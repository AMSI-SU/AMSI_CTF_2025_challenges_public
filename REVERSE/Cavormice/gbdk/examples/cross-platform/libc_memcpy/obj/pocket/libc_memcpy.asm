;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module libc_memcpy
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _benchmark_memcpy
	.globl _font_set
	.globl _font_load
	.globl _font_init
	.globl _memset
	.globl _memmove
	.globl _memcpy
	.globl _puts
	.globl _printf
	.globl _memcpy_dst
	.globl _memcpy_src
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_memcpy_dst::
	.ds 300
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
;src/libc_memcpy.c:16: int benchmark_memcpy(int num, int size)
;	---------------------------------
; Function benchmark_memcpy
; ---------------------------------
_benchmark_memcpy::
	add	sp, #-8
	ldhl	sp,	#4
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/libc_memcpy.c:19: uint16_t start_time = sys_time;
	ld	a, (#_sys_time)
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (#_sys_time + 1)
	ldhl	sp,	#1
	ld	(hl), a
;src/libc_memcpy.c:20: for(i = 0; i < num; i++)
	xor	a, a
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), a
00103$:
	ldhl	sp,	#6
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00122$
	bit	7, d
	jr	NZ, 00123$
	cp	a, a
	jr	00123$
00122$:
	bit	7, d
	jr	Z, 00123$
	scf
00123$:
	jr	NC, 00101$
;src/libc_memcpy.c:21: memcpy(memcpy_dst, memcpy_src, size);
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	bc, #_memcpy_src
	ld	de, #_memcpy_dst
	call	_memcpy
;src/libc_memcpy.c:20: for(i = 0; i < num; i++)
	ldhl	sp,	#6
	inc	(hl)
	jr	NZ, 00103$
	inc	hl
	inc	(hl)
	jr	00103$
00101$:
;src/libc_memcpy.c:22: return (int)(sys_time - start_time);
	ld	hl, #_sys_time
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	pop	hl
	push	hl
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	b, a
	ld	c, e
;src/libc_memcpy.c:23: }
	add	sp, #8
	ret
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
;src/libc_memcpy.c:25: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-4
;src/libc_memcpy.c:30: font_init();
	call	_font_init
;src/libc_memcpy.c:31: ibm_font = font_load(font_ibm);
	ld	de, #_font_ibm
	push	de
	call	_font_load
	pop	hl
;src/libc_memcpy.c:32: font_set(ibm_font);
	push	de
	call	_font_set
	pop	hl
;src/libc_memcpy.c:36: char dst[4] = "dst";
	ldhl	sp,	#0
	ld	c, l
	ld	b, h
	ld	(hl), #0x64
	ldhl	sp,	#1
	ld	a, #0x73
	ld	(hl+), a
	ld	a, #0x74
	ld	(hl+), a
	ld	(hl), #0x00
;src/libc_memcpy.c:37: const char* src = "src";
;src/libc_memcpy.c:38: printf("memcpy(dst,src,2)\n-> %s\n", memcpy(dst, src, 2));
	ld	e, c
	ld	d, b
	ld	bc, #0x0002
	push	bc
	ld	bc, #___str_1
	call	_memcpy
	push	bc
	ld	de, #___str_4
	push	de
	call	_printf
	add	sp, #4
;src/libc_memcpy.c:42: char dst[4] = "dst";
	ldhl	sp,	#0
	ld	c, l
	ld	b, h
	ld	(hl), #0x64
	ldhl	sp,	#1
	ld	a, #0x73
	ld	(hl+), a
	ld	a, #0x74
	ld	(hl+), a
	ld	(hl), #0x00
;src/libc_memcpy.c:43: const char* src = "src";
;src/libc_memcpy.c:44: printf("memmove(dst,src,2)\n-> %s\n", memmove(dst, src, 2));
	ld	e, c
	ld	d, b
	ld	bc, #0x0002
	push	bc
	ld	bc, #___str_1
	call	_memmove
	push	bc
	ld	de, #___str_5
	push	de
	call	_printf
	add	sp, #4
;src/libc_memcpy.c:48: char dst[4] = "dst";
	ldhl	sp,	#0
	ld	c, l
	ld	b, h
	ld	(hl), #0x64
	ldhl	sp,	#1
	ld	a, #0x73
	ld	(hl+), a
	ld	a, #0x74
	ld	(hl+), a
;src/libc_memcpy.c:49: printf("memset(dst,x,2)\n-> %s\n", memset(dst, 'x', 2));
	ld	de, #0x0002
	ld	(hl), d
	push	de
	ld	de, #0x0078
	push	de
	push	bc
	call	_memset
	add	sp, #6
	push	de
	ld	de, #___str_6
	push	de
	call	_printf
	add	sp, #4
;src/libc_memcpy.c:52: printf("\nBenchmark memcpy:\n");
	ld	de, #___str_8
	call	_puts
;src/libc_memcpy.c:54: printf("800*memcpy(d,s,150)\n-> %d frames\n", benchmark_memcpy(800, 150));
	ld	bc, #0x0096
	ld	de, #0x0320
	call	_benchmark_memcpy
	push	bc
	ld	de, #___str_9
	push	de
	call	_printf
	add	sp, #4
;src/libc_memcpy.c:55: printf("400*memcpy(d,s,300)\n-> %d frames\n", benchmark_memcpy(400, 300));
	ld	bc, #0x012c
	ld	de, #0x0190
	call	_benchmark_memcpy
	push	bc
	ld	de, #___str_10
	push	de
	call	_printf
;src/libc_memcpy.c:57: }
	add	sp, #8
	ret
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
___str_8:
	.db 0x0a
	.ascii "Benchmark memcpy:"
	.db 0x00
___str_9:
	.ascii "800*memcpy(d,s,150)"
	.db 0x0a
	.ascii "-> %d frames"
	.db 0x0a
	.db 0x00
___str_10:
	.ascii "400*memcpy(d,s,300)"
	.db 0x0a
	.ascii "-> %d frames"
	.db 0x0a
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
