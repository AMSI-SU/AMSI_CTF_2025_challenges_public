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
	.globl _gb_decompress
	.globl _set_tile_map_compat
	.globl _set_tile_2bpp_data
	.globl _vsync
	.globl _buffer
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
;src/main.c:19: __WRITE_VDP_REG(VDP_R2, R2_MAP_0x3800);
	ld	iy, #_shadow_VDP_R2
	ld	0 (iy), #0xff
	di
	ld	a, #0xff
	out	(_VDP_CMD), a
	ld	a, #0x82
	out	(_VDP_CMD), a
	ei
;src/main.c:20: __WRITE_VDP_REG(VDP_R5, R5_SAT_0x3F00);
	ld	iy, #_shadow_VDP_R5
	ld	0 (iy), #0xff
	di
	ld	a, #0xff
	out	(_VDP_CMD), a
	ld	a, #0x85
	out	(_VDP_CMD), a
	ei
;src/main.c:29: set_bkg_data(0, gb_decompress(monalisa_tiles_comp, buffer) >> 4, buffer);
	ld	de, #_buffer+0
	ld	c, e
	ld	b, d
	push	de
	ld	hl, #_monalisa_tiles_comp
	push	hl
	call	_gb_decompress
	ex	de, hl
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
;../../../include/sms/sms.h:633: set_tile_2bpp_data(start, ntiles, src, _current_2bpp_palette);
	ld	hl, (__current_2bpp_palette)
	push	hl
	push	bc
	push	de
	ld	hl, #0x0000
	push	hl
	call	_set_tile_2bpp_data
;src/main.c:32: set_bkg_tiles(0,0, monalisa_mapWidth, monalisa_mapHeight, monalisa_mapPLN0);
	ld	hl, #_monalisa_mapPLN0
	push	hl
	ld	hl, #0x1214
	push	hl
	ld	hl, #0x00
	push	hl
	call	_set_tile_map_compat
;src/main.c:36: while(1) {
00102$:
;src/main.c:41: vsync();
	call	_vsync
;src/main.c:43: }
	jr	00102$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
