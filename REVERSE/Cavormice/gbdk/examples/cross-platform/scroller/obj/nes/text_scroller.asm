;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module text_scroller
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
	.globl _scroller_text
	.globl _scanline_offsets_tbl
	.globl _main
	.globl _scanline_isr
	.globl _printf
	.globl _font_set
	.globl _font_load
	.globl _font_init
	.globl _fill_bkg_rect
	.globl _get_bkg_xy_addr
	.globl _set_vram_byte
	.globl _display_off
	.globl _display_on
	.globl _vsync
	.globl _add_LCD
	.globl _scroller_next_char
	.globl _scroller_x
	.globl _scanline_offsets
	.globl _limit
	.globl _base
	.globl _scroller_vram_addr
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
_scroller_vram_addr::
	.ds 2
_base::
	.ds 2
_limit::
	.ds 2
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS    (ABS)
;--------------------------------------------------------
; initialized external ram data
;--------------------------------------------------------
	.area _DATA
_scanline_offsets::
	.ds 2
_scroller_x::
	.ds 1
_scroller_next_char::
	.ds 2
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
;Allocation info for local variables in function 'scanline_isr'
;------------------------------------------------------------
;__300000006               Allocated to registers 
;__300000007               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;__300000009               Allocated to registers 
;__300000010               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;__300000012               Allocated to registers 
;__300000013               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;------------------------------------------------------------
;	src/text_scroller.c: 16: void scanline_isr(void) {
;	-----------------------------------------
;	 function scanline_isr
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_scanline_isr:
;	src/text_scroller.c: 18: switch (_lcd_scanline) {
	lda	__lcd_scanline
	beq	00101$
	lda	__lcd_scanline
	cmp	#0x78
	beq	00102$
	lda	__lcd_scanline
	cmp	#0x80
	beq	00103$
	rts
;	src/text_scroller.c: 19: case 0: 
00101$:
;	../../../include/nes/nes.h: 918: bkg_scroll_x = x, bkg_scroll_y = y;
	ldx	#0x00
	stx	_bkg_scroll_x
	stx	_bkg_scroll_y
;	src/text_scroller.c: 21: _lcd_scanline = SCROLL_POS_PIX_START + 1;
	ldx	#0x78
	stx	__lcd_scanline
;	src/text_scroller.c: 22: break;
	rts
;	src/text_scroller.c: 23: case SCROLL_POS_PIX_START + 1:
00102$:
;	src/text_scroller.c: 24: move_bkg(scroller_x, SCROLL_POS_PIX_START + 1);
	lda	_scroller_x
	sta	_bkg_scroll_x
;	../../../include/nes/nes.h: 918: bkg_scroll_x = x, bkg_scroll_y = y;
	ldx	#0x78
	stx	_bkg_scroll_y
;	src/text_scroller.c: 25: _lcd_scanline = SCROLL_POS_PIX_END + 1;
	ldx	#0x80
	stx	__lcd_scanline
;	src/text_scroller.c: 26: break;
	rts
;	src/text_scroller.c: 27: case SCROLL_POS_PIX_END + 1:
00103$:
;	../../../include/nes/nes.h: 918: bkg_scroll_x = x, bkg_scroll_y = y;
	ldx	#0x00
	stx	_bkg_scroll_x
	ldx	#0x80
	stx	_bkg_scroll_y
;	src/text_scroller.c: 29: _lcd_scanline = 0;
	ldx	#0x00
	stx	__lcd_scanline
;	src/text_scroller.c: 31: }
;	src/text_scroller.c: 55: }
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;sloc0                     Allocated with name '_main_sloc0_1_0'
;__300000015               Allocated to registers 
;__300000016               Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers 
;------------------------------------------------------------
;	src/text_scroller.c: 66: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/text_scroller.c: 67: DISPLAY_OFF;
	jsr	_display_off
;	src/text_scroller.c: 69: font_init();
	jsr	_font_init
;	src/text_scroller.c: 70: font_set(font_load(font_ibm));
	ldx	#>_font_ibm
	lda	#_font_ibm
	jsr	_font_load
	jsr	_font_set
;	src/text_scroller.c: 72: fill_bkg_rect(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, '*' - ' ');
	ldx	#0x20
	stx	_fill_bkg_rect_PARM_3
	ldx	#0x1e
	stx	_fill_bkg_rect_PARM_4
	ldx	#0x0a
	stx	_fill_bkg_rect_PARM_5
	lda	#0x00
	tax
	jsr	_fill_bkg_rect
;	src/text_scroller.c: 73: DISPLAY_ON;
	jsr	_display_on
;	src/text_scroller.c: 75: printf(" Scrolling %d chars", sizeof(scroller_text) - 1);
	lda	#0x01
	pha
	lda	#0x68
	pha
	lda	#>___str_0
	pha
	lda	#___str_0
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
;	src/text_scroller.c: 82: }
	php
	sei
;	src/text_scroller.c: 78: add_LCD(scanline_isr);
	ldx	#>(_scanline_isr)
	lda	#(_scanline_isr)
	jsr	_add_LCD
	plp
;	src/text_scroller.c: 89: HIDE_LEFT_COLUMN;    
	lda	_shadow_PPUMASK
	and	#0xf9
	sta	_shadow_PPUMASK
