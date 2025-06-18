;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module testrand
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _waitpadup
	.globl _waitpad
	.globl _arand
	.globl _initarand
	.globl _rand
	.globl _puts
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
;src/testrand.c:14: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-3
;src/testrand.c:16: puts("press A...");
	ld	de, #___str_0
	call	_puts
;src/testrand.c:17: waitpad(J_A);
	ld	a, #0x10
	call	_waitpad
;src/testrand.c:18: initarand(sys_time);
	ld	hl, #_sys_time
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	call	_initarand
	pop	hl
;src/testrand.c:19: while(TRUE) {
00103$:
;src/testrand.c:20: waitpadup();
	call	_waitpadup
;src/testrand.c:21: for (uint8_t i = 0; i != 16; i++) 
	ldhl	sp,	#2
	ld	(hl), #0x00
00106$:
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x10
	jr	Z, 00101$
;src/testrand.c:22: printf("r=%x a=%x\n", (uint16_t)rand(), (uint16_t)arand());
	call	_arand
	ldhl	sp,	#0
	ld	a, e
	ld	(hl+), a
	ld	(hl), #0x00
	call	_rand
	xor	a, a
	pop	bc
	push	bc
	push	bc
	ld	d, a
	push	de
	ld	de, #___str_1
	push	de
	call	_printf
	add	sp, #6
;src/testrand.c:21: for (uint8_t i = 0; i != 16; i++) 
	ldhl	sp,	#2
	inc	(hl)
	jr	00106$
00101$:
;src/testrand.c:23: puts("press A...");
	ld	de, #___str_0
	call	_puts
;src/testrand.c:24: waitpad(J_A);
	ld	a, #0x10
	call	_waitpad
	jr	00103$
;src/testrand.c:26: }
	add	sp, #3
	ret
___str_0:
	.ascii "press A..."
	.db 0x00
___str_1:
	.ascii "r=%x a=%x"
	.db 0x0a
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
