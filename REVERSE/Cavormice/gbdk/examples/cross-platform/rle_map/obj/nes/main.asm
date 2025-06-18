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
	.globl b___func_map_compressed
	.globl ___func_map_compressed
	.globl b___func_map_tiles
	.globl ___func_map_tiles
	.globl _rle_decompress
	.globl _rle_init
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _vsync
	.globl _datapos
	.globl _scrollpos
	.globl _data
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
_main_sloc0_1_0:
	.ds 1
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
_data::
	.ds 18
_main_map_x_column_30001_101:
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS    (ABS)
;--------------------------------------------------------
; initialized external ram data
;--------------------------------------------------------
	.area _DATA
_scrollpos::
	.ds 1
_datapos::
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
;Allocation info for local variables in function '__func_map_tiles'
;------------------------------------------------------------
;	src/main.c: 8: INCBIN(map_tiles, "res/map_tiles.bin")
;	-----------------------------------------
;	 function __func_map_tiles
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
	b___func_map_tiles	= 0
___func_map_tiles:
;	naked function: no prologue.
		_map_tiles::
	 1$:
	 .incbin "res/map_tiles.bin" 
	 2$:
	 ___size_map_tiles = (2$-1$) 
	 .globl ___size_map_tiles 
	 .local b___func_map_tiles 
	 ___bank_map_tiles = b___func_map_tiles 
	 .globl ___bank_map_tiles 
;	naked function: no epilogue.
;------------------------------------------------------------
;Allocation info for local variables in function '__func_map_compressed'
;------------------------------------------------------------
;	src/main.c: 15: INCBIN(map_compressed, "res/map.bin.rle")
;	-----------------------------------------
;	 function __func_map_compressed
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
	b___func_map_compressed	= 0
___func_map_compressed:
;	naked function: no prologue.
		_map_compressed::
	 1$:
	 .incbin "res/map.bin.rle" 
	 2$:
	 ___size_map_compressed = (2$-1$) 
	 .globl ___size_map_compressed 
	 .local b___func_map_compressed 
	 ___bank_map_compressed = b___func_map_compressed 
	 .globl ___bank_map_compressed 
;	naked function: no epilogue.
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;sloc0                     Allocated with name '_main_sloc0_1_0'
;i                         Allocated to registers 
;__300000006               Allocated to registers a 
;__300000007               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;map_x_column              Allocated with name '_main_map_x_column_30001_101'
;------------------------------------------------------------
;	src/main.c: 22: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/main.c: 28: HIDE_LEFT_COLUMN;
	lda	_shadow_PPUMASK
	and	#0xf9
	sta	_shadow_PPUMASK
;	src/main.c: 30: SHOW_BKG;
	lda	_shadow_PPUMASK
	ora	#0x08
	sta	_shadow_PPUMASK
;	src/main.c: 33: set_bkg_data(0, INCBIN_SIZE(map_tiles) >> 4, map_tiles);
	ldx	#>___size_map_tiles
	lda	#___size_map_tiles
	stx	*(REGTEMP+0)
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	ldx	#>_map_tiles
	stx	(_set_bkg_data_PARM_3 + 1)
	ldx	#_map_tiles
	stx	_set_bkg_data_PARM_3
	tax
	lda	#0x00
	jsr	_set_bkg_data
;	src/main.c: 36: rle_init(map_compressed);
	ldx	#>_map_compressed
	lda	#_map_compressed
	jsr	_rle_init
;	src/main.c: 41: for (uint8_t i = 0; (i != DEVICE_SCREEN_WIDTH + 1); i++) {
	ldx	#0x00
	stx	*_main_sloc0_1_0
00113$:
	lda	*_main_sloc0_1_0
	cmp	#0x21
	beq	00103$
;	src/main.c: 42: rle_decompress(data, MAP_DATA_HEIGHT);
	ldx	#0x12
	stx	_rle_decompress_PARM_2
	ldx	#>_data
	lda	#_data
	jsr	_rle_decompress
;	src/main.c: 47: set_bkg_tiles(i & (DEVICE_SCREEN_BUFFER_WIDTH-1), 0, 1, MAP_DATA_HEIGHT, data);
	lda	*_main_sloc0_1_0
	and	#0x1f
	ldx	#>_data
	stx	(_set_bkg_tiles_PARM_5 + 1)
	ldx	#_data
	stx	_set_bkg_tiles_PARM_5
	ldx	#0x01
	stx	_set_bkg_tiles_PARM_3
	ldx	#0x12
	stx	_set_bkg_tiles_PARM_4
	ldx	#0x00
	jsr	_set_bkg_tiles
;	src/main.c: 41: for (uint8_t i = 0; (i != DEVICE_SCREEN_WIDTH + 1); i++) {
	inc	*_main_sloc0_1_0
	jmp	00113$
00103$:
;	src/main.c: 51: datapos = 0;
	ldx	#0x00
	stx	_datapos
;	src/main.c: 52: scrollpos = 1;
	inx
	stx	_scrollpos
;	src/main.c: 53: while(TRUE) {
00109$:
;	src/main.c: 55: vsync();
	jsr	_vsync
;	src/main.c: 60: scrollpos++;
	inc	_scrollpos
;	src/main.c: 61: move_bkg(scrollpos, 0);
	lda	_scrollpos
;	../../../include/nes/nes.h: 918: bkg_scroll_x = x, bkg_scroll_y = y;
	sta	_bkg_scroll_x
	ldx	#0x00
	stx	_bkg_scroll_y
;	src/main.c: 65: if ((scrollpos & 0x07u) == 0) {
	ldx	#0x07
	stx	*(REGTEMP+0)
	bit	*(REGTEMP+0)
	bne	00109$
;	src/main.c: 69: datapos = (scrollpos >> 3);
	lsr	a
	lsr	a
	lsr	a
	sta	_datapos
;	src/main.c: 70: uint8_t map_x_column = (datapos + DEVICE_SCREEN_WIDTH) & (DEVICE_SCREEN_BUFFER_WIDTH-1);
	clc
	adc	#0x20
	and	#0x1f
	sta	_main_map_x_column_30001_101
;	src/main.c: 75: if (!rle_decompress(data, MAP_DATA_HEIGHT)) {
	ldx	#0x12
	stx	_rle_decompress_PARM_2
	ldx	#>_data
	lda	#_data
	jsr	_rle_decompress
	cmp	#0x00
	bne	00105$
;	src/main.c: 76: rle_init(map_compressed);
	ldx	#>_map_compressed
	lda	#_map_compressed
	jsr	_rle_init
;	src/main.c: 77: rle_decompress(data, MAP_DATA_HEIGHT);
	ldx	#0x12
	stx	_rle_decompress_PARM_2
	ldx	#>_data
	lda	#_data
	jsr	_rle_decompress
00105$:
;	src/main.c: 83: set_bkg_tiles(map_x_column, 0, 1, MAP_DATA_HEIGHT, data);
	lda	#>_data
	sta	(_set_bkg_tiles_PARM_5 + 1)
	lda	#_data
	sta	_set_bkg_tiles_PARM_5
	ldx	#0x01
	stx	_set_bkg_tiles_PARM_3
	ldx	#0x12
	stx	_set_bkg_tiles_PARM_4
	lda	_main_map_x_column_30001_101
	ldx	#0x00
	jsr	_set_bkg_tiles
	jmp	00109$
;	src/main.c: 86: }
	rts
	.area _CODE
	.area _XINIT
__xinit__scrollpos:
	.db #0x00	; 0
__xinit__datapos:
	.db #0x00	; 0
	.area _CABS    (ABS)
