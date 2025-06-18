;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module snes_joypads
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
	.globl _gotoxy
	.globl _font_load
	.globl _font_init
	.globl _display_on
	.globl _vsync
	.globl _joypad_ex
	.globl _joypad_init
	.globl _printf
	.globl _putchar
	.globl _joypads
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
_main_sloc0_1_0:
	.ds 2
_main_sloc1_1_0:
	.ds 1
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
_joypads::
	.ds 5
_main_joy_40000_107:
	.ds 1
_main_joy_s_40000_107:
	.ds 1
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
;sloc0                     Allocated with name '_main_sloc0_1_0'
;sloc1                     Allocated with name '_main_sloc1_1_0'
;ibm_font                  Allocated to registers 
;i                         Allocated to registers 
;y                         Allocated to registers 
;joy                       Allocated with name '_main_joy_40000_107'
;joy_s                     Allocated with name '_main_joy_s_40000_107'
;------------------------------------------------------------
;	snes_joypads.c: 45: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	snes_joypads.c: 50: font_init();
	jsr	_font_init
;	snes_joypads.c: 51: ibm_font = font_load(font_ibm);
	ldx	#>_font_ibm
	lda	#_font_ibm
	jsr	_font_load
;	snes_joypads.c: 53: joypad_init(4, &joypads);
	lda	#>_joypads
	sta	(_joypad_init_PARM_2 + 1)
	lda	#_joypads
	sta	_joypad_init_PARM_2
	lda	#0x04
	jsr	_joypad_init
;	snes_joypads.c: 54: DISPLAY_ON;
	jsr	_display_on
;	snes_joypads.c: 55: while(TRUE)
00103$:
;	snes_joypads.c: 58: joypad_ex(&joypads);
	ldx	#>_joypads
	lda	#_joypads
	jsr	_joypad_ex
;	snes_joypads.c: 60: for(i = 0; i < 2; i++)
	ldx	#0x00
	stx	*_main_sloc0_1_0
	stx	*(_main_sloc0_1_0 + 1)
00105$:
;	snes_joypads.c: 62: int y = 4 + 2*i;
	lda	*_main_sloc0_1_0
	asl	a
	clc
	adc	#0x04
	sta	*_main_sloc1_1_0
;	snes_joypads.c: 63: uint8_t joy = joypads.joypads[i];     // Common NES/SNES bits
	ldx	*(_main_sloc0_1_0 + 1)
	lda	*_main_sloc0_1_0
	clc
	adc	#<((_joypads + 0x0001)+0)
	sta	*(DPTR+0)
	txa
	adc	#>((_joypads + 0x0001)+0)
	sta	*(DPTR+1)
	ldy	#0x00
	lda	[DPTR],y
	sta	_main_joy_40000_107
;	snes_joypads.c: 64: uint8_t joy_s = joypads.joypads[i+2]; // SNES additional bits
	lda	*_main_sloc0_1_0
	clc
	adc	#0x02
	ldx	#0x00
	tay
	lda	((_joypads + 0x0001)+0+0x0000),y
	sta	_main_joy_s_40000_107
;	snes_joypads.c: 65: gotoxy(1, y);
	lda	#0x01
	ldx	*_main_sloc1_1_0
	jsr	_gotoxy
;	snes_joypads.c: 66: printf("JOY%d: ", i);
	lda	*(_main_sloc0_1_0 + 1)
	pha
	lda	*_main_sloc0_1_0
	pha
	lda	#>___str_0
	pha
	lda	#___str_0
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
;	snes_joypads.c: 67: putchar((joy & J_LEFT)   ? 'l' : ' ');
	lda	#0x02
	and	_main_joy_40000_107
	beq	00109$
	lda	#0x6c
	jmp	00110$
00109$:
	lda	#0x20
00110$:
	jsr	_putchar
;	snes_joypads.c: 68: putchar((joy & J_RIGHT)  ? 'r' : ' ');
	lda	#0x01
	and	_main_joy_40000_107
	beq	00111$
	lda	#0x72
	jmp	00112$
00111$:
	lda	#0x20
00112$:
	jsr	_putchar
;	snes_joypads.c: 69: putchar((joy & J_UP)     ? 'u' : ' ');
	lda	#0x08
	and	_main_joy_40000_107
	beq	00113$
	lda	#0x75
	jmp	00114$
