;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module display_system
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _get_system_name
	.globl _gotoxy
	.globl _font_load
	.globl _font_init
	.globl _vsync
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
;src/display_system.c:18: const char* get_system_name(uint8_t system)
;	---------------------------------
; Function get_system_name
; ---------------------------------
_get_system_name::
;src/display_system.c:20: switch(system)
	or	a, a
	jr	Z, 00101$
	dec	a
	jr	Z, 00102$
	jr	00103$
;src/display_system.c:22: case SYSTEM_60HZ:
00101$:
;src/display_system.c:23: return "60 Hz";
	ld	bc, #___str_0
	ret
;src/display_system.c:24: case SYSTEM_50HZ:
00102$:
;src/display_system.c:35: return "50 Hz";
	ld	bc, #___str_1
	ret
;src/display_system.c:37: default:
00103$:
;src/display_system.c:38: return "Unknown";
	ld	bc, #___str_2
;src/display_system.c:39: }
;src/display_system.c:40: }
	ret
___str_0:
	.ascii "60 Hz"
	.db 0x00
___str_1:
	.ascii "50 Hz"
	.db 0x00
___str_2:
	.ascii "Unknown"
	.db 0x00
;src/display_system.c:42: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/display_system.c:47: font_init();
	call	_font_init
;src/display_system.c:48: ibm_font = font_load(font_ibm);
	ld	de, #_font_ibm
	push	de
	call	_font_load
	pop	hl
;src/display_system.c:49: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/display_system.c:50: gotoxy(4, 4);
	ld	hl, #0x404
	push	hl
	call	_gotoxy
	pop	hl
;src/display_system.c:51: printf("System: %s", get_system_name(system));
	xor	a, a
	call	_get_system_name
	push	bc
	ld	de, #___str_3
	push	de
	call	_printf
	add	sp, #4
;src/display_system.c:52: vsync();
;src/display_system.c:53: }
	jp	_vsync
___str_3:
	.ascii "System: %s"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
