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
080e : 8e 8d 35 STX $358d ; (spentry + 0)
0811 : a2 36 __ LDX #$36
0813 : a0 da __ LDY #$da
0815 : a9 00 __ LDA #$00
0817 : 85 19 __ STA IP + 0 
0819 : 86 1a __ STX IP + 1 
081b : e0 45 __ CPX #$45
081d : f0 0b __ BEQ $082a ; (startup + 41)
081f : 91 19 __ STA (IP + 0),y 
0821 : c8 __ __ INY
0822 : d0 fb __ BNE $081f ; (startup + 30)
0824 : e8 __ __ INX
0825 : d0 f2 __ BNE $0819 ; (startup + 24)
0827 : 91 19 __ STA (IP + 0),y 
0829 : c8 __ __ INY
082a : c0 29 __ CPY #$29
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
;  46, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
0880 : 20 ce 08 JSR $08ce ; (set_mixed_charset.s0 + 0)
;  50, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
0883 : 20 d7 08 JSR $08d7 ; (mapgen_init.s0 + 0)
.l38:
;  66, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
0886 : 20 2e 0b JSR $0b2e ; (oscar_clrscr.s0 + 0)
;  68, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
0889 : 20 61 0b JSR $0b61 ; (mapgen_generate_dungeon.s0 + 0)
;  70, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
088c : a9 01 __ LDA #$01
.l37:
088e : 85 14 __ STA P7 
0890 : 20 40 2d JSR $2d40 ; (render_map_viewport.s0 + 0)
0893 : 4c a1 08 JMP $08a1 ; (main.l3 + 0)
.s13:
;  74, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
0896 : a9 61 __ LDA #$61
0898 : 85 12 __ STA P5 
089a : a9 33 __ LDA #$33
089c : 85 13 __ STA P6 
089e : 20 09 33 JSR $3309 ; (save_compact_map.s0 + 0)
.l3:
;  59, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08a1 : 20 c8 32 JSR $32c8 ; (getch.l1 + 0)
08a4 : 8d 17 9f STA $9f17 ; (key + 0)
;  61, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08a7 : c9 51 __ CMP #$51
08a9 : f0 19 __ BEQ $08c4 ; (main.s5 + 0)
.s8:
08ab : c9 71 __ CMP #$71
08ad : f0 15 __ BEQ $08c4 ; (main.s5 + 0)
.s6:
;  65, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08af : c9 20 __ CMP #$20
08b1 : f0 d3 __ BEQ $0886 ; (main.l38 + 0)
.s11:
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08b3 : c9 4d __ CMP #$4d
08b5 : f0 df __ BEQ $0896 ; (main.s13 + 0)
.s16:
08b7 : c9 6d __ CMP #$6d
08b9 : f0 db __ BEQ $0896 ; (main.s13 + 0)
.s14:
;  77, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08bb : 85 0d __ STA P0 
08bd : 20 6d 33 JSR $336d ; (process_navigation_input.s0 + 0)
;  78, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08c0 : a9 00 __ LDA #$00
08c2 : f0 ca __ BEQ $088e ; (main.l37 + 0)
.s5:
;  62, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08c4 : 20 2e 0b JSR $0b2e ; (oscar_clrscr.s0 + 0)
;  82, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08c7 : a9 00 __ LDA #$00
08c9 : 85 1b __ STA ACCU + 0 
08cb : 85 1c __ STA ACCU + 1 
.s1001:
08cd : 60 __ __ RTS
--------------------------------------------------------------------
set_mixed_charset: ; set_mixed_charset()->void
.s0:
;  10, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08ce : ad 18 d0 LDA $d018 
08d1 : 09 02 __ ORA #$02
08d3 : 8d 18 d0 STA $d018 
.s1001:
;  11, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08d6 : 60 __ __ RTS
--------------------------------------------------------------------
mapgen_init: ; mapgen_init()->void
.s0:
;  48, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
08d7 : 4c da 08 JMP $08da ; (init_rng.s0 + 0)
--------------------------------------------------------------------
init_rng: ; init_rng()->void
.s0:
;  67, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
08da : 20 27 0a JSR $0a27 ; (get_hardware_entropy.s0 + 0)
08dd : a5 1b __ LDA ACCU + 0 
08df : 85 48 __ STA T3 + 0 
08e1 : 8d f3 9f STA $9ff3 ; (ix + 0)
08e4 : a5 1c __ LDA ACCU + 1 
08e6 : 85 49 __ STA T3 + 1 
08e8 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
;  68, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
08eb : 20 27 0a JSR $0a27 ; (get_hardware_entropy.s0 + 0)
08ee : a5 1b __ LDA ACCU + 0 
08f0 : 85 4a __ STA T4 + 0 
08f2 : 8d f1 9f STA $9ff1 ; (second_part + 0)
08f5 : a5 1c __ LDA ACCU + 1 
08f7 : 85 4b __ STA T4 + 1 
08f9 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
;  69, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
08fc : 20 27 0a JSR $0a27 ; (get_hardware_entropy.s0 + 0)
08ff : a5 1b __ LDA ACCU + 0 
0901 : 85 46 __ STA T2 + 0 
0903 : 8d ef 9f STA $9fef ; (screen_pos + 1)
0906 : a5 1c __ LDA ACCU + 1 
0908 : 85 47 __ STA T2 + 1 
090a : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
;  70, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
090d : 20 27 0a JSR $0a27 ; (get_hardware_entropy.s0 + 0)
0910 : a5 1b __ LDA ACCU + 0 
0912 : 8d ed 9f STA $9fed ; (highest_priority + 0)
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0915 : a9 00 __ LDA #$00
0917 : 8d 8f 35 STA $358f ; (generation_counter + 1)
;  81, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
091a : 8d ec 9f STA $9fec ; (dy + 0)
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
091d : a9 01 __ LDA #$01
091f : 8d 8e 35 STA $358e ; (generation_counter + 0)
;  70, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0922 : a5 4a __ LDA T4 + 0 
0924 : 0a __ __ ASL
0925 : 85 44 __ STA T1 + 0 
0927 : a5 4b __ LDA T4 + 1 
0929 : 2a __ __ ROL
092a : 06 44 __ ASL T1 + 0 
092c : 2a __ __ ROL
092d : 06 44 __ ASL T1 + 0 
092f : 2a __ __ ROL
0930 : 45 49 __ EOR T3 + 1 
0932 : aa __ __ TAX
0933 : a5 44 __ LDA T1 + 0 
0935 : 45 48 __ EOR T3 + 0 
0937 : 85 44 __ STA T1 + 0 
0939 : a5 46 __ LDA T2 + 0 
093b : 46 47 __ LSR T2 + 1 
093d : 6a __ __ ROR
093e : 46 47 __ LSR T2 + 1 
0940 : 6a __ __ ROR
0941 : 45 44 __ EOR T1 + 0 
0943 : a8 __ __ TAY
0944 : 8a __ __ TXA
0945 : 45 47 __ EOR T2 + 1 
0947 : 85 45 __ STA T1 + 1 
0949 : a5 1c __ LDA ACCU + 1 
094b : 8d ee 9f STA $9fee ; (entropy4 + 1)
;  75, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
094e : 06 1b __ ASL ACCU + 0 
0950 : 2a __ __ ROL
0951 : 06 1b __ ASL ACCU + 0 
0953 : 2a __ __ ROL
0954 : 06 1b __ ASL ACCU + 0 
0956 : 2a __ __ ROL
0957 : 06 1b __ ASL ACCU + 0 
0959 : 2a __ __ ROL
095a : 06 1b __ ASL ACCU + 0 
095c : 2a __ __ ROL
095d : 45 45 __ EOR T1 + 1 
095f : 8d 91 35 STA $3591 ; (rng_seed + 1)
0962 : 98 __ __ TYA
0963 : 45 1b __ EOR ACCU + 0 
0965 : 49 80 __ EOR #$80
0967 : 8d 90 35 STA $3590 ; (rng_seed + 0)
;  76, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
096a : 0a __ __ ASL
096b : 85 44 __ STA T1 + 0 
096d : ad 91 35 LDA $3591 ; (rng_seed + 1)
0970 : 2a __ __ ROL
0971 : 06 44 __ ASL T1 + 0 
0973 : 2a __ __ ROL
0974 : 06 44 __ ASL T1 + 0 
0976 : 2a __ __ ROL
0977 : 06 44 __ ASL T1 + 0 
0979 : 2a __ __ ROL
097a : 06 44 __ ASL T1 + 0 
097c : 2a __ __ ROL
097d : aa __ __ TAX
097e : ad 91 35 LDA $3591 ; (rng_seed + 1)
0981 : 4a __ __ LSR
0982 : 4a __ __ LSR
0983 : 4a __ __ LSR
0984 : 45 44 __ EOR T1 + 0 
0986 : 49 1d __ EOR #$1d
0988 : 8d 90 35 STA $3590 ; (rng_seed + 0)
098b : 8a __ __ TXA
098c : 49 ac __ EOR #$ac
098e : 8d 91 35 STA $3591 ; (rng_seed + 1)
;  78, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0991 : ad 90 35 LDA $3590 ; (rng_seed + 0)
0994 : 49 37 __ EOR #$37
0996 : 8d 90 35 STA $3590 ; (rng_seed + 0)
0999 : ad 91 35 LDA $3591 ; (rng_seed + 1)
099c : 49 9e __ EOR #$9e
099e : 8d 91 35 STA $3591 ; (rng_seed + 1)
;  79, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
09a1 : 18 __ __ CLC
09a2 : a5 4a __ LDA T4 + 0 
09a4 : 65 48 __ ADC T3 + 0 
09a6 : 85 1b __ STA ACCU + 0 
09a8 : a5 4b __ LDA T4 + 1 
09aa : 65 49 __ ADC T3 + 1 
09ac : 85 1c __ STA ACCU + 1 
09ae : a9 2f __ LDA #$2f
09b0 : 85 03 __ STA WORK + 0 
09b2 : a9 5a __ LDA #$5a
09b4 : 85 04 __ STA WORK + 1 
09b6 : 20 aa 34 JSR $34aa ; (mul16 + 0)
09b9 : a5 05 __ LDA WORK + 2 
09bb : 4d 90 35 EOR $3590 ; (rng_seed + 0)
09be : 8d 90 35 STA $3590 ; (rng_seed + 0)
09c1 : a5 06 __ LDA WORK + 3 
09c3 : 4d 91 35 EOR $3591 ; (rng_seed + 1)
09c6 : 8d 91 35 STA $3591 ; (rng_seed + 1)
.l2:
;  82, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
09c9 : ad 90 35 LDA $3590 ; (rng_seed + 0)
09cc : 0a __ __ ASL
09cd : 85 44 __ STA T1 + 0 
09cf : ad 91 35 LDA $3591 ; (rng_seed + 1)
09d2 : 2a __ __ ROL
09d3 : 06 44 __ ASL T1 + 0 
09d5 : 2a __ __ ROL
09d6 : 06 44 __ ASL T1 + 0 
09d8 : 2a __ __ ROL
09d9 : 85 45 __ STA T1 + 1 
09db : ad 91 35 LDA $3591 ; (rng_seed + 1)
09de : 4a __ __ LSR
09df : 4a __ __ LSR
09e0 : 4a __ __ LSR
09e1 : 4a __ __ LSR
09e2 : 4a __ __ LSR
09e3 : 45 44 __ EOR T1 + 0 
09e5 : ac ec 9f LDY $9fec ; (dy + 0)
09e8 : 59 71 35 EOR $3571,y ; (__multab7982L + 0)
09eb : 8d 90 35 STA $3590 ; (rng_seed + 0)
09ee : aa __ __ TAX
09ef : b9 7a 35 LDA $357a,y ; (__multab7982H + 0)
09f2 : 45 45 __ EOR T1 + 1 
09f4 : 85 1c __ STA ACCU + 1 
09f6 : 8d 91 35 STA $3591 ; (rng_seed + 1)
;  81, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
09f9 : ee ec 9f INC $9fec ; (dy + 0)
09fc : ad ec 9f LDA $9fec ; (dy + 0)
09ff : c9 04 __ CMP #$04
0a01 : 90 c6 __ BCC $09c9 ; (init_rng.l2 + 0)
.s4:
;  87, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a03 : a9 00 __ LDA #$00
0a05 : 8d ec 9f STA $9fec ; (dy + 0)
;  85, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a08 : 8a __ __ TXA
0a09 : 05 1c __ ORA ACCU + 1 
0a0b : d0 0a __ BNE $0a17 ; (init_rng.l9 + 0)
.s5:
0a0d : a9 22 __ LDA #$22
0a0f : 8d 90 35 STA $3590 ; (rng_seed + 0)
0a12 : a9 1d __ LDA #$1d
0a14 : 8d 91 35 STA $3591 ; (rng_seed + 1)
.l9:
;  88, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a17 : a9 ff __ LDA #$ff
0a19 : 20 35 0a JSR $0a35 ; (rnd.s0 + 0)
;  87, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a1c : ee ec 9f INC $9fec ; (dy + 0)
0a1f : ad ec 9f LDA $9fec ; (dy + 0)
0a22 : c9 08 __ CMP #$08
0a24 : 90 f1 __ BCC $0a17 ; (init_rng.l9 + 0)
.s1001:
;  90, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a26 : 60 __ __ RTS
--------------------------------------------------------------------
get_hardware_entropy: ; get_hardware_entropy()->u16
.s0:
;  59, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a27 : ad 12 d0 LDA $d012 
0a2a : 4d 04 dc EOR $dc04 
0a2d : 85 1b __ STA ACCU + 0 
0a2f : ad 05 dc LDA $dc05 
0a32 : 85 1c __ STA ACCU + 1 
.s1001:
0a34 : 60 __ __ RTS
--------------------------------------------------------------------
rnd: ; rnd(u8)->u8
.s0:
; 147, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a35 : c9 02 __ CMP #$02
0a37 : b0 03 __ BCS $0a3c ; (rnd.s3 + 0)
.s1:
0a39 : a9 00 __ LDA #$00
.s1001:
; 187, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a3b : 60 __ __ RTS
.s3:
0a3c : 85 0d __ STA P0 ; (max + 0)
; 151, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a3e : ad 90 35 LDA $3590 ; (rng_seed + 0)
0a41 : 85 1b __ STA ACCU + 0 
0a43 : 8d f8 9f STA $9ff8 ; (room + 1)
; 150, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a46 : ad 91 35 LDA $3591 ; (rng_seed + 1)
0a49 : 85 1c __ STA ACCU + 1 
0a4b : 85 43 __ STA T1 + 0 
0a4d : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 152, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a50 : 10 04 __ BPL $0a56 ; (rnd.s42 + 0)
.s41:
0a52 : a9 01 __ LDA #$01
0a54 : b0 02 __ BCS $0a58 ; (rnd.s43 + 0)
.s42:
; 152, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a56 : a9 00 __ LDA #$00
.s43:
0a58 : 8d f7 9f STA $9ff7 ; (d + 1)
; 155, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a5b : 06 1b __ ASL ACCU + 0 
0a5d : 26 1c __ ROL ACCU + 1 
0a5f : aa __ __ TAX
0a60 : a5 1b __ LDA ACCU + 0 
0a62 : 8d 90 35 STA $3590 ; (rng_seed + 0)
0a65 : a4 1c __ LDY ACCU + 1 
0a67 : 8c 91 35 STY $3591 ; (rng_seed + 1)
; 158, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a6a : 8a __ __ TXA
0a6b : f0 0b __ BEQ $0a78 ; (rnd.s7 + 0)
.s5:
; 159, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a6d : 98 __ __ TYA
0a6e : 49 b4 __ EOR #$b4
0a70 : 8d 91 35 STA $3591 ; (rng_seed + 1)
0a73 : a5 1b __ LDA ACCU + 0 
0a75 : 8d 90 35 STA $3590 ; (rng_seed + 0)
.s7:
; 163, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a78 : a9 00 __ LDA #$00
0a7a : 06 43 __ ASL T1 + 0 
0a7c : 2a __ __ ROL
0a7d : 06 43 __ ASL T1 + 0 
0a7f : 2a __ __ ROL
0a80 : 06 43 __ ASL T1 + 0 
0a82 : 2a __ __ ROL
0a83 : 06 43 __ ASL T1 + 0 
0a85 : 2a __ __ ROL
0a86 : 06 43 __ ASL T1 + 0 
0a88 : 2a __ __ ROL
0a89 : aa __ __ TAX
0a8a : ad f8 9f LDA $9ff8 ; (room + 1)
0a8d : 4a __ __ LSR
0a8e : 4a __ __ LSR
0a8f : 4a __ __ LSR
0a90 : 05 43 __ ORA T1 + 0 
0a92 : 4d 90 35 EOR $3590 ; (rng_seed + 0)
0a95 : 8d 90 35 STA $3590 ; (rng_seed + 0)
0a98 : 8a __ __ TXA
0a99 : 4d 91 35 EOR $3591 ; (rng_seed + 1)
0a9c : 8d 91 35 STA $3591 ; (rng_seed + 1)
; 166, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0a9f : 4d 90 35 EOR $3590 ; (rng_seed + 0)
0aa2 : 8d f6 9f STA $9ff6 ; (y2 + 0)
; 169, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0aa5 : a5 0d __ LDA P0 ; (max + 0)
0aa7 : c9 08 __ CMP #$08
0aa9 : d0 06 __ BNE $0ab1 ; (rnd.s19 + 0)
.s11:
; 175, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0aab : ad f6 9f LDA $9ff6 ; (y2 + 0)
0aae : 29 07 __ AND #$07
0ab0 : 60 __ __ RTS
.s19:
; 169, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0ab1 : 90 67 __ BCC $0b1a ; (rnd.s21 + 0)
.s20:
0ab3 : c9 10 __ CMP #$10
0ab5 : d0 06 __ BNE $0abd ; (rnd.s14 + 0)
.s12:
; 177, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0ab7 : ad f6 9f LDA $9ff6 ; (y2 + 0)
0aba : 29 0f __ AND #$0f
0abc : 60 __ __ RTS
.s14:
; 181, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0abd : a9 00 __ LDA #$00
0abf : 85 1b __ STA ACCU + 0 
0ac1 : 85 04 __ STA WORK + 1 
0ac3 : a5 0d __ LDA P0 ; (max + 0)
0ac5 : 85 03 __ STA WORK + 0 
0ac7 : a9 01 __ LDA #$01
0ac9 : 85 1c __ STA ACCU + 1 
0acb : 20 ec 34 JSR $34ec ; (divmod + 0)
0ace : a5 0d __ LDA P0 ; (max + 0)
0ad0 : 20 72 34 JSR $3472 ; (mul16by8 + 0)
0ad3 : a5 1b __ LDA ACCU + 0 
0ad5 : 8d f5 9f STA $9ff5 ; (s + 1)
; 182, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0ad8 : ad f6 9f LDA $9ff6 ; (y2 + 0)
0adb : c5 1b __ CMP ACCU + 0 
0add : 90 29 __ BCC $0b08 ; (rnd.s17 + 0)
.l16:
; 184, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0adf : ad 90 35 LDA $3590 ; (rng_seed + 0)
0ae2 : 0a __ __ ASL
0ae3 : 85 1c __ STA ACCU + 1 
0ae5 : ad 91 35 LDA $3591 ; (rng_seed + 1)
0ae8 : 2a __ __ ROL
0ae9 : aa __ __ TAX
0aea : ad 91 35 LDA $3591 ; (rng_seed + 1)
0aed : 0a __ __ ASL
0aee : a9 00 __ LDA #$00
0af0 : 2a __ __ ROL
0af1 : 45 1c __ EOR ACCU + 1 
0af3 : 49 37 __ EOR #$37
0af5 : 8d 90 35 STA $3590 ; (rng_seed + 0)
0af8 : 8a __ __ TXA
0af9 : 49 9e __ EOR #$9e
0afb : 8d 91 35 STA $3591 ; (rng_seed + 1)
; 185, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0afe : 4d 90 35 EOR $3590 ; (rng_seed + 0)
0b01 : 8d f6 9f STA $9ff6 ; (y2 + 0)
; 182, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b04 : c5 1b __ CMP ACCU + 0 
0b06 : b0 d7 __ BCS $0adf ; (rnd.l16 + 0)
.s17:
; 187, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b08 : 85 1b __ STA ACCU + 0 
0b0a : a9 00 __ LDA #$00
0b0c : 85 1c __ STA ACCU + 1 
0b0e : 85 04 __ STA WORK + 1 
0b10 : a5 0d __ LDA P0 ; (max + 0)
0b12 : 85 03 __ STA WORK + 0 
0b14 : 20 ec 34 JSR $34ec ; (divmod + 0)
0b17 : a5 05 __ LDA WORK + 2 
0b19 : 60 __ __ RTS
.s21:
; 169, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b1a : c9 02 __ CMP #$02
0b1c : d0 06 __ BNE $0b24 ; (rnd.s22 + 0)
.s9:
; 171, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b1e : ad f6 9f LDA $9ff6 ; (y2 + 0)
0b21 : 29 01 __ AND #$01
0b23 : 60 __ __ RTS
.s22:
; 169, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b24 : c9 04 __ CMP #$04
0b26 : d0 95 __ BNE $0abd ; (rnd.s14 + 0)
.s10:
; 173, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b28 : ad f6 9f LDA $9ff6 ; (y2 + 0)
0b2b : 29 03 __ AND #$03
0b2d : 60 __ __ RTS
--------------------------------------------------------------------
oscar_clrscr: ; oscar_clrscr()->void
.s0:
; 100, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b2e : a9 20 __ LDA #$20
0b30 : a2 00 __ LDX #$00
0b32 : 9d 00 04 STA $0400,x 
0b35 : e8 __ __ INX
0b36 : d0 fa __ BNE $0b32 ; (oscar_clrscr.s0 + 4)
0b38 : a2 00 __ LDX #$00
0b3a : 9d 00 05 STA $0500,x 
0b3d : e8 __ __ INX
0b3e : d0 fa __ BNE $0b3a ; (oscar_clrscr.s0 + 12)
0b40 : a2 00 __ LDX #$00
0b42 : 9d 00 06 STA $0600,x 
0b45 : e8 __ __ INX
0b46 : d0 fa __ BNE $0b42 ; (oscar_clrscr.s0 + 20)
0b48 : a2 00 __ LDX #$00
0b4a : 9d 00 07 STA $0700,x 
0b4d : e8 __ __ INX
0b4e : e0 e8 __ CPX #$e8
0b50 : d0 f8 __ BNE $0b4a ; (oscar_clrscr.s0 + 28)
0b52 : a9 00 __ LDA #$00
0b54 : 85 d3 __ STA $d3 
0b56 : 85 d6 __ STA $d6 
0b58 : a9 00 __ LDA #$00
0b5a : 85 d1 __ STA $d1 
0b5c : a9 04 __ LDA #$04
0b5e : 85 d2 __ STA $d2 
.s1001:
; 141, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b60 : 60 __ __ RTS
--------------------------------------------------------------------
mapgen_generate_dungeon: ; mapgen_generate_dungeon()->u8
.s0:
;  54, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0b61 : 20 6d 0b JSR $0b6d ; (reset_viewport_state.s0 + 0)
;  57, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0b64 : 20 7e 0b JSR $0b7e ; (reset_display_state.s0 + 0)
;  61, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0b67 : 20 9c 0b JSR $0b9c ; (reset_all_generation_data.s0 + 0)
;  63, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0b6a : 4c bc 0d JMP $0dbc ; (generate_level.s1000 + 0)
--------------------------------------------------------------------
reset_viewport_state: ; reset_viewport_state()->void
.s0:
;  24, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0b6d : a9 00 __ LDA #$00
0b6f : 8d dc 36 STA $36dc ; (view + 0)
;  25, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0b72 : 8d dd 36 STA $36dd ; (view + 1)
;  23, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0b75 : a9 20 __ LDA #$20
0b77 : 8d db 36 STA $36db ; (camera_center_y + 0)
;  22, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0b7a : 8d da 36 STA $36da ; (camera_center_x + 0)
.s1001:
;  26, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0b7d : 60 __ __ RTS
--------------------------------------------------------------------
reset_display_state: ; reset_display_state()->void
.s0:
;  37, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0b7e : a9 00 __ LDA #$00
0b80 : 8d c7 3a STA $3ac7 ; (last_scroll_direction + 0)
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0b83 : a9 01 __ LDA #$01
0b85 : 8d c6 3a STA $3ac6 ; (screen_dirty + 0)
;  31, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0b88 : a9 20 __ LDA #$20
0b8a : a2 fa __ LDX #$fa
.l1003:
0b8c : ca __ __ DEX
0b8d : 9d de 36 STA $36de,x ; (screen_buffer + 0)
0b90 : 9d d8 37 STA $37d8,x ; (screen_buffer + 250)
0b93 : 9d d2 38 STA $38d2,x ; (screen_buffer + 500)
0b96 : 9d cc 39 STA $39cc,x ; (screen_buffer + 750)
0b99 : d0 f1 __ BNE $0b8c ; (reset_display_state.l1003 + 0)
.s1001:
;  38, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/public.c"
0b9b : 60 __ __ RTS
--------------------------------------------------------------------
reset_all_generation_data: ; reset_all_generation_data()->void
.s0:
; 706, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b9c : 20 da 08 JSR $08da ; (init_rng.s0 + 0)
; 709, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0b9f : 20 ad 0b JSR $0bad ; (clear_map.s0 + 0)
; 712, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0ba2 : a9 00 __ LDA #$00
0ba4 : 8d 92 35 STA $3592 ; (room_count + 0)
; 715, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0ba7 : 20 ed 0b JSR $0bed ; (clear_room_center_cache.s0 + 0)
; 718, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0baa : 4c f3 0b JMP $0bf3 ; (init_rule_based_connection_system.s0 + 0)
--------------------------------------------------------------------
clear_map: ; clear_map()->void
.s0:
; 301, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bad : a9 00 __ LDA #$00
0baf : 85 43 __ STA T1 + 0 
0bb1 : 8d f8 9f STA $9ff8 ; (room + 1)
; 304, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bb4 : 8d f6 9f STA $9ff6 ; (y2 + 0)
0bb7 : 8d f7 9f STA $9ff7 ; (d + 1)
; 301, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bba : a9 06 __ LDA #$06
0bbc : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
.l1005:
; 305, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bbf : 18 __ __ CLC
0bc0 : a9 c8 __ LDA #$c8
0bc2 : 6d f6 9f ADC $9ff6 ; (y2 + 0)
0bc5 : a8 __ __ TAY
0bc6 : ad f7 9f LDA $9ff7 ; (d + 1)
0bc9 : 85 1c __ STA ACCU + 1 
0bcb : 69 3a __ ADC #$3a
0bcd : 85 44 __ STA T1 + 1 
0bcf : a9 00 __ LDA #$00
0bd1 : ae f6 9f LDX $9ff6 ; (y2 + 0)
0bd4 : 91 43 __ STA (T1 + 0),y 
; 304, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bd6 : 8a __ __ TXA
0bd7 : 69 01 __ ADC #$01
0bd9 : 8d f6 9f STA $9ff6 ; (y2 + 0)
0bdc : a5 1c __ LDA ACCU + 1 
0bde : 69 00 __ ADC #$00
0be0 : 8d f7 9f STA $9ff7 ; (d + 1)
0be3 : c9 06 __ CMP #$06
0be5 : d0 d8 __ BNE $0bbf ; (clear_map.l1005 + 0)
.s1006:
; 304, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0be7 : ad f6 9f LDA $9ff6 ; (y2 + 0)
0bea : d0 d3 __ BNE $0bbf ; (clear_map.l1005 + 0)
.s1001:
; 307, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bec : 60 __ __ RTS
--------------------------------------------------------------------
clear_room_center_cache: ; clear_room_center_cache()->void
.s0:
; 365, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bed : a9 00 __ LDA #$00
0bef : 8d 93 35 STA $3593 ; (room_center_cache_valid + 0)
.s1001:
; 366, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0bf2 : 60 __ __ RTS
--------------------------------------------------------------------
init_rule_based_connection_system: ; init_rule_based_connection_system()->void
.s0:
; 546, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0bf3 : a9 00 __ LDA #$00
0bf5 : 8d f5 9f STA $9ff5 ; (s + 1)
.l2:
; 547, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0bf8 : ad f5 9f LDA $9ff5 ; (s + 1)
0bfb : aa __ __ TAX
0bfc : 0a __ __ ASL
0bfd : 0a __ __ ASL
0bfe : 6d f5 9f ADC $9ff5 ; (s + 1)
0c01 : 0a __ __ ASL
0c02 : 0a __ __ ASL
0c03 : 85 43 __ STA T0 + 0 
0c05 : a9 00 __ LDA #$00
0c07 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
; 548, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c0a : 2a __ __ ROL
0c0b : 85 44 __ STA T0 + 1 
0c0d : a9 58 __ LDA #$58
0c0f : 65 43 __ ADC T0 + 0 
0c11 : 85 1b __ STA ACCU + 0 
0c13 : a9 42 __ LDA #$42
0c15 : 65 44 __ ADC T0 + 1 
0c17 : 85 1c __ STA ACCU + 1 
0c19 : 18 __ __ CLC
0c1a : a9 c8 __ LDA #$c8
0c1c : 65 43 __ ADC T0 + 0 
0c1e : 85 43 __ STA T0 + 0 
0c20 : a9 40 __ LDA #$40
0c22 : 65 44 __ ADC T0 + 1 
0c24 : 85 44 __ STA T0 + 1 
.l6:
; 549, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c26 : a9 ff __ LDA #$ff
0c28 : ac f4 9f LDY $9ff4 ; (entropy1 + 1)
0c2b : 91 1b __ STA (ACCU + 0),y 
; 548, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c2d : a9 00 __ LDA #$00
0c2f : 91 43 __ STA (T0 + 0),y 
; 547, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c31 : c8 __ __ INY
0c32 : 8c f4 9f STY $9ff4 ; (entropy1 + 1)
0c35 : c0 14 __ CPY #$14
0c37 : 90 ed __ BCC $0c26 ; (init_rule_based_connection_system.l6 + 0)
.s3:
; 546, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c39 : e8 __ __ INX
0c3a : 8e f5 9f STX $9ff5 ; (s + 1)
0c3d : e0 14 __ CPX #$14
0c3f : 90 b7 __ BCC $0bf8 ; (init_rule_based_connection_system.l2 + 0)
.s4:
; 561, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c41 : 8d f3 9f STA $9ff3 ; (ix + 0)
; 558, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c44 : 8d 9f 36 STA $369f ; (distance_cache_valid + 0)
; 557, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c47 : 8d 9e 36 STA $369e ; (connection_cache + 72)
; 554, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c4a : 8d 54 36 STA $3654 ; (corridor_pool + 192)
; 555, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c4d : 8d 55 36 STA $3655 ; (corridor_pool + 193)
; 561, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c50 : ad 92 35 LDA $3592 ; (room_count + 0)
0c53 : 85 48 __ STA T5 + 0 
0c55 : f0 74 __ BEQ $0ccb ; (init_rule_based_connection_system.s12 + 0)
.l13:
0c57 : ad f3 9f LDA $9ff3 ; (ix + 0)
0c5a : c9 14 __ CMP #$14
0c5c : b0 6d __ BCS $0ccb ; (init_rule_based_connection_system.s12 + 0)
.s10:
; 562, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c5e : 85 49 __ STA T6 + 0 
0c60 : 85 45 __ STA T2 + 0 
0c62 : 69 01 __ ADC #$01
0c64 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
0c67 : c5 48 __ CMP T5 + 0 
0c69 : b0 55 __ BCS $0cc0 ; (init_rule_based_connection_system.s11 + 0)
.s31:
; 563, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c6b : a5 45 __ LDA T2 + 0 
0c6d : 0a __ __ ASL
0c6e : 0a __ __ ASL
0c6f : 65 45 __ ADC T2 + 0 
0c71 : 0a __ __ ASL
0c72 : 0a __ __ ASL
0c73 : a2 00 __ LDX #$00
0c75 : 90 01 __ BCC $0c78 ; (init_rule_based_connection_system.s1013 + 0)
.s1012:
0c77 : e8 __ __ INX
.s1013:
0c78 : 18 __ __ CLC
0c79 : 69 58 __ ADC #$58
0c7b : 85 46 __ STA T3 + 0 
0c7d : 8a __ __ TXA
0c7e : 69 42 __ ADC #$42
0c80 : 85 47 __ STA T3 + 1 
.l18:
; 562, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c82 : ad f2 9f LDA $9ff2 ; (entropy2 + 1)
0c85 : c9 14 __ CMP #$14
0c87 : b0 37 __ BCS $0cc0 ; (init_rule_based_connection_system.s11 + 0)
.s15:
; 563, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c89 : a5 49 __ LDA T6 + 0 
0c8b : 85 13 __ STA P6 
0c8d : ad f2 9f LDA $9ff2 ; (entropy2 + 1)
0c90 : 85 14 __ STA P7 
0c92 : 20 d1 0c JSR $0cd1 ; (calculate_room_distance.s0 + 0)
0c95 : a4 14 __ LDY P7 
0c97 : 91 46 __ STA (T3 + 0),y 
0c99 : aa __ __ TAX
; 564, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0c9a : 98 __ __ TYA
0c9b : 0a __ __ ASL
0c9c : 0a __ __ ASL
0c9d : 65 14 __ ADC P7 
0c9f : 0a __ __ ASL
0ca0 : 0a __ __ ASL
0ca1 : a0 00 __ LDY #$00
0ca3 : 90 01 __ BCC $0ca6 ; (init_rule_based_connection_system.s1015 + 0)
.s1014:
0ca5 : c8 __ __ INY
.s1015:
0ca6 : 18 __ __ CLC
0ca7 : 69 58 __ ADC #$58
0ca9 : 85 43 __ STA T0 + 0 
0cab : 98 __ __ TYA
0cac : 69 42 __ ADC #$42
0cae : 85 44 __ STA T0 + 1 
0cb0 : 8a __ __ TXA
0cb1 : a4 45 __ LDY T2 + 0 
0cb3 : 91 43 __ STA (T0 + 0),y 
; 562, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0cb5 : a5 14 __ LDA P7 
0cb7 : 69 01 __ ADC #$01
0cb9 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
0cbc : c5 48 __ CMP T5 + 0 
0cbe : 90 c2 __ BCC $0c82 ; (init_rule_based_connection_system.l18 + 0)
.s11:
; 561, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0cc0 : a5 49 __ LDA T6 + 0 
0cc2 : 69 00 __ ADC #$00
0cc4 : 8d f3 9f STA $9ff3 ; (ix + 0)
0cc7 : c5 48 __ CMP T5 + 0 
0cc9 : 90 8c __ BCC $0c57 ; (init_rule_based_connection_system.l13 + 0)
.s12:
; 567, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0ccb : a9 01 __ LDA #$01
0ccd : 8d 9f 36 STA $369f ; (distance_cache_valid + 0)
.s1001:
; 568, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
0cd0 : 60 __ __ RTS
--------------------------------------------------------------------
calculate_room_distance: ; calculate_room_distance(u8,u8)->u8
.s0:
; 376, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0cd1 : a5 13 __ LDA P6 ; (room1 + 0)
0cd3 : 85 0d __ STA P0 
0cd5 : a9 f9 __ LDA #$f9
0cd7 : 85 0e __ STA P1 
0cd9 : a9 9f __ LDA #$9f
0cdb : 85 11 __ STA P4 
0cdd : a9 9f __ LDA #$9f
0cdf : 85 0f __ STA P2 
0ce1 : a9 f8 __ LDA #$f8
0ce3 : 85 10 __ STA P3 
0ce5 : 20 16 0d JSR $0d16 ; (get_room_center.s0 + 0)
; 377, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0ce8 : a5 14 __ LDA P7 ; (room2 + 0)
0cea : 85 0d __ STA P0 
0cec : a9 f7 __ LDA #$f7
0cee : 85 0e __ STA P1 
0cf0 : a9 9f __ LDA #$9f
0cf2 : 85 11 __ STA P4 
0cf4 : a9 9f __ LDA #$9f
0cf6 : 85 0f __ STA P2 
0cf8 : a9 f6 __ LDA #$f6
0cfa : 85 10 __ STA P3 
0cfc : 20 16 0d JSR $0d16 ; (get_room_center.s0 + 0)
; 378, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0cff : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
0d02 : 85 0f __ STA P2 
0d04 : ad f8 9f LDA $9ff8 ; (room + 1)
0d07 : 85 10 __ STA P3 
0d09 : ad f7 9f LDA $9ff7 ; (d + 1)
0d0c : 85 11 __ STA P4 
0d0e : ad f6 9f LDA $9ff6 ; (y2 + 0)
0d11 : 85 12 __ STA P5 
0d13 : 4c 91 0d JMP $0d91 ; (manhattan_distance.s0 + 0)
--------------------------------------------------------------------
get_room_center: ; get_room_center(u8,u8*,u8*)->void
.s0:
; 333, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d16 : ad 93 35 LDA $3593 ; (room_center_cache_valid + 0)
0d19 : d0 05 __ BNE $0d20 ; (get_room_center.s4 + 0)
.s1002:
; 336, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d1b : a5 0d __ LDA P0 ; (room_id + 0)
0d1d : 4c 26 0d JMP $0d26 ; (get_room_center.s1 + 0)
.s4:
; 333, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d20 : a5 0d __ LDA P0 ; (room_id + 0)
0d22 : c9 14 __ CMP #$14
0d24 : 90 5c __ BCC $0d82 ; (get_room_center.s3 + 0)
.s1:
; 336, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d26 : 85 1b __ STA ACCU + 0 
0d28 : 0a __ __ ASL
0d29 : 0a __ __ ASL
0d2a : 0a __ __ ASL
0d2b : aa __ __ TAX
0d2c : bd 02 44 LDA $4402,x ; (rooms + 2)
0d2f : 38 __ __ SEC
0d30 : e9 01 __ SBC #$01
0d32 : a8 __ __ TAY
0d33 : a9 00 __ LDA #$00
0d35 : e9 00 __ SBC #$00
0d37 : 85 44 __ STA T2 + 1 
0d39 : 0a __ __ ASL
0d3a : 98 __ __ TYA
0d3b : 69 00 __ ADC #$00
0d3d : 85 43 __ STA T2 + 0 
0d3f : a5 44 __ LDA T2 + 1 
0d41 : 69 00 __ ADC #$00
0d43 : 4a __ __ LSR
0d44 : 66 43 __ ROR T2 + 0 
0d46 : bd 00 44 LDA $4400,x ; (rooms + 0)
0d49 : 18 __ __ CLC
0d4a : 65 43 __ ADC T2 + 0 
0d4c : a0 00 __ LDY #$00
0d4e : 91 0e __ STA (P1),y ; (center_x + 0)
; 337, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d50 : bd 03 44 LDA $4403,x ; (rooms + 3)
0d53 : 38 __ __ SEC
0d54 : e9 01 __ SBC #$01
0d56 : 85 43 __ STA T2 + 0 
0d58 : 98 __ __ TYA
0d59 : e9 00 __ SBC #$00
0d5b : 85 44 __ STA T2 + 1 
0d5d : 0a __ __ ASL
0d5e : a5 43 __ LDA T2 + 0 
0d60 : 69 00 __ ADC #$00
0d62 : 85 43 __ STA T2 + 0 
0d64 : a5 44 __ LDA T2 + 1 
0d66 : 69 00 __ ADC #$00
0d68 : 4a __ __ LSR
0d69 : 66 43 __ ROR T2 + 0 
0d6b : bd 01 44 LDA $4401,x ; (rooms + 1)
0d6e : 18 __ __ CLC
0d6f : 65 43 __ ADC T2 + 0 
0d71 : 91 10 __ STA (P3),y ; (center_y + 0)
; 340, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d73 : b1 0e __ LDA (P1),y ; (center_x + 0)
0d75 : 06 1b __ ASL ACCU + 0 
0d77 : a6 1b __ LDX ACCU + 0 
0d79 : 9d a0 44 STA $44a0,x ; (room_center_cache + 0)
; 341, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d7c : b1 10 __ LDA (P3),y ; (center_y + 0)
0d7e : 9d a1 44 STA $44a1,x ; (room_center_cache + 1)
0d81 : 60 __ __ RTS
.s3:
; 346, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d82 : 0a __ __ ASL
0d83 : aa __ __ TAX
0d84 : bd a0 44 LDA $44a0,x ; (room_center_cache + 0)
0d87 : a0 00 __ LDY #$00
0d89 : 91 0e __ STA (P1),y ; (center_x + 0)
; 347, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d8b : bd a1 44 LDA $44a1,x ; (room_center_cache + 1)
0d8e : 91 10 __ STA (P3),y ; (center_y + 0)
.s1001:
; 343, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d90 : 60 __ __ RTS
--------------------------------------------------------------------
manhattan_distance: ; manhattan_distance(u8,u8,u8,u8)->u8
.s0:
; 370, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0d91 : a5 0f __ LDA P2 ; (x1 + 0)
0d93 : 85 0d __ STA P0 
0d95 : a5 11 __ LDA P4 ; (x2 + 0)
0d97 : 85 0e __ STA P1 
0d99 : 20 ad 0d JSR $0dad ; (fast_abs_diff.s0 + 0)
0d9c : 85 43 __ STA T0 + 0 
0d9e : a5 10 __ LDA P3 ; (y1 + 0)
0da0 : 85 0d __ STA P0 
0da2 : a5 12 __ LDA P5 ; (y2 + 0)
0da4 : 85 0e __ STA P1 
0da6 : 20 ad 0d JSR $0dad ; (fast_abs_diff.s0 + 0)
0da9 : 18 __ __ CLC
0daa : 65 43 __ ADC T0 + 0 
.s1001:
0dac : 60 __ __ RTS
--------------------------------------------------------------------
fast_abs_diff: ; fast_abs_diff(u8,u8)->u8
.s0:
; 328, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0dad : a5 0e __ LDA P1 ; (b + 0)
0daf : c5 0d __ CMP P0 ; (a + 0)
0db1 : 90 03 __ BCC $0db6 ; (fast_abs_diff.s2 + 0)
.s3:
0db3 : e5 0d __ SBC P0 ; (a + 0)
0db5 : 60 __ __ RTS
.s2:
; 328, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0db6 : 38 __ __ SEC
0db7 : a5 0d __ LDA P0 ; (a + 0)
0db9 : e5 0e __ SBC P1 ; (b + 0)
.s1001:
0dbb : 60 __ __ RTS
--------------------------------------------------------------------
generate_level: ; generate_level()->u8
.s1000:
0dbc : a2 09 __ LDX #$09
0dbe : b5 53 __ LDA T1 + 0,x 
0dc0 : 9d 18 9f STA $9f18,x ; (generate_level@stack + 0)
0dc3 : ca __ __ DEX
0dc4 : 10 f8 __ BPL $0dbe ; (generate_level.s1000 + 2)
.s0:
; 159, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0dc6 : a9 38 __ LDA #$38
0dc8 : 85 0e __ STA P1 
0dca : a9 10 __ LDA #$10
0dcc : 85 0f __ STA P2 
0dce : 20 f6 0f JSR $0ff6 ; (print_text.s0 + 0)
; 165, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0dd1 : 20 5c 10 JSR $105c ; (create_rooms.s1000 + 0)
; 167, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0dd4 : ad 92 35 LDA $3592 ; (room_count + 0)
0dd7 : d0 03 __ BNE $0ddc ; (generate_level.s3 + 0)
0dd9 : 4c 6e 0e JMP $0e6e ; (generate_level.s1001 + 0)
.s3:
; 171, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ddc : 85 58 __ STA T5 + 0 
0dde : a9 54 __ LDA #$54
0de0 : 85 0e __ STA P1 
0de2 : a9 18 __ LDA #$18
0de4 : 85 0f __ STA P2 
0de6 : 20 f6 0f JSR $0ff6 ; (print_text.s0 + 0)
; 173, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0de9 : a9 00 __ LDA #$00
0deb : 8d 33 9f STA $9f33 ; (connections_made + 0)
; 176, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0dee : 20 f3 0b JSR $0bf3 ; (init_rule_based_connection_system.s0 + 0)
; 179, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0df1 : a9 00 __ LDA #$00
0df3 : 8d 32 9f STA $9f32 ; (i + 0)
.l6:
; 180, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0df6 : a9 00 __ LDA #$00
0df8 : ae 32 9f LDX $9f32 ; (i + 0)
0dfb : 9d 34 9f STA $9f34,x ; (connected + 0)
; 179, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0dfe : ee 32 9f INC $9f32 ; (i + 0)
0e01 : ad 32 9f LDA $9f32 ; (i + 0)
0e04 : c9 14 __ CMP #$14
0e06 : 90 ee __ BCC $0df6 ; (generate_level.l6 + 0)
.s8:
; 187, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e08 : a9 00 __ LDA #$00
0e0a : 85 1c __ STA ACCU + 1 
0e0c : 8d 2e 9f STA $9f2e ; (iterations + 0)
0e0f : 8d 2f 9f STA $9f2f ; (iterations + 1)
; 184, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e12 : a9 01 __ LDA #$01
0e14 : 8d 34 9f STA $9f34 ; (connected + 0)
; 186, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e17 : a5 58 __ LDA T5 + 0 
0e19 : 85 1b __ STA ACCU + 0 
0e1b : 20 72 34 JSR $3472 ; (mul16by8 + 0)
0e1e : a5 1b __ LDA ACCU + 0 
0e20 : 0a __ __ ASL
0e21 : 85 55 __ STA T3 + 0 
0e23 : 8d 30 9f STA $9f30 ; (max_iterations + 0)
0e26 : a5 1c __ LDA ACCU + 1 
0e28 : 2a __ __ ROL
0e29 : 85 56 __ STA T3 + 1 
0e2b : 8d 31 9f STA $9f31 ; (max_iterations + 1)
0e2e : 4c 40 0e JMP $0e40 ; (generate_level.l9 + 0)
.s279:
; 246, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e31 : 18 __ __ CLC
0e32 : a5 53 __ LDA T1 + 0 
0e34 : 69 01 __ ADC #$01
0e36 : 8d 2e 9f STA $9f2e ; (iterations + 0)
0e39 : a5 54 __ LDA T1 + 1 
0e3b : 69 00 __ ADC #$00
0e3d : 8d 2f 9f STA $9f2f ; (iterations + 1)
.l9:
; 188, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e40 : ad 33 9f LDA $9f33 ; (connections_made + 0)
0e43 : 85 59 __ STA T6 + 0 
0e45 : 38 __ __ SEC
0e46 : a5 58 __ LDA T5 + 0 
0e48 : e9 01 __ SBC #$01
0e4a : 90 1a __ BCC $0e66 ; (generate_level.s11 + 0)
.s1008:
0e4c : c5 59 __ CMP T6 + 0 
0e4e : 90 16 __ BCC $0e66 ; (generate_level.s11 + 0)
.s1024:
0e50 : f0 14 __ BEQ $0e66 ; (generate_level.s11 + 0)
.s12:
0e52 : ad 2e 9f LDA $9f2e ; (iterations + 0)
0e55 : 85 53 __ STA T1 + 0 
0e57 : ad 2f 9f LDA $9f2f ; (iterations + 1)
0e5a : 85 54 __ STA T1 + 1 
0e5c : c5 56 __ CMP T3 + 1 
0e5e : d0 04 __ BNE $0e64 ; (generate_level.s1006 + 0)
.s1005:
0e60 : a5 53 __ LDA T1 + 0 
0e62 : c5 55 __ CMP T3 + 0 
.s1006:
0e64 : 90 15 __ BCC $0e7b ; (generate_level.s10 + 0)
.s11:
; 251, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e66 : 20 1c 28 JSR $281c ; (add_walls.s0 + 0)
; 254, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e69 : 20 19 2c JSR $2c19 ; (add_stairs.s0 + 0)
; 256, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e6c : a9 01 __ LDA #$01
.s1001:
0e6e : 85 1b __ STA ACCU + 0 
0e70 : a2 09 __ LDX #$09
0e72 : bd 18 9f LDA $9f18,x ; (generate_level@stack + 0)
0e75 : 95 53 __ STA T1 + 0,x 
0e77 : ca __ __ DEX
0e78 : 10 f8 __ BPL $0e72 ; (generate_level.s1001 + 4)
0e7a : 60 __ __ RTS
.s10:
; 196, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e7b : a9 00 __ LDA #$00
0e7d : 8d 32 9f STA $9f32 ; (i + 0)
; 192, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e80 : 8d 2a 9f STA $9f2a ; (connection_found + 0)
; 193, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e83 : 8d 29 9f STA $9f29 ; (failed_attempts + 0)
; 190, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e86 : a9 ff __ LDA #$ff
0e88 : 8d 2d 9f STA $9f2d ; (best_room1 + 0)
0e8b : 8d 2c 9f STA $9f2c ; (best_room2 + 0)
; 191, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e8e : 8d 2b 9f STA $9f2b ; (best_distance + 0)
; 196, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e91 : a5 58 __ LDA T5 + 0 
0e93 : f0 02 __ BEQ $0e97 ; (generate_level.s1023 + 0)
.s1022:
0e95 : a9 01 __ LDA #$01
.s1023:
0e97 : 85 5a __ STA T7 + 0 
0e99 : d0 03 __ BNE $0e9e ; (generate_level.l14 + 0)
0e9b : 4c 4d 0f JMP $0f4d ; (generate_level.s41 + 0)
.l14:
; 197, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e9e : ae 32 9f LDX $9f32 ; (i + 0)
0ea1 : 86 5b __ STX T8 + 0 
0ea3 : bd 34 9f LDA $9f34,x ; (connected + 0)
0ea6 : f0 64 __ BEQ $0f0c ; (generate_level.s15 + 0)
.s19:
; 198, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ea8 : a9 00 __ LDA #$00
0eaa : 8d 28 9f STA $9f28 ; (j + 0)
0ead : a5 5a __ LDA T7 + 0 
0eaf : f0 5b __ BEQ $0f0c ; (generate_level.s15 + 0)
.l22:
; 199, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0eb1 : ae 28 9f LDX $9f28 ; (j + 0)
0eb4 : 86 5c __ STX T9 + 0 
0eb6 : bd 34 9f LDA $9f34,x ; (connected + 0)
0eb9 : d0 45 __ BNE $0f00 ; (generate_level.s21 + 0)
.s27:
; 200, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ebb : a5 5b __ LDA T8 + 0 
0ebd : 85 0d __ STA P0 
0ebf : a5 5c __ LDA T9 + 0 
0ec1 : 85 0e __ STA P1 
0ec3 : 20 69 18 JSR $1869 ; (rooms_are_connected.s0 + 0)
0ec6 : aa __ __ TAX
0ec7 : d0 37 __ BNE $0f00 ; (generate_level.s21 + 0)
.s31:
; 202, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ec9 : a5 0d __ LDA P0 
0ecb : 85 17 __ STA P10 
0ecd : a5 5c __ LDA T9 + 0 
0ecf : 85 18 __ STA P11 
0ed1 : 20 94 18 JSR $1894 ; (can_connect_rooms_safely.s0 + 0)
0ed4 : a5 1b __ LDA ACCU + 0 
0ed6 : f0 28 __ BEQ $0f00 ; (generate_level.s21 + 0)
.s35:
; 203, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ed8 : a5 5b __ LDA T8 + 0 
0eda : 85 13 __ STA P6 
0edc : a5 5c __ LDA T9 + 0 
0ede : 85 14 __ STA P7 
0ee0 : 20 d1 0c JSR $0cd1 ; (calculate_room_distance.s0 + 0)
0ee3 : 8d 27 9f STA $9f27 ; (distance + 0)
; 204, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ee6 : cd 2b 9f CMP $9f2b ; (best_distance + 0)
0ee9 : b0 15 __ BCS $0f00 ; (generate_level.s21 + 0)
.s37:
; 206, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0eeb : a5 13 __ LDA P6 
0eed : 8d 2d 9f STA $9f2d ; (best_room1 + 0)
; 207, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ef0 : a5 5c __ LDA T9 + 0 
0ef2 : 8d 2c 9f STA $9f2c ; (best_room2 + 0)
; 205, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ef5 : ad 27 9f LDA $9f27 ; (distance + 0)
0ef8 : 8d 2b 9f STA $9f2b ; (best_distance + 0)
; 208, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0efb : a9 01 __ LDA #$01
0efd : 8d 2a 9f STA $9f2a ; (connection_found + 0)
.s21:
; 198, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f00 : 18 __ __ CLC
0f01 : a5 5c __ LDA T9 + 0 
0f03 : 69 01 __ ADC #$01
0f05 : 8d 28 9f STA $9f28 ; (j + 0)
0f08 : c5 58 __ CMP T5 + 0 
0f0a : 90 a5 __ BCC $0eb1 ; (generate_level.l22 + 0)
.s15:
; 196, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f0c : 18 __ __ CLC
0f0d : a5 5b __ LDA T8 + 0 
0f0f : 69 01 __ ADC #$01
0f11 : 8d 32 9f STA $9f32 ; (i + 0)
0f14 : c5 58 __ CMP T5 + 0 
0f16 : 90 86 __ BCC $0e9e ; (generate_level.l14 + 0)
.s16:
; 213, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f18 : ad 2a 9f LDA $9f2a ; (connection_found + 0)
0f1b : f0 30 __ BEQ $0f4d ; (generate_level.s41 + 0)
.s43:
0f1d : ad 2d 9f LDA $9f2d ; (best_room1 + 0)
0f20 : 8d fe 9f STA $9ffe ; (sstack + 4)
0f23 : ad 2c 9f LDA $9f2c ; (best_room2 + 0)
0f26 : 85 57 __ STA T4 + 0 
0f28 : 8d ff 9f STA $9fff ; (sstack + 5)
0f2b : 20 bb 19 JSR $19bb ; (rule_based_connect_rooms.s1000 + 0)
0f2e : a5 1b __ LDA ACCU + 0 
0f30 : f0 1b __ BEQ $0f4d ; (generate_level.s41 + 0)
.s40:
; 214, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f32 : a9 01 __ LDA #$01
0f34 : a6 57 __ LDX T4 + 0 
0f36 : 9d 34 9f STA $9f34,x ; (connected + 0)
; 215, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f39 : a6 59 __ LDX T6 + 0 
0f3b : e8 __ __ INX
0f3c : 8e 33 9f STX $9f33 ; (connections_made + 0)
; 216, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f3f : a9 25 __ LDA #$25
0f41 : 85 0e __ STA P1 
0f43 : a9 17 __ LDA #$17
0f45 : 85 0f __ STA P2 
0f47 : 20 f6 0f JSR $0ff6 ; (print_text.s0 + 0)
0f4a : 4c 31 0e JMP $0e31 ; (generate_level.s279 + 0)
.s41:
; 221, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f4d : a9 00 __ LDA #$00
0f4f : 8d 32 9f STA $9f32 ; (i + 0)
; 220, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f52 : 8d 2a 9f STA $9f2a ; (connection_found + 0)
; 221, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f55 : a5 5a __ LDA T7 + 0 
0f57 : d0 03 __ BNE $0f5c ; (generate_level.l48 + 0)
0f59 : 4c f2 0f JMP $0ff2 ; (generate_level.s79 + 0)
.l48:
; 222, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f5c : ae 32 9f LDX $9f32 ; (i + 0)
0f5f : 86 59 __ STX T6 + 0 
0f61 : bd 34 9f LDA $9f34,x ; (connected + 0)
0f64 : f0 6e __ BEQ $0fd4 ; (generate_level.s49 + 0)
.s54:
; 223, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f66 : a9 00 __ LDA #$00
0f68 : 8d 26 9f STA $9f26 ; (j + 0)
0f6b : a5 5a __ LDA T7 + 0 
0f6d : f0 65 __ BEQ $0fd4 ; (generate_level.s49 + 0)
.l60:
0f6f : ad 2a 9f LDA $9f2a ; (connection_found + 0)
0f72 : d0 60 __ BNE $0fd4 ; (generate_level.s49 + 0)
.s57:
; 224, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f74 : ac 26 9f LDY $9f26 ; (j + 0)
0f77 : 84 5b __ STY T8 + 0 
0f79 : b9 34 9f LDA $9f34,y ; (connected + 0)
0f7c : d0 4a __ BNE $0fc8 ; (generate_level.s56 + 0)
.s63:
; 225, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f7e : 84 0e __ STY P1 
0f80 : a5 59 __ LDA T6 + 0 
0f82 : 85 0d __ STA P0 
0f84 : 20 69 18 JSR $1869 ; (rooms_are_connected.s0 + 0)
0f87 : aa __ __ TAX
0f88 : d0 3e __ BNE $0fc8 ; (generate_level.s56 + 0)
.s67:
; 227, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f8a : a5 0d __ LDA P0 
0f8c : 85 17 __ STA P10 
0f8e : a5 5b __ LDA T8 + 0 
0f90 : 85 18 __ STA P11 
0f92 : 20 94 18 JSR $1894 ; (can_connect_rooms_safely.s0 + 0)
0f95 : a5 1b __ LDA ACCU + 0 
0f97 : f0 2f __ BEQ $0fc8 ; (generate_level.s56 + 0)
.s72:
0f99 : a5 59 __ LDA T6 + 0 
0f9b : 8d fe 9f STA $9ffe ; (sstack + 4)
0f9e : a5 5b __ LDA T8 + 0 
0fa0 : 8d ff 9f STA $9fff ; (sstack + 5)
0fa3 : 20 bb 19 JSR $19bb ; (rule_based_connect_rooms.s1000 + 0)
0fa6 : a5 1b __ LDA ACCU + 0 
0fa8 : f0 1e __ BEQ $0fc8 ; (generate_level.s56 + 0)
.s73:
; 232, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0faa : a9 01 __ LDA #$01
0fac : 8d 2a 9f STA $9f2a ; (connection_found + 0)
; 230, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0faf : a6 5b __ LDX T8 + 0 
0fb1 : 9d 34 9f STA $9f34,x ; (connected + 0)
; 231, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0fb4 : ee 33 9f INC $9f33 ; (connections_made + 0)
0fb7 : ad 33 9f LDA $9f33 ; (connections_made + 0)
; 233, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0fba : 4a __ __ LSR
0fbb : b0 0b __ BCS $0fc8 ; (generate_level.s56 + 0)
.s76:
0fbd : a9 25 __ LDA #$25
0fbf : 85 0e __ STA P1 
0fc1 : a9 17 __ LDA #$17
0fc3 : 85 0f __ STA P2 
0fc5 : 20 f6 0f JSR $0ff6 ; (print_text.s0 + 0)
.s56:
; 223, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0fc8 : 18 __ __ CLC
0fc9 : a5 5b __ LDA T8 + 0 
0fcb : 69 01 __ ADC #$01
0fcd : 8d 26 9f STA $9f26 ; (j + 0)
0fd0 : c5 58 __ CMP T5 + 0 
0fd2 : 90 9b __ BCC $0f6f ; (generate_level.l60 + 0)
.s49:
; 221, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0fd4 : 18 __ __ CLC
0fd5 : a5 59 __ LDA T6 + 0 
0fd7 : 69 01 __ ADC #$01
0fd9 : 8d 32 9f STA $9f32 ; (i + 0)
0fdc : c5 58 __ CMP T5 + 0 
0fde : ad 2a 9f LDA $9f2a ; (connection_found + 0)
0fe1 : b0 0d __ BCS $0ff0 ; (generate_level.s50 + 0)
.s51:
0fe3 : d0 03 __ BNE $0fe8 ; (generate_level.s80 + 0)
0fe5 : 4c 5c 0f JMP $0f5c ; (generate_level.l48 + 0)
.s80:
; 243, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0fe8 : a9 00 __ LDA #$00
.s1012:
0fea : 8d 29 9f STA $9f29 ; (failed_attempts + 0)
0fed : 4c 31 0e JMP $0e31 ; (generate_level.s279 + 0)
.s50:
; 239, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ff0 : d0 f6 __ BNE $0fe8 ; (generate_level.s80 + 0)
.s79:
; 240, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ff2 : a9 01 __ LDA #$01
0ff4 : d0 f4 __ BNE $0fea ; (generate_level.s1012 + 0)
--------------------------------------------------------------------
print_text: ; print_text(const u8*)->void
.s0:
; 682, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0ff6 : a9 00 __ LDA #$00
0ff8 : f0 0f __ BEQ $1009 ; (print_text.l1 + 0)
.s6:
; 686, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0ffa : 8d f8 9f STA $9ff8 ; (room + 1)
; 692, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
0ffd : 85 43 __ STA T0 + 0 
0fff : a5 43 __ LDA T0 + 0 
1001 : 20 d2 ff JSR $ffd2 
; 695, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1004 : 18 __ __ CLC
1005 : a5 44 __ LDA T3 + 0 
1007 : 69 01 __ ADC #$01
.l1:
; 682, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1009 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 683, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
100c : 85 44 __ STA T3 + 0 
100e : a8 __ __ TAY
100f : b1 0e __ LDA (P1),y ; (text + 0)
1011 : d0 01 __ BNE $1014 ; (print_text.s2 + 0)
.s1001:
; 697, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1013 : 60 __ __ RTS
.s2:
; 685, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1014 : c9 0a __ CMP #$0a
1016 : d0 04 __ BNE $101c ; (print_text.s5 + 0)
.s4:
; 686, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1018 : a9 0d __ LDA #$0d
101a : d0 de __ BNE $0ffa ; (print_text.s6 + 0)
.s5:
; 688, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
101c : 20 22 10 JSR $1022 ; (to_mixed_charset.s0 + 0)
101f : 4c fa 0f JMP $0ffa ; (print_text.s6 + 0)
--------------------------------------------------------------------
to_mixed_charset: ; to_mixed_charset(u8)->u8
.s0:
; 676, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1022 : c9 41 __ CMP #$41
1024 : 90 06 __ BCC $102c ; (to_mixed_charset.s1001 + 0)
.s4:
1026 : c9 5b __ CMP #$5b
1028 : b0 03 __ BCS $102d ; (to_mixed_charset.s3 + 0)
.s1:
102a : 69 20 __ ADC #$20
.s1001:
; 678, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
102c : 60 __ __ RTS
.s3:
; 677, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
102d : c9 61 __ CMP #$61
102f : 90 fb __ BCC $102c ; (to_mixed_charset.s1001 + 0)
.s9:
1031 : c9 7b __ CMP #$7b
1033 : b0 f7 __ BCS $102c ; (to_mixed_charset.s1001 + 0)
.s6:
1035 : e9 1f __ SBC #$1f
1037 : 60 __ __ RTS
--------------------------------------------------------------------
1038 : __ __ __ BYT 20 20 20 20 20 20 2a 2a 2a 20 48 61 63 6b 65 64 :       *** Hacked
1048 : __ __ __ BYT 20 4d 61 70 20 47 65 6e 65 72 61 74 6f 72 20 2a :  Map Generator *
1058 : __ __ __ BYT 2a 2a 0a 00                                     : **..
--------------------------------------------------------------------
create_rooms: ; create_rooms()->void
.s1000:
105c : a5 53 __ LDA T5 + 0 
105e : 8d c8 9f STA $9fc8 ; (path1 + 43)
1061 : a5 54 __ LDA T6 + 0 
1063 : 8d c9 9f STA $9fc9 ; (path1 + 44)
.s0:
; 206, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1066 : a9 00 __ LDA #$00
1068 : 8d e1 9f STA $9fe1 ; (search_x1 + 0)
; 208, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
106b : 8d d0 9f STA $9fd0 ; (path1 + 51)
; 210, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
106e : a9 1c __ LDA #$1c
1070 : 85 0e __ STA P1 
1072 : a9 12 __ LDA #$12
1074 : 85 0f __ STA P2 
1076 : 20 f6 0f JSR $0ff6 ; (print_text.s0 + 0)
; 213, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1079 : a9 00 __ LDA #$00
107b : 8d e6 9f STA $9fe6 ; (closest_corridor_y1 + 0)
107e : 18 __ __ CLC
.l1012:
; 214, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
107f : aa __ __ TAX
1080 : 9d d1 9f STA $9fd1,x ; (path1 + 52)
; 215, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1083 : ee d0 9f INC $9fd0 ; (path1 + 51)
; 213, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1086 : 69 01 __ ADC #$01
1088 : 8d e6 9f STA $9fe6 ; (closest_corridor_y1 + 0)
108b : c9 10 __ CMP #$10
; 215, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
108d : ae d0 9f LDX $9fd0 ; (path1 + 51)
1090 : 90 ed __ BCC $107f ; (create_rooms.l1012 + 0)
.s4:
1092 : 86 53 __ STX T5 + 0 
; 218, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1094 : 8a __ __ TXA
1095 : e9 01 __ SBC #$01
1097 : 85 4f __ STA T2 + 0 
1099 : 8d e6 9f STA $9fe6 ; (closest_corridor_y1 + 0)
109c : a9 00 __ LDA #$00
109e : e9 00 __ SBC #$00
10a0 : 85 50 __ STA T2 + 1 
10a2 : a5 4f __ LDA T2 + 0 
10a4 : f0 2e __ BEQ $10d4 ; (create_rooms.s8 + 0)
.l6:
; 219, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10a6 : ad e6 9f LDA $9fe6 ; (closest_corridor_y1 + 0)
10a9 : 18 __ __ CLC
10aa : 69 01 __ ADC #$01
10ac : 85 54 __ STA T6 + 0 
10ae : 20 35 0a JSR $0a35 ; (rnd.s0 + 0)
10b1 : 8d cf 9f STA $9fcf ; (path1 + 50)
; 220, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10b4 : aa __ __ TAX
10b5 : ac e6 9f LDY $9fe6 ; (closest_corridor_y1 + 0)
10b8 : b9 d1 9f LDA $9fd1,y ; (path1 + 52)
10bb : 8d ce 9f STA $9fce ; (path1 + 49)
; 221, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10be : bd d1 9f LDA $9fd1,x ; (path1 + 52)
10c1 : 99 d1 9f STA $9fd1,y ; (path1 + 52)
; 222, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10c4 : ad ce 9f LDA $9fce ; (path1 + 49)
10c7 : 9d d1 9f STA $9fd1,x ; (path1 + 52)
; 218, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10ca : 18 __ __ CLC
10cb : a5 54 __ LDA T6 + 0 
10cd : 69 fe __ ADC #$fe
10cf : 8d e6 9f STA $9fe6 ; (closest_corridor_y1 + 0)
10d2 : d0 d2 __ BNE $10a6 ; (create_rooms.l6 + 0)
.s8:
; 226, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10d4 : a9 00 __ LDA #$00
10d6 : 8d cd 9f STA $9fcd ; (path1 + 48)
.l10:
; 227, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10d9 : a9 00 __ LDA #$00
10db : 8d e6 9f STA $9fe6 ; (closest_corridor_y1 + 0)
.l13:
10de : ad e6 9f LDA $9fe6 ; (closest_corridor_y1 + 0)
10e1 : 85 51 __ STA T3 + 0 
10e3 : 85 4e __ STA T1 + 0 
10e5 : a5 50 __ LDA T2 + 1 
10e7 : 30 2d __ BMI $1116 ; (create_rooms.s11 + 0)
.s1005:
10e9 : d0 06 __ BNE $10f1 ; (create_rooms.s14 + 0)
.s1002:
10eb : a5 4e __ LDA T1 + 0 
10ed : c5 4f __ CMP T2 + 0 
10ef : b0 25 __ BCS $1116 ; (create_rooms.s11 + 0)
.s14:
; 228, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10f1 : a9 02 __ LDA #$02
10f3 : 20 35 0a JSR $0a35 ; (rnd.s0 + 0)
; 227, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10f6 : a6 51 __ LDX T3 + 0 
10f8 : e8 __ __ INX
10f9 : 8e e6 9f STX $9fe6 ; (closest_corridor_y1 + 0)
; 228, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10fc : aa __ __ TAX
10fd : f0 df __ BEQ $10de ; (create_rooms.l13 + 0)
.s17:
; 229, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10ff : a6 4e __ LDX T1 + 0 
1101 : bd d1 9f LDA $9fd1,x ; (path1 + 52)
1104 : 8d cc 9f STA $9fcc ; (path1 + 47)
; 230, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1107 : bd d2 9f LDA $9fd2,x ; (path1 + 53)
110a : 9d d1 9f STA $9fd1,x ; (path1 + 52)
; 231, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
110d : ad cc 9f LDA $9fcc ; (path1 + 47)
1110 : 9d d2 9f STA $9fd2,x ; (path1 + 53)
1113 : 4c de 10 JMP $10de ; (create_rooms.l13 + 0)
.s11:
; 226, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1116 : ee cd 9f INC $9fcd ; (path1 + 48)
1119 : ad cd 9f LDA $9fcd ; (path1 + 48)
111c : c9 02 __ CMP #$02
111e : 90 b9 __ BCC $10d9 ; (create_rooms.l10 + 0)
.s12:
; 235, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1120 : a9 00 __ LDA #$00
1122 : 8d e6 9f STA $9fe6 ; (closest_corridor_y1 + 0)
.l25:
1125 : ad e1 9f LDA $9fe1 ; (search_x1 + 0)
1128 : c9 14 __ CMP #$14
112a : 90 03 __ BCC $112f ; (create_rooms.s24 + 0)
112c : 4c e5 11 JMP $11e5 ; (create_rooms.s23 + 0)
.s24:
112f : 85 4f __ STA T2 + 0 
1131 : ad e6 9f LDA $9fe6 ; (closest_corridor_y1 + 0)
1134 : c5 53 __ CMP T5 + 0 
1136 : b0 f4 __ BCS $112c ; (create_rooms.l25 + 7)
.s21:
; 238, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1138 : 85 51 __ STA T3 + 0 
113a : a9 0a __ LDA #$0a
113c : 20 35 0a JSR $0a35 ; (rnd.s0 + 0)
113f : c9 06 __ CMP #$06
1141 : 90 17 __ BCC $115a ; (create_rooms.s26 + 0)
.s27:
; 251, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1143 : a9 05 __ LDA #$05
1145 : 20 35 0a JSR $0a35 ; (rnd.s0 + 0)
1148 : 18 __ __ CLC
1149 : 69 04 __ ADC #$04
114b : a8 __ __ TAY
; 252, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
114c : a9 05 __ LDA #$05
.s167:
; 242, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
114e : 8c e3 9f STY $9fe3 ; (door1_x + 0)
; 243, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1151 : 20 35 0a JSR $0a35 ; (rnd.s0 + 0)
1154 : 18 __ __ CLC
1155 : 69 04 __ ADC #$04
1157 : 4c 82 11 JMP $1182 ; (create_rooms.s28 + 0)
.s26:
; 240, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
115a : a9 02 __ LDA #$02
115c : 20 35 0a JSR $0a35 ; (rnd.s0 + 0)
115f : aa __ __ TAX
1160 : f0 0d __ BEQ $116f ; (create_rooms.s30 + 0)
.s29:
; 242, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1162 : a9 04 __ LDA #$04
1164 : 20 35 0a JSR $0a35 ; (rnd.s0 + 0)
1167 : 18 __ __ CLC
1168 : 69 05 __ ADC #$05
116a : a8 __ __ TAY
; 243, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
116b : a9 03 __ LDA #$03
116d : d0 df __ BNE $114e ; (create_rooms.s167 + 0)
.s30:
; 246, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
116f : a9 03 __ LDA #$03
1171 : 20 35 0a JSR $0a35 ; (rnd.s0 + 0)
1174 : 18 __ __ CLC
1175 : 69 04 __ ADC #$04
1177 : 8d e3 9f STA $9fe3 ; (door1_x + 0)
; 247, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
117a : a9 04 __ LDA #$04
117c : 20 35 0a JSR $0a35 ; (rnd.s0 + 0)
117f : 18 __ __ CLC
1180 : 69 05 __ ADC #$05
.s28:
; 243, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1182 : 8d e2 9f STA $9fe2 ; (min_dist2 + 0)
; 255, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1185 : 85 17 __ STA P10 
1187 : a6 51 __ LDX T3 + 0 
1189 : bd d1 9f LDA $9fd1,x ; (path1 + 52)
118c : 85 15 __ STA P8 
118e : ad e3 9f LDA $9fe3 ; (door1_x + 0)
1191 : 85 52 __ STA T4 + 0 
1193 : 85 16 __ STA P9 
1195 : a9 e5 __ LDA #$e5
1197 : 8d fa 9f STA $9ffa ; (sstack + 0)
119a : a9 9f __ LDA #$9f
119c : 8d fb 9f STA $9ffb ; (sstack + 1)
119f : a9 e4 __ LDA #$e4
11a1 : 8d fc 9f STA $9ffc ; (sstack + 2)
11a4 : a9 9f __ LDA #$9f
11a6 : 8d fd 9f STA $9ffd ; (sstack + 3)
11a9 : 20 2c 12 JSR $122c ; (try_place_room_at_grid.s0 + 0)
11ac : a5 1b __ LDA ACCU + 0 
11ae : f0 26 __ BEQ $11d6 ; (create_rooms.s20 + 0)
.s32:
; 256, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11b0 : ad e5 9f LDA $9fe5 ; (tile + 0)
11b3 : 85 13 __ STA P6 
11b5 : ad e4 9f LDA $9fe4 ; (y + 0)
11b8 : 85 14 __ STA P7 
11ba : a5 52 __ LDA T4 + 0 
11bc : 85 15 __ STA P8 
11be : a5 17 __ LDA P10 
11c0 : 85 16 __ STA P9 
11c2 : 20 8c 15 JSR $158c ; (place_room.s0 + 0)
; 257, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11c5 : a6 4f __ LDX T2 + 0 
11c7 : e8 __ __ INX
11c8 : 8e e1 9f STX $9fe1 ; (search_x1 + 0)
; 258, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11cb : a9 25 __ LDA #$25
11cd : 85 0e __ STA P1 
11cf : a9 17 __ LDA #$17
11d1 : 85 0f __ STA P2 
11d3 : 20 f6 0f JSR $0ff6 ; (print_text.s0 + 0)
.s20:
; 235, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11d6 : 18 __ __ CLC
11d7 : a5 51 __ LDA T3 + 0 
11d9 : 69 01 __ ADC #$01
11db : 8d e6 9f STA $9fe6 ; (closest_corridor_y1 + 0)
11de : c9 14 __ CMP #$14
11e0 : b0 03 __ BCS $11e5 ; (create_rooms.s23 + 0)
11e2 : 4c 25 11 JMP $1125 ; (create_rooms.l25 + 0)
.s23:
; 262, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11e5 : ad e1 9f LDA $9fe1 ; (search_x1 + 0)
11e8 : 85 4d __ STA T0 + 0 
11ea : 8d 92 35 STA $3592 ; (room_count + 0)
; 263, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11ed : 20 27 17 JSR $1727 ; (assign_room_priorities.s0 + 0)
; 266, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11f0 : 20 6f 17 JSR $176f ; (init_room_center_cache.s0 + 0)
; 269, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11f3 : a5 4d __ LDA T0 + 0 
11f5 : f0 1a __ BEQ $1211 ; (create_rooms.s1001 + 0)
.s35:
; 270, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11f7 : a9 00 __ LDA #$00
11f9 : 85 0d __ STA P0 
11fb : a9 36 __ LDA #$36
11fd : 85 11 __ STA P4 
11ff : a9 da __ LDA #$da
1201 : 85 0e __ STA P1 
1203 : a9 36 __ LDA #$36
1205 : 85 0f __ STA P2 
1207 : a9 db __ LDA #$db
1209 : 85 10 __ STA P3 
120b : 20 16 0d JSR $0d16 ; (get_room_center.s0 + 0)
; 271, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
120e : 20 e3 17 JSR $17e3 ; (update_camera.s0 + 0)
.s1001:
1211 : ad c8 9f LDA $9fc8 ; (path1 + 43)
1214 : 85 53 __ STA T5 + 0 
1216 : ad c9 9f LDA $9fc9 ; (path1 + 44)
1219 : 85 54 __ STA T6 + 0 
; 273, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
121b : 60 __ __ RTS
--------------------------------------------------------------------
121c : __ __ __ BYT 0a 42 75 69 6c 64 69 6e 67 20 72 6f 6f 6d 73 00 : .Building rooms.
--------------------------------------------------------------------
try_place_room_at_grid: ; try_place_room_at_grid(u8,u8,u8,u8*,u8*)->u8
.s0:
;  83, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
122c : a9 00 __ LDA #$00
122e : 8d e8 9f STA $9fe8 ; (room2_center_y + 0)
.l2:
;  87, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1231 : a5 15 __ LDA P8 ; (grid_index + 0)
1233 : 85 0e __ STA P1 
1235 : a9 ea __ LDA #$ea
1237 : 85 0f __ STA P2 
1239 : a9 9f __ LDA #$9f
123b : 85 12 __ STA P5 
123d : a9 9f __ LDA #$9f
123f : 85 10 __ STA P3 
1241 : a9 e9 __ LDA #$e9
1243 : 85 11 __ STA P4 
1245 : 20 04 13 JSR $1304 ; (get_grid_position.s0 + 0)
;  90, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1248 : a9 0a __ LDA #$0a
124a : 20 35 0a JSR $0a35 ; (rnd.s0 + 0)
124d : c9 05 __ CMP #$05
124f : b0 66 __ BCS $12b7 ; (try_place_room_at_grid.s6 + 0)
.s4:
;  92, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1251 : a9 08 __ LDA #$08
1253 : 8d e7 9f STA $9fe7 ; (offset_range + 0)
;  93, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1256 : 20 35 0a JSR $0a35 ; (rnd.s0 + 0)
1259 : 38 __ __ SEC
125a : e9 04 __ SBC #$04
125c : 18 __ __ CLC
125d : 6d ea 9f ADC $9fea ; (check_y + 0)
1260 : 85 4c __ STA T2 + 0 
1262 : 8d ea 9f STA $9fea ; (check_y + 0)
;  94, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1265 : a9 08 __ LDA #$08
1267 : 20 35 0a JSR $0a35 ; (rnd.s0 + 0)
126a : 38 __ __ SEC
126b : e9 04 __ SBC #$04
126d : 18 __ __ CLC
126e : 6d e9 9f ADC $9fe9 ; (y + 0)
1271 : 8d e9 9f STA $9fe9 ; (y + 0)
;  97, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1274 : a5 4c __ LDA T2 + 0 
1276 : c9 04 __ CMP #$04
1278 : b0 05 __ BCS $127f ; (try_place_room_at_grid.s9 + 0)
.s7:
127a : a9 04 __ LDA #$04
127c : 8d ea 9f STA $9fea ; (check_y + 0)
.s9:
;  98, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
127f : ad e9 9f LDA $9fe9 ; (y + 0)
1282 : c9 04 __ CMP #$04
1284 : b0 05 __ BCS $128b ; (try_place_room_at_grid.s12 + 0)
.s10:
1286 : a9 04 __ LDA #$04
1288 : 8d e9 9f STA $9fe9 ; (y + 0)
.s12:
;  99, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
128b : 18 __ __ CLC
128c : a5 16 __ LDA P9 ; (w + 0)
128e : 6d ea 9f ADC $9fea ; (check_y + 0)
1291 : b0 04 __ BCS $1297 ; (try_place_room_at_grid.s13 + 0)
.s1003:
1293 : c9 3d __ CMP #$3d
1295 : 90 0a __ BCC $12a1 ; (try_place_room_at_grid.s15 + 0)
.s13:
1297 : a9 40 __ LDA #$40
1299 : e5 16 __ SBC P9 ; (w + 0)
129b : 38 __ __ SEC
129c : e9 04 __ SBC #$04
129e : 8d ea 9f STA $9fea ; (check_y + 0)
.s15:
; 100, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12a1 : 18 __ __ CLC
12a2 : a5 17 __ LDA P10 ; (h + 0)
12a4 : 6d e9 9f ADC $9fe9 ; (y + 0)
12a7 : b0 04 __ BCS $12ad ; (try_place_room_at_grid.s16 + 0)
.s1002:
12a9 : c9 3d __ CMP #$3d
12ab : 90 0a __ BCC $12b7 ; (try_place_room_at_grid.s6 + 0)
.s16:
12ad : a9 40 __ LDA #$40
12af : e5 17 __ SBC P10 ; (h + 0)
12b1 : 38 __ __ SEC
12b2 : e9 04 __ SBC #$04
12b4 : 8d e9 9f STA $9fe9 ; (y + 0)
.s6:
; 102, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12b7 : a5 16 __ LDA P9 ; (w + 0)
12b9 : 85 13 __ STA P6 
12bb : a5 17 __ LDA P10 ; (h + 0)
12bd : 85 14 __ STA P7 
12bf : ad ea 9f LDA $9fea ; (check_y + 0)
12c2 : 85 4b __ STA T1 + 0 
12c4 : 85 11 __ STA P4 
12c6 : ad e9 9f LDA $9fe9 ; (y + 0)
12c9 : 85 12 __ STA P5 
12cb : 20 b2 13 JSR $13b2 ; (can_place_room.s0 + 0)
12ce : a5 1b __ LDA ACCU + 0 ; (result_y + 0)
12d0 : d0 0e __ BNE $12e0 ; (try_place_room_at_grid.s19 + 0)
.s21:
; 106, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12d2 : ee e8 9f INC $9fe8 ; (room2_center_y + 0)
12d5 : ad e8 9f LDA $9fe8 ; (room2_center_y + 0)
;  85, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12d8 : c9 14 __ CMP #$14
12da : b0 03 __ BCS $12df ; (try_place_room_at_grid.s1001 + 0)
12dc : 4c 31 12 JMP $1231 ; (try_place_room_at_grid.l2 + 0)
.s1001:
; 111, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12df : 60 __ __ RTS
.s19:
; 103, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12e0 : ad fa 9f LDA $9ffa ; (sstack + 0)
12e3 : 85 43 __ STA T0 + 0 
12e5 : ad fb 9f LDA $9ffb ; (sstack + 1)
12e8 : 85 44 __ STA T0 + 1 
12ea : a5 4b __ LDA T1 + 0 
12ec : a0 00 __ LDY #$00
12ee : 91 43 __ STA (T0 + 0),y 
; 104, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12f0 : ad fc 9f LDA $9ffc ; (sstack + 2)
12f3 : 85 43 __ STA T0 + 0 
12f5 : ad fd 9f LDA $9ffd ; (sstack + 3)
12f8 : 85 44 __ STA T0 + 1 
12fa : ad e9 9f LDA $9fe9 ; (y + 0)
12fd : 91 43 __ STA (T0 + 0),y 
; 105, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12ff : a9 01 __ LDA #$01
1301 : 85 1b __ STA ACCU + 0 ; (result_y + 0)
1303 : 60 __ __ RTS
--------------------------------------------------------------------
get_grid_position: ; get_grid_position(u8,u8*,u8*)->void
.s0:
; 385, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1304 : a9 0e __ LDA #$0e
1306 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
; 386, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1309 : 8d f1 9f STA $9ff1 ; (second_part + 0)
; 393, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
130c : 8d ee 9f STA $9fee ; (entropy4 + 1)
; 394, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
130f : 8d ed 9f STA $9fed ; (highest_priority + 0)
; 383, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1312 : a5 0e __ LDA P1 ; (grid_index + 0)
1314 : 29 03 __ AND #$03
1316 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
1319 : aa __ __ TAX
; 384, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
131a : a5 0e __ LDA P1 ; (grid_index + 0)
131c : 4a __ __ LSR
131d : 4a __ __ LSR
131e : 8d f3 9f STA $9ff3 ; (ix + 0)
; 389, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1321 : bd 83 35 LDA $3583,x ; (__multab14L + 0)
1324 : 18 __ __ CLC
1325 : 69 04 __ ADC #$04
1327 : 85 45 __ STA T1 + 0 
1329 : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
; 390, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
132c : ad f3 9f LDA $9ff3 ; (ix + 0)
132f : 0a __ __ ASL
1330 : 0a __ __ ASL
1331 : 0a __ __ ASL
1332 : 38 __ __ SEC
1333 : ed f3 9f SBC $9ff3 ; (ix + 0)
1336 : 0a __ __ ASL
1337 : 18 __ __ CLC
1338 : 69 04 __ ADC #$04
133a : 85 46 __ STA T2 + 0 
133c : 8d ef 9f STA $9fef ; (screen_pos + 1)
; 397, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
133f : a9 15 __ LDA #$15
1341 : 20 35 0a JSR $0a35 ; (rnd.s0 + 0)
1344 : 85 44 __ STA T0 + 0 
1346 : 8d ec 9f STA $9fec ; (dy + 0)
; 398, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1349 : a9 15 __ LDA #$15
134b : 20 35 0a JSR $0a35 ; (rnd.s0 + 0)
134e : 8d eb 9f STA $9feb ; (screen_offset + 1)
1351 : aa __ __ TAX
; 401, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1352 : 18 __ __ CLC
1353 : a5 44 __ LDA T0 + 0 
1355 : 65 45 __ ADC T1 + 0 
1357 : 38 __ __ SEC
1358 : e9 07 __ SBC #$07
135a : a0 00 __ LDY #$00
135c : 91 0f __ STA (P2),y ; (x + 0)
; 402, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
135e : 8a __ __ TXA
135f : 18 __ __ CLC
1360 : 65 46 __ ADC T2 + 0 
1362 : 38 __ __ SEC
1363 : e9 07 __ SBC #$07
1365 : 91 11 __ STA (P4),y ; (y + 0)
; 405, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1367 : a9 06 __ LDA #$06
1369 : 20 35 0a JSR $0a35 ; (rnd.s0 + 0)
136c : 38 __ __ SEC
136d : e9 03 __ SBC #$03
136f : 18 __ __ CLC
1370 : a0 00 __ LDY #$00
1372 : 71 0f __ ADC (P2),y ; (x + 0)
1374 : 91 0f __ STA (P2),y ; (x + 0)
; 406, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1376 : a9 06 __ LDA #$06
1378 : 20 35 0a JSR $0a35 ; (rnd.s0 + 0)
137b : 38 __ __ SEC
137c : e9 03 __ SBC #$03
137e : 18 __ __ CLC
137f : a0 00 __ LDY #$00
1381 : 71 11 __ ADC (P4),y ; (y + 0)
1383 : 91 11 __ STA (P4),y ; (y + 0)
1385 : aa __ __ TAX
; 409, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1386 : b1 0f __ LDA (P2),y ; (x + 0)
1388 : c9 04 __ CMP #$04
138a : b0 08 __ BCS $1394 ; (get_grid_position.s3 + 0)
.s1:
138c : a9 04 __ LDA #$04
138e : 91 0f __ STA (P2),y ; (x + 0)
; 410, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1390 : b1 11 __ LDA (P4),y ; (y + 0)
1392 : 90 01 __ BCC $1395 ; (get_grid_position.s1002 + 0)
.s3:
; 410, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1394 : 8a __ __ TXA
.s1002:
1395 : c9 04 __ CMP #$04
1397 : b0 04 __ BCS $139d ; (get_grid_position.s6 + 0)
.s4:
; 410, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1399 : a9 04 __ LDA #$04
139b : 91 11 __ STA (P4),y ; (y + 0)
.s6:
; 411, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
139d : b1 0f __ LDA (P2),y ; (x + 0)
139f : c9 35 __ CMP #$35
13a1 : 90 04 __ BCC $13a7 ; (get_grid_position.s9 + 0)
.s7:
13a3 : a9 34 __ LDA #$34
13a5 : 91 0f __ STA (P2),y ; (x + 0)
.s9:
; 412, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
13a7 : b1 11 __ LDA (P4),y ; (y + 0)
13a9 : c9 35 __ CMP #$35
13ab : 90 04 __ BCC $13b1 ; (get_grid_position.s1001 + 0)
.s10:
13ad : a9 34 __ LDA #$34
13af : 91 11 __ STA (P4),y ; (y + 0)
.s1001:
; 413, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
13b1 : 60 __ __ RTS
--------------------------------------------------------------------
can_place_room: ; can_place_room(u8,u8,u8,u8)->u8
.s0:
;  19, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
13b2 : a5 11 __ LDA P4 ; (x + 0)
13b4 : c9 03 __ CMP #$03
13b6 : b0 03 __ BCS $13bb ; (can_place_room.s6 + 0)
13b8 : 4c 40 14 JMP $1440 ; (can_place_room.s1 + 0)
.s6:
13bb : a5 12 __ LDA P5 ; (y + 0)
13bd : c9 03 __ CMP #$03
13bf : 90 7f __ BCC $1440 ; (can_place_room.s1 + 0)
.s5:
13c1 : 18 __ __ CLC
13c2 : a5 11 __ LDA P4 ; (x + 0)
13c4 : 65 13 __ ADC P6 ; (w + 0)
13c6 : b0 78 __ BCS $1440 ; (can_place_room.s1 + 0)
.s1021:
13c8 : c9 3d __ CMP #$3d
13ca : b0 74 __ BCS $1440 ; (can_place_room.s1 + 0)
.s4:
13cc : 85 49 __ STA T5 + 0 
13ce : a5 12 __ LDA P5 ; (y + 0)
13d0 : 65 14 __ ADC P7 ; (h + 0)
13d2 : b0 6c __ BCS $1440 ; (can_place_room.s1 + 0)
.s1020:
13d4 : c9 3d __ CMP #$3d
13d6 : b0 68 __ BCS $1440 ; (can_place_room.s1 + 0)
.s3:
;  22, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
13d8 : 85 4a __ STA T7 + 0 
13da : 38 __ __ SEC
13db : a5 12 __ LDA P5 ; (y + 0)
13dd : e9 04 __ SBC #$04
13df : 85 47 __ STA T2 + 0 
13e1 : 4c e8 13 JMP $13e8 ; (can_place_room.l8 + 0)
.s10:
;  22, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
13e4 : e6 47 __ INC T2 + 0 
13e6 : a5 47 __ LDA T2 + 0 
.l8:
13e8 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
13eb : 18 __ __ CLC
13ec : a5 4a __ LDA T7 + 0 
13ee : 69 04 __ ADC #$04
13f0 : b0 04 __ BCS $13f6 ; (can_place_room.s9 + 0)
.s1017:
13f2 : c5 47 __ CMP T2 + 0 
13f4 : 90 4f __ BCC $1445 ; (can_place_room.s11 + 0)
.s9:
;  23, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
13f6 : a5 11 __ LDA P4 ; (x + 0)
13f8 : e9 04 __ SBC #$04
13fa : 8d f3 9f STA $9ff3 ; (ix + 0)
13fd : 18 __ __ CLC
13fe : a5 49 __ LDA T5 + 0 
1400 : 69 04 __ ADC #$04
1402 : 85 45 __ STA T1 + 0 
1404 : a9 00 __ LDA #$00
1406 : 2a __ __ ROL
1407 : 85 46 __ STA T1 + 1 
1409 : ad f3 9f LDA $9ff3 ; (ix + 0)
140c : 90 08 __ BCC $1416 ; (can_place_room.l12 + 0)
.s14:
;  23, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
140e : 18 __ __ CLC
140f : a5 48 __ LDA T3 + 0 
1411 : 69 01 __ ADC #$01
1413 : 8d f3 9f STA $9ff3 ; (ix + 0)
.l12:
1416 : 85 48 __ STA T3 + 0 
1418 : a5 46 __ LDA T1 + 1 
141a : d0 07 __ BNE $1423 ; (can_place_room.s13 + 0)
.s1014:
141c : a5 45 __ LDA T1 + 0 
141e : cd f3 9f CMP $9ff3 ; (ix + 0)
1421 : 90 c1 __ BCC $13e4 ; (can_place_room.s10 + 0)
.s13:
;  24, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1423 : a5 48 __ LDA T3 + 0 
1425 : 85 0d __ STA P0 
1427 : a5 47 __ LDA T2 + 0 
1429 : 85 0e __ STA P1 
142b : 20 c2 14 JSR $14c2 ; (coords_in_bounds.s0 + 0)
142e : aa __ __ TAX
142f : f0 dd __ BEQ $140e ; (can_place_room.s14 + 0)
.s16:
;  25, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1431 : a5 0d __ LDA P0 
1433 : 85 0f __ STA P2 
1435 : a5 0e __ LDA P1 
1437 : 85 10 __ STA P3 
1439 : 20 d5 14 JSR $14d5 ; (tile_is_empty.s0 + 0)
143c : a5 1b __ LDA ACCU + 0 
143e : d0 ce __ BNE $140e ; (can_place_room.s14 + 0)
.s1:
;  20, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1440 : a9 00 __ LDA #$00
.s1001:
;  54, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1442 : 85 1b __ STA ACCU + 0 
1444 : 60 __ __ RTS
.s11:
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1445 : a9 00 __ LDA #$00
1447 : 8d f1 9f STA $9ff1 ; (second_part + 0)
144a : ad 92 35 LDA $3592 ; (room_count + 0)
144d : f0 6f __ BEQ $14be ; (can_place_room.s26 + 0)
.s1022:
144f : 85 1b __ STA ACCU + 0 
1451 : a6 49 __ LDX T5 + 0 
.l24:
;  38, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1453 : 8e ee 9f STX $9fee ; (entropy4 + 1)
;  39, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1456 : a5 4a __ LDA T7 + 0 
1458 : 8d ed 9f STA $9fed ; (highest_priority + 0)
;  42, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
145b : a9 05 __ LDA #$05
145d : 8d ec 9f STA $9fec ; (dy + 0)
;  43, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1460 : 8d eb 9f STA $9feb ; (screen_offset + 1)
;  36, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1463 : ad f1 9f LDA $9ff1 ; (second_part + 0)
1466 : 0a __ __ ASL
1467 : 0a __ __ ASL
1468 : 0a __ __ ASL
1469 : a8 __ __ TAY
146a : b9 02 44 LDA $4402,y ; (rooms + 2)
146d : 79 00 44 ADC $4400,y ; (rooms + 0)
1470 : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
;  37, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1473 : b9 03 44 LDA $4403,y ; (rooms + 3)
1476 : 18 __ __ CLC
1477 : 79 01 44 ADC $4401,y ; (rooms + 1)
147a : 8d ef 9f STA $9fef ; (screen_pos + 1)
;  46, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
147d : ad f0 9f LDA $9ff0 ; (entropy3 + 1)
1480 : 18 __ __ CLC
1481 : 69 05 __ ADC #$05
1483 : b0 06 __ BCS $148b ; (can_place_room.s30 + 0)
.s1011:
1485 : c5 11 __ CMP P4 ; (x + 0)
1487 : 90 2b __ BCC $14b4 ; (can_place_room.s25 + 0)
.s1034:
1489 : f0 29 __ BEQ $14b4 ; (can_place_room.s25 + 0)
.s30:
148b : 8a __ __ TXA
148c : 18 __ __ CLC
148d : 69 05 __ ADC #$05
148f : b0 07 __ BCS $1498 ; (can_place_room.s27 + 0)
.s1008:
1491 : d9 00 44 CMP $4400,y ; (rooms + 0)
1494 : 90 1e __ BCC $14b4 ; (can_place_room.s25 + 0)
.s1033:
1496 : f0 1c __ BEQ $14b4 ; (can_place_room.s25 + 0)
.s27:
;  48, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1498 : ad ef 9f LDA $9fef ; (screen_pos + 1)
149b : 18 __ __ CLC
149c : 69 05 __ ADC #$05
149e : b0 06 __ BCS $14a6 ; (can_place_room.s34 + 0)
.s1005:
14a0 : c5 12 __ CMP P5 ; (y + 0)
14a2 : 90 10 __ BCC $14b4 ; (can_place_room.s25 + 0)
.s1032:
14a4 : f0 0e __ BEQ $14b4 ; (can_place_room.s25 + 0)
.s34:
14a6 : 18 __ __ CLC
14a7 : a5 4a __ LDA T7 + 0 
14a9 : 69 05 __ ADC #$05
14ab : b0 93 __ BCS $1440 ; (can_place_room.s1 + 0)
.s1002:
14ad : d9 01 44 CMP $4401,y ; (rooms + 1)
14b0 : 90 02 __ BCC $14b4 ; (can_place_room.s25 + 0)
.s1031:
14b2 : d0 8c __ BNE $1440 ; (can_place_room.s1 + 0)
.s25:
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
14b4 : ee f1 9f INC $9ff1 ; (second_part + 0)
14b7 : ad f1 9f LDA $9ff1 ; (second_part + 0)
14ba : c5 1b __ CMP ACCU + 0 
14bc : 90 95 __ BCC $1453 ; (can_place_room.l24 + 0)
.s26:
;  54, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
14be : a9 01 __ LDA #$01
14c0 : d0 80 __ BNE $1442 ; (can_place_room.s1001 + 0)
--------------------------------------------------------------------
coords_in_bounds: ; coords_in_bounds(u8,u8)->u8
.s0:
; 477, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
14c2 : a5 0d __ LDA P0 ; (x + 0)
14c4 : c9 40 __ CMP #$40
14c6 : b0 0a __ BCS $14d2 ; (coords_in_bounds.s2 + 0)
.s6:
14c8 : a5 0e __ LDA P1 ; (y + 0)
14ca : c9 40 __ CMP #$40
14cc : a9 00 __ LDA #$00
14ce : 2a __ __ ROL
14cf : 49 01 __ EOR #$01
14d1 : 60 __ __ RTS
.s2:
; 477, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
14d2 : a9 00 __ LDA #$00
.s1001:
14d4 : 60 __ __ RTS
--------------------------------------------------------------------
tile_is_empty: ; tile_is_empty(u8,u8)->u8
.s0:
; 284, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
14d5 : a5 0f __ LDA P2 ; (x + 0)
14d7 : c9 40 __ CMP #$40
14d9 : b0 06 __ BCS $14e1 ; (tile_is_empty.s1 + 0)
.s4:
14db : a5 10 __ LDA P3 ; (y + 0)
14dd : c9 40 __ CMP #$40
14df : 90 04 __ BCC $14e5 ; (tile_is_empty.s3 + 0)
.s1:
14e1 : a9 01 __ LDA #$01
14e3 : b0 11 __ BCS $14f6 ; (tile_is_empty.s1001 + 0)
.s3:
; 285, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
14e5 : 85 0e __ STA P1 
14e7 : a5 0f __ LDA P2 ; (x + 0)
14e9 : 85 0d __ STA P0 
14eb : 20 f9 14 JSR $14f9 ; (get_tile_core.s0 + 0)
14ee : c9 01 __ CMP #$01
14f0 : a9 00 __ LDA #$00
14f2 : 69 ff __ ADC #$ff
14f4 : 29 01 __ AND #$01
.s1001:
14f6 : 85 1b __ STA ACCU + 0 
14f8 : 60 __ __ RTS
--------------------------------------------------------------------
get_tile_core: ; get_tile_core(u8,u8)->u8
.s0:
; 259, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
14f9 : a5 0e __ LDA P1 ; (y + 0)
14fb : 4a __ __ LSR
14fc : aa __ __ TAX
14fd : a9 00 __ LDA #$00
14ff : 6a __ __ ROR
1500 : 85 43 __ STA T1 + 0 
1502 : a9 00 __ LDA #$00
1504 : 46 0e __ LSR P1 ; (y + 0)
1506 : 6a __ __ ROR
1507 : 66 0e __ ROR P1 ; (y + 0)
1509 : 6a __ __ ROR
150a : 65 43 __ ADC T1 + 0 
150c : a8 __ __ TAY
150d : 8a __ __ TXA
150e : 65 0e __ ADC P1 ; (y + 0)
1510 : aa __ __ TAX
1511 : 98 __ __ TYA
1512 : 18 __ __ CLC
1513 : 65 0d __ ADC P0 ; (x + 0)
1515 : 90 01 __ BCC $1518 ; (get_tile_core.s1013 + 0)
.s1012:
; 250, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1517 : e8 __ __ INX
.s1013:
1518 : 18 __ __ CLC
1519 : 65 0d __ ADC P0 ; (x + 0)
151b : 90 01 __ BCC $151e ; (get_tile_core.s1015 + 0)
.s1014:
; 250, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
151d : e8 __ __ INX
.s1015:
151e : 18 __ __ CLC
151f : 65 0d __ ADC P0 ; (x + 0)
1521 : 8d f8 9f STA $9ff8 ; (room + 1)
1524 : 8a __ __ TXA
1525 : 69 00 __ ADC #$00
1527 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 253, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
152a : 4a __ __ LSR
152b : 85 44 __ STA T1 + 1 
152d : ad f8 9f LDA $9ff8 ; (room + 1)
1530 : 6a __ __ ROR
1531 : 46 44 __ LSR T1 + 1 
1533 : 6a __ __ ROR
1534 : 46 44 __ LSR T1 + 1 
1536 : 6a __ __ ROR
1537 : 18 __ __ CLC
1538 : 69 c8 __ ADC #$c8
153a : 85 43 __ STA T1 + 0 
153c : 8d f6 9f STA $9ff6 ; (y2 + 0)
153f : a9 3a __ LDA #$3a
1541 : 65 44 __ ADC T1 + 1 
1543 : 85 44 __ STA T1 + 1 
1545 : 8d f7 9f STA $9ff7 ; (d + 1)
; 254, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1548 : ad f8 9f LDA $9ff8 ; (room + 1)
154b : 29 07 __ AND #$07
154d : 85 1b __ STA ACCU + 0 
154f : 8d f5 9f STA $9ff5 ; (s + 1)
; 259, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1552 : aa __ __ TAX
1553 : a0 00 __ LDY #$00
1555 : b1 43 __ LDA (T1 + 0),y 
1557 : e0 00 __ CPX #$00
1559 : f0 04 __ BEQ $155f ; (get_tile_core.s1003 + 0)
.l1002:
; 259, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
155b : 4a __ __ LSR
155c : ca __ __ DEX
155d : d0 fc __ BNE $155b ; (get_tile_core.l1002 + 0)
.s1003:
; 257, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
155f : 85 1c __ STA ACCU + 1 
1561 : a5 1b __ LDA ACCU + 0 
1563 : c9 06 __ CMP #$06
1565 : b0 05 __ BCS $156c ; (get_tile_core.s3 + 0)
.s1:
; 259, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1567 : a5 1c __ LDA ACCU + 1 
.s1001:
; 264, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1569 : 29 07 __ AND #$07
156b : 60 __ __ RTS
.s3:
; 263, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
156c : a9 08 __ LDA #$08
156e : e5 1b __ SBC ACCU + 0 
1570 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
; 264, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1573 : aa __ __ TAX
1574 : bd c6 36 LDA $36c6,x ; (bitshift + 36)
1577 : 38 __ __ SEC
1578 : e9 01 __ SBC #$01
157a : a0 01 __ LDY #$01
157c : 31 43 __ AND (T1 + 0),y 
157e : ae f4 9f LDX $9ff4 ; (entropy1 + 1)
1581 : f0 04 __ BEQ $1587 ; (get_tile_core.s1005 + 0)
.l1006:
1583 : 0a __ __ ASL
1584 : ca __ __ DEX
1585 : d0 fc __ BNE $1583 ; (get_tile_core.l1006 + 0)
.s1005:
; 264, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1587 : 05 1c __ ORA ACCU + 1 
1589 : 4c 69 15 JMP $1569 ; (get_tile_core.s1001 + 0)
--------------------------------------------------------------------
place_room: ; place_room(u8,u8,u8,u8)->void
.s0:
;  60, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
158c : a5 14 __ LDA P7 ; (y + 0)
158e : 4c 95 15 JMP $1595 ; (place_room.l1 + 0)
.s3:
;  60, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1591 : a5 4a __ LDA T3 + 0 
1593 : 69 00 __ ADC #$00
.l1:
1595 : 8d ee 9f STA $9fee ; (entropy4 + 1)
1598 : 18 __ __ CLC
1599 : a5 16 __ LDA P9 ; (h + 0)
159b : 65 14 __ ADC P7 ; (y + 0)
159d : 85 43 __ STA T0 + 0 
159f : ad ee 9f LDA $9fee ; (entropy4 + 1)
15a2 : 85 4a __ STA T3 + 0 
15a4 : b0 04 __ BCS $15aa ; (place_room.s2 + 0)
.s1005:
15a6 : c5 43 __ CMP T0 + 0 
15a8 : b0 13 __ BCS $15bd ; (place_room.s4 + 0)
.s2:
;  61, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15aa : a5 13 __ LDA P6 ; (x + 0)
15ac : 8d ef 9f STA $9fef ; (screen_pos + 1)
15af : 18 __ __ CLC
15b0 : 65 15 __ ADC P8 ; (w + 0)
15b2 : 85 48 __ STA T1 + 0 
15b4 : a9 00 __ LDA #$00
15b6 : 2a __ __ ROL
15b7 : 85 49 __ STA T1 + 1 
15b9 : a5 13 __ LDA P6 ; (x + 0)
15bb : 90 2d __ BCC $15ea ; (place_room.l5 + 0)
.s4:
;  68, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15bd : ad 92 35 LDA $3592 ; (room_count + 0)
15c0 : c9 14 __ CMP #$14
15c2 : b0 25 __ BCS $15e9 ; (place_room.s1001 + 0)
.s12:
;  69, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15c4 : 0a __ __ ASL
15c5 : 0a __ __ ASL
15c6 : 0a __ __ ASL
15c7 : aa __ __ TAX
15c8 : a5 13 __ LDA P6 ; (x + 0)
15ca : 9d 00 44 STA $4400,x ; (rooms + 0)
;  70, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15cd : a5 14 __ LDA P7 ; (y + 0)
15cf : 9d 01 44 STA $4401,x ; (rooms + 1)
;  71, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15d2 : a5 15 __ LDA P8 ; (w + 0)
15d4 : 9d 02 44 STA $4402,x ; (rooms + 2)
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15d7 : a5 16 __ LDA P9 ; (h + 0)
15d9 : 9d 03 44 STA $4403,x ; (rooms + 3)
;  74, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15dc : a9 00 __ LDA #$00
15de : 9d 04 44 STA $4404,x ; (rooms + 4)
;  73, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15e1 : a9 05 __ LDA #$05
15e3 : 9d 07 44 STA $4407,x ; (rooms + 7)
;  75, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15e6 : ee 92 35 INC $3592 ; (room_count + 0)
.s1001:
;  77, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15e9 : 60 __ __ RTS
.l5:
;  61, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15ea : a8 __ __ TAY
15eb : a5 49 __ LDA T1 + 1 
15ed : d0 2d __ BNE $161c ; (place_room.s1008 + 0)
.s1002:
15ef : 98 __ __ TYA
15f0 : c4 48 __ CPY T1 + 0 
15f2 : b0 9d __ BCS $1591 ; (place_room.s3 + 0)
.s6:
;  62, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15f4 : 85 0d __ STA P0 
15f6 : 18 __ __ CLC
15f7 : 69 01 __ ADC #$01
15f9 : 85 4b __ STA T4 + 0 
15fb : a5 4a __ LDA T3 + 0 
15fd : 85 0e __ STA P1 
15ff : 20 c2 14 JSR $14c2 ; (coords_in_bounds.s0 + 0)
1602 : aa __ __ TAX
1603 : f0 0f __ BEQ $1614 ; (place_room.s51 + 0)
.s9:
;  63, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1605 : a5 0d __ LDA P0 
1607 : 85 10 __ STA P3 
1609 : a5 0e __ LDA P1 
160b : 85 11 __ STA P4 
160d : a9 02 __ LDA #$02
160f : 85 12 __ STA P5 
1611 : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
.s51:
;  61, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1614 : a5 4b __ LDA T4 + 0 
1616 : 8d ef 9f STA $9fef ; (screen_pos + 1)
1619 : 4c ea 15 JMP $15ea ; (place_room.l5 + 0)
.s1008:
;  62, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
161c : 98 __ __ TYA
161d : 4c f4 15 JMP $15f4 ; (place_room.s6 + 0)
--------------------------------------------------------------------
set_tile_raw: ; set_tile_raw(u8,u8,u8)->void
.s0:
; 296, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1620 : a5 10 __ LDA P3 ; (x + 0)
1622 : 85 0d __ STA P0 
1624 : a5 11 __ LDA P4 ; (y + 0)
1626 : 85 0e __ STA P1 
1628 : a5 12 __ LDA P5 ; (tile + 0)
162a : 85 0f __ STA P2 
162c : 4c 2f 16 JMP $162f ; (set_compact_tile_fast.s0 + 0)
--------------------------------------------------------------------
set_compact_tile_fast: ; set_compact_tile_fast(u8,u8,u8)->void
.s0:
; 218, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
162f : a5 0d __ LDA P0 ; (x + 0)
1631 : c9 40 __ CMP #$40
1633 : b0 06 __ BCS $163b ; (set_compact_tile_fast.s1001 + 0)
.s4:
1635 : a5 0e __ LDA P1 ; (y + 0)
1637 : c9 40 __ CMP #$40
1639 : 90 01 __ BCC $163c ; (set_compact_tile_fast.s3 + 0)
.s1001:
163b : 60 __ __ RTS
.s3:
; 230, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
163c : 85 1c __ STA ACCU + 1 
163e : 4a __ __ LSR
163f : aa __ __ TAX
1640 : a9 00 __ LDA #$00
1642 : 6a __ __ ROR
1643 : 85 43 __ STA T1 + 0 
1645 : a9 00 __ LDA #$00
1647 : 46 1c __ LSR ACCU + 1 
1649 : 6a __ __ ROR
164a : 66 1c __ ROR ACCU + 1 
164c : 6a __ __ ROR
164d : 65 43 __ ADC T1 + 0 
164f : a8 __ __ TAY
1650 : 8a __ __ TXA
1651 : 65 1c __ ADC ACCU + 1 
1653 : aa __ __ TAX
1654 : 98 __ __ TYA
1655 : 18 __ __ CLC
1656 : 65 0d __ ADC P0 ; (x + 0)
1658 : 90 01 __ BCC $165b ; (set_compact_tile_fast.s1023 + 0)
.s1022:
; 221, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
165a : e8 __ __ INX
.s1023:
165b : 18 __ __ CLC
165c : 65 0d __ ADC P0 ; (x + 0)
165e : 90 01 __ BCC $1661 ; (set_compact_tile_fast.s1025 + 0)
.s1024:
; 221, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1660 : e8 __ __ INX
.s1025:
1661 : 18 __ __ CLC
1662 : 65 0d __ ADC P0 ; (x + 0)
1664 : 8d f8 9f STA $9ff8 ; (room + 1)
1667 : 8a __ __ TXA
1668 : 69 00 __ ADC #$00
166a : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 224, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
166d : 4a __ __ LSR
166e : 85 44 __ STA T1 + 1 
1670 : ad f8 9f LDA $9ff8 ; (room + 1)
1673 : 6a __ __ ROR
1674 : 46 44 __ LSR T1 + 1 
1676 : 6a __ __ ROR
1677 : 46 44 __ LSR T1 + 1 
1679 : 6a __ __ ROR
167a : 18 __ __ CLC
167b : 69 c8 __ ADC #$c8
167d : 85 43 __ STA T1 + 0 
167f : 8d f6 9f STA $9ff6 ; (y2 + 0)
1682 : a9 3a __ LDA #$3a
1684 : 65 44 __ ADC T1 + 1 
1686 : 85 44 __ STA T1 + 1 
1688 : 8d f7 9f STA $9ff7 ; (d + 1)
; 225, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
168b : ad f8 9f LDA $9ff8 ; (room + 1)
168e : 29 07 __ AND #$07
1690 : 85 1b __ STA ACCU + 0 
1692 : 8d f5 9f STA $9ff5 ; (s + 1)
; 230, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1695 : a5 0f __ LDA P2 ; (tile + 0)
1697 : 29 07 __ AND #$07
1699 : 85 1d __ STA ACCU + 2 
169b : a0 00 __ LDY #$00
169d : b1 43 __ LDA (T1 + 0),y 
169f : 85 1c __ STA ACCU + 1 
16a1 : a5 1b __ LDA ACCU + 0 
16a3 : c9 06 __ CMP #$06
16a5 : b0 1c __ BCS $16c3 ; (set_compact_tile_fast.s7 + 0)
.s6:
; 232, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16a7 : aa __ __ TAX
16a8 : bd 87 35 LDA $3587,x ; (__shltab7L + 0)
16ab : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
; 233, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16ae : 49 ff __ EOR #$ff
16b0 : 25 1c __ AND ACCU + 1 
16b2 : 85 1c __ STA ACCU + 1 
16b4 : a5 1d __ LDA ACCU + 2 
16b6 : e0 00 __ CPX #$00
16b8 : f0 04 __ BEQ $16be ; (set_compact_tile_fast.s1016 + 0)
.l1014:
16ba : 0a __ __ ASL
16bb : ca __ __ DEX
16bc : d0 fc __ BNE $16ba ; (set_compact_tile_fast.l1014 + 0)
.s1016:
; 233, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16be : 05 1c __ ORA ACCU + 1 
.s1017:
; 243, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16c0 : 91 43 __ STA (T1 + 0),y 
16c2 : 60 __ __ RTS
.s7:
; 236, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16c3 : a9 08 __ LDA #$08
16c5 : e5 1b __ SBC ACCU + 0 
16c7 : 85 1e __ STA ACCU + 3 
16c9 : 8d f3 9f STA $9ff3 ; (ix + 0)
; 237, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16cc : aa __ __ TAX
16cd : 49 03 __ EOR #$03
16cf : 85 45 __ STA T5 + 0 
16d1 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
; 239, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16d4 : bd aa 36 LDA $36aa,x ; (bitshift + 8)
16d7 : 38 __ __ SEC
16d8 : e9 01 __ SBC #$01
16da : 85 46 __ STA T6 + 0 
16dc : a6 1b __ LDX ACCU + 0 
16de : f0 04 __ BEQ $16e4 ; (set_compact_tile_fast.s1003 + 0)
.l1010:
16e0 : 0a __ __ ASL
16e1 : ca __ __ DEX
16e2 : d0 fc __ BNE $16e0 ; (set_compact_tile_fast.l1010 + 0)
.s1003:
; 239, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16e4 : 85 47 __ STA T7 + 0 
16e6 : 8d f1 9f STA $9ff1 ; (second_part + 0)
; 240, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16e9 : a6 45 __ LDX T5 + 0 
16eb : bd aa 36 LDA $36aa,x ; (bitshift + 8)
16ee : 38 __ __ SEC
16ef : e9 01 __ SBC #$01
16f1 : 85 45 __ STA T5 + 0 
16f3 : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
; 242, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
16f6 : a5 1d __ LDA ACCU + 2 
16f8 : 25 46 __ AND T6 + 0 
16fa : a6 1b __ LDX ACCU + 0 
16fc : f0 04 __ BEQ $1702 ; (set_compact_tile_fast.s1005 + 0)
.l1012:
16fe : 0a __ __ ASL
16ff : ca __ __ DEX
1700 : d0 fc __ BNE $16fe ; (set_compact_tile_fast.l1012 + 0)
.s1005:
; 242, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1702 : 85 46 __ STA T6 + 0 
1704 : a9 ff __ LDA #$ff
1706 : 45 47 __ EOR T7 + 0 
1708 : 25 1c __ AND ACCU + 1 
170a : 05 46 __ ORA T6 + 0 
170c : 91 43 __ STA (T1 + 0),y 
; 243, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
170e : a9 ff __ LDA #$ff
1710 : 45 45 __ EOR T5 + 0 
1712 : a0 01 __ LDY #$01
1714 : 31 43 __ AND (T1 + 0),y 
1716 : 85 1b __ STA ACCU + 0 
1718 : a5 1d __ LDA ACCU + 2 
171a : a6 1e __ LDX ACCU + 3 
.l1006:
171c : 4a __ __ LSR
171d : ca __ __ DEX
171e : d0 fc __ BNE $171c ; (set_compact_tile_fast.l1006 + 0)
.s1007:
1720 : 05 1b __ ORA ACCU + 0 
1722 : 4c c0 16 JMP $16c0 ; (set_compact_tile_fast.s1017 + 0)
--------------------------------------------------------------------
1725 : __ __ __ BYT 2e 00                                           : ..
--------------------------------------------------------------------
assign_room_priorities: ; assign_room_priorities()->void
.s0:
; 118, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1727 : a9 00 __ LDA #$00
1729 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
172c : ad 92 35 LDA $3592 ; (room_count + 0)
172f : 85 45 __ STA T4 + 0 
1731 : f0 3b __ BEQ $176e ; (assign_room_priorities.s1001 + 0)
.l2:
; 119, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1733 : ae f4 9f LDX $9ff4 ; (entropy1 + 1)
1736 : e8 __ __ INX
1737 : 86 46 __ STX T5 + 0 
1739 : ad f4 9f LDA $9ff4 ; (entropy1 + 1)
173c : 0a __ __ ASL
173d : 0a __ __ ASL
173e : 0a __ __ ASL
173f : 85 44 __ STA T2 + 0 
1741 : ad f4 9f LDA $9ff4 ; (entropy1 + 1)
1744 : d0 04 __ BNE $174a ; (assign_room_priorities.s6 + 0)
.s5:
; 120, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1746 : a9 0a __ LDA #$0a
1748 : d0 16 __ BNE $1760 ; (assign_room_priorities.s1 + 0)
.s6:
; 121, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
174a : a5 45 __ LDA T4 + 0 
174c : 38 __ __ SEC
174d : e9 01 __ SBC #$01
174f : cd f4 9f CMP $9ff4 ; (entropy1 + 1)
1752 : d0 04 __ BNE $1758 ; (assign_room_priorities.s9 + 0)
.s8:
; 122, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1754 : a9 08 __ LDA #$08
1756 : d0 08 __ BNE $1760 ; (assign_room_priorities.s1 + 0)
.s9:
; 124, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1758 : a9 03 __ LDA #$03
175a : 20 35 0a JSR $0a35 ; (rnd.s0 + 0)
175d : 18 __ __ CLC
175e : 69 05 __ ADC #$05
.s1:
; 120, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1760 : a6 44 __ LDX T2 + 0 
1762 : 9d 07 44 STA $4407,x ; (rooms + 7)
; 118, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1765 : a5 46 __ LDA T5 + 0 
1767 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
176a : c5 45 __ CMP T4 + 0 
176c : 90 c5 __ BCC $1733 ; (assign_room_priorities.l2 + 0)
.s1001:
; 127, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
176e : 60 __ __ RTS
--------------------------------------------------------------------
init_room_center_cache: ; init_room_center_cache()->void
.s0:
; 355, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
176f : a9 00 __ LDA #$00
1771 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
1774 : ad 92 35 LDA $3592 ; (room_count + 0)
1777 : f0 64 __ BEQ $17dd ; (init_room_center_cache.s4 + 0)
.l5:
1779 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
177c : c9 14 __ CMP #$14
177e : b0 5d __ BCS $17dd ; (init_room_center_cache.s4 + 0)
.s2:
; 357, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1780 : 85 1b __ STA ACCU + 0 
1782 : 0a __ __ ASL
1783 : 0a __ __ ASL
1784 : 0a __ __ ASL
1785 : aa __ __ TAX
1786 : bd 02 44 LDA $4402,x ; (rooms + 2)
1789 : 38 __ __ SEC
178a : e9 01 __ SBC #$01
178c : 85 1c __ STA ACCU + 1 
178e : a9 00 __ LDA #$00
1790 : e9 00 __ SBC #$00
1792 : a8 __ __ TAY
1793 : 0a __ __ ASL
1794 : a5 1c __ LDA ACCU + 1 
1796 : 69 00 __ ADC #$00
1798 : 85 1c __ STA ACCU + 1 
179a : 98 __ __ TYA
179b : 69 00 __ ADC #$00
179d : 4a __ __ LSR
179e : 66 1c __ ROR ACCU + 1 
17a0 : bd 00 44 LDA $4400,x ; (rooms + 0)
17a3 : 18 __ __ CLC
17a4 : 65 1c __ ADC ACCU + 1 
17a6 : 06 1b __ ASL ACCU + 0 
17a8 : a4 1b __ LDY ACCU + 0 
17aa : 99 a0 44 STA $44a0,y ; (room_center_cache + 0)
; 358, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
17ad : bd 03 44 LDA $4403,x ; (rooms + 3)
17b0 : 38 __ __ SEC
17b1 : e9 01 __ SBC #$01
17b3 : 85 1c __ STA ACCU + 1 
17b5 : a9 00 __ LDA #$00
17b7 : e9 00 __ SBC #$00
17b9 : a8 __ __ TAY
17ba : 0a __ __ ASL
17bb : a5 1c __ LDA ACCU + 1 
17bd : 69 00 __ ADC #$00
17bf : 85 1c __ STA ACCU + 1 
17c1 : 98 __ __ TYA
17c2 : 69 00 __ ADC #$00
17c4 : 4a __ __ LSR
17c5 : 66 1c __ ROR ACCU + 1 
17c7 : bd 01 44 LDA $4401,x ; (rooms + 1)
17ca : 18 __ __ CLC
17cb : 65 1c __ ADC ACCU + 1 
17cd : a6 1b __ LDX ACCU + 0 
17cf : 9d a1 44 STA $44a1,x ; (room_center_cache + 1)
; 355, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
17d2 : ee f9 9f INC $9ff9 ; (bit_offset + 1)
17d5 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
17d8 : cd 92 35 CMP $3592 ; (room_count + 0)
17db : 90 9c __ BCC $1779 ; (init_room_center_cache.l5 + 0)
.s4:
; 360, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
17dd : a9 01 __ LDA #$01
17df : 8d 93 35 STA $3593 ; (room_center_cache_valid + 0)
.s1001:
; 361, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
17e2 : 60 __ __ RTS
--------------------------------------------------------------------
update_camera: ; update_camera()->void
.s0:
;  49, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
17e3 : ad dc 36 LDA $36dc ; (view + 0)
17e6 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
;  50, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
17e9 : ad dd 36 LDA $36dd ; (view + 1)
17ec : 8d f8 9f STA $9ff8 ; (room + 1)
;  52, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
17ef : ad db 36 LDA $36db ; (camera_center_y + 0)
17f2 : 8d f6 9f STA $9ff6 ; (y2 + 0)
;  51, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
17f5 : ad da 36 LDA $36da ; (camera_center_x + 0)
17f8 : 8d f7 9f STA $9ff7 ; (d + 1)
;  55, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
17fb : c9 14 __ CMP #$14
17fd : b0 04 __ BCS $1803 ; (update_camera.s1 + 0)
.s2:
;  58, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
17ff : a9 00 __ LDA #$00
1801 : 90 02 __ BCC $1805 ; (update_camera.s18 + 0)
.s1:
;  56, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1803 : e9 14 __ SBC #$14
.s18:
;  58, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1805 : 8d dc 36 STA $36dc ; (view + 0)
;  61, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1808 : ad db 36 LDA $36db ; (camera_center_y + 0)
180b : c9 0c __ CMP #$0c
180d : b0 04 __ BCS $1813 ; (update_camera.s4 + 0)
.s5:
;  64, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
180f : a9 00 __ LDA #$00
1811 : 90 02 __ BCC $1815 ; (update_camera.s19 + 0)
.s4:
;  62, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1813 : e9 0c __ SBC #$0c
.s19:
;  64, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1815 : 8d dd 36 STA $36dd ; (view + 1)
;  68, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1818 : a9 18 __ LDA #$18
181a : cd dc 36 CMP $36dc ; (view + 0)
181d : b0 03 __ BCS $1822 ; (update_camera.s20 + 0)
.s7:
;  69, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
181f : 8d dc 36 STA $36dc ; (view + 0)
.s20:
;  71, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1822 : a9 27 __ LDA #$27
1824 : cd dd 36 CMP $36dd ; (view + 1)
1827 : b0 03 __ BCS $182c ; (update_camera.s12 + 0)
.s10:
;  72, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1829 : 8d dd 36 STA $36dd ; (view + 1)
.s12:
;  77, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
182c : ad dc 36 LDA $36dc ; (view + 0)
182f : 18 __ __ CLC
1830 : 69 14 __ ADC #$14
1832 : 8d da 36 STA $36da ; (camera_center_x + 0)
;  78, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1835 : ad dd 36 LDA $36dd ; (view + 1)
1838 : 18 __ __ CLC
1839 : 69 0c __ ADC #$0c
183b : 8d db 36 STA $36db ; (camera_center_y + 0)
;  81, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
183e : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
1841 : cd dc 36 CMP $36dc ; (view + 0)
1844 : d0 08 __ BNE $184e ; (update_camera.s13 + 0)
.s16:
1846 : ad f8 9f LDA $9ff8 ; (room + 1)
1849 : cd dd 36 CMP $36dd ; (view + 1)
184c : f0 05 __ BEQ $1853 ; (update_camera.s1001 + 0)
.s13:
;  82, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
184e : a9 01 __ LDA #$01
1850 : 8d c6 3a STA $3ac6 ; (screen_dirty + 0)
.s1001:
;  84, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
1853 : 60 __ __ RTS
--------------------------------------------------------------------
1854 : __ __ __ BYT 0a 0a 43 72 65 61 74 69 6e 67 20 63 6f 72 72 69 : ..Creating corri
1864 : __ __ __ BYT 64 6f 72 73 00                                  : dors.
--------------------------------------------------------------------
rooms_are_connected: ; rooms_are_connected(u8,u8)->u8
.s0:
; 572, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1869 : a5 0d __ LDA P0 ; (room1 + 0)
186b : cd 92 35 CMP $3592 ; (room_count + 0)
186e : b0 07 __ BCS $1877 ; (rooms_are_connected.s1 + 0)
.s4:
1870 : a4 0e __ LDY P1 ; (room2 + 0)
; 572, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1872 : cc 92 35 CPY $3592 ; (room_count + 0)
1875 : 90 03 __ BCC $187a ; (rooms_are_connected.s3 + 0)
.s1:
1877 : a9 00 __ LDA #$00
1879 : 60 __ __ RTS
.s3:
; 573, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
187a : 0a __ __ ASL
187b : 0a __ __ ASL
187c : 65 0d __ ADC P0 ; (room1 + 0)
187e : 0a __ __ ASL
187f : 0a __ __ ASL
1880 : aa __ __ TAX
1881 : a9 00 __ LDA #$00
1883 : 2a __ __ ROL
1884 : 85 1c __ STA ACCU + 1 
1886 : 8a __ __ TXA
1887 : 69 c8 __ ADC #$c8
1889 : 85 1b __ STA ACCU + 0 
188b : a9 40 __ LDA #$40
188d : 65 1c __ ADC ACCU + 1 
188f : 85 1c __ STA ACCU + 1 
1891 : b1 1b __ LDA (ACCU + 0),y 
.s1001:
1893 : 60 __ __ RTS
--------------------------------------------------------------------
can_connect_rooms_safely: ; can_connect_rooms_safely(u8,u8)->u8
.s0:
;  76, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1894 : a5 17 __ LDA P10 ; (room1 + 0)
1896 : cd 92 35 CMP $3592 ; (room_count + 0)
1899 : b0 1f __ BCS $18ba ; (can_connect_rooms_safely.s1 + 0)
.s5:
189b : a5 18 __ LDA P11 ; (room2 + 0)
189d : cd 92 35 CMP $3592 ; (room_count + 0)
18a0 : b0 18 __ BCS $18ba ; (can_connect_rooms_safely.s1 + 0)
.s4:
18a2 : a5 17 __ LDA P10 ; (room1 + 0)
18a4 : c5 18 __ CMP P11 ; (room2 + 0)
18a6 : f0 12 __ BEQ $18ba ; (can_connect_rooms_safely.s1 + 0)
.s3:
;  81, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18a8 : 85 15 __ STA P8 
18aa : a5 18 __ LDA P11 ; (room2 + 0)
18ac : 85 16 __ STA P9 
18ae : 20 4b 19 JSR $194b ; (get_cached_room_distance.s0 + 0)
18b1 : a5 1b __ LDA ACCU + 0 
18b3 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
;  82, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18b6 : c9 1f __ CMP #$1f
18b8 : 90 05 __ BCC $18bf ; (can_connect_rooms_safely.s9 + 0)
.s1:
;  77, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18ba : a9 00 __ LDA #$00
18bc : 4c 48 19 JMP $1948 ; (can_connect_rooms_safely.s1001 + 0)
.s9:
;  87, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18bf : a5 17 __ LDA P10 ; (room1 + 0)
18c1 : 0a __ __ ASL
18c2 : 0a __ __ ASL
18c3 : 0a __ __ ASL
18c4 : aa __ __ TAX
18c5 : bd 00 44 LDA $4400,x ; (rooms + 0)
18c8 : 38 __ __ SEC
18c9 : e9 04 __ SBC #$04
18cb : 8d f3 9f STA $9ff3 ; (ix + 0)
;  88, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18ce : bd 01 44 LDA $4401,x ; (rooms + 1)
18d1 : 38 __ __ SEC
18d2 : e9 04 __ SBC #$04
18d4 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
;  89, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18d7 : bd 02 44 LDA $4402,x ; (rooms + 2)
18da : 18 __ __ CLC
18db : 7d 00 44 ADC $4400,x ; (rooms + 0)
18de : 18 __ __ CLC
18df : 69 04 __ ADC #$04
18e1 : 8d f1 9f STA $9ff1 ; (second_part + 0)
;  90, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18e4 : bd 03 44 LDA $4403,x ; (rooms + 3)
18e7 : 18 __ __ CLC
18e8 : 7d 01 44 ADC $4401,x ; (rooms + 1)
18eb : 18 __ __ CLC
18ec : 69 04 __ ADC #$04
18ee : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
;  91, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
18f1 : a5 18 __ LDA P11 ; (room2 + 0)
18f3 : 0a __ __ ASL
18f4 : 0a __ __ ASL
18f5 : 0a __ __ ASL
18f6 : aa __ __ TAX
18f7 : bd 00 44 LDA $4400,x ; (rooms + 0)
18fa : 38 __ __ SEC
18fb : e9 04 __ SBC #$04
18fd : 8d ef 9f STA $9fef ; (screen_pos + 1)
;  92, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1900 : bd 01 44 LDA $4401,x ; (rooms + 1)
1903 : 38 __ __ SEC
1904 : e9 04 __ SBC #$04
1906 : 8d ee 9f STA $9fee ; (entropy4 + 1)
;  93, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1909 : bd 02 44 LDA $4402,x ; (rooms + 2)
190c : 18 __ __ CLC
190d : 7d 00 44 ADC $4400,x ; (rooms + 0)
1910 : 18 __ __ CLC
1911 : 69 04 __ ADC #$04
1913 : 8d ed 9f STA $9fed ; (highest_priority + 0)
;  94, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1916 : bd 03 44 LDA $4403,x ; (rooms + 3)
1919 : 18 __ __ CLC
191a : 7d 01 44 ADC $4401,x ; (rooms + 1)
191d : 18 __ __ CLC
191e : 69 04 __ ADC #$04
1920 : 8d ec 9f STA $9fec ; (dy + 0)
;  97, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1923 : ad ef 9f LDA $9fef ; (screen_pos + 1)
1926 : cd f1 9f CMP $9ff1 ; (second_part + 0)
1929 : b0 1b __ BCS $1946 ; (can_connect_rooms_safely.s13 + 0)
.s16:
192b : ad f3 9f LDA $9ff3 ; (ix + 0)
192e : cd ed 9f CMP $9fed ; (highest_priority + 0)
1931 : b0 13 __ BCS $1946 ; (can_connect_rooms_safely.s13 + 0)
.s15:
;  98, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1933 : ad ee 9f LDA $9fee ; (entropy4 + 1)
1936 : cd f0 9f CMP $9ff0 ; (entropy3 + 1)
1939 : b0 0b __ BCS $1946 ; (can_connect_rooms_safely.s13 + 0)
.s14:
193b : ad f2 9f LDA $9ff2 ; (entropy2 + 1)
193e : cd ec 9f CMP $9fec ; (dy + 0)
1941 : a9 00 __ LDA #$00
1943 : 2a __ __ ROL
1944 : 90 02 __ BCC $1948 ; (can_connect_rooms_safely.s1001 + 0)
.s13:
; 102, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1946 : a9 01 __ LDA #$01
.s1001:
1948 : 85 1b __ STA ACCU + 0 
194a : 60 __ __ RTS
--------------------------------------------------------------------
get_cached_room_distance: ; get_cached_room_distance(u8,u8)->u8
.s0:
;  53, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
194b : ad 9f 36 LDA $369f ; (distance_cache_valid + 0)
194e : f0 0c __ BEQ $195c ; (get_cached_room_distance.s1006 + 0)
.s5:
1950 : a5 15 __ LDA P8 ; (room1 + 0)
1952 : c9 14 __ CMP #$14
1954 : b0 08 __ BCS $195e ; (get_cached_room_distance.s1 + 0)
.s4:
1956 : a5 16 __ LDA P9 ; (room2 + 0)
1958 : c9 14 __ CMP #$14
195a : 90 0e __ BCC $196a ; (get_cached_room_distance.s3 + 0)
.s1006:
;  54, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
195c : a5 15 __ LDA P8 ; (room1 + 0)
.s1:
195e : 85 13 __ STA P6 
1960 : a5 16 __ LDA P9 ; (room2 + 0)
1962 : 85 14 __ STA P7 
1964 : 20 d1 0c JSR $0cd1 ; (calculate_room_distance.s0 + 0)
.s1001:
1967 : 85 1b __ STA ACCU + 0 
1969 : 60 __ __ RTS
.s3:
;  57, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
196a : a5 15 __ LDA P8 ; (room1 + 0)
196c : 0a __ __ ASL
196d : 0a __ __ ASL
196e : 65 15 __ ADC P8 ; (room1 + 0)
1970 : 0a __ __ ASL
1971 : 0a __ __ ASL
1972 : a2 00 __ LDX #$00
1974 : 90 01 __ BCC $1977 ; (get_cached_room_distance.s1003 + 0)
.s1002:
1976 : e8 __ __ INX
.s1003:
1977 : 18 __ __ CLC
1978 : 69 58 __ ADC #$58
197a : 85 45 __ STA T0 + 0 
197c : 8a __ __ TXA
197d : 69 42 __ ADC #$42
197f : 85 46 __ STA T0 + 1 
1981 : a4 16 __ LDY P9 ; (room2 + 0)
1983 : b1 45 __ LDA (T0 + 0),y 
1985 : 8d f5 9f STA $9ff5 ; (s + 1)
;  58, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1988 : c9 ff __ CMP #$ff
198a : d0 db __ BNE $1967 ; (get_cached_room_distance.s1001 + 0)
.s9:
;  63, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
198c : 84 14 __ STY P7 
198e : a5 15 __ LDA P8 ; (room1 + 0)
1990 : 85 13 __ STA P6 
1992 : 20 d1 0c JSR $0cd1 ; (calculate_room_distance.s0 + 0)
;  64, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1995 : a4 16 __ LDY P9 ; (room2 + 0)
1997 : 91 45 __ STA (T0 + 0),y 
;  63, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1999 : 8d f5 9f STA $9ff5 ; (s + 1)
199c : aa __ __ TAX
;  65, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
199d : 98 __ __ TYA
199e : 0a __ __ ASL
199f : 0a __ __ ASL
19a0 : 65 16 __ ADC P9 ; (room2 + 0)
19a2 : 0a __ __ ASL
19a3 : 0a __ __ ASL
19a4 : a0 00 __ LDY #$00
19a6 : 90 01 __ BCC $19a9 ; (get_cached_room_distance.s1005 + 0)
.s1004:
19a8 : c8 __ __ INY
.s1005:
19a9 : 18 __ __ CLC
19aa : 69 58 __ ADC #$58
19ac : 85 45 __ STA T0 + 0 
19ae : 98 __ __ TYA
19af : 69 42 __ ADC #$42
19b1 : 85 46 __ STA T0 + 1 
19b3 : 8a __ __ TXA
19b4 : a4 15 __ LDY P8 ; (room1 + 0)
19b6 : 91 45 __ STA (T0 + 0),y 
;  67, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
19b8 : 4c 67 19 JMP $1967 ; (get_cached_room_distance.s1001 + 0)
--------------------------------------------------------------------
rule_based_connect_rooms: ; rule_based_connect_rooms(u8,u8)->u8
.s1000:
19bb : a5 53 __ LDA T5 + 0 
19bd : 8d 48 9f STA $9f48 ; (rule_based_connect_rooms@stack + 0)
19c0 : a5 54 __ LDA T5 + 1 
19c2 : 8d 49 9f STA $9f49 ; (rule_based_connect_rooms@stack + 1)
19c5 : a5 55 __ LDA T9 + 0 
19c7 : 8d 4a 9f STA $9f4a ; (rule_based_connect_rooms@stack + 2)
.s0:
; 496, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
19ca : ad fe 9f LDA $9ffe ; (sstack + 4)
19cd : 85 52 __ STA T8 + 0 
19cf : 85 17 __ STA P10 
19d1 : ad ff 9f LDA $9fff ; (sstack + 5)
19d4 : 85 55 __ STA T9 + 0 
19d6 : 85 18 __ STA P11 
19d8 : 20 94 18 JSR $1894 ; (can_connect_rooms_safely.s0 + 0)
19db : a5 1b __ LDA ACCU + 0 
19dd : d0 03 __ BNE $19e2 ; (rule_based_connect_rooms.s3 + 0)
19df : 4c 67 1a JMP $1a67 ; (rule_based_connect_rooms.s1001 + 0)
.s3:
; 501, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
19e2 : a5 52 __ LDA T8 + 0 
19e4 : 0a __ __ ASL
19e5 : 0a __ __ ASL
19e6 : 65 52 __ ADC T8 + 0 
19e8 : 0a __ __ ASL
19e9 : 0a __ __ ASL
19ea : a2 00 __ LDX #$00
19ec : 90 01 __ BCC $19ef ; (rule_based_connect_rooms.s1005 + 0)
.s1004:
19ee : e8 __ __ INX
.s1005:
19ef : 18 __ __ CLC
19f0 : 69 c8 __ ADC #$c8
19f2 : 85 53 __ STA T5 + 0 
19f4 : 8a __ __ TXA
19f5 : 69 40 __ ADC #$40
19f7 : 85 54 __ STA T5 + 1 
19f9 : a4 55 __ LDY T9 + 0 
19fb : b1 53 __ LDA (T5 + 0),y 
19fd : d0 66 __ BNE $1a65 ; (rule_based_connect_rooms.s5 + 0)
.s7:
; 509, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
19ff : 8d 51 9f STA $9f51 ; (i + 0)
; 508, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a02 : 8d 50 9f STA $9f50 ; (sp + 0)
.l10:
; 509, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a05 : a9 00 __ LDA #$00
1a07 : ae 51 9f LDX $9f51 ; (i + 0)
1a0a : 9d e8 43 STA $43e8,x ; (visited_global + 0)
1a0d : ee 51 9f INC $9f51 ; (i + 0)
1a10 : ad 51 9f LDA $9f51 ; (i + 0)
1a13 : c9 14 __ CMP #$14
1a15 : 90 ee __ BCC $1a05 ; (rule_based_connect_rooms.l10 + 0)
.s12:
; 510, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a17 : a9 01 __ LDA #$01
1a19 : 8d 50 9f STA $9f50 ; (sp + 0)
1a1c : a6 52 __ LDX T8 + 0 
1a1e : 8e c8 44 STX $44c8 ; (stack_global + 0)
; 511, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a21 : 9d e8 43 STA $43e8,x ; (visited_global + 0)
.l14:
; 514, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a24 : a9 00 __ LDA #$00
1a26 : 8d 51 9f STA $9f51 ; (i + 0)
; 513, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a29 : ae 50 9f LDX $9f50 ; (sp + 0)
1a2c : ce 50 9f DEC $9f50 ; (sp + 0)
1a2f : bd c7 44 LDA $44c7,x ; (room_center_cache + 39)
1a32 : 8d 4f 9f STA $9f4f ; (current + 0)
; 514, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a35 : ad 92 35 LDA $3592 ; (room_count + 0)
1a38 : f0 56 __ BEQ $1a90 ; (rule_based_connect_rooms.s13 + 0)
.s49:
; 515, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a3a : 85 49 __ STA T6 + 0 
1a3c : bd c7 44 LDA $44c7,x ; (room_center_cache + 39)
1a3f : 0a __ __ ASL
1a40 : 0a __ __ ASL
1a41 : 7d c7 44 ADC $44c7,x ; (room_center_cache + 39)
1a44 : 0a __ __ ASL
1a45 : 0a __ __ ASL
1a46 : a2 00 __ LDX #$00
1a48 : 90 01 __ BCC $1a4b ; (rule_based_connect_rooms.s1007 + 0)
.s1006:
1a4a : e8 __ __ INX
.s1007:
1a4b : 18 __ __ CLC
1a4c : 69 c8 __ ADC #$c8
1a4e : 85 43 __ STA T0 + 0 
1a50 : 8a __ __ TXA
1a51 : 69 40 __ ADC #$40
1a53 : 85 44 __ STA T0 + 1 
.l17:
1a55 : ac 51 9f LDY $9f51 ; (i + 0)
1a58 : b1 43 __ LDA (T0 + 0),y 
1a5a : f0 2c __ BEQ $1a88 ; (rule_based_connect_rooms.s16 + 0)
.s23:
1a5c : b9 e8 43 LDA $43e8,y ; (visited_global + 0)
1a5f : d0 27 __ BNE $1a88 ; (rule_based_connect_rooms.s16 + 0)
.s20:
; 516, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a61 : c4 55 __ CPY T9 + 0 
1a63 : d0 14 __ BNE $1a79 ; (rule_based_connect_rooms.s26 + 0)
.s5:
; 502, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a65 : a9 01 __ LDA #$01
.s1001:
; 497, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a67 : 85 1b __ STA ACCU + 0 
1a69 : ad 48 9f LDA $9f48 ; (rule_based_connect_rooms@stack + 0)
1a6c : 85 53 __ STA T5 + 0 
1a6e : ad 49 9f LDA $9f49 ; (rule_based_connect_rooms@stack + 1)
1a71 : 85 54 __ STA T5 + 1 
1a73 : ad 4a 9f LDA $9f4a ; (rule_based_connect_rooms@stack + 2)
1a76 : 85 55 __ STA T9 + 0 
1a78 : 60 __ __ RTS
.s26:
; 519, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a79 : a9 01 __ LDA #$01
1a7b : 99 e8 43 STA $43e8,y ; (visited_global + 0)
; 520, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a7e : ae 50 9f LDX $9f50 ; (sp + 0)
1a81 : ee 50 9f INC $9f50 ; (sp + 0)
1a84 : 98 __ __ TYA
1a85 : 9d c8 44 STA $44c8,x ; (stack_global + 0)
.s16:
; 514, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a88 : c8 __ __ INY
1a89 : 8c 51 9f STY $9f51 ; (i + 0)
1a8c : c4 49 __ CPY T6 + 0 
1a8e : 90 c5 __ BCC $1a55 ; (rule_based_connect_rooms.l17 + 0)
.s13:
; 512, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a90 : ad 50 9f LDA $9f50 ; (sp + 0)
1a93 : d0 8f __ BNE $1a24 ; (rule_based_connect_rooms.l14 + 0)
.s15:
; 526, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1a95 : a5 52 __ LDA T8 + 0 
1a97 : 85 13 __ STA P6 
1a99 : a5 55 __ LDA T9 + 0 
1a9b : 85 14 __ STA P7 
1a9d : 20 ea 1a JSR $1aea ; (can_reuse_existing_path.s0 + 0)
1aa0 : a5 1b __ LDA ACCU + 0 
1aa2 : f0 11 __ BEQ $1ab5 ; (rule_based_connect_rooms.s30 + 0)
.s28:
; 527, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1aa4 : a5 13 __ LDA P6 
1aa6 : 8d fc 9f STA $9ffc ; (sstack + 2)
1aa9 : a5 14 __ LDA P7 
1aab : 8d fd 9f STA $9ffd ; (sstack + 3)
1aae : 20 eb 1c JSR $1ceb ; (connect_via_existing_corridors.s0 + 0)
1ab1 : a5 1b __ LDA ACCU + 0 
1ab3 : d0 10 __ BNE $1ac5 ; (rule_based_connect_rooms.s31 + 0)
.s30:
; 534, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ab5 : a5 52 __ LDA T8 + 0 
1ab7 : 8d fc 9f STA $9ffc ; (sstack + 2)
1aba : a5 55 __ LDA T9 + 0 
1abc : 8d fd 9f STA $9ffd ; (sstack + 3)
1abf : 20 58 24 JSR $2458 ; (draw_rule_based_corridor.s0 + 0)
1ac2 : aa __ __ TAX
1ac3 : f0 a2 __ BEQ $1a67 ; (rule_based_connect_rooms.s1001 + 0)
.s31:
; 528, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ac5 : a9 01 __ LDA #$01
1ac7 : a4 55 __ LDY T9 + 0 
1ac9 : 91 53 __ STA (T5 + 0),y 
; 529, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1acb : 98 __ __ TYA
1acc : 0a __ __ ASL
1acd : 0a __ __ ASL
1ace : 65 55 __ ADC T9 + 0 
1ad0 : 0a __ __ ASL
1ad1 : 0a __ __ ASL
1ad2 : a2 00 __ LDX #$00
1ad4 : 90 01 __ BCC $1ad7 ; (rule_based_connect_rooms.s1009 + 0)
.s1008:
1ad6 : e8 __ __ INX
.s1009:
1ad7 : 18 __ __ CLC
1ad8 : 69 c8 __ ADC #$c8
1ada : 85 43 __ STA T0 + 0 
1adc : 8a __ __ TXA
1add : 69 40 __ ADC #$40
1adf : 85 44 __ STA T0 + 1 
1ae1 : a9 01 __ LDA #$01
1ae3 : a4 52 __ LDY T8 + 0 
1ae5 : 91 43 __ STA (T0 + 0),y 
; 530, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ae7 : 4c 67 1a JMP $1a67 ; (rule_based_connect_rooms.s1001 + 0)
--------------------------------------------------------------------
can_reuse_existing_path: ; can_reuse_existing_path(u8,u8)->u8
.s0:
; 292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1aea : a5 13 __ LDA P6 ; (room1 + 0)
1aec : 85 0d __ STA P0 
1aee : a9 f3 __ LDA #$f3
1af0 : 85 0e __ STA P1 
1af2 : a9 9f __ LDA #$9f
1af4 : 85 11 __ STA P4 
1af6 : a9 9f __ LDA #$9f
1af8 : 85 0f __ STA P2 
1afa : a9 f2 __ LDA #$f2
1afc : 85 10 __ STA P3 
1afe : 20 16 0d JSR $0d16 ; (get_room_center.s0 + 0)
; 293, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b01 : a5 14 __ LDA P7 ; (room2 + 0)
1b03 : 85 0d __ STA P0 
1b05 : a9 f1 __ LDA #$f1
1b07 : 85 0e __ STA P1 
1b09 : a9 9f __ LDA #$9f
1b0b : 85 11 __ STA P4 
1b0d : a9 9f __ LDA #$9f
1b0f : 85 0f __ STA P2 
1b11 : a9 f0 __ LDA #$f0
1b13 : 85 10 __ STA P3 
1b15 : 20 16 0d JSR $0d16 ; (get_room_center.s0 + 0)
; 297, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b18 : a9 00 __ LDA #$00
1b1a : 8d ef 9f STA $9fef ; (screen_pos + 1)
1b1d : 8d ee 9f STA $9fee ; (entropy4 + 1)
; 300, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b20 : a9 fc __ LDA #$fc
1b22 : 8d ed 9f STA $9fed ; (highest_priority + 0)
.l2:
; 301, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b25 : a9 fc __ LDA #$fc
1b27 : 8d ec 9f STA $9fec ; (dy + 0)
1b2a : ad ef 9f LDA $9fef ; (screen_pos + 1)
1b2d : d0 59 __ BNE $1b88 ; (can_reuse_existing_path.s3 + 0)
.l7:
; 302, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b2f : ad ed 9f LDA $9fed ; (highest_priority + 0)
1b32 : 18 __ __ CLC
1b33 : 6d f3 9f ADC $9ff3 ; (ix + 0)
1b36 : 85 46 __ STA T2 + 0 
1b38 : 85 0d __ STA P0 
1b3a : 8d eb 9f STA $9feb ; (screen_offset + 1)
; 303, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b3d : ad ec 9f LDA $9fec ; (dy + 0)
1b40 : 85 47 __ STA T3 + 0 
1b42 : 18 __ __ CLC
1b43 : 6d f2 9f ADC $9ff2 ; (entropy2 + 1)
1b46 : 85 45 __ STA T0 + 0 
1b48 : 85 0e __ STA P1 
1b4a : 8d ea 9f STA $9fea ; (check_y + 0)
; 305, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b4d : 20 30 1c JSR $1c30 ; (coords_in_bounds_fast.s0 + 0)
1b50 : aa __ __ TAX
1b51 : f0 22 __ BEQ $1b75 ; (can_reuse_existing_path.s6 + 0)
.s15:
; 306, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b53 : a5 0d __ LDA P0 
1b55 : 85 11 __ STA P4 
1b57 : a5 0e __ LDA P1 
1b59 : 85 12 __ STA P5 
1b5b : 20 43 1c JSR $1c43 ; (tile_is_floor_fast.s0 + 0)
1b5e : a5 1b __ LDA ACCU + 0 
1b60 : f0 13 __ BEQ $1b75 ; (can_reuse_existing_path.s6 + 0)
.s14:
; 307, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b62 : a5 46 __ LDA T2 + 0 
1b64 : 85 0f __ STA P2 
1b66 : a5 45 __ LDA T0 + 0 
1b68 : 85 10 __ STA P3 
1b6a : 20 87 1c JSR $1c87 ; (is_outside_any_room.s0 + 0)
1b6d : aa __ __ TAX
1b6e : f0 05 __ BEQ $1b75 ; (can_reuse_existing_path.s6 + 0)
.s11:
; 308, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b70 : a9 01 __ LDA #$01
1b72 : 8d ef 9f STA $9fef ; (screen_pos + 1)
.s6:
; 301, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b75 : 18 __ __ CLC
1b76 : a5 47 __ LDA T3 + 0 
1b78 : 69 01 __ ADC #$01
1b7a : 8d ec 9f STA $9fec ; (dy + 0)
1b7d : 30 04 __ BMI $1b83 ; (can_reuse_existing_path.s10 + 0)
.s1007:
1b7f : c9 05 __ CMP #$05
1b81 : b0 05 __ BCS $1b88 ; (can_reuse_existing_path.s3 + 0)
.s10:
; 301, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b83 : ad ef 9f LDA $9fef ; (screen_pos + 1)
1b86 : f0 a7 __ BEQ $1b2f ; (can_reuse_existing_path.l7 + 0)
.s3:
; 300, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b88 : ad ed 9f LDA $9fed ; (highest_priority + 0)
1b8b : ee ed 9f INC $9fed ; (highest_priority + 0)
1b8e : 49 80 __ EOR #$80
1b90 : c9 84 __ CMP #$84
1b92 : ad ef 9f LDA $9fef ; (screen_pos + 1)
1b95 : 90 03 __ BCC $1b9a ; (can_reuse_existing_path.s5 + 0)
1b97 : 4c 2b 1c JMP $1c2b ; (can_reuse_existing_path.s4 + 0)
.s5:
1b9a : f0 89 __ BEQ $1b25 ; (can_reuse_existing_path.l2 + 0)
.s18:
; 317, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1b9c : 85 47 __ STA T3 + 0 
1b9e : a9 fc __ LDA #$fc
1ba0 : 8d e9 9f STA $9fe9 ; (y + 0)
1ba3 : ad ee 9f LDA $9fee ; (entropy4 + 1)
1ba6 : d0 75 __ BNE $1c1d ; (can_reuse_existing_path.s23 + 0)
.l21:
; 318, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ba8 : a9 fc __ LDA #$fc
1baa : 8d e8 9f STA $9fe8 ; (room2_center_y + 0)
1bad : ad ee 9f LDA $9fee ; (entropy4 + 1)
1bb0 : d0 59 __ BNE $1c0b ; (can_reuse_existing_path.s22 + 0)
.l26:
; 319, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bb2 : ad e9 9f LDA $9fe9 ; (y + 0)
1bb5 : 18 __ __ CLC
1bb6 : 6d f1 9f ADC $9ff1 ; (second_part + 0)
1bb9 : 85 46 __ STA T2 + 0 
1bbb : 85 0d __ STA P0 
1bbd : 8d e7 9f STA $9fe7 ; (offset_range + 0)
; 320, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bc0 : ad e8 9f LDA $9fe8 ; (room2_center_y + 0)
1bc3 : 85 48 __ STA T4 + 0 
1bc5 : 18 __ __ CLC
1bc6 : 6d f0 9f ADC $9ff0 ; (entropy3 + 1)
1bc9 : 85 45 __ STA T0 + 0 
1bcb : 85 0e __ STA P1 
1bcd : 8d e6 9f STA $9fe6 ; (closest_corridor_y1 + 0)
; 322, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bd0 : 20 30 1c JSR $1c30 ; (coords_in_bounds_fast.s0 + 0)
1bd3 : aa __ __ TAX
1bd4 : f0 22 __ BEQ $1bf8 ; (can_reuse_existing_path.s25 + 0)
.s34:
; 323, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bd6 : a5 0d __ LDA P0 
1bd8 : 85 11 __ STA P4 
1bda : a5 0e __ LDA P1 
1bdc : 85 12 __ STA P5 
1bde : 20 43 1c JSR $1c43 ; (tile_is_floor_fast.s0 + 0)
1be1 : a5 1b __ LDA ACCU + 0 
1be3 : f0 13 __ BEQ $1bf8 ; (can_reuse_existing_path.s25 + 0)
.s33:
; 324, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1be5 : a5 46 __ LDA T2 + 0 
1be7 : 85 0f __ STA P2 
1be9 : a5 45 __ LDA T0 + 0 
1beb : 85 10 __ STA P3 
1bed : 20 87 1c JSR $1c87 ; (is_outside_any_room.s0 + 0)
1bf0 : aa __ __ TAX
1bf1 : f0 05 __ BEQ $1bf8 ; (can_reuse_existing_path.s25 + 0)
.s30:
; 325, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bf3 : a9 01 __ LDA #$01
1bf5 : 8d ee 9f STA $9fee ; (entropy4 + 1)
.s25:
; 318, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1bf8 : 18 __ __ CLC
1bf9 : a5 48 __ LDA T4 + 0 
1bfb : 69 01 __ ADC #$01
1bfd : 8d e8 9f STA $9fe8 ; (room2_center_y + 0)
1c00 : 30 04 __ BMI $1c06 ; (can_reuse_existing_path.s29 + 0)
.s1006:
1c02 : c9 05 __ CMP #$05
1c04 : b0 05 __ BCS $1c0b ; (can_reuse_existing_path.s22 + 0)
.s29:
; 318, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c06 : ad ee 9f LDA $9fee ; (entropy4 + 1)
1c09 : f0 a7 __ BEQ $1bb2 ; (can_reuse_existing_path.l26 + 0)
.s22:
; 317, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c0b : ad e9 9f LDA $9fe9 ; (y + 0)
1c0e : ee e9 9f INC $9fe9 ; (y + 0)
1c11 : aa __ __ TAX
1c12 : 30 04 __ BMI $1c18 ; (can_reuse_existing_path.s24 + 0)
.s1005:
1c14 : c9 04 __ CMP #$04
1c16 : b0 05 __ BCS $1c1d ; (can_reuse_existing_path.s23 + 0)
.s24:
; 317, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c18 : ad ee 9f LDA $9fee ; (entropy4 + 1)
1c1b : f0 8b __ BEQ $1ba8 ; (can_reuse_existing_path.l21 + 0)
.s23:
; 331, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c1d : a5 47 __ LDA T3 + 0 
1c1f : f0 07 __ BEQ $1c28 ; (can_reuse_existing_path.s1001 + 0)
.s38:
1c21 : ad ee 9f LDA $9fee ; (entropy4 + 1)
1c24 : f0 02 __ BEQ $1c28 ; (can_reuse_existing_path.s1001 + 0)
.s35:
1c26 : a9 01 __ LDA #$01
.s1001:
; 314, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1c28 : 85 1b __ STA ACCU + 0 
1c2a : 60 __ __ RTS
.s4:
1c2b : f0 fb __ BEQ $1c28 ; (can_reuse_existing_path.s1001 + 0)
1c2d : 4c 9c 1b JMP $1b9c ; (can_reuse_existing_path.s18 + 0)
--------------------------------------------------------------------
coords_in_bounds_fast: ; coords_in_bounds_fast(u8,u8)->u8
.s0:
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utility.h"
1c30 : a5 0d __ LDA P0 ; (x + 0)
1c32 : c9 40 __ CMP #$40
1c34 : b0 0a __ BCS $1c40 ; (coords_in_bounds_fast.s2 + 0)
.s4:
1c36 : a5 0e __ LDA P1 ; (y + 0)
1c38 : c9 40 __ CMP #$40
1c3a : a9 00 __ LDA #$00
1c3c : 2a __ __ ROL
1c3d : 49 01 __ EOR #$01
1c3f : 60 __ __ RTS
.s2:
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utility.h"
1c40 : a9 00 __ LDA #$00
.s1001:
1c42 : 60 __ __ RTS
--------------------------------------------------------------------
tile_is_floor_fast: ; tile_is_floor_fast(u8,u8)->u8
.s0:
;  37, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utility.h"
1c43 : a5 11 __ LDA P4 ; (x + 0)
1c45 : 85 0d __ STA P0 
1c47 : a5 12 __ LDA P5 ; (y + 0)
1c49 : 85 0e __ STA P1 
1c4b : 20 30 1c JSR $1c30 ; (coords_in_bounds_fast.s0 + 0)
1c4e : aa __ __ TAX
1c4f : f0 17 __ BEQ $1c68 ; (tile_is_floor_fast.s1001 + 0)
.s3:
;  38, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utility.h"
1c51 : a5 11 __ LDA P4 ; (x + 0)
1c53 : 85 0f __ STA P2 
1c55 : a5 12 __ LDA P5 ; (y + 0)
1c57 : 85 10 __ STA P3 
1c59 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
1c5c : a5 1b __ LDA ACCU + 0 
1c5e : c9 02 __ CMP #$02
1c60 : d0 04 __ BNE $1c66 ; (tile_is_floor_fast.s1003 + 0)
.s1002:
1c62 : a9 01 __ LDA #$01
1c64 : d0 02 __ BNE $1c68 ; (tile_is_floor_fast.s1001 + 0)
.s1003:
1c66 : a9 00 __ LDA #$00
.s1001:
;  37, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utility.h"
1c68 : 85 1b __ STA ACCU + 0 
1c6a : 60 __ __ RTS
--------------------------------------------------------------------
get_tile_raw: ; get_tile_raw(u8,u8)->u8
.s0:
; 291, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1c6b : a5 0f __ LDA P2 ; (x + 0)
1c6d : c9 40 __ CMP #$40
1c6f : b0 06 __ BCS $1c77 ; (get_tile_raw.s1 + 0)
.s4:
1c71 : a5 10 __ LDA P3 ; (y + 0)
1c73 : c9 40 __ CMP #$40
1c75 : 90 04 __ BCC $1c7b ; (get_tile_raw.s3 + 0)
.s1:
1c77 : a9 00 __ LDA #$00
1c79 : b0 09 __ BCS $1c84 ; (get_tile_raw.s1001 + 0)
.s3:
; 292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
1c7b : 85 0e __ STA P1 
1c7d : a5 0f __ LDA P2 ; (x + 0)
1c7f : 85 0d __ STA P0 
1c81 : 20 f9 14 JSR $14f9 ; (get_tile_core.s0 + 0)
.s1001:
1c84 : 85 1b __ STA ACCU + 0 
1c86 : 60 __ __ RTS
--------------------------------------------------------------------
is_outside_any_room: ; is_outside_any_room(u8,u8)->u8
.s0:
; 143, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1c87 : a5 0f __ LDA P2 ; (x + 0)
1c89 : 85 0d __ STA P0 
1c8b : a5 10 __ LDA P3 ; (y + 0)
1c8d : 85 0e __ STA P1 
1c8f : 20 9b 1c JSR $1c9b ; (is_inside_room.s0 + 0)
1c92 : c9 01 __ CMP #$01
1c94 : a9 00 __ LDA #$00
1c96 : 69 ff __ ADC #$ff
1c98 : 29 01 __ AND #$01
.s1001:
1c9a : 60 __ __ RTS
--------------------------------------------------------------------
is_inside_room: ; is_inside_room(u8,u8)->u8
.s0:
; 132, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1c9b : a9 00 __ LDA #$00
1c9d : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
1ca0 : ad 92 35 LDA $3592 ; (room_count + 0)
1ca3 : f0 40 __ BEQ $1ce5 ; (is_inside_room.s4 + 0)
.s1008:
1ca5 : 85 1c __ STA ACCU + 1 
1ca7 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
1caa : a4 0d __ LDY P0 ; (x + 0)
.l2:
; 133, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1cac : 0a __ __ ASL
1cad : 0a __ __ ASL
1cae : 0a __ __ ASL
1caf : aa __ __ TAX
1cb0 : 98 __ __ TYA
1cb1 : dd 00 44 CMP $4400,x ; (rooms + 0)
1cb4 : 90 25 __ BCC $1cdb ; (is_inside_room.s3 + 0)
.s10:
1cb6 : bd 02 44 LDA $4402,x ; (rooms + 2)
1cb9 : 18 __ __ CLC
1cba : 7d 00 44 ADC $4400,x ; (rooms + 0)
1cbd : b0 06 __ BCS $1cc5 ; (is_inside_room.s9 + 0)
.s1005:
1cbf : 85 1b __ STA ACCU + 0 
1cc1 : c4 1b __ CPY ACCU + 0 
1cc3 : b0 16 __ BCS $1cdb ; (is_inside_room.s3 + 0)
.s9:
; 134, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1cc5 : a5 0e __ LDA P1 ; (y + 0)
1cc7 : dd 01 44 CMP $4401,x ; (rooms + 1)
1cca : 90 0f __ BCC $1cdb ; (is_inside_room.s3 + 0)
.s8:
1ccc : bd 03 44 LDA $4403,x ; (rooms + 3)
1ccf : 18 __ __ CLC
1cd0 : 7d 01 44 ADC $4401,x ; (rooms + 1)
1cd3 : b0 13 __ BCS $1ce8 ; (is_inside_room.s5 + 0)
.s1002:
1cd5 : c5 0e __ CMP P1 ; (y + 0)
1cd7 : 90 02 __ BCC $1cdb ; (is_inside_room.s3 + 0)
.s1011:
1cd9 : d0 0d __ BNE $1ce8 ; (is_inside_room.s5 + 0)
.s3:
; 132, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1cdb : ee f9 9f INC $9ff9 ; (bit_offset + 1)
1cde : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
1ce1 : c5 1c __ CMP ACCU + 1 
1ce3 : 90 c7 __ BCC $1cac ; (is_inside_room.l2 + 0)
.s4:
; 138, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1ce5 : a9 00 __ LDA #$00
.s1001:
1ce7 : 60 __ __ RTS
.s5:
1ce8 : a9 01 __ LDA #$01
1cea : 60 __ __ RTS
--------------------------------------------------------------------
connect_via_existing_corridors: ; connect_via_existing_corridors(u8,u8)->u8
.s0:
; 340, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ceb : ad fc 9f LDA $9ffc ; (sstack + 2)
1cee : 85 48 __ STA T1 + 0 
1cf0 : 85 0d __ STA P0 
1cf2 : a9 eb __ LDA #$eb
1cf4 : 85 0e __ STA P1 
1cf6 : a9 9f __ LDA #$9f
1cf8 : 85 11 __ STA P4 
1cfa : a9 9f __ LDA #$9f
1cfc : 85 0f __ STA P2 
1cfe : a9 ea __ LDA #$ea
1d00 : 85 10 __ STA P3 
1d02 : 20 16 0d JSR $0d16 ; (get_room_center.s0 + 0)
; 341, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1d05 : ad fd 9f LDA $9ffd ; (sstack + 3)
1d08 : 85 49 __ STA T2 + 0 
1d0a : 85 0d __ STA P0 
1d0c : a9 e9 __ LDA #$e9
1d0e : 85 0e __ STA P1 
1d10 : a9 9f __ LDA #$9f
1d12 : 85 11 __ STA P4 
1d14 : a9 9f __ LDA #$9f
1d16 : 85 0f __ STA P2 
1d18 : a9 e8 __ LDA #$e8
1d1a : 85 10 __ STA P3 
1d1c : 20 16 0d JSR $0d16 ; (get_room_center.s0 + 0)
; 342, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1d1f : a5 48 __ LDA T1 + 0 
1d21 : 0a __ __ ASL
1d22 : 0a __ __ ASL
1d23 : 0a __ __ ASL
1d24 : 85 4b __ STA T4 + 0 
1d26 : 18 __ __ CLC
1d27 : 69 00 __ ADC #$00
1d29 : 85 12 __ STA P5 
1d2b : a9 44 __ LDA #$44
1d2d : 69 00 __ ADC #$00
1d2f : 85 13 __ STA P6 
1d31 : ad e9 9f LDA $9fe9 ; (y + 0)
1d34 : 85 14 __ STA P7 
1d36 : ad e8 9f LDA $9fe8 ; (room2_center_y + 0)
1d39 : 85 15 __ STA P8 
1d3b : a9 ef __ LDA #$ef
1d3d : 85 16 __ STA P9 
1d3f : a9 ee __ LDA #$ee
1d41 : 8d fa 9f STA $9ffa ; (sstack + 0)
1d44 : a9 9f __ LDA #$9f
1d46 : 85 17 __ STA P10 
1d48 : a9 9f __ LDA #$9f
1d4a : 8d fb 9f STA $9ffb ; (sstack + 1)
1d4d : 20 d5 21 JSR $21d5 ; (find_room_exit.s0 + 0)
; 344, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1d50 : a5 49 __ LDA T2 + 0 
1d52 : 0a __ __ ASL
1d53 : 0a __ __ ASL
1d54 : 0a __ __ ASL
1d55 : 85 4c __ STA T5 + 0 
1d57 : 18 __ __ CLC
1d58 : 69 00 __ ADC #$00
1d5a : 85 12 __ STA P5 
1d5c : a9 44 __ LDA #$44
1d5e : 69 00 __ ADC #$00
1d60 : 85 13 __ STA P6 
1d62 : ad eb 9f LDA $9feb ; (screen_offset + 1)
1d65 : 85 14 __ STA P7 
1d67 : ad ea 9f LDA $9fea ; (check_y + 0)
1d6a : 85 15 __ STA P8 
1d6c : a9 ed __ LDA #$ed
1d6e : 85 16 __ STA P9 
1d70 : a9 ec __ LDA #$ec
1d72 : 8d fa 9f STA $9ffa ; (sstack + 0)
1d75 : a9 9f __ LDA #$9f
1d77 : 85 17 __ STA P10 
1d79 : a9 9f __ LDA #$9f
1d7b : 8d fb 9f STA $9ffb ; (sstack + 1)
1d7e : 20 d5 21 JSR $21d5 ; (find_room_exit.s0 + 0)
; 347, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1d81 : a9 ff __ LDA #$ff
1d83 : 8d e7 9f STA $9fe7 ; (offset_range + 0)
1d86 : 8d e6 9f STA $9fe6 ; (closest_corridor_y1 + 0)
; 348, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1d89 : 8d e5 9f STA $9fe5 ; (tile + 0)
1d8c : 8d e4 9f STA $9fe4 ; (y + 0)
; 349, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1d8f : 8d e3 9f STA $9fe3 ; (door1_x + 0)
1d92 : 8d e2 9f STA $9fe2 ; (min_dist2 + 0)
; 354, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1d95 : a9 0a __ LDA #$0a
1d97 : cd eb 9f CMP $9feb ; (screen_offset + 1)
1d9a : 90 04 __ BCC $1da0 ; (connect_via_existing_corridors.s1 + 0)
.s2:
1d9c : a9 00 __ LDA #$00
1d9e : b0 05 __ BCS $1da5 ; (connect_via_existing_corridors.s238 + 0)
.s1:
; 354, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1da0 : ad eb 9f LDA $9feb ; (screen_offset + 1)
1da3 : e9 09 __ SBC #$09
.s238:
1da5 : 8d e1 9f STA $9fe1 ; (search_x1 + 0)
; 355, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1da8 : a9 0a __ LDA #$0a
1daa : cd ea 9f CMP $9fea ; (check_y + 0)
1dad : 90 04 __ BCC $1db3 ; (connect_via_existing_corridors.s4 + 0)
.s5:
1daf : a9 00 __ LDA #$00
1db1 : b0 05 __ BCS $1db8 ; (connect_via_existing_corridors.s239 + 0)
.s4:
; 355, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1db3 : ad ea 9f LDA $9fea ; (check_y + 0)
1db6 : e9 09 __ SBC #$09
.s239:
1db8 : 8d e0 9f STA $9fe0 ; (grid_positions + 15)
; 356, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1dbb : ad eb 9f LDA $9feb ; (screen_offset + 1)
1dbe : c9 36 __ CMP #$36
1dc0 : 90 04 __ BCC $1dc6 ; (connect_via_existing_corridors.s7 + 0)
.s8:
1dc2 : a9 3f __ LDA #$3f
1dc4 : b0 02 __ BCS $1dc8 ; (connect_via_existing_corridors.s240 + 0)
.s7:
; 356, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1dc6 : 69 0a __ ADC #$0a
.s240:
1dc8 : 8d df 9f STA $9fdf ; (grid_positions + 14)
; 357, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1dcb : ad ea 9f LDA $9fea ; (check_y + 0)
1dce : c9 36 __ CMP #$36
1dd0 : 90 04 __ BCC $1dd6 ; (connect_via_existing_corridors.s10 + 0)
.s11:
1dd2 : a9 3f __ LDA #$3f
1dd4 : b0 02 __ BCS $1dd8 ; (connect_via_existing_corridors.s136 + 0)
.s10:
; 357, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1dd6 : 69 0a __ ADC #$0a
.s136:
1dd8 : 8d de 9f STA $9fde ; (grid_positions + 13)
; 359, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ddb : ae e0 9f LDX $9fe0 ; (grid_positions + 15)
1dde : 8e dd 9f STX $9fdd ; (grid_positions + 12)
1de1 : cd e0 9f CMP $9fe0 ; (grid_positions + 15)
1de4 : b0 03 __ BCS $1de9 ; (connect_via_existing_corridors.s172 + 0)
1de6 : 4c ac 1e JMP $1eac ; (connect_via_existing_corridors.s16 + 0)
.s172:
; 360, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1de9 : 85 4d __ STA T6 + 0 
1deb : ad e1 9f LDA $9fe1 ; (search_x1 + 0)
1dee : 85 4e __ STA T7 + 0 
1df0 : ad df 9f LDA $9fdf ; (grid_positions + 14)
1df3 : 85 4f __ STA T8 + 0 
1df5 : c5 4e __ CMP T7 + 0 
1df7 : a9 00 __ LDA #$00
1df9 : 2a __ __ ROL
1dfa : 85 50 __ STA T9 + 0 
.l14:
1dfc : a5 4e __ LDA T7 + 0 
1dfe : 8d dc 9f STA $9fdc ; (grid_positions + 11)
1e01 : a5 50 __ LDA T9 + 0 
1e03 : d0 03 __ BNE $1e08 ; (connect_via_existing_corridors.s171 + 0)
1e05 : 4c 9f 1e JMP $1e9f ; (connect_via_existing_corridors.s15 + 0)
.s171:
; 361, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e08 : ad dd 9f LDA $9fdd ; (grid_positions + 12)
1e0b : 85 10 __ STA P3 
.l18:
1e0d : ad dc 9f LDA $9fdc ; (grid_positions + 11)
1e10 : 85 51 __ STA T11 + 0 
1e12 : 85 0f __ STA P2 
1e14 : 20 7b 22 JSR $227b ; (tile_is_floor.s0 + 0)
1e17 : a5 1b __ LDA ACCU + 0 ; (room1 + 0)
1e19 : f0 74 __ BEQ $1e8f ; (connect_via_existing_corridors.s17 + 0)
.s24:
1e1b : 20 87 1c JSR $1c87 ; (is_outside_any_room.s0 + 0)
1e1e : aa __ __ TAX
1e1f : f0 6e __ BEQ $1e8f ; (connect_via_existing_corridors.s17 + 0)
.s21:
; 363, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e21 : a5 51 __ LDA T11 + 0 
1e23 : 85 0d __ STA P0 
1e25 : ad ef 9f LDA $9fef ; (screen_pos + 1)
1e28 : 85 0e __ STA P1 
1e2a : 20 ad 0d JSR $0dad ; (fast_abs_diff.s0 + 0)
1e2d : 85 49 __ STA T2 + 0 
1e2f : a5 10 __ LDA P3 
1e31 : 85 0d __ STA P0 
1e33 : ad ee 9f LDA $9fee ; (entropy4 + 1)
1e36 : 85 0e __ STA P1 
1e38 : 20 ad 0d JSR $0dad ; (fast_abs_diff.s0 + 0)
1e3b : 18 __ __ CLC
1e3c : 65 49 __ ADC T2 + 0 
1e3e : 85 48 __ STA T1 + 0 
1e40 : 8d db 9f STA $9fdb ; (grid_positions + 10)
; 364, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e43 : a5 51 __ LDA T11 + 0 
1e45 : 85 0d __ STA P0 
1e47 : ad ed 9f LDA $9fed ; (highest_priority + 0)
1e4a : 85 0e __ STA P1 
1e4c : 20 ad 0d JSR $0dad ; (fast_abs_diff.s0 + 0)
1e4f : 85 43 __ STA T0 + 0 
1e51 : a5 10 __ LDA P3 
1e53 : 85 0d __ STA P0 
1e55 : ad ec 9f LDA $9fec ; (dy + 0)
1e58 : 85 0e __ STA P1 
1e5a : 20 ad 0d JSR $0dad ; (fast_abs_diff.s0 + 0)
1e5d : 18 __ __ CLC
1e5e : 65 43 __ ADC T0 + 0 
1e60 : 8d da 9f STA $9fda ; (grid_positions + 9)
; 366, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e63 : a5 48 __ LDA T1 + 0 
1e65 : cd e3 9f CMP $9fe3 ; (door1_x + 0)
1e68 : b0 0d __ BCS $1e77 ; (connect_via_existing_corridors.s27 + 0)
.s25:
; 367, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e6a : 8d e3 9f STA $9fe3 ; (door1_x + 0)
; 368, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e6d : a5 51 __ LDA T11 + 0 
1e6f : 8d e7 9f STA $9fe7 ; (offset_range + 0)
; 369, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e72 : a5 10 __ LDA P3 
1e74 : 8d e6 9f STA $9fe6 ; (closest_corridor_y1 + 0)
.s27:
; 371, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e77 : ad da 9f LDA $9fda ; (grid_positions + 9)
1e7a : cd e2 9f CMP $9fe2 ; (min_dist2 + 0)
1e7d : b0 10 __ BCS $1e8f ; (connect_via_existing_corridors.s17 + 0)
.s28:
; 373, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e7f : a5 51 __ LDA T11 + 0 
1e81 : 8d e5 9f STA $9fe5 ; (tile + 0)
; 374, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e84 : a5 10 __ LDA P3 
1e86 : 8d e4 9f STA $9fe4 ; (y + 0)
; 372, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e89 : ad da 9f LDA $9fda ; (grid_positions + 9)
1e8c : 8d e2 9f STA $9fe2 ; (min_dist2 + 0)
.s17:
; 360, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e8f : a6 51 __ LDX T11 + 0 
1e91 : e8 __ __ INX
1e92 : 8e dc 9f STX $9fdc ; (grid_positions + 11)
1e95 : a5 4f __ LDA T8 + 0 
1e97 : cd dc 9f CMP $9fdc ; (grid_positions + 11)
1e9a : 90 03 __ BCC $1e9f ; (connect_via_existing_corridors.s15 + 0)
1e9c : 4c 0d 1e JMP $1e0d ; (connect_via_existing_corridors.l18 + 0)
.s15:
; 359, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1e9f : ee dd 9f INC $9fdd ; (grid_positions + 12)
1ea2 : a5 4d __ LDA T6 + 0 
1ea4 : cd dd 9f CMP $9fdd ; (grid_positions + 12)
1ea7 : 90 03 __ BCC $1eac ; (connect_via_existing_corridors.s16 + 0)
1ea9 : 4c fc 1d JMP $1dfc ; (connect_via_existing_corridors.l14 + 0)
.s16:
; 381, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1eac : ad e7 9f LDA $9fe7 ; (offset_range + 0)
1eaf : c9 ff __ CMP #$ff
1eb1 : f0 17 __ BEQ $1eca ; (connect_via_existing_corridors.s33 + 0)
.s36:
1eb3 : 85 4d __ STA T6 + 0 
1eb5 : ad e5 9f LDA $9fe5 ; (tile + 0)
1eb8 : c9 ff __ CMP #$ff
1eba : f0 0e __ BEQ $1eca ; (connect_via_existing_corridors.s33 + 0)
.s35:
1ebc : 85 4e __ STA T7 + 0 
1ebe : a9 08 __ LDA #$08
1ec0 : cd e3 9f CMP $9fe3 ; (door1_x + 0)
1ec3 : 90 05 __ BCC $1eca ; (connect_via_existing_corridors.s33 + 0)
.s34:
1ec5 : cd e2 9f CMP $9fe2 ; (min_dist2 + 0)
1ec8 : b0 05 __ BCS $1ecf ; (connect_via_existing_corridors.s31 + 0)
.s33:
; 486, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1eca : a9 00 __ LDA #$00
1ecc : 4c b4 21 JMP $21b4 ; (connect_via_existing_corridors.s1001 + 0)
.s31:
; 388, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ecf : a9 00 __ LDA #$00
1ed1 : 8d c5 9f STA $9fc5 ; (path1 + 40)
; 389, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ed4 : 8d 9c 9f STA $9f9c ; (dx1 + 0)
1ed7 : 8d 9b 9f STA $9f9b ; (dy1 + 0)
; 390, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1eda : a4 4b __ LDY T4 + 0 
1edc : b9 00 44 LDA $4400,y ; (rooms + 0)
1edf : e9 01 __ SBC #$01
1ee1 : 90 11 __ BCC $1ef4 ; (connect_via_existing_corridors.s38 + 0)
.s1029:
1ee3 : cd ef 9f CMP $9fef ; (screen_pos + 1)
1ee6 : d0 0c __ BNE $1ef4 ; (connect_via_existing_corridors.s38 + 0)
.s37:
1ee8 : a9 ff __ LDA #$ff
.s286:
; 391, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1eea : 8d 9c 9f STA $9f9c ; (dx1 + 0)
1eed : a9 00 __ LDA #$00
1eef : 8d 9b 9f STA $9f9b ; (dy1 + 0)
1ef2 : f0 3d __ BEQ $1f31 ; (connect_via_existing_corridors.s39 + 0)
.s38:
; 391, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ef4 : b9 02 44 LDA $4402,y ; (rooms + 2)
1ef7 : 18 __ __ CLC
1ef8 : 79 00 44 ADC $4400,y ; (rooms + 0)
1efb : b0 09 __ BCS $1f06 ; (connect_via_existing_corridors.s41 + 0)
.s1026:
1efd : cd ef 9f CMP $9fef ; (screen_pos + 1)
1f00 : d0 04 __ BNE $1f06 ; (connect_via_existing_corridors.s41 + 0)
.s40:
1f02 : a9 01 __ LDA #$01
1f04 : d0 e4 __ BNE $1eea ; (connect_via_existing_corridors.s286 + 0)
.s41:
; 392, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f06 : b9 01 44 LDA $4401,y ; (rooms + 1)
1f09 : 38 __ __ SEC
1f0a : e9 01 __ SBC #$01
1f0c : 90 11 __ BCC $1f1f ; (connect_via_existing_corridors.s44 + 0)
.s1023:
1f0e : cd ee 9f CMP $9fee ; (entropy4 + 1)
1f11 : d0 0c __ BNE $1f1f ; (connect_via_existing_corridors.s44 + 0)
.s43:
1f13 : a9 ff __ LDA #$ff
.s341:
; 393, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f15 : 8d 9b 9f STA $9f9b ; (dy1 + 0)
1f18 : a9 00 __ LDA #$00
1f1a : 8d 9c 9f STA $9f9c ; (dx1 + 0)
1f1d : f0 12 __ BEQ $1f31 ; (connect_via_existing_corridors.s39 + 0)
.s44:
; 393, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f1f : b9 03 44 LDA $4403,y ; (rooms + 3)
1f22 : 18 __ __ CLC
1f23 : 79 01 44 ADC $4401,y ; (rooms + 1)
1f26 : b0 09 __ BCS $1f31 ; (connect_via_existing_corridors.s39 + 0)
.s1020:
1f28 : cd ee 9f CMP $9fee ; (entropy4 + 1)
1f2b : d0 04 __ BNE $1f31 ; (connect_via_existing_corridors.s39 + 0)
.s46:
1f2d : a9 01 __ LDA #$01
1f2f : d0 e4 __ BNE $1f15 ; (connect_via_existing_corridors.s341 + 0)
.s39:
; 394, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f31 : ad 9c 9f LDA $9f9c ; (dx1 + 0)
1f34 : 18 __ __ CLC
1f35 : 6d ef 9f ADC $9fef ; (screen_pos + 1)
1f38 : 85 49 __ STA T2 + 0 
1f3a : 85 0d __ STA P0 
1f3c : 8d 9a 9f STA $9f9a ; (corridor1_x + 0)
; 396, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f3f : a9 01 __ LDA #$01
1f41 : 8d a0 36 STA $36a0 ; (corridor_endpoint_override + 0)
; 395, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f44 : ad 9b 9f LDA $9f9b ; (dy1 + 0)
1f47 : 18 __ __ CLC
1f48 : 6d ee 9f ADC $9fee ; (entropy4 + 1)
1f4b : 85 48 __ STA T1 + 0 
1f4d : 85 0e __ STA P1 
1f4f : 8d 99 9f STA $9f99 ; (corridor1_y + 0)
; 397, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f52 : 20 c2 14 JSR $14c2 ; (coords_in_bounds.s0 + 0)
1f55 : aa __ __ TAX
1f56 : f0 2d __ BEQ $1f85 ; (connect_via_existing_corridors.s51 + 0)
.s52:
1f58 : a5 0d __ LDA P0 
1f5a : 85 13 __ STA P6 
1f5c : a5 0e __ LDA P1 
1f5e : 85 14 __ STA P7 
1f60 : 20 9d 22 JSR $229d ; (can_place_corridor_tile.s0 + 0)
1f63 : aa __ __ TAX
1f64 : f0 1f __ BEQ $1f85 ; (connect_via_existing_corridors.s51 + 0)
.s49:
; 398, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f66 : a5 49 __ LDA T2 + 0 
1f68 : 85 10 __ STA P3 
1f6a : a5 48 __ LDA T1 + 0 
1f6c : 85 11 __ STA P4 
1f6e : a9 02 __ LDA #$02
1f70 : 85 12 __ STA P5 
1f72 : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
; 399, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f75 : a5 10 __ LDA P3 
1f77 : 8d 9d 9f STA $9f9d ; (path1 + 0)
; 400, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f7a : a5 11 __ LDA P4 
1f7c : ae c5 9f LDX $9fc5 ; (path1 + 40)
1f7f : 9d b1 9f STA $9fb1,x ; (path1 + 20)
; 401, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f82 : ee c5 9f INC $9fc5 ; (path1 + 40)
.s51:
; 404, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f85 : a5 49 __ LDA T2 + 0 
1f87 : 8d 98 9f STA $9f98 ; (current1_x + 0)
; 405, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f8a : a5 48 __ LDA T1 + 0 
1f8c : 8d 97 9f STA $9f97 ; (current1_y + 0)
; 406, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f8f : a9 40 __ LDA #$40
1f91 : 8d 96 9f STA $9f96 ; (step_limit1 + 0)
; 403, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f94 : a9 00 __ LDA #$00
1f96 : 8d a0 36 STA $36a0 ; (corridor_endpoint_override + 0)
.l53:
; 407, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1f99 : ac 98 9f LDY $9f98 ; (current1_x + 0)
1f9c : c4 4d __ CPY T6 + 0 
1f9e : f0 04 __ BEQ $1fa4 ; (connect_via_existing_corridors.s1003 + 0)
.s1002:
1fa0 : a2 01 __ LDX #$01
1fa2 : d0 0a __ BNE $1fae ; (connect_via_existing_corridors.s56 + 0)
.s1003:
1fa4 : ad 97 9f LDA $9f97 ; (current1_y + 0)
1fa7 : a2 00 __ LDX #$00
1fa9 : cd e6 9f CMP $9fe6 ; (closest_corridor_y1 + 0)
1fac : f0 6b __ BEQ $2019 ; (connect_via_existing_corridors.s55 + 0)
.s56:
1fae : ad 96 9f LDA $9f96 ; (step_limit1 + 0)
1fb1 : ce 96 9f DEC $9f96 ; (step_limit1 + 0)
1fb4 : 09 00 __ ORA #$00
1fb6 : f0 61 __ BEQ $2019 ; (connect_via_existing_corridors.s55 + 0)
.s54:
; 409, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fb8 : 8a __ __ TXA
1fb9 : f0 03 __ BEQ $1fbe ; (connect_via_existing_corridors.s59 + 0)
1fbb : 4c c6 21 JMP $21c6 ; (connect_via_existing_corridors.s58 + 0)
.s59:
; 412, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fbe : ac 97 9f LDY $9f97 ; (current1_y + 0)
1fc1 : cc e6 9f CPY $9fe6 ; (closest_corridor_y1 + 0)
1fc4 : f0 53 __ BEQ $2019 ; (connect_via_existing_corridors.s55 + 0)
.s64:
; 413, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fc6 : b0 03 __ BCS $1fcb ; (connect_via_existing_corridors.s68 + 0)
.s67:
1fc8 : c8 __ __ INY
1fc9 : 90 01 __ BCC $1fcc ; (connect_via_existing_corridors.s288 + 0)
.s68:
; 414, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fcb : 88 __ __ DEY
.s288:
1fcc : 8c 97 9f STY $9f97 ; (current1_y + 0)
; 418, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1fcf : ad 98 9f LDA $9f98 ; (current1_x + 0)
.s60:
1fd2 : 85 49 __ STA T2 + 0 
1fd4 : 85 0f __ STA P2 
1fd6 : ad 97 9f LDA $9f97 ; (current1_y + 0)
1fd9 : 85 4a __ STA T3 + 0 
1fdb : 85 10 __ STA P3 
1fdd : 20 87 1c JSR $1c87 ; (is_outside_any_room.s0 + 0)
1fe0 : aa __ __ TAX
1fe1 : f0 b6 __ BEQ $1f99 ; (connect_via_existing_corridors.l53 + 0)
.s74:
1fe3 : a5 0f __ LDA P2 
1fe5 : 85 13 __ STA P6 
1fe7 : a5 4a __ LDA T3 + 0 
1fe9 : 85 14 __ STA P7 
1feb : 20 9d 22 JSR $229d ; (can_place_corridor_tile.s0 + 0)
1fee : aa __ __ TAX
1fef : f0 a8 __ BEQ $1f99 ; (connect_via_existing_corridors.l53 + 0)
.s71:
; 419, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
1ff1 : a5 49 __ LDA T2 + 0 
1ff3 : 85 10 __ STA P3 
1ff5 : a5 4a __ LDA T3 + 0 
1ff7 : 85 11 __ STA P4 
1ff9 : a9 02 __ LDA #$02
1ffb : 85 12 __ STA P5 
1ffd : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
; 420, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2000 : ae c5 9f LDX $9fc5 ; (path1 + 40)
2003 : e0 14 __ CPX #$14
2005 : b0 92 __ BCS $1f99 ; (connect_via_existing_corridors.l53 + 0)
.s75:
; 421, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2007 : a5 10 __ LDA P3 
2009 : 9d 9d 9f STA $9f9d,x ; (path1 + 0)
; 422, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
200c : a5 4a __ LDA T3 + 0 
200e : ae c5 9f LDX $9fc5 ; (path1 + 40)
2011 : 9d b1 9f STA $9fb1,x ; (path1 + 20)
; 423, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2014 : ee c5 9f INC $9fc5 ; (path1 + 40)
2017 : 90 80 __ BCC $1f99 ; (connect_via_existing_corridors.l53 + 0)
.s55:
; 428, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2019 : ad c5 9f LDA $9fc5 ; (path1 + 40)
201c : f0 22 __ BEQ $2040 ; (connect_via_existing_corridors.s83 + 0)
.s78:
; 429, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
201e : 85 48 __ STA T1 + 0 
2020 : ad 9d 9f LDA $9f9d ; (path1 + 0)
2023 : 85 13 __ STA P6 
2025 : ad b1 9f LDA $9fb1 ; (path1 + 20)
2028 : 85 14 __ STA P7 
202a : 20 49 24 JSR $2449 ; (place_door.s0 + 0)
; 431, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
202d : a4 48 __ LDY T1 + 0 
202f : c0 02 __ CPY #$02
2031 : 90 0d __ BCC $2040 ; (connect_via_existing_corridors.s83 + 0)
.s81:
; 432, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2033 : b9 9c 9f LDA $9f9c,y ; (dx1 + 0)
2036 : 85 13 __ STA P6 
2038 : b9 b0 9f LDA $9fb0,y ; (path1 + 19)
203b : 85 14 __ STA P7 
203d : 20 49 24 JSR $2449 ; (place_door.s0 + 0)
.s83:
; 437, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2040 : a9 00 __ LDA #$00
2042 : 8d 81 9f STA $9f81 ; (path2 + 40)
; 438, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2045 : 8d 58 9f STA $9f58 ; (dx2 + 0)
2048 : 8d 57 9f STA $9f57 ; (dy2 + 0)
; 439, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
204b : a4 4c __ LDY T5 + 0 
204d : b9 00 44 LDA $4400,y ; (rooms + 0)
2050 : 38 __ __ SEC
2051 : e9 01 __ SBC #$01
2053 : 90 11 __ BCC $2066 ; (connect_via_existing_corridors.s85 + 0)
.s1017:
2055 : cd ed 9f CMP $9fed ; (highest_priority + 0)
2058 : d0 0c __ BNE $2066 ; (connect_via_existing_corridors.s85 + 0)
.s84:
205a : a9 ff __ LDA #$ff
.s289:
; 440, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
205c : 8d 58 9f STA $9f58 ; (dx2 + 0)
205f : a9 00 __ LDA #$00
2061 : 8d 57 9f STA $9f57 ; (dy2 + 0)
2064 : f0 3d __ BEQ $20a3 ; (connect_via_existing_corridors.s86 + 0)
.s85:
; 440, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2066 : b9 02 44 LDA $4402,y ; (rooms + 2)
2069 : 18 __ __ CLC
206a : 79 00 44 ADC $4400,y ; (rooms + 0)
206d : b0 09 __ BCS $2078 ; (connect_via_existing_corridors.s88 + 0)
.s1014:
206f : cd ed 9f CMP $9fed ; (highest_priority + 0)
2072 : d0 04 __ BNE $2078 ; (connect_via_existing_corridors.s88 + 0)
.s87:
2074 : a9 01 __ LDA #$01
2076 : d0 e4 __ BNE $205c ; (connect_via_existing_corridors.s289 + 0)
.s88:
; 441, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2078 : b9 01 44 LDA $4401,y ; (rooms + 1)
207b : 38 __ __ SEC
207c : e9 01 __ SBC #$01
207e : 90 11 __ BCC $2091 ; (connect_via_existing_corridors.s91 + 0)
.s1011:
2080 : cd ec 9f CMP $9fec ; (dy + 0)
2083 : d0 0c __ BNE $2091 ; (connect_via_existing_corridors.s91 + 0)
.s90:
2085 : a9 ff __ LDA #$ff
.s342:
; 442, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2087 : 8d 57 9f STA $9f57 ; (dy2 + 0)
208a : a9 00 __ LDA #$00
208c : 8d 58 9f STA $9f58 ; (dx2 + 0)
208f : f0 12 __ BEQ $20a3 ; (connect_via_existing_corridors.s86 + 0)
.s91:
; 442, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2091 : b9 03 44 LDA $4403,y ; (rooms + 3)
2094 : 18 __ __ CLC
2095 : 79 01 44 ADC $4401,y ; (rooms + 1)
2098 : b0 09 __ BCS $20a3 ; (connect_via_existing_corridors.s86 + 0)
.s1008:
209a : cd ec 9f CMP $9fec ; (dy + 0)
209d : d0 04 __ BNE $20a3 ; (connect_via_existing_corridors.s86 + 0)
.s93:
209f : a9 01 __ LDA #$01
20a1 : d0 e4 __ BNE $2087 ; (connect_via_existing_corridors.s342 + 0)
.s86:
; 443, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20a3 : ad 58 9f LDA $9f58 ; (dx2 + 0)
20a6 : 18 __ __ CLC
20a7 : 6d ed 9f ADC $9fed ; (highest_priority + 0)
20aa : 85 49 __ STA T2 + 0 
20ac : 85 0d __ STA P0 
20ae : 8d 56 9f STA $9f56 ; (corridor2_x + 0)
; 445, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20b1 : a9 01 __ LDA #$01
20b3 : 8d a0 36 STA $36a0 ; (corridor_endpoint_override + 0)
; 444, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20b6 : ad 57 9f LDA $9f57 ; (dy2 + 0)
20b9 : 18 __ __ CLC
20ba : 6d ec 9f ADC $9fec ; (dy + 0)
20bd : 85 48 __ STA T1 + 0 
20bf : 85 0e __ STA P1 
20c1 : 8d 55 9f STA $9f55 ; (corridor2_y + 0)
; 446, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20c4 : 20 c2 14 JSR $14c2 ; (coords_in_bounds.s0 + 0)
20c7 : aa __ __ TAX
20c8 : f0 2d __ BEQ $20f7 ; (connect_via_existing_corridors.s98 + 0)
.s99:
20ca : a5 0d __ LDA P0 
20cc : 85 13 __ STA P6 
20ce : a5 0e __ LDA P1 
20d0 : 85 14 __ STA P7 
20d2 : 20 9d 22 JSR $229d ; (can_place_corridor_tile.s0 + 0)
20d5 : aa __ __ TAX
20d6 : f0 1f __ BEQ $20f7 ; (connect_via_existing_corridors.s98 + 0)
.s96:
; 447, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20d8 : a5 49 __ LDA T2 + 0 
20da : 85 10 __ STA P3 
20dc : a5 48 __ LDA T1 + 0 
20de : 85 11 __ STA P4 
20e0 : a9 02 __ LDA #$02
20e2 : 85 12 __ STA P5 
20e4 : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
; 448, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20e7 : a5 10 __ LDA P3 
20e9 : 8d 59 9f STA $9f59 ; (path2 + 0)
; 449, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20ec : a5 11 __ LDA P4 
20ee : ae 81 9f LDX $9f81 ; (path2 + 40)
20f1 : 9d 6d 9f STA $9f6d,x ; (path2 + 20)
; 450, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20f4 : ee 81 9f INC $9f81 ; (path2 + 40)
.s98:
; 453, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20f7 : a5 49 __ LDA T2 + 0 
20f9 : 8d 54 9f STA $9f54 ; (current2_x + 0)
; 454, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
20fc : a5 48 __ LDA T1 + 0 
20fe : 8d 53 9f STA $9f53 ; (current2_y + 0)
; 455, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2101 : a9 40 __ LDA #$40
2103 : 8d 52 9f STA $9f52 ; (step_limit2 + 0)
; 452, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2106 : a9 00 __ LDA #$00
2108 : 8d a0 36 STA $36a0 ; (corridor_endpoint_override + 0)
.l100:
; 456, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
210b : ac 54 9f LDY $9f54 ; (current2_x + 0)
210e : c4 4e __ CPY T7 + 0 
2110 : f0 04 __ BEQ $2116 ; (connect_via_existing_corridors.s1006 + 0)
.s1005:
2112 : a2 01 __ LDX #$01
2114 : d0 0a __ BNE $2120 ; (connect_via_existing_corridors.s103 + 0)
.s1006:
2116 : ad 53 9f LDA $9f53 ; (current2_y + 0)
2119 : a2 00 __ LDX #$00
211b : cd e4 9f CMP $9fe4 ; (y + 0)
211e : f0 6b __ BEQ $218b ; (connect_via_existing_corridors.s102 + 0)
.s103:
2120 : ad 52 9f LDA $9f52 ; (step_limit2 + 0)
2123 : ce 52 9f DEC $9f52 ; (step_limit2 + 0)
2126 : 09 00 __ ORA #$00
2128 : f0 61 __ BEQ $218b ; (connect_via_existing_corridors.s102 + 0)
.s101:
; 458, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
212a : 8a __ __ TXA
212b : f0 03 __ BEQ $2130 ; (connect_via_existing_corridors.s106 + 0)
212d : 4c b7 21 JMP $21b7 ; (connect_via_existing_corridors.s105 + 0)
.s106:
; 461, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2130 : ac 53 9f LDY $9f53 ; (current2_y + 0)
2133 : cc e4 9f CPY $9fe4 ; (y + 0)
2136 : f0 53 __ BEQ $218b ; (connect_via_existing_corridors.s102 + 0)
.s111:
; 462, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2138 : b0 03 __ BCS $213d ; (connect_via_existing_corridors.s115 + 0)
.s114:
213a : c8 __ __ INY
213b : 90 01 __ BCC $213e ; (connect_via_existing_corridors.s291 + 0)
.s115:
; 463, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
213d : 88 __ __ DEY
.s291:
213e : 8c 53 9f STY $9f53 ; (current2_y + 0)
; 467, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2141 : ad 54 9f LDA $9f54 ; (current2_x + 0)
.s107:
2144 : 85 49 __ STA T2 + 0 
2146 : 85 0f __ STA P2 
2148 : ad 53 9f LDA $9f53 ; (current2_y + 0)
214b : 85 4a __ STA T3 + 0 
214d : 85 10 __ STA P3 
214f : 20 87 1c JSR $1c87 ; (is_outside_any_room.s0 + 0)
2152 : aa __ __ TAX
2153 : f0 b6 __ BEQ $210b ; (connect_via_existing_corridors.l100 + 0)
.s121:
2155 : a5 0f __ LDA P2 
2157 : 85 13 __ STA P6 
2159 : a5 4a __ LDA T3 + 0 
215b : 85 14 __ STA P7 
215d : 20 9d 22 JSR $229d ; (can_place_corridor_tile.s0 + 0)
2160 : aa __ __ TAX
2161 : f0 a8 __ BEQ $210b ; (connect_via_existing_corridors.l100 + 0)
.s118:
; 468, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2163 : a5 49 __ LDA T2 + 0 
2165 : 85 10 __ STA P3 
2167 : a5 4a __ LDA T3 + 0 
2169 : 85 11 __ STA P4 
216b : a9 02 __ LDA #$02
216d : 85 12 __ STA P5 
216f : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
; 469, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2172 : ae 81 9f LDX $9f81 ; (path2 + 40)
2175 : e0 14 __ CPX #$14
2177 : b0 92 __ BCS $210b ; (connect_via_existing_corridors.l100 + 0)
.s122:
; 470, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2179 : a5 10 __ LDA P3 
217b : 9d 59 9f STA $9f59,x ; (path2 + 0)
; 471, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
217e : a5 4a __ LDA T3 + 0 
2180 : ae 81 9f LDX $9f81 ; (path2 + 40)
2183 : 9d 6d 9f STA $9f6d,x ; (path2 + 20)
; 472, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2186 : ee 81 9f INC $9f81 ; (path2 + 40)
2189 : 90 80 __ BCC $210b ; (connect_via_existing_corridors.l100 + 0)
.s102:
; 477, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
218b : ad 81 9f LDA $9f81 ; (path2 + 40)
218e : f0 22 __ BEQ $21b2 ; (connect_via_existing_corridors.s1035 + 0)
.s125:
; 478, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2190 : 85 48 __ STA T1 + 0 
2192 : ad 59 9f LDA $9f59 ; (path2 + 0)
2195 : 85 13 __ STA P6 
2197 : ad 6d 9f LDA $9f6d ; (path2 + 20)
219a : 85 14 __ STA P7 
219c : 20 49 24 JSR $2449 ; (place_door.s0 + 0)
; 480, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
219f : a4 48 __ LDY T1 + 0 
21a1 : c0 02 __ CPY #$02
21a3 : 90 0d __ BCC $21b2 ; (connect_via_existing_corridors.s1035 + 0)
.s128:
; 481, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21a5 : b9 58 9f LDA $9f58,y ; (dx2 + 0)
21a8 : 85 13 __ STA P6 
21aa : b9 6c 9f LDA $9f6c,y ; (path2 + 19)
21ad : 85 14 __ STA P7 
21af : 20 49 24 JSR $2449 ; (place_door.s0 + 0)
.s1035:
; 483, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21b2 : a9 01 __ LDA #$01
.s1001:
; 486, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21b4 : 85 1b __ STA ACCU + 0 ; (room1 + 0)
21b6 : 60 __ __ RTS
.s105:
; 459, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21b7 : c4 4e __ CPY T7 + 0 
21b9 : b0 03 __ BCS $21be ; (connect_via_existing_corridors.s109 + 0)
.s108:
21bb : c8 __ __ INY
21bc : 90 01 __ BCC $21bf ; (connect_via_existing_corridors.s290 + 0)
.s109:
; 460, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21be : 88 __ __ DEY
.s290:
21bf : 8c 54 9f STY $9f54 ; (current2_x + 0)
21c2 : 98 __ __ TYA
21c3 : 4c 44 21 JMP $2144 ; (connect_via_existing_corridors.s107 + 0)
.s58:
; 410, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21c6 : c4 4d __ CPY T6 + 0 
21c8 : b0 03 __ BCS $21cd ; (connect_via_existing_corridors.s62 + 0)
.s61:
21ca : c8 __ __ INY
21cb : 90 01 __ BCC $21ce ; (connect_via_existing_corridors.s287 + 0)
.s62:
; 411, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
21cd : 88 __ __ DEY
.s287:
21ce : 8c 98 9f STY $9f98 ; (current1_x + 0)
21d1 : 98 __ __ TYA
21d2 : 4c d2 1f JMP $1fd2 ; (connect_via_existing_corridors.s60 + 0)
--------------------------------------------------------------------
find_room_exit: ; find_room_exit(struct S#1334*,u8,u8,u8*,u8*)->void
.s0:
; 168, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
21d5 : 38 __ __ SEC
21d6 : a5 12 __ LDA P5 ; (room + 0)
21d8 : e9 00 __ SBC #$00
21da : 85 43 __ STA T0 + 0 
21dc : a5 13 __ LDA P6 ; (room + 1)
21de : e9 44 __ SBC #$44
21e0 : 4a __ __ LSR
21e1 : 66 43 __ ROR T0 + 0 
21e3 : 4a __ __ LSR
21e4 : 66 43 __ ROR T0 + 0 
21e6 : 4a __ __ LSR
21e7 : a5 43 __ LDA T0 + 0 
21e9 : 6a __ __ ROR
21ea : 85 0d __ STA P0 
21ec : 8d f7 9f STA $9ff7 ; (d + 1)
; 169, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
21ef : a9 f9 __ LDA #$f9
21f1 : 85 0e __ STA P1 
21f3 : a9 9f __ LDA #$9f
21f5 : 85 11 __ STA P4 
21f7 : a9 9f __ LDA #$9f
21f9 : 85 0f __ STA P2 
21fb : a9 f8 __ LDA #$f8
21fd : 85 10 __ STA P3 
21ff : 20 16 0d JSR $0d16 ; (get_room_center.s0 + 0)
; 170, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2202 : a5 14 __ LDA P7 ; (target_x + 0)
2204 : 85 0d __ STA P0 
2206 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
2209 : 85 45 __ STA T5 + 0 
220b : 85 0e __ STA P1 
220d : 20 ad 0d JSR $0dad ; (fast_abs_diff.s0 + 0)
2210 : 85 46 __ STA T6 + 0 
2212 : 8d f6 9f STA $9ff6 ; (y2 + 0)
; 171, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2215 : a5 15 __ LDA P8 ; (target_y + 0)
2217 : 85 0d __ STA P0 
2219 : ad f8 9f LDA $9ff8 ; (room + 1)
221c : 85 47 __ STA T8 + 0 
221e : 85 0e __ STA P1 
2220 : 20 ad 0d JSR $0dad ; (fast_abs_diff.s0 + 0)
2223 : 8d f5 9f STA $9ff5 ; (s + 1)
; 174, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2226 : ae fa 9f LDX $9ffa ; (sstack + 0)
2229 : 86 1b __ STX ACCU + 0 
222b : ae fb 9f LDX $9ffb ; (sstack + 1)
222e : 86 1c __ STX ACCU + 1 
2230 : c5 46 __ CMP T6 + 0 
2232 : 90 24 __ BCC $2258 ; (find_room_exit.s1 + 0)
.s2:
; 187, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2234 : a0 01 __ LDY #$01
2236 : b1 12 __ LDA (P5),y ; (room + 0)
2238 : 85 1d __ STA ACCU + 2 
223a : a5 47 __ LDA T8 + 0 
223c : c5 15 __ CMP P8 ; (target_y + 0)
223e : 90 07 __ BCC $2247 ; (find_room_exit.s7 + 0)
.s8:
; 193, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2240 : a5 1d __ LDA ACCU + 2 
2242 : e9 02 __ SBC #$02
2244 : 4c 4e 22 JMP $224e ; (find_room_exit.s14 + 0)
.s7:
; 189, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2247 : a0 03 __ LDY #$03
2249 : b1 12 __ LDA (P5),y ; (room + 0)
224b : 38 __ __ SEC
224c : 65 1d __ ADC ACCU + 2 
.s14:
; 193, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
224e : a0 00 __ LDY #$00
2250 : 91 1b __ STA (ACCU + 0),y 
; 194, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2252 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
2255 : 91 16 __ STA (P9),y ; (exit_x + 0)
.s1001:
; 198, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2257 : 60 __ __ RTS
.s1:
; 176, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2258 : a0 00 __ LDY #$00
225a : b1 12 __ LDA (P5),y ; (room + 0)
225c : 85 1d __ STA ACCU + 2 
225e : a5 45 __ LDA T5 + 0 
2260 : c5 14 __ CMP P7 ; (target_x + 0)
2262 : b0 0b __ BCS $226f ; (find_room_exit.s5 + 0)
.s4:
; 182, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2264 : a0 02 __ LDY #$02
2266 : b1 12 __ LDA (P5),y ; (room + 0)
2268 : 38 __ __ SEC
2269 : 65 1d __ ADC ACCU + 2 
226b : a0 00 __ LDY #$00
226d : f0 04 __ BEQ $2273 ; (find_room_exit.s13 + 0)
.s5:
; 182, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
226f : a5 1d __ LDA ACCU + 2 
2271 : e9 02 __ SBC #$02
.s13:
2273 : 91 16 __ STA (P9),y ; (exit_x + 0)
; 183, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
2275 : ad f8 9f LDA $9ff8 ; (room + 1)
2278 : 91 1b __ STA (ACCU + 0),y 
227a : 60 __ __ RTS
--------------------------------------------------------------------
tile_is_floor: ; tile_is_floor(u8,u8)->u8
.s0:
; 269, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
227b : a5 0f __ LDA P2 ; (x + 0)
227d : c9 40 __ CMP #$40
227f : b0 17 __ BCS $2298 ; (tile_is_floor.s1005 + 0)
.s4:
2281 : a5 10 __ LDA P3 ; (y + 0)
2283 : c9 40 __ CMP #$40
2285 : b0 11 __ BCS $2298 ; (tile_is_floor.s1005 + 0)
.s3:
; 270, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
2287 : 85 0e __ STA P1 
2289 : a5 0f __ LDA P2 ; (x + 0)
228b : 85 0d __ STA P0 
228d : 20 f9 14 JSR $14f9 ; (get_tile_core.s0 + 0)
2290 : c9 02 __ CMP #$02
2292 : d0 04 __ BNE $2298 ; (tile_is_floor.s1005 + 0)
.s1002:
2294 : a9 01 __ LDA #$01
2296 : d0 02 __ BNE $229a ; (tile_is_floor.s1001 + 0)
.s1005:
2298 : a9 00 __ LDA #$00
.s1001:
229a : 85 1b __ STA ACCU + 0 
229c : 60 __ __ RTS
--------------------------------------------------------------------
can_place_corridor_tile: ; can_place_corridor_tile(u8,u8)->u8
.s0:
; 109, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
229d : a5 13 __ LDA P6 ; (x + 0)
229f : 85 0d __ STA P0 
22a1 : a5 14 __ LDA P7 ; (y + 0)
22a3 : 85 0e __ STA P1 
22a5 : ad a0 36 LDA $36a0 ; (corridor_endpoint_override + 0)
22a8 : f0 03 __ BEQ $22ad ; (can_place_corridor_tile.s3 + 0)
22aa : 4c 32 23 JMP $2332 ; (can_place_corridor_tile.s1 + 0)
.s3:
; 116, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
22ad : 20 30 1c JSR $1c30 ; (coords_in_bounds_fast.s0 + 0)
22b0 : aa __ __ TAX
22b1 : f0 7e __ BEQ $2331 ; (can_place_corridor_tile.s1001 + 0)
.s19:
; 118, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
22b3 : a5 13 __ LDA P6 ; (x + 0)
22b5 : 85 0f __ STA P2 
22b7 : a5 14 __ LDA P7 ; (y + 0)
22b9 : 85 10 __ STA P3 
22bb : 20 87 1c JSR $1c87 ; (is_outside_any_room.s0 + 0)
22be : aa __ __ TAX
22bf : f0 70 __ BEQ $2331 ; (can_place_corridor_tile.s1001 + 0)
.s23:
; 122, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
22c1 : e6 0f __ INC P2 
22c3 : 20 87 1c JSR $1c87 ; (is_outside_any_room.s0 + 0)
22c6 : aa __ __ TAX
22c7 : f0 68 __ BEQ $2331 ; (can_place_corridor_tile.s1001 + 0)
.s30:
; 123, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
22c9 : a6 13 __ LDX P6 ; (x + 0)
22cb : ca __ __ DEX
22cc : 86 0f __ STX P2 
22ce : 20 87 1c JSR $1c87 ; (is_outside_any_room.s0 + 0)
22d1 : aa __ __ TAX
22d2 : f0 5d __ BEQ $2331 ; (can_place_corridor_tile.s1001 + 0)
.s29:
; 124, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
22d4 : e6 0f __ INC P2 
22d6 : e6 10 __ INC P3 
22d8 : 20 87 1c JSR $1c87 ; (is_outside_any_room.s0 + 0)
22db : aa __ __ TAX
22dc : f0 53 __ BEQ $2331 ; (can_place_corridor_tile.s1001 + 0)
.s28:
; 125, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
22de : a6 14 __ LDX P7 ; (y + 0)
22e0 : ca __ __ DEX
22e1 : 86 10 __ STX P3 
22e3 : 20 87 1c JSR $1c87 ; (is_outside_any_room.s0 + 0)
22e6 : aa __ __ TAX
22e7 : f0 48 __ BEQ $2331 ; (can_place_corridor_tile.s1001 + 0)
.s27:
; 130, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
22e9 : a9 00 __ LDA #$00
22eb : 8d f6 9f STA $9ff6 ; (y2 + 0)
22ee : ad 92 35 LDA $3592 ; (room_count + 0)
22f1 : f0 3c __ BEQ $232f ; (can_place_corridor_tile.s14 + 0)
.l33:
; 132, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
22f3 : ad f6 9f LDA $9ff6 ; (y2 + 0)
22f6 : 85 45 __ STA T6 + 0 
22f8 : 85 0d __ STA P0 
22fa : a9 f5 __ LDA #$f5
22fc : 85 0e __ STA P1 
22fe : a9 9f __ LDA #$9f
2300 : 85 0f __ STA P2 
2302 : a9 f4 __ LDA #$f4
2304 : 85 10 __ STA P3 
2306 : a9 9f __ LDA #$9f
2308 : 85 11 __ STA P4 
230a : 20 16 0d JSR $0d16 ; (get_room_center.s0 + 0)
; 133, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
230d : a5 13 __ LDA P6 ; (x + 0)
230f : 85 0f __ STA P2 
2311 : a5 14 __ LDA P7 ; (y + 0)
2313 : 85 10 __ STA P3 
2315 : ad f5 9f LDA $9ff5 ; (s + 1)
2318 : 85 11 __ STA P4 
231a : ad f4 9f LDA $9ff4 ; (entropy1 + 1)
231d : 85 12 __ STA P5 
231f : 20 2d 24 JSR $242d ; (manhattan_distance_fast.s0 + 0)
; 130, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2322 : 18 __ __ CLC
2323 : a5 45 __ LDA T6 + 0 
2325 : 69 01 __ ADC #$01
2327 : 8d f6 9f STA $9ff6 ; (y2 + 0)
232a : cd 92 35 CMP $3592 ; (room_count + 0)
232d : 90 c4 __ BCC $22f3 ; (can_place_corridor_tile.l33 + 0)
.s14:
; 114, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
232f : a9 01 __ LDA #$01
.s1001:
; 111, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2331 : 60 __ __ RTS
.s1:
2332 : 20 30 1c JSR $1c30 ; (coords_in_bounds_fast.s0 + 0)
2335 : aa __ __ TAX
2336 : f0 f9 __ BEQ $2331 ; (can_place_corridor_tile.s1001 + 0)
.s6:
; 112, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2338 : a5 13 __ LDA P6 ; (x + 0)
233a : 85 0f __ STA P2 
233c : a5 14 __ LDA P7 ; (y + 0)
233e : 85 10 __ STA P3 
2340 : 20 87 1c JSR $1c87 ; (is_outside_any_room.s0 + 0)
2343 : aa __ __ TAX
2344 : f0 eb __ BEQ $2331 ; (can_place_corridor_tile.s1001 + 0)
.s10:
; 113, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2346 : a5 13 __ LDA P6 ; (x + 0)
2348 : 85 0d __ STA P0 
234a : a5 14 __ LDA P7 ; (y + 0)
234c : 85 0e __ STA P1 
234e : 20 55 23 JSR $2355 ; (is_on_room_edge.s0 + 0)
2351 : aa __ __ TAX
2352 : d0 db __ BNE $232f ; (can_place_corridor_tile.s14 + 0)
2354 : 60 __ __ RTS
--------------------------------------------------------------------
is_on_room_edge: ; is_on_room_edge(u8,u8)->u8
.s0:
;  25, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
2355 : a9 00 __ LDA #$00
2357 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
235a : ad 92 35 LDA $3592 ; (room_count + 0)
235d : 85 43 __ STA T5 + 0 
235f : d0 03 __ BNE $2364 ; (is_on_room_edge.l2 + 0)
2361 : 4c 27 24 JMP $2427 ; (is_on_room_edge.s4 + 0)
.l2:
;  26, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
2364 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
2367 : 0a __ __ ASL
2368 : 0a __ __ ASL
2369 : 0a __ __ ASL
236a : aa __ __ TAX
236b : 69 00 __ ADC #$00
236d : 85 1b __ STA ACCU + 0 
236f : 8d f7 9f STA $9ff7 ; (d + 1)
2372 : a9 44 __ LDA #$44
2374 : 69 00 __ ADC #$00
2376 : 85 1c __ STA ACCU + 1 
2378 : 8d f8 9f STA $9ff8 ; (room + 1)
;  28, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
237b : bd 01 44 LDA $4401,x ; (rooms + 1)
237e : 85 44 __ STA T8 + 0 
2380 : c5 0e __ CMP P1 ; (y + 0)
2382 : d0 1a __ BNE $239e ; (is_on_room_edge.s7 + 0)
.s9:
2384 : a0 00 __ LDY #$00
2386 : b1 1b __ LDA (ACCU + 0),y 
2388 : c5 0d __ CMP P0 ; (x + 0)
238a : 90 02 __ BCC $238e ; (is_on_room_edge.s8 + 0)
.s1022:
238c : d0 10 __ BNE $239e ; (is_on_room_edge.s7 + 0)
.s8:
238e : 18 __ __ CLC
238f : a0 02 __ LDY #$02
2391 : 71 1b __ ADC (ACCU + 0),y 
2393 : 90 03 __ BCC $2398 ; (is_on_room_edge.s1017 + 0)
2395 : 4c 2a 24 JMP $242a ; (is_on_room_edge.s5 + 0)
.s1017:
2398 : c5 0d __ CMP P0 ; (x + 0)
239a : 90 02 __ BCC $239e ; (is_on_room_edge.s7 + 0)
.s1023:
239c : d0 f7 __ BNE $2395 ; (is_on_room_edge.s8 + 7)
.s7:
;  30, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
239e : a0 03 __ LDY #$03
23a0 : b1 1b __ LDA (ACCU + 0),y 
23a2 : 18 __ __ CLC
23a3 : 65 44 __ ADC T8 + 0 
23a5 : 85 1d __ STA ACCU + 2 
23a7 : a9 00 __ LDA #$00
23a9 : 2a __ __ ROL
23aa : aa __ __ TAX
23ab : 38 __ __ SEC
23ac : a5 1d __ LDA ACCU + 2 
23ae : e9 01 __ SBC #$01
23b0 : 85 1e __ STA ACCU + 3 
23b2 : 8a __ __ TXA
23b3 : e9 00 __ SBC #$00
23b5 : d0 1d __ BNE $23d4 ; (is_on_room_edge.s1037 + 0)
.s1014:
23b7 : a5 0e __ LDA P1 ; (y + 0)
23b9 : c5 1e __ CMP ACCU + 3 
23bb : d0 17 __ BNE $23d4 ; (is_on_room_edge.s1037 + 0)
.s15:
23bd : a0 00 __ LDY #$00
23bf : b1 1b __ LDA (ACCU + 0),y 
23c1 : c5 0d __ CMP P0 ; (x + 0)
23c3 : 90 02 __ BCC $23c7 ; (is_on_room_edge.s14 + 0)
.s1024:
23c5 : d0 0f __ BNE $23d6 ; (is_on_room_edge.s13 + 0)
.s14:
23c7 : 18 __ __ CLC
23c8 : a0 02 __ LDY #$02
23ca : 71 1b __ ADC (ACCU + 0),y 
23cc : b0 5c __ BCS $242a ; (is_on_room_edge.s5 + 0)
.s1011:
23ce : c5 0d __ CMP P0 ; (x + 0)
23d0 : 90 02 __ BCC $23d4 ; (is_on_room_edge.s1037 + 0)
.s1025:
23d2 : d0 56 __ BNE $242a ; (is_on_room_edge.s5 + 0)
.s1037:
;  32, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
23d4 : a0 00 __ LDY #$00
.s13:
23d6 : b1 1b __ LDA (ACCU + 0),y 
23d8 : 85 1e __ STA ACCU + 3 
23da : c5 0d __ CMP P0 ; (x + 0)
23dc : d0 0f __ BNE $23ed ; (is_on_room_edge.s19 + 0)
.s21:
23de : a5 0e __ LDA P1 ; (y + 0)
23e0 : c5 44 __ CMP T8 + 0 
23e2 : 90 09 __ BCC $23ed ; (is_on_room_edge.s19 + 0)
.s20:
23e4 : 8a __ __ TXA
23e5 : d0 43 __ BNE $242a ; (is_on_room_edge.s5 + 0)
.s1008:
23e7 : a5 0e __ LDA P1 ; (y + 0)
23e9 : c5 1d __ CMP ACCU + 2 
23eb : 90 3d __ BCC $242a ; (is_on_room_edge.s5 + 0)
.s19:
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
23ed : a0 02 __ LDY #$02
23ef : b1 1b __ LDA (ACCU + 0),y 
23f1 : 18 __ __ CLC
23f2 : 65 1e __ ADC ACCU + 3 
23f4 : a8 __ __ TAY
23f5 : a9 00 __ LDA #$00
23f7 : 2a __ __ ROL
23f8 : 85 1c __ STA ACCU + 1 
23fa : 98 __ __ TYA
23fb : e9 00 __ SBC #$00
23fd : 85 1b __ STA ACCU + 0 
23ff : a5 1c __ LDA ACCU + 1 
2401 : e9 00 __ SBC #$00
2403 : d0 15 __ BNE $241a ; (is_on_room_edge.s3 + 0)
.s1005:
2405 : a5 0d __ LDA P0 ; (x + 0)
2407 : c5 1b __ CMP ACCU + 0 
2409 : d0 0f __ BNE $241a ; (is_on_room_edge.s3 + 0)
.s27:
240b : a5 0e __ LDA P1 ; (y + 0)
240d : c5 44 __ CMP T8 + 0 
240f : 90 09 __ BCC $241a ; (is_on_room_edge.s3 + 0)
.s26:
2411 : 8a __ __ TXA
2412 : d0 16 __ BNE $242a ; (is_on_room_edge.s5 + 0)
.s1002:
2414 : a5 0e __ LDA P1 ; (y + 0)
2416 : c5 1d __ CMP ACCU + 2 
2418 : 90 10 __ BCC $242a ; (is_on_room_edge.s5 + 0)
.s3:
;  25, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
241a : ee f9 9f INC $9ff9 ; (bit_offset + 1)
241d : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
2420 : c5 43 __ CMP T5 + 0 
2422 : b0 03 __ BCS $2427 ; (is_on_room_edge.s4 + 0)
2424 : 4c 64 23 JMP $2364 ; (is_on_room_edge.l2 + 0)
.s4:
;  36, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/utility.c"
2427 : a9 00 __ LDA #$00
.s1001:
2429 : 60 __ __ RTS
.s5:
242a : a9 01 __ LDA #$01
242c : 60 __ __ RTS
--------------------------------------------------------------------
manhattan_distance_fast: ; manhattan_distance_fast(u8,u8,u8,u8)->u8
.s0:
;  50, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utility.h"
242d : a5 0f __ LDA P2 ; (x1 + 0)
242f : 85 0d __ STA P0 
2431 : a5 11 __ LDA P4 ; (x2 + 0)
2433 : 85 0e __ STA P1 
2435 : 20 ad 0d JSR $0dad ; (fast_abs_diff.s0 + 0)
2438 : 85 43 __ STA T0 + 0 
243a : a5 10 __ LDA P3 ; (y1 + 0)
243c : 85 0d __ STA P0 
243e : a5 12 __ LDA P5 ; (y2 + 0)
2440 : 85 0e __ STA P1 
2442 : 20 ad 0d JSR $0dad ; (fast_abs_diff.s0 + 0)
2445 : 18 __ __ CLC
2446 : 65 43 __ ADC T0 + 0 
.s1001:
2448 : 60 __ __ RTS
--------------------------------------------------------------------
place_door: ; place_door(u8,u8)->void
.s0:
;  16, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/door_placement.c"
2449 : a5 13 __ LDA P6 ; (x + 0)
244b : 85 10 __ STA P3 
244d : a5 14 __ LDA P7 ; (y + 0)
244f : 85 11 __ STA P4 
2451 : a9 03 __ LDA #$03
2453 : 85 12 __ STA P5 
2455 : 4c 20 16 JMP $1620 ; (set_tile_raw.s0 + 0)
--------------------------------------------------------------------
draw_rule_based_corridor: ; draw_rule_based_corridor(u8,u8)->u8
.s0:
; 222, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2458 : ad fc 9f LDA $9ffc ; (sstack + 2)
245b : 85 4b __ STA T1 + 0 
245d : 85 0d __ STA P0 
245f : a9 e9 __ LDA #$e9
2461 : 85 0e __ STA P1 
2463 : a9 9f __ LDA #$9f
2465 : 85 11 __ STA P4 
2467 : a9 9f __ LDA #$9f
2469 : 85 0f __ STA P2 
246b : a9 e8 __ LDA #$e8
246d : 85 10 __ STA P3 
246f : 20 16 0d JSR $0d16 ; (get_room_center.s0 + 0)
; 223, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2472 : ad fd 9f LDA $9ffd ; (sstack + 3)
2475 : 85 0d __ STA P0 
2477 : 85 4e __ STA T4 + 0 
2479 : 0a __ __ ASL
247a : 0a __ __ ASL
247b : 85 4a __ STA T0 + 0 
247d : a9 e7 __ LDA #$e7
247f : 85 0e __ STA P1 
2481 : a9 9f __ LDA #$9f
2483 : 85 11 __ STA P4 
2485 : a9 9f __ LDA #$9f
2487 : 85 0f __ STA P2 
2489 : a9 e6 __ LDA #$e6
248b : 85 10 __ STA P3 
248d : 20 16 0d JSR $0d16 ; (get_room_center.s0 + 0)
; 224, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2490 : a5 4b __ LDA T1 + 0 
2492 : 0a __ __ ASL
2493 : 0a __ __ ASL
2494 : 0a __ __ ASL
2495 : 85 4d __ STA T3 + 0 
2497 : 18 __ __ CLC
2498 : 69 00 __ ADC #$00
249a : 85 12 __ STA P5 
249c : a9 44 __ LDA #$44
249e : 69 00 __ ADC #$00
24a0 : 85 13 __ STA P6 
24a2 : ad e7 9f LDA $9fe7 ; (offset_range + 0)
24a5 : 85 14 __ STA P7 
24a7 : ad e6 9f LDA $9fe6 ; (closest_corridor_y1 + 0)
24aa : 85 15 __ STA P8 
24ac : a9 ed __ LDA #$ed
24ae : 85 16 __ STA P9 
24b0 : a9 ec __ LDA #$ec
24b2 : 8d fa 9f STA $9ffa ; (sstack + 0)
24b5 : a9 9f __ LDA #$9f
24b7 : 85 17 __ STA P10 
24b9 : a9 9f __ LDA #$9f
24bb : 8d fb 9f STA $9ffb ; (sstack + 1)
24be : 20 d5 21 JSR $21d5 ; (find_room_exit.s0 + 0)
; 225, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
24c1 : a5 4a __ LDA T0 + 0 
24c3 : 0a __ __ ASL
24c4 : 85 4f __ STA T5 + 0 
24c6 : 18 __ __ CLC
24c7 : 69 00 __ ADC #$00
24c9 : 85 12 __ STA P5 
24cb : a9 44 __ LDA #$44
24cd : 69 00 __ ADC #$00
24cf : 85 13 __ STA P6 
24d1 : ad e9 9f LDA $9fe9 ; (y + 0)
24d4 : 85 14 __ STA P7 
24d6 : ad e8 9f LDA $9fe8 ; (room2_center_y + 0)
24d9 : 85 15 __ STA P8 
24db : a9 eb __ LDA #$eb
24dd : 85 16 __ STA P9 
24df : a9 ea __ LDA #$ea
24e1 : 8d fa 9f STA $9ffa ; (sstack + 0)
24e4 : a9 9f __ LDA #$9f
24e6 : 85 17 __ STA P10 
24e8 : a9 9f __ LDA #$9f
24ea : 8d fb 9f STA $9ffb ; (sstack + 1)
24ed : 20 d5 21 JSR $21d5 ; (find_room_exit.s0 + 0)
; 231, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
24f0 : a9 02 __ LDA #$02
24f2 : 85 12 __ STA P5 
24f4 : a9 01 __ LDA #$01
24f6 : 8d a0 36 STA $36a0 ; (corridor_endpoint_override + 0)
; 228, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
24f9 : a9 00 __ LDA #$00
24fb : 8d 28 45 STA $4528 ; (corridor_path_static + 40)
; 232, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
24fe : ad ed 9f LDA $9fed ; (highest_priority + 0)
2501 : 85 10 __ STA P3 
2503 : ad ec 9f LDA $9fec ; (dy + 0)
2506 : 85 11 __ STA P4 
2508 : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
; 235, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
250b : a5 11 __ LDA P4 
250d : 85 16 __ STA P9 
250f : 8d 14 45 STA $4514 ; (corridor_path_static + 20)
; 234, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2512 : a5 10 __ LDA P3 
2514 : 85 15 __ STA P8 
2516 : 8d 00 45 STA $4500 ; (corridor_path_static + 0)
; 241, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2519 : ad eb 9f LDA $9feb ; (screen_offset + 1)
251c : 18 __ __ CLC
251d : 65 10 __ ADC P3 
251f : 6a __ __ ROR
2520 : 85 17 __ STA P10 
2522 : 8d e5 9f STA $9fe5 ; (tile + 0)
; 238, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2525 : a9 00 __ LDA #$00
2527 : 8d a0 36 STA $36a0 ; (corridor_endpoint_override + 0)
; 236, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
252a : a9 01 __ LDA #$01
252c : 8d 28 45 STA $4528 ; (corridor_path_static + 40)
; 242, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
252f : ad ea 9f LDA $9fea ; (check_y + 0)
2532 : 18 __ __ CLC
2533 : 65 11 __ ADC P4 
2535 : 6a __ __ ROR
2536 : 85 18 __ STA P11 
2538 : 8d e4 9f STA $9fe4 ; (y + 0)
; 246, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
253b : 18 __ __ CLC
253c : a5 4e __ LDA T4 + 0 
253e : 65 4b __ ADC T1 + 0 
2540 : 85 4c __ STA T2 + 0 
2542 : 29 01 __ AND #$01
2544 : 8d fa 9f STA $9ffa ; (sstack + 0)
2547 : 20 78 26 JSR $2678 ; (straight_corridor_path.s0 + 0)
; 248, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
254a : a5 17 __ LDA P10 
254c : 85 15 __ STA P8 
254e : a5 18 __ LDA P11 
2550 : 85 16 __ STA P9 
2552 : ad eb 9f LDA $9feb ; (screen_offset + 1)
2555 : 85 17 __ STA P10 
2557 : ad ea 9f LDA $9fea ; (check_y + 0)
255a : 85 18 __ STA P11 
255c : 18 __ __ CLC
255d : a5 4c __ LDA T2 + 0 
255f : 69 01 __ ADC #$01
2561 : 29 01 __ AND #$01
2563 : 8d fa 9f STA $9ffa ; (sstack + 0)
2566 : 20 78 26 JSR $2678 ; (straight_corridor_path.s0 + 0)
; 252, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2569 : ad ed 9f LDA $9fed ; (highest_priority + 0)
256c : 8d e3 9f STA $9fe3 ; (door1_x + 0)
; 253, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
256f : ad ec 9f LDA $9fec ; (dy + 0)
2572 : 8d e2 9f STA $9fe2 ; (min_dist2 + 0)
; 254, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2575 : ad eb 9f LDA $9feb ; (screen_offset + 1)
2578 : 8d e1 9f STA $9fe1 ; (search_x1 + 0)
; 255, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
257b : ad ea 9f LDA $9fea ; (check_y + 0)
257e : 8d e0 9f STA $9fe0 ; (grid_positions + 15)
; 258, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2581 : a6 4d __ LDX T3 + 0 
2583 : bd 00 44 LDA $4400,x ; (rooms + 0)
2586 : 85 4a __ STA T0 + 0 
2588 : 38 __ __ SEC
2589 : e9 02 __ SBC #$02
258b : 90 0f __ BCC $259c ; (draw_rule_based_corridor.s5 + 0)
.s1023:
258d : cd e3 9f CMP $9fe3 ; (door1_x + 0)
2590 : d0 0a __ BNE $259c ; (draw_rule_based_corridor.s5 + 0)
.s4:
; 259, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2592 : c6 4a __ DEC T0 + 0 
.s37:
; 261, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2594 : a5 4a __ LDA T0 + 0 
2596 : 8d e3 9f STA $9fe3 ; (door1_x + 0)
2599 : 4c ee 25 JMP $25ee ; (draw_rule_based_corridor.s6 + 0)
.s5:
; 260, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
259c : bd 02 44 LDA $4402,x ; (rooms + 2)
259f : 18 __ __ CLC
25a0 : 65 4a __ ADC T0 + 0 
25a2 : 85 4a __ STA T0 + 0 
25a4 : a9 00 __ LDA #$00
25a6 : 2a __ __ ROL
25a7 : a8 __ __ TAY
25a8 : a5 4a __ LDA T0 + 0 
25aa : 69 01 __ ADC #$01
25ac : 85 4b __ STA T1 + 0 
25ae : 98 __ __ TYA
25af : 69 00 __ ADC #$00
25b1 : d0 07 __ BNE $25ba ; (draw_rule_based_corridor.s8 + 0)
.s1020:
25b3 : a5 4b __ LDA T1 + 0 
25b5 : cd e3 9f CMP $9fe3 ; (door1_x + 0)
25b8 : f0 da __ BEQ $2594 ; (draw_rule_based_corridor.s37 + 0)
.s8:
; 262, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25ba : bd 01 44 LDA $4401,x ; (rooms + 1)
25bd : 85 4a __ STA T0 + 0 
25bf : 38 __ __ SEC
25c0 : e9 02 __ SBC #$02
25c2 : 90 0f __ BCC $25d3 ; (draw_rule_based_corridor.s11 + 0)
.s1017:
25c4 : cd ec 9f CMP $9fec ; (dy + 0)
25c7 : d0 0a __ BNE $25d3 ; (draw_rule_based_corridor.s11 + 0)
.s10:
; 263, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25c9 : c6 4a __ DEC T0 + 0 
.s38:
; 265, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25cb : a5 4a __ LDA T0 + 0 
25cd : 8d e2 9f STA $9fe2 ; (min_dist2 + 0)
25d0 : 4c ee 25 JMP $25ee ; (draw_rule_based_corridor.s6 + 0)
.s11:
; 264, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25d3 : bd 03 44 LDA $4403,x ; (rooms + 3)
25d6 : 18 __ __ CLC
25d7 : 65 4a __ ADC T0 + 0 
25d9 : 85 4a __ STA T0 + 0 
25db : a9 00 __ LDA #$00
25dd : 2a __ __ ROL
25de : a8 __ __ TAY
25df : a5 4a __ LDA T0 + 0 
25e1 : 69 01 __ ADC #$01
25e3 : aa __ __ TAX
25e4 : 98 __ __ TYA
25e5 : 69 00 __ ADC #$00
25e7 : d0 05 __ BNE $25ee ; (draw_rule_based_corridor.s6 + 0)
.s1014:
25e9 : ec ec 9f CPX $9fec ; (dy + 0)
25ec : f0 dd __ BEQ $25cb ; (draw_rule_based_corridor.s38 + 0)
.s6:
; 269, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
25ee : ad e3 9f LDA $9fe3 ; (door1_x + 0)
25f1 : 85 13 __ STA P6 
25f3 : ad e2 9f LDA $9fe2 ; (min_dist2 + 0)
25f6 : 85 14 __ STA P7 
25f8 : a6 4f __ LDX T5 + 0 
25fa : bd 00 44 LDA $4400,x ; (rooms + 0)
25fd : 85 4b __ STA T1 + 0 
25ff : 38 __ __ SEC
2600 : e9 02 __ SBC #$02
2602 : 90 1f __ BCC $2623 ; (draw_rule_based_corridor.s17 + 0)
.s1011:
2604 : cd eb 9f CMP $9feb ; (screen_offset + 1)
2607 : d0 1a __ BNE $2623 ; (draw_rule_based_corridor.s17 + 0)
.s16:
; 270, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2609 : c6 4b __ DEC T1 + 0 
.s39:
; 272, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
260b : a5 4b __ LDA T1 + 0 
260d : 8d e1 9f STA $9fe1 ; (search_x1 + 0)
.s18:
; 279, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2610 : 20 49 24 JSR $2449 ; (place_door.s0 + 0)
; 280, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2613 : ad e1 9f LDA $9fe1 ; (search_x1 + 0)
2616 : 85 13 __ STA P6 
2618 : ad e0 9f LDA $9fe0 ; (grid_positions + 15)
261b : 85 14 __ STA P7 
261d : 20 49 24 JSR $2449 ; (place_door.s0 + 0)
; 282, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2620 : a9 01 __ LDA #$01
.s1001:
2622 : 60 __ __ RTS
.s17:
; 271, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2623 : bd 02 44 LDA $4402,x ; (rooms + 2)
2626 : 18 __ __ CLC
2627 : 65 4b __ ADC T1 + 0 
2629 : 85 4b __ STA T1 + 0 
262b : a9 00 __ LDA #$00
262d : 2a __ __ ROL
262e : a8 __ __ TAY
262f : a5 4b __ LDA T1 + 0 
2631 : 69 01 __ ADC #$01
2633 : 85 4c __ STA T2 + 0 
2635 : 98 __ __ TYA
2636 : 69 00 __ ADC #$00
2638 : d0 07 __ BNE $2641 ; (draw_rule_based_corridor.s20 + 0)
.s1008:
263a : a5 4c __ LDA T2 + 0 
263c : cd eb 9f CMP $9feb ; (screen_offset + 1)
263f : f0 ca __ BEQ $260b ; (draw_rule_based_corridor.s39 + 0)
.s20:
; 273, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2641 : bd 01 44 LDA $4401,x ; (rooms + 1)
2644 : 85 4a __ STA T0 + 0 
2646 : 38 __ __ SEC
2647 : e9 02 __ SBC #$02
2649 : 90 05 __ BCC $2650 ; (draw_rule_based_corridor.s23 + 0)
.s1005:
264b : cd ea 9f CMP $9fea ; (check_y + 0)
264e : f0 23 __ BEQ $2673 ; (draw_rule_based_corridor.s22 + 0)
.s23:
; 275, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2650 : bd 03 44 LDA $4403,x ; (rooms + 3)
2653 : 18 __ __ CLC
2654 : 65 4a __ ADC T0 + 0 
2656 : 85 4a __ STA T0 + 0 
2658 : a9 00 __ LDA #$00
265a : 2a __ __ ROL
265b : a8 __ __ TAY
265c : a5 4a __ LDA T0 + 0 
265e : 69 01 __ ADC #$01
2660 : aa __ __ TAX
2661 : 98 __ __ TYA
2662 : 69 00 __ ADC #$00
2664 : d0 aa __ BNE $2610 ; (draw_rule_based_corridor.s18 + 0)
.s1002:
2666 : ec ea 9f CPX $9fea ; (check_y + 0)
2669 : d0 a5 __ BNE $2610 ; (draw_rule_based_corridor.s18 + 0)
.s40:
; 276, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
266b : a5 4a __ LDA T0 + 0 
266d : 8d e0 9f STA $9fe0 ; (grid_positions + 15)
2670 : 4c 10 26 JMP $2610 ; (draw_rule_based_corridor.s18 + 0)
.s22:
; 274, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2673 : c6 4a __ DEC T0 + 0 
2675 : 4c 6b 26 JMP $266b ; (draw_rule_based_corridor.s40 + 0)
--------------------------------------------------------------------
straight_corridor_path: ; straight_corridor_path(i8,i8,i8,i8,u8)->void
.s0:
; 159, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2678 : a5 15 __ LDA P8 ; (sx + 0)
267a : 8d ef 9f STA $9fef ; (screen_pos + 1)
; 160, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
267d : a5 16 __ LDA P9 ; (sy + 0)
267f : 8d ee 9f STA $9fee ; (entropy4 + 1)
; 161, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2682 : ad fa 9f LDA $9ffa ; (sstack + 0)
2685 : f0 03 __ BEQ $268a ; (straight_corridor_path.s55 + 0)
2687 : 4c 56 27 JMP $2756 ; (straight_corridor_path.s53 + 0)
.s55:
; 190, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
268a : a5 18 __ LDA P11 ; (ey + 0)
268c : 85 48 __ STA T5 + 0 
.l28:
268e : a5 16 __ LDA P9 ; (sy + 0)
2690 : c5 48 __ CMP T5 + 0 
2692 : d0 07 __ BNE $269b ; (straight_corridor_path.s29 + 0)
.s54:
; 203, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2694 : a5 17 __ LDA P10 ; (ex + 0)
2696 : 85 16 __ STA P9 ; (sy + 0)
2698 : 4c f5 26 JMP $26f5 ; (straight_corridor_path.l40 + 0)
.s29:
; 191, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
269b : ad ee 9f LDA $9fee ; (entropy4 + 1)
269e : c5 48 __ CMP T5 + 0 
26a0 : f0 0a __ BEQ $26ac ; (straight_corridor_path.s32 + 0)
.s1005:
26a2 : 45 48 __ EOR T5 + 0 
26a4 : 90 04 __ BCC $26aa ; (straight_corridor_path.s1006 + 0)
.s1007:
26a6 : 10 04 __ BPL $26ac ; (straight_corridor_path.s32 + 0)
26a8 : 30 0b __ BMI $26b5 ; (straight_corridor_path.s31 + 0)
.s1006:
26aa : 10 09 __ BPL $26b5 ; (straight_corridor_path.s31 + 0)
.s32:
; 192, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26ac : ad ee 9f LDA $9fee ; (entropy4 + 1)
26af : 18 __ __ CLC
26b0 : 69 ff __ ADC #$ff
26b2 : 4c bb 26 JMP $26bb ; (straight_corridor_path.s33 + 0)
.s31:
; 191, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26b5 : ad ee 9f LDA $9fee ; (entropy4 + 1)
26b8 : 18 __ __ CLC
26b9 : 69 01 __ ADC #$01
.s33:
; 192, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26bb : 85 14 __ STA P7 
26bd : 8d ee 9f STA $9fee ; (entropy4 + 1)
; 193, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26c0 : a5 15 __ LDA P8 ; (sx + 0)
26c2 : 85 13 __ STA P6 
26c4 : 20 9d 22 JSR $229d ; (can_place_corridor_tile.s0 + 0)
26c7 : aa __ __ TAX
26c8 : a5 14 __ LDA P7 
26ca : 85 16 __ STA P9 ; (sy + 0)
26cc : 8a __ __ TXA
26cd : f0 bf __ BEQ $268e ; (straight_corridor_path.l28 + 0)
.s34:
; 194, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26cf : a5 15 __ LDA P8 ; (sx + 0)
26d1 : 85 10 __ STA P3 
26d3 : a5 14 __ LDA P7 
26d5 : 85 11 __ STA P4 
26d7 : a9 02 __ LDA #$02
26d9 : 85 12 __ STA P5 
26db : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
; 195, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26de : ae 28 45 LDX $4528 ; (corridor_path_static + 40)
26e1 : e0 14 __ CPX #$14
26e3 : b0 a9 __ BCS $268e ; (straight_corridor_path.l28 + 0)
.s37:
; 196, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26e5 : a5 13 __ LDA P6 
26e7 : 9d 00 45 STA $4500,x ; (corridor_path_static + 0)
; 197, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26ea : a5 14 __ LDA P7 
26ec : 9d 14 45 STA $4514,x ; (corridor_path_static + 20)
; 198, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26ef : e8 __ __ INX
26f0 : 8e 28 45 STX $4528 ; (corridor_path_static + 40)
26f3 : 90 99 __ BCC $268e ; (straight_corridor_path.l28 + 0)
.l40:
; 203, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26f5 : a5 15 __ LDA P8 ; (sx + 0)
26f7 : c5 16 __ CMP P9 ; (sy + 0)
26f9 : f0 5a __ BEQ $2755 ; (straight_corridor_path.s1001 + 0)
.s41:
; 204, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
26fb : ad ef 9f LDA $9fef ; (screen_pos + 1)
26fe : c5 16 __ CMP P9 ; (sy + 0)
2700 : f0 0a __ BEQ $270c ; (straight_corridor_path.s44 + 0)
.s1002:
2702 : 45 16 __ EOR P9 ; (sy + 0)
2704 : 90 04 __ BCC $270a ; (straight_corridor_path.s1003 + 0)
.s1004:
2706 : 10 04 __ BPL $270c ; (straight_corridor_path.s44 + 0)
2708 : 30 0b __ BMI $2715 ; (straight_corridor_path.s43 + 0)
.s1003:
270a : 10 09 __ BPL $2715 ; (straight_corridor_path.s43 + 0)
.s44:
; 205, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
270c : ad ef 9f LDA $9fef ; (screen_pos + 1)
270f : 18 __ __ CLC
2710 : 69 ff __ ADC #$ff
2712 : 4c 1b 27 JMP $271b ; (straight_corridor_path.s45 + 0)
.s43:
; 204, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2715 : ad ef 9f LDA $9fef ; (screen_pos + 1)
2718 : 18 __ __ CLC
2719 : 69 01 __ ADC #$01
.s45:
; 205, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
271b : 8d ef 9f STA $9fef ; (screen_pos + 1)
; 206, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
271e : 85 13 __ STA P6 
2720 : 85 15 __ STA P8 ; (sx + 0)
2722 : ad ee 9f LDA $9fee ; (entropy4 + 1)
2725 : 85 49 __ STA T6 + 0 
2727 : 85 14 __ STA P7 
2729 : 20 9d 22 JSR $229d ; (can_place_corridor_tile.s0 + 0)
272c : aa __ __ TAX
272d : f0 c6 __ BEQ $26f5 ; (straight_corridor_path.l40 + 0)
.s46:
; 207, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
272f : a5 13 __ LDA P6 
2731 : 85 10 __ STA P3 
2733 : a5 49 __ LDA T6 + 0 
2735 : 85 11 __ STA P4 
2737 : a9 02 __ LDA #$02
2739 : 85 12 __ STA P5 
273b : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
; 208, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
273e : ae 28 45 LDX $4528 ; (corridor_path_static + 40)
2741 : e0 14 __ CPX #$14
2743 : b0 b0 __ BCS $26f5 ; (straight_corridor_path.l40 + 0)
.s49:
; 209, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2745 : a5 13 __ LDA P6 
2747 : 9d 00 45 STA $4500,x ; (corridor_path_static + 0)
; 210, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
274a : a5 49 __ LDA T6 + 0 
274c : 9d 14 45 STA $4514,x ; (corridor_path_static + 20)
; 211, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
274f : e8 __ __ INX
2750 : 8e 28 45 STX $4528 ; (corridor_path_static + 40)
2753 : 90 a0 __ BCC $26f5 ; (straight_corridor_path.l40 + 0)
.s1001:
; 216, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2755 : 60 __ __ RTS
.s53:
; 163, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2756 : a5 17 __ LDA P10 ; (ex + 0)
2758 : 85 48 __ STA T5 + 0 
.l4:
275a : a5 15 __ LDA P8 ; (sx + 0)
275c : c5 48 __ CMP T5 + 0 
275e : d0 60 __ BNE $27c0 ; (straight_corridor_path.s5 + 0)
.l16:
; 176, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2760 : a5 16 __ LDA P9 ; (sy + 0)
2762 : c5 18 __ CMP P11 ; (ey + 0)
2764 : f0 ef __ BEQ $2755 ; (straight_corridor_path.s1001 + 0)
.s17:
; 177, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2766 : ad ee 9f LDA $9fee ; (entropy4 + 1)
2769 : c5 18 __ CMP P11 ; (ey + 0)
276b : f0 0a __ BEQ $2777 ; (straight_corridor_path.s20 + 0)
.s1008:
276d : 45 18 __ EOR P11 ; (ey + 0)
276f : 90 04 __ BCC $2775 ; (straight_corridor_path.s1009 + 0)
.s1010:
2771 : 10 04 __ BPL $2777 ; (straight_corridor_path.s20 + 0)
2773 : 30 0b __ BMI $2780 ; (straight_corridor_path.s19 + 0)
.s1009:
2775 : 10 09 __ BPL $2780 ; (straight_corridor_path.s19 + 0)
.s20:
; 178, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2777 : ad ee 9f LDA $9fee ; (entropy4 + 1)
277a : 18 __ __ CLC
277b : 69 ff __ ADC #$ff
277d : 4c 86 27 JMP $2786 ; (straight_corridor_path.s21 + 0)
.s19:
; 177, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2780 : ad ee 9f LDA $9fee ; (entropy4 + 1)
2783 : 18 __ __ CLC
2784 : 69 01 __ ADC #$01
.s21:
; 178, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2786 : 85 16 __ STA P9 ; (sy + 0)
2788 : 8d ee 9f STA $9fee ; (entropy4 + 1)
; 179, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
278b : 85 14 __ STA P7 
278d : ad ef 9f LDA $9fef ; (screen_pos + 1)
2790 : 85 48 __ STA T5 + 0 
2792 : 85 13 __ STA P6 
2794 : 20 9d 22 JSR $229d ; (can_place_corridor_tile.s0 + 0)
2797 : aa __ __ TAX
2798 : f0 c6 __ BEQ $2760 ; (straight_corridor_path.l16 + 0)
.s22:
; 180, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
279a : a5 48 __ LDA T5 + 0 
279c : 85 10 __ STA P3 
279e : a5 16 __ LDA P9 ; (sy + 0)
27a0 : 85 11 __ STA P4 
27a2 : a9 02 __ LDA #$02
27a4 : 85 12 __ STA P5 
27a6 : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
; 181, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
27a9 : ae 28 45 LDX $4528 ; (corridor_path_static + 40)
27ac : e0 14 __ CPX #$14
27ae : b0 b0 __ BCS $2760 ; (straight_corridor_path.l16 + 0)
.s25:
; 182, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
27b0 : a5 48 __ LDA T5 + 0 
27b2 : 9d 00 45 STA $4500,x ; (corridor_path_static + 0)
; 183, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
27b5 : a5 14 __ LDA P7 
27b7 : 9d 14 45 STA $4514,x ; (corridor_path_static + 20)
; 184, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
27ba : e8 __ __ INX
27bb : 8e 28 45 STX $4528 ; (corridor_path_static + 40)
27be : 90 a0 __ BCC $2760 ; (straight_corridor_path.l16 + 0)
.s5:
; 164, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
27c0 : ad ef 9f LDA $9fef ; (screen_pos + 1)
27c3 : c5 48 __ CMP T5 + 0 
27c5 : f0 0a __ BEQ $27d1 ; (straight_corridor_path.s8 + 0)
.s1011:
27c7 : 45 48 __ EOR T5 + 0 
27c9 : 90 04 __ BCC $27cf ; (straight_corridor_path.s1012 + 0)
.s1013:
27cb : 10 04 __ BPL $27d1 ; (straight_corridor_path.s8 + 0)
27cd : 30 0b __ BMI $27da ; (straight_corridor_path.s7 + 0)
.s1012:
27cf : 10 09 __ BPL $27da ; (straight_corridor_path.s7 + 0)
.s8:
; 165, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
27d1 : ad ef 9f LDA $9fef ; (screen_pos + 1)
27d4 : 18 __ __ CLC
27d5 : 69 ff __ ADC #$ff
27d7 : 4c e0 27 JMP $27e0 ; (straight_corridor_path.s9 + 0)
.s7:
; 164, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
27da : ad ef 9f LDA $9fef ; (screen_pos + 1)
27dd : 18 __ __ CLC
27de : 69 01 __ ADC #$01
.s9:
; 165, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
27e0 : 8d ef 9f STA $9fef ; (screen_pos + 1)
; 166, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
27e3 : 85 13 __ STA P6 
27e5 : a5 16 __ LDA P9 ; (sy + 0)
27e7 : 85 14 __ STA P7 
27e9 : 20 9d 22 JSR $229d ; (can_place_corridor_tile.s0 + 0)
27ec : a8 __ __ TAY
27ed : a6 13 __ LDX P6 
27ef : 86 15 __ STX P8 ; (sx + 0)
27f1 : 98 __ __ TYA
27f2 : d0 03 __ BNE $27f7 ; (straight_corridor_path.s10 + 0)
27f4 : 4c 5a 27 JMP $275a ; (straight_corridor_path.l4 + 0)
.s10:
; 167, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
27f7 : 86 10 __ STX P3 
27f9 : a5 16 __ LDA P9 ; (sy + 0)
27fb : 85 11 __ STA P4 
27fd : a9 02 __ LDA #$02
27ff : 85 12 __ STA P5 
2801 : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
; 168, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2804 : ae 28 45 LDX $4528 ; (corridor_path_static + 40)
2807 : e0 14 __ CPX #$14
2809 : b0 e9 __ BCS $27f4 ; (straight_corridor_path.s9 + 20)
.s13:
; 169, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
280b : a5 13 __ LDA P6 
280d : 9d 00 45 STA $4500,x ; (corridor_path_static + 0)
; 170, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2810 : a5 14 __ LDA P7 
2812 : 9d 14 45 STA $4514,x ; (corridor_path_static + 20)
; 171, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/rule_based_connection_system.c"
2815 : e8 __ __ INX
2816 : 8e 28 45 STX $4528 ; (corridor_path_static + 40)
2819 : 4c 5a 27 JMP $275a ; (straight_corridor_path.l4 + 0)
--------------------------------------------------------------------
add_walls: ; add_walls()->void
.s0:
;  23, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
281c : a9 09 __ LDA #$09
281e : 85 0e __ STA P1 
2820 : a9 2c __ LDA #$2c
2822 : 85 0f __ STA P2 
2824 : 20 f6 0f JSR $0ff6 ; (print_text.s0 + 0)
;  26, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2827 : a9 00 __ LDA #$00
2829 : 8d ee 9f STA $9fee ; (entropy4 + 1)
.l2:
;  27, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
282c : a9 00 __ LDA #$00
282e : 8d ef 9f STA $9fef ; (screen_pos + 1)
.l6:
;  28, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2831 : 85 4b __ STA T3 + 0 
2833 : 85 0f __ STA P2 
2835 : ad ee 9f LDA $9fee ; (entropy4 + 1)
2838 : 85 4c __ STA T4 + 0 
283a : 85 10 __ STA P3 
283c : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
283f : a5 1b __ LDA ACCU + 0 
2841 : 8d ed 9f STA $9fed ; (highest_priority + 0)
;  30, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2844 : c9 02 __ CMP #$02
2846 : f0 07 __ BEQ $284f ; (add_walls.s9 + 0)
.s12:
2848 : c9 03 __ CMP #$03
284a : f0 03 __ BEQ $284f ; (add_walls.s9 + 0)
284c : 4c df 28 JMP $28df ; (add_walls.s5 + 0)
.s9:
;  33, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
284f : a5 4c __ LDA T4 + 0 
2851 : 85 48 __ STA T0 + 0 
2853 : f0 1e __ BEQ $2873 ; (add_walls.s15 + 0)
.s16:
2855 : aa __ __ TAX
2856 : ca __ __ DEX
2857 : 86 49 __ STX T1 + 0 
2859 : 86 10 __ STX P3 
285b : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
285e : a5 1b __ LDA ACCU + 0 
2860 : d0 0f __ BNE $2871 ; (add_walls.s1002 + 0)
.s13:
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2862 : a5 0f __ LDA P2 
2864 : 85 10 __ STA P3 
2866 : a5 49 __ LDA T1 + 0 
2868 : 85 11 __ STA P4 
286a : a9 01 __ LDA #$01
286c : 85 12 __ STA P5 
286e : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
.s1002:
;  37, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2871 : a5 4c __ LDA T4 + 0 
.s15:
2873 : c9 3f __ CMP #$3f
2875 : b0 20 __ BCS $2897 ; (add_walls.s19 + 0)
.s20:
2877 : a5 4b __ LDA T3 + 0 
2879 : 85 0f __ STA P2 
287b : e6 48 __ INC T0 + 0 
287d : a5 48 __ LDA T0 + 0 
287f : 85 10 __ STA P3 
2881 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2884 : a5 1b __ LDA ACCU + 0 
2886 : d0 0f __ BNE $2897 ; (add_walls.s19 + 0)
.s17:
;  38, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2888 : a5 0f __ LDA P2 
288a : 85 10 __ STA P3 
288c : a5 48 __ LDA T0 + 0 
288e : 85 11 __ STA P4 
2890 : a9 01 __ LDA #$01
2892 : 85 12 __ STA P5 
2894 : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
.s19:
;  41, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2897 : a5 4b __ LDA T3 + 0 
2899 : f0 1f __ BEQ $28ba ; (add_walls.s23 + 0)
.s24:
289b : a6 4c __ LDX T4 + 0 
289d : 86 10 __ STX P3 
289f : 38 __ __ SEC
28a0 : e9 01 __ SBC #$01
28a2 : 85 0f __ STA P2 
28a4 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
28a7 : a5 1b __ LDA ACCU + 0 
28a9 : d0 0f __ BNE $28ba ; (add_walls.s23 + 0)
.s21:
;  42, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
28ab : a5 0f __ LDA P2 
28ad : 85 10 __ STA P3 
28af : a5 4c __ LDA T4 + 0 
28b1 : 85 11 __ STA P4 
28b3 : a9 01 __ LDA #$01
28b5 : 85 12 __ STA P5 
28b7 : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
.s23:
;  45, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
28ba : a6 4b __ LDX T3 + 0 
28bc : e0 3f __ CPX #$3f
28be : b0 1f __ BCS $28df ; (add_walls.s5 + 0)
.s28:
28c0 : e8 __ __ INX
28c1 : 86 48 __ STX T0 + 0 
28c3 : 86 0f __ STX P2 
28c5 : a5 4c __ LDA T4 + 0 
28c7 : 85 10 __ STA P3 
28c9 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
28cc : a5 1b __ LDA ACCU + 0 
28ce : d0 0f __ BNE $28df ; (add_walls.s5 + 0)
.s25:
;  46, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
28d0 : a5 48 __ LDA T0 + 0 
28d2 : 85 10 __ STA P3 
28d4 : a5 4c __ LDA T4 + 0 
28d6 : 85 11 __ STA P4 
28d8 : a9 01 __ LDA #$01
28da : 85 12 __ STA P5 
28dc : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
.s5:
;  27, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
28df : 18 __ __ CLC
28e0 : a5 4b __ LDA T3 + 0 
28e2 : 69 01 __ ADC #$01
28e4 : 8d ef 9f STA $9fef ; (screen_pos + 1)
28e7 : c9 40 __ CMP #$40
28e9 : b0 03 __ BCS $28ee ; (add_walls.s8 + 0)
28eb : 4c 31 28 JMP $2831 ; (add_walls.l6 + 0)
.s8:
;  50, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
28ee : a5 4c __ LDA T4 + 0 
28f0 : 29 0f __ AND #$0f
28f2 : d0 0b __ BNE $28ff ; (add_walls.s1 + 0)
.s29:
28f4 : a9 25 __ LDA #$25
28f6 : 85 0e __ STA P1 
28f8 : a9 17 __ LDA #$17
28fa : 85 0f __ STA P2 
28fc : 20 f6 0f JSR $0ff6 ; (print_text.s0 + 0)
.s1:
;  26, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
28ff : 18 __ __ CLC
2900 : a5 4c __ LDA T4 + 0 
2902 : 69 01 __ ADC #$01
2904 : 8d ee 9f STA $9fee ; (entropy4 + 1)
2907 : c9 40 __ CMP #$40
2909 : b0 03 __ BCS $290e ; (add_walls.s4 + 0)
290b : 4c 2c 28 JMP $282c ; (add_walls.l2 + 0)
.s4:
;  54, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
290e : a9 01 __ LDA #$01
2910 : 8d ee 9f STA $9fee ; (entropy4 + 1)
.l33:
;  55, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2913 : a9 01 __ LDA #$01
2915 : 8d ef 9f STA $9fef ; (screen_pos + 1)
.l37:
;  56, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2918 : 85 4e __ STA T6 + 0 
291a : 85 0f __ STA P2 
291c : ad ee 9f LDA $9fee ; (entropy4 + 1)
291f : 85 4f __ STA T7 + 0 
2921 : 85 10 __ STA P3 
2923 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2926 : a5 1b __ LDA ACCU + 0 
2928 : 8d ec 9f STA $9fec ; (dy + 0)
;  57, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
292b : c9 02 __ CMP #$02
292d : f0 1c __ BEQ $294b ; (add_walls.s40 + 0)
.s43:
292f : c9 03 __ CMP #$03
2931 : f0 18 __ BEQ $294b ; (add_walls.s40 + 0)
.s36:
;  55, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2933 : 18 __ __ CLC
2934 : a5 4e __ LDA T6 + 0 
2936 : 69 01 __ ADC #$01
2938 : 8d ef 9f STA $9fef ; (screen_pos + 1)
293b : c9 3f __ CMP #$3f
293d : 90 d9 __ BCC $2918 ; (add_walls.l37 + 0)
.s34:
;  54, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
293f : a5 4f __ LDA T7 + 0 
2941 : 69 00 __ ADC #$00
2943 : 8d ee 9f STA $9fee ; (entropy4 + 1)
2946 : c9 3f __ CMP #$3f
2948 : 90 c9 __ BCC $2913 ; (add_walls.l33 + 0)
.s1001:
; 103, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
294a : 60 __ __ RTS
.s40:
;  59, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
294b : a6 0f __ LDX P2 
294d : e8 __ __ INX
294e : 86 4a __ STX T2 + 0 
2950 : 86 0f __ STX P2 
2952 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2955 : a6 1b __ LDX ACCU + 0 
2957 : ca __ __ DEX
2958 : d0 2d __ BNE $2987 ; (add_walls.s46 + 0)
.s48:
295a : a5 4e __ LDA T6 + 0 
295c : 85 0f __ STA P2 
295e : a6 4f __ LDX T7 + 0 
2960 : e8 __ __ INX
2961 : 86 48 __ STX T0 + 0 
2963 : 86 10 __ STX P3 
2965 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2968 : a6 1b __ LDX ACCU + 0 
296a : ca __ __ DEX
296b : d0 1a __ BNE $2987 ; (add_walls.s46 + 0)
.s47:
296d : a5 4a __ LDA T2 + 0 
296f : 85 0f __ STA P2 
2971 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2974 : a5 1b __ LDA ACCU + 0 
2976 : d0 0f __ BNE $2987 ; (add_walls.s46 + 0)
.s44:
;  60, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2978 : a5 0f __ LDA P2 
297a : 85 10 __ STA P3 
297c : a5 48 __ LDA T0 + 0 
297e : 85 11 __ STA P4 
2980 : a9 06 __ LDA #$06
2982 : 85 12 __ STA P5 
2984 : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
.s46:
;  62, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2987 : a5 4f __ LDA T7 + 0 
2989 : 85 10 __ STA P3 
298b : a6 4e __ LDX T6 + 0 
298d : ca __ __ DEX
298e : 86 4b __ STX T3 + 0 
2990 : 86 0f __ STX P2 
2992 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2995 : a6 1b __ LDX ACCU + 0 
2997 : ca __ __ DEX
2998 : d0 2d __ BNE $29c7 ; (add_walls.s51 + 0)
.s53:
299a : a5 4e __ LDA T6 + 0 
299c : 85 0f __ STA P2 
299e : a6 4f __ LDX T7 + 0 
29a0 : e8 __ __ INX
29a1 : 86 48 __ STX T0 + 0 
29a3 : 86 10 __ STX P3 
29a5 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
29a8 : a6 1b __ LDX ACCU + 0 
29aa : ca __ __ DEX
29ab : d0 1a __ BNE $29c7 ; (add_walls.s51 + 0)
.s52:
29ad : a5 4b __ LDA T3 + 0 
29af : 85 0f __ STA P2 
29b1 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
29b4 : a5 1b __ LDA ACCU + 0 
29b6 : d0 0f __ BNE $29c7 ; (add_walls.s51 + 0)
.s49:
;  63, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
29b8 : a5 0f __ LDA P2 
29ba : 85 10 __ STA P3 
29bc : a5 48 __ LDA T0 + 0 
29be : 85 11 __ STA P4 
29c0 : a9 06 __ LDA #$06
29c2 : 85 12 __ STA P5 
29c4 : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
.s51:
;  65, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
29c7 : a5 4a __ LDA T2 + 0 
29c9 : 85 0f __ STA P2 
29cb : a5 4f __ LDA T7 + 0 
29cd : 85 10 __ STA P3 
29cf : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
29d2 : a6 1b __ LDX ACCU + 0 
29d4 : ca __ __ DEX
29d5 : d0 2d __ BNE $2a04 ; (add_walls.s56 + 0)
.s58:
29d7 : a5 4e __ LDA T6 + 0 
29d9 : 85 0f __ STA P2 
29db : a6 4f __ LDX T7 + 0 
29dd : ca __ __ DEX
29de : 86 48 __ STX T0 + 0 
29e0 : c6 10 __ DEC P3 
29e2 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
29e5 : a6 1b __ LDX ACCU + 0 
29e7 : ca __ __ DEX
29e8 : d0 1a __ BNE $2a04 ; (add_walls.s56 + 0)
.s57:
29ea : a5 4a __ LDA T2 + 0 
29ec : 85 0f __ STA P2 
29ee : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
29f1 : a5 1b __ LDA ACCU + 0 
29f3 : d0 0f __ BNE $2a04 ; (add_walls.s56 + 0)
.s54:
;  66, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
29f5 : a5 0f __ LDA P2 
29f7 : 85 10 __ STA P3 
29f9 : a5 48 __ LDA T0 + 0 
29fb : 85 11 __ STA P4 
29fd : a9 06 __ LDA #$06
29ff : 85 12 __ STA P5 
2a01 : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
.s56:
;  68, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2a04 : a5 4b __ LDA T3 + 0 
2a06 : 85 0f __ STA P2 
2a08 : a5 4f __ LDA T7 + 0 
2a0a : 85 10 __ STA P3 
2a0c : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2a0f : a6 1b __ LDX ACCU + 0 
2a11 : ca __ __ DEX
2a12 : d0 2d __ BNE $2a41 ; (add_walls.s61 + 0)
.s63:
2a14 : a5 4e __ LDA T6 + 0 
2a16 : 85 0f __ STA P2 
2a18 : a6 4f __ LDX T7 + 0 
2a1a : ca __ __ DEX
2a1b : 86 48 __ STX T0 + 0 
2a1d : c6 10 __ DEC P3 
2a1f : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2a22 : a6 1b __ LDX ACCU + 0 
2a24 : ca __ __ DEX
2a25 : d0 1a __ BNE $2a41 ; (add_walls.s61 + 0)
.s62:
2a27 : a5 4b __ LDA T3 + 0 
2a29 : 85 0f __ STA P2 
2a2b : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2a2e : a5 1b __ LDA ACCU + 0 
2a30 : d0 0f __ BNE $2a41 ; (add_walls.s61 + 0)
.s59:
;  69, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2a32 : a5 0f __ LDA P2 
2a34 : 85 10 __ STA P3 
2a36 : a5 48 __ LDA T0 + 0 
2a38 : 85 11 __ STA P4 
2a3a : a9 06 __ LDA #$06
2a3c : 85 12 __ STA P5 
2a3e : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
.s61:
;  73, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2a41 : a5 4a __ LDA T2 + 0 
2a43 : 85 0f __ STA P2 
2a45 : a5 4f __ LDA T7 + 0 
2a47 : 85 10 __ STA P3 
2a49 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2a4c : a5 1b __ LDA ACCU + 0 
2a4e : c9 02 __ CMP #$02
2a50 : f0 09 __ BEQ $2a5b ; (add_walls.s70 + 0)
.s71:
2a52 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2a55 : a5 1b __ LDA ACCU + 0 
2a57 : c9 03 __ CMP #$03
2a59 : d0 58 __ BNE $2ab3 ; (add_walls.s66 + 0)
.s70:
;  74, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2a5b : a5 4e __ LDA T6 + 0 
2a5d : 85 0f __ STA P2 
2a5f : a6 4f __ LDX T7 + 0 
2a61 : e8 __ __ INX
2a62 : 86 4c __ STX T4 + 0 
2a64 : 86 10 __ STX P3 
2a66 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2a69 : a5 1b __ LDA ACCU + 0 
2a6b : c9 02 __ CMP #$02
2a6d : f0 09 __ BEQ $2a78 ; (add_walls.s69 + 0)
.s72:
2a6f : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2a72 : a5 1b __ LDA ACCU + 0 
2a74 : c9 03 __ CMP #$03
2a76 : d0 3b __ BNE $2ab3 ; (add_walls.s66 + 0)
.s69:
;  75, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2a78 : a5 4a __ LDA T2 + 0 
2a7a : 85 0f __ STA P2 
2a7c : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2a7f : a6 1b __ LDX ACCU + 0 
2a81 : ca __ __ DEX
2a82 : d0 2f __ BNE $2ab3 ; (add_walls.s66 + 0)
.s68:
;  76, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2a84 : 18 __ __ CLC
2a85 : a5 4e __ LDA T6 + 0 
2a87 : 69 02 __ ADC #$02
2a89 : 85 0f __ STA P2 
2a8b : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2a8e : a6 1b __ LDX ACCU + 0 
2a90 : ca __ __ DEX
2a91 : d0 20 __ BNE $2ab3 ; (add_walls.s66 + 0)
.s67:
2a93 : a5 4a __ LDA T2 + 0 
2a95 : 85 0f __ STA P2 
2a97 : a6 4c __ LDX T4 + 0 
2a99 : e8 __ __ INX
2a9a : 86 10 __ STX P3 
2a9c : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2a9f : a6 1b __ LDX ACCU + 0 
2aa1 : ca __ __ DEX
2aa2 : d0 0f __ BNE $2ab3 ; (add_walls.s66 + 0)
.s64:
;  77, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2aa4 : a5 0f __ LDA P2 
2aa6 : 85 10 __ STA P3 
2aa8 : a5 4c __ LDA T4 + 0 
2aaa : 85 11 __ STA P4 
2aac : a9 06 __ LDA #$06
2aae : 85 12 __ STA P5 
2ab0 : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
.s66:
;  80, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2ab3 : a5 4b __ LDA T3 + 0 
2ab5 : 85 0f __ STA P2 
2ab7 : a5 4f __ LDA T7 + 0 
2ab9 : 85 10 __ STA P3 
2abb : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2abe : a5 1b __ LDA ACCU + 0 
2ac0 : c9 02 __ CMP #$02
2ac2 : f0 09 __ BEQ $2acd ; (add_walls.s79 + 0)
.s80:
2ac4 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2ac7 : a5 1b __ LDA ACCU + 0 
2ac9 : c9 03 __ CMP #$03
2acb : d0 58 __ BNE $2b25 ; (add_walls.s75 + 0)
.s79:
;  81, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2acd : a5 4e __ LDA T6 + 0 
2acf : 85 0f __ STA P2 
2ad1 : a6 4f __ LDX T7 + 0 
2ad3 : e8 __ __ INX
2ad4 : 86 4c __ STX T4 + 0 
2ad6 : 86 10 __ STX P3 
2ad8 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2adb : a5 1b __ LDA ACCU + 0 
2add : c9 02 __ CMP #$02
2adf : f0 09 __ BEQ $2aea ; (add_walls.s78 + 0)
.s81:
2ae1 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2ae4 : a5 1b __ LDA ACCU + 0 
2ae6 : c9 03 __ CMP #$03
2ae8 : d0 3b __ BNE $2b25 ; (add_walls.s75 + 0)
.s78:
;  82, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2aea : a5 4b __ LDA T3 + 0 
2aec : 85 0f __ STA P2 
2aee : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2af1 : a6 1b __ LDX ACCU + 0 
2af3 : ca __ __ DEX
2af4 : d0 2f __ BNE $2b25 ; (add_walls.s75 + 0)
.s77:
;  83, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2af6 : 38 __ __ SEC
2af7 : a5 4e __ LDA T6 + 0 
2af9 : e9 02 __ SBC #$02
2afb : 85 0f __ STA P2 
2afd : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2b00 : a6 1b __ LDX ACCU + 0 
2b02 : ca __ __ DEX
2b03 : d0 20 __ BNE $2b25 ; (add_walls.s75 + 0)
.s76:
2b05 : a5 4b __ LDA T3 + 0 
2b07 : 85 0f __ STA P2 
2b09 : a6 4c __ LDX T4 + 0 
2b0b : e8 __ __ INX
2b0c : 86 10 __ STX P3 
2b0e : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2b11 : a6 1b __ LDX ACCU + 0 
2b13 : ca __ __ DEX
2b14 : d0 0f __ BNE $2b25 ; (add_walls.s75 + 0)
.s73:
;  84, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2b16 : a5 0f __ LDA P2 
2b18 : 85 10 __ STA P3 
2b1a : a5 4c __ LDA T4 + 0 
2b1c : 85 11 __ STA P4 
2b1e : a9 06 __ LDA #$06
2b20 : 85 12 __ STA P5 
2b22 : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
.s75:
;  87, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2b25 : a5 4a __ LDA T2 + 0 
2b27 : 85 0f __ STA P2 
2b29 : a5 4f __ LDA T7 + 0 
2b2b : 85 10 __ STA P3 
2b2d : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2b30 : a5 1b __ LDA ACCU + 0 
2b32 : c9 02 __ CMP #$02
2b34 : f0 09 __ BEQ $2b3f ; (add_walls.s88 + 0)
.s89:
2b36 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2b39 : a5 1b __ LDA ACCU + 0 
2b3b : c9 03 __ CMP #$03
2b3d : d0 55 __ BNE $2b94 ; (add_walls.s84 + 0)
.s88:
;  88, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2b3f : a5 4e __ LDA T6 + 0 
2b41 : 85 0f __ STA P2 
2b43 : a6 4f __ LDX T7 + 0 
2b45 : ca __ __ DEX
2b46 : 86 4d __ STX T5 + 0 
2b48 : c6 10 __ DEC P3 
2b4a : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2b4d : a5 1b __ LDA ACCU + 0 
2b4f : c9 02 __ CMP #$02
2b51 : f0 09 __ BEQ $2b5c ; (add_walls.s87 + 0)
.s90:
2b53 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2b56 : a5 1b __ LDA ACCU + 0 
2b58 : c9 03 __ CMP #$03
2b5a : d0 38 __ BNE $2b94 ; (add_walls.s84 + 0)
.s87:
;  89, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2b5c : a5 4a __ LDA T2 + 0 
2b5e : 85 0f __ STA P2 
2b60 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2b63 : a6 1b __ LDX ACCU + 0 
2b65 : ca __ __ DEX
2b66 : d0 2c __ BNE $2b94 ; (add_walls.s84 + 0)
.s86:
;  90, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2b68 : 18 __ __ CLC
2b69 : a5 4e __ LDA T6 + 0 
2b6b : 69 02 __ ADC #$02
2b6d : 85 0f __ STA P2 
2b6f : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2b72 : a6 1b __ LDX ACCU + 0 
2b74 : ca __ __ DEX
2b75 : d0 1d __ BNE $2b94 ; (add_walls.s84 + 0)
.s85:
2b77 : a5 4a __ LDA T2 + 0 
2b79 : 85 0f __ STA P2 
2b7b : c6 10 __ DEC P3 
2b7d : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2b80 : a6 1b __ LDX ACCU + 0 
2b82 : ca __ __ DEX
2b83 : d0 0f __ BNE $2b94 ; (add_walls.s84 + 0)
.s82:
;  91, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2b85 : a5 0f __ LDA P2 
2b87 : 85 10 __ STA P3 
2b89 : a5 4d __ LDA T5 + 0 
2b8b : 85 11 __ STA P4 
2b8d : a9 06 __ LDA #$06
2b8f : 85 12 __ STA P5 
2b91 : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
.s84:
;  94, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2b94 : a5 4b __ LDA T3 + 0 
2b96 : 85 0f __ STA P2 
2b98 : a5 4f __ LDA T7 + 0 
2b9a : 85 10 __ STA P3 
2b9c : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2b9f : a5 1b __ LDA ACCU + 0 
2ba1 : c9 02 __ CMP #$02
2ba3 : f0 0c __ BEQ $2bb1 ; (add_walls.s97 + 0)
.s98:
2ba5 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2ba8 : a5 1b __ LDA ACCU + 0 
2baa : c9 03 __ CMP #$03
2bac : f0 03 __ BEQ $2bb1 ; (add_walls.s97 + 0)
2bae : 4c 33 29 JMP $2933 ; (add_walls.s36 + 0)
.s97:
;  95, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2bb1 : a5 4e __ LDA T6 + 0 
2bb3 : 85 0f __ STA P2 
2bb5 : a6 4f __ LDX T7 + 0 
2bb7 : ca __ __ DEX
2bb8 : 86 4c __ STX T4 + 0 
2bba : c6 10 __ DEC P3 
2bbc : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2bbf : a5 1b __ LDA ACCU + 0 
2bc1 : c9 02 __ CMP #$02
2bc3 : f0 09 __ BEQ $2bce ; (add_walls.s96 + 0)
.s99:
2bc5 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2bc8 : a5 1b __ LDA ACCU + 0 
2bca : c9 03 __ CMP #$03
2bcc : d0 e0 __ BNE $2bae ; (add_walls.s98 + 9)
.s96:
;  96, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2bce : a5 4b __ LDA T3 + 0 
2bd0 : 85 0f __ STA P2 
2bd2 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2bd5 : a6 1b __ LDX ACCU + 0 
2bd7 : ca __ __ DEX
2bd8 : d0 d4 __ BNE $2bae ; (add_walls.s98 + 9)
.s95:
;  97, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2bda : 38 __ __ SEC
2bdb : a5 4e __ LDA T6 + 0 
2bdd : e9 02 __ SBC #$02
2bdf : 85 0f __ STA P2 
2be1 : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2be4 : a6 1b __ LDX ACCU + 0 
2be6 : ca __ __ DEX
2be7 : d0 c5 __ BNE $2bae ; (add_walls.s98 + 9)
.s94:
2be9 : a5 4b __ LDA T3 + 0 
2beb : 85 0f __ STA P2 
2bed : c6 10 __ DEC P3 
2bef : 20 6b 1c JSR $1c6b ; (get_tile_raw.s0 + 0)
2bf2 : a6 1b __ LDX ACCU + 0 
2bf4 : ca __ __ DEX
2bf5 : d0 b7 __ BNE $2bae ; (add_walls.s98 + 9)
.s91:
;  98, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2bf7 : a5 0f __ LDA P2 
2bf9 : 85 10 __ STA P3 
2bfb : a5 4c __ LDA T4 + 0 
2bfd : 85 11 __ STA P4 
2bff : a9 06 __ LDA #$06
2c01 : 85 12 __ STA P5 
2c03 : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
2c06 : 4c 33 29 JMP $2933 ; (add_walls.s36 + 0)
--------------------------------------------------------------------
2c09 : __ __ __ BYT 0a 0a 50 6c 61 63 69 6e 67 20 77 61 6c 6c 73 00 : ..Placing walls.
--------------------------------------------------------------------
add_stairs: ; add_stairs()->void
.s0:
; 112, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2c19 : a9 2f __ LDA #$2f
2c1b : 85 0e __ STA P1 
2c1d : a9 2d __ LDA #$2d
2c1f : 85 0f __ STA P2 
2c21 : 20 f6 0f JSR $0ff6 ; (print_text.s0 + 0)
; 114, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2c24 : ad 92 35 LDA $3592 ; (room_count + 0)
2c27 : c9 02 __ CMP #$02
2c29 : b0 01 __ BCS $2c2c ; (add_stairs.s3 + 0)
2c2b : 60 __ __ RTS
.s3:
; 117, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2c2c : 85 4a __ STA T3 + 0 
2c2e : e9 01 __ SBC #$01
2c30 : 8d ee 9f STA $9fee ; (entropy4 + 1)
; 116, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2c33 : a9 17 __ LDA #$17
2c35 : 85 0f __ STA P2 
2c37 : a9 25 __ LDA #$25
2c39 : 85 0e __ STA P1 
2c3b : a9 00 __ LDA #$00
2c3d : 8d ef 9f STA $9fef ; (screen_pos + 1)
; 119, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2c40 : 8d ed 9f STA $9fed ; (highest_priority + 0)
; 120, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2c43 : 8d ec 9f STA $9fec ; (dy + 0)
.l6:
; 121, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2c46 : 85 4b __ STA T4 + 0 
2c48 : 29 03 __ AND #$03
2c4a : d0 03 __ BNE $2c4f ; (add_stairs.s11 + 0)
.s9:
2c4c : 20 f6 0f JSR $0ff6 ; (print_text.s0 + 0)
.s11:
; 120, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2c4f : a6 4b __ LDX T4 + 0 
2c51 : e8 __ __ INX
2c52 : 8e ec 9f STX $9fec ; (dy + 0)
; 122, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2c55 : a5 4b __ LDA T4 + 0 
2c57 : 0a __ __ ASL
2c58 : 0a __ __ ASL
2c59 : 0a __ __ ASL
2c5a : a8 __ __ TAY
2c5b : ad ed 9f LDA $9fed ; (highest_priority + 0)
2c5e : d9 07 44 CMP $4407,y ; (rooms + 7)
2c61 : b0 0b __ BCS $2c6e ; (add_stairs.s5 + 0)
.s12:
; 124, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2c63 : a5 4b __ LDA T4 + 0 
2c65 : 8d ef 9f STA $9fef ; (screen_pos + 1)
; 123, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2c68 : b9 07 44 LDA $4407,y ; (rooms + 7)
2c6b : 8d ed 9f STA $9fed ; (highest_priority + 0)
.s5:
; 120, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2c6e : ad ec 9f LDA $9fec ; (dy + 0)
2c71 : c5 4a __ CMP T3 + 0 
2c73 : 90 d1 __ BCC $2c46 ; (add_stairs.l6 + 0)
.s8:
; 129, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2c75 : a9 00 __ LDA #$00
2c77 : 8d eb 9f STA $9feb ; (screen_offset + 1)
; 130, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2c7a : 8d ea 9f STA $9fea ; (check_y + 0)
; 131, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2c7d : a2 25 __ LDX #$25
2c7f : 86 0e __ STX P1 
2c81 : a2 17 __ LDX #$17
2c83 : 86 0f __ STX P2 
.l16:
2c85 : 85 4b __ STA T4 + 0 
2c87 : 29 03 __ AND #$03
2c89 : d0 03 __ BNE $2c8e ; (add_stairs.s76 + 0)
.s19:
2c8b : 20 f6 0f JSR $0ff6 ; (print_text.s0 + 0)
.s76:
; 132, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2c8e : a5 4b __ LDA T4 + 0 
2c90 : cd ef 9f CMP $9fef ; (screen_pos + 1)
2c93 : f0 19 __ BEQ $2cae ; (add_stairs.s15 + 0)
.s25:
2c95 : 0a __ __ ASL
2c96 : 0a __ __ ASL
2c97 : 0a __ __ ASL
2c98 : a8 __ __ TAY
2c99 : ad eb 9f LDA $9feb ; (screen_offset + 1)
2c9c : d9 07 44 CMP $4407,y ; (rooms + 7)
2c9f : b0 0b __ BCS $2cac ; (add_stairs.s1002 + 0)
.s22:
; 134, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2ca1 : a5 4b __ LDA T4 + 0 
2ca3 : 8d ee 9f STA $9fee ; (entropy4 + 1)
; 133, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2ca6 : b9 07 44 LDA $4407,y ; (rooms + 7)
2ca9 : 8d eb 9f STA $9feb ; (screen_offset + 1)
.s1002:
; 130, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2cac : a5 4b __ LDA T4 + 0 
.s15:
2cae : 18 __ __ CLC
2caf : 69 01 __ ADC #$01
2cb1 : 8d ea 9f STA $9fea ; (check_y + 0)
2cb4 : c5 4a __ CMP T3 + 0 
2cb6 : 90 cd __ BCC $2c85 ; (add_stairs.l16 + 0)
.s18:
; 138, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2cb8 : ad ef 9f LDA $9fef ; (screen_pos + 1)
2cbb : 85 0d __ STA P0 
2cbd : a9 e9 __ LDA #$e9
2cbf : 85 0e __ STA P1 
2cc1 : a9 9f __ LDA #$9f
2cc3 : 85 11 __ STA P4 
2cc5 : a9 9f __ LDA #$9f
2cc7 : 85 0f __ STA P2 
2cc9 : a9 e8 __ LDA #$e8
2ccb : 85 10 __ STA P3 
2ccd : 20 16 0d JSR $0d16 ; (get_room_center.s0 + 0)
; 139, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2cd0 : ad e9 9f LDA $9fe9 ; (y + 0)
2cd3 : 85 48 __ STA T1 + 0 
2cd5 : 85 0d __ STA P0 
2cd7 : ad e8 9f LDA $9fe8 ; (room2_center_y + 0)
2cda : 85 49 __ STA T2 + 0 
2cdc : 85 0e __ STA P1 
2cde : 20 c2 14 JSR $14c2 ; (coords_in_bounds.s0 + 0)
2ce1 : aa __ __ TAX
2ce2 : f0 0f __ BEQ $2cf3 ; (add_stairs.s28 + 0)
.s26:
; 140, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2ce4 : a5 48 __ LDA T1 + 0 
2ce6 : 85 10 __ STA P3 
2ce8 : a5 49 __ LDA T2 + 0 
2cea : 85 11 __ STA P4 
2cec : a9 04 __ LDA #$04
2cee : 85 12 __ STA P5 
2cf0 : 20 20 16 JSR $1620 ; (set_tile_raw.s0 + 0)
.s28:
; 145, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2cf3 : ad ee 9f LDA $9fee ; (entropy4 + 1)
2cf6 : 85 0d __ STA P0 
2cf8 : a9 e7 __ LDA #$e7
2cfa : 85 0e __ STA P1 
2cfc : a9 9f __ LDA #$9f
2cfe : 85 11 __ STA P4 
2d00 : a9 9f __ LDA #$9f
2d02 : 85 0f __ STA P2 
2d04 : a9 e6 __ LDA #$e6
2d06 : 85 10 __ STA P3 
2d08 : 20 16 0d JSR $0d16 ; (get_room_center.s0 + 0)
; 146, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2d0b : ad e7 9f LDA $9fe7 ; (offset_range + 0)
2d0e : 85 48 __ STA T1 + 0 
2d10 : 85 0d __ STA P0 
2d12 : ad e6 9f LDA $9fe6 ; (closest_corridor_y1 + 0)
2d15 : 85 49 __ STA T2 + 0 
2d17 : 85 0e __ STA P1 
2d19 : 20 c2 14 JSR $14c2 ; (coords_in_bounds.s0 + 0)
2d1c : aa __ __ TAX
2d1d : d0 01 __ BNE $2d20 ; (add_stairs.s29 + 0)
.s1001:
; 114, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2d1f : 60 __ __ RTS
.s29:
; 147, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
2d20 : a5 48 __ LDA T1 + 0 
2d22 : 85 10 __ STA P3 
2d24 : a5 49 __ LDA T2 + 0 
2d26 : 85 11 __ STA P4 
2d28 : a9 05 __ LDA #$05
2d2a : 85 12 __ STA P5 
2d2c : 4c 20 16 JMP $1620 ; (set_tile_raw.s0 + 0)
--------------------------------------------------------------------
2d2f : __ __ __ BYT 0a 0a 50 6c 61 63 69 6e 67 20 73 74 61 69 72 73 : ..Placing stairs
2d3f : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
render_map_viewport: ; render_map_viewport(u8)->void
.s0:
; 141, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d40 : a5 14 __ LDA P7 ; (force_refresh + 0)
2d42 : d0 21 __ BNE $2d65 ; (render_map_viewport.s1 + 0)
.s3:
; 153, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d44 : ad c6 3a LDA $3ac6 ; (screen_dirty + 0)
2d47 : f0 1b __ BEQ $2d64 ; (render_map_viewport.s1001 + 0)
.s6:
; 158, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d49 : ad c7 3a LDA $3ac7 ; (last_scroll_direction + 0)
2d4c : 8d e3 9f STA $9fe3 ; (door1_x + 0)
; 161, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d4f : d0 06 __ BNE $2d57 ; (render_map_viewport.s8 + 0)
.s9:
; 166, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d51 : 20 90 30 JSR $3090 ; (update_full_screen.s0 + 0)
; 172, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d54 : 4c 5c 2d JMP $2d5c ; (render_map_viewport.s1006 + 0)
.s8:
; 163, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d57 : 85 13 __ STA P6 
2d59 : 20 98 2d JSR $2d98 ; (update_screen_with_perfect_scroll.s0 + 0)
.s1006:
; 171, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d5c : a9 00 __ LDA #$00
2d5e : 8d c7 3a STA $3ac7 ; (last_scroll_direction + 0)
; 169, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d61 : 8d c6 3a STA $3ac6 ; (screen_dirty + 0)
.s1001:
; 154, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d64 : 60 __ __ RTS
.s1:
; 143, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d65 : 20 2e 0b JSR $0b2e ; (oscar_clrscr.s0 + 0)
; 149, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d68 : a9 00 __ LDA #$00
2d6a : 8d c7 3a STA $3ac7 ; (last_scroll_direction + 0)
; 148, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d6d : a9 01 __ LDA #$01
2d6f : 8d c6 3a STA $3ac6 ; (screen_dirty + 0)
; 146, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d72 : a9 20 __ LDA #$20
2d74 : a2 fa __ LDX #$fa
.l1003:
2d76 : ca __ __ DEX
2d77 : 9d 00 04 STA $0400,x 
2d7a : 9d fa 04 STA $04fa,x 
2d7d : 9d f4 05 STA $05f4,x 
2d80 : 9d ee 06 STA $06ee,x 
2d83 : d0 f1 __ BNE $2d76 ; (render_map_viewport.l1003 + 0)
.s1002:
; 147, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d85 : a2 fa __ LDX #$fa
.l1005:
2d87 : ca __ __ DEX
2d88 : 9d de 36 STA $36de,x ; (screen_buffer + 0)
2d8b : 9d d8 37 STA $37d8,x ; (screen_buffer + 250)
2d8e : 9d d2 38 STA $38d2,x ; (screen_buffer + 500)
2d91 : 9d cc 39 STA $39cc,x ; (screen_buffer + 750)
2d94 : d0 f1 __ BNE $2d87 ; (render_map_viewport.l1005 + 0)
2d96 : f0 b1 __ BEQ $2d49 ; (render_map_viewport.s6 + 0)
--------------------------------------------------------------------
update_screen_with_perfect_scroll: ; update_screen_with_perfect_scroll(u8)->void
.s0:
; 273, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2d98 : a5 13 __ LDA P6 ; (scroll_dir + 0)
2d9a : f0 1c __ BEQ $2db8 ; (update_screen_with_perfect_scroll.s1 + 0)
.s4:
2d9c : c9 05 __ CMP #$05
2d9e : b0 18 __ BCS $2db8 ; (update_screen_with_perfect_scroll.s1 + 0)
.s3:
; 279, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2da0 : c9 03 __ CMP #$03
2da2 : d0 03 __ BNE $2da7 ; (update_screen_with_perfect_scroll.s28 + 0)
2da4 : 4c df 2f JMP $2fdf ; (update_screen_with_perfect_scroll.s17 + 0)
.s28:
2da7 : b0 03 __ BCS $2dac ; (update_screen_with_perfect_scroll.s29 + 0)
2da9 : 4c 65 2e JMP $2e65 ; (update_screen_with_perfect_scroll.s30 + 0)
.s29:
2dac : c9 04 __ CMP #$04
2dae : f0 01 __ BEQ $2db1 ; (update_screen_with_perfect_scroll.s22 + 0)
.s1001:
; 358, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2db0 : 60 __ __ RTS
.s22:
; 283, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2db1 : ad dc 36 LDA $36dc ; (view + 0)
2db4 : c9 18 __ CMP #$18
2db6 : 90 03 __ BCC $2dbb ; (update_screen_with_perfect_scroll.s70 + 0)
.s1:
; 274, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2db8 : 4c 90 30 JMP $3090 ; (update_full_screen.s0 + 0)
.s70:
; 344, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2dbb : 85 51 __ STA T6 + 0 
2dbd : a9 27 __ LDA #$27
2dbf : 85 11 __ STA P4 
2dc1 : a9 00 __ LDA #$00
2dc3 : 85 12 __ STA P5 
2dc5 : 8d e8 9f STA $9fe8 ; (room2_center_y + 0)
.l72:
; 345, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2dc8 : 85 52 __ STA T7 + 0 
2dca : 0a __ __ ASL
2dcb : 85 1b __ STA ACCU + 0 
2dcd : a9 00 __ LDA #$00
2dcf : 8d e9 9f STA $9fe9 ; (y + 0)
2dd2 : 2a __ __ ROL
2dd3 : 06 1b __ ASL ACCU + 0 
2dd5 : 2a __ __ ROL
2dd6 : aa __ __ TAX
2dd7 : a5 1b __ LDA ACCU + 0 
2dd9 : 65 52 __ ADC T7 + 0 
2ddb : 85 4f __ STA T3 + 0 
2ddd : 8a __ __ TXA
2dde : 69 00 __ ADC #$00
2de0 : 06 4f __ ASL T3 + 0 
2de2 : 2a __ __ ROL
2de3 : 06 4f __ ASL T3 + 0 
2de5 : 2a __ __ ROL
2de6 : 06 4f __ ASL T3 + 0 
2de8 : 2a __ __ ROL
2de9 : 85 50 __ STA T3 + 1 
2deb : 18 __ __ CLC
2dec : 69 04 __ ADC #$04
2dee : 85 4c __ STA T1 + 1 
2df0 : a6 4f __ LDX T3 + 0 
2df2 : 86 4b __ STX T1 + 0 
2df4 : 18 __ __ CLC
.l1014:
; 346, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2df5 : ac e9 9f LDY $9fe9 ; (y + 0)
2df8 : c8 __ __ INY
2df9 : b1 4b __ LDA (T1 + 0),y 
2dfb : 88 __ __ DEY
2dfc : 91 4b __ STA (T1 + 0),y 
; 345, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2dfe : 98 __ __ TYA
2dff : 69 01 __ ADC #$01
2e01 : 8d e9 9f STA $9fe9 ; (y + 0)
2e04 : c9 27 __ CMP #$27
2e06 : 90 ed __ BCC $2df5 ; (update_screen_with_perfect_scroll.l1014 + 0)
.s78:
; 349, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e08 : 18 __ __ CLC
2e09 : a9 de __ LDA #$de
2e0b : 65 4f __ ADC T3 + 0 
2e0d : 85 4b __ STA T1 + 0 
2e0f : 85 0d __ STA P0 
2e11 : a9 36 __ LDA #$36
2e13 : 65 50 __ ADC T3 + 1 
2e15 : 85 4c __ STA T1 + 1 
2e17 : 85 0e __ STA P1 
2e19 : 8a __ __ TXA
2e1a : 18 __ __ CLC
2e1b : 69 df __ ADC #$df
2e1d : 85 0f __ STA P2 
2e1f : a5 50 __ LDA T3 + 1 
2e21 : 69 36 __ ADC #$36
2e23 : 85 10 __ STA P3 
2e25 : 20 cf 31 JSR $31cf ; (memmove.s0 + 0)
; 352, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e28 : 38 __ __ SEC
2e29 : a5 51 __ LDA T6 + 0 
2e2b : e9 d9 __ SBC #$d9
2e2d : 85 0d __ STA P0 
2e2f : ad dd 36 LDA $36dd ; (view + 1)
2e32 : 18 __ __ CLC
2e33 : 65 52 __ ADC T7 + 0 
2e35 : 85 0e __ STA P1 
2e37 : 20 fa 30 JSR $30fa ; (get_map_tile_fast.s0 + 0)
2e3a : 8d e4 9f STA $9fe4 ; (y + 0)
; 353, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e3d : 18 __ __ CLC
2e3e : a9 27 __ LDA #$27
2e40 : 65 4f __ ADC T3 + 0 
2e42 : 85 43 __ STA T0 + 0 
2e44 : a9 04 __ LDA #$04
2e46 : 65 50 __ ADC T3 + 1 
2e48 : 85 44 __ STA T0 + 1 
2e4a : ad e4 9f LDA $9fe4 ; (y + 0)
2e4d : a0 00 __ LDY #$00
2e4f : 91 43 __ STA (T0 + 0),y 
; 354, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e51 : a0 27 __ LDY #$27
2e53 : 91 4b __ STA (T1 + 0),y 
; 344, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e55 : 18 __ __ CLC
2e56 : a5 52 __ LDA T7 + 0 
2e58 : 69 01 __ ADC #$01
2e5a : 8d e8 9f STA $9fe8 ; (room2_center_y + 0)
2e5d : c9 19 __ CMP #$19
2e5f : b0 03 __ BCS $2e64 ; (update_screen_with_perfect_scroll.s78 + 92)
2e61 : 4c c8 2d JMP $2dc8 ; (update_screen_with_perfect_scroll.l72 + 0)
2e64 : 60 __ __ RTS
.s30:
; 279, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e65 : c9 01 __ CMP #$01
2e67 : f0 03 __ BEQ $2e6c ; (update_screen_with_perfect_scroll.s7 + 0)
2e69 : 4c 1c 2f JMP $2f1c ; (update_screen_with_perfect_scroll.s31 + 0)
.s7:
; 280, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e6c : ad dd 36 LDA $36dd ; (view + 1)
2e6f : d0 03 __ BNE $2e74 ; (update_screen_with_perfect_scroll.s35 + 0)
2e71 : 4c b8 2d JMP $2db8 ; (update_screen_with_perfect_scroll.s1 + 0)
.s35:
; 290, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e74 : 85 51 __ STA T6 + 0 
2e76 : a9 00 __ LDA #$00
2e78 : 85 12 __ STA P5 
2e7a : a9 28 __ LDA #$28
2e7c : 85 11 __ STA P4 
2e7e : a9 18 __ LDA #$18
2e80 : 8d e8 9f STA $9fe8 ; (room2_center_y + 0)
.l37:
; 292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e83 : 85 52 __ STA T7 + 0 
2e85 : 0a __ __ ASL
2e86 : 85 1b __ STA ACCU + 0 
2e88 : a9 00 __ LDA #$00
2e8a : 8d e9 9f STA $9fe9 ; (y + 0)
; 293, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2e8d : 2a __ __ ROL
2e8e : 06 1b __ ASL ACCU + 0 
2e90 : 2a __ __ ROL
2e91 : aa __ __ TAX
2e92 : a5 1b __ LDA ACCU + 0 
2e94 : 65 52 __ ADC T7 + 0 
2e96 : 85 43 __ STA T0 + 0 
2e98 : 8a __ __ TXA
2e99 : 69 00 __ ADC #$00
2e9b : 06 43 __ ASL T0 + 0 
2e9d : 2a __ __ ROL
2e9e : 06 43 __ ASL T0 + 0 
2ea0 : 2a __ __ ROL
2ea1 : 06 43 __ ASL T0 + 0 
2ea3 : 2a __ __ ROL
2ea4 : 85 44 __ STA T0 + 1 
2ea6 : 18 __ __ CLC
2ea7 : 69 04 __ ADC #$04
2ea9 : 85 4e __ STA T2 + 1 
2eab : 18 __ __ CLC
2eac : a9 d8 __ LDA #$d8
2eae : 65 43 __ ADC T0 + 0 
2eb0 : 85 4b __ STA T1 + 0 
2eb2 : a9 03 __ LDA #$03
2eb4 : 65 44 __ ADC T0 + 1 
2eb6 : 85 4c __ STA T1 + 1 
2eb8 : a5 43 __ LDA T0 + 0 
2eba : 85 4d __ STA T2 + 0 
.l41:
2ebc : ac e9 9f LDY $9fe9 ; (y + 0)
2ebf : b1 4b __ LDA (T1 + 0),y 
2ec1 : 91 4d __ STA (T2 + 0),y 
; 292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ec3 : c8 __ __ INY
2ec4 : 8c e9 9f STY $9fe9 ; (y + 0)
2ec7 : c0 28 __ CPY #$28
2ec9 : 90 f1 __ BCC $2ebc ; (update_screen_with_perfect_scroll.l41 + 0)
.s43:
; 296, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ecb : 18 __ __ CLC
2ecc : a9 de __ LDA #$de
2ece : 65 43 __ ADC T0 + 0 
2ed0 : 85 0d __ STA P0 
2ed2 : a9 36 __ LDA #$36
2ed4 : 65 44 __ ADC T0 + 1 
2ed6 : 85 0e __ STA P1 
2ed8 : 18 __ __ CLC
2ed9 : a9 b6 __ LDA #$b6
2edb : 65 43 __ ADC T0 + 0 
2edd : 85 0f __ STA P2 
2edf : a9 36 __ LDA #$36
2ee1 : 65 44 __ ADC T0 + 1 
2ee3 : 85 10 __ STA P3 
2ee5 : 20 cf 31 JSR $31cf ; (memmove.s0 + 0)
; 290, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ee8 : 18 __ __ CLC
2ee9 : a5 52 __ LDA T7 + 0 
2eeb : 69 ff __ ADC #$ff
2eed : 8d e8 9f STA $9fe8 ; (room2_center_y + 0)
2ef0 : c9 01 __ CMP #$01
2ef2 : b0 8f __ BCS $2e83 ; (update_screen_with_perfect_scroll.l37 + 0)
.s39:
; 300, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ef4 : 8d e9 9f STA $9fe9 ; (y + 0)
; 301, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ef7 : a5 51 __ LDA T6 + 0 
2ef9 : 85 0e __ STA P1 
.l1010:
2efb : ad e9 9f LDA $9fe9 ; (y + 0)
2efe : 85 4f __ STA T3 + 0 
2f00 : 6d dc 36 ADC $36dc ; (view + 0)
2f03 : 85 0d __ STA P0 
2f05 : 20 fa 30 JSR $30fa ; (get_map_tile_fast.s0 + 0)
2f08 : 8d e7 9f STA $9fe7 ; (offset_range + 0)
; 302, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2f0b : a6 4f __ LDX T3 + 0 
2f0d : 9d 00 04 STA $0400,x 
; 303, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2f10 : 9d de 36 STA $36de,x ; (screen_buffer + 0)
; 300, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2f13 : e8 __ __ INX
2f14 : 8e e9 9f STX $9fe9 ; (y + 0)
2f17 : e0 28 __ CPX #$28
2f19 : 90 e0 __ BCC $2efb ; (update_screen_with_perfect_scroll.l1010 + 0)
2f1b : 60 __ __ RTS
.s31:
; 279, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2f1c : c9 02 __ CMP #$02
2f1e : f0 01 __ BEQ $2f21 ; (update_screen_with_perfect_scroll.s12 + 0)
2f20 : 60 __ __ RTS
.s12:
; 281, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2f21 : ad dd 36 LDA $36dd ; (view + 1)
2f24 : c9 27 __ CMP #$27
2f26 : 90 03 __ BCC $2f2b ; (update_screen_with_perfect_scroll.s83 + 0)
2f28 : 4c b8 2d JMP $2db8 ; (update_screen_with_perfect_scroll.s1 + 0)
.s83:
; 308, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2f2b : 85 51 __ STA T6 + 0 
2f2d : a9 28 __ LDA #$28
2f2f : 85 11 __ STA P4 
2f31 : a9 00 __ LDA #$00
2f33 : 85 12 __ STA P5 
2f35 : 8d e8 9f STA $9fe8 ; (room2_center_y + 0)
.l50:
; 310, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2f38 : 85 52 __ STA T7 + 0 
2f3a : 0a __ __ ASL
2f3b : 85 1b __ STA ACCU + 0 
2f3d : a9 00 __ LDA #$00
2f3f : 8d e9 9f STA $9fe9 ; (y + 0)
; 311, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2f42 : 2a __ __ ROL
2f43 : 06 1b __ ASL ACCU + 0 
2f45 : 2a __ __ ROL
2f46 : aa __ __ TAX
2f47 : a5 1b __ LDA ACCU + 0 
2f49 : 65 52 __ ADC T7 + 0 
2f4b : 85 43 __ STA T0 + 0 
2f4d : 8a __ __ TXA
2f4e : 69 00 __ ADC #$00
2f50 : 06 43 __ ASL T0 + 0 
2f52 : 2a __ __ ROL
2f53 : 06 43 __ ASL T0 + 0 
2f55 : 2a __ __ ROL
2f56 : 06 43 __ ASL T0 + 0 
2f58 : 2a __ __ ROL
2f59 : 85 44 __ STA T0 + 1 
2f5b : 18 __ __ CLC
2f5c : 69 04 __ ADC #$04
2f5e : 85 4c __ STA T1 + 1 
2f60 : a5 43 __ LDA T0 + 0 
2f62 : 85 4b __ STA T1 + 0 
2f64 : 18 __ __ CLC
2f65 : 69 28 __ ADC #$28
2f67 : 85 4d __ STA T2 + 0 
2f69 : a5 44 __ LDA T0 + 1 
2f6b : 69 04 __ ADC #$04
2f6d : 85 4e __ STA T2 + 1 
.l54:
2f6f : ac e9 9f LDY $9fe9 ; (y + 0)
2f72 : b1 4d __ LDA (T2 + 0),y 
2f74 : 91 4b __ STA (T1 + 0),y 
; 310, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2f76 : c8 __ __ INY
2f77 : 8c e9 9f STY $9fe9 ; (y + 0)
2f7a : c0 28 __ CPY #$28
2f7c : 90 f1 __ BCC $2f6f ; (update_screen_with_perfect_scroll.l54 + 0)
.s56:
; 314, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2f7e : 18 __ __ CLC
2f7f : a9 de __ LDA #$de
2f81 : 65 43 __ ADC T0 + 0 
2f83 : 85 0d __ STA P0 
2f85 : a9 36 __ LDA #$36
2f87 : 65 44 __ ADC T0 + 1 
2f89 : 85 0e __ STA P1 
2f8b : 18 __ __ CLC
2f8c : a5 43 __ LDA T0 + 0 
2f8e : 69 06 __ ADC #$06
2f90 : 85 0f __ STA P2 
2f92 : a5 44 __ LDA T0 + 1 
2f94 : 69 37 __ ADC #$37
2f96 : 85 10 __ STA P3 
2f98 : 20 cf 31 JSR $31cf ; (memmove.s0 + 0)
; 308, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2f9b : 18 __ __ CLC
2f9c : a5 52 __ LDA T7 + 0 
2f9e : 69 01 __ ADC #$01
2fa0 : 8d e8 9f STA $9fe8 ; (room2_center_y + 0)
2fa3 : c9 18 __ CMP #$18
2fa5 : 90 91 __ BCC $2f38 ; (update_screen_with_perfect_scroll.l50 + 0)
.s52:
; 318, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2fa7 : a9 c0 __ LDA #$c0
2fa9 : 8d ea 9f STA $9fea ; (check_y + 0)
2fac : a9 03 __ LDA #$03
2fae : 8d eb 9f STA $9feb ; (screen_offset + 1)
; 319, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2fb1 : a9 00 __ LDA #$00
2fb3 : 8d e9 9f STA $9fe9 ; (y + 0)
; 320, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2fb6 : 18 __ __ CLC
.l1012:
2fb7 : ad e9 9f LDA $9fe9 ; (y + 0)
2fba : 85 4f __ STA T3 + 0 
2fbc : 6d dc 36 ADC $36dc ; (view + 0)
2fbf : 85 0d __ STA P0 
2fc1 : 38 __ __ SEC
2fc2 : a5 51 __ LDA T6 + 0 
2fc4 : e9 e8 __ SBC #$e8
2fc6 : 85 0e __ STA P1 
2fc8 : 20 fa 30 JSR $30fa ; (get_map_tile_fast.s0 + 0)
2fcb : 8d e6 9f STA $9fe6 ; (closest_corridor_y1 + 0)
; 321, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2fce : a6 4f __ LDX T3 + 0 
2fd0 : 9d c0 07 STA $07c0,x 
; 322, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2fd3 : 9d 9e 3a STA $3a9e,x ; (screen_buffer + 960)
; 319, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2fd6 : e8 __ __ INX
2fd7 : 8e e9 9f STX $9fe9 ; (y + 0)
2fda : e0 28 __ CPX #$28
2fdc : 90 d9 __ BCC $2fb7 ; (update_screen_with_perfect_scroll.l1012 + 0)
2fde : 60 __ __ RTS
.s17:
; 282, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2fdf : ad dc 36 LDA $36dc ; (view + 0)
2fe2 : d0 03 __ BNE $2fe7 ; (update_screen_with_perfect_scroll.s61 + 0)
2fe4 : 4c b8 2d JMP $2db8 ; (update_screen_with_perfect_scroll.s1 + 0)
.s61:
; 328, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2fe7 : 85 51 __ STA T6 + 0 
2fe9 : a9 00 __ LDA #$00
2feb : 8d e8 9f STA $9fe8 ; (room2_center_y + 0)
; 333, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2fee : 85 12 __ STA P5 
2ff0 : a9 27 __ LDA #$27
2ff2 : 85 11 __ STA P4 
.l63:
; 329, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
2ff4 : ad e8 9f LDA $9fe8 ; (room2_center_y + 0)
2ff7 : 85 52 __ STA T7 + 0 
2ff9 : 85 4d __ STA T2 + 0 
2ffb : 0a __ __ ASL
2ffc : 85 1b __ STA ACCU + 0 
2ffe : a9 27 __ LDA #$27
3000 : 8d e9 9f STA $9fe9 ; (y + 0)
; 330, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3003 : a9 00 __ LDA #$00
3005 : 2a __ __ ROL
3006 : 06 1b __ ASL ACCU + 0 
3008 : 2a __ __ ROL
3009 : aa __ __ TAX
300a : a5 1b __ LDA ACCU + 0 
300c : 65 4d __ ADC T2 + 0 
300e : 85 4f __ STA T3 + 0 
3010 : 8a __ __ TXA
3011 : 69 00 __ ADC #$00
3013 : 06 4f __ ASL T3 + 0 
3015 : 2a __ __ ROL
3016 : 06 4f __ ASL T3 + 0 
3018 : 2a __ __ ROL
3019 : 06 4f __ ASL T3 + 0 
301b : 2a __ __ ROL
301c : 85 50 __ STA T3 + 1 
301e : 18 __ __ CLC
301f : a9 ff __ LDA #$ff
3021 : 65 4f __ ADC T3 + 0 
3023 : 85 43 __ STA T0 + 0 
3025 : a9 03 __ LDA #$03
3027 : 65 50 __ ADC T3 + 1 
3029 : 85 44 __ STA T0 + 1 
.l67:
302b : ac e9 9f LDY $9fe9 ; (y + 0)
302e : b1 43 __ LDA (T0 + 0),y 
3030 : c8 __ __ INY
3031 : 91 43 __ STA (T0 + 0),y 
; 329, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3033 : 98 __ __ TYA
3034 : 18 __ __ CLC
3035 : 69 fe __ ADC #$fe
3037 : 8d e9 9f STA $9fe9 ; (y + 0)
303a : c9 01 __ CMP #$01
303c : b0 ed __ BCS $302b ; (update_screen_with_perfect_scroll.l67 + 0)
.s69:
; 333, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
303e : a9 de __ LDA #$de
3040 : 65 4f __ ADC T3 + 0 
3042 : 85 0f __ STA P2 
3044 : a9 36 __ LDA #$36
3046 : 65 50 __ ADC T3 + 1 
3048 : 85 10 __ STA P3 
304a : 18 __ __ CLC
304b : a5 4f __ LDA T3 + 0 
304d : 69 df __ ADC #$df
304f : 85 0d __ STA P0 
3051 : a5 50 __ LDA T3 + 1 
3053 : 69 36 __ ADC #$36
3055 : 85 0e __ STA P1 
3057 : 20 cf 31 JSR $31cf ; (memmove.s0 + 0)
; 336, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
305a : a5 51 __ LDA T6 + 0 
305c : 85 0d __ STA P0 
305e : ad dd 36 LDA $36dd ; (view + 1)
3061 : 18 __ __ CLC
3062 : 65 4d __ ADC T2 + 0 
3064 : 85 0e __ STA P1 
3066 : 20 fa 30 JSR $30fa ; (get_map_tile_fast.s0 + 0)
3069 : 8d e5 9f STA $9fe5 ; (tile + 0)
; 337, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
306c : a5 4f __ LDA T3 + 0 
306e : 85 43 __ STA T0 + 0 
3070 : 18 __ __ CLC
3071 : a9 04 __ LDA #$04
3073 : 65 50 __ ADC T3 + 1 
3075 : 85 44 __ STA T0 + 1 
3077 : ad e5 9f LDA $9fe5 ; (tile + 0)
307a : a0 00 __ LDY #$00
307c : 91 43 __ STA (T0 + 0),y 
; 338, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
307e : 91 0f __ STA (P2),y 
; 328, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3080 : 18 __ __ CLC
3081 : a5 52 __ LDA T7 + 0 
3083 : 69 01 __ ADC #$01
3085 : 8d e8 9f STA $9fe8 ; (room2_center_y + 0)
3088 : c9 19 __ CMP #$19
308a : b0 03 __ BCS $308f ; (update_screen_with_perfect_scroll.s69 + 81)
308c : 4c f4 2f JMP $2ff4 ; (update_screen_with_perfect_scroll.l63 + 0)
308f : 60 __ __ RTS
--------------------------------------------------------------------
update_full_screen: ; update_full_screen()->void
.s0:
; 362, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3090 : a9 00 __ LDA #$00
3092 : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
.l2:
; 365, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3095 : 85 49 __ STA T6 + 0 
3097 : 0a __ __ ASL
3098 : 0a __ __ ASL
3099 : 65 49 __ ADC T6 + 0 
309b : 0a __ __ ASL
309c : 0a __ __ ASL
309d : 85 43 __ STA T0 + 0 
309f : a9 00 __ LDA #$00
30a1 : 8d ed 9f STA $9fed ; (highest_priority + 0)
; 363, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30a4 : 2a __ __ ROL
30a5 : 06 43 __ ASL T0 + 0 
30a7 : 2a __ __ ROL
30a8 : 8d ef 9f STA $9fef ; (screen_pos + 1)
30ab : a5 43 __ LDA T0 + 0 
30ad : 85 47 __ STA T3 + 0 
30af : 8d ee 9f STA $9fee ; (entropy4 + 1)
; 366, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30b2 : a9 04 __ LDA #$04
30b4 : 6d ef 9f ADC $9fef ; (screen_pos + 1)
30b7 : 85 48 __ STA T3 + 1 
30b9 : 18 __ __ CLC
30ba : a9 de __ LDA #$de
30bc : 65 43 __ ADC T0 + 0 
30be : 85 45 __ STA T2 + 0 
30c0 : a9 36 __ LDA #$36
30c2 : 6d ef 9f ADC $9fef ; (screen_pos + 1)
30c5 : 85 46 __ STA T2 + 1 
30c7 : 18 __ __ CLC
.l1002:
30c8 : ad ed 9f LDA $9fed ; (highest_priority + 0)
30cb : 85 4a __ STA T7 + 0 
30cd : 6d dc 36 ADC $36dc ; (view + 0)
30d0 : 85 0d __ STA P0 
30d2 : ad dd 36 LDA $36dd ; (view + 1)
30d5 : 18 __ __ CLC
30d6 : 65 49 __ ADC T6 + 0 
30d8 : 85 0e __ STA P1 
30da : 20 fa 30 JSR $30fa ; (get_map_tile_fast.s0 + 0)
30dd : 8d ec 9f STA $9fec ; (dy + 0)
; 370, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30e0 : a4 4a __ LDY T7 + 0 
30e2 : 91 47 __ STA (T3 + 0),y 
; 371, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30e4 : 91 45 __ STA (T2 + 0),y 
; 365, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30e6 : c8 __ __ INY
30e7 : 8c ed 9f STY $9fed ; (highest_priority + 0)
30ea : c0 28 __ CPY #$28
30ec : 90 da __ BCC $30c8 ; (update_full_screen.l1002 + 0)
.s3:
; 362, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30ee : a5 49 __ LDA T6 + 0 
30f0 : 69 00 __ ADC #$00
30f2 : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
30f5 : c9 19 __ CMP #$19
30f7 : 90 9c __ BCC $3095 ; (update_full_screen.l2 + 0)
.s1001:
; 374, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30f9 : 60 __ __ RTS
--------------------------------------------------------------------
get_map_tile_fast: ; get_map_tile_fast(u8,u8)->u8
.s0:
; 105, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
30fa : a5 0d __ LDA P0 ; (map_x + 0)
30fc : c9 40 __ CMP #$40
30fe : b0 06 __ BCS $3106 ; (get_map_tile_fast.s1 + 0)
.s4:
3100 : a5 0e __ LDA P1 ; (map_y + 0)
3102 : c9 40 __ CMP #$40
3104 : 90 03 __ BCC $3109 ; (get_map_tile_fast.s3 + 0)
.s1:
; 106, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3106 : a9 20 __ LDA #$20
.s1001:
3108 : 60 __ __ RTS
.s3:
; 117, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3109 : 85 1c __ STA ACCU + 1 
310b : 4a __ __ LSR
310c : aa __ __ TAX
310d : a9 00 __ LDA #$00
310f : 6a __ __ ROR
3110 : 85 43 __ STA T1 + 0 
3112 : a9 00 __ LDA #$00
3114 : 46 1c __ LSR ACCU + 1 
3116 : 6a __ __ ROR
3117 : 66 1c __ ROR ACCU + 1 
3119 : 6a __ __ ROR
311a : 65 43 __ ADC T1 + 0 
311c : a8 __ __ TAY
311d : 8a __ __ TXA
311e : 65 1c __ ADC ACCU + 1 
3120 : aa __ __ TAX
3121 : 98 __ __ TYA
3122 : 18 __ __ CLC
3123 : 65 0d __ ADC P0 ; (map_x + 0)
3125 : 90 01 __ BCC $3128 ; (get_map_tile_fast.s1014 + 0)
.s1013:
; 110, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3127 : e8 __ __ INX
.s1014:
3128 : 18 __ __ CLC
3129 : 65 0d __ ADC P0 ; (map_x + 0)
312b : 90 01 __ BCC $312e ; (get_map_tile_fast.s1016 + 0)
.s1015:
; 110, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
312d : e8 __ __ INX
.s1016:
312e : 18 __ __ CLC
312f : 65 0d __ ADC P0 ; (map_x + 0)
3131 : 8d f8 9f STA $9ff8 ; (room + 1)
3134 : 8a __ __ TXA
3135 : 69 00 __ ADC #$00
3137 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 111, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
313a : 4a __ __ LSR
313b : 85 44 __ STA T1 + 1 
313d : ad f8 9f LDA $9ff8 ; (room + 1)
3140 : 6a __ __ ROR
3141 : 46 44 __ LSR T1 + 1 
3143 : 6a __ __ ROR
3144 : 46 44 __ LSR T1 + 1 
3146 : 6a __ __ ROR
3147 : 18 __ __ CLC
3148 : 69 c8 __ ADC #$c8
314a : 85 43 __ STA T1 + 0 
314c : 8d f6 9f STA $9ff6 ; (y2 + 0)
314f : a9 3a __ LDA #$3a
3151 : 65 44 __ ADC T1 + 1 
3153 : 85 44 __ STA T1 + 1 
3155 : 8d f7 9f STA $9ff7 ; (d + 1)
; 112, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3158 : ad f8 9f LDA $9ff8 ; (room + 1)
315b : 29 07 __ AND #$07
315d : 85 1b __ STA ACCU + 0 
315f : 8d f5 9f STA $9ff5 ; (s + 1)
; 117, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3162 : aa __ __ TAX
3163 : a0 00 __ LDY #$00
3165 : b1 43 __ LDA (T1 + 0),y 
3167 : e0 00 __ CPX #$00
3169 : f0 04 __ BEQ $316f ; (get_map_tile_fast.s1003 + 0)
.l1002:
; 117, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
316b : 4a __ __ LSR
316c : ca __ __ DEX
316d : d0 fc __ BNE $316b ; (get_map_tile_fast.l1002 + 0)
.s1003:
; 115, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
316f : 85 1c __ STA ACCU + 1 
3171 : a5 1b __ LDA ACCU + 0 
3173 : c9 06 __ CMP #$06
3175 : a5 1c __ LDA ACCU + 1 
3177 : 90 23 __ BCC $319c ; (get_map_tile_fast.s33 + 0)
.s7:
; 121, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3179 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
; 120, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
317c : a9 08 __ LDA #$08
317e : e5 1b __ SBC ACCU + 0 
3180 : 8d f3 9f STA $9ff3 ; (ix + 0)
; 122, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3183 : aa __ __ TAX
3184 : bd c6 36 LDA $36c6,x ; (bitshift + 36)
3187 : 38 __ __ SEC
3188 : e9 01 __ SBC #$01
318a : a0 01 __ LDY #$01
318c : 31 43 __ AND (T1 + 0),y 
318e : ae f3 9f LDX $9ff3 ; (ix + 0)
3191 : f0 04 __ BEQ $3197 ; (get_map_tile_fast.s1005 + 0)
.l1006:
3193 : 0a __ __ ASL
3194 : ca __ __ DEX
3195 : d0 fc __ BNE $3193 ; (get_map_tile_fast.l1006 + 0)
.s1005:
; 122, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3197 : 8d f1 9f STA $9ff1 ; (second_part + 0)
; 123, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
319a : 05 1c __ ORA ACCU + 1 
.s33:
319c : 29 07 __ AND #$07
319e : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
31a1 : c9 03 __ CMP #$03
31a3 : d0 03 __ BNE $31a8 ; (get_map_tile_fast.s20 + 0)
.s13:
; 130, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
31a5 : a9 db __ LDA #$db
31a7 : 60 __ __ RTS
.s20:
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
31a8 : 90 16 __ BCC $31c0 ; (get_map_tile_fast.s22 + 0)
.s21:
31aa : c9 05 __ CMP #$05
31ac : d0 03 __ BNE $31b1 ; (get_map_tile_fast.s26 + 0)
.s15:
; 132, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
31ae : a9 3e __ LDA #$3e
31b0 : 60 __ __ RTS
.s26:
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
31b1 : b0 03 __ BCS $31b6 ; (get_map_tile_fast.s27 + 0)
.s14:
; 131, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
31b3 : a9 3c __ LDA #$3c
31b5 : 60 __ __ RTS
.s27:
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
31b6 : c9 06 __ CMP #$06
31b8 : f0 03 __ BEQ $31bd ; (get_map_tile_fast.s16 + 0)
31ba : 4c 06 31 JMP $3106 ; (get_map_tile_fast.s1 + 0)
.s16:
; 133, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
31bd : a9 e6 __ LDA #$e6
31bf : 60 __ __ RTS
.s22:
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
31c0 : c9 01 __ CMP #$01
31c2 : d0 03 __ BNE $31c7 ; (get_map_tile_fast.s23 + 0)
.s11:
; 128, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
31c4 : a9 a0 __ LDA #$a0
31c6 : 60 __ __ RTS
.s23:
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
31c7 : 8a __ __ TXA
31c8 : 69 ff __ ADC #$ff
31ca : 29 0e __ AND #$0e
31cc : 49 2e __ EOR #$2e
31ce : 60 __ __ RTS
--------------------------------------------------------------------
memmove: ; memmove(void*,const void*,i16)->void*
.s0:
; 237, "E:/Apps/oscar64/include/string.c"
31cf : a5 11 __ LDA P4 ; (size + 0)
31d1 : 8d f8 9f STA $9ff8 ; (room + 1)
31d4 : a6 0e __ LDX P1 ; (dst + 1)
31d6 : a5 12 __ LDA P5 ; (size + 1)
31d8 : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 238, "E:/Apps/oscar64/include/string.c"
31db : 10 03 __ BPL $31e0 ; (memmove.s1006 + 0)
31dd : 4c 7b 32 JMP $327b ; (memmove.s3 + 0)
.s1006:
31e0 : 05 11 __ ORA P4 ; (size + 0)
31e2 : f0 f9 __ BEQ $31dd ; (memmove.s0 + 14)
.s1:
; 240, "E:/Apps/oscar64/include/string.c"
31e4 : 8e f7 9f STX $9ff7 ; (d + 1)
31e7 : a5 0d __ LDA P0 ; (dst + 0)
31e9 : 8d f6 9f STA $9ff6 ; (y2 + 0)
; 241, "E:/Apps/oscar64/include/string.c"
31ec : a5 0f __ LDA P2 ; (src + 0)
31ee : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
31f1 : a5 10 __ LDA P3 ; (src + 1)
31f3 : 8d f5 9f STA $9ff5 ; (s + 1)
; 242, "E:/Apps/oscar64/include/string.c"
31f6 : e4 10 __ CPX P3 ; (src + 1)
31f8 : d0 05 __ BNE $31ff ; (memmove.s1005 + 0)
.s1004:
31fa : a5 0d __ LDA P0 ; (dst + 0)
31fc : cd f4 9f CMP $9ff4 ; (entropy1 + 1)
.s1005:
31ff : b0 04 __ BCS $3205 ; (memmove.s5 + 0)
.s7:
; 246, "E:/Apps/oscar64/include/string.c"
3201 : a0 00 __ LDY #$00
3203 : 90 7d __ BCC $3282 ; (memmove.l1007 + 0)
.s5:
; 248, "E:/Apps/oscar64/include/string.c"
3205 : ad f5 9f LDA $9ff5 ; (s + 1)
3208 : cd f7 9f CMP $9ff7 ; (d + 1)
320b : d0 06 __ BNE $3213 ; (memmove.s1003 + 0)
.s1002:
320d : ad f4 9f LDA $9ff4 ; (entropy1 + 1)
3210 : cd f6 9f CMP $9ff6 ; (y2 + 0)
.s1003:
3213 : b0 66 __ BCS $327b ; (memmove.s3 + 0)
.s9:
; 251, "E:/Apps/oscar64/include/string.c"
3215 : ad f4 9f LDA $9ff4 ; (entropy1 + 1)
3218 : 18 __ __ CLC
3219 : 65 11 __ ADC P4 ; (size + 0)
321b : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
321e : ad f5 9f LDA $9ff5 ; (s + 1)
3221 : 6d f9 9f ADC $9ff9 ; (bit_offset + 1)
3224 : 8d f5 9f STA $9ff5 ; (s + 1)
; 250, "E:/Apps/oscar64/include/string.c"
3227 : ad f6 9f LDA $9ff6 ; (y2 + 0)
322a : 18 __ __ CLC
322b : 65 11 __ ADC P4 ; (size + 0)
322d : 8d f6 9f STA $9ff6 ; (y2 + 0)
3230 : ad f7 9f LDA $9ff7 ; (d + 1)
3233 : 6d f9 9f ADC $9ff9 ; (bit_offset + 1)
3236 : 8d f7 9f STA $9ff7 ; (d + 1)
; 253, "E:/Apps/oscar64/include/string.c"
3239 : a0 00 __ LDY #$00
.l1009:
323b : ad f4 9f LDA $9ff4 ; (entropy1 + 1)
323e : 18 __ __ CLC
323f : 69 ff __ ADC #$ff
3241 : 85 1b __ STA ACCU + 0 
3243 : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
3246 : ad f5 9f LDA $9ff5 ; (s + 1)
3249 : 69 ff __ ADC #$ff
324b : 85 1c __ STA ACCU + 1 
324d : 8d f5 9f STA $9ff5 ; (s + 1)
3250 : ad f6 9f LDA $9ff6 ; (y2 + 0)
3253 : 18 __ __ CLC
3254 : 69 ff __ ADC #$ff
3256 : 85 43 __ STA T1 + 0 
3258 : 8d f6 9f STA $9ff6 ; (y2 + 0)
325b : ad f7 9f LDA $9ff7 ; (d + 1)
325e : 69 ff __ ADC #$ff
3260 : 85 44 __ STA T1 + 1 
3262 : 8d f7 9f STA $9ff7 ; (d + 1)
3265 : b1 1b __ LDA (ACCU + 0),y 
3267 : 91 43 __ STA (T1 + 0),y 
; 254, "E:/Apps/oscar64/include/string.c"
3269 : ad f8 9f LDA $9ff8 ; (room + 1)
326c : d0 03 __ BNE $3271 ; (memmove.s1017 + 0)
.s1016:
; 254, "E:/Apps/oscar64/include/string.c"
326e : ce f9 9f DEC $9ff9 ; (bit_offset + 1)
.s1017:
3271 : ce f8 9f DEC $9ff8 ; (room + 1)
3274 : d0 c5 __ BNE $323b ; (memmove.l1009 + 0)
.s1018:
; 254, "E:/Apps/oscar64/include/string.c"
3276 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
3279 : d0 c0 __ BNE $323b ; (memmove.l1009 + 0)
.s3:
; 257, "E:/Apps/oscar64/include/string.c"
327b : 86 1c __ STX ACCU + 1 
327d : a5 0d __ LDA P0 ; (dst + 0)
327f : 85 1b __ STA ACCU + 0 
.s1001:
3281 : 60 __ __ RTS
.l1007:
; 245, "E:/Apps/oscar64/include/string.c"
3282 : ad f4 9f LDA $9ff4 ; (entropy1 + 1)
3285 : 85 1b __ STA ACCU + 0 
3287 : 18 __ __ CLC
3288 : 69 01 __ ADC #$01
328a : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
328d : ad f5 9f LDA $9ff5 ; (s + 1)
3290 : 85 1c __ STA ACCU + 1 
3292 : 69 00 __ ADC #$00
3294 : 8d f5 9f STA $9ff5 ; (s + 1)
3297 : ad f6 9f LDA $9ff6 ; (y2 + 0)
329a : 85 43 __ STA T1 + 0 
329c : ad f7 9f LDA $9ff7 ; (d + 1)
329f : 85 44 __ STA T1 + 1 
32a1 : b1 1b __ LDA (ACCU + 0),y 
32a3 : 91 43 __ STA (T1 + 0),y 
32a5 : 18 __ __ CLC
32a6 : a5 43 __ LDA T1 + 0 
32a8 : 69 01 __ ADC #$01
32aa : 8d f6 9f STA $9ff6 ; (y2 + 0)
32ad : a5 44 __ LDA T1 + 1 
32af : 69 00 __ ADC #$00
32b1 : 8d f7 9f STA $9ff7 ; (d + 1)
; 246, "E:/Apps/oscar64/include/string.c"
32b4 : ad f8 9f LDA $9ff8 ; (room + 1)
32b7 : d0 03 __ BNE $32bc ; (memmove.s1014 + 0)
.s1013:
; 246, "E:/Apps/oscar64/include/string.c"
32b9 : ce f9 9f DEC $9ff9 ; (bit_offset + 1)
.s1014:
32bc : ce f8 9f DEC $9ff8 ; (room + 1)
32bf : d0 c1 __ BNE $3282 ; (memmove.l1007 + 0)
.s1015:
; 246, "E:/Apps/oscar64/include/string.c"
32c1 : ad f9 9f LDA $9ff9 ; (bit_offset + 1)
32c4 : d0 bc __ BNE $3282 ; (memmove.l1007 + 0)
32c6 : f0 b3 __ BEQ $327b ; (memmove.s3 + 0)
--------------------------------------------------------------------
getch: ; getch()->u8
.l1:
; 320, "E:/Apps/oscar64/include/conio.c"
32c8 : 20 e4 ff JSR $ffe4 
32cb : 85 1b __ STA ACCU + 0 
32cd : a5 1b __ LDA ACCU + 0 
; 319, "E:/Apps/oscar64/include/conio.c"
32cf : 8d f9 9f STA $9ff9 ; (bit_offset + 1)
; 323, "E:/Apps/oscar64/include/conio.c"
32d2 : f0 f4 __ BEQ $32c8 ; (getch.l1 + 0)
.s2:
; 325, "E:/Apps/oscar64/include/conio.c"
32d4 : 4c d7 32 JMP $32d7 ; (convch.s0 + 0)
--------------------------------------------------------------------
convch: ; convch(u8)->u8
.s0:
32d7 : a8 __ __ TAY
; 246, "E:/Apps/oscar64/include/conio.c"
32d8 : ad a1 36 LDA $36a1 ; (giocharmap + 0)
32db : f0 27 __ BEQ $3304 ; (convch.s3 + 0)
.s1:
; 248, "E:/Apps/oscar64/include/conio.c"
32dd : c0 0d __ CPY #$0d
32df : d0 03 __ BNE $32e4 ; (convch.s5 + 0)
.s4:
; 263, "E:/Apps/oscar64/include/conio.c"
32e1 : a9 0a __ LDA #$0a
.s1001:
32e3 : 60 __ __ RTS
.s5:
; 250, "E:/Apps/oscar64/include/conio.c"
32e4 : c9 02 __ CMP #$02
32e6 : 90 1c __ BCC $3304 ; (convch.s3 + 0)
.s7:
; 252, "E:/Apps/oscar64/include/conio.c"
32e8 : 98 __ __ TYA
32e9 : c0 41 __ CPY #$41
32eb : 90 17 __ BCC $3304 ; (convch.s3 + 0)
.s13:
32ed : c9 db __ CMP #$db
32ef : b0 13 __ BCS $3304 ; (convch.s3 + 0)
.s10:
; 254, "E:/Apps/oscar64/include/conio.c"
32f1 : c9 c1 __ CMP #$c1
32f3 : 90 03 __ BCC $32f8 ; (convch.s16 + 0)
.s14:
; 255, "E:/Apps/oscar64/include/conio.c"
32f5 : 49 a0 __ EOR #$a0
32f7 : a8 __ __ TAY
.s16:
; 256, "E:/Apps/oscar64/include/conio.c"
32f8 : c9 7b __ CMP #$7b
32fa : b0 08 __ BCS $3304 ; (convch.s3 + 0)
.s20:
32fc : c9 61 __ CMP #$61
32fe : b0 06 __ BCS $3306 ; (convch.s17 + 0)
.s21:
3300 : c9 5b __ CMP #$5b
3302 : 90 02 __ BCC $3306 ; (convch.s17 + 0)
.s3:
; 263, "E:/Apps/oscar64/include/conio.c"
3304 : 98 __ __ TYA
3305 : 60 __ __ RTS
.s17:
; 257, "E:/Apps/oscar64/include/conio.c"
3306 : 49 20 __ EOR #$20
3308 : 60 __ __ RTS
--------------------------------------------------------------------
save_compact_map: ; save_compact_map(const u8*)->void
.s0:
;  13, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_export.c"
3309 : a5 12 __ LDA P5 ; (filename + 0)
330b : 85 0d __ STA P0 
330d : a5 13 __ LDA P6 ; (filename + 1)
330f : 85 0e __ STA P1 
3311 : 20 2b 33 JSR $332b ; (krnio_setnam.s0 + 0)
;  14, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_export.c"
3314 : a9 08 __ LDA #$08
3316 : 85 0d __ STA P0 
3318 : a9 40 __ LDA #$40
331a : 85 11 __ STA P4 
331c : a9 c8 __ LDA #$c8
331e : 85 0e __ STA P1 
3320 : a9 3a __ LDA #$3a
3322 : 85 0f __ STA P2 
3324 : a9 c8 __ LDA #$c8
3326 : 85 10 __ STA P3 
3328 : 4c 41 33 JMP $3341 ; (krnio_save.s0 + 0)
--------------------------------------------------------------------
krnio_setnam: ; krnio_setnam(const u8*)->void
.s0:
;  34, "E:/Apps/oscar64/include/c64/kernalio.c"
332b : a5 0d __ LDA P0 
332d : 05 0e __ ORA P1 
332f : f0 08 __ BEQ $3339 ; (krnio_setnam.s0 + 14)
3331 : a0 ff __ LDY #$ff
3333 : c8 __ __ INY
3334 : b1 0d __ LDA (P0),y 
3336 : d0 fb __ BNE $3333 ; (krnio_setnam.s0 + 8)
3338 : 98 __ __ TYA
3339 : a6 0d __ LDX P0 
333b : a4 0e __ LDY P1 
333d : 20 bd ff JSR $ffbd 
.s1001:
;  49, "E:/Apps/oscar64/include/c64/kernalio.c"
3340 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_save: ; krnio_save(u8,const u8*,const u8*)->bool
.s0:
; 161, "E:/Apps/oscar64/include/c64/kernalio.c"
3341 : a9 00 __ LDA #$00
3343 : a6 0d __ LDX P0 
3345 : a0 00 __ LDY #$00
3347 : 20 ba ff JSR $ffba 
334a : a9 0e __ LDA #$0e
334c : a6 10 __ LDX P3 
334e : a4 11 __ LDY P4 
3350 : 20 d8 ff JSR $ffd8 
3353 : a9 00 __ LDA #$00
3355 : 2a __ __ ROL
3356 : 49 01 __ EOR #$01
3358 : 85 1b __ STA ACCU + 0 
335a : a5 1b __ LDA ACCU + 0 
335c : f0 02 __ BEQ $3360 ; (krnio_save.s1001 + 0)
.s1006:
335e : a9 01 __ LDA #$01
.s1001:
; 158, "E:/Apps/oscar64/include/c64/kernalio.c"
3360 : 60 __ __ RTS
--------------------------------------------------------------------
3361 : __ __ __ BYT 4d 41 50 44 41 54 41 2e 42 49 4e 00             : MAPDATA.BIN.
--------------------------------------------------------------------
process_navigation_input: ; process_navigation_input(u8)->void
.s0:
; 180, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
336d : ad dc 36 LDA $36dc ; (view + 0)
3370 : 85 44 __ STA T3 + 0 
3372 : 8d f5 9f STA $9ff5 ; (s + 1)
; 184, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3375 : a9 00 __ LDA #$00
3377 : 8d f1 9f STA $9ff1 ; (second_part + 0)
; 181, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
337a : ad dd 36 LDA $36dd ; (view + 1)
337d : 85 45 __ STA T4 + 0 
337f : 8d f4 9f STA $9ff4 ; (entropy1 + 1)
; 182, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3382 : ad da 36 LDA $36da ; (camera_center_x + 0)
3385 : 85 43 __ STA T2 + 0 
3387 : 8d f3 9f STA $9ff3 ; (ix + 0)
; 183, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
338a : ad db 36 LDA $36db ; (camera_center_y + 0)
338d : 85 46 __ STA T5 + 0 
338f : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
; 187, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3392 : a5 0d __ LDA P0 ; (key + 0)
3394 : c9 61 __ CMP #$61
3396 : d0 03 __ BNE $339b ; (process_navigation_input.s19 + 0)
3398 : 4c 64 34 JMP $3464 ; (process_navigation_input.s10 + 0)
.s19:
339b : b0 03 __ BCS $33a0 ; (process_navigation_input.s20 + 0)
339d : 4c 52 34 JMP $3452 ; (process_navigation_input.s21 + 0)
.s20:
33a0 : c9 73 __ CMP #$73
33a2 : d0 03 __ BNE $33a7 ; (process_navigation_input.s28 + 0)
33a4 : 4c 47 34 JMP $3447 ; (process_navigation_input.s6 + 0)
.s28:
33a7 : b0 03 __ BCS $33ac ; (process_navigation_input.s29 + 0)
33a9 : 4c 35 34 JMP $3435 ; (process_navigation_input.s30 + 0)
.s29:
33ac : c9 77 __ CMP #$77
33ae : d0 41 __ BNE $33f1 ; (process_navigation_input.s1001 + 0)
.s2:
; 190, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
33b0 : a5 46 __ LDA T5 + 0 
33b2 : f0 3d __ BEQ $33f1 ; (process_navigation_input.s1001 + 0)
.s3:
; 191, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
33b4 : 69 fe __ ADC #$fe
.s70:
; 199, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
33b6 : 8d f2 9f STA $9ff2 ; (entropy2 + 1)
.s33:
; 208, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
33b9 : a9 01 __ LDA #$01
33bb : 8d f1 9f STA $9ff1 ; (second_part + 0)
; 223, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
33be : a5 43 __ LDA T2 + 0 
33c0 : 8d f0 9f STA $9ff0 ; (entropy3 + 1)
; 224, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
33c3 : a5 46 __ LDA T5 + 0 
33c5 : 8d ef 9f STA $9fef ; (screen_pos + 1)
; 226, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
33c8 : ad f3 9f LDA $9ff3 ; (ix + 0)
33cb : 8d da 36 STA $36da ; (camera_center_x + 0)
; 227, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
33ce : ad f2 9f LDA $9ff2 ; (entropy2 + 1)
33d1 : 8d db 36 STA $36db ; (camera_center_y + 0)
; 228, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
33d4 : 20 e3 17 JSR $17e3 ; (update_camera.s0 + 0)
; 232, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
33d7 : a5 44 __ LDA T3 + 0 
33d9 : cd dc 36 CMP $36dc ; (view + 0)
33dc : d0 07 __ BNE $33e5 ; (process_navigation_input.s36 + 0)
.s39:
33de : a5 45 __ LDA T4 + 0 
33e0 : cd dd 36 CMP $36dd ; (view + 1)
33e3 : f0 32 __ BEQ $3417 ; (process_navigation_input.s37 + 0)
.s36:
; 234, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
33e5 : ad dd 36 LDA $36dd ; (view + 1)
33e8 : c5 45 __ CMP T4 + 0 
33ea : b0 06 __ BCS $33f2 ; (process_navigation_input.s41 + 0)
.s40:
; 235, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
33ec : a9 01 __ LDA #$01
.s1002:
33ee : 8d c7 3a STA $3ac7 ; (last_scroll_direction + 0)
.s1001:
; 261, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
33f1 : 60 __ __ RTS
.s41:
; 236, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
33f2 : a5 45 __ LDA T4 + 0 
33f4 : cd dd 36 CMP $36dd ; (view + 1)
33f7 : b0 04 __ BCS $33fd ; (process_navigation_input.s44 + 0)
.s43:
; 237, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
33f9 : a9 02 __ LDA #$02
33fb : 90 f1 __ BCC $33ee ; (process_navigation_input.s1002 + 0)
.s44:
; 238, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
33fd : ad dc 36 LDA $36dc ; (view + 0)
3400 : c5 44 __ CMP T3 + 0 
3402 : b0 04 __ BCS $3408 ; (process_navigation_input.s47 + 0)
.s46:
; 239, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3404 : a9 03 __ LDA #$03
3406 : 90 e6 __ BCC $33ee ; (process_navigation_input.s1002 + 0)
.s47:
; 240, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3408 : a5 44 __ LDA T3 + 0 
340a : cd dc 36 CMP $36dc ; (view + 0)
340d : b0 04 __ BCS $3413 ; (process_navigation_input.s50 + 0)
.s49:
; 241, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
340f : a9 04 __ LDA #$04
3411 : 90 db __ BCC $33ee ; (process_navigation_input.s1002 + 0)
.s50:
; 243, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3413 : a9 00 __ LDA #$00
3415 : b0 d7 __ BCS $33ee ; (process_navigation_input.s1002 + 0)
.s37:
; 248, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3417 : ad db 36 LDA $36db ; (camera_center_y + 0)
341a : c5 46 __ CMP T5 + 0 
341c : 90 ce __ BCC $33ec ; (process_navigation_input.s40 + 0)
.s53:
; 250, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
341e : a5 46 __ LDA T5 + 0 
3420 : cd db 36 CMP $36db ; (camera_center_y + 0)
3423 : 90 d4 __ BCC $33f9 ; (process_navigation_input.s43 + 0)
.s56:
; 252, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3425 : ad da 36 LDA $36da ; (camera_center_x + 0)
3428 : c5 43 __ CMP T2 + 0 
342a : 90 d8 __ BCC $3404 ; (process_navigation_input.s46 + 0)
.s59:
; 254, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
342c : a5 43 __ LDA T2 + 0 
342e : cd da 36 CMP $36da ; (camera_center_x + 0)
3431 : b0 e0 __ BCS $3413 ; (process_navigation_input.s50 + 0)
3433 : 90 da __ BCC $340f ; (process_navigation_input.s49 + 0)
.s30:
; 187, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3435 : c9 64 __ CMP #$64
3437 : d0 b8 __ BNE $33f1 ; (process_navigation_input.s1001 + 0)
.s14:
; 214, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3439 : a5 43 __ LDA T2 + 0 
343b : c9 3f __ CMP #$3f
343d : b0 b2 __ BCS $33f1 ; (process_navigation_input.s1001 + 0)
.s15:
; 215, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
343f : 69 01 __ ADC #$01
.s71:
3441 : 8d f3 9f STA $9ff3 ; (ix + 0)
3444 : 4c b9 33 JMP $33b9 ; (process_navigation_input.s33 + 0)
.s6:
; 198, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3447 : a5 46 __ LDA T5 + 0 
3449 : c9 3f __ CMP #$3f
344b : b0 a4 __ BCS $33f1 ; (process_navigation_input.s1001 + 0)
.s7:
; 199, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
344d : 69 01 __ ADC #$01
344f : 4c b6 33 JMP $33b6 ; (process_navigation_input.s70 + 0)
.s21:
; 187, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3452 : c9 53 __ CMP #$53
3454 : f0 f1 __ BEQ $3447 ; (process_navigation_input.s6 + 0)
.s22:
3456 : 90 08 __ BCC $3460 ; (process_navigation_input.s24 + 0)
.s23:
3458 : c9 57 __ CMP #$57
345a : d0 03 __ BNE $345f ; (process_navigation_input.s23 + 7)
345c : 4c b0 33 JMP $33b0 ; (process_navigation_input.s2 + 0)
345f : 60 __ __ RTS
.s24:
3460 : c9 41 __ CMP #$41
3462 : d0 09 __ BNE $346d ; (process_navigation_input.s25 + 0)
.s10:
; 206, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3464 : a5 43 __ LDA T2 + 0 
3466 : f0 89 __ BEQ $33f1 ; (process_navigation_input.s1001 + 0)
.s11:
; 207, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
3468 : 69 fe __ ADC #$fe
346a : 4c 41 34 JMP $3441 ; (process_navigation_input.s71 + 0)
.s25:
; 187, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/testdisplay.c"
346d : c9 44 __ CMP #$44
346f : f0 c8 __ BEQ $3439 ; (process_navigation_input.s14 + 0)
3471 : 60 __ __ RTS
--------------------------------------------------------------------
mul16by8: ; mul16by8
3472 : 4a __ __ LSR
3473 : f0 2e __ BEQ $34a3 ; (mul16by8 + 49)
3475 : a2 00 __ LDX #$00
3477 : a0 00 __ LDY #$00
3479 : 90 13 __ BCC $348e ; (mul16by8 + 28)
347b : a4 1b __ LDY ACCU + 0 
347d : a6 1c __ LDX ACCU + 1 
347f : b0 0d __ BCS $348e ; (mul16by8 + 28)
3481 : 85 02 __ STA $02 
3483 : 18 __ __ CLC
3484 : 98 __ __ TYA
3485 : 65 1b __ ADC ACCU + 0 
3487 : a8 __ __ TAY
3488 : 8a __ __ TXA
3489 : 65 1c __ ADC ACCU + 1 
348b : aa __ __ TAX
348c : a5 02 __ LDA $02 
348e : 06 1b __ ASL ACCU + 0 
3490 : 26 1c __ ROL ACCU + 1 
3492 : 4a __ __ LSR
3493 : 90 f9 __ BCC $348e ; (mul16by8 + 28)
3495 : d0 ea __ BNE $3481 ; (mul16by8 + 15)
3497 : 18 __ __ CLC
3498 : 98 __ __ TYA
3499 : 65 1b __ ADC ACCU + 0 
349b : 85 1b __ STA ACCU + 0 
349d : 8a __ __ TXA
349e : 65 1c __ ADC ACCU + 1 
34a0 : 85 1c __ STA ACCU + 1 
34a2 : 60 __ __ RTS
34a3 : b0 04 __ BCS $34a9 ; (mul16by8 + 55)
34a5 : 85 1b __ STA ACCU + 0 
34a7 : 85 1c __ STA ACCU + 1 
34a9 : 60 __ __ RTS
--------------------------------------------------------------------
mul16: ; mul16
34aa : a0 00 __ LDY #$00
34ac : 84 06 __ STY WORK + 3 
34ae : a5 03 __ LDA WORK + 0 
34b0 : a6 04 __ LDX WORK + 1 
34b2 : f0 1c __ BEQ $34d0 ; (mul16 + 38)
34b4 : 38 __ __ SEC
34b5 : 6a __ __ ROR
34b6 : 90 0d __ BCC $34c5 ; (mul16 + 27)
34b8 : aa __ __ TAX
34b9 : 18 __ __ CLC
34ba : 98 __ __ TYA
34bb : 65 1b __ ADC ACCU + 0 
34bd : a8 __ __ TAY
34be : a5 06 __ LDA WORK + 3 
34c0 : 65 1c __ ADC ACCU + 1 
34c2 : 85 06 __ STA WORK + 3 
34c4 : 8a __ __ TXA
34c5 : 06 1b __ ASL ACCU + 0 
34c7 : 26 1c __ ROL ACCU + 1 
34c9 : 4a __ __ LSR
34ca : 90 f9 __ BCC $34c5 ; (mul16 + 27)
34cc : d0 ea __ BNE $34b8 ; (mul16 + 14)
34ce : a5 04 __ LDA WORK + 1 
34d0 : 4a __ __ LSR
34d1 : 90 0d __ BCC $34e0 ; (mul16 + 54)
34d3 : aa __ __ TAX
34d4 : 18 __ __ CLC
34d5 : 98 __ __ TYA
34d6 : 65 1b __ ADC ACCU + 0 
34d8 : a8 __ __ TAY
34d9 : a5 06 __ LDA WORK + 3 
34db : 65 1c __ ADC ACCU + 1 
34dd : 85 06 __ STA WORK + 3 
34df : 8a __ __ TXA
34e0 : 06 1b __ ASL ACCU + 0 
34e2 : 26 1c __ ROL ACCU + 1 
34e4 : 4a __ __ LSR
34e5 : b0 ec __ BCS $34d3 ; (mul16 + 41)
34e7 : d0 f7 __ BNE $34e0 ; (mul16 + 54)
34e9 : 84 05 __ STY WORK + 2 
34eb : 60 __ __ RTS
--------------------------------------------------------------------
divmod: ; divmod
34ec : a5 1c __ LDA ACCU + 1 
34ee : d0 31 __ BNE $3521 ; (divmod + 53)
34f0 : a5 04 __ LDA WORK + 1 
34f2 : d0 1e __ BNE $3512 ; (divmod + 38)
34f4 : 85 06 __ STA WORK + 3 
34f6 : a2 04 __ LDX #$04
34f8 : 06 1b __ ASL ACCU + 0 
34fa : 2a __ __ ROL
34fb : c5 03 __ CMP WORK + 0 
34fd : 90 02 __ BCC $3501 ; (divmod + 21)
34ff : e5 03 __ SBC WORK + 0 
3501 : 26 1b __ ROL ACCU + 0 
3503 : 2a __ __ ROL
3504 : c5 03 __ CMP WORK + 0 
3506 : 90 02 __ BCC $350a ; (divmod + 30)
3508 : e5 03 __ SBC WORK + 0 
350a : 26 1b __ ROL ACCU + 0 
350c : ca __ __ DEX
350d : d0 eb __ BNE $34fa ; (divmod + 14)
350f : 85 05 __ STA WORK + 2 
3511 : 60 __ __ RTS
3512 : a5 1b __ LDA ACCU + 0 
3514 : 85 05 __ STA WORK + 2 
3516 : a5 1c __ LDA ACCU + 1 
3518 : 85 06 __ STA WORK + 3 
351a : a9 00 __ LDA #$00
351c : 85 1b __ STA ACCU + 0 
351e : 85 1c __ STA ACCU + 1 
3520 : 60 __ __ RTS
3521 : a5 04 __ LDA WORK + 1 
3523 : d0 1f __ BNE $3544 ; (divmod + 88)
3525 : a5 03 __ LDA WORK + 0 
3527 : 30 1b __ BMI $3544 ; (divmod + 88)
3529 : a9 00 __ LDA #$00
352b : 85 06 __ STA WORK + 3 
352d : a2 10 __ LDX #$10
352f : 06 1b __ ASL ACCU + 0 
3531 : 26 1c __ ROL ACCU + 1 
3533 : 2a __ __ ROL
3534 : c5 03 __ CMP WORK + 0 
3536 : 90 02 __ BCC $353a ; (divmod + 78)
3538 : e5 03 __ SBC WORK + 0 
353a : 26 1b __ ROL ACCU + 0 
353c : 26 1c __ ROL ACCU + 1 
353e : ca __ __ DEX
353f : d0 f2 __ BNE $3533 ; (divmod + 71)
3541 : 85 05 __ STA WORK + 2 
3543 : 60 __ __ RTS
3544 : a9 00 __ LDA #$00
3546 : 85 05 __ STA WORK + 2 
3548 : 85 06 __ STA WORK + 3 
354a : 84 02 __ STY $02 
354c : a0 10 __ LDY #$10
354e : 18 __ __ CLC
354f : 26 1b __ ROL ACCU + 0 
3551 : 26 1c __ ROL ACCU + 1 
3553 : 26 05 __ ROL WORK + 2 
3555 : 26 06 __ ROL WORK + 3 
3557 : 38 __ __ SEC
3558 : a5 05 __ LDA WORK + 2 
355a : e5 03 __ SBC WORK + 0 
355c : aa __ __ TAX
355d : a5 06 __ LDA WORK + 3 
355f : e5 04 __ SBC WORK + 1 
3561 : 90 04 __ BCC $3567 ; (divmod + 123)
3563 : 86 05 __ STX WORK + 2 
3565 : 85 06 __ STA WORK + 3 
3567 : 88 __ __ DEY
3568 : d0 e5 __ BNE $354f ; (divmod + 99)
356a : 26 1b __ ROL ACCU + 0 
356c : 26 1c __ ROL ACCU + 1 
356e : a4 02 __ LDY $02 
3570 : 60 __ __ RTS
--------------------------------------------------------------------
__multab7982L:
3571 : __ __ __ BYT 00 2e 5c 8a b8 e6 14 42 70                      : ..\....Bp
--------------------------------------------------------------------
__multab7982H:
357a : __ __ __ BYT 00 1f 3e 5d 7c 9b bb da f9                      : ..>]|....
--------------------------------------------------------------------
__multab14L:
3583 : __ __ __ BYT 00 0e 1c 2a                                     : ...*
--------------------------------------------------------------------
__shltab7L:
3587 : __ __ __ BYT 07 0e 1c 38 70 e0                               : ...8p.
--------------------------------------------------------------------
spentry:
358d : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
generation_counter:
358e : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
rng_seed:
3590 : __ __ __ BYT 01 00                                           : ..
--------------------------------------------------------------------
room_count:
3592 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
room_center_cache_valid:
3593 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
corridor_pool:
3594 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
35a4 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
35b4 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
35c4 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
35d4 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
35e4 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
35f4 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3604 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3614 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3624 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3634 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3644 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3654 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
connection_cache:
3656 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3666 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3676 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3686 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3696 : __ __ __ BYT 00 00 00 00 00 00 00 00 00                      : .........
--------------------------------------------------------------------
distance_cache_valid:
369f : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
corridor_endpoint_override:
36a0 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
giocharmap:
36a1 : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
bitshift:
36a2 : __ __ __ BYT 00 00 00 00 00 00 00 00 01 02 04 08 10 20 40 80 : ............. @.
36b2 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
36c2 : __ __ __ BYT 80 40 20 10 08 04 02 01 00 00 00 00 00 00 00 00 : .@ .............
36d2 : __ __ __ BYT 00 00 00 00 00 00 00 00                         : ........
--------------------------------------------------------------------
camera_center_x:
36da : __ __ __ BSS	1
--------------------------------------------------------------------
camera_center_y:
36db : __ __ __ BSS	1
--------------------------------------------------------------------
view:
36dc : __ __ __ BSS	2
--------------------------------------------------------------------
screen_buffer:
36de : __ __ __ BSS	1000
--------------------------------------------------------------------
screen_dirty:
3ac6 : __ __ __ BSS	1
--------------------------------------------------------------------
last_scroll_direction:
3ac7 : __ __ __ BSS	1
--------------------------------------------------------------------
compact_map:
3ac8 : __ __ __ BSS	1536
--------------------------------------------------------------------
connection_matrix:
40c8 : __ __ __ BSS	400
--------------------------------------------------------------------
room_distance_cache:
4258 : __ __ __ BSS	400
--------------------------------------------------------------------
visited_global:
43e8 : __ __ __ BSS	20
--------------------------------------------------------------------
rooms:
4400 : __ __ __ BSS	160
--------------------------------------------------------------------
room_center_cache:
44a0 : __ __ __ BSS	40
--------------------------------------------------------------------
stack_global:
44c8 : __ __ __ BSS	20
--------------------------------------------------------------------
corridor_path_static:
4500 : __ __ __ BSS	41
