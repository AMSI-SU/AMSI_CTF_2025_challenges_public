;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module bcd
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _bcd2text
	.globl _bcd_sub
	.globl _bcd_add
	.globl _uint2bcd
	.globl _font_set
	.globl _font_load
	.globl _font_init
	.globl _set_tile_map_compat
	.globl _len
	.globl _bcd3
	.globl _bcd2
	.globl _bcd
	.globl _buf
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
_buf::
	.ds 10
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_bcd::
	.ds 4
_bcd2::
	.ds 4
_bcd3::
	.ds 4
_len::
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
;src/bcd.c:15: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/bcd.c:16: font_init();
	call	_font_init
;src/bcd.c:17: font_set(font_load(font_spect));
	ld	hl, #_font_spect
	push	hl
	call	_font_load
	ex	(sp),hl
	call	_font_set
;src/bcd.c:19: len = bcd2text(&bcd, 0x10, buf);
	ld	hl, #_buf
	ex	(sp),hl
	ld	a, #0x10
	push	af
	inc	sp
	ld	hl, #_bcd
	call	_bcd2text
	ld	(_len+0), a
;src/bcd.c:20: set_bkg_tiles(5, 5, len, 1, buf);
	ld	hl, #_buf
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	ld	a, (_len+0)
	ld	h, a
	ld	l, #0x05
	push	hl
	ld	a, #0x05
	push	af
	inc	sp
	call	_set_tile_map_compat
;src/bcd.c:22: bcd_add(&bcd, &bcd2);
	ld	de, #_bcd2
	ld	hl, #_bcd
	call	_bcd_add
;src/bcd.c:24: len = bcd2text(&bcd, 0x10, buf);
	ld	hl, #_buf
	push	hl
	ld	a, #0x10
	push	af
	inc	sp
	ld	hl, #_bcd
	call	_bcd2text
	ld	(_len+0), a
;src/bcd.c:25: set_bkg_tiles(5, 6, len, 1, buf);
	ld	hl, #_buf
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	ld	a, (_len+0)
	ld	h, a
	ld	l, #0x06
	push	hl
	ld	a, #0x05
	push	af
	inc	sp
	call	_set_tile_map_compat
;src/bcd.c:27: bcd_sub(&bcd, &bcd3);
	ld	de, #_bcd3
	ld	hl, #_bcd
	call	_bcd_sub
;src/bcd.c:29: len = bcd2text(&bcd, 0x10, buf);
	ld	hl, #_buf
	push	hl
	ld	a, #0x10
	push	af
	inc	sp
	ld	hl, #_bcd
	call	_bcd2text
	ld	(_len+0), a
;src/bcd.c:30: set_bkg_tiles(5, 7, len, 1, buf);
	ld	hl, #_buf
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	ld	a, (_len+0)
	ld	h, a
	ld	l, #0x07
	push	hl
	ld	a, #0x05
	push	af
	inc	sp
	call	_set_tile_map_compat
;src/bcd.c:32: uint2bcd(12345, &bcd);
	ld	de, #_bcd
	ld	hl, #0x3039
	call	_uint2bcd
;src/bcd.c:34: len = bcd2text(&bcd, 0x10, buf);
	ld	hl, #_buf
	push	hl
	ld	a, #0x10
	push	af
	inc	sp
	ld	hl, #_bcd
	call	_bcd2text
	ld	(_len+0), a
;src/bcd.c:35: set_bkg_tiles(5, 8, len, 1, buf);
	ld	hl, #_buf
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	ld	a, (_len+0)
	ld	h, a
	ld	l, #0x08
	push	hl
	ld	a, #0x05
	push	af
	inc	sp
	call	_set_tile_map_compat
;src/bcd.c:36: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__bcd:
	.byte #0x40, #0x30, #0x20, #0x10	; 270544960
__xinit__bcd2:
	.byte #0x08, #0x07, #0x06, #0x05	; 84281096
__xinit__bcd3:
	.byte #0x11, #0x11, #0x11, #0x11	; 286331153
__xinit__len:
	.db #0x00	; 0
	.area _CABS (ABS)
