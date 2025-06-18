;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module phys
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _set_tile_2bpp_data
	.globl _joypad
	.globl _vsync
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
_GG_STATE	=	0x0000
_GG_EXT_7BIT	=	0x0001
_GG_EXT_CTL	=	0x0002
_GG_SIO_SEND	=	0x0003
_GG_SIO_RECV	=	0x0004
_GG_SIO_CTL	=	0x0005
_GG_SOUND_PAN	=	0x0006
_MEMORY_CTL	=	0x003e
_JOY_CTL	=	0x003f
_VCOUNTER	=	0x007e
_PSG	=	0x007f
_HCOUNTER	=	0x007f
_VDP_DATA	=	0x00be
_VDP_CMD	=	0x00bf
_VDP_STATUS	=	0x00bf
_JOY_PORT1	=	0x00dc
_JOY_PORT2	=	0x00dd
_FMADDRESS	=	0x00f0
_FMDATA	=	0x00f1
_AUDIOCTRL	=	0x00f2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_RAM_CONTROL	=	0xfffc
_GLASSES_3D	=	0xfff8
_MAP_FRAME0	=	0xfffd
_MAP_FRAME1	=	0xfffe
_MAP_FRAME2	=	0xffff
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
;src/phys.c:51: set_sprite_data(0, 4, sprite_data);
;../../../include/sms/sms.h:636: set_tile_2bpp_data((uint8_t)(start) + 0x100u, ntiles, src, _current_2bpp_palette);
	ld	hl, (__current_2bpp_palette)
	push	hl
	ld	hl, #_sprite_data
	push	hl
	ld	hl, #0x0004
	push	hl
	ld	hl, #0x0100
	push	hl
	call	_set_tile_2bpp_data
;../../../include/sms/sms.h:807: shadow_OAM[0x41+(nb << 1)] = tile;
	ld	hl, #_shadow_OAM+65
	ld	(hl), #0x00
;src/phys.c:57: SHOW_BKG; SHOW_SPRITES;
	ld	hl, #__sprites_OFF
	ld	(hl), #0x00
;src/phys.c:59: PosX = PosY = PIXELS_TO_SUBPIXELS(64);
	ld	hl, #0x0400
	ld	(_PosY), hl
	ld	(_PosX), hl
;src/phys.c:60: SpdX = SpdY = PIXELS_TO_SUBPIXELS(0);
	ld	h, l
	ld	(_SpdY), hl
	ld	(_SpdX), hl
