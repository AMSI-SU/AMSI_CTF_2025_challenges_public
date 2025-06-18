;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module level
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
	.globl _SetupCurrentLevel
	.globl _IsTileSolid
	.globl _setBKGPalettes
	.globl __switch_prg0
	.globl _set_bkg_native_data
	.globl _set_bkg_attribute_xy_nes16x16
	.globl _nextLevel
	.globl _currentLevel
	.globl _IsTileSolid_PARM_2
	.globl _currentAreaBank
	.globl _currentLevelNonSolidTileCount
	.globl _currentLevelMap
	.globl _currentLevelHeightInTiles
	.globl _currentLevelHeight
	.globl _currentLevelWidthInTiles
	.globl _currentLevelWidth
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
_IsTileSolid_sloc0_1_0:
	.ds 2
_SetupCurrentLevel_sloc0_1_0:
	.ds 1
_SetupCurrentLevel_sloc1_1_0:
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
_currentLevelWidth::
	.ds 2
_currentLevelWidthInTiles::
	.ds 2
_currentLevelHeight::
	.ds 2
_currentLevelHeightInTiles::
	.ds 2
_currentLevelMap::
	.ds 2
_currentLevelNonSolidTileCount::
	.ds 1
_currentAreaBank::
	.ds 1
_IsTileSolid_PARM_2:
	.ds 2
_IsTileSolid__previous_bank_10000_119:
	.ds 1
_IsTileSolid_column_10001_120:
	.ds 2
_IsTileSolid_row_10001_120:
	.ds 2
_SetupCurrentLevel__previous_bank_10000_124:
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS    (ABS)
;--------------------------------------------------------
; initialized external ram data
;--------------------------------------------------------
	.area _DATA
_currentLevel::
	.ds 1