;	src/text_scroller.c: 90: base = (uint8_t *)((uint16_t)get_bkg_xy_addr(0, SCROLL_POS) & (DEVICE_SCREEN_MAP_ENTRY_SIZE==1?0xffe0:0xffc0));
	lda	#0x00
	ldx	#0x0f
	jsr	_get_bkg_xy_addr
	and	#0xe0
	sta	*_main_sloc0_1_0
	stx	*(_main_sloc0_1_0 + 1)
	sta	_base
	stx	(_base + 1)
;	src/text_scroller.c: 91: limit = base + (DEVICE_SCREEN_BUFFER_WIDTH * DEVICE_SCREEN_MAP_ENTRY_SIZE);
	ldx	*(_main_sloc0_1_0 + 1)
	lda	*_main_sloc0_1_0
	clc
	adc	#0x20
	bcc	00145$
	inx
00145$:
	sta	_limit
	stx	(_limit + 1)
;	src/text_scroller.c: 93: scroller_vram_addr = base + ((DEVICE_SCREEN_X_OFFSET + DEVICE_SCREEN_WIDTH) * DEVICE_SCREEN_MAP_ENTRY_SIZE);
	sta	_scroller_vram_addr
	stx	(_scroller_vram_addr + 1)
;	src/text_scroller.c: 94: if (scroller_vram_addr >= limit) scroller_vram_addr = base;
	lda	_scroller_vram_addr
	sec
	sbc	_limit
	lda	(_scroller_vram_addr + 1)
	sbc	(_limit + 1)
	bcc	00102$
	lda	*(_main_sloc0_1_0 + 1)
	sta	(_scroller_vram_addr + 1)
	lda	*_main_sloc0_1_0
	sta	_scroller_vram_addr
00102$:
;	src/text_scroller.c: 96: set_vram_byte(scroller_vram_addr, *scroller_next_char - 0x20);
	lda	_scroller_next_char
	sta	*(DPTR+0)
	lda	(_scroller_next_char + 1)
	sta	*(DPTR+1)
	ldy	#0x00
	lda	[DPTR],y
	sec
	sbc	#0x20
	sta	_set_vram_byte_PARM_2
	ldx	(_scroller_vram_addr + 1)
	lda	_scroller_vram_addr
	jsr	_set_vram_byte
;	src/text_scroller.c: 98: while (1) {
00110$:
;	src/text_scroller.c: 99: scroller_x++;
	inc	_scroller_x
;	src/text_scroller.c: 100: if ((scroller_x & 0x07) == 0) {
	lda	_scroller_x
	and	#0x07
	bne	00108$
;	src/text_scroller.c: 102: scroller_next_char++;
	inc	_scroller_next_char
	bne	00148$
	inc	(_scroller_next_char + 1)
00148$:
;	src/text_scroller.c: 103: if (*scroller_next_char == 0) scroller_next_char = scroller_text;
	lda	_scroller_next_char
	sta	*(DPTR+0)
	lda	(_scroller_next_char + 1)
	sta	*(DPTR+1)
	ldy	#0x00
	lda	[DPTR],y
	bne	00104$
	lda	#>_scroller_text
	sta	(_scroller_next_char + 1)
	lda	#_scroller_text
	sta	_scroller_next_char
00104$:
;	src/text_scroller.c: 106: scroller_vram_addr += DEVICE_SCREEN_MAP_ENTRY_SIZE;
	inc	_scroller_vram_addr
	bne	00151$
	inc	(_scroller_vram_addr + 1)
00151$:
;	src/text_scroller.c: 107: if (scroller_vram_addr >= limit) scroller_vram_addr = base;
	lda	_scroller_vram_addr
	sec
	sbc	_limit
	lda	(_scroller_vram_addr + 1)
	sbc	(_limit + 1)
	bcc	00106$
	lda	(_base + 1)
	sta	(_scroller_vram_addr + 1)
	lda	_base
	sta	_scroller_vram_addr
00106$:
;	src/text_scroller.c: 110: set_vram_byte(scroller_vram_addr, *scroller_next_char - 0x20);
	lda	_scroller_next_char
	sta	*(DPTR+0)
	lda	(_scroller_next_char + 1)
	sta	*(DPTR+1)
	ldy	#0x00
	lda	[DPTR],y
	sec
	sbc	#0x20
	sta	_set_vram_byte_PARM_2
	ldx	(_scroller_vram_addr + 1)
	lda	_scroller_vram_addr
	jsr	_set_vram_byte
00108$:
;	../../../include/nes/nes.h: 918: bkg_scroll_x = x, bkg_scroll_y = y;
	ldx	#0x00
	stx	_bkg_scroll_x
	stx	_bkg_scroll_y
;	src/text_scroller.c: 115: _lcd_scanline = 0;
	stx	__lcd_scanline
;	src/text_scroller.c: 117: vsync();        
	jsr	_vsync
	jmp	00110$
;	src/text_scroller.c: 119: }
	rts
	.area _CODE
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
	.area _XINIT
__xinit__scanline_offsets:
	.dw _scanline_offsets_tbl
__xinit__scroller_x:
	.db #0x00	; 0
__xinit__scroller_next_char:
	.dw _scroller_text
	.area _CABS    (ABS)
