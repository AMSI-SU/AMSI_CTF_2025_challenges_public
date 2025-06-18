;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module banked
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b_banked_func
	.globl _banked_func
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_VCOUNTER	=	0x007e
_PSG	=	0x007f
_HCOUNTER	=	0x007f
_VDP_DATA	=	0x0098
_VDP_CMD	=	0x0099
_VDP_STATUS	=	0x0099
_FMADDRESS	=	0x00f0
_FMDATA	=	0x00f1
_AUDIOCTRL	=	0x00f2
_MAP_FRAME0	=	0x00fc
_MAP_FRAME1	=	0x00fd
_MAP_FRAME2	=	0x00fe
_MAP_FRAME3	=	0x00ff
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
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
	.area _CODE_3
;banked.c:6: uint16_t banked_func(uint8_t be, uint8_t ef) BANKED {
;	---------------------------------
; Function banked_func
; ---------------------------------
	b_banked_func	= 3
_banked_func::
	push	ix
;banked.c:7: return ((be << 8) | ef);
	ld	hl, #0x7
	add	hl, sp
	ld	d, (hl)
	inc	hl
	ld	e, (hl)
;banked.c:8: }
	pop	ix
	ret
	.area _CODE_3
	.area _INITIALIZER
	.area _CABS (ABS)
