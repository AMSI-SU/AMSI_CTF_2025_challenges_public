;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module fonts
	.optsdcc -mz80
	
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
	.globl _puts
	.globl _printf
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
;src/fonts.c:17: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-6
	add	hl, sp
	ld	sp, hl
;src/fonts.c:20: __WRITE_VDP_REG(VDP_R2, R2_MAP_0x3800);
	ld	iy, #_shadow_VDP_R2
	ld	0 (iy), #0xff
	di
	ld	a, #0xff
	out	(_VDP_CMD), a
	ld	a, #0x82
	out	(_VDP_CMD), a
	ei
;src/fonts.c:21: __WRITE_VDP_REG(VDP_R5, R5_SAT_0x3F00);
	ld	iy, #_shadow_VDP_R5
	ld	0 (iy), #0xff
	di
	ld	a, #0xff
	out	(_VDP_CMD), a
	ld	a, #0x85
	out	(_VDP_CMD), a
	ei
;src/fonts.c:28: font_init();
	call	_font_init
;src/fonts.c:31: ibm_font = font_load(font_ibm);  /* 96 tiles */
	ld	hl, #_font_ibm
	push	hl
	call	_font_load
	pop	af
	ex	(sp), hl
;src/fonts.c:32: italic_font = font_load(font_italic);   /* 93 tiles */
	ld	hl, #_font_italic
	push	hl
	call	_font_load
	pop	af
	ld	-4 (ix), l
	ld	-3 (ix), h
;src/fonts.c:35: font_color(WHITE, DKGREY);
	ld	hl, #0x103
	push	hl
	call	_font_color
;src/fonts.c:37: min_font = font_load(font_min);
	ld	hl, #_font_min
	ex	(sp),hl
	call	_font_load
	pop	af
	ld	-2 (ix), l
	ld	-1 (ix), h
;src/fonts.c:40: mode(get_mode() | M_NO_SCROLL);
	call	_get_mode
	ld	a, l
	or	a, #0x04
	push	af
	inc	sp
	call	_mode
	inc	sp
;src/fonts.c:45: font_set(ibm_font);
	pop	hl
	push	hl
	push	hl
	call	_font_set
	pop	af
;src/fonts.c:48: printf("IBM Font #!?123\n");
	ld	hl, #___str_8
	call	_puts
;src/fonts.c:51: font_set(italic_font);
	pop	de
	pop	hl
	push	hl
	push	de
	push	hl
	call	_font_set
	pop	af
;src/fonts.c:52: for (i=1; i!=5; i++) {
	ld	bc, #0x0001
00102$:
;src/fonts.c:53: printf("In italics, line %u\n", i);
	push	bc
	push	bc
	ld	hl, #___str_4
	push	hl
	call	_printf
	pop	af
	pop	af
	pop	bc
;src/fonts.c:52: for (i=1; i!=5; i++) {
	inc	bc
	ld	a, c
	sub	a, #0x05
	or	a, b
	jr	NZ, 00102$
;src/fonts.c:57: font_set(min_font);
	ld	l, -2 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	call	_font_set
	pop	af
;src/fonts.c:58: printf("Minimal 36 tile font\n");
	ld	hl, #___str_6
	call	_puts
;src/fonts.c:61: font_set(ibm_font);
	pop	hl
	push	hl
	push	hl
	call	_font_set
;src/fonts.c:62: printf("\nDone!");
	ld	hl, #___str_7
	ex	(sp),hl
	call	_printf
;src/fonts.c:63: }
	ld	sp,ix
	pop	ix
	ret
___str_4:
	.ascii "In italics, line %u"
	.db 0x0a
	.db 0x00
___str_6:
	.ascii "Minimal 36 tile font"
	.db 0x00
___str_7:
	.db 0x0a
	.ascii "Done!"
	.db 0x00
___str_8:
	.ascii "Font demo."
	.db 0x0a
	.db 0x0a
	.ascii "IBM Font #!?123"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
