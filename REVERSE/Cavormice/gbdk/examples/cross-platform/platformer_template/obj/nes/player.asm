;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module player
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
	.globl _PlayerPalettesGGSMS
	.globl _baseProp
	.globl b_UpdatePlayer
	.globl _UpdatePlayer
	.globl _DrawPlayer
	.globl b_SetupPlayer
	.globl _SetupPlayer
	.globl _SetPlayerPalettes
	.globl _UpdatePlayerVRAMTiles
	.globl _IsTileSolid
	.globl __switch_prg0
	.globl _set_sprite_data
	.globl _set_sprite_palette
	.globl _threeFrameCounter
	.globl _playerJumpIncrease
	.globl _facingRight
	.globl _DrawPlayer_PARM_3
	.globl _DrawPlayer_PARM_2
	.globl _playerYVelocity
	.globl _playerXVelocity
	.globl _playerY
	.globl _playerX
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
_UpdatePlayer_sloc0_1_0:
	.ds 1
_UpdatePlayer_sloc1_1_0:
	.ds 2
_UpdatePlayer_sloc2_1_0:
	.ds 2
_UpdatePlayer_sloc3_1_0:
	.ds 2
_UpdatePlayer_sloc4_1_0:
	.ds 2
_UpdatePlayer_sloc5_1_0:
	.ds 2
_UpdatePlayer_sloc6_1_0:
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
_playerX::
	.ds 2
_playerY::
	.ds 2
_playerXVelocity::
	.ds 2
_playerYVelocity::
	.ds 2
_DrawPlayer_PARM_2:
	.ds 2
_DrawPlayer_PARM_3:
	.ds 1
_DrawPlayer__previous_bank_10000_129:
	.ds 1
_DrawPlayer_playerCameraX_10000_129:
	.ds 2
_DrawPlayer_playerCameraY_10000_129:
	.ds 2
_UpdatePlayer_moveSpeed_10000_134:
	.ds 2
_UpdatePlayer_threeFrameCounterValue_10001_135:
	.ds 1
_UpdatePlayer_turning_10002_137:
	.ds 1
_UpdatePlayer_playerRealX_10003_151:
	.ds 2
_UpdatePlayer_playerRealY_10003_151:
	.ds 2
_UpdatePlayer_grounded_10003_151:
	.ds 1
_UpdatePlayer_max_20004_166:
	.ds 2
_UpdatePlayer_spritesUsed_10005_167:
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS    (ABS)
;--------------------------------------------------------
; initialized external ram data
;--------------------------------------------------------
	.area _DATA
_facingRight::
	.ds 1
_playerJumpIncrease::
	.ds 1
_threeFrameCounter::
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
;	src/player.c: 67: void UpdatePlayerVRAMTiles(void) NONBANKED{
;	-----------------------------------------
;	 function UpdatePlayerVRAMTiles
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_UpdatePlayerVRAMTiles:
;	src/player.c: 68: uint8_t _previous_bank = CURRENT_BANK;
	lda	__current_bank
;	src/player.c: 71: SWITCH_ROM(BANK(PlayerCharacterSprites));
	ldx	#___bank_PlayerCharacterSprites
	pha
	txa
	jsr	__switch_prg0
	pla
;	src/player.c: 73: set_player_sprite_data (0,PlayerCharacterSprites_TILE_COUNT,PlayerCharacterSprites_tiles);
	ldx	#>_PlayerCharacterSprites_tiles
	stx	(_set_sprite_data_PARM_3 + 1)
	ldx	#_PlayerCharacterSprites_tiles
	stx	_set_sprite_data_PARM_3
	pha
	lda	#0x00
	ldx	#0x3e
	jsr	_set_sprite_data
	pla
;	src/player.c: 75: SWITCH_ROM(_previous_bank);
;	src/player.c: 76: }
	jmp	__switch_prg0
;	src/player.c: 78: void SetPlayerPalettes(void) NONBANKED{
;	-----------------------------------------
;	 function SetPlayerPalettes
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_SetPlayerPalettes:
;	src/player.c: 79: uint8_t _previous_bank = CURRENT_BANK;
	lda	__current_bank
;	src/player.c: 81: SWITCH_ROM(PLAYER_PALETTES_BANK);
	ldx	#___bank_PlayerCharacterSprites
	pha
	txa
	jsr	__switch_prg0
	pla
;	src/player.c: 91: set_sprite_palette(baseProp, 4, PLAYER_PALETTES);
	ldx	#>_PlayerCharacterSprites_palettes
	stx	(_set_sprite_palette_PARM_3 + 1)
	ldx	#_PlayerCharacterSprites_palettes
	stx	_set_sprite_palette_PARM_3
	pha
	lda	_baseProp
	ldx	#0x04
	jsr	_set_sprite_palette
	pla
;	src/player.c: 95: SWITCH_ROM(_previous_bank);
;	src/player.c: 96: }
	jmp	__switch_prg0
