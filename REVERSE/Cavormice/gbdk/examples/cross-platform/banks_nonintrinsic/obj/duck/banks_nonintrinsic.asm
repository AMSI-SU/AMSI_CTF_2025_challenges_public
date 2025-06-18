;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module banks_nonintrinsic
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _set_RAM_bank1
	.globl _set_RAM_bank0
	.globl _set_ROM_bank2
	.globl _set_ROM_bank1
	.globl _puts
	.globl _printf
	.globl _putchar
	.globl _add_num__ptr
	.globl _hello_rom_1
	.globl _hello_rom_2
	.globl _add_num_sram_0
	.globl _hello_sram_0
	.globl _add_num_sram_1b
	.globl _add_num_sram_1a
	.globl _hello_sram_1
	.globl _add_num_wram
	.globl _data
	.globl __current_ram_bank
	.globl ___dummy_variable
	.globl _hello_code
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
___dummy_variable::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
__current_ram_bank::
	.ds 1
_data::
	.ds 20
_add_num_wram::
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
;src/banks_nonintrinsic.c:21: void set_ROM_bank1(void) NONBANKED { SWITCH_ROM(1); }
;	---------------------------------
; Function set_ROM_bank1
; ---------------------------------
_set_ROM_bank1::
	ld	a, #0x01
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), #0x01
	ret
_hello_code:
	.ascii "hello from CODE"
	.db 0x0a
	.db 0x00
;src/banks_nonintrinsic.c:22: void set_ROM_bank2(void) NONBANKED { SWITCH_ROM(2); }
;	---------------------------------
; Function set_ROM_bank2
; ---------------------------------
_set_ROM_bank2::
	ld	a, #0x02
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), #0x02
	ret
;src/banks_nonintrinsic.c:31: void set_RAM_bank0(void) NONBANKED { SWITCH_RAM_BANK(0); }
;	---------------------------------
; Function set_RAM_bank0
; ---------------------------------
_set_RAM_bank0::
	ld	hl, #__current_ram_bank
	ld	(hl), #0x00
	ret
;src/banks_nonintrinsic.c:32: void set_RAM_bank1(void) NONBANKED { SWITCH_RAM_BANK(1); }
;	---------------------------------
; Function set_RAM_bank1
; ---------------------------------
_set_RAM_bank1::
	ld	hl, #__current_ram_bank
	ld	(hl), #0x01
	ret
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/banks_nonintrinsic.c:50: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	dec	sp
	dec	sp
;src/banks_nonintrinsic.c:53: add_num_sram_0 = 2;
	call	_set_RAM_bank0
	ld	hl, #_add_num_sram_0
	ld	a, #0x02
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/banks_nonintrinsic.c:54: add_num_sram_1a = 4;
	call	_set_RAM_bank1
	ld	hl, #_add_num_sram_1a
	ld	a, #0x04
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/banks_nonintrinsic.c:55: add_num_sram_1b = 8;
	ld	hl, #_add_num_sram_1b
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/banks_nonintrinsic.c:58: for (int8_t i = 0; (hello_code[i]); i++) putchar(hello_code[i]);
	ld	b, #0x00
00119$:
	ld	a, b
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	hl, #_hello_code
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00101$
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	bc
	inc	b
	jr	00119$
00101$:
;src/banks_nonintrinsic.c:59: for (int8_t i = 0; (hello_rom_1[i]); i++) putchar(hello_rom_1[i]);
	ld	c, #0x00
00122$:
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	push	bc
	push	de
	call	_set_ROM_bank1
	pop	de
	pop	bc
	ld	hl, #_hello_rom_1
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	bc
	inc	c
	jr	00122$
00102$:
;src/banks_nonintrinsic.c:60: for (int8_t i = 0; (hello_rom_2[i]); i++) putchar(hello_rom_2[i]);
	ld	c, #0x00
00125$:
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	push	bc
	push	de
	call	_set_ROM_bank2
	pop	de
	pop	bc
	ld	hl, #_hello_rom_2
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00103$
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	bc
	inc	c
	jr	00125$
00103$:
;src/banks_nonintrinsic.c:63: for (int8_t i = 0; (i < sizeof(hello_rom_1)); i++) hello_sram_0[i] = hello_rom_1[i];
	ld	c, #0x00
