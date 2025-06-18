;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module banks
	.optsdcc -msm83
	
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
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_var_internal::
	.ds 2
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
;src/banks.c:18: void bank_fixed(void) NONBANKED
;	---------------------------------
; Function bank_fixed
; ---------------------------------
_bank_fixed::
;src/banks.c:20: puts("I'm in fixed ROM");
	ld	de, #___str_0
;src/banks.c:21: }
	jp	_puts
___str_0:
	.ascii "I'm in fixed ROM"
	.db 0x00
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/banks.c:23: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/banks.c:25: puts("Program Start...");
	ld	de, #___str_1
	call	_puts
;src/banks.c:27: ENABLE_RAM;
	ld	hl, #_rRAMG
	ld	(hl), #0x0a
;src/banks.c:29: var_internal = 1;
	ld	hl, #_var_internal
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/banks.c:30: SWITCH_RAM(0);
	ld	hl, #_rRAMB
	ld	(hl), #0x00
;src/banks.c:31: var_0 = 2;
	ld	hl, #_var_0
	ld	a, #0x02
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/banks.c:32: SWITCH_RAM(1);
	ld	hl, #_rRAMB
	ld	(hl), #0x01
;src/banks.c:33: var_1 = 3;
	ld	hl, #_var_1
	ld	a, #0x03
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/banks.c:34: SWITCH_RAM(0);
	ld	hl, #_rRAMB
	ld	(hl), #0x00
;src/banks.c:35: var_2 = 4;
	ld	hl, #_var_2
	ld	a, #0x04
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/banks.c:36: SWITCH_RAM(1);
	ld	hl, #_rRAMB
	ld	(hl), #0x01
;src/banks.c:37: var_3 = 5;
	ld	hl, #_var_3
	ld	a, #0x05
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/banks.c:39: bank_fixed();
	call	_bank_fixed
;src/banks.c:40: bank_1();
	ld	e, #b_bank_1
	ld	hl, #_bank_1
	call	___sdcc_bcall_ehl
;src/banks.c:41: bank_2();
	ld	e, #b_bank_2
	ld	hl, #_bank_2
	call	___sdcc_bcall_ehl
;src/banks.c:42: bank_3();
	ld	e, #b_bank_3
	ld	hl, #_bank_3
	call	___sdcc_bcall_ehl
;src/banks.c:44: printf("Var is %u\n", var_internal);
	ld	hl, #_var_internal
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	de, #___str_2
	push	de
	call	_printf
	add	sp, #4
;src/banks.c:45: SWITCH_RAM(0);
	ld	hl, #_rRAMB
	ld	(hl), #0x00
;src/banks.c:46: printf("Var_0 is %u\n", var_0);
	ld	hl, #_var_0
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	de, #___str_3
	push	de
	call	_printf
	add	sp, #4
;src/banks.c:47: SWITCH_RAM(1);
	ld	hl, #_rRAMB
	ld	(hl), #0x01
;src/banks.c:48: printf("Var_1 is %u\n", var_1);
	ld	hl, #_var_1
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	de, #___str_4
	push	de
	call	_printf
	add	sp, #4
;src/banks.c:49: SWITCH_RAM(0);
	ld	hl, #_rRAMB
	ld	(hl), #0x00
;src/banks.c:50: printf("Var_2 is %u\n", var_2);
	ld	hl, #_var_2
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	de, #___str_5
	push	de
	call	_printf
	add	sp, #4
;src/banks.c:51: SWITCH_RAM(1);
	ld	hl, #_rRAMB
	ld	(hl), #0x01
;src/banks.c:52: printf("Var_3 is %u\n", var_3);
	ld	hl, #_var_3
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	de, #___str_6
	push	de
	call	_printf
	add	sp, #4
;src/banks.c:54: puts("The End...");
	ld	de, #___str_7
;src/banks.c:55: }
	jp	_puts
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
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
