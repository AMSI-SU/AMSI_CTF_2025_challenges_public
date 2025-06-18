;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module camera
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
	.globl b_UpdateCamera
	.globl _UpdateCamera
	.globl _SetCurrentLevelSubmap
	.globl __switch_prg0
	.globl _set_bkg_submap
	.globl _SetCurrentLevelSubmap_PARM_4
	.globl _SetCurrentLevelSubmap_PARM_3
	.globl _redraw
	.globl _old_map_pos_x
	.globl _map_pos_x
	.globl _old_camera_x
	.globl _camera_x
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
_UpdateCamera_sloc0_1_0:
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
_camera_x::
	.ds 2
_old_camera_x::
	.ds 2
_map_pos_x::
	.ds 1
_old_map_pos_x::
	.ds 1
_redraw::
	.ds 1
_SetCurrentLevelSubmap_PARM_3:
	.ds 1
_SetCurrentLevelSubmap_PARM_4:
	.ds 1
_SetCurrentLevelSubmap_y_10000_90:
	.ds 1
_SetCurrentLevelSubmap__previous_bank_10000_91:
	.ds 1
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
;	src/camera.c: 30: void SetCurrentLevelSubmap(uint8_t x, uint8_t y, uint8_t w, uint8_t h) NONBANKED{
;	-----------------------------------------
;	 function SetCurrentLevelSubmap
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_SetCurrentLevelSubmap:
	stx	_SetCurrentLevelSubmap_y_10000_90
;	src/camera.c: 32: uint8_t _previous_bank = CURRENT_BANK;
	ldx	__current_bank
	stx	_SetCurrentLevelSubmap__previous_bank_10000_91
;	src/camera.c: 34: SWITCH_ROM(currentAreaBank);
	pha
	lda	_currentAreaBank
	jsr	__switch_prg0
	pla
;	src/camera.c: 36: set_bkg_submap(x,y,w, h, currentLevelMap, currentLevelWidthInTiles);
	ldx	_currentLevelWidthInTiles
	stx	_set_bkg_submap_PARM_6
	ldx	_SetCurrentLevelSubmap_PARM_3
	stx	_set_bkg_submap_PARM_3
	ldx	_SetCurrentLevelSubmap_PARM_4
	stx	_set_bkg_submap_PARM_4
	ldx	(_currentLevelMap + 1)
	stx	(_set_bkg_submap_PARM_5 + 1)
	ldx	_currentLevelMap
	stx	_set_bkg_submap_PARM_5
	ldx	_SetCurrentLevelSubmap_y_10000_90
	jsr	_set_bkg_submap
;	src/camera.c: 38: SWITCH_ROM(_previous_bank);
	lda	_SetCurrentLevelSubmap__previous_bank_10000_91
;	src/camera.c: 40: }
	jmp	__switch_prg0
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE_255
;------------------------------------------------------------
;Allocation info for local variables in function 'SetCurrentLevelSubmap'
;------------------------------------------------------------
;w                         Allocated with name '_SetCurrentLevelSubmap_PARM_3'
;h                         Allocated with name '_SetCurrentLevelSubmap_PARM_4'
;y                         Allocated with name '_SetCurrentLevelSubmap_y_10000_90'
;x                         Allocated to registers a 
;_previous_bank            Allocated with name '_SetCurrentLevelSubmap__previous_bank_10000_91'
;------------------------------------------------------------
;------------------------------------------------------------
;Allocation info for local variables in function 'UpdateCamera'
;------------------------------------------------------------
;sloc0                     Allocated with name '_UpdateCamera_sloc0_1_0'
;__200000006               Allocated to registers 
;__200000007               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;__400000009               Allocated to registers y 
;__400000010               Allocated to registers y 
;map_pos_x                 Allocated to registers 
;__500000012               Allocated to registers y 
;__500000013               Allocated to registers a 
;map_pos_x                 Allocated to registers 
;------------------------------------------------------------
;	src/camera.c: 56: void UpdateCamera(void) BANKED {
;	-----------------------------------------
;	 function UpdateCamera
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
	b_UpdateCamera	= 255
_UpdateCamera:
;	src/camera.c: 59: move_bkg(camera_x, 0);
	lda	_camera_x
	sta	_bkg_scroll_x
;	../../../include/nes/nes.h: 918: bkg_scroll_x = x, bkg_scroll_y = y;
	ldx	#0x00
	stx	_bkg_scroll_y
;	src/camera.c: 62: map_pos_x = (uint8_t)(camera_x >> 3u);
	ldx	(_camera_x + 1)
	lda	_camera_x
	stx	*(REGTEMP+0)
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	tay
	sty	_map_pos_x
;	src/camera.c: 63: if (map_pos_x != old_map_pos_x) {
	cpy	_old_map_pos_x
	bne	00147$
	jmp	00107$
00147$:
;	src/camera.c: 64: if (camera_x < old_camera_x) {
	lda	_camera_x
	sec
	sbc	_old_camera_x
	lda	(_camera_x + 1)
	sbc	(_old_camera_x + 1)
	bcs	00104$
;	src/camera.c: 66: update_column_left(map_pos_x), 
;	src/camera.c: 45: return map_pos_x + 1;
	iny
;	src/camera.c: 69: MIN(DEVICE_SCREEN_HEIGHT, currentLevelHeightInTiles ));     
	lda	#0x1e
	sec
	sbc	_currentLevelHeightInTiles
	lda	#0x00
	sbc	(_currentLevelHeightInTiles + 1)
	bcs	00113$
	ldx	#0x00
	lda	#0x1e
	jmp	00114$
00113$:
	ldx	(_currentLevelHeightInTiles + 1)
	lda	_currentLevelHeightInTiles
00114$:
	sta	_SetCurrentLevelSubmap_PARM_4
	ldx	#0x01
	stx	_SetCurrentLevelSubmap_PARM_3
	tya
	dex
	jsr	_SetCurrentLevelSubmap
	jmp	00105$
00104$:
;	src/camera.c: 71: if ((currentLevelWidthInTiles - DEVICE_SCREEN_WIDTH) > map_pos_x) {
	ldx	(_currentLevelWidthInTiles + 1)
	lda	_currentLevelWidthInTiles
	sec
	sbc	#0x20
	sta	*_UpdateCamera_sloc0_1_0
	txa
	sbc	#0x00
	sta	*(_UpdateCamera_sloc0_1_0 + 1)
	ldx	#0x00
	tya
	sec
	sbc	*_UpdateCamera_sloc0_1_0
	txa
	sbc	*(_UpdateCamera_sloc0_1_0 + 1)
	bcs	00105$
;	src/camera.c: 73: update_column_right(map_pos_x), 
	tya
;	src/camera.c: 53: return map_pos_x + DEVICE_SCREEN_WIDTH;
	clc
	adc	#0x20
	tay
;	src/camera.c: 76: MIN(DEVICE_SCREEN_HEIGHT, currentLevelHeightInTiles));   
	lda	#0x1e
	sec
	sbc	_currentLevelHeightInTiles
	txa
	sbc	(_currentLevelHeightInTiles + 1)
	bcs	00115$
	lda	#0x1e
	jmp	00116$
00115$:
	ldx	(_currentLevelHeightInTiles + 1)
	lda	_currentLevelHeightInTiles
00116$:
	sta	_SetCurrentLevelSubmap_PARM_4
	ldx	#0x01
	stx	_SetCurrentLevelSubmap_PARM_3
	tya
	dex
	jsr	_SetCurrentLevelSubmap
00105$:
;	src/camera.c: 79: old_map_pos_x = map_pos_x;
	lda	_map_pos_x
	sta	_old_map_pos_x
00107$:
;	src/camera.c: 82: old_camera_x = camera_x;
	lda	(_camera_x + 1)
	sta	(_old_camera_x + 1)
	lda	_camera_x
	sta	_old_camera_x
;	src/camera.c: 83: }
	rts
	.area _CODE_255
	.area _XINIT
	.area _CABS    (ABS)
