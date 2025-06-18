;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module display_system
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
	.globl _get_system_name
	.globl _gotoxy
	.globl _font_load
	.globl _font_init
	.globl _display_on
	.globl _vsync
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
;Allocation info for local variables in function 'get_system_name'
;------------------------------------------------------------
;system                    Allocated to registers a 
;------------------------------------------------------------
;	src/display_system.c: 18: const char* get_system_name(uint8_t system)
;	-----------------------------------------
;	 function get_system_name
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_get_system_name:
;	src/display_system.c: 20: switch(system)
	cmp	#0x00
	beq	00101$
	cmp	#0x01
	beq	00102$
	jmp	00106$
;	src/display_system.c: 22: case SYSTEM_60HZ:
00101$:
;	src/display_system.c: 23: return "60 Hz";
	ldx	#>___str_0
	lda	#___str_0
	rts
;	src/display_system.c: 24: case SYSTEM_50HZ:
00102$:
;	src/display_system.c: 30: if((_SYSTEM & 0xC0) == SYSTEM_BITS_DENDY)
	lda	__SYSTEM
	and	#0xc0
	cmp	#0x80
	bne	00104$
;	src/display_system.c: 31: return "50 Hz (Dendy-like)";
	ldx	#>___str_1
	lda	#___str_1
	rts
00104$:
;	src/display_system.c: 33: return "50 Hz";
	ldx	#>___str_2
	lda	#___str_2
	rts
;	src/display_system.c: 37: default:
00106$:
;	src/display_system.c: 38: return "Unknown";
	ldx	#>___str_3
	lda	#___str_3
;	src/display_system.c: 39: }
;	src/display_system.c: 40: }
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;__200000006               Allocated to registers a 
;ibm_font                  Allocated to registers 
;system                    Allocated to registers 
;------------------------------------------------------------
;	src/display_system.c: 42: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/display_system.c: 45: uint8_t system = get_system();
	lda	__SYSTEM
	bne	00102$
	lda	#0x00
	jmp	00104$
00102$:
	lda	#0x01
00104$:
;	src/display_system.c: 47: font_init();
	pha
	jsr	_font_init
	pla
;	src/display_system.c: 48: ibm_font = font_load(font_ibm);
	pha
	ldx	#>_font_ibm
	lda	#_font_ibm
	jsr	_font_load
	pla
;	src/display_system.c: 49: DISPLAY_ON;
	pha
	jsr	_display_on
;	src/display_system.c: 50: gotoxy(4, 4);
	lda	#0x04
	tax
	jsr	_gotoxy
	pla
;	src/display_system.c: 51: printf("System: %s", get_system_name(system));
	jsr	_get_system_name
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
;	src/display_system.c: 52: vsync();
;	src/display_system.c: 53: }
	jmp	_vsync
	.area _CODE
___str_0:
	.ascii "60 Hz"
	.db 0x00
___str_1:
	.ascii "50 Hz (Dendy-like)"
	.db 0x00
___str_2:
	.ascii "50 Hz"
	.db 0x00
___str_3:
	.ascii "Unknown"
	.db 0x00
___str_4:
	.ascii "System: %s"
	.db 0x00
	.area _XINIT
	.area _CABS    (ABS)
