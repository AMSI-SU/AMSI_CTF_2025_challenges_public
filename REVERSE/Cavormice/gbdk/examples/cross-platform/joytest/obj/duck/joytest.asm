;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module joytest
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _reset_object_pos
	.globl _draw_disabled
	.globl _draw_buttons
	.globl _sgb_check
	.globl _fill_bkg_rect
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _vsync
	.globl _joypad_ex
	.globl _joypad_init
	.globl _joypad
	.globl _joy
	.globl _old_joy
	.globl _isSGB
	.globl _toggle
	.globl _joypads
	.globl _old_joypads
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
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
	dec	sp
	ld	c, a
	ld	b, e
;src/joytest.c:14: set_bkg_based_tiles(x,      y, 2, 2, (state & J_UP)     ? pressed_buttons[0] : normal_buttons[0], 1);
	bit	2, c
	jr	Z, 00111$
	ld	de, #_pressed_buttons+0
	jr	00112$
00111$:
	ld	de, #_normal_buttons+0
00112$:
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
;../../../include/gb/gb.h:1170: _map_tile_offset = base_tile;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x01
;../../../include/gb/gb.h:1171: set_bkg_tiles(x, y, w, h, tiles);
	push	de
	ld	hl, #0x202
	push	hl
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;../../../include/gb/gb.h:1172: _map_tile_offset = 0;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x00
;src/joytest.c:15: set_bkg_based_tiles(x + 2,  y, 2, 2, (state & J_DOWN)   ? pressed_buttons[1] : normal_buttons[1], 1);
	bit	3, c
	jr	Z, 00113$
	ld	de, #_pressed_buttons+4
	jr	00114$
00113$:
	ld	de, #_normal_buttons+4
00114$:
	ld	a, b
	inc	a
	inc	a
;../../../include/gb/gb.h:1170: _map_tile_offset = base_tile;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x01
;../../../include/gb/gb.h:1171: set_bkg_tiles(x, y, w, h, tiles);
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
	ldhl	sp,	#4
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;../../../include/gb/gb.h:1172: _map_tile_offset = 0;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x00
;src/joytest.c:16: set_bkg_based_tiles(x + 4,  y, 2, 2, (state & J_LEFT)   ? pressed_buttons[2] : normal_buttons[2], 1);
	bit	1, c
	jr	Z, 00115$
	ld	de, #_pressed_buttons+8
	jr	00116$
00115$:
	ld	de, #_normal_buttons+8
00116$:
	ld	a, b
	inc	a
	inc	a
	inc	a
	inc	a
;../../../include/gb/gb.h:1170: _map_tile_offset = base_tile;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x01
;../../../include/gb/gb.h:1171: set_bkg_tiles(x, y, w, h, tiles);
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
	ldhl	sp,	#4
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;../../../include/gb/gb.h:1172: _map_tile_offset = 0;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x00
;src/joytest.c:17: set_bkg_based_tiles(x + 6,  y, 2, 2, (state & J_RIGHT)  ? pressed_buttons[3] : normal_buttons[3], 1);
	bit	0, c
	jr	Z, 00117$
	ld	de, #_pressed_buttons+12
	jr	00118$
00117$:
	ld	de, #_normal_buttons+12
00118$:
	ld	a, b
	add	a, #0x06
;../../../include/gb/gb.h:1170: _map_tile_offset = base_tile;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x01
;../../../include/gb/gb.h:1171: set_bkg_tiles(x, y, w, h, tiles);
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
	ldhl	sp,	#4
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;../../../include/gb/gb.h:1172: _map_tile_offset = 0;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x00
;src/joytest.c:18: set_bkg_based_tiles(x + 8,  y, 2, 2, (state & J_A)      ? pressed_buttons[4] : normal_buttons[4], 1);
	bit	4, c
	jr	Z, 00119$
	ld	de, #_pressed_buttons+16
	jr	00120$
00119$:
	ld	de, #_normal_buttons+16
00120$:
	ld	a, b
	add	a, #0x08
