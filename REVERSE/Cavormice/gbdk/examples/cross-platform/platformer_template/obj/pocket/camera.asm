;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module camera
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b_UpdateCamera
	.globl _UpdateCamera
	.globl _SetCurrentLevelSubmap
	.globl _set_bkg_submap
	.globl _redraw
	.globl _old_map_pos_x
	.globl _map_pos_x
	.globl _old_camera_x
	.globl _camera_x
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
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
;src/camera.c:30: void SetCurrentLevelSubmap(uint8_t x, uint8_t y, uint8_t w, uint8_t h) NONBANKED{
;	---------------------------------
; Function SetCurrentLevelSubmap
; ---------------------------------
_SetCurrentLevelSubmap::
	ld	b, a
;src/camera.c:32: uint8_t _previous_bank = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ld	c, a
;src/camera.c:34: SWITCH_ROM(currentAreaBank);
	ld	a, (#_currentAreaBank)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;src/camera.c:36: set_bkg_submap(x,y,w, h, currentLevelMap, currentLevelWidthInTiles);
	ld	a, (#_currentLevelWidthInTiles)
	push	bc
	push	af
	inc	sp
	ld	hl, #_currentLevelMap
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, (_currentLevelMap + 1)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	ldhl	sp,	#8
	ld	a, (hl-)
	push	af
	inc	sp
	ld	d, (hl)
	push	de
	push	bc
	inc	sp
	call	_set_bkg_submap
	add	sp, #7
	pop	bc
;src/camera.c:38: SWITCH_ROM(_previous_bank);
	ld	a, c
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), c
;src/camera.c:40: }
	pop	hl
	pop	af
	jp	(hl)
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE_255
;src/camera.c:56: void UpdateCamera(void) BANKED {
;	---------------------------------
; Function UpdateCamera
; ---------------------------------
	b_UpdateCamera	= 255
_UpdateCamera::
	dec	sp
	dec	sp
;src/camera.c:59: move_bkg(camera_x, 0);
	ld	hl, #_camera_x
	ld	a, (hl)
	ldh	(_SCX_REG + 0), a
;../../../include/gb/gb.h:1449: SCX_REG=x, SCY_REG=y;
	xor	a, a
;src/camera.c:62: map_pos_x = (uint8_t)(camera_x >> 3u);
	ldh	(_SCY_REG + 0), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ld	hl, #_map_pos_x
	ld	(hl), c
;src/camera.c:63: if (map_pos_x != old_map_pos_x) {
	ld	a, (hl)
	ld	hl, #_old_map_pos_x
	sub	a, (hl)
	jr	Z, 00107$
;src/camera.c:69: MIN(DEVICE_SCREEN_HEIGHT, currentLevelHeightInTiles ));     
	ld	hl, #_currentLevelHeightInTiles
	ld	a, #0x12
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#0
	ld	(hl), a
	ld	hl, #_currentLevelHeightInTiles
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;src/camera.c:66: update_column_left(map_pos_x), 
	ld	a, (#_map_pos_x)
	ldhl	sp,	#1
	ld	(hl), a
;src/camera.c:64: if (camera_x < old_camera_x) {
	push	de
	ld	de, #_camera_x
	ld	hl, #_old_camera_x
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00104$
;src/camera.c:69: MIN(DEVICE_SCREEN_HEIGHT, currentLevelHeightInTiles ));     
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00113$
	ld	de, #0x0012
00113$:
;src/camera.c:66: update_column_left(map_pos_x), 
	ld	h, e
	ld	l, #0x01
	push	hl
	ld	e, #0x00
	ldhl	sp,	#3
	ld	a, (hl)
	call	_SetCurrentLevelSubmap
	jr	00105$
00104$:
;src/camera.c:71: if ((currentLevelWidthInTiles - DEVICE_SCREEN_WIDTH) > map_pos_x) {
	ld	hl, #_currentLevelWidthInTiles
	ld	a, (hl+)
	ld	c, (hl)
	add	a, #0xec
	ld	b, a
	ld	a, c
	adc	a, #0xff
	ld	c, a
	ld	hl, #_map_pos_x
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	a, l
	sub	a, b
	ld	a, h
	sbc	a, c
	jr	NC, 00105$
;src/camera.c:76: MIN(DEVICE_SCREEN_HEIGHT, currentLevelHeightInTiles));   
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00115$
	ld	de, #0x0012
00115$:
;src/camera.c:53: return map_pos_x + DEVICE_SCREEN_WIDTH;
	ldhl	sp,	#1
	ld	a, (hl)
	add	a, #0x14
	ld	c, a
;src/camera.c:73: update_column_right(map_pos_x), 
	ld	h, e
	ld	l, #0x01
	push	hl
	ld	e, #0x00
	ld	a, c
	call	_SetCurrentLevelSubmap
00105$:
;src/camera.c:79: old_map_pos_x = map_pos_x;
	ld	a, (#_map_pos_x)
	ld	(#_old_map_pos_x),a
00107$:
;src/camera.c:82: old_camera_x = camera_x;
	ld	a, (#_camera_x)
	ld	(#_old_camera_x),a
	ld	a, (#_camera_x + 1)
	ld	(#_old_camera_x + 1),a
;src/camera.c:83: }
	inc	sp
	inc	sp
	ret
	.area _CODE_255
	.area _INITIALIZER
	.area _CABS (ABS)
