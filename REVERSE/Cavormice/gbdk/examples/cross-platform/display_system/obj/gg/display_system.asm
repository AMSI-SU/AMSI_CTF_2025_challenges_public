;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module display_system
	.optsdcc -mz80
	
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
	ld	de, #___str_0
	ret
;src/display_system.c:24: case SYSTEM_50HZ:
00102$:
;src/display_system.c:35: return "50 Hz";
	ld	de, #___str_1
	ret
;src/display_system.c:37: default:
00103$:
;src/display_system.c:38: return "Unknown";
	ld	de, #___str_2
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
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;src/display_system.c:45: uint8_t system = get_system();
	ld	a, (__SYSTEM+0)
	ld	-1 (ix), a
;src/display_system.c:47: font_init();
	call	_font_init
;src/display_system.c:48: ibm_font = font_load(font_ibm);
	ld	hl, #_font_ibm
	push	hl
	call	_font_load
	pop	af
;src/display_system.c:49: DISPLAY_ON;
	ld	a, (_shadow_VDP_R1+0)
	or	a, #0x40
	ld	(_shadow_VDP_R1+0), a
	di
	ld	a, (_shadow_VDP_R1+0)
	out	(_VDP_CMD), a
	ld	a, #0x81
	out	(_VDP_CMD), a
	ei
;src/display_system.c:50: gotoxy(4, 4);
	ld	hl, #0x404
	push	hl
	call	_gotoxy
	pop	af
;src/display_system.c:51: printf("System: %s", get_system_name(system));
	ld	a, -1 (ix)
	call	_get_system_name
	push	de
	ld	hl, #___str_3
	push	hl
	call	_printf
	pop	af
	pop	af
;src/display_system.c:52: vsync();
	call	_vsync
;src/display_system.c:53: }
	inc	sp
	pop	ix
	ret
___str_3:
	.ascii "System: %s"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