;../../../include/gb/gb.h:1170: _map_tile_offset = base_tile;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x01
;../../../include/gb/gb.h:1171: set_bkg_tiles(x, y, w, h, tiles);
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
	ldhl	sp,	#4
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;../../../include/gb/gb.h:1172: _map_tile_offset = 0;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x00
;src/joytest.c:19: set_bkg_based_tiles(x + 10, y, 2, 2, (state & J_B)      ? pressed_buttons[5] : normal_buttons[5], 1);
	bit	5, c
	jr	Z, 00121$
	ld	de, #_pressed_buttons+20
	jr	00122$
00121$:
	ld	de, #_normal_buttons+20
00122$:
	ld	a, b
	add	a, #0x0a
;../../../include/gb/gb.h:1170: _map_tile_offset = base_tile;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x01
;../../../include/gb/gb.h:1171: set_bkg_tiles(x, y, w, h, tiles);
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
	ldhl	sp,	#4
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;../../../include/gb/gb.h:1172: _map_tile_offset = 0;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x00
;src/joytest.c:20: set_bkg_based_tiles(x + 12, y, 2, 2, (state & J_START)  ? pressed_buttons[6] : normal_buttons[6], 1);
	bit	7, c
	jr	Z, 00123$
	ld	de, #_pressed_buttons+24
	jr	00124$
00123$:
	ld	de, #_normal_buttons+24
00124$:
	ld	a, b
	add	a, #0x0c
;../../../include/gb/gb.h:1170: _map_tile_offset = base_tile;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x01
;../../../include/gb/gb.h:1171: set_bkg_tiles(x, y, w, h, tiles);
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
	ldhl	sp,	#4
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;../../../include/gb/gb.h:1172: _map_tile_offset = 0;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x00
;src/joytest.c:21: set_bkg_based_tiles(x + 14, y, 2, 2, (state & J_SELECT) ? pressed_buttons[7] : normal_buttons[7], 1);
	bit	6, c
	jr	Z, 00125$
	ld	de, #_pressed_buttons+28
	jr	00126$
00125$:
	ld	de, #_normal_buttons+28
00126$:
	ld	a, b
	add	a, #0x0e
;../../../include/gb/gb.h:1170: _map_tile_offset = base_tile;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x01
;../../../include/gb/gb.h:1171: set_bkg_tiles(x, y, w, h, tiles);
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
	ldhl	sp,	#4
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;../../../include/gb/gb.h:1172: _map_tile_offset = 0;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x00
;src/joytest.c:21: set_bkg_based_tiles(x + 14, y, 2, 2, (state & J_SELECT) ? pressed_buttons[7] : normal_buttons[7], 1);
;src/joytest.c:22: }
	inc	sp
	pop	hl
	inc	sp
	jp	(hl)