00128$:
	ld	a, c
	xor	a, #0x80
	sub	a, #0x93
	ld	a, #0x00
	rla
	ld	b, a
	push	bc
	call	_set_ROM_bank1
	pop	bc
	ld	a, b
	or	a, a
	jr	Z, 00104$
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	hl, #_hello_sram_0
	add	hl, de
	ld	a, e
	add	a, #<(_hello_rom_1)
	ld	e, a
	ld	a, d
	adc	a, #>(_hello_rom_1)
	ld	d, a
	ld	a, (de)
	ld	b, a
	push	hl
	push	bc
	call	_set_RAM_bank0
	pop	bc
	pop	hl
	ld	(hl), b
	inc	c
	jr	00128$
00104$:
;src/banks_nonintrinsic.c:64: for (int8_t i = 0; (i < 4); i++) hello_sram_0[i + 11] = data[i];
	ld	c, #0x00
	push	bc
	call	_set_RAM_bank0
	pop	bc
00131$:
	ld	a, c
	xor	a, #0x80
	sub	a, #0x84
	jr	NC, 00105$
	ld	a, c
	add	a, #0x0b
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	hl, #_hello_sram_0
	add	hl, de
	ld	a, c
	ld	b, a
	rlca
	sbc	a, a
	ld	d, a
	ld	a, b
	add	a, #<(_data)
	ld	e, a
	ld	a, d
	adc	a, #>(_data)
	ld	d, a
	ld	a, (de)
	ld	(hl), a
	inc	c
	jr	00131$
00105$:
;src/banks_nonintrinsic.c:65: for (int8_t i = 0; (hello_sram_0[i]); i++) putchar(hello_sram_0[i]);
	ld	c, #0x00
00134$:
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	hl, #_hello_sram_0
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00106$
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	call	_set_RAM_bank0
	pop	bc
	inc	c
	jr	00134$
00106$:
;src/banks_nonintrinsic.c:68: for (int8_t i = 0; (i < sizeof(hello_rom_2)); i++) hello_sram_1[i] = hello_rom_2[i];
	ld	c, #0x00
00137$:
	ld	a, c
	xor	a, #0x80
	sub	a, #0x93
	ld	a, #0x00
	rla
	ld	b, a
	push	bc
	call	_set_ROM_bank2
	pop	bc
	ld	a, b
	or	a, a
	jr	Z, 00107$
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	hl, #_hello_sram_1
	add	hl, de
	ld	a, e
	add	a, #<(_hello_rom_2)
	ld	e, a
	ld	a, d
	adc	a, #>(_hello_rom_2)
	ld	d, a
	ld	a, (de)
	ld	b, a
	push	hl
	push	bc
	call	_set_RAM_bank1
	pop	bc
	pop	hl
	ld	(hl), b
	inc	c
	jr	00137$
00107$:
;src/banks_nonintrinsic.c:69: for (int8_t i = 0; (i < 4); i++) hello_sram_1[i + 11] = data[i];
	ld	c, #0x00
	push	bc
	call	_set_RAM_bank1
	pop	bc
00140$:
	ld	a, c
	xor	a, #0x80
	sub	a, #0x84
	jr	NC, 00108$
	ld	a, c
	add	a, #0x0b
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	hl, #_hello_sram_1
	add	hl, de
	ld	a, c
	ld	b, a
	rlca
	sbc	a, a
	ld	d, a
	ld	a, b
	add	a, #<(_data)
	ld	e, a
	ld	a, d
	adc	a, #>(_data)
	ld	d, a
	ld	a, (de)
	ld	(hl), a
	inc	c
	jr	00140$
00108$:
;src/banks_nonintrinsic.c:70: for (int8_t i = 0; (hello_sram_1[i]); i++) putchar(hello_sram_1[i]);
	ld	c, #0x00
00143$:
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	hl, #_hello_sram_1
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00109$
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	call	_set_RAM_bank1
	pop	bc
	inc	c
	jr	00143$
00109$:
;src/banks_nonintrinsic.c:72: printf("once more...\n");
	ld	de, #___str_2
	call	_puts
;src/banks_nonintrinsic.c:74: for (int8_t i = 0; (hello_code[i]); i++) putchar(hello_code[i]);
	ld	c, #0x00
00146$:
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	hl, #_hello_code
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00110$
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	bc
	inc	c
	jr	00146$
00110$:
;src/banks_nonintrinsic.c:75: for (int8_t i = 0; (hello_rom_1[i]); i++) putchar(hello_rom_1[i]);
	ld	c, #0x00
