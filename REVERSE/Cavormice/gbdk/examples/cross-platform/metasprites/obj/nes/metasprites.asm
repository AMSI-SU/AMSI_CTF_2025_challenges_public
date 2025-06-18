;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module metasprites
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
	.globl _green_pal
	.globl _cyan_pal
	.globl _pink_pal
	.globl _gray_pal
	.globl _reverse_bits
	.globl _pattern
	.globl _main
	.globl _load_and_duplicate_sprite_tile_data
	.globl _get_tile_offset
	.globl _set_tile
	.globl _hide_sprites_range
	.globl _fill_bkg_rect
	.globl _set_sprite_data
	.globl _set_bkg_data
	.globl _display_off
	.globl _display_on
	.globl _vsync
	.globl _joypad
	.globl _set_sprite_palette
	.globl _old_joyp
	.globl _joyp
	.globl _set_tile_PARM_4
	.globl _set_tile_PARM_3
	.globl _set_tile_PARM_2
	.globl _num_tiles
	.globl _flipped_data
	.globl _rot
	.globl _idx
	.globl _PosF
	.globl _SpdY
	.globl _SpdX
	.globl _PosY
	.globl _PosX
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
_load_and_duplicate_sprite_tile_data_sloc0_1_0:
	.ds 2
_load_and_duplicate_sprite_tile_data_sloc1_1_0:
	.ds 1
_main_sloc0_1_0:
	.ds 1
_main_sloc1_1_0:
	.ds 2
_main_sloc2_1_0:
	.ds 2
;--------------------------------------------------------
; overlayable items in ram
;--------------------------------------------------------
	.area	OSEG    (PAG, OVR)
_set_tile_sloc0_1_0:
	.ds 2
_set_tile_sloc1_1_0:
	.ds 2
_set_tile_sloc2_1_0:
	.ds 2
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
_PosX::
	.ds 2
_PosY::
	.ds 2
_SpdX::
	.ds 2
_SpdY::
	.ds 2
_PosF::
	.ds 1
_idx::
	.ds 1
_rot::
	.ds 1
_flipped_data::
	.ds 16
_num_tiles::
	.ds 2
_set_tile_PARM_2:
	.ds 2
_set_tile_PARM_3:
	.ds 1
_set_tile_PARM_4:
	.ds 1
_set_tile_tile_idx_10000_115:
	.ds 1
_set_tile_y_30000_118:
	.ds 2
_main___400010009_40001_141:
	.ds 1
_main_x_50001_142:
	.ds 2
_main_y_50001_142:
	.ds 2
_main___400010017_40001_144:
	.ds 1
_main___400010019_40001_144:
	.ds 2
_main_y_50001_145:
	.ds 2
_main___400010025_40001_147:
	.ds 1
_main___400010027_40001_147:
	.ds 2
_main___400010028_40001_147:
	.ds 2
_main___400010033_40001_150:
	.ds 1
_main___400010035_40001_150:
	.ds 2
_main___400010036_40001_150:
	.ds 2
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS    (ABS)
;--------------------------------------------------------
; initialized external ram data
;--------------------------------------------------------
	.area _DATA
_joyp::
	.ds 1
_old_joyp::
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
;Allocation info for local variables in function 'set_tile'
;------------------------------------------------------------
;data                      Allocated with name '_set_tile_PARM_2'
;flip_x                    Allocated with name '_set_tile_PARM_3'
;flip_y                    Allocated with name '_set_tile_PARM_4'
;tile_idx                  Allocated with name '_set_tile_tile_idx_10000_115'
;i                         Allocated to registers 
;y                         Allocated with name '_set_tile_y_30000_118'
;sloc0                     Allocated with name '_set_tile_sloc0_1_0'
;sloc1                     Allocated with name '_set_tile_sloc1_1_0'
;sloc2                     Allocated with name '_set_tile_sloc2_1_0'
;------------------------------------------------------------
;	src/metasprites.c: 94: void set_tile(uint8_t tile_idx, uint8_t* data, uint8_t flip_x, uint8_t flip_y)
;	-----------------------------------------
;	 function set_tile
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_set_tile:
	sta	_set_tile_tile_idx_10000_115
;	src/metasprites.c: 97: for(i = 0; i < TILE_HEIGHT; i++)
	ldx	#0x00
	stx	*_set_tile_sloc0_1_0
	stx	*(_set_tile_sloc0_1_0 + 1)
00102$:
;	src/metasprites.c: 99: size_t y = flip_y ? (TILE_HEIGHT-1-i) : i; 
	lda	_set_tile_PARM_4
	beq	00106$
	lda	#0x07
	sec
	sbc	*_set_tile_sloc0_1_0
	pha
	lda	#0x00
	sbc	*(_set_tile_sloc0_1_0 + 1)
	tax
	pla
	jmp	00107$
00106$:
	ldx	*(_set_tile_sloc0_1_0 + 1)
	lda	*_set_tile_sloc0_1_0
00107$:
	sta	_set_tile_y_30000_118
	stx	(_set_tile_y_30000_118 + 1)
;	src/metasprites.c: 100: flipped_data[2*i] = flip_x ? reverse_bits[data[2*y]] : data[2*y];
	lda	*_set_tile_sloc0_1_0
	asl	a
	ldx	#0x00
	cmp	#0x00
	bpl	00145$
	dex
00145$:
	sta	*_set_tile_sloc1_1_0
	stx	*(_set_tile_sloc1_1_0 + 1)
	lda	_set_tile_PARM_3
	beq	00108$
	ldx	(_set_tile_y_30000_118 + 1)
	lda	_set_tile_y_30000_118
	stx	*(REGTEMP+0)
	asl	a
	rol	*(REGTEMP+0)
	ldx	*(REGTEMP+0)
	clc
	adc	_set_tile_PARM_2
	sta	*_set_tile_sloc2_1_0
	txa
	adc	(_set_tile_PARM_2 + 1)
	sta	*(_set_tile_sloc2_1_0 + 1)
	ldy	#0x00
	lda	[*_set_tile_sloc2_1_0],y
	ldx	#0x00
	tay
	lda	(_reverse_bits+0+0x0000),y
	jmp	00109$
