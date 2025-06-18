;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
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
	.globl _joypad
	.globl _vsync
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
;src/main.c:26: SHOW_SPRITES;
	ld	iy, #__sprites_OFF
	ld	0 (iy), #0x00
;src/main.c:27: SPRITES_8x16;
	ld	a, (_shadow_VDP_R1+0)
	or	a, #0x02
	ld	(_shadow_VDP_R1+0), a
	di
	ld	a, (_shadow_VDP_R1+0)
	out	(_VDP_CMD), a
	ld	a, #0x81
	out	(_VDP_CMD), a
	ei
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
	ld	l, #0x48
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #0xa0
	call	_ShowCentered
;src/main.c:31: WaitForStartOrA();
	call	_WaitForStartOrA
;src/main.c:34: currentLevel=255;
	ld	a, #0xff
	ld	(#_currentLevel), a
;src/main.c:35: nextLevel=0;
	xor	a, a
	ld	(#_nextLevel), a
;src/main.c:38: while(1) {
00106$:
;src/main.c:41: vsync();
	call	_vsync
;src/main.c:44: if(nextLevel!=currentLevel){
	ld	a, (_nextLevel+0)
	ld	iy, #_currentLevel
	sub	a, 0 (iy)
	jr	Z, 00104$
;src/main.c:48: if(currentLevel!=255){
	ld	a, (_currentLevel+0)
	inc	a
	jr	Z, 00102$
;src/main.c:50: ShowCentered(NextLevel_WIDTH,NextLevel_HEIGHT,BANK(NextLevel),NextLevel_tiles,NextLevel_TILE_COUNT,NextLevel_map,NextLevel_palettes);
	ld	bc, #_NextLevel_map
	ld	de, #_NextLevel_tiles
	ld	a, #<(___bank_NextLevel)
	ld	hl, #_NextLevel_palettes
	push	hl
	push	bc
	ld	h, #0x1c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	de
	push	af
	inc	sp
	ld	l, #0x48
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #0xa0
	call	_ShowCentered
;src/main.c:52: WaitForStartOrA();
	call	_WaitForStartOrA
00102$:
;src/main.c:56: currentLevel=nextLevel;
	ld	a, (_nextLevel+0)
	ld	(_currentLevel+0), a
;../../../include/sms/sms.h:254: __WRITE_VDP_REG(VDP_R1, __READ_VDP_REG(VDP_R1) &= (~R1_DISP_ON));
	ld	a, (_shadow_VDP_R1+0)
	and	a, #0xbf
	ld	(_shadow_VDP_R1+0), a
	di
	ld	a, (_shadow_VDP_R1+0)
	out	(_VDP_CMD), a
	ld	a, #0x81
	out	(_VDP_CMD), a
	ei
;src/main.c:61: SetupCurrentLevel();
	call	_SetupCurrentLevel
;src/main.c:63: camera_x=0;
	ld	hl, #0x0000
	ld	(_camera_x), hl
;src/main.c:69: SetCurrentLevelSubmap(0,0,DEVICE_SCREEN_WIDTH+1,DEVICE_SCREEN_HEIGHT);
	ld	hl, #0x1215
	push	hl
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	ld	l, a
	call	_SetCurrentLevelSubmap
;src/main.c:71: DISPLAY_ON;
	ld	a, (_shadow_VDP_R1+0)
	or	a, #0x40
	ld	(_shadow_VDP_R1+0), a
	di
	ld	a, (_shadow_VDP_R1+0)
	out	(_VDP_CMD), a
	ld	a, #0x81
	out	(_VDP_CMD), a
	ei
;src/main.c:81: SetupPlayer();
	ld	e, #b_SetupPlayer
	ld	hl, #_SetupPlayer
	call	___sdcc_bcall_ehl
00104$:
;src/main.c:85: joypadPrevious = joypadCurrent;
	ld	a, (_joypadCurrent+0)
	ld	(_joypadPrevious+0), a
;src/main.c:86: joypadCurrent = joypad();
	call	_joypad
	ld	a, l
	ld	(_joypadCurrent+0), a
;src/main.c:88: uint8_t spritesUsed = UpdatePlayer();
	ld	e, #b_UpdatePlayer
	ld	hl, #_UpdatePlayer
	call	___sdcc_bcall_ehl
;src/main.c:89: hide_sprites_range(spritesUsed,MAX_HARDWARE_SPRITES);
;	spillPairReg hl
;	spillPairReg hl
	ld	l, #0x40
	call	_hide_sprites_range
;src/main.c:91: UpdateCamera();
	ld	e, #b_UpdateCamera
	ld	hl, #_UpdateCamera
	call	___sdcc_bcall_ehl
;src/main.c:93: }
	jp	00106$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
