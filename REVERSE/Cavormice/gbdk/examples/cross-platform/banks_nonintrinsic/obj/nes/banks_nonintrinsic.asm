;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module banks_nonintrinsic
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
	.globl _hello_code
	.globl _main
	.globl _set_RAM_bank1
	.globl _set_RAM_bank0
	.globl _set_ROM_bank2
	.globl _set_ROM_bank1
	.globl _printf
	.globl _putchar
	.globl __switch_prg0
	.globl _add_num_wram
	.globl _data
	.globl __current_ram_bank
	.globl ___dummy_variable
	.globl _OAMDMA
	.globl _PPUDATA
	.globl _PPUADDR
	.globl _PPUSCROLL
	.globl _OAMDATA
	.globl _OAMADDR
	.globl _PPUSTATUS
	.globl _PPUMASK
	.globl _PPUCTRL
	.globl _add_num__ptr
	.globl _hello_rom_1
	.globl _hello_rom_2
	.globl _add_num_sram_0
	.globl _hello_sram_0
	.globl _add_num_sram_1b
	.globl _add_num_sram_1a
	.globl _hello_sram_1
;--------------------------------------------------------
; ZP ram data
;--------------------------------------------------------
	.area _ZP      (PAG)
_main_sloc0_1_0:
	.ds 1
_main_sloc1_1_0:
	.ds 2
_main_sloc2_1_0:
	.ds 1
_main_sloc3_1_0:
	.ds 2
;--------------------------------------------------------
; DATA_1 ram data
;--------------------------------------------------------
	.area _DATA_1
_hello_sram_1::
	.ds 20
_add_num_sram_1a::
	.ds 2
_add_num_sram_1b::
	.ds 2
;--------------------------------------------------------
; DATA_0 ram data
;--------------------------------------------------------
	.area _DATA_0
_hello_sram_0::
	.ds 20
_add_num_sram_0::
	.ds 2
;--------------------------------------------------------
; CODE_2 rom data
;--------------------------------------------------------
	.area _CODE_2
_hello_rom_2:
	.ascii "hello from CODE_2"
	.db 0x0a
	.db 0x00
;--------------------------------------------------------
; CODE_1 rom data
;--------------------------------------------------------
	.area _CODE_1
_hello_rom_1:
	.ascii "hello from CODE_1"
	.db 0x0a
	.db 0x00
_add_num__ptr:
	.dw _add_num_sram_1a
	.dw _add_num_sram_1b
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
___dummy_variable::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS    (ABS)
;--------------------------------------------------------
; initialized external ram data
;--------------------------------------------------------
	.area _DATA
__current_ram_bank::
	.ds 1
_data::
	.ds 20
_add_num_wram::
	.ds 2
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
;	src/banks_nonintrinsic.c: 21: void set_ROM_bank1(void) NONBANKED { SWITCH_ROM(1); }
;	-----------------------------------------
;	 function set_ROM_bank1
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_set_ROM_bank1:
	lda	#0x01
	jmp	__switch_prg0
;	src/banks_nonintrinsic.c: 22: void set_ROM_bank2(void) NONBANKED { SWITCH_ROM(2); }
;	-----------------------------------------
;	 function set_ROM_bank2
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_set_ROM_bank2:
	lda	#0x02
	jmp	__switch_prg0
;	src/banks_nonintrinsic.c: 31: void set_RAM_bank0(void) NONBANKED { SWITCH_RAM_BANK(0); }
;	-----------------------------------------
;	 function set_RAM_bank0
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_set_RAM_bank0:
	ldx	#0x00
	stx	__current_ram_bank
	rts
