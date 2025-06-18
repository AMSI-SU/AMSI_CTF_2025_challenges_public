;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module camera
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b_UpdateCamera
	.globl _UpdateCamera
	.globl _SetCurrentLevelSubmap
	.globl _set_tile_submap_compat
	.globl _redraw
	.globl _old_map_pos_x
	.globl _map_pos_x
	.globl _old_camera_x
	.globl _camera_x
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
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
	ld	c, a
	ld	e, l
;src/camera.c:32: uint8_t _previous_bank = CURRENT_BANK;
	ld	a, (_MAP_FRAME1+0)
	ld	-1 (ix), a
;src/camera.c:34: SWITCH_ROM(currentAreaBank);
	ld	a, (_currentAreaBank+0)
	ld	(_MAP_FRAME1+0), a
;src/camera.c:36: set_bkg_submap(x,y,w, h, currentLevelMap, currentLevelWidthInTiles);
	ld	a, (_currentLevelWidthInTiles+0)
	ld	hl, (_currentLevelMap)
	ld	d, 5 (ix)
	ld	b, 4 (ix)
;../../../include/sms/sms.h:696: set_tile_submap_compat(x, y, w, h, map_w, map);
	push	hl
	push	af
	inc	sp
	push	de
	inc	sp
	push	bc
	inc	sp
	ld	b, e
	push	bc
	call	_set_tile_submap_compat
;src/camera.c:38: SWITCH_ROM(_previous_bank);
	ld	a, -1 (ix)
	ld	(_MAP_FRAME1+0), a
;src/camera.c:40: }
	inc	sp
	pop	ix
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
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;src/camera.c:59: move_bkg(camera_x, 0);
	ld	a, (_camera_x+0)
;../../../include/sms/sms.h:223: __WRITE_VDP_REG(VDP_RSCX, -x);
	ld	hl, #_shadow_VDP_RSCX
	neg
	ld	(hl), a
	di
	ld	a, (_shadow_VDP_RSCX+0)
	out	(_VDP_CMD), a
	ld	a, #0x88
	out	(_VDP_CMD), a
	ei
;../../../include/sms/sms.h:224: __WRITE_VDP_REG(VDP_RSCY, y);
	ld	iy, #_shadow_VDP_RSCY
	ld	0 (iy), #0x00
	di
	ld	a, #0x00
	out	(_VDP_CMD), a
	ld	a, #0x89
	out	(_VDP_CMD), a
	ei
;src/camera.c:62: map_pos_x = (uint8_t)(camera_x >> 3u);
	ld	hl, (_camera_x)
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
	ld	a, l
	ld	(#_map_pos_x), a
;src/camera.c:63: if (map_pos_x != old_map_pos_x) {
	ld	a, (_map_pos_x+0)
	ld	hl, #_old_map_pos_x
	sub	a, (hl)
	jr	Z, 00107$
;src/camera.c:69: MIN(DEVICE_SCREEN_HEIGHT, currentLevelHeightInTiles ));     
	ld	hl, #_currentLevelHeightInTiles
	ld	a, #0x12
	cp	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	rla
	ld	-2 (ix), a
	ld	de, (_currentLevelHeightInTiles)
;src/camera.c:66: update_column_left(map_pos_x), 
	ld	a, (_map_pos_x+0)
	ld	-1 (ix), a
;src/camera.c:64: if (camera_x < old_camera_x) {
	ld	hl, #_old_camera_x
	ld	a, (_camera_x+0)
	sub	a, (hl)
	inc	hl
	ld	a, (_camera_x+1)
	sbc	a, (hl)
	jr	NC, 00104$
;src/camera.c:69: MIN(DEVICE_SCREEN_HEIGHT, currentLevelHeightInTiles ));     
	ld	a, -2 (ix)
	or	a, a
	jr	Z, 00113$
	ld	de, #0x0012
00113$:
;src/camera.c:66: update_column_left(map_pos_x), 
	ld	h, e
	ld	l, #0x01
	push	hl
	ld	l, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	a, -1 (ix)
	call	_SetCurrentLevelSubmap
	jr	00105$
00104$:
;src/camera.c:71: if ((currentLevelWidthInTiles - DEVICE_SCREEN_WIDTH) > map_pos_x) {
	ld	hl, (_currentLevelWidthInTiles)
	ld	bc, #0xffec
	add	hl,bc
	ld	c, l
	ld	b, h
	ld	a, (_map_pos_x+0)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	ld	h, a
	sbc	hl, bc
	jr	NC, 00105$
;src/camera.c:76: MIN(DEVICE_SCREEN_HEIGHT, currentLevelHeightInTiles));   
	ld	a, -2 (ix)
	or	a, a
	jr	Z, 00115$
	ld	de, #0x0012
00115$:
	ld	b, e
;src/camera.c:53: return map_pos_x + DEVICE_SCREEN_WIDTH;
	ld	a, -1 (ix)
	add	a, #0x14
	ld	c, a
;src/camera.c:73: update_column_right(map_pos_x), 
	push	bc
	inc	sp
	ld	a, #0x01
	push	af
	inc	sp
	ld	l, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	a, c
	call	_SetCurrentLevelSubmap
00105$:
;src/camera.c:79: old_map_pos_x = map_pos_x;
	ld	a, (_map_pos_x+0)
	ld	(_old_map_pos_x+0), a
00107$:
;src/camera.c:82: old_camera_x = camera_x;
	ld	hl, (_camera_x)
	ld	(_old_camera_x), hl
;src/camera.c:83: }
	ld	sp, ix
	pop	ix
	ret
	.area _CODE_255
	.area _INITIALIZER
	.area _CABS (ABS)
