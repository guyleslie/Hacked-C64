; Compiled with 1.31.261.0
--------------------------------------------------------------------
mst_best_distance:
00f7 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
mst_best_room1:
00f8 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
mst_best_room2:
00f9 : __ __ __ BYT 00                                              : .
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
080e : 8e d9 3f STX $3fd9 ; (spentry + 0)
0811 : a2 41 __ LDX #$41
0813 : a0 38 __ LDY #$38
0815 : a9 00 __ LDA #$00
0817 : 85 19 __ STA IP + 0 
0819 : 86 1a __ STX IP + 1 
081b : e0 52 __ CPX #$52
081d : f0 0b __ BEQ $082a ; (startup + 41)
081f : 91 19 __ STA (IP + 0),y 
0821 : c8 __ __ INY
0822 : d0 fb __ BNE $081f ; (startup + 30)
0824 : e8 __ __ INX
0825 : d0 f2 __ BNE $0819 ; (startup + 24)
0827 : 91 19 __ STA (IP + 0),y 
0829 : c8 __ __ INY
082a : c0 a9 __ CPY #$a9
082c : d0 f9 __ BNE $0827 ; (startup + 38)
082e : a9 00 __ LDA #$00
0830 : a2 f7 __ LDX #$f7
0832 : d0 03 __ BNE $0837 ; (startup + 54)
0834 : 95 00 __ STA $00,x 
0836 : e8 __ __ INX
0837 : e0 fa __ CPX #$fa
0839 : d0 f9 __ BNE $0834 ; (startup + 51)
083b : a9 70 __ LDA #$70
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
;  57, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
0880 : 20 df 08 JSR $08df ; (clrscr.s0 + 0)
;  60, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
0883 : 20 ec 08 JSR $08ec ; (set_mixed_charset.s0 + 0)
;  63, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
0886 : 20 f5 08 JSR $08f5 ; (init_rng.s0 + 0)
;  66, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
0889 : a9 01 __ LDA #$01
088b : 85 15 __ STA P8 
088d : a9 00 __ LDA #$00
088f : 85 16 __ STA P9 
0891 : 20 49 0b JSR $0b49 ; (mapgen_init.s0 + 0)
.l38:
;  85, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
0894 : 20 02 0e JSR $0e02 ; (mapgen_generate_dungeon.s0 + 0)
;  87, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
0897 : a9 01 __ LDA #$01
.l37:
0899 : 85 14 __ STA P7 
089b : 20 64 37 JSR $3764 ; (render_map_viewport.s0 + 0)
089e : 4c ac 08 JMP $08ac ; (main.l3 + 0)
.s13:
;  91, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08a1 : a9 ad __ LDA #$ad
08a3 : 85 12 __ STA P5 
08a5 : a9 3d __ LDA #$3d
08a7 : 85 13 __ STA P6 
08a9 : 20 4b 3d JSR $3d4b ; (save_compact_map.s0 + 0)
.l3:
;  76, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08ac : 20 0a 3d JSR $3d0a ; (getch.l1 + 0)
08af : 8d 72 9f STA $9f72 ; (key + 0)
;  78, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08b2 : c9 51 __ CMP #$51
08b4 : f0 1f __ BEQ $08d5 ; (main.s5 + 0)
.s8:
08b6 : c9 71 __ CMP #$71
08b8 : f0 1b __ BEQ $08d5 ; (main.s5 + 0)
.s6:
;  82, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08ba : c9 20 __ CMP #$20
08bc : d0 06 __ BNE $08c4 ; (main.s11 + 0)
.s10:
;  83, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08be : 20 df 08 JSR $08df ; (clrscr.s0 + 0)
08c1 : 4c 94 08 JMP $0894 ; (main.l38 + 0)
.s11:
;  89, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08c4 : c9 4d __ CMP #$4d
08c6 : f0 d9 __ BEQ $08a1 ; (main.s13 + 0)
.s16:
08c8 : c9 6d __ CMP #$6d
08ca : f0 d5 __ BEQ $08a1 ; (main.s13 + 0)
.s14:
;  94, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08cc : 85 0d __ STA P0 
08ce : 20 b9 3d JSR $3db9 ; (process_navigation_input.s0 + 0)
;  95, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08d1 : a9 00 __ LDA #$00
08d3 : f0 c4 __ BEQ $0899 ; (main.l37 + 0)
.s5:
;  79, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08d5 : 20 df 08 JSR $08df ; (clrscr.s0 + 0)
;  99, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08d8 : a9 00 __ LDA #$00
08da : 85 1b __ STA ACCU + 0 
08dc : 85 1c __ STA ACCU + 1 
.s1001:
08de : 60 __ __ RTS
--------------------------------------------------------------------
clrscr: ; clrscr()->void
.s0:
; 345, "E:/Apps/oscar64/include/conio.c"
08df : a9 93 __ LDA #$93
08e1 : 4c e4 08 JMP $08e4 ; (putrch.s0 + 0)
--------------------------------------------------------------------
putrch: ; putrch(u8)->void
.s0:
08e4 : 85 0d __ STA P0 
; 193, "E:/Apps/oscar64/include/conio.c"
08e6 : a5 0d __ LDA P0 
08e8 : 20 d2 ff JSR $ffd2 
.s1001:
; 196, "E:/Apps/oscar64/include/conio.c"
08eb : 60 __ __ RTS
--------------------------------------------------------------------
set_mixed_charset: ; set_mixed_charset()->void
.s0:
;  27, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08ec : ad 18 d0 LDA $d018 
08ef : 09 02 __ ORA #$02
08f1 : 8d 18 d0 STA $d018 
.s1001:
;  28, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/main.c"
08f4 : 60 __ __ RTS
--------------------------------------------------------------------
init_rng: ; init_rng()->void
.s0:
; 119, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
08f5 : 20 42 0a JSR $0a42 ; (get_hardware_entropy.s0 + 0)
08f8 : a5 1b __ LDA ACCU + 0 
08fa : 85 48 __ STA T3 + 0 
08fc : 8d eb 9f STA $9feb ; (i + 0)
08ff : a5 1c __ LDA ACCU + 1 
0901 : 85 49 __ STA T3 + 1 
0903 : 8d ec 9f STA $9fec ; (entropy1 + 1)
; 120, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0906 : 20 42 0a JSR $0a42 ; (get_hardware_entropy.s0 + 0)
0909 : a5 1b __ LDA ACCU + 0 
090b : 85 4a __ STA T4 + 0 
090d : 8d e9 9f STA $9fe9 ; (connected + 1)
0910 : a5 1c __ LDA ACCU + 1 
0912 : 85 4b __ STA T4 + 1 
0914 : 8d ea 9f STA $9fea ; (entropy2 + 1)
; 121, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0917 : 20 42 0a JSR $0a42 ; (get_hardware_entropy.s0 + 0)
091a : a5 1b __ LDA ACCU + 0 
091c : 85 46 __ STA T2 + 0 
091e : 8d e7 9f STA $9fe7 ; (idx + 0)
0921 : a5 1c __ LDA ACCU + 1 
0923 : 85 47 __ STA T2 + 1 
0925 : 8d e8 9f STA $9fe8 ; (entropy3 + 1)
; 122, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0928 : 20 42 0a JSR $0a42 ; (get_hardware_entropy.s0 + 0)
092b : a5 1b __ LDA ACCU + 0 
092d : 8d e5 9f STA $9fe5 ; (leg1_end_x + 0)
; 125, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0930 : a9 00 __ LDA #$00
0932 : 8d db 3f STA $3fdb ; (generation_counter + 1)
; 137, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0935 : 8d e4 9f STA $9fe4 ; (random_offset_x + 0)
; 125, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0938 : a9 01 __ LDA #$01
093a : 8d da 3f STA $3fda ; (generation_counter + 0)
; 122, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
093d : a5 4a __ LDA T4 + 0 
093f : 0a __ __ ASL
0940 : 85 44 __ STA T1 + 0 
0942 : a5 4b __ LDA T4 + 1 
0944 : 2a __ __ ROL
0945 : 06 44 __ ASL T1 + 0 
0947 : 2a __ __ ROL
0948 : 06 44 __ ASL T1 + 0 
094a : 2a __ __ ROL
094b : 45 49 __ EOR T3 + 1 
094d : aa __ __ TAX
094e : a5 44 __ LDA T1 + 0 
0950 : 45 48 __ EOR T3 + 0 
0952 : 85 44 __ STA T1 + 0 
0954 : a5 46 __ LDA T2 + 0 
0956 : 46 47 __ LSR T2 + 1 
0958 : 6a __ __ ROR
0959 : 46 47 __ LSR T2 + 1 
095b : 6a __ __ ROR
095c : 45 44 __ EOR T1 + 0 
095e : a8 __ __ TAY
095f : 8a __ __ TXA
0960 : 45 47 __ EOR T2 + 1 
0962 : 85 45 __ STA T1 + 1 
0964 : a5 1c __ LDA ACCU + 1 
0966 : 8d e6 9f STA $9fe6 ; (screen_pos + 1)
; 129, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0969 : 06 1b __ ASL ACCU + 0 
096b : 2a __ __ ROL
096c : 06 1b __ ASL ACCU + 0 
096e : 2a __ __ ROL
096f : 06 1b __ ASL ACCU + 0 
0971 : 2a __ __ ROL
0972 : 06 1b __ ASL ACCU + 0 
0974 : 2a __ __ ROL
0975 : 06 1b __ ASL ACCU + 0 
0977 : 2a __ __ ROL
0978 : 45 45 __ EOR T1 + 1 
097a : 8d dd 3f STA $3fdd ; (rng_seed + 1)
097d : 98 __ __ TYA
097e : 45 1b __ EOR ACCU + 0 
0980 : 49 80 __ EOR #$80
0982 : 8d dc 3f STA $3fdc ; (rng_seed + 0)
; 130, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0985 : 0a __ __ ASL
0986 : 85 44 __ STA T1 + 0 
0988 : ad dd 3f LDA $3fdd ; (rng_seed + 1)
098b : 2a __ __ ROL
098c : 06 44 __ ASL T1 + 0 
098e : 2a __ __ ROL
098f : 06 44 __ ASL T1 + 0 
0991 : 2a __ __ ROL
0992 : 06 44 __ ASL T1 + 0 
0994 : 2a __ __ ROL
0995 : 06 44 __ ASL T1 + 0 
0997 : 2a __ __ ROL
0998 : aa __ __ TAX
0999 : ad dd 3f LDA $3fdd ; (rng_seed + 1)
099c : 4a __ __ LSR
099d : 4a __ __ LSR
099e : 4a __ __ LSR
099f : 45 44 __ EOR T1 + 0 
09a1 : 49 1d __ EOR #$1d
09a3 : 8d dc 3f STA $3fdc ; (rng_seed + 0)
09a6 : 8a __ __ TXA
09a7 : 49 ac __ EOR #$ac
09a9 : 8d dd 3f STA $3fdd ; (rng_seed + 1)
; 133, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
09ac : ad dc 3f LDA $3fdc ; (rng_seed + 0)
09af : 49 37 __ EOR #$37
09b1 : 8d dc 3f STA $3fdc ; (rng_seed + 0)
09b4 : ad dd 3f LDA $3fdd ; (rng_seed + 1)
09b7 : 49 9e __ EOR #$9e
09b9 : 8d dd 3f STA $3fdd ; (rng_seed + 1)
; 134, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
09bc : 18 __ __ CLC
09bd : a5 4a __ LDA T4 + 0 
09bf : 65 48 __ ADC T3 + 0 
09c1 : 85 1b __ STA ACCU + 0 
09c3 : a5 4b __ LDA T4 + 1 
09c5 : 65 49 __ ADC T3 + 1 
09c7 : 85 1c __ STA ACCU + 1 
09c9 : a9 2f __ LDA #$2f
09cb : 85 03 __ STA WORK + 0 
09cd : a9 5a __ LDA #$5a
09cf : 85 04 __ STA WORK + 1 
09d1 : 20 f6 3e JSR $3ef6 ; (mul16 + 0)
09d4 : a5 05 __ LDA WORK + 2 
09d6 : 4d dc 3f EOR $3fdc ; (rng_seed + 0)
09d9 : 8d dc 3f STA $3fdc ; (rng_seed + 0)
09dc : a5 06 __ LDA WORK + 3 
09de : 4d dd 3f EOR $3fdd ; (rng_seed + 1)
09e1 : 8d dd 3f STA $3fdd ; (rng_seed + 1)
.l2:
; 138, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
09e4 : ad dc 3f LDA $3fdc ; (rng_seed + 0)
09e7 : 0a __ __ ASL
09e8 : 85 44 __ STA T1 + 0 
09ea : ad dd 3f LDA $3fdd ; (rng_seed + 1)
09ed : 2a __ __ ROL
09ee : 06 44 __ ASL T1 + 0 
09f0 : 2a __ __ ROL
09f1 : 06 44 __ ASL T1 + 0 
09f3 : 2a __ __ ROL
09f4 : 85 45 __ STA T1 + 1 
09f6 : ad dd 3f LDA $3fdd ; (rng_seed + 1)
09f9 : 4a __ __ LSR
09fa : 4a __ __ LSR
09fb : 4a __ __ LSR
09fc : 4a __ __ LSR
09fd : 4a __ __ LSR
09fe : 45 44 __ EOR T1 + 0 
0a00 : ac e4 9f LDY $9fe4 ; (random_offset_x + 0)
0a03 : 59 bd 3f EOR $3fbd,y ; (__multab7982L + 0)
0a06 : 8d dc 3f STA $3fdc ; (rng_seed + 0)
0a09 : aa __ __ TAX
0a0a : b9 c6 3f LDA $3fc6,y ; (__multab7982H + 0)
0a0d : 45 45 __ EOR T1 + 1 
0a0f : 85 1c __ STA ACCU + 1 
0a11 : 8d dd 3f STA $3fdd ; (rng_seed + 1)
; 137, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0a14 : ee e4 9f INC $9fe4 ; (random_offset_x + 0)
0a17 : ad e4 9f LDA $9fe4 ; (random_offset_x + 0)
0a1a : c9 04 __ CMP #$04
0a1c : 90 c6 __ BCC $09e4 ; (init_rng.l2 + 0)
.s4:
; 145, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0a1e : a9 00 __ LDA #$00
0a20 : 8d e4 9f STA $9fe4 ; (random_offset_x + 0)
; 142, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0a23 : 8a __ __ TXA
0a24 : 05 1c __ ORA ACCU + 1 
0a26 : d0 0a __ BNE $0a32 ; (init_rng.l9 + 0)
.s5:
0a28 : a9 22 __ LDA #$22
0a2a : 8d dc 3f STA $3fdc ; (rng_seed + 0)
0a2d : a9 1d __ LDA #$1d
0a2f : 8d dd 3f STA $3fdd ; (rng_seed + 1)
.l9:
; 146, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0a32 : a9 ff __ LDA #$ff
0a34 : 20 50 0a JSR $0a50 ; (rnd.s0 + 0)
; 145, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0a37 : ee e4 9f INC $9fe4 ; (random_offset_x + 0)
0a3a : ad e4 9f LDA $9fe4 ; (random_offset_x + 0)
0a3d : c9 08 __ CMP #$08
0a3f : 90 f1 __ BCC $0a32 ; (init_rng.l9 + 0)
.s1001:
; 148, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0a41 : 60 __ __ RTS
--------------------------------------------------------------------
get_hardware_entropy: ; get_hardware_entropy()->u16
.s0:
; 110, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0a42 : ad 12 d0 LDA $d012 
0a45 : 4d 04 dc EOR $dc04 
0a48 : 85 1b __ STA ACCU + 0 
0a4a : ad 05 dc LDA $dc05 
0a4d : 85 1c __ STA ACCU + 1 
.s1001:
0a4f : 60 __ __ RTS
--------------------------------------------------------------------
rnd: ; rnd(u8)->u8
.s0:
; 152, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0a50 : c9 02 __ CMP #$02
0a52 : b0 03 __ BCS $0a57 ; (rnd.s3 + 0)
.s1:
0a54 : a9 00 __ LDA #$00
.s1001:
; 192, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0a56 : 60 __ __ RTS
.s3:
0a57 : 85 0d __ STA P0 ; (max + 0)
; 156, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0a59 : ad dc 3f LDA $3fdc ; (rng_seed + 0)
0a5c : 85 1b __ STA ACCU + 0 
0a5e : 8d f0 9f STA $9ff0 ; (r1 + 0)
; 155, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0a61 : ad dd 3f LDA $3fdd ; (rng_seed + 1)
0a64 : 85 1c __ STA ACCU + 1 
0a66 : 85 43 __ STA T1 + 0 
0a68 : 8d f1 9f STA $9ff1 ; (r1 + 1)
; 157, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0a6b : 10 04 __ BPL $0a71 ; (rnd.s42 + 0)
.s41:
0a6d : a9 01 __ LDA #$01
0a6f : b0 02 __ BCS $0a73 ; (rnd.s43 + 0)
.s42:
; 157, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0a71 : a9 00 __ LDA #$00
.s43:
0a73 : 8d ef 9f STA $9fef ; (byte_ptr + 1)
; 160, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0a76 : 06 1b __ ASL ACCU + 0 
0a78 : 26 1c __ ROL ACCU + 1 
0a7a : aa __ __ TAX
0a7b : a5 1b __ LDA ACCU + 0 
0a7d : 8d dc 3f STA $3fdc ; (rng_seed + 0)
0a80 : a4 1c __ LDY ACCU + 1 
0a82 : 8c dd 3f STY $3fdd ; (rng_seed + 1)
; 163, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0a85 : 8a __ __ TXA
0a86 : f0 0b __ BEQ $0a93 ; (rnd.s7 + 0)
.s5:
; 164, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0a88 : 98 __ __ TYA
0a89 : 49 b4 __ EOR #$b4
0a8b : 8d dd 3f STA $3fdd ; (rng_seed + 1)
0a8e : a5 1b __ LDA ACCU + 0 
0a90 : 8d dc 3f STA $3fdc ; (rng_seed + 0)
.s7:
; 168, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0a93 : a9 00 __ LDA #$00
0a95 : 06 43 __ ASL T1 + 0 
0a97 : 2a __ __ ROL
0a98 : 06 43 __ ASL T1 + 0 
0a9a : 2a __ __ ROL
0a9b : 06 43 __ ASL T1 + 0 
0a9d : 2a __ __ ROL
0a9e : 06 43 __ ASL T1 + 0 
0aa0 : 2a __ __ ROL
0aa1 : 06 43 __ ASL T1 + 0 
0aa3 : 2a __ __ ROL
0aa4 : aa __ __ TAX
0aa5 : ad f0 9f LDA $9ff0 ; (r1 + 0)
0aa8 : 4a __ __ LSR
0aa9 : 4a __ __ LSR
0aaa : 4a __ __ LSR
0aab : 05 43 __ ORA T1 + 0 
0aad : 4d dc 3f EOR $3fdc ; (rng_seed + 0)
0ab0 : 8d dc 3f STA $3fdc ; (rng_seed + 0)
0ab3 : 8a __ __ TXA
0ab4 : 4d dd 3f EOR $3fdd ; (rng_seed + 1)
0ab7 : 8d dd 3f STA $3fdd ; (rng_seed + 1)
; 171, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0aba : 4d dc 3f EOR $3fdc ; (rng_seed + 0)
0abd : 8d ee 9f STA $9fee ; (result + 0)
; 174, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0ac0 : a5 0d __ LDA P0 ; (max + 0)
0ac2 : c9 08 __ CMP #$08
0ac4 : d0 06 __ BNE $0acc ; (rnd.s19 + 0)
.s11:
; 180, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0ac6 : ad ee 9f LDA $9fee ; (result + 0)
0ac9 : 29 07 __ AND #$07
0acb : 60 __ __ RTS
.s19:
; 174, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0acc : 90 67 __ BCC $0b35 ; (rnd.s21 + 0)
.s20:
0ace : c9 10 __ CMP #$10
0ad0 : d0 06 __ BNE $0ad8 ; (rnd.s14 + 0)
.s12:
; 182, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0ad2 : ad ee 9f LDA $9fee ; (result + 0)
0ad5 : 29 0f __ AND #$0f
0ad7 : 60 __ __ RTS
.s14:
; 186, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0ad8 : a9 00 __ LDA #$00
0ada : 85 1b __ STA ACCU + 0 
0adc : 85 04 __ STA WORK + 1 
0ade : a5 0d __ LDA P0 ; (max + 0)
0ae0 : 85 03 __ STA WORK + 0 
0ae2 : a9 01 __ LDA #$01
0ae4 : 85 1c __ STA ACCU + 1 
0ae6 : 20 38 3f JSR $3f38 ; (divmod + 0)
0ae9 : a5 0d __ LDA P0 ; (max + 0)
0aeb : 20 be 3e JSR $3ebe ; (mul16by8 + 0)
0aee : a5 1b __ LDA ACCU + 0 
0af0 : 8d ed 9f STA $9fed ; (s + 1)
; 187, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0af3 : ad ee 9f LDA $9fee ; (result + 0)
0af6 : c5 1b __ CMP ACCU + 0 
0af8 : 90 29 __ BCC $0b23 ; (rnd.s17 + 0)
.l16:
; 189, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0afa : ad dc 3f LDA $3fdc ; (rng_seed + 0)
0afd : 0a __ __ ASL
0afe : 85 1c __ STA ACCU + 1 
0b00 : ad dd 3f LDA $3fdd ; (rng_seed + 1)
0b03 : 2a __ __ ROL
0b04 : aa __ __ TAX
0b05 : ad dd 3f LDA $3fdd ; (rng_seed + 1)
0b08 : 0a __ __ ASL
0b09 : a9 00 __ LDA #$00
0b0b : 2a __ __ ROL
0b0c : 45 1c __ EOR ACCU + 1 
0b0e : 49 37 __ EOR #$37
0b10 : 8d dc 3f STA $3fdc ; (rng_seed + 0)
0b13 : 8a __ __ TXA
0b14 : 49 9e __ EOR #$9e
0b16 : 8d dd 3f STA $3fdd ; (rng_seed + 1)
; 190, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0b19 : 4d dc 3f EOR $3fdc ; (rng_seed + 0)
0b1c : 8d ee 9f STA $9fee ; (result + 0)
; 187, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0b1f : c5 1b __ CMP ACCU + 0 
0b21 : b0 d7 __ BCS $0afa ; (rnd.l16 + 0)
.s17:
; 192, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0b23 : 85 1b __ STA ACCU + 0 
0b25 : a9 00 __ LDA #$00
0b27 : 85 1c __ STA ACCU + 1 
0b29 : 85 04 __ STA WORK + 1 
0b2b : a5 0d __ LDA P0 ; (max + 0)
0b2d : 85 03 __ STA WORK + 0 
0b2f : 20 38 3f JSR $3f38 ; (divmod + 0)
0b32 : a5 05 __ LDA WORK + 2 
0b34 : 60 __ __ RTS
.s21:
; 174, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0b35 : c9 02 __ CMP #$02
0b37 : d0 06 __ BNE $0b3f ; (rnd.s22 + 0)
.s9:
; 176, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0b39 : ad ee 9f LDA $9fee ; (result + 0)
0b3c : 29 01 __ AND #$01
0b3e : 60 __ __ RTS
.s22:
; 174, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0b3f : c9 04 __ CMP #$04
0b41 : d0 95 __ BNE $0ad8 ; (rnd.s14 + 0)
.s10:
; 178, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0b43 : ad ee 9f LDA $9fee ; (result + 0)
0b46 : 29 03 __ AND #$03
0b48 : 60 __ __ RTS
--------------------------------------------------------------------
mapgen_init: ; mapgen_init(u16)->void
.s0:
;1098, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0b49 : a9 00 __ LDA #$00
0b4b : 8d de 3f STA $3fde ; (room_count + 0)
;1097, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0b4e : a5 15 __ LDA P8 ; (seed + 0)
0b50 : 8d dc 3f STA $3fdc ; (rng_seed + 0)
0b53 : a5 16 __ LDA P9 ; (seed + 1)
0b55 : 8d dd 3f STA $3fdd ; (rng_seed + 1)
;1099, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0b58 : 20 61 0b JSR $0b61 ; (clear_map.s0 + 0)
;1100, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0b5b : 20 a1 0b JSR $0ba1 ; (clear_room_center_cache.s0 + 0)
;1101, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0b5e : 4c a7 0b JMP $0ba7 ; (init_connection_system.s0 + 0)
--------------------------------------------------------------------
clear_map: ; clear_map()->void
.s0:
; 383, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0b61 : a9 00 __ LDA #$00
0b63 : 85 43 __ STA T1 + 0 
0b65 : 8d f0 9f STA $9ff0 ; (r1 + 0)
; 387, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0b68 : 8d ee 9f STA $9fee ; (result + 0)
0b6b : 8d ef 9f STA $9fef ; (byte_ptr + 1)
; 383, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0b6e : a9 06 __ LDA #$06
0b70 : 8d f1 9f STA $9ff1 ; (r1 + 1)
.l1005:
; 388, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0b73 : 18 __ __ CLC
0b74 : a9 38 __ LDA #$38
0b76 : 6d ee 9f ADC $9fee ; (result + 0)
0b79 : a8 __ __ TAY
0b7a : ad ef 9f LDA $9fef ; (byte_ptr + 1)
0b7d : 85 1c __ STA ACCU + 1 
0b7f : 69 41 __ ADC #$41
0b81 : 85 44 __ STA T1 + 1 
0b83 : a9 00 __ LDA #$00
0b85 : ae ee 9f LDX $9fee ; (result + 0)
0b88 : 91 43 __ STA (T1 + 0),y 
; 387, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0b8a : 8a __ __ TXA
0b8b : 69 01 __ ADC #$01
0b8d : 8d ee 9f STA $9fee ; (result + 0)
0b90 : a5 1c __ LDA ACCU + 1 
0b92 : 69 00 __ ADC #$00
0b94 : 8d ef 9f STA $9fef ; (byte_ptr + 1)
0b97 : c9 06 __ CMP #$06
0b99 : d0 d8 __ BNE $0b73 ; (clear_map.l1005 + 0)
.s1006:
; 387, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0b9b : ad ee 9f LDA $9fee ; (result + 0)
0b9e : d0 d3 __ BNE $0b73 ; (clear_map.l1005 + 0)
.s1001:
; 390, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0ba0 : 60 __ __ RTS
--------------------------------------------------------------------
clear_room_center_cache: ; clear_room_center_cache()->void
.s0:
; 879, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0ba1 : a9 00 __ LDA #$00
0ba3 : 8d df 3f STA $3fdf ; (room_center_cache_valid + 0)
.s1001:
; 880, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0ba6 : 60 __ __ RTS
--------------------------------------------------------------------
init_connection_system: ; init_connection_system()->void
.s0:
;1295, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
0ba7 : a9 00 __ LDA #$00
0ba9 : 8d eb 9f STA $9feb ; (i + 0)
.l2:
;1296, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
0bac : ad eb 9f LDA $9feb ; (i + 0)
0baf : aa __ __ TAX
0bb0 : 0a __ __ ASL
0bb1 : 0a __ __ ASL
0bb2 : 6d eb 9f ADC $9feb ; (i + 0)
0bb5 : 0a __ __ ASL
0bb6 : 0a __ __ ASL
0bb7 : 85 43 __ STA T0 + 0 
0bb9 : a9 00 __ LDA #$00
0bbb : 8d ea 9f STA $9fea ; (entropy2 + 1)
;1298, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
0bbe : 2a __ __ ROL
0bbf : 85 44 __ STA T0 + 1 
0bc1 : a9 c8 __ LDA #$c8
0bc3 : 65 43 __ ADC T0 + 0 
0bc5 : 85 45 __ STA T1 + 0 
0bc7 : a9 48 __ LDA #$48
0bc9 : 65 44 __ ADC T0 + 1 
0bcb : 85 46 __ STA T1 + 1 
0bcd : 18 __ __ CLC
0bce : a9 38 __ LDA #$38
0bd0 : 65 43 __ ADC T0 + 0 
0bd2 : 85 43 __ STA T0 + 0 
0bd4 : a9 47 __ LDA #$47
0bd6 : 65 44 __ ADC T0 + 1 
0bd8 : 85 44 __ STA T0 + 1 
0bda : a9 00 __ LDA #$00
.l1002:
0bdc : ac ea 9f LDY $9fea ; (entropy2 + 1)
0bdf : 91 45 __ STA (T1 + 0),y 
;1297, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
0be1 : 91 43 __ STA (T0 + 0),y 
;1296, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
0be3 : c8 __ __ INY
0be4 : 8c ea 9f STY $9fea ; (entropy2 + 1)
0be7 : c0 14 __ CPY #$14
0be9 : 90 f1 __ BCC $0bdc ; (init_connection_system.l1002 + 0)
.s3:
;1295, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
0beb : e8 __ __ INX
0bec : 8e eb 9f STX $9feb ; (i + 0)
0bef : e0 14 __ CPX #$14
0bf1 : 90 b9 __ BCC $0bac ; (init_connection_system.l2 + 0)
.s4:
;1305, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
0bf3 : 8d ea 40 STA $40ea ; (connection_cache + 72)
;1303, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
0bf6 : 8d a0 40 STA $40a0 ; (corridor_pool + 192)
;1304, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
0bf9 : 8d a1 40 STA $40a1 ; (corridor_pool + 193)
;1308, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
0bfc : 20 05 0c JSR $0c05 ; (init_room_distance_cache.s0 + 0)
;1311, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
0bff : 20 d4 0d JSR $0dd4 ; (init_striped_distance_cache.s0 + 0)
;1312, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
0c02 : 4c fc 0d JMP $0dfc ; (clear_mst_candidates_striped.s0 + 0)
--------------------------------------------------------------------
init_room_distance_cache: ; init_room_distance_cache()->void
.s0:
;1572, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0c05 : a9 00 __ LDA #$00
0c07 : 8d ed 9f STA $9fed ; (s + 1)
.l2:
;1573, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0c0a : ad ed 9f LDA $9fed ; (s + 1)
0c0d : aa __ __ TAX
0c0e : 0a __ __ ASL
0c0f : 0a __ __ ASL
0c10 : 6d ed 9f ADC $9fed ; (s + 1)
0c13 : 0a __ __ ASL
0c14 : 0a __ __ ASL
0c15 : a8 __ __ TAY
0c16 : a9 00 __ LDA #$00
0c18 : 8d ec 9f STA $9fec ; (entropy1 + 1)
;1574, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0c1b : 2a __ __ ROL
0c1c : 85 1c __ STA ACCU + 1 
0c1e : 98 __ __ TYA
0c1f : 69 58 __ ADC #$58
0c21 : 85 1b __ STA ACCU + 0 
0c23 : a9 4a __ LDA #$4a
0c25 : 65 1c __ ADC ACCU + 1 
0c27 : 85 1c __ STA ACCU + 1 
0c29 : a9 ff __ LDA #$ff
.l1012:
0c2b : ac ec 9f LDY $9fec ; (entropy1 + 1)
0c2e : 91 1b __ STA (ACCU + 0),y 
;1573, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0c30 : c8 __ __ INY
0c31 : 8c ec 9f STY $9fec ; (entropy1 + 1)
0c34 : c0 14 __ CPY #$14
0c36 : 90 f3 __ BCC $0c2b ; (init_room_distance_cache.l1012 + 0)
.s3:
;1572, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0c38 : e8 __ __ INX
0c39 : 8e ed 9f STX $9fed ; (s + 1)
0c3c : e0 14 __ CPX #$14
0c3e : 90 ca __ BCC $0c0a ; (init_room_distance_cache.l2 + 0)
.s4:
;1579, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0c40 : a9 00 __ LDA #$00
0c42 : 8d ed 9f STA $9fed ; (s + 1)
0c45 : ad de 3f LDA $3fde ; (room_count + 0)
0c48 : 85 47 __ STA T5 + 0 
0c4a : f0 74 __ BEQ $0cc0 ; (init_room_distance_cache.s12 + 0)
.l13:
0c4c : ad ed 9f LDA $9fed ; (s + 1)
0c4f : c9 14 __ CMP #$14
0c51 : b0 6d __ BCS $0cc0 ; (init_room_distance_cache.s12 + 0)
.s10:
;1580, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0c53 : 85 48 __ STA T6 + 0 
0c55 : 85 44 __ STA T2 + 0 
0c57 : 69 01 __ ADC #$01
0c59 : 8d ec 9f STA $9fec ; (entropy1 + 1)
0c5c : c5 47 __ CMP T5 + 0 
0c5e : b0 55 __ BCS $0cb5 ; (init_room_distance_cache.s11 + 0)
.s31:
;1581, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0c60 : a5 44 __ LDA T2 + 0 
0c62 : 0a __ __ ASL
0c63 : 0a __ __ ASL
0c64 : 65 44 __ ADC T2 + 0 
0c66 : 0a __ __ ASL
0c67 : 0a __ __ ASL
0c68 : a2 00 __ LDX #$00
0c6a : 90 01 __ BCC $0c6d ; (init_room_distance_cache.s1015 + 0)
.s1014:
0c6c : e8 __ __ INX
.s1015:
0c6d : 18 __ __ CLC
0c6e : 69 58 __ ADC #$58
0c70 : 85 45 __ STA T3 + 0 
0c72 : 8a __ __ TXA
0c73 : 69 4a __ ADC #$4a
0c75 : 85 46 __ STA T3 + 1 
.l18:
;1580, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0c77 : ad ec 9f LDA $9fec ; (entropy1 + 1)
0c7a : c9 14 __ CMP #$14
0c7c : b0 37 __ BCS $0cb5 ; (init_room_distance_cache.s11 + 0)
.s15:
;1581, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0c7e : a5 48 __ LDA T6 + 0 
0c80 : 85 13 __ STA P6 
0c82 : ad ec 9f LDA $9fec ; (entropy1 + 1)
0c85 : 85 14 __ STA P7 
0c87 : 20 c6 0c JSR $0cc6 ; (calculate_room_distance.s0 + 0)
0c8a : a4 14 __ LDY P7 
0c8c : 91 45 __ STA (T3 + 0),y 
0c8e : aa __ __ TAX
;1582, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0c8f : 98 __ __ TYA
0c90 : 0a __ __ ASL
0c91 : 0a __ __ ASL
0c92 : 65 14 __ ADC P7 
0c94 : 0a __ __ ASL
0c95 : 0a __ __ ASL
0c96 : a0 00 __ LDY #$00
0c98 : 90 01 __ BCC $0c9b ; (init_room_distance_cache.s1017 + 0)
.s1016:
0c9a : c8 __ __ INY
.s1017:
0c9b : 18 __ __ CLC
0c9c : 69 58 __ ADC #$58
0c9e : 85 1b __ STA ACCU + 0 
0ca0 : 98 __ __ TYA
0ca1 : 69 4a __ ADC #$4a
0ca3 : 85 1c __ STA ACCU + 1 
0ca5 : 8a __ __ TXA
0ca6 : a4 44 __ LDY T2 + 0 
0ca8 : 91 1b __ STA (ACCU + 0),y 
;1580, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0caa : a5 14 __ LDA P7 
0cac : 69 01 __ ADC #$01
0cae : 8d ec 9f STA $9fec ; (entropy1 + 1)
0cb1 : c5 47 __ CMP T5 + 0 
0cb3 : 90 c2 __ BCC $0c77 ; (init_room_distance_cache.l18 + 0)
.s11:
;1579, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0cb5 : a5 48 __ LDA T6 + 0 
0cb7 : 69 00 __ ADC #$00
0cb9 : 8d ed 9f STA $9fed ; (s + 1)
0cbc : c5 47 __ CMP T5 + 0 
0cbe : 90 8c __ BCC $0c4c ; (init_room_distance_cache.l13 + 0)
.s12:
;1586, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0cc0 : a9 01 __ LDA #$01
0cc2 : 8d eb 40 STA $40eb ; (distance_cache_valid + 0)
.s1001:
;1587, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0cc5 : 60 __ __ RTS
--------------------------------------------------------------------
calculate_room_distance: ; calculate_room_distance(u8,u8)->u8
.s0:
; 885, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0cc6 : a5 13 __ LDA P6 ; (room1 + 0)
0cc8 : 85 0e __ STA P1 
0cca : a9 f1 __ LDA #$f1
0ccc : 85 0f __ STA P2 
0cce : a9 9f __ LDA #$9f
0cd0 : 85 12 __ STA P5 
0cd2 : a9 9f __ LDA #$9f
0cd4 : 85 10 __ STA P3 
0cd6 : a9 f0 __ LDA #$f0
0cd8 : 85 11 __ STA P4 
0cda : 20 0b 0d JSR $0d0b ; (get_room_center.s0 + 0)
; 886, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0cdd : a5 14 __ LDA P7 ; (room2 + 0)
0cdf : 85 0e __ STA P1 
0ce1 : a9 ef __ LDA #$ef
0ce3 : 85 0f __ STA P2 
0ce5 : a9 9f __ LDA #$9f
0ce7 : 85 12 __ STA P5 
0ce9 : a9 9f __ LDA #$9f
0ceb : 85 10 __ STA P3 
0ced : a9 ee __ LDA #$ee
0cef : 85 11 __ STA P4 
0cf1 : 20 0b 0d JSR $0d0b ; (get_room_center.s0 + 0)
; 887, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0cf4 : ad f1 9f LDA $9ff1 ; (r1 + 1)
0cf7 : 85 0f __ STA P2 
0cf9 : ad f0 9f LDA $9ff0 ; (r1 + 0)
0cfc : 85 10 __ STA P3 
0cfe : ad ef 9f LDA $9fef ; (byte_ptr + 1)
0d01 : 85 11 __ STA P4 
0d03 : ad ee 9f LDA $9fee ; (result + 0)
0d06 : 85 12 __ STA P5 
0d08 : 4c a9 0d JMP $0da9 ; (manhattan_distance.s0 + 0)
--------------------------------------------------------------------
get_room_center: ; get_room_center(u8,u8*,u8*)->void
.s0:
; 849, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0d0b : ad df 3f LDA $3fdf ; (room_center_cache_valid + 0)
0d0e : d0 05 __ BNE $0d15 ; (get_room_center.s4 + 0)
.s1002:
; 851, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0d10 : a5 0e __ LDA P1 ; (room_id + 0)
0d12 : 4c 2a 0d JMP $0d2a ; (get_room_center.s1 + 0)
.s4:
; 849, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0d15 : a5 0e __ LDA P1 ; (room_id + 0)
0d17 : c9 14 __ CMP #$14
0d19 : b0 0f __ BCS $0d2a ; (get_room_center.s1 + 0)
.s3:
; 861, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0d1b : 0a __ __ ASL
0d1c : aa __ __ TAX
0d1d : bd a0 4c LDA $4ca0,x ; (room_center_cache + 0)
0d20 : a0 00 __ LDY #$00
0d22 : 91 0f __ STA (P2),y ; (center_x + 0)
; 862, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0d24 : bd a1 4c LDA $4ca1,x ; (room_center_cache + 1)
0d27 : 91 11 __ STA (P4),y ; (center_y + 0)
.s1001:
; 858, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0d29 : 60 __ __ RTS
.s1:
; 851, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0d2a : 85 0d __ STA P0 
0d2c : 20 4f 0d JSR $0d4f ; (get_room_center_x.s0 + 0)
0d2f : a0 00 __ LDY #$00
0d31 : 91 0f __ STA (P2),y ; (center_x + 0)
; 852, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0d33 : a5 0d __ LDA P0 
0d35 : 20 7c 0d JSR $0d7c ; (get_room_center_y.s0 + 0)
0d38 : a0 00 __ LDY #$00
0d3a : 91 11 __ STA (P4),y ; (center_y + 0)
; 854, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0d3c : a5 0e __ LDA P1 ; (room_id + 0)
0d3e : c9 14 __ CMP #$14
0d40 : b0 e7 __ BCS $0d29 ; (get_room_center.s1001 + 0)
.s5:
; 855, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0d42 : 0a __ __ ASL
0d43 : aa __ __ TAX
0d44 : b1 0f __ LDA (P2),y ; (center_x + 0)
0d46 : 9d a0 4c STA $4ca0,x ; (room_center_cache + 0)
; 856, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0d49 : b1 11 __ LDA (P4),y ; (center_y + 0)
0d4b : 9d a1 4c STA $4ca1,x ; (room_center_cache + 1)
0d4e : 60 __ __ RTS
--------------------------------------------------------------------
get_room_center_x: ; get_room_center_x(u8)->u8
.s0:
; 776, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0d4f : cd de 3f CMP $3fde ; (room_count + 0)
0d52 : 90 03 __ BCC $0d57 ; (get_room_center_x.s3 + 0)
.s1:
0d54 : a9 00 __ LDA #$00
0d56 : 60 __ __ RTS
.s3:
; 777, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0d57 : 0a __ __ ASL
0d58 : 0a __ __ ASL
0d59 : 0a __ __ ASL
0d5a : a8 __ __ TAY
0d5b : b9 02 4c LDA $4c02,y ; (rooms + 2)
0d5e : 38 __ __ SEC
0d5f : e9 01 __ SBC #$01
0d61 : aa __ __ TAX
0d62 : a9 00 __ LDA #$00
0d64 : e9 00 __ SBC #$00
0d66 : 85 1c __ STA ACCU + 1 
0d68 : 0a __ __ ASL
0d69 : 8a __ __ TXA
0d6a : 69 00 __ ADC #$00
0d6c : 85 1b __ STA ACCU + 0 
0d6e : a5 1c __ LDA ACCU + 1 
0d70 : 69 00 __ ADC #$00
0d72 : 4a __ __ LSR
0d73 : 66 1b __ ROR ACCU + 0 
0d75 : b9 00 4c LDA $4c00,y ; (rooms + 0)
0d78 : 18 __ __ CLC
0d79 : 65 1b __ ADC ACCU + 0 
.s1001:
0d7b : 60 __ __ RTS
--------------------------------------------------------------------
get_room_center_y: ; get_room_center_y(u8)->u8
.s0:
; 782, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0d7c : cd de 3f CMP $3fde ; (room_count + 0)
0d7f : 90 03 __ BCC $0d84 ; (get_room_center_y.s3 + 0)
.s1:
0d81 : a9 00 __ LDA #$00
0d83 : 60 __ __ RTS
.s3:
; 783, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0d84 : 0a __ __ ASL
0d85 : 0a __ __ ASL
0d86 : 0a __ __ ASL
0d87 : a8 __ __ TAY
0d88 : b9 03 4c LDA $4c03,y ; (rooms + 3)
0d8b : 38 __ __ SEC
0d8c : e9 01 __ SBC #$01
0d8e : aa __ __ TAX
0d8f : a9 00 __ LDA #$00
0d91 : e9 00 __ SBC #$00
0d93 : 85 1c __ STA ACCU + 1 
0d95 : 0a __ __ ASL
0d96 : 8a __ __ TXA
0d97 : 69 00 __ ADC #$00
0d99 : 85 1b __ STA ACCU + 0 
0d9b : a5 1c __ LDA ACCU + 1 
0d9d : 69 00 __ ADC #$00
0d9f : 4a __ __ LSR
0da0 : 66 1b __ ROR ACCU + 0 
0da2 : b9 01 4c LDA $4c01,y ; (rooms + 1)
0da5 : 18 __ __ CLC
0da6 : 65 1b __ ADC ACCU + 0 
.s1001:
0da8 : 60 __ __ RTS
--------------------------------------------------------------------
manhattan_distance: ; manhattan_distance(u8,u8,u8,u8)->u8
.s0:
; 754, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0da9 : a5 0f __ LDA P2 ; (x1 + 0)
0dab : 85 0d __ STA P0 
0dad : a5 11 __ LDA P4 ; (x2 + 0)
0daf : 85 0e __ STA P1 
0db1 : 20 c5 0d JSR $0dc5 ; (abs_diff.s0 + 0)
0db4 : 85 43 __ STA T0 + 0 
0db6 : a5 10 __ LDA P3 ; (y1 + 0)
0db8 : 85 0d __ STA P0 
0dba : a5 12 __ LDA P5 ; (y2 + 0)
0dbc : 85 0e __ STA P1 
0dbe : 20 c5 0d JSR $0dc5 ; (abs_diff.s0 + 0)
0dc1 : 18 __ __ CLC
0dc2 : 65 43 __ ADC T0 + 0 
.s1001:
0dc4 : 60 __ __ RTS
--------------------------------------------------------------------
abs_diff: ; abs_diff(u8,u8)->u8
.s0:
;1253, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0dc5 : a5 0e __ LDA P1 ; (b + 0)
0dc7 : c5 0d __ CMP P0 ; (a + 0)
0dc9 : 90 03 __ BCC $0dce ; (abs_diff.s2 + 0)
.s3:
0dcb : e5 0d __ SBC P0 ; (a + 0)
0dcd : 60 __ __ RTS
.s2:
;1253, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0dce : 38 __ __ SEC
0dcf : a5 0d __ LDA P0 ; (a + 0)
0dd1 : e5 0e __ SBC P1 ; (b + 0)
.s1001:
0dd3 : 60 __ __ RTS
--------------------------------------------------------------------
init_striped_distance_cache: ; init_striped_distance_cache()->void
.s0:
;1330, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0dd4 : a9 00 __ LDA #$00
0dd6 : 8d f1 9f STA $9ff1 ; (r1 + 1)
.l2:
;1332, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0dd9 : a9 ff __ LDA #$ff
0ddb : ae f1 9f LDX $9ff1 ; (r1 + 1)
0dde : 9d 00 4d STA $4d00,x ; (connection_distance_cache_striped.room1 + 0)
;1333, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0de1 : 9d 40 4d STA $4d40,x ; (connection_distance_cache_striped.room2 + 0)
;1334, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0de4 : 9d 80 4d STA $4d80,x ; (connection_distance_cache_striped.distance + 0)
;1331, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0de7 : a9 00 __ LDA #$00
0de9 : 9d c0 4d STA $4dc0,x ; (connection_distance_cache_striped.valid + 0)
;1330, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0dec : ee f1 9f INC $9ff1 ; (r1 + 1)
0def : ad f1 9f LDA $9ff1 ; (r1 + 1)
0df2 : c9 40 __ CMP #$40
0df4 : 90 e3 __ BCC $0dd9 ; (init_striped_distance_cache.l2 + 0)
.s4:
;1337, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0df6 : a9 00 __ LDA #$00
0df8 : 8d ec 40 STA $40ec ; (striped_cache_size + 0)
.s1001:
;1338, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0dfb : 60 __ __ RTS
--------------------------------------------------------------------
clear_mst_candidates_striped: ; clear_mst_candidates_striped()->void
.s0:
;1285, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
0dfc : a9 00 __ LDA #$00
0dfe : 8d ed 40 STA $40ed ; (edge_candidate_count + 0)
.s1001:
;1288, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
0e01 : 60 __ __ RTS
--------------------------------------------------------------------
mapgen_generate_dungeon: ; mapgen_generate_dungeon()->u8
.s0:
;1107, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0e02 : 20 0e 0e JSR $0e0e ; (reset_viewport_state.s0 + 0)
;1110, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0e05 : 20 1f 0e JSR $0e1f ; (reset_display_state.s0 + 0)
;1113, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0e08 : 20 3d 0e JSR $0e3d ; (reset_all_generation_data.s0 + 0)
;1115, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0e0b : 4c 4e 0e JMP $0e4e ; (generate_level.s1000 + 0)
--------------------------------------------------------------------
reset_viewport_state: ; reset_viewport_state()->void
.s0:
;1057, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0e0e : a9 00 __ LDA #$00
0e10 : 8d f0 40 STA $40f0 ; (view + 0)
;1058, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0e13 : 8d f1 40 STA $40f1 ; (view + 1)
;1056, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0e16 : a9 20 __ LDA #$20
0e18 : 8d ef 40 STA $40ef ; (camera_center_y + 0)
;1055, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0e1b : 8d ee 40 STA $40ee ; (camera_center_x + 0)
.s1001:
;1059, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0e1e : 60 __ __ RTS
--------------------------------------------------------------------
reset_display_state: ; reset_display_state()->void
.s0:
;1070, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0e1f : a9 00 __ LDA #$00
0e21 : 8d f3 40 STA $40f3 ; (last_scroll_direction + 0)
;1067, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0e24 : a9 01 __ LDA #$01
0e26 : 8d f2 40 STA $40f2 ; (screen_dirty + 0)
;1064, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0e29 : a9 20 __ LDA #$20
0e2b : a2 fa __ LDX #$fa
.l1003:
0e2d : ca __ __ DEX
0e2e : 9d 00 4e STA $4e00,x ; (screen_buffer + 0)
0e31 : 9d fa 4e STA $4efa,x ; (screen_buffer + 250)
0e34 : 9d f4 4f STA $4ff4,x ; (screen_buffer + 500)
0e37 : 9d ee 50 STA $50ee,x ; (screen_buffer + 750)
0e3a : d0 f1 __ BNE $0e2d ; (reset_display_state.l1003 + 0)
.s1001:
;1071, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0e3c : 60 __ __ RTS
--------------------------------------------------------------------
reset_all_generation_data: ; reset_all_generation_data()->void
.s0:
;1076, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0e3d : 20 f5 08 JSR $08f5 ; (init_rng.s0 + 0)
;1079, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0e40 : 20 61 0b JSR $0b61 ; (clear_map.s0 + 0)
;1082, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0e43 : a9 00 __ LDA #$00
0e45 : 8d de 3f STA $3fde ; (room_count + 0)
;1085, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0e48 : 20 a1 0b JSR $0ba1 ; (clear_room_center_cache.s0 + 0)
;1088, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0e4b : 4c a7 0b JMP $0ba7 ; (init_connection_system.s0 + 0)
--------------------------------------------------------------------
generate_level: ; generate_level()->u8
.s1000:
0e4e : a2 04 __ LDX #$04
0e50 : b5 53 __ LDA T2 + 0,x 
0e52 : 9d 73 9f STA $9f73,x ; (generate_level@stack + 0)
0e55 : ca __ __ DEX
0e56 : 10 f8 __ BPL $0e50 ; (generate_level.s1000 + 2)
.s0:
; 148, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e58 : a9 00 __ LDA #$00
0e5a : 85 0e __ STA P1 
0e5c : a9 10 __ LDA #$10
0e5e : 85 0f __ STA P2 
0e60 : 20 af 0f JSR $0faf ; (print_text.s0 + 0)
; 151, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e63 : 20 24 10 JSR $1024 ; (create_rooms.s1000 + 0)
; 153, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e66 : ad de 3f LDA $3fde ; (room_count + 0)
0e69 : d0 03 __ BNE $0e6e ; (generate_level.s3 + 0)
0e6b : 4c a2 0f JMP $0fa2 ; (generate_level.s1001 + 0)
.s3:
; 159, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e6e : 85 53 __ STA T2 + 0 
0e70 : a9 00 __ LDA #$00
0e72 : 85 0e __ STA P1 
0e74 : a9 17 __ LDA #$17
0e76 : 85 0f __ STA P2 
0e78 : 20 af 0f JSR $0faf ; (print_text.s0 + 0)
; 161, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e7b : a9 00 __ LDA #$00
0e7d : 8d 7c 9f STA $9f7c ; (connections_made + 0)
; 164, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e80 : 20 a7 0b JSR $0ba7 ; (init_connection_system.s0 + 0)
; 167, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e83 : a9 00 __ LDA #$00
0e85 : 8d 7b 9f STA $9f7b ; (i + 0)
.l6:
; 168, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e88 : a9 00 __ LDA #$00
0e8a : ae 7b 9f LDX $9f7b ; (i + 0)
0e8d : 9d 7d 9f STA $9f7d,x ; (connected + 0)
; 167, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e90 : ee 7b 9f INC $9f7b ; (i + 0)
0e93 : ad 7b 9f LDA $9f7b ; (i + 0)
0e96 : c9 14 __ CMP #$14
0e98 : 90 ee __ BCC $0e88 ; (generate_level.l6 + 0)
.s8:
; 171, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0e9a : a9 01 __ LDA #$01
0e9c : 8d 7d 9f STA $9f7d ; (connected + 0)
0e9f : b0 18 __ BCS $0eb9 ; (generate_level.l9 + 0)
.s42:
; 214, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ea1 : a9 01 __ LDA #$01
0ea3 : a6 f9 __ LDX $f9 ; (mst_best_room2 + 0)
0ea5 : 9d 7d 9f STA $9f7d,x ; (connected + 0)
; 215, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ea8 : a6 54 __ LDX T3 + 0 
0eaa : e8 __ __ INX
0eab : 8e 7c 9f STX $9f7c ; (connections_made + 0)
; 216, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0eae : a9 db __ LDA #$db
0eb0 : 85 0e __ STA P1 
0eb2 : a9 15 __ LDA #$15
0eb4 : 85 0f __ STA P2 
0eb6 : 20 af 0f JSR $0faf ; (print_text.s0 + 0)
.l9:
; 175, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0eb9 : ad 7c 9f LDA $9f7c ; (connections_made + 0)
0ebc : 85 54 __ STA T3 + 0 
0ebe : 38 __ __ SEC
0ebf : a5 53 __ LDA T2 + 0 
0ec1 : e9 01 __ SBC #$01
0ec3 : b0 03 __ BCS $0ec8 ; (generate_level.s1005 + 0)
0ec5 : 4c 9a 0f JMP $0f9a ; (generate_level.s11 + 0)
.s1005:
0ec8 : c5 54 __ CMP T3 + 0 
0eca : 90 f9 __ BCC $0ec5 ; (generate_level.l9 + 12)
.s1013:
0ecc : f0 f7 __ BEQ $0ec5 ; (generate_level.l9 + 12)
.s10:
; 177, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ece : a9 00 __ LDA #$00
0ed0 : 8d 7a 9f STA $9f7a ; (connection_found + 0)
; 176, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ed3 : a9 ff __ LDA #$ff
0ed5 : 85 f7 __ STA $f7 ; (mst_best_distance + 0)
; 180, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ed7 : a9 7d __ LDA #$7d
0ed9 : 85 15 __ STA P8 
0edb : a9 f9 __ LDA #$f9
0edd : 8d f2 9f STA $9ff2 ; (sstack + 0)
0ee0 : a9 9f __ LDA #$9f
0ee2 : 85 16 __ STA P9 
0ee4 : a9 f8 __ LDA #$f8
0ee6 : 85 17 __ STA P10 
0ee8 : a9 00 __ LDA #$00
0eea : 85 18 __ STA P11 
0eec : a9 00 __ LDA #$00
0eee : 8d f3 9f STA $9ff3 ; (sstack + 1)
0ef1 : 20 18 17 JSR $1718 ; (find_best_connection_striped.s0 + 0)
0ef4 : a5 1b __ LDA ACCU + 0 
0ef6 : 8d 7a 9f STA $9f7a ; (connection_found + 0)
; 182, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0ef9 : f0 03 __ BEQ $0efe ; (generate_level.s12 + 0)
0efb : 4c 81 0f JMP $0f81 ; (generate_level.s14 + 0)
.s12:
; 185, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0efe : a5 53 __ LDA T2 + 0 
0f00 : c9 01 __ CMP #$01
0f02 : a9 00 __ LDA #$00
0f04 : 8d 7b 9f STA $9f7b ; (i + 0)
0f07 : 2a __ __ ROL
0f08 : 85 55 __ STA T4 + 0 
0f0a : f0 75 __ BEQ $0f81 ; (generate_level.s14 + 0)
.l16:
; 186, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f0c : ae 7b 9f LDX $9f7b ; (i + 0)
0f0f : 86 56 __ STX T5 + 0 
0f11 : bd 7d 9f LDA $9f7d,x ; (connected + 0)
0f14 : f0 5f __ BEQ $0f75 ; (generate_level.s17 + 0)
.s21:
; 188, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f16 : a9 00 __ LDA #$00
0f18 : 8d 79 9f STA $9f79 ; (j + 0)
0f1b : a5 55 __ LDA T4 + 0 
0f1d : f0 56 __ BEQ $0f75 ; (generate_level.s17 + 0)
.l24:
; 190, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f1f : ae 79 9f LDX $9f79 ; (j + 0)
0f22 : 86 57 __ STX T6 + 0 
0f24 : bd 7d 9f LDA $9f7d,x ; (connected + 0)
0f27 : d0 40 __ BNE $0f69 ; (generate_level.s23 + 0)
.s29:
; 194, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f29 : a5 56 __ LDA T5 + 0 
0f2b : 85 17 __ STA P10 
0f2d : a5 57 __ LDA T6 + 0 
0f2f : 85 18 __ STA P11 
0f31 : 20 55 19 JSR $1955 ; (can_connect_rooms_safely.s0 + 0)
0f34 : a5 1b __ LDA ACCU + 0 
0f36 : f0 31 __ BEQ $0f69 ; (generate_level.s23 + 0)
.s33:
; 197, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f38 : a5 17 __ LDA P10 
0f3a : 85 0d __ STA P0 
0f3c : a5 57 __ LDA T6 + 0 
0f3e : 85 0e __ STA P1 
0f40 : 20 ff 19 JSR $19ff ; (is_room_reachable.s0 + 0)
0f43 : aa __ __ TAX
0f44 : d0 23 __ BNE $0f69 ; (generate_level.s23 + 0)
.s37:
; 200, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f46 : a5 17 __ LDA P10 
0f48 : 85 15 __ STA P8 
0f4a : a5 57 __ LDA T6 + 0 
0f4c : 85 16 __ STA P9 
0f4e : 20 b7 1a JSR $1ab7 ; (get_cached_room_distance_striped.s0 + 0)
0f51 : a5 1b __ LDA ACCU + 0 
0f53 : 8d 78 9f STA $9f78 ; (distance + 0)
; 201, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f56 : c5 f7 __ CMP $f7 ; (mst_best_distance + 0)
0f58 : b0 0f __ BCS $0f69 ; (generate_level.s23 + 0)
.s39:
; 202, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f5a : 85 f7 __ STA $f7 ; (mst_best_distance + 0)
; 205, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f5c : a9 01 __ LDA #$01
0f5e : 8d 7a 9f STA $9f7a ; (connection_found + 0)
; 204, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f61 : a5 57 __ LDA T6 + 0 
0f63 : 85 f9 __ STA $f9 ; (mst_best_room2 + 0)
; 203, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f65 : a5 17 __ LDA P10 
0f67 : 85 f8 __ STA $f8 ; (mst_best_room1 + 0)
.s23:
; 188, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f69 : 18 __ __ CLC
0f6a : a5 57 __ LDA T6 + 0 
0f6c : 69 01 __ ADC #$01
0f6e : 8d 79 9f STA $9f79 ; (j + 0)
0f71 : c5 53 __ CMP T2 + 0 
0f73 : 90 aa __ BCC $0f1f ; (generate_level.l24 + 0)
.s17:
; 185, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f75 : 18 __ __ CLC
0f76 : a5 56 __ LDA T5 + 0 
0f78 : 69 01 __ ADC #$01
0f7a : 8d 7b 9f STA $9f7b ; (i + 0)
0f7d : c5 53 __ CMP T2 + 0 
0f7f : 90 8b __ BCC $0f0c ; (generate_level.l16 + 0)
.s14:
; 212, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f81 : ad 7a 9f LDA $9f7a ; (connection_found + 0)
0f84 : f0 14 __ BEQ $0f9a ; (generate_level.s11 + 0)
.s45:
0f86 : a5 f8 __ LDA $f8 ; (mst_best_room1 + 0)
0f88 : 8d fe 9f STA $9ffe ; (sstack + 12)
0f8b : a5 f9 __ LDA $f9 ; (mst_best_room2 + 0)
0f8d : 8d ff 9f STA $9fff ; (sstack + 13)
0f90 : 20 c6 1b JSR $1bc6 ; (connect_rooms_directly.s1000 + 0)
0f93 : a5 1b __ LDA ACCU + 0 
0f95 : f0 03 __ BEQ $0f9a ; (generate_level.s11 + 0)
0f97 : 4c a1 0e JMP $0ea1 ; (generate_level.s42 + 0)
.s11:
; 224, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f9a : 20 a2 32 JSR $32a2 ; (add_stairs.s0 + 0)
; 227, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0f9d : 20 dc 33 JSR $33dc ; (add_walls.s0 + 0)
; 229, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
0fa0 : a9 01 __ LDA #$01
.s1001:
0fa2 : 85 1b __ STA ACCU + 0 
0fa4 : a2 04 __ LDX #$04
0fa6 : bd 73 9f LDA $9f73,x ; (generate_level@stack + 0)
0fa9 : 95 53 __ STA T2 + 0,x 
0fab : ca __ __ DEX
0fac : 10 f8 __ BPL $0fa6 ; (generate_level.s1001 + 4)
0fae : 60 __ __ RTS
--------------------------------------------------------------------
print_text: ; print_text(const u8*)->void
.s0:
;1031, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0faf : a9 00 __ LDA #$00
0fb1 : f0 0f __ BEQ $0fc2 ; (print_text.l1 + 0)
.s6:
;1035, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0fb3 : 8d f0 9f STA $9ff0 ; (r1 + 0)
;1041, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0fb6 : 85 43 __ STA T0 + 0 
0fb8 : a5 43 __ LDA T0 + 0 
0fba : 20 d2 ff JSR $ffd2 
;1044, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0fbd : 18 __ __ CLC
0fbe : a5 44 __ LDA T3 + 0 
0fc0 : 69 01 __ ADC #$01
.l1:
;1031, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0fc2 : 8d f1 9f STA $9ff1 ; (r1 + 1)
;1032, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0fc5 : 85 44 __ STA T3 + 0 
0fc7 : a8 __ __ TAY
0fc8 : b1 0e __ LDA (P1),y ; (text + 0)
0fca : d0 01 __ BNE $0fcd ; (print_text.s2 + 0)
.s1001:
;1046, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0fcc : 60 __ __ RTS
.s2:
;1034, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0fcd : c9 0a __ CMP #$0a
0fcf : d0 04 __ BNE $0fd5 ; (print_text.s5 + 0)
.s4:
;1035, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0fd1 : a9 0d __ LDA #$0d
0fd3 : d0 de __ BNE $0fb3 ; (print_text.s6 + 0)
.s5:
;1037, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0fd5 : 20 db 0f JSR $0fdb ; (to_mixed_charset.s0 + 0)
0fd8 : 4c b3 0f JMP $0fb3 ; (print_text.s6 + 0)
--------------------------------------------------------------------
to_mixed_charset: ; to_mixed_charset(u8)->u8
.s0:
;1022, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0fdb : c9 41 __ CMP #$41
0fdd : 90 06 __ BCC $0fe5 ; (to_mixed_charset.s1001 + 0)
.s4:
0fdf : c9 5b __ CMP #$5b
0fe1 : b0 03 __ BCS $0fe6 ; (to_mixed_charset.s3 + 0)
.s1:
0fe3 : 69 20 __ ADC #$20
.s1001:
;1024, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0fe5 : 60 __ __ RTS
.s3:
;1023, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0fe6 : c9 61 __ CMP #$61
0fe8 : 90 fb __ BCC $0fe5 ; (to_mixed_charset.s1001 + 0)
.s9:
0fea : c9 7b __ CMP #$7b
0fec : b0 f7 __ BCS $0fe5 ; (to_mixed_charset.s1001 + 0)
.s6:
0fee : e9 1f __ SBC #$1f
0ff0 : 60 __ __ RTS
--------------------------------------------------------------------
set_tile_raw: ; set_tile_raw(u8,u8,u8)->void
.s0:
; 337, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
0ff1 : a5 10 __ LDA P3 ; (x + 0)
0ff3 : 85 0d __ STA P0 
0ff5 : a5 11 __ LDA P4 ; (y + 0)
0ff7 : 85 0e __ STA P1 
0ff9 : a5 12 __ LDA P5 ; (tile + 0)
0ffb : 85 0f __ STA P2 
0ffd : 4c e9 14 JMP $14e9 ; (set_compact_tile.s0 + 0)
--------------------------------------------------------------------
1000 : __ __ __ BYT 20 20 20 20 20 20 2a 2a 2a 20 48 61 63 6b 65 64 :       *** Hacked
1010 : __ __ __ BYT 20 4d 61 70 20 47 65 6e 65 72 61 74 6f 72 20 2a :  Map Generator *
1020 : __ __ __ BYT 2a 2a 0a 00                                     : **..
--------------------------------------------------------------------
create_rooms: ; create_rooms()->void
.s1000:
1024 : a5 53 __ LDA T5 + 0 
1026 : 8d be 9f STA $9fbe ; (create_rooms@stack + 0)
1029 : a5 54 __ LDA T6 + 0 
102b : 8d bf 9f STA $9fbf ; (create_rooms@stack + 1)
.s0:
; 193, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
102e : a9 00 __ LDA #$00
1030 : 8d de 9f STA $9fde ; (pivot_x + 0)
; 195, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1033 : 8d cd 9f STA $9fcd ; (find_l_corridor_exits@stack + 2)
; 197, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1036 : a9 88 __ LDA #$88
1038 : 85 0e __ STA P1 
103a : a9 11 __ LDA #$11
103c : 85 0f __ STA P2 
103e : 20 af 0f JSR $0faf ; (print_text.s0 + 0)
; 200, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1041 : a9 00 __ LDA #$00
1043 : 8d cc 9f STA $9fcc ; (find_l_corridor_exits@stack + 1)
1046 : 18 __ __ CLC
.l1004:
; 201, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1047 : aa __ __ TAX
1048 : 9d ce 9f STA $9fce,x ; (find_l_corridor_exits@stack + 3)
; 202, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
104b : ee cd 9f INC $9fcd ; (find_l_corridor_exits@stack + 2)
; 200, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
104e : 69 01 __ ADC #$01
1050 : 8d cc 9f STA $9fcc ; (find_l_corridor_exits@stack + 1)
1053 : c9 10 __ CMP #$10
; 202, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1055 : ae cd 9f LDX $9fcd ; (find_l_corridor_exits@stack + 2)
1058 : 90 ed __ BCC $1047 ; (create_rooms.l1004 + 0)
.s4:
105a : 86 52 __ STX T4 + 0 
; 206, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
105c : ca __ __ DEX
105d : 8a __ __ TXA
105e : b0 25 __ BCS $1085 ; (create_rooms.l109 + 0)
.s6:
; 207, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1060 : aa __ __ TAX
1061 : e8 __ __ INX
1062 : 86 53 __ STX T5 + 0 
1064 : 8a __ __ TXA
1065 : 20 50 0a JSR $0a50 ; (rnd.s0 + 0)
1068 : 8d ca 9f STA $9fca ; (exit1 + 5)
; 208, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
106b : aa __ __ TAX
106c : a4 4f __ LDY T0 + 0 
106e : b9 ce 9f LDA $9fce,y ; (find_l_corridor_exits@stack + 3)
1071 : 8d c9 9f STA $9fc9 ; (exit1 + 4)
; 209, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1074 : bd ce 9f LDA $9fce,x ; (find_l_corridor_exits@stack + 3)
1077 : 99 ce 9f STA $9fce,y ; (find_l_corridor_exits@stack + 3)
; 210, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
107a : ad c9 9f LDA $9fc9 ; (exit1 + 4)
107d : 9d ce 9f STA $9fce,x ; (find_l_corridor_exits@stack + 3)
; 206, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1080 : 18 __ __ CLC
1081 : a5 53 __ LDA T5 + 0 
1083 : 69 fe __ ADC #$fe
.l109:
1085 : 85 4f __ STA T0 + 0 
1087 : 8d cb 9f STA $9fcb ; (find_l_corridor_exits@stack + 0)
108a : d0 d4 __ BNE $1060 ; (create_rooms.s6 + 0)
.s8:
; 214, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
108c : a9 00 __ LDA #$00
108e : 8d c8 9f STA $9fc8 ; (exit1 + 3)
.l14:
1091 : ad de 9f LDA $9fde ; (pivot_x + 0)
1094 : c9 14 __ CMP #$14
1096 : 90 03 __ BCC $109b ; (create_rooms.s13 + 0)
1098 : 4c 51 11 JMP $1151 ; (create_rooms.s12 + 0)
.s13:
109b : 85 53 __ STA T5 + 0 
109d : ad c8 9f LDA $9fc8 ; (exit1 + 3)
10a0 : c5 52 __ CMP T4 + 0 
10a2 : b0 f4 __ BCS $1098 ; (create_rooms.l14 + 7)
.s10:
; 218, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10a4 : 85 54 __ STA T6 + 0 
10a6 : a9 0a __ LDA #$0a
10a8 : 20 50 0a JSR $0a50 ; (rnd.s0 + 0)
10ab : c9 06 __ CMP #$06
10ad : 90 17 __ BCC $10c6 ; (create_rooms.s15 + 0)
.s16:
; 231, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10af : a9 05 __ LDA #$05
10b1 : 20 50 0a JSR $0a50 ; (rnd.s0 + 0)
10b4 : 18 __ __ CLC
10b5 : 69 04 __ ADC #$04
10b7 : a8 __ __ TAY
; 232, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10b8 : a9 05 __ LDA #$05
.s118:
; 222, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10ba : 8c c7 9f STY $9fc7 ; (exit1 + 2)
; 223, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10bd : 20 50 0a JSR $0a50 ; (rnd.s0 + 0)
10c0 : 18 __ __ CLC
10c1 : 69 04 __ ADC #$04
10c3 : 4c ee 10 JMP $10ee ; (create_rooms.s17 + 0)
.s15:
; 220, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10c6 : a9 02 __ LDA #$02
10c8 : 20 50 0a JSR $0a50 ; (rnd.s0 + 0)
10cb : aa __ __ TAX
10cc : f0 0d __ BEQ $10db ; (create_rooms.s19 + 0)
.s18:
; 222, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10ce : a9 04 __ LDA #$04
10d0 : 20 50 0a JSR $0a50 ; (rnd.s0 + 0)
10d3 : 18 __ __ CLC
10d4 : 69 05 __ ADC #$05
10d6 : a8 __ __ TAY
; 223, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10d7 : a9 03 __ LDA #$03
10d9 : d0 df __ BNE $10ba ; (create_rooms.s118 + 0)
.s19:
; 226, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10db : a9 03 __ LDA #$03
10dd : 20 50 0a JSR $0a50 ; (rnd.s0 + 0)
10e0 : 18 __ __ CLC
10e1 : 69 04 __ ADC #$04
10e3 : 8d c7 9f STA $9fc7 ; (exit1 + 2)
; 227, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10e6 : a9 04 __ LDA #$04
10e8 : 20 50 0a JSR $0a50 ; (rnd.s0 + 0)
10eb : 18 __ __ CLC
10ec : 69 05 __ ADC #$05
.s17:
; 223, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10ee : 85 51 __ STA T3 + 0 
10f0 : 8d c6 9f STA $9fc6 ; (exit1 + 1)
; 236, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
10f3 : 85 15 __ STA P8 
10f5 : a9 c5 __ LDA #$c5
10f7 : 85 16 __ STA P9 
10f9 : a9 9f __ LDA #$9f
10fb : 85 17 __ STA P10 
10fd : a9 c4 __ LDA #$c4
10ff : 8d f2 9f STA $9ff2 ; (sstack + 0)
1102 : a9 9f __ LDA #$9f
1104 : 8d f3 9f STA $9ff3 ; (sstack + 1)
1107 : a6 54 __ LDX T6 + 0 
1109 : bd ce 9f LDA $9fce,x ; (find_l_corridor_exits@stack + 3)
110c : 85 13 __ STA P6 
110e : ad c7 9f LDA $9fc7 ; (exit1 + 2)
1111 : 85 50 __ STA T1 + 0 
1113 : 85 14 __ STA P7 
1115 : 20 98 11 JSR $1198 ; (try_place_room_at_grid.s0 + 0)
1118 : a5 1b __ LDA ACCU + 0 
111a : f0 26 __ BEQ $1142 ; (create_rooms.s9 + 0)
.s21:
; 237, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
111c : ad c5 9f LDA $9fc5 ; (x + 0)
111f : 85 13 __ STA P6 
1121 : ad c4 9f LDA $9fc4 ; (exit2 + 5)
1124 : 85 14 __ STA P7 
1126 : a5 50 __ LDA T1 + 0 
1128 : 85 15 __ STA P8 
112a : a5 51 __ LDA T3 + 0 
112c : 85 16 __ STA P9 
112e : 20 6c 14 JSR $146c ; (place_room.s0 + 0)
; 238, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1131 : a6 53 __ LDX T5 + 0 
1133 : e8 __ __ INX
1134 : 8e de 9f STX $9fde ; (pivot_x + 0)
; 239, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1137 : a9 db __ LDA #$db
1139 : 85 0e __ STA P1 
113b : a9 15 __ LDA #$15
113d : 85 0f __ STA P2 
113f : 20 af 0f JSR $0faf ; (print_text.s0 + 0)
.s9:
; 214, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1142 : 18 __ __ CLC
1143 : a5 54 __ LDA T6 + 0 
1145 : 69 01 __ ADC #$01
1147 : 8d c8 9f STA $9fc8 ; (exit1 + 3)
114a : c9 14 __ CMP #$14
114c : b0 03 __ BCS $1151 ; (create_rooms.s12 + 0)
114e : 4c 91 10 JMP $1091 ; (create_rooms.l14 + 0)
.s12:
; 244, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1151 : ad de 9f LDA $9fde ; (pivot_x + 0)
1154 : 85 4f __ STA T0 + 0 
1156 : 8d de 3f STA $3fde ; (room_count + 0)
; 245, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1159 : 20 dd 15 JSR $15dd ; (assign_room_priorities.s0 + 0)
; 248, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
115c : 20 25 16 JSR $1625 ; (init_room_center_cache.s0 + 0)
; 251, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
115f : a5 4f __ LDA T0 + 0 
1161 : f0 1a __ BEQ $117d ; (create_rooms.s1001 + 0)
.s24:
; 252, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1163 : a9 00 __ LDA #$00
1165 : 85 0e __ STA P1 
1167 : a9 40 __ LDA #$40
1169 : 85 12 __ STA P5 
116b : a9 ee __ LDA #$ee
116d : 85 0f __ STA P2 
116f : a9 40 __ LDA #$40
1171 : 85 10 __ STA P3 
1173 : a9 ef __ LDA #$ef
1175 : 85 11 __ STA P4 
1177 : 20 0b 0d JSR $0d0b ; (get_room_center.s0 + 0)
; 253, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
117a : 20 63 16 JSR $1663 ; (update_camera.s0 + 0)
.s1001:
117d : ad be 9f LDA $9fbe ; (create_rooms@stack + 0)
1180 : 85 53 __ STA T5 + 0 
1182 : ad bf 9f LDA $9fbf ; (create_rooms@stack + 1)
1185 : 85 54 __ STA T6 + 0 
; 255, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1187 : 60 __ __ RTS
--------------------------------------------------------------------
1188 : __ __ __ BYT 0a 42 75 69 6c 64 69 6e 67 20 72 6f 6f 6d 73 00 : .Building rooms.
--------------------------------------------------------------------
try_place_room_at_grid: ; try_place_room_at_grid(u8,u8,u8,u8*,u8*)->u8
.s0:
; 112, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1198 : a9 00 __ LDA #$00
119a : 8d e2 9f STA $9fe2 ; (best_distance + 0)
.l2:
; 119, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
119d : a5 13 __ LDA P6 ; (grid_index + 0)
119f : 85 0e __ STA P1 
11a1 : a9 e1 __ LDA #$e1
11a3 : 85 0f __ STA P2 
11a5 : a9 9f __ LDA #$9f
11a7 : 85 12 __ STA P5 
11a9 : a9 9f __ LDA #$9f
11ab : 85 10 __ STA P3 
11ad : a9 e0 __ LDA #$e0
11af : 85 11 __ STA P4 
11b1 : 20 6d 12 JSR $126d ; (get_grid_position.s0 + 0)
; 122, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11b4 : ad e2 9f LDA $9fe2 ; (best_distance + 0)
11b7 : 85 4e __ STA T7 + 0 
11b9 : c9 06 __ CMP #$06
11bb : 90 6b __ BCC $1228 ; (try_place_room_at_grid.s6 + 0)
.s4:
; 124, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11bd : e9 05 __ SBC #$05
11bf : 85 4c __ STA T2 + 0 
11c1 : 8d df 9f STA $9fdf ; (leg_length + 0)
; 125, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11c4 : 0a __ __ ASL
11c5 : 85 49 __ STA T0 + 0 
11c7 : 20 50 0a JSR $0a50 ; (rnd.s0 + 0)
11ca : 38 __ __ SEC
11cb : e5 4c __ SBC T2 + 0 
11cd : 18 __ __ CLC
11ce : 6d e1 9f ADC $9fe1 ; (r1 + 0)
11d1 : 85 4d __ STA T3 + 0 
11d3 : 8d e1 9f STA $9fe1 ; (r1 + 0)
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11d6 : a5 49 __ LDA T0 + 0 
11d8 : 20 50 0a JSR $0a50 ; (rnd.s0 + 0)
11db : 38 __ __ SEC
11dc : e5 4c __ SBC T2 + 0 
11de : 18 __ __ CLC
11df : 6d e0 9f ADC $9fe0 ; (y + 0)
11e2 : 8d e0 9f STA $9fe0 ; (y + 0)
; 129, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11e5 : a5 4d __ LDA T3 + 0 
11e7 : c9 04 __ CMP #$04
11e9 : b0 05 __ BCS $11f0 ; (try_place_room_at_grid.s9 + 0)
.s7:
11eb : a9 04 __ LDA #$04
11ed : 8d e1 9f STA $9fe1 ; (r1 + 0)
.s9:
; 130, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11f0 : ad e0 9f LDA $9fe0 ; (y + 0)
11f3 : c9 04 __ CMP #$04
11f5 : b0 05 __ BCS $11fc ; (try_place_room_at_grid.s12 + 0)
.s10:
11f7 : a9 04 __ LDA #$04
11f9 : 8d e0 9f STA $9fe0 ; (y + 0)
.s12:
; 131, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
11fc : 18 __ __ CLC
11fd : a5 14 __ LDA P7 ; (w + 0)
11ff : 6d e1 9f ADC $9fe1 ; (r1 + 0)
1202 : b0 04 __ BCS $1208 ; (try_place_room_at_grid.s13 + 0)
.s1003:
1204 : c9 3d __ CMP #$3d
1206 : 90 0a __ BCC $1212 ; (try_place_room_at_grid.s15 + 0)
.s13:
1208 : a9 40 __ LDA #$40
120a : e5 14 __ SBC P7 ; (w + 0)
120c : 38 __ __ SEC
120d : e9 04 __ SBC #$04
120f : 8d e1 9f STA $9fe1 ; (r1 + 0)
.s15:
; 132, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1212 : 18 __ __ CLC
1213 : a5 15 __ LDA P8 ; (h + 0)
1215 : 6d e0 9f ADC $9fe0 ; (y + 0)
1218 : b0 04 __ BCS $121e ; (try_place_room_at_grid.s16 + 0)
.s1002:
121a : c9 3d __ CMP #$3d
121c : 90 0a __ BCC $1228 ; (try_place_room_at_grid.s6 + 0)
.s16:
121e : a9 40 __ LDA #$40
1220 : e5 15 __ SBC P8 ; (h + 0)
1222 : 38 __ __ SEC
1223 : e9 04 __ SBC #$04
1225 : 8d e0 9f STA $9fe0 ; (y + 0)
.s6:
; 136, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1228 : a5 14 __ LDA P7 ; (w + 0)
122a : 85 11 __ STA P4 
122c : a5 15 __ LDA P8 ; (h + 0)
122e : 85 12 __ STA P5 
1230 : ad e1 9f LDA $9fe1 ; (r1 + 0)
1233 : 85 4b __ STA T1 + 0 
1235 : 85 0f __ STA P2 
1237 : ad e0 9f LDA $9fe0 ; (y + 0)
123a : 85 10 __ STA P3 
123c : 20 1b 13 JSR $131b ; (can_place_room.s0 + 0)
123f : a5 1b __ LDA ACCU + 0 
1241 : d0 10 __ BNE $1253 ; (try_place_room_at_grid.s19 + 0)
.s21:
; 142, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1243 : 18 __ __ CLC
1244 : a5 4e __ LDA T7 + 0 
1246 : 69 01 __ ADC #$01
1248 : 8d e2 9f STA $9fe2 ; (best_distance + 0)
; 115, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
124b : c9 0f __ CMP #$0f
124d : b0 03 __ BCS $1252 ; (try_place_room_at_grid.s1001 + 0)
124f : 4c 9d 11 JMP $119d ; (try_place_room_at_grid.l2 + 0)
.s1001:
; 145, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1252 : 60 __ __ RTS
.s19:
; 137, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1253 : a5 4b __ LDA T1 + 0 
1255 : a0 00 __ LDY #$00
1257 : 91 16 __ STA (P9),y ; (result_x + 0)
; 138, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1259 : ad f2 9f LDA $9ff2 ; (sstack + 0)
125c : 85 49 __ STA T0 + 0 
125e : ad f3 9f LDA $9ff3 ; (sstack + 1)
1261 : 85 4a __ STA T0 + 1 
1263 : ad e0 9f LDA $9fe0 ; (y + 0)
1266 : 91 49 __ STA (T0 + 0),y 
; 139, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1268 : a9 01 __ LDA #$01
126a : 85 1b __ STA ACCU + 0 
126c : 60 __ __ RTS
--------------------------------------------------------------------
get_grid_position: ; get_grid_position(u8,u8*,u8*)->void
.s0:
;  35, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
126d : a9 0e __ LDA #$0e
126f : 8d ea 9f STA $9fea ; (entropy2 + 1)
;  36, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1272 : 8d e9 9f STA $9fe9 ; (connected + 1)
;  43, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1275 : 8d e6 9f STA $9fe6 ; (screen_pos + 1)
;  44, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1278 : 8d e5 9f STA $9fe5 ; (leg1_end_x + 0)
;  33, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
127b : a5 0e __ LDA P1 ; (grid_index + 0)
127d : 29 03 __ AND #$03
127f : 8d ec 9f STA $9fec ; (entropy1 + 1)
1282 : aa __ __ TAX
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1283 : a5 0e __ LDA P1 ; (grid_index + 0)
1285 : 4a __ __ LSR
1286 : 4a __ __ LSR
1287 : 8d eb 9f STA $9feb ; (i + 0)
;  39, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
128a : bd cf 3f LDA $3fcf,x ; (__multab14L + 0)
128d : 18 __ __ CLC
128e : 69 04 __ ADC #$04
1290 : 85 45 __ STA T1 + 0 
1292 : 8d e8 9f STA $9fe8 ; (entropy3 + 1)
;  40, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1295 : ad eb 9f LDA $9feb ; (i + 0)
1298 : 0a __ __ ASL
1299 : 0a __ __ ASL
129a : 0a __ __ ASL
129b : 38 __ __ SEC
129c : ed eb 9f SBC $9feb ; (i + 0)
129f : 0a __ __ ASL
12a0 : 18 __ __ CLC
12a1 : 69 04 __ ADC #$04
12a3 : 85 46 __ STA T2 + 0 
12a5 : 8d e7 9f STA $9fe7 ; (idx + 0)
;  47, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12a8 : a9 15 __ LDA #$15
12aa : 20 50 0a JSR $0a50 ; (rnd.s0 + 0)
12ad : 85 44 __ STA T0 + 0 
12af : 8d e4 9f STA $9fe4 ; (random_offset_x + 0)
;  48, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12b2 : a9 15 __ LDA #$15
12b4 : 20 50 0a JSR $0a50 ; (rnd.s0 + 0)
12b7 : 8d e3 9f STA $9fe3 ; (screen_offset + 1)
12ba : aa __ __ TAX
;  51, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12bb : 18 __ __ CLC
12bc : a5 44 __ LDA T0 + 0 
12be : 65 45 __ ADC T1 + 0 
12c0 : 38 __ __ SEC
12c1 : e9 07 __ SBC #$07
12c3 : a0 00 __ LDY #$00
12c5 : 91 0f __ STA (P2),y ; (x + 0)
;  52, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12c7 : 8a __ __ TXA
12c8 : 18 __ __ CLC
12c9 : 65 46 __ ADC T2 + 0 
12cb : 38 __ __ SEC
12cc : e9 07 __ SBC #$07
12ce : 91 11 __ STA (P4),y ; (y + 0)
;  55, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12d0 : a9 07 __ LDA #$07
12d2 : 20 50 0a JSR $0a50 ; (rnd.s0 + 0)
12d5 : 38 __ __ SEC
12d6 : e9 03 __ SBC #$03
12d8 : 18 __ __ CLC
12d9 : a0 00 __ LDY #$00
12db : 71 0f __ ADC (P2),y ; (x + 0)
12dd : 91 0f __ STA (P2),y ; (x + 0)
;  56, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12df : a9 07 __ LDA #$07
12e1 : 20 50 0a JSR $0a50 ; (rnd.s0 + 0)
12e4 : 38 __ __ SEC
12e5 : e9 03 __ SBC #$03
12e7 : 18 __ __ CLC
12e8 : a0 00 __ LDY #$00
12ea : 71 11 __ ADC (P4),y ; (y + 0)
12ec : 91 11 __ STA (P4),y ; (y + 0)
12ee : aa __ __ TAX
;  59, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12ef : b1 0f __ LDA (P2),y ; (x + 0)
12f1 : c9 04 __ CMP #$04
12f3 : b0 08 __ BCS $12fd ; (get_grid_position.s3 + 0)
.s1:
12f5 : a9 04 __ LDA #$04
12f7 : 91 0f __ STA (P2),y ; (x + 0)
;  60, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12f9 : b1 11 __ LDA (P4),y ; (y + 0)
12fb : 90 01 __ BCC $12fe ; (get_grid_position.s1002 + 0)
.s3:
;  60, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
12fd : 8a __ __ TXA
.s1002:
12fe : c9 04 __ CMP #$04
1300 : b0 04 __ BCS $1306 ; (get_grid_position.s6 + 0)
.s4:
;  60, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1302 : a9 04 __ LDA #$04
1304 : 91 11 __ STA (P4),y ; (y + 0)
.s6:
;  61, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1306 : b1 0f __ LDA (P2),y ; (x + 0)
1308 : c9 35 __ CMP #$35
130a : 90 04 __ BCC $1310 ; (get_grid_position.s9 + 0)
.s7:
130c : a9 34 __ LDA #$34
130e : 91 0f __ STA (P2),y ; (x + 0)
.s9:
;  62, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1310 : b1 11 __ LDA (P4),y ; (y + 0)
1312 : c9 35 __ CMP #$35
1314 : 90 04 __ BCC $131a ; (get_grid_position.s1001 + 0)
.s10:
1316 : a9 34 __ LDA #$34
1318 : 91 11 __ STA (P4),y ; (y + 0)
.s1001:
;  63, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
131a : 60 __ __ RTS
--------------------------------------------------------------------
can_place_room: ; can_place_room(u8,u8,u8,u8)->u8
.s0:
;  79, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
131b : a5 0f __ LDA P2 ; (x + 0)
131d : c9 07 __ CMP #$07
131f : b0 04 __ BCS $1325 ; (can_place_room.s57 + 0)
.s58:
1321 : a9 03 __ LDA #$03
1323 : 90 02 __ BCC $1327 ; (can_place_room.s59 + 0)
.s57:
;  79, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1325 : e9 04 __ SBC #$04
.s59:
1327 : 85 48 __ STA T4 + 0 
1329 : 8d e9 9f STA $9fe9 ; (connected + 1)
;  80, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
132c : a5 10 __ LDA P3 ; (y + 0)
132e : c9 07 __ CMP #$07
1330 : b0 04 __ BCS $1336 ; (can_place_room.s60 + 0)
.s61:
1332 : a9 03 __ LDA #$03
1334 : 90 02 __ BCC $1338 ; (can_place_room.s62 + 0)
.s60:
;  80, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1336 : e9 04 __ SBC #$04
.s62:
1338 : 8d e8 9f STA $9fe8 ; (entropy3 + 1)
;  81, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
133b : 18 __ __ CLC
133c : a5 11 __ LDA P4 ; (w + 0)
133e : 65 0f __ ADC P2 ; (x + 0)
1340 : 18 __ __ CLC
1341 : 69 04 __ ADC #$04
1343 : 8d e7 9f STA $9fe7 ; (idx + 0)
;  82, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1346 : 18 __ __ CLC
1347 : a5 12 __ LDA P5 ; (h + 0)
1349 : 65 10 __ ADC P3 ; (y + 0)
134b : 18 __ __ CLC
134c : 69 04 __ ADC #$04
134e : 8d e6 9f STA $9fe6 ; (screen_pos + 1)
;  85, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1351 : ad e7 9f LDA $9fe7 ; (idx + 0)
1354 : c9 3d __ CMP #$3d
1356 : b0 6b __ BCS $13c3 ; (can_place_room.s1 + 0)
.s4:
1358 : ad e6 9f LDA $9fe6 ; (screen_pos + 1)
135b : c9 3d __ CMP #$3d
135d : b0 64 __ BCS $13c3 ; (can_place_room.s1 + 0)
.s3:
;  90, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
135f : ad e7 9f LDA $9fe7 ; (idx + 0)
1362 : c9 40 __ CMP #$40
1364 : 90 05 __ BCC $136b ; (can_place_room.s8 + 0)
.s6:
1366 : a9 3f __ LDA #$3f
1368 : 8d e7 9f STA $9fe7 ; (idx + 0)
.s8:
;  91, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
136b : ad e6 9f LDA $9fe6 ; (screen_pos + 1)
136e : c9 40 __ CMP #$40
1370 : 90 05 __ BCC $1377 ; (can_place_room.s26 + 0)
.s9:
1372 : a9 3f __ LDA #$3f
1374 : 8d e6 9f STA $9fe6 ; (screen_pos + 1)
.s26:
;  94, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1377 : ad e8 9f LDA $9fe8 ; (entropy3 + 1)
137a : 8d e5 9f STA $9fe5 ; (leg1_end_x + 0)
137d : ad e6 9f LDA $9fe6 ; (screen_pos + 1)
1380 : 85 45 __ STA T1 + 0 
1382 : cd e8 9f CMP $9fe8 ; (entropy3 + 1)
1385 : 90 37 __ BCC $13be ; (can_place_room.s15 + 0)
.l13:
;  95, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1387 : a5 48 __ LDA T4 + 0 
1389 : 8d e4 9f STA $9fe4 ; (random_offset_x + 0)
138c : ad e7 9f LDA $9fe7 ; (idx + 0)
138f : 85 46 __ STA T2 + 0 
1391 : c5 48 __ CMP T4 + 0 
1393 : 90 1f __ BCC $13b4 ; (can_place_room.s14 + 0)
.l17:
;  96, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1395 : ad e4 9f LDA $9fe4 ; (random_offset_x + 0)
1398 : 85 47 __ STA T3 + 0 
139a : 85 0d __ STA P0 
139c : ad e5 9f LDA $9fe5 ; (leg1_end_x + 0)
139f : 85 0e __ STA P1 
13a1 : 20 c7 13 JSR $13c7 ; (get_compact_tile.s0 + 0)
13a4 : aa __ __ TAX
13a5 : d0 1c __ BNE $13c3 ; (can_place_room.s1 + 0)
.s18:
;  95, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
13a7 : a6 47 __ LDX T3 + 0 
13a9 : e8 __ __ INX
13aa : 8e e4 9f STX $9fe4 ; (random_offset_x + 0)
13ad : a5 46 __ LDA T2 + 0 
13af : cd e4 9f CMP $9fe4 ; (random_offset_x + 0)
13b2 : b0 e1 __ BCS $1395 ; (can_place_room.l17 + 0)
.s14:
;  94, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
13b4 : ee e5 9f INC $9fe5 ; (leg1_end_x + 0)
13b7 : a5 45 __ LDA T1 + 0 
13b9 : cd e5 9f CMP $9fe5 ; (leg1_end_x + 0)
13bc : b0 c9 __ BCS $1387 ; (can_place_room.l13 + 0)
.s15:
; 102, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
13be : a9 01 __ LDA #$01
.s1001:
13c0 : 85 1b __ STA ACCU + 0 
13c2 : 60 __ __ RTS
.s1:
;  86, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
13c3 : a9 00 __ LDA #$00
13c5 : f0 f9 __ BEQ $13c0 ; (can_place_room.s1001 + 0)
--------------------------------------------------------------------
get_compact_tile: ; get_compact_tile(u8,u8)->u8
.s0:
; 203, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
13c7 : a5 0d __ LDA P0 ; (x + 0)
13c9 : c9 40 __ CMP #$40
13cb : b0 06 __ BCS $13d3 ; (get_compact_tile.s1 + 0)
.s4:
13cd : a5 0e __ LDA P1 ; (y + 0)
13cf : c9 40 __ CMP #$40
13d1 : 90 03 __ BCC $13d6 ; (get_compact_tile.s3 + 0)
.s1:
13d3 : a9 00 __ LDA #$00
.s1001:
; 227, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
13d5 : 60 __ __ RTS
.s3:
; 217, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
13d6 : 85 1c __ STA ACCU + 1 
13d8 : 4a __ __ LSR
13d9 : aa __ __ TAX
13da : a9 00 __ LDA #$00
13dc : 6a __ __ ROR
13dd : 85 43 __ STA T1 + 0 
13df : a9 00 __ LDA #$00
13e1 : 46 1c __ LSR ACCU + 1 
13e3 : 6a __ __ ROR
13e4 : 66 1c __ ROR ACCU + 1 
13e6 : 6a __ __ ROR
13e7 : 65 43 __ ADC T1 + 0 
13e9 : a8 __ __ TAY
13ea : 8a __ __ TXA
13eb : 65 1c __ ADC ACCU + 1 
13ed : aa __ __ TAX
13ee : 98 __ __ TYA
13ef : 18 __ __ CLC
13f0 : 65 0d __ ADC P0 ; (x + 0)
13f2 : 90 01 __ BCC $13f5 ; (get_compact_tile.s1015 + 0)
.s1014:
; 207, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
13f4 : e8 __ __ INX
.s1015:
13f5 : 18 __ __ CLC
13f6 : 65 0d __ ADC P0 ; (x + 0)
13f8 : 90 01 __ BCC $13fb ; (get_compact_tile.s1017 + 0)
.s1016:
; 207, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
13fa : e8 __ __ INX
.s1017:
13fb : 18 __ __ CLC
13fc : 65 0d __ ADC P0 ; (x + 0)
13fe : 8d f0 9f STA $9ff0 ; (r1 + 0)
1401 : 8a __ __ TXA
1402 : 69 00 __ ADC #$00
1404 : 8d f1 9f STA $9ff1 ; (r1 + 1)
; 210, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1407 : 4a __ __ LSR
1408 : 85 44 __ STA T1 + 1 
140a : ad f0 9f LDA $9ff0 ; (r1 + 0)
140d : 6a __ __ ROR
140e : 46 44 __ LSR T1 + 1 
1410 : 6a __ __ ROR
1411 : 46 44 __ LSR T1 + 1 
1413 : 6a __ __ ROR
1414 : 18 __ __ CLC
1415 : 69 38 __ ADC #$38
1417 : 85 43 __ STA T1 + 0 
1419 : 8d ee 9f STA $9fee ; (result + 0)
141c : a9 41 __ LDA #$41
141e : 65 44 __ ADC T1 + 1 
1420 : 85 44 __ STA T1 + 1 
1422 : 8d ef 9f STA $9fef ; (byte_ptr + 1)
; 211, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1425 : ad f0 9f LDA $9ff0 ; (r1 + 0)
1428 : 29 07 __ AND #$07
142a : 85 1b __ STA ACCU + 0 
142c : 8d ed 9f STA $9fed ; (s + 1)
; 217, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
142f : aa __ __ TAX
1430 : a0 00 __ LDY #$00
1432 : b1 43 __ LDA (T1 + 0),y 
1434 : e0 00 __ CPX #$00
1436 : f0 04 __ BEQ $143c ; (get_compact_tile.s1003 + 0)
.l1002:
; 217, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1438 : 4a __ __ LSR
1439 : ca __ __ DEX
143a : d0 fc __ BNE $1438 ; (get_compact_tile.l1002 + 0)
.s1003:
; 214, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
143c : 85 1c __ STA ACCU + 1 
143e : a5 1b __ LDA ACCU + 0 
1440 : c9 06 __ CMP #$06
1442 : a5 1c __ LDA ACCU + 1 
1444 : 90 23 __ BCC $1469 ; (get_compact_tile.s1009 + 0)
.s7:
; 222, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1446 : 8d eb 9f STA $9feb ; (i + 0)
; 221, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1449 : a9 08 __ LDA #$08
144b : e5 1b __ SBC ACCU + 0 
144d : 8d ec 9f STA $9fec ; (entropy1 + 1)
; 225, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1450 : aa __ __ TAX
1451 : bd 24 41 LDA $4124,x ; (bitshift + 36)
1454 : 38 __ __ SEC
1455 : e9 01 __ SBC #$01
1457 : a0 01 __ LDY #$01
1459 : 31 43 __ AND (T1 + 0),y 
145b : ae ec 9f LDX $9fec ; (entropy1 + 1)
145e : f0 04 __ BEQ $1464 ; (get_compact_tile.s1005 + 0)
.l1006:
1460 : 0a __ __ ASL
1461 : ca __ __ DEX
1462 : d0 fc __ BNE $1460 ; (get_compact_tile.l1006 + 0)
.s1005:
; 225, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1464 : 8d ea 9f STA $9fea ; (entropy2 + 1)
; 227, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1467 : 05 1c __ ORA ACCU + 1 
.s1009:
1469 : 29 07 __ AND #$07
146b : 60 __ __ RTS
--------------------------------------------------------------------
place_room: ; place_room(u8,u8,u8,u8)->void
.s0:
; 151, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
146c : a9 02 __ LDA #$02
146e : 85 12 __ STA P5 
1470 : a5 14 __ LDA P7 ; (y + 0)
1472 : 4c 79 14 JMP $1479 ; (place_room.l1 + 0)
.s3:
; 151, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1475 : a5 4a __ LDA T3 + 0 
1477 : 69 00 __ ADC #$00
.l1:
1479 : 8d e7 9f STA $9fe7 ; (idx + 0)
147c : 18 __ __ CLC
147d : a5 16 __ LDA P9 ; (h + 0)
147f : 65 14 __ ADC P7 ; (y + 0)
1481 : 85 43 __ STA T0 + 0 
1483 : ad e7 9f LDA $9fe7 ; (idx + 0)
1486 : 85 4a __ STA T3 + 0 
1488 : b0 2f __ BCS $14b9 ; (place_room.s2 + 0)
.s1005:
148a : c5 43 __ CMP T0 + 0 
148c : 90 2b __ BCC $14b9 ; (place_room.s2 + 0)
.s4:
; 158, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
148e : ad de 3f LDA $3fde ; (room_count + 0)
1491 : c9 14 __ CMP #$14
1493 : b0 23 __ BCS $14b8 ; (place_room.s1001 + 0)
.s9:
; 159, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1495 : 0a __ __ ASL
1496 : 0a __ __ ASL
1497 : 0a __ __ ASL
1498 : aa __ __ TAX
1499 : a5 13 __ LDA P6 ; (x + 0)
149b : 9d 00 4c STA $4c00,x ; (rooms + 0)
; 160, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
149e : a5 14 __ LDA P7 ; (y + 0)
14a0 : 9d 01 4c STA $4c01,x ; (rooms + 1)
; 161, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
14a3 : a5 15 __ LDA P8 ; (w + 0)
14a5 : 9d 02 4c STA $4c02,x ; (rooms + 2)
; 162, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
14a8 : a5 16 __ LDA P9 ; (h + 0)
14aa : 9d 03 4c STA $4c03,x ; (rooms + 3)
; 164, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
14ad : a9 00 __ LDA #$00
14af : 9d 04 4c STA $4c04,x ; (rooms + 4)
; 163, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
14b2 : 9d 07 4c STA $4c07,x ; (rooms + 7)
; 165, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
14b5 : ee de 3f INC $3fde ; (room_count + 0)
.s1001:
; 167, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
14b8 : 60 __ __ RTS
.s2:
; 152, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
14b9 : a5 13 __ LDA P6 ; (x + 0)
14bb : 8d e6 9f STA $9fe6 ; (screen_pos + 1)
14be : 18 __ __ CLC
14bf : 65 15 __ ADC P8 ; (w + 0)
14c1 : 85 48 __ STA T1 + 0 
14c3 : a9 00 __ LDA #$00
14c5 : 2a __ __ ROL
14c6 : 85 49 __ STA T1 + 1 
14c8 : d0 07 __ BNE $14d1 ; (place_room.l6 + 0)
.s1002:
; 152, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
14ca : ad e6 9f LDA $9fe6 ; (screen_pos + 1)
14cd : c5 48 __ CMP T1 + 0 
14cf : b0 a4 __ BCS $1475 ; (place_room.s3 + 0)
.l6:
; 153, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
14d1 : a5 4a __ LDA T3 + 0 
14d3 : 85 11 __ STA P4 
.l1008:
14d5 : ad e6 9f LDA $9fe6 ; (screen_pos + 1)
14d8 : 85 10 __ STA P3 
14da : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
; 152, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
14dd : a6 10 __ LDX P3 
14df : e8 __ __ INX
14e0 : 8e e6 9f STX $9fe6 ; (screen_pos + 1)
14e3 : a5 49 __ LDA T1 + 1 
14e5 : d0 ee __ BNE $14d5 ; (place_room.l1008 + 0)
14e7 : f0 e1 __ BEQ $14ca ; (place_room.s1002 + 0)
--------------------------------------------------------------------
set_compact_tile: ; set_compact_tile(u8,u8,u8)->void
.s0:
; 238, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
14e9 : a5 0d __ LDA P0 ; (x + 0)
14eb : c9 40 __ CMP #$40
14ed : b0 06 __ BCS $14f5 ; (set_compact_tile.s1001 + 0)
.s4:
14ef : a5 0e __ LDA P1 ; (y + 0)
14f1 : c9 40 __ CMP #$40
14f3 : 90 01 __ BCC $14f6 ; (set_compact_tile.s3 + 0)
.s1001:
14f5 : 60 __ __ RTS
.s3:
; 250, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
14f6 : 85 1c __ STA ACCU + 1 
14f8 : 4a __ __ LSR
14f9 : aa __ __ TAX
14fa : a9 00 __ LDA #$00
14fc : 6a __ __ ROR
14fd : 85 43 __ STA T1 + 0 
14ff : a9 00 __ LDA #$00
1501 : 46 1c __ LSR ACCU + 1 
1503 : 6a __ __ ROR
1504 : 66 1c __ ROR ACCU + 1 
1506 : 6a __ __ ROR
1507 : 65 43 __ ADC T1 + 0 
1509 : a8 __ __ TAY
150a : 8a __ __ TXA
150b : 65 1c __ ADC ACCU + 1 
150d : aa __ __ TAX
150e : 98 __ __ TYA
150f : 18 __ __ CLC
1510 : 65 0d __ ADC P0 ; (x + 0)
1512 : 90 01 __ BCC $1515 ; (set_compact_tile.s1023 + 0)
.s1022:
; 241, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1514 : e8 __ __ INX
.s1023:
1515 : 18 __ __ CLC
1516 : 65 0d __ ADC P0 ; (x + 0)
1518 : 90 01 __ BCC $151b ; (set_compact_tile.s1025 + 0)
.s1024:
; 241, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
151a : e8 __ __ INX
.s1025:
151b : 18 __ __ CLC
151c : 65 0d __ ADC P0 ; (x + 0)
151e : 8d f0 9f STA $9ff0 ; (r1 + 0)
1521 : 8a __ __ TXA
1522 : 69 00 __ ADC #$00
1524 : 8d f1 9f STA $9ff1 ; (r1 + 1)
; 244, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1527 : 4a __ __ LSR
1528 : 85 44 __ STA T1 + 1 
152a : ad f0 9f LDA $9ff0 ; (r1 + 0)
152d : 6a __ __ ROR
152e : 46 44 __ LSR T1 + 1 
1530 : 6a __ __ ROR
1531 : 46 44 __ LSR T1 + 1 
1533 : 6a __ __ ROR
1534 : 18 __ __ CLC
1535 : 69 38 __ ADC #$38
1537 : 85 43 __ STA T1 + 0 
1539 : 8d ee 9f STA $9fee ; (result + 0)
153c : a9 41 __ LDA #$41
153e : 65 44 __ ADC T1 + 1 
1540 : 85 44 __ STA T1 + 1 
1542 : 8d ef 9f STA $9fef ; (byte_ptr + 1)
; 245, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1545 : ad f0 9f LDA $9ff0 ; (r1 + 0)
1548 : 29 07 __ AND #$07
154a : 85 1b __ STA ACCU + 0 
154c : 8d ed 9f STA $9fed ; (s + 1)
; 250, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
154f : a5 0f __ LDA P2 ; (tile + 0)
1551 : 29 07 __ AND #$07
1553 : 85 1d __ STA ACCU + 2 
1555 : a0 00 __ LDY #$00
1557 : b1 43 __ LDA (T1 + 0),y 
1559 : 85 1c __ STA ACCU + 1 
155b : a5 1b __ LDA ACCU + 0 
155d : c9 06 __ CMP #$06
155f : b0 1c __ BCS $157d ; (set_compact_tile.s7 + 0)
.s6:
; 252, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1561 : aa __ __ TAX
1562 : bd d3 3f LDA $3fd3,x ; (__shltab7L + 0)
1565 : 8d ec 9f STA $9fec ; (entropy1 + 1)
; 253, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1568 : 49 ff __ EOR #$ff
156a : 25 1c __ AND ACCU + 1 
156c : 85 1c __ STA ACCU + 1 
156e : a5 1d __ LDA ACCU + 2 
1570 : e0 00 __ CPX #$00
1572 : f0 04 __ BEQ $1578 ; (set_compact_tile.s1016 + 0)
.l1014:
1574 : 0a __ __ ASL
1575 : ca __ __ DEX
1576 : d0 fc __ BNE $1574 ; (set_compact_tile.l1014 + 0)
.s1016:
; 253, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1578 : 05 1c __ ORA ACCU + 1 
.s1017:
; 265, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
157a : 91 43 __ STA (T1 + 0),y 
157c : 60 __ __ RTS
.s7:
; 256, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
157d : a9 08 __ LDA #$08
157f : e5 1b __ SBC ACCU + 0 
1581 : 85 1e __ STA ACCU + 3 
1583 : 8d eb 9f STA $9feb ; (i + 0)
; 257, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1586 : aa __ __ TAX
1587 : 49 03 __ EOR #$03
1589 : 85 45 __ STA T5 + 0 
158b : 8d ea 9f STA $9fea ; (entropy2 + 1)
; 260, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
158e : bd 08 41 LDA $4108,x ; (bitshift + 8)
1591 : 38 __ __ SEC
1592 : e9 01 __ SBC #$01
1594 : 85 46 __ STA T6 + 0 
1596 : a6 1b __ LDX ACCU + 0 
1598 : f0 04 __ BEQ $159e ; (set_compact_tile.s1003 + 0)
.l1010:
159a : 0a __ __ ASL
159b : ca __ __ DEX
159c : d0 fc __ BNE $159a ; (set_compact_tile.l1010 + 0)
.s1003:
; 260, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
159e : 85 47 __ STA T7 + 0 
15a0 : 8d e9 9f STA $9fe9 ; (connected + 1)
; 261, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
15a3 : a5 1d __ LDA ACCU + 2 
15a5 : 25 46 __ AND T6 + 0 
15a7 : a6 1b __ LDX ACCU + 0 
15a9 : f0 04 __ BEQ $15af ; (set_compact_tile.s1005 + 0)
.l1012:
15ab : 0a __ __ ASL
15ac : ca __ __ DEX
15ad : d0 fc __ BNE $15ab ; (set_compact_tile.l1012 + 0)
.s1005:
; 261, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
15af : 85 46 __ STA T6 + 0 
15b1 : a9 ff __ LDA #$ff
15b3 : 45 47 __ EOR T7 + 0 
15b5 : 25 1c __ AND ACCU + 1 
15b7 : 05 46 __ ORA T6 + 0 
15b9 : 91 43 __ STA (T1 + 0),y 
; 264, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
15bb : a6 45 __ LDX T5 + 0 
15bd : bd 08 41 LDA $4108,x ; (bitshift + 8)
15c0 : 38 __ __ SEC
15c1 : e9 01 __ SBC #$01
15c3 : 8d e8 9f STA $9fe8 ; (entropy3 + 1)
; 265, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
15c6 : 49 ff __ EOR #$ff
15c8 : a0 01 __ LDY #$01
15ca : 31 43 __ AND (T1 + 0),y 
15cc : 85 1b __ STA ACCU + 0 
15ce : a5 1d __ LDA ACCU + 2 
15d0 : a6 1e __ LDX ACCU + 3 
.l1006:
15d2 : 4a __ __ LSR
15d3 : ca __ __ DEX
15d4 : d0 fc __ BNE $15d2 ; (set_compact_tile.l1006 + 0)
.s1007:
15d6 : 05 1b __ ORA ACCU + 0 
15d8 : 4c 7a 15 JMP $157a ; (set_compact_tile.s1017 + 0)
--------------------------------------------------------------------
15db : __ __ __ BYT 2e 00                                           : ..
--------------------------------------------------------------------
assign_room_priorities: ; assign_room_priorities()->void
.s0:
; 175, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15dd : a9 00 __ LDA #$00
15df : 8d ec 9f STA $9fec ; (entropy1 + 1)
15e2 : ad de 3f LDA $3fde ; (room_count + 0)
15e5 : 85 45 __ STA T4 + 0 
15e7 : f0 3b __ BEQ $1624 ; (assign_room_priorities.s1001 + 0)
.l2:
; 176, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15e9 : ae ec 9f LDX $9fec ; (entropy1 + 1)
15ec : e8 __ __ INX
15ed : 86 46 __ STX T5 + 0 
15ef : ad ec 9f LDA $9fec ; (entropy1 + 1)
15f2 : 0a __ __ ASL
15f3 : 0a __ __ ASL
15f4 : 0a __ __ ASL
15f5 : 85 44 __ STA T2 + 0 
15f7 : ad ec 9f LDA $9fec ; (entropy1 + 1)
15fa : d0 04 __ BNE $1600 ; (assign_room_priorities.s6 + 0)
.s5:
; 177, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
15fc : a9 0a __ LDA #$0a
15fe : d0 16 __ BNE $1616 ; (assign_room_priorities.s1 + 0)
.s6:
; 178, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1600 : a5 45 __ LDA T4 + 0 
1602 : 38 __ __ SEC
1603 : e9 01 __ SBC #$01
1605 : cd ec 9f CMP $9fec ; (entropy1 + 1)
1608 : d0 04 __ BNE $160e ; (assign_room_priorities.s9 + 0)
.s8:
; 179, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
160a : a9 08 __ LDA #$08
160c : d0 08 __ BNE $1616 ; (assign_room_priorities.s1 + 0)
.s9:
; 182, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
160e : a9 03 __ LDA #$03
1610 : 20 50 0a JSR $0a50 ; (rnd.s0 + 0)
1613 : 18 __ __ CLC
1614 : 69 05 __ ADC #$05
.s1:
; 177, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1616 : a6 44 __ LDX T2 + 0 
1618 : 9d 07 4c STA $4c07,x ; (rooms + 7)
; 175, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
161b : a5 46 __ LDA T5 + 0 
161d : 8d ec 9f STA $9fec ; (entropy1 + 1)
1620 : c5 45 __ CMP T4 + 0 
1622 : 90 c5 __ BCC $15e9 ; (assign_room_priorities.l2 + 0)
.s1001:
; 185, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/room_management.c"
1624 : 60 __ __ RTS
--------------------------------------------------------------------
init_room_center_cache: ; init_room_center_cache()->void
.s0:
; 870, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1625 : a9 00 __ LDA #$00
1627 : 8d f1 9f STA $9ff1 ; (r1 + 1)
162a : ad de 3f LDA $3fde ; (room_count + 0)
162d : f0 2e __ BEQ $165d ; (init_room_center_cache.s4 + 0)
.l5:
162f : ad f1 9f LDA $9ff1 ; (r1 + 1)
1632 : c9 14 __ CMP #$14
1634 : b0 27 __ BCS $165d ; (init_room_center_cache.s4 + 0)
.s2:
; 871, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1636 : 85 0d __ STA P0 
1638 : 20 4f 0d JSR $0d4f ; (get_room_center_x.s0 + 0)
163b : aa __ __ TAX
163c : a5 0d __ LDA P0 
163e : 0a __ __ ASL
163f : 85 43 __ STA T1 + 0 
1641 : a8 __ __ TAY
1642 : 8a __ __ TXA
1643 : 99 a0 4c STA $4ca0,y ; (room_center_cache + 0)
; 872, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1646 : a5 0d __ LDA P0 
1648 : 20 7c 0d JSR $0d7c ; (get_room_center_y.s0 + 0)
164b : a6 43 __ LDX T1 + 0 
164d : 9d a1 4c STA $4ca1,x ; (room_center_cache + 1)
; 870, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1650 : 18 __ __ CLC
1651 : a5 0d __ LDA P0 
1653 : 69 01 __ ADC #$01
1655 : 8d f1 9f STA $9ff1 ; (r1 + 1)
1658 : cd de 3f CMP $3fde ; (room_count + 0)
165b : 90 d2 __ BCC $162f ; (init_room_center_cache.l5 + 0)
.s4:
; 874, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
165d : a9 01 __ LDA #$01
165f : 8d df 3f STA $3fdf ; (room_center_cache_valid + 0)
.s1001:
; 875, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1662 : 60 __ __ RTS
--------------------------------------------------------------------
update_camera: ; update_camera()->void
.s0:
;  31, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
1663 : ad f0 40 LDA $40f0 ; (view + 0)
1666 : 85 46 __ STA T5 + 0 
1668 : 8d f1 9f STA $9ff1 ; (r1 + 1)
;  32, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
166b : ad f1 40 LDA $40f1 ; (view + 1)
166e : 85 47 __ STA T6 + 0 
1670 : 8d f0 9f STA $9ff0 ; (r1 + 0)
;  33, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
1673 : ad ee 40 LDA $40ee ; (camera_center_x + 0)
1676 : 85 44 __ STA T2 + 0 
1678 : 8d ef 9f STA $9fef ; (byte_ptr + 1)
;  34, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
167b : ad ef 40 LDA $40ef ; (camera_center_y + 0)
167e : 85 45 __ STA T4 + 0 
1680 : 8d ee 9f STA $9fee ; (result + 0)
;  36, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
1683 : 20 eb 16 JSR $16eb ; (get_viewport_half_width.s1001 + 0)
1686 : 85 43 __ STA T1 + 0 
1688 : 8d ed 9f STA $9fed ; (s + 1)
;  37, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
168b : 20 ee 16 JSR $16ee ; (get_viewport_half_height.s1001 + 0)
168e : 85 1b __ STA ACCU + 0 
1690 : 8d ec 9f STA $9fec ; (entropy1 + 1)
;  40, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
1693 : a5 44 __ LDA T2 + 0 
1695 : c5 43 __ CMP T1 + 0 
1697 : b0 04 __ BCS $169d ; (update_camera.s1 + 0)
.s2:
;  43, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
1699 : a9 00 __ LDA #$00
169b : 90 02 __ BCC $169f ; (update_camera.s18 + 0)
.s1:
;  41, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
169d : e5 43 __ SBC T1 + 0 
.s18:
;  43, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
169f : 8d f0 40 STA $40f0 ; (view + 0)
;  46, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
16a2 : a5 45 __ LDA T4 + 0 
16a4 : c5 1b __ CMP ACCU + 0 
16a6 : b0 04 __ BCS $16ac ; (update_camera.s4 + 0)
.s5:
;  49, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
16a8 : a9 00 __ LDA #$00
16aa : 90 02 __ BCC $16ae ; (update_camera.s19 + 0)
.s4:
;  47, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
16ac : e5 1b __ SBC ACCU + 0 
.s19:
;  49, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
16ae : 8d f1 40 STA $40f1 ; (view + 1)
;  53, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
16b1 : a9 18 __ LDA #$18
16b3 : cd f0 40 CMP $40f0 ; (view + 0)
16b6 : b0 03 __ BCS $16bb ; (update_camera.s20 + 0)
.s7:
;  54, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
16b8 : 8d f0 40 STA $40f0 ; (view + 0)
.s20:
;  56, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
16bb : a9 27 __ LDA #$27
16bd : cd f1 40 CMP $40f1 ; (view + 1)
16c0 : b0 03 __ BCS $16c5 ; (update_camera.s12 + 0)
.s10:
;  57, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
16c2 : 8d f1 40 STA $40f1 ; (view + 1)
.s12:
;  62, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
16c5 : ad f0 40 LDA $40f0 ; (view + 0)
16c8 : 18 __ __ CLC
16c9 : 65 43 __ ADC T1 + 0 
16cb : 8d ee 40 STA $40ee ; (camera_center_x + 0)
;  63, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
16ce : 18 __ __ CLC
16cf : a5 1b __ LDA ACCU + 0 
16d1 : 6d f1 40 ADC $40f1 ; (view + 1)
16d4 : 8d ef 40 STA $40ef ; (camera_center_y + 0)
;  66, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
16d7 : a5 46 __ LDA T5 + 0 
16d9 : cd f0 40 CMP $40f0 ; (view + 0)
16dc : d0 07 __ BNE $16e5 ; (update_camera.s13 + 0)
.s16:
16de : a5 47 __ LDA T6 + 0 
16e0 : cd f1 40 CMP $40f1 ; (view + 1)
16e3 : f0 05 __ BEQ $16ea ; (update_camera.s1001 + 0)
.s13:
;  67, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
16e5 : a9 01 __ LDA #$01
16e7 : 8d f2 40 STA $40f2 ; (screen_dirty + 0)
.s1001:
;  69, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
16ea : 60 __ __ RTS
--------------------------------------------------------------------
get_viewport_half_width: ; get_viewport_half_width()->u8
.s1001:
16eb : a9 14 __ LDA #$14
; 805, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
16ed : 60 __ __ RTS
--------------------------------------------------------------------
get_viewport_half_height: ; get_viewport_half_height()->u8
.s1001:
16ee : a9 0c __ LDA #$0c
; 810, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
16f0 : 60 __ __ RTS
--------------------------------------------------------------------
get_max_connection_distance: ; get_max_connection_distance()->u8
.s0:
; 899, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
16f1 : a9 08 __ LDA #$08
16f3 : cd de 3f CMP $3fde ; (room_count + 0)
16f6 : a9 50 __ LDA #$50
16f8 : b0 02 __ BCS $16fc ; (get_max_connection_distance.s1001 + 0)
.s3:
; 904, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
16fa : a9 1e __ LDA #$1e
.s1001:
16fc : 60 __ __ RTS
--------------------------------------------------------------------
get_viewport_max_y: ; get_viewport_max_y()->u8
.s1001:
16fd : a9 18 __ LDA #$18
; 820, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
16ff : 60 __ __ RTS
--------------------------------------------------------------------
1700 : __ __ __ BYT 0a 0a 43 72 65 61 74 69 6e 67 20 63 6f 72 72 69 : ..Creating corri
1710 : __ __ __ BYT 64 6f 72 73 2e 2e 2e 00                         : dors....
--------------------------------------------------------------------
find_best_connection_striped: ; find_best_connection_striped(u8*,u8*,u8*)->u8
.s0:
;1244, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1718 : a9 00 __ LDA #$00
171a : 8d ec 9f STA $9fec ; (entropy1 + 1)
;1241, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
171d : 8d ed 40 STA $40ed ; (edge_candidate_count + 0)
;1266, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1720 : a5 15 __ LDA P8 ; (connected + 0)
1722 : 8d e8 9f STA $9fe8 ; (entropy3 + 1)
1725 : a5 16 __ LDA P9 ; (connected + 1)
1727 : 8d e9 9f STA $9fe9 ; (connected + 1)
;1244, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
172a : ad de 3f LDA $3fde ; (room_count + 0)
172d : 85 45 __ STA T6 + 0 
172f : d0 03 __ BNE $1734 ; (find_best_connection_striped.l3 + 0)
1731 : 4c b5 18 JMP $18b5 ; (find_best_connection_striped.s1 + 0)
.l3:
;1245, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1734 : ac ec 9f LDY $9fec ; (entropy1 + 1)
1737 : 84 46 __ STY T8 + 0 
1739 : b1 15 __ LDA (P8),y ; (connected + 0)
173b : d0 03 __ BNE $1740 ; (find_best_connection_striped.s8 + 0)
173d : 4c a6 18 JMP $18a6 ; (find_best_connection_striped.s4 + 0)
.s8:
;1247, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1740 : a9 00 __ LDA #$00
1742 : 8d eb 9f STA $9feb ; (i + 0)
.l11:
;1248, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1745 : 85 47 __ STA T9 + 0 
1747 : a8 __ __ TAY
1748 : b1 15 __ LDA (P8),y ; (connected + 0)
174a : f0 03 __ BEQ $174f ; (find_best_connection_striped.s17 + 0)
174c : 4c 97 18 JMP $1897 ; (find_best_connection_striped.s12 + 0)
.s17:
174f : a5 46 __ LDA T8 + 0 
1751 : c5 47 __ CMP T9 + 0 
1753 : f0 f7 __ BEQ $174c ; (find_best_connection_striped.l11 + 7)
.s16:
;1251, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1755 : 8c e4 9f STY $9fe4 ; (random_offset_x + 0)
;1343, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1758 : 8c e0 9f STY $9fe0 ; (y + 0)
;1251, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
175b : 8d e5 9f STA $9fe5 ; (leg1_end_x + 0)
;1343, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
175e : 8d e1 9f STA $9fe1 ; (r1 + 0)
;1292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1761 : a9 00 __ LDA #$00
1763 : 8d e2 9f STA $9fe2 ; (best_distance + 0)
1766 : ad ec 40 LDA $40ec ; (striped_cache_size + 0)
1769 : 85 48 __ STA T10 + 0 
176b : d0 08 __ BNE $1775 ; (find_best_connection_striped.s1005 + 0)
.s1006:
176d : a9 00 __ LDA #$00
176f : 85 44 __ STA T5 + 0 
.s28:
;1302, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1771 : a9 ff __ LDA #$ff
1773 : d0 35 __ BNE $17aa ; (find_best_connection_striped.s20 + 0)
.s1005:
;1292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1775 : a9 01 __ LDA #$01
1777 : 85 44 __ STA T5 + 0 
.l26:
;1293, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1779 : ae e2 9f LDX $9fe2 ; (best_distance + 0)
177c : bd c0 4d LDA $4dc0,x ; (connection_distance_cache_striped.valid + 0)
177f : f0 1a __ BEQ $179b ; (find_best_connection_striped.s27 + 0)
.s32:
;1294, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1781 : a5 46 __ LDA T8 + 0 
1783 : dd 00 4d CMP $4d00,x ; (connection_distance_cache_striped.room1 + 0)
1786 : d0 06 __ BNE $178e ; (find_best_connection_striped.s33 + 0)
.s34:
;1295, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1788 : 98 __ __ TYA
1789 : dd 40 4d CMP $4d40,x ; (connection_distance_cache_striped.room2 + 0)
178c : f0 19 __ BEQ $17a7 ; (find_best_connection_striped.s29 + 0)
.s33:
;1296, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
178e : 98 __ __ TYA
178f : dd 00 4d CMP $4d00,x ; (connection_distance_cache_striped.room1 + 0)
1792 : d0 07 __ BNE $179b ; (find_best_connection_striped.s27 + 0)
.s35:
;1297, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1794 : a5 46 __ LDA T8 + 0 
1796 : dd 40 4d CMP $4d40,x ; (connection_distance_cache_striped.room2 + 0)
1799 : f0 0c __ BEQ $17a7 ; (find_best_connection_striped.s29 + 0)
.s27:
;1292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
179b : ee e2 9f INC $9fe2 ; (best_distance + 0)
179e : ad e2 9f LDA $9fe2 ; (best_distance + 0)
17a1 : c5 48 __ CMP T10 + 0 
17a3 : 90 d4 __ BCC $1779 ; (find_best_connection_striped.l26 + 0)
17a5 : b0 ca __ BCS $1771 ; (find_best_connection_striped.s28 + 0)
.s29:
;1298, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
17a7 : bd 80 4d LDA $4d80,x ; (connection_distance_cache_striped.distance + 0)
.s20:
17aa : 8d df 9f STA $9fdf ; (leg_length + 0)
;1343, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
17ad : 85 1b __ STA ACCU + 0 
17af : 8d e7 9f STA $9fe7 ; (idx + 0)
;1344, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
17b2 : c9 ff __ CMP #$ff
17b4 : f0 03 __ BEQ $17b9 ; (find_best_connection_striped.s40 + 0)
17b6 : 4c 4f 18 JMP $184f ; (find_best_connection_striped.s19 + 0)
.s40:
;1349, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
17b9 : 84 14 __ STY P7 
17bb : a5 46 __ LDA T8 + 0 
17bd : 85 13 __ STA P6 
17bf : 20 c6 0c JSR $0cc6 ; (calculate_room_distance.s0 + 0)
17c2 : 85 1b __ STA ACCU + 0 
;1350, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
17c4 : 8d db 9f STA $9fdb ; (grid_positions + 13)
;1349, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
17c7 : 8d e6 9f STA $9fe6 ; (screen_pos + 1)
;1350, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
17ca : a5 13 __ LDA P6 
17cc : 8d dd 9f STA $9fdd ; (grid_positions + 15)
17cf : a5 48 __ LDA T10 + 0 
17d1 : c9 40 __ CMP #$40
17d3 : a6 47 __ LDX T9 + 0 
17d5 : 8e dc 9f STX $9fdc ; (grid_positions + 14)
;1308, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
17d8 : b0 75 __ BCS $184f ; (find_best_connection_striped.s19 + 0)
.s47:
17da : a5 13 __ LDA P6 
17dc : c5 45 __ CMP T6 + 0 
17de : b0 6f __ BCS $184f ; (find_best_connection_striped.s19 + 0)
.s46:
17e0 : 8a __ __ TXA
17e1 : e4 45 __ CPX T6 + 0 
17e3 : b0 6a __ BCS $184f ; (find_best_connection_striped.s19 + 0)
.s45:
;1313, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
17e5 : 8d d8 9f STA $9fd8 ; (grid_positions + 10)
;1292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
17e8 : a9 00 __ LDA #$00
17ea : 8d da 9f STA $9fda ; (grid_positions + 12)
;1313, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
17ed : a5 13 __ LDA P6 
17ef : 8d d9 9f STA $9fd9 ; (grid_positions + 11)
;1292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
17f2 : a5 44 __ LDA T5 + 0 
17f4 : f0 34 __ BEQ $182a ; (find_best_connection_striped.s60 + 0)
.l58:
;1293, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
17f6 : ae da 9f LDX $9fda ; (grid_positions + 12)
17f9 : bd c0 4d LDA $4dc0,x ; (connection_distance_cache_striped.valid + 0)
17fc : f0 22 __ BEQ $1820 ; (find_best_connection_striped.s59 + 0)
.s64:
;1294, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
17fe : a5 46 __ LDA T8 + 0 
1800 : dd 00 4d CMP $4d00,x ; (connection_distance_cache_striped.room1 + 0)
1803 : f0 05 __ BEQ $180a ; (find_best_connection_striped.s66 + 0)
.s1051:
;1296, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1805 : a5 14 __ LDA P7 
1807 : 4c 14 18 JMP $1814 ; (find_best_connection_striped.s65 + 0)
.s66:
;1295, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
180a : a5 14 __ LDA P7 
180c : dd 40 4d CMP $4d40,x ; (connection_distance_cache_striped.room2 + 0)
180f : d0 03 __ BNE $1814 ; (find_best_connection_striped.s65 + 0)
1811 : 4c 45 19 JMP $1945 ; (find_best_connection_striped.s61 + 0)
.s65:
;1296, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1814 : dd 00 4d CMP $4d00,x ; (connection_distance_cache_striped.room1 + 0)
1817 : d0 07 __ BNE $1820 ; (find_best_connection_striped.s59 + 0)
.s67:
;1297, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1819 : a5 46 __ LDA T8 + 0 
181b : dd 40 4d CMP $4d40,x ; (connection_distance_cache_striped.room2 + 0)
181e : f0 f1 __ BEQ $1811 ; (find_best_connection_striped.s66 + 7)
.s59:
;1292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1820 : ee da 9f INC $9fda ; (grid_positions + 12)
1823 : ad da 9f LDA $9fda ; (grid_positions + 12)
1826 : c5 48 __ CMP T10 + 0 
1828 : 90 cc __ BCC $17f6 ; (find_best_connection_striped.l58 + 0)
.s60:
;1302, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
182a : a9 ff __ LDA #$ff
182c : 8d d7 9f STA $9fd7 ; (grid_positions + 9)
.s51:
;1317, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
182f : a5 48 __ LDA T10 + 0 
1831 : 8d de 9f STA $9fde ; (pivot_x + 0)
1834 : aa __ __ TAX
1835 : 18 __ __ CLC
1836 : 69 01 __ ADC #$01
1838 : 8d ec 40 STA $40ec ; (striped_cache_size + 0)
;1319, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
183b : a5 46 __ LDA T8 + 0 
183d : 9d 00 4d STA $4d00,x ; (connection_distance_cache_striped.room1 + 0)
;1320, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1840 : a5 14 __ LDA P7 
1842 : 9d 40 4d STA $4d40,x ; (connection_distance_cache_striped.room2 + 0)
;1321, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1845 : a5 1b __ LDA ACCU + 0 
1847 : 9d 80 4d STA $4d80,x ; (connection_distance_cache_striped.distance + 0)
;1322, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
184a : a9 01 __ LDA #$01
184c : 9d c0 4d STA $4dc0,x ; (connection_distance_cache_striped.valid + 0)
.s19:
;1345, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
184f : a5 1b __ LDA ACCU + 0 
1851 : 8d e3 9f STA $9fe3 ; (screen_offset + 1)
;1251, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1854 : 8d ea 9f STA $9fea ; (entropy2 + 1)
;1254, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1857 : c9 ff __ CMP #$ff
1859 : b0 3c __ BCS $1897 ; (find_best_connection_striped.s12 + 0)
.s72:
;1255, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
185b : 8d d3 9f STA $9fd3 ; (grid_positions + 5)
185e : a5 46 __ LDA T8 + 0 
1860 : 8d d5 9f STA $9fd5 ; (grid_positions + 7)
1863 : ad ed 40 LDA $40ed ; (edge_candidate_count + 0)
1866 : c9 20 __ CMP #$20
1868 : a6 47 __ LDX T9 + 0 
186a : 8e d4 9f STX $9fd4 ; (grid_positions + 6)
;1185, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
186d : 90 07 __ BCC $1876 ; (find_best_connection_striped.s81 + 0)
.s79:
;1186, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
186f : a9 00 __ LDA #$00
1871 : 8d d2 9f STA $9fd2 ; (grid_positions + 4)
1874 : b0 3f __ BCS $18b5 ; (find_best_connection_striped.s1 + 0)
.s81:
;1195, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1876 : 8d d6 9f STA $9fd6 ; (grid_positions + 8)
1879 : a8 __ __ TAY
187a : 69 01 __ ADC #$01
187c : 8d ed 40 STA $40ed ; (edge_candidate_count + 0)
;1196, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
187f : a5 46 __ LDA T8 + 0 
1881 : 99 00 52 STA $5200,y ; (mst_edge_candidates_striped.room1 + 0)
;1201, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1884 : a9 01 __ LDA #$01
1886 : 8d d2 9f STA $9fd2 ; (grid_positions + 4)
;1197, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1889 : 8a __ __ TXA
188a : 99 20 52 STA $5220,y ; (mst_edge_candidates_striped.room2 + 0)
;1198, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
188d : a5 1b __ LDA ACCU + 0 
188f : 99 40 52 STA $5240,y ; (mst_edge_candidates_striped.distance + 0)
;1199, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1892 : a9 00 __ LDA #$00
1894 : 99 60 52 STA $5260,y ; (mst_edge_candidates_striped.explored + 0)
.s12:
;1247, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1897 : 18 __ __ CLC
1898 : a5 47 __ LDA T9 + 0 
189a : 69 01 __ ADC #$01
189c : 8d eb 9f STA $9feb ; (i + 0)
189f : c5 45 __ CMP T6 + 0 
18a1 : b0 03 __ BCS $18a6 ; (find_best_connection_striped.s4 + 0)
18a3 : 4c 45 17 JMP $1745 ; (find_best_connection_striped.l11 + 0)
.s4:
;1244, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
18a6 : 18 __ __ CLC
18a7 : a5 46 __ LDA T8 + 0 
18a9 : 69 01 __ ADC #$01
18ab : 8d ec 9f STA $9fec ; (entropy1 + 1)
18ae : c5 45 __ CMP T6 + 0 
18b0 : b0 03 __ BCS $18b5 ; (find_best_connection_striped.s1 + 0)
18b2 : 4c 34 17 JMP $1734 ; (find_best_connection_striped.l3 + 0)
.s1:
;1268, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
18b5 : ad ed 40 LDA $40ed ; (edge_candidate_count + 0)
18b8 : f0 43 __ BEQ $18fd ; (find_best_connection_striped.s92 + 0)
.s94:
;1206, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
18ba : 85 15 __ STA P8 ; (connected + 0)
18bc : a9 ff __ LDA #$ff
18be : 8d d0 9f STA $9fd0 ; (grid_positions + 2)
;1207, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
18c1 : 8d cf 9f STA $9fcf ; (find_l_corridor_exits@stack + 4)
;1210, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
18c4 : a9 00 __ LDA #$00
18c6 : 8d d1 9f STA $9fd1 ; (grid_positions + 3)
18c9 : a5 15 __ LDA P8 ; (connected + 0)
18cb : f0 23 __ BEQ $18f0 ; (find_best_connection_striped.s100 + 0)
.l98:
;1211, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
18cd : ae d1 9f LDX $9fd1 ; (grid_positions + 3)
18d0 : bd 60 52 LDA $5260,x ; (mst_edge_candidates_striped.explored + 0)
18d3 : d0 11 __ BNE $18e6 ; (find_best_connection_striped.s97 + 0)
.s104:
;1212, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
18d5 : bd 40 52 LDA $5240,x ; (mst_edge_candidates_striped.distance + 0)
18d8 : cd cf 9f CMP $9fcf ; (find_l_corridor_exits@stack + 4)
18db : b0 09 __ BCS $18e6 ; (find_best_connection_striped.s97 + 0)
.s101:
;1213, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
18dd : 8d cf 9f STA $9fcf ; (find_l_corridor_exits@stack + 4)
;1214, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
18e0 : ad d1 9f LDA $9fd1 ; (grid_positions + 3)
18e3 : 8d d0 9f STA $9fd0 ; (grid_positions + 2)
.s97:
;1210, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
18e6 : ee d1 9f INC $9fd1 ; (grid_positions + 3)
18e9 : ad d1 9f LDA $9fd1 ; (grid_positions + 3)
18ec : c5 15 __ CMP P8 ; (connected + 0)
18ee : 90 dd __ BCC $18cd ; (find_best_connection_striped.l98 + 0)
.s100:
;1273, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
18f0 : ad d0 9f LDA $9fd0 ; (grid_positions + 2)
18f3 : 8d ed 9f STA $9fed ; (s + 1)
;1218, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
18f6 : 8d ce 9f STA $9fce ; (find_l_corridor_exits@stack + 3)
;1274, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
18f9 : c9 ff __ CMP #$ff
18fb : d0 05 __ BNE $1902 ; (find_best_connection_striped.s108 + 0)
.s92:
;1269, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
18fd : a9 00 __ LDA #$00
.s1001:
;1279, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
18ff : 85 1b __ STA ACCU + 0 
1901 : 60 __ __ RTS
.s108:
1902 : 8d cd 9f STA $9fcd ; (find_l_corridor_exits@stack + 2)
1905 : a5 17 __ LDA P10 ; (best_room1 + 0)
1907 : 8d cb 9f STA $9fcb ; (find_l_corridor_exits@stack + 0)
190a : a5 18 __ LDA P11 ; (best_room1 + 1)
190c : 8d cc 9f STA $9fcc ; (find_l_corridor_exits@stack + 1)
190f : ad f2 9f LDA $9ff2 ; (sstack + 0)
1912 : 85 1b __ STA ACCU + 0 
1914 : 8d c9 9f STA $9fc9 ; (exit1 + 4)
1917 : ad f3 9f LDA $9ff3 ; (sstack + 1)
191a : 8d ca 9f STA $9fca ; (exit1 + 5)
;1223, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
191d : ae d0 9f LDX $9fd0 ; (grid_positions + 2)
1920 : e4 15 __ CPX P8 ; (connected + 0)
1922 : b0 1a __ BCS $193e ; (find_best_connection_striped.s111 + 0)
.s113:
;1232, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1924 : 85 1c __ STA ACCU + 1 
1926 : a9 01 __ LDA #$01
1928 : 8d c8 9f STA $9fc8 ; (exit1 + 3)
;1228, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
192b : bd 00 52 LDA $5200,x ; (mst_edge_candidates_striped.room1 + 0)
192e : a0 00 __ LDY #$00
1930 : 91 17 __ STA (P10),y ; (best_room1 + 0)
;1229, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1932 : bd 20 52 LDA $5220,x ; (mst_edge_candidates_striped.room2 + 0)
1935 : 91 1b __ STA (ACCU + 0),y 
;1230, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1937 : a9 01 __ LDA #$01
1939 : 9d 60 52 STA $5260,x ; (mst_edge_candidates_striped.explored + 0)
;1279, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
193c : 90 c1 __ BCC $18ff ; (find_best_connection_striped.s1001 + 0)
.s111:
;1224, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
193e : a9 00 __ LDA #$00
1940 : 8d c8 9f STA $9fc8 ; (exit1 + 3)
;1279, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1943 : b0 ba __ BCS $18ff ; (find_best_connection_striped.s1001 + 0)
.s61:
;1298, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1945 : bd 80 4d LDA $4d80,x ; (connection_distance_cache_striped.distance + 0)
1948 : 8d d7 9f STA $9fd7 ; (grid_positions + 9)
;1313, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
194b : c9 ff __ CMP #$ff
194d : f0 03 __ BEQ $1952 ; (find_best_connection_striped.s61 + 13)
194f : 4c 4f 18 JMP $184f ; (find_best_connection_striped.s19 + 0)
1952 : 4c 2f 18 JMP $182f ; (find_best_connection_striped.s51 + 0)
--------------------------------------------------------------------
can_connect_rooms_safely: ; can_connect_rooms_safely(u8,u8)->u8
.s0:
; 294, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1955 : a5 17 __ LDA P10 ; (room1 + 0)
1957 : cd de 3f CMP $3fde ; (room_count + 0)
195a : b0 0d __ BCS $1969 ; (can_connect_rooms_safely.s1 + 0)
.s5:
195c : a5 18 __ LDA P11 ; (room2 + 0)
195e : cd de 3f CMP $3fde ; (room_count + 0)
1961 : b0 06 __ BCS $1969 ; (can_connect_rooms_safely.s1 + 0)
.s4:
1963 : a5 17 __ LDA P10 ; (room1 + 0)
1965 : c5 18 __ CMP P11 ; (room2 + 0)
1967 : d0 04 __ BNE $196d ; (can_connect_rooms_safely.s3 + 0)
.s1:
; 295, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1969 : a9 00 __ LDA #$00
196b : f0 1d __ BEQ $198a ; (can_connect_rooms_safely.s1001 + 0)
.s3:
; 299, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
196d : 85 15 __ STA P8 
196f : a5 18 __ LDA P11 ; (room2 + 0)
1971 : 85 16 __ STA P9 
1973 : 20 f1 16 JSR $16f1 ; (get_max_connection_distance.s0 + 0)
1976 : 85 46 __ STA T1 + 0 
1978 : 8d ec 9f STA $9fec ; (entropy1 + 1)
; 300, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
197b : 20 8d 19 JSR $198d ; (get_cached_room_distance.s0 + 0)
197e : a5 1b __ LDA ACCU + 0 
1980 : 8d eb 9f STA $9feb ; (i + 0)
; 301, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1983 : a5 46 __ LDA T1 + 0 
1985 : c5 1b __ CMP ACCU + 0 
1987 : a9 00 __ LDA #$00
1989 : 2a __ __ ROL
.s1001:
; 305, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
198a : 85 1b __ STA ACCU + 0 
198c : 60 __ __ RTS
--------------------------------------------------------------------
get_cached_room_distance: ; get_cached_room_distance(u8,u8)->u8
.s0:
;1259, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
198d : ad eb 40 LDA $40eb ; (distance_cache_valid + 0)
1990 : f0 0c __ BEQ $199e ; (get_cached_room_distance.s1006 + 0)
.s5:
1992 : a5 15 __ LDA P8 ; (room1 + 0)
1994 : c9 14 __ CMP #$14
1996 : b0 08 __ BCS $19a0 ; (get_cached_room_distance.s1 + 0)
.s4:
1998 : a5 16 __ LDA P9 ; (room2 + 0)
199a : c9 14 __ CMP #$14
199c : 90 0e __ BCC $19ac ; (get_cached_room_distance.s3 + 0)
.s1006:
;1260, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
199e : a5 15 __ LDA P8 ; (room1 + 0)
.s1:
19a0 : 85 13 __ STA P6 
19a2 : a5 16 __ LDA P9 ; (room2 + 0)
19a4 : 85 14 __ STA P7 
19a6 : 20 c6 0c JSR $0cc6 ; (calculate_room_distance.s0 + 0)
.s1001:
19a9 : 85 1b __ STA ACCU + 0 
19ab : 60 __ __ RTS
.s3:
;1263, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
19ac : a5 15 __ LDA P8 ; (room1 + 0)
19ae : 0a __ __ ASL
19af : 0a __ __ ASL
19b0 : 65 15 __ ADC P8 ; (room1 + 0)
19b2 : 0a __ __ ASL
19b3 : 0a __ __ ASL
19b4 : a2 00 __ LDX #$00
19b6 : 90 01 __ BCC $19b9 ; (get_cached_room_distance.s1003 + 0)
.s1002:
19b8 : e8 __ __ INX
.s1003:
19b9 : 18 __ __ CLC
19ba : 69 58 __ ADC #$58
19bc : 85 44 __ STA T0 + 0 
19be : 8a __ __ TXA
19bf : 69 4a __ ADC #$4a
19c1 : 85 45 __ STA T0 + 1 
19c3 : a4 16 __ LDY P9 ; (room2 + 0)
19c5 : b1 44 __ LDA (T0 + 0),y 
19c7 : 8d ed 9f STA $9fed ; (s + 1)
;1264, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
19ca : c9 ff __ CMP #$ff
19cc : d0 db __ BNE $19a9 ; (get_cached_room_distance.s1001 + 0)
.s9:
;1269, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
19ce : 84 14 __ STY P7 
19d0 : a5 15 __ LDA P8 ; (room1 + 0)
19d2 : 85 13 __ STA P6 
19d4 : 20 c6 0c JSR $0cc6 ; (calculate_room_distance.s0 + 0)
19d7 : 85 43 __ STA T3 + 0 
;1270, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
19d9 : a4 16 __ LDY P9 ; (room2 + 0)
19db : 91 44 __ STA (T0 + 0),y 
;1269, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
19dd : 8d ed 9f STA $9fed ; (s + 1)
;1271, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
19e0 : 98 __ __ TYA
19e1 : 0a __ __ ASL
19e2 : 0a __ __ ASL
19e3 : 65 16 __ ADC P9 ; (room2 + 0)
19e5 : 0a __ __ ASL
19e6 : 0a __ __ ASL
19e7 : a2 00 __ LDX #$00
19e9 : 90 01 __ BCC $19ec ; (get_cached_room_distance.s1005 + 0)
.s1004:
19eb : e8 __ __ INX
.s1005:
19ec : 18 __ __ CLC
19ed : 69 58 __ ADC #$58
19ef : 85 44 __ STA T0 + 0 
19f1 : 8a __ __ TXA
19f2 : 69 4a __ ADC #$4a
19f4 : 85 45 __ STA T0 + 1 
19f6 : a5 43 __ LDA T3 + 0 
19f8 : a4 15 __ LDY P8 ; (room1 + 0)
19fa : 91 44 __ STA (T0 + 0),y 
;1273, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
19fc : 4c a9 19 JMP $19a9 ; (get_cached_room_distance.s1001 + 0)
--------------------------------------------------------------------
is_room_reachable: ; is_room_reachable(u8,u8)->u8
.s0:
; 121, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
19ff : ad de 3f LDA $3fde ; (room_count + 0)
1a02 : c5 0d __ CMP P0 ; (room1 + 0)
1a04 : 90 10 __ BCC $1a16 ; (is_room_reachable.s1 + 0)
.s1006:
1a06 : f0 0e __ BEQ $1a16 ; (is_room_reachable.s1 + 0)
.s5:
1a08 : c5 0e __ CMP P1 ; (room2 + 0)
1a0a : 90 0a __ BCC $1a16 ; (is_room_reachable.s1 + 0)
.s1007:
1a0c : f0 08 __ BEQ $1a16 ; (is_room_reachable.s1 + 0)
.s4:
1a0e : 85 1d __ STA ACCU + 2 
1a10 : a5 0d __ LDA P0 ; (room1 + 0)
1a12 : c5 0e __ CMP P1 ; (room2 + 0)
1a14 : d0 03 __ BNE $1a19 ; (is_room_reachable.s3 + 0)
.s1:
; 122, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1a16 : a9 00 __ LDA #$00
.s1001:
1a18 : 60 __ __ RTS
.s3:
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1a19 : 0a __ __ ASL
1a1a : 0a __ __ ASL
1a1b : 65 0d __ ADC P0 ; (room1 + 0)
1a1d : 0a __ __ ASL
1a1e : 0a __ __ ASL
1a1f : a2 00 __ LDX #$00
1a21 : 90 01 __ BCC $1a24 ; (is_room_reachable.s1005 + 0)
.s1004:
1a23 : e8 __ __ INX
.s1005:
1a24 : 18 __ __ CLC
1a25 : 69 38 __ ADC #$38
1a27 : 85 1b __ STA ACCU + 0 
1a29 : 8a __ __ TXA
1a2a : 69 47 __ ADC #$47
1a2c : 85 1c __ STA ACCU + 1 
1a2e : a4 0e __ LDY P1 ; (room2 + 0)
1a30 : b1 1b __ LDA (ACCU + 0),y 
1a32 : f0 03 __ BEQ $1a37 ; (is_room_reachable.s9 + 0)
.s7:
1a34 : a9 01 __ LDA #$01
1a36 : 60 __ __ RTS
.s9:
; 136, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1a37 : 8d f1 9f STA $9ff1 ; (r1 + 1)
; 133, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1a3a : 8d f0 9f STA $9ff0 ; (r1 + 0)
.l12:
; 137, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1a3d : a9 00 __ LDA #$00
1a3f : ae f1 9f LDX $9ff1 ; (r1 + 1)
1a42 : 9d e8 4b STA $4be8,x ; (visited_global + 0)
; 136, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1a45 : ee f1 9f INC $9ff1 ; (r1 + 1)
1a48 : ad f1 9f LDA $9ff1 ; (r1 + 1)
1a4b : c5 1d __ CMP ACCU + 2 
1a4d : 90 ee __ BCC $1a3d ; (is_room_reachable.l12 + 0)
.s14:
; 141, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1a4f : a9 01 __ LDA #$01
1a51 : 8d f0 9f STA $9ff0 ; (r1 + 0)
1a54 : a6 0d __ LDX P0 ; (room1 + 0)
1a56 : 8e c8 4c STX $4cc8 ; (stack_global + 0)
; 142, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1a59 : 9d e8 4b STA $4be8,x ; (visited_global + 0)
.l16:
; 146, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1a5c : ce f0 9f DEC $9ff0 ; (r1 + 0)
1a5f : aa __ __ TAX
1a60 : bd c7 4c LDA $4cc7,x ; (room_center_cache + 39)
1a63 : 8d ef 9f STA $9fef ; (byte_ptr + 1)
; 149, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1a66 : 0a __ __ ASL
1a67 : 0a __ __ ASL
1a68 : 7d c7 4c ADC $4cc7,x ; (room_center_cache + 39)
1a6b : 0a __ __ ASL
1a6c : 0a __ __ ASL
1a6d : a8 __ __ TAY
1a6e : a9 00 __ LDA #$00
1a70 : 8d f1 9f STA $9ff1 ; (r1 + 1)
; 150, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1a73 : 2a __ __ ROL
1a74 : aa __ __ TAX
1a75 : 98 __ __ TYA
1a76 : 69 38 __ ADC #$38
1a78 : 85 1b __ STA ACCU + 0 
1a7a : 8a __ __ TXA
1a7b : 69 47 __ ADC #$47
1a7d : 85 1c __ STA ACCU + 1 
.l19:
1a7f : ad f1 9f LDA $9ff1 ; (r1 + 1)
1a82 : aa __ __ TAX
1a83 : a8 __ __ TAY
1a84 : b1 1b __ LDA (ACCU + 0),y 
1a86 : f0 1f __ BEQ $1aa7 ; (is_room_reachable.s18 + 0)
.s25:
1a88 : bd e8 4b LDA $4be8,x ; (visited_global + 0)
1a8b : d0 1a __ BNE $1aa7 ; (is_room_reachable.s18 + 0)
.s22:
; 152, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1a8d : e4 0e __ CPX P1 ; (room2 + 0)
1a8f : f0 a3 __ BEQ $1a34 ; (is_room_reachable.s7 + 0)
.s28:
; 157, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1a91 : a9 01 __ LDA #$01
1a93 : 9d e8 4b STA $4be8,x ; (visited_global + 0)
; 158, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1a96 : ad f0 9f LDA $9ff0 ; (r1 + 0)
1a99 : c9 14 __ CMP #$14
1a9b : b0 0a __ BCS $1aa7 ; (is_room_reachable.s18 + 0)
.s30:
; 159, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1a9d : a8 __ __ TAY
1a9e : 69 01 __ ADC #$01
1aa0 : 8d f0 9f STA $9ff0 ; (r1 + 0)
1aa3 : 8a __ __ TXA
1aa4 : 99 c8 4c STA $4cc8,y ; (stack_global + 0)
.s18:
; 149, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1aa7 : e8 __ __ INX
1aa8 : 8e f1 9f STX $9ff1 ; (r1 + 1)
1aab : e4 1d __ CPX ACCU + 2 
1aad : 90 d0 __ BCC $1a7f ; (is_room_reachable.l19 + 0)
.s15:
; 145, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1aaf : ad f0 9f LDA $9ff0 ; (r1 + 0)
1ab2 : d0 a8 __ BNE $1a5c ; (is_room_reachable.l16 + 0)
1ab4 : 4c 16 1a JMP $1a16 ; (is_room_reachable.s1 + 0)
--------------------------------------------------------------------
get_cached_room_distance_striped: ; get_cached_room_distance_striped(u8,u8)->u8
.s0:
;1292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1ab7 : a9 00 __ LDA #$00
1ab9 : 8d eb 9f STA $9feb ; (i + 0)
;1343, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1abc : a5 15 __ LDA P8 ; (room1 + 0)
1abe : 8d ea 9f STA $9fea ; (entropy2 + 1)
1ac1 : a5 16 __ LDA P9 ; (room2 + 0)
1ac3 : 8d e9 9f STA $9fe9 ; (connected + 1)
;1292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1ac6 : ad de 3f LDA $3fde ; (room_count + 0)
1ac9 : 85 44 __ STA T4 + 0 
1acb : ad ec 40 LDA $40ec ; (striped_cache_size + 0)
1ace : 85 45 __ STA T7 + 0 
1ad0 : d0 08 __ BNE $1ada ; (get_cached_room_distance_striped.s1002 + 0)
.s1003:
1ad2 : a9 00 __ LDA #$00
1ad4 : 85 46 __ STA T8 + 0 
.s9:
;1302, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1ad6 : a9 ff __ LDA #$ff
1ad8 : d0 3a __ BNE $1b14 ; (get_cached_room_distance_striped.s1 + 0)
.s1002:
;1292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1ada : a9 01 __ LDA #$01
1adc : 85 46 __ STA T8 + 0 
.l7:
;1293, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1ade : ac eb 9f LDY $9feb ; (i + 0)
1ae1 : b9 c0 4d LDA $4dc0,y ; (connection_distance_cache_striped.valid + 0)
1ae4 : f0 1f __ BEQ $1b05 ; (get_cached_room_distance_striped.s8 + 0)
.s13:
;1294, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1ae6 : a5 15 __ LDA P8 ; (room1 + 0)
1ae8 : d9 00 4d CMP $4d00,y ; (connection_distance_cache_striped.room1 + 0)
1aeb : f0 05 __ BEQ $1af2 ; (get_cached_room_distance_striped.s15 + 0)
.s1012:
;1296, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1aed : a5 16 __ LDA P9 ; (room2 + 0)
1aef : 4c f9 1a JMP $1af9 ; (get_cached_room_distance_striped.s14 + 0)
.s15:
;1295, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1af2 : a5 16 __ LDA P9 ; (room2 + 0)
1af4 : d9 40 4d CMP $4d40,y ; (connection_distance_cache_striped.room2 + 0)
1af7 : f0 18 __ BEQ $1b11 ; (get_cached_room_distance_striped.s10 + 0)
.s14:
;1296, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1af9 : d9 00 4d CMP $4d00,y ; (connection_distance_cache_striped.room1 + 0)
1afc : d0 07 __ BNE $1b05 ; (get_cached_room_distance_striped.s8 + 0)
.s16:
;1297, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1afe : a5 15 __ LDA P8 ; (room1 + 0)
1b00 : d9 40 4d CMP $4d40,y ; (connection_distance_cache_striped.room2 + 0)
1b03 : f0 0c __ BEQ $1b11 ; (get_cached_room_distance_striped.s10 + 0)
.s8:
;1292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1b05 : ee eb 9f INC $9feb ; (i + 0)
1b08 : ad eb 9f LDA $9feb ; (i + 0)
1b0b : c5 45 __ CMP T7 + 0 
1b0d : 90 cf __ BCC $1ade ; (get_cached_room_distance_striped.l7 + 0)
1b0f : b0 c5 __ BCS $1ad6 ; (get_cached_room_distance_striped.s9 + 0)
.s10:
;1298, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1b11 : b9 80 4d LDA $4d80,y ; (connection_distance_cache_striped.distance + 0)
.s1:
1b14 : 8d e8 9f STA $9fe8 ; (entropy3 + 1)
;1343, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1b17 : 85 1b __ STA ACCU + 0 
1b19 : 8d ed 9f STA $9fed ; (s + 1)
;1344, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1b1c : c9 ff __ CMP #$ff
1b1e : f0 01 __ BEQ $1b21 ; (get_cached_room_distance_striped.s21 + 0)
1b20 : 60 __ __ RTS
.s21:
;1349, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1b21 : a5 15 __ LDA P8 ; (room1 + 0)
1b23 : 85 13 __ STA P6 
1b25 : a5 16 __ LDA P9 ; (room2 + 0)
1b27 : 85 14 __ STA P7 
1b29 : 20 c6 0c JSR $0cc6 ; (calculate_room_distance.s0 + 0)
1b2c : 85 1b __ STA ACCU + 0 
;1350, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1b2e : 8d e4 9f STA $9fe4 ; (random_offset_x + 0)
;1349, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1b31 : 8d ec 9f STA $9fec ; (entropy1 + 1)
1b34 : aa __ __ TAX
;1350, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1b35 : a5 15 __ LDA P8 ; (room1 + 0)
1b37 : 8d e6 9f STA $9fe6 ; (screen_pos + 1)
1b3a : a5 16 __ LDA P9 ; (room2 + 0)
1b3c : 8d e5 9f STA $9fe5 ; (leg1_end_x + 0)
;1308, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1b3f : a5 45 __ LDA T7 + 0 
1b41 : c9 40 __ CMP #$40
1b43 : b0 75 __ BCS $1bba ; (get_cached_room_distance_striped.s1001 + 0)
.s28:
1b45 : a5 13 __ LDA P6 
1b47 : c5 44 __ CMP T4 + 0 
1b49 : b0 6f __ BCS $1bba ; (get_cached_room_distance_striped.s1001 + 0)
.s27:
1b4b : a5 14 __ LDA P7 
1b4d : c5 44 __ CMP T4 + 0 
1b4f : b0 69 __ BCS $1bba ; (get_cached_room_distance_striped.s1001 + 0)
.s26:
;1292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1b51 : a9 00 __ LDA #$00
1b53 : 8d e3 9f STA $9fe3 ; (screen_offset + 1)
;1313, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1b56 : a5 15 __ LDA P8 ; (room1 + 0)
1b58 : 8d e2 9f STA $9fe2 ; (best_distance + 0)
1b5b : a5 16 __ LDA P9 ; (room2 + 0)
1b5d : 8d e1 9f STA $9fe1 ; (r1 + 0)
;1292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1b60 : a5 46 __ LDA T8 + 0 
1b62 : f0 31 __ BEQ $1b95 ; (get_cached_room_distance_striped.s41 + 0)
.l39:
;1293, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1b64 : ac e3 9f LDY $9fe3 ; (screen_offset + 1)
1b67 : b9 c0 4d LDA $4dc0,y ; (connection_distance_cache_striped.valid + 0)
1b6a : f0 1f __ BEQ $1b8b ; (get_cached_room_distance_striped.s40 + 0)
.s45:
;1294, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1b6c : a5 15 __ LDA P8 ; (room1 + 0)
1b6e : d9 00 4d CMP $4d00,y ; (connection_distance_cache_striped.room1 + 0)
1b71 : f0 05 __ BEQ $1b78 ; (get_cached_room_distance_striped.s47 + 0)
.s1011:
;1296, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1b73 : a5 16 __ LDA P9 ; (room2 + 0)
1b75 : 4c 7f 1b JMP $1b7f ; (get_cached_room_distance_striped.s46 + 0)
.s47:
;1295, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1b78 : a5 16 __ LDA P9 ; (room2 + 0)
1b7a : d9 40 4d CMP $4d40,y ; (connection_distance_cache_striped.room2 + 0)
1b7d : f0 3c __ BEQ $1bbb ; (get_cached_room_distance_striped.s42 + 0)
.s46:
;1296, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1b7f : d9 00 4d CMP $4d00,y ; (connection_distance_cache_striped.room1 + 0)
1b82 : d0 07 __ BNE $1b8b ; (get_cached_room_distance_striped.s40 + 0)
.s48:
;1297, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1b84 : a5 15 __ LDA P8 ; (room1 + 0)
1b86 : d9 40 4d CMP $4d40,y ; (connection_distance_cache_striped.room2 + 0)
1b89 : f0 30 __ BEQ $1bbb ; (get_cached_room_distance_striped.s42 + 0)
.s40:
;1292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1b8b : ee e3 9f INC $9fe3 ; (screen_offset + 1)
1b8e : ad e3 9f LDA $9fe3 ; (screen_offset + 1)
1b91 : c5 45 __ CMP T7 + 0 
1b93 : 90 cf __ BCC $1b64 ; (get_cached_room_distance_striped.l39 + 0)
.s41:
;1302, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1b95 : a9 ff __ LDA #$ff
1b97 : 8d e0 9f STA $9fe0 ; (y + 0)
.s32:
;1317, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1b9a : a5 45 __ LDA T7 + 0 
1b9c : 8d e7 9f STA $9fe7 ; (idx + 0)
1b9f : 18 __ __ CLC
1ba0 : 69 01 __ ADC #$01
1ba2 : 8d ec 40 STA $40ec ; (striped_cache_size + 0)
;1319, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1ba5 : a5 15 __ LDA P8 ; (room1 + 0)
1ba7 : a4 45 __ LDY T7 + 0 
1ba9 : 99 00 4d STA $4d00,y ; (connection_distance_cache_striped.room1 + 0)
;1320, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1bac : a5 16 __ LDA P9 ; (room2 + 0)
1bae : 99 40 4d STA $4d40,y ; (connection_distance_cache_striped.room2 + 0)
;1321, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1bb1 : 8a __ __ TXA
1bb2 : 99 80 4d STA $4d80,y ; (connection_distance_cache_striped.distance + 0)
;1322, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1bb5 : a9 01 __ LDA #$01
1bb7 : 99 c0 4d STA $4dc0,y ; (connection_distance_cache_striped.valid + 0)
.s1001:
;1351, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1bba : 60 __ __ RTS
.s42:
;1298, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1bbb : b9 80 4d LDA $4d80,y ; (connection_distance_cache_striped.distance + 0)
1bbe : 8d e0 9f STA $9fe0 ; (y + 0)
;1313, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
1bc1 : c9 ff __ CMP #$ff
1bc3 : f0 d5 __ BEQ $1b9a ; (get_cached_room_distance_striped.s32 + 0)
1bc5 : 60 __ __ RTS
--------------------------------------------------------------------
connect_rooms_directly: ; connect_rooms_directly(u8,u8)->u8
.s1000:
1bc6 : a2 05 __ LDX #$05
1bc8 : b5 53 __ LDA T0 + 0,x 
1bca : 9d 91 9f STA $9f91,x ; (connect_rooms_directly@stack + 0)
1bcd : ca __ __ DEX
1bce : 10 f8 __ BPL $1bc8 ; (connect_rooms_directly.s1000 + 2)
.s0:
;1138, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1bd0 : ad fe 9f LDA $9ffe ; (sstack + 12)
1bd3 : 85 57 __ STA T6 + 0 
1bd5 : 85 17 __ STA P10 
1bd7 : ad ff 9f LDA $9fff ; (sstack + 13)
1bda : 85 58 __ STA T7 + 0 
1bdc : 85 18 __ STA P11 
1bde : 20 55 19 JSR $1955 ; (can_connect_rooms_safely.s0 + 0)
1be1 : a5 1b __ LDA ACCU + 0 
1be3 : d0 03 __ BNE $1be8 ; (connect_rooms_directly.s3 + 0)
1be5 : 4c 99 1c JMP $1c99 ; (connect_rooms_directly.s1001 + 0)
.s3:
;1142, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1be8 : a5 57 __ LDA T6 + 0 
1bea : 0a __ __ ASL
1beb : 0a __ __ ASL
1bec : 65 57 __ ADC T6 + 0 
1bee : 0a __ __ ASL
1bef : 0a __ __ ASL
1bf0 : 85 53 __ STA T0 + 0 
1bf2 : a9 00 __ LDA #$00
1bf4 : 2a __ __ ROL
1bf5 : 85 54 __ STA T0 + 1 
1bf7 : a9 38 __ LDA #$38
1bf9 : 65 53 __ ADC T0 + 0 
1bfb : 85 43 __ STA T1 + 0 
1bfd : a9 47 __ LDA #$47
1bff : 65 54 __ ADC T0 + 1 
1c01 : 85 44 __ STA T1 + 1 
1c03 : a4 58 __ LDY T7 + 0 
1c05 : b1 43 __ LDA (T1 + 0),y 
1c07 : f0 03 __ BEQ $1c0c ; (connect_rooms_directly.s7 + 0)
1c09 : 4c 8e 1c JMP $1c8e ; (connect_rooms_directly.s5 + 0)
.s7:
;1146, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1c0c : 18 __ __ CLC
1c0d : a9 c8 __ LDA #$c8
1c0f : 65 53 __ ADC T0 + 0 
1c11 : 85 53 __ STA T0 + 0 
1c13 : a9 48 __ LDA #$48
1c15 : 65 54 __ ADC T0 + 1 
1c17 : 85 54 __ STA T0 + 1 
1c19 : b1 53 __ LDA (T0 + 0),y 
1c1b : d0 71 __ BNE $1c8e ; (connect_rooms_directly.s5 + 0)
.s11:
;1150, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1c1d : 84 0e __ STY P1 
1c1f : 18 __ __ CLC
1c20 : a5 43 __ LDA T1 + 0 
1c22 : 65 58 __ ADC T7 + 0 
1c24 : 85 55 __ STA T4 + 0 
1c26 : a5 44 __ LDA T1 + 1 
1c28 : 69 00 __ ADC #$00
1c2a : 85 56 __ STA T4 + 1 
1c2c : a5 57 __ LDA T6 + 0 
1c2e : 85 0d __ STA P0 
1c30 : 20 ff 19 JSR $19ff ; (is_room_reachable.s0 + 0)
1c33 : 85 45 __ STA T5 + 0 
;1154, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1c35 : a9 01 __ LDA #$01
1c37 : a4 58 __ LDY T7 + 0 
1c39 : 91 53 __ STA (T0 + 0),y 
;1152, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1c3b : 91 43 __ STA (T1 + 0),y 
;1155, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1c3d : 98 __ __ TYA
1c3e : 0a __ __ ASL
1c3f : 0a __ __ ASL
1c40 : 65 58 __ ADC T7 + 0 
1c42 : 0a __ __ ASL
1c43 : 0a __ __ ASL
1c44 : 85 53 __ STA T0 + 0 
1c46 : a9 00 __ LDA #$00
1c48 : 2a __ __ ROL
1c49 : 85 54 __ STA T0 + 1 
1c4b : a9 c8 __ LDA #$c8
1c4d : 65 53 __ ADC T0 + 0 
1c4f : 85 43 __ STA T1 + 0 
1c51 : a9 48 __ LDA #$48
1c53 : 65 54 __ ADC T0 + 1 
1c55 : 85 44 __ STA T1 + 1 
1c57 : a9 01 __ LDA #$01
1c59 : a4 0d __ LDY P0 
1c5b : 91 43 __ STA (T1 + 0),y 
;1153, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1c5d : 18 __ __ CLC
1c5e : a9 38 __ LDA #$38
1c60 : 65 53 __ ADC T0 + 0 
1c62 : aa __ __ TAX
1c63 : a9 47 __ LDA #$47
1c65 : 65 54 __ ADC T0 + 1 
1c67 : a8 __ __ TAY
1c68 : 8a __ __ TXA
1c69 : 18 __ __ CLC
1c6a : 65 0d __ ADC P0 
1c6c : 85 53 __ STA T0 + 0 
1c6e : 90 01 __ BCC $1c71 ; (connect_rooms_directly.s1003 + 0)
.s1002:
1c70 : c8 __ __ INY
.s1003:
1c71 : 84 54 __ STY T0 + 1 
1c73 : a9 01 __ LDA #$01
1c75 : a0 00 __ LDY #$00
1c77 : 91 53 __ STA (T0 + 0),y 
;1150, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1c79 : a5 45 __ LDA T5 + 0 
1c7b : d0 11 __ BNE $1c8e ; (connect_rooms_directly.s5 + 0)
.s15:
;1164, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1c7d : a5 0d __ LDA P0 
1c7f : 8d fc 9f STA $9ffc ; (sstack + 10)
1c82 : a5 58 __ LDA T7 + 0 
1c84 : 8d fd 9f STA $9ffd ; (sstack + 11)
1c87 : 20 a4 1c JSR $1ca4 ; (draw_corridor.s1000 + 0)
1c8a : a5 1b __ LDA ACCU + 0 
1c8c : f0 06 __ BEQ $1c94 ; (connect_rooms_directly.s19 + 0)
.s5:
;1143, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1c8e : a9 01 __ LDA #$01
1c90 : 85 1b __ STA ACCU + 0 
1c92 : d0 05 __ BNE $1c99 ; (connect_rooms_directly.s1001 + 0)
.s19:
;1168, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1c94 : a8 __ __ TAY
1c95 : 91 55 __ STA (T4 + 0),y 
;1169, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1c97 : 91 53 __ STA (T0 + 0),y 
.s1001:
1c99 : a2 05 __ LDX #$05
1c9b : bd 91 9f LDA $9f91,x ; (connect_rooms_directly@stack + 0)
1c9e : 95 53 __ STA T0 + 0,x 
1ca0 : ca __ __ DEX
1ca1 : 10 f8 __ BPL $1c9b ; (connect_rooms_directly.s1001 + 2)
;1139, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1ca3 : 60 __ __ RTS
--------------------------------------------------------------------
draw_corridor: ; draw_corridor(u8,u8)->u8
.s1000:
1ca4 : a2 0b __ LDX #$0b
1ca6 : b5 53 __ LDA T0 + 0,x 
1ca8 : 9d 9b 9f STA $9f9b,x ; (draw_corridor@stack + 0)
1cab : ca __ __ DEX
1cac : 10 f8 __ BPL $1ca6 ; (draw_corridor.s1000 + 2)
.s0:
;1455, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1cae : ad fc 9f LDA $9ffc ; (sstack + 10)
1cb1 : 85 5b __ STA T6 + 0 
1cb3 : 85 0e __ STA P1 
1cb5 : a9 be __ LDA #$be
1cb7 : 85 0f __ STA P2 
1cb9 : a9 9f __ LDA #$9f
1cbb : 85 12 __ STA P5 
1cbd : a9 9f __ LDA #$9f
1cbf : 85 10 __ STA P3 
1cc1 : a9 bd __ LDA #$bd
1cc3 : 85 11 __ STA P4 
1cc5 : 20 0b 0d JSR $0d0b ; (get_room_center.s0 + 0)
;1456, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1cc8 : ad fd 9f LDA $9ffd ; (sstack + 11)
1ccb : 85 0e __ STA P1 
1ccd : 85 5c __ STA T7 + 0 
1ccf : 0a __ __ ASL
1cd0 : 0a __ __ ASL
1cd1 : 0a __ __ ASL
1cd2 : 85 57 __ STA T3 + 0 
1cd4 : a9 bc __ LDA #$bc
1cd6 : 85 0f __ STA P2 
1cd8 : a9 9f __ LDA #$9f
1cda : 85 12 __ STA P5 
1cdc : a9 9f __ LDA #$9f
1cde : 85 10 __ STA P3 
1ce0 : a9 bb __ LDA #$bb
1ce2 : 85 11 __ STA P4 
1ce4 : 20 0b 0d JSR $0d0b ; (get_room_center.s0 + 0)
;1459, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1ce7 : a5 5b __ LDA T6 + 0 
1ce9 : 0a __ __ ASL
1cea : 0a __ __ ASL
1ceb : 0a __ __ ASL
1cec : 18 __ __ CLC
1ced : 69 00 __ ADC #$00
1cef : 85 55 __ STA T2 + 0 
1cf1 : 8d f2 9f STA $9ff2 ; (sstack + 0)
1cf4 : a9 4c __ LDA #$4c
1cf6 : 69 00 __ ADC #$00
1cf8 : 85 56 __ STA T2 + 1 
1cfa : 8d f3 9f STA $9ff3 ; (sstack + 1)
1cfd : ad bc 9f LDA $9fbc ; (room2_center_x + 0)
1d00 : 8d f4 9f STA $9ff4 ; (sstack + 2)
1d03 : ad bb 9f LDA $9fbb ; (room2_center_y + 0)
1d06 : 8d f5 9f STA $9ff5 ; (sstack + 3)
1d09 : a9 c5 __ LDA #$c5
1d0b : 8d f6 9f STA $9ff6 ; (sstack + 4)
1d0e : a9 9f __ LDA #$9f
1d10 : 8d f7 9f STA $9ff7 ; (sstack + 5)
1d13 : 20 26 20 JSR $2026 ; (calculate_exit_points.s1000 + 0)
;1460, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1d16 : 18 __ __ CLC
1d17 : a9 00 __ LDA #$00
1d19 : 65 57 __ ADC T3 + 0 
1d1b : 85 58 __ STA T4 + 0 
1d1d : 8d f2 9f STA $9ff2 ; (sstack + 0)
1d20 : a9 4c __ LDA #$4c
1d22 : 69 00 __ ADC #$00
1d24 : 85 59 __ STA T4 + 1 
1d26 : 8d f3 9f STA $9ff3 ; (sstack + 1)
1d29 : ad be 9f LDA $9fbe ; (create_rooms@stack + 0)
1d2c : 8d f4 9f STA $9ff4 ; (sstack + 2)
1d2f : ad bd 9f LDA $9fbd ; (room1_center_y + 0)
1d32 : 8d f5 9f STA $9ff5 ; (sstack + 3)
1d35 : a9 bf __ LDA #$bf
1d37 : 8d f6 9f STA $9ff6 ; (sstack + 4)
1d3a : a9 9f __ LDA #$9f
1d3c : 8d f7 9f STA $9ff7 ; (sstack + 5)
1d3f : 20 26 20 JSR $2026 ; (calculate_exit_points.s1000 + 0)
;1463, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1d42 : a5 5b __ LDA T6 + 0 
1d44 : 85 0d __ STA P0 
1d46 : a5 5c __ LDA T7 + 0 
1d48 : 85 0e __ STA P1 
1d4a : a9 00 __ LDA #$00
1d4c : 8d a8 52 STA $52a8 ; (corridor_path_static + 40)
;1467, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1d4f : a9 ba __ LDA #$ba
1d51 : 85 0f __ STA P2 
1d53 : a9 9f __ LDA #$9f
1d55 : 85 12 __ STA P5 
1d57 : a9 9f __ LDA #$9f
1d59 : 85 10 __ STA P3 
1d5b : a9 b9 __ LDA #$b9
1d5d : 85 11 __ STA P4 
1d5f : 20 60 25 JSR $2560 ; (check_room_axis_alignment.s0 + 0)
;1473, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1d62 : ad ba 9f LDA $9fba ; (has_horizontal_overlap + 0)
1d65 : f0 03 __ BEQ $1d6a ; (draw_corridor.s4 + 0)
1d67 : 4c ab 1f JMP $1fab ; (draw_corridor.s1 + 0)
.s4:
1d6a : ad b9 9f LDA $9fb9 ; (has_vertical_overlap + 0)
1d6d : d0 f8 __ BNE $1d67 ; (draw_corridor.s0 + 185)
.s2:
;1516, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1d6f : ad dc 3f LDA $3fdc ; (rng_seed + 0)
1d72 : 85 1b __ STA ACCU + 0 
1d74 : ad dd 3f LDA $3fdd ; (rng_seed + 1)
1d77 : 85 1c __ STA ACCU + 1 
1d79 : a9 64 __ LDA #$64
1d7b : 85 03 __ STA WORK + 0 
1d7d : a9 00 __ LDA #$00
1d7f : 85 04 __ STA WORK + 1 
1d81 : 20 38 3f JSR $3f38 ; (divmod + 0)
1d84 : a5 05 __ LDA WORK + 2 
1d86 : c9 32 __ CMP #$32
1d88 : a9 00 __ LDA #$00
1d8a : 2a __ __ ROL
1d8b : 49 01 __ EOR #$01
1d8d : 8d b6 9f STA $9fb6 ; (use_l_shaped + 0)
1d90 : f0 03 __ BEQ $1d95 ; (draw_corridor.s24 + 0)
1d92 : 4c 17 1e JMP $1e17 ; (draw_corridor.s22 + 0)
.s24:
;1565, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1d95 : ad c3 9f LDA $9fc3 ; (create_rooms@stack + 5)
1d98 : 85 0e __ STA P1 
1d9a : ad c9 9f LDA $9fc9 ; (exit1 + 4)
1d9d : 20 2d 2a JSR $2a2d ; (get_optimal_corridor_direction.s0 + 0)
1da0 : 8d aa 9f STA $9faa ; (start_with_x + 0)
.s66:
;1568, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1da3 : 85 54 __ STA T1 + 0 
1da5 : 85 11 __ STA P4 
1da7 : a5 5b __ LDA T6 + 0 
1da9 : 85 12 __ STA P5 
1dab : a5 5c __ LDA T7 + 0 
1dad : 85 13 __ STA P6 
1daf : ad c7 9f LDA $9fc7 ; (exit1 + 2)
1db2 : 85 55 __ STA T2 + 0 
1db4 : 85 0d __ STA P0 
1db6 : ad c8 9f LDA $9fc8 ; (exit1 + 3)
1db9 : 85 57 __ STA T3 + 0 
1dbb : 85 0e __ STA P1 
1dbd : ad c1 9f LDA $9fc1 ; (create_rooms@stack + 3)
1dc0 : 85 58 __ STA T4 + 0 
1dc2 : 85 0f __ STA P2 
1dc4 : ad c2 9f LDA $9fc2 ; (create_rooms@stack + 4)
1dc7 : 85 5a __ STA T5 + 0 
1dc9 : 85 10 __ STA P3 
1dcb : 20 3b 2a JSR $2a3b ; (z_path_avoids_rooms.s0 + 0)
1dce : a5 1b __ LDA ACCU + 0 
;1499, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1dd0 : f0 3a __ BEQ $1e0c ; (draw_corridor.s1001 + 0)
.s15:
;1502, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1dd2 : a5 55 __ LDA T2 + 0 
1dd4 : 8d f5 9f STA $9ff5 ; (sstack + 3)
1dd7 : a5 57 __ LDA T3 + 0 
1dd9 : 8d f6 9f STA $9ff6 ; (sstack + 4)
1ddc : a5 58 __ LDA T4 + 0 
1dde : 8d f7 9f STA $9ff7 ; (sstack + 5)
1de1 : a5 5a __ LDA T5 + 0 
1de3 : 8d f8 9f STA $9ff8 ; (sstack + 6)
1de6 : a5 54 __ LDA T1 + 0 
1de8 : 8d f9 9f STA $9ff9 ; (sstack + 7)
;1571, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1deb : 20 32 2b JSR $2b32 ; (draw_z_corridor.s0 + 0)
1dee : a5 1b __ LDA ACCU + 0 
;1502, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1df0 : f0 1a __ BEQ $1e0c ; (draw_corridor.s1001 + 0)
.s18:
;1505, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1df2 : a5 55 __ LDA T2 + 0 
1df4 : 85 13 __ STA P6 
1df6 : a5 57 __ LDA T3 + 0 
1df8 : 85 14 __ STA P7 
1dfa : 20 0e 2a JSR $2a0e ; (place_door.s0 + 0)
;1506, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1dfd : a5 5a __ LDA T5 + 0 
1dff : a6 58 __ LDX T4 + 0 
.s1010:
1e01 : 86 13 __ STX P6 
1e03 : 85 14 __ STA P7 
1e05 : 20 0e 2a JSR $2a0e ; (place_door.s0 + 0)
;1507, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1e08 : a9 01 __ LDA #$01
1e0a : 85 1b __ STA ACCU + 0 
.s1001:
1e0c : a2 0b __ LDX #$0b
1e0e : bd 9b 9f LDA $9f9b,x ; (draw_corridor@stack + 0)
1e11 : 95 53 __ STA T0 + 0,x 
1e13 : ca __ __ DEX
1e14 : 10 f8 __ BPL $1e0e ; (draw_corridor.s1001 + 2)
;1581, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1e16 : 60 __ __ RTS
.s22:
;1521, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1e17 : a5 0d __ LDA P0 
1e19 : 8d f2 9f STA $9ff2 ; (sstack + 0)
1e1c : a5 0e __ LDA P1 
1e1e : 8d f3 9f STA $9ff3 ; (sstack + 1)
1e21 : a9 b5 __ LDA #$b5
1e23 : 8d f4 9f STA $9ff4 ; (sstack + 2)
1e26 : a9 9f __ LDA #$9f
1e28 : 8d f5 9f STA $9ff5 ; (sstack + 3)
1e2b : a9 b4 __ LDA #$b4
1e2d : 8d f6 9f STA $9ff6 ; (sstack + 4)
1e30 : a9 9f __ LDA #$9f
1e32 : 8d f7 9f STA $9ff7 ; (sstack + 5)
1e35 : a9 b3 __ LDA #$b3
1e37 : 8d f8 9f STA $9ff8 ; (sstack + 6)
1e3a : a9 9f __ LDA #$9f
1e3c : 8d f9 9f STA $9ff9 ; (sstack + 7)
1e3f : a9 b2 __ LDA #$b2
1e41 : 8d fa 9f STA $9ffa ; (sstack + 8)
1e44 : a9 9f __ LDA #$9f
1e46 : 8d fb 9f STA $9ffb ; (sstack + 9)
1e49 : 20 19 2e JSR $2e19 ; (find_l_corridor_exits.s1000 + 0)
;1524, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1e4c : a5 55 __ LDA T2 + 0 
1e4e : 85 0d __ STA P0 
1e50 : a5 56 __ LDA T2 + 1 
1e52 : 85 0e __ STA P1 
1e54 : ad b5 9f LDA $9fb5 ; (l_exit1_x + 0)
1e57 : 85 0f __ STA P2 
1e59 : 8d b1 9f STA $9fb1 ; (door1_x + 0)
1e5c : ad b4 9f LDA $9fb4 ; (l_exit1_y + 0)
1e5f : 85 10 __ STA P3 
1e61 : 8d b0 9f STA $9fb0 ; (door1_y + 0)
;1525, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1e64 : ad b3 9f LDA $9fb3 ; (l_exit2_x + 0)
1e67 : 85 53 __ STA T0 + 0 
1e69 : 8d af 9f STA $9faf ; (door2_x + 0)
1e6c : ad b2 9f LDA $9fb2 ; (l_exit2_y + 0)
1e6f : 85 54 __ STA T1 + 0 
1e71 : 8d ae 9f STA $9fae ; (door2_y + 0)
;1528, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1e74 : 20 fe 30 JSR $30fe ; (get_exit_side.s0 + 0)
1e77 : 85 5d __ STA T8 + 0 
1e79 : 8d ad 9f STA $9fad ; (exit1_side + 0)
;1529, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1e7c : a5 58 __ LDA T4 + 0 
1e7e : 85 0d __ STA P0 
1e80 : a5 59 __ LDA T4 + 1 
1e82 : 85 0e __ STA P1 
1e84 : a5 53 __ LDA T0 + 0 
1e86 : 85 0f __ STA P2 
1e88 : a5 54 __ LDA T1 + 0 
1e8a : 85 10 __ STA P3 
1e8c : 20 fe 30 JSR $30fe ; (get_exit_side.s0 + 0)
1e8f : 85 5e __ STA T9 + 0 
1e91 : 8d ac 9f STA $9fac ; (exit2_side + 0)
;1532, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1e94 : a5 5d __ LDA T8 + 0 
1e96 : c9 02 __ CMP #$02
1e98 : d0 10 __ BNE $1eaa ; (draw_corridor.s31 + 0)
.s28:
;1535, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1e9a : a0 01 __ LDY #$01
1e9c : b1 55 __ LDA (T2 + 0),y 
1e9e : aa __ __ TAX
1e9f : a9 02 __ LDA #$02
1ea1 : ca __ __ DEX
.s83:
;1536, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1ea2 : 8e b0 9f STX $9fb0 ; (door1_y + 0)
;1532, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1ea5 : 85 5d __ STA T8 + 0 
1ea7 : 4c c0 1e JMP $1ec0 ; (draw_corridor.s25 + 0)
.s31:
;1532, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1eaa : b0 03 __ BCS $1eaf ; (draw_corridor.s32 + 0)
1eac : 4c 8f 1f JMP $1f8f ; (draw_corridor.s33 + 0)
.s32:
1eaf : c9 03 __ CMP #$03
1eb1 : d0 0d __ BNE $1ec0 ; (draw_corridor.s25 + 0)
.s29:
1eb3 : a0 01 __ LDY #$01
1eb5 : b1 55 __ LDA (T2 + 0),y 
1eb7 : 18 __ __ CLC
1eb8 : a0 03 __ LDY #$03
1eba : 71 55 __ ADC (T2 + 0),y 
1ebc : aa __ __ TAX
1ebd : 98 __ __ TYA
1ebe : d0 e2 __ BNE $1ea2 ; (draw_corridor.s83 + 0)
.s25:
;1539, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1ec0 : a5 5e __ LDA T9 + 0 
1ec2 : c9 02 __ CMP #$02
1ec4 : d0 0c __ BNE $1ed2 ; (draw_corridor.s42 + 0)
.s39:
;1543, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1ec6 : a6 57 __ LDX T3 + 0 
1ec8 : bc 01 4c LDY $4c01,x ; (rooms + 1)
1ecb : 88 __ __ DEY
1ecc : 8c ae 9f STY $9fae ; (door2_y + 0)
1ecf : 4c e7 1e JMP $1ee7 ; (draw_corridor.s36 + 0)
.s42:
;1539, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1ed2 : b0 03 __ BCS $1ed7 ; (draw_corridor.s43 + 0)
1ed4 : 4c 71 1f JMP $1f71 ; (draw_corridor.s44 + 0)
.s43:
1ed7 : c9 03 __ CMP #$03
1ed9 : d0 0c __ BNE $1ee7 ; (draw_corridor.s36 + 0)
.s40:
;1543, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1edb : a0 01 __ LDY #$01
1edd : b1 0d __ LDA (P0),y 
1edf : 18 __ __ CLC
1ee0 : a0 03 __ LDY #$03
1ee2 : 71 0d __ ADC (P0),y 
1ee4 : 8d ae 9f STA $9fae ; (door2_y + 0)
.s36:
;1547, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1ee7 : a5 5b __ LDA T6 + 0 
1ee9 : 85 11 __ STA P4 
1eeb : a5 5c __ LDA T7 + 0 
1eed : 85 12 __ STA P5 
1eef : ad b1 9f LDA $9fb1 ; (door1_x + 0)
1ef2 : 85 54 __ STA T1 + 0 
1ef4 : 85 0d __ STA P0 
1ef6 : a9 01 __ LDA #$01
1ef8 : 85 13 __ STA P6 
1efa : ad b0 9f LDA $9fb0 ; (door1_y + 0)
1efd : 85 55 __ STA T2 + 0 
1eff : 85 0e __ STA P1 
1f01 : ad af 9f LDA $9faf ; (door2_x + 0)
1f04 : 85 57 __ STA T3 + 0 
1f06 : 85 0f __ STA P2 
1f08 : ad ae 9f LDA $9fae ; (door2_y + 0)
1f0b : 85 58 __ STA T4 + 0 
1f0d : 85 10 __ STA P3 
1f0f : 20 5f 31 JSR $315f ; (l_path_avoids_rooms.s0 + 0)
1f12 : a5 1b __ LDA ACCU + 0 
1f14 : d0 23 __ BNE $1f39 ; (draw_corridor.s47 + 0)
.s50:
;1550, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1f16 : a5 54 __ LDA T1 + 0 
1f18 : 85 0d __ STA P0 
1f1a : a5 55 __ LDA T2 + 0 
1f1c : 85 0e __ STA P1 
1f1e : a5 57 __ LDA T3 + 0 
1f20 : 85 0f __ STA P2 
1f22 : a5 58 __ LDA T4 + 0 
1f24 : 85 10 __ STA P3 
1f26 : a5 5b __ LDA T6 + 0 
1f28 : 85 11 __ STA P4 
1f2a : c6 13 __ DEC P6 
1f2c : 20 5f 31 JSR $315f ; (l_path_avoids_rooms.s0 + 0)
1f2f : a5 1b __ LDA ACCU + 0 
1f31 : d0 06 __ BNE $1f39 ; (draw_corridor.s47 + 0)
.s48:
;1549, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1f33 : 8d ab 9f STA $9fab ; (l_path_clear + 0)
1f36 : 4c 95 1d JMP $1d95 ; (draw_corridor.s24 + 0)
.s47:
;1556, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1f39 : a5 54 __ LDA T1 + 0 
1f3b : 8d f5 9f STA $9ff5 ; (sstack + 3)
1f3e : a5 55 __ LDA T2 + 0 
1f40 : 8d f6 9f STA $9ff6 ; (sstack + 4)
1f43 : a5 57 __ LDA T3 + 0 
1f45 : 8d f7 9f STA $9ff7 ; (sstack + 5)
1f48 : a5 58 __ LDA T4 + 0 
1f4a : 8d f8 9f STA $9ff8 ; (sstack + 6)
1f4d : a5 5d __ LDA T8 + 0 
1f4f : 8d f9 9f STA $9ff9 ; (sstack + 7)
1f52 : a5 5e __ LDA T9 + 0 
1f54 : 8d fa 9f STA $9ffa ; (sstack + 8)
;1549, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1f57 : a9 01 __ LDA #$01
1f59 : 8d ab 9f STA $9fab ; (l_path_clear + 0)
;1556, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1f5c : 20 9e 31 JSR $319e ; (draw_l_corridor.s0 + 0)
.s1011:
;1488, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1f5f : a5 54 __ LDA T1 + 0 
1f61 : 85 13 __ STA P6 
1f63 : a5 55 __ LDA T2 + 0 
1f65 : 85 14 __ STA P7 
1f67 : 20 0e 2a JSR $2a0e ; (place_door.s0 + 0)
;1489, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1f6a : a5 58 __ LDA T4 + 0 
1f6c : a6 57 __ LDX T3 + 0 
1f6e : 4c 01 1e JMP $1e01 ; (draw_corridor.s1010 + 0)
.s44:
;1539, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1f71 : a0 00 __ LDY #$00
1f73 : b1 0d __ LDA (P0),y 
1f75 : 85 54 __ STA T1 + 0 
1f77 : a5 5e __ LDA T9 + 0 
1f79 : f0 09 __ BEQ $1f84 ; (draw_corridor.s37 + 0)
.s38:
;1541, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1f7b : a0 02 __ LDY #$02
1f7d : b1 0d __ LDA (P0),y 
1f7f : 65 54 __ ADC T1 + 0 
1f81 : 4c 89 1f JMP $1f89 ; (draw_corridor.s84 + 0)
.s37:
;1540, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1f84 : 38 __ __ SEC
1f85 : a5 54 __ LDA T1 + 0 
1f87 : e9 01 __ SBC #$01
.s84:
;1541, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1f89 : 8d af 9f STA $9faf ; (door2_x + 0)
1f8c : 4c e7 1e JMP $1ee7 ; (draw_corridor.s36 + 0)
.s33:
;1532, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1f8f : a0 00 __ LDY #$00
1f91 : b1 55 __ LDA (T2 + 0),y 
1f93 : 85 54 __ STA T1 + 0 
1f95 : a5 5d __ LDA T8 + 0 
1f97 : d0 06 __ BNE $1f9f ; (draw_corridor.s27 + 0)
.s26:
;1534, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1f99 : c6 54 __ DEC T1 + 0 
1f9b : a5 54 __ LDA T1 + 0 
1f9d : 90 06 __ BCC $1fa5 ; (draw_corridor.s1009 + 0)
.s27:
;1534, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1f9f : a0 02 __ LDY #$02
1fa1 : b1 55 __ LDA (T2 + 0),y 
1fa3 : 65 54 __ ADC T1 + 0 
.s1009:
1fa5 : 8d b1 9f STA $9fb1 ; (door1_x + 0)
1fa8 : 4c c0 1e JMP $1ec0 ; (draw_corridor.s25 + 0)
.s1:
;1478, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1fab : ad dc 3f LDA $3fdc ; (rng_seed + 0)
1fae : 85 1b __ STA ACCU + 0 
1fb0 : ad dd 3f LDA $3fdd ; (rng_seed + 1)
1fb3 : 85 1c __ STA ACCU + 1 
1fb5 : a9 64 __ LDA #$64
1fb7 : 85 03 __ STA WORK + 0 
1fb9 : a9 00 __ LDA #$00
1fbb : 85 04 __ STA WORK + 1 
1fbd : 20 38 3f JSR $3f38 ; (divmod + 0)
1fc0 : a5 05 __ LDA WORK + 2 
1fc2 : c9 46 __ CMP #$46
1fc4 : a9 00 __ LDA #$00
1fc6 : 2a __ __ ROL
1fc7 : 49 01 __ EOR #$01
1fc9 : 8d b8 9f STA $9fb8 ; (use_straight + 0)
1fcc : f0 47 __ BEQ $2015 ; (draw_corridor.s7 + 0)
.s5:
;1482, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1fce : a5 0d __ LDA P0 
1fd0 : 85 11 __ STA P4 
1fd2 : a5 0e __ LDA P1 
1fd4 : 85 12 __ STA P5 
1fd6 : ad c7 9f LDA $9fc7 ; (exit1 + 2)
1fd9 : 85 54 __ STA T1 + 0 
1fdb : 85 0d __ STA P0 
1fdd : ad c8 9f LDA $9fc8 ; (exit1 + 3)
1fe0 : 85 55 __ STA T2 + 0 
1fe2 : 85 0e __ STA P1 
1fe4 : ad c1 9f LDA $9fc1 ; (create_rooms@stack + 3)
1fe7 : 85 57 __ STA T3 + 0 
1fe9 : 85 0f __ STA P2 
1feb : ad c2 9f LDA $9fc2 ; (create_rooms@stack + 4)
1fee : 85 58 __ STA T4 + 0 
1ff0 : 85 10 __ STA P3 
1ff2 : 20 f3 25 JSR $25f3 ; (path_intersects_other_rooms.s0 + 0)
1ff5 : a5 1b __ LDA ACCU + 0 
1ff7 : d0 1c __ BNE $2015 ; (draw_corridor.s7 + 0)
.s8:
;1485, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
1ff9 : a5 54 __ LDA T1 + 0 
1ffb : 85 17 __ STA P10 
1ffd : a5 55 __ LDA T2 + 0 
1fff : 85 18 __ STA P11 
2001 : a5 57 __ LDA T3 + 0 
2003 : 8d f2 9f STA $9ff2 ; (sstack + 0)
2006 : a5 58 __ LDA T4 + 0 
2008 : 8d f3 9f STA $9ff3 ; (sstack + 1)
200b : 20 35 28 JSR $2835 ; (draw_straight_corridor.s0 + 0)
200e : a5 1b __ LDA ACCU + 0 
2010 : f0 03 __ BEQ $2015 ; (draw_corridor.s7 + 0)
2012 : 4c 5f 1f JMP $1f5f ; (draw_corridor.s1011 + 0)
.s7:
;1496, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2015 : ad c3 9f LDA $9fc3 ; (create_rooms@stack + 5)
2018 : 85 0e __ STA P1 
201a : ad c9 9f LDA $9fc9 ; (exit1 + 4)
201d : 20 2d 2a JSR $2a2d ; (get_optimal_corridor_direction.s0 + 0)
2020 : 8d b7 9f STA $9fb7 ; (start_with_x + 0)
2023 : 4c a3 1d JMP $1da3 ; (draw_corridor.s66 + 0)
--------------------------------------------------------------------
calculate_exit_points: ; calculate_exit_points(struct S#849*,u8,u8,struct S#1050*)->void
.s1000:
2026 : a5 53 __ LDA T8 + 0 
2028 : 8d ce 9f STA $9fce ; (find_l_corridor_exits@stack + 3)
.s0:
; 608, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
202b : ad f2 9f LDA $9ff2 ; (sstack + 0)
202e : 85 4c __ STA T3 + 0 
2030 : 38 __ __ SEC
2031 : e9 00 __ SBC #$00
2033 : 85 4a __ STA T1 + 0 
2035 : ad f3 9f LDA $9ff3 ; (sstack + 1)
2038 : 85 4d __ STA T3 + 1 
203a : e9 4c __ SBC #$4c
203c : 4a __ __ LSR
203d : 66 4a __ ROR T1 + 0 
203f : 4a __ __ LSR
2040 : 66 4a __ ROR T1 + 0 
2042 : 4a __ __ LSR
2043 : 66 4a __ ROR T1 + 0 
2045 : a5 4a __ LDA T1 + 0 
2047 : 85 0e __ STA P1 
2049 : 8d db 9f STA $9fdb ; (grid_positions + 13)
; 609, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
204c : a9 dd __ LDA #$dd
204e : 85 0f __ STA P2 
2050 : a9 9f __ LDA #$9f
2052 : 85 12 __ STA P5 
2054 : a9 9f __ LDA #$9f
2056 : 85 10 __ STA P3 
2058 : a9 dc __ LDA #$dc
205a : 85 11 __ STA P4 
205c : 20 0b 0d JSR $0d0b ; (get_room_center.s0 + 0)
; 611, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
205f : ad f4 9f LDA $9ff4 ; (sstack + 2)
2062 : 85 50 __ STA T5 + 0 
2064 : 85 0d __ STA P0 
2066 : ad dd 9f LDA $9fdd ; (grid_positions + 15)
2069 : 85 51 __ STA T6 + 0 
206b : 85 0e __ STA P1 
206d : 20 c5 0d JSR $0dc5 ; (abs_diff.s0 + 0)
2070 : 85 4b __ STA T2 + 0 
2072 : 8d da 9f STA $9fda ; (grid_positions + 12)
; 612, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2075 : ad f5 9f LDA $9ff5 ; (sstack + 3)
2078 : 85 52 __ STA T7 + 0 
207a : 85 0d __ STA P0 
207c : ad dc 9f LDA $9fdc ; (grid_positions + 14)
207f : 85 53 __ STA T8 + 0 
2081 : 85 0e __ STA P1 
2083 : 20 c5 0d JSR $0dc5 ; (abs_diff.s0 + 0)
2086 : 8d d9 9f STA $9fd9 ; (grid_positions + 11)
; 615, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2089 : c5 4b __ CMP T2 + 0 
208b : b0 03 __ BCS $2090 ; (calculate_exit_points.s2 + 0)
208d : 4c 5a 21 JMP $215a ; (calculate_exit_points.s1 + 0)
.s2:
; 649, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2090 : a0 02 __ LDY #$02
2092 : b1 4c __ LDA (T3 + 0),y 
2094 : 85 0d __ STA P0 
2096 : a5 50 __ LDA T5 + 0 
2098 : 85 0e __ STA P1 
209a : a0 00 __ LDY #$00
209c : b1 4c __ LDA (T3 + 0),y 
209e : 85 0f __ STA P2 
20a0 : 20 24 22 JSR $2224 ; (calculate_optimal_exit_position.s0 + 0)
20a3 : 18 __ __ CLC
20a4 : 65 0f __ ADC P2 
20a6 : 8d d5 9f STA $9fd5 ; (grid_positions + 7)
20a9 : aa __ __ TAX
; 651, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
20aa : a5 4a __ LDA T1 + 0 
20ac : 85 11 __ STA P4 
20ae : a5 0e __ LDA P1 
20b0 : 85 13 __ STA P6 
20b2 : a5 52 __ LDA T7 + 0 
20b4 : 85 14 __ STA P7 
20b6 : a9 d4 __ LDA #$d4
20b8 : 85 15 __ STA P8 
20ba : a9 9f __ LDA #$9f
20bc : 85 16 __ STA P9 
20be : a9 d3 __ LDA #$d3
20c0 : 85 17 __ STA P10 
20c2 : a9 9f __ LDA #$9f
20c4 : 85 18 __ STA P11 
20c6 : a0 01 __ LDY #$01
20c8 : b1 4c __ LDA (T3 + 0),y 
20ca : 85 4a __ STA T1 + 0 
20cc : ad f6 9f LDA $9ff6 ; (sstack + 4)
20cf : 85 4e __ STA T4 + 0 
20d1 : ad f7 9f LDA $9ff7 ; (sstack + 5)
20d4 : 85 4f __ STA T4 + 1 
20d6 : a5 53 __ LDA T8 + 0 
20d8 : c5 14 __ CMP P7 
20da : b0 1a __ BCS $20f6 ; (calculate_exit_points.s14 + 0)
.s13:
; 653, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
20dc : a0 03 __ LDY #$03
20de : b1 4c __ LDA (T3 + 0),y 
20e0 : 38 __ __ SEC
20e1 : 65 4a __ ADC T1 + 0 
20e3 : a0 01 __ LDY #$01
20e5 : 91 4e __ STA (T4 + 0),y 
; 655, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
20e7 : b1 4c __ LDA (T3 + 0),y 
20e9 : 18 __ __ CLC
20ea : a0 03 __ LDY #$03
20ec : 71 4c __ ADC (T3 + 0),y 
20ee : 85 4a __ STA T1 + 0 
20f0 : 98 __ __ TYA
20f1 : c8 __ __ INY
20f2 : 91 4e __ STA (T4 + 0),y 
20f4 : d0 12 __ BNE $2108 ; (calculate_exit_points.s15 + 0)
.s14:
; 658, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
20f6 : a5 4a __ LDA T1 + 0 
20f8 : e9 02 __ SBC #$02
20fa : 91 4e __ STA (T4 + 0),y 
; 660, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
20fc : b1 4c __ LDA (T3 + 0),y 
20fe : 85 4a __ STA T1 + 0 
2100 : a9 02 __ LDA #$02
2102 : a0 04 __ LDY #$04
2104 : 91 4e __ STA (T4 + 0),y 
; 659, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2106 : c6 4a __ DEC T1 + 0 
.s15:
; 662, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2108 : 8a __ __ TXA
2109 : a0 00 __ LDY #$00
210b : 91 4e __ STA (T4 + 0),y 
210d : a0 02 __ LDY #$02
210f : 91 4e __ STA (T4 + 0),y 
; 659, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2111 : a5 4a __ LDA T1 + 0 
2113 : c8 __ __ INY
2114 : 91 4e __ STA (T4 + 0),y 
; 663, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2116 : c8 __ __ INY
2117 : b1 4e __ LDA (T4 + 0),y 
2119 : 85 12 __ STA P5 
211b : 8a __ __ TXA
211c : 38 __ __ SEC
211d : a0 00 __ LDY #$00
211f : f1 4c __ SBC (T3 + 0),y 
2121 : a0 05 __ LDY #$05
2123 : 91 4e __ STA (T4 + 0),y 
; 667, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2125 : 20 89 22 JSR $2289 ; (find_existing_door_on_room_side.s0 + 0)
2128 : a5 1b __ LDA ACCU + 0 ; (target_x + 0)
212a : f0 28 __ BEQ $2154 ; (calculate_exit_points.s1001 + 0)
.s16:
; 670, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
212c : ad d4 9f LDA $9fd4 ; (grid_positions + 6)
212f : a0 00 __ LDY #$00
2131 : 91 4e __ STA (T4 + 0),y 
2133 : a0 02 __ LDY #$02
2135 : 91 4e __ STA (T4 + 0),y 
; 671, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2137 : 38 __ __ SEC
2138 : a0 00 __ LDY #$00
213a : f1 4c __ SBC (T3 + 0),y 
213c : a0 05 __ LDY #$05
213e : 91 4e __ STA (T4 + 0),y 
; 673, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2140 : 88 __ __ DEY
2141 : b1 4e __ LDA (T4 + 0),y 
2143 : ae d3 9f LDX $9fd3 ; (grid_positions + 5)
2146 : c9 03 __ CMP #$03
2148 : f0 04 __ BEQ $214e ; (calculate_exit_points.s19 + 0)
.s20:
; 676, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
214a : ca __ __ DEX
214b : 4c 4f 21 JMP $214f ; (calculate_exit_points.s30 + 0)
.s19:
; 674, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
214e : e8 __ __ INX
.s30:
; 676, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
214f : 8a __ __ TXA
2150 : a0 01 __ LDY #$01
.s1002:
; 644, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2152 : 91 4e __ STA (T4 + 0),y 
.s1001:
2154 : ad ce 9f LDA $9fce ; (find_l_corridor_exits@stack + 3)
2157 : 85 53 __ STA T8 + 0 
; 680, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2159 : 60 __ __ RTS
.s1:
; 617, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
215a : a0 03 __ LDY #$03
215c : b1 4c __ LDA (T3 + 0),y 
215e : 85 0d __ STA P0 
2160 : a5 52 __ LDA T7 + 0 
2162 : 85 0e __ STA P1 
2164 : a0 01 __ LDY #$01
2166 : b1 4c __ LDA (T3 + 0),y 
2168 : 85 0f __ STA P2 
216a : 20 24 22 JSR $2224 ; (calculate_optimal_exit_position.s0 + 0)
216d : 18 __ __ CLC
216e : 65 0f __ ADC P2 
2170 : 8d d8 9f STA $9fd8 ; (grid_positions + 10)
2173 : aa __ __ TAX
; 619, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2174 : a5 4a __ LDA T1 + 0 
2176 : 85 11 __ STA P4 
2178 : a5 50 __ LDA T5 + 0 
217a : 85 13 __ STA P6 
217c : a5 0e __ LDA P1 
217e : 85 14 __ STA P7 
2180 : a9 d7 __ LDA #$d7
2182 : 85 15 __ STA P8 
2184 : a9 9f __ LDA #$9f
2186 : 85 16 __ STA P9 
2188 : a9 d6 __ LDA #$d6
218a : 85 17 __ STA P10 
218c : a9 9f __ LDA #$9f
218e : 85 18 __ STA P11 
2190 : a0 00 __ LDY #$00
2192 : b1 4c __ LDA (T3 + 0),y 
2194 : 85 4a __ STA T1 + 0 
2196 : ad f6 9f LDA $9ff6 ; (sstack + 4)
2199 : 85 4e __ STA T4 + 0 
219b : ad f7 9f LDA $9ff7 ; (sstack + 5)
219e : 85 4f __ STA T4 + 1 
21a0 : a5 51 __ LDA T6 + 0 
21a2 : c5 13 __ CMP P6 
21a4 : b0 1c __ BCS $21c2 ; (calculate_exit_points.s5 + 0)
.s4:
; 621, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
21a6 : a0 02 __ LDY #$02
21a8 : b1 4c __ LDA (T3 + 0),y 
21aa : 38 __ __ SEC
21ab : 65 4a __ ADC T1 + 0 
21ad : a0 00 __ LDY #$00
21af : 91 4e __ STA (T4 + 0),y 
; 623, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
21b1 : b1 4c __ LDA (T3 + 0),y 
21b3 : 18 __ __ CLC
21b4 : a0 02 __ LDY #$02
21b6 : 71 4c __ ADC (T3 + 0),y 
21b8 : 85 4a __ STA T1 + 0 
21ba : a9 01 __ LDA #$01
21bc : a0 04 __ LDY #$04
21be : 91 4e __ STA (T4 + 0),y 
21c0 : d0 11 __ BNE $21d3 ; (calculate_exit_points.s6 + 0)
.s5:
; 626, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
21c2 : a5 4a __ LDA T1 + 0 
21c4 : e9 02 __ SBC #$02
21c6 : 91 4e __ STA (T4 + 0),y 
; 628, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
21c8 : b1 4c __ LDA (T3 + 0),y 
21ca : 85 4a __ STA T1 + 0 
21cc : 98 __ __ TYA
21cd : a0 04 __ LDY #$04
21cf : 91 4e __ STA (T4 + 0),y 
; 627, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
21d1 : c6 4a __ DEC T1 + 0 
.s6:
; 630, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
21d3 : 8a __ __ TXA
21d4 : a0 01 __ LDY #$01
21d6 : 91 4e __ STA (T4 + 0),y 
; 627, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
21d8 : a0 03 __ LDY #$03
21da : 91 4e __ STA (T4 + 0),y 
21dc : a5 4a __ LDA T1 + 0 
; 630, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
21de : 88 __ __ DEY
21df : 91 4e __ STA (T4 + 0),y 
; 631, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
21e1 : a0 04 __ LDY #$04
21e3 : b1 4e __ LDA (T4 + 0),y 
21e5 : 85 12 __ STA P5 
21e7 : 8a __ __ TXA
21e8 : 38 __ __ SEC
21e9 : a0 01 __ LDY #$01
21eb : f1 4c __ SBC (T3 + 0),y 
21ed : a0 05 __ LDY #$05
21ef : 91 4e __ STA (T4 + 0),y 
; 635, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
21f1 : 20 89 22 JSR $2289 ; (find_existing_door_on_room_side.s0 + 0)
21f4 : a5 1b __ LDA ACCU + 0 ; (target_x + 0)
21f6 : d0 03 __ BNE $21fb ; (calculate_exit_points.s7 + 0)
21f8 : 4c 54 21 JMP $2154 ; (calculate_exit_points.s1001 + 0)
.s7:
; 638, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
21fb : ad d6 9f LDA $9fd6 ; (grid_positions + 8)
21fe : a0 01 __ LDY #$01
2200 : 91 4e __ STA (T4 + 0),y 
2202 : a0 03 __ LDY #$03
2204 : 91 4e __ STA (T4 + 0),y 
; 639, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2206 : 38 __ __ SEC
2207 : a0 01 __ LDY #$01
2209 : f1 4c __ SBC (T3 + 0),y 
220b : a0 05 __ LDY #$05
220d : 91 4e __ STA (T4 + 0),y 
; 641, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
220f : 88 __ __ DEY
2210 : b1 4e __ LDA (T4 + 0),y 
2212 : ae d7 9f LDX $9fd7 ; (grid_positions + 9)
2215 : c9 01 __ CMP #$01
2217 : f0 04 __ BEQ $221d ; (calculate_exit_points.s10 + 0)
.s11:
; 644, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2219 : ca __ __ DEX
221a : 4c 1e 22 JMP $221e ; (calculate_exit_points.s29 + 0)
.s10:
; 642, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
221d : e8 __ __ INX
.s29:
; 644, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
221e : 8a __ __ TXA
221f : a0 00 __ LDY #$00
2221 : 4c 52 21 JMP $2152 ; (calculate_exit_points.s1002 + 0)
--------------------------------------------------------------------
calculate_optimal_exit_position: ; calculate_optimal_exit_position(u8,u8,u8)->u8
.s0:
; 493, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2224 : a5 0d __ LDA P0 ; (room_dim + 0)
2226 : 4a __ __ LSR
2227 : a8 __ __ TAY
2228 : 18 __ __ CLC
2229 : 65 0f __ ADC P2 ; (room_coord + 0)
222b : 85 43 __ STA T2 + 0 
222d : a9 00 __ LDA #$00
222f : 2a __ __ ROL
2230 : 85 44 __ STA T2 + 1 
2232 : d0 0a __ BNE $223e ; (calculate_optimal_exit_position.s2 + 0)
.s1005:
2234 : a5 43 __ LDA T2 + 0 
2236 : c5 0e __ CMP P1 ; (target_coord + 0)
2238 : b0 04 __ BCS $223e ; (calculate_optimal_exit_position.s2 + 0)
.s1:
; 495, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
223a : a9 c0 __ LDA #$c0
223c : 90 10 __ BCC $224e ; (calculate_optimal_exit_position.s3 + 0)
.s2:
; 496, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
223e : a5 44 __ LDA T2 + 1 
2240 : d0 0a __ BNE $224c ; (calculate_optimal_exit_position.s4 + 0)
.s1002:
2242 : a5 0e __ LDA P1 ; (target_coord + 0)
2244 : c5 43 __ CMP T2 + 0 
2246 : d0 04 __ BNE $224c ; (calculate_optimal_exit_position.s4 + 0)
.s5:
; 501, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2248 : a9 80 __ LDA #$80
224a : d0 02 __ BNE $224e ; (calculate_optimal_exit_position.s3 + 0)
.s4:
; 498, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
224c : a9 40 __ LDA #$40
.s3:
; 495, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
224e : 8d f1 9f STA $9ff1 ; (r1 + 1)
; 506, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2251 : a5 0d __ LDA P0 ; (room_dim + 0)
2253 : 4a __ __ LSR
2254 : 4a __ __ LSR
2255 : 85 43 __ STA T2 + 0 
2257 : 8d f0 9f STA $9ff0 ; (r1 + 0)
; 507, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
225a : 38 __ __ SEC
225b : a5 0d __ LDA P0 ; (room_dim + 0)
225d : e5 43 __ SBC T2 + 0 
225f : 8d ef 9f STA $9fef ; (byte_ptr + 1)
; 509, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2262 : a5 43 __ LDA T2 + 0 
2264 : cd ef 9f CMP $9fef ; (byte_ptr + 1)
2267 : 90 02 __ BCC $226b ; (calculate_optimal_exit_position.s9 + 0)
.s7:
; 511, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2269 : 98 __ __ TYA
226a : 60 __ __ RTS
.s9:
; 515, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
226b : ad ef 9f LDA $9fef ; (byte_ptr + 1)
226e : 38 __ __ SEC
226f : e5 43 __ SBC T2 + 0 
2271 : 85 1b __ STA ACCU + 0 
2273 : 8d ee 9f STA $9fee ; (result + 0)
; 516, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2276 : a9 00 __ LDA #$00
2278 : 85 1c __ STA ACCU + 1 
227a : ad f1 9f LDA $9ff1 ; (r1 + 1)
227d : 20 be 3e JSR $3ebe ; (mul16by8 + 0)
2280 : a5 1c __ LDA ACCU + 1 
2282 : 8d ed 9f STA $9fed ; (s + 1)
; 518, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2285 : 18 __ __ CLC
2286 : 65 43 __ ADC T2 + 0 
.s1001:
2288 : 60 __ __ RTS
--------------------------------------------------------------------
find_existing_door_on_room_side: ; find_existing_door_on_room_side(u8,u8,u8,u8,u8*,u8*)->u8
.s0:
;1338, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2289 : a5 11 __ LDA P4 ; (room_idx + 0)
228b : cd de 3f CMP $3fde ; (room_count + 0)
228e : 90 03 __ BCC $2293 ; (find_existing_door_on_room_side.s3 + 0)
2290 : 4c 63 23 JMP $2363 ; (find_existing_door_on_room_side.s1 + 0)
.s3:
;1342, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2293 : a9 00 __ LDA #$00
2295 : 8d e5 9f STA $9fe5 ; (leg1_end_x + 0)
2298 : 8d e4 9f STA $9fe4 ; (random_offset_x + 0)
;1343, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
229b : 8d e3 9f STA $9fe3 ; (screen_offset + 1)
;1340, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
229e : a5 11 __ LDA P4 ; (room_idx + 0)
22a0 : 0a __ __ ASL
22a1 : 0a __ __ ASL
22a2 : 0a __ __ ASL
22a3 : 18 __ __ CLC
22a4 : 69 00 __ ADC #$00
22a6 : 85 45 __ STA T2 + 0 
22a8 : 8d e8 9f STA $9fe8 ; (entropy3 + 1)
;1344, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
22ab : a9 ff __ LDA #$ff
22ad : 8d e2 9f STA $9fe2 ; (best_distance + 0)
;1340, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
22b0 : a9 4c __ LDA #$4c
22b2 : 69 00 __ ADC #$00
22b4 : 85 46 __ STA T2 + 1 
22b6 : 8d e9 9f STA $9fe9 ; (connected + 1)
;1346, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
22b9 : a5 12 __ LDA P5 ; (side + 0)
22bb : c9 02 __ CMP #$02
22bd : d0 13 __ BNE $22d2 ; (find_existing_door_on_room_side.s55 + 0)
.s30:
;1378, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
22bf : a0 01 __ LDY #$01
22c1 : b1 45 __ LDA (T2 + 0),y 
22c3 : e9 01 __ SBC #$01
22c5 : 85 47 __ STA T3 + 0 
22c7 : 8d e6 9f STA $9fe6 ; (screen_pos + 1)
;1379, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
22ca : 88 __ __ DEY
22cb : b1 45 __ LDA (T2 + 0),y 
22cd : 85 48 __ STA T4 + 0 
22cf : 4c 4c 24 JMP $244c ; (find_existing_door_on_room_side.l31 + 0)
.s55:
;1346, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
22d2 : b0 03 __ BCS $22d7 ; (find_existing_door_on_room_side.s56 + 0)
22d4 : 4c 68 23 JMP $2368 ; (find_existing_door_on_room_side.s57 + 0)
.s56:
22d7 : c9 03 __ CMP #$03
22d9 : d0 b5 __ BNE $2290 ; (find_existing_door_on_room_side.s0 + 7)
.s42:
;1393, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
22db : a0 01 __ LDY #$01
22dd : b1 45 __ LDA (T2 + 0),y 
22df : 18 __ __ CLC
22e0 : a0 03 __ LDY #$03
22e2 : 71 45 __ ADC (T2 + 0),y 
22e4 : 85 47 __ STA T3 + 0 
22e6 : 8d e6 9f STA $9fe6 ; (screen_pos + 1)
;1394, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
22e9 : a0 00 __ LDY #$00
22eb : b1 45 __ LDA (T2 + 0),y 
22ed : 85 48 __ STA T4 + 0 
22ef : 4c f7 22 JMP $22f7 ; (find_existing_door_on_room_side.l43 + 0)
.s153:
;1394, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
22f2 : 18 __ __ CLC
22f3 : a5 49 __ LDA T5 + 0 
22f5 : 69 01 __ ADC #$01
.l43:
22f7 : 8d e7 9f STA $9fe7 ; (idx + 0)
22fa : a0 02 __ LDY #$02
22fc : b1 45 __ LDA (T2 + 0),y 
22fe : 18 __ __ CLC
22ff : 65 48 __ ADC T4 + 0 
2301 : 85 43 __ STA T0 + 0 
2303 : ad e7 9f LDA $9fe7 ; (idx + 0)
2306 : 85 49 __ STA T5 + 0 
2308 : b0 04 __ BCS $230e ; (find_existing_door_on_room_side.s44 + 0)
.s1002:
230a : c5 43 __ CMP T0 + 0 
230c : b0 40 __ BCS $234e ; (find_existing_door_on_room_side.s5 + 0)
.s44:
;1395, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
230e : 85 0f __ STA P2 
2310 : a5 47 __ LDA T3 + 0 
2312 : 85 10 __ STA P3 
2314 : 20 a8 24 JSR $24a8 ; (tile_is_door.s0 + 0)
2317 : a5 1b __ LDA ACCU + 0 
2319 : f0 d7 __ BEQ $22f2 ; (find_existing_door_on_room_side.s153 + 0)
.s47:
;1396, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
231b : a5 49 __ LDA T5 + 0 
231d : 85 0d __ STA P0 
231f : a5 13 __ LDA P6 ; (target_x + 0)
2321 : 85 0e __ STA P1 
2323 : 20 c5 0d JSR $0dc5 ; (abs_diff.s0 + 0)
2326 : 8d de 9f STA $9fde ; (pivot_x + 0)
;1397, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2329 : ad e3 9f LDA $9fe3 ; (screen_offset + 1)
232c : f0 08 __ BEQ $2336 ; (find_existing_door_on_room_side.s50 + 0)
.s53:
232e : ad de 9f LDA $9fde ; (pivot_x + 0)
2331 : cd e2 9f CMP $9fe2 ; (best_distance + 0)
2334 : b0 bc __ BCS $22f2 ; (find_existing_door_on_room_side.s153 + 0)
.s50:
;1398, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2336 : a5 49 __ LDA T5 + 0 
2338 : 8d e5 9f STA $9fe5 ; (leg1_end_x + 0)
;1399, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
233b : a5 10 __ LDA P3 
233d : 8d e4 9f STA $9fe4 ; (random_offset_x + 0)
;1401, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2340 : a9 01 __ LDA #$01
2342 : 8d e3 9f STA $9fe3 ; (screen_offset + 1)
;1400, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2345 : ad de 9f LDA $9fde ; (pivot_x + 0)
2348 : 8d e2 9f STA $9fe2 ; (best_distance + 0)
234b : 4c f2 22 JMP $22f2 ; (find_existing_door_on_room_side.s153 + 0)
.s5:
;1408, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
234e : ad e3 9f LDA $9fe3 ; (screen_offset + 1)
2351 : f0 10 __ BEQ $2363 ; (find_existing_door_on_room_side.s1 + 0)
.s60:
;1409, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2353 : ad e5 9f LDA $9fe5 ; (leg1_end_x + 0)
2356 : a0 00 __ LDY #$00
2358 : 91 15 __ STA (P8),y ; (door_x + 0)
;1410, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
235a : ad e4 9f LDA $9fe4 ; (random_offset_x + 0)
235d : 91 17 __ STA (P10),y ; (door_y + 0)
;1411, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
235f : a9 01 __ LDA #$01
2361 : b0 02 __ BCS $2365 ; (find_existing_door_on_room_side.s1001 + 0)
.s1:
;1338, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2363 : a9 00 __ LDA #$00
.s1001:
2365 : 85 1b __ STA ACCU + 0 
2367 : 60 __ __ RTS
.s57:
;1349, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2368 : a0 01 __ LDY #$01
236a : b1 45 __ LDA (T2 + 0),y 
236c : 85 48 __ STA T4 + 0 
236e : 8d e6 9f STA $9fe6 ; (screen_pos + 1)
;1346, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2371 : 88 __ __ DEY
2372 : b1 45 __ LDA (T2 + 0),y 
2374 : 85 43 __ STA T0 + 0 
2376 : a5 12 __ LDA P5 ; (side + 0)
2378 : f0 68 __ BEQ $23e2 ; (find_existing_door_on_room_side.s6 + 0)
.s18:
;1363, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
237a : a0 02 __ LDY #$02
237c : b1 45 __ LDA (T2 + 0),y 
237e : 65 43 __ ADC T0 + 0 
2380 : 85 47 __ STA T3 + 0 
2382 : 8d e7 9f STA $9fe7 ; (idx + 0)
2385 : 4c 8e 23 JMP $238e ; (find_existing_door_on_room_side.l19 + 0)
.s151:
;1364, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2388 : a6 49 __ LDX T5 + 0 
238a : e8 __ __ INX
238b : 8e e6 9f STX $9fe6 ; (screen_pos + 1)
.l19:
238e : a0 03 __ LDY #$03
2390 : b1 45 __ LDA (T2 + 0),y 
2392 : 18 __ __ CLC
2393 : 65 48 __ ADC T4 + 0 
2395 : 85 43 __ STA T0 + 0 
2397 : ad e6 9f LDA $9fe6 ; (screen_pos + 1)
239a : 85 49 __ STA T5 + 0 
239c : b0 04 __ BCS $23a2 ; (find_existing_door_on_room_side.s20 + 0)
.s1005:
239e : c5 43 __ CMP T0 + 0 
23a0 : b0 ac __ BCS $234e ; (find_existing_door_on_room_side.s5 + 0)
.s20:
;1365, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
23a2 : 85 10 __ STA P3 
23a4 : a5 47 __ LDA T3 + 0 
23a6 : 85 0f __ STA P2 
23a8 : 20 a8 24 JSR $24a8 ; (tile_is_door.s0 + 0)
23ab : a5 1b __ LDA ACCU + 0 
23ad : f0 d9 __ BEQ $2388 ; (find_existing_door_on_room_side.s151 + 0)
.s23:
;1366, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
23af : a5 49 __ LDA T5 + 0 
23b1 : 85 0d __ STA P0 
23b3 : a5 14 __ LDA P7 ; (target_y + 0)
23b5 : 85 0e __ STA P1 
23b7 : 20 c5 0d JSR $0dc5 ; (abs_diff.s0 + 0)
23ba : 8d e0 9f STA $9fe0 ; (y + 0)
;1367, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
23bd : ad e3 9f LDA $9fe3 ; (screen_offset + 1)
23c0 : f0 08 __ BEQ $23ca ; (find_existing_door_on_room_side.s26 + 0)
.s29:
23c2 : ad e0 9f LDA $9fe0 ; (y + 0)
23c5 : cd e2 9f CMP $9fe2 ; (best_distance + 0)
23c8 : b0 be __ BCS $2388 ; (find_existing_door_on_room_side.s151 + 0)
.s26:
;1368, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
23ca : a5 0f __ LDA P2 
23cc : 8d e5 9f STA $9fe5 ; (leg1_end_x + 0)
;1369, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
23cf : a5 49 __ LDA T5 + 0 
23d1 : 8d e4 9f STA $9fe4 ; (random_offset_x + 0)
;1371, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
23d4 : a9 01 __ LDA #$01
23d6 : 8d e3 9f STA $9fe3 ; (screen_offset + 1)
;1370, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
23d9 : ad e0 9f LDA $9fe0 ; (y + 0)
23dc : 8d e2 9f STA $9fe2 ; (best_distance + 0)
23df : 4c 88 23 JMP $2388 ; (find_existing_door_on_room_side.s151 + 0)
.s6:
;1348, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
23e2 : 38 __ __ SEC
23e3 : a5 43 __ LDA T0 + 0 
23e5 : e9 01 __ SBC #$01
23e7 : 85 47 __ STA T3 + 0 
23e9 : 8d e7 9f STA $9fe7 ; (idx + 0)
23ec : 4c f5 23 JMP $23f5 ; (find_existing_door_on_room_side.l7 + 0)
.s150:
;1349, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
23ef : a6 49 __ LDX T5 + 0 
23f1 : e8 __ __ INX
23f2 : 8e e6 9f STX $9fe6 ; (screen_pos + 1)
.l7:
23f5 : a0 03 __ LDY #$03
23f7 : b1 45 __ LDA (T2 + 0),y 
23f9 : 18 __ __ CLC
23fa : 65 48 __ ADC T4 + 0 
23fc : 85 43 __ STA T0 + 0 
23fe : ad e6 9f LDA $9fe6 ; (screen_pos + 1)
2401 : 85 49 __ STA T5 + 0 
2403 : b0 07 __ BCS $240c ; (find_existing_door_on_room_side.s8 + 0)
.s1008:
2405 : c5 43 __ CMP T0 + 0 
2407 : 90 03 __ BCC $240c ; (find_existing_door_on_room_side.s8 + 0)
2409 : 4c 4e 23 JMP $234e ; (find_existing_door_on_room_side.s5 + 0)
.s8:
;1350, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
240c : 85 10 __ STA P3 
240e : a5 47 __ LDA T3 + 0 
2410 : 85 0f __ STA P2 
2412 : 20 a8 24 JSR $24a8 ; (tile_is_door.s0 + 0)
2415 : a5 1b __ LDA ACCU + 0 
2417 : f0 d6 __ BEQ $23ef ; (find_existing_door_on_room_side.s150 + 0)
.s11:
;1351, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2419 : a5 49 __ LDA T5 + 0 
241b : 85 0d __ STA P0 
241d : a5 14 __ LDA P7 ; (target_y + 0)
241f : 85 0e __ STA P1 
2421 : 20 c5 0d JSR $0dc5 ; (abs_diff.s0 + 0)
2424 : 8d e1 9f STA $9fe1 ; (r1 + 0)
;1352, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2427 : ad e3 9f LDA $9fe3 ; (screen_offset + 1)
242a : f0 08 __ BEQ $2434 ; (find_existing_door_on_room_side.s14 + 0)
.s17:
242c : ad e1 9f LDA $9fe1 ; (r1 + 0)
242f : cd e2 9f CMP $9fe2 ; (best_distance + 0)
2432 : b0 bb __ BCS $23ef ; (find_existing_door_on_room_side.s150 + 0)
.s14:
;1353, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2434 : a5 0f __ LDA P2 
2436 : 8d e5 9f STA $9fe5 ; (leg1_end_x + 0)
;1354, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2439 : a5 49 __ LDA T5 + 0 
243b : 8d e4 9f STA $9fe4 ; (random_offset_x + 0)
;1356, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
243e : a9 01 __ LDA #$01
2440 : 8d e3 9f STA $9fe3 ; (screen_offset + 1)
;1355, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2443 : ad e1 9f LDA $9fe1 ; (r1 + 0)
2446 : 8d e2 9f STA $9fe2 ; (best_distance + 0)
2449 : 4c ef 23 JMP $23ef ; (find_existing_door_on_room_side.s150 + 0)
.l31:
;1379, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
244c : 8d e7 9f STA $9fe7 ; (idx + 0)
244f : a0 02 __ LDY #$02
2451 : b1 45 __ LDA (T2 + 0),y 
2453 : 18 __ __ CLC
2454 : 65 48 __ ADC T4 + 0 
2456 : 85 43 __ STA T0 + 0 
2458 : ad e7 9f LDA $9fe7 ; (idx + 0)
245b : 85 49 __ STA T5 + 0 
245d : b0 04 __ BCS $2463 ; (find_existing_door_on_room_side.s32 + 0)
.s1011:
245f : c5 43 __ CMP T0 + 0 
2461 : b0 a6 __ BCS $2409 ; (find_existing_door_on_room_side.s1008 + 4)
.s32:
;1380, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2463 : 85 0f __ STA P2 
2465 : a5 47 __ LDA T3 + 0 
2467 : 85 10 __ STA P3 
2469 : 20 a8 24 JSR $24a8 ; (tile_is_door.s0 + 0)
246c : a5 1b __ LDA ACCU + 0 
246e : f0 30 __ BEQ $24a0 ; (find_existing_door_on_room_side.s152 + 0)
.s35:
;1381, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2470 : a5 49 __ LDA T5 + 0 
2472 : 85 0d __ STA P0 
2474 : a5 13 __ LDA P6 ; (target_x + 0)
2476 : 85 0e __ STA P1 
2478 : 20 c5 0d JSR $0dc5 ; (abs_diff.s0 + 0)
247b : 8d df 9f STA $9fdf ; (leg_length + 0)
;1382, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
247e : ad e3 9f LDA $9fe3 ; (screen_offset + 1)
2481 : f0 08 __ BEQ $248b ; (find_existing_door_on_room_side.s38 + 0)
.s41:
2483 : ad df 9f LDA $9fdf ; (leg_length + 0)
2486 : cd e2 9f CMP $9fe2 ; (best_distance + 0)
2489 : b0 15 __ BCS $24a0 ; (find_existing_door_on_room_side.s152 + 0)
.s38:
;1383, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
248b : a5 49 __ LDA T5 + 0 
248d : 8d e5 9f STA $9fe5 ; (leg1_end_x + 0)
;1384, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2490 : a5 10 __ LDA P3 
2492 : 8d e4 9f STA $9fe4 ; (random_offset_x + 0)
;1386, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2495 : a9 01 __ LDA #$01
2497 : 8d e3 9f STA $9fe3 ; (screen_offset + 1)
;1385, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
249a : ad df 9f LDA $9fdf ; (leg_length + 0)
249d : 8d e2 9f STA $9fe2 ; (best_distance + 0)
.s152:
;1379, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
24a0 : 18 __ __ CLC
24a1 : a5 49 __ LDA T5 + 0 
24a3 : 69 01 __ ADC #$01
24a5 : 4c 4c 24 JMP $244c ; (find_existing_door_on_room_side.l31 + 0)
--------------------------------------------------------------------
tile_is_door: ; tile_is_door(u8,u8)->u8
.s0:
; 364, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
24a8 : a5 0f __ LDA P2 ; (x + 0)
24aa : c9 40 __ CMP #$40
24ac : b0 17 __ BCS $24c5 ; (tile_is_door.s1005 + 0)
.s4:
24ae : a5 10 __ LDA P3 ; (y + 0)
24b0 : c9 40 __ CMP #$40
24b2 : b0 11 __ BCS $24c5 ; (tile_is_door.s1005 + 0)
.s3:
; 365, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
24b4 : 85 0e __ STA P1 
24b6 : a5 0f __ LDA P2 ; (x + 0)
24b8 : 85 0d __ STA P0 
24ba : 20 ca 24 JSR $24ca ; (get_tile_core.s0 + 0)
24bd : c9 03 __ CMP #$03
24bf : d0 04 __ BNE $24c5 ; (tile_is_door.s1005 + 0)
.s1002:
24c1 : a9 01 __ LDA #$01
24c3 : d0 02 __ BNE $24c7 ; (tile_is_door.s1001 + 0)
.s1005:
24c5 : a9 00 __ LDA #$00
.s1001:
24c7 : 85 1b __ STA ACCU + 0 
24c9 : 60 __ __ RTS
--------------------------------------------------------------------
get_tile_core: ; get_tile_core(u8,u8)->u8
.s0:
; 285, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
24ca : a5 0e __ LDA P1 ; (y + 0)
24cc : 4a __ __ LSR
24cd : aa __ __ TAX
24ce : a9 00 __ LDA #$00
24d0 : 6a __ __ ROR
24d1 : 85 43 __ STA T1 + 0 
24d3 : a9 00 __ LDA #$00
24d5 : 46 0e __ LSR P1 ; (y + 0)
24d7 : 6a __ __ ROR
24d8 : 66 0e __ ROR P1 ; (y + 0)
24da : 6a __ __ ROR
24db : 65 43 __ ADC T1 + 0 
24dd : a8 __ __ TAY
24de : 8a __ __ TXA
24df : 65 0e __ ADC P1 ; (y + 0)
24e1 : aa __ __ TAX
24e2 : 98 __ __ TYA
24e3 : 18 __ __ CLC
24e4 : 65 0d __ ADC P0 ; (x + 0)
24e6 : 90 01 __ BCC $24e9 ; (get_tile_core.s1013 + 0)
.s1012:
; 276, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
24e8 : e8 __ __ INX
.s1013:
24e9 : 18 __ __ CLC
24ea : 65 0d __ ADC P0 ; (x + 0)
24ec : 90 01 __ BCC $24ef ; (get_tile_core.s1015 + 0)
.s1014:
; 276, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
24ee : e8 __ __ INX
.s1015:
24ef : 18 __ __ CLC
24f0 : 65 0d __ ADC P0 ; (x + 0)
24f2 : 8d f0 9f STA $9ff0 ; (r1 + 0)
24f5 : 8a __ __ TXA
24f6 : 69 00 __ ADC #$00
24f8 : 8d f1 9f STA $9ff1 ; (r1 + 1)
; 279, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
24fb : 4a __ __ LSR
24fc : 85 44 __ STA T1 + 1 
24fe : ad f0 9f LDA $9ff0 ; (r1 + 0)
2501 : 6a __ __ ROR
2502 : 46 44 __ LSR T1 + 1 
2504 : 6a __ __ ROR
2505 : 46 44 __ LSR T1 + 1 
2507 : 6a __ __ ROR
2508 : 18 __ __ CLC
2509 : 69 38 __ ADC #$38
250b : 85 43 __ STA T1 + 0 
250d : 8d ee 9f STA $9fee ; (result + 0)
2510 : a9 41 __ LDA #$41
2512 : 65 44 __ ADC T1 + 1 
2514 : 85 44 __ STA T1 + 1 
2516 : 8d ef 9f STA $9fef ; (byte_ptr + 1)
; 280, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2519 : ad f0 9f LDA $9ff0 ; (r1 + 0)
251c : 29 07 __ AND #$07
251e : 85 1b __ STA ACCU + 0 
2520 : 8d ed 9f STA $9fed ; (s + 1)
; 285, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2523 : aa __ __ TAX
2524 : a0 00 __ LDY #$00
2526 : b1 43 __ LDA (T1 + 0),y 
2528 : e0 00 __ CPX #$00
252a : f0 04 __ BEQ $2530 ; (get_tile_core.s1003 + 0)
.l1002:
; 285, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
252c : 4a __ __ LSR
252d : ca __ __ DEX
252e : d0 fc __ BNE $252c ; (get_tile_core.l1002 + 0)
.s1003:
; 283, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2530 : 85 1c __ STA ACCU + 1 
2532 : a5 1b __ LDA ACCU + 0 
2534 : c9 06 __ CMP #$06
2536 : a5 1c __ LDA ACCU + 1 
2538 : 90 23 __ BCC $255d ; (get_tile_core.s1001 + 0)
.s3:
; 290, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
253a : 8d eb 9f STA $9feb ; (i + 0)
; 289, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
253d : a9 08 __ LDA #$08
253f : e5 1b __ SBC ACCU + 0 
2541 : 8d ec 9f STA $9fec ; (entropy1 + 1)
; 291, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2544 : aa __ __ TAX
2545 : bd 24 41 LDA $4124,x ; (bitshift + 36)
2548 : 38 __ __ SEC
2549 : e9 01 __ SBC #$01
254b : a0 01 __ LDY #$01
254d : 31 43 __ AND (T1 + 0),y 
254f : ae ec 9f LDX $9fec ; (entropy1 + 1)
2552 : f0 04 __ BEQ $2558 ; (get_tile_core.s1005 + 0)
.l1006:
2554 : 0a __ __ ASL
2555 : ca __ __ DEX
2556 : d0 fc __ BNE $2554 ; (get_tile_core.l1006 + 0)
.s1005:
; 291, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2558 : 8d ea 9f STA $9fea ; (entropy2 + 1)
; 293, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
255b : 05 1c __ ORA ACCU + 1 
.s1001:
255d : 29 07 __ AND #$07
255f : 60 __ __ RTS
--------------------------------------------------------------------
check_room_axis_alignment: ; check_room_axis_alignment(u8,u8,u8*,u8*)->void
.s0:
; 723, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2560 : a5 0d __ LDA P0 ; (room1 + 0)
2562 : 0a __ __ ASL
2563 : 0a __ __ ASL
2564 : 0a __ __ ASL
2565 : a8 __ __ TAY
2566 : 69 00 __ ADC #$00
2568 : 85 43 __ STA T1 + 0 
256a : 8d f0 9f STA $9ff0 ; (r1 + 0)
256d : a9 4c __ LDA #$4c
256f : 69 00 __ ADC #$00
2571 : 85 44 __ STA T1 + 1 
2573 : 8d f1 9f STA $9ff1 ; (r1 + 1)
; 724, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2576 : a5 0e __ LDA P1 ; (room2 + 0)
2578 : 0a __ __ ASL
2579 : 0a __ __ ASL
257a : 0a __ __ ASL
257b : aa __ __ TAX
257c : 69 00 __ ADC #$00
257e : 85 45 __ STA T3 + 0 
2580 : 8d ee 9f STA $9fee ; (result + 0)
2583 : a9 4c __ LDA #$4c
2585 : 69 00 __ ADC #$00
2587 : 85 46 __ STA T3 + 1 
2589 : 8d ef 9f STA $9fef ; (byte_ptr + 1)
; 727, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
258c : b9 01 4c LDA $4c01,y ; (rooms + 1)
258f : 85 1b __ STA ACCU + 0 
2591 : 18 __ __ CLC
2592 : 79 03 4c ADC $4c03,y ; (rooms + 3)
2595 : b0 0b __ BCS $25a2 ; (check_room_axis_alignment.s4 + 0)
.s1011:
2597 : dd 01 4c CMP $4c01,x ; (rooms + 1)
259a : 90 02 __ BCC $259e ; (check_room_axis_alignment.s2 + 0)
.s1016:
259c : d0 04 __ BNE $25a2 ; (check_room_axis_alignment.s4 + 0)
.s2:
259e : a9 00 __ LDA #$00
25a0 : f0 19 __ BEQ $25bb ; (check_room_axis_alignment.s1014 + 0)
.s4:
; 727, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
25a2 : a0 03 __ LDY #$03
25a4 : b1 45 __ LDA (T3 + 0),y 
25a6 : 18 __ __ CLC
25a7 : 7d 01 4c ADC $4c01,x ; (rooms + 1)
25aa : 90 04 __ BCC $25b0 ; (check_room_axis_alignment.s1008 + 0)
.s1:
25ac : a9 01 __ LDA #$01
25ae : b0 0b __ BCS $25bb ; (check_room_axis_alignment.s1014 + 0)
.s1008:
; 727, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
25b0 : 85 1c __ STA ACCU + 1 
25b2 : a5 1b __ LDA ACCU + 0 
25b4 : c5 1c __ CMP ACCU + 1 
25b6 : a9 00 __ LDA #$00
25b8 : 2a __ __ ROL
25b9 : 49 01 __ EOR #$01
.s1014:
25bb : a0 00 __ LDY #$00
25bd : 91 0f __ STA (P2),y ; (has_horizontal_overlap + 0)
; 730, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
25bf : a0 02 __ LDY #$02
25c1 : b1 43 __ LDA (T1 + 0),y 
25c3 : 85 1c __ STA ACCU + 1 
25c5 : a0 00 __ LDY #$00
25c7 : b1 43 __ LDA (T1 + 0),y 
25c9 : aa __ __ TAX
25ca : 18 __ __ CLC
25cb : 65 1c __ ADC ACCU + 1 
25cd : 85 43 __ STA T1 + 0 
25cf : b1 45 __ LDA (T3 + 0),y 
25d1 : b0 08 __ BCS $25db ; (check_room_axis_alignment.s8 + 0)
.s1005:
; 730, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
25d3 : c5 43 __ CMP T1 + 0 
25d5 : 90 04 __ BCC $25db ; (check_room_axis_alignment.s8 + 0)
.s6:
25d7 : 98 __ __ TYA
.s1001:
25d8 : 91 11 __ STA (P4),y ; (has_vertical_overlap + 0)
; 731, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
25da : 60 __ __ RTS
.s8:
; 730, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
25db : 18 __ __ CLC
25dc : a0 02 __ LDY #$02
25de : 71 45 __ ADC (T3 + 0),y 
25e0 : 90 04 __ BCC $25e6 ; (check_room_axis_alignment.s1002 + 0)
.s5:
; 731, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
25e2 : a9 01 __ LDA #$01
25e4 : b0 09 __ BCS $25ef ; (check_room_axis_alignment.s1017 + 0)
.s1002:
; 730, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
25e6 : 85 43 __ STA T1 + 0 
25e8 : e4 43 __ CPX T1 + 0 
25ea : a9 00 __ LDA #$00
25ec : 2a __ __ ROL
25ed : 49 01 __ EOR #$01
.s1017:
25ef : a0 00 __ LDY #$00
25f1 : f0 e5 __ BEQ $25d8 ; (check_room_axis_alignment.s1001 + 0)
--------------------------------------------------------------------
path_intersects_other_rooms: ; path_intersects_other_rooms(u8,u8,u8,u8,u8,u8)->u8
.s0:
; 233, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
25f3 : a9 00 __ LDA #$00
25f5 : 8d eb 9f STA $9feb ; (i + 0)
; 227, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
25f8 : a5 0e __ LDA P1 ; (start_y + 0)
25fa : 85 43 __ STA T6 + 0 
25fc : a5 10 __ LDA P3 ; (end_y + 0)
25fe : 85 44 __ STA T7 + 0 
2600 : a5 11 __ LDA P4 ; (source_room + 0)
2602 : 85 45 __ STA T8 + 0 
2604 : ad de 3f LDA $3fde ; (room_count + 0)
2607 : 85 46 __ STA T9 + 0 
2609 : a5 0d __ LDA P0 ; (start_x + 0)
260b : 85 47 __ STA T11 + 0 
260d : c5 0f __ CMP P2 ; (end_x + 0)
260f : a6 0f __ LDX P2 ; (end_x + 0)
2611 : 86 48 __ STX T12 + 0 
2613 : 90 01 __ BCC $2616 ; (path_intersects_other_rooms.s49 + 0)
.s50:
2615 : 8a __ __ TXA
.s49:
2616 : 85 49 __ STA T13 + 0 
2618 : 8d ea 9f STA $9fea ; (entropy2 + 1)
; 228, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
261b : 8a __ __ TXA
261c : e4 0d __ CPX P0 ; (start_x + 0)
261e : b0 02 __ BCS $2622 ; (path_intersects_other_rooms.s53 + 0)
.s52:
; 228, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2620 : a5 0d __ LDA P0 ; (start_x + 0)
.s53:
2622 : 85 4a __ STA T14 + 0 
2624 : 8d e9 9f STA $9fe9 ; (connected + 1)
; 229, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2627 : a5 0e __ LDA P1 ; (start_y + 0)
2629 : c5 10 __ CMP P3 ; (end_y + 0)
262b : 90 02 __ BCC $262f ; (path_intersects_other_rooms.s55 + 0)
.s56:
; 229, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
262d : a5 10 __ LDA P3 ; (end_y + 0)
.s55:
262f : 85 4b __ STA T15 + 0 
2631 : 8d e8 9f STA $9fe8 ; (entropy3 + 1)
; 230, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2634 : a5 10 __ LDA P3 ; (end_y + 0)
2636 : c5 0e __ CMP P1 ; (start_y + 0)
2638 : b0 02 __ BCS $263c ; (path_intersects_other_rooms.s59 + 0)
.s58:
; 230, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
263a : a5 0e __ LDA P1 ; (start_y + 0)
.s59:
263c : 85 4c __ STA T16 + 0 
263e : 8d e7 9f STA $9fe7 ; (idx + 0)
; 233, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2641 : a5 46 __ LDA T9 + 0 
2643 : f0 19 __ BEQ $265e ; (path_intersects_other_rooms.s16 + 0)
.l14:
; 234, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2645 : ad eb 9f LDA $9feb ; (i + 0)
2648 : 85 4d __ STA T17 + 0 
264a : c5 45 __ CMP T8 + 0 
264c : f0 04 __ BEQ $2652 ; (path_intersects_other_rooms.s15 + 0)
.s20:
264e : c5 12 __ CMP P5 ; (dest_room + 0)
2650 : d0 11 __ BNE $2663 ; (path_intersects_other_rooms.s19 + 0)
.s15:
; 233, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2652 : 18 __ __ CLC
2653 : a5 4d __ LDA T17 + 0 
2655 : 69 01 __ ADC #$01
2657 : 8d eb 9f STA $9feb ; (i + 0)
265a : c5 46 __ CMP T9 + 0 
265c : 90 e7 __ BCC $2645 ; (path_intersects_other_rooms.l14 + 0)
.s16:
; 259, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
265e : a9 00 __ LDA #$00
.s1001:
2660 : 85 1b __ STA ACCU + 0 
2662 : 60 __ __ RTS
.s19:
; 237, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2663 : 0a __ __ ASL
2664 : 0a __ __ ASL
2665 : 0a __ __ ASL
2666 : a8 __ __ TAY
2667 : b9 00 4c LDA $4c00,y ; (rooms + 0)
266a : 85 1b __ STA ACCU + 0 
266c : 8d e6 9f STA $9fe6 ; (screen_pos + 1)
; 238, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
266f : b9 01 4c LDA $4c01,y ; (rooms + 1)
2672 : 8d e5 9f STA $9fe5 ; (leg1_end_x + 0)
; 239, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2675 : b9 02 4c LDA $4c02,y ; (rooms + 2)
2678 : 8d e4 9f STA $9fe4 ; (random_offset_x + 0)
; 240, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
267b : b9 03 4c LDA $4c03,y ; (rooms + 3)
267e : 8d e3 9f STA $9fe3 ; (screen_offset + 1)
; 243, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2681 : b9 00 4c LDA $4c00,y ; (rooms + 0)
2684 : f0 05 __ BEQ $268b ; (path_intersects_other_rooms.s62 + 0)
.s61:
2686 : 38 __ __ SEC
2687 : a5 1b __ LDA ACCU + 0 
2689 : e9 01 __ SBC #$01
.s62:
268b : 8d e2 9f STA $9fe2 ; (best_distance + 0)
; 244, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
268e : b9 02 4c LDA $4c02,y ; (rooms + 2)
2691 : 49 ff __ EOR #$ff
2693 : 38 __ __ SEC
2694 : e9 01 __ SBC #$01
2696 : 90 06 __ BCC $269e ; (path_intersects_other_rooms.s65 + 0)
.s1006:
; 244, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2698 : c5 1b __ CMP ACCU + 0 
269a : 90 02 __ BCC $269e ; (path_intersects_other_rooms.s65 + 0)
.s1013:
269c : d0 04 __ BNE $26a2 ; (path_intersects_other_rooms.s64 + 0)
.s65:
269e : a9 ff __ LDA #$ff
26a0 : d0 05 __ BNE $26a7 ; (path_intersects_other_rooms.s66 + 0)
.s64:
; 244, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
26a2 : b9 02 4c LDA $4c02,y ; (rooms + 2)
26a5 : 65 1b __ ADC ACCU + 0 
.s66:
26a7 : 8d e1 9f STA $9fe1 ; (r1 + 0)
; 245, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
26aa : b9 01 4c LDA $4c01,y ; (rooms + 1)
26ad : f0 03 __ BEQ $26b2 ; (path_intersects_other_rooms.s68 + 0)
.s67:
26af : 38 __ __ SEC
26b0 : e9 01 __ SBC #$01
.s68:
26b2 : 8d e0 9f STA $9fe0 ; (y + 0)
; 246, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
26b5 : b9 03 4c LDA $4c03,y ; (rooms + 3)
26b8 : 49 ff __ EOR #$ff
26ba : 38 __ __ SEC
26bb : e9 01 __ SBC #$01
26bd : 90 07 __ BCC $26c6 ; (path_intersects_other_rooms.s71 + 0)
.s1002:
; 246, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
26bf : d9 01 4c CMP $4c01,y ; (rooms + 1)
26c2 : 90 02 __ BCC $26c6 ; (path_intersects_other_rooms.s71 + 0)
.s1012:
26c4 : d0 04 __ BNE $26ca ; (path_intersects_other_rooms.s70 + 0)
.s71:
26c6 : a9 ff __ LDA #$ff
26c8 : d0 06 __ BNE $26d0 ; (path_intersects_other_rooms.s72 + 0)
.s70:
; 246, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
26ca : b9 03 4c LDA $4c03,y ; (rooms + 3)
26cd : 79 01 4c ADC $4c01,y ; (rooms + 1)
.s72:
26d0 : 8d df 9f STA $9fdf ; (leg_length + 0)
; 249, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
26d3 : a5 4a __ LDA T14 + 0 
26d5 : cd e2 9f CMP $9fe2 ; (best_distance + 0)
26d8 : b0 03 __ BCS $26dd ; (path_intersects_other_rooms.s27 + 0)
26da : 4c 52 26 JMP $2652 ; (path_intersects_other_rooms.s15 + 0)
.s27:
26dd : ad e1 9f LDA $9fe1 ; (r1 + 0)
26e0 : c5 49 __ CMP T13 + 0 
26e2 : 90 f6 __ BCC $26da ; (path_intersects_other_rooms.s72 + 10)
.s26:
; 250, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
26e4 : a5 4c __ LDA T16 + 0 
26e6 : cd e0 9f CMP $9fe0 ; (y + 0)
26e9 : 90 ef __ BCC $26da ; (path_intersects_other_rooms.s72 + 10)
.s25:
26eb : ad df 9f LDA $9fdf ; (leg_length + 0)
26ee : c5 4b __ CMP T15 + 0 
26f0 : 90 e8 __ BCC $26da ; (path_intersects_other_rooms.s72 + 10)
.s22:
; 253, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
26f2 : a5 47 __ LDA T11 + 0 
26f4 : 85 0d __ STA P0 ; (start_x + 0)
26f6 : a5 43 __ LDA T6 + 0 
26f8 : 85 0e __ STA P1 ; (start_y + 0)
26fa : a5 48 __ LDA T12 + 0 
26fc : 85 0f __ STA P2 ; (end_x + 0)
26fe : a5 44 __ LDA T7 + 0 
2700 : 85 10 __ STA P3 ; (end_y + 0)
2702 : a5 4d __ LDA T17 + 0 
2704 : 85 11 __ STA P4 ; (source_room + 0)
2706 : 20 11 27 JSR $2711 ; (detailed_path_room_intersection.s0 + 0)
2709 : aa __ __ TAX
270a : f0 ce __ BEQ $26da ; (path_intersects_other_rooms.s72 + 10)
.s28:
; 254, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
270c : a9 01 __ LDA #$01
270e : 4c 60 26 JMP $2660 ; (path_intersects_other_rooms.s1001 + 0)
--------------------------------------------------------------------
detailed_path_room_intersection: ; detailed_path_room_intersection(u8,u8,u8,u8,u8)->u8
.s0:
; 184, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2711 : a5 0d __ LDA P0 ; (start_x + 0)
2713 : 8d f1 9f STA $9ff1 ; (r1 + 1)
; 185, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2716 : a5 0e __ LDA P1 ; (start_y + 0)
2718 : 8d f0 9f STA $9ff0 ; (r1 + 0)
.l1:
; 187, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
271b : ad f1 9f LDA $9ff1 ; (r1 + 1)
271e : 29 80 __ AND #$80
2720 : 10 02 __ BPL $2724 ; (detailed_path_room_intersection.l1 + 9)
2722 : a9 ff __ LDA #$ff
2724 : 85 1c __ STA ACCU + 1 
2726 : d0 07 __ BNE $272f ; (detailed_path_room_intersection.s1002 + 0)
.s1005:
2728 : a5 0f __ LDA P2 ; (end_x + 0)
272a : cd f1 9f CMP $9ff1 ; (r1 + 1)
272d : f0 04 __ BEQ $2733 ; (detailed_path_room_intersection.s1003 + 0)
.s1002:
272f : a2 01 __ LDX #$01
2731 : d0 0d __ BNE $2740 ; (detailed_path_room_intersection.s2 + 0)
.s1003:
2733 : a2 00 __ LDX #$00
2735 : ad f0 9f LDA $9ff0 ; (r1 + 0)
2738 : 30 06 __ BMI $2740 ; (detailed_path_room_intersection.s2 + 0)
.s1040:
273a : c5 10 __ CMP P3 ; (end_y + 0)
273c : d0 02 __ BNE $2740 ; (detailed_path_room_intersection.s2 + 0)
.s3:
273e : 8a __ __ TXA
273f : 60 __ __ RTS
.s2:
; 189, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2740 : a0 00 __ LDY #$00
2742 : 2c f0 9f BIT $9ff0 ; (r1 + 0)
2745 : 10 01 __ BPL $2748 ; (detailed_path_room_intersection.s1044 + 0)
.s1043:
; 192, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2747 : 88 __ __ DEY
.s1044:
; 189, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2748 : a5 1c __ LDA ACCU + 1 
274a : 30 09 __ BMI $2755 ; (detailed_path_room_intersection.s5 + 0)
.s1039:
; 189, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
274c : d0 13 __ BNE $2761 ; (detailed_path_room_intersection.s6 + 0)
.s1036:
274e : ad f1 9f LDA $9ff1 ; (r1 + 1)
2751 : c5 0f __ CMP P2 ; (end_x + 0)
2753 : b0 0c __ BCS $2761 ; (detailed_path_room_intersection.s6 + 0)
.s5:
2755 : ad f1 9f LDA $9ff1 ; (r1 + 1)
2758 : 18 __ __ CLC
2759 : 69 01 __ ADC #$01
.s66:
; 190, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
275b : 8d f1 9f STA $9ff1 ; (r1 + 1)
275e : 4c 6d 27 JMP $276d ; (detailed_path_room_intersection.s7 + 0)
.s6:
; 190, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2761 : 8a __ __ TXA
2762 : f0 09 __ BEQ $276d ; (detailed_path_room_intersection.s7 + 0)
.s8:
2764 : ad f1 9f LDA $9ff1 ; (r1 + 1)
2767 : 18 __ __ CLC
2768 : 69 ff __ ADC #$ff
276a : 8d f1 9f STA $9ff1 ; (r1 + 1)
.s7:
; 192, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
276d : 98 __ __ TYA
276e : 30 09 __ BMI $2779 ; (detailed_path_room_intersection.s11 + 0)
.s1035:
2770 : d0 13 __ BNE $2785 ; (detailed_path_room_intersection.s12 + 0)
.s1032:
2772 : ad f0 9f LDA $9ff0 ; (r1 + 0)
2775 : c5 10 __ CMP P3 ; (end_y + 0)
2777 : b0 0c __ BCS $2785 ; (detailed_path_room_intersection.s12 + 0)
.s11:
2779 : ad f0 9f LDA $9ff0 ; (r1 + 0)
277c : 18 __ __ CLC
277d : 69 01 __ ADC #$01
.s67:
; 193, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
277f : 8d f0 9f STA $9ff0 ; (r1 + 0)
2782 : 4c 94 27 JMP $2794 ; (detailed_path_room_intersection.s13 + 0)
.s12:
; 193, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2785 : a5 10 __ LDA P3 ; (end_y + 0)
2787 : cd f0 9f CMP $9ff0 ; (r1 + 0)
278a : b0 08 __ BCS $2794 ; (detailed_path_room_intersection.s13 + 0)
.s14:
278c : ad f0 9f LDA $9ff0 ; (r1 + 0)
278f : 69 ff __ ADC #$ff
2791 : 8d f0 9f STA $9ff0 ; (r1 + 0)
.s13:
; 196, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2794 : a5 11 __ LDA P4 ; (room_index + 0)
2796 : 0a __ __ ASL
2797 : 0a __ __ ASL
2798 : 0a __ __ ASL
2799 : aa __ __ TAX
279a : bd 00 4c LDA $4c00,x ; (rooms + 0)
279d : f0 02 __ BEQ $27a1 ; (detailed_path_room_intersection.s33 + 0)
.s32:
279f : e9 00 __ SBC #$00
.s33:
27a1 : 8d ef 9f STA $9fef ; (byte_ptr + 1)
; 197, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
27a4 : bd 02 4c LDA $4c02,x ; (rooms + 2)
27a7 : 49 ff __ EOR #$ff
27a9 : 38 __ __ SEC
27aa : e9 01 __ SBC #$01
27ac : 90 07 __ BCC $27b5 ; (detailed_path_room_intersection.s36 + 0)
.s1028:
; 197, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
27ae : dd 00 4c CMP $4c00,x ; (rooms + 0)
27b1 : 90 02 __ BCC $27b5 ; (detailed_path_room_intersection.s36 + 0)
.s1046:
27b3 : d0 04 __ BNE $27b9 ; (detailed_path_room_intersection.s35 + 0)
.s36:
27b5 : a9 ff __ LDA #$ff
27b7 : d0 06 __ BNE $27bf ; (detailed_path_room_intersection.s37 + 0)
.s35:
; 198, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
27b9 : bd 02 4c LDA $4c02,x ; (rooms + 2)
27bc : 7d 00 4c ADC $4c00,x ; (rooms + 0)
.s37:
; 197, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
27bf : 8d ee 9f STA $9fee ; (result + 0)
; 199, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
27c2 : bd 01 4c LDA $4c01,x ; (rooms + 1)
27c5 : f0 03 __ BEQ $27ca ; (detailed_path_room_intersection.s39 + 0)
.s38:
27c7 : 38 __ __ SEC
27c8 : e9 01 __ SBC #$01
.s39:
27ca : 8d ed 9f STA $9fed ; (s + 1)
; 200, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
27cd : bd 03 4c LDA $4c03,x ; (rooms + 3)
27d0 : 49 ff __ EOR #$ff
27d2 : 38 __ __ SEC
27d3 : e9 01 __ SBC #$01
27d5 : 90 07 __ BCC $27de ; (detailed_path_room_intersection.s42 + 0)
.s1024:
; 200, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
27d7 : dd 01 4c CMP $4c01,x ; (rooms + 1)
27da : 90 02 __ BCC $27de ; (detailed_path_room_intersection.s42 + 0)
.s1045:
27dc : d0 04 __ BNE $27e2 ; (detailed_path_room_intersection.s41 + 0)
.s42:
27de : a9 ff __ LDA #$ff
27e0 : d0 06 __ BNE $27e8 ; (detailed_path_room_intersection.s43 + 0)
.s41:
; 201, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
27e2 : bd 03 4c LDA $4c03,x ; (rooms + 3)
27e5 : 7d 01 4c ADC $4c01,x ; (rooms + 1)
.s43:
; 200, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
27e8 : 8d ec 9f STA $9fec ; (entropy1 + 1)
; 203, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
27eb : ad f1 9f LDA $9ff1 ; (r1 + 1)
27ee : 29 80 __ AND #$80
27f0 : 10 02 __ BPL $27f4 ; (detailed_path_room_intersection.s43 + 12)
27f2 : a9 ff __ LDA #$ff
27f4 : 10 03 __ BPL $27f9 ; (detailed_path_room_intersection.s1023 + 0)
27f6 : 4c 1b 27 JMP $271b ; (detailed_path_room_intersection.l1 + 0)
.s1023:
27f9 : a8 __ __ TAY
27fa : aa __ __ TAX
27fb : d0 08 __ BNE $2805 ; (detailed_path_room_intersection.s22 + 0)
.s1020:
27fd : ad f1 9f LDA $9ff1 ; (r1 + 1)
2800 : cd ef 9f CMP $9fef ; (byte_ptr + 1)
2803 : 90 f1 __ BCC $27f6 ; (detailed_path_room_intersection.s43 + 14)
.s22:
2805 : 98 __ __ TYA
2806 : d0 ee __ BNE $27f6 ; (detailed_path_room_intersection.s43 + 14)
.s1016:
2808 : ad ee 9f LDA $9fee ; (result + 0)
280b : cd f1 9f CMP $9ff1 ; (r1 + 1)
280e : 90 e6 __ BCC $27f6 ; (detailed_path_room_intersection.s43 + 14)
.s21:
; 204, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2810 : ad f0 9f LDA $9ff0 ; (r1 + 0)
2813 : 29 80 __ AND #$80
2815 : 10 02 __ BPL $2819 ; (detailed_path_room_intersection.s21 + 9)
2817 : a9 ff __ LDA #$ff
2819 : 30 db __ BMI $27f6 ; (detailed_path_room_intersection.s43 + 14)
.s1015:
281b : a8 __ __ TAY
281c : aa __ __ TAX
281d : d0 08 __ BNE $2827 ; (detailed_path_room_intersection.s20 + 0)
.s1012:
281f : ad f0 9f LDA $9ff0 ; (r1 + 0)
2822 : cd ed 9f CMP $9fed ; (s + 1)
2825 : 90 cf __ BCC $27f6 ; (detailed_path_room_intersection.s43 + 14)
.s20:
2827 : 98 __ __ TYA
2828 : d0 cc __ BNE $27f6 ; (detailed_path_room_intersection.s43 + 14)
.s1008:
282a : ad ec 9f LDA $9fec ; (entropy1 + 1)
282d : cd f0 9f CMP $9ff0 ; (r1 + 0)
2830 : 90 c4 __ BCC $27f6 ; (detailed_path_room_intersection.s43 + 14)
.s17:
; 205, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2832 : a9 01 __ LDA #$01
.s1001:
; 208, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2834 : 60 __ __ RTS
--------------------------------------------------------------------
draw_straight_corridor: ; draw_straight_corridor(u8,u8,u8,u8)->u8
.s0:
; 955, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2835 : a5 18 __ LDA P11 ; (exit1_y + 0)
2837 : 8d e6 9f STA $9fe6 ; (screen_pos + 1)
; 954, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
283a : ad f2 9f LDA $9ff2 ; (sstack + 0)
283d : 85 4a __ STA T5 + 0 
283f : a5 17 __ LDA P10 ; (exit1_x + 0)
2841 : 8d e7 9f STA $9fe7 ; (idx + 0)
; 958, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2844 : c5 4a __ CMP T5 + 0 
2846 : f0 0c __ BEQ $2854 ; (draw_straight_corridor.l6 + 0)
.s4:
2848 : a5 18 __ LDA P11 ; (exit1_y + 0)
284a : cd f3 9f CMP $9ff3 ; (sstack + 1)
284d : f0 05 __ BEQ $2854 ; (draw_straight_corridor.l6 + 0)
.s1:
; 959, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
284f : a9 00 __ LDA #$00
.s1001:
; 982, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2851 : 85 1b __ STA ACCU + 0 
2853 : 60 __ __ RTS
.l6:
; 963, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2854 : ad e7 9f LDA $9fe7 ; (idx + 0)
2857 : 85 4b __ STA T6 + 0 
2859 : 85 48 __ STA T2 + 0 
285b : 29 80 __ AND #$80
285d : 10 02 __ BPL $2861 ; (draw_straight_corridor.l6 + 13)
285f : a9 ff __ LDA #$ff
2861 : 85 49 __ STA T2 + 1 
2863 : d0 14 __ BNE $2879 ; (draw_straight_corridor.s7 + 0)
.s1013:
2865 : a5 48 __ LDA T2 + 0 
2867 : c5 4a __ CMP T5 + 0 
2869 : d0 0e __ BNE $2879 ; (draw_straight_corridor.s7 + 0)
.s9:
286b : ad e6 9f LDA $9fe6 ; (screen_pos + 1)
286e : 30 09 __ BMI $2879 ; (draw_straight_corridor.s7 + 0)
.s1010:
2870 : cd f3 9f CMP $9ff3 ; (sstack + 1)
2873 : d0 04 __ BNE $2879 ; (draw_straight_corridor.s7 + 0)
.s8:
; 982, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2875 : a9 01 __ LDA #$01
2877 : d0 d8 __ BNE $2851 ; (draw_straight_corridor.s1001 + 0)
.s7:
; 965, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2879 : a5 4b __ LDA T6 + 0 
287b : 85 15 __ STA P8 
287d : ad e6 9f LDA $9fe6 ; (screen_pos + 1)
2880 : 85 4c __ STA T7 + 0 
2882 : 85 16 __ STA P9 
2884 : 20 fb 28 JSR $28fb ; (can_place_corridor.s0 + 0)
2887 : aa __ __ TAX
2888 : f0 24 __ BEQ $28ae ; (draw_straight_corridor.s12 + 0)
.s10:
; 966, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
288a : a5 4b __ LDA T6 + 0 
288c : 85 10 __ STA P3 
288e : a5 4c __ LDA T7 + 0 
2890 : 85 11 __ STA P4 
2892 : a9 02 __ LDA #$02
2894 : 85 12 __ STA P5 
2896 : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
; 967, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2899 : ae a8 52 LDX $52a8 ; (corridor_path_static + 40)
289c : e0 14 __ CPX #$14
289e : b0 0e __ BCS $28ae ; (draw_straight_corridor.s12 + 0)
.s13:
; 968, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
28a0 : a5 4b __ LDA T6 + 0 
28a2 : 9d 80 52 STA $5280,x ; (corridor_path_static + 0)
; 969, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
28a5 : a5 4c __ LDA T7 + 0 
28a7 : 9d 94 52 STA $5294,x ; (corridor_path_static + 20)
; 970, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
28aa : e8 __ __ INX
28ab : 8e a8 52 STX $52a8 ; (corridor_path_static + 40)
.s12:
; 975, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
28ae : a0 00 __ LDY #$00
28b0 : 24 4c __ BIT T7 + 0 
28b2 : 10 01 __ BPL $28b5 ; (draw_straight_corridor.s1018 + 0)
.s1017:
; 978, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
28b4 : 88 __ __ DEY
.s1018:
; 975, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
28b5 : a5 49 __ LDA T2 + 1 
28b7 : 30 08 __ BMI $28c1 ; (draw_straight_corridor.s16 + 0)
.s1009:
; 975, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
28b9 : d0 11 __ BNE $28cc ; (draw_straight_corridor.s17 + 0)
.s1006:
28bb : a5 48 __ LDA T2 + 0 
28bd : c5 4a __ CMP T5 + 0 
28bf : b0 0b __ BCS $28cc ; (draw_straight_corridor.s17 + 0)
.s16:
28c1 : a9 01 __ LDA #$01
.s66:
; 976, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
28c3 : 18 __ __ CLC
28c4 : 65 48 __ ADC T2 + 0 
28c6 : 8d e7 9f STA $9fe7 ; (idx + 0)
28c9 : 4c d6 28 JMP $28d6 ; (draw_straight_corridor.s18 + 0)
.s17:
; 976, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
28cc : a5 4a __ LDA T5 + 0 
28ce : c5 48 __ CMP T2 + 0 
28d0 : b0 04 __ BCS $28d6 ; (draw_straight_corridor.s18 + 0)
.s19:
28d2 : a9 ff __ LDA #$ff
28d4 : 90 ed __ BCC $28c3 ; (draw_straight_corridor.s66 + 0)
.s18:
; 978, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
28d6 : 98 __ __ TYA
28d7 : 30 1e __ BMI $28f7 ; (draw_straight_corridor.s22 + 0)
.s1005:
28d9 : d0 07 __ BNE $28e2 ; (draw_straight_corridor.s23 + 0)
.s1002:
28db : a5 4c __ LDA T7 + 0 
28dd : cd f3 9f CMP $9ff3 ; (sstack + 1)
28e0 : 90 15 __ BCC $28f7 ; (draw_straight_corridor.s22 + 0)
.s23:
; 979, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
28e2 : ad f3 9f LDA $9ff3 ; (sstack + 1)
28e5 : c5 16 __ CMP P9 
28e7 : 90 03 __ BCC $28ec ; (draw_straight_corridor.s25 + 0)
28e9 : 4c 54 28 JMP $2854 ; (draw_straight_corridor.l6 + 0)
.s25:
28ec : a9 ff __ LDA #$ff
.s56:
28ee : 18 __ __ CLC
28ef : 65 16 __ ADC P9 
28f1 : 8d e6 9f STA $9fe6 ; (screen_pos + 1)
28f4 : 4c 54 28 JMP $2854 ; (draw_straight_corridor.l6 + 0)
.s22:
; 978, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
28f7 : a9 01 __ LDA #$01
28f9 : d0 f3 __ BNE $28ee ; (draw_straight_corridor.s56 + 0)
--------------------------------------------------------------------
can_place_corridor: ; can_place_corridor(u8,u8)->u8
.s0:
; 310, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
28fb : a5 15 __ LDA P8 ; (x + 0)
28fd : 85 0d __ STA P0 
28ff : a5 16 __ LDA P9 ; (y + 0)
2901 : 85 0e __ STA P1 
2903 : 20 1a 29 JSR $291a ; (is_within_map_bounds.s0 + 0)
2906 : aa __ __ TAX
2907 : f0 10 __ BEQ $2919 ; (can_place_corridor.s1001 + 0)
.s3:
; 311, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2909 : a5 15 __ LDA P8 ; (x + 0)
290b : 85 13 __ STA P6 
290d : a5 16 __ LDA P9 ; (y + 0)
290f : 85 14 __ STA P7 
2911 : 20 2d 29 JSR $292d ; (is_outside_any_room.s0 + 0)
2914 : aa __ __ TAX
2915 : f0 02 __ BEQ $2919 ; (can_place_corridor.s1001 + 0)
.s7:
; 313, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2917 : a9 01 __ LDA #$01
.s1001:
; 310, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2919 : 60 __ __ RTS
--------------------------------------------------------------------
is_within_map_bounds: ; is_within_map_bounds(u8,u8)->u8
.s0:
; 403, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
291a : a5 0d __ LDA P0 ; (x + 0)
291c : c9 40 __ CMP #$40
291e : b0 0a __ BCS $292a ; (is_within_map_bounds.s2 + 0)
.s4:
2920 : a5 0e __ LDA P1 ; (y + 0)
2922 : c9 40 __ CMP #$40
2924 : a9 00 __ LDA #$00
2926 : 2a __ __ ROL
2927 : 49 01 __ EOR #$01
2929 : 60 __ __ RTS
.s2:
; 403, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
292a : a9 00 __ LDA #$00
.s1001:
292c : 60 __ __ RTS
--------------------------------------------------------------------
is_outside_any_room: ; is_outside_any_room(u8,u8)->u8
.s0:
; 471, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
292d : a5 13 __ LDA P6 ; (x + 0)
292f : 85 11 __ STA P4 
2931 : a5 14 __ LDA P7 ; (y + 0)
2933 : 85 12 __ STA P5 
2935 : 20 3e 29 JSR $293e ; (is_inside_any_room.s0 + 0)
2938 : a9 00 __ LDA #$00
293a : c5 1b __ CMP ACCU + 0 
293c : 2a __ __ ROL
.s1001:
293d : 60 __ __ RTS
--------------------------------------------------------------------
is_inside_any_room: ; is_inside_any_room(u8,u8)->u8
.s0:
; 431, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
293e : a9 00 __ LDA #$00
2940 : 8d ed 9f STA $9fed ; (s + 1)
2943 : ad de 3f LDA $3fde ; (room_count + 0)
2946 : 85 45 __ STA T1 + 0 
2948 : f0 22 __ BEQ $296c ; (is_inside_any_room.s4 + 0)
.l2:
; 432, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
294a : a5 11 __ LDA P4 ; (x + 0)
294c : 85 0e __ STA P1 
294e : a5 12 __ LDA P5 ; (y + 0)
2950 : 85 0f __ STA P2 
2952 : ad ed 9f LDA $9fed ; (s + 1)
2955 : 85 46 __ STA T4 + 0 
2957 : 85 10 __ STA P3 
2959 : 20 75 29 JSR $2975 ; (point_in_room.s0 + 0)
295c : a5 1b __ LDA ACCU + 0 
295e : d0 11 __ BNE $2971 ; (is_inside_any_room.s5 + 0)
.s3:
; 431, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2960 : 18 __ __ CLC
2961 : a5 46 __ LDA T4 + 0 
2963 : 69 01 __ ADC #$01
2965 : 8d ed 9f STA $9fed ; (s + 1)
2968 : c5 45 __ CMP T1 + 0 
296a : 90 de __ BCC $294a ; (is_inside_any_room.l2 + 0)
.s4:
; 436, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
296c : a9 00 __ LDA #$00
.s1001:
296e : 85 1b __ STA ACCU + 0 
2970 : 60 __ __ RTS
.s5:
; 433, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2971 : a9 01 __ LDA #$01
2973 : d0 f9 __ BNE $296e ; (is_inside_any_room.s1001 + 0)
--------------------------------------------------------------------
point_in_room: ; point_in_room(u8,u8,u8)->u8
.s0:
; 417, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2975 : a5 10 __ LDA P3 ; (room_id + 0)
2977 : cd de 3f CMP $3fde ; (room_count + 0)
297a : b0 47 __ BCS $29c3 ; (point_in_room.s1010 + 0)
.s3:
; 419, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
297c : 85 0d __ STA P0 
297e : 0a __ __ ASL
297f : 0a __ __ ASL
2980 : 0a __ __ ASL
2981 : 18 __ __ CLC
2982 : 69 00 __ ADC #$00
2984 : 85 43 __ STA T2 + 0 
2986 : 8d f0 9f STA $9ff0 ; (r1 + 0)
2989 : a9 4c __ LDA #$4c
298b : 69 00 __ ADC #$00
298d : 85 44 __ STA T2 + 1 
298f : 8d f1 9f STA $9ff1 ; (r1 + 1)
; 420, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
2992 : a5 0d __ LDA P0 
2994 : 20 e0 29 JSR $29e0 ; (get_room_right_edge.s0 + 0)
2997 : 8d ef 9f STA $9fef ; (byte_ptr + 1)
; 421, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
299a : a5 0d __ LDA P0 
299c : 20 f7 29 JSR $29f7 ; (get_room_bottom_edge.s0 + 0)
299f : 8d ee 9f STA $9fee ; (result + 0)
; 425, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
29a2 : a0 00 __ LDY #$00
29a4 : b1 43 __ LDA (T2 + 0),y 
29a6 : c5 0e __ CMP P1 ; (x + 0)
29a8 : 90 02 __ BCC $29ac ; (point_in_room.s10 + 0)
.s1011:
29aa : d0 17 __ BNE $29c3 ; (point_in_room.s1010 + 0)
.s10:
29ac : 18 __ __ CLC
29ad : a0 02 __ LDY #$02
29af : 71 43 __ ADC (T2 + 0),y 
29b1 : b0 06 __ BCS $29b9 ; (point_in_room.s9 + 0)
.s1005:
29b3 : c5 0e __ CMP P1 ; (x + 0)
29b5 : 90 0c __ BCC $29c3 ; (point_in_room.s1010 + 0)
.s1013:
29b7 : f0 0a __ BEQ $29c3 ; (point_in_room.s1010 + 0)
.s9:
; 426, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
29b9 : a0 01 __ LDY #$01
29bb : b1 43 __ LDA (T2 + 0),y 
29bd : c5 0f __ CMP P2 ; (y + 0)
29bf : 90 07 __ BCC $29c8 ; (point_in_room.s8 + 0)
.s1012:
29c1 : f0 05 __ BEQ $29c8 ; (point_in_room.s8 + 0)
.s1010:
29c3 : a9 00 __ LDA #$00
.s1001:
; 425, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
29c5 : 85 1b __ STA ACCU + 0 
29c7 : 60 __ __ RTS
.s8:
; 426, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
29c8 : 18 __ __ CLC
29c9 : a0 03 __ LDY #$03
29cb : 71 43 __ ADC (T2 + 0),y 
29cd : 90 04 __ BCC $29d3 ; (point_in_room.s1002 + 0)
.s5:
29cf : a9 01 __ LDA #$01
29d1 : b0 f2 __ BCS $29c5 ; (point_in_room.s1001 + 0)
.s1002:
; 426, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
29d3 : 85 1b __ STA ACCU + 0 
29d5 : a5 0f __ LDA P2 ; (y + 0)
29d7 : c5 1b __ CMP ACCU + 0 
29d9 : a9 00 __ LDA #$00
29db : 2a __ __ ROL
29dc : 49 01 __ EOR #$01
29de : 90 e5 __ BCC $29c5 ; (point_in_room.s1001 + 0)
--------------------------------------------------------------------
get_room_right_edge: ; get_room_right_edge(u8)->u8
.s0:
; 764, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
29e0 : cd de 3f CMP $3fde ; (room_count + 0)
29e3 : 90 03 __ BCC $29e8 ; (get_room_right_edge.s3 + 0)
.s1:
29e5 : a9 00 __ LDA #$00
29e7 : 60 __ __ RTS
.s3:
; 765, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
29e8 : 0a __ __ ASL
29e9 : 0a __ __ ASL
29ea : 0a __ __ ASL
29eb : aa __ __ TAX
29ec : bd 00 4c LDA $4c00,x ; (rooms + 0)
29ef : 18 __ __ CLC
29f0 : 7d 02 4c ADC $4c02,x ; (rooms + 2)
29f3 : 38 __ __ SEC
29f4 : e9 01 __ SBC #$01
.s1001:
29f6 : 60 __ __ RTS
--------------------------------------------------------------------
get_room_bottom_edge: ; get_room_bottom_edge(u8)->u8
.s0:
; 770, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
29f7 : cd de 3f CMP $3fde ; (room_count + 0)
29fa : 90 03 __ BCC $29ff ; (get_room_bottom_edge.s3 + 0)
.s1:
29fc : a9 00 __ LDA #$00
29fe : 60 __ __ RTS
.s3:
; 771, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
29ff : 0a __ __ ASL
2a00 : 0a __ __ ASL
2a01 : 0a __ __ ASL
2a02 : aa __ __ TAX
2a03 : bd 01 4c LDA $4c01,x ; (rooms + 1)
2a06 : 18 __ __ CLC
2a07 : 7d 03 4c ADC $4c03,x ; (rooms + 3)
2a0a : 38 __ __ SEC
2a0b : e9 01 __ SBC #$01
.s1001:
2a0d : 60 __ __ RTS
--------------------------------------------------------------------
place_door: ; place_door(u8,u8)->void
.s0:
;1420, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2a0e : a5 13 __ LDA P6 ; (x + 0)
2a10 : 85 0f __ STA P2 
2a12 : a5 14 __ LDA P7 ; (y + 0)
2a14 : 85 10 __ STA P3 
2a16 : 20 a8 24 JSR $24a8 ; (tile_is_door.s0 + 0)
2a19 : a5 1b __ LDA ACCU + 0 
2a1b : d0 0f __ BNE $2a2c ; (place_door.s1001 + 0)
.s1:
;1421, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2a1d : a5 13 __ LDA P6 ; (x + 0)
2a1f : 85 10 __ STA P3 
2a21 : a5 14 __ LDA P7 ; (y + 0)
2a23 : 85 11 __ STA P4 
2a25 : a9 03 __ LDA #$03
2a27 : 85 12 __ STA P5 
2a29 : 4c f1 0f JMP $0ff1 ; (set_tile_raw.s0 + 0)
.s1001:
;1423, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2a2c : 60 __ __ RTS
--------------------------------------------------------------------
get_optimal_corridor_direction: ; get_optimal_corridor_direction(u8,u8)->u8
.s0:
; 863, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2a2d : c9 02 __ CMP #$02
2a2f : f0 04 __ BEQ $2a35 ; (get_optimal_corridor_direction.s1 + 0)
.s4:
2a31 : c9 03 __ CMP #$03
2a33 : d0 03 __ BNE $2a38 ; (get_optimal_corridor_direction.s2 + 0)
.s1:
; 865, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2a35 : a9 00 __ LDA #$00
2a37 : 60 __ __ RTS
.s2:
2a38 : a9 01 __ LDA #$01
.s1001:
; 868, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2a3a : 60 __ __ RTS
--------------------------------------------------------------------
z_path_avoids_rooms: ; z_path_avoids_rooms(u8,u8,u8,u8,u8,u8,u8)->u8
.s0:
;1004, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2a3b : a5 0f __ LDA P2 ; (exit2_x + 0)
2a3d : 85 51 __ STA T7 + 0 
2a3f : c5 0d __ CMP P0 ; (exit1_x + 0)
2a41 : 90 05 __ BCC $2a48 ; (z_path_avoids_rooms.s23 + 0)
.s24:
2a43 : e5 0d __ SBC P0 ; (exit1_x + 0)
2a45 : 4c 4d 2a JMP $2a4d ; (z_path_avoids_rooms.s25 + 0)
.s23:
;1004, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2a48 : 38 __ __ SEC
2a49 : a5 0d __ LDA P0 ; (exit1_x + 0)
2a4b : e5 0f __ SBC P2 ; (exit2_x + 0)
.s25:
2a4d : 8d da 9f STA $9fda ; (grid_positions + 12)
;1005, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2a50 : a5 10 __ LDA P3 ; (exit2_y + 0)
2a52 : 85 52 __ STA T8 + 0 
2a54 : c5 0e __ CMP P1 ; (exit1_y + 0)
2a56 : 90 05 __ BCC $2a5d ; (z_path_avoids_rooms.s26 + 0)
.s27:
2a58 : e5 0e __ SBC P1 ; (exit1_y + 0)
2a5a : 4c 62 2a JMP $2a62 ; (z_path_avoids_rooms.s28 + 0)
.s26:
;1005, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2a5d : 38 __ __ SEC
2a5e : a5 0e __ LDA P1 ; (exit1_y + 0)
2a60 : e5 10 __ SBC P3 ; (exit2_y + 0)
.s28:
2a62 : 8d d9 9f STA $9fd9 ; (grid_positions + 11)
;1007, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2a65 : a9 00 __ LDA #$00
2a67 : 85 1c __ STA ACCU + 1 
2a69 : 85 04 __ STA WORK + 1 
2a6b : a9 03 __ LDA #$03
2a6d : 85 03 __ STA WORK + 0 
2a6f : a5 11 __ LDA P4 ; (start_with_x + 0)
2a71 : f0 03 __ BEQ $2a76 ; (z_path_avoids_rooms.s2 + 0)
2a73 : 4c 02 2b JMP $2b02 ; (z_path_avoids_rooms.s1 + 0)
.s2:
;1022, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2a76 : ad d9 9f LDA $9fd9 ; (grid_positions + 11)
2a79 : 85 1b __ STA ACCU + 0 
2a7b : 20 38 3f JSR $3f38 ; (divmod + 0)
2a7e : a6 1b __ LDX ACCU + 0 
2a80 : e8 __ __ INX
2a81 : 8e d7 9f STX $9fd7 ; (grid_positions + 9)
;1024, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2a84 : a5 0e __ LDA P1 ; (exit1_y + 0)
2a86 : c5 10 __ CMP P3 ; (exit2_y + 0)
2a88 : 90 06 __ BCC $2a90 ; (z_path_avoids_rooms.s7 + 0)
.s8:
;1027, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2a8a : ed d7 9f SBC $9fd7 ; (grid_positions + 9)
2a8d : 4c 93 2a JMP $2a93 ; (z_path_avoids_rooms.s9 + 0)
.s7:
;1025, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2a90 : 6d d7 9f ADC $9fd7 ; (grid_positions + 9)
.s9:
;1027, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2a93 : 8d dd 9f STA $9fdd ; (grid_positions + 15)
;1031, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2a96 : 8d db 9f STA $9fdb ; (grid_positions + 13)
;1029, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2a99 : a5 0d __ LDA P0 ; (exit1_x + 0)
2a9b : 8d de 9f STA $9fde ; (pivot_x + 0)
;1030, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2a9e : a5 0f __ LDA P2 ; (exit2_x + 0)
2aa0 : 8d dc 9f STA $9fdc ; (grid_positions + 14)
.s3:
;1035, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2aa3 : ad de 9f LDA $9fde ; (pivot_x + 0)
2aa6 : 85 4e __ STA T1 + 0 
2aa8 : 85 0f __ STA P2 ; (exit2_x + 0)
2aaa : ad dd 9f LDA $9fdd ; (grid_positions + 15)
2aad : 85 4f __ STA T2 + 0 
2aaf : 85 10 __ STA P3 ; (exit2_y + 0)
2ab1 : a5 12 __ LDA P5 ; (source_room + 0)
2ab3 : 85 50 __ STA T3 + 0 
2ab5 : 85 11 __ STA P4 ; (start_with_x + 0)
2ab7 : a5 13 __ LDA P6 ; (dest_room + 0)
2ab9 : 85 12 __ STA P5 ; (source_room + 0)
2abb : 20 f3 25 JSR $25f3 ; (path_intersects_other_rooms.s0 + 0)
2abe : a5 1b __ LDA ACCU + 0 
2ac0 : d0 21 __ BNE $2ae3 ; (z_path_avoids_rooms.s10 + 0)
.s12:
;1039, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2ac2 : a5 4e __ LDA T1 + 0 
2ac4 : 85 0d __ STA P0 ; (exit1_x + 0)
2ac6 : a5 4f __ LDA T2 + 0 
2ac8 : 85 0e __ STA P1 ; (exit1_y + 0)
2aca : a5 50 __ LDA T3 + 0 
2acc : 85 11 __ STA P4 ; (start_with_x + 0)
2ace : ad dc 9f LDA $9fdc ; (grid_positions + 14)
2ad1 : 85 4e __ STA T1 + 0 
2ad3 : 85 0f __ STA P2 ; (exit2_x + 0)
2ad5 : ad db 9f LDA $9fdb ; (grid_positions + 13)
2ad8 : 85 4f __ STA T2 + 0 
2ada : 85 10 __ STA P3 ; (exit2_y + 0)
2adc : 20 f3 25 JSR $25f3 ; (path_intersects_other_rooms.s0 + 0)
2adf : a5 1b __ LDA ACCU + 0 
2ae1 : f0 04 __ BEQ $2ae7 ; (z_path_avoids_rooms.s16 + 0)
.s10:
;1036, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2ae3 : a9 00 __ LDA #$00
2ae5 : f0 18 __ BEQ $2aff ; (z_path_avoids_rooms.s1001 + 0)
.s16:
;1043, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2ae7 : a5 4e __ LDA T1 + 0 
2ae9 : 85 0d __ STA P0 ; (exit1_x + 0)
2aeb : a5 4f __ LDA T2 + 0 
2aed : 85 0e __ STA P1 ; (exit1_y + 0)
2aef : a5 51 __ LDA T7 + 0 
2af1 : 85 0f __ STA P2 ; (exit2_x + 0)
2af3 : a5 52 __ LDA T8 + 0 
2af5 : 85 10 __ STA P3 ; (exit2_y + 0)
2af7 : 20 f3 25 JSR $25f3 ; (path_intersects_other_rooms.s0 + 0)
2afa : a9 00 __ LDA #$00
2afc : c5 1b __ CMP ACCU + 0 
2afe : 2a __ __ ROL
.s1001:
;1047, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2aff : 85 1b __ STA ACCU + 0 
2b01 : 60 __ __ RTS
.s1:
;1009, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2b02 : ad da 9f LDA $9fda ; (grid_positions + 12)
2b05 : 85 1b __ STA ACCU + 0 
2b07 : 20 38 3f JSR $3f38 ; (divmod + 0)
2b0a : a6 1b __ LDX ACCU + 0 
2b0c : e8 __ __ INX
2b0d : 8e d8 9f STX $9fd8 ; (grid_positions + 10)
;1011, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2b10 : a5 0d __ LDA P0 ; (exit1_x + 0)
2b12 : c5 0f __ CMP P2 ; (exit2_x + 0)
2b14 : 90 06 __ BCC $2b1c ; (z_path_avoids_rooms.s4 + 0)
.s5:
;1014, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2b16 : ed d8 9f SBC $9fd8 ; (grid_positions + 10)
2b19 : 4c 1f 2b JMP $2b1f ; (z_path_avoids_rooms.s6 + 0)
.s4:
;1012, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2b1c : 6d d8 9f ADC $9fd8 ; (grid_positions + 10)
.s6:
;1014, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2b1f : 8d de 9f STA $9fde ; (pivot_x + 0)
;1017, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2b22 : 8d dc 9f STA $9fdc ; (grid_positions + 14)
;1016, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2b25 : a5 0e __ LDA P1 ; (exit1_y + 0)
2b27 : 8d dd 9f STA $9fdd ; (grid_positions + 15)
;1018, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2b2a : a5 10 __ LDA P3 ; (exit2_y + 0)
2b2c : 8d db 9f STA $9fdb ; (grid_positions + 13)
2b2f : 4c a3 2a JMP $2aa3 ; (z_path_avoids_rooms.s3 + 0)
--------------------------------------------------------------------
draw_z_corridor: ; draw_z_corridor(u8,u8,u8,u8,u8)->u8
.s0:
;1072, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2b32 : ad f7 9f LDA $9ff7 ; (sstack + 5)
2b35 : 85 4c __ STA T6 + 0 
2b37 : 85 43 __ STA T1 + 0 
2b39 : ad f5 9f LDA $9ff5 ; (sstack + 3)
2b3c : 85 4b __ STA T5 + 0 
2b3e : 85 4a __ STA T0 + 0 
2b40 : c5 43 __ CMP T1 + 0 
2b42 : 90 02 __ BCC $2b46 ; (draw_z_corridor.s12 + 0)
.s1002:
2b44 : d0 08 __ BNE $2b4e ; (draw_z_corridor.s11 + 0)
.s12:
2b46 : 38 __ __ SEC
2b47 : a5 43 __ LDA T1 + 0 
2b49 : e5 4a __ SBC T0 + 0 
2b4b : 4c 50 2b JMP $2b50 ; (draw_z_corridor.s13 + 0)
.s11:
;1072, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2b4e : e5 43 __ SBC T1 + 0 
.s13:
2b50 : 8d e1 9f STA $9fe1 ; (r1 + 0)
;1073, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2b53 : ad f8 9f LDA $9ff8 ; (sstack + 6)
2b56 : 85 4e __ STA T8 + 0 
2b58 : 85 47 __ STA T3 + 0 
2b5a : ad f6 9f LDA $9ff6 ; (sstack + 4)
2b5d : 85 4d __ STA T7 + 0 
2b5f : 85 45 __ STA T2 + 0 
2b61 : c5 47 __ CMP T3 + 0 
2b63 : 90 02 __ BCC $2b67 ; (draw_z_corridor.s15 + 0)
.s1003:
2b65 : d0 08 __ BNE $2b6f ; (draw_z_corridor.s14 + 0)
.s15:
2b67 : 38 __ __ SEC
2b68 : a5 47 __ LDA T3 + 0 
2b6a : e5 45 __ SBC T2 + 0 
2b6c : 4c 71 2b JMP $2b71 ; (draw_z_corridor.s16 + 0)
.s14:
;1073, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2b6f : e5 47 __ SBC T3 + 0 
.s16:
2b71 : 8d e0 9f STA $9fe0 ; (y + 0)
;1075, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2b74 : a9 00 __ LDA #$00
2b76 : 85 1c __ STA ACCU + 1 ; (exit1_x + 0)
2b78 : 85 04 __ STA WORK + 1 
2b7a : a9 03 __ LDA #$03
2b7c : 85 03 __ STA WORK + 0 
2b7e : ad f9 9f LDA $9ff9 ; (sstack + 7)
2b81 : d0 7a __ BNE $2bfd ; (draw_z_corridor.s1 + 0)
.s2:
;1100, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2b83 : ad e0 9f LDA $9fe0 ; (y + 0)
2b86 : 85 1b __ STA ACCU + 0 
2b88 : 20 38 3f JSR $3f38 ; (divmod + 0)
2b8b : a6 1b __ LDX ACCU + 0 
2b8d : e8 __ __ INX
2b8e : 8e de 9f STX $9fde ; (pivot_x + 0)
;1103, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2b91 : a5 4d __ LDA T7 + 0 
2b93 : 85 18 __ STA P11 
2b95 : c5 4e __ CMP T8 + 0 
2b97 : 90 08 __ BCC $2ba1 ; (draw_z_corridor.s7 + 0)
.s8:
;1106, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2b99 : a5 45 __ LDA T2 + 0 
2b9b : ed de 9f SBC $9fde ; (pivot_x + 0)
2b9e : 4c a6 2b JMP $2ba6 ; (draw_z_corridor.s9 + 0)
.s7:
;1104, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2ba1 : ad de 9f LDA $9fde ; (pivot_x + 0)
2ba4 : 65 45 __ ADC T2 + 0 
.s9:
;1106, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2ba6 : 85 4a __ STA T0 + 0 
2ba8 : 8d e4 9f STA $9fe4 ; (random_offset_x + 0)
;1115, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2bab : 8d f3 9f STA $9ff3 ; (sstack + 1)
;1112, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2bae : 8d e2 9f STA $9fe2 ; (best_distance + 0)
;1108, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2bb1 : a5 4b __ LDA T5 + 0 
2bb3 : 85 17 __ STA P10 
2bb5 : 8d e5 9f STA $9fe5 ; (leg1_end_x + 0)
;1115, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2bb8 : 8d f2 9f STA $9ff2 ; (sstack + 0)
2bbb : a9 00 __ LDA #$00
2bbd : 8d f4 9f STA $9ff4 ; (sstack + 2)
;1111, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2bc0 : a5 4c __ LDA T6 + 0 
2bc2 : 8d e3 9f STA $9fe3 ; (screen_offset + 1)
;1115, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2bc5 : 20 6e 2c JSR $2c6e ; (straight_corridor_path.s0 + 0)
;1116, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2bc8 : a5 4b __ LDA T5 + 0 
2bca : 85 17 __ STA P10 
2bcc : a5 4a __ LDA T0 + 0 
2bce : 85 18 __ STA P11 
2bd0 : 8d f3 9f STA $9ff3 ; (sstack + 1)
2bd3 : a5 4c __ LDA T6 + 0 
2bd5 : 8d f2 9f STA $9ff2 ; (sstack + 0)
2bd8 : a9 01 __ LDA #$01
2bda : 8d f4 9f STA $9ff4 ; (sstack + 2)
2bdd : 20 6e 2c JSR $2c6e ; (straight_corridor_path.s0 + 0)
;1117, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2be0 : a5 4c __ LDA T6 + 0 
2be2 : 85 17 __ STA P10 
2be4 : 8d f2 9f STA $9ff2 ; (sstack + 0)
2be7 : a5 4a __ LDA T0 + 0 
2be9 : 85 18 __ STA P11 
2beb : a5 4e __ LDA T8 + 0 
2bed : 8d f3 9f STA $9ff3 ; (sstack + 1)
2bf0 : a9 00 __ LDA #$00
.s1001:
;1095, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2bf2 : 8d f4 9f STA $9ff4 ; (sstack + 2)
2bf5 : 20 6e 2c JSR $2c6e ; (straight_corridor_path.s0 + 0)
;1120, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2bf8 : a9 01 __ LDA #$01
2bfa : 85 1b __ STA ACCU + 0 
2bfc : 60 __ __ RTS
.s1:
;1078, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2bfd : ad e1 9f LDA $9fe1 ; (r1 + 0)
2c00 : 85 1b __ STA ACCU + 0 
2c02 : 20 38 3f JSR $3f38 ; (divmod + 0)
2c05 : a6 1b __ LDX ACCU + 0 
2c07 : e8 __ __ INX
2c08 : 8e df 9f STX $9fdf ; (leg_length + 0)
;1081, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2c0b : a5 4b __ LDA T5 + 0 
2c0d : 85 17 __ STA P10 
2c0f : c5 4c __ CMP T6 + 0 
2c11 : 90 08 __ BCC $2c1b ; (draw_z_corridor.s4 + 0)
.s5:
;1084, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2c13 : a5 4a __ LDA T0 + 0 
2c15 : ed df 9f SBC $9fdf ; (leg_length + 0)
2c18 : 4c 20 2c JMP $2c20 ; (draw_z_corridor.s6 + 0)
.s4:
;1082, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2c1b : ad df 9f LDA $9fdf ; (leg_length + 0)
2c1e : 65 4a __ ADC T0 + 0 
.s6:
;1084, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2c20 : 85 4a __ STA T0 + 0 
2c22 : 8d e5 9f STA $9fe5 ; (leg1_end_x + 0)
;1093, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2c25 : 8d f2 9f STA $9ff2 ; (sstack + 0)
;1089, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2c28 : 8d e3 9f STA $9fe3 ; (screen_offset + 1)
;1086, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2c2b : a5 4d __ LDA T7 + 0 
2c2d : 85 18 __ STA P11 
2c2f : 8d e4 9f STA $9fe4 ; (random_offset_x + 0)
;1093, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2c32 : 8d f3 9f STA $9ff3 ; (sstack + 1)
2c35 : a9 01 __ LDA #$01
2c37 : 8d f4 9f STA $9ff4 ; (sstack + 2)
;1090, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2c3a : a5 4e __ LDA T8 + 0 
2c3c : 8d e2 9f STA $9fe2 ; (best_distance + 0)
;1093, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2c3f : 20 6e 2c JSR $2c6e ; (straight_corridor_path.s0 + 0)
;1094, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2c42 : a5 4a __ LDA T0 + 0 
2c44 : 85 17 __ STA P10 
2c46 : 8d f2 9f STA $9ff2 ; (sstack + 0)
2c49 : a5 4d __ LDA T7 + 0 
2c4b : 85 18 __ STA P11 
2c4d : a5 4e __ LDA T8 + 0 
2c4f : 8d f3 9f STA $9ff3 ; (sstack + 1)
2c52 : a9 00 __ LDA #$00
2c54 : 8d f4 9f STA $9ff4 ; (sstack + 2)
2c57 : 20 6e 2c JSR $2c6e ; (straight_corridor_path.s0 + 0)
;1095, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2c5a : a5 4a __ LDA T0 + 0 
2c5c : 85 17 __ STA P10 
2c5e : a5 4e __ LDA T8 + 0 
2c60 : 85 18 __ STA P11 
2c62 : 8d f3 9f STA $9ff3 ; (sstack + 1)
2c65 : a5 4c __ LDA T6 + 0 
2c67 : 8d f2 9f STA $9ff2 ; (sstack + 0)
2c6a : a9 01 __ LDA #$01
;1120, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2c6c : d0 84 __ BNE $2bf2 ; (draw_z_corridor.s1001 + 0)
--------------------------------------------------------------------
straight_corridor_path: ; straight_corridor_path(i8,i8,i8,i8,u8)->void
.s0:
; 329, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2c6e : a5 17 __ LDA P10 ; (sx + 0)
2c70 : 8d e7 9f STA $9fe7 ; (idx + 0)
; 330, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2c73 : a5 18 __ LDA P11 ; (sy + 0)
2c75 : 8d e6 9f STA $9fe6 ; (screen_pos + 1)
; 332, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2c78 : ad f4 9f LDA $9ff4 ; (sstack + 2)
2c7b : f0 03 __ BEQ $2c80 ; (straight_corridor_path.s55 + 0)
2c7d : 4c 4e 2d JMP $2d4e ; (straight_corridor_path.s53 + 0)
.s55:
; 361, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2c80 : ad f3 9f LDA $9ff3 ; (sstack + 1)
2c83 : 85 48 __ STA T5 + 0 
.l28:
2c85 : a5 18 __ LDA P11 ; (sy + 0)
2c87 : c5 48 __ CMP T5 + 0 
2c89 : d0 08 __ BNE $2c93 ; (straight_corridor_path.s29 + 0)
.s54:
; 374, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2c8b : ad f2 9f LDA $9ff2 ; (sstack + 0)
2c8e : 85 18 __ STA P11 ; (sy + 0)
2c90 : 4c ed 2c JMP $2ced ; (straight_corridor_path.l40 + 0)
.s29:
; 362, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2c93 : ad e6 9f LDA $9fe6 ; (screen_pos + 1)
2c96 : c5 48 __ CMP T5 + 0 
2c98 : f0 0a __ BEQ $2ca4 ; (straight_corridor_path.s32 + 0)
.s1005:
2c9a : 45 48 __ EOR T5 + 0 
2c9c : 90 04 __ BCC $2ca2 ; (straight_corridor_path.s1006 + 0)
.s1007:
2c9e : 10 04 __ BPL $2ca4 ; (straight_corridor_path.s32 + 0)
2ca0 : 30 0b __ BMI $2cad ; (straight_corridor_path.s31 + 0)
.s1006:
2ca2 : 10 09 __ BPL $2cad ; (straight_corridor_path.s31 + 0)
.s32:
; 363, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2ca4 : ad e6 9f LDA $9fe6 ; (screen_pos + 1)
2ca7 : 18 __ __ CLC
2ca8 : 69 ff __ ADC #$ff
2caa : 4c b3 2c JMP $2cb3 ; (straight_corridor_path.s33 + 0)
.s31:
; 362, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2cad : ad e6 9f LDA $9fe6 ; (screen_pos + 1)
2cb0 : 18 __ __ CLC
2cb1 : 69 01 __ ADC #$01
.s33:
; 363, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2cb3 : 85 16 __ STA P9 
2cb5 : 8d e6 9f STA $9fe6 ; (screen_pos + 1)
; 364, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2cb8 : a5 17 __ LDA P10 ; (sx + 0)
2cba : 85 15 __ STA P8 
2cbc : 20 fb 28 JSR $28fb ; (can_place_corridor.s0 + 0)
2cbf : aa __ __ TAX
2cc0 : a5 16 __ LDA P9 
2cc2 : 85 18 __ STA P11 ; (sy + 0)
2cc4 : 8a __ __ TXA
2cc5 : f0 be __ BEQ $2c85 ; (straight_corridor_path.l28 + 0)
.s34:
; 365, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2cc7 : a5 17 __ LDA P10 ; (sx + 0)
2cc9 : 85 10 __ STA P3 
2ccb : a5 16 __ LDA P9 
2ccd : 85 11 __ STA P4 
2ccf : a9 02 __ LDA #$02
2cd1 : 85 12 __ STA P5 
2cd3 : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
; 366, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2cd6 : ae a8 52 LDX $52a8 ; (corridor_path_static + 40)
2cd9 : e0 14 __ CPX #$14
2cdb : b0 a8 __ BCS $2c85 ; (straight_corridor_path.l28 + 0)
.s37:
; 367, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2cdd : a5 15 __ LDA P8 
2cdf : 9d 80 52 STA $5280,x ; (corridor_path_static + 0)
; 368, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2ce2 : a5 16 __ LDA P9 
2ce4 : 9d 94 52 STA $5294,x ; (corridor_path_static + 20)
; 369, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2ce7 : e8 __ __ INX
2ce8 : 8e a8 52 STX $52a8 ; (corridor_path_static + 40)
2ceb : 90 98 __ BCC $2c85 ; (straight_corridor_path.l28 + 0)
.l40:
; 374, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2ced : a5 17 __ LDA P10 ; (sx + 0)
2cef : c5 18 __ CMP P11 ; (sy + 0)
2cf1 : f0 5a __ BEQ $2d4d ; (straight_corridor_path.s1001 + 0)
.s41:
; 375, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2cf3 : ad e7 9f LDA $9fe7 ; (idx + 0)
2cf6 : c5 18 __ CMP P11 ; (sy + 0)
2cf8 : f0 0a __ BEQ $2d04 ; (straight_corridor_path.s44 + 0)
.s1002:
2cfa : 45 18 __ EOR P11 ; (sy + 0)
2cfc : 90 04 __ BCC $2d02 ; (straight_corridor_path.s1003 + 0)
.s1004:
2cfe : 10 04 __ BPL $2d04 ; (straight_corridor_path.s44 + 0)
2d00 : 30 0b __ BMI $2d0d ; (straight_corridor_path.s43 + 0)
.s1003:
2d02 : 10 09 __ BPL $2d0d ; (straight_corridor_path.s43 + 0)
.s44:
; 376, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2d04 : ad e7 9f LDA $9fe7 ; (idx + 0)
2d07 : 18 __ __ CLC
2d08 : 69 ff __ ADC #$ff
2d0a : 4c 13 2d JMP $2d13 ; (straight_corridor_path.s45 + 0)
.s43:
; 375, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2d0d : ad e7 9f LDA $9fe7 ; (idx + 0)
2d10 : 18 __ __ CLC
2d11 : 69 01 __ ADC #$01
.s45:
; 376, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2d13 : 8d e7 9f STA $9fe7 ; (idx + 0)
; 377, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2d16 : 85 15 __ STA P8 
2d18 : 85 17 __ STA P10 ; (sx + 0)
2d1a : ad e6 9f LDA $9fe6 ; (screen_pos + 1)
2d1d : 85 49 __ STA T6 + 0 
2d1f : 85 16 __ STA P9 
2d21 : 20 fb 28 JSR $28fb ; (can_place_corridor.s0 + 0)
2d24 : aa __ __ TAX
2d25 : f0 c6 __ BEQ $2ced ; (straight_corridor_path.l40 + 0)
.s46:
; 378, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2d27 : a5 15 __ LDA P8 
2d29 : 85 10 __ STA P3 
2d2b : a5 49 __ LDA T6 + 0 
2d2d : 85 11 __ STA P4 
2d2f : a9 02 __ LDA #$02
2d31 : 85 12 __ STA P5 
2d33 : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
; 379, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2d36 : ae a8 52 LDX $52a8 ; (corridor_path_static + 40)
2d39 : e0 14 __ CPX #$14
2d3b : b0 b0 __ BCS $2ced ; (straight_corridor_path.l40 + 0)
.s49:
; 380, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2d3d : a5 15 __ LDA P8 
2d3f : 9d 80 52 STA $5280,x ; (corridor_path_static + 0)
; 381, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2d42 : a5 49 __ LDA T6 + 0 
2d44 : 9d 94 52 STA $5294,x ; (corridor_path_static + 20)
; 382, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2d47 : e8 __ __ INX
2d48 : 8e a8 52 STX $52a8 ; (corridor_path_static + 40)
2d4b : 90 a0 __ BCC $2ced ; (straight_corridor_path.l40 + 0)
.s1001:
; 387, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2d4d : 60 __ __ RTS
.s53:
; 334, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2d4e : ad f2 9f LDA $9ff2 ; (sstack + 0)
2d51 : 85 48 __ STA T5 + 0 
.l4:
2d53 : a5 17 __ LDA P10 ; (sx + 0)
2d55 : c5 48 __ CMP T5 + 0 
2d57 : d0 08 __ BNE $2d61 ; (straight_corridor_path.s5 + 0)
.s52:
; 347, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2d59 : ad f3 9f LDA $9ff3 ; (sstack + 1)
2d5c : 85 17 __ STA P10 ; (sx + 0)
2d5e : 4c b9 2d JMP $2db9 ; (straight_corridor_path.l16 + 0)
.s5:
; 335, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2d61 : ad e7 9f LDA $9fe7 ; (idx + 0)
2d64 : c5 48 __ CMP T5 + 0 
2d66 : f0 0a __ BEQ $2d72 ; (straight_corridor_path.s8 + 0)
.s1011:
2d68 : 45 48 __ EOR T5 + 0 
2d6a : 90 04 __ BCC $2d70 ; (straight_corridor_path.s1012 + 0)
.s1013:
2d6c : 10 04 __ BPL $2d72 ; (straight_corridor_path.s8 + 0)
2d6e : 30 0b __ BMI $2d7b ; (straight_corridor_path.s7 + 0)
.s1012:
2d70 : 10 09 __ BPL $2d7b ; (straight_corridor_path.s7 + 0)
.s8:
; 336, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2d72 : ad e7 9f LDA $9fe7 ; (idx + 0)
2d75 : 18 __ __ CLC
2d76 : 69 ff __ ADC #$ff
2d78 : 4c 81 2d JMP $2d81 ; (straight_corridor_path.s9 + 0)
.s7:
; 335, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2d7b : ad e7 9f LDA $9fe7 ; (idx + 0)
2d7e : 18 __ __ CLC
2d7f : 69 01 __ ADC #$01
.s9:
; 336, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2d81 : 8d e7 9f STA $9fe7 ; (idx + 0)
; 337, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2d84 : 85 15 __ STA P8 
2d86 : a5 18 __ LDA P11 ; (sy + 0)
2d88 : 85 16 __ STA P9 
2d8a : 20 fb 28 JSR $28fb ; (can_place_corridor.s0 + 0)
2d8d : a8 __ __ TAY
2d8e : a6 15 __ LDX P8 
2d90 : 86 17 __ STX P10 ; (sx + 0)
2d92 : 98 __ __ TYA
2d93 : f0 be __ BEQ $2d53 ; (straight_corridor_path.l4 + 0)
.s10:
; 338, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2d95 : 86 10 __ STX P3 
2d97 : a5 18 __ LDA P11 ; (sy + 0)
2d99 : 85 11 __ STA P4 
2d9b : a9 02 __ LDA #$02
2d9d : 85 12 __ STA P5 
2d9f : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
; 339, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2da2 : ae a8 52 LDX $52a8 ; (corridor_path_static + 40)
2da5 : e0 14 __ CPX #$14
2da7 : b0 aa __ BCS $2d53 ; (straight_corridor_path.l4 + 0)
.s13:
; 340, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2da9 : a5 15 __ LDA P8 
2dab : 9d 80 52 STA $5280,x ; (corridor_path_static + 0)
; 341, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2dae : a5 16 __ LDA P9 
2db0 : 9d 94 52 STA $5294,x ; (corridor_path_static + 20)
; 342, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2db3 : e8 __ __ INX
2db4 : 8e a8 52 STX $52a8 ; (corridor_path_static + 40)
2db7 : 90 9a __ BCC $2d53 ; (straight_corridor_path.l4 + 0)
.l16:
; 347, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2db9 : a5 18 __ LDA P11 ; (sy + 0)
2dbb : c5 17 __ CMP P10 ; (sx + 0)
2dbd : f0 8e __ BEQ $2d4d ; (straight_corridor_path.s1001 + 0)
.s17:
; 348, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2dbf : ad e6 9f LDA $9fe6 ; (screen_pos + 1)
2dc2 : c5 17 __ CMP P10 ; (sx + 0)
2dc4 : f0 0a __ BEQ $2dd0 ; (straight_corridor_path.s20 + 0)
.s1008:
2dc6 : 45 17 __ EOR P10 ; (sx + 0)
2dc8 : 90 04 __ BCC $2dce ; (straight_corridor_path.s1009 + 0)
.s1010:
2dca : 10 04 __ BPL $2dd0 ; (straight_corridor_path.s20 + 0)
2dcc : 30 0b __ BMI $2dd9 ; (straight_corridor_path.s19 + 0)
.s1009:
2dce : 10 09 __ BPL $2dd9 ; (straight_corridor_path.s19 + 0)
.s20:
; 349, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2dd0 : ad e6 9f LDA $9fe6 ; (screen_pos + 1)
2dd3 : 18 __ __ CLC
2dd4 : 69 ff __ ADC #$ff
2dd6 : 4c df 2d JMP $2ddf ; (straight_corridor_path.s21 + 0)
.s19:
; 348, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2dd9 : ad e6 9f LDA $9fe6 ; (screen_pos + 1)
2ddc : 18 __ __ CLC
2ddd : 69 01 __ ADC #$01
.s21:
; 349, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2ddf : 85 18 __ STA P11 ; (sy + 0)
2de1 : 8d e6 9f STA $9fe6 ; (screen_pos + 1)
; 350, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2de4 : 85 16 __ STA P9 
2de6 : ad e7 9f LDA $9fe7 ; (idx + 0)
2de9 : 85 48 __ STA T5 + 0 
2deb : 85 15 __ STA P8 
2ded : 20 fb 28 JSR $28fb ; (can_place_corridor.s0 + 0)
2df0 : aa __ __ TAX
2df1 : f0 c6 __ BEQ $2db9 ; (straight_corridor_path.l16 + 0)
.s22:
; 351, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2df3 : a5 48 __ LDA T5 + 0 
2df5 : 85 10 __ STA P3 
2df7 : a5 18 __ LDA P11 ; (sy + 0)
2df9 : 85 11 __ STA P4 
2dfb : a9 02 __ LDA #$02
2dfd : 85 12 __ STA P5 
2dff : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
; 352, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2e02 : ae a8 52 LDX $52a8 ; (corridor_path_static + 40)
2e05 : e0 14 __ CPX #$14
2e07 : b0 b0 __ BCS $2db9 ; (straight_corridor_path.l16 + 0)
.s25:
; 353, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2e09 : a5 48 __ LDA T5 + 0 
2e0b : 9d 80 52 STA $5280,x ; (corridor_path_static + 0)
; 354, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2e0e : a5 16 __ LDA P9 
2e10 : 9d 94 52 STA $5294,x ; (corridor_path_static + 20)
; 355, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2e13 : e8 __ __ INX
2e14 : 8e a8 52 STX $52a8 ; (corridor_path_static + 40)
2e17 : 90 a0 __ BCC $2db9 ; (straight_corridor_path.l16 + 0)
--------------------------------------------------------------------
find_l_corridor_exits: ; find_l_corridor_exits(u8,u8,u8*,u8*,u8*,u8*)->void
.s1000:
2e19 : a5 53 __ LDA T8 + 0 
2e1b : 8d cb 9f STA $9fcb ; (find_l_corridor_exits@stack + 0)
2e1e : a5 54 __ LDA T8 + 1 
2e20 : 8d cc 9f STA $9fcc ; (find_l_corridor_exits@stack + 1)
2e23 : a5 55 __ LDA T11 + 0 
2e25 : 8d cd 9f STA $9fcd ; (find_l_corridor_exits@stack + 2)
.s0:
; 530, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2e28 : ad f2 9f LDA $9ff2 ; (sstack + 0)
2e2b : 85 11 __ STA P4 
2e2d : 0a __ __ ASL
2e2e : 0a __ __ ASL
2e2f : 0a __ __ ASL
2e30 : aa __ __ TAX
2e31 : 69 00 __ ADC #$00
2e33 : 85 4c __ STA T1 + 0 
2e35 : 8d dc 9f STA $9fdc ; (grid_positions + 14)
2e38 : a9 4c __ LDA #$4c
2e3a : 69 00 __ ADC #$00
2e3c : 85 4d __ STA T1 + 1 
2e3e : 8d dd 9f STA $9fdd ; (grid_positions + 15)
; 531, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2e41 : ad f3 9f LDA $9ff3 ; (sstack + 1)
2e44 : 85 55 __ STA T11 + 0 
2e46 : 0a __ __ ASL
2e47 : 0a __ __ ASL
2e48 : 0a __ __ ASL
2e49 : 85 4e __ STA T2 + 0 
2e4b : 69 00 __ ADC #$00
2e4d : 85 53 __ STA T8 + 0 
2e4f : 8d da 9f STA $9fda ; (grid_positions + 12)
2e52 : a9 4c __ LDA #$4c
2e54 : 69 00 __ ADC #$00
2e56 : 85 54 __ STA T8 + 1 
2e58 : 8d db 9f STA $9fdb ; (grid_positions + 13)
; 534, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2e5b : bd 02 4c LDA $4c02,x ; (rooms + 2)
2e5e : 85 50 __ STA T3 + 0 
2e60 : 4a __ __ LSR
2e61 : 85 43 __ STA T4 + 0 
2e63 : a0 00 __ LDY #$00
2e65 : b1 4c __ LDA (T1 + 0),y 
2e67 : 85 52 __ STA T5 + 0 
2e69 : 18 __ __ CLC
2e6a : 65 43 __ ADC T4 + 0 
2e6c : 85 43 __ STA T4 + 0 
2e6e : 8d d9 9f STA $9fd9 ; (grid_positions + 11)
; 535, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2e71 : bd 03 4c LDA $4c03,x ; (rooms + 3)
2e74 : 4a __ __ LSR
2e75 : 18 __ __ CLC
2e76 : 7d 01 4c ADC $4c01,x ; (rooms + 1)
2e79 : 85 4a __ STA T0 + 0 
2e7b : 8d d8 9f STA $9fd8 ; (grid_positions + 10)
; 536, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2e7e : a6 4e __ LDX T2 + 0 
2e80 : bd 02 4c LDA $4c02,x ; (rooms + 2)
2e83 : 4a __ __ LSR
2e84 : 18 __ __ CLC
2e85 : 71 53 __ ADC (T8 + 0),y 
2e87 : 8d d7 9f STA $9fd7 ; (grid_positions + 9)
; 537, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2e8a : bd 03 4c LDA $4c03,x ; (rooms + 3)
2e8d : 4a __ __ LSR
2e8e : 18 __ __ CLC
2e8f : 7d 01 4c ADC $4c01,x ; (rooms + 1)
2e92 : 85 4e __ STA T2 + 0 
2e94 : 8d d6 9f STA $9fd6 ; (grid_positions + 8)
; 543, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2e97 : a5 43 __ LDA T4 + 0 
2e99 : cd d7 9f CMP $9fd7 ; (grid_positions + 9)
2e9c : 98 __ __ TYA
2e9d : 2a __ __ ROL
2e9e : 49 01 __ EOR #$01
2ea0 : 85 47 __ STA T7 + 0 
2ea2 : f0 1a __ BEQ $2ebe ; (find_l_corridor_exits.s2 + 0)
.s4:
2ea4 : a5 4a __ LDA T0 + 0 
2ea6 : c5 4e __ CMP T2 + 0 
2ea8 : b0 14 __ BCS $2ebe ; (find_l_corridor_exits.s2 + 0)
.s1:
; 545, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2eaa : a9 01 __ LDA #$01
2eac : 8d d5 9f STA $9fd5 ; (grid_positions + 7)
; 546, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2eaf : a9 02 __ LDA #$02
2eb1 : 8d d4 9f STA $9fd4 ; (grid_positions + 6)
; 568, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2eb4 : a5 52 __ LDA T5 + 0 
2eb6 : 65 50 __ ADC T3 + 0 
2eb8 : 18 __ __ CLC
2eb9 : 69 01 __ ADC #$01
2ebb : 4c 27 2f JMP $2f27 ; (find_l_corridor_exits.s76 + 0)
.s2:
; 547, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2ebe : ad d7 9f LDA $9fd7 ; (grid_positions + 9)
2ec1 : c5 43 __ CMP T4 + 0 
2ec3 : b0 2c __ BCS $2ef1 ; (find_l_corridor_exits.s6 + 0)
.s8:
2ec5 : a5 4a __ LDA T0 + 0 
2ec7 : c5 4e __ CMP T2 + 0 
2ec9 : b0 26 __ BCS $2ef1 ; (find_l_corridor_exits.s6 + 0)
.s5:
; 549, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2ecb : a9 03 __ LDA #$03
2ecd : 8d d5 9f STA $9fd5 ; (grid_positions + 7)
; 550, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2ed0 : a9 01 __ LDA #$01
2ed2 : 8d d4 9f STA $9fd4 ; (grid_positions + 6)
; 576, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2ed5 : ad f4 9f LDA $9ff4 ; (sstack + 2)
2ed8 : 85 4a __ STA T0 + 0 
2eda : ad f5 9f LDA $9ff5 ; (sstack + 3)
2edd : 85 4b __ STA T0 + 1 
2edf : a5 43 __ LDA T4 + 0 
2ee1 : 91 4a __ STA (T0 + 0),y 
; 577, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2ee3 : a0 03 __ LDY #$03
2ee5 : b1 4c __ LDA (T1 + 0),y 
2ee7 : 85 1b __ STA ACCU + 0 ; (exit1_x + 0)
2ee9 : 38 __ __ SEC
2eea : a0 01 __ LDY #$01
2eec : 71 4c __ ADC (T1 + 0),y 
2eee : 4c 43 2f JMP $2f43 ; (find_l_corridor_exits.s13 + 0)
.s6:
; 551, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2ef1 : a5 47 __ LDA T7 + 0 
2ef3 : f0 25 __ BEQ $2f1a ; (find_l_corridor_exits.s10 + 0)
.s12:
2ef5 : a5 4e __ LDA T2 + 0 
2ef7 : c5 4a __ CMP T0 + 0 
2ef9 : b0 1f __ BCS $2f1a ; (find_l_corridor_exits.s10 + 0)
.s9:
; 554, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2efb : 8c d4 9f STY $9fd4 ; (grid_positions + 6)
; 553, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2efe : a9 02 __ LDA #$02
2f00 : 8d d5 9f STA $9fd5 ; (grid_positions + 7)
; 572, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2f03 : ad f4 9f LDA $9ff4 ; (sstack + 2)
2f06 : 85 4a __ STA T0 + 0 
2f08 : ad f5 9f LDA $9ff5 ; (sstack + 3)
2f0b : 85 4b __ STA T0 + 1 
2f0d : a5 43 __ LDA T4 + 0 
2f0f : 91 4a __ STA (T0 + 0),y 
; 573, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2f11 : a0 01 __ LDY #$01
2f13 : b1 4c __ LDA (T1 + 0),y 
2f15 : e9 01 __ SBC #$01
2f17 : 4c 43 2f JMP $2f43 ; (find_l_corridor_exits.s13 + 0)
.s10:
; 557, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2f1a : 8c d5 9f STY $9fd5 ; (grid_positions + 7)
; 558, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2f1d : a9 03 __ LDA #$03
2f1f : 8d d4 9f STA $9fd4 ; (grid_positions + 6)
; 564, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2f22 : 38 __ __ SEC
2f23 : a5 52 __ LDA T5 + 0 
2f25 : e9 02 __ SBC #$02
.s76:
2f27 : ae f4 9f LDX $9ff4 ; (sstack + 2)
2f2a : 86 4e __ STX T2 + 0 
2f2c : ae f5 9f LDX $9ff5 ; (sstack + 3)
2f2f : 86 4f __ STX T2 + 1 
2f31 : 91 4e __ STA (T2 + 0),y 
; 565, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2f33 : a0 03 __ LDY #$03
2f35 : b1 4c __ LDA (T1 + 0),y 
2f37 : 4a __ __ LSR
2f38 : 85 4a __ STA T0 + 0 
2f3a : a0 01 __ LDY #$01
2f3c : b1 4c __ LDA (T1 + 0),y 
2f3e : 85 1b __ STA ACCU + 0 ; (exit1_x + 0)
2f40 : 18 __ __ CLC
2f41 : 65 4a __ ADC T0 + 0 
.s13:
; 584, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2f43 : 85 14 __ STA P7 
2f45 : 8d d0 9f STA $9fd0 ; (grid_positions + 2)
2f48 : ae f6 9f LDX $9ff6 ; (sstack + 4)
2f4b : 86 4c __ STX T1 + 0 
2f4d : ae f7 9f LDX $9ff7 ; (sstack + 5)
2f50 : 86 4d __ STX T1 + 1 
; 573, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2f52 : a0 00 __ LDY #$00
2f54 : 91 4c __ STA (T1 + 0),y 
; 583, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2f56 : ad f4 9f LDA $9ff4 ; (sstack + 2)
2f59 : 85 4a __ STA T0 + 0 
2f5b : ad f5 9f LDA $9ff5 ; (sstack + 3)
2f5e : 85 4b __ STA T0 + 1 
2f60 : b1 4a __ LDA (T0 + 0),y 
2f62 : 85 13 __ STA P6 
2f64 : 8d d1 9f STA $9fd1 ; (grid_positions + 3)
; 586, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2f67 : ad d5 9f LDA $9fd5 ; (grid_positions + 7)
2f6a : 85 52 __ STA T5 + 0 
2f6c : 85 12 __ STA P5 
2f6e : a9 d3 __ LDA #$d3
2f70 : 85 15 __ STA P8 
2f72 : a9 9f __ LDA #$9f
2f74 : 85 18 __ STA P11 
2f76 : a9 9f __ LDA #$9f
2f78 : 85 16 __ STA P9 
2f7a : a9 d2 __ LDA #$d2
2f7c : 85 17 __ STA P10 
2f7e : 20 89 22 JSR $2289 ; (find_existing_door_on_room_side.s0 + 0)
2f81 : a5 55 __ LDA T11 + 0 
2f83 : 85 11 __ STA P4 
2f85 : a5 1b __ LDA ACCU + 0 ; (exit1_x + 0)
2f87 : f0 2e __ BEQ $2fb7 ; (find_l_corridor_exits.s67 + 0)
.s24:
; 588, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2f89 : a5 52 __ LDA T5 + 0 
2f8b : c9 02 __ CMP #$02
2f8d : d0 11 __ BNE $2fa0 ; (find_l_corridor_exits.s33 + 0)
.s30:
; 598, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2f8f : ad d3 9f LDA $9fd3 ; (grid_positions + 5)
2f92 : a0 00 __ LDY #$00
2f94 : 91 4a __ STA (T0 + 0),y 
; 599, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2f96 : ae d2 9f LDX $9fd2 ; (grid_positions + 4)
2f99 : ca __ __ DEX
.s82:
; 603, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2f9a : 8a __ __ TXA
2f9b : 91 4c __ STA (T1 + 0),y 
2f9d : 4c b7 2f JMP $2fb7 ; (find_l_corridor_exits.s67 + 0)
.s33:
; 588, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2fa0 : b0 03 __ BCS $2fa5 ; (find_l_corridor_exits.s34 + 0)
2fa2 : 4c d7 30 JMP $30d7 ; (find_l_corridor_exits.s35 + 0)
.s34:
2fa5 : c9 03 __ CMP #$03
2fa7 : d0 0e __ BNE $2fb7 ; (find_l_corridor_exits.s67 + 0)
.s31:
; 602, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2fa9 : ad d3 9f LDA $9fd3 ; (grid_positions + 5)
2fac : a0 00 __ LDY #$00
2fae : 91 4a __ STA (T0 + 0),y 
; 603, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2fb0 : ae d2 9f LDX $9fd2 ; (grid_positions + 4)
2fb3 : e8 __ __ INX
2fb4 : 8a __ __ TXA
2fb5 : 91 4c __ STA (T1 + 0),y 
.s67:
; 608, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2fb7 : ad d4 9f LDA $9fd4 ; (grid_positions + 6)
2fba : aa __ __ TAX
2fbb : c9 02 __ CMP #$02
2fbd : d0 1f __ BNE $2fde ; (find_l_corridor_exits.s44 + 0)
.s41:
; 618, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2fbf : ad f8 9f LDA $9ff8 ; (sstack + 6)
2fc2 : 85 4c __ STA T1 + 0 
2fc4 : ad f9 9f LDA $9ff9 ; (sstack + 7)
2fc7 : 85 4d __ STA T1 + 1 
2fc9 : a0 02 __ LDY #$02
2fcb : b1 53 __ LDA (T8 + 0),y 
2fcd : 4a __ __ LSR
2fce : 18 __ __ CLC
2fcf : a0 00 __ LDY #$00
2fd1 : 71 53 __ ADC (T8 + 0),y 
2fd3 : 91 4c __ STA (T1 + 0),y 
; 619, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2fd5 : c8 __ __ INY
2fd6 : b1 53 __ LDA (T8 + 0),y 
2fd8 : 38 __ __ SEC
2fd9 : e9 02 __ SBC #$02
2fdb : 4c 0b 30 JMP $300b ; (find_l_corridor_exits.s79 + 0)
.s44:
; 608, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2fde : c9 02 __ CMP #$02
2fe0 : b0 03 __ BCS $2fe5 ; (find_l_corridor_exits.s45 + 0)
2fe2 : 4c 98 30 JMP $3098 ; (find_l_corridor_exits.s46 + 0)
.s45:
2fe5 : c9 03 __ CMP #$03
2fe7 : f0 04 __ BEQ $2fed ; (find_l_corridor_exits.s42 + 0)
.s1005:
; 628, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2fe9 : a0 00 __ LDY #$00
2feb : f0 2c __ BEQ $3019 ; (find_l_corridor_exits.s38 + 0)
.s42:
; 622, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
2fed : ad f8 9f LDA $9ff8 ; (sstack + 6)
2ff0 : 85 4c __ STA T1 + 0 
2ff2 : ad f9 9f LDA $9ff9 ; (sstack + 7)
2ff5 : 85 4d __ STA T1 + 1 
2ff7 : a0 02 __ LDY #$02
2ff9 : b1 53 __ LDA (T8 + 0),y 
2ffb : 4a __ __ LSR
2ffc : 18 __ __ CLC
2ffd : a0 00 __ LDY #$00
2fff : 71 53 __ ADC (T8 + 0),y 
3001 : 91 4c __ STA (T1 + 0),y 
; 623, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3003 : c8 __ __ INY
3004 : b1 53 __ LDA (T8 + 0),y 
3006 : 38 __ __ SEC
3007 : a0 03 __ LDY #$03
3009 : 71 53 __ ADC (T8 + 0),y 
.s79:
300b : ae fa 9f LDX $9ffa ; (sstack + 8)
300e : 86 4c __ STX T1 + 0 
3010 : ae fb 9f LDX $9ffb ; (sstack + 9)
3013 : 86 4d __ STX T1 + 1 
3015 : a0 00 __ LDY #$00
3017 : 91 4c __ STA (T1 + 0),y 
.s38:
; 628, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3019 : ad f8 9f LDA $9ff8 ; (sstack + 6)
301c : 85 4a __ STA T0 + 0 
301e : ad f9 9f LDA $9ff9 ; (sstack + 7)
3021 : 85 4b __ STA T0 + 1 
3023 : b1 4a __ LDA (T0 + 0),y 
3025 : 85 13 __ STA P6 
3027 : 8d d1 9f STA $9fd1 ; (grid_positions + 3)
; 629, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
302a : ad fa 9f LDA $9ffa ; (sstack + 8)
302d : 85 4c __ STA T1 + 0 
302f : ad fb 9f LDA $9ffb ; (sstack + 9)
3032 : 85 4d __ STA T1 + 1 
3034 : b1 4c __ LDA (T1 + 0),y 
3036 : 85 14 __ STA P7 
3038 : 8d d0 9f STA $9fd0 ; (grid_positions + 2)
; 631, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
303b : ad d4 9f LDA $9fd4 ; (grid_positions + 6)
303e : 85 50 __ STA T3 + 0 
3040 : 85 12 __ STA P5 
3042 : 20 89 22 JSR $2289 ; (find_existing_door_on_room_side.s0 + 0)
3045 : a5 1b __ LDA ACCU + 0 ; (exit1_x + 0)
3047 : f0 14 __ BEQ $305d ; (find_l_corridor_exits.s1001 + 0)
.s49:
; 633, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3049 : a5 50 __ LDA T3 + 0 
304b : c9 02 __ CMP #$02
304d : d0 1e __ BNE $306d ; (find_l_corridor_exits.s58 + 0)
.s55:
; 643, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
304f : ad d3 9f LDA $9fd3 ; (grid_positions + 5)
3052 : a0 00 __ LDY #$00
3054 : 91 4a __ STA (T0 + 0),y 
; 644, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3056 : ae d2 9f LDX $9fd2 ; (grid_positions + 4)
3059 : ca __ __ DEX
.s81:
; 648, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
305a : 8a __ __ TXA
305b : 91 4c __ STA (T1 + 0),y 
.s1001:
305d : ad cb 9f LDA $9fcb ; (find_l_corridor_exits@stack + 0)
3060 : 85 53 __ STA T8 + 0 
3062 : ad cc 9f LDA $9fcc ; (find_l_corridor_exits@stack + 1)
3065 : 85 54 __ STA T8 + 1 
3067 : ad cd 9f LDA $9fcd ; (find_l_corridor_exits@stack + 2)
306a : 85 55 __ STA T11 + 0 
; 652, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
306c : 60 __ __ RTS
.s58:
; 633, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
306d : 90 12 __ BCC $3081 ; (find_l_corridor_exits.s60 + 0)
.s59:
306f : c9 03 __ CMP #$03
3071 : d0 ea __ BNE $305d ; (find_l_corridor_exits.s1001 + 0)
.s56:
; 647, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3073 : ad d3 9f LDA $9fd3 ; (grid_positions + 5)
3076 : a0 00 __ LDY #$00
3078 : 91 4a __ STA (T0 + 0),y 
; 648, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
307a : ae d2 9f LDX $9fd2 ; (grid_positions + 4)
307d : e8 __ __ INX
307e : 4c 5a 30 JMP $305a ; (find_l_corridor_exits.s81 + 0)
.s60:
; 635, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3081 : ad d2 9f LDA $9fd2 ; (grid_positions + 4)
3084 : a0 00 __ LDY #$00
3086 : 91 4c __ STA (T1 + 0),y 
; 633, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3088 : ae d3 9f LDX $9fd3 ; (grid_positions + 5)
308b : a5 50 __ LDA T3 + 0 
308d : d0 03 __ BNE $3092 ; (find_l_corridor_exits.s54 + 0)
.s53:
; 636, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
308f : ca __ __ DEX
3090 : 90 01 __ BCC $3093 ; (find_l_corridor_exits.s80 + 0)
.s54:
; 640, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3092 : e8 __ __ INX
.s80:
3093 : 8a __ __ TXA
3094 : 91 4a __ STA (T0 + 0),y 
3096 : 90 c5 __ BCC $305d ; (find_l_corridor_exits.s1001 + 0)
.s46:
; 608, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3098 : a0 00 __ LDY #$00
309a : b1 53 __ LDA (T8 + 0),y 
309c : 85 4c __ STA T1 + 0 
309e : ad f8 9f LDA $9ff8 ; (sstack + 6)
30a1 : 85 4e __ STA T2 + 0 
30a3 : ad f9 9f LDA $9ff9 ; (sstack + 7)
30a6 : 85 4f __ STA T2 + 1 
30a8 : ad fa 9f LDA $9ffa ; (sstack + 8)
30ab : 85 50 __ STA T3 + 0 
30ad : ad fb 9f LDA $9ffb ; (sstack + 9)
30b0 : 85 51 __ STA T3 + 1 
30b2 : 8a __ __ TXA
30b3 : f0 0b __ BEQ $30c0 ; (find_l_corridor_exits.s39 + 0)
.s40:
; 614, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
30b5 : a0 02 __ LDY #$02
30b7 : b1 53 __ LDA (T8 + 0),y 
30b9 : 38 __ __ SEC
30ba : 65 4c __ ADC T1 + 0 
30bc : a0 00 __ LDY #$00
30be : f0 05 __ BEQ $30c5 ; (find_l_corridor_exits.s78 + 0)
.s39:
; 610, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
30c0 : 38 __ __ SEC
30c1 : a5 4c __ LDA T1 + 0 
30c3 : e9 02 __ SBC #$02
.s78:
; 614, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
30c5 : 91 4e __ STA (T2 + 0),y 
; 615, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
30c7 : a0 03 __ LDY #$03
30c9 : b1 53 __ LDA (T8 + 0),y 
30cb : 4a __ __ LSR
30cc : 18 __ __ CLC
30cd : a0 01 __ LDY #$01
30cf : 71 53 __ ADC (T8 + 0),y 
30d1 : 88 __ __ DEY
30d2 : 91 50 __ STA (T3 + 0),y 
30d4 : 4c 19 30 JMP $3019 ; (find_l_corridor_exits.s38 + 0)
.s35:
; 590, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
30d7 : ad d2 9f LDA $9fd2 ; (grid_positions + 4)
30da : a0 00 __ LDY #$00
30dc : 91 4c __ STA (T1 + 0),y 
; 588, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
30de : ad d4 9f LDA $9fd4 ; (grid_positions + 6)
30e1 : 85 4e __ STA T2 + 0 
30e3 : ae d3 9f LDX $9fd3 ; (grid_positions + 5)
30e6 : a5 52 __ LDA T5 + 0 
30e8 : d0 03 __ BNE $30ed ; (find_l_corridor_exits.s29 + 0)
.s28:
; 591, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
30ea : ca __ __ DEX
30eb : 90 01 __ BCC $30ee ; (find_l_corridor_exits.s72 + 0)
.s29:
; 595, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
30ed : e8 __ __ INX
.s72:
30ee : 8a __ __ TXA
30ef : 91 4a __ STA (T0 + 0),y 
; 608, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
30f1 : a5 4e __ LDA T2 + 0 
30f3 : aa __ __ TAX
30f4 : c9 02 __ CMP #$02
30f6 : f0 03 __ BEQ $30fb ; (find_l_corridor_exits.s72 + 13)
30f8 : 4c de 2f JMP $2fde ; (find_l_corridor_exits.s44 + 0)
30fb : 4c bf 2f JMP $2fbf ; (find_l_corridor_exits.s41 + 0)
--------------------------------------------------------------------
get_exit_side: ; get_exit_side(struct S#8374*,u8,u8)->u8
.s0:
; 399, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
30fe : a0 00 __ LDY #$00
3100 : b1 0d __ LDA (P0),y ; (room + 0)
3102 : 85 1b __ STA ACCU + 0 
3104 : 38 __ __ SEC
3105 : e9 02 __ SBC #$02
3107 : 90 04 __ BCC $310d ; (get_exit_side.s3 + 0)
.s1011:
3109 : c5 0f __ CMP P2 ; (exit_x + 0)
310b : f0 4f __ BEQ $315c ; (get_exit_side.s1 + 0)
.s3:
; 403, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
310d : a0 02 __ LDY #$02
310f : b1 0d __ LDA (P0),y ; (room + 0)
3111 : 18 __ __ CLC
3112 : 65 1b __ ADC ACCU + 0 
3114 : a2 00 __ LDX #$00
3116 : 90 01 __ BCC $3119 ; (get_exit_side.s1016 + 0)
.s1015:
3118 : e8 __ __ INX
.s1016:
3119 : 18 __ __ CLC
311a : 69 01 __ ADC #$01
311c : 85 1b __ STA ACCU + 0 
311e : 8a __ __ TXA
311f : 69 00 __ ADC #$00
3121 : d0 09 __ BNE $312c ; (get_exit_side.s7 + 0)
.s1008:
3123 : a5 0f __ LDA P2 ; (exit_x + 0)
3125 : c5 1b __ CMP ACCU + 0 
3127 : d0 03 __ BNE $312c ; (get_exit_side.s7 + 0)
.s5:
; 404, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3129 : a9 01 __ LDA #$01
.s1001:
; 400, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
312b : 60 __ __ RTS
.s7:
; 407, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
312c : a0 01 __ LDY #$01
312e : b1 0d __ LDA (P0),y ; (room + 0)
3130 : 85 1b __ STA ACCU + 0 
3132 : 38 __ __ SEC
3133 : e9 02 __ SBC #$02
3135 : 90 07 __ BCC $313e ; (get_exit_side.s11 + 0)
.s1005:
3137 : c5 10 __ CMP P3 ; (exit_y + 0)
3139 : d0 03 __ BNE $313e ; (get_exit_side.s11 + 0)
.s9:
; 408, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
313b : a9 02 __ LDA #$02
313d : 60 __ __ RTS
.s11:
; 411, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
313e : a0 03 __ LDY #$03
3140 : b1 0d __ LDA (P0),y ; (room + 0)
3142 : 18 __ __ CLC
3143 : 65 1b __ ADC ACCU + 0 
3145 : a2 00 __ LDX #$00
3147 : 90 01 __ BCC $314a ; (get_exit_side.s1018 + 0)
.s1017:
3149 : e8 __ __ INX
.s1018:
314a : 18 __ __ CLC
314b : 69 01 __ ADC #$01
314d : 85 1b __ STA ACCU + 0 
314f : 8a __ __ TXA
3150 : 69 00 __ ADC #$00
3152 : d0 08 __ BNE $315c ; (get_exit_side.s1 + 0)
.s1002:
3154 : a5 10 __ LDA P3 ; (exit_y + 0)
3156 : c5 1b __ CMP ACCU + 0 
3158 : d0 02 __ BNE $315c ; (get_exit_side.s1 + 0)
.s13:
; 412, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
315a : 98 __ __ TYA
315b : 60 __ __ RTS
.s1:
; 400, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
315c : a9 00 __ LDA #$00
315e : 60 __ __ RTS
--------------------------------------------------------------------
l_path_avoids_rooms: ; l_path_avoids_rooms(u8,u8,u8,u8,u8,u8,u8)->u8
.s0:
; 269, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
315f : a5 13 __ LDA P6 ; (xy_first + 0)
3161 : d0 0a __ BNE $316d ; (l_path_avoids_rooms.s1 + 0)
.s2:
; 276, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3163 : a5 10 __ LDA P3 ; (ey + 0)
3165 : 8d dd 9f STA $9fdd ; (grid_positions + 15)
; 275, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3168 : a5 0d __ LDA P0 ; (sx + 0)
316a : 4c 74 31 JMP $3174 ; (l_path_avoids_rooms.s3 + 0)
.s1:
; 272, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
316d : a5 0e __ LDA P1 ; (sy + 0)
316f : 8d dd 9f STA $9fdd ; (grid_positions + 15)
; 271, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3172 : a5 0f __ LDA P2 ; (ex + 0)
.s3:
3174 : 8d de 9f STA $9fde ; (pivot_x + 0)
; 280, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3177 : 85 0f __ STA P2 ; (ex + 0)
3179 : ad dd 9f LDA $9fdd ; (grid_positions + 15)
317c : 85 4e __ STA T2 + 0 
317e : 85 10 __ STA P3 ; (ey + 0)
3180 : 20 f3 25 JSR $25f3 ; (path_intersects_other_rooms.s0 + 0)
3183 : a5 1b __ LDA ACCU + 0 
3185 : f0 04 __ BEQ $318b ; (l_path_avoids_rooms.s6 + 0)
.s4:
; 281, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3187 : a9 00 __ LDA #$00
3189 : f0 10 __ BEQ $319b ; (l_path_avoids_rooms.s1001 + 0)
.s6:
; 285, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
318b : a5 0f __ LDA P2 ; (ex + 0)
318d : 85 0d __ STA P0 ; (sx + 0)
318f : a5 4e __ LDA T2 + 0 
3191 : 85 0e __ STA P1 ; (sy + 0)
3193 : 20 f3 25 JSR $25f3 ; (path_intersects_other_rooms.s0 + 0)
3196 : a9 00 __ LDA #$00
3198 : c5 1b __ CMP ACCU + 0 
319a : 2a __ __ ROL
.s1001:
; 289, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
319b : 85 1b __ STA ACCU + 0 
319d : 60 __ __ RTS
--------------------------------------------------------------------
draw_l_corridor: ; draw_l_corridor(u8,u8,u8,u8,u8,u8)->void
.s0:
; 674, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
319e : ad f9 9f LDA $9ff9 ; (sstack + 7)
31a1 : d0 03 __ BNE $31a6 ; (draw_l_corridor.s5 + 0)
31a3 : 4c 5a 32 JMP $325a ; (draw_l_corridor.s4 + 0)
.s5:
31a6 : c9 01 __ CMP #$01
31a8 : f0 f9 __ BEQ $31a3 ; (draw_l_corridor.s0 + 5)
.s2:
; 684, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
31aa : c9 02 __ CMP #$02
31ac : f0 07 __ BEQ $31b5 ; (draw_l_corridor.s10 + 0)
.s11:
31ae : ad f9 9f LDA $9ff9 ; (sstack + 7)
31b1 : c9 03 __ CMP #$03
31b3 : d0 43 __ BNE $31f8 ; (draw_l_corridor.s8 + 0)
.s10:
31b5 : ad fa 9f LDA $9ffa ; (sstack + 8)
31b8 : f0 04 __ BEQ $31be ; (draw_l_corridor.s7 + 0)
.s12:
31ba : c9 01 __ CMP #$01
31bc : d0 3a __ BNE $31f8 ; (draw_l_corridor.s8 + 0)
.s7:
; 691, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
31be : ad f5 9f LDA $9ff5 ; (sstack + 3)
31c1 : 85 4a __ STA T1 + 0 
31c3 : 85 17 __ STA P10 
31c5 : 8d f2 9f STA $9ff2 ; (sstack + 0)
; 687, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
31c8 : 8d e5 9f STA $9fe5 ; (leg1_end_x + 0)
; 691, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
31cb : a9 00 __ LDA #$00
31cd : 8d f4 9f STA $9ff4 ; (sstack + 2)
31d0 : ad f8 9f LDA $9ff8 ; (sstack + 6)
31d3 : 85 4b __ STA T2 + 0 
31d5 : 8d f3 9f STA $9ff3 ; (sstack + 1)
; 688, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
31d8 : 8d e4 9f STA $9fe4 ; (random_offset_x + 0)
; 691, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
31db : ad f6 9f LDA $9ff6 ; (sstack + 4)
31de : 85 18 __ STA P11 
31e0 : 20 6e 2c JSR $2c6e ; (straight_corridor_path.s0 + 0)
; 692, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
31e3 : a5 4a __ LDA T1 + 0 
31e5 : 85 17 __ STA P10 
31e7 : a5 4b __ LDA T2 + 0 
31e9 : 85 18 __ STA P11 
31eb : 8d f3 9f STA $9ff3 ; (sstack + 1)
31ee : ad f7 9f LDA $9ff7 ; (sstack + 5)
31f1 : 8d f2 9f STA $9ff2 ; (sstack + 0)
; 705, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
31f4 : a9 01 __ LDA #$01
31f6 : d0 5c __ BNE $3254 ; (draw_l_corridor.s3 + 0)
.s8:
; 705, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
31f8 : ad f5 9f LDA $9ff5 ; (sstack + 3)
31fb : 85 17 __ STA P10 
31fd : ad f7 9f LDA $9ff7 ; (sstack + 5)
3200 : 8d f2 9f STA $9ff2 ; (sstack + 0)
; 696, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3203 : 18 __ __ CLC
3204 : 65 17 __ ADC P10 
3206 : 6a __ __ ROR
3207 : 8d e5 9f STA $9fe5 ; (leg1_end_x + 0)
; 705, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
320a : ad f6 9f LDA $9ff6 ; (sstack + 4)
320d : 85 18 __ STA P11 
320f : ad f8 9f LDA $9ff8 ; (sstack + 6)
3212 : 8d f3 9f STA $9ff3 ; (sstack + 1)
; 697, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3215 : 18 __ __ CLC
3216 : 65 18 __ ADC P11 
3218 : 6a __ __ ROR
3219 : 8d e4 9f STA $9fe4 ; (random_offset_x + 0)
; 700, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
321c : ad f7 9f LDA $9ff7 ; (sstack + 5)
321f : c5 17 __ CMP P10 
3221 : 90 08 __ BCC $322b ; (draw_l_corridor.s16 + 0)
.s17:
3223 : ad f2 9f LDA $9ff2 ; (sstack + 0)
3226 : e5 17 __ SBC P10 
3228 : 4c 31 32 JMP $3231 ; (draw_l_corridor.s18 + 0)
.s16:
; 700, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
322b : a5 17 __ LDA P10 
322d : 38 __ __ SEC
322e : ed f2 9f SBC $9ff2 ; (sstack + 0)
.s18:
3231 : 8d e3 9f STA $9fe3 ; (screen_offset + 1)
; 701, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3234 : ad f8 9f LDA $9ff8 ; (sstack + 6)
3237 : c5 18 __ CMP P11 
3239 : 90 08 __ BCC $3243 ; (draw_l_corridor.s19 + 0)
.s20:
323b : ad f3 9f LDA $9ff3 ; (sstack + 1)
323e : e5 18 __ SBC P11 
3240 : 4c 49 32 JMP $3249 ; (draw_l_corridor.s21 + 0)
.s19:
; 701, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3243 : a5 18 __ LDA P11 
3245 : 38 __ __ SEC
3246 : ed f3 9f SBC $9ff3 ; (sstack + 1)
.s21:
3249 : 8d e2 9f STA $9fe2 ; (best_distance + 0)
; 703, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
324c : cd e3 9f CMP $9fe3 ; (screen_offset + 1)
324f : a9 00 __ LDA #$00
3251 : 2a __ __ ROL
3252 : 49 01 __ EOR #$01
.s3:
; 708, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3254 : 8d f4 9f STA $9ff4 ; (sstack + 2)
; 682, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3257 : 4c 6e 2c JMP $2c6e ; (straight_corridor_path.s0 + 0)
.s4:
; 674, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
325a : ad fa 9f LDA $9ffa ; (sstack + 8)
325d : c9 02 __ CMP #$02
325f : f0 07 __ BEQ $3268 ; (draw_l_corridor.s1 + 0)
.s6:
3261 : c9 03 __ CMP #$03
3263 : f0 03 __ BEQ $3268 ; (draw_l_corridor.s1 + 0)
3265 : 4c ae 31 JMP $31ae ; (draw_l_corridor.s11 + 0)
.s1:
; 681, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3268 : ad f7 9f LDA $9ff7 ; (sstack + 5)
326b : 85 4a __ STA T1 + 0 
326d : 8d f2 9f STA $9ff2 ; (sstack + 0)
; 677, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3270 : 8d e5 9f STA $9fe5 ; (leg1_end_x + 0)
; 681, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3273 : a9 01 __ LDA #$01
3275 : 8d f4 9f STA $9ff4 ; (sstack + 2)
3278 : ad f6 9f LDA $9ff6 ; (sstack + 4)
327b : 85 4b __ STA T2 + 0 
327d : 85 18 __ STA P11 
327f : 8d f3 9f STA $9ff3 ; (sstack + 1)
; 678, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3282 : 8d e4 9f STA $9fe4 ; (random_offset_x + 0)
; 681, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
3285 : ad f5 9f LDA $9ff5 ; (sstack + 3)
3288 : 85 17 __ STA P10 
328a : 20 6e 2c JSR $2c6e ; (straight_corridor_path.s0 + 0)
; 682, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
328d : a5 4a __ LDA T1 + 0 
328f : 85 17 __ STA P10 
3291 : 8d f2 9f STA $9ff2 ; (sstack + 0)
3294 : a5 4b __ LDA T2 + 0 
3296 : 85 18 __ STA P11 
3298 : ad f8 9f LDA $9ff8 ; (sstack + 6)
329b : 8d f3 9f STA $9ff3 ; (sstack + 1)
; 708, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/connection_system.c"
329e : a9 00 __ LDA #$00
32a0 : f0 b2 __ BEQ $3254 ; (draw_l_corridor.s3 + 0)
--------------------------------------------------------------------
add_stairs: ; add_stairs()->void
.s0:
;  47, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
32a2 : a9 b8 __ LDA #$b8
32a4 : 85 0e __ STA P1 
32a6 : a9 33 __ LDA #$33
32a8 : 85 0f __ STA P2 
32aa : 20 af 0f JSR $0faf ; (print_text.s0 + 0)
;  49, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
32ad : ad de 3f LDA $3fde ; (room_count + 0)
32b0 : c9 02 __ CMP #$02
32b2 : b0 01 __ BCS $32b5 ; (add_stairs.s3 + 0)
32b4 : 60 __ __ RTS
.s3:
;  52, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
32b5 : 85 4a __ STA T3 + 0 
32b7 : e9 01 __ SBC #$01
32b9 : 8d e6 9f STA $9fe6 ; (screen_pos + 1)
;  51, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
32bc : a9 15 __ LDA #$15
32be : 85 0f __ STA P2 
32c0 : a9 db __ LDA #$db
32c2 : 85 0e __ STA P1 
32c4 : a9 00 __ LDA #$00
32c6 : 8d e7 9f STA $9fe7 ; (idx + 0)
;  55, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
32c9 : 8d e5 9f STA $9fe5 ; (leg1_end_x + 0)
;  56, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
32cc : 8d e4 9f STA $9fe4 ; (random_offset_x + 0)
.l6:
;  57, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
32cf : 85 4b __ STA T4 + 0 
32d1 : 29 03 __ AND #$03
32d3 : d0 03 __ BNE $32d8 ; (add_stairs.s11 + 0)
.s9:
32d5 : 20 af 0f JSR $0faf ; (print_text.s0 + 0)
.s11:
;  56, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
32d8 : a6 4b __ LDX T4 + 0 
32da : e8 __ __ INX
32db : 8e e4 9f STX $9fe4 ; (random_offset_x + 0)
;  58, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
32de : a5 4b __ LDA T4 + 0 
32e0 : 0a __ __ ASL
32e1 : 0a __ __ ASL
32e2 : 0a __ __ ASL
32e3 : a8 __ __ TAY
32e4 : ad e5 9f LDA $9fe5 ; (leg1_end_x + 0)
32e7 : d9 07 4c CMP $4c07,y ; (rooms + 7)
32ea : b0 0b __ BCS $32f7 ; (add_stairs.s5 + 0)
.s12:
;  60, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
32ec : a5 4b __ LDA T4 + 0 
32ee : 8d e7 9f STA $9fe7 ; (idx + 0)
;  59, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
32f1 : b9 07 4c LDA $4c07,y ; (rooms + 7)
32f4 : 8d e5 9f STA $9fe5 ; (leg1_end_x + 0)
.s5:
;  56, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
32f7 : ad e4 9f LDA $9fe4 ; (random_offset_x + 0)
32fa : c5 4a __ CMP T3 + 0 
32fc : 90 d1 __ BCC $32cf ; (add_stairs.l6 + 0)
.s8:
;  65, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
32fe : a9 00 __ LDA #$00
3300 : 8d e3 9f STA $9fe3 ; (screen_offset + 1)
;  66, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3303 : 8d e2 9f STA $9fe2 ; (best_distance + 0)
;  67, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3306 : a2 db __ LDX #$db
3308 : 86 0e __ STX P1 
330a : a2 15 __ LDX #$15
330c : 86 0f __ STX P2 
.l16:
330e : 85 4b __ STA T4 + 0 
3310 : 29 03 __ AND #$03
3312 : d0 03 __ BNE $3317 ; (add_stairs.s76 + 0)
.s19:
3314 : 20 af 0f JSR $0faf ; (print_text.s0 + 0)
.s76:
;  68, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3317 : a5 4b __ LDA T4 + 0 
3319 : cd e7 9f CMP $9fe7 ; (idx + 0)
331c : f0 19 __ BEQ $3337 ; (add_stairs.s15 + 0)
.s25:
331e : 0a __ __ ASL
331f : 0a __ __ ASL
3320 : 0a __ __ ASL
3321 : a8 __ __ TAY
3322 : ad e3 9f LDA $9fe3 ; (screen_offset + 1)
3325 : d9 07 4c CMP $4c07,y ; (rooms + 7)
3328 : b0 0b __ BCS $3335 ; (add_stairs.s1002 + 0)
.s22:
;  70, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
332a : a5 4b __ LDA T4 + 0 
332c : 8d e6 9f STA $9fe6 ; (screen_pos + 1)
;  69, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
332f : b9 07 4c LDA $4c07,y ; (rooms + 7)
3332 : 8d e3 9f STA $9fe3 ; (screen_offset + 1)
.s1002:
;  66, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3335 : a5 4b __ LDA T4 + 0 
.s15:
3337 : 18 __ __ CLC
3338 : 69 01 __ ADC #$01
333a : 8d e2 9f STA $9fe2 ; (best_distance + 0)
333d : c5 4a __ CMP T3 + 0 
333f : 90 cd __ BCC $330e ; (add_stairs.l16 + 0)
.s18:
;  76, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3341 : ad e7 9f LDA $9fe7 ; (idx + 0)
3344 : 85 0e __ STA P1 
3346 : a9 e1 __ LDA #$e1
3348 : 85 0f __ STA P2 
334a : a9 9f __ LDA #$9f
334c : 85 12 __ STA P5 
334e : a9 9f __ LDA #$9f
3350 : 85 10 __ STA P3 
3352 : a9 e0 __ LDA #$e0
3354 : 85 11 __ STA P4 
3356 : 20 0b 0d JSR $0d0b ; (get_room_center.s0 + 0)
;  77, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3359 : ad e1 9f LDA $9fe1 ; (r1 + 0)
335c : 85 48 __ STA T1 + 0 
335e : 85 0d __ STA P0 
3360 : ad e0 9f LDA $9fe0 ; (y + 0)
3363 : 85 49 __ STA T2 + 0 
3365 : 85 0e __ STA P1 
3367 : 20 c9 33 JSR $33c9 ; (coords_in_bounds.s0 + 0)
336a : aa __ __ TAX
336b : f0 0f __ BEQ $337c ; (add_stairs.s28 + 0)
.s26:
;  78, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
336d : a5 48 __ LDA T1 + 0 
336f : 85 10 __ STA P3 
3371 : a5 49 __ LDA T2 + 0 
3373 : 85 11 __ STA P4 
3375 : a9 04 __ LDA #$04
3377 : 85 12 __ STA P5 
3379 : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
.s28:
;  83, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
337c : ad e6 9f LDA $9fe6 ; (screen_pos + 1)
337f : 85 0e __ STA P1 
3381 : a9 df __ LDA #$df
3383 : 85 0f __ STA P2 
3385 : a9 9f __ LDA #$9f
3387 : 85 12 __ STA P5 
3389 : a9 9f __ LDA #$9f
338b : 85 10 __ STA P3 
338d : a9 de __ LDA #$de
338f : 85 11 __ STA P4 
3391 : 20 0b 0d JSR $0d0b ; (get_room_center.s0 + 0)
;  84, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3394 : ad df 9f LDA $9fdf ; (leg_length + 0)
3397 : 85 48 __ STA T1 + 0 
3399 : 85 0d __ STA P0 
339b : ad de 9f LDA $9fde ; (pivot_x + 0)
339e : 85 49 __ STA T2 + 0 
33a0 : 85 0e __ STA P1 
33a2 : 20 c9 33 JSR $33c9 ; (coords_in_bounds.s0 + 0)
33a5 : aa __ __ TAX
33a6 : d0 01 __ BNE $33a9 ; (add_stairs.s29 + 0)
.s1001:
;  49, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
33a8 : 60 __ __ RTS
.s29:
;  85, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
33a9 : a5 48 __ LDA T1 + 0 
33ab : 85 10 __ STA P3 
33ad : a5 49 __ LDA T2 + 0 
33af : 85 11 __ STA P4 
33b1 : a9 05 __ LDA #$05
33b3 : 85 12 __ STA P5 
33b5 : 4c f1 0f JMP $0ff1 ; (set_tile_raw.s0 + 0)
--------------------------------------------------------------------
33b8 : __ __ __ BYT 0a 0a 50 6c 61 63 69 6e 67 20 73 74 61 69 72 73 : ..Placing stairs
33c8 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
coords_in_bounds: ; coords_in_bounds(u8,u8)->u8
.s0:
; 398, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
33c9 : a5 0d __ LDA P0 ; (x + 0)
33cb : c9 40 __ CMP #$40
33cd : b0 0a __ BCS $33d9 ; (coords_in_bounds.s2 + 0)
.s6:
33cf : a5 0e __ LDA P1 ; (y + 0)
33d1 : c9 40 __ CMP #$40
33d3 : a9 00 __ LDA #$00
33d5 : 2a __ __ ROL
33d6 : 49 01 __ EOR #$01
33d8 : 60 __ __ RTS
.s2:
; 398, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
33d9 : a9 00 __ LDA #$00
.s1001:
33db : 60 __ __ RTS
--------------------------------------------------------------------
add_walls: ; add_walls()->void
.s0:
;  97, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
33dc : a9 2a __ LDA #$2a
33de : 85 0e __ STA P1 
33e0 : a9 37 __ LDA #$37
33e2 : 85 0f __ STA P2 
33e4 : 20 af 0f JSR $0faf ; (print_text.s0 + 0)
;  99, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
33e7 : a9 00 __ LDA #$00
33e9 : 8d e6 9f STA $9fe6 ; (screen_pos + 1)
.l2:
; 102, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
33ec : a9 00 __ LDA #$00
33ee : 8d e7 9f STA $9fe7 ; (idx + 0)
.l9:
; 103, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
33f1 : 85 4b __ STA T4 + 0 
33f3 : 85 0f __ STA P2 
33f5 : ad e6 9f LDA $9fe6 ; (screen_pos + 1)
33f8 : 85 4c __ STA T5 + 0 
33fa : 85 10 __ STA P3 
33fc : 20 3a 37 JSR $373a ; (get_tile_raw.s0 + 0)
33ff : a5 1b __ LDA ACCU + 0 
3401 : 8d e5 9f STA $9fe5 ; (leg1_end_x + 0)
; 106, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3404 : 20 56 37 JSR $3756 ; (is_walkable_tile.s0 + 0)
3407 : aa __ __ TAX
3408 : f0 03 __ BEQ $340d ; (add_walls.s50 + 0)
340a : 4c be 35 JMP $35be ; (add_walls.s11 + 0)
.s50:
; 102, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
340d : a5 4c __ LDA T5 + 0 
340f : 85 10 __ STA P3 
3411 : e6 4b __ INC T4 + 0 
3413 : a5 4b __ LDA T4 + 0 
3415 : 8d e7 9f STA $9fe7 ; (idx + 0)
; 103, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3418 : 85 0f __ STA P2 
341a : 20 3a 37 JSR $373a ; (get_tile_raw.s0 + 0)
341d : a5 1b __ LDA ACCU + 0 
341f : 8d e5 9f STA $9fe5 ; (leg1_end_x + 0)
; 106, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3422 : 20 56 37 JSR $3756 ; (is_walkable_tile.s0 + 0)
3425 : aa __ __ TAX
3426 : d0 2a __ BNE $3452 ; (add_walls.s52 + 0)
.s5:
; 102, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3428 : 18 __ __ CLC
3429 : a5 4b __ LDA T4 + 0 
342b : 69 01 __ ADC #$01
342d : 8d e7 9f STA $9fe7 ; (idx + 0)
3430 : c9 3f __ CMP #$3f
3432 : 90 bd __ BCC $33f1 ; (add_walls.l9 + 0)
.s8:
; 136, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3434 : a5 4c __ LDA T5 + 0 
3436 : 29 07 __ AND #$07
3438 : d0 0b __ BNE $3445 ; (add_walls.s1 + 0)
.s91:
343a : a9 db __ LDA #$db
343c : 85 0e __ STA P1 
343e : a9 15 __ LDA #$15
3440 : 85 0f __ STA P2 
3442 : 20 af 0f JSR $0faf ; (print_text.s0 + 0)
.s1:
;  99, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3445 : 18 __ __ CLC
3446 : a5 4c __ LDA T5 + 0 
3448 : 69 01 __ ADC #$01
344a : 8d e6 9f STA $9fe6 ; (screen_pos + 1)
344d : c9 40 __ CMP #$40
344f : 90 9b __ BCC $33ec ; (add_walls.l2 + 0)
.s1001:
; 138, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3451 : 60 __ __ RTS
.s52:
; 108, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3452 : a5 4c __ LDA T5 + 0 
3454 : 85 49 __ STA T1 + 0 
3456 : d0 06 __ BNE $345e ; (add_walls.s1002 + 0)
.s1003:
3458 : a9 00 __ LDA #$00
345a : 85 4d __ STA T6 + 0 
345c : f0 20 __ BEQ $347e ; (add_walls.s57 + 0)
.s1002:
345e : aa __ __ TAX
345f : ca __ __ DEX
3460 : 86 48 __ STX T0 + 0 
3462 : 86 10 __ STX P3 
3464 : a9 01 __ LDA #$01
3466 : 85 4d __ STA T6 + 0 
3468 : 20 3a 37 JSR $373a ; (get_tile_raw.s0 + 0)
346b : a5 1b __ LDA ACCU + 0 
346d : d0 0f __ BNE $347e ; (add_walls.s57 + 0)
.s55:
; 109, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
346f : a5 0f __ LDA P2 
3471 : 85 10 __ STA P3 
3473 : a5 48 __ LDA T0 + 0 
3475 : 85 11 __ STA P4 
3477 : a9 01 __ LDA #$01
3479 : 85 12 __ STA P5 
347b : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
.s57:
; 111, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
347e : a5 4c __ LDA T5 + 0 
3480 : c9 3f __ CMP #$3f
3482 : a9 00 __ LDA #$00
3484 : 2a __ __ ROL
3485 : 49 01 __ EOR #$01
3487 : 85 4e __ STA T7 + 0 
3489 : f0 21 __ BEQ $34ac ; (add_walls.s61 + 0)
.s62:
348b : a5 4b __ LDA T4 + 0 
348d : 85 0f __ STA P2 
348f : a6 4c __ LDX T5 + 0 
3491 : e8 __ __ INX
3492 : 86 48 __ STX T0 + 0 
3494 : 86 10 __ STX P3 
3496 : 20 3a 37 JSR $373a ; (get_tile_raw.s0 + 0)
3499 : a5 1b __ LDA ACCU + 0 
349b : d0 0f __ BNE $34ac ; (add_walls.s61 + 0)
.s59:
; 112, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
349d : a5 0f __ LDA P2 
349f : 85 10 __ STA P3 
34a1 : a5 48 __ LDA T0 + 0 
34a3 : 85 11 __ STA P4 
34a5 : a9 01 __ LDA #$01
34a7 : 85 12 __ STA P5 
34a9 : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
.s61:
; 114, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
34ac : a5 4b __ LDA T4 + 0 
34ae : f0 02 __ BEQ $34b2 ; (add_walls.s1031 + 0)
.s1030:
34b0 : a9 01 __ LDA #$01
.s1031:
34b2 : 85 4f __ STA T8 + 0 
34b4 : f0 1f __ BEQ $34d5 ; (add_walls.s65 + 0)
.s66:
34b6 : a5 4c __ LDA T5 + 0 
34b8 : 85 10 __ STA P3 
34ba : a6 4b __ LDX T4 + 0 
34bc : ca __ __ DEX
34bd : 86 0f __ STX P2 
34bf : 20 3a 37 JSR $373a ; (get_tile_raw.s0 + 0)
34c2 : a5 1b __ LDA ACCU + 0 
34c4 : d0 0f __ BNE $34d5 ; (add_walls.s65 + 0)
.s63:
; 115, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
34c6 : a5 0f __ LDA P2 
34c8 : 85 10 __ STA P3 
34ca : a5 4c __ LDA T5 + 0 
34cc : 85 11 __ STA P4 
34ce : a9 01 __ LDA #$01
34d0 : 85 12 __ STA P5 
34d2 : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
.s65:
; 117, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
34d5 : a5 4b __ LDA T4 + 0 
34d7 : c9 3f __ CMP #$3f
34d9 : a9 00 __ LDA #$00
34db : 2a __ __ ROL
34dc : 49 01 __ EOR #$01
34de : 85 50 __ STA T9 + 0 
34e0 : f0 21 __ BEQ $3503 ; (add_walls.s69 + 0)
.s70:
34e2 : a5 4c __ LDA T5 + 0 
34e4 : 85 10 __ STA P3 
34e6 : a6 4b __ LDX T4 + 0 
34e8 : e8 __ __ INX
34e9 : 86 48 __ STX T0 + 0 
34eb : 86 0f __ STX P2 
34ed : 20 3a 37 JSR $373a ; (get_tile_raw.s0 + 0)
34f0 : a5 1b __ LDA ACCU + 0 
34f2 : d0 0f __ BNE $3503 ; (add_walls.s69 + 0)
.s67:
; 118, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
34f4 : a5 48 __ LDA T0 + 0 
34f6 : 85 10 __ STA P3 
34f8 : a5 4c __ LDA T5 + 0 
34fa : 85 11 __ STA P4 
34fc : a9 01 __ LDA #$01
34fe : 85 12 __ STA P5 
3500 : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
.s69:
; 122, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3503 : a5 4f __ LDA T8 + 0 
3505 : f0 1a __ BEQ $3521 ; (add_walls.s73 + 0)
.s75:
3507 : a5 4d __ LDA T6 + 0 
3509 : f0 16 __ BEQ $3521 ; (add_walls.s73 + 0)
.s74:
350b : a6 4b __ LDX T4 + 0 
350d : ca __ __ DEX
350e : 86 0f __ STX P2 
3510 : a6 4c __ LDX T5 + 0 
3512 : ca __ __ DEX
3513 : 86 4a __ STX T2 + 0 
3515 : 86 10 __ STX P3 
3517 : 20 3a 37 JSR $373a ; (get_tile_raw.s0 + 0)
351a : a5 1b __ LDA ACCU + 0 
351c : d0 03 __ BNE $3521 ; (add_walls.s73 + 0)
351e : 4c a8 35 JMP $35a8 ; (add_walls.s71 + 0)
.s73:
; 125, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3521 : a5 50 __ LDA T9 + 0 
3523 : f0 28 __ BEQ $354d ; (add_walls.s78 + 0)
.s80:
3525 : a5 4d __ LDA T6 + 0 
3527 : f0 24 __ BEQ $354d ; (add_walls.s78 + 0)
.s79:
3529 : a6 4b __ LDX T4 + 0 
352b : e8 __ __ INX
352c : 86 48 __ STX T0 + 0 
352e : 86 0f __ STX P2 
3530 : a6 4c __ LDX T5 + 0 
3532 : ca __ __ DEX
3533 : 86 4a __ STX T2 + 0 
3535 : 86 10 __ STX P3 
3537 : 20 3a 37 JSR $373a ; (get_tile_raw.s0 + 0)
353a : a5 1b __ LDA ACCU + 0 
353c : d0 0f __ BNE $354d ; (add_walls.s78 + 0)
.s76:
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
353e : a5 48 __ LDA T0 + 0 
3540 : 85 10 __ STA P3 
3542 : a5 4a __ LDA T2 + 0 
3544 : 85 11 __ STA P4 
3546 : a9 01 __ LDA #$01
3548 : 85 12 __ STA P5 
354a : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
.s78:
; 128, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
354d : a5 4f __ LDA T8 + 0 
354f : f0 26 __ BEQ $3577 ; (add_walls.s83 + 0)
.s85:
3551 : a5 4e __ LDA T7 + 0 
3553 : f0 22 __ BEQ $3577 ; (add_walls.s83 + 0)
.s84:
3555 : a6 4b __ LDX T4 + 0 
3557 : ca __ __ DEX
3558 : 86 0f __ STX P2 
355a : a6 4c __ LDX T5 + 0 
355c : e8 __ __ INX
355d : 86 4a __ STX T2 + 0 
355f : 86 10 __ STX P3 
3561 : 20 3a 37 JSR $373a ; (get_tile_raw.s0 + 0)
3564 : a5 1b __ LDA ACCU + 0 
3566 : d0 0f __ BNE $3577 ; (add_walls.s83 + 0)
.s81:
; 129, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3568 : a5 0f __ LDA P2 
356a : 85 10 __ STA P3 
356c : a5 4a __ LDA T2 + 0 
356e : 85 11 __ STA P4 
3570 : a9 01 __ LDA #$01
3572 : 85 12 __ STA P5 
3574 : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
.s83:
; 131, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3577 : a5 50 __ LDA T9 + 0 
3579 : d0 03 __ BNE $357e ; (add_walls.s90 + 0)
357b : 4c 28 34 JMP $3428 ; (add_walls.s5 + 0)
.s90:
357e : a5 4e __ LDA T7 + 0 
3580 : f0 f9 __ BEQ $357b ; (add_walls.s83 + 4)
.s89:
3582 : a6 4b __ LDX T4 + 0 
3584 : e8 __ __ INX
3585 : 86 48 __ STX T0 + 0 
3587 : 86 0f __ STX P2 
3589 : e6 49 __ INC T1 + 0 
358b : a5 49 __ LDA T1 + 0 
358d : 85 10 __ STA P3 
358f : 20 3a 37 JSR $373a ; (get_tile_raw.s0 + 0)
3592 : a5 1b __ LDA ACCU + 0 
3594 : d0 e5 __ BNE $357b ; (add_walls.s83 + 4)
.s86:
; 132, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3596 : a5 48 __ LDA T0 + 0 
3598 : 85 10 __ STA P3 
359a : a5 49 __ LDA T1 + 0 
359c : 85 11 __ STA P4 
359e : a9 01 __ LDA #$01
35a0 : 85 12 __ STA P5 
35a2 : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
35a5 : 4c 28 34 JMP $3428 ; (add_walls.s5 + 0)
.s71:
; 123, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
35a8 : a5 0f __ LDA P2 
35aa : 85 10 __ STA P3 
35ac : a5 4a __ LDA T2 + 0 
35ae : 85 11 __ STA P4 
35b0 : a9 01 __ LDA #$01
35b2 : 85 12 __ STA P5 
35b4 : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
; 125, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
35b7 : a5 50 __ LDA T9 + 0 
35b9 : f0 96 __ BEQ $3551 ; (add_walls.s85 + 0)
35bb : 4c 29 35 JMP $3529 ; (add_walls.s79 + 0)
.s11:
; 108, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
35be : a5 4c __ LDA T5 + 0 
35c0 : 85 49 __ STA T1 + 0 
35c2 : d0 06 __ BNE $35ca ; (add_walls.s1014 + 0)
.s1015:
35c4 : a9 00 __ LDA #$00
35c6 : 85 4d __ STA T6 + 0 
35c8 : f0 20 __ BEQ $35ea ; (add_walls.s16 + 0)
.s1014:
35ca : aa __ __ TAX
35cb : ca __ __ DEX
35cc : 86 48 __ STX T0 + 0 
35ce : 86 10 __ STX P3 
35d0 : a9 01 __ LDA #$01
35d2 : 85 4d __ STA T6 + 0 
35d4 : 20 3a 37 JSR $373a ; (get_tile_raw.s0 + 0)
35d7 : a5 1b __ LDA ACCU + 0 
35d9 : d0 0f __ BNE $35ea ; (add_walls.s16 + 0)
.s14:
; 109, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
35db : a5 0f __ LDA P2 
35dd : 85 10 __ STA P3 
35df : a5 48 __ LDA T0 + 0 
35e1 : 85 11 __ STA P4 
35e3 : a9 01 __ LDA #$01
35e5 : 85 12 __ STA P5 
35e7 : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
.s16:
; 111, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
35ea : a5 4c __ LDA T5 + 0 
35ec : c9 3f __ CMP #$3f
35ee : a9 00 __ LDA #$00
35f0 : 2a __ __ ROL
35f1 : 49 01 __ EOR #$01
35f3 : 85 4e __ STA T7 + 0 
35f5 : f0 21 __ BEQ $3618 ; (add_walls.s20 + 0)
.s21:
35f7 : a5 4b __ LDA T4 + 0 
35f9 : 85 0f __ STA P2 
35fb : a6 4c __ LDX T5 + 0 
35fd : e8 __ __ INX
35fe : 86 48 __ STX T0 + 0 
3600 : 86 10 __ STX P3 
3602 : 20 3a 37 JSR $373a ; (get_tile_raw.s0 + 0)
3605 : a5 1b __ LDA ACCU + 0 
3607 : d0 0f __ BNE $3618 ; (add_walls.s20 + 0)
.s18:
; 112, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3609 : a5 0f __ LDA P2 
360b : 85 10 __ STA P3 
360d : a5 48 __ LDA T0 + 0 
360f : 85 11 __ STA P4 
3611 : a9 01 __ LDA #$01
3613 : 85 12 __ STA P5 
3615 : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
.s20:
; 114, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3618 : a5 4b __ LDA T4 + 0 
361a : f0 02 __ BEQ $361e ; (add_walls.s1028 + 0)
.s1027:
361c : a9 01 __ LDA #$01
.s1028:
361e : 85 4f __ STA T8 + 0 
3620 : f0 1f __ BEQ $3641 ; (add_walls.s24 + 0)
.s25:
3622 : a5 4c __ LDA T5 + 0 
3624 : 85 10 __ STA P3 
3626 : a6 4b __ LDX T4 + 0 
3628 : ca __ __ DEX
3629 : 86 0f __ STX P2 
362b : 20 3a 37 JSR $373a ; (get_tile_raw.s0 + 0)
362e : a5 1b __ LDA ACCU + 0 
3630 : d0 0f __ BNE $3641 ; (add_walls.s24 + 0)
.s22:
; 115, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3632 : a5 0f __ LDA P2 
3634 : 85 10 __ STA P3 
3636 : a5 4c __ LDA T5 + 0 
3638 : 85 11 __ STA P4 
363a : a9 01 __ LDA #$01
363c : 85 12 __ STA P5 
363e : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
.s24:
; 117, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3641 : a5 4b __ LDA T4 + 0 
3643 : c9 3f __ CMP #$3f
3645 : a9 00 __ LDA #$00
3647 : 2a __ __ ROL
3648 : 49 01 __ EOR #$01
364a : 85 50 __ STA T9 + 0 
364c : f0 21 __ BEQ $366f ; (add_walls.s28 + 0)
.s29:
364e : a5 4c __ LDA T5 + 0 
3650 : 85 10 __ STA P3 
3652 : a6 4b __ LDX T4 + 0 
3654 : e8 __ __ INX
3655 : 86 48 __ STX T0 + 0 
3657 : 86 0f __ STX P2 
3659 : 20 3a 37 JSR $373a ; (get_tile_raw.s0 + 0)
365c : a5 1b __ LDA ACCU + 0 
365e : d0 0f __ BNE $366f ; (add_walls.s28 + 0)
.s26:
; 118, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3660 : a5 48 __ LDA T0 + 0 
3662 : 85 10 __ STA P3 
3664 : a5 4c __ LDA T5 + 0 
3666 : 85 11 __ STA P4 
3668 : a9 01 __ LDA #$01
366a : 85 12 __ STA P5 
366c : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
.s28:
; 122, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
366f : a5 4f __ LDA T8 + 0 
3671 : f0 1a __ BEQ $368d ; (add_walls.s32 + 0)
.s34:
3673 : a5 4d __ LDA T6 + 0 
3675 : f0 16 __ BEQ $368d ; (add_walls.s32 + 0)
.s33:
3677 : a6 4b __ LDX T4 + 0 
3679 : ca __ __ DEX
367a : 86 0f __ STX P2 
367c : a6 4c __ LDX T5 + 0 
367e : ca __ __ DEX
367f : 86 4a __ STX T2 + 0 
3681 : 86 10 __ STX P3 
3683 : 20 3a 37 JSR $373a ; (get_tile_raw.s0 + 0)
3686 : a5 1b __ LDA ACCU + 0 
3688 : d0 03 __ BNE $368d ; (add_walls.s32 + 0)
368a : 4c 14 37 JMP $3714 ; (add_walls.s30 + 0)
.s32:
; 125, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
368d : a5 50 __ LDA T9 + 0 
368f : f0 28 __ BEQ $36b9 ; (add_walls.s37 + 0)
.s39:
3691 : a5 4d __ LDA T6 + 0 
3693 : f0 24 __ BEQ $36b9 ; (add_walls.s37 + 0)
.s38:
3695 : a6 4b __ LDX T4 + 0 
3697 : e8 __ __ INX
3698 : 86 48 __ STX T0 + 0 
369a : 86 0f __ STX P2 
369c : a6 4c __ LDX T5 + 0 
369e : ca __ __ DEX
369f : 86 4a __ STX T2 + 0 
36a1 : 86 10 __ STX P3 
36a3 : 20 3a 37 JSR $373a ; (get_tile_raw.s0 + 0)
36a6 : a5 1b __ LDA ACCU + 0 
36a8 : d0 0f __ BNE $36b9 ; (add_walls.s37 + 0)
.s35:
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
36aa : a5 48 __ LDA T0 + 0 
36ac : 85 10 __ STA P3 
36ae : a5 4a __ LDA T2 + 0 
36b0 : 85 11 __ STA P4 
36b2 : a9 01 __ LDA #$01
36b4 : 85 12 __ STA P5 
36b6 : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
.s37:
; 128, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
36b9 : a5 4f __ LDA T8 + 0 
36bb : f0 26 __ BEQ $36e3 ; (add_walls.s42 + 0)
.s44:
36bd : a5 4e __ LDA T7 + 0 
36bf : f0 22 __ BEQ $36e3 ; (add_walls.s42 + 0)
.s43:
36c1 : a6 4b __ LDX T4 + 0 
36c3 : ca __ __ DEX
36c4 : 86 0f __ STX P2 
36c6 : a6 4c __ LDX T5 + 0 
36c8 : e8 __ __ INX
36c9 : 86 4a __ STX T2 + 0 
36cb : 86 10 __ STX P3 
36cd : 20 3a 37 JSR $373a ; (get_tile_raw.s0 + 0)
36d0 : a5 1b __ LDA ACCU + 0 
36d2 : d0 0f __ BNE $36e3 ; (add_walls.s42 + 0)
.s40:
; 129, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
36d4 : a5 0f __ LDA P2 
36d6 : 85 10 __ STA P3 
36d8 : a5 4a __ LDA T2 + 0 
36da : 85 11 __ STA P4 
36dc : a9 01 __ LDA #$01
36de : 85 12 __ STA P5 
36e0 : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
.s42:
; 131, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
36e3 : a5 50 __ LDA T9 + 0 
36e5 : d0 03 __ BNE $36ea ; (add_walls.s49 + 0)
36e7 : 4c 0d 34 JMP $340d ; (add_walls.s50 + 0)
.s49:
36ea : a5 4e __ LDA T7 + 0 
36ec : f0 f9 __ BEQ $36e7 ; (add_walls.s42 + 4)
.s48:
36ee : a6 4b __ LDX T4 + 0 
36f0 : e8 __ __ INX
36f1 : 86 48 __ STX T0 + 0 
36f3 : 86 0f __ STX P2 
36f5 : e6 49 __ INC T1 + 0 
36f7 : a5 49 __ LDA T1 + 0 
36f9 : 85 10 __ STA P3 
36fb : 20 3a 37 JSR $373a ; (get_tile_raw.s0 + 0)
36fe : a5 1b __ LDA ACCU + 0 
3700 : d0 e5 __ BNE $36e7 ; (add_walls.s42 + 4)
.s45:
; 132, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3702 : a5 48 __ LDA T0 + 0 
3704 : 85 10 __ STA P3 
3706 : a5 49 __ LDA T1 + 0 
3708 : 85 11 __ STA P4 
370a : a9 01 __ LDA #$01
370c : 85 12 __ STA P5 
370e : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
3711 : 4c 0d 34 JMP $340d ; (add_walls.s50 + 0)
.s30:
; 123, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3714 : a5 0f __ LDA P2 
3716 : 85 10 __ STA P3 
3718 : a5 4a __ LDA T2 + 0 
371a : 85 11 __ STA P4 
371c : a9 01 __ LDA #$01
371e : 85 12 __ STA P5 
3720 : 20 f1 0f JSR $0ff1 ; (set_tile_raw.s0 + 0)
; 125, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3723 : a5 50 __ LDA T9 + 0 
3725 : f0 96 __ BEQ $36bd ; (add_walls.s44 + 0)
3727 : 4c 95 36 JMP $3695 ; (add_walls.s38 + 0)
--------------------------------------------------------------------
372a : __ __ __ BYT 0a 0a 50 6c 61 63 69 6e 67 20 77 61 6c 6c 73 00 : ..Placing walls.
--------------------------------------------------------------------
get_tile_raw: ; get_tile_raw(u8,u8)->u8
.s0:
; 326, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
373a : a5 0f __ LDA P2 ; (x + 0)
373c : c9 40 __ CMP #$40
373e : b0 06 __ BCS $3746 ; (get_tile_raw.s1 + 0)
.s4:
3740 : a5 10 __ LDA P3 ; (y + 0)
3742 : c9 40 __ CMP #$40
3744 : 90 04 __ BCC $374a ; (get_tile_raw.s3 + 0)
.s1:
3746 : a9 00 __ LDA #$00
3748 : b0 09 __ BCS $3753 ; (get_tile_raw.s1001 + 0)
.s3:
; 327, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
374a : 85 0e __ STA P1 
374c : a5 0f __ LDA P2 ; (x + 0)
374e : 85 0d __ STA P0 
3750 : 20 ca 24 JSR $24ca ; (get_tile_core.s0 + 0)
.s1001:
3753 : 85 1b __ STA ACCU + 0 
3755 : 60 __ __ RTS
--------------------------------------------------------------------
is_walkable_tile: ; is_walkable_tile(u8)->u8
.s0:
;  26, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3756 : c9 02 __ CMP #$02
3758 : f0 04 __ BEQ $375e ; (is_walkable_tile.s1 + 0)
.s4:
375a : c9 03 __ CMP #$03
375c : d0 03 __ BNE $3761 ; (is_walkable_tile.s2 + 0)
.s1:
375e : a9 01 __ LDA #$01
3760 : 60 __ __ RTS
.s2:
;  26, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_generation.c"
3761 : a9 00 __ LDA #$00
.s1001:
3763 : 60 __ __ RTS
--------------------------------------------------------------------
render_map_viewport: ; render_map_viewport(u8)->void
.s0:
; 111, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3764 : a5 14 __ LDA P7 ; (force_refresh + 0)
3766 : f0 0f __ BEQ $3777 ; (render_map_viewport.s3 + 0)
.s1:
; 112, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3768 : 20 df 08 JSR $08df ; (clrscr.s0 + 0)
; 114, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
376b : a9 00 __ LDA #$00
376d : 8d f3 40 STA $40f3 ; (last_scroll_direction + 0)
; 113, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3770 : a9 01 __ LDA #$01
3772 : 8d f2 40 STA $40f2 ; (screen_dirty + 0)
3775 : d0 05 __ BNE $377c ; (render_map_viewport.s6 + 0)
.s3:
; 118, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3777 : ad f2 40 LDA $40f2 ; (screen_dirty + 0)
377a : f0 1b __ BEQ $3797 ; (render_map_viewport.s1001 + 0)
.s6:
; 123, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
377c : ad f3 40 LDA $40f3 ; (last_scroll_direction + 0)
377f : 8d d6 9f STA $9fd6 ; (grid_positions + 8)
; 126, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3782 : d0 06 __ BNE $378a ; (render_map_viewport.s8 + 0)
.s9:
; 131, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3784 : 20 58 3b JSR $3b58 ; (update_full_screen.s0 + 0)
; 137, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3787 : 4c 8f 37 JMP $378f ; (render_map_viewport.s1002 + 0)
.s8:
; 128, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
378a : 85 13 __ STA P6 
378c : 20 98 37 JSR $3798 ; (update_screen_with_scroll.s1000 + 0)
.s1002:
; 136, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
378f : a9 00 __ LDA #$00
3791 : 8d f3 40 STA $40f3 ; (last_scroll_direction + 0)
; 135, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3794 : 8d f2 40 STA $40f2 ; (screen_dirty + 0)
.s1001:
; 119, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3797 : 60 __ __ RTS
--------------------------------------------------------------------
update_screen_with_scroll: ; update_screen_with_scroll(u8)->void
.s1000:
3798 : a5 53 __ LDA T5 + 0 
379a : 8d d7 9f STA $9fd7 ; (grid_positions + 9)
379d : a5 54 __ LDA T6 + 0 
379f : 8d d8 9f STA $9fd8 ; (grid_positions + 10)
37a2 : a5 55 __ LDA T7 + 0 
37a4 : 8d d9 9f STA $9fd9 ; (grid_positions + 11)
.s0:
; 240, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
37a7 : a5 13 __ LDA P6 ; (scroll_dir + 0)
37a9 : f0 23 __ BEQ $37ce ; (update_screen_with_scroll.s1 + 0)
.s4:
37ab : c9 05 __ CMP #$05
37ad : b0 1f __ BCS $37ce ; (update_screen_with_scroll.s1 + 0)
.s3:
; 246, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
37af : c9 03 __ CMP #$03
37b1 : d0 03 __ BNE $37b6 ; (update_screen_with_scroll.s1003 + 0)
37b3 : 4c 48 3b JMP $3b48 ; (update_screen_with_scroll.s1002 + 0)
.s1003:
37b6 : 85 4b __ STA T1 + 0 
37b8 : a2 00 __ LDX #$00
37ba : 86 4d __ STX T2 + 0 
37bc : c9 03 __ CMP #$03
37be : b0 03 __ BCS $37c3 ; (update_screen_with_scroll.s29 + 0)
37c0 : 4c 2b 3b JMP $3b2b ; (update_screen_with_scroll.s30 + 0)
.s29:
37c3 : c9 04 __ CMP #$04
37c5 : d0 1a __ BNE $37e1 ; (update_screen_with_scroll.s6 + 0)
.s22:
; 250, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
37c7 : ad f0 40 LDA $40f0 ; (view + 0)
37ca : c9 18 __ CMP #$18
37cc : 90 13 __ BCC $37e1 ; (update_screen_with_scroll.s6 + 0)
.s1:
; 241, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
37ce : 20 58 3b JSR $3b58 ; (update_full_screen.s0 + 0)
.s1001:
37d1 : ad d7 9f LDA $9fd7 ; (grid_positions + 9)
37d4 : 85 53 __ STA T5 + 0 
37d6 : ad d8 9f LDA $9fd8 ; (grid_positions + 10)
37d9 : 85 54 __ STA T6 + 0 
37db : ad d9 9f LDA $9fd9 ; (grid_positions + 11)
37de : 85 55 __ STA T7 + 0 
; 330, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
37e0 : 60 __ __ RTS
.s6:
; 254, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
37e1 : 20 fd 16 JSR $16fd ; (get_viewport_max_y.s1001 + 0)
37e4 : 85 54 __ STA T6 + 0 
37e6 : 8d df 9f STA $9fdf ; (leg_length + 0)
; 255, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
37e9 : 20 0e 3c JSR $3c0e ; (get_viewport_max_x.s1001 + 0)
37ec : 85 53 __ STA T5 + 0 
37ee : 8d de 9f STA $9fde ; (pivot_x + 0)
; 257, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
37f1 : a5 4d __ LDA T2 + 0 
37f3 : f0 11 __ BEQ $3806 ; (update_screen_with_scroll.s80 + 0)
.s61:
; 301, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
37f5 : a5 53 __ LDA T5 + 0 
37f7 : c9 01 __ CMP #$01
37f9 : a9 00 __ LDA #$00
37fb : 85 12 __ STA P5 
37fd : 8d e0 9f STA $9fe0 ; (y + 0)
; 302, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3800 : 2a __ __ ROL
3801 : 85 51 __ STA T4 + 0 
3803 : 4c 74 3a JMP $3a74 ; (update_screen_with_scroll.l63 + 0)
.s80:
; 257, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3806 : a5 4b __ LDA T1 + 0 
3808 : c9 03 __ CMP #$03
380a : b0 03 __ BCS $380f ; (update_screen_with_scroll.s81 + 0)
380c : 4c d6 38 JMP $38d6 ; (update_screen_with_scroll.s82 + 0)
.s81:
380f : c9 04 __ CMP #$04
3811 : d0 be __ BNE $37d1 ; (update_screen_with_scroll.s1001 + 0)
.s70:
; 317, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3813 : a5 53 __ LDA T5 + 0 
3815 : c9 01 __ CMP #$01
3817 : a9 00 __ LDA #$00
3819 : 85 12 __ STA P5 
381b : 8d e0 9f STA $9fe0 ; (y + 0)
; 318, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
381e : 2a __ __ ROL
381f : 85 54 __ STA T6 + 0 
.l72:
3821 : a9 00 __ LDA #$00
3823 : 8d e1 9f STA $9fe1 ; (r1 + 0)
3826 : a5 54 __ LDA T6 + 0 
3828 : f0 39 __ BEQ $3863 ; (update_screen_with_scroll.s78 + 0)
.s124:
382a : ad e0 9f LDA $9fe0 ; (y + 0)
382d : 0a __ __ ASL
382e : 85 1b __ STA ACCU + 0 
3830 : a9 00 __ LDA #$00
3832 : 2a __ __ ROL
3833 : 06 1b __ ASL ACCU + 0 
3835 : 2a __ __ ROL
3836 : aa __ __ TAX
3837 : a5 1b __ LDA ACCU + 0 
3839 : 6d e0 9f ADC $9fe0 ; (y + 0)
383c : 85 43 __ STA T0 + 0 
383e : 8a __ __ TXA
383f : 69 00 __ ADC #$00
3841 : 06 43 __ ASL T0 + 0 
3843 : 2a __ __ ROL
3844 : 06 43 __ ASL T0 + 0 
3846 : 2a __ __ ROL
3847 : 06 43 __ ASL T0 + 0 
3849 : 2a __ __ ROL
384a : 18 __ __ CLC
384b : 69 04 __ ADC #$04
384d : 85 44 __ STA T0 + 1 
384f : 18 __ __ CLC
.l1027:
; 319, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3850 : ac e1 9f LDY $9fe1 ; (r1 + 0)
3853 : c8 __ __ INY
3854 : b1 43 __ LDA (T0 + 0),y 
3856 : 88 __ __ DEY
3857 : 91 43 __ STA (T0 + 0),y 
; 318, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3859 : 98 __ __ TYA
385a : 69 01 __ ADC #$01
385c : 8d e1 9f STA $9fe1 ; (r1 + 0)
385f : c5 53 __ CMP T5 + 0 
3861 : 90 ed __ BCC $3850 ; (update_screen_with_scroll.l1027 + 0)
.s78:
; 322, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3863 : a5 53 __ LDA T5 + 0 
3865 : 85 11 __ STA P4 
3867 : ad e0 9f LDA $9fe0 ; (y + 0)
386a : 85 55 __ STA T7 + 0 
386c : 0a __ __ ASL
386d : 0a __ __ ASL
386e : 65 55 __ ADC T7 + 0 
3870 : 0a __ __ ASL
3871 : 0a __ __ ASL
3872 : 85 4f __ STA T3 + 0 
3874 : a9 00 __ LDA #$00
3876 : 2a __ __ ROL
3877 : 06 4f __ ASL T3 + 0 
3879 : 2a __ __ ROL
387a : 85 50 __ STA T3 + 1 
387c : a9 00 __ LDA #$00
387e : 65 4f __ ADC T3 + 0 
3880 : 85 51 __ STA T4 + 0 
3882 : 85 0d __ STA P0 
3884 : a9 4e __ LDA #$4e
3886 : 65 50 __ ADC T3 + 1 
3888 : 85 52 __ STA T4 + 1 
388a : 85 0e __ STA P1 
388c : 18 __ __ CLC
388d : a5 4f __ LDA T3 + 0 
388f : 69 01 __ ADC #$01
3891 : 85 0f __ STA P2 
3893 : a5 50 __ LDA T3 + 1 
3895 : 69 4e __ ADC #$4e
3897 : 85 10 __ STA P3 
3899 : 20 11 3c JSR $3c11 ; (memmove.s0 + 0)
; 324, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
389c : ad f0 40 LDA $40f0 ; (view + 0)
389f : 18 __ __ CLC
38a0 : 65 11 __ ADC P4 
38a2 : 85 0f __ STA P2 
38a4 : ad f1 40 LDA $40f1 ; (view + 1)
38a7 : 18 __ __ CLC
38a8 : 65 55 __ ADC T7 + 0 
38aa : 85 10 __ STA P3 
38ac : 20 c4 3b JSR $3bc4 ; (get_map_tile_fast.s0 + 0)
38af : a5 4f __ LDA T3 + 0 
38b1 : 85 43 __ STA T0 + 0 
38b3 : a9 04 __ LDA #$04
38b5 : 05 50 __ ORA T3 + 1 
38b7 : 85 44 __ STA T0 + 1 
38b9 : a5 1b __ LDA ACCU + 0 
38bb : 8d da 9f STA $9fda ; (grid_positions + 12)
; 325, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
38be : a4 11 __ LDY P4 
38c0 : 91 43 __ STA (T0 + 0),y 
; 326, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
38c2 : 91 51 __ STA (T4 + 0),y 
; 317, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
38c4 : 18 __ __ CLC
38c5 : a5 55 __ LDA T7 + 0 
38c7 : 69 01 __ ADC #$01
38c9 : 8d e0 9f STA $9fe0 ; (y + 0)
38cc : c9 19 __ CMP #$19
38ce : b0 03 __ BCS $38d3 ; (update_screen_with_scroll.s78 + 112)
38d0 : 4c 21 38 JMP $3821 ; (update_screen_with_scroll.l72 + 0)
38d3 : 4c d1 37 JMP $37d1 ; (update_screen_with_scroll.s1001 + 0)
.s82:
; 257, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
38d6 : c9 01 __ CMP #$01
38d8 : d0 03 __ BNE $38dd ; (update_screen_with_scroll.s83 + 0)
38da : 4c c7 39 JMP $39c7 ; (update_screen_with_scroll.s35 + 0)
.s83:
38dd : c9 02 __ CMP #$02
38df : d0 f2 __ BNE $38d3 ; (update_screen_with_scroll.s78 + 112)
.s48:
; 281, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
38e1 : a9 00 __ LDA #$00
38e3 : 8d e0 9f STA $9fe0 ; (y + 0)
38e6 : a5 54 __ LDA T6 + 0 
38e8 : d0 5e __ BNE $3948 ; (update_screen_with_scroll.s1030 + 0)
.s52:
; 291, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
38ea : 85 4b __ STA T1 + 0 
38ec : 0a __ __ ASL
38ed : 0a __ __ ASL
38ee : 65 54 __ ADC T6 + 0 
38f0 : 0a __ __ ASL
38f1 : 0a __ __ ASL
38f2 : 85 43 __ STA T0 + 0 
38f4 : a9 00 __ LDA #$00
38f6 : 8d e1 9f STA $9fe1 ; (r1 + 0)
; 290, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
38f9 : 2a __ __ ROL
38fa : 06 43 __ ASL T0 + 0 
38fc : 2a __ __ ROL
38fd : 8d e3 9f STA $9fe3 ; (screen_offset + 1)
3900 : a5 43 __ LDA T0 + 0 
3902 : 85 4f __ STA T3 + 0 
3904 : 8d e2 9f STA $9fe2 ; (best_distance + 0)
; 292, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3907 : a9 04 __ LDA #$04
3909 : 6d e3 9f ADC $9fe3 ; (screen_offset + 1)
390c : 85 50 __ STA T3 + 1 
390e : 18 __ __ CLC
390f : a9 00 __ LDA #$00
3911 : 65 43 __ ADC T0 + 0 
3913 : 85 4d __ STA T2 + 0 
3915 : a9 4e __ LDA #$4e
3917 : 6d e3 9f ADC $9fe3 ; (screen_offset + 1)
391a : 85 4e __ STA T2 + 1 
391c : 18 __ __ CLC
.l1025:
391d : ad e1 9f LDA $9fe1 ; (r1 + 0)
3920 : 85 54 __ STA T6 + 0 
3922 : 6d f0 40 ADC $40f0 ; (view + 0)
3925 : 85 0f __ STA P2 
3927 : ad f1 40 LDA $40f1 ; (view + 1)
392a : 18 __ __ CLC
392b : 65 4b __ ADC T1 + 0 
392d : 85 10 __ STA P3 
392f : 20 c4 3b JSR $3bc4 ; (get_map_tile_fast.s0 + 0)
3932 : a5 1b __ LDA ACCU + 0 
3934 : 8d dc 9f STA $9fdc ; (grid_positions + 14)
; 293, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3937 : a4 54 __ LDY T6 + 0 
3939 : 91 4f __ STA (T3 + 0),y 
; 294, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
393b : 91 4d __ STA (T2 + 0),y 
; 291, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
393d : c8 __ __ INY
393e : 8c e1 9f STY $9fe1 ; (r1 + 0)
3941 : c0 28 __ CPY #$28
3943 : 90 d8 __ BCC $391d ; (update_screen_with_scroll.l1025 + 0)
3945 : 4c d1 37 JMP $37d1 ; (update_screen_with_scroll.s1001 + 0)
.s1030:
; 287, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3948 : a9 28 __ LDA #$28
394a : 85 11 __ STA P4 
394c : a9 00 __ LDA #$00
394e : 85 12 __ STA P5 
.l50:
; 283, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3950 : ad e0 9f LDA $9fe0 ; (y + 0)
3953 : 85 55 __ STA T7 + 0 
3955 : 0a __ __ ASL
3956 : 85 1b __ STA ACCU + 0 
3958 : a9 00 __ LDA #$00
395a : 8d e1 9f STA $9fe1 ; (r1 + 0)
; 284, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
395d : 2a __ __ ROL
395e : 06 1b __ ASL ACCU + 0 
3960 : 2a __ __ ROL
3961 : aa __ __ TAX
3962 : a5 1b __ LDA ACCU + 0 
3964 : 65 55 __ ADC T7 + 0 
3966 : 85 43 __ STA T0 + 0 
3968 : 8a __ __ TXA
3969 : 69 00 __ ADC #$00
396b : 06 43 __ ASL T0 + 0 
396d : 2a __ __ ROL
396e : 06 43 __ ASL T0 + 0 
3970 : 2a __ __ ROL
3971 : 06 43 __ ASL T0 + 0 
3973 : 2a __ __ ROL
3974 : 85 44 __ STA T0 + 1 
3976 : 18 __ __ CLC
3977 : 69 04 __ ADC #$04
3979 : 85 4c __ STA T1 + 1 
397b : a5 43 __ LDA T0 + 0 
397d : 85 4b __ STA T1 + 0 
397f : 18 __ __ CLC
3980 : 69 28 __ ADC #$28
3982 : 85 4d __ STA T2 + 0 
3984 : a5 44 __ LDA T0 + 1 
3986 : 69 04 __ ADC #$04
3988 : 85 4e __ STA T2 + 1 
.l54:
398a : ac e1 9f LDY $9fe1 ; (r1 + 0)
398d : b1 4d __ LDA (T2 + 0),y 
398f : 91 4b __ STA (T1 + 0),y 
; 283, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3991 : c8 __ __ INY
3992 : 8c e1 9f STY $9fe1 ; (r1 + 0)
3995 : c0 28 __ CPY #$28
3997 : 90 f1 __ BCC $398a ; (update_screen_with_scroll.l54 + 0)
.s56:
; 287, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3999 : 18 __ __ CLC
399a : a9 00 __ LDA #$00
399c : 65 43 __ ADC T0 + 0 
399e : 85 0d __ STA P0 
39a0 : a9 4e __ LDA #$4e
39a2 : 65 44 __ ADC T0 + 1 
39a4 : 85 0e __ STA P1 
39a6 : 18 __ __ CLC
39a7 : a5 43 __ LDA T0 + 0 
39a9 : 69 28 __ ADC #$28
39ab : 85 0f __ STA P2 
39ad : a5 44 __ LDA T0 + 1 
39af : 69 4e __ ADC #$4e
39b1 : 85 10 __ STA P3 
39b3 : 20 11 3c JSR $3c11 ; (memmove.s0 + 0)
; 281, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
39b6 : 18 __ __ CLC
39b7 : a5 55 __ LDA T7 + 0 
39b9 : 69 01 __ ADC #$01
39bb : 8d e0 9f STA $9fe0 ; (y + 0)
39be : c5 54 __ CMP T6 + 0 
39c0 : 90 8e __ BCC $3950 ; (update_screen_with_scroll.l50 + 0)
.s1031:
; 290, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
39c2 : a5 54 __ LDA T6 + 0 
39c4 : 4c ea 38 JMP $38ea ; (update_screen_with_scroll.s52 + 0)
.s35:
; 262, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
39c7 : a5 54 __ LDA T6 + 0 
39c9 : 8d e0 9f STA $9fe0 ; (y + 0)
39cc : c9 01 __ CMP #$01
39ce : 90 79 __ BCC $3a49 ; (update_screen_with_scroll.s39 + 0)
.s1029:
; 268, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
39d0 : a2 28 __ LDX #$28
39d2 : 86 11 __ STX P4 
39d4 : a2 00 __ LDX #$00
39d6 : 86 12 __ STX P5 
.l37:
; 264, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
39d8 : 85 54 __ STA T6 + 0 
39da : 0a __ __ ASL
39db : 85 1b __ STA ACCU + 0 
39dd : a9 00 __ LDA #$00
39df : 8d e1 9f STA $9fe1 ; (r1 + 0)
; 265, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
39e2 : 2a __ __ ROL
39e3 : 06 1b __ ASL ACCU + 0 
39e5 : 2a __ __ ROL
39e6 : aa __ __ TAX
39e7 : a5 1b __ LDA ACCU + 0 
39e9 : 65 54 __ ADC T6 + 0 
39eb : 85 43 __ STA T0 + 0 
39ed : 8a __ __ TXA
39ee : 69 00 __ ADC #$00
39f0 : 06 43 __ ASL T0 + 0 
39f2 : 2a __ __ ROL
39f3 : 06 43 __ ASL T0 + 0 
39f5 : 2a __ __ ROL
39f6 : 06 43 __ ASL T0 + 0 
39f8 : 2a __ __ ROL
39f9 : 85 44 __ STA T0 + 1 
39fb : 18 __ __ CLC
39fc : 69 04 __ ADC #$04
39fe : 85 4e __ STA T2 + 1 
3a00 : 18 __ __ CLC
3a01 : a9 d8 __ LDA #$d8
3a03 : 65 43 __ ADC T0 + 0 
3a05 : 85 4b __ STA T1 + 0 
3a07 : a9 03 __ LDA #$03
3a09 : 65 44 __ ADC T0 + 1 
3a0b : 85 4c __ STA T1 + 1 
3a0d : a5 43 __ LDA T0 + 0 
3a0f : 85 4d __ STA T2 + 0 
.l41:
3a11 : ac e1 9f LDY $9fe1 ; (r1 + 0)
3a14 : b1 4b __ LDA (T1 + 0),y 
3a16 : 91 4d __ STA (T2 + 0),y 
; 264, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3a18 : c8 __ __ INY
3a19 : 8c e1 9f STY $9fe1 ; (r1 + 0)
3a1c : c0 28 __ CPY #$28
3a1e : 90 f1 __ BCC $3a11 ; (update_screen_with_scroll.l41 + 0)
.s43:
; 268, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3a20 : 18 __ __ CLC
3a21 : a9 00 __ LDA #$00
3a23 : 65 43 __ ADC T0 + 0 
3a25 : 85 0d __ STA P0 
3a27 : a9 4e __ LDA #$4e
3a29 : 65 44 __ ADC T0 + 1 
3a2b : 85 0e __ STA P1 
3a2d : 18 __ __ CLC
3a2e : a9 d8 __ LDA #$d8
3a30 : 65 43 __ ADC T0 + 0 
3a32 : 85 0f __ STA P2 
3a34 : a9 4d __ LDA #$4d
3a36 : 65 44 __ ADC T0 + 1 
3a38 : 85 10 __ STA P3 
3a3a : 20 11 3c JSR $3c11 ; (memmove.s0 + 0)
; 262, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3a3d : 18 __ __ CLC
3a3e : a5 54 __ LDA T6 + 0 
3a40 : 69 ff __ ADC #$ff
3a42 : 8d e0 9f STA $9fe0 ; (y + 0)
3a45 : c9 01 __ CMP #$01
3a47 : b0 8f __ BCS $39d8 ; (update_screen_with_scroll.l37 + 0)
.s39:
; 271, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3a49 : 8d e1 9f STA $9fe1 ; (r1 + 0)
.l1023:
; 272, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3a4c : 85 4f __ STA T3 + 0 
3a4e : 6d f0 40 ADC $40f0 ; (view + 0)
3a51 : 85 0f __ STA P2 
3a53 : ad f1 40 LDA $40f1 ; (view + 1)
3a56 : 85 10 __ STA P3 
3a58 : 20 c4 3b JSR $3bc4 ; (get_map_tile_fast.s0 + 0)
3a5b : a5 1b __ LDA ACCU + 0 
3a5d : 8d dd 9f STA $9fdd ; (grid_positions + 15)
; 273, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3a60 : a6 4f __ LDX T3 + 0 
3a62 : 9d 00 04 STA $0400,x 
; 274, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3a65 : 9d 00 4e STA $4e00,x ; (screen_buffer + 0)
; 271, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3a68 : e8 __ __ INX
3a69 : 8e e1 9f STX $9fe1 ; (r1 + 0)
3a6c : 8a __ __ TXA
3a6d : e0 28 __ CPX #$28
3a6f : 90 db __ BCC $3a4c ; (update_screen_with_scroll.l1023 + 0)
3a71 : 4c d1 37 JMP $37d1 ; (update_screen_with_scroll.s1001 + 0)
.l63:
; 302, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3a74 : a6 53 __ LDX T5 + 0 
3a76 : 8e e1 9f STX $9fe1 ; (r1 + 0)
3a79 : a5 51 __ LDA T4 + 0 
3a7b : f0 40 __ BEQ $3abd ; (update_screen_with_scroll.s69 + 0)
.s116:
; 303, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3a7d : ad e0 9f LDA $9fe0 ; (y + 0)
3a80 : 0a __ __ ASL
3a81 : 85 1b __ STA ACCU + 0 
3a83 : a9 00 __ LDA #$00
3a85 : 2a __ __ ROL
3a86 : 06 1b __ ASL ACCU + 0 
3a88 : 2a __ __ ROL
3a89 : a8 __ __ TAY
3a8a : a5 1b __ LDA ACCU + 0 
3a8c : 6d e0 9f ADC $9fe0 ; (y + 0)
3a8f : 85 43 __ STA T0 + 0 
3a91 : 98 __ __ TYA
3a92 : 69 00 __ ADC #$00
3a94 : 06 43 __ ASL T0 + 0 
3a96 : 2a __ __ ROL
3a97 : 06 43 __ ASL T0 + 0 
3a99 : 2a __ __ ROL
3a9a : 06 43 __ ASL T0 + 0 
3a9c : 2a __ __ ROL
3a9d : a8 __ __ TAY
3a9e : 18 __ __ CLC
3a9f : a9 ff __ LDA #$ff
3aa1 : 65 43 __ ADC T0 + 0 
3aa3 : 85 43 __ STA T0 + 0 
3aa5 : 98 __ __ TYA
3aa6 : 69 03 __ ADC #$03
3aa8 : 85 44 __ STA T0 + 1 
.l67:
3aaa : ac e1 9f LDY $9fe1 ; (r1 + 0)
3aad : b1 43 __ LDA (T0 + 0),y 
3aaf : c8 __ __ INY
3ab0 : 91 43 __ STA (T0 + 0),y 
; 302, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3ab2 : 98 __ __ TYA
3ab3 : 18 __ __ CLC
3ab4 : 69 fe __ ADC #$fe
3ab6 : 8d e1 9f STA $9fe1 ; (r1 + 0)
3ab9 : c9 01 __ CMP #$01
3abb : b0 ed __ BCS $3aaa ; (update_screen_with_scroll.l67 + 0)
.s69:
; 306, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3abd : 86 11 __ STX P4 
3abf : ad e0 9f LDA $9fe0 ; (y + 0)
3ac2 : 85 54 __ STA T6 + 0 
3ac4 : 0a __ __ ASL
3ac5 : 0a __ __ ASL
3ac6 : 65 54 __ ADC T6 + 0 
3ac8 : 0a __ __ ASL
3ac9 : 0a __ __ ASL
3aca : 85 4d __ STA T2 + 0 
3acc : a9 00 __ LDA #$00
3ace : 2a __ __ ROL
3acf : 06 4d __ ASL T2 + 0 
3ad1 : 2a __ __ ROL
3ad2 : 85 4e __ STA T2 + 1 
3ad4 : a9 00 __ LDA #$00
3ad6 : 65 4d __ ADC T2 + 0 
3ad8 : 85 4f __ STA T3 + 0 
3ada : 85 0f __ STA P2 
3adc : a9 4e __ LDA #$4e
3ade : 65 4e __ ADC T2 + 1 
3ae0 : 85 50 __ STA T3 + 1 
3ae2 : 85 10 __ STA P3 
3ae4 : 18 __ __ CLC
3ae5 : a5 4d __ LDA T2 + 0 
3ae7 : 69 01 __ ADC #$01
3ae9 : 85 0d __ STA P0 
3aeb : a5 4e __ LDA T2 + 1 
3aed : 69 4e __ ADC #$4e
3aef : 85 0e __ STA P1 
3af1 : 20 11 3c JSR $3c11 ; (memmove.s0 + 0)
; 308, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3af4 : ad f0 40 LDA $40f0 ; (view + 0)
3af7 : 85 0f __ STA P2 
3af9 : ad f1 40 LDA $40f1 ; (view + 1)
3afc : 18 __ __ CLC
3afd : 65 54 __ ADC T6 + 0 
3aff : 85 10 __ STA P3 
3b01 : 20 c4 3b JSR $3bc4 ; (get_map_tile_fast.s0 + 0)
3b04 : a5 4d __ LDA T2 + 0 
3b06 : 85 43 __ STA T0 + 0 
3b08 : a9 04 __ LDA #$04
3b0a : 05 4e __ ORA T2 + 1 
3b0c : 85 44 __ STA T0 + 1 
3b0e : a5 1b __ LDA ACCU + 0 
3b10 : 8d db 9f STA $9fdb ; (grid_positions + 13)
; 309, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3b13 : a0 00 __ LDY #$00
3b15 : 91 43 __ STA (T0 + 0),y 
; 310, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3b17 : 91 4f __ STA (T3 + 0),y 
; 301, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3b19 : 18 __ __ CLC
3b1a : a5 54 __ LDA T6 + 0 
3b1c : 69 01 __ ADC #$01
3b1e : 8d e0 9f STA $9fe0 ; (y + 0)
3b21 : c9 19 __ CMP #$19
3b23 : b0 03 __ BCS $3b28 ; (update_screen_with_scroll.s69 + 107)
3b25 : 4c 74 3a JMP $3a74 ; (update_screen_with_scroll.l63 + 0)
3b28 : 4c d1 37 JMP $37d1 ; (update_screen_with_scroll.s1001 + 0)
.s30:
; 246, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3b2b : c9 01 __ CMP #$01
3b2d : d0 0b __ BNE $3b3a ; (update_screen_with_scroll.s31 + 0)
.s7:
; 247, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3b2f : ad f1 40 LDA $40f1 ; (view + 1)
3b32 : f0 03 __ BEQ $3b37 ; (update_screen_with_scroll.s7 + 8)
3b34 : 4c e1 37 JMP $37e1 ; (update_screen_with_scroll.s6 + 0)
3b37 : 4c ce 37 JMP $37ce ; (update_screen_with_scroll.s1 + 0)
.s31:
; 246, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3b3a : c9 02 __ CMP #$02
3b3c : d0 f6 __ BNE $3b34 ; (update_screen_with_scroll.s7 + 5)
.s12:
; 248, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3b3e : ad f1 40 LDA $40f1 ; (view + 1)
3b41 : c9 27 __ CMP #$27
3b43 : 90 ef __ BCC $3b34 ; (update_screen_with_scroll.s7 + 5)
3b45 : 4c ce 37 JMP $37ce ; (update_screen_with_scroll.s1 + 0)
.s1002:
; 246, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3b48 : a9 01 __ LDA #$01
3b4a : 85 4d __ STA T2 + 0 
3b4c : a9 03 __ LDA #$03
3b4e : 85 4b __ STA T1 + 0 
3b50 : ad f0 40 LDA $40f0 ; (view + 0)
3b53 : d0 df __ BNE $3b34 ; (update_screen_with_scroll.s7 + 5)
3b55 : 4c ce 37 JMP $37ce ; (update_screen_with_scroll.s1 + 0)
--------------------------------------------------------------------
update_full_screen: ; update_full_screen()->void
.s0:
;  93, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3b58 : a9 00 __ LDA #$00
3b5a : 8d e8 9f STA $9fe8 ; (entropy3 + 1)
.l2:
;  97, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3b5d : 85 49 __ STA T6 + 0 
3b5f : 0a __ __ ASL
3b60 : 0a __ __ ASL
3b61 : 65 49 __ ADC T6 + 0 
3b63 : 0a __ __ ASL
3b64 : 0a __ __ ASL
3b65 : 85 43 __ STA T0 + 0 
3b67 : a9 00 __ LDA #$00
3b69 : 8d e7 9f STA $9fe7 ; (idx + 0)
;  94, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3b6c : 2a __ __ ROL
3b6d : 06 43 __ ASL T0 + 0 
3b6f : 2a __ __ ROL
3b70 : 8d e6 9f STA $9fe6 ; (screen_pos + 1)
3b73 : a5 43 __ LDA T0 + 0 
3b75 : 85 47 __ STA T3 + 0 
3b77 : 8d e5 9f STA $9fe5 ; (leg1_end_x + 0)
;  99, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3b7a : a9 04 __ LDA #$04
3b7c : 6d e6 9f ADC $9fe6 ; (screen_pos + 1)
3b7f : 85 48 __ STA T3 + 1 
3b81 : 18 __ __ CLC
3b82 : a9 00 __ LDA #$00
3b84 : 65 43 __ ADC T0 + 0 
3b86 : 85 45 __ STA T2 + 0 
3b88 : a9 4e __ LDA #$4e
3b8a : 6d e6 9f ADC $9fe6 ; (screen_pos + 1)
3b8d : 85 46 __ STA T2 + 1 
3b8f : 18 __ __ CLC
.l1002:
3b90 : ad e7 9f LDA $9fe7 ; (idx + 0)
3b93 : 85 4a __ STA T7 + 0 
3b95 : 6d f0 40 ADC $40f0 ; (view + 0)
3b98 : 85 0f __ STA P2 
3b9a : ad f1 40 LDA $40f1 ; (view + 1)
3b9d : 18 __ __ CLC
3b9e : 65 49 __ ADC T6 + 0 
3ba0 : 85 10 __ STA P3 
3ba2 : 20 c4 3b JSR $3bc4 ; (get_map_tile_fast.s0 + 0)
3ba5 : a5 1b __ LDA ACCU + 0 
3ba7 : 8d e4 9f STA $9fe4 ; (random_offset_x + 0)
; 102, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3baa : a4 4a __ LDY T7 + 0 
3bac : 91 47 __ STA (T3 + 0),y 
; 103, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3bae : 91 45 __ STA (T2 + 0),y 
;  97, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3bb0 : c8 __ __ INY
3bb1 : 8c e7 9f STY $9fe7 ; (idx + 0)
3bb4 : c0 28 __ CPY #$28
3bb6 : 90 d8 __ BCC $3b90 ; (update_full_screen.l1002 + 0)
.s3:
;  93, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3bb8 : a5 49 __ LDA T6 + 0 
3bba : 69 00 __ ADC #$00
3bbc : 8d e8 9f STA $9fe8 ; (entropy3 + 1)
3bbf : c9 19 __ CMP #$19
3bc1 : 90 9a __ BCC $3b5d ; (update_full_screen.l2 + 0)
.s1001:
; 106, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3bc3 : 60 __ __ RTS
--------------------------------------------------------------------
get_map_tile_fast: ; get_map_tile_fast(u8,u8)->u8
.s0:
; 299, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
3bc4 : a5 0f __ LDA P2 ; (map_x + 0)
3bc6 : c9 40 __ CMP #$40
3bc8 : b0 2d __ BCS $3bf7 ; (get_map_tile_fast.s1 + 0)
.s4:
3bca : a5 10 __ LDA P3 ; (map_y + 0)
3bcc : c9 40 __ CMP #$40
3bce : b0 27 __ BCS $3bf7 ; (get_map_tile_fast.s1 + 0)
.s3:
; 304, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
3bd0 : 85 0e __ STA P1 
3bd2 : a5 0f __ LDA P2 ; (map_x + 0)
3bd4 : 85 0d __ STA P0 
3bd6 : 20 ca 24 JSR $24ca ; (get_tile_core.s0 + 0)
3bd9 : 8d e9 9f STA $9fe9 ; (connected + 1)
; 307, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
3bdc : c9 03 __ CMP #$03
3bde : d0 05 __ BNE $3be5 ; (get_map_tile_fast.s16 + 0)
.s10:
; 311, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
3be0 : a9 db __ LDA #$db
.s1001:
; 300, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
3be2 : 85 1b __ STA ACCU + 0 
3be4 : 60 __ __ RTS
.s16:
; 307, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
3be5 : 90 14 __ BCC $3bfb ; (get_map_tile_fast.s18 + 0)
.s17:
3be7 : c9 04 __ CMP #$04
3be9 : d0 04 __ BNE $3bef ; (get_map_tile_fast.s22 + 0)
.s11:
; 312, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
3beb : a9 3c __ LDA #$3c
3bed : d0 f3 __ BNE $3be2 ; (get_map_tile_fast.s1001 + 0)
.s22:
; 307, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
3bef : c9 05 __ CMP #$05
3bf1 : d0 04 __ BNE $3bf7 ; (get_map_tile_fast.s1 + 0)
.s12:
; 313, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
3bf3 : a9 3e __ LDA #$3e
3bf5 : d0 eb __ BNE $3be2 ; (get_map_tile_fast.s1001 + 0)
.s1:
; 300, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
3bf7 : a9 20 __ LDA #$20
3bf9 : d0 e7 __ BNE $3be2 ; (get_map_tile_fast.s1001 + 0)
.s18:
; 307, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
3bfb : c9 01 __ CMP #$01
3bfd : d0 04 __ BNE $3c03 ; (get_map_tile_fast.s19 + 0)
.s8:
; 309, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
3bff : a9 a0 __ LDA #$a0
3c01 : d0 df __ BNE $3be2 ; (get_map_tile_fast.s1001 + 0)
.s19:
; 307, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
3c03 : a9 00 __ LDA #$00
3c05 : 69 ff __ ADC #$ff
3c07 : 29 0e __ AND #$0e
3c09 : 49 2e __ EOR #$2e
3c0b : 4c e2 3b JMP $3be2 ; (get_map_tile_fast.s1001 + 0)
--------------------------------------------------------------------
get_viewport_max_x: ; get_viewport_max_x()->u8
.s1001:
3c0e : a9 27 __ LDA #$27
; 815, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_utils.c"
3c10 : 60 __ __ RTS
--------------------------------------------------------------------
memmove: ; memmove(void*,const void*,i16)->void*
.s0:
; 237, "E:/Apps/oscar64/include/string.c"
3c11 : a5 11 __ LDA P4 ; (size + 0)
3c13 : 8d f0 9f STA $9ff0 ; (r1 + 0)
3c16 : a6 0e __ LDX P1 ; (dst + 1)
3c18 : a5 12 __ LDA P5 ; (size + 1)
3c1a : 8d f1 9f STA $9ff1 ; (r1 + 1)
; 238, "E:/Apps/oscar64/include/string.c"
3c1d : 10 03 __ BPL $3c22 ; (memmove.s1006 + 0)
3c1f : 4c bd 3c JMP $3cbd ; (memmove.s3 + 0)
.s1006:
3c22 : 05 11 __ ORA P4 ; (size + 0)
3c24 : f0 f9 __ BEQ $3c1f ; (memmove.s0 + 14)
.s1:
; 240, "E:/Apps/oscar64/include/string.c"
3c26 : 8e ef 9f STX $9fef ; (byte_ptr + 1)
3c29 : a5 0d __ LDA P0 ; (dst + 0)
3c2b : 8d ee 9f STA $9fee ; (result + 0)
; 241, "E:/Apps/oscar64/include/string.c"
3c2e : a5 0f __ LDA P2 ; (src + 0)
3c30 : 8d ec 9f STA $9fec ; (entropy1 + 1)
3c33 : a5 10 __ LDA P3 ; (src + 1)
3c35 : 8d ed 9f STA $9fed ; (s + 1)
; 242, "E:/Apps/oscar64/include/string.c"
3c38 : e4 10 __ CPX P3 ; (src + 1)
3c3a : d0 05 __ BNE $3c41 ; (memmove.s1005 + 0)
.s1004:
3c3c : a5 0d __ LDA P0 ; (dst + 0)
3c3e : cd ec 9f CMP $9fec ; (entropy1 + 1)
.s1005:
3c41 : b0 04 __ BCS $3c47 ; (memmove.s5 + 0)
.s7:
; 246, "E:/Apps/oscar64/include/string.c"
3c43 : a0 00 __ LDY #$00
3c45 : 90 7d __ BCC $3cc4 ; (memmove.l1007 + 0)
.s5:
; 248, "E:/Apps/oscar64/include/string.c"
3c47 : ad ed 9f LDA $9fed ; (s + 1)
3c4a : cd ef 9f CMP $9fef ; (byte_ptr + 1)
3c4d : d0 06 __ BNE $3c55 ; (memmove.s1003 + 0)
.s1002:
3c4f : ad ec 9f LDA $9fec ; (entropy1 + 1)
3c52 : cd ee 9f CMP $9fee ; (result + 0)
.s1003:
3c55 : b0 66 __ BCS $3cbd ; (memmove.s3 + 0)
.s9:
; 251, "E:/Apps/oscar64/include/string.c"
3c57 : ad ec 9f LDA $9fec ; (entropy1 + 1)
3c5a : 18 __ __ CLC
3c5b : 65 11 __ ADC P4 ; (size + 0)
3c5d : 8d ec 9f STA $9fec ; (entropy1 + 1)
3c60 : ad ed 9f LDA $9fed ; (s + 1)
3c63 : 6d f1 9f ADC $9ff1 ; (r1 + 1)
3c66 : 8d ed 9f STA $9fed ; (s + 1)
; 250, "E:/Apps/oscar64/include/string.c"
3c69 : ad ee 9f LDA $9fee ; (result + 0)
3c6c : 18 __ __ CLC
3c6d : 65 11 __ ADC P4 ; (size + 0)
3c6f : 8d ee 9f STA $9fee ; (result + 0)
3c72 : ad ef 9f LDA $9fef ; (byte_ptr + 1)
3c75 : 6d f1 9f ADC $9ff1 ; (r1 + 1)
3c78 : 8d ef 9f STA $9fef ; (byte_ptr + 1)
; 253, "E:/Apps/oscar64/include/string.c"
3c7b : a0 00 __ LDY #$00
.l1009:
3c7d : ad ec 9f LDA $9fec ; (entropy1 + 1)
3c80 : 18 __ __ CLC
3c81 : 69 ff __ ADC #$ff
3c83 : 85 1b __ STA ACCU + 0 
3c85 : 8d ec 9f STA $9fec ; (entropy1 + 1)
3c88 : ad ed 9f LDA $9fed ; (s + 1)
3c8b : 69 ff __ ADC #$ff
3c8d : 85 1c __ STA ACCU + 1 
3c8f : 8d ed 9f STA $9fed ; (s + 1)
3c92 : ad ee 9f LDA $9fee ; (result + 0)
3c95 : 18 __ __ CLC
3c96 : 69 ff __ ADC #$ff
3c98 : 85 43 __ STA T1 + 0 
3c9a : 8d ee 9f STA $9fee ; (result + 0)
3c9d : ad ef 9f LDA $9fef ; (byte_ptr + 1)
3ca0 : 69 ff __ ADC #$ff
3ca2 : 85 44 __ STA T1 + 1 
3ca4 : 8d ef 9f STA $9fef ; (byte_ptr + 1)
3ca7 : b1 1b __ LDA (ACCU + 0),y 
3ca9 : 91 43 __ STA (T1 + 0),y 
; 254, "E:/Apps/oscar64/include/string.c"
3cab : ad f0 9f LDA $9ff0 ; (r1 + 0)
3cae : d0 03 __ BNE $3cb3 ; (memmove.s1017 + 0)
.s1016:
; 254, "E:/Apps/oscar64/include/string.c"
3cb0 : ce f1 9f DEC $9ff1 ; (r1 + 1)
.s1017:
3cb3 : ce f0 9f DEC $9ff0 ; (r1 + 0)
3cb6 : d0 c5 __ BNE $3c7d ; (memmove.l1009 + 0)
.s1018:
; 254, "E:/Apps/oscar64/include/string.c"
3cb8 : ad f1 9f LDA $9ff1 ; (r1 + 1)
3cbb : d0 c0 __ BNE $3c7d ; (memmove.l1009 + 0)
.s3:
; 257, "E:/Apps/oscar64/include/string.c"
3cbd : 86 1c __ STX ACCU + 1 
3cbf : a5 0d __ LDA P0 ; (dst + 0)
3cc1 : 85 1b __ STA ACCU + 0 
.s1001:
3cc3 : 60 __ __ RTS
.l1007:
; 245, "E:/Apps/oscar64/include/string.c"
3cc4 : ad ec 9f LDA $9fec ; (entropy1 + 1)
3cc7 : 85 1b __ STA ACCU + 0 
3cc9 : 18 __ __ CLC
3cca : 69 01 __ ADC #$01
3ccc : 8d ec 9f STA $9fec ; (entropy1 + 1)
3ccf : ad ed 9f LDA $9fed ; (s + 1)
3cd2 : 85 1c __ STA ACCU + 1 
3cd4 : 69 00 __ ADC #$00
3cd6 : 8d ed 9f STA $9fed ; (s + 1)
3cd9 : ad ee 9f LDA $9fee ; (result + 0)
3cdc : 85 43 __ STA T1 + 0 
3cde : ad ef 9f LDA $9fef ; (byte_ptr + 1)
3ce1 : 85 44 __ STA T1 + 1 
3ce3 : b1 1b __ LDA (ACCU + 0),y 
3ce5 : 91 43 __ STA (T1 + 0),y 
3ce7 : 18 __ __ CLC
3ce8 : a5 43 __ LDA T1 + 0 
3cea : 69 01 __ ADC #$01
3cec : 8d ee 9f STA $9fee ; (result + 0)
3cef : a5 44 __ LDA T1 + 1 
3cf1 : 69 00 __ ADC #$00
3cf3 : 8d ef 9f STA $9fef ; (byte_ptr + 1)
; 246, "E:/Apps/oscar64/include/string.c"
3cf6 : ad f0 9f LDA $9ff0 ; (r1 + 0)
3cf9 : d0 03 __ BNE $3cfe ; (memmove.s1014 + 0)
.s1013:
; 246, "E:/Apps/oscar64/include/string.c"
3cfb : ce f1 9f DEC $9ff1 ; (r1 + 1)
.s1014:
3cfe : ce f0 9f DEC $9ff0 ; (r1 + 0)
3d01 : d0 c1 __ BNE $3cc4 ; (memmove.l1007 + 0)
.s1015:
; 246, "E:/Apps/oscar64/include/string.c"
3d03 : ad f1 9f LDA $9ff1 ; (r1 + 1)
3d06 : d0 bc __ BNE $3cc4 ; (memmove.l1007 + 0)
3d08 : f0 b3 __ BEQ $3cbd ; (memmove.s3 + 0)
--------------------------------------------------------------------
getch: ; getch()->u8
.l1:
; 320, "E:/Apps/oscar64/include/conio.c"
3d0a : 20 e4 ff JSR $ffe4 
3d0d : 85 1b __ STA ACCU + 0 
3d0f : a5 1b __ LDA ACCU + 0 
; 319, "E:/Apps/oscar64/include/conio.c"
3d11 : 8d f1 9f STA $9ff1 ; (r1 + 1)
; 323, "E:/Apps/oscar64/include/conio.c"
3d14 : f0 f4 __ BEQ $3d0a ; (getch.l1 + 0)
.s2:
; 325, "E:/Apps/oscar64/include/conio.c"
3d16 : 4c 19 3d JMP $3d19 ; (convch.s0 + 0)
--------------------------------------------------------------------
convch: ; convch(u8)->u8
.s0:
3d19 : a8 __ __ TAY
; 246, "E:/Apps/oscar64/include/conio.c"
3d1a : ad f4 40 LDA $40f4 ; (giocharmap + 0)
3d1d : f0 27 __ BEQ $3d46 ; (convch.s3 + 0)
.s1:
; 248, "E:/Apps/oscar64/include/conio.c"
3d1f : c0 0d __ CPY #$0d
3d21 : d0 03 __ BNE $3d26 ; (convch.s5 + 0)
.s4:
; 263, "E:/Apps/oscar64/include/conio.c"
3d23 : a9 0a __ LDA #$0a
.s1001:
3d25 : 60 __ __ RTS
.s5:
; 250, "E:/Apps/oscar64/include/conio.c"
3d26 : c9 02 __ CMP #$02
3d28 : 90 1c __ BCC $3d46 ; (convch.s3 + 0)
.s7:
; 252, "E:/Apps/oscar64/include/conio.c"
3d2a : 98 __ __ TYA
3d2b : c0 41 __ CPY #$41
3d2d : 90 17 __ BCC $3d46 ; (convch.s3 + 0)
.s13:
3d2f : c9 db __ CMP #$db
3d31 : b0 13 __ BCS $3d46 ; (convch.s3 + 0)
.s10:
; 254, "E:/Apps/oscar64/include/conio.c"
3d33 : c9 c1 __ CMP #$c1
3d35 : 90 03 __ BCC $3d3a ; (convch.s16 + 0)
.s14:
; 255, "E:/Apps/oscar64/include/conio.c"
3d37 : 49 a0 __ EOR #$a0
3d39 : a8 __ __ TAY
.s16:
; 256, "E:/Apps/oscar64/include/conio.c"
3d3a : c9 7b __ CMP #$7b
3d3c : b0 08 __ BCS $3d46 ; (convch.s3 + 0)
.s20:
3d3e : c9 61 __ CMP #$61
3d40 : b0 06 __ BCS $3d48 ; (convch.s17 + 0)
.s21:
3d42 : c9 5b __ CMP #$5b
3d44 : 90 02 __ BCC $3d48 ; (convch.s17 + 0)
.s3:
; 263, "E:/Apps/oscar64/include/conio.c"
3d46 : 98 __ __ TYA
3d47 : 60 __ __ RTS
.s17:
; 257, "E:/Apps/oscar64/include/conio.c"
3d48 : 49 20 __ EOR #$20
3d4a : 60 __ __ RTS
--------------------------------------------------------------------
save_compact_map: ; save_compact_map(const u8*)->void
.s0:
;  18, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_export.c"
3d4b : a9 00 __ LDA #$00
3d4d : 8d f0 9f STA $9ff0 ; (r1 + 0)
3d50 : a9 06 __ LDA #$06
3d52 : 8d f1 9f STA $9ff1 ; (r1 + 1)
;  21, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_export.c"
3d55 : a5 12 __ LDA P5 ; (filename + 0)
3d57 : 85 0d __ STA P0 
3d59 : a5 13 __ LDA P6 ; (filename + 1)
3d5b : 85 0e __ STA P1 
3d5d : 20 77 3d JSR $3d77 ; (krnio_setnam.s0 + 0)
;  25, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/map_export.c"
3d60 : a9 08 __ LDA #$08
3d62 : 85 0d __ STA P0 
3d64 : a9 47 __ LDA #$47
3d66 : 85 11 __ STA P4 
3d68 : a9 38 __ LDA #$38
3d6a : 85 0e __ STA P1 
3d6c : a9 41 __ LDA #$41
3d6e : 85 0f __ STA P2 
3d70 : a9 38 __ LDA #$38
3d72 : 85 10 __ STA P3 
3d74 : 4c 8d 3d JMP $3d8d ; (krnio_save.s0 + 0)
--------------------------------------------------------------------
krnio_setnam: ; krnio_setnam(const u8*)->void
.s0:
;  34, "E:/Apps/oscar64/include/c64/kernalio.c"
3d77 : a5 0d __ LDA P0 
3d79 : 05 0e __ ORA P1 
3d7b : f0 08 __ BEQ $3d85 ; (krnio_setnam.s0 + 14)
3d7d : a0 ff __ LDY #$ff
3d7f : c8 __ __ INY
3d80 : b1 0d __ LDA (P0),y 
3d82 : d0 fb __ BNE $3d7f ; (krnio_setnam.s0 + 8)
3d84 : 98 __ __ TYA
3d85 : a6 0d __ LDX P0 
3d87 : a4 0e __ LDY P1 
3d89 : 20 bd ff JSR $ffbd 
.s1001:
;  49, "E:/Apps/oscar64/include/c64/kernalio.c"
3d8c : 60 __ __ RTS
--------------------------------------------------------------------
krnio_save: ; krnio_save(u8,const u8*,const u8*)->bool
.s0:
; 161, "E:/Apps/oscar64/include/c64/kernalio.c"
3d8d : a9 00 __ LDA #$00
3d8f : a6 0d __ LDX P0 
3d91 : a0 00 __ LDY #$00
3d93 : 20 ba ff JSR $ffba 
3d96 : a9 0e __ LDA #$0e
3d98 : a6 10 __ LDX P3 
3d9a : a4 11 __ LDY P4 
3d9c : 20 d8 ff JSR $ffd8 
3d9f : a9 00 __ LDA #$00
3da1 : 2a __ __ ROL
3da2 : 49 01 __ EOR #$01
3da4 : 85 1b __ STA ACCU + 0 
3da6 : a5 1b __ LDA ACCU + 0 
3da8 : f0 02 __ BEQ $3dac ; (krnio_save.s1001 + 0)
.s1006:
3daa : a9 01 __ LDA #$01
.s1001:
; 158, "E:/Apps/oscar64/include/c64/kernalio.c"
3dac : 60 __ __ RTS
--------------------------------------------------------------------
3dad : __ __ __ BYT 4d 41 50 44 41 54 41 2e 42 49 4e 00             : MAPDATA.BIN.
--------------------------------------------------------------------
process_navigation_input: ; process_navigation_input(u8)->void
.s0:
; 145, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3db9 : ad f0 40 LDA $40f0 ; (view + 0)
3dbc : 85 49 __ STA T3 + 0 
3dbe : 8d eb 9f STA $9feb ; (i + 0)
; 149, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3dc1 : a9 00 __ LDA #$00
3dc3 : 8d e7 9f STA $9fe7 ; (idx + 0)
; 146, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3dc6 : ad f1 40 LDA $40f1 ; (view + 1)
3dc9 : 85 4a __ STA T4 + 0 
3dcb : 8d ea 9f STA $9fea ; (entropy2 + 1)
; 147, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3dce : ad ee 40 LDA $40ee ; (camera_center_x + 0)
3dd1 : 85 48 __ STA T2 + 0 
3dd3 : 8d e9 9f STA $9fe9 ; (connected + 1)
; 148, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3dd6 : ad ef 40 LDA $40ef ; (camera_center_y + 0)
3dd9 : 85 4b __ STA T5 + 0 
3ddb : 8d e8 9f STA $9fe8 ; (entropy3 + 1)
; 152, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3dde : a5 0d __ LDA P0 ; (key + 0)
3de0 : c9 61 __ CMP #$61
3de2 : d0 03 __ BNE $3de7 ; (process_navigation_input.s19 + 0)
3de4 : 4c b0 3e JMP $3eb0 ; (process_navigation_input.s10 + 0)
.s19:
3de7 : b0 03 __ BCS $3dec ; (process_navigation_input.s20 + 0)
3de9 : 4c 9e 3e JMP $3e9e ; (process_navigation_input.s21 + 0)
.s20:
3dec : c9 73 __ CMP #$73
3dee : d0 03 __ BNE $3df3 ; (process_navigation_input.s28 + 0)
3df0 : 4c 93 3e JMP $3e93 ; (process_navigation_input.s6 + 0)
.s28:
3df3 : b0 03 __ BCS $3df8 ; (process_navigation_input.s29 + 0)
3df5 : 4c 81 3e JMP $3e81 ; (process_navigation_input.s30 + 0)
.s29:
3df8 : c9 77 __ CMP #$77
3dfa : d0 41 __ BNE $3e3d ; (process_navigation_input.s1001 + 0)
.s2:
; 155, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3dfc : a5 4b __ LDA T5 + 0 
3dfe : f0 3d __ BEQ $3e3d ; (process_navigation_input.s1001 + 0)
.s3:
; 156, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e00 : 69 fe __ ADC #$fe
.s70:
; 164, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e02 : 8d e8 9f STA $9fe8 ; (entropy3 + 1)
.s33:
; 173, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e05 : a9 01 __ LDA #$01
3e07 : 8d e7 9f STA $9fe7 ; (idx + 0)
; 189, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e0a : a5 48 __ LDA T2 + 0 
3e0c : 8d e6 9f STA $9fe6 ; (screen_pos + 1)
; 190, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e0f : a5 4b __ LDA T5 + 0 
3e11 : 8d e5 9f STA $9fe5 ; (leg1_end_x + 0)
; 192, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e14 : ad e9 9f LDA $9fe9 ; (connected + 1)
3e17 : 8d ee 40 STA $40ee ; (camera_center_x + 0)
; 193, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e1a : ad e8 9f LDA $9fe8 ; (entropy3 + 1)
3e1d : 8d ef 40 STA $40ef ; (camera_center_y + 0)
; 194, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e20 : 20 63 16 JSR $1663 ; (update_camera.s0 + 0)
; 198, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e23 : a5 49 __ LDA T3 + 0 
3e25 : cd f0 40 CMP $40f0 ; (view + 0)
3e28 : d0 07 __ BNE $3e31 ; (process_navigation_input.s36 + 0)
.s39:
3e2a : a5 4a __ LDA T4 + 0 
3e2c : cd f1 40 CMP $40f1 ; (view + 1)
3e2f : f0 32 __ BEQ $3e63 ; (process_navigation_input.s37 + 0)
.s36:
; 200, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e31 : ad f1 40 LDA $40f1 ; (view + 1)
3e34 : c5 4a __ CMP T4 + 0 
3e36 : b0 06 __ BCS $3e3e ; (process_navigation_input.s41 + 0)
.s40:
; 201, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e38 : a9 01 __ LDA #$01
.s1002:
3e3a : 8d f3 40 STA $40f3 ; (last_scroll_direction + 0)
.s1001:
; 227, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e3d : 60 __ __ RTS
.s41:
; 202, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e3e : a5 4a __ LDA T4 + 0 
3e40 : cd f1 40 CMP $40f1 ; (view + 1)
3e43 : b0 04 __ BCS $3e49 ; (process_navigation_input.s44 + 0)
.s43:
; 203, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e45 : a9 02 __ LDA #$02
3e47 : 90 f1 __ BCC $3e3a ; (process_navigation_input.s1002 + 0)
.s44:
; 204, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e49 : ad f0 40 LDA $40f0 ; (view + 0)
3e4c : c5 49 __ CMP T3 + 0 
3e4e : b0 04 __ BCS $3e54 ; (process_navigation_input.s47 + 0)
.s46:
; 205, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e50 : a9 03 __ LDA #$03
3e52 : 90 e6 __ BCC $3e3a ; (process_navigation_input.s1002 + 0)
.s47:
; 206, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e54 : a5 49 __ LDA T3 + 0 
3e56 : cd f0 40 CMP $40f0 ; (view + 0)
3e59 : b0 04 __ BCS $3e5f ; (process_navigation_input.s50 + 0)
.s49:
; 207, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e5b : a9 04 __ LDA #$04
3e5d : 90 db __ BCC $3e3a ; (process_navigation_input.s1002 + 0)
.s50:
; 209, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e5f : a9 00 __ LDA #$00
3e61 : b0 d7 __ BCS $3e3a ; (process_navigation_input.s1002 + 0)
.s37:
; 214, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e63 : ad ef 40 LDA $40ef ; (camera_center_y + 0)
3e66 : c5 4b __ CMP T5 + 0 
3e68 : 90 ce __ BCC $3e38 ; (process_navigation_input.s40 + 0)
.s53:
; 216, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e6a : a5 4b __ LDA T5 + 0 
3e6c : cd ef 40 CMP $40ef ; (camera_center_y + 0)
3e6f : 90 d4 __ BCC $3e45 ; (process_navigation_input.s43 + 0)
.s56:
; 218, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e71 : ad ee 40 LDA $40ee ; (camera_center_x + 0)
3e74 : c5 48 __ CMP T2 + 0 
3e76 : 90 d8 __ BCC $3e50 ; (process_navigation_input.s46 + 0)
.s59:
; 220, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e78 : a5 48 __ LDA T2 + 0 
3e7a : cd ee 40 CMP $40ee ; (camera_center_x + 0)
3e7d : b0 e0 __ BCS $3e5f ; (process_navigation_input.s50 + 0)
3e7f : 90 da __ BCC $3e5b ; (process_navigation_input.s49 + 0)
.s30:
; 152, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e81 : c9 64 __ CMP #$64
3e83 : d0 b8 __ BNE $3e3d ; (process_navigation_input.s1001 + 0)
.s14:
; 179, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e85 : a5 48 __ LDA T2 + 0 
3e87 : c9 3f __ CMP #$3f
3e89 : b0 b2 __ BCS $3e3d ; (process_navigation_input.s1001 + 0)
.s15:
; 180, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e8b : 69 01 __ ADC #$01
.s71:
3e8d : 8d e9 9f STA $9fe9 ; (connected + 1)
3e90 : 4c 05 3e JMP $3e05 ; (process_navigation_input.s33 + 0)
.s6:
; 163, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e93 : a5 4b __ LDA T5 + 0 
3e95 : c9 3f __ CMP #$3f
3e97 : b0 a4 __ BCS $3e3d ; (process_navigation_input.s1001 + 0)
.s7:
; 164, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e99 : 69 01 __ ADC #$01
3e9b : 4c 02 3e JMP $3e02 ; (process_navigation_input.s70 + 0)
.s21:
; 152, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3e9e : c9 53 __ CMP #$53
3ea0 : f0 f1 __ BEQ $3e93 ; (process_navigation_input.s6 + 0)
.s22:
3ea2 : 90 08 __ BCC $3eac ; (process_navigation_input.s24 + 0)
.s23:
3ea4 : c9 57 __ CMP #$57
3ea6 : d0 03 __ BNE $3eab ; (process_navigation_input.s23 + 7)
3ea8 : 4c fc 3d JMP $3dfc ; (process_navigation_input.s2 + 0)
3eab : 60 __ __ RTS
.s24:
3eac : c9 41 __ CMP #$41
3eae : d0 09 __ BNE $3eb9 ; (process_navigation_input.s25 + 0)
.s10:
; 171, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3eb0 : a5 48 __ LDA T2 + 0 
3eb2 : f0 89 __ BEQ $3e3d ; (process_navigation_input.s1001 + 0)
.s11:
; 172, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3eb4 : 69 fe __ ADC #$fe
3eb6 : 4c 8d 3e JMP $3e8d ; (process_navigation_input.s71 + 0)
.s25:
; 152, "C:/Users/guyle/OneDrive/Documents/programing/C64/OSCAR64/Hacked C64/main/src/mapgen/mapgen_display.c"
3eb9 : c9 44 __ CMP #$44
3ebb : f0 c8 __ BEQ $3e85 ; (process_navigation_input.s14 + 0)
3ebd : 60 __ __ RTS
--------------------------------------------------------------------
mul16by8: ; mul16by8
3ebe : 4a __ __ LSR
3ebf : f0 2e __ BEQ $3eef ; (mul16by8 + 49)
3ec1 : a2 00 __ LDX #$00
3ec3 : a0 00 __ LDY #$00
3ec5 : 90 13 __ BCC $3eda ; (mul16by8 + 28)
3ec7 : a4 1b __ LDY ACCU + 0 
3ec9 : a6 1c __ LDX ACCU + 1 
3ecb : b0 0d __ BCS $3eda ; (mul16by8 + 28)
3ecd : 85 02 __ STA $02 
3ecf : 18 __ __ CLC
3ed0 : 98 __ __ TYA
3ed1 : 65 1b __ ADC ACCU + 0 
3ed3 : a8 __ __ TAY
3ed4 : 8a __ __ TXA
3ed5 : 65 1c __ ADC ACCU + 1 
3ed7 : aa __ __ TAX
3ed8 : a5 02 __ LDA $02 
3eda : 06 1b __ ASL ACCU + 0 
3edc : 26 1c __ ROL ACCU + 1 
3ede : 4a __ __ LSR
3edf : 90 f9 __ BCC $3eda ; (mul16by8 + 28)
3ee1 : d0 ea __ BNE $3ecd ; (mul16by8 + 15)
3ee3 : 18 __ __ CLC
3ee4 : 98 __ __ TYA
3ee5 : 65 1b __ ADC ACCU + 0 
3ee7 : 85 1b __ STA ACCU + 0 
3ee9 : 8a __ __ TXA
3eea : 65 1c __ ADC ACCU + 1 
3eec : 85 1c __ STA ACCU + 1 
3eee : 60 __ __ RTS
3eef : b0 04 __ BCS $3ef5 ; (mul16by8 + 55)
3ef1 : 85 1b __ STA ACCU + 0 
3ef3 : 85 1c __ STA ACCU + 1 
3ef5 : 60 __ __ RTS
--------------------------------------------------------------------
mul16: ; mul16
3ef6 : a0 00 __ LDY #$00
3ef8 : 84 06 __ STY WORK + 3 
3efa : a5 03 __ LDA WORK + 0 
3efc : a6 04 __ LDX WORK + 1 
3efe : f0 1c __ BEQ $3f1c ; (mul16 + 38)
3f00 : 38 __ __ SEC
3f01 : 6a __ __ ROR
3f02 : 90 0d __ BCC $3f11 ; (mul16 + 27)
3f04 : aa __ __ TAX
3f05 : 18 __ __ CLC
3f06 : 98 __ __ TYA
3f07 : 65 1b __ ADC ACCU + 0 
3f09 : a8 __ __ TAY
3f0a : a5 06 __ LDA WORK + 3 
3f0c : 65 1c __ ADC ACCU + 1 
3f0e : 85 06 __ STA WORK + 3 
3f10 : 8a __ __ TXA
3f11 : 06 1b __ ASL ACCU + 0 
3f13 : 26 1c __ ROL ACCU + 1 
3f15 : 4a __ __ LSR
3f16 : 90 f9 __ BCC $3f11 ; (mul16 + 27)
3f18 : d0 ea __ BNE $3f04 ; (mul16 + 14)
3f1a : a5 04 __ LDA WORK + 1 
3f1c : 4a __ __ LSR
3f1d : 90 0d __ BCC $3f2c ; (mul16 + 54)
3f1f : aa __ __ TAX
3f20 : 18 __ __ CLC
3f21 : 98 __ __ TYA
3f22 : 65 1b __ ADC ACCU + 0 
3f24 : a8 __ __ TAY
3f25 : a5 06 __ LDA WORK + 3 
3f27 : 65 1c __ ADC ACCU + 1 
3f29 : 85 06 __ STA WORK + 3 
3f2b : 8a __ __ TXA
3f2c : 06 1b __ ASL ACCU + 0 
3f2e : 26 1c __ ROL ACCU + 1 
3f30 : 4a __ __ LSR
3f31 : b0 ec __ BCS $3f1f ; (mul16 + 41)
3f33 : d0 f7 __ BNE $3f2c ; (mul16 + 54)
3f35 : 84 05 __ STY WORK + 2 
3f37 : 60 __ __ RTS
--------------------------------------------------------------------
divmod: ; divmod
3f38 : a5 1c __ LDA ACCU + 1 
3f3a : d0 31 __ BNE $3f6d ; (divmod + 53)
3f3c : a5 04 __ LDA WORK + 1 
3f3e : d0 1e __ BNE $3f5e ; (divmod + 38)
3f40 : 85 06 __ STA WORK + 3 
3f42 : a2 04 __ LDX #$04
3f44 : 06 1b __ ASL ACCU + 0 
3f46 : 2a __ __ ROL
3f47 : c5 03 __ CMP WORK + 0 
3f49 : 90 02 __ BCC $3f4d ; (divmod + 21)
3f4b : e5 03 __ SBC WORK + 0 
3f4d : 26 1b __ ROL ACCU + 0 
3f4f : 2a __ __ ROL
3f50 : c5 03 __ CMP WORK + 0 
3f52 : 90 02 __ BCC $3f56 ; (divmod + 30)
3f54 : e5 03 __ SBC WORK + 0 
3f56 : 26 1b __ ROL ACCU + 0 
3f58 : ca __ __ DEX
3f59 : d0 eb __ BNE $3f46 ; (divmod + 14)
3f5b : 85 05 __ STA WORK + 2 
3f5d : 60 __ __ RTS
3f5e : a5 1b __ LDA ACCU + 0 
3f60 : 85 05 __ STA WORK + 2 
3f62 : a5 1c __ LDA ACCU + 1 
3f64 : 85 06 __ STA WORK + 3 
3f66 : a9 00 __ LDA #$00
3f68 : 85 1b __ STA ACCU + 0 
3f6a : 85 1c __ STA ACCU + 1 
3f6c : 60 __ __ RTS
3f6d : a5 04 __ LDA WORK + 1 
3f6f : d0 1f __ BNE $3f90 ; (divmod + 88)
3f71 : a5 03 __ LDA WORK + 0 
3f73 : 30 1b __ BMI $3f90 ; (divmod + 88)
3f75 : a9 00 __ LDA #$00
3f77 : 85 06 __ STA WORK + 3 
3f79 : a2 10 __ LDX #$10
3f7b : 06 1b __ ASL ACCU + 0 
3f7d : 26 1c __ ROL ACCU + 1 
3f7f : 2a __ __ ROL
3f80 : c5 03 __ CMP WORK + 0 
3f82 : 90 02 __ BCC $3f86 ; (divmod + 78)
3f84 : e5 03 __ SBC WORK + 0 
3f86 : 26 1b __ ROL ACCU + 0 
3f88 : 26 1c __ ROL ACCU + 1 
3f8a : ca __ __ DEX
3f8b : d0 f2 __ BNE $3f7f ; (divmod + 71)
3f8d : 85 05 __ STA WORK + 2 
3f8f : 60 __ __ RTS
3f90 : a9 00 __ LDA #$00
3f92 : 85 05 __ STA WORK + 2 
3f94 : 85 06 __ STA WORK + 3 
3f96 : 84 02 __ STY $02 
3f98 : a0 10 __ LDY #$10
3f9a : 18 __ __ CLC
3f9b : 26 1b __ ROL ACCU + 0 
3f9d : 26 1c __ ROL ACCU + 1 
3f9f : 26 05 __ ROL WORK + 2 
3fa1 : 26 06 __ ROL WORK + 3 
3fa3 : 38 __ __ SEC
3fa4 : a5 05 __ LDA WORK + 2 
3fa6 : e5 03 __ SBC WORK + 0 
3fa8 : aa __ __ TAX
3fa9 : a5 06 __ LDA WORK + 3 
3fab : e5 04 __ SBC WORK + 1 
3fad : 90 04 __ BCC $3fb3 ; (divmod + 123)
3faf : 86 05 __ STX WORK + 2 
3fb1 : 85 06 __ STA WORK + 3 
3fb3 : 88 __ __ DEY
3fb4 : d0 e5 __ BNE $3f9b ; (divmod + 99)
3fb6 : 26 1b __ ROL ACCU + 0 
3fb8 : 26 1c __ ROL ACCU + 1 
3fba : a4 02 __ LDY $02 
3fbc : 60 __ __ RTS
--------------------------------------------------------------------
__multab7982L:
3fbd : __ __ __ BYT 00 2e 5c 8a b8 e6 14 42 70                      : ..\....Bp
--------------------------------------------------------------------
__multab7982H:
3fc6 : __ __ __ BYT 00 1f 3e 5d 7c 9b bb da f9                      : ..>]|....
--------------------------------------------------------------------
__multab14L:
3fcf : __ __ __ BYT 00 0e 1c 2a                                     : ...*
--------------------------------------------------------------------
__shltab7L:
3fd3 : __ __ __ BYT 07 0e 1c 38 70 e0                               : ...8p.
--------------------------------------------------------------------
spentry:
3fd9 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
generation_counter:
3fda : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
rng_seed:
3fdc : __ __ __ BYT 01 00                                           : ..
--------------------------------------------------------------------
room_count:
3fde : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
room_center_cache_valid:
3fdf : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
corridor_pool:
3fe0 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3ff0 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
4000 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
4010 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
4020 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
4030 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
4040 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
4050 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
4060 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
4070 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
4080 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
4090 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
40a0 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
connection_cache:
40a2 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
40b2 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
40c2 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
40d2 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
40e2 : __ __ __ BYT 00 00 00 00 00 00 00 00 00                      : .........
--------------------------------------------------------------------
distance_cache_valid:
40eb : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
striped_cache_size:
40ec : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
edge_candidate_count:
40ed : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
camera_center_x:
40ee : __ __ __ BYT 20                                              :  
--------------------------------------------------------------------
camera_center_y:
40ef : __ __ __ BYT 20                                              :  
--------------------------------------------------------------------
view:
40f0 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
screen_dirty:
40f2 : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
last_scroll_direction:
40f3 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
giocharmap:
40f4 : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
bitshift:
4100 : __ __ __ BYT 00 00 00 00 00 00 00 00 01 02 04 08 10 20 40 80 : ............. @.
4110 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
4120 : __ __ __ BYT 80 40 20 10 08 04 02 01 00 00 00 00 00 00 00 00 : .@ .............
4130 : __ __ __ BYT 00 00 00 00 00 00 00 00                         : ........
--------------------------------------------------------------------
compact_map:
4138 : __ __ __ BSS	1536
--------------------------------------------------------------------
connection_matrix:
4738 : __ __ __ BSS	400
--------------------------------------------------------------------
attempted_connections:
48c8 : __ __ __ BSS	400
--------------------------------------------------------------------
room_distance_cache:
4a58 : __ __ __ BSS	400
--------------------------------------------------------------------
visited_global:
4be8 : __ __ __ BSS	20
--------------------------------------------------------------------
rooms:
4c00 : __ __ __ BSS	160
--------------------------------------------------------------------
room_center_cache:
4ca0 : __ __ __ BSS	40
--------------------------------------------------------------------
stack_global:
4cc8 : __ __ __ BSS	20
--------------------------------------------------------------------
connection_distance_cache_striped:
4d00 : __ __ __ BSS	256
--------------------------------------------------------------------
screen_buffer:
4e00 : __ __ __ BSS	1000
--------------------------------------------------------------------
mst_edge_candidates_striped:
5200 : __ __ __ BSS	128
--------------------------------------------------------------------
corridor_path_static:
5280 : __ __ __ BSS	41
