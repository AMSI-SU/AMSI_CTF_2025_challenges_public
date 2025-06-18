;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module joytest
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
	.globl _reset_object_pos
	.globl _draw_disabled
	.globl _draw_buttons
	.globl _fill_bkg_rect
	.globl _scroll_sprite
	.globl _move_sprite
	.globl _set_sprite_tile
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _vsync
	.globl _joypad_ex
	.globl _joypad_init
	.globl _joypad
	.globl _joy
	.globl _old_joy
	.globl _isSGB
	.globl _toggle
	.globl _joypads
	.globl _old_joypads
	.globl _draw_buttons_PARM_3
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
_main_sloc0_1_0:
	.ds 1
_main_sloc1_1_0:
	.ds 2
;--------------------------------------------------------
; overlayable items in ram
;--------------------------------------------------------
	.area	OSEG    (PAG, OVR)
_draw_buttons_sloc0_1_0:
	.ds 1
	.area	OSEG    (PAG, OVR)
_draw_disabled_sloc0_1_0:
	.ds 1
	.area	OSEG    (PAG, OVR)
_reset_object_pos_sloc0_1_0:
	.ds 1
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
_draw_buttons_PARM_3:
	.ds 1
_draw_buttons_x_10000_88:
	.ds 1
_draw_buttons_state_10000_88:
	.ds 1
_draw_buttons___200000007_20000_90:
	.ds 1
_draw_disabled_y_10000_114:
	.ds 1
_old_joypads::
	.ds 5
_joypads::
	.ds 5
_main_j_50000_156:
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS    (ABS)
;--------------------------------------------------------
; initialized external ram data
;--------------------------------------------------------
	.area _DATA
_toggle::
	.ds 1
_isSGB::
	.ds 1
_old_joy::
	.ds 1
