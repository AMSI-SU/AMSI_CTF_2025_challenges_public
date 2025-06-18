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
	.globl _gb_decompress
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _vsync
	.globl _buffer
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_buffer::
	.ds 4096
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
;src/main.c:16: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:29: set_bkg_data(0, gb_decompress(monalisa_tiles_comp, buffer) >> 4, buffer);
	ld	bc, #_buffer
	ld	de, #_monalisa_tiles_comp
	call	_gb_decompress
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ld	a, c
	ld	de, #_buffer
	push	de
	ld	h, a
	ld	l, #0x00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/main.c:32: set_bkg_tiles(0,0, monalisa_mapWidth, monalisa_mapHeight, monalisa_mapPLN0);
	ld	de, #_monalisa_mapPLN0
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:33: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:36: while(1) {
00102$:
;src/main.c:41: vsync();
	call	_vsync
;src/main.c:43: }
	jr	00102$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
