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
	.globl _display_on
	.globl _vsync
	.globl _joypad
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
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS    (ABS)
;--------------------------------------------------------
; initialized external ram data
;--------------------------------------------------------
	.area _DATA
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
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;spritesUsed               Allocated to registers a 
;------------------------------------------------------------
;	src/main.c: 14: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/main.c: 25: SHOW_BKG;
	lda	_shadow_PPUMASK
	ora	#0x08
	sta	_shadow_PPUMASK
;	src/main.c: 26: SHOW_SPRITES;
	lda	_shadow_PPUMASK
	ora	#0x10
	sta	_shadow_PPUMASK
;	src/main.c: 27: SPRITES_8x16;
	lda	_shadow_PPUCTRL
	ora	#0x20
	sta	_shadow_PPUCTRL
;	src/main.c: 29: ShowCentered(TitleScreen_WIDTH,TitleScreen_HEIGHT,BANK(TitleScreen),TitleScreen_tiles,TitleScreen_TILE_COUNT,TitleScreen_map,TitleScreen_palettes);
	lda	#___bank_TitleScreen
	sta	_ShowCentered_PARM_3
	lda	#>_TitleScreen_tiles
	sta	(_ShowCentered_PARM_4 + 1)
	lda	#_TitleScreen_tiles
	sta	_ShowCentered_PARM_4
	lda	#>_TitleScreen_map
	sta	(_ShowCentered_PARM_6 + 1)
	lda	#_TitleScreen_map
	sta	_ShowCentered_PARM_6
	lda	#>_TitleScreen_palettes
	sta	(_ShowCentered_PARM_7 + 1)
	lda	#_TitleScreen_palettes
	sta	_ShowCentered_PARM_7
	ldx	#0x76
	stx	_ShowCentered_PARM_5
	lda	#0xa0
	ldx	#0x48
	jsr	_ShowCentered
;	src/main.c: 31: WaitForStartOrA();
	jsr	_WaitForStartOrA
;	src/main.c: 34: currentLevel=255;
	ldx	#0xff
	stx	_currentLevel
;	src/main.c: 35: nextLevel=0;
	inx
	stx	_nextLevel
;	src/main.c: 38: while(1) {
00106$:
;	src/main.c: 41: vsync();
	jsr	_vsync
;	src/main.c: 44: if(nextLevel!=currentLevel){
	lda	_nextLevel
	cmp	_currentLevel
	beq	00104$
;	src/main.c: 48: if(currentLevel!=255){
	lda	_currentLevel
	cmp	#0xff
	beq	00102$
;	src/main.c: 50: ShowCentered(NextLevel_WIDTH,NextLevel_HEIGHT,BANK(NextLevel),NextLevel_tiles,NextLevel_TILE_COUNT,NextLevel_map,NextLevel_palettes);
	lda	#___bank_NextLevel
	sta	_ShowCentered_PARM_3
	lda	#>_NextLevel_tiles
	sta	(_ShowCentered_PARM_4 + 1)
	lda	#_NextLevel_tiles
	sta	_ShowCentered_PARM_4
	lda	#>_NextLevel_map
	sta	(_ShowCentered_PARM_6 + 1)
	lda	#_NextLevel_map
	sta	_ShowCentered_PARM_6
	lda	#>_NextLevel_palettes
	sta	(_ShowCentered_PARM_7 + 1)
	lda	#_NextLevel_palettes
	sta	_ShowCentered_PARM_7
	ldx	#0x1c
	stx	_ShowCentered_PARM_5
	lda	#0xa0
	ldx	#0x48
	jsr	_ShowCentered
;	src/main.c: 52: WaitForStartOrA();
	jsr	_WaitForStartOrA
00102$:
;	src/main.c: 56: currentLevel=nextLevel;
	lda	_nextLevel
	sta	_currentLevel
;	src/main.c: 58: DISPLAY_OFF;
	jsr	_display_off
;	src/main.c: 61: SetupCurrentLevel();
	jsr	_SetupCurrentLevel
;	src/main.c: 63: camera_x=0;
	ldx	#0x00
	stx	_camera_x
	stx	(_camera_x + 1)
;	src/main.c: 69: SetCurrentLevelSubmap(0,0,DEVICE_SCREEN_WIDTH+1,DEVICE_SCREEN_HEIGHT);
	ldx	#0x21
	stx	_SetCurrentLevelSubmap_PARM_3
	ldx	#0x1e
	stx	_SetCurrentLevelSubmap_PARM_4
	lda	#0x00
	tax
	jsr	_SetCurrentLevelSubmap
;	src/main.c: 71: DISPLAY_ON;
	jsr	_display_on
;	src/main.c: 77: HIDE_LEFT_COLUMN;
	lda	_shadow_PPUMASK
	and	#0xf9
	sta	_shadow_PPUMASK
;	src/main.c: 81: SetupPlayer();
	jsr	___sdcc_bcall
	.db	b_SetupPlayer
	.dw 	_SetupPlayer-1
00104$:
;	src/main.c: 85: joypadPrevious = joypadCurrent;
	lda	_joypadCurrent
	sta	_joypadPrevious
;	src/main.c: 86: joypadCurrent = joypad();
	jsr	_joypad
	sta	_joypadCurrent
;	src/main.c: 88: uint8_t spritesUsed = UpdatePlayer();
	jsr	___sdcc_bcall
	.db	b_UpdatePlayer
	.dw 	_UpdatePlayer-1
;	src/main.c: 89: hide_sprites_range(spritesUsed,MAX_HARDWARE_SPRITES);
	ldx	#0x40
	jsr	_hide_sprites_range
;	src/main.c: 91: UpdateCamera();
	jsr	___sdcc_bcall
	.db	b_UpdateCamera
	.dw 	_UpdateCamera-1
	jmp	00106$
;	src/main.c: 93: }
	rts
	.area _CODE
	.area _XINIT
	.area _CABS    (ABS)
