;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module text_scroller
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _scanline_isr
	.globl _printf
	.globl _font_set
	.globl _font_load
	.globl _font_init
	.globl _get_bkg_xy_addr
	.globl _set_vram_byte
	.globl _fill_rect_compat
	.globl _vsync
	.globl _add_LCD
	.globl _set_interrupts
	.globl _scroller_next_char
	.globl _scroller_x
	.globl _scanline_offsets
	.globl _limit
	.globl _base
	.globl _scroller_vram_addr
	.globl _scroller_text
	.globl _scanline_offsets_tbl
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
_scroller_vram_addr::
	.ds 2
_base::
	.ds 2
_limit::
	.ds 2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_scanline_offsets::
	.ds 2
_scroller_x::
	.ds 1
_scroller_next_char::
	.ds 2
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
;src/text_scroller.c:16: void scanline_isr(void) {
;	---------------------------------
; Function scanline_isr
; ---------------------------------
_scanline_isr::
;src/text_scroller.c:47: if (VCOUNTER == (SCROLL_POS_PIX_START - 8)) {
	in	a, (_VCOUNTER)
	sub	a, #0x87
	jr	NZ, 00108$
;src/text_scroller.c:48: while (VCOUNTER != SCROLL_POS_PIX_START);
00101$:
	in	a, (_VCOUNTER)
	sub	a, #0x8f
	jr	NZ, 00101$
;src/text_scroller.c:49: VDP_CMD = -scroller_x; VDP_CMD = VDP_RSCX;
	ld	hl, #_scroller_x
	xor	a, a
	sub	a, (hl)
	out	(_VDP_CMD), a
	ld	a, #0x88
	out	(_VDP_CMD), a
;src/text_scroller.c:50: while (VCOUNTER != SCROLL_POS_PIX_START + 8);
00104$:
	in	a, (_VCOUNTER)
	sub	a, #0x97
	ret	Z
	jr	00104$
00108$:
;src/text_scroller.c:52: VDP_CMD = 0; VDP_CMD = VDP_RSCX;
	xor	a, a
	out	(_VDP_CMD), a
	ld	a, #0x88
	out	(_VDP_CMD), a
;src/text_scroller.c:55: }
	ret
_scanline_offsets_tbl:
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x00	; 0
;src/text_scroller.c:66: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
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
;src/text_scroller.c:69: font_init();
	call	_font_init
;src/text_scroller.c:70: font_set(font_load(font_ibm));
	ld	hl, #_font_ibm
	push	hl
	call	_font_load
	ex	(sp),hl
	call	_font_set
;src/text_scroller.c:72: fill_bkg_rect(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, '*' - ' ');
	ld	hl, #0x000a
	ex	(sp),hl
	ld	hl, #0x1214
	push	hl
	ld	hl, #0x00
	push	hl
	call	_fill_rect_compat
;src/text_scroller.c:73: DISPLAY_ON;
	ld	a, (_shadow_VDP_R1+0)
	or	a, #0x40
	ld	(_shadow_VDP_R1+0), a
	di
	ld	a, (_shadow_VDP_R1+0)
	out	(_VDP_CMD), a
	ld	a, #0x81
	out	(_VDP_CMD), a
	ei
;src/text_scroller.c:75: printf(" Scrolling %d chars", sizeof(scroller_text) - 1);
	ld	hl, #0x0168
	push	hl
	ld	hl, #___str_0
	push	hl
	call	_printf
	pop	af
	pop	af
;src/text_scroller.c:82: }
	ld	a,i
	di
	push	af
;src/text_scroller.c:78: add_LCD(scanline_isr);
	ld	hl, #_scanline_isr
	call	_add_LCD
	pop	af
	jp	PO, 00151$
	ei
00151$:
;src/text_scroller.c:84: __WRITE_VDP_REG(VDP_R10, 0x07);
	ld	iy, #_shadow_VDP_R10
	ld	0 (iy), #0x07
	di
	ld	a, #0x07
	out	(_VDP_CMD), a
	ld	a, #0x8a
	out	(_VDP_CMD), a
	ei
;src/text_scroller.c:87: set_interrupts(VBL_IFLAG | LCD_IFLAG);
	ld	l, #0x03
;	spillPairReg hl
;	spillPairReg hl
	call	_set_interrupts
;src/text_scroller.c:89: HIDE_LEFT_COLUMN;    
	ld	a, (_shadow_VDP_R0+0)
	or	a, #0x20
	ld	(_shadow_VDP_R0+0), a
	di
	ld	a, (_shadow_VDP_R0+0)
	out	(_VDP_CMD), a
	ld	a, #0x80
	out	(_VDP_CMD), a
	ei
