;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module libc_memcpy
	.optsdcc -mz80
	
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
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	push	af
	ld	-2 (ix), l
	ld	-1 (ix), h
	ld	-4 (ix), e
	ld	-3 (ix), d
;src/libc_memcpy.c:19: uint16_t start_time = sys_time;
	ld	hl, (_sys_time)
	ex	(sp), hl
;src/libc_memcpy.c:20: for(i = 0; i < num; i++)
	ld	bc, #0x0000
00103$:
	ld	a, c
	sub	a, -2 (ix)
	ld	a, b
	sbc	a, -1 (ix)
	jp	PO, 00122$
	xor	a, #0x80
00122$:
	jp	P, 00101$
;src/libc_memcpy.c:21: memcpy(memcpy_dst, memcpy_src, size);
	push	bc
	ld	l, -4 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -3 (ix)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	ld	de, #_memcpy_src
	ld	hl, #_memcpy_dst
	call	_memcpy
	pop	bc
;src/libc_memcpy.c:20: for(i = 0; i < num; i++)
	inc	bc
	jr	00103$
00101$:
;src/libc_memcpy.c:22: return (int)(sys_time - start_time);
	ld	a, (_sys_time+0)
	sub	a, -6 (ix)
	ld	e, a
	ld	a, (_sys_time+1)
	sbc	a, -5 (ix)
	ld	d, a
;src/libc_memcpy.c:23: }
	ld	sp, ix
	pop	ix
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
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;src/libc_memcpy.c:30: font_init();
	call	_font_init
;src/libc_memcpy.c:31: ibm_font = font_load(font_ibm);
	ld	hl, #_font_ibm
	push	hl
	call	_font_load
;src/libc_memcpy.c:32: font_set(ibm_font);
	ex	(sp),hl
	call	_font_set
	pop	af
;src/libc_memcpy.c:36: char dst[4] = "dst";
	ld	-4 (ix), #0x64
	ld	-3 (ix), #0x73
	ld	-2 (ix), #0x74
	ld	-1 (ix), #0x00
;src/libc_memcpy.c:37: const char* src = "src";
;src/libc_memcpy.c:38: printf("memcpy(dst,src,2)\n-> %s\n", memcpy(dst, src, 2));
	ld	hl, #0x0002
	push	hl
	ld	de, #___str_1
	ld	hl, #2
	add	hl, sp
	call	_memcpy
	push	de
	ld	hl, #___str_4
	push	hl
	call	_printf
	pop	af
	pop	af
;src/libc_memcpy.c:42: char dst[4] = "dst";
	ld	hl, #0
	add	hl, sp
	ex	de, hl
	ld	a, #0x64
	ld	(de), a
	ld	-3 (ix), #0x73
	ld	-2 (ix), #0x74
	ld	-1 (ix), #0x00
;src/libc_memcpy.c:43: const char* src = "src";
	ld	bc, #___str_1
;src/libc_memcpy.c:44: printf("memmove(dst,src,2)\n-> %s\n", memmove(dst, src, 2));
	ld	hl, #0x0002
	push	hl
	push	bc
	push	de
	call	_memmove
	pop	af
	pop	af
	pop	af
	ld	bc, #___str_5+0
	push	hl
	push	bc
	call	_printf
	pop	af
	pop	af
;src/libc_memcpy.c:48: char dst[4] = "dst";
	ld	hl, #0
	add	hl, sp
	ex	de, hl
	ld	a, #0x64
	ld	(de), a
	ld	-3 (ix), #0x73
	ld	-2 (ix), #0x74
	ld	-1 (ix), #0x00
;src/libc_memcpy.c:49: printf("memset(dst,x,2)\n-> %s\n", memset(dst, 'x', 2));
	ld	hl, #0x0002
	push	hl
	ld	l, #0x78
	push	hl
	push	de
	call	_memset
	ld	bc, #___str_6+0
	push	hl
	push	bc
	call	_printf
	pop	af
	pop	af
;src/libc_memcpy.c:52: printf("\nBenchmark memcpy:\n");
	ld	hl, #___str_8
	call	_puts
;src/libc_memcpy.c:54: printf("800*memcpy(d,s,150)\n-> %d frames\n", benchmark_memcpy(800, 150));
	ld	de, #0x0096
	ld	hl, #0x0320
	call	_benchmark_memcpy
	push	de
	ld	hl, #___str_9
	push	hl
	call	_printf
	pop	af
	pop	af
;src/libc_memcpy.c:55: printf("400*memcpy(d,s,300)\n-> %d frames\n", benchmark_memcpy(400, 300));
	ld	de, #0x012c
	ld	hl, #0x0190
	call	_benchmark_memcpy
	push	de
	ld	hl, #___str_10
	push	hl
	call	_printf
;src/libc_memcpy.c:57: }
	ld	sp,ix
	pop	ix
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
