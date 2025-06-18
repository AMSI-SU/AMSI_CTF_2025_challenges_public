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
	.globl _init_gfx
	.globl b___func_blank_tile_data
	.globl ___func_blank_tile_data
	.globl b___func_logo_map
	.globl ___func_logo_map
	.globl b___func_logo_tiles_data
	.globl ___func_logo_tiles_data
	.globl _fill_bkg_rect
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _vsync
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
;Allocation info for local variables in function '__func_logo_tiles_data'
;------------------------------------------------------------
;	src/main.c: 6: INCBIN(logo_tiles_data, "res/gbdk2020.bin") // Variable name to use, Path to file
;	-----------------------------------------
;	 function __func_logo_tiles_data
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
	b___func_logo_tiles_data	= 0
___func_logo_tiles_data:
;	naked function: no prologue.
		_logo_tiles_data::
	 1$:
	 .incbin "res/gbdk2020.bin" 
	 2$:
	 ___size_logo_tiles_data = (2$-1$) 
	 .globl ___size_logo_tiles_data 
	 .local b___func_logo_tiles_data 
	 ___bank_logo_tiles_data = b___func_logo_tiles_data 
	 .globl ___bank_logo_tiles_data 
;	naked function: no epilogue.
;------------------------------------------------------------
;Allocation info for local variables in function '__func_logo_map'
;------------------------------------------------------------
;	src/main.c: 9: INCBIN(logo_map, "res/gbdk2020_map.bin")
;	-----------------------------------------
;	 function __func_logo_map
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
	b___func_logo_map	= 0
___func_logo_map:
;	naked function: no prologue.
		_logo_map::
	 1$:
	 .incbin "res/gbdk2020_map.bin" 
	 2$:
	 ___size_logo_map = (2$-1$) 
	 .globl ___size_logo_map 
	 .local b___func_logo_map 
	 ___bank_logo_map = b___func_logo_map 
	 .globl ___bank_logo_map 
;	naked function: no epilogue.
;------------------------------------------------------------
;Allocation info for local variables in function '__func_blank_tile_data'
;------------------------------------------------------------
;	src/main.c: 12: INCBIN(blank_tile_data, "res/blanktile.bin")
;	-----------------------------------------
;	 function __func_blank_tile_data
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
	b___func_blank_tile_data	= 0
___func_blank_tile_data:
;	naked function: no prologue.
		_blank_tile_data::
	 1$:
	 .incbin "res/blanktile.bin" 
	 2$:
	 ___size_blank_tile_data = (2$-1$) 
	 .globl ___size_blank_tile_data 
	 .local b___func_blank_tile_data 
	 ___bank_blank_tile_data = b___func_blank_tile_data 
	 .globl ___bank_blank_tile_data 
;	naked function: no epilogue.
;------------------------------------------------------------
;Allocation info for local variables in function 'init_gfx'
;------------------------------------------------------------
;	src/main.c: 28: void init_gfx(void) {
;	-----------------------------------------
;	 function init_gfx
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_init_gfx:
;	src/main.c: 30: set_bkg_data(0x80u, 1u, blank_tile_data); // The first 0x80u here is the tile ID
	lda	#>_blank_tile_data
	sta	(_set_bkg_data_PARM_3 + 1)
	lda	#_blank_tile_data
	sta	_set_bkg_data_PARM_3
	lda	#0x80
	ldx	#0x01
	jsr	_set_bkg_data
;	src/main.c: 31: fill_bkg_rect(0u, 0u, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, 0x80u);   // The last 0x80u here is the tile ID 
	ldx	#0x20
	stx	_fill_bkg_rect_PARM_3
	ldx	#0x1e
	stx	_fill_bkg_rect_PARM_4
	ldx	#0x80
	stx	_fill_bkg_rect_PARM_5
	lda	#0x00
	tax
	jsr	_fill_bkg_rect
;	src/main.c: 35: set_bkg_data(0u, INCBIN_SIZE(logo_tiles_data) / TILE_BYTES, logo_tiles_data);
	ldx	#>___size_logo_tiles_data
	lda	#___size_logo_tiles_data
	stx	*(REGTEMP+0)
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	ldx	#>_logo_tiles_data
	stx	(_set_bkg_data_PARM_3 + 1)
	ldx	#_logo_tiles_data
	stx	_set_bkg_data_PARM_3
	tax
	lda	#0x00
	jsr	_set_bkg_data
;	src/main.c: 38: logo_map);
	lda	#>_logo_map
	sta	(_set_bkg_tiles_PARM_5 + 1)
	lda	#_logo_map
	sta	_set_bkg_tiles_PARM_5
	ldx	#0x07
	stx	_set_bkg_tiles_PARM_3
	ldx	#0x0c
	stx	_set_bkg_tiles_PARM_4
	lda	#0x06
	ldx	#0x03
	jsr	_set_bkg_tiles
;	src/main.c: 41: SHOW_BKG;
	lda	_shadow_PPUMASK
	ora	#0x08
	sta	_shadow_PPUMASK
;	src/main.c: 42: }
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;	src/main.c: 46: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/main.c: 48: init_gfx();
	jsr	_init_gfx
;	src/main.c: 51: while(1) {
00102$:
;	src/main.c: 56: vsync();
	jsr	_vsync
	jmp	00102$
;	src/main.c: 58: }
	rts
	.area _CODE
	.area _XINIT
	.area _CABS    (ABS)
