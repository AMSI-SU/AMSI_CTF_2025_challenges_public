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
	.globl _some_const_var_0
	.globl _main
	.globl _bank_fixed
	.globl b_func_4
	.globl _func_4
	.globl b_func_3
	.globl _func_3
	.globl b_func_2
	.globl _func_2
	.globl b_func_1
	.globl _func_1
	.globl _puts
	.globl _printf
	.globl __switch_prg0
	.globl _vsync
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
_main__saved_bank_10000_101:
	.ds 1
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
;	src/banks.c: 17: void bank_fixed(void) NONBANKED
;	-----------------------------------------
;	 function bank_fixed
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_bank_fixed:
;	src/banks.c: 19: puts("I'm in fixed ROM");
	ldx	#>___str_0
	lda	#___str_0
;	src/banks.c: 20: }
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
;sloc0                     Allocated with name '_main_sloc0_1_0'
;_saved_bank               Allocated with name '_main__saved_bank_10000_101'
;------------------------------------------------------------
;	src/banks.c: 22: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/banks.c: 29: printf("Program Start...\n\n");
	lda	#>___str_1
	pha
	lda	#___str_1
	pha
	jsr	_printf
	pla
	pla
;	src/banks.c: 32: bank_fixed();
	jsr	_bank_fixed
;	src/banks.c: 34: func_1();
	jsr	___sdcc_bcall
	.db	b_func_1
	.dw 	_func_1-1
;	src/banks.c: 35: func_2();
	jsr	___sdcc_bcall
	.db	b_func_2
	.dw 	_func_2-1
;	src/banks.c: 36: func_3();
	jsr	___sdcc_bcall
	.db	b_func_3
	.dw 	_func_3-1
;	src/banks.c: 37: func_4();
	jsr	___sdcc_bcall
	.db	b_func_4
	.dw 	_func_4-1
;	src/banks.c: 39: printf("\n");
	lda	#>___str_2
	pha
	lda	#___str_2
	pha
	jsr	_printf
	pla
	pla
;	src/banks.c: 43: printf("Const0= %u nonbanked\n", some_const_var_0);
	lda	#0x00
	pha
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
;	src/banks.c: 45: SWITCH_ROM(BANK(some_const_var_1));
	lda	#___bank_some_const_var_1
	jsr	__switch_prg0
;	src/banks.c: 46: printf("Const1= %u in bank %hu\n", some_const_var_1, BANK(some_const_var_1));
	lda	#___bank_some_const_var_1
	ldx	_some_const_var_1
	stx	*_main_sloc0_1_0
	ldx	#0x00
	stx	*(_main_sloc0_1_0 + 1)
	pha
	lda	*(_main_sloc0_1_0 + 1)
	pha
	lda	*_main_sloc0_1_0
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
	pla
;	src/banks.c: 47: SWITCH_ROM(BANK(some_const_var_2));
	lda	#___bank_some_const_var_2
	jsr	__switch_prg0
;	src/banks.c: 48: printf("Const2= %u in bank %hu\n", some_const_var_2, BANK(some_const_var_2));
	lda	#___bank_some_const_var_2
	ldx	_some_const_var_2
	stx	*_main_sloc0_1_0
	ldx	#0x00
	stx	*(_main_sloc0_1_0 + 1)
	pha
	lda	*(_main_sloc0_1_0 + 1)
	pha
	lda	*_main_sloc0_1_0
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
	pla
;	src/banks.c: 49: SWITCH_ROM(BANK(some_const_var_3));
	lda	#___bank_some_const_var_3
	jsr	__switch_prg0
;	src/banks.c: 50: printf("Const3= %u in bank %hu\n", some_const_var_3, BANK(some_const_var_3));
	lda	#___bank_some_const_var_3
	ldx	_some_const_var_3
	stx	*_main_sloc0_1_0
	ldx	#0x00
	stx	*(_main_sloc0_1_0 + 1)
	pha
	lda	*(_main_sloc0_1_0 + 1)
	pha
	lda	*_main_sloc0_1_0
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
	pla
;	src/banks.c: 56: _saved_bank = CURRENT_BANK;
	lda	__current_bank
	sta	_main__saved_bank_10000_101
;	src/banks.c: 59: SWITCH_ROM(BANK(some_const_var_4));
	lda	#___bank_some_const_var_4
	jsr	__switch_prg0
;	src/banks.c: 60: printf("Const4= %u in bank %hu\n", some_const_var_4, BANK(some_const_var_4));
	lda	#___bank_some_const_var_4
	ldx	_some_const_var_4
	stx	*_main_sloc0_1_0
	ldx	#0x00
	stx	*(_main_sloc0_1_0 + 1)
	pha
	lda	*(_main_sloc0_1_0 + 1)
	pha
	lda	*_main_sloc0_1_0
	pha
	lda	#>___str_7
	pha
	lda	#___str_7
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
	pla
;	src/banks.c: 63: SWITCH_ROM(_saved_bank);
	lda	_main__saved_bank_10000_101
	jsr	__switch_prg0
;	src/banks.c: 67: printf("\n");
	lda	#>___str_2
	pha
	lda	#___str_2
	pha
	jsr	_printf
	pla
	pla
;	src/banks.c: 68: puts("The End...");
	ldx	#>___str_8
	lda	#___str_8
	jsr	_puts
;	src/banks.c: 71: while(1) {
00102$:
;	src/banks.c: 74: vsync();
	jsr	_vsync
	jmp	00102$
;	src/banks.c: 76: }
	rts
	.area _CODE
_some_const_var_0:
	.db #0x00	; 0
___str_0:
	.ascii "I'm in fixed ROM"
	.db 0x00
___str_1:
	.ascii "Program Start..."
	.db 0x0a
	.db 0x0a
	.db 0x00
___str_2:
	.db 0x0a
	.db 0x00
___str_3:
	.ascii "Const0= %u nonbanked"
	.db 0x0a
	.db 0x00
___str_4:
	.ascii "Const1= %u in bank %hu"
	.db 0x0a
	.db 0x00
___str_5:
	.ascii "Const2= %u in bank %hu"
	.db 0x0a
	.db 0x00
___str_6:
	.ascii "Const3= %u in bank %hu"
	.db 0x0a
	.db 0x00
___str_7:
	.ascii "Const4= %u in bank %hu"
	.db 0x0a
	.db 0x00
___str_8:
	.ascii "The End..."
	.db 0x00
	.area _XINIT
	.area _CABS    (ABS)