;	src/banks_nonintrinsic.c: 32: void set_RAM_bank1(void) NONBANKED { SWITCH_RAM_BANK(1); }
;	-----------------------------------------
;	 function set_RAM_bank1
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_set_RAM_bank1:
	ldx	#0x01
	stx	__current_ram_bank
	rts
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;------------------------------------------------------------
;Allocation info for local variables in function 'set_ROM_bank1'
;------------------------------------------------------------
;------------------------------------------------------------
;Allocation info for local variables in function 'set_ROM_bank2'
;------------------------------------------------------------
;------------------------------------------------------------
;Allocation info for local variables in function 'set_RAM_bank0'
;------------------------------------------------------------
;------------------------------------------------------------
;Allocation info for local variables in function 'set_RAM_bank1'
;------------------------------------------------------------
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;sloc0                     Allocated with name '_main_sloc0_1_0'
;sloc1                     Allocated with name '_main_sloc1_1_0'
;sloc2                     Allocated with name '_main_sloc2_1_0'
;sloc3                     Allocated with name '_main_sloc3_1_0'
;i                         Allocated to registers 
;i                         Allocated to registers 
;i                         Allocated to registers 
;i                         Allocated to registers 
;i                         Allocated to registers 
;i                         Allocated to registers 
;i                         Allocated to registers 
;i                         Allocated to registers 
;i                         Allocated to registers 
;i                         Allocated to registers 
;i                         Allocated to registers 
;i                         Allocated to registers 
;i                         Allocated to registers 
;i                         Allocated to registers 
;------------------------------------------------------------
;	src/banks_nonintrinsic.c: 50: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/banks_nonintrinsic.c: 53: add_num_sram_0 = 2;
	jsr	_set_RAM_bank0
	ldx	#0x02
	stx	_add_num_sram_0
	ldx	#0x00
	stx	(_add_num_sram_0 + 1)
;	src/banks_nonintrinsic.c: 54: add_num_sram_1a = 4;
	jsr	_set_RAM_bank1
	ldx	#0x04
	stx	_add_num_sram_1a
	ldx	#0x00
	stx	(_add_num_sram_1a + 1)
;	src/banks_nonintrinsic.c: 55: add_num_sram_1b = 8;
	ldx	#0x08
	stx	_add_num_sram_1b
	ldx	#0x00
	stx	(_add_num_sram_1b + 1)
;	src/banks_nonintrinsic.c: 58: for (int8_t i = 0; (hello_code[i]); i++) putchar(hello_code[i]);
	stx	*_main_sloc0_1_0
00119$:
	ldx	#0x00
	lda	*_main_sloc0_1_0
	bpl	00350$
	dex
00350$:
	clc
	adc	#<(_hello_code+0)
	sta	*(DPTR+0)
	txa
	adc	#>(_hello_code+0)
	sta	*(DPTR+1)
	ldy	#0x00
	lda	[DPTR],y
	beq	00101$
	jsr	_putchar
	inc	*_main_sloc0_1_0
	jmp	00119$
00101$:
;	src/banks_nonintrinsic.c: 59: for (int8_t i = 0; (hello_rom_1[i]); i++) putchar(hello_rom_1[i]);
	ldx	#0x00
	stx	*_main_sloc0_1_0
00122$:
	ldx	#0x00
	lda	*_main_sloc0_1_0
	bpl	00353$
	dex
00353$:
	pha
	sta	*(REGTEMP+0)
	txa
	pha
	lda	*(REGTEMP+0)
	jsr	_set_ROM_bank1
	pla
	tax
	pla
	clc
	adc	#<(_hello_rom_1+0)
	sta	*(DPTR+0)
	txa
	adc	#>(_hello_rom_1+0)
	sta	*(DPTR+1)
	ldy	#0x00
	lda	[DPTR],y
	beq	00102$
	jsr	_putchar
	inc	*_main_sloc0_1_0
	jmp	00122$
00102$:
;	src/banks_nonintrinsic.c: 60: for (int8_t i = 0; (hello_rom_2[i]); i++) putchar(hello_rom_2[i]);
	ldx	#0x00
	stx	*_main_sloc0_1_0
00125$:
	ldx	#0x00
	lda	*_main_sloc0_1_0
	bpl	00356$
	dex
00356$:
	pha
	sta	*(REGTEMP+0)
	txa
	pha
	lda	*(REGTEMP+0)
	jsr	_set_ROM_bank2
	pla
	tax
	pla
	clc
	adc	#<(_hello_rom_2+0)
	sta	*(DPTR+0)
	txa
	adc	#>(_hello_rom_2+0)
	sta	*(DPTR+1)
	ldy	#0x00
	lda	[DPTR],y
	beq	00103$
	jsr	_putchar
	inc	*_main_sloc0_1_0
	jmp	00125$
