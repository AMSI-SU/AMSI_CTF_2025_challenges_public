;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module level
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _SetupCurrentLevel
	.globl _IsTileSolid
	.globl _setBKGPalettes
	.globl _set_bkg_tile_xy
	.globl _set_bkg_data
	.globl _nextLevel
	.globl _currentLevel
	.globl _currentAreaBank
	.globl _currentLevelNonSolidTileCount
	.globl _currentLevelMap
	.globl _currentLevelHeightInTiles
	.globl _currentLevelHeight
	.globl _currentLevelWidthInTiles
	.globl _currentLevelWidth
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
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
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_currentLevel::
	.ds 1
_nextLevel::
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
;src/level.c:40: uint8_t IsTileSolid(uint16_t worldX,uint16_t worldY) NONBANKED{
;	---------------------------------
; Function IsTileSolid
; ---------------------------------
_IsTileSolid::
	add	sp, #-3
;src/level.c:42: uint8_t _previous_bank = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#0
	ld	(hl), a
;src/level.c:44: SWITCH_ROM(currentAreaBank);
	ld	a, (#_currentAreaBank)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;src/level.c:47: uint16_t column = worldX>>3;
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
;src/level.c:48: uint16_t row = worldY>>3;
	ldhl	sp,	#1
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
;src/level.c:50: uint16_t worldMaxRow = currentLevelHeight>>3;
	ld	hl, #_currentLevelHeight
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
;src/level.c:55: if(row>worldMaxRow||column>=currentLevelWidthInTiles){
	ldhl	sp,	#1
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00101$
	ld	hl, #_currentLevelWidthInTiles
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00102$
00101$:
;src/level.c:57: SWITCH_ROM(_previous_bank);
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;src/level.c:58: return TRUE;
	ld	a, #0x01
	jr	00104$
00102$:
;src/level.c:61: uint16_t index = column + row* currentLevelWidthInTiles;
	push	de
	ld	hl, #_currentLevelWidthInTiles
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	add	hl, de
	ld	c, l
	ld	b, h
;src/level.c:63: uint8_t tile = currentLevelMap[index];
	ld	a, c
	ld	hl, #_currentLevelMap
	add	a, (hl)
	inc	hl
	ld	c, a
	ld	a, b
	adc	a, (hl)
	ld	b, a
	ld	a, (bc)
	ld	c, a
;src/level.c:65: SWITCH_ROM(_previous_bank);
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;src/level.c:67: return tile<currentLevelNonSolidTileCount;
	ld	a, c
	ld	hl, #_currentLevelNonSolidTileCount
	sub	a, (hl)
	ld	a, #0x00
	rla
00104$:
;src/level.c:68: }
	add	sp, #3
	ret
;src/level.c:72: void SetupCurrentLevel(void) NONBANKED{
;	---------------------------------
; Function SetupCurrentLevel
; ---------------------------------
_SetupCurrentLevel::
	dec	sp
;src/level.c:74: uint8_t _previous_bank = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#0
	ld	(hl), a
;src/level.c:76: for(uint8_t i=0;i<DEVICE_SCREEN_BUFFER_WIDTH;i++){
	ld	c, #0x00
00124$:
	ld	a, c
	sub	a, #0x20
	jr	NC, 00102$
;src/level.c:77: for(uint8_t j=0;j<DEVICE_SCREEN_BUFFER_HEIGHT;j++){
	ld	b, #0x00
00121$:
	ld	a, b
	sub	a, #0x20
	jr	NC, 00125$
;../../../include/gb/gb.h:1411: VBK_REG = VBK_ATTRIBUTES;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;../../../include/gb/gb.h:1412: addr = set_bkg_tile_xy(x, y, a);
	push	bc
	xor	a, a
	push	af
	inc	sp
	ld	e, b
	ld	a, c
	call	_set_bkg_tile_xy
	pop	bc
;../../../include/gb/gb.h:1413: VBK_REG = VBK_TILES;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;src/level.c:77: for(uint8_t j=0;j<DEVICE_SCREEN_BUFFER_HEIGHT;j++){
	inc	b
	jr	00121$
00125$:
;src/level.c:76: for(uint8_t i=0;i<DEVICE_SCREEN_BUFFER_WIDTH;i++){
	inc	c
	jr	00124$
00102$:
;src/level.c:85: switch(currentLevel % 3){
	ld	a, (#_currentLevel)
	ld	e, #0x03
	call	__moduchar
	ld	a, c
	or	a, a
	jr	Z, 00103$
	ld	a, c
	dec	a
	jr	Z, 00104$
	ld	a, c
	sub	a, #0x02
	jp	Z,00105$
	jp	00106$
;src/level.c:86: case 0:
00103$:
;src/level.c:92: SWITCH_ROM(( BANK(World1Tileset)));
	ld	a, #<(___bank_World1Tileset)
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), #<(___bank_World1Tileset)
;src/level.c:94: set_native_tile_data(0,World1Tileset_TILE_COUNT,World1Tileset_tiles);
	ld	bc, #_World1Tileset_tiles
;../../../include/gb/gb.h:2134: set_bkg_data(first_tile, nb_tiles, data);
	push	bc
	ld	hl, #0x2000
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/level.c:95: setBKGPalettes(World1Tileset_PALETTE_COUNT,World1Tileset_palettes);
	ld	de, #_World1Tileset_palettes
	ld	a, #0x04
	call	_setBKGPalettes
;src/level.c:99: SWITCH_ROM((currentAreaBank = BANK(World1Area1)));
	ld	a, #<(___bank_World1Area1)
	ldh	(__current_bank + 0), a
	ld	a, #<(___bank_World1Area1)
	ld	(#_currentAreaBank),a
	ld	(#_rROMB0),a
;src/level.c:101: currentLevelNonSolidTileCount=WORLD1_SOLID_TILE_COUNT;
	ld	hl, #_currentLevelNonSolidTileCount
	ld	(hl), #0x11
;src/level.c:102: currentLevelWidth = World1Area1_WIDTH;
	ld	hl, #_currentLevelWidth
	ld	a, #0xe0
	ld	(hl+), a
	ld	(hl), #0x01
;src/level.c:103: currentLevelHeight = World1Area1_HEIGHT;
	ld	hl, #_currentLevelHeight
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x01
;src/level.c:104: currentLevelWidthInTiles = World1Area1_WIDTH>>3;
	ld	hl, #_currentLevelWidthInTiles
	ld	a, #0x3c
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/level.c:105: currentLevelHeightInTiles = World1Area1_HEIGHT>>3;            
	ld	hl, #_currentLevelHeightInTiles
	ld	a, #0x20
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/level.c:106: currentLevelMap= World1Area1_map;
	ld	hl, #_currentLevelMap
	ld	(hl), #<(_World1Area1_map)
	inc	hl
	ld	(hl), #>(_World1Area1_map)
;src/level.c:109: break;
	jp	00106$
;src/level.c:110: case 1:
00104$:
;src/level.c:115: SWITCH_ROM((currentAreaBank = BANK(World1Tileset)));
	ld	bc, #___bank_World1Tileset+0
	ld	a, c
	ldh	(__current_bank + 0), a
	ld	hl, #_currentAreaBank
	ld	(hl), c
	ld	hl, #_rROMB0
	ld	(hl), c
;src/level.c:118: set_native_tile_data(0,World1Tileset_TILE_COUNT,World1Tileset_tiles);
;../../../include/gb/gb.h:2134: set_bkg_data(first_tile, nb_tiles, data);
	ld	de, #_World1Tileset_tiles
	push	de
	ld	hl, #0x2000
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/level.c:119: setBKGPalettes(World1Tileset_PALETTE_COUNT,World1Tileset_palettes);
	ld	de, #_World1Tileset_palettes
	ld	a, #0x04
	call	_setBKGPalettes
;src/level.c:124: SWITCH_ROM((currentAreaBank = BANK(World1Area2)));
	ld	a, #<(___bank_World1Area2)
	ldh	(__current_bank + 0), a
	ld	a, #<(___bank_World1Area2)
	ld	(#_currentAreaBank),a
	ld	(#_rROMB0),a
;src/level.c:126: currentLevelNonSolidTileCount=WORLD1_SOLID_TILE_COUNT;
	ld	hl, #_currentLevelNonSolidTileCount
	ld	(hl), #0x11
;src/level.c:127: currentLevelWidth = World1Area2_WIDTH;
	ld	hl, #_currentLevelWidth
	ld	a, #0xe0
	ld	(hl+), a
	ld	(hl), #0x01
;src/level.c:128: currentLevelHeight = World1Area2_HEIGHT;
	ld	hl, #_currentLevelHeight
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x01
;src/level.c:129: currentLevelWidthInTiles = World1Area2_WIDTH>>3;
	ld	hl, #_currentLevelWidthInTiles
	ld	a, #0x3c
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/level.c:130: currentLevelHeightInTiles = World1Area2_HEIGHT>>3;
	ld	hl, #_currentLevelHeightInTiles
	ld	a, #0x20
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/level.c:131: currentLevelMap= World1Area2_map;
	ld	hl, #_currentLevelMap
	ld	(hl), #<(_World1Area2_map)
	inc	hl
	ld	(hl), #>(_World1Area2_map)
;src/level.c:133: break;
	jr	00106$
;src/level.c:134: case 2:
00105$:
;src/level.c:139: SWITCH_ROM((BANK(World2Tileset)));
	ld	a, #<(___bank_World2Tileset)
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), #<(___bank_World2Tileset)
;src/level.c:141: set_native_tile_data(0,World2Tileset_TILE_COUNT,World2Tileset_tiles);
;../../../include/gb/gb.h:2134: set_bkg_data(first_tile, nb_tiles, data);
	ld	de, #_World2Tileset_tiles
	push	de
	ld	hl, #0x4600
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/level.c:142: setBKGPalettes(World2Tileset_PALETTE_COUNT,World2Tileset_palettes);
	ld	de, #_World2Tileset_palettes
	ld	a, #0x04
	call	_setBKGPalettes
;src/level.c:147: SWITCH_ROM((currentAreaBank = BANK(World2Area1)));
	ld	a, #<(___bank_World2Area1)
	ldh	(__current_bank + 0), a
	ld	a, #<(___bank_World2Area1)
	ld	(#_currentAreaBank),a
	ld	(#_rROMB0),a
;src/level.c:149: currentLevelNonSolidTileCount=WORLD2_SOLID_TILE_COUNT;
	ld	hl, #_currentLevelNonSolidTileCount
	ld	(hl), #0x44
;src/level.c:150: currentLevelWidth = World2Area1_WIDTH;
	ld	hl, #_currentLevelWidth
	ld	a, #0xe0
	ld	(hl+), a
	ld	(hl), #0x01
;src/level.c:151: currentLevelHeight = World2Area1_HEIGHT;
	ld	hl, #_currentLevelHeight
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x01
;src/level.c:152: currentLevelWidthInTiles = World2Area1_WIDTH>>3;
	ld	hl, #_currentLevelWidthInTiles
	ld	a, #0x3c
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/level.c:153: currentLevelHeightInTiles = World2Area1_HEIGHT>>3;
	ld	hl, #_currentLevelHeightInTiles
	ld	a, #0x20
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/level.c:154: currentLevelMap= World2Area1_map;
	ld	hl, #_currentLevelMap
	ld	(hl), #<(_World2Area1_map)
	inc	hl
	ld	(hl), #>(_World2Area1_map)
;src/level.c:157: }
00106$:
;src/level.c:159: SWITCH_ROM(_previous_bank);
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;src/level.c:160: }
	inc	sp
	ret
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _INITIALIZER
__xinit__currentLevel:
	.db #0xff	; 255
__xinit__nextLevel:
	.db #0x00	; 0
	.area _CABS (ABS)
