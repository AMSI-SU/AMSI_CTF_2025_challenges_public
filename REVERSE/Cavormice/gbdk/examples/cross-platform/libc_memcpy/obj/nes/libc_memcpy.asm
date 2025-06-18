;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module libc_memcpy
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
	.globl _memcpy_src
	.globl _main
	.globl _benchmark_memcpy
	.globl _font_set
	.globl _font_load
	.globl _font_init
	.globl _memset
	.globl _memmove
	.globl ___memcpy
	.globl _printf
	.globl _benchmark_memcpy_PARM_2
	.globl _memcpy_dst
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
_benchmark_memcpy_sloc0_1_0:
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
_memcpy_dst::
	.ds 300
_benchmark_memcpy_PARM_2:
	.ds 2
_benchmark_memcpy_num_10000_115:
	.ds 2
_benchmark_memcpy_start_time_10000_116:
	.ds 2
_main_dst_20000_120:
	.ds 4
_main_dst_20000_121:
	.ds 4
_main_dst_20000_122:
	.ds 4
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
;Allocation info for local variables in function 'benchmark_memcpy'
;------------------------------------------------------------
;sloc0                     Allocated with name '_benchmark_memcpy_sloc0_1_0'
;size                      Allocated with name '_benchmark_memcpy_PARM_2'
;num                       Allocated with name '_benchmark_memcpy_num_10000_115'
;i                         Allocated to registers 
;start_time                Allocated with name '_benchmark_memcpy_start_time_10000_116'
;------------------------------------------------------------
;	src/libc_memcpy.c: 16: int benchmark_memcpy(int num, int size)
;	-----------------------------------------
;	 function benchmark_memcpy
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_benchmark_memcpy:
	sta	_benchmark_memcpy_num_10000_115
	stx	(_benchmark_memcpy_num_10000_115 + 1)
;	src/libc_memcpy.c: 19: uint16_t start_time = sys_time;
	lda	(_sys_time + 1)
	sta	(_benchmark_memcpy_start_time_10000_116 + 1)
	lda	_sys_time
	sta	_benchmark_memcpy_start_time_10000_116
;	src/libc_memcpy.c: 20: for(i = 0; i < num; i++)
	ldx	#0x00
	stx	*_benchmark_memcpy_sloc0_1_0
	stx	*(_benchmark_memcpy_sloc0_1_0 + 1)
00103$:
	lda	*_benchmark_memcpy_sloc0_1_0
	sec
	sbc	_benchmark_memcpy_num_10000_115
	lda	*(_benchmark_memcpy_sloc0_1_0 + 1)
	sbc	(_benchmark_memcpy_num_10000_115 + 1)
	bvc	00121$
	bpl	00120$
	bmi	00101$
00121$:
	bpl	00101$
00120$:
;	src/libc_memcpy.c: 21: memcpy(memcpy_dst, memcpy_src, size);
	lda	#>_memcpy_src
	sta	(___memcpy_PARM_2 + 1)
	lda	#_memcpy_src
	sta	___memcpy_PARM_2
	lda	(_benchmark_memcpy_PARM_2 + 1)
	sta	(___memcpy_PARM_3 + 1)
	lda	_benchmark_memcpy_PARM_2
	sta	___memcpy_PARM_3
	ldx	#>_memcpy_dst
	lda	#_memcpy_dst
	jsr	___memcpy
;	src/libc_memcpy.c: 20: for(i = 0; i < num; i++)
	inc	*_benchmark_memcpy_sloc0_1_0
	bne	00103$
	inc	*(_benchmark_memcpy_sloc0_1_0 + 1)
	jmp	00103$
00101$:
;	src/libc_memcpy.c: 22: return (int)(sys_time - start_time);
	lda	_sys_time
	sec
	sbc	_benchmark_memcpy_start_time_10000_116
	pha
	lda	(_sys_time + 1)
	sbc	(_benchmark_memcpy_start_time_10000_116 + 1)
	tax
	pla
;	src/libc_memcpy.c: 23: }
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;ibm_font                  Allocated to registers a x 
;dst                       Allocated with name '_main_dst_20000_120'
;src                       Allocated to registers 
;dst                       Allocated with name '_main_dst_20000_121'
;src                       Allocated to registers 
;dst                       Allocated with name '_main_dst_20000_122'
;------------------------------------------------------------
;	src/libc_memcpy.c: 25: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/libc_memcpy.c: 30: font_init();
	jsr	_font_init
;	src/libc_memcpy.c: 31: ibm_font = font_load(font_ibm);
	ldx	#>_font_ibm
	lda	#_font_ibm
	jsr	_font_load
;	src/libc_memcpy.c: 32: font_set(ibm_font);
	jsr	_font_set
;	src/libc_memcpy.c: 36: char dst[4] = "dst";
	ldx	#0x64
	stx	_main_dst_20000_120
	ldx	#0x73
	stx	(_main_dst_20000_120 + 0x0001)
	inx
	stx	(_main_dst_20000_120 + 0x0002)
	ldx	#0x00
	stx	(_main_dst_20000_120 + 0x0003)
