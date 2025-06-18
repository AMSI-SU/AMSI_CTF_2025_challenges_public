;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module player
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b_UpdatePlayer
	.globl _UpdatePlayer
	.globl _DrawPlayer
	.globl b_SetupPlayer
	.globl _SetupPlayer
	.globl _SetPlayerPalettes
	.globl _UpdatePlayerVRAMTiles
	.globl _IsTileSolid
	.globl _set_sprite_data
	.globl _threeFrameCounter
	.globl _playerJumpIncrease
	.globl _facingRight
	.globl _playerYVelocity
	.globl _playerXVelocity
	.globl _playerY
	.globl _playerX
	.globl _PlayerPalettesGGSMS
	.globl _baseProp
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_playerX::
	.ds 2
_playerY::
	.ds 2
_playerXVelocity::
	.ds 2
_playerYVelocity::
	.ds 2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_facingRight::
	.ds 1
_playerJumpIncrease::
	.ds 1
_threeFrameCounter::
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
;src/player.c:67: void UpdatePlayerVRAMTiles(void) NONBANKED{
;	---------------------------------
; Function UpdatePlayerVRAMTiles
; ---------------------------------
_UpdatePlayerVRAMTiles::
;src/player.c:68: uint8_t _previous_bank = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ld	c, a
;src/player.c:71: SWITCH_ROM(BANK(PlayerCharacterSprites));
	ld	a, #<(___bank_PlayerCharacterSprites)
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), #<(___bank_PlayerCharacterSprites)
;src/player.c:73: set_player_sprite_data (0,PlayerCharacterSprites_TILE_COUNT,PlayerCharacterSprites_tiles);
	ld	de, #_PlayerCharacterSprites_tiles
	push	de
	ld	hl, #0x3e00
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/player.c:75: SWITCH_ROM(_previous_bank);
	ld	a, c
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), c
;src/player.c:76: }
	ret
_baseProp:
	.db #0x00	; 0
_PlayerPalettesGGSMS:
	.dw #0x221f
	.dw #0x7fff
	.dw #0x56b5
	.dw #0x0000
	.dw #0x0011
	.dw #0x01c0
	.dw #0x5460
	.dw #0x020f
	.dw #0x3620
	.dw #0x2809
	.dw #0x001f
	.dw #0x03e4
	.dw #0x7ca0
	.dw #0x03bf
	.dw #0x7f80
	.dw #0x7e1f
;src/player.c:78: void SetPlayerPalettes(void) NONBANKED{
;	---------------------------------
; Function SetPlayerPalettes
; ---------------------------------
_SetPlayerPalettes::
;src/player.c:79: uint8_t _previous_bank = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ld	c, a
;src/player.c:81: SWITCH_ROM(PLAYER_PALETTES_BANK);
	ld	a, #<(___bank_PlayerCharacterSprites)
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), #<(___bank_PlayerCharacterSprites)
;src/player.c:95: SWITCH_ROM(_previous_bank);
	ld	a, c
	ldh	(__current_bank + 0), a
	ld	(hl), c
;src/player.c:96: }
	ret
;src/player.c:116: uint8_t DrawPlayer(uint16_t playerRealX, uint16_t playerRealY, uint8_t frame) NONBANKED{
;	---------------------------------
; Function DrawPlayer
; ---------------------------------
_DrawPlayer::
	dec	sp
;src/player.c:119: uint8_t _previous_bank = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#0
	ld	(hl), a
;src/player.c:123: uint16_t playerCameraX = (playerRealX-camera_x)+DEVICE_SPRITE_PX_OFFSET_X;
	ld	a, e
	ld	hl, #_camera_x
	ld	e, (hl)
	sub	a, e
	add	a, #0x08
	ld	e, a
;src/player.c:124: uint16_t playerCameraY= (playerRealY)+DEVICE_SPRITE_PX_OFFSET_Y;
	ld	a, c
	add	a, #0x10
	ld	c, a
;src/player.c:126: SWITCH_ROM(BANK(PlayerCharacterSprites));
	ld	a, #<(___bank_PlayerCharacterSprites)
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), #<(___bank_PlayerCharacterSprites)
;src/player.c:128: spritesUsed = move_metasprite_ex(PlayerCharacterSprites_metasprites[frame],0,baseProp,0,playerCameraX,playerCameraY);
	ld	b, e
	ldhl	sp,	#3
	ld	e, (hl)
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	ld	de, #_PlayerCharacterSprites_metasprites
	add	hl, de
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
;../../../include/gb/metasprites.h:160: __current_metasprite = metasprite;
	ld	e, a
	ld	d, h
	ld	hl, #___current_metasprite
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;../../../include/gb/metasprites.h:161: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x00
;../../../include/gb/metasprites.h:162: __current_base_prop = base_prop;
	ld	hl, #___current_base_prop
	ld	(hl), #0x00
