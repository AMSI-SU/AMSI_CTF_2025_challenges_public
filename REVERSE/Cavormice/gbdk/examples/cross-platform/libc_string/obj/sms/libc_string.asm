;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module libc_string
	.optsdcc -mz80
	
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
	.area _CODE
;src/libc_string.c:12: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-18
	add	hl, sp
	ld	sp, hl
;src/libc_string.c:17: font_init();
	call	_font_init
;src/libc_string.c:18: ibm_font = font_load(font_ibm);
	ld	hl, #_font_ibm
	push	hl
	call	_font_load
;src/libc_string.c:19: font_set(ibm_font);
	ex	(sp),hl
	call	_font_set
;src/libc_string.c:22: printf("strlen(gbdk) -> %d\n", strlen("gbdk"));
	ld	hl, #___str_6
	ex	(sp),hl
	call	_strlen
	pop	af
	ld	bc, #___str_5+0
	push	hl
	push	bc
	call	_printf
	pop	af
	pop	af
;src/libc_string.c:24: printf("strcmp(gbdk,gbdk)\n-> %d\n", strcmp("gbdk", "gbdk"));
	ld	de, #___str_6
	ld	hl, #___str_6
	call	_strcmp
	push	de
	ld	hl, #___str_7
	push	hl
	call	_printf
	pop	af
	pop	af
;src/libc_string.c:25: printf("strcmp(gbdk,ggdk)\n-> %d\n", strcmp("gbdk", "ggdk"));
	ld	de, #___str_9
	ld	hl, #___str_6
	call	_strcmp
	push	de
	ld	hl, #___str_8
	push	hl
	call	_printf
	pop	af
	pop	af
;src/libc_string.c:26: printf("strcmp(ggdk,gbdk)\n-> %d\n", strcmp("ggdk", "gbdk"));
	ld	de, #___str_6
	ld	hl, #___str_9
	call	_strcmp
	push	de
	ld	hl, #___str_10
	push	hl
	call	_printf
	pop	af
;src/libc_string.c:27: printf("strncmp(gbdk,gbc,2)\n-> %d\n", strncmp("gbdk", "gbc", 2));
	ld	hl, #0x0002
	ex	(sp),hl
	ld	de, #___str_12
	ld	hl, #___str_6
	call	_strncmp
	push	de
	ld	hl, #___str_11
	push	hl
	call	_printf
	pop	af
	pop	af
;src/libc_string.c:30: char dst[4] = "dst";
	ld	-4 (ix), #0x64
	ld	-3 (ix), #0x73
	ld	-2 (ix), #0x74
	ld	-1 (ix), #0x00
;src/libc_string.c:31: const char* src = "src";
;src/libc_string.c:32: strcpy(dst, src);
	ld	hl, #___str_1
	push	hl
	ld	hl, #16
	add	hl, sp
	push	hl
	call	_strcpy
	pop	af
	pop	af
;src/libc_string.c:33: printf("strcpy(dst,src)\n-> %s\n", dst);
	ld	hl, #14
	add	hl, sp
	push	hl
	ld	hl, #___str_13
	push	hl
	call	_printf
	pop	af
	pop	af
;src/libc_string.c:37: char dst[4] = "dst";
	ld	-4 (ix), #0x64
	ld	-3 (ix), #0x73
	ld	-2 (ix), #0x74
	ld	-1 (ix), #0x00
;src/libc_string.c:38: const char* src = "src";
;src/libc_string.c:39: strncpy(dst, src, 2);
	ld	hl, #0x0002
	push	hl
	ld	de, #___str_1
	ld	hl, #16
	add	hl, sp
	call	_strncpy
;src/libc_string.c:40: printf("strncpy(dst,src,2)\n-> %s\n", dst);
	ld	hl, #14
	add	hl, sp
	push	hl
	ld	hl, #___str_14
	push	hl
	call	_printf
	pop	af
	pop	af
;src/libc_string.c:44: char dst[9] = "gbdk";
	ld	-18 (ix), #0x67
	ld	-17 (ix), #0x62
	ld	-16 (ix), #0x64
	ld	-15 (ix), #0x6b
	ld	-14 (ix), #0x00
	ld	-13 (ix), #0x00
	ld	-12 (ix), #0x00
	ld	-11 (ix), #0x00
	ld	-10 (ix), #0x00
;src/libc_string.c:45: char dst2[9] = "gbdk";
	ld	-9 (ix), #0x67
	ld	-8 (ix), #0x62
	ld	-7 (ix), #0x64
	ld	-6 (ix), #0x6b
	ld	-5 (ix), #0x00
	ld	-4 (ix), #0x00
	ld	-3 (ix), #0x00
	ld	-2 (ix), #0x00
	ld	-1 (ix), #0x00
;src/libc_string.c:46: printf("strcat(gbdk,2020)\n-> %s\n", strcat(dst, "2020"));
	ld	de, #___str_16
	ld	hl, #0
	add	hl, sp
	call	_strcat
	push	de
	ld	hl, #___str_15
	push	hl
	call	_printf
	pop	af
;src/libc_string.c:47: printf("strncat(gbdk,lib,2)\n-> %s\n", strncat(dst2, "lib",2));
	ld	hl, #0x0002
	ex	(sp),hl
	ld	de, #___str_18
	ld	hl, #11
	add	hl, sp
	call	_strncat
	push	de
	ld	hl, #___str_17
	push	hl
	call	_printf
;src/libc_string.c:49: }
	ld	sp,ix
	pop	ix
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
