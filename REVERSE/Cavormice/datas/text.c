#include <gb/gb.h>

#define TEXT_FONT_OFFSET 0xD0

#define _TEXT_CHAR_A              TEXT_FONT_OFFSET
#define _TEXT_CHAR_0              TEXT_FONT_OFFSET + 26
#define _TEXT_CHAR_APOSTROPHE     TEXT_FONT_OFFSET + 26 + 10 + 0
#define _TEXT_CHAR_DASH           TEXT_FONT_OFFSET + 26 + 10 + 1
#define _TEXT_CHAR_DOT            TEXT_FONT_OFFSET + 26 + 10 + 2
#define _TEXT_CHAR_COMMA          TEXT_FONT_OFFSET + 26 + 10 + 3
#define _TEXT_CHAR_COLON          TEXT_FONT_OFFSET + 26 + 10 + 4
#define _TEXT_CHAR_EXCLAMATION    TEXT_FONT_OFFSET + 26 + 10 + 5
#define _TEXT_CHAR_INTERROGATION  TEXT_FONT_OFFSET + 26 + 10 + 6
#define _TEXT_CHAR_LPARENTHESES   TEXT_FONT_OFFSET + 26 + 10 + 7
#define _TEXT_CHAR_RPARENTHESES   TEXT_FONT_OFFSET + 26 + 10 + 8
#define _TEXT_CHAR_TOFU           TEXT_FONT_OFFSET + 26 + 10 + 9
#define _TEXT_CHAR_BORDER         TEXT_FONT_OFFSET + 26 + 10 + 10
#define _TEXT_CHAR_SPACE          TEXT_FONT_OFFSET + 26 + 10 + 11

#define FONT_TILESET_TILE_COUNT 48
const UINT8 FONT_TILESET[] = {
    0x3C, 0x3C, 0x66, 0x66, 0x66, 0x66, 0x7E, 0x7E, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x00, 0x00,
    0x7C, 0x7C, 0x66, 0x66, 0x66, 0x66, 0x7C, 0x7C, 0x66, 0x66, 0x66, 0x66, 0x7C, 0x7C, 0x00, 0x00,
    0x3C, 0x3C, 0x62, 0x62, 0x60, 0x60, 0x60, 0x60, 0x60, 0x60, 0x62, 0x62, 0x3C, 0x3C, 0x00, 0x00,
    0x7C, 0x7C, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x7C, 0x7C, 0x00, 0x00,
    0x7E, 0x7E, 0x60, 0x60, 0x60, 0x60, 0x7C, 0x7C, 0x60, 0x60, 0x60, 0x60, 0x7E, 0x7E, 0x00, 0x00,
    0x7E, 0x7E, 0x60, 0x60, 0x60, 0x60, 0x7C, 0x7C, 0x60, 0x60, 0x60, 0x60, 0x60, 0x60, 0x00, 0x00,
    0x3C, 0x3C, 0x62, 0x62, 0x60, 0x60, 0x6E, 0x6E, 0x66, 0x66, 0x66, 0x66, 0x3E, 0x3E, 0x00, 0x00,
    0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x7E, 0x7E, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x00, 0x00,
    0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x00, 0x00,
    0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x46, 0x46, 0x3C, 0x3C, 0x00, 0x00,
    0x66, 0x66, 0x6C, 0x6C, 0x78, 0x78, 0x70, 0x70, 0x78, 0x78, 0x6C, 0x6C, 0x66, 0x66, 0x00, 0x00,
    0x60, 0x60, 0x60, 0x60, 0x60, 0x60, 0x60, 0x60, 0x60, 0x60, 0x60, 0x60, 0x7C, 0x7C, 0x00, 0x00,
    0xFC, 0xFC, 0xD6, 0xD6, 0xD6, 0xD6, 0xD6, 0xD6, 0xD6, 0xD6, 0xC6, 0xC6, 0xC6, 0xC6, 0x00, 0x00,
    0x62, 0x62, 0x72, 0x72, 0x7A, 0x7A, 0x5E, 0x5E, 0x4E, 0x4E, 0x46, 0x46, 0x42, 0x42, 0x00, 0x00,
    0x3C, 0x3C, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x3C, 0x3C, 0x00, 0x00,
    0x7C, 0x7C, 0x66, 0x66, 0x66, 0x66, 0x7C, 0x7C, 0x60, 0x60, 0x60, 0x60, 0x60, 0x60, 0x00, 0x00,
    0x3C, 0x3C, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x3C, 0x3C, 0x06, 0x06,
    0x7C, 0x7C, 0x66, 0x66, 0x66, 0x66, 0x7C, 0x7C, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x00, 0x00,
    0x3C, 0x3C, 0x62, 0x62, 0x70, 0x70, 0x3C, 0x3C, 0x0E, 0x0E, 0x46, 0x46, 0x3C, 0x3C, 0x00, 0x00,
    0x7E, 0x7E, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x00, 0x00,
    0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x3C, 0x3C, 0x00, 0x00,
    0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x64, 0x64, 0x78, 0x78, 0x00, 0x00,
    0xC6, 0xC6, 0xC6, 0xC6, 0xC6, 0xC6, 0xD6, 0xD6, 0xD6, 0xD6, 0xD6, 0xD6, 0xFC, 0xFC, 0x00, 0x00,
    0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x3C, 0x3C, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x00, 0x00,
    0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x3C, 0x3C, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x00, 0x00,
    0x7E, 0x7E, 0x0E, 0x0E, 0x1C, 0x1C, 0x38, 0x38, 0x70, 0x70, 0x60, 0x60, 0x7E, 0x7E, 0x00, 0x00,
    0x3C, 0x3C, 0x66, 0x66, 0x6E, 0x6E, 0x76, 0x76, 0x66, 0x66, 0x66, 0x66, 0x3C, 0x3C, 0x00, 0x00,
    0x18, 0x18, 0x38, 0x38, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x00, 0x00,
    0x3C, 0x3C, 0x66, 0x66, 0x0E, 0x0E, 0x1C, 0x1C, 0x38, 0x38, 0x70, 0x70, 0x7E, 0x7E, 0x00, 0x00,
    0x7E, 0x7E, 0x0C, 0x0C, 0x18, 0x18, 0x3C, 0x3C, 0x06, 0x06, 0x46, 0x46, 0x3C, 0x3C, 0x00, 0x00,
    0x0C, 0x0C, 0x1C, 0x1C, 0x2C, 0x2C, 0x4C, 0x4C, 0x7E, 0x7E, 0x0C, 0x0C, 0x0C, 0x0C, 0x00, 0x00,
    0x7E, 0x7E, 0x60, 0x60, 0x7C, 0x7C, 0x06, 0x06, 0x06, 0x06, 0x46, 0x46, 0x3C, 0x3C, 0x00, 0x00,
    0x1C, 0x1C, 0x20, 0x20, 0x60, 0x60, 0x7C, 0x7C, 0x66, 0x66, 0x66, 0x66, 0x3C, 0x3C, 0x00, 0x00,
    0x7E, 0x7E, 0x06, 0x06, 0x0E, 0x0E, 0x1C, 0x1C, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x00, 0x00,
    0x3C, 0x3C, 0x66, 0x66, 0x66, 0x66, 0x3C, 0x3C, 0x66, 0x66, 0x66, 0x66, 0x3C, 0x3C, 0x00, 0x00,
    0x3C, 0x3C, 0x66, 0x66, 0x66, 0x66, 0x3E, 0x3E, 0x06, 0x06, 0x0C, 0x0C, 0x38, 0x38, 0x00, 0x00,
    0x18, 0x18, 0x18, 0x18, 0x10, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3C, 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x18, 0x18, 0x18, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x30, 0x30, 0x30, 0x20, 0x20,
    0x00, 0x00, 0x18, 0x18, 0x18, 0x18, 0x00, 0x00, 0x00, 0x00, 0x18, 0x18, 0x18, 0x18, 0x00, 0x00,
    0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x00, 0x00, 0x18, 0x18, 0x00, 0x00,
    0x3C, 0x3C, 0x46, 0x46, 0x06, 0x06, 0x0C, 0x0C, 0x18, 0x18, 0x18, 0x18, 0x00, 0x00, 0x18, 0x18,
    0x04, 0x04, 0x08, 0x08, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x08, 0x08, 0x04, 0x04,
    0x20, 0x20, 0x10, 0x10, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x10, 0x10, 0x20, 0x20,
    0x00, 0xFE, 0x7C, 0x82, 0x7C, 0x82, 0x7C, 0x82, 0x7C, 0x82, 0x7C, 0x82, 0x00, 0xFE, 0x00, 0x00,
    0xFF, 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
};