00108$:
	ldx	(_set_tile_y_30000_118 + 1)
	lda	_set_tile_y_30000_118
	stx	*(REGTEMP+0)
	asl	a
	rol	*(REGTEMP+0)
	ldx	*(REGTEMP+0)
	clc
	adc	_set_tile_PARM_2
	sta	*_set_tile_sloc2_1_0
	txa
	adc	(_set_tile_PARM_2 + 1)
	sta	*(_set_tile_sloc2_1_0 + 1)
	ldy	#0x00
	lda	[*_set_tile_sloc2_1_0],y
00109$:
	sta	*(REGTEMP+0)
	clc
	lda	*_set_tile_sloc1_1_0
	adc	#<(_flipped_data+0)
	sta	*(DPTR+0)
	lda	*(_set_tile_sloc1_1_0 + 1)
	adc	#>(_flipped_data+0)
	sta	*(DPTR+1)
	lda	*(REGTEMP+0)
	ldy	#0x00
	sta	[DPTR],y
;	src/metasprites.c: 101: flipped_data[2*i+1] = flip_x ? reverse_bits[data[2*y+1]] : data[2*y+1];
	lda	*_set_tile_sloc0_1_0
	asl	a
	tay
	iny
	ldx	#0x00
	tya
	bpl	00148$
	dex
00148$:
	sta	*_set_tile_sloc2_1_0
	stx	*(_set_tile_sloc2_1_0 + 1)
	lda	_set_tile_PARM_3
	beq	00110$
	ldx	(_set_tile_y_30000_118 + 1)
	lda	_set_tile_y_30000_118
	stx	*(REGTEMP+0)
	asl	a
	rol	*(REGTEMP+0)
	ldx	*(REGTEMP+0)
	clc
	adc	#0x01
	bcc	00151$
	inx
00151$:
	clc
	adc	_set_tile_PARM_2
	sta	*_set_tile_sloc1_1_0
	txa
	adc	(_set_tile_PARM_2 + 1)
	sta	*(_set_tile_sloc1_1_0 + 1)
	ldy	#0x00
	lda	[*_set_tile_sloc1_1_0],y
	ldx	#0x00
	tay
	lda	(_reverse_bits+0+0x0000),y
	jmp	00111$
00110$:
	ldx	(_set_tile_y_30000_118 + 1)
	lda	_set_tile_y_30000_118
	stx	*(REGTEMP+0)
	asl	a
	rol	*(REGTEMP+0)
	ldx	*(REGTEMP+0)
	clc
	adc	#0x01
	bcc	00152$
	inx
00152$:
	clc
	adc	_set_tile_PARM_2
	sta	*_set_tile_sloc1_1_0
	txa
	adc	(_set_tile_PARM_2 + 1)
	sta	*(_set_tile_sloc1_1_0 + 1)
	ldy	#0x00
	lda	[*_set_tile_sloc1_1_0],y
00111$:
	sta	*(REGTEMP+0)
	clc
	lda	*_set_tile_sloc2_1_0
	adc	#<(_flipped_data+0)
	sta	*(DPTR+0)
	lda	*(_set_tile_sloc2_1_0 + 1)
	adc	#>(_flipped_data+0)
	sta	*(DPTR+1)
	lda	*(REGTEMP+0)
	ldy	#0x00
	sta	[DPTR],y
;	src/metasprites.c: 97: for(i = 0; i < TILE_HEIGHT; i++)
	inc	*_set_tile_sloc0_1_0
	bne	00153$
	inc	*(_set_tile_sloc0_1_0 + 1)
00153$:
	lda	*_set_tile_sloc0_1_0
	sec
	sbc	#0x08
	lda	*(_set_tile_sloc0_1_0 + 1)
	sbc	#0x00
	bcs	00154$
	jmp	00102$
00154$:
;	src/metasprites.c: 103: set_sprite_data(tile_idx, 1, flipped_data);
	lda	#>_flipped_data
	sta	(_set_sprite_data_PARM_3 + 1)
	lda	#_flipped_data
	sta	_set_sprite_data_PARM_3
	lda	_set_tile_tile_idx_10000_115
	ldx	#0x01
;	src/metasprites.c: 104: }
	jmp	_set_sprite_data
;------------------------------------------------------------
;Allocation info for local variables in function 'get_tile_offset'
;------------------------------------------------------------
;flipy                     Allocated to registers 
;flipx                     Allocated to registers 
;offset                    Allocated to registers 
;------------------------------------------------------------
;	src/metasprites.c: 106: uint8_t get_tile_offset(uint8_t flipx, uint8_t flipy)
;	-----------------------------------------
;	 function get_tile_offset
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_get_tile_offset:
;	src/metasprites.c: 117: return offset;
	lda	#0x00
;	src/metasprites.c: 118: }
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'load_and_duplicate_sprite_tile_data'
;------------------------------------------------------------
;sloc0                     Allocated with name '_load_and_duplicate_sprite_tile_data_sloc0_1_0'
;sloc1                     Allocated with name '_load_and_duplicate_sprite_tile_data_sloc1_1_0'
;i                         Allocated to registers 
;------------------------------------------------------------
;	src/metasprites.c: 123: void load_and_duplicate_sprite_tile_data(void)
;	-----------------------------------------
;	 function load_and_duplicate_sprite_tile_data
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_load_and_duplicate_sprite_tile_data:
;	src/metasprites.c: 126: num_tiles = sizeof(sprite_tiles) >> 4;
	ldx	#0x30
	stx	_num_tiles
	ldx	#0x00
	stx	(_num_tiles + 1)
;	src/metasprites.c: 127: for(i = 0; i < num_tiles; i++)
	stx	*_load_and_duplicate_sprite_tile_data_sloc0_1_0
	stx	*(_load_and_duplicate_sprite_tile_data_sloc0_1_0 + 1)
00103$:
	lda	*_load_and_duplicate_sprite_tile_data_sloc0_1_0
	sec
	sbc	_num_tiles
	lda	*(_load_and_duplicate_sprite_tile_data_sloc0_1_0 + 1)
	sbc	(_num_tiles + 1)
	bcs	00105$