;src/joytest.c:24: void draw_disabled(uint8_t x, uint8_t y) {
;	---------------------------------
; Function draw_disabled
; ---------------------------------
_draw_disabled::
	ld	c, a
	ld	b, e
;src/joytest.c:25: set_bkg_based_tiles(x,      y, 2, 2, disabled_buttons[0], 1);
;../../../include/gb/gb.h:1170: _map_tile_offset = base_tile;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x01
;../../../include/gb/gb.h:1171: set_bkg_tiles(x, y, w, h, tiles);
	ld	de, #_disabled_buttons
	push	de
	ld	hl, #0x202
	push	hl
	push	bc
	inc	sp
	ld	a, c
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;src/joytest.c:26: set_bkg_based_tiles(x + 2,  y, 2, 2, disabled_buttons[1], 1);
	ld	de, #_disabled_buttons + 4
	ld	a, c
	inc	a
	inc	a
;../../../include/gb/gb.h:1170: _map_tile_offset = base_tile;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x01
;../../../include/gb/gb.h:1171: set_bkg_tiles(x, y, w, h, tiles);
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
	call	_set_bkg_tiles
	add	sp, #6
;src/joytest.c:27: set_bkg_based_tiles(x + 4,  y, 2, 2, disabled_buttons[2], 1);
	ld	de, #_disabled_buttons + 8
	ld	a, c
	inc	a
	inc	a
	inc	a
	inc	a
;../../../include/gb/gb.h:1170: _map_tile_offset = base_tile;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x01
;../../../include/gb/gb.h:1171: set_bkg_tiles(x, y, w, h, tiles);
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
	call	_set_bkg_tiles
	add	sp, #6
;src/joytest.c:28: set_bkg_based_tiles(x + 6,  y, 2, 2, disabled_buttons[3], 1);
	ld	de, #_disabled_buttons + 12
	ld	a, c
	add	a, #0x06
;../../../include/gb/gb.h:1170: _map_tile_offset = base_tile;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x01
;../../../include/gb/gb.h:1171: set_bkg_tiles(x, y, w, h, tiles);
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
	call	_set_bkg_tiles
	add	sp, #6
;src/joytest.c:29: set_bkg_based_tiles(x + 8,  y, 2, 2, disabled_buttons[4], 1);
	ld	de, #_disabled_buttons + 16
	ld	a, c
	add	a, #0x08
;../../../include/gb/gb.h:1170: _map_tile_offset = base_tile;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x01
;../../../include/gb/gb.h:1171: set_bkg_tiles(x, y, w, h, tiles);
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
	call	_set_bkg_tiles
	add	sp, #6
;src/joytest.c:30: set_bkg_based_tiles(x + 10, y, 2, 2, disabled_buttons[5], 1);
	ld	de, #_disabled_buttons + 20
	ld	a, c
	add	a, #0x0a
;../../../include/gb/gb.h:1170: _map_tile_offset = base_tile;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x01
;../../../include/gb/gb.h:1171: set_bkg_tiles(x, y, w, h, tiles);
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
	call	_set_bkg_tiles
	add	sp, #6
;src/joytest.c:31: set_bkg_based_tiles(x + 12, y, 2, 2, disabled_buttons[6], 1);
	ld	de, #_disabled_buttons + 24
	ld	a, c
	add	a, #0x0c
;../../../include/gb/gb.h:1170: _map_tile_offset = base_tile;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x01
;../../../include/gb/gb.h:1171: set_bkg_tiles(x, y, w, h, tiles);
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
	call	_set_bkg_tiles
	add	sp, #6
;src/joytest.c:32: set_bkg_based_tiles(x + 14, y, 2, 2, disabled_buttons[7], 1);
	ld	de, #_disabled_buttons + 28
	ld	a, c
	add	a, #0x0e
;../../../include/gb/gb.h:1170: _map_tile_offset = base_tile;
	ld	hl, #__map_tile_offset
	ld	(hl), #0x01
;../../../include/gb/gb.h:1171: set_bkg_tiles(x, y, w, h, tiles);
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
	call	_set_bkg_tiles
	add	sp, #6
;../../../include/gb/gb.h:1172: _map_tile_offset = 0;
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
;src/joytest.c:36: for (uint8_t i = 0; i < 4; i++) {
	ld	c, #0x00
00105$:
	ld	a, c
	sub	a, #0x04
	ret	NC
;../../../include/gb/gb.h:1875: shadow_OAM[nb].tile=tile;
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	e, l
	ld	d, h
	ld	hl,#_shadow_OAM + 1
	add	hl,de
	inc	hl
	ld	(hl), c
;src/joytest.c:39: DEVICE_SPRITE_PX_OFFSET_X + (i << 3) + ((DEVICE_SCREEN_PX_WIDTH - (4 * 8)) >> 1), 
	ld	a, c
	add	a, a
	add	a, a
	add	a, a
	add	a, #0x48
	ld	b, a
;../../../include/gb/gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
	add	hl, de
;../../../include/gb/gb.h:1962: itm->y=y, itm->x=x;
	ld	a, #0x84
	ld	(hl+), a
	ld	(hl), b
;src/joytest.c:36: for (uint8_t i = 0; i < 4; i++) {
	inc	c
;src/joytest.c:43: }
	jr	00105$
;src/joytest.c:51: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-4
;src/joytest.c:54: for (uint8_t i = 4; i != 0; i--) vsync();
	ld	c, #0x04
00139$:
	ld	a, c
	or	a, a
	jr	Z, 00101$
	call	_vsync
	dec	c
	jr	00139$
00101$:
;src/joytest.c:57: isSGB = sgb_check();
	call	_sgb_check
	xor	a, a
	cp	a, e
	rla
	ld	(#_isSGB),a
;src/joytest.c:60: joypad_init(4, &joypads);
	ld	de, #_joypads
	push	de
	ld	a, #0x04
	push	af
	inc	sp
	call	_joypad_init
	add	sp, #3
;src/joytest.c:62: set_sprite_data(0, sizeof(sprite_data) >> 4, sprite_data);
	ld	de, #_sprite_data
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/joytest.c:63: set_bkg_data(1, sizeof(tiles_data) >> 4, tiles_data);
	ld	de, #_tiles_data
	push	de
	ld	hl, #0x5d01
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/joytest.c:64: fill_bkg_rect(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, 0);
	xor	a, a
	ld	h, a
	ld	l, #0x12
	push	hl
	ld	a, #0x14
	push	af
	inc	sp
	xor	a, a
	rrca
	push	af
	call	_fill_bkg_rect
	add	sp, #5
;src/joytest.c:66: if (isSGB) draw_disabled(0, 0); else draw_buttons(joy, 0, 0);
	ld	hl, #_isSGB
	bit	0, (hl)
	jr	Z, 00103$
	xor	a, a
	ld	e, a
	call	_draw_disabled
	jr	00154$
00103$:
	xor	a, a
	push	af
	inc	sp
	ld	e, #0x00
	ld	a, (#_joy)
	call	_draw_buttons
;src/joytest.c:68: for (uint8_t i = 0; i != 4; i++) {
00154$:
	ldhl	sp,	#3
	ld	(hl), #0x00
00142$:
	ldhl	sp,	#3
	ld	a, (hl)
	sub	a, #0x04
	jr	Z, 00108$
;src/joytest.c:69: if (i <= (joypads.npads - 1)) {
	ld	hl, #_joypads
	ld	c, (hl)
	xor	a, a
	ld	b, a
	dec	bc
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
;src/joytest.c:70: draw_buttons(joypads.joypads[i], 0, 4 + (i << 1)); 
	xor	a, a
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	add	a, a
	add	a, #0x04
;src/joytest.c:69: if (i <= (joypads.npads - 1)) {
	ld	(hl-), a
	dec	hl
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00286$
	bit	7, d
	jr	NZ, 00287$
	cp	a, a
	jr	00287$
00286$:
	bit	7, d
	jr	Z, 00287$
	scf
00287$:
	jr	C, 00106$
;src/joytest.c:70: draw_buttons(joypads.joypads[i], 0, 4 + (i << 1)); 
	ld	bc, #_joypads + 1
	ldhl	sp,	#3
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	ldhl	sp,	#2
	ld	a, (hl)
	push	af
	inc	sp
	ld	e, #0x00
	ld	a, c
	call	_draw_buttons
	jr	00143$
00106$:
;src/joytest.c:72: draw_disabled(0, 4 + (i << 1));
	ldhl	sp,	#2
	ld	e, (hl)
	xor	a, a
	call	_draw_disabled
00143$:
;src/joytest.c:68: for (uint8_t i = 0; i != 4; i++) {
	ldhl	sp,	#3
	inc	(hl)
	jr	00142$
00108$:
;src/joytest.c:76: reset_object_pos();
	call	_reset_object_pos
;src/joytest.c:77: SHOW_SPRITES; SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x40
	ldh	(_LCDC_REG + 0), a
;src/joytest.c:79: while(TRUE) {
00132$:
;src/joytest.c:81: if (toggle = !toggle) {
	ld	hl, #_toggle
	ld	a, (hl)
	xor	a, #0x01
	ld	c, a
	ld	(hl), a
	bit	0, c
	jr	Z, 00129$
;src/joytest.c:83: if (!isSGB) {
	ld	hl, #_isSGB
	bit	0, (hl)
	jp	NZ, 00130$
;src/joytest.c:84: old_joy = joy, joy = joypad();
	ld	a, (#_joy)
	ld	(#_old_joy),a
	call	_joypad
	ld	hl, #_joy
	ld	(hl), a
;src/joytest.c:87: if (joy != old_joy) draw_buttons(joy, 0, 0);
	ld	a, (hl)
	ld	hl, #_old_joy
	sub	a, (hl)
	jr	Z, 00110$
	xor	a, a
	push	af
	inc	sp
	ld	e, #0x00
	ld	a, (#_joy)
	call	_draw_buttons
00110$:
;src/joytest.c:90: if (joy & J_START) reset_object_pos();
	ld	a, (#_joy)
	rlca
	jp	NC,00130$
	call	_reset_object_pos
	jp	00130$
00129$:
;src/joytest.c:93: old_joypads = joypads;
	ld	de, #0x0005
	push	de
	ld	bc, #_joypads
	ld	de, #_old_joypads
	call	___memcpy
;src/joytest.c:94: joypad_ex(&joypads);
	ld	de, #_joypads
	call	_joypad_ex
;src/joytest.c:96: for (uint8_t i = 0; i < joypads.npads; i++) {
	ld	c, #0x00
00145$:
	ld	hl, #_joypads
	ld	b, (hl)
	ld	a, c
	sub	a, b
	jr	NC, 00130$
;src/joytest.c:97: uint8_t j = joypads.joypads[i];
	ld	hl, #(_joypads + 1)
	ld	b, #0x00
	add	hl, bc
	ld	b, (hl)
;src/joytest.c:100: if (old_joypads.joypads[i] != j) draw_buttons(j, 0, 4 + (i << 1));
	ld	de, #_old_joypads + 1
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	a, (hl)
	sub	a, b
	jr	Z, 00116$
	ld	a, c
	add	a, a
	add	a, #0x04
	push	bc
	push	af
	inc	sp
	ld	e, #0x00
	ld	a, b
	call	_draw_buttons
	pop	bc
00116$:
;src/joytest.c:103: if (j & J_LEFT)  scroll_sprite(i, -1, 0);
	bit	1, b
	jr	Z, 00118$
;../../../include/gb/gb.h:1977: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, de
;../../../include/gb/gb.h:1978: itm->y+=y, itm->x+=x;
	ld	a, (hl)
	ld	(hl+), a
	dec	(hl)
	ld	a, (hl)
;src/joytest.c:103: if (j & J_LEFT)  scroll_sprite(i, -1, 0);
00118$:
;src/joytest.c:104: if (j & J_RIGHT) scroll_sprite(i, 1, 0);
	bit	0, b
	jr	Z, 00120$
;../../../include/gb/gb.h:1977: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, de
;../../../include/gb/gb.h:1978: itm->y+=y, itm->x+=x;
	ld	a, (hl)
	ld	(hl+), a
	inc	(hl)
	ld	a, (hl)
;src/joytest.c:104: if (j & J_RIGHT) scroll_sprite(i, 1, 0);
00120$:
;src/joytest.c:105: if (j & J_UP)    scroll_sprite(i, 0, -1);
	bit	2, b
	jr	Z, 00122$
;../../../include/gb/gb.h:1977: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, de
;../../../include/gb/gb.h:1978: itm->y+=y, itm->x+=x;
	ld	a, (hl)
	dec	a
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
;src/joytest.c:105: if (j & J_UP)    scroll_sprite(i, 0, -1);
00122$:
;src/joytest.c:106: if (j & J_DOWN)  scroll_sprite(i, 0, 1);
	bit	3, b
	jr	Z, 00124$
;../../../include/gb/gb.h:1977: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, de
;../../../include/gb/gb.h:1978: itm->y+=y, itm->x+=x;
	ld	a, (hl)
	inc	a
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
;src/joytest.c:106: if (j & J_DOWN)  scroll_sprite(i, 0, 1);
00124$:
;src/joytest.c:109: if (j & J_START) reset_object_pos();
	bit	7, b
	jr	Z, 00146$
	push	bc
	call	_reset_object_pos
	pop	bc
00146$:
;src/joytest.c:96: for (uint8_t i = 0; i < joypads.npads; i++) {
	inc	c
	jr	00145$
00130$:
;src/joytest.c:113: vsync();
	call	_vsync
	jp	00132$
;src/joytest.c:115: }
	add	sp, #4
	ret
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
