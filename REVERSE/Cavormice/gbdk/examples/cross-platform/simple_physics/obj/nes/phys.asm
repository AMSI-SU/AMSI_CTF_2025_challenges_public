;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module phys
	.optsdcc -mmos6502
	
;; Ordering of segments for the linker.
	.area _ZP      (PAG)
	.area _OSEG    (PAG, OVR)
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _CODE
	.area _XINIT
	.area _DATA
	.area _DATA
	.area _BSS
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sprite_data
	.globl _main
	.globl _move_sprite
	.globl _set_sprite_tile
	.globl _set_sprite_data
	.globl _vsync
	.globl _joypad
	.globl _joy
	.globl _old_joy
	.globl _SpdY
	.globl _SpdX
	.globl _PosY
	.globl _PosX
	.globl _OAMDMA
	.globl _PPUDATA
	.globl _PPUADDR
	.globl _PPUSCROLL
	.globl _OAMDATA
	.globl _OAMADDR
	.globl _PPUSTATUS
	.globl _PPUMASK
	.globl _PPUCTRL
;--------------------------------------------------------
; ZP ram data
;--------------------------------------------------------
	.area _ZP      (PAG)
;--------------------------------------------------------
; overlayable items in ram
;--------------------------------------------------------
	.area	OSEG    (PAG, OVR)
_main_sloc0_1_0:
	.ds 2
;--------------------------------------------------------
; uninitialized external ram data
;--------------------------------------------------------
	.area _BSS
_PPUCTRL	=	0x2000
_PPUMASK	=	0x2001
_PPUSTATUS	=	0x2002
_OAMADDR	=	0x2003
_OAMDATA	=	0x2004
_PPUSCROLL	=	0x2005
_PPUADDR	=	0x2006
_PPUDATA	=	0x2007
_OAMDMA	=	0x4014
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
; absolute external ram data
;--------------------------------------------------------
	.area _DABS    (ABS)
;--------------------------------------------------------
; initialized external ram data
;--------------------------------------------------------
	.area _DATA
_joy::
	.ds 1
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
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;sloc0                     Allocated with name '_main_sloc0_1_0'
;------------------------------------------------------------
;	src/phys.c: 45: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/phys.c: 51: set_sprite_data(0, 4, sprite_data);
	lda	#>_sprite_data
	sta	(_set_sprite_data_PARM_3 + 1)
	lda	#_sprite_data
	sta	_set_sprite_data_PARM_3
	lda	#0x00
	ldx	#0x04
	jsr	_set_sprite_data
;	src/phys.c: 54: set_sprite_tile(0, 0);
	lda	#0x00
	tax
	jsr	_set_sprite_tile
;	src/phys.c: 57: SHOW_BKG; SHOW_SPRITES;
	lda	_shadow_PPUMASK
	ora	#0x08
	sta	_shadow_PPUMASK
	lda	_shadow_PPUMASK
	ora	#0x10
	sta	_shadow_PPUMASK
;	src/phys.c: 59: PosX = PosY = PIXELS_TO_SUBPIXELS(64);
	ldx	#0x00
	stx	_PosY
	ldx	#0x04
	stx	(_PosY + 1)
	ldx	#0x00
	stx	_PosX
	ldx	#0x04
	stx	(_PosX + 1)
;	src/phys.c: 60: SpdX = SpdY = PIXELS_TO_SUBPIXELS(0);
	ldx	#0x00
	stx	_SpdY
	stx	(_SpdY + 1)
	stx	_SpdX
	stx	(_SpdX + 1)
