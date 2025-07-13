// Set PETSCII mixed case (lower/upper) mode for C64
#define VIC_BANK 0xD018
#define CHARSET_LOWER_UPPER 0x14 // 00010100b: screen at $0400, charset at $1800 (lower/upper)

void oscar_set_mixed_case(void) {
    // Set VIC-II to use lowercase/uppercase character set
    *(unsigned char*)VIC_BANK = CHARSET_LOWER_UPPER;
}

