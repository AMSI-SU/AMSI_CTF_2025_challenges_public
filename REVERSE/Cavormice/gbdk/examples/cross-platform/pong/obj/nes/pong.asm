;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module pong
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
	.globl _HUD
	.globl _main
	.globl _init_pad
	.globl _printf
	.globl _gotoxy
	.globl _move_sprite
	.globl _set_sprite_tile
	.globl _set_sprite_data
	.globl _vsync
	.globl _joypad_ex
	.globl _joypad_init
	.globl _sprite_data
	.globl _spd_ballY
	.globl _spd_ballX
	.globl _ballY
	.globl _ballX
	.globl _player2_score
	.globl _player1_score
	.globl _player2
	.globl _player1
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
_init_pad_n_10000_99:
	.ds 1
_joypads::
	.ds 5
_player1::
	.ds 1
_player2::
	.ds 1
_player1_score::
	.ds 2
_player2_score::
	.ds 2
_ballX::
	.ds 1
_ballY::
	.ds 1
_spd_ballX::
	.ds 1
_spd_ballY::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS    (ABS)
;--------------------------------------------------------
; initialized external ram data
;--------------------------------------------------------
	.area _DATA
_sprite_data::
	.ds 64
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
;Allocation info for local variables in function 'init_pad'
;------------------------------------------------------------
;n                         Allocated with name '_init_pad_n_10000_99'
;------------------------------------------------------------
;	src/pong.c: 16: void init_pad(uint8_t n) {
;	-----------------------------------------
;	 function init_pad
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_init_pad:
;	src/pong.c: 17: set_sprite_tile(n << 2, n);
	sta	_init_pad_n_10000_99
	asl	a
	asl	a
	pha
	ldx	_init_pad_n_10000_99
	jsr	_set_sprite_tile
	pla
;	src/pong.c: 18: set_sprite_tile((n << 2) + 1, n);
	pha
	clc
	adc	#0x01
	tay
	ldx	_init_pad_n_10000_99
	jsr	_set_sprite_tile
	pla
;	src/pong.c: 19: set_sprite_tile((n << 2) + 2, n);
	clc
	adc	#0x02
	ldx	_init_pad_n_10000_99
;	src/pong.c: 20: }
	jmp	_set_sprite_tile
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;sloc0                     Allocated with name '_main_sloc0_1_0'
;__300000006               Allocated to registers 
;__300000007               Allocated to registers 
;__300000008               Allocated to registers x 
;n                         Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers a 
;__300000010               Allocated to registers 
;__300000011               Allocated to registers 
;__300000012               Allocated to registers x 
;n                         Allocated to registers 
;x                         Allocated to registers 
;y                         Allocated to registers a 
;------------------------------------------------------------
;	src/pong.c: 51: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
;	src/pong.c: 56: set_sprite_data(0, 4, sprite_data);
	lda	#>_sprite_data
	sta	(_set_sprite_data_PARM_3 + 1)
	lda	#_sprite_data
	sta	_set_sprite_data_PARM_3
	lda	#0x00
	ldx	#0x04
	jsr	_set_sprite_data
;	src/pong.c: 59: init_pad(0);
	lda	#0x00
	jsr	_init_pad
;	src/pong.c: 60: init_pad(1);
	lda	#0x01
	jsr	_init_pad
;	src/pong.c: 63: set_sprite_tile(3, 2);
	lda	#0x03
	ldx	#0x02
	jsr	_set_sprite_tile
;	src/pong.c: 66: SHOW_BKG; SHOW_SPRITES;
	lda	_shadow_PPUMASK
	ora	#0x08
	sta	_shadow_PPUMASK
	lda	_shadow_PPUMASK
	ora	#0x10
	sta	_shadow_PPUMASK