_joy::
	.ds 1
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
;Allocation info for local variables in function 'draw_buttons'
;------------------------------------------------------------
;y                         Allocated with name '_draw_buttons_PARM_3'
;x                         Allocated with name '_draw_buttons_x_10000_88'
;state                     Allocated with name '_draw_buttons_state_10000_88'
;__200000006               Allocated to registers 
;__200000007               Allocated with name '_draw_buttons___200000007_20000_90'
;__200000008               Allocated to registers 
;__200000009               Allocated to registers 
;__200000010               Allocated to registers 
;__200000011               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;w                         Allocated to registers 
;h                         Allocated to registers 
;tiles                     Allocated to registers 
;base_tile                 Allocated to registers 
;__200000013               Allocated to registers a 
;__200000014               Allocated to registers 
;__200000015               Allocated to registers 
;__200000016               Allocated to registers 
;__200000017               Allocated to registers 
;__200000018               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;w                         Allocated to registers 
;h                         Allocated to registers 
;tiles                     Allocated to registers 
;base_tile                 Allocated to registers 
;__200000020               Allocated to registers a 
;__200000021               Allocated to registers 
;__200000022               Allocated to registers 
;__200000023               Allocated to registers 
;__200000024               Allocated to registers 
;__200000025               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;w                         Allocated to registers 
;h                         Allocated to registers 
;tiles                     Allocated to registers 
;base_tile                 Allocated to registers 
;__200000027               Allocated to registers a 
;__200000028               Allocated to registers 
;__200000029               Allocated to registers 
;__200000030               Allocated to registers 
;__200000031               Allocated to registers 
;__200000032               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;w                         Allocated to registers 
;h                         Allocated to registers 
;tiles                     Allocated to registers 
;base_tile                 Allocated to registers 
;__200000034               Allocated to registers a 
;__200000035               Allocated to registers 
;__200000036               Allocated to registers 
;__200000037               Allocated to registers 
;__200000038               Allocated to registers 
;__200000039               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;w                         Allocated to registers 
;h                         Allocated to registers 
;tiles                     Allocated to registers 
;base_tile                 Allocated to registers 
;__200000041               Allocated to registers a 
;__200000042               Allocated to registers 
;__200000043               Allocated to registers 
;__200000044               Allocated to registers 
;__200000045               Allocated to registers 
;__200000046               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;w                         Allocated to registers 
;h                         Allocated to registers 
;tiles                     Allocated to registers 
;base_tile                 Allocated to registers 
;__200000048               Allocated to registers a 
;__200000049               Allocated to registers 
;__200000050               Allocated to registers 
;__200000051               Allocated to registers 
;__200000052               Allocated to registers 
;__200000053               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;w                         Allocated to registers 
;h                         Allocated to registers 
;tiles                     Allocated to registers 
;base_tile                 Allocated to registers 
;__200000055               Allocated to registers a 
;__200000056               Allocated to registers 
;__200000057               Allocated to registers 
;__200000058               Allocated to registers 
;__200000059               Allocated to registers 
;__200000060               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;w                         Allocated to registers 
;h                         Allocated to registers 
;tiles                     Allocated to registers 
;base_tile                 Allocated to registers 
;sloc0                     Allocated with name '_draw_buttons_sloc0_1_0'
;------------------------------------------------------------
;	src/joytest.c: 13: void draw_buttons(uint8_t state, uint8_t x, uint8_t y) {
;	-----------------------------------------
;	 function draw_buttons
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_draw_buttons:
	sta	_draw_buttons_state_10000_88
	stx	_draw_buttons_x_10000_88
;	src/joytest.c: 14: set_bkg_based_tiles(x,      y, 2, 2, (state & J_UP)     ? pressed_buttons[0] : normal_buttons[0], 1);
	lda	#0x08
	and	_draw_buttons_state_10000_88
	beq	00111$
	lda	#_pressed_buttons
	ldx	#>_pressed_buttons
	jmp	00112$
00111$:
	lda	#_normal_buttons
	ldx	#>_normal_buttons
00112$:
	sta	_set_bkg_tiles_PARM_5
	stx	(_set_bkg_tiles_PARM_5 + 1)
	lda	_draw_buttons_PARM_3
	sta	_draw_buttons___200000007_20000_90
;	../../../include/nes/nes.h: 778: _map_tile_offset = base_tile;
	ldx	#0x01
	stx	__map_tile_offset
;	../../../include/nes/nes.h: 779: set_bkg_tiles(x, y, w, h, tiles);
	inx
	stx	_set_bkg_tiles_PARM_3
	stx	_set_bkg_tiles_PARM_4
	lda	_draw_buttons_x_10000_88
	ldx	_draw_buttons___200000007_20000_90
	jsr	_set_bkg_tiles
;	../../../include/nes/nes.h: 780: _map_tile_offset = 0;
	ldx	#0x00
	stx	__map_tile_offset
;	src/joytest.c: 15: set_bkg_based_tiles(x + 2,  y, 2, 2, (state & J_DOWN)   ? pressed_buttons[1] : normal_buttons[1], 1);
	lda	#0x04
	and	_draw_buttons_state_10000_88
	beq	00113$
	ldx	#>_pressed_buttons
	lda	#_pressed_buttons
	clc
	adc	#0x04
	bcc	00114$
	inx
	jmp	00114$
00113$:
	ldx	#>_normal_buttons
	lda	#_normal_buttons
	clc
	adc	#0x04
	bcc	00180$
	inx
00180$:
00114$:
	sta	_set_bkg_tiles_PARM_5
	stx	(_set_bkg_tiles_PARM_5 + 1)
	lda	_draw_buttons_x_10000_88
	sta	*_draw_buttons_sloc0_1_0
	clc
	adc	#0x02
;	../../../include/nes/nes.h: 778: _map_tile_offset = base_tile;
	ldx	#0x01
	stx	__map_tile_offset
;	../../../include/nes/nes.h: 779: set_bkg_tiles(x, y, w, h, tiles);
	inx
	stx	_set_bkg_tiles_PARM_3
	stx	_set_bkg_tiles_PARM_4
	ldx	_draw_buttons___200000007_20000_90
	jsr	_set_bkg_tiles
;	../../../include/nes/nes.h: 780: _map_tile_offset = 0;
	ldx	#0x00
	stx	__map_tile_offset
;	src/joytest.c: 16: set_bkg_based_tiles(x + 4,  y, 2, 2, (state & J_LEFT)   ? pressed_buttons[2] : normal_buttons[2], 1);
	lda	#0x02
	and	_draw_buttons_state_10000_88
	beq	00115$
	ldx	#>_pressed_buttons
	lda	#_pressed_buttons
	clc
	adc	#0x08
	bcc	00116$
	inx
	jmp	00116$
00115$:
	ldx	#>_normal_buttons
	lda	#_normal_buttons
	clc
	adc	#0x08
	bcc	00184$
	inx
00184$:
00116$:
	sta	_set_bkg_tiles_PARM_5
	stx	(_set_bkg_tiles_PARM_5 + 1)
	lda	*_draw_buttons_sloc0_1_0
	clc
	adc	#0x04
;	../../../include/nes/nes.h: 778: _map_tile_offset = base_tile;
	ldx	#0x01
	stx	__map_tile_offset
;	../../../include/nes/nes.h: 779: set_bkg_tiles(x, y, w, h, tiles);
	inx
	stx	_set_bkg_tiles_PARM_3
	stx	_set_bkg_tiles_PARM_4
	ldx	_draw_buttons___200000007_20000_90
	jsr	_set_bkg_tiles
;	../../../include/nes/nes.h: 780: _map_tile_offset = 0;
	ldx	#0x00
	stx	__map_tile_offset
;	src/joytest.c: 17: set_bkg_based_tiles(x + 6,  y, 2, 2, (state & J_RIGHT)  ? pressed_buttons[3] : normal_buttons[3], 1);
	lda	#0x01
	and	_draw_buttons_state_10000_88
	beq	00117$
	ldx	#>_pressed_buttons
	lda	#_pressed_buttons
	clc
	adc	#0x0c
	bcc	00118$
	inx
	jmp	00118$
00117$:
	ldx	#>_normal_buttons
	lda	#_normal_buttons
	clc
	adc	#0x0c
	bcc	00188$
	inx
00188$:
00118$:
	sta	_set_bkg_tiles_PARM_5
	stx	(_set_bkg_tiles_PARM_5 + 1)
	lda	*_draw_buttons_sloc0_1_0
	clc
	adc	#0x06
;	../../../include/nes/nes.h: 778: _map_tile_offset = base_tile;
	ldx	#0x01
	stx	__map_tile_offset
;	../../../include/nes/nes.h: 779: set_bkg_tiles(x, y, w, h, tiles);
	inx
	stx	_set_bkg_tiles_PARM_3
	stx	_set_bkg_tiles_PARM_4
	ldx	_draw_buttons___200000007_20000_90
	jsr	_set_bkg_tiles
;	../../../include/nes/nes.h: 780: _map_tile_offset = 0;
	ldx	#0x00
	stx	__map_tile_offset
;	src/joytest.c: 18: set_bkg_based_tiles(x + 8,  y, 2, 2, (state & J_A)      ? pressed_buttons[4] : normal_buttons[4], 1);
	bit	_draw_buttons_state_10000_88
	bpl	00119$
	ldx	#>_pressed_buttons
	lda	#_pressed_buttons
	clc
	adc	#0x10
	bcc	00120$
	inx
	jmp	00120$
00119$:
	ldx	#>_normal_buttons
	lda	#_normal_buttons
	clc
	adc	#0x10
	bcc	00191$
	inx
00191$:
00120$:
	sta	_set_bkg_tiles_PARM_5
	stx	(_set_bkg_tiles_PARM_5 + 1)
	lda	*_draw_buttons_sloc0_1_0
	clc
	adc	#0x08
;	../../../include/nes/nes.h: 778: _map_tile_offset = base_tile;
	ldx	#0x01
	stx	__map_tile_offset
;	../../../include/nes/nes.h: 779: set_bkg_tiles(x, y, w, h, tiles);
	inx
	stx	_set_bkg_tiles_PARM_3
	stx	_set_bkg_tiles_PARM_4
	ldx	_draw_buttons___200000007_20000_90
	jsr	_set_bkg_tiles
;	../../../include/nes/nes.h: 780: _map_tile_offset = 0;
	ldx	#0x00
	stx	__map_tile_offset
;	src/joytest.c: 19: set_bkg_based_tiles(x + 10, y, 2, 2, (state & J_B)      ? pressed_buttons[5] : normal_buttons[5], 1);
	bit	_draw_buttons_state_10000_88
	bvc	00121$
	ldx	#>_pressed_buttons
	lda	#_pressed_buttons
	clc
	adc	#0x14
	bcc	00122$
	inx
	jmp	00122$
00121$:
	ldx	#>_normal_buttons
	lda	#_normal_buttons
	clc
	adc	#0x14
	bcc	00194$
	inx
00194$:
00122$:
	sta	_set_bkg_tiles_PARM_5
	stx	(_set_bkg_tiles_PARM_5 + 1)
	lda	*_draw_buttons_sloc0_1_0
	clc
	adc	#0x0a
;	../../../include/nes/nes.h: 778: _map_tile_offset = base_tile;
	ldx	#0x01
	stx	__map_tile_offset
;	../../../include/nes/nes.h: 779: set_bkg_tiles(x, y, w, h, tiles);
	inx
	stx	_set_bkg_tiles_PARM_3
	stx	_set_bkg_tiles_PARM_4
	ldx	_draw_buttons___200000007_20000_90
	jsr	_set_bkg_tiles
;	../../../include/nes/nes.h: 780: _map_tile_offset = 0;
	ldx	#0x00
	stx	__map_tile_offset
;	src/joytest.c: 20: set_bkg_based_tiles(x + 12, y, 2, 2, (state & J_START)  ? pressed_buttons[6] : normal_buttons[6], 1);
	lda	#0x10
	and	_draw_buttons_state_10000_88
	beq	00123$
	ldx	#>_pressed_buttons
	lda	#_pressed_buttons
	clc
	adc	#0x18
	bcc	00124$
	inx
	jmp	00124$
00123$:
	ldx	#>_normal_buttons
	lda	#_normal_buttons
	clc
	adc	#0x18
	bcc	00198$
	inx
00198$:
00124$:
	sta	_set_bkg_tiles_PARM_5
	stx	(_set_bkg_tiles_PARM_5 + 1)
	lda	*_draw_buttons_sloc0_1_0
	clc
	adc	#0x0c
;	../../../include/nes/nes.h: 778: _map_tile_offset = base_tile;
	ldx	#0x01
	stx	__map_tile_offset
;	../../../include/nes/nes.h: 779: set_bkg_tiles(x, y, w, h, tiles);
	inx
	stx	_set_bkg_tiles_PARM_3
	stx	_set_bkg_tiles_PARM_4
	ldx	_draw_buttons___200000007_20000_90
	jsr	_set_bkg_tiles
;	../../../include/nes/nes.h: 780: _map_tile_offset = 0;
	ldx	#0x00
	stx	__map_tile_offset
;	src/joytest.c: 21: set_bkg_based_tiles(x + 14, y, 2, 2, (state & J_SELECT) ? pressed_buttons[7] : normal_buttons[7], 1);
	lda	#0x20
	and	_draw_buttons_state_10000_88
	beq	00125$
	ldx	#>_pressed_buttons
	lda	#_pressed_buttons
	clc
	adc	#0x1c
	bcc	00126$
	inx
	jmp	00126$
00125$:
	ldx	#>_normal_buttons
	lda	#_normal_buttons
	clc
	adc	#0x1c
	bcc	00202$
	inx
00202$:
00126$:
	sta	_set_bkg_tiles_PARM_5
	stx	(_set_bkg_tiles_PARM_5 + 1)
	lda	*_draw_buttons_sloc0_1_0
	clc
	adc	#0x0e
;	../../../include/nes/nes.h: 778: _map_tile_offset = base_tile;
	ldx	#0x01
	stx	__map_tile_offset
;	../../../include/nes/nes.h: 779: set_bkg_tiles(x, y, w, h, tiles);
	inx
	stx	_set_bkg_tiles_PARM_3
	stx	_set_bkg_tiles_PARM_4
	ldx	_draw_buttons___200000007_20000_90
	jsr	_set_bkg_tiles
;	../../../include/nes/nes.h: 780: _map_tile_offset = 0;
	ldx	#0x00
	stx	__map_tile_offset
;	src/joytest.c: 21: set_bkg_based_tiles(x + 14, y, 2, 2, (state & J_SELECT) ? pressed_buttons[7] : normal_buttons[7], 1);
;	src/joytest.c: 22: }
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'draw_disabled'
;------------------------------------------------------------
;y                         Allocated with name '_draw_disabled_y_10000_114'
;x                         Allocated to registers a 
;__200000062               Allocated to registers 
;__200000063               Allocated to registers 
;__200000064               Allocated to registers 
;__200000065               Allocated to registers 
;__200000066               Allocated to registers 
;__200000067               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;w                         Allocated to registers 
;h                         Allocated to registers 
;tiles                     Allocated to registers 
;base_tile                 Allocated to registers 
;__200000069               Allocated to registers a 
;__200000070               Allocated to registers 
;__200000071               Allocated to registers 
;__200000072               Allocated to registers 
;__200000073               Allocated to registers 
;__200000074               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;w                         Allocated to registers 
;h                         Allocated to registers 
;tiles                     Allocated to registers 
;base_tile                 Allocated to registers 
;__200000076               Allocated to registers a 
;__200000077               Allocated to registers 
;__200000078               Allocated to registers 
;__200000079               Allocated to registers 
;__200000080               Allocated to registers 
;__200000081               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;w                         Allocated to registers 
;h                         Allocated to registers 
;tiles                     Allocated to registers 
;base_tile                 Allocated to registers 
;__200000083               Allocated to registers a 
;__200000084               Allocated to registers 
;__200000085               Allocated to registers 
;__200000086               Allocated to registers 
;__200000087               Allocated to registers 
;__200000088               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;w                         Allocated to registers 
;h                         Allocated to registers 
;tiles                     Allocated to registers 
;base_tile                 Allocated to registers 
;__200000090               Allocated to registers a 
;__200000091               Allocated to registers 
;__200000092               Allocated to registers 
;__200000093               Allocated to registers 
;__200000094               Allocated to registers 
;__200000095               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;w                         Allocated to registers 
;h                         Allocated to registers 
;tiles                     Allocated to registers 
;base_tile                 Allocated to registers 
;__200000097               Allocated to registers a 
;__200000098               Allocated to registers 
;__200000099               Allocated to registers 
;__200000100               Allocated to registers 
;__200000101               Allocated to registers 
;__200000102               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;w                         Allocated to registers 
;h                         Allocated to registers 
;tiles                     Allocated to registers 
;base_tile                 Allocated to registers 
;__200000104               Allocated to registers a 
;__200000105               Allocated to registers 
;__200000106               Allocated to registers 
;__200000107               Allocated to registers 
;__200000108               Allocated to registers 
;__200000109               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;w                         Allocated to registers 
;h                         Allocated to registers 
;tiles                     Allocated to registers 
;base_tile                 Allocated to registers 
;__200000111               Allocated to registers a 
;__200000112               Allocated to registers 
;__200000113               Allocated to registers 
;__200000114               Allocated to registers 
;__200000115               Allocated to registers 
;__200000116               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;w                         Allocated to registers 
;h                         Allocated to registers 
;tiles                     Allocated to registers 
;base_tile                 Allocated to registers 
;sloc0                     Allocated with name '_draw_disabled_sloc0_1_0'
;------------------------------------------------------------
;	src/joytest.c: 24: void draw_disabled(uint8_t x, uint8_t y) {
;	-----------------------------------------
;	 function draw_disabled
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_draw_disabled:
	stx	_draw_disabled_y_10000_114
;	src/joytest.c: 25: set_bkg_based_tiles(x,      y, 2, 2, disabled_buttons[0], 1);
	ldx	#>_disabled_buttons
	stx	(_set_bkg_tiles_PARM_5 + 1)
	ldx	#_disabled_buttons
	stx	_set_bkg_tiles_PARM_5
;	../../../include/nes/nes.h: 778: _map_tile_offset = base_tile;
	ldx	#0x01
	stx	__map_tile_offset
;	../../../include/nes/nes.h: 779: set_bkg_tiles(x, y, w, h, tiles);
	inx
	stx	_set_bkg_tiles_PARM_3
	stx	_set_bkg_tiles_PARM_4
	pha
	ldx	_draw_disabled_y_10000_114
	jsr	_set_bkg_tiles
	pla
;	src/joytest.c: 26: set_bkg_based_tiles(x + 2,  y, 2, 2, disabled_buttons[1], 1);
	ldx	#>(_disabled_buttons + 0x0004)
	stx	(_set_bkg_tiles_PARM_5 + 1)
	ldx	#(_disabled_buttons + 0x0004)
	stx	_set_bkg_tiles_PARM_5
	sta	*_draw_disabled_sloc0_1_0
	clc
	adc	#0x02
;	../../../include/nes/nes.h: 778: _map_tile_offset = base_tile;
	ldx	#0x01
	stx	__map_tile_offset
;	../../../include/nes/nes.h: 779: set_bkg_tiles(x, y, w, h, tiles);
	inx
	stx	_set_bkg_tiles_PARM_3
	stx	_set_bkg_tiles_PARM_4
	ldx	_draw_disabled_y_10000_114
	jsr	_set_bkg_tiles
;	src/joytest.c: 27: set_bkg_based_tiles(x + 4,  y, 2, 2, disabled_buttons[2], 1);
	lda	#>(_disabled_buttons + 0x0008)
	sta	(_set_bkg_tiles_PARM_5 + 1)
	lda	#(_disabled_buttons + 0x0008)
	sta	_set_bkg_tiles_PARM_5
	lda	*_draw_disabled_sloc0_1_0
	clc
	adc	#0x04
;	../../../include/nes/nes.h: 778: _map_tile_offset = base_tile;
	ldx	#0x01
	stx	__map_tile_offset
;	../../../include/nes/nes.h: 779: set_bkg_tiles(x, y, w, h, tiles);
	inx
	stx	_set_bkg_tiles_PARM_3
	stx	_set_bkg_tiles_PARM_4
	ldx	_draw_disabled_y_10000_114
	jsr	_set_bkg_tiles
;	src/joytest.c: 28: set_bkg_based_tiles(x + 6,  y, 2, 2, disabled_buttons[3], 1);
	lda	#>(_disabled_buttons + 0x000c)
	sta	(_set_bkg_tiles_PARM_5 + 1)
	lda	#(_disabled_buttons + 0x000c)
	sta	_set_bkg_tiles_PARM_5
	lda	*_draw_disabled_sloc0_1_0
	clc
	adc	#0x06
;	../../../include/nes/nes.h: 778: _map_tile_offset = base_tile;
	ldx	#0x01
	stx	__map_tile_offset
;	../../../include/nes/nes.h: 779: set_bkg_tiles(x, y, w, h, tiles);
	inx
	stx	_set_bkg_tiles_PARM_3
	stx	_set_bkg_tiles_PARM_4
	ldx	_draw_disabled_y_10000_114
	jsr	_set_bkg_tiles
;	src/joytest.c: 29: set_bkg_based_tiles(x + 8,  y, 2, 2, disabled_buttons[4], 1);
	lda	#>(_disabled_buttons + 0x0010)
	sta	(_set_bkg_tiles_PARM_5 + 1)
	lda	#(_disabled_buttons + 0x0010)
	sta	_set_bkg_tiles_PARM_5
	lda	*_draw_disabled_sloc0_1_0
	clc
	adc	#0x08
;	../../../include/nes/nes.h: 778: _map_tile_offset = base_tile;
	ldx	#0x01
	stx	__map_tile_offset
;	../../../include/nes/nes.h: 779: set_bkg_tiles(x, y, w, h, tiles);
	inx
	stx	_set_bkg_tiles_PARM_3
	stx	_set_bkg_tiles_PARM_4
	ldx	_draw_disabled_y_10000_114
	jsr	_set_bkg_tiles
;	src/joytest.c: 30: set_bkg_based_tiles(x + 10, y, 2, 2, disabled_buttons[5], 1);
	lda	#>(_disabled_buttons + 0x0014)
	sta	(_set_bkg_tiles_PARM_5 + 1)
	lda	#(_disabled_buttons + 0x0014)
	sta	_set_bkg_tiles_PARM_5
	lda	*_draw_disabled_sloc0_1_0
	clc
	adc	#0x0a
;	../../../include/nes/nes.h: 778: _map_tile_offset = base_tile;
	ldx	#0x01
	stx	__map_tile_offset
;	../../../include/nes/nes.h: 779: set_bkg_tiles(x, y, w, h, tiles);
	inx
	stx	_set_bkg_tiles_PARM_3
	stx	_set_bkg_tiles_PARM_4
	ldx	_draw_disabled_y_10000_114
	jsr	_set_bkg_tiles
;	src/joytest.c: 31: set_bkg_based_tiles(x + 12, y, 2, 2, disabled_buttons[6], 1);
	lda	#>(_disabled_buttons + 0x0018)
	sta	(_set_bkg_tiles_PARM_5 + 1)
	lda	#(_disabled_buttons + 0x0018)
	sta	_set_bkg_tiles_PARM_5
	lda	*_draw_disabled_sloc0_1_0
	clc
	adc	#0x0c
;	../../../include/nes/nes.h: 778: _map_tile_offset = base_tile;
	ldx	#0x01
	stx	__map_tile_offset
;	../../../include/nes/nes.h: 779: set_bkg_tiles(x, y, w, h, tiles);
	inx
	stx	_set_bkg_tiles_PARM_3
	stx	_set_bkg_tiles_PARM_4
	ldx	_draw_disabled_y_10000_114
	jsr	_set_bkg_tiles
;	src/joytest.c: 32: set_bkg_based_tiles(x + 14, y, 2, 2, disabled_buttons[7], 1);
	lda	#>(_disabled_buttons + 0x001c)
	sta	(_set_bkg_tiles_PARM_5 + 1)
	lda	#(_disabled_buttons + 0x001c)
	sta	_set_bkg_tiles_PARM_5
	lda	*_draw_disabled_sloc0_1_0
	clc
	adc	#0x0e
;	../../../include/nes/nes.h: 778: _map_tile_offset = base_tile;
	ldx	#0x01
	stx	__map_tile_offset
;	../../../include/nes/nes.h: 779: set_bkg_tiles(x, y, w, h, tiles);
	inx
	stx	_set_bkg_tiles_PARM_3
	stx	_set_bkg_tiles_PARM_4
	ldx	_draw_disabled_y_10000_114
	jsr	_set_bkg_tiles
;	../../../include/nes/nes.h: 780: _map_tile_offset = 0;
	ldx	#0x00
	stx	__map_tile_offset
;	src/joytest.c: 32: set_bkg_based_tiles(x + 14, y, 2, 2, disabled_buttons[7], 1);
;	src/joytest.c: 33: }
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'reset_object_pos'
;------------------------------------------------------------
;i                         Allocated to registers 
;sloc0                     Allocated with name '_reset_object_pos_sloc0_1_0'
;------------------------------------------------------------
;	src/joytest.c: 35: void reset_object_pos(void) {
;	-----------------------------------------
;	 function reset_object_pos
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_reset_object_pos:
;	src/joytest.c: 36: for (uint8_t i = 0; i < 4; i++) {
	ldx	#0x00
	stx	*_reset_object_pos_sloc0_1_0
00103$:
	lda	*_reset_object_pos_sloc0_1_0
	cmp	#0x04
	bcs	00105$
;	src/joytest.c: 37: set_sprite_tile(i, i);
	lda	*_reset_object_pos_sloc0_1_0
	ldx	*_reset_object_pos_sloc0_1_0
	jsr	_set_sprite_tile
;	src/joytest.c: 39: DEVICE_SPRITE_PX_OFFSET_X + (i << 3) + ((DEVICE_SCREEN_PX_WIDTH - (4 * 8)) >> 1), 
	lda	*_reset_object_pos_sloc0_1_0
	asl	a
	asl	a
	asl	a
	clc
	adc	#0x70
;	src/joytest.c: 41: );
	ldx	#0xa3
	stx	_move_sprite_PARM_3
	tax
	lda	*_reset_object_pos_sloc0_1_0
	jsr	_move_sprite
;	src/joytest.c: 36: for (uint8_t i = 0; i < 4; i++) {
	inc	*_reset_object_pos_sloc0_1_0
	jmp	00103$
00105$:
;	src/joytest.c: 43: }
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;sloc0                     Allocated with name '_main_sloc0_1_0'
;sloc1                     Allocated with name '_main_sloc1_1_0'
;i                         Allocated to registers 
;i                         Allocated to registers 
;i                         Allocated to registers 
;j                         Allocated with name '_main_j_50000_156'
;------------------------------------------------------------
;	src/joytest.c: 51: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/joytest.c: 54: for (uint8_t i = 4; i != 0; i--) vsync();
	lda	#0x04
00135$:
	cmp	#0x00
	beq	00101$
	pha
	jsr	_vsync
	pla
	sec
	sbc	#0x01
	jmp	00135$
00101$:
;	src/joytest.c: 60: joypad_init(4, &joypads);
	lda	#>_joypads
	sta	(_joypad_init_PARM_2 + 1)
	lda	#_joypads
	sta	_joypad_init_PARM_2
	lda	#0x04
	jsr	_joypad_init
;	src/joytest.c: 62: set_sprite_data(0, sizeof(sprite_data) >> 4, sprite_data);
	lda	#>_sprite_data
	sta	(_set_sprite_data_PARM_3 + 1)
	lda	#_sprite_data
	sta	_set_sprite_data_PARM_3
	lda	#0x00
	ldx	#0x04
	jsr	_set_sprite_data
;	src/joytest.c: 63: set_bkg_data(1, sizeof(tiles_data) >> 4, tiles_data);
	lda	#>_tiles_data
	sta	(_set_bkg_data_PARM_3 + 1)
	lda	#_tiles_data
	sta	_set_bkg_data_PARM_3
	lda	#0x01
	ldx	#0x5d
	jsr	_set_bkg_data
;	src/joytest.c: 64: fill_bkg_rect(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, 0);
	ldx	#0x20
	stx	_fill_bkg_rect_PARM_3
	ldx	#0x1e
	stx	_fill_bkg_rect_PARM_4
	ldx	#0x00
	stx	_fill_bkg_rect_PARM_5
	txa
	jsr	_fill_bkg_rect
;	src/joytest.c: 66: if (isSGB) draw_disabled(0, 0); else draw_buttons(joy, 0, 0);
	lda	_isSGB
	beq	00103$
	lda	#0x00
	tax
	jsr	_draw_disabled
	jmp	00150$
00103$:
	ldx	#0x00
	stx	_draw_buttons_PARM_3
	lda	_joy
	jsr	_draw_buttons
;	src/joytest.c: 68: for (uint8_t i = 0; i != 4; i++) {
00150$:
	ldx	#0x00
	stx	*_main_sloc0_1_0
00138$:
	lda	*_main_sloc0_1_0
	cmp	#0x04
	beq	00108$
;	src/joytest.c: 69: if (i <= (joypads.npads - 1)) {
	lda	_joypads
	ldx	#0x00
	sec
	sbc	#0x01
	bcs	00267$
	dex
00267$:
	ldy	*_main_sloc0_1_0
	sty	*_main_sloc1_1_0
	ldy	#0x00
	sty	*(_main_sloc1_1_0 + 1)
	sec
	sbc	*_main_sloc1_1_0
	txa
	sbc	*(_main_sloc1_1_0 + 1)
	bvs	00269$
	bpl	00268$
	bmi	00106$
00269$:
	bpl	00106$
00268$:
;	src/joytest.c: 70: draw_buttons(joypads.joypads[i], 0, 4 + (i << 1)); 
	ldx	#0x00
	lda	*_main_sloc0_1_0
	tax
	ldy	((_joypads + 0x0001)+0+0x0000),x
	lda	*_main_sloc0_1_0
	asl	a
	clc
	adc	#0x04
	sta	_draw_buttons_PARM_3
	tya
	ldx	#0x00
	jsr	_draw_buttons
	jmp	00139$
00106$:
;	src/joytest.c: 72: draw_disabled(0, 4 + (i << 1));
	lda	*_main_sloc0_1_0
	asl	a
	clc
	adc	#0x04
	tax
	lda	#0x00
	jsr	_draw_disabled
00139$:
;	src/joytest.c: 68: for (uint8_t i = 0; i != 4; i++) {
	inc	*_main_sloc0_1_0
	jmp	00138$
00108$:
;	src/joytest.c: 76: reset_object_pos();
	jsr	_reset_object_pos
;	src/joytest.c: 77: SHOW_SPRITES; SHOW_BKG;
	lda	_shadow_PPUMASK
	ora	#0x10
	sta	_shadow_PPUMASK
	lda	_shadow_PPUMASK
	ora	#0x08
	sta	_shadow_PPUMASK
;	src/joytest.c: 79: while(TRUE) {
00132$:
;	src/joytest.c: 81: if (toggle = !toggle) {
	lda	_toggle
	eor	#0x01
	tax
	sta	_toggle
	beq	00129$
;	src/joytest.c: 83: if (!isSGB) {
	lda	_isSGB
	beq	00275$
	jmp	00130$
00275$:
;	src/joytest.c: 84: old_joy = joy, joy = joypad();
	lda	_joy
	sta	_old_joy
	jsr	_joypad
	sta	_joy
;	src/joytest.c: 87: if (joy != old_joy) draw_buttons(joy, 0, 0);
	cmp	_old_joy
	beq	00110$
	ldx	#0x00
	stx	_draw_buttons_PARM_3
	jsr	_draw_buttons
00110$:
;	src/joytest.c: 90: if (joy & J_START) reset_object_pos();
	lda	_joy
	and	#0x10
	bne	00277$
	jmp	00130$
00277$:
	jsr	_reset_object_pos
	jmp	00130$
00129$:
;	src/joytest.c: 93: old_joypads = joypads;
	lda	#>_joypads
	sta	(___memcpy_PARM_2 + 1)
	lda	#_joypads
	sta	___memcpy_PARM_2
	ldx	#0x05
	stx	___memcpy_PARM_3
	ldx	#0x00
	stx	(___memcpy_PARM_3 + 1)
	ldx	#>_old_joypads
	lda	#_old_joypads
	jsr	___memcpy
;	src/joytest.c: 94: joypad_ex(&joypads);
	ldx	#>_joypads
	lda	#_joypads
	jsr	_joypad_ex
;	src/joytest.c: 96: for (uint8_t i = 0; i < joypads.npads; i++) {
	ldx	#0x00
	stx	*_main_sloc1_1_0
00141$:
	lda	_joypads
	cmp	*_main_sloc1_1_0
	beq	00279$
	bcs	00278$
00279$:
	jmp	00130$
00278$:
;	src/joytest.c: 97: uint8_t j = joypads.joypads[i];
	ldx	#0x00
	lda	*_main_sloc1_1_0
	tay
	lda	((_joypads + 0x0001)+0+0x0000),y
	sta	_main_j_50000_156
;	src/joytest.c: 100: if (old_joypads.joypads[i] != j) draw_buttons(j, 0, 4 + (i << 1));
	lda	*_main_sloc1_1_0
	tay
	lda	((_old_joypads + 0x0001)+0+0x0000),y
	cmp	_main_j_50000_156
	beq	00116$
	lda	*_main_sloc1_1_0
	asl	a
	clc
	adc	#0x04
	sta	_draw_buttons_PARM_3
	lda	_main_j_50000_156
	jsr	_draw_buttons
00116$:
;	src/joytest.c: 103: if (j & J_LEFT)  scroll_sprite(i, -1, 0);
	lda	#0x02
	and	_main_j_50000_156
	beq	00118$
	ldx	#0x00
	stx	_scroll_sprite_PARM_3
	lda	*_main_sloc1_1_0
	dex
	jsr	_scroll_sprite
00118$:
;	src/joytest.c: 104: if (j & J_RIGHT) scroll_sprite(i, 1, 0);
	lda	#0x01
	and	_main_j_50000_156
	beq	00120$
	ldx	#0x00
	stx	_scroll_sprite_PARM_3
	lda	*_main_sloc1_1_0
	inx
	jsr	_scroll_sprite
00120$:
;	src/joytest.c: 105: if (j & J_UP)    scroll_sprite(i, 0, -1);
	lda	#0x08
	and	_main_j_50000_156
	beq	00122$
	ldx	#0xff
	stx	_scroll_sprite_PARM_3
	lda	*_main_sloc1_1_0
	inx
	jsr	_scroll_sprite
00122$:
;	src/joytest.c: 106: if (j & J_DOWN)  scroll_sprite(i, 0, 1);
	lda	#0x04
	and	_main_j_50000_156
	beq	00124$
	ldx	#0x01
	stx	_scroll_sprite_PARM_3
	lda	*_main_sloc1_1_0
	dex
	jsr	_scroll_sprite
00124$:
;	src/joytest.c: 109: if (j & J_START) reset_object_pos();
	lda	#0x10
	and	_main_j_50000_156
	beq	00142$
	jsr	_reset_object_pos
00142$:
;	src/joytest.c: 96: for (uint8_t i = 0; i < joypads.npads; i++) {
	inc	*_main_sloc1_1_0
	jmp	00141$
00130$:
;	src/joytest.c: 113: vsync();
	jsr	_vsync
	jmp	00132$
;	src/joytest.c: 115: }
	rts
	.area _CODE
	.area _XINIT
__xinit__toggle:
	.db #0x00	;  0
__xinit__isSGB:
	.db #0x00	;  0
__xinit__old_joy:
	.db #0xff	; 255
__xinit__joy:
	.db #0x00	; 0
	.area _CABS    (ABS)
