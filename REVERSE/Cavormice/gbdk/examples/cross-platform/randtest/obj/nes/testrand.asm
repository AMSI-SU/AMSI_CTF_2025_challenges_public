;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module testrand
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
	.globl _waitpadup
	.globl _waitpad
	.globl _arand
	.globl _initarand
	.globl _rand
	.globl _puts
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
	.ds 1
_main_sloc1_1_0:
	.ds 2
_main_sloc2_1_0:
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
;sloc1                     Allocated with name '_main_sloc1_1_0'
;sloc2                     Allocated with name '_main_sloc2_1_0'
;i                         Allocated to registers 
;------------------------------------------------------------
;	src/testrand.c: 14: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/testrand.c: 16: puts("press A...");
	ldx	#>___str_0
	lda	#___str_0
	jsr	_puts
;	src/testrand.c: 17: waitpad(J_A);
	lda	#0x80
	jsr	_waitpad
;	src/testrand.c: 18: initarand(sys_time);
	lda	_sys_time
	ldx	(_sys_time + 1)
	jsr	_initarand
;	src/testrand.c: 19: while(TRUE) {
00103$:
;	src/testrand.c: 20: waitpadup();
	jsr	_waitpadup
;	src/testrand.c: 21: for (uint8_t i = 0; i != 16; i++) 
	ldx	#0x00
	stx	*_main_sloc0_1_0
00106$:
	lda	*_main_sloc0_1_0
	cmp	#0x10
	beq	00101$
;	src/testrand.c: 22: printf("r=%x a=%x\n", (uint16_t)rand(), (uint16_t)arand());
	jsr	_arand
	sta	*_main_sloc1_1_0
	ldx	#0x00
	stx	*(_main_sloc1_1_0 + 1)
	jsr	_rand
	sta	*_main_sloc2_1_0
	ldx	#0x00
	stx	*(_main_sloc2_1_0 + 1)
	lda	*(_main_sloc1_1_0 + 1)
	pha
	lda	*_main_sloc1_1_0
	pha
	lda	*(_main_sloc2_1_0 + 1)
	pha
	lda	*_main_sloc2_1_0
	pha
	lda	#>___str_1
	pha
	lda	#___str_1
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
	pla
	pla
;	src/testrand.c: 21: for (uint8_t i = 0; i != 16; i++) 
	inc	*_main_sloc0_1_0
	jmp	00106$
00101$:
;	src/testrand.c: 23: puts("press A...");
	ldx	#>___str_0
	lda	#___str_0
	jsr	_puts
;	src/testrand.c: 24: waitpad(J_A);
	lda	#0x80
	jsr	_waitpad
	jmp	00103$
;	src/testrand.c: 26: }
	rts
	.area _CODE
___str_0:
	.ascii "press A..."
	.db 0x00
___str_1:
	.ascii "r=%x a=%x"
	.db 0x0a
	.db 0x00
	.area _XINIT
	.area _CABS    (ABS)
