;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module fonts
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
	.globl _font_color
	.globl _font_set
	.globl _font_load
	.globl _font_init
	.globl _get_mode
	.globl _mode
	.globl _printf
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
_main_ibm_font_10000_104:
	.ds 2
_main_italic_font_10000_104:
	.ds 2
_main_min_font_10000_104:
	.ds 2
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
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;sloc0                     Allocated with name '_main_sloc0_1_0'
;ibm_font                  Allocated with name '_main_ibm_font_10000_104'
;italic_font               Allocated with name '_main_italic_font_10000_104'
;min_font                  Allocated with name '_main_min_font_10000_104'
;i                         Allocated to registers 
;------------------------------------------------------------
;	src/fonts.c: 17: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/fonts.c: 28: font_init();
	jsr	_font_init
;	src/fonts.c: 31: ibm_font = font_load(font_ibm);  /* 96 tiles */
	ldx	#>_font_ibm
	lda	#_font_ibm
	jsr	_font_load
	sta	_main_ibm_font_10000_104
	stx	(_main_ibm_font_10000_104 + 1)
;	src/fonts.c: 32: italic_font = font_load(font_italic);   /* 93 tiles */
	ldx	#>_font_italic
	lda	#_font_italic
	jsr	_font_load
	sta	_main_italic_font_10000_104
	stx	(_main_italic_font_10000_104 + 1)
;	src/fonts.c: 35: font_color(WHITE, DKGREY);
	lda	#0x03
	ldx	#0x01
	jsr	_font_color
;	src/fonts.c: 37: min_font = font_load(font_min);
	ldx	#>_font_min
	lda	#_font_min
	jsr	_font_load
	sta	_main_min_font_10000_104
	stx	(_main_min_font_10000_104 + 1)
;	src/fonts.c: 40: mode(get_mode() | M_NO_SCROLL);
	jsr	_get_mode
	ora	#0x04
	jsr	_mode
;	src/fonts.c: 45: font_set(ibm_font);
	ldx	(_main_ibm_font_10000_104 + 1)
	lda	_main_ibm_font_10000_104
	jsr	_font_set
;	src/fonts.c: 46: printf("Font demo.\n\n");
	lda	#>___str_0
	pha
	lda	#___str_0
	pha
	jsr	_printf
	pla
	pla
;	src/fonts.c: 48: printf("IBM Font #!?123\n");
	lda	#>___str_1
	pha
	lda	#___str_1
	pha
	jsr	_printf
	pla
	pla
;	src/fonts.c: 51: font_set(italic_font);
	ldx	(_main_italic_font_10000_104 + 1)
	lda	_main_italic_font_10000_104
	jsr	_font_set
;	src/fonts.c: 52: for (i=1; i!=5; i++) {
	ldx	#0x01
	stx	*_main_sloc0_1_0
	dex
	stx	*(_main_sloc0_1_0 + 1)
00102$:
;	src/fonts.c: 53: printf("In italics, line %u\n", i);
	lda	*(_main_sloc0_1_0 + 1)
	pha
	lda	*_main_sloc0_1_0
	pha
	lda	#>___str_2
	pha
	lda	#___str_2
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
;	src/fonts.c: 52: for (i=1; i!=5; i++) {
	inc	*_main_sloc0_1_0
	bne	00119$
	inc	*(_main_sloc0_1_0 + 1)
00119$:
	lda	*_main_sloc0_1_0
	cmp	#0x05
	bne	00102$
	lda	*(_main_sloc0_1_0 + 1)
	bne	00102$
;	src/fonts.c: 57: font_set(min_font);
	ldx	(_main_min_font_10000_104 + 1)
	lda	_main_min_font_10000_104
	jsr	_font_set
;	src/fonts.c: 58: printf("Minimal 36 tile font\n");
	lda	#>___str_3
	pha
	lda	#___str_3
	pha
	jsr	_printf
	pla
	pla
;	src/fonts.c: 61: font_set(ibm_font);
	ldx	(_main_ibm_font_10000_104 + 1)
	lda	_main_ibm_font_10000_104
	jsr	_font_set
;	src/fonts.c: 62: printf("\nDone!");
	lda	#>___str_4
	pha
	lda	#___str_4
	pha
	jsr	_printf
	pla
	pla
;	src/fonts.c: 63: }
	rts
	.area _CODE
___str_0:
	.ascii "Font demo."
	.db 0x0a
	.db 0x0a
	.db 0x00
___str_1:
	.ascii "IBM Font #!?123"
	.db 0x0a
	.db 0x00
___str_2:
	.ascii "In italics, line %u"
	.db 0x0a
	.db 0x00
___str_3:
	.ascii "Minimal 36 tile font"
	.db 0x0a
	.db 0x00
___str_4:
	.db 0x0a
	.ascii "Done!"
	.db 0x00
	.area _XINIT
	.area _CABS    (ABS)
