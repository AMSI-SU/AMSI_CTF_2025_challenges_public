;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module level
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _SetupCurrentLevel
	.globl _IsTileSolid
	.globl _setBKGPalettes
	.globl _set_attribute_xy
	.globl _set_native_tile_data
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
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	dec	sp
	ld	c, l
	ld	b, h
;src/level.c:42: uint8_t _previous_bank = CURRENT_BANK;
	ld	a, (_MAP_FRAME1+0)
	ld	-3 (ix), a
;src/level.c:44: SWITCH_ROM(currentAreaBank);
	ld	a, (_currentAreaBank+0)
	ld	(_MAP_FRAME1+0), a
;src/level.c:47: uint16_t column = worldX>>3;
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
;src/level.c:48: uint16_t row = worldY>>3;
	ld	-2 (ix), e
	ld	-1 (ix), d
	srl	-1 (ix)
	rr	-2 (ix)
	srl	-1 (ix)
	rr	-2 (ix)
	srl	-1 (ix)
	rr	-2 (ix)
;src/level.c:50: uint16_t worldMaxRow = currentLevelHeight>>3;
	ld	hl, (_currentLevelHeight)
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
;src/level.c:55: if(row>worldMaxRow||column>=currentLevelWidthInTiles){
	ld	a, l
	sub	a, -2 (ix)
	ld	a, h
	sbc	a, -1 (ix)
	jr	C, 00101$
	ld	hl, #_currentLevelWidthInTiles
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00102$
00101$:
;src/level.c:57: SWITCH_ROM(_previous_bank);
	ld	a, -3 (ix)
	ld	(_MAP_FRAME1+0), a
;src/level.c:58: return TRUE;
	ld	a, #0x01
	jr	00104$
00102$:
;src/level.c:61: uint16_t index = column + row* currentLevelWidthInTiles;
	push	bc
	ld	de, (_currentLevelWidthInTiles)
	ld	l, -2 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	__mulint
	ex	de, hl
	pop	bc
	add	hl, bc
	ex	de, hl
;src/level.c:63: uint8_t tile = currentLevelMap[index];
	ld	hl, (_currentLevelMap)
	add	hl, de
	ld	c, (hl)
;src/level.c:65: SWITCH_ROM(_previous_bank);
	ld	a, -3 (ix)
	ld	(_MAP_FRAME1+0), a
;src/level.c:67: return tile<currentLevelNonSolidTileCount;
	ld	a, c
	ld	hl, #_currentLevelNonSolidTileCount
	sub	a, (hl)
	ld	a, #0x00
	rla
00104$:
;src/level.c:68: }
	ld	sp, ix
	pop	ix
	ret
