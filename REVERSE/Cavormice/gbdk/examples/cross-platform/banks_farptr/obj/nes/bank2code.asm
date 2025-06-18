;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module bank2code
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
	.globl b_some_bank2_proc2
	.globl _some_bank2_proc2
	.globl b___func_some_bank2_proc2
	.globl ___func_some_bank2_proc2
	.globl b_some_bank2_proc1
	.globl _some_bank2_proc1
	.globl b___func_some_bank2_proc1
	.globl ___func_some_bank2_proc1
	.globl b_some_bank2_proc0
	.globl _some_bank2_proc0
	.globl b___func_some_bank2_proc0
	.globl ___func_some_bank2_proc0
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
_local_bank2_proc_sloc0_1_0:
	.ds 2
_local_bank2_proc_sloc1_1_0:
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
_local_bank2_proc_PARM_2:
	.ds 2
_some_bank2_proc1_param2_10000_102:
	.ds 1
_some_bank2_proc1_param1_10000_102:
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
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE_2
;------------------------------------------------------------
;Allocation info for local variables in function 'local_bank2_proc'
;------------------------------------------------------------
;sloc0                     Allocated with name '_local_bank2_proc_sloc0_1_0'
;sloc1                     Allocated with name '_local_bank2_proc_sloc1_1_0'
;param2                    Allocated with name '_local_bank2_proc_PARM_2'
;param1                    Allocated to registers a x 
;------------------------------------------------------------
;	src/bank2code.c: 7: static int local_bank2_proc(int param1, int param2) {
;	-----------------------------------------
;	 function local_bank2_proc
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_local_bank2_proc:
;	src/bank2code.c: 8: printf("  sum: %d (bank=%d)\n", param1 + param2, (int)CURRENT_BANK);
	ldy	__current_bank
	sty	*_local_bank2_proc_sloc0_1_0
	ldy	#0x00
	sty	*(_local_bank2_proc_sloc0_1_0 + 1)
	clc
	adc	_local_bank2_proc_PARM_2
	sta	*_local_bank2_proc_sloc1_1_0
	txa
	adc	(_local_bank2_proc_PARM_2 + 1)
	sta	*(_local_bank2_proc_sloc1_1_0 + 1)
	lda	*(_local_bank2_proc_sloc0_1_0 + 1)
	pha
	lda	*_local_bank2_proc_sloc0_1_0
	pha
	lda	*(_local_bank2_proc_sloc1_1_0 + 1)
	pha
	lda	*_local_bank2_proc_sloc1_1_0
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
;	src/bank2code.c: 9: return (param1 + param2) << 1;
	ldx	*(_local_bank2_proc_sloc1_1_0 + 1)
	lda	*_local_bank2_proc_sloc1_1_0
	stx	*(REGTEMP+0)
	asl	a
	rol	*(REGTEMP+0)
	ldx	*(REGTEMP+0)
;	src/bank2code.c: 10: }
	rts
;------------------------------------------------------------
;Allocation info for local variables in function '__func_some_bank2_proc0'
;------------------------------------------------------------
;	src/bank2code.c: 12: BANKREF(some_bank2_proc0)
;	-----------------------------------------
;	 function __func_some_bank2_proc0
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
	b___func_some_bank2_proc0	= 2
___func_some_bank2_proc0:
;	naked function: no prologue.
		.local b___func_some_bank2_proc0 
	 ___bank_some_bank2_proc0 = b___func_some_bank2_proc0 
	 .globl ___bank_some_bank2_proc0 
;	naked function: no epilogue.
;------------------------------------------------------------
;Allocation info for local variables in function 'some_bank2_proc0'
;------------------------------------------------------------
;	src/bank2code.c: 13: void some_bank2_proc0(void) BANKED {
;	-----------------------------------------
;	 function some_bank2_proc0
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
	b_some_bank2_proc0	= 2
_some_bank2_proc0:
;	src/bank2code.c: 14: printf("some_bank2_proc0\n");
	lda	#>___str_1
	pha
	lda	#___str_1
	pha
	jsr	_printf
	pla
	pla
;	src/bank2code.c: 15: }
	rts
;------------------------------------------------------------
;Allocation info for local variables in function '__func_some_bank2_proc1'
;------------------------------------------------------------
;	src/bank2code.c: 17: BANKREF(some_bank2_proc1)
;	-----------------------------------------
;	 function __func_some_bank2_proc1
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
	b___func_some_bank2_proc1	= 2
