;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module joytest
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _reset_object_pos
	.globl _draw_disabled
	.globl _draw_buttons
	.globl _fill_rect_compat
	.globl _set_tile_map_compat
	.globl _set_tile_2bpp_data
	.globl _joypad_ex
	.globl _joypad_init
	.globl _joypad
	.globl _vsync
	.globl _joy
	.globl _old_joy
	.globl _isSGB
	.globl _toggle
	.globl _joypads
	.globl _old_joypads
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
_old_joypads::
	.ds 5
_joypads::
	.ds 5
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_toggle::
	.ds 1
_isSGB::
	.ds 1
_old_joy::
	.ds 1
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
;src/joytest.c:13: void draw_buttons(uint8_t state, uint8_t x, uint8_t y) {
;	---------------------------------
; Function draw_buttons
; ---------------------------------
_draw_buttons::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	ld	b, a
	ld	-1 (ix), l
;src/joytest.c:14: set_bkg_based_tiles(x,      y, 2, 2, (state & J_UP)     ? pressed_buttons[0] : normal_buttons[0], 1);
	bit	0, b
	jr	Z, 00111$
	ld	de, #_pressed_buttons+0
	jr	00112$
00111$:
	ld	de, #_normal_buttons+0
00112$:
	ld	c, 4 (ix)
;../../../include/sms/sms.h:676: _map_tile_offset = base_tile;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x01
;../../../include/sms/sms.h:677: set_tile_map_compat(x, y, w, h, tiles);
	push	bc
	push	de
	ld	hl, #0x202
	push	hl
	ld	h, c
	ld	l, -1 (ix)
	push	hl
	call	_set_tile_map_compat
	pop	bc
;../../../include/sms/sms.h:678: _map_tile_offset = 0;
	ld	a, #0x00
	ld	(#__map_tile_offset), a
;src/joytest.c:15: set_bkg_based_tiles(x + 2,  y, 2, 2, (state & J_DOWN)   ? pressed_buttons[1] : normal_buttons[1], 1);
	bit	1, b
	jr	Z, 00113$
	ld	de, #_pressed_buttons+4
	jr	00114$
00113$:
	ld	de, #_normal_buttons+4
00114$:
	ld	a, -1 (ix)
	ld	-2 (ix), a
	inc	a
	inc	a
;../../../include/sms/sms.h:676: _map_tile_offset = base_tile;
	ld	iy, #__map_tile_offset
	ld	0 (iy), #0x01
;../../../include/sms/sms.h:677: set_tile_map_compat(x, y, w, h, tiles);
	push	bc
	push	de
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_tile_map_compat
	pop	bc
;../../../include/sms/sms.h:678: _map_tile_offset = 0;
	ld	a, #0x00
	ld	(#__map_tile_offset), a
;src/joytest.c:16: set_bkg_based_tiles(x + 4,  y, 2, 2, (state & J_LEFT)   ? pressed_buttons[2] : normal_buttons[2], 1);
	bit	2, b
	jr	Z, 00115$
	ld	de, #_pressed_buttons+8
	jr	00116$
00115$:
	ld	de, #_normal_buttons+8
00116$:
	ld	a, -2 (ix)
	inc	a
	inc	a
	inc	a
	inc	a
;../../../include/sms/sms.h:676: _map_tile_offset = base_tile;
	ld	iy, #__map_tile_offset
	ld	0 (iy), #0x01
;../../../include/sms/sms.h:677: set_tile_map_compat(x, y, w, h, tiles);
	push	bc
	push	de
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_tile_map_compat
	pop	bc
;../../../include/sms/sms.h:678: _map_tile_offset = 0;
	xor	a, a
	ld	(#__map_tile_offset), a
;src/joytest.c:17: set_bkg_based_tiles(x + 6,  y, 2, 2, (state & J_RIGHT)  ? pressed_buttons[3] : normal_buttons[3], 1);
	bit	3, b
	jr	Z, 00117$
	ld	de, #_pressed_buttons+12
	jr	00118$
00117$:
	ld	de, #_normal_buttons+12
00118$:
	ld	a, -2 (ix)
	add	a, #0x06
;../../../include/sms/sms.h:676: _map_tile_offset = base_tile;
	ld	iy, #__map_tile_offset
	ld	0 (iy), #0x01
;../../../include/sms/sms.h:677: set_tile_map_compat(x, y, w, h, tiles);
	push	bc
	push	de
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_tile_map_compat
	pop	bc
;../../../include/sms/sms.h:678: _map_tile_offset = 0;
	xor	a, a
	ld	(#__map_tile_offset), a
;src/joytest.c:18: set_bkg_based_tiles(x + 8,  y, 2, 2, (state & J_A)      ? pressed_buttons[4] : normal_buttons[4], 1);
	bit	5, b
	jr	Z, 00119$
	ld	de, #_pressed_buttons+16
	jr	00120$
00119$:
	ld	de, #_normal_buttons+16
00120$:
	ld	a, -2 (ix)
	add	a, #0x08
;../../../include/sms/sms.h:676: _map_tile_offset = base_tile;
	ld	iy, #__map_tile_offset
	ld	0 (iy), #0x01
;../../../include/sms/sms.h:677: set_tile_map_compat(x, y, w, h, tiles);
	push	bc
	push	de
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_tile_map_compat
	pop	bc
;../../../include/sms/sms.h:678: _map_tile_offset = 0;
	xor	a, a
	ld	(#__map_tile_offset), a
;src/joytest.c:19: set_bkg_based_tiles(x + 10, y, 2, 2, (state & J_B)      ? pressed_buttons[5] : normal_buttons[5], 1);
	bit	4, b
	jr	Z, 00121$
	ld	de, #_pressed_buttons+20
	jr	00122$
00121$:
	ld	de, #_normal_buttons+20
00122$:
	ld	a, -2 (ix)
	add	a, #0x0a
;../../../include/sms/sms.h:676: _map_tile_offset = base_tile;
	ld	iy, #__map_tile_offset
	ld	0 (iy), #0x01
;../../../include/sms/sms.h:677: set_tile_map_compat(x, y, w, h, tiles);
	push	bc
	push	de
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_tile_map_compat
	pop	bc
;../../../include/sms/sms.h:678: _map_tile_offset = 0;
	xor	a, a
	ld	(#__map_tile_offset), a
;src/joytest.c:20: set_bkg_based_tiles(x + 12, y, 2, 2, (state & J_START)  ? pressed_buttons[6] : normal_buttons[6], 1);
	bit	6, b
	jr	Z, 00123$
	ld	de, #_pressed_buttons+24
	jr	00124$
00123$:
	ld	de, #_normal_buttons+24
00124$:
	ld	a, -2 (ix)
	add	a, #0x0c
;../../../include/sms/sms.h:676: _map_tile_offset = base_tile;
	ld	iy, #__map_tile_offset
	ld	0 (iy), #0x01
;../../../include/sms/sms.h:677: set_tile_map_compat(x, y, w, h, tiles);
	push	bc
	push	de
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_tile_map_compat
	pop	bc
;../../../include/sms/sms.h:678: _map_tile_offset = 0;
	xor	a, a
	ld	(#__map_tile_offset), a
;src/joytest.c:21: set_bkg_based_tiles(x + 14, y, 2, 2, (state & J_SELECT) ? pressed_buttons[7] : normal_buttons[7], 1);
	bit	7, b
	jr	Z, 00125$
	ld	de, #_pressed_buttons+28
	jr	00126$
00125$:
	ld	de, #_normal_buttons+28
00126$:
	ld	a, -2 (ix)
	add	a, #0x0e
;../../../include/sms/sms.h:676: _map_tile_offset = base_tile;
	ld	iy, #__map_tile_offset
	ld	0 (iy), #0x01
;../../../include/sms/sms.h:677: set_tile_map_compat(x, y, w, h, tiles);
	push	de
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_tile_map_compat
;../../../include/sms/sms.h:678: _map_tile_offset = 0;
	ld	iy, #__map_tile_offset
	ld	0 (iy), #0x00
;src/joytest.c:21: set_bkg_based_tiles(x + 14, y, 2, 2, (state & J_SELECT) ? pressed_buttons[7] : normal_buttons[7], 1);
;src/joytest.c:22: }
	ld	sp, ix
	pop	ix
	pop	hl
	inc	sp
	jp	(hl)
;src/joytest.c:24: void draw_disabled(uint8_t x, uint8_t y) {
;	---------------------------------
; Function draw_disabled
; ---------------------------------
_draw_disabled::
	ld	c, a
	ld	b, l
;src/joytest.c:25: set_bkg_based_tiles(x,      y, 2, 2, disabled_buttons[0], 1);
;../../../include/sms/sms.h:676: _map_tile_offset = base_tile;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x01
;../../../include/sms/sms.h:677: set_tile_map_compat(x, y, w, h, tiles);
	push	bc
	ld	hl, #_disabled_buttons
	push	hl
	ld	hl, #0x202
	push	hl
	push	bc
	call	_set_tile_map_compat
	pop	bc
;src/joytest.c:26: set_bkg_based_tiles(x + 2,  y, 2, 2, disabled_buttons[1], 1);
	ld	de, #_disabled_buttons + 4
	ld	a, c
	inc	a
	inc	a
;../../../include/sms/sms.h:676: _map_tile_offset = base_tile;
	ld	iy, #__map_tile_offset
	ld	0 (iy), #0x01
;../../../include/sms/sms.h:677: set_tile_map_compat(x, y, w, h, tiles);
	push	bc
	push	de
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	push	hl
	push	af
	inc	sp
	call	_set_tile_map_compat
	pop	bc
;src/joytest.c:27: set_bkg_based_tiles(x + 4,  y, 2, 2, disabled_buttons[2], 1);
	ld	de, #_disabled_buttons + 8
	ld	a, c
	inc	a
	inc	a
	inc	a
	inc	a
;../../../include/sms/sms.h:676: _map_tile_offset = base_tile;
	ld	iy, #__map_tile_offset
	ld	0 (iy), #0x01
;../../../include/sms/sms.h:677: set_tile_map_compat(x, y, w, h, tiles);
	push	bc
	push	de
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	push	hl
	push	af
	inc	sp
	call	_set_tile_map_compat
	pop	bc
;src/joytest.c:28: set_bkg_based_tiles(x + 6,  y, 2, 2, disabled_buttons[3], 1);
	ld	de, #_disabled_buttons + 12
	ld	a, c
	add	a, #0x06
;../../../include/sms/sms.h:676: _map_tile_offset = base_tile;
	ld	iy, #__map_tile_offset
	ld	0 (iy), #0x01
;../../../include/sms/sms.h:677: set_tile_map_compat(x, y, w, h, tiles);
	push	bc
	push	de
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	push	hl
	push	af
	inc	sp
	call	_set_tile_map_compat
	pop	bc
;src/joytest.c:29: set_bkg_based_tiles(x + 8,  y, 2, 2, disabled_buttons[4], 1);
	ld	de, #_disabled_buttons + 16
	ld	a, c
	add	a, #0x08
;../../../include/sms/sms.h:676: _map_tile_offset = base_tile;
	ld	iy, #__map_tile_offset
	ld	0 (iy), #0x01
;../../../include/sms/sms.h:677: set_tile_map_compat(x, y, w, h, tiles);
	push	bc
	push	de
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	push	hl
	push	af
	inc	sp
	call	_set_tile_map_compat
	pop	bc
;src/joytest.c:30: set_bkg_based_tiles(x + 10, y, 2, 2, disabled_buttons[5], 1);
	ld	de, #_disabled_buttons + 20
	ld	a, c
	add	a, #0x0a
;../../../include/sms/sms.h:676: _map_tile_offset = base_tile;
	ld	iy, #__map_tile_offset
	ld	0 (iy), #0x01
;../../../include/sms/sms.h:677: set_tile_map_compat(x, y, w, h, tiles);
	push	bc
	push	de
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	push	hl
	push	af
	inc	sp
	call	_set_tile_map_compat
	pop	bc
;src/joytest.c:31: set_bkg_based_tiles(x + 12, y, 2, 2, disabled_buttons[6], 1);
	ld	de, #_disabled_buttons + 24
	ld	a, c
	add	a, #0x0c
;../../../include/sms/sms.h:676: _map_tile_offset = base_tile;
	ld	iy, #__map_tile_offset
	ld	0 (iy), #0x01
;../../../include/sms/sms.h:677: set_tile_map_compat(x, y, w, h, tiles);
	push	bc
	push	de
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	push	hl
	push	af
	inc	sp
	call	_set_tile_map_compat
	pop	bc
;src/joytest.c:32: set_bkg_based_tiles(x + 14, y, 2, 2, disabled_buttons[7], 1);
	ld	de, #_disabled_buttons + 28
	ld	a, c
	add	a, #0x0e
;../../../include/sms/sms.h:676: _map_tile_offset = base_tile;
	ld	iy, #__map_tile_offset
	ld	0 (iy), #0x01
;../../../include/sms/sms.h:677: set_tile_map_compat(x, y, w, h, tiles);
	push	de
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	push	hl
	push	af
	inc	sp
	call	_set_tile_map_compat
;../../../include/sms/sms.h:678: _map_tile_offset = 0;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x00
;src/joytest.c:32: set_bkg_based_tiles(x + 14, y, 2, 2, disabled_buttons[7], 1);
;src/joytest.c:33: }
	ret
;src/joytest.c:35: void reset_object_pos(void) {
;	---------------------------------
; Function reset_object_pos
; ---------------------------------
_reset_object_pos::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;src/joytest.c:36: for (uint8_t i = 0; i < 4; i++) {
	ld	c, #0x00
00105$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00107$
;../../../include/sms/sms.h:807: shadow_OAM[0x41+(nb << 1)] = tile;
	ld	e, c
	ld	d, #0x00
	ex	de, hl
	add	hl, hl
	ex	de, hl
	ld	hl, #0x0041
	add	hl, de
	ld	a, #<(_shadow_OAM)
	add	a, l
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #>(_shadow_OAM)
	adc	a, h
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	(hl), c
;src/joytest.c:39: DEVICE_SPRITE_PX_OFFSET_X + (i << 3) + ((DEVICE_SCREEN_PX_WIDTH - (4 * 8)) >> 1), 
	ld	a, c
	add	a, a
	add	a, a
	add	a, a
	add	a, #0x70
	ld	-1 (ix), a
;../../../include/sms/sms.h:848: shadow_OAM[nb] = (y < VDP_SAT_TERM) ? y : 0xC0;
	ld	hl, #_shadow_OAM
	ld	b, #0x00
	add	hl, bc
	ld	(hl), #0x8b
;../../../include/sms/sms.h:849: shadow_OAM[0x40+(nb << 1)] = x;
	ld	hl, #0x0040
	add	hl, de
	ld	de, #_shadow_OAM
	add	hl, de
	ld	a, -1 (ix)
	ld	(hl), a
;src/joytest.c:36: for (uint8_t i = 0; i < 4; i++) {
	inc	c
	jr	00105$
00107$:
;src/joytest.c:43: }
	inc	sp
	pop	ix
	ret
;src/joytest.c:51: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-6
	add	hl, sp
	ld	sp, hl
;src/joytest.c:54: for (uint8_t i = 4; i != 0; i--) vsync();
	ld	c, #0x04
00141$:
	ld	a, c
	or	a, a
	jr	Z, 00101$
	call	_vsync
	dec	c
	jr	00141$
00101$:
;src/joytest.c:60: joypad_init(4, &joypads);
	ld	hl, #_joypads
	push	hl
	ld	a, #0x04
	push	af
	inc	sp
	call	_joypad_init
;src/joytest.c:62: set_sprite_data(0, sizeof(sprite_data) >> 4, sprite_data);
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
;src/joytest.c:63: set_bkg_data(1, sizeof(tiles_data) >> 4, tiles_data);
;../../../include/sms/sms.h:633: set_tile_2bpp_data(start, ntiles, src, _current_2bpp_palette);
	ld	hl, (__current_2bpp_palette)
	push	hl
	ld	hl, #_tiles_data
	push	hl
	ld	hl, #0x005d
	push	hl
	ld	l, #0x01
	push	hl
	call	_set_tile_2bpp_data
;src/joytest.c:64: fill_bkg_rect(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, 0);
	ld	hl, #0x0000
	push	hl
	ld	hl, #0x1820
	push	hl
	ld	hl, #0x00
	push	hl
	call	_fill_rect_compat
;src/joytest.c:66: if (isSGB) draw_disabled(0, 0); else draw_buttons(joy, 0, 0);
	ld	hl, #_isSGB
	bit	0, (hl)
	jr	Z, 00103$
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	ld	l, a
	call	_draw_disabled
	jr	00164$
00103$:
	xor	a, a
	push	af
	inc	sp
	ld	l, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	a, (_joy+0)
	call	_draw_buttons
;src/joytest.c:68: for (uint8_t i = 0; i != 4; i++) {
00164$:
	ld	-1 (ix), #0x00
00144$:
	ld	a, -1 (ix)
	sub	a, #0x04
	jr	Z, 00108$
;src/joytest.c:69: if (i <= (joypads.npads - 1)) {
	ld	hl, #_joypads
	ld	e, (hl)
	ld	d, #0x00
	dec	de
	ld	l, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
;src/joytest.c:70: draw_buttons(joypads.joypads[i], 0, 4 + (i << 1)); 
	ld	a, -1 (ix)
	add	a, a
	add	a, #0x04
	ld	c, a
;src/joytest.c:69: if (i <= (joypads.npads - 1)) {
	ld	a, e
	sub	a, l
	ld	a, d
	sbc	a, h
	jp	PO, 00324$
	xor	a, #0x80
00324$:
	jp	M, 00106$
;src/joytest.c:70: draw_buttons(joypads.joypads[i], 0, 4 + (i << 1)); 
	ld	de, #_joypads + 1
	ld	l, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	b, (hl)
	ld	a, c
	push	af
	inc	sp
	ld	l, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	a, b
	call	_draw_buttons
	jr	00145$
00106$:
;src/joytest.c:72: draw_disabled(0, 4 + (i << 1));
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	call	_draw_disabled
00145$:
;src/joytest.c:68: for (uint8_t i = 0; i != 4; i++) {
	inc	-1 (ix)
	jr	00144$
00108$:
;src/joytest.c:76: reset_object_pos();
	call	_reset_object_pos
;src/joytest.c:77: SHOW_SPRITES; SHOW_BKG;
	xor	a, a
	ld	(#__sprites_OFF), a
;src/joytest.c:79: while(TRUE) {
00132$:
;src/joytest.c:81: if (toggle = !toggle) {
	ld	a, (_toggle+0)
	xor	a, #0x01
	ld	c, a
	ld	(_toggle+0), a
	bit	0, c
	jr	Z, 00129$
;src/joytest.c:83: if (!isSGB) {
	ld	iy, #_isSGB
	bit	0, 0 (iy)
	jp	NZ, 00130$
;src/joytest.c:84: old_joy = joy, joy = joypad();
	ld	a, (_joy+0)
	ld	(_old_joy+0), a
	call	_joypad
	ld	a, l
	ld	(_joy+0), a
;src/joytest.c:87: if (joy != old_joy) draw_buttons(joy, 0, 0);
	ld	a, (_joy+0)
	ld	iy, #_old_joy
	sub	a, 0 (iy)
	jr	Z, 00110$
	xor	a, a
	push	af
	inc	sp
	ld	l, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	a, (_joy+0)
	call	_draw_buttons
00110$:
;src/joytest.c:90: if (joy & J_START) reset_object_pos();
	ld	a, (_joy+0)
	bit	6, a
	jp	Z,00130$
	call	_reset_object_pos
	jp	00130$
00129$:
;src/joytest.c:93: old_joypads = joypads;
	ld	de, #_old_joypads
	ld	hl, #_joypads
	ld	bc, #0x0005
	ldir
;src/joytest.c:94: joypad_ex(&joypads);
	ld	hl, #_joypads
	call	_joypad_ex
;src/joytest.c:96: for (uint8_t i = 0; i < joypads.npads; i++) {
	ld	-1 (ix), #0x00
00147$:
	ld	hl, #_joypads
	ld	a,-1 (ix)
	sub	a,(hl)
	jp	NC, 00130$
;src/joytest.c:97: uint8_t j = joypads.joypads[i];
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
;src/joytest.c:100: if (old_joypads.joypads[i] != j) draw_buttons(j, 0, 4 + (i << 1));
	ld	bc, #_old_joypads + 1
	ld	l, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	a,-6 (ix)
	sub	a,(hl)
	jr	Z, 00116$
	ld	a, -1 (ix)
	add	a, a
	add	a, #0x04
	push	af
	inc	sp
	ld	l, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	a, -6 (ix)
	call	_draw_buttons
00116$:
;src/joytest.c:103: if (j & J_LEFT)  scroll_sprite(i, -1, 0);
	bit	2, -6 (ix)
	jr	Z, 00118$
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
	jr	NC, 00151$
	ld	-2 (ix), c
	jr	00152$
00151$:
	ld	-2 (ix), #0xc0
00152$:
	ld	a, -2 (ix)
	pop	bc
	pop	hl
	push	hl
	push	bc
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
	dec	a
	ld	(de), a
;src/joytest.c:103: if (j & J_LEFT)  scroll_sprite(i, -1, 0);
00118$:
;src/joytest.c:104: if (j & J_RIGHT) scroll_sprite(i, 1, 0);
	bit	3, -6 (ix)
	jr	Z, 00120$
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
	jr	C, 00154$
	ld	b, #0xc0
00154$:
	ld	(hl), b
;../../../include/sms/sms.h:866: shadow_OAM[0x40+(nb << 1)] += x;
	ld	b, #0x00
	ld	a, c
	add	a, a
	rl	b
	add	a, #0x40
	ld	c, a
	jr	NC, 00331$
	inc	b
00331$:
	ld	hl, #_shadow_OAM
	add	hl, bc
	ex	de, hl
	ld	hl, #_shadow_OAM+0
	add	hl, bc
	ld	a, (hl)
	inc	a
	ld	(de), a
;src/joytest.c:104: if (j & J_RIGHT) scroll_sprite(i, 1, 0);
00120$:
;src/joytest.c:105: if (j & J_UP)    scroll_sprite(i, 0, -1);
	bit	0, -6 (ix)
	jr	Z, 00122$
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
	jr	C, 00156$
	ld	b, #0xc0
00156$:
	ld	(hl), b
;../../../include/sms/sms.h:866: shadow_OAM[0x40+(nb << 1)] += x;
	ld	b, #0x00
	ld	a, c
	add	a, a
	rl	b
	add	a, #0x40
	ld	c, a
	jr	NC, 00334$
	inc	b
00334$:
	ld	hl, #_shadow_OAM
	add	hl, bc
	ex	de, hl
	ld	hl, #_shadow_OAM+0
	add	hl, bc
	ld	a, (hl)
	ld	(de), a
;src/joytest.c:105: if (j & J_UP)    scroll_sprite(i, 0, -1);
00122$:
;src/joytest.c:106: if (j & J_DOWN)  scroll_sprite(i, 0, 1);
	bit	1, -6 (ix)
	jr	Z, 00124$
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
	inc	b
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
	jr	C, 00158$
	ld	b, #0xc0
00158$:
	ld	(hl), b
;../../../include/sms/sms.h:866: shadow_OAM[0x40+(nb << 1)] += x;
	ld	a, c
	ld	b, #0x00
	add	a, a
	rl	b
	add	a, #0x40
	ld	c, a
	jr	NC, 00337$
	inc	b
00337$:
	ld	hl, #_shadow_OAM
	add	hl, bc
	ex	de, hl
	ld	hl, #_shadow_OAM
	add	hl, bc
	ld	a, (hl)
	ld	(de), a
;src/joytest.c:106: if (j & J_DOWN)  scroll_sprite(i, 0, 1);
00124$:
;src/joytest.c:109: if (j & J_START) reset_object_pos();
	bit	6, -6 (ix)
	jr	Z, 00148$
	call	_reset_object_pos
00148$:
;src/joytest.c:96: for (uint8_t i = 0; i < joypads.npads; i++) {
	inc	-1 (ix)
	jp	00147$
00130$:
;src/joytest.c:113: vsync();
	call	_vsync
;src/joytest.c:115: }
	jp	00132$
	.area _CODE
	.area _INITIALIZER
__xinit__toggle:
	.db #0x00	;  0
__xinit__isSGB:
	.db #0x00	;  0
__xinit__old_joy:
	.db #0xff	; 255
__xinit__joy:
	.db #0x00	; 0
	.area _CABS (ABS)