00103$:
;	src/banks_nonintrinsic.c: 63: for (int8_t i = 0; (i < sizeof(hello_rom_1)); i++) hello_sram_0[i] = hello_rom_1[i];
	ldx	#0x00
	stx	*_main_sloc0_1_0
00128$:
	lda	*_main_sloc0_1_0
	sec
	sbc	#0x13
	bvc	00361$
	bpl	00359$
	bmi	00362$
00361$:
	bmi	00359$
00362$:
	lda	#0x00
	jmp	00360$
00359$:
	lda	#0x01
00360$:
	pha
	jsr	_set_ROM_bank1
	pla
	beq	00104$
	ldx	#0x00
	lda	*_main_sloc0_1_0
	bpl	00365$
	dex
00365$:
	sta	*_main_sloc1_1_0
	stx	*(_main_sloc1_1_0 + 1)
	clc
	adc	#<(_hello_rom_1+0)
	sta	*(DPTR+0)
	txa
	adc	#>(_hello_rom_1+0)
	sta	*(DPTR+1)
	ldy	#0x00
	lda	[DPTR],y
	sta	*_main_sloc2_1_0
	jsr	_set_RAM_bank0
	clc
	lda	*_main_sloc1_1_0
	adc	#<(_hello_sram_0+0)
	sta	*(DPTR+0)
	lda	*(_main_sloc1_1_0 + 1)
	adc	#>(_hello_sram_0+0)
	sta	*(DPTR+1)
	lda	*_main_sloc2_1_0
	ldy	#0x00
	sta	[DPTR],y
	inc	*_main_sloc0_1_0
	jmp	00128$
00104$:
;	src/banks_nonintrinsic.c: 64: for (int8_t i = 0; (i < 4); i++) hello_sram_0[i + 11] = data[i];
	ldx	#0x00
	stx	*_main_sloc2_1_0
	jsr	_set_RAM_bank0
00131$:
	lda	*_main_sloc2_1_0
	sec
	sbc	#0x04
	bvc	00367$
	bpl	00366$
	bmi	00105$
00367$:
	bpl	00105$
00366$:
	lda	*_main_sloc2_1_0
	clc
	adc	#0x0b
	ldx	#0x00
	cmp	#0x00
	bpl	00369$
	dex
00369$:
	sta	*_main_sloc1_1_0
	stx	*(_main_sloc1_1_0 + 1)
	ldx	#0x00
	lda	*_main_sloc2_1_0
	bpl	00370$
	dex
00370$:
	clc
	adc	#<(_data+0)
	sta	*(DPTR+0)
	txa
	adc	#>(_data+0)
	sta	*(DPTR+1)
	ldy	#0x00
	lda	[DPTR],y
	sta	*(REGTEMP+0)
	clc
	lda	*_main_sloc1_1_0
	adc	#<(_hello_sram_0+0)
	sta	*(DPTR+0)
	lda	*(_main_sloc1_1_0 + 1)
	adc	#>(_hello_sram_0+0)
	sta	*(DPTR+1)
	lda	*(REGTEMP+0)
	sta	[DPTR],y
	inc	*_main_sloc2_1_0
	jmp	00131$
00105$:
;	src/banks_nonintrinsic.c: 65: for (int8_t i = 0; (hello_sram_0[i]); i++) putchar(hello_sram_0[i]);
	ldx	#0x00
	stx	*_main_sloc2_1_0
00134$:
	ldx	#0x00
	lda	*_main_sloc2_1_0
	bpl	00371$
	dex
00371$:
	clc
	adc	#<(_hello_sram_0+0)
	sta	*(DPTR+0)
	txa
	adc	#>(_hello_sram_0+0)
	sta	*(DPTR+1)
	ldy	#0x00
	lda	[DPTR],y
	beq	00106$
	jsr	_putchar
	jsr	_set_RAM_bank0
	inc	*_main_sloc2_1_0
	jmp	00134$
00106$:
;	src/banks_nonintrinsic.c: 68: for (int8_t i = 0; (i < sizeof(hello_rom_2)); i++) hello_sram_1[i] = hello_rom_2[i];
	ldx	#0x00
	stx	*_main_sloc2_1_0
00137$:
	lda	*_main_sloc2_1_0
	sec
	sbc	#0x13
	bvc	00376$
	bpl	00374$
	bmi	00377$