;src/level.c:72: void SetupCurrentLevel(void) NONBANKED{
;	---------------------------------
; Function SetupCurrentLevel
; ---------------------------------
_SetupCurrentLevel::
;src/level.c:74: uint8_t _previous_bank = CURRENT_BANK;
	ld	a, (_MAP_FRAME1+0)
	ld	c, a
;src/level.c:76: for(uint8_t i=0;i<DEVICE_SCREEN_BUFFER_WIDTH;i++){
	ld	b, #0x00
00111$:
	ld	a, b
	sub	a, #0x20
	jr	NC, 00102$
;src/level.c:77: for(uint8_t j=0;j<DEVICE_SCREEN_BUFFER_HEIGHT;j++){
	ld	d, #0x00
00108$:
	ld	a, d
	sub	a, #0x1c
	jr	NC, 00112$
;src/level.c:78: set_attribute_xy(i,j,0);
	push	bc
	push	de
	xor	a, a
	push	af
	inc	sp
	ld	e, b
	push	de
	call	_set_attribute_xy
	pop	de
	pop	bc
;src/level.c:77: for(uint8_t j=0;j<DEVICE_SCREEN_BUFFER_HEIGHT;j++){
	inc	d
	jr	00108$
00112$:
;src/level.c:76: for(uint8_t i=0;i<DEVICE_SCREEN_BUFFER_WIDTH;i++){
	inc	b
	jr	00111$
00102$:
;src/level.c:85: switch(currentLevel % 3){
	ld	a, (_currentLevel+0)
	ld	b, a
	push	bc
	ld	l, #0x03
;	spillPairReg hl
;	spillPairReg hl
	ld	a, b
	call	__moduchar
	pop	bc
	ld	a, e
	or	a, a
	jr	Z, 00103$
	ld	a, e
	dec	a
	jr	Z, 00104$
	ld	a, e
	sub	a, #0x02
	jp	Z,00105$
	jp	00106$
;src/level.c:86: case 0:
00103$:
;src/level.c:92: SWITCH_ROM(( BANK(World1Tileset)));
	ld	hl, #_MAP_FRAME1
	ld	(hl), #<(___bank_World1Tileset)
;src/level.c:94: set_native_tile_data(0,World1Tileset_TILE_COUNT,World1Tileset_tiles);
	push	bc
	ld	hl, #_World1Tileset_tiles
	push	hl
	ld	de, #0x0020
	ld	hl, #0x0000
	call	_set_native_tile_data
	ld	de, #_World1Tileset_palettes
	ld	a, #0x01
	call	_setBKGPalettes
	pop	bc
;src/level.c:99: SWITCH_ROM((currentAreaBank = BANK(World1Area1)));
	ld	a, #<(___bank_World1Area1)
	ld	(_currentAreaBank+0), a
	ld	(_MAP_FRAME1+0), a
;src/level.c:101: currentLevelNonSolidTileCount=WORLD1_SOLID_TILE_COUNT;
	ld	hl, #_currentLevelNonSolidTileCount
	ld	(hl), #0x11
;src/level.c:102: currentLevelWidth = World1Area1_WIDTH;
	ld	hl, #0x01e0
	ld	(_currentLevelWidth), hl
;src/level.c:103: currentLevelHeight = World1Area1_HEIGHT;
	ld	l, #0x00
	ld	(_currentLevelHeight), hl
;src/level.c:104: currentLevelWidthInTiles = World1Area1_WIDTH>>3;
	ld	hl, #0x003c
	ld	(_currentLevelWidthInTiles), hl
;src/level.c:105: currentLevelHeightInTiles = World1Area1_HEIGHT>>3;            
	ld	l, #0x20
	ld	(_currentLevelHeightInTiles), hl
;src/level.c:106: currentLevelMap= World1Area1_map;
	ld	iy, #_currentLevelMap
	ld	0 (iy), #<(_World1Area1_map)
	ld	1 (iy), #>(_World1Area1_map)
;src/level.c:109: break;
	jp	00106$
;src/level.c:110: case 1:
00104$:
;src/level.c:115: SWITCH_ROM((currentAreaBank = BANK(World1Tileset)));
	ld	a, #<(___bank_World1Tileset)
	ld	(_currentAreaBank+0), a
	ld	(_MAP_FRAME1+0), a
;src/level.c:118: set_native_tile_data(0,World1Tileset_TILE_COUNT,World1Tileset_tiles);
	push	bc
	ld	hl, #_World1Tileset_tiles
	push	hl
	ld	de, #0x0020
	ld	hl, #0x0000
	call	_set_native_tile_data
	ld	de, #_World1Tileset_palettes
	ld	a, #0x01
	call	_setBKGPalettes
	pop	bc
;src/level.c:124: SWITCH_ROM((currentAreaBank = BANK(World1Area2)));
	ld	a, #<(___bank_World1Area2)
	ld	(_currentAreaBank+0), a
	ld	(_MAP_FRAME1+0), a
;src/level.c:126: currentLevelNonSolidTileCount=WORLD1_SOLID_TILE_COUNT;
	ld	hl, #_currentLevelNonSolidTileCount
	ld	(hl), #0x11
;src/level.c:127: currentLevelWidth = World1Area2_WIDTH;
	ld	hl, #0x01e0
	ld	(_currentLevelWidth), hl
;src/level.c:128: currentLevelHeight = World1Area2_HEIGHT;
	ld	l, #0x00
	ld	(_currentLevelHeight), hl
;src/level.c:129: currentLevelWidthInTiles = World1Area2_WIDTH>>3;
	ld	hl, #0x003c
	ld	(_currentLevelWidthInTiles), hl
;src/level.c:130: currentLevelHeightInTiles = World1Area2_HEIGHT>>3;
	ld	l, #0x20
	ld	(_currentLevelHeightInTiles), hl
;src/level.c:131: currentLevelMap= World1Area2_map;
	ld	iy, #_currentLevelMap
	ld	0 (iy), #<(_World1Area2_map)
	ld	1 (iy), #>(_World1Area2_map)
;src/level.c:133: break;
	jr	00106$
;src/level.c:134: case 2:
00105$:
;src/level.c:139: SWITCH_ROM((BANK(World2Tileset)));
	ld	hl, #_MAP_FRAME1
	ld	(hl), #<(___bank_World2Tileset)
;src/level.c:141: set_native_tile_data(0,World2Tileset_TILE_COUNT,World2Tileset_tiles);
	ld	de, #_World2Tileset_tiles
	push	bc
	push	de
	ld	de, #0x0046
	ld	hl, #0x0000
	call	_set_native_tile_data
	ld	de, #_World2Tileset_palettes
	ld	a, #0x01
	call	_setBKGPalettes
	pop	bc
;src/level.c:147: SWITCH_ROM((currentAreaBank = BANK(World2Area1)));
	ld	a, #<(___bank_World2Area1)
	ld	(_currentAreaBank+0), a
	ld	(_MAP_FRAME1+0), a
;src/level.c:149: currentLevelNonSolidTileCount=WORLD2_SOLID_TILE_COUNT;
	ld	hl, #_currentLevelNonSolidTileCount
	ld	(hl), #0x44
;src/level.c:150: currentLevelWidth = World2Area1_WIDTH;
	ld	hl, #0x01e0
	ld	(_currentLevelWidth), hl
;src/level.c:151: currentLevelHeight = World2Area1_HEIGHT;
	ld	l, #0x00
	ld	(_currentLevelHeight), hl
;src/level.c:152: currentLevelWidthInTiles = World2Area1_WIDTH>>3;
	ld	hl, #0x003c
	ld	(_currentLevelWidthInTiles), hl
;src/level.c:153: currentLevelHeightInTiles = World2Area1_HEIGHT>>3;
	ld	l, #0x20
	ld	(_currentLevelHeightInTiles), hl
;src/level.c:154: currentLevelMap= World2Area1_map;
	ld	iy, #_currentLevelMap
	ld	0 (iy), #<(_World2Area1_map)
	ld	1 (iy), #>(_World2Area1_map)
;src/level.c:157: }
00106$:
;src/level.c:159: SWITCH_ROM(_previous_bank);
	ld	hl, #_MAP_FRAME1
	ld	(hl), c
;src/level.c:160: }
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
