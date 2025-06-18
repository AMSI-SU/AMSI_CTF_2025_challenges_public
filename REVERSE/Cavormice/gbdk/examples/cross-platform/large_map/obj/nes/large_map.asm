;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module large_map
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
	.globl _init_camera
	.globl _set_camera
	.globl _set_bkg_native_data
	.globl _set_bkg_submap
	.globl _set_bkg_submap_attributes_nes16x16
	.globl _display_off
	.globl _display_on
	.globl _vsync
	.globl _joypad
	.globl _set_bkg_palette
	.globl _redraw
	.globl _old_map_pos_y
	.globl _old_map_pos_x
	.globl _map_pos_y
	.globl _map_pos_x
	.globl _old_camera_y
	.globl _old_camera_x
	.globl _camera_y
	.globl _camera_x
	.globl _joy
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
_set_camera_sloc0_1_0:
	.ds 2
_init_camera_sloc0_1_0:
	.ds 1
_init_camera_sloc1_1_0:
	.ds 1
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
_joy::
	.ds 1
_camera_x::
	.ds 2
_camera_y::
	.ds 2
_old_camera_x::
	.ds 2
_old_camera_y::
	.ds 2
_map_pos_x::
	.ds 1
_map_pos_y::
	.ds 1
_old_map_pos_x::
	.ds 1
_old_map_pos_y::
	.ds 1
_redraw::
	.ds 1
_init_camera_y_10000_172:
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
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;------------------------------------------------------------
;Allocation info for local variables in function 'set_camera'
;------------------------------------------------------------
;sloc0                     Allocated with name '_set_camera_sloc0_1_0'
;__200000006               Allocated to registers 
;__200000007               Allocated to registers a 
;x                         Allocated to registers 
;y                         Allocated to registers 
;__400000009               Allocated to registers y 
;__400000010               Allocated to registers y 
;map_pos_y                 Allocated to registers 
;__400000019               Allocated to registers y 
;__400000012               Allocated to registers 
;__400000013               Allocated to registers 
;__400000014               Allocated to registers x 
;__400000015               Allocated to registers 
;__400000016               Allocated to registers 
;__400000017               Allocated to registers 
;__500000020               Allocated to registers 
;map_pos_y                 Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;w                         Allocated to registers 
;h                         Allocated to registers 
;attributes                Allocated to registers 
;map_w                     Allocated to registers 
;__500000022               Allocated to registers y 
;__500000023               Allocated to registers a 
;map_pos_y                 Allocated to registers 
;__500000032               Allocated to registers a 
;__500000025               Allocated to registers 
;__500000026               Allocated to registers 
;__500000027               Allocated to registers x 
;__500000028               Allocated to registers 
;__500000029               Allocated to registers 
;__500000030               Allocated to registers 
;__600000033               Allocated to registers 
;map_pos_y                 Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;w                         Allocated to registers 
;h                         Allocated to registers 
;attributes                Allocated to registers 
;map_w                     Allocated to registers 
;__400000035               Allocated to registers y 
;__400000036               Allocated to registers y 
;map_pos_x                 Allocated to registers 
;__400000045               Allocated to registers y 
;__400000038               Allocated to registers 
;__400000039               Allocated to registers 
;__400000040               Allocated to registers 
;__400000041               Allocated to registers x 
;__400000042               Allocated to registers 
;__400000043               Allocated to registers 
;__500000046               Allocated to registers 
;map_pos_x                 Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;w                         Allocated to registers 
;h                         Allocated to registers 
;attributes                Allocated to registers 
;map_w                     Allocated to registers 
;__500000048               Allocated to registers y 
;__500000049               Allocated to registers a 
;map_pos_x                 Allocated to registers 
;__500000058               Allocated to registers a 
;__500000051               Allocated to registers 
;__500000052               Allocated to registers 
;__500000053               Allocated to registers 
;__500000054               Allocated to registers x 
;__500000055               Allocated to registers 
;__500000056               Allocated to registers 
;__600000059               Allocated to registers 
;map_pos_x                 Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;w                         Allocated to registers 
;h                         Allocated to registers 
;attributes                Allocated to registers 
;map_w                     Allocated to registers 
;------------------------------------------------------------
;	src/large_map.c: 82: void set_camera(void)
;	-----------------------------------------
;	 function set_camera
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 0 bytes.
_set_camera:
;	src/large_map.c: 85: move_bkg(camera_x, WRAP_SCROLL_Y(camera_y + SCROLL_Y_OFFSET));
	ldx	(_camera_y + 1)
	lda	_camera_y
	clc
	adc	#0x04
	bcc	00230$
	inx
