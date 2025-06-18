;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module banks_farptr
	.optsdcc -mz80
	
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
	ld	e, #<(___bank_some_bank2_proc1)
	ld	d, #0x00
	ld	hl, #_some_bank2_proc1
	call	_to_far_ptr
	ld	(_farptr_var0), de
	ld	(_farptr_var0 + 2), hl
;src/banks_farptr.c:26: farptr_var1 = to_far_ptr(some_bank2_proc1, BANK(some_bank2_proc1));
	ld	e, #<(___bank_some_bank2_proc1)
	ld	d, #0x00
	ld	hl, #_some_bank2_proc1
	call	_to_far_ptr
	ld	(_farptr_var1), de
	ld	(_farptr_var1 + 2), hl
;src/banks_farptr.c:27: farptr_var2 = to_far_ptr(some_bank2_proc0, BANK(some_bank2_proc0));
	ld	e, #<(___bank_some_bank2_proc0)
	ld	d, #0x00
	ld	hl, #_some_bank2_proc0
	call	_to_far_ptr
	ld	(_farptr_var2), de
	ld	(_farptr_var2 + 2), hl
;src/banks_farptr.c:28: farptr_var2 = to_far_ptr(some_bank2_proc0, BANK(some_bank2_proc0));
	ld	e, #<(___bank_some_bank2_proc0)
	ld	d, #0x00
	ld	hl, #_some_bank2_proc0
	call	_to_far_ptr
	ld	(_farptr_var2), de
	ld	(_farptr_var2 + 2), hl
;src/banks_farptr.c:31: printf("FAR PTR0: %x:%x\n", (int)FAR_SEG(farptr_var0), (int)FAR_OFS(farptr_var0));
	ld	de, (#_farptr_var0 + 0)
	ld	hl, (#_farptr_var0 + 2)
	ld	bc, #___str_0+0
	push	de
	push	hl
	push	bc
	call	_printf
	pop	af
	pop	af
	pop	af
;src/banks_farptr.c:32: printf("FAR PTR1: %x:%x\n", (int)FAR_SEG(farptr_var1), (int)FAR_OFS(farptr_var1));
	ld	de, (#_farptr_var1 + 0)
	ld	hl, (#_farptr_var1 + 2)
	ld	bc, #___str_1+0
	push	de
	push	hl
	push	bc
	call	_printf
	pop	af
	pop	af
	pop	af
;src/banks_farptr.c:35: FAR_CALL(farptr_var2, void (*)(void));
	ld	de, #___call_banked_ptr
	ld	hl, #_farptr_var2
	ld	bc, #4
	ldir
	call	___call__banked
;src/banks_farptr.c:38: res = some_bank2_proc1(100, 50);
	ld	hl, #0x3264
	push	hl
	ld	e, #b_some_bank2_proc1
	ld	hl, #_some_bank2_proc1
	call	___sdcc_bcall_ehl
	pop	af
	ld	(_res), de
;src/banks_farptr.c:39: printf("CALL DIR: %d\n", res);
	ld	hl, (_res)
	push	hl
	ld	hl, #___str_2
	push	hl
	call	_printf
	pop	af
;src/banks_farptr.c:42: res = some_bank2_proc2(100, 50, 1);
	ld	hl, #0x132
	ex	(sp),hl
	ld	a, #0x64
	push	af
	inc	sp
	ld	e, #b_some_bank2_proc2
	ld	hl, #_some_bank2_proc2
	call	___sdcc_bcall_ehl
	pop	af
	inc	sp
	ld	(_res), de
;src/banks_farptr.c:43: printf("CALL DIR (RE): %d\n", res);
	ld	hl, (_res)
	push	hl
	ld	hl, #___str_3
	push	hl
	call	_printf
	pop	af
	pop	af
;src/banks_farptr.c:53: res = FAR_CALL(farptr_var1, some_bank2_proc_t, 100, 50);
	ld	de, #___call_banked_ptr
	ld	hl, #_farptr_var1
	ld	bc, #4
	ldir
	ld	bc, #___call__banked
	ld	hl, #0x3264
	push	hl
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	call	___sdcc_call_hl
	pop	af
	ld	(_res), de
;src/banks_farptr.c:56: printf("CALL IND: %d\n", res);
	ld	hl, (_res)
	push	hl
	ld	hl, #___str_4
	push	hl
	call	_printf
	pop	af
	pop	af
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
	ld	a, (_RAM_CONTROL+0)
	or	a, #0x08
	ld	(_RAM_CONTROL+0), a
;src/banks_farptr.c:61: printf("START (bank=%d)\n", (int)CURRENT_BANK);
	ld	a, (_MAP_FRAME1+0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	hl, #___str_5
	push	hl
	call	_printf
	pop	af
	pop	af
;src/banks_farptr.c:62: run();
	call	_run
;src/banks_farptr.c:63: printf("DONE! (bank=%d)\n", (int)CURRENT_BANK);
	ld	a, (_MAP_FRAME1+0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	hl, #___str_6
	push	hl
	call	_printf
	pop	af
	pop	af
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
