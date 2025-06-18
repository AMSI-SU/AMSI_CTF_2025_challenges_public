;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module large_map
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _init_camera
	.globl _set_camera
	.globl _set_bkg_palette
	.globl _set_bkg_submap
	.globl _set_bkg_data
	.globl _display_off
	.globl _vsync
	.globl _joypad
	.globl _redraw
	.globl _old_map_pos_y
	.globl _old_map_pos_x
	.globl _map_pos_y
	.globl _map_pos_x
	.globl _old_camera_y
	.globl _old_camera_x
	.globl _camera_y
	.globl _camera_x
	.globl _joy
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_joy::
	.ds 1
_camera_x::
	.ds 2
_camera_y::
	.ds 2
_old_camera_x::
	.ds 2
_old_camera_y::
	.ds 2
_map_pos_x::
	.ds 1
_map_pos_y::
	.ds 1
_old_map_pos_x::
	.ds 1
_old_map_pos_y::
	.ds 1
_redraw::
	.ds 1
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
;src/large_map.c:82: void set_camera(void)
;	---------------------------------
; Function set_camera
; ---------------------------------
_set_camera::
	dec	sp
	dec	sp
;src/large_map.c:85: move_bkg(camera_x, WRAP_SCROLL_Y(camera_y + SCROLL_Y_OFFSET));
	ld	hl, #_camera_y
	ld	c, (hl)
	ld	a, (#_camera_x)
	ldh	(_SCX_REG + 0), a
;../../../include/gb/gb.h:1449: SCX_REG=x, SCY_REG=y;
	ld	a, c
	ldh	(_SCY_REG + 0), a
;src/large_map.c:87: map_pos_y = (uint8_t)(camera_y >> 3u);
	ld	hl, #_camera_y
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ld	hl, #_map_pos_y
	ld	(hl), c
;src/large_map.c:88: if (map_pos_y != old_map_pos_y)
	ld	a, (hl)
	ld	hl, #_old_map_pos_y
	sub	a, (hl)
	jp	Z,00107$
;src/large_map.c:92: set_submap_indices(
	ld	hl, #_map_pos_x
	ld	b, (hl)
	ld	e, #0x00
	ld	a, #0x9c
	sub	a, (hl)
	ld	c, a
	ld	a, (#_map_pos_y)
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, #0x9c
	sub	a, b
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	sbc	a, a
	sub	a, e
	ld	b, a
	ld	e, b
	ld	d, #0x00
	ld	a, #0x15
	cp	a, l
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00245$
	bit	7, d
	jr	NZ, 00246$
	cp	a, a
	jr	00246$
00245$:
	bit	7, d
	jr	Z, 00246$
	scf
00246$:
	ld	a, #0x00
	rla
	ldhl	sp,	#1
	ld	(hl), a
;src/large_map.c:90: if (camera_y < old_camera_y)
	ld	de, #_camera_y
	ld	hl, #_old_camera_y
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	NC, 00104$
;src/large_map.c:92: set_submap_indices(
	ld	de, #_bigmap_map+0
	ldhl	sp,	#1
	ld	a, (hl)
	or	a, a
	jr	Z, 00130$
	ld	a, #0x15
	jr	00131$
00130$:
	ld	a, c
00131$:
	ld	h, #0x9c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	de
	ld	h, #0x01
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	ld	a, (#_map_pos_x)
	push	af
	inc	sp
	call	_set_bkg_submap
	add	sp, #7
;src/large_map.c:99: set_submap_attributes(
	ld	bc, #_bigmap_map_attributes+0
	ld	hl, #_map_pos_x
	ld	e, (hl)
	ld	d, #0x00
	ld	a, #0x9c
	sub	a, e
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	sbc	a, a
	sub	a, d
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	e, h
	ld	d, #0x00
	ld	a, #0x15
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	bit	7, e
	jr	Z, 00247$
	bit	7, d
	jr	NZ, 00248$
	cp	a, a
	jr	00248$
00247$:
	bit	7, d
	jr	Z, 00248$
	scf
00248$:
	jr	NC, 00132$
	ld	d, #0x15
	jr	00133$
00132$:
	ld	a, #0x9c
	ld	hl, #_map_pos_x
	sub	a, (hl)
	ld	d, a
00133$:
	ld	hl, #_map_pos_y
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, (_map_pos_x)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
;../../../include/gb/gb.h:1358: VBK_REG = VBK_ATTRIBUTES;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;../../../include/gb/gb.h:1359: set_bkg_submap(x, y, w, h, map, map_w);
	ld	a, #0x9c
	push	af
	inc	sp
	push	bc
	ld	a, #0x01
	push	af
	inc	sp
	ld	e, h
	push	de
	ld	a, l
	push	af
	inc	sp
	call	_set_bkg_submap
	add	sp, #7
;../../../include/gb/gb.h:1360: VBK_REG = VBK_TILES;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;src/large_map.c:99: set_submap_attributes(
	jp	00105$
00104$:
;src/large_map.c:109: if ((bigmap_mapHeight - DEVICE_SCREEN_HEIGHT) > map_pos_y)
	ld	a, (#_map_pos_y)
	sub	a, #0x30
	jp	NC, 00105$
;src/large_map.c:111: set_submap_indices(
	ldhl	sp,	#1
	ld	a, (hl)
	or	a, a
	jr	Z, 00134$
	ld	b, #0x15
	jr	00135$
00134$:
	ld	b, c
00135$:
;src/large_map.c:79: return map_pos_y + DEVICE_SCREEN_HEIGHT;
	ldhl	sp,	#0
	ld	a, (hl)
	add	a, #0x12
;src/large_map.c:111: set_submap_indices(
	ld	h, #0x9c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	de, #_bigmap_map
	push	de
	ld	h, #0x01
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	push	hl
	push	af
	inc	sp
	ld	a, (#_map_pos_x)
	push	af
	inc	sp
	call	_set_bkg_submap
	add	sp, #7
;src/large_map.c:118: set_submap_attributes(
	ld	hl, #_map_pos_x
	ld	c, (hl)
	ld	b, #0x00
	ld	a, #0x9c
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
	ld	e, b
	ld	d, #0x00
	ld	a, #0x15
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00249$
	bit	7, d
	jr	NZ, 00250$
	cp	a, a
	jr	00250$
00249$:
	bit	7, d
	jr	Z, 00250$
	scf
00250$:
	jr	NC, 00136$
	ld	d, #0x15
	jr	00137$
00136$:
	ld	a, #0x9c
	ld	hl, #_map_pos_x
	sub	a, (hl)
	ld	d, a
00137$:
	ld	a, (#_map_pos_y)
;src/large_map.c:79: return map_pos_y + DEVICE_SCREEN_HEIGHT;
	add	a, #0x12
	ld	c, a
;src/large_map.c:118: set_submap_attributes(
	ld	hl, #_map_pos_x
	ld	b, (hl)
;../../../include/gb/gb.h:1358: VBK_REG = VBK_ATTRIBUTES;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;../../../include/gb/gb.h:1359: set_bkg_submap(x, y, w, h, map, map_w);
	ld	a, #0x9c
	push	af
	inc	sp
	ld	hl, #_bigmap_map_attributes
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	ld	e, c
	push	de
	push	bc
	inc	sp
	call	_set_bkg_submap
	add	sp, #7
;../../../include/gb/gb.h:1360: VBK_REG = VBK_TILES;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;src/large_map.c:118: set_submap_attributes(
00105$:
;src/large_map.c:127: old_map_pos_y = map_pos_y; 
	ld	a, (#_map_pos_y)
	ld	(#_old_map_pos_y),a
00107$:
;src/large_map.c:130: map_pos_x = (uint8_t)(camera_x >> 3u);
	ld	hl, #_camera_x
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ld	hl, #_map_pos_x
	ld	(hl), c
;src/large_map.c:131: if (map_pos_x != old_map_pos_x)
	ld	a, (hl)
	ld	hl, #_old_map_pos_x
	sub	a, (hl)
	jp	Z,00114$
;src/large_map.c:99: set_submap_attributes(
	ld	hl, #_map_pos_x
	ld	c, (hl)
;src/large_map.c:135: set_submap_indices(
	ld	hl, #_map_pos_y
	ld	b, (hl)
	ld	e, #0x00
	ld	a, #0x42
	sub	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, #0x42
	sub	a, b
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	sbc	a, a
	sub	a, e
	ld	b, a
	ld	e, b
	ld	d, #0x00
	ld	a, #0x13
	cp	a, l
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00252$
	bit	7, d
	jr	NZ, 00253$
	cp	a, a
	jr	00253$
00252$:
	bit	7, d
	jr	Z, 00253$
	scf
00253$:
	ld	a, #0x00
	rla
	ldhl	sp,	#1
	ld	(hl), a
;src/large_map.c:133: if (camera_x < old_camera_x)
	ld	de, #_camera_x
	ld	hl, #_old_camera_x
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	NC, 00111$
;src/large_map.c:135: set_submap_indices(
	ldhl	sp,	#1
	ld	a, (hl)
	or	a, a
	jr	Z, 00138$
	ld	a, #0x13
	jr	00139$
00138$:
	ldhl	sp,	#0
	ld	a, (hl)
00139$:
	ld	h, #0x9c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	de, #_bigmap_map
	push	de
	ld	h, a
	ld	l, #0x01
	push	hl
	ld	a, (#_map_pos_y)
	ld	b, a
	push	bc
	call	_set_bkg_submap
	add	sp, #7
;src/large_map.c:142: set_submap_attributes(
	ld	hl, #_map_pos_y
	ld	c, (hl)
	ld	b, #0x00
	ld	a, #0x42
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
	ld	e, b
	ld	d, #0x00
	ld	a, #0x13
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00254$
	bit	7, d
	jr	NZ, 00255$
	cp	a, a
	jr	00255$
00254$:
	bit	7, d
	jr	Z, 00255$
	scf
00255$:
	jr	NC, 00140$
	ld	a, #0x13
	jr	00141$
00140$:
	ld	a, #0x42
	ld	hl, #_map_pos_y
	sub	a, (hl)
00141$:
	ld	hl, #_map_pos_y
	ld	c, (hl)
	ld	hl, #_map_pos_x
	ld	b, (hl)
;../../../include/gb/gb.h:1358: VBK_REG = VBK_ATTRIBUTES;
	push	af
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
	pop	af
;../../../include/gb/gb.h:1359: set_bkg_submap(x, y, w, h, map, map_w);
	ld	h, #0x9c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	de, #_bigmap_map_attributes
	push	de
	ld	h, a
	ld	l, #0x01
	push	hl
	ld	a, c
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_set_bkg_submap
	add	sp, #7
;../../../include/gb/gb.h:1360: VBK_REG = VBK_TILES;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;src/large_map.c:142: set_submap_attributes(
	jp	00112$
00111$:
;src/large_map.c:152: if ((bigmap_mapWidth - DEVICE_SCREEN_WIDTH) > map_pos_x)
	ld	a, (#_map_pos_x)
	sub	a, #0x88
	jp	NC, 00112$
;src/large_map.c:154: set_submap_indices(
	ldhl	sp,	#1
	ld	a, (hl)
	or	a, a
	jr	Z, 00142$
	ld	b, #0x13
	jr	00143$
00142$:
	ldhl	sp,	#0
	ld	b, (hl)
00143$:
;src/large_map.c:65: return map_pos_x + DEVICE_SCREEN_WIDTH;
	ld	a, c
	add	a, #0x14
;src/large_map.c:154: set_submap_indices(
	ld	h, #0x9c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	de, #_bigmap_map
	push	de
	push	bc
	inc	sp
	ld	h, #0x01
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	hl, #_map_pos_y
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_bkg_submap
	add	sp, #7
;src/large_map.c:161: set_submap_attributes(
	ld	hl, #_map_pos_y
	ld	c, (hl)
	ld	b, #0x00
	ld	a, #0x42
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
	ld	e, b
	ld	d, #0x00
	ld	a, #0x13
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00256$
	bit	7, d
	jr	NZ, 00257$
	cp	a, a
	jr	00257$
00256$:
	bit	7, d
	jr	Z, 00257$
	scf
00257$:
	jr	NC, 00144$
	ld	c, #0x13
	jr	00145$
00144$:
	ld	a, #0x42
	ld	hl, #_map_pos_y
	sub	a, (hl)
	ld	c, a
00145$:
	ld	hl, #_map_pos_y
	ld	e, (hl)
	ld	hl, #_map_pos_x
	ld	a, (hl)
;src/large_map.c:65: return map_pos_x + DEVICE_SCREEN_WIDTH;
	add	a, #0x14
;../../../include/gb/gb.h:1358: VBK_REG = VBK_ATTRIBUTES;
	push	af
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
	pop	af
;../../../include/gb/gb.h:1359: set_bkg_submap(x, y, w, h, map, map_w);
	ld	h, #0x9c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	hl, #_bigmap_map_attributes
	push	hl
	ld	h, c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x01
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, e
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_bkg_submap
	add	sp, #7
;../../../include/gb/gb.h:1360: VBK_REG = VBK_TILES;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;src/large_map.c:161: set_submap_attributes(
00112$:
;src/large_map.c:170: old_map_pos_x = map_pos_x;
	ld	a, (#_map_pos_x)
	ld	(#_old_map_pos_x),a
00114$:
;src/large_map.c:173: old_camera_x = camera_x, old_camera_y = camera_y;
	ld	a, (#_camera_x)
	ld	(#_old_camera_x),a
	ld	a, (#_camera_x + 1)
	ld	(#_old_camera_x + 1),a
	ld	a, (#_camera_y)
	ld	(#_old_camera_y),a
	ld	a, (#_camera_y + 1)
	ld	(#_old_camera_y + 1),a
;src/large_map.c:174: }
	inc	sp
	inc	sp
	ret
;src/large_map.c:177: void init_camera(uint8_t x, uint8_t y) {
;	---------------------------------
; Function init_camera
; ---------------------------------
_init_camera::
	ld	b, a
	ld	c, e
;src/large_map.c:180: set_native_tile_data(0, bigmap_TILE_COUNT, bigmap_tiles);
;../../../include/gb/gb.h:2134: set_bkg_data(first_tile, nb_tiles, data);
	ld	de, #_bigmap_tiles
	push	de
	ld	hl, #0xd200
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/large_map.c:188: if (_cpu == CGB_TYPE) {
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	NZ, 00102$
;src/large_map.c:189: set_bkg_palette(BKGF_CGB_PAL0, bigmap_PALETTE_COUNT, bigmap_palettes);
	push	bc
	ld	de, #_bigmap_palettes
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_bkg_palette
	add	sp, #4
	pop	bc
00102$:
;src/large_map.c:197: camera_x = x;
	ld	hl, #_camera_x
	ld	a, b
	ld	(hl+), a
	ld	(hl), #0x00
;src/large_map.c:198: camera_y = y;
	ld	hl, #_camera_y
	ld	a, c
	ld	(hl+), a
	ld	(hl), #0x00
;src/large_map.c:200: if (camera_x > camera_max_x) camera_x = camera_max_x;
	ld	hl, #_camera_x
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, #0x40
	cp	a, c
	ld	a, #0x04
	sbc	a, b
	jr	NC, 00104$
	dec	hl
	ld	a, #0x40
	ld	(hl+), a
	ld	(hl), #0x04
00104$:
;src/large_map.c:201: if (camera_y > camera_max_y) camera_y = camera_max_y;
	ld	hl, #_camera_y
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, #0x80
	cp	a, c
	ld	a, #0x01
	sbc	a, b
	jr	NC, 00106$
	dec	hl
	ld	a, #0x80
	ld	(hl+), a
	ld	(hl), #0x01
00106$:
;src/large_map.c:202: old_camera_x = camera_x; old_camera_y = camera_y;
	ld	a, (#_camera_x)
	ld	(#_old_camera_x),a
	ld	a, (#_camera_x + 1)
	ld	(#_old_camera_x + 1),a
	ld	a, (#_camera_y)
	ld	(#_old_camera_y),a
	ld	a, (#_camera_y + 1)
	ld	(#_old_camera_y + 1),a
;src/large_map.c:204: map_pos_x = camera_x >> 3;
	ld	hl, #_camera_x
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ld	hl, #_map_pos_x
	ld	(hl), c
;src/large_map.c:205: map_pos_y = camera_y >> 3;
	ld	hl, #_camera_y
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ld	hl, #_map_pos_y
	ld	(hl), c
;src/large_map.c:206: old_map_pos_x = old_map_pos_y = 255;
	ld	hl, #_old_map_pos_y
	ld	(hl), #0xff
	ld	hl, #_old_map_pos_x
	ld	(hl), #0xff
;src/large_map.c:207: move_bkg(camera_x, WRAP_SCROLL_Y(camera_y + SCROLL_Y_OFFSET));
	ld	hl, #_camera_y
	ld	c, (hl)
	ld	a, (#_camera_x)
	ldh	(_SCX_REG + 0), a
;../../../include/gb/gb.h:1449: SCX_REG=x, SCY_REG=y;
	ld	a, c
	ldh	(_SCY_REG + 0), a
;src/large_map.c:210: set_submap_indices(
	ld	bc, #_bigmap_map+0
	ld	hl, #_map_pos_y
	ld	e, (hl)
	ld	d, #0x00
	ld	a, #0x42
	sub	a, e
	ld	e, a
	sbc	a, a
	sub	a, d
	ld	d, a
	ld	a, #0x13
	cp	a, e
	ld	a, #0x00
	sbc	a, d
	jr	NC, 00116$
	ld	d, #0x13
	jr	00117$
00116$:
	ld	a, #0x42
	ld	hl, #_map_pos_y
	sub	a, (hl)
	ld	d, a
00117$:
	ld	hl, #_map_pos_x
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #0x9c
	sub	a, l
	ld	e, a
	sbc	a, a
	sub	a, h
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #0x15
	cp	a, e
	ld	a, #0x00
	sbc	a, l
	jr	NC, 00118$
	ld	a, #0x15
	jr	00119$
00118$:
	ld	a, #0x9c
	ld	hl, #_map_pos_x
	sub	a, (hl)
00119$:
	ld	h, #0x9c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	bc
	push	de
	inc	sp
	push	af
	inc	sp
	ld	a, (#_map_pos_y)
	ld	h, a
	ld	a, (#_map_pos_x)
	ld	l, a
	push	hl
	call	_set_bkg_submap
	add	sp, #7
;src/large_map.c:218: set_submap_attributes(
	ld	hl, #_map_pos_y
	ld	c, (hl)
	ld	b, #0x00
	ld	a, #0x42
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
	ld	a, #0x13
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	jr	NC, 00120$
	ld	c, #0x13
	jr	00121$
00120$:
	ld	a, #0x42
	ld	hl, #_map_pos_y
	sub	a, (hl)
	ld	c, a
00121$:
	ld	hl, #_map_pos_x
	ld	e, (hl)
	ld	d, #0x00
	ld	a, #0x9c
	sub	a, e
	ld	e, a
	sbc	a, a
	sub	a, d
	ld	b, a
	ld	a, #0x15
	cp	a, e
	ld	a, #0x00
	sbc	a, b
	jr	NC, 00122$
	ld	b, #0x15
	jr	00123$
00122$:
	ld	a, #0x9c
	ld	hl, #_map_pos_x
	sub	a, (hl)
	ld	b, a
00123$:
	ld	hl, #_map_pos_y
	ld	e, (hl)
	ld	hl, #_map_pos_x
	ld	d, (hl)
;../../../include/gb/gb.h:1358: VBK_REG = VBK_ATTRIBUTES;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;../../../include/gb/gb.h:1359: set_bkg_submap(x, y, w, h, map, map_w);
	ld	a, #0x9c
	push	af
	inc	sp
	ld	hl, #_bigmap_map_attributes
	push	hl
	ld	a, c
	push	af
	inc	sp
	ld	c, e
	push	bc
	push	de
	inc	sp
	call	_set_bkg_submap
	add	sp, #7
;../../../include/gb/gb.h:1360: VBK_REG = VBK_TILES;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;src/large_map.c:226: redraw = FALSE;
	ld	hl, #_redraw
	ld	(hl), #0x00
;src/large_map.c:228: move_bkg(camera_x, WRAP_SCROLL_Y(camera_y + SCROLL_Y_OFFSET));
	ld	hl, #_camera_y
	ld	c, (hl)
	ld	a, (#_camera_x)
	ldh	(_SCX_REG + 0), a
;../../../include/gb/gb.h:1449: SCX_REG=x, SCY_REG=y;
	ld	a, c
	ldh	(_SCY_REG + 0), a
;src/large_map.c:228: move_bkg(camera_x, WRAP_SCROLL_Y(camera_y + SCROLL_Y_OFFSET));
;src/large_map.c:235: }
	ret
;src/large_map.c:237: void main(void){
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/large_map.c:238: DISPLAY_OFF;
	call	_display_off
;src/large_map.c:239: init_camera(0, 0);
	xor	a, a
	ld	e, a
	call	_init_camera
;src/large_map.c:241: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/large_map.c:242: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/large_map.c:243: while (TRUE) {
00123$:
;src/large_map.c:244: joy = joypad();
	call	_joypad
	ld	hl, #_joy
	ld	(hl), a
;src/large_map.c:246: if (joy & J_UP) {
	ld	c, (hl)
	bit	2, c
	jr	Z, 00108$
;src/large_map.c:247: if (camera_y) {
	ld	hl, #_camera_y + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00109$
;src/large_map.c:248: camera_y--;
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/large_map.c:249: redraw = TRUE;
	ld	hl, #_redraw
	ld	(hl), #0x01
	jr	00109$
00108$:
;src/large_map.c:251: } else if (joy & J_DOWN) {
	bit	3, c
	jr	Z, 00109$
;src/large_map.c:252: if (camera_y < camera_max_y) {
	ld	hl, #_camera_y
	ld	a, (hl+)
	ld	e, (hl)
	sub	a, #0x80
	ld	a, e
	sbc	a, #0x01
	jr	NC, 00109$
;src/large_map.c:253: camera_y++;
	dec	hl
	inc	(hl)
	jr	NZ, 00199$
	inc	hl
	inc	(hl)
00199$:
;src/large_map.c:254: redraw = TRUE;
	ld	hl, #_redraw
	ld	(hl), #0x01
00109$:
;src/large_map.c:258: if (joy & J_LEFT) {
	bit	1, c
	jr	Z, 00117$
;src/large_map.c:259: if (camera_x) {
	ld	hl, #_camera_x + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00118$
;src/large_map.c:260: camera_x--;
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/large_map.c:261: redraw = TRUE;
	ld	hl, #_redraw
	ld	(hl), #0x01
	jr	00118$
00117$:
;src/large_map.c:263: } else if (joy & J_RIGHT) {
	bit	0, c
	jr	Z, 00118$
;src/large_map.c:264: if (camera_x < camera_max_x) {
	ld	hl, #_camera_x
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0x40
	ld	a, b
	sbc	a, #0x04
	jr	NC, 00118$
;src/large_map.c:265: camera_x++;
	dec	hl
	inc	(hl)
	jr	NZ, 00202$
	inc	hl
	inc	(hl)
00202$:
;src/large_map.c:266: redraw = TRUE;
	ld	hl, #_redraw
	ld	(hl), #0x01
00118$:
;src/large_map.c:269: if (redraw) {
	ld	a, (#_redraw)
	or	a, a
	jr	Z, 00120$
;src/large_map.c:270: vsync();
	call	_vsync
;src/large_map.c:271: set_camera();
	call	_set_camera
;src/large_map.c:272: redraw = FALSE;
	ld	hl, #_redraw
	ld	(hl), #0x00
	jp	00123$
00120$:
;src/large_map.c:273: } else vsync();
	call	_vsync
;src/large_map.c:275: }
	jp	00123$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
