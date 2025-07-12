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
080e : 8e 3b 34 STX $343b ; (spentry + 0)
0811 : a2 35 __ LDX #$35
0813 : a0 88 __ LDY #$88
0815 : a9 00 __ LDA #$00
0817 : 85 19 __ STA IP + 0 
0819 : 86 1a __ STX IP + 1 
081b : e0 43 __ CPX #$43
081d : f0 0b __ BEQ $082a ; (startup + 41)
081f : 91 19 __ STA (IP + 0),y 
0821 : c8 __ __ INY
0822 : d0 fb __ BNE $081f ; (startup + 30)
0824 : e8 __ __ INX
0825 : d0 f2 __ BNE $0819 ; (startup + 24)
0827 : 91 19 __ STA (IP + 0),y 
0829 : c8 __ __ INY
082a : c0 c9 __ CPY #$c9
082c : d0 f9 __ BNE $0827 ; (startup + 38)
082e : a9 00 __ LDA #$00
0830 : a2 f7 __ LDX #$f7
0832 : d0 03 __ BNE $0837 ; (startup + 54)
0834 : 95 00 __ STA $00,x 
0836 : e8 __ __ INX
0837 : e0 f7 __ CPX #$f7
0839 : d0 f9 __ BNE $0834 ; (startup + 51)
083b : a9 09 __ LDA #$09
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
0889 : a9 98 __ LDA #$98
088b : 85 0d __ STA P0 
088d : a9 2b __ LDA #$2b
088f : 85 0e __ STA P1 
0891 : 20 82 2b JSR $2b82 ; (krnio_setnam.s0 + 0)
;  42, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
0894 : a9 08 __ LDA #$08
0896 : 85 0d __ STA P0 
0898 : a9 3f __ LDA #$3f
089a : 85 11 __ STA P4 
089c : a9 76 __ LDA #$76
089e : 85 0e __ STA P1 
08a0 : a9 39 __ LDA #$39
08a2 : 85 0f __ STA P2 
08a4 : a9 76 __ LDA #$76
08a6 : 85 10 __ STA P3 
08a8 : 20 a4 2b JSR $2ba4 ; (krnio_save.s0 + 0)
08ab : aa __ __ TAX
08ac : d0 0b __ BNE $08b9 ; (main.l19 + 0)
.s45:
;  65, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08ae : a9 46 __ LDA #$46
08b0 : 85 0f __ STA P2 
08b2 : a9 2c __ LDA #$2c
08b4 : 85 10 __ STA P3 
08b6 : 20 c4 2b JSR $2bc4 ; (puts.l1 + 0)
.l19:
;  47, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08b9 : a9 01 __ LDA #$01
08bb : d0 07 __ BNE $08c4 ; (main.l6 + 0)
.s13:
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08bd : 85 0d __ STA P0 
08bf : 20 1b 32 JSR $321b ; (process_navigation_input.s0 + 0)
;  73, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08c2 : a9 00 __ LDA #$00
.l6:
;  47, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08c4 : 85 14 __ STA P7 
08c6 : 20 57 2c JSR $2c57 ; (render_map_viewport.s0 + 0)
;  51, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08c9 : 20 da 31 JSR $31da ; (getch.l1 + 0)
08cc : 8d 0b 9f STA $9f0b ; (key + 0)
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
08dd : a9 98 __ LDA #$98
08df : 85 0d __ STA P0 
08e1 : a9 2b __ LDA #$2b
08e3 : 85 0e __ STA P1 
08e5 : 20 82 2b JSR $2b82 ; (krnio_setnam.s0 + 0)
;  63, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08e8 : a9 08 __ LDA #$08
08ea : 85 0d __ STA P0 
08ec : a9 3f __ LDA #$3f
08ee : 85 11 __ STA P4 
08f0 : a9 76 __ LDA #$76
08f2 : 85 0e __ STA P1 
08f4 : a9 39 __ LDA #$39
08f6 : 85 0f __ STA P2 
08f8 : a9 76 __ LDA #$76
08fa : 85 10 __ STA P3 
08fc : 20 a4 2b JSR $2ba4 ; (krnio_save.s0 + 0)
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
;  66, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0911 : 20 5e 0a JSR $0a5e ; (get_hardware_entropy.s0 + 0)
0914 : a5 1b __ LDA ACCU + 0 
0916 : 85 48 __ STA T3 + 0 
0918 : 8d f3 9f STA $9ff3 ; (grid_y + 0)
091b : a5 1c __ LDA ACCU + 1 
091d : 85 49 __ STA T3 + 1 
091f : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
;  67, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0922 : 20 5e 0a JSR $0a5e ; (get_hardware_entropy.s0 + 0)
0925 : a5 1b __ LDA ACCU + 0 
0927 : 85 4a __ STA T4 + 0 
0929 : 8d f1 9f STA $9ff1 ; (cell_h + 0)
092c : a5 1c __ LDA ACCU + 1 
092e : 85 4b __ STA T4 + 1 
0930 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
;  68, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0933 : 20 5e 0a JSR $0a5e ; (get_hardware_entropy.s0 + 0)
0936 : a5 1b __ LDA ACCU + 0 
0938 : 85 46 __ STA T2 + 0 
093a : 8d ef 9f STA $9fef ; (screen_pos + 1)
093d : a5 1c __ LDA ACCU + 1 
093f : 85 47 __ STA T2 + 1 
0941 : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
;  69, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0944 : 20 5e 0a JSR $0a5e ; (get_hardware_entropy.s0 + 0)
0947 : a5 1b __ LDA ACCU + 0 
0949 : 8d ed 9f STA $9fed ; (highest_priority + 0)
;  71, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
094c : a9 00 __ LDA #$00
094e : 8d 3d 34 STA $343d ; (generation_counter + 1)
;  80, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0951 : 8d ec 9f STA $9fec ; (i + 0)
;  71, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0954 : a9 01 __ LDA #$01
0956 : 8d 3c 34 STA $343c ; (generation_counter + 0)
;  69, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
;  74, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
0996 : 8d 3f 34 STA $343f ; (rng_seed + 1)
0999 : 98 __ __ TYA
099a : 45 1b __ EOR ACCU + 0 
099c : 49 80 __ EOR #$80
099e : 8d 3e 34 STA $343e ; (rng_seed + 0)
;  75, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
09a1 : 0a __ __ ASL
09a2 : 85 44 __ STA T1 + 0 
09a4 : ad 3f 34 LDA $343f ; (rng_seed + 1)
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
09b5 : ad 3f 34 LDA $343f ; (rng_seed + 1)
09b8 : 4a __ __ LSR
09b9 : 4a __ __ LSR
09ba : 4a __ __ LSR
09bb : 45 44 __ EOR T1 + 0 
09bd : 49 1d __ EOR #$1d
09bf : 8d 3e 34 STA $343e ; (rng_seed + 0)
09c2 : 8a __ __ TXA
09c3 : 49 ac __ EOR #$ac
09c5 : 8d 3f 34 STA $343f ; (rng_seed + 1)
;  77, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
09c8 : ad 3e 34 LDA $343e ; (rng_seed + 0)
09cb : 49 37 __ EOR #$37
09cd : 8d 3e 34 STA $343e ; (rng_seed + 0)
09d0 : ad 3f 34 LDA $343f ; (rng_seed + 1)
09d3 : 49 9e __ EOR #$9e
09d5 : 8d 3f 34 STA $343f ; (rng_seed + 1)
;  78, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
09ed : 20 58 33 JSR $3358 ; (mul16 + 0)
09f0 : a5 05 __ LDA WORK + 2 
09f2 : 4d 3e 34 EOR $343e ; (rng_seed + 0)
09f5 : 8d 3e 34 STA $343e ; (rng_seed + 0)
09f8 : a5 06 __ LDA WORK + 3 
09fa : 4d 3f 34 EOR $343f ; (rng_seed + 1)
09fd : 8d 3f 34 STA $343f ; (rng_seed + 1)
.l2:
;  81, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a00 : ad 3e 34 LDA $343e ; (rng_seed + 0)
0a03 : 0a __ __ ASL
0a04 : 85 44 __ STA T1 + 0 
0a06 : ad 3f 34 LDA $343f ; (rng_seed + 1)
0a09 : 2a __ __ ROL
0a0a : 06 44 __ ASL T1 + 0 
0a0c : 2a __ __ ROL
0a0d : 06 44 __ ASL T1 + 0 
0a0f : 2a __ __ ROL
0a10 : 85 45 __ STA T1 + 1 
0a12 : ad 3f 34 LDA $343f ; (rng_seed + 1)
0a15 : 4a __ __ LSR
0a16 : 4a __ __ LSR
0a17 : 4a __ __ LSR
0a18 : 4a __ __ LSR
0a19 : 4a __ __ LSR
0a1a : 45 44 __ EOR T1 + 0 
0a1c : ac ec 9f LDY $9fec ; (i + 0)
0a1f : 59 1f 34 EOR $341f,y ; (__multab7982L + 0)
0a22 : 8d 3e 34 STA $343e ; (rng_seed + 0)
0a25 : aa __ __ TAX
0a26 : b9 28 34 LDA $3428,y ; (__multab7982H + 0)
0a29 : 45 45 __ EOR T1 + 1 
0a2b : 85 1c __ STA ACCU + 1 
0a2d : 8d 3f 34 STA $343f ; (rng_seed + 1)
;  80, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a30 : ee ec 9f INC $9fec ; (i + 0)
0a33 : ad ec 9f LDA $9fec ; (i + 0)
0a36 : c9 04 __ CMP #$04
0a38 : 90 c6 __ BCC $0a00 ; (init_rng.l2 + 0)
.s4:
;  86, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a3a : a9 00 __ LDA #$00
0a3c : 8d ec 9f STA $9fec ; (i + 0)
;  84, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a3f : 8a __ __ TXA
0a40 : 05 1c __ ORA ACCU + 1 
0a42 : d0 0a __ BNE $0a4e ; (init_rng.l9 + 0)
.s5:
0a44 : a9 22 __ LDA #$22
0a46 : 8d 3e 34 STA $343e ; (rng_seed + 0)
0a49 : a9 1d __ LDA #$1d
0a4b : 8d 3f 34 STA $343f ; (rng_seed + 1)
.l9:
;  87, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a4e : a9 ff __ LDA #$ff
0a50 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
;  86, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a53 : ee ec 9f INC $9fec ; (i + 0)
0a56 : ad ec 9f LDA $9fec ; (i + 0)
0a59 : c9 08 __ CMP #$08
0a5b : 90 f1 __ BCC $0a4e ; (init_rng.l9 + 0)
.s1001:
;  89, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a5d : 60 __ __ RTS
--------------------------------------------------------------------
get_hardware_entropy: ; get_hardware_entropy()->u16
.s0:
;  58, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 146, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a6c : c9 02 __ CMP #$02
0a6e : b0 03 __ BCS $0a73 ; (rnd.s3 + 0)
.s1:
0a70 : a9 00 __ LDA #$00
.s1001:
; 186, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a72 : 60 __ __ RTS
.s3:
0a73 : 85 0d __ STA P0 ; (max + 0)
; 150, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a75 : ad 3e 34 LDA $343e ; (rng_seed + 0)
0a78 : 85 1b __ STA ACCU + 0 
0a7a : 8d f8 9f STA $9ff8 ; (room + 1)
; 149, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a7d : ad 3f 34 LDA $343f ; (rng_seed + 1)
0a80 : 85 1c __ STA ACCU + 1 
0a82 : 85 43 __ STA T1 + 0 
0a84 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 151, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a87 : 10 04 __ BPL $0a8d ; (rnd.s42 + 0)
.s41:
0a89 : a9 01 __ LDA #$01
0a8b : b0 02 __ BCS $0a8f ; (rnd.s43 + 0)
.s42:
; 151, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a8d : a9 00 __ LDA #$00
.s43:
0a8f : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
; 154, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a92 : 06 1b __ ASL ACCU + 0 
0a94 : 26 1c __ ROL ACCU + 1 
0a96 : aa __ __ TAX
0a97 : a5 1b __ LDA ACCU + 0 
0a99 : 8d 3e 34 STA $343e ; (rng_seed + 0)
0a9c : a4 1c __ LDY ACCU + 1 
0a9e : 8c 3f 34 STY $343f ; (rng_seed + 1)
; 157, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0aa1 : 8a __ __ TXA
0aa2 : f0 0b __ BEQ $0aaf ; (rnd.s7 + 0)
.s5:
; 158, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0aa4 : 98 __ __ TYA
0aa5 : 49 b4 __ EOR #$b4
0aa7 : 8d 3f 34 STA $343f ; (rng_seed + 1)
0aaa : a5 1b __ LDA ACCU + 0 
0aac : 8d 3e 34 STA $343e ; (rng_seed + 0)
.s7:
; 162, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
0ac9 : 4d 3e 34 EOR $343e ; (rng_seed + 0)
0acc : 8d 3e 34 STA $343e ; (rng_seed + 0)
0acf : 8a __ __ TXA
0ad0 : 4d 3f 34 EOR $343f ; (rng_seed + 1)
0ad3 : 8d 3f 34 STA $343f ; (rng_seed + 1)
; 165, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0ad6 : 4d 3e 34 EOR $343e ; (rng_seed + 0)
0ad9 : 8d f6 9f STA $9ff6 ; (room_center_y + 0)
; 168, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0adc : a5 0d __ LDA P0 ; (max + 0)
0ade : c9 08 __ CMP #$08
0ae0 : d0 06 __ BNE $0ae8 ; (rnd.s19 + 0)
.s11:
; 174, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0ae2 : ad f6 9f LDA $9ff6 ; (room_center_y + 0)
0ae5 : 29 07 __ AND #$07
0ae7 : 60 __ __ RTS
.s19:
; 168, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0ae8 : 90 67 __ BCC $0b51 ; (rnd.s21 + 0)
.s20:
0aea : c9 10 __ CMP #$10
0aec : d0 06 __ BNE $0af4 ; (rnd.s14 + 0)
.s12:
; 176, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0aee : ad f6 9f LDA $9ff6 ; (room_center_y + 0)
0af1 : 29 0f __ AND #$0f
0af3 : 60 __ __ RTS
.s14:
; 180, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0af4 : a9 00 __ LDA #$00
0af6 : 85 1b __ STA ACCU + 0 
0af8 : 85 04 __ STA WORK + 1 
0afa : a5 0d __ LDA P0 ; (max + 0)
0afc : 85 03 __ STA WORK + 0 
0afe : a9 01 __ LDA #$01
0b00 : 85 1c __ STA ACCU + 1 
0b02 : 20 9a 33 JSR $339a ; (divmod + 0)
0b05 : a5 0d __ LDA P0 ; (max + 0)
0b07 : 20 20 33 JSR $3320 ; (mul16by8 + 0)
0b0a : a5 1b __ LDA ACCU + 0 
0b0c : 8d f5 9f STA $9ff5 ; (s + 1)
; 181, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b0f : ad f6 9f LDA $9ff6 ; (room_center_y + 0)
0b12 : c5 1b __ CMP ACCU + 0 
0b14 : 90 29 __ BCC $0b3f ; (rnd.s17 + 0)
.l16:
; 183, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b16 : ad 3e 34 LDA $343e ; (rng_seed + 0)
0b19 : 0a __ __ ASL
0b1a : 85 1c __ STA ACCU + 1 
0b1c : ad 3f 34 LDA $343f ; (rng_seed + 1)
0b1f : 2a __ __ ROL
0b20 : aa __ __ TAX
0b21 : ad 3f 34 LDA $343f ; (rng_seed + 1)
0b24 : 0a __ __ ASL
0b25 : a9 00 __ LDA #$00
0b27 : 2a __ __ ROL
0b28 : 45 1c __ EOR ACCU + 1 
0b2a : 49 37 __ EOR #$37
0b2c : 8d 3e 34 STA $343e ; (rng_seed + 0)
0b2f : 8a __ __ TXA
0b30 : 49 9e __ EOR #$9e
0b32 : 8d 3f 34 STA $343f ; (rng_seed + 1)
; 184, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b35 : 4d 3e 34 EOR $343e ; (rng_seed + 0)
0b38 : 8d f6 9f STA $9ff6 ; (room_center_y + 0)
; 181, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b3b : c5 1b __ CMP ACCU + 0 
0b3d : b0 d7 __ BCS $0b16 ; (rnd.l16 + 0)
.s17:
; 186, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b3f : 85 1b __ STA ACCU + 0 
0b41 : a9 00 __ LDA #$00
0b43 : 85 1c __ STA ACCU + 1 
0b45 : 85 04 __ STA WORK + 1 
0b47 : a5 0d __ LDA P0 ; (max + 0)
0b49 : 85 03 __ STA WORK + 0 
0b4b : 20 9a 33 JSR $339a ; (divmod + 0)
0b4e : a5 05 __ LDA WORK + 2 
0b50 : 60 __ __ RTS
.s21:
; 168, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b51 : c9 02 __ CMP #$02
0b53 : d0 06 __ BNE $0b5b ; (rnd.s22 + 0)
.s9:
; 170, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b55 : ad f6 9f LDA $9ff6 ; (room_center_y + 0)
0b58 : 29 01 __ AND #$01
0b5a : 60 __ __ RTS
.s22:
; 168, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b5b : c9 04 __ CMP #$04
0b5d : d0 95 __ BNE $0af4 ; (rnd.s14 + 0)
.s10:
; 172, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b5f : ad f6 9f LDA $9ff6 ; (room_center_y + 0)
0b62 : 29 03 __ AND #$03
0b64 : 60 __ __ RTS
--------------------------------------------------------------------
oscar_clrscr: ; oscar_clrscr()->void
.s0:
;  99, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 140, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
0ba6 : 8d 8a 35 STA $358a ; (view + 0)
;  25, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0ba9 : 8d 8b 35 STA $358b ; (view + 1)
;  23, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0bac : a9 20 __ LDA #$20
0bae : 8d 89 35 STA $3589 ; (camera_center_y + 0)
;  22, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0bb1 : 8d 88 35 STA $3588 ; (camera_center_x + 0)
.s1001:
;  26, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0bb4 : 60 __ __ RTS
--------------------------------------------------------------------
reset_display_state: ; reset_display_state()->void
.s0:
;  37, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0bb5 : a9 00 __ LDA #$00
0bb7 : 8d 75 39 STA $3975 ; (last_scroll_direction + 0)
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0bba : a9 01 __ LDA #$01
0bbc : 8d 74 39 STA $3974 ; (screen_dirty + 0)
;  31, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0bbf : a9 20 __ LDA #$20
0bc1 : a2 fa __ LDX #$fa
.l1003:
0bc3 : ca __ __ DEX
0bc4 : 9d 8c 35 STA $358c,x ; (screen_buffer + 0)
0bc7 : 9d 86 36 STA $3686,x ; (screen_buffer + 250)
0bca : 9d 80 37 STA $3780,x ; (screen_buffer + 500)
0bcd : 9d 7a 38 STA $387a,x ; (screen_buffer + 750)
0bd0 : d0 f1 __ BNE $0bc3 ; (reset_display_state.l1003 + 0)
.s1001:
;  38, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0bd2 : 60 __ __ RTS
--------------------------------------------------------------------
reset_all_generation_data: ; reset_all_generation_data()->void
.s0:
; 701, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bd3 : 20 11 09 JSR $0911 ; (init_rng.s0 + 0)
; 704, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bd6 : 20 e4 0b JSR $0be4 ; (clear_map.s0 + 0)
; 707, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bd9 : a9 00 __ LDA #$00
0bdb : 8d 40 34 STA $3440 ; (room_count + 0)
; 710, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bde : 20 24 0c JSR $0c24 ; (clear_room_center_cache.s0 + 0)
; 713, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0be1 : 4c 2a 0c JMP $0c2a ; (init_rule_based_connection_system.s0 + 0)
--------------------------------------------------------------------
clear_map: ; clear_map()->void
.s0:
; 300, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0be4 : a9 00 __ LDA #$00
0be6 : 85 43 __ STA T1 + 0 
0be8 : 8d f8 9f STA $9ff8 ; (room + 1)
; 303, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0beb : 8d f6 9f STA $9ff6 ; (room_center_y + 0)
0bee : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
; 300, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bf1 : a9 06 __ LDA #$06
0bf3 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
.l1005:
; 304, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bf6 : 18 __ __ CLC
0bf7 : a9 76 __ LDA #$76
0bf9 : 6d f6 9f ADC $9ff6 ; (room_center_y + 0)
0bfc : a8 __ __ TAY
0bfd : ad f7 9f LDA $9ff7 ; (byte_ptr + 1)
0c00 : 85 1c __ STA ACCU + 1 
0c02 : 69 39 __ ADC #$39
0c04 : 85 44 __ STA T1 + 1 
0c06 : a9 00 __ LDA #$00
0c08 : ae f6 9f LDX $9ff6 ; (room_center_y + 0)
0c0b : 91 43 __ STA (T1 + 0),y 
; 303, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0c0d : 8a __ __ TXA
0c0e : 69 01 __ ADC #$01
0c10 : 8d f6 9f STA $9ff6 ; (room_center_y + 0)
0c13 : a5 1c __ LDA ACCU + 1 
0c15 : 69 00 __ ADC #$00
0c17 : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
0c1a : c9 06 __ CMP #$06
0c1c : d0 d8 __ BNE $0bf6 ; (clear_map.l1005 + 0)
.s1006:
; 303, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0c1e : ad f6 9f LDA $9ff6 ; (room_center_y + 0)
0c21 : d0 d3 __ BNE $0bf6 ; (clear_map.l1005 + 0)
.s1001:
; 306, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0c23 : 60 __ __ RTS
--------------------------------------------------------------------
clear_room_center_cache: ; clear_room_center_cache()->void
.s0:
; 364, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0c24 : a9 00 __ LDA #$00
0c26 : 8d 41 34 STA $3441 ; (room_center_cache_valid + 0)
.s1001:
; 365, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0c29 : 60 __ __ RTS
--------------------------------------------------------------------
init_rule_based_connection_system: ; init_rule_based_connection_system()->void
.s0:
; 476, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c2a : a9 00 __ LDA #$00
0c2c : 8d f5 9f STA $9ff5 ; (s + 1)
.l2:
; 477, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
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
; 478, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c41 : 2a __ __ ROL
0c42 : 85 44 __ STA T0 + 1 
0c44 : a9 06 __ LDA #$06
0c46 : 65 43 __ ADC T0 + 0 
0c48 : 85 1b __ STA ACCU + 0 
0c4a : a9 41 __ LDA #$41
0c4c : 65 44 __ ADC T0 + 1 
0c4e : 85 1c __ STA ACCU + 1 
0c50 : 18 __ __ CLC
0c51 : a9 76 __ LDA #$76
0c53 : 65 43 __ ADC T0 + 0 
0c55 : 85 43 __ STA T0 + 0 
0c57 : a9 3f __ LDA #$3f
0c59 : 65 44 __ ADC T0 + 1 
0c5b : 85 44 __ STA T0 + 1 
.l6:
; 479, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c5d : a9 ff __ LDA #$ff
0c5f : ac f4 9f LDY $9ff4 ; (entropy1 + 1)
0c62 : 91 1b __ STA (ACCU + 0),y 
; 478, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c64 : a9 00 __ LDA #$00
0c66 : 91 43 __ STA (T0 + 0),y 
; 477, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c68 : c8 __ __ INY
0c69 : 8c f4 9f STY $9ff4 ; (entropy1 + 1)
0c6c : c0 14 __ CPY #$14
0c6e : 90 ed __ BCC $0c5d ; (init_rule_based_connection_system.l6 + 0)
.s3:
; 476, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c70 : e8 __ __ INX
0c71 : 8e f5 9f STX $9ff5 ; (s + 1)
0c74 : e0 14 __ CPX #$14
0c76 : 90 b7 __ BCC $0c2f ; (init_rule_based_connection_system.l2 + 0)
.s4:
; 491, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c78 : 8d f3 9f STA $9ff3 ; (grid_y + 0)
; 488, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c7b : 8d 4d 35 STA $354d ; (distance_cache_valid + 0)
; 487, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c7e : 8d 4c 35 STA $354c ; (connection_cache + 72)
; 484, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c81 : 8d 02 35 STA $3502 ; (corridor_pool + 192)
; 485, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c84 : 8d 03 35 STA $3503 ; (corridor_pool + 193)
; 491, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c87 : ad 40 34 LDA $3440 ; (room_count + 0)
0c8a : 85 48 __ STA T5 + 0 
0c8c : f0 74 __ BEQ $0d02 ; (init_rule_based_connection_system.s12 + 0)
.l13:
0c8e : ad f3 9f LDA $9ff3 ; (grid_y + 0)
0c91 : c9 14 __ CMP #$14
0c93 : b0 6d __ BCS $0d02 ; (init_rule_based_connection_system.s12 + 0)
.s10:
; 492, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c95 : 85 49 __ STA T6 + 0 
0c97 : 85 45 __ STA T2 + 0 
0c99 : 69 01 __ ADC #$01
0c9b : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
0c9e : c5 48 __ CMP T5 + 0 
0ca0 : b0 55 __ BCS $0cf7 ; (init_rule_based_connection_system.s11 + 0)
.s31:
; 493, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
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
0cb0 : 69 06 __ ADC #$06
0cb2 : 85 46 __ STA T3 + 0 
0cb4 : 8a __ __ TXA
0cb5 : 69 41 __ ADC #$41
0cb7 : 85 47 __ STA T3 + 1 
.l18:
; 492, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0cb9 : ad f2 9f LDA $9ff2 ; (entropy2 + 1)
0cbc : c9 14 __ CMP #$14
0cbe : b0 37 __ BCS $0cf7 ; (init_rule_based_connection_system.s11 + 0)
.s15:
; 493, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0cc0 : a5 49 __ LDA T6 + 0 
0cc2 : 85 13 __ STA P6 
0cc4 : ad f2 9f LDA $9ff2 ; (entropy2 + 1)
0cc7 : 85 14 __ STA P7 
0cc9 : 20 08 0d JSR $0d08 ; (calculate_room_distance.s0 + 0)
0ccc : a4 14 __ LDY P7 
0cce : 91 46 __ STA (T3 + 0),y 
0cd0 : aa __ __ TAX
; 494, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
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
0cde : 69 06 __ ADC #$06
0ce0 : 85 43 __ STA T0 + 0 
0ce2 : 98 __ __ TYA
0ce3 : 69 41 __ ADC #$41
0ce5 : 85 44 __ STA T0 + 1 
0ce7 : 8a __ __ TXA
0ce8 : a4 45 __ LDY T2 + 0 
0cea : 91 43 __ STA (T0 + 0),y 
; 492, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0cec : a5 14 __ LDA P7 
0cee : 69 01 __ ADC #$01
0cf0 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
0cf3 : c5 48 __ CMP T5 + 0 
0cf5 : 90 c2 __ BCC $0cb9 ; (init_rule_based_connection_system.l18 + 0)
.s11:
; 491, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0cf7 : a5 49 __ LDA T6 + 0 
0cf9 : 69 00 __ ADC #$00
0cfb : 8d f3 9f STA $9ff3 ; (grid_y + 0)
0cfe : c5 48 __ CMP T5 + 0 
0d00 : 90 8c __ BCC $0c8e ; (init_rule_based_connection_system.l13 + 0)
.s12:
; 497, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0d02 : a9 01 __ LDA #$01
0d04 : 8d 4d 35 STA $354d ; (distance_cache_valid + 0)
.s1001:
; 498, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0d07 : 60 __ __ RTS
--------------------------------------------------------------------
calculate_room_distance: ; calculate_room_distance(u8,u8)->u8
.s0:
; 375, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 376, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 377, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d36 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
0d39 : 85 0f __ STA P2 
0d3b : ad f8 9f LDA $9ff8 ; (room + 1)
0d3e : 85 10 __ STA P3 
0d40 : ad f7 9f LDA $9ff7 ; (byte_ptr + 1)
0d43 : 85 11 __ STA P4 
0d45 : ad f6 9f LDA $9ff6 ; (room_center_y + 0)
0d48 : 85 12 __ STA P5 
0d4a : 4c c8 0d JMP $0dc8 ; (manhattan_distance.s0 + 0)
--------------------------------------------------------------------
get_room_center: ; get_room_center(u8,u8*,u8*)->void
.s0:
; 332, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d4d : ad 41 34 LDA $3441 ; (room_center_cache_valid + 0)
0d50 : d0 05 __ BNE $0d57 ; (get_room_center.s4 + 0)
.s1002:
; 335, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d52 : a5 0d __ LDA P0 ; (room_id + 0)
0d54 : 4c 5d 0d JMP $0d5d ; (get_room_center.s1 + 0)
.s4:
; 332, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d57 : a5 0d __ LDA P0 ; (room_id + 0)
0d59 : c9 14 __ CMP #$14
0d5b : 90 5c __ BCC $0db9 ; (get_room_center.s3 + 0)
.s1:
; 335, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d5d : 85 1b __ STA ACCU + 0 
0d5f : 0a __ __ ASL
0d60 : 0a __ __ ASL
0d61 : 0a __ __ ASL
0d62 : aa __ __ TAX
0d63 : bd 02 43 LDA $4302,x ; (rooms + 2)
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
0d7d : bd 00 43 LDA $4300,x ; (rooms + 0)
0d80 : 18 __ __ CLC
0d81 : 65 43 __ ADC T2 + 0 
0d83 : a0 00 __ LDY #$00
0d85 : 91 0e __ STA (P1),y ; (center_x + 0)
; 336, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d87 : bd 03 43 LDA $4303,x ; (rooms + 3)
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
0da2 : bd 01 43 LDA $4301,x ; (rooms + 1)
0da5 : 18 __ __ CLC
0da6 : 65 43 __ ADC T2 + 0 
0da8 : 91 10 __ STA (P3),y ; (center_y + 0)
; 339, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0daa : b1 0e __ LDA (P1),y ; (center_x + 0)
0dac : 06 1b __ ASL ACCU + 0 
0dae : a6 1b __ LDX ACCU + 0 
0db0 : 9d 96 42 STA $4296,x ; (room_center_cache + 0)
; 340, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0db3 : b1 10 __ LDA (P3),y ; (center_y + 0)
0db5 : 9d 97 42 STA $4297,x ; (room_center_cache + 1)
0db8 : 60 __ __ RTS
.s3:
; 345, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0db9 : 0a __ __ ASL
0dba : aa __ __ TAX
0dbb : bd 96 42 LDA $4296,x ; (room_center_cache + 0)
0dbe : a0 00 __ LDY #$00
0dc0 : 91 0e __ STA (P1),y ; (center_x + 0)
; 346, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0dc2 : bd 97 42 LDA $4297,x ; (room_center_cache + 1)
0dc5 : 91 10 __ STA (P3),y ; (center_y + 0)
.s1001:
; 342, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0dc7 : 60 __ __ RTS
--------------------------------------------------------------------
manhattan_distance: ; manhattan_distance(u8,u8,u8,u8)->u8
.s0:
; 369, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 327, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0de4 : a5 0e __ LDA P1 ; (b + 0)
0de6 : c5 0d __ CMP P0 ; (a + 0)
0de8 : 90 03 __ BCC $0ded ; (fast_abs_diff.s2 + 0)
.s3:
0dea : e5 0d __ SBC P0 ; (a + 0)
0dec : 60 __ __ RTS
.s2:
; 327, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
0df7 : 9d 0c 9f STA $9f0c,x ; (generate_level@stack + 0)
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
0e0b : ad 40 34 LDA $3440 ; (room_count + 0)
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
0e22 : 8d 27 9f STA $9f27 ; (connections_made + 0)
; 128, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e25 : 20 2a 0c JSR $0c2a ; (init_rule_based_connection_system.s0 + 0)
; 131, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e28 : a9 00 __ LDA #$00
0e2a : 8d 26 9f STA $9f26 ; (i + 0)
.l6:
; 132, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e2d : a9 00 __ LDA #$00
0e2f : ae 26 9f LDX $9f26 ; (i + 0)
0e32 : 9d 28 9f STA $9f28,x ; (connected + 0)
; 131, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e35 : ee 26 9f INC $9f26 ; (i + 0)
0e38 : ad 26 9f LDA $9f26 ; (i + 0)
0e3b : c9 14 __ CMP #$14
0e3d : 90 ee __ BCC $0e2d ; (generate_level.l6 + 0)
.s8:
; 139, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e3f : a9 00 __ LDA #$00
0e41 : 85 1c __ STA ACCU + 1 
0e43 : 8d 22 9f STA $9f22 ; (iterations + 0)
0e46 : 8d 23 9f STA $9f23 ; (iterations + 1)
; 136, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e49 : a9 01 __ LDA #$01
0e4b : 8d 28 9f STA $9f28 ; (connected + 0)
; 138, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e4e : a5 58 __ LDA T5 + 0 
0e50 : 85 1b __ STA ACCU + 0 
0e52 : 20 20 33 JSR $3320 ; (mul16by8 + 0)
0e55 : a5 1b __ LDA ACCU + 0 
0e57 : 0a __ __ ASL
0e58 : 85 55 __ STA T3 + 0 
0e5a : 8d 24 9f STA $9f24 ; (max_iterations + 0)
0e5d : a5 1c __ LDA ACCU + 1 
0e5f : 2a __ __ ROL
0e60 : 85 56 __ STA T3 + 1 
0e62 : 8d 25 9f STA $9f25 ; (max_iterations + 1)
0e65 : 4c 77 0e JMP $0e77 ; (generate_level.l9 + 0)
.s279:
; 198, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e68 : 18 __ __ CLC
0e69 : a5 53 __ LDA T1 + 0 
0e6b : 69 01 __ ADC #$01
0e6d : 8d 22 9f STA $9f22 ; (iterations + 0)
0e70 : a5 54 __ LDA T1 + 1 
0e72 : 69 00 __ ADC #$00
0e74 : 8d 23 9f STA $9f23 ; (iterations + 1)
.l9:
; 140, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e77 : ad 27 9f LDA $9f27 ; (connections_made + 0)
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
0e89 : ad 22 9f LDA $9f22 ; (iterations + 0)
0e8c : 85 53 __ STA T1 + 0 
0e8e : ad 23 9f LDA $9f23 ; (iterations + 1)
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
0e9d : 20 57 29 JSR $2957 ; (add_walls.s0 + 0)
; 206, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ea0 : 20 5b 2a JSR $2a5b ; (add_stairs.s0 + 0)
; 208, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ea3 : a9 01 __ LDA #$01
.s1001:
0ea5 : 85 1b __ STA ACCU + 0 
0ea7 : a2 09 __ LDX #$09
0ea9 : bd 0c 9f LDA $9f0c,x ; (generate_level@stack + 0)
0eac : 95 53 __ STA T1 + 0,x 
0eae : ca __ __ DEX
0eaf : 10 f8 __ BPL $0ea9 ; (generate_level.s1001 + 4)
0eb1 : 60 __ __ RTS
.s10:
; 148, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0eb2 : a9 00 __ LDA #$00
0eb4 : 8d 26 9f STA $9f26 ; (i + 0)
; 144, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0eb7 : 8d 1e 9f STA $9f1e ; (connection_found + 0)
; 145, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0eba : 8d 1d 9f STA $9f1d ; (failed_attempts + 0)
; 142, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ebd : a9 ff __ LDA #$ff
0ebf : 8d 21 9f STA $9f21 ; (best_room1 + 0)
0ec2 : 8d 20 9f STA $9f20 ; (best_room2 + 0)
; 143, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ec5 : 8d 1f 9f STA $9f1f ; (best_distance + 0)
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
0ed5 : ae 26 9f LDX $9f26 ; (i + 0)
0ed8 : 86 5b __ STX T8 + 0 
0eda : bd 28 9f LDA $9f28,x ; (connected + 0)
0edd : f0 64 __ BEQ $0f43 ; (generate_level.s15 + 0)
.s19:
; 150, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0edf : a9 00 __ LDA #$00
0ee1 : 8d 1c 9f STA $9f1c ; (j + 0)
0ee4 : a5 5a __ LDA T7 + 0 
0ee6 : f0 5b __ BEQ $0f43 ; (generate_level.s15 + 0)
.l22:
; 151, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ee8 : ae 1c 9f LDX $9f1c ; (j + 0)
0eeb : 86 5c __ STX T9 + 0 
0eed : bd 28 9f LDA $9f28,x ; (connected + 0)
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
0f1a : 8d 1b 9f STA $9f1b ; (distance + 0)
; 156, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f1d : cd 1f 9f CMP $9f1f ; (best_distance + 0)
0f20 : b0 15 __ BCS $0f37 ; (generate_level.s21 + 0)
.s37:
; 158, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f22 : a5 13 __ LDA P6 
0f24 : 8d 21 9f STA $9f21 ; (best_room1 + 0)
; 159, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f27 : a5 5c __ LDA T9 + 0 
0f29 : 8d 20 9f STA $9f20 ; (best_room2 + 0)
; 157, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f2c : ad 1b 9f LDA $9f1b ; (distance + 0)
0f2f : 8d 1f 9f STA $9f1f ; (best_distance + 0)
; 160, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f32 : a9 01 __ LDA #$01
0f34 : 8d 1e 9f STA $9f1e ; (connection_found + 0)
.s21:
; 150, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f37 : 18 __ __ CLC
0f38 : a5 5c __ LDA T9 + 0 
0f3a : 69 01 __ ADC #$01
0f3c : 8d 1c 9f STA $9f1c ; (j + 0)
0f3f : c5 58 __ CMP T5 + 0 
0f41 : 90 a5 __ BCC $0ee8 ; (generate_level.l22 + 0)
.s15:
; 148, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f43 : 18 __ __ CLC
0f44 : a5 5b __ LDA T8 + 0 
0f46 : 69 01 __ ADC #$01
0f48 : 8d 26 9f STA $9f26 ; (i + 0)
0f4b : c5 58 __ CMP T5 + 0 
0f4d : 90 86 __ BCC $0ed5 ; (generate_level.l14 + 0)
.s16:
; 165, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f4f : ad 1e 9f LDA $9f1e ; (connection_found + 0)
0f52 : f0 30 __ BEQ $0f84 ; (generate_level.s41 + 0)
.s43:
0f54 : ad 21 9f LDA $9f21 ; (best_room1 + 0)
0f57 : 8d fe 9f STA $9ffe ; (sstack + 4)
0f5a : ad 20 9f LDA $9f20 ; (best_room2 + 0)
0f5d : 85 57 __ STA T4 + 0 
0f5f : 8d ff 9f STA $9fff ; (sstack + 5)
0f62 : 20 e3 19 JSR $19e3 ; (rule_based_connect_rooms.s1000 + 0)
0f65 : a5 1b __ LDA ACCU + 0 
0f67 : f0 1b __ BEQ $0f84 ; (generate_level.s41 + 0)
.s40:
; 166, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f69 : a9 01 __ LDA #$01
0f6b : a6 57 __ LDX T4 + 0 
0f6d : 9d 28 9f STA $9f28,x ; (connected + 0)
; 167, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f70 : a6 59 __ LDX T6 + 0 
0f72 : e8 __ __ INX
0f73 : 8e 27 9f STX $9f27 ; (connections_made + 0)
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
0f86 : 8d 26 9f STA $9f26 ; (i + 0)
; 172, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f89 : 8d 1e 9f STA $9f1e ; (connection_found + 0)
; 173, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f8c : a5 5a __ LDA T7 + 0 
0f8e : d0 03 __ BNE $0f93 ; (generate_level.l48 + 0)
0f90 : 4c 29 10 JMP $1029 ; (generate_level.s79 + 0)
.l48:
; 174, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f93 : ae 26 9f LDX $9f26 ; (i + 0)
0f96 : 86 59 __ STX T6 + 0 
0f98 : bd 28 9f LDA $9f28,x ; (connected + 0)
0f9b : f0 6e __ BEQ $100b ; (generate_level.s49 + 0)
.s54:
; 175, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f9d : a9 00 __ LDA #$00
0f9f : 8d 1a 9f STA $9f1a ; (j + 0)
0fa2 : a5 5a __ LDA T7 + 0 
0fa4 : f0 65 __ BEQ $100b ; (generate_level.s49 + 0)
.l60:
0fa6 : ad 1e 9f LDA $9f1e ; (connection_found + 0)
0fa9 : d0 60 __ BNE $100b ; (generate_level.s49 + 0)
.s57:
; 176, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0fab : ac 1a 9f LDY $9f1a ; (j + 0)
0fae : 84 5b __ STY T8 + 0 
0fb0 : b9 28 9f LDA $9f28,y ; (connected + 0)
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
0fe3 : 8d 1e 9f STA $9f1e ; (connection_found + 0)
; 182, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0fe6 : a6 5b __ LDX T8 + 0 
0fe8 : 9d 28 9f STA $9f28,x ; (connected + 0)
; 183, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0feb : ee 27 9f INC $9f27 ; (connections_made + 0)
0fee : ad 27 9f LDA $9f27 ; (connections_made + 0)
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
1004 : 8d 1a 9f STA $9f1a ; (j + 0)
1007 : c5 58 __ CMP T5 + 0 
1009 : 90 9b __ BCC $0fa6 ; (generate_level.l60 + 0)
.s49:
; 173, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
100b : 18 __ __ CLC
100c : a5 59 __ LDA T6 + 0 
100e : 69 01 __ ADC #$01
1010 : 8d 26 9f STA $9f26 ; (i + 0)
1013 : c5 58 __ CMP T5 + 0 
1015 : ad 1e 9f LDA $9f1e ; (connection_found + 0)
1018 : b0 0d __ BCS $1027 ; (generate_level.s50 + 0)
.s51:
101a : d0 03 __ BNE $101f ; (generate_level.s80 + 0)
101c : 4c 93 0f JMP $0f93 ; (generate_level.l48 + 0)
.s80:
; 195, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
101f : a9 00 __ LDA #$00
.s1012:
1021 : 8d 1d 9f STA $9f1d ; (failed_attempts + 0)
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
; 674, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
102d : a9 00 __ LDA #$00
102f : f0 05 __ BEQ $1036 ; (print_text.l1 + 0)
.s25:
; 690, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1031 : 18 __ __ CLC
1032 : a5 43 __ LDA T2 + 0 
1034 : 69 01 __ ADC #$01
.l1:
; 674, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1036 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 675, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1039 : 85 43 __ STA T2 + 0 
103b : a8 __ __ TAY
103c : b1 0d __ LDA (P0),y ; (text + 0)
103e : d0 01 __ BNE $1041 ; (print_text.s2 + 0)
.s1001:
; 692, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1040 : 60 __ __ RTS
.s2:
; 676, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1041 : c9 0a __ CMP #$0a
1043 : f0 0a __ BEQ $104f ; (print_text.s4 + 0)
.s5:
; 685, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1045 : a4 43 __ LDY T2 + 0 
1047 : b1 0d __ LDA (P0),y ; (text + 0)
1049 : 20 d2 ff JSR $ffd2 
104c : 4c 31 10 JMP $1031 ; (print_text.s25 + 0)
.s4:
; 679, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
1079 : 8d c8 9f STA $9fc8 ; (path1 + 44)
107c : a5 54 __ LDA T6 + 0 
107e : 8d c9 9f STA $9fc9 ; (path1 + 45)
.s0:
; 213, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1081 : a9 00 __ LDA #$00
1083 : 8d e1 9f STA $9fe1 ; (min_dist2 + 0)
; 215, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1086 : 8d d0 9f STA $9fd0 ; (path1 + 52)
; 217, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1089 : a9 37 __ LDA #$37
108b : 85 0d __ STA P0 
108d : a9 12 __ LDA #$12
108f : 85 0e __ STA P1 
1091 : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
; 220, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1094 : a9 00 __ LDA #$00
1096 : 8d e6 9f STA $9fe6 ; (check_y + 0)
1099 : 18 __ __ CLC
.l1012:
; 221, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
109a : aa __ __ TAX
109b : 9d d1 9f STA $9fd1,x ; (path1 + 53)
; 222, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
109e : ee d0 9f INC $9fd0 ; (path1 + 52)
; 220, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10a1 : 69 01 __ ADC #$01
10a3 : 8d e6 9f STA $9fe6 ; (check_y + 0)
10a6 : c9 10 __ CMP #$10
; 222, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10a8 : ae d0 9f LDX $9fd0 ; (path1 + 52)
10ab : 90 ed __ BCC $109a ; (create_rooms.l1012 + 0)
.s4:
10ad : 86 53 __ STX T5 + 0 
; 225, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10af : 8a __ __ TXA
10b0 : e9 01 __ SBC #$01
10b2 : 85 4f __ STA T2 + 0 
10b4 : 8d e6 9f STA $9fe6 ; (check_y + 0)
10b7 : a9 00 __ LDA #$00
10b9 : e9 00 __ SBC #$00
10bb : 85 50 __ STA T2 + 1 
10bd : a5 4f __ LDA T2 + 0 
10bf : f0 2e __ BEQ $10ef ; (create_rooms.s8 + 0)
.l6:
; 226, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10c1 : ad e6 9f LDA $9fe6 ; (check_y + 0)
10c4 : 18 __ __ CLC
10c5 : 69 01 __ ADC #$01
10c7 : 85 54 __ STA T6 + 0 
10c9 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
10cc : 8d cf 9f STA $9fcf ; (path1 + 51)
; 227, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10cf : aa __ __ TAX
10d0 : ac e6 9f LDY $9fe6 ; (check_y + 0)
10d3 : b9 d1 9f LDA $9fd1,y ; (path1 + 53)
10d6 : 8d ce 9f STA $9fce ; (path1 + 50)
; 228, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10d9 : bd d1 9f LDA $9fd1,x ; (path1 + 53)
10dc : 99 d1 9f STA $9fd1,y ; (path1 + 53)
; 229, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10df : ad ce 9f LDA $9fce ; (path1 + 50)
10e2 : 9d d1 9f STA $9fd1,x ; (path1 + 53)
; 225, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10e5 : 18 __ __ CLC
10e6 : a5 54 __ LDA T6 + 0 
10e8 : 69 fe __ ADC #$fe
10ea : 8d e6 9f STA $9fe6 ; (check_y + 0)
10ed : d0 d2 __ BNE $10c1 ; (create_rooms.l6 + 0)
.s8:
; 233, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10ef : a9 00 __ LDA #$00
10f1 : 8d cd 9f STA $9fcd ; (path1 + 49)
.l10:
; 234, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10f4 : a9 00 __ LDA #$00
10f6 : 8d e6 9f STA $9fe6 ; (check_y + 0)
.l13:
10f9 : ad e6 9f LDA $9fe6 ; (check_y + 0)
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
; 235, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
110c : a9 02 __ LDA #$02
110e : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
; 234, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1111 : a6 51 __ LDX T3 + 0 
1113 : e8 __ __ INX
1114 : 8e e6 9f STX $9fe6 ; (check_y + 0)
; 235, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1117 : aa __ __ TAX
1118 : f0 df __ BEQ $10f9 ; (create_rooms.l13 + 0)
.s17:
; 236, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
111a : a6 4e __ LDX T1 + 0 
111c : bd d1 9f LDA $9fd1,x ; (path1 + 53)
111f : 8d cc 9f STA $9fcc ; (path1 + 48)
; 237, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1122 : bd d2 9f LDA $9fd2,x ; (path1 + 54)
1125 : 9d d1 9f STA $9fd1,x ; (path1 + 53)
; 238, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1128 : ad cc 9f LDA $9fcc ; (path1 + 48)
112b : 9d d2 9f STA $9fd2,x ; (path1 + 54)
112e : 4c f9 10 JMP $10f9 ; (create_rooms.l13 + 0)
.s11:
; 233, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1131 : ee cd 9f INC $9fcd ; (path1 + 49)
1134 : ad cd 9f LDA $9fcd ; (path1 + 49)
1137 : c9 02 __ CMP #$02
1139 : 90 b9 __ BCC $10f4 ; (create_rooms.l10 + 0)
.s12:
; 242, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
113b : a9 00 __ LDA #$00
113d : 8d e6 9f STA $9fe6 ; (check_y + 0)
.l25:
1140 : ad e1 9f LDA $9fe1 ; (min_dist2 + 0)
1143 : c9 14 __ CMP #$14
1145 : 90 03 __ BCC $114a ; (create_rooms.s24 + 0)
1147 : 4c 00 12 JMP $1200 ; (create_rooms.s23 + 0)
.s24:
114a : 85 4f __ STA T2 + 0 
114c : ad e6 9f LDA $9fe6 ; (check_y + 0)
114f : c5 53 __ CMP T5 + 0 
1151 : b0 f4 __ BCS $1147 ; (create_rooms.l25 + 7)
.s21:
; 245, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1153 : 85 51 __ STA T3 + 0 
1155 : a9 0a __ LDA #$0a
1157 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
115a : c9 06 __ CMP #$06
115c : 90 17 __ BCC $1175 ; (create_rooms.s26 + 0)
.s27:
; 258, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
115e : a9 05 __ LDA #$05
1160 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
1163 : 18 __ __ CLC
1164 : 69 04 __ ADC #$04
1166 : a8 __ __ TAY
; 259, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1167 : a9 05 __ LDA #$05
.s167:
; 249, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1169 : 8c e3 9f STY $9fe3 ; (y + 0)
; 250, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
116c : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
116f : 18 __ __ CLC
1170 : 69 04 __ ADC #$04
1172 : 4c 9d 11 JMP $119d ; (create_rooms.s28 + 0)
.s26:
; 247, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1175 : a9 02 __ LDA #$02
1177 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
117a : aa __ __ TAX
117b : f0 0d __ BEQ $118a ; (create_rooms.s30 + 0)
.s29:
; 249, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
117d : a9 04 __ LDA #$04
117f : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
1182 : 18 __ __ CLC
1183 : 69 05 __ ADC #$05
1185 : a8 __ __ TAY
; 250, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1186 : a9 03 __ LDA #$03
1188 : d0 df __ BNE $1169 ; (create_rooms.s167 + 0)
.s30:
; 253, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
118a : a9 03 __ LDA #$03
118c : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
118f : 18 __ __ CLC
1190 : 69 04 __ ADC #$04
1192 : 8d e3 9f STA $9fe3 ; (y + 0)
; 254, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1195 : a9 04 __ LDA #$04
1197 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
119a : 18 __ __ CLC
119b : 69 05 __ ADC #$05
.s28:
; 250, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
119d : 8d e2 9f STA $9fe2 ; (min_dist1 + 0)
; 262, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11a0 : 85 17 __ STA P10 
11a2 : a6 51 __ LDX T3 + 0 
11a4 : bd d1 9f LDA $9fd1,x ; (path1 + 53)
11a7 : 85 15 __ STA P8 
11a9 : ad e3 9f LDA $9fe3 ; (y + 0)
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
; 263, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11cb : ad e5 9f LDA $9fe5 ; (x + 0)
11ce : 85 13 __ STA P6 
11d0 : ad e4 9f LDA $9fe4 ; (tile + 0)
11d3 : 85 14 __ STA P7 
11d5 : a5 52 __ LDA T4 + 0 
11d7 : 85 15 __ STA P8 
11d9 : a5 17 __ LDA P10 
11db : 85 16 __ STA P9 
11dd : 20 a7 15 JSR $15a7 ; (place_room.s0 + 0)
; 264, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11e0 : a6 4f __ LDX T2 + 0 
11e2 : e8 __ __ INX
11e3 : 8e e1 9f STX $9fe1 ; (min_dist2 + 0)
; 265, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11e6 : a9 40 __ LDA #$40
11e8 : 85 0d __ STA P0 
11ea : a9 17 __ LDA #$17
11ec : 85 0e __ STA P1 
11ee : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
.s20:
; 242, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11f1 : 18 __ __ CLC
11f2 : a5 51 __ LDA T3 + 0 
11f4 : 69 01 __ ADC #$01
11f6 : 8d e6 9f STA $9fe6 ; (check_y + 0)
11f9 : c9 14 __ CMP #$14
11fb : b0 03 __ BCS $1200 ; (create_rooms.s23 + 0)
11fd : 4c 40 11 JMP $1140 ; (create_rooms.l25 + 0)
.s23:
; 269, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1200 : ad e1 9f LDA $9fe1 ; (min_dist2 + 0)
1203 : 85 4d __ STA T0 + 0 
1205 : 8d 40 34 STA $3440 ; (room_count + 0)
; 270, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1208 : 20 42 17 JSR $1742 ; (assign_room_priorities.s0 + 0)
; 273, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
120b : 20 8a 17 JSR $178a ; (init_room_center_cache.s0 + 0)
; 276, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
120e : a5 4d __ LDA T0 + 0 
1210 : f0 1a __ BEQ $122c ; (create_rooms.s1001 + 0)
.s35:
; 277, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1212 : a9 00 __ LDA #$00
1214 : 85 0d __ STA P0 
1216 : a9 35 __ LDA #$35
1218 : 85 11 __ STA P4 
121a : a9 88 __ LDA #$88
121c : 85 0e __ STA P1 
121e : a9 35 __ LDA #$35
1220 : 85 0f __ STA P2 
1222 : a9 89 __ LDA #$89
1224 : 85 10 __ STA P3 
1226 : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 278, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1229 : 20 fe 17 JSR $17fe ; (update_camera.s0 + 0)
.s1001:
122c : ad c8 9f LDA $9fc8 ; (path1 + 44)
122f : 85 53 __ STA T5 + 0 
1231 : ad c9 9f LDA $9fc9 ; (path1 + 45)
1234 : 85 54 __ STA T6 + 0 
; 280, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1236 : 60 __ __ RTS
--------------------------------------------------------------------
1237 : __ __ __ BYT 0a 43 52 45 41 54 49 4e 47 20 52 4f 4f 4d 53 00 : .CREATING ROOMS.
--------------------------------------------------------------------
try_place_room_at_grid: ; try_place_room_at_grid(u8,u8,u8,u8*,u8*)->u8
.s0:
;  83, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1247 : a9 00 __ LDA #$00
1249 : 8d e8 9f STA $9fe8 ; (up_y + 0)
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
1289 : 6d e9 9f ADC $9fe9 ; (up_x + 0)
128c : 8d e9 9f STA $9fe9 ; (up_x + 0)
;  97, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
128f : a5 4c __ LDA T2 + 0 
1291 : c9 04 __ CMP #$04
1293 : b0 05 __ BCS $129a ; (try_place_room_at_grid.s9 + 0)
.s7:
1295 : a9 04 __ LDA #$04
1297 : 8d ea 9f STA $9fea ; (i + 0)
.s9:
;  98, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
129a : ad e9 9f LDA $9fe9 ; (up_x + 0)
129d : c9 04 __ CMP #$04
129f : b0 05 __ BCS $12a6 ; (try_place_room_at_grid.s12 + 0)
.s10:
12a1 : a9 04 __ LDA #$04
12a3 : 8d e9 9f STA $9fe9 ; (up_x + 0)
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
12bf : 6d e9 9f ADC $9fe9 ; (up_x + 0)
12c2 : b0 04 __ BCS $12c8 ; (try_place_room_at_grid.s16 + 0)
.s1002:
12c4 : c9 3d __ CMP #$3d
12c6 : 90 0a __ BCC $12d2 ; (try_place_room_at_grid.s6 + 0)
.s16:
12c8 : a9 40 __ LDA #$40
12ca : e5 17 __ SBC P10 ; (h + 0)
12cc : 38 __ __ SEC
12cd : e9 04 __ SBC #$04
12cf : 8d e9 9f STA $9fe9 ; (up_x + 0)
.s6:
; 102, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12d2 : a5 16 __ LDA P9 ; (w + 0)
12d4 : 85 13 __ STA P6 
12d6 : a5 17 __ LDA P10 ; (h + 0)
12d8 : 85 14 __ STA P7 
12da : ad ea 9f LDA $9fea ; (i + 0)
12dd : 85 4b __ STA T1 + 0 
12df : 85 11 __ STA P4 
12e1 : ad e9 9f LDA $9fe9 ; (up_x + 0)
12e4 : 85 12 __ STA P5 
12e6 : 20 cd 13 JSR $13cd ; (can_place_room.s0 + 0)
12e9 : a5 1b __ LDA ACCU + 0 ; (result_y + 0)
12eb : d0 0e __ BNE $12fb ; (try_place_room_at_grid.s19 + 0)
.s21:
; 106, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12ed : ee e8 9f INC $9fe8 ; (up_y + 0)
12f0 : ad e8 9f LDA $9fe8 ; (up_y + 0)
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
1315 : ad e9 9f LDA $9fe9 ; (up_x + 0)
1318 : 91 43 __ STA (T0 + 0),y 
; 105, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
131a : a9 01 __ LDA #$01
131c : 85 1b __ STA ACCU + 0 ; (result_y + 0)
131e : 60 __ __ RTS
--------------------------------------------------------------------
get_grid_position: ; get_grid_position(u8,u8*,u8*)->void
.s0:
; 384, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
131f : a9 0e __ LDA #$0e
1321 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
; 385, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1324 : 8d f1 9f STA $9ff1 ; (cell_h + 0)
; 392, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1327 : 8d ee 9f STA $9fee ; (entropy4 + 1)
; 393, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
132a : 8d ed 9f STA $9fed ; (highest_priority + 0)
; 382, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
132d : a5 0e __ LDA P1 ; (grid_index + 0)
132f : 29 03 __ AND #$03
1331 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
1334 : aa __ __ TAX
; 383, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1335 : a5 0e __ LDA P1 ; (grid_index + 0)
1337 : 4a __ __ LSR
1338 : 4a __ __ LSR
1339 : 8d f3 9f STA $9ff3 ; (grid_y + 0)
; 388, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
133c : bd 31 34 LDA $3431,x ; (__multab14L + 0)
133f : 18 __ __ CLC
1340 : 69 04 __ ADC #$04
1342 : 85 45 __ STA T1 + 0 
1344 : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
; 389, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1347 : ad f3 9f LDA $9ff3 ; (grid_y + 0)
134a : 0a __ __ ASL
134b : 0a __ __ ASL
134c : 0a __ __ ASL
134d : 38 __ __ SEC
134e : ed f3 9f SBC $9ff3 ; (grid_y + 0)
1351 : 0a __ __ ASL
1352 : 18 __ __ CLC
1353 : 69 04 __ ADC #$04
1355 : 85 46 __ STA T2 + 0 
1357 : 8d ef 9f STA $9fef ; (screen_pos + 1)
; 396, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
135a : a9 15 __ LDA #$15
135c : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
135f : 85 44 __ STA T0 + 0 
1361 : 8d ec 9f STA $9fec ; (i + 0)
; 397, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1364 : a9 15 __ LDA #$15
1366 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
1369 : 8d eb 9f STA $9feb ; (screen_offset + 1)
136c : aa __ __ TAX
; 400, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
136d : 18 __ __ CLC
136e : a5 44 __ LDA T0 + 0 
1370 : 65 45 __ ADC T1 + 0 
1372 : 38 __ __ SEC
1373 : e9 07 __ SBC #$07
1375 : a0 00 __ LDY #$00
1377 : 91 0f __ STA (P2),y ; (x + 0)
; 401, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1379 : 8a __ __ TXA
137a : 18 __ __ CLC
137b : 65 46 __ ADC T2 + 0 
137d : 38 __ __ SEC
137e : e9 07 __ SBC #$07
1380 : 91 11 __ STA (P4),y ; (y + 0)
; 404, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1382 : a9 06 __ LDA #$06
1384 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
1387 : 38 __ __ SEC
1388 : e9 03 __ SBC #$03
138a : 18 __ __ CLC
138b : a0 00 __ LDY #$00
138d : 71 0f __ ADC (P2),y ; (x + 0)
138f : 91 0f __ STA (P2),y ; (x + 0)
; 405, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1391 : a9 06 __ LDA #$06
1393 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
1396 : 38 __ __ SEC
1397 : e9 03 __ SBC #$03
1399 : 18 __ __ CLC
139a : a0 00 __ LDY #$00
139c : 71 11 __ ADC (P4),y ; (y + 0)
139e : 91 11 __ STA (P4),y ; (y + 0)
13a0 : aa __ __ TAX
; 408, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
13a1 : b1 0f __ LDA (P2),y ; (x + 0)
13a3 : c9 04 __ CMP #$04
13a5 : b0 08 __ BCS $13af ; (get_grid_position.s3 + 0)
.s1:
13a7 : a9 04 __ LDA #$04
13a9 : 91 0f __ STA (P2),y ; (x + 0)
; 409, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
13ab : b1 11 __ LDA (P4),y ; (y + 0)
13ad : 90 01 __ BCC $13b0 ; (get_grid_position.s1002 + 0)
.s3:
; 409, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
13af : 8a __ __ TXA
.s1002:
13b0 : c9 04 __ CMP #$04
13b2 : b0 04 __ BCS $13b8 ; (get_grid_position.s6 + 0)
.s4:
; 409, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
13b4 : a9 04 __ LDA #$04
13b6 : 91 11 __ STA (P4),y ; (y + 0)
.s6:
; 410, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
13b8 : b1 0f __ LDA (P2),y ; (x + 0)
13ba : c9 35 __ CMP #$35
13bc : 90 04 __ BCC $13c2 ; (get_grid_position.s9 + 0)
.s7:
13be : a9 34 __ LDA #$34
13c0 : 91 0f __ STA (P2),y ; (x + 0)
.s9:
; 411, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
13c2 : b1 11 __ LDA (P4),y ; (y + 0)
13c4 : c9 35 __ CMP #$35
13c6 : 90 04 __ BCC $13cc ; (get_grid_position.s1001 + 0)
.s10:
13c8 : a9 34 __ LDA #$34
13ca : 91 11 __ STA (P4),y ; (y + 0)
.s1001:
; 412, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
1415 : 8d f3 9f STA $9ff3 ; (grid_y + 0)
1418 : 18 __ __ CLC
1419 : a5 49 __ LDA T5 + 0 
141b : 69 04 __ ADC #$04
141d : 85 45 __ STA T1 + 0 
141f : a9 00 __ LDA #$00
1421 : 2a __ __ ROL
1422 : 85 46 __ STA T1 + 1 
1424 : ad f3 9f LDA $9ff3 ; (grid_y + 0)
1427 : 90 08 __ BCC $1431 ; (can_place_room.l12 + 0)
.s14:
;  23, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1429 : 18 __ __ CLC
142a : a5 48 __ LDA T3 + 0 
142c : 69 01 __ ADC #$01
142e : 8d f3 9f STA $9ff3 ; (grid_y + 0)
.l12:
1431 : 85 48 __ STA T3 + 0 
1433 : a5 46 __ LDA T1 + 1 
1435 : d0 07 __ BNE $143e ; (can_place_room.s13 + 0)
.s1014:
1437 : a5 45 __ LDA T1 + 0 
1439 : cd f3 9f CMP $9ff3 ; (grid_y + 0)
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
1465 : ad 40 34 LDA $3440 ; (room_count + 0)
1468 : f0 6f __ BEQ $14d9 ; (can_place_room.s26 + 0)
.s1022:
146a : 85 1b __ STA ACCU + 0 
146c : a6 49 __ LDX T5 + 0 
.l24:
;  38, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
146e : 8e ee 9f STX $9fee ; (entropy4 + 1)
;  39, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1471 : a5 4a __ LDA T7 + 0 
1473 : 8d ed 9f STA $9fed ; (highest_priority + 0)
;  42, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1476 : a9 05 __ LDA #$05
1478 : 8d ec 9f STA $9fec ; (i + 0)
;  43, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
147b : 8d eb 9f STA $9feb ; (screen_offset + 1)
;  36, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
147e : ad f1 9f LDA $9ff1 ; (cell_h + 0)
1481 : 0a __ __ ASL
1482 : 0a __ __ ASL
1483 : 0a __ __ ASL
1484 : a8 __ __ TAY
1485 : b9 02 43 LDA $4302,y ; (rooms + 2)
1488 : 79 00 43 ADC $4300,y ; (rooms + 0)
148b : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
;  37, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
148e : b9 03 43 LDA $4303,y ; (rooms + 3)
1491 : 18 __ __ CLC
1492 : 79 01 43 ADC $4301,y ; (rooms + 1)
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
14ac : d9 00 43 CMP $4300,y ; (rooms + 0)
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
14c8 : d9 01 43 CMP $4301,y ; (rooms + 1)
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
; 476, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 476, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
14ed : a9 00 __ LDA #$00
.s1001:
14ef : 60 __ __ RTS
--------------------------------------------------------------------
tile_is_empty: ; tile_is_empty(u8,u8)->u8
.s0:
; 283, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 284, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 258, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 249, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1532 : e8 __ __ INX
.s1013:
1533 : 18 __ __ CLC
1534 : 65 0d __ ADC P0 ; (x + 0)
1536 : 90 01 __ BCC $1539 ; (get_tile_core.s1015 + 0)
.s1014:
; 249, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1538 : e8 __ __ INX
.s1015:
1539 : 18 __ __ CLC
153a : 65 0d __ ADC P0 ; (x + 0)
153c : 8d f8 9f STA $9ff8 ; (room + 1)
153f : 8a __ __ TXA
1540 : 69 00 __ ADC #$00
1542 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 252, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1545 : 4a __ __ LSR
1546 : 85 44 __ STA T1 + 1 
1548 : ad f8 9f LDA $9ff8 ; (room + 1)
154b : 6a __ __ ROR
154c : 46 44 __ LSR T1 + 1 
154e : 6a __ __ ROR
154f : 46 44 __ LSR T1 + 1 
1551 : 6a __ __ ROR
1552 : 18 __ __ CLC
1553 : 69 76 __ ADC #$76
1555 : 85 43 __ STA T1 + 0 
1557 : 8d f6 9f STA $9ff6 ; (room_center_y + 0)
155a : a9 39 __ LDA #$39
155c : 65 44 __ ADC T1 + 1 
155e : 85 44 __ STA T1 + 1 
1560 : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
; 253, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1563 : ad f8 9f LDA $9ff8 ; (room + 1)
1566 : 29 07 __ AND #$07
1568 : 85 1b __ STA ACCU + 0 
156a : 8d f5 9f STA $9ff5 ; (s + 1)
; 258, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
156d : aa __ __ TAX
156e : a0 00 __ LDY #$00
1570 : b1 43 __ LDA (T1 + 0),y 
1572 : e0 00 __ CPX #$00
1574 : f0 04 __ BEQ $157a ; (get_tile_core.s1003 + 0)
.l1002:
; 258, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1576 : 4a __ __ LSR
1577 : ca __ __ DEX
1578 : d0 fc __ BNE $1576 ; (get_tile_core.l1002 + 0)
.s1003:
; 256, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
157a : 85 1c __ STA ACCU + 1 
157c : a5 1b __ LDA ACCU + 0 
157e : c9 06 __ CMP #$06
1580 : b0 05 __ BCS $1587 ; (get_tile_core.s3 + 0)
.s1:
; 258, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1582 : a5 1c __ LDA ACCU + 1 
.s1001:
; 263, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1584 : 29 07 __ AND #$07
1586 : 60 __ __ RTS
.s3:
; 262, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1587 : a9 08 __ LDA #$08
1589 : e5 1b __ SBC ACCU + 0 
158b : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
; 263, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
158e : aa __ __ TAX
158f : bd 74 35 LDA $3574,x ; (bitshift + 36)
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
; 263, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
15d8 : ad 40 34 LDA $3440 ; (room_count + 0)
15db : c9 14 __ CMP #$14
15dd : b0 25 __ BCS $1604 ; (place_room.s1001 + 0)
.s12:
;  69, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15df : 0a __ __ ASL
15e0 : 0a __ __ ASL
15e1 : 0a __ __ ASL
15e2 : aa __ __ TAX
15e3 : a5 13 __ LDA P6 ; (x + 0)
15e5 : 9d 00 43 STA $4300,x ; (rooms + 0)
;  70, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15e8 : a5 14 __ LDA P7 ; (y + 0)
15ea : 9d 01 43 STA $4301,x ; (rooms + 1)
;  71, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15ed : a5 15 __ LDA P8 ; (w + 0)
15ef : 9d 02 43 STA $4302,x ; (rooms + 2)
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15f2 : a5 16 __ LDA P9 ; (h + 0)
15f4 : 9d 03 43 STA $4303,x ; (rooms + 3)
;  74, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15f7 : a9 00 __ LDA #$00
15f9 : 9d 04 43 STA $4304,x ; (rooms + 4)
;  73, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15fc : a9 05 __ LDA #$05
15fe : 9d 07 43 STA $4307,x ; (rooms + 7)
;  75, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1601 : ee 40 34 INC $3440 ; (room_count + 0)
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
; 295, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 217, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 229, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 220, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1675 : e8 __ __ INX
.s1023:
1676 : 18 __ __ CLC
1677 : 65 0d __ ADC P0 ; (x + 0)
1679 : 90 01 __ BCC $167c ; (set_compact_tile_fast.s1025 + 0)
.s1024:
; 220, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
167b : e8 __ __ INX
.s1025:
167c : 18 __ __ CLC
167d : 65 0d __ ADC P0 ; (x + 0)
167f : 8d f8 9f STA $9ff8 ; (room + 1)
1682 : 8a __ __ TXA
1683 : 69 00 __ ADC #$00
1685 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 223, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1688 : 4a __ __ LSR
1689 : 85 44 __ STA T1 + 1 
168b : ad f8 9f LDA $9ff8 ; (room + 1)
168e : 6a __ __ ROR
168f : 46 44 __ LSR T1 + 1 
1691 : 6a __ __ ROR
1692 : 46 44 __ LSR T1 + 1 
1694 : 6a __ __ ROR
1695 : 18 __ __ CLC
1696 : 69 76 __ ADC #$76
1698 : 85 43 __ STA T1 + 0 
169a : 8d f6 9f STA $9ff6 ; (room_center_y + 0)
169d : a9 39 __ LDA #$39
169f : 65 44 __ ADC T1 + 1 
16a1 : 85 44 __ STA T1 + 1 
16a3 : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
; 224, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16a6 : ad f8 9f LDA $9ff8 ; (room + 1)
16a9 : 29 07 __ AND #$07
16ab : 85 1b __ STA ACCU + 0 
16ad : 8d f5 9f STA $9ff5 ; (s + 1)
; 229, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 231, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16c2 : aa __ __ TAX
16c3 : bd 35 34 LDA $3435,x ; (__shltab7L + 0)
16c6 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
; 232, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 232, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16d9 : 05 1c __ ORA ACCU + 1 
.s1017:
; 242, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16db : 91 43 __ STA (T1 + 0),y 
16dd : 60 __ __ RTS
.s7:
; 235, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16de : a9 08 __ LDA #$08
16e0 : e5 1b __ SBC ACCU + 0 
16e2 : 85 1e __ STA ACCU + 3 
16e4 : 8d f3 9f STA $9ff3 ; (grid_y + 0)
; 236, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16e7 : aa __ __ TAX
16e8 : 49 03 __ EOR #$03
16ea : 85 45 __ STA T5 + 0 
16ec : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
; 238, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16ef : bd 58 35 LDA $3558,x ; (bitshift + 8)
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
; 238, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16ff : 85 47 __ STA T7 + 0 
1701 : 8d f1 9f STA $9ff1 ; (cell_h + 0)
; 239, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1704 : a6 45 __ LDX T5 + 0 
1706 : bd 58 35 LDA $3558,x ; (bitshift + 8)
1709 : 38 __ __ SEC
170a : e9 01 __ SBC #$01
170c : 85 45 __ STA T5 + 0 
170e : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
; 241, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1711 : a5 1d __ LDA ACCU + 2 
1713 : 25 46 __ AND T6 + 0 
1715 : a6 1b __ LDX ACCU + 0 
1717 : f0 04 __ BEQ $171d ; (set_compact_tile_fast.s1005 + 0)
.l1012:
1719 : 0a __ __ ASL
171a : ca __ __ DEX
171b : d0 fc __ BNE $1719 ; (set_compact_tile_fast.l1012 + 0)
.s1005:
; 241, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
171d : 85 46 __ STA T6 + 0 
171f : a9 ff __ LDA #$ff
1721 : 45 47 __ EOR T7 + 0 
1723 : 25 1c __ AND ACCU + 1 
1725 : 05 46 __ ORA T6 + 0 
1727 : 91 43 __ STA (T1 + 0),y 
; 242, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
1747 : ad 40 34 LDA $3440 ; (room_count + 0)
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
177d : 9d 07 43 STA $4307,x ; (rooms + 7)
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
; 354, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
178a : a9 00 __ LDA #$00
178c : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
178f : ad 40 34 LDA $3440 ; (room_count + 0)
1792 : f0 64 __ BEQ $17f8 ; (init_room_center_cache.s4 + 0)
.l5:
1794 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
1797 : c9 14 __ CMP #$14
1799 : b0 5d __ BCS $17f8 ; (init_room_center_cache.s4 + 0)
.s2:
; 356, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
179b : 85 1b __ STA ACCU + 0 
179d : 0a __ __ ASL
179e : 0a __ __ ASL
179f : 0a __ __ ASL
17a0 : aa __ __ TAX
17a1 : bd 02 43 LDA $4302,x ; (rooms + 2)
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
17bb : bd 00 43 LDA $4300,x ; (rooms + 0)
17be : 18 __ __ CLC
17bf : 65 1c __ ADC ACCU + 1 
17c1 : 06 1b __ ASL ACCU + 0 
17c3 : a4 1b __ LDY ACCU + 0 
17c5 : 99 96 42 STA $4296,y ; (room_center_cache + 0)
; 357, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
17c8 : bd 03 43 LDA $4303,x ; (rooms + 3)
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
17e2 : bd 01 43 LDA $4301,x ; (rooms + 1)
17e5 : 18 __ __ CLC
17e6 : 65 1c __ ADC ACCU + 1 
17e8 : a6 1b __ LDX ACCU + 0 
17ea : 9d 97 42 STA $4297,x ; (room_center_cache + 1)
; 354, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
17ed : ee f9 9f INC $9ff9 ; (bit_offset + 1)
17f0 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
17f3 : cd 40 34 CMP $3440 ; (room_count + 0)
17f6 : 90 9c __ BCC $1794 ; (init_room_center_cache.l5 + 0)
.s4:
; 359, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
17f8 : a9 01 __ LDA #$01
17fa : 8d 41 34 STA $3441 ; (room_center_cache_valid + 0)
.s1001:
; 360, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
17fd : 60 __ __ RTS
--------------------------------------------------------------------
update_camera: ; update_camera()->void
.s0:
;  49, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
17fe : ad 8a 35 LDA $358a ; (view + 0)
1801 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
;  50, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1804 : ad 8b 35 LDA $358b ; (view + 1)
1807 : 8d f8 9f STA $9ff8 ; (room + 1)
;  52, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
180a : ad 89 35 LDA $3589 ; (camera_center_y + 0)
180d : 8d f6 9f STA $9ff6 ; (room_center_y + 0)
;  51, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1810 : ad 88 35 LDA $3588 ; (camera_center_x + 0)
1813 : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
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
1820 : 8d 8a 35 STA $358a ; (view + 0)
;  61, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1823 : ad 89 35 LDA $3589 ; (camera_center_y + 0)
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
1830 : 8d 8b 35 STA $358b ; (view + 1)
;  68, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1833 : a9 18 __ LDA #$18
1835 : cd 8a 35 CMP $358a ; (view + 0)
1838 : b0 03 __ BCS $183d ; (update_camera.s20 + 0)
.s7:
;  69, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
183a : 8d 8a 35 STA $358a ; (view + 0)
.s20:
;  71, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
183d : a9 27 __ LDA #$27
183f : cd 8b 35 CMP $358b ; (view + 1)
1842 : b0 03 __ BCS $1847 ; (update_camera.s12 + 0)
.s10:
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1844 : 8d 8b 35 STA $358b ; (view + 1)
.s12:
;  77, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1847 : ad 8a 35 LDA $358a ; (view + 0)
184a : 18 __ __ CLC
184b : 69 14 __ ADC #$14
184d : 8d 88 35 STA $3588 ; (camera_center_x + 0)
;  78, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1850 : ad 8b 35 LDA $358b ; (view + 1)
1853 : 18 __ __ CLC
1854 : 69 0c __ ADC #$0c
1856 : 8d 89 35 STA $3589 ; (camera_center_y + 0)
;  81, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1859 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
185c : cd 8a 35 CMP $358a ; (view + 0)
185f : d0 08 __ BNE $1869 ; (update_camera.s13 + 0)
.s16:
1861 : ad f8 9f LDA $9ff8 ; (room + 1)
1864 : cd 8b 35 CMP $358b ; (view + 1)
1867 : f0 05 __ BEQ $186e ; (update_camera.s1001 + 0)
.s13:
;  82, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1869 : a9 01 __ LDA #$01
186b : 8d 74 39 STA $3974 ; (screen_dirty + 0)
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
; 502, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1891 : a5 0d __ LDA P0 ; (room1 + 0)
1893 : cd 40 34 CMP $3440 ; (room_count + 0)
1896 : b0 07 __ BCS $189f ; (rooms_are_connected.s1 + 0)
.s4:
1898 : a4 0e __ LDY P1 ; (room2 + 0)
; 502, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
189a : cc 40 34 CPY $3440 ; (room_count + 0)
189d : 90 03 __ BCC $18a2 ; (rooms_are_connected.s3 + 0)
.s1:
189f : a9 00 __ LDA #$00
18a1 : 60 __ __ RTS
.s3:
; 503, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
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
18af : 69 76 __ ADC #$76
18b1 : 85 1b __ STA ACCU + 0 
18b3 : a9 3f __ LDA #$3f
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
18be : cd 40 34 CMP $3440 ; (room_count + 0)
18c1 : b0 1f __ BCS $18e2 ; (can_connect_rooms_safely.s1 + 0)
.s5:
18c3 : a5 18 __ LDA P11 ; (room2 + 0)
18c5 : cd 40 34 CMP $3440 ; (room_count + 0)
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
18ed : bd 00 43 LDA $4300,x ; (rooms + 0)
18f0 : 38 __ __ SEC
18f1 : e9 04 __ SBC #$04
18f3 : 8d f3 9f STA $9ff3 ; (grid_y + 0)
;  88, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18f6 : bd 01 43 LDA $4301,x ; (rooms + 1)
18f9 : 38 __ __ SEC
18fa : e9 04 __ SBC #$04
18fc : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
;  89, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18ff : bd 02 43 LDA $4302,x ; (rooms + 2)
1902 : 18 __ __ CLC
1903 : 7d 00 43 ADC $4300,x ; (rooms + 0)
1906 : 18 __ __ CLC
1907 : 69 04 __ ADC #$04
1909 : 8d f1 9f STA $9ff1 ; (cell_h + 0)
;  90, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
190c : bd 03 43 LDA $4303,x ; (rooms + 3)
190f : 18 __ __ CLC
1910 : 7d 01 43 ADC $4301,x ; (rooms + 1)
1913 : 18 __ __ CLC
1914 : 69 04 __ ADC #$04
1916 : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
;  91, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1919 : a5 18 __ LDA P11 ; (room2 + 0)
191b : 0a __ __ ASL
191c : 0a __ __ ASL
191d : 0a __ __ ASL
191e : aa __ __ TAX
191f : bd 00 43 LDA $4300,x ; (rooms + 0)
1922 : 38 __ __ SEC
1923 : e9 04 __ SBC #$04
1925 : 8d ef 9f STA $9fef ; (screen_pos + 1)
;  92, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1928 : bd 01 43 LDA $4301,x ; (rooms + 1)
192b : 38 __ __ SEC
192c : e9 04 __ SBC #$04
192e : 8d ee 9f STA $9fee ; (entropy4 + 1)
;  93, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1931 : bd 02 43 LDA $4302,x ; (rooms + 2)
1934 : 18 __ __ CLC
1935 : 7d 00 43 ADC $4300,x ; (rooms + 0)
1938 : 18 __ __ CLC
1939 : 69 04 __ ADC #$04
193b : 8d ed 9f STA $9fed ; (highest_priority + 0)
;  94, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
193e : bd 03 43 LDA $4303,x ; (rooms + 3)
1941 : 18 __ __ CLC
1942 : 7d 01 43 ADC $4301,x ; (rooms + 1)
1945 : 18 __ __ CLC
1946 : 69 04 __ ADC #$04
1948 : 8d ec 9f STA $9fec ; (i + 0)
;  97, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
194b : ad ef 9f LDA $9fef ; (screen_pos + 1)
194e : cd f1 9f CMP $9ff1 ; (cell_h + 0)
1951 : b0 1b __ BCS $196e ; (can_connect_rooms_safely.s13 + 0)
.s16:
1953 : ad f3 9f LDA $9ff3 ; (grid_y + 0)
1956 : cd ed 9f CMP $9fed ; (highest_priority + 0)
1959 : b0 13 __ BCS $196e ; (can_connect_rooms_safely.s13 + 0)
.s15:
;  98, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
195b : ad ee 9f LDA $9fee ; (entropy4 + 1)
195e : cd f0 9f CMP $9ff0 ; (entropy3 + 1)
1961 : b0 0b __ BCS $196e ; (can_connect_rooms_safely.s13 + 0)
.s14:
1963 : ad f2 9f LDA $9ff2 ; (entropy2 + 1)
1966 : cd ec 9f CMP $9fec ; (i + 0)
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
1973 : ad 4d 35 LDA $354d ; (distance_cache_valid + 0)
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
19a0 : 69 06 __ ADC #$06
19a2 : 85 45 __ STA T0 + 0 
19a4 : 8a __ __ TXA
19a5 : 69 41 __ ADC #$41
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
19d2 : 69 06 __ ADC #$06
19d4 : 85 45 __ STA T0 + 0 
19d6 : 98 __ __ TYA
19d7 : 69 41 __ ADC #$41
19d9 : 85 46 __ STA T0 + 1 
19db : 8a __ __ TXA
19dc : a4 15 __ LDY P8 ; (room1 + 0)
19de : 91 45 __ STA (T0 + 0),y 
;  67, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
19e0 : 4c 8f 19 JMP $198f ; (get_cached_room_distance.s1001 + 0)
--------------------------------------------------------------------
rule_based_connect_rooms: ; rule_based_connect_rooms(u8,u8)->u8
.s1000:
19e3 : a2 03 __ LDX #$03
19e5 : b5 53 __ LDA T5 + 0,x 
19e7 : 9d 3c 9f STA $9f3c,x ; (rule_based_connect_rooms@stack + 0)
19ea : ca __ __ DEX
19eb : 10 f8 __ BPL $19e5 ; (rule_based_connect_rooms.s1000 + 2)
.s0:
; 426, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
19ed : ad fe 9f LDA $9ffe ; (sstack + 4)
19f0 : 85 55 __ STA T8 + 0 
19f2 : 85 17 __ STA P10 
19f4 : ad ff 9f LDA $9fff ; (sstack + 5)
19f7 : 85 56 __ STA T9 + 0 
19f9 : 85 18 __ STA P11 
19fb : 20 bc 18 JSR $18bc ; (can_connect_rooms_safely.s0 + 0)
19fe : a5 1b __ LDA ACCU + 0 
1a00 : d0 03 __ BNE $1a05 ; (rule_based_connect_rooms.s3 + 0)
1a02 : 4c 8a 1a JMP $1a8a ; (rule_based_connect_rooms.s1001 + 0)
.s3:
; 431, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a05 : a5 55 __ LDA T8 + 0 
1a07 : 0a __ __ ASL
1a08 : 0a __ __ ASL
1a09 : 65 55 __ ADC T8 + 0 
1a0b : 0a __ __ ASL
1a0c : 0a __ __ ASL
1a0d : a2 00 __ LDX #$00
1a0f : 90 01 __ BCC $1a12 ; (rule_based_connect_rooms.s1005 + 0)
.s1004:
1a11 : e8 __ __ INX
.s1005:
1a12 : 18 __ __ CLC
1a13 : 69 76 __ ADC #$76
1a15 : 85 53 __ STA T5 + 0 
1a17 : 8a __ __ TXA
1a18 : 69 3f __ ADC #$3f
1a1a : 85 54 __ STA T5 + 1 
1a1c : a4 56 __ LDY T9 + 0 
1a1e : b1 53 __ LDA (T5 + 0),y 
1a20 : d0 66 __ BNE $1a88 ; (rule_based_connect_rooms.s5 + 0)
.s7:
; 439, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a22 : 8d 46 9f STA $9f46 ; (i + 0)
; 438, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a25 : 8d 45 9f STA $9f45 ; (sp + 0)
.l10:
; 439, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a28 : a9 00 __ LDA #$00
1a2a : ae 46 9f LDX $9f46 ; (i + 0)
1a2d : 9d be 42 STA $42be,x ; (visited_global + 0)
1a30 : ee 46 9f INC $9f46 ; (i + 0)
1a33 : ad 46 9f LDA $9f46 ; (i + 0)
1a36 : c9 14 __ CMP #$14
1a38 : 90 ee __ BCC $1a28 ; (rule_based_connect_rooms.l10 + 0)
.s12:
; 440, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a3a : a9 01 __ LDA #$01
1a3c : 8d 45 9f STA $9f45 ; (sp + 0)
1a3f : a6 55 __ LDX T8 + 0 
1a41 : 8e d2 42 STX $42d2 ; (stack_global + 0)
; 441, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a44 : 9d be 42 STA $42be,x ; (visited_global + 0)
.l14:
; 444, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a47 : a9 00 __ LDA #$00
1a49 : 8d 46 9f STA $9f46 ; (i + 0)
; 443, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a4c : ae 45 9f LDX $9f45 ; (sp + 0)
1a4f : ce 45 9f DEC $9f45 ; (sp + 0)
1a52 : bd d1 42 LDA $42d1,x ; (visited_global + 19)
1a55 : 8d 44 9f STA $9f44 ; (current + 0)
; 444, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a58 : ad 40 34 LDA $3440 ; (room_count + 0)
1a5b : f0 51 __ BEQ $1aae ; (rule_based_connect_rooms.s13 + 0)
.s49:
; 445, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a5d : 85 49 __ STA T6 + 0 
1a5f : bd d1 42 LDA $42d1,x ; (visited_global + 19)
1a62 : 0a __ __ ASL
1a63 : 0a __ __ ASL
1a64 : 7d d1 42 ADC $42d1,x ; (visited_global + 19)
1a67 : 0a __ __ ASL
1a68 : 0a __ __ ASL
1a69 : a2 00 __ LDX #$00
1a6b : 90 01 __ BCC $1a6e ; (rule_based_connect_rooms.s1007 + 0)
.s1006:
1a6d : e8 __ __ INX
.s1007:
1a6e : 18 __ __ CLC
1a6f : 69 76 __ ADC #$76
1a71 : 85 43 __ STA T0 + 0 
1a73 : 8a __ __ TXA
1a74 : 69 3f __ ADC #$3f
1a76 : 85 44 __ STA T0 + 1 
.l17:
1a78 : ac 46 9f LDY $9f46 ; (i + 0)
1a7b : b1 43 __ LDA (T0 + 0),y 
1a7d : f0 27 __ BEQ $1aa6 ; (rule_based_connect_rooms.s16 + 0)
.s23:
1a7f : b9 be 42 LDA $42be,y ; (visited_global + 0)
1a82 : d0 22 __ BNE $1aa6 ; (rule_based_connect_rooms.s16 + 0)
.s20:
; 446, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a84 : c4 56 __ CPY T9 + 0 
1a86 : d0 0f __ BNE $1a97 ; (rule_based_connect_rooms.s26 + 0)
.s5:
; 432, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a88 : a9 01 __ LDA #$01
.s1001:
; 427, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a8a : 85 1b __ STA ACCU + 0 
1a8c : a2 03 __ LDX #$03
1a8e : bd 3c 9f LDA $9f3c,x ; (rule_based_connect_rooms@stack + 0)
1a91 : 95 53 __ STA T5 + 0,x 
1a93 : ca __ __ DEX
1a94 : 10 f8 __ BPL $1a8e ; (rule_based_connect_rooms.s1001 + 4)
1a96 : 60 __ __ RTS
.s26:
; 449, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a97 : a9 01 __ LDA #$01
1a99 : 99 be 42 STA $42be,y ; (visited_global + 0)
; 450, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a9c : ae 45 9f LDX $9f45 ; (sp + 0)
1a9f : ee 45 9f INC $9f45 ; (sp + 0)
1aa2 : 98 __ __ TYA
1aa3 : 9d d2 42 STA $42d2,x ; (stack_global + 0)
.s16:
; 444, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1aa6 : c8 __ __ INY
1aa7 : 8c 46 9f STY $9f46 ; (i + 0)
1aaa : c4 49 __ CPY T6 + 0 
1aac : 90 ca __ BCC $1a78 ; (rule_based_connect_rooms.l17 + 0)
.s13:
; 442, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1aae : ad 45 9f LDA $9f45 ; (sp + 0)
1ab1 : d0 94 __ BNE $1a47 ; (rule_based_connect_rooms.l14 + 0)
.s15:
; 456, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ab3 : a5 55 __ LDA T8 + 0 
1ab5 : 85 13 __ STA P6 
1ab7 : a5 56 __ LDA T9 + 0 
1ab9 : 85 14 __ STA P7 
1abb : 20 08 1b JSR $1b08 ; (can_reuse_existing_path.s0 + 0)
1abe : a5 1b __ LDA ACCU + 0 
1ac0 : f0 11 __ BEQ $1ad3 ; (rule_based_connect_rooms.s30 + 0)
.s28:
; 457, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ac2 : a5 13 __ LDA P6 
1ac4 : 8d fc 9f STA $9ffc ; (sstack + 2)
1ac7 : a5 14 __ LDA P7 
1ac9 : 8d fd 9f STA $9ffd ; (sstack + 3)
1acc : 20 09 1d JSR $1d09 ; (connect_via_existing_corridors.s1000 + 0)
1acf : a5 1b __ LDA ACCU + 0 
1ad1 : d0 10 __ BNE $1ae3 ; (rule_based_connect_rooms.s31 + 0)
.s30:
; 464, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ad3 : a5 55 __ LDA T8 + 0 
1ad5 : 8d fc 9f STA $9ffc ; (sstack + 2)
1ad8 : a5 56 __ LDA T9 + 0 
1ada : 8d fd 9f STA $9ffd ; (sstack + 3)
1add : 20 cd 26 JSR $26cd ; (draw_rule_based_corridor.s0 + 0)
1ae0 : aa __ __ TAX
1ae1 : f0 a7 __ BEQ $1a8a ; (rule_based_connect_rooms.s1001 + 0)
.s31:
; 458, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ae3 : a9 01 __ LDA #$01
1ae5 : a4 56 __ LDY T9 + 0 
1ae7 : 91 53 __ STA (T5 + 0),y 
; 459, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ae9 : 98 __ __ TYA
1aea : 0a __ __ ASL
1aeb : 0a __ __ ASL
1aec : 65 56 __ ADC T9 + 0 
1aee : 0a __ __ ASL
1aef : 0a __ __ ASL
1af0 : a2 00 __ LDX #$00
1af2 : 90 01 __ BCC $1af5 ; (rule_based_connect_rooms.s1009 + 0)
.s1008:
1af4 : e8 __ __ INX
.s1009:
1af5 : 18 __ __ CLC
1af6 : 69 76 __ ADC #$76
1af8 : 85 43 __ STA T0 + 0 
1afa : 8a __ __ TXA
1afb : 69 3f __ ADC #$3f
1afd : 85 44 __ STA T0 + 1 
1aff : a9 01 __ LDA #$01
1b01 : a4 55 __ LDY T8 + 0 
1b03 : 91 43 __ STA (T0 + 0),y 
; 460, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b05 : 4c 8a 1a JMP $1a8a ; (rule_based_connect_rooms.s1001 + 0)
--------------------------------------------------------------------
can_reuse_existing_path: ; can_reuse_existing_path(u8,u8)->u8
.s0:
; 234, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b08 : a5 13 __ LDA P6 ; (room1 + 0)
1b0a : 85 0d __ STA P0 
1b0c : a9 f3 __ LDA #$f3
1b0e : 85 0e __ STA P1 
1b10 : a9 9f __ LDA #$9f
1b12 : 85 11 __ STA P4 
1b14 : a9 9f __ LDA #$9f
1b16 : 85 0f __ STA P2 
1b18 : a9 f2 __ LDA #$f2
1b1a : 85 10 __ STA P3 
1b1c : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 235, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b1f : a5 14 __ LDA P7 ; (room2 + 0)
1b21 : 85 0d __ STA P0 
1b23 : a9 f1 __ LDA #$f1
1b25 : 85 0e __ STA P1 
1b27 : a9 9f __ LDA #$9f
1b29 : 85 11 __ STA P4 
1b2b : a9 9f __ LDA #$9f
1b2d : 85 0f __ STA P2 
1b2f : a9 f0 __ LDA #$f0
1b31 : 85 10 __ STA P3 
1b33 : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 239, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b36 : a9 00 __ LDA #$00
1b38 : 8d ef 9f STA $9fef ; (screen_pos + 1)
1b3b : 8d ee 9f STA $9fee ; (entropy4 + 1)
; 242, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b3e : a9 fc __ LDA #$fc
1b40 : 8d ed 9f STA $9fed ; (highest_priority + 0)
.l2:
; 243, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b43 : a9 fc __ LDA #$fc
1b45 : 8d ec 9f STA $9fec ; (i + 0)
1b48 : ad ef 9f LDA $9fef ; (screen_pos + 1)
1b4b : d0 59 __ BNE $1ba6 ; (can_reuse_existing_path.s3 + 0)
.l7:
; 244, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b4d : ad ed 9f LDA $9fed ; (highest_priority + 0)
1b50 : 18 __ __ CLC
1b51 : 6d f3 9f ADC $9ff3 ; (grid_y + 0)
1b54 : 85 46 __ STA T2 + 0 
1b56 : 85 0d __ STA P0 
1b58 : 8d eb 9f STA $9feb ; (screen_offset + 1)
; 245, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b5b : ad ec 9f LDA $9fec ; (i + 0)
1b5e : 85 47 __ STA T3 + 0 
1b60 : 18 __ __ CLC
1b61 : 6d f2 9f ADC $9ff2 ; (entropy2 + 1)
1b64 : 85 45 __ STA T0 + 0 
1b66 : 85 0e __ STA P1 
1b68 : 8d ea 9f STA $9fea ; (i + 0)
; 247, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b6b : 20 4e 1c JSR $1c4e ; (coords_in_bounds_fast.s0 + 0)
1b6e : aa __ __ TAX
1b6f : f0 22 __ BEQ $1b93 ; (can_reuse_existing_path.s6 + 0)
.s15:
; 248, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b71 : a5 0d __ LDA P0 
1b73 : 85 11 __ STA P4 
1b75 : a5 0e __ LDA P1 
1b77 : 85 12 __ STA P5 
1b79 : 20 61 1c JSR $1c61 ; (tile_is_floor_fast.s0 + 0)
1b7c : a5 1b __ LDA ACCU + 0 
1b7e : f0 13 __ BEQ $1b93 ; (can_reuse_existing_path.s6 + 0)
.s14:
; 249, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b80 : a5 46 __ LDA T2 + 0 
1b82 : 85 0f __ STA P2 
1b84 : a5 45 __ LDA T0 + 0 
1b86 : 85 10 __ STA P3 
1b88 : 20 a5 1c JSR $1ca5 ; (is_outside_any_room.s0 + 0)
1b8b : aa __ __ TAX
1b8c : f0 05 __ BEQ $1b93 ; (can_reuse_existing_path.s6 + 0)
.s11:
; 250, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b8e : a9 01 __ LDA #$01
1b90 : 8d ef 9f STA $9fef ; (screen_pos + 1)
.s6:
; 243, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b93 : 18 __ __ CLC
1b94 : a5 47 __ LDA T3 + 0 
1b96 : 69 01 __ ADC #$01
1b98 : 8d ec 9f STA $9fec ; (i + 0)
1b9b : 30 04 __ BMI $1ba1 ; (can_reuse_existing_path.s10 + 0)
.s1007:
1b9d : c9 05 __ CMP #$05
1b9f : b0 05 __ BCS $1ba6 ; (can_reuse_existing_path.s3 + 0)
.s10:
; 243, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ba1 : ad ef 9f LDA $9fef ; (screen_pos + 1)
1ba4 : f0 a7 __ BEQ $1b4d ; (can_reuse_existing_path.l7 + 0)
.s3:
; 242, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ba6 : ad ed 9f LDA $9fed ; (highest_priority + 0)
1ba9 : ee ed 9f INC $9fed ; (highest_priority + 0)
1bac : 49 80 __ EOR #$80
1bae : c9 84 __ CMP #$84
1bb0 : ad ef 9f LDA $9fef ; (screen_pos + 1)
1bb3 : 90 03 __ BCC $1bb8 ; (can_reuse_existing_path.s5 + 0)
1bb5 : 4c 49 1c JMP $1c49 ; (can_reuse_existing_path.s4 + 0)
.s5:
1bb8 : f0 89 __ BEQ $1b43 ; (can_reuse_existing_path.l2 + 0)
.s18:
; 259, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bba : 85 47 __ STA T3 + 0 
1bbc : a9 fc __ LDA #$fc
1bbe : 8d e9 9f STA $9fe9 ; (up_x + 0)
1bc1 : ad ee 9f LDA $9fee ; (entropy4 + 1)
1bc4 : d0 75 __ BNE $1c3b ; (can_reuse_existing_path.s23 + 0)
.l21:
; 260, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bc6 : a9 fc __ LDA #$fc
1bc8 : 8d e8 9f STA $9fe8 ; (up_y + 0)
1bcb : ad ee 9f LDA $9fee ; (entropy4 + 1)
1bce : d0 59 __ BNE $1c29 ; (can_reuse_existing_path.s22 + 0)
.l26:
; 261, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bd0 : ad e9 9f LDA $9fe9 ; (up_x + 0)
1bd3 : 18 __ __ CLC
1bd4 : 6d f1 9f ADC $9ff1 ; (cell_h + 0)
1bd7 : 85 46 __ STA T2 + 0 
1bd9 : 85 0d __ STA P0 
1bdb : 8d e7 9f STA $9fe7 ; (down_x + 0)
; 262, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bde : ad e8 9f LDA $9fe8 ; (up_y + 0)
1be1 : 85 48 __ STA T4 + 0 
1be3 : 18 __ __ CLC
1be4 : 6d f0 9f ADC $9ff0 ; (entropy3 + 1)
1be7 : 85 45 __ STA T0 + 0 
1be9 : 85 0e __ STA P1 
1beb : 8d e6 9f STA $9fe6 ; (check_y + 0)
; 264, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bee : 20 4e 1c JSR $1c4e ; (coords_in_bounds_fast.s0 + 0)
1bf1 : aa __ __ TAX
1bf2 : f0 22 __ BEQ $1c16 ; (can_reuse_existing_path.s25 + 0)
.s34:
; 265, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bf4 : a5 0d __ LDA P0 
1bf6 : 85 11 __ STA P4 
1bf8 : a5 0e __ LDA P1 
1bfa : 85 12 __ STA P5 
1bfc : 20 61 1c JSR $1c61 ; (tile_is_floor_fast.s0 + 0)
1bff : a5 1b __ LDA ACCU + 0 
1c01 : f0 13 __ BEQ $1c16 ; (can_reuse_existing_path.s25 + 0)
.s33:
; 266, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c03 : a5 46 __ LDA T2 + 0 
1c05 : 85 0f __ STA P2 
1c07 : a5 45 __ LDA T0 + 0 
1c09 : 85 10 __ STA P3 
1c0b : 20 a5 1c JSR $1ca5 ; (is_outside_any_room.s0 + 0)
1c0e : aa __ __ TAX
1c0f : f0 05 __ BEQ $1c16 ; (can_reuse_existing_path.s25 + 0)
.s30:
; 267, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c11 : a9 01 __ LDA #$01
1c13 : 8d ee 9f STA $9fee ; (entropy4 + 1)
.s25:
; 260, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c16 : 18 __ __ CLC
1c17 : a5 48 __ LDA T4 + 0 
1c19 : 69 01 __ ADC #$01
1c1b : 8d e8 9f STA $9fe8 ; (up_y + 0)
1c1e : 30 04 __ BMI $1c24 ; (can_reuse_existing_path.s29 + 0)
.s1006:
1c20 : c9 05 __ CMP #$05
1c22 : b0 05 __ BCS $1c29 ; (can_reuse_existing_path.s22 + 0)
.s29:
; 260, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c24 : ad ee 9f LDA $9fee ; (entropy4 + 1)
1c27 : f0 a7 __ BEQ $1bd0 ; (can_reuse_existing_path.l26 + 0)
.s22:
; 259, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c29 : ad e9 9f LDA $9fe9 ; (up_x + 0)
1c2c : ee e9 9f INC $9fe9 ; (up_x + 0)
1c2f : aa __ __ TAX
1c30 : 30 04 __ BMI $1c36 ; (can_reuse_existing_path.s24 + 0)
.s1005:
1c32 : c9 04 __ CMP #$04
1c34 : b0 05 __ BCS $1c3b ; (can_reuse_existing_path.s23 + 0)
.s24:
; 259, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c36 : ad ee 9f LDA $9fee ; (entropy4 + 1)
1c39 : f0 8b __ BEQ $1bc6 ; (can_reuse_existing_path.l21 + 0)
.s23:
; 273, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c3b : a5 47 __ LDA T3 + 0 
1c3d : f0 07 __ BEQ $1c46 ; (can_reuse_existing_path.s1001 + 0)
.s38:
1c3f : ad ee 9f LDA $9fee ; (entropy4 + 1)
1c42 : f0 02 __ BEQ $1c46 ; (can_reuse_existing_path.s1001 + 0)
.s35:
1c44 : a9 01 __ LDA #$01
.s1001:
; 256, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c46 : 85 1b __ STA ACCU + 0 
1c48 : 60 __ __ RTS
.s4:
1c49 : f0 fb __ BEQ $1c46 ; (can_reuse_existing_path.s1001 + 0)
1c4b : 4c ba 1b JMP $1bba ; (can_reuse_existing_path.s18 + 0)
--------------------------------------------------------------------
coords_in_bounds_fast: ; coords_in_bounds_fast(u8,u8)->u8
.s0:
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utility.h"
1c4e : a5 0d __ LDA P0 ; (x + 0)
1c50 : c9 40 __ CMP #$40
1c52 : b0 0a __ BCS $1c5e ; (coords_in_bounds_fast.s2 + 0)
.s4:
1c54 : a5 0e __ LDA P1 ; (y + 0)
1c56 : c9 40 __ CMP #$40
1c58 : a9 00 __ LDA #$00
1c5a : 2a __ __ ROL
1c5b : 49 01 __ EOR #$01
1c5d : 60 __ __ RTS
.s2:
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utility.h"
1c5e : a9 00 __ LDA #$00
.s1001:
1c60 : 60 __ __ RTS
--------------------------------------------------------------------
tile_is_floor_fast: ; tile_is_floor_fast(u8,u8)->u8
.s0:
;  37, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utility.h"
1c61 : a5 11 __ LDA P4 ; (x + 0)
1c63 : 85 0d __ STA P0 
1c65 : a5 12 __ LDA P5 ; (y + 0)
1c67 : 85 0e __ STA P1 
1c69 : 20 4e 1c JSR $1c4e ; (coords_in_bounds_fast.s0 + 0)
1c6c : aa __ __ TAX
1c6d : f0 17 __ BEQ $1c86 ; (tile_is_floor_fast.s1001 + 0)
.s3:
;  38, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utility.h"
1c6f : a5 11 __ LDA P4 ; (x + 0)
1c71 : 85 0f __ STA P2 
1c73 : a5 12 __ LDA P5 ; (y + 0)
1c75 : 85 10 __ STA P3 
1c77 : 20 89 1c JSR $1c89 ; (get_tile_raw.s0 + 0)
1c7a : a5 1b __ LDA ACCU + 0 
1c7c : c9 02 __ CMP #$02
1c7e : d0 04 __ BNE $1c84 ; (tile_is_floor_fast.s1003 + 0)
.s1002:
1c80 : a9 01 __ LDA #$01
1c82 : d0 02 __ BNE $1c86 ; (tile_is_floor_fast.s1001 + 0)
.s1003:
1c84 : a9 00 __ LDA #$00
.s1001:
;  37, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utility.h"
1c86 : 85 1b __ STA ACCU + 0 
1c88 : 60 __ __ RTS
--------------------------------------------------------------------
get_tile_raw: ; get_tile_raw(u8,u8)->u8
.s0:
; 290, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1c89 : a5 0f __ LDA P2 ; (x + 0)
1c8b : c9 40 __ CMP #$40
1c8d : b0 06 __ BCS $1c95 ; (get_tile_raw.s1 + 0)
.s4:
1c8f : a5 10 __ LDA P3 ; (y + 0)
1c91 : c9 40 __ CMP #$40
1c93 : 90 04 __ BCC $1c99 ; (get_tile_raw.s3 + 0)
.s1:
1c95 : a9 00 __ LDA #$00
1c97 : b0 09 __ BCS $1ca2 ; (get_tile_raw.s1001 + 0)
.s3:
; 291, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1c99 : 85 0e __ STA P1 
1c9b : a5 0f __ LDA P2 ; (x + 0)
1c9d : 85 0d __ STA P0 
1c9f : 20 14 15 JSR $1514 ; (get_tile_core.s0 + 0)
.s1001:
1ca2 : 85 1b __ STA ACCU + 0 
1ca4 : 60 __ __ RTS
--------------------------------------------------------------------
is_outside_any_room: ; is_outside_any_room(u8,u8)->u8
.s0:
; 143, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1ca5 : a5 0f __ LDA P2 ; (x + 0)
1ca7 : 85 0d __ STA P0 
1ca9 : a5 10 __ LDA P3 ; (y + 0)
1cab : 85 0e __ STA P1 
1cad : 20 b9 1c JSR $1cb9 ; (is_inside_room.s0 + 0)
1cb0 : c9 01 __ CMP #$01
1cb2 : a9 00 __ LDA #$00
1cb4 : 69 ff __ ADC #$ff
1cb6 : 29 01 __ AND #$01
.s1001:
1cb8 : 60 __ __ RTS
--------------------------------------------------------------------
is_inside_room: ; is_inside_room(u8,u8)->u8
.s0:
; 132, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1cb9 : a9 00 __ LDA #$00
1cbb : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
1cbe : ad 40 34 LDA $3440 ; (room_count + 0)
1cc1 : f0 40 __ BEQ $1d03 ; (is_inside_room.s4 + 0)
.s1008:
1cc3 : 85 1c __ STA ACCU + 1 
1cc5 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
1cc8 : a4 0d __ LDY P0 ; (x + 0)
.l2:
; 133, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1cca : 0a __ __ ASL
1ccb : 0a __ __ ASL
1ccc : 0a __ __ ASL
1ccd : aa __ __ TAX
1cce : 98 __ __ TYA
1ccf : dd 00 43 CMP $4300,x ; (rooms + 0)
1cd2 : 90 25 __ BCC $1cf9 ; (is_inside_room.s3 + 0)
.s10:
1cd4 : bd 02 43 LDA $4302,x ; (rooms + 2)
1cd7 : 18 __ __ CLC
1cd8 : 7d 00 43 ADC $4300,x ; (rooms + 0)
1cdb : b0 06 __ BCS $1ce3 ; (is_inside_room.s9 + 0)
.s1005:
1cdd : 85 1b __ STA ACCU + 0 
1cdf : c4 1b __ CPY ACCU + 0 
1ce1 : b0 16 __ BCS $1cf9 ; (is_inside_room.s3 + 0)
.s9:
; 134, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1ce3 : a5 0e __ LDA P1 ; (y + 0)
1ce5 : dd 01 43 CMP $4301,x ; (rooms + 1)
1ce8 : 90 0f __ BCC $1cf9 ; (is_inside_room.s3 + 0)
.s8:
1cea : bd 03 43 LDA $4303,x ; (rooms + 3)
1ced : 18 __ __ CLC
1cee : 7d 01 43 ADC $4301,x ; (rooms + 1)
1cf1 : b0 13 __ BCS $1d06 ; (is_inside_room.s5 + 0)
.s1002:
1cf3 : c5 0e __ CMP P1 ; (y + 0)
1cf5 : 90 02 __ BCC $1cf9 ; (is_inside_room.s3 + 0)
.s1011:
1cf7 : d0 0d __ BNE $1d06 ; (is_inside_room.s5 + 0)
.s3:
; 132, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1cf9 : ee f9 9f INC $9ff9 ; (bit_offset + 1)
1cfc : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
1cff : c5 1c __ CMP ACCU + 1 
1d01 : 90 c7 __ BCC $1cca ; (is_inside_room.l2 + 0)
.s4:
; 138, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1d03 : a9 00 __ LDA #$00
.s1001:
1d05 : 60 __ __ RTS
.s5:
1d06 : a9 01 __ LDA #$01
1d08 : 60 __ __ RTS
--------------------------------------------------------------------
connect_via_existing_corridors: ; connect_via_existing_corridors(u8,u8)->u8
.s1000:
1d09 : a2 03 __ LDX #$03
1d0b : b5 53 __ LDA T7 + 0,x 
1d0d : 9d 47 9f STA $9f47,x ; (connect_via_existing_corridors@stack + 0)
1d10 : ca __ __ DEX
1d11 : 10 f8 __ BPL $1d0b ; (connect_via_existing_corridors.s1000 + 2)
.s0:
; 282, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1d13 : ad fc 9f LDA $9ffc ; (sstack + 2)
1d16 : 85 4d __ STA T1 + 0 
1d18 : 85 0d __ STA P0 
1d1a : a9 ea __ LDA #$ea
1d1c : 85 0e __ STA P1 
1d1e : a9 9f __ LDA #$9f
1d20 : 85 11 __ STA P4 
1d22 : a9 9f __ LDA #$9f
1d24 : 85 0f __ STA P2 
1d26 : a9 e9 __ LDA #$e9
1d28 : 85 10 __ STA P3 
1d2a : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 283, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1d2d : ad fd 9f LDA $9ffd ; (sstack + 3)
1d30 : 85 4e __ STA T2 + 0 
1d32 : 85 0d __ STA P0 
1d34 : a9 e8 __ LDA #$e8
1d36 : 85 0e __ STA P1 
1d38 : a9 9f __ LDA #$9f
1d3a : 85 11 __ STA P4 
1d3c : a9 9f __ LDA #$9f
1d3e : 85 0f __ STA P2 
1d40 : a9 e7 __ LDA #$e7
1d42 : 85 10 __ STA P3 
1d44 : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 284, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1d47 : a5 4d __ LDA T1 + 0 
1d49 : 0a __ __ ASL
1d4a : 0a __ __ ASL
1d4b : 0a __ __ ASL
1d4c : 85 50 __ STA T4 + 0 
1d4e : 18 __ __ CLC
1d4f : 69 00 __ ADC #$00
1d51 : 85 12 __ STA P5 
1d53 : a9 43 __ LDA #$43
1d55 : 69 00 __ ADC #$00
1d57 : 85 13 __ STA P6 
1d59 : ad e8 9f LDA $9fe8 ; (up_y + 0)
1d5c : 85 14 __ STA P7 
1d5e : ad e7 9f LDA $9fe7 ; (down_x + 0)
1d61 : 85 15 __ STA P8 
1d63 : a9 ee __ LDA #$ee
1d65 : 85 16 __ STA P9 
1d67 : a9 ed __ LDA #$ed
1d69 : 8d fa 9f STA $9ffa ; (sstack + 0)
1d6c : a9 9f __ LDA #$9f
1d6e : 85 17 __ STA P10 
1d70 : a9 9f __ LDA #$9f
1d72 : 8d fb 9f STA $9ffb ; (sstack + 1)
1d75 : 20 d5 21 JSR $21d5 ; (find_room_exit.s0 + 0)
; 286, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1d78 : a5 4e __ LDA T2 + 0 
1d7a : 0a __ __ ASL
1d7b : 0a __ __ ASL
1d7c : 0a __ __ ASL
1d7d : 85 51 __ STA T5 + 0 
1d7f : 18 __ __ CLC
1d80 : 69 00 __ ADC #$00
1d82 : 85 12 __ STA P5 
1d84 : a9 43 __ LDA #$43
1d86 : 69 00 __ ADC #$00
1d88 : 85 13 __ STA P6 
1d8a : ad ea 9f LDA $9fea ; (i + 0)
1d8d : 85 14 __ STA P7 
1d8f : ad e9 9f LDA $9fe9 ; (up_x + 0)
1d92 : 85 15 __ STA P8 
1d94 : a9 ec __ LDA #$ec
1d96 : 85 16 __ STA P9 
1d98 : a9 eb __ LDA #$eb
1d9a : 8d fa 9f STA $9ffa ; (sstack + 0)
1d9d : a9 9f __ LDA #$9f
1d9f : 85 17 __ STA P10 
1da1 : a9 9f __ LDA #$9f
1da3 : 8d fb 9f STA $9ffb ; (sstack + 1)
1da6 : 20 d5 21 JSR $21d5 ; (find_room_exit.s0 + 0)
; 289, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1da9 : a9 ff __ LDA #$ff
1dab : 8d e6 9f STA $9fe6 ; (check_y + 0)
1dae : 8d e5 9f STA $9fe5 ; (x + 0)
; 290, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1db1 : 8d e4 9f STA $9fe4 ; (tile + 0)
1db4 : 8d e3 9f STA $9fe3 ; (y + 0)
; 291, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1db7 : 8d e2 9f STA $9fe2 ; (min_dist1 + 0)
1dba : 8d e1 9f STA $9fe1 ; (min_dist2 + 0)
; 296, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1dbd : a9 0a __ LDA #$0a
1dbf : cd ea 9f CMP $9fea ; (i + 0)
1dc2 : 90 04 __ BCC $1dc8 ; (connect_via_existing_corridors.s1 + 0)
.s2:
1dc4 : a9 00 __ LDA #$00
1dc6 : b0 05 __ BCS $1dcd ; (connect_via_existing_corridors.s226 + 0)
.s1:
; 296, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1dc8 : ad ea 9f LDA $9fea ; (i + 0)
1dcb : e9 09 __ SBC #$09
.s226:
1dcd : 8d e0 9f STA $9fe0 ; (grid_positions + 15)
; 297, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1dd0 : a9 0a __ LDA #$0a
1dd2 : cd e9 9f CMP $9fe9 ; (up_x + 0)
1dd5 : 90 04 __ BCC $1ddb ; (connect_via_existing_corridors.s4 + 0)
.s5:
1dd7 : a9 00 __ LDA #$00
1dd9 : b0 05 __ BCS $1de0 ; (connect_via_existing_corridors.s227 + 0)
.s4:
; 297, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ddb : ad e9 9f LDA $9fe9 ; (up_x + 0)
1dde : e9 09 __ SBC #$09
.s227:
1de0 : 8d df 9f STA $9fdf ; (grid_positions + 14)
; 298, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1de3 : ad ea 9f LDA $9fea ; (i + 0)
1de6 : c9 36 __ CMP #$36
1de8 : 90 04 __ BCC $1dee ; (connect_via_existing_corridors.s7 + 0)
.s8:
1dea : a9 3f __ LDA #$3f
1dec : b0 02 __ BCS $1df0 ; (connect_via_existing_corridors.s228 + 0)
.s7:
; 298, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1dee : 69 0a __ ADC #$0a
.s228:
1df0 : 8d de 9f STA $9fde ; (grid_positions + 13)
; 299, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1df3 : ad e9 9f LDA $9fe9 ; (up_x + 0)
1df6 : c9 36 __ CMP #$36
1df8 : 90 04 __ BCC $1dfe ; (connect_via_existing_corridors.s10 + 0)
.s11:
1dfa : a9 3f __ LDA #$3f
1dfc : b0 02 __ BCS $1e00 ; (connect_via_existing_corridors.s124 + 0)
.s10:
; 299, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1dfe : 69 0a __ ADC #$0a
.s124:
1e00 : 8d dd 9f STA $9fdd ; (grid_positions + 12)
; 301, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e03 : ae df 9f LDX $9fdf ; (grid_positions + 14)
1e06 : 8e dc 9f STX $9fdc ; (grid_positions + 11)
1e09 : cd df 9f CMP $9fdf ; (grid_positions + 14)
1e0c : b0 03 __ BCS $1e11 ; (connect_via_existing_corridors.s160 + 0)
1e0e : 4c d4 1e JMP $1ed4 ; (connect_via_existing_corridors.s16 + 0)
.s160:
; 302, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e11 : 85 52 __ STA T6 + 0 
1e13 : ad e0 9f LDA $9fe0 ; (grid_positions + 15)
1e16 : 85 53 __ STA T7 + 0 
1e18 : ad de 9f LDA $9fde ; (grid_positions + 13)
1e1b : 85 54 __ STA T8 + 0 
1e1d : c5 53 __ CMP T7 + 0 
1e1f : a9 00 __ LDA #$00
1e21 : 2a __ __ ROL
1e22 : 85 55 __ STA T9 + 0 
.l14:
1e24 : a5 53 __ LDA T7 + 0 
1e26 : 8d db 9f STA $9fdb ; (grid_positions + 10)
1e29 : a5 55 __ LDA T9 + 0 
1e2b : d0 03 __ BNE $1e30 ; (connect_via_existing_corridors.s159 + 0)
1e2d : 4c c7 1e JMP $1ec7 ; (connect_via_existing_corridors.s15 + 0)
.s159:
; 303, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e30 : ad dc 9f LDA $9fdc ; (grid_positions + 11)
1e33 : 85 10 __ STA P3 
.l18:
1e35 : ad db 9f LDA $9fdb ; (grid_positions + 10)
1e38 : 85 56 __ STA T11 + 0 
1e3a : 85 0f __ STA P2 
1e3c : 20 78 22 JSR $2278 ; (tile_is_floor.s0 + 0)
1e3f : a5 1b __ LDA ACCU + 0 ; (room1 + 0)
1e41 : f0 74 __ BEQ $1eb7 ; (connect_via_existing_corridors.s17 + 0)
.s24:
1e43 : 20 a5 1c JSR $1ca5 ; (is_outside_any_room.s0 + 0)
1e46 : aa __ __ TAX
1e47 : f0 6e __ BEQ $1eb7 ; (connect_via_existing_corridors.s17 + 0)
.s21:
; 305, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e49 : a5 56 __ LDA T11 + 0 
1e4b : 85 0d __ STA P0 
1e4d : ad ee 9f LDA $9fee ; (entropy4 + 1)
1e50 : 85 0e __ STA P1 
1e52 : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
1e55 : 85 4e __ STA T2 + 0 
1e57 : a5 10 __ LDA P3 
1e59 : 85 0d __ STA P0 
1e5b : ad ed 9f LDA $9fed ; (highest_priority + 0)
1e5e : 85 0e __ STA P1 
1e60 : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
1e63 : 18 __ __ CLC
1e64 : 65 4e __ ADC T2 + 0 
1e66 : 85 4d __ STA T1 + 0 
1e68 : 8d da 9f STA $9fda ; (grid_positions + 9)
; 306, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e6b : a5 56 __ LDA T11 + 0 
1e6d : 85 0d __ STA P0 
1e6f : ad ec 9f LDA $9fec ; (i + 0)
1e72 : 85 0e __ STA P1 
1e74 : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
1e77 : 85 43 __ STA T0 + 0 
1e79 : a5 10 __ LDA P3 
1e7b : 85 0d __ STA P0 
1e7d : ad eb 9f LDA $9feb ; (screen_offset + 1)
1e80 : 85 0e __ STA P1 
1e82 : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
1e85 : 18 __ __ CLC
1e86 : 65 43 __ ADC T0 + 0 
1e88 : 8d d9 9f STA $9fd9 ; (grid_positions + 8)
; 308, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e8b : a5 4d __ LDA T1 + 0 
1e8d : cd e2 9f CMP $9fe2 ; (min_dist1 + 0)
1e90 : b0 0d __ BCS $1e9f ; (connect_via_existing_corridors.s27 + 0)
.s25:
; 309, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e92 : 8d e2 9f STA $9fe2 ; (min_dist1 + 0)
; 310, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e95 : a5 56 __ LDA T11 + 0 
1e97 : 8d e6 9f STA $9fe6 ; (check_y + 0)
; 311, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e9a : a5 10 __ LDA P3 
1e9c : 8d e5 9f STA $9fe5 ; (x + 0)
.s27:
; 313, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e9f : ad d9 9f LDA $9fd9 ; (grid_positions + 8)
1ea2 : cd e1 9f CMP $9fe1 ; (min_dist2 + 0)
1ea5 : b0 10 __ BCS $1eb7 ; (connect_via_existing_corridors.s17 + 0)
.s28:
; 315, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ea7 : a5 56 __ LDA T11 + 0 
1ea9 : 8d e4 9f STA $9fe4 ; (tile + 0)
; 316, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1eac : a5 10 __ LDA P3 
1eae : 8d e3 9f STA $9fe3 ; (y + 0)
; 314, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1eb1 : ad d9 9f LDA $9fd9 ; (grid_positions + 8)
1eb4 : 8d e1 9f STA $9fe1 ; (min_dist2 + 0)
.s17:
; 302, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1eb7 : a6 56 __ LDX T11 + 0 
1eb9 : e8 __ __ INX
1eba : 8e db 9f STX $9fdb ; (grid_positions + 10)
1ebd : a5 54 __ LDA T8 + 0 
1ebf : cd db 9f CMP $9fdb ; (grid_positions + 10)
1ec2 : 90 03 __ BCC $1ec7 ; (connect_via_existing_corridors.s15 + 0)
1ec4 : 4c 35 1e JMP $1e35 ; (connect_via_existing_corridors.l18 + 0)
.s15:
; 301, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ec7 : ee dc 9f INC $9fdc ; (grid_positions + 11)
1eca : a5 52 __ LDA T6 + 0 
1ecc : cd dc 9f CMP $9fdc ; (grid_positions + 11)
1ecf : 90 03 __ BCC $1ed4 ; (connect_via_existing_corridors.s16 + 0)
1ed1 : 4c 24 1e JMP $1e24 ; (connect_via_existing_corridors.l14 + 0)
.s16:
; 323, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ed4 : ad e6 9f LDA $9fe6 ; (check_y + 0)
1ed7 : c9 ff __ CMP #$ff
1ed9 : f0 17 __ BEQ $1ef2 ; (connect_via_existing_corridors.s33 + 0)
.s36:
1edb : 85 52 __ STA T6 + 0 
1edd : ad e4 9f LDA $9fe4 ; (tile + 0)
1ee0 : c9 ff __ CMP #$ff
1ee2 : f0 0e __ BEQ $1ef2 ; (connect_via_existing_corridors.s33 + 0)
.s35:
1ee4 : 85 53 __ STA T7 + 0 
1ee6 : a9 08 __ LDA #$08
1ee8 : cd e2 9f CMP $9fe2 ; (min_dist1 + 0)
1eeb : 90 05 __ BCC $1ef2 ; (connect_via_existing_corridors.s33 + 0)
.s34:
1eed : cd e1 9f CMP $9fe1 ; (min_dist2 + 0)
1ef0 : b0 05 __ BCS $1ef7 ; (connect_via_existing_corridors.s31 + 0)
.s33:
; 416, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ef2 : a9 00 __ LDA #$00
1ef4 : 4c aa 21 JMP $21aa ; (connect_via_existing_corridors.s1001 + 0)
.s31:
; 330, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ef7 : a9 00 __ LDA #$00
1ef9 : 8d c4 9f STA $9fc4 ; (path1 + 40)
; 331, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1efc : 8d 9b 9f STA $9f9b ; (dx1 + 0)
1eff : 8d 9a 9f STA $9f9a ; (dy1 + 0)
; 332, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f02 : a4 50 __ LDY T4 + 0 
1f04 : b9 00 43 LDA $4300,y ; (rooms + 0)
1f07 : e9 01 __ SBC #$01
1f09 : 90 11 __ BCC $1f1c ; (connect_via_existing_corridors.s38 + 0)
.s1029:
1f0b : cd ee 9f CMP $9fee ; (entropy4 + 1)
1f0e : d0 0c __ BNE $1f1c ; (connect_via_existing_corridors.s38 + 0)
.s37:
1f10 : a9 ff __ LDA #$ff
.s270:
; 333, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f12 : 8d 9b 9f STA $9f9b ; (dx1 + 0)
1f15 : a9 00 __ LDA #$00
1f17 : 8d 9a 9f STA $9f9a ; (dy1 + 0)
1f1a : f0 3d __ BEQ $1f59 ; (connect_via_existing_corridors.s39 + 0)
.s38:
; 333, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f1c : b9 02 43 LDA $4302,y ; (rooms + 2)
1f1f : 18 __ __ CLC
1f20 : 79 00 43 ADC $4300,y ; (rooms + 0)
1f23 : b0 09 __ BCS $1f2e ; (connect_via_existing_corridors.s41 + 0)
.s1026:
1f25 : cd ee 9f CMP $9fee ; (entropy4 + 1)
1f28 : d0 04 __ BNE $1f2e ; (connect_via_existing_corridors.s41 + 0)
.s40:
1f2a : a9 01 __ LDA #$01
1f2c : d0 e4 __ BNE $1f12 ; (connect_via_existing_corridors.s270 + 0)
.s41:
; 334, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f2e : b9 01 43 LDA $4301,y ; (rooms + 1)
1f31 : 38 __ __ SEC
1f32 : e9 01 __ SBC #$01
1f34 : 90 11 __ BCC $1f47 ; (connect_via_existing_corridors.s44 + 0)
.s1023:
1f36 : cd ed 9f CMP $9fed ; (highest_priority + 0)
1f39 : d0 0c __ BNE $1f47 ; (connect_via_existing_corridors.s44 + 0)
.s43:
1f3b : a9 ff __ LDA #$ff
.s321:
; 335, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f3d : 8d 9a 9f STA $9f9a ; (dy1 + 0)
1f40 : a9 00 __ LDA #$00
1f42 : 8d 9b 9f STA $9f9b ; (dx1 + 0)
1f45 : f0 12 __ BEQ $1f59 ; (connect_via_existing_corridors.s39 + 0)
.s44:
; 335, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f47 : b9 03 43 LDA $4303,y ; (rooms + 3)
1f4a : 18 __ __ CLC
1f4b : 79 01 43 ADC $4301,y ; (rooms + 1)
1f4e : b0 09 __ BCS $1f59 ; (connect_via_existing_corridors.s39 + 0)
.s1020:
1f50 : cd ed 9f CMP $9fed ; (highest_priority + 0)
1f53 : d0 04 __ BNE $1f59 ; (connect_via_existing_corridors.s39 + 0)
.s46:
1f55 : a9 01 __ LDA #$01
1f57 : d0 e4 __ BNE $1f3d ; (connect_via_existing_corridors.s321 + 0)
.s39:
; 336, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f59 : ad 9b 9f LDA $9f9b ; (dx1 + 0)
1f5c : 18 __ __ CLC
1f5d : 6d ee 9f ADC $9fee ; (entropy4 + 1)
1f60 : 85 4e __ STA T2 + 0 
1f62 : 85 0d __ STA P0 
1f64 : 8d 99 9f STA $9f99 ; (corridor1_x + 0)
; 338, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f67 : a9 01 __ LDA #$01
1f69 : 8d 4e 35 STA $354e ; (corridor_endpoint_override + 0)
; 337, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f6c : ad 9a 9f LDA $9f9a ; (dy1 + 0)
1f6f : 18 __ __ CLC
1f70 : 6d ed 9f ADC $9fed ; (highest_priority + 0)
1f73 : 85 4d __ STA T1 + 0 
1f75 : 85 0e __ STA P1 
1f77 : 8d 98 9f STA $9f98 ; (corridor1_y + 0)
; 339, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f7a : 20 dd 14 JSR $14dd ; (coords_in_bounds.s0 + 0)
1f7d : aa __ __ TAX
1f7e : f0 30 __ BEQ $1fb0 ; (connect_via_existing_corridors.s51 + 0)
.s52:
1f80 : a5 0d __ LDA P0 
1f82 : 85 13 __ STA P6 
1f84 : a5 0e __ LDA P1 
1f86 : 85 14 __ STA P7 
1f88 : 20 9a 22 JSR $229a ; (can_place_corridor_tile.s0 + 0)
1f8b : aa __ __ TAX
1f8c : f0 22 __ BEQ $1fb0 ; (connect_via_existing_corridors.s51 + 0)
.s49:
; 340, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f8e : a5 4e __ LDA T2 + 0 
1f90 : 85 10 __ STA P3 
1f92 : a5 4d __ LDA T1 + 0 
1f94 : 85 11 __ STA P4 
1f96 : a9 02 __ LDA #$02
1f98 : 85 12 __ STA P5 
1f9a : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
; 341, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f9d : a5 10 __ LDA P3 
1f9f : ae c4 9f LDX $9fc4 ; (path1 + 40)
1fa2 : 9d 9c 9f STA $9f9c,x ; (path1 + 0)
; 342, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fa5 : a5 11 __ LDA P4 
1fa7 : ae c4 9f LDX $9fc4 ; (path1 + 40)
1faa : 9d b0 9f STA $9fb0,x ; (path1 + 20)
; 343, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fad : ee c4 9f INC $9fc4 ; (path1 + 40)
.s51:
; 346, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fb0 : a5 4e __ LDA T2 + 0 
1fb2 : 8d 97 9f STA $9f97 ; (current1_x + 0)
; 347, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fb5 : a5 4d __ LDA T1 + 0 
1fb7 : 8d 96 9f STA $9f96 ; (current1_y + 0)
; 348, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fba : a9 40 __ LDA #$40
1fbc : 8d 95 9f STA $9f95 ; (step_limit1 + 0)
; 345, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fbf : a9 00 __ LDA #$00
1fc1 : 8d 4e 35 STA $354e ; (corridor_endpoint_override + 0)
.l53:
; 349, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fc4 : ac 97 9f LDY $9f97 ; (current1_x + 0)
1fc7 : c4 52 __ CPY T6 + 0 
1fc9 : f0 04 __ BEQ $1fcf ; (connect_via_existing_corridors.s1003 + 0)
.s1002:
1fcb : a2 01 __ LDX #$01
1fcd : d0 0a __ BNE $1fd9 ; (connect_via_existing_corridors.s56 + 0)
.s1003:
1fcf : ad 96 9f LDA $9f96 ; (current1_y + 0)
1fd2 : a2 00 __ LDX #$00
1fd4 : cd e5 9f CMP $9fe5 ; (x + 0)
1fd7 : f0 6b __ BEQ $2044 ; (connect_via_existing_corridors.s55 + 0)
.s56:
1fd9 : ad 95 9f LDA $9f95 ; (step_limit1 + 0)
1fdc : ce 95 9f DEC $9f95 ; (step_limit1 + 0)
1fdf : 09 00 __ ORA #$00
1fe1 : f0 61 __ BEQ $2044 ; (connect_via_existing_corridors.s55 + 0)
.s54:
; 351, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fe3 : 8a __ __ TXA
1fe4 : f0 03 __ BEQ $1fe9 ; (connect_via_existing_corridors.s59 + 0)
1fe6 : 4c c6 21 JMP $21c6 ; (connect_via_existing_corridors.s58 + 0)
.s59:
; 354, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fe9 : ac 96 9f LDY $9f96 ; (current1_y + 0)
1fec : cc e5 9f CPY $9fe5 ; (x + 0)
1fef : f0 53 __ BEQ $2044 ; (connect_via_existing_corridors.s55 + 0)
.s64:
; 355, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ff1 : b0 03 __ BCS $1ff6 ; (connect_via_existing_corridors.s68 + 0)
.s67:
1ff3 : c8 __ __ INY
1ff4 : 90 01 __ BCC $1ff7 ; (connect_via_existing_corridors.s272 + 0)
.s68:
; 356, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ff6 : 88 __ __ DEY
.s272:
1ff7 : 8c 96 9f STY $9f96 ; (current1_y + 0)
; 360, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ffa : ad 97 9f LDA $9f97 ; (current1_x + 0)
.s60:
1ffd : 85 4e __ STA T2 + 0 
1fff : 85 0f __ STA P2 
2001 : ad 96 9f LDA $9f96 ; (current1_y + 0)
2004 : 85 4f __ STA T3 + 0 
2006 : 85 10 __ STA P3 
2008 : 20 a5 1c JSR $1ca5 ; (is_outside_any_room.s0 + 0)
200b : aa __ __ TAX
200c : f0 b6 __ BEQ $1fc4 ; (connect_via_existing_corridors.l53 + 0)
.s74:
200e : a5 0f __ LDA P2 
2010 : 85 13 __ STA P6 
2012 : a5 4f __ LDA T3 + 0 
2014 : 85 14 __ STA P7 
2016 : 20 9a 22 JSR $229a ; (can_place_corridor_tile.s0 + 0)
2019 : aa __ __ TAX
201a : f0 a8 __ BEQ $1fc4 ; (connect_via_existing_corridors.l53 + 0)
.s71:
; 361, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
201c : a5 4e __ LDA T2 + 0 
201e : 85 10 __ STA P3 
2020 : a5 4f __ LDA T3 + 0 
2022 : 85 11 __ STA P4 
2024 : a9 02 __ LDA #$02
2026 : 85 12 __ STA P5 
2028 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
; 362, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
202b : ae c4 9f LDX $9fc4 ; (path1 + 40)
202e : e0 14 __ CPX #$14
2030 : b0 92 __ BCS $1fc4 ; (connect_via_existing_corridors.l53 + 0)
.s75:
; 363, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2032 : a5 10 __ LDA P3 
2034 : 9d 9c 9f STA $9f9c,x ; (path1 + 0)
; 364, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2037 : a5 4f __ LDA T3 + 0 
2039 : ae c4 9f LDX $9fc4 ; (path1 + 40)
203c : 9d b0 9f STA $9fb0,x ; (path1 + 20)
; 365, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
203f : ee c4 9f INC $9fc4 ; (path1 + 40)
2042 : 90 80 __ BCC $1fc4 ; (connect_via_existing_corridors.l53 + 0)
.s55:
; 369, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2044 : a9 9c __ LDA #$9c
2046 : 85 15 __ STA P8 
2048 : a9 9f __ LDA #$9f
204a : 85 16 __ STA P9 
204c : 20 60 23 JSR $2360 ; (place_doors_along_corridor.s0 + 0)
; 373, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
204f : a9 00 __ LDA #$00
2051 : 8d 80 9f STA $9f80 ; (path2 + 40)
; 374, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2054 : 8d 57 9f STA $9f57 ; (dx2 + 0)
2057 : 8d 56 9f STA $9f56 ; (dy2 + 0)
; 375, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
205a : a4 51 __ LDY T5 + 0 
205c : b9 00 43 LDA $4300,y ; (rooms + 0)
205f : 38 __ __ SEC
2060 : e9 01 __ SBC #$01
2062 : 90 11 __ BCC $2075 ; (connect_via_existing_corridors.s79 + 0)
.s1017:
2064 : cd ec 9f CMP $9fec ; (i + 0)
2067 : d0 0c __ BNE $2075 ; (connect_via_existing_corridors.s79 + 0)
.s78:
2069 : a9 ff __ LDA #$ff
.s273:
; 376, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
206b : 8d 57 9f STA $9f57 ; (dx2 + 0)
206e : a9 00 __ LDA #$00
2070 : 8d 56 9f STA $9f56 ; (dy2 + 0)
2073 : f0 3d __ BEQ $20b2 ; (connect_via_existing_corridors.s80 + 0)
.s79:
; 376, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2075 : b9 02 43 LDA $4302,y ; (rooms + 2)
2078 : 18 __ __ CLC
2079 : 79 00 43 ADC $4300,y ; (rooms + 0)
207c : b0 09 __ BCS $2087 ; (connect_via_existing_corridors.s82 + 0)
.s1014:
207e : cd ec 9f CMP $9fec ; (i + 0)
2081 : d0 04 __ BNE $2087 ; (connect_via_existing_corridors.s82 + 0)
.s81:
2083 : a9 01 __ LDA #$01
2085 : d0 e4 __ BNE $206b ; (connect_via_existing_corridors.s273 + 0)
.s82:
; 377, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2087 : b9 01 43 LDA $4301,y ; (rooms + 1)
208a : 38 __ __ SEC
208b : e9 01 __ SBC #$01
208d : 90 11 __ BCC $20a0 ; (connect_via_existing_corridors.s85 + 0)
.s1011:
208f : cd eb 9f CMP $9feb ; (screen_offset + 1)
2092 : d0 0c __ BNE $20a0 ; (connect_via_existing_corridors.s85 + 0)
.s84:
2094 : a9 ff __ LDA #$ff
.s322:
; 378, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2096 : 8d 56 9f STA $9f56 ; (dy2 + 0)
2099 : a9 00 __ LDA #$00
209b : 8d 57 9f STA $9f57 ; (dx2 + 0)
209e : f0 12 __ BEQ $20b2 ; (connect_via_existing_corridors.s80 + 0)
.s85:
; 378, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20a0 : b9 03 43 LDA $4303,y ; (rooms + 3)
20a3 : 18 __ __ CLC
20a4 : 79 01 43 ADC $4301,y ; (rooms + 1)
20a7 : b0 09 __ BCS $20b2 ; (connect_via_existing_corridors.s80 + 0)
.s1008:
20a9 : cd eb 9f CMP $9feb ; (screen_offset + 1)
20ac : d0 04 __ BNE $20b2 ; (connect_via_existing_corridors.s80 + 0)
.s87:
20ae : a9 01 __ LDA #$01
20b0 : d0 e4 __ BNE $2096 ; (connect_via_existing_corridors.s322 + 0)
.s80:
; 379, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20b2 : ad 57 9f LDA $9f57 ; (dx2 + 0)
20b5 : 18 __ __ CLC
20b6 : 6d ec 9f ADC $9fec ; (i + 0)
20b9 : 85 4e __ STA T2 + 0 
20bb : 85 0d __ STA P0 
20bd : 8d 55 9f STA $9f55 ; (corridor2_x + 0)
; 381, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20c0 : a9 01 __ LDA #$01
20c2 : 8d 4e 35 STA $354e ; (corridor_endpoint_override + 0)
; 380, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20c5 : ad 56 9f LDA $9f56 ; (dy2 + 0)
20c8 : 18 __ __ CLC
20c9 : 6d eb 9f ADC $9feb ; (screen_offset + 1)
20cc : 85 4d __ STA T1 + 0 
20ce : 85 0e __ STA P1 
20d0 : 8d 54 9f STA $9f54 ; (corridor2_y + 0)
; 382, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20d3 : 20 dd 14 JSR $14dd ; (coords_in_bounds.s0 + 0)
20d6 : aa __ __ TAX
20d7 : f0 30 __ BEQ $2109 ; (connect_via_existing_corridors.s92 + 0)
.s93:
20d9 : a5 0d __ LDA P0 
20db : 85 13 __ STA P6 
20dd : a5 0e __ LDA P1 
20df : 85 14 __ STA P7 
20e1 : 20 9a 22 JSR $229a ; (can_place_corridor_tile.s0 + 0)
20e4 : aa __ __ TAX
20e5 : f0 22 __ BEQ $2109 ; (connect_via_existing_corridors.s92 + 0)
.s90:
; 383, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20e7 : a5 4e __ LDA T2 + 0 
20e9 : 85 10 __ STA P3 
20eb : a5 4d __ LDA T1 + 0 
20ed : 85 11 __ STA P4 
20ef : a9 02 __ LDA #$02
20f1 : 85 12 __ STA P5 
20f3 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
; 384, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20f6 : a5 10 __ LDA P3 
20f8 : ae 80 9f LDX $9f80 ; (path2 + 40)
20fb : 9d 58 9f STA $9f58,x ; (path2 + 0)
; 385, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20fe : a5 11 __ LDA P4 
2100 : ae 80 9f LDX $9f80 ; (path2 + 40)
2103 : 9d 6c 9f STA $9f6c,x ; (path2 + 20)
; 386, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2106 : ee 80 9f INC $9f80 ; (path2 + 40)
.s92:
; 389, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2109 : a5 4e __ LDA T2 + 0 
210b : 8d 53 9f STA $9f53 ; (current2_x + 0)
; 390, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
210e : a5 4d __ LDA T1 + 0 
2110 : 8d 52 9f STA $9f52 ; (current2_y + 0)
; 391, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2113 : a9 40 __ LDA #$40
2115 : 8d 51 9f STA $9f51 ; (step_limit2 + 0)
; 388, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2118 : a9 00 __ LDA #$00
211a : 8d 4e 35 STA $354e ; (corridor_endpoint_override + 0)
.l94:
; 392, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
211d : ac 53 9f LDY $9f53 ; (current2_x + 0)
2120 : c4 53 __ CPY T7 + 0 
2122 : f0 04 __ BEQ $2128 ; (connect_via_existing_corridors.s1006 + 0)
.s1005:
2124 : a2 01 __ LDX #$01
2126 : d0 0a __ BNE $2132 ; (connect_via_existing_corridors.s97 + 0)
.s1006:
2128 : ad 52 9f LDA $9f52 ; (current2_y + 0)
212b : a2 00 __ LDX #$00
212d : cd e3 9f CMP $9fe3 ; (y + 0)
2130 : f0 15 __ BEQ $2147 ; (connect_via_existing_corridors.s96 + 0)
.s97:
2132 : ad 51 9f LDA $9f51 ; (step_limit2 + 0)
2135 : ce 51 9f DEC $9f51 ; (step_limit2 + 0)
2138 : 09 00 __ ORA #$00
213a : f0 0b __ BEQ $2147 ; (connect_via_existing_corridors.s96 + 0)
.s95:
; 394, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
213c : 8a __ __ TXA
213d : d0 78 __ BNE $21b7 ; (connect_via_existing_corridors.s99 + 0)
.s100:
; 397, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
213f : ac 52 9f LDY $9f52 ; (current2_y + 0)
2142 : cc e3 9f CPY $9fe3 ; (y + 0)
2145 : d0 0f __ BNE $2156 ; (connect_via_existing_corridors.s105 + 0)
.s96:
; 412, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2147 : a9 58 __ LDA #$58
2149 : 85 15 __ STA P8 
214b : a9 9f __ LDA #$9f
214d : 85 16 __ STA P9 
214f : 20 60 23 JSR $2360 ; (place_doors_along_corridor.s0 + 0)
; 413, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2152 : a9 01 __ LDA #$01
2154 : d0 54 __ BNE $21aa ; (connect_via_existing_corridors.s1001 + 0)
.s105:
; 398, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2156 : b0 03 __ BCS $215b ; (connect_via_existing_corridors.s109 + 0)
.s108:
2158 : c8 __ __ INY
2159 : 90 01 __ BCC $215c ; (connect_via_existing_corridors.s275 + 0)
.s109:
; 399, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
215b : 88 __ __ DEY
.s275:
215c : 8c 52 9f STY $9f52 ; (current2_y + 0)
; 403, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
215f : ad 53 9f LDA $9f53 ; (current2_x + 0)
.s101:
2162 : 85 4e __ STA T2 + 0 
2164 : 85 0f __ STA P2 
2166 : ad 52 9f LDA $9f52 ; (current2_y + 0)
2169 : 85 4f __ STA T3 + 0 
216b : 85 10 __ STA P3 
216d : 20 a5 1c JSR $1ca5 ; (is_outside_any_room.s0 + 0)
2170 : aa __ __ TAX
2171 : f0 aa __ BEQ $211d ; (connect_via_existing_corridors.l94 + 0)
.s115:
2173 : a5 0f __ LDA P2 
2175 : 85 13 __ STA P6 
2177 : a5 4f __ LDA T3 + 0 
2179 : 85 14 __ STA P7 
217b : 20 9a 22 JSR $229a ; (can_place_corridor_tile.s0 + 0)
217e : aa __ __ TAX
217f : f0 9c __ BEQ $211d ; (connect_via_existing_corridors.l94 + 0)
.s112:
; 404, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2181 : a5 4e __ LDA T2 + 0 
2183 : 85 10 __ STA P3 
2185 : a5 4f __ LDA T3 + 0 
2187 : 85 11 __ STA P4 
2189 : a9 02 __ LDA #$02
218b : 85 12 __ STA P5 
218d : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
; 405, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2190 : ae 80 9f LDX $9f80 ; (path2 + 40)
2193 : e0 14 __ CPX #$14
2195 : b0 86 __ BCS $211d ; (connect_via_existing_corridors.l94 + 0)
.s116:
; 406, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2197 : a5 10 __ LDA P3 
2199 : 9d 58 9f STA $9f58,x ; (path2 + 0)
; 407, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
219c : a5 4f __ LDA T3 + 0 
219e : ae 80 9f LDX $9f80 ; (path2 + 40)
21a1 : 9d 6c 9f STA $9f6c,x ; (path2 + 20)
; 408, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21a4 : ee 80 9f INC $9f80 ; (path2 + 40)
21a7 : 4c 1d 21 JMP $211d ; (connect_via_existing_corridors.l94 + 0)
.s1001:
; 416, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21aa : 85 1b __ STA ACCU + 0 ; (room1 + 0)
21ac : a2 03 __ LDX #$03
21ae : bd 47 9f LDA $9f47,x ; (connect_via_existing_corridors@stack + 0)
21b1 : 95 53 __ STA T7 + 0,x 
21b3 : ca __ __ DEX
21b4 : 10 f8 __ BPL $21ae ; (connect_via_existing_corridors.s1001 + 4)
21b6 : 60 __ __ RTS
.s99:
; 395, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21b7 : c4 53 __ CPY T7 + 0 
21b9 : b0 03 __ BCS $21be ; (connect_via_existing_corridors.s103 + 0)
.s102:
21bb : c8 __ __ INY
21bc : 90 01 __ BCC $21bf ; (connect_via_existing_corridors.s274 + 0)
.s103:
; 396, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21be : 88 __ __ DEY
.s274:
21bf : 8c 53 9f STY $9f53 ; (current2_x + 0)
21c2 : 98 __ __ TYA
21c3 : 4c 62 21 JMP $2162 ; (connect_via_existing_corridors.s101 + 0)
.s58:
; 352, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21c6 : c4 52 __ CPY T6 + 0 
21c8 : b0 03 __ BCS $21cd ; (connect_via_existing_corridors.s62 + 0)
.s61:
21ca : c8 __ __ INY
21cb : 90 01 __ BCC $21ce ; (connect_via_existing_corridors.s271 + 0)
.s62:
; 353, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21cd : 88 __ __ DEY
.s271:
21ce : 8c 97 9f STY $9f97 ; (current1_x + 0)
21d1 : 98 __ __ TYA
21d2 : 4c fd 1f JMP $1ffd ; (connect_via_existing_corridors.s60 + 0)
--------------------------------------------------------------------
find_room_exit: ; find_room_exit(struct S#1442*,u8,u8,u8*,u8*)->void
.s0:
; 176, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
21d5 : 38 __ __ SEC
21d6 : a5 12 __ LDA P5 ; (room + 0)
21d8 : e9 00 __ SBC #$00
21da : 85 43 __ STA T0 + 0 
21dc : a5 13 __ LDA P6 ; (room + 1)
21de : e9 43 __ SBC #$43
21e0 : 4a __ __ LSR
21e1 : 66 43 __ ROR T0 + 0 
21e3 : 4a __ __ LSR
21e4 : 66 43 __ ROR T0 + 0 
21e6 : 4a __ __ LSR
21e7 : a5 43 __ LDA T0 + 0 
21e9 : 6a __ __ ROR
21ea : 85 0d __ STA P0 
21ec : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
; 177, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
21ef : a9 f9 __ LDA #$f9
21f1 : 85 0e __ STA P1 
21f3 : a9 9f __ LDA #$9f
21f5 : 85 11 __ STA P4 
21f7 : a9 9f __ LDA #$9f
21f9 : 85 0f __ STA P2 
21fb : a9 f8 __ LDA #$f8
21fd : 85 10 __ STA P3 
21ff : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 179, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2202 : a5 14 __ LDA P7 ; (target_x + 0)
2204 : 85 0d __ STA P0 
2206 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
2209 : 85 45 __ STA T5 + 0 
220b : 85 0e __ STA P1 
220d : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
2210 : 85 46 __ STA T6 + 0 
2212 : 8d f6 9f STA $9ff6 ; (room_center_y + 0)
; 180, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2215 : a5 15 __ LDA P8 ; (target_y + 0)
2217 : 85 0d __ STA P0 
2219 : ad f8 9f LDA $9ff8 ; (room + 1)
221c : 85 47 __ STA T8 + 0 
221e : 85 0e __ STA P1 
2220 : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
2223 : 8d f5 9f STA $9ff5 ; (s + 1)
; 182, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2226 : ae fa 9f LDX $9ffa ; (sstack + 0)
2229 : 86 1b __ STX ACCU + 0 
222b : ae fb 9f LDX $9ffb ; (sstack + 1)
222e : 86 1c __ STX ACCU + 1 
2230 : c5 46 __ CMP T6 + 0 
2232 : 90 22 __ BCC $2256 ; (find_room_exit.s1 + 0)
.s2:
; 195, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2234 : a0 01 __ LDY #$01
2236 : b1 12 __ LDA (P5),y ; (room + 0)
2238 : 85 1d __ STA ACCU + 2 
223a : a5 47 __ LDA T8 + 0 
223c : c5 15 __ CMP P8 ; (target_y + 0)
223e : 90 06 __ BCC $2246 ; (find_room_exit.s7 + 0)
.s8:
; 201, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2240 : c6 1d __ DEC ACCU + 2 
2242 : a5 1d __ LDA ACCU + 2 
2244 : b0 06 __ BCS $224c ; (find_room_exit.s1003 + 0)
.s7:
; 197, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2246 : a0 03 __ LDY #$03
2248 : b1 12 __ LDA (P5),y ; (room + 0)
224a : 65 1d __ ADC ACCU + 2 
.s1003:
; 201, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
224c : a0 00 __ LDY #$00
224e : 91 1b __ STA (ACCU + 0),y 
; 202, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2250 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
2253 : 91 16 __ STA (P9),y ; (exit_x + 0)
.s1001:
; 205, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2255 : 60 __ __ RTS
.s1:
; 184, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2256 : a0 00 __ LDY #$00
2258 : b1 12 __ LDA (P5),y ; (room + 0)
225a : 85 1d __ STA ACCU + 2 
225c : a5 45 __ LDA T5 + 0 
225e : c5 14 __ CMP P7 ; (target_x + 0)
2260 : b0 0a __ BCS $226c ; (find_room_exit.s5 + 0)
.s4:
; 190, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2262 : a0 02 __ LDY #$02
2264 : b1 12 __ LDA (P5),y ; (room + 0)
2266 : 65 1d __ ADC ACCU + 2 
2268 : a0 00 __ LDY #$00
226a : f0 04 __ BEQ $2270 ; (find_room_exit.s1002 + 0)
.s5:
; 190, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
226c : c6 1d __ DEC ACCU + 2 
226e : a5 1d __ LDA ACCU + 2 
.s1002:
2270 : 91 16 __ STA (P9),y ; (exit_x + 0)
; 191, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2272 : ad f8 9f LDA $9ff8 ; (room + 1)
2275 : 91 1b __ STA (ACCU + 0),y 
2277 : 60 __ __ RTS
--------------------------------------------------------------------
tile_is_floor: ; tile_is_floor(u8,u8)->u8
.s0:
; 268, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
2278 : a5 0f __ LDA P2 ; (x + 0)
227a : c9 40 __ CMP #$40
227c : b0 17 __ BCS $2295 ; (tile_is_floor.s1005 + 0)
.s4:
227e : a5 10 __ LDA P3 ; (y + 0)
2280 : c9 40 __ CMP #$40
2282 : b0 11 __ BCS $2295 ; (tile_is_floor.s1005 + 0)
.s3:
; 269, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
2284 : 85 0e __ STA P1 
2286 : a5 0f __ LDA P2 ; (x + 0)
2288 : 85 0d __ STA P0 
228a : 20 14 15 JSR $1514 ; (get_tile_core.s0 + 0)
228d : c9 02 __ CMP #$02
228f : d0 04 __ BNE $2295 ; (tile_is_floor.s1005 + 0)
.s1002:
2291 : a9 01 __ LDA #$01
2293 : d0 02 __ BNE $2297 ; (tile_is_floor.s1001 + 0)
.s1005:
2295 : a9 00 __ LDA #$00
.s1001:
2297 : 85 1b __ STA ACCU + 0 
2299 : 60 __ __ RTS
--------------------------------------------------------------------
can_place_corridor_tile: ; can_place_corridor_tile(u8,u8)->u8
.s0:
; 109, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
229a : a5 13 __ LDA P6 ; (x + 0)
229c : 85 0d __ STA P0 
229e : a5 14 __ LDA P7 ; (y + 0)
22a0 : 85 0e __ STA P1 
22a2 : ad 4e 35 LDA $354e ; (corridor_endpoint_override + 0)
22a5 : f0 03 __ BEQ $22aa ; (can_place_corridor_tile.s3 + 0)
22a7 : 4c 2f 23 JMP $232f ; (can_place_corridor_tile.s1 + 0)
.s3:
; 114, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
22aa : 20 4e 1c JSR $1c4e ; (coords_in_bounds_fast.s0 + 0)
22ad : aa __ __ TAX
22ae : f0 7e __ BEQ $232e ; (can_place_corridor_tile.s1001 + 0)
.s15:
; 116, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
22b0 : a5 13 __ LDA P6 ; (x + 0)
22b2 : 85 0f __ STA P2 
22b4 : a5 14 __ LDA P7 ; (y + 0)
22b6 : 85 10 __ STA P3 
22b8 : 20 a5 1c JSR $1ca5 ; (is_outside_any_room.s0 + 0)
22bb : aa __ __ TAX
22bc : f0 70 __ BEQ $232e ; (can_place_corridor_tile.s1001 + 0)
.s19:
; 120, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
22be : e6 0f __ INC P2 
22c0 : 20 a5 1c JSR $1ca5 ; (is_outside_any_room.s0 + 0)
22c3 : aa __ __ TAX
22c4 : f0 68 __ BEQ $232e ; (can_place_corridor_tile.s1001 + 0)
.s26:
; 121, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
22c6 : a6 13 __ LDX P6 ; (x + 0)
22c8 : ca __ __ DEX
22c9 : 86 0f __ STX P2 
22cb : 20 a5 1c JSR $1ca5 ; (is_outside_any_room.s0 + 0)
22ce : aa __ __ TAX
22cf : f0 5d __ BEQ $232e ; (can_place_corridor_tile.s1001 + 0)
.s25:
; 122, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
22d1 : e6 0f __ INC P2 
22d3 : e6 10 __ INC P3 
22d5 : 20 a5 1c JSR $1ca5 ; (is_outside_any_room.s0 + 0)
22d8 : aa __ __ TAX
22d9 : f0 53 __ BEQ $232e ; (can_place_corridor_tile.s1001 + 0)
.s24:
; 123, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
22db : a6 14 __ LDX P7 ; (y + 0)
22dd : ca __ __ DEX
22de : 86 10 __ STX P3 
22e0 : 20 a5 1c JSR $1ca5 ; (is_outside_any_room.s0 + 0)
22e3 : aa __ __ TAX
22e4 : f0 48 __ BEQ $232e ; (can_place_corridor_tile.s1001 + 0)
.s23:
; 128, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
22e6 : a9 00 __ LDA #$00
22e8 : 8d f8 9f STA $9ff8 ; (room + 1)
22eb : ad 40 34 LDA $3440 ; (room_count + 0)
22ee : f0 3c __ BEQ $232c ; (can_place_corridor_tile.s10 + 0)
.l29:
; 130, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
22f0 : ad f8 9f LDA $9ff8 ; (room + 1)
22f3 : 85 45 __ STA T6 + 0 
22f5 : 85 0d __ STA P0 
22f7 : a9 f7 __ LDA #$f7
22f9 : 85 0e __ STA P1 
22fb : a9 9f __ LDA #$9f
22fd : 85 0f __ STA P2 
22ff : a9 f6 __ LDA #$f6
2301 : 85 10 __ STA P3 
2303 : a9 9f __ LDA #$9f
2305 : 85 11 __ STA P4 
2307 : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 131, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
230a : a5 13 __ LDA P6 ; (x + 0)
230c : 85 0f __ STA P2 
230e : a5 14 __ LDA P7 ; (y + 0)
2310 : 85 10 __ STA P3 
2312 : ad f7 9f LDA $9ff7 ; (byte_ptr + 1)
2315 : 85 11 __ STA P4 
2317 : ad f6 9f LDA $9ff6 ; (room_center_y + 0)
231a : 85 12 __ STA P5 
231c : 20 44 23 JSR $2344 ; (manhattan_distance_fast.s0 + 0)
; 128, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
231f : 18 __ __ CLC
2320 : a5 45 __ LDA T6 + 0 
2322 : 69 01 __ ADC #$01
2324 : 8d f8 9f STA $9ff8 ; (room + 1)
2327 : cd 40 34 CMP $3440 ; (room_count + 0)
232a : 90 c4 __ BCC $22f0 ; (can_place_corridor_tile.l29 + 0)
.s10:
; 112, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
232c : a9 01 __ LDA #$01
.s1001:
; 110, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
232e : 60 __ __ RTS
.s1:
232f : 20 4e 1c JSR $1c4e ; (coords_in_bounds_fast.s0 + 0)
2332 : aa __ __ TAX
2333 : f0 f9 __ BEQ $232e ; (can_place_corridor_tile.s1001 + 0)
.s6:
; 111, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2335 : a5 13 __ LDA P6 ; (x + 0)
2337 : 85 0f __ STA P2 
2339 : a5 14 __ LDA P7 ; (y + 0)
233b : 85 10 __ STA P3 
233d : 20 a5 1c JSR $1ca5 ; (is_outside_any_room.s0 + 0)
2340 : aa __ __ TAX
2341 : d0 e9 __ BNE $232c ; (can_place_corridor_tile.s10 + 0)
2343 : 60 __ __ RTS
--------------------------------------------------------------------
manhattan_distance_fast: ; manhattan_distance_fast(u8,u8,u8,u8)->u8
.s0:
;  50, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utility.h"
2344 : a5 0f __ LDA P2 ; (x1 + 0)
2346 : 85 0d __ STA P0 
2348 : a5 11 __ LDA P4 ; (x2 + 0)
234a : 85 0e __ STA P1 
234c : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
234f : 85 43 __ STA T0 + 0 
2351 : a5 10 __ LDA P3 ; (y1 + 0)
2353 : 85 0d __ STA P0 
2355 : a5 12 __ LDA P5 ; (y2 + 0)
2357 : 85 0e __ STA P1 
2359 : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
235c : 18 __ __ CLC
235d : 65 43 __ ADC T0 + 0 
.s1001:
235f : 60 __ __ RTS
--------------------------------------------------------------------
place_doors_along_corridor: ; place_doors_along_corridor(const struct S#3995*)->void
.s0:
;  55, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
2360 : a9 00 __ LDA #$00
2362 : f0 05 __ BEQ $2369 ; (place_doors_along_corridor.l1 + 0)
.s2:
;  57, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
2364 : 18 __ __ CLC
2365 : a5 4b __ LDA T4 + 0 
2367 : 69 01 __ ADC #$01
.l1:
;  55, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
2369 : 8d ef 9f STA $9fef ; (screen_pos + 1)
;  56, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
236c : 85 4b __ STA T4 + 0 
236e : a0 28 __ LDY #$28
2370 : b1 15 __ LDA (P8),y ; (path + 0)
2372 : 85 4c __ STA T5 + 0 
2374 : a5 4b __ LDA T4 + 0 
2376 : c5 4c __ CMP T5 + 0 
2378 : b0 4b __ BCS $23c5 ; (place_doors_along_corridor.s7 + 0)
.s4:
237a : 65 15 __ ADC P8 ; (path + 0)
237c : 85 43 __ STA T0 + 0 
237e : a5 16 __ LDA P9 ; (path + 1)
2380 : 69 00 __ ADC #$00
2382 : 85 44 __ STA T0 + 1 
2384 : a4 4b __ LDY T4 + 0 
2386 : b1 15 __ LDA (P8),y ; (path + 0)
2388 : 85 10 __ STA P3 
238a : a0 14 __ LDY #$14
238c : b1 43 __ LDA (T0 + 0),y 
238e : 85 11 __ STA P4 
2390 : 20 4a 24 JSR $244a ; (is_adjacent_to_room.s0 + 0)
2393 : a5 1b __ LDA ACCU + 0 
2395 : f0 cd __ BEQ $2364 ; (place_doors_along_corridor.s2 + 0)
.s5:
;  60, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
2397 : 20 2c 25 JSR $252c ; (is_corner.s0 + 0)
239a : 18 __ __ CLC
239b : a5 15 __ LDA P8 ; (path + 0)
239d : 69 14 __ ADC #$14
239f : 85 43 __ STA T0 + 0 
23a1 : a5 16 __ LDA P9 ; (path + 1)
23a3 : 69 00 __ ADC #$00
23a5 : 85 44 __ STA T0 + 1 
23a7 : a5 1b __ LDA ACCU + 0 
23a9 : f0 0c __ BEQ $23b7 ; (place_doors_along_corridor.s10 + 0)
.s11:
23ab : 18 __ __ CLC
23ac : a5 4b __ LDA T4 + 0 
23ae : 69 01 __ ADC #$01
23b0 : c5 4c __ CMP T5 + 0 
23b2 : b0 03 __ BCS $23b7 ; (place_doors_along_corridor.s10 + 0)
.s8:
23b4 : 8d ef 9f STA $9fef ; (screen_pos + 1)
.s10:
;  61, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
23b7 : ac ef 9f LDY $9fef ; (screen_pos + 1)
23ba : b1 43 __ LDA (T0 + 0),y 
23bc : 85 14 __ STA P7 
23be : b1 15 __ LDA (P8),y ; (path + 0)
23c0 : 85 13 __ STA P6 
23c2 : 20 fa 25 JSR $25fa ; (place_door.s0 + 0)
.s7:
;  64, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
23c5 : a5 4c __ LDA T5 + 0 
23c7 : 38 __ __ SEC
23c8 : e9 01 __ SBC #$01
23ca : 8d ef 9f STA $9fef ; (screen_pos + 1)
;  65, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
23cd : c9 ff __ CMP #$ff
23cf : b0 2e __ BCS $23ff ; (place_doors_along_corridor.s14 + 0)
.s57:
23d1 : a5 15 __ LDA P8 ; (path + 0)
23d3 : 69 14 __ ADC #$14
23d5 : 85 49 __ STA T2 + 0 
23d7 : a5 16 __ LDA P9 ; (path + 1)
23d9 : 69 00 __ ADC #$00
23db : 85 4a __ STA T2 + 1 
.l15:
23dd : ac ef 9f LDY $9fef ; (screen_pos + 1)
23e0 : 84 4b __ STY T4 + 0 
23e2 : b1 49 __ LDA (T2 + 0),y 
23e4 : 85 11 __ STA P4 
23e6 : b1 15 __ LDA (P8),y ; (path + 0)
23e8 : 85 10 __ STA P3 
23ea : 20 4a 24 JSR $244a ; (is_adjacent_to_room.s0 + 0)
23ed : a5 1b __ LDA ACCU + 0 
23ef : d0 0e __ BNE $23ff ; (place_doors_along_corridor.s14 + 0)
.s13:
;  66, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
23f1 : a5 4b __ LDA T4 + 0 
23f3 : f0 0a __ BEQ $23ff ; (place_doors_along_corridor.s14 + 0)
.s18:
;  67, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
23f5 : 18 __ __ CLC
23f6 : 69 ff __ ADC #$ff
23f8 : 8d ef 9f STA $9fef ; (screen_pos + 1)
;  65, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
23fb : c9 ff __ CMP #$ff
23fd : 90 de __ BCC $23dd ; (place_doors_along_corridor.l15 + 0)
.s14:
;  69, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
23ff : ad ef 9f LDA $9fef ; (screen_pos + 1)
2402 : c5 4c __ CMP T5 + 0 
2404 : 90 01 __ BCC $2407 ; (place_doors_along_corridor.s20 + 0)
.s1001:
;  73, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
2406 : 60 __ __ RTS
.s20:
;  70, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
2407 : 85 49 __ STA T2 + 0 
2409 : a8 __ __ TAY
240a : 65 15 __ ADC P8 ; (path + 0)
240c : 85 43 __ STA T0 + 0 
240e : a5 16 __ LDA P9 ; (path + 1)
2410 : 69 00 __ ADC #$00
2412 : 85 44 __ STA T0 + 1 
2414 : b1 15 __ LDA (P8),y ; (path + 0)
2416 : 85 10 __ STA P3 
2418 : a0 14 __ LDY #$14
241a : b1 43 __ LDA (T0 + 0),y 
241c : 85 11 __ STA P4 
241e : 20 2c 25 JSR $252c ; (is_corner.s0 + 0)
2421 : 18 __ __ CLC
2422 : a5 15 __ LDA P8 ; (path + 0)
2424 : 69 14 __ ADC #$14
2426 : 85 43 __ STA T0 + 0 
2428 : a5 16 __ LDA P9 ; (path + 1)
242a : 69 00 __ ADC #$00
242c : 85 44 __ STA T0 + 1 
242e : a5 1b __ LDA ACCU + 0 
2430 : f0 0a __ BEQ $243c ; (place_doors_along_corridor.s25 + 0)
.s26:
2432 : a5 49 __ LDA T2 + 0 
2434 : f0 06 __ BEQ $243c ; (place_doors_along_corridor.s25 + 0)
.s23:
2436 : 18 __ __ CLC
2437 : 69 ff __ ADC #$ff
2439 : 8d ef 9f STA $9fef ; (screen_pos + 1)
.s25:
;  71, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
243c : ac ef 9f LDY $9fef ; (screen_pos + 1)
243f : b1 43 __ LDA (T0 + 0),y 
2441 : 85 14 __ STA P7 
2443 : b1 15 __ LDA (P8),y ; (path + 0)
2445 : 85 13 __ STA P6 
2447 : 4c fa 25 JMP $25fa ; (place_door.s0 + 0)
--------------------------------------------------------------------
is_adjacent_to_room: ; is_adjacent_to_room(u8,u8)->u8
.s0:
;  18, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
244a : a9 00 __ LDA #$00
244c : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
244f : ad 40 34 LDA $3440 ; (room_count + 0)
2452 : d0 03 __ BNE $2457 ; (is_adjacent_to_room.s20 + 0)
2454 : 4c e5 24 JMP $24e5 ; (is_adjacent_to_room.s4 + 0)
.s20:
;  21, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
2457 : 85 44 __ STA T4 + 0 
2459 : a6 10 __ LDX P3 ; (x + 0)
245b : ca __ __ DEX
245c : 86 43 __ STX T2 + 0 
.l2:
;  19, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
245e : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
2461 : 85 45 __ STA T6 + 0 
2463 : 0a __ __ ASL
2464 : 0a __ __ ASL
2465 : 0a __ __ ASL
2466 : 18 __ __ CLC
2467 : 69 00 __ ADC #$00
2469 : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
246c : a9 43 __ LDA #$43
246e : 69 00 __ ADC #$00
2470 : 8d f8 9f STA $9ff8 ; (room + 1)
;  21, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
2473 : a5 10 __ LDA P3 ; (x + 0)
2475 : f0 14 __ BEQ $248b ; (is_adjacent_to_room.s10 + 0)
.s11:
2477 : a5 43 __ LDA T2 + 0 
2479 : 85 0d __ STA P0 
247b : a5 11 __ LDA P4 ; (y + 0)
247d : 85 0e __ STA P1 
247f : a5 45 __ LDA T6 + 0 
2481 : 85 0f __ STA P2 
2483 : 20 ee 24 JSR $24ee ; (point_in_room.s0 + 0)
2486 : aa __ __ TAX
2487 : d0 61 __ BNE $24ea ; (is_adjacent_to_room.s5 + 0)
.s1005:
;  22, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
2489 : a5 10 __ LDA P3 ; (x + 0)
.s10:
248b : 18 __ __ CLC
248c : 69 01 __ ADC #$01
248e : b0 14 __ BCS $24a4 ; (is_adjacent_to_room.s9 + 0)
.s1003:
2490 : c9 40 __ CMP #$40
2492 : b0 10 __ BCS $24a4 ; (is_adjacent_to_room.s9 + 0)
.s12:
2494 : 85 0d __ STA P0 
2496 : a5 11 __ LDA P4 ; (y + 0)
2498 : 85 0e __ STA P1 
249a : a5 45 __ LDA T6 + 0 
249c : 85 0f __ STA P2 
249e : 20 ee 24 JSR $24ee ; (point_in_room.s0 + 0)
24a1 : aa __ __ TAX
24a2 : d0 46 __ BNE $24ea ; (is_adjacent_to_room.s5 + 0)
.s9:
;  23, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
24a4 : a5 11 __ LDA P4 ; (y + 0)
24a6 : f0 15 __ BEQ $24bd ; (is_adjacent_to_room.s8 + 0)
.s13:
24a8 : a6 10 __ LDX P3 ; (x + 0)
24aa : 86 0d __ STX P0 
24ac : a6 45 __ LDX T6 + 0 
24ae : 86 0f __ STX P2 
24b0 : 38 __ __ SEC
24b1 : e9 01 __ SBC #$01
24b3 : 85 0e __ STA P1 
24b5 : 20 ee 24 JSR $24ee ; (point_in_room.s0 + 0)
24b8 : aa __ __ TAX
24b9 : d0 2f __ BNE $24ea ; (is_adjacent_to_room.s5 + 0)
.s1006:
;  24, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
24bb : a5 11 __ LDA P4 ; (y + 0)
.s8:
24bd : 18 __ __ CLC
24be : 69 01 __ ADC #$01
24c0 : b0 14 __ BCS $24d6 ; (is_adjacent_to_room.s3 + 0)
.s1002:
24c2 : c9 40 __ CMP #$40
24c4 : b0 10 __ BCS $24d6 ; (is_adjacent_to_room.s3 + 0)
.s14:
24c6 : 85 0e __ STA P1 
24c8 : a5 10 __ LDA P3 ; (x + 0)
24ca : 85 0d __ STA P0 
24cc : a5 45 __ LDA T6 + 0 
24ce : 85 0f __ STA P2 
24d0 : 20 ee 24 JSR $24ee ; (point_in_room.s0 + 0)
24d3 : aa __ __ TAX
24d4 : d0 14 __ BNE $24ea ; (is_adjacent_to_room.s5 + 0)
.s3:
;  18, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
24d6 : 18 __ __ CLC
24d7 : a5 45 __ LDA T6 + 0 
24d9 : 69 01 __ ADC #$01
24db : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
24de : c5 44 __ CMP T4 + 0 
24e0 : b0 03 __ BCS $24e5 ; (is_adjacent_to_room.s4 + 0)
24e2 : 4c 5e 24 JMP $245e ; (is_adjacent_to_room.l2 + 0)
.s4:
;  28, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
24e5 : a9 00 __ LDA #$00
.s1001:
24e7 : 85 1b __ STA ACCU + 0 
24e9 : 60 __ __ RTS
.s5:
;  25, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
24ea : a9 01 __ LDA #$01
24ec : d0 f9 __ BNE $24e7 ; (is_adjacent_to_room.s1001 + 0)
--------------------------------------------------------------------
point_in_room: ; point_in_room(u8,u8,u8)->u8
.s0:
; 489, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
24ee : a5 0f __ LDA P2 ; (room_id + 0)
24f0 : 0a __ __ ASL
24f1 : 0a __ __ ASL
24f2 : 0a __ __ ASL
24f3 : aa __ __ TAX
24f4 : a5 0d __ LDA P0 ; (x + 0)
24f6 : dd 00 43 CMP $4300,x ; (rooms + 0)
24f9 : 90 16 __ BCC $2511 ; (point_in_room.s2 + 0)
.s6:
24fb : bd 02 43 LDA $4302,x ; (rooms + 2)
24fe : 18 __ __ CLC
24ff : 7d 00 43 ADC $4300,x ; (rooms + 0)
2502 : b0 06 __ BCS $250a ; (point_in_room.s5 + 0)
.s1005:
2504 : c5 0d __ CMP P0 ; (x + 0)
2506 : 90 09 __ BCC $2511 ; (point_in_room.s2 + 0)
.s1010:
2508 : f0 07 __ BEQ $2511 ; (point_in_room.s2 + 0)
.s5:
; 490, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
250a : a5 0e __ LDA P1 ; (y + 0)
250c : dd 01 43 CMP $4301,x ; (rooms + 1)
250f : b0 03 __ BCS $2514 ; (point_in_room.s4 + 0)
.s2:
2511 : a9 00 __ LDA #$00
.s1001:
; 489, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
2513 : 60 __ __ RTS
.s4:
; 490, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
2514 : bd 03 43 LDA $4303,x ; (rooms + 3)
2517 : 18 __ __ CLC
2518 : 7d 01 43 ADC $4301,x ; (rooms + 1)
251b : 90 03 __ BCC $2520 ; (point_in_room.s1002 + 0)
.s1:
251d : a9 01 __ LDA #$01
251f : 60 __ __ RTS
.s1002:
; 490, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
2520 : 85 1b __ STA ACCU + 0 
2522 : a5 0e __ LDA P1 ; (y + 0)
2524 : c5 1b __ CMP ACCU + 0 
2526 : a9 00 __ LDA #$00
2528 : 2a __ __ ROL
2529 : 49 01 __ EOR #$01
252b : 60 __ __ RTS
--------------------------------------------------------------------
is_corner: ; is_corner(u8,u8)->u8
.s0:
;  33, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
252c : a9 00 __ LDA #$00
252e : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
2531 : ad 40 34 LDA $3440 ; (room_count + 0)
2534 : d0 05 __ BNE $253b ; (is_corner.s24 + 0)
.s4:
;  42, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
2536 : a9 00 __ LDA #$00
.s1001:
2538 : 85 1b __ STA ACCU + 0 
253a : 60 __ __ RTS
.s24:
;  37, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
253b : 85 45 __ STA T5 + 0 
253d : a6 10 __ LDX P3 ; (x + 0)
253f : ca __ __ DEX
2540 : 86 43 __ STX T2 + 0 
.l2:
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
2542 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
2545 : 85 46 __ STA T7 + 0 
2547 : 0a __ __ ASL
2548 : 0a __ __ ASL
2549 : 0a __ __ ASL
254a : 18 __ __ CLC
254b : 69 00 __ ADC #$00
254d : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
2550 : a9 43 __ LDA #$43
2552 : 69 00 __ ADC #$00
2554 : 8d f8 9f STA $9ff8 ; (room + 1)
;  35, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
2557 : a5 10 __ LDA P3 ; (x + 0)
2559 : f0 02 __ BEQ $255d ; (is_corner.s1014 + 0)
.s1013:
255b : a9 01 __ LDA #$01
.s1014:
255d : 85 47 __ STA T8 + 0 
255f : f0 15 __ BEQ $2576 ; (is_corner.s10 + 0)
.s12:
2561 : a6 11 __ LDX P4 ; (y + 0)
2563 : f0 11 __ BEQ $2576 ; (is_corner.s10 + 0)
.s11:
2565 : ca __ __ DEX
2566 : 86 0e __ STX P1 
2568 : a5 43 __ LDA T2 + 0 
256a : 85 0d __ STA P0 
256c : a5 46 __ LDA T7 + 0 
256e : 85 0f __ STA P2 
2570 : 20 ee 24 JSR $24ee ; (point_in_room.s0 + 0)
2573 : aa __ __ TAX
2574 : d0 6d __ BNE $25e3 ; (is_corner.s5 + 0)
.s10:
;  36, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
2576 : 18 __ __ CLC
2577 : a5 10 __ LDA P3 ; (x + 0)
2579 : 69 01 __ ADC #$01
257b : 85 44 __ STA T3 + 0 
257d : 90 06 __ BCC $2585 ; (is_corner.s1008 + 0)
.s1006:
257f : a9 00 __ LDA #$00
2581 : 85 48 __ STA T9 + 0 
2583 : b0 20 __ BCS $25a5 ; (is_corner.s9 + 0)
.s1008:
2585 : c9 40 __ CMP #$40
2587 : a9 00 __ LDA #$00
2589 : 2a __ __ ROL
258a : 49 01 __ EOR #$01
258c : 85 48 __ STA T9 + 0 
258e : f0 15 __ BEQ $25a5 ; (is_corner.s9 + 0)
.s14:
2590 : a6 11 __ LDX P4 ; (y + 0)
2592 : f0 11 __ BEQ $25a5 ; (is_corner.s9 + 0)
.s13:
2594 : ca __ __ DEX
2595 : 86 0e __ STX P1 
2597 : a5 44 __ LDA T3 + 0 
2599 : 85 0d __ STA P0 
259b : a5 46 __ LDA T7 + 0 
259d : 85 0f __ STA P2 
259f : 20 ee 24 JSR $24ee ; (point_in_room.s0 + 0)
25a2 : aa __ __ TAX
25a3 : d0 3e __ BNE $25e3 ; (is_corner.s5 + 0)
.s9:
;  37, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
25a5 : a5 47 __ LDA T8 + 0 
25a7 : f0 1b __ BEQ $25c4 ; (is_corner.s8 + 0)
.s16:
25a9 : 18 __ __ CLC
25aa : a5 11 __ LDA P4 ; (y + 0)
25ac : 69 01 __ ADC #$01
25ae : b0 14 __ BCS $25c4 ; (is_corner.s8 + 0)
.s1010:
25b0 : c9 40 __ CMP #$40
25b2 : b0 10 __ BCS $25c4 ; (is_corner.s8 + 0)
.s15:
25b4 : 85 0e __ STA P1 
25b6 : a5 43 __ LDA T2 + 0 
25b8 : 85 0d __ STA P0 
25ba : a5 46 __ LDA T7 + 0 
25bc : 85 0f __ STA P2 
25be : 20 ee 24 JSR $24ee ; (point_in_room.s0 + 0)
25c1 : aa __ __ TAX
25c2 : d0 1f __ BNE $25e3 ; (is_corner.s5 + 0)
.s8:
;  38, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
25c4 : a5 48 __ LDA T9 + 0 
25c6 : f0 20 __ BEQ $25e8 ; (is_corner.s3 + 0)
.s18:
25c8 : 18 __ __ CLC
25c9 : a5 11 __ LDA P4 ; (y + 0)
25cb : 69 01 __ ADC #$01
25cd : b0 19 __ BCS $25e8 ; (is_corner.s3 + 0)
.s1009:
25cf : c9 40 __ CMP #$40
25d1 : b0 15 __ BCS $25e8 ; (is_corner.s3 + 0)
.s17:
25d3 : 85 0e __ STA P1 
25d5 : a5 44 __ LDA T3 + 0 
25d7 : 85 0d __ STA P0 
25d9 : a5 46 __ LDA T7 + 0 
25db : 85 0f __ STA P2 
25dd : 20 ee 24 JSR $24ee ; (point_in_room.s0 + 0)
25e0 : aa __ __ TAX
25e1 : f0 05 __ BEQ $25e8 ; (is_corner.s3 + 0)
.s5:
;  39, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
25e3 : a9 01 __ LDA #$01
25e5 : 4c 38 25 JMP $2538 ; (is_corner.s1001 + 0)
.s3:
;  33, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
25e8 : 18 __ __ CLC
25e9 : a5 46 __ LDA T7 + 0 
25eb : 69 01 __ ADC #$01
25ed : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
25f0 : c5 45 __ CMP T5 + 0 
25f2 : b0 03 __ BCS $25f7 ; (is_corner.s3 + 15)
25f4 : 4c 42 25 JMP $2542 ; (is_corner.l2 + 0)
25f7 : 4c 36 25 JMP $2536 ; (is_corner.s4 + 0)
--------------------------------------------------------------------
place_door: ; place_door(u8,u8)->void
.s0:
;  47, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
25fa : a5 13 __ LDA P6 ; (x + 0)
25fc : 85 0d __ STA P0 
25fe : a5 14 __ LDA P7 ; (y + 0)
2600 : 85 0e __ STA P1 
2602 : 20 18 26 JSR $2618 ; (is_valid_room_wall_for_door.s0 + 0)
2605 : aa __ __ TAX
2606 : d0 01 __ BNE $2609 ; (place_door.s1 + 0)
.s1001:
;  50, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
2608 : 60 __ __ RTS
.s1:
;  48, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
2609 : a5 13 __ LDA P6 ; (x + 0)
260b : 85 10 __ STA P3 
260d : a5 14 __ LDA P7 ; (y + 0)
260f : 85 11 __ STA P4 
2611 : a9 03 __ LDA #$03
2613 : 85 12 __ STA P5 
2615 : 4c 3b 16 JMP $163b ; (set_tile_raw.s0 + 0)
--------------------------------------------------------------------
is_valid_room_wall_for_door: ; is_valid_room_wall_for_door(u8,u8)->u8
.s0:
;  20, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
2618 : a9 00 __ LDA #$00
261a : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
261d : ad 40 34 LDA $3440 ; (room_count + 0)
2620 : 85 1d __ STA ACCU + 2 
2622 : d0 03 __ BNE $2627 ; (is_valid_room_wall_for_door.l2 + 0)
2624 : 4c c7 26 JMP $26c7 ; (is_valid_room_wall_for_door.s4 + 0)
.l2:
;  21, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
2627 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
262a : 0a __ __ ASL
262b : 0a __ __ ASL
262c : 0a __ __ ASL
262d : aa __ __ TAX
262e : 69 00 __ ADC #$00
2630 : 85 1b __ STA ACCU + 0 
2632 : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
2635 : a9 43 __ LDA #$43
2637 : 69 00 __ ADC #$00
2639 : 85 1c __ STA ACCU + 1 
263b : 8d f8 9f STA $9ff8 ; (room + 1)
;  23, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
263e : a5 0e __ LDA P1 ; (y + 0)
2640 : dd 01 43 CMP $4301,x ; (rooms + 1)
2643 : 90 38 __ BCC $267d ; (is_valid_room_wall_for_door.s7 + 0)
.s8:
2645 : a0 03 __ LDY #$03
2647 : b1 1b __ LDA (ACCU + 0),y 
2649 : 18 __ __ CLC
264a : 7d 01 43 ADC $4301,x ; (rooms + 1)
264d : a8 __ __ TAY
264e : a9 00 __ LDA #$00
2650 : 2a __ __ ROL
2651 : 85 44 __ STA T3 + 1 
2653 : 98 __ __ TYA
2654 : e9 00 __ SBC #$00
2656 : a8 __ __ TAY
2657 : a5 44 __ LDA T3 + 1 
2659 : e9 00 __ SBC #$00
265b : d0 04 __ BNE $2661 ; (is_valid_room_wall_for_door.s5 + 0)
.s1017:
265d : c4 0e __ CPY P1 ; (y + 0)
265f : 90 1c __ BCC $267d ; (is_valid_room_wall_for_door.s7 + 0)
.s5:
;  24, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
2661 : a0 00 __ LDY #$00
2663 : b1 1b __ LDA (ACCU + 0),y 
2665 : 85 43 __ STA T3 + 0 
2667 : 38 __ __ SEC
2668 : e9 01 __ SBC #$01
266a : 90 04 __ BCC $2670 ; (is_valid_room_wall_for_door.s12 + 0)
.s1014:
266c : c5 0d __ CMP P0 ; (x + 0)
266e : f0 5a __ BEQ $26ca ; (is_valid_room_wall_for_door.s9 + 0)
.s12:
2670 : a0 02 __ LDY #$02
2672 : b1 1b __ LDA (ACCU + 0),y 
2674 : 18 __ __ CLC
2675 : 65 43 __ ADC T3 + 0 
2677 : b0 04 __ BCS $267d ; (is_valid_room_wall_for_door.s7 + 0)
.s1011:
2679 : c5 0d __ CMP P0 ; (x + 0)
267b : f0 4d __ BEQ $26ca ; (is_valid_room_wall_for_door.s9 + 0)
.s7:
;  29, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
267d : a0 00 __ LDY #$00
267f : b1 1b __ LDA (ACCU + 0),y 
2681 : c5 0d __ CMP P0 ; (x + 0)
2683 : 90 02 __ BCC $2687 ; (is_valid_room_wall_for_door.s17 + 0)
.s1022:
2685 : d0 33 __ BNE $26ba ; (is_valid_room_wall_for_door.s3 + 0)
.s17:
2687 : 18 __ __ CLC
2688 : a0 02 __ LDY #$02
268a : 71 1b __ ADC (ACCU + 0),y 
268c : a8 __ __ TAY
268d : a9 00 __ LDA #$00
268f : 2a __ __ ROL
2690 : 85 44 __ STA T3 + 1 
2692 : 98 __ __ TYA
2693 : e9 00 __ SBC #$00
2695 : a8 __ __ TAY
2696 : a5 44 __ LDA T3 + 1 
2698 : e9 00 __ SBC #$00
269a : d0 04 __ BNE $26a0 ; (is_valid_room_wall_for_door.s14 + 0)
.s1008:
269c : c4 0d __ CPY P0 ; (x + 0)
269e : 90 1a __ BCC $26ba ; (is_valid_room_wall_for_door.s3 + 0)
.s14:
;  30, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
26a0 : bd 01 43 LDA $4301,x ; (rooms + 1)
26a3 : 38 __ __ SEC
26a4 : e9 01 __ SBC #$01
26a6 : 90 04 __ BCC $26ac ; (is_valid_room_wall_for_door.s21 + 0)
.s1005:
26a8 : c5 0e __ CMP P1 ; (y + 0)
26aa : f0 1e __ BEQ $26ca ; (is_valid_room_wall_for_door.s9 + 0)
.s21:
26ac : a0 03 __ LDY #$03
26ae : b1 1b __ LDA (ACCU + 0),y 
26b0 : 18 __ __ CLC
26b1 : 7d 01 43 ADC $4301,x ; (rooms + 1)
26b4 : b0 04 __ BCS $26ba ; (is_valid_room_wall_for_door.s3 + 0)
.s1002:
26b6 : c5 0e __ CMP P1 ; (y + 0)
26b8 : f0 10 __ BEQ $26ca ; (is_valid_room_wall_for_door.s9 + 0)
.s3:
;  20, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
26ba : ee f9 9f INC $9ff9 ; (bit_offset + 1)
26bd : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
26c0 : c5 1d __ CMP ACCU + 2 
26c2 : b0 03 __ BCS $26c7 ; (is_valid_room_wall_for_door.s4 + 0)
26c4 : 4c 27 26 JMP $2627 ; (is_valid_room_wall_for_door.l2 + 0)
.s4:
;  35, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
26c7 : a9 00 __ LDA #$00
.s1001:
26c9 : 60 __ __ RTS
.s9:
26ca : a9 01 __ LDA #$01
26cc : 60 __ __ RTS
--------------------------------------------------------------------
draw_rule_based_corridor: ; draw_rule_based_corridor(u8,u8)->u8
.s0:
; 153, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26cd : a9 00 __ LDA #$00
26cf : 8d e6 9f STA $9fe6 ; (check_y + 0)
26d2 : 8d e5 9f STA $9fe5 ; (x + 0)
; 155, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26d5 : ad fc 9f LDA $9ffc ; (sstack + 2)
26d8 : 85 4d __ STA T1 + 0 
26da : 85 0d __ STA P0 
26dc : a9 ea __ LDA #$ea
26de : 85 0e __ STA P1 
26e0 : a9 9f __ LDA #$9f
26e2 : 85 11 __ STA P4 
26e4 : a9 9f __ LDA #$9f
26e6 : 85 0f __ STA P2 
26e8 : a9 e9 __ LDA #$e9
26ea : 85 10 __ STA P3 
26ec : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 156, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26ef : ad fd 9f LDA $9ffd ; (sstack + 3)
26f2 : 85 4e __ STA T2 + 0 
26f4 : 85 0d __ STA P0 
26f6 : a9 e8 __ LDA #$e8
26f8 : 85 0e __ STA P1 
26fa : a9 9f __ LDA #$9f
26fc : 85 11 __ STA P4 
26fe : a9 9f __ LDA #$9f
2700 : 85 0f __ STA P2 
2702 : a9 e7 __ LDA #$e7
2704 : 85 10 __ STA P3 
2706 : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 157, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2709 : a5 4d __ LDA T1 + 0 
270b : 0a __ __ ASL
270c : 0a __ __ ASL
270d : 0a __ __ ASL
270e : 85 50 __ STA T4 + 0 
2710 : 18 __ __ CLC
2711 : 69 00 __ ADC #$00
2713 : 85 12 __ STA P5 
2715 : a9 43 __ LDA #$43
2717 : 69 00 __ ADC #$00
2719 : 85 13 __ STA P6 
271b : ad e8 9f LDA $9fe8 ; (up_y + 0)
271e : 85 14 __ STA P7 
2720 : ad e7 9f LDA $9fe7 ; (down_x + 0)
2723 : 85 15 __ STA P8 
2725 : a9 ee __ LDA #$ee
2727 : 85 16 __ STA P9 
2729 : a9 ed __ LDA #$ed
272b : 8d fa 9f STA $9ffa ; (sstack + 0)
272e : a9 9f __ LDA #$9f
2730 : 85 17 __ STA P10 
2732 : a9 9f __ LDA #$9f
2734 : 8d fb 9f STA $9ffb ; (sstack + 1)
2737 : 20 d5 21 JSR $21d5 ; (find_room_exit.s0 + 0)
; 158, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
273a : a5 4e __ LDA T2 + 0 
273c : 0a __ __ ASL
273d : 0a __ __ ASL
273e : 0a __ __ ASL
273f : 18 __ __ CLC
2740 : 69 00 __ ADC #$00
2742 : 85 12 __ STA P5 
2744 : a9 43 __ LDA #$43
2746 : 69 00 __ ADC #$00
2748 : 85 13 __ STA P6 
274a : ad ea 9f LDA $9fea ; (i + 0)
274d : 85 14 __ STA P7 
274f : ad e9 9f LDA $9fe9 ; (up_x + 0)
2752 : 85 15 __ STA P8 
2754 : a9 ec __ LDA #$ec
2756 : 85 16 __ STA P9 
2758 : a9 eb __ LDA #$eb
275a : 8d fa 9f STA $9ffa ; (sstack + 0)
275d : a9 9f __ LDA #$9f
275f : 85 17 __ STA P10 
2761 : a9 9f __ LDA #$9f
2763 : 8d fb 9f STA $9ffb ; (sstack + 1)
2766 : 20 d5 21 JSR $21d5 ; (find_room_exit.s0 + 0)
; 161, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2769 : a2 00 __ LDX #$00
276b : 8e c8 43 STX $43c8 ; (corridor_path_static + 40)
; 163, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
276e : a4 50 __ LDY T4 + 0 
2770 : b9 00 43 LDA $4300,y ; (rooms + 0)
2773 : 38 __ __ SEC
2774 : e9 01 __ SBC #$01
2776 : 90 10 __ BCC $2788 ; (draw_rule_based_corridor.s2 + 0)
.s1031:
2778 : cd ee 9f CMP $9fee ; (entropy4 + 1)
277b : d0 0b __ BNE $2788 ; (draw_rule_based_corridor.s2 + 0)
.s1:
277d : a9 ff __ LDA #$ff
.s171:
; 164, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
277f : 8e e5 9f STX $9fe5 ; (x + 0)
2782 : 8d e6 9f STA $9fe6 ; (check_y + 0)
2785 : 4c c4 27 JMP $27c4 ; (draw_rule_based_corridor.s3 + 0)
.s2:
; 164, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2788 : b9 02 43 LDA $4302,y ; (rooms + 2)
278b : 18 __ __ CLC
278c : 79 00 43 ADC $4300,y ; (rooms + 0)
278f : b0 09 __ BCS $279a ; (draw_rule_based_corridor.s5 + 0)
.s1028:
2791 : cd ee 9f CMP $9fee ; (entropy4 + 1)
2794 : d0 04 __ BNE $279a ; (draw_rule_based_corridor.s5 + 0)
.s4:
2796 : a9 01 __ LDA #$01
2798 : d0 e5 __ BNE $277f ; (draw_rule_based_corridor.s171 + 0)
.s5:
; 165, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
279a : b9 01 43 LDA $4301,y ; (rooms + 1)
279d : 38 __ __ SEC
279e : e9 01 __ SBC #$01
27a0 : 90 10 __ BCC $27b2 ; (draw_rule_based_corridor.s8 + 0)
.s1025:
27a2 : cd ed 9f CMP $9fed ; (highest_priority + 0)
27a5 : d0 0b __ BNE $27b2 ; (draw_rule_based_corridor.s8 + 0)
.s7:
27a7 : a9 ff __ LDA #$ff
.s198:
; 166, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
27a9 : 8e e6 9f STX $9fe6 ; (check_y + 0)
27ac : 8d e5 9f STA $9fe5 ; (x + 0)
27af : 4c c4 27 JMP $27c4 ; (draw_rule_based_corridor.s3 + 0)
.s8:
; 166, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
27b2 : b9 03 43 LDA $4303,y ; (rooms + 3)
27b5 : 18 __ __ CLC
27b6 : 79 01 43 ADC $4301,y ; (rooms + 1)
27b9 : b0 09 __ BCS $27c4 ; (draw_rule_based_corridor.s3 + 0)
.s1022:
27bb : cd ed 9f CMP $9fed ; (highest_priority + 0)
27be : d0 04 __ BNE $27c4 ; (draw_rule_based_corridor.s3 + 0)
.s10:
27c0 : a9 01 __ LDA #$01
27c2 : d0 e5 __ BNE $27a9 ; (draw_rule_based_corridor.s198 + 0)
.s3:
; 168, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
27c4 : ad e6 9f LDA $9fe6 ; (check_y + 0)
27c7 : 85 4f __ STA T3 + 0 
27c9 : 18 __ __ CLC
27ca : 6d ee 9f ADC $9fee ; (entropy4 + 1)
27cd : 85 13 __ STA P6 
27cf : 8d e4 9f STA $9fe4 ; (tile + 0)
; 171, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
27d2 : a9 01 __ LDA #$01
27d4 : 8d 4e 35 STA $354e ; (corridor_endpoint_override + 0)
; 169, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
27d7 : ad e5 9f LDA $9fe5 ; (x + 0)
27da : 85 50 __ STA T4 + 0 
27dc : 18 __ __ CLC
27dd : 6d ed 9f ADC $9fed ; (highest_priority + 0)
27e0 : 85 14 __ STA P7 
27e2 : 8d e3 9f STA $9fe3 ; (y + 0)
; 172, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
27e5 : 20 9a 22 JSR $229a ; (can_place_corridor_tile.s0 + 0)
27e8 : aa __ __ TAX
27e9 : f0 24 __ BEQ $280f ; (draw_rule_based_corridor.s56 + 0)
.s13:
; 173, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
27eb : a5 13 __ LDA P6 
27ed : 85 10 __ STA P3 
27ef : a5 14 __ LDA P7 
27f1 : 85 11 __ STA P4 
27f3 : a9 02 __ LDA #$02
27f5 : 85 12 __ STA P5 
27f7 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
; 174, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
27fa : ae c8 43 LDX $43c8 ; (corridor_path_static + 40)
27fd : e0 14 __ CPX #$14
27ff : b0 0e __ BCS $280f ; (draw_rule_based_corridor.s56 + 0)
.s16:
; 175, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2801 : a5 13 __ LDA P6 
2803 : 9d a0 43 STA $43a0,x ; (corridor_path_static + 0)
; 176, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2806 : a5 14 __ LDA P7 
2808 : 9d b4 43 STA $43b4,x ; (corridor_path_static + 20)
; 177, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
280b : e8 __ __ INX
280c : 8e c8 43 STX $43c8 ; (corridor_path_static + 40)
.s56:
; 180, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
280f : a9 00 __ LDA #$00
2811 : 8d 4e 35 STA $354e ; (corridor_endpoint_override + 0)
; 183, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2814 : a5 13 __ LDA P6 
2816 : 30 05 __ BMI $281d ; (draw_rule_based_corridor.l22 + 0)
.s1019:
; 183, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2818 : cd ec 9f CMP $9fec ; (i + 0)
281b : f0 56 __ BEQ $2873 ; (draw_rule_based_corridor.s55 + 0)
.l22:
281d : ad e3 9f LDA $9fe3 ; (y + 0)
2820 : 30 05 __ BMI $2827 ; (draw_rule_based_corridor.s20 + 0)
.s1016:
2822 : cd eb 9f CMP $9feb ; (screen_offset + 1)
2825 : f0 4c __ BEQ $2873 ; (draw_rule_based_corridor.s55 + 0)
.s20:
; 184, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2827 : ad e4 9f LDA $9fe4 ; (tile + 0)
282a : 18 __ __ CLC
282b : 65 4f __ ADC T3 + 0 
282d : 85 13 __ STA P6 
282f : 8d e4 9f STA $9fe4 ; (tile + 0)
; 185, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2832 : ad e3 9f LDA $9fe3 ; (y + 0)
2835 : 18 __ __ CLC
2836 : 65 50 __ ADC T4 + 0 
2838 : 85 14 __ STA P7 
283a : 8d e3 9f STA $9fe3 ; (y + 0)
; 186, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
283d : 20 9a 22 JSR $229a ; (can_place_corridor_tile.s0 + 0)
2840 : aa __ __ TAX
2841 : f0 2a __ BEQ $286d ; (draw_rule_based_corridor.s181 + 0)
.s23:
; 187, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2843 : a5 13 __ LDA P6 
2845 : 85 10 __ STA P3 
2847 : a5 14 __ LDA P7 
2849 : 85 11 __ STA P4 
284b : a9 02 __ LDA #$02
284d : 85 12 __ STA P5 
284f : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
; 188, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2852 : ae c8 43 LDX $43c8 ; (corridor_path_static + 40)
2855 : e0 14 __ CPX #$14
2857 : b0 14 __ BCS $286d ; (draw_rule_based_corridor.s181 + 0)
.s26:
; 189, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2859 : a5 13 __ LDA P6 
285b : 9d a0 43 STA $43a0,x ; (corridor_path_static + 0)
; 190, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
285e : a5 14 __ LDA P7 
2860 : 9d b4 43 STA $43b4,x ; (corridor_path_static + 20)
; 191, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2863 : e8 __ __ INX
2864 : 8e c8 43 STX $43c8 ; (corridor_path_static + 40)
; 183, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2867 : a5 13 __ LDA P6 
2869 : 30 b2 __ BMI $281d ; (draw_rule_based_corridor.l22 + 0)
286b : 10 ab __ BPL $2818 ; (draw_rule_based_corridor.s1019 + 0)
.s181:
; 183, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
286d : a5 13 __ LDA P6 
286f : 30 ac __ BMI $281d ; (draw_rule_based_corridor.l22 + 0)
2871 : 10 a5 __ BPL $2818 ; (draw_rule_based_corridor.s1019 + 0)
.s55:
; 196, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2873 : ad e4 9f LDA $9fe4 ; (tile + 0)
2876 : 30 05 __ BMI $287d ; (draw_rule_based_corridor.l30 + 0)
.s1013:
; 196, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2878 : cd ec 9f CMP $9fec ; (i + 0)
287b : f0 62 __ BEQ $28df ; (draw_rule_based_corridor.s54 + 0)
.l30:
; 197, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
287d : ad e4 9f LDA $9fe4 ; (tile + 0)
2880 : 29 80 __ AND #$80
2882 : 10 02 __ BPL $2886 ; (draw_rule_based_corridor.l30 + 9)
2884 : a9 ff __ LDA #$ff
2886 : 30 13 __ BMI $289b ; (draw_rule_based_corridor.s32 + 0)
.s1012:
2888 : d0 08 __ BNE $2892 ; (draw_rule_based_corridor.s33 + 0)
.s1009:
288a : ad e4 9f LDA $9fe4 ; (tile + 0)
288d : cd ec 9f CMP $9fec ; (i + 0)
2890 : 90 09 __ BCC $289b ; (draw_rule_based_corridor.s32 + 0)
.s33:
; 198, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2892 : ad e4 9f LDA $9fe4 ; (tile + 0)
2895 : 18 __ __ CLC
2896 : 69 ff __ ADC #$ff
2898 : 4c a1 28 JMP $28a1 ; (draw_rule_based_corridor.s34 + 0)
.s32:
; 197, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
289b : ad e4 9f LDA $9fe4 ; (tile + 0)
289e : 18 __ __ CLC
289f : 69 01 __ ADC #$01
.s34:
; 198, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
28a1 : 8d e4 9f STA $9fe4 ; (tile + 0)
; 199, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
28a4 : 85 13 __ STA P6 
28a6 : 85 4f __ STA T3 + 0 
28a8 : ad e3 9f LDA $9fe3 ; (y + 0)
28ab : 85 51 __ STA T5 + 0 
28ad : 85 14 __ STA P7 
28af : 20 9a 22 JSR $229a ; (can_place_corridor_tile.s0 + 0)
28b2 : aa __ __ TAX
28b3 : f0 24 __ BEQ $28d9 ; (draw_rule_based_corridor.s29 + 0)
.s35:
; 200, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
28b5 : a5 13 __ LDA P6 
28b7 : 85 10 __ STA P3 
28b9 : a5 51 __ LDA T5 + 0 
28bb : 85 11 __ STA P4 
28bd : a9 02 __ LDA #$02
28bf : 85 12 __ STA P5 
28c1 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
; 201, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
28c4 : ae c8 43 LDX $43c8 ; (corridor_path_static + 40)
28c7 : e0 14 __ CPX #$14
28c9 : b0 0e __ BCS $28d9 ; (draw_rule_based_corridor.s29 + 0)
.s38:
; 202, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
28cb : a5 13 __ LDA P6 
28cd : 9d a0 43 STA $43a0,x ; (corridor_path_static + 0)
; 203, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
28d0 : a5 51 __ LDA T5 + 0 
28d2 : 9d b4 43 STA $43b4,x ; (corridor_path_static + 20)
; 204, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
28d5 : e8 __ __ INX
28d6 : 8e c8 43 STX $43c8 ; (corridor_path_static + 40)
.s29:
; 196, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
28d9 : a5 4f __ LDA T3 + 0 
28db : 30 a0 __ BMI $287d ; (draw_rule_based_corridor.l30 + 0)
28dd : 10 99 __ BPL $2878 ; (draw_rule_based_corridor.s1013 + 0)
.s54:
; 208, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
28df : ad e3 9f LDA $9fe3 ; (y + 0)
28e2 : 30 05 __ BMI $28e9 ; (draw_rule_based_corridor.l42 + 0)
.s1006:
; 208, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
28e4 : cd eb 9f CMP $9feb ; (screen_offset + 1)
28e7 : f0 60 __ BEQ $2949 ; (draw_rule_based_corridor.s43 + 0)
.l42:
; 209, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
28e9 : ad e3 9f LDA $9fe3 ; (y + 0)
28ec : 29 80 __ AND #$80
28ee : 10 02 __ BPL $28f2 ; (draw_rule_based_corridor.l42 + 9)
28f0 : a9 ff __ LDA #$ff
28f2 : 30 13 __ BMI $2907 ; (draw_rule_based_corridor.s44 + 0)
.s1005:
28f4 : d0 08 __ BNE $28fe ; (draw_rule_based_corridor.s45 + 0)
.s1002:
28f6 : ad e3 9f LDA $9fe3 ; (y + 0)
28f9 : cd eb 9f CMP $9feb ; (screen_offset + 1)
28fc : 90 09 __ BCC $2907 ; (draw_rule_based_corridor.s44 + 0)
.s45:
; 210, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
28fe : ad e3 9f LDA $9fe3 ; (y + 0)
2901 : 18 __ __ CLC
2902 : 69 ff __ ADC #$ff
2904 : 4c 0d 29 JMP $290d ; (draw_rule_based_corridor.s46 + 0)
.s44:
; 209, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2907 : ad e3 9f LDA $9fe3 ; (y + 0)
290a : 18 __ __ CLC
290b : 69 01 __ ADC #$01
.s46:
; 210, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
290d : 8d e3 9f STA $9fe3 ; (y + 0)
; 211, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2910 : 85 14 __ STA P7 
2912 : ad e4 9f LDA $9fe4 ; (tile + 0)
2915 : 85 50 __ STA T4 + 0 
2917 : 85 13 __ STA P6 
2919 : 20 9a 22 JSR $229a ; (can_place_corridor_tile.s0 + 0)
291c : aa __ __ TAX
291d : f0 24 __ BEQ $2943 ; (draw_rule_based_corridor.s190 + 0)
.s47:
; 212, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
291f : a5 50 __ LDA T4 + 0 
2921 : 85 10 __ STA P3 
2923 : a5 14 __ LDA P7 
2925 : 85 11 __ STA P4 
2927 : a9 02 __ LDA #$02
2929 : 85 12 __ STA P5 
292b : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
; 213, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
292e : ae c8 43 LDX $43c8 ; (corridor_path_static + 40)
2931 : e0 14 __ CPX #$14
2933 : b0 0e __ BCS $2943 ; (draw_rule_based_corridor.s190 + 0)
.s50:
; 214, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2935 : a5 50 __ LDA T4 + 0 
2937 : 9d a0 43 STA $43a0,x ; (corridor_path_static + 0)
; 215, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
293a : a5 14 __ LDA P7 
293c : 9d b4 43 STA $43b4,x ; (corridor_path_static + 20)
; 216, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
293f : e8 __ __ INX
2940 : 8e c8 43 STX $43c8 ; (corridor_path_static + 40)
.s190:
; 208, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2943 : a5 14 __ LDA P7 
2945 : 30 a2 __ BMI $28e9 ; (draw_rule_based_corridor.l42 + 0)
2947 : 10 9b __ BPL $28e4 ; (draw_rule_based_corridor.s1006 + 0)
.s43:
; 222, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2949 : a9 a0 __ LDA #$a0
294b : 85 15 __ STA P8 
294d : a9 43 __ LDA #$43
294f : 85 16 __ STA P9 
2951 : 20 60 23 JSR $2360 ; (place_doors_along_corridor.s0 + 0)
; 224, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2954 : a9 01 __ LDA #$01
.s1001:
2956 : 60 __ __ RTS
--------------------------------------------------------------------
add_walls: ; add_walls()->void
.s0:
;  23, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2957 : a9 4a __ LDA #$4a
2959 : 85 0d __ STA P0 
295b : a9 2a __ LDA #$2a
295d : 85 0e __ STA P1 
295f : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
;  26, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2962 : a9 00 __ LDA #$00
2964 : 8d ee 9f STA $9fee ; (entropy4 + 1)
.l2:
;  27, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2967 : a9 00 __ LDA #$00
2969 : 8d ef 9f STA $9fef ; (screen_pos + 1)
.l6:
;  28, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
296c : 85 4a __ STA T3 + 0 
296e : 85 0f __ STA P2 
2970 : ad ee 9f LDA $9fee ; (entropy4 + 1)
2973 : 85 4b __ STA T4 + 0 
2975 : 85 10 __ STA P3 
2977 : 20 89 1c JSR $1c89 ; (get_tile_raw.s0 + 0)
297a : a5 1b __ LDA ACCU + 0 
297c : 8d ed 9f STA $9fed ; (highest_priority + 0)
;  31, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
297f : c9 02 __ CMP #$02
2981 : f0 07 __ BEQ $298a ; (add_walls.s9 + 0)
.s12:
2983 : c9 03 __ CMP #$03
2985 : f0 03 __ BEQ $298a ; (add_walls.s9 + 0)
2987 : 4c 1a 2a JMP $2a1a ; (add_walls.s5 + 0)
.s9:
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
298a : a5 4b __ LDA T4 + 0 
298c : 85 48 __ STA T0 + 0 
298e : f0 1e __ BEQ $29ae ; (add_walls.s15 + 0)
.s16:
2990 : aa __ __ TAX
2991 : ca __ __ DEX
2992 : 86 49 __ STX T1 + 0 
2994 : 86 10 __ STX P3 
2996 : 20 89 1c JSR $1c89 ; (get_tile_raw.s0 + 0)
2999 : a5 1b __ LDA ACCU + 0 
299b : d0 0f __ BNE $29ac ; (add_walls.s1002 + 0)
.s13:
;  35, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
299d : a5 0f __ LDA P2 
299f : 85 10 __ STA P3 
29a1 : a5 49 __ LDA T1 + 0 
29a3 : 85 11 __ STA P4 
29a5 : a9 01 __ LDA #$01
29a7 : 85 12 __ STA P5 
29a9 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s1002:
;  39, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
29ac : a5 4b __ LDA T4 + 0 
.s15:
29ae : c9 3f __ CMP #$3f
29b0 : b0 20 __ BCS $29d2 ; (add_walls.s19 + 0)
.s20:
29b2 : a5 4a __ LDA T3 + 0 
29b4 : 85 0f __ STA P2 
29b6 : e6 48 __ INC T0 + 0 
29b8 : a5 48 __ LDA T0 + 0 
29ba : 85 10 __ STA P3 
29bc : 20 89 1c JSR $1c89 ; (get_tile_raw.s0 + 0)
29bf : a5 1b __ LDA ACCU + 0 
29c1 : d0 0f __ BNE $29d2 ; (add_walls.s19 + 0)
.s17:
;  40, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
29c3 : a5 0f __ LDA P2 
29c5 : 85 10 __ STA P3 
29c7 : a5 48 __ LDA T0 + 0 
29c9 : 85 11 __ STA P4 
29cb : a9 01 __ LDA #$01
29cd : 85 12 __ STA P5 
29cf : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s19:
;  44, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
29d2 : a5 4a __ LDA T3 + 0 
29d4 : f0 1f __ BEQ $29f5 ; (add_walls.s23 + 0)
.s24:
29d6 : a6 4b __ LDX T4 + 0 
29d8 : 86 10 __ STX P3 
29da : 38 __ __ SEC
29db : e9 01 __ SBC #$01
29dd : 85 0f __ STA P2 
29df : 20 89 1c JSR $1c89 ; (get_tile_raw.s0 + 0)
29e2 : a5 1b __ LDA ACCU + 0 
29e4 : d0 0f __ BNE $29f5 ; (add_walls.s23 + 0)
.s21:
;  45, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
29e6 : a5 0f __ LDA P2 
29e8 : 85 10 __ STA P3 
29ea : a5 4b __ LDA T4 + 0 
29ec : 85 11 __ STA P4 
29ee : a9 01 __ LDA #$01
29f0 : 85 12 __ STA P5 
29f2 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s23:
;  49, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
29f5 : a6 4a __ LDX T3 + 0 
29f7 : e0 3f __ CPX #$3f
29f9 : b0 1f __ BCS $2a1a ; (add_walls.s5 + 0)
.s28:
29fb : e8 __ __ INX
29fc : 86 48 __ STX T0 + 0 
29fe : 86 0f __ STX P2 
2a00 : a5 4b __ LDA T4 + 0 
2a02 : 85 10 __ STA P3 
2a04 : 20 89 1c JSR $1c89 ; (get_tile_raw.s0 + 0)
2a07 : a5 1b __ LDA ACCU + 0 
2a09 : d0 0f __ BNE $2a1a ; (add_walls.s5 + 0)
.s25:
;  50, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2a0b : a5 48 __ LDA T0 + 0 
2a0d : 85 10 __ STA P3 
2a0f : a5 4b __ LDA T4 + 0 
2a11 : 85 11 __ STA P4 
2a13 : a9 01 __ LDA #$01
2a15 : 85 12 __ STA P5 
2a17 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s5:
;  27, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2a1a : 18 __ __ CLC
2a1b : a5 4a __ LDA T3 + 0 
2a1d : 69 01 __ ADC #$01
2a1f : 8d ef 9f STA $9fef ; (screen_pos + 1)
2a22 : c9 40 __ CMP #$40
2a24 : b0 03 __ BCS $2a29 ; (add_walls.s8 + 0)
2a26 : 4c 6c 29 JMP $296c ; (add_walls.l6 + 0)
.s8:
;  53, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2a29 : a5 4b __ LDA T4 + 0 
2a2b : 29 0f __ AND #$0f
2a2d : d0 0b __ BNE $2a3a ; (add_walls.s1 + 0)
.s29:
2a2f : a9 40 __ LDA #$40
2a31 : 85 0d __ STA P0 
2a33 : a9 17 __ LDA #$17
2a35 : 85 0e __ STA P1 
2a37 : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
.s1:
;  26, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2a3a : 18 __ __ CLC
2a3b : a5 4b __ LDA T4 + 0 
2a3d : 69 01 __ ADC #$01
2a3f : 8d ee 9f STA $9fee ; (entropy4 + 1)
2a42 : c9 40 __ CMP #$40
2a44 : b0 03 __ BCS $2a49 ; (add_walls.s1001 + 0)
2a46 : 4c 67 29 JMP $2967 ; (add_walls.l2 + 0)
.s1001:
;  55, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2a49 : 60 __ __ RTS
--------------------------------------------------------------------
2a4a : __ __ __ BYT 0a 0a 43 52 45 41 54 49 4e 47 20 57 41 4c 4c 53 : ..CREATING WALLS
2a5a : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
add_stairs: ; add_stairs()->void
.s0:
;  64, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2a5b : a9 71 __ LDA #$71
2a5d : 85 0d __ STA P0 
2a5f : a9 2b __ LDA #$2b
2a61 : 85 0e __ STA P1 
2a63 : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
;  66, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2a66 : ad 40 34 LDA $3440 ; (room_count + 0)
2a69 : c9 02 __ CMP #$02
2a6b : b0 01 __ BCS $2a6e ; (add_stairs.s3 + 0)
2a6d : 60 __ __ RTS
.s3:
;  69, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2a6e : 85 4a __ STA T3 + 0 
2a70 : e9 01 __ SBC #$01
2a72 : 8d ee 9f STA $9fee ; (entropy4 + 1)
;  68, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2a75 : a9 00 __ LDA #$00
2a77 : 8d ef 9f STA $9fef ; (screen_pos + 1)
;  71, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2a7a : 8d ed 9f STA $9fed ; (highest_priority + 0)
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2a7d : 8d ec 9f STA $9fec ; (i + 0)
.l6:
;  73, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2a80 : 85 4b __ STA T4 + 0 
2a82 : 29 03 __ AND #$03
2a84 : d0 0b __ BNE $2a91 ; (add_stairs.s11 + 0)
.s9:
2a86 : a9 40 __ LDA #$40
2a88 : 85 0d __ STA P0 
2a8a : a9 17 __ LDA #$17
2a8c : 85 0e __ STA P1 
2a8e : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
.s11:
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2a91 : a6 4b __ LDX T4 + 0 
2a93 : e8 __ __ INX
2a94 : 8e ec 9f STX $9fec ; (i + 0)
;  74, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2a97 : a5 4b __ LDA T4 + 0 
2a99 : 0a __ __ ASL
2a9a : 0a __ __ ASL
2a9b : 0a __ __ ASL
2a9c : a8 __ __ TAY
2a9d : ad ed 9f LDA $9fed ; (highest_priority + 0)
2aa0 : d9 07 43 CMP $4307,y ; (rooms + 7)
2aa3 : b0 0b __ BCS $2ab0 ; (add_stairs.s5 + 0)
.s12:
;  76, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2aa5 : a5 4b __ LDA T4 + 0 
2aa7 : 8d ef 9f STA $9fef ; (screen_pos + 1)
;  75, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2aaa : b9 07 43 LDA $4307,y ; (rooms + 7)
2aad : 8d ed 9f STA $9fed ; (highest_priority + 0)
.s5:
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2ab0 : ad ec 9f LDA $9fec ; (i + 0)
2ab3 : c5 4a __ CMP T3 + 0 
2ab5 : 90 c9 __ BCC $2a80 ; (add_stairs.l6 + 0)
.s8:
;  81, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2ab7 : a9 00 __ LDA #$00
2ab9 : 8d eb 9f STA $9feb ; (screen_offset + 1)
;  82, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2abc : 8d ea 9f STA $9fea ; (i + 0)
.l16:
;  83, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2abf : 85 4b __ STA T4 + 0 
2ac1 : 29 03 __ AND #$03
2ac3 : d0 0b __ BNE $2ad0 ; (add_stairs.s76 + 0)
.s19:
2ac5 : a9 40 __ LDA #$40
2ac7 : 85 0d __ STA P0 
2ac9 : a9 17 __ LDA #$17
2acb : 85 0e __ STA P1 
2acd : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
.s76:
;  84, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2ad0 : a5 4b __ LDA T4 + 0 
2ad2 : cd ef 9f CMP $9fef ; (screen_pos + 1)
2ad5 : f0 19 __ BEQ $2af0 ; (add_stairs.s15 + 0)
.s25:
2ad7 : 0a __ __ ASL
2ad8 : 0a __ __ ASL
2ad9 : 0a __ __ ASL
2ada : a8 __ __ TAY
2adb : ad eb 9f LDA $9feb ; (screen_offset + 1)
2ade : d9 07 43 CMP $4307,y ; (rooms + 7)
2ae1 : b0 0b __ BCS $2aee ; (add_stairs.s1002 + 0)
.s22:
;  86, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2ae3 : a5 4b __ LDA T4 + 0 
2ae5 : 8d ee 9f STA $9fee ; (entropy4 + 1)
;  85, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2ae8 : b9 07 43 LDA $4307,y ; (rooms + 7)
2aeb : 8d eb 9f STA $9feb ; (screen_offset + 1)
.s1002:
;  82, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2aee : a5 4b __ LDA T4 + 0 
.s15:
2af0 : 18 __ __ CLC
2af1 : 69 01 __ ADC #$01
2af3 : 8d ea 9f STA $9fea ; (i + 0)
2af6 : c5 4a __ CMP T3 + 0 
2af8 : 90 c5 __ BCC $2abf ; (add_stairs.l16 + 0)
.s18:
;  90, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2afa : ad ef 9f LDA $9fef ; (screen_pos + 1)
2afd : 85 0d __ STA P0 
2aff : a9 e9 __ LDA #$e9
2b01 : 85 0e __ STA P1 
2b03 : a9 9f __ LDA #$9f
2b05 : 85 11 __ STA P4 
2b07 : a9 9f __ LDA #$9f
2b09 : 85 0f __ STA P2 
2b0b : a9 e8 __ LDA #$e8
2b0d : 85 10 __ STA P3 
2b0f : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
;  91, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2b12 : ad e9 9f LDA $9fe9 ; (up_x + 0)
2b15 : 85 48 __ STA T1 + 0 
2b17 : 85 0d __ STA P0 
2b19 : ad e8 9f LDA $9fe8 ; (up_y + 0)
2b1c : 85 49 __ STA T2 + 0 
2b1e : 85 0e __ STA P1 
2b20 : 20 dd 14 JSR $14dd ; (coords_in_bounds.s0 + 0)
2b23 : aa __ __ TAX
2b24 : f0 0f __ BEQ $2b35 ; (add_stairs.s28 + 0)
.s26:
;  92, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2b26 : a5 48 __ LDA T1 + 0 
2b28 : 85 10 __ STA P3 
2b2a : a5 49 __ LDA T2 + 0 
2b2c : 85 11 __ STA P4 
2b2e : a9 04 __ LDA #$04
2b30 : 85 12 __ STA P5 
2b32 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s28:
;  97, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2b35 : ad ee 9f LDA $9fee ; (entropy4 + 1)
2b38 : 85 0d __ STA P0 
2b3a : a9 e7 __ LDA #$e7
2b3c : 85 0e __ STA P1 
2b3e : a9 9f __ LDA #$9f
2b40 : 85 11 __ STA P4 
2b42 : a9 9f __ LDA #$9f
2b44 : 85 0f __ STA P2 
2b46 : a9 e6 __ LDA #$e6
2b48 : 85 10 __ STA P3 
2b4a : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
;  98, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2b4d : ad e7 9f LDA $9fe7 ; (down_x + 0)
2b50 : 85 48 __ STA T1 + 0 
2b52 : 85 0d __ STA P0 
2b54 : ad e6 9f LDA $9fe6 ; (check_y + 0)
2b57 : 85 49 __ STA T2 + 0 
2b59 : 85 0e __ STA P1 
2b5b : 20 dd 14 JSR $14dd ; (coords_in_bounds.s0 + 0)
2b5e : aa __ __ TAX
2b5f : d0 01 __ BNE $2b62 ; (add_stairs.s29 + 0)
.s1001:
;  66, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2b61 : 60 __ __ RTS
.s29:
;  99, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2b62 : a5 48 __ LDA T1 + 0 
2b64 : 85 10 __ STA P3 
2b66 : a5 49 __ LDA T2 + 0 
2b68 : 85 11 __ STA P4 
2b6a : a9 05 __ LDA #$05
2b6c : 85 12 __ STA P5 
2b6e : 4c 3b 16 JMP $163b ; (set_tile_raw.s0 + 0)
--------------------------------------------------------------------
2b71 : __ __ __ BYT 0a 0a 50 4c 41 43 49 4e 47 20 53 54 41 49 52 53 : ..PLACING STAIRS
2b81 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
krnio_setnam: ; krnio_setnam(const u8*)->void
.s0:
;  34, "E:/Apps/oscar64/include/c64/kernalio.c"
2b82 : a5 0d __ LDA P0 
2b84 : 05 0e __ ORA P1 
2b86 : f0 08 __ BEQ $2b90 ; (krnio_setnam.s0 + 14)
2b88 : a0 ff __ LDY #$ff
2b8a : c8 __ __ INY
2b8b : b1 0d __ LDA (P0),y 
2b8d : d0 fb __ BNE $2b8a ; (krnio_setnam.s0 + 8)
2b8f : 98 __ __ TYA
2b90 : a6 0d __ LDX P0 
2b92 : a4 0e __ LDY P1 
2b94 : 20 bd ff JSR $ffbd 
.s1001:
;  49, "E:/Apps/oscar64/include/c64/kernalio.c"
2b97 : 60 __ __ RTS
--------------------------------------------------------------------
2b98 : __ __ __ BYT 4d 41 50 44 41 54 41 2e 42 49 4e 00             : MAPDATA.BIN.
--------------------------------------------------------------------
krnio_save: ; krnio_save(u8,const u8*,const u8*)->bool
.s0:
; 161, "E:/Apps/oscar64/include/c64/kernalio.c"
2ba4 : a9 00 __ LDA #$00
2ba6 : a6 0d __ LDX P0 
2ba8 : a0 00 __ LDY #$00
2baa : 20 ba ff JSR $ffba 
2bad : a9 0e __ LDA #$0e
2baf : a6 10 __ LDX P3 
2bb1 : a4 11 __ LDY P4 
2bb3 : 20 d8 ff JSR $ffd8 
2bb6 : a9 00 __ LDA #$00
2bb8 : 2a __ __ ROL
2bb9 : 49 01 __ EOR #$01
2bbb : 85 1b __ STA ACCU + 0 
2bbd : a5 1b __ LDA ACCU + 0 
2bbf : f0 02 __ BEQ $2bc3 ; (krnio_save.s1001 + 0)
.s1006:
2bc1 : a9 01 __ LDA #$01
.s1001:
; 158, "E:/Apps/oscar64/include/c64/kernalio.c"
2bc3 : 60 __ __ RTS
--------------------------------------------------------------------
puts: ; puts(const u8*)->void
.l1:
;  17, "E:/Apps/oscar64/include/stdio.c"
2bc4 : a0 00 __ LDY #$00
2bc6 : b1 0f __ LDA (P2),y ; (str + 0)
2bc8 : 8d f8 9f STA $9ff8 ; (room + 1)
2bcb : e6 0f __ INC P2 ; (str + 0)
2bcd : d0 02 __ BNE $2bd1 ; (puts.s1003 + 0)
.s1002:
2bcf : e6 10 __ INC P3 ; (str + 1)
.s1003:
2bd1 : aa __ __ TAX
2bd2 : f0 08 __ BEQ $2bdc ; (puts.s1001 + 0)
.s2:
;  18, "E:/Apps/oscar64/include/stdio.c"
2bd4 : 85 0e __ STA P1 
2bd6 : 20 dd 2b JSR $2bdd ; (putpch.s0 + 0)
2bd9 : 4c c4 2b JMP $2bc4 ; (puts.l1 + 0)
.s1001:
;  19, "E:/Apps/oscar64/include/stdio.c"
2bdc : 60 __ __ RTS
--------------------------------------------------------------------
putpch: ; putpch(u8)->void
.s0:
; 204, "E:/Apps/oscar64/include/conio.c"
2bdd : ad 4f 35 LDA $354f ; (giocharmap + 0)
2be0 : f0 33 __ BEQ $2c15 ; (putpch.s1004 + 0)
.s1:
; 206, "E:/Apps/oscar64/include/conio.c"
2be2 : a5 0e __ LDA P1 ; (c + 0)
2be4 : c9 0a __ CMP #$0a
2be6 : d0 05 __ BNE $2bed ; (putpch.s5 + 0)
.s4:
; 239, "E:/Apps/oscar64/include/conio.c"
2be8 : a9 0d __ LDA #$0d
.s1002:
2bea : 4c 3e 2c JMP $2c3e ; (putrch.s0 + 0)
.s5:
; 208, "E:/Apps/oscar64/include/conio.c"
2bed : c9 09 __ CMP #$09
2bef : f0 30 __ BEQ $2c21 ; (putpch.s7 + 0)
.s8:
; 216, "E:/Apps/oscar64/include/conio.c"
2bf1 : ad 4f 35 LDA $354f ; (giocharmap + 0)
2bf4 : c9 02 __ CMP #$02
2bf6 : 90 1d __ BCC $2c15 ; (putpch.s1004 + 0)
.s13:
; 218, "E:/Apps/oscar64/include/conio.c"
2bf8 : a5 0e __ LDA P1 ; (c + 0)
2bfa : c9 41 __ CMP #$41
2bfc : 90 ec __ BCC $2bea ; (putpch.s1002 + 0)
.s19:
2bfe : c9 7b __ CMP #$7b
2c00 : b0 e8 __ BCS $2bea ; (putpch.s1002 + 0)
.s16:
; 220, "E:/Apps/oscar64/include/conio.c"
2c02 : c9 61 __ CMP #$61
2c04 : b0 04 __ BCS $2c0a ; (putpch.s20 + 0)
.s23:
2c06 : c9 5b __ CMP #$5b
2c08 : b0 e0 __ BCS $2bea ; (putpch.s1002 + 0)
.s20:
; 230, "E:/Apps/oscar64/include/conio.c"
2c0a : 49 20 __ EOR #$20
2c0c : 85 0e __ STA P1 ; (c + 0)
2c0e : ad 4f 35 LDA $354f ; (giocharmap + 0)
2c11 : c9 02 __ CMP #$02
2c13 : f0 05 __ BEQ $2c1a ; (putpch.s24 + 0)
.s1004:
; 239, "E:/Apps/oscar64/include/conio.c"
2c15 : a5 0e __ LDA P1 ; (c + 0)
2c17 : 4c ea 2b JMP $2bea ; (putpch.s1002 + 0)
.s24:
; 240, "E:/Apps/oscar64/include/conio.c"
2c1a : a5 0e __ LDA P1 ; (c + 0)
2c1c : 29 5f __ AND #$5f
2c1e : 4c ea 2b JMP $2bea ; (putpch.s1002 + 0)
.s7:
; 210, "E:/Apps/oscar64/include/conio.c"
2c21 : 20 39 2c JSR $2c39 ; (wherex.s0 + 0)
2c24 : 29 03 __ AND #$03
2c26 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
.l10:
; 212, "E:/Apps/oscar64/include/conio.c"
2c29 : a9 20 __ LDA #$20
2c2b : 20 3e 2c JSR $2c3e ; (putrch.s0 + 0)
; 213, "E:/Apps/oscar64/include/conio.c"
2c2e : ee f9 9f INC $9ff9 ; (bit_offset + 1)
2c31 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
2c34 : c9 04 __ CMP #$04
2c36 : 90 f1 __ BCC $2c29 ; (putpch.l10 + 0)
.s1001:
; 240, "E:/Apps/oscar64/include/conio.c"
2c38 : 60 __ __ RTS
--------------------------------------------------------------------
wherex: ; wherex()->u8
.s0:
; 413, "E:/Apps/oscar64/include/conio.c"
2c39 : a5 d3 __ LDA $d3 
.s1001:
2c3b : a5 d3 __ LDA $d3 
; 413, "E:/Apps/oscar64/include/conio.c"
2c3d : 60 __ __ RTS
--------------------------------------------------------------------
putrch: ; putrch(u8)->void
.s0:
2c3e : 85 0d __ STA P0 
; 193, "E:/Apps/oscar64/include/conio.c"
2c40 : a5 0d __ LDA P0 
2c42 : 20 d2 ff JSR $ffd2 
.s1001:
; 196, "E:/Apps/oscar64/include/conio.c"
2c45 : 60 __ __ RTS
--------------------------------------------------------------------
2c46 : __ __ __ BYT 46 69 6c 65 20 73 61 76 65 20 65 72 72 6f 72 21 : File save error!
2c56 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
render_map_viewport: ; render_map_viewport(u8)->void
.s0:
; 140, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c57 : a5 14 __ LDA P7 ; (force_refresh + 0)
2c59 : d0 21 __ BNE $2c7c ; (render_map_viewport.s1 + 0)
.s3:
; 152, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c5b : ad 74 39 LDA $3974 ; (screen_dirty + 0)
2c5e : f0 1b __ BEQ $2c7b ; (render_map_viewport.s1001 + 0)
.s6:
; 157, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c60 : ad 75 39 LDA $3975 ; (last_scroll_direction + 0)
2c63 : 8d e3 9f STA $9fe3 ; (y + 0)
; 160, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c66 : d0 06 __ BNE $2c6e ; (render_map_viewport.s8 + 0)
.s9:
; 165, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c68 : 20 a7 2f JSR $2fa7 ; (update_full_screen.s0 + 0)
; 171, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c6b : 4c 73 2c JMP $2c73 ; (render_map_viewport.s1006 + 0)
.s8:
; 162, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c6e : 85 13 __ STA P6 
2c70 : 20 af 2c JSR $2caf ; (update_screen_with_perfect_scroll.s0 + 0)
.s1006:
; 170, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c73 : a9 00 __ LDA #$00
2c75 : 8d 75 39 STA $3975 ; (last_scroll_direction + 0)
; 168, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c78 : 8d 74 39 STA $3974 ; (screen_dirty + 0)
.s1001:
; 153, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c7b : 60 __ __ RTS
.s1:
; 142, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c7c : 20 65 0b JSR $0b65 ; (oscar_clrscr.s0 + 0)
; 148, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c7f : a9 00 __ LDA #$00
2c81 : 8d 75 39 STA $3975 ; (last_scroll_direction + 0)
; 147, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c84 : a9 01 __ LDA #$01
2c86 : 8d 74 39 STA $3974 ; (screen_dirty + 0)
; 145, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c89 : a9 20 __ LDA #$20
2c8b : a2 fa __ LDX #$fa
.l1003:
2c8d : ca __ __ DEX
2c8e : 9d 00 04 STA $0400,x 
2c91 : 9d fa 04 STA $04fa,x 
2c94 : 9d f4 05 STA $05f4,x 
2c97 : 9d ee 06 STA $06ee,x 
2c9a : d0 f1 __ BNE $2c8d ; (render_map_viewport.l1003 + 0)
.s1002:
; 146, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c9c : a2 fa __ LDX #$fa
.l1005:
2c9e : ca __ __ DEX
2c9f : 9d 8c 35 STA $358c,x ; (screen_buffer + 0)
2ca2 : 9d 86 36 STA $3686,x ; (screen_buffer + 250)
2ca5 : 9d 80 37 STA $3780,x ; (screen_buffer + 500)
2ca8 : 9d 7a 38 STA $387a,x ; (screen_buffer + 750)
2cab : d0 f1 __ BNE $2c9e ; (render_map_viewport.l1005 + 0)
2cad : f0 b1 __ BEQ $2c60 ; (render_map_viewport.s6 + 0)
--------------------------------------------------------------------
update_screen_with_perfect_scroll: ; update_screen_with_perfect_scroll(u8)->void
.s0:
; 272, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2caf : a5 13 __ LDA P6 ; (scroll_dir + 0)
2cb1 : f0 1c __ BEQ $2ccf ; (update_screen_with_perfect_scroll.s1 + 0)
.s4:
2cb3 : c9 05 __ CMP #$05
2cb5 : b0 18 __ BCS $2ccf ; (update_screen_with_perfect_scroll.s1 + 0)
.s3:
; 278, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2cb7 : c9 03 __ CMP #$03
2cb9 : d0 03 __ BNE $2cbe ; (update_screen_with_perfect_scroll.s28 + 0)
2cbb : 4c f6 2e JMP $2ef6 ; (update_screen_with_perfect_scroll.s17 + 0)
.s28:
2cbe : b0 03 __ BCS $2cc3 ; (update_screen_with_perfect_scroll.s29 + 0)
2cc0 : 4c 7c 2d JMP $2d7c ; (update_screen_with_perfect_scroll.s30 + 0)
.s29:
2cc3 : c9 04 __ CMP #$04
2cc5 : f0 01 __ BEQ $2cc8 ; (update_screen_with_perfect_scroll.s22 + 0)
.s1001:
; 357, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2cc7 : 60 __ __ RTS
.s22:
; 282, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2cc8 : ad 8a 35 LDA $358a ; (view + 0)
2ccb : c9 18 __ CMP #$18
2ccd : 90 03 __ BCC $2cd2 ; (update_screen_with_perfect_scroll.s70 + 0)
.s1:
; 273, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ccf : 4c a7 2f JMP $2fa7 ; (update_full_screen.s0 + 0)
.s70:
; 343, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2cd2 : 85 51 __ STA T6 + 0 
2cd4 : a9 27 __ LDA #$27
2cd6 : 85 11 __ STA P4 
2cd8 : a9 00 __ LDA #$00
2cda : 85 12 __ STA P5 
2cdc : 8d e8 9f STA $9fe8 ; (up_y + 0)
.l72:
; 344, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2cdf : 85 52 __ STA T7 + 0 
2ce1 : 0a __ __ ASL
2ce2 : 85 1b __ STA ACCU + 0 
2ce4 : a9 00 __ LDA #$00
2ce6 : 8d e9 9f STA $9fe9 ; (up_x + 0)
2ce9 : 2a __ __ ROL
2cea : 06 1b __ ASL ACCU + 0 
2cec : 2a __ __ ROL
2ced : aa __ __ TAX
2cee : a5 1b __ LDA ACCU + 0 
2cf0 : 65 52 __ ADC T7 + 0 
2cf2 : 85 4f __ STA T3 + 0 
2cf4 : 8a __ __ TXA
2cf5 : 69 00 __ ADC #$00
2cf7 : 06 4f __ ASL T3 + 0 
2cf9 : 2a __ __ ROL
2cfa : 06 4f __ ASL T3 + 0 
2cfc : 2a __ __ ROL
2cfd : 06 4f __ ASL T3 + 0 
2cff : 2a __ __ ROL
2d00 : 85 50 __ STA T3 + 1 
2d02 : 18 __ __ CLC
2d03 : 69 04 __ ADC #$04
2d05 : 85 4c __ STA T1 + 1 
2d07 : a6 4f __ LDX T3 + 0 
2d09 : 86 4b __ STX T1 + 0 
2d0b : 18 __ __ CLC
.l1014:
; 345, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d0c : ac e9 9f LDY $9fe9 ; (up_x + 0)
2d0f : c8 __ __ INY
2d10 : b1 4b __ LDA (T1 + 0),y 
2d12 : 88 __ __ DEY
2d13 : 91 4b __ STA (T1 + 0),y 
; 344, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d15 : 98 __ __ TYA
2d16 : 69 01 __ ADC #$01
2d18 : 8d e9 9f STA $9fe9 ; (up_x + 0)
2d1b : c9 27 __ CMP #$27
2d1d : 90 ed __ BCC $2d0c ; (update_screen_with_perfect_scroll.l1014 + 0)
.s78:
; 348, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d1f : 18 __ __ CLC
2d20 : a9 8c __ LDA #$8c
2d22 : 65 4f __ ADC T3 + 0 
2d24 : 85 4b __ STA T1 + 0 
2d26 : 85 0d __ STA P0 
2d28 : a9 35 __ LDA #$35
2d2a : 65 50 __ ADC T3 + 1 
2d2c : 85 4c __ STA T1 + 1 
2d2e : 85 0e __ STA P1 
2d30 : 8a __ __ TXA
2d31 : 18 __ __ CLC
2d32 : 69 8d __ ADC #$8d
2d34 : 85 0f __ STA P2 
2d36 : a5 50 __ LDA T3 + 1 
2d38 : 69 35 __ ADC #$35
2d3a : 85 10 __ STA P3 
2d3c : 20 e1 30 JSR $30e1 ; (memmove.s0 + 0)
; 351, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d3f : 38 __ __ SEC
2d40 : a5 51 __ LDA T6 + 0 
2d42 : e9 d9 __ SBC #$d9
2d44 : 85 0d __ STA P0 
2d46 : ad 8b 35 LDA $358b ; (view + 1)
2d49 : 18 __ __ CLC
2d4a : 65 52 __ ADC T7 + 0 
2d4c : 85 0e __ STA P1 
2d4e : 20 11 30 JSR $3011 ; (get_map_tile_fast.s0 + 0)
2d51 : 8d e4 9f STA $9fe4 ; (tile + 0)
; 352, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d54 : 18 __ __ CLC
2d55 : a9 27 __ LDA #$27
2d57 : 65 4f __ ADC T3 + 0 
2d59 : 85 43 __ STA T0 + 0 
2d5b : a9 04 __ LDA #$04
2d5d : 65 50 __ ADC T3 + 1 
2d5f : 85 44 __ STA T0 + 1 
2d61 : ad e4 9f LDA $9fe4 ; (tile + 0)
2d64 : a0 00 __ LDY #$00
2d66 : 91 43 __ STA (T0 + 0),y 
; 353, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d68 : a0 27 __ LDY #$27
2d6a : 91 4b __ STA (T1 + 0),y 
; 343, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d6c : 18 __ __ CLC
2d6d : a5 52 __ LDA T7 + 0 
2d6f : 69 01 __ ADC #$01
2d71 : 8d e8 9f STA $9fe8 ; (up_y + 0)
2d74 : c9 19 __ CMP #$19
2d76 : b0 03 __ BCS $2d7b ; (update_screen_with_perfect_scroll.s78 + 92)
2d78 : 4c df 2c JMP $2cdf ; (update_screen_with_perfect_scroll.l72 + 0)
2d7b : 60 __ __ RTS
.s30:
; 278, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d7c : c9 01 __ CMP #$01
2d7e : f0 03 __ BEQ $2d83 ; (update_screen_with_perfect_scroll.s7 + 0)
2d80 : 4c 33 2e JMP $2e33 ; (update_screen_with_perfect_scroll.s31 + 0)
.s7:
; 279, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d83 : ad 8b 35 LDA $358b ; (view + 1)
2d86 : d0 03 __ BNE $2d8b ; (update_screen_with_perfect_scroll.s35 + 0)
2d88 : 4c cf 2c JMP $2ccf ; (update_screen_with_perfect_scroll.s1 + 0)
.s35:
; 289, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d8b : 85 51 __ STA T6 + 0 
2d8d : a9 00 __ LDA #$00
2d8f : 85 12 __ STA P5 
2d91 : a9 28 __ LDA #$28
2d93 : 85 11 __ STA P4 
2d95 : a9 18 __ LDA #$18
2d97 : 8d e8 9f STA $9fe8 ; (up_y + 0)
.l37:
; 291, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d9a : 85 52 __ STA T7 + 0 
2d9c : 0a __ __ ASL
2d9d : 85 1b __ STA ACCU + 0 
2d9f : a9 00 __ LDA #$00
2da1 : 8d e9 9f STA $9fe9 ; (up_x + 0)
; 292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2da4 : 2a __ __ ROL
2da5 : 06 1b __ ASL ACCU + 0 
2da7 : 2a __ __ ROL
2da8 : aa __ __ TAX
2da9 : a5 1b __ LDA ACCU + 0 
2dab : 65 52 __ ADC T7 + 0 
2dad : 85 43 __ STA T0 + 0 
2daf : 8a __ __ TXA
2db0 : 69 00 __ ADC #$00
2db2 : 06 43 __ ASL T0 + 0 
2db4 : 2a __ __ ROL
2db5 : 06 43 __ ASL T0 + 0 
2db7 : 2a __ __ ROL
2db8 : 06 43 __ ASL T0 + 0 
2dba : 2a __ __ ROL
2dbb : 85 44 __ STA T0 + 1 
2dbd : 18 __ __ CLC
2dbe : 69 04 __ ADC #$04
2dc0 : 85 4e __ STA T2 + 1 
2dc2 : 18 __ __ CLC
2dc3 : a9 d8 __ LDA #$d8
2dc5 : 65 43 __ ADC T0 + 0 
2dc7 : 85 4b __ STA T1 + 0 
2dc9 : a9 03 __ LDA #$03
2dcb : 65 44 __ ADC T0 + 1 
2dcd : 85 4c __ STA T1 + 1 
2dcf : a5 43 __ LDA T0 + 0 
2dd1 : 85 4d __ STA T2 + 0 
.l41:
2dd3 : ac e9 9f LDY $9fe9 ; (up_x + 0)
2dd6 : b1 4b __ LDA (T1 + 0),y 
2dd8 : 91 4d __ STA (T2 + 0),y 
; 291, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2dda : c8 __ __ INY
2ddb : 8c e9 9f STY $9fe9 ; (up_x + 0)
2dde : c0 28 __ CPY #$28
2de0 : 90 f1 __ BCC $2dd3 ; (update_screen_with_perfect_scroll.l41 + 0)
.s43:
; 295, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2de2 : 18 __ __ CLC
2de3 : a9 8c __ LDA #$8c
2de5 : 65 43 __ ADC T0 + 0 
2de7 : 85 0d __ STA P0 
2de9 : a9 35 __ LDA #$35
2deb : 65 44 __ ADC T0 + 1 
2ded : 85 0e __ STA P1 
2def : 18 __ __ CLC
2df0 : a9 64 __ LDA #$64
2df2 : 65 43 __ ADC T0 + 0 
2df4 : 85 0f __ STA P2 
2df6 : a9 35 __ LDA #$35
2df8 : 65 44 __ ADC T0 + 1 
2dfa : 85 10 __ STA P3 
2dfc : 20 e1 30 JSR $30e1 ; (memmove.s0 + 0)
; 289, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2dff : 18 __ __ CLC
2e00 : a5 52 __ LDA T7 + 0 
2e02 : 69 ff __ ADC #$ff
2e04 : 8d e8 9f STA $9fe8 ; (up_y + 0)
2e07 : c9 01 __ CMP #$01
2e09 : b0 8f __ BCS $2d9a ; (update_screen_with_perfect_scroll.l37 + 0)
.s39:
; 299, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e0b : 8d e9 9f STA $9fe9 ; (up_x + 0)
; 300, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e0e : a5 51 __ LDA T6 + 0 
2e10 : 85 0e __ STA P1 
.l1010:
2e12 : ad e9 9f LDA $9fe9 ; (up_x + 0)
2e15 : 85 4f __ STA T3 + 0 
2e17 : 6d 8a 35 ADC $358a ; (view + 0)
2e1a : 85 0d __ STA P0 
2e1c : 20 11 30 JSR $3011 ; (get_map_tile_fast.s0 + 0)
2e1f : 8d e7 9f STA $9fe7 ; (down_x + 0)
; 301, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e22 : a6 4f __ LDX T3 + 0 
2e24 : 9d 00 04 STA $0400,x 
; 302, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e27 : 9d 8c 35 STA $358c,x ; (screen_buffer + 0)
; 299, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e2a : e8 __ __ INX
2e2b : 8e e9 9f STX $9fe9 ; (up_x + 0)
2e2e : e0 28 __ CPX #$28
2e30 : 90 e0 __ BCC $2e12 ; (update_screen_with_perfect_scroll.l1010 + 0)
2e32 : 60 __ __ RTS
.s31:
; 278, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e33 : c9 02 __ CMP #$02
2e35 : f0 01 __ BEQ $2e38 ; (update_screen_with_perfect_scroll.s12 + 0)
2e37 : 60 __ __ RTS
.s12:
; 280, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e38 : ad 8b 35 LDA $358b ; (view + 1)
2e3b : c9 27 __ CMP #$27
2e3d : 90 03 __ BCC $2e42 ; (update_screen_with_perfect_scroll.s83 + 0)
2e3f : 4c cf 2c JMP $2ccf ; (update_screen_with_perfect_scroll.s1 + 0)
.s83:
; 307, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e42 : 85 51 __ STA T6 + 0 
2e44 : a9 28 __ LDA #$28
2e46 : 85 11 __ STA P4 
2e48 : a9 00 __ LDA #$00
2e4a : 85 12 __ STA P5 
2e4c : 8d e8 9f STA $9fe8 ; (up_y + 0)
.l50:
; 309, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e4f : 85 52 __ STA T7 + 0 
2e51 : 0a __ __ ASL
2e52 : 85 1b __ STA ACCU + 0 
2e54 : a9 00 __ LDA #$00
2e56 : 8d e9 9f STA $9fe9 ; (up_x + 0)
; 310, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e59 : 2a __ __ ROL
2e5a : 06 1b __ ASL ACCU + 0 
2e5c : 2a __ __ ROL
2e5d : aa __ __ TAX
2e5e : a5 1b __ LDA ACCU + 0 
2e60 : 65 52 __ ADC T7 + 0 
2e62 : 85 43 __ STA T0 + 0 
2e64 : 8a __ __ TXA
2e65 : 69 00 __ ADC #$00
2e67 : 06 43 __ ASL T0 + 0 
2e69 : 2a __ __ ROL
2e6a : 06 43 __ ASL T0 + 0 
2e6c : 2a __ __ ROL
2e6d : 06 43 __ ASL T0 + 0 
2e6f : 2a __ __ ROL
2e70 : 85 44 __ STA T0 + 1 
2e72 : 18 __ __ CLC
2e73 : 69 04 __ ADC #$04
2e75 : 85 4c __ STA T1 + 1 
2e77 : a5 43 __ LDA T0 + 0 
2e79 : 85 4b __ STA T1 + 0 
2e7b : 18 __ __ CLC
2e7c : 69 28 __ ADC #$28
2e7e : 85 4d __ STA T2 + 0 
2e80 : a5 44 __ LDA T0 + 1 
2e82 : 69 04 __ ADC #$04
2e84 : 85 4e __ STA T2 + 1 
.l54:
2e86 : ac e9 9f LDY $9fe9 ; (up_x + 0)
2e89 : b1 4d __ LDA (T2 + 0),y 
2e8b : 91 4b __ STA (T1 + 0),y 
; 309, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e8d : c8 __ __ INY
2e8e : 8c e9 9f STY $9fe9 ; (up_x + 0)
2e91 : c0 28 __ CPY #$28
2e93 : 90 f1 __ BCC $2e86 ; (update_screen_with_perfect_scroll.l54 + 0)
.s56:
; 313, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e95 : 18 __ __ CLC
2e96 : a9 8c __ LDA #$8c
2e98 : 65 43 __ ADC T0 + 0 
2e9a : 85 0d __ STA P0 
2e9c : a9 35 __ LDA #$35
2e9e : 65 44 __ ADC T0 + 1 
2ea0 : 85 0e __ STA P1 
2ea2 : 18 __ __ CLC
2ea3 : a5 43 __ LDA T0 + 0 
2ea5 : 69 b4 __ ADC #$b4
2ea7 : 85 0f __ STA P2 
2ea9 : a5 44 __ LDA T0 + 1 
2eab : 69 35 __ ADC #$35
2ead : 85 10 __ STA P3 
2eaf : 20 e1 30 JSR $30e1 ; (memmove.s0 + 0)
; 307, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2eb2 : 18 __ __ CLC
2eb3 : a5 52 __ LDA T7 + 0 
2eb5 : 69 01 __ ADC #$01
2eb7 : 8d e8 9f STA $9fe8 ; (up_y + 0)
2eba : c9 18 __ CMP #$18
2ebc : 90 91 __ BCC $2e4f ; (update_screen_with_perfect_scroll.l50 + 0)
.s52:
; 317, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ebe : a9 c0 __ LDA #$c0
2ec0 : 8d ea 9f STA $9fea ; (i + 0)
2ec3 : a9 03 __ LDA #$03
2ec5 : 8d eb 9f STA $9feb ; (screen_offset + 1)
; 318, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ec8 : a9 00 __ LDA #$00
2eca : 8d e9 9f STA $9fe9 ; (up_x + 0)
; 319, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ecd : 18 __ __ CLC
.l1012:
2ece : ad e9 9f LDA $9fe9 ; (up_x + 0)
2ed1 : 85 4f __ STA T3 + 0 
2ed3 : 6d 8a 35 ADC $358a ; (view + 0)
2ed6 : 85 0d __ STA P0 
2ed8 : 38 __ __ SEC
2ed9 : a5 51 __ LDA T6 + 0 
2edb : e9 e8 __ SBC #$e8
2edd : 85 0e __ STA P1 
2edf : 20 11 30 JSR $3011 ; (get_map_tile_fast.s0 + 0)
2ee2 : 8d e6 9f STA $9fe6 ; (check_y + 0)
; 320, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ee5 : a6 4f __ LDX T3 + 0 
2ee7 : 9d c0 07 STA $07c0,x 
; 321, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2eea : 9d 4c 39 STA $394c,x ; (screen_buffer + 960)
; 318, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2eed : e8 __ __ INX
2eee : 8e e9 9f STX $9fe9 ; (up_x + 0)
2ef1 : e0 28 __ CPX #$28
2ef3 : 90 d9 __ BCC $2ece ; (update_screen_with_perfect_scroll.l1012 + 0)
2ef5 : 60 __ __ RTS
.s17:
; 281, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ef6 : ad 8a 35 LDA $358a ; (view + 0)
2ef9 : d0 03 __ BNE $2efe ; (update_screen_with_perfect_scroll.s61 + 0)
2efb : 4c cf 2c JMP $2ccf ; (update_screen_with_perfect_scroll.s1 + 0)
.s61:
; 327, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2efe : 85 51 __ STA T6 + 0 
2f00 : a9 00 __ LDA #$00
2f02 : 8d e8 9f STA $9fe8 ; (up_y + 0)
; 332, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2f05 : 85 12 __ STA P5 
2f07 : a9 27 __ LDA #$27
2f09 : 85 11 __ STA P4 
.l63:
; 328, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2f0b : ad e8 9f LDA $9fe8 ; (up_y + 0)
2f0e : 85 52 __ STA T7 + 0 
2f10 : 85 4d __ STA T2 + 0 
2f12 : 0a __ __ ASL
2f13 : 85 1b __ STA ACCU + 0 
2f15 : a9 27 __ LDA #$27
2f17 : 8d e9 9f STA $9fe9 ; (up_x + 0)
; 329, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2f1a : a9 00 __ LDA #$00
2f1c : 2a __ __ ROL
2f1d : 06 1b __ ASL ACCU + 0 
2f1f : 2a __ __ ROL
2f20 : aa __ __ TAX
2f21 : a5 1b __ LDA ACCU + 0 
2f23 : 65 4d __ ADC T2 + 0 
2f25 : 85 4f __ STA T3 + 0 
2f27 : 8a __ __ TXA
2f28 : 69 00 __ ADC #$00
2f2a : 06 4f __ ASL T3 + 0 
2f2c : 2a __ __ ROL
2f2d : 06 4f __ ASL T3 + 0 
2f2f : 2a __ __ ROL
2f30 : 06 4f __ ASL T3 + 0 
2f32 : 2a __ __ ROL
2f33 : 85 50 __ STA T3 + 1 
2f35 : 18 __ __ CLC
2f36 : a9 ff __ LDA #$ff
2f38 : 65 4f __ ADC T3 + 0 
2f3a : 85 43 __ STA T0 + 0 
2f3c : a9 03 __ LDA #$03
2f3e : 65 50 __ ADC T3 + 1 
2f40 : 85 44 __ STA T0 + 1 
.l67:
2f42 : ac e9 9f LDY $9fe9 ; (up_x + 0)
2f45 : b1 43 __ LDA (T0 + 0),y 
2f47 : c8 __ __ INY
2f48 : 91 43 __ STA (T0 + 0),y 
; 328, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2f4a : 98 __ __ TYA
2f4b : 18 __ __ CLC
2f4c : 69 fe __ ADC #$fe
2f4e : 8d e9 9f STA $9fe9 ; (up_x + 0)
2f51 : c9 01 __ CMP #$01
2f53 : b0 ed __ BCS $2f42 ; (update_screen_with_perfect_scroll.l67 + 0)
.s69:
; 332, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2f55 : a9 8c __ LDA #$8c
2f57 : 65 4f __ ADC T3 + 0 
2f59 : 85 0f __ STA P2 
2f5b : a9 35 __ LDA #$35
2f5d : 65 50 __ ADC T3 + 1 
2f5f : 85 10 __ STA P3 
2f61 : 18 __ __ CLC
2f62 : a5 4f __ LDA T3 + 0 
2f64 : 69 8d __ ADC #$8d
2f66 : 85 0d __ STA P0 
2f68 : a5 50 __ LDA T3 + 1 
2f6a : 69 35 __ ADC #$35
2f6c : 85 0e __ STA P1 
2f6e : 20 e1 30 JSR $30e1 ; (memmove.s0 + 0)
; 335, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2f71 : a5 51 __ LDA T6 + 0 
2f73 : 85 0d __ STA P0 
2f75 : ad 8b 35 LDA $358b ; (view + 1)
2f78 : 18 __ __ CLC
2f79 : 65 4d __ ADC T2 + 0 
2f7b : 85 0e __ STA P1 
2f7d : 20 11 30 JSR $3011 ; (get_map_tile_fast.s0 + 0)
2f80 : 8d e5 9f STA $9fe5 ; (x + 0)
; 336, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2f83 : a5 4f __ LDA T3 + 0 
2f85 : 85 43 __ STA T0 + 0 
2f87 : 18 __ __ CLC
2f88 : a9 04 __ LDA #$04
2f8a : 65 50 __ ADC T3 + 1 
2f8c : 85 44 __ STA T0 + 1 
2f8e : ad e5 9f LDA $9fe5 ; (x + 0)
2f91 : a0 00 __ LDY #$00
2f93 : 91 43 __ STA (T0 + 0),y 
; 337, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2f95 : 91 0f __ STA (P2),y 
; 327, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2f97 : 18 __ __ CLC
2f98 : a5 52 __ LDA T7 + 0 
2f9a : 69 01 __ ADC #$01
2f9c : 8d e8 9f STA $9fe8 ; (up_y + 0)
2f9f : c9 19 __ CMP #$19
2fa1 : b0 03 __ BCS $2fa6 ; (update_screen_with_perfect_scroll.s69 + 81)
2fa3 : 4c 0b 2f JMP $2f0b ; (update_screen_with_perfect_scroll.l63 + 0)
2fa6 : 60 __ __ RTS
--------------------------------------------------------------------
update_full_screen: ; update_full_screen()->void
.s0:
; 361, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2fa7 : a9 00 __ LDA #$00
2fa9 : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
.l2:
; 364, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2fac : 85 49 __ STA T6 + 0 
2fae : 0a __ __ ASL
2faf : 0a __ __ ASL
2fb0 : 65 49 __ ADC T6 + 0 
2fb2 : 0a __ __ ASL
2fb3 : 0a __ __ ASL
2fb4 : 85 43 __ STA T0 + 0 
2fb6 : a9 00 __ LDA #$00
2fb8 : 8d ed 9f STA $9fed ; (highest_priority + 0)
; 362, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2fbb : 2a __ __ ROL
2fbc : 06 43 __ ASL T0 + 0 
2fbe : 2a __ __ ROL
2fbf : 8d ef 9f STA $9fef ; (screen_pos + 1)
2fc2 : a5 43 __ LDA T0 + 0 
2fc4 : 85 47 __ STA T3 + 0 
2fc6 : 8d ee 9f STA $9fee ; (entropy4 + 1)
; 365, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2fc9 : a9 04 __ LDA #$04
2fcb : 6d ef 9f ADC $9fef ; (screen_pos + 1)
2fce : 85 48 __ STA T3 + 1 
2fd0 : 18 __ __ CLC
2fd1 : a9 8c __ LDA #$8c
2fd3 : 65 43 __ ADC T0 + 0 
2fd5 : 85 45 __ STA T2 + 0 
2fd7 : a9 35 __ LDA #$35
2fd9 : 6d ef 9f ADC $9fef ; (screen_pos + 1)
2fdc : 85 46 __ STA T2 + 1 
2fde : 18 __ __ CLC
.l1002:
2fdf : ad ed 9f LDA $9fed ; (highest_priority + 0)
2fe2 : 85 4a __ STA T7 + 0 
2fe4 : 6d 8a 35 ADC $358a ; (view + 0)
2fe7 : 85 0d __ STA P0 
2fe9 : ad 8b 35 LDA $358b ; (view + 1)
2fec : 18 __ __ CLC
2fed : 65 49 __ ADC T6 + 0 
2fef : 85 0e __ STA P1 
2ff1 : 20 11 30 JSR $3011 ; (get_map_tile_fast.s0 + 0)
2ff4 : 8d ec 9f STA $9fec ; (i + 0)
; 369, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ff7 : a4 4a __ LDY T7 + 0 
2ff9 : 91 47 __ STA (T3 + 0),y 
; 370, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ffb : 91 45 __ STA (T2 + 0),y 
; 364, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ffd : c8 __ __ INY
2ffe : 8c ed 9f STY $9fed ; (highest_priority + 0)
3001 : c0 28 __ CPY #$28
3003 : 90 da __ BCC $2fdf ; (update_full_screen.l1002 + 0)
.s3:
; 361, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3005 : a5 49 __ LDA T6 + 0 
3007 : 69 00 __ ADC #$00
3009 : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
300c : c9 19 __ CMP #$19
300e : 90 9c __ BCC $2fac ; (update_full_screen.l2 + 0)
.s1001:
; 373, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3010 : 60 __ __ RTS
--------------------------------------------------------------------
get_map_tile_fast: ; get_map_tile_fast(u8,u8)->u8
.s0:
; 105, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3011 : a5 0d __ LDA P0 ; (map_x + 0)
3013 : c9 40 __ CMP #$40
3015 : b0 06 __ BCS $301d ; (get_map_tile_fast.s1 + 0)
.s4:
3017 : a5 0e __ LDA P1 ; (map_y + 0)
3019 : c9 40 __ CMP #$40
301b : 90 03 __ BCC $3020 ; (get_map_tile_fast.s3 + 0)
.s1:
; 106, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
301d : a9 20 __ LDA #$20
.s1001:
301f : 60 __ __ RTS
.s3:
; 117, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3020 : 85 1c __ STA ACCU + 1 
3022 : 4a __ __ LSR
3023 : aa __ __ TAX
3024 : a9 00 __ LDA #$00
3026 : 6a __ __ ROR
3027 : 85 43 __ STA T1 + 0 
3029 : a9 00 __ LDA #$00
302b : 46 1c __ LSR ACCU + 1 
302d : 6a __ __ ROR
302e : 66 1c __ ROR ACCU + 1 
3030 : 6a __ __ ROR
3031 : 65 43 __ ADC T1 + 0 
3033 : a8 __ __ TAY
3034 : 8a __ __ TXA
3035 : 65 1c __ ADC ACCU + 1 
3037 : aa __ __ TAX
3038 : 98 __ __ TYA
3039 : 18 __ __ CLC
303a : 65 0d __ ADC P0 ; (map_x + 0)
303c : 90 01 __ BCC $303f ; (get_map_tile_fast.s1014 + 0)
.s1013:
; 110, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
303e : e8 __ __ INX
.s1014:
303f : 18 __ __ CLC
3040 : 65 0d __ ADC P0 ; (map_x + 0)
3042 : 90 01 __ BCC $3045 ; (get_map_tile_fast.s1016 + 0)
.s1015:
; 110, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3044 : e8 __ __ INX
.s1016:
3045 : 18 __ __ CLC
3046 : 65 0d __ ADC P0 ; (map_x + 0)
3048 : 8d f8 9f STA $9ff8 ; (room + 1)
304b : 8a __ __ TXA
304c : 69 00 __ ADC #$00
304e : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 111, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3051 : 4a __ __ LSR
3052 : 85 44 __ STA T1 + 1 
3054 : ad f8 9f LDA $9ff8 ; (room + 1)
3057 : 6a __ __ ROR
3058 : 46 44 __ LSR T1 + 1 
305a : 6a __ __ ROR
305b : 46 44 __ LSR T1 + 1 
305d : 6a __ __ ROR
305e : 18 __ __ CLC
305f : 69 76 __ ADC #$76
3061 : 85 43 __ STA T1 + 0 
3063 : 8d f6 9f STA $9ff6 ; (room_center_y + 0)
3066 : a9 39 __ LDA #$39
3068 : 65 44 __ ADC T1 + 1 
306a : 85 44 __ STA T1 + 1 
306c : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
; 112, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
306f : ad f8 9f LDA $9ff8 ; (room + 1)
3072 : 29 07 __ AND #$07
3074 : 85 1b __ STA ACCU + 0 
3076 : 8d f5 9f STA $9ff5 ; (s + 1)
; 117, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3079 : aa __ __ TAX
307a : a0 00 __ LDY #$00
307c : b1 43 __ LDA (T1 + 0),y 
307e : e0 00 __ CPX #$00
3080 : f0 04 __ BEQ $3086 ; (get_map_tile_fast.s1003 + 0)
.l1002:
; 117, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3082 : 4a __ __ LSR
3083 : ca __ __ DEX
3084 : d0 fc __ BNE $3082 ; (get_map_tile_fast.l1002 + 0)
.s1003:
; 115, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3086 : 85 1c __ STA ACCU + 1 
3088 : a5 1b __ LDA ACCU + 0 
308a : c9 06 __ CMP #$06
308c : a5 1c __ LDA ACCU + 1 
308e : 90 23 __ BCC $30b3 ; (get_map_tile_fast.s30 + 0)
.s7:
; 121, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3090 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
; 120, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3093 : a9 08 __ LDA #$08
3095 : e5 1b __ SBC ACCU + 0 
3097 : 8d f3 9f STA $9ff3 ; (grid_y + 0)
; 122, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
309a : aa __ __ TAX
309b : bd 74 35 LDA $3574,x ; (bitshift + 36)
309e : 38 __ __ SEC
309f : e9 01 __ SBC #$01
30a1 : a0 01 __ LDY #$01
30a3 : 31 43 __ AND (T1 + 0),y 
30a5 : ae f3 9f LDX $9ff3 ; (grid_y + 0)
30a8 : f0 04 __ BEQ $30ae ; (get_map_tile_fast.s1005 + 0)
.l1006:
30aa : 0a __ __ ASL
30ab : ca __ __ DEX
30ac : d0 fc __ BNE $30aa ; (get_map_tile_fast.l1006 + 0)
.s1005:
; 122, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30ae : 8d f1 9f STA $9ff1 ; (cell_h + 0)
; 123, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30b1 : 05 1c __ ORA ACCU + 1 
.s30:
30b3 : 29 07 __ AND #$07
30b5 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30b8 : c9 03 __ CMP #$03
30ba : d0 03 __ BNE $30bf ; (get_map_tile_fast.s19 + 0)
.s13:
; 130, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30bc : a9 2b __ LDA #$2b
30be : 60 __ __ RTS
.s19:
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30bf : 90 11 __ BCC $30d2 ; (get_map_tile_fast.s21 + 0)
.s20:
30c1 : c9 04 __ CMP #$04
30c3 : d0 03 __ BNE $30c8 ; (get_map_tile_fast.s25 + 0)
.s14:
; 131, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30c5 : a9 3c __ LDA #$3c
30c7 : 60 __ __ RTS
.s25:
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30c8 : c9 05 __ CMP #$05
30ca : f0 03 __ BEQ $30cf ; (get_map_tile_fast.s15 + 0)
30cc : 4c 1d 30 JMP $301d ; (get_map_tile_fast.s1 + 0)
.s15:
; 132, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30cf : a9 3e __ LDA #$3e
30d1 : 60 __ __ RTS
.s21:
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30d2 : c9 01 __ CMP #$01
30d4 : d0 03 __ BNE $30d9 ; (get_map_tile_fast.s22 + 0)
.s11:
; 128, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30d6 : a9 23 __ LDA #$23
30d8 : 60 __ __ RTS
.s22:
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30d9 : 8a __ __ TXA
30da : 69 ff __ ADC #$ff
30dc : 29 0e __ AND #$0e
30de : 49 2e __ EOR #$2e
30e0 : 60 __ __ RTS
--------------------------------------------------------------------
memmove: ; memmove(void*,const void*,i16)->void*
.s0:
; 237, "E:/Apps/oscar64/include/string.c"
30e1 : a5 11 __ LDA P4 ; (size + 0)
30e3 : 8d f8 9f STA $9ff8 ; (room + 1)
30e6 : a6 0e __ LDX P1 ; (dst + 1)
30e8 : a5 12 __ LDA P5 ; (size + 1)
30ea : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 238, "E:/Apps/oscar64/include/string.c"
30ed : 10 03 __ BPL $30f2 ; (memmove.s1006 + 0)
30ef : 4c 8d 31 JMP $318d ; (memmove.s3 + 0)
.s1006:
30f2 : 05 11 __ ORA P4 ; (size + 0)
30f4 : f0 f9 __ BEQ $30ef ; (memmove.s0 + 14)
.s1:
; 240, "E:/Apps/oscar64/include/string.c"
30f6 : 8e f7 9f STX $9ff7 ; (byte_ptr + 1)
30f9 : a5 0d __ LDA P0 ; (dst + 0)
30fb : 8d f6 9f STA $9ff6 ; (room_center_y + 0)
; 241, "E:/Apps/oscar64/include/string.c"
30fe : a5 0f __ LDA P2 ; (src + 0)
3100 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
3103 : a5 10 __ LDA P3 ; (src + 1)
3105 : 8d f5 9f STA $9ff5 ; (s + 1)
; 242, "E:/Apps/oscar64/include/string.c"
3108 : e4 10 __ CPX P3 ; (src + 1)
310a : d0 05 __ BNE $3111 ; (memmove.s1005 + 0)
.s1004:
310c : a5 0d __ LDA P0 ; (dst + 0)
310e : cd f4 9f CMP $9ff4 ; (entropy1 + 1)
.s1005:
3111 : b0 04 __ BCS $3117 ; (memmove.s5 + 0)
.s7:
; 246, "E:/Apps/oscar64/include/string.c"
3113 : a0 00 __ LDY #$00
3115 : 90 7d __ BCC $3194 ; (memmove.l1007 + 0)
.s5:
; 248, "E:/Apps/oscar64/include/string.c"
3117 : ad f5 9f LDA $9ff5 ; (s + 1)
311a : cd f7 9f CMP $9ff7 ; (byte_ptr + 1)
311d : d0 06 __ BNE $3125 ; (memmove.s1003 + 0)
.s1002:
311f : ad f4 9f LDA $9ff4 ; (entropy1 + 1)
3122 : cd f6 9f CMP $9ff6 ; (room_center_y + 0)
.s1003:
3125 : b0 66 __ BCS $318d ; (memmove.s3 + 0)
.s9:
; 251, "E:/Apps/oscar64/include/string.c"
3127 : ad f4 9f LDA $9ff4 ; (entropy1 + 1)
312a : 18 __ __ CLC
312b : 65 11 __ ADC P4 ; (size + 0)
312d : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
3130 : ad f5 9f LDA $9ff5 ; (s + 1)
3133 : 6d f9 9f ADC $9ff9 ; (bit_offset + 1)
3136 : 8d f5 9f STA $9ff5 ; (s + 1)
; 250, "E:/Apps/oscar64/include/string.c"
3139 : ad f6 9f LDA $9ff6 ; (room_center_y + 0)
313c : 18 __ __ CLC
313d : 65 11 __ ADC P4 ; (size + 0)
313f : 8d f6 9f STA $9ff6 ; (room_center_y + 0)
3142 : ad f7 9f LDA $9ff7 ; (byte_ptr + 1)
3145 : 6d f9 9f ADC $9ff9 ; (bit_offset + 1)
3148 : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
; 253, "E:/Apps/oscar64/include/string.c"
314b : a0 00 __ LDY #$00
.l1009:
314d : ad f4 9f LDA $9ff4 ; (entropy1 + 1)
3150 : 18 __ __ CLC
3151 : 69 ff __ ADC #$ff
3153 : 85 1b __ STA ACCU + 0 
3155 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
3158 : ad f5 9f LDA $9ff5 ; (s + 1)
315b : 69 ff __ ADC #$ff
315d : 85 1c __ STA ACCU + 1 
315f : 8d f5 9f STA $9ff5 ; (s + 1)
3162 : ad f6 9f LDA $9ff6 ; (room_center_y + 0)
3165 : 18 __ __ CLC
3166 : 69 ff __ ADC #$ff
3168 : 85 43 __ STA T1 + 0 
316a : 8d f6 9f STA $9ff6 ; (room_center_y + 0)
316d : ad f7 9f LDA $9ff7 ; (byte_ptr + 1)
3170 : 69 ff __ ADC #$ff
3172 : 85 44 __ STA T1 + 1 
3174 : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
3177 : b1 1b __ LDA (ACCU + 0),y 
3179 : 91 43 __ STA (T1 + 0),y 
; 254, "E:/Apps/oscar64/include/string.c"
317b : ad f8 9f LDA $9ff8 ; (room + 1)
317e : d0 03 __ BNE $3183 ; (memmove.s1017 + 0)
.s1016:
; 254, "E:/Apps/oscar64/include/string.c"
3180 : ce f9 9f DEC $9ff9 ; (bit_offset + 1)
.s1017:
3183 : ce f8 9f DEC $9ff8 ; (room + 1)
3186 : d0 c5 __ BNE $314d ; (memmove.l1009 + 0)
.s1018:
; 254, "E:/Apps/oscar64/include/string.c"
3188 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
318b : d0 c0 __ BNE $314d ; (memmove.l1009 + 0)
.s3:
; 257, "E:/Apps/oscar64/include/string.c"
318d : 86 1c __ STX ACCU + 1 
318f : a5 0d __ LDA P0 ; (dst + 0)
3191 : 85 1b __ STA ACCU + 0 
.s1001:
3193 : 60 __ __ RTS
.l1007:
; 245, "E:/Apps/oscar64/include/string.c"
3194 : ad f4 9f LDA $9ff4 ; (entropy1 + 1)
3197 : 85 1b __ STA ACCU + 0 
3199 : 18 __ __ CLC
319a : 69 01 __ ADC #$01
319c : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
319f : ad f5 9f LDA $9ff5 ; (s + 1)
31a2 : 85 1c __ STA ACCU + 1 
31a4 : 69 00 __ ADC #$00
31a6 : 8d f5 9f STA $9ff5 ; (s + 1)
31a9 : ad f6 9f LDA $9ff6 ; (room_center_y + 0)
31ac : 85 43 __ STA T1 + 0 
31ae : ad f7 9f LDA $9ff7 ; (byte_ptr + 1)
31b1 : 85 44 __ STA T1 + 1 
31b3 : b1 1b __ LDA (ACCU + 0),y 
31b5 : 91 43 __ STA (T1 + 0),y 
31b7 : 18 __ __ CLC
31b8 : a5 43 __ LDA T1 + 0 
31ba : 69 01 __ ADC #$01
31bc : 8d f6 9f STA $9ff6 ; (room_center_y + 0)
31bf : a5 44 __ LDA T1 + 1 
31c1 : 69 00 __ ADC #$00
31c3 : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
; 246, "E:/Apps/oscar64/include/string.c"
31c6 : ad f8 9f LDA $9ff8 ; (room + 1)
31c9 : d0 03 __ BNE $31ce ; (memmove.s1014 + 0)
.s1013:
; 246, "E:/Apps/oscar64/include/string.c"
31cb : ce f9 9f DEC $9ff9 ; (bit_offset + 1)
.s1014:
31ce : ce f8 9f DEC $9ff8 ; (room + 1)
31d1 : d0 c1 __ BNE $3194 ; (memmove.l1007 + 0)
.s1015:
; 246, "E:/Apps/oscar64/include/string.c"
31d3 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
31d6 : d0 bc __ BNE $3194 ; (memmove.l1007 + 0)
31d8 : f0 b3 __ BEQ $318d ; (memmove.s3 + 0)
--------------------------------------------------------------------
getch: ; getch()->u8
.l1:
; 320, "E:/Apps/oscar64/include/conio.c"
31da : 20 e4 ff JSR $ffe4 
31dd : 85 1b __ STA ACCU + 0 
31df : a5 1b __ LDA ACCU + 0 
; 319, "E:/Apps/oscar64/include/conio.c"
31e1 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 323, "E:/Apps/oscar64/include/conio.c"
31e4 : f0 f4 __ BEQ $31da ; (getch.l1 + 0)
.s2:
; 325, "E:/Apps/oscar64/include/conio.c"
31e6 : 4c e9 31 JMP $31e9 ; (convch.s0 + 0)
--------------------------------------------------------------------
convch: ; convch(u8)->u8
.s0:
31e9 : a8 __ __ TAY
; 246, "E:/Apps/oscar64/include/conio.c"
31ea : ad 4f 35 LDA $354f ; (giocharmap + 0)
31ed : f0 27 __ BEQ $3216 ; (convch.s3 + 0)
.s1:
; 248, "E:/Apps/oscar64/include/conio.c"
31ef : c0 0d __ CPY #$0d
31f1 : d0 03 __ BNE $31f6 ; (convch.s5 + 0)
.s4:
; 263, "E:/Apps/oscar64/include/conio.c"
31f3 : a9 0a __ LDA #$0a
.s1001:
31f5 : 60 __ __ RTS
.s5:
; 250, "E:/Apps/oscar64/include/conio.c"
31f6 : c9 02 __ CMP #$02
31f8 : 90 1c __ BCC $3216 ; (convch.s3 + 0)
.s7:
; 252, "E:/Apps/oscar64/include/conio.c"
31fa : 98 __ __ TYA
31fb : c0 41 __ CPY #$41
31fd : 90 17 __ BCC $3216 ; (convch.s3 + 0)
.s13:
31ff : c9 db __ CMP #$db
3201 : b0 13 __ BCS $3216 ; (convch.s3 + 0)
.s10:
; 254, "E:/Apps/oscar64/include/conio.c"
3203 : c9 c1 __ CMP #$c1
3205 : 90 03 __ BCC $320a ; (convch.s16 + 0)
.s14:
; 255, "E:/Apps/oscar64/include/conio.c"
3207 : 49 a0 __ EOR #$a0
3209 : a8 __ __ TAY
.s16:
; 256, "E:/Apps/oscar64/include/conio.c"
320a : c9 7b __ CMP #$7b
320c : b0 08 __ BCS $3216 ; (convch.s3 + 0)
.s20:
320e : c9 61 __ CMP #$61
3210 : b0 06 __ BCS $3218 ; (convch.s17 + 0)
.s21:
3212 : c9 5b __ CMP #$5b
3214 : 90 02 __ BCC $3218 ; (convch.s17 + 0)
.s3:
; 263, "E:/Apps/oscar64/include/conio.c"
3216 : 98 __ __ TYA
3217 : 60 __ __ RTS
.s17:
; 257, "E:/Apps/oscar64/include/conio.c"
3218 : 49 20 __ EOR #$20
321a : 60 __ __ RTS
--------------------------------------------------------------------
process_navigation_input: ; process_navigation_input(u8)->void
.s0:
; 179, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
321b : ad 8a 35 LDA $358a ; (view + 0)
321e : 85 44 __ STA T3 + 0 
3220 : 8d f5 9f STA $9ff5 ; (s + 1)
; 183, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3223 : a9 00 __ LDA #$00
3225 : 8d f1 9f STA $9ff1 ; (cell_h + 0)
; 180, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3228 : ad 8b 35 LDA $358b ; (view + 1)
322b : 85 45 __ STA T4 + 0 
322d : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
; 181, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3230 : ad 88 35 LDA $3588 ; (camera_center_x + 0)
3233 : 85 43 __ STA T2 + 0 
3235 : 8d f3 9f STA $9ff3 ; (grid_y + 0)
; 182, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3238 : ad 89 35 LDA $3589 ; (camera_center_y + 0)
323b : 85 46 __ STA T5 + 0 
323d : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
; 186, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3240 : a5 0d __ LDA P0 ; (key + 0)
3242 : c9 61 __ CMP #$61
3244 : d0 03 __ BNE $3249 ; (process_navigation_input.s19 + 0)
3246 : 4c 12 33 JMP $3312 ; (process_navigation_input.s10 + 0)
.s19:
3249 : b0 03 __ BCS $324e ; (process_navigation_input.s20 + 0)
324b : 4c 00 33 JMP $3300 ; (process_navigation_input.s21 + 0)
.s20:
324e : c9 73 __ CMP #$73
3250 : d0 03 __ BNE $3255 ; (process_navigation_input.s28 + 0)
3252 : 4c f5 32 JMP $32f5 ; (process_navigation_input.s6 + 0)
.s28:
3255 : b0 03 __ BCS $325a ; (process_navigation_input.s29 + 0)
3257 : 4c e3 32 JMP $32e3 ; (process_navigation_input.s30 + 0)
.s29:
325a : c9 77 __ CMP #$77
325c : d0 41 __ BNE $329f ; (process_navigation_input.s1001 + 0)
.s2:
; 189, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
325e : a5 46 __ LDA T5 + 0 
3260 : f0 3d __ BEQ $329f ; (process_navigation_input.s1001 + 0)
.s3:
; 190, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3262 : 69 fe __ ADC #$fe
.s70:
; 198, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3264 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
.s33:
; 207, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3267 : a9 01 __ LDA #$01
3269 : 8d f1 9f STA $9ff1 ; (cell_h + 0)
; 222, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
326c : a5 43 __ LDA T2 + 0 
326e : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
; 223, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3271 : a5 46 __ LDA T5 + 0 
3273 : 8d ef 9f STA $9fef ; (screen_pos + 1)
; 225, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3276 : ad f3 9f LDA $9ff3 ; (grid_y + 0)
3279 : 8d 88 35 STA $3588 ; (camera_center_x + 0)
; 226, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
327c : ad f2 9f LDA $9ff2 ; (entropy2 + 1)
327f : 8d 89 35 STA $3589 ; (camera_center_y + 0)
; 227, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3282 : 20 fe 17 JSR $17fe ; (update_camera.s0 + 0)
; 231, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3285 : a5 44 __ LDA T3 + 0 
3287 : cd 8a 35 CMP $358a ; (view + 0)
328a : d0 07 __ BNE $3293 ; (process_navigation_input.s36 + 0)
.s39:
328c : a5 45 __ LDA T4 + 0 
328e : cd 8b 35 CMP $358b ; (view + 1)
3291 : f0 32 __ BEQ $32c5 ; (process_navigation_input.s37 + 0)
.s36:
; 233, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3293 : ad 8b 35 LDA $358b ; (view + 1)
3296 : c5 45 __ CMP T4 + 0 
3298 : b0 06 __ BCS $32a0 ; (process_navigation_input.s41 + 0)
.s40:
; 234, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
329a : a9 01 __ LDA #$01
.s1002:
329c : 8d 75 39 STA $3975 ; (last_scroll_direction + 0)
.s1001:
; 260, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
329f : 60 __ __ RTS
.s41:
; 235, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
32a0 : a5 45 __ LDA T4 + 0 
32a2 : cd 8b 35 CMP $358b ; (view + 1)
32a5 : b0 04 __ BCS $32ab ; (process_navigation_input.s44 + 0)
.s43:
; 236, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
32a7 : a9 02 __ LDA #$02
32a9 : 90 f1 __ BCC $329c ; (process_navigation_input.s1002 + 0)
.s44:
; 237, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
32ab : ad 8a 35 LDA $358a ; (view + 0)
32ae : c5 44 __ CMP T3 + 0 
32b0 : b0 04 __ BCS $32b6 ; (process_navigation_input.s47 + 0)
.s46:
; 238, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
32b2 : a9 03 __ LDA #$03
32b4 : 90 e6 __ BCC $329c ; (process_navigation_input.s1002 + 0)
.s47:
; 239, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
32b6 : a5 44 __ LDA T3 + 0 
32b8 : cd 8a 35 CMP $358a ; (view + 0)
32bb : b0 04 __ BCS $32c1 ; (process_navigation_input.s50 + 0)
.s49:
; 240, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
32bd : a9 04 __ LDA #$04
32bf : 90 db __ BCC $329c ; (process_navigation_input.s1002 + 0)
.s50:
; 242, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
32c1 : a9 00 __ LDA #$00
32c3 : b0 d7 __ BCS $329c ; (process_navigation_input.s1002 + 0)
.s37:
; 247, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
32c5 : ad 89 35 LDA $3589 ; (camera_center_y + 0)
32c8 : c5 46 __ CMP T5 + 0 
32ca : 90 ce __ BCC $329a ; (process_navigation_input.s40 + 0)
.s53:
; 249, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
32cc : a5 46 __ LDA T5 + 0 
32ce : cd 89 35 CMP $3589 ; (camera_center_y + 0)
32d1 : 90 d4 __ BCC $32a7 ; (process_navigation_input.s43 + 0)
.s56:
; 251, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
32d3 : ad 88 35 LDA $3588 ; (camera_center_x + 0)
32d6 : c5 43 __ CMP T2 + 0 
32d8 : 90 d8 __ BCC $32b2 ; (process_navigation_input.s46 + 0)
.s59:
; 253, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
32da : a5 43 __ LDA T2 + 0 
32dc : cd 88 35 CMP $3588 ; (camera_center_x + 0)
32df : b0 e0 __ BCS $32c1 ; (process_navigation_input.s50 + 0)
32e1 : 90 da __ BCC $32bd ; (process_navigation_input.s49 + 0)
.s30:
; 186, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
32e3 : c9 64 __ CMP #$64
32e5 : d0 b8 __ BNE $329f ; (process_navigation_input.s1001 + 0)
.s14:
; 213, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
32e7 : a5 43 __ LDA T2 + 0 
32e9 : c9 3f __ CMP #$3f
32eb : b0 b2 __ BCS $329f ; (process_navigation_input.s1001 + 0)
.s15:
; 214, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
32ed : 69 01 __ ADC #$01
.s71:
32ef : 8d f3 9f STA $9ff3 ; (grid_y + 0)
32f2 : 4c 67 32 JMP $3267 ; (process_navigation_input.s33 + 0)
.s6:
; 197, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
32f5 : a5 46 __ LDA T5 + 0 
32f7 : c9 3f __ CMP #$3f
32f9 : b0 a4 __ BCS $329f ; (process_navigation_input.s1001 + 0)
.s7:
; 198, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
32fb : 69 01 __ ADC #$01
32fd : 4c 64 32 JMP $3264 ; (process_navigation_input.s70 + 0)
.s21:
; 186, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3300 : c9 53 __ CMP #$53
3302 : f0 f1 __ BEQ $32f5 ; (process_navigation_input.s6 + 0)
.s22:
3304 : 90 08 __ BCC $330e ; (process_navigation_input.s24 + 0)
.s23:
3306 : c9 57 __ CMP #$57
3308 : d0 03 __ BNE $330d ; (process_navigation_input.s23 + 7)
330a : 4c 5e 32 JMP $325e ; (process_navigation_input.s2 + 0)
330d : 60 __ __ RTS
.s24:
330e : c9 41 __ CMP #$41
3310 : d0 09 __ BNE $331b ; (process_navigation_input.s25 + 0)
.s10:
; 205, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3312 : a5 43 __ LDA T2 + 0 
3314 : f0 89 __ BEQ $329f ; (process_navigation_input.s1001 + 0)
.s11:
; 206, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3316 : 69 fe __ ADC #$fe
3318 : 4c ef 32 JMP $32ef ; (process_navigation_input.s71 + 0)
.s25:
; 186, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
331b : c9 44 __ CMP #$44
331d : f0 c8 __ BEQ $32e7 ; (process_navigation_input.s14 + 0)
331f : 60 __ __ RTS
--------------------------------------------------------------------
mul16by8: ; mul16by8
3320 : 4a __ __ LSR
3321 : f0 2e __ BEQ $3351 ; (mul16by8 + 49)
3323 : a2 00 __ LDX #$00
3325 : a0 00 __ LDY #$00
3327 : 90 13 __ BCC $333c ; (mul16by8 + 28)
3329 : a4 1b __ LDY ACCU + 0 
332b : a6 1c __ LDX ACCU + 1 
332d : b0 0d __ BCS $333c ; (mul16by8 + 28)
332f : 85 02 __ STA $02 
3331 : 18 __ __ CLC
3332 : 98 __ __ TYA
3333 : 65 1b __ ADC ACCU + 0 
3335 : a8 __ __ TAY
3336 : 8a __ __ TXA
3337 : 65 1c __ ADC ACCU + 1 
3339 : aa __ __ TAX
333a : a5 02 __ LDA $02 
333c : 06 1b __ ASL ACCU + 0 
333e : 26 1c __ ROL ACCU + 1 
3340 : 4a __ __ LSR
3341 : 90 f9 __ BCC $333c ; (mul16by8 + 28)
3343 : d0 ea __ BNE $332f ; (mul16by8 + 15)
3345 : 18 __ __ CLC
3346 : 98 __ __ TYA
3347 : 65 1b __ ADC ACCU + 0 
3349 : 85 1b __ STA ACCU + 0 
334b : 8a __ __ TXA
334c : 65 1c __ ADC ACCU + 1 
334e : 85 1c __ STA ACCU + 1 
3350 : 60 __ __ RTS
3351 : b0 04 __ BCS $3357 ; (mul16by8 + 55)
3353 : 85 1b __ STA ACCU + 0 
3355 : 85 1c __ STA ACCU + 1 
3357 : 60 __ __ RTS
--------------------------------------------------------------------
mul16: ; mul16
3358 : a0 00 __ LDY #$00
335a : 84 06 __ STY WORK + 3 
335c : a5 03 __ LDA WORK + 0 
335e : a6 04 __ LDX WORK + 1 
3360 : f0 1c __ BEQ $337e ; (mul16 + 38)
3362 : 38 __ __ SEC
3363 : 6a __ __ ROR
3364 : 90 0d __ BCC $3373 ; (mul16 + 27)
3366 : aa __ __ TAX
3367 : 18 __ __ CLC
3368 : 98 __ __ TYA
3369 : 65 1b __ ADC ACCU + 0 
336b : a8 __ __ TAY
336c : a5 06 __ LDA WORK + 3 
336e : 65 1c __ ADC ACCU + 1 
3370 : 85 06 __ STA WORK + 3 
3372 : 8a __ __ TXA
3373 : 06 1b __ ASL ACCU + 0 
3375 : 26 1c __ ROL ACCU + 1 
3377 : 4a __ __ LSR
3378 : 90 f9 __ BCC $3373 ; (mul16 + 27)
337a : d0 ea __ BNE $3366 ; (mul16 + 14)
337c : a5 04 __ LDA WORK + 1 
337e : 4a __ __ LSR
337f : 90 0d __ BCC $338e ; (mul16 + 54)
3381 : aa __ __ TAX
3382 : 18 __ __ CLC
3383 : 98 __ __ TYA
3384 : 65 1b __ ADC ACCU + 0 
3386 : a8 __ __ TAY
3387 : a5 06 __ LDA WORK + 3 
3389 : 65 1c __ ADC ACCU + 1 
338b : 85 06 __ STA WORK + 3 
338d : 8a __ __ TXA
338e : 06 1b __ ASL ACCU + 0 
3390 : 26 1c __ ROL ACCU + 1 
3392 : 4a __ __ LSR
3393 : b0 ec __ BCS $3381 ; (mul16 + 41)
3395 : d0 f7 __ BNE $338e ; (mul16 + 54)
3397 : 84 05 __ STY WORK + 2 
3399 : 60 __ __ RTS
--------------------------------------------------------------------
divmod: ; divmod
339a : a5 1c __ LDA ACCU + 1 
339c : d0 31 __ BNE $33cf ; (divmod + 53)
339e : a5 04 __ LDA WORK + 1 
33a0 : d0 1e __ BNE $33c0 ; (divmod + 38)
33a2 : 85 06 __ STA WORK + 3 
33a4 : a2 04 __ LDX #$04
33a6 : 06 1b __ ASL ACCU + 0 
33a8 : 2a __ __ ROL
33a9 : c5 03 __ CMP WORK + 0 
33ab : 90 02 __ BCC $33af ; (divmod + 21)
33ad : e5 03 __ SBC WORK + 0 
33af : 26 1b __ ROL ACCU + 0 
33b1 : 2a __ __ ROL
33b2 : c5 03 __ CMP WORK + 0 
33b4 : 90 02 __ BCC $33b8 ; (divmod + 30)
33b6 : e5 03 __ SBC WORK + 0 
33b8 : 26 1b __ ROL ACCU + 0 
33ba : ca __ __ DEX
33bb : d0 eb __ BNE $33a8 ; (divmod + 14)
33bd : 85 05 __ STA WORK + 2 
33bf : 60 __ __ RTS
33c0 : a5 1b __ LDA ACCU + 0 
33c2 : 85 05 __ STA WORK + 2 
33c4 : a5 1c __ LDA ACCU + 1 
33c6 : 85 06 __ STA WORK + 3 
33c8 : a9 00 __ LDA #$00
33ca : 85 1b __ STA ACCU + 0 
33cc : 85 1c __ STA ACCU + 1 
33ce : 60 __ __ RTS
33cf : a5 04 __ LDA WORK + 1 
33d1 : d0 1f __ BNE $33f2 ; (divmod + 88)
33d3 : a5 03 __ LDA WORK + 0 
33d5 : 30 1b __ BMI $33f2 ; (divmod + 88)
33d7 : a9 00 __ LDA #$00
33d9 : 85 06 __ STA WORK + 3 
33db : a2 10 __ LDX #$10
33dd : 06 1b __ ASL ACCU + 0 
33df : 26 1c __ ROL ACCU + 1 
33e1 : 2a __ __ ROL
33e2 : c5 03 __ CMP WORK + 0 
33e4 : 90 02 __ BCC $33e8 ; (divmod + 78)
33e6 : e5 03 __ SBC WORK + 0 
33e8 : 26 1b __ ROL ACCU + 0 
33ea : 26 1c __ ROL ACCU + 1 
33ec : ca __ __ DEX
33ed : d0 f2 __ BNE $33e1 ; (divmod + 71)
33ef : 85 05 __ STA WORK + 2 
33f1 : 60 __ __ RTS
33f2 : a9 00 __ LDA #$00
33f4 : 85 05 __ STA WORK + 2 
33f6 : 85 06 __ STA WORK + 3 
33f8 : 84 02 __ STY $02 
33fa : a0 10 __ LDY #$10
33fc : 18 __ __ CLC
33fd : 26 1b __ ROL ACCU + 0 
33ff : 26 1c __ ROL ACCU + 1 
3401 : 26 05 __ ROL WORK + 2 
3403 : 26 06 __ ROL WORK + 3 
3405 : 38 __ __ SEC
3406 : a5 05 __ LDA WORK + 2 
3408 : e5 03 __ SBC WORK + 0 
340a : aa __ __ TAX
340b : a5 06 __ LDA WORK + 3 
340d : e5 04 __ SBC WORK + 1 
340f : 90 04 __ BCC $3415 ; (divmod + 123)
3411 : 86 05 __ STX WORK + 2 
3413 : 85 06 __ STA WORK + 3 
3415 : 88 __ __ DEY
3416 : d0 e5 __ BNE $33fd ; (divmod + 99)
3418 : 26 1b __ ROL ACCU + 0 
341a : 26 1c __ ROL ACCU + 1 
341c : a4 02 __ LDY $02 
341e : 60 __ __ RTS
--------------------------------------------------------------------
__multab7982L:
341f : __ __ __ BYT 00 2e 5c 8a b8 e6 14 42 70                      : ..\....Bp
--------------------------------------------------------------------
__multab7982H:
3428 : __ __ __ BYT 00 1f 3e 5d 7c 9b bb da f9                      : ..>]|....
--------------------------------------------------------------------
__multab14L:
3431 : __ __ __ BYT 00 0e 1c 2a                                     : ...*
--------------------------------------------------------------------
__shltab7L:
3435 : __ __ __ BYT 07 0e 1c 38 70 e0                               : ...8p.
--------------------------------------------------------------------
spentry:
343b : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
generation_counter:
343c : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
rng_seed:
343e : __ __ __ BYT 01 00                                           : ..
--------------------------------------------------------------------
room_count:
3440 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
room_center_cache_valid:
3441 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
corridor_pool:
3442 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3452 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3462 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3472 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3482 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3492 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
34a2 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
34b2 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
34c2 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
34d2 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
34e2 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
34f2 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3502 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
connection_cache:
3504 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3514 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3524 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3534 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3544 : __ __ __ BYT 00 00 00 00 00 00 00 00 00                      : .........
--------------------------------------------------------------------
distance_cache_valid:
354d : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
corridor_endpoint_override:
354e : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
giocharmap:
354f : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
bitshift:
3550 : __ __ __ BYT 00 00 00 00 00 00 00 00 01 02 04 08 10 20 40 80 : ............. @.
3560 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3570 : __ __ __ BYT 80 40 20 10 08 04 02 01 00 00 00 00 00 00 00 00 : .@ .............
3580 : __ __ __ BYT 00 00 00 00 00 00 00 00                         : ........
--------------------------------------------------------------------
camera_center_x:
3588 : __ __ __ BSS	1
--------------------------------------------------------------------
camera_center_y:
3589 : __ __ __ BSS	1
--------------------------------------------------------------------
view:
358a : __ __ __ BSS	2
--------------------------------------------------------------------
screen_buffer:
358c : __ __ __ BSS	1000
--------------------------------------------------------------------
screen_dirty:
3974 : __ __ __ BSS	1
--------------------------------------------------------------------
last_scroll_direction:
3975 : __ __ __ BSS	1
--------------------------------------------------------------------
compact_map:
3976 : __ __ __ BSS	1536
--------------------------------------------------------------------
connection_matrix:
3f76 : __ __ __ BSS	400
--------------------------------------------------------------------
room_distance_cache:
4106 : __ __ __ BSS	400
--------------------------------------------------------------------
room_center_cache:
4296 : __ __ __ BSS	40
--------------------------------------------------------------------
visited_global:
42be : __ __ __ BSS	20
--------------------------------------------------------------------
stack_global:
42d2 : __ __ __ BSS	20
--------------------------------------------------------------------
rooms:
4300 : __ __ __ BSS	160
--------------------------------------------------------------------
corridor_path_static:
43a0 : __ __ __ BSS	41