00376$:
	bmi	00374$
00377$:
	lda	#0x00
	jmp	00375$
00374$:
	lda	#0x01
00375$:
	pha
	jsr	_set_ROM_bank2
	pla
	beq	00107$
	ldx	#0x00
	lda	*_main_sloc2_1_0
	bpl	00380$
	dex
00380$:
	sta	*_main_sloc1_1_0
	stx	*(_main_sloc1_1_0 + 1)
	clc
	adc	#<(_hello_rom_2+0)
	sta	*(DPTR+0)
	txa
	adc	#>(_hello_rom_2+0)
	sta	*(DPTR+1)
	ldy	#0x00
	lda	[DPTR],y
	sta	*_main_sloc0_1_0
	jsr	_set_RAM_bank1
	clc
	lda	*_main_sloc1_1_0
	adc	#<(_hello_sram_1+0)
	sta	*(DPTR+0)
	lda	*(_main_sloc1_1_0 + 1)
	adc	#>(_hello_sram_1+0)
	sta	*(DPTR+1)
	lda	*_main_sloc0_1_0
	ldy	#0x00
	sta	[DPTR],y
	inc	*_main_sloc2_1_0
	jmp	00137$
00107$:
;	src/banks_nonintrinsic.c: 69: for (int8_t i = 0; (i < 4); i++) hello_sram_1[i + 11] = data[i];
	ldx	#0x00
	stx	*_main_sloc2_1_0
	jsr	_set_RAM_bank1
00140$:
	lda	*_main_sloc2_1_0
	sec
	sbc	#0x04
	bvc	00382$
	bpl	00381$
	bmi	00108$
00382$:
	bpl	00108$
00381$:
	lda	*_main_sloc2_1_0
	clc
	adc	#0x0b
	ldx	#0x00
	cmp	#0x00
	bpl	00384$
	dex
00384$:
	sta	*_main_sloc1_1_0
	stx	*(_main_sloc1_1_0 + 1)
	ldx	#0x00
	lda	*_main_sloc2_1_0
	bpl	00385$
	dex
00385$:
	clc
	adc	#<(_data+0)
	sta	*(DPTR+0)
	txa
	adc	#>(_data+0)
	sta	*(DPTR+1)
	ldy	#0x00
	lda	[DPTR],y
	sta	*(REGTEMP+0)
	clc
	lda	*_main_sloc1_1_0
	adc	#<(_hello_sram_1+0)
	sta	*(DPTR+0)
	lda	*(_main_sloc1_1_0 + 1)
	adc	#>(_hello_sram_1+0)
	sta	*(DPTR+1)
	lda	*(REGTEMP+0)
	sta	[DPTR],y
	inc	*_main_sloc2_1_0
	jmp	00140$
00108$:
;	src/banks_nonintrinsic.c: 70: for (int8_t i = 0; (hello_sram_1[i]); i++) putchar(hello_sram_1[i]);
	ldx	#0x00
	stx	*_main_sloc2_1_0
00143$:
	ldx	#0x00
	lda	*_main_sloc2_1_0
	bpl	00386$
	dex
00386$:
	clc
	adc	#<(_hello_sram_1+0)
	sta	*(DPTR+0)
	txa
	adc	#>(_hello_sram_1+0)
	sta	*(DPTR+1)
	ldy	#0x00
	lda	[DPTR],y
	beq	00109$
	jsr	_putchar
	jsr	_set_RAM_bank1
	inc	*_main_sloc2_1_0
	jmp	00143$
00109$:
;	src/banks_nonintrinsic.c: 72: printf("once more...\n");
	lda	#>___str_0
	pha
	lda	#___str_0
	pha
	jsr	_printf
	pla
	pla
;	src/banks_nonintrinsic.c: 74: for (int8_t i = 0; (hello_code[i]); i++) putchar(hello_code[i]);
	ldx	#0x00
	stx	*_main_sloc2_1_0
00146$:
	ldx	#0x00
	lda	*_main_sloc2_1_0
	bpl	00389$
	dex
00389$:
	clc
	adc	#<(_hello_code+0)
	sta	*(DPTR+0)
	txa
	adc	#>(_hello_code+0)
	sta	*(DPTR+1)
	ldy	#0x00
	lda	[DPTR],y
	beq	00110$
	jsr	_putchar
	inc	*_main_sloc2_1_0
	jmp	00146$
