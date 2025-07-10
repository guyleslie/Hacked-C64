#ifndef OSCAR64_CONSOLE_H
#define OSCAR64_CONSOLE_H

// Oscar64 specific console functions
void oscar_clrscr(void);
void oscar_gotoxy(unsigned char x, unsigned char y);
void oscar_cputc(unsigned char c);

#endif // OSCAR64_CONSOLE_H
