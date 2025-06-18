;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module multiplayer
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
	.globl _scroll_sprite
	.globl _move_sprite
	.globl _set_sprite_tile
	.globl _set_sprite_data
	.globl _vsync
	.globl _joypad_ex
	.globl _joypad_init
	.globl _joypads
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
	.ds 1
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
_joypads::
	.ds 5
_main_joy_40000_95:
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS    (ABS)
;--------------------------------------------------------
; initialized external ram data
;--------------------------------------------------------
	.area _DATA
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
;i                         Allocated to registers 
;i                         Allocated to registers 
;i                         Allocated to registers 
;joy                       Allocated with name '_main_joy_40000_95'
;i                         Allocated to registers 
;sloc0                     Allocated with name '_main_sloc0_1_0'
;------------------------------------------------------------
;	src/multiplayer.c: 14: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/multiplayer.c: 15: set_sprite_data(0, 4, sprite_data);
	lda	#>_sprite_data
	sta	(_set_sprite_data_PARM_3 + 1)
	lda	#_sprite_data
	sta	_set_sprite_data_PARM_3
	lda	#0x00
	ldx	#0x04
	jsr	_set_sprite_data
;	src/multiplayer.c: 16: for (uint8_t i = 0; i < 4; i++) {
	ldx	#0x00
	stx	*_main_sloc0_1_0
00119$:
	lda	*_main_sloc0_1_0
	cmp	#0x04
	bcs	00101$
;	src/multiplayer.c: 17: set_sprite_tile(i, i);
	lda	*_main_sloc0_1_0
	ldx	*_main_sloc0_1_0
	jsr	_set_sprite_tile
;	src/multiplayer.c: 19: DEVICE_SPRITE_PX_OFFSET_X + (i << 3) + ((DEVICE_SCREEN_PX_WIDTH - (4 * 8)) / 2), 
	lda	*_main_sloc0_1_0
	asl	a
	asl	a
	asl	a
	clc
	adc	#0x70
;	src/multiplayer.c: 20: DEVICE_SPRITE_PX_OFFSET_Y + ((DEVICE_SCREEN_PX_HEIGHT - 8) / 2));
	ldx	#0x73
	stx	_move_sprite_PARM_3
	tax
	lda	*_main_sloc0_1_0
	jsr	_move_sprite
;	src/multiplayer.c: 16: for (uint8_t i = 0; i < 4; i++) {
	inc	*_main_sloc0_1_0
	jmp	00119$
00101$:
;	src/multiplayer.c: 22: SHOW_SPRITES;
	lda	_shadow_PPUMASK
	ora	#0x10
	sta	_shadow_PPUMASK
;	src/multiplayer.c: 26: for (uint8_t i = 4; i != 0; i--) vsync();
	lda	#0x04
00122$:
	cmp	#0x00
	beq	00102$
	pha
	jsr	_vsync
	pla
	sec
	sbc	#0x01
	jmp	00122$
00102$:
;	src/multiplayer.c: 29: joypad_init(4, &joypads);
	lda	#>_joypads
	sta	(_joypad_init_PARM_2 + 1)
	lda	#_joypads
	sta	_joypad_init_PARM_2
	lda	#0x04
	jsr	_joypad_init
;	src/multiplayer.c: 31: while(1) {
00116$:
;	src/multiplayer.c: 33: joypad_ex(&joypads);
	ldx	#>_joypads
	lda	#_joypads
	jsr	_joypad_ex
;	src/multiplayer.c: 35: for (uint8_t i = 0; i < joypads.npads; i++) {
	ldx	#0x00
	stx	*_main_sloc0_1_0
00125$:
	lda	_joypads
	cmp	*_main_sloc0_1_0
	beq	00111$
	bcc	00111$
;	src/multiplayer.c: 36: uint8_t joy = joypads.joypads[i];
	ldx	#0x00
	lda	*_main_sloc0_1_0
	tay
	lda	((_joypads + 0x0001)+0+0x0000),y
	sta	_main_joy_40000_95
;	src/multiplayer.c: 37: if (joy & J_LEFT) scroll_sprite(i, -1, 0);
	lda	#0x02
	and	_main_joy_40000_95
	beq	00104$
	stx	_scroll_sprite_PARM_3
	lda	*_main_sloc0_1_0
	dex
	jsr	_scroll_sprite
00104$:
;	src/multiplayer.c: 38: if (joy & J_RIGHT) scroll_sprite(i, 1, 0);
	lda	#0x01
	and	_main_joy_40000_95
	beq	00106$
	ldx	#0x00
	stx	_scroll_sprite_PARM_3
	lda	*_main_sloc0_1_0
	inx
	jsr	_scroll_sprite
00106$:
;	src/multiplayer.c: 39: if (joy & J_UP) scroll_sprite(i, 0, -1);
	lda	#0x08
	and	_main_joy_40000_95
	beq	00108$
	ldx	#0xff
	stx	_scroll_sprite_PARM_3
	lda	*_main_sloc0_1_0
	inx
	jsr	_scroll_sprite
00108$:
;	src/multiplayer.c: 40: if (joy & J_DOWN) scroll_sprite(i, 0, 1);
	lda	#0x04
	and	_main_joy_40000_95
	beq	00126$
	ldx	#0x01
	stx	_scroll_sprite_PARM_3
	lda	*_main_sloc0_1_0
	dex
	jsr	_scroll_sprite
00126$:
;	src/multiplayer.c: 35: for (uint8_t i = 0; i < joypads.npads; i++) {
	inc	*_main_sloc0_1_0
	jmp	00125$
00111$:
;	src/multiplayer.c: 43: if (joypads.joy0 & J_START) {
	lda	(_joypads + 0x0001)
	and	#0x10
	beq	00114$
;	src/multiplayer.c: 44: for (uint8_t i = 0; i < 4; i++) move_sprite(i, (i << 3) + 64, 64);
	ldy	#0x00
00128$:
	cpy	#0x04
	bcs	00114$
	tya
	asl	a
	asl	a
	asl	a
	clc
	adc	#0x40
	ldx	#0x40
	stx	_move_sprite_PARM_3
	sta	*(REGTEMP+0)
	tya
	pha
	lda	*(REGTEMP+0)
	tax
	tya
	jsr	_move_sprite
	sta	*(REGTEMP+0)
	pla
	tay
	lda	*(REGTEMP+0)
	iny
	jmp	00128$
00114$:
;	src/multiplayer.c: 46: vsync();
	jsr	_vsync
	jmp	00116$
;	src/multiplayer.c: 48: }
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
	.area _CABS    (ABS)