;../../../include/gb/metasprites.h:163: return __move_metasprite(base_sprite, (y << 8) | (uint8_t)x);
	ld	d, c
	ld	e, b
	xor	a, a
	call	___move_metasprite
	ld	c, a
;src/player.c:130: SWITCH_ROM(_previous_bank);
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;src/player.c:132: return spritesUsed;
	ld	a, c
;src/player.c:133: }
	inc	sp
	pop	hl
	inc	sp
	jp	(hl)
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE_255
;src/player.c:98: void SetupPlayer(void) BANKED{
;	---------------------------------
; Function SetupPlayer
; ---------------------------------
	b_SetupPlayer	= 255
_SetupPlayer::
;src/player.c:102: playerX=40<<4;
	ld	hl, #_playerX
	ld	a, #0x80
	ld	(hl+), a
	ld	(hl), #0x02
;src/player.c:103: playerY=40<<4;
	ld	hl, #_playerY
	ld	a, #0x80
	ld	(hl+), a
	ld	(hl), #0x02
;src/player.c:105: playerXVelocity=0;
	xor	a, a
	ld	hl, #_playerXVelocity
	ld	(hl+), a
	ld	(hl), a
;src/player.c:106: playerYVelocity=0;
	xor	a, a
	ld	hl, #_playerYVelocity
	ld	(hl+), a
	ld	(hl), a
;src/player.c:108: UpdatePlayerVRAMTiles();
	call	_UpdatePlayerVRAMTiles
;src/player.c:111: SetPlayerPalettes();
;src/player.c:114: }
	jp	_SetPlayerPalettes
