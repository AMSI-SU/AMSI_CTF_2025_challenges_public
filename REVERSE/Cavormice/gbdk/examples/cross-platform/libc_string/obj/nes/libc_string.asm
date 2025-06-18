;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module libc_string
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
_main_dst_20000_117:
	.ds 4
_main_dst_20000_118:
	.ds 4
_main_dst_20000_119:
	.ds 9
_main_dst2_20000_119:
	.ds 9
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
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;ibm_font                  Allocated to registers a x 
;dst                       Allocated with name '_main_dst_20000_117'
;src                       Allocated to registers 
;dst                       Allocated with name '_main_dst_20000_118'
;src                       Allocated to registers 
;dst                       Allocated with name '_main_dst_20000_119'
;dst2                      Allocated with name '_main_dst2_20000_119'
;------------------------------------------------------------
;	src/libc_string.c: 12: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/libc_string.c: 17: font_init();
	jsr	_font_init
;	src/libc_string.c: 18: ibm_font = font_load(font_ibm);
	ldx	#>_font_ibm
	lda	#_font_ibm
	jsr	_font_load
;	src/libc_string.c: 19: font_set(ibm_font);
	jsr	_font_set
;	src/libc_string.c: 22: printf("strlen(gbdk) -> %d\n", strlen("gbdk"));
	ldx	#>___str_6
	lda	#___str_6
	jsr	_strlen
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
;	src/libc_string.c: 24: printf("strcmp(gbdk,gbdk)\n-> %d\n", strcmp("gbdk", "gbdk"));
	lda	#>___str_6
	sta	(_strcmp_PARM_2 + 1)
	lda	#___str_6
	sta	_strcmp_PARM_2
	ldx	#>___str_6
	lda	#___str_6
	jsr	_strcmp
	sta	*(REGTEMP+0)
	txa
	pha
	lda	*(REGTEMP+0)
	pha
	lda	#>___str_7
	pha
	lda	#___str_7
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
;	src/libc_string.c: 25: printf("strcmp(gbdk,ggdk)\n-> %d\n", strcmp("gbdk", "ggdk"));
	lda	#>___str_9
	sta	(_strcmp_PARM_2 + 1)
	lda	#___str_9
	sta	_strcmp_PARM_2
	ldx	#>___str_6
	lda	#___str_6
	jsr	_strcmp
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
;	src/libc_string.c: 26: printf("strcmp(ggdk,gbdk)\n-> %d\n", strcmp("ggdk", "gbdk"));
	lda	#>___str_6
	sta	(_strcmp_PARM_2 + 1)
	lda	#___str_6
	sta	_strcmp_PARM_2
	ldx	#>___str_9
	lda	#___str_9
	jsr	_strcmp
	sta	*(REGTEMP+0)
	txa
	pha
	lda	*(REGTEMP+0)
	pha
	lda	#>___str_10
	pha
	lda	#___str_10
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
;	src/libc_string.c: 27: printf("strncmp(gbdk,gbc,2)\n-> %d\n", strncmp("gbdk", "gbc", 2));
	lda	#>___str_12
	sta	(_strncmp_PARM_2 + 1)
	lda	#___str_12
	sta	_strncmp_PARM_2
	ldx	#0x02
	stx	_strncmp_PARM_3
	ldx	#0x00
	stx	(_strncmp_PARM_3 + 1)
	ldx	#>___str_6
	lda	#___str_6
	jsr	_strncmp
	sta	*(REGTEMP+0)
	txa
	pha
	lda	*(REGTEMP+0)
	pha
	lda	#>___str_11
	pha
	lda	#___str_11
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
;	src/libc_string.c: 30: char dst[4] = "dst";
	ldx	#0x64
	stx	_main_dst_20000_117
	ldx	#0x73
	stx	(_main_dst_20000_117 + 0x0001)
	inx
	stx	(_main_dst_20000_117 + 0x0002)
	ldx	#0x00
	stx	(_main_dst_20000_117 + 0x0003)
;	src/libc_string.c: 31: const char* src = "src";
	lda	#>___str_1
	sta	(_strcpy_PARM_2 + 1)
	lda	#___str_1
	sta	_strcpy_PARM_2
;	src/libc_string.c: 32: strcpy(dst, src);
	ldx	#>_main_dst_20000_117
	lda	#_main_dst_20000_117
	jsr	_strcpy