;src/phys.c:62: while(TRUE) {
00132$:
;src/phys.c:64: INPUT_PROCESS;
	ld	a, (_joy+0)
	ld	(_old_joy+0), a
	call	_joypad
	ld	a, l
	ld	(_joy+0), a
	ld	a, (_joy+0)
	ld	c, a
;src/phys.c:68: SpdY -= Y_ACCELERATION_IN_SUBPIXELS;
	ld	hl, (_SpdY)
;src/phys.c:67: if (INPUT_KEY(J_UP)) {
	bit	0, c
	jr	Z, 00108$
;src/phys.c:68: SpdY -= Y_ACCELERATION_IN_SUBPIXELS;
	dec	hl
	dec	hl
	ld	(_SpdY), hl
;src/phys.c:69: if (SpdY < -MAX_Y_SPEED_IN_SUBPIXELS) SpdY = -MAX_Y_SPEED_IN_SUBPIXELS;
	ld	a, (_SpdY+0)
	sub	a, #0xc0
	ld	a, (_SpdY+1)
	rla
	ccf
	rra
	sbc	a, #0x7f
	jr	NC, 00109$
	ld	hl, #0xffc0
	ld	(_SpdY), hl
	jr	00109$
00108$:
;src/phys.c:70: } else if (INPUT_KEY(J_DOWN)) {
	bit	1, c
	jr	Z, 00109$
;src/phys.c:71: SpdY += Y_ACCELERATION_IN_SUBPIXELS;
	inc	hl
	inc	hl
	ld	(_SpdY), hl
;src/phys.c:72: if (SpdY > MAX_Y_SPEED_IN_SUBPIXELS) SpdY = MAX_Y_SPEED_IN_SUBPIXELS;
	ld	hl, (_SpdY)
	ld	a, #0x40
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	jp	PO, 00248$
	xor	a, #0x80
00248$:
	jp	P, 00109$
	ld	hl, #0x0040
	ld	(_SpdY), hl
00109$:
;src/phys.c:75: SpdX -= X_ACCELERATION_IN_SUBPIXELS;
	ld	hl, (_SpdX)
;src/phys.c:74: if (INPUT_KEY(J_LEFT)) {
	bit	2, c
	jr	Z, 00117$
;src/phys.c:75: SpdX -= X_ACCELERATION_IN_SUBPIXELS;
	dec	hl
	dec	hl
	ld	(_SpdX), hl
;src/phys.c:76: if (SpdX < -MAX_X_SPEED_IN_SUBPIXELS) SpdX = -MAX_X_SPEED_IN_SUBPIXELS;
	ld	a, (_SpdX+0)
	sub	a, #0xc0
	ld	a, (_SpdX+1)
	rla
	ccf
	rra
	sbc	a, #0x7f
	jr	NC, 00118$
	ld	hl, #0xffc0
	ld	(_SpdX), hl
	jr	00118$
00117$:
;src/phys.c:77: } else if (INPUT_KEY(J_RIGHT)) {
	bit	3, c
	jr	Z, 00118$
;src/phys.c:78: SpdX += X_ACCELERATION_IN_SUBPIXELS;
	inc	hl
	inc	hl
	ld	(_SpdX), hl
;src/phys.c:79: if (SpdX > MAX_X_SPEED_IN_SUBPIXELS) SpdX = MAX_X_SPEED_IN_SUBPIXELS;
	ld	hl, (_SpdX)
	ld	a, #0x40
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	jp	PO, 00251$
	xor	a, #0x80
00251$:
	jp	P, 00118$
	ld	hl, #0x0040
	ld	(_SpdX), hl
00118$:
;src/phys.c:82: if (INPUT_KEYPRESS(J_A)) {
	ld	a, (_old_joy+0)
	ld	b, #0x00
	cpl
	ld	c, a
	ld	a, b
	cpl
	ld	a, (_joy+0)
	ld	e, #0x00
	and	a, c
	bit	5,a
	jr	Z, 00120$
;src/phys.c:83: SpdY = -JUMP_ACCELERATION_IN_SUBPIXELS;
	ld	hl, #0xffe0
	ld	(_SpdY), hl
00120$:
;src/phys.c:87: PosX += SpdX, PosY += SpdY;
	ld	hl, #_SpdX
	push	de
	ld	de, #_PosX
	ld	a, (de)
	add	a, (hl)
	inc	hl
	ld	(de), a
	inc	de
	ld	a, (de)
	adc	a, (hl)
	ld	(de), a
	pop	de
	ld	hl, #_SpdY
	push	de
	ld	de, #_PosY
	ld	a, (de)
	add	a, (hl)
	inc	hl
	ld	(de), a
	inc	de
	ld	a, (de)
	adc	a, (hl)
	ld	(de), a
	pop	de
;src/phys.c:90: move_sprite(0, SUBPIXELS_TO_PIXELS(PosX), SUBPIXELS_TO_PIXELS(PosY));
	ld	hl, (_PosY)
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	ld	b, l
	ld	hl, (_PosX)
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	ld	c, l
;../../../include/sms/sms.h:848: shadow_OAM[nb] = (y < VDP_SAT_TERM) ? y : 0xC0;
	ld	a, b
	sub	a, #0xd0
	jr	C, 00140$
	ld	b, #0xc0
00140$:
	ld	hl, #_shadow_OAM
	ld	(hl), b
;../../../include/sms/sms.h:849: shadow_OAM[0x40+(nb << 1)] = x;
	ld	hl, #(_shadow_OAM + 64)
	ld	(hl), c
;src/phys.c:93: if (SpdY < 0) SpdY++; else if (SpdY) SpdY--;
	ld	hl, (_SpdY)
	bit	7, h
	jr	Z, 00124$
	ld	hl, (_SpdY)
	inc	hl
	ld	(_SpdY), hl
	jr	00125$
00124$:
	ld	a, (_SpdY+1)
	ld	hl, #_SpdY
	or	a, (hl)
	jr	Z, 00125$
	ld	hl, (_SpdY)
	dec	hl
	ld	(_SpdY), hl
00125$:
;src/phys.c:94: if (SpdX < 0) SpdX++; else if (SpdX) SpdX--;
	ld	hl, (_SpdX)
	bit	7, h
	jr	Z, 00129$
	ld	hl, (_SpdX)
	inc	hl
	ld	(_SpdX), hl
	jr	00130$
00129$:
	ld	a, (_SpdX+1)
	ld	iy, #_SpdX
	or	a, 0 (iy)
	jr	Z, 00130$
	ld	hl, (_SpdX)
	dec	hl
	ld	(_SpdX), hl
00130$:
;src/phys.c:97: vsync();
	call	_vsync
;src/phys.c:99: }
	jp	00132$
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
