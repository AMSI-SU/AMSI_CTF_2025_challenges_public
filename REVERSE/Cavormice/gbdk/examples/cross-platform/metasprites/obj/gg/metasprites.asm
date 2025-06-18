;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module metasprites
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _load_and_duplicate_sprite_tile_data
	.globl _get_tile_offset
	.globl _set_tile
	.globl _hide_sprites_range
	.globl _fill_rect_compat
	.globl _set_tile_2bpp_data
	.globl _joypad
	.globl _vsync
	.globl _old_joyp
	.globl _joyp
	.globl _num_tiles
	.globl _flipped_data
	.globl _rot
	.globl _idx
	.globl _PosF
	.globl _SpdY
	.globl _SpdX
	.globl _PosY
	.globl _PosX
	.globl _green_pal
	.globl _cyan_pal
	.globl _pink_pal
	.globl _gray_pal
	.globl _reverse_bits
	.globl _pattern
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
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_joyp::
	.ds 1
_old_joyp::
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
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/metasprites.c:94: void set_tile(uint8_t tile_idx, uint8_t* data, uint8_t flip_x, uint8_t flip_y)
;	---------------------------------
; Function set_tile
; ---------------------------------
_set_tile::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-7
	add	hl, sp
	ld	sp, hl
	ld	-3 (ix), a
	ld	-5 (ix), e
	ld	-4 (ix), d
;src/metasprites.c:97: for(i = 0; i < TILE_HEIGHT; i++)
	xor	a, a
	ld	-2 (ix), a
	ld	-1 (ix), a
00103$:
;src/metasprites.c:99: size_t y = flip_y ? (TILE_HEIGHT-1-i) : i; 
	ld	a, 5 (ix)
	or	a, a
	jr	Z, 00107$
	ld	a, #0x07
	sub	a, -2 (ix)
	ld	-7 (ix), a
	sbc	a, a
	sub	a, -1 (ix)
	ld	-6 (ix), a
	jr	00108$
00107$:
	ld	a, -2 (ix)
	ld	-7 (ix), a
	ld	-6 (ix), #0x00
00108$:
	pop	de
	push	de
;src/metasprites.c:100: flipped_data[2*i] = flip_x ? reverse_bits[data[2*y]] : data[2*y];
	ld	a, -2 (ix)
	add	a, a
	ld	c, a
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	rlca
	sbc	a, a
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #<(_flipped_data)
	add	a, l
	ld	-7 (ix), a
	ld	a, #>(_flipped_data)
	adc	a, h
	ld	-6 (ix), a
	ex	de, hl
	add	hl, hl
	ex	de, hl
	ld	l, -5 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -4 (ix)
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	b, (hl)
	ld	a, 4 (ix)
	or	a, a
	jr	Z, 00109$
	ld	a, #<(_reverse_bits)
	add	a, b
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #>(_reverse_bits)
	adc	a, #0x00
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	b, (hl)
00109$:
	pop	hl
	push	hl
	ld	(hl), b
;src/metasprites.c:101: flipped_data[2*i+1] = flip_x ? reverse_bits[data[2*y+1]] : data[2*y+1];
	inc	c
	ld	a, c
	rlca
	sbc	a, a
	ld	b, a
	ld	hl, #_flipped_data
	add	hl, bc
	ld	c, l
	ld	b, h
	inc	de
	ld	l, -5 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -4 (ix)
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, (hl)
	ld	a, 4 (ix)
	or	a, a
	jr	Z, 00111$
	ld	hl, #_reverse_bits
	ld	d, #0x00
	add	hl, de
	ld	a, (hl)
	jr	00112$
00111$:
	ld	a, e
00112$:
	ld	(bc), a
;src/metasprites.c:97: for(i = 0; i < TILE_HEIGHT; i++)
	inc	-2 (ix)
	jr	NZ, 00149$
	inc	-1 (ix)