00110$:
;	src/banks_nonintrinsic.c: 75: for (int8_t i = 0; (hello_rom_1[i]); i++) putchar(hello_rom_1[i]);
	ldx	#0x00
	stx	*_main_sloc2_1_0
00149$:
	ldx	#0x00
	lda	*_main_sloc2_1_0
	bpl	00392$
	dex
00392$:
	pha
	sta	*(REGTEMP+0)
	txa
	pha
	lda	*(REGTEMP+0)
	jsr	_set_ROM_bank1
	pla
	tax
	pla
	clc
	adc	#<(_hello_rom_1+0)
	sta	*(DPTR+0)
	txa
	adc	#>(_hello_rom_1+0)
	sta	*(DPTR+1)
	ldy	#0x00
	lda	[DPTR],y
	beq	00111$
	jsr	_putchar
	inc	*_main_sloc2_1_0
	jmp	00149$
00111$:
;	src/banks_nonintrinsic.c: 76: for (int8_t i = 0; (hello_rom_2[i]); i++) putchar(hello_rom_2[i]);
	ldx	#0x00
	stx	*_main_sloc2_1_0
00152$:
	ldx	#0x00
	lda	*_main_sloc2_1_0
	bpl	00395$
	dex
00395$:
	pha
	sta	*(REGTEMP+0)
	txa
	pha
	lda	*(REGTEMP+0)
	jsr	_set_ROM_bank2
	pla
	tax
	pla
	clc
	adc	#<(_hello_rom_2+0)
	sta	*(DPTR+0)
	txa
	adc	#>(_hello_rom_2+0)
	sta	*(DPTR+1)
	ldy	#0x00
	lda	[DPTR],y
	beq	00112$
	jsr	_putchar
	inc	*_main_sloc2_1_0
	jmp	00152$
00112$:
;	src/banks_nonintrinsic.c: 77: for (int8_t i = 0; (hello_sram_0[i]); i++) putchar(hello_sram_0[i]);
	ldx	#0x00
	stx	*_main_sloc2_1_0
00155$:
	ldx	#0x00
	lda	*_main_sloc2_1_0
	bpl	00398$
	dex
00398$:
	pha
	sta	*(REGTEMP+0)
	txa
	pha
	lda	*(REGTEMP+0)
	jsr	_set_RAM_bank0
	pla
	tax
	pla
	clc
	adc	#<(_hello_sram_0+0)
	sta	*(DPTR+0)
	txa
	adc	#>(_hello_sram_0+0)
	sta	*(DPTR+1)
	ldy	#0x00
	lda	[DPTR],y
	beq	00113$
	jsr	_putchar
	inc	*_main_sloc2_1_0
	jmp	00155$
00113$:
;	src/banks_nonintrinsic.c: 78: for (int8_t i = 0; (hello_sram_1[i]); i++) putchar(hello_sram_1[i]);
	ldx	#0x00
	stx	*_main_sloc2_1_0
00158$:
	ldx	#0x00
	lda	*_main_sloc2_1_0
	bpl	00401$
	dex
00401$:
	pha
	sta	*(REGTEMP+0)
	txa
	pha
	lda	*(REGTEMP+0)
	jsr	_set_RAM_bank1
	pla
	tax
	pla
	clc
	adc	#<(_hello_sram_1+0)
	sta	*(DPTR+0)
	txa
	adc	#>(_hello_sram_1+0)
	sta	*(DPTR+1)
	ldy	#0x00
	lda	[DPTR],y
	beq	00114$
	jsr	_putchar
	inc	*_main_sloc2_1_0
	jmp	00158$
00114$:
;	src/banks_nonintrinsic.c: 80: printf("once more...\n");
	lda	#>___str_0
	pha
	lda	#___str_0
	pha
	jsr	_printf
	pla
	pla
