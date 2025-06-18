;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module player
	.optsdcc -mz80
	
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
	.globl _set_sprite_native_data
	.globl _set_palette
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
	ld	a, (_MAP_FRAME1+0)
	ld	c, a
;src/player.c:71: SWITCH_ROM(BANK(PlayerCharacterSprites));
	ld	hl, #_MAP_FRAME1
	ld	(hl), #<(___bank_PlayerCharacterSprites)
;src/player.c:73: set_player_sprite_data (0,PlayerCharacterSprites_TILE_COUNT,PlayerCharacterSprites_tiles);
	push	bc
	ld	hl, #_PlayerCharacterSprites_tiles
	push	hl
	ld	de, #0x007c
	xor	a, a
	call	_set_sprite_native_data
	pop	bc
;src/player.c:75: SWITCH_ROM(_previous_bank);
	ld	hl, #_MAP_FRAME1
	ld	(hl), c
;src/player.c:76: }
	ret
_baseProp:
	.db #0x00	; 0
_PlayerPalettesGGSMS:
	.db #0x1b	; 27
	.db #0x3f	; 63
	.db #0x2a	; 42
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x20	; 32
	.db #0x09	; 9
	.db #0x18	; 24
	.db #0x11	; 17
	.db #0x03	; 3
	.db #0x0c	; 12
	.db #0x30	; 48	'0'
	.db #0x0f	; 15
	.db #0x3c	; 60
	.db #0x3b	; 59
;src/player.c:78: void SetPlayerPalettes(void) NONBANKED{
;	---------------------------------
; Function SetPlayerPalettes
; ---------------------------------
_SetPlayerPalettes::
;src/player.c:79: uint8_t _previous_bank = CURRENT_BANK;
	ld	a, (_MAP_FRAME1+0)
	ld	c, a
;src/player.c:81: SWITCH_ROM(PLAYER_PALETTES_BANK);
;src/player.c:85: set_sprite_palette(baseProp, 1, PLAYER_PALETTES);
	push	bc
	ld	hl, #_PlayerPalettesGGSMS
	push	hl
	ld	hl, #0x101
	push	hl
	call	_set_palette
	pop	bc
;src/player.c:95: SWITCH_ROM(_previous_bank);
	ld	hl, #_MAP_FRAME1
	ld	(hl), c
;src/player.c:96: }
	ret
;src/player.c:116: uint8_t DrawPlayer(uint16_t playerRealX, uint16_t playerRealY, uint8_t frame) NONBANKED{
;	---------------------------------
; Function DrawPlayer
; ---------------------------------
_DrawPlayer::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
	ld	c, l
	ld	b, h
;src/player.c:119: uint8_t _previous_bank = CURRENT_BANK;
	ld	a, (_MAP_FRAME1+0)
	ld	-1 (ix), a
;src/player.c:123: uint16_t playerCameraX = (playerRealX-camera_x)+DEVICE_SPRITE_PX_OFFSET_X;
	ld	hl, #_camera_x
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	c, a
	ld	a, b
	sbc	a, (hl)
	ld	b, a
;src/player.c:124: uint16_t playerCameraY= (playerRealY)+DEVICE_SPRITE_PX_OFFSET_Y;
	ld	hl, #0xffff
	add	hl, de
	ex	de, hl
;src/player.c:126: SWITCH_ROM(BANK(PlayerCharacterSprites));
	ld	hl, #_MAP_FRAME1
	ld	(hl), #<(___bank_PlayerCharacterSprites)
;src/player.c:128: spritesUsed = move_metasprite_ex(PlayerCharacterSprites_metasprites[frame],0,baseProp,0,playerCameraX,playerCameraY);
	ld	l, 4 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	push	de
	ld	de, #_PlayerCharacterSprites_metasprites
	add	hl, de
	pop	de
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
;../../../include/sms/metasprites.h:83: __current_metasprite = metasprite;
	ld	(___current_metasprite), hl
;../../../include/sms/metasprites.h:84: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x00
;../../../include/sms/metasprites.h:85: return __move_metasprite(base_sprite, x, y);
	push	de
	ld	e, c
	ld	d, b
	xor	a, a
	call	___move_metasprite
	ld	c, a
;src/player.c:130: SWITCH_ROM(_previous_bank);
	ld	a, -1 (ix)
	ld	(_MAP_FRAME1+0), a
;src/player.c:132: return spritesUsed;
	ld	a, c
;src/player.c:133: }
	inc	sp
	pop	ix
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
	ld	hl, #0x0280
	ld	(_playerX), hl