___func_some_bank2_proc1:
;	naked function: no prologue.
		.local b___func_some_bank2_proc1 
	 ___bank_some_bank2_proc1 = b___func_some_bank2_proc1 
	 .globl ___bank_some_bank2_proc1 
;	naked function: no epilogue.
;------------------------------------------------------------
;Allocation info for local variables in function 'some_bank2_proc1'
;------------------------------------------------------------
;param2                    Allocated with name '_some_bank2_proc1_param2_10000_102'
;param1                    Allocated with name '_some_bank2_proc1_param1_10000_102'
;------------------------------------------------------------
;	src/bank2code.c: 18: int some_bank2_proc1(uint8_t param1, uint8_t param2) BANKED {
;	-----------------------------------------
;	 function some_bank2_proc1
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
	b_some_bank2_proc1	= 2
_some_bank2_proc1:
	sta	_some_bank2_proc1_param1_10000_102
	stx	_some_bank2_proc1_param2_10000_102
;	src/bank2code.c: 19: printf("some_bank2_proc1\n");
	lda	#>___str_2
	pha
	lda	#___str_2
	pha
	jsr	_printf
	pla
	pla
;	src/bank2code.c: 20: return local_bank2_proc(param1, param2);
	ldx	#0x00
	lda	_some_bank2_proc1_param1_10000_102
	ldy	_some_bank2_proc1_param2_10000_102
	sty	_local_bank2_proc_PARM_2
	stx	(_local_bank2_proc_PARM_2 + 1)
;	src/bank2code.c: 21: }
	jmp	_local_bank2_proc
;------------------------------------------------------------
;Allocation info for local variables in function '__func_some_bank2_proc2'
;------------------------------------------------------------
;	src/bank2code.c: 23: BANKREF(some_bank2_proc2)
;	-----------------------------------------
;	 function __func_some_bank2_proc2
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
	b___func_some_bank2_proc2	= 2
___func_some_bank2_proc2:
;	naked function: no prologue.
		.local b___func_some_bank2_proc2 
	 ___bank_some_bank2_proc2 = b___func_some_bank2_proc2 
	 .globl ___bank_some_bank2_proc2 
;	naked function: no epilogue.
;------------------------------------------------------------
;Allocation info for local variables in function 'some_bank2_proc2'
;------------------------------------------------------------
;param3                    Allocated to stack - sp +9 +1 
;param2                    Allocated to registers y 
;param1                    Allocated to stack - sp +3 +1 
;sloc0                     Allocated to stack - sp +1 +2 
;------------------------------------------------------------
;	src/bank2code.c: 24: int some_bank2_proc2(uint8_t param1, uint8_t param2, uint8_t param3) BANKED REENTRANT {
;	-----------------------------------------
;	 function some_bank2_proc2
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 3 bytes.
	b_some_bank2_proc2	= 2
_some_bank2_proc2:
	pha
	pha
	pha
	stx	*(REGTEMP+0)
	ldy	*(REGTEMP+0)
;	src/bank2code.c: 25: printf("some_bank2_proc2\n");
	sta	*(REGTEMP+0)
	tya
	pha
	lda	#>___str_3
	pha
	lda	#___str_3
	pha
	jsr	_printf
	pla
	pla
	sta	*(REGTEMP+0)
	pla
	tay
	lda	*(REGTEMP+0)
;	src/bank2code.c: 26: return local_bank2_proc(param1, param2 * param3);
	tsx
	lda	0x103,x
	sta	0x101,x
	lda	#0x00
	sta	0x102,x
	tya
	sta	*(REGTEMP+0)
	lda	0x109,x
	tax
	lda	*(REGTEMP+0)
	jsr	__muluchar
	sta	_local_bank2_proc_PARM_2
	stx	(_local_bank2_proc_PARM_2 + 1)
	tsx
	lda	0x102,x
	tax
	stx	*(REGTEMP+0)
	tsx
	lda	0x101,x
	php
	ldx	*(REGTEMP+0)
	plp
	jsr	_local_bank2_proc
;	src/bank2code.c: 27: }
	sta	*(REGTEMP+0)
	pla
	pla
	pla
	lda	*(REGTEMP+0)
	rts
	.area _CODE_2
___str_0:
	.ascii "  sum: %d (bank=%d)"
	.db 0x0a
	.db 0x00
___str_1:
	.ascii "some_bank2_proc0"
	.db 0x0a
	.db 0x00
___str_2:
	.ascii "some_bank2_proc1"
	.db 0x0a
	.db 0x00
___str_3:
	.ascii "some_bank2_proc2"
	.db 0x0a
	.db 0x00
	.area _XINIT
	.area _CABS    (ABS)