;	src/player.c: 116: uint8_t DrawPlayer(uint16_t playerRealX, uint16_t playerRealY, uint8_t frame) NONBANKED{
;	-----------------------------------------
;	 function DrawPlayer
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_DrawPlayer:
;	src/player.c: 119: uint8_t _previous_bank = CURRENT_BANK;
	ldy	__current_bank
	sty	_DrawPlayer__previous_bank_10000_129
;	src/player.c: 123: uint16_t playerCameraX = (playerRealX-camera_x)+DEVICE_SPRITE_PX_OFFSET_X;
	sec
	sbc	_camera_x
	sta	_DrawPlayer_playerCameraX_10000_129
	txa
	sbc	(_camera_x + 1)
	sta	(_DrawPlayer_playerCameraX_10000_129 + 1)
;	src/player.c: 124: uint16_t playerCameraY= (playerRealY)+DEVICE_SPRITE_PX_OFFSET_Y;
	ldx	(_DrawPlayer_PARM_2 + 1)
	lda	_DrawPlayer_PARM_2
	clc
	adc	#0xff
	pha
	txa
	adc	#0xff
	tax
	pla
	sta	_DrawPlayer_playerCameraY_10000_129
	stx	(_DrawPlayer_playerCameraY_10000_129 + 1)
;	src/player.c: 126: SWITCH_ROM(BANK(PlayerCharacterSprites));
	lda	#___bank_PlayerCharacterSprites
	jsr	__switch_prg0
;	src/player.c: 128: spritesUsed = move_metasprite_ex(PlayerCharacterSprites_metasprites[frame],0,baseProp,0,playerCameraX,playerCameraY);
	ldx	#0x00
	lda	_DrawPlayer_PARM_3
	stx	*(REGTEMP+0)
	asl	a
	rol	*(REGTEMP+0)
	ldx	*(REGTEMP+0)
	clc
	adc	#<(_PlayerCharacterSprites_metasprites+0)
	sta	*(DPTR+0)
	txa
	adc	#>(_PlayerCharacterSprites_metasprites+0)
	sta	*(DPTR+1)
	ldy	#0x01
	lda	[DPTR],y
	tax
	dey
	lda	[DPTR],y
;	../../../include/nes/metasprites.h: 91: __current_metasprite = metasprite;
	sta	___current_metasprite
	stx	(___current_metasprite + 1)
;	../../../include/nes/metasprites.h: 92: __current_base_tile = base_tile;
	sty	___current_base_tile
;	../../../include/nes/metasprites.h: 93: __current_base_prop = base_prop;
	sty	___current_base_prop
;	../../../include/nes/metasprites.h: 94: return __move_metasprite(base_sprite, x, y);
	lda	(_DrawPlayer_playerCameraX_10000_129 + 1)
	sta	(___move_metasprite_PARM_2 + 1)
	lda	_DrawPlayer_playerCameraX_10000_129
	sta	___move_metasprite_PARM_2
	lda	(_DrawPlayer_playerCameraY_10000_129 + 1)
	sta	(___move_metasprite_PARM_3 + 1)
	lda	_DrawPlayer_playerCameraY_10000_129
	sta	___move_metasprite_PARM_3
	tya
	jsr	___move_metasprite
;	src/player.c: 130: SWITCH_ROM(_previous_bank);
	pha
	lda	_DrawPlayer__previous_bank_10000_129
	jsr	__switch_prg0
	pla
;	src/player.c: 132: return spritesUsed;
;	src/player.c: 133: }
	rts
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE_255
;------------------------------------------------------------
;Allocation info for local variables in function 'UpdatePlayerVRAMTiles'
;------------------------------------------------------------
;_previous_bank            Allocated to registers a 
;------------------------------------------------------------
;------------------------------------------------------------
;Allocation info for local variables in function 'SetPlayerPalettes'
;------------------------------------------------------------
;_previous_bank            Allocated to registers a 
;------------------------------------------------------------
;------------------------------------------------------------
;Allocation info for local variables in function 'SetupPlayer'
;------------------------------------------------------------
;	src/player.c: 98: void SetupPlayer(void) BANKED{
;	-----------------------------------------
;	 function SetupPlayer
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
	b_SetupPlayer	= 255
_SetupPlayer:
;	src/player.c: 102: playerX=40<<4;
	ldx	#0x80
	stx	_playerX
	ldx	#0x02
	stx	(_playerX + 1)
;	src/player.c: 103: playerY=40<<4;
	ldx	#0x80
	stx	_playerY
	ldx	#0x02
	stx	(_playerY + 1)
;	src/player.c: 105: playerXVelocity=0;
	ldx	#0x00
	stx	_playerXVelocity
	stx	(_playerXVelocity + 1)
;	src/player.c: 106: playerYVelocity=0;
	stx	_playerYVelocity
	stx	(_playerYVelocity + 1)
;	src/player.c: 108: UpdatePlayerVRAMTiles();
	jsr	_UpdatePlayerVRAMTiles
;	src/player.c: 111: SetPlayerPalettes();
;	src/player.c: 114: }
	jmp	_SetPlayerPalettes