00230$:
	ldy	#0xf0
	sty	__moduint_PARM_2
	ldy	#0x00
	sty	(__moduint_PARM_2 + 1)
	jsr	__moduint
	ldx	_camera_x
	stx	_bkg_scroll_x
;	../../../include/nes/nes.h: 918: bkg_scroll_x = x, bkg_scroll_y = y;
	sta	_bkg_scroll_y
;	src/large_map.c: 87: map_pos_y = (uint8_t)(camera_y >> 3u);
	ldx	(_camera_y + 1)
	lda	_camera_y
	stx	*(REGTEMP+0)
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	tay
	sty	_map_pos_y
;	src/large_map.c: 88: if (map_pos_y != old_map_pos_y)
	cpy	_old_map_pos_y
	bne	00231$
	jmp	00107$
00231$:
;	src/large_map.c: 90: if (camera_y < old_camera_y)
	lda	_camera_y
	sec
	sbc	_old_camera_y
	lda	(_camera_y + 1)
	sbc	(_old_camera_y + 1)
	bcc	00232$
	jmp	00104$
00232$:
;	src/large_map.c: 92: set_submap_indices(
;	src/large_map.c: 71: return map_pos_y + 1;
	iny
;	src/large_map.c: 92: set_submap_indices(
	ldx	#0x00
	lda	_map_pos_x
	sta	*(REGTEMP+0)
	lda	#0x9c
	sec
	sbc	*(REGTEMP+0)
	sta	*_set_camera_sloc0_1_0
	txa
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	sta	*(_set_camera_sloc0_1_0 + 1)
	lda	#0x21
	sec
	sbc	*_set_camera_sloc0_1_0
	txa
	sbc	*(_set_camera_sloc0_1_0 + 1)
	bvc	00234$
	bpl	00233$
	bmi	00130$
00234$:
	bpl	00130$
00233$:
	lda	#0x21
	jmp	00131$
00130$:
	lda	#0x9c
	sec
	sbc	_map_pos_x
00131$:
	ldx	#>_bigmap_map
	stx	(_set_bkg_submap_PARM_5 + 1)
	ldx	#_bigmap_map
	stx	_set_bkg_submap_PARM_5
	sta	_set_bkg_submap_PARM_3
	ldx	#0x01
	stx	_set_bkg_submap_PARM_4
	ldx	#0x9c
	stx	_set_bkg_submap_PARM_6
	lda	_map_pos_x
	sty	*(REGTEMP+0)
	ldx	*(REGTEMP+0)
	jsr	_set_bkg_submap
;	src/large_map.c: 99: set_submap_attributes(
	ldx	#0x00
	lda	_map_pos_x
	sta	*(REGTEMP+0)
	lda	#0x9c
	sec
	sbc	*(REGTEMP+0)
	sta	*_set_camera_sloc0_1_0
	txa
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	sta	*(_set_camera_sloc0_1_0 + 1)
	lda	#0x21
	sec
	sbc	*_set_camera_sloc0_1_0
	txa
	sbc	*(_set_camera_sloc0_1_0 + 1)
	bvc	00237$
	bpl	00236$
	bmi	00132$
00237$:
	bpl	00132$
00236$:
	ldx	#0x21
	jmp	00133$
00132$:
	lda	#0x9c
	sec
	sbc	_map_pos_x
	tax
00133$:
;	src/large_map.c: 71: return map_pos_y + 1;
	ldy	_map_pos_y
	iny
;	../../../include/nes/nes.h: 753: set_bkg_submap_attributes_nes16x16(x >> 1, y >> 1, (w + 1) >> 1, (h + 1) >> 1, attributes, map_w >> 1);
	lda	_map_pos_x
	lsr	a
	sta	*_set_camera_sloc0_1_0
	tya
	lsr	a
	tay
	txa
	ldx	#0x00
	clc
	adc	#0x01
	bcc	00239$
	inx
00239$:
	stx	*(REGTEMP+0)
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	sta	_set_bkg_submap_attributes_nes16x16_PARM_3
	ldx	#0x01
	stx	_set_bkg_submap_attributes_nes16x16_PARM_4
	lda	#>_bigmap_map_attributes
	sta	(_set_bkg_submap_attributes_nes16x16_PARM_5 + 1)
	lda	#_bigmap_map_attributes
	sta	_set_bkg_submap_attributes_nes16x16_PARM_5
	ldx	#0x4e
	stx	_set_bkg_submap_attributes_nes16x16_PARM_6
	lda	*_set_camera_sloc0_1_0
	sty	*(REGTEMP+0)
	ldx	*(REGTEMP+0)
	jsr	_set_bkg_submap_attributes_nes16x16
;	src/large_map.c: 99: set_submap_attributes(
	jmp	00105$
00104$:
;	src/large_map.c: 109: if ((bigmap_mapHeight - DEVICE_SCREEN_HEIGHT) > map_pos_y)
	cpy	#0x24
	bcc	00240$
	jmp	00105$
00240$:
;	src/large_map.c: 111: set_submap_indices(
	tya
;	src/large_map.c: 79: return map_pos_y + DEVICE_SCREEN_HEIGHT;
	clc
	adc	#0x1e
	tay
;	src/large_map.c: 111: set_submap_indices(
	ldx	#0x00
	lda	_map_pos_x
	sta	*(REGTEMP+0)
	lda	#0x9c
	sec
	sbc	*(REGTEMP+0)
	sta	*_set_camera_sloc0_1_0
	txa
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	sta	*(_set_camera_sloc0_1_0 + 1)
	lda	#0x21
	sec
	sbc	*_set_camera_sloc0_1_0
	txa
	sbc	*(_set_camera_sloc0_1_0 + 1)
	bvc	00242$
	bpl	00241$
	bmi	00134$
00242$:
	bpl	00134$
00241$:
	lda	#0x21
	jmp	00135$
00134$:
	lda	#0x9c
	sec
	sbc	_map_pos_x
00135$:
	ldx	#>_bigmap_map
	stx	(_set_bkg_submap_PARM_5 + 1)
	ldx	#_bigmap_map
	stx	_set_bkg_submap_PARM_5
	sta	_set_bkg_submap_PARM_3
	ldx	#0x01
	stx	_set_bkg_submap_PARM_4
	ldx	#0x9c
	stx	_set_bkg_submap_PARM_6
	lda	_map_pos_x
	sty	*(REGTEMP+0)
	ldx	*(REGTEMP+0)
	jsr	_set_bkg_submap
;	src/large_map.c: 118: set_submap_attributes(
	ldx	#0x00
	lda	_map_pos_x
	sta	*(REGTEMP+0)
	lda	#0x9c
	sec
	sbc	*(REGTEMP+0)
	sta	*_set_camera_sloc0_1_0
	txa
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	sta	*(_set_camera_sloc0_1_0 + 1)
	lda	#0x21
	sec
	sbc	*_set_camera_sloc0_1_0
	txa
	sbc	*(_set_camera_sloc0_1_0 + 1)
	bvc	00245$
	bpl	00244$
	bmi	00136$
00245$:
	bpl	00136$
00244$:
	ldx	#0x21
	jmp	00137$
00136$:
	lda	#0x9c
	sec
	sbc	_map_pos_x
	tax
00137$:
;	src/large_map.c: 79: return map_pos_y + DEVICE_SCREEN_HEIGHT;
	lda	_map_pos_y
	clc
	adc	#0x1e
;	../../../include/nes/nes.h: 753: set_bkg_submap_attributes_nes16x16(x >> 1, y >> 1, (w + 1) >> 1, (h + 1) >> 1, attributes, map_w >> 1);
	pha
	lda	_map_pos_x
	lsr	a
	tay
	pla
	lsr	a
	sta	*_set_camera_sloc0_1_0
	txa
	ldx	#0x00
	clc
	adc	#0x01
	bcc	00247$
	inx
00247$:
	stx	*(REGTEMP+0)
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	sta	_set_bkg_submap_attributes_nes16x16_PARM_3
	ldx	#0x01
	stx	_set_bkg_submap_attributes_nes16x16_PARM_4
	lda	#>_bigmap_map_attributes
	sta	(_set_bkg_submap_attributes_nes16x16_PARM_5 + 1)
	lda	#_bigmap_map_attributes
	sta	_set_bkg_submap_attributes_nes16x16_PARM_5
	ldx	#0x4e
	stx	_set_bkg_submap_attributes_nes16x16_PARM_6
	tya
	ldx	*_set_camera_sloc0_1_0
	jsr	_set_bkg_submap_attributes_nes16x16
;	src/large_map.c: 118: set_submap_attributes(
00105$:
;	src/large_map.c: 127: old_map_pos_y = map_pos_y; 
	lda	_map_pos_y
	sta	_old_map_pos_y
00107$:
;	src/large_map.c: 130: map_pos_x = (uint8_t)(camera_x >> 3u);
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
;	src/large_map.c: 131: if (map_pos_x != old_map_pos_x)
	cpy	_old_map_pos_x
	bne	00248$
	jmp	00114$
00248$:
;	src/large_map.c: 133: if (camera_x < old_camera_x)
	lda	_camera_x
	sec
	sbc	_old_camera_x
	lda	(_camera_x + 1)
	sbc	(_old_camera_x + 1)
	bcc	00249$
	jmp	00111$
00249$:
;	src/large_map.c: 135: set_submap_indices(
;	src/large_map.c: 57: return map_pos_x + 1;
	iny
;	src/large_map.c: 135: set_submap_indices(
	ldx	#0x00
	lda	_map_pos_y
	sta	*(REGTEMP+0)
	lda	#0x42
	sec
	sbc	*(REGTEMP+0)
	sta	*_set_camera_sloc0_1_0
	txa
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	sta	*(_set_camera_sloc0_1_0 + 1)
	lda	#0x1f
	sec
	sbc	*_set_camera_sloc0_1_0
	txa
	sbc	*(_set_camera_sloc0_1_0 + 1)
	bvc	00251$
	bpl	00250$
	bmi	00138$
00251$:
	bpl	00138$
00250$:
	lda	#0x1f
	jmp	00139$
00138$:
	lda	#0x42
	sec
	sbc	_map_pos_y
00139$:
	ldx	#>_bigmap_map
	stx	(_set_bkg_submap_PARM_5 + 1)
	ldx	#_bigmap_map
	stx	_set_bkg_submap_PARM_5
	ldx	#0x01
	stx	_set_bkg_submap_PARM_3
	sta	_set_bkg_submap_PARM_4
	ldx	#0x9c
	stx	_set_bkg_submap_PARM_6
	tya
	ldx	_map_pos_y
	jsr	_set_bkg_submap
;	src/large_map.c: 142: set_submap_attributes(
	ldx	#0x00
	lda	_map_pos_y
	sta	*(REGTEMP+0)
	lda	#0x42
	sec
	sbc	*(REGTEMP+0)
	sta	*_set_camera_sloc0_1_0
	txa
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	sta	*(_set_camera_sloc0_1_0 + 1)
	lda	#0x1f
	sec
	sbc	*_set_camera_sloc0_1_0
	txa
	sbc	*(_set_camera_sloc0_1_0 + 1)
	bvc	00254$
	bpl	00253$
	bmi	00140$
00254$:
	bpl	00140$
00253$:
	ldx	#0x1f
	jmp	00141$
00140$:
	lda	#0x42
	sec
	sbc	_map_pos_y
	tax
00141$:
;	src/large_map.c: 57: return map_pos_x + 1;
	ldy	_map_pos_x
	iny
;	../../../include/nes/nes.h: 753: set_bkg_submap_attributes_nes16x16(x >> 1, y >> 1, (w + 1) >> 1, (h + 1) >> 1, attributes, map_w >> 1);
	tya
	lsr	a
	tay
	lda	_map_pos_y
	lsr	a
	sta	*_set_camera_sloc0_1_0
	txa
	ldx	#0x00
	clc
	adc	#0x01
	bcc	00256$
	inx
00256$:
	stx	*(REGTEMP+0)
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	sta	_set_bkg_submap_attributes_nes16x16_PARM_4
	ldx	#0x01
	stx	_set_bkg_submap_attributes_nes16x16_PARM_3
	lda	#>_bigmap_map_attributes
	sta	(_set_bkg_submap_attributes_nes16x16_PARM_5 + 1)
	lda	#_bigmap_map_attributes
	sta	_set_bkg_submap_attributes_nes16x16_PARM_5
	ldx	#0x4e
	stx	_set_bkg_submap_attributes_nes16x16_PARM_6
	tya
	ldx	*_set_camera_sloc0_1_0
	jsr	_set_bkg_submap_attributes_nes16x16
;	src/large_map.c: 142: set_submap_attributes(
	jmp	00112$
00111$:
;	src/large_map.c: 152: if ((bigmap_mapWidth - DEVICE_SCREEN_WIDTH) > map_pos_x)
	cpy	#0x7c
	bcc	00257$
	jmp	00112$
00257$:
;	src/large_map.c: 154: set_submap_indices(
	tya
;	src/large_map.c: 65: return map_pos_x + DEVICE_SCREEN_WIDTH;
	clc
	adc	#0x20
	tay
;	src/large_map.c: 154: set_submap_indices(
	ldx	#0x00
	lda	_map_pos_y
	sta	*(REGTEMP+0)
	lda	#0x42
	sec
	sbc	*(REGTEMP+0)
	sta	*_set_camera_sloc0_1_0
	txa
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	sta	*(_set_camera_sloc0_1_0 + 1)
	lda	#0x1f
	sec
	sbc	*_set_camera_sloc0_1_0
	txa
	sbc	*(_set_camera_sloc0_1_0 + 1)
	bvc	00259$
	bpl	00258$
	bmi	00142$
00259$:
	bpl	00142$
00258$:
	lda	#0x1f
	jmp	00143$
00142$:
	lda	#0x42
	sec
	sbc	_map_pos_y
00143$:
	ldx	#>_bigmap_map
	stx	(_set_bkg_submap_PARM_5 + 1)
	ldx	#_bigmap_map
	stx	_set_bkg_submap_PARM_5
	ldx	#0x01
	stx	_set_bkg_submap_PARM_3
	sta	_set_bkg_submap_PARM_4
	ldx	#0x9c
	stx	_set_bkg_submap_PARM_6
	tya
	ldx	_map_pos_y
	jsr	_set_bkg_submap
;	src/large_map.c: 161: set_submap_attributes(
	ldx	#0x00
	lda	_map_pos_y
	sta	*(REGTEMP+0)
	lda	#0x42
	sec
	sbc	*(REGTEMP+0)
	sta	*_set_camera_sloc0_1_0
	txa
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	sta	*(_set_camera_sloc0_1_0 + 1)
	lda	#0x1f
	sec
	sbc	*_set_camera_sloc0_1_0
	txa
	sbc	*(_set_camera_sloc0_1_0 + 1)
	bvc	00262$
	bpl	00261$
	bmi	00144$
00262$:
	bpl	00144$
00261$:
	ldx	#0x1f
	jmp	00145$
00144$:
	lda	#0x42
	sec
	sbc	_map_pos_y
	tax
00145$:
;	src/large_map.c: 65: return map_pos_x + DEVICE_SCREEN_WIDTH;
	lda	_map_pos_x
	clc
	adc	#0x20
;	../../../include/nes/nes.h: 753: set_bkg_submap_attributes_nes16x16(x >> 1, y >> 1, (w + 1) >> 1, (h + 1) >> 1, attributes, map_w >> 1);
	lsr	a
	tay
	lda	_map_pos_y
	lsr	a
	sta	*_set_camera_sloc0_1_0
	txa
	ldx	#0x00
	clc
	adc	#0x01
	bcc	00264$
	inx
00264$:
	stx	*(REGTEMP+0)
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	sta	_set_bkg_submap_attributes_nes16x16_PARM_4
	ldx	#0x01
	stx	_set_bkg_submap_attributes_nes16x16_PARM_3
	lda	#>_bigmap_map_attributes
	sta	(_set_bkg_submap_attributes_nes16x16_PARM_5 + 1)
	lda	#_bigmap_map_attributes
	sta	_set_bkg_submap_attributes_nes16x16_PARM_5
	ldx	#0x4e
	stx	_set_bkg_submap_attributes_nes16x16_PARM_6
	tya
	ldx	*_set_camera_sloc0_1_0
	jsr	_set_bkg_submap_attributes_nes16x16
;	src/large_map.c: 161: set_submap_attributes(
00112$:
;	src/large_map.c: 170: old_map_pos_x = map_pos_x;
	lda	_map_pos_x
	sta	_old_map_pos_x
00114$:
;	src/large_map.c: 173: old_camera_x = camera_x, old_camera_y = camera_y;
	lda	(_camera_x + 1)
	sta	(_old_camera_x + 1)
	lda	_camera_x
	sta	_old_camera_x
	lda	(_camera_y + 1)
	sta	(_old_camera_y + 1)
	lda	_camera_y
	sta	_old_camera_y
;	src/large_map.c: 174: }
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'init_camera'
;------------------------------------------------------------
;sloc0                     Allocated with name '_init_camera_sloc0_1_0'
;sloc1                     Allocated with name '_init_camera_sloc1_1_0'
;y                         Allocated with name '_init_camera_y_10000_172'
;x                         Allocated to registers a 
;__200000061               Allocated to registers 
;__200000062               Allocated to registers 
;__200000063               Allocated to registers 
;first_tile                Allocated to registers 
;nb_tiles                  Allocated to registers 
;data                      Allocated to registers 
;__200000065               Allocated to registers 
;__200000066               Allocated to registers a 
;x                         Allocated to registers 
;y                         Allocated to registers 
;__200000068               Allocated to registers 
;__200000069               Allocated to registers 
;__200000070               Allocated to registers x 
;__200000071               Allocated to registers y 
;__200000072               Allocated to registers 
;__200000073               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;w                         Allocated to registers 
;h                         Allocated to registers 
;attributes                Allocated to registers 
;map_w                     Allocated to registers 
;__200000075               Allocated to registers 
;__200000076               Allocated to registers a 
;x                         Allocated to registers 
;y                         Allocated to registers 
;------------------------------------------------------------
;	src/large_map.c: 177: void init_camera(uint8_t x, uint8_t y) {
;	-----------------------------------------
;	 function init_camera
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_init_camera:
	stx	_init_camera_y_10000_172
;	src/large_map.c: 180: set_native_tile_data(0, bigmap_TILE_COUNT, bigmap_tiles);
	ldx	#>_bigmap_tiles
	stx	(_set_bkg_native_data_PARM_3 + 1)
	ldx	#_bigmap_tiles
	stx	_set_bkg_native_data_PARM_3
;	../../../include/nes/nes.h: 1207: set_bkg_native_data(first_tile, nb_tiles, data);
	pha
	lda	#0x00
	ldx	#0xe1
	jsr	_set_bkg_native_data
	pla
;	src/large_map.c: 192: set_bkg_palette(0, bigmap_PALETTE_COUNT, bigmap_palettes);
	ldx	#>_bigmap_palettes
	stx	(_set_bkg_palette_PARM_3 + 1)
	ldx	#_bigmap_palettes
	stx	_set_bkg_palette_PARM_3
	pha
	lda	#0x00
	ldx	#0x04
	jsr	_set_bkg_palette
	pla
;	src/large_map.c: 197: camera_x = x;
	sta	_camera_x
	ldx	#0x00
	stx	(_camera_x + 1)
;	src/large_map.c: 198: camera_y = y;
	lda	_init_camera_y_10000_172
	sta	_camera_y
	stx	(_camera_y + 1)
;	src/large_map.c: 202: old_camera_x = camera_x; old_camera_y = camera_y;
	lda	(_camera_x + 1)
	sta	(_old_camera_x + 1)
	lda	_camera_x
	sta	_old_camera_x
	lda	(_camera_y + 1)
	sta	(_old_camera_y + 1)
	lda	_camera_y
	sta	_old_camera_y
;	src/large_map.c: 204: map_pos_x = camera_x >> 3;
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
	sta	*_init_camera_sloc0_1_0
	sta	_map_pos_x
;	src/large_map.c: 205: map_pos_y = camera_y >> 3;
	ldx	(_camera_y + 1)
	lda	_camera_y
	stx	*(REGTEMP+0)
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	lsr	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	sta	*_init_camera_sloc1_1_0
	sta	_map_pos_y
;	src/large_map.c: 206: old_map_pos_x = old_map_pos_y = 255;
	ldx	#0xff
	stx	_old_map_pos_y
	stx	_old_map_pos_x
;	src/large_map.c: 207: move_bkg(camera_x, WRAP_SCROLL_Y(camera_y + SCROLL_Y_OFFSET));
	ldx	(_camera_y + 1)
	lda	_camera_y
	clc
	adc	#0x04
	bcc	00154$
	inx
00154$:
	ldy	#0xf0
	sty	__moduint_PARM_2
	ldy	#0x00
	sty	(__moduint_PARM_2 + 1)
	jsr	__moduint
	ldx	_camera_x
	stx	_bkg_scroll_x
;	../../../include/nes/nes.h: 918: bkg_scroll_x = x, bkg_scroll_y = y;
	sta	_bkg_scroll_y
;	src/large_map.c: 210: set_submap_indices(
	ldx	#0x00
	lda	*_init_camera_sloc0_1_0
	sta	*(REGTEMP+0)
	lda	#0x9c
	sec
	sbc	*(REGTEMP+0)
	pha
	txa
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	tax
	pla
	sta	*(REGTEMP+0)
	lda	#0x21
	sec
	sbc	*(REGTEMP+0)
	lda	#0x00
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	bcs	00116$
	ldy	#0x21
	jmp	00117$
00116$:
	lda	#0x9c
	sec
	sbc	*_init_camera_sloc0_1_0
	tay
00117$:
	ldx	#0x00
	lda	*_init_camera_sloc1_1_0
	sta	*(REGTEMP+0)
	lda	#0x42
	sec
	sbc	*(REGTEMP+0)
	pha
	txa
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	tax
	pla
	sta	*(REGTEMP+0)
	lda	#0x1f
	sec
	sbc	*(REGTEMP+0)
	lda	#0x00
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	bcs	00118$
	lda	#0x1f
	jmp	00119$
00118$:
	lda	#0x42
	sec
	sbc	*_init_camera_sloc1_1_0
00119$:
	ldx	#>_bigmap_map
	stx	(_set_bkg_submap_PARM_5 + 1)
	ldx	#_bigmap_map
	stx	_set_bkg_submap_PARM_5
	sty	_set_bkg_submap_PARM_3
	sta	_set_bkg_submap_PARM_4
	ldx	#0x9c
	stx	_set_bkg_submap_PARM_6
	lda	*_init_camera_sloc0_1_0
	ldx	*_init_camera_sloc1_1_0
	jsr	_set_bkg_submap
;	src/large_map.c: 218: set_submap_attributes(
	ldx	#0x00
	lda	_map_pos_y
	sta	*(REGTEMP+0)
	lda	#0x42
	sec
	sbc	*(REGTEMP+0)
	pha
	txa
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	tax
	pla
	sta	*(REGTEMP+0)
	lda	#0x1f
	sec
	sbc	*(REGTEMP+0)
	lda	#0x00
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	bcs	00120$
	ldy	#0x1f
	jmp	00121$
00120$:
	lda	#0x42
	sec
	sbc	_map_pos_y
	tay
00121$:
	ldx	#0x00
	lda	_map_pos_x
	sta	*(REGTEMP+0)
	lda	#0x9c
	sec
	sbc	*(REGTEMP+0)
	pha
	txa
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	tax
	pla
	sta	*(REGTEMP+0)
	lda	#0x21
	sec
	sbc	*(REGTEMP+0)
	lda	#0x00
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	bcs	00122$
	ldx	#0x21
	jmp	00123$
00122$:
	lda	#0x9c
	sec
	sbc	_map_pos_x
	tax
00123$:
;	../../../include/nes/nes.h: 753: set_bkg_submap_attributes_nes16x16(x >> 1, y >> 1, (w + 1) >> 1, (h + 1) >> 1, attributes, map_w >> 1);
	lda	_map_pos_x
	lsr	a
	sta	*_init_camera_sloc1_1_0
	lda	_map_pos_y
	lsr	a
	sta	*_init_camera_sloc0_1_0
	txa
	ldx	#0x00
	clc
	adc	#0x01
	bcc	00159$
	inx
00159$:
	stx	*(REGTEMP+0)
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	sta	_set_bkg_submap_attributes_nes16x16_PARM_3
	ldx	#0x00
	tya
	clc
	adc	#0x01
	bcc	00160$
	inx
00160$:
	stx	*(REGTEMP+0)
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	sta	_set_bkg_submap_attributes_nes16x16_PARM_4
	lda	#>_bigmap_map_attributes
	sta	(_set_bkg_submap_attributes_nes16x16_PARM_5 + 1)
	lda	#_bigmap_map_attributes
	sta	_set_bkg_submap_attributes_nes16x16_PARM_5
	ldx	#0x4e
	stx	_set_bkg_submap_attributes_nes16x16_PARM_6
	lda	*_init_camera_sloc1_1_0
	ldx	*_init_camera_sloc0_1_0
	jsr	_set_bkg_submap_attributes_nes16x16
;	src/large_map.c: 226: redraw = FALSE;
	ldx	#0x00
	stx	_redraw
;	src/large_map.c: 228: move_bkg(camera_x, WRAP_SCROLL_Y(camera_y + SCROLL_Y_OFFSET));
	ldx	(_camera_y + 1)
	lda	_camera_y
	clc
	adc	#0x04
	bcc	00161$
	inx
00161$:
	ldy	#0xf0
	sty	__moduint_PARM_2
	ldy	#0x00
	sty	(__moduint_PARM_2 + 1)
	jsr	__moduint
	ldx	_camera_x
	stx	_bkg_scroll_x
;	../../../include/nes/nes.h: 918: bkg_scroll_x = x, bkg_scroll_y = y;
	sta	_bkg_scroll_y
;	src/large_map.c: 233: HIDE_LEFT_COLUMN;
	lda	_shadow_PPUMASK
	and	#0xf9
	sta	_shadow_PPUMASK
;	src/large_map.c: 235: }
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;	src/large_map.c: 237: void main(void){
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/large_map.c: 238: DISPLAY_OFF;
	jsr	_display_off
;	src/large_map.c: 239: init_camera(0, 0);
	lda	#0x00
	tax
	jsr	_init_camera
;	src/large_map.c: 241: SHOW_BKG;
	lda	_shadow_PPUMASK
	ora	#0x08
	sta	_shadow_PPUMASK
;	src/large_map.c: 242: DISPLAY_ON;
	jsr	_display_on
;	src/large_map.c: 243: while (TRUE) {
00123$:
;	src/large_map.c: 244: joy = joypad();
	jsr	_joypad
	sta	_joy
;	src/large_map.c: 246: if (joy & J_UP) {
	ldx	#0x08
	stx	*(REGTEMP+0)
	bit	*(REGTEMP+0)
	beq	00108$
;	src/large_map.c: 247: if (camera_y) {
	lda	(_camera_y + 1)
	ora	_camera_y
	beq	00109$
;	src/large_map.c: 248: camera_y--;
	sec
	lda	_camera_y
	sbc	#0x01
	sta	_camera_y
	bcs	00190$
	dec	(_camera_y + 1)
00190$:
;	src/large_map.c: 249: redraw = TRUE;
	ldx	#0x01
	stx	_redraw
	jmp	00109$
00108$:
;	src/large_map.c: 251: } else if (joy & J_DOWN) {
	and	#0x04
	beq	00109$
;	src/large_map.c: 252: if (camera_y < camera_max_y) {
	ldx	(_camera_y + 1)
	lda	_camera_y
	sec
	sbc	#0x20
	txa
	sbc	#0x01
	bcs	00109$
;	src/large_map.c: 253: camera_y++;
	inc	_camera_y
	bne	00193$
	inc	(_camera_y + 1)
00193$:
;	src/large_map.c: 254: redraw = TRUE;
	ldx	#0x01
	stx	_redraw
00109$:
;	src/large_map.c: 258: if (joy & J_LEFT) {
	lda	_joy
	ldx	#0x02
	stx	*(REGTEMP+0)
	bit	*(REGTEMP+0)
	beq	00117$
;	src/large_map.c: 259: if (camera_x) {
	lda	(_camera_x + 1)
	ora	_camera_x
	beq	00118$
;	src/large_map.c: 260: camera_x--;
	sec
	lda	_camera_x
	sbc	#0x01
	sta	_camera_x
	bcs	00197$
	dec	(_camera_x + 1)
00197$:
;	src/large_map.c: 261: redraw = TRUE;
	dex
	stx	_redraw
	jmp	00118$
00117$:
;	src/large_map.c: 263: } else if (joy & J_RIGHT) {
	and	#0x01
	beq	00118$
;	src/large_map.c: 264: if (camera_x < camera_max_x) {
	ldx	(_camera_x + 1)
	lda	_camera_x
	sec
	sbc	#0xe0
	txa
	sbc	#0x03
	bcs	00118$
;	src/large_map.c: 265: camera_x++;
	inc	_camera_x
	bne	00200$
	inc	(_camera_x + 1)
00200$:
;	src/large_map.c: 266: redraw = TRUE;
	ldx	#0x01
	stx	_redraw
00118$:
;	src/large_map.c: 269: if (redraw) {
	lda	_redraw
	beq	00120$
;	src/large_map.c: 270: vsync();
	jsr	_vsync
;	src/large_map.c: 271: set_camera();
	jsr	_set_camera
;	src/large_map.c: 272: redraw = FALSE;
	ldx	#0x00
	stx	_redraw
	jmp	00123$
00120$:
;	src/large_map.c: 273: } else vsync();
	jsr	_vsync
	jmp	00123$
;	src/large_map.c: 275: }
	rts
	.area _CODE
	.area _XINIT
	.area _CABS    (ABS)
