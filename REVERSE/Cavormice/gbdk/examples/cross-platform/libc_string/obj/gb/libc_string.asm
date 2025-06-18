;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module libc_string
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _font_set
	.globl _font_load
	.globl _font_init
	.globl _strncpy
	.globl _strncmp
	.globl _strncat
	.globl _strlen
	.globl _strcat
	.globl _strcmp
	.globl _strcpy
	.globl _printf
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
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
;src/libc_string.c:12: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-18
;src/libc_string.c:17: font_init();
	call	_font_init
;src/libc_string.c:18: ibm_font = font_load(font_ibm);
	ld	de, #_font_ibm
	push	de
	call	_font_load
	pop	hl
;src/libc_string.c:19: font_set(ibm_font);
	push	de
	call	_font_set
	pop	hl
;src/libc_string.c:22: printf("strlen(gbdk) -> %d\n", strlen("gbdk"));
	ld	de, #___str_6
	push	de
	call	_strlen
	pop	hl
	push	de
	ld	de, #___str_5
	push	de
	call	_printf
	add	sp, #4
;src/libc_string.c:24: printf("strcmp(gbdk,gbdk)\n-> %d\n", strcmp("gbdk", "gbdk"));
	ld	de, #___str_6
	push	de
	push	de
	call	_strcmp
	add	sp, #4
	push	de
	ld	de, #___str_7
	push	de
	call	_printf
	add	sp, #4
;src/libc_string.c:25: printf("strcmp(gbdk,ggdk)\n-> %d\n", strcmp("gbdk", "ggdk"));
	ld	de, #___str_9
	push	de
	ld	de, #___str_6
	push	de
	call	_strcmp
	add	sp, #4
	push	de
	ld	de, #___str_8
	push	de
	call	_printf
	add	sp, #4
;src/libc_string.c:26: printf("strcmp(ggdk,gbdk)\n-> %d\n", strcmp("ggdk", "gbdk"));
	ld	de, #___str_6
	push	de
	ld	de, #___str_9
	push	de
	call	_strcmp
	add	sp, #4
	push	de
	ld	de, #___str_10
	push	de
	call	_printf
	add	sp, #4
;src/libc_string.c:27: printf("strncmp(gbdk,gbc,2)\n-> %d\n", strncmp("gbdk", "gbc", 2));
	ld	de, #0x0002
	push	de
	ld	bc, #___str_12
	ld	de, #___str_6
	call	_strncmp
	push	bc
	ld	de, #___str_11
	push	de
	call	_printf
	add	sp, #4
;src/libc_string.c:30: char dst[4] = "dst";
	ldhl	sp,	#14
	ld	c, l
	ld	b, h
	ld	(hl), #0x64
	ldhl	sp,	#15
	ld	a, #0x73
	ld	(hl+), a
	ld	a, #0x74
	ld	(hl+), a
	ld	(hl), #0x00
;src/libc_string.c:31: const char* src = "src";
	ld	hl, #___str_1
;src/libc_string.c:32: strcpy(dst, src);
	ld	e, c
	ld	d, b
	push	hl
	push	de
	call	_strcpy
	add	sp, #4
;src/libc_string.c:33: printf("strcpy(dst,src)\n-> %s\n", dst);
	push	bc
	ld	de, #___str_13
	push	de
	call	_printf
	add	sp, #4
;src/libc_string.c:37: char dst[4] = "dst";
	ldhl	sp,	#14
	ld	a, #0x64
	ld	(hl+), a
	ld	a, #0x73
	ld	(hl+), a
	ld	a, #0x74
	ld	(hl+), a
;src/libc_string.c:38: const char* src = "src";
;src/libc_string.c:39: strncpy(dst, src, 2);
	ld	de, #0x0002
	ld	(hl), d
	push	de
	ld	bc, #___str_1
	ld	hl, #16
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_strncpy
;src/libc_string.c:40: printf("strncpy(dst,src,2)\n-> %s\n", dst);
	ld	hl, #14
	add	hl, sp
	push	hl
	ld	de, #___str_14
	push	de
	call	_printf
	add	sp, #4
;src/libc_string.c:44: char dst[9] = "gbdk";
	ldhl	sp,	#0
	ld	c, l
	ld	b, h
	ld	(hl), #0x67
	ldhl	sp,	#1
	ld	a, #0x62
	ld	(hl+), a
	ld	a, #0x64
	ld	(hl+), a
	ld	a, #0x6b
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
;src/libc_string.c:45: char dst2[9] = "gbdk";
	xor	a, a
	ld	(hl+), a
	ld	a, #0x67
	ld	(hl+), a
	ld	a, #0x62
	ld	(hl+), a
	ld	a, #0x64
	ld	(hl+), a
	ld	a, #0x6b
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/libc_string.c:46: printf("strcat(gbdk,2020)\n-> %s\n", strcat(dst, "2020"));
	ld	e, c
	ld	d, b
	ld	bc, #___str_16
	call	_strcat
	push	bc
	ld	de, #___str_15
	push	de
	call	_printf
	add	sp, #4
;src/libc_string.c:47: printf("strncat(gbdk,lib,2)\n-> %s\n", strncat(dst2, "lib",2));
	ld	de, #0x0002
	push	de
	ld	bc, #___str_18
	ld	hl, #11
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_strncat
	push	bc
	ld	de, #___str_17
	push	de
	call	_printf
;src/libc_string.c:49: }
	add	sp, #22
	ret
___str_1:
	.ascii "src"
	.db 0x00
___str_5:
	.ascii "strlen(gbdk) -> %d"
	.db 0x0a
	.db 0x00
___str_6:
	.ascii "gbdk"
	.db 0x00
___str_7:
	.ascii "strcmp(gbdk,gbdk)"
	.db 0x0a
	.ascii "-> %d"
	.db 0x0a
	.db 0x00
___str_8:
	.ascii "strcmp(gbdk,ggdk)"
	.db 0x0a
	.ascii "-> %d"
	.db 0x0a
	.db 0x00
___str_9:
	.ascii "ggdk"
	.db 0x00
___str_10:
	.ascii "strcmp(ggdk,gbdk)"
	.db 0x0a
	.ascii "-> %d"
	.db 0x0a
	.db 0x00
___str_11:
	.ascii "strncmp(gbdk,gbc,2)"
	.db 0x0a
	.ascii "-> %d"
	.db 0x0a
	.db 0x00
___str_12:
	.ascii "gbc"
	.db 0x00
___str_13:
	.ascii "strcpy(dst,src)"
	.db 0x0a
	.ascii "-> %s"
	.db 0x0a
	.db 0x00
___str_14:
	.ascii "strncpy(dst,src,2)"
	.db 0x0a
	.ascii "-> %s"
	.db 0x0a
	.db 0x00
___str_15:
	.ascii "strcat(gbdk,2020)"
	.db 0x0a
	.ascii "-> %s"
	.db 0x0a
	.db 0x00
___str_16:
	.ascii "2020"
	.db 0x00
___str_17:
	.ascii "strncat(gbdk,lib,2)"
	.db 0x0a
	.ascii "-> %s"
	.db 0x0a
	.db 0x00
___str_18:
	.ascii "lib"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