_nextLevel::
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
;	src/level.c: 40: uint8_t IsTileSolid(uint16_t worldX,uint16_t worldY) NONBANKED{
;	-----------------------------------------
;	 function IsTileSolid
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_IsTileSolid:
;	src/level.c: 42: uint8_t _previous_bank = CURRENT_BANK;
	ldy	__current_bank
	sty	_IsTileSolid__previous_bank_10000_119
;	src/level.c: 44: SWITCH_ROM(currentAreaBank);
	pha
	sta	*(REGTEMP+0)
	txa
	pha
	lda	_currentAreaBank
	jsr	__switch_prg0
	pla
	tax
	pla
;	src/level.c: 47: uint16_t column = worldX>>3;
	stx	*(REGTEMP+0)
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	sta	_IsTileSolid_column_10001_120
	stx	(_IsTileSolid_column_10001_120 + 1)
;	src/level.c: 48: uint16_t row = worldY>>3;
	ldx	(_IsTileSolid_PARM_2 + 1)
	lda	_IsTileSolid_PARM_2
	stx	*(REGTEMP+0)
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	sta	_IsTileSolid_row_10001_120
	stx	(_IsTileSolid_row_10001_120 + 1)
;	src/level.c: 50: uint16_t worldMaxRow = currentLevelHeight>>3;
	ldx	(_currentLevelHeight + 1)
	lda	_currentLevelHeight
	stx	*(REGTEMP+0)
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
;	src/level.c: 55: if(row>worldMaxRow||column>=currentLevelWidthInTiles){
	sec
	sbc	_IsTileSolid_row_10001_120
	txa
	sbc	(_IsTileSolid_row_10001_120 + 1)
	bcc	00101$
	lda	_IsTileSolid_column_10001_120
	sec
	sbc	_currentLevelWidthInTiles
	lda	(_IsTileSolid_column_10001_120 + 1)
	sbc	(_currentLevelWidthInTiles + 1)
	bcc	00102$
00101$:
;	src/level.c: 57: SWITCH_ROM(_previous_bank);
	lda	_IsTileSolid__previous_bank_10000_119
	jsr	__switch_prg0
;	src/level.c: 58: return TRUE;
	lda	#0x01
	rts
00102$:
;	src/level.c: 61: uint16_t index = column + row* currentLevelWidthInTiles;
	lda	(_currentLevelWidthInTiles + 1)
	sta	(__mulint_PARM_2 + 1)
	lda	_currentLevelWidthInTiles
	sta	__mulint_PARM_2
	ldx	(_IsTileSolid_row_10001_120 + 1)
	lda	_IsTileSolid_row_10001_120
	jsr	__mulint
	clc
	adc	_IsTileSolid_column_10001_120
	pha
	txa
	adc	(_IsTileSolid_column_10001_120 + 1)
	tax
	pla
;	src/level.c: 63: uint8_t tile = currentLevelMap[index];
	clc
	adc	_currentLevelMap
	sta	*_IsTileSolid_sloc0_1_0
	txa
	adc	(_currentLevelMap + 1)
	sta	*(_IsTileSolid_sloc0_1_0 + 1)
	ldy	#0x00
	lda	[*_IsTileSolid_sloc0_1_0],y
;	src/level.c: 65: SWITCH_ROM(_previous_bank);
	pha
	lda	_IsTileSolid__previous_bank_10000_119
	jsr	__switch_prg0
	pla
;	src/level.c: 67: return tile<currentLevelNonSolidTileCount;
	cmp	_currentLevelNonSolidTileCount
	bcc	00114$
	lda	#0x00
	rts
00114$:
	lda	#0x01
;	src/level.c: 68: }
	rts
;	src/level.c: 72: void SetupCurrentLevel(void) NONBANKED{
;	-----------------------------------------
;	 function SetupCurrentLevel
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_SetupCurrentLevel:
;	src/level.c: 74: uint8_t _previous_bank = CURRENT_BANK;
	lda	__current_bank
	sta	_SetupCurrentLevel__previous_bank_10000_124
;	src/level.c: 76: for(uint8_t i=0;i<DEVICE_SCREEN_BUFFER_WIDTH;i++){
	ldx	#0x00
	stx	*_SetupCurrentLevel_sloc0_1_0
00130$:
	lda	*_SetupCurrentLevel_sloc0_1_0
	cmp	#0x20
	bcs	00102$
;	src/level.c: 77: for(uint8_t j=0;j<DEVICE_SCREEN_BUFFER_HEIGHT;j++){
	lda	*_SetupCurrentLevel_sloc0_1_0
	lsr	a
	sta	*_SetupCurrentLevel_sloc1_1_0
	ldy	#0x00
00127$:
	cpy	#0x1e
	bcs	00131$
;	../../../include/nes/nes.h: 891: set_bkg_attribute_xy_nes16x16(x >> 1, y >> 1, a);
	tya
	lsr	a
	ldx	#0x00
	stx	_set_bkg_attribute_xy_nes16x16_PARM_3
	sta	*(REGTEMP+0)
	tya
	pha
	lda	*(REGTEMP+0)
	tax
	lda	*_SetupCurrentLevel_sloc1_1_0
	jsr	_set_bkg_attribute_xy_nes16x16
	sta	*(REGTEMP+0)
	pla
	tay
	lda	*(REGTEMP+0)
;	src/level.c: 77: for(uint8_t j=0;j<DEVICE_SCREEN_BUFFER_HEIGHT;j++){
	iny
	jmp	00127$
00131$:
;	src/level.c: 76: for(uint8_t i=0;i<DEVICE_SCREEN_BUFFER_WIDTH;i++){
	inc	*_SetupCurrentLevel_sloc0_1_0
	jmp	00130$
00102$:
;	src/level.c: 85: switch(currentLevel % 3){
	lda	_currentLevel
	ldx	#0x03
	jsr	__moduchar
	ldx	#0x00
	tay
	lda	00172$,y
	sta	*(REGTEMP+0)
	lda	00173$,y
	sta	*(REGTEMP+1)
	jmp	[REGTEMP+0]
00172$:
	.db	00103$
	.db	00104$
	.db	00105$
00173$:
	.db	>00103$
	.db	>00104$
	.db	>00105$
;	src/level.c: 86: case 0:
00103$:
;	src/level.c: 92: SWITCH_ROM(( BANK(World1Tileset)));
	lda	#___bank_World1Tileset
	jsr	__switch_prg0
;	src/level.c: 94: set_native_tile_data(0,World1Tileset_TILE_COUNT,World1Tileset_tiles);
	lda	#>_World1Tileset_tiles
	sta	(_set_bkg_native_data_PARM_3 + 1)
	lda	#_World1Tileset_tiles
	sta	_set_bkg_native_data_PARM_3
;	../../../include/nes/nes.h: 1207: set_bkg_native_data(first_tile, nb_tiles, data);
	lda	#0x00
	ldx	#0x20
	jsr	_set_bkg_native_data
;	src/level.c: 95: setBKGPalettes(World1Tileset_PALETTE_COUNT,World1Tileset_palettes);
	lda	#>_World1Tileset_palettes
	sta	(_setBKGPalettes_PARM_2 + 1)
	lda	#_World1Tileset_palettes
	sta	_setBKGPalettes_PARM_2
	lda	#0x04
	jsr	_setBKGPalettes
;	src/level.c: 99: SWITCH_ROM((currentAreaBank = BANK(World1Area1)));
	lda	#___bank_World1Area1
	sta	_currentAreaBank
	jsr	__switch_prg0
;	src/level.c: 101: currentLevelNonSolidTileCount=WORLD1_SOLID_TILE_COUNT;
	ldx	#0x11
	stx	_currentLevelNonSolidTileCount
;	src/level.c: 102: currentLevelWidth = World1Area1_WIDTH;
	ldx	#0xe0
	stx	_currentLevelWidth
	ldx	#0x01
	stx	(_currentLevelWidth + 1)
;	src/level.c: 103: currentLevelHeight = World1Area1_HEIGHT;
	dex
	stx	_currentLevelHeight
	inx
	stx	(_currentLevelHeight + 1)
;	src/level.c: 104: currentLevelWidthInTiles = World1Area1_WIDTH>>3;
	ldx	#0x3c
	stx	_currentLevelWidthInTiles
	ldx	#0x00
	stx	(_currentLevelWidthInTiles + 1)
;	src/level.c: 105: currentLevelHeightInTiles = World1Area1_HEIGHT>>3;            
	ldx	#0x20
	stx	_currentLevelHeightInTiles
	ldx	#0x00
	stx	(_currentLevelHeightInTiles + 1)
;	src/level.c: 106: currentLevelMap= World1Area1_map;
	lda	#>_World1Area1_map
	sta	(_currentLevelMap + 1)
	lda	#_World1Area1_map
	sta	_currentLevelMap
;	src/level.c: 109: break;
	jmp	00106$
;	src/level.c: 110: case 1:
00104$:
;	src/level.c: 115: SWITCH_ROM((currentAreaBank = BANK(World1Tileset)));
	lda	#___bank_World1Tileset
	sta	_currentAreaBank
	jsr	__switch_prg0
;	src/level.c: 118: set_native_tile_data(0,World1Tileset_TILE_COUNT,World1Tileset_tiles);
	lda	#>_World1Tileset_tiles
	sta	(_set_bkg_native_data_PARM_3 + 1)
	lda	#_World1Tileset_tiles
	sta	_set_bkg_native_data_PARM_3
;	../../../include/nes/nes.h: 1207: set_bkg_native_data(first_tile, nb_tiles, data);
	lda	#0x00
	ldx	#0x20
	jsr	_set_bkg_native_data
;	src/level.c: 119: setBKGPalettes(World1Tileset_PALETTE_COUNT,World1Tileset_palettes);
	lda	#>_World1Tileset_palettes
	sta	(_setBKGPalettes_PARM_2 + 1)
	lda	#_World1Tileset_palettes
	sta	_setBKGPalettes_PARM_2
	lda	#0x04
	jsr	_setBKGPalettes
;	src/level.c: 124: SWITCH_ROM((currentAreaBank = BANK(World1Area2)));
	lda	#___bank_World1Area2
	sta	_currentAreaBank
	jsr	__switch_prg0
;	src/level.c: 126: currentLevelNonSolidTileCount=WORLD1_SOLID_TILE_COUNT;
	ldx	#0x11
	stx	_currentLevelNonSolidTileCount
;	src/level.c: 127: currentLevelWidth = World1Area2_WIDTH;
	ldx	#0xe0
	stx	_currentLevelWidth
	ldx	#0x01
	stx	(_currentLevelWidth + 1)
;	src/level.c: 128: currentLevelHeight = World1Area2_HEIGHT;
	dex
	stx	_currentLevelHeight
	inx
	stx	(_currentLevelHeight + 1)
;	src/level.c: 129: currentLevelWidthInTiles = World1Area2_WIDTH>>3;
	ldx	#0x3c
	stx	_currentLevelWidthInTiles
	ldx	#0x00
	stx	(_currentLevelWidthInTiles + 1)
;	src/level.c: 130: currentLevelHeightInTiles = World1Area2_HEIGHT>>3;
	ldx	#0x20
	stx	_currentLevelHeightInTiles
	ldx	#0x00
	stx	(_currentLevelHeightInTiles + 1)
;	src/level.c: 131: currentLevelMap= World1Area2_map;
	lda	#>_World1Area2_map
	sta	(_currentLevelMap + 1)
	lda	#_World1Area2_map
	sta	_currentLevelMap
;	src/level.c: 133: break;
	jmp	00106$
;	src/level.c: 134: case 2:
00105$:
;	src/level.c: 139: SWITCH_ROM((BANK(World2Tileset)));
	lda	#___bank_World2Tileset
	jsr	__switch_prg0
;	src/level.c: 141: set_native_tile_data(0,World2Tileset_TILE_COUNT,World2Tileset_tiles);
	lda	#>_World2Tileset_tiles
	sta	(_set_bkg_native_data_PARM_3 + 1)
	lda	#_World2Tileset_tiles
	sta	_set_bkg_native_data_PARM_3
;	../../../include/nes/nes.h: 1207: set_bkg_native_data(first_tile, nb_tiles, data);
	lda	#0x00
	ldx	#0x46
	jsr	_set_bkg_native_data
;	src/level.c: 142: setBKGPalettes(World2Tileset_PALETTE_COUNT,World2Tileset_palettes);
	lda	#>_World2Tileset_palettes
	sta	(_setBKGPalettes_PARM_2 + 1)
	lda	#_World2Tileset_palettes
	sta	_setBKGPalettes_PARM_2
	lda	#0x04
	jsr	_setBKGPalettes
;	src/level.c: 147: SWITCH_ROM((currentAreaBank = BANK(World2Area1)));
	lda	#___bank_World2Area1
	sta	_currentAreaBank
	jsr	__switch_prg0
;	src/level.c: 149: currentLevelNonSolidTileCount=WORLD2_SOLID_TILE_COUNT;
	ldx	#0x44
	stx	_currentLevelNonSolidTileCount
;	src/level.c: 150: currentLevelWidth = World2Area1_WIDTH;
	ldx	#0xe0
	stx	_currentLevelWidth
	ldx	#0x01
	stx	(_currentLevelWidth + 1)
;	src/level.c: 151: currentLevelHeight = World2Area1_HEIGHT;
	dex
	stx	_currentLevelHeight
	inx
	stx	(_currentLevelHeight + 1)
;	src/level.c: 152: currentLevelWidthInTiles = World2Area1_WIDTH>>3;
	ldx	#0x3c
	stx	_currentLevelWidthInTiles
	ldx	#0x00
	stx	(_currentLevelWidthInTiles + 1)
;	src/level.c: 153: currentLevelHeightInTiles = World2Area1_HEIGHT>>3;
	ldx	#0x20
	stx	_currentLevelHeightInTiles
	ldx	#0x00
	stx	(_currentLevelHeightInTiles + 1)
;	src/level.c: 154: currentLevelMap= World2Area1_map;
	lda	#>_World2Area1_map
	sta	(_currentLevelMap + 1)
	lda	#_World2Area1_map
	sta	_currentLevelMap
;	src/level.c: 157: }
00106$:
;	src/level.c: 159: SWITCH_ROM(_previous_bank);
	lda	_SetupCurrentLevel__previous_bank_10000_124
;	src/level.c: 160: }
	jmp	__switch_prg0
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;------------------------------------------------------------
;Allocation info for local variables in function 'IsTileSolid'
;------------------------------------------------------------
;sloc0                     Allocated with name '_IsTileSolid_sloc0_1_0'
;worldY                    Allocated with name '_IsTileSolid_PARM_2'
;worldX                    Allocated to registers a x 
;_previous_bank            Allocated with name '_IsTileSolid__previous_bank_10000_119'
;column                    Allocated with name '_IsTileSolid_column_10001_120'
;row                       Allocated with name '_IsTileSolid_row_10001_120'
;worldMaxRow               Allocated to registers a x 
;index                     Allocated to registers a x 
;tile                      Allocated to registers a 
;------------------------------------------------------------
;------------------------------------------------------------
;Allocation info for local variables in function 'SetupCurrentLevel'
;------------------------------------------------------------
;sloc0                     Allocated with name '_SetupCurrentLevel_sloc0_1_0'
;sloc1                     Allocated with name '_SetupCurrentLevel_sloc1_1_0'
;_previous_bank            Allocated with name '_SetupCurrentLevel__previous_bank_10000_124'
;i                         Allocated to registers 
;j                         Allocated to registers 
;__600000006               Allocated to registers 
;__600000007               Allocated to registers 
;__600000008               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;a                         Allocated to registers 
;__300000010               Allocated to registers 
;__300000011               Allocated to registers 
;__300000012               Allocated to registers 
;first_tile                Allocated to registers 
;nb_tiles                  Allocated to registers 
;data                      Allocated to registers 
;__300000014               Allocated to registers 
;__300000015               Allocated to registers 
;__300000016               Allocated to registers 
;first_tile                Allocated to registers 
;nb_tiles                  Allocated to registers 
;data                      Allocated to registers 
;__300000018               Allocated to registers 
;__300000019               Allocated to registers 
;__300000020               Allocated to registers 
;first_tile                Allocated to registers 
;nb_tiles                  Allocated to registers 
;data                      Allocated to registers 
;------------------------------------------------------------
	.area _CODE
	.area _XINIT
__xinit__currentLevel:
	.db #0xff	; 255
__xinit__nextLevel:
	.db #0x00	; 0
	.area _CABS    (ABS)