00149$:
	ld	a, -2 (ix)
	sub	a, #0x08
	ld	a, #0x00
	sbc	a, #0x00
	jp	C, 00103$
;src/metasprites.c:103: set_sprite_data(tile_idx, 1, flipped_data);
	ld	bc, #_flipped_data
	ld	e, -3 (ix)
;../../../include/sms/sms.h:636: set_tile_2bpp_data((uint8_t)(start) + 0x100u, ntiles, src, _current_2bpp_palette);
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	inc	a
	ld	d, a
	ld	hl, (__current_2bpp_palette)
	push	hl
	push	bc
	ld	hl, #0x0001
	push	hl
	push	de
	call	_set_tile_2bpp_data
;src/metasprites.c:103: set_sprite_data(tile_idx, 1, flipped_data);
;src/metasprites.c:104: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	jp	(hl)
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
;src/metasprites.c:106: uint8_t get_tile_offset(uint8_t flipx, uint8_t flipy)
;	---------------------------------
; Function get_tile_offset
; ---------------------------------
_get_tile_offset::
	ld	c, a
;src/metasprites.c:111: offset += flipy ? num_tiles : 0;
	ld	a, l
	ld	hl, (_num_tiles)
	or	a, a
	jr	Z, 00103$
	ld	a, l
	jr	00104$
00103$:
	xor	a, a
00104$:
;src/metasprites.c:114: offset <<= 1;
	add	a, a
;src/metasprites.c:115: offset += flipx ? num_tiles : 0;
	inc	c
	dec	c
	jr	Z, 00105$
	ld	c, l
	jr	00106$
00105$:
	ld	bc, #0x0000
00106$:
	add	a, c
;src/metasprites.c:117: return offset;
;src/metasprites.c:118: }
	ret
;src/metasprites.c:123: void load_and_duplicate_sprite_tile_data(void)
;	---------------------------------
; Function load_and_duplicate_sprite_tile_data
; ---------------------------------
_load_and_duplicate_sprite_tile_data::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	dec	sp
;src/metasprites.c:126: num_tiles = sizeof(sprite_tiles) >> 4;
	ld	hl, #0x0030
	ld	(_num_tiles), hl
;src/metasprites.c:127: for(i = 0; i < num_tiles; i++)
	xor	a, a
	ld	-2 (ix), a
	ld	-1 (ix), a
00103$:
	ld	hl, #_num_tiles
	ld	a, -2 (ix)
	sub	a, (hl)
	ld	a, -1 (ix)
	inc	hl
	sbc	a, (hl)
	jp	NC, 00105$
;src/metasprites.c:129: set_tile(i + get_tile_offset(0, 0), sprite_tiles + (i << 4), 0, 0);
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de, #_sprite_tiles
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, -2 (ix)
	ld	-3 (ix), a
	push	hl
	push	de
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	ld	l, a
	call	_get_tile_offset
	pop	de
	pop	hl
	add	a, -3 (ix)
	ld	c, a
	push	hl
	ld	hl, #0x00
	push	hl
	ld	a, c
	call	_set_tile
	pop	hl
;src/metasprites.c:131: set_tile(i + get_tile_offset(1, 0), sprite_tiles + (i << 4), 1, 0);
	ld	e, l
	ld	d, h
	push	hl
	push	de
	ld	l, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #0x01
	call	_get_tile_offset
	pop	de
	pop	hl
	add	a, -3 (ix)
	ld	c, a
	push	hl
	ld	hl, #0x01
	push	hl
	ld	a, c
	call	_set_tile
	pop	hl
;src/metasprites.c:134: set_tile(i + get_tile_offset(0, 1), sprite_tiles + (i << 4), 0, 1);
	ld	e, l
	ld	d, h
	push	hl
	push	de
	ld	l, #0x01
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	call	_get_tile_offset
	pop	de
	pop	hl
	add	a, -3 (ix)
	ld	c, a
	push	hl
	ld	hl, #0x100
	push	hl
	ld	a, c
	call	_set_tile