;	src/phys.c: 62: while(TRUE) {
00132$:
;	src/phys.c: 64: INPUT_PROCESS;
	lda	_joy
	sta	_old_joy
	jsr	_joypad
	sta	_joy
;	src/phys.c: 67: if (INPUT_KEY(J_UP)) {
	ldx	#0x08
	stx	*(REGTEMP+0)
	bit	*(REGTEMP+0)
	beq	00108$
;	src/phys.c: 68: SpdY -= Y_ACCELERATION_IN_SUBPIXELS;
	ldx	(_SpdY + 1)
	lda	_SpdY
	sec
	sbc	#0x02
	bcs	00221$
	dex
00221$:
	sta	_SpdY
	stx	(_SpdY + 1)
;	src/phys.c: 69: if (SpdY < -MAX_Y_SPEED_IN_SUBPIXELS) SpdY = -MAX_Y_SPEED_IN_SUBPIXELS;
	lda	_SpdY
	sec
	sbc	#0xc0
	lda	(_SpdY + 1)
	sbc	#0xff
	bvc	00223$
	bpl	00222$
	bmi	00109$
00223$:
	bpl	00109$
00222$:
	ldx	#0xc0
	stx	_SpdY
	ldx	#0xff
	stx	(_SpdY + 1)
	jmp	00109$
00108$:
;	src/phys.c: 70: } else if (INPUT_KEY(J_DOWN)) {
	and	#0x04
	beq	00109$
;	src/phys.c: 71: SpdY += Y_ACCELERATION_IN_SUBPIXELS;
	ldx	(_SpdY + 1)
	lda	_SpdY
	clc
	adc	#0x02
	bcc	00226$
	inx
00226$:
;	src/phys.c: 72: if (SpdY > MAX_Y_SPEED_IN_SUBPIXELS) SpdY = MAX_Y_SPEED_IN_SUBPIXELS;
	sta	_SpdY
	stx	(_SpdY + 1)
	sta	*(REGTEMP+0)
	lda	#0x40
	sec
	sbc	*(REGTEMP+0)
	lda	#0x00
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	bvc	00228$
	bpl	00227$
	bmi	00109$
00228$:
	bpl	00109$
00227$:
	ldx	#0x40
	stx	_SpdY
	ldx	#0x00
	stx	(_SpdY + 1)
00109$:
;	src/phys.c: 74: if (INPUT_KEY(J_LEFT)) {
	lda	_joy
	ldx	#0x02
	stx	*(REGTEMP+0)
	bit	*(REGTEMP+0)
	beq	00117$
;	src/phys.c: 75: SpdX -= X_ACCELERATION_IN_SUBPIXELS;
	ldx	(_SpdX + 1)
	lda	_SpdX
	sec
	sbc	#0x02
	bcs	00231$
	dex
00231$:
	sta	_SpdX
	stx	(_SpdX + 1)
;	src/phys.c: 76: if (SpdX < -MAX_X_SPEED_IN_SUBPIXELS) SpdX = -MAX_X_SPEED_IN_SUBPIXELS;
	lda	_SpdX
	sec
	sbc	#0xc0
	lda	(_SpdX + 1)
	sbc	#0xff
	bvc	00233$
	bpl	00232$
	bmi	00118$
00233$:
	bpl	00118$
00232$:
	ldx	#0xc0
	stx	_SpdX
	ldx	#0xff
	stx	(_SpdX + 1)
	jmp	00118$
00117$:
;	src/phys.c: 77: } else if (INPUT_KEY(J_RIGHT)) {
	and	#0x01
	beq	00118$
;	src/phys.c: 78: SpdX += X_ACCELERATION_IN_SUBPIXELS;
	ldx	(_SpdX + 1)
	lda	_SpdX
	clc
	adc	#0x02
	bcc	00236$
	inx
00236$:
;	src/phys.c: 79: if (SpdX > MAX_X_SPEED_IN_SUBPIXELS) SpdX = MAX_X_SPEED_IN_SUBPIXELS;
	sta	_SpdX
	stx	(_SpdX + 1)
	sta	*(REGTEMP+0)
	lda	#0x40
	sec
	sbc	*(REGTEMP+0)
	lda	#0x00
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	bvc	00238$
	bpl	00237$
	bmi	00118$
00238$:
	bpl	00118$
00237$:
	ldx	#0x40
	stx	_SpdX
	ldx	#0x00
	stx	(_SpdX + 1)
00118$:
;	src/phys.c: 82: if (INPUT_KEYPRESS(J_A)) {
	ldx	#0x00
	lda	_old_joy
	eor	#0xff
	sta	*_main_sloc0_1_0
	txa
	eor	#0xff
	sta	*(_main_sloc0_1_0 + 1)
	lda	_joy
	and	*_main_sloc0_1_0
	sta	*_main_sloc0_1_0
	txa
	and	*(_main_sloc0_1_0 + 1)
	sta	*(_main_sloc0_1_0 + 1)
	bit	*_main_sloc0_1_0
	bpl	00120$
;	src/phys.c: 83: SpdY = -JUMP_ACCELERATION_IN_SUBPIXELS;
	ldx	#0xe0
	stx	_SpdY
	ldx	#0xff
	stx	(_SpdY + 1)
00120$:
;	src/phys.c: 87: PosX += SpdX, PosY += SpdY;
	lda	_PosX
	clc
	adc	_SpdX
	sta	_PosX
	lda	(_PosX + 1)
	adc	(_SpdX + 1)
	sta	(_PosX + 1)
	lda	_PosY
	clc
	adc	_SpdY
	sta	_PosY
	lda	(_PosY + 1)
	adc	(_SpdY + 1)
	sta	(_PosY + 1)
;	src/phys.c: 90: move_sprite(0, SUBPIXELS_TO_PIXELS(PosX), SUBPIXELS_TO_PIXELS(PosY));
	ldx	(_PosX + 1)
	lda	_PosX
	stx	*(REGTEMP+0)
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	tay 
	ldx	(_PosY + 1)
	lda	_PosY
	stx	*(REGTEMP+0)
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	sta	_move_sprite_PARM_3
	lda	#0x00
	sty	*(REGTEMP+0)
	ldx	*(REGTEMP+0)
	jsr	_move_sprite
;	src/phys.c: 93: if (SpdY < 0) SpdY++; else if (SpdY) SpdY--;
	lda	(_SpdY + 1)
	sta	*(_main_sloc0_1_0 + 1)
	lda	_SpdY
	sta	*_main_sloc0_1_0
	bit	*(_main_sloc0_1_0 + 1)
	bpl	00124$
	inc	_SpdY
	bne	00125$
	inc	(_SpdY + 1)
	jmp	00125$
00124$:
	lda	(_SpdY + 1)
	ora	_SpdY
	beq	00125$
	sec
	lda	_SpdY
	sbc	#0x01
	sta	_SpdY
	bcs	00245$
	dec	(_SpdY + 1)
00245$:
00125$:
;	src/phys.c: 94: if (SpdX < 0) SpdX++; else if (SpdX) SpdX--;
	lda	(_SpdX + 1)
	sta	*(_main_sloc0_1_0 + 1)
	lda	_SpdX
	sta	*_main_sloc0_1_0
	bit	*(_main_sloc0_1_0 + 1)
	bpl	00129$
	inc	_SpdX
	bne	00130$
	inc	(_SpdX + 1)
	jmp	00130$
00129$:
	lda	(_SpdX + 1)
	ora	_SpdX
	beq	00130$
	sec
	lda	_SpdX
	sbc	#0x01
	sta	_SpdX
	bcs	00250$
	dec	(_SpdX + 1)
00250$:
00130$:
;	src/phys.c: 97: vsync();
	jsr	_vsync
	jmp	00132$
;	src/phys.c: 99: }
	rts
	.area _CODE
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
	.area _XINIT
__xinit__joy:
	.db #0x00	; 0
	.area _CABS    (ABS)
