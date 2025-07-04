;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module bank2code
	.optsdcc -mz80
	
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
	.area _CODE_2
;src/bank2code.c:7: static int local_bank2_proc(int param1, int param2) {
;	---------------------------------
; Function local_bank2_proc
; ---------------------------------
_local_bank2_proc:
;src/bank2code.c:8: printf("  sum: %d (bank=%d)\n", param1 + param2, (int)CURRENT_BANK);
	ld	a, (_MAP_FRAME1+0)
	ld	c, a
	ld	b, #0x00
	add	hl, de
	ld	de, #___str_0+0
	push	hl
	push	bc
	push	hl
	push	de
	call	_printf
	pop	af
	pop	af
	pop	af
	pop	hl
;src/bank2code.c:9: return (param1 + param2) << 1;
	add	hl, hl
	ex	de, hl
;src/bank2code.c:10: }
	ret
___str_0:
	.ascii "  sum: %d (bank=%d)"
	.db 0x0a
	.db 0x00
;src/bank2code.c:12: BANKREF(some_bank2_proc0)
;	---------------------------------
; Function __func_some_bank2_proc0
; ---------------------------------
	b___func_some_bank2_proc0	= 2
___func_some_bank2_proc0::
	.local b___func_some_bank2_proc0 
	___bank_some_bank2_proc0 = b___func_some_bank2_proc0 
	.globl ___bank_some_bank2_proc0 
;src/bank2code.c:13: void some_bank2_proc0(void) BANKED {
;	---------------------------------
; Function some_bank2_proc0
; ---------------------------------
	b_some_bank2_proc0	= 2
_some_bank2_proc0::
;src/bank2code.c:14: printf("some_bank2_proc0\n");
	ld	hl, #___str_2
;src/bank2code.c:15: }
	jp	_puts
___str_2:
	.ascii "some_bank2_proc0"
	.db 0x00
;src/bank2code.c:17: BANKREF(some_bank2_proc1)
;	---------------------------------
; Function __func_some_bank2_proc1
; ---------------------------------
	b___func_some_bank2_proc1	= 2
___func_some_bank2_proc1::
	.local b___func_some_bank2_proc1 
	___bank_some_bank2_proc1 = b___func_some_bank2_proc1 
	.globl ___bank_some_bank2_proc1 
;src/bank2code.c:18: int some_bank2_proc1(uint8_t param1, uint8_t param2) BANKED {
;	---------------------------------
; Function some_bank2_proc1
; ---------------------------------
	b_some_bank2_proc1	= 2
_some_bank2_proc1::
;src/bank2code.c:19: printf("some_bank2_proc1\n");
	ld	hl, #___str_4
	call	_puts
;src/bank2code.c:20: return local_bank2_proc(param1, param2);
	ld	iy, #6
	add	iy, sp
	ld	e, 0 (iy)
	ld	d, #0x00
	ld	l, -1 (iy)
	dec	iy
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
;src/bank2code.c:21: }
	jp	_local_bank2_proc
___str_4:
	.ascii "some_bank2_proc1"
	.db 0x00
;src/bank2code.c:23: BANKREF(some_bank2_proc2)
;	---------------------------------
; Function __func_some_bank2_proc2
; ---------------------------------
	b___func_some_bank2_proc2	= 2
___func_some_bank2_proc2::
	.local b___func_some_bank2_proc2 
	___bank_some_bank2_proc2 = b___func_some_bank2_proc2 
	.globl ___bank_some_bank2_proc2 
;src/bank2code.c:24: int some_bank2_proc2(uint8_t param1, uint8_t param2, uint8_t param3) BANKED REENTRANT {
;	---------------------------------
; Function some_bank2_proc2
; ---------------------------------
	b_some_bank2_proc2	= 2
_some_bank2_proc2::
;src/bank2code.c:25: printf("some_bank2_proc2\n");
	ld	hl, #___str_6
	call	_puts
;src/bank2code.c:26: return local_bank2_proc(param1, param2 * param3);
	ld	iy, #7
	add	iy, sp
	ld	e, 0 (iy)
	ld	h, -1 (iy)
	dec	iy
;	spillPairReg hl
;	spillPairReg hl
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00103$:
	add	hl, hl
	jr	NC, 00104$
	add	hl, de
00104$:
	djnz	00103$
	ex	de, hl
	ld	l, -1 (iy)
	dec	iy
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
;src/bank2code.c:27: }
	jp	_local_bank2_proc
___str_6:
	.ascii "some_bank2_proc2"
	.db 0x00
	.area _CODE_2
	.area _INITIALIZER
	.area _CABS (ABS)