void text_load_font() {
    set_bkg_data(TEXT_FONT_OFFSET, FONT_TILESET_TILE_COUNT, FONT_TILESET);
}

// Write the given char at the (x, y) position on the Background layer
void text_print_char_bkg(UINT8 x, UINT8 y, unsigned char chr) {
    UINT8 tile = _TEXT_CHAR_TOFU;

    if (chr >= 'a' && chr <= 'z') {
        tile = _TEXT_CHAR_A + chr - 'a';
    } else if (chr >= 'A' && chr <= 'Z') {
        tile = _TEXT_CHAR_A + chr - 'A';
    } else if (chr >= '0' && chr <= '9') {
        tile = _TEXT_CHAR_0 + chr - '0';
    } else {
        switch (chr) {
            case '\'':
                tile = _TEXT_CHAR_APOSTROPHE;
                break;
            case '-':
                tile = _TEXT_CHAR_DASH;
                break;
            case '.':
                tile = _TEXT_CHAR_DOT;
                break;
            case ',':
                tile = _TEXT_CHAR_COMMA;
                break;
            case ':':
                tile = _TEXT_CHAR_COLON;
                break;
            case '!':
                tile = _TEXT_CHAR_EXCLAMATION;
                break;
            case '?':
                tile = _TEXT_CHAR_INTERROGATION;
                break;
            case '(':
                tile = _TEXT_CHAR_LPARENTHESES;
                break;
            case ')':
                tile = _TEXT_CHAR_RPARENTHESES;
                break;
            case ' ':
                tile = _TEXT_CHAR_SPACE;
                break;
        }
    }

    set_bkg_tiles(x, y, 1, 1, &tile);
}

// Write the given string at the (x, y) position on the Background layer
// Line feed (\n) allowed
void text_print_string_bkg(UINT8 x, UINT8 y, unsigned char *string) {
    UINT8 offset_x = 0;
    UINT8 offset_y = 0;

    while (string[0]) {
        if (string[0] == '\n') {
            offset_x = 0;
            offset_y += 1;
        } else {
            text_print_char_bkg(x + offset_x, y + offset_y, (unsigned char) string[0]);
            offset_x += 1;
        }

        string += 1;  // Increment pointer address, /!\ THIS IS DANGEROUS!
    }
}