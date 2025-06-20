;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl b___func_map_compressed
	.globl ___func_map_compressed
	.globl b___func_map_tiles
	.globl ___func_map_tiles
	.globl _rle_decompress
	.globl _rle_init
	.globl _set_tile_map_compat
	.globl _set_tile_2bpp_data
	.globl _vsync
	.globl _datapos
	.globl _scrollpos
	.globl _data
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
_data::
	.ds 18
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_scrollpos::
	.ds 1
_datapos::
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
;src/main.c:8: INCBIN(map_tiles, "res/map_tiles.bin")
;	---------------------------------
; Function __func_map_tiles
; ---------------------------------
	b___func_map_tiles	= 0
___func_map_tiles::
_map_tiles::
1$:
	.incbin "res/map_tiles.bin" 
2$:
	___size_map_tiles = (2$-1$) 
	.globl ___size_map_tiles 
	.local b___func_map_tiles 
	___bank_map_tiles = b___func_map_tiles 
	.globl ___bank_map_tiles 
;src/main.c:15: INCBIN(map_compressed, "res/map.bin.rle")
;	---------------------------------
; Function __func_map_compressed
; ---------------------------------
	b___func_map_compressed	= 0
___func_map_compressed::
_map_compressed::
1$:
	.incbin "res/map.bin.rle" 
2$:
	___size_map_compressed = (2$-1$) 
	.globl ___size_map_compressed 
	.local b___func_map_compressed 
	___bank_map_compressed = b___func_map_compressed 
	.globl ___bank_map_compressed 
;src/main.c:22: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;src/main.c:33: set_bkg_data(0, INCBIN_SIZE(map_tiles) >> 4, map_tiles);
	ld	de, #_map_tiles+0
	ld	bc, #___size_map_tiles+0
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
;../../../include/sms/sms.h:633: set_tile_2bpp_data(start, ntiles, src, _current_2bpp_palette);
	ld	hl, (__current_2bpp_palette)
	push	hl
	push	de
	push	bc
	ld	hl, #0x0000
	push	hl
	call	_set_tile_2bpp_data
;src/main.c:36: rle_init(map_compressed);
	ld	hl, #_map_compressed
	call	_rle_init
;src/main.c:41: for (uint8_t i = 0; (i != DEVICE_SCREEN_WIDTH + 1); i++) {
	ld	-1 (ix), #0x00
00114$:
	ld	a, -1 (ix)
	sub	a, #0x15
	jr	Z, 00103$
;src/main.c:42: rle_decompress(data, MAP_DATA_HEIGHT);
	ld	a, #0x12
	push	af
	inc	sp
	ld	hl, #_data
	push	hl
	call	_rle_decompress
;src/main.c:47: set_bkg_tiles(i & (DEVICE_SCREEN_BUFFER_WIDTH-1), 0, 1, MAP_DATA_HEIGHT, data);
	ld	bc, #_data
	ld	a, -1 (ix)
	and	a, #0x1f
	push	bc
	ld	h, #0x12
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x01
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_tile_map_compat
;src/main.c:41: for (uint8_t i = 0; (i != DEVICE_SCREEN_WIDTH + 1); i++) {
	inc	-1 (ix)
	jr	00114$
00103$:
;src/main.c:51: datapos = 0;
	ld	hl, #_datapos
	ld	(hl), #0x00
;src/main.c:52: scrollpos = 1;
	ld	hl, #_scrollpos
	ld	(hl), #0x01
;src/main.c:53: while(TRUE) {
00109$:
;src/main.c:55: vsync();
	call	_vsync
;src/main.c:60: scrollpos++;
	ld	iy, #_scrollpos
	inc	0 (iy)
;src/main.c:61: move_bkg(scrollpos, 0);
	ld	a, (_scrollpos+0)
;../../../include/sms/sms.h:223: __WRITE_VDP_REG(VDP_RSCX, -x);
	ld	hl, #_shadow_VDP_RSCX
	neg
	ld	(hl), a
	di
	ld	a, (_shadow_VDP_RSCX+0)
	out	(_VDP_CMD), a
	ld	a, #0x88
	out	(_VDP_CMD), a
	ei
;../../../include/sms/sms.h:224: __WRITE_VDP_REG(VDP_RSCY, y);
	ld	iy, #_shadow_VDP_RSCY
	ld	0 (iy), #0x00
	di
	ld	a, #0x00
	out	(_VDP_CMD), a
	ld	a, #0x89
	out	(_VDP_CMD), a
	ei
;src/main.c:65: if ((scrollpos & 0x07u) == 0) {
	ld	a, (_scrollpos+0)
	and	a, #0x07
	jr	NZ, 00109$
;src/main.c:69: datapos = (scrollpos >> 3);
	ld	a, (_scrollpos+0)
	rrca
	rrca
	rrca
	and	a, #0x1f
	ld	(_datapos+0), a
;src/main.c:70: uint8_t map_x_column = (datapos + DEVICE_SCREEN_WIDTH) & (DEVICE_SCREEN_BUFFER_WIDTH-1);
	ld	a, (_datapos+0)
	add	a, #0x14
	and	a, #0x1f
	ld	-1 (ix), a
;src/main.c:75: if (!rle_decompress(data, MAP_DATA_HEIGHT)) {
	ld	a, #0x12
	push	af
	inc	sp
	ld	hl, #_data
	push	hl
	call	_rle_decompress
	ld	a, l
	or	a, a
	jr	NZ, 00105$
;src/main.c:76: rle_init(map_compressed);
	ld	hl, #_map_compressed
	call	_rle_init
;src/main.c:77: rle_decompress(data, MAP_DATA_HEIGHT);
	ld	a, #0x12
	push	af
	inc	sp
	ld	hl, #_data
	push	hl
	call	_rle_decompress
00105$:
;src/main.c:83: set_bkg_tiles(map_x_column, 0, 1, MAP_DATA_HEIGHT, data);
	ld	hl, #_data
	push	hl
	ld	hl, #0x1201
	push	hl
	xor	a, a
	push	af
	inc	sp
	ld	a, -1 (ix)
	push	af
	inc	sp
	call	_set_tile_map_compat
	jp	00109$
;src/main.c:86: }
	inc	sp
	pop	ix
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__scrollpos:
	.db #0x00	; 0
__xinit__datapos:
	.db #0x00	; 0
	.area _CABS (ABS)
