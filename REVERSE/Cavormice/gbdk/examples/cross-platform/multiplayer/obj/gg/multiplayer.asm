;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module multiplayer
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _set_tile_2bpp_data
	.globl _joypad_ex
	.globl _joypad_init
	.globl _vsync
	.globl _joypads
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
_joypads::
	.ds 5
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
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
;src/multiplayer.c:14: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-7
	add	hl, sp
	ld	sp, hl
;src/multiplayer.c:15: set_sprite_data(0, 4, sprite_data);
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
;src/multiplayer.c:16: for (uint8_t i = 0; i < 4; i++) {
	ld	c, #0x00
00127$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00101$
;../../../include/sms/sms.h:807: shadow_OAM[0x41+(nb << 1)] = tile;
	ld	e, c
	ld	d, #0x00
	ex	de, hl
	add	hl, hl
	ex	de, hl
	ld	hl, #0x0041
	add	hl, de
	ld	a, l
	add	a, #<(_shadow_OAM)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	adc	a, #>(_shadow_OAM)
	ld	h, a
	ld	(hl), c
;src/multiplayer.c:19: DEVICE_SPRITE_PX_OFFSET_X + (i << 3) + ((DEVICE_SCREEN_PX_WIDTH - (4 * 8)) / 2), 
	ld	a, c
	add	a, a
	add	a, a
	add	a, a
	add	a, #0x70
	ld	b, a
;../../../include/sms/sms.h:848: shadow_OAM[nb] = (y < VDP_SAT_TERM) ? y : 0xC0;
	ld	a, c
	add	a, #<(_shadow_OAM)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #0x00
	adc	a, #>(_shadow_OAM)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	(hl), #0x5b
;../../../include/sms/sms.h:849: shadow_OAM[0x40+(nb << 1)] = x;
	ld	hl, #0x0040
	add	hl, de
	ld	de, #_shadow_OAM
	add	hl, de
	ld	(hl), b
;src/multiplayer.c:16: for (uint8_t i = 0; i < 4; i++) {
	inc	c
	jr	00127$
00101$:
;src/multiplayer.c:22: SHOW_SPRITES;
	ld	hl, #__sprites_OFF
	ld	(hl), #0x00
;src/multiplayer.c:26: for (uint8_t i = 4; i != 0; i--) vsync();
	ld	c, #0x04
00130$:
	ld	a, c
	or	a, a
	jr	Z, 00102$
	call	_vsync
	dec	c
	jr	00130$
00102$:
;src/multiplayer.c:29: joypad_init(4, &joypads);
	ld	hl, #_joypads
	push	hl
	ld	a, #0x04
	push	af
	inc	sp
	call	_joypad_init
;src/multiplayer.c:31: while(1) {
00116$:
;src/multiplayer.c:33: joypad_ex(&joypads);
	ld	hl, #_joypads
	call	_joypad_ex
;src/multiplayer.c:35: for (uint8_t i = 0; i < joypads.npads; i++) {
	ld	-1 (ix), #0x00
00133$:
	ld	hl, #_joypads
	ld	a,-1 (ix)
	sub	a,(hl)
	jp	NC, 00111$
;src/multiplayer.c:36: uint8_t joy = joypads.joypads[i];
	ld	bc, #_joypads + 1
	ld	l, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	a, (hl)
	ld	-6 (ix), a
;src/multiplayer.c:37: if (joy & J_LEFT) scroll_sprite(i, -1, 0);
	bit	2, -6 (ix)
	jr	Z, 00104$
	ld	c, -1 (ix)
;../../../include/sms/sms.h:864: uint8_t new_y = shadow_OAM[nb] + y;
	ld	de, #_shadow_OAM+0
	ld	l, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	b, (hl)
;../../../include/sms/sms.h:865: shadow_OAM[nb] = (new_y < VDP_SAT_TERM) ? new_y : 0xC0;
	ld	de, #_shadow_OAM+0
	ld	l, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	a, b
	sub	a, #0xd0
	jr	C, 00143$
	ld	b, #0xc0
00143$:
	ld	(hl), b
;../../../include/sms/sms.h:866: shadow_OAM[0x40+(nb << 1)] += x;
	ld	b, #0x00
	ld	a, c
	add	a, a
	rl	b
	add	a, #0x40
	ld	c, a
	jr	NC, 00286$
	inc	b
00286$:
	ld	hl, #_shadow_OAM
	add	hl, bc
	ex	de, hl
	ld	hl, #_shadow_OAM+0
	add	hl, bc
	ld	a, (hl)
	dec	a
	ld	(de), a
;src/multiplayer.c:37: if (joy & J_LEFT) scroll_sprite(i, -1, 0);
00104$:
;src/multiplayer.c:38: if (joy & J_RIGHT) scroll_sprite(i, 1, 0);
	bit	3, -6 (ix)
	jr	Z, 00106$
	ld	a, -1 (ix)
	ld	-5 (ix), a
;../../../include/sms/sms.h:864: uint8_t new_y = shadow_OAM[nb] + y;
	ld	bc, #_shadow_OAM+0
	ld	l, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, (hl)
;../../../include/sms/sms.h:865: shadow_OAM[nb] = (new_y < VDP_SAT_TERM) ? new_y : 0xC0;
	ld	a, -1 (ix)
	add	a, #<(_shadow_OAM)
	ld	-4 (ix), a
	ld	a, #0x00
	adc	a, #>(_shadow_OAM)
	ld	-3 (ix), a
	ld	a, c
	sub	a, #0xd0
	jr	NC, 00144$
	ld	-2 (ix), c
	jr	00145$
00144$:
	ld	-2 (ix), #0xc0
00145$:
	ld	a, -2 (ix)
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	(hl), a
;../../../include/sms/sms.h:866: shadow_OAM[0x40+(nb << 1)] += x;
	ld	l, -5 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	ld	bc, #0x40
	add	hl,bc
	ld	c, l
	ld	b, h
	ld	hl, #_shadow_OAM
	add	hl, bc
	ex	de, hl
	ld	hl, #_shadow_OAM+0
	add	hl, bc
	ld	a, (hl)
	inc	a
	ld	(de), a
;src/multiplayer.c:38: if (joy & J_RIGHT) scroll_sprite(i, 1, 0);
00106$:
;src/multiplayer.c:39: if (joy & J_UP) scroll_sprite(i, 0, -1);
	bit	0, -6 (ix)
	jr	Z, 00108$
	ld	c, -1 (ix)
;../../../include/sms/sms.h:864: uint8_t new_y = shadow_OAM[nb] + y;
	ld	de, #_shadow_OAM+0
	ld	l, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	a, (hl)
	dec	a
	ld	b, a
;../../../include/sms/sms.h:865: shadow_OAM[nb] = (new_y < VDP_SAT_TERM) ? new_y : 0xC0;
	ld	de, #_shadow_OAM+0
	ld	l, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	a, b
	sub	a, #0xd0
	jr	C, 00147$
	ld	b, #0xc0
00147$:
	ld	(hl), b
;../../../include/sms/sms.h:866: shadow_OAM[0x40+(nb << 1)] += x;
	ld	b, #0x00
	ld	a, c
	add	a, a
	rl	b
	add	a, #0x40
	ld	c, a
	jr	NC, 00290$
	inc	b
00290$:
	ld	hl, #_shadow_OAM
	add	hl, bc
	ex	de, hl
	ld	hl, #_shadow_OAM
	add	hl, bc
	ld	a, (hl)
	ld	(de), a
;src/multiplayer.c:39: if (joy & J_UP) scroll_sprite(i, 0, -1);
00108$:
;src/multiplayer.c:40: if (joy & J_DOWN) scroll_sprite(i, 0, 1);
	bit	1, -6 (ix)
	jp	Z,00134$
	ld	a, -1 (ix)
	ld	-2 (ix), a
;../../../include/sms/sms.h:864: uint8_t new_y = shadow_OAM[nb] + y;
	ld	a, -1 (ix)
	add	a, #<(_shadow_OAM)
	ld	-4 (ix), a
	ld	a, #0x00
	adc	a, #>(_shadow_OAM)
	ld	-3 (ix), a
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	c, (hl)
	inc	c
;../../../include/sms/sms.h:865: shadow_OAM[nb] = (new_y < VDP_SAT_TERM) ? new_y : 0xC0;
	ld	a, -1 (ix)
	add	a, #<(_shadow_OAM)
	ld	-5 (ix), a
	ld	a, #0x00
	adc	a, #>(_shadow_OAM)
	ld	-4 (ix), a
	ld	a, c
	sub	a, #0xd0
	jr	NC, 00148$
	ld	-3 (ix), c
	jr	00149$
00148$:
	ld	-3 (ix), #0xc0
00149$:
	ld	a, -3 (ix)
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), a
;../../../include/sms/sms.h:866: shadow_OAM[0x40+(nb << 1)] += x;
	ld	a, -2 (ix)
	ld	-3 (ix), a
	ld	-2 (ix), #0x00
	sla	-3 (ix)
	rl	-2 (ix)
	ld	a, -3 (ix)
	add	a, #0x40
	ld	-7 (ix), a
	ld	a, -2 (ix)
	adc	a, #0x00
	ld	-6 (ix), a
	ld	a, -7 (ix)
	add	a, #<(_shadow_OAM)
	ld	-5 (ix), a
	ld	a, -6 (ix)
	adc	a, #>(_shadow_OAM)
	ld	-4 (ix), a
	ld	a, -7 (ix)
	add	a, #<(_shadow_OAM)
	ld	-3 (ix), a
	ld	a, -6 (ix)
	adc	a, #>(_shadow_OAM)
	ld	-2 (ix), a
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	ld	a, (hl)
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), a
;src/multiplayer.c:40: if (joy & J_DOWN) scroll_sprite(i, 0, 1);
00134$:
;src/multiplayer.c:35: for (uint8_t i = 0; i < joypads.npads; i++) {
	inc	-1 (ix)
	jp	00133$
00111$:
;src/multiplayer.c:43: if (joypads.joy0 & J_START) {
	ld	a, (#_joypads + 1)
	bit	6, a
	jr	Z, 00114$
;src/multiplayer.c:44: for (uint8_t i = 0; i < 4; i++) move_sprite(i, (i << 3) + 64, 64);
	ld	c, #0x00
00136$:
	ld	a,c
	cp	a,#0x04
	jr	NC, 00114$
	add	a, a
	add	a, a
	add	a, a
	add	a, #0x40
	ld	b, a
;../../../include/sms/sms.h:848: shadow_OAM[nb] = (y < VDP_SAT_TERM) ? y : 0xC0;
	ld	de, #_shadow_OAM+0
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	(hl), #0x40
;../../../include/sms/sms.h:849: shadow_OAM[0x40+(nb << 1)] = x;
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	ld	de, #0x0040
	add	hl, de
	ld	de, #_shadow_OAM
	add	hl, de
	ld	(hl), b
;src/multiplayer.c:44: for (uint8_t i = 0; i < 4; i++) move_sprite(i, (i << 3) + 64, 64);
	inc	c
	jr	00136$
00114$:
;src/multiplayer.c:46: vsync();
	call	_vsync
;src/multiplayer.c:48: }
	jp	00116$
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
	.area _CABS (ABS)
