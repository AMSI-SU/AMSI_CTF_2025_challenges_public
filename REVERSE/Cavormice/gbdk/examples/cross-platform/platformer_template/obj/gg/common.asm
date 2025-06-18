;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module common
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _hide_sprites_range
	.globl _fill_rect_compat
	.globl _set_tile_map_compat
	.globl _set_native_tile_data
	.globl _set_palette
	.globl _joypad
	.globl _vsync
	.globl _joypadPrevious
	.globl _joypadCurrent
	.globl _WaitForStartOrA
	.globl _setBKGPalettes
	.globl _ShowCentered
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
_joypadCurrent::
	.ds 1
_joypadPrevious::
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
;src/common.c:24: void setBKGPalettes(uint8_t count, const palette_color_t *palettes) NONBANKED{
;	---------------------------------
; Function setBKGPalettes
; ---------------------------------
_setBKGPalettes::
;src/common.c:29: set_bkg_palette(0, count, palettes);
	push	de
	ld	h, a
	ld	l, #0x00
	push	hl
	call	_set_palette
;src/common.c:37: }
	ret
;src/common.c:40: void ShowCentered(uint8_t width,uint8_t height,uint8_t bank, uint8_t* tileData, uint8_t tileCount, uint8_t* mapData, const palette_color_t* palettes) NONBANKED{
;	---------------------------------
; Function ShowCentered
; ---------------------------------
_ShowCentered::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	push	af
	ld	-1 (ix), a
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
;src/common.c:45: uint8_t _previous_bank = CURRENT_BANK;
	ld	a, (_MAP_FRAME1+0)
	ld	-6 (ix), a
;src/common.c:49: hide_sprites_range(0,MAX_HARDWARE_SPRITES);
	push	hl
	ld	l, #0x40
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	call	_hide_sprites_range
	pop	hl
;../../../include/sms/sms.h:223: __WRITE_VDP_REG(VDP_RSCX, -x);
	ld	iy, #_shadow_VDP_RSCX
	ld	0 (iy), #0x00
	di
	ld	a, #0x00
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
;src/common.c:54: uint8_t titleRow = (DEVICE_SCREEN_HEIGHT-(height>>3))/2;
	ld	a, l
	rrca
	rrca
	rrca
	and	a, #0x1f
	ld	-5 (ix), a
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #0x12
	sub	a, l
	ld	e, a
	sbc	a, a
	sub	a, h
	ld	d, a
	ld	c, e
	ld	b, d
	bit	7, d
	jr	Z, 00105$
	ld	c, e
	ld	b, d
	inc	bc
00105$:
	sra	b
	rr	c
	ld	-4 (ix), c
;src/common.c:55: uint8_t titleColumn = (DEVICE_SCREEN_WIDTH-(width>>3))/2;
	ld	a, -1 (ix)
	rrca
	rrca
	rrca
	and	a, #0x1f
	ld	-3 (ix), a
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #0x14
	sub	a, l
	ld	e, a
	sbc	a, a
	sub	a, h
	ld	d, a
	ld	c, e
	ld	b, d
	bit	7, d
	jr	Z, 00106$
	ld	c, e
	ld	b, d
	inc	bc
00106$:
	sra	b
	rr	c
	ld	-2 (ix), c
;src/common.c:57: SWITCH_ROM(bank);
	ld	a, 4 (ix)
	ld	(_MAP_FRAME1+0), a
;src/common.c:59: setBKGPalettes(1,palettes);
	ld	e, 10 (ix)
	ld	d, 11 (ix)
	ld	a, #0x01
	call	_setBKGPalettes
;src/common.c:61: set_native_tile_data(0,tileCount,tileData);
	ld	c, 5 (ix)
	ld	b, 6 (ix)
	ld	e, 7 (ix)
	ld	d, #0x00
	push	bc
	ld	hl, #0x0000
	call	_set_native_tile_data
;src/common.c:62: fill_bkg_rect(0,0,DEVICE_SCREEN_WIDTH,DEVICE_SCREEN_HEIGHT,0);
	ld	hl, #0x0000
	push	hl
	ld	hl, #0x1214
	push	hl
	ld	hl, #0x00
	push	hl
	call	_fill_rect_compat
;src/common.c:63: set_bkg_tiles(titleColumn,titleRow,width>>3,height>>3,mapData);
	ld	l, 8 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, 9 (ix)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	ld	h, -5 (ix)
	ld	l, -3 (ix)
	push	hl
	ld	h, -4 (ix)
	ld	l, -2 (ix)
	push	hl
	call	_set_tile_map_compat
;src/common.c:64: SWITCH_ROM(_previous_bank);
	ld	a, -6 (ix)
	ld	(_MAP_FRAME1+0), a
;src/common.c:66: DISPLAY_ON;
	ld	a, (_shadow_VDP_R1+0)
	or	a, #0x40
	ld	(_shadow_VDP_R1+0), a
	di
	ld	a, (_shadow_VDP_R1+0)
	out	(_VDP_CMD), a
	ld	a, #0x81
	out	(_VDP_CMD), a
	ei
;src/common.c:67: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	pop	af
	pop	af
	jp	(hl)
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/common.c:9: void WaitForStartOrA(void){
;	---------------------------------
; Function WaitForStartOrA
; ---------------------------------
_WaitForStartOrA::
;src/common.c:10: while(1){
00108$:
;src/common.c:13: joypadPrevious = joypadCurrent;
	ld	a, (_joypadCurrent+0)
	ld	(_joypadPrevious+0), a
;src/common.c:14: joypadCurrent = joypad();
	call	_joypad
	ld	a, l
;src/common.c:16: if((joypadCurrent & J_START) && !(joypadPrevious & J_START))break;
	ld	(_joypadCurrent+0), a
	ld	c, a
	ld	a, (_joypadPrevious+0)
	bit	6, c
	jr	Z, 00102$
	bit	6, a
	ret	Z
00102$:
;src/common.c:17: if((joypadCurrent & J_A) && !(joypadPrevious & J_A))break;
	bit	5, c
	jr	Z, 00105$
	bit	5, a
	ret	Z
00105$:
;src/common.c:19: vsync();
	call	_vsync
;src/common.c:22: }
	jr	00108$
	.area _CODE
	.area _INITIALIZER
__xinit__joypadCurrent:
	.db #0x00	; 0
__xinit__joypadPrevious:
	.db #0x00	; 0
	.area _CABS (ABS)