00149$:
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	push	bc
	push	de
	call	_set_ROM_bank1
	pop	de
	pop	bc
	ld	hl, #_hello_rom_1
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00111$
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	bc
	inc	c
	jr	00149$
00111$:
;src/banks_nonintrinsic.c:76: for (int8_t i = 0; (hello_rom_2[i]); i++) putchar(hello_rom_2[i]);
	ld	c, #0x00
00152$:
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	push	bc
	push	de
	call	_set_ROM_bank2
	pop	de
	pop	bc
	ld	hl, #_hello_rom_2
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00112$
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	bc
	inc	c
	jr	00152$
00112$:
;src/banks_nonintrinsic.c:77: for (int8_t i = 0; (hello_sram_0[i]); i++) putchar(hello_sram_0[i]);
	ld	c, #0x00
00155$:
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	push	bc
	push	de
	call	_set_RAM_bank0
	pop	de
	pop	bc
	ld	hl, #_hello_sram_0
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00113$
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	bc
	inc	c
	jr	00155$
00113$:
;src/banks_nonintrinsic.c:78: for (int8_t i = 0; (hello_sram_1[i]); i++) putchar(hello_sram_1[i]);
	ld	c, #0x00
00158$:
	ld	a, c
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	push	bc
	push	de
	call	_set_RAM_bank1
	pop	de
	pop	bc
	ld	hl, #_hello_sram_1
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00114$
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	bc
	inc	c
	jr	00158$
00114$:
;src/banks_nonintrinsic.c:80: printf("once more...\n");
	ld	de, #___str_2
	call	_puts
;src/banks_nonintrinsic.c:82: printf("%s", hello_code);
	ld	de, #_hello_code
	push	de
	ld	de, #___str_4
	push	de
	call	_printf
	add	sp, #4
;src/banks_nonintrinsic.c:83: printf("%s", switch_to(hello_rom_1));
	call	_set_ROM_bank1
	ld	a, (#_hello_rom_1 + 0)
	ld	(#___dummy_variable),a
	ld	de, #_hello_rom_1
	push	de
	ld	de, #___str_4
	push	de
	call	_printf
	add	sp, #4
;src/banks_nonintrinsic.c:84: printf("%s", switch_to(hello_rom_2));
	call	_set_ROM_bank2
	ld	a, (#_hello_rom_2 + 0)
	ld	(#___dummy_variable),a
	ld	de, #_hello_rom_2
	push	de
	ld	de, #___str_4
	push	de
	call	_printf
	add	sp, #4
;src/banks_nonintrinsic.c:85: printf("%s", switch_to(hello_sram_0));
	call	_set_RAM_bank0
	ld	a, (#_hello_sram_0 + 0)
	ld	(#___dummy_variable),a
	ld	de, #_hello_sram_0
	push	de
	ld	de, #___str_4
	push	de
	call	_printf
	add	sp, #4
;src/banks_nonintrinsic.c:86: printf("%s", switch_to(hello_sram_1));
	call	_set_RAM_bank1
	ld	a, (#_hello_sram_1 + 0)
	ld	(#___dummy_variable),a
	ld	de, #_hello_sram_1
	push	de
	ld	de, #___str_4
	push	de
	call	_printf
	add	sp, #4
;src/banks_nonintrinsic.c:89: printf("1+2+4+8=0x%x", (int)(add_num_wram + add_num_sram_0 + (*add_num__ptr[0]) + (*add_num__ptr[1])));
	call	_set_RAM_bank0
	ld	hl, #_add_num_wram
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_add_num_sram_0
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	call	_set_ROM_bank1
	ld	hl, #_add_num__ptr
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	call	_set_RAM_bank1
	pop	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	call	_set_ROM_bank1
	pop	bc
	pop	hl
	push	hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #(_add_num__ptr + 2)
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	push	bc
	call	_set_RAM_bank1
	pop	bc
	pop	hl
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	push	hl
	ld	de, #___str_5
	push	de
	call	_printf
;src/banks_nonintrinsic.c:92: while(1);
00116$:
	jr	00116$
;src/banks_nonintrinsic.c:93: }
	inc	sp
	inc	sp
	ret
___str_2:
	.ascii "once more..."
	.db 0x00
___str_4:
	.ascii "%s"
	.db 0x00
___str_5:
	.ascii "1+2+4+8=0x%x"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
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
	.area _CABS (ABS)
