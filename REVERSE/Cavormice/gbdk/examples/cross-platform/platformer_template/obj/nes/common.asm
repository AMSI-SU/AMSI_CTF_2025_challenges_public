;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module common
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
	.globl _hide_sprites_range
	.globl __switch_prg0
	.globl _fill_bkg_rect
	.globl _set_sprite_native_data
	.globl _set_bkg_native_data
	.globl _set_bkg_tiles
	.globl _display_off
	.globl _display_on
	.globl _vsync
	.globl _joypad
	.globl _set_bkg_palette
	.globl _joypadPrevious
	.globl _joypadCurrent
	.globl _ShowCentered_PARM_7
	.globl _ShowCentered_PARM_6
	.globl _ShowCentered_PARM_5
	.globl _ShowCentered_PARM_4
	.globl _ShowCentered_PARM_3
	.globl _setBKGPalettes_PARM_2
	.globl _OAMDMA
	.globl _PPUDATA
	.globl _PPUADDR
	.globl _PPUSCROLL
	.globl _OAMDATA
	.globl _OAMADDR
	.globl _PPUSTATUS
	.globl _PPUMASK
	.globl _PPUCTRL
	.globl _WaitForStartOrA
	.globl _setBKGPalettes
	.globl _ShowCentered
;--------------------------------------------------------
; ZP ram data
;--------------------------------------------------------
	.area _ZP      (PAG)
_ShowCentered_sloc0_1_0:
	.ds 1
_ShowCentered_sloc1_1_0:
	.ds 2
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
_setBKGPalettes_PARM_2:
	.ds 2
_ShowCentered_PARM_3:
	.ds 1
_ShowCentered_PARM_4:
	.ds 2
_ShowCentered_PARM_5:
	.ds 1
_ShowCentered_PARM_6:
	.ds 2
_ShowCentered_PARM_7:
	.ds 2
_ShowCentered_width_10000_123:
	.ds 1
_ShowCentered__previous_bank_10001_125:
	.ds 1
_ShowCentered_titleRow_10002_126:
	.ds 1
_ShowCentered_titleColumn_10002_126:
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS    (ABS)
;--------------------------------------------------------
; initialized external ram data
;--------------------------------------------------------
	.area _DATA
_joypadCurrent::
	.ds 1
_joypadPrevious::
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
;	src/common.c: 24: void setBKGPalettes(uint8_t count, const palette_color_t *palettes) NONBANKED{
;	-----------------------------------------
;	 function setBKGPalettes
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_setBKGPalettes:
;	src/common.c: 35: set_bkg_palette(0, count, palettes);
	ldx	(_setBKGPalettes_PARM_2 + 1)
	stx	(_set_bkg_palette_PARM_3 + 1)
	ldx	_setBKGPalettes_PARM_2
	stx	_set_bkg_palette_PARM_3
	tax
	lda	#0x00
;	src/common.c: 37: }
	jmp	_set_bkg_palette