;src/player.c:103: playerY=40<<4;
	ld	(_playerY), hl
;src/player.c:105: playerXVelocity=0;
	ld	hl, #0x0000
	ld	(_playerXVelocity), hl
;src/player.c:106: playerYVelocity=0;
	ld	(_playerYVelocity), hl
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
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-11
	add	hl, sp
	ld	sp, hl
;src/player.c:139: int16_t moveSpeed = (joypadCurrent & J_B) ?PLAYER_CHARACTER_RUN_VELOCITY:PLAYER_CHARACTER_WALK_VELOCITY;
	ld	a, (_joypadCurrent+0)
	ld	-5 (ix), a
	and	a,#0x10
	jr	Z, 00191$
	ld	de, #0x01a9
	jr	00192$
00191$:
	ld	de, #0x0145
00192$:
;src/player.c:140: uint8_t threeFrameCounterSpeed = (joypadCurrent & J_B) ? PLAYER_CHARACTER_RUN_TWO_FRAME_COUNTER : PLAYER_CHARACTER_WALK_TWO_FRAME_COUNTER;
	or	a, a
	ld	a, #0x05
	jr	NZ, 00194$
	ld	a, #0x03
00194$:
;src/player.c:142: threeFrameCounter+=threeFrameCounterSpeed;
	ld	hl, #_threeFrameCounter
	add	a, (hl)
	ld	(hl), a
;src/player.c:143: uint8_t threeFrameCounterValue = threeFrameCounter>>4;
	ld	a, (_threeFrameCounter+0)
	rlca
	rlca
	rlca
	rlca
	and	a, #0x0f
