;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module banks
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
	.globl _bank_fixed
	.globl b_bank_3
	.globl _bank_3
	.globl b_bank_2
	.globl _bank_2
	.globl b_bank_1
	.globl _bank_1
	.globl _puts
	.globl _printf
	.globl _var_internal
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
_var_internal::
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
;	src/banks.c: 18: void bank_fixed(void) NONBANKED
;	-----------------------------------------
;	 function bank_fixed
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_bank_fixed:
;	src/banks.c: 20: puts("I'm in fixed ROM");
	ldx	#>___str_0
	lda	#___str_0
;	src/banks.c: 21: }
	jmp	_puts
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;------------------------------------------------------------
;Allocation info for local variables in function 'bank_fixed'
;------------------------------------------------------------
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;	src/banks.c: 23: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/banks.c: 25: puts("Program Start...");
	ldx	#>___str_1
	lda	#___str_1
	jsr	_puts
;	src/banks.c: 29: var_internal = 1;
	ldx	#0x01
	stx	_var_internal
	dex
	stx	(_var_internal + 1)
;	src/banks.c: 31: var_0 = 2;
	ldx	#0x02
	stx	_var_0
	ldx	#0x00
	stx	(_var_0 + 1)
;	src/banks.c: 33: var_1 = 3;
	ldx	#0x03
	stx	_var_1
	ldx	#0x00
	stx	(_var_1 + 1)
;	src/banks.c: 35: var_2 = 4;
	ldx	#0x04
	stx	_var_2
	ldx	#0x00
	stx	(_var_2 + 1)
;	src/banks.c: 37: var_3 = 5;
	ldx	#0x05
	stx	_var_3
	ldx	#0x00
	stx	(_var_3 + 1)
;	src/banks.c: 39: bank_fixed();
	jsr	_bank_fixed
;	src/banks.c: 40: bank_1();
	jsr	___sdcc_bcall
	.db	b_bank_1
	.dw 	_bank_1-1
;	src/banks.c: 41: bank_2();
	jsr	___sdcc_bcall
	.db	b_bank_2
	.dw 	_bank_2-1
;	src/banks.c: 42: bank_3();
	jsr	___sdcc_bcall
	.db	b_bank_3
	.dw 	_bank_3-1
;	src/banks.c: 44: printf("Var is %u\n", var_internal);
	lda	(_var_internal + 1)
	pha
	lda	_var_internal
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
;	src/banks.c: 46: printf("Var_0 is %u\n", var_0);
	lda	(_var_0 + 1)
	pha
	lda	_var_0
	pha
	lda	#>___str_3
	pha
	lda	#___str_3
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
;	src/banks.c: 48: printf("Var_1 is %u\n", var_1);
	lda	(_var_1 + 1)
	pha
	lda	_var_1
	pha
	lda	#>___str_4
	pha
	lda	#___str_4
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
;	src/banks.c: 50: printf("Var_2 is %u\n", var_2);
	lda	(_var_2 + 1)
	pha
	lda	_var_2
	pha
	lda	#>___str_5
	pha
	lda	#___str_5
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
;	src/banks.c: 52: printf("Var_3 is %u\n", var_3);
	lda	(_var_3 + 1)
	pha
	lda	_var_3
	pha
	lda	#>___str_6
	pha
	lda	#___str_6
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
;	src/banks.c: 54: puts("The End...");
	ldx	#>___str_7
	lda	#___str_7
;	src/banks.c: 55: }
	jmp	_puts
	.area _CODE
___str_0:
	.ascii "I'm in fixed ROM"
	.db 0x00
___str_1:
	.ascii "Program Start..."
	.db 0x00
___str_2:
	.ascii "Var is %u"
	.db 0x0a
	.db 0x00
___str_3:
	.ascii "Var_0 is %u"
	.db 0x0a
	.db 0x00
___str_4:
	.ascii "Var_1 is %u"
	.db 0x0a
	.db 0x00
___str_5:
	.ascii "Var_2 is %u"
	.db 0x0a
	.db 0x00
___str_6:
	.ascii "Var_3 is %u"
	.db 0x0a
	.db 0x00
___str_7:
	.ascii "The End..."
	.db 0x00
	.area _XINIT
	.area _CABS    (ABS)
