;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module banks
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
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
	.globl _set_default_palette
	.globl _vsync
	.globl _some_const_var_0
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
;src/banks.c:17: void bank_fixed(void) NONBANKED
;	---------------------------------
; Function bank_fixed
; ---------------------------------
_bank_fixed::
;src/banks.c:19: puts("I'm in fixed ROM");
	ld	hl, #___str_0
;src/banks.c:20: }
	jp	_puts
_some_const_var_0:
	.db #0x00	; 0
___str_0:
	.ascii "I'm in fixed ROM"
	.db 0x00
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/banks.c:22: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;src/banks.c:27: set_default_palette();
	call	_set_default_palette
;src/banks.c:29: printf("Program Start...\n\n");
	ld	hl, #___str_2
	call	_puts
;src/banks.c:32: bank_fixed();
	call	_bank_fixed
;src/banks.c:34: func_1();
	ld	e, #b_func_1
	ld	hl, #_func_1
	call	___sdcc_bcall_ehl
;src/banks.c:35: func_2();
	ld	e, #b_func_2
	ld	hl, #_func_2
	call	___sdcc_bcall_ehl
;src/banks.c:36: func_3();
	ld	e, #b_func_3
	ld	hl, #_func_3
	call	___sdcc_bcall_ehl
;src/banks.c:37: func_4();
	ld	e, #b_func_4
	ld	hl, #_func_4
	call	___sdcc_bcall_ehl
;src/banks.c:39: printf("\n");
	ld	hl, #___str_4
	call	_puts
;src/banks.c:43: printf("Const0= %u nonbanked\n", some_const_var_0);
	ld	hl, #0x0000
	push	hl
	ld	hl, #___str_5
	push	hl
	call	_printf
	pop	af
	pop	af
;src/banks.c:45: SWITCH_ROM(BANK(some_const_var_1));
	ld	hl, #_MAP_FRAME1
	ld	(hl), #<(___bank_some_const_var_1)
;src/banks.c:46: printf("Const1= %u in bank %hu\n", some_const_var_1, BANK(some_const_var_1));
	ld	d, #<(___bank_some_const_var_1)
	ld	a, (_some_const_var_1+0)
	ld	c, a
	ld	b, #0x00
	push	de
	inc	sp
	push	bc
	ld	hl, #___str_6
	push	hl
	call	_printf
	pop	af
	pop	af
	inc	sp
;src/banks.c:47: SWITCH_ROM(BANK(some_const_var_2));
	ld	hl, #_MAP_FRAME1
	ld	(hl), #<(___bank_some_const_var_2)
;src/banks.c:48: printf("Const2= %u in bank %hu\n", some_const_var_2, BANK(some_const_var_2));
	ld	d, #<(___bank_some_const_var_2)
	ld	a, (_some_const_var_2+0)
	ld	c, a
	ld	b, #0x00
	push	de
	inc	sp
	push	bc
	ld	hl, #___str_7
	push	hl
	call	_printf
	pop	af
	pop	af
	inc	sp
;src/banks.c:49: SWITCH_ROM(BANK(some_const_var_3));
	ld	hl, #_MAP_FRAME1
	ld	(hl), #<(___bank_some_const_var_3)
;src/banks.c:50: printf("Const3= %u in bank %hu\n", some_const_var_3, BANK(some_const_var_3));
	ld	d, #<(___bank_some_const_var_3)
	ld	a, (_some_const_var_3+0)
	ld	c, a
	ld	b, #0x00
	push	de
	inc	sp
	push	bc
	ld	hl, #___str_8
	push	hl
	call	_printf
	pop	af
	pop	af
	inc	sp
;src/banks.c:56: _saved_bank = CURRENT_BANK;
	ld	a, (_MAP_FRAME1+0)
	ld	-1 (ix), a
;src/banks.c:59: SWITCH_ROM(BANK(some_const_var_4));
	ld	hl, #_MAP_FRAME1
	ld	(hl), #<(___bank_some_const_var_4)
;src/banks.c:60: printf("Const4= %u in bank %hu\n", some_const_var_4, BANK(some_const_var_4));
	ld	e, #<(___bank_some_const_var_4)
	ld	a, (_some_const_var_4+0)
	ld	c, a
	ld	b, #0x00
	ld	a, e
	push	af
	inc	sp
	push	bc
	ld	hl, #___str_9
	push	hl
	call	_printf
	pop	af
	pop	af
	inc	sp
;src/banks.c:63: SWITCH_ROM(_saved_bank);
	ld	a, -1 (ix)
	ld	(_MAP_FRAME1+0), a
;src/banks.c:68: puts("The End...");
	ld	hl, #___str_12
	call	_puts
;src/banks.c:71: while(1) {
00102$:
;src/banks.c:74: vsync();
	call	_vsync
	jr	00102$
;src/banks.c:76: }
	inc	sp
	pop	ix
	ret
___str_2:
	.ascii "Program Start..."
	.db 0x0a
	.db 0x00
___str_4:
	.db 0x00
___str_5:
	.ascii "Const0= %u nonbanked"
	.db 0x0a
	.db 0x00
___str_6:
	.ascii "Const1= %u in bank %hu"
	.db 0x0a
	.db 0x00
___str_7:
	.ascii "Const2= %u in bank %hu"
	.db 0x0a
	.db 0x00
___str_8:
	.ascii "Const3= %u in bank %hu"
	.db 0x0a
	.db 0x00
___str_9:
	.ascii "Const4= %u in bank %hu"
	.db 0x0a
	.db 0x00
___str_12:
	.db 0x0a
	.ascii "The End..."
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
