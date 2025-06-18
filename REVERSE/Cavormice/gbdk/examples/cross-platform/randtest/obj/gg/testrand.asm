;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module testrand
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _waitpadup
	.globl _waitpad
	.globl _arand
	.globl _initarand
	.globl _rand
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
;src/testrand.c:14: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;src/testrand.c:16: puts("press A...");
	ld	hl, #___str_0
	call	_puts
;src/testrand.c:17: waitpad(J_A);
	ld	l, #0x20
;	spillPairReg hl
;	spillPairReg hl
	call	_waitpad
;src/testrand.c:18: initarand(sys_time);
	ld	hl, (_sys_time)
	call	_initarand
;src/testrand.c:19: while(TRUE) {
00103$:
;src/testrand.c:20: waitpadup();
	call	_waitpadup
;src/testrand.c:21: for (uint8_t i = 0; i != 16; i++) 
	ld	-1 (ix), #0x00
00106$:
	ld	a, -1 (ix)
	sub	a, #0x10
	jr	Z, 00101$
;src/testrand.c:22: printf("r=%x a=%x\n", (uint16_t)rand(), (uint16_t)arand());
	call	_arand
	ld	c, l
	ld	b, #0x00
	push	bc
	call	_rand
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	de, #___str_1
	push	bc
	push	hl
	push	de
	call	_printf
	pop	af
	pop	af
	pop	af
;src/testrand.c:21: for (uint8_t i = 0; i != 16; i++) 
	inc	-1 (ix)
	jr	00106$
00101$:
;src/testrand.c:23: puts("press A...");
	ld	hl, #___str_0
	call	_puts
;src/testrand.c:24: waitpad(J_A);
	ld	l, #0x20
;	spillPairReg hl
;	spillPairReg hl
	call	_waitpad
	jr	00103$
;src/testrand.c:26: }
	inc	sp
	pop	ix
	ret
___str_0:
	.ascii "press A..."
	.db 0x00
___str_1:
	.ascii "r=%x a=%x"
	.db 0x0a
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