;	src/libc_memcpy.c: 37: const char* src = "src";
;	src/libc_memcpy.c: 38: printf("memcpy(dst,src,2)\n-> %s\n", memcpy(dst, src, 2));
	lda	#>___str_1
	sta	(___memcpy_PARM_2 + 1)
	lda	#___str_1
	sta	___memcpy_PARM_2
	ldx	#0x02
	stx	___memcpy_PARM_3
	ldx	#0x00
	stx	(___memcpy_PARM_3 + 1)
	ldx	#>_main_dst_20000_120
	lda	#_main_dst_20000_120
	jsr	___memcpy
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
;	src/libc_memcpy.c: 42: char dst[4] = "dst";
	ldx	#0x64
	stx	_main_dst_20000_121
	ldx	#0x73
	stx	(_main_dst_20000_121 + 0x0001)
	inx
	stx	(_main_dst_20000_121 + 0x0002)
	ldx	#0x00
	stx	(_main_dst_20000_121 + 0x0003)
;	src/libc_memcpy.c: 43: const char* src = "src";
;	src/libc_memcpy.c: 44: printf("memmove(dst,src,2)\n-> %s\n", memmove(dst, src, 2));
	lda	#>___str_1
	sta	(_memmove_PARM_2 + 1)
	lda	#___str_1
	sta	_memmove_PARM_2
	ldx	#0x02
	stx	_memmove_PARM_3
	ldx	#0x00
	stx	(_memmove_PARM_3 + 1)
	ldx	#>_main_dst_20000_121
	lda	#_main_dst_20000_121
	jsr	_memmove
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
;	src/libc_memcpy.c: 48: char dst[4] = "dst";
	ldx	#0x64
	stx	_main_dst_20000_122
	ldx	#0x73
	stx	(_main_dst_20000_122 + 0x0001)
	inx
	stx	(_main_dst_20000_122 + 0x0002)
	ldx	#0x00
	stx	(_main_dst_20000_122 + 0x0003)
;	src/libc_memcpy.c: 49: printf("memset(dst,x,2)\n-> %s\n", memset(dst, 'x', 2));
	ldx	#0x78
	stx	_memset_PARM_2
	ldx	#0x00
	stx	(_memset_PARM_2 + 1)
	ldx	#0x02
	stx	_memset_PARM_3
	ldx	#0x00
	stx	(_memset_PARM_3 + 1)
	ldx	#>_main_dst_20000_122
	lda	#_main_dst_20000_122
	jsr	_memset
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
;	src/libc_memcpy.c: 52: printf("\nBenchmark memcpy:\n");
	lda	#>___str_7
	pha
	lda	#___str_7
	pha
	jsr	_printf
	pla
	pla
;	src/libc_memcpy.c: 54: printf("800*memcpy(d,s,150)\n-> %d frames\n", benchmark_memcpy(800, 150));
	ldx	#0x96
	stx	_benchmark_memcpy_PARM_2
	ldx	#0x00
	stx	(_benchmark_memcpy_PARM_2 + 1)
	ldx	#0x03
	lda	#0x20
	jsr	_benchmark_memcpy
	sta	*(REGTEMP+0)
	txa
	pha
	lda	*(REGTEMP+0)
	pha
	lda	#>___str_8
	pha
	lda	#___str_8
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
;	src/libc_memcpy.c: 55: printf("400*memcpy(d,s,300)\n-> %d frames\n", benchmark_memcpy(400, 300));
	ldx	#0x2c
	stx	_benchmark_memcpy_PARM_2
	ldx	#0x01
	stx	(_benchmark_memcpy_PARM_2 + 1)
	lda	#0x90
	jsr	_benchmark_memcpy
	sta	*(REGTEMP+0)
	txa
	pha
	lda	*(REGTEMP+0)
	pha
	lda	#>___str_9
	pha
	lda	#___str_9
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
;	src/libc_memcpy.c: 57: }
	rts
	.area _CODE
_memcpy_src:
	.db #0x00	; 0
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
___str_1:
	.ascii "src"
	.db 0x00
___str_4:
	.ascii "memcpy(dst,src,2)"
	.db 0x0a
	.ascii "-> %s"
	.db 0x0a
	.db 0x00
___str_5:
	.ascii "memmove(dst,src,2)"
	.db 0x0a
	.ascii "-> %s"
	.db 0x0a
	.db 0x00
___str_6:
	.ascii "memset(dst,x,2)"
	.db 0x0a
	.ascii "-> %s"
	.db 0x0a
	.db 0x00
___str_7:
	.db 0x0a
	.ascii "Benchmark memcpy:"
	.db 0x0a
	.db 0x00
___str_8:
	.ascii "800*memcpy(d,s,150)"
	.db 0x0a
	.ascii "-> %d frames"
	.db 0x0a
	.db 0x00
___str_9:
	.ascii "400*memcpy(d,s,300)"
	.db 0x0a
	.ascii "-> %d frames"
	.db 0x0a
	.db 0x00
	.area _XINIT
	.area _CABS    (ABS)
