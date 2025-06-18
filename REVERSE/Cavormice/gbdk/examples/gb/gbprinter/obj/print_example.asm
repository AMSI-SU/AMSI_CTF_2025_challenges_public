;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module print_example
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _printer_check_cancel
	.globl _gbprinter_print_image
	.globl _gbprinter_detect
	.globl _puts
	.globl _waitpadup
	.globl _waitpad
	.globl _joypad
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_printer_check_cancel_keys_10000_173:
	.ds 1
_printer_check_cancel_old_keys_10000_173:
	.ds 1
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
;src/print_example.c:10: static uint8_t keys = 0, old_keys;
	ld	hl, #_printer_check_cancel_keys_10000_173
	ld	(hl), #0x00
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/print_example.c:9: bool printer_check_cancel(void) {
;	---------------------------------
; Function printer_check_cancel
; ---------------------------------
_printer_check_cancel::
;src/print_example.c:11: old_keys = keys; keys = joypad();
	ld	a, (#_printer_check_cancel_keys_10000_173)
	ld	(#_printer_check_cancel_old_keys_10000_173),a
	call	_joypad
	ld	(#_printer_check_cancel_keys_10000_173),a
;src/print_example.c:12: return (((old_keys ^ keys) & J_B) & (keys & J_B));
	ld	a, (#_printer_check_cancel_old_keys_10000_173)
	ld	hl, #_printer_check_cancel_keys_10000_173
	xor	a, (hl)
	and	a, #0x20
	ld	c, a
	ld	a, (hl)
	and	a, #0x20
	and	a, c
	ld	c, a
	xor	a, a
	cp	a, c
	rla
;src/print_example.c:13: }
	ret
;src/print_example.c:15: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/print_example.c:16: while(1) {
00108$:
;src/print_example.c:17: puts("Press A to print");
	ld	de, #___str_0
	call	_puts
;src/print_example.c:18: waitpad(J_A);
	ld	a, #0x10
	call	_waitpad
;src/print_example.c:19: if (gbprinter_detect(PRINTER_DETECT_TIMEOUT) == PRN_STATUS_OK) {
	ld	a, #0x0a
	call	_gbprinter_detect
	or	a, a
	jr	NZ, 00105$
;src/print_example.c:20: if (gbprinter_print_image(scene00001_map, scene00001_tiles,
	ld	hl, #0x90e
	push	hl
	ld	a, #0x03
	push	af
	inc	sp
	ld	bc, #_scene00001_tiles
	ld	de, #_scene00001_map
	call	_gbprinter_print_image
	or	a, a
	jr	NZ, 00102$
;src/print_example.c:23: puts("Printed OK!");
	ld	de, #___str_1
	call	_puts
	jr	00106$
00102$:
;src/print_example.c:25: puts("Print error!");
	ld	de, #___str_2
	call	_puts
	jr	00106$
00105$:
;src/print_example.c:28: puts("No printer!");
	ld	de, #___str_3
	call	_puts
00106$:
;src/print_example.c:30: waitpadup();
	call	_waitpadup
;src/print_example.c:32: }
	jr	00108$
___str_0:
	.ascii "Press A to print"
	.db 0x00
___str_1:
	.ascii "Printed OK!"
	.db 0x00
___str_2:
	.ascii "Print error!"
	.db 0x00
___str_3:
	.ascii "No printer!"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