;	src/libc_string.c: 33: printf("strcpy(dst,src)\n-> %s\n", dst);
	lda	#>_main_dst_20000_117
	pha
	lda	#_main_dst_20000_117
	pha
	lda	#>___str_13
	pha
	lda	#___str_13
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
;	src/libc_string.c: 37: char dst[4] = "dst";
	ldx	#0x64
	stx	_main_dst_20000_118
	ldx	#0x73
	stx	(_main_dst_20000_118 + 0x0001)
	inx
	stx	(_main_dst_20000_118 + 0x0002)
	ldx	#0x00
	stx	(_main_dst_20000_118 + 0x0003)
;	src/libc_string.c: 38: const char* src = "src";
	lda	#>___str_1
	sta	(_strncpy_PARM_2 + 1)
	lda	#___str_1
	sta	_strncpy_PARM_2
;	src/libc_string.c: 39: strncpy(dst, src, 2);
	ldx	#0x02
	stx	_strncpy_PARM_3
	ldx	#0x00
	stx	(_strncpy_PARM_3 + 1)
	ldx	#>_main_dst_20000_118
	lda	#_main_dst_20000_118
	jsr	_strncpy
;	src/libc_string.c: 40: printf("strncpy(dst,src,2)\n-> %s\n", dst);
	lda	#>_main_dst_20000_118
	pha
	lda	#_main_dst_20000_118
	pha
	lda	#>___str_14
	pha
	lda	#___str_14
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
;	src/libc_string.c: 44: char dst[9] = "gbdk";
	ldx	#0x67
	stx	_main_dst_20000_119
	ldx	#0x62
	stx	(_main_dst_20000_119 + 0x0001)
	ldx	#0x64
	stx	(_main_dst_20000_119 + 0x0002)
	ldx	#0x6b
	stx	(_main_dst_20000_119 + 0x0003)
	ldx	#0x00
	stx	(_main_dst_20000_119 + 0x0004)
	stx	(_main_dst_20000_119 + 0x0005)
	stx	(_main_dst_20000_119 + 0x0006)
	stx	(_main_dst_20000_119 + 0x0007)
	stx	(_main_dst_20000_119 + 0x0008)
;	src/libc_string.c: 45: char dst2[9] = "gbdk";
	ldx	#0x67
	stx	_main_dst2_20000_119
	ldx	#0x62
	stx	(_main_dst2_20000_119 + 0x0001)
	ldx	#0x64
	stx	(_main_dst2_20000_119 + 0x0002)
	ldx	#0x6b
	stx	(_main_dst2_20000_119 + 0x0003)
	ldx	#0x00
	stx	(_main_dst2_20000_119 + 0x0004)
	stx	(_main_dst2_20000_119 + 0x0005)
	stx	(_main_dst2_20000_119 + 0x0006)
	stx	(_main_dst2_20000_119 + 0x0007)
	stx	(_main_dst2_20000_119 + 0x0008)
;	src/libc_string.c: 46: printf("strcat(gbdk,2020)\n-> %s\n", strcat(dst, "2020"));
	lda	#>___str_16
	sta	(_strcat_PARM_2 + 1)
	lda	#___str_16
	sta	_strcat_PARM_2
	ldx	#>_main_dst_20000_119
	lda	#_main_dst_20000_119
	jsr	_strcat
	sta	*(REGTEMP+0)
	txa
	pha
	lda	*(REGTEMP+0)
	pha
	lda	#>___str_15
	pha
	lda	#___str_15
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
;	src/libc_string.c: 47: printf("strncat(gbdk,lib,2)\n-> %s\n", strncat(dst2, "lib",2));
	lda	#>___str_18
	sta	(_strncat_PARM_2 + 1)
	lda	#___str_18
	sta	_strncat_PARM_2
	ldx	#0x02
	stx	_strncat_PARM_3
	ldx	#0x00
	stx	(_strncat_PARM_3 + 1)
	ldx	#>_main_dst2_20000_119
	lda	#_main_dst2_20000_119
	jsr	_strncat
	sta	*(REGTEMP+0)
	txa
	pha
	lda	*(REGTEMP+0)
	pha
	lda	#>___str_17
	pha
	lda	#___str_17
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
;	src/libc_string.c: 49: }
	rts
	.area _CODE
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
	.area _XINIT
	.area _CABS    (ABS)