;	src/metasprites.c: 129: set_tile(i + get_tile_offset(0, 0), sprite_tiles + (i << 4), 0, 0);
	lda	*_load_and_duplicate_sprite_tile_data_sloc0_1_0
	sta	*_load_and_duplicate_sprite_tile_data_sloc1_1_0
	lda	#0x00
	tax
	jsr	_get_tile_offset
	clc
	adc	*_load_and_duplicate_sprite_tile_data_sloc1_1_0
	tay
	ldx	*(_load_and_duplicate_sprite_tile_data_sloc0_1_0 + 1)
	lda	*_load_and_duplicate_sprite_tile_data_sloc0_1_0
	stx	*(REGTEMP+0)
	asl	a
	rol	*(REGTEMP+0)
	asl	a
	rol	*(REGTEMP+0)
	asl	a
	rol	*(REGTEMP+0)
	asl	a
	rol	*(REGTEMP+0)
	ldx	*(REGTEMP+0)
	clc
	adc	#_sprite_tiles
	pha
	txa
	adc	#>_sprite_tiles
	tax
	pla
	sta	_set_tile_PARM_2
	stx	(_set_tile_PARM_2 + 1)
	ldx	#0x00
	stx	_set_tile_PARM_3
	stx	_set_tile_PARM_4
	tya
	jsr	_set_tile
;	src/metasprites.c: 127: for(i = 0; i < num_tiles; i++)
	inc	*_load_and_duplicate_sprite_tile_data_sloc0_1_0
	bne	00103$
	inc	*(_load_and_duplicate_sprite_tile_data_sloc0_1_0 + 1)
	jmp	00103$
00105$:
;	src/metasprites.c: 140: }
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;sloc0                     Allocated with name '_main_sloc0_1_0'
;sloc1                     Allocated with name '_main_sloc1_1_0'
;sloc2                     Allocated with name '_main_sloc2_1_0'
;hiwater                   Allocated to registers a 
;subpal                    Allocated to registers y 
;__400010030               Allocated to registers 
;__400010022               Allocated to registers 
;__400010014               Allocated to registers a 
;__400010006               Allocated to registers a 
;__400010007               Allocated to registers 
;__400010008               Allocated to registers 
;__400010009               Allocated with name '_main___400010009_40001_141'
;__400010010               Allocated to registers 
;__400010011               Allocated to registers 
;__400010012               Allocated to registers 
;metasprite                Allocated to registers a x 
;base_tile                 Allocated to registers 
;base_prop                 Allocated to registers 
;base_sprite               Allocated to registers 
;x                         Allocated with name '_main_x_50001_142'
;y                         Allocated with name '_main_y_50001_142'
;__400010015               Allocated to registers 
;__400010016               Allocated to registers 
;__400010017               Allocated with name '_main___400010017_40001_144'
;__400010018               Allocated to registers 
;__400010019               Allocated with name '_main___400010019_40001_144'
;__400010020               Allocated to registers 
;metasprite                Allocated to registers a x 
;base_tile                 Allocated to registers 
;base_prop                 Allocated to registers 
;base_sprite               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated with name '_main_y_50001_145'
;__400010023               Allocated to registers 
;__400010024               Allocated to registers 
;__400010025               Allocated with name '_main___400010025_40001_147'
;__400010026               Allocated to registers 
;__400010027               Allocated with name '_main___400010027_40001_147'
;__400010028               Allocated with name '_main___400010028_40001_147'
;metasprite                Allocated to registers a x 
;base_tile                 Allocated to registers 
;base_prop                 Allocated to registers 
;base_sprite               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;__400010031               Allocated to registers 
;__400010032               Allocated to registers 
;__400010033               Allocated with name '_main___400010033_40001_150'
;__400010034               Allocated to registers 
;__400010035               Allocated with name '_main___400010035_40001_150'
;__400010036               Allocated with name '_main___400010036_40001_150'
;metasprite                Allocated to registers a x 
;base_tile                 Allocated to registers 
;base_prop                 Allocated to registers 
;base_sprite               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;------------------------------------------------------------
;	src/metasprites.c: 160: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/metasprites.c: 161: DISPLAY_OFF;
	jsr	_display_off
;	src/metasprites.c: 170: set_sprite_palette(0, 1, gray_pal);
	lda	#>_gray_pal
	sta	(_set_sprite_palette_PARM_3 + 1)
	lda	#_gray_pal
	sta	_set_sprite_palette_PARM_3
	lda	#0x00
	ldx	#0x01
	jsr	_set_sprite_palette
;	src/metasprites.c: 171: set_sprite_palette(1, 1, pink_pal);
	lda	#>_pink_pal
	sta	(_set_sprite_palette_PARM_3 + 1)
	lda	#_pink_pal
	sta	_set_sprite_palette_PARM_3
	lda	#0x01
	tax
	jsr	_set_sprite_palette
;	src/metasprites.c: 172: set_sprite_palette(2, 1, cyan_pal);
	lda	#>_cyan_pal
	sta	(_set_sprite_palette_PARM_3 + 1)
	lda	#_cyan_pal
	sta	_set_sprite_palette_PARM_3
	lda	#0x02
	ldx	#0x01
	jsr	_set_sprite_palette
;	src/metasprites.c: 173: set_sprite_palette(3, 1, green_pal);
	lda	#>_green_pal
	sta	(_set_sprite_palette_PARM_3 + 1)
	lda	#_green_pal
	sta	_set_sprite_palette_PARM_3
	lda	#0x03
	ldx	#0x01
	jsr	_set_sprite_palette
;	src/metasprites.c: 177: fill_bkg_rect(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, 0);
	ldx	#0x20
	stx	_fill_bkg_rect_PARM_3
	ldx	#0x1e
	stx	_fill_bkg_rect_PARM_4
	ldx	#0x00
	stx	_fill_bkg_rect_PARM_5
	txa
	jsr	_fill_bkg_rect
;	src/metasprites.c: 180: set_bkg_data(0, 1, pattern);
	lda	#>_pattern
	sta	(_set_bkg_data_PARM_3 + 1)
	lda	#_pattern
	sta	_set_bkg_data_PARM_3
	lda	#0x00
	ldx	#0x01
	jsr	_set_bkg_data
;	src/metasprites.c: 183: load_and_duplicate_sprite_tile_data();
	jsr	_load_and_duplicate_sprite_tile_data
;	src/metasprites.c: 186: SHOW_BKG; SHOW_SPRITES;
	lda	_shadow_PPUMASK
	ora	#0x08
	sta	_shadow_PPUMASK
	lda	_shadow_PPUMASK
	ora	#0x10
	sta	_shadow_PPUMASK
