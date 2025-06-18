;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module phys
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _set_sprite_data
	.globl _vsync
	.globl _joypad
	.globl _joy
	.globl _old_joy
	.globl _SpdY
	.globl _SpdX
	.globl _PosY
	.globl _PosX
	.globl _sprite_data
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_PosX::
	.ds 2
_PosY::
	.ds 2
_SpdX::
	.ds 2
_SpdY::
	.ds 2
_old_joy::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_joy::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/phys.c:45: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	dec	sp
;src/phys.c:48: BGP_REG = OBP0_REG = OBP1_REG = DMG_PALETTE(DMG_WHITE, DMG_LITE_GRAY, DMG_DARK_GRAY, DMG_BLACK);
	ld	a, #0xe4
	ldh	(_OBP1_REG + 0), a
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;src/phys.c:51: set_sprite_data(0, 4, sprite_data);
	ld	de, #_sprite_data
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_sprite_data
	add	sp, #4
;../../../include/gb/gb.h:1875: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;src/phys.c:57: SHOW_BKG; SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x40
	ldh	(_LCDC_REG + 0), a
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/phys.c:59: PosX = PosY = PIXELS_TO_SUBPIXELS(64);
	ld	hl, #_PosY
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x04
	ld	hl, #_PosX
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x04
;src/phys.c:60: SpdX = SpdY = PIXELS_TO_SUBPIXELS(0);
	xor	a, a
	ld	hl, #_SpdY
	ld	(hl+), a
	ld	(hl), a
	xor	a, a
	ld	hl, #_SpdX
	ld	(hl+), a
	ld	(hl), a
