; Compiled with 1.31.261.0
--------------------------------------------------------------------
startup: ; startup
0801 : 0b __ __ INV
0802 : 08 __ __ PHP
0803 : 0a __ __ ASL
0804 : 00 __ __ BRK
0805 : 9e __ __ INV
0806 : 32 __ __ INV
0807 : 30 36 __ BMI $083f ; (startup + 62)
0809 : 31 00 __ AND ($00),y 
080b : 00 __ __ BRK
080c : 00 __ __ BRK
080d : ba __ __ TSX
080e : 8e ff 31 STX $31ff ; (spentry + 0)
0811 : a2 33 __ LDX #$33
0813 : a0 64 __ LDY #$64
0815 : a9 00 __ LDA #$00
0817 : 85 19 __ STA IP + 0 
0819 : 86 1a __ STX IP + 1 
081b : e0 41 __ CPX #$41
081d : f0 0b __ BEQ $082a ; (startup + 41)
081f : 91 19 __ STA (IP + 0),y 
0821 : c8 __ __ INY
0822 : d0 fb __ BNE $081f ; (startup + 30)
0824 : e8 __ __ INX
0825 : d0 f2 __ BNE $0819 ; (startup + 24)
0827 : 91 19 __ STA (IP + 0),y 
0829 : c8 __ __ INY
082a : c0 a0 __ CPY #$a0
082c : d0 f9 __ BNE $0827 ; (startup + 38)
082e : a9 00 __ LDA #$00
0830 : a2 f7 __ LDX #$f7
0832 : d0 03 __ BNE $0837 ; (startup + 54)
0834 : 95 00 __ STA $00,x 
0836 : e8 __ __ INX
0837 : e0 f7 __ CPX #$f7
0839 : d0 f9 __ BNE $0834 ; (startup + 51)
083b : a9 15 __ LDA #$15
083d : 85 23 __ STA SP + 0 
083f : a9 9f __ LDA #$9f
0841 : 85 24 __ STA SP + 1 
0843 : 20 80 08 JSR $0880 ; (main.s0 + 0)
0846 : a9 4c __ LDA #$4c
0848 : 85 54 __ STA $54 
084a : a9 00 __ LDA #$00
084c : 85 13 __ STA P6 
084e : a9 19 __ LDA #$19
0850 : 85 16 __ STA P9 
0852 : 60 __ __ RTS
--------------------------------------------------------------------
main: ; main()->i16
.s0:
;  35, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
0880 : 20 0e 09 JSR $090e ; (mapgen_init.s0 + 0)
;  36, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
0883 : 20 65 0b JSR $0b65 ; (oscar_clrscr.s0 + 0)
;  38, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
0886 : 20 98 0b JSR $0b98 ; (mapgen_generate_dungeon.s0 + 0)
;  40, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
0889 : a9 74 __ LDA #$74
088b : 85 0d __ STA P0 
088d : a9 29 __ LDA #$29
088f : 85 0e __ STA P1 
0891 : 20 5e 29 JSR $295e ; (krnio_setnam.s0 + 0)
;  42, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
0894 : a9 08 __ LDA #$08
0896 : 85 0d __ STA P0 
0898 : a9 3d __ LDA #$3d
089a : 85 11 __ STA P4 
089c : a9 52 __ LDA #$52
089e : 85 0e __ STA P1 
08a0 : a9 37 __ LDA #$37
08a2 : 85 0f __ STA P2 
08a4 : a9 52 __ LDA #$52
08a6 : 85 10 __ STA P3 
08a8 : 20 80 29 JSR $2980 ; (krnio_save.s0 + 0)
08ab : aa __ __ TAX
08ac : d0 0b __ BNE $08b9 ; (main.l19 + 0)
.s45:
;  65, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08ae : a9 22 __ LDA #$22
08b0 : 85 0f __ STA P2 
08b2 : a9 2a __ LDA #$2a
08b4 : 85 10 __ STA P3 
08b6 : 20 a0 29 JSR $29a0 ; (puts.l1 + 0)
.l19:
;  47, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08b9 : a9 01 __ LDA #$01
08bb : d0 07 __ BNE $08c4 ; (main.l6 + 0)
.s13:
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08bd : 85 0d __ STA P0 
08bf : 20 f7 2f JSR $2ff7 ; (process_navigation_input.s0 + 0)
;  73, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08c2 : a9 00 __ LDA #$00
.l6:
;  47, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08c4 : 85 14 __ STA P7 
08c6 : 20 33 2a JSR $2a33 ; (render_map_viewport.s0 + 0)
;  51, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08c9 : 20 b6 2f JSR $2fb6 ; (getch.l1 + 0)
08cc : 8d 17 9f STA $9f17 ; (key + 0)
;  53, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08cf : c9 51 __ CMP #$51
08d1 : f0 31 __ BEQ $0904 ; (main.s8 + 0)
.s9:
;  57, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08d3 : c9 20 __ CMP #$20
08d5 : d0 e6 __ BNE $08bd ; (main.s13 + 0)
.s12:
;  58, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08d7 : 20 65 0b JSR $0b65 ; (oscar_clrscr.s0 + 0)
;  60, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08da : 20 98 0b JSR $0b98 ; (mapgen_generate_dungeon.s0 + 0)
;  62, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08dd : a9 74 __ LDA #$74
08df : 85 0d __ STA P0 
08e1 : a9 29 __ LDA #$29
08e3 : 85 0e __ STA P1 
08e5 : 20 5e 29 JSR $295e ; (krnio_setnam.s0 + 0)
;  63, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08e8 : a9 08 __ LDA #$08
08ea : 85 0d __ STA P0 
08ec : a9 3d __ LDA #$3d
08ee : 85 11 __ STA P4 
08f0 : a9 52 __ LDA #$52
08f2 : 85 0e __ STA P1 
08f4 : a9 37 __ LDA #$37
08f6 : 85 0f __ STA P2 
08f8 : a9 52 __ LDA #$52
08fa : 85 10 __ STA P3 
08fc : 20 80 29 JSR $2980 ; (krnio_save.s0 + 0)
08ff : aa __ __ TAX
0900 : d0 b7 __ BNE $08b9 ; (main.l19 + 0)
0902 : f0 aa __ BEQ $08ae ; (main.s45 + 0)
.s8:
;  54, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
0904 : 20 65 0b JSR $0b65 ; (oscar_clrscr.s0 + 0)
;  77, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
0907 : a9 00 __ LDA #$00
0909 : 85 1b __ STA ACCU + 0 
090b : 85 1c __ STA ACCU + 1 
.s1001:
090d : 60 __ __ RTS
--------------------------------------------------------------------
mapgen_init: ; mapgen_init()->void
.s0:
;  48, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
090e : 4c 11 09 JMP $0911 ; (init_rng.s0 + 0)
--------------------------------------------------------------------
init_rng: ; init_rng()->void
.s0:
;  67, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0911 : 20 5e 0a JSR $0a5e ; (get_hardware_entropy.s0 + 0)
0914 : a5 1b __ LDA ACCU + 0 
0916 : 85 48 __ STA T3 + 0 
0918 : 8d f3 9f STA $9ff3 ; (room1_buffer_x1 + 0)
091b : a5 1c __ LDA ACCU + 1 
091d : 85 49 __ STA T3 + 1 
091f : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
;  68, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0922 : 20 5e 0a JSR $0a5e ; (get_hardware_entropy.s0 + 0)
0925 : a5 1b __ LDA ACCU + 0 
0927 : 85 4a __ STA T4 + 0 
0929 : 8d f1 9f STA $9ff1 ; (cell_h + 0)
092c : a5 1c __ LDA ACCU + 1 
092e : 85 4b __ STA T4 + 1 
0930 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
;  69, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0933 : 20 5e 0a JSR $0a5e ; (get_hardware_entropy.s0 + 0)
0936 : a5 1b __ LDA ACCU + 0 
0938 : 85 46 __ STA T2 + 0 
093a : 8d ef 9f STA $9fef ; (screen_pos + 1)
093d : a5 1c __ LDA ACCU + 1 
093f : 85 47 __ STA T2 + 1 
0941 : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
;  70, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0944 : 20 5e 0a JSR $0a5e ; (get_hardware_entropy.s0 + 0)
0947 : a5 1b __ LDA ACCU + 0 
0949 : 8d ed 9f STA $9fed ; (extra_range_y + 0)
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
094c : a9 00 __ LDA #$00
094e : 8d 19 32 STA $3219 ; (generation_counter + 1)
;  81, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0951 : 8d ec 9f STA $9fec ; (random_offset_x + 0)
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0954 : a9 01 __ LDA #$01
0956 : 8d 18 32 STA $3218 ; (generation_counter + 0)
;  70, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0959 : a5 4a __ LDA T4 + 0 
095b : 0a __ __ ASL
095c : 85 44 __ STA T1 + 0 
095e : a5 4b __ LDA T4 + 1 
0960 : 2a __ __ ROL
0961 : 06 44 __ ASL T1 + 0 
0963 : 2a __ __ ROL
0964 : 06 44 __ ASL T1 + 0 
0966 : 2a __ __ ROL
0967 : 45 49 __ EOR T3 + 1 
0969 : aa __ __ TAX
096a : a5 44 __ LDA T1 + 0 
096c : 45 48 __ EOR T3 + 0 
096e : 85 44 __ STA T1 + 0 
0970 : a5 46 __ LDA T2 + 0 
0972 : 46 47 __ LSR T2 + 1 
0974 : 6a __ __ ROR
0975 : 46 47 __ LSR T2 + 1 
0977 : 6a __ __ ROR
0978 : 45 44 __ EOR T1 + 0 
097a : a8 __ __ TAY
097b : 8a __ __ TXA
097c : 45 47 __ EOR T2 + 1 
097e : 85 45 __ STA T1 + 1 
0980 : a5 1c __ LDA ACCU + 1 
0982 : 8d ee 9f STA $9fee ; (entropy4 + 1)
;  75, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0985 : 06 1b __ ASL ACCU + 0 
0987 : 2a __ __ ROL
0988 : 06 1b __ ASL ACCU + 0 
098a : 2a __ __ ROL
098b : 06 1b __ ASL ACCU + 0 
098d : 2a __ __ ROL
098e : 06 1b __ ASL ACCU + 0 
0990 : 2a __ __ ROL
0991 : 06 1b __ ASL ACCU + 0 
0993 : 2a __ __ ROL
0994 : 45 45 __ EOR T1 + 1 
0996 : 8d 1b 32 STA $321b ; (rng_seed + 1)
0999 : 98 __ __ TYA
099a : 45 1b __ EOR ACCU + 0 
099c : 49 80 __ EOR #$80
099e : 8d 1a 32 STA $321a ; (rng_seed + 0)
;  76, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
09a1 : 0a __ __ ASL
09a2 : 85 44 __ STA T1 + 0 
09a4 : ad 1b 32 LDA $321b ; (rng_seed + 1)
09a7 : 2a __ __ ROL
09a8 : 06 44 __ ASL T1 + 0 
09aa : 2a __ __ ROL
09ab : 06 44 __ ASL T1 + 0 
09ad : 2a __ __ ROL
09ae : 06 44 __ ASL T1 + 0 
09b0 : 2a __ __ ROL
09b1 : 06 44 __ ASL T1 + 0 
09b3 : 2a __ __ ROL
09b4 : aa __ __ TAX
09b5 : ad 1b 32 LDA $321b ; (rng_seed + 1)
09b8 : 4a __ __ LSR
09b9 : 4a __ __ LSR
09ba : 4a __ __ LSR
09bb : 45 44 __ EOR T1 + 0 
09bd : 49 1d __ EOR #$1d
09bf : 8d 1a 32 STA $321a ; (rng_seed + 0)
09c2 : 8a __ __ TXA
09c3 : 49 ac __ EOR #$ac
09c5 : 8d 1b 32 STA $321b ; (rng_seed + 1)
;  78, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
09c8 : ad 1a 32 LDA $321a ; (rng_seed + 0)
09cb : 49 37 __ EOR #$37
09cd : 8d 1a 32 STA $321a ; (rng_seed + 0)
09d0 : ad 1b 32 LDA $321b ; (rng_seed + 1)
09d3 : 49 9e __ EOR #$9e
09d5 : 8d 1b 32 STA $321b ; (rng_seed + 1)
;  79, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
09d8 : 18 __ __ CLC
09d9 : a5 4a __ LDA T4 + 0 
09db : 65 48 __ ADC T3 + 0 
09dd : 85 1b __ STA ACCU + 0 
09df : a5 4b __ LDA T4 + 1 
09e1 : 65 49 __ ADC T3 + 1 
09e3 : 85 1c __ STA ACCU + 1 
09e5 : a9 2f __ LDA #$2f
09e7 : 85 03 __ STA WORK + 0 
09e9 : a9 5a __ LDA #$5a
09eb : 85 04 __ STA WORK + 1 
09ed : 20 34 31 JSR $3134 ; (mul16 + 0)
09f0 : a5 05 __ LDA WORK + 2 
09f2 : 4d 1a 32 EOR $321a ; (rng_seed + 0)
09f5 : 8d 1a 32 STA $321a ; (rng_seed + 0)
09f8 : a5 06 __ LDA WORK + 3 
09fa : 4d 1b 32 EOR $321b ; (rng_seed + 1)
09fd : 8d 1b 32 STA $321b ; (rng_seed + 1)
.l2:
;  82, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a00 : ad 1a 32 LDA $321a ; (rng_seed + 0)
0a03 : 0a __ __ ASL
0a04 : 85 44 __ STA T1 + 0 
0a06 : ad 1b 32 LDA $321b ; (rng_seed + 1)
0a09 : 2a __ __ ROL
0a0a : 06 44 __ ASL T1 + 0 
0a0c : 2a __ __ ROL
0a0d : 06 44 __ ASL T1 + 0 
0a0f : 2a __ __ ROL
0a10 : 85 45 __ STA T1 + 1 
0a12 : ad 1b 32 LDA $321b ; (rng_seed + 1)
0a15 : 4a __ __ LSR
0a16 : 4a __ __ LSR
0a17 : 4a __ __ LSR
0a18 : 4a __ __ LSR
0a19 : 4a __ __ LSR
0a1a : 45 44 __ EOR T1 + 0 
0a1c : ac ec 9f LDY $9fec ; (random_offset_x + 0)
0a1f : 59 00 32 EOR $3200,y ; (__multab7982L + 0)
0a22 : 8d 1a 32 STA $321a ; (rng_seed + 0)
0a25 : aa __ __ TAX
0a26 : b9 09 32 LDA $3209,y ; (__multab7982H + 0)
0a29 : 45 45 __ EOR T1 + 1 
0a2b : 85 1c __ STA ACCU + 1 
0a2d : 8d 1b 32 STA $321b ; (rng_seed + 1)
;  81, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a30 : ee ec 9f INC $9fec ; (random_offset_x + 0)
0a33 : ad ec 9f LDA $9fec ; (random_offset_x + 0)
0a36 : c9 04 __ CMP #$04
0a38 : 90 c6 __ BCC $0a00 ; (init_rng.l2 + 0)
.s4:
;  87, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a3a : a9 00 __ LDA #$00
0a3c : 8d ec 9f STA $9fec ; (random_offset_x + 0)
;  85, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a3f : 8a __ __ TXA
0a40 : 05 1c __ ORA ACCU + 1 
0a42 : d0 0a __ BNE $0a4e ; (init_rng.l9 + 0)
.s5:
0a44 : a9 22 __ LDA #$22
0a46 : 8d 1a 32 STA $321a ; (rng_seed + 0)
0a49 : a9 1d __ LDA #$1d
0a4b : 8d 1b 32 STA $321b ; (rng_seed + 1)
.l9:
;  88, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a4e : a9 ff __ LDA #$ff
0a50 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
;  87, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a53 : ee ec 9f INC $9fec ; (random_offset_x + 0)
0a56 : ad ec 9f LDA $9fec ; (random_offset_x + 0)
0a59 : c9 08 __ CMP #$08
0a5b : 90 f1 __ BCC $0a4e ; (init_rng.l9 + 0)
.s1001:
;  90, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a5d : 60 __ __ RTS
--------------------------------------------------------------------
get_hardware_entropy: ; get_hardware_entropy()->u16
.s0:
;  59, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a5e : ad 12 d0 LDA $d012 
0a61 : 4d 04 dc EOR $dc04 
0a64 : 85 1b __ STA ACCU + 0 
0a66 : ad 05 dc LDA $dc05 
0a69 : 85 1c __ STA ACCU + 1 
.s1001:
0a6b : 60 __ __ RTS
--------------------------------------------------------------------
rnd: ; rnd(u8)->u8
.s0:
; 147, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a6c : c9 02 __ CMP #$02
0a6e : b0 03 __ BCS $0a73 ; (rnd.s3 + 0)
.s1:
0a70 : a9 00 __ LDA #$00
.s1001:
; 187, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a72 : 60 __ __ RTS
.s3:
0a73 : 85 0d __ STA P0 ; (max + 0)
; 151, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a75 : ad 1a 32 LDA $321a ; (rng_seed + 0)
0a78 : 85 1b __ STA ACCU + 0 
0a7a : 8d f8 9f STA $9ff8 ; (room + 1)
; 150, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a7d : ad 1b 32 LDA $321b ; (rng_seed + 1)
0a80 : 85 1c __ STA ACCU + 1 
0a82 : 85 43 __ STA T1 + 0 
0a84 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 152, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a87 : 10 04 __ BPL $0a8d ; (rnd.s42 + 0)
.s41:
0a89 : a9 01 __ LDA #$01
0a8b : b0 02 __ BCS $0a8f ; (rnd.s43 + 0)
.s42:
; 152, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a8d : a9 00 __ LDA #$00
.s43:
0a8f : 8d f7 9f STA $9ff7 ; (d + 1)
; 155, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a92 : 06 1b __ ASL ACCU + 0 
0a94 : 26 1c __ ROL ACCU + 1 
0a96 : aa __ __ TAX
0a97 : a5 1b __ LDA ACCU + 0 
0a99 : 8d 1a 32 STA $321a ; (rng_seed + 0)
0a9c : a4 1c __ LDY ACCU + 1 
0a9e : 8c 1b 32 STY $321b ; (rng_seed + 1)
; 158, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0aa1 : 8a __ __ TXA
0aa2 : f0 0b __ BEQ $0aaf ; (rnd.s7 + 0)
.s5:
; 159, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0aa4 : 98 __ __ TYA
0aa5 : 49 b4 __ EOR #$b4
0aa7 : 8d 1b 32 STA $321b ; (rng_seed + 1)
0aaa : a5 1b __ LDA ACCU + 0 
0aac : 8d 1a 32 STA $321a ; (rng_seed + 0)
.s7:
; 163, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0aaf : a9 00 __ LDA #$00
0ab1 : 06 43 __ ASL T1 + 0 
0ab3 : 2a __ __ ROL
0ab4 : 06 43 __ ASL T1 + 0 
0ab6 : 2a __ __ ROL
0ab7 : 06 43 __ ASL T1 + 0 
0ab9 : 2a __ __ ROL
0aba : 06 43 __ ASL T1 + 0 
0abc : 2a __ __ ROL
0abd : 06 43 __ ASL T1 + 0 
0abf : 2a __ __ ROL
0ac0 : aa __ __ TAX
0ac1 : ad f8 9f LDA $9ff8 ; (room + 1)
0ac4 : 4a __ __ LSR
0ac5 : 4a __ __ LSR
0ac6 : 4a __ __ LSR
0ac7 : 05 43 __ ORA T1 + 0 
0ac9 : 4d 1a 32 EOR $321a ; (rng_seed + 0)
0acc : 8d 1a 32 STA $321a ; (rng_seed + 0)
0acf : 8a __ __ TXA
0ad0 : 4d 1b 32 EOR $321b ; (rng_seed + 1)
0ad3 : 8d 1b 32 STA $321b ; (rng_seed + 1)
; 166, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0ad6 : 4d 1a 32 EOR $321a ; (rng_seed + 0)
0ad9 : 8d f6 9f STA $9ff6 ; (d + 0)
; 169, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0adc : a5 0d __ LDA P0 ; (max + 0)
0ade : c9 08 __ CMP #$08
0ae0 : d0 06 __ BNE $0ae8 ; (rnd.s19 + 0)
.s11:
; 175, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0ae2 : ad f6 9f LDA $9ff6 ; (d + 0)
0ae5 : 29 07 __ AND #$07
0ae7 : 60 __ __ RTS
.s19:
; 169, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0ae8 : 90 67 __ BCC $0b51 ; (rnd.s21 + 0)
.s20:
0aea : c9 10 __ CMP #$10
0aec : d0 06 __ BNE $0af4 ; (rnd.s14 + 0)
.s12:
; 177, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0aee : ad f6 9f LDA $9ff6 ; (d + 0)
0af1 : 29 0f __ AND #$0f
0af3 : 60 __ __ RTS
.s14:
; 181, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0af4 : a9 00 __ LDA #$00
0af6 : 85 1b __ STA ACCU + 0 
0af8 : 85 04 __ STA WORK + 1 
0afa : a5 0d __ LDA P0 ; (max + 0)
0afc : 85 03 __ STA WORK + 0 
0afe : a9 01 __ LDA #$01
0b00 : 85 1c __ STA ACCU + 1 
0b02 : 20 76 31 JSR $3176 ; (divmod + 0)
0b05 : a5 0d __ LDA P0 ; (max + 0)
0b07 : 20 fc 30 JSR $30fc ; (mul16by8 + 0)
0b0a : a5 1b __ LDA ACCU + 0 
0b0c : 8d f5 9f STA $9ff5 ; (s + 1)
; 182, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b0f : ad f6 9f LDA $9ff6 ; (d + 0)
0b12 : c5 1b __ CMP ACCU + 0 
0b14 : 90 29 __ BCC $0b3f ; (rnd.s17 + 0)
.l16:
; 184, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b16 : ad 1a 32 LDA $321a ; (rng_seed + 0)
0b19 : 0a __ __ ASL
0b1a : 85 1c __ STA ACCU + 1 
0b1c : ad 1b 32 LDA $321b ; (rng_seed + 1)
0b1f : 2a __ __ ROL
0b20 : aa __ __ TAX
0b21 : ad 1b 32 LDA $321b ; (rng_seed + 1)
0b24 : 0a __ __ ASL
0b25 : a9 00 __ LDA #$00
0b27 : 2a __ __ ROL
0b28 : 45 1c __ EOR ACCU + 1 
0b2a : 49 37 __ EOR #$37
0b2c : 8d 1a 32 STA $321a ; (rng_seed + 0)
0b2f : 8a __ __ TXA
0b30 : 49 9e __ EOR #$9e
0b32 : 8d 1b 32 STA $321b ; (rng_seed + 1)
; 185, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b35 : 4d 1a 32 EOR $321a ; (rng_seed + 0)
0b38 : 8d f6 9f STA $9ff6 ; (d + 0)
; 182, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b3b : c5 1b __ CMP ACCU + 0 
0b3d : b0 d7 __ BCS $0b16 ; (rnd.l16 + 0)
.s17:
; 187, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b3f : 85 1b __ STA ACCU + 0 
0b41 : a9 00 __ LDA #$00
0b43 : 85 1c __ STA ACCU + 1 
0b45 : 85 04 __ STA WORK + 1 
0b47 : a5 0d __ LDA P0 ; (max + 0)
0b49 : 85 03 __ STA WORK + 0 
0b4b : 20 76 31 JSR $3176 ; (divmod + 0)
0b4e : a5 05 __ LDA WORK + 2 
0b50 : 60 __ __ RTS
.s21:
; 169, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b51 : c9 02 __ CMP #$02
0b53 : d0 06 __ BNE $0b5b ; (rnd.s22 + 0)
.s9:
; 171, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b55 : ad f6 9f LDA $9ff6 ; (d + 0)
0b58 : 29 01 __ AND #$01
0b5a : 60 __ __ RTS
.s22:
; 169, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b5b : c9 04 __ CMP #$04
0b5d : d0 95 __ BNE $0af4 ; (rnd.s14 + 0)
.s10:
; 173, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b5f : ad f6 9f LDA $9ff6 ; (d + 0)
0b62 : 29 03 __ AND #$03
0b64 : 60 __ __ RTS
--------------------------------------------------------------------
oscar_clrscr: ; oscar_clrscr()->void
.s0:
; 100, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b65 : a9 20 __ LDA #$20
0b67 : a2 00 __ LDX #$00
0b69 : 9d 00 04 STA $0400,x 
0b6c : e8 __ __ INX
0b6d : d0 fa __ BNE $0b69 ; (oscar_clrscr.s0 + 4)
0b6f : a2 00 __ LDX #$00
0b71 : 9d 00 05 STA $0500,x 
0b74 : e8 __ __ INX
0b75 : d0 fa __ BNE $0b71 ; (oscar_clrscr.s0 + 12)
0b77 : a2 00 __ LDX #$00
0b79 : 9d 00 06 STA $0600,x 
0b7c : e8 __ __ INX
0b7d : d0 fa __ BNE $0b79 ; (oscar_clrscr.s0 + 20)
0b7f : a2 00 __ LDX #$00
0b81 : 9d 00 07 STA $0700,x 
0b84 : e8 __ __ INX
0b85 : e0 e8 __ CPX #$e8
0b87 : d0 f8 __ BNE $0b81 ; (oscar_clrscr.s0 + 28)
0b89 : a9 00 __ LDA #$00
0b8b : 85 d3 __ STA $d3 
0b8d : 85 d6 __ STA $d6 
0b8f : a9 00 __ LDA #$00
0b91 : 85 d1 __ STA $d1 
0b93 : a9 04 __ LDA #$04
0b95 : 85 d2 __ STA $d2 
.s1001:
; 141, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b97 : 60 __ __ RTS
--------------------------------------------------------------------
mapgen_generate_dungeon: ; mapgen_generate_dungeon()->u8
.s0:
;  54, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0b98 : 20 a4 0b JSR $0ba4 ; (reset_viewport_state.s0 + 0)
;  57, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0b9b : 20 b5 0b JSR $0bb5 ; (reset_display_state.s0 + 0)
;  61, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0b9e : 20 d3 0b JSR $0bd3 ; (reset_all_generation_data.s0 + 0)
;  63, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0ba1 : 4c f3 0d JMP $0df3 ; (generate_level.s1000 + 0)
--------------------------------------------------------------------
reset_viewport_state: ; reset_viewport_state()->void
.s0:
;  24, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0ba4 : a9 00 __ LDA #$00
0ba6 : 8d 66 33 STA $3366 ; (view + 0)
;  25, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0ba9 : 8d 67 33 STA $3367 ; (view + 1)
;  23, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0bac : a9 20 __ LDA #$20
0bae : 8d 65 33 STA $3365 ; (camera_center_y + 0)
;  22, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0bb1 : 8d 64 33 STA $3364 ; (camera_center_x + 0)
.s1001:
;  26, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0bb4 : 60 __ __ RTS
--------------------------------------------------------------------
reset_display_state: ; reset_display_state()->void
.s0:
;  37, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0bb5 : a9 00 __ LDA #$00
0bb7 : 8d 51 37 STA $3751 ; (last_scroll_direction + 0)
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0bba : a9 01 __ LDA #$01
0bbc : 8d 50 37 STA $3750 ; (screen_dirty + 0)
;  31, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0bbf : a9 20 __ LDA #$20
0bc1 : a2 fa __ LDX #$fa
.l1003:
0bc3 : ca __ __ DEX
0bc4 : 9d 68 33 STA $3368,x ; (screen_buffer + 0)
0bc7 : 9d 62 34 STA $3462,x ; (screen_buffer + 250)
0bca : 9d 5c 35 STA $355c,x ; (screen_buffer + 500)
0bcd : 9d 56 36 STA $3656,x ; (screen_buffer + 750)
0bd0 : d0 f1 __ BNE $0bc3 ; (reset_display_state.l1003 + 0)
.s1001:
;  38, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0bd2 : 60 __ __ RTS
--------------------------------------------------------------------
reset_all_generation_data: ; reset_all_generation_data()->void
.s0:
; 702, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bd3 : 20 11 09 JSR $0911 ; (init_rng.s0 + 0)
; 705, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bd6 : 20 e4 0b JSR $0be4 ; (clear_map.s0 + 0)
; 708, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bd9 : a9 00 __ LDA #$00
0bdb : 8d 1c 32 STA $321c ; (room_count + 0)
; 711, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bde : 20 24 0c JSR $0c24 ; (clear_room_center_cache.s0 + 0)
; 714, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0be1 : 4c 2a 0c JMP $0c2a ; (init_rule_based_connection_system.s0 + 0)
--------------------------------------------------------------------
clear_map: ; clear_map()->void
.s0:
; 301, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0be4 : a9 00 __ LDA #$00
0be6 : 85 43 __ STA T1 + 0 
0be8 : 8d f8 9f STA $9ff8 ; (room + 1)
; 304, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0beb : 8d f6 9f STA $9ff6 ; (d + 0)
0bee : 8d f7 9f STA $9ff7 ; (d + 1)
; 301, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bf1 : a9 06 __ LDA #$06
0bf3 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
.l1005:
; 305, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bf6 : 18 __ __ CLC
0bf7 : a9 52 __ LDA #$52
0bf9 : 6d f6 9f ADC $9ff6 ; (d + 0)
0bfc : a8 __ __ TAY
0bfd : ad f7 9f LDA $9ff7 ; (d + 1)
0c00 : 85 1c __ STA ACCU + 1 
0c02 : 69 37 __ ADC #$37
0c04 : 85 44 __ STA T1 + 1 
0c06 : a9 00 __ LDA #$00
0c08 : ae f6 9f LDX $9ff6 ; (d + 0)
0c0b : 91 43 __ STA (T1 + 0),y 
; 304, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0c0d : 8a __ __ TXA
0c0e : 69 01 __ ADC #$01
0c10 : 8d f6 9f STA $9ff6 ; (d + 0)
0c13 : a5 1c __ LDA ACCU + 1 
0c15 : 69 00 __ ADC #$00
0c17 : 8d f7 9f STA $9ff7 ; (d + 1)
0c1a : c9 06 __ CMP #$06
0c1c : d0 d8 __ BNE $0bf6 ; (clear_map.l1005 + 0)
.s1006:
; 304, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0c1e : ad f6 9f LDA $9ff6 ; (d + 0)
0c21 : d0 d3 __ BNE $0bf6 ; (clear_map.l1005 + 0)
.s1001:
; 307, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0c23 : 60 __ __ RTS
--------------------------------------------------------------------
clear_room_center_cache: ; clear_room_center_cache()->void
.s0:
; 365, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0c24 : a9 00 __ LDA #$00
0c26 : 8d 1d 32 STA $321d ; (room_center_cache_valid + 0)
.s1001:
; 366, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0c29 : 60 __ __ RTS
--------------------------------------------------------------------
init_rule_based_connection_system: ; init_rule_based_connection_system()->void
.s0:
; 497, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c2a : a9 00 __ LDA #$00
0c2c : 8d f5 9f STA $9ff5 ; (s + 1)
.l2:
; 498, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c2f : ad f5 9f LDA $9ff5 ; (s + 1)
0c32 : aa __ __ TAX
0c33 : 0a __ __ ASL
0c34 : 0a __ __ ASL
0c35 : 6d f5 9f ADC $9ff5 ; (s + 1)
0c38 : 0a __ __ ASL
0c39 : 0a __ __ ASL
0c3a : 85 43 __ STA T0 + 0 
0c3c : a9 00 __ LDA #$00
0c3e : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
; 499, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c41 : 2a __ __ ROL
0c42 : 85 44 __ STA T0 + 1 
0c44 : a9 e2 __ LDA #$e2
0c46 : 65 43 __ ADC T0 + 0 
0c48 : 85 1b __ STA ACCU + 0 
0c4a : a9 3e __ LDA #$3e
0c4c : 65 44 __ ADC T0 + 1 
0c4e : 85 1c __ STA ACCU + 1 
0c50 : 18 __ __ CLC
0c51 : a9 52 __ LDA #$52
0c53 : 65 43 __ ADC T0 + 0 
0c55 : 85 43 __ STA T0 + 0 
0c57 : a9 3d __ LDA #$3d
0c59 : 65 44 __ ADC T0 + 1 
0c5b : 85 44 __ STA T0 + 1 
.l6:
; 500, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c5d : a9 ff __ LDA #$ff
0c5f : ac f4 9f LDY $9ff4 ; (entropy1 + 1)
0c62 : 91 1b __ STA (ACCU + 0),y 
; 499, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c64 : a9 00 __ LDA #$00
0c66 : 91 43 __ STA (T0 + 0),y 
; 498, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c68 : c8 __ __ INY
0c69 : 8c f4 9f STY $9ff4 ; (entropy1 + 1)
0c6c : c0 14 __ CPY #$14
0c6e : 90 ed __ BCC $0c5d ; (init_rule_based_connection_system.l6 + 0)
.s3:
; 497, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c70 : e8 __ __ INX
0c71 : 8e f5 9f STX $9ff5 ; (s + 1)
0c74 : e0 14 __ CPX #$14
0c76 : 90 b7 __ BCC $0c2f ; (init_rule_based_connection_system.l2 + 0)
.s4:
; 512, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c78 : 8d f3 9f STA $9ff3 ; (room1_buffer_x1 + 0)
; 509, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c7b : 8d 29 33 STA $3329 ; (distance_cache_valid + 0)
; 508, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c7e : 8d 28 33 STA $3328 ; (connection_cache + 72)
; 505, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c81 : 8d de 32 STA $32de ; (corridor_pool + 192)
; 506, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c84 : 8d df 32 STA $32df ; (corridor_pool + 193)
; 512, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c87 : ad 1c 32 LDA $321c ; (room_count + 0)
0c8a : 85 48 __ STA T5 + 0 
0c8c : f0 74 __ BEQ $0d02 ; (init_rule_based_connection_system.s12 + 0)
.l13:
0c8e : ad f3 9f LDA $9ff3 ; (room1_buffer_x1 + 0)
0c91 : c9 14 __ CMP #$14
0c93 : b0 6d __ BCS $0d02 ; (init_rule_based_connection_system.s12 + 0)
.s10:
; 513, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c95 : 85 49 __ STA T6 + 0 
0c97 : 85 45 __ STA T2 + 0 
0c99 : 69 01 __ ADC #$01
0c9b : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
0c9e : c5 48 __ CMP T5 + 0 
0ca0 : b0 55 __ BCS $0cf7 ; (init_rule_based_connection_system.s11 + 0)
.s31:
; 514, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0ca2 : a5 45 __ LDA T2 + 0 
0ca4 : 0a __ __ ASL
0ca5 : 0a __ __ ASL
0ca6 : 65 45 __ ADC T2 + 0 
0ca8 : 0a __ __ ASL
0ca9 : 0a __ __ ASL
0caa : a2 00 __ LDX #$00
0cac : 90 01 __ BCC $0caf ; (init_rule_based_connection_system.s1013 + 0)
.s1012:
0cae : e8 __ __ INX
.s1013:
0caf : 18 __ __ CLC
0cb0 : 69 e2 __ ADC #$e2
0cb2 : 85 46 __ STA T3 + 0 
0cb4 : 8a __ __ TXA
0cb5 : 69 3e __ ADC #$3e
0cb7 : 85 47 __ STA T3 + 1 
.l18:
; 513, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0cb9 : ad f2 9f LDA $9ff2 ; (entropy2 + 1)
0cbc : c9 14 __ CMP #$14
0cbe : b0 37 __ BCS $0cf7 ; (init_rule_based_connection_system.s11 + 0)
.s15:
; 514, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0cc0 : a5 49 __ LDA T6 + 0 
0cc2 : 85 13 __ STA P6 
0cc4 : ad f2 9f LDA $9ff2 ; (entropy2 + 1)
0cc7 : 85 14 __ STA P7 
0cc9 : 20 08 0d JSR $0d08 ; (calculate_room_distance.s0 + 0)
0ccc : a4 14 __ LDY P7 
0cce : 91 46 __ STA (T3 + 0),y 
0cd0 : aa __ __ TAX
; 515, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0cd1 : 98 __ __ TYA
0cd2 : 0a __ __ ASL
0cd3 : 0a __ __ ASL
0cd4 : 65 14 __ ADC P7 
0cd6 : 0a __ __ ASL
0cd7 : 0a __ __ ASL
0cd8 : a0 00 __ LDY #$00
0cda : 90 01 __ BCC $0cdd ; (init_rule_based_connection_system.s1015 + 0)
.s1014:
0cdc : c8 __ __ INY
.s1015:
0cdd : 18 __ __ CLC
0cde : 69 e2 __ ADC #$e2
0ce0 : 85 43 __ STA T0 + 0 
0ce2 : 98 __ __ TYA
0ce3 : 69 3e __ ADC #$3e
0ce5 : 85 44 __ STA T0 + 1 
0ce7 : 8a __ __ TXA
0ce8 : a4 45 __ LDY T2 + 0 
0cea : 91 43 __ STA (T0 + 0),y 
; 513, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0cec : a5 14 __ LDA P7 
0cee : 69 01 __ ADC #$01
0cf0 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
0cf3 : c5 48 __ CMP T5 + 0 
0cf5 : 90 c2 __ BCC $0cb9 ; (init_rule_based_connection_system.l18 + 0)
.s11:
; 512, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0cf7 : a5 49 __ LDA T6 + 0 
0cf9 : 69 00 __ ADC #$00
0cfb : 8d f3 9f STA $9ff3 ; (room1_buffer_x1 + 0)
0cfe : c5 48 __ CMP T5 + 0 
0d00 : 90 8c __ BCC $0c8e ; (init_rule_based_connection_system.l13 + 0)
.s12:
; 518, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0d02 : a9 01 __ LDA #$01
0d04 : 8d 29 33 STA $3329 ; (distance_cache_valid + 0)
.s1001:
; 519, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0d07 : 60 __ __ RTS
--------------------------------------------------------------------
calculate_room_distance: ; calculate_room_distance(u8,u8)->u8
.s0:
; 376, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d08 : a5 13 __ LDA P6 ; (room1 + 0)
0d0a : 85 0d __ STA P0 
0d0c : a9 f9 __ LDA #$f9
0d0e : 85 0e __ STA P1 
0d10 : a9 9f __ LDA #$9f
0d12 : 85 11 __ STA P4 
0d14 : a9 9f __ LDA #$9f
0d16 : 85 0f __ STA P2 
0d18 : a9 f8 __ LDA #$f8
0d1a : 85 10 __ STA P3 
0d1c : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 377, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d1f : a5 14 __ LDA P7 ; (room2 + 0)
0d21 : 85 0d __ STA P0 
0d23 : a9 f7 __ LDA #$f7
0d25 : 85 0e __ STA P1 
0d27 : a9 9f __ LDA #$9f
0d29 : 85 11 __ STA P4 
0d2b : a9 9f __ LDA #$9f
0d2d : 85 0f __ STA P2 
0d2f : a9 f6 __ LDA #$f6
0d31 : 85 10 __ STA P3 
0d33 : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 378, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d36 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
0d39 : 85 0f __ STA P2 
0d3b : ad f8 9f LDA $9ff8 ; (room + 1)
0d3e : 85 10 __ STA P3 
0d40 : ad f7 9f LDA $9ff7 ; (d + 1)
0d43 : 85 11 __ STA P4 
0d45 : ad f6 9f LDA $9ff6 ; (d + 0)
0d48 : 85 12 __ STA P5 
0d4a : 4c c8 0d JMP $0dc8 ; (manhattan_distance.s0 + 0)
--------------------------------------------------------------------
get_room_center: ; get_room_center(u8,u8*,u8*)->void
.s0:
; 333, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d4d : ad 1d 32 LDA $321d ; (room_center_cache_valid + 0)
0d50 : d0 05 __ BNE $0d57 ; (get_room_center.s4 + 0)
.s1002:
; 336, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d52 : a5 0d __ LDA P0 ; (room_id + 0)
0d54 : 4c 5d 0d JMP $0d5d ; (get_room_center.s1 + 0)
.s4:
; 333, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d57 : a5 0d __ LDA P0 ; (room_id + 0)
0d59 : c9 14 __ CMP #$14
0d5b : 90 5c __ BCC $0db9 ; (get_room_center.s3 + 0)
.s1:
; 336, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d5d : 85 1b __ STA ACCU + 0 
0d5f : 0a __ __ ASL
0d60 : 0a __ __ ASL
0d61 : 0a __ __ ASL
0d62 : aa __ __ TAX
0d63 : bd 02 41 LDA $4102,x ; (rooms + 2)
0d66 : 38 __ __ SEC
0d67 : e9 01 __ SBC #$01
0d69 : a8 __ __ TAY
0d6a : a9 00 __ LDA #$00
0d6c : e9 00 __ SBC #$00
0d6e : 85 44 __ STA T2 + 1 
0d70 : 0a __ __ ASL
0d71 : 98 __ __ TYA
0d72 : 69 00 __ ADC #$00
0d74 : 85 43 __ STA T2 + 0 
0d76 : a5 44 __ LDA T2 + 1 
0d78 : 69 00 __ ADC #$00
0d7a : 4a __ __ LSR
0d7b : 66 43 __ ROR T2 + 0 
0d7d : bd 00 41 LDA $4100,x ; (rooms + 0)
0d80 : 18 __ __ CLC
0d81 : 65 43 __ ADC T2 + 0 
0d83 : a0 00 __ LDY #$00
0d85 : 91 0e __ STA (P1),y ; (center_x + 0)
; 337, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d87 : bd 03 41 LDA $4103,x ; (rooms + 3)
0d8a : 38 __ __ SEC
0d8b : e9 01 __ SBC #$01
0d8d : 85 43 __ STA T2 + 0 
0d8f : 98 __ __ TYA
0d90 : e9 00 __ SBC #$00
0d92 : 85 44 __ STA T2 + 1 
0d94 : 0a __ __ ASL
0d95 : a5 43 __ LDA T2 + 0 
0d97 : 69 00 __ ADC #$00
0d99 : 85 43 __ STA T2 + 0 
0d9b : a5 44 __ LDA T2 + 1 
0d9d : 69 00 __ ADC #$00
0d9f : 4a __ __ LSR
0da0 : 66 43 __ ROR T2 + 0 
0da2 : bd 01 41 LDA $4101,x ; (rooms + 1)
0da5 : 18 __ __ CLC
0da6 : 65 43 __ ADC T2 + 0 
0da8 : 91 10 __ STA (P3),y ; (center_y + 0)
; 340, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0daa : b1 0e __ LDA (P1),y ; (center_x + 0)
0dac : 06 1b __ ASL ACCU + 0 
0dae : a6 1b __ LDX ACCU + 0 
0db0 : 9d 72 40 STA $4072,x ; (room_center_cache + 0)
; 341, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0db3 : b1 10 __ LDA (P3),y ; (center_y + 0)
0db5 : 9d 73 40 STA $4073,x ; (room_center_cache + 1)
0db8 : 60 __ __ RTS
.s3:
; 346, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0db9 : 0a __ __ ASL
0dba : aa __ __ TAX
0dbb : bd 72 40 LDA $4072,x ; (room_center_cache + 0)
0dbe : a0 00 __ LDY #$00
0dc0 : 91 0e __ STA (P1),y ; (center_x + 0)
; 347, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0dc2 : bd 73 40 LDA $4073,x ; (room_center_cache + 1)
0dc5 : 91 10 __ STA (P3),y ; (center_y + 0)
.s1001:
; 343, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0dc7 : 60 __ __ RTS
--------------------------------------------------------------------
manhattan_distance: ; manhattan_distance(u8,u8,u8,u8)->u8
.s0:
; 370, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0dc8 : a5 0f __ LDA P2 ; (x1 + 0)
0dca : 85 0d __ STA P0 
0dcc : a5 11 __ LDA P4 ; (x2 + 0)
0dce : 85 0e __ STA P1 
0dd0 : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
0dd3 : 85 43 __ STA T0 + 0 
0dd5 : a5 10 __ LDA P3 ; (y1 + 0)
0dd7 : 85 0d __ STA P0 
0dd9 : a5 12 __ LDA P5 ; (y2 + 0)
0ddb : 85 0e __ STA P1 
0ddd : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
0de0 : 18 __ __ CLC
0de1 : 65 43 __ ADC T0 + 0 
.s1001:
0de3 : 60 __ __ RTS
--------------------------------------------------------------------
fast_abs_diff: ; fast_abs_diff(u8,u8)->u8
.s0:
; 328, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0de4 : a5 0e __ LDA P1 ; (b + 0)
0de6 : c5 0d __ CMP P0 ; (a + 0)
0de8 : 90 03 __ BCC $0ded ; (fast_abs_diff.s2 + 0)
.s3:
0dea : e5 0d __ SBC P0 ; (a + 0)
0dec : 60 __ __ RTS
.s2:
; 328, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0ded : 38 __ __ SEC
0dee : a5 0d __ LDA P0 ; (a + 0)
0df0 : e5 0e __ SBC P1 ; (b + 0)
.s1001:
0df2 : 60 __ __ RTS
--------------------------------------------------------------------
generate_level: ; generate_level()->u8
.s1000:
0df3 : a2 09 __ LDX #$09
0df5 : b5 53 __ LDA T1 + 0,x 
0df7 : 9d 18 9f STA $9f18,x ; (generate_level@stack + 0)
0dfa : ca __ __ DEX
0dfb : 10 f8 __ BPL $0df5 ; (generate_level.s1000 + 2)
.s0:
; 111, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0dfd : a9 57 __ LDA #$57
0dff : 85 0d __ STA P0 
0e01 : a9 10 __ LDA #$10
0e03 : 85 0e __ STA P1 
0e05 : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
; 117, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e08 : 20 77 10 JSR $1077 ; (create_rooms.s1000 + 0)
; 119, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e0b : ad 1c 32 LDA $321c ; (room_count + 0)
0e0e : d0 03 __ BNE $0e13 ; (generate_level.s3 + 0)
0e10 : 4c a5 0e JMP $0ea5 ; (generate_level.s1001 + 0)
.s3:
; 123, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e13 : 85 58 __ STA T5 + 0 
0e15 : a9 6f __ LDA #$6f
0e17 : 85 0d __ STA P0 
0e19 : a9 18 __ LDA #$18
0e1b : 85 0e __ STA P1 
0e1d : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
; 125, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e20 : a9 00 __ LDA #$00
0e22 : 8d 33 9f STA $9f33 ; (connections_made + 0)
; 128, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e25 : 20 2a 0c JSR $0c2a ; (init_rule_based_connection_system.s0 + 0)
; 131, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e28 : a9 00 __ LDA #$00
0e2a : 8d 32 9f STA $9f32 ; (i + 0)
.l6:
; 132, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e2d : a9 00 __ LDA #$00
0e2f : ae 32 9f LDX $9f32 ; (i + 0)
0e32 : 9d 34 9f STA $9f34,x ; (connected + 0)
; 131, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e35 : ee 32 9f INC $9f32 ; (i + 0)
0e38 : ad 32 9f LDA $9f32 ; (i + 0)
0e3b : c9 14 __ CMP #$14
0e3d : 90 ee __ BCC $0e2d ; (generate_level.l6 + 0)
.s8:
; 139, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e3f : a9 00 __ LDA #$00
0e41 : 85 1c __ STA ACCU + 1 
0e43 : 8d 2e 9f STA $9f2e ; (iterations + 0)
0e46 : 8d 2f 9f STA $9f2f ; (iterations + 1)
; 136, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e49 : a9 01 __ LDA #$01
0e4b : 8d 34 9f STA $9f34 ; (connected + 0)
; 138, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e4e : a5 58 __ LDA T5 + 0 
0e50 : 85 1b __ STA ACCU + 0 
0e52 : 20 fc 30 JSR $30fc ; (mul16by8 + 0)
0e55 : a5 1b __ LDA ACCU + 0 
0e57 : 0a __ __ ASL
0e58 : 85 55 __ STA T3 + 0 
0e5a : 8d 30 9f STA $9f30 ; (max_iterations + 0)
0e5d : a5 1c __ LDA ACCU + 1 
0e5f : 2a __ __ ROL
0e60 : 85 56 __ STA T3 + 1 
0e62 : 8d 31 9f STA $9f31 ; (max_iterations + 1)
0e65 : 4c 77 0e JMP $0e77 ; (generate_level.l9 + 0)
.s279:
; 198, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e68 : 18 __ __ CLC
0e69 : a5 53 __ LDA T1 + 0 
0e6b : 69 01 __ ADC #$01
0e6d : 8d 2e 9f STA $9f2e ; (iterations + 0)
0e70 : a5 54 __ LDA T1 + 1 
0e72 : 69 00 __ ADC #$00
0e74 : 8d 2f 9f STA $9f2f ; (iterations + 1)
.l9:
; 140, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e77 : ad 33 9f LDA $9f33 ; (connections_made + 0)
0e7a : 85 59 __ STA T6 + 0 
0e7c : 38 __ __ SEC
0e7d : a5 58 __ LDA T5 + 0 
0e7f : e9 01 __ SBC #$01
0e81 : 90 1a __ BCC $0e9d ; (generate_level.s11 + 0)
.s1008:
0e83 : c5 59 __ CMP T6 + 0 
0e85 : 90 16 __ BCC $0e9d ; (generate_level.s11 + 0)
.s1024:
0e87 : f0 14 __ BEQ $0e9d ; (generate_level.s11 + 0)
.s12:
0e89 : ad 2e 9f LDA $9f2e ; (iterations + 0)
0e8c : 85 53 __ STA T1 + 0 
0e8e : ad 2f 9f LDA $9f2f ; (iterations + 1)
0e91 : 85 54 __ STA T1 + 1 
0e93 : c5 56 __ CMP T3 + 1 
0e95 : d0 04 __ BNE $0e9b ; (generate_level.s1006 + 0)
.s1005:
0e97 : a5 53 __ LDA T1 + 0 
0e99 : c5 55 __ CMP T3 + 0 
.s1006:
0e9b : 90 15 __ BCC $0eb2 ; (generate_level.s10 + 0)
.s11:
; 203, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e9d : 20 33 27 JSR $2733 ; (add_walls.s0 + 0)
; 206, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ea0 : 20 37 28 JSR $2837 ; (add_stairs.s0 + 0)
; 208, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ea3 : a9 01 __ LDA #$01
.s1001:
0ea5 : 85 1b __ STA ACCU + 0 
0ea7 : a2 09 __ LDX #$09
0ea9 : bd 18 9f LDA $9f18,x ; (generate_level@stack + 0)
0eac : 95 53 __ STA T1 + 0,x 
0eae : ca __ __ DEX
0eaf : 10 f8 __ BPL $0ea9 ; (generate_level.s1001 + 4)
0eb1 : 60 __ __ RTS
.s10:
; 148, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0eb2 : a9 00 __ LDA #$00
0eb4 : 8d 32 9f STA $9f32 ; (i + 0)
; 144, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0eb7 : 8d 2a 9f STA $9f2a ; (connection_found + 0)
; 145, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0eba : 8d 29 9f STA $9f29 ; (failed_attempts + 0)
; 142, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ebd : a9 ff __ LDA #$ff
0ebf : 8d 2d 9f STA $9f2d ; (best_room1 + 0)
0ec2 : 8d 2c 9f STA $9f2c ; (best_room2 + 0)
; 143, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ec5 : 8d 2b 9f STA $9f2b ; (best_distance + 0)
; 148, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ec8 : a5 58 __ LDA T5 + 0 
0eca : f0 02 __ BEQ $0ece ; (generate_level.s1023 + 0)
.s1022:
0ecc : a9 01 __ LDA #$01
.s1023:
0ece : 85 5a __ STA T7 + 0 
0ed0 : d0 03 __ BNE $0ed5 ; (generate_level.l14 + 0)
0ed2 : 4c 84 0f JMP $0f84 ; (generate_level.s41 + 0)
.l14:
; 149, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ed5 : ae 32 9f LDX $9f32 ; (i + 0)
0ed8 : 86 5b __ STX T8 + 0 
0eda : bd 34 9f LDA $9f34,x ; (connected + 0)
0edd : f0 64 __ BEQ $0f43 ; (generate_level.s15 + 0)
.s19:
; 150, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0edf : a9 00 __ LDA #$00
0ee1 : 8d 28 9f STA $9f28 ; (j + 0)
0ee4 : a5 5a __ LDA T7 + 0 
0ee6 : f0 5b __ BEQ $0f43 ; (generate_level.s15 + 0)
.l22:
; 151, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ee8 : ae 28 9f LDX $9f28 ; (j + 0)
0eeb : 86 5c __ STX T9 + 0 
0eed : bd 34 9f LDA $9f34,x ; (connected + 0)
0ef0 : d0 45 __ BNE $0f37 ; (generate_level.s21 + 0)
.s27:
; 152, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ef2 : a5 5b __ LDA T8 + 0 
0ef4 : 85 0d __ STA P0 
0ef6 : a5 5c __ LDA T9 + 0 
0ef8 : 85 0e __ STA P1 
0efa : 20 91 18 JSR $1891 ; (rooms_are_connected.s0 + 0)
0efd : aa __ __ TAX
0efe : d0 37 __ BNE $0f37 ; (generate_level.s21 + 0)
.s31:
; 154, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f00 : a5 0d __ LDA P0 
0f02 : 85 17 __ STA P10 
0f04 : a5 5c __ LDA T9 + 0 
0f06 : 85 18 __ STA P11 
0f08 : 20 bc 18 JSR $18bc ; (can_connect_rooms_safely.s0 + 0)
0f0b : a5 1b __ LDA ACCU + 0 
0f0d : f0 28 __ BEQ $0f37 ; (generate_level.s21 + 0)
.s35:
; 155, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f0f : a5 5b __ LDA T8 + 0 
0f11 : 85 13 __ STA P6 
0f13 : a5 5c __ LDA T9 + 0 
0f15 : 85 14 __ STA P7 
0f17 : 20 08 0d JSR $0d08 ; (calculate_room_distance.s0 + 0)
0f1a : 8d 27 9f STA $9f27 ; (distance + 0)
; 156, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f1d : cd 2b 9f CMP $9f2b ; (best_distance + 0)
0f20 : b0 15 __ BCS $0f37 ; (generate_level.s21 + 0)
.s37:
; 158, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f22 : a5 13 __ LDA P6 
0f24 : 8d 2d 9f STA $9f2d ; (best_room1 + 0)
; 159, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f27 : a5 5c __ LDA T9 + 0 
0f29 : 8d 2c 9f STA $9f2c ; (best_room2 + 0)
; 157, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f2c : ad 27 9f LDA $9f27 ; (distance + 0)
0f2f : 8d 2b 9f STA $9f2b ; (best_distance + 0)
; 160, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f32 : a9 01 __ LDA #$01
0f34 : 8d 2a 9f STA $9f2a ; (connection_found + 0)
.s21:
; 150, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f37 : 18 __ __ CLC
0f38 : a5 5c __ LDA T9 + 0 
0f3a : 69 01 __ ADC #$01
0f3c : 8d 28 9f STA $9f28 ; (j + 0)
0f3f : c5 58 __ CMP T5 + 0 
0f41 : 90 a5 __ BCC $0ee8 ; (generate_level.l22 + 0)
.s15:
; 148, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f43 : 18 __ __ CLC
0f44 : a5 5b __ LDA T8 + 0 
0f46 : 69 01 __ ADC #$01
0f48 : 8d 32 9f STA $9f32 ; (i + 0)
0f4b : c5 58 __ CMP T5 + 0 
0f4d : 90 86 __ BCC $0ed5 ; (generate_level.l14 + 0)
.s16:
; 165, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f4f : ad 2a 9f LDA $9f2a ; (connection_found + 0)
0f52 : f0 30 __ BEQ $0f84 ; (generate_level.s41 + 0)
.s43:
0f54 : ad 2d 9f LDA $9f2d ; (best_room1 + 0)
0f57 : 8d fe 9f STA $9ffe ; (sstack + 4)
0f5a : ad 2c 9f LDA $9f2c ; (best_room2 + 0)
0f5d : 85 57 __ STA T4 + 0 
0f5f : 8d ff 9f STA $9fff ; (sstack + 5)
0f62 : 20 e3 19 JSR $19e3 ; (rule_based_connect_rooms.s1000 + 0)
0f65 : a5 1b __ LDA ACCU + 0 
0f67 : f0 1b __ BEQ $0f84 ; (generate_level.s41 + 0)
.s40:
; 166, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f69 : a9 01 __ LDA #$01
0f6b : a6 57 __ LDX T4 + 0 
0f6d : 9d 34 9f STA $9f34,x ; (connected + 0)
; 167, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f70 : a6 59 __ LDX T6 + 0 
0f72 : e8 __ __ INX
0f73 : 8e 33 9f STX $9f33 ; (connections_made + 0)
; 168, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f76 : a9 40 __ LDA #$40
0f78 : 85 0d __ STA P0 
0f7a : a9 17 __ LDA #$17
0f7c : 85 0e __ STA P1 
0f7e : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
0f81 : 4c 68 0e JMP $0e68 ; (generate_level.s279 + 0)
.s41:
; 173, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f84 : a9 00 __ LDA #$00
0f86 : 8d 32 9f STA $9f32 ; (i + 0)
; 172, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f89 : 8d 2a 9f STA $9f2a ; (connection_found + 0)
; 173, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f8c : a5 5a __ LDA T7 + 0 
0f8e : d0 03 __ BNE $0f93 ; (generate_level.l48 + 0)
0f90 : 4c 29 10 JMP $1029 ; (generate_level.s79 + 0)
.l48:
; 174, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f93 : ae 32 9f LDX $9f32 ; (i + 0)
0f96 : 86 59 __ STX T6 + 0 
0f98 : bd 34 9f LDA $9f34,x ; (connected + 0)
0f9b : f0 6e __ BEQ $100b ; (generate_level.s49 + 0)
.s54:
; 175, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f9d : a9 00 __ LDA #$00
0f9f : 8d 26 9f STA $9f26 ; (j + 0)
0fa2 : a5 5a __ LDA T7 + 0 
0fa4 : f0 65 __ BEQ $100b ; (generate_level.s49 + 0)
.l60:
0fa6 : ad 2a 9f LDA $9f2a ; (connection_found + 0)
0fa9 : d0 60 __ BNE $100b ; (generate_level.s49 + 0)
.s57:
; 176, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0fab : ac 26 9f LDY $9f26 ; (j + 0)
0fae : 84 5b __ STY T8 + 0 
0fb0 : b9 34 9f LDA $9f34,y ; (connected + 0)
0fb3 : d0 4a __ BNE $0fff ; (generate_level.s56 + 0)
.s63:
; 177, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0fb5 : 84 0e __ STY P1 
0fb7 : a5 59 __ LDA T6 + 0 
0fb9 : 85 0d __ STA P0 
0fbb : 20 91 18 JSR $1891 ; (rooms_are_connected.s0 + 0)
0fbe : aa __ __ TAX
0fbf : d0 3e __ BNE $0fff ; (generate_level.s56 + 0)
.s67:
; 179, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0fc1 : a5 0d __ LDA P0 
0fc3 : 85 17 __ STA P10 
0fc5 : a5 5b __ LDA T8 + 0 
0fc7 : 85 18 __ STA P11 
0fc9 : 20 bc 18 JSR $18bc ; (can_connect_rooms_safely.s0 + 0)
0fcc : a5 1b __ LDA ACCU + 0 
0fce : f0 2f __ BEQ $0fff ; (generate_level.s56 + 0)
.s72:
0fd0 : a5 59 __ LDA T6 + 0 
0fd2 : 8d fe 9f STA $9ffe ; (sstack + 4)
0fd5 : a5 5b __ LDA T8 + 0 
0fd7 : 8d ff 9f STA $9fff ; (sstack + 5)
0fda : 20 e3 19 JSR $19e3 ; (rule_based_connect_rooms.s1000 + 0)
0fdd : a5 1b __ LDA ACCU + 0 
0fdf : f0 1e __ BEQ $0fff ; (generate_level.s56 + 0)
.s73:
; 184, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0fe1 : a9 01 __ LDA #$01
0fe3 : 8d 2a 9f STA $9f2a ; (connection_found + 0)
; 182, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0fe6 : a6 5b __ LDX T8 + 0 
0fe8 : 9d 34 9f STA $9f34,x ; (connected + 0)
; 183, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0feb : ee 33 9f INC $9f33 ; (connections_made + 0)
0fee : ad 33 9f LDA $9f33 ; (connections_made + 0)
; 185, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ff1 : 4a __ __ LSR
0ff2 : b0 0b __ BCS $0fff ; (generate_level.s56 + 0)
.s76:
0ff4 : a9 40 __ LDA #$40
0ff6 : 85 0d __ STA P0 
0ff8 : a9 17 __ LDA #$17
0ffa : 85 0e __ STA P1 
0ffc : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
.s56:
; 175, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0fff : 18 __ __ CLC
1000 : a5 5b __ LDA T8 + 0 
1002 : 69 01 __ ADC #$01
1004 : 8d 26 9f STA $9f26 ; (j + 0)
1007 : c5 58 __ CMP T5 + 0 
1009 : 90 9b __ BCC $0fa6 ; (generate_level.l60 + 0)
.s49:
; 173, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
100b : 18 __ __ CLC
100c : a5 59 __ LDA T6 + 0 
100e : 69 01 __ ADC #$01
1010 : 8d 32 9f STA $9f32 ; (i + 0)
1013 : c5 58 __ CMP T5 + 0 
1015 : ad 2a 9f LDA $9f2a ; (connection_found + 0)
1018 : b0 0d __ BCS $1027 ; (generate_level.s50 + 0)
.s51:
101a : d0 03 __ BNE $101f ; (generate_level.s80 + 0)
101c : 4c 93 0f JMP $0f93 ; (generate_level.l48 + 0)
.s80:
; 195, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
101f : a9 00 __ LDA #$00
.s1012:
1021 : 8d 29 9f STA $9f29 ; (failed_attempts + 0)
1024 : 4c 68 0e JMP $0e68 ; (generate_level.s279 + 0)
.s50:
; 191, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
1027 : d0 f6 __ BNE $101f ; (generate_level.s80 + 0)
.s79:
; 192, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
1029 : a9 01 __ LDA #$01
102b : d0 f4 __ BNE $1021 ; (generate_level.s1012 + 0)
--------------------------------------------------------------------
print_text: ; print_text(const u8*)->void
.s0:
; 675, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
102d : a9 00 __ LDA #$00
102f : f0 05 __ BEQ $1036 ; (print_text.l1 + 0)
.s25:
; 691, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1031 : 18 __ __ CLC
1032 : a5 43 __ LDA T2 + 0 
1034 : 69 01 __ ADC #$01
.l1:
; 675, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1036 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 676, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1039 : 85 43 __ STA T2 + 0 
103b : a8 __ __ TAY
103c : b1 0d __ LDA (P0),y ; (text + 0)
103e : d0 01 __ BNE $1041 ; (print_text.s2 + 0)
.s1001:
; 693, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1040 : 60 __ __ RTS
.s2:
; 677, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1041 : c9 0a __ CMP #$0a
1043 : f0 0a __ BEQ $104f ; (print_text.s4 + 0)
.s5:
; 686, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1045 : a4 43 __ LDY T2 + 0 
1047 : b1 0d __ LDA (P0),y ; (text + 0)
1049 : 20 d2 ff JSR $ffd2 
104c : 4c 31 10 JMP $1031 ; (print_text.s25 + 0)
.s4:
; 680, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
104f : a9 0d __ LDA #$0d
1051 : 20 d2 ff JSR $ffd2 
1054 : 4c 31 10 JMP $1031 ; (print_text.s25 + 0)
--------------------------------------------------------------------
1057 : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 3d 3d 3d 47 45 4e :           ===GEN
1067 : __ __ __ BYT 45 52 41 54 49 4e 47 20 4d 41 50 3d 3d 3d 0a 00 : ERATING MAP===..
--------------------------------------------------------------------
create_rooms: ; create_rooms()->void
.s1000:
1077 : a5 53 __ LDA T5 + 0 
1079 : 8d c8 9f STA $9fc8 ; (path1 + 43)
107c : a5 54 __ LDA T6 + 0 
107e : 8d c9 9f STA $9fc9 ; (path1 + 44)
.s0:
; 204, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1081 : a9 00 __ LDA #$00
1083 : 8d e1 9f STA $9fe1 ; (search_x1 + 0)
; 206, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1086 : 8d d0 9f STA $9fd0 ; (path1 + 51)
; 208, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1089 : a9 37 __ LDA #$37
108b : 85 0d __ STA P0 
108d : a9 12 __ LDA #$12
108f : 85 0e __ STA P1 
1091 : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
; 211, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1094 : a9 00 __ LDA #$00
1096 : 8d e6 9f STA $9fe6 ; (i + 0)
1099 : 18 __ __ CLC
.l1012:
; 212, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
109a : aa __ __ TAX
109b : 9d d1 9f STA $9fd1,x ; (path1 + 52)
; 213, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
109e : ee d0 9f INC $9fd0 ; (path1 + 51)
; 211, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10a1 : 69 01 __ ADC #$01
10a3 : 8d e6 9f STA $9fe6 ; (i + 0)
10a6 : c9 10 __ CMP #$10
; 213, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10a8 : ae d0 9f LDX $9fd0 ; (path1 + 51)
10ab : 90 ed __ BCC $109a ; (create_rooms.l1012 + 0)
.s4:
10ad : 86 53 __ STX T5 + 0 
; 216, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10af : 8a __ __ TXA
10b0 : e9 01 __ SBC #$01
10b2 : 85 4f __ STA T2 + 0 
10b4 : 8d e6 9f STA $9fe6 ; (i + 0)
10b7 : a9 00 __ LDA #$00
10b9 : e9 00 __ SBC #$00
10bb : 85 50 __ STA T2 + 1 
10bd : a5 4f __ LDA T2 + 0 
10bf : f0 2e __ BEQ $10ef ; (create_rooms.s8 + 0)
.l6:
; 217, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10c1 : ad e6 9f LDA $9fe6 ; (i + 0)
10c4 : 18 __ __ CLC
10c5 : 69 01 __ ADC #$01
10c7 : 85 54 __ STA T6 + 0 
10c9 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
10cc : 8d cf 9f STA $9fcf ; (path1 + 50)
; 218, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10cf : aa __ __ TAX
10d0 : ac e6 9f LDY $9fe6 ; (i + 0)
10d3 : b9 d1 9f LDA $9fd1,y ; (path1 + 52)
10d6 : 8d ce 9f STA $9fce ; (path1 + 49)
; 219, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10d9 : bd d1 9f LDA $9fd1,x ; (path1 + 52)
10dc : 99 d1 9f STA $9fd1,y ; (path1 + 52)
; 220, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10df : ad ce 9f LDA $9fce ; (path1 + 49)
10e2 : 9d d1 9f STA $9fd1,x ; (path1 + 52)
; 216, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10e5 : 18 __ __ CLC
10e6 : a5 54 __ LDA T6 + 0 
10e8 : 69 fe __ ADC #$fe
10ea : 8d e6 9f STA $9fe6 ; (i + 0)
10ed : d0 d2 __ BNE $10c1 ; (create_rooms.l6 + 0)
.s8:
; 224, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10ef : a9 00 __ LDA #$00
10f1 : 8d cd 9f STA $9fcd ; (path1 + 48)
.l10:
; 225, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10f4 : a9 00 __ LDA #$00
10f6 : 8d e6 9f STA $9fe6 ; (i + 0)
.l13:
10f9 : ad e6 9f LDA $9fe6 ; (i + 0)
10fc : 85 51 __ STA T3 + 0 
10fe : 85 4e __ STA T1 + 0 
1100 : a5 50 __ LDA T2 + 1 
1102 : 30 2d __ BMI $1131 ; (create_rooms.s11 + 0)
.s1005:
1104 : d0 06 __ BNE $110c ; (create_rooms.s14 + 0)
.s1002:
1106 : a5 4e __ LDA T1 + 0 
1108 : c5 4f __ CMP T2 + 0 
110a : b0 25 __ BCS $1131 ; (create_rooms.s11 + 0)
.s14:
; 226, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
110c : a9 02 __ LDA #$02
110e : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
; 225, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1111 : a6 51 __ LDX T3 + 0 
1113 : e8 __ __ INX
1114 : 8e e6 9f STX $9fe6 ; (i + 0)
; 226, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1117 : aa __ __ TAX
1118 : f0 df __ BEQ $10f9 ; (create_rooms.l13 + 0)
.s17:
; 227, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
111a : a6 4e __ LDX T1 + 0 
111c : bd d1 9f LDA $9fd1,x ; (path1 + 52)
111f : 8d cc 9f STA $9fcc ; (path1 + 47)
; 228, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1122 : bd d2 9f LDA $9fd2,x ; (path1 + 53)
1125 : 9d d1 9f STA $9fd1,x ; (path1 + 52)
; 229, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1128 : ad cc 9f LDA $9fcc ; (path1 + 47)
112b : 9d d2 9f STA $9fd2,x ; (path1 + 53)
112e : 4c f9 10 JMP $10f9 ; (create_rooms.l13 + 0)
.s11:
; 224, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1131 : ee cd 9f INC $9fcd ; (path1 + 48)
1134 : ad cd 9f LDA $9fcd ; (path1 + 48)
1137 : c9 02 __ CMP #$02
1139 : 90 b9 __ BCC $10f4 ; (create_rooms.l10 + 0)
.s12:
; 233, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
113b : a9 00 __ LDA #$00
113d : 8d e6 9f STA $9fe6 ; (i + 0)
.l25:
1140 : ad e1 9f LDA $9fe1 ; (search_x1 + 0)
1143 : c9 14 __ CMP #$14
1145 : 90 03 __ BCC $114a ; (create_rooms.s24 + 0)
1147 : 4c 00 12 JMP $1200 ; (create_rooms.s23 + 0)
.s24:
114a : 85 4f __ STA T2 + 0 
114c : ad e6 9f LDA $9fe6 ; (i + 0)
114f : c5 53 __ CMP T5 + 0 
1151 : b0 f4 __ BCS $1147 ; (create_rooms.l25 + 7)
.s21:
; 236, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1153 : 85 51 __ STA T3 + 0 
1155 : a9 0a __ LDA #$0a
1157 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
115a : c9 06 __ CMP #$06
115c : 90 17 __ BCC $1175 ; (create_rooms.s26 + 0)
.s27:
; 249, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
115e : a9 05 __ LDA #$05
1160 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
1163 : 18 __ __ CLC
1164 : 69 04 __ ADC #$04
1166 : a8 __ __ TAY
; 250, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1167 : a9 05 __ LDA #$05
.s167:
; 240, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1169 : 8c e3 9f STY $9fe3 ; (w + 0)
; 241, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
116c : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
116f : 18 __ __ CLC
1170 : 69 04 __ ADC #$04
1172 : 4c 9d 11 JMP $119d ; (create_rooms.s28 + 0)
.s26:
; 238, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1175 : a9 02 __ LDA #$02
1177 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
117a : aa __ __ TAX
117b : f0 0d __ BEQ $118a ; (create_rooms.s30 + 0)
.s29:
; 240, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
117d : a9 04 __ LDA #$04
117f : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
1182 : 18 __ __ CLC
1183 : 69 05 __ ADC #$05
1185 : a8 __ __ TAY
; 241, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1186 : a9 03 __ LDA #$03
1188 : d0 df __ BNE $1169 ; (create_rooms.s167 + 0)
.s30:
; 244, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
118a : a9 03 __ LDA #$03
118c : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
118f : 18 __ __ CLC
1190 : 69 04 __ ADC #$04
1192 : 8d e3 9f STA $9fe3 ; (w + 0)
; 245, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1195 : a9 04 __ LDA #$04
1197 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
119a : 18 __ __ CLC
119b : 69 05 __ ADC #$05
.s28:
; 241, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
119d : 8d e2 9f STA $9fe2 ; (min_dist2 + 0)
; 253, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11a0 : 85 17 __ STA P10 
11a2 : a6 51 __ LDX T3 + 0 
11a4 : bd d1 9f LDA $9fd1,x ; (path1 + 52)
11a7 : 85 15 __ STA P8 
11a9 : ad e3 9f LDA $9fe3 ; (w + 0)
11ac : 85 52 __ STA T4 + 0 
11ae : 85 16 __ STA P9 
11b0 : a9 e5 __ LDA #$e5
11b2 : 8d fa 9f STA $9ffa ; (sstack + 0)
11b5 : a9 9f __ LDA #$9f
11b7 : 8d fb 9f STA $9ffb ; (sstack + 1)
11ba : a9 e4 __ LDA #$e4
11bc : 8d fc 9f STA $9ffc ; (sstack + 2)
11bf : a9 9f __ LDA #$9f
11c1 : 8d fd 9f STA $9ffd ; (sstack + 3)
11c4 : 20 47 12 JSR $1247 ; (try_place_room_at_grid.s0 + 0)
11c7 : a5 1b __ LDA ACCU + 0 
11c9 : f0 26 __ BEQ $11f1 ; (create_rooms.s20 + 0)
.s32:
; 254, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11cb : ad e5 9f LDA $9fe5 ; (x + 0)
11ce : 85 13 __ STA P6 
11d0 : ad e4 9f LDA $9fe4 ; (y + 0)
11d3 : 85 14 __ STA P7 
11d5 : a5 52 __ LDA T4 + 0 
11d7 : 85 15 __ STA P8 
11d9 : a5 17 __ LDA P10 
11db : 85 16 __ STA P9 
11dd : 20 a7 15 JSR $15a7 ; (place_room.s0 + 0)
; 255, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11e0 : a6 4f __ LDX T2 + 0 
11e2 : e8 __ __ INX
11e3 : 8e e1 9f STX $9fe1 ; (search_x1 + 0)
; 256, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11e6 : a9 40 __ LDA #$40
11e8 : 85 0d __ STA P0 
11ea : a9 17 __ LDA #$17
11ec : 85 0e __ STA P1 
11ee : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
.s20:
; 233, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11f1 : 18 __ __ CLC
11f2 : a5 51 __ LDA T3 + 0 
11f4 : 69 01 __ ADC #$01
11f6 : 8d e6 9f STA $9fe6 ; (i + 0)
11f9 : c9 14 __ CMP #$14
11fb : b0 03 __ BCS $1200 ; (create_rooms.s23 + 0)
11fd : 4c 40 11 JMP $1140 ; (create_rooms.l25 + 0)
.s23:
; 260, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1200 : ad e1 9f LDA $9fe1 ; (search_x1 + 0)
1203 : 85 4d __ STA T0 + 0 
1205 : 8d 1c 32 STA $321c ; (room_count + 0)
; 261, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1208 : 20 42 17 JSR $1742 ; (assign_room_priorities.s0 + 0)
; 264, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
120b : 20 8a 17 JSR $178a ; (init_room_center_cache.s0 + 0)
; 267, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
120e : a5 4d __ LDA T0 + 0 
1210 : f0 1a __ BEQ $122c ; (create_rooms.s1001 + 0)
.s35:
; 268, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1212 : a9 00 __ LDA #$00
1214 : 85 0d __ STA P0 
1216 : a9 33 __ LDA #$33
1218 : 85 11 __ STA P4 
121a : a9 64 __ LDA #$64
121c : 85 0e __ STA P1 
121e : a9 33 __ LDA #$33
1220 : 85 0f __ STA P2 
1222 : a9 65 __ LDA #$65
1224 : 85 10 __ STA P3 
1226 : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 269, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1229 : 20 fe 17 JSR $17fe ; (update_camera.s0 + 0)
.s1001:
122c : ad c8 9f LDA $9fc8 ; (path1 + 43)
122f : 85 53 __ STA T5 + 0 
1231 : ad c9 9f LDA $9fc9 ; (path1 + 44)
1234 : 85 54 __ STA T6 + 0 
; 271, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1236 : 60 __ __ RTS
--------------------------------------------------------------------
1237 : __ __ __ BYT 0a 43 52 45 41 54 49 4e 47 20 52 4f 4f 4d 53 00 : .CREATING ROOMS.
--------------------------------------------------------------------
try_place_room_at_grid: ; try_place_room_at_grid(u8,u8,u8,u8*,u8*)->u8
.s0:
;  83, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1247 : a9 00 __ LDA #$00
1249 : 8d e8 9f STA $9fe8 ; (attempts + 0)
.l2:
;  87, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
124c : a5 15 __ LDA P8 ; (grid_index + 0)
124e : 85 0e __ STA P1 
1250 : a9 ea __ LDA #$ea
1252 : 85 0f __ STA P2 
1254 : a9 9f __ LDA #$9f
1256 : 85 12 __ STA P5 
1258 : a9 9f __ LDA #$9f
125a : 85 10 __ STA P3 
125c : a9 e9 __ LDA #$e9
125e : 85 11 __ STA P4 
1260 : 20 1f 13 JSR $131f ; (get_grid_position.s0 + 0)
;  90, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1263 : a9 0a __ LDA #$0a
1265 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
1268 : c9 05 __ CMP #$05
126a : b0 66 __ BCS $12d2 ; (try_place_room_at_grid.s6 + 0)
.s4:
;  92, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
126c : a9 08 __ LDA #$08
126e : 8d e7 9f STA $9fe7 ; (down_x + 0)
;  93, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1271 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
1274 : 38 __ __ SEC
1275 : e9 04 __ SBC #$04
1277 : 18 __ __ CLC
1278 : 6d ea 9f ADC $9fea ; (i + 0)
127b : 85 4c __ STA T2 + 0 
127d : 8d ea 9f STA $9fea ; (i + 0)
;  94, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1280 : a9 08 __ LDA #$08
1282 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
1285 : 38 __ __ SEC
1286 : e9 04 __ SBC #$04
1288 : 18 __ __ CLC
1289 : 6d e9 9f ADC $9fe9 ; (y + 0)
128c : 8d e9 9f STA $9fe9 ; (y + 0)
;  97, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
128f : a5 4c __ LDA T2 + 0 
1291 : c9 04 __ CMP #$04
1293 : b0 05 __ BCS $129a ; (try_place_room_at_grid.s9 + 0)
.s7:
1295 : a9 04 __ LDA #$04
1297 : 8d ea 9f STA $9fea ; (i + 0)
.s9:
;  98, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
129a : ad e9 9f LDA $9fe9 ; (y + 0)
129d : c9 04 __ CMP #$04
129f : b0 05 __ BCS $12a6 ; (try_place_room_at_grid.s12 + 0)
.s10:
12a1 : a9 04 __ LDA #$04
12a3 : 8d e9 9f STA $9fe9 ; (y + 0)
.s12:
;  99, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12a6 : 18 __ __ CLC
12a7 : a5 16 __ LDA P9 ; (w + 0)
12a9 : 6d ea 9f ADC $9fea ; (i + 0)
12ac : b0 04 __ BCS $12b2 ; (try_place_room_at_grid.s13 + 0)
.s1003:
12ae : c9 3d __ CMP #$3d
12b0 : 90 0a __ BCC $12bc ; (try_place_room_at_grid.s15 + 0)
.s13:
12b2 : a9 40 __ LDA #$40
12b4 : e5 16 __ SBC P9 ; (w + 0)
12b6 : 38 __ __ SEC
12b7 : e9 04 __ SBC #$04
12b9 : 8d ea 9f STA $9fea ; (i + 0)
.s15:
; 100, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12bc : 18 __ __ CLC
12bd : a5 17 __ LDA P10 ; (h + 0)
12bf : 6d e9 9f ADC $9fe9 ; (y + 0)
12c2 : b0 04 __ BCS $12c8 ; (try_place_room_at_grid.s16 + 0)
.s1002:
12c4 : c9 3d __ CMP #$3d
12c6 : 90 0a __ BCC $12d2 ; (try_place_room_at_grid.s6 + 0)
.s16:
12c8 : a9 40 __ LDA #$40
12ca : e5 17 __ SBC P10 ; (h + 0)
12cc : 38 __ __ SEC
12cd : e9 04 __ SBC #$04
12cf : 8d e9 9f STA $9fe9 ; (y + 0)
.s6:
; 102, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12d2 : a5 16 __ LDA P9 ; (w + 0)
12d4 : 85 13 __ STA P6 
12d6 : a5 17 __ LDA P10 ; (h + 0)
12d8 : 85 14 __ STA P7 
12da : ad ea 9f LDA $9fea ; (i + 0)
12dd : 85 4b __ STA T1 + 0 
12df : 85 11 __ STA P4 
12e1 : ad e9 9f LDA $9fe9 ; (y + 0)
12e4 : 85 12 __ STA P5 
12e6 : 20 cd 13 JSR $13cd ; (can_place_room.s0 + 0)
12e9 : a5 1b __ LDA ACCU + 0 ; (result_y + 0)
12eb : d0 0e __ BNE $12fb ; (try_place_room_at_grid.s19 + 0)
.s21:
; 106, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12ed : ee e8 9f INC $9fe8 ; (attempts + 0)
12f0 : ad e8 9f LDA $9fe8 ; (attempts + 0)
;  85, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12f3 : c9 14 __ CMP #$14
12f5 : b0 03 __ BCS $12fa ; (try_place_room_at_grid.s1001 + 0)
12f7 : 4c 4c 12 JMP $124c ; (try_place_room_at_grid.l2 + 0)
.s1001:
; 111, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12fa : 60 __ __ RTS
.s19:
; 103, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12fb : ad fa 9f LDA $9ffa ; (sstack + 0)
12fe : 85 43 __ STA T0 + 0 
1300 : ad fb 9f LDA $9ffb ; (sstack + 1)
1303 : 85 44 __ STA T0 + 1 
1305 : a5 4b __ LDA T1 + 0 
1307 : a0 00 __ LDY #$00
1309 : 91 43 __ STA (T0 + 0),y 
; 104, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
130b : ad fc 9f LDA $9ffc ; (sstack + 2)
130e : 85 43 __ STA T0 + 0 
1310 : ad fd 9f LDA $9ffd ; (sstack + 3)
1313 : 85 44 __ STA T0 + 1 
1315 : ad e9 9f LDA $9fe9 ; (y + 0)
1318 : 91 43 __ STA (T0 + 0),y 
; 105, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
131a : a9 01 __ LDA #$01
131c : 85 1b __ STA ACCU + 0 ; (result_y + 0)
131e : 60 __ __ RTS
--------------------------------------------------------------------
get_grid_position: ; get_grid_position(u8,u8*,u8*)->void
.s0:
; 385, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
131f : a9 0e __ LDA #$0e
1321 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
; 386, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1324 : 8d f1 9f STA $9ff1 ; (cell_h + 0)
; 393, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1327 : 8d ee 9f STA $9fee ; (entropy4 + 1)
; 394, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
132a : 8d ed 9f STA $9fed ; (extra_range_y + 0)
; 383, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
132d : a5 0e __ LDA P1 ; (grid_index + 0)
132f : 29 03 __ AND #$03
1331 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
1334 : aa __ __ TAX
; 384, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1335 : a5 0e __ LDA P1 ; (grid_index + 0)
1337 : 4a __ __ LSR
1338 : 4a __ __ LSR
1339 : 8d f3 9f STA $9ff3 ; (room1_buffer_x1 + 0)
; 389, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
133c : bd fb 31 LDA $31fb,x ; (__multab14L + 0)
133f : 18 __ __ CLC
1340 : 69 04 __ ADC #$04
1342 : 85 45 __ STA T1 + 0 
1344 : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
; 390, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1347 : ad f3 9f LDA $9ff3 ; (room1_buffer_x1 + 0)
134a : 0a __ __ ASL
134b : 0a __ __ ASL
134c : 0a __ __ ASL
134d : 38 __ __ SEC
134e : ed f3 9f SBC $9ff3 ; (room1_buffer_x1 + 0)
1351 : 0a __ __ ASL
1352 : 18 __ __ CLC
1353 : 69 04 __ ADC #$04
1355 : 85 46 __ STA T2 + 0 
1357 : 8d ef 9f STA $9fef ; (screen_pos + 1)
; 397, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
135a : a9 15 __ LDA #$15
135c : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
135f : 85 44 __ STA T0 + 0 
1361 : 8d ec 9f STA $9fec ; (random_offset_x + 0)
; 398, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1364 : a9 15 __ LDA #$15
1366 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
1369 : 8d eb 9f STA $9feb ; (screen_offset + 1)
136c : aa __ __ TAX
; 401, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
136d : 18 __ __ CLC
136e : a5 44 __ LDA T0 + 0 
1370 : 65 45 __ ADC T1 + 0 
1372 : 38 __ __ SEC
1373 : e9 07 __ SBC #$07
1375 : a0 00 __ LDY #$00
1377 : 91 0f __ STA (P2),y ; (x + 0)
; 402, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1379 : 8a __ __ TXA
137a : 18 __ __ CLC
137b : 65 46 __ ADC T2 + 0 
137d : 38 __ __ SEC
137e : e9 07 __ SBC #$07
1380 : 91 11 __ STA (P4),y ; (y + 0)
; 405, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1382 : a9 06 __ LDA #$06
1384 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
1387 : 38 __ __ SEC
1388 : e9 03 __ SBC #$03
138a : 18 __ __ CLC
138b : a0 00 __ LDY #$00
138d : 71 0f __ ADC (P2),y ; (x + 0)
138f : 91 0f __ STA (P2),y ; (x + 0)
; 406, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1391 : a9 06 __ LDA #$06
1393 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
1396 : 38 __ __ SEC
1397 : e9 03 __ SBC #$03
1399 : 18 __ __ CLC
139a : a0 00 __ LDY #$00
139c : 71 11 __ ADC (P4),y ; (y + 0)
139e : 91 11 __ STA (P4),y ; (y + 0)
13a0 : aa __ __ TAX
; 409, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
13a1 : b1 0f __ LDA (P2),y ; (x + 0)
13a3 : c9 04 __ CMP #$04
13a5 : b0 08 __ BCS $13af ; (get_grid_position.s3 + 0)
.s1:
13a7 : a9 04 __ LDA #$04
13a9 : 91 0f __ STA (P2),y ; (x + 0)
; 410, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
13ab : b1 11 __ LDA (P4),y ; (y + 0)
13ad : 90 01 __ BCC $13b0 ; (get_grid_position.s1002 + 0)
.s3:
; 410, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
13af : 8a __ __ TXA
.s1002:
13b0 : c9 04 __ CMP #$04
13b2 : b0 04 __ BCS $13b8 ; (get_grid_position.s6 + 0)
.s4:
; 410, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
13b4 : a9 04 __ LDA #$04
13b6 : 91 11 __ STA (P4),y ; (y + 0)
.s6:
; 411, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
13b8 : b1 0f __ LDA (P2),y ; (x + 0)
13ba : c9 35 __ CMP #$35
13bc : 90 04 __ BCC $13c2 ; (get_grid_position.s9 + 0)
.s7:
13be : a9 34 __ LDA #$34
13c0 : 91 0f __ STA (P2),y ; (x + 0)
.s9:
; 412, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
13c2 : b1 11 __ LDA (P4),y ; (y + 0)
13c4 : c9 35 __ CMP #$35
13c6 : 90 04 __ BCC $13cc ; (get_grid_position.s1001 + 0)
.s10:
13c8 : a9 34 __ LDA #$34
13ca : 91 11 __ STA (P4),y ; (y + 0)
.s1001:
; 413, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
13cc : 60 __ __ RTS
--------------------------------------------------------------------
can_place_room: ; can_place_room(u8,u8,u8,u8)->u8
.s0:
;  19, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
13cd : a5 11 __ LDA P4 ; (x + 0)
13cf : c9 03 __ CMP #$03
13d1 : b0 03 __ BCS $13d6 ; (can_place_room.s6 + 0)
13d3 : 4c 5b 14 JMP $145b ; (can_place_room.s1 + 0)
.s6:
13d6 : a5 12 __ LDA P5 ; (y + 0)
13d8 : c9 03 __ CMP #$03
13da : 90 7f __ BCC $145b ; (can_place_room.s1 + 0)
.s5:
13dc : 18 __ __ CLC
13dd : a5 11 __ LDA P4 ; (x + 0)
13df : 65 13 __ ADC P6 ; (w + 0)
13e1 : b0 78 __ BCS $145b ; (can_place_room.s1 + 0)
.s1021:
13e3 : c9 3d __ CMP #$3d
13e5 : b0 74 __ BCS $145b ; (can_place_room.s1 + 0)
.s4:
13e7 : 85 49 __ STA T5 + 0 
13e9 : a5 12 __ LDA P5 ; (y + 0)
13eb : 65 14 __ ADC P7 ; (h + 0)
13ed : b0 6c __ BCS $145b ; (can_place_room.s1 + 0)
.s1020:
13ef : c9 3d __ CMP #$3d
13f1 : b0 68 __ BCS $145b ; (can_place_room.s1 + 0)
.s3:
;  22, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
13f3 : 85 4a __ STA T7 + 0 
13f5 : 38 __ __ SEC
13f6 : a5 12 __ LDA P5 ; (y + 0)
13f8 : e9 04 __ SBC #$04
13fa : 85 47 __ STA T2 + 0 
13fc : 4c 03 14 JMP $1403 ; (can_place_room.l8 + 0)
.s10:
;  22, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
13ff : e6 47 __ INC T2 + 0 
1401 : a5 47 __ LDA T2 + 0 
.l8:
1403 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
1406 : 18 __ __ CLC
1407 : a5 4a __ LDA T7 + 0 
1409 : 69 04 __ ADC #$04
140b : b0 04 __ BCS $1411 ; (can_place_room.s9 + 0)
.s1017:
140d : c5 47 __ CMP T2 + 0 
140f : 90 4f __ BCC $1460 ; (can_place_room.s11 + 0)
.s9:
;  23, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1411 : a5 11 __ LDA P4 ; (x + 0)
1413 : e9 04 __ SBC #$04
1415 : 8d f3 9f STA $9ff3 ; (room1_buffer_x1 + 0)
1418 : 18 __ __ CLC
1419 : a5 49 __ LDA T5 + 0 
141b : 69 04 __ ADC #$04
141d : 85 45 __ STA T1 + 0 
141f : a9 00 __ LDA #$00
1421 : 2a __ __ ROL
1422 : 85 46 __ STA T1 + 1 
1424 : ad f3 9f LDA $9ff3 ; (room1_buffer_x1 + 0)
1427 : 90 08 __ BCC $1431 ; (can_place_room.l12 + 0)
.s14:
;  23, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1429 : 18 __ __ CLC
142a : a5 48 __ LDA T3 + 0 
142c : 69 01 __ ADC #$01
142e : 8d f3 9f STA $9ff3 ; (room1_buffer_x1 + 0)
.l12:
1431 : 85 48 __ STA T3 + 0 
1433 : a5 46 __ LDA T1 + 1 
1435 : d0 07 __ BNE $143e ; (can_place_room.s13 + 0)
.s1014:
1437 : a5 45 __ LDA T1 + 0 
1439 : cd f3 9f CMP $9ff3 ; (room1_buffer_x1 + 0)
143c : 90 c1 __ BCC $13ff ; (can_place_room.s10 + 0)
.s13:
;  24, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
143e : a5 48 __ LDA T3 + 0 
1440 : 85 0d __ STA P0 
1442 : a5 47 __ LDA T2 + 0 
1444 : 85 0e __ STA P1 
1446 : 20 dd 14 JSR $14dd ; (coords_in_bounds.s0 + 0)
1449 : aa __ __ TAX
144a : f0 dd __ BEQ $1429 ; (can_place_room.s14 + 0)
.s16:
;  25, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
144c : a5 0d __ LDA P0 
144e : 85 0f __ STA P2 
1450 : a5 0e __ LDA P1 
1452 : 85 10 __ STA P3 
1454 : 20 f0 14 JSR $14f0 ; (tile_is_empty.s0 + 0)
1457 : a5 1b __ LDA ACCU + 0 
1459 : d0 ce __ BNE $1429 ; (can_place_room.s14 + 0)
.s1:
;  20, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
145b : a9 00 __ LDA #$00
.s1001:
;  54, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
145d : 85 1b __ STA ACCU + 0 
145f : 60 __ __ RTS
.s11:
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1460 : a9 00 __ LDA #$00
1462 : 8d f1 9f STA $9ff1 ; (cell_h + 0)
1465 : ad 1c 32 LDA $321c ; (room_count + 0)
1468 : f0 6f __ BEQ $14d9 ; (can_place_room.s26 + 0)
.s1022:
146a : 85 1b __ STA ACCU + 0 
146c : a6 49 __ LDX T5 + 0 
.l24:
;  38, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
146e : 8e ee 9f STX $9fee ; (entropy4 + 1)
;  39, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1471 : a5 4a __ LDA T7 + 0 
1473 : 8d ed 9f STA $9fed ; (extra_range_y + 0)
;  42, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1476 : a9 05 __ LDA #$05
1478 : 8d ec 9f STA $9fec ; (random_offset_x + 0)
;  43, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
147b : 8d eb 9f STA $9feb ; (screen_offset + 1)
;  36, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
147e : ad f1 9f LDA $9ff1 ; (cell_h + 0)
1481 : 0a __ __ ASL
1482 : 0a __ __ ASL
1483 : 0a __ __ ASL
1484 : a8 __ __ TAY
1485 : b9 02 41 LDA $4102,y ; (rooms + 2)
1488 : 79 00 41 ADC $4100,y ; (rooms + 0)
148b : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
;  37, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
148e : b9 03 41 LDA $4103,y ; (rooms + 3)
1491 : 18 __ __ CLC
1492 : 79 01 41 ADC $4101,y ; (rooms + 1)
1495 : 8d ef 9f STA $9fef ; (screen_pos + 1)
;  46, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1498 : ad f0 9f LDA $9ff0 ; (entropy3 + 1)
149b : 18 __ __ CLC
149c : 69 05 __ ADC #$05
149e : b0 06 __ BCS $14a6 ; (can_place_room.s30 + 0)
.s1011:
14a0 : c5 11 __ CMP P4 ; (x + 0)
14a2 : 90 2b __ BCC $14cf ; (can_place_room.s25 + 0)
.s1034:
14a4 : f0 29 __ BEQ $14cf ; (can_place_room.s25 + 0)
.s30:
14a6 : 8a __ __ TXA
14a7 : 18 __ __ CLC
14a8 : 69 05 __ ADC #$05
14aa : b0 07 __ BCS $14b3 ; (can_place_room.s27 + 0)
.s1008:
14ac : d9 00 41 CMP $4100,y ; (rooms + 0)
14af : 90 1e __ BCC $14cf ; (can_place_room.s25 + 0)
.s1033:
14b1 : f0 1c __ BEQ $14cf ; (can_place_room.s25 + 0)
.s27:
;  48, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
14b3 : ad ef 9f LDA $9fef ; (screen_pos + 1)
14b6 : 18 __ __ CLC
14b7 : 69 05 __ ADC #$05
14b9 : b0 06 __ BCS $14c1 ; (can_place_room.s34 + 0)
.s1005:
14bb : c5 12 __ CMP P5 ; (y + 0)
14bd : 90 10 __ BCC $14cf ; (can_place_room.s25 + 0)
.s1032:
14bf : f0 0e __ BEQ $14cf ; (can_place_room.s25 + 0)
.s34:
14c1 : 18 __ __ CLC
14c2 : a5 4a __ LDA T7 + 0 
14c4 : 69 05 __ ADC #$05
14c6 : b0 93 __ BCS $145b ; (can_place_room.s1 + 0)
.s1002:
14c8 : d9 01 41 CMP $4101,y ; (rooms + 1)
14cb : 90 02 __ BCC $14cf ; (can_place_room.s25 + 0)
.s1031:
14cd : d0 8c __ BNE $145b ; (can_place_room.s1 + 0)
.s25:
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
14cf : ee f1 9f INC $9ff1 ; (cell_h + 0)
14d2 : ad f1 9f LDA $9ff1 ; (cell_h + 0)
14d5 : c5 1b __ CMP ACCU + 0 
14d7 : 90 95 __ BCC $146e ; (can_place_room.l24 + 0)
.s26:
;  54, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
14d9 : a9 01 __ LDA #$01
14db : d0 80 __ BNE $145d ; (can_place_room.s1001 + 0)
--------------------------------------------------------------------
coords_in_bounds: ; coords_in_bounds(u8,u8)->u8
.s0:
; 477, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
14dd : a5 0d __ LDA P0 ; (x + 0)
14df : c9 40 __ CMP #$40
14e1 : b0 0a __ BCS $14ed ; (coords_in_bounds.s2 + 0)
.s6:
14e3 : a5 0e __ LDA P1 ; (y + 0)
14e5 : c9 40 __ CMP #$40
14e7 : a9 00 __ LDA #$00
14e9 : 2a __ __ ROL
14ea : 49 01 __ EOR #$01
14ec : 60 __ __ RTS
.s2:
; 477, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
14ed : a9 00 __ LDA #$00
.s1001:
14ef : 60 __ __ RTS
--------------------------------------------------------------------
tile_is_empty: ; tile_is_empty(u8,u8)->u8
.s0:
; 284, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
14f0 : a5 0f __ LDA P2 ; (x + 0)
14f2 : c9 40 __ CMP #$40
14f4 : b0 06 __ BCS $14fc ; (tile_is_empty.s1 + 0)
.s4:
14f6 : a5 10 __ LDA P3 ; (y + 0)
14f8 : c9 40 __ CMP #$40
14fa : 90 04 __ BCC $1500 ; (tile_is_empty.s3 + 0)
.s1:
14fc : a9 01 __ LDA #$01
14fe : b0 11 __ BCS $1511 ; (tile_is_empty.s1001 + 0)
.s3:
; 285, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1500 : 85 0e __ STA P1 
1502 : a5 0f __ LDA P2 ; (x + 0)
1504 : 85 0d __ STA P0 
1506 : 20 14 15 JSR $1514 ; (get_tile_core.s0 + 0)
1509 : c9 01 __ CMP #$01
150b : a9 00 __ LDA #$00
150d : 69 ff __ ADC #$ff
150f : 29 01 __ AND #$01
.s1001:
1511 : 85 1b __ STA ACCU + 0 
1513 : 60 __ __ RTS
--------------------------------------------------------------------
get_tile_core: ; get_tile_core(u8,u8)->u8
.s0:
; 259, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1514 : a5 0e __ LDA P1 ; (y + 0)
1516 : 4a __ __ LSR
1517 : aa __ __ TAX
1518 : a9 00 __ LDA #$00
151a : 6a __ __ ROR
151b : 85 43 __ STA T1 + 0 
151d : a9 00 __ LDA #$00
151f : 46 0e __ LSR P1 ; (y + 0)
1521 : 6a __ __ ROR
1522 : 66 0e __ ROR P1 ; (y + 0)
1524 : 6a __ __ ROR
1525 : 65 43 __ ADC T1 + 0 
1527 : a8 __ __ TAY
1528 : 8a __ __ TXA
1529 : 65 0e __ ADC P1 ; (y + 0)
152b : aa __ __ TAX
152c : 98 __ __ TYA
152d : 18 __ __ CLC
152e : 65 0d __ ADC P0 ; (x + 0)
1530 : 90 01 __ BCC $1533 ; (get_tile_core.s1013 + 0)
.s1012:
; 250, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1532 : e8 __ __ INX
.s1013:
1533 : 18 __ __ CLC
1534 : 65 0d __ ADC P0 ; (x + 0)
1536 : 90 01 __ BCC $1539 ; (get_tile_core.s1015 + 0)
.s1014:
; 250, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1538 : e8 __ __ INX
.s1015:
1539 : 18 __ __ CLC
153a : 65 0d __ ADC P0 ; (x + 0)
153c : 8d f8 9f STA $9ff8 ; (room + 1)
153f : 8a __ __ TXA
1540 : 69 00 __ ADC #$00
1542 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 253, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1545 : 4a __ __ LSR
1546 : 85 44 __ STA T1 + 1 
1548 : ad f8 9f LDA $9ff8 ; (room + 1)
154b : 6a __ __ ROR
154c : 46 44 __ LSR T1 + 1 
154e : 6a __ __ ROR
154f : 46 44 __ LSR T1 + 1 
1551 : 6a __ __ ROR
1552 : 18 __ __ CLC
1553 : 69 52 __ ADC #$52
1555 : 85 43 __ STA T1 + 0 
1557 : 8d f6 9f STA $9ff6 ; (d + 0)
155a : a9 37 __ LDA #$37
155c : 65 44 __ ADC T1 + 1 
155e : 85 44 __ STA T1 + 1 
1560 : 8d f7 9f STA $9ff7 ; (d + 1)
; 254, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1563 : ad f8 9f LDA $9ff8 ; (room + 1)
1566 : 29 07 __ AND #$07
1568 : 85 1b __ STA ACCU + 0 
156a : 8d f5 9f STA $9ff5 ; (s + 1)
; 259, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
156d : aa __ __ TAX
156e : a0 00 __ LDY #$00
1570 : b1 43 __ LDA (T1 + 0),y 
1572 : e0 00 __ CPX #$00
1574 : f0 04 __ BEQ $157a ; (get_tile_core.s1003 + 0)
.l1002:
; 259, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1576 : 4a __ __ LSR
1577 : ca __ __ DEX
1578 : d0 fc __ BNE $1576 ; (get_tile_core.l1002 + 0)
.s1003:
; 257, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
157a : 85 1c __ STA ACCU + 1 
157c : a5 1b __ LDA ACCU + 0 
157e : c9 06 __ CMP #$06
1580 : b0 05 __ BCS $1587 ; (get_tile_core.s3 + 0)
.s1:
; 259, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1582 : a5 1c __ LDA ACCU + 1 
.s1001:
; 264, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1584 : 29 07 __ AND #$07
1586 : 60 __ __ RTS
.s3:
; 263, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1587 : a9 08 __ LDA #$08
1589 : e5 1b __ SBC ACCU + 0 
158b : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
; 264, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
158e : aa __ __ TAX
158f : bd 50 33 LDA $3350,x ; (bitshift + 36)
1592 : 38 __ __ SEC
1593 : e9 01 __ SBC #$01
1595 : a0 01 __ LDY #$01
1597 : 31 43 __ AND (T1 + 0),y 
1599 : ae f4 9f LDX $9ff4 ; (entropy1 + 1)
159c : f0 04 __ BEQ $15a2 ; (get_tile_core.s1005 + 0)
.l1006:
159e : 0a __ __ ASL
159f : ca __ __ DEX
15a0 : d0 fc __ BNE $159e ; (get_tile_core.l1006 + 0)
.s1005:
; 264, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
15a2 : 05 1c __ ORA ACCU + 1 
15a4 : 4c 84 15 JMP $1584 ; (get_tile_core.s1001 + 0)
--------------------------------------------------------------------
place_room: ; place_room(u8,u8,u8,u8)->void
.s0:
;  60, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15a7 : a5 14 __ LDA P7 ; (y + 0)
15a9 : 4c b0 15 JMP $15b0 ; (place_room.l1 + 0)
.s3:
;  60, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15ac : a5 4a __ LDA T3 + 0 
15ae : 69 00 __ ADC #$00
.l1:
15b0 : 8d ee 9f STA $9fee ; (entropy4 + 1)
15b3 : 18 __ __ CLC
15b4 : a5 16 __ LDA P9 ; (h + 0)
15b6 : 65 14 __ ADC P7 ; (y + 0)
15b8 : 85 43 __ STA T0 + 0 
15ba : ad ee 9f LDA $9fee ; (entropy4 + 1)
15bd : 85 4a __ STA T3 + 0 
15bf : b0 04 __ BCS $15c5 ; (place_room.s2 + 0)
.s1005:
15c1 : c5 43 __ CMP T0 + 0 
15c3 : b0 13 __ BCS $15d8 ; (place_room.s4 + 0)
.s2:
;  61, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15c5 : a5 13 __ LDA P6 ; (x + 0)
15c7 : 8d ef 9f STA $9fef ; (screen_pos + 1)
15ca : 18 __ __ CLC
15cb : 65 15 __ ADC P8 ; (w + 0)
15cd : 85 48 __ STA T1 + 0 
15cf : a9 00 __ LDA #$00
15d1 : 2a __ __ ROL
15d2 : 85 49 __ STA T1 + 1 
15d4 : a5 13 __ LDA P6 ; (x + 0)
15d6 : 90 2d __ BCC $1605 ; (place_room.l5 + 0)
.s4:
;  68, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15d8 : ad 1c 32 LDA $321c ; (room_count + 0)
15db : c9 14 __ CMP #$14
15dd : b0 25 __ BCS $1604 ; (place_room.s1001 + 0)
.s12:
;  69, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15df : 0a __ __ ASL
15e0 : 0a __ __ ASL
15e1 : 0a __ __ ASL
15e2 : aa __ __ TAX
15e3 : a5 13 __ LDA P6 ; (x + 0)
15e5 : 9d 00 41 STA $4100,x ; (rooms + 0)
;  70, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15e8 : a5 14 __ LDA P7 ; (y + 0)
15ea : 9d 01 41 STA $4101,x ; (rooms + 1)
;  71, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15ed : a5 15 __ LDA P8 ; (w + 0)
15ef : 9d 02 41 STA $4102,x ; (rooms + 2)
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15f2 : a5 16 __ LDA P9 ; (h + 0)
15f4 : 9d 03 41 STA $4103,x ; (rooms + 3)
;  74, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15f7 : a9 00 __ LDA #$00
15f9 : 9d 04 41 STA $4104,x ; (rooms + 4)
;  73, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15fc : a9 05 __ LDA #$05
15fe : 9d 07 41 STA $4107,x ; (rooms + 7)
;  75, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1601 : ee 1c 32 INC $321c ; (room_count + 0)
.s1001:
;  77, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1604 : 60 __ __ RTS
.l5:
;  61, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1605 : a8 __ __ TAY
1606 : a5 49 __ LDA T1 + 1 
1608 : d0 2d __ BNE $1637 ; (place_room.s1008 + 0)
.s1002:
160a : 98 __ __ TYA
160b : c4 48 __ CPY T1 + 0 
160d : b0 9d __ BCS $15ac ; (place_room.s3 + 0)
.s6:
;  62, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
160f : 85 0d __ STA P0 
1611 : 18 __ __ CLC
1612 : 69 01 __ ADC #$01
1614 : 85 4b __ STA T4 + 0 
1616 : a5 4a __ LDA T3 + 0 
1618 : 85 0e __ STA P1 
161a : 20 dd 14 JSR $14dd ; (coords_in_bounds.s0 + 0)
161d : aa __ __ TAX
161e : f0 0f __ BEQ $162f ; (place_room.s51 + 0)
.s9:
;  63, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1620 : a5 0d __ LDA P0 
1622 : 85 10 __ STA P3 
1624 : a5 0e __ LDA P1 
1626 : 85 11 __ STA P4 
1628 : a9 02 __ LDA #$02
162a : 85 12 __ STA P5 
162c : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s51:
;  61, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
162f : a5 4b __ LDA T4 + 0 
1631 : 8d ef 9f STA $9fef ; (screen_pos + 1)
1634 : 4c 05 16 JMP $1605 ; (place_room.l5 + 0)
.s1008:
;  62, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1637 : 98 __ __ TYA
1638 : 4c 0f 16 JMP $160f ; (place_room.s6 + 0)
--------------------------------------------------------------------
set_tile_raw: ; set_tile_raw(u8,u8,u8)->void
.s0:
; 296, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
163b : a5 10 __ LDA P3 ; (x + 0)
163d : 85 0d __ STA P0 
163f : a5 11 __ LDA P4 ; (y + 0)
1641 : 85 0e __ STA P1 
1643 : a5 12 __ LDA P5 ; (tile + 0)
1645 : 85 0f __ STA P2 
1647 : 4c 4a 16 JMP $164a ; (set_compact_tile_fast.s0 + 0)
--------------------------------------------------------------------
set_compact_tile_fast: ; set_compact_tile_fast(u8,u8,u8)->void
.s0:
; 218, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
164a : a5 0d __ LDA P0 ; (x + 0)
164c : c9 40 __ CMP #$40
164e : b0 06 __ BCS $1656 ; (set_compact_tile_fast.s1001 + 0)
.s4:
1650 : a5 0e __ LDA P1 ; (y + 0)
1652 : c9 40 __ CMP #$40
1654 : 90 01 __ BCC $1657 ; (set_compact_tile_fast.s3 + 0)
.s1001:
1656 : 60 __ __ RTS
.s3:
; 230, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1657 : 85 1c __ STA ACCU + 1 
1659 : 4a __ __ LSR
165a : aa __ __ TAX
165b : a9 00 __ LDA #$00
165d : 6a __ __ ROR
165e : 85 43 __ STA T1 + 0 
1660 : a9 00 __ LDA #$00
1662 : 46 1c __ LSR ACCU + 1 
1664 : 6a __ __ ROR
1665 : 66 1c __ ROR ACCU + 1 
1667 : 6a __ __ ROR
1668 : 65 43 __ ADC T1 + 0 
166a : a8 __ __ TAY
166b : 8a __ __ TXA
166c : 65 1c __ ADC ACCU + 1 
166e : aa __ __ TAX
166f : 98 __ __ TYA
1670 : 18 __ __ CLC
1671 : 65 0d __ ADC P0 ; (x + 0)
1673 : 90 01 __ BCC $1676 ; (set_compact_tile_fast.s1023 + 0)
.s1022:
; 221, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1675 : e8 __ __ INX
.s1023:
1676 : 18 __ __ CLC
1677 : 65 0d __ ADC P0 ; (x + 0)
1679 : 90 01 __ BCC $167c ; (set_compact_tile_fast.s1025 + 0)
.s1024:
; 221, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
167b : e8 __ __ INX
.s1025:
167c : 18 __ __ CLC
167d : 65 0d __ ADC P0 ; (x + 0)
167f : 8d f8 9f STA $9ff8 ; (room + 1)
1682 : 8a __ __ TXA
1683 : 69 00 __ ADC #$00
1685 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 224, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1688 : 4a __ __ LSR
1689 : 85 44 __ STA T1 + 1 
168b : ad f8 9f LDA $9ff8 ; (room + 1)
168e : 6a __ __ ROR
168f : 46 44 __ LSR T1 + 1 
1691 : 6a __ __ ROR
1692 : 46 44 __ LSR T1 + 1 
1694 : 6a __ __ ROR
1695 : 18 __ __ CLC
1696 : 69 52 __ ADC #$52
1698 : 85 43 __ STA T1 + 0 
169a : 8d f6 9f STA $9ff6 ; (d + 0)
169d : a9 37 __ LDA #$37
169f : 65 44 __ ADC T1 + 1 
16a1 : 85 44 __ STA T1 + 1 
16a3 : 8d f7 9f STA $9ff7 ; (d + 1)
; 225, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16a6 : ad f8 9f LDA $9ff8 ; (room + 1)
16a9 : 29 07 __ AND #$07
16ab : 85 1b __ STA ACCU + 0 
16ad : 8d f5 9f STA $9ff5 ; (s + 1)
; 230, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16b0 : a5 0f __ LDA P2 ; (tile + 0)
16b2 : 29 07 __ AND #$07
16b4 : 85 1d __ STA ACCU + 2 
16b6 : a0 00 __ LDY #$00
16b8 : b1 43 __ LDA (T1 + 0),y 
16ba : 85 1c __ STA ACCU + 1 
16bc : a5 1b __ LDA ACCU + 0 
16be : c9 06 __ CMP #$06
16c0 : b0 1c __ BCS $16de ; (set_compact_tile_fast.s7 + 0)
.s6:
; 232, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16c2 : aa __ __ TAX
16c3 : bd 12 32 LDA $3212,x ; (__shltab7L + 0)
16c6 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
; 233, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16c9 : 49 ff __ EOR #$ff
16cb : 25 1c __ AND ACCU + 1 
16cd : 85 1c __ STA ACCU + 1 
16cf : a5 1d __ LDA ACCU + 2 
16d1 : e0 00 __ CPX #$00
16d3 : f0 04 __ BEQ $16d9 ; (set_compact_tile_fast.s1016 + 0)
.l1014:
16d5 : 0a __ __ ASL
16d6 : ca __ __ DEX
16d7 : d0 fc __ BNE $16d5 ; (set_compact_tile_fast.l1014 + 0)
.s1016:
; 233, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16d9 : 05 1c __ ORA ACCU + 1 
.s1017:
; 243, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16db : 91 43 __ STA (T1 + 0),y 
16dd : 60 __ __ RTS
.s7:
; 236, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16de : a9 08 __ LDA #$08
16e0 : e5 1b __ SBC ACCU + 0 
16e2 : 85 1e __ STA ACCU + 3 
16e4 : 8d f3 9f STA $9ff3 ; (room1_buffer_x1 + 0)
; 237, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16e7 : aa __ __ TAX
16e8 : 49 03 __ EOR #$03
16ea : 85 45 __ STA T5 + 0 
16ec : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
; 239, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16ef : bd 34 33 LDA $3334,x ; (bitshift + 8)
16f2 : 38 __ __ SEC
16f3 : e9 01 __ SBC #$01
16f5 : 85 46 __ STA T6 + 0 
16f7 : a6 1b __ LDX ACCU + 0 
16f9 : f0 04 __ BEQ $16ff ; (set_compact_tile_fast.s1003 + 0)
.l1010:
16fb : 0a __ __ ASL
16fc : ca __ __ DEX
16fd : d0 fc __ BNE $16fb ; (set_compact_tile_fast.l1010 + 0)
.s1003:
; 239, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16ff : 85 47 __ STA T7 + 0 
1701 : 8d f1 9f STA $9ff1 ; (cell_h + 0)
; 240, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1704 : a6 45 __ LDX T5 + 0 
1706 : bd 34 33 LDA $3334,x ; (bitshift + 8)
1709 : 38 __ __ SEC
170a : e9 01 __ SBC #$01
170c : 85 45 __ STA T5 + 0 
170e : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
; 242, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1711 : a5 1d __ LDA ACCU + 2 
1713 : 25 46 __ AND T6 + 0 
1715 : a6 1b __ LDX ACCU + 0 
1717 : f0 04 __ BEQ $171d ; (set_compact_tile_fast.s1005 + 0)
.l1012:
1719 : 0a __ __ ASL
171a : ca __ __ DEX
171b : d0 fc __ BNE $1719 ; (set_compact_tile_fast.l1012 + 0)
.s1005:
; 242, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
171d : 85 46 __ STA T6 + 0 
171f : a9 ff __ LDA #$ff
1721 : 45 47 __ EOR T7 + 0 
1723 : 25 1c __ AND ACCU + 1 
1725 : 05 46 __ ORA T6 + 0 
1727 : 91 43 __ STA (T1 + 0),y 
; 243, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1729 : a9 ff __ LDA #$ff
172b : 45 45 __ EOR T5 + 0 
172d : a0 01 __ LDY #$01
172f : 31 43 __ AND (T1 + 0),y 
1731 : 85 1b __ STA ACCU + 0 
1733 : a5 1d __ LDA ACCU + 2 
1735 : a6 1e __ LDX ACCU + 3 
.l1006:
1737 : 4a __ __ LSR
1738 : ca __ __ DEX
1739 : d0 fc __ BNE $1737 ; (set_compact_tile_fast.l1006 + 0)
.s1007:
173b : 05 1b __ ORA ACCU + 0 
173d : 4c db 16 JMP $16db ; (set_compact_tile_fast.s1017 + 0)
--------------------------------------------------------------------
1740 : __ __ __ BYT 2e 00                                           : ..
--------------------------------------------------------------------
assign_room_priorities: ; assign_room_priorities()->void
.s0:
; 118, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1742 : a9 00 __ LDA #$00
1744 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
1747 : ad 1c 32 LDA $321c ; (room_count + 0)
174a : 85 45 __ STA T4 + 0 
174c : f0 3b __ BEQ $1789 ; (assign_room_priorities.s1001 + 0)
.l2:
; 119, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
174e : ae f4 9f LDX $9ff4 ; (entropy1 + 1)
1751 : e8 __ __ INX
1752 : 86 46 __ STX T5 + 0 
1754 : ad f4 9f LDA $9ff4 ; (entropy1 + 1)
1757 : 0a __ __ ASL
1758 : 0a __ __ ASL
1759 : 0a __ __ ASL
175a : 85 44 __ STA T2 + 0 
175c : ad f4 9f LDA $9ff4 ; (entropy1 + 1)
175f : d0 04 __ BNE $1765 ; (assign_room_priorities.s6 + 0)
.s5:
; 120, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1761 : a9 0a __ LDA #$0a
1763 : d0 16 __ BNE $177b ; (assign_room_priorities.s1 + 0)
.s6:
; 121, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1765 : a5 45 __ LDA T4 + 0 
1767 : 38 __ __ SEC
1768 : e9 01 __ SBC #$01
176a : cd f4 9f CMP $9ff4 ; (entropy1 + 1)
176d : d0 04 __ BNE $1773 ; (assign_room_priorities.s9 + 0)
.s8:
; 122, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
176f : a9 08 __ LDA #$08
1771 : d0 08 __ BNE $177b ; (assign_room_priorities.s1 + 0)
.s9:
; 124, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1773 : a9 03 __ LDA #$03
1775 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
1778 : 18 __ __ CLC
1779 : 69 05 __ ADC #$05
.s1:
; 120, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
177b : a6 44 __ LDX T2 + 0 
177d : 9d 07 41 STA $4107,x ; (rooms + 7)
; 118, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1780 : a5 46 __ LDA T5 + 0 
1782 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
1785 : c5 45 __ CMP T4 + 0 
1787 : 90 c5 __ BCC $174e ; (assign_room_priorities.l2 + 0)
.s1001:
; 127, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1789 : 60 __ __ RTS
--------------------------------------------------------------------
init_room_center_cache: ; init_room_center_cache()->void
.s0:
; 355, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
178a : a9 00 __ LDA #$00
178c : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
178f : ad 1c 32 LDA $321c ; (room_count + 0)
1792 : f0 64 __ BEQ $17f8 ; (init_room_center_cache.s4 + 0)
.l5:
1794 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
1797 : c9 14 __ CMP #$14
1799 : b0 5d __ BCS $17f8 ; (init_room_center_cache.s4 + 0)
.s2:
; 357, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
179b : 85 1b __ STA ACCU + 0 
179d : 0a __ __ ASL
179e : 0a __ __ ASL
179f : 0a __ __ ASL
17a0 : aa __ __ TAX
17a1 : bd 02 41 LDA $4102,x ; (rooms + 2)
17a4 : 38 __ __ SEC
17a5 : e9 01 __ SBC #$01
17a7 : 85 1c __ STA ACCU + 1 
17a9 : a9 00 __ LDA #$00
17ab : e9 00 __ SBC #$00
17ad : a8 __ __ TAY
17ae : 0a __ __ ASL
17af : a5 1c __ LDA ACCU + 1 
17b1 : 69 00 __ ADC #$00
17b3 : 85 1c __ STA ACCU + 1 
17b5 : 98 __ __ TYA
17b6 : 69 00 __ ADC #$00
17b8 : 4a __ __ LSR
17b9 : 66 1c __ ROR ACCU + 1 
17bb : bd 00 41 LDA $4100,x ; (rooms + 0)
17be : 18 __ __ CLC
17bf : 65 1c __ ADC ACCU + 1 
17c1 : 06 1b __ ASL ACCU + 0 
17c3 : a4 1b __ LDY ACCU + 0 
17c5 : 99 72 40 STA $4072,y ; (room_center_cache + 0)
; 358, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
17c8 : bd 03 41 LDA $4103,x ; (rooms + 3)
17cb : 38 __ __ SEC
17cc : e9 01 __ SBC #$01
17ce : 85 1c __ STA ACCU + 1 
17d0 : a9 00 __ LDA #$00
17d2 : e9 00 __ SBC #$00
17d4 : a8 __ __ TAY
17d5 : 0a __ __ ASL
17d6 : a5 1c __ LDA ACCU + 1 
17d8 : 69 00 __ ADC #$00
17da : 85 1c __ STA ACCU + 1 
17dc : 98 __ __ TYA
17dd : 69 00 __ ADC #$00
17df : 4a __ __ LSR
17e0 : 66 1c __ ROR ACCU + 1 
17e2 : bd 01 41 LDA $4101,x ; (rooms + 1)
17e5 : 18 __ __ CLC
17e6 : 65 1c __ ADC ACCU + 1 
17e8 : a6 1b __ LDX ACCU + 0 
17ea : 9d 73 40 STA $4073,x ; (room_center_cache + 1)
; 355, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
17ed : ee f9 9f INC $9ff9 ; (bit_offset + 1)
17f0 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
17f3 : cd 1c 32 CMP $321c ; (room_count + 0)
17f6 : 90 9c __ BCC $1794 ; (init_room_center_cache.l5 + 0)
.s4:
; 360, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
17f8 : a9 01 __ LDA #$01
17fa : 8d 1d 32 STA $321d ; (room_center_cache_valid + 0)
.s1001:
; 361, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
17fd : 60 __ __ RTS
--------------------------------------------------------------------
update_camera: ; update_camera()->void
.s0:
;  49, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
17fe : ad 66 33 LDA $3366 ; (view + 0)
1801 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
;  50, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1804 : ad 67 33 LDA $3367 ; (view + 1)
1807 : 8d f8 9f STA $9ff8 ; (room + 1)
;  52, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
180a : ad 65 33 LDA $3365 ; (camera_center_y + 0)
180d : 8d f6 9f STA $9ff6 ; (d + 0)
;  51, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1810 : ad 64 33 LDA $3364 ; (camera_center_x + 0)
1813 : 8d f7 9f STA $9ff7 ; (d + 1)
;  55, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1816 : c9 14 __ CMP #$14
1818 : b0 04 __ BCS $181e ; (update_camera.s1 + 0)
.s2:
;  58, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
181a : a9 00 __ LDA #$00
181c : 90 02 __ BCC $1820 ; (update_camera.s18 + 0)
.s1:
;  56, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
181e : e9 14 __ SBC #$14
.s18:
;  58, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1820 : 8d 66 33 STA $3366 ; (view + 0)
;  61, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1823 : ad 65 33 LDA $3365 ; (camera_center_y + 0)
1826 : c9 0c __ CMP #$0c
1828 : b0 04 __ BCS $182e ; (update_camera.s4 + 0)
.s5:
;  64, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
182a : a9 00 __ LDA #$00
182c : 90 02 __ BCC $1830 ; (update_camera.s19 + 0)
.s4:
;  62, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
182e : e9 0c __ SBC #$0c
.s19:
;  64, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1830 : 8d 67 33 STA $3367 ; (view + 1)
;  68, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1833 : a9 18 __ LDA #$18
1835 : cd 66 33 CMP $3366 ; (view + 0)
1838 : b0 03 __ BCS $183d ; (update_camera.s20 + 0)
.s7:
;  69, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
183a : 8d 66 33 STA $3366 ; (view + 0)
.s20:
;  71, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
183d : a9 27 __ LDA #$27
183f : cd 67 33 CMP $3367 ; (view + 1)
1842 : b0 03 __ BCS $1847 ; (update_camera.s12 + 0)
.s10:
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1844 : 8d 67 33 STA $3367 ; (view + 1)
.s12:
;  77, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1847 : ad 66 33 LDA $3366 ; (view + 0)
184a : 18 __ __ CLC
184b : 69 14 __ ADC #$14
184d : 8d 64 33 STA $3364 ; (camera_center_x + 0)
;  78, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1850 : ad 67 33 LDA $3367 ; (view + 1)
1853 : 18 __ __ CLC
1854 : 69 0c __ ADC #$0c
1856 : 8d 65 33 STA $3365 ; (camera_center_y + 0)
;  81, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1859 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
185c : cd 66 33 CMP $3366 ; (view + 0)
185f : d0 08 __ BNE $1869 ; (update_camera.s13 + 0)
.s16:
1861 : ad f8 9f LDA $9ff8 ; (room + 1)
1864 : cd 67 33 CMP $3367 ; (view + 1)
1867 : f0 05 __ BEQ $186e ; (update_camera.s1001 + 0)
.s13:
;  82, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1869 : a9 01 __ LDA #$01
186b : 8d 50 37 STA $3750 ; (screen_dirty + 0)
.s1001:
;  84, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
186e : 60 __ __ RTS
--------------------------------------------------------------------
186f : __ __ __ BYT 0a 0a 43 4f 4e 4e 45 43 54 49 4e 47 20 52 4f 4f : ..CONNECTING ROO
187f : __ __ __ BYT 4d 53 20 57 49 54 48 20 43 4f 52 52 49 44 4f 52 : MS WITH CORRIDOR
188f : __ __ __ BYT 53 00                                           : S.
--------------------------------------------------------------------
rooms_are_connected: ; rooms_are_connected(u8,u8)->u8
.s0:
; 523, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1891 : a5 0d __ LDA P0 ; (room1 + 0)
1893 : cd 1c 32 CMP $321c ; (room_count + 0)
1896 : b0 07 __ BCS $189f ; (rooms_are_connected.s1 + 0)
.s4:
1898 : a4 0e __ LDY P1 ; (room2 + 0)
; 523, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
189a : cc 1c 32 CPY $321c ; (room_count + 0)
189d : 90 03 __ BCC $18a2 ; (rooms_are_connected.s3 + 0)
.s1:
189f : a9 00 __ LDA #$00
18a1 : 60 __ __ RTS
.s3:
; 524, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18a2 : 0a __ __ ASL
18a3 : 0a __ __ ASL
18a4 : 65 0d __ ADC P0 ; (room1 + 0)
18a6 : 0a __ __ ASL
18a7 : 0a __ __ ASL
18a8 : aa __ __ TAX
18a9 : a9 00 __ LDA #$00
18ab : 2a __ __ ROL
18ac : 85 1c __ STA ACCU + 1 
18ae : 8a __ __ TXA
18af : 69 52 __ ADC #$52
18b1 : 85 1b __ STA ACCU + 0 
18b3 : a9 3d __ LDA #$3d
18b5 : 65 1c __ ADC ACCU + 1 
18b7 : 85 1c __ STA ACCU + 1 
18b9 : b1 1b __ LDA (ACCU + 0),y 
.s1001:
18bb : 60 __ __ RTS
--------------------------------------------------------------------
can_connect_rooms_safely: ; can_connect_rooms_safely(u8,u8)->u8
.s0:
;  76, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18bc : a5 17 __ LDA P10 ; (room1 + 0)
18be : cd 1c 32 CMP $321c ; (room_count + 0)
18c1 : b0 1f __ BCS $18e2 ; (can_connect_rooms_safely.s1 + 0)
.s5:
18c3 : a5 18 __ LDA P11 ; (room2 + 0)
18c5 : cd 1c 32 CMP $321c ; (room_count + 0)
18c8 : b0 18 __ BCS $18e2 ; (can_connect_rooms_safely.s1 + 0)
.s4:
18ca : a5 17 __ LDA P10 ; (room1 + 0)
18cc : c5 18 __ CMP P11 ; (room2 + 0)
18ce : f0 12 __ BEQ $18e2 ; (can_connect_rooms_safely.s1 + 0)
.s3:
;  81, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18d0 : 85 15 __ STA P8 
18d2 : a5 18 __ LDA P11 ; (room2 + 0)
18d4 : 85 16 __ STA P9 
18d6 : 20 73 19 JSR $1973 ; (get_cached_room_distance.s0 + 0)
18d9 : a5 1b __ LDA ACCU + 0 
18db : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
;  82, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18de : c9 1f __ CMP #$1f
18e0 : 90 05 __ BCC $18e7 ; (can_connect_rooms_safely.s9 + 0)
.s1:
;  77, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18e2 : a9 00 __ LDA #$00
18e4 : 4c 70 19 JMP $1970 ; (can_connect_rooms_safely.s1001 + 0)
.s9:
;  87, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18e7 : a5 17 __ LDA P10 ; (room1 + 0)
18e9 : 0a __ __ ASL
18ea : 0a __ __ ASL
18eb : 0a __ __ ASL
18ec : aa __ __ TAX
18ed : bd 00 41 LDA $4100,x ; (rooms + 0)
18f0 : 38 __ __ SEC
18f1 : e9 04 __ SBC #$04
18f3 : 8d f3 9f STA $9ff3 ; (room1_buffer_x1 + 0)
;  88, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18f6 : bd 01 41 LDA $4101,x ; (rooms + 1)
18f9 : 38 __ __ SEC
18fa : e9 04 __ SBC #$04
18fc : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
;  89, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18ff : bd 02 41 LDA $4102,x ; (rooms + 2)
1902 : 18 __ __ CLC
1903 : 7d 00 41 ADC $4100,x ; (rooms + 0)
1906 : 18 __ __ CLC
1907 : 69 04 __ ADC #$04
1909 : 8d f1 9f STA $9ff1 ; (cell_h + 0)
;  90, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
190c : bd 03 41 LDA $4103,x ; (rooms + 3)
190f : 18 __ __ CLC
1910 : 7d 01 41 ADC $4101,x ; (rooms + 1)
1913 : 18 __ __ CLC
1914 : 69 04 __ ADC #$04
1916 : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
;  91, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1919 : a5 18 __ LDA P11 ; (room2 + 0)
191b : 0a __ __ ASL
191c : 0a __ __ ASL
191d : 0a __ __ ASL
191e : aa __ __ TAX
191f : bd 00 41 LDA $4100,x ; (rooms + 0)
1922 : 38 __ __ SEC
1923 : e9 04 __ SBC #$04
1925 : 8d ef 9f STA $9fef ; (screen_pos + 1)
;  92, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1928 : bd 01 41 LDA $4101,x ; (rooms + 1)
192b : 38 __ __ SEC
192c : e9 04 __ SBC #$04
192e : 8d ee 9f STA $9fee ; (entropy4 + 1)
;  93, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1931 : bd 02 41 LDA $4102,x ; (rooms + 2)
1934 : 18 __ __ CLC
1935 : 7d 00 41 ADC $4100,x ; (rooms + 0)
1938 : 18 __ __ CLC
1939 : 69 04 __ ADC #$04
193b : 8d ed 9f STA $9fed ; (extra_range_y + 0)
;  94, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
193e : bd 03 41 LDA $4103,x ; (rooms + 3)
1941 : 18 __ __ CLC
1942 : 7d 01 41 ADC $4101,x ; (rooms + 1)
1945 : 18 __ __ CLC
1946 : 69 04 __ ADC #$04
1948 : 8d ec 9f STA $9fec ; (random_offset_x + 0)
;  97, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
194b : ad ef 9f LDA $9fef ; (screen_pos + 1)
194e : cd f1 9f CMP $9ff1 ; (cell_h + 0)
1951 : b0 1b __ BCS $196e ; (can_connect_rooms_safely.s13 + 0)
.s16:
1953 : ad f3 9f LDA $9ff3 ; (room1_buffer_x1 + 0)
1956 : cd ed 9f CMP $9fed ; (extra_range_y + 0)
1959 : b0 13 __ BCS $196e ; (can_connect_rooms_safely.s13 + 0)
.s15:
;  98, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
195b : ad ee 9f LDA $9fee ; (entropy4 + 1)
195e : cd f0 9f CMP $9ff0 ; (entropy3 + 1)
1961 : b0 0b __ BCS $196e ; (can_connect_rooms_safely.s13 + 0)
.s14:
1963 : ad f2 9f LDA $9ff2 ; (entropy2 + 1)
1966 : cd ec 9f CMP $9fec ; (random_offset_x + 0)
1969 : a9 00 __ LDA #$00
196b : 2a __ __ ROL
196c : 90 02 __ BCC $1970 ; (can_connect_rooms_safely.s1001 + 0)
.s13:
; 102, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
196e : a9 01 __ LDA #$01
.s1001:
1970 : 85 1b __ STA ACCU + 0 
1972 : 60 __ __ RTS
--------------------------------------------------------------------
get_cached_room_distance: ; get_cached_room_distance(u8,u8)->u8
.s0:
;  53, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1973 : ad 29 33 LDA $3329 ; (distance_cache_valid + 0)
1976 : f0 0c __ BEQ $1984 ; (get_cached_room_distance.s1006 + 0)
.s5:
1978 : a5 15 __ LDA P8 ; (room1 + 0)
197a : c9 14 __ CMP #$14
197c : b0 08 __ BCS $1986 ; (get_cached_room_distance.s1 + 0)
.s4:
197e : a5 16 __ LDA P9 ; (room2 + 0)
1980 : c9 14 __ CMP #$14
1982 : 90 0e __ BCC $1992 ; (get_cached_room_distance.s3 + 0)
.s1006:
;  54, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1984 : a5 15 __ LDA P8 ; (room1 + 0)
.s1:
1986 : 85 13 __ STA P6 
1988 : a5 16 __ LDA P9 ; (room2 + 0)
198a : 85 14 __ STA P7 
198c : 20 08 0d JSR $0d08 ; (calculate_room_distance.s0 + 0)
.s1001:
198f : 85 1b __ STA ACCU + 0 
1991 : 60 __ __ RTS
.s3:
;  57, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1992 : a5 15 __ LDA P8 ; (room1 + 0)
1994 : 0a __ __ ASL
1995 : 0a __ __ ASL
1996 : 65 15 __ ADC P8 ; (room1 + 0)
1998 : 0a __ __ ASL
1999 : 0a __ __ ASL
199a : a2 00 __ LDX #$00
199c : 90 01 __ BCC $199f ; (get_cached_room_distance.s1003 + 0)
.s1002:
199e : e8 __ __ INX
.s1003:
199f : 18 __ __ CLC
19a0 : 69 e2 __ ADC #$e2
19a2 : 85 45 __ STA T0 + 0 
19a4 : 8a __ __ TXA
19a5 : 69 3e __ ADC #$3e
19a7 : 85 46 __ STA T0 + 1 
19a9 : a4 16 __ LDY P9 ; (room2 + 0)
19ab : b1 45 __ LDA (T0 + 0),y 
19ad : 8d f5 9f STA $9ff5 ; (s + 1)
;  58, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
19b0 : c9 ff __ CMP #$ff
19b2 : d0 db __ BNE $198f ; (get_cached_room_distance.s1001 + 0)
.s9:
;  63, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
19b4 : 84 14 __ STY P7 
19b6 : a5 15 __ LDA P8 ; (room1 + 0)
19b8 : 85 13 __ STA P6 
19ba : 20 08 0d JSR $0d08 ; (calculate_room_distance.s0 + 0)
;  64, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
19bd : a4 16 __ LDY P9 ; (room2 + 0)
19bf : 91 45 __ STA (T0 + 0),y 
;  63, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
19c1 : 8d f5 9f STA $9ff5 ; (s + 1)
19c4 : aa __ __ TAX
;  65, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
19c5 : 98 __ __ TYA
19c6 : 0a __ __ ASL
19c7 : 0a __ __ ASL
19c8 : 65 16 __ ADC P9 ; (room2 + 0)
19ca : 0a __ __ ASL
19cb : 0a __ __ ASL
19cc : a0 00 __ LDY #$00
19ce : 90 01 __ BCC $19d1 ; (get_cached_room_distance.s1005 + 0)
.s1004:
19d0 : c8 __ __ INY
.s1005:
19d1 : 18 __ __ CLC
19d2 : 69 e2 __ ADC #$e2
19d4 : 85 45 __ STA T0 + 0 
19d6 : 98 __ __ TYA
19d7 : 69 3e __ ADC #$3e
19d9 : 85 46 __ STA T0 + 1 
19db : 8a __ __ TXA
19dc : a4 15 __ LDY P8 ; (room1 + 0)
19de : 91 45 __ STA (T0 + 0),y 
;  67, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
19e0 : 4c 8f 19 JMP $198f ; (get_cached_room_distance.s1001 + 0)
--------------------------------------------------------------------
rule_based_connect_rooms: ; rule_based_connect_rooms(u8,u8)->u8
.s1000:
19e3 : a5 53 __ LDA T5 + 0 
19e5 : 8d 48 9f STA $9f48 ; (rule_based_connect_rooms@stack + 0)
19e8 : a5 54 __ LDA T5 + 1 
19ea : 8d 49 9f STA $9f49 ; (rule_based_connect_rooms@stack + 1)
19ed : a5 55 __ LDA T9 + 0 
19ef : 8d 4a 9f STA $9f4a ; (rule_based_connect_rooms@stack + 2)
.s0:
; 447, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
19f2 : ad fe 9f LDA $9ffe ; (sstack + 4)
19f5 : 85 52 __ STA T8 + 0 
19f7 : 85 17 __ STA P10 
19f9 : ad ff 9f LDA $9fff ; (sstack + 5)
19fc : 85 55 __ STA T9 + 0 
19fe : 85 18 __ STA P11 
1a00 : 20 bc 18 JSR $18bc ; (can_connect_rooms_safely.s0 + 0)
1a03 : a5 1b __ LDA ACCU + 0 
1a05 : d0 03 __ BNE $1a0a ; (rule_based_connect_rooms.s3 + 0)
1a07 : 4c 8f 1a JMP $1a8f ; (rule_based_connect_rooms.s1001 + 0)
.s3:
; 452, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a0a : a5 52 __ LDA T8 + 0 
1a0c : 0a __ __ ASL
1a0d : 0a __ __ ASL
1a0e : 65 52 __ ADC T8 + 0 
1a10 : 0a __ __ ASL
1a11 : 0a __ __ ASL
1a12 : a2 00 __ LDX #$00
1a14 : 90 01 __ BCC $1a17 ; (rule_based_connect_rooms.s1005 + 0)
.s1004:
1a16 : e8 __ __ INX
.s1005:
1a17 : 18 __ __ CLC
1a18 : 69 52 __ ADC #$52
1a1a : 85 53 __ STA T5 + 0 
1a1c : 8a __ __ TXA
1a1d : 69 3d __ ADC #$3d
1a1f : 85 54 __ STA T5 + 1 
1a21 : a4 55 __ LDY T9 + 0 
1a23 : b1 53 __ LDA (T5 + 0),y 
1a25 : d0 66 __ BNE $1a8d ; (rule_based_connect_rooms.s5 + 0)
.s7:
; 460, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a27 : 8d 51 9f STA $9f51 ; (i + 0)
; 459, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a2a : 8d 50 9f STA $9f50 ; (sp + 0)
.l10:
; 460, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a2d : a9 00 __ LDA #$00
1a2f : ae 51 9f LDX $9f51 ; (i + 0)
1a32 : 9d 9a 40 STA $409a,x ; (visited_global + 0)
1a35 : ee 51 9f INC $9f51 ; (i + 0)
1a38 : ad 51 9f LDA $9f51 ; (i + 0)
1a3b : c9 14 __ CMP #$14
1a3d : 90 ee __ BCC $1a2d ; (rule_based_connect_rooms.l10 + 0)
.s12:
; 461, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a3f : a9 01 __ LDA #$01
1a41 : 8d 50 9f STA $9f50 ; (sp + 0)
1a44 : a6 52 __ LDX T8 + 0 
1a46 : 8e ae 40 STX $40ae ; (stack_global + 0)
; 462, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a49 : 9d 9a 40 STA $409a,x ; (visited_global + 0)
.l14:
; 465, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a4c : a9 00 __ LDA #$00
1a4e : 8d 51 9f STA $9f51 ; (i + 0)
; 464, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a51 : ae 50 9f LDX $9f50 ; (sp + 0)
1a54 : ce 50 9f DEC $9f50 ; (sp + 0)
1a57 : bd ad 40 LDA $40ad,x ; (visited_global + 19)
1a5a : 8d 4f 9f STA $9f4f ; (current + 0)
; 465, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a5d : ad 1c 32 LDA $321c ; (room_count + 0)
1a60 : f0 56 __ BEQ $1ab8 ; (rule_based_connect_rooms.s13 + 0)
.s49:
; 466, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a62 : 85 49 __ STA T6 + 0 
1a64 : bd ad 40 LDA $40ad,x ; (visited_global + 19)
1a67 : 0a __ __ ASL
1a68 : 0a __ __ ASL
1a69 : 7d ad 40 ADC $40ad,x ; (visited_global + 19)
1a6c : 0a __ __ ASL
1a6d : 0a __ __ ASL
1a6e : a2 00 __ LDX #$00
1a70 : 90 01 __ BCC $1a73 ; (rule_based_connect_rooms.s1007 + 0)
.s1006:
1a72 : e8 __ __ INX
.s1007:
1a73 : 18 __ __ CLC
1a74 : 69 52 __ ADC #$52
1a76 : 85 43 __ STA T0 + 0 
1a78 : 8a __ __ TXA
1a79 : 69 3d __ ADC #$3d
1a7b : 85 44 __ STA T0 + 1 
.l17:
1a7d : ac 51 9f LDY $9f51 ; (i + 0)
1a80 : b1 43 __ LDA (T0 + 0),y 
1a82 : f0 2c __ BEQ $1ab0 ; (rule_based_connect_rooms.s16 + 0)
.s23:
1a84 : b9 9a 40 LDA $409a,y ; (visited_global + 0)
1a87 : d0 27 __ BNE $1ab0 ; (rule_based_connect_rooms.s16 + 0)
.s20:
; 467, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a89 : c4 55 __ CPY T9 + 0 
1a8b : d0 14 __ BNE $1aa1 ; (rule_based_connect_rooms.s26 + 0)
.s5:
; 453, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a8d : a9 01 __ LDA #$01
.s1001:
; 448, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a8f : 85 1b __ STA ACCU + 0 
1a91 : ad 48 9f LDA $9f48 ; (rule_based_connect_rooms@stack + 0)
1a94 : 85 53 __ STA T5 + 0 
1a96 : ad 49 9f LDA $9f49 ; (rule_based_connect_rooms@stack + 1)
1a99 : 85 54 __ STA T5 + 1 
1a9b : ad 4a 9f LDA $9f4a ; (rule_based_connect_rooms@stack + 2)
1a9e : 85 55 __ STA T9 + 0 
1aa0 : 60 __ __ RTS
.s26:
; 470, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1aa1 : a9 01 __ LDA #$01
1aa3 : 99 9a 40 STA $409a,y ; (visited_global + 0)
; 471, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1aa6 : ae 50 9f LDX $9f50 ; (sp + 0)
1aa9 : ee 50 9f INC $9f50 ; (sp + 0)
1aac : 98 __ __ TYA
1aad : 9d ae 40 STA $40ae,x ; (stack_global + 0)
.s16:
; 465, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ab0 : c8 __ __ INY
1ab1 : 8c 51 9f STY $9f51 ; (i + 0)
1ab4 : c4 49 __ CPY T6 + 0 
1ab6 : 90 c5 __ BCC $1a7d ; (rule_based_connect_rooms.l17 + 0)
.s13:
; 463, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ab8 : ad 50 9f LDA $9f50 ; (sp + 0)
1abb : d0 8f __ BNE $1a4c ; (rule_based_connect_rooms.l14 + 0)
.s15:
; 477, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1abd : a5 52 __ LDA T8 + 0 
1abf : 85 13 __ STA P6 
1ac1 : a5 55 __ LDA T9 + 0 
1ac3 : 85 14 __ STA P7 
1ac5 : 20 12 1b JSR $1b12 ; (can_reuse_existing_path.s0 + 0)
1ac8 : a5 1b __ LDA ACCU + 0 
1aca : f0 11 __ BEQ $1add ; (rule_based_connect_rooms.s30 + 0)
.s28:
; 478, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1acc : a5 13 __ LDA P6 
1ace : 8d fc 9f STA $9ffc ; (sstack + 2)
1ad1 : a5 14 __ LDA P7 
1ad3 : 8d fd 9f STA $9ffd ; (sstack + 3)
1ad6 : 20 13 1d JSR $1d13 ; (connect_via_existing_corridors.s0 + 0)
1ad9 : a5 1b __ LDA ACCU + 0 
1adb : d0 10 __ BNE $1aed ; (rule_based_connect_rooms.s31 + 0)
.s30:
; 485, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1add : a5 52 __ LDA T8 + 0 
1adf : 8d fc 9f STA $9ffc ; (sstack + 2)
1ae2 : a5 55 __ LDA T9 + 0 
1ae4 : 8d fd 9f STA $9ffd ; (sstack + 3)
1ae7 : 20 7d 24 JSR $247d ; (draw_rule_based_corridor.s0 + 0)
1aea : aa __ __ TAX
1aeb : f0 a2 __ BEQ $1a8f ; (rule_based_connect_rooms.s1001 + 0)
.s31:
; 479, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1aed : a9 01 __ LDA #$01
1aef : a4 55 __ LDY T9 + 0 
1af1 : 91 53 __ STA (T5 + 0),y 
; 480, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1af3 : 98 __ __ TYA
1af4 : 0a __ __ ASL
1af5 : 0a __ __ ASL
1af6 : 65 55 __ ADC T9 + 0 
1af8 : 0a __ __ ASL
1af9 : 0a __ __ ASL
1afa : a2 00 __ LDX #$00
1afc : 90 01 __ BCC $1aff ; (rule_based_connect_rooms.s1009 + 0)
.s1008:
1afe : e8 __ __ INX
.s1009:
1aff : 18 __ __ CLC
1b00 : 69 52 __ ADC #$52
1b02 : 85 43 __ STA T0 + 0 
1b04 : 8a __ __ TXA
1b05 : 69 3d __ ADC #$3d
1b07 : 85 44 __ STA T0 + 1 
1b09 : a9 01 __ LDA #$01
1b0b : a4 52 __ LDY T8 + 0 
1b0d : 91 43 __ STA (T0 + 0),y 
; 481, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b0f : 4c 8f 1a JMP $1a8f ; (rule_based_connect_rooms.s1001 + 0)
--------------------------------------------------------------------
can_reuse_existing_path: ; can_reuse_existing_path(u8,u8)->u8
.s0:
; 243, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b12 : a5 13 __ LDA P6 ; (room1 + 0)
1b14 : 85 0d __ STA P0 
1b16 : a9 f3 __ LDA #$f3
1b18 : 85 0e __ STA P1 
1b1a : a9 9f __ LDA #$9f
1b1c : 85 11 __ STA P4 
1b1e : a9 9f __ LDA #$9f
1b20 : 85 0f __ STA P2 
1b22 : a9 f2 __ LDA #$f2
1b24 : 85 10 __ STA P3 
1b26 : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 244, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b29 : a5 14 __ LDA P7 ; (room2 + 0)
1b2b : 85 0d __ STA P0 
1b2d : a9 f1 __ LDA #$f1
1b2f : 85 0e __ STA P1 
1b31 : a9 9f __ LDA #$9f
1b33 : 85 11 __ STA P4 
1b35 : a9 9f __ LDA #$9f
1b37 : 85 0f __ STA P2 
1b39 : a9 f0 __ LDA #$f0
1b3b : 85 10 __ STA P3 
1b3d : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 248, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b40 : a9 00 __ LDA #$00
1b42 : 8d ef 9f STA $9fef ; (screen_pos + 1)
1b45 : 8d ee 9f STA $9fee ; (entropy4 + 1)
; 251, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b48 : a9 fc __ LDA #$fc
1b4a : 8d ed 9f STA $9fed ; (extra_range_y + 0)
.l2:
; 252, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b4d : a9 fc __ LDA #$fc
1b4f : 8d ec 9f STA $9fec ; (random_offset_x + 0)
1b52 : ad ef 9f LDA $9fef ; (screen_pos + 1)
1b55 : d0 59 __ BNE $1bb0 ; (can_reuse_existing_path.s3 + 0)
.l7:
; 253, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b57 : ad ed 9f LDA $9fed ; (extra_range_y + 0)
1b5a : 18 __ __ CLC
1b5b : 6d f3 9f ADC $9ff3 ; (room1_buffer_x1 + 0)
1b5e : 85 46 __ STA T2 + 0 
1b60 : 85 0d __ STA P0 
1b62 : 8d eb 9f STA $9feb ; (screen_offset + 1)
; 254, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b65 : ad ec 9f LDA $9fec ; (random_offset_x + 0)
1b68 : 85 47 __ STA T3 + 0 
1b6a : 18 __ __ CLC
1b6b : 6d f2 9f ADC $9ff2 ; (entropy2 + 1)
1b6e : 85 45 __ STA T0 + 0 
1b70 : 85 0e __ STA P1 
1b72 : 8d ea 9f STA $9fea ; (i + 0)
; 256, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b75 : 20 58 1c JSR $1c58 ; (coords_in_bounds_fast.s0 + 0)
1b78 : aa __ __ TAX
1b79 : f0 22 __ BEQ $1b9d ; (can_reuse_existing_path.s6 + 0)
.s15:
; 257, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b7b : a5 0d __ LDA P0 
1b7d : 85 11 __ STA P4 
1b7f : a5 0e __ LDA P1 
1b81 : 85 12 __ STA P5 
1b83 : 20 6b 1c JSR $1c6b ; (tile_is_floor_fast.s0 + 0)
1b86 : a5 1b __ LDA ACCU + 0 
1b88 : f0 13 __ BEQ $1b9d ; (can_reuse_existing_path.s6 + 0)
.s14:
; 258, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b8a : a5 46 __ LDA T2 + 0 
1b8c : 85 0f __ STA P2 
1b8e : a5 45 __ LDA T0 + 0 
1b90 : 85 10 __ STA P3 
1b92 : 20 af 1c JSR $1caf ; (is_outside_any_room.s0 + 0)
1b95 : aa __ __ TAX
1b96 : f0 05 __ BEQ $1b9d ; (can_reuse_existing_path.s6 + 0)
.s11:
; 259, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b98 : a9 01 __ LDA #$01
1b9a : 8d ef 9f STA $9fef ; (screen_pos + 1)
.s6:
; 252, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b9d : 18 __ __ CLC
1b9e : a5 47 __ LDA T3 + 0 
1ba0 : 69 01 __ ADC #$01
1ba2 : 8d ec 9f STA $9fec ; (random_offset_x + 0)
1ba5 : 30 04 __ BMI $1bab ; (can_reuse_existing_path.s10 + 0)
.s1007:
1ba7 : c9 05 __ CMP #$05
1ba9 : b0 05 __ BCS $1bb0 ; (can_reuse_existing_path.s3 + 0)
.s10:
; 252, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bab : ad ef 9f LDA $9fef ; (screen_pos + 1)
1bae : f0 a7 __ BEQ $1b57 ; (can_reuse_existing_path.l7 + 0)
.s3:
; 251, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bb0 : ad ed 9f LDA $9fed ; (extra_range_y + 0)
1bb3 : ee ed 9f INC $9fed ; (extra_range_y + 0)
1bb6 : 49 80 __ EOR #$80
1bb8 : c9 84 __ CMP #$84
1bba : ad ef 9f LDA $9fef ; (screen_pos + 1)
1bbd : 90 03 __ BCC $1bc2 ; (can_reuse_existing_path.s5 + 0)
1bbf : 4c 53 1c JMP $1c53 ; (can_reuse_existing_path.s4 + 0)
.s5:
1bc2 : f0 89 __ BEQ $1b4d ; (can_reuse_existing_path.l2 + 0)
.s18:
; 268, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bc4 : 85 47 __ STA T3 + 0 
1bc6 : a9 fc __ LDA #$fc
1bc8 : 8d e9 9f STA $9fe9 ; (y + 0)
1bcb : ad ee 9f LDA $9fee ; (entropy4 + 1)
1bce : d0 75 __ BNE $1c45 ; (can_reuse_existing_path.s23 + 0)
.l21:
; 269, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bd0 : a9 fc __ LDA #$fc
1bd2 : 8d e8 9f STA $9fe8 ; (attempts + 0)
1bd5 : ad ee 9f LDA $9fee ; (entropy4 + 1)
1bd8 : d0 59 __ BNE $1c33 ; (can_reuse_existing_path.s22 + 0)
.l26:
; 270, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bda : ad e9 9f LDA $9fe9 ; (y + 0)
1bdd : 18 __ __ CLC
1bde : 6d f1 9f ADC $9ff1 ; (cell_h + 0)
1be1 : 85 46 __ STA T2 + 0 
1be3 : 85 0d __ STA P0 
1be5 : 8d e7 9f STA $9fe7 ; (down_x + 0)
; 271, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1be8 : ad e8 9f LDA $9fe8 ; (attempts + 0)
1beb : 85 48 __ STA T4 + 0 
1bed : 18 __ __ CLC
1bee : 6d f0 9f ADC $9ff0 ; (entropy3 + 1)
1bf1 : 85 45 __ STA T0 + 0 
1bf3 : 85 0e __ STA P1 
1bf5 : 8d e6 9f STA $9fe6 ; (i + 0)
; 273, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bf8 : 20 58 1c JSR $1c58 ; (coords_in_bounds_fast.s0 + 0)
1bfb : aa __ __ TAX
1bfc : f0 22 __ BEQ $1c20 ; (can_reuse_existing_path.s25 + 0)
.s34:
; 274, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bfe : a5 0d __ LDA P0 
1c00 : 85 11 __ STA P4 
1c02 : a5 0e __ LDA P1 
1c04 : 85 12 __ STA P5 
1c06 : 20 6b 1c JSR $1c6b ; (tile_is_floor_fast.s0 + 0)
1c09 : a5 1b __ LDA ACCU + 0 
1c0b : f0 13 __ BEQ $1c20 ; (can_reuse_existing_path.s25 + 0)
.s33:
; 275, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c0d : a5 46 __ LDA T2 + 0 
1c0f : 85 0f __ STA P2 
1c11 : a5 45 __ LDA T0 + 0 
1c13 : 85 10 __ STA P3 
1c15 : 20 af 1c JSR $1caf ; (is_outside_any_room.s0 + 0)
1c18 : aa __ __ TAX
1c19 : f0 05 __ BEQ $1c20 ; (can_reuse_existing_path.s25 + 0)
.s30:
; 276, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c1b : a9 01 __ LDA #$01
1c1d : 8d ee 9f STA $9fee ; (entropy4 + 1)
.s25:
; 269, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c20 : 18 __ __ CLC
1c21 : a5 48 __ LDA T4 + 0 
1c23 : 69 01 __ ADC #$01
1c25 : 8d e8 9f STA $9fe8 ; (attempts + 0)
1c28 : 30 04 __ BMI $1c2e ; (can_reuse_existing_path.s29 + 0)
.s1006:
1c2a : c9 05 __ CMP #$05
1c2c : b0 05 __ BCS $1c33 ; (can_reuse_existing_path.s22 + 0)
.s29:
; 269, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c2e : ad ee 9f LDA $9fee ; (entropy4 + 1)
1c31 : f0 a7 __ BEQ $1bda ; (can_reuse_existing_path.l26 + 0)
.s22:
; 268, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c33 : ad e9 9f LDA $9fe9 ; (y + 0)
1c36 : ee e9 9f INC $9fe9 ; (y + 0)
1c39 : aa __ __ TAX
1c3a : 30 04 __ BMI $1c40 ; (can_reuse_existing_path.s24 + 0)
.s1005:
1c3c : c9 04 __ CMP #$04
1c3e : b0 05 __ BCS $1c45 ; (can_reuse_existing_path.s23 + 0)
.s24:
; 268, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c40 : ad ee 9f LDA $9fee ; (entropy4 + 1)
1c43 : f0 8b __ BEQ $1bd0 ; (can_reuse_existing_path.l21 + 0)
.s23:
; 282, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c45 : a5 47 __ LDA T3 + 0 
1c47 : f0 07 __ BEQ $1c50 ; (can_reuse_existing_path.s1001 + 0)
.s38:
1c49 : ad ee 9f LDA $9fee ; (entropy4 + 1)
1c4c : f0 02 __ BEQ $1c50 ; (can_reuse_existing_path.s1001 + 0)
.s35:
1c4e : a9 01 __ LDA #$01
.s1001:
; 265, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c50 : 85 1b __ STA ACCU + 0 
1c52 : 60 __ __ RTS
.s4:
1c53 : f0 fb __ BEQ $1c50 ; (can_reuse_existing_path.s1001 + 0)
1c55 : 4c c4 1b JMP $1bc4 ; (can_reuse_existing_path.s18 + 0)
--------------------------------------------------------------------
coords_in_bounds_fast: ; coords_in_bounds_fast(u8,u8)->u8
.s0:
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utility.h"
1c58 : a5 0d __ LDA P0 ; (x + 0)
1c5a : c9 40 __ CMP #$40
1c5c : b0 0a __ BCS $1c68 ; (coords_in_bounds_fast.s2 + 0)
.s4:
1c5e : a5 0e __ LDA P1 ; (y + 0)
1c60 : c9 40 __ CMP #$40
1c62 : a9 00 __ LDA #$00
1c64 : 2a __ __ ROL
1c65 : 49 01 __ EOR #$01
1c67 : 60 __ __ RTS
.s2:
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utility.h"
1c68 : a9 00 __ LDA #$00
.s1001:
1c6a : 60 __ __ RTS
--------------------------------------------------------------------
tile_is_floor_fast: ; tile_is_floor_fast(u8,u8)->u8
.s0:
;  37, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utility.h"
1c6b : a5 11 __ LDA P4 ; (x + 0)
1c6d : 85 0d __ STA P0 
1c6f : a5 12 __ LDA P5 ; (y + 0)
1c71 : 85 0e __ STA P1 
1c73 : 20 58 1c JSR $1c58 ; (coords_in_bounds_fast.s0 + 0)
1c76 : aa __ __ TAX
1c77 : f0 17 __ BEQ $1c90 ; (tile_is_floor_fast.s1001 + 0)
.s3:
;  38, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utility.h"
1c79 : a5 11 __ LDA P4 ; (x + 0)
1c7b : 85 0f __ STA P2 
1c7d : a5 12 __ LDA P5 ; (y + 0)
1c7f : 85 10 __ STA P3 
1c81 : 20 93 1c JSR $1c93 ; (get_tile_raw.s0 + 0)
1c84 : a5 1b __ LDA ACCU + 0 
1c86 : c9 02 __ CMP #$02
1c88 : d0 04 __ BNE $1c8e ; (tile_is_floor_fast.s1003 + 0)
.s1002:
1c8a : a9 01 __ LDA #$01
1c8c : d0 02 __ BNE $1c90 ; (tile_is_floor_fast.s1001 + 0)
.s1003:
1c8e : a9 00 __ LDA #$00
.s1001:
;  37, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utility.h"
1c90 : 85 1b __ STA ACCU + 0 
1c92 : 60 __ __ RTS
--------------------------------------------------------------------
get_tile_raw: ; get_tile_raw(u8,u8)->u8
.s0:
; 291, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1c93 : a5 0f __ LDA P2 ; (x + 0)
1c95 : c9 40 __ CMP #$40
1c97 : b0 06 __ BCS $1c9f ; (get_tile_raw.s1 + 0)
.s4:
1c99 : a5 10 __ LDA P3 ; (y + 0)
1c9b : c9 40 __ CMP #$40
1c9d : 90 04 __ BCC $1ca3 ; (get_tile_raw.s3 + 0)
.s1:
1c9f : a9 00 __ LDA #$00
1ca1 : b0 09 __ BCS $1cac ; (get_tile_raw.s1001 + 0)
.s3:
; 292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1ca3 : 85 0e __ STA P1 
1ca5 : a5 0f __ LDA P2 ; (x + 0)
1ca7 : 85 0d __ STA P0 
1ca9 : 20 14 15 JSR $1514 ; (get_tile_core.s0 + 0)
.s1001:
1cac : 85 1b __ STA ACCU + 0 
1cae : 60 __ __ RTS
--------------------------------------------------------------------
is_outside_any_room: ; is_outside_any_room(u8,u8)->u8
.s0:
; 143, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1caf : a5 0f __ LDA P2 ; (x + 0)
1cb1 : 85 0d __ STA P0 
1cb3 : a5 10 __ LDA P3 ; (y + 0)
1cb5 : 85 0e __ STA P1 
1cb7 : 20 c3 1c JSR $1cc3 ; (is_inside_room.s0 + 0)
1cba : c9 01 __ CMP #$01
1cbc : a9 00 __ LDA #$00
1cbe : 69 ff __ ADC #$ff
1cc0 : 29 01 __ AND #$01
.s1001:
1cc2 : 60 __ __ RTS
--------------------------------------------------------------------
is_inside_room: ; is_inside_room(u8,u8)->u8
.s0:
; 132, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1cc3 : a9 00 __ LDA #$00
1cc5 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
1cc8 : ad 1c 32 LDA $321c ; (room_count + 0)
1ccb : f0 40 __ BEQ $1d0d ; (is_inside_room.s4 + 0)
.s1008:
1ccd : 85 1c __ STA ACCU + 1 
1ccf : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
1cd2 : a4 0d __ LDY P0 ; (x + 0)
.l2:
; 133, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1cd4 : 0a __ __ ASL
1cd5 : 0a __ __ ASL
1cd6 : 0a __ __ ASL
1cd7 : aa __ __ TAX
1cd8 : 98 __ __ TYA
1cd9 : dd 00 41 CMP $4100,x ; (rooms + 0)
1cdc : 90 25 __ BCC $1d03 ; (is_inside_room.s3 + 0)
.s10:
1cde : bd 02 41 LDA $4102,x ; (rooms + 2)
1ce1 : 18 __ __ CLC
1ce2 : 7d 00 41 ADC $4100,x ; (rooms + 0)
1ce5 : b0 06 __ BCS $1ced ; (is_inside_room.s9 + 0)
.s1005:
1ce7 : 85 1b __ STA ACCU + 0 
1ce9 : c4 1b __ CPY ACCU + 0 
1ceb : b0 16 __ BCS $1d03 ; (is_inside_room.s3 + 0)
.s9:
; 134, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1ced : a5 0e __ LDA P1 ; (y + 0)
1cef : dd 01 41 CMP $4101,x ; (rooms + 1)
1cf2 : 90 0f __ BCC $1d03 ; (is_inside_room.s3 + 0)
.s8:
1cf4 : bd 03 41 LDA $4103,x ; (rooms + 3)
1cf7 : 18 __ __ CLC
1cf8 : 7d 01 41 ADC $4101,x ; (rooms + 1)
1cfb : b0 13 __ BCS $1d10 ; (is_inside_room.s5 + 0)
.s1002:
1cfd : c5 0e __ CMP P1 ; (y + 0)
1cff : 90 02 __ BCC $1d03 ; (is_inside_room.s3 + 0)
.s1011:
1d01 : d0 0d __ BNE $1d10 ; (is_inside_room.s5 + 0)
.s3:
; 132, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1d03 : ee f9 9f INC $9ff9 ; (bit_offset + 1)
1d06 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
1d09 : c5 1c __ CMP ACCU + 1 
1d0b : 90 c7 __ BCC $1cd4 ; (is_inside_room.l2 + 0)
.s4:
; 138, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1d0d : a9 00 __ LDA #$00
.s1001:
1d0f : 60 __ __ RTS
.s5:
1d10 : a9 01 __ LDA #$01
1d12 : 60 __ __ RTS
--------------------------------------------------------------------
connect_via_existing_corridors: ; connect_via_existing_corridors(u8,u8)->u8
.s0:
; 291, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1d13 : ad fc 9f LDA $9ffc ; (sstack + 2)
1d16 : 85 48 __ STA T1 + 0 
1d18 : 85 0d __ STA P0 
1d1a : a9 eb __ LDA #$eb
1d1c : 85 0e __ STA P1 
1d1e : a9 9f __ LDA #$9f
1d20 : 85 11 __ STA P4 
1d22 : a9 9f __ LDA #$9f
1d24 : 85 0f __ STA P2 
1d26 : a9 ea __ LDA #$ea
1d28 : 85 10 __ STA P3 
1d2a : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1d2d : ad fd 9f LDA $9ffd ; (sstack + 3)
1d30 : 85 49 __ STA T2 + 0 
1d32 : 85 0d __ STA P0 
1d34 : a9 e9 __ LDA #$e9
1d36 : 85 0e __ STA P1 
1d38 : a9 9f __ LDA #$9f
1d3a : 85 11 __ STA P4 
1d3c : a9 9f __ LDA #$9f
1d3e : 85 0f __ STA P2 
1d40 : a9 e8 __ LDA #$e8
1d42 : 85 10 __ STA P3 
1d44 : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 293, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1d47 : a5 48 __ LDA T1 + 0 
1d49 : 0a __ __ ASL
1d4a : 0a __ __ ASL
1d4b : 0a __ __ ASL
1d4c : 85 4b __ STA T4 + 0 
1d4e : 18 __ __ CLC
1d4f : 69 00 __ ADC #$00
1d51 : 85 12 __ STA P5 
1d53 : a9 41 __ LDA #$41
1d55 : 69 00 __ ADC #$00
1d57 : 85 13 __ STA P6 
1d59 : ad e9 9f LDA $9fe9 ; (y + 0)
1d5c : 85 14 __ STA P7 
1d5e : ad e8 9f LDA $9fe8 ; (attempts + 0)
1d61 : 85 15 __ STA P8 
1d63 : a9 ef __ LDA #$ef
1d65 : 85 16 __ STA P9 
1d67 : a9 ee __ LDA #$ee
1d69 : 8d fa 9f STA $9ffa ; (sstack + 0)
1d6c : a9 9f __ LDA #$9f
1d6e : 85 17 __ STA P10 
1d70 : a9 9f __ LDA #$9f
1d72 : 8d fb 9f STA $9ffb ; (sstack + 1)
1d75 : 20 fd 21 JSR $21fd ; (find_room_exit.s0 + 0)
; 295, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1d78 : a5 49 __ LDA T2 + 0 
1d7a : 0a __ __ ASL
1d7b : 0a __ __ ASL
1d7c : 0a __ __ ASL
1d7d : 85 4c __ STA T5 + 0 
1d7f : 18 __ __ CLC
1d80 : 69 00 __ ADC #$00
1d82 : 85 12 __ STA P5 
1d84 : a9 41 __ LDA #$41
1d86 : 69 00 __ ADC #$00
1d88 : 85 13 __ STA P6 
1d8a : ad eb 9f LDA $9feb ; (screen_offset + 1)
1d8d : 85 14 __ STA P7 
1d8f : ad ea 9f LDA $9fea ; (i + 0)
1d92 : 85 15 __ STA P8 
1d94 : a9 ed __ LDA #$ed
1d96 : 85 16 __ STA P9 
1d98 : a9 ec __ LDA #$ec
1d9a : 8d fa 9f STA $9ffa ; (sstack + 0)
1d9d : a9 9f __ LDA #$9f
1d9f : 85 17 __ STA P10 
1da1 : a9 9f __ LDA #$9f
1da3 : 8d fb 9f STA $9ffb ; (sstack + 1)
1da6 : 20 fd 21 JSR $21fd ; (find_room_exit.s0 + 0)
; 298, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1da9 : a9 ff __ LDA #$ff
1dab : 8d e7 9f STA $9fe7 ; (down_x + 0)
1dae : 8d e6 9f STA $9fe6 ; (i + 0)
; 299, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1db1 : 8d e5 9f STA $9fe5 ; (x + 0)
1db4 : 8d e4 9f STA $9fe4 ; (y + 0)
; 300, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1db7 : 8d e3 9f STA $9fe3 ; (w + 0)
1dba : 8d e2 9f STA $9fe2 ; (min_dist2 + 0)
; 305, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1dbd : a9 0a __ LDA #$0a
1dbf : cd eb 9f CMP $9feb ; (screen_offset + 1)
1dc2 : 90 04 __ BCC $1dc8 ; (connect_via_existing_corridors.s1 + 0)
.s2:
1dc4 : a9 00 __ LDA #$00
1dc6 : b0 05 __ BCS $1dcd ; (connect_via_existing_corridors.s238 + 0)
.s1:
; 305, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1dc8 : ad eb 9f LDA $9feb ; (screen_offset + 1)
1dcb : e9 09 __ SBC #$09
.s238:
1dcd : 8d e1 9f STA $9fe1 ; (search_x1 + 0)
; 306, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1dd0 : a9 0a __ LDA #$0a
1dd2 : cd ea 9f CMP $9fea ; (i + 0)
1dd5 : 90 04 __ BCC $1ddb ; (connect_via_existing_corridors.s4 + 0)
.s5:
1dd7 : a9 00 __ LDA #$00
1dd9 : b0 05 __ BCS $1de0 ; (connect_via_existing_corridors.s239 + 0)
.s4:
; 306, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ddb : ad ea 9f LDA $9fea ; (i + 0)
1dde : e9 09 __ SBC #$09
.s239:
1de0 : 8d e0 9f STA $9fe0 ; (grid_positions + 15)
; 307, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1de3 : ad eb 9f LDA $9feb ; (screen_offset + 1)
1de6 : c9 36 __ CMP #$36
1de8 : 90 04 __ BCC $1dee ; (connect_via_existing_corridors.s7 + 0)
.s8:
1dea : a9 3f __ LDA #$3f
1dec : b0 02 __ BCS $1df0 ; (connect_via_existing_corridors.s240 + 0)
.s7:
; 307, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1dee : 69 0a __ ADC #$0a
.s240:
1df0 : 8d df 9f STA $9fdf ; (grid_positions + 14)
; 308, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1df3 : ad ea 9f LDA $9fea ; (i + 0)
1df6 : c9 36 __ CMP #$36
1df8 : 90 04 __ BCC $1dfe ; (connect_via_existing_corridors.s10 + 0)
.s11:
1dfa : a9 3f __ LDA #$3f
1dfc : b0 02 __ BCS $1e00 ; (connect_via_existing_corridors.s136 + 0)
.s10:
; 308, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1dfe : 69 0a __ ADC #$0a
.s136:
1e00 : 8d de 9f STA $9fde ; (grid_positions + 13)
; 310, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e03 : ae e0 9f LDX $9fe0 ; (grid_positions + 15)
1e06 : 8e dd 9f STX $9fdd ; (grid_positions + 12)
1e09 : cd e0 9f CMP $9fe0 ; (grid_positions + 15)
1e0c : b0 03 __ BCS $1e11 ; (connect_via_existing_corridors.s172 + 0)
1e0e : 4c d4 1e JMP $1ed4 ; (connect_via_existing_corridors.s16 + 0)
.s172:
; 311, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e11 : 85 4d __ STA T6 + 0 
1e13 : ad e1 9f LDA $9fe1 ; (search_x1 + 0)
1e16 : 85 4e __ STA T7 + 0 
1e18 : ad df 9f LDA $9fdf ; (grid_positions + 14)
1e1b : 85 4f __ STA T8 + 0 
1e1d : c5 4e __ CMP T7 + 0 
1e1f : a9 00 __ LDA #$00
1e21 : 2a __ __ ROL
1e22 : 85 50 __ STA T9 + 0 
.l14:
1e24 : a5 4e __ LDA T7 + 0 
1e26 : 8d dc 9f STA $9fdc ; (grid_positions + 11)
1e29 : a5 50 __ LDA T9 + 0 
1e2b : d0 03 __ BNE $1e30 ; (connect_via_existing_corridors.s171 + 0)
1e2d : 4c c7 1e JMP $1ec7 ; (connect_via_existing_corridors.s15 + 0)
.s171:
; 312, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e30 : ad dd 9f LDA $9fdd ; (grid_positions + 12)
1e33 : 85 10 __ STA P3 
.l18:
1e35 : ad dc 9f LDA $9fdc ; (grid_positions + 11)
1e38 : 85 51 __ STA T11 + 0 
1e3a : 85 0f __ STA P2 
1e3c : 20 a0 22 JSR $22a0 ; (tile_is_floor.s0 + 0)
1e3f : a5 1b __ LDA ACCU + 0 ; (room1 + 0)
1e41 : f0 74 __ BEQ $1eb7 ; (connect_via_existing_corridors.s17 + 0)
.s24:
1e43 : 20 af 1c JSR $1caf ; (is_outside_any_room.s0 + 0)
1e46 : aa __ __ TAX
1e47 : f0 6e __ BEQ $1eb7 ; (connect_via_existing_corridors.s17 + 0)
.s21:
; 314, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e49 : a5 51 __ LDA T11 + 0 
1e4b : 85 0d __ STA P0 
1e4d : ad ef 9f LDA $9fef ; (screen_pos + 1)
1e50 : 85 0e __ STA P1 
1e52 : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
1e55 : 85 49 __ STA T2 + 0 
1e57 : a5 10 __ LDA P3 
1e59 : 85 0d __ STA P0 
1e5b : ad ee 9f LDA $9fee ; (entropy4 + 1)
1e5e : 85 0e __ STA P1 
1e60 : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
1e63 : 18 __ __ CLC
1e64 : 65 49 __ ADC T2 + 0 
1e66 : 85 48 __ STA T1 + 0 
1e68 : 8d db 9f STA $9fdb ; (grid_positions + 10)
; 315, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e6b : a5 51 __ LDA T11 + 0 
1e6d : 85 0d __ STA P0 
1e6f : ad ed 9f LDA $9fed ; (extra_range_y + 0)
1e72 : 85 0e __ STA P1 
1e74 : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
1e77 : 85 43 __ STA T0 + 0 
1e79 : a5 10 __ LDA P3 
1e7b : 85 0d __ STA P0 
1e7d : ad ec 9f LDA $9fec ; (random_offset_x + 0)
1e80 : 85 0e __ STA P1 
1e82 : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
1e85 : 18 __ __ CLC
1e86 : 65 43 __ ADC T0 + 0 
1e88 : 8d da 9f STA $9fda ; (grid_positions + 9)
; 317, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e8b : a5 48 __ LDA T1 + 0 
1e8d : cd e3 9f CMP $9fe3 ; (w + 0)
1e90 : b0 0d __ BCS $1e9f ; (connect_via_existing_corridors.s27 + 0)
.s25:
; 318, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e92 : 8d e3 9f STA $9fe3 ; (w + 0)
; 319, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e95 : a5 51 __ LDA T11 + 0 
1e97 : 8d e7 9f STA $9fe7 ; (down_x + 0)
; 320, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e9a : a5 10 __ LDA P3 
1e9c : 8d e6 9f STA $9fe6 ; (i + 0)
.s27:
; 322, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e9f : ad da 9f LDA $9fda ; (grid_positions + 9)
1ea2 : cd e2 9f CMP $9fe2 ; (min_dist2 + 0)
1ea5 : b0 10 __ BCS $1eb7 ; (connect_via_existing_corridors.s17 + 0)
.s28:
; 324, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ea7 : a5 51 __ LDA T11 + 0 
1ea9 : 8d e5 9f STA $9fe5 ; (x + 0)
; 325, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1eac : a5 10 __ LDA P3 
1eae : 8d e4 9f STA $9fe4 ; (y + 0)
; 323, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1eb1 : ad da 9f LDA $9fda ; (grid_positions + 9)
1eb4 : 8d e2 9f STA $9fe2 ; (min_dist2 + 0)
.s17:
; 311, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1eb7 : a6 51 __ LDX T11 + 0 
1eb9 : e8 __ __ INX
1eba : 8e dc 9f STX $9fdc ; (grid_positions + 11)
1ebd : a5 4f __ LDA T8 + 0 
1ebf : cd dc 9f CMP $9fdc ; (grid_positions + 11)
1ec2 : 90 03 __ BCC $1ec7 ; (connect_via_existing_corridors.s15 + 0)
1ec4 : 4c 35 1e JMP $1e35 ; (connect_via_existing_corridors.l18 + 0)
.s15:
; 310, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ec7 : ee dd 9f INC $9fdd ; (grid_positions + 12)
1eca : a5 4d __ LDA T6 + 0 
1ecc : cd dd 9f CMP $9fdd ; (grid_positions + 12)
1ecf : 90 03 __ BCC $1ed4 ; (connect_via_existing_corridors.s16 + 0)
1ed1 : 4c 24 1e JMP $1e24 ; (connect_via_existing_corridors.l14 + 0)
.s16:
; 332, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ed4 : ad e7 9f LDA $9fe7 ; (down_x + 0)
1ed7 : c9 ff __ CMP #$ff
1ed9 : f0 17 __ BEQ $1ef2 ; (connect_via_existing_corridors.s33 + 0)
.s36:
1edb : 85 4d __ STA T6 + 0 
1edd : ad e5 9f LDA $9fe5 ; (x + 0)
1ee0 : c9 ff __ CMP #$ff
1ee2 : f0 0e __ BEQ $1ef2 ; (connect_via_existing_corridors.s33 + 0)
.s35:
1ee4 : 85 4e __ STA T7 + 0 
1ee6 : a9 08 __ LDA #$08
1ee8 : cd e3 9f CMP $9fe3 ; (w + 0)
1eeb : 90 05 __ BCC $1ef2 ; (connect_via_existing_corridors.s33 + 0)
.s34:
1eed : cd e2 9f CMP $9fe2 ; (min_dist2 + 0)
1ef0 : b0 05 __ BCS $1ef7 ; (connect_via_existing_corridors.s31 + 0)
.s33:
; 437, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ef2 : a9 00 __ LDA #$00
1ef4 : 4c dc 21 JMP $21dc ; (connect_via_existing_corridors.s1001 + 0)
.s31:
; 339, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ef7 : a9 00 __ LDA #$00
1ef9 : 8d c5 9f STA $9fc5 ; (path1 + 40)
; 340, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1efc : 8d 9c 9f STA $9f9c ; (dx1 + 0)
1eff : 8d 9b 9f STA $9f9b ; (dy1 + 0)
; 341, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f02 : a4 4b __ LDY T4 + 0 
1f04 : b9 00 41 LDA $4100,y ; (rooms + 0)
1f07 : e9 01 __ SBC #$01
1f09 : 90 11 __ BCC $1f1c ; (connect_via_existing_corridors.s38 + 0)
.s1029:
1f0b : cd ef 9f CMP $9fef ; (screen_pos + 1)
1f0e : d0 0c __ BNE $1f1c ; (connect_via_existing_corridors.s38 + 0)
.s37:
1f10 : a9 ff __ LDA #$ff
.s286:
; 342, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f12 : 8d 9c 9f STA $9f9c ; (dx1 + 0)
1f15 : a9 00 __ LDA #$00
1f17 : 8d 9b 9f STA $9f9b ; (dy1 + 0)
1f1a : f0 3d __ BEQ $1f59 ; (connect_via_existing_corridors.s39 + 0)
.s38:
; 342, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f1c : b9 02 41 LDA $4102,y ; (rooms + 2)
1f1f : 18 __ __ CLC
1f20 : 79 00 41 ADC $4100,y ; (rooms + 0)
1f23 : b0 09 __ BCS $1f2e ; (connect_via_existing_corridors.s41 + 0)
.s1026:
1f25 : cd ef 9f CMP $9fef ; (screen_pos + 1)
1f28 : d0 04 __ BNE $1f2e ; (connect_via_existing_corridors.s41 + 0)
.s40:
1f2a : a9 01 __ LDA #$01
1f2c : d0 e4 __ BNE $1f12 ; (connect_via_existing_corridors.s286 + 0)
.s41:
; 343, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f2e : b9 01 41 LDA $4101,y ; (rooms + 1)
1f31 : 38 __ __ SEC
1f32 : e9 01 __ SBC #$01
1f34 : 90 11 __ BCC $1f47 ; (connect_via_existing_corridors.s44 + 0)
.s1023:
1f36 : cd ee 9f CMP $9fee ; (entropy4 + 1)
1f39 : d0 0c __ BNE $1f47 ; (connect_via_existing_corridors.s44 + 0)
.s43:
1f3b : a9 ff __ LDA #$ff
.s341:
; 344, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f3d : 8d 9b 9f STA $9f9b ; (dy1 + 0)
1f40 : a9 00 __ LDA #$00
1f42 : 8d 9c 9f STA $9f9c ; (dx1 + 0)
1f45 : f0 12 __ BEQ $1f59 ; (connect_via_existing_corridors.s39 + 0)
.s44:
; 344, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f47 : b9 03 41 LDA $4103,y ; (rooms + 3)
1f4a : 18 __ __ CLC
1f4b : 79 01 41 ADC $4101,y ; (rooms + 1)
1f4e : b0 09 __ BCS $1f59 ; (connect_via_existing_corridors.s39 + 0)
.s1020:
1f50 : cd ee 9f CMP $9fee ; (entropy4 + 1)
1f53 : d0 04 __ BNE $1f59 ; (connect_via_existing_corridors.s39 + 0)
.s46:
1f55 : a9 01 __ LDA #$01
1f57 : d0 e4 __ BNE $1f3d ; (connect_via_existing_corridors.s341 + 0)
.s39:
; 345, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f59 : ad 9c 9f LDA $9f9c ; (dx1 + 0)
1f5c : 18 __ __ CLC
1f5d : 6d ef 9f ADC $9fef ; (screen_pos + 1)
1f60 : 85 49 __ STA T2 + 0 
1f62 : 85 0d __ STA P0 
1f64 : 8d 9a 9f STA $9f9a ; (corridor1_x + 0)
; 347, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f67 : a9 01 __ LDA #$01
1f69 : 8d 2a 33 STA $332a ; (corridor_endpoint_override + 0)
; 346, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f6c : ad 9b 9f LDA $9f9b ; (dy1 + 0)
1f6f : 18 __ __ CLC
1f70 : 6d ee 9f ADC $9fee ; (entropy4 + 1)
1f73 : 85 48 __ STA T1 + 0 
1f75 : 85 0e __ STA P1 
1f77 : 8d 99 9f STA $9f99 ; (corridor1_y + 0)
; 348, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f7a : 20 dd 14 JSR $14dd ; (coords_in_bounds.s0 + 0)
1f7d : aa __ __ TAX
1f7e : f0 2d __ BEQ $1fad ; (connect_via_existing_corridors.s51 + 0)
.s52:
1f80 : a5 0d __ LDA P0 
1f82 : 85 13 __ STA P6 
1f84 : a5 0e __ LDA P1 
1f86 : 85 14 __ STA P7 
1f88 : 20 c2 22 JSR $22c2 ; (can_place_corridor_tile.s0 + 0)
1f8b : aa __ __ TAX
1f8c : f0 1f __ BEQ $1fad ; (connect_via_existing_corridors.s51 + 0)
.s49:
; 349, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f8e : a5 49 __ LDA T2 + 0 
1f90 : 85 10 __ STA P3 
1f92 : a5 48 __ LDA T1 + 0 
1f94 : 85 11 __ STA P4 
1f96 : a9 02 __ LDA #$02
1f98 : 85 12 __ STA P5 
1f9a : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
; 350, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f9d : a5 10 __ LDA P3 
1f9f : 8d 9d 9f STA $9f9d ; (path1 + 0)
; 351, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fa2 : a5 11 __ LDA P4 
1fa4 : ae c5 9f LDX $9fc5 ; (path1 + 40)
1fa7 : 9d b1 9f STA $9fb1,x ; (path1 + 20)
; 352, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1faa : ee c5 9f INC $9fc5 ; (path1 + 40)
.s51:
; 355, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fad : a5 49 __ LDA T2 + 0 
1faf : 8d 98 9f STA $9f98 ; (current1_x + 0)
; 356, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fb2 : a5 48 __ LDA T1 + 0 
1fb4 : 8d 97 9f STA $9f97 ; (current1_y + 0)
; 357, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fb7 : a9 40 __ LDA #$40
1fb9 : 8d 96 9f STA $9f96 ; (step_limit1 + 0)
; 354, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fbc : a9 00 __ LDA #$00
1fbe : 8d 2a 33 STA $332a ; (corridor_endpoint_override + 0)
.l53:
; 358, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fc1 : ac 98 9f LDY $9f98 ; (current1_x + 0)
1fc4 : c4 4d __ CPY T6 + 0 
1fc6 : f0 04 __ BEQ $1fcc ; (connect_via_existing_corridors.s1003 + 0)
.s1002:
1fc8 : a2 01 __ LDX #$01
1fca : d0 0a __ BNE $1fd6 ; (connect_via_existing_corridors.s56 + 0)
.s1003:
1fcc : ad 97 9f LDA $9f97 ; (current1_y + 0)
1fcf : a2 00 __ LDX #$00
1fd1 : cd e6 9f CMP $9fe6 ; (i + 0)
1fd4 : f0 6b __ BEQ $2041 ; (connect_via_existing_corridors.s55 + 0)
.s56:
1fd6 : ad 96 9f LDA $9f96 ; (step_limit1 + 0)
1fd9 : ce 96 9f DEC $9f96 ; (step_limit1 + 0)
1fdc : 09 00 __ ORA #$00
1fde : f0 61 __ BEQ $2041 ; (connect_via_existing_corridors.s55 + 0)
.s54:
; 360, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fe0 : 8a __ __ TXA
1fe1 : f0 03 __ BEQ $1fe6 ; (connect_via_existing_corridors.s59 + 0)
1fe3 : 4c ee 21 JMP $21ee ; (connect_via_existing_corridors.s58 + 0)
.s59:
; 363, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fe6 : ac 97 9f LDY $9f97 ; (current1_y + 0)
1fe9 : cc e6 9f CPY $9fe6 ; (i + 0)
1fec : f0 53 __ BEQ $2041 ; (connect_via_existing_corridors.s55 + 0)
.s64:
; 364, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fee : b0 03 __ BCS $1ff3 ; (connect_via_existing_corridors.s68 + 0)
.s67:
1ff0 : c8 __ __ INY
1ff1 : 90 01 __ BCC $1ff4 ; (connect_via_existing_corridors.s288 + 0)
.s68:
; 365, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ff3 : 88 __ __ DEY
.s288:
1ff4 : 8c 97 9f STY $9f97 ; (current1_y + 0)
; 369, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ff7 : ad 98 9f LDA $9f98 ; (current1_x + 0)
.s60:
1ffa : 85 49 __ STA T2 + 0 
1ffc : 85 0f __ STA P2 
1ffe : ad 97 9f LDA $9f97 ; (current1_y + 0)
2001 : 85 4a __ STA T3 + 0 
2003 : 85 10 __ STA P3 
2005 : 20 af 1c JSR $1caf ; (is_outside_any_room.s0 + 0)
2008 : aa __ __ TAX
2009 : f0 b6 __ BEQ $1fc1 ; (connect_via_existing_corridors.l53 + 0)
.s74:
200b : a5 0f __ LDA P2 
200d : 85 13 __ STA P6 
200f : a5 4a __ LDA T3 + 0 
2011 : 85 14 __ STA P7 
2013 : 20 c2 22 JSR $22c2 ; (can_place_corridor_tile.s0 + 0)
2016 : aa __ __ TAX
2017 : f0 a8 __ BEQ $1fc1 ; (connect_via_existing_corridors.l53 + 0)
.s71:
; 370, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2019 : a5 49 __ LDA T2 + 0 
201b : 85 10 __ STA P3 
201d : a5 4a __ LDA T3 + 0 
201f : 85 11 __ STA P4 
2021 : a9 02 __ LDA #$02
2023 : 85 12 __ STA P5 
2025 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
; 371, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2028 : ae c5 9f LDX $9fc5 ; (path1 + 40)
202b : e0 14 __ CPX #$14
202d : b0 92 __ BCS $1fc1 ; (connect_via_existing_corridors.l53 + 0)
.s75:
; 372, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
202f : a5 10 __ LDA P3 
2031 : 9d 9d 9f STA $9f9d,x ; (path1 + 0)
; 373, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2034 : a5 4a __ LDA T3 + 0 
2036 : ae c5 9f LDX $9fc5 ; (path1 + 40)
2039 : 9d b1 9f STA $9fb1,x ; (path1 + 20)
; 374, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
203c : ee c5 9f INC $9fc5 ; (path1 + 40)
203f : 90 80 __ BCC $1fc1 ; (connect_via_existing_corridors.l53 + 0)
.s55:
; 379, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2041 : ad c5 9f LDA $9fc5 ; (path1 + 40)
2044 : f0 22 __ BEQ $2068 ; (connect_via_existing_corridors.s83 + 0)
.s78:
; 380, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2046 : 85 48 __ STA T1 + 0 
2048 : ad 9d 9f LDA $9f9d ; (path1 + 0)
204b : 85 13 __ STA P6 
204d : ad b1 9f LDA $9fb1 ; (path1 + 20)
2050 : 85 14 __ STA P7 
2052 : 20 6e 24 JSR $246e ; (place_door.s0 + 0)
; 382, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2055 : a4 48 __ LDY T1 + 0 
2057 : c0 02 __ CPY #$02
2059 : 90 0d __ BCC $2068 ; (connect_via_existing_corridors.s83 + 0)
.s81:
; 383, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
205b : b9 9c 9f LDA $9f9c,y ; (dx1 + 0)
205e : 85 13 __ STA P6 
2060 : b9 b0 9f LDA $9fb0,y ; (path1 + 19)
2063 : 85 14 __ STA P7 
2065 : 20 6e 24 JSR $246e ; (place_door.s0 + 0)
.s83:
; 388, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2068 : a9 00 __ LDA #$00
206a : 8d 81 9f STA $9f81 ; (path2 + 40)
; 389, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
206d : 8d 58 9f STA $9f58 ; (dx2 + 0)
2070 : 8d 57 9f STA $9f57 ; (dy2 + 0)
; 390, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2073 : a4 4c __ LDY T5 + 0 
2075 : b9 00 41 LDA $4100,y ; (rooms + 0)
2078 : 38 __ __ SEC
2079 : e9 01 __ SBC #$01
207b : 90 11 __ BCC $208e ; (connect_via_existing_corridors.s85 + 0)
.s1017:
207d : cd ed 9f CMP $9fed ; (extra_range_y + 0)
2080 : d0 0c __ BNE $208e ; (connect_via_existing_corridors.s85 + 0)
.s84:
2082 : a9 ff __ LDA #$ff
.s289:
; 391, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2084 : 8d 58 9f STA $9f58 ; (dx2 + 0)
2087 : a9 00 __ LDA #$00
2089 : 8d 57 9f STA $9f57 ; (dy2 + 0)
208c : f0 3d __ BEQ $20cb ; (connect_via_existing_corridors.s86 + 0)
.s85:
; 391, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
208e : b9 02 41 LDA $4102,y ; (rooms + 2)
2091 : 18 __ __ CLC
2092 : 79 00 41 ADC $4100,y ; (rooms + 0)
2095 : b0 09 __ BCS $20a0 ; (connect_via_existing_corridors.s88 + 0)
.s1014:
2097 : cd ed 9f CMP $9fed ; (extra_range_y + 0)
209a : d0 04 __ BNE $20a0 ; (connect_via_existing_corridors.s88 + 0)
.s87:
209c : a9 01 __ LDA #$01
209e : d0 e4 __ BNE $2084 ; (connect_via_existing_corridors.s289 + 0)
.s88:
; 392, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20a0 : b9 01 41 LDA $4101,y ; (rooms + 1)
20a3 : 38 __ __ SEC
20a4 : e9 01 __ SBC #$01
20a6 : 90 11 __ BCC $20b9 ; (connect_via_existing_corridors.s91 + 0)
.s1011:
20a8 : cd ec 9f CMP $9fec ; (random_offset_x + 0)
20ab : d0 0c __ BNE $20b9 ; (connect_via_existing_corridors.s91 + 0)
.s90:
20ad : a9 ff __ LDA #$ff
.s342:
; 393, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20af : 8d 57 9f STA $9f57 ; (dy2 + 0)
20b2 : a9 00 __ LDA #$00
20b4 : 8d 58 9f STA $9f58 ; (dx2 + 0)
20b7 : f0 12 __ BEQ $20cb ; (connect_via_existing_corridors.s86 + 0)
.s91:
; 393, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20b9 : b9 03 41 LDA $4103,y ; (rooms + 3)
20bc : 18 __ __ CLC
20bd : 79 01 41 ADC $4101,y ; (rooms + 1)
20c0 : b0 09 __ BCS $20cb ; (connect_via_existing_corridors.s86 + 0)
.s1008:
20c2 : cd ec 9f CMP $9fec ; (random_offset_x + 0)
20c5 : d0 04 __ BNE $20cb ; (connect_via_existing_corridors.s86 + 0)
.s93:
20c7 : a9 01 __ LDA #$01
20c9 : d0 e4 __ BNE $20af ; (connect_via_existing_corridors.s342 + 0)
.s86:
; 394, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20cb : ad 58 9f LDA $9f58 ; (dx2 + 0)
20ce : 18 __ __ CLC
20cf : 6d ed 9f ADC $9fed ; (extra_range_y + 0)
20d2 : 85 49 __ STA T2 + 0 
20d4 : 85 0d __ STA P0 
20d6 : 8d 56 9f STA $9f56 ; (corridor2_x + 0)
; 396, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20d9 : a9 01 __ LDA #$01
20db : 8d 2a 33 STA $332a ; (corridor_endpoint_override + 0)
; 395, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20de : ad 57 9f LDA $9f57 ; (dy2 + 0)
20e1 : 18 __ __ CLC
20e2 : 6d ec 9f ADC $9fec ; (random_offset_x + 0)
20e5 : 85 48 __ STA T1 + 0 
20e7 : 85 0e __ STA P1 
20e9 : 8d 55 9f STA $9f55 ; (corridor2_y + 0)
; 397, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20ec : 20 dd 14 JSR $14dd ; (coords_in_bounds.s0 + 0)
20ef : aa __ __ TAX
20f0 : f0 2d __ BEQ $211f ; (connect_via_existing_corridors.s98 + 0)
.s99:
20f2 : a5 0d __ LDA P0 
20f4 : 85 13 __ STA P6 
20f6 : a5 0e __ LDA P1 
20f8 : 85 14 __ STA P7 
20fa : 20 c2 22 JSR $22c2 ; (can_place_corridor_tile.s0 + 0)
20fd : aa __ __ TAX
20fe : f0 1f __ BEQ $211f ; (connect_via_existing_corridors.s98 + 0)
.s96:
; 398, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2100 : a5 49 __ LDA T2 + 0 
2102 : 85 10 __ STA P3 
2104 : a5 48 __ LDA T1 + 0 
2106 : 85 11 __ STA P4 
2108 : a9 02 __ LDA #$02
210a : 85 12 __ STA P5 
210c : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
; 399, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
210f : a5 10 __ LDA P3 
2111 : 8d 59 9f STA $9f59 ; (path2 + 0)
; 400, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2114 : a5 11 __ LDA P4 
2116 : ae 81 9f LDX $9f81 ; (path2 + 40)
2119 : 9d 6d 9f STA $9f6d,x ; (path2 + 20)
; 401, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
211c : ee 81 9f INC $9f81 ; (path2 + 40)
.s98:
; 404, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
211f : a5 49 __ LDA T2 + 0 
2121 : 8d 54 9f STA $9f54 ; (current2_x + 0)
; 405, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2124 : a5 48 __ LDA T1 + 0 
2126 : 8d 53 9f STA $9f53 ; (current2_y + 0)
; 406, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2129 : a9 40 __ LDA #$40
212b : 8d 52 9f STA $9f52 ; (step_limit2 + 0)
; 403, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
212e : a9 00 __ LDA #$00
2130 : 8d 2a 33 STA $332a ; (corridor_endpoint_override + 0)
.l100:
; 407, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2133 : ac 54 9f LDY $9f54 ; (current2_x + 0)
2136 : c4 4e __ CPY T7 + 0 
2138 : f0 04 __ BEQ $213e ; (connect_via_existing_corridors.s1006 + 0)
.s1005:
213a : a2 01 __ LDX #$01
213c : d0 0a __ BNE $2148 ; (connect_via_existing_corridors.s103 + 0)
.s1006:
213e : ad 53 9f LDA $9f53 ; (current2_y + 0)
2141 : a2 00 __ LDX #$00
2143 : cd e4 9f CMP $9fe4 ; (y + 0)
2146 : f0 6b __ BEQ $21b3 ; (connect_via_existing_corridors.s102 + 0)
.s103:
2148 : ad 52 9f LDA $9f52 ; (step_limit2 + 0)
214b : ce 52 9f DEC $9f52 ; (step_limit2 + 0)
214e : 09 00 __ ORA #$00
2150 : f0 61 __ BEQ $21b3 ; (connect_via_existing_corridors.s102 + 0)
.s101:
; 409, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2152 : 8a __ __ TXA
2153 : f0 03 __ BEQ $2158 ; (connect_via_existing_corridors.s106 + 0)
2155 : 4c df 21 JMP $21df ; (connect_via_existing_corridors.s105 + 0)
.s106:
; 412, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2158 : ac 53 9f LDY $9f53 ; (current2_y + 0)
215b : cc e4 9f CPY $9fe4 ; (y + 0)
215e : f0 53 __ BEQ $21b3 ; (connect_via_existing_corridors.s102 + 0)
.s111:
; 413, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2160 : b0 03 __ BCS $2165 ; (connect_via_existing_corridors.s115 + 0)
.s114:
2162 : c8 __ __ INY
2163 : 90 01 __ BCC $2166 ; (connect_via_existing_corridors.s291 + 0)
.s115:
; 414, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2165 : 88 __ __ DEY
.s291:
2166 : 8c 53 9f STY $9f53 ; (current2_y + 0)
; 418, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2169 : ad 54 9f LDA $9f54 ; (current2_x + 0)
.s107:
216c : 85 49 __ STA T2 + 0 
216e : 85 0f __ STA P2 
2170 : ad 53 9f LDA $9f53 ; (current2_y + 0)
2173 : 85 4a __ STA T3 + 0 
2175 : 85 10 __ STA P3 
2177 : 20 af 1c JSR $1caf ; (is_outside_any_room.s0 + 0)
217a : aa __ __ TAX
217b : f0 b6 __ BEQ $2133 ; (connect_via_existing_corridors.l100 + 0)
.s121:
217d : a5 0f __ LDA P2 
217f : 85 13 __ STA P6 
2181 : a5 4a __ LDA T3 + 0 
2183 : 85 14 __ STA P7 
2185 : 20 c2 22 JSR $22c2 ; (can_place_corridor_tile.s0 + 0)
2188 : aa __ __ TAX
2189 : f0 a8 __ BEQ $2133 ; (connect_via_existing_corridors.l100 + 0)
.s118:
; 419, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
218b : a5 49 __ LDA T2 + 0 
218d : 85 10 __ STA P3 
218f : a5 4a __ LDA T3 + 0 
2191 : 85 11 __ STA P4 
2193 : a9 02 __ LDA #$02
2195 : 85 12 __ STA P5 
2197 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
; 420, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
219a : ae 81 9f LDX $9f81 ; (path2 + 40)
219d : e0 14 __ CPX #$14
219f : b0 92 __ BCS $2133 ; (connect_via_existing_corridors.l100 + 0)
.s122:
; 421, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21a1 : a5 10 __ LDA P3 
21a3 : 9d 59 9f STA $9f59,x ; (path2 + 0)
; 422, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21a6 : a5 4a __ LDA T3 + 0 
21a8 : ae 81 9f LDX $9f81 ; (path2 + 40)
21ab : 9d 6d 9f STA $9f6d,x ; (path2 + 20)
; 423, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21ae : ee 81 9f INC $9f81 ; (path2 + 40)
21b1 : 90 80 __ BCC $2133 ; (connect_via_existing_corridors.l100 + 0)
.s102:
; 428, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21b3 : ad 81 9f LDA $9f81 ; (path2 + 40)
21b6 : f0 22 __ BEQ $21da ; (connect_via_existing_corridors.s1035 + 0)
.s125:
; 429, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21b8 : 85 48 __ STA T1 + 0 
21ba : ad 59 9f LDA $9f59 ; (path2 + 0)
21bd : 85 13 __ STA P6 
21bf : ad 6d 9f LDA $9f6d ; (path2 + 20)
21c2 : 85 14 __ STA P7 
21c4 : 20 6e 24 JSR $246e ; (place_door.s0 + 0)
; 431, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21c7 : a4 48 __ LDY T1 + 0 
21c9 : c0 02 __ CPY #$02
21cb : 90 0d __ BCC $21da ; (connect_via_existing_corridors.s1035 + 0)
.s128:
; 432, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21cd : b9 58 9f LDA $9f58,y ; (dx2 + 0)
21d0 : 85 13 __ STA P6 
21d2 : b9 6c 9f LDA $9f6c,y ; (path2 + 19)
21d5 : 85 14 __ STA P7 
21d7 : 20 6e 24 JSR $246e ; (place_door.s0 + 0)
.s1035:
; 434, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21da : a9 01 __ LDA #$01
.s1001:
; 437, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21dc : 85 1b __ STA ACCU + 0 ; (room1 + 0)
21de : 60 __ __ RTS
.s105:
; 410, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21df : c4 4e __ CPY T7 + 0 
21e1 : b0 03 __ BCS $21e6 ; (connect_via_existing_corridors.s109 + 0)
.s108:
21e3 : c8 __ __ INY
21e4 : 90 01 __ BCC $21e7 ; (connect_via_existing_corridors.s290 + 0)
.s109:
; 411, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21e6 : 88 __ __ DEY
.s290:
21e7 : 8c 54 9f STY $9f54 ; (current2_x + 0)
21ea : 98 __ __ TYA
21eb : 4c 6c 21 JMP $216c ; (connect_via_existing_corridors.s107 + 0)
.s58:
; 361, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21ee : c4 4d __ CPY T6 + 0 
21f0 : b0 03 __ BCS $21f5 ; (connect_via_existing_corridors.s62 + 0)
.s61:
21f2 : c8 __ __ INY
21f3 : 90 01 __ BCC $21f6 ; (connect_via_existing_corridors.s287 + 0)
.s62:
; 362, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21f5 : 88 __ __ DEY
.s287:
21f6 : 8c 98 9f STY $9f98 ; (current1_x + 0)
21f9 : 98 __ __ TYA
21fa : 4c fa 1f JMP $1ffa ; (connect_via_existing_corridors.s60 + 0)
--------------------------------------------------------------------
find_room_exit: ; find_room_exit(struct S#1442*,u8,u8,u8*,u8*)->void
.s0:
; 168, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
21fd : 38 __ __ SEC
21fe : a5 12 __ LDA P5 ; (room + 0)
2200 : e9 00 __ SBC #$00
2202 : 85 43 __ STA T0 + 0 
2204 : a5 13 __ LDA P6 ; (room + 1)
2206 : e9 41 __ SBC #$41
2208 : 4a __ __ LSR
2209 : 66 43 __ ROR T0 + 0 
220b : 4a __ __ LSR
220c : 66 43 __ ROR T0 + 0 
220e : 4a __ __ LSR
220f : a5 43 __ LDA T0 + 0 
2211 : 6a __ __ ROR
2212 : 85 0d __ STA P0 
2214 : 8d f7 9f STA $9ff7 ; (d + 1)
; 169, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2217 : a9 f9 __ LDA #$f9
2219 : 85 0e __ STA P1 
221b : a9 9f __ LDA #$9f
221d : 85 11 __ STA P4 
221f : a9 9f __ LDA #$9f
2221 : 85 0f __ STA P2 
2223 : a9 f8 __ LDA #$f8
2225 : 85 10 __ STA P3 
2227 : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 170, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
222a : a5 14 __ LDA P7 ; (target_x + 0)
222c : 85 0d __ STA P0 
222e : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
2231 : 85 45 __ STA T5 + 0 
2233 : 85 0e __ STA P1 
2235 : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
2238 : 85 46 __ STA T6 + 0 
223a : 8d f6 9f STA $9ff6 ; (d + 0)
; 171, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
223d : a5 15 __ LDA P8 ; (target_y + 0)
223f : 85 0d __ STA P0 
2241 : ad f8 9f LDA $9ff8 ; (room + 1)
2244 : 85 47 __ STA T8 + 0 
2246 : 85 0e __ STA P1 
2248 : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
224b : 8d f5 9f STA $9ff5 ; (s + 1)
; 173, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
224e : ae fa 9f LDX $9ffa ; (sstack + 0)
2251 : 86 1b __ STX ACCU + 0 
2253 : ae fb 9f LDX $9ffb ; (sstack + 1)
2256 : 86 1c __ STX ACCU + 1 
2258 : c5 46 __ CMP T6 + 0 
225a : 90 22 __ BCC $227e ; (find_room_exit.s1 + 0)
.s2:
; 186, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
225c : a0 01 __ LDY #$01
225e : b1 12 __ LDA (P5),y ; (room + 0)
2260 : 85 1d __ STA ACCU + 2 
2262 : a5 47 __ LDA T8 + 0 
2264 : c5 15 __ CMP P8 ; (target_y + 0)
2266 : 90 06 __ BCC $226e ; (find_room_exit.s7 + 0)
.s8:
; 192, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2268 : c6 1d __ DEC ACCU + 2 
226a : a5 1d __ LDA ACCU + 2 
226c : b0 06 __ BCS $2274 ; (find_room_exit.s1003 + 0)
.s7:
; 188, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
226e : a0 03 __ LDY #$03
2270 : b1 12 __ LDA (P5),y ; (room + 0)
2272 : 65 1d __ ADC ACCU + 2 
.s1003:
; 192, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2274 : a0 00 __ LDY #$00
2276 : 91 1b __ STA (ACCU + 0),y 
; 193, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2278 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
227b : 91 16 __ STA (P9),y ; (exit_x + 0)
.s1001:
; 196, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
227d : 60 __ __ RTS
.s1:
; 175, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
227e : a0 00 __ LDY #$00
2280 : b1 12 __ LDA (P5),y ; (room + 0)
2282 : 85 1d __ STA ACCU + 2 
2284 : a5 45 __ LDA T5 + 0 
2286 : c5 14 __ CMP P7 ; (target_x + 0)
2288 : b0 0a __ BCS $2294 ; (find_room_exit.s5 + 0)
.s4:
; 181, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
228a : a0 02 __ LDY #$02
228c : b1 12 __ LDA (P5),y ; (room + 0)
228e : 65 1d __ ADC ACCU + 2 
2290 : a0 00 __ LDY #$00
2292 : f0 04 __ BEQ $2298 ; (find_room_exit.s1002 + 0)
.s5:
; 181, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2294 : c6 1d __ DEC ACCU + 2 
2296 : a5 1d __ LDA ACCU + 2 
.s1002:
2298 : 91 16 __ STA (P9),y ; (exit_x + 0)
; 182, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
229a : ad f8 9f LDA $9ff8 ; (room + 1)
229d : 91 1b __ STA (ACCU + 0),y 
229f : 60 __ __ RTS
--------------------------------------------------------------------
tile_is_floor: ; tile_is_floor(u8,u8)->u8
.s0:
; 269, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
22a0 : a5 0f __ LDA P2 ; (x + 0)
22a2 : c9 40 __ CMP #$40
22a4 : b0 17 __ BCS $22bd ; (tile_is_floor.s1005 + 0)
.s4:
22a6 : a5 10 __ LDA P3 ; (y + 0)
22a8 : c9 40 __ CMP #$40
22aa : b0 11 __ BCS $22bd ; (tile_is_floor.s1005 + 0)
.s3:
; 270, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
22ac : 85 0e __ STA P1 
22ae : a5 0f __ LDA P2 ; (x + 0)
22b0 : 85 0d __ STA P0 
22b2 : 20 14 15 JSR $1514 ; (get_tile_core.s0 + 0)
22b5 : c9 02 __ CMP #$02
22b7 : d0 04 __ BNE $22bd ; (tile_is_floor.s1005 + 0)
.s1002:
22b9 : a9 01 __ LDA #$01
22bb : d0 02 __ BNE $22bf ; (tile_is_floor.s1001 + 0)
.s1005:
22bd : a9 00 __ LDA #$00
.s1001:
22bf : 85 1b __ STA ACCU + 0 
22c1 : 60 __ __ RTS
--------------------------------------------------------------------
can_place_corridor_tile: ; can_place_corridor_tile(u8,u8)->u8
.s0:
; 109, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
22c2 : a5 13 __ LDA P6 ; (x + 0)
22c4 : 85 0d __ STA P0 
22c6 : a5 14 __ LDA P7 ; (y + 0)
22c8 : 85 0e __ STA P1 
22ca : ad 2a 33 LDA $332a ; (corridor_endpoint_override + 0)
22cd : f0 03 __ BEQ $22d2 ; (can_place_corridor_tile.s3 + 0)
22cf : 4c 57 23 JMP $2357 ; (can_place_corridor_tile.s1 + 0)
.s3:
; 116, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
22d2 : 20 58 1c JSR $1c58 ; (coords_in_bounds_fast.s0 + 0)
22d5 : aa __ __ TAX
22d6 : f0 7e __ BEQ $2356 ; (can_place_corridor_tile.s1001 + 0)
.s19:
; 118, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
22d8 : a5 13 __ LDA P6 ; (x + 0)
22da : 85 0f __ STA P2 
22dc : a5 14 __ LDA P7 ; (y + 0)
22de : 85 10 __ STA P3 
22e0 : 20 af 1c JSR $1caf ; (is_outside_any_room.s0 + 0)
22e3 : aa __ __ TAX
22e4 : f0 70 __ BEQ $2356 ; (can_place_corridor_tile.s1001 + 0)
.s23:
; 122, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
22e6 : e6 0f __ INC P2 
22e8 : 20 af 1c JSR $1caf ; (is_outside_any_room.s0 + 0)
22eb : aa __ __ TAX
22ec : f0 68 __ BEQ $2356 ; (can_place_corridor_tile.s1001 + 0)
.s30:
; 123, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
22ee : a6 13 __ LDX P6 ; (x + 0)
22f0 : ca __ __ DEX
22f1 : 86 0f __ STX P2 
22f3 : 20 af 1c JSR $1caf ; (is_outside_any_room.s0 + 0)
22f6 : aa __ __ TAX
22f7 : f0 5d __ BEQ $2356 ; (can_place_corridor_tile.s1001 + 0)
.s29:
; 124, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
22f9 : e6 0f __ INC P2 
22fb : e6 10 __ INC P3 
22fd : 20 af 1c JSR $1caf ; (is_outside_any_room.s0 + 0)
2300 : aa __ __ TAX
2301 : f0 53 __ BEQ $2356 ; (can_place_corridor_tile.s1001 + 0)
.s28:
; 125, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2303 : a6 14 __ LDX P7 ; (y + 0)
2305 : ca __ __ DEX
2306 : 86 10 __ STX P3 
2308 : 20 af 1c JSR $1caf ; (is_outside_any_room.s0 + 0)
230b : aa __ __ TAX
230c : f0 48 __ BEQ $2356 ; (can_place_corridor_tile.s1001 + 0)
.s27:
; 130, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
230e : a9 00 __ LDA #$00
2310 : 8d f6 9f STA $9ff6 ; (d + 0)
2313 : ad 1c 32 LDA $321c ; (room_count + 0)
2316 : f0 3c __ BEQ $2354 ; (can_place_corridor_tile.s14 + 0)
.l33:
; 132, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2318 : ad f6 9f LDA $9ff6 ; (d + 0)
231b : 85 45 __ STA T6 + 0 
231d : 85 0d __ STA P0 
231f : a9 f5 __ LDA #$f5
2321 : 85 0e __ STA P1 
2323 : a9 9f __ LDA #$9f
2325 : 85 0f __ STA P2 
2327 : a9 f4 __ LDA #$f4
2329 : 85 10 __ STA P3 
232b : a9 9f __ LDA #$9f
232d : 85 11 __ STA P4 
232f : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 133, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2332 : a5 13 __ LDA P6 ; (x + 0)
2334 : 85 0f __ STA P2 
2336 : a5 14 __ LDA P7 ; (y + 0)
2338 : 85 10 __ STA P3 
233a : ad f5 9f LDA $9ff5 ; (s + 1)
233d : 85 11 __ STA P4 
233f : ad f4 9f LDA $9ff4 ; (entropy1 + 1)
2342 : 85 12 __ STA P5 
2344 : 20 52 24 JSR $2452 ; (manhattan_distance_fast.s0 + 0)
; 130, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2347 : 18 __ __ CLC
2348 : a5 45 __ LDA T6 + 0 
234a : 69 01 __ ADC #$01
234c : 8d f6 9f STA $9ff6 ; (d + 0)
234f : cd 1c 32 CMP $321c ; (room_count + 0)
2352 : 90 c4 __ BCC $2318 ; (can_place_corridor_tile.l33 + 0)
.s14:
; 114, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2354 : a9 01 __ LDA #$01
.s1001:
; 111, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2356 : 60 __ __ RTS
.s1:
2357 : 20 58 1c JSR $1c58 ; (coords_in_bounds_fast.s0 + 0)
235a : aa __ __ TAX
235b : f0 f9 __ BEQ $2356 ; (can_place_corridor_tile.s1001 + 0)
.s6:
; 112, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
235d : a5 13 __ LDA P6 ; (x + 0)
235f : 85 0f __ STA P2 
2361 : a5 14 __ LDA P7 ; (y + 0)
2363 : 85 10 __ STA P3 
2365 : 20 af 1c JSR $1caf ; (is_outside_any_room.s0 + 0)
2368 : aa __ __ TAX
2369 : f0 eb __ BEQ $2356 ; (can_place_corridor_tile.s1001 + 0)
.s10:
; 113, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
236b : a5 13 __ LDA P6 ; (x + 0)
236d : 85 0d __ STA P0 
236f : a5 14 __ LDA P7 ; (y + 0)
2371 : 85 0e __ STA P1 
2373 : 20 7a 23 JSR $237a ; (is_on_room_edge.s0 + 0)
2376 : aa __ __ TAX
2377 : d0 db __ BNE $2354 ; (can_place_corridor_tile.s14 + 0)
2379 : 60 __ __ RTS
--------------------------------------------------------------------
is_on_room_edge: ; is_on_room_edge(u8,u8)->u8
.s0:
;  25, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
237a : a9 00 __ LDA #$00
237c : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
237f : ad 1c 32 LDA $321c ; (room_count + 0)
2382 : 85 43 __ STA T5 + 0 
2384 : d0 03 __ BNE $2389 ; (is_on_room_edge.l2 + 0)
2386 : 4c 4c 24 JMP $244c ; (is_on_room_edge.s4 + 0)
.l2:
;  26, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
2389 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
238c : 0a __ __ ASL
238d : 0a __ __ ASL
238e : 0a __ __ ASL
238f : aa __ __ TAX
2390 : 69 00 __ ADC #$00
2392 : 85 1b __ STA ACCU + 0 
2394 : 8d f7 9f STA $9ff7 ; (d + 1)
2397 : a9 41 __ LDA #$41
2399 : 69 00 __ ADC #$00
239b : 85 1c __ STA ACCU + 1 
239d : 8d f8 9f STA $9ff8 ; (room + 1)
;  28, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
23a0 : bd 01 41 LDA $4101,x ; (rooms + 1)
23a3 : 85 44 __ STA T8 + 0 
23a5 : c5 0e __ CMP P1 ; (y + 0)
23a7 : d0 1a __ BNE $23c3 ; (is_on_room_edge.s7 + 0)
.s9:
23a9 : a0 00 __ LDY #$00
23ab : b1 1b __ LDA (ACCU + 0),y 
23ad : c5 0d __ CMP P0 ; (x + 0)
23af : 90 02 __ BCC $23b3 ; (is_on_room_edge.s8 + 0)
.s1022:
23b1 : d0 10 __ BNE $23c3 ; (is_on_room_edge.s7 + 0)
.s8:
23b3 : 18 __ __ CLC
23b4 : a0 02 __ LDY #$02
23b6 : 71 1b __ ADC (ACCU + 0),y 
23b8 : 90 03 __ BCC $23bd ; (is_on_room_edge.s1017 + 0)
23ba : 4c 4f 24 JMP $244f ; (is_on_room_edge.s5 + 0)
.s1017:
23bd : c5 0d __ CMP P0 ; (x + 0)
23bf : 90 02 __ BCC $23c3 ; (is_on_room_edge.s7 + 0)
.s1023:
23c1 : d0 f7 __ BNE $23ba ; (is_on_room_edge.s8 + 7)
.s7:
;  30, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
23c3 : a0 03 __ LDY #$03
23c5 : b1 1b __ LDA (ACCU + 0),y 
23c7 : 18 __ __ CLC
23c8 : 65 44 __ ADC T8 + 0 
23ca : 85 1d __ STA ACCU + 2 
23cc : a9 00 __ LDA #$00
23ce : 2a __ __ ROL
23cf : aa __ __ TAX
23d0 : 38 __ __ SEC
23d1 : a5 1d __ LDA ACCU + 2 
23d3 : e9 01 __ SBC #$01
23d5 : 85 1e __ STA ACCU + 3 
23d7 : 8a __ __ TXA
23d8 : e9 00 __ SBC #$00
23da : d0 1d __ BNE $23f9 ; (is_on_room_edge.s1037 + 0)
.s1014:
23dc : a5 0e __ LDA P1 ; (y + 0)
23de : c5 1e __ CMP ACCU + 3 
23e0 : d0 17 __ BNE $23f9 ; (is_on_room_edge.s1037 + 0)
.s15:
23e2 : a0 00 __ LDY #$00
23e4 : b1 1b __ LDA (ACCU + 0),y 
23e6 : c5 0d __ CMP P0 ; (x + 0)
23e8 : 90 02 __ BCC $23ec ; (is_on_room_edge.s14 + 0)
.s1024:
23ea : d0 0f __ BNE $23fb ; (is_on_room_edge.s13 + 0)
.s14:
23ec : 18 __ __ CLC
23ed : a0 02 __ LDY #$02
23ef : 71 1b __ ADC (ACCU + 0),y 
23f1 : b0 5c __ BCS $244f ; (is_on_room_edge.s5 + 0)
.s1011:
23f3 : c5 0d __ CMP P0 ; (x + 0)
23f5 : 90 02 __ BCC $23f9 ; (is_on_room_edge.s1037 + 0)
.s1025:
23f7 : d0 56 __ BNE $244f ; (is_on_room_edge.s5 + 0)
.s1037:
;  32, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
23f9 : a0 00 __ LDY #$00
.s13:
23fb : b1 1b __ LDA (ACCU + 0),y 
23fd : 85 1e __ STA ACCU + 3 
23ff : c5 0d __ CMP P0 ; (x + 0)
2401 : d0 0f __ BNE $2412 ; (is_on_room_edge.s19 + 0)
.s21:
2403 : a5 0e __ LDA P1 ; (y + 0)
2405 : c5 44 __ CMP T8 + 0 
2407 : 90 09 __ BCC $2412 ; (is_on_room_edge.s19 + 0)
.s20:
2409 : 8a __ __ TXA
240a : d0 43 __ BNE $244f ; (is_on_room_edge.s5 + 0)
.s1008:
240c : a5 0e __ LDA P1 ; (y + 0)
240e : c5 1d __ CMP ACCU + 2 
2410 : 90 3d __ BCC $244f ; (is_on_room_edge.s5 + 0)
.s19:
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
2412 : a0 02 __ LDY #$02
2414 : b1 1b __ LDA (ACCU + 0),y 
2416 : 18 __ __ CLC
2417 : 65 1e __ ADC ACCU + 3 
2419 : a8 __ __ TAY
241a : a9 00 __ LDA #$00
241c : 2a __ __ ROL
241d : 85 1c __ STA ACCU + 1 
241f : 98 __ __ TYA
2420 : e9 00 __ SBC #$00
2422 : 85 1b __ STA ACCU + 0 
2424 : a5 1c __ LDA ACCU + 1 
2426 : e9 00 __ SBC #$00
2428 : d0 15 __ BNE $243f ; (is_on_room_edge.s3 + 0)
.s1005:
242a : a5 0d __ LDA P0 ; (x + 0)
242c : c5 1b __ CMP ACCU + 0 
242e : d0 0f __ BNE $243f ; (is_on_room_edge.s3 + 0)
.s27:
2430 : a5 0e __ LDA P1 ; (y + 0)
2432 : c5 44 __ CMP T8 + 0 
2434 : 90 09 __ BCC $243f ; (is_on_room_edge.s3 + 0)
.s26:
2436 : 8a __ __ TXA
2437 : d0 16 __ BNE $244f ; (is_on_room_edge.s5 + 0)
.s1002:
2439 : a5 0e __ LDA P1 ; (y + 0)
243b : c5 1d __ CMP ACCU + 2 
243d : 90 10 __ BCC $244f ; (is_on_room_edge.s5 + 0)
.s3:
;  25, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
243f : ee f9 9f INC $9ff9 ; (bit_offset + 1)
2442 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
2445 : c5 43 __ CMP T5 + 0 
2447 : b0 03 __ BCS $244c ; (is_on_room_edge.s4 + 0)
2449 : 4c 89 23 JMP $2389 ; (is_on_room_edge.l2 + 0)
.s4:
;  36, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
244c : a9 00 __ LDA #$00
.s1001:
244e : 60 __ __ RTS
.s5:
244f : a9 01 __ LDA #$01
2451 : 60 __ __ RTS
--------------------------------------------------------------------
manhattan_distance_fast: ; manhattan_distance_fast(u8,u8,u8,u8)->u8
.s0:
;  50, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utility.h"
2452 : a5 0f __ LDA P2 ; (x1 + 0)
2454 : 85 0d __ STA P0 
2456 : a5 11 __ LDA P4 ; (x2 + 0)
2458 : 85 0e __ STA P1 
245a : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
245d : 85 43 __ STA T0 + 0 
245f : a5 10 __ LDA P3 ; (y1 + 0)
2461 : 85 0d __ STA P0 
2463 : a5 12 __ LDA P5 ; (y2 + 0)
2465 : 85 0e __ STA P1 
2467 : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
246a : 18 __ __ CLC
246b : 65 43 __ ADC T0 + 0 
.s1001:
246d : 60 __ __ RTS
--------------------------------------------------------------------
place_door: ; place_door(u8,u8)->void
.s0:
;  16, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
246e : a5 13 __ LDA P6 ; (x + 0)
2470 : 85 10 __ STA P3 
2472 : a5 14 __ LDA P7 ; (y + 0)
2474 : 85 11 __ STA P4 
2476 : a9 03 __ LDA #$03
2478 : 85 12 __ STA P5 
247a : 4c 3b 16 JMP $163b ; (set_tile_raw.s0 + 0)
--------------------------------------------------------------------
draw_rule_based_corridor: ; draw_rule_based_corridor(u8,u8)->u8
.s0:
; 152, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
247d : a9 00 __ LDA #$00
247f : 8d e7 9f STA $9fe7 ; (down_x + 0)
2482 : 8d e6 9f STA $9fe6 ; (i + 0)
; 154, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2485 : ad fc 9f LDA $9ffc ; (sstack + 2)
2488 : 85 48 __ STA T1 + 0 
248a : 85 0d __ STA P0 
248c : a9 eb __ LDA #$eb
248e : 85 0e __ STA P1 
2490 : a9 9f __ LDA #$9f
2492 : 85 11 __ STA P4 
2494 : a9 9f __ LDA #$9f
2496 : 85 0f __ STA P2 
2498 : a9 ea __ LDA #$ea
249a : 85 10 __ STA P3 
249c : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 155, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
249f : ad fd 9f LDA $9ffd ; (sstack + 3)
24a2 : 85 49 __ STA T2 + 0 
24a4 : 85 0d __ STA P0 
24a6 : a9 e9 __ LDA #$e9
24a8 : 85 0e __ STA P1 
24aa : a9 9f __ LDA #$9f
24ac : 85 11 __ STA P4 
24ae : a9 9f __ LDA #$9f
24b0 : 85 0f __ STA P2 
24b2 : a9 e8 __ LDA #$e8
24b4 : 85 10 __ STA P3 
24b6 : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 156, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
24b9 : a5 48 __ LDA T1 + 0 
24bb : 0a __ __ ASL
24bc : 0a __ __ ASL
24bd : 0a __ __ ASL
24be : 85 4a __ STA T3 + 0 
24c0 : 18 __ __ CLC
24c1 : 69 00 __ ADC #$00
24c3 : 85 12 __ STA P5 
24c5 : a9 41 __ LDA #$41
24c7 : 69 00 __ ADC #$00
24c9 : 85 13 __ STA P6 
24cb : ad e9 9f LDA $9fe9 ; (y + 0)
24ce : 85 14 __ STA P7 
24d0 : ad e8 9f LDA $9fe8 ; (attempts + 0)
24d3 : 85 15 __ STA P8 
24d5 : a9 ef __ LDA #$ef
24d7 : 85 16 __ STA P9 
24d9 : a9 ee __ LDA #$ee
24db : 8d fa 9f STA $9ffa ; (sstack + 0)
24de : a9 9f __ LDA #$9f
24e0 : 85 17 __ STA P10 
24e2 : a9 9f __ LDA #$9f
24e4 : 8d fb 9f STA $9ffb ; (sstack + 1)
24e7 : 20 fd 21 JSR $21fd ; (find_room_exit.s0 + 0)
; 157, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
24ea : a5 49 __ LDA T2 + 0 
24ec : 0a __ __ ASL
24ed : 0a __ __ ASL
24ee : 0a __ __ ASL
24ef : 18 __ __ CLC
24f0 : 69 00 __ ADC #$00
24f2 : 85 12 __ STA P5 
24f4 : a9 41 __ LDA #$41
24f6 : 69 00 __ ADC #$00
24f8 : 85 13 __ STA P6 
24fa : ad eb 9f LDA $9feb ; (screen_offset + 1)
24fd : 85 14 __ STA P7 
24ff : ad ea 9f LDA $9fea ; (i + 0)
2502 : 85 15 __ STA P8 
2504 : a9 ed __ LDA #$ed
2506 : 85 16 __ STA P9 
2508 : a9 ec __ LDA #$ec
250a : 8d fa 9f STA $9ffa ; (sstack + 0)
250d : a9 9f __ LDA #$9f
250f : 85 17 __ STA P10 
2511 : a9 9f __ LDA #$9f
2513 : 8d fb 9f STA $9ffb ; (sstack + 1)
2516 : 20 fd 21 JSR $21fd ; (find_room_exit.s0 + 0)
; 161, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2519 : a2 00 __ LDX #$00
251b : 8e ea 40 STX $40ea ; (corridor_path_static + 40)
; 163, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
251e : ad ef 9f LDA $9fef ; (screen_pos + 1)
2521 : 85 4c __ STA T5 + 0 
2523 : 85 10 __ STA P3 
2525 : ad ee 9f LDA $9fee ; (entropy4 + 1)
2528 : 85 4d __ STA T6 + 0 
252a : 85 11 __ STA P4 
252c : a4 4a __ LDY T3 + 0 
252e : b9 00 41 LDA $4100,y ; (rooms + 0)
2531 : 38 __ __ SEC
2532 : e9 01 __ SBC #$01
2534 : 90 0f __ BCC $2545 ; (draw_rule_based_corridor.s2 + 0)
.s1031:
2536 : c5 10 __ CMP P3 
2538 : d0 0b __ BNE $2545 ; (draw_rule_based_corridor.s2 + 0)
.s1:
253a : a9 ff __ LDA #$ff
.s173:
; 164, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
253c : 8e e6 9f STX $9fe6 ; (i + 0)
253f : 8d e7 9f STA $9fe7 ; (down_x + 0)
2542 : 4c 7e 25 JMP $257e ; (draw_rule_based_corridor.s3 + 0)
.s2:
; 164, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2545 : b9 02 41 LDA $4102,y ; (rooms + 2)
2548 : 18 __ __ CLC
2549 : 79 00 41 ADC $4100,y ; (rooms + 0)
254c : b0 08 __ BCS $2556 ; (draw_rule_based_corridor.s5 + 0)
.s1028:
254e : c5 10 __ CMP P3 
2550 : d0 04 __ BNE $2556 ; (draw_rule_based_corridor.s5 + 0)
.s4:
2552 : a9 01 __ LDA #$01
2554 : d0 e6 __ BNE $253c ; (draw_rule_based_corridor.s173 + 0)
.s5:
; 165, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2556 : b9 01 41 LDA $4101,y ; (rooms + 1)
2559 : 38 __ __ SEC
255a : e9 01 __ SBC #$01
255c : 90 0f __ BCC $256d ; (draw_rule_based_corridor.s8 + 0)
.s1025:
255e : c5 11 __ CMP P4 
2560 : d0 0b __ BNE $256d ; (draw_rule_based_corridor.s8 + 0)
.s7:
2562 : a9 ff __ LDA #$ff
.s199:
; 166, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2564 : 8e e7 9f STX $9fe7 ; (down_x + 0)
2567 : 8d e6 9f STA $9fe6 ; (i + 0)
256a : 4c 7e 25 JMP $257e ; (draw_rule_based_corridor.s3 + 0)
.s8:
; 166, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
256d : b9 03 41 LDA $4103,y ; (rooms + 3)
2570 : 18 __ __ CLC
2571 : 79 01 41 ADC $4101,y ; (rooms + 1)
2574 : b0 08 __ BCS $257e ; (draw_rule_based_corridor.s3 + 0)
.s1022:
2576 : c5 11 __ CMP P4 
2578 : d0 04 __ BNE $257e ; (draw_rule_based_corridor.s3 + 0)
.s10:
257a : a9 01 __ LDA #$01
257c : d0 e6 __ BNE $2564 ; (draw_rule_based_corridor.s199 + 0)
.s3:
; 169, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
257e : a9 02 __ LDA #$02
2580 : 85 12 __ STA P5 
2582 : a9 01 __ LDA #$01
2584 : 8d 2a 33 STA $332a ; (corridor_endpoint_override + 0)
; 170, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2587 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
; 172, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
258a : a5 4c __ LDA T5 + 0 
258c : 8d c2 40 STA $40c2 ; (corridor_path_static + 0)
; 173, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
258f : a5 4d __ LDA T6 + 0 
2591 : 8d d6 40 STA $40d6 ; (corridor_path_static + 20)
; 178, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2594 : ad e7 9f LDA $9fe7 ; (down_x + 0)
2597 : 85 4a __ STA T3 + 0 
2599 : 18 __ __ CLC
259a : 65 10 __ ADC P3 
259c : 85 13 __ STA P6 
259e : 8d e5 9f STA $9fe5 ; (x + 0)
; 176, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25a1 : a9 00 __ LDA #$00
25a3 : 8d 2a 33 STA $332a ; (corridor_endpoint_override + 0)
; 174, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25a6 : a9 01 __ LDA #$01
25a8 : 8d ea 40 STA $40ea ; (corridor_path_static + 40)
; 179, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25ab : ad e6 9f LDA $9fe6 ; (i + 0)
25ae : 85 4b __ STA T4 + 0 
25b0 : 18 __ __ CLC
25b1 : 65 11 __ ADC P4 
25b3 : 85 14 __ STA P7 
25b5 : 8d e4 9f STA $9fe4 ; (y + 0)
; 180, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25b8 : 20 c2 22 JSR $22c2 ; (can_place_corridor_tile.s0 + 0)
25bb : aa __ __ TAX
25bc : f0 75 __ BEQ $2633 ; (draw_rule_based_corridor.s22 + 0)
.s16:
; 181, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25be : a5 13 __ LDA P6 
25c0 : 85 10 __ STA P3 
25c2 : a5 14 __ LDA P7 
25c4 : 85 11 __ STA P4 
25c6 : a9 02 __ LDA #$02
25c8 : 85 12 __ STA P5 
25ca : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
; 184, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25cd : a5 14 __ LDA P7 
25cf : 8d d7 40 STA $40d7 ; (corridor_path_static + 21)
; 185, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25d2 : a9 02 __ LDA #$02
25d4 : 8d ea 40 STA $40ea ; (corridor_path_static + 40)
; 183, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25d7 : a5 13 __ LDA P6 
25d9 : 8d c3 40 STA $40c3 ; (corridor_path_static + 1)
25dc : 30 05 __ BMI $25e3 ; (draw_rule_based_corridor.l25 + 0)
.s1019:
; 190, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25de : cd ed 9f CMP $9fed ; (extra_range_y + 0)
25e1 : f0 56 __ BEQ $2639 ; (draw_rule_based_corridor.s58 + 0)
.l25:
25e3 : ad e4 9f LDA $9fe4 ; (y + 0)
25e6 : 30 05 __ BMI $25ed ; (draw_rule_based_corridor.s23 + 0)
.s1016:
25e8 : cd ec 9f CMP $9fec ; (random_offset_x + 0)
25eb : f0 4c __ BEQ $2639 ; (draw_rule_based_corridor.s58 + 0)
.s23:
; 191, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25ed : ad e5 9f LDA $9fe5 ; (x + 0)
25f0 : 18 __ __ CLC
25f1 : 65 4a __ ADC T3 + 0 
25f3 : 85 13 __ STA P6 
25f5 : 8d e5 9f STA $9fe5 ; (x + 0)
; 192, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25f8 : ad e4 9f LDA $9fe4 ; (y + 0)
25fb : 18 __ __ CLC
25fc : 65 4b __ ADC T4 + 0 
25fe : 85 14 __ STA P7 
2600 : 8d e4 9f STA $9fe4 ; (y + 0)
; 193, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2603 : 20 c2 22 JSR $22c2 ; (can_place_corridor_tile.s0 + 0)
2606 : aa __ __ TAX
2607 : f0 2a __ BEQ $2633 ; (draw_rule_based_corridor.s22 + 0)
.s26:
; 194, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2609 : a5 13 __ LDA P6 
260b : 85 10 __ STA P3 
260d : a5 14 __ LDA P7 
260f : 85 11 __ STA P4 
2611 : a9 02 __ LDA #$02
2613 : 85 12 __ STA P5 
2615 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
; 195, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2618 : ae ea 40 LDX $40ea ; (corridor_path_static + 40)
261b : e0 14 __ CPX #$14
261d : b0 14 __ BCS $2633 ; (draw_rule_based_corridor.s22 + 0)
.s29:
; 196, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
261f : a5 13 __ LDA P6 
2621 : 9d c2 40 STA $40c2,x ; (corridor_path_static + 0)
; 197, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2624 : a5 14 __ LDA P7 
2626 : 9d d6 40 STA $40d6,x ; (corridor_path_static + 20)
; 198, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2629 : e8 __ __ INX
262a : 8e ea 40 STX $40ea ; (corridor_path_static + 40)
; 190, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
262d : a5 13 __ LDA P6 
262f : 30 b2 __ BMI $25e3 ; (draw_rule_based_corridor.l25 + 0)
2631 : 10 ab __ BPL $25de ; (draw_rule_based_corridor.s1019 + 0)
.s22:
; 190, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2633 : a5 13 __ LDA P6 
2635 : 30 ac __ BMI $25e3 ; (draw_rule_based_corridor.l25 + 0)
2637 : 10 a5 __ BPL $25de ; (draw_rule_based_corridor.s1019 + 0)
.s58:
; 203, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2639 : ad e5 9f LDA $9fe5 ; (x + 0)
263c : 30 0d __ BMI $264b ; (draw_rule_based_corridor.l33 + 0)
.s1013:
; 203, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
263e : cd ed 9f CMP $9fed ; (extra_range_y + 0)
2641 : d0 08 __ BNE $264b ; (draw_rule_based_corridor.l33 + 0)
.s57:
; 215, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2643 : ad e4 9f LDA $9fe4 ; (y + 0)
2646 : 85 4a __ STA T3 + 0 
2648 : 4c ad 26 JMP $26ad ; (draw_rule_based_corridor.l191 + 0)
.l33:
; 204, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
264b : ad e5 9f LDA $9fe5 ; (x + 0)
264e : 29 80 __ AND #$80
2650 : 10 02 __ BPL $2654 ; (draw_rule_based_corridor.l33 + 9)
2652 : a9 ff __ LDA #$ff
2654 : 30 13 __ BMI $2669 ; (draw_rule_based_corridor.s35 + 0)
.s1012:
2656 : d0 08 __ BNE $2660 ; (draw_rule_based_corridor.s36 + 0)
.s1009:
2658 : ad e5 9f LDA $9fe5 ; (x + 0)
265b : cd ed 9f CMP $9fed ; (extra_range_y + 0)
265e : 90 09 __ BCC $2669 ; (draw_rule_based_corridor.s35 + 0)
.s36:
; 205, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2660 : ad e5 9f LDA $9fe5 ; (x + 0)
2663 : 18 __ __ CLC
2664 : 69 ff __ ADC #$ff
2666 : 4c 6f 26 JMP $266f ; (draw_rule_based_corridor.s37 + 0)
.s35:
; 204, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2669 : ad e5 9f LDA $9fe5 ; (x + 0)
266c : 18 __ __ CLC
266d : 69 01 __ ADC #$01
.s37:
; 205, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
266f : 8d e5 9f STA $9fe5 ; (x + 0)
; 206, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2672 : 85 13 __ STA P6 
2674 : 85 4a __ STA T3 + 0 
2676 : ad e4 9f LDA $9fe4 ; (y + 0)
2679 : 85 4c __ STA T5 + 0 
267b : 85 14 __ STA P7 
267d : 20 c2 22 JSR $22c2 ; (can_place_corridor_tile.s0 + 0)
2680 : aa __ __ TAX
2681 : f0 24 __ BEQ $26a7 ; (draw_rule_based_corridor.s32 + 0)
.s38:
; 207, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2683 : a5 13 __ LDA P6 
2685 : 85 10 __ STA P3 
2687 : a5 4c __ LDA T5 + 0 
2689 : 85 11 __ STA P4 
268b : a9 02 __ LDA #$02
268d : 85 12 __ STA P5 
268f : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
; 208, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2692 : ae ea 40 LDX $40ea ; (corridor_path_static + 40)
2695 : e0 14 __ CPX #$14
2697 : b0 0e __ BCS $26a7 ; (draw_rule_based_corridor.s32 + 0)
.s41:
; 209, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2699 : a5 13 __ LDA P6 
269b : 9d c2 40 STA $40c2,x ; (corridor_path_static + 0)
; 210, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
269e : a5 4c __ LDA T5 + 0 
26a0 : 9d d6 40 STA $40d6,x ; (corridor_path_static + 20)
; 211, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26a3 : e8 __ __ INX
26a4 : 8e ea 40 STX $40ea ; (corridor_path_static + 40)
.s32:
; 203, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26a7 : a5 4a __ LDA T3 + 0 
26a9 : 30 a0 __ BMI $264b ; (draw_rule_based_corridor.l33 + 0)
26ab : 10 91 __ BPL $263e ; (draw_rule_based_corridor.s1013 + 0)
.l191:
; 215, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26ad : ad ec 9f LDA $9fec ; (random_offset_x + 0)
26b0 : 85 49 __ STA T2 + 0 
26b2 : a5 4a __ LDA T3 + 0 
26b4 : 30 04 __ BMI $26ba ; (draw_rule_based_corridor.s45 + 0)
.s1006:
26b6 : c5 49 __ CMP T2 + 0 
26b8 : f0 5d __ BEQ $2717 ; (draw_rule_based_corridor.s46 + 0)
.s45:
; 216, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26ba : ad e4 9f LDA $9fe4 ; (y + 0)
26bd : 29 80 __ AND #$80
26bf : 10 02 __ BPL $26c3 ; (draw_rule_based_corridor.s45 + 9)
26c1 : a9 ff __ LDA #$ff
26c3 : 30 12 __ BMI $26d7 ; (draw_rule_based_corridor.s47 + 0)
.s1005:
26c5 : d0 07 __ BNE $26ce ; (draw_rule_based_corridor.s48 + 0)
.s1002:
26c7 : ad e4 9f LDA $9fe4 ; (y + 0)
26ca : c5 49 __ CMP T2 + 0 
26cc : 90 09 __ BCC $26d7 ; (draw_rule_based_corridor.s47 + 0)
.s48:
; 217, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26ce : ad e4 9f LDA $9fe4 ; (y + 0)
26d1 : 18 __ __ CLC
26d2 : 69 ff __ ADC #$ff
26d4 : 4c dd 26 JMP $26dd ; (draw_rule_based_corridor.s49 + 0)
.s47:
; 216, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26d7 : ad e4 9f LDA $9fe4 ; (y + 0)
26da : 18 __ __ CLC
26db : 69 01 __ ADC #$01
.s49:
; 217, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26dd : 85 4a __ STA T3 + 0 
26df : 8d e4 9f STA $9fe4 ; (y + 0)
; 218, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26e2 : 85 14 __ STA P7 
26e4 : ad e5 9f LDA $9fe5 ; (x + 0)
26e7 : 85 4b __ STA T4 + 0 
26e9 : 85 13 __ STA P6 
26eb : 20 c2 22 JSR $22c2 ; (can_place_corridor_tile.s0 + 0)
26ee : aa __ __ TAX
26ef : f0 bc __ BEQ $26ad ; (draw_rule_based_corridor.l191 + 0)
.s50:
; 219, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26f1 : a5 4b __ LDA T4 + 0 
26f3 : 85 10 __ STA P3 
26f5 : a5 14 __ LDA P7 
26f7 : 85 11 __ STA P4 
26f9 : a9 02 __ LDA #$02
26fb : 85 12 __ STA P5 
26fd : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
; 220, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2700 : ae ea 40 LDX $40ea ; (corridor_path_static + 40)
2703 : e0 14 __ CPX #$14
2705 : b0 a6 __ BCS $26ad ; (draw_rule_based_corridor.l191 + 0)
.s53:
; 221, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2707 : a5 4b __ LDA T4 + 0 
2709 : 9d c2 40 STA $40c2,x ; (corridor_path_static + 0)
; 222, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
270c : a5 14 __ LDA P7 
270e : 9d d6 40 STA $40d6,x ; (corridor_path_static + 20)
; 223, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2711 : e8 __ __ INX
2712 : 8e ea 40 STX $40ea ; (corridor_path_static + 40)
2715 : 90 96 __ BCC $26ad ; (draw_rule_based_corridor.l191 + 0)
.s46:
; 230, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2717 : ad ef 9f LDA $9fef ; (screen_pos + 1)
271a : 85 13 __ STA P6 
271c : ad ee 9f LDA $9fee ; (entropy4 + 1)
271f : 85 14 __ STA P7 
2721 : 20 6e 24 JSR $246e ; (place_door.s0 + 0)
; 231, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2724 : ad ed 9f LDA $9fed ; (extra_range_y + 0)
2727 : 85 13 __ STA P6 
2729 : a5 49 __ LDA T2 + 0 
272b : 85 14 __ STA P7 
272d : 20 6e 24 JSR $246e ; (place_door.s0 + 0)
; 233, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2730 : a9 01 __ LDA #$01
.s1001:
2732 : 60 __ __ RTS
--------------------------------------------------------------------
add_walls: ; add_walls()->void
.s0:
;  23, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2733 : a9 26 __ LDA #$26
2735 : 85 0d __ STA P0 
2737 : a9 28 __ LDA #$28
2739 : 85 0e __ STA P1 
273b : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
;  26, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
273e : a9 00 __ LDA #$00
2740 : 8d ee 9f STA $9fee ; (entropy4 + 1)
.l2:
;  27, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2743 : a9 00 __ LDA #$00
2745 : 8d ef 9f STA $9fef ; (screen_pos + 1)
.l6:
;  28, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2748 : 85 4a __ STA T3 + 0 
274a : 85 0f __ STA P2 
274c : ad ee 9f LDA $9fee ; (entropy4 + 1)
274f : 85 4b __ STA T4 + 0 
2751 : 85 10 __ STA P3 
2753 : 20 93 1c JSR $1c93 ; (get_tile_raw.s0 + 0)
2756 : a5 1b __ LDA ACCU + 0 
2758 : 8d ed 9f STA $9fed ; (extra_range_y + 0)
;  31, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
275b : c9 02 __ CMP #$02
275d : f0 07 __ BEQ $2766 ; (add_walls.s9 + 0)
.s12:
275f : c9 03 __ CMP #$03
2761 : f0 03 __ BEQ $2766 ; (add_walls.s9 + 0)
2763 : 4c f6 27 JMP $27f6 ; (add_walls.s5 + 0)
.s9:
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2766 : a5 4b __ LDA T4 + 0 
2768 : 85 48 __ STA T0 + 0 
276a : f0 1e __ BEQ $278a ; (add_walls.s15 + 0)
.s16:
276c : aa __ __ TAX
276d : ca __ __ DEX
276e : 86 49 __ STX T1 + 0 
2770 : 86 10 __ STX P3 
2772 : 20 93 1c JSR $1c93 ; (get_tile_raw.s0 + 0)
2775 : a5 1b __ LDA ACCU + 0 
2777 : d0 0f __ BNE $2788 ; (add_walls.s1002 + 0)
.s13:
;  35, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2779 : a5 0f __ LDA P2 
277b : 85 10 __ STA P3 
277d : a5 49 __ LDA T1 + 0 
277f : 85 11 __ STA P4 
2781 : a9 01 __ LDA #$01
2783 : 85 12 __ STA P5 
2785 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s1002:
;  39, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2788 : a5 4b __ LDA T4 + 0 
.s15:
278a : c9 3f __ CMP #$3f
278c : b0 20 __ BCS $27ae ; (add_walls.s19 + 0)
.s20:
278e : a5 4a __ LDA T3 + 0 
2790 : 85 0f __ STA P2 
2792 : e6 48 __ INC T0 + 0 
2794 : a5 48 __ LDA T0 + 0 
2796 : 85 10 __ STA P3 
2798 : 20 93 1c JSR $1c93 ; (get_tile_raw.s0 + 0)
279b : a5 1b __ LDA ACCU + 0 
279d : d0 0f __ BNE $27ae ; (add_walls.s19 + 0)
.s17:
;  40, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
279f : a5 0f __ LDA P2 
27a1 : 85 10 __ STA P3 
27a3 : a5 48 __ LDA T0 + 0 
27a5 : 85 11 __ STA P4 
27a7 : a9 01 __ LDA #$01
27a9 : 85 12 __ STA P5 
27ab : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s19:
;  44, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
27ae : a5 4a __ LDA T3 + 0 
27b0 : f0 1f __ BEQ $27d1 ; (add_walls.s23 + 0)
.s24:
27b2 : a6 4b __ LDX T4 + 0 
27b4 : 86 10 __ STX P3 
27b6 : 38 __ __ SEC
27b7 : e9 01 __ SBC #$01
27b9 : 85 0f __ STA P2 
27bb : 20 93 1c JSR $1c93 ; (get_tile_raw.s0 + 0)
27be : a5 1b __ LDA ACCU + 0 
27c0 : d0 0f __ BNE $27d1 ; (add_walls.s23 + 0)
.s21:
;  45, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
27c2 : a5 0f __ LDA P2 
27c4 : 85 10 __ STA P3 
27c6 : a5 4b __ LDA T4 + 0 
27c8 : 85 11 __ STA P4 
27ca : a9 01 __ LDA #$01
27cc : 85 12 __ STA P5 
27ce : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s23:
;  49, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
27d1 : a6 4a __ LDX T3 + 0 
27d3 : e0 3f __ CPX #$3f
27d5 : b0 1f __ BCS $27f6 ; (add_walls.s5 + 0)
.s28:
27d7 : e8 __ __ INX
27d8 : 86 48 __ STX T0 + 0 
27da : 86 0f __ STX P2 
27dc : a5 4b __ LDA T4 + 0 
27de : 85 10 __ STA P3 
27e0 : 20 93 1c JSR $1c93 ; (get_tile_raw.s0 + 0)
27e3 : a5 1b __ LDA ACCU + 0 
27e5 : d0 0f __ BNE $27f6 ; (add_walls.s5 + 0)
.s25:
;  50, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
27e7 : a5 48 __ LDA T0 + 0 
27e9 : 85 10 __ STA P3 
27eb : a5 4b __ LDA T4 + 0 
27ed : 85 11 __ STA P4 
27ef : a9 01 __ LDA #$01
27f1 : 85 12 __ STA P5 
27f3 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s5:
;  27, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
27f6 : 18 __ __ CLC
27f7 : a5 4a __ LDA T3 + 0 
27f9 : 69 01 __ ADC #$01
27fb : 8d ef 9f STA $9fef ; (screen_pos + 1)
27fe : c9 40 __ CMP #$40
2800 : b0 03 __ BCS $2805 ; (add_walls.s8 + 0)
2802 : 4c 48 27 JMP $2748 ; (add_walls.l6 + 0)
.s8:
;  53, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2805 : a5 4b __ LDA T4 + 0 
2807 : 29 0f __ AND #$0f
2809 : d0 0b __ BNE $2816 ; (add_walls.s1 + 0)
.s29:
280b : a9 40 __ LDA #$40
280d : 85 0d __ STA P0 
280f : a9 17 __ LDA #$17
2811 : 85 0e __ STA P1 
2813 : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
.s1:
;  26, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2816 : 18 __ __ CLC
2817 : a5 4b __ LDA T4 + 0 
2819 : 69 01 __ ADC #$01
281b : 8d ee 9f STA $9fee ; (entropy4 + 1)
281e : c9 40 __ CMP #$40
2820 : b0 03 __ BCS $2825 ; (add_walls.s1001 + 0)
2822 : 4c 43 27 JMP $2743 ; (add_walls.l2 + 0)
.s1001:
;  55, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2825 : 60 __ __ RTS
--------------------------------------------------------------------
2826 : __ __ __ BYT 0a 0a 43 52 45 41 54 49 4e 47 20 57 41 4c 4c 53 : ..CREATING WALLS
2836 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
add_stairs: ; add_stairs()->void
.s0:
;  64, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2837 : a9 4d __ LDA #$4d
2839 : 85 0d __ STA P0 
283b : a9 29 __ LDA #$29
283d : 85 0e __ STA P1 
283f : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
;  66, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2842 : ad 1c 32 LDA $321c ; (room_count + 0)
2845 : c9 02 __ CMP #$02
2847 : b0 01 __ BCS $284a ; (add_stairs.s3 + 0)
2849 : 60 __ __ RTS
.s3:
;  69, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
284a : 85 4a __ STA T3 + 0 
284c : e9 01 __ SBC #$01
284e : 8d ee 9f STA $9fee ; (entropy4 + 1)
;  68, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2851 : a9 00 __ LDA #$00
2853 : 8d ef 9f STA $9fef ; (screen_pos + 1)
;  71, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2856 : 8d ed 9f STA $9fed ; (extra_range_y + 0)
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2859 : 8d ec 9f STA $9fec ; (random_offset_x + 0)
.l6:
;  73, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
285c : 85 4b __ STA T4 + 0 
285e : 29 03 __ AND #$03
2860 : d0 0b __ BNE $286d ; (add_stairs.s11 + 0)
.s9:
2862 : a9 40 __ LDA #$40
2864 : 85 0d __ STA P0 
2866 : a9 17 __ LDA #$17
2868 : 85 0e __ STA P1 
286a : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
.s11:
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
286d : a6 4b __ LDX T4 + 0 
286f : e8 __ __ INX
2870 : 8e ec 9f STX $9fec ; (random_offset_x + 0)
;  74, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2873 : a5 4b __ LDA T4 + 0 
2875 : 0a __ __ ASL
2876 : 0a __ __ ASL
2877 : 0a __ __ ASL
2878 : a8 __ __ TAY
2879 : ad ed 9f LDA $9fed ; (extra_range_y + 0)
287c : d9 07 41 CMP $4107,y ; (rooms + 7)
287f : b0 0b __ BCS $288c ; (add_stairs.s5 + 0)
.s12:
;  76, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2881 : a5 4b __ LDA T4 + 0 
2883 : 8d ef 9f STA $9fef ; (screen_pos + 1)
;  75, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2886 : b9 07 41 LDA $4107,y ; (rooms + 7)
2889 : 8d ed 9f STA $9fed ; (extra_range_y + 0)
.s5:
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
288c : ad ec 9f LDA $9fec ; (random_offset_x + 0)
288f : c5 4a __ CMP T3 + 0 
2891 : 90 c9 __ BCC $285c ; (add_stairs.l6 + 0)
.s8:
;  81, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2893 : a9 00 __ LDA #$00
2895 : 8d eb 9f STA $9feb ; (screen_offset + 1)
;  82, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2898 : 8d ea 9f STA $9fea ; (i + 0)
.l16:
;  83, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
289b : 85 4b __ STA T4 + 0 
289d : 29 03 __ AND #$03
289f : d0 0b __ BNE $28ac ; (add_stairs.s76 + 0)
.s19:
28a1 : a9 40 __ LDA #$40
28a3 : 85 0d __ STA P0 
28a5 : a9 17 __ LDA #$17
28a7 : 85 0e __ STA P1 
28a9 : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
.s76:
;  84, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
28ac : a5 4b __ LDA T4 + 0 
28ae : cd ef 9f CMP $9fef ; (screen_pos + 1)
28b1 : f0 19 __ BEQ $28cc ; (add_stairs.s15 + 0)
.s25:
28b3 : 0a __ __ ASL
28b4 : 0a __ __ ASL
28b5 : 0a __ __ ASL
28b6 : a8 __ __ TAY
28b7 : ad eb 9f LDA $9feb ; (screen_offset + 1)
28ba : d9 07 41 CMP $4107,y ; (rooms + 7)
28bd : b0 0b __ BCS $28ca ; (add_stairs.s1002 + 0)
.s22:
;  86, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
28bf : a5 4b __ LDA T4 + 0 
28c1 : 8d ee 9f STA $9fee ; (entropy4 + 1)
;  85, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
28c4 : b9 07 41 LDA $4107,y ; (rooms + 7)
28c7 : 8d eb 9f STA $9feb ; (screen_offset + 1)
.s1002:
;  82, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
28ca : a5 4b __ LDA T4 + 0 
.s15:
28cc : 18 __ __ CLC
28cd : 69 01 __ ADC #$01
28cf : 8d ea 9f STA $9fea ; (i + 0)
28d2 : c5 4a __ CMP T3 + 0 
28d4 : 90 c5 __ BCC $289b ; (add_stairs.l16 + 0)
.s18:
;  90, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
28d6 : ad ef 9f LDA $9fef ; (screen_pos + 1)
28d9 : 85 0d __ STA P0 
28db : a9 e9 __ LDA #$e9
28dd : 85 0e __ STA P1 
28df : a9 9f __ LDA #$9f
28e1 : 85 11 __ STA P4 
28e3 : a9 9f __ LDA #$9f
28e5 : 85 0f __ STA P2 
28e7 : a9 e8 __ LDA #$e8
28e9 : 85 10 __ STA P3 
28eb : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
;  91, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
28ee : ad e9 9f LDA $9fe9 ; (y + 0)
28f1 : 85 48 __ STA T1 + 0 
28f3 : 85 0d __ STA P0 
28f5 : ad e8 9f LDA $9fe8 ; (attempts + 0)
28f8 : 85 49 __ STA T2 + 0 
28fa : 85 0e __ STA P1 
28fc : 20 dd 14 JSR $14dd ; (coords_in_bounds.s0 + 0)
28ff : aa __ __ TAX
2900 : f0 0f __ BEQ $2911 ; (add_stairs.s28 + 0)
.s26:
;  92, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2902 : a5 48 __ LDA T1 + 0 
2904 : 85 10 __ STA P3 
2906 : a5 49 __ LDA T2 + 0 
2908 : 85 11 __ STA P4 
290a : a9 04 __ LDA #$04
290c : 85 12 __ STA P5 
290e : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s28:
;  97, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2911 : ad ee 9f LDA $9fee ; (entropy4 + 1)
2914 : 85 0d __ STA P0 
2916 : a9 e7 __ LDA #$e7
2918 : 85 0e __ STA P1 
291a : a9 9f __ LDA #$9f
291c : 85 11 __ STA P4 
291e : a9 9f __ LDA #$9f
2920 : 85 0f __ STA P2 
2922 : a9 e6 __ LDA #$e6
2924 : 85 10 __ STA P3 
2926 : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
;  98, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2929 : ad e7 9f LDA $9fe7 ; (down_x + 0)
292c : 85 48 __ STA T1 + 0 
292e : 85 0d __ STA P0 
2930 : ad e6 9f LDA $9fe6 ; (i + 0)
2933 : 85 49 __ STA T2 + 0 
2935 : 85 0e __ STA P1 
2937 : 20 dd 14 JSR $14dd ; (coords_in_bounds.s0 + 0)
293a : aa __ __ TAX
293b : d0 01 __ BNE $293e ; (add_stairs.s29 + 0)
.s1001:
;  66, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
293d : 60 __ __ RTS
.s29:
;  99, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
293e : a5 48 __ LDA T1 + 0 
2940 : 85 10 __ STA P3 
2942 : a5 49 __ LDA T2 + 0 
2944 : 85 11 __ STA P4 
2946 : a9 05 __ LDA #$05
2948 : 85 12 __ STA P5 
294a : 4c 3b 16 JMP $163b ; (set_tile_raw.s0 + 0)
--------------------------------------------------------------------
294d : __ __ __ BYT 0a 0a 50 4c 41 43 49 4e 47 20 53 54 41 49 52 53 : ..PLACING STAIRS
295d : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
krnio_setnam: ; krnio_setnam(const u8*)->void
.s0:
;  34, "E:/Apps/oscar64/include/c64/kernalio.c"
295e : a5 0d __ LDA P0 
2960 : 05 0e __ ORA P1 
2962 : f0 08 __ BEQ $296c ; (krnio_setnam.s0 + 14)
2964 : a0 ff __ LDY #$ff
2966 : c8 __ __ INY
2967 : b1 0d __ LDA (P0),y 
2969 : d0 fb __ BNE $2966 ; (krnio_setnam.s0 + 8)
296b : 98 __ __ TYA
296c : a6 0d __ LDX P0 
296e : a4 0e __ LDY P1 
2970 : 20 bd ff JSR $ffbd 
.s1001:
;  49, "E:/Apps/oscar64/include/c64/kernalio.c"
2973 : 60 __ __ RTS
--------------------------------------------------------------------
2974 : __ __ __ BYT 4d 41 50 44 41 54 41 2e 42 49 4e 00             : MAPDATA.BIN.
--------------------------------------------------------------------
krnio_save: ; krnio_save(u8,const u8*,const u8*)->bool
.s0:
; 161, "E:/Apps/oscar64/include/c64/kernalio.c"
2980 : a9 00 __ LDA #$00
2982 : a6 0d __ LDX P0 
2984 : a0 00 __ LDY #$00
2986 : 20 ba ff JSR $ffba 
2989 : a9 0e __ LDA #$0e
298b : a6 10 __ LDX P3 
298d : a4 11 __ LDY P4 
298f : 20 d8 ff JSR $ffd8 
2992 : a9 00 __ LDA #$00
2994 : 2a __ __ ROL
2995 : 49 01 __ EOR #$01
2997 : 85 1b __ STA ACCU + 0 
2999 : a5 1b __ LDA ACCU + 0 
299b : f0 02 __ BEQ $299f ; (krnio_save.s1001 + 0)
.s1006:
299d : a9 01 __ LDA #$01
.s1001:
; 158, "E:/Apps/oscar64/include/c64/kernalio.c"
299f : 60 __ __ RTS
--------------------------------------------------------------------
puts: ; puts(const u8*)->void
.l1:
;  17, "E:/Apps/oscar64/include/stdio.c"
29a0 : a0 00 __ LDY #$00
29a2 : b1 0f __ LDA (P2),y ; (str + 0)
29a4 : 8d f8 9f STA $9ff8 ; (room + 1)
29a7 : e6 0f __ INC P2 ; (str + 0)
29a9 : d0 02 __ BNE $29ad ; (puts.s1003 + 0)
.s1002:
29ab : e6 10 __ INC P3 ; (str + 1)
.s1003:
29ad : aa __ __ TAX
29ae : f0 08 __ BEQ $29b8 ; (puts.s1001 + 0)
.s2:
;  18, "E:/Apps/oscar64/include/stdio.c"
29b0 : 85 0e __ STA P1 
29b2 : 20 b9 29 JSR $29b9 ; (putpch.s0 + 0)
29b5 : 4c a0 29 JMP $29a0 ; (puts.l1 + 0)
.s1001:
;  19, "E:/Apps/oscar64/include/stdio.c"
29b8 : 60 __ __ RTS
--------------------------------------------------------------------
putpch: ; putpch(u8)->void
.s0:
; 204, "E:/Apps/oscar64/include/conio.c"
29b9 : ad 2b 33 LDA $332b ; (giocharmap + 0)
29bc : f0 33 __ BEQ $29f1 ; (putpch.s1004 + 0)
.s1:
; 206, "E:/Apps/oscar64/include/conio.c"
29be : a5 0e __ LDA P1 ; (c + 0)
29c0 : c9 0a __ CMP #$0a
29c2 : d0 05 __ BNE $29c9 ; (putpch.s5 + 0)
.s4:
; 239, "E:/Apps/oscar64/include/conio.c"
29c4 : a9 0d __ LDA #$0d
.s1002:
29c6 : 4c 1a 2a JMP $2a1a ; (putrch.s0 + 0)
.s5:
; 208, "E:/Apps/oscar64/include/conio.c"
29c9 : c9 09 __ CMP #$09
29cb : f0 30 __ BEQ $29fd ; (putpch.s7 + 0)
.s8:
; 216, "E:/Apps/oscar64/include/conio.c"
29cd : ad 2b 33 LDA $332b ; (giocharmap + 0)
29d0 : c9 02 __ CMP #$02
29d2 : 90 1d __ BCC $29f1 ; (putpch.s1004 + 0)
.s13:
; 218, "E:/Apps/oscar64/include/conio.c"
29d4 : a5 0e __ LDA P1 ; (c + 0)
29d6 : c9 41 __ CMP #$41
29d8 : 90 ec __ BCC $29c6 ; (putpch.s1002 + 0)
.s19:
29da : c9 7b __ CMP #$7b
29dc : b0 e8 __ BCS $29c6 ; (putpch.s1002 + 0)
.s16:
; 220, "E:/Apps/oscar64/include/conio.c"
29de : c9 61 __ CMP #$61
29e0 : b0 04 __ BCS $29e6 ; (putpch.s20 + 0)
.s23:
29e2 : c9 5b __ CMP #$5b
29e4 : b0 e0 __ BCS $29c6 ; (putpch.s1002 + 0)
.s20:
; 230, "E:/Apps/oscar64/include/conio.c"
29e6 : 49 20 __ EOR #$20
29e8 : 85 0e __ STA P1 ; (c + 0)
29ea : ad 2b 33 LDA $332b ; (giocharmap + 0)
29ed : c9 02 __ CMP #$02
29ef : f0 05 __ BEQ $29f6 ; (putpch.s24 + 0)
.s1004:
; 239, "E:/Apps/oscar64/include/conio.c"
29f1 : a5 0e __ LDA P1 ; (c + 0)
29f3 : 4c c6 29 JMP $29c6 ; (putpch.s1002 + 0)
.s24:
; 240, "E:/Apps/oscar64/include/conio.c"
29f6 : a5 0e __ LDA P1 ; (c + 0)
29f8 : 29 5f __ AND #$5f
29fa : 4c c6 29 JMP $29c6 ; (putpch.s1002 + 0)
.s7:
; 210, "E:/Apps/oscar64/include/conio.c"
29fd : 20 15 2a JSR $2a15 ; (wherex.s0 + 0)
2a00 : 29 03 __ AND #$03
2a02 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
.l10:
; 212, "E:/Apps/oscar64/include/conio.c"
2a05 : a9 20 __ LDA #$20
2a07 : 20 1a 2a JSR $2a1a ; (putrch.s0 + 0)
; 213, "E:/Apps/oscar64/include/conio.c"
2a0a : ee f9 9f INC $9ff9 ; (bit_offset + 1)
2a0d : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
2a10 : c9 04 __ CMP #$04
2a12 : 90 f1 __ BCC $2a05 ; (putpch.l10 + 0)
.s1001:
; 240, "E:/Apps/oscar64/include/conio.c"
2a14 : 60 __ __ RTS
--------------------------------------------------------------------
wherex: ; wherex()->u8
.s0:
; 413, "E:/Apps/oscar64/include/conio.c"
2a15 : a5 d3 __ LDA $d3 
.s1001:
2a17 : a5 d3 __ LDA $d3 
; 413, "E:/Apps/oscar64/include/conio.c"
2a19 : 60 __ __ RTS
--------------------------------------------------------------------
putrch: ; putrch(u8)->void
.s0:
2a1a : 85 0d __ STA P0 
; 193, "E:/Apps/oscar64/include/conio.c"
2a1c : a5 0d __ LDA P0 
2a1e : 20 d2 ff JSR $ffd2 
.s1001:
; 196, "E:/Apps/oscar64/include/conio.c"
2a21 : 60 __ __ RTS
--------------------------------------------------------------------
2a22 : __ __ __ BYT 46 69 6c 65 20 73 61 76 65 20 65 72 72 6f 72 21 : File save error!
2a32 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
render_map_viewport: ; render_map_viewport(u8)->void
.s0:
; 140, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a33 : a5 14 __ LDA P7 ; (force_refresh + 0)
2a35 : d0 21 __ BNE $2a58 ; (render_map_viewport.s1 + 0)
.s3:
; 152, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a37 : ad 50 37 LDA $3750 ; (screen_dirty + 0)
2a3a : f0 1b __ BEQ $2a57 ; (render_map_viewport.s1001 + 0)
.s6:
; 157, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a3c : ad 51 37 LDA $3751 ; (last_scroll_direction + 0)
2a3f : 8d e3 9f STA $9fe3 ; (w + 0)
; 160, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a42 : d0 06 __ BNE $2a4a ; (render_map_viewport.s8 + 0)
.s9:
; 165, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a44 : 20 83 2d JSR $2d83 ; (update_full_screen.s0 + 0)
; 171, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a47 : 4c 4f 2a JMP $2a4f ; (render_map_viewport.s1006 + 0)
.s8:
; 162, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a4a : 85 13 __ STA P6 
2a4c : 20 8b 2a JSR $2a8b ; (update_screen_with_perfect_scroll.s0 + 0)
.s1006:
; 170, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a4f : a9 00 __ LDA #$00
2a51 : 8d 51 37 STA $3751 ; (last_scroll_direction + 0)
; 168, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a54 : 8d 50 37 STA $3750 ; (screen_dirty + 0)
.s1001:
; 153, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a57 : 60 __ __ RTS
.s1:
; 142, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a58 : 20 65 0b JSR $0b65 ; (oscar_clrscr.s0 + 0)
; 148, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a5b : a9 00 __ LDA #$00
2a5d : 8d 51 37 STA $3751 ; (last_scroll_direction + 0)
; 147, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a60 : a9 01 __ LDA #$01
2a62 : 8d 50 37 STA $3750 ; (screen_dirty + 0)
; 145, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a65 : a9 20 __ LDA #$20
2a67 : a2 fa __ LDX #$fa
.l1003:
2a69 : ca __ __ DEX
2a6a : 9d 00 04 STA $0400,x 
2a6d : 9d fa 04 STA $04fa,x 
2a70 : 9d f4 05 STA $05f4,x 
2a73 : 9d ee 06 STA $06ee,x 
2a76 : d0 f1 __ BNE $2a69 ; (render_map_viewport.l1003 + 0)
.s1002:
; 146, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a78 : a2 fa __ LDX #$fa
.l1005:
2a7a : ca __ __ DEX
2a7b : 9d 68 33 STA $3368,x ; (screen_buffer + 0)
2a7e : 9d 62 34 STA $3462,x ; (screen_buffer + 250)
2a81 : 9d 5c 35 STA $355c,x ; (screen_buffer + 500)
2a84 : 9d 56 36 STA $3656,x ; (screen_buffer + 750)
2a87 : d0 f1 __ BNE $2a7a ; (render_map_viewport.l1005 + 0)
2a89 : f0 b1 __ BEQ $2a3c ; (render_map_viewport.s6 + 0)
--------------------------------------------------------------------
update_screen_with_perfect_scroll: ; update_screen_with_perfect_scroll(u8)->void
.s0:
; 272, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a8b : a5 13 __ LDA P6 ; (scroll_dir + 0)
2a8d : f0 1c __ BEQ $2aab ; (update_screen_with_perfect_scroll.s1 + 0)
.s4:
2a8f : c9 05 __ CMP #$05
2a91 : b0 18 __ BCS $2aab ; (update_screen_with_perfect_scroll.s1 + 0)
.s3:
; 278, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a93 : c9 03 __ CMP #$03
2a95 : d0 03 __ BNE $2a9a ; (update_screen_with_perfect_scroll.s28 + 0)
2a97 : 4c d2 2c JMP $2cd2 ; (update_screen_with_perfect_scroll.s17 + 0)
.s28:
2a9a : b0 03 __ BCS $2a9f ; (update_screen_with_perfect_scroll.s29 + 0)
2a9c : 4c 58 2b JMP $2b58 ; (update_screen_with_perfect_scroll.s30 + 0)
.s29:
2a9f : c9 04 __ CMP #$04
2aa1 : f0 01 __ BEQ $2aa4 ; (update_screen_with_perfect_scroll.s22 + 0)
.s1001:
; 357, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2aa3 : 60 __ __ RTS
.s22:
; 282, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2aa4 : ad 66 33 LDA $3366 ; (view + 0)
2aa7 : c9 18 __ CMP #$18
2aa9 : 90 03 __ BCC $2aae ; (update_screen_with_perfect_scroll.s70 + 0)
.s1:
; 273, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2aab : 4c 83 2d JMP $2d83 ; (update_full_screen.s0 + 0)
.s70:
; 343, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2aae : 85 51 __ STA T6 + 0 
2ab0 : a9 27 __ LDA #$27
2ab2 : 85 11 __ STA P4 
2ab4 : a9 00 __ LDA #$00
2ab6 : 85 12 __ STA P5 
2ab8 : 8d e8 9f STA $9fe8 ; (attempts + 0)
.l72:
; 344, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2abb : 85 52 __ STA T7 + 0 
2abd : 0a __ __ ASL
2abe : 85 1b __ STA ACCU + 0 
2ac0 : a9 00 __ LDA #$00
2ac2 : 8d e9 9f STA $9fe9 ; (y + 0)
2ac5 : 2a __ __ ROL
2ac6 : 06 1b __ ASL ACCU + 0 
2ac8 : 2a __ __ ROL
2ac9 : aa __ __ TAX
2aca : a5 1b __ LDA ACCU + 0 
2acc : 65 52 __ ADC T7 + 0 
2ace : 85 4f __ STA T3 + 0 
2ad0 : 8a __ __ TXA
2ad1 : 69 00 __ ADC #$00
2ad3 : 06 4f __ ASL T3 + 0 
2ad5 : 2a __ __ ROL
2ad6 : 06 4f __ ASL T3 + 0 
2ad8 : 2a __ __ ROL
2ad9 : 06 4f __ ASL T3 + 0 
2adb : 2a __ __ ROL
2adc : 85 50 __ STA T3 + 1 
2ade : 18 __ __ CLC
2adf : 69 04 __ ADC #$04
2ae1 : 85 4c __ STA T1 + 1 
2ae3 : a6 4f __ LDX T3 + 0 
2ae5 : 86 4b __ STX T1 + 0 
2ae7 : 18 __ __ CLC
.l1014:
; 345, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ae8 : ac e9 9f LDY $9fe9 ; (y + 0)
2aeb : c8 __ __ INY
2aec : b1 4b __ LDA (T1 + 0),y 
2aee : 88 __ __ DEY
2aef : 91 4b __ STA (T1 + 0),y 
; 344, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2af1 : 98 __ __ TYA
2af2 : 69 01 __ ADC #$01
2af4 : 8d e9 9f STA $9fe9 ; (y + 0)
2af7 : c9 27 __ CMP #$27
2af9 : 90 ed __ BCC $2ae8 ; (update_screen_with_perfect_scroll.l1014 + 0)
.s78:
; 348, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2afb : 18 __ __ CLC
2afc : a9 68 __ LDA #$68
2afe : 65 4f __ ADC T3 + 0 
2b00 : 85 4b __ STA T1 + 0 
2b02 : 85 0d __ STA P0 
2b04 : a9 33 __ LDA #$33
2b06 : 65 50 __ ADC T3 + 1 
2b08 : 85 4c __ STA T1 + 1 
2b0a : 85 0e __ STA P1 
2b0c : 8a __ __ TXA
2b0d : 18 __ __ CLC
2b0e : 69 69 __ ADC #$69
2b10 : 85 0f __ STA P2 
2b12 : a5 50 __ LDA T3 + 1 
2b14 : 69 33 __ ADC #$33
2b16 : 85 10 __ STA P3 
2b18 : 20 bd 2e JSR $2ebd ; (memmove.s0 + 0)
; 351, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2b1b : 38 __ __ SEC
2b1c : a5 51 __ LDA T6 + 0 
2b1e : e9 d9 __ SBC #$d9
2b20 : 85 0d __ STA P0 
2b22 : ad 67 33 LDA $3367 ; (view + 1)
2b25 : 18 __ __ CLC
2b26 : 65 52 __ ADC T7 + 0 
2b28 : 85 0e __ STA P1 
2b2a : 20 ed 2d JSR $2ded ; (get_map_tile_fast.s0 + 0)
2b2d : 8d e4 9f STA $9fe4 ; (y + 0)
; 352, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2b30 : 18 __ __ CLC
2b31 : a9 27 __ LDA #$27
2b33 : 65 4f __ ADC T3 + 0 
2b35 : 85 43 __ STA T0 + 0 
2b37 : a9 04 __ LDA #$04
2b39 : 65 50 __ ADC T3 + 1 
2b3b : 85 44 __ STA T0 + 1 
2b3d : ad e4 9f LDA $9fe4 ; (y + 0)
2b40 : a0 00 __ LDY #$00
2b42 : 91 43 __ STA (T0 + 0),y 
; 353, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2b44 : a0 27 __ LDY #$27
2b46 : 91 4b __ STA (T1 + 0),y 
; 343, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2b48 : 18 __ __ CLC
2b49 : a5 52 __ LDA T7 + 0 
2b4b : 69 01 __ ADC #$01
2b4d : 8d e8 9f STA $9fe8 ; (attempts + 0)
2b50 : c9 19 __ CMP #$19
2b52 : b0 03 __ BCS $2b57 ; (update_screen_with_perfect_scroll.s78 + 92)
2b54 : 4c bb 2a JMP $2abb ; (update_screen_with_perfect_scroll.l72 + 0)
2b57 : 60 __ __ RTS
.s30:
; 278, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2b58 : c9 01 __ CMP #$01
2b5a : f0 03 __ BEQ $2b5f ; (update_screen_with_perfect_scroll.s7 + 0)
2b5c : 4c 0f 2c JMP $2c0f ; (update_screen_with_perfect_scroll.s31 + 0)
.s7:
; 279, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2b5f : ad 67 33 LDA $3367 ; (view + 1)
2b62 : d0 03 __ BNE $2b67 ; (update_screen_with_perfect_scroll.s35 + 0)
2b64 : 4c ab 2a JMP $2aab ; (update_screen_with_perfect_scroll.s1 + 0)
.s35:
; 289, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2b67 : 85 51 __ STA T6 + 0 
2b69 : a9 00 __ LDA #$00
2b6b : 85 12 __ STA P5 
2b6d : a9 28 __ LDA #$28
2b6f : 85 11 __ STA P4 
2b71 : a9 18 __ LDA #$18
2b73 : 8d e8 9f STA $9fe8 ; (attempts + 0)
.l37:
; 291, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2b76 : 85 52 __ STA T7 + 0 
2b78 : 0a __ __ ASL
2b79 : 85 1b __ STA ACCU + 0 
2b7b : a9 00 __ LDA #$00
2b7d : 8d e9 9f STA $9fe9 ; (y + 0)
; 292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2b80 : 2a __ __ ROL
2b81 : 06 1b __ ASL ACCU + 0 
2b83 : 2a __ __ ROL
2b84 : aa __ __ TAX
2b85 : a5 1b __ LDA ACCU + 0 
2b87 : 65 52 __ ADC T7 + 0 
2b89 : 85 43 __ STA T0 + 0 
2b8b : 8a __ __ TXA
2b8c : 69 00 __ ADC #$00
2b8e : 06 43 __ ASL T0 + 0 
2b90 : 2a __ __ ROL
2b91 : 06 43 __ ASL T0 + 0 
2b93 : 2a __ __ ROL
2b94 : 06 43 __ ASL T0 + 0 
2b96 : 2a __ __ ROL
2b97 : 85 44 __ STA T0 + 1 
2b99 : 18 __ __ CLC
2b9a : 69 04 __ ADC #$04
2b9c : 85 4e __ STA T2 + 1 
2b9e : 18 __ __ CLC
2b9f : a9 d8 __ LDA #$d8
2ba1 : 65 43 __ ADC T0 + 0 
2ba3 : 85 4b __ STA T1 + 0 
2ba5 : a9 03 __ LDA #$03
2ba7 : 65 44 __ ADC T0 + 1 
2ba9 : 85 4c __ STA T1 + 1 
2bab : a5 43 __ LDA T0 + 0 
2bad : 85 4d __ STA T2 + 0 
.l41:
2baf : ac e9 9f LDY $9fe9 ; (y + 0)
2bb2 : b1 4b __ LDA (T1 + 0),y 
2bb4 : 91 4d __ STA (T2 + 0),y 
; 291, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2bb6 : c8 __ __ INY
2bb7 : 8c e9 9f STY $9fe9 ; (y + 0)
2bba : c0 28 __ CPY #$28
2bbc : 90 f1 __ BCC $2baf ; (update_screen_with_perfect_scroll.l41 + 0)
.s43:
; 295, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2bbe : 18 __ __ CLC
2bbf : a9 68 __ LDA #$68
2bc1 : 65 43 __ ADC T0 + 0 
2bc3 : 85 0d __ STA P0 
2bc5 : a9 33 __ LDA #$33
2bc7 : 65 44 __ ADC T0 + 1 
2bc9 : 85 0e __ STA P1 
2bcb : 18 __ __ CLC
2bcc : a9 40 __ LDA #$40
2bce : 65 43 __ ADC T0 + 0 
2bd0 : 85 0f __ STA P2 
2bd2 : a9 33 __ LDA #$33
2bd4 : 65 44 __ ADC T0 + 1 
2bd6 : 85 10 __ STA P3 
2bd8 : 20 bd 2e JSR $2ebd ; (memmove.s0 + 0)
; 289, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2bdb : 18 __ __ CLC
2bdc : a5 52 __ LDA T7 + 0 
2bde : 69 ff __ ADC #$ff
2be0 : 8d e8 9f STA $9fe8 ; (attempts + 0)
2be3 : c9 01 __ CMP #$01
2be5 : b0 8f __ BCS $2b76 ; (update_screen_with_perfect_scroll.l37 + 0)
.s39:
; 299, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2be7 : 8d e9 9f STA $9fe9 ; (y + 0)
; 300, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2bea : a5 51 __ LDA T6 + 0 
2bec : 85 0e __ STA P1 
.l1010:
2bee : ad e9 9f LDA $9fe9 ; (y + 0)
2bf1 : 85 4f __ STA T3 + 0 
2bf3 : 6d 66 33 ADC $3366 ; (view + 0)
2bf6 : 85 0d __ STA P0 
2bf8 : 20 ed 2d JSR $2ded ; (get_map_tile_fast.s0 + 0)
2bfb : 8d e7 9f STA $9fe7 ; (down_x + 0)
; 301, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2bfe : a6 4f __ LDX T3 + 0 
2c00 : 9d 00 04 STA $0400,x 
; 302, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c03 : 9d 68 33 STA $3368,x ; (screen_buffer + 0)
; 299, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c06 : e8 __ __ INX
2c07 : 8e e9 9f STX $9fe9 ; (y + 0)
2c0a : e0 28 __ CPX #$28
2c0c : 90 e0 __ BCC $2bee ; (update_screen_with_perfect_scroll.l1010 + 0)
2c0e : 60 __ __ RTS
.s31:
; 278, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c0f : c9 02 __ CMP #$02
2c11 : f0 01 __ BEQ $2c14 ; (update_screen_with_perfect_scroll.s12 + 0)
2c13 : 60 __ __ RTS
.s12:
; 280, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c14 : ad 67 33 LDA $3367 ; (view + 1)
2c17 : c9 27 __ CMP #$27
2c19 : 90 03 __ BCC $2c1e ; (update_screen_with_perfect_scroll.s83 + 0)
2c1b : 4c ab 2a JMP $2aab ; (update_screen_with_perfect_scroll.s1 + 0)
.s83:
; 307, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c1e : 85 51 __ STA T6 + 0 
2c20 : a9 28 __ LDA #$28
2c22 : 85 11 __ STA P4 
2c24 : a9 00 __ LDA #$00
2c26 : 85 12 __ STA P5 
2c28 : 8d e8 9f STA $9fe8 ; (attempts + 0)
.l50:
; 309, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c2b : 85 52 __ STA T7 + 0 
2c2d : 0a __ __ ASL
2c2e : 85 1b __ STA ACCU + 0 
2c30 : a9 00 __ LDA #$00
2c32 : 8d e9 9f STA $9fe9 ; (y + 0)
; 310, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c35 : 2a __ __ ROL
2c36 : 06 1b __ ASL ACCU + 0 
2c38 : 2a __ __ ROL
2c39 : aa __ __ TAX
2c3a : a5 1b __ LDA ACCU + 0 
2c3c : 65 52 __ ADC T7 + 0 
2c3e : 85 43 __ STA T0 + 0 
2c40 : 8a __ __ TXA
2c41 : 69 00 __ ADC #$00
2c43 : 06 43 __ ASL T0 + 0 
2c45 : 2a __ __ ROL
2c46 : 06 43 __ ASL T0 + 0 
2c48 : 2a __ __ ROL
2c49 : 06 43 __ ASL T0 + 0 
2c4b : 2a __ __ ROL
2c4c : 85 44 __ STA T0 + 1 
2c4e : 18 __ __ CLC
2c4f : 69 04 __ ADC #$04
2c51 : 85 4c __ STA T1 + 1 
2c53 : a5 43 __ LDA T0 + 0 
2c55 : 85 4b __ STA T1 + 0 
2c57 : 18 __ __ CLC
2c58 : 69 28 __ ADC #$28
2c5a : 85 4d __ STA T2 + 0 
2c5c : a5 44 __ LDA T0 + 1 
2c5e : 69 04 __ ADC #$04
2c60 : 85 4e __ STA T2 + 1 
.l54:
2c62 : ac e9 9f LDY $9fe9 ; (y + 0)
2c65 : b1 4d __ LDA (T2 + 0),y 
2c67 : 91 4b __ STA (T1 + 0),y 
; 309, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c69 : c8 __ __ INY
2c6a : 8c e9 9f STY $9fe9 ; (y + 0)
2c6d : c0 28 __ CPY #$28
2c6f : 90 f1 __ BCC $2c62 ; (update_screen_with_perfect_scroll.l54 + 0)
.s56:
; 313, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c71 : 18 __ __ CLC
2c72 : a9 68 __ LDA #$68
2c74 : 65 43 __ ADC T0 + 0 
2c76 : 85 0d __ STA P0 
2c78 : a9 33 __ LDA #$33
2c7a : 65 44 __ ADC T0 + 1 
2c7c : 85 0e __ STA P1 
2c7e : 18 __ __ CLC
2c7f : a5 43 __ LDA T0 + 0 
2c81 : 69 90 __ ADC #$90
2c83 : 85 0f __ STA P2 
2c85 : a5 44 __ LDA T0 + 1 
2c87 : 69 33 __ ADC #$33
2c89 : 85 10 __ STA P3 
2c8b : 20 bd 2e JSR $2ebd ; (memmove.s0 + 0)
; 307, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c8e : 18 __ __ CLC
2c8f : a5 52 __ LDA T7 + 0 
2c91 : 69 01 __ ADC #$01
2c93 : 8d e8 9f STA $9fe8 ; (attempts + 0)
2c96 : c9 18 __ CMP #$18
2c98 : 90 91 __ BCC $2c2b ; (update_screen_with_perfect_scroll.l50 + 0)
.s52:
; 317, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c9a : a9 c0 __ LDA #$c0
2c9c : 8d ea 9f STA $9fea ; (i + 0)
2c9f : a9 03 __ LDA #$03
2ca1 : 8d eb 9f STA $9feb ; (screen_offset + 1)
; 318, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ca4 : a9 00 __ LDA #$00
2ca6 : 8d e9 9f STA $9fe9 ; (y + 0)
; 319, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ca9 : 18 __ __ CLC
.l1012:
2caa : ad e9 9f LDA $9fe9 ; (y + 0)
2cad : 85 4f __ STA T3 + 0 
2caf : 6d 66 33 ADC $3366 ; (view + 0)
2cb2 : 85 0d __ STA P0 
2cb4 : 38 __ __ SEC
2cb5 : a5 51 __ LDA T6 + 0 
2cb7 : e9 e8 __ SBC #$e8
2cb9 : 85 0e __ STA P1 
2cbb : 20 ed 2d JSR $2ded ; (get_map_tile_fast.s0 + 0)
2cbe : 8d e6 9f STA $9fe6 ; (i + 0)
; 320, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2cc1 : a6 4f __ LDX T3 + 0 
2cc3 : 9d c0 07 STA $07c0,x 
; 321, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2cc6 : 9d 28 37 STA $3728,x ; (screen_buffer + 960)
; 318, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2cc9 : e8 __ __ INX
2cca : 8e e9 9f STX $9fe9 ; (y + 0)
2ccd : e0 28 __ CPX #$28
2ccf : 90 d9 __ BCC $2caa ; (update_screen_with_perfect_scroll.l1012 + 0)
2cd1 : 60 __ __ RTS
.s17:
; 281, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2cd2 : ad 66 33 LDA $3366 ; (view + 0)
2cd5 : d0 03 __ BNE $2cda ; (update_screen_with_perfect_scroll.s61 + 0)
2cd7 : 4c ab 2a JMP $2aab ; (update_screen_with_perfect_scroll.s1 + 0)
.s61:
; 327, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2cda : 85 51 __ STA T6 + 0 
2cdc : a9 00 __ LDA #$00
2cde : 8d e8 9f STA $9fe8 ; (attempts + 0)
; 332, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ce1 : 85 12 __ STA P5 
2ce3 : a9 27 __ LDA #$27
2ce5 : 85 11 __ STA P4 
.l63:
; 328, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ce7 : ad e8 9f LDA $9fe8 ; (attempts + 0)
2cea : 85 52 __ STA T7 + 0 
2cec : 85 4d __ STA T2 + 0 
2cee : 0a __ __ ASL
2cef : 85 1b __ STA ACCU + 0 
2cf1 : a9 27 __ LDA #$27
2cf3 : 8d e9 9f STA $9fe9 ; (y + 0)
; 329, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2cf6 : a9 00 __ LDA #$00
2cf8 : 2a __ __ ROL
2cf9 : 06 1b __ ASL ACCU + 0 
2cfb : 2a __ __ ROL
2cfc : aa __ __ TAX
2cfd : a5 1b __ LDA ACCU + 0 
2cff : 65 4d __ ADC T2 + 0 
2d01 : 85 4f __ STA T3 + 0 
2d03 : 8a __ __ TXA
2d04 : 69 00 __ ADC #$00
2d06 : 06 4f __ ASL T3 + 0 
2d08 : 2a __ __ ROL
2d09 : 06 4f __ ASL T3 + 0 
2d0b : 2a __ __ ROL
2d0c : 06 4f __ ASL T3 + 0 
2d0e : 2a __ __ ROL
2d0f : 85 50 __ STA T3 + 1 
2d11 : 18 __ __ CLC
2d12 : a9 ff __ LDA #$ff
2d14 : 65 4f __ ADC T3 + 0 
2d16 : 85 43 __ STA T0 + 0 
2d18 : a9 03 __ LDA #$03
2d1a : 65 50 __ ADC T3 + 1 
2d1c : 85 44 __ STA T0 + 1 
.l67:
2d1e : ac e9 9f LDY $9fe9 ; (y + 0)
2d21 : b1 43 __ LDA (T0 + 0),y 
2d23 : c8 __ __ INY
2d24 : 91 43 __ STA (T0 + 0),y 
; 328, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d26 : 98 __ __ TYA
2d27 : 18 __ __ CLC
2d28 : 69 fe __ ADC #$fe
2d2a : 8d e9 9f STA $9fe9 ; (y + 0)
2d2d : c9 01 __ CMP #$01
2d2f : b0 ed __ BCS $2d1e ; (update_screen_with_perfect_scroll.l67 + 0)
.s69:
; 332, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d31 : a9 68 __ LDA #$68
2d33 : 65 4f __ ADC T3 + 0 
2d35 : 85 0f __ STA P2 
2d37 : a9 33 __ LDA #$33
2d39 : 65 50 __ ADC T3 + 1 
2d3b : 85 10 __ STA P3 
2d3d : 18 __ __ CLC
2d3e : a5 4f __ LDA T3 + 0 
2d40 : 69 69 __ ADC #$69
2d42 : 85 0d __ STA P0 
2d44 : a5 50 __ LDA T3 + 1 
2d46 : 69 33 __ ADC #$33
2d48 : 85 0e __ STA P1 
2d4a : 20 bd 2e JSR $2ebd ; (memmove.s0 + 0)
; 335, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d4d : a5 51 __ LDA T6 + 0 
2d4f : 85 0d __ STA P0 
2d51 : ad 67 33 LDA $3367 ; (view + 1)
2d54 : 18 __ __ CLC
2d55 : 65 4d __ ADC T2 + 0 
2d57 : 85 0e __ STA P1 
2d59 : 20 ed 2d JSR $2ded ; (get_map_tile_fast.s0 + 0)
2d5c : 8d e5 9f STA $9fe5 ; (x + 0)
; 336, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d5f : a5 4f __ LDA T3 + 0 
2d61 : 85 43 __ STA T0 + 0 
2d63 : 18 __ __ CLC
2d64 : a9 04 __ LDA #$04
2d66 : 65 50 __ ADC T3 + 1 
2d68 : 85 44 __ STA T0 + 1 
2d6a : ad e5 9f LDA $9fe5 ; (x + 0)
2d6d : a0 00 __ LDY #$00
2d6f : 91 43 __ STA (T0 + 0),y 
; 337, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d71 : 91 0f __ STA (P2),y 
; 327, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d73 : 18 __ __ CLC
2d74 : a5 52 __ LDA T7 + 0 
2d76 : 69 01 __ ADC #$01
2d78 : 8d e8 9f STA $9fe8 ; (attempts + 0)
2d7b : c9 19 __ CMP #$19
2d7d : b0 03 __ BCS $2d82 ; (update_screen_with_perfect_scroll.s69 + 81)
2d7f : 4c e7 2c JMP $2ce7 ; (update_screen_with_perfect_scroll.l63 + 0)
2d82 : 60 __ __ RTS
--------------------------------------------------------------------
update_full_screen: ; update_full_screen()->void
.s0:
; 361, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d83 : a9 00 __ LDA #$00
2d85 : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
.l2:
; 364, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d88 : 85 49 __ STA T6 + 0 
2d8a : 0a __ __ ASL
2d8b : 0a __ __ ASL
2d8c : 65 49 __ ADC T6 + 0 
2d8e : 0a __ __ ASL
2d8f : 0a __ __ ASL
2d90 : 85 43 __ STA T0 + 0 
2d92 : a9 00 __ LDA #$00
2d94 : 8d ed 9f STA $9fed ; (extra_range_y + 0)
; 362, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d97 : 2a __ __ ROL
2d98 : 06 43 __ ASL T0 + 0 
2d9a : 2a __ __ ROL
2d9b : 8d ef 9f STA $9fef ; (screen_pos + 1)
2d9e : a5 43 __ LDA T0 + 0 
2da0 : 85 47 __ STA T3 + 0 
2da2 : 8d ee 9f STA $9fee ; (entropy4 + 1)
; 365, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2da5 : a9 04 __ LDA #$04
2da7 : 6d ef 9f ADC $9fef ; (screen_pos + 1)
2daa : 85 48 __ STA T3 + 1 
2dac : 18 __ __ CLC
2dad : a9 68 __ LDA #$68
2daf : 65 43 __ ADC T0 + 0 
2db1 : 85 45 __ STA T2 + 0 
2db3 : a9 33 __ LDA #$33
2db5 : 6d ef 9f ADC $9fef ; (screen_pos + 1)
2db8 : 85 46 __ STA T2 + 1 
2dba : 18 __ __ CLC
.l1002:
2dbb : ad ed 9f LDA $9fed ; (extra_range_y + 0)
2dbe : 85 4a __ STA T7 + 0 
2dc0 : 6d 66 33 ADC $3366 ; (view + 0)
2dc3 : 85 0d __ STA P0 
2dc5 : ad 67 33 LDA $3367 ; (view + 1)
2dc8 : 18 __ __ CLC
2dc9 : 65 49 __ ADC T6 + 0 
2dcb : 85 0e __ STA P1 
2dcd : 20 ed 2d JSR $2ded ; (get_map_tile_fast.s0 + 0)
2dd0 : 8d ec 9f STA $9fec ; (random_offset_x + 0)
; 369, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2dd3 : a4 4a __ LDY T7 + 0 
2dd5 : 91 47 __ STA (T3 + 0),y 
; 370, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2dd7 : 91 45 __ STA (T2 + 0),y 
; 364, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2dd9 : c8 __ __ INY
2dda : 8c ed 9f STY $9fed ; (extra_range_y + 0)
2ddd : c0 28 __ CPY #$28
2ddf : 90 da __ BCC $2dbb ; (update_full_screen.l1002 + 0)
.s3:
; 361, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2de1 : a5 49 __ LDA T6 + 0 
2de3 : 69 00 __ ADC #$00
2de5 : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
2de8 : c9 19 __ CMP #$19
2dea : 90 9c __ BCC $2d88 ; (update_full_screen.l2 + 0)
.s1001:
; 373, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2dec : 60 __ __ RTS
--------------------------------------------------------------------
get_map_tile_fast: ; get_map_tile_fast(u8,u8)->u8
.s0:
; 105, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ded : a5 0d __ LDA P0 ; (map_x + 0)
2def : c9 40 __ CMP #$40
2df1 : b0 06 __ BCS $2df9 ; (get_map_tile_fast.s1 + 0)
.s4:
2df3 : a5 0e __ LDA P1 ; (map_y + 0)
2df5 : c9 40 __ CMP #$40
2df7 : 90 03 __ BCC $2dfc ; (get_map_tile_fast.s3 + 0)
.s1:
; 106, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2df9 : a9 20 __ LDA #$20
.s1001:
2dfb : 60 __ __ RTS
.s3:
; 117, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2dfc : 85 1c __ STA ACCU + 1 
2dfe : 4a __ __ LSR
2dff : aa __ __ TAX
2e00 : a9 00 __ LDA #$00
2e02 : 6a __ __ ROR
2e03 : 85 43 __ STA T1 + 0 
2e05 : a9 00 __ LDA #$00
2e07 : 46 1c __ LSR ACCU + 1 
2e09 : 6a __ __ ROR
2e0a : 66 1c __ ROR ACCU + 1 
2e0c : 6a __ __ ROR
2e0d : 65 43 __ ADC T1 + 0 
2e0f : a8 __ __ TAY
2e10 : 8a __ __ TXA
2e11 : 65 1c __ ADC ACCU + 1 
2e13 : aa __ __ TAX
2e14 : 98 __ __ TYA
2e15 : 18 __ __ CLC
2e16 : 65 0d __ ADC P0 ; (map_x + 0)
2e18 : 90 01 __ BCC $2e1b ; (get_map_tile_fast.s1014 + 0)
.s1013:
; 110, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e1a : e8 __ __ INX
.s1014:
2e1b : 18 __ __ CLC
2e1c : 65 0d __ ADC P0 ; (map_x + 0)
2e1e : 90 01 __ BCC $2e21 ; (get_map_tile_fast.s1016 + 0)
.s1015:
; 110, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e20 : e8 __ __ INX
.s1016:
2e21 : 18 __ __ CLC
2e22 : 65 0d __ ADC P0 ; (map_x + 0)
2e24 : 8d f8 9f STA $9ff8 ; (room + 1)
2e27 : 8a __ __ TXA
2e28 : 69 00 __ ADC #$00
2e2a : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 111, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e2d : 4a __ __ LSR
2e2e : 85 44 __ STA T1 + 1 
2e30 : ad f8 9f LDA $9ff8 ; (room + 1)
2e33 : 6a __ __ ROR
2e34 : 46 44 __ LSR T1 + 1 
2e36 : 6a __ __ ROR
2e37 : 46 44 __ LSR T1 + 1 
2e39 : 6a __ __ ROR
2e3a : 18 __ __ CLC
2e3b : 69 52 __ ADC #$52
2e3d : 85 43 __ STA T1 + 0 
2e3f : 8d f6 9f STA $9ff6 ; (d + 0)
2e42 : a9 37 __ LDA #$37
2e44 : 65 44 __ ADC T1 + 1 
2e46 : 85 44 __ STA T1 + 1 
2e48 : 8d f7 9f STA $9ff7 ; (d + 1)
; 112, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e4b : ad f8 9f LDA $9ff8 ; (room + 1)
2e4e : 29 07 __ AND #$07
2e50 : 85 1b __ STA ACCU + 0 
2e52 : 8d f5 9f STA $9ff5 ; (s + 1)
; 117, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e55 : aa __ __ TAX
2e56 : a0 00 __ LDY #$00
2e58 : b1 43 __ LDA (T1 + 0),y 
2e5a : e0 00 __ CPX #$00
2e5c : f0 04 __ BEQ $2e62 ; (get_map_tile_fast.s1003 + 0)
.l1002:
; 117, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e5e : 4a __ __ LSR
2e5f : ca __ __ DEX
2e60 : d0 fc __ BNE $2e5e ; (get_map_tile_fast.l1002 + 0)
.s1003:
; 115, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e62 : 85 1c __ STA ACCU + 1 
2e64 : a5 1b __ LDA ACCU + 0 
2e66 : c9 06 __ CMP #$06
2e68 : a5 1c __ LDA ACCU + 1 
2e6a : 90 23 __ BCC $2e8f ; (get_map_tile_fast.s30 + 0)
.s7:
; 121, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e6c : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
; 120, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e6f : a9 08 __ LDA #$08
2e71 : e5 1b __ SBC ACCU + 0 
2e73 : 8d f3 9f STA $9ff3 ; (room1_buffer_x1 + 0)
; 122, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e76 : aa __ __ TAX
2e77 : bd 50 33 LDA $3350,x ; (bitshift + 36)
2e7a : 38 __ __ SEC
2e7b : e9 01 __ SBC #$01
2e7d : a0 01 __ LDY #$01
2e7f : 31 43 __ AND (T1 + 0),y 
2e81 : ae f3 9f LDX $9ff3 ; (room1_buffer_x1 + 0)
2e84 : f0 04 __ BEQ $2e8a ; (get_map_tile_fast.s1005 + 0)
.l1006:
2e86 : 0a __ __ ASL
2e87 : ca __ __ DEX
2e88 : d0 fc __ BNE $2e86 ; (get_map_tile_fast.l1006 + 0)
.s1005:
; 122, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e8a : 8d f1 9f STA $9ff1 ; (cell_h + 0)
; 123, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e8d : 05 1c __ ORA ACCU + 1 
.s30:
2e8f : 29 07 __ AND #$07
2e91 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e94 : c9 03 __ CMP #$03
2e96 : d0 03 __ BNE $2e9b ; (get_map_tile_fast.s19 + 0)
.s13:
; 130, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e98 : a9 2b __ LDA #$2b
2e9a : 60 __ __ RTS
.s19:
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e9b : 90 11 __ BCC $2eae ; (get_map_tile_fast.s21 + 0)
.s20:
2e9d : c9 04 __ CMP #$04
2e9f : d0 03 __ BNE $2ea4 ; (get_map_tile_fast.s25 + 0)
.s14:
; 131, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ea1 : a9 3c __ LDA #$3c
2ea3 : 60 __ __ RTS
.s25:
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ea4 : c9 05 __ CMP #$05
2ea6 : f0 03 __ BEQ $2eab ; (get_map_tile_fast.s15 + 0)
2ea8 : 4c f9 2d JMP $2df9 ; (get_map_tile_fast.s1 + 0)
.s15:
; 132, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2eab : a9 3e __ LDA #$3e
2ead : 60 __ __ RTS
.s21:
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2eae : c9 01 __ CMP #$01
2eb0 : d0 03 __ BNE $2eb5 ; (get_map_tile_fast.s22 + 0)
.s11:
; 128, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2eb2 : a9 23 __ LDA #$23
2eb4 : 60 __ __ RTS
.s22:
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2eb5 : 8a __ __ TXA
2eb6 : 69 ff __ ADC #$ff
2eb8 : 29 0e __ AND #$0e
2eba : 49 2e __ EOR #$2e
2ebc : 60 __ __ RTS
--------------------------------------------------------------------
memmove: ; memmove(void*,const void*,i16)->void*
.s0:
; 237, "E:/Apps/oscar64/include/string.c"
2ebd : a5 11 __ LDA P4 ; (size + 0)
2ebf : 8d f8 9f STA $9ff8 ; (room + 1)
2ec2 : a6 0e __ LDX P1 ; (dst + 1)
2ec4 : a5 12 __ LDA P5 ; (size + 1)
2ec6 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 238, "E:/Apps/oscar64/include/string.c"
2ec9 : 10 03 __ BPL $2ece ; (memmove.s1006 + 0)
2ecb : 4c 69 2f JMP $2f69 ; (memmove.s3 + 0)
.s1006:
2ece : 05 11 __ ORA P4 ; (size + 0)
2ed0 : f0 f9 __ BEQ $2ecb ; (memmove.s0 + 14)
.s1:
; 240, "E:/Apps/oscar64/include/string.c"
2ed2 : 8e f7 9f STX $9ff7 ; (d + 1)
2ed5 : a5 0d __ LDA P0 ; (dst + 0)
2ed7 : 8d f6 9f STA $9ff6 ; (d + 0)
; 241, "E:/Apps/oscar64/include/string.c"
2eda : a5 0f __ LDA P2 ; (src + 0)
2edc : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
2edf : a5 10 __ LDA P3 ; (src + 1)
2ee1 : 8d f5 9f STA $9ff5 ; (s + 1)
; 242, "E:/Apps/oscar64/include/string.c"
2ee4 : e4 10 __ CPX P3 ; (src + 1)
2ee6 : d0 05 __ BNE $2eed ; (memmove.s1005 + 0)
.s1004:
2ee8 : a5 0d __ LDA P0 ; (dst + 0)
2eea : cd f4 9f CMP $9ff4 ; (entropy1 + 1)
.s1005:
2eed : b0 04 __ BCS $2ef3 ; (memmove.s5 + 0)
.s7:
; 246, "E:/Apps/oscar64/include/string.c"
2eef : a0 00 __ LDY #$00
2ef1 : 90 7d __ BCC $2f70 ; (memmove.l1007 + 0)
.s5:
; 248, "E:/Apps/oscar64/include/string.c"
2ef3 : ad f5 9f LDA $9ff5 ; (s + 1)
2ef6 : cd f7 9f CMP $9ff7 ; (d + 1)
2ef9 : d0 06 __ BNE $2f01 ; (memmove.s1003 + 0)
.s1002:
2efb : ad f4 9f LDA $9ff4 ; (entropy1 + 1)
2efe : cd f6 9f CMP $9ff6 ; (d + 0)
.s1003:
2f01 : b0 66 __ BCS $2f69 ; (memmove.s3 + 0)
.s9:
; 251, "E:/Apps/oscar64/include/string.c"
2f03 : ad f4 9f LDA $9ff4 ; (entropy1 + 1)
2f06 : 18 __ __ CLC
2f07 : 65 11 __ ADC P4 ; (size + 0)
2f09 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
2f0c : ad f5 9f LDA $9ff5 ; (s + 1)
2f0f : 6d f9 9f ADC $9ff9 ; (bit_offset + 1)
2f12 : 8d f5 9f STA $9ff5 ; (s + 1)
; 250, "E:/Apps/oscar64/include/string.c"
2f15 : ad f6 9f LDA $9ff6 ; (d + 0)
2f18 : 18 __ __ CLC
2f19 : 65 11 __ ADC P4 ; (size + 0)
2f1b : 8d f6 9f STA $9ff6 ; (d + 0)
2f1e : ad f7 9f LDA $9ff7 ; (d + 1)
2f21 : 6d f9 9f ADC $9ff9 ; (bit_offset + 1)
2f24 : 8d f7 9f STA $9ff7 ; (d + 1)
; 253, "E:/Apps/oscar64/include/string.c"
2f27 : a0 00 __ LDY #$00
.l1009:
2f29 : ad f4 9f LDA $9ff4 ; (entropy1 + 1)
2f2c : 18 __ __ CLC
2f2d : 69 ff __ ADC #$ff
2f2f : 85 1b __ STA ACCU + 0 
2f31 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
2f34 : ad f5 9f LDA $9ff5 ; (s + 1)
2f37 : 69 ff __ ADC #$ff
2f39 : 85 1c __ STA ACCU + 1 
2f3b : 8d f5 9f STA $9ff5 ; (s + 1)
2f3e : ad f6 9f LDA $9ff6 ; (d + 0)
2f41 : 18 __ __ CLC
2f42 : 69 ff __ ADC #$ff
2f44 : 85 43 __ STA T1 + 0 
2f46 : 8d f6 9f STA $9ff6 ; (d + 0)
2f49 : ad f7 9f LDA $9ff7 ; (d + 1)
2f4c : 69 ff __ ADC #$ff
2f4e : 85 44 __ STA T1 + 1 
2f50 : 8d f7 9f STA $9ff7 ; (d + 1)
2f53 : b1 1b __ LDA (ACCU + 0),y 
2f55 : 91 43 __ STA (T1 + 0),y 
; 254, "E:/Apps/oscar64/include/string.c"
2f57 : ad f8 9f LDA $9ff8 ; (room + 1)
2f5a : d0 03 __ BNE $2f5f ; (memmove.s1017 + 0)
.s1016:
; 254, "E:/Apps/oscar64/include/string.c"
2f5c : ce f9 9f DEC $9ff9 ; (bit_offset + 1)
.s1017:
2f5f : ce f8 9f DEC $9ff8 ; (room + 1)
2f62 : d0 c5 __ BNE $2f29 ; (memmove.l1009 + 0)
.s1018:
; 254, "E:/Apps/oscar64/include/string.c"
2f64 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
2f67 : d0 c0 __ BNE $2f29 ; (memmove.l1009 + 0)
.s3:
; 257, "E:/Apps/oscar64/include/string.c"
2f69 : 86 1c __ STX ACCU + 1 
2f6b : a5 0d __ LDA P0 ; (dst + 0)
2f6d : 85 1b __ STA ACCU + 0 
.s1001:
2f6f : 60 __ __ RTS
.l1007:
; 245, "E:/Apps/oscar64/include/string.c"
2f70 : ad f4 9f LDA $9ff4 ; (entropy1 + 1)
2f73 : 85 1b __ STA ACCU + 0 
2f75 : 18 __ __ CLC
2f76 : 69 01 __ ADC #$01
2f78 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
2f7b : ad f5 9f LDA $9ff5 ; (s + 1)
2f7e : 85 1c __ STA ACCU + 1 
2f80 : 69 00 __ ADC #$00
2f82 : 8d f5 9f STA $9ff5 ; (s + 1)
2f85 : ad f6 9f LDA $9ff6 ; (d + 0)
2f88 : 85 43 __ STA T1 + 0 
2f8a : ad f7 9f LDA $9ff7 ; (d + 1)
2f8d : 85 44 __ STA T1 + 1 
2f8f : b1 1b __ LDA (ACCU + 0),y 
2f91 : 91 43 __ STA (T1 + 0),y 
2f93 : 18 __ __ CLC
2f94 : a5 43 __ LDA T1 + 0 
2f96 : 69 01 __ ADC #$01
2f98 : 8d f6 9f STA $9ff6 ; (d + 0)
2f9b : a5 44 __ LDA T1 + 1 
2f9d : 69 00 __ ADC #$00
2f9f : 8d f7 9f STA $9ff7 ; (d + 1)
; 246, "E:/Apps/oscar64/include/string.c"
2fa2 : ad f8 9f LDA $9ff8 ; (room + 1)
2fa5 : d0 03 __ BNE $2faa ; (memmove.s1014 + 0)
.s1013:
; 246, "E:/Apps/oscar64/include/string.c"
2fa7 : ce f9 9f DEC $9ff9 ; (bit_offset + 1)
.s1014:
2faa : ce f8 9f DEC $9ff8 ; (room + 1)
2fad : d0 c1 __ BNE $2f70 ; (memmove.l1007 + 0)
.s1015:
; 246, "E:/Apps/oscar64/include/string.c"
2faf : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
2fb2 : d0 bc __ BNE $2f70 ; (memmove.l1007 + 0)
2fb4 : f0 b3 __ BEQ $2f69 ; (memmove.s3 + 0)
--------------------------------------------------------------------
getch: ; getch()->u8
.l1:
; 320, "E:/Apps/oscar64/include/conio.c"
2fb6 : 20 e4 ff JSR $ffe4 
2fb9 : 85 1b __ STA ACCU + 0 
2fbb : a5 1b __ LDA ACCU + 0 
; 319, "E:/Apps/oscar64/include/conio.c"
2fbd : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 323, "E:/Apps/oscar64/include/conio.c"
2fc0 : f0 f4 __ BEQ $2fb6 ; (getch.l1 + 0)
.s2:
; 325, "E:/Apps/oscar64/include/conio.c"
2fc2 : 4c c5 2f JMP $2fc5 ; (convch.s0 + 0)
--------------------------------------------------------------------
convch: ; convch(u8)->u8
.s0:
2fc5 : a8 __ __ TAY
; 246, "E:/Apps/oscar64/include/conio.c"
2fc6 : ad 2b 33 LDA $332b ; (giocharmap + 0)
2fc9 : f0 27 __ BEQ $2ff2 ; (convch.s3 + 0)
.s1:
; 248, "E:/Apps/oscar64/include/conio.c"
2fcb : c0 0d __ CPY #$0d
2fcd : d0 03 __ BNE $2fd2 ; (convch.s5 + 0)
.s4:
; 263, "E:/Apps/oscar64/include/conio.c"
2fcf : a9 0a __ LDA #$0a
.s1001:
2fd1 : 60 __ __ RTS
.s5:
; 250, "E:/Apps/oscar64/include/conio.c"
2fd2 : c9 02 __ CMP #$02
2fd4 : 90 1c __ BCC $2ff2 ; (convch.s3 + 0)
.s7:
; 252, "E:/Apps/oscar64/include/conio.c"
2fd6 : 98 __ __ TYA
2fd7 : c0 41 __ CPY #$41
2fd9 : 90 17 __ BCC $2ff2 ; (convch.s3 + 0)
.s13:
2fdb : c9 db __ CMP #$db
2fdd : b0 13 __ BCS $2ff2 ; (convch.s3 + 0)
.s10:
; 254, "E:/Apps/oscar64/include/conio.c"
2fdf : c9 c1 __ CMP #$c1
2fe1 : 90 03 __ BCC $2fe6 ; (convch.s16 + 0)
.s14:
; 255, "E:/Apps/oscar64/include/conio.c"
2fe3 : 49 a0 __ EOR #$a0
2fe5 : a8 __ __ TAY
.s16:
; 256, "E:/Apps/oscar64/include/conio.c"
2fe6 : c9 7b __ CMP #$7b
2fe8 : b0 08 __ BCS $2ff2 ; (convch.s3 + 0)
.s20:
2fea : c9 61 __ CMP #$61
2fec : b0 06 __ BCS $2ff4 ; (convch.s17 + 0)
.s21:
2fee : c9 5b __ CMP #$5b
2ff0 : 90 02 __ BCC $2ff4 ; (convch.s17 + 0)
.s3:
; 263, "E:/Apps/oscar64/include/conio.c"
2ff2 : 98 __ __ TYA
2ff3 : 60 __ __ RTS
.s17:
; 257, "E:/Apps/oscar64/include/conio.c"
2ff4 : 49 20 __ EOR #$20
2ff6 : 60 __ __ RTS
--------------------------------------------------------------------
process_navigation_input: ; process_navigation_input(u8)->void
.s0:
; 179, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ff7 : ad 66 33 LDA $3366 ; (view + 0)
2ffa : 85 44 __ STA T3 + 0 
2ffc : 8d f5 9f STA $9ff5 ; (s + 1)
; 183, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2fff : a9 00 __ LDA #$00
3001 : 8d f1 9f STA $9ff1 ; (cell_h + 0)
; 180, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3004 : ad 67 33 LDA $3367 ; (view + 1)
3007 : 85 45 __ STA T4 + 0 
3009 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
; 181, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
300c : ad 64 33 LDA $3364 ; (camera_center_x + 0)
300f : 85 43 __ STA T2 + 0 
3011 : 8d f3 9f STA $9ff3 ; (room1_buffer_x1 + 0)
; 182, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3014 : ad 65 33 LDA $3365 ; (camera_center_y + 0)
3017 : 85 46 __ STA T5 + 0 
3019 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
; 186, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
301c : a5 0d __ LDA P0 ; (key + 0)
301e : c9 61 __ CMP #$61
3020 : d0 03 __ BNE $3025 ; (process_navigation_input.s19 + 0)
3022 : 4c ee 30 JMP $30ee ; (process_navigation_input.s10 + 0)
.s19:
3025 : b0 03 __ BCS $302a ; (process_navigation_input.s20 + 0)
3027 : 4c dc 30 JMP $30dc ; (process_navigation_input.s21 + 0)
.s20:
302a : c9 73 __ CMP #$73
302c : d0 03 __ BNE $3031 ; (process_navigation_input.s28 + 0)
302e : 4c d1 30 JMP $30d1 ; (process_navigation_input.s6 + 0)
.s28:
3031 : b0 03 __ BCS $3036 ; (process_navigation_input.s29 + 0)
3033 : 4c bf 30 JMP $30bf ; (process_navigation_input.s30 + 0)
.s29:
3036 : c9 77 __ CMP #$77
3038 : d0 41 __ BNE $307b ; (process_navigation_input.s1001 + 0)
.s2:
; 189, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
303a : a5 46 __ LDA T5 + 0 
303c : f0 3d __ BEQ $307b ; (process_navigation_input.s1001 + 0)
.s3:
; 190, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
303e : 69 fe __ ADC #$fe
.s70:
; 198, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3040 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
.s33:
; 207, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3043 : a9 01 __ LDA #$01
3045 : 8d f1 9f STA $9ff1 ; (cell_h + 0)
; 222, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3048 : a5 43 __ LDA T2 + 0 
304a : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
; 223, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
304d : a5 46 __ LDA T5 + 0 
304f : 8d ef 9f STA $9fef ; (screen_pos + 1)
; 225, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3052 : ad f3 9f LDA $9ff3 ; (room1_buffer_x1 + 0)
3055 : 8d 64 33 STA $3364 ; (camera_center_x + 0)
; 226, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3058 : ad f2 9f LDA $9ff2 ; (entropy2 + 1)
305b : 8d 65 33 STA $3365 ; (camera_center_y + 0)
; 227, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
305e : 20 fe 17 JSR $17fe ; (update_camera.s0 + 0)
; 231, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3061 : a5 44 __ LDA T3 + 0 
3063 : cd 66 33 CMP $3366 ; (view + 0)
3066 : d0 07 __ BNE $306f ; (process_navigation_input.s36 + 0)
.s39:
3068 : a5 45 __ LDA T4 + 0 
306a : cd 67 33 CMP $3367 ; (view + 1)
306d : f0 32 __ BEQ $30a1 ; (process_navigation_input.s37 + 0)
.s36:
; 233, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
306f : ad 67 33 LDA $3367 ; (view + 1)
3072 : c5 45 __ CMP T4 + 0 
3074 : b0 06 __ BCS $307c ; (process_navigation_input.s41 + 0)
.s40:
; 234, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3076 : a9 01 __ LDA #$01
.s1002:
3078 : 8d 51 37 STA $3751 ; (last_scroll_direction + 0)
.s1001:
; 260, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
307b : 60 __ __ RTS
.s41:
; 235, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
307c : a5 45 __ LDA T4 + 0 
307e : cd 67 33 CMP $3367 ; (view + 1)
3081 : b0 04 __ BCS $3087 ; (process_navigation_input.s44 + 0)
.s43:
; 236, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3083 : a9 02 __ LDA #$02
3085 : 90 f1 __ BCC $3078 ; (process_navigation_input.s1002 + 0)
.s44:
; 237, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3087 : ad 66 33 LDA $3366 ; (view + 0)
308a : c5 44 __ CMP T3 + 0 
308c : b0 04 __ BCS $3092 ; (process_navigation_input.s47 + 0)
.s46:
; 238, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
308e : a9 03 __ LDA #$03
3090 : 90 e6 __ BCC $3078 ; (process_navigation_input.s1002 + 0)
.s47:
; 239, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3092 : a5 44 __ LDA T3 + 0 
3094 : cd 66 33 CMP $3366 ; (view + 0)
3097 : b0 04 __ BCS $309d ; (process_navigation_input.s50 + 0)
.s49:
; 240, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3099 : a9 04 __ LDA #$04
309b : 90 db __ BCC $3078 ; (process_navigation_input.s1002 + 0)
.s50:
; 242, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
309d : a9 00 __ LDA #$00
309f : b0 d7 __ BCS $3078 ; (process_navigation_input.s1002 + 0)
.s37:
; 247, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30a1 : ad 65 33 LDA $3365 ; (camera_center_y + 0)
30a4 : c5 46 __ CMP T5 + 0 
30a6 : 90 ce __ BCC $3076 ; (process_navigation_input.s40 + 0)
.s53:
; 249, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30a8 : a5 46 __ LDA T5 + 0 
30aa : cd 65 33 CMP $3365 ; (camera_center_y + 0)
30ad : 90 d4 __ BCC $3083 ; (process_navigation_input.s43 + 0)
.s56:
; 251, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30af : ad 64 33 LDA $3364 ; (camera_center_x + 0)
30b2 : c5 43 __ CMP T2 + 0 
30b4 : 90 d8 __ BCC $308e ; (process_navigation_input.s46 + 0)
.s59:
; 253, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30b6 : a5 43 __ LDA T2 + 0 
30b8 : cd 64 33 CMP $3364 ; (camera_center_x + 0)
30bb : b0 e0 __ BCS $309d ; (process_navigation_input.s50 + 0)
30bd : 90 da __ BCC $3099 ; (process_navigation_input.s49 + 0)
.s30:
; 186, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30bf : c9 64 __ CMP #$64
30c1 : d0 b8 __ BNE $307b ; (process_navigation_input.s1001 + 0)
.s14:
; 213, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30c3 : a5 43 __ LDA T2 + 0 
30c5 : c9 3f __ CMP #$3f
30c7 : b0 b2 __ BCS $307b ; (process_navigation_input.s1001 + 0)
.s15:
; 214, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30c9 : 69 01 __ ADC #$01
.s71:
30cb : 8d f3 9f STA $9ff3 ; (room1_buffer_x1 + 0)
30ce : 4c 43 30 JMP $3043 ; (process_navigation_input.s33 + 0)
.s6:
; 197, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30d1 : a5 46 __ LDA T5 + 0 
30d3 : c9 3f __ CMP #$3f
30d5 : b0 a4 __ BCS $307b ; (process_navigation_input.s1001 + 0)
.s7:
; 198, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30d7 : 69 01 __ ADC #$01
30d9 : 4c 40 30 JMP $3040 ; (process_navigation_input.s70 + 0)
.s21:
; 186, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30dc : c9 53 __ CMP #$53
30de : f0 f1 __ BEQ $30d1 ; (process_navigation_input.s6 + 0)
.s22:
30e0 : 90 08 __ BCC $30ea ; (process_navigation_input.s24 + 0)
.s23:
30e2 : c9 57 __ CMP #$57
30e4 : d0 03 __ BNE $30e9 ; (process_navigation_input.s23 + 7)
30e6 : 4c 3a 30 JMP $303a ; (process_navigation_input.s2 + 0)
30e9 : 60 __ __ RTS
.s24:
30ea : c9 41 __ CMP #$41
30ec : d0 09 __ BNE $30f7 ; (process_navigation_input.s25 + 0)
.s10:
; 205, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30ee : a5 43 __ LDA T2 + 0 
30f0 : f0 89 __ BEQ $307b ; (process_navigation_input.s1001 + 0)
.s11:
; 206, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30f2 : 69 fe __ ADC #$fe
30f4 : 4c cb 30 JMP $30cb ; (process_navigation_input.s71 + 0)
.s25:
; 186, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30f7 : c9 44 __ CMP #$44
30f9 : f0 c8 __ BEQ $30c3 ; (process_navigation_input.s14 + 0)
30fb : 60 __ __ RTS
--------------------------------------------------------------------
mul16by8: ; mul16by8
30fc : 4a __ __ LSR
30fd : f0 2e __ BEQ $312d ; (mul16by8 + 49)
30ff : a2 00 __ LDX #$00
3101 : a0 00 __ LDY #$00
3103 : 90 13 __ BCC $3118 ; (mul16by8 + 28)
3105 : a4 1b __ LDY ACCU + 0 
3107 : a6 1c __ LDX ACCU + 1 
3109 : b0 0d __ BCS $3118 ; (mul16by8 + 28)
310b : 85 02 __ STA $02 
310d : 18 __ __ CLC
310e : 98 __ __ TYA
310f : 65 1b __ ADC ACCU + 0 
3111 : a8 __ __ TAY
3112 : 8a __ __ TXA
3113 : 65 1c __ ADC ACCU + 1 
3115 : aa __ __ TAX
3116 : a5 02 __ LDA $02 
3118 : 06 1b __ ASL ACCU + 0 
311a : 26 1c __ ROL ACCU + 1 
311c : 4a __ __ LSR
311d : 90 f9 __ BCC $3118 ; (mul16by8 + 28)
311f : d0 ea __ BNE $310b ; (mul16by8 + 15)
3121 : 18 __ __ CLC
3122 : 98 __ __ TYA
3123 : 65 1b __ ADC ACCU + 0 
3125 : 85 1b __ STA ACCU + 0 
3127 : 8a __ __ TXA
3128 : 65 1c __ ADC ACCU + 1 
312a : 85 1c __ STA ACCU + 1 
312c : 60 __ __ RTS
312d : b0 04 __ BCS $3133 ; (mul16by8 + 55)
312f : 85 1b __ STA ACCU + 0 
3131 : 85 1c __ STA ACCU + 1 
3133 : 60 __ __ RTS
--------------------------------------------------------------------
mul16: ; mul16
3134 : a0 00 __ LDY #$00
3136 : 84 06 __ STY WORK + 3 
3138 : a5 03 __ LDA WORK + 0 
313a : a6 04 __ LDX WORK + 1 
313c : f0 1c __ BEQ $315a ; (mul16 + 38)
313e : 38 __ __ SEC
313f : 6a __ __ ROR
3140 : 90 0d __ BCC $314f ; (mul16 + 27)
3142 : aa __ __ TAX
3143 : 18 __ __ CLC
3144 : 98 __ __ TYA
3145 : 65 1b __ ADC ACCU + 0 
3147 : a8 __ __ TAY
3148 : a5 06 __ LDA WORK + 3 
314a : 65 1c __ ADC ACCU + 1 
314c : 85 06 __ STA WORK + 3 
314e : 8a __ __ TXA
314f : 06 1b __ ASL ACCU + 0 
3151 : 26 1c __ ROL ACCU + 1 
3153 : 4a __ __ LSR
3154 : 90 f9 __ BCC $314f ; (mul16 + 27)
3156 : d0 ea __ BNE $3142 ; (mul16 + 14)
3158 : a5 04 __ LDA WORK + 1 
315a : 4a __ __ LSR
315b : 90 0d __ BCC $316a ; (mul16 + 54)
315d : aa __ __ TAX
315e : 18 __ __ CLC
315f : 98 __ __ TYA
3160 : 65 1b __ ADC ACCU + 0 
3162 : a8 __ __ TAY
3163 : a5 06 __ LDA WORK + 3 
3165 : 65 1c __ ADC ACCU + 1 
3167 : 85 06 __ STA WORK + 3 
3169 : 8a __ __ TXA
316a : 06 1b __ ASL ACCU + 0 
316c : 26 1c __ ROL ACCU + 1 
316e : 4a __ __ LSR
316f : b0 ec __ BCS $315d ; (mul16 + 41)
3171 : d0 f7 __ BNE $316a ; (mul16 + 54)
3173 : 84 05 __ STY WORK + 2 
3175 : 60 __ __ RTS
--------------------------------------------------------------------
divmod: ; divmod
3176 : a5 1c __ LDA ACCU + 1 
3178 : d0 31 __ BNE $31ab ; (divmod + 53)
317a : a5 04 __ LDA WORK + 1 
317c : d0 1e __ BNE $319c ; (divmod + 38)
317e : 85 06 __ STA WORK + 3 
3180 : a2 04 __ LDX #$04
3182 : 06 1b __ ASL ACCU + 0 
3184 : 2a __ __ ROL
3185 : c5 03 __ CMP WORK + 0 
3187 : 90 02 __ BCC $318b ; (divmod + 21)
3189 : e5 03 __ SBC WORK + 0 
318b : 26 1b __ ROL ACCU + 0 
318d : 2a __ __ ROL
318e : c5 03 __ CMP WORK + 0 
3190 : 90 02 __ BCC $3194 ; (divmod + 30)
3192 : e5 03 __ SBC WORK + 0 
3194 : 26 1b __ ROL ACCU + 0 
3196 : ca __ __ DEX
3197 : d0 eb __ BNE $3184 ; (divmod + 14)
3199 : 85 05 __ STA WORK + 2 
319b : 60 __ __ RTS
319c : a5 1b __ LDA ACCU + 0 
319e : 85 05 __ STA WORK + 2 
31a0 : a5 1c __ LDA ACCU + 1 
31a2 : 85 06 __ STA WORK + 3 
31a4 : a9 00 __ LDA #$00
31a6 : 85 1b __ STA ACCU + 0 
31a8 : 85 1c __ STA ACCU + 1 
31aa : 60 __ __ RTS
31ab : a5 04 __ LDA WORK + 1 
31ad : d0 1f __ BNE $31ce ; (divmod + 88)
31af : a5 03 __ LDA WORK + 0 
31b1 : 30 1b __ BMI $31ce ; (divmod + 88)
31b3 : a9 00 __ LDA #$00
31b5 : 85 06 __ STA WORK + 3 
31b7 : a2 10 __ LDX #$10
31b9 : 06 1b __ ASL ACCU + 0 
31bb : 26 1c __ ROL ACCU + 1 
31bd : 2a __ __ ROL
31be : c5 03 __ CMP WORK + 0 
31c0 : 90 02 __ BCC $31c4 ; (divmod + 78)
31c2 : e5 03 __ SBC WORK + 0 
31c4 : 26 1b __ ROL ACCU + 0 
31c6 : 26 1c __ ROL ACCU + 1 
31c8 : ca __ __ DEX
31c9 : d0 f2 __ BNE $31bd ; (divmod + 71)
31cb : 85 05 __ STA WORK + 2 
31cd : 60 __ __ RTS
31ce : a9 00 __ LDA #$00
31d0 : 85 05 __ STA WORK + 2 
31d2 : 85 06 __ STA WORK + 3 
31d4 : 84 02 __ STY $02 
31d6 : a0 10 __ LDY #$10
31d8 : 18 __ __ CLC
31d9 : 26 1b __ ROL ACCU + 0 
31db : 26 1c __ ROL ACCU + 1 
31dd : 26 05 __ ROL WORK + 2 
31df : 26 06 __ ROL WORK + 3 
31e1 : 38 __ __ SEC
31e2 : a5 05 __ LDA WORK + 2 
31e4 : e5 03 __ SBC WORK + 0 
31e6 : aa __ __ TAX
31e7 : a5 06 __ LDA WORK + 3 
31e9 : e5 04 __ SBC WORK + 1 
31eb : 90 04 __ BCC $31f1 ; (divmod + 123)
31ed : 86 05 __ STX WORK + 2 
31ef : 85 06 __ STA WORK + 3 
31f1 : 88 __ __ DEY
31f2 : d0 e5 __ BNE $31d9 ; (divmod + 99)
31f4 : 26 1b __ ROL ACCU + 0 
31f6 : 26 1c __ ROL ACCU + 1 
31f8 : a4 02 __ LDY $02 
31fa : 60 __ __ RTS
--------------------------------------------------------------------
__multab14L:
31fb : __ __ __ BYT 00 0e 1c 2a                                     : ...*
--------------------------------------------------------------------
spentry:
31ff : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
__multab7982L:
3200 : __ __ __ BYT 00 2e 5c 8a b8 e6 14 42 70                      : ..\....Bp
--------------------------------------------------------------------
__multab7982H:
3209 : __ __ __ BYT 00 1f 3e 5d 7c 9b bb da f9                      : ..>]|....
--------------------------------------------------------------------
__shltab7L:
3212 : __ __ __ BYT 07 0e 1c 38 70 e0                               : ...8p.
--------------------------------------------------------------------
generation_counter:
3218 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
rng_seed:
321a : __ __ __ BYT 01 00                                           : ..
--------------------------------------------------------------------
room_count:
321c : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
room_center_cache_valid:
321d : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
corridor_pool:
321e : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
322e : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
323e : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
324e : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
325e : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
326e : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
327e : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
328e : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
329e : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
32ae : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
32be : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
32ce : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
32de : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
connection_cache:
32e0 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
32f0 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3300 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3310 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3320 : __ __ __ BYT 00 00 00 00 00 00 00 00 00                      : .........
--------------------------------------------------------------------
distance_cache_valid:
3329 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
corridor_endpoint_override:
332a : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
giocharmap:
332b : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
bitshift:
332c : __ __ __ BYT 00 00 00 00 00 00 00 00 01 02 04 08 10 20 40 80 : ............. @.
333c : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
334c : __ __ __ BYT 80 40 20 10 08 04 02 01 00 00 00 00 00 00 00 00 : .@ .............
335c : __ __ __ BYT 00 00 00 00 00 00 00 00                         : ........
--------------------------------------------------------------------
camera_center_x:
3364 : __ __ __ BSS	1
--------------------------------------------------------------------
camera_center_y:
3365 : __ __ __ BSS	1
--------------------------------------------------------------------
view:
3366 : __ __ __ BSS	2
--------------------------------------------------------------------
screen_buffer:
3368 : __ __ __ BSS	1000
--------------------------------------------------------------------
screen_dirty:
3750 : __ __ __ BSS	1
--------------------------------------------------------------------
last_scroll_direction:
3751 : __ __ __ BSS	1
--------------------------------------------------------------------
compact_map:
3752 : __ __ __ BSS	1536
--------------------------------------------------------------------
connection_matrix:
3d52 : __ __ __ BSS	400
--------------------------------------------------------------------
room_distance_cache:
3ee2 : __ __ __ BSS	400
--------------------------------------------------------------------
room_center_cache:
4072 : __ __ __ BSS	40
--------------------------------------------------------------------
visited_global:
409a : __ __ __ BSS	20
--------------------------------------------------------------------
stack_global:
40ae : __ __ __ BSS	20
--------------------------------------------------------------------
corridor_path_static:
40c2 : __ __ __ BSS	41
--------------------------------------------------------------------
rooms:
4100 : __ __ __ BSS	160