;	src/metasprites.c: 192: SPRITES_8x8;
	lda	_shadow_PPUCTRL
	and	#0xdf
	sta	_shadow_PPUCTRL
;	src/metasprites.c: 194: DISPLAY_ON;
	jsr	_display_on
;	src/metasprites.c: 197: PosX = (DEVICE_SCREEN_PX_WIDTH / 2) << 4;
	ldx	#0x00
	stx	_PosX
	ldx	#0x08
	stx	(_PosX + 1)
;	src/metasprites.c: 198: PosY = (DEVICE_SCREEN_PX_HEIGHT / 2) << 4;
	ldx	#0x80
	stx	_PosY
	ldx	#0x07
	stx	(_PosY + 1)
;	src/metasprites.c: 199: SpdX = SpdY = 0;
	ldx	#0x00
	stx	_SpdY
	stx	(_SpdY + 1)
	stx	_SpdX
	stx	(_SpdX + 1)
;	src/metasprites.c: 201: idx = 0; rot = 0;
	stx	_idx
	stx	_rot
;	src/metasprites.c: 203: while(TRUE) {        
00145$:
;	src/metasprites.c: 205: KEY_INPUT;
	lda	_joyp
	sta	_old_joyp
	jsr	_joypad
	sta	_joyp
;	src/metasprites.c: 207: PosF = 0;
	ldx	#0x00
	stx	_PosF
;	src/metasprites.c: 209: if (KEY_DOWN(J_UP)) {
	ldx	#0x08
	stx	*(REGTEMP+0)
	bit	*(REGTEMP+0)
	beq	00108$
;	src/metasprites.c: 210: SpdY -= 2;
	ldx	(_SpdY + 1)
	lda	_SpdY
	sec
	sbc	#0x02
	bcs	00319$
	dex
00319$:
	sta	_SpdY
	stx	(_SpdY + 1)
;	src/metasprites.c: 211: if (SpdY < -32) SpdY = -32;
	lda	_SpdY
	sec
	sbc	#0xe0
	lda	(_SpdY + 1)
	sbc	#0xff
	bvc	00321$
	bpl	00320$
	bmi	00102$
00321$:
	bpl	00102$
00320$:
	ldx	#0xe0
	stx	_SpdY
	ldx	#0xff
	stx	(_SpdY + 1)
00102$:
;	src/metasprites.c: 212: PosF |= ACC_Y;
	lda	_PosF
	ora	#0x02
	sta	_PosF
	jmp	00109$
00108$:
;	src/metasprites.c: 213: } else if (KEY_DOWN(J_DOWN)) {
	and	#0x04
	beq	00109$
;	src/metasprites.c: 214: SpdY += 2;
	ldx	(_SpdY + 1)
	lda	_SpdY
	clc
	adc	#0x02
	bcc	00324$
	inx
00324$:
;	src/metasprites.c: 215: if (SpdY > 32) SpdY = 32;
	sta	_SpdY
	stx	(_SpdY + 1)
	sta	*(REGTEMP+0)
	lda	#0x20
	sec
	sbc	*(REGTEMP+0)
	lda	#0x00
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	bvc	00326$
	bpl	00325$
	bmi	00104$
00326$:
	bpl	00104$
00325$:
	ldx	#0x20
	stx	_SpdY
	ldx	#0x00
	stx	(_SpdY + 1)
00104$:
;	src/metasprites.c: 216: PosF |= ACC_Y;
	lda	_PosF
	ora	#0x02
	sta	_PosF
00109$:
;	src/metasprites.c: 219: if (KEY_DOWN(J_LEFT)) {
	lda	_joyp
	ldx	#0x02
	stx	*(REGTEMP+0)
	bit	*(REGTEMP+0)
	beq	00117$
;	src/metasprites.c: 220: SpdX -= 2;
	ldx	(_SpdX + 1)
	lda	_SpdX
	sec
	sbc	#0x02
	bcs	00329$
	dex
00329$:
	sta	_SpdX
	stx	(_SpdX + 1)
;	src/metasprites.c: 221: if (SpdX < -32) SpdX = -32;
	lda	_SpdX
	sec
	sbc	#0xe0
	lda	(_SpdX + 1)
	sbc	#0xff
	bvc	00331$
	bpl	00330$
	bmi	00111$
00331$:
	bpl	00111$
00330$:
	ldx	#0xe0
	stx	_SpdX
	ldx	#0xff
	stx	(_SpdX + 1)
00111$:
;	src/metasprites.c: 222: PosF |= ACC_X;
	lda	_PosF
	ora	#0x01
	sta	_PosF
	jmp	00118$
00117$:
;	src/metasprites.c: 223: } else if (KEY_DOWN(J_RIGHT)) {
	and	#0x01
	beq	00118$
;	src/metasprites.c: 224: SpdX += 2;
	ldx	(_SpdX + 1)
	lda	_SpdX
	clc
	adc	#0x02
	bcc	00334$
	inx
00334$:
;	src/metasprites.c: 225: if (SpdX > 32) SpdX = 32;
	sta	_SpdX
	stx	(_SpdX + 1)
	sta	*(REGTEMP+0)
	lda	#0x20
	sec
	sbc	*(REGTEMP+0)
	lda	#0x00
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	bvc	00336$
	bpl	00335$
	bmi	00113$
00336$:
	bpl	00113$
00335$:
	ldx	#0x20
	stx	_SpdX
	ldx	#0x00
	stx	(_SpdX + 1)
00113$:
;	src/metasprites.c: 226: PosF |= ACC_X;
	lda	_PosF
	ora	#0x01
	sta	_PosF
00118$:
;	src/metasprites.c: 230: if (KEY_PRESSED(J_B)) {
	lda	_joyp
	eor	_old_joyp
	and	_joyp
	and	#0x40
	beq	00122$
;	src/metasprites.c: 231: idx++; if (idx >= (sizeof(sprite_metasprites) >> 1)) idx = 0;
	inc	_idx
	lda	_idx
	cmp	#0x05
	bcc	00122$
	ldx	#0x00
	stx	_idx
00122$:
;	src/metasprites.c: 235: if (KEY_PRESSED(J_A)) {
	lda	_joyp
	eor	_old_joyp
	and	_joyp
	and	#0x80
	beq	00124$
;	src/metasprites.c: 236: rot++; rot &= 0xF;
	inc	_rot
	lda	_rot
	and	#0x0f
	sta	_rot
00124$:
;	src/metasprites.c: 239: PosX += SpdX, PosY += SpdY; 
	lda	_PosX
	clc
	adc	_SpdX
	sta	_PosX
	lda	(_PosX + 1)
	adc	(_SpdX + 1)
	sta	(_PosX + 1)
	lda	_PosY
	clc
	adc	_SpdY
	sta	_PosY
	lda	(_PosY + 1)
	adc	(_SpdY + 1)
	sta	(_PosY + 1)
;	src/metasprites.c: 241: uint8_t hiwater = SPR_NUM_START;
	ldx	#0x00
	stx	*_main_sloc0_1_0
;	src/metasprites.c: 250: uint8_t subpal = rot >> 2;
	lda	_rot
	lsr	a
	lsr	a
	tay
;	src/metasprites.c: 251: switch (rot & 0x3) {
	lda	_rot
	and	#0x03
	cmp	#0x01
	beq	00125$
	cmp	#0x02
	bne	00342$
	jmp	00126$
00342$:
	cmp	#0x03
	bne	00343$
	jmp	00127$
00343$:
	jmp	00128$
;	src/metasprites.c: 252: case 1:
00125$:
;	src/metasprites.c: 258: DEVICE_SPRITE_PX_OFFSET_Y + (PosY >> 4));
	ldx	(_PosY + 1)
	lda	_PosY
	stx	*(REGTEMP+0)
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	clc
	adc	#0xff
	pha
	txa
	adc	#0xff
	tax
	pla
	sta	_main_y_50001_142
	stx	(_main_y_50001_142 + 1)
;	src/metasprites.c: 257: DEVICE_SPRITE_PX_OFFSET_X + (PosX >> 4),
	ldx	(_PosX + 1)
	lda	_PosX
	stx	*(REGTEMP+0)
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	sta	_main_x_50001_142
	stx	(_main_x_50001_142 + 1)
	sty	_main___400010009_40001_141
;	src/metasprites.c: 254: TILE_NUM_START + get_tile_offset(0, 1),
	lda	#0x00
	ldx	#0x01
	jsr	_get_tile_offset
	sta	___current_base_tile
;	src/metasprites.c: 253: hiwater += move_metasprite_flipy( sprite_metasprites[idx],
	ldx	#0x00
	lda	_idx
	stx	*(REGTEMP+0)
	asl	a
	rol	*(REGTEMP+0)
	ldx	*(REGTEMP+0)
	clc
	adc	#<(_sprite_metasprites+0)
	sta	*(DPTR+0)
	txa
	adc	#>(_sprite_metasprites+0)
	sta	*(DPTR+1)
	ldy	#0x01
	lda	[DPTR],y
	tax
	dey
	lda	[DPTR],y
;	../../../include/nes/metasprites.h: 170: __current_metasprite = metasprite;
	sta	___current_metasprite
	stx	(___current_metasprite + 1)
;	../../../include/nes/metasprites.h: 172: __current_base_prop = base_prop;
	lda	_main___400010009_40001_141
	sta	___current_base_prop
;	../../../include/nes/metasprites.h: 173: return __move_metasprite_flipy(base_sprite, x, y - ((shadow_PPUCTRL & PPUCTRL_SPR_8X16) ? 16 : 8) );
	lda	_shadow_PPUCTRL
	and	#0x20
	beq	00153$
	ldx	#0x10
	stx	*_main_sloc1_1_0
	sty	*(_main_sloc1_1_0 + 1)
	jmp	00154$
00153$:
	ldx	#0x08
	stx	*_main_sloc1_1_0
	ldx	#0x00
	stx	*(_main_sloc1_1_0 + 1)
00154$:
	ldx	(_main_y_50001_142 + 1)
	lda	_main_y_50001_142
	sec
	sbc	*_main_sloc1_1_0
	pha
	txa
	sbc	*(_main_sloc1_1_0 + 1)
	tax
	pla
	sta	___move_metasprite_flipy_PARM_3
	stx	(___move_metasprite_flipy_PARM_3 + 1)
	lda	(_main_x_50001_142 + 1)
	sta	(___move_metasprite_flipy_PARM_2 + 1)
	lda	_main_x_50001_142
	sta	___move_metasprite_flipy_PARM_2
	lda	#0x00
	jsr	___move_metasprite_flipy
;	src/metasprites.c: 258: DEVICE_SPRITE_PX_OFFSET_Y + (PosY >> 4));
	clc
	adc	*_main_sloc0_1_0
;	src/metasprites.c: 259: break;
	jmp	00129$
;	src/metasprites.c: 260: case 2:
00126$:
;	src/metasprites.c: 266: DEVICE_SPRITE_PX_OFFSET_Y + (PosY >> 4));
	ldx	(_PosY + 1)
	lda	_PosY
	stx	*(REGTEMP+0)
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	clc
	adc	#0xff
	pha
	txa
	adc	#0xff
	tax
	pla
	sta	_main_y_50001_145
	stx	(_main_y_50001_145 + 1)
;	src/metasprites.c: 265: DEVICE_SPRITE_PX_OFFSET_X + (PosX >> 4),
	ldx	(_PosX + 1)
	lda	_PosX
	stx	*(REGTEMP+0)
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	sta	_main___400010019_40001_144
	stx	(_main___400010019_40001_144 + 1)
	sty	_main___400010017_40001_144
;	src/metasprites.c: 262: TILE_NUM_START + get_tile_offset(1, 1),
	lda	#0x01
	tax
	jsr	_get_tile_offset
	sta	___current_base_tile
;	src/metasprites.c: 261: hiwater += move_metasprite_flipxy(sprite_metasprites[idx],
	ldx	#0x00
	lda	_idx
	stx	*(REGTEMP+0)
	asl	a
	rol	*(REGTEMP+0)
	ldx	*(REGTEMP+0)
	clc
	adc	#<(_sprite_metasprites+0)
	sta	*(DPTR+0)
	txa
	adc	#>(_sprite_metasprites+0)
	sta	*(DPTR+1)
	ldy	#0x01
	lda	[DPTR],y
	tax
	dey
	lda	[DPTR],y
;	../../../include/nes/metasprites.h: 209: __current_metasprite = metasprite;
	sta	___current_metasprite
	stx	(___current_metasprite + 1)
;	../../../include/nes/metasprites.h: 211: __current_base_prop = base_prop;
	lda	_main___400010017_40001_144
	sta	___current_base_prop
;	../../../include/nes/metasprites.h: 212: return __move_metasprite_flipxy(base_sprite, x - 8, y - ((shadow_PPUCTRL & PPUCTRL_SPR_8X16) ? 16 : 8));
	ldx	(_main___400010019_40001_144 + 1)
	lda	_main___400010019_40001_144
	sec
	sbc	#0x08
	bcs	00345$
	dex
00345$:
	sta	*_main_sloc1_1_0
	stx	*(_main_sloc1_1_0 + 1)
	lda	_shadow_PPUCTRL
	and	#0x20
	beq	00155$
	ldx	#0x10
	stx	*_main_sloc2_1_0
	sty	*(_main_sloc2_1_0 + 1)
	jmp	00156$
00155$:
	ldx	#0x08
	stx	*_main_sloc2_1_0
	ldx	#0x00
	stx	*(_main_sloc2_1_0 + 1)
00156$:
	ldx	(_main_y_50001_145 + 1)
	lda	_main_y_50001_145
	sec
	sbc	*_main_sloc2_1_0
	pha
	txa
	sbc	*(_main_sloc2_1_0 + 1)
	tax
	pla
	sta	___move_metasprite_flipxy_PARM_3
	stx	(___move_metasprite_flipxy_PARM_3 + 1)
	lda	*(_main_sloc1_1_0 + 1)
	sta	(___move_metasprite_flipxy_PARM_2 + 1)
	lda	*_main_sloc1_1_0
	sta	___move_metasprite_flipxy_PARM_2
	lda	#0x00
	jsr	___move_metasprite_flipxy
;	src/metasprites.c: 266: DEVICE_SPRITE_PX_OFFSET_Y + (PosY >> 4));
	clc
	adc	*_main_sloc0_1_0
;	src/metasprites.c: 267: break;
	jmp	00129$
;	src/metasprites.c: 268: case 3:
00127$:
;	src/metasprites.c: 274: DEVICE_SPRITE_PX_OFFSET_Y + (PosY >> 4));
	ldx	(_PosY + 1)
	lda	_PosY
	stx	*(REGTEMP+0)
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	clc
	adc	#0xff
	pha
	txa
	adc	#0xff
	tax
	pla
	sta	_main___400010028_40001_147
	stx	(_main___400010028_40001_147 + 1)
;	src/metasprites.c: 273: DEVICE_SPRITE_PX_OFFSET_X + (PosX >> 4),
	ldx	(_PosX + 1)
	lda	_PosX
	stx	*(REGTEMP+0)
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	sta	_main___400010027_40001_147
	stx	(_main___400010027_40001_147 + 1)
	sty	_main___400010025_40001_147
;	src/metasprites.c: 270: TILE_NUM_START + get_tile_offset(1, 0),
	lda	#0x01
	ldx	#0x00
	jsr	_get_tile_offset
	sta	___current_base_tile
;	src/metasprites.c: 269: hiwater += move_metasprite_flipx( sprite_metasprites[idx],
	ldx	#0x00
	lda	_idx
	stx	*(REGTEMP+0)
	asl	a
	rol	*(REGTEMP+0)
	ldx	*(REGTEMP+0)
	clc
	adc	#<(_sprite_metasprites+0)
	sta	*(DPTR+0)
	txa
	adc	#>(_sprite_metasprites+0)
	sta	*(DPTR+1)
	ldy	#0x01
	lda	[DPTR],y
	tax
	dey
	lda	[DPTR],y
;	../../../include/nes/metasprites.h: 130: __current_metasprite = metasprite;
	sta	___current_metasprite
	stx	(___current_metasprite + 1)
;	../../../include/nes/metasprites.h: 132: __current_base_prop = base_prop;
	lda	_main___400010025_40001_147
	sta	___current_base_prop
;	../../../include/nes/metasprites.h: 133: return __move_metasprite_flipx(base_sprite, x - 8, y);
	ldx	(_main___400010027_40001_147 + 1)
	lda	_main___400010027_40001_147
	sec
	sbc	#0x08
	bcs	00347$
	dex
00347$:
	sta	___move_metasprite_flipx_PARM_2
	stx	(___move_metasprite_flipx_PARM_2 + 1)
	lda	(_main___400010028_40001_147 + 1)
	sta	(___move_metasprite_flipx_PARM_3 + 1)
	lda	_main___400010028_40001_147
	sta	___move_metasprite_flipx_PARM_3
	tya
	jsr	___move_metasprite_flipx
;	src/metasprites.c: 275: break;
	jmp	00129$
;	src/metasprites.c: 276: default:
00128$:
;	src/metasprites.c: 282: DEVICE_SPRITE_PX_OFFSET_Y + (PosY >> 4));
	ldx	(_PosY + 1)
	lda	_PosY
	stx	*(REGTEMP+0)
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	clc
	adc	#0xff
	pha
	txa
	adc	#0xff
	tax
	pla
	sta	_main___400010036_40001_150
	stx	(_main___400010036_40001_150 + 1)
;	src/metasprites.c: 281: DEVICE_SPRITE_PX_OFFSET_X + (PosX >> 4),
	ldx	(_PosX + 1)
	lda	_PosX
	stx	*(REGTEMP+0)
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	cpx	#0x80
	ror	*(REGTEMP+0)
	ror	a
	ldx	*(REGTEMP+0)
	sta	_main___400010035_40001_150
	stx	(_main___400010035_40001_150 + 1)
	sty	_main___400010033_40001_150
;	src/metasprites.c: 278: TILE_NUM_START + get_tile_offset(0, 0),
	lda	#0x00
	tax
	jsr	_get_tile_offset
	sta	___current_base_tile
;	src/metasprites.c: 277: hiwater += move_metasprite_ex(    sprite_metasprites[idx],
	ldx	#0x00
	lda	_idx
	stx	*(REGTEMP+0)
	asl	a
	rol	*(REGTEMP+0)
	ldx	*(REGTEMP+0)
	clc
	adc	#<(_sprite_metasprites+0)
	sta	*(DPTR+0)
	txa
	adc	#>(_sprite_metasprites+0)
	sta	*(DPTR+1)
	ldy	#0x01
	lda	[DPTR],y
	tax
	dey
	lda	[DPTR],y
;	../../../include/nes/metasprites.h: 91: __current_metasprite = metasprite;
	sta	___current_metasprite
	stx	(___current_metasprite + 1)
;	../../../include/nes/metasprites.h: 93: __current_base_prop = base_prop;
	lda	_main___400010033_40001_150
	sta	___current_base_prop
;	../../../include/nes/metasprites.h: 94: return __move_metasprite(base_sprite, x, y);
	lda	(_main___400010035_40001_150 + 1)
	sta	(___move_metasprite_PARM_2 + 1)
	lda	_main___400010035_40001_150
	sta	___move_metasprite_PARM_2
	lda	(_main___400010036_40001_150 + 1)
	sta	(___move_metasprite_PARM_3 + 1)
	lda	_main___400010036_40001_150
	sta	___move_metasprite_PARM_3
	tya
	jsr	___move_metasprite
;	src/metasprites.c: 284: }
00129$:
;	src/metasprites.c: 287: hide_sprites_range(hiwater, MAX_HARDWARE_SPRITES);        
	ldx	#0x40
	jsr	_hide_sprites_range
;	src/metasprites.c: 290: if (!(PosF & ACC_Y)) {
	lda	_PosF
	and	#0x02
	bne	00136$
;	src/metasprites.c: 291: if (SpdY != 0) {
	lda	(_SpdY + 1)
	ora	_SpdY
	beq	00136$
;	src/metasprites.c: 292: if (SpdY > 0) SpdY--;
	ldx	(_SpdY + 1)
	lda	_SpdY
	sta	*(REGTEMP+0)
	lda	#0x00
	sec
	sbc	*(REGTEMP+0)
	lda	#0x00
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	bvc	00352$
	bpl	00351$
	bmi	00131$
00352$:
	bpl	00131$
00351$:
	sec
	lda	_SpdY
	sbc	#0x01
	sta	_SpdY
	bcs	00136$
	dec	(_SpdY + 1)
	jmp	00136$
00131$:
;	src/metasprites.c: 293: else SpdY ++;
	inc	_SpdY
	bne	00355$
	inc	(_SpdY + 1)
00355$:
00136$:
;	src/metasprites.c: 298: if (!(PosF & ACC_X)) {
	lda	_PosF
	and	#0x01
	bne	00143$
;	src/metasprites.c: 299: if (SpdX != 0) {
	lda	(_SpdX + 1)
	ora	_SpdX
	beq	00143$
;	src/metasprites.c: 300: if (SpdX > 0) SpdX--;
	ldx	(_SpdX + 1)
	lda	_SpdX
	sta	*(REGTEMP+0)
	lda	#0x00
	sec
	sbc	*(REGTEMP+0)
	lda	#0x00
	stx	*(REGTEMP+0)
	sbc	*(REGTEMP+0)
	bvc	00360$
	bpl	00359$
	bmi	00138$
00360$:
	bpl	00138$
00359$:
	sec
	lda	_SpdX
	sbc	#0x01
	sta	_SpdX
	bcs	00143$
	dec	(_SpdX + 1)
	jmp	00143$
00138$:
;	src/metasprites.c: 301: else SpdX ++;
	inc	_SpdX
	bne	00363$
	inc	(_SpdX + 1)
00363$:
00143$:
;	src/metasprites.c: 307: vsync();
	jsr	_vsync
	jmp	00145$
;	src/metasprites.c: 309: }
	rts
	.area _CODE
_pattern:
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
_reverse_bits:
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x20	; 32
	.db #0xa0	; 160
	.db #0x60	; 96
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0x90	; 144
	.db #0x50	; 80	'P'
	.db #0xd0	; 208
	.db #0x30	; 48	'0'
	.db #0xb0	; 176
	.db #0x70	; 112	'p'
	.db #0xf0	; 240
	.db #0x08	; 8
	.db #0x88	; 136
	.db #0x48	; 72	'H'
	.db #0xc8	; 200
	.db #0x28	; 40
	.db #0xa8	; 168
	.db #0x68	; 104	'h'
	.db #0xe8	; 232
	.db #0x18	; 24
	.db #0x98	; 152
	.db #0x58	; 88	'X'
	.db #0xd8	; 216
	.db #0x38	; 56	'8'
	.db #0xb8	; 184
	.db #0x78	; 120	'x'
	.db #0xf8	; 248
	.db #0x04	; 4
	.db #0x84	; 132
	.db #0x44	; 68	'D'
	.db #0xc4	; 196
	.db #0x24	; 36
	.db #0xa4	; 164
	.db #0x64	; 100	'd'
	.db #0xe4	; 228
	.db #0x14	; 20
	.db #0x94	; 148
	.db #0x54	; 84	'T'
	.db #0xd4	; 212
	.db #0x34	; 52	'4'
	.db #0xb4	; 180
	.db #0x74	; 116	't'
	.db #0xf4	; 244
	.db #0x0c	; 12
	.db #0x8c	; 140
	.db #0x4c	; 76	'L'
	.db #0xcc	; 204
	.db #0x2c	; 44
	.db #0xac	; 172
	.db #0x6c	; 108	'l'
	.db #0xec	; 236
	.db #0x1c	; 28
	.db #0x9c	; 156
	.db #0x5c	; 92
	.db #0xdc	; 220
	.db #0x3c	; 60
	.db #0xbc	; 188
	.db #0x7c	; 124
	.db #0xfc	; 252
	.db #0x02	; 2
	.db #0x82	; 130
	.db #0x42	; 66	'B'
	.db #0xc2	; 194
	.db #0x22	; 34
	.db #0xa2	; 162
	.db #0x62	; 98	'b'
	.db #0xe2	; 226
	.db #0x12	; 18
	.db #0x92	; 146
	.db #0x52	; 82	'R'
	.db #0xd2	; 210
	.db #0x32	; 50	'2'
	.db #0xb2	; 178
	.db #0x72	; 114	'r'
	.db #0xf2	; 242
	.db #0x0a	; 10
	.db #0x8a	; 138
	.db #0x4a	; 74	'J'
	.db #0xca	; 202
	.db #0x2a	; 42
	.db #0xaa	; 170
	.db #0x6a	; 106	'j'
	.db #0xea	; 234
	.db #0x1a	; 26
	.db #0x9a	; 154
	.db #0x5a	; 90	'Z'
	.db #0xda	; 218
	.db #0x3a	; 58
	.db #0xba	; 186
	.db #0x7a	; 122	'z'
	.db #0xfa	; 250
	.db #0x06	; 6
	.db #0x86	; 134
	.db #0x46	; 70	'F'
	.db #0xc6	; 198
	.db #0x26	; 38
	.db #0xa6	; 166
	.db #0x66	; 102	'f'
	.db #0xe6	; 230
	.db #0x16	; 22
	.db #0x96	; 150
	.db #0x56	; 86	'V'
	.db #0xd6	; 214
	.db #0x36	; 54	'6'
	.db #0xb6	; 182
	.db #0x76	; 118	'v'
	.db #0xf6	; 246
	.db #0x0e	; 14
	.db #0x8e	; 142
	.db #0x4e	; 78	'N'
	.db #0xce	; 206
	.db #0x2e	; 46
	.db #0xae	; 174
	.db #0x6e	; 110	'n'
	.db #0xee	; 238
	.db #0x1e	; 30
	.db #0x9e	; 158
	.db #0x5e	; 94
	.db #0xde	; 222
	.db #0x3e	; 62
	.db #0xbe	; 190
	.db #0x7e	; 126
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0x81	; 129
	.db #0x41	; 65	'A'
	.db #0xc1	; 193
	.db #0x21	; 33
	.db #0xa1	; 161
	.db #0x61	; 97	'a'
	.db #0xe1	; 225
	.db #0x11	; 17
	.db #0x91	; 145
	.db #0x51	; 81	'Q'
	.db #0xd1	; 209
	.db #0x31	; 49	'1'
	.db #0xb1	; 177
	.db #0x71	; 113	'q'
	.db #0xf1	; 241
	.db #0x09	; 9
	.db #0x89	; 137
	.db #0x49	; 73	'I'
	.db #0xc9	; 201
	.db #0x29	; 41
	.db #0xa9	; 169
	.db #0x69	; 105	'i'
	.db #0xe9	; 233
	.db #0x19	; 25
	.db #0x99	; 153
	.db #0x59	; 89	'Y'
	.db #0xd9	; 217
	.db #0x39	; 57	'9'
	.db #0xb9	; 185
	.db #0x79	; 121	'y'
	.db #0xf9	; 249
	.db #0x05	; 5
	.db #0x85	; 133
	.db #0x45	; 69	'E'
	.db #0xc5	; 197
	.db #0x25	; 37
	.db #0xa5	; 165
	.db #0x65	; 101	'e'
	.db #0xe5	; 229
	.db #0x15	; 21
	.db #0x95	; 149
	.db #0x55	; 85	'U'
	.db #0xd5	; 213
	.db #0x35	; 53	'5'
	.db #0xb5	; 181
	.db #0x75	; 117	'u'
	.db #0xf5	; 245
	.db #0x0d	; 13
	.db #0x8d	; 141
	.db #0x4d	; 77	'M'
	.db #0xcd	; 205
	.db #0x2d	; 45
	.db #0xad	; 173
	.db #0x6d	; 109	'm'
	.db #0xed	; 237
	.db #0x1d	; 29
	.db #0x9d	; 157
	.db #0x5d	; 93
	.db #0xdd	; 221
	.db #0x3d	; 61
	.db #0xbd	; 189
	.db #0x7d	; 125
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0x83	; 131
	.db #0x43	; 67	'C'
	.db #0xc3	; 195
	.db #0x23	; 35
	.db #0xa3	; 163
	.db #0x63	; 99	'c'
	.db #0xe3	; 227
	.db #0x13	; 19
	.db #0x93	; 147
	.db #0x53	; 83	'S'
	.db #0xd3	; 211
	.db #0x33	; 51	'3'
	.db #0xb3	; 179
	.db #0x73	; 115	's'
	.db #0xf3	; 243
	.db #0x0b	; 11
	.db #0x8b	; 139
	.db #0x4b	; 75	'K'
	.db #0xcb	; 203
	.db #0x2b	; 43
	.db #0xab	; 171
	.db #0x6b	; 107	'k'
	.db #0xeb	; 235
	.db #0x1b	; 27
	.db #0x9b	; 155
	.db #0x5b	; 91
	.db #0xdb	; 219
	.db #0x3b	; 59
	.db #0xbb	; 187
	.db #0x7b	; 123
	.db #0xfb	; 251
	.db #0x07	; 7
	.db #0x87	; 135
	.db #0x47	; 71	'G'
	.db #0xc7	; 199
	.db #0x27	; 39
	.db #0xa7	; 167
	.db #0x67	; 103	'g'
	.db #0xe7	; 231
	.db #0x17	; 23
	.db #0x97	; 151
	.db #0x57	; 87	'W'
	.db #0xd7	; 215
	.db #0x37	; 55	'7'
	.db #0xb7	; 183
	.db #0x77	; 119	'w'
	.db #0xf7	; 247
	.db #0x0f	; 15
	.db #0x8f	; 143
	.db #0x4f	; 79	'O'
	.db #0xcf	; 207
	.db #0x2f	; 47
	.db #0xaf	; 175
	.db #0x6f	; 111	'o'
	.db #0xef	; 239
	.db #0x1f	; 31
	.db #0x9f	; 159
	.db #0x5f	; 95
	.db #0xdf	; 223
	.db #0x3f	; 63
	.db #0xbf	; 191
	.db #0x7f	; 127
	.db #0xff	; 255
_gray_pal:
	.db #0x20	; 32
	.db #0x3d	; 61
	.db #0x00	; 0
	.db #0x1d	; 29
_pink_pal:
	.db #0x20	; 32
	.db #0x24	; 36
	.db #0x14	; 20
	.db #0x04	; 4
_cyan_pal:
	.db #0x20	; 32
	.db #0x3c	; 60
	.db #0x2c	; 44
	.db #0x1c	; 28
_green_pal:
	.db #0x20	; 32
	.db #0x3a	; 58
	.db #0x2a	; 42
	.db #0x19	; 25
	.area _XINIT
__xinit__joyp:
	.db #0x00	; 0
__xinit__old_joyp:
	.db #0x00	; 0
	.area _CABS    (ABS)
