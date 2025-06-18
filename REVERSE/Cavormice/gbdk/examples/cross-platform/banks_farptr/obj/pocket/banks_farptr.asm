;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module banks_farptr
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _run
	.globl b_some_bank2_proc2
	.globl _some_bank2_proc2
	.globl b_some_bank2_proc1
	.globl _some_bank2_proc1
	.globl b_some_bank2_proc0
	.globl _some_bank2_proc0
	.globl _to_far_ptr
	.globl ___call__banked
	.globl _printf
	.globl _res
	.globl _farptr_var3
	.globl _farptr_var2
	.globl _farptr_var1
	.globl _farptr_var0
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_farptr_var0::
	.ds 4
_farptr_var1::
	.ds 4
_farptr_var2::
	.ds 4
_farptr_var3::
	.ds 4
_res::
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
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/banks_farptr.c:23: void run(void) {
;	---------------------------------
; Function run
; ---------------------------------
_run::
;src/banks_farptr.c:25: farptr_var0 = to_far_ptr(some_bank2_proc1, BANK(some_bank2_proc1));
	ld	c, #<(___bank_some_bank2_proc1)
	ld	b, #0x00
	ld	de, #_some_bank2_proc1
	call	_to_far_ptr
	ld	hl, #_farptr_var0
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl+), a
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/banks_farptr.c:26: farptr_var1 = to_far_ptr(some_bank2_proc1, BANK(some_bank2_proc1));
	ld	c, #<(___bank_some_bank2_proc1)
	ld	b, #0x00
	ld	de, #_some_bank2_proc1
	call	_to_far_ptr
	ld	hl, #_farptr_var1
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl+), a
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/banks_farptr.c:27: farptr_var2 = to_far_ptr(some_bank2_proc0, BANK(some_bank2_proc0));
	ld	c, #<(___bank_some_bank2_proc0)
	ld	b, #0x00
	ld	de, #_some_bank2_proc0
	call	_to_far_ptr
	ld	hl, #_farptr_var2
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl+), a
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/banks_farptr.c:28: farptr_var2 = to_far_ptr(some_bank2_proc0, BANK(some_bank2_proc0));
	ld	c, #<(___bank_some_bank2_proc0)
	ld	b, #0x00
	ld	de, #_some_bank2_proc0
	call	_to_far_ptr
	ld	hl, #_farptr_var2
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl+), a
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/banks_farptr.c:31: printf("FAR PTR0: %x:%x\n", (int)FAR_SEG(farptr_var0), (int)FAR_OFS(farptr_var0));
	ld	hl, #_farptr_var0
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #_farptr_var0 + 2
	ld	a, (hl+)
	ld	l, (hl)
;	spillPairReg hl
	ld	e, a
	ld	d, l
	push	bc
	push	de
	ld	de, #___str_0
	push	de
	call	_printf
	add	sp, #6
;src/banks_farptr.c:32: printf("FAR PTR1: %x:%x\n", (int)FAR_SEG(farptr_var1), (int)FAR_OFS(farptr_var1));
	ld	hl, #_farptr_var1
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #_farptr_var1 + 2
	ld	a, (hl+)
	ld	l, (hl)
;	spillPairReg hl
	ld	e, a
	ld	d, l
	push	bc
	push	de
	ld	de, #___str_1
	push	de
	call	_printf
	add	sp, #6
;src/banks_farptr.c:35: FAR_CALL(farptr_var2, void (*)(void));
	ld	hl, #_farptr_var2
	ld	d, h
	ld	e, l
	ld	hl, #___call_banked_ptr
	ld	a, (de)
	ld	(hl+),	a
	inc	de
	ld	a, (de)
	ld	(hl+),	a
	inc	de
	ld	a, (de)
	ld	(hl+),	a
	inc	de
	ld	a, (de)
	ld	(hl), a
	call	___call__banked
;src/banks_farptr.c:38: res = some_bank2_proc1(100, 50);
	ld	hl, #0x3264
	push	hl
	ld	e, #b_some_bank2_proc1
	ld	hl, #_some_bank2_proc1
	call	___sdcc_bcall_ehl
	pop	hl
	ld	hl, #_res
	ld	a, c
	ld	(hl+), a
;src/banks_farptr.c:39: printf("CALL DIR: %d\n", res);
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	de, #___str_2
	push	de
	call	_printf
	add	sp, #4
;src/banks_farptr.c:42: res = some_bank2_proc2(100, 50, 1);
	ld	hl, #0x132
	push	hl
	ld	a, #0x64
	push	af
	inc	sp
	ld	e, #b_some_bank2_proc2
	ld	hl, #_some_bank2_proc2
	call	___sdcc_bcall_ehl
	add	sp, #3
	ld	hl, #_res
	ld	a, c
	ld	(hl+), a
;src/banks_farptr.c:43: printf("CALL DIR (RE): %d\n", res);
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	de, #___str_3
	push	de
	call	_printf
	add	sp, #4
;src/banks_farptr.c:53: res = FAR_CALL(farptr_var1, some_bank2_proc_t, 100, 50);
	ld	hl, #_farptr_var1
	ld	d, h
	ld	e, l
	ld	hl, #___call_banked_ptr
	ld	a, (de)
	ld	(hl+),	a
	inc	de
	ld	a, (de)
	ld	(hl+),	a
	inc	de
	ld	a, (de)
	ld	(hl+),	a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	hl, #___call__banked
	ld	de, #0x3264
	push	de
	ld	bc, #00103$
	push	bc
	ld	c, l
	ld	b, h
	push	bc
	ret
00103$:
	inc	sp
	inc	sp
	ld	hl, #_res
	ld	a, c
	ld	(hl+), a
;src/banks_farptr.c:56: printf("CALL IND: %d\n", res);
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	de, #___str_4
	push	de
	call	_printf
	add	sp, #4
;src/banks_farptr.c:57: }
	ret
___str_0:
	.ascii "FAR PTR0: %x:%x"
	.db 0x0a
	.db 0x00
___str_1:
	.ascii "FAR PTR1: %x:%x"
	.db 0x0a
	.db 0x00
___str_2:
	.ascii "CALL DIR: %d"
	.db 0x0a
	.db 0x00
___str_3:
	.ascii "CALL DIR (RE): %d"
	.db 0x0a
	.db 0x00
___str_4:
	.ascii "CALL IND: %d"
	.db 0x0a
	.db 0x00
;src/banks_farptr.c:59: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/banks_farptr.c:60: ENABLE_RAM;
	ld	hl, #_rRAMG
	ld	(hl), #0x0a
;src/banks_farptr.c:61: printf("START (bank=%d)\n", (int)CURRENT_BANK);
	ldh	a, (__current_bank + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_5
	push	de
	call	_printf
	add	sp, #4
;src/banks_farptr.c:62: run();
	call	_run
;src/banks_farptr.c:63: printf("DONE! (bank=%d)\n", (int)CURRENT_BANK);
	ldh	a, (__current_bank + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_6
	push	de
	call	_printf
	add	sp, #4
;src/banks_farptr.c:64: }
	ret
___str_5:
	.ascii "START (bank=%d)"
	.db 0x0a
	.db 0x00
___str_6:
	.ascii "DONE! (bank=%d)"
	.db 0x0a
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
