;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module main
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
	.globl _fill_bkg_rect
	.globl _set_bkg_native_data
	.globl _set_bkg_attributes_nes16x16
	.globl _set_bkg_tiles
	.globl _display_off
	.globl _display_on
	.globl _vsync
	.globl _set_bkg_palette
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
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS    (ABS)
;--------------------------------------------------------
; initialized external ram data
;--------------------------------------------------------
	.area _DATA
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
;__200000006               Allocated to registers 
;__200000007               Allocated to registers 
;__200000008               Allocated to registers 
;__200000009               Allocated to registers 
;__200000010               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;w                         Allocated to registers 
;h                         Allocated to registers 
;attributes                Allocated to registers 
;------------------------------------------------------------
;	src/main.c: 5: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/main.c: 6: DISPLAY_OFF;
	jsr	_display_off
;	src/main.c: 7: fill_bkg_rect(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, 0);
	ldx	#0x20
	stx	_fill_bkg_rect_PARM_3
	ldx	#0x1e
	stx	_fill_bkg_rect_PARM_4
	ldx	#0x00
	stx	_fill_bkg_rect_PARM_5
	txa
	jsr	_fill_bkg_rect
;	src/main.c: 16: set_bkg_palette(0, GBDK_2020_logo_PALETTE_COUNT, GBDK_2020_logo_palettes);
	lda	#>_GBDK_2020_logo_palettes
	sta	(_set_bkg_palette_PARM_3 + 1)
	lda	#_GBDK_2020_logo_palettes
	sta	_set_bkg_palette_PARM_3
	lda	#0x00
	ldx	#0x03
	jsr	_set_bkg_palette
;	src/main.c: 19: set_bkg_native_data(0, GBDK_2020_logo_TILE_COUNT, GBDK_2020_logo_tiles);
	lda	#>_GBDK_2020_logo_tiles
	sta	(_set_bkg_native_data_PARM_3 + 1)
	lda	#_GBDK_2020_logo_tiles
	sta	_set_bkg_native_data_PARM_3
	lda	#0x00
	ldx	#0x28
	jsr	_set_bkg_native_data
;	src/main.c: 25: GBDK_2020_logo_map_attributes);
	lda	#>_GBDK_2020_logo_map_attributes
	sta	(_set_bkg_attributes_nes16x16_PARM_5 + 1)
	lda	#_GBDK_2020_logo_map_attributes
	sta	_set_bkg_attributes_nes16x16_PARM_5
;	../../../include/nes/nes.h: 690: set_bkg_attributes_nes16x16(x >> 1, y >> 1, (w + 1) >> 1, (h + 1) >> 1, attributes);
	ldx	#0x0a
	stx	_set_bkg_attributes_nes16x16_PARM_3
	dex
	stx	_set_bkg_attributes_nes16x16_PARM_4
	lda	#0x03
	tax
	jsr	_set_bkg_attributes_nes16x16
;	src/main.c: 31: GBDK_2020_logo_map);
	lda	#>_GBDK_2020_logo_map
	sta	(_set_bkg_tiles_PARM_5 + 1)
	lda	#_GBDK_2020_logo_map
	sta	_set_bkg_tiles_PARM_5
	ldx	#0x14
	stx	_set_bkg_tiles_PARM_3
	ldx	#0x12
	stx	_set_bkg_tiles_PARM_4
	lda	#0x06
	tax
	jsr	_set_bkg_tiles
;	src/main.c: 33: vsync();
	jsr	_vsync
;	src/main.c: 34: SHOW_BKG;
	lda	_shadow_PPUMASK
	ora	#0x08
	sta	_shadow_PPUMASK
;	src/main.c: 35: DISPLAY_ON;
;	src/main.c: 36: }
	jmp	_display_on
	.area _CODE
	.area _XINIT
	.area _CABS    (ABS)