;src/player.c:144: if(threeFrameCounterValue>=3){
	ld	-11 (ix), a
	sub	a, #0x03
	jr	C, 00102$
;src/player.c:145: threeFrameCounter=0;
	xor	a, a
	ld	(#_threeFrameCounter), a
;src/player.c:146: threeFrameCounterValue=0;
	ld	-11 (ix), #0x00
00102$:
;src/player.c:149: uint8_t turning = FALSE;
	ld	-10 (ix), #0x00
;src/player.c:154: if(playerXVelocity<0){
	ld	bc, (_playerXVelocity)
	ld	a, b
	rlca
	and	a,#0x01
	ld	-4 (ix), a
;src/player.c:157: playerXVelocity+=GROUND_FRICTION;
	ld	iy, #0x000f
	add	iy, bc
;src/player.c:151: if(joypadCurrent &J_RIGHT){
	bit	3, -5 (ix)
	jr	Z, 00134$
;src/player.c:154: if(playerXVelocity<0){
	ld	a, -4 (ix)
	or	a, a
	jr	Z, 00109$
;src/player.c:157: playerXVelocity+=GROUND_FRICTION;
	ld	(_playerXVelocity), iy
;src/player.c:160: if(playerXVelocity<0)turning=TRUE;
	ld	hl, (_playerXVelocity)
	bit	7, h
	jr	Z, 00104$
	ld	-10 (ix), #0x01
	jp	00135$
00104$:
;src/player.c:163: facingRight=TRUE;
	ld	hl, #_facingRight
	ld	(hl), #0x01
	jp	00135$
00109$:
;src/player.c:166: playerXVelocity=moveSpeed;
	ld	(_playerXVelocity), de
;src/player.c:169: if(!facingRight){
	ld	a, (_facingRight+0)
	or	a, a
	jp	NZ, 00135$
;src/player.c:170: facingRight=TRUE;
	ld	hl, #_facingRight
	ld	(hl), #0x01
	jp	00135$
00134$:
;src/player.c:177: if(playerXVelocity>0){
	xor	a, a
	cp	a, c
	sbc	a, b
	jp	PO, 00532$
	xor	a, #0x80
00532$:
	rlca
	and	a,#0x01
	ld	-3 (ix), a
;src/player.c:180: playerXVelocity-=GROUND_FRICTION;
	ld	a, c
	add	a, #0xf1
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, b
	adc	a, #0xff
	ld	-2 (ix), l
	ld	-1 (ix), a
;src/player.c:174: }else if(joypadCurrent &J_LEFT){
	bit	2, -5 (ix)
	jr	Z, 00131$
;src/player.c:177: if(playerXVelocity>0){
	ld	a, -3 (ix)
	or	a, a
	jr	Z, 00117$
;src/player.c:180: playerXVelocity-=GROUND_FRICTION;
	ld	l, -2 (ix)
	ld	h, -1 (ix)
;src/player.c:183: if(playerXVelocity>0)turning=TRUE;
	ld	(_playerXVelocity), hl
	xor	a, a
	cp	a, l
	sbc	a, h
	jp	PO, 00534$
	xor	a, #0x80
00534$:
	jp	P, 00112$
	ld	-10 (ix), #0x01
	jr	00135$
00112$:
;src/player.c:186: facingRight=FALSE;
	ld	hl, #_facingRight
	ld	(hl), #0x00
	jr	00135$
00117$:
;src/player.c:190: playerXVelocity=-moveSpeed;
	ld	hl, #_playerXVelocity
	xor	a, a
	sub	a, e
	ld	(hl), a
	inc	hl
	sbc	a, a
	sub	a, d
	ld	(hl), a
;src/player.c:193: if(facingRight){
	ld	a, (_facingRight+0)
	or	a, a
	jr	Z, 00135$
;src/player.c:194: facingRight=FALSE;
	ld	hl, #_facingRight
	ld	(hl), #0x00
	jr	00135$
00131$:
;src/player.c:203: if (playerXVelocity > 0) {
	ld	a, -3 (ix)
	or	a, a
	jr	Z, 00128$
;src/player.c:204: if (playerXVelocity >= GROUND_FRICTION) playerXVelocity -= GROUND_FRICTION;
	ld	a, c
	sub	a, #0x0f
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	C, 00120$
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	(_playerXVelocity), hl
	jr	00135$
00120$:
;src/player.c:205: else playerXVelocity=0;
	ld	hl, #0x0000
	ld	(_playerXVelocity), hl
	jr	00135$
00128$:
;src/player.c:207: else if (playerXVelocity < 0) {
	ld	a, -4 (ix)
	or	a, a
	jr	Z, 00135$
;src/player.c:208: if (playerXVelocity <= GROUND_FRICTION) playerXVelocity += GROUND_FRICTION;
	ld	(_playerXVelocity), iy
;src/player.c:209: else playerXVelocity=0;
00135$:
;src/player.c:213: uint16_t playerRealX = playerX>>4;
	ld	a, (_playerX+0)
	ld	-2 (ix), a
	ld	a, (_playerX+1)
	ld	-1 (ix), a
	srl	-1 (ix)
	rr	-2 (ix)
	srl	-1 (ix)
	rr	-2 (ix)
	srl	-1 (ix)
	rr	-2 (ix)
	srl	-1 (ix)
	rr	-2 (ix)
;src/player.c:214: uint16_t playerRealY = playerY>>4;
	ld	bc, (_playerY)
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
;src/player.c:216: uint8_t grounded = FALSE;
	ld	-9 (ix), #0x00
;src/player.c:223: if(playerRealY<DEVICE_SCREEN_PX_HEIGHT){
	ld	a, c
	sub	a, #0xc0
	ld	a, b
	sbc	a, #0x00
	jr	NC, 00140$
;src/player.c:226: while(IsTileSolid(playerRealX,playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT-1)){
00136$:
	ld	e, c
	ld	d, b
	ld	hl, #0x0017
	add	hl, de
	push	bc
	ex	de, hl
	ld	l, -2 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	_IsTileSolid
	pop	bc
	or	a, a
	jr	Z, 00140$
;src/player.c:227: playerY-=16;
	ld	hl, (_playerY)
	ld	a, l
	add	a, #0xf0
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	adc	a, #0xff
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	(_playerY), hl
;src/player.c:228: playerRealY = playerY>>4;
	ld	bc, (_playerY)
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	jr	00136$
00140$:
;src/player.c:226: while(IsTileSolid(playerRealX,playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT-1)){
	ld	-8 (ix), c
	ld	-7 (ix), b
;src/player.c:249: if(IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+2)||IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HALF_HEIGHT)||IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+(PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT-2)))playerXVelocity=0;
;src/player.c:242: if(playerXVelocity!=0){
	ld	a, (_playerXVelocity+1)
	ld	hl, #_playerXVelocity
	or	a, (hl)
	jp	Z, 00155$
;src/player.c:245: if(playerXVelocity>0){
	ld	hl, (_playerXVelocity)
	ld	-6 (ix), l
	ld	-5 (ix), h
;src/player.c:249: if(IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+2)||IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HALF_HEIGHT)||IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+(PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT-2)))playerXVelocity=0;
	ld	e, -8 (ix)
	ld	d, -7 (ix)
	inc	de
	inc	de
	ld	iy, #0x000c
	push	bc
	ld	c, -8 (ix)
	ld	b, -7 (ix)
	add	iy, bc
	pop	bc
	ld	a, -8 (ix)
	add	a, #0x16
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, -7 (ix)
	adc	a, #0x00
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	-4 (ix), l
	ld	-3 (ix), h
;src/player.c:245: if(playerXVelocity>0){
	xor	a, a
	cp	a, -6 (ix)
	sbc	a, -5 (ix)
	jp	PO, 00535$
	xor	a, #0x80
00535$:
	jp	P, 00152$
;src/player.c:249: if(IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+2)||IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HALF_HEIGHT)||IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+(PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT-2)))playerXVelocity=0;
	ld	a, -2 (ix)
	add	a, #0x05
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, -1 (ix)
	adc	a, #0x00
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	push	bc
	push	iy
	call	_IsTileSolid
	pop	iy
	pop	bc
	pop	hl
	or	a, a
	jr	NZ, 00141$
	push	hl
	push	bc
	push	iy
	pop	de
	call	_IsTileSolid
	pop	bc
	pop	hl
	or	a, a
	jr	NZ, 00141$
	push	bc
	ld	e, -4 (ix)
	ld	d, -3 (ix)
	call	_IsTileSolid
	pop	bc
	or	a, a
	jr	Z, 00155$
00141$:
	ld	hl, #0x0000
	ld	(_playerXVelocity), hl
	jr	00155$
00152$:
;src/player.c:252: }else if(playerXVelocity<0){
	bit	7, -5 (ix)
	jr	Z, 00155$
;src/player.c:256: if(IsTileSolid(playerRealX-PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+2)||IsTileSolid(playerRealX-PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HALF_HEIGHT)||IsTileSolid(playerRealX-PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+(PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT-2)))playerXVelocity=0;
	ld	a, -2 (ix)
	add	a, #0xfb
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, -1 (ix)
	adc	a, #0xff
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	push	bc
	push	iy
	call	_IsTileSolid
	pop	iy
	pop	bc
	pop	hl
	or	a, a
	jr	NZ, 00145$
	push	hl
	push	bc
	push	iy
	pop	de
	call	_IsTileSolid
	pop	bc
	pop	hl
	or	a, a
	jr	NZ, 00145$
	push	bc
	ld	e, -4 (ix)
	ld	d, -3 (ix)
	call	_IsTileSolid
	pop	bc
	or	a, a
	jr	Z, 00155$
00145$:
	ld	hl, #0x0000
	ld	(_playerXVelocity), hl
00155$:
;src/player.c:261: if(playerYVelocity>=0){
	ld	hl, (_playerYVelocity)
	ld	-6 (ix), l
	ld	-5 (ix), h
;src/player.c:265: if(IsTileSolid(playerRealX+(PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH-2),playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT)||IsTileSolid(playerRealX-(PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH-2),playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT)){
	ld	l, -2 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	inc	hl
	ld	a, -2 (ix)
	add	a, #0xfd
	ld	e, a
	ld	a, -1 (ix)
	adc	a, #0xff
	ld	d, a
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	-2 (ix), e
	ld	-1 (ix), d
;src/player.c:261: if(playerYVelocity>=0){
	bit	7, -5 (ix)
	jr	NZ, 00160$
;src/player.c:265: if(IsTileSolid(playerRealX+(PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH-2),playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT)||IsTileSolid(playerRealX-(PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH-2),playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT)){
	ld	l, -8 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -7 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	de, #0x0018
	add	hl, de
	ex	de, hl
	push	de
	ld	l, -4 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -3 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	_IsTileSolid
	pop	hl
	or	a, a
	jr	NZ, 00156$
	ex	de, hl
	ld	l, -2 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	_IsTileSolid
	or	a, a
	jr	Z, 00167$
00156$:
;src/player.c:266: playerYVelocity=0;
	ld	hl, #0x0000
	ld	(_playerYVelocity), hl
;src/player.c:267: grounded=TRUE;
	ld	-9 (ix), #0x01
	jr	00167$
;src/player.c:277: while(IsTileSolid(playerRealX+(PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH-2),playerRealY)||IsTileSolid(playerRealX-(PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH-2),playerRealY)){
00160$:
	push	bc
	ld	e, c
	ld	d, b
	ld	l, -4 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -3 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	_IsTileSolid
	pop	bc
	or	a, a
	jr	NZ, 00161$
	ld	e, c
	ld	d, b
	ld	l, -2 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	_IsTileSolid
	or	a, a
	jr	Z, 00167$
00161$:
;src/player.c:278: playerYVelocity=0;
	ld	hl, #0x0000
	ld	(_playerYVelocity), hl
;src/player.c:279: playerY+=16;
	ld	hl, (_playerY)
	ld	bc, #0x0010
	add	hl, bc
	ld	(_playerY), hl
;src/player.c:280: playerRealY = playerY>>4;
	ld	bc, (_playerY)
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	jr	00160$
00167$:
;src/player.c:286: uint8_t pressedA = (joypadCurrent & J_A && !(joypadPrevious & J_A));
	ld	a, (_joypadCurrent+0)
	rlca
	rlca
	rlca
	jr	NC, 00195$
	ld	a, (_joypadPrevious+0)
	rlca
	rlca
	rlca
	jr	NC, 00196$
00195$:
	ld	c, #0x00
	jr	00197$
00196$:
	ld	c, #0x01
00197$:
;src/player.c:287: uint8_t pressedUp = (joypadCurrent & J_UP && !(joypadPrevious & J_UP));
	ld	a, (_joypadCurrent+0)
	and	a,#0x01
	jr	Z, 00198$
	ld	a, (_joypadPrevious+0)
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
	ld	a, -9 (ix)
	or	a, a
	jr	Z, 00169$
	ld	a, c
	or	a, a
	jr	Z, 00169$
;src/player.c:292: playerYVelocity=-PLAYER_CHARACTER_JUMP_VELOCITY;
	ld	hl, #0xfdda
	ld	(_playerYVelocity), hl
;src/player.c:293: playerJumpIncrease=PLAYER_CHARACTER_INCREASE_JUMP_TIMER_MAX;
	ld	hl, #_playerJumpIncrease
	ld	(hl), #0x14
00169$:
;src/player.c:261: if(playerYVelocity>=0){
	ld	bc, (_playerYVelocity)
;src/player.c:297: if(!grounded){
	ld	a, -9 (ix)
	or	a, a
	jr	NZ, 00180$
;src/player.c:300: if(playerJumpIncrease>0)playerJumpIncrease--;
	ld	a, (_playerJumpIncrease+0)
	or	a, a
	jr	Z, 00172$
	ld	hl, #_playerJumpIncrease
	dec	(hl)
00172$:
;src/player.c:139: int16_t moveSpeed = (joypadCurrent & J_B) ?PLAYER_CHARACTER_RUN_VELOCITY:PLAYER_CHARACTER_WALK_VELOCITY;
	ld	a, (_joypadCurrent+0)
;src/player.c:303: if(!((joypadCurrent & J_A||joypadCurrent & J_UP))||playerJumpIncrease==0){
	bit	5, a
	jr	NZ, 00176$
	rrca
	jr	NC, 00173$
00176$:
	ld	a, (_playerJumpIncrease+0)
	or	a, a
	jr	NZ, 00181$
00173$:
;src/player.c:306: playerYVelocity+=GRAVTY;
	ld	hl, #0x002d
	add	hl, bc
	ld	(_playerYVelocity), hl
;src/player.c:309: playerJumpIncrease=0;
	ld	hl, #_playerJumpIncrease
	ld	(hl), #0x00
	jr	00181$
00180$:
;src/player.c:313: }else if(playerYVelocity>=0){
	bit	7, b
	jr	NZ, 00181$
;src/player.c:316: playerYVelocity=0;
	ld	hl, #0x0000
	ld	(_playerYVelocity), hl
00181$:
;src/player.c:320: playerX+=playerXVelocity>>4;
	ld	a, (_playerXVelocity+0)
	ld	-8 (ix), a
	ld	a, (_playerXVelocity+1)
	ld	-7 (ix), a
	sra	-7 (ix)
	rr	-8 (ix)
	sra	-7 (ix)
	rr	-8 (ix)
	sra	-7 (ix)
	rr	-8 (ix)
	sra	-7 (ix)
	rr	-8 (ix)
	ld	a, -8 (ix)
	ld	e, -7 (ix)
	ld	hl, #_playerX
	add	a, (hl)
	ld	(hl), a
	inc	hl
	ld	a, e
	adc	a, (hl)
	ld	(hl), a
;src/player.c:321: playerY+=playerYVelocity>>4;
	ld	hl, (_playerYVelocity)
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	ld	c, l
	ld	e, h
	ld	a, c
	ld	hl, #_playerY
	add	a, (hl)
	ld	(hl), a
	inc	hl
	ld	a, e
	adc	a, (hl)
	ld	(hl), a
;src/player.c:324: playerRealX = playerX>>4;
	ld	a, (_playerX+0)
	ld	-6 (ix), a
	ld	a, (_playerX+1)
	ld	-5 (ix), a
	srl	-5 (ix)
	rr	-6 (ix)
	srl	-5 (ix)
	rr	-6 (ix)
	srl	-5 (ix)
	rr	-6 (ix)
	srl	-5 (ix)
	rr	-6 (ix)
;src/player.c:325: playerRealY = playerY>>4;
	ld	a, (_playerY+0)
	ld	-4 (ix), a
	ld	a, (_playerY+1)
	ld	-3 (ix), a
	srl	-3 (ix)
	rr	-4 (ix)
	srl	-3 (ix)
	rr	-4 (ix)
	srl	-3 (ix)
	rr	-4 (ix)
	srl	-3 (ix)
	rr	-4 (ix)
;src/player.c:249: if(IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+2)||IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+PLAYER_CHARACTER_BOUNDING_BOX_HALF_HEIGHT)||IsTileSolid(playerRealX+PLAYER_CHARACTER_BOUNDING_BOX_HALF_WIDTH,playerRealY+(PLAYER_CHARACTER_BOUNDING_BOX_HEIGHT-2)))playerXVelocity=0;
	ld	a, -6 (ix)
	ld	-2 (ix), a
	ld	a, -5 (ix)
	ld	-1 (ix), a
;src/player.c:328: if(playerRealX>=(DEVICE_SCREEN_PX_WIDTH>>1)){
	ld	a, -6 (ix)
	sub	a, #0x80
	ld	a, -5 (ix)
	sbc	a, #0x00
	jr	C, 00185$
;src/player.c:329: uint16_t max = currentLevelWidth-DEVICE_SCREEN_PX_WIDTH;
	ld	hl, (_currentLevelWidth)
	ld	c, l
	ld	a,h
	dec	a
	ld	b, a
;src/player.c:330: camera_x=playerRealX-(DEVICE_SCREEN_PX_WIDTH>>1);
	ld	a, -2 (ix)
	add	a, #0x80
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, -1 (ix)
	adc	a, #0xff
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	(_camera_x), hl
;src/player.c:333: if(camera_x>max)camera_x=max;
	ld	a, c
	ld	iy, #_camera_x
	sub	a, 0 (iy)
	ld	a, b
	sbc	a, 1 (iy)
	jr	NC, 00186$
	ld	(_camera_x), bc
	jr	00186$
00185$:
;src/player.c:335: else camera_x=0;
	ld	hl, #0x0000
	ld	(_camera_x), hl
00186$:
;src/player.c:345: uint8_t frame = grounded ? (turning ? 5 :((playerXVelocity>>4)==0 ? 0 : threeFrameCounterValue)) : (playerYVelocity<0 ? 3 : 4);
	ld	a, -9 (ix)
	or	a, a
	jr	Z, 00204$
	ld	a, -10 (ix)
	or	a, a
	jr	Z, 00206$
	ld	-7 (ix), #0x05
	jr	00207$
00206$:
	ld	a, -7 (ix)
	or	a, -8 (ix)
	jr	NZ, 00208$
	xor	a, a
	jr	00209$
00208$:
	ld	a, -11 (ix)
00209$:
	ld	-7 (ix), a
00207$:
	ld	a, -7 (ix)
	jr	00205$
00204$:
	ld	hl, (_playerYVelocity)
	ld	-8 (ix), l
	ld	-7 (ix), h
	bit	7, -7 (ix)
	jr	Z, 00210$
	ld	-7 (ix), #0x03
	jr	00211$
00210$:
	ld	-7 (ix), #0x04
00211$:
	ld	a, -7 (ix)
00205$:
	ld	-9 (ix), a
;src/player.c:346: uint8_t directionOffset = facingRight ? 0 : 6;
	ld	a, (_facingRight+0)
	or	a, a
	jr	Z, 00212$
	xor	a, a
	jr	00213$
00212$:
	ld	a, #0x06
00213$:
;src/player.c:348: uint8_t spritesUsed = DrawPlayer(playerRealX,playerRealY,frame+directionOffset);
	ld	-7 (ix), a
	add	a, -9 (ix)
	ld	-7 (ix), a
	push	af
	inc	sp
	ld	e, -4 (ix)
	ld	d, -3 (ix)
	ld	l, -6 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -5 (ix)
;	spillPairReg hl
;	spillPairReg hl
	call	_DrawPlayer
	ld	c, a
;src/player.c:351: if(playerRealX>currentLevelWidth-32){
	ld	hl, (_currentLevelWidth)
	ld	a, l
	add	a, #0xe0
	ld	b, a
	ld	a, h
	adc	a, #0xff
	ld	e, a
	ld	a, b
	sub	a, -2 (ix)
	ld	a, e
	sbc	a, -1 (ix)
	jr	NC, 00188$
;src/player.c:352: nextLevel++;
	ld	hl, #_nextLevel
	inc	(hl)
00188$:
;src/player.c:355: return spritesUsed;
	ld	a, c
;src/player.c:356: }
	ld	sp, ix
	pop	ix
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