;	spillPairReg hl
;	spillPairReg hl
	ld	a,#0x01
	ld	l,a
	call	_get_tile_offset
	pop	de
	add	a, -3 (ix)
	ld	c, a
	ld	hl, #0x101
	push	hl
	ld	a, c
	call	_set_tile
;src/metasprites.c:127: for(i = 0; i < num_tiles; i++)
	inc	-2 (ix)
	jp	NZ,00103$
	inc	-1 (ix)
	jp	00103$
00105$:
;src/metasprites.c:140: }
	ld	sp, ix
	pop	ix
	ret
;src/metasprites.c:160: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-9
	add	hl, sp
	ld	sp, hl
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
;src/metasprites.c:177: fill_bkg_rect(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, 0);
	ld	hl, #0x0000
	push	hl
	ld	hl, #0x1214
	push	hl
	ld	hl, #0x00
	push	hl
	call	_fill_rect_compat
;src/metasprites.c:180: set_bkg_data(0, 1, pattern);
;../../../include/sms/sms.h:633: set_tile_2bpp_data(start, ntiles, src, _current_2bpp_palette);
	ld	hl, (__current_2bpp_palette)
	push	hl
	ld	hl, #_pattern
	push	hl
	ld	hl, #0x0001
	push	hl
	ld	l, h
	push	hl
	call	_set_tile_2bpp_data
;src/metasprites.c:183: load_and_duplicate_sprite_tile_data();
	call	_load_and_duplicate_sprite_tile_data
;src/metasprites.c:186: SHOW_BKG; SHOW_SPRITES;
	ld	iy, #__sprites_OFF
	ld	0 (iy), #0x00
;src/metasprites.c:192: SPRITES_8x8;
	ld	a, (_shadow_VDP_R1+0)
	and	a, #0xfd
	ld	(_shadow_VDP_R1+0), a
	di
	ld	a, (_shadow_VDP_R1+0)
	out	(_VDP_CMD), a
	ld	a, #0x81
	out	(_VDP_CMD), a
	ei
;src/metasprites.c:194: DISPLAY_ON;
	ld	a, (_shadow_VDP_R1+0)
	or	a, #0x40
	ld	(_shadow_VDP_R1+0), a
	di
	ld	a, (_shadow_VDP_R1+0)
	out	(_VDP_CMD), a
	ld	a, #0x81
	out	(_VDP_CMD), a
	ei
;src/metasprites.c:197: PosX = (DEVICE_SCREEN_PX_WIDTH / 2) << 4;
	ld	hl, #0x0500
	ld	(_PosX), hl
;src/metasprites.c:198: PosY = (DEVICE_SCREEN_PX_HEIGHT / 2) << 4;
	ld	hl, #0x0480
	ld	(_PosY), hl
;src/metasprites.c:199: SpdX = SpdY = 0;
	ld	hl, #0x0000
	ld	(_SpdY), hl
	ld	(_SpdX), hl