;	src/common.c: 40: void ShowCentered(uint8_t width,uint8_t height,uint8_t bank, uint8_t* tileData, uint8_t tileCount, uint8_t* mapData, const palette_color_t* palettes) NONBANKED{
;	-----------------------------------------
;	 function ShowCentered
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_ShowCentered:
	sta	_ShowCentered_width_10000_123
	txa
;	src/common.c: 43: DISPLAY_OFF;
	pha
	jsr	_display_off
	pla
;	src/common.c: 45: uint8_t _previous_bank = CURRENT_BANK;
	ldx	__current_bank
	stx	_ShowCentered__previous_bank_10001_125
;	src/common.c: 49: hide_sprites_range(0,MAX_HARDWARE_SPRITES);
	pha
	lda	#0x00
	ldx	#0x40
	jsr	_hide_sprites_range
	pla
;	../../../include/nes/nes.h: 918: bkg_scroll_x = x, bkg_scroll_y = y;
	ldx	#0x00
	stx	_bkg_scroll_x
	stx	_bkg_scroll_y
;	src/common.c: 54: uint8_t titleRow = (DEVICE_SCREEN_HEIGHT-(height>>3))/2;
	lsr	a
	lsr	a
	lsr	a
	sta	*_ShowCentered_sloc0_1_0
	sta	*(REGTEMP+0)
	lda	#0x1e
	sec
	sbc	*(REGTEMP+0)
	sta	*_ShowCentered_sloc1_1_0
	txa
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	sta	*(_ShowCentered_sloc1_1_0 + 1)
	ldx	*(_ShowCentered_sloc1_1_0 + 1)
	lda	*_ShowCentered_sloc1_1_0
	bit	*(_ShowCentered_sloc1_1_0 + 1)
	bpl	00110$
	ldx	#0x00
	txa
00110$:
	stx	*(REGTEMP+0)
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	sta	_ShowCentered_titleRow_10002_126
;	src/common.c: 55: uint8_t titleColumn = (DEVICE_SCREEN_WIDTH-(width>>3))/2;
	lda	_ShowCentered_width_10000_123
	lsr	a
	lsr	a
	lsr	a
	sta	*_ShowCentered_sloc1_1_0
	ldx	#0x00
	lda	*_ShowCentered_sloc1_1_0
	sta	*(REGTEMP+0)
	lda	#0x20
	sec
	sbc	*(REGTEMP+0)
	pha
	txa
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	tax
	pla
	stx	*(REGTEMP+0)
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	sta	_ShowCentered_titleColumn_10002_126
;	src/common.c: 57: SWITCH_ROM(bank);
	lda	_ShowCentered_PARM_3
	jsr	__switch_prg0
;	src/common.c: 59: setBKGPalettes(1,palettes);
	lda	(_ShowCentered_PARM_7 + 1)
	sta	(_setBKGPalettes_PARM_2 + 1)
	lda	_ShowCentered_PARM_7
	sta	_setBKGPalettes_PARM_2
	lda	#0x01
	jsr	_setBKGPalettes
;	src/common.c: 61: set_native_tile_data(0,tileCount,tileData);
	lda	(_ShowCentered_PARM_4 + 1)
	sta	(_set_bkg_native_data_PARM_3 + 1)
	lda	_ShowCentered_PARM_4
	sta	_set_bkg_native_data_PARM_3
	lda	_ShowCentered_PARM_5
;	../../../include/nes/nes.h: 1207: set_bkg_native_data(first_tile, nb_tiles, data);
	tax
	lda	#0x00
	jsr	_set_bkg_native_data
;	src/common.c: 62: fill_bkg_rect(0,0,DEVICE_SCREEN_WIDTH,DEVICE_SCREEN_HEIGHT,0);
	ldx	#0x20
	stx	_fill_bkg_rect_PARM_3
	ldx	#0x1e
	stx	_fill_bkg_rect_PARM_4
	ldx	#0x00
	stx	_fill_bkg_rect_PARM_5
	txa
	jsr	_fill_bkg_rect
;	src/common.c: 63: set_bkg_tiles(titleColumn,titleRow,width>>3,height>>3,mapData);
	lda	*_ShowCentered_sloc1_1_0
	sta	_set_bkg_tiles_PARM_3
	lda	*_ShowCentered_sloc0_1_0
	sta	_set_bkg_tiles_PARM_4
	lda	(_ShowCentered_PARM_6 + 1)
	sta	(_set_bkg_tiles_PARM_5 + 1)
	lda	_ShowCentered_PARM_6
	sta	_set_bkg_tiles_PARM_5
	lda	_ShowCentered_titleColumn_10002_126
	ldx	_ShowCentered_titleRow_10002_126
	jsr	_set_bkg_tiles
;	src/common.c: 64: SWITCH_ROM(_previous_bank);
	lda	_ShowCentered__previous_bank_10001_125
	jsr	__switch_prg0
;	src/common.c: 66: DISPLAY_ON;
;	src/common.c: 67: }
	jmp	_display_on
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;------------------------------------------------------------
;Allocation info for local variables in function 'WaitForStartOrA'
;------------------------------------------------------------
;	src/common.c: 9: void WaitForStartOrA(void){
;	-----------------------------------------
;	 function WaitForStartOrA
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_WaitForStartOrA:
;	src/common.c: 10: while(1){
00108$:
;	src/common.c: 13: joypadPrevious = joypadCurrent;
	lda	_joypadCurrent
	sta	_joypadPrevious
;	src/common.c: 14: joypadCurrent = joypad();
	jsr	_joypad
	sta	_joypadCurrent
;	src/common.c: 16: if((joypadCurrent & J_START) && !(joypadPrevious & J_START))break;
	and	#0x10
	beq	00102$
	lda	_joypadPrevious
	and	#0x10
	beq	00110$
00102$:
;	src/common.c: 17: if((joypadCurrent & J_A) && !(joypadPrevious & J_A))break;
	lda	_joypadCurrent
	and	#0x80
	beq	00105$
	lda	_joypadPrevious
	and	#0x80
	beq	00110$
00105$:
;	src/common.c: 19: vsync();
	jsr	_vsync
	jmp	00108$
00110$:
;	src/common.c: 22: }
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'setBKGPalettes'
;------------------------------------------------------------
;palettes                  Allocated with name '_setBKGPalettes_PARM_2'
;count                     Allocated to registers a 
;------------------------------------------------------------
;------------------------------------------------------------
;Allocation info for local variables in function 'ShowCentered'
;------------------------------------------------------------
;sloc0                     Allocated with name '_ShowCentered_sloc0_1_0'
;sloc1                     Allocated with name '_ShowCentered_sloc1_1_0'
;bank                      Allocated with name '_ShowCentered_PARM_3'
;tileData                  Allocated with name '_ShowCentered_PARM_4'
;tileCount                 Allocated with name '_ShowCentered_PARM_5'
;mapData                   Allocated with name '_ShowCentered_PARM_6'
;palettes                  Allocated with name '_ShowCentered_PARM_7'
;height                    Allocated to registers a 
;width                     Allocated with name '_ShowCentered_width_10000_123'
;_previous_bank            Allocated with name '_ShowCentered__previous_bank_10001_125'
;__200010006               Allocated to registers 
;__200010007               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;titleRow                  Allocated with name '_ShowCentered_titleRow_10002_126'
;titleColumn               Allocated with name '_ShowCentered_titleColumn_10002_126'
;__200020009               Allocated to registers 
;__200020010               Allocated to registers a 
;__200020011               Allocated to registers 
;first_tile                Allocated to registers 
;nb_tiles                  Allocated to registers 
;data                      Allocated to registers 
;------------------------------------------------------------
	.area _CODE
	.area _XINIT
__xinit__joypadCurrent:
	.db #0x00	; 0
__xinit__joypadPrevious:
	.db #0x00	; 0
	.area _CABS    (ABS)