;src/text_scroller.c:90: base = (uint8_t *)((uint16_t)get_bkg_xy_addr(0, SCROLL_POS) & (DEVICE_SCREEN_MAP_ENTRY_SIZE==1?0xffe0:0xffc0));
	ld	hl, #0xf00
	push	hl
	call	_get_bkg_xy_addr
	ld	a, l
	and	a, #0xc0
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	(_base), hl
;src/text_scroller.c:91: limit = base + (DEVICE_SCREEN_BUFFER_WIDTH * DEVICE_SCREEN_MAP_ENTRY_SIZE);
	ld	hl, #_limit
	ld	a, (_base+0)
	add	a, #0x40
	ld	(hl), a
	inc	hl
	ld	a, (_base+1)
	adc	a, #0x00
	ld	(hl), a
;src/text_scroller.c:93: scroller_vram_addr = base + ((DEVICE_SCREEN_X_OFFSET + DEVICE_SCREEN_WIDTH) * DEVICE_SCREEN_MAP_ENTRY_SIZE);
	ld	hl, #_scroller_vram_addr
	ld	a, (_base+0)
	add	a, #0x34
	ld	(hl), a
	inc	hl
	ld	a, (_base+1)
	adc	a, #0x00
	ld	(hl), a
;src/text_scroller.c:94: if (scroller_vram_addr >= limit) scroller_vram_addr = base;
	ld	hl, #_limit
	ld	a, (_scroller_vram_addr+0)
	sub	a, (hl)
	inc	hl
	ld	a, (_scroller_vram_addr+1)
	sbc	a, (hl)
	jr	C, 00102$
	ld	hl, (_base)
	ld	(_scroller_vram_addr), hl
00102$:
;src/text_scroller.c:96: set_vram_byte(scroller_vram_addr, *scroller_next_char - 0x20);
	ld	hl, (_scroller_next_char)
	ld	a, (hl)
	add	a, #0xe0
	push	af
	inc	sp
	ld	hl, (_scroller_vram_addr)
	push	hl
	call	_set_vram_byte
;src/text_scroller.c:98: while (1) {
00110$:
;src/text_scroller.c:99: scroller_x++;
	ld	hl, #_scroller_x
	inc	(hl)
;src/text_scroller.c:100: if ((scroller_x & 0x07) == 0) {
	ld	a, (_scroller_x+0)
	and	a, #0x07
	jr	NZ, 00108$
;src/text_scroller.c:102: scroller_next_char++;
	ld	hl, (_scroller_next_char)
	inc	hl
	ld	(_scroller_next_char), hl
;src/text_scroller.c:103: if (*scroller_next_char == 0) scroller_next_char = scroller_text;
	ld	hl, (_scroller_next_char)
	ld	a, (hl)
	or	a, a
	jr	NZ, 00104$
	ld	iy, #_scroller_next_char
	ld	0 (iy), #<(_scroller_text)
	ld	1 (iy), #>(_scroller_text)
00104$:
;src/text_scroller.c:106: scroller_vram_addr += DEVICE_SCREEN_MAP_ENTRY_SIZE;
	ld	hl, (_scroller_vram_addr)
	inc	hl
	inc	hl
	ld	(_scroller_vram_addr), hl
;src/text_scroller.c:107: if (scroller_vram_addr >= limit) scroller_vram_addr = base;
	ld	hl, #_limit
	ld	a, (_scroller_vram_addr+0)
	sub	a, (hl)
	inc	hl
	ld	a, (_scroller_vram_addr+1)
	sbc	a, (hl)
	jr	C, 00106$
	ld	hl, (_base)
	ld	(_scroller_vram_addr), hl
00106$:
;src/text_scroller.c:110: set_vram_byte(scroller_vram_addr, *scroller_next_char - 0x20);
	ld	hl, (_scroller_next_char)
	ld	a, (hl)
	add	a, #0xe0
	push	af
	inc	sp
	ld	hl, (_scroller_vram_addr)
	push	hl
	call	_set_vram_byte
00108$:
;src/text_scroller.c:117: vsync();        
	call	_vsync
;src/text_scroller.c:119: }
	jr	00110$
_scroller_text:
	.ascii "This is a text scroller demo for GBDK-2020. You can use idea"
	.ascii "s, that are shown in this demo, to make different parallax e"
	.ascii "ffects, scrolling of tilemaps which are larger than 32x32 ti"
	.ascii "les and TEXT SCROLLERS, of course! Need to write something e"
	.ascii "lse to make this text longer than 256 characters. The quick "
	.ascii "red fox jumps over the lazy brown dog. 0123456789.          "
	.db 0x00
___str_0:
	.ascii " Scrolling %d chars"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
__xinit__scanline_offsets:
	.dw _scanline_offsets_tbl
__xinit__scroller_x:
	.db #0x00	; 0
__xinit__scroller_next_char:
	.dw _scroller_text
	.area _CABS (ABS)