00113$:
	lda	#0x20
00114$:
	jsr	_putchar
;	snes_joypads.c: 70: putchar((joy & J_DOWN)   ? 'd' : ' ');
	lda	#0x04
	and	_main_joy_40000_107
	beq	00115$
	lda	#0x64
	jmp	00116$
00115$:
	lda	#0x20
00116$:
	jsr	_putchar
;	snes_joypads.c: 71: printf( (joy & J_SELECT) ? "SELECT " : "       ");
	lda	#0x20
	and	_main_joy_40000_107
	beq	00117$
	ldx	#>___str_1
	lda	#___str_1
	jmp	00118$
00117$:
	ldx	#>___str_2
	lda	#___str_2
00118$:
	sta	*(REGTEMP+0)
	txa
	pha
	lda	*(REGTEMP+0)
	pha
	jsr	_printf
	pla
	pla
;	snes_joypads.c: 72: printf( (joy & J_START)  ? "START "  : "      ");
	lda	#0x10
	and	_main_joy_40000_107
	beq	00119$
	ldx	#>___str_3
	lda	#___str_3
	jmp	00120$
00119$:
	ldx	#>___str_4
	lda	#___str_4
00120$:
	sta	*(REGTEMP+0)
	txa
	pha
	lda	*(REGTEMP+0)
	pha
	jsr	_printf
	pla
	pla
;	snes_joypads.c: 73: putchar((joy & JS_Y)     ? 'Y' : ' ');
	bit	_main_joy_40000_107
	bvc	00121$
	lda	#0x59
	jmp	00122$
00121$:
	lda	#0x20
00122$:
	jsr	_putchar
;	snes_joypads.c: 74: putchar((joy & JS_B)     ? 'B' : ' ');
	bit	_main_joy_40000_107
	bpl	00123$
	lda	#0x42
	jmp	00124$
00123$:
	lda	#0x20
00124$:
	jsr	_putchar
;	snes_joypads.c: 75: putchar((joy_s & JS_X)   ? 'X' : ' ');
	bit	_main_joy_s_40000_107
	bvc	00125$
	lda	#0x58
	jmp	00126$
00125$:
	lda	#0x20
00126$:
	jsr	_putchar
;	snes_joypads.c: 76: putchar((joy_s & JS_A)   ? 'A' : ' ');
	bit	_main_joy_s_40000_107
	bpl	00127$
	lda	#0x41
	jmp	00128$
00127$:
	lda	#0x20
00128$:
	jsr	_putchar
;	snes_joypads.c: 77: putchar((joy_s & JS_L)   ? 'L' : ' ');
	lda	#0x20
	and	_main_joy_s_40000_107
	beq	00129$
	lda	#0x4c
	jmp	00130$
00129$:
	lda	#0x20
00130$:
	jsr	_putchar
;	snes_joypads.c: 78: putchar((joy_s & JS_R)   ? 'R' : ' ');
	lda	#0x10
	and	_main_joy_s_40000_107
	beq	00131$
	lda	#0x52
	jmp	00132$
00131$:
	lda	#0x20
00132$:
	jsr	_putchar
;	snes_joypads.c: 60: for(i = 0; i < 2; i++)
	inc	*_main_sloc0_1_0
	bne	00244$
	inc	*(_main_sloc0_1_0 + 1)
00244$:
	lda	*_main_sloc0_1_0
	sec
	sbc	#0x02
	lda	*(_main_sloc0_1_0 + 1)
	sbc	#0x00
	bvs	00246$
	bpl	00245$
	bmi	00247$
00246$:
	bmi	00245$
00247$:
	jmp	00105$
00245$:
;	snes_joypads.c: 81: vsync();
	jsr	_vsync
	jmp	00103$
;	snes_joypads.c: 83: }
	rts
	.area _CODE
___str_0:
	.ascii "JOY%d: "
	.db 0x00
___str_1:
	.ascii "SELECT "
	.db 0x00
___str_2:
	.ascii "       "
	.db 0x00
___str_3:
	.ascii "START "
	.db 0x00
___str_4:
	.ascii "      "
	.db 0x00
	.area _XINIT
	.area _CABS    (ABS)