;src/player.c:135: uint8_t UpdatePlayer(void) BANKED{
;	---------------------------------
; Function UpdatePlayer
; ---------------------------------
	b_UpdatePlayer	= 255
_UpdatePlayer::
	add	sp, #-15
;src/player.c:139: int16_t moveSpeed = (joypadCurrent & J_B) ?PLAYER_CHARACTER_RUN_VELOCITY:PLAYER_CHARACTER_WALK_VELOCITY;
	ld	a, (#_joypadCurrent)
	ldhl	sp,	#6
	ld	(hl), a
	and	a,#0x20
	jr	Z, 00191$
	ld	bc, #0x01a9
	jr	00192$
00191$:
	ld	bc, #0x0145
00192$:
	ldhl	sp,	#7
	ld	(hl), c
	inc	hl
	ld	(hl), b
;src/player.c:140: uint8_t threeFrameCounterSpeed = (joypadCurrent & J_B) ? PLAYER_CHARACTER_RUN_TWO_FRAME_COUNTER : PLAYER_CHARACTER_WALK_TWO_FRAME_COUNTER;
	or	a, a
	jr	Z, 00193$
	ld	b, #0x05
	jr	00194$
00193$:
	ld	b, #0x03
00194$:
	ld	a, b
;src/player.c:142: threeFrameCounter+=threeFrameCounterSpeed;
	ld	hl, #_threeFrameCounter
	add	a, (hl)
;src/player.c:143: uint8_t threeFrameCounterValue = threeFrameCounter>>4;
	ld	(hl), a
	swap	a
	and	a, #0x0f
	ldhl	sp,	#2
;src/player.c:144: if(threeFrameCounterValue>=3){
	ld	(hl), a
	sub	a, #0x03
	jr	C, 00102$
;src/player.c:145: threeFrameCounter=0;
	ld	hl, #_threeFrameCounter
	ld	(hl), #0x00
;src/player.c:146: threeFrameCounterValue=0;
	ldhl	sp,	#2
	ld	(hl), #0x00
00102$:
;src/player.c:149: uint8_t turning = FALSE;
	ldhl	sp,	#3
	ld	(hl), #0x00
;src/player.c:154: if(playerXVelocity<0){
	ld	a, (#_playerXVelocity)
	ldhl	sp,	#9
	ld	(hl), a
	ld	a, (#_playerXVelocity + 1)
	ldhl	sp,	#10
	ld	(hl+), a
	rlca
	and	a,#0x01
;src/player.c:157: playerXVelocity+=GROUND_FRICTION;
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#12
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/player.c:151: if(joypadCurrent &J_RIGHT){
	push	hl
	ldhl	sp,	#8
	bit	0, (hl)
	pop	hl
	jr	Z, 00134$
;src/player.c:154: if(playerXVelocity<0){
	ldhl	sp,	#11
	ld	a, (hl)
	or	a, a
	jr	Z, 00109$
;src/player.c:157: playerXVelocity+=GROUND_FRICTION;
	inc	hl
	ld	a, (hl)
	ld	(#_playerXVelocity),a
	ldhl	sp,	#13
	ld	a, (hl)
	ld	hl, #_playerXVelocity + 1
;src/player.c:160: if(playerXVelocity<0)turning=TRUE;
	ld	(hl-), a
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00104$
	ldhl	sp,	#3
	ld	(hl), #0x01
	jp	00135$
00104$:
;src/player.c:163: facingRight=TRUE;
	ld	hl, #_facingRight
	ld	(hl), #0x01
	jp	00135$
00109$:
;src/player.c:166: playerXVelocity=moveSpeed;
	ldhl	sp,	#7
	ld	a, (hl)
	ld	(#_playerXVelocity),a
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(#_playerXVelocity + 1),a
;src/player.c:169: if(!facingRight){
	ld	hl, #_facingRight
	ld	a, (hl)
	or	a, a
	jp	NZ, 00135$
;src/player.c:170: facingRight=TRUE;
	ld	(hl), #0x01
	jp	00135$
00134$:
;src/player.c:177: if(playerXVelocity>0){
	ldhl	sp,	#9
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00532$
	bit	7, d
	jr	NZ, 00533$
	cp	a, a
	jr	00533$
00532$:
	bit	7, d
	jr	Z, 00533$
	scf
00533$:
	ld	a, #0x00
	rla
	ldhl	sp,	#14
	ld	(hl), a
;src/player.c:180: playerXVelocity-=GROUND_FRICTION;
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	c, e
	ld	b, a
;src/player.c:174: }else if(joypadCurrent &J_LEFT){
	push	hl
	ldhl	sp,	#8
	bit	1, (hl)
	pop	hl
	jr	Z, 00131$
;src/player.c:177: if(playerXVelocity>0){
	ldhl	sp,	#14
	ld	a, (hl)
	or	a, a
	jr	Z, 00117$
;src/player.c:180: playerXVelocity-=GROUND_FRICTION;
	ld	hl, #_playerXVelocity
	ld	a, c
	ld	(hl+), a
;src/player.c:183: if(playerXVelocity>0)turning=TRUE;
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	e, b
	xor	a, a
	ld	d, a
	cp	a, c
	sbc	a, b
	bit	7, e
	jr	Z, 00535$
	bit	7, d
	jr	NZ, 00536$
	cp	a, a
	jr	00536$
00535$:
	bit	7, d
	jr	Z, 00536$
	scf
00536$:
	jr	NC, 00112$
	ldhl	sp,	#3
	ld	(hl), #0x01
	jr	00135$
00112$:
;src/player.c:186: facingRight=FALSE;
	ld	hl, #_facingRight
	ld	(hl), #0x00
	jr	00135$
00117$:
;src/player.c:190: playerXVelocity=-moveSpeed;
	ld	de, #0x0000
	ldhl	sp,	#7
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	hl, #_playerXVelocity + 1
	ld	(hl-), a
	ld	(hl), e
;src/player.c:193: if(facingRight){
	ld	hl, #_facingRight
	ld	a, (hl)
	or	a, a
	jr	Z, 00135$
;src/player.c:194: facingRight=FALSE;
	ld	(hl), #0x00
	jr	00135$
00131$:
;src/player.c:203: if (playerXVelocity > 0) {
	ldhl	sp,	#14
	ld	a, (hl)
	or	a, a
	jr	Z, 00128$
;src/player.c:204: if (playerXVelocity >= GROUND_FRICTION) playerXVelocity -= GROUND_FRICTION;
	ldhl	sp,	#9
	ld	a, (hl+)
	sub	a, #0x0f
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00537$
	bit	7, d
	jr	NZ, 00538$
	cp	a, a
	jr	00538$
00537$:
	bit	7, d
	jr	Z, 00538$
	scf
00538$:
	jr	C, 00120$
	ld	hl, #_playerXVelocity
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00135$
00120$:
;src/player.c:205: else playerXVelocity=0;
	xor	a, a
	ld	hl, #_playerXVelocity
	ld	(hl+), a
	ld	(hl), a
	jr	00135$
00128$:
;src/player.c:207: else if (playerXVelocity < 0) {
	ldhl	sp,	#11
	ld	a, (hl)
	or	a, a
	jr	Z, 00135$
;src/player.c:208: if (playerXVelocity <= GROUND_FRICTION) playerXVelocity += GROUND_FRICTION;
	inc	hl
	ld	a, (hl)
	ld	(#_playerXVelocity),a
	ldhl	sp,	#13
	ld	a, (hl)
	ld	(#_playerXVelocity + 1),a
;src/player.c:209: else playerXVelocity=0;
00135$:
;src/player.c:213: uint16_t playerRealX = playerX>>4;
	ld	hl, #_playerX
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
;src/player.c:214: uint16_t playerRealY = playerY>>4;
	ld	a, (#_playerY)
	ldhl	sp,	#4
	ld	(hl), a
	ld	a, (#_playerY + 1)
	ldhl	sp,	#5
	ld	(hl), a
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
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
;src/player.c:216: uint8_t grounded = FALSE;
	inc	hl
	inc	hl
;src/player.c:223: if(playerRealY<DEVICE_SCREEN_PX_HEIGHT){
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	sub	a, #0x90
	ld	a, (hl)
	sbc	a, #0x00
	jr	NC, 00140$
;src/player.c:226: while(IsTileSolid(playerRealX,playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT-1)){
00136$:
	ldhl	sp,	#4
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x0017
	add	hl, bc
	ld	c, l
	ld	b, h
	push	de
	call	_IsTileSolid
	pop	de
	or	a, a
	jr	Z, 00140$
;src/player.c:227: playerY-=16;
	ld	hl, #_playerY
	ld	a, (hl+)
	ld	b, (hl)
	dec	hl
	add	a, #0xf0
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	(hl), c
	inc	hl
;src/player.c:228: playerRealY = playerY>>4;
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ld	a, (#_playerY + 1)
	ldhl	sp,	#5
	ld	(hl), a
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
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	jr	00136$
00140$:
;src/player.c:226: while(IsTileSolid(playerRealX,playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT-1)){
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
;src/player.c:249: if(IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+2)||IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HALF_HEIGHT)||IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+(PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT-2)))playerXVelocity=0;
	ldhl	sp,	#11
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/player.c:242: if(playerXVelocity!=0){
	ld	hl, #_playerXVelocity + 1
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00155$
;src/player.c:245: if(playerXVelocity>0){
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	ld	a, (#_playerXVelocity + 1)
	ldhl	sp,	#14
	ld	(hl), a
;src/player.c:249: if(IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+2)||IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HALF_HEIGHT)||IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+(PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT-2)))playerXVelocity=0;
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl-)
	ld	b, a
	inc	bc
	inc	bc
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0016
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/player.c:245: if(playerXVelocity>0){
	ldhl	sp,	#13
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00539$
	bit	7, d
	jr	NZ, 00540$
	cp	a, a
	jr	00540$
00539$:
	bit	7, d
	jr	Z, 00540$
	scf
00540$:
	jr	NC, 00152$
;src/player.c:249: if(IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+2)||IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HALF_HEIGHT)||IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+(PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT-2)))playerXVelocity=0;
	ldhl	sp,#11
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	e, l
	ld	d, h
	push	de
	call	_IsTileSolid
	pop	de
	or	a, a
	jr	NZ, 00141$
	push	de
	ldhl	sp,	#2
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	call	_IsTileSolid
	pop	de
	or	a, a
	jr	NZ, 00141$
	ldhl	sp,	#9
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	call	_IsTileSolid
	or	a, a
	jr	Z, 00155$
00141$:
	xor	a, a
	ld	hl, #_playerXVelocity
	ld	(hl+), a
	ld	(hl), a
	jr	00155$
00152$:
;src/player.c:252: }else if(playerXVelocity<0){
	ldhl	sp,	#14
	bit	7, (hl)
	jr	Z, 00155$
;src/player.c:256: if(IsTileSolid(playerRealX-PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+2)||IsTileSolid(playerRealX-PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HALF_HEIGHT)||IsTileSolid(playerRealX-PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+(PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT-2)))playerXVelocity=0;
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#14
	ld	(hl-), a
	ld	(hl),e
	inc	hl
	ld	d, (hl)
	push	de
	call	_IsTileSolid
	pop	de
	or	a, a
	jr	NZ, 00145$
	push	de
	ldhl	sp,	#2
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	call	_IsTileSolid
	pop	de
	or	a, a
	jr	NZ, 00145$
	ldhl	sp,	#9
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	call	_IsTileSolid
	or	a, a
	jr	Z, 00155$
00145$:
	xor	a, a
	ld	hl, #_playerXVelocity
	ld	(hl+), a
	ld	(hl), a
00155$:
;src/player.c:261: if(playerYVelocity>=0){
	ld	a, (#_playerYVelocity)
	ldhl	sp,	#9
	ld	(hl), a
	ld	a, (#_playerYVelocity + 1)
	ldhl	sp,	#10
;src/player.c:265: if(IsTileSolid(playerRealX+(PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH-2),playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT)||IsTileSolid(playerRealX-(PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH-2),playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT)){
	ld	(hl+), a
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl-)
	ld	b, a
	inc	bc
	inc	bc
	inc	bc
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#14
	ld	(hl-), a
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, c
	ld	(hl+), a
;src/player.c:261: if(playerYVelocity>=0){
	ld	a, b
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	bit	7, a
	jr	NZ, 00160$
;src/player.c:265: if(IsTileSolid(playerRealX+(PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH-2),playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT)||IsTileSolid(playerRealX-(PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH-2),playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT)){
	dec	hl
	dec	hl
	dec	hl
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, #0x0018
	add	hl, de
	ld	e, l
	ld	d, h
	push	de
	ld	c, e
	ld	b, d
	ldhl	sp,	#13
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_IsTileSolid
	pop	de
	or	a, a
	jr	NZ, 00156$
	ld	c, e
	ld	b, d
	ldhl	sp,	#13
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_IsTileSolid
	or	a, a
	jr	Z, 00167$
00156$:
;src/player.c:266: playerYVelocity=0;
	xor	a, a
	ld	hl, #_playerYVelocity
	ld	(hl+), a
	ld	(hl), a
;src/player.c:267: grounded=TRUE;
	ldhl	sp,	#6
	ld	(hl), #0x01
	jr	00167$
;src/player.c:277: while(IsTileSolid(playerRealX+(PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH-2),playerRealY)||IsTileSolid(playerRealX-(PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH-2),playerRealY)){
00160$:
	ldhl	sp,	#4
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ldhl	sp,	#11
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_IsTileSolid
	or	a, a
	jr	NZ, 00161$
	ldhl	sp,	#4
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ldhl	sp,	#13
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_IsTileSolid
	or	a, a
	jr	Z, 00167$
00161$:
;src/player.c:278: playerYVelocity=0;
	xor	a, a
	ld	hl, #_playerYVelocity
	ld	(hl+), a
	ld	(hl), a
;src/player.c:279: playerY+=16;
	ld	hl, #_playerY
	ld	a, (hl+)
	ld	b, (hl)
	dec	hl
	add	a, #0x10
	ld	c, a
	ld	a, b
	adc	a, #0x00
	ld	(hl), c
	inc	hl
;src/player.c:280: playerRealY = playerY>>4;
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ld	a, (#_playerY + 1)
	ldhl	sp,	#5
	ld	(hl), a
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
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	jr	00160$
00167$:
;src/player.c:286: uint8_t pressedA = (joypadCurrent & J_A && !(joypadPrevious & J_A));
	ld	a, (#_joypadCurrent)
	swap	a
	and	a,#0x01
	jr	Z, 00195$
	ld	a, (#_joypadPrevious)
	swap	a
	and	a,#0x01
	jr	Z, 00196$
00195$:
	ld	c, #0x00
	jr	00197$
00196$:
	ld	c, #0x01
00197$:
;src/player.c:287: uint8_t pressedUp = (joypadCurrent & J_UP && !(joypadPrevious & J_UP));
	ld	a, (#_joypadCurrent)
	rrca
	rrca
	and	a,#0x01
	jr	Z, 00198$
	ld	a, (#_joypadPrevious)
	rrca
	rrca
	and	a,#0x01
	jr	Z, 00199$
00198$:
	xor	a, a
	jr	00200$
00199$:
	ld	a, #0x01
00200$:
;src/player.c:288: uint8_t pressedAOrUp = pressedA||pressedUp;
	inc	c
	dec	c
	jr	NZ, 00202$
	or	a,a
	jr	NZ, 00202$
	ld	c,a
	jr	00203$
00202$:
	ld	c, #0x01
00203$:
;src/player.c:291: if(grounded && pressedAOrUp){
	ldhl	sp,	#6
	ld	a, (hl)
	or	a, a
	jr	Z, 00169$
	ld	a, c
	or	a, a
	jr	Z, 00169$
;src/player.c:292: playerYVelocity=-PLAYER_CHARACTER_JUMP_VELOCITY;
	ld	hl, #_playerYVelocity
	ld	a, #0xda
	ld	(hl+), a
	ld	(hl), #0xfd
;src/player.c:293: playerJumpIncrease=PLAYER_CHARACTER_INCREASE_JUMP_TIMER_MAX;
	ld	hl, #_playerJumpIncrease
	ld	(hl), #0x14
00169$:
;src/player.c:261: if(playerYVelocity>=0){
	ld	hl, #_playerYVelocity
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/player.c:297: if(!grounded){
	ldhl	sp,	#6
	ld	a, (hl)
	or	a, a
	jr	NZ, 00180$
;src/player.c:300: if(playerJumpIncrease>0)playerJumpIncrease--;
	ld	hl, #_playerJumpIncrease
	ld	a, (hl)
	or	a, a
	jr	Z, 00172$
	dec	(hl)
00172$:
;src/player.c:139: int16_t moveSpeed = (joypadCurrent & J_B) ?PLAYER_CHARACTER_RUN_VELOCITY:PLAYER_CHARACTER_WALK_VELOCITY;
	ld	a, (#_joypadCurrent)
;src/player.c:303: if(!((joypadCurrent & J_A||joypadCurrent & J_UP))||playerJumpIncrease==0){
	bit	4, a
	jr	NZ, 00176$
	bit	2, a
	jr	Z, 00173$
00176$:
	ld	a, (#_playerJumpIncrease)
	or	a, a
	jr	NZ, 00181$
00173$:
;src/player.c:306: playerYVelocity+=GRAVTY;
	ld	hl, #0x002d
	add	hl, bc
	ld	c, l
	ld	a, h
	ld	hl, #_playerYVelocity
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/player.c:309: playerJumpIncrease=0;
	ld	hl, #_playerJumpIncrease
	ld	(hl), #0x00
	jr	00181$
00180$:
;src/player.c:313: }else if(playerYVelocity>=0){
	bit	7, b
	jr	NZ, 00181$
;src/player.c:316: playerYVelocity=0;
	xor	a, a
	ld	hl, #_playerYVelocity
	ld	(hl+), a
	ld	(hl), a
00181$:
;src/player.c:320: playerX+=playerXVelocity>>4;
	ld	a, (#_playerXVelocity)
	ldhl	sp,	#4
	ld	(hl), a
	ld	a, (#_playerXVelocity + 1)
	ldhl	sp,	#5
	ld	(hl), a
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #_playerX
	ld	a, (hl)
	add	a, c
	ld	(hl+), a
	ld	a, (hl)
	adc	a, b
	ld	(hl), a
;src/player.c:321: playerY+=playerYVelocity>>4;
	ld	hl, #_playerYVelocity
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ld	hl, #_playerY
	ld	a, (hl)
	add	a, c
	ld	(hl+), a
	ld	a, (hl)
	adc	a, b
	ld	(hl), a
;src/player.c:324: playerRealX = playerX>>4;
	ld	a, (#_playerX)
	ldhl	sp,	#7
	ld	(hl), a
	ld	a, (#_playerX + 1)
	ldhl	sp,	#8
	ld	(hl), a
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
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
;src/player.c:325: playerRealY = playerY>>4;
	ld	a, (#_playerY)
	ldhl	sp,	#9
	ld	(hl), a
	ld	a, (#_playerY + 1)
	ldhl	sp,	#10
	ld	(hl), a
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
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
;src/player.c:249: if(IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+2)||IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HALF_HEIGHT)||IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+(PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT-2)))playerXVelocity=0;
	dec	hl
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
;src/player.c:328: if(playerRealX>=(DEVICE_SCREEN_PX_WIDTH>>1)){
	ldhl	sp,	#7
	ld	a, (hl+)
	sub	a, #0x50
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00185$
;src/player.c:329: uint16_t max = currentLevelWidth-DEVICE_SCREEN_PX_WIDTH;
	ld	hl, #_currentLevelWidth
	ld	a, (hl+)
	ld	b, (hl)
	add	a, #0x60
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
;src/player.c:330: camera_x=playerRealX-(DEVICE_SCREEN_PX_WIDTH>>1);
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0050
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#14
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl)
	ld	(#_camera_x),a
	ldhl	sp,	#14
	ld	a, (hl)
	ld	hl, #_camera_x + 1
;src/player.c:333: if(camera_x>max)camera_x=max;
	ld	(hl-), a
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00186$
	ld	hl, #_camera_x
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00186$
00185$:
;src/player.c:335: else camera_x=0;
	xor	a, a
	ld	hl, #_camera_x
	ld	(hl+), a
	ld	(hl), a
00186$:
;src/player.c:345: uint8_t frame = grounded ? (turning ? 5 :((playerXVelocity>>4)==0 ? 0 : threeFrameCounterValue)) : (playerYVelocity<0 ? 3 : 4);
	ldhl	sp,	#6
	ld	a, (hl)
	or	a, a
	jr	Z, 00204$
	ldhl	sp,	#3
	ld	a, (hl)
	or	a, a
	jr	Z, 00206$
	ld	c, #0x05
	jr	00205$
00206$:
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a,(hl)
	jr	NZ, 00208$
	ld	c,a
	jr	00205$
00208$:
	ldhl	sp,	#2
	ld	c, (hl)
	jr	00205$
00204$:
	ld	a, (#_playerYVelocity)
	ldhl	sp,	#13
	ld	(hl), a
	ld	a, (#_playerYVelocity + 1)
	ldhl	sp,	#14
	ld	(hl), a
	bit	7, (hl)
	jr	Z, 00210$
	ld	(hl), #0x03
	jr	00211$
00210$:
	ldhl	sp,	#14
	ld	(hl), #0x04
00211$:
	ldhl	sp,	#14
	ld	c, (hl)
00205$:
;src/player.c:346: uint8_t directionOffset = facingRight ? 0 : 6;
	ld	a, (#_facingRight)
	or	a, a
	jr	Z, 00212$
	xor	a, a
	jr	00213$
00212$:
	ld	a, #0x06
00213$:
;src/player.c:348: uint8_t spritesUsed = DrawPlayer(playerRealX,playerRealY,frame+directionOffset);
	add	a, c
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ldhl	sp,	#8
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_DrawPlayer
	ld	c, a
;src/player.c:351: if(playerRealX>currentLevelWidth-32){
	ld	hl, #_currentLevelWidth
	ld	a, (hl+)
	ld	b, (hl)
	add	a, #0xe0
	ld	e, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ldhl	sp,	#11
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00188$
;src/player.c:352: nextLevel++;
	ld	hl, #_nextLevel
	inc	(hl)
00188$:
;src/player.c:355: return spritesUsed;
	ld	a, c
;src/player.c:356: }
	add	sp, #15
	ret
	.area _CODE_255
	.area _INITIALIZER
__xinit__facingRight:
	.db #0x01	; 1
__xinit__playerJumpIncrease:
	.db #0x00	; 0
__xinit__threeFrameCounter:
	.db #0x00	; 0
	.area _CABS (ABS)
