;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module test
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _strlen
	.globl _uitoa
	.globl _printf
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
	.area _CODE
;test.c:6: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-32
	add	hl, sp
	ld	sp, hl
;test.c:9: printf("%d %s", strlen(uitoa(score, data, 10)), data);
	ld	a, #0x0a
	push	af
	inc	sp
	ld	hl, #1
	add	hl, sp
	push	hl
	ld	hl, #0x004b
	push	hl
	call	_uitoa
	pop	af
	pop	af
	inc	sp
	push	hl
	call	_strlen
	pop	af
	ex	de, hl
	ld	hl, #0
	add	hl, sp
	push	hl
	push	de
	ld	hl, #___str_0
	push	hl
	call	_printf
;test.c:10: }
	ld	sp,ix
	pop	ix
	ret
___str_0:
	.ascii "%d %s"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
