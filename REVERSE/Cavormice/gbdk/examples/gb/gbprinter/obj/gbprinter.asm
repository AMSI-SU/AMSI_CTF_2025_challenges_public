;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module gbprinter
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _printer_wait
	.globl _printer_check_cancel
	.globl _printer_print_tile
	.globl _printer_send_command
	.globl _printer_send_byte
	.globl _printer_send_receive
	.globl _memset
	.globl _memcpy
	.globl _vsync
	.globl _PRN_PKT_START
	.globl _gbprinter_detect
	.globl _gbprinter_print_image
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_printer_status:
	.ds 2
_printer_tile_num:
	.ds 1
_printer_print_tile_printer_CRC_10000_158:
	.ds 2
_gbprinter_print_image_img_10000_177:
	.ds 2
_gbprinter_print_image_error_10000_177:
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_PRN_PKT_START::
	.ds 14
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
;src/gbprinter.c:31: uint8_t printer_send_receive(uint8_t b) {
;	---------------------------------
; Function printer_send_receive
; ---------------------------------
_printer_send_receive::
	ldh	(_SB_REG + 0), a
;src/gbprinter.c:33: SC_REG = START_TRANSFER;
	ld	a, #0x81
	ldh	(_SC_REG + 0), a
;src/gbprinter.c:34: while (SC_REG & 0x80);
00101$:
	ldh	a, (_SC_REG + 0)
	rlca
	jr	C, 00101$
;src/gbprinter.c:35: return SB_REG;
	ldh	a, (_SB_REG + 0)
;src/gbprinter.c:36: }
	ret
_PRN_PKT_INIT:
	.db #0x88	; 136
	.db #0x33	; 51	'3'
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_PRN_PKT_STATUS:
	.db #0x88	; 136
	.db #0x33	; 51	'3'
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_PRN_PKT_EOF:
	.db #0x88	; 136
	.db #0x33	; 51	'3'
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_PRN_PKT_CANCEL:
	.db #0x88	; 136
	.db #0x33	; 51	'3'
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
;src/gbprinter.c:38: uint8_t printer_send_byte(uint8_t b) {
;	---------------------------------
; Function printer_send_byte
; ---------------------------------
_printer_send_byte::
	ld	e, a
;src/gbprinter.c:39: return (uint8_t)(printer_status = ((printer_status << 8) | printer_send_receive(b)));
	ld	hl, #_printer_status
	ld	b, (hl)
	ld	c, #0x00
	push	bc
	ld	a, e
	call	_printer_send_receive
	pop	bc
	ld	hl, #_printer_status
	ld	(hl+), a
	ld	(hl), b
;src/gbprinter.c:40: }
	ret
;src/gbprinter.c:42: uint8_t printer_send_command(const uint8_t *command, uint8_t length) {
;	---------------------------------
; Function printer_send_command
; ---------------------------------
_printer_send_command::
	ld	c, a
;src/gbprinter.c:44: while (index++ < length) printer_send_byte(*command++);
	ld	b, #0x00
00101$:
	ld	a, b
	sub	a, c
	jr	NC, 00103$
	inc	b
	ld	a, (de)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	inc	de
	push	bc
	push	de
	ld	a, l
	call	_printer_send_byte
	pop	de
	pop	bc
	jr	00101$
00103$:
;src/gbprinter.c:45: return ((uint8_t)(printer_status >> 8) == PRN_MAGIC_DETECT) ? (uint8_t)printer_status : PRN_STATUS_MASK_ERRORS;
	ld	hl, #_printer_status + 1
	ld	a, (hl)
	sub	a, #0x81
	jr	NZ, 00106$
	dec	hl
	ld	a, (hl)
	ret
00106$:
	ld	a, #0xf0
;src/gbprinter.c:46: }
	ret