;------------------------------------------------------------
;Allocation info for local variables in function 'DrawPlayer'
;------------------------------------------------------------
;playerRealY               Allocated with name '_DrawPlayer_PARM_2'
;frame                     Allocated with name '_DrawPlayer_PARM_3'
;playerRealX               Allocated to registers a x 
;__200000006               Allocated to registers a 
;spritesUsed               Allocated to registers 
;_previous_bank            Allocated with name '_DrawPlayer__previous_bank_10000_129'
;playerCameraX             Allocated with name '_DrawPlayer_playerCameraX_10000_129'
;playerCameraY             Allocated with name '_DrawPlayer_playerCameraY_10000_129'
;__200000007               Allocated to registers 
;__200000008               Allocated to registers 
;__200000009               Allocated to registers 
;__200000010               Allocated to registers 
;__200000011               Allocated to registers 
;__200000012               Allocated to registers 
;metasprite                Allocated to registers a x 
;base_tile                 Allocated to registers 
;base_prop                 Allocated to registers 
;base_sprite               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;------------------------------------------------------------
;------------------------------------------------------------
;Allocation info for local variables in function 'UpdatePlayer'
;------------------------------------------------------------
;sloc0                     Allocated with name '_UpdatePlayer_sloc0_1_0'
;sloc1                     Allocated with name '_UpdatePlayer_sloc1_1_0'
;sloc2                     Allocated with name '_UpdatePlayer_sloc2_1_0'
;sloc3                     Allocated with name '_UpdatePlayer_sloc3_1_0'
;sloc4                     Allocated with name '_UpdatePlayer_sloc4_1_0'
;sloc5                     Allocated with name '_UpdatePlayer_sloc5_1_0'
;sloc6                     Allocated with name '_UpdatePlayer_sloc6_1_0'
;moveSpeed                 Allocated with name '_UpdatePlayer_moveSpeed_10000_134'
;threeFrameCounterSpeed    Allocated to registers a 
;threeFrameCounterValue    Allocated with name '_UpdatePlayer_threeFrameCounterValue_10001_135'
;turning                   Allocated with name '_UpdatePlayer_turning_10002_137'
;playerRealX               Allocated with name '_UpdatePlayer_playerRealX_10003_151'
;playerRealY               Allocated with name '_UpdatePlayer_playerRealY_10003_151'
;grounded                  Allocated with name '_UpdatePlayer_grounded_10003_151'
;pressedA                  Allocated to registers x 
;pressedUp                 Allocated to registers a 
;pressedAOrUp              Allocated to registers a 
;max                       Allocated with name '_UpdatePlayer_max_20004_166'
;frame                     Allocated to registers a 
;directionOffset           Allocated to registers x 
;spritesUsed               Allocated with name '_UpdatePlayer_spritesUsed_10005_167'
;------------------------------------------------------------
;	src/player.c: 135: uint8_t UpdatePlayer(void) BANKED{
;	-----------------------------------------
;	 function UpdatePlayer
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 0 bytes.
	b_UpdatePlayer	= 255
_UpdatePlayer:
;	src/player.c: 139: int16_t moveSpeed = (joypadCurrent & J_B) ?PLAYER_CHARACTER_RUN_VELOCITY:PLAYER_CHARACTER_WALK_VELOCITY;
	lda	_joypadCurrent
	sta	*_UpdatePlayer_sloc0_1_0
	bit	*_UpdatePlayer_sloc0_1_0
	bvc	00191$
	ldx	#0x01
	lda	#0xa9
	jmp	00192$
00191$:
	ldx	#0x01
	lda	#0x45
00192$:
	sta	_UpdatePlayer_moveSpeed_10000_134
	stx	(_UpdatePlayer_moveSpeed_10000_134 + 1)
;	src/player.c: 140: uint8_t threeFrameCounterSpeed = (joypadCurrent & J_B) ? PLAYER_CHARACTER_RUN_TWO_FRAME_COUNTER : PLAYER_CHARACTER_WALK_TWO_FRAME_COUNTER;
	bit	*_UpdatePlayer_sloc0_1_0
	bvc	00193$
	lda	#0x05
	jmp	00194$
00193$:
	lda	#0x03
00194$:
;	src/player.c: 142: threeFrameCounter+=threeFrameCounterSpeed;
	clc
	adc	_threeFrameCounter
;	src/player.c: 143: uint8_t threeFrameCounterValue = threeFrameCounter>>4;
	sta	_threeFrameCounter
	lsr	a
	lsr	a
	lsr	a
	lsr	a
;	src/player.c: 144: if(threeFrameCounterValue>=3){
	sta	_UpdatePlayer_threeFrameCounterValue_10001_135
	cmp	#0x03
	bcc	00102$
;	src/player.c: 145: threeFrameCounter=0;
	ldx	#0x00
	stx	_threeFrameCounter
;	src/player.c: 146: threeFrameCounterValue=0;
	stx	_UpdatePlayer_threeFrameCounterValue_10001_135
00102$:
;	src/player.c: 149: uint8_t turning = FALSE;
	ldx	#0x00
	stx	_UpdatePlayer_turning_10002_137
;	src/player.c: 151: if(joypadCurrent &J_RIGHT){
	lda	#0x01
	and	*_UpdatePlayer_sloc0_1_0
	beq	00134$
;	src/player.c: 154: if(playerXVelocity<0){
	lda	(_playerXVelocity + 1)
	sta	*(_UpdatePlayer_sloc1_1_0 + 1)
	lda	_playerXVelocity
	sta	*_UpdatePlayer_sloc1_1_0
	bit	*(_UpdatePlayer_sloc1_1_0 + 1)
	bpl	00109$
;	src/player.c: 157: playerXVelocity+=GROUND_FRICTION;
	ldx	*(_UpdatePlayer_sloc1_1_0 + 1)
	lda	*_UpdatePlayer_sloc1_1_0
	clc
	adc	#0x0f
	bcc	00537$
	inx
00537$:
;	src/player.c: 160: if(playerXVelocity<0)turning=TRUE;
	sta	_playerXVelocity
	stx	(_playerXVelocity + 1)
	sta	*_UpdatePlayer_sloc1_1_0
	stx	*(_UpdatePlayer_sloc1_1_0 + 1)
	bit	*(_UpdatePlayer_sloc1_1_0 + 1)
	bpl	00104$
	ldx	#0x01
	stx	_UpdatePlayer_turning_10002_137
	jmp	00135$
00104$:
;	src/player.c: 163: facingRight=TRUE;
	ldx	#0x01
	stx	_facingRight
	jmp	00135$
00109$:
;	src/player.c: 166: playerXVelocity=moveSpeed;
	lda	(_UpdatePlayer_moveSpeed_10000_134 + 1)
	sta	(_playerXVelocity + 1)
	lda	_UpdatePlayer_moveSpeed_10000_134
	sta	_playerXVelocity
;	src/player.c: 169: if(!facingRight){
	lda	_facingRight
	beq	00540$
	jmp	00135$
00540$:
;	src/player.c: 170: facingRight=TRUE;
	ldx	#0x01
	stx	_facingRight
	jmp	00135$
00134$:
;	src/player.c: 174: }else if(joypadCurrent &J_LEFT){
	lda	#0x02
	and	*_UpdatePlayer_sloc0_1_0
	beq	00131$
;	src/player.c: 177: if(playerXVelocity>0){
	lda	(_playerXVelocity + 1)
	sta	*(_UpdatePlayer_sloc1_1_0 + 1)
	lda	_playerXVelocity
	sta	*_UpdatePlayer_sloc1_1_0
	lda	#0x00
	sec
	sbc	*_UpdatePlayer_sloc1_1_0
	lda	#0x00
	sbc	*(_UpdatePlayer_sloc1_1_0 + 1)
	bvc	00544$
	bpl	00543$
	bmi	00117$
00544$:
	bpl	00117$
00543$:
;	src/player.c: 180: playerXVelocity-=GROUND_FRICTION;
	ldx	*(_UpdatePlayer_sloc1_1_0 + 1)
	lda	*_UpdatePlayer_sloc1_1_0
	sec
	sbc	#0x0f
	bcs	00546$
	dex
00546$:
;	src/player.c: 183: if(playerXVelocity>0)turning=TRUE;
	sta	_playerXVelocity
	stx	(_playerXVelocity + 1)
	sta	*(REGTEMP+0)
	lda	#0x00
	sec
	sbc	*(REGTEMP+0)
	lda	#0x00
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	bvc	00548$
	bpl	00547$
	bmi	00112$
00548$:
	bpl	00112$
00547$:
	ldx	#0x01
	stx	_UpdatePlayer_turning_10002_137
	jmp	00135$
00112$:
;	src/player.c: 186: facingRight=FALSE;
	ldx	#0x00
	stx	_facingRight
	jmp	00135$
00117$:
;	src/player.c: 190: playerXVelocity=-moveSpeed;
	lda	#0x00
	sec
	sbc	_UpdatePlayer_moveSpeed_10000_134
	sta	_playerXVelocity
	lda	#0x00
	sbc	(_UpdatePlayer_moveSpeed_10000_134 + 1)
	sta	(_playerXVelocity + 1)
;	src/player.c: 193: if(facingRight){
	lda	_facingRight
	beq	00135$
;	src/player.c: 194: facingRight=FALSE;
	ldx	#0x00
	stx	_facingRight
	jmp	00135$
00131$:
;	src/player.c: 203: if (playerXVelocity > 0) {
	lda	(_playerXVelocity + 1)
	sta	*(_UpdatePlayer_sloc1_1_0 + 1)
	lda	_playerXVelocity
	sta	*_UpdatePlayer_sloc1_1_0
	lda	#0x00
	sec
	sbc	*_UpdatePlayer_sloc1_1_0
	lda	#0x00
	sbc	*(_UpdatePlayer_sloc1_1_0 + 1)
	bvc	00553$
	bpl	00552$
	bmi	00128$
00553$:
	bpl	00128$
00552$:
;	src/player.c: 204: if (playerXVelocity >= GROUND_FRICTION) playerXVelocity -= GROUND_FRICTION;
	lda	*_UpdatePlayer_sloc1_1_0
	sec
	sbc	#0x0f
	lda	*(_UpdatePlayer_sloc1_1_0 + 1)
	sbc	#0x00
	bvs	00556$
	bpl	00555$
	bmi	00120$
00556$:
	bpl	00120$
00555$:
	ldx	*(_UpdatePlayer_sloc1_1_0 + 1)
	lda	*_UpdatePlayer_sloc1_1_0
	sec
	sbc	#0x0f
	bcs	00558$
	dex
00558$:
	sta	_playerXVelocity
	stx	(_playerXVelocity + 1)
	jmp	00135$
00120$:
;	src/player.c: 205: else playerXVelocity=0;
	ldx	#0x00
	stx	_playerXVelocity
	stx	(_playerXVelocity + 1)
	jmp	00135$
00128$:
;	src/player.c: 207: else if (playerXVelocity < 0) {
	bit	*(_UpdatePlayer_sloc1_1_0 + 1)
	bpl	00135$
;	src/player.c: 208: if (playerXVelocity <= GROUND_FRICTION) playerXVelocity += GROUND_FRICTION;
	ldx	*(_UpdatePlayer_sloc1_1_0 + 1)
	lda	*_UpdatePlayer_sloc1_1_0
	clc
	adc	#0x0f
	bcc	00560$
	inx
00560$:
	sta	_playerXVelocity
	stx	(_playerXVelocity + 1)
;	src/player.c: 209: else playerXVelocity=0;
00135$:
;	src/player.c: 213: uint16_t playerRealX = playerX>>4;
	ldx	(_playerX + 1)
	lda	_playerX
	stx	*(REGTEMP+0)
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	sta	*_UpdatePlayer_sloc1_1_0
	stx	*(_UpdatePlayer_sloc1_1_0 + 1)
;	src/player.c: 214: uint16_t playerRealY = playerY>>4;
	ldx	(_playerY + 1)
	lda	_playerY
	stx	*(REGTEMP+0)
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	sta	*_UpdatePlayer_sloc2_1_0
	stx	*(_UpdatePlayer_sloc2_1_0 + 1)
;	src/player.c: 216: uint8_t grounded = FALSE;
	ldx	#0x00
	stx	_UpdatePlayer_grounded_10003_151
;	src/player.c: 223: if(playerRealY<DEVICE_SCREEN_PX_HEIGHT){
	lda	*_UpdatePlayer_sloc2_1_0
	sec
	sbc	#0xf0
	lda	*(_UpdatePlayer_sloc2_1_0 + 1)
	sbc	#0x00
	bcs	00140$
;	src/player.c: 226: while(IsTileSolid(playerRealX,playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT-1)){
00136$:
	ldx	*(_UpdatePlayer_sloc2_1_0 + 1)
	lda	*_UpdatePlayer_sloc2_1_0
	clc
	adc	#0x17
	bcc	00562$
	inx
00562$:
	sta	_IsTileSolid_PARM_2
	stx	(_IsTileSolid_PARM_2 + 1)
	ldx	*(_UpdatePlayer_sloc1_1_0 + 1)
	lda	*_UpdatePlayer_sloc1_1_0
	jsr	_IsTileSolid
	cmp	#0x00
	beq	00140$
;	src/player.c: 227: playerY-=16;
	ldx	(_playerY + 1)
	lda	_playerY
	sec
	sbc	#0x10
	bcs	00565$
	dex
00565$:
;	src/player.c: 228: playerRealY = playerY>>4;
	sta	_playerY
	stx	(_playerY + 1)
	stx	*(REGTEMP+0)
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	sta	*_UpdatePlayer_sloc2_1_0
	stx	*(_UpdatePlayer_sloc2_1_0 + 1)
	jmp	00136$
00140$:
;	src/player.c: 242: if(playerXVelocity!=0){
	lda	(_playerXVelocity + 1)
	ora	_playerXVelocity
	bne	00567$
	jmp	00155$
00567$:
;	src/player.c: 245: if(playerXVelocity>0){
	lda	(_playerXVelocity + 1)
	sta	*(_UpdatePlayer_sloc3_1_0 + 1)
	lda	_playerXVelocity
	sta	*_UpdatePlayer_sloc3_1_0
	lda	#0x00
	sec
	sbc	*_UpdatePlayer_sloc3_1_0
	lda	#0x00
	sbc	*(_UpdatePlayer_sloc3_1_0 + 1)
	bvc	00569$
	bpl	00568$
	bmi	00570$
00569$:
	bmi	00568$
00570$:
	jmp	00152$
00568$:
;	src/player.c: 249: if(IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+2)||IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HALF_HEIGHT)||IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+(PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT-2)))playerXVelocity=0;
	lda	*(_UpdatePlayer_sloc1_1_0 + 1)
	sta	*(_UpdatePlayer_sloc4_1_0 + 1)
	lda	*_UpdatePlayer_sloc1_1_0
	sta	*_UpdatePlayer_sloc4_1_0
	ldx	*(_UpdatePlayer_sloc4_1_0 + 1)
	lda	*_UpdatePlayer_sloc4_1_0
	clc
	adc	#0x05
	bcc	00571$
	inx
00571$:
	sta	*_UpdatePlayer_sloc5_1_0
	stx	*(_UpdatePlayer_sloc5_1_0 + 1)
	lda	*(_UpdatePlayer_sloc2_1_0 + 1)
	sta	*(_UpdatePlayer_sloc6_1_0 + 1)
	lda	*_UpdatePlayer_sloc2_1_0
	sta	*_UpdatePlayer_sloc6_1_0
	ldx	*(_UpdatePlayer_sloc6_1_0 + 1)
	lda	*_UpdatePlayer_sloc6_1_0
	clc
	adc	#0x02
	bcc	00572$
	inx
00572$:
	sta	_IsTileSolid_PARM_2
	stx	(_IsTileSolid_PARM_2 + 1)
	ldx	*(_UpdatePlayer_sloc5_1_0 + 1)
	lda	*_UpdatePlayer_sloc5_1_0
	jsr	_IsTileSolid
	cmp	#0x00
	bne	00141$
	ldx	*(_UpdatePlayer_sloc4_1_0 + 1)
	lda	*_UpdatePlayer_sloc4_1_0
	clc
	adc	#0x05
	bcc	00575$
	inx
00575$:
	sta	*_UpdatePlayer_sloc5_1_0
	stx	*(_UpdatePlayer_sloc5_1_0 + 1)
	ldx	*(_UpdatePlayer_sloc6_1_0 + 1)
	lda	*_UpdatePlayer_sloc6_1_0
	clc
	adc	#0x0c
	bcc	00576$
	inx
00576$:
	sta	_IsTileSolid_PARM_2
	stx	(_IsTileSolid_PARM_2 + 1)
	ldx	*(_UpdatePlayer_sloc5_1_0 + 1)
	lda	*_UpdatePlayer_sloc5_1_0
	jsr	_IsTileSolid
	cmp	#0x00
	bne	00141$
	ldx	*(_UpdatePlayer_sloc4_1_0 + 1)
	lda	*_UpdatePlayer_sloc4_1_0
	clc
	adc	#0x05
	bcc	00579$
	inx
00579$:
	sta	*_UpdatePlayer_sloc5_1_0
	stx	*(_UpdatePlayer_sloc5_1_0 + 1)
	ldx	*(_UpdatePlayer_sloc6_1_0 + 1)
	lda	*_UpdatePlayer_sloc6_1_0
	clc
	adc	#0x16
	bcc	00580$
	inx
00580$:
	sta	_IsTileSolid_PARM_2
	stx	(_IsTileSolid_PARM_2 + 1)
	ldx	*(_UpdatePlayer_sloc5_1_0 + 1)
	lda	*_UpdatePlayer_sloc5_1_0
	jsr	_IsTileSolid
	cmp	#0x00
	bne	00582$
	jmp	00155$
00582$:
00141$:
	ldx	#0x00
	stx	_playerXVelocity
	stx	(_playerXVelocity + 1)
	jmp	00155$
00152$:
;	src/player.c: 252: }else if(playerXVelocity<0){
	bit	*(_UpdatePlayer_sloc3_1_0 + 1)
	bmi	00583$
	jmp	00155$
00583$:
;	src/player.c: 256: if(IsTileSolid(playerRealX-PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+2)||IsTileSolid(playerRealX-PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HALF_HEIGHT)||IsTileSolid(playerRealX-PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+(PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT-2)))playerXVelocity=0;
	lda	*(_UpdatePlayer_sloc1_1_0 + 1)
	sta	*(_UpdatePlayer_sloc6_1_0 + 1)
	lda	*_UpdatePlayer_sloc1_1_0
	sta	*_UpdatePlayer_sloc6_1_0
	ldx	*(_UpdatePlayer_sloc6_1_0 + 1)
	lda	*_UpdatePlayer_sloc6_1_0
	sec
	sbc	#0x05
	bcs	00584$
	dex
00584$:
	sta	*_UpdatePlayer_sloc5_1_0
	stx	*(_UpdatePlayer_sloc5_1_0 + 1)
	lda	*(_UpdatePlayer_sloc2_1_0 + 1)
	sta	*(_UpdatePlayer_sloc4_1_0 + 1)
	lda	*_UpdatePlayer_sloc2_1_0
	sta	*_UpdatePlayer_sloc4_1_0
	ldx	*(_UpdatePlayer_sloc4_1_0 + 1)
	lda	*_UpdatePlayer_sloc4_1_0
	clc
	adc	#0x02
	bcc	00585$
	inx
00585$:
	sta	_IsTileSolid_PARM_2
	stx	(_IsTileSolid_PARM_2 + 1)
	ldx	*(_UpdatePlayer_sloc5_1_0 + 1)
	lda	*_UpdatePlayer_sloc5_1_0
	jsr	_IsTileSolid
	cmp	#0x00
	bne	00145$
	ldx	*(_UpdatePlayer_sloc6_1_0 + 1)
	lda	*_UpdatePlayer_sloc6_1_0
	sec
	sbc	#0x05
	bcs	00588$
	dex
00588$:
	sta	*_UpdatePlayer_sloc5_1_0
	stx	*(_UpdatePlayer_sloc5_1_0 + 1)
	ldx	*(_UpdatePlayer_sloc4_1_0 + 1)
	lda	*_UpdatePlayer_sloc4_1_0
	clc
	adc	#0x0c
	bcc	00589$
	inx
00589$:
	sta	_IsTileSolid_PARM_2
	stx	(_IsTileSolid_PARM_2 + 1)
	ldx	*(_UpdatePlayer_sloc5_1_0 + 1)
	lda	*_UpdatePlayer_sloc5_1_0
	jsr	_IsTileSolid
	cmp	#0x00
	bne	00145$
	ldx	*(_UpdatePlayer_sloc6_1_0 + 1)
	lda	*_UpdatePlayer_sloc6_1_0
	sec
	sbc	#0x05
	bcs	00592$
	dex
00592$:
	sta	*_UpdatePlayer_sloc6_1_0
	stx	*(_UpdatePlayer_sloc6_1_0 + 1)
	ldx	*(_UpdatePlayer_sloc4_1_0 + 1)
	lda	*_UpdatePlayer_sloc4_1_0
	clc
	adc	#0x16
	bcc	00593$
	inx
00593$:
	sta	_IsTileSolid_PARM_2
	stx	(_IsTileSolid_PARM_2 + 1)
	ldx	*(_UpdatePlayer_sloc6_1_0 + 1)
	lda	*_UpdatePlayer_sloc6_1_0
	jsr	_IsTileSolid
	cmp	#0x00
	beq	00155$
00145$:
	ldx	#0x00
	stx	_playerXVelocity
	stx	(_playerXVelocity + 1)
00155$:
;	src/player.c: 261: if(playerYVelocity>=0){
	lda	(_playerYVelocity + 1)
	sta	*(_UpdatePlayer_sloc6_1_0 + 1)
	lda	_playerYVelocity
	sta	*_UpdatePlayer_sloc6_1_0
	bit	*(_UpdatePlayer_sloc6_1_0 + 1)
	bmi	00160$
;	src/player.c: 265: if(IsTileSolid(playerRealX+(PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH-2),playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT)||IsTileSolid(playerRealX-(PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH-2),playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT)){
	lda	*(_UpdatePlayer_sloc1_1_0 + 1)
	sta	*(_UpdatePlayer_sloc6_1_0 + 1)
	lda	*_UpdatePlayer_sloc1_1_0
	sta	*_UpdatePlayer_sloc6_1_0
	ldx	*(_UpdatePlayer_sloc6_1_0 + 1)
	lda	*_UpdatePlayer_sloc6_1_0
	clc
	adc	#0x03
	bcc	00597$
	inx
00597$:
	sta	*_UpdatePlayer_sloc5_1_0
	stx	*(_UpdatePlayer_sloc5_1_0 + 1)
	lda	*(_UpdatePlayer_sloc2_1_0 + 1)
	sta	*(_UpdatePlayer_sloc4_1_0 + 1)
	lda	*_UpdatePlayer_sloc2_1_0
	sta	*_UpdatePlayer_sloc4_1_0
	ldx	*(_UpdatePlayer_sloc4_1_0 + 1)
	lda	*_UpdatePlayer_sloc4_1_0
	clc
	adc	#0x18
	bcc	00598$
	inx
00598$:
	sta	_IsTileSolid_PARM_2
	stx	(_IsTileSolid_PARM_2 + 1)
	ldx	*(_UpdatePlayer_sloc5_1_0 + 1)
	lda	*_UpdatePlayer_sloc5_1_0
	jsr	_IsTileSolid
	cmp	#0x00
	bne	00156$
	ldx	*(_UpdatePlayer_sloc6_1_0 + 1)
	lda	*_UpdatePlayer_sloc6_1_0
	sec
	sbc	#0x03
	bcs	00601$
	dex
00601$:
	sta	*_UpdatePlayer_sloc6_1_0
	stx	*(_UpdatePlayer_sloc6_1_0 + 1)
	ldx	*(_UpdatePlayer_sloc4_1_0 + 1)
	lda	*_UpdatePlayer_sloc4_1_0
	clc
	adc	#0x18
	bcc	00602$
	inx
00602$:
	sta	_IsTileSolid_PARM_2
	stx	(_IsTileSolid_PARM_2 + 1)
	ldx	*(_UpdatePlayer_sloc6_1_0 + 1)
	lda	*_UpdatePlayer_sloc6_1_0
	jsr	_IsTileSolid
	cmp	#0x00
	bne	00604$
	jmp	00167$
00604$:
00156$:
;	src/player.c: 266: playerYVelocity=0;
	ldx	#0x00
	stx	_playerYVelocity
	stx	(_playerYVelocity + 1)
;	src/player.c: 267: grounded=TRUE;
	inx
	stx	_UpdatePlayer_grounded_10003_151
	jmp	00167$
;	src/player.c: 277: while(IsTileSolid(playerRealX+(PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH-2),playerRealY)||IsTileSolid(playerRealX-(PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH-2),playerRealY)){
00160$:
	lda	*(_UpdatePlayer_sloc1_1_0 + 1)
	sta	*(_UpdatePlayer_sloc6_1_0 + 1)
	lda	*_UpdatePlayer_sloc1_1_0
	sta	*_UpdatePlayer_sloc6_1_0
	ldx	*(_UpdatePlayer_sloc6_1_0 + 1)
	lda	*_UpdatePlayer_sloc6_1_0
	clc
	adc	#0x03
	bcc	00605$
	inx
00605$:
	ldy	*(_UpdatePlayer_sloc2_1_0 + 1)
	sty	(_IsTileSolid_PARM_2 + 1)
	ldy	*_UpdatePlayer_sloc2_1_0
	sty	_IsTileSolid_PARM_2
	jsr	_IsTileSolid
	cmp	#0x00
	bne	00161$
	ldx	*(_UpdatePlayer_sloc6_1_0 + 1)
	lda	*_UpdatePlayer_sloc6_1_0
	sec
	sbc	#0x03
	bcs	00608$
	dex
00608$:
	ldy	*(_UpdatePlayer_sloc2_1_0 + 1)
	sty	(_IsTileSolid_PARM_2 + 1)
	ldy	*_UpdatePlayer_sloc2_1_0
	sty	_IsTileSolid_PARM_2
	jsr	_IsTileSolid
	cmp	#0x00
	beq	00167$
00161$:
;	src/player.c: 278: playerYVelocity=0;
	ldx	#0x00
	stx	_playerYVelocity
	stx	(_playerYVelocity + 1)
;	src/player.c: 279: playerY+=16;
	ldx	(_playerY + 1)
	lda	_playerY
	clc
	adc	#0x10
	bcc	00611$
	inx
00611$:
;	src/player.c: 280: playerRealY = playerY>>4;
	sta	_playerY
	stx	(_playerY + 1)
	stx	*(REGTEMP+0)
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	sta	*_UpdatePlayer_sloc2_1_0
	stx	*(_UpdatePlayer_sloc2_1_0 + 1)
	jmp	00160$
00167$:
;	src/player.c: 286: uint8_t pressedA = (joypadCurrent & J_A && !(joypadPrevious & J_A));
	lda	_joypadCurrent
	sta	*_UpdatePlayer_sloc6_1_0
	bit	*_UpdatePlayer_sloc6_1_0
	bpl	00195$
	lda	_joypadPrevious
	and	#0x80
	beq	00196$
00195$:
	ldx	#0x00
	jmp	00197$
00196$:
	ldx	#0x01
00197$:
;	src/player.c: 287: uint8_t pressedUp = (joypadCurrent & J_UP && !(joypadPrevious & J_UP));
	lda	#0x08
	and	*_UpdatePlayer_sloc6_1_0
	beq	00198$
	lda	_joypadPrevious
	and	#0x08
	beq	00199$
00198$:
	lda	#0x00
	jmp	00200$
00199$:
	lda	#0x01
00200$:
;	src/player.c: 288: uint8_t pressedAOrUp = pressedA||pressedUp;
	cpx	#0x00
	bne	00202$
	cmp	#0x00
	bne	00202$
	lda	#0x00
	jmp	00203$
00202$:
	lda	#0x01
00203$:
;	src/player.c: 291: if(grounded && pressedAOrUp){
	ldx	_UpdatePlayer_grounded_10003_151
	beq	00169$
	cmp	#0x00
	beq	00169$
;	src/player.c: 292: playerYVelocity=-PLAYER_CHARACTER_JUMP_VELOCITY;
	ldx	#0xda
	stx	_playerYVelocity
	ldx	#0xfd
	stx	(_playerYVelocity + 1)
;	src/player.c: 293: playerJumpIncrease=PLAYER_CHARACTER_INCREASE_JUMP_TIMER_MAX;
	ldx	#0x14
	stx	_playerJumpIncrease
00169$:
;	src/player.c: 297: if(!grounded){
	lda	_UpdatePlayer_grounded_10003_151
	bne	00180$
;	src/player.c: 300: if(playerJumpIncrease>0)playerJumpIncrease--;
	lda	_playerJumpIncrease
	beq	00172$
	dec	_playerJumpIncrease
00172$:
;	src/player.c: 303: if(!((joypadCurrent & J_A||joypadCurrent & J_UP))||playerJumpIncrease==0){
	bit	*_UpdatePlayer_sloc6_1_0
	bmi	00176$
	lda	#0x08
	and	*_UpdatePlayer_sloc6_1_0
	beq	00173$
00176$:
	lda	_playerJumpIncrease
	bne	00181$
00173$:
;	src/player.c: 306: playerYVelocity+=GRAVTY;
	ldx	(_playerYVelocity + 1)
	lda	_playerYVelocity
	clc
	adc	#0x2d
	bcc	00634$
	inx
00634$:
	sta	_playerYVelocity
	stx	(_playerYVelocity + 1)
;	src/player.c: 309: playerJumpIncrease=0;
	ldx	#0x00
	stx	_playerJumpIncrease
	jmp	00181$
00180$:
;	src/player.c: 313: }else if(playerYVelocity>=0){
	lda	(_playerYVelocity + 1)
	sta	*(_UpdatePlayer_sloc6_1_0 + 1)
	lda	_playerYVelocity
	sta	*_UpdatePlayer_sloc6_1_0
	bit	*(_UpdatePlayer_sloc6_1_0 + 1)
	bmi	00181$
;	src/player.c: 316: playerYVelocity=0;
	ldx	#0x00
	stx	_playerYVelocity
	stx	(_playerYVelocity + 1)
00181$:
;	src/player.c: 320: playerX+=playerXVelocity>>4;
	ldx	(_playerXVelocity + 1)
	lda	_playerXVelocity
	stx	*(REGTEMP+0)
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	sta	*_UpdatePlayer_sloc6_1_0
	stx	*(_UpdatePlayer_sloc6_1_0 + 1)
	clc
	adc	_playerX
	sta	_playerX
	txa
	adc	(_playerX + 1)
	sta	(_playerX + 1)
;	src/player.c: 321: playerY+=playerYVelocity>>4;
	ldx	(_playerYVelocity + 1)
	lda	_playerYVelocity
	stx	*(REGTEMP+0)
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	clc
	adc	_playerY
	sta	_playerY
	txa
	adc	(_playerY + 1)
	sta	(_playerY + 1)
;	src/player.c: 324: playerRealX = playerX>>4;
	ldx	(_playerX + 1)
	lda	_playerX
	stx	*(REGTEMP+0)
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	sta	_UpdatePlayer_playerRealX_10003_151
	stx	(_UpdatePlayer_playerRealX_10003_151 + 1)
;	src/player.c: 325: playerRealY = playerY>>4;
	ldx	(_playerY + 1)
	lda	_playerY
	stx	*(REGTEMP+0)
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	sta	_UpdatePlayer_playerRealY_10003_151
	stx	(_UpdatePlayer_playerRealY_10003_151 + 1)
;	src/player.c: 328: if(playerRealX>=(DEVICE_SCREEN_PX_WIDTH>>1)){
	lda	_UpdatePlayer_playerRealX_10003_151
	sec
	sbc	#0x80
	lda	(_UpdatePlayer_playerRealX_10003_151 + 1)
	sbc	#0x00
	bcc	00185$
;	src/player.c: 329: uint16_t max = currentLevelWidth-DEVICE_SCREEN_PX_WIDTH;
	ldx	(_currentLevelWidth + 1)
	lda	_currentLevelWidth
	sec
	sbc	#0x00
	pha
	txa
	sbc	#0x01
	tax
	pla
	sta	_UpdatePlayer_max_20004_166
	stx	(_UpdatePlayer_max_20004_166 + 1)
;	src/player.c: 330: camera_x=playerRealX-(DEVICE_SCREEN_PX_WIDTH>>1);
	ldx	(_UpdatePlayer_playerRealX_10003_151 + 1)
	lda	_UpdatePlayer_playerRealX_10003_151
	sec
	sbc	#0x80
	bcs	00637$
	dex
00637$:
	sta	_camera_x
	stx	(_camera_x + 1)
;	src/player.c: 333: if(camera_x>max)camera_x=max;
	sta	*(REGTEMP+0)
	lda	_UpdatePlayer_max_20004_166
	sec
	sbc	*(REGTEMP+0)
	lda	(_UpdatePlayer_max_20004_166 + 1)
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	bcs	00186$
	lda	(_UpdatePlayer_max_20004_166 + 1)
	sta	(_camera_x + 1)
	lda	_UpdatePlayer_max_20004_166
	sta	_camera_x
	jmp	00186$
00185$:
;	src/player.c: 335: else camera_x=0;
	ldx	#0x00
	stx	_camera_x
	stx	(_camera_x + 1)
00186$:
;	src/player.c: 345: uint8_t frame = grounded ? (turning ? 5 :((playerXVelocity>>4)==0 ? 0 : threeFrameCounterValue)) : (playerYVelocity<0 ? 3 : 4);
	lda	_UpdatePlayer_grounded_10003_151
	beq	00204$
	lda	_UpdatePlayer_turning_10002_137
	beq	00206$
	lda	#0x05
	jmp	00205$
00206$:
	lda	*(_UpdatePlayer_sloc6_1_0 + 1)
	ora	*_UpdatePlayer_sloc6_1_0
	bne	00208$
	lda	#0x00
	jmp	00205$
00208$:
	lda	_UpdatePlayer_threeFrameCounterValue_10001_135
	jmp	00205$
00204$:
	lda	(_playerYVelocity + 1)
	sta	*(_UpdatePlayer_sloc6_1_0 + 1)
	lda	_playerYVelocity
	sta	*_UpdatePlayer_sloc6_1_0
	bit	*(_UpdatePlayer_sloc6_1_0 + 1)
	bpl	00210$
	lda	#0x03
	jmp	00211$
00210$:
	lda	#0x04
00211$:
00205$:
;	src/player.c: 346: uint8_t directionOffset = facingRight ? 0 : 6;
	ldx	_facingRight
	beq	00212$
	ldx	#0x00
	jmp	00213$
00212$:
	ldx	#0x06
00213$:
;	src/player.c: 348: uint8_t spritesUsed = DrawPlayer(playerRealX,playerRealY,frame+directionOffset);
	clc
	stx	*(REGTEMP+0)
	adc	*(REGTEMP+0)
	sta	_DrawPlayer_PARM_3
	lda	(_UpdatePlayer_playerRealY_10003_151 + 1)
	sta	(_DrawPlayer_PARM_2 + 1)
	lda	_UpdatePlayer_playerRealY_10003_151
	sta	_DrawPlayer_PARM_2
	ldx	(_UpdatePlayer_playerRealX_10003_151 + 1)
	lda	_UpdatePlayer_playerRealX_10003_151
	jsr	_DrawPlayer
	sta	_UpdatePlayer_spritesUsed_10005_167
;	src/player.c: 351: if(playerRealX>currentLevelWidth-32){
	ldx	(_currentLevelWidth + 1)
	lda	_currentLevelWidth
	sec
	sbc	#0x20
	bcs	00648$
	dex
00648$:
	ldy	(_UpdatePlayer_playerRealX_10003_151 + 1)
	sty	*(_UpdatePlayer_sloc6_1_0 + 1)
	ldy	_UpdatePlayer_playerRealX_10003_151
	sty	*_UpdatePlayer_sloc6_1_0
	sec
	sbc	*_UpdatePlayer_sloc6_1_0
	txa
	sbc	*(_UpdatePlayer_sloc6_1_0 + 1)
	bcs	00188$
;	src/player.c: 352: nextLevel++;
	inc	_nextLevel
00188$:
;	src/player.c: 355: return spritesUsed;
	lda	_UpdatePlayer_spritesUsed_10005_167
;	src/player.c: 356: }
	rts
	.area _CODE_255
_baseProp:
	.db #0x00	; 0
_PlayerPalettesGGSMS:
	.db #0x26	; 38
	.db #0x20	; 32
	.db #0x3d	; 61
	.db #0x1d	; 29
	.db #0x17	; 23
	.db #0x19	; 25
	.db #0x02	; 2
	.db #0x29	; 41
	.db #0x2b	; 43
	.db #0x04	; 4
	.db #0x16	; 22
	.db #0x2a	; 42
	.db #0x12	; 18
	.db #0x28	; 40
	.db #0x2c	; 44
	.db #0x34	; 52	'4'
	.area _XINIT
__xinit__facingRight:
	.db #0x01	; 1
__xinit__playerJumpIncrease:
	.db #0x00	; 0
__xinit__threeFrameCounter:
	.db #0x00	; 0
	.area _CABS    (ABS)
