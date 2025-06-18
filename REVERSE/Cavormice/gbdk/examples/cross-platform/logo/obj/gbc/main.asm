;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _set_bkg_palette
	.globl _fill_bkg_rect
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _display_off
	.globl _vsync
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
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
;src/main.c:5: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:6: DISPLAY_OFF;
	call	_display_off
;src/main.c:7: fill_bkg_rect(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, 0);
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
;src/main.c:12: if (_cpu == CGB_TYPE) {
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	NZ, 00102$
;src/main.c:13: set_bkg_palette(BKGF_CGB_PAL0, GBDK_2020_logo_PALETTE_COUNT, GBDK_2020_logo_palettes);
	ld	de, #_GBDK_2020_logo_palettes
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_bkg_palette
	add	sp, #4
00102$:
;src/main.c:19: set_bkg_native_data(0, GBDK_2020_logo_TILE_COUNT, GBDK_2020_logo_tiles);
;../../../include/gb/gb.h:2156: set_bkg_data(first_tile, nb_tiles, data);
	ld	de, #_GBDK_2020_logo_tiles
	push	de
	ld	hl, #0x2900
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/main.c:25: GBDK_2020_logo_map_attributes);
;../../../include/gb/gb.h:1226: VBK_REG = VBK_ATTRIBUTES;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;../../../include/gb/gb.h:1227: set_bkg_tiles(x, y, w, h, tiles);
	ld	de, #_GBDK_2020_logo_map_attributes
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;../../../include/gb/gb.h:1228: VBK_REG = VBK_TILES;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;src/main.c:31: GBDK_2020_logo_map);
;src/main.c:27: set_tile_map((DEVICE_SCREEN_WIDTH - (GBDK_2020_logo_WIDTH >> 3)) >> 1,
	ld	de, #_GBDK_2020_logo_map
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:33: vsync();
	call	_vsync
;src/main.c:34: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:35: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/main.c:36: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