;src/gbprinter.c:49: uint8_t printer_print_tile(const uint8_t *tiledata) {
;	---------------------------------
; Function printer_print_tile
; ---------------------------------
_printer_print_tile::
	dec	sp
	dec	sp
	ld	b, e
;src/gbprinter.c:52: if (printer_tile_num == 0) {
	ld	a, (#_printer_tile_num)
	or	a, a
	jr	NZ, 00119$
;src/gbprinter.c:53: const uint8_t * data = PRINT_TILE;
	ld	hl, #_printer_print_tile_PRINT_TILE_10000_158
;src/gbprinter.c:54: for (uint8_t i = sizeof(PRINT_TILE); i != 0; i--) printer_send_receive(*data++);
	ld	c, #0x06
00108$:
	ld	a, c
	or	a, a
	jr	Z, 00101$
	ld	a, (hl+)
	ld	e, a
	push	hl
	push	bc
	push	de
	ld	a, e
	call	_printer_send_receive
	pop	de
	pop	bc
	pop	hl
	dec	c
	jr	00108$
00101$:
;src/gbprinter.c:55: printer_CRC = 0x04 + 0x80 + 0x02;
	ld	hl, #_printer_print_tile_printer_CRC_10000_158
	ld	a, #0x86
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/gbprinter.c:57: for(uint8_t i = 0x10; i != 0; i--, tiledata++) {
00119$:
	ld	c, #0x10
	ldhl	sp,	#0
	ld	a, b
	ld	(hl+), a
	ld	(hl), d
00111$:
	ld	a, c
	or	a, a
	jr	Z, 00104$
;src/gbprinter.c:58: printer_CRC += *tiledata;
	pop	de
	push	de
	ld	a, (de)
	ld	hl, #_printer_print_tile_printer_CRC_10000_158
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	dec	hl
	ld	b, #0x00
	add	a, e
	ld	e, a
	ld	a, b
	adc	a, d
	ld	(hl), e
	inc	hl
	ld	(hl), a
;src/gbprinter.c:59: printer_send_receive(*tiledata);
	pop	de
	push	de
	ld	a, (de)
	ld	b, a
	push	bc
	ld	a, b
	call	_printer_send_receive
	pop	bc
;src/gbprinter.c:57: for(uint8_t i = 0x10; i != 0; i--, tiledata++) {
	dec	c
	ldhl	sp,	#0
	inc	(hl)
	jr	NZ, 00111$
	inc	hl
	inc	(hl)
	jr	00111$
00104$:
;src/gbprinter.c:61: if (++printer_tile_num == 40) {
	ld	hl, #_printer_tile_num
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x28
	jr	NZ, 00106$
;src/gbprinter.c:62: printer_send_receive((uint8_t)printer_CRC);
	ld	a, (#_printer_print_tile_printer_CRC_10000_158)
	call	_printer_send_receive
;src/gbprinter.c:63: printer_send_receive((uint8_t)(printer_CRC >> 8));
	ld	a, (#_printer_print_tile_printer_CRC_10000_158 + 1)
	call	_printer_send_receive
;src/gbprinter.c:64: printer_send_receive(0x00);
	xor	a, a
	call	_printer_send_receive
;src/gbprinter.c:65: printer_send_receive(0x00);
	xor	a, a
	call	_printer_send_receive
;src/gbprinter.c:66: printer_CRC = printer_tile_num = 0;
	ld	hl, #_printer_tile_num
	ld	(hl), #0x00
	xor	a, a
	ld	hl, #_printer_print_tile_printer_CRC_10000_158
	ld	(hl+), a
	ld	(hl), a
;src/gbprinter.c:67: return TRUE;
	ld	a, #0x01
	jr	00113$
00106$:
;src/gbprinter.c:69: return FALSE;
	xor	a, a
00113$:
;src/gbprinter.c:70: }
	inc	sp
	inc	sp
	ret
_printer_print_tile_PRINT_TILE_10000_158:
	.db #0x88	; 136
	.db #0x33	; 51	'3'
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x02	; 2
;src/gbprinter.c:79: uint8_t printer_wait(uint16_t timeout, uint8_t mask, uint8_t value) {
;	---------------------------------
; Function printer_wait
; ---------------------------------
_printer_wait::
	dec	sp
	ldhl	sp,	#0
	ld	(hl), a
;src/gbprinter.c:81: while (((error = PRINTER_SEND_COMMAND(PRN_PKT_STATUS)) & mask) != value) {
00107$:
	push	de
	ld	a, #0x0a
	ld	de, #_PRN_PKT_STATUS
	call	_printer_send_command
	pop	de
	ld	c, a
	ldhl	sp,	#0
	and	a, (hl)
	ld	b, a
	ldhl	sp,	#3
	ld	a, (hl)
	sub	a, b
	jr	Z, 00109$
;src/gbprinter.c:82: if (printer_check_cancel()) {
	push	bc
	push	de
	call	_printer_check_cancel
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	bit	0, l
	jr	Z, 00102$
;src/gbprinter.c:83: PRINTER_SEND_COMMAND(PRN_PKT_CANCEL);
	ld	a, #0x0a
	ld	de, #_PRN_PKT_CANCEL
	call	_printer_send_command
;src/gbprinter.c:84: return PRN_STATUS_CANCELLED;
	ld	a, #0x40
	jr	00110$
00102$:
;src/gbprinter.c:86: if (timeout-- == 0) return PRN_STATUS_MASK_ERRORS;
	ld	a, e
	ld	b, d
	dec	de
	or	a, b
	jr	NZ, 00104$
	ld	a, #0xf0
	jr	00110$
00104$:
;src/gbprinter.c:87: if (error & PRN_STATUS_MASK_ERRORS) break;
	ld	a, c
	and	a, #0xf0
	jr	NZ, 00109$
;src/gbprinter.c:88: vsync();
	call	_vsync
	jr	00107$
00109$:
;src/gbprinter.c:90: return error;
	ld	a, c
00110$:
;src/gbprinter.c:91: }
	inc	sp
	pop	hl
	inc	sp
	jp	(hl)
;src/gbprinter.c:93: uint8_t gbprinter_detect(uint8_t delay) {
;	---------------------------------
; Function gbprinter_detect
; ---------------------------------
_gbprinter_detect::
	ld	e, a
;src/gbprinter.c:73: printer_tile_num = 0;
	ld	hl, #_printer_tile_num
	ld	(hl), #0x00
;src/gbprinter.c:74: PRINTER_SEND_COMMAND(PRN_PKT_INIT);
	push	de
	ld	a, #0x0a
	ld	de, #_PRN_PKT_INIT
	call	_printer_send_command
	pop	de
;src/gbprinter.c:95: return printer_wait(delay, PRN_STATUS_MASK_ANY, PRN_STATUS_OK);
	xor	a, a
	ld	d, a
	push	af
	inc	sp
	ld	a, #0xff
	call	_printer_wait
;src/gbprinter.c:96: }
	ret
;src/gbprinter.c:98: uint8_t gbprinter_print_image(const uint8_t * image_map, const uint8_t * image, int8_t pos_x, uint8_t width, uint8_t height) {
;	---------------------------------
; Function gbprinter_print_image
; ---------------------------------
_gbprinter_print_image::
	add	sp, #-33
	ldhl	sp,	#27
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#25
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/gbprinter.c:102: uint8_t tile_data[16], rows = (((height + 1) >> 1) << 1), pkt_count = 0;
	ldhl	sp,	#37
	ld	c, (hl)
	xor	a, a
	ld	b, a
	inc	bc
	sra	b
	rr	c
	ld	a, c
	add	a, a
	ldhl	sp,	#18
	ld	(hl), a
	ldhl	sp,	#29
	ld	(hl), #0x00
;src/gbprinter.c:104: if ((rows >> 1) == 0) return PRN_STATUS_OK;
	ldhl	sp,	#18
	ld	a, (hl)
	srl	a
	ldhl	sp,	#32
	ld	(hl), a
	or	a, a
	jr	NZ, 00102$
	xor	a, a
	jp	00138$
00102$:
;src/gbprinter.c:106: img = image;
	ldhl	sp,	#25
	ld	a, (hl)
	ld	(#_gbprinter_print_image_img_10000_177),a
	ldhl	sp,	#26
	ld	a, (hl)
	ld	(#_gbprinter_print_image_img_10000_177 + 1),a
;src/gbprinter.c:108: printer_tile_num = 0;
	ld	hl, #_printer_tile_num
	ld	(hl), #0x00
;src/gbprinter.c:110: for (uint8_t y = 0; y != rows; y++) {
	ldhl	sp,	#30
	ld	(hl), #0x00
00136$:
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#30
	sub	a, (hl)
	jp	Z,00123$
;src/gbprinter.c:111: for (int16_t x = 0; x != PRN_TILE_WIDTH; x++) {
	ldhl	sp,	#30
	ld	a, (hl)
	ldhl	sp,	#37
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#19
	ld	(hl), a
	ldhl	sp,	#36
	ld	e, (hl)
	ldhl	sp,	#30
	ld	a, (hl)
	call	__muluchar
	ldhl	sp,	#20
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	xor	a, a
	ldhl	sp,	#31
	ld	(hl+), a
	ld	(hl), a
00133$:
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0x14
	or	a, (hl)
	jp	Z,00137$
;src/gbprinter.c:113: if ((y < height) && (x >= pos_x) && (x < (pos_x + width))) {
	ldhl	sp,	#19
	ld	a, (hl)
	or	a, a
	jp	Z, 00104$
	ldhl	sp,	#35
	ld	a, (hl)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ldhl	sp,	#31
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00277$
	bit	7, d
	jr	NZ, 00278$
	cp	a, a
	jr	00278$
00277$:
	bit	7, d
	jr	Z, 00278$
	scf
00278$:
	jr	C, 00104$
	ldhl	sp,	#35
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl+), a
	rlca
	sbc	a, a
	ld	(hl), a
	ldhl	sp,	#36
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#23
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00279$
	bit	7, d
	jr	NZ, 00280$
	cp	a, a
	jr	00280$
00279$:
	bit	7, d
	jr	Z, 00280$
	scf
00280$:
	jr	NC, 00104$
;src/gbprinter.c:114: uint8_t tile = image_map[(y * width) + (x - pos_x)];
	pop	de
	push	de
	ldhl	sp,	#23
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	b, a
	ld	c, e
	ldhl	sp,	#20
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#27
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
;src/gbprinter.c:115: memcpy(tile_data, img + ((uint16_t)tile << 4), sizeof(tile_data));
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	a, c
	ld	hl, #_gbprinter_print_image_img_10000_177
	add	a, (hl)
	inc	hl
	ld	c, a
	ld	a, b
	adc	a, (hl)
	ld	b, a
	ld	de, #0x0010
	push	de
	ld	hl, #4
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_memcpy
	jr	00105$
00104$:
;src/gbprinter.c:117: memset(tile_data, 0, sizeof(tile_data));
	ld	hl, #2
	add	hl, sp
	ld	de, #0x0010
	push	de
	ld	de, #0x0000
	push	de
	push	hl
	call	_memset
	add	sp, #6
00105$:
;src/gbprinter.c:120: if (printer_print_tile(tile_data)) {
	ld	hl, #2
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_printer_print_tile
	or	a, a
	jr	Z, 00111$
;src/gbprinter.c:121: pkt_count++;
	ldhl	sp,	#29
	inc	(hl)
;src/gbprinter.c:122: if (printer_check_cancel()) {
	call	_printer_check_cancel
	bit	0,a
	jr	Z, 00111$
;src/gbprinter.c:123: PRINTER_SEND_COMMAND(PRN_PKT_CANCEL);
	ld	a, #0x0a
	ld	de, #_PRN_PKT_CANCEL
	call	_printer_send_command
;src/gbprinter.c:124: return PRN_STATUS_CANCELLED;
	ld	a, #0x40
	jp	00138$
00111$:
;src/gbprinter.c:127: if (pkt_count == 9) {
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x09
	jp	NZ,00134$
;src/gbprinter.c:128: pkt_count = 0;
	ldhl	sp,	#29
	ld	(hl), #0x00
;src/gbprinter.c:129: PRINTER_SEND_COMMAND(PRN_PKT_EOF);
	ld	a, #0x0a
	ld	de, #_PRN_PKT_EOF
	call	_printer_send_command
;src/gbprinter.c:131: gbprinter_set_print_params((y == (rows - 1)) ? PRN_FINAL_MARGIN : PRN_NO_MARGINS, PRN_PALETTE_NORMAL, PRN_EXPOSURE_DARK);
	ldhl	sp,	#18
	ld	c, (hl)
	xor	a, a
	ld	b, a
	dec	bc
	ldhl	sp,	#30
	ld	e, (hl)
	ld	d, #0x00
	ld	a, e
	sub	a, c
	jr	NZ, 00283$
	ld	a, d
	sub	a, b
	ld	a, #0x01
	jr	Z, 00284$
00283$:
	xor	a, a
00284$:
	ldhl	sp,	#22
	ld	(hl), a
	or	a, a
	ld	c, #0x03
	jr	NZ, 00141$
	ld	c, #0x00
00141$:
;src/gbprinter.h:138: PRN_PKT_START.crc = ((PRN_CMD_PRINT + 0x04u + 0x01u) + (PRN_PKT_START.margins = margins) + (PRN_PKT_START.palette = palette) + (PRN_PKT_START.exposure = exposure));
	ld	hl, #(_PRN_PKT_START + 7)
	ld	(hl), c
	ld	b, #0x00
	ld	hl, #_PRN_PKT_START + 8
	ld	(hl), #0xe4
	ld	hl, #_PRN_PKT_START + 9
	ld	(hl), #0x7f
	ld	hl, #0x016a
	add	hl, bc
	ld	c, l
	ld	a, h
	ldhl	sp,	#23
	ld	(hl), c
	inc	hl
	ld	(hl-), a
	ld	de, #(_PRN_PKT_START + 10)
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/gbprinter.c:132: PRINTER_SEND_COMMAND(PRN_PKT_START);
	ld	a, #0x0e
	ld	de, #_PRN_PKT_START
	call	_printer_send_command
;src/gbprinter.c:134: if ((error = printer_wait(PRN_BUSY_TIMEOUT, PRN_STATUS_BUSY, PRN_STATUS_BUSY)) & PRN_STATUS_MASK_ERRORS) return error;
	ld	a, #0x02
	push	af
	inc	sp
	ld	a, #0x02
	ld	de, #0x0078
	call	_printer_wait
	ld	(#_gbprinter_print_image_error_10000_177),a
	and	a, #0xf0
	jr	Z, 00113$
	ld	a, (#_gbprinter_print_image_error_10000_177)
	jp	00138$
00113$:
;src/gbprinter.c:135: if ((error = printer_wait(PRN_COMPLETION_TIMEOUT, PRN_STATUS_BUSY, 0)) & PRN_STATUS_MASK_ERRORS) return error;
	xor	a, a
	push	af
	inc	sp
	ld	a, #0x02
	ld	de, #0x04b0
	call	_printer_wait
	ld	(#_gbprinter_print_image_error_10000_177),a
	and	a, #0xf0
	jr	Z, 00115$
	ld	a, (#_gbprinter_print_image_error_10000_177)
	jp	00138$
00115$:
;src/gbprinter.c:138: if (y != (rows - 1)) {
	ldhl	sp,	#22
	bit	0, (hl)
	jr	NZ, 00134$
;src/gbprinter.c:139: PRINTER_SEND_COMMAND(PRN_PKT_INIT);
	ld	a, #0x0a
	ld	de, #_PRN_PKT_INIT
	call	_printer_send_command
;src/gbprinter.c:140: if (error = printer_wait(PRN_SEIKO_RESET_TIMEOUT, PRN_STATUS_MASK_ANY, PRN_STATUS_OK)) return error;
	xor	a, a
	push	af
	inc	sp
	ld	a, #0xff
	ld	de, #0x000a
	call	_printer_wait
	ld	(#_gbprinter_print_image_error_10000_177),a
	or	a,a
	jr	NZ, 00138$
00134$:
;src/gbprinter.c:111: for (int16_t x = 0; x != PRN_TILE_WIDTH; x++) {
	ldhl	sp,	#31
	inc	(hl)
	jp	NZ,00133$
	inc	hl
	inc	(hl)
	jp	00133$
00137$:
;src/gbprinter.c:110: for (uint8_t y = 0; y != rows; y++) {
	ldhl	sp,	#30
	inc	(hl)
	jp	00136$
00123$:
;src/gbprinter.c:146: if (pkt_count) {
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	Z, 00129$
;src/gbprinter.c:147: PRINTER_SEND_COMMAND(PRN_PKT_EOF);
	ld	a, #0x0a
	ld	de, #_PRN_PKT_EOF
	call	_printer_send_command
;src/gbprinter.h:138: PRN_PKT_START.crc = ((PRN_CMD_PRINT + 0x04u + 0x01u) + (PRN_PKT_START.margins = margins) + (PRN_PKT_START.palette = palette) + (PRN_PKT_START.exposure = exposure));
	ld	hl, #_PRN_PKT_START + 7
	ld	(hl), #0x03
	ld	hl, #_PRN_PKT_START + 8
	ld	(hl), #0xe4
	ld	hl, #_PRN_PKT_START + 9
	ld	(hl), #0x7f
	ld	hl, #(_PRN_PKT_START + 10)
	ld	a, #0x6d
	ld	(hl+), a
	ld	(hl), #0x01
;src/gbprinter.c:150: PRINTER_SEND_COMMAND(PRN_PKT_START);
	ld	a, #0x0e
	ld	de, #_PRN_PKT_START
	call	_printer_send_command
;src/gbprinter.c:152: if ((error = printer_wait(PRN_BUSY_TIMEOUT, PRN_STATUS_BUSY, PRN_STATUS_BUSY)) & PRN_STATUS_MASK_ERRORS) return error;
	ld	a, #0x02
	push	af
	inc	sp
	ld	a, #0x02
	ld	de, #0x0078
	call	_printer_wait
	ld	(#_gbprinter_print_image_error_10000_177),a
	and	a, #0xf0
	jr	Z, 00125$
	ld	a, (#_gbprinter_print_image_error_10000_177)
	jr	00138$
00125$:
;src/gbprinter.c:153: if ((error = printer_wait(PRN_COMPLETION_TIMEOUT, PRN_STATUS_BUSY, 0)) & PRN_STATUS_MASK_ERRORS) return error;
	xor	a, a
	push	af
	inc	sp
	ld	a, #0x02
	ld	de, #0x04b0
	call	_printer_wait
	ld	(#_gbprinter_print_image_error_10000_177),a
	and	a, #0xf0
	jr	Z, 00129$
	ld	a, (#_gbprinter_print_image_error_10000_177)
	jr	00138$
00129$:
;src/gbprinter.c:155: return PRINTER_SEND_COMMAND(PRN_PKT_STATUS);
	ld	a, #0x0a
	ld	de, #_PRN_PKT_STATUS
	call	_printer_send_command
	ldhl	sp,#32
	ld	(hl), a
00138$:
;src/gbprinter.c:156: }
	add	sp, #33
	pop	hl
	add	sp, #3
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
__xinit__PRN_PKT_START:
	.dw #0x3388
	.dw #0x0002
	.dw #0x0004
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xe4	; 228
	.db #0x7f	; 127
	.dw #0x0000
	.dw #0x0000
	.area _CABS (ABS)
