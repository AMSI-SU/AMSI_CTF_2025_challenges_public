;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module banks_farptr
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
_run_sloc0_1_0:
	.ds 2
_run_sloc1_1_0:
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
;Allocation info for local variables in function 'run'
;------------------------------------------------------------
;sloc0                     Allocated with name '_run_sloc0_1_0'
;sloc1                     Allocated with name '_run_sloc1_1_0'
;------------------------------------------------------------
;	src/banks_farptr.c: 23: void run(void) {
;	-----------------------------------------
;	 function run
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_run:
;	src/banks_farptr.c: 25: farptr_var0 = to_far_ptr(some_bank2_proc1, BANK(some_bank2_proc1));
	ldx	#>(_some_bank2_proc1)
	lda	#(_some_bank2_proc1)
	ldy	#___bank_some_bank2_proc1
	sty	_to_far_ptr_PARM_2
	pha
	lda	#0x00
	sta	(_to_far_ptr_PARM_2 + 1)
	pla
	jsr	_to_far_ptr
	sta	_farptr_var0
	stx	(_farptr_var0 + 1)
	lda	*___SDCC_m6502_ret2
	sta	(_farptr_var0 + 2)
	lda	*___SDCC_m6502_ret3
	sta	(_farptr_var0 + 3)
;	src/banks_farptr.c: 26: farptr_var1 = to_far_ptr(some_bank2_proc1, BANK(some_bank2_proc1));
	ldx	#>(_some_bank2_proc1)
	lda	#(_some_bank2_proc1)
	ldy	#___bank_some_bank2_proc1
	sty	_to_far_ptr_PARM_2
	pha
	lda	#0x00
	sta	(_to_far_ptr_PARM_2 + 1)
	pla
	jsr	_to_far_ptr
	sta	_farptr_var1
	stx	(_farptr_var1 + 1)
	lda	*___SDCC_m6502_ret2
	sta	(_farptr_var1 + 2)
	lda	*___SDCC_m6502_ret3
	sta	(_farptr_var1 + 3)
;	src/banks_farptr.c: 27: farptr_var2 = to_far_ptr(some_bank2_proc0, BANK(some_bank2_proc0));
	ldx	#>(_some_bank2_proc0)
	lda	#(_some_bank2_proc0)
	ldy	#___bank_some_bank2_proc0
	sty	_to_far_ptr_PARM_2
	pha
	lda	#0x00
	sta	(_to_far_ptr_PARM_2 + 1)
	pla
	jsr	_to_far_ptr
	sta	_farptr_var2
	stx	(_farptr_var2 + 1)
	lda	*___SDCC_m6502_ret2
	sta	(_farptr_var2 + 2)
	lda	*___SDCC_m6502_ret3
	sta	(_farptr_var2 + 3)
;	src/banks_farptr.c: 28: farptr_var2 = to_far_ptr(some_bank2_proc0, BANK(some_bank2_proc0));
	ldx	#>(_some_bank2_proc0)
	lda	#(_some_bank2_proc0)
	ldy	#___bank_some_bank2_proc0
	sty	_to_far_ptr_PARM_2
	pha
	lda	#0x00
	sta	(_to_far_ptr_PARM_2 + 1)
	pla
	jsr	_to_far_ptr
	sta	_farptr_var2
	stx	(_farptr_var2 + 1)
	lda	*___SDCC_m6502_ret2
	sta	(_farptr_var2 + 2)
	lda	*___SDCC_m6502_ret3
	sta	(_farptr_var2 + 3)
;	src/banks_farptr.c: 31: printf("FAR PTR0: %x:%x\n", (int)FAR_SEG(farptr_var0), (int)FAR_OFS(farptr_var0));
	ldx	(_farptr_var0 + 1)
	lda	_farptr_var0
	sta	*_run_sloc0_1_0
	stx	*(_run_sloc0_1_0 + 1)
	ldx	((_farptr_var0 + 0x0002) + 1)
	lda	(_farptr_var0 + 0x0002)
	sta	*_run_sloc1_1_0
	stx	*(_run_sloc1_1_0 + 1)
	lda	*(_run_sloc0_1_0 + 1)
	pha
	lda	*_run_sloc0_1_0
	pha
	lda	*(_run_sloc1_1_0 + 1)
	pha
	lda	*_run_sloc1_1_0
	pha
	lda	#>___str_0
	pha
	lda	#___str_0
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
	pla
	pla
;	src/banks_farptr.c: 32: printf("FAR PTR1: %x:%x\n", (int)FAR_SEG(farptr_var1), (int)FAR_OFS(farptr_var1));
	ldx	(_farptr_var1 + 1)
	lda	_farptr_var1
	sta	*_run_sloc1_1_0
	stx	*(_run_sloc1_1_0 + 1)
	ldx	((_farptr_var1 + 0x0002) + 1)
	lda	(_farptr_var1 + 0x0002)
	sta	*_run_sloc0_1_0
	stx	*(_run_sloc0_1_0 + 1)
	lda	*(_run_sloc1_1_0 + 1)
	pha
	lda	*_run_sloc1_1_0
	pha
	lda	*(_run_sloc0_1_0 + 1)
	pha
	lda	*_run_sloc0_1_0
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
;	src/banks_farptr.c: 35: FAR_CALL(farptr_var2, void (*)(void));
	lda	(_farptr_var2 + 3)
	sta	(___call_banked_ptr + 3)
	lda	(_farptr_var2 + 2)
	sta	(___call_banked_ptr + 2)
	lda	(_farptr_var2 + 1)
	sta	(___call_banked_ptr + 1)
	lda	_farptr_var2
	sta	___call_banked_ptr
	jsr	___call__banked
;	src/banks_farptr.c: 38: res = some_bank2_proc1(100, 50);
	lda	#0x64
	ldx	#0x32
	jsr	___sdcc_bcall
	.db	b_some_bank2_proc1
	.dw 	_some_bank2_proc1-1
	sta	_res
	stx	(_res + 1)
;	src/banks_farptr.c: 39: printf("CALL DIR: %d\n", res);
	sta	*(REGTEMP+0)
	txa
	pha
	lda	*(REGTEMP+0)
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
;	src/banks_farptr.c: 42: res = some_bank2_proc2(100, 50, 1);
	lda	#0x01
	pha
	lda	#0x64
	ldx	#0x32
	jsr	___sdcc_bcall
	.db	b_some_bank2_proc2
	.dw 	_some_bank2_proc2-1
	sta	*(REGTEMP+0)
	pla
	lda	*(REGTEMP+0)
	sta	_res
	stx	(_res + 1)
;	src/banks_farptr.c: 43: printf("CALL DIR (RE): %d\n", res);
	sta	*(REGTEMP+0)
	txa
	pha
	lda	*(REGTEMP+0)
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
;	src/banks_farptr.c: 50: res = FAR_CALL(farptr_var1, int (*)(uint8_t, uint8_t), 100, 50);
	lda	(_farptr_var1 + 3)
	sta	(___call_banked_ptr + 3)
	lda	(_farptr_var1 + 2)
	sta	(___call_banked_ptr + 2)
	lda	(_farptr_var1 + 1)
	sta	(___call_banked_ptr + 1)
	lda	_farptr_var1
	sta	___call_banked_ptr
	lda	#>(___call__banked)
	sta	*(_run_sloc1_1_0 + 1)
	lda	#(___call__banked)
	sta	*_run_sloc1_1_0
	sta	*(REGTEMP+0)
	lda	*(_run_sloc1_1_0 + 1)
	sta	*(REGTEMP+1)
	lda	#0x64
	ldx	#0x32
	jsr	__sdcc_indirect_jsr
	sta	_res
	stx	(_res + 1)
;	src/banks_farptr.c: 56: printf("CALL IND: %d\n", res);
	sta	*(REGTEMP+0)
	txa
	pha
	lda	*(REGTEMP+0)
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
;	src/banks_farptr.c: 57: }
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;	src/banks_farptr.c: 59: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/banks_farptr.c: 61: printf("START (bank=%d)\n", (int)CURRENT_BANK);
	ldx	#0x00
	lda	__current_bank
	sta	*(REGTEMP+0)
	txa
	pha
	lda	*(REGTEMP+0)
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
;	src/banks_farptr.c: 62: run();
	jsr	_run
;	src/banks_farptr.c: 63: printf("DONE! (bank=%d)\n", (int)CURRENT_BANK);
	ldx	#0x00
	lda	__current_bank
	sta	*(REGTEMP+0)
	txa
	pha
	lda	*(REGTEMP+0)
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
;	src/banks_farptr.c: 64: }
	rts
	.area _CODE
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
___str_5:
	.ascii "START (bank=%d)"
	.db 0x0a
	.db 0x00
___str_6:
	.ascii "DONE! (bank=%d)"
	.db 0x0a
	.db 0x00
	.area _XINIT
	.area _CABS    (ABS)
