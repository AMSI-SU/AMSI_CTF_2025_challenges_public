;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module bcd
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
	.globl _main
	.globl _bcd2text
	.globl _bcd_sub
	.globl _bcd_add
	.globl _uint2bcd
	.globl _font_set
	.globl _font_load
	.globl _font_init
	.globl _set_bkg_tiles
	.globl _len
	.globl _bcd3
	.globl _bcd2
	.globl _bcd
	.globl _buf
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
_buf::
	.ds 10
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS    (ABS)
;--------------------------------------------------------
; initialized external ram data
;--------------------------------------------------------
	.area _DATA
_bcd::
	.ds 4
_bcd2::
	.ds 4
_bcd3::
	.ds 4
_len::
	.ds 1
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
;	src/bcd.c: 15: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/bcd.c: 16: font_init();
	jsr	_font_init
;	src/bcd.c: 17: font_set(font_load(font_spect));
	ldx	#>_font_spect
	lda	#_font_spect
	jsr	_font_load
	jsr	_font_set
;	src/bcd.c: 19: len = bcd2text(&bcd, 0x10, buf);
	lda	#>_buf
	sta	(_bcd2text_PARM_3 + 1)
	lda	#_buf
	sta	_bcd2text_PARM_3
	ldx	#0x10
	stx	_bcd2text_PARM_2
	ldx	#>_bcd
	lda	#_bcd
	jsr	_bcd2text
	sta	_len
;	src/bcd.c: 20: set_bkg_tiles(5, 5, len, 1, buf);
	ldx	#>_buf
	stx	(_set_bkg_tiles_PARM_5 + 1)
	ldx	#_buf
	stx	_set_bkg_tiles_PARM_5
	sta	_set_bkg_tiles_PARM_3
	ldx	#0x01
	stx	_set_bkg_tiles_PARM_4
	lda	#0x05
	tax
	jsr	_set_bkg_tiles
;	src/bcd.c: 22: bcd_add(&bcd, &bcd2);
	lda	#>_bcd2
	sta	(_bcd_add_PARM_2 + 1)
	lda	#_bcd2
	sta	_bcd_add_PARM_2
	ldx	#>_bcd
	lda	#_bcd
	jsr	_bcd_add
;	src/bcd.c: 24: len = bcd2text(&bcd, 0x10, buf);
	lda	#>_buf
	sta	(_bcd2text_PARM_3 + 1)
	lda	#_buf
	sta	_bcd2text_PARM_3
	ldx	#0x10
	stx	_bcd2text_PARM_2
	ldx	#>_bcd
	lda	#_bcd
	jsr	_bcd2text
	sta	_len
;	src/bcd.c: 25: set_bkg_tiles(5, 6, len, 1, buf);
	ldx	#>_buf
	stx	(_set_bkg_tiles_PARM_5 + 1)
	ldx	#_buf
	stx	_set_bkg_tiles_PARM_5
	sta	_set_bkg_tiles_PARM_3
	ldx	#0x01
	stx	_set_bkg_tiles_PARM_4
	lda	#0x05
	ldx	#0x06
	jsr	_set_bkg_tiles
;	src/bcd.c: 27: bcd_sub(&bcd, &bcd3);
	lda	#>_bcd3
	sta	(_bcd_sub_PARM_2 + 1)
	lda	#_bcd3
	sta	_bcd_sub_PARM_2
	ldx	#>_bcd
	lda	#_bcd
	jsr	_bcd_sub
;	src/bcd.c: 29: len = bcd2text(&bcd, 0x10, buf);
	lda	#>_buf
	sta	(_bcd2text_PARM_3 + 1)
	lda	#_buf
	sta	_bcd2text_PARM_3
	ldx	#0x10
	stx	_bcd2text_PARM_2
	ldx	#>_bcd
	lda	#_bcd
	jsr	_bcd2text
	sta	_len
;	src/bcd.c: 30: set_bkg_tiles(5, 7, len, 1, buf);
	ldx	#>_buf
	stx	(_set_bkg_tiles_PARM_5 + 1)
	ldx	#_buf
	stx	_set_bkg_tiles_PARM_5
	sta	_set_bkg_tiles_PARM_3
	ldx	#0x01
	stx	_set_bkg_tiles_PARM_4
	lda	#0x05
	ldx	#0x07
	jsr	_set_bkg_tiles
;	src/bcd.c: 32: uint2bcd(12345, &bcd);
	lda	#>_bcd
	sta	(_uint2bcd_PARM_2 + 1)
	lda	#_bcd
	sta	_uint2bcd_PARM_2
	ldx	#0x30
	lda	#0x39
	jsr	_uint2bcd
;	src/bcd.c: 34: len = bcd2text(&bcd, 0x10, buf);
	lda	#>_buf
	sta	(_bcd2text_PARM_3 + 1)
	lda	#_buf
	sta	_bcd2text_PARM_3
	ldx	#0x10
	stx	_bcd2text_PARM_2
	ldx	#>_bcd
	lda	#_bcd
	jsr	_bcd2text
	sta	_len
;	src/bcd.c: 35: set_bkg_tiles(5, 8, len, 1, buf);
	ldx	#>_buf
	stx	(_set_bkg_tiles_PARM_5 + 1)
	ldx	#_buf
	stx	_set_bkg_tiles_PARM_5
	sta	_set_bkg_tiles_PARM_3
	ldx	#0x01
	stx	_set_bkg_tiles_PARM_4
	lda	#0x05
	ldx	#0x08
;	src/bcd.c: 36: }
	jmp	_set_bkg_tiles
	.area _CODE
	.area _XINIT
__xinit__bcd:
	.byte #0x40, #0x30, #0x20, #0x10	; 270544960
__xinit__bcd2:
	.byte #0x08, #0x07, #0x06, #0x05	; 84281096
__xinit__bcd3:
	.byte #0x11, #0x11, #0x11, #0x11	; 286331153
__xinit__len:
	.db #0x00	; 0
	.area _CABS    (ABS)
