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
080e : 8e 1d 32 STX $321d ; (spentry + 0)
0811 : a2 33 __ LDX #$33
0813 : a0 6a __ LDY #$6a
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
083b : a9 62 __ LDA #$62
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
0889 : a9 7a __ LDA #$7a
088b : 85 0d __ STA P0 
088d : a9 29 __ LDA #$29
088f : 85 0e __ STA P1 
0891 : 20 64 29 JSR $2964 ; (krnio_setnam.s0 + 0)
;  42, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
0894 : a9 08 __ LDA #$08
0896 : 85 0d __ STA P0 
0898 : a9 3d __ LDA #$3d
089a : 85 11 __ STA P4 
089c : a9 58 __ LDA #$58
089e : 85 0e __ STA P1 
08a0 : a9 37 __ LDA #$37
08a2 : 85 0f __ STA P2 
08a4 : a9 58 __ LDA #$58
08a6 : 85 10 __ STA P3 
08a8 : 20 86 29 JSR $2986 ; (krnio_save.s0 + 0)
08ab : aa __ __ TAX
08ac : d0 0b __ BNE $08b9 ; (main.l19 + 0)
.s45:
;  65, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08ae : a9 28 __ LDA #$28
08b0 : 85 0f __ STA P2 
08b2 : a9 2a __ LDA #$2a
08b4 : 85 10 __ STA P3 
08b6 : 20 a6 29 JSR $29a6 ; (puts.l1 + 0)
.l19:
;  47, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08b9 : a9 01 __ LDA #$01
08bb : d0 07 __ BNE $08c4 ; (main.l6 + 0)
.s13:
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08bd : 85 0d __ STA P0 
08bf : 20 fd 2f JSR $2ffd ; (process_navigation_input.s0 + 0)
;  73, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08c2 : a9 00 __ LDA #$00
.l6:
;  47, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08c4 : 85 14 __ STA P7 
08c6 : 20 39 2a JSR $2a39 ; (render_map_viewport.s0 + 0)
;  51, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08c9 : 20 bc 2f JSR $2fbc ; (getch.l1 + 0)
08cc : 8d 64 9f STA $9f64 ; (key + 0)
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
08dd : a9 7a __ LDA #$7a
08df : 85 0d __ STA P0 
08e1 : a9 29 __ LDA #$29
08e3 : 85 0e __ STA P1 
08e5 : 20 64 29 JSR $2964 ; (krnio_setnam.s0 + 0)
;  63, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08e8 : a9 08 __ LDA #$08
08ea : 85 0d __ STA P0 
08ec : a9 3d __ LDA #$3d
08ee : 85 11 __ STA P4 
08f0 : a9 58 __ LDA #$58
08f2 : 85 0e __ STA P1 
08f4 : a9 37 __ LDA #$37
08f6 : 85 0f __ STA P2 
08f8 : a9 58 __ LDA #$58
08fa : 85 10 __ STA P3 
08fc : 20 86 29 JSR $2986 ; (krnio_save.s0 + 0)
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
0918 : 8d f3 9f STA $9ff3 ; (i + 0)
091b : a5 1c __ LDA ACCU + 1 
091d : 85 49 __ STA T3 + 1 
091f : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
;  67, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0922 : 20 5e 0a JSR $0a5e ; (get_hardware_entropy.s0 + 0)
0925 : a5 1b __ LDA ACCU + 0 
0927 : 85 4a __ STA T4 + 0 
0929 : 8d f1 9f STA $9ff1 ; (entropy2 + 0)
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
0949 : 8d ed 9f STA $9fed ; (exit2_x + 0)
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
094c : a9 00 __ LDA #$00
094e : 8d 1f 32 STA $321f ; (generation_counter + 1)
;  84, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0951 : 8d ec 9f STA $9fec ; (exit2_y + 0)
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0954 : a9 01 __ LDA #$01
0956 : 8d 1e 32 STA $321e ; (generation_counter + 0)
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
;  76, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
0996 : 8d 21 32 STA $3221 ; (rng_seed + 1)
0999 : 98 __ __ TYA
099a : 45 1b __ EOR ACCU + 0 
099c : 49 80 __ EOR #$80
099e : 8d 20 32 STA $3220 ; (rng_seed + 0)
;  77, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
09a1 : 0a __ __ ASL
09a2 : 85 44 __ STA T1 + 0 
09a4 : ad 21 32 LDA $3221 ; (rng_seed + 1)
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
09b5 : ad 21 32 LDA $3221 ; (rng_seed + 1)
09b8 : 4a __ __ LSR
09b9 : 4a __ __ LSR
09ba : 4a __ __ LSR
09bb : 45 44 __ EOR T1 + 0 
09bd : 49 1d __ EOR #$1d
09bf : 8d 20 32 STA $3220 ; (rng_seed + 0)
09c2 : 8a __ __ TXA
09c3 : 49 ac __ EOR #$ac
09c5 : 8d 21 32 STA $3221 ; (rng_seed + 1)
;  80, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
09c8 : ad 20 32 LDA $3220 ; (rng_seed + 0)
09cb : 49 37 __ EOR #$37
09cd : 8d 20 32 STA $3220 ; (rng_seed + 0)
09d0 : ad 21 32 LDA $3221 ; (rng_seed + 1)
09d3 : 49 9e __ EOR #$9e
09d5 : 8d 21 32 STA $3221 ; (rng_seed + 1)
;  81, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
09ed : 20 3a 31 JSR $313a ; (mul16 + 0)
09f0 : a5 05 __ LDA WORK + 2 
09f2 : 4d 20 32 EOR $3220 ; (rng_seed + 0)
09f5 : 8d 20 32 STA $3220 ; (rng_seed + 0)
09f8 : a5 06 __ LDA WORK + 3 
09fa : 4d 21 32 EOR $3221 ; (rng_seed + 1)
09fd : 8d 21 32 STA $3221 ; (rng_seed + 1)
.l2:
;  85, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a00 : ad 20 32 LDA $3220 ; (rng_seed + 0)
0a03 : 0a __ __ ASL
0a04 : 85 44 __ STA T1 + 0 
0a06 : ad 21 32 LDA $3221 ; (rng_seed + 1)
0a09 : 2a __ __ ROL
0a0a : 06 44 __ ASL T1 + 0 
0a0c : 2a __ __ ROL
0a0d : 06 44 __ ASL T1 + 0 
0a0f : 2a __ __ ROL
0a10 : 85 45 __ STA T1 + 1 
0a12 : ad 21 32 LDA $3221 ; (rng_seed + 1)
0a15 : 4a __ __ LSR
0a16 : 4a __ __ LSR
0a17 : 4a __ __ LSR
0a18 : 4a __ __ LSR
0a19 : 4a __ __ LSR
0a1a : 45 44 __ EOR T1 + 0 
0a1c : ac ec 9f LDY $9fec ; (exit2_y + 0)
0a1f : 59 01 32 EOR $3201,y ; (__multab7982L + 0)
0a22 : 8d 20 32 STA $3220 ; (rng_seed + 0)
0a25 : aa __ __ TAX
0a26 : b9 0a 32 LDA $320a,y ; (__multab7982H + 0)
0a29 : 45 45 __ EOR T1 + 1 
0a2b : 85 1c __ STA ACCU + 1 
0a2d : 8d 21 32 STA $3221 ; (rng_seed + 1)
;  84, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a30 : ee ec 9f INC $9fec ; (exit2_y + 0)
0a33 : ad ec 9f LDA $9fec ; (exit2_y + 0)
0a36 : c9 04 __ CMP #$04
0a38 : 90 c6 __ BCC $0a00 ; (init_rng.l2 + 0)
.s4:
;  92, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a3a : a9 00 __ LDA #$00
0a3c : 8d eb 9f STA $9feb ; (screen_offset + 1)
;  89, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a3f : 8a __ __ TXA
0a40 : 05 1c __ ORA ACCU + 1 
0a42 : d0 0a __ BNE $0a4e ; (init_rng.l9 + 0)
.s5:
0a44 : a9 22 __ LDA #$22
0a46 : 8d 20 32 STA $3220 ; (rng_seed + 0)
0a49 : a9 1d __ LDA #$1d
0a4b : 8d 21 32 STA $3221 ; (rng_seed + 1)
.l9:
;  93, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a4e : a9 ff __ LDA #$ff
0a50 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
;  92, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a53 : ee eb 9f INC $9feb ; (screen_offset + 1)
0a56 : ad eb 9f LDA $9feb ; (screen_offset + 1)
0a59 : c9 08 __ CMP #$08
0a5b : 90 f1 __ BCC $0a4e ; (init_rng.l9 + 0)
.s1001:
;  95, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 152, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a6c : c9 02 __ CMP #$02
0a6e : b0 03 __ BCS $0a73 ; (rnd.s3 + 0)
.s1:
0a70 : a9 00 __ LDA #$00
.s1001:
; 192, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a72 : 60 __ __ RTS
.s3:
0a73 : 85 0d __ STA P0 ; (max + 0)
; 156, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a75 : ad 20 32 LDA $3220 ; (rng_seed + 0)
0a78 : 85 1b __ STA ACCU + 0 
0a7a : 8d f8 9f STA $9ff8 ; (room + 1)
; 155, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a7d : ad 21 32 LDA $3221 ; (rng_seed + 1)
0a80 : 85 1c __ STA ACCU + 1 
0a82 : 85 43 __ STA T1 + 0 
0a84 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 157, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a87 : 10 04 __ BPL $0a8d ; (rnd.s42 + 0)
.s41:
0a89 : a9 01 __ LDA #$01
0a8b : b0 02 __ BCS $0a8f ; (rnd.s43 + 0)
.s42:
; 157, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a8d : a9 00 __ LDA #$00
.s43:
0a8f : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
; 160, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a92 : 06 1b __ ASL ACCU + 0 
0a94 : 26 1c __ ROL ACCU + 1 
0a96 : aa __ __ TAX
0a97 : a5 1b __ LDA ACCU + 0 
0a99 : 8d 20 32 STA $3220 ; (rng_seed + 0)
0a9c : a4 1c __ LDY ACCU + 1 
0a9e : 8c 21 32 STY $3221 ; (rng_seed + 1)
; 163, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0aa1 : 8a __ __ TXA
0aa2 : f0 0b __ BEQ $0aaf ; (rnd.s7 + 0)
.s5:
; 164, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0aa4 : 98 __ __ TYA
0aa5 : 49 b4 __ EOR #$b4
0aa7 : 8d 21 32 STA $3221 ; (rng_seed + 1)
0aaa : a5 1b __ LDA ACCU + 0 
0aac : 8d 20 32 STA $3220 ; (rng_seed + 0)
.s7:
; 168, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
0ac9 : 4d 20 32 EOR $3220 ; (rng_seed + 0)
0acc : 8d 20 32 STA $3220 ; (rng_seed + 0)
0acf : 8a __ __ TXA
0ad0 : 4d 21 32 EOR $3221 ; (rng_seed + 1)
0ad3 : 8d 21 32 STA $3221 ; (rng_seed + 1)
; 171, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0ad6 : 4d 20 32 EOR $3220 ; (rng_seed + 0)
0ad9 : 8d f6 9f STA $9ff6 ; (dx + 0)
; 174, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0adc : a5 0d __ LDA P0 ; (max + 0)
0ade : c9 08 __ CMP #$08
0ae0 : d0 06 __ BNE $0ae8 ; (rnd.s19 + 0)
.s11:
; 180, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0ae2 : ad f6 9f LDA $9ff6 ; (dx + 0)
0ae5 : 29 07 __ AND #$07
0ae7 : 60 __ __ RTS
.s19:
; 174, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0ae8 : 90 67 __ BCC $0b51 ; (rnd.s21 + 0)
.s20:
0aea : c9 10 __ CMP #$10
0aec : d0 06 __ BNE $0af4 ; (rnd.s14 + 0)
.s12:
; 182, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0aee : ad f6 9f LDA $9ff6 ; (dx + 0)
0af1 : 29 0f __ AND #$0f
0af3 : 60 __ __ RTS
.s14:
; 186, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0af4 : a9 00 __ LDA #$00
0af6 : 85 1b __ STA ACCU + 0 
0af8 : 85 04 __ STA WORK + 1 
0afa : a5 0d __ LDA P0 ; (max + 0)
0afc : 85 03 __ STA WORK + 0 
0afe : a9 01 __ LDA #$01
0b00 : 85 1c __ STA ACCU + 1 
0b02 : 20 7c 31 JSR $317c ; (divmod + 0)
0b05 : a5 0d __ LDA P0 ; (max + 0)
0b07 : 20 02 31 JSR $3102 ; (mul16by8 + 0)
0b0a : a5 1b __ LDA ACCU + 0 
0b0c : 8d f5 9f STA $9ff5 ; (s + 1)
; 187, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b0f : ad f6 9f LDA $9ff6 ; (dx + 0)
0b12 : c5 1b __ CMP ACCU + 0 
0b14 : 90 29 __ BCC $0b3f ; (rnd.s17 + 0)
.l16:
; 189, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b16 : ad 20 32 LDA $3220 ; (rng_seed + 0)
0b19 : 0a __ __ ASL
0b1a : 85 1c __ STA ACCU + 1 
0b1c : ad 21 32 LDA $3221 ; (rng_seed + 1)
0b1f : 2a __ __ ROL
0b20 : aa __ __ TAX
0b21 : ad 21 32 LDA $3221 ; (rng_seed + 1)
0b24 : 0a __ __ ASL
0b25 : a9 00 __ LDA #$00
0b27 : 2a __ __ ROL
0b28 : 45 1c __ EOR ACCU + 1 
0b2a : 49 37 __ EOR #$37
0b2c : 8d 20 32 STA $3220 ; (rng_seed + 0)
0b2f : 8a __ __ TXA
0b30 : 49 9e __ EOR #$9e
0b32 : 8d 21 32 STA $3221 ; (rng_seed + 1)
; 190, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b35 : 4d 20 32 EOR $3220 ; (rng_seed + 0)
0b38 : 8d f6 9f STA $9ff6 ; (dx + 0)
; 187, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b3b : c5 1b __ CMP ACCU + 0 
0b3d : b0 d7 __ BCS $0b16 ; (rnd.l16 + 0)
.s17:
; 192, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b3f : 85 1b __ STA ACCU + 0 
0b41 : a9 00 __ LDA #$00
0b43 : 85 1c __ STA ACCU + 1 
0b45 : 85 04 __ STA WORK + 1 
0b47 : a5 0d __ LDA P0 ; (max + 0)
0b49 : 85 03 __ STA WORK + 0 
0b4b : 20 7c 31 JSR $317c ; (divmod + 0)
0b4e : a5 05 __ LDA WORK + 2 
0b50 : 60 __ __ RTS
.s21:
; 174, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b51 : c9 02 __ CMP #$02
0b53 : d0 06 __ BNE $0b5b ; (rnd.s22 + 0)
.s9:
; 176, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b55 : ad f6 9f LDA $9ff6 ; (dx + 0)
0b58 : 29 01 __ AND #$01
0b5a : 60 __ __ RTS
.s22:
; 174, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b5b : c9 04 __ CMP #$04
0b5d : d0 95 __ BNE $0af4 ; (rnd.s14 + 0)
.s10:
; 178, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b5f : ad f6 9f LDA $9ff6 ; (dx + 0)
0b62 : 29 03 __ AND #$03
0b64 : 60 __ __ RTS
--------------------------------------------------------------------
oscar_clrscr: ; oscar_clrscr()->void
.s0:
; 105, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 146, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
0ba6 : 8d 6c 33 STA $336c ; (view + 0)
;  25, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0ba9 : 8d 6d 33 STA $336d ; (view + 1)
;  23, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0bac : a9 20 __ LDA #$20
0bae : 8d 6b 33 STA $336b ; (camera_center_y + 0)
;  22, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0bb1 : 8d 6a 33 STA $336a ; (camera_center_x + 0)
.s1001:
;  26, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0bb4 : 60 __ __ RTS
--------------------------------------------------------------------
reset_display_state: ; reset_display_state()->void
.s0:
;  37, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0bb5 : a9 00 __ LDA #$00
0bb7 : 8d 57 37 STA $3757 ; (last_scroll_direction + 0)
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0bba : a9 01 __ LDA #$01
0bbc : 8d 56 37 STA $3756 ; (screen_dirty + 0)
;  31, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0bbf : a9 20 __ LDA #$20
0bc1 : a2 fa __ LDX #$fa
.l1003:
0bc3 : ca __ __ DEX
0bc4 : 9d 6e 33 STA $336e,x ; (screen_buffer + 0)
0bc7 : 9d 68 34 STA $3468,x ; (screen_buffer + 250)
0bca : 9d 62 35 STA $3562,x ; (screen_buffer + 500)
0bcd : 9d 5c 36 STA $365c,x ; (screen_buffer + 750)
0bd0 : d0 f1 __ BNE $0bc3 ; (reset_display_state.l1003 + 0)
.s1001:
;  38, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0bd2 : 60 __ __ RTS
--------------------------------------------------------------------
reset_all_generation_data: ; reset_all_generation_data()->void
.s0:
; 707, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bd3 : 20 11 09 JSR $0911 ; (init_rng.s0 + 0)
; 710, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bd6 : 20 e4 0b JSR $0be4 ; (clear_map.s0 + 0)
; 713, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bd9 : a9 00 __ LDA #$00
0bdb : 8d 22 32 STA $3222 ; (room_count + 0)
; 716, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bde : 20 24 0c JSR $0c24 ; (clear_room_center_cache.s0 + 0)
; 719, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0be1 : 4c 2a 0c JMP $0c2a ; (init_rule_based_connection_system.s0 + 0)
--------------------------------------------------------------------
clear_map: ; clear_map()->void
.s0:
; 306, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0be4 : a9 00 __ LDA #$00
0be6 : 85 43 __ STA T1 + 0 
0be8 : 8d f8 9f STA $9ff8 ; (room + 1)
; 309, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0beb : 8d f6 9f STA $9ff6 ; (dx + 0)
0bee : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
; 306, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bf1 : a9 06 __ LDA #$06
0bf3 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
.l1005:
; 310, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bf6 : 18 __ __ CLC
0bf7 : a9 58 __ LDA #$58
0bf9 : 6d f6 9f ADC $9ff6 ; (dx + 0)
0bfc : a8 __ __ TAY
0bfd : ad f7 9f LDA $9ff7 ; (byte_ptr + 1)
0c00 : 85 1c __ STA ACCU + 1 
0c02 : 69 37 __ ADC #$37
0c04 : 85 44 __ STA T1 + 1 
0c06 : a9 00 __ LDA #$00
0c08 : ae f6 9f LDX $9ff6 ; (dx + 0)
0c0b : 91 43 __ STA (T1 + 0),y 
; 309, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0c0d : 8a __ __ TXA
0c0e : 69 01 __ ADC #$01
0c10 : 8d f6 9f STA $9ff6 ; (dx + 0)
0c13 : a5 1c __ LDA ACCU + 1 
0c15 : 69 00 __ ADC #$00
0c17 : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
0c1a : c9 06 __ CMP #$06
0c1c : d0 d8 __ BNE $0bf6 ; (clear_map.l1005 + 0)
.s1006:
; 309, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0c1e : ad f6 9f LDA $9ff6 ; (dx + 0)
0c21 : d0 d3 __ BNE $0bf6 ; (clear_map.l1005 + 0)
.s1001:
; 312, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0c23 : 60 __ __ RTS
--------------------------------------------------------------------
clear_room_center_cache: ; clear_room_center_cache()->void
.s0:
; 370, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0c24 : a9 00 __ LDA #$00
0c26 : 8d 23 32 STA $3223 ; (room_center_cache_valid + 0)
.s1001:
; 371, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0c29 : 60 __ __ RTS
--------------------------------------------------------------------
init_rule_based_connection_system: ; init_rule_based_connection_system()->void
.s0:
; 449, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c2a : a9 00 __ LDA #$00
0c2c : 8d f5 9f STA $9ff5 ; (s + 1)
.l2:
; 450, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
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
; 451, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c41 : 2a __ __ ROL
0c42 : 85 44 __ STA T0 + 1 
0c44 : a9 e8 __ LDA #$e8
0c46 : 65 43 __ ADC T0 + 0 
0c48 : 85 1b __ STA ACCU + 0 
0c4a : a9 3e __ LDA #$3e
0c4c : 65 44 __ ADC T0 + 1 
0c4e : 85 1c __ STA ACCU + 1 
0c50 : 18 __ __ CLC
0c51 : a9 58 __ LDA #$58
0c53 : 65 43 __ ADC T0 + 0 
0c55 : 85 43 __ STA T0 + 0 
0c57 : a9 3d __ LDA #$3d
0c59 : 65 44 __ ADC T0 + 1 
0c5b : 85 44 __ STA T0 + 1 
.l6:
; 452, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c5d : a9 ff __ LDA #$ff
0c5f : ac f4 9f LDY $9ff4 ; (entropy1 + 1)
0c62 : 91 1b __ STA (ACCU + 0),y 
; 451, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c64 : a9 00 __ LDA #$00
0c66 : 91 43 __ STA (T0 + 0),y 
; 450, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c68 : c8 __ __ INY
0c69 : 8c f4 9f STY $9ff4 ; (entropy1 + 1)
0c6c : c0 14 __ CPY #$14
0c6e : 90 ed __ BCC $0c5d ; (init_rule_based_connection_system.l6 + 0)
.s3:
; 449, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c70 : e8 __ __ INX
0c71 : 8e f5 9f STX $9ff5 ; (s + 1)
0c74 : e0 14 __ CPX #$14
0c76 : 90 b7 __ BCC $0c2f ; (init_rule_based_connection_system.l2 + 0)
.s4:
; 464, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c78 : 8d f3 9f STA $9ff3 ; (i + 0)
; 461, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c7b : 8d 2f 33 STA $332f ; (distance_cache_valid + 0)
; 460, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c7e : 8d 2e 33 STA $332e ; (connection_cache + 72)
; 457, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c81 : 8d e4 32 STA $32e4 ; (corridor_pool + 192)
; 458, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c84 : 8d e5 32 STA $32e5 ; (corridor_pool + 193)
; 464, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c87 : ad 22 32 LDA $3222 ; (room_count + 0)
0c8a : 85 48 __ STA T5 + 0 
0c8c : f0 74 __ BEQ $0d02 ; (init_rule_based_connection_system.s12 + 0)
.l13:
0c8e : ad f3 9f LDA $9ff3 ; (i + 0)
0c91 : c9 14 __ CMP #$14
0c93 : b0 6d __ BCS $0d02 ; (init_rule_based_connection_system.s12 + 0)
.s10:
; 465, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c95 : 85 49 __ STA T6 + 0 
0c97 : 85 45 __ STA T2 + 0 
0c99 : 69 01 __ ADC #$01
0c9b : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
0c9e : c5 48 __ CMP T5 + 0 
0ca0 : b0 55 __ BCS $0cf7 ; (init_rule_based_connection_system.s11 + 0)
.s31:
; 466, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
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
0cb0 : 69 e8 __ ADC #$e8
0cb2 : 85 46 __ STA T3 + 0 
0cb4 : 8a __ __ TXA
0cb5 : 69 3e __ ADC #$3e
0cb7 : 85 47 __ STA T3 + 1 
.l18:
; 465, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0cb9 : ad f2 9f LDA $9ff2 ; (entropy2 + 1)
0cbc : c9 14 __ CMP #$14
0cbe : b0 37 __ BCS $0cf7 ; (init_rule_based_connection_system.s11 + 0)
.s15:
; 466, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0cc0 : a5 49 __ LDA T6 + 0 
0cc2 : 85 13 __ STA P6 
0cc4 : ad f2 9f LDA $9ff2 ; (entropy2 + 1)
0cc7 : 85 14 __ STA P7 
0cc9 : 20 08 0d JSR $0d08 ; (calculate_room_distance.s0 + 0)
0ccc : a4 14 __ LDY P7 
0cce : 91 46 __ STA (T3 + 0),y 
0cd0 : aa __ __ TAX
; 467, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
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
0cde : 69 e8 __ ADC #$e8
0ce0 : 85 43 __ STA T0 + 0 
0ce2 : 98 __ __ TYA
0ce3 : 69 3e __ ADC #$3e
0ce5 : 85 44 __ STA T0 + 1 
0ce7 : 8a __ __ TXA
0ce8 : a4 45 __ LDY T2 + 0 
0cea : 91 43 __ STA (T0 + 0),y 
; 465, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0cec : a5 14 __ LDA P7 
0cee : 69 01 __ ADC #$01
0cf0 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
0cf3 : c5 48 __ CMP T5 + 0 
0cf5 : 90 c2 __ BCC $0cb9 ; (init_rule_based_connection_system.l18 + 0)
.s11:
; 464, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0cf7 : a5 49 __ LDA T6 + 0 
0cf9 : 69 00 __ ADC #$00
0cfb : 8d f3 9f STA $9ff3 ; (i + 0)
0cfe : c5 48 __ CMP T5 + 0 
0d00 : 90 8c __ BCC $0c8e ; (init_rule_based_connection_system.l13 + 0)
.s12:
; 470, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0d02 : a9 01 __ LDA #$01
0d04 : 8d 2f 33 STA $332f ; (distance_cache_valid + 0)
.s1001:
; 471, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0d07 : 60 __ __ RTS
--------------------------------------------------------------------
calculate_room_distance: ; calculate_room_distance(u8,u8)->u8
.s0:
; 381, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 382, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 383, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d36 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
0d39 : 85 0f __ STA P2 
0d3b : ad f8 9f LDA $9ff8 ; (room + 1)
0d3e : 85 10 __ STA P3 
0d40 : ad f7 9f LDA $9ff7 ; (byte_ptr + 1)
0d43 : 85 11 __ STA P4 
0d45 : ad f6 9f LDA $9ff6 ; (dx + 0)
0d48 : 85 12 __ STA P5 
0d4a : 4c c8 0d JMP $0dc8 ; (manhattan_distance.s0 + 0)
--------------------------------------------------------------------
get_room_center: ; get_room_center(u8,u8*,u8*)->void
.s0:
; 338, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d4d : ad 23 32 LDA $3223 ; (room_center_cache_valid + 0)
0d50 : d0 05 __ BNE $0d57 ; (get_room_center.s4 + 0)
.s1002:
; 341, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d52 : a5 0d __ LDA P0 ; (room_id + 0)
0d54 : 4c 5d 0d JMP $0d5d ; (get_room_center.s1 + 0)
.s4:
; 338, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d57 : a5 0d __ LDA P0 ; (room_id + 0)
0d59 : c9 14 __ CMP #$14
0d5b : 90 5c __ BCC $0db9 ; (get_room_center.s3 + 0)
.s1:
; 341, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 342, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 345, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0daa : b1 0e __ LDA (P1),y ; (center_x + 0)
0dac : 06 1b __ ASL ACCU + 0 
0dae : a6 1b __ LDX ACCU + 0 
0db0 : 9d 78 40 STA $4078,x ; (room_center_cache + 0)
; 346, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0db3 : b1 10 __ LDA (P3),y ; (center_y + 0)
0db5 : 9d 79 40 STA $4079,x ; (room_center_cache + 1)
0db8 : 60 __ __ RTS
.s3:
; 351, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0db9 : 0a __ __ ASL
0dba : aa __ __ TAX
0dbb : bd 78 40 LDA $4078,x ; (room_center_cache + 0)
0dbe : a0 00 __ LDY #$00
0dc0 : 91 0e __ STA (P1),y ; (center_x + 0)
; 352, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0dc2 : bd 79 40 LDA $4079,x ; (room_center_cache + 1)
0dc5 : 91 10 __ STA (P3),y ; (center_y + 0)
.s1001:
; 348, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0dc7 : 60 __ __ RTS
--------------------------------------------------------------------
manhattan_distance: ; manhattan_distance(u8,u8,u8,u8)->u8
.s0:
; 375, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 333, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0de4 : a5 0e __ LDA P1 ; (b + 0)
0de6 : c5 0d __ CMP P0 ; (a + 0)
0de8 : 90 03 __ BCC $0ded ; (fast_abs_diff.s2 + 0)
.s3:
0dea : e5 0d __ SBC P0 ; (a + 0)
0dec : 60 __ __ RTS
.s2:
; 333, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
0df7 : 9d 65 9f STA $9f65,x ; (generate_level@stack + 0)
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
0e0b : ad 22 32 LDA $3222 ; (room_count + 0)
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
0e22 : 8d 80 9f STA $9f80 ; (connections_made + 0)
; 128, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e25 : 20 2a 0c JSR $0c2a ; (init_rule_based_connection_system.s0 + 0)
; 131, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e28 : a9 00 __ LDA #$00
0e2a : 8d 7f 9f STA $9f7f ; (i + 0)
.l6:
; 132, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e2d : a9 00 __ LDA #$00
0e2f : ae 7f 9f LDX $9f7f ; (i + 0)
0e32 : 9d 81 9f STA $9f81,x ; (connected + 0)
; 131, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e35 : ee 7f 9f INC $9f7f ; (i + 0)
0e38 : ad 7f 9f LDA $9f7f ; (i + 0)
0e3b : c9 14 __ CMP #$14
0e3d : 90 ee __ BCC $0e2d ; (generate_level.l6 + 0)
.s8:
; 139, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e3f : a9 00 __ LDA #$00
0e41 : 85 1c __ STA ACCU + 1 
0e43 : 8d 7b 9f STA $9f7b ; (iterations + 0)
0e46 : 8d 7c 9f STA $9f7c ; (iterations + 1)
; 136, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e49 : a9 01 __ LDA #$01
0e4b : 8d 81 9f STA $9f81 ; (connected + 0)
; 138, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e4e : a5 58 __ LDA T5 + 0 
0e50 : 85 1b __ STA ACCU + 0 
0e52 : 20 02 31 JSR $3102 ; (mul16by8 + 0)
0e55 : a5 1b __ LDA ACCU + 0 
0e57 : 0a __ __ ASL
0e58 : 85 55 __ STA T3 + 0 
0e5a : 8d 7d 9f STA $9f7d ; (max_iterations + 0)
0e5d : a5 1c __ LDA ACCU + 1 
0e5f : 2a __ __ ROL
0e60 : 85 56 __ STA T3 + 1 
0e62 : 8d 7e 9f STA $9f7e ; (max_iterations + 1)
0e65 : 4c 77 0e JMP $0e77 ; (generate_level.l9 + 0)
.s279:
; 198, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e68 : 18 __ __ CLC
0e69 : a5 53 __ LDA T1 + 0 
0e6b : 69 01 __ ADC #$01
0e6d : 8d 7b 9f STA $9f7b ; (iterations + 0)
0e70 : a5 54 __ LDA T1 + 1 
0e72 : 69 00 __ ADC #$00
0e74 : 8d 7c 9f STA $9f7c ; (iterations + 1)
.l9:
; 140, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e77 : ad 80 9f LDA $9f80 ; (connections_made + 0)
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
0e89 : ad 7b 9f LDA $9f7b ; (iterations + 0)
0e8c : 85 53 __ STA T1 + 0 
0e8e : ad 7c 9f LDA $9f7c ; (iterations + 1)
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
0e9d : 20 39 27 JSR $2739 ; (add_walls.s0 + 0)
; 206, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ea0 : 20 3d 28 JSR $283d ; (add_stairs.s0 + 0)
; 208, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ea3 : a9 01 __ LDA #$01
.s1001:
0ea5 : 85 1b __ STA ACCU + 0 
0ea7 : a2 09 __ LDX #$09
0ea9 : bd 65 9f LDA $9f65,x ; (generate_level@stack + 0)
0eac : 95 53 __ STA T1 + 0,x 
0eae : ca __ __ DEX
0eaf : 10 f8 __ BPL $0ea9 ; (generate_level.s1001 + 4)
0eb1 : 60 __ __ RTS
.s10:
; 148, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0eb2 : a9 00 __ LDA #$00
0eb4 : 8d 7f 9f STA $9f7f ; (i + 0)
; 144, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0eb7 : 8d 77 9f STA $9f77 ; (connection_found + 0)
; 145, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0eba : 8d 76 9f STA $9f76 ; (failed_attempts + 0)
; 142, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ebd : a9 ff __ LDA #$ff
0ebf : 8d 7a 9f STA $9f7a ; (best_room1 + 0)
0ec2 : 8d 79 9f STA $9f79 ; (best_room2 + 0)
; 143, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ec5 : 8d 78 9f STA $9f78 ; (best_distance + 0)
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
0ed5 : ae 7f 9f LDX $9f7f ; (i + 0)
0ed8 : 86 5b __ STX T8 + 0 
0eda : bd 81 9f LDA $9f81,x ; (connected + 0)
0edd : f0 64 __ BEQ $0f43 ; (generate_level.s15 + 0)
.s19:
; 150, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0edf : a9 00 __ LDA #$00
0ee1 : 8d 75 9f STA $9f75 ; (j + 0)
0ee4 : a5 5a __ LDA T7 + 0 
0ee6 : f0 5b __ BEQ $0f43 ; (generate_level.s15 + 0)
.l22:
; 151, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ee8 : ae 75 9f LDX $9f75 ; (j + 0)
0eeb : 86 5c __ STX T9 + 0 
0eed : bd 81 9f LDA $9f81,x ; (connected + 0)
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
0f1a : 8d 74 9f STA $9f74 ; (distance + 0)
; 156, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f1d : cd 78 9f CMP $9f78 ; (best_distance + 0)
0f20 : b0 15 __ BCS $0f37 ; (generate_level.s21 + 0)
.s37:
; 158, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f22 : a5 13 __ LDA P6 
0f24 : 8d 7a 9f STA $9f7a ; (best_room1 + 0)
; 159, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f27 : a5 5c __ LDA T9 + 0 
0f29 : 8d 79 9f STA $9f79 ; (best_room2 + 0)
; 157, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f2c : ad 74 9f LDA $9f74 ; (distance + 0)
0f2f : 8d 78 9f STA $9f78 ; (best_distance + 0)
; 160, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f32 : a9 01 __ LDA #$01
0f34 : 8d 77 9f STA $9f77 ; (connection_found + 0)
.s21:
; 150, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f37 : 18 __ __ CLC
0f38 : a5 5c __ LDA T9 + 0 
0f3a : 69 01 __ ADC #$01
0f3c : 8d 75 9f STA $9f75 ; (j + 0)
0f3f : c5 58 __ CMP T5 + 0 
0f41 : 90 a5 __ BCC $0ee8 ; (generate_level.l22 + 0)
.s15:
; 148, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f43 : 18 __ __ CLC
0f44 : a5 5b __ LDA T8 + 0 
0f46 : 69 01 __ ADC #$01
0f48 : 8d 7f 9f STA $9f7f ; (i + 0)
0f4b : c5 58 __ CMP T5 + 0 
0f4d : 90 86 __ BCC $0ed5 ; (generate_level.l14 + 0)
.s16:
; 165, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f4f : ad 77 9f LDA $9f77 ; (connection_found + 0)
0f52 : f0 30 __ BEQ $0f84 ; (generate_level.s41 + 0)
.s43:
0f54 : ad 7a 9f LDA $9f7a ; (best_room1 + 0)
0f57 : 8d fe 9f STA $9ffe ; (sstack + 4)
0f5a : ad 79 9f LDA $9f79 ; (best_room2 + 0)
0f5d : 85 57 __ STA T4 + 0 
0f5f : 8d ff 9f STA $9fff ; (sstack + 5)
0f62 : 20 e3 19 JSR $19e3 ; (rule_based_connect_rooms.s1000 + 0)
0f65 : a5 1b __ LDA ACCU + 0 
0f67 : f0 1b __ BEQ $0f84 ; (generate_level.s41 + 0)
.s40:
; 166, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f69 : a9 01 __ LDA #$01
0f6b : a6 57 __ LDX T4 + 0 
0f6d : 9d 81 9f STA $9f81,x ; (connected + 0)
; 167, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f70 : a6 59 __ LDX T6 + 0 
0f72 : e8 __ __ INX
0f73 : 8e 80 9f STX $9f80 ; (connections_made + 0)
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
0f86 : 8d 7f 9f STA $9f7f ; (i + 0)
; 172, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f89 : 8d 77 9f STA $9f77 ; (connection_found + 0)
; 173, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f8c : a5 5a __ LDA T7 + 0 
0f8e : d0 03 __ BNE $0f93 ; (generate_level.l48 + 0)
0f90 : 4c 29 10 JMP $1029 ; (generate_level.s79 + 0)
.l48:
; 174, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f93 : ae 7f 9f LDX $9f7f ; (i + 0)
0f96 : 86 59 __ STX T6 + 0 
0f98 : bd 81 9f LDA $9f81,x ; (connected + 0)
0f9b : f0 6e __ BEQ $100b ; (generate_level.s49 + 0)
.s54:
; 175, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f9d : a9 00 __ LDA #$00
0f9f : 8d 73 9f STA $9f73 ; (j + 0)
0fa2 : a5 5a __ LDA T7 + 0 
0fa4 : f0 65 __ BEQ $100b ; (generate_level.s49 + 0)
.l60:
0fa6 : ad 77 9f LDA $9f77 ; (connection_found + 0)
0fa9 : d0 60 __ BNE $100b ; (generate_level.s49 + 0)
.s57:
; 176, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0fab : ac 73 9f LDY $9f73 ; (j + 0)
0fae : 84 5b __ STY T8 + 0 
0fb0 : b9 81 9f LDA $9f81,y ; (connected + 0)
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
0fe3 : 8d 77 9f STA $9f77 ; (connection_found + 0)
; 182, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0fe6 : a6 5b __ LDX T8 + 0 
0fe8 : 9d 81 9f STA $9f81,x ; (connected + 0)
; 183, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0feb : ee 80 9f INC $9f80 ; (connections_made + 0)
0fee : ad 80 9f LDA $9f80 ; (connections_made + 0)
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
1004 : 8d 73 9f STA $9f73 ; (j + 0)
1007 : c5 58 __ CMP T5 + 0 
1009 : 90 9b __ BCC $0fa6 ; (generate_level.l60 + 0)
.s49:
; 173, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
100b : 18 __ __ CLC
100c : a5 59 __ LDA T6 + 0 
100e : 69 01 __ ADC #$01
1010 : 8d 7f 9f STA $9f7f ; (i + 0)
1013 : c5 58 __ CMP T5 + 0 
1015 : ad 77 9f LDA $9f77 ; (connection_found + 0)
1018 : b0 0d __ BCS $1027 ; (generate_level.s50 + 0)
.s51:
101a : d0 03 __ BNE $101f ; (generate_level.s80 + 0)
101c : 4c 93 0f JMP $0f93 ; (generate_level.l48 + 0)
.s80:
; 195, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
101f : a9 00 __ LDA #$00
.s1012:
1021 : 8d 76 9f STA $9f76 ; (failed_attempts + 0)
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
; 680, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
102d : a9 00 __ LDA #$00
102f : f0 05 __ BEQ $1036 ; (print_text.l1 + 0)
.s25:
; 696, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1031 : 18 __ __ CLC
1032 : a5 43 __ LDA T2 + 0 
1034 : 69 01 __ ADC #$01
.l1:
; 680, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1036 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 681, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1039 : 85 43 __ STA T2 + 0 
103b : a8 __ __ TAY
103c : b1 0d __ LDA (P0),y ; (text + 0)
103e : d0 01 __ BNE $1041 ; (print_text.s2 + 0)
.s1001:
; 698, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1040 : 60 __ __ RTS
.s2:
; 682, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1041 : c9 0a __ CMP #$0a
1043 : f0 0a __ BEQ $104f ; (print_text.s4 + 0)
.s5:
; 691, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1045 : a4 43 __ LDY T2 + 0 
1047 : b1 0d __ LDA (P0),y ; (text + 0)
1049 : 20 d2 ff JSR $ffd2 
104c : 4c 31 10 JMP $1031 ; (print_text.s25 + 0)
.s4:
; 685, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
1079 : 8d c8 9f STA $9fc8 ; (step_limit2 + 0)
107c : a5 54 __ LDA T6 + 0 
107e : 8d c9 9f STA $9fc9 ; (create_rooms@stack + 1)
.s0:
; 213, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1081 : a9 00 __ LDA #$00
1083 : 8d e1 9f STA $9fe1 ; (y + 1)
; 215, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1086 : 8d d0 9f STA $9fd0 ; (dx2 + 1)
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
109b : 9d d1 9f STA $9fd1,x ; (step_limit1 + 0)
; 222, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
109e : ee d0 9f INC $9fd0 ; (dx2 + 1)
; 220, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10a1 : 69 01 __ ADC #$01
10a3 : 8d e6 9f STA $9fe6 ; (check_y + 0)
10a6 : c9 10 __ CMP #$10
; 222, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10a8 : ae d0 9f LDX $9fd0 ; (dx2 + 1)
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
10cc : 8d cf 9f STA $9fcf ; (dx2 + 0)
; 227, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10cf : aa __ __ TAX
10d0 : ac e6 9f LDY $9fe6 ; (check_y + 0)
10d3 : b9 d1 9f LDA $9fd1,y ; (step_limit1 + 0)
10d6 : 8d ce 9f STA $9fce ; (dy2 + 1)
; 228, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10d9 : bd d1 9f LDA $9fd1,x ; (step_limit1 + 0)
10dc : 99 d1 9f STA $9fd1,y ; (step_limit1 + 0)
; 229, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10df : ad ce 9f LDA $9fce ; (dy2 + 1)
10e2 : 9d d1 9f STA $9fd1,x ; (step_limit1 + 0)
; 225, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10e5 : 18 __ __ CLC
10e6 : a5 54 __ LDA T6 + 0 
10e8 : 69 fe __ ADC #$fe
10ea : 8d e6 9f STA $9fe6 ; (check_y + 0)
10ed : d0 d2 __ BNE $10c1 ; (create_rooms.l6 + 0)
.s8:
; 233, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10ef : a9 00 __ LDA #$00
10f1 : 8d cd 9f STA $9fcd ; (pass + 0)
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
111c : bd d1 9f LDA $9fd1,x ; (step_limit1 + 0)
111f : 8d cc 9f STA $9fcc ; (corridor2_x + 0)
; 237, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1122 : bd d2 9f LDA $9fd2,x ; (grid_positions + 1)
1125 : 9d d1 9f STA $9fd1,x ; (step_limit1 + 0)
; 238, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1128 : ad cc 9f LDA $9fcc ; (corridor2_x + 0)
112b : 9d d2 9f STA $9fd2,x ; (grid_positions + 1)
112e : 4c f9 10 JMP $10f9 ; (create_rooms.l13 + 0)
.s11:
; 233, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1131 : ee cd 9f INC $9fcd ; (pass + 0)
1134 : ad cd 9f LDA $9fcd ; (pass + 0)
1137 : c9 02 __ CMP #$02
1139 : 90 b9 __ BCC $10f4 ; (create_rooms.l10 + 0)
.s12:
; 242, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
113b : a9 00 __ LDA #$00
113d : 8d e6 9f STA $9fe6 ; (check_y + 0)
.l25:
1140 : ad e1 9f LDA $9fe1 ; (y + 1)
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
1169 : 8c e3 9f STY $9fe3 ; (x + 1)
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
1192 : 8d e3 9f STA $9fe3 ; (x + 1)
; 254, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1195 : a9 04 __ LDA #$04
1197 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
119a : 18 __ __ CLC
119b : 69 05 __ ADC #$05
.s28:
; 250, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
119d : 8d e2 9f STA $9fe2 ; (h + 0)
; 262, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11a0 : 85 17 __ STA P10 
11a2 : a6 51 __ LDX T3 + 0 
11a4 : bd d1 9f LDA $9fd1,x ; (step_limit1 + 0)
11a7 : 85 15 __ STA P8 
11a9 : ad e3 9f LDA $9fe3 ; (x + 1)
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
11cb : ad e5 9f LDA $9fe5 ; (dy + 1)
11ce : 85 13 __ STA P6 
11d0 : ad e4 9f LDA $9fe4 ; (dy + 0)
11d3 : 85 14 __ STA P7 
11d5 : a5 52 __ LDA T4 + 0 
11d7 : 85 15 __ STA P8 
11d9 : a5 17 __ LDA P10 
11db : 85 16 __ STA P9 
11dd : 20 a7 15 JSR $15a7 ; (place_room.s0 + 0)
; 264, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11e0 : a6 4f __ LDX T2 + 0 
11e2 : e8 __ __ INX
11e3 : 8e e1 9f STX $9fe1 ; (y + 1)
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
1200 : ad e1 9f LDA $9fe1 ; (y + 1)
1203 : 85 4d __ STA T0 + 0 
1205 : 8d 22 32 STA $3222 ; (room_count + 0)
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
1216 : a9 33 __ LDA #$33
1218 : 85 11 __ STA P4 
121a : a9 6a __ LDA #$6a
121c : 85 0e __ STA P1 
121e : a9 33 __ LDA #$33
1220 : 85 0f __ STA P2 
1222 : a9 6b __ LDA #$6b
1224 : 85 10 __ STA P3 
1226 : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 278, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1229 : 20 fe 17 JSR $17fe ; (update_camera.s0 + 0)
.s1001:
122c : ad c8 9f LDA $9fc8 ; (step_limit2 + 0)
122f : 85 53 __ STA T5 + 0 
1231 : ad c9 9f LDA $9fc9 ; (create_rooms@stack + 1)
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
126e : 8d e7 9f STA $9fe7 ; (dx + 1)
;  93, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1271 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
1274 : 38 __ __ SEC
1275 : e9 04 __ SBC #$04
1277 : 18 __ __ CLC
1278 : 6d ea 9f ADC $9fea ; (x + 0)
127b : 85 4c __ STA T2 + 0 
127d : 8d ea 9f STA $9fea ; (x + 0)
;  94, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1280 : a9 08 __ LDA #$08
1282 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
1285 : 38 __ __ SEC
1286 : e9 04 __ SBC #$04
1288 : 18 __ __ CLC
1289 : 6d e9 9f ADC $9fe9 ; (room2_center_x + 0)
128c : 8d e9 9f STA $9fe9 ; (room2_center_x + 0)
;  97, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
128f : a5 4c __ LDA T2 + 0 
1291 : c9 04 __ CMP #$04
1293 : b0 05 __ BCS $129a ; (try_place_room_at_grid.s9 + 0)
.s7:
1295 : a9 04 __ LDA #$04
1297 : 8d ea 9f STA $9fea ; (x + 0)
.s9:
;  98, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
129a : ad e9 9f LDA $9fe9 ; (room2_center_x + 0)
129d : c9 04 __ CMP #$04
129f : b0 05 __ BCS $12a6 ; (try_place_room_at_grid.s12 + 0)
.s10:
12a1 : a9 04 __ LDA #$04
12a3 : 8d e9 9f STA $9fe9 ; (room2_center_x + 0)
.s12:
;  99, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12a6 : 18 __ __ CLC
12a7 : a5 16 __ LDA P9 ; (w + 0)
12a9 : 6d ea 9f ADC $9fea ; (x + 0)
12ac : b0 04 __ BCS $12b2 ; (try_place_room_at_grid.s13 + 0)
.s1003:
12ae : c9 3d __ CMP #$3d
12b0 : 90 0a __ BCC $12bc ; (try_place_room_at_grid.s15 + 0)
.s13:
12b2 : a9 40 __ LDA #$40
12b4 : e5 16 __ SBC P9 ; (w + 0)
12b6 : 38 __ __ SEC
12b7 : e9 04 __ SBC #$04
12b9 : 8d ea 9f STA $9fea ; (x + 0)
.s15:
; 100, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12bc : 18 __ __ CLC
12bd : a5 17 __ LDA P10 ; (h + 0)
12bf : 6d e9 9f ADC $9fe9 ; (room2_center_x + 0)
12c2 : b0 04 __ BCS $12c8 ; (try_place_room_at_grid.s16 + 0)
.s1002:
12c4 : c9 3d __ CMP #$3d
12c6 : 90 0a __ BCC $12d2 ; (try_place_room_at_grid.s6 + 0)
.s16:
12c8 : a9 40 __ LDA #$40
12ca : e5 17 __ SBC P10 ; (h + 0)
12cc : 38 __ __ SEC
12cd : e9 04 __ SBC #$04
12cf : 8d e9 9f STA $9fe9 ; (room2_center_x + 0)
.s6:
; 102, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12d2 : a5 16 __ LDA P9 ; (w + 0)
12d4 : 85 13 __ STA P6 
12d6 : a5 17 __ LDA P10 ; (h + 0)
12d8 : 85 14 __ STA P7 
12da : ad ea 9f LDA $9fea ; (x + 0)
12dd : 85 4b __ STA T1 + 0 
12df : 85 11 __ STA P4 
12e1 : ad e9 9f LDA $9fe9 ; (room2_center_x + 0)
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
1315 : ad e9 9f LDA $9fe9 ; (room2_center_x + 0)
1318 : 91 43 __ STA (T0 + 0),y 
; 105, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
131a : a9 01 __ LDA #$01
131c : 85 1b __ STA ACCU + 0 ; (result_y + 0)
131e : 60 __ __ RTS
--------------------------------------------------------------------
get_grid_position: ; get_grid_position(u8,u8*,u8*)->void
.s0:
; 390, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
131f : a9 0e __ LDA #$0e
1321 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
; 391, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1324 : 8d f1 9f STA $9ff1 ; (entropy2 + 0)
; 398, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1327 : 8d ee 9f STA $9fee ; (entropy4 + 1)
; 399, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
132a : 8d ed 9f STA $9fed ; (exit2_x + 0)
; 388, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
132d : a5 0e __ LDA P1 ; (grid_index + 0)
132f : 29 03 __ AND #$03
1331 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
1334 : aa __ __ TAX
; 389, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1335 : a5 0e __ LDA P1 ; (grid_index + 0)
1337 : 4a __ __ LSR
1338 : 4a __ __ LSR
1339 : 8d f3 9f STA $9ff3 ; (i + 0)
; 394, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
133c : bd 13 32 LDA $3213,x ; (__multab14L + 0)
133f : 18 __ __ CLC
1340 : 69 04 __ ADC #$04
1342 : 85 45 __ STA T1 + 0 
1344 : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
; 395, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1347 : ad f3 9f LDA $9ff3 ; (i + 0)
134a : 0a __ __ ASL
134b : 0a __ __ ASL
134c : 0a __ __ ASL
134d : 38 __ __ SEC
134e : ed f3 9f SBC $9ff3 ; (i + 0)
1351 : 0a __ __ ASL
1352 : 18 __ __ CLC
1353 : 69 04 __ ADC #$04
1355 : 85 46 __ STA T2 + 0 
1357 : 8d ef 9f STA $9fef ; (screen_pos + 1)
; 402, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
135a : a9 15 __ LDA #$15
135c : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
135f : 85 44 __ STA T0 + 0 
1361 : 8d ec 9f STA $9fec ; (exit2_y + 0)
; 403, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1364 : a9 15 __ LDA #$15
1366 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
1369 : 8d eb 9f STA $9feb ; (screen_offset + 1)
136c : aa __ __ TAX
; 406, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
136d : 18 __ __ CLC
136e : a5 44 __ LDA T0 + 0 
1370 : 65 45 __ ADC T1 + 0 
1372 : 38 __ __ SEC
1373 : e9 07 __ SBC #$07
1375 : a0 00 __ LDY #$00
1377 : 91 0f __ STA (P2),y ; (x + 0)
; 407, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1379 : 8a __ __ TXA
137a : 18 __ __ CLC
137b : 65 46 __ ADC T2 + 0 
137d : 38 __ __ SEC
137e : e9 07 __ SBC #$07
1380 : 91 11 __ STA (P4),y ; (y + 0)
; 410, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1382 : a9 06 __ LDA #$06
1384 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
1387 : 38 __ __ SEC
1388 : e9 03 __ SBC #$03
138a : 18 __ __ CLC
138b : a0 00 __ LDY #$00
138d : 71 0f __ ADC (P2),y ; (x + 0)
138f : 91 0f __ STA (P2),y ; (x + 0)
; 411, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1391 : a9 06 __ LDA #$06
1393 : 20 6c 0a JSR $0a6c ; (rnd.s0 + 0)
1396 : 38 __ __ SEC
1397 : e9 03 __ SBC #$03
1399 : 18 __ __ CLC
139a : a0 00 __ LDY #$00
139c : 71 11 __ ADC (P4),y ; (y + 0)
139e : 91 11 __ STA (P4),y ; (y + 0)
13a0 : aa __ __ TAX
; 414, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
13a1 : b1 0f __ LDA (P2),y ; (x + 0)
13a3 : c9 04 __ CMP #$04
13a5 : b0 08 __ BCS $13af ; (get_grid_position.s3 + 0)
.s1:
13a7 : a9 04 __ LDA #$04
13a9 : 91 0f __ STA (P2),y ; (x + 0)
; 415, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
13ab : b1 11 __ LDA (P4),y ; (y + 0)
13ad : 90 01 __ BCC $13b0 ; (get_grid_position.s1002 + 0)
.s3:
; 415, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
13af : 8a __ __ TXA
.s1002:
13b0 : c9 04 __ CMP #$04
13b2 : b0 04 __ BCS $13b8 ; (get_grid_position.s6 + 0)
.s4:
; 415, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
13b4 : a9 04 __ LDA #$04
13b6 : 91 11 __ STA (P4),y ; (y + 0)
.s6:
; 416, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
13b8 : b1 0f __ LDA (P2),y ; (x + 0)
13ba : c9 35 __ CMP #$35
13bc : 90 04 __ BCC $13c2 ; (get_grid_position.s9 + 0)
.s7:
13be : a9 34 __ LDA #$34
13c0 : 91 0f __ STA (P2),y ; (x + 0)
.s9:
; 417, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
13c2 : b1 11 __ LDA (P4),y ; (y + 0)
13c4 : c9 35 __ CMP #$35
13c6 : 90 04 __ BCC $13cc ; (get_grid_position.s1001 + 0)
.s10:
13c8 : a9 34 __ LDA #$34
13ca : 91 11 __ STA (P4),y ; (y + 0)
.s1001:
; 418, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
1415 : 8d f3 9f STA $9ff3 ; (i + 0)
1418 : 18 __ __ CLC
1419 : a5 49 __ LDA T5 + 0 
141b : 69 04 __ ADC #$04
141d : 85 45 __ STA T1 + 0 
141f : a9 00 __ LDA #$00
1421 : 2a __ __ ROL
1422 : 85 46 __ STA T1 + 1 
1424 : ad f3 9f LDA $9ff3 ; (i + 0)
1427 : 90 08 __ BCC $1431 ; (can_place_room.l12 + 0)
.s14:
;  23, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1429 : 18 __ __ CLC
142a : a5 48 __ LDA T3 + 0 
142c : 69 01 __ ADC #$01
142e : 8d f3 9f STA $9ff3 ; (i + 0)
.l12:
1431 : 85 48 __ STA T3 + 0 
1433 : a5 46 __ LDA T1 + 1 
1435 : d0 07 __ BNE $143e ; (can_place_room.s13 + 0)
.s1014:
1437 : a5 45 __ LDA T1 + 0 
1439 : cd f3 9f CMP $9ff3 ; (i + 0)
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
1462 : 8d f1 9f STA $9ff1 ; (entropy2 + 0)
1465 : ad 22 32 LDA $3222 ; (room_count + 0)
1468 : f0 6f __ BEQ $14d9 ; (can_place_room.s26 + 0)
.s1022:
146a : 85 1b __ STA ACCU + 0 
146c : a6 49 __ LDX T5 + 0 
.l24:
;  38, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
146e : 8e ee 9f STX $9fee ; (entropy4 + 1)
;  39, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1471 : a5 4a __ LDA T7 + 0 
1473 : 8d ed 9f STA $9fed ; (exit2_x + 0)
;  42, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1476 : a9 05 __ LDA #$05
1478 : 8d ec 9f STA $9fec ; (exit2_y + 0)
;  43, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
147b : 8d eb 9f STA $9feb ; (screen_offset + 1)
;  36, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
147e : ad f1 9f LDA $9ff1 ; (entropy2 + 0)
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
14cf : ee f1 9f INC $9ff1 ; (entropy2 + 0)
14d2 : ad f1 9f LDA $9ff1 ; (entropy2 + 0)
14d5 : c5 1b __ CMP ACCU + 0 
14d7 : 90 95 __ BCC $146e ; (can_place_room.l24 + 0)
.s26:
;  54, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
14d9 : a9 01 __ LDA #$01
14db : d0 80 __ BNE $145d ; (can_place_room.s1001 + 0)
--------------------------------------------------------------------
coords_in_bounds: ; coords_in_bounds(u8,u8)->u8
.s0:
; 482, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 482, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
14ed : a9 00 __ LDA #$00
.s1001:
14ef : 60 __ __ RTS
--------------------------------------------------------------------
tile_is_empty: ; tile_is_empty(u8,u8)->u8
.s0:
; 289, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 290, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 264, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 255, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1532 : e8 __ __ INX
.s1013:
1533 : 18 __ __ CLC
1534 : 65 0d __ ADC P0 ; (x + 0)
1536 : 90 01 __ BCC $1539 ; (get_tile_core.s1015 + 0)
.s1014:
; 255, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1538 : e8 __ __ INX
.s1015:
1539 : 18 __ __ CLC
153a : 65 0d __ ADC P0 ; (x + 0)
153c : 8d f8 9f STA $9ff8 ; (room + 1)
153f : 8a __ __ TXA
1540 : 69 00 __ ADC #$00
1542 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 258, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1545 : 4a __ __ LSR
1546 : 85 44 __ STA T1 + 1 
1548 : ad f8 9f LDA $9ff8 ; (room + 1)
154b : 6a __ __ ROR
154c : 46 44 __ LSR T1 + 1 
154e : 6a __ __ ROR
154f : 46 44 __ LSR T1 + 1 
1551 : 6a __ __ ROR
1552 : 18 __ __ CLC
1553 : 69 58 __ ADC #$58
1555 : 85 43 __ STA T1 + 0 
1557 : 8d f6 9f STA $9ff6 ; (dx + 0)
155a : a9 37 __ LDA #$37
155c : 65 44 __ ADC T1 + 1 
155e : 85 44 __ STA T1 + 1 
1560 : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
; 259, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1563 : ad f8 9f LDA $9ff8 ; (room + 1)
1566 : 29 07 __ AND #$07
1568 : 85 1b __ STA ACCU + 0 
156a : 8d f5 9f STA $9ff5 ; (s + 1)
; 264, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
156d : aa __ __ TAX
156e : a0 00 __ LDY #$00
1570 : b1 43 __ LDA (T1 + 0),y 
1572 : e0 00 __ CPX #$00
1574 : f0 04 __ BEQ $157a ; (get_tile_core.s1003 + 0)
.l1002:
; 264, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1576 : 4a __ __ LSR
1577 : ca __ __ DEX
1578 : d0 fc __ BNE $1576 ; (get_tile_core.l1002 + 0)
.s1003:
; 262, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
157a : 85 1c __ STA ACCU + 1 
157c : a5 1b __ LDA ACCU + 0 
157e : c9 06 __ CMP #$06
1580 : b0 05 __ BCS $1587 ; (get_tile_core.s3 + 0)
.s1:
; 264, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1582 : a5 1c __ LDA ACCU + 1 
.s1001:
; 269, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1584 : 29 07 __ AND #$07
1586 : 60 __ __ RTS
.s3:
; 268, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1587 : a9 08 __ LDA #$08
1589 : e5 1b __ SBC ACCU + 0 
158b : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
; 269, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
158e : aa __ __ TAX
158f : bd 56 33 LDA $3356,x ; (bitshift + 36)
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
; 269, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
15d8 : ad 22 32 LDA $3222 ; (room_count + 0)
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
1601 : ee 22 32 INC $3222 ; (room_count + 0)
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
; 301, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 223, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 235, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 226, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1675 : e8 __ __ INX
.s1023:
1676 : 18 __ __ CLC
1677 : 65 0d __ ADC P0 ; (x + 0)
1679 : 90 01 __ BCC $167c ; (set_compact_tile_fast.s1025 + 0)
.s1024:
; 226, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
167b : e8 __ __ INX
.s1025:
167c : 18 __ __ CLC
167d : 65 0d __ ADC P0 ; (x + 0)
167f : 8d f8 9f STA $9ff8 ; (room + 1)
1682 : 8a __ __ TXA
1683 : 69 00 __ ADC #$00
1685 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 229, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1688 : 4a __ __ LSR
1689 : 85 44 __ STA T1 + 1 
168b : ad f8 9f LDA $9ff8 ; (room + 1)
168e : 6a __ __ ROR
168f : 46 44 __ LSR T1 + 1 
1691 : 6a __ __ ROR
1692 : 46 44 __ LSR T1 + 1 
1694 : 6a __ __ ROR
1695 : 18 __ __ CLC
1696 : 69 58 __ ADC #$58
1698 : 85 43 __ STA T1 + 0 
169a : 8d f6 9f STA $9ff6 ; (dx + 0)
169d : a9 37 __ LDA #$37
169f : 65 44 __ ADC T1 + 1 
16a1 : 85 44 __ STA T1 + 1 
16a3 : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
; 230, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16a6 : ad f8 9f LDA $9ff8 ; (room + 1)
16a9 : 29 07 __ AND #$07
16ab : 85 1b __ STA ACCU + 0 
16ad : 8d f5 9f STA $9ff5 ; (s + 1)
; 235, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 237, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16c2 : aa __ __ TAX
16c3 : bd 17 32 LDA $3217,x ; (__shltab7L + 0)
16c6 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
; 238, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
; 238, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16d9 : 05 1c __ ORA ACCU + 1 
.s1017:
; 248, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16db : 91 43 __ STA (T1 + 0),y 
16dd : 60 __ __ RTS
.s7:
; 241, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16de : a9 08 __ LDA #$08
16e0 : e5 1b __ SBC ACCU + 0 
16e2 : 85 1e __ STA ACCU + 3 
16e4 : 8d f3 9f STA $9ff3 ; (i + 0)
; 242, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16e7 : aa __ __ TAX
16e8 : 49 03 __ EOR #$03
16ea : 85 45 __ STA T5 + 0 
16ec : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
; 244, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16ef : bd 3a 33 LDA $333a,x ; (bitshift + 8)
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
; 244, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16ff : 85 47 __ STA T7 + 0 
1701 : 8d f1 9f STA $9ff1 ; (entropy2 + 0)
; 245, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1704 : a6 45 __ LDX T5 + 0 
1706 : bd 3a 33 LDA $333a,x ; (bitshift + 8)
1709 : 38 __ __ SEC
170a : e9 01 __ SBC #$01
170c : 85 45 __ STA T5 + 0 
170e : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
; 247, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1711 : a5 1d __ LDA ACCU + 2 
1713 : 25 46 __ AND T6 + 0 
1715 : a6 1b __ LDX ACCU + 0 
1717 : f0 04 __ BEQ $171d ; (set_compact_tile_fast.s1005 + 0)
.l1012:
1719 : 0a __ __ ASL
171a : ca __ __ DEX
171b : d0 fc __ BNE $1719 ; (set_compact_tile_fast.l1012 + 0)
.s1005:
; 247, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
171d : 85 46 __ STA T6 + 0 
171f : a9 ff __ LDA #$ff
1721 : 45 47 __ EOR T7 + 0 
1723 : 25 1c __ AND ACCU + 1 
1725 : 05 46 __ ORA T6 + 0 
1727 : 91 43 __ STA (T1 + 0),y 
; 248, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
1747 : ad 22 32 LDA $3222 ; (room_count + 0)
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
; 360, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
178a : a9 00 __ LDA #$00
178c : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
178f : ad 22 32 LDA $3222 ; (room_count + 0)
1792 : f0 64 __ BEQ $17f8 ; (init_room_center_cache.s4 + 0)
.l5:
1794 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
1797 : c9 14 __ CMP #$14
1799 : b0 5d __ BCS $17f8 ; (init_room_center_cache.s4 + 0)
.s2:
; 362, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
17c5 : 99 78 40 STA $4078,y ; (room_center_cache + 0)
; 363, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
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
17ea : 9d 79 40 STA $4079,x ; (room_center_cache + 1)
; 360, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
17ed : ee f9 9f INC $9ff9 ; (bit_offset + 1)
17f0 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
17f3 : cd 22 32 CMP $3222 ; (room_count + 0)
17f6 : 90 9c __ BCC $1794 ; (init_room_center_cache.l5 + 0)
.s4:
; 365, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
17f8 : a9 01 __ LDA #$01
17fa : 8d 23 32 STA $3223 ; (room_center_cache_valid + 0)
.s1001:
; 366, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
17fd : 60 __ __ RTS
--------------------------------------------------------------------
update_camera: ; update_camera()->void
.s0:
;  49, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
17fe : ad 6c 33 LDA $336c ; (view + 0)
1801 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
;  50, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1804 : ad 6d 33 LDA $336d ; (view + 1)
1807 : 8d f8 9f STA $9ff8 ; (room + 1)
;  52, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
180a : ad 6b 33 LDA $336b ; (camera_center_y + 0)
180d : 8d f6 9f STA $9ff6 ; (dx + 0)
;  51, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1810 : ad 6a 33 LDA $336a ; (camera_center_x + 0)
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
1820 : 8d 6c 33 STA $336c ; (view + 0)
;  61, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1823 : ad 6b 33 LDA $336b ; (camera_center_y + 0)
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
1830 : 8d 6d 33 STA $336d ; (view + 1)
;  68, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1833 : a9 18 __ LDA #$18
1835 : cd 6c 33 CMP $336c ; (view + 0)
1838 : b0 03 __ BCS $183d ; (update_camera.s20 + 0)
.s7:
;  69, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
183a : 8d 6c 33 STA $336c ; (view + 0)
.s20:
;  71, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
183d : a9 27 __ LDA #$27
183f : cd 6d 33 CMP $336d ; (view + 1)
1842 : b0 03 __ BCS $1847 ; (update_camera.s12 + 0)
.s10:
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1844 : 8d 6d 33 STA $336d ; (view + 1)
.s12:
;  77, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1847 : ad 6c 33 LDA $336c ; (view + 0)
184a : 18 __ __ CLC
184b : 69 14 __ ADC #$14
184d : 8d 6a 33 STA $336a ; (camera_center_x + 0)
;  78, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1850 : ad 6d 33 LDA $336d ; (view + 1)
1853 : 18 __ __ CLC
1854 : 69 0c __ ADC #$0c
1856 : 8d 6b 33 STA $336b ; (camera_center_y + 0)
;  81, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1859 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
185c : cd 6c 33 CMP $336c ; (view + 0)
185f : d0 08 __ BNE $1869 ; (update_camera.s13 + 0)
.s16:
1861 : ad f8 9f LDA $9ff8 ; (room + 1)
1864 : cd 6d 33 CMP $336d ; (view + 1)
1867 : f0 05 __ BEQ $186e ; (update_camera.s1001 + 0)
.s13:
;  82, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1869 : a9 01 __ LDA #$01
186b : 8d 56 37 STA $3756 ; (screen_dirty + 0)
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
; 475, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1891 : a5 0d __ LDA P0 ; (room1 + 0)
1893 : cd 22 32 CMP $3222 ; (room_count + 0)
1896 : b0 07 __ BCS $189f ; (rooms_are_connected.s1 + 0)
.s4:
1898 : a4 0e __ LDY P1 ; (room2 + 0)
; 475, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
189a : cc 22 32 CPY $3222 ; (room_count + 0)
189d : 90 03 __ BCC $18a2 ; (rooms_are_connected.s3 + 0)
.s1:
189f : a9 00 __ LDA #$00
18a1 : 60 __ __ RTS
.s3:
; 476, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
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
18af : 69 58 __ ADC #$58
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
;  69, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18bc : a5 17 __ LDA P10 ; (room1 + 0)
18be : cd 22 32 CMP $3222 ; (room_count + 0)
18c1 : b0 1f __ BCS $18e2 ; (can_connect_rooms_safely.s1 + 0)
.s5:
18c3 : a5 18 __ LDA P11 ; (room2 + 0)
18c5 : cd 22 32 CMP $3222 ; (room_count + 0)
18c8 : b0 18 __ BCS $18e2 ; (can_connect_rooms_safely.s1 + 0)
.s4:
18ca : a5 17 __ LDA P10 ; (room1 + 0)
18cc : c5 18 __ CMP P11 ; (room2 + 0)
18ce : f0 12 __ BEQ $18e2 ; (can_connect_rooms_safely.s1 + 0)
.s3:
;  74, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18d0 : 85 15 __ STA P8 
18d2 : a5 18 __ LDA P11 ; (room2 + 0)
18d4 : 85 16 __ STA P9 
18d6 : 20 73 19 JSR $1973 ; (get_cached_room_distance.s0 + 0)
18d9 : a5 1b __ LDA ACCU + 0 
18db : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
;  75, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18de : c9 1f __ CMP #$1f
18e0 : 90 05 __ BCC $18e7 ; (can_connect_rooms_safely.s9 + 0)
.s1:
;  70, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18e2 : a9 00 __ LDA #$00
18e4 : 4c 70 19 JMP $1970 ; (can_connect_rooms_safely.s1001 + 0)
.s9:
;  80, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18e7 : a5 17 __ LDA P10 ; (room1 + 0)
18e9 : 0a __ __ ASL
18ea : 0a __ __ ASL
18eb : 0a __ __ ASL
18ec : aa __ __ TAX
18ed : bd 00 41 LDA $4100,x ; (rooms + 0)
18f0 : 38 __ __ SEC
18f1 : e9 04 __ SBC #$04
18f3 : 8d f3 9f STA $9ff3 ; (i + 0)
;  81, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18f6 : bd 01 41 LDA $4101,x ; (rooms + 1)
18f9 : 38 __ __ SEC
18fa : e9 04 __ SBC #$04
18fc : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
;  82, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18ff : bd 02 41 LDA $4102,x ; (rooms + 2)
1902 : 18 __ __ CLC
1903 : 7d 00 41 ADC $4100,x ; (rooms + 0)
1906 : 18 __ __ CLC
1907 : 69 04 __ ADC #$04
1909 : 8d f1 9f STA $9ff1 ; (entropy2 + 0)
;  83, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
190c : bd 03 41 LDA $4103,x ; (rooms + 3)
190f : 18 __ __ CLC
1910 : 7d 01 41 ADC $4101,x ; (rooms + 1)
1913 : 18 __ __ CLC
1914 : 69 04 __ ADC #$04
1916 : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
;  84, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1919 : a5 18 __ LDA P11 ; (room2 + 0)
191b : 0a __ __ ASL
191c : 0a __ __ ASL
191d : 0a __ __ ASL
191e : aa __ __ TAX
191f : bd 00 41 LDA $4100,x ; (rooms + 0)
1922 : 38 __ __ SEC
1923 : e9 04 __ SBC #$04
1925 : 8d ef 9f STA $9fef ; (screen_pos + 1)
;  85, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1928 : bd 01 41 LDA $4101,x ; (rooms + 1)
192b : 38 __ __ SEC
192c : e9 04 __ SBC #$04
192e : 8d ee 9f STA $9fee ; (entropy4 + 1)
;  86, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1931 : bd 02 41 LDA $4102,x ; (rooms + 2)
1934 : 18 __ __ CLC
1935 : 7d 00 41 ADC $4100,x ; (rooms + 0)
1938 : 18 __ __ CLC
1939 : 69 04 __ ADC #$04
193b : 8d ed 9f STA $9fed ; (exit2_x + 0)
;  87, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
193e : bd 03 41 LDA $4103,x ; (rooms + 3)
1941 : 18 __ __ CLC
1942 : 7d 01 41 ADC $4101,x ; (rooms + 1)
1945 : 18 __ __ CLC
1946 : 69 04 __ ADC #$04
1948 : 8d ec 9f STA $9fec ; (exit2_y + 0)
;  90, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
194b : ad ef 9f LDA $9fef ; (screen_pos + 1)
194e : cd f1 9f CMP $9ff1 ; (entropy2 + 0)
1951 : b0 1b __ BCS $196e ; (can_connect_rooms_safely.s13 + 0)
.s16:
1953 : ad f3 9f LDA $9ff3 ; (i + 0)
1956 : cd ed 9f CMP $9fed ; (exit2_x + 0)
1959 : b0 13 __ BCS $196e ; (can_connect_rooms_safely.s13 + 0)
.s15:
;  91, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
195b : ad ee 9f LDA $9fee ; (entropy4 + 1)
195e : cd f0 9f CMP $9ff0 ; (entropy3 + 1)
1961 : b0 0b __ BCS $196e ; (can_connect_rooms_safely.s13 + 0)
.s14:
1963 : ad f2 9f LDA $9ff2 ; (entropy2 + 1)
1966 : cd ec 9f CMP $9fec ; (exit2_y + 0)
1969 : a9 00 __ LDA #$00
196b : 2a __ __ ROL
196c : 90 02 __ BCC $1970 ; (can_connect_rooms_safely.s1001 + 0)
.s13:
;  95, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
196e : a9 01 __ LDA #$01
.s1001:
1970 : 85 1b __ STA ACCU + 0 
1972 : 60 __ __ RTS
--------------------------------------------------------------------
get_cached_room_distance: ; get_cached_room_distance(u8,u8)->u8
.s0:
;  46, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1973 : ad 2f 33 LDA $332f ; (distance_cache_valid + 0)
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
;  47, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
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
;  50, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
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
19a0 : 69 e8 __ ADC #$e8
19a2 : 85 45 __ STA T0 + 0 
19a4 : 8a __ __ TXA
19a5 : 69 3e __ ADC #$3e
19a7 : 85 46 __ STA T0 + 1 
19a9 : a4 16 __ LDY P9 ; (room2 + 0)
19ab : b1 45 __ LDA (T0 + 0),y 
19ad : 8d f5 9f STA $9ff5 ; (s + 1)
;  51, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
19b0 : c9 ff __ CMP #$ff
19b2 : d0 db __ BNE $198f ; (get_cached_room_distance.s1001 + 0)
.s9:
;  56, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
19b4 : 84 14 __ STY P7 
19b6 : a5 15 __ LDA P8 ; (room1 + 0)
19b8 : 85 13 __ STA P6 
19ba : 20 08 0d JSR $0d08 ; (calculate_room_distance.s0 + 0)
;  57, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
19bd : a4 16 __ LDY P9 ; (room2 + 0)
19bf : 91 45 __ STA (T0 + 0),y 
;  56, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
19c1 : 8d f5 9f STA $9ff5 ; (s + 1)
19c4 : aa __ __ TAX
;  58, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
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
19d2 : 69 e8 __ ADC #$e8
19d4 : 85 45 __ STA T0 + 0 
19d6 : 98 __ __ TYA
19d7 : 69 3e __ ADC #$3e
19d9 : 85 46 __ STA T0 + 1 
19db : 8a __ __ TXA
19dc : a4 15 __ LDY P8 ; (room1 + 0)
19de : 91 45 __ STA (T0 + 0),y 
;  60, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
19e0 : 4c 8f 19 JMP $198f ; (get_cached_room_distance.s1001 + 0)
--------------------------------------------------------------------
rule_based_connect_rooms: ; rule_based_connect_rooms(u8,u8)->u8
.s1000:
19e3 : a2 03 __ LDX #$03
19e5 : b5 53 __ LDA T5 + 0,x 
19e7 : 9d 95 9f STA $9f95,x ; (rule_based_connect_rooms@stack + 0)
19ea : ca __ __ DEX
19eb : 10 f8 __ BPL $19e5 ; (rule_based_connect_rooms.s1000 + 2)
.s0:
; 399, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
19ed : ad fe 9f LDA $9ffe ; (sstack + 4)
19f0 : 85 55 __ STA T8 + 0 
19f2 : 85 17 __ STA P10 
19f4 : ad ff 9f LDA $9fff ; (sstack + 5)
19f7 : 85 56 __ STA T9 + 0 
19f9 : 85 18 __ STA P11 
19fb : 20 bc 18 JSR $18bc ; (can_connect_rooms_safely.s0 + 0)
19fe : a5 1b __ LDA ACCU + 0 
1a00 : f0 79 __ BEQ $1a7b ; (rule_based_connect_rooms.s1001 + 0)
.s3:
; 404, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a02 : a5 55 __ LDA T8 + 0 
1a04 : 0a __ __ ASL
1a05 : 0a __ __ ASL
1a06 : 65 55 __ ADC T8 + 0 
1a08 : 0a __ __ ASL
1a09 : 0a __ __ ASL
1a0a : a2 00 __ LDX #$00
1a0c : 90 01 __ BCC $1a0f ; (rule_based_connect_rooms.s1009 + 0)
.s1008:
1a0e : e8 __ __ INX
.s1009:
1a0f : 18 __ __ CLC
1a10 : 69 58 __ ADC #$58
1a12 : 85 53 __ STA T5 + 0 
1a14 : 8a __ __ TXA
1a15 : 69 3d __ ADC #$3d
1a17 : 85 54 __ STA T5 + 1 
1a19 : a4 56 __ LDY T9 + 0 
1a1b : b1 53 __ LDA (T5 + 0),y 
1a1d : d0 5a __ BNE $1a79 ; (rule_based_connect_rooms.s5 + 0)
.s7:
; 413, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a1f : a6 55 __ LDX T8 + 0 
1a21 : 8e a0 9f STX $9fa0 ; (stack + 0)
1a24 : a2 01 __ LDX #$01
1a26 : 8e 9f 9f STX $9f9f ; (sp + 0)
; 410, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a29 : a2 13 __ LDX #$13
.l1004:
1a2b : 9d b4 9f STA $9fb4,x ; (visited + 0)
1a2e : ca __ __ DEX
1a2f : 10 fa __ BPL $1a2b ; (rule_based_connect_rooms.l1004 + 0)
.s1003:
; 414, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a31 : a9 01 __ LDA #$01
1a33 : a6 55 __ LDX T8 + 0 
1a35 : 9d b4 9f STA $9fb4,x ; (visited + 0)
.l10:
; 417, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a38 : a9 00 __ LDA #$00
1a3a : 8d 9d 9f STA $9f9d ; (i + 0)
; 416, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a3d : ae 9f 9f LDX $9f9f ; (sp + 0)
1a40 : ce 9f 9f DEC $9f9f ; (sp + 0)
1a43 : bd 9f 9f LDA $9f9f,x ; (sp + 0)
1a46 : 8d 9e 9f STA $9f9e ; (current + 0)
; 417, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a49 : ad 22 32 LDA $3222 ; (room_count + 0)
1a4c : f0 51 __ BEQ $1a9f ; (rule_based_connect_rooms.s9 + 0)
.s42:
; 418, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a4e : 85 49 __ STA T6 + 0 
1a50 : bd 9f 9f LDA $9f9f,x ; (sp + 0)
1a53 : 0a __ __ ASL
1a54 : 0a __ __ ASL
1a55 : 7d 9f 9f ADC $9f9f,x ; (sp + 0)
1a58 : 0a __ __ ASL
1a59 : 0a __ __ ASL
1a5a : a2 00 __ LDX #$00
1a5c : 90 01 __ BCC $1a5f ; (rule_based_connect_rooms.s1011 + 0)
.s1010:
1a5e : e8 __ __ INX
.s1011:
1a5f : 18 __ __ CLC
1a60 : 69 58 __ ADC #$58
1a62 : 85 43 __ STA T0 + 0 
1a64 : 8a __ __ TXA
1a65 : 69 3d __ ADC #$3d
1a67 : 85 44 __ STA T0 + 1 
.l13:
1a69 : ac 9d 9f LDY $9f9d ; (i + 0)
1a6c : b1 43 __ LDA (T0 + 0),y 
1a6e : f0 27 __ BEQ $1a97 ; (rule_based_connect_rooms.s12 + 0)
.s19:
1a70 : b9 b4 9f LDA $9fb4,y ; (visited + 0)
1a73 : d0 22 __ BNE $1a97 ; (rule_based_connect_rooms.s12 + 0)
.s16:
; 419, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a75 : c4 56 __ CPY T9 + 0 
1a77 : d0 0f __ BNE $1a88 ; (rule_based_connect_rooms.s22 + 0)
.s5:
; 405, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a79 : a9 01 __ LDA #$01
.s1001:
; 400, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a7b : 85 1b __ STA ACCU + 0 
1a7d : a2 03 __ LDX #$03
1a7f : bd 95 9f LDA $9f95,x ; (rule_based_connect_rooms@stack + 0)
1a82 : 95 53 __ STA T5 + 0,x 
1a84 : ca __ __ DEX
1a85 : 10 f8 __ BPL $1a7f ; (rule_based_connect_rooms.s1001 + 4)
1a87 : 60 __ __ RTS
.s22:
; 422, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a88 : a9 01 __ LDA #$01
1a8a : 99 b4 9f STA $9fb4,y ; (visited + 0)
; 423, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a8d : ae 9f 9f LDX $9f9f ; (sp + 0)
1a90 : ee 9f 9f INC $9f9f ; (sp + 0)
1a93 : 98 __ __ TYA
1a94 : 9d a0 9f STA $9fa0,x ; (stack + 0)
.s12:
; 417, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a97 : c8 __ __ INY
1a98 : 8c 9d 9f STY $9f9d ; (i + 0)
1a9b : c4 49 __ CPY T6 + 0 
1a9d : 90 ca __ BCC $1a69 ; (rule_based_connect_rooms.l13 + 0)
.s9:
; 415, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a9f : ad 9f 9f LDA $9f9f ; (sp + 0)
1aa2 : d0 94 __ BNE $1a38 ; (rule_based_connect_rooms.l10 + 0)
.s11:
; 429, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1aa4 : a5 55 __ LDA T8 + 0 
1aa6 : 85 13 __ STA P6 
1aa8 : a5 56 __ LDA T9 + 0 
1aaa : 85 14 __ STA P7 
1aac : 20 f9 1a JSR $1af9 ; (can_reuse_existing_path.s0 + 0)
1aaf : a5 1b __ LDA ACCU + 0 
1ab1 : f0 11 __ BEQ $1ac4 ; (rule_based_connect_rooms.s26 + 0)
.s24:
; 430, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ab3 : a5 13 __ LDA P6 
1ab5 : 8d fc 9f STA $9ffc ; (sstack + 2)
1ab8 : a5 14 __ LDA P7 
1aba : 8d fd 9f STA $9ffd ; (sstack + 3)
1abd : 20 fa 1c JSR $1cfa ; (connect_via_existing_corridors.s0 + 0)
1ac0 : a5 1b __ LDA ACCU + 0 
1ac2 : d0 10 __ BNE $1ad4 ; (rule_based_connect_rooms.s27 + 0)
.s26:
; 437, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ac4 : a5 55 __ LDA T8 + 0 
1ac6 : 8d fc 9f STA $9ffc ; (sstack + 2)
1ac9 : a5 56 __ LDA T9 + 0 
1acb : 8d fd 9f STA $9ffd ; (sstack + 3)
1ace : 20 0c 24 JSR $240c ; (draw_rule_based_corridor.s0 + 0)
1ad1 : aa __ __ TAX
1ad2 : f0 a7 __ BEQ $1a7b ; (rule_based_connect_rooms.s1001 + 0)
.s27:
; 431, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ad4 : a9 01 __ LDA #$01
1ad6 : a4 56 __ LDY T9 + 0 
1ad8 : 91 53 __ STA (T5 + 0),y 
; 432, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ada : 98 __ __ TYA
1adb : 0a __ __ ASL
1adc : 0a __ __ ASL
1add : 65 56 __ ADC T9 + 0 
1adf : 0a __ __ ASL
1ae0 : 0a __ __ ASL
1ae1 : a2 00 __ LDX #$00
1ae3 : 90 01 __ BCC $1ae6 ; (rule_based_connect_rooms.s1013 + 0)
.s1012:
1ae5 : e8 __ __ INX
.s1013:
1ae6 : 18 __ __ CLC
1ae7 : 69 58 __ ADC #$58
1ae9 : 85 43 __ STA T0 + 0 
1aeb : 8a __ __ TXA
1aec : 69 3d __ ADC #$3d
1aee : 85 44 __ STA T0 + 1 
1af0 : a9 01 __ LDA #$01
1af2 : a4 55 __ LDY T8 + 0 
1af4 : 91 43 __ STA (T0 + 0),y 
; 433, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1af6 : 4c 7b 1a JMP $1a7b ; (rule_based_connect_rooms.s1001 + 0)
--------------------------------------------------------------------
can_reuse_existing_path: ; can_reuse_existing_path(u8,u8)->u8
.s0:
; 229, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1af9 : a5 13 __ LDA P6 ; (room1 + 0)
1afb : 85 0d __ STA P0 
1afd : a9 f3 __ LDA #$f3
1aff : 85 0e __ STA P1 
1b01 : a9 9f __ LDA #$9f
1b03 : 85 11 __ STA P4 
1b05 : a9 9f __ LDA #$9f
1b07 : 85 0f __ STA P2 
1b09 : a9 f2 __ LDA #$f2
1b0b : 85 10 __ STA P3 
1b0d : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 230, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b10 : a5 14 __ LDA P7 ; (room2 + 0)
1b12 : 85 0d __ STA P0 
1b14 : a9 f1 __ LDA #$f1
1b16 : 85 0e __ STA P1 
1b18 : a9 9f __ LDA #$9f
1b1a : 85 11 __ STA P4 
1b1c : a9 9f __ LDA #$9f
1b1e : 85 0f __ STA P2 
1b20 : a9 f0 __ LDA #$f0
1b22 : 85 10 __ STA P3 
1b24 : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 234, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b27 : a9 00 __ LDA #$00
1b29 : 8d ef 9f STA $9fef ; (screen_pos + 1)
1b2c : 8d ee 9f STA $9fee ; (entropy4 + 1)
; 237, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b2f : a9 fc __ LDA #$fc
1b31 : 8d ed 9f STA $9fed ; (exit2_x + 0)
.l2:
; 238, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b34 : a9 fc __ LDA #$fc
1b36 : 8d ec 9f STA $9fec ; (exit2_y + 0)
1b39 : ad ef 9f LDA $9fef ; (screen_pos + 1)
1b3c : d0 59 __ BNE $1b97 ; (can_reuse_existing_path.s3 + 0)
.l7:
; 239, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b3e : ad ed 9f LDA $9fed ; (exit2_x + 0)
1b41 : 18 __ __ CLC
1b42 : 6d f3 9f ADC $9ff3 ; (i + 0)
1b45 : 85 46 __ STA T2 + 0 
1b47 : 85 0d __ STA P0 
1b49 : 8d eb 9f STA $9feb ; (screen_offset + 1)
; 240, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b4c : ad ec 9f LDA $9fec ; (exit2_y + 0)
1b4f : 85 47 __ STA T3 + 0 
1b51 : 18 __ __ CLC
1b52 : 6d f2 9f ADC $9ff2 ; (entropy2 + 1)
1b55 : 85 45 __ STA T0 + 0 
1b57 : 85 0e __ STA P1 
1b59 : 8d ea 9f STA $9fea ; (x + 0)
; 242, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b5c : 20 3f 1c JSR $1c3f ; (coords_in_bounds_fast.s0 + 0)
1b5f : aa __ __ TAX
1b60 : f0 22 __ BEQ $1b84 ; (can_reuse_existing_path.s6 + 0)
.s15:
; 243, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b62 : a5 0d __ LDA P0 
1b64 : 85 11 __ STA P4 
1b66 : a5 0e __ LDA P1 
1b68 : 85 12 __ STA P5 
1b6a : 20 52 1c JSR $1c52 ; (tile_is_floor_fast.s0 + 0)
1b6d : a5 1b __ LDA ACCU + 0 
1b6f : f0 13 __ BEQ $1b84 ; (can_reuse_existing_path.s6 + 0)
.s14:
; 244, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b71 : a5 46 __ LDA T2 + 0 
1b73 : 85 0f __ STA P2 
1b75 : a5 45 __ LDA T0 + 0 
1b77 : 85 10 __ STA P3 
1b79 : 20 96 1c JSR $1c96 ; (is_outside_any_room.s0 + 0)
1b7c : aa __ __ TAX
1b7d : f0 05 __ BEQ $1b84 ; (can_reuse_existing_path.s6 + 0)
.s11:
; 245, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b7f : a9 01 __ LDA #$01
1b81 : 8d ef 9f STA $9fef ; (screen_pos + 1)
.s6:
; 238, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b84 : 18 __ __ CLC
1b85 : a5 47 __ LDA T3 + 0 
1b87 : 69 01 __ ADC #$01
1b89 : 8d ec 9f STA $9fec ; (exit2_y + 0)
1b8c : 30 04 __ BMI $1b92 ; (can_reuse_existing_path.s10 + 0)
.s1007:
1b8e : c9 05 __ CMP #$05
1b90 : b0 05 __ BCS $1b97 ; (can_reuse_existing_path.s3 + 0)
.s10:
; 238, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b92 : ad ef 9f LDA $9fef ; (screen_pos + 1)
1b95 : f0 a7 __ BEQ $1b3e ; (can_reuse_existing_path.l7 + 0)
.s3:
; 237, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b97 : ad ed 9f LDA $9fed ; (exit2_x + 0)
1b9a : ee ed 9f INC $9fed ; (exit2_x + 0)
1b9d : 49 80 __ EOR #$80
1b9f : c9 84 __ CMP #$84
1ba1 : ad ef 9f LDA $9fef ; (screen_pos + 1)
1ba4 : 90 03 __ BCC $1ba9 ; (can_reuse_existing_path.s5 + 0)
1ba6 : 4c 3a 1c JMP $1c3a ; (can_reuse_existing_path.s4 + 0)
.s5:
1ba9 : f0 89 __ BEQ $1b34 ; (can_reuse_existing_path.l2 + 0)
.s18:
; 254, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bab : 85 47 __ STA T3 + 0 
1bad : a9 fc __ LDA #$fc
1baf : 8d e9 9f STA $9fe9 ; (room2_center_x + 0)
1bb2 : ad ee 9f LDA $9fee ; (entropy4 + 1)
1bb5 : d0 75 __ BNE $1c2c ; (can_reuse_existing_path.s23 + 0)
.l21:
; 255, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bb7 : a9 fc __ LDA #$fc
1bb9 : 8d e8 9f STA $9fe8 ; (up_y + 0)
1bbc : ad ee 9f LDA $9fee ; (entropy4 + 1)
1bbf : d0 59 __ BNE $1c1a ; (can_reuse_existing_path.s22 + 0)
.l26:
; 256, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bc1 : ad e9 9f LDA $9fe9 ; (room2_center_x + 0)
1bc4 : 18 __ __ CLC
1bc5 : 6d f1 9f ADC $9ff1 ; (entropy2 + 0)
1bc8 : 85 46 __ STA T2 + 0 
1bca : 85 0d __ STA P0 
1bcc : 8d e7 9f STA $9fe7 ; (dx + 1)
; 257, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bcf : ad e8 9f LDA $9fe8 ; (up_y + 0)
1bd2 : 85 48 __ STA T4 + 0 
1bd4 : 18 __ __ CLC
1bd5 : 6d f0 9f ADC $9ff0 ; (entropy3 + 1)
1bd8 : 85 45 __ STA T0 + 0 
1bda : 85 0e __ STA P1 
1bdc : 8d e6 9f STA $9fe6 ; (check_y + 0)
; 259, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bdf : 20 3f 1c JSR $1c3f ; (coords_in_bounds_fast.s0 + 0)
1be2 : aa __ __ TAX
1be3 : f0 22 __ BEQ $1c07 ; (can_reuse_existing_path.s25 + 0)
.s34:
; 260, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1be5 : a5 0d __ LDA P0 
1be7 : 85 11 __ STA P4 
1be9 : a5 0e __ LDA P1 
1beb : 85 12 __ STA P5 
1bed : 20 52 1c JSR $1c52 ; (tile_is_floor_fast.s0 + 0)
1bf0 : a5 1b __ LDA ACCU + 0 
1bf2 : f0 13 __ BEQ $1c07 ; (can_reuse_existing_path.s25 + 0)
.s33:
; 261, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bf4 : a5 46 __ LDA T2 + 0 
1bf6 : 85 0f __ STA P2 
1bf8 : a5 45 __ LDA T0 + 0 
1bfa : 85 10 __ STA P3 
1bfc : 20 96 1c JSR $1c96 ; (is_outside_any_room.s0 + 0)
1bff : aa __ __ TAX
1c00 : f0 05 __ BEQ $1c07 ; (can_reuse_existing_path.s25 + 0)
.s30:
; 262, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c02 : a9 01 __ LDA #$01
1c04 : 8d ee 9f STA $9fee ; (entropy4 + 1)
.s25:
; 255, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c07 : 18 __ __ CLC
1c08 : a5 48 __ LDA T4 + 0 
1c0a : 69 01 __ ADC #$01
1c0c : 8d e8 9f STA $9fe8 ; (up_y + 0)
1c0f : 30 04 __ BMI $1c15 ; (can_reuse_existing_path.s29 + 0)
.s1006:
1c11 : c9 05 __ CMP #$05
1c13 : b0 05 __ BCS $1c1a ; (can_reuse_existing_path.s22 + 0)
.s29:
; 255, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c15 : ad ee 9f LDA $9fee ; (entropy4 + 1)
1c18 : f0 a7 __ BEQ $1bc1 ; (can_reuse_existing_path.l26 + 0)
.s22:
; 254, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c1a : ad e9 9f LDA $9fe9 ; (room2_center_x + 0)
1c1d : ee e9 9f INC $9fe9 ; (room2_center_x + 0)
1c20 : aa __ __ TAX
1c21 : 30 04 __ BMI $1c27 ; (can_reuse_existing_path.s24 + 0)
.s1005:
1c23 : c9 04 __ CMP #$04
1c25 : b0 05 __ BCS $1c2c ; (can_reuse_existing_path.s23 + 0)
.s24:
; 254, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c27 : ad ee 9f LDA $9fee ; (entropy4 + 1)
1c2a : f0 8b __ BEQ $1bb7 ; (can_reuse_existing_path.l21 + 0)
.s23:
; 268, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c2c : a5 47 __ LDA T3 + 0 
1c2e : f0 07 __ BEQ $1c37 ; (can_reuse_existing_path.s1001 + 0)
.s38:
1c30 : ad ee 9f LDA $9fee ; (entropy4 + 1)
1c33 : f0 02 __ BEQ $1c37 ; (can_reuse_existing_path.s1001 + 0)
.s35:
1c35 : a9 01 __ LDA #$01
.s1001:
; 251, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c37 : 85 1b __ STA ACCU + 0 
1c39 : 60 __ __ RTS
.s4:
1c3a : f0 fb __ BEQ $1c37 ; (can_reuse_existing_path.s1001 + 0)
1c3c : 4c ab 1b JMP $1bab ; (can_reuse_existing_path.s18 + 0)
--------------------------------------------------------------------
coords_in_bounds_fast: ; coords_in_bounds_fast(u8,u8)->u8
.s0:
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen_utility.h"
1c3f : a5 0d __ LDA P0 ; (x + 0)
1c41 : c9 40 __ CMP #$40
1c43 : b0 0a __ BCS $1c4f ; (coords_in_bounds_fast.s2 + 0)
.s4:
1c45 : a5 0e __ LDA P1 ; (y + 0)
1c47 : c9 40 __ CMP #$40
1c49 : a9 00 __ LDA #$00
1c4b : 2a __ __ ROL
1c4c : 49 01 __ EOR #$01
1c4e : 60 __ __ RTS
.s2:
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen_utility.h"
1c4f : a9 00 __ LDA #$00
.s1001:
1c51 : 60 __ __ RTS
--------------------------------------------------------------------
tile_is_floor_fast: ; tile_is_floor_fast(u8,u8)->u8
.s0:
;  37, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen_utility.h"
1c52 : a5 11 __ LDA P4 ; (x + 0)
1c54 : 85 0d __ STA P0 
1c56 : a5 12 __ LDA P5 ; (y + 0)
1c58 : 85 0e __ STA P1 
1c5a : 20 3f 1c JSR $1c3f ; (coords_in_bounds_fast.s0 + 0)
1c5d : aa __ __ TAX
1c5e : f0 17 __ BEQ $1c77 ; (tile_is_floor_fast.s1001 + 0)
.s3:
;  38, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen_utility.h"
1c60 : a5 11 __ LDA P4 ; (x + 0)
1c62 : 85 0f __ STA P2 
1c64 : a5 12 __ LDA P5 ; (y + 0)
1c66 : 85 10 __ STA P3 
1c68 : 20 7a 1c JSR $1c7a ; (get_tile_raw.s0 + 0)
1c6b : a5 1b __ LDA ACCU + 0 
1c6d : c9 02 __ CMP #$02
1c6f : d0 04 __ BNE $1c75 ; (tile_is_floor_fast.s1003 + 0)
.s1002:
1c71 : a9 01 __ LDA #$01
1c73 : d0 02 __ BNE $1c77 ; (tile_is_floor_fast.s1001 + 0)
.s1003:
1c75 : a9 00 __ LDA #$00
.s1001:
;  37, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen_utility.h"
1c77 : 85 1b __ STA ACCU + 0 
1c79 : 60 __ __ RTS
--------------------------------------------------------------------
get_tile_raw: ; get_tile_raw(u8,u8)->u8
.s0:
; 296, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1c7a : a5 0f __ LDA P2 ; (x + 0)
1c7c : c9 40 __ CMP #$40
1c7e : b0 06 __ BCS $1c86 ; (get_tile_raw.s1 + 0)
.s4:
1c80 : a5 10 __ LDA P3 ; (y + 0)
1c82 : c9 40 __ CMP #$40
1c84 : 90 04 __ BCC $1c8a ; (get_tile_raw.s3 + 0)
.s1:
1c86 : a9 00 __ LDA #$00
1c88 : b0 09 __ BCS $1c93 ; (get_tile_raw.s1001 + 0)
.s3:
; 297, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1c8a : 85 0e __ STA P1 
1c8c : a5 0f __ LDA P2 ; (x + 0)
1c8e : 85 0d __ STA P0 
1c90 : 20 14 15 JSR $1514 ; (get_tile_core.s0 + 0)
.s1001:
1c93 : 85 1b __ STA ACCU + 0 
1c95 : 60 __ __ RTS
--------------------------------------------------------------------
is_outside_any_room: ; is_outside_any_room(u8,u8)->u8
.s0:
; 143, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1c96 : a5 0f __ LDA P2 ; (x + 0)
1c98 : 85 0d __ STA P0 
1c9a : a5 10 __ LDA P3 ; (y + 0)
1c9c : 85 0e __ STA P1 
1c9e : 20 aa 1c JSR $1caa ; (is_inside_room.s0 + 0)
1ca1 : c9 01 __ CMP #$01
1ca3 : a9 00 __ LDA #$00
1ca5 : 69 ff __ ADC #$ff
1ca7 : 29 01 __ AND #$01
.s1001:
1ca9 : 60 __ __ RTS
--------------------------------------------------------------------
is_inside_room: ; is_inside_room(u8,u8)->u8
.s0:
; 132, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1caa : a9 00 __ LDA #$00
1cac : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
1caf : ad 22 32 LDA $3222 ; (room_count + 0)
1cb2 : f0 40 __ BEQ $1cf4 ; (is_inside_room.s4 + 0)
.s1008:
1cb4 : 85 1c __ STA ACCU + 1 
1cb6 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
1cb9 : a4 0d __ LDY P0 ; (x + 0)
.l2:
; 133, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1cbb : 0a __ __ ASL
1cbc : 0a __ __ ASL
1cbd : 0a __ __ ASL
1cbe : aa __ __ TAX
1cbf : 98 __ __ TYA
1cc0 : dd 00 41 CMP $4100,x ; (rooms + 0)
1cc3 : 90 25 __ BCC $1cea ; (is_inside_room.s3 + 0)
.s10:
1cc5 : bd 02 41 LDA $4102,x ; (rooms + 2)
1cc8 : 18 __ __ CLC
1cc9 : 7d 00 41 ADC $4100,x ; (rooms + 0)
1ccc : b0 06 __ BCS $1cd4 ; (is_inside_room.s9 + 0)
.s1005:
1cce : 85 1b __ STA ACCU + 0 
1cd0 : c4 1b __ CPY ACCU + 0 
1cd2 : b0 16 __ BCS $1cea ; (is_inside_room.s3 + 0)
.s9:
; 134, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1cd4 : a5 0e __ LDA P1 ; (y + 0)
1cd6 : dd 01 41 CMP $4101,x ; (rooms + 1)
1cd9 : 90 0f __ BCC $1cea ; (is_inside_room.s3 + 0)
.s8:
1cdb : bd 03 41 LDA $4103,x ; (rooms + 3)
1cde : 18 __ __ CLC
1cdf : 7d 01 41 ADC $4101,x ; (rooms + 1)
1ce2 : b0 13 __ BCS $1cf7 ; (is_inside_room.s5 + 0)
.s1002:
1ce4 : c5 0e __ CMP P1 ; (y + 0)
1ce6 : 90 02 __ BCC $1cea ; (is_inside_room.s3 + 0)
.s1011:
1ce8 : d0 0d __ BNE $1cf7 ; (is_inside_room.s5 + 0)
.s3:
; 132, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1cea : ee f9 9f INC $9ff9 ; (bit_offset + 1)
1ced : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
1cf0 : c5 1c __ CMP ACCU + 1 
1cf2 : 90 c7 __ BCC $1cbb ; (is_inside_room.l2 + 0)
.s4:
; 138, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1cf4 : a9 00 __ LDA #$00
.s1001:
1cf6 : 60 __ __ RTS
.s5:
1cf7 : a9 01 __ LDA #$01
1cf9 : 60 __ __ RTS
--------------------------------------------------------------------
connect_via_existing_corridors: ; connect_via_existing_corridors(u8,u8)->u8
.s0:
; 277, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1cfa : ad fc 9f LDA $9ffc ; (sstack + 2)
1cfd : 85 49 __ STA T1 + 0 
1cff : 85 0d __ STA P0 
1d01 : a9 eb __ LDA #$eb
1d03 : 85 0e __ STA P1 
1d05 : a9 9f __ LDA #$9f
1d07 : 85 11 __ STA P4 
1d09 : a9 9f __ LDA #$9f
1d0b : 85 0f __ STA P2 
1d0d : a9 ea __ LDA #$ea
1d0f : 85 10 __ STA P3 
1d11 : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 278, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1d14 : ad fd 9f LDA $9ffd ; (sstack + 3)
1d17 : 85 4a __ STA T2 + 0 
1d19 : 85 0d __ STA P0 
1d1b : a9 e9 __ LDA #$e9
1d1d : 85 0e __ STA P1 
1d1f : a9 9f __ LDA #$9f
1d21 : 85 11 __ STA P4 
1d23 : a9 9f __ LDA #$9f
1d25 : 85 0f __ STA P2 
1d27 : a9 e8 __ LDA #$e8
1d29 : 85 10 __ STA P3 
1d2b : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 279, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1d2e : a5 49 __ LDA T1 + 0 
1d30 : 0a __ __ ASL
1d31 : 0a __ __ ASL
1d32 : 0a __ __ ASL
1d33 : 85 4c __ STA T4 + 0 
1d35 : 18 __ __ CLC
1d36 : 69 00 __ ADC #$00
1d38 : 85 12 __ STA P5 
1d3a : a9 41 __ LDA #$41
1d3c : 69 00 __ ADC #$00
1d3e : 85 13 __ STA P6 
1d40 : ad e9 9f LDA $9fe9 ; (room2_center_x + 0)
1d43 : 85 14 __ STA P7 
1d45 : ad e8 9f LDA $9fe8 ; (up_y + 0)
1d48 : 85 15 __ STA P8 
1d4a : a9 ef __ LDA #$ef
1d4c : 85 16 __ STA P9 
1d4e : a9 ee __ LDA #$ee
1d50 : 8d fa 9f STA $9ffa ; (sstack + 0)
1d53 : a9 9f __ LDA #$9f
1d55 : 85 17 __ STA P10 
1d57 : a9 9f __ LDA #$9f
1d59 : 8d fb 9f STA $9ffb ; (sstack + 1)
1d5c : 20 cc 21 JSR $21cc ; (find_room_exit.s0 + 0)
; 281, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1d5f : a5 4a __ LDA T2 + 0 
1d61 : 0a __ __ ASL
1d62 : 0a __ __ ASL
1d63 : 0a __ __ ASL
1d64 : 85 4d __ STA T5 + 0 
1d66 : 18 __ __ CLC
1d67 : 69 00 __ ADC #$00
1d69 : 85 12 __ STA P5 
1d6b : a9 41 __ LDA #$41
1d6d : 69 00 __ ADC #$00
1d6f : 85 13 __ STA P6 
1d71 : ad eb 9f LDA $9feb ; (screen_offset + 1)
1d74 : 85 14 __ STA P7 
1d76 : ad ea 9f LDA $9fea ; (x + 0)
1d79 : 85 15 __ STA P8 
1d7b : a9 ed __ LDA #$ed
1d7d : 85 16 __ STA P9 
1d7f : a9 ec __ LDA #$ec
1d81 : 8d fa 9f STA $9ffa ; (sstack + 0)
1d84 : a9 9f __ LDA #$9f
1d86 : 85 17 __ STA P10 
1d88 : a9 9f __ LDA #$9f
1d8a : 8d fb 9f STA $9ffb ; (sstack + 1)
1d8d : 20 cc 21 JSR $21cc ; (find_room_exit.s0 + 0)
; 284, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1d90 : a9 ff __ LDA #$ff
1d92 : 8d e7 9f STA $9fe7 ; (dx + 1)
1d95 : 8d e6 9f STA $9fe6 ; (check_y + 0)
; 285, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1d98 : 8d e5 9f STA $9fe5 ; (dy + 1)
1d9b : 8d e4 9f STA $9fe4 ; (dy + 0)
; 286, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1d9e : 8d e3 9f STA $9fe3 ; (x + 1)
1da1 : 8d e2 9f STA $9fe2 ; (h + 0)
; 289, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1da4 : a9 0a __ LDA #$0a
1da6 : cd eb 9f CMP $9feb ; (screen_offset + 1)
1da9 : 90 04 __ BCC $1daf ; (connect_via_existing_corridors.s159 + 0)
.s160:
1dab : a9 00 __ LDA #$00
1dad : b0 05 __ BCS $1db4 ; (connect_via_existing_corridors.s161 + 0)
.s159:
; 289, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1daf : ad eb 9f LDA $9feb ; (screen_offset + 1)
1db2 : e9 09 __ SBC #$09
.s161:
1db4 : 85 4b __ STA T3 + 0 
1db6 : 8d e1 9f STA $9fe1 ; (y + 1)
; 290, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1db9 : a9 0a __ LDA #$0a
1dbb : cd ea 9f CMP $9fea ; (x + 0)
1dbe : 90 04 __ BCC $1dc4 ; (connect_via_existing_corridors.s162 + 0)
.s163:
1dc0 : a9 00 __ LDA #$00
1dc2 : b0 05 __ BCS $1dc9 ; (connect_via_existing_corridors.s164 + 0)
.s162:
; 290, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1dc4 : ad ea 9f LDA $9fea ; (x + 0)
1dc7 : e9 09 __ SBC #$09
.s164:
1dc9 : 8d e0 9f STA $9fe0 ; (grid_positions + 15)
; 294, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1dcc : 8d dd 9f STA $9fdd ; (grid_positions + 12)
; 291, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1dcf : ad eb 9f LDA $9feb ; (screen_offset + 1)
1dd2 : c9 36 __ CMP #$36
1dd4 : 90 04 __ BCC $1dda ; (connect_via_existing_corridors.s165 + 0)
.s166:
1dd6 : a9 3f __ LDA #$3f
1dd8 : b0 02 __ BCS $1ddc ; (connect_via_existing_corridors.s167 + 0)
.s165:
; 291, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1dda : 69 0a __ ADC #$0a
.s167:
1ddc : 85 4e __ STA T6 + 0 
1dde : 8d df 9f STA $9fdf ; (grid_positions + 14)
; 292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1de1 : ad ea 9f LDA $9fea ; (x + 0)
1de4 : c9 36 __ CMP #$36
1de6 : 90 04 __ BCC $1dec ; (connect_via_existing_corridors.s168 + 0)
.s169:
1de8 : a9 3f __ LDA #$3f
1dea : b0 02 __ BCS $1dee ; (connect_via_existing_corridors.s170 + 0)
.s168:
; 292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1dec : 69 0a __ ADC #$0a
.s170:
1dee : 8d de 9f STA $9fde ; (grid_positions + 13)
; 294, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1df1 : cd e0 9f CMP $9fe0 ; (grid_positions + 15)
1df4 : b0 03 __ BCS $1df9 ; (connect_via_existing_corridors.s144 + 0)
1df6 : 4c b4 1e JMP $1eb4 ; (connect_via_existing_corridors.s4 + 0)
.s144:
; 295, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1df9 : 85 4f __ STA T7 + 0 
1dfb : a5 4e __ LDA T6 + 0 
1dfd : c5 4b __ CMP T3 + 0 
1dff : a9 00 __ LDA #$00
1e01 : 2a __ __ ROL
1e02 : 85 51 __ STA T9 + 0 
.l2:
1e04 : a5 4b __ LDA T3 + 0 
1e06 : 8d dc 9f STA $9fdc ; (grid_positions + 11)
1e09 : a5 51 __ LDA T9 + 0 
1e0b : d0 03 __ BNE $1e10 ; (connect_via_existing_corridors.s143 + 0)
1e0d : 4c a7 1e JMP $1ea7 ; (connect_via_existing_corridors.s3 + 0)
.s143:
; 296, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e10 : ad dd 9f LDA $9fdd ; (grid_positions + 12)
1e13 : 85 10 __ STA P3 
.l6:
1e15 : ad dc 9f LDA $9fdc ; (grid_positions + 11)
1e18 : 85 52 __ STA T11 + 0 
1e1a : 85 0f __ STA P2 
1e1c : 20 6f 22 JSR $226f ; (tile_is_floor.s0 + 0)
1e1f : a5 1b __ LDA ACCU + 0 ; (room1 + 0)
1e21 : f0 74 __ BEQ $1e97 ; (connect_via_existing_corridors.s5 + 0)
.s12:
1e23 : 20 96 1c JSR $1c96 ; (is_outside_any_room.s0 + 0)
1e26 : aa __ __ TAX
1e27 : f0 6e __ BEQ $1e97 ; (connect_via_existing_corridors.s5 + 0)
.s9:
; 298, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e29 : a5 52 __ LDA T11 + 0 
1e2b : 85 0d __ STA P0 
1e2d : ad ef 9f LDA $9fef ; (screen_pos + 1)
1e30 : 85 0e __ STA P1 
1e32 : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
1e35 : 85 4a __ STA T2 + 0 
1e37 : a5 10 __ LDA P3 
1e39 : 85 0d __ STA P0 
1e3b : ad ee 9f LDA $9fee ; (entropy4 + 1)
1e3e : 85 0e __ STA P1 
1e40 : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
1e43 : 18 __ __ CLC
1e44 : 65 4a __ ADC T2 + 0 
1e46 : 85 49 __ STA T1 + 0 
1e48 : 8d db 9f STA $9fdb ; (grid_positions + 10)
; 299, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e4b : a5 52 __ LDA T11 + 0 
1e4d : 85 0d __ STA P0 
1e4f : ad ed 9f LDA $9fed ; (exit2_x + 0)
1e52 : 85 0e __ STA P1 
1e54 : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
1e57 : 85 48 __ STA T0 + 0 
1e59 : a5 10 __ LDA P3 
1e5b : 85 0d __ STA P0 
1e5d : ad ec 9f LDA $9fec ; (exit2_y + 0)
1e60 : 85 0e __ STA P1 
1e62 : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
1e65 : 18 __ __ CLC
1e66 : 65 48 __ ADC T0 + 0 
1e68 : 8d da 9f STA $9fda ; (grid_positions + 9)
; 301, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e6b : a5 49 __ LDA T1 + 0 
1e6d : cd e3 9f CMP $9fe3 ; (x + 1)
1e70 : b0 0d __ BCS $1e7f ; (connect_via_existing_corridors.s15 + 0)
.s13:
; 302, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e72 : 8d e3 9f STA $9fe3 ; (x + 1)
; 303, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e75 : a5 52 __ LDA T11 + 0 
1e77 : 8d e7 9f STA $9fe7 ; (dx + 1)
; 304, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e7a : a5 10 __ LDA P3 
1e7c : 8d e6 9f STA $9fe6 ; (check_y + 0)
.s15:
; 307, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e7f : ad da 9f LDA $9fda ; (grid_positions + 9)
1e82 : cd e2 9f CMP $9fe2 ; (h + 0)
1e85 : b0 10 __ BCS $1e97 ; (connect_via_existing_corridors.s5 + 0)
.s16:
; 309, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e87 : a5 52 __ LDA T11 + 0 
1e89 : 8d e5 9f STA $9fe5 ; (dy + 1)
; 310, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e8c : a5 10 __ LDA P3 
1e8e : 8d e4 9f STA $9fe4 ; (dy + 0)
; 308, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e91 : ad da 9f LDA $9fda ; (grid_positions + 9)
1e94 : 8d e2 9f STA $9fe2 ; (h + 0)
.s5:
; 295, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e97 : a6 52 __ LDX T11 + 0 
1e99 : e8 __ __ INX
1e9a : 8e dc 9f STX $9fdc ; (grid_positions + 11)
1e9d : a5 4e __ LDA T6 + 0 
1e9f : cd dc 9f CMP $9fdc ; (grid_positions + 11)
1ea2 : 90 03 __ BCC $1ea7 ; (connect_via_existing_corridors.s3 + 0)
1ea4 : 4c 15 1e JMP $1e15 ; (connect_via_existing_corridors.l6 + 0)
.s3:
; 294, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ea7 : ee dd 9f INC $9fdd ; (grid_positions + 12)
1eaa : a5 4f __ LDA T7 + 0 
1eac : cd dd 9f CMP $9fdd ; (grid_positions + 12)
1eaf : 90 03 __ BCC $1eb4 ; (connect_via_existing_corridors.s4 + 0)
1eb1 : 4c 04 1e JMP $1e04 ; (connect_via_existing_corridors.l2 + 0)
.s4:
; 317, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1eb4 : ad e7 9f LDA $9fe7 ; (dx + 1)
1eb7 : c9 ff __ CMP #$ff
1eb9 : f0 2b __ BEQ $1ee6 ; (connect_via_existing_corridors.s21 + 0)
.s24:
1ebb : 85 4e __ STA T6 + 0 
1ebd : ad e5 9f LDA $9fe5 ; (dy + 1)
1ec0 : c9 ff __ CMP #$ff
1ec2 : f0 22 __ BEQ $1ee6 ; (connect_via_existing_corridors.s21 + 0)
.s23:
1ec4 : 85 4f __ STA T7 + 0 
1ec6 : a9 08 __ LDA #$08
1ec8 : cd e3 9f CMP $9fe3 ; (x + 1)
1ecb : 90 19 __ BCC $1ee6 ; (connect_via_existing_corridors.s21 + 0)
.s22:
1ecd : cd e2 9f CMP $9fe2 ; (h + 0)
1ed0 : 90 14 __ BCC $1ee6 ; (connect_via_existing_corridors.s21 + 0)
.s19:
; 322, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ed2 : ad ef 9f LDA $9fef ; (screen_pos + 1)
1ed5 : 85 4b __ STA T3 + 0 
1ed7 : 85 0d __ STA P0 
1ed9 : ad ee 9f LDA $9fee ; (entropy4 + 1)
1edc : 85 50 __ STA T8 + 0 
1ede : 85 0e __ STA P1 
1ee0 : 20 dd 14 JSR $14dd ; (coords_in_bounds.s0 + 0)
1ee3 : aa __ __ TAX
1ee4 : d0 05 __ BNE $1eeb ; (connect_via_existing_corridors.s27 + 0)
.s21:
; 389, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ee6 : a9 00 __ LDA #$00
.s1001:
1ee8 : 85 1b __ STA ACCU + 0 ; (room1 + 0)
1eea : 60 __ __ RTS
.s27:
; 323, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1eeb : 20 91 22 JSR $2291 ; (is_valid_room_wall_for_door.s0 + 0)
1eee : aa __ __ TAX
1eef : f0 0f __ BEQ $1f00 ; (connect_via_existing_corridors.s31 + 0)
.s29:
; 324, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ef1 : a5 4b __ LDA T3 + 0 
1ef3 : 85 10 __ STA P3 
1ef5 : a5 50 __ LDA T8 + 0 
1ef7 : 85 11 __ STA P4 
1ef9 : a9 03 __ LDA #$03
1efb : 85 12 __ STA P5 
1efd : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s31:
; 326, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f00 : a9 00 __ LDA #$00
1f02 : 8d d8 9f STA $9fd8 ; (grid_positions + 7)
1f05 : 8d d9 9f STA $9fd9 ; (grid_positions + 8)
1f08 : 8d d6 9f STA $9fd6 ; (grid_positions + 5)
1f0b : 8d d7 9f STA $9fd7 ; (grid_positions + 6)
; 333, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f0e : a2 01 __ LDX #$01
1f10 : 8e 30 33 STX $3330 ; (corridor_endpoint_override + 0)
; 327, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f13 : a4 4c __ LDY T4 + 0 
1f15 : b9 00 41 LDA $4100,y ; (rooms + 0)
1f18 : 38 __ __ SEC
1f19 : e9 01 __ SBC #$01
1f1b : 90 16 __ BCC $1f33 ; (connect_via_existing_corridors.s33 + 0)
.s1029:
1f1d : c5 4b __ CMP T3 + 0 
1f1f : d0 12 __ BNE $1f33 ; (connect_via_existing_corridors.s33 + 0)
.s32:
1f21 : a9 ff __ LDA #$ff
1f23 : 8d d8 9f STA $9fd8 ; (grid_positions + 7)
.s277:
; 328, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f26 : 8d d9 9f STA $9fd9 ; (grid_positions + 8)
1f29 : a9 00 __ LDA #$00
1f2b : 8d d6 9f STA $9fd6 ; (grid_positions + 5)
1f2e : 8d d7 9f STA $9fd7 ; (grid_positions + 6)
1f31 : f0 46 __ BEQ $1f79 ; (connect_via_existing_corridors.s34 + 0)
.s33:
; 328, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f33 : b9 02 41 LDA $4102,y ; (rooms + 2)
1f36 : 18 __ __ CLC
1f37 : 79 00 41 ADC $4100,y ; (rooms + 0)
1f3a : b0 0b __ BCS $1f47 ; (connect_via_existing_corridors.s36 + 0)
.s1026:
1f3c : c5 4b __ CMP T3 + 0 
1f3e : d0 07 __ BNE $1f47 ; (connect_via_existing_corridors.s36 + 0)
.s35:
1f40 : 8e d8 9f STX $9fd8 ; (grid_positions + 7)
1f43 : a9 00 __ LDA #$00
1f45 : f0 df __ BEQ $1f26 ; (connect_via_existing_corridors.s277 + 0)
.s36:
; 329, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f47 : b9 01 41 LDA $4101,y ; (rooms + 1)
1f4a : 38 __ __ SEC
1f4b : e9 01 __ SBC #$01
1f4d : 90 16 __ BCC $1f65 ; (connect_via_existing_corridors.s39 + 0)
.s1023:
1f4f : c5 50 __ CMP T8 + 0 
1f51 : d0 12 __ BNE $1f65 ; (connect_via_existing_corridors.s39 + 0)
.s38:
1f53 : a9 ff __ LDA #$ff
1f55 : 8d d6 9f STA $9fd6 ; (grid_positions + 5)
.s328:
; 330, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f58 : 8d d7 9f STA $9fd7 ; (grid_positions + 6)
1f5b : a9 00 __ LDA #$00
1f5d : 8d d8 9f STA $9fd8 ; (grid_positions + 7)
1f60 : 8d d9 9f STA $9fd9 ; (grid_positions + 8)
1f63 : f0 14 __ BEQ $1f79 ; (connect_via_existing_corridors.s34 + 0)
.s39:
; 330, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f65 : b9 03 41 LDA $4103,y ; (rooms + 3)
1f68 : 18 __ __ CLC
1f69 : 79 01 41 ADC $4101,y ; (rooms + 1)
1f6c : b0 0b __ BCS $1f79 ; (connect_via_existing_corridors.s34 + 0)
.s1020:
1f6e : c5 50 __ CMP T8 + 0 
1f70 : d0 07 __ BNE $1f79 ; (connect_via_existing_corridors.s34 + 0)
.s41:
1f72 : 8e d6 9f STX $9fd6 ; (grid_positions + 5)
1f75 : a9 00 __ LDA #$00
1f77 : f0 df __ BEQ $1f58 ; (connect_via_existing_corridors.s328 + 0)
.s34:
; 331, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f79 : ad d8 9f LDA $9fd8 ; (grid_positions + 7)
1f7c : 18 __ __ CLC
1f7d : 65 4b __ ADC T3 + 0 
1f7f : 85 4a __ STA T2 + 0 
1f81 : 85 0d __ STA P0 
1f83 : 8d d5 9f STA $9fd5 ; (grid_positions + 4)
; 332, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f86 : ad d6 9f LDA $9fd6 ; (grid_positions + 5)
1f89 : 18 __ __ CLC
1f8a : 65 50 __ ADC T8 + 0 
1f8c : 85 48 __ STA T0 + 0 
1f8e : 85 0e __ STA P1 
1f90 : 8d d4 9f STA $9fd4 ; (grid_positions + 3)
; 334, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f93 : 20 dd 14 JSR $14dd ; (coords_in_bounds.s0 + 0)
1f96 : aa __ __ TAX
1f97 : f0 1d __ BEQ $1fb6 ; (connect_via_existing_corridors.s46 + 0)
.s47:
1f99 : a5 0d __ LDA P0 
1f9b : 85 13 __ STA P6 
1f9d : a5 0e __ LDA P1 
1f9f : 85 14 __ STA P7 
1fa1 : 20 46 23 JSR $2346 ; (can_place_corridor_tile.s0 + 0)
1fa4 : aa __ __ TAX
1fa5 : f0 0f __ BEQ $1fb6 ; (connect_via_existing_corridors.s46 + 0)
.s44:
; 335, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fa7 : a5 4a __ LDA T2 + 0 
1fa9 : 85 10 __ STA P3 
1fab : a5 48 __ LDA T0 + 0 
1fad : 85 11 __ STA P4 
1faf : a9 02 __ LDA #$02
1fb1 : 85 12 __ STA P5 
1fb3 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s46:
; 338, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fb6 : a5 4a __ LDA T2 + 0 
1fb8 : 8d d3 9f STA $9fd3 ; (grid_positions + 2)
; 339, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fbb : a5 48 __ LDA T0 + 0 
1fbd : 8d d2 9f STA $9fd2 ; (grid_positions + 1)
; 340, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fc0 : a9 40 __ LDA #$40
1fc2 : 8d d1 9f STA $9fd1 ; (step_limit1 + 0)
; 337, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fc5 : a9 00 __ LDA #$00
1fc7 : 8d 30 33 STA $3330 ; (corridor_endpoint_override + 0)
.l48:
; 341, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fca : a5 4e __ LDA T6 + 0 
1fcc : cd d3 9f CMP $9fd3 ; (grid_positions + 2)
1fcf : f0 04 __ BEQ $1fd5 ; (connect_via_existing_corridors.s1003 + 0)
.s1002:
1fd1 : a0 01 __ LDY #$01
1fd3 : d0 0a __ BNE $1fdf ; (connect_via_existing_corridors.s51 + 0)
.s1003:
1fd5 : ad d2 9f LDA $9fd2 ; (grid_positions + 1)
1fd8 : a0 00 __ LDY #$00
1fda : cd e6 9f CMP $9fe6 ; (check_y + 0)
1fdd : f0 1a __ BEQ $1ff9 ; (connect_via_existing_corridors.s50 + 0)
.s51:
1fdf : ad d1 9f LDA $9fd1 ; (step_limit1 + 0)
1fe2 : ce d1 9f DEC $9fd1 ; (step_limit1 + 0)
1fe5 : aa __ __ TAX
1fe6 : f0 11 __ BEQ $1ff9 ; (connect_via_existing_corridors.s50 + 0)
.s49:
; 342, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fe8 : 98 __ __ TYA
1fe9 : f0 03 __ BEQ $1fee ; (connect_via_existing_corridors.s54 + 0)
1feb : 4c b7 21 JMP $21b7 ; (connect_via_existing_corridors.s53 + 0)
.s54:
; 344, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fee : ad d2 9f LDA $9fd2 ; (grid_positions + 1)
1ff1 : cd e6 9f CMP $9fe6 ; (check_y + 0)
1ff4 : f0 03 __ BEQ $1ff9 ; (connect_via_existing_corridors.s50 + 0)
1ff6 : 4c 73 21 JMP $2173 ; (connect_via_existing_corridors.s56 + 0)
.s50:
; 355, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ff9 : ad ed 9f LDA $9fed ; (exit2_x + 0)
1ffc : 85 4b __ STA T3 + 0 
1ffe : 85 0d __ STA P0 
2000 : ad ec 9f LDA $9fec ; (exit2_y + 0)
2003 : 85 4c __ STA T4 + 0 
2005 : 85 0e __ STA P1 
2007 : 20 dd 14 JSR $14dd ; (coords_in_bounds.s0 + 0)
200a : aa __ __ TAX
200b : d0 03 __ BNE $2010 ; (connect_via_existing_corridors.s66 + 0)
200d : 4c e6 1e JMP $1ee6 ; (connect_via_existing_corridors.s21 + 0)
.s66:
; 356, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2010 : 20 91 22 JSR $2291 ; (is_valid_room_wall_for_door.s0 + 0)
2013 : aa __ __ TAX
2014 : f0 0f __ BEQ $2025 ; (connect_via_existing_corridors.s70 + 0)
.s68:
; 357, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2016 : a5 4b __ LDA T3 + 0 
2018 : 85 10 __ STA P3 
201a : a5 4c __ LDA T4 + 0 
201c : 85 11 __ STA P4 
201e : a9 03 __ LDA #$03
2020 : 85 12 __ STA P5 
2022 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s70:
; 359, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2025 : a9 00 __ LDA #$00
2027 : 8d cf 9f STA $9fcf ; (dx2 + 0)
202a : 8d d0 9f STA $9fd0 ; (dx2 + 1)
202d : 8d cd 9f STA $9fcd ; (pass + 0)
2030 : 8d ce 9f STA $9fce ; (dy2 + 1)
; 366, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2033 : a2 01 __ LDX #$01
2035 : 8e 30 33 STX $3330 ; (corridor_endpoint_override + 0)
; 360, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2038 : a4 4d __ LDY T5 + 0 
203a : b9 00 41 LDA $4100,y ; (rooms + 0)
203d : 38 __ __ SEC
203e : e9 01 __ SBC #$01
2040 : 90 16 __ BCC $2058 ; (connect_via_existing_corridors.s72 + 0)
.s1017:
2042 : c5 4b __ CMP T3 + 0 
2044 : d0 12 __ BNE $2058 ; (connect_via_existing_corridors.s72 + 0)
.s71:
2046 : a9 ff __ LDA #$ff
2048 : 8d cf 9f STA $9fcf ; (dx2 + 0)
.s278:
; 361, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
204b : 8d d0 9f STA $9fd0 ; (dx2 + 1)
204e : a9 00 __ LDA #$00
2050 : 8d cd 9f STA $9fcd ; (pass + 0)
2053 : 8d ce 9f STA $9fce ; (dy2 + 1)
2056 : f0 46 __ BEQ $209e ; (connect_via_existing_corridors.s73 + 0)
.s72:
; 361, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2058 : b9 02 41 LDA $4102,y ; (rooms + 2)
205b : 18 __ __ CLC
205c : 79 00 41 ADC $4100,y ; (rooms + 0)
205f : b0 0b __ BCS $206c ; (connect_via_existing_corridors.s75 + 0)
.s1014:
2061 : c5 4b __ CMP T3 + 0 
2063 : d0 07 __ BNE $206c ; (connect_via_existing_corridors.s75 + 0)
.s74:
2065 : 8e cf 9f STX $9fcf ; (dx2 + 0)
2068 : a9 00 __ LDA #$00
206a : f0 df __ BEQ $204b ; (connect_via_existing_corridors.s278 + 0)
.s75:
; 362, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
206c : b9 01 41 LDA $4101,y ; (rooms + 1)
206f : 38 __ __ SEC
2070 : e9 01 __ SBC #$01
2072 : 90 16 __ BCC $208a ; (connect_via_existing_corridors.s78 + 0)
.s1011:
2074 : c5 4c __ CMP T4 + 0 
2076 : d0 12 __ BNE $208a ; (connect_via_existing_corridors.s78 + 0)
.s77:
2078 : a9 ff __ LDA #$ff
207a : 8d cd 9f STA $9fcd ; (pass + 0)
.s329:
; 363, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
207d : 8d ce 9f STA $9fce ; (dy2 + 1)
2080 : a9 00 __ LDA #$00
2082 : 8d cf 9f STA $9fcf ; (dx2 + 0)
2085 : 8d d0 9f STA $9fd0 ; (dx2 + 1)
2088 : f0 14 __ BEQ $209e ; (connect_via_existing_corridors.s73 + 0)
.s78:
; 363, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
208a : b9 03 41 LDA $4103,y ; (rooms + 3)
208d : 18 __ __ CLC
208e : 79 01 41 ADC $4101,y ; (rooms + 1)
2091 : b0 0b __ BCS $209e ; (connect_via_existing_corridors.s73 + 0)
.s1008:
2093 : c5 4c __ CMP T4 + 0 
2095 : d0 07 __ BNE $209e ; (connect_via_existing_corridors.s73 + 0)
.s80:
2097 : 8e cd 9f STX $9fcd ; (pass + 0)
209a : a9 00 __ LDA #$00
209c : f0 df __ BEQ $207d ; (connect_via_existing_corridors.s329 + 0)
.s73:
; 364, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
209e : ad cf 9f LDA $9fcf ; (dx2 + 0)
20a1 : 18 __ __ CLC
20a2 : 65 4b __ ADC T3 + 0 
20a4 : 85 4a __ STA T2 + 0 
20a6 : 85 0d __ STA P0 
20a8 : 8d cc 9f STA $9fcc ; (corridor2_x + 0)
; 365, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20ab : ad cd 9f LDA $9fcd ; (pass + 0)
20ae : 18 __ __ CLC
20af : 65 4c __ ADC T4 + 0 
20b1 : 85 48 __ STA T0 + 0 
20b3 : 85 0e __ STA P1 
20b5 : 8d cb 9f STA $9fcb ; (create_rooms@stack + 3)
; 367, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20b8 : 20 dd 14 JSR $14dd ; (coords_in_bounds.s0 + 0)
20bb : aa __ __ TAX
20bc : f0 1d __ BEQ $20db ; (connect_via_existing_corridors.s85 + 0)
.s86:
20be : a5 0d __ LDA P0 
20c0 : 85 13 __ STA P6 
20c2 : a5 0e __ LDA P1 
20c4 : 85 14 __ STA P7 
20c6 : 20 46 23 JSR $2346 ; (can_place_corridor_tile.s0 + 0)
20c9 : aa __ __ TAX
20ca : f0 0f __ BEQ $20db ; (connect_via_existing_corridors.s85 + 0)
.s83:
; 368, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20cc : a5 4a __ LDA T2 + 0 
20ce : 85 10 __ STA P3 
20d0 : a5 48 __ LDA T0 + 0 
20d2 : 85 11 __ STA P4 
20d4 : a9 02 __ LDA #$02
20d6 : 85 12 __ STA P5 
20d8 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s85:
; 371, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20db : a5 4a __ LDA T2 + 0 
20dd : 8d ca 9f STA $9fca ; (create_rooms@stack + 2)
; 372, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20e0 : a5 48 __ LDA T0 + 0 
20e2 : 8d c9 9f STA $9fc9 ; (create_rooms@stack + 1)
; 373, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20e5 : a9 40 __ LDA #$40
20e7 : 8d c8 9f STA $9fc8 ; (step_limit2 + 0)
; 370, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20ea : a9 00 __ LDA #$00
20ec : 8d 30 33 STA $3330 ; (corridor_endpoint_override + 0)
.l87:
; 374, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20ef : a5 4f __ LDA T7 + 0 
20f1 : cd ca 9f CMP $9fca ; (create_rooms@stack + 2)
20f4 : f0 04 __ BEQ $20fa ; (connect_via_existing_corridors.s1006 + 0)
.s1005:
20f6 : a0 01 __ LDY #$01
20f8 : d0 0a __ BNE $2104 ; (connect_via_existing_corridors.s90 + 0)
.s1006:
20fa : ad c9 9f LDA $9fc9 ; (create_rooms@stack + 1)
20fd : a0 00 __ LDY #$00
20ff : cd e4 9f CMP $9fe4 ; (dy + 0)
2102 : f0 14 __ BEQ $2118 ; (connect_via_existing_corridors.s89 + 0)
.s90:
2104 : ad c8 9f LDA $9fc8 ; (step_limit2 + 0)
2107 : ce c8 9f DEC $9fc8 ; (step_limit2 + 0)
210a : aa __ __ TAX
210b : f0 0b __ BEQ $2118 ; (connect_via_existing_corridors.s89 + 0)
.s88:
; 375, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
210d : 98 __ __ TYA
210e : d0 4e __ BNE $215e ; (connect_via_existing_corridors.s92 + 0)
.s93:
; 377, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2110 : ad c9 9f LDA $9fc9 ; (create_rooms@stack + 1)
2113 : cd e4 9f CMP $9fe4 ; (dy + 0)
2116 : d0 05 __ BNE $211d ; (connect_via_existing_corridors.s95 + 0)
.s89:
; 386, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2118 : a9 01 __ LDA #$01
211a : 4c e8 1e JMP $1ee8 ; (connect_via_existing_corridors.s1001 + 0)
.s95:
; 378, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
211d : a9 ff __ LDA #$ff
211f : b0 02 __ BCS $2123 ; (connect_via_existing_corridors.s182 + 0)
.s180:
2121 : a9 01 __ LDA #$01
.s182:
2123 : 18 __ __ CLC
2124 : 6d c9 9f ADC $9fc9 ; (create_rooms@stack + 1)
2127 : 8d c9 9f STA $9fc9 ; (create_rooms@stack + 1)
; 382, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
212a : ad ca 9f LDA $9fca ; (create_rooms@stack + 2)
.s94:
212d : 85 49 __ STA T1 + 0 
212f : 85 0f __ STA P2 
2131 : ad c9 9f LDA $9fc9 ; (create_rooms@stack + 1)
2134 : 85 4a __ STA T2 + 0 
2136 : 85 10 __ STA P3 
2138 : 20 96 1c JSR $1c96 ; (is_outside_any_room.s0 + 0)
213b : aa __ __ TAX
213c : f0 b1 __ BEQ $20ef ; (connect_via_existing_corridors.l87 + 0)
.s102:
213e : a5 49 __ LDA T1 + 0 
2140 : 85 13 __ STA P6 
2142 : a5 4a __ LDA T2 + 0 
2144 : 85 14 __ STA P7 
2146 : 20 46 23 JSR $2346 ; (can_place_corridor_tile.s0 + 0)
2149 : aa __ __ TAX
214a : f0 a3 __ BEQ $20ef ; (connect_via_existing_corridors.l87 + 0)
.s99:
; 383, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
214c : a5 49 __ LDA T1 + 0 
214e : 85 10 __ STA P3 
2150 : a5 4a __ LDA T2 + 0 
2152 : 85 11 __ STA P4 
2154 : a9 02 __ LDA #$02
2156 : 85 12 __ STA P5 
2158 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
215b : 4c ef 20 JMP $20ef ; (connect_via_existing_corridors.l87 + 0)
.s92:
; 376, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
215e : ad ca 9f LDA $9fca ; (create_rooms@stack + 2)
2161 : c5 4f __ CMP T7 + 0 
2163 : a9 ff __ LDA #$ff
2165 : b0 02 __ BCS $2169 ; (connect_via_existing_corridors.s179 + 0)
.s177:
2167 : a9 01 __ LDA #$01
.s179:
2169 : 18 __ __ CLC
216a : 6d ca 9f ADC $9fca ; (create_rooms@stack + 2)
216d : 8d ca 9f STA $9fca ; (create_rooms@stack + 2)
2170 : 4c 2d 21 JMP $212d ; (connect_via_existing_corridors.s94 + 0)
.s56:
; 345, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2173 : a9 ff __ LDA #$ff
2175 : b0 02 __ BCS $2179 ; (connect_via_existing_corridors.s176 + 0)
.s174:
2177 : a9 01 __ LDA #$01
.s176:
2179 : 18 __ __ CLC
217a : 6d d2 9f ADC $9fd2 ; (grid_positions + 1)
217d : 8d d2 9f STA $9fd2 ; (grid_positions + 1)
; 349, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2180 : ad d3 9f LDA $9fd3 ; (grid_positions + 2)
.s55:
2183 : 85 49 __ STA T1 + 0 
2185 : 85 0f __ STA P2 
2187 : ad d2 9f LDA $9fd2 ; (grid_positions + 1)
218a : 85 4a __ STA T2 + 0 
218c : 85 10 __ STA P3 
218e : 20 96 1c JSR $1c96 ; (is_outside_any_room.s0 + 0)
2191 : aa __ __ TAX
2192 : d0 03 __ BNE $2197 ; (connect_via_existing_corridors.s63 + 0)
2194 : 4c ca 1f JMP $1fca ; (connect_via_existing_corridors.l48 + 0)
.s63:
2197 : a5 49 __ LDA T1 + 0 
2199 : 85 13 __ STA P6 
219b : a5 4a __ LDA T2 + 0 
219d : 85 14 __ STA P7 
219f : 20 46 23 JSR $2346 ; (can_place_corridor_tile.s0 + 0)
21a2 : aa __ __ TAX
21a3 : f0 ef __ BEQ $2194 ; (connect_via_existing_corridors.s55 + 17)
.s60:
; 350, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21a5 : a5 49 __ LDA T1 + 0 
21a7 : 85 10 __ STA P3 
21a9 : a5 4a __ LDA T2 + 0 
21ab : 85 11 __ STA P4 
21ad : a9 02 __ LDA #$02
21af : 85 12 __ STA P5 
21b1 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
21b4 : 4c ca 1f JMP $1fca ; (connect_via_existing_corridors.l48 + 0)
.s53:
; 343, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21b7 : ad d3 9f LDA $9fd3 ; (grid_positions + 2)
21ba : c5 4e __ CMP T6 + 0 
21bc : a9 ff __ LDA #$ff
21be : b0 02 __ BCS $21c2 ; (connect_via_existing_corridors.s173 + 0)
.s171:
21c0 : a9 01 __ LDA #$01
.s173:
21c2 : 18 __ __ CLC
21c3 : 6d d3 9f ADC $9fd3 ; (grid_positions + 2)
21c6 : 8d d3 9f STA $9fd3 ; (grid_positions + 2)
21c9 : 4c 83 21 JMP $2183 ; (connect_via_existing_corridors.s55 + 0)
--------------------------------------------------------------------
find_room_exit: ; find_room_exit(struct S#1442*,u8,u8,u8*,u8*)->void
.s0:
; 176, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
21cc : 38 __ __ SEC
21cd : a5 12 __ LDA P5 ; (room + 0)
21cf : e9 00 __ SBC #$00
21d1 : 85 43 __ STA T0 + 0 
21d3 : a5 13 __ LDA P6 ; (room + 1)
21d5 : e9 41 __ SBC #$41
21d7 : 4a __ __ LSR
21d8 : 66 43 __ ROR T0 + 0 
21da : 4a __ __ LSR
21db : 66 43 __ ROR T0 + 0 
21dd : 4a __ __ LSR
21de : a5 43 __ LDA T0 + 0 
21e0 : 6a __ __ ROR
21e1 : 85 0d __ STA P0 
21e3 : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
; 177, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
21e6 : a9 f9 __ LDA #$f9
21e8 : 85 0e __ STA P1 
21ea : a9 9f __ LDA #$9f
21ec : 85 11 __ STA P4 
21ee : a9 9f __ LDA #$9f
21f0 : 85 0f __ STA P2 
21f2 : a9 f8 __ LDA #$f8
21f4 : 85 10 __ STA P3 
21f6 : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 179, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
21f9 : a5 14 __ LDA P7 ; (target_x + 0)
21fb : 85 0d __ STA P0 
21fd : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
2200 : 85 45 __ STA T5 + 0 
2202 : 85 0e __ STA P1 
2204 : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
2207 : 85 46 __ STA T6 + 0 
2209 : 8d f6 9f STA $9ff6 ; (dx + 0)
; 180, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
220c : a5 15 __ LDA P8 ; (target_y + 0)
220e : 85 0d __ STA P0 
2210 : ad f8 9f LDA $9ff8 ; (room + 1)
2213 : 85 47 __ STA T8 + 0 
2215 : 85 0e __ STA P1 
2217 : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
221a : 8d f5 9f STA $9ff5 ; (s + 1)
; 182, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
221d : ae fa 9f LDX $9ffa ; (sstack + 0)
2220 : 86 1b __ STX ACCU + 0 
2222 : ae fb 9f LDX $9ffb ; (sstack + 1)
2225 : 86 1c __ STX ACCU + 1 
2227 : c5 46 __ CMP T6 + 0 
2229 : 90 22 __ BCC $224d ; (find_room_exit.s1 + 0)
.s2:
; 195, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
222b : a0 01 __ LDY #$01
222d : b1 12 __ LDA (P5),y ; (room + 0)
222f : 85 1d __ STA ACCU + 2 
2231 : a5 47 __ LDA T8 + 0 
2233 : c5 15 __ CMP P8 ; (target_y + 0)
2235 : 90 06 __ BCC $223d ; (find_room_exit.s7 + 0)
.s8:
; 201, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2237 : c6 1d __ DEC ACCU + 2 
2239 : a5 1d __ LDA ACCU + 2 
223b : b0 06 __ BCS $2243 ; (find_room_exit.s1003 + 0)
.s7:
; 197, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
223d : a0 03 __ LDY #$03
223f : b1 12 __ LDA (P5),y ; (room + 0)
2241 : 65 1d __ ADC ACCU + 2 
.s1003:
; 201, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2243 : a0 00 __ LDY #$00
2245 : 91 1b __ STA (ACCU + 0),y 
; 202, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2247 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
224a : 91 16 __ STA (P9),y ; (exit_x + 0)
.s1001:
; 205, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
224c : 60 __ __ RTS
.s1:
; 184, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
224d : a0 00 __ LDY #$00
224f : b1 12 __ LDA (P5),y ; (room + 0)
2251 : 85 1d __ STA ACCU + 2 
2253 : a5 45 __ LDA T5 + 0 
2255 : c5 14 __ CMP P7 ; (target_x + 0)
2257 : b0 0a __ BCS $2263 ; (find_room_exit.s5 + 0)
.s4:
; 190, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2259 : a0 02 __ LDY #$02
225b : b1 12 __ LDA (P5),y ; (room + 0)
225d : 65 1d __ ADC ACCU + 2 
225f : a0 00 __ LDY #$00
2261 : f0 04 __ BEQ $2267 ; (find_room_exit.s1002 + 0)
.s5:
; 190, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2263 : c6 1d __ DEC ACCU + 2 
2265 : a5 1d __ LDA ACCU + 2 
.s1002:
2267 : 91 16 __ STA (P9),y ; (exit_x + 0)
; 191, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2269 : ad f8 9f LDA $9ff8 ; (room + 1)
226c : 91 1b __ STA (ACCU + 0),y 
226e : 60 __ __ RTS
--------------------------------------------------------------------
tile_is_floor: ; tile_is_floor(u8,u8)->u8
.s0:
; 274, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
226f : a5 0f __ LDA P2 ; (x + 0)
2271 : c9 40 __ CMP #$40
2273 : b0 17 __ BCS $228c ; (tile_is_floor.s1005 + 0)
.s4:
2275 : a5 10 __ LDA P3 ; (y + 0)
2277 : c9 40 __ CMP #$40
2279 : b0 11 __ BCS $228c ; (tile_is_floor.s1005 + 0)
.s3:
; 275, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
227b : 85 0e __ STA P1 
227d : a5 0f __ LDA P2 ; (x + 0)
227f : 85 0d __ STA P0 
2281 : 20 14 15 JSR $1514 ; (get_tile_core.s0 + 0)
2284 : c9 02 __ CMP #$02
2286 : d0 04 __ BNE $228c ; (tile_is_floor.s1005 + 0)
.s1002:
2288 : a9 01 __ LDA #$01
228a : d0 02 __ BNE $228e ; (tile_is_floor.s1001 + 0)
.s1005:
228c : a9 00 __ LDA #$00
.s1001:
228e : 85 1b __ STA ACCU + 0 
2290 : 60 __ __ RTS
--------------------------------------------------------------------
is_valid_room_wall_for_door: ; is_valid_room_wall_for_door(u8,u8)->u8
.s0:
;  20, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
2291 : a9 00 __ LDA #$00
2293 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
2296 : ad 22 32 LDA $3222 ; (room_count + 0)
2299 : 85 1d __ STA ACCU + 2 
229b : d0 03 __ BNE $22a0 ; (is_valid_room_wall_for_door.l2 + 0)
229d : 4c 40 23 JMP $2340 ; (is_valid_room_wall_for_door.s4 + 0)
.l2:
;  21, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
22a0 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
22a3 : 0a __ __ ASL
22a4 : 0a __ __ ASL
22a5 : 0a __ __ ASL
22a6 : aa __ __ TAX
22a7 : 69 00 __ ADC #$00
22a9 : 85 1b __ STA ACCU + 0 
22ab : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
22ae : a9 41 __ LDA #$41
22b0 : 69 00 __ ADC #$00
22b2 : 85 1c __ STA ACCU + 1 
22b4 : 8d f8 9f STA $9ff8 ; (room + 1)
;  23, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
22b7 : a5 0e __ LDA P1 ; (y + 0)
22b9 : dd 01 41 CMP $4101,x ; (rooms + 1)
22bc : 90 38 __ BCC $22f6 ; (is_valid_room_wall_for_door.s7 + 0)
.s8:
22be : a0 03 __ LDY #$03
22c0 : b1 1b __ LDA (ACCU + 0),y 
22c2 : 18 __ __ CLC
22c3 : 7d 01 41 ADC $4101,x ; (rooms + 1)
22c6 : a8 __ __ TAY
22c7 : a9 00 __ LDA #$00
22c9 : 2a __ __ ROL
22ca : 85 44 __ STA T3 + 1 
22cc : 98 __ __ TYA
22cd : e9 00 __ SBC #$00
22cf : a8 __ __ TAY
22d0 : a5 44 __ LDA T3 + 1 
22d2 : e9 00 __ SBC #$00
22d4 : d0 04 __ BNE $22da ; (is_valid_room_wall_for_door.s5 + 0)
.s1017:
22d6 : c4 0e __ CPY P1 ; (y + 0)
22d8 : 90 1c __ BCC $22f6 ; (is_valid_room_wall_for_door.s7 + 0)
.s5:
;  24, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
22da : a0 00 __ LDY #$00
22dc : b1 1b __ LDA (ACCU + 0),y 
22de : 85 43 __ STA T3 + 0 
22e0 : 38 __ __ SEC
22e1 : e9 01 __ SBC #$01
22e3 : 90 04 __ BCC $22e9 ; (is_valid_room_wall_for_door.s12 + 0)
.s1014:
22e5 : c5 0d __ CMP P0 ; (x + 0)
22e7 : f0 5a __ BEQ $2343 ; (is_valid_room_wall_for_door.s9 + 0)
.s12:
22e9 : a0 02 __ LDY #$02
22eb : b1 1b __ LDA (ACCU + 0),y 
22ed : 18 __ __ CLC
22ee : 65 43 __ ADC T3 + 0 
22f0 : b0 04 __ BCS $22f6 ; (is_valid_room_wall_for_door.s7 + 0)
.s1011:
22f2 : c5 0d __ CMP P0 ; (x + 0)
22f4 : f0 4d __ BEQ $2343 ; (is_valid_room_wall_for_door.s9 + 0)
.s7:
;  29, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
22f6 : a0 00 __ LDY #$00
22f8 : b1 1b __ LDA (ACCU + 0),y 
22fa : c5 0d __ CMP P0 ; (x + 0)
22fc : 90 02 __ BCC $2300 ; (is_valid_room_wall_for_door.s17 + 0)
.s1022:
22fe : d0 33 __ BNE $2333 ; (is_valid_room_wall_for_door.s3 + 0)
.s17:
2300 : 18 __ __ CLC
2301 : a0 02 __ LDY #$02
2303 : 71 1b __ ADC (ACCU + 0),y 
2305 : a8 __ __ TAY
2306 : a9 00 __ LDA #$00
2308 : 2a __ __ ROL
2309 : 85 44 __ STA T3 + 1 
230b : 98 __ __ TYA
230c : e9 00 __ SBC #$00
230e : a8 __ __ TAY
230f : a5 44 __ LDA T3 + 1 
2311 : e9 00 __ SBC #$00
2313 : d0 04 __ BNE $2319 ; (is_valid_room_wall_for_door.s14 + 0)
.s1008:
2315 : c4 0d __ CPY P0 ; (x + 0)
2317 : 90 1a __ BCC $2333 ; (is_valid_room_wall_for_door.s3 + 0)
.s14:
;  30, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
2319 : bd 01 41 LDA $4101,x ; (rooms + 1)
231c : 38 __ __ SEC
231d : e9 01 __ SBC #$01
231f : 90 04 __ BCC $2325 ; (is_valid_room_wall_for_door.s21 + 0)
.s1005:
2321 : c5 0e __ CMP P1 ; (y + 0)
2323 : f0 1e __ BEQ $2343 ; (is_valid_room_wall_for_door.s9 + 0)
.s21:
2325 : a0 03 __ LDY #$03
2327 : b1 1b __ LDA (ACCU + 0),y 
2329 : 18 __ __ CLC
232a : 7d 01 41 ADC $4101,x ; (rooms + 1)
232d : b0 04 __ BCS $2333 ; (is_valid_room_wall_for_door.s3 + 0)
.s1002:
232f : c5 0e __ CMP P1 ; (y + 0)
2331 : f0 10 __ BEQ $2343 ; (is_valid_room_wall_for_door.s9 + 0)
.s3:
;  20, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
2333 : ee f9 9f INC $9ff9 ; (bit_offset + 1)
2336 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
2339 : c5 1d __ CMP ACCU + 2 
233b : b0 03 __ BCS $2340 ; (is_valid_room_wall_for_door.s4 + 0)
233d : 4c a0 22 JMP $22a0 ; (is_valid_room_wall_for_door.l2 + 0)
.s4:
;  35, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
2340 : a9 00 __ LDA #$00
.s1001:
2342 : 60 __ __ RTS
.s9:
2343 : a9 01 __ LDA #$01
2345 : 60 __ __ RTS
--------------------------------------------------------------------
can_place_corridor_tile: ; can_place_corridor_tile(u8,u8)->u8
.s0:
; 102, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2346 : a5 13 __ LDA P6 ; (x + 0)
2348 : 85 0d __ STA P0 
234a : a5 14 __ LDA P7 ; (y + 0)
234c : 85 0e __ STA P1 
234e : ad 30 33 LDA $3330 ; (corridor_endpoint_override + 0)
2351 : f0 03 __ BEQ $2356 ; (can_place_corridor_tile.s3 + 0)
2353 : 4c db 23 JMP $23db ; (can_place_corridor_tile.s1 + 0)
.s3:
; 107, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2356 : 20 3f 1c JSR $1c3f ; (coords_in_bounds_fast.s0 + 0)
2359 : aa __ __ TAX
235a : f0 7e __ BEQ $23da ; (can_place_corridor_tile.s1001 + 0)
.s15:
; 109, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
235c : a5 13 __ LDA P6 ; (x + 0)
235e : 85 0f __ STA P2 
2360 : a5 14 __ LDA P7 ; (y + 0)
2362 : 85 10 __ STA P3 
2364 : 20 96 1c JSR $1c96 ; (is_outside_any_room.s0 + 0)
2367 : aa __ __ TAX
2368 : f0 70 __ BEQ $23da ; (can_place_corridor_tile.s1001 + 0)
.s19:
; 113, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
236a : e6 0f __ INC P2 
236c : 20 96 1c JSR $1c96 ; (is_outside_any_room.s0 + 0)
236f : aa __ __ TAX
2370 : f0 68 __ BEQ $23da ; (can_place_corridor_tile.s1001 + 0)
.s26:
; 114, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2372 : a6 13 __ LDX P6 ; (x + 0)
2374 : ca __ __ DEX
2375 : 86 0f __ STX P2 
2377 : 20 96 1c JSR $1c96 ; (is_outside_any_room.s0 + 0)
237a : aa __ __ TAX
237b : f0 5d __ BEQ $23da ; (can_place_corridor_tile.s1001 + 0)
.s25:
; 115, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
237d : e6 0f __ INC P2 
237f : e6 10 __ INC P3 
2381 : 20 96 1c JSR $1c96 ; (is_outside_any_room.s0 + 0)
2384 : aa __ __ TAX
2385 : f0 53 __ BEQ $23da ; (can_place_corridor_tile.s1001 + 0)
.s24:
; 116, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2387 : a6 14 __ LDX P7 ; (y + 0)
2389 : ca __ __ DEX
238a : 86 10 __ STX P3 
238c : 20 96 1c JSR $1c96 ; (is_outside_any_room.s0 + 0)
238f : aa __ __ TAX
2390 : f0 48 __ BEQ $23da ; (can_place_corridor_tile.s1001 + 0)
.s23:
; 121, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2392 : a9 00 __ LDA #$00
2394 : 8d f8 9f STA $9ff8 ; (room + 1)
2397 : ad 22 32 LDA $3222 ; (room_count + 0)
239a : f0 3c __ BEQ $23d8 ; (can_place_corridor_tile.s10 + 0)
.l29:
; 123, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
239c : ad f8 9f LDA $9ff8 ; (room + 1)
239f : 85 45 __ STA T6 + 0 
23a1 : 85 0d __ STA P0 
23a3 : a9 f7 __ LDA #$f7
23a5 : 85 0e __ STA P1 
23a7 : a9 9f __ LDA #$9f
23a9 : 85 0f __ STA P2 
23ab : a9 f6 __ LDA #$f6
23ad : 85 10 __ STA P3 
23af : a9 9f __ LDA #$9f
23b1 : 85 11 __ STA P4 
23b3 : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 124, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
23b6 : a5 13 __ LDA P6 ; (x + 0)
23b8 : 85 0f __ STA P2 
23ba : a5 14 __ LDA P7 ; (y + 0)
23bc : 85 10 __ STA P3 
23be : ad f7 9f LDA $9ff7 ; (byte_ptr + 1)
23c1 : 85 11 __ STA P4 
23c3 : ad f6 9f LDA $9ff6 ; (dx + 0)
23c6 : 85 12 __ STA P5 
23c8 : 20 f0 23 JSR $23f0 ; (manhattan_distance_fast.s0 + 0)
; 121, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
23cb : 18 __ __ CLC
23cc : a5 45 __ LDA T6 + 0 
23ce : 69 01 __ ADC #$01
23d0 : 8d f8 9f STA $9ff8 ; (room + 1)
23d3 : cd 22 32 CMP $3222 ; (room_count + 0)
23d6 : 90 c4 __ BCC $239c ; (can_place_corridor_tile.l29 + 0)
.s10:
; 105, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
23d8 : a9 01 __ LDA #$01
.s1001:
; 103, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
23da : 60 __ __ RTS
.s1:
23db : 20 3f 1c JSR $1c3f ; (coords_in_bounds_fast.s0 + 0)
23de : aa __ __ TAX
23df : f0 f9 __ BEQ $23da ; (can_place_corridor_tile.s1001 + 0)
.s6:
; 104, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
23e1 : a5 13 __ LDA P6 ; (x + 0)
23e3 : 85 0f __ STA P2 
23e5 : a5 14 __ LDA P7 ; (y + 0)
23e7 : 85 10 __ STA P3 
23e9 : 20 96 1c JSR $1c96 ; (is_outside_any_room.s0 + 0)
23ec : aa __ __ TAX
23ed : d0 e9 __ BNE $23d8 ; (can_place_corridor_tile.s10 + 0)
23ef : 60 __ __ RTS
--------------------------------------------------------------------
manhattan_distance_fast: ; manhattan_distance_fast(u8,u8,u8,u8)->u8
.s0:
;  50, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen_utility.h"
23f0 : a5 0f __ LDA P2 ; (x1 + 0)
23f2 : 85 0d __ STA P0 
23f4 : a5 11 __ LDA P4 ; (x2 + 0)
23f6 : 85 0e __ STA P1 
23f8 : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
23fb : 85 43 __ STA T0 + 0 
23fd : a5 10 __ LDA P3 ; (y1 + 0)
23ff : 85 0d __ STA P0 
2401 : a5 12 __ LDA P5 ; (y2 + 0)
2403 : 85 0e __ STA P1 
2405 : 20 e4 0d JSR $0de4 ; (fast_abs_diff.s0 + 0)
2408 : 18 __ __ CLC
2409 : 65 43 __ ADC T0 + 0 
.s1001:
240b : 60 __ __ RTS
--------------------------------------------------------------------
draw_rule_based_corridor: ; draw_rule_based_corridor(u8,u8)->u8
.s0:
; 146, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
240c : ad fc 9f LDA $9ffc ; (sstack + 2)
240f : 85 4a __ STA T1 + 0 
2411 : 85 0d __ STA P0 
2413 : a9 eb __ LDA #$eb
2415 : 85 0e __ STA P1 
2417 : a9 9f __ LDA #$9f
2419 : 85 11 __ STA P4 
241b : a9 9f __ LDA #$9f
241d : 85 0f __ STA P2 
241f : a9 ea __ LDA #$ea
2421 : 85 10 __ STA P3 
2423 : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 147, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2426 : ad fd 9f LDA $9ffd ; (sstack + 3)
2429 : 85 4c __ STA T2 + 0 
242b : 85 0d __ STA P0 
242d : a9 e9 __ LDA #$e9
242f : 85 0e __ STA P1 
2431 : a9 9f __ LDA #$9f
2433 : 85 11 __ STA P4 
2435 : a9 9f __ LDA #$9f
2437 : 85 0f __ STA P2 
2439 : a9 e8 __ LDA #$e8
243b : 85 10 __ STA P3 
243d : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
; 149, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2440 : a5 4a __ LDA T1 + 0 
2442 : 0a __ __ ASL
2443 : 0a __ __ ASL
2444 : 0a __ __ ASL
2445 : 85 50 __ STA T4 + 0 
2447 : 18 __ __ CLC
2448 : 69 00 __ ADC #$00
244a : 85 12 __ STA P5 
244c : a9 41 __ LDA #$41
244e : 69 00 __ ADC #$00
2450 : 85 13 __ STA P6 
2452 : ad e9 9f LDA $9fe9 ; (room2_center_x + 0)
2455 : 85 14 __ STA P7 
2457 : ad e8 9f LDA $9fe8 ; (up_y + 0)
245a : 85 15 __ STA P8 
245c : a9 ef __ LDA #$ef
245e : 85 16 __ STA P9 
2460 : a9 ee __ LDA #$ee
2462 : 8d fa 9f STA $9ffa ; (sstack + 0)
2465 : a9 9f __ LDA #$9f
2467 : 85 17 __ STA P10 
2469 : a9 9f __ LDA #$9f
246b : 8d fb 9f STA $9ffb ; (sstack + 1)
246e : 20 cc 21 JSR $21cc ; (find_room_exit.s0 + 0)
; 150, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2471 : a5 4c __ LDA T2 + 0 
2473 : 0a __ __ ASL
2474 : 0a __ __ ASL
2475 : 0a __ __ ASL
2476 : 18 __ __ CLC
2477 : 69 00 __ ADC #$00
2479 : 85 12 __ STA P5 
247b : a9 41 __ LDA #$41
247d : 69 00 __ ADC #$00
247f : 85 13 __ STA P6 
2481 : ad eb 9f LDA $9feb ; (screen_offset + 1)
2484 : 85 14 __ STA P7 
2486 : ad ea 9f LDA $9fea ; (x + 0)
2489 : 85 15 __ STA P8 
248b : a9 ed __ LDA #$ed
248d : 85 16 __ STA P9 
248f : a9 ec __ LDA #$ec
2491 : 8d fa 9f STA $9ffa ; (sstack + 0)
2494 : a9 9f __ LDA #$9f
2496 : 85 17 __ STA P10 
2498 : a9 9f __ LDA #$9f
249a : 8d fb 9f STA $9ffb ; (sstack + 1)
249d : 20 cc 21 JSR $21cc ; (find_room_exit.s0 + 0)
; 153, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
24a0 : a9 00 __ LDA #$00
24a2 : 8d e6 9f STA $9fe6 ; (check_y + 0)
24a5 : 8d e7 9f STA $9fe7 ; (dx + 1)
24a8 : 8d e4 9f STA $9fe4 ; (dy + 0)
24ab : 8d e5 9f STA $9fe5 ; (dy + 1)
; 167, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
24ae : a2 01 __ LDX #$01
24b0 : 8e 30 33 STX $3330 ; (corridor_endpoint_override + 0)
; 154, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
24b3 : a4 50 __ LDY T4 + 0 
24b5 : b9 00 41 LDA $4100,y ; (rooms + 0)
24b8 : 38 __ __ SEC
24b9 : e9 01 __ SBC #$01
24bb : 90 17 __ BCC $24d4 ; (draw_rule_based_corridor.s2 + 0)
.s1037:
24bd : cd ef 9f CMP $9fef ; (screen_pos + 1)
24c0 : d0 12 __ BNE $24d4 ; (draw_rule_based_corridor.s2 + 0)
.s1:
24c2 : a9 ff __ LDA #$ff
24c4 : 8d e6 9f STA $9fe6 ; (check_y + 0)
.s169:
; 155, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
24c7 : 8d e7 9f STA $9fe7 ; (dx + 1)
24ca : a9 00 __ LDA #$00
24cc : 8d e4 9f STA $9fe4 ; (dy + 0)
24cf : 8d e5 9f STA $9fe5 ; (dy + 1)
24d2 : f0 49 __ BEQ $251d ; (draw_rule_based_corridor.s3 + 0)
.s2:
; 155, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
24d4 : b9 02 41 LDA $4102,y ; (rooms + 2)
24d7 : 18 __ __ CLC
24d8 : 79 00 41 ADC $4100,y ; (rooms + 0)
24db : b0 0c __ BCS $24e9 ; (draw_rule_based_corridor.s5 + 0)
.s1034:
24dd : cd ef 9f CMP $9fef ; (screen_pos + 1)
24e0 : d0 07 __ BNE $24e9 ; (draw_rule_based_corridor.s5 + 0)
.s4:
24e2 : 8e e6 9f STX $9fe6 ; (check_y + 0)
24e5 : a9 00 __ LDA #$00
24e7 : f0 de __ BEQ $24c7 ; (draw_rule_based_corridor.s169 + 0)
.s5:
; 156, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
24e9 : b9 01 41 LDA $4101,y ; (rooms + 1)
24ec : 38 __ __ SEC
24ed : e9 01 __ SBC #$01
24ef : 90 17 __ BCC $2508 ; (draw_rule_based_corridor.s8 + 0)
.s1031:
24f1 : cd ee 9f CMP $9fee ; (entropy4 + 1)
24f4 : d0 12 __ BNE $2508 ; (draw_rule_based_corridor.s8 + 0)
.s7:
24f6 : a9 ff __ LDA #$ff
24f8 : 8d e4 9f STA $9fe4 ; (dy + 0)
.s194:
; 157, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
24fb : 8d e5 9f STA $9fe5 ; (dy + 1)
24fe : a9 00 __ LDA #$00
2500 : 8d e6 9f STA $9fe6 ; (check_y + 0)
2503 : 8d e7 9f STA $9fe7 ; (dx + 1)
2506 : f0 15 __ BEQ $251d ; (draw_rule_based_corridor.s3 + 0)
.s8:
; 157, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2508 : b9 03 41 LDA $4103,y ; (rooms + 3)
250b : 18 __ __ CLC
250c : 79 01 41 ADC $4101,y ; (rooms + 1)
250f : b0 0c __ BCS $251d ; (draw_rule_based_corridor.s3 + 0)
.s1028:
2511 : cd ee 9f CMP $9fee ; (entropy4 + 1)
2514 : d0 07 __ BNE $251d ; (draw_rule_based_corridor.s3 + 0)
.s10:
2516 : 8e e4 9f STX $9fe4 ; (dy + 0)
2519 : a9 00 __ LDA #$00
251b : f0 de __ BEQ $24fb ; (draw_rule_based_corridor.s194 + 0)
.s3:
; 160, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
251d : ad e6 9f LDA $9fe6 ; (check_y + 0)
2520 : 85 4e __ STA T3 + 0 
2522 : 18 __ __ CLC
2523 : 6d ef 9f ADC $9fef ; (screen_pos + 1)
2526 : 85 4a __ STA T1 + 0 
2528 : 85 13 __ STA P6 
252a : 8d e2 9f STA $9fe2 ; (h + 0)
; 163, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
252d : 8d de 9f STA $9fde ; (grid_positions + 13)
2530 : ad e7 9f LDA $9fe7 ; (dx + 1)
2533 : 85 4f __ STA T3 + 1 
2535 : 69 00 __ ADC #$00
2537 : 85 4b __ STA T1 + 1 
2539 : 8d df 9f STA $9fdf ; (grid_positions + 14)
; 160, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
253c : 8d e3 9f STA $9fe3 ; (x + 1)
; 161, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
253f : ad e4 9f LDA $9fe4 ; (dy + 0)
2542 : 85 50 __ STA T4 + 0 
2544 : 18 __ __ CLC
2545 : 6d ee 9f ADC $9fee ; (entropy4 + 1)
2548 : 85 14 __ STA P7 
254a : 8d e0 9f STA $9fe0 ; (grid_positions + 15)
; 164, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
254d : 8d dc 9f STA $9fdc ; (grid_positions + 11)
2550 : ad e5 9f LDA $9fe5 ; (dy + 1)
2553 : 85 51 __ STA T4 + 1 
2555 : 69 00 __ ADC #$00
2557 : 85 49 __ STA T0 + 1 
2559 : 8d dd 9f STA $9fdd ; (grid_positions + 12)
; 161, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
255c : 8d e1 9f STA $9fe1 ; (y + 1)
; 168, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
255f : 20 46 23 JSR $2346 ; (can_place_corridor_tile.s0 + 0)
2562 : aa __ __ TAX
2563 : f0 0f __ BEQ $2574 ; (draw_rule_based_corridor.s15 + 0)
.s13:
; 169, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2565 : a5 13 __ LDA P6 
2567 : 85 10 __ STA P3 
2569 : a5 14 __ LDA P7 
256b : 85 11 __ STA P4 
256d : a9 02 __ LDA #$02
256f : 85 12 __ STA P5 
2571 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s15:
; 171, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2574 : a9 00 __ LDA #$00
2576 : 8d 30 33 STA $3330 ; (corridor_endpoint_override + 0)
2579 : f0 0f __ BEQ $258a ; (draw_rule_based_corridor.l195 + 0)
.s20:
; 183, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
257b : a5 13 __ LDA P6 
257d : 85 10 __ STA P3 
257f : a5 14 __ LDA P7 
2581 : 85 11 __ STA P4 
2583 : a9 02 __ LDA #$02
2585 : 85 12 __ STA P5 
2587 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.l195:
; 184, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
258a : a5 13 __ LDA P6 
258c : 8d da 9f STA $9fda ; (grid_positions + 9)
; 185, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
258f : a5 14 __ LDA P7 
2591 : 8d d8 9f STA $9fd8 ; (grid_positions + 7)
2594 : a5 49 __ LDA T0 + 1 
2596 : 8d d9 9f STA $9fd9 ; (grid_positions + 8)
; 184, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2599 : a5 4b __ LDA T1 + 1 
259b : 8d db 9f STA $9fdb ; (grid_positions + 10)
259e : d0 07 __ BNE $25a7 ; (draw_rule_based_corridor.l19 + 0)
.s1025:
; 178, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25a0 : a5 4a __ LDA T1 + 0 
25a2 : cd ed 9f CMP $9fed ; (exit2_x + 0)
25a5 : f0 45 __ BEQ $25ec ; (draw_rule_based_corridor.s43 + 0)
.l19:
25a7 : ad e1 9f LDA $9fe1 ; (y + 1)
25aa : d0 08 __ BNE $25b4 ; (draw_rule_based_corridor.s17 + 0)
.s1022:
25ac : ad e0 9f LDA $9fe0 ; (grid_positions + 15)
25af : cd ec 9f CMP $9fec ; (exit2_y + 0)
25b2 : f0 38 __ BEQ $25ec ; (draw_rule_based_corridor.s43 + 0)
.s17:
; 180, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25b4 : ad e2 9f LDA $9fe2 ; (h + 0)
25b7 : 18 __ __ CLC
25b8 : 65 4e __ ADC T3 + 0 
25ba : 85 4a __ STA T1 + 0 
25bc : 85 13 __ STA P6 
25be : 8d e2 9f STA $9fe2 ; (h + 0)
25c1 : ad e3 9f LDA $9fe3 ; (x + 1)
25c4 : 65 4f __ ADC T3 + 1 
25c6 : 85 4b __ STA T1 + 1 
25c8 : 8d e3 9f STA $9fe3 ; (x + 1)
; 181, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25cb : ad e0 9f LDA $9fe0 ; (grid_positions + 15)
25ce : 18 __ __ CLC
25cf : 65 50 __ ADC T4 + 0 
25d1 : 85 14 __ STA P7 
25d3 : 8d e0 9f STA $9fe0 ; (grid_positions + 15)
25d6 : ad e1 9f LDA $9fe1 ; (y + 1)
25d9 : 65 51 __ ADC T4 + 1 
25db : 85 49 __ STA T0 + 1 
25dd : 8d e1 9f STA $9fe1 ; (y + 1)
; 182, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25e0 : 20 46 23 JSR $2346 ; (can_place_corridor_tile.s0 + 0)
25e3 : aa __ __ TAX
25e4 : d0 95 __ BNE $257b ; (draw_rule_based_corridor.s20 + 0)
.s152:
; 178, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25e6 : a5 4b __ LDA T1 + 1 
25e8 : d0 bd __ BNE $25a7 ; (draw_rule_based_corridor.l19 + 0)
25ea : f0 b4 __ BEQ $25a0 ; (draw_rule_based_corridor.s1025 + 0)
.s43:
; 190, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25ec : ad e3 9f LDA $9fe3 ; (x + 1)
25ef : d0 08 __ BNE $25f9 ; (draw_rule_based_corridor.s79 + 0)
.s1019:
25f1 : ad e2 9f LDA $9fe2 ; (h + 0)
25f4 : cd ed 9f CMP $9fed ; (exit2_x + 0)
25f7 : f0 75 __ BEQ $266e ; (draw_rule_based_corridor.s42 + 0)
.s79:
; 191, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25f9 : ad e0 9f LDA $9fe0 ; (grid_positions + 15)
25fc : 85 4c __ STA T2 + 0 
25fe : ad e1 9f LDA $9fe1 ; (y + 1)
2601 : 85 4d __ STA T2 + 1 
2603 : ad e3 9f LDA $9fe3 ; (x + 1)
2606 : 30 0a __ BMI $2612 ; (draw_rule_based_corridor.l96 + 0)
.s1018:
; 191, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2608 : d0 0e __ BNE $2618 ; (draw_rule_based_corridor.s97 + 0)
.s1015:
260a : ad e2 9f LDA $9fe2 ; (h + 0)
260d : cd ed 9f CMP $9fed ; (exit2_x + 0)
2610 : b0 06 __ BCS $2618 ; (draw_rule_based_corridor.s97 + 0)
.l96:
2612 : a9 00 __ LDA #$00
2614 : a2 01 __ LDX #$01
2616 : d0 03 __ BNE $261b ; (draw_rule_based_corridor.l98 + 0)
.s97:
; 191, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2618 : a9 ff __ LDA #$ff
261a : aa __ __ TAX
.l98:
261b : a8 __ __ TAY
261c : a5 4c __ LDA T2 + 0 
261e : 85 14 __ STA P7 
2620 : 8a __ __ TXA
2621 : 18 __ __ CLC
2622 : 6d e2 9f ADC $9fe2 ; (h + 0)
2625 : 85 13 __ STA P6 
2627 : 8d e2 9f STA $9fe2 ; (h + 0)
262a : 98 __ __ TYA
262b : 6d e3 9f ADC $9fe3 ; (x + 1)
262e : 85 4b __ STA T1 + 1 
2630 : 8d e3 9f STA $9fe3 ; (x + 1)
; 192, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2633 : 20 46 23 JSR $2346 ; (can_place_corridor_tile.s0 + 0)
2636 : aa __ __ TAX
2637 : f0 23 __ BEQ $265c ; (draw_rule_based_corridor.s23 + 0)
.s26:
; 193, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2639 : a5 13 __ LDA P6 
263b : 85 10 __ STA P3 
263d : a5 14 __ LDA P7 
263f : 85 11 __ STA P4 
2641 : a9 02 __ LDA #$02
2643 : 85 12 __ STA P5 
2645 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
; 194, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2648 : a5 13 __ LDA P6 
264a : 8d da 9f STA $9fda ; (grid_positions + 9)
264d : a5 4b __ LDA T1 + 1 
264f : 8d db 9f STA $9fdb ; (grid_positions + 10)
; 195, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2652 : a5 14 __ LDA P7 
2654 : 8d d8 9f STA $9fd8 ; (grid_positions + 7)
2657 : a5 4d __ LDA T2 + 1 
2659 : 8d d9 9f STA $9fd9 ; (grid_positions + 8)
.s23:
; 190, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
265c : a5 4b __ LDA T1 + 1 
265e : d0 07 __ BNE $2667 ; (draw_rule_based_corridor.s24 + 0)
.s1012:
2660 : a5 13 __ LDA P6 
2662 : cd ed 9f CMP $9fed ; (exit2_x + 0)
2665 : f0 07 __ BEQ $266e ; (draw_rule_based_corridor.s42 + 0)
.s24:
; 191, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2667 : ad e3 9f LDA $9fe3 ; (x + 1)
266a : 30 a6 __ BMI $2612 ; (draw_rule_based_corridor.l96 + 0)
266c : 10 9a __ BPL $2608 ; (draw_rule_based_corridor.s1018 + 0)
.s42:
; 198, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
266e : ad e1 9f LDA $9fe1 ; (y + 1)
2671 : d0 08 __ BNE $267b ; (draw_rule_based_corridor.s78 + 0)
.s1009:
2673 : ad e0 9f LDA $9fe0 ; (grid_positions + 15)
2676 : cd ec 9f CMP $9fec ; (exit2_y + 0)
2679 : f0 75 __ BEQ $26f0 ; (draw_rule_based_corridor.s31 + 0)
.s78:
; 199, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
267b : ad e2 9f LDA $9fe2 ; (h + 0)
267e : 85 4c __ STA T2 + 0 
2680 : ad e3 9f LDA $9fe3 ; (x + 1)
2683 : 85 4d __ STA T2 + 1 
2685 : ad e1 9f LDA $9fe1 ; (y + 1)
2688 : 30 0a __ BMI $2694 ; (draw_rule_based_corridor.l99 + 0)
.s1008:
; 199, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
268a : d0 0e __ BNE $269a ; (draw_rule_based_corridor.s100 + 0)
.s1005:
268c : ad e0 9f LDA $9fe0 ; (grid_positions + 15)
268f : cd ec 9f CMP $9fec ; (exit2_y + 0)
2692 : b0 06 __ BCS $269a ; (draw_rule_based_corridor.s100 + 0)
.l99:
2694 : a9 00 __ LDA #$00
2696 : a2 01 __ LDX #$01
2698 : d0 03 __ BNE $269d ; (draw_rule_based_corridor.l101 + 0)
.s100:
; 199, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
269a : a9 ff __ LDA #$ff
269c : aa __ __ TAX
.l101:
269d : a8 __ __ TAY
269e : a5 4c __ LDA T2 + 0 
26a0 : 85 13 __ STA P6 
26a2 : 8a __ __ TXA
26a3 : 18 __ __ CLC
26a4 : 6d e0 9f ADC $9fe0 ; (grid_positions + 15)
26a7 : 85 14 __ STA P7 
26a9 : 8d e0 9f STA $9fe0 ; (grid_positions + 15)
26ac : 98 __ __ TYA
26ad : 6d e1 9f ADC $9fe1 ; (y + 1)
26b0 : 85 4b __ STA T1 + 1 
26b2 : 8d e1 9f STA $9fe1 ; (y + 1)
; 200, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26b5 : 20 46 23 JSR $2346 ; (can_place_corridor_tile.s0 + 0)
26b8 : aa __ __ TAX
26b9 : f0 23 __ BEQ $26de ; (draw_rule_based_corridor.s29 + 0)
.s32:
; 201, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26bb : a5 13 __ LDA P6 
26bd : 85 10 __ STA P3 
26bf : a5 14 __ LDA P7 
26c1 : 85 11 __ STA P4 
26c3 : a9 02 __ LDA #$02
26c5 : 85 12 __ STA P5 
26c7 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
; 202, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26ca : a5 13 __ LDA P6 
26cc : 8d da 9f STA $9fda ; (grid_positions + 9)
26cf : a5 4d __ LDA T2 + 1 
26d1 : 8d db 9f STA $9fdb ; (grid_positions + 10)
; 203, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26d4 : a5 14 __ LDA P7 
26d6 : 8d d8 9f STA $9fd8 ; (grid_positions + 7)
26d9 : a5 4b __ LDA T1 + 1 
26db : 8d d9 9f STA $9fd9 ; (grid_positions + 8)
.s29:
; 198, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26de : a5 4b __ LDA T1 + 1 
26e0 : d0 07 __ BNE $26e9 ; (draw_rule_based_corridor.s30 + 0)
.s1002:
26e2 : a5 14 __ LDA P7 
26e4 : cd ec 9f CMP $9fec ; (exit2_y + 0)
26e7 : f0 07 __ BEQ $26f0 ; (draw_rule_based_corridor.s31 + 0)
.s30:
; 199, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26e9 : ad e1 9f LDA $9fe1 ; (y + 1)
26ec : 30 a6 __ BMI $2694 ; (draw_rule_based_corridor.l99 + 0)
26ee : 10 9a __ BPL $268a ; (draw_rule_based_corridor.s1008 + 0)
.s31:
; 209, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26f0 : ad ef 9f LDA $9fef ; (screen_pos + 1)
26f3 : 85 4a __ STA T1 + 0 
26f5 : 85 0d __ STA P0 
26f7 : ad ee 9f LDA $9fee ; (entropy4 + 1)
26fa : 85 4c __ STA T2 + 0 
26fc : 85 0e __ STA P1 
26fe : 20 91 22 JSR $2291 ; (is_valid_room_wall_for_door.s0 + 0)
2701 : aa __ __ TAX
2702 : f0 0f __ BEQ $2713 ; (draw_rule_based_corridor.s37 + 0)
.s35:
; 210, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2704 : a5 4a __ LDA T1 + 0 
2706 : 85 10 __ STA P3 
2708 : a5 4c __ LDA T2 + 0 
270a : 85 11 __ STA P4 
270c : a9 03 __ LDA #$03
270e : 85 12 __ STA P5 
2710 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s37:
; 213, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2713 : ad ed 9f LDA $9fed ; (exit2_x + 0)
2716 : 85 4a __ STA T1 + 0 
2718 : 85 0d __ STA P0 
271a : ad ec 9f LDA $9fec ; (exit2_y + 0)
271d : 85 4c __ STA T2 + 0 
271f : 85 0e __ STA P1 
2721 : 20 91 22 JSR $2291 ; (is_valid_room_wall_for_door.s0 + 0)
2724 : aa __ __ TAX
2725 : f0 0f __ BEQ $2736 ; (draw_rule_based_corridor.s40 + 0)
.s38:
; 214, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2727 : a5 4a __ LDA T1 + 0 
2729 : 85 10 __ STA P3 
272b : a5 4c __ LDA T2 + 0 
272d : 85 11 __ STA P4 
272f : a9 03 __ LDA #$03
2731 : 85 12 __ STA P5 
2733 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s40:
; 219, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2736 : a9 01 __ LDA #$01
.s1001:
2738 : 60 __ __ RTS
--------------------------------------------------------------------
add_walls: ; add_walls()->void
.s0:
;  23, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2739 : a9 2c __ LDA #$2c
273b : 85 0d __ STA P0 
273d : a9 28 __ LDA #$28
273f : 85 0e __ STA P1 
2741 : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
;  26, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2744 : a9 00 __ LDA #$00
2746 : 8d ee 9f STA $9fee ; (entropy4 + 1)
.l2:
;  27, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2749 : a9 00 __ LDA #$00
274b : 8d ef 9f STA $9fef ; (screen_pos + 1)
.l6:
;  28, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
274e : 85 4a __ STA T3 + 0 
2750 : 85 0f __ STA P2 
2752 : ad ee 9f LDA $9fee ; (entropy4 + 1)
2755 : 85 4b __ STA T4 + 0 
2757 : 85 10 __ STA P3 
2759 : 20 7a 1c JSR $1c7a ; (get_tile_raw.s0 + 0)
275c : a5 1b __ LDA ACCU + 0 
275e : 8d ed 9f STA $9fed ; (exit2_x + 0)
;  31, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2761 : c9 02 __ CMP #$02
2763 : f0 07 __ BEQ $276c ; (add_walls.s9 + 0)
.s12:
2765 : c9 03 __ CMP #$03
2767 : f0 03 __ BEQ $276c ; (add_walls.s9 + 0)
2769 : 4c fc 27 JMP $27fc ; (add_walls.s5 + 0)
.s9:
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
276c : a5 4b __ LDA T4 + 0 
276e : 85 48 __ STA T0 + 0 
2770 : f0 1e __ BEQ $2790 ; (add_walls.s15 + 0)
.s16:
2772 : aa __ __ TAX
2773 : ca __ __ DEX
2774 : 86 49 __ STX T1 + 0 
2776 : 86 10 __ STX P3 
2778 : 20 7a 1c JSR $1c7a ; (get_tile_raw.s0 + 0)
277b : a5 1b __ LDA ACCU + 0 
277d : d0 0f __ BNE $278e ; (add_walls.s1002 + 0)
.s13:
;  35, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
277f : a5 0f __ LDA P2 
2781 : 85 10 __ STA P3 
2783 : a5 49 __ LDA T1 + 0 
2785 : 85 11 __ STA P4 
2787 : a9 01 __ LDA #$01
2789 : 85 12 __ STA P5 
278b : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s1002:
;  39, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
278e : a5 4b __ LDA T4 + 0 
.s15:
2790 : c9 3f __ CMP #$3f
2792 : b0 20 __ BCS $27b4 ; (add_walls.s19 + 0)
.s20:
2794 : a5 4a __ LDA T3 + 0 
2796 : 85 0f __ STA P2 
2798 : e6 48 __ INC T0 + 0 
279a : a5 48 __ LDA T0 + 0 
279c : 85 10 __ STA P3 
279e : 20 7a 1c JSR $1c7a ; (get_tile_raw.s0 + 0)
27a1 : a5 1b __ LDA ACCU + 0 
27a3 : d0 0f __ BNE $27b4 ; (add_walls.s19 + 0)
.s17:
;  40, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
27a5 : a5 0f __ LDA P2 
27a7 : 85 10 __ STA P3 
27a9 : a5 48 __ LDA T0 + 0 
27ab : 85 11 __ STA P4 
27ad : a9 01 __ LDA #$01
27af : 85 12 __ STA P5 
27b1 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s19:
;  44, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
27b4 : a5 4a __ LDA T3 + 0 
27b6 : f0 1f __ BEQ $27d7 ; (add_walls.s23 + 0)
.s24:
27b8 : a6 4b __ LDX T4 + 0 
27ba : 86 10 __ STX P3 
27bc : 38 __ __ SEC
27bd : e9 01 __ SBC #$01
27bf : 85 0f __ STA P2 
27c1 : 20 7a 1c JSR $1c7a ; (get_tile_raw.s0 + 0)
27c4 : a5 1b __ LDA ACCU + 0 
27c6 : d0 0f __ BNE $27d7 ; (add_walls.s23 + 0)
.s21:
;  45, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
27c8 : a5 0f __ LDA P2 
27ca : 85 10 __ STA P3 
27cc : a5 4b __ LDA T4 + 0 
27ce : 85 11 __ STA P4 
27d0 : a9 01 __ LDA #$01
27d2 : 85 12 __ STA P5 
27d4 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s23:
;  49, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
27d7 : a6 4a __ LDX T3 + 0 
27d9 : e0 3f __ CPX #$3f
27db : b0 1f __ BCS $27fc ; (add_walls.s5 + 0)
.s28:
27dd : e8 __ __ INX
27de : 86 48 __ STX T0 + 0 
27e0 : 86 0f __ STX P2 
27e2 : a5 4b __ LDA T4 + 0 
27e4 : 85 10 __ STA P3 
27e6 : 20 7a 1c JSR $1c7a ; (get_tile_raw.s0 + 0)
27e9 : a5 1b __ LDA ACCU + 0 
27eb : d0 0f __ BNE $27fc ; (add_walls.s5 + 0)
.s25:
;  50, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
27ed : a5 48 __ LDA T0 + 0 
27ef : 85 10 __ STA P3 
27f1 : a5 4b __ LDA T4 + 0 
27f3 : 85 11 __ STA P4 
27f5 : a9 01 __ LDA #$01
27f7 : 85 12 __ STA P5 
27f9 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s5:
;  27, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
27fc : 18 __ __ CLC
27fd : a5 4a __ LDA T3 + 0 
27ff : 69 01 __ ADC #$01
2801 : 8d ef 9f STA $9fef ; (screen_pos + 1)
2804 : c9 40 __ CMP #$40
2806 : b0 03 __ BCS $280b ; (add_walls.s8 + 0)
2808 : 4c 4e 27 JMP $274e ; (add_walls.l6 + 0)
.s8:
;  53, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
280b : a5 4b __ LDA T4 + 0 
280d : 29 0f __ AND #$0f
280f : d0 0b __ BNE $281c ; (add_walls.s1 + 0)
.s29:
2811 : a9 40 __ LDA #$40
2813 : 85 0d __ STA P0 
2815 : a9 17 __ LDA #$17
2817 : 85 0e __ STA P1 
2819 : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
.s1:
;  26, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
281c : 18 __ __ CLC
281d : a5 4b __ LDA T4 + 0 
281f : 69 01 __ ADC #$01
2821 : 8d ee 9f STA $9fee ; (entropy4 + 1)
2824 : c9 40 __ CMP #$40
2826 : b0 03 __ BCS $282b ; (add_walls.s1001 + 0)
2828 : 4c 49 27 JMP $2749 ; (add_walls.l2 + 0)
.s1001:
;  55, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
282b : 60 __ __ RTS
--------------------------------------------------------------------
282c : __ __ __ BYT 0a 0a 43 52 45 41 54 49 4e 47 20 57 41 4c 4c 53 : ..CREATING WALLS
283c : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
add_stairs: ; add_stairs()->void
.s0:
;  64, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
283d : a9 53 __ LDA #$53
283f : 85 0d __ STA P0 
2841 : a9 29 __ LDA #$29
2843 : 85 0e __ STA P1 
2845 : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
;  66, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2848 : ad 22 32 LDA $3222 ; (room_count + 0)
284b : c9 02 __ CMP #$02
284d : b0 01 __ BCS $2850 ; (add_stairs.s3 + 0)
284f : 60 __ __ RTS
.s3:
;  69, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2850 : 85 4a __ STA T3 + 0 
2852 : e9 01 __ SBC #$01
2854 : 8d ee 9f STA $9fee ; (entropy4 + 1)
;  68, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2857 : a9 00 __ LDA #$00
2859 : 8d ef 9f STA $9fef ; (screen_pos + 1)
;  71, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
285c : 8d ed 9f STA $9fed ; (exit2_x + 0)
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
285f : 8d ec 9f STA $9fec ; (exit2_y + 0)
.l6:
;  73, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2862 : 85 4b __ STA T4 + 0 
2864 : 29 03 __ AND #$03
2866 : d0 0b __ BNE $2873 ; (add_stairs.s11 + 0)
.s9:
2868 : a9 40 __ LDA #$40
286a : 85 0d __ STA P0 
286c : a9 17 __ LDA #$17
286e : 85 0e __ STA P1 
2870 : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
.s11:
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2873 : a6 4b __ LDX T4 + 0 
2875 : e8 __ __ INX
2876 : 8e ec 9f STX $9fec ; (exit2_y + 0)
;  74, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2879 : a5 4b __ LDA T4 + 0 
287b : 0a __ __ ASL
287c : 0a __ __ ASL
287d : 0a __ __ ASL
287e : a8 __ __ TAY
287f : ad ed 9f LDA $9fed ; (exit2_x + 0)
2882 : d9 07 41 CMP $4107,y ; (rooms + 7)
2885 : b0 0b __ BCS $2892 ; (add_stairs.s5 + 0)
.s12:
;  76, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2887 : a5 4b __ LDA T4 + 0 
2889 : 8d ef 9f STA $9fef ; (screen_pos + 1)
;  75, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
288c : b9 07 41 LDA $4107,y ; (rooms + 7)
288f : 8d ed 9f STA $9fed ; (exit2_x + 0)
.s5:
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2892 : ad ec 9f LDA $9fec ; (exit2_y + 0)
2895 : c5 4a __ CMP T3 + 0 
2897 : 90 c9 __ BCC $2862 ; (add_stairs.l6 + 0)
.s8:
;  81, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2899 : a9 00 __ LDA #$00
289b : 8d eb 9f STA $9feb ; (screen_offset + 1)
;  82, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
289e : 8d ea 9f STA $9fea ; (x + 0)
.l16:
;  83, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
28a1 : 85 4b __ STA T4 + 0 
28a3 : 29 03 __ AND #$03
28a5 : d0 0b __ BNE $28b2 ; (add_stairs.s76 + 0)
.s19:
28a7 : a9 40 __ LDA #$40
28a9 : 85 0d __ STA P0 
28ab : a9 17 __ LDA #$17
28ad : 85 0e __ STA P1 
28af : 20 2d 10 JSR $102d ; (print_text.s0 + 0)
.s76:
;  84, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
28b2 : a5 4b __ LDA T4 + 0 
28b4 : cd ef 9f CMP $9fef ; (screen_pos + 1)
28b7 : f0 19 __ BEQ $28d2 ; (add_stairs.s15 + 0)
.s25:
28b9 : 0a __ __ ASL
28ba : 0a __ __ ASL
28bb : 0a __ __ ASL
28bc : a8 __ __ TAY
28bd : ad eb 9f LDA $9feb ; (screen_offset + 1)
28c0 : d9 07 41 CMP $4107,y ; (rooms + 7)
28c3 : b0 0b __ BCS $28d0 ; (add_stairs.s1002 + 0)
.s22:
;  86, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
28c5 : a5 4b __ LDA T4 + 0 
28c7 : 8d ee 9f STA $9fee ; (entropy4 + 1)
;  85, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
28ca : b9 07 41 LDA $4107,y ; (rooms + 7)
28cd : 8d eb 9f STA $9feb ; (screen_offset + 1)
.s1002:
;  82, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
28d0 : a5 4b __ LDA T4 + 0 
.s15:
28d2 : 18 __ __ CLC
28d3 : 69 01 __ ADC #$01
28d5 : 8d ea 9f STA $9fea ; (x + 0)
28d8 : c5 4a __ CMP T3 + 0 
28da : 90 c5 __ BCC $28a1 ; (add_stairs.l16 + 0)
.s18:
;  90, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
28dc : ad ef 9f LDA $9fef ; (screen_pos + 1)
28df : 85 0d __ STA P0 
28e1 : a9 e9 __ LDA #$e9
28e3 : 85 0e __ STA P1 
28e5 : a9 9f __ LDA #$9f
28e7 : 85 11 __ STA P4 
28e9 : a9 9f __ LDA #$9f
28eb : 85 0f __ STA P2 
28ed : a9 e8 __ LDA #$e8
28ef : 85 10 __ STA P3 
28f1 : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
;  91, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
28f4 : ad e9 9f LDA $9fe9 ; (room2_center_x + 0)
28f7 : 85 48 __ STA T1 + 0 
28f9 : 85 0d __ STA P0 
28fb : ad e8 9f LDA $9fe8 ; (up_y + 0)
28fe : 85 49 __ STA T2 + 0 
2900 : 85 0e __ STA P1 
2902 : 20 dd 14 JSR $14dd ; (coords_in_bounds.s0 + 0)
2905 : aa __ __ TAX
2906 : f0 0f __ BEQ $2917 ; (add_stairs.s28 + 0)
.s26:
;  92, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2908 : a5 48 __ LDA T1 + 0 
290a : 85 10 __ STA P3 
290c : a5 49 __ LDA T2 + 0 
290e : 85 11 __ STA P4 
2910 : a9 04 __ LDA #$04
2912 : 85 12 __ STA P5 
2914 : 20 3b 16 JSR $163b ; (set_tile_raw.s0 + 0)
.s28:
;  97, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2917 : ad ee 9f LDA $9fee ; (entropy4 + 1)
291a : 85 0d __ STA P0 
291c : a9 e7 __ LDA #$e7
291e : 85 0e __ STA P1 
2920 : a9 9f __ LDA #$9f
2922 : 85 11 __ STA P4 
2924 : a9 9f __ LDA #$9f
2926 : 85 0f __ STA P2 
2928 : a9 e6 __ LDA #$e6
292a : 85 10 __ STA P3 
292c : 20 4d 0d JSR $0d4d ; (get_room_center.s0 + 0)
;  98, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
292f : ad e7 9f LDA $9fe7 ; (dx + 1)
2932 : 85 48 __ STA T1 + 0 
2934 : 85 0d __ STA P0 
2936 : ad e6 9f LDA $9fe6 ; (check_y + 0)
2939 : 85 49 __ STA T2 + 0 
293b : 85 0e __ STA P1 
293d : 20 dd 14 JSR $14dd ; (coords_in_bounds.s0 + 0)
2940 : aa __ __ TAX
2941 : d0 01 __ BNE $2944 ; (add_stairs.s29 + 0)
.s1001:
;  66, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2943 : 60 __ __ RTS
.s29:
;  99, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2944 : a5 48 __ LDA T1 + 0 
2946 : 85 10 __ STA P3 
2948 : a5 49 __ LDA T2 + 0 
294a : 85 11 __ STA P4 
294c : a9 05 __ LDA #$05
294e : 85 12 __ STA P5 
2950 : 4c 3b 16 JMP $163b ; (set_tile_raw.s0 + 0)
--------------------------------------------------------------------
2953 : __ __ __ BYT 0a 0a 50 4c 41 43 49 4e 47 20 53 54 41 49 52 53 : ..PLACING STAIRS
2963 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
krnio_setnam: ; krnio_setnam(const u8*)->void
.s0:
;  34, "E:/Apps/oscar64/include/c64/kernalio.c"
2964 : a5 0d __ LDA P0 
2966 : 05 0e __ ORA P1 
2968 : f0 08 __ BEQ $2972 ; (krnio_setnam.s0 + 14)
296a : a0 ff __ LDY #$ff
296c : c8 __ __ INY
296d : b1 0d __ LDA (P0),y 
296f : d0 fb __ BNE $296c ; (krnio_setnam.s0 + 8)
2971 : 98 __ __ TYA
2972 : a6 0d __ LDX P0 
2974 : a4 0e __ LDY P1 
2976 : 20 bd ff JSR $ffbd 
.s1001:
;  49, "E:/Apps/oscar64/include/c64/kernalio.c"
2979 : 60 __ __ RTS
--------------------------------------------------------------------
297a : __ __ __ BYT 4d 41 50 44 41 54 41 2e 42 49 4e 00             : MAPDATA.BIN.
--------------------------------------------------------------------
krnio_save: ; krnio_save(u8,const u8*,const u8*)->bool
.s0:
; 161, "E:/Apps/oscar64/include/c64/kernalio.c"
2986 : a9 00 __ LDA #$00
2988 : a6 0d __ LDX P0 
298a : a0 00 __ LDY #$00
298c : 20 ba ff JSR $ffba 
298f : a9 0e __ LDA #$0e
2991 : a6 10 __ LDX P3 
2993 : a4 11 __ LDY P4 
2995 : 20 d8 ff JSR $ffd8 
2998 : a9 00 __ LDA #$00
299a : 2a __ __ ROL
299b : 49 01 __ EOR #$01
299d : 85 1b __ STA ACCU + 0 
299f : a5 1b __ LDA ACCU + 0 
29a1 : f0 02 __ BEQ $29a5 ; (krnio_save.s1001 + 0)
.s1006:
29a3 : a9 01 __ LDA #$01
.s1001:
; 158, "E:/Apps/oscar64/include/c64/kernalio.c"
29a5 : 60 __ __ RTS
--------------------------------------------------------------------
puts: ; puts(const u8*)->void
.l1:
;  17, "E:/Apps/oscar64/include/stdio.c"
29a6 : a0 00 __ LDY #$00
29a8 : b1 0f __ LDA (P2),y ; (str + 0)
29aa : 8d f8 9f STA $9ff8 ; (room + 1)
29ad : e6 0f __ INC P2 ; (str + 0)
29af : d0 02 __ BNE $29b3 ; (puts.s1003 + 0)
.s1002:
29b1 : e6 10 __ INC P3 ; (str + 1)
.s1003:
29b3 : aa __ __ TAX
29b4 : f0 08 __ BEQ $29be ; (puts.s1001 + 0)
.s2:
;  18, "E:/Apps/oscar64/include/stdio.c"
29b6 : 85 0e __ STA P1 
29b8 : 20 bf 29 JSR $29bf ; (putpch.s0 + 0)
29bb : 4c a6 29 JMP $29a6 ; (puts.l1 + 0)
.s1001:
;  19, "E:/Apps/oscar64/include/stdio.c"
29be : 60 __ __ RTS
--------------------------------------------------------------------
putpch: ; putpch(u8)->void
.s0:
; 204, "E:/Apps/oscar64/include/conio.c"
29bf : ad 31 33 LDA $3331 ; (giocharmap + 0)
29c2 : f0 33 __ BEQ $29f7 ; (putpch.s1004 + 0)
.s1:
; 206, "E:/Apps/oscar64/include/conio.c"
29c4 : a5 0e __ LDA P1 ; (c + 0)
29c6 : c9 0a __ CMP #$0a
29c8 : d0 05 __ BNE $29cf ; (putpch.s5 + 0)
.s4:
; 239, "E:/Apps/oscar64/include/conio.c"
29ca : a9 0d __ LDA #$0d
.s1002:
29cc : 4c 20 2a JMP $2a20 ; (putrch.s0 + 0)
.s5:
; 208, "E:/Apps/oscar64/include/conio.c"
29cf : c9 09 __ CMP #$09
29d1 : f0 30 __ BEQ $2a03 ; (putpch.s7 + 0)
.s8:
; 216, "E:/Apps/oscar64/include/conio.c"
29d3 : ad 31 33 LDA $3331 ; (giocharmap + 0)
29d6 : c9 02 __ CMP #$02
29d8 : 90 1d __ BCC $29f7 ; (putpch.s1004 + 0)
.s13:
; 218, "E:/Apps/oscar64/include/conio.c"
29da : a5 0e __ LDA P1 ; (c + 0)
29dc : c9 41 __ CMP #$41
29de : 90 ec __ BCC $29cc ; (putpch.s1002 + 0)
.s19:
29e0 : c9 7b __ CMP #$7b
29e2 : b0 e8 __ BCS $29cc ; (putpch.s1002 + 0)
.s16:
; 220, "E:/Apps/oscar64/include/conio.c"
29e4 : c9 61 __ CMP #$61
29e6 : b0 04 __ BCS $29ec ; (putpch.s20 + 0)
.s23:
29e8 : c9 5b __ CMP #$5b
29ea : b0 e0 __ BCS $29cc ; (putpch.s1002 + 0)
.s20:
; 230, "E:/Apps/oscar64/include/conio.c"
29ec : 49 20 __ EOR #$20
29ee : 85 0e __ STA P1 ; (c + 0)
29f0 : ad 31 33 LDA $3331 ; (giocharmap + 0)
29f3 : c9 02 __ CMP #$02
29f5 : f0 05 __ BEQ $29fc ; (putpch.s24 + 0)
.s1004:
; 239, "E:/Apps/oscar64/include/conio.c"
29f7 : a5 0e __ LDA P1 ; (c + 0)
29f9 : 4c cc 29 JMP $29cc ; (putpch.s1002 + 0)
.s24:
; 240, "E:/Apps/oscar64/include/conio.c"
29fc : a5 0e __ LDA P1 ; (c + 0)
29fe : 29 5f __ AND #$5f
2a00 : 4c cc 29 JMP $29cc ; (putpch.s1002 + 0)
.s7:
; 210, "E:/Apps/oscar64/include/conio.c"
2a03 : 20 1b 2a JSR $2a1b ; (wherex.s0 + 0)
2a06 : 29 03 __ AND #$03
2a08 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
.l10:
; 212, "E:/Apps/oscar64/include/conio.c"
2a0b : a9 20 __ LDA #$20
2a0d : 20 20 2a JSR $2a20 ; (putrch.s0 + 0)
; 213, "E:/Apps/oscar64/include/conio.c"
2a10 : ee f9 9f INC $9ff9 ; (bit_offset + 1)
2a13 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
2a16 : c9 04 __ CMP #$04
2a18 : 90 f1 __ BCC $2a0b ; (putpch.l10 + 0)
.s1001:
; 240, "E:/Apps/oscar64/include/conio.c"
2a1a : 60 __ __ RTS
--------------------------------------------------------------------
wherex: ; wherex()->u8
.s0:
; 413, "E:/Apps/oscar64/include/conio.c"
2a1b : a5 d3 __ LDA $d3 
.s1001:
2a1d : a5 d3 __ LDA $d3 
; 413, "E:/Apps/oscar64/include/conio.c"
2a1f : 60 __ __ RTS
--------------------------------------------------------------------
putrch: ; putrch(u8)->void
.s0:
2a20 : 85 0d __ STA P0 
; 193, "E:/Apps/oscar64/include/conio.c"
2a22 : a5 0d __ LDA P0 
2a24 : 20 d2 ff JSR $ffd2 
.s1001:
; 196, "E:/Apps/oscar64/include/conio.c"
2a27 : 60 __ __ RTS
--------------------------------------------------------------------
2a28 : __ __ __ BYT 46 69 6c 65 20 73 61 76 65 20 65 72 72 6f 72 21 : File save error!
2a38 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
render_map_viewport: ; render_map_viewport(u8)->void
.s0:
; 140, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a39 : a5 14 __ LDA P7 ; (force_refresh + 0)
2a3b : d0 21 __ BNE $2a5e ; (render_map_viewport.s1 + 0)
.s3:
; 152, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a3d : ad 56 37 LDA $3756 ; (screen_dirty + 0)
2a40 : f0 1b __ BEQ $2a5d ; (render_map_viewport.s1001 + 0)
.s6:
; 157, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a42 : ad 57 37 LDA $3757 ; (last_scroll_direction + 0)
2a45 : 8d e3 9f STA $9fe3 ; (x + 1)
; 160, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a48 : d0 06 __ BNE $2a50 ; (render_map_viewport.s8 + 0)
.s9:
; 165, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a4a : 20 89 2d JSR $2d89 ; (update_full_screen.s0 + 0)
; 171, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a4d : 4c 55 2a JMP $2a55 ; (render_map_viewport.s1006 + 0)
.s8:
; 162, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a50 : 85 13 __ STA P6 
2a52 : 20 91 2a JSR $2a91 ; (update_screen_with_perfect_scroll.s0 + 0)
.s1006:
; 170, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a55 : a9 00 __ LDA #$00
2a57 : 8d 57 37 STA $3757 ; (last_scroll_direction + 0)
; 168, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a5a : 8d 56 37 STA $3756 ; (screen_dirty + 0)
.s1001:
; 153, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a5d : 60 __ __ RTS
.s1:
; 142, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a5e : 20 65 0b JSR $0b65 ; (oscar_clrscr.s0 + 0)
; 148, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a61 : a9 00 __ LDA #$00
2a63 : 8d 57 37 STA $3757 ; (last_scroll_direction + 0)
; 147, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a66 : a9 01 __ LDA #$01
2a68 : 8d 56 37 STA $3756 ; (screen_dirty + 0)
; 145, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a6b : a9 20 __ LDA #$20
2a6d : a2 fa __ LDX #$fa
.l1003:
2a6f : ca __ __ DEX
2a70 : 9d 00 04 STA $0400,x 
2a73 : 9d fa 04 STA $04fa,x 
2a76 : 9d f4 05 STA $05f4,x 
2a79 : 9d ee 06 STA $06ee,x 
2a7c : d0 f1 __ BNE $2a6f ; (render_map_viewport.l1003 + 0)
.s1002:
; 146, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a7e : a2 fa __ LDX #$fa
.l1005:
2a80 : ca __ __ DEX
2a81 : 9d 6e 33 STA $336e,x ; (screen_buffer + 0)
2a84 : 9d 68 34 STA $3468,x ; (screen_buffer + 250)
2a87 : 9d 62 35 STA $3562,x ; (screen_buffer + 500)
2a8a : 9d 5c 36 STA $365c,x ; (screen_buffer + 750)
2a8d : d0 f1 __ BNE $2a80 ; (render_map_viewport.l1005 + 0)
2a8f : f0 b1 __ BEQ $2a42 ; (render_map_viewport.s6 + 0)
--------------------------------------------------------------------
update_screen_with_perfect_scroll: ; update_screen_with_perfect_scroll(u8)->void
.s0:
; 272, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a91 : a5 13 __ LDA P6 ; (scroll_dir + 0)
2a93 : f0 1c __ BEQ $2ab1 ; (update_screen_with_perfect_scroll.s1 + 0)
.s4:
2a95 : c9 05 __ CMP #$05
2a97 : b0 18 __ BCS $2ab1 ; (update_screen_with_perfect_scroll.s1 + 0)
.s3:
; 278, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2a99 : c9 03 __ CMP #$03
2a9b : d0 03 __ BNE $2aa0 ; (update_screen_with_perfect_scroll.s28 + 0)
2a9d : 4c d8 2c JMP $2cd8 ; (update_screen_with_perfect_scroll.s17 + 0)
.s28:
2aa0 : b0 03 __ BCS $2aa5 ; (update_screen_with_perfect_scroll.s29 + 0)
2aa2 : 4c 5e 2b JMP $2b5e ; (update_screen_with_perfect_scroll.s30 + 0)
.s29:
2aa5 : c9 04 __ CMP #$04
2aa7 : f0 01 __ BEQ $2aaa ; (update_screen_with_perfect_scroll.s22 + 0)
.s1001:
; 357, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2aa9 : 60 __ __ RTS
.s22:
; 282, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2aaa : ad 6c 33 LDA $336c ; (view + 0)
2aad : c9 18 __ CMP #$18
2aaf : 90 03 __ BCC $2ab4 ; (update_screen_with_perfect_scroll.s70 + 0)
.s1:
; 273, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ab1 : 4c 89 2d JMP $2d89 ; (update_full_screen.s0 + 0)
.s70:
; 343, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ab4 : 85 51 __ STA T6 + 0 
2ab6 : a9 27 __ LDA #$27
2ab8 : 85 11 __ STA P4 
2aba : a9 00 __ LDA #$00
2abc : 85 12 __ STA P5 
2abe : 8d e8 9f STA $9fe8 ; (up_y + 0)
.l72:
; 344, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ac1 : 85 52 __ STA T7 + 0 
2ac3 : 0a __ __ ASL
2ac4 : 85 1b __ STA ACCU + 0 
2ac6 : a9 00 __ LDA #$00
2ac8 : 8d e9 9f STA $9fe9 ; (room2_center_x + 0)
2acb : 2a __ __ ROL
2acc : 06 1b __ ASL ACCU + 0 
2ace : 2a __ __ ROL
2acf : aa __ __ TAX
2ad0 : a5 1b __ LDA ACCU + 0 
2ad2 : 65 52 __ ADC T7 + 0 
2ad4 : 85 4f __ STA T3 + 0 
2ad6 : 8a __ __ TXA
2ad7 : 69 00 __ ADC #$00
2ad9 : 06 4f __ ASL T3 + 0 
2adb : 2a __ __ ROL
2adc : 06 4f __ ASL T3 + 0 
2ade : 2a __ __ ROL
2adf : 06 4f __ ASL T3 + 0 
2ae1 : 2a __ __ ROL
2ae2 : 85 50 __ STA T3 + 1 
2ae4 : 18 __ __ CLC
2ae5 : 69 04 __ ADC #$04
2ae7 : 85 4c __ STA T1 + 1 
2ae9 : a6 4f __ LDX T3 + 0 
2aeb : 86 4b __ STX T1 + 0 
2aed : 18 __ __ CLC
.l1014:
; 345, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2aee : ac e9 9f LDY $9fe9 ; (room2_center_x + 0)
2af1 : c8 __ __ INY
2af2 : b1 4b __ LDA (T1 + 0),y 
2af4 : 88 __ __ DEY
2af5 : 91 4b __ STA (T1 + 0),y 
; 344, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2af7 : 98 __ __ TYA
2af8 : 69 01 __ ADC #$01
2afa : 8d e9 9f STA $9fe9 ; (room2_center_x + 0)
2afd : c9 27 __ CMP #$27
2aff : 90 ed __ BCC $2aee ; (update_screen_with_perfect_scroll.l1014 + 0)
.s78:
; 348, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2b01 : 18 __ __ CLC
2b02 : a9 6e __ LDA #$6e
2b04 : 65 4f __ ADC T3 + 0 
2b06 : 85 4b __ STA T1 + 0 
2b08 : 85 0d __ STA P0 
2b0a : a9 33 __ LDA #$33
2b0c : 65 50 __ ADC T3 + 1 
2b0e : 85 4c __ STA T1 + 1 
2b10 : 85 0e __ STA P1 
2b12 : 8a __ __ TXA
2b13 : 18 __ __ CLC
2b14 : 69 6f __ ADC #$6f
2b16 : 85 0f __ STA P2 
2b18 : a5 50 __ LDA T3 + 1 
2b1a : 69 33 __ ADC #$33
2b1c : 85 10 __ STA P3 
2b1e : 20 c3 2e JSR $2ec3 ; (memmove.s0 + 0)
; 351, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2b21 : 38 __ __ SEC
2b22 : a5 51 __ LDA T6 + 0 
2b24 : e9 d9 __ SBC #$d9
2b26 : 85 0d __ STA P0 
2b28 : ad 6d 33 LDA $336d ; (view + 1)
2b2b : 18 __ __ CLC
2b2c : 65 52 __ ADC T7 + 0 
2b2e : 85 0e __ STA P1 
2b30 : 20 f3 2d JSR $2df3 ; (get_map_tile_fast.s0 + 0)
2b33 : 8d e4 9f STA $9fe4 ; (dy + 0)
; 352, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2b36 : 18 __ __ CLC
2b37 : a9 27 __ LDA #$27
2b39 : 65 4f __ ADC T3 + 0 
2b3b : 85 43 __ STA T0 + 0 
2b3d : a9 04 __ LDA #$04
2b3f : 65 50 __ ADC T3 + 1 
2b41 : 85 44 __ STA T0 + 1 
2b43 : ad e4 9f LDA $9fe4 ; (dy + 0)
2b46 : a0 00 __ LDY #$00
2b48 : 91 43 __ STA (T0 + 0),y 
; 353, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2b4a : a0 27 __ LDY #$27
2b4c : 91 4b __ STA (T1 + 0),y 
; 343, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2b4e : 18 __ __ CLC
2b4f : a5 52 __ LDA T7 + 0 
2b51 : 69 01 __ ADC #$01
2b53 : 8d e8 9f STA $9fe8 ; (up_y + 0)
2b56 : c9 19 __ CMP #$19
2b58 : b0 03 __ BCS $2b5d ; (update_screen_with_perfect_scroll.s78 + 92)
2b5a : 4c c1 2a JMP $2ac1 ; (update_screen_with_perfect_scroll.l72 + 0)
2b5d : 60 __ __ RTS
.s30:
; 278, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2b5e : c9 01 __ CMP #$01
2b60 : f0 03 __ BEQ $2b65 ; (update_screen_with_perfect_scroll.s7 + 0)
2b62 : 4c 15 2c JMP $2c15 ; (update_screen_with_perfect_scroll.s31 + 0)
.s7:
; 279, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2b65 : ad 6d 33 LDA $336d ; (view + 1)
2b68 : d0 03 __ BNE $2b6d ; (update_screen_with_perfect_scroll.s35 + 0)
2b6a : 4c b1 2a JMP $2ab1 ; (update_screen_with_perfect_scroll.s1 + 0)
.s35:
; 289, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2b6d : 85 51 __ STA T6 + 0 
2b6f : a9 00 __ LDA #$00
2b71 : 85 12 __ STA P5 
2b73 : a9 28 __ LDA #$28
2b75 : 85 11 __ STA P4 
2b77 : a9 18 __ LDA #$18
2b79 : 8d e8 9f STA $9fe8 ; (up_y + 0)
.l37:
; 291, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2b7c : 85 52 __ STA T7 + 0 
2b7e : 0a __ __ ASL
2b7f : 85 1b __ STA ACCU + 0 
2b81 : a9 00 __ LDA #$00
2b83 : 8d e9 9f STA $9fe9 ; (room2_center_x + 0)
; 292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2b86 : 2a __ __ ROL
2b87 : 06 1b __ ASL ACCU + 0 
2b89 : 2a __ __ ROL
2b8a : aa __ __ TAX
2b8b : a5 1b __ LDA ACCU + 0 
2b8d : 65 52 __ ADC T7 + 0 
2b8f : 85 43 __ STA T0 + 0 
2b91 : 8a __ __ TXA
2b92 : 69 00 __ ADC #$00
2b94 : 06 43 __ ASL T0 + 0 
2b96 : 2a __ __ ROL
2b97 : 06 43 __ ASL T0 + 0 
2b99 : 2a __ __ ROL
2b9a : 06 43 __ ASL T0 + 0 
2b9c : 2a __ __ ROL
2b9d : 85 44 __ STA T0 + 1 
2b9f : 18 __ __ CLC
2ba0 : 69 04 __ ADC #$04
2ba2 : 85 4e __ STA T2 + 1 
2ba4 : 18 __ __ CLC
2ba5 : a9 d8 __ LDA #$d8
2ba7 : 65 43 __ ADC T0 + 0 
2ba9 : 85 4b __ STA T1 + 0 
2bab : a9 03 __ LDA #$03
2bad : 65 44 __ ADC T0 + 1 
2baf : 85 4c __ STA T1 + 1 
2bb1 : a5 43 __ LDA T0 + 0 
2bb3 : 85 4d __ STA T2 + 0 
.l41:
2bb5 : ac e9 9f LDY $9fe9 ; (room2_center_x + 0)
2bb8 : b1 4b __ LDA (T1 + 0),y 
2bba : 91 4d __ STA (T2 + 0),y 
; 291, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2bbc : c8 __ __ INY
2bbd : 8c e9 9f STY $9fe9 ; (room2_center_x + 0)
2bc0 : c0 28 __ CPY #$28
2bc2 : 90 f1 __ BCC $2bb5 ; (update_screen_with_perfect_scroll.l41 + 0)
.s43:
; 295, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2bc4 : 18 __ __ CLC
2bc5 : a9 6e __ LDA #$6e
2bc7 : 65 43 __ ADC T0 + 0 
2bc9 : 85 0d __ STA P0 
2bcb : a9 33 __ LDA #$33
2bcd : 65 44 __ ADC T0 + 1 
2bcf : 85 0e __ STA P1 
2bd1 : 18 __ __ CLC
2bd2 : a9 46 __ LDA #$46
2bd4 : 65 43 __ ADC T0 + 0 
2bd6 : 85 0f __ STA P2 
2bd8 : a9 33 __ LDA #$33
2bda : 65 44 __ ADC T0 + 1 
2bdc : 85 10 __ STA P3 
2bde : 20 c3 2e JSR $2ec3 ; (memmove.s0 + 0)
; 289, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2be1 : 18 __ __ CLC
2be2 : a5 52 __ LDA T7 + 0 
2be4 : 69 ff __ ADC #$ff
2be6 : 8d e8 9f STA $9fe8 ; (up_y + 0)
2be9 : c9 01 __ CMP #$01
2beb : b0 8f __ BCS $2b7c ; (update_screen_with_perfect_scroll.l37 + 0)
.s39:
; 299, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2bed : 8d e9 9f STA $9fe9 ; (room2_center_x + 0)
; 300, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2bf0 : a5 51 __ LDA T6 + 0 
2bf2 : 85 0e __ STA P1 
.l1010:
2bf4 : ad e9 9f LDA $9fe9 ; (room2_center_x + 0)
2bf7 : 85 4f __ STA T3 + 0 
2bf9 : 6d 6c 33 ADC $336c ; (view + 0)
2bfc : 85 0d __ STA P0 
2bfe : 20 f3 2d JSR $2df3 ; (get_map_tile_fast.s0 + 0)
2c01 : 8d e7 9f STA $9fe7 ; (dx + 1)
; 301, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c04 : a6 4f __ LDX T3 + 0 
2c06 : 9d 00 04 STA $0400,x 
; 302, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c09 : 9d 6e 33 STA $336e,x ; (screen_buffer + 0)
; 299, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c0c : e8 __ __ INX
2c0d : 8e e9 9f STX $9fe9 ; (room2_center_x + 0)
2c10 : e0 28 __ CPX #$28
2c12 : 90 e0 __ BCC $2bf4 ; (update_screen_with_perfect_scroll.l1010 + 0)
2c14 : 60 __ __ RTS
.s31:
; 278, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c15 : c9 02 __ CMP #$02
2c17 : f0 01 __ BEQ $2c1a ; (update_screen_with_perfect_scroll.s12 + 0)
2c19 : 60 __ __ RTS
.s12:
; 280, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c1a : ad 6d 33 LDA $336d ; (view + 1)
2c1d : c9 27 __ CMP #$27
2c1f : 90 03 __ BCC $2c24 ; (update_screen_with_perfect_scroll.s83 + 0)
2c21 : 4c b1 2a JMP $2ab1 ; (update_screen_with_perfect_scroll.s1 + 0)
.s83:
; 307, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c24 : 85 51 __ STA T6 + 0 
2c26 : a9 28 __ LDA #$28
2c28 : 85 11 __ STA P4 
2c2a : a9 00 __ LDA #$00
2c2c : 85 12 __ STA P5 
2c2e : 8d e8 9f STA $9fe8 ; (up_y + 0)
.l50:
; 309, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c31 : 85 52 __ STA T7 + 0 
2c33 : 0a __ __ ASL
2c34 : 85 1b __ STA ACCU + 0 
2c36 : a9 00 __ LDA #$00
2c38 : 8d e9 9f STA $9fe9 ; (room2_center_x + 0)
; 310, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c3b : 2a __ __ ROL
2c3c : 06 1b __ ASL ACCU + 0 
2c3e : 2a __ __ ROL
2c3f : aa __ __ TAX
2c40 : a5 1b __ LDA ACCU + 0 
2c42 : 65 52 __ ADC T7 + 0 
2c44 : 85 43 __ STA T0 + 0 
2c46 : 8a __ __ TXA
2c47 : 69 00 __ ADC #$00
2c49 : 06 43 __ ASL T0 + 0 
2c4b : 2a __ __ ROL
2c4c : 06 43 __ ASL T0 + 0 
2c4e : 2a __ __ ROL
2c4f : 06 43 __ ASL T0 + 0 
2c51 : 2a __ __ ROL
2c52 : 85 44 __ STA T0 + 1 
2c54 : 18 __ __ CLC
2c55 : 69 04 __ ADC #$04
2c57 : 85 4c __ STA T1 + 1 
2c59 : a5 43 __ LDA T0 + 0 
2c5b : 85 4b __ STA T1 + 0 
2c5d : 18 __ __ CLC
2c5e : 69 28 __ ADC #$28
2c60 : 85 4d __ STA T2 + 0 
2c62 : a5 44 __ LDA T0 + 1 
2c64 : 69 04 __ ADC #$04
2c66 : 85 4e __ STA T2 + 1 
.l54:
2c68 : ac e9 9f LDY $9fe9 ; (room2_center_x + 0)
2c6b : b1 4d __ LDA (T2 + 0),y 
2c6d : 91 4b __ STA (T1 + 0),y 
; 309, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c6f : c8 __ __ INY
2c70 : 8c e9 9f STY $9fe9 ; (room2_center_x + 0)
2c73 : c0 28 __ CPY #$28
2c75 : 90 f1 __ BCC $2c68 ; (update_screen_with_perfect_scroll.l54 + 0)
.s56:
; 313, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c77 : 18 __ __ CLC
2c78 : a9 6e __ LDA #$6e
2c7a : 65 43 __ ADC T0 + 0 
2c7c : 85 0d __ STA P0 
2c7e : a9 33 __ LDA #$33
2c80 : 65 44 __ ADC T0 + 1 
2c82 : 85 0e __ STA P1 
2c84 : 18 __ __ CLC
2c85 : a5 43 __ LDA T0 + 0 
2c87 : 69 96 __ ADC #$96
2c89 : 85 0f __ STA P2 
2c8b : a5 44 __ LDA T0 + 1 
2c8d : 69 33 __ ADC #$33
2c8f : 85 10 __ STA P3 
2c91 : 20 c3 2e JSR $2ec3 ; (memmove.s0 + 0)
; 307, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2c94 : 18 __ __ CLC
2c95 : a5 52 __ LDA T7 + 0 
2c97 : 69 01 __ ADC #$01
2c99 : 8d e8 9f STA $9fe8 ; (up_y + 0)
2c9c : c9 18 __ CMP #$18
2c9e : 90 91 __ BCC $2c31 ; (update_screen_with_perfect_scroll.l50 + 0)
.s52:
; 317, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ca0 : a9 c0 __ LDA #$c0
2ca2 : 8d ea 9f STA $9fea ; (x + 0)
2ca5 : a9 03 __ LDA #$03
2ca7 : 8d eb 9f STA $9feb ; (screen_offset + 1)
; 318, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2caa : a9 00 __ LDA #$00
2cac : 8d e9 9f STA $9fe9 ; (room2_center_x + 0)
; 319, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2caf : 18 __ __ CLC
.l1012:
2cb0 : ad e9 9f LDA $9fe9 ; (room2_center_x + 0)
2cb3 : 85 4f __ STA T3 + 0 
2cb5 : 6d 6c 33 ADC $336c ; (view + 0)
2cb8 : 85 0d __ STA P0 
2cba : 38 __ __ SEC
2cbb : a5 51 __ LDA T6 + 0 
2cbd : e9 e8 __ SBC #$e8
2cbf : 85 0e __ STA P1 
2cc1 : 20 f3 2d JSR $2df3 ; (get_map_tile_fast.s0 + 0)
2cc4 : 8d e6 9f STA $9fe6 ; (check_y + 0)
; 320, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2cc7 : a6 4f __ LDX T3 + 0 
2cc9 : 9d c0 07 STA $07c0,x 
; 321, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ccc : 9d 2e 37 STA $372e,x ; (screen_buffer + 960)
; 318, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ccf : e8 __ __ INX
2cd0 : 8e e9 9f STX $9fe9 ; (room2_center_x + 0)
2cd3 : e0 28 __ CPX #$28
2cd5 : 90 d9 __ BCC $2cb0 ; (update_screen_with_perfect_scroll.l1012 + 0)
2cd7 : 60 __ __ RTS
.s17:
; 281, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2cd8 : ad 6c 33 LDA $336c ; (view + 0)
2cdb : d0 03 __ BNE $2ce0 ; (update_screen_with_perfect_scroll.s61 + 0)
2cdd : 4c b1 2a JMP $2ab1 ; (update_screen_with_perfect_scroll.s1 + 0)
.s61:
; 327, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ce0 : 85 51 __ STA T6 + 0 
2ce2 : a9 00 __ LDA #$00
2ce4 : 8d e8 9f STA $9fe8 ; (up_y + 0)
; 332, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ce7 : 85 12 __ STA P5 
2ce9 : a9 27 __ LDA #$27
2ceb : 85 11 __ STA P4 
.l63:
; 328, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ced : ad e8 9f LDA $9fe8 ; (up_y + 0)
2cf0 : 85 52 __ STA T7 + 0 
2cf2 : 85 4d __ STA T2 + 0 
2cf4 : 0a __ __ ASL
2cf5 : 85 1b __ STA ACCU + 0 
2cf7 : a9 27 __ LDA #$27
2cf9 : 8d e9 9f STA $9fe9 ; (room2_center_x + 0)
; 329, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2cfc : a9 00 __ LDA #$00
2cfe : 2a __ __ ROL
2cff : 06 1b __ ASL ACCU + 0 
2d01 : 2a __ __ ROL
2d02 : aa __ __ TAX
2d03 : a5 1b __ LDA ACCU + 0 
2d05 : 65 4d __ ADC T2 + 0 
2d07 : 85 4f __ STA T3 + 0 
2d09 : 8a __ __ TXA
2d0a : 69 00 __ ADC #$00
2d0c : 06 4f __ ASL T3 + 0 
2d0e : 2a __ __ ROL
2d0f : 06 4f __ ASL T3 + 0 
2d11 : 2a __ __ ROL
2d12 : 06 4f __ ASL T3 + 0 
2d14 : 2a __ __ ROL
2d15 : 85 50 __ STA T3 + 1 
2d17 : 18 __ __ CLC
2d18 : a9 ff __ LDA #$ff
2d1a : 65 4f __ ADC T3 + 0 
2d1c : 85 43 __ STA T0 + 0 
2d1e : a9 03 __ LDA #$03
2d20 : 65 50 __ ADC T3 + 1 
2d22 : 85 44 __ STA T0 + 1 
.l67:
2d24 : ac e9 9f LDY $9fe9 ; (room2_center_x + 0)
2d27 : b1 43 __ LDA (T0 + 0),y 
2d29 : c8 __ __ INY
2d2a : 91 43 __ STA (T0 + 0),y 
; 328, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d2c : 98 __ __ TYA
2d2d : 18 __ __ CLC
2d2e : 69 fe __ ADC #$fe
2d30 : 8d e9 9f STA $9fe9 ; (room2_center_x + 0)
2d33 : c9 01 __ CMP #$01
2d35 : b0 ed __ BCS $2d24 ; (update_screen_with_perfect_scroll.l67 + 0)
.s69:
; 332, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d37 : a9 6e __ LDA #$6e
2d39 : 65 4f __ ADC T3 + 0 
2d3b : 85 0f __ STA P2 
2d3d : a9 33 __ LDA #$33
2d3f : 65 50 __ ADC T3 + 1 
2d41 : 85 10 __ STA P3 
2d43 : 18 __ __ CLC
2d44 : a5 4f __ LDA T3 + 0 
2d46 : 69 6f __ ADC #$6f
2d48 : 85 0d __ STA P0 
2d4a : a5 50 __ LDA T3 + 1 
2d4c : 69 33 __ ADC #$33
2d4e : 85 0e __ STA P1 
2d50 : 20 c3 2e JSR $2ec3 ; (memmove.s0 + 0)
; 335, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d53 : a5 51 __ LDA T6 + 0 
2d55 : 85 0d __ STA P0 
2d57 : ad 6d 33 LDA $336d ; (view + 1)
2d5a : 18 __ __ CLC
2d5b : 65 4d __ ADC T2 + 0 
2d5d : 85 0e __ STA P1 
2d5f : 20 f3 2d JSR $2df3 ; (get_map_tile_fast.s0 + 0)
2d62 : 8d e5 9f STA $9fe5 ; (dy + 1)
; 336, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d65 : a5 4f __ LDA T3 + 0 
2d67 : 85 43 __ STA T0 + 0 
2d69 : 18 __ __ CLC
2d6a : a9 04 __ LDA #$04
2d6c : 65 50 __ ADC T3 + 1 
2d6e : 85 44 __ STA T0 + 1 
2d70 : ad e5 9f LDA $9fe5 ; (dy + 1)
2d73 : a0 00 __ LDY #$00
2d75 : 91 43 __ STA (T0 + 0),y 
; 337, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d77 : 91 0f __ STA (P2),y 
; 327, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d79 : 18 __ __ CLC
2d7a : a5 52 __ LDA T7 + 0 
2d7c : 69 01 __ ADC #$01
2d7e : 8d e8 9f STA $9fe8 ; (up_y + 0)
2d81 : c9 19 __ CMP #$19
2d83 : b0 03 __ BCS $2d88 ; (update_screen_with_perfect_scroll.s69 + 81)
2d85 : 4c ed 2c JMP $2ced ; (update_screen_with_perfect_scroll.l63 + 0)
2d88 : 60 __ __ RTS
--------------------------------------------------------------------
update_full_screen: ; update_full_screen()->void
.s0:
; 361, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d89 : a9 00 __ LDA #$00
2d8b : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
.l2:
; 364, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d8e : 85 49 __ STA T6 + 0 
2d90 : 0a __ __ ASL
2d91 : 0a __ __ ASL
2d92 : 65 49 __ ADC T6 + 0 
2d94 : 0a __ __ ASL
2d95 : 0a __ __ ASL
2d96 : 85 43 __ STA T0 + 0 
2d98 : a9 00 __ LDA #$00
2d9a : 8d ed 9f STA $9fed ; (exit2_x + 0)
; 362, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d9d : 2a __ __ ROL
2d9e : 06 43 __ ASL T0 + 0 
2da0 : 2a __ __ ROL
2da1 : 8d ef 9f STA $9fef ; (screen_pos + 1)
2da4 : a5 43 __ LDA T0 + 0 
2da6 : 85 47 __ STA T3 + 0 
2da8 : 8d ee 9f STA $9fee ; (entropy4 + 1)
; 365, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2dab : a9 04 __ LDA #$04
2dad : 6d ef 9f ADC $9fef ; (screen_pos + 1)
2db0 : 85 48 __ STA T3 + 1 
2db2 : 18 __ __ CLC
2db3 : a9 6e __ LDA #$6e
2db5 : 65 43 __ ADC T0 + 0 
2db7 : 85 45 __ STA T2 + 0 
2db9 : a9 33 __ LDA #$33
2dbb : 6d ef 9f ADC $9fef ; (screen_pos + 1)
2dbe : 85 46 __ STA T2 + 1 
2dc0 : 18 __ __ CLC
.l1002:
2dc1 : ad ed 9f LDA $9fed ; (exit2_x + 0)
2dc4 : 85 4a __ STA T7 + 0 
2dc6 : 6d 6c 33 ADC $336c ; (view + 0)
2dc9 : 85 0d __ STA P0 
2dcb : ad 6d 33 LDA $336d ; (view + 1)
2dce : 18 __ __ CLC
2dcf : 65 49 __ ADC T6 + 0 
2dd1 : 85 0e __ STA P1 
2dd3 : 20 f3 2d JSR $2df3 ; (get_map_tile_fast.s0 + 0)
2dd6 : 8d ec 9f STA $9fec ; (exit2_y + 0)
; 369, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2dd9 : a4 4a __ LDY T7 + 0 
2ddb : 91 47 __ STA (T3 + 0),y 
; 370, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ddd : 91 45 __ STA (T2 + 0),y 
; 364, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ddf : c8 __ __ INY
2de0 : 8c ed 9f STY $9fed ; (exit2_x + 0)
2de3 : c0 28 __ CPY #$28
2de5 : 90 da __ BCC $2dc1 ; (update_full_screen.l1002 + 0)
.s3:
; 361, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2de7 : a5 49 __ LDA T6 + 0 
2de9 : 69 00 __ ADC #$00
2deb : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
2dee : c9 19 __ CMP #$19
2df0 : 90 9c __ BCC $2d8e ; (update_full_screen.l2 + 0)
.s1001:
; 373, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2df2 : 60 __ __ RTS
--------------------------------------------------------------------
get_map_tile_fast: ; get_map_tile_fast(u8,u8)->u8
.s0:
; 105, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2df3 : a5 0d __ LDA P0 ; (map_x + 0)
2df5 : c9 40 __ CMP #$40
2df7 : b0 06 __ BCS $2dff ; (get_map_tile_fast.s1 + 0)
.s4:
2df9 : a5 0e __ LDA P1 ; (map_y + 0)
2dfb : c9 40 __ CMP #$40
2dfd : 90 03 __ BCC $2e02 ; (get_map_tile_fast.s3 + 0)
.s1:
; 106, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2dff : a9 20 __ LDA #$20
.s1001:
2e01 : 60 __ __ RTS
.s3:
; 117, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e02 : 85 1c __ STA ACCU + 1 
2e04 : 4a __ __ LSR
2e05 : aa __ __ TAX
2e06 : a9 00 __ LDA #$00
2e08 : 6a __ __ ROR
2e09 : 85 43 __ STA T1 + 0 
2e0b : a9 00 __ LDA #$00
2e0d : 46 1c __ LSR ACCU + 1 
2e0f : 6a __ __ ROR
2e10 : 66 1c __ ROR ACCU + 1 
2e12 : 6a __ __ ROR
2e13 : 65 43 __ ADC T1 + 0 
2e15 : a8 __ __ TAY
2e16 : 8a __ __ TXA
2e17 : 65 1c __ ADC ACCU + 1 
2e19 : aa __ __ TAX
2e1a : 98 __ __ TYA
2e1b : 18 __ __ CLC
2e1c : 65 0d __ ADC P0 ; (map_x + 0)
2e1e : 90 01 __ BCC $2e21 ; (get_map_tile_fast.s1014 + 0)
.s1013:
; 110, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e20 : e8 __ __ INX
.s1014:
2e21 : 18 __ __ CLC
2e22 : 65 0d __ ADC P0 ; (map_x + 0)
2e24 : 90 01 __ BCC $2e27 ; (get_map_tile_fast.s1016 + 0)
.s1015:
; 110, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e26 : e8 __ __ INX
.s1016:
2e27 : 18 __ __ CLC
2e28 : 65 0d __ ADC P0 ; (map_x + 0)
2e2a : 8d f8 9f STA $9ff8 ; (room + 1)
2e2d : 8a __ __ TXA
2e2e : 69 00 __ ADC #$00
2e30 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 111, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e33 : 4a __ __ LSR
2e34 : 85 44 __ STA T1 + 1 
2e36 : ad f8 9f LDA $9ff8 ; (room + 1)
2e39 : 6a __ __ ROR
2e3a : 46 44 __ LSR T1 + 1 
2e3c : 6a __ __ ROR
2e3d : 46 44 __ LSR T1 + 1 
2e3f : 6a __ __ ROR
2e40 : 18 __ __ CLC
2e41 : 69 58 __ ADC #$58
2e43 : 85 43 __ STA T1 + 0 
2e45 : 8d f6 9f STA $9ff6 ; (dx + 0)
2e48 : a9 37 __ LDA #$37
2e4a : 65 44 __ ADC T1 + 1 
2e4c : 85 44 __ STA T1 + 1 
2e4e : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
; 112, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e51 : ad f8 9f LDA $9ff8 ; (room + 1)
2e54 : 29 07 __ AND #$07
2e56 : 85 1b __ STA ACCU + 0 
2e58 : 8d f5 9f STA $9ff5 ; (s + 1)
; 117, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e5b : aa __ __ TAX
2e5c : a0 00 __ LDY #$00
2e5e : b1 43 __ LDA (T1 + 0),y 
2e60 : e0 00 __ CPX #$00
2e62 : f0 04 __ BEQ $2e68 ; (get_map_tile_fast.s1003 + 0)
.l1002:
; 117, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e64 : 4a __ __ LSR
2e65 : ca __ __ DEX
2e66 : d0 fc __ BNE $2e64 ; (get_map_tile_fast.l1002 + 0)
.s1003:
; 115, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e68 : 85 1c __ STA ACCU + 1 
2e6a : a5 1b __ LDA ACCU + 0 
2e6c : c9 06 __ CMP #$06
2e6e : a5 1c __ LDA ACCU + 1 
2e70 : 90 23 __ BCC $2e95 ; (get_map_tile_fast.s30 + 0)
.s7:
; 121, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e72 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
; 120, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e75 : a9 08 __ LDA #$08
2e77 : e5 1b __ SBC ACCU + 0 
2e79 : 8d f3 9f STA $9ff3 ; (i + 0)
; 122, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e7c : aa __ __ TAX
2e7d : bd 56 33 LDA $3356,x ; (bitshift + 36)
2e80 : 38 __ __ SEC
2e81 : e9 01 __ SBC #$01
2e83 : a0 01 __ LDY #$01
2e85 : 31 43 __ AND (T1 + 0),y 
2e87 : ae f3 9f LDX $9ff3 ; (i + 0)
2e8a : f0 04 __ BEQ $2e90 ; (get_map_tile_fast.s1005 + 0)
.l1006:
2e8c : 0a __ __ ASL
2e8d : ca __ __ DEX
2e8e : d0 fc __ BNE $2e8c ; (get_map_tile_fast.l1006 + 0)
.s1005:
; 122, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e90 : 8d f1 9f STA $9ff1 ; (entropy2 + 0)
; 123, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e93 : 05 1c __ ORA ACCU + 1 
.s30:
2e95 : 29 07 __ AND #$07
2e97 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e9a : c9 03 __ CMP #$03
2e9c : d0 03 __ BNE $2ea1 ; (get_map_tile_fast.s19 + 0)
.s13:
; 130, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e9e : a9 2b __ LDA #$2b
2ea0 : 60 __ __ RTS
.s19:
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ea1 : 90 11 __ BCC $2eb4 ; (get_map_tile_fast.s21 + 0)
.s20:
2ea3 : c9 04 __ CMP #$04
2ea5 : d0 03 __ BNE $2eaa ; (get_map_tile_fast.s25 + 0)
.s14:
; 131, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ea7 : a9 3c __ LDA #$3c
2ea9 : 60 __ __ RTS
.s25:
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2eaa : c9 05 __ CMP #$05
2eac : f0 03 __ BEQ $2eb1 ; (get_map_tile_fast.s15 + 0)
2eae : 4c ff 2d JMP $2dff ; (get_map_tile_fast.s1 + 0)
.s15:
; 132, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2eb1 : a9 3e __ LDA #$3e
2eb3 : 60 __ __ RTS
.s21:
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2eb4 : c9 01 __ CMP #$01
2eb6 : d0 03 __ BNE $2ebb ; (get_map_tile_fast.s22 + 0)
.s11:
; 128, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2eb8 : a9 23 __ LDA #$23
2eba : 60 __ __ RTS
.s22:
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ebb : 8a __ __ TXA
2ebc : 69 ff __ ADC #$ff
2ebe : 29 0e __ AND #$0e
2ec0 : 49 2e __ EOR #$2e
2ec2 : 60 __ __ RTS
--------------------------------------------------------------------
memmove: ; memmove(void*,const void*,i16)->void*
.s0:
; 237, "E:/Apps/oscar64/include/string.c"
2ec3 : a5 11 __ LDA P4 ; (size + 0)
2ec5 : 8d f8 9f STA $9ff8 ; (room + 1)
2ec8 : a6 0e __ LDX P1 ; (dst + 1)
2eca : a5 12 __ LDA P5 ; (size + 1)
2ecc : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 238, "E:/Apps/oscar64/include/string.c"
2ecf : 10 03 __ BPL $2ed4 ; (memmove.s1006 + 0)
2ed1 : 4c 6f 2f JMP $2f6f ; (memmove.s3 + 0)
.s1006:
2ed4 : 05 11 __ ORA P4 ; (size + 0)
2ed6 : f0 f9 __ BEQ $2ed1 ; (memmove.s0 + 14)
.s1:
; 240, "E:/Apps/oscar64/include/string.c"
2ed8 : 8e f7 9f STX $9ff7 ; (byte_ptr + 1)
2edb : a5 0d __ LDA P0 ; (dst + 0)
2edd : 8d f6 9f STA $9ff6 ; (dx + 0)
; 241, "E:/Apps/oscar64/include/string.c"
2ee0 : a5 0f __ LDA P2 ; (src + 0)
2ee2 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
2ee5 : a5 10 __ LDA P3 ; (src + 1)
2ee7 : 8d f5 9f STA $9ff5 ; (s + 1)
; 242, "E:/Apps/oscar64/include/string.c"
2eea : e4 10 __ CPX P3 ; (src + 1)
2eec : d0 05 __ BNE $2ef3 ; (memmove.s1005 + 0)
.s1004:
2eee : a5 0d __ LDA P0 ; (dst + 0)
2ef0 : cd f4 9f CMP $9ff4 ; (entropy1 + 1)
.s1005:
2ef3 : b0 04 __ BCS $2ef9 ; (memmove.s5 + 0)
.s7:
; 246, "E:/Apps/oscar64/include/string.c"
2ef5 : a0 00 __ LDY #$00
2ef7 : 90 7d __ BCC $2f76 ; (memmove.l1007 + 0)
.s5:
; 248, "E:/Apps/oscar64/include/string.c"
2ef9 : ad f5 9f LDA $9ff5 ; (s + 1)
2efc : cd f7 9f CMP $9ff7 ; (byte_ptr + 1)
2eff : d0 06 __ BNE $2f07 ; (memmove.s1003 + 0)
.s1002:
2f01 : ad f4 9f LDA $9ff4 ; (entropy1 + 1)
2f04 : cd f6 9f CMP $9ff6 ; (dx + 0)
.s1003:
2f07 : b0 66 __ BCS $2f6f ; (memmove.s3 + 0)
.s9:
; 251, "E:/Apps/oscar64/include/string.c"
2f09 : ad f4 9f LDA $9ff4 ; (entropy1 + 1)
2f0c : 18 __ __ CLC
2f0d : 65 11 __ ADC P4 ; (size + 0)
2f0f : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
2f12 : ad f5 9f LDA $9ff5 ; (s + 1)
2f15 : 6d f9 9f ADC $9ff9 ; (bit_offset + 1)
2f18 : 8d f5 9f STA $9ff5 ; (s + 1)
; 250, "E:/Apps/oscar64/include/string.c"
2f1b : ad f6 9f LDA $9ff6 ; (dx + 0)
2f1e : 18 __ __ CLC
2f1f : 65 11 __ ADC P4 ; (size + 0)
2f21 : 8d f6 9f STA $9ff6 ; (dx + 0)
2f24 : ad f7 9f LDA $9ff7 ; (byte_ptr + 1)
2f27 : 6d f9 9f ADC $9ff9 ; (bit_offset + 1)
2f2a : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
; 253, "E:/Apps/oscar64/include/string.c"
2f2d : a0 00 __ LDY #$00
.l1009:
2f2f : ad f4 9f LDA $9ff4 ; (entropy1 + 1)
2f32 : 18 __ __ CLC
2f33 : 69 ff __ ADC #$ff
2f35 : 85 1b __ STA ACCU + 0 
2f37 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
2f3a : ad f5 9f LDA $9ff5 ; (s + 1)
2f3d : 69 ff __ ADC #$ff
2f3f : 85 1c __ STA ACCU + 1 
2f41 : 8d f5 9f STA $9ff5 ; (s + 1)
2f44 : ad f6 9f LDA $9ff6 ; (dx + 0)
2f47 : 18 __ __ CLC
2f48 : 69 ff __ ADC #$ff
2f4a : 85 43 __ STA T1 + 0 
2f4c : 8d f6 9f STA $9ff6 ; (dx + 0)
2f4f : ad f7 9f LDA $9ff7 ; (byte_ptr + 1)
2f52 : 69 ff __ ADC #$ff
2f54 : 85 44 __ STA T1 + 1 
2f56 : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
2f59 : b1 1b __ LDA (ACCU + 0),y 
2f5b : 91 43 __ STA (T1 + 0),y 
; 254, "E:/Apps/oscar64/include/string.c"
2f5d : ad f8 9f LDA $9ff8 ; (room + 1)
2f60 : d0 03 __ BNE $2f65 ; (memmove.s1017 + 0)
.s1016:
; 254, "E:/Apps/oscar64/include/string.c"
2f62 : ce f9 9f DEC $9ff9 ; (bit_offset + 1)
.s1017:
2f65 : ce f8 9f DEC $9ff8 ; (room + 1)
2f68 : d0 c5 __ BNE $2f2f ; (memmove.l1009 + 0)
.s1018:
; 254, "E:/Apps/oscar64/include/string.c"
2f6a : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
2f6d : d0 c0 __ BNE $2f2f ; (memmove.l1009 + 0)
.s3:
; 257, "E:/Apps/oscar64/include/string.c"
2f6f : 86 1c __ STX ACCU + 1 
2f71 : a5 0d __ LDA P0 ; (dst + 0)
2f73 : 85 1b __ STA ACCU + 0 
.s1001:
2f75 : 60 __ __ RTS
.l1007:
; 245, "E:/Apps/oscar64/include/string.c"
2f76 : ad f4 9f LDA $9ff4 ; (entropy1 + 1)
2f79 : 85 1b __ STA ACCU + 0 
2f7b : 18 __ __ CLC
2f7c : 69 01 __ ADC #$01
2f7e : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
2f81 : ad f5 9f LDA $9ff5 ; (s + 1)
2f84 : 85 1c __ STA ACCU + 1 
2f86 : 69 00 __ ADC #$00
2f88 : 8d f5 9f STA $9ff5 ; (s + 1)
2f8b : ad f6 9f LDA $9ff6 ; (dx + 0)
2f8e : 85 43 __ STA T1 + 0 
2f90 : ad f7 9f LDA $9ff7 ; (byte_ptr + 1)
2f93 : 85 44 __ STA T1 + 1 
2f95 : b1 1b __ LDA (ACCU + 0),y 
2f97 : 91 43 __ STA (T1 + 0),y 
2f99 : 18 __ __ CLC
2f9a : a5 43 __ LDA T1 + 0 
2f9c : 69 01 __ ADC #$01
2f9e : 8d f6 9f STA $9ff6 ; (dx + 0)
2fa1 : a5 44 __ LDA T1 + 1 
2fa3 : 69 00 __ ADC #$00
2fa5 : 8d f7 9f STA $9ff7 ; (byte_ptr + 1)
; 246, "E:/Apps/oscar64/include/string.c"
2fa8 : ad f8 9f LDA $9ff8 ; (room + 1)
2fab : d0 03 __ BNE $2fb0 ; (memmove.s1014 + 0)
.s1013:
; 246, "E:/Apps/oscar64/include/string.c"
2fad : ce f9 9f DEC $9ff9 ; (bit_offset + 1)
.s1014:
2fb0 : ce f8 9f DEC $9ff8 ; (room + 1)
2fb3 : d0 c1 __ BNE $2f76 ; (memmove.l1007 + 0)
.s1015:
; 246, "E:/Apps/oscar64/include/string.c"
2fb5 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
2fb8 : d0 bc __ BNE $2f76 ; (memmove.l1007 + 0)
2fba : f0 b3 __ BEQ $2f6f ; (memmove.s3 + 0)
--------------------------------------------------------------------
getch: ; getch()->u8
.l1:
; 320, "E:/Apps/oscar64/include/conio.c"
2fbc : 20 e4 ff JSR $ffe4 
2fbf : 85 1b __ STA ACCU + 0 
2fc1 : a5 1b __ LDA ACCU + 0 
; 319, "E:/Apps/oscar64/include/conio.c"
2fc3 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 323, "E:/Apps/oscar64/include/conio.c"
2fc6 : f0 f4 __ BEQ $2fbc ; (getch.l1 + 0)
.s2:
; 325, "E:/Apps/oscar64/include/conio.c"
2fc8 : 4c cb 2f JMP $2fcb ; (convch.s0 + 0)
--------------------------------------------------------------------
convch: ; convch(u8)->u8
.s0:
2fcb : a8 __ __ TAY
; 246, "E:/Apps/oscar64/include/conio.c"
2fcc : ad 31 33 LDA $3331 ; (giocharmap + 0)
2fcf : f0 27 __ BEQ $2ff8 ; (convch.s3 + 0)
.s1:
; 248, "E:/Apps/oscar64/include/conio.c"
2fd1 : c0 0d __ CPY #$0d
2fd3 : d0 03 __ BNE $2fd8 ; (convch.s5 + 0)
.s4:
; 263, "E:/Apps/oscar64/include/conio.c"
2fd5 : a9 0a __ LDA #$0a
.s1001:
2fd7 : 60 __ __ RTS
.s5:
; 250, "E:/Apps/oscar64/include/conio.c"
2fd8 : c9 02 __ CMP #$02
2fda : 90 1c __ BCC $2ff8 ; (convch.s3 + 0)
.s7:
; 252, "E:/Apps/oscar64/include/conio.c"
2fdc : 98 __ __ TYA
2fdd : c0 41 __ CPY #$41
2fdf : 90 17 __ BCC $2ff8 ; (convch.s3 + 0)
.s13:
2fe1 : c9 db __ CMP #$db
2fe3 : b0 13 __ BCS $2ff8 ; (convch.s3 + 0)
.s10:
; 254, "E:/Apps/oscar64/include/conio.c"
2fe5 : c9 c1 __ CMP #$c1
2fe7 : 90 03 __ BCC $2fec ; (convch.s16 + 0)
.s14:
; 255, "E:/Apps/oscar64/include/conio.c"
2fe9 : 49 a0 __ EOR #$a0
2feb : a8 __ __ TAY
.s16:
; 256, "E:/Apps/oscar64/include/conio.c"
2fec : c9 7b __ CMP #$7b
2fee : b0 08 __ BCS $2ff8 ; (convch.s3 + 0)
.s20:
2ff0 : c9 61 __ CMP #$61
2ff2 : b0 06 __ BCS $2ffa ; (convch.s17 + 0)
.s21:
2ff4 : c9 5b __ CMP #$5b
2ff6 : 90 02 __ BCC $2ffa ; (convch.s17 + 0)
.s3:
; 263, "E:/Apps/oscar64/include/conio.c"
2ff8 : 98 __ __ TYA
2ff9 : 60 __ __ RTS
.s17:
; 257, "E:/Apps/oscar64/include/conio.c"
2ffa : 49 20 __ EOR #$20
2ffc : 60 __ __ RTS
--------------------------------------------------------------------
process_navigation_input: ; process_navigation_input(u8)->void
.s0:
; 179, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ffd : ad 6c 33 LDA $336c ; (view + 0)
3000 : 85 44 __ STA T3 + 0 
3002 : 8d f5 9f STA $9ff5 ; (s + 1)
; 183, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3005 : a9 00 __ LDA #$00
3007 : 8d f1 9f STA $9ff1 ; (entropy2 + 0)
; 180, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
300a : ad 6d 33 LDA $336d ; (view + 1)
300d : 85 45 __ STA T4 + 0 
300f : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
; 181, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3012 : ad 6a 33 LDA $336a ; (camera_center_x + 0)
3015 : 85 43 __ STA T2 + 0 
3017 : 8d f3 9f STA $9ff3 ; (i + 0)
; 182, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
301a : ad 6b 33 LDA $336b ; (camera_center_y + 0)
301d : 85 46 __ STA T5 + 0 
301f : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
; 186, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3022 : a5 0d __ LDA P0 ; (key + 0)
3024 : c9 61 __ CMP #$61
3026 : d0 03 __ BNE $302b ; (process_navigation_input.s19 + 0)
3028 : 4c f4 30 JMP $30f4 ; (process_navigation_input.s10 + 0)
.s19:
302b : b0 03 __ BCS $3030 ; (process_navigation_input.s20 + 0)
302d : 4c e2 30 JMP $30e2 ; (process_navigation_input.s21 + 0)
.s20:
3030 : c9 73 __ CMP #$73
3032 : d0 03 __ BNE $3037 ; (process_navigation_input.s28 + 0)
3034 : 4c d7 30 JMP $30d7 ; (process_navigation_input.s6 + 0)
.s28:
3037 : b0 03 __ BCS $303c ; (process_navigation_input.s29 + 0)
3039 : 4c c5 30 JMP $30c5 ; (process_navigation_input.s30 + 0)
.s29:
303c : c9 77 __ CMP #$77
303e : d0 41 __ BNE $3081 ; (process_navigation_input.s1001 + 0)
.s2:
; 189, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3040 : a5 46 __ LDA T5 + 0 
3042 : f0 3d __ BEQ $3081 ; (process_navigation_input.s1001 + 0)
.s3:
; 190, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3044 : 69 fe __ ADC #$fe
.s70:
; 198, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3046 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
.s33:
; 207, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3049 : a9 01 __ LDA #$01
304b : 8d f1 9f STA $9ff1 ; (entropy2 + 0)
; 222, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
304e : a5 43 __ LDA T2 + 0 
3050 : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
; 223, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3053 : a5 46 __ LDA T5 + 0 
3055 : 8d ef 9f STA $9fef ; (screen_pos + 1)
; 225, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3058 : ad f3 9f LDA $9ff3 ; (i + 0)
305b : 8d 6a 33 STA $336a ; (camera_center_x + 0)
; 226, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
305e : ad f2 9f LDA $9ff2 ; (entropy2 + 1)
3061 : 8d 6b 33 STA $336b ; (camera_center_y + 0)
; 227, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3064 : 20 fe 17 JSR $17fe ; (update_camera.s0 + 0)
; 231, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3067 : a5 44 __ LDA T3 + 0 
3069 : cd 6c 33 CMP $336c ; (view + 0)
306c : d0 07 __ BNE $3075 ; (process_navigation_input.s36 + 0)
.s39:
306e : a5 45 __ LDA T4 + 0 
3070 : cd 6d 33 CMP $336d ; (view + 1)
3073 : f0 32 __ BEQ $30a7 ; (process_navigation_input.s37 + 0)
.s36:
; 233, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3075 : ad 6d 33 LDA $336d ; (view + 1)
3078 : c5 45 __ CMP T4 + 0 
307a : b0 06 __ BCS $3082 ; (process_navigation_input.s41 + 0)
.s40:
; 234, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
307c : a9 01 __ LDA #$01
.s1002:
307e : 8d 57 37 STA $3757 ; (last_scroll_direction + 0)
.s1001:
; 260, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3081 : 60 __ __ RTS
.s41:
; 235, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3082 : a5 45 __ LDA T4 + 0 
3084 : cd 6d 33 CMP $336d ; (view + 1)
3087 : b0 04 __ BCS $308d ; (process_navigation_input.s44 + 0)
.s43:
; 236, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3089 : a9 02 __ LDA #$02
308b : 90 f1 __ BCC $307e ; (process_navigation_input.s1002 + 0)
.s44:
; 237, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
308d : ad 6c 33 LDA $336c ; (view + 0)
3090 : c5 44 __ CMP T3 + 0 
3092 : b0 04 __ BCS $3098 ; (process_navigation_input.s47 + 0)
.s46:
; 238, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3094 : a9 03 __ LDA #$03
3096 : 90 e6 __ BCC $307e ; (process_navigation_input.s1002 + 0)
.s47:
; 239, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3098 : a5 44 __ LDA T3 + 0 
309a : cd 6c 33 CMP $336c ; (view + 0)
309d : b0 04 __ BCS $30a3 ; (process_navigation_input.s50 + 0)
.s49:
; 240, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
309f : a9 04 __ LDA #$04
30a1 : 90 db __ BCC $307e ; (process_navigation_input.s1002 + 0)
.s50:
; 242, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30a3 : a9 00 __ LDA #$00
30a5 : b0 d7 __ BCS $307e ; (process_navigation_input.s1002 + 0)
.s37:
; 247, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30a7 : ad 6b 33 LDA $336b ; (camera_center_y + 0)
30aa : c5 46 __ CMP T5 + 0 
30ac : 90 ce __ BCC $307c ; (process_navigation_input.s40 + 0)
.s53:
; 249, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30ae : a5 46 __ LDA T5 + 0 
30b0 : cd 6b 33 CMP $336b ; (camera_center_y + 0)
30b3 : 90 d4 __ BCC $3089 ; (process_navigation_input.s43 + 0)
.s56:
; 251, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30b5 : ad 6a 33 LDA $336a ; (camera_center_x + 0)
30b8 : c5 43 __ CMP T2 + 0 
30ba : 90 d8 __ BCC $3094 ; (process_navigation_input.s46 + 0)
.s59:
; 253, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30bc : a5 43 __ LDA T2 + 0 
30be : cd 6a 33 CMP $336a ; (camera_center_x + 0)
30c1 : b0 e0 __ BCS $30a3 ; (process_navigation_input.s50 + 0)
30c3 : 90 da __ BCC $309f ; (process_navigation_input.s49 + 0)
.s30:
; 186, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30c5 : c9 64 __ CMP #$64
30c7 : d0 b8 __ BNE $3081 ; (process_navigation_input.s1001 + 0)
.s14:
; 213, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30c9 : a5 43 __ LDA T2 + 0 
30cb : c9 3f __ CMP #$3f
30cd : b0 b2 __ BCS $3081 ; (process_navigation_input.s1001 + 0)
.s15:
; 214, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30cf : 69 01 __ ADC #$01
.s71:
30d1 : 8d f3 9f STA $9ff3 ; (i + 0)
30d4 : 4c 49 30 JMP $3049 ; (process_navigation_input.s33 + 0)
.s6:
; 197, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30d7 : a5 46 __ LDA T5 + 0 
30d9 : c9 3f __ CMP #$3f
30db : b0 a4 __ BCS $3081 ; (process_navigation_input.s1001 + 0)
.s7:
; 198, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30dd : 69 01 __ ADC #$01
30df : 4c 46 30 JMP $3046 ; (process_navigation_input.s70 + 0)
.s21:
; 186, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30e2 : c9 53 __ CMP #$53
30e4 : f0 f1 __ BEQ $30d7 ; (process_navigation_input.s6 + 0)
.s22:
30e6 : 90 08 __ BCC $30f0 ; (process_navigation_input.s24 + 0)
.s23:
30e8 : c9 57 __ CMP #$57
30ea : d0 03 __ BNE $30ef ; (process_navigation_input.s23 + 7)
30ec : 4c 40 30 JMP $3040 ; (process_navigation_input.s2 + 0)
30ef : 60 __ __ RTS
.s24:
30f0 : c9 41 __ CMP #$41
30f2 : d0 09 __ BNE $30fd ; (process_navigation_input.s25 + 0)
.s10:
; 205, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30f4 : a5 43 __ LDA T2 + 0 
30f6 : f0 89 __ BEQ $3081 ; (process_navigation_input.s1001 + 0)
.s11:
; 206, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30f8 : 69 fe __ ADC #$fe
30fa : 4c d1 30 JMP $30d1 ; (process_navigation_input.s71 + 0)
.s25:
; 186, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30fd : c9 44 __ CMP #$44
30ff : f0 c8 __ BEQ $30c9 ; (process_navigation_input.s14 + 0)
3101 : 60 __ __ RTS
--------------------------------------------------------------------
mul16by8: ; mul16by8
3102 : 4a __ __ LSR
3103 : f0 2e __ BEQ $3133 ; (mul16by8 + 49)
3105 : a2 00 __ LDX #$00
3107 : a0 00 __ LDY #$00
3109 : 90 13 __ BCC $311e ; (mul16by8 + 28)
310b : a4 1b __ LDY ACCU + 0 
310d : a6 1c __ LDX ACCU + 1 
310f : b0 0d __ BCS $311e ; (mul16by8 + 28)
3111 : 85 02 __ STA $02 
3113 : 18 __ __ CLC
3114 : 98 __ __ TYA
3115 : 65 1b __ ADC ACCU + 0 
3117 : a8 __ __ TAY
3118 : 8a __ __ TXA
3119 : 65 1c __ ADC ACCU + 1 
311b : aa __ __ TAX
311c : a5 02 __ LDA $02 
311e : 06 1b __ ASL ACCU + 0 
3120 : 26 1c __ ROL ACCU + 1 
3122 : 4a __ __ LSR
3123 : 90 f9 __ BCC $311e ; (mul16by8 + 28)
3125 : d0 ea __ BNE $3111 ; (mul16by8 + 15)
3127 : 18 __ __ CLC
3128 : 98 __ __ TYA
3129 : 65 1b __ ADC ACCU + 0 
312b : 85 1b __ STA ACCU + 0 
312d : 8a __ __ TXA
312e : 65 1c __ ADC ACCU + 1 
3130 : 85 1c __ STA ACCU + 1 
3132 : 60 __ __ RTS
3133 : b0 04 __ BCS $3139 ; (mul16by8 + 55)
3135 : 85 1b __ STA ACCU + 0 
3137 : 85 1c __ STA ACCU + 1 
3139 : 60 __ __ RTS
--------------------------------------------------------------------
mul16: ; mul16
313a : a0 00 __ LDY #$00
313c : 84 06 __ STY WORK + 3 
313e : a5 03 __ LDA WORK + 0 
3140 : a6 04 __ LDX WORK + 1 
3142 : f0 1c __ BEQ $3160 ; (mul16 + 38)
3144 : 38 __ __ SEC
3145 : 6a __ __ ROR
3146 : 90 0d __ BCC $3155 ; (mul16 + 27)
3148 : aa __ __ TAX
3149 : 18 __ __ CLC
314a : 98 __ __ TYA
314b : 65 1b __ ADC ACCU + 0 
314d : a8 __ __ TAY
314e : a5 06 __ LDA WORK + 3 
3150 : 65 1c __ ADC ACCU + 1 
3152 : 85 06 __ STA WORK + 3 
3154 : 8a __ __ TXA
3155 : 06 1b __ ASL ACCU + 0 
3157 : 26 1c __ ROL ACCU + 1 
3159 : 4a __ __ LSR
315a : 90 f9 __ BCC $3155 ; (mul16 + 27)
315c : d0 ea __ BNE $3148 ; (mul16 + 14)
315e : a5 04 __ LDA WORK + 1 
3160 : 4a __ __ LSR
3161 : 90 0d __ BCC $3170 ; (mul16 + 54)
3163 : aa __ __ TAX
3164 : 18 __ __ CLC
3165 : 98 __ __ TYA
3166 : 65 1b __ ADC ACCU + 0 
3168 : a8 __ __ TAY
3169 : a5 06 __ LDA WORK + 3 
316b : 65 1c __ ADC ACCU + 1 
316d : 85 06 __ STA WORK + 3 
316f : 8a __ __ TXA
3170 : 06 1b __ ASL ACCU + 0 
3172 : 26 1c __ ROL ACCU + 1 
3174 : 4a __ __ LSR
3175 : b0 ec __ BCS $3163 ; (mul16 + 41)
3177 : d0 f7 __ BNE $3170 ; (mul16 + 54)
3179 : 84 05 __ STY WORK + 2 
317b : 60 __ __ RTS
--------------------------------------------------------------------
divmod: ; divmod
317c : a5 1c __ LDA ACCU + 1 
317e : d0 31 __ BNE $31b1 ; (divmod + 53)
3180 : a5 04 __ LDA WORK + 1 
3182 : d0 1e __ BNE $31a2 ; (divmod + 38)
3184 : 85 06 __ STA WORK + 3 
3186 : a2 04 __ LDX #$04
3188 : 06 1b __ ASL ACCU + 0 
318a : 2a __ __ ROL
318b : c5 03 __ CMP WORK + 0 
318d : 90 02 __ BCC $3191 ; (divmod + 21)
318f : e5 03 __ SBC WORK + 0 
3191 : 26 1b __ ROL ACCU + 0 
3193 : 2a __ __ ROL
3194 : c5 03 __ CMP WORK + 0 
3196 : 90 02 __ BCC $319a ; (divmod + 30)
3198 : e5 03 __ SBC WORK + 0 
319a : 26 1b __ ROL ACCU + 0 
319c : ca __ __ DEX
319d : d0 eb __ BNE $318a ; (divmod + 14)
319f : 85 05 __ STA WORK + 2 
31a1 : 60 __ __ RTS
31a2 : a5 1b __ LDA ACCU + 0 
31a4 : 85 05 __ STA WORK + 2 
31a6 : a5 1c __ LDA ACCU + 1 
31a8 : 85 06 __ STA WORK + 3 
31aa : a9 00 __ LDA #$00
31ac : 85 1b __ STA ACCU + 0 
31ae : 85 1c __ STA ACCU + 1 
31b0 : 60 __ __ RTS
31b1 : a5 04 __ LDA WORK + 1 
31b3 : d0 1f __ BNE $31d4 ; (divmod + 88)
31b5 : a5 03 __ LDA WORK + 0 
31b7 : 30 1b __ BMI $31d4 ; (divmod + 88)
31b9 : a9 00 __ LDA #$00
31bb : 85 06 __ STA WORK + 3 
31bd : a2 10 __ LDX #$10
31bf : 06 1b __ ASL ACCU + 0 
31c1 : 26 1c __ ROL ACCU + 1 
31c3 : 2a __ __ ROL
31c4 : c5 03 __ CMP WORK + 0 
31c6 : 90 02 __ BCC $31ca ; (divmod + 78)
31c8 : e5 03 __ SBC WORK + 0 
31ca : 26 1b __ ROL ACCU + 0 
31cc : 26 1c __ ROL ACCU + 1 
31ce : ca __ __ DEX
31cf : d0 f2 __ BNE $31c3 ; (divmod + 71)
31d1 : 85 05 __ STA WORK + 2 
31d3 : 60 __ __ RTS
31d4 : a9 00 __ LDA #$00
31d6 : 85 05 __ STA WORK + 2 
31d8 : 85 06 __ STA WORK + 3 
31da : 84 02 __ STY $02 
31dc : a0 10 __ LDY #$10
31de : 18 __ __ CLC
31df : 26 1b __ ROL ACCU + 0 
31e1 : 26 1c __ ROL ACCU + 1 
31e3 : 26 05 __ ROL WORK + 2 
31e5 : 26 06 __ ROL WORK + 3 
31e7 : 38 __ __ SEC
31e8 : a5 05 __ LDA WORK + 2 
31ea : e5 03 __ SBC WORK + 0 
31ec : aa __ __ TAX
31ed : a5 06 __ LDA WORK + 3 
31ef : e5 04 __ SBC WORK + 1 
31f1 : 90 04 __ BCC $31f7 ; (divmod + 123)
31f3 : 86 05 __ STX WORK + 2 
31f5 : 85 06 __ STA WORK + 3 
31f7 : 88 __ __ DEY
31f8 : d0 e5 __ BNE $31df ; (divmod + 99)
31fa : 26 1b __ ROL ACCU + 0 
31fc : 26 1c __ ROL ACCU + 1 
31fe : a4 02 __ LDY $02 
3200 : 60 __ __ RTS
--------------------------------------------------------------------
__multab7982L:
3201 : __ __ __ BYT 00 2e 5c 8a b8 e6 14 42 70                      : ..\....Bp
--------------------------------------------------------------------
__multab7982H:
320a : __ __ __ BYT 00 1f 3e 5d 7c 9b bb da f9                      : ..>]|....
--------------------------------------------------------------------
__multab14L:
3213 : __ __ __ BYT 00 0e 1c 2a                                     : ...*
--------------------------------------------------------------------
__shltab7L:
3217 : __ __ __ BYT 07 0e 1c 38 70 e0                               : ...8p.
--------------------------------------------------------------------
spentry:
321d : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
generation_counter:
321e : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
rng_seed:
3220 : __ __ __ BYT 01 00                                           : ..
--------------------------------------------------------------------
room_count:
3222 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
room_center_cache_valid:
3223 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
corridor_pool:
3224 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3234 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3244 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3254 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3264 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3274 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3284 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3294 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
32a4 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
32b4 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
32c4 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
32d4 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
32e4 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
connection_cache:
32e6 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
32f6 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3306 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3316 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3326 : __ __ __ BYT 00 00 00 00 00 00 00 00 00                      : .........
--------------------------------------------------------------------
distance_cache_valid:
332f : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
corridor_endpoint_override:
3330 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
giocharmap:
3331 : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
bitshift:
3332 : __ __ __ BYT 00 00 00 00 00 00 00 00 01 02 04 08 10 20 40 80 : ............. @.
3342 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3352 : __ __ __ BYT 80 40 20 10 08 04 02 01 00 00 00 00 00 00 00 00 : .@ .............
3362 : __ __ __ BYT 00 00 00 00 00 00 00 00                         : ........
--------------------------------------------------------------------
camera_center_x:
336a : __ __ __ BSS	1
--------------------------------------------------------------------
camera_center_y:
336b : __ __ __ BSS	1
--------------------------------------------------------------------
view:
336c : __ __ __ BSS	2
--------------------------------------------------------------------
screen_buffer:
336e : __ __ __ BSS	1000
--------------------------------------------------------------------
screen_dirty:
3756 : __ __ __ BSS	1
--------------------------------------------------------------------
last_scroll_direction:
3757 : __ __ __ BSS	1
--------------------------------------------------------------------
compact_map:
3758 : __ __ __ BSS	1536
--------------------------------------------------------------------
connection_matrix:
3d58 : __ __ __ BSS	400
--------------------------------------------------------------------
room_distance_cache:
3ee8 : __ __ __ BSS	400
--------------------------------------------------------------------
room_center_cache:
4078 : __ __ __ BSS	40
--------------------------------------------------------------------
rooms:
4100 : __ __ __ BSS	160