;src/phys.c:62: while(TRUE) {
00132$:
;src/phys.c:64: INPUT_PROCESS;
	ld	a, (#_joy)
	ld	(#_old_joy),a
	call	_joypad
	ld	hl, #_joy
	ld	(hl), a
;src/phys.c:67: if (INPUT_KEY(J_UP)) {
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
;src/phys.c:68: SpdY -= Y_ACCELERATION_IN_SUBPIXELS;
	ld	hl, #_SpdY
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;src/phys.c:67: if (INPUT_KEY(J_UP)) {
	push	hl
	ldhl	sp,	#2
	bit	2, (hl)
	pop	hl
	jr	Z, 00108$
;src/phys.c:68: SpdY -= Y_ACCELERATION_IN_SUBPIXELS;
	dec	de
	dec	de
	ld	hl, #_SpdY
	ld	a, e
	ld	(hl+), a
;src/phys.c:69: if (SpdY < -MAX_Y_SPEED_IN_SUBPIXELS) SpdY = -MAX_Y_SPEED_IN_SUBPIXELS;
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0xc0
	ld	a, (hl)
	sbc	a, #0xff
	ld	d, (hl)
	ld	a, #0xff
	bit	7,a
	jr	Z, 00237$
	bit	7, d
	jr	NZ, 00238$
	cp	a, a
	jr	00238$
00237$:
	bit	7, d
	jr	Z, 00238$
	scf
00238$:
	jr	NC, 00109$
	ld	hl, #_SpdY
	ld	a, #0xc0
	ld	(hl+), a
	ld	(hl), #0xff
	jr	00109$
00108$:
;src/phys.c:70: } else if (INPUT_KEY(J_DOWN)) {
	push	hl
	ldhl	sp,	#2
	bit	3, (hl)
	pop	hl
	jr	Z, 00109$
;src/phys.c:71: SpdY += Y_ACCELERATION_IN_SUBPIXELS;
	inc	de
	inc	de
	ld	hl, #_SpdY
	ld	a, e
	ld	(hl+), a
;src/phys.c:72: if (SpdY > MAX_Y_SPEED_IN_SUBPIXELS) SpdY = MAX_Y_SPEED_IN_SUBPIXELS;
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	e, b
	ld	d, #0x00
	ld	a, #0x40
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00240$
	bit	7, d
	jr	NZ, 00241$
	cp	a, a
	jr	00241$
00240$:
	bit	7, d
	jr	Z, 00241$
	scf
00241$:
	jr	NC, 00109$
	ld	hl, #_SpdY
	ld	a, #0x40
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00109$:
;src/phys.c:75: SpdX -= X_ACCELERATION_IN_SUBPIXELS;
	ld	hl, #_SpdX
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/phys.c:74: if (INPUT_KEY(J_LEFT)) {
	push	hl
	ldhl	sp,	#2
	bit	1, (hl)
	pop	hl
	jr	Z, 00117$
;src/phys.c:75: SpdX -= X_ACCELERATION_IN_SUBPIXELS;
	dec	bc
	dec	bc
	ld	hl, #_SpdX
	ld	a, c
	ld	(hl+), a
;src/phys.c:76: if (SpdX < -MAX_X_SPEED_IN_SUBPIXELS) SpdX = -MAX_X_SPEED_IN_SUBPIXELS;
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0xc0
	ld	a, (hl)
	sbc	a, #0xff
	ld	d, (hl)
	ld	a, #0xff
	bit	7,a
	jr	Z, 00243$
	bit	7, d
	jr	NZ, 00244$
	cp	a, a
	jr	00244$
00243$:
	bit	7, d
	jr	Z, 00244$
	scf
00244$:
	jr	NC, 00118$
	ld	hl, #_SpdX
	ld	a, #0xc0
	ld	(hl+), a
	ld	(hl), #0xff
	jr	00118$
00117$:
;src/phys.c:77: } else if (INPUT_KEY(J_RIGHT)) {
	push	hl
	ldhl	sp,	#2
	bit	0, (hl)
	pop	hl
	jr	Z, 00118$
;src/phys.c:78: SpdX += X_ACCELERATION_IN_SUBPIXELS;
	inc	bc
	inc	bc
	ld	hl, #_SpdX
	ld	a, c
	ld	(hl+), a
;src/phys.c:79: if (SpdX > MAX_X_SPEED_IN_SUBPIXELS) SpdX = MAX_X_SPEED_IN_SUBPIXELS;
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	e, b
	ld	d, #0x00
	ld	a, #0x40
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00246$
	bit	7, d
	jr	NZ, 00247$
	cp	a, a
	jr	00247$
00246$:
	bit	7, d
	jr	Z, 00247$
	scf
00247$:
	jr	NC, 00118$
	ld	hl, #_SpdX
	ld	a, #0x40
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00118$:
;src/phys.c:82: if (INPUT_KEYPRESS(J_A)) {
	ld	a, (#_old_joy)
	ld	c, #0x00
	cpl
	ld	e, a
	ld	a, c
	cpl
	ld	a, (#_joy)
	and	a, e
	bit	4,a
	jr	Z, 00120$
;src/phys.c:83: SpdY = -JUMP_ACCELERATION_IN_SUBPIXELS;
	ld	hl, #_SpdY
	ld	a, #0xe0
	ld	(hl+), a
	ld	(hl), #0xff
00120$:
;src/phys.c:87: PosX += SpdX, PosY += SpdY;
	ld	a, (#_PosX)
	ld	hl, #_SpdX
	add	a, (hl)
	ld	hl, #_PosX
	ld	(hl+), a
	ld	a, (hl)
	ld	hl, #_SpdX + 1
	adc	a, (hl)
	ld	(#_PosX + 1),a
	ld	a, (#_PosY)
	ld	hl, #_SpdY
	add	a, (hl)
	ld	hl, #_PosY
	ld	(hl+), a
	ld	a, (hl)
	ld	hl, #_SpdY + 1
	adc	a, (hl)
	ld	hl, #_PosY + 1
;src/phys.c:90: move_sprite(0, SUBPIXELS_TO_PIXELS(PosX), SUBPIXELS_TO_PIXELS(PosY));
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ld	hl, #_PosX
	ld	a, (hl+)
	ld	b, a
	ld	e, (hl)
	sra	e
	rr	b
	sra	e
	rr	b
	sra	e
	rr	b
	sra	e
	rr	b
;../../../include/gb/gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
;../../../include/gb/gb.h:1962: itm->y=y, itm->x=x;
	ld	hl, #_shadow_OAM
	ld	(hl), c
	ld	hl, #(_shadow_OAM + 1)
	ld	(hl), b
;src/phys.c:93: if (SpdY < 0) SpdY++; else if (SpdY) SpdY--;
	ld	hl, #_SpdY
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00124$
	dec	hl
	inc	(hl)
	jr	NZ, 00125$
	inc	hl
	inc	(hl)
	jr	00125$
00124$:
	ld	hl, #_SpdY + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00125$
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
00125$:
;src/phys.c:94: if (SpdX < 0) SpdX++; else if (SpdX) SpdX--;
	ld	hl, #_SpdX
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00129$
	dec	hl
	inc	(hl)
	jr	NZ, 00130$
	inc	hl
	inc	(hl)
	jr	00130$
00129$:
	ld	hl, #_SpdX + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00130$
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
00130$:
;src/phys.c:97: vsync();
	call	_vsync
	jp	00132$
;src/phys.c:99: }
	inc	sp
	ret
_sprite_data:
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0xa9	; 169
	.db #0xff	; 255
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0xb9	; 185
	.db #0xff	; 255
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0x91	; 145
	.db #0xff	; 255
	.db #0xb9	; 185
	.db #0xff	; 255
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0x5a	; 90	'Z'
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0xa9	; 169
	.db #0xff	; 255
	.db #0xa9	; 169
	.db #0xff	; 255
	.db #0xb9	; 185
	.db #0xff	; 255
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.area _CODE
	.area _INITIALIZER
__xinit__joy:
	.db #0x00	; 0
	.area _CABS (ABS)