;	src/banks_nonintrinsic.c: 82: printf("%s", hello_code);
	lda	#>_hello_code
	pha
	lda	#_hello_code
	pha
	lda	#>___str_1
	pha
	lda	#___str_1
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
;	src/banks_nonintrinsic.c: 83: printf("%s", switch_to(hello_rom_1));
	jsr	_set_ROM_bank1
	lda	_hello_rom_1
	sta	___dummy_variable
	lda	#>_hello_rom_1
	pha
	lda	#_hello_rom_1
	pha
	lda	#>___str_1
	pha
	lda	#___str_1
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
;	src/banks_nonintrinsic.c: 84: printf("%s", switch_to(hello_rom_2));
	jsr	_set_ROM_bank2
	lda	_hello_rom_2
	sta	___dummy_variable
	lda	#>_hello_rom_2
	pha
	lda	#_hello_rom_2
	pha
	lda	#>___str_1
	pha
	lda	#___str_1
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
;	src/banks_nonintrinsic.c: 85: printf("%s", switch_to(hello_sram_0));
	jsr	_set_RAM_bank0
	lda	_hello_sram_0
	sta	___dummy_variable
	lda	#>_hello_sram_0
	pha
	lda	#_hello_sram_0
	pha
	lda	#>___str_1
	pha
	lda	#___str_1
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
;	src/banks_nonintrinsic.c: 86: printf("%s", switch_to(hello_sram_1));
	jsr	_set_RAM_bank1
	lda	_hello_sram_1
	sta	___dummy_variable
	lda	#>_hello_sram_1
	pha
	lda	#_hello_sram_1
	pha
	lda	#>___str_1
	pha
	lda	#___str_1
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
;	src/banks_nonintrinsic.c: 89: printf("1+2+4+8=0x%x", (int)(add_num_wram + add_num_sram_0 + (*add_num__ptr[0]) + (*add_num__ptr[1])));
	jsr	_set_RAM_bank0
	lda	_add_num_wram
	clc
	adc	_add_num_sram_0
	sta	*_main_sloc1_1_0
	lda	(_add_num_wram + 1)
	adc	(_add_num_sram_0 + 1)
	sta	*(_main_sloc1_1_0 + 1)
	jsr	_set_ROM_bank1
	lda	(_add_num__ptr + 1)
	sta	*(_main_sloc3_1_0 + 1)
	lda	_add_num__ptr
	sta	*_main_sloc3_1_0
	jsr	_set_RAM_bank1
	ldy	#0x01
	lda	[*_main_sloc3_1_0],y
	pha
	dey
	lda	[*_main_sloc3_1_0],y
	sta	*_main_sloc3_1_0
	pla
	sta	*(_main_sloc3_1_0 + 1)
	jsr	_set_ROM_bank1
	lda	*_main_sloc1_1_0
	clc
	adc	*_main_sloc3_1_0
	sta	*_main_sloc3_1_0
	lda	*(_main_sloc1_1_0 + 1)
	adc	*(_main_sloc3_1_0 + 1)
	sta	*(_main_sloc3_1_0 + 1)
	lda	((_add_num__ptr + 0x0002) + 1)
	sta	*(_main_sloc1_1_0 + 1)
	lda	(_add_num__ptr + 0x0002)
	sta	*_main_sloc1_1_0
	jsr	_set_RAM_bank1
	ldy	#0x01
	lda	[*_main_sloc1_1_0],y
	tax
	dey
	lda	[*_main_sloc1_1_0],y
	clc
	adc	*_main_sloc3_1_0
	sta	*_main_sloc3_1_0
	txa
	adc	*(_main_sloc3_1_0 + 1)
	sta	*(_main_sloc3_1_0 + 1)
	pha
	lda	*_main_sloc3_1_0
	pha
	lda	#>___str_2
	pha
	lda	#___str_2
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
;	src/banks_nonintrinsic.c: 92: while(1);
00116$:
	jmp	00116$
;	src/banks_nonintrinsic.c: 93: }
	rts
	.area _CODE
_hello_code:
	.ascii "hello from CODE"
	.db 0x0a
	.db 0x00
___str_0:
	.ascii "once more..."
	.db 0x0a
	.db 0x00
___str_1:
	.ascii "%s"
	.db 0x00
___str_2:
	.ascii "1+2+4+8=0x%x"
	.db 0x00
	.area _XINIT
__xinit___current_ram_bank:
	.db #0x00	; 0
__xinit__data:
	.ascii "DATA"
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
__xinit__add_num_wram:
	.dw #0x0001
	.area _CABS    (ABS)