;src/metasprites.c:201: idx = 0; rot = 0;
	xor	a, a
	ld	(#_idx), a
	xor	a, a
	ld	(#_rot), a
;src/metasprites.c:203: while(TRUE) {        
00145$:
;src/metasprites.c:205: KEY_INPUT;
	ld	a, (_joyp+0)
	ld	(_old_joyp+0), a
	call	_joypad
	ld	a, l
	ld	(_joyp+0), a
;src/metasprites.c:207: PosF = 0;
	ld	hl, #_PosF
	ld	(hl), #0x00
;src/metasprites.c:209: if (KEY_DOWN(J_UP)) {
	ld	a, (_joyp+0)
	ld	-2 (ix), a
;src/metasprites.c:210: SpdY -= 2;
	ld	hl, (_SpdY)
;src/metasprites.c:212: PosF |= ACC_Y;
	ld	a, (_PosF+0)
	or	a, #0x02
	ld	-1 (ix), a
;src/metasprites.c:209: if (KEY_DOWN(J_UP)) {
	bit	0, -2 (ix)
	jr	Z, 00108$
;src/metasprites.c:210: SpdY -= 2;
	dec	hl
	dec	hl
	ld	(_SpdY), hl
;src/metasprites.c:211: if (SpdY < -32) SpdY = -32;
	ld	a, (_SpdY+0)
	sub	a, #0xe0
	ld	a, (_SpdY+1)
	rla
	ccf
	rra
	sbc	a, #0x7f
	jr	NC, 00102$
	ld	hl, #0xffe0
	ld	(_SpdY), hl
00102$:
;src/metasprites.c:212: PosF |= ACC_Y;
	ld	a, -1 (ix)
	ld	(_PosF+0), a
	jr	00109$
00108$:
;src/metasprites.c:213: } else if (KEY_DOWN(J_DOWN)) {
	bit	1, -2 (ix)
	jr	Z, 00109$
;src/metasprites.c:214: SpdY += 2;
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	ld	(_SpdY), bc
;src/metasprites.c:215: if (SpdY > 32) SpdY = 32;
	ld	hl, (_SpdY)
	ld	a, #0x20
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	jp	PO, 00322$
	xor	a, #0x80
00322$:
	jp	P, 00104$
	ld	hl, #0x0020
	ld	(_SpdY), hl
00104$:
;src/metasprites.c:216: PosF |= ACC_Y;
	ld	a, -1 (ix)
	ld	(_PosF+0), a
00109$:
;src/metasprites.c:220: SpdX -= 2;
	ld	de, (_SpdX)
;src/metasprites.c:222: PosF |= ACC_X;
	ld	a, (_PosF+0)
	or	a, #0x01
	ld	-1 (ix), a
;src/metasprites.c:219: if (KEY_DOWN(J_LEFT)) {
	bit	2, -2 (ix)
	jr	Z, 00117$
;src/metasprites.c:220: SpdX -= 2;
	dec	de
	dec	de
	ld	(_SpdX), de
;src/metasprites.c:221: if (SpdX < -32) SpdX = -32;
	ld	a, (_SpdX+0)
	sub	a, #0xe0
	ld	a, (_SpdX+1)
	rla
	ccf
	rra
	sbc	a, #0x7f
	jr	NC, 00111$
	ld	hl, #0xffe0
	ld	(_SpdX), hl
00111$:
;src/metasprites.c:222: PosF |= ACC_X;
	ld	a, -1 (ix)
	ld	(_PosF+0), a
	jr	00118$
00117$:
;src/metasprites.c:223: } else if (KEY_DOWN(J_RIGHT)) {
	bit	3, -2 (ix)
	jr	Z, 00118$
;src/metasprites.c:224: SpdX += 2;
	inc	de
	inc	de
	ld	(_SpdX), de
;src/metasprites.c:225: if (SpdX > 32) SpdX = 32;
	ld	hl, (_SpdX)
	ld	a, #0x20
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	jp	PO, 00325$
	xor	a, #0x80
00325$:
	jp	P, 00113$
	ld	hl, #0x0020
	ld	(_SpdX), hl
00113$:
;src/metasprites.c:226: PosF |= ACC_X;
	ld	a, -1 (ix)
	ld	(_PosF+0), a
00118$:
;src/metasprites.c:230: if (KEY_PRESSED(J_B)) {
	ld	a, (_joyp+0)
	ld	hl, #_old_joyp
	xor	a, (hl)
	ld	hl, #_joyp
	and	a, (hl)
	ld	c, a
	bit	4, c
	jr	Z, 00122$
;src/metasprites.c:231: idx++; if (idx >= (sizeof(sprite_metasprites) >> 1)) idx = 0;
	ld	iy, #_idx
	inc	0 (iy)
	ld	a, (_idx+0)
	sub	a, #0x05
	jr	C, 00122$
	ld	0 (iy), #0x00
00122$:
;src/metasprites.c:235: if (KEY_PRESSED(J_A)) {
	bit	5, c
	jr	Z, 00124$
;src/metasprites.c:236: rot++; rot &= 0xF;
	ld	hl, #_rot
	inc	(hl)
	ld	a, (_rot+0)
	and	a, #0x0f
	ld	(_rot+0), a
00124$:
;src/metasprites.c:239: PosX += SpdX, PosY += SpdY; 
	ld	hl, #_SpdX
	push	de
	ld	de, #_PosX
	ld	a, (de)
	add	a, (hl)
	inc	hl
	ld	(de), a
	inc	de
	ld	a, (de)
	adc	a, (hl)
	ld	(de), a
	pop	de
	ld	hl, #_SpdY
	push	de
	ld	de, #_PosY
	ld	a, (de)
	add	a, (hl)
	inc	hl
	ld	(de), a
	inc	de
	ld	a, (de)
	adc	a, (hl)
	ld	(de), a
	pop	de
;src/metasprites.c:251: switch (rot & 0x3) {
	ld	a, (_rot+0)
	and	a, #0x03
	ld	-5 (ix), a
;src/metasprites.c:258: DEVICE_SPRITE_PX_OFFSET_Y + (PosY >> 4));
	ld	a, (_PosY+0)
	ld	-2 (ix), a
	ld	a, (_PosY+1)
	ld	-1 (ix), a
	sra	-1 (ix)
	rr	-2 (ix)
	sra	-1 (ix)
	rr	-2 (ix)
	sra	-1 (ix)
	rr	-2 (ix)
	sra	-1 (ix)
	rr	-2 (ix)
;src/metasprites.c:257: DEVICE_SPRITE_PX_OFFSET_X + (PosX >> 4),
	ld	a, (_PosX+0)
	ld	-4 (ix), a
	ld	a, (_PosX+1)
	ld	-3 (ix), a
	sra	-3 (ix)
	rr	-4 (ix)
	sra	-3 (ix)
	rr	-4 (ix)
	sra	-3 (ix)
	rr	-4 (ix)
	sra	-3 (ix)
	rr	-4 (ix)
;src/metasprites.c:258: DEVICE_SPRITE_PX_OFFSET_Y + (PosY >> 4));
;src/metasprites.c:257: DEVICE_SPRITE_PX_OFFSET_X + (PosX >> 4),
	ld	a, -4 (ix)
	ld	-7 (ix), a
	ld	a, -3 (ix)
	ld	-6 (ix), a
;src/metasprites.c:258: DEVICE_SPRITE_PX_OFFSET_Y + (PosY >> 4));
	ld	a, -2 (ix)
	add	a, #0x17
	ld	-4 (ix), a
	ld	a, -1 (ix)
	adc	a, #0x00
	ld	-3 (ix), a
;src/metasprites.c:257: DEVICE_SPRITE_PX_OFFSET_X + (PosX >> 4),
	ld	a, -7 (ix)
	add	a, #0x30
	ld	-2 (ix), a
	ld	a, -6 (ix)
	adc	a, #0x00
	ld	-1 (ix), a
;src/metasprites.c:258: DEVICE_SPRITE_PX_OFFSET_Y + (PosY >> 4));
;src/metasprites.c:257: DEVICE_SPRITE_PX_OFFSET_X + (PosX >> 4),
;src/metasprites.c:251: switch (rot & 0x3) {
	ld	a, -5 (ix)
	dec	a
	jr	Z, 00125$
	ld	a, -5 (ix)
	sub	a, #0x02
	jr	Z, 00126$
	ld	a, -5 (ix)
	sub	a, #0x03
	jp	Z,00127$
	jp	00128$
;src/metasprites.c:252: case 1:
00125$:
;src/metasprites.c:258: DEVICE_SPRITE_PX_OFFSET_Y + (PosY >> 4));
	ld	c, -4 (ix)
	ld	b, -3 (ix)
;src/metasprites.c:257: DEVICE_SPRITE_PX_OFFSET_X + (PosX >> 4),
	ld	e, -2 (ix)
	ld	d, -1 (ix)
;src/metasprites.c:254: TILE_NUM_START + get_tile_offset(0, 1),
	push	bc
	push	de
	ld	l, #0x01
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	call	_get_tile_offset
	ld	-1 (ix), a
	pop	de
	pop	bc
;src/metasprites.c:253: hiwater += move_metasprite_flipy( sprite_metasprites[idx],
	ld	a, (_idx+0)
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	a, a
	rl	h
	add	a, #<(_sprite_metasprites)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	adc	a, #>(_sprite_metasprites)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
;src/metasprites.c:258: DEVICE_SPRITE_PX_OFFSET_Y + (PosY >> 4));
;../../../include/sms/metasprites.h:149: __current_metasprite = metasprite;
	ld	(___current_metasprite), hl
;../../../include/sms/metasprites.h:150: __current_base_tile = base_tile;
	ld	a, -1 (ix)
	ld	(___current_base_tile+0), a
;../../../include/sms/metasprites.h:151: return __move_metasprite_flipy(base_sprite, x, y - ((__READ_VDP_REG(VDP_R1) & R1_SPR_8X16) ? 16 : 8) );
	ld	a, (_shadow_VDP_R1+0)
	bit	1, a
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	ld	l, #0x10
	jr	NZ, 00156$
	ld	l, #0x08
00156$:
	ld	a, c
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	sub	a, l
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
	push	bc
	xor	a, a
	call	___move_metasprite_flipy
;src/metasprites.c:258: DEVICE_SPRITE_PX_OFFSET_Y + (PosY >> 4));
	ld	-1 (ix), a
;src/metasprites.c:259: break;
	jp	00129$
;src/metasprites.c:260: case 2:
00126$:
;src/metasprites.c:266: DEVICE_SPRITE_PX_OFFSET_Y + (PosY >> 4));
	ld	c, -4 (ix)
	ld	b, -3 (ix)
;src/metasprites.c:265: DEVICE_SPRITE_PX_OFFSET_X + (PosX >> 4),
	ld	e, -2 (ix)
	ld	d, -1 (ix)
;src/metasprites.c:262: TILE_NUM_START + get_tile_offset(1, 1),
	push	bc
	push	de
;	spillPairReg hl
;	spillPairReg hl
	ld	a,#0x01
	ld	l,a
	call	_get_tile_offset
	ld	-1 (ix), a
	pop	de
	pop	bc
;src/metasprites.c:261: hiwater += move_metasprite_flipxy(sprite_metasprites[idx],
	ld	a, (_idx+0)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	ld	a, l
	add	a, #<(_sprite_metasprites)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	adc	a, #>(_sprite_metasprites)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
;src/metasprites.c:266: DEVICE_SPRITE_PX_OFFSET_Y + (PosY >> 4));
;../../../include/sms/metasprites.h:178: __current_metasprite = metasprite;
	ld	(___current_metasprite), hl
;../../../include/sms/metasprites.h:179: __current_base_tile = base_tile;
	ld	a, -1 (ix)
	ld	(___current_base_tile+0), a
;../../../include/sms/metasprites.h:180: return __move_metasprite_flipxy(base_sprite, x - 8, y - ((__READ_VDP_REG(VDP_R1) & R1_SPR_8X16) ? 16 : 8));
	ld	a, (_shadow_VDP_R1+0)
	bit	1, a
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	ld	l, #0x10
	jr	NZ, 00158$
	ld	l, #0x08
00158$:
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	a, c
	sub	a, l
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
	ld	a, e
	add	a, #0xf8
	ld	e, a
	ld	a, d
	adc	a, #0xff
	ld	d, a
	push	bc
	xor	a, a
	call	___move_metasprite_flipxy
;src/metasprites.c:266: DEVICE_SPRITE_PX_OFFSET_Y + (PosY >> 4));
	ld	-1 (ix), a
;src/metasprites.c:267: break;
	jp	00129$
;src/metasprites.c:268: case 3:
00127$:
;src/metasprites.c:274: DEVICE_SPRITE_PX_OFFSET_Y + (PosY >> 4));
	ld	a, -4 (ix)
	ld	-7 (ix), a
	ld	a, -3 (ix)
	ld	-6 (ix), a
;src/metasprites.c:273: DEVICE_SPRITE_PX_OFFSET_X + (PosX >> 4),
	ld	a, -2 (ix)
	ld	-5 (ix), a
	ld	a, -1 (ix)
	ld	-4 (ix), a
;src/metasprites.c:270: TILE_NUM_START + get_tile_offset(1, 0),
	ld	l, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #0x01
	call	_get_tile_offset
	ld	-3 (ix), a
;src/metasprites.c:269: hiwater += move_metasprite_flipx( sprite_metasprites[idx],
	ld	a, (_idx+0)
	ld	-2 (ix), a
	ld	-1 (ix), #0x00
	ld	a, -2 (ix)
	ld	-9 (ix), a
	ld	-8 (ix), #0x00
	sla	-9 (ix)
	rl	-8 (ix)
	ld	a, -9 (ix)
	add	a, #<(_sprite_metasprites)
	ld	-2 (ix), a
	ld	a, -8 (ix)
	adc	a, #>(_sprite_metasprites)
	ld	-1 (ix), a
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	a, (hl)
	ld	-2 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-1 (ix), a
;../../../include/sms/metasprites.h:120: __current_metasprite = metasprite;
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	(___current_metasprite), hl
;../../../include/sms/metasprites.h:121: __current_base_tile = base_tile;
	ld	a, -3 (ix)
	ld	(___current_base_tile+0), a
;../../../include/sms/metasprites.h:122: return __move_metasprite_flipx(base_sprite, x - 8, y);
	ld	a, -5 (ix)
	ld	-2 (ix), a
	ld	a, -4 (ix)
	ld	-1 (ix), a
	ld	a, -2 (ix)
	add	a, #0xf8
	ld	-4 (ix), a
	ld	a, -1 (ix)
	adc	a, #0xff
	ld	-3 (ix), a
	ld	a, -4 (ix)
	ld	-2 (ix), a
	ld	a, -3 (ix)
	ld	-1 (ix), a
	pop	de
	pop	hl
	push	hl
	push	de
	push	hl
	ld	e, -2 (ix)
	ld	d, -1 (ix)
	xor	a, a
	call	___move_metasprite_flipx
	ld	-1 (ix), a
;src/metasprites.c:275: break;
	jr	00129$
;src/metasprites.c:276: default:
00128$:
;src/metasprites.c:282: DEVICE_SPRITE_PX_OFFSET_Y + (PosY >> 4));
	ld	a, -4 (ix)
	ld	-7 (ix), a
	ld	a, -3 (ix)
	ld	-6 (ix), a
;src/metasprites.c:281: DEVICE_SPRITE_PX_OFFSET_X + (PosX >> 4),
	ld	a, -2 (ix)
	ld	-5 (ix), a
	ld	a, -1 (ix)
	ld	-4 (ix), a
;src/metasprites.c:278: TILE_NUM_START + get_tile_offset(0, 0),
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	ld	l, a
	call	_get_tile_offset
	ld	-3 (ix), a
;src/metasprites.c:277: hiwater += move_metasprite_ex(    sprite_metasprites[idx],
	ld	a, (_idx+0)
	ld	-2 (ix), a
	ld	-1 (ix), #0x00
	ld	a, -2 (ix)
	ld	-9 (ix), a
	ld	-8 (ix), #0x00
	sla	-9 (ix)
	rl	-8 (ix)
	ld	a, -9 (ix)
	add	a, #<(_sprite_metasprites)
	ld	-2 (ix), a
	ld	a, -8 (ix)
	adc	a, #>(_sprite_metasprites)
	ld	-1 (ix), a
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	a, (hl)
	ld	-2 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-1 (ix), a
;../../../include/sms/metasprites.h:83: __current_metasprite = metasprite;
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	(___current_metasprite), hl
;../../../include/sms/metasprites.h:84: __current_base_tile = base_tile;
	ld	a, -3 (ix)
	ld	(___current_base_tile+0), a
;../../../include/sms/metasprites.h:85: return __move_metasprite(base_sprite, x, y);
	pop	de
	pop	hl
	push	hl
	push	de
	push	hl
	ld	e, -5 (ix)
	ld	d, -4 (ix)
	xor	a, a
	call	___move_metasprite
	ld	-1 (ix), a
;src/metasprites.c:284: }
00129$:
;src/metasprites.c:287: hide_sprites_range(hiwater, MAX_HARDWARE_SPRITES);        
	ld	l, #0x40
;	spillPairReg hl
;	spillPairReg hl
	ld	a, -1 (ix)
	call	_hide_sprites_range
;src/metasprites.c:290: if (!(PosF & ACC_Y)) {
	ld	a, (_PosF+0)
	ld	c, a
	bit	1, c
	jr	NZ, 00136$
;src/metasprites.c:291: if (SpdY != 0) {
	ld	a, (_SpdY+1)
	ld	iy, #_SpdY
	or	a, 0 (iy)
	jr	Z, 00136$
;src/metasprites.c:292: if (SpdY > 0) SpdY--;
	ld	hl, (_SpdY)
	xor	a, a
	cp	a, l
	sbc	a, h
	jp	PO, 00338$
	xor	a, #0x80
00338$:
	jp	P, 00131$
	ld	hl, (_SpdY)
	dec	hl
	ld	(_SpdY), hl
	jr	00136$
00131$:
;src/metasprites.c:293: else SpdY ++;
	ld	hl, (_SpdY)
	inc	hl
	ld	(_SpdY), hl
00136$:
;src/metasprites.c:298: if (!(PosF & ACC_X)) {
	bit	0, c
	jr	NZ, 00143$
;src/metasprites.c:299: if (SpdX != 0) {
	ld	a, (_SpdX+1)
	ld	iy, #_SpdX
	or	a, 0 (iy)
	jr	Z, 00143$
;src/metasprites.c:300: if (SpdX > 0) SpdX--;
	ld	hl, (_SpdX)
	xor	a, a
	cp	a, l
	sbc	a, h
	jp	PO, 00341$
	xor	a, #0x80
00341$:
	jp	P, 00138$
	ld	hl, (_SpdX)
	dec	hl
	ld	(_SpdX), hl
	jr	00143$
00138$:
;src/metasprites.c:301: else SpdX ++;
	ld	hl, (_SpdX)
	inc	hl
	ld	(_SpdX), hl
00143$:
;src/metasprites.c:307: vsync();
	call	_vsync
;src/metasprites.c:309: }
	jp	00145$
_gray_pal:
	.dw #0x0fff
	.dw #0x0aaa
	.dw #0x0555
	.dw #0x0000
_pink_pal:
	.dw #0x0fff
	.dw #0x0f0f
	.dw #0x0a0a
	.dw #0x0505
_cyan_pal:
	.dw #0x0fff
	.dw #0x0ff5
	.dw #0x0aa0
	.dw #0x0550
_green_pal:
	.dw #0x0fff
	.dw #0x0afa
	.dw #0x00a0
	.dw #0x0050
	.area _CODE
	.area _INITIALIZER
__xinit__joyp:
	.db #0x00	; 0
__xinit__old_joyp:
	.db #0x00	; 0
	.area _CABS (ABS)