;	src/pong.c: 69: if (joypad_init(2, &joypads) != 2) {
	lda	#>_joypads
	sta	(_joypad_init_PARM_2 + 1)
	lda	#_joypads
	sta	_joypad_init_PARM_2
	lda	#0x02
	jsr	_joypad_init
	cmp	#0x02
	beq	00102$
;	src/pong.c: 70: printf("Device must support\nat least two joypads");
	lda	#>___str_0
	pha
	lda	#___str_0
	pha
	jsr	_printf
	pla
	pla
;	src/pong.c: 71: return;
	rts
00102$:
;	src/pong.c: 75: player1 = 64, player2 = 64;
	ldx	#0x40
	stx	_player1
	stx	_player2
;	src/pong.c: 76: player1_score = player2_score = 0;
	ldx	#0x00
	stx	_player2_score
	stx	(_player2_score + 1)
	stx	_player1_score
	stx	(_player1_score + 1)
;	src/pong.c: 79: printf(HUD, player1_score, player2_score);
	txa
	pha
	pha
	pha
	pha
	lda	#>_HUD
	pha
	lda	#_HUD
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
	pla
	pla
;	src/pong.c: 82: ballX = INITBALLX, ballY = INITBALLY;
	ldx	#0x54
	stx	_ballX
	ldx	#0x48
	stx	_ballY
;	src/pong.c: 83: spd_ballX = 1, spd_ballY = 1;
	ldx	#0x01
	stx	_spd_ballX
	stx	_spd_ballY
;	src/pong.c: 85: while(1) {
00143$:
;	src/pong.c: 87: joypad_ex(&joypads);
	ldx	#>_joypads
	lda	#_joypads
	jsr	_joypad_ex
;	src/pong.c: 90: if (joypads.joy0 & J_UP) {
	lda	(_joypads + 0x0001)
	ldx	#0x08
	stx	*(REGTEMP+0)
	bit	*(REGTEMP+0)
	beq	00110$
;	src/pong.c: 91: player1 -= 2;
	lda	_player1
	sec
	sbc	#0x02
;	src/pong.c: 92: if (player1 < YMIN) player1 = YMIN;
	sta	_player1
	cmp	#0x1c
	bcs	00111$
	ldx	#0x1c
	stx	_player1
	jmp	00111$
00110$:
;	src/pong.c: 93: } else if (joypads.joy0 & J_DOWN) {
	and	#0x04
	beq	00111$
;	src/pong.c: 94: player1 += 2;
	lda	_player1
	clc
	adc	#0x02
;	src/pong.c: 95: if (player1 > YMAX) player1 = YMAX;            
	sta	_player1
	cmp	#0x64
	beq	00111$
	bcc	00111$
	ldx	#0x64
	stx	_player1
00111$:
;	src/pong.c: 97: draw_pad(0, PLAYER1_X, player1);
	ldx	_player1
	txa
;	src/pong.c: 24: move_sprite(n << 2, x, y);
	stx	_move_sprite_PARM_3
	pha
	lda	#0x00
	tax
	jsr	_move_sprite
	pla
;	src/pong.c: 25: move_sprite((n << 2) + 1, x, y + 8);
	pha
	clc
	adc	#0x08
	sta	_move_sprite_PARM_3
	lda	#0x01
	ldx	#0x00
	jsr	_move_sprite
	pla
;	src/pong.c: 26: move_sprite((n << 2) + 2, x, y + 16);
	clc
	adc	#0x10
	sta	_move_sprite_PARM_3
	lda	#0x02
	ldx	#0x00
	jsr	_move_sprite
;	src/pong.c: 100: if (joypads.joy1 & J_UP) {
	lda	(_joypads + 0x0002)
	ldx	#0x08
	stx	*(REGTEMP+0)
	bit	*(REGTEMP+0)
	beq	00119$
;	src/pong.c: 101: player2 -= 2;
	lda	_player2
	sec
	sbc	#0x02
;	src/pong.c: 102: if (player2 < YMIN) player2 = YMIN;
	sta	_player2
	cmp	#0x1c
	bcs	00120$
	ldx	#0x1c
	stx	_player2
	jmp	00120$
00119$:
;	src/pong.c: 103: } else if (joypads.joy1 & J_DOWN) {
	and	#0x04
	beq	00120$
;	src/pong.c: 104: player2 += 2;
	lda	_player2
	clc
	adc	#0x02
;	src/pong.c: 105: if (player2 > YMAX) player2 = YMAX;            
	sta	_player2
	cmp	#0x64
	beq	00120$
	bcc	00120$
	ldx	#0x64
	stx	_player2
00120$:
;	src/pong.c: 107: draw_pad(1, PLAYER2_X, player2);
	ldx	_player2
	txa
;	src/pong.c: 24: move_sprite(n << 2, x, y);
	stx	_move_sprite_PARM_3
	pha
	lda	#0x04
	ldx	#0xf8
	jsr	_move_sprite
	pla
;	src/pong.c: 25: move_sprite((n << 2) + 1, x, y + 8);
	pha
	clc
	adc	#0x08
	sta	_move_sprite_PARM_3
	lda	#0x05
	ldx	#0xf8
	jsr	_move_sprite
	pla
;	src/pong.c: 26: move_sprite((n << 2) + 2, x, y + 16);
	clc
	adc	#0x10
	sta	_move_sprite_PARM_3
	lda	#0x06
	ldx	#0xf8
	jsr	_move_sprite
;	src/pong.c: 110: ballX += spd_ballX, ballY += spd_ballY;
	lda	_ballX
	clc
	adc	_spd_ballX
	sta	_ballX
	lda	_ballY
	clc
	adc	_spd_ballY
;	src/pong.c: 112: if ((ballY < YMIN) || (ballY > (YMAX + 24))) {
	sta	_ballY
	cmp	#0x1c
	bcc	00121$
	lda	_ballY
	cmp	#0x7c
	beq	00122$
	bcc	00122$
00121$:
;	src/pong.c: 113: spd_ballY = -spd_ballY; 
	lda	_spd_ballY
	eor	#0xff
	clc
	adc	#0x01
	sta	_spd_ballY
00122$:
;	src/pong.c: 116: if (ballX < (PLAYER1_X + 8)) {
	lda	_ballX
	cmp	#0x08
	bcs	00135$
;	src/pong.c: 117: if ((ballY > player1) && (ballY < (player1 + 24)) && (spd_ballX < 0)) 
	lda	_ballY
	cmp	_player1
	beq	00291$
	bcs	00290$
00291$:
	jmp	00136$
00290$:
	ldx	#0x00
	lda	_player1
	clc
	adc	#0x18
	sta	*_main_sloc0_1_0
	txa
	adc	#0x00
	sta	*(_main_sloc0_1_0 + 1)
	lda	_ballY
	sec
	sbc	*_main_sloc0_1_0
	txa
	sbc	*(_main_sloc0_1_0 + 1)
	bvc	00293$
	bpl	00292$
	bmi	00136$
00293$:
	bpl	00136$
00292$:
	bit	_spd_ballX
	bpl	00136$
;	src/pong.c: 118: spd_ballX = -spd_ballX;
	lda	_spd_ballX
	eor	#0xff
	clc
	adc	#0x01
	sta	_spd_ballX
	jmp	00136$
00135$:
;	src/pong.c: 119: } else if (ballX > (PLAYER2_X - 8)) {
	lda	_ballX
	cmp	#0xf0
	beq	00136$
	bcc	00136$
;	src/pong.c: 120: if ((ballY > player2) && (ballY < (player2 + 24)) && (spd_ballX > 0)) 
	lda	_ballY
	cmp	_player2
	beq	00136$
	bcc	00136$
	ldx	#0x00
	lda	_player2
	clc
	adc	#0x18
	sta	*_main_sloc0_1_0
	txa
	adc	#0x00
	sta	*(_main_sloc0_1_0 + 1)
	lda	_ballY
	sec
	sbc	*_main_sloc0_1_0
	txa
	sbc	*(_main_sloc0_1_0 + 1)
	bvc	00301$
	bpl	00300$
	bmi	00136$
00301$:
	bpl	00136$
00300$:
	txa
	sec
	sbc	_spd_ballX
	bvc	00304$
	bpl	00303$
	bmi	00136$
00304$:
	bpl	00136$
00303$:
;	src/pong.c: 121: spd_ballX = -spd_ballX;
	lda	_spd_ballX
	eor	#0xff
	clc
	adc	#0x01
	sta	_spd_ballX
00136$:
;	src/pong.c: 124: if (ballX <= PLAYER1_X) {
	lda	_ballX
	bne	00140$
;	src/pong.c: 126: ballX = INITBALLX, ballY = INITBALLY;
	ldx	#0x54
	stx	_ballX
	ldx	#0x48
	stx	_ballY
;	src/pong.c: 127: spd_ballX = -spd_ballX;
	lda	_spd_ballX
	eor	#0xff
	clc
	adc	#0x01
	sta	_spd_ballX
;	src/pong.c: 128: player2_score++;
	inc	_player2_score
	bne	00308$
	inc	(_player2_score + 1)
00308$:
;	src/pong.c: 129: gotoxy(0, 0); printf(HUD, player1_score, player2_score);
	lda	#0x00
	tax
	jsr	_gotoxy
	lda	(_player2_score + 1)
	pha
	lda	_player2_score
	pha
	lda	(_player1_score + 1)
	pha
	lda	_player1_score
	pha
	lda	#>_HUD
	pha
	lda	#_HUD
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
	pla
	pla
	jmp	00141$
00140$:
;	src/pong.c: 130: } else if (ballX > PLAYER2_X) {
	lda	_ballX
	cmp	#0xf8
	beq	00141$
	bcc	00141$
;	src/pong.c: 132: ballX = INITBALLX, ballY = INITBALLY;
	ldx	#0x54
	stx	_ballX
	ldx	#0x48
	stx	_ballY
;	src/pong.c: 133: spd_ballX = -spd_ballX;
	lda	_spd_ballX
	eor	#0xff
	clc
	adc	#0x01
	sta	_spd_ballX
;	src/pong.c: 134: player1_score++;
	inc	_player1_score
	bne	00311$
	inc	(_player1_score + 1)
00311$:
;	src/pong.c: 135: gotoxy(0, 0); printf(HUD, player1_score, player2_score);
	lda	#0x00
	tax
	jsr	_gotoxy
	lda	(_player2_score + 1)
	pha
	lda	_player2_score
	pha
	lda	(_player1_score + 1)
	pha
	lda	_player1_score
	pha
	lda	#>_HUD
	pha
	lda	#_HUD
	pha
	jsr	_printf
	pla
	pla
	pla
	pla
	pla
	pla
00141$:
;	src/pong.c: 138: move_sprite(3, ballX, ballY);
	lda	_ballY
	sta	_move_sprite_PARM_3
	lda	#0x03
	ldx	_ballX
	jsr	_move_sprite
;	src/pong.c: 141: vsync();
	jsr	_vsync
	jmp	00143$
;	src/pong.c: 143: }
	rts
	.area _CODE
_HUD:
	.ascii " p1: %d   p2: %d"
	.db 0x00
___str_0:
	.ascii "Device must support"
	.db 0x0a
	.ascii "at least two joypads"
	.db 0x00
	.area _XINIT
__xinit__sprite_data:
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0xa9	; 169
	.db #0xff	; 255
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0xb9	; 185
	.db #0xff	; 255
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0x91	; 145
	.db #0xff	; 255
	.db #0xb9	; 185
	.db #0xff	; 255
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0x5a	; 90	'Z'
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0xa9	; 169
	.db #0xff	; 255
	.db #0xa9	; 169
	.db #0xff	; 255
	.db #0xb9	; 185
	.db #0xff	; 255
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.area _CABS    (ABS)
