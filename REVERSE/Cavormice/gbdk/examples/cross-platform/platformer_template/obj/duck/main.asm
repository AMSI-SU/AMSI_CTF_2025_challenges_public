;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _SetCurrentLevelSubmap
	.globl b_UpdateCamera
	.globl _UpdateCamera
	.globl _SetupCurrentLevel
	.globl _ShowCentered
	.globl _WaitForStartOrA
	.globl _hide_sprites_range
	.globl b_UpdatePlayer
	.globl _UpdatePlayer
	.globl b_SetupPlayer
	.globl _SetupPlayer
	.globl _display_off
	.globl _vsync
	.globl _joypad
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
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
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/main.c:14: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	dec	sp
;src/main.c:20: BGP_REG = DMG_PALETTE(DMG_BLACK, DMG_WHITE, DMG_LITE_GRAY, DMG_DARK_GRAY);
	ld	a, #0x93
	ldh	(_BGP_REG + 0), a
;src/main.c:21: OBP0_REG =OBP1_REG =DMG_PALETTE(DMG_DARK_GRAY, DMG_BLACK, DMG_WHITE,  DMG_LITE_GRAY );
	ld	a, #0x4e
	ldh	(_OBP1_REG + 0), a
	ld	a, #0x4e
	ldh	(_OBP0_REG + 0), a
;src/main.c:25: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x40
	ldh	(_LCDC_REG + 0), a
;src/main.c:26: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:27: SPRITES_8x16;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/main.c:29: ShowCentered(TitleScreen_WIDTH,TitleScreen_HEIGHT,BANK(TitleScreen),TitleScreen_tiles,TitleScreen_TILE_COUNT,TitleScreen_map,TitleScreen_palettes);
	ld	de, #_TitleScreen_map+0
	ld	bc, #_TitleScreen_tiles+0
	ld	a, #<(___bank_TitleScreen)
	ld	hl, #_TitleScreen_palettes
	push	hl
	push	de
	ld	h, #0x76
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	bc
	push	af
	inc	sp
	ld	e, #0x48
	ld	a, #0xa0
	call	_ShowCentered
;src/main.c:31: WaitForStartOrA();
	call	_WaitForStartOrA
;src/main.c:34: currentLevel=255;
	ld	hl, #_currentLevel
	ld	(hl), #0xff
;src/main.c:35: nextLevel=0;
	ld	hl, #_nextLevel
	ld	(hl), #0x00
;src/main.c:38: while(1) {
00106$:
;src/main.c:41: vsync();
	call	_vsync
;src/main.c:44: if(nextLevel!=currentLevel){
	ld	a, (#_nextLevel)
	ld	hl, #_currentLevel
	sub	a, (hl)
	jr	Z, 00104$
;src/main.c:48: if(currentLevel!=255){
	ld	a, (#_currentLevel)
	inc	a
	jr	Z, 00102$
;src/main.c:50: ShowCentered(NextLevel_WIDTH,NextLevel_HEIGHT,BANK(NextLevel),NextLevel_tiles,NextLevel_TILE_COUNT,NextLevel_map,NextLevel_palettes);
	ldhl	sp,	#0
	ld	(hl), #<(___bank_NextLevel)
	ld	de, #_NextLevel_palettes
	push	de
	ld	de, #_NextLevel_map
	push	de
	ld	a, #0x1c
	push	af
	inc	sp
	ld	de, #_NextLevel_tiles
	push	de
	ld	a, (hl)
	push	af
	inc	sp
	ld	e, #0x48
	ld	a, #0xa0
	call	_ShowCentered
;src/main.c:52: WaitForStartOrA();
	call	_WaitForStartOrA
00102$:
;src/main.c:56: currentLevel=nextLevel;
	ld	a, (#_nextLevel)
	ld	(#_currentLevel),a
;src/main.c:58: DISPLAY_OFF;
	call	_display_off
;src/main.c:61: SetupCurrentLevel();
	call	_SetupCurrentLevel
;src/main.c:63: camera_x=0;
	xor	a, a
	ld	hl, #_camera_x
	ld	(hl+), a
	ld	(hl), a
;src/main.c:69: SetCurrentLevelSubmap(0,0,DEVICE_SCREEN_WIDTH+1,DEVICE_SCREEN_HEIGHT);
	ld	hl, #0x1215
	push	hl
	xor	a, a
	ld	e, a
	call	_SetCurrentLevelSubmap
;src/main.c:71: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/main.c:81: SetupPlayer();
	ld	e, #b_SetupPlayer
	ld	hl, #_SetupPlayer
	call	___sdcc_bcall_ehl
00104$:
;src/main.c:85: joypadPrevious = joypadCurrent;
	ld	a, (#_joypadCurrent)
	ld	(#_joypadPrevious),a
;src/main.c:86: joypadCurrent = joypad();
	call	_joypad
	ld	(#_joypadCurrent),a
;src/main.c:88: uint8_t spritesUsed = UpdatePlayer();
	ld	e, #b_UpdatePlayer
	ld	hl, #_UpdatePlayer
	call	___sdcc_bcall_ehl
	ldhl	sp,	#0
	ld	(hl), a
;src/main.c:89: hide_sprites_range(spritesUsed,MAX_HARDWARE_SPRITES);
	ld	e, #0x28
	ldhl	sp,	#0
	ld	a, (hl)
	call	_hide_sprites_range
;src/main.c:91: UpdateCamera();
	ld	e, #b_UpdateCamera
	ld	hl, #_UpdateCamera
	call	___sdcc_bcall_ehl
	jp	00106$
;src/main.c:93: }
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
