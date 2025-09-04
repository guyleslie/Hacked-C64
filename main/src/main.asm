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
080e : 8e e0 35 STX $35e0 ; (spentry + 0)
0811 : a2 36 __ LDX #$36
0813 : a0 38 __ LDY #$38
0815 : a9 00 __ LDA #$00
0817 : 85 19 __ STA IP + 0 
0819 : 86 1a __ STX IP + 1 
081b : e0 44 __ CPX #$44
081d : f0 0b __ BEQ $082a ; (startup + 41)
081f : 91 19 __ STA (IP + 0),y 
0821 : c8 __ __ INY
0822 : d0 fb __ BNE $081f ; (startup + 30)
0824 : e8 __ __ INX
0825 : d0 f2 __ BNE $0819 ; (startup + 24)
0827 : 91 19 __ STA (IP + 0),y 
0829 : c8 __ __ INY
082a : c0 1c __ CPY #$1c
082c : d0 f9 __ BNE $0827 ; (startup + 38)
082e : a9 00 __ LDA #$00
0830 : a2 f7 __ LDX #$f7
0832 : d0 03 __ BNE $0837 ; (startup + 54)
0834 : 95 00 __ STA $00,x 
0836 : e8 __ __ INX
0837 : e0 f7 __ CPX #$f7
0839 : d0 f9 __ BNE $0834 ; (startup + 51)
083b : a9 d6 __ LDA #$d6
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
0880 : 20 f4 08 JSR $08f4 ; (clrscr.s0 + 0)
0883 : 20 fe 08 JSR $08fe ; (set_mixed_charset.s0 + 0)
.l54:
0886 : 20 07 09 JSR $0907 ; (mapgen_generate_dungeon.s0 + 0)
.l3:
0889 : 20 f4 22 JSR $22f4 ; (getch.l1 + 0)
088c : c9 51 __ CMP #$51
088e : f0 5a __ BEQ $08ea ; (main.s5 + 0)
.s8:
0890 : c9 71 __ CMP #$71
0892 : f0 56 __ BEQ $08ea ; (main.s5 + 0)
.s6:
0894 : c9 20 __ CMP #$20
0896 : d0 06 __ BNE $089e ; (main.s11 + 0)
.s10:
0898 : 20 f4 08 JSR $08f4 ; (clrscr.s0 + 0)
089b : 4c 86 08 JMP $0886 ; (main.l54 + 0)
.s11:
089e : c9 4d __ CMP #$4d
08a0 : f0 04 __ BEQ $08a6 ; (main.s13 + 0)
.s16:
08a2 : c9 6d __ CMP #$6d
08a4 : d0 0e __ BNE $08b4 ; (main.s14 + 0)
.s13:
08a6 : a9 2a __ LDA #$2a
08a8 : 85 12 __ STA P5 
08aa : a9 34 __ LDA #$34
08ac : 85 13 __ STA P6 
08ae : 20 d2 33 JSR $33d2 ; (save_compact_map.s0 + 0)
08b1 : 4c 89 08 JMP $0889 ; (main.l3 + 0)
.s14:
08b4 : c9 77 __ CMP #$77
08b6 : f0 04 __ BEQ $08bc ; (main.s17 + 0)
.s20:
08b8 : c9 57 __ CMP #$57
08ba : d0 0a __ BNE $08c6 ; (main.s18 + 0)
.s17:
08bc : a9 01 __ LDA #$01
.s55:
08be : 85 15 __ STA P8 
08c0 : 20 36 34 JSR $3436 ; (move_camera_direction.s1000 + 0)
08c3 : 4c 89 08 JMP $0889 ; (main.l3 + 0)
.s18:
08c6 : c9 73 __ CMP #$73
08c8 : f0 04 __ BEQ $08ce ; (main.s21 + 0)
.s24:
08ca : c9 53 __ CMP #$53
08cc : d0 04 __ BNE $08d2 ; (main.s22 + 0)
.s21:
08ce : a9 02 __ LDA #$02
08d0 : d0 ec __ BNE $08be ; (main.s55 + 0)
.s22:
08d2 : c9 61 __ CMP #$61
08d4 : f0 04 __ BEQ $08da ; (main.s25 + 0)
.s28:
08d6 : c9 41 __ CMP #$41
08d8 : d0 04 __ BNE $08de ; (main.s26 + 0)
.s25:
08da : a9 03 __ LDA #$03
08dc : d0 e0 __ BNE $08be ; (main.s55 + 0)
.s26:
08de : c9 64 __ CMP #$64
08e0 : f0 04 __ BEQ $08e6 ; (main.s29 + 0)
.s32:
08e2 : c9 44 __ CMP #$44
08e4 : d0 a3 __ BNE $0889 ; (main.l3 + 0)
.s29:
08e6 : a9 04 __ LDA #$04
08e8 : d0 d4 __ BNE $08be ; (main.s55 + 0)
.s5:
08ea : 20 f4 08 JSR $08f4 ; (clrscr.s0 + 0)
08ed : a9 00 __ LDA #$00
08ef : 85 1b __ STA ACCU + 0 
08f1 : 85 1c __ STA ACCU + 1 
.s1001:
08f3 : 60 __ __ RTS
--------------------------------------------------------------------
clrscr: ; clrscr()->void
.s0:
08f4 : a9 93 __ LDA #$93
08f6 : 85 43 __ STA T0 + 0 
08f8 : a5 43 __ LDA T0 + 0 
08fa : 20 d2 ff JSR $ffd2 
.s1001:
08fd : 60 __ __ RTS
--------------------------------------------------------------------
set_mixed_charset: ; set_mixed_charset()->void
.s0:
08fe : ad 18 d0 LDA $d018 
0901 : 09 02 __ ORA #$02
0903 : 8d 18 d0 STA $d018 
.s1001:
0906 : 60 __ __ RTS
--------------------------------------------------------------------
mapgen_generate_dungeon: ; mapgen_generate_dungeon()->u8
.s0:
0907 : 20 13 09 JSR $0913 ; (reset_viewport_state.s0 + 0)
090a : 20 24 09 JSR $0924 ; (reset_display_state.s0 + 0)
090d : 20 42 09 JSR $0942 ; (reset_all_generation_data.s0 + 0)
0910 : 4c f3 09 JMP $09f3 ; (generate_level.s0 + 0)
--------------------------------------------------------------------
reset_viewport_state: ; reset_viewport_state()->void
.s0:
0913 : a9 00 __ LDA #$00
0915 : 8d e3 35 STA $35e3 ; (view + 0)
0918 : 8d e4 35 STA $35e4 ; (view + 1)
091b : a9 20 __ LDA #$20
091d : 8d e2 35 STA $35e2 ; (camera_center_y + 0)
0920 : 8d e1 35 STA $35e1 ; (camera_center_x + 0)
.s1001:
0923 : 60 __ __ RTS
--------------------------------------------------------------------
reset_display_state: ; reset_display_state()->void
.s0:
0924 : a9 00 __ LDA #$00
0926 : 8d e6 35 STA $35e6 ; (last_scroll_direction + 0)
0929 : a9 01 __ LDA #$01
092b : 8d e5 35 STA $35e5 ; (screen_dirty + 0)
092e : a9 20 __ LDA #$20
0930 : a2 fa __ LDX #$fa
.l1003:
0932 : ca __ __ DEX
0933 : 9d 38 36 STA $3638,x ; (screen_buffer + 0)
0936 : 9d 32 37 STA $3732,x ; (screen_buffer + 250)
0939 : 9d 2c 38 STA $382c,x ; (screen_buffer + 500)
093c : 9d 26 39 STA $3926,x ; (screen_buffer + 750)
093f : d0 f1 __ BNE $0932 ; (reset_display_state.l1003 + 0)
.s1001:
0941 : 60 __ __ RTS
--------------------------------------------------------------------
reset_all_generation_data: ; reset_all_generation_data()->void
.s0:
0942 : 20 79 09 JSR $0979 ; (init_rnd.s0 + 0)
0945 : 20 90 09 JSR $0990 ; (clear_map.s0 + 0)
0948 : a9 20 __ LDA #$20
094a : 85 43 __ STA T0 + 0 
094c : a9 40 __ LDA #$40
094e : 85 44 __ STA T0 + 1 
.l2:
0950 : a9 00 __ LDA #$00
0952 : a0 04 __ LDY #$04
0954 : 91 43 __ STA (T0 + 0),y 
0956 : c8 __ __ INY
0957 : 91 43 __ STA (T0 + 0),y 
0959 : 18 __ __ CLC
095a : a5 43 __ LDA T0 + 0 
095c : 69 1d __ ADC #$1d
095e : 85 43 __ STA T0 + 0 
0960 : 90 02 __ BCC $0964 ; (reset_all_generation_data.s1005 + 0)
.s1004:
0962 : e6 44 __ INC T0 + 1 
.s1005:
0964 : c9 64 __ CMP #$64
0966 : d0 e8 __ BNE $0950 ; (reset_all_generation_data.l2 + 0)
.s1002:
0968 : a5 44 __ LDA T0 + 1 
096a : c9 42 __ CMP #$42
096c : d0 e2 __ BNE $0950 ; (reset_all_generation_data.l2 + 0)
.s4:
096e : a9 00 __ LDA #$00
0970 : 8d e9 35 STA $35e9 ; (room_center_cache_valid + 0)
0973 : 8d e8 35 STA $35e8 ; (room_count + 0)
0976 : 4c af 09 JMP $09af ; (init_connection_system.s0 + 0)
--------------------------------------------------------------------
init_rnd: ; init_rnd()->void
.s0:
0979 : ad 12 d0 LDA $d012 
097c : 4d 04 dc EOR $dc04 
097f : 8d e7 35 STA $35e7 ; (rnd_state + 0)
0982 : ad 05 dc LDA $dc05 
0985 : ad e7 35 LDA $35e7 ; (rnd_state + 0)
0988 : d0 05 __ BNE $098f ; (init_rnd.s1001 + 0)
.s1:
098a : a9 01 __ LDA #$01
098c : 8d e7 35 STA $35e7 ; (rnd_state + 0)
.s1001:
098f : 60 __ __ RTS
--------------------------------------------------------------------
clear_map: ; clear_map()->void
.s0:
0990 : a9 3a __ LDA #$3a
0992 : 85 1c __ STA ACCU + 1 
0994 : a9 00 __ LDA #$00
0996 : 85 1b __ STA ACCU + 0 
0998 : a0 20 __ LDY #$20
.l1004:
099a : a9 00 __ LDA #$00
099c : 91 1b __ STA (ACCU + 0),y 
099e : c8 __ __ INY
099f : d0 02 __ BNE $09a3 ; (clear_map.s1007 + 0)
.s1006:
09a1 : e6 1c __ INC ACCU + 1 
.s1007:
09a3 : 98 __ __ TYA
09a4 : c9 20 __ CMP #$20
09a6 : d0 f2 __ BNE $099a ; (clear_map.l1004 + 0)
.s1005:
09a8 : a5 1c __ LDA ACCU + 1 
09aa : c9 40 __ CMP #$40
09ac : d0 ec __ BNE $099a ; (clear_map.l1004 + 0)
.s1001:
09ae : 60 __ __ RTS
--------------------------------------------------------------------
init_connection_system: ; init_connection_system()->void
.s0:
09af : a9 20 __ LDA #$20
09b1 : 85 1b __ STA ACCU + 0 
09b3 : a9 40 __ LDA #$40
09b5 : 85 1c __ STA ACCU + 1 
09b7 : a9 28 __ LDA #$28
09b9 : 85 43 __ STA T1 + 0 
09bb : a9 40 __ LDA #$40
09bd : 85 44 __ STA T1 + 1 
.l2:
09bf : a9 00 __ LDA #$00
09c1 : a0 04 __ LDY #$04
09c3 : 91 1b __ STA (ACCU + 0),y 
09c5 : a0 1c __ LDY #$1c
09c7 : 91 1b __ STA (ACCU + 0),y 
09c9 : a9 ff __ LDA #$ff
09cb : a0 03 __ LDY #$03
.l1004:
09cd : 91 43 __ STA (T1 + 0),y 
09cf : 88 __ __ DEY
09d0 : 10 fb __ BPL $09cd ; (init_connection_system.l1004 + 0)
.s1005:
09d2 : 18 __ __ CLC
09d3 : a5 1b __ LDA ACCU + 0 
09d5 : 69 1d __ ADC #$1d
09d7 : 85 1b __ STA ACCU + 0 
09d9 : 90 02 __ BCC $09dd ; (init_connection_system.s1007 + 0)
.s1006:
09db : e6 1c __ INC ACCU + 1 
.s1007:
09dd : 18 __ __ CLC
09de : a5 43 __ LDA T1 + 0 
09e0 : 69 1d __ ADC #$1d
09e2 : 85 43 __ STA T1 + 0 
09e4 : 90 02 __ BCC $09e8 ; (init_connection_system.s1009 + 0)
.s1008:
09e6 : e6 44 __ INC T1 + 1 
.s1009:
09e8 : c9 6c __ CMP #$6c
09ea : d0 d3 __ BNE $09bf ; (init_connection_system.l2 + 0)
.s1002:
09ec : a5 44 __ LDA T1 + 1 
09ee : c9 42 __ CMP #$42
09f0 : d0 cd __ BNE $09bf ; (init_connection_system.l2 + 0)
.s1001:
09f2 : 60 __ __ RTS
--------------------------------------------------------------------
generate_level: ; generate_level()->u8
.s0:
09f3 : a9 59 __ LDA #$59
09f5 : 85 0e __ STA P1 
09f7 : a9 0a __ LDA #$0a
09f9 : 85 0f __ STA P2 
09fb : 20 1f 0a JSR $0a1f ; (print_text.s0 + 0)
09fe : 20 7d 0a JSR $0a7d ; (create_rooms.s1000 + 0)
0a01 : ad e8 35 LDA $35e8 ; (room_count + 0)
0a04 : f0 18 __ BEQ $0a1e ; (generate_level.s1001 + 0)
.s3:
0a06 : 20 af 09 JSR $09af ; (init_connection_system.s0 + 0)
0a09 : 20 34 10 JSR $1034 ; (connect_rooms.s1000 + 0)
0a0c : a9 0f __ LDA #$0f
0a0e : 85 14 __ STA P7 
0a10 : 20 4d 1e JSR $1e4d ; (mark_secret_rooms.s0 + 0)
0a13 : 20 de 20 JSR $20de ; (add_stairs.s0 + 0)
0a16 : 20 11 23 JSR $2311 ; (add_walls.s1000 + 0)
0a19 : 20 d4 2d JSR $2dd4 ; (initialize_camera.s0 + 0)
0a1c : a9 01 __ LDA #$01
.s1001:
0a1e : 60 __ __ RTS
--------------------------------------------------------------------
print_text: ; print_text(const u8*)->void
.s0:
0a1f : a9 00 __ LDA #$00
0a21 : 85 44 __ STA T3 + 0 
0a23 : f0 09 __ BEQ $0a2e ; (print_text.l1 + 0)
.s6:
0a25 : 85 43 __ STA T0 + 0 
0a27 : a5 43 __ LDA T0 + 0 
0a29 : 20 d2 ff JSR $ffd2 
0a2c : e6 44 __ INC T3 + 0 
.l1:
0a2e : a4 44 __ LDY T3 + 0 
0a30 : b1 0e __ LDA (P1),y ; (text + 0)
0a32 : d0 01 __ BNE $0a35 ; (print_text.s2 + 0)
.s1001:
0a34 : 60 __ __ RTS
.s2:
0a35 : c9 0a __ CMP #$0a
0a37 : d0 04 __ BNE $0a3d ; (print_text.s5 + 0)
.s4:
0a39 : a9 0d __ LDA #$0d
0a3b : d0 e8 __ BNE $0a25 ; (print_text.s6 + 0)
.s5:
0a3d : 20 43 0a JSR $0a43 ; (to_mixed_charset.s0 + 0)
0a40 : 4c 25 0a JMP $0a25 ; (print_text.s6 + 0)
--------------------------------------------------------------------
to_mixed_charset: ; to_mixed_charset(u8)->u8
.s0:
0a43 : c9 41 __ CMP #$41
0a45 : 90 06 __ BCC $0a4d ; (to_mixed_charset.s1001 + 0)
.s4:
0a47 : c9 5b __ CMP #$5b
0a49 : b0 03 __ BCS $0a4e ; (to_mixed_charset.s3 + 0)
.s1:
0a4b : 69 20 __ ADC #$20
.s1001:
0a4d : 60 __ __ RTS
.s3:
0a4e : c9 61 __ CMP #$61
0a50 : 90 fb __ BCC $0a4d ; (to_mixed_charset.s1001 + 0)
.s9:
0a52 : c9 7b __ CMP #$7b
0a54 : b0 f7 __ BCS $0a4d ; (to_mixed_charset.s1001 + 0)
.s6:
0a56 : e9 1f __ SBC #$1f
0a58 : 60 __ __ RTS
--------------------------------------------------------------------
0a59 : __ __ __ BYT 20 20 20 20 20 20 2a 2a 2a 20 48 61 63 6b 65 64 :       *** Hacked
0a69 : __ __ __ BYT 20 4d 61 70 20 47 65 6e 65 72 61 74 6f 72 20 2a :  Map Generator *
0a79 : __ __ __ BYT 2a 2a 0a 00                                     : **..
--------------------------------------------------------------------
create_rooms: ; create_rooms()->void
.s1000:
0a7d : a5 53 __ LDA T6 + 0 
0a7f : 8d d8 9f STA $9fd8 ; (create_rooms@stack + 0)
0a82 : a5 54 __ LDA T7 + 0 
0a84 : 8d d9 9f STA $9fd9 ; (create_rooms@stack + 1)
.s0:
0a87 : 20 b2 0b JSR $0bb2 ; (init_rooms.s0 + 0)
0a8a : a9 00 __ LDA #$00
0a8c : 85 0e __ STA P1 
0a8e : a9 0c __ LDA #$0c
0a90 : 85 0f __ STA P2 
0a92 : 20 1f 0a JSR $0a1f ; (print_text.s0 + 0)
0a95 : a0 00 __ LDY #$00
0a97 : 84 53 __ STY T6 + 0 
.l1002:
0a99 : 98 __ __ TYA
0a9a : 99 e5 9f STA $9fe5,y ; (connect_rooms@stack + 4)
0a9d : c8 __ __ INY
0a9e : c0 10 __ CPY #$10
0aa0 : 90 f7 __ BCC $0a99 ; (create_rooms.l1002 + 0)
.s1003:
0aa2 : a9 0f __ LDA #$0f
.l6:
0aa4 : 85 50 __ STA T0 + 0 
0aa6 : aa __ __ TAX
0aa7 : e8 __ __ INX
0aa8 : 86 51 __ STX T4 + 0 
0aaa : 8a __ __ TXA
0aab : 20 10 0c JSR $0c10 ; (rnd.s0 + 0)
0aae : aa __ __ TAX
0aaf : a4 50 __ LDY T0 + 0 
0ab1 : b9 e5 9f LDA $9fe5,y ; (connect_rooms@stack + 4)
0ab4 : 85 1b __ STA ACCU + 0 
0ab6 : bd e5 9f LDA $9fe5,x ; (connect_rooms@stack + 4)
0ab9 : 99 e5 9f STA $9fe5,y ; (connect_rooms@stack + 4)
0abc : a5 1b __ LDA ACCU + 0 
0abe : 9d e5 9f STA $9fe5,x ; (connect_rooms@stack + 4)
0ac1 : 18 __ __ CLC
0ac2 : a5 51 __ LDA T4 + 0 
0ac4 : 69 fe __ ADC #$fe
0ac6 : d0 dc __ BNE $0aa4 ; (create_rooms.l6 + 0)
.s8:
0ac8 : a9 02 __ LDA #$02
0aca : 85 51 __ STA T4 + 0 
.l10:
0acc : a9 00 __ LDA #$00
0ace : 85 52 __ STA T5 + 0 
.l14:
0ad0 : a9 02 __ LDA #$02
0ad2 : 20 10 0c JSR $0c10 ; (rnd.s0 + 0)
0ad5 : aa __ __ TAX
0ad6 : f0 0f __ BEQ $0ae7 ; (create_rooms.s144 + 0)
.s17:
0ad8 : a4 52 __ LDY T5 + 0 
0ada : b9 e6 9f LDA $9fe6,y ; (connect_rooms@stack + 5)
0add : be e5 9f LDX $9fe5,y ; (connect_rooms@stack + 4)
0ae0 : 99 e5 9f STA $9fe5,y ; (connect_rooms@stack + 4)
0ae3 : 8a __ __ TXA
0ae4 : 99 e6 9f STA $9fe6,y ; (connect_rooms@stack + 5)
.s144:
0ae7 : e6 52 __ INC T5 + 0 
0ae9 : a5 52 __ LDA T5 + 0 
0aeb : c9 0f __ CMP #$0f
0aed : 90 e1 __ BCC $0ad0 ; (create_rooms.l14 + 0)
.s11:
0aef : c6 51 __ DEC T4 + 0 
0af1 : d0 d9 __ BNE $0acc ; (create_rooms.l10 + 0)
.s12:
0af3 : a9 00 __ LDA #$00
0af5 : 85 54 __ STA T7 + 0 
0af7 : b0 02 __ BCS $0afb ; (create_rooms.l25 + 0)
.s20:
0af9 : e6 54 __ INC T7 + 0 
.l25:
0afb : a5 53 __ LDA T6 + 0 
0afd : c9 14 __ CMP #$14
0aff : b0 08 __ BCS $0b09 ; (create_rooms.s23 + 0)
.s24:
0b01 : a5 54 __ LDA T7 + 0 
0b03 : c9 10 __ CMP #$10
0b05 : 90 13 __ BCC $0b1a ; (create_rooms.s21 + 0)
.s1004:
0b07 : a5 53 __ LDA T6 + 0 
.s23:
0b09 : 8d e8 35 STA $35e8 ; (room_count + 0)
0b0c : 20 e4 0f JSR $0fe4 ; (assign_room_priorities.s0 + 0)
.s1001:
0b0f : ad d8 9f LDA $9fd8 ; (create_rooms@stack + 0)
0b12 : 85 53 __ STA T6 + 0 
0b14 : ad d9 9f LDA $9fd9 ; (create_rooms@stack + 1)
0b17 : 85 54 __ STA T7 + 0 
0b19 : 60 __ __ RTS
.s21:
0b1a : a9 0a __ LDA #$0a
0b1c : 20 10 0c JSR $0c10 ; (rnd.s0 + 0)
0b1f : c9 06 __ CMP #$06
0b21 : 90 15 __ BCC $0b38 ; (create_rooms.s26 + 0)
.s27:
0b23 : a9 05 __ LDA #$05
0b25 : 20 10 0c JSR $0c10 ; (rnd.s0 + 0)
0b28 : 85 51 __ STA T4 + 0 
0b2a : a9 05 __ LDA #$05
0b2c : 20 10 0c JSR $0c10 ; (rnd.s0 + 0)
0b2f : 18 __ __ CLC
0b30 : 69 04 __ ADC #$04
.s145:
0b32 : 85 15 __ STA P8 
0b34 : a9 04 __ LDA #$04
0b36 : d0 2d __ BNE $0b65 ; (create_rooms.s28 + 0)
.s26:
0b38 : a9 02 __ LDA #$02
0b3a : 20 10 0c JSR $0c10 ; (rnd.s0 + 0)
0b3d : aa __ __ TAX
0b3e : d0 12 __ BNE $0b52 ; (create_rooms.s29 + 0)
.s30:
0b40 : a9 03 __ LDA #$03
0b42 : 20 10 0c JSR $0c10 ; (rnd.s0 + 0)
0b45 : 85 51 __ STA T4 + 0 
0b47 : a9 04 __ LDA #$04
0b49 : 20 10 0c JSR $0c10 ; (rnd.s0 + 0)
0b4c : 18 __ __ CLC
0b4d : 69 05 __ ADC #$05
0b4f : 4c 32 0b JMP $0b32 ; (create_rooms.s145 + 0)
.s29:
0b52 : a9 04 __ LDA #$04
0b54 : 20 10 0c JSR $0c10 ; (rnd.s0 + 0)
0b57 : 85 51 __ STA T4 + 0 
0b59 : a9 03 __ LDA #$03
0b5b : 20 10 0c JSR $0c10 ; (rnd.s0 + 0)
0b5e : 18 __ __ CLC
0b5f : 69 04 __ ADC #$04
0b61 : 85 15 __ STA P8 
0b63 : a9 05 __ LDA #$05
.s28:
0b65 : 18 __ __ CLC
0b66 : 65 51 __ ADC T4 + 0 
0b68 : 85 14 __ STA P7 
0b6a : a9 e4 __ LDA #$e4
0b6c : 85 16 __ STA P9 
0b6e : a9 9f __ LDA #$9f
0b70 : 85 17 __ STA P10 
0b72 : a9 e3 __ LDA #$e3
0b74 : 8d f7 9f STA $9ff7 ; (sstack + 0)
0b77 : a9 9f __ LDA #$9f
0b79 : 8d f8 9f STA $9ff8 ; (sstack + 1)
0b7c : a6 54 __ LDX T7 + 0 
0b7e : bd e5 9f LDA $9fe5,x ; (connect_rooms@stack + 4)
0b81 : 85 13 __ STA P6 
0b83 : 20 41 0c JSR $0c41 ; (try_place_room_at_grid.s0 + 0)
0b86 : a5 1b __ LDA ACCU + 0 
0b88 : d0 03 __ BNE $0b8d ; (create_rooms.s32 + 0)
0b8a : 4c f9 0a JMP $0af9 ; (create_rooms.s20 + 0)
.s32:
0b8d : ad e4 9f LDA $9fe4 ; (connect_rooms@stack + 3)
0b90 : 85 10 __ STA P3 
0b92 : ad e3 9f LDA $9fe3 ; (connect_rooms@stack + 2)
0b95 : 85 11 __ STA P4 
0b97 : a5 14 __ LDA P7 
0b99 : 85 12 __ STA P5 
0b9b : a5 15 __ LDA P8 
0b9d : 85 13 __ STA P6 
0b9f : 20 97 0e JSR $0e97 ; (place_room.s0 + 0)
0ba2 : a9 fe __ LDA #$fe
0ba4 : 85 0e __ STA P1 
0ba6 : a9 0b __ LDA #$0b
0ba8 : 85 0f __ STA P2 
0baa : 20 1f 0a JSR $0a1f ; (print_text.s0 + 0)
0bad : e6 53 __ INC T6 + 0 
0baf : 4c f9 0a JMP $0af9 ; (create_rooms.s20 + 0)
--------------------------------------------------------------------
init_rooms: ; init_rooms()->void
.s0:
0bb2 : a9 20 __ LDA #$20
0bb4 : 85 1b __ STA ACCU + 0 
0bb6 : a9 40 __ LDA #$40
0bb8 : 85 1c __ STA ACCU + 1 
0bba : a9 28 __ LDA #$28
0bbc : 85 43 __ STA T1 + 0 
0bbe : a9 40 __ LDA #$40
0bc0 : 85 44 __ STA T1 + 1 
.l2:
0bc2 : a9 00 __ LDA #$00
0bc4 : a0 04 __ LDY #$04
0bc6 : 91 1b __ STA (ACCU + 0),y 
0bc8 : c8 __ __ INY
0bc9 : 91 1b __ STA (ACCU + 0),y 
0bcb : a0 1c __ LDY #$1c
0bcd : 91 1b __ STA (ACCU + 0),y 
0bcf : a9 ff __ LDA #$ff
0bd1 : a0 03 __ LDY #$03
.l1004:
0bd3 : 91 43 __ STA (T1 + 0),y 
0bd5 : 88 __ __ DEY
0bd6 : 10 fb __ BPL $0bd3 ; (init_rooms.l1004 + 0)
.s1005:
0bd8 : 18 __ __ CLC
0bd9 : a5 1b __ LDA ACCU + 0 
0bdb : 69 1d __ ADC #$1d
0bdd : 85 1b __ STA ACCU + 0 
0bdf : 90 02 __ BCC $0be3 ; (init_rooms.s1007 + 0)
.s1006:
0be1 : e6 1c __ INC ACCU + 1 
.s1007:
0be3 : 18 __ __ CLC
0be4 : a5 43 __ LDA T1 + 0 
0be6 : 69 1d __ ADC #$1d
0be8 : 85 43 __ STA T1 + 0 
0bea : 90 02 __ BCC $0bee ; (init_rooms.s1009 + 0)
.s1008:
0bec : e6 44 __ INC T1 + 1 
.s1009:
0bee : c9 6c __ CMP #$6c
0bf0 : d0 d0 __ BNE $0bc2 ; (init_rooms.l2 + 0)
.s1002:
0bf2 : a5 44 __ LDA T1 + 1 
0bf4 : c9 42 __ CMP #$42
0bf6 : d0 ca __ BNE $0bc2 ; (init_rooms.l2 + 0)
.s4:
0bf8 : a9 00 __ LDA #$00
0bfa : 8d e8 35 STA $35e8 ; (room_count + 0)
.s1001:
0bfd : 60 __ __ RTS
--------------------------------------------------------------------
0bfe : __ __ __ BYT 2e 00                                           : ..
--------------------------------------------------------------------
0c00 : __ __ __ BYT 0a 42 75 69 6c 64 69 6e 67 20 72 6f 6f 6d 73 00 : .Building rooms.
--------------------------------------------------------------------
rnd: ; rnd(u8)->u8
.s0:
0c10 : c9 02 __ CMP #$02
0c12 : b0 03 __ BCS $0c17 ; (rnd.s3 + 0)
.s1:
0c14 : a9 00 __ LDA #$00
0c16 : 60 __ __ RTS
.s3:
0c17 : 85 0d __ STA P0 ; (max + 0)
0c19 : ad e7 35 LDA $35e7 ; (rnd_state + 0)
0c1c : 85 1b __ STA ACCU + 0 
0c1e : a9 00 __ LDA #$00
0c20 : 85 1c __ STA ACCU + 1 
0c22 : a9 61 __ LDA #$61
0c24 : 20 19 35 JSR $3519 ; (mul16by8 + 0)
0c27 : 18 __ __ CLC
0c28 : a5 1b __ LDA ACCU + 0 
0c2a : 69 47 __ ADC #$47
0c2c : 8d e7 35 STA $35e7 ; (rnd_state + 0)
0c2f : 85 1b __ STA ACCU + 0 
0c31 : a9 00 __ LDA #$00
0c33 : 85 1c __ STA ACCU + 1 
0c35 : 85 04 __ STA WORK + 1 
0c37 : a5 0d __ LDA P0 ; (max + 0)
0c39 : 85 03 __ STA WORK + 0 
0c3b : 20 51 35 JSR $3551 ; (divmod + 0)
0c3e : a5 05 __ LDA WORK + 2 
.s1001:
0c40 : 60 __ __ RTS
--------------------------------------------------------------------
try_place_room_at_grid: ; try_place_room_at_grid(u8,u8,u8,u8*,u8*)->u8
.s0:
0c41 : a9 00 __ LDA #$00
0c43 : 85 4f __ STA T4 + 0 
.l2:
0c45 : a5 13 __ LDA P6 ; (grid_index + 0)
0c47 : 85 0e __ STA P1 
0c49 : a9 f6 __ LDA #$f6
0c4b : 85 0f __ STA P2 
0c4d : a9 9f __ LDA #$9f
0c4f : 85 12 __ STA P5 
0c51 : a9 9f __ LDA #$9f
0c53 : 85 10 __ STA P3 
0c55 : a9 f5 __ LDA #$f5
0c57 : 85 11 __ STA P4 
0c59 : 20 0b 0d JSR $0d0b ; (get_grid_position.s0 + 0)
0c5c : a5 4f __ LDA T4 + 0 
0c5e : c9 06 __ CMP #$06
0c60 : 90 68 __ BCC $0cca ; (try_place_room_at_grid.s6 + 0)
.s4:
0c62 : e9 05 __ SBC #$05
0c64 : 85 4d __ STA T2 + 0 
0c66 : 0a __ __ ASL
0c67 : 85 4a __ STA T0 + 0 
0c69 : 20 10 0c JSR $0c10 ; (rnd.s0 + 0)
0c6c : 38 __ __ SEC
0c6d : e5 4d __ SBC T2 + 0 
0c6f : 18 __ __ CLC
0c70 : 6d f6 9f ADC $9ff6 ; (add_walls@stack + 14)
0c73 : 85 4e __ STA T3 + 0 
0c75 : 8d f6 9f STA $9ff6 ; (add_walls@stack + 14)
0c78 : a5 4a __ LDA T0 + 0 
0c7a : 20 10 0c JSR $0c10 ; (rnd.s0 + 0)
0c7d : 38 __ __ SEC
0c7e : e5 4d __ SBC T2 + 0 
0c80 : 18 __ __ CLC
0c81 : 6d f5 9f ADC $9ff5 ; (add_walls@stack + 13)
0c84 : 8d f5 9f STA $9ff5 ; (add_walls@stack + 13)
0c87 : a5 4e __ LDA T3 + 0 
0c89 : c9 04 __ CMP #$04
0c8b : b0 05 __ BCS $0c92 ; (try_place_room_at_grid.s9 + 0)
.s7:
0c8d : a9 04 __ LDA #$04
0c8f : 8d f6 9f STA $9ff6 ; (add_walls@stack + 14)
.s9:
0c92 : ad f5 9f LDA $9ff5 ; (add_walls@stack + 13)
0c95 : c9 04 __ CMP #$04
0c97 : b0 05 __ BCS $0c9e ; (try_place_room_at_grid.s12 + 0)
.s10:
0c99 : a9 04 __ LDA #$04
0c9b : 8d f5 9f STA $9ff5 ; (add_walls@stack + 13)
.s12:
0c9e : 18 __ __ CLC
0c9f : a5 14 __ LDA P7 ; (w + 0)
0ca1 : 6d f6 9f ADC $9ff6 ; (add_walls@stack + 14)
0ca4 : b0 04 __ BCS $0caa ; (try_place_room_at_grid.s13 + 0)
.s1003:
0ca6 : c9 3d __ CMP #$3d
0ca8 : 90 0a __ BCC $0cb4 ; (try_place_room_at_grid.s15 + 0)
.s13:
0caa : a9 40 __ LDA #$40
0cac : e5 14 __ SBC P7 ; (w + 0)
0cae : 38 __ __ SEC
0caf : e9 04 __ SBC #$04
0cb1 : 8d f6 9f STA $9ff6 ; (add_walls@stack + 14)
.s15:
0cb4 : 18 __ __ CLC
0cb5 : a5 15 __ LDA P8 ; (h + 0)
0cb7 : 6d f5 9f ADC $9ff5 ; (add_walls@stack + 13)
0cba : b0 04 __ BCS $0cc0 ; (try_place_room_at_grid.s16 + 0)
.s1002:
0cbc : c9 3d __ CMP #$3d
0cbe : 90 0a __ BCC $0cca ; (try_place_room_at_grid.s6 + 0)
.s16:
0cc0 : a9 40 __ LDA #$40
0cc2 : e5 15 __ SBC P8 ; (h + 0)
0cc4 : 38 __ __ SEC
0cc5 : e9 04 __ SBC #$04
0cc7 : 8d f5 9f STA $9ff5 ; (add_walls@stack + 13)
.s6:
0cca : a5 14 __ LDA P7 ; (w + 0)
0ccc : 85 11 __ STA P4 
0cce : a5 15 __ LDA P8 ; (h + 0)
0cd0 : 85 12 __ STA P5 
0cd2 : ad f6 9f LDA $9ff6 ; (add_walls@stack + 14)
0cd5 : 85 4c __ STA T1 + 0 
0cd7 : 85 0f __ STA P2 
0cd9 : ad f5 9f LDA $9ff5 ; (add_walls@stack + 13)
0cdc : 85 10 __ STA P3 
0cde : 20 91 0d JSR $0d91 ; (can_place_room.s0 + 0)
0ce1 : a5 1b __ LDA ACCU + 0 
0ce3 : d0 0c __ BNE $0cf1 ; (try_place_room_at_grid.s19 + 0)
.s21:
0ce5 : e6 4f __ INC T4 + 0 
0ce7 : a5 4f __ LDA T4 + 0 
0ce9 : c9 0f __ CMP #$0f
0ceb : b0 03 __ BCS $0cf0 ; (try_place_room_at_grid.s1001 + 0)
0ced : 4c 45 0c JMP $0c45 ; (try_place_room_at_grid.l2 + 0)
.s1001:
0cf0 : 60 __ __ RTS
.s19:
0cf1 : a5 4c __ LDA T1 + 0 
0cf3 : a0 00 __ LDY #$00
0cf5 : 91 16 __ STA (P9),y ; (result_x + 0)
0cf7 : ad f7 9f LDA $9ff7 ; (sstack + 0)
0cfa : 85 4a __ STA T0 + 0 
0cfc : ad f8 9f LDA $9ff8 ; (sstack + 1)
0cff : 85 4b __ STA T0 + 1 
0d01 : ad f5 9f LDA $9ff5 ; (add_walls@stack + 13)
0d04 : 91 4a __ STA (T0 + 0),y 
0d06 : a9 01 __ LDA #$01
0d08 : 85 1b __ STA ACCU + 0 
0d0a : 60 __ __ RTS
--------------------------------------------------------------------
get_grid_position: ; get_grid_position(u8,u8*,u8*)->void
.s0:
0d0b : a9 15 __ LDA #$15
0d0d : 20 10 0c JSR $0c10 ; (rnd.s0 + 0)
0d10 : 85 44 __ STA T2 + 0 
0d12 : a9 15 __ LDA #$15
0d14 : 20 10 0c JSR $0c10 ; (rnd.s0 + 0)
0d17 : 85 45 __ STA T3 + 0 
0d19 : a5 0e __ LDA P1 ; (grid_index + 0)
0d1b : 29 03 __ AND #$03
0d1d : aa __ __ TAX
0d1e : bd d6 35 LDA $35d6,x ; (__multab14L + 0)
0d21 : 18 __ __ CLC
0d22 : 69 04 __ ADC #$04
0d24 : 18 __ __ CLC
0d25 : 65 44 __ ADC T2 + 0 
0d27 : 38 __ __ SEC
0d28 : e9 07 __ SBC #$07
0d2a : a0 00 __ LDY #$00
0d2c : 91 0f __ STA (P2),y ; (x + 0)
0d2e : a5 0e __ LDA P1 ; (grid_index + 0)
0d30 : 29 fc __ AND #$fc
0d32 : 4a __ __ LSR
0d33 : 85 43 __ STA T0 + 0 
0d35 : 0a __ __ ASL
0d36 : 0a __ __ ASL
0d37 : 0a __ __ ASL
0d38 : 38 __ __ SEC
0d39 : e5 43 __ SBC T0 + 0 
0d3b : 18 __ __ CLC
0d3c : 69 04 __ ADC #$04
0d3e : 18 __ __ CLC
0d3f : 65 45 __ ADC T3 + 0 
0d41 : 38 __ __ SEC
0d42 : e9 07 __ SBC #$07
0d44 : 91 11 __ STA (P4),y ; (y + 0)
0d46 : a9 07 __ LDA #$07
0d48 : 20 10 0c JSR $0c10 ; (rnd.s0 + 0)
0d4b : 38 __ __ SEC
0d4c : e9 03 __ SBC #$03
0d4e : 18 __ __ CLC
0d4f : a0 00 __ LDY #$00
0d51 : 71 0f __ ADC (P2),y ; (x + 0)
0d53 : 91 0f __ STA (P2),y ; (x + 0)
0d55 : a9 07 __ LDA #$07
0d57 : 20 10 0c JSR $0c10 ; (rnd.s0 + 0)
0d5a : 38 __ __ SEC
0d5b : e9 03 __ SBC #$03
0d5d : 18 __ __ CLC
0d5e : a0 00 __ LDY #$00
0d60 : 71 11 __ ADC (P4),y ; (y + 0)
0d62 : 91 11 __ STA (P4),y ; (y + 0)
0d64 : aa __ __ TAX
0d65 : b1 0f __ LDA (P2),y ; (x + 0)
0d67 : c9 04 __ CMP #$04
0d69 : b0 08 __ BCS $0d73 ; (get_grid_position.s3 + 0)
.s1:
0d6b : a9 04 __ LDA #$04
0d6d : 91 0f __ STA (P2),y ; (x + 0)
0d6f : b1 11 __ LDA (P4),y ; (y + 0)
0d71 : 90 01 __ BCC $0d74 ; (get_grid_position.s1002 + 0)
.s3:
0d73 : 8a __ __ TXA
.s1002:
0d74 : c9 04 __ CMP #$04
0d76 : b0 04 __ BCS $0d7c ; (get_grid_position.s6 + 0)
.s4:
0d78 : a9 04 __ LDA #$04
0d7a : 91 11 __ STA (P4),y ; (y + 0)
.s6:
0d7c : b1 0f __ LDA (P2),y ; (x + 0)
0d7e : c9 35 __ CMP #$35
0d80 : 90 04 __ BCC $0d86 ; (get_grid_position.s9 + 0)
.s7:
0d82 : a9 34 __ LDA #$34
0d84 : 91 0f __ STA (P2),y ; (x + 0)
.s9:
0d86 : b1 11 __ LDA (P4),y ; (y + 0)
0d88 : c9 35 __ CMP #$35
0d8a : 90 04 __ BCC $0d90 ; (get_grid_position.s1001 + 0)
.s10:
0d8c : a9 34 __ LDA #$34
0d8e : 91 11 __ STA (P4),y ; (y + 0)
.s1001:
0d90 : 60 __ __ RTS
--------------------------------------------------------------------
can_place_room: ; can_place_room(u8,u8,u8,u8)->u8
.s0:
0d91 : 18 __ __ CLC
0d92 : a5 0f __ LDA P2 ; (x + 0)
0d94 : 65 11 __ ADC P4 ; (w + 0)
0d96 : 18 __ __ CLC
0d97 : 69 04 __ ADC #$04
0d99 : c9 3d __ CMP #$3d
0d9b : b0 0c __ BCS $0da9 ; (can_place_room.s1 + 0)
.s4:
0d9d : a8 __ __ TAY
0d9e : a5 10 __ LDA P3 ; (y + 0)
0da0 : 65 12 __ ADC P5 ; (h + 0)
0da2 : 18 __ __ CLC
0da3 : 69 04 __ ADC #$04
0da5 : c9 3d __ CMP #$3d
0da7 : 90 05 __ BCC $0dae ; (can_place_room.s3 + 0)
.s1:
0da9 : a9 00 __ LDA #$00
.s1001:
0dab : 85 1b __ STA ACCU + 0 
0dad : 60 __ __ RTS
.s3:
0dae : 85 47 __ STA T3 + 0 
0db0 : a5 0f __ LDA P2 ; (x + 0)
0db2 : c9 07 __ CMP #$07
0db4 : b0 04 __ BCS $0dba ; (can_place_room.s56 + 0)
.s57:
0db6 : a9 03 __ LDA #$03
0db8 : 90 02 __ BCC $0dbc ; (can_place_room.s58 + 0)
.s56:
0dba : e9 04 __ SBC #$04
.s58:
0dbc : 85 48 __ STA T4 + 0 
0dbe : a5 10 __ LDA P3 ; (y + 0)
0dc0 : c9 07 __ CMP #$07
0dc2 : b0 04 __ BCS $0dc8 ; (can_place_room.s59 + 0)
.s60:
0dc4 : a9 03 __ LDA #$03
0dc6 : 90 02 __ BCC $0dca ; (can_place_room.s61 + 0)
.s59:
0dc8 : e9 04 __ SBC #$04
.s61:
0dca : aa __ __ TAX
0dcb : 98 __ __ TYA
0dcc : c0 40 __ CPY #$40
0dce : 90 02 __ BCC $0dd2 ; (can_place_room.s8 + 0)
.s6:
0dd0 : a9 3f __ LDA #$3f
.s8:
0dd2 : 86 45 __ STX T1 + 0 
0dd4 : 85 46 __ STA T2 + 0 
0dd6 : a5 47 __ LDA T3 + 0 
0dd8 : c9 40 __ CMP #$40
0dda : 90 04 __ BCC $0de0 ; (can_place_room.l102 + 0)
.s9:
0ddc : a9 3f __ LDA #$3f
0dde : 85 47 __ STA T3 + 0 
.l102:
0de0 : c5 45 __ CMP T1 + 0 
0de2 : b0 04 __ BCS $0de8 ; (can_place_room.s13 + 0)
.s15:
0de4 : a9 01 __ LDA #$01
0de6 : 90 c3 __ BCC $0dab ; (can_place_room.s1001 + 0)
.s13:
0de8 : a5 46 __ LDA T2 + 0 
0dea : c5 48 __ CMP T4 + 0 
0dec : 90 1a __ BCC $0e08 ; (can_place_room.s14 + 0)
.s31:
0dee : a5 48 __ LDA T4 + 0 
0df0 : 85 49 __ STA T5 + 0 
.l17:
0df2 : a5 49 __ LDA T5 + 0 
0df4 : 85 0d __ STA P0 
0df6 : a5 45 __ LDA T1 + 0 
0df8 : 85 0e __ STA P1 
0dfa : 20 0e 0e JSR $0e0e ; (get_compact_tile.s0 + 0)
0dfd : aa __ __ TAX
0dfe : d0 a9 __ BNE $0da9 ; (can_place_room.s1 + 0)
.s18:
0e00 : e6 49 __ INC T5 + 0 
0e02 : a5 46 __ LDA T2 + 0 
0e04 : c5 49 __ CMP T5 + 0 
0e06 : b0 ea __ BCS $0df2 ; (can_place_room.l17 + 0)
.s14:
0e08 : e6 45 __ INC T1 + 0 
0e0a : a5 47 __ LDA T3 + 0 
0e0c : 90 d2 __ BCC $0de0 ; (can_place_room.l102 + 0)
--------------------------------------------------------------------
get_compact_tile: ; get_compact_tile(u8,u8)->u8
.s0:
0e0e : a5 0d __ LDA P0 ; (x + 0)
0e10 : c9 40 __ CMP #$40
0e12 : b0 06 __ BCS $0e1a ; (get_compact_tile.s1 + 0)
.s4:
0e14 : a5 0e __ LDA P1 ; (y + 0)
0e16 : c9 40 __ CMP #$40
0e18 : 90 03 __ BCC $0e1d ; (get_compact_tile.s3 + 0)
.s1:
0e1a : a9 00 __ LDA #$00
.s1001:
0e1c : 60 __ __ RTS
.s3:
0e1d : 85 1c __ STA ACCU + 1 
0e1f : 4a __ __ LSR
0e20 : aa __ __ TAX
0e21 : a9 00 __ LDA #$00
0e23 : 6a __ __ ROR
0e24 : 85 43 __ STA T1 + 0 
0e26 : a9 00 __ LDA #$00
0e28 : 46 1c __ LSR ACCU + 1 
0e2a : 6a __ __ ROR
0e2b : 66 1c __ ROR ACCU + 1 
0e2d : 6a __ __ ROR
0e2e : 65 43 __ ADC T1 + 0 
0e30 : a8 __ __ TAY
0e31 : 8a __ __ TXA
0e32 : 65 1c __ ADC ACCU + 1 
0e34 : aa __ __ TAX
0e35 : 98 __ __ TYA
0e36 : 18 __ __ CLC
0e37 : 65 0d __ ADC P0 ; (x + 0)
0e39 : 90 01 __ BCC $0e3c ; (get_compact_tile.s1015 + 0)
.s1014:
0e3b : e8 __ __ INX
.s1015:
0e3c : 18 __ __ CLC
0e3d : 65 0d __ ADC P0 ; (x + 0)
0e3f : 90 01 __ BCC $0e42 ; (get_compact_tile.s1017 + 0)
.s1016:
0e41 : e8 __ __ INX
.s1017:
0e42 : 18 __ __ CLC
0e43 : 65 0d __ ADC P0 ; (x + 0)
0e45 : a8 __ __ TAY
0e46 : 8a __ __ TXA
0e47 : 69 00 __ ADC #$00
0e49 : 4a __ __ LSR
0e4a : 85 44 __ STA T1 + 1 
0e4c : 98 __ __ TYA
0e4d : 6a __ __ ROR
0e4e : 46 44 __ LSR T1 + 1 
0e50 : 6a __ __ ROR
0e51 : 46 44 __ LSR T1 + 1 
0e53 : 6a __ __ ROR
0e54 : 85 43 __ STA T1 + 0 
0e56 : 18 __ __ CLC
0e57 : a9 3a __ LDA #$3a
0e59 : 65 44 __ ADC T1 + 1 
0e5b : 85 44 __ STA T1 + 1 
0e5d : 98 __ __ TYA
0e5e : 29 07 __ AND #$07
0e60 : 85 1b __ STA ACCU + 0 
0e62 : aa __ __ TAX
0e63 : a0 20 __ LDY #$20
0e65 : b1 43 __ LDA (T1 + 0),y 
0e67 : e0 00 __ CPX #$00
0e69 : f0 04 __ BEQ $0e6f ; (get_compact_tile.s1003 + 0)
.l1002:
0e6b : 4a __ __ LSR
0e6c : ca __ __ DEX
0e6d : d0 fc __ BNE $0e6b ; (get_compact_tile.l1002 + 0)
.s1003:
0e6f : 85 1c __ STA ACCU + 1 
0e71 : a5 1b __ LDA ACCU + 0 
0e73 : c9 06 __ CMP #$06
0e75 : b0 05 __ BCS $0e7c ; (get_compact_tile.s7 + 0)
.s6:
0e77 : a5 1c __ LDA ACCU + 1 
.s1009:
0e79 : 29 07 __ AND #$07
0e7b : 60 __ __ RTS
.s7:
0e7c : a9 08 __ LDA #$08
0e7e : e5 1b __ SBC ACCU + 0 
0e80 : aa __ __ TAX
0e81 : bd 24 36 LDA $3624,x ; (bitshift + 36)
0e84 : 38 __ __ SEC
0e85 : e9 01 __ SBC #$01
0e87 : c8 __ __ INY
0e88 : 31 43 __ AND (T1 + 0),y 
0e8a : e0 00 __ CPX #$00
0e8c : f0 04 __ BEQ $0e92 ; (get_compact_tile.s1005 + 0)
.l1006:
0e8e : 0a __ __ ASL
0e8f : ca __ __ DEX
0e90 : d0 fc __ BNE $0e8e ; (get_compact_tile.l1006 + 0)
.s1005:
0e92 : 05 1c __ ORA ACCU + 1 
0e94 : 4c 79 0e JMP $0e79 ; (get_compact_tile.s1009 + 0)
--------------------------------------------------------------------
place_room: ; place_room(u8,u8,u8,u8)->void
.s0:
0e97 : a5 11 __ LDA P4 ; (y + 0)
0e99 : 85 4a __ STA T4 + 0 
0e9b : 4c a0 0e JMP $0ea0 ; (place_room.l1 + 0)
.s3:
0e9e : e6 4a __ INC T4 + 0 
.l1:
0ea0 : 18 __ __ CLC
0ea1 : a5 13 __ LDA P6 ; (h + 0)
0ea3 : 65 11 __ ADC P4 ; (y + 0)
0ea5 : b0 49 __ BCS $0ef0 ; (place_room.s2 + 0)
.s1005:
0ea7 : c5 4a __ CMP T4 + 0 
0ea9 : 90 02 __ BCC $0ead ; (place_room.s4 + 0)
.s1009:
0eab : d0 43 __ BNE $0ef0 ; (place_room.s2 + 0)
.s4:
0ead : ad e8 35 LDA $35e8 ; (room_count + 0)
0eb0 : c9 14 __ CMP #$14
0eb2 : b0 3b __ BCS $0eef ; (place_room.s1001 + 0)
.s10:
0eb4 : 85 47 __ STA T1 + 0 
0eb6 : 85 1b __ STA ACCU + 0 
0eb8 : a9 00 __ LDA #$00
0eba : 85 1c __ STA ACCU + 1 
0ebc : a9 1d __ LDA #$1d
0ebe : 20 19 35 JSR $3519 ; (mul16by8 + 0)
0ec1 : 18 __ __ CLC
0ec2 : a9 20 __ LDA #$20
0ec4 : 65 1b __ ADC ACCU + 0 
0ec6 : 85 43 __ STA T0 + 0 
0ec8 : a9 40 __ LDA #$40
0eca : 65 1c __ ADC ACCU + 1 
0ecc : 85 44 __ STA T0 + 1 
0ece : a5 10 __ LDA P3 ; (x + 0)
0ed0 : a0 00 __ LDY #$00
0ed2 : 91 43 __ STA (T0 + 0),y 
0ed4 : a5 11 __ LDA P4 ; (y + 0)
0ed6 : c8 __ __ INY
0ed7 : 91 43 __ STA (T0 + 0),y 
0ed9 : a5 12 __ LDA P5 ; (w + 0)
0edb : c8 __ __ INY
0edc : 91 43 __ STA (T0 + 0),y 
0ede : a5 13 __ LDA P6 ; (h + 0)
0ee0 : c8 __ __ INY
0ee1 : 91 43 __ STA (T0 + 0),y 
0ee3 : a9 00 __ LDA #$00
0ee5 : a0 07 __ LDY #$07
0ee7 : 91 43 __ STA (T0 + 0),y 
0ee9 : a6 47 __ LDX T1 + 0 
0eeb : e8 __ __ INX
0eec : 8e e8 35 STX $35e8 ; (room_count + 0)
.s1001:
0eef : 60 __ __ RTS
.s2:
0ef0 : a5 10 __ LDA P3 ; (x + 0)
0ef2 : 85 49 __ STA T2 + 0 
0ef4 : 18 __ __ CLC
0ef5 : 65 12 __ ADC P5 ; (w + 0)
0ef7 : 85 47 __ STA T1 + 0 
0ef9 : a9 00 __ LDA #$00
0efb : 2a __ __ ROL
0efc : 85 48 __ STA T1 + 1 
0efe : f0 15 __ BEQ $0f15 ; (place_room.s1002 + 0)
.l1008:
0f00 : a5 49 __ LDA T2 + 0 
.l6:
0f02 : 85 0d __ STA P0 
0f04 : a5 4a __ LDA T4 + 0 
0f06 : 85 0e __ STA P1 
0f08 : a9 02 __ LDA #$02
0f0a : 85 0f __ STA P2 
0f0c : 20 1d 0f JSR $0f1d ; (set_compact_tile.s0 + 0)
0f0f : e6 49 __ INC T2 + 0 
0f11 : a5 48 __ LDA T1 + 1 
0f13 : d0 eb __ BNE $0f00 ; (place_room.l1008 + 0)
.s1002:
0f15 : a5 49 __ LDA T2 + 0 
0f17 : c5 47 __ CMP T1 + 0 
0f19 : 90 e7 __ BCC $0f02 ; (place_room.l6 + 0)
0f1b : b0 81 __ BCS $0e9e ; (place_room.s3 + 0)
--------------------------------------------------------------------
set_compact_tile: ; set_compact_tile(u8,u8,u8)->void
.s0:
0f1d : a5 0d __ LDA P0 ; (x + 0)
0f1f : c9 40 __ CMP #$40
0f21 : b0 74 __ BCS $0f97 ; (set_compact_tile.s1001 + 0)
.s4:
0f23 : a5 0e __ LDA P1 ; (y + 0)
0f25 : c9 40 __ CMP #$40
0f27 : b0 6e __ BCS $0f97 ; (set_compact_tile.s1001 + 0)
.s3:
0f29 : a5 0f __ LDA P2 ; (tile + 0)
0f2b : 29 07 __ AND #$07
0f2d : 85 1d __ STA ACCU + 2 
0f2f : a5 0e __ LDA P1 ; (y + 0)
0f31 : 4a __ __ LSR
0f32 : aa __ __ TAX
0f33 : a9 00 __ LDA #$00
0f35 : 6a __ __ ROR
0f36 : 85 43 __ STA T1 + 0 
0f38 : a9 00 __ LDA #$00
0f3a : 46 0e __ LSR P1 ; (y + 0)
0f3c : 6a __ __ ROR
0f3d : 66 0e __ ROR P1 ; (y + 0)
0f3f : 6a __ __ ROR
0f40 : 65 43 __ ADC T1 + 0 
0f42 : a8 __ __ TAY
0f43 : 8a __ __ TXA
0f44 : 65 0e __ ADC P1 ; (y + 0)
0f46 : aa __ __ TAX
0f47 : 98 __ __ TYA
0f48 : 18 __ __ CLC
0f49 : 65 0d __ ADC P0 ; (x + 0)
0f4b : 90 01 __ BCC $0f4e ; (set_compact_tile.s1023 + 0)
.s1022:
0f4d : e8 __ __ INX
.s1023:
0f4e : 18 __ __ CLC
0f4f : 65 0d __ ADC P0 ; (x + 0)
0f51 : 90 01 __ BCC $0f54 ; (set_compact_tile.s1025 + 0)
.s1024:
0f53 : e8 __ __ INX
.s1025:
0f54 : 18 __ __ CLC
0f55 : 65 0d __ ADC P0 ; (x + 0)
0f57 : 85 1b __ STA ACCU + 0 
0f59 : 8a __ __ TXA
0f5a : 69 00 __ ADC #$00
0f5c : 4a __ __ LSR
0f5d : 85 44 __ STA T1 + 1 
0f5f : a5 1b __ LDA ACCU + 0 
0f61 : 6a __ __ ROR
0f62 : 46 44 __ LSR T1 + 1 
0f64 : 6a __ __ ROR
0f65 : 46 44 __ LSR T1 + 1 
0f67 : 6a __ __ ROR
0f68 : 85 43 __ STA T1 + 0 
0f6a : 18 __ __ CLC
0f6b : a9 3a __ LDA #$3a
0f6d : 65 44 __ ADC T1 + 1 
0f6f : 85 44 __ STA T1 + 1 
0f71 : a0 20 __ LDY #$20
0f73 : b1 43 __ LDA (T1 + 0),y 
0f75 : 85 1c __ STA ACCU + 1 
0f77 : a5 1b __ LDA ACCU + 0 
0f79 : 29 07 __ AND #$07
0f7b : c9 06 __ CMP #$06
0f7d : b0 19 __ BCS $0f98 ; (set_compact_tile.s7 + 0)
.s6:
0f7f : aa __ __ TAX
0f80 : bd da 35 LDA $35da,x ; (__shltab7L + 0)
0f83 : 49 ff __ EOR #$ff
0f85 : 25 1c __ AND ACCU + 1 
0f87 : 85 1c __ STA ACCU + 1 
0f89 : a5 1d __ LDA ACCU + 2 
0f8b : e0 00 __ CPX #$00
0f8d : f0 04 __ BEQ $0f93 ; (set_compact_tile.s1016 + 0)
.l1014:
0f8f : 0a __ __ ASL
0f90 : ca __ __ DEX
0f91 : d0 fc __ BNE $0f8f ; (set_compact_tile.l1014 + 0)
.s1016:
0f93 : 05 1c __ ORA ACCU + 1 
.s1017:
0f95 : 91 43 __ STA (T1 + 0),y 
.s1001:
0f97 : 60 __ __ RTS
.s7:
0f98 : 85 1b __ STA ACCU + 0 
0f9a : 49 ff __ EOR #$ff
0f9c : 69 08 __ ADC #$08
0f9e : 85 1e __ STA ACCU + 3 
0fa0 : aa __ __ TAX
0fa1 : bd 08 36 LDA $3608,x ; (bitshift + 8)
0fa4 : 38 __ __ SEC
0fa5 : e9 01 __ SBC #$01
0fa7 : 85 45 __ STA T5 + 0 
0fa9 : 25 1d __ AND ACCU + 2 
0fab : a6 1b __ LDX ACCU + 0 
0fad : f0 04 __ BEQ $0fb3 ; (set_compact_tile.s1003 + 0)
.l1010:
0faf : 0a __ __ ASL
0fb0 : ca __ __ DEX
0fb1 : d0 fc __ BNE $0faf ; (set_compact_tile.l1010 + 0)
.s1003:
0fb3 : 85 46 __ STA T6 + 0 
0fb5 : a5 45 __ LDA T5 + 0 
0fb7 : a6 1b __ LDX ACCU + 0 
0fb9 : f0 04 __ BEQ $0fbf ; (set_compact_tile.s1005 + 0)
.l1012:
0fbb : 0a __ __ ASL
0fbc : ca __ __ DEX
0fbd : d0 fc __ BNE $0fbb ; (set_compact_tile.l1012 + 0)
.s1005:
0fbf : 49 ff __ EOR #$ff
0fc1 : 25 1c __ AND ACCU + 1 
0fc3 : 05 46 __ ORA T6 + 0 
0fc5 : 91 43 __ STA (T1 + 0),y 
0fc7 : a6 1e __ LDX ACCU + 3 
0fc9 : bd 24 36 LDA $3624,x ; (bitshift + 36)
0fcc : 38 __ __ SEC
0fcd : e9 01 __ SBC #$01
0fcf : 49 ff __ EOR #$ff
0fd1 : c8 __ __ INY
0fd2 : 31 43 __ AND (T1 + 0),y 
0fd4 : 85 1b __ STA ACCU + 0 
0fd6 : a5 1d __ LDA ACCU + 2 
.l1006:
0fd8 : 4a __ __ LSR
0fd9 : ca __ __ DEX
0fda : d0 fc __ BNE $0fd8 ; (set_compact_tile.l1006 + 0)
.s1007:
0fdc : 05 1b __ ORA ACCU + 0 
0fde : a0 20 __ LDY #$20
0fe0 : c8 __ __ INY
0fe1 : 4c 95 0f JMP $0f95 ; (set_compact_tile.s1017 + 0)
--------------------------------------------------------------------
assign_room_priorities: ; assign_room_priorities()->void
.s0:
0fe4 : ad e8 35 LDA $35e8 ; (room_count + 0)
0fe7 : f0 24 __ BEQ $100d ; (assign_room_priorities.s1001 + 0)
.s14:
0fe9 : 85 46 __ STA T3 + 0 
0feb : a9 00 __ LDA #$00
0fed : 85 47 __ STA T4 + 0 
0fef : 85 43 __ STA T1 + 0 
0ff1 : a9 0a __ LDA #$0a
0ff3 : 8d 27 40 STA $4027 ; (rooms + 7)
0ff6 : a9 27 __ LDA #$27
0ff8 : 85 44 __ STA T2 + 0 
0ffa : a9 40 __ LDA #$40
0ffc : 85 45 __ STA T2 + 1 
0ffe : 4c 05 10 JMP $1005 ; (assign_room_priorities.l1 + 0)
.s1002:
1001 : a0 00 __ LDY #$00
1003 : 91 44 __ STA (T2 + 0),y 
.l1:
1005 : e6 47 __ INC T4 + 0 
1007 : a5 47 __ LDA T4 + 0 
1009 : c5 46 __ CMP T3 + 0 
100b : 90 01 __ BCC $100e ; (assign_room_priorities.s43 + 0)
.s1001:
100d : 60 __ __ RTS
.s43:
100e : a5 44 __ LDA T2 + 0 
1010 : 69 1d __ ADC #$1d
1012 : 85 44 __ STA T2 + 0 
1014 : 90 02 __ BCC $1018 ; (assign_room_priorities.s1005 + 0)
.s1004:
1016 : e6 45 __ INC T2 + 1 
.s1005:
1018 : a6 46 __ LDX T3 + 0 
101a : ca __ __ DEX
101b : 86 1b __ STX ACCU + 0 
101d : e6 43 __ INC T1 + 0 
101f : a5 43 __ LDA T1 + 0 
1021 : c5 1b __ CMP ACCU + 0 
1023 : d0 04 __ BNE $1029 ; (assign_room_priorities.s9 + 0)
.s8:
1025 : a9 08 __ LDA #$08
1027 : d0 d8 __ BNE $1001 ; (assign_room_priorities.s1002 + 0)
.s9:
1029 : a9 03 __ LDA #$03
102b : 20 10 0c JSR $0c10 ; (rnd.s0 + 0)
102e : 18 __ __ CLC
102f : 69 05 __ ADC #$05
1031 : 4c 01 10 JMP $1001 ; (assign_room_priorities.s1002 + 0)
--------------------------------------------------------------------
connect_rooms: ; connect_rooms()->void
.s1000:
1034 : a2 07 __ LDX #$07
1036 : b5 53 __ LDA T2 + 0,x 
1038 : 9d e1 9f STA $9fe1,x ; (create_rooms@stack + 9)
103b : ca __ __ DEX
103c : 10 f8 __ BPL $1036 ; (connect_rooms.s1000 + 2)
.s0:
103e : a9 0d __ LDA #$0d
1040 : 85 0e __ STA P1 
1042 : a9 11 __ LDA #$11
1044 : 85 0f __ STA P2 
1046 : 20 1f 0a JSR $0a1f ; (print_text.s0 + 0)
1049 : ad e8 35 LDA $35e8 ; (room_count + 0)
104c : 85 54 __ STA T3 + 0 
104e : d0 08 __ BNE $1058 ; (connect_rooms.s1002 + 0)
.s1003:
1050 : a9 00 __ LDA #$00
1052 : 85 55 __ STA T4 + 0 
.s4:
1054 : 85 53 __ STA T2 + 0 
1056 : f0 12 __ BEQ $106a ; (connect_rooms.l5 + 0)
.s1002:
1058 : a9 01 __ LDA #$01
105a : 85 55 __ STA T4 + 0 
105c : a2 00 __ LDX #$00
.l1009:
105e : 9d ec 35 STA $35ec,x ; (connected + 0)
1061 : e8 __ __ INX
1062 : e4 54 __ CPX T3 + 0 
1064 : a9 00 __ LDA #$00
1066 : 90 f6 __ BCC $105e ; (connect_rooms.l1009 + 0)
1068 : b0 ea __ BCS $1054 ; (connect_rooms.s4 + 0)
.l5:
106a : 38 __ __ SEC
106b : a5 54 __ LDA T3 + 0 
106d : e9 01 __ SBC #$01
106f : b0 03 __ BCS $1074 ; (connect_rooms.s1005 + 0)
1071 : 4c 02 11 JMP $1102 ; (connect_rooms.s1001 + 0)
.s1005:
1074 : c5 53 __ CMP T2 + 0 
1076 : 90 f9 __ BCC $1071 ; (connect_rooms.l5 + 7)
.s1019:
1078 : f0 f7 __ BEQ $1071 ; (connect_rooms.l5 + 7)
.s6:
107a : a9 ff __ LDA #$ff
107c : 85 56 __ STA T5 + 0 
107e : 85 57 __ STA T6 + 0 
1080 : a5 55 __ LDA T4 + 0 
1082 : f0 4c __ BEQ $10d0 ; (connect_rooms.s11 + 0)
.s49:
1084 : a9 ff __ LDA #$ff
1086 : 85 58 __ STA T7 + 0 
1088 : a0 00 __ LDY #$00
108a : ad ec 35 LDA $35ec ; (connected + 0)
108d : f0 35 __ BEQ $10c4 ; (connect_rooms.l10 + 0)
.l14:
108f : a5 55 __ LDA T4 + 0 
1091 : f0 31 __ BEQ $10c4 ; (connect_rooms.l10 + 0)
.s48:
1093 : 84 59 __ STY T8 + 0 
1095 : a0 00 __ LDY #$00
.l17:
1097 : 84 5a __ STY T9 + 0 
1099 : b9 ec 35 LDA $35ec,y ; (connected + 0)
109c : d0 1d __ BNE $10bb ; (connect_rooms.s16 + 0)
.s23:
109e : a5 59 __ LDA T8 + 0 
10a0 : c5 5a __ CMP T9 + 0 
10a2 : f0 17 __ BEQ $10bb ; (connect_rooms.s16 + 0)
.s22:
10a4 : 84 10 __ STY P3 
10a6 : 85 0f __ STA P2 
10a8 : 20 1f 11 JSR $111f ; (get_cached_room_distance.s0 + 0)
10ab : a5 1b __ LDA ACCU + 0 
10ad : c5 58 __ CMP T7 + 0 
10af : b0 0a __ BCS $10bb ; (connect_rooms.s16 + 0)
.s25:
10b1 : 85 58 __ STA T7 + 0 
10b3 : a5 0f __ LDA P2 
10b5 : 85 56 __ STA T5 + 0 
10b7 : a5 5a __ LDA T9 + 0 
10b9 : 85 57 __ STA T6 + 0 
.s16:
10bb : a4 5a __ LDY T9 + 0 
10bd : c8 __ __ INY
10be : c4 54 __ CPY T3 + 0 
10c0 : 90 d5 __ BCC $1097 ; (connect_rooms.l17 + 0)
.s1017:
10c2 : a4 59 __ LDY T8 + 0 
.l10:
10c4 : c8 __ __ INY
10c5 : c4 54 __ CPY T3 + 0 
10c7 : b0 07 __ BCS $10d0 ; (connect_rooms.s11 + 0)
.s9:
10c9 : b9 ec 35 LDA $35ec,y ; (connected + 0)
10cc : f0 f6 __ BEQ $10c4 ; (connect_rooms.l10 + 0)
10ce : d0 bf __ BNE $108f ; (connect_rooms.l14 + 0)
.s11:
10d0 : a6 56 __ LDX T5 + 0 
10d2 : e8 __ __ INX
10d3 : f0 2d __ BEQ $1102 ; (connect_rooms.s1001 + 0)
.s31:
10d5 : a6 57 __ LDX T6 + 0 
10d7 : e8 __ __ INX
10d8 : f0 28 __ BEQ $1102 ; (connect_rooms.s1001 + 0)
.s28:
10da : a5 56 __ LDA T5 + 0 
10dc : 8d fe 9f STA $9ffe ; (sstack + 7)
10df : a5 57 __ LDA T6 + 0 
10e1 : 8d ff 9f STA $9fff ; (sstack + 8)
10e4 : 20 ec 12 JSR $12ec ; (connect_rooms_directly.s1000 + 0)
10e7 : a5 1b __ LDA ACCU + 0 
10e9 : f0 17 __ BEQ $1102 ; (connect_rooms.s1001 + 0)
.s32:
10eb : a9 01 __ LDA #$01
10ed : a6 57 __ LDX T6 + 0 
10ef : 9d ec 35 STA $35ec,x ; (connected + 0)
10f2 : a9 fe __ LDA #$fe
10f4 : 85 0e __ STA P1 
10f6 : a9 0b __ LDA #$0b
10f8 : 85 0f __ STA P2 
10fa : 20 1f 0a JSR $0a1f ; (print_text.s0 + 0)
10fd : e6 53 __ INC T2 + 0 
10ff : 4c 6a 10 JMP $106a ; (connect_rooms.l5 + 0)
.s1001:
1102 : a2 07 __ LDX #$07
1104 : bd e1 9f LDA $9fe1,x ; (create_rooms@stack + 9)
1107 : 95 53 __ STA T2 + 0,x 
1109 : ca __ __ DEX
110a : 10 f8 __ BPL $1104 ; (connect_rooms.s1001 + 2)
110c : 60 __ __ RTS
--------------------------------------------------------------------
110d : __ __ __ BYT 0a 43 6f 6e 6e 65 63 74 69 6e 67 20 72 6f 6f 6d : .Connecting room
111d : __ __ __ BYT 73 00                                           : s.
--------------------------------------------------------------------
get_cached_room_distance: ; get_cached_room_distance(u8,u8)->u8
.s0:
111f : ad ea 35 LDA $35ea ; (distance_cache_valid + 0)
1122 : f0 0c __ BEQ $1130 ; (get_cached_room_distance.s1006 + 0)
.s5:
1124 : a5 0f __ LDA P2 ; (room1 + 0)
1126 : c9 14 __ CMP #$14
1128 : b0 08 __ BCS $1132 ; (get_cached_room_distance.s1 + 0)
.s4:
112a : a5 10 __ LDA P3 ; (room2 + 0)
112c : c9 14 __ CMP #$14
112e : 90 0e __ BCC $113e ; (get_cached_room_distance.s3 + 0)
.s1006:
1130 : a5 0f __ LDA P2 ; (room1 + 0)
.s1:
1132 : 85 0d __ STA P0 
1134 : a5 10 __ LDA P3 ; (room2 + 0)
1136 : 85 0e __ STA P1 
1138 : 20 89 11 JSR $1189 ; (calculate_room_distance.s0 + 0)
.s1001:
113b : 85 1b __ STA ACCU + 0 
113d : 60 __ __ RTS
.s3:
113e : a5 0f __ LDA P2 ; (room1 + 0)
1140 : 0a __ __ ASL
1141 : 0a __ __ ASL
1142 : 65 0f __ ADC P2 ; (room1 + 0)
1144 : 0a __ __ ASL
1145 : 0a __ __ ASL
1146 : a2 00 __ LDX #$00
1148 : 90 01 __ BCC $114b ; (get_cached_room_distance.s1003 + 0)
.s1002:
114a : e8 __ __ INX
.s1003:
114b : 18 __ __ CLC
114c : 69 8c __ ADC #$8c
114e : 85 48 __ STA T0 + 0 
1150 : 8a __ __ TXA
1151 : 69 42 __ ADC #$42
1153 : 85 49 __ STA T0 + 1 
1155 : a4 10 __ LDY P3 ; (room2 + 0)
1157 : b1 48 __ LDA (T0 + 0),y 
1159 : c9 ff __ CMP #$ff
115b : d0 de __ BNE $113b ; (get_cached_room_distance.s1001 + 0)
.s9:
115d : 84 0e __ STY P1 
115f : a5 0f __ LDA P2 ; (room1 + 0)
1161 : 85 0d __ STA P0 
1163 : 20 89 11 JSR $1189 ; (calculate_room_distance.s0 + 0)
1166 : a4 10 __ LDY P3 ; (room2 + 0)
1168 : 91 48 __ STA (T0 + 0),y 
116a : aa __ __ TAX
116b : 98 __ __ TYA
116c : 0a __ __ ASL
116d : 0a __ __ ASL
116e : 65 10 __ ADC P3 ; (room2 + 0)
1170 : 0a __ __ ASL
1171 : 0a __ __ ASL
1172 : a0 00 __ LDY #$00
1174 : 90 01 __ BCC $1177 ; (get_cached_room_distance.s1005 + 0)
.s1004:
1176 : c8 __ __ INY
.s1005:
1177 : 18 __ __ CLC
1178 : 69 8c __ ADC #$8c
117a : 85 48 __ STA T0 + 0 
117c : 98 __ __ TYA
117d : 69 42 __ ADC #$42
117f : 85 49 __ STA T0 + 1 
1181 : 8a __ __ TXA
1182 : a4 0f __ LDY P2 ; (room1 + 0)
1184 : 91 48 __ STA (T0 + 0),y 
1186 : 4c 3b 11 JMP $113b ; (get_cached_room_distance.s1001 + 0)
--------------------------------------------------------------------
calculate_room_distance: ; calculate_room_distance(u8,u8)->u8
.s0:
1189 : ad e9 35 LDA $35e9 ; (room_center_cache_valid + 0)
118c : d0 05 __ BNE $1193 ; (calculate_room_distance.s5 + 0)
.s1003:
118e : a5 0d __ LDA P0 ; (room1 + 0)
1190 : 4c a8 11 JMP $11a8 ; (calculate_room_distance.s2 + 0)
.s5:
1193 : a5 0d __ LDA P0 ; (room1 + 0)
1195 : c9 14 __ CMP #$14
1197 : b0 0f __ BCS $11a8 ; (calculate_room_distance.s2 + 0)
.s4:
1199 : 0a __ __ ASL
119a : aa __ __ TAX
119b : bd 65 42 LDA $4265,x ; (room_center_cache + 1)
119e : 85 47 __ STA T7 + 0 
11a0 : bd 64 42 LDA $4264,x ; (room_center_cache + 0)
11a3 : 85 46 __ STA T6 + 0 
11a5 : 4c 28 12 JMP $1228 ; (calculate_room_distance.s1 + 0)
.s2:
11a8 : 85 43 __ STA T0 + 0 
11aa : cd e8 35 CMP $35e8 ; (room_count + 0)
11ad : 90 06 __ BCC $11b5 ; (calculate_room_distance.s9 + 0)
.s7:
11af : a9 00 __ LDA #$00
11b1 : 85 44 __ STA T2 + 0 
11b3 : b0 59 __ BCS $120e ; (calculate_room_distance.s12 + 0)
.s9:
11b5 : 85 1b __ STA ACCU + 0 
11b7 : a9 00 __ LDA #$00
11b9 : 85 1c __ STA ACCU + 1 
11bb : a9 1d __ LDA #$1d
11bd : 20 19 35 JSR $3519 ; (mul16by8 + 0)
11c0 : 18 __ __ CLC
11c1 : a9 20 __ LDA #$20
11c3 : 65 1b __ ADC ACCU + 0 
11c5 : 85 1b __ STA ACCU + 0 
11c7 : a9 40 __ LDA #$40
11c9 : 65 1c __ ADC ACCU + 1 
11cb : 85 1c __ STA ACCU + 1 
11cd : a0 03 __ LDY #$03
11cf : b1 1b __ LDA (ACCU + 0),y 
11d1 : 38 __ __ SEC
11d2 : e9 01 __ SBC #$01
11d4 : a8 __ __ TAY
11d5 : a9 00 __ LDA #$00
11d7 : e9 00 __ SBC #$00
11d9 : aa __ __ TAX
11da : 0a __ __ ASL
11db : 98 __ __ TYA
11dc : 69 00 __ ADC #$00
11de : 85 44 __ STA T2 + 0 
11e0 : 8a __ __ TXA
11e1 : 69 00 __ ADC #$00
11e3 : 4a __ __ LSR
11e4 : 66 44 __ ROR T2 + 0 
11e6 : a0 01 __ LDY #$01
11e8 : b1 1b __ LDA (ACCU + 0),y 
11ea : 18 __ __ CLC
11eb : 65 44 __ ADC T2 + 0 
11ed : 85 44 __ STA T2 + 0 
11ef : c8 __ __ INY
11f0 : b1 1b __ LDA (ACCU + 0),y 
11f2 : 38 __ __ SEC
11f3 : e9 01 __ SBC #$01
11f5 : a8 __ __ TAY
11f6 : a9 00 __ LDA #$00
11f8 : e9 00 __ SBC #$00
11fa : aa __ __ TAX
11fb : 0a __ __ ASL
11fc : 98 __ __ TYA
11fd : 69 00 __ ADC #$00
11ff : 85 45 __ STA T3 + 0 
1201 : 8a __ __ TXA
1202 : 69 00 __ ADC #$00
1204 : 4a __ __ LSR
1205 : 66 45 __ ROR T3 + 0 
1207 : a0 00 __ LDY #$00
1209 : b1 1b __ LDA (ACCU + 0),y 
120b : 18 __ __ CLC
120c : 65 45 __ ADC T3 + 0 
.s12:
120e : 85 46 __ STA T6 + 0 
1210 : aa __ __ TAX
1211 : a5 44 __ LDA T2 + 0 
1213 : 85 47 __ STA T7 + 0 
1215 : a5 0d __ LDA P0 ; (room1 + 0)
1217 : c9 14 __ CMP #$14
1219 : b0 0d __ BCS $1228 ; (calculate_room_distance.s1 + 0)
.s18:
121b : 06 43 __ ASL T0 + 0 
121d : 8a __ __ TXA
121e : a6 43 __ LDX T0 + 0 
1220 : 9d 64 42 STA $4264,x ; (room_center_cache + 0)
1223 : a5 44 __ LDA T2 + 0 
1225 : 9d 65 42 STA $4265,x ; (room_center_cache + 1)
.s1:
1228 : ad e9 35 LDA $35e9 ; (room_center_cache_valid + 0)
122b : d0 05 __ BNE $1232 ; (calculate_room_distance.s26 + 0)
.s1002:
122d : a5 0e __ LDA P1 ; (room2 + 0)
122f : 4c 47 12 JMP $1247 ; (calculate_room_distance.s23 + 0)
.s26:
1232 : a5 0e __ LDA P1 ; (room2 + 0)
1234 : c9 14 __ CMP #$14
1236 : b0 0f __ BCS $1247 ; (calculate_room_distance.s23 + 0)
.s25:
1238 : 0a __ __ ASL
1239 : a8 __ __ TAY
123a : b9 65 42 LDA $4265,y ; (room_center_cache + 1)
123d : 85 1c __ STA ACCU + 1 
123f : be 64 42 LDX $4264,y ; (room_center_cache + 0)
1242 : 86 1b __ STX ACCU + 0 
1244 : 4c c7 12 JMP $12c7 ; (calculate_room_distance.s22 + 0)
.s23:
1247 : 85 43 __ STA T0 + 0 
1249 : cd e8 35 CMP $35e8 ; (room_count + 0)
124c : 90 06 __ BCC $1254 ; (calculate_room_distance.s30 + 0)
.s28:
124e : a9 00 __ LDA #$00
1250 : 85 44 __ STA T2 + 0 
1252 : b0 59 __ BCS $12ad ; (calculate_room_distance.s33 + 0)
.s30:
1254 : 85 1b __ STA ACCU + 0 
1256 : a9 00 __ LDA #$00
1258 : 85 1c __ STA ACCU + 1 
125a : a9 1d __ LDA #$1d
125c : 20 19 35 JSR $3519 ; (mul16by8 + 0)
125f : 18 __ __ CLC
1260 : a9 20 __ LDA #$20
1262 : 65 1b __ ADC ACCU + 0 
1264 : 85 1b __ STA ACCU + 0 
1266 : a9 40 __ LDA #$40
1268 : 65 1c __ ADC ACCU + 1 
126a : 85 1c __ STA ACCU + 1 
126c : a0 03 __ LDY #$03
126e : b1 1b __ LDA (ACCU + 0),y 
1270 : 38 __ __ SEC
1271 : e9 01 __ SBC #$01
1273 : a8 __ __ TAY
1274 : a9 00 __ LDA #$00
1276 : e9 00 __ SBC #$00
1278 : aa __ __ TAX
1279 : 0a __ __ ASL
127a : 98 __ __ TYA
127b : 69 00 __ ADC #$00
127d : 85 44 __ STA T2 + 0 
127f : 8a __ __ TXA
1280 : 69 00 __ ADC #$00
1282 : 4a __ __ LSR
1283 : 66 44 __ ROR T2 + 0 
1285 : a0 01 __ LDY #$01
1287 : b1 1b __ LDA (ACCU + 0),y 
1289 : 18 __ __ CLC
128a : 65 44 __ ADC T2 + 0 
128c : 85 44 __ STA T2 + 0 
128e : c8 __ __ INY
128f : b1 1b __ LDA (ACCU + 0),y 
1291 : 38 __ __ SEC
1292 : e9 01 __ SBC #$01
1294 : a8 __ __ TAY
1295 : a9 00 __ LDA #$00
1297 : e9 00 __ SBC #$00
1299 : aa __ __ TAX
129a : 0a __ __ ASL
129b : 98 __ __ TYA
129c : 69 00 __ ADC #$00
129e : 85 45 __ STA T3 + 0 
12a0 : 8a __ __ TXA
12a1 : 69 00 __ ADC #$00
12a3 : 4a __ __ LSR
12a4 : 66 45 __ ROR T3 + 0 
12a6 : a0 00 __ LDY #$00
12a8 : b1 1b __ LDA (ACCU + 0),y 
12aa : 18 __ __ CLC
12ab : 65 45 __ ADC T3 + 0 
.s33:
12ad : 85 1b __ STA ACCU + 0 
12af : aa __ __ TAX
12b0 : a5 44 __ LDA T2 + 0 
12b2 : 85 1c __ STA ACCU + 1 
12b4 : a5 0e __ LDA P1 ; (room2 + 0)
12b6 : c9 14 __ CMP #$14
12b8 : b0 0d __ BCS $12c7 ; (calculate_room_distance.s22 + 0)
.s39:
12ba : 06 43 __ ASL T0 + 0 
12bc : 8a __ __ TXA
12bd : a4 43 __ LDY T0 + 0 
12bf : 99 64 42 STA $4264,y ; (room_center_cache + 0)
12c2 : a5 44 __ LDA T2 + 0 
12c4 : 99 65 42 STA $4265,y ; (room_center_cache + 1)
.s22:
12c7 : 8a __ __ TXA
12c8 : e4 46 __ CPX T6 + 0 
12ca : 90 05 __ BCC $12d1 ; (calculate_room_distance.s50 + 0)
.s51:
12cc : e5 46 __ SBC T6 + 0 
12ce : 4c d6 12 JMP $12d6 ; (calculate_room_distance.s52 + 0)
.s50:
12d1 : 38 __ __ SEC
12d2 : a5 46 __ LDA T6 + 0 
12d4 : e5 1b __ SBC ACCU + 0 
.s52:
12d6 : 85 43 __ STA T0 + 0 
12d8 : a5 1c __ LDA ACCU + 1 
12da : c5 47 __ CMP T7 + 0 
12dc : 90 05 __ BCC $12e3 ; (calculate_room_distance.s53 + 0)
.s54:
12de : e5 47 __ SBC T7 + 0 
12e0 : 4c e8 12 JMP $12e8 ; (calculate_room_distance.s55 + 0)
.s53:
12e3 : 38 __ __ SEC
12e4 : a5 47 __ LDA T7 + 0 
12e6 : e5 1c __ SBC ACCU + 1 
.s55:
12e8 : 18 __ __ CLC
12e9 : 65 43 __ ADC T0 + 0 
.s1001:
12eb : 60 __ __ RTS
--------------------------------------------------------------------
connect_rooms_directly: ; connect_rooms_directly(u8,u8)->u8
.s1000:
12ec : a2 03 __ LDX #$03
12ee : b5 53 __ LDA T5 + 0,x 
12f0 : 9d e9 9f STA $9fe9,x ; (grid_positions + 4)
12f3 : ca __ __ DEX
12f4 : 10 f8 __ BPL $12ee ; (connect_rooms_directly.s1000 + 2)
.s0:
12f6 : ad fe 9f LDA $9ffe ; (sstack + 7)
12f9 : 85 53 __ STA T5 + 0 
12fb : 85 0d __ STA P0 
12fd : ad ff 9f LDA $9fff ; (sstack + 8)
1300 : 85 54 __ STA T6 + 0 
1302 : 85 0e __ STA P1 
1304 : 20 1d 15 JSR $151d ; (rooms_are_connected.s0 + 0)
1307 : aa __ __ TAX
1308 : f0 0f __ BEQ $1319 ; (connect_rooms_directly.s3 + 0)
.s1002:
130a : a9 01 __ LDA #$01
.s1001:
130c : 85 1b __ STA ACCU + 0 
130e : a2 03 __ LDX #$03
1310 : bd e9 9f LDA $9fe9,x ; (grid_positions + 4)
1313 : 95 53 __ STA T5 + 0,x 
1315 : ca __ __ DEX
1316 : 10 f8 __ BPL $1310 ; (connect_rooms_directly.s1001 + 4)
1318 : 60 __ __ RTS
.s3:
1319 : a5 53 __ LDA T5 + 0 
131b : 85 11 __ STA P4 
131d : a5 54 __ LDA T6 + 0 
131f : 85 12 __ STA P5 
1321 : 20 5f 15 JSR $155f ; (can_connect_rooms_safely.s0 + 0)
1324 : a5 1b __ LDA ACCU + 0 
1326 : f0 e4 __ BEQ $130c ; (connect_rooms_directly.s1001 + 0)
.s7:
1328 : a5 12 __ LDA P5 
132a : 85 1b __ STA ACCU + 0 
132c : a9 00 __ LDA #$00
132e : 85 1c __ STA ACCU + 1 
1330 : a9 1d __ LDA #$1d
1332 : 20 19 35 JSR $3519 ; (mul16by8 + 0)
1335 : 18 __ __ CLC
1336 : a9 20 __ LDA #$20
1338 : 65 1b __ ADC ACCU + 0 
133a : 85 4d __ STA T0 + 0 
133c : a9 40 __ LDA #$40
133e : 65 1c __ ADC ACCU + 1 
1340 : 85 4e __ STA T0 + 1 
1342 : a0 02 __ LDY #$02
1344 : b1 4d __ LDA (T0 + 0),y 
1346 : 4a __ __ LSR
1347 : a0 00 __ LDY #$00
1349 : 84 1c __ STY ACCU + 1 
134b : 18 __ __ CLC
134c : 71 4d __ ADC (T0 + 0),y 
134e : 85 0e __ STA P1 
1350 : a0 03 __ LDY #$03
1352 : b1 4d __ LDA (T0 + 0),y 
1354 : 4a __ __ LSR
1355 : 18 __ __ CLC
1356 : a0 01 __ LDY #$01
1358 : 71 4d __ ADC (T0 + 0),y 
135a : 85 0f __ STA P2 
135c : a5 11 __ LDA P4 
135e : 85 0d __ STA P0 
1360 : 85 1b __ STA ACCU + 0 
1362 : a9 f6 __ LDA #$f6
1364 : 85 10 __ STA P3 
1366 : a9 9f __ LDA #$9f
1368 : 85 11 __ STA P4 
136a : a9 f5 __ LDA #$f5
136c : 85 12 __ STA P5 
136e : a9 9f __ LDA #$9f
1370 : 85 13 __ STA P6 
1372 : a9 1d __ LDA #$1d
1374 : 20 19 35 JSR $3519 ; (mul16by8 + 0)
1377 : a9 20 __ LDA #$20
1379 : 85 4d __ STA T0 + 0 
137b : 18 __ __ CLC
137c : a9 40 __ LDA #$40
137e : 65 1c __ ADC ACCU + 1 
1380 : 85 4e __ STA T0 + 1 
1382 : a4 1b __ LDY ACCU + 0 
1384 : b1 4d __ LDA (T0 + 0),y 
1386 : 85 4f __ STA T1 + 0 
1388 : c8 __ __ INY
1389 : b1 4d __ LDA (T0 + 0),y 
138b : 85 52 __ STA T4 + 0 
138d : c8 __ __ INY
138e : b1 4d __ LDA (T0 + 0),y 
1390 : 85 55 __ STA T7 + 0 
1392 : c8 __ __ INY
1393 : b1 4d __ LDA (T0 + 0),y 
1395 : 4a __ __ LSR
1396 : 85 4d __ STA T0 + 0 
1398 : 20 93 15 JSR $1593 ; (calculate_exit_from_target.s0 + 0)
139b : a5 54 __ LDA T6 + 0 
139d : 85 0d __ STA P0 
139f : a5 55 __ LDA T7 + 0 
13a1 : 4a __ __ LSR
13a2 : 18 __ __ CLC
13a3 : 65 4f __ ADC T1 + 0 
13a5 : 85 0e __ STA P1 
13a7 : 18 __ __ CLC
13a8 : a5 52 __ LDA T4 + 0 
13aa : 65 4d __ ADC T0 + 0 
13ac : 85 0f __ STA P2 
13ae : a9 f4 __ LDA #$f4
13b0 : 85 10 __ STA P3 
13b2 : a9 9f __ LDA #$9f
13b4 : 85 13 __ STA P6 
13b6 : a9 9f __ LDA #$9f
13b8 : 85 11 __ STA P4 
13ba : a9 f3 __ LDA #$f3
13bc : 85 12 __ STA P5 
13be : 20 93 15 JSR $1593 ; (calculate_exit_from_target.s0 + 0)
13c1 : a5 53 __ LDA T5 + 0 
13c3 : 85 0d __ STA P0 
13c5 : a5 54 __ LDA T6 + 0 
13c7 : 85 0e __ STA P1 
13c9 : a9 f2 __ LDA #$f2
13cb : 85 0f __ STA P2 
13cd : a9 9f __ LDA #$9f
13cf : 85 12 __ STA P5 
13d1 : a9 9f __ LDA #$9f
13d3 : 85 10 __ STA P3 
13d5 : a9 f1 __ LDA #$f1
13d7 : 85 11 __ STA P4 
13d9 : 20 41 16 JSR $1641 ; (check_room_alignment.s0 + 0)
13dc : ad f2 9f LDA $9ff2 ; (grid_positions + 13)
13df : 85 55 __ STA T7 + 0 
13e1 : f0 03 __ BEQ $13e6 ; (connect_rooms_directly.s12 + 0)
13e3 : 4c e1 14 JMP $14e1 ; (connect_rooms_directly.s9 + 0)
.s12:
13e6 : ad f1 9f LDA $9ff1 ; (grid_positions + 12)
13e9 : d0 f8 __ BNE $13e3 ; (connect_rooms_directly.s7 + 187)
.s10:
13eb : a9 64 __ LDA #$64
13ed : 20 10 0c JSR $0c10 ; (rnd.s0 + 0)
13f0 : c9 32 __ CMP #$32
13f2 : b0 2b __ BCS $141f ; (connect_rooms_directly.s14 + 0)
.s16:
13f4 : a5 53 __ LDA T5 + 0 
13f6 : 85 0d __ STA P0 
13f8 : a9 f6 __ LDA #$f6
13fa : 85 0f __ STA P2 
13fc : a9 9f __ LDA #$9f
13fe : 85 16 __ STA P9 
1400 : a9 9f __ LDA #$9f
1402 : 85 10 __ STA P3 
1404 : a9 f5 __ LDA #$f5
1406 : 85 11 __ STA P4 
1408 : a9 9f __ LDA #$9f
140a : 85 12 __ STA P5 
140c : a9 f4 __ LDA #$f4
140e : 85 13 __ STA P6 
1410 : a9 9f __ LDA #$9f
1412 : 85 14 __ STA P7 
1414 : a9 f3 __ LDA #$f3
1416 : 85 15 __ STA P8 
1418 : 20 27 18 JSR $1827 ; (calculate_l_exits.s0 + 0)
141b : a9 01 __ LDA #$01
141d : d0 02 __ BNE $1421 ; (connect_rooms_directly.s11 + 0)
.s14:
141f : a9 02 __ LDA #$02
.s11:
1421 : 85 13 __ STA P6 
1423 : a5 53 __ LDA T5 + 0 
1425 : 85 11 __ STA P4 
1427 : a5 0e __ LDA P1 
1429 : 85 12 __ STA P5 
142b : ad f6 9f LDA $9ff6 ; (add_walls@stack + 14)
142e : 85 50 __ STA T2 + 0 
1430 : 85 0d __ STA P0 
1432 : ad f5 9f LDA $9ff5 ; (add_walls@stack + 13)
1435 : 85 51 __ STA T3 + 0 
1437 : 85 0e __ STA P1 
1439 : ad f4 9f LDA $9ff4 ; (grid_positions + 15)
143c : 85 52 __ STA T4 + 0 
143e : 85 0f __ STA P2 
1440 : ad f3 9f LDA $9ff3 ; (grid_positions + 14)
1443 : 85 55 __ STA T7 + 0 
1445 : 85 10 __ STA P3 
1447 : 20 52 19 JSR $1952 ; (path_is_safe.s0 + 0)
144a : aa __ __ TAX
144b : d0 03 __ BNE $1450 ; (connect_rooms_directly.s21 + 0)
144d : 4c 0c 13 JMP $130c ; (connect_rooms_directly.s1001 + 0)
.s21:
1450 : a5 11 __ LDA P4 
1452 : 85 0d __ STA P0 
1454 : a5 50 __ LDA T2 + 0 
1456 : 85 0e __ STA P1 
1458 : a5 51 __ LDA T3 + 0 
145a : 85 0f __ STA P2 
145c : 20 01 1a JSR $1a01 ; (get_wall_side_from_exit.s0 + 0)
145f : 85 4d __ STA T0 + 0 
1461 : a5 54 __ LDA T6 + 0 
1463 : 85 0d __ STA P0 
1465 : a5 52 __ LDA T4 + 0 
1467 : 85 0e __ STA P1 
1469 : a5 55 __ LDA T7 + 0 
146b : 85 0f __ STA P2 
146d : 20 01 1a JSR $1a01 ; (get_wall_side_from_exit.s0 + 0)
1470 : 85 56 __ STA T8 + 0 
1472 : a5 50 __ LDA T2 + 0 
1474 : 8d f8 9f STA $9ff8 ; (sstack + 1)
1477 : a5 51 __ LDA T3 + 0 
1479 : 8d f9 9f STA $9ff9 ; (sstack + 2)
147c : a5 4d __ LDA T0 + 0 
147e : 8d fa 9f STA $9ffa ; (sstack + 3)
1481 : a5 52 __ LDA T4 + 0 
1483 : 8d fb 9f STA $9ffb ; (sstack + 4)
1486 : a5 55 __ LDA T7 + 0 
1488 : 8d fc 9f STA $9ffc ; (sstack + 5)
148b : a5 13 __ LDA P6 
148d : 8d fd 9f STA $9ffd ; (sstack + 6)
1490 : 20 42 1a JSR $1a42 ; (draw_corridor_from_door.s0 + 0)
1493 : a5 50 __ LDA T2 + 0 
1495 : 85 10 __ STA P3 
1497 : a5 51 __ LDA T3 + 0 
1499 : 85 11 __ STA P4 
149b : 20 fd 1c JSR $1cfd ; (place_door.s0 + 0)
149e : a5 52 __ LDA T4 + 0 
14a0 : 85 10 __ STA P3 
14a2 : a5 55 __ LDA T7 + 0 
14a4 : 85 11 __ STA P4 
14a6 : 20 fd 1c JSR $1cfd ; (place_door.s0 + 0)
14a9 : a5 53 __ LDA T5 + 0 
14ab : 85 0d __ STA P0 
14ad : a5 54 __ LDA T6 + 0 
14af : 85 0e __ STA P1 
14b1 : 20 9c 1d JSR $1d9c ; (add_room_connection.s0 + 0)
14b4 : a5 50 __ LDA T2 + 0 
14b6 : 85 0e __ STA P1 
14b8 : a5 51 __ LDA T3 + 0 
14ba : 85 0f __ STA P2 
14bc : a5 4d __ LDA T0 + 0 
14be : 85 10 __ STA P3 
14c0 : a5 54 __ LDA T6 + 0 
14c2 : 85 11 __ STA P4 
14c4 : 20 ff 1d JSR $1dff ; (add_door_to_room.s0 + 0)
14c7 : a5 11 __ LDA P4 
14c9 : 85 0d __ STA P0 
14cb : a5 52 __ LDA T4 + 0 
14cd : 85 0e __ STA P1 
14cf : a5 55 __ LDA T7 + 0 
14d1 : 85 0f __ STA P2 
14d3 : a5 56 __ LDA T8 + 0 
14d5 : 85 10 __ STA P3 
14d7 : a5 53 __ LDA T5 + 0 
14d9 : 85 11 __ STA P4 
14db : 20 ff 1d JSR $1dff ; (add_door_to_room.s0 + 0)
14de : 4c 0a 13 JMP $130a ; (connect_rooms_directly.s1002 + 0)
.s9:
14e1 : a9 64 __ LDA #$64
14e3 : 20 10 0c JSR $0c10 ; (rnd.s0 + 0)
14e6 : c9 46 __ CMP #$46
14e8 : 90 03 __ BCC $14ed ; (connect_rooms_directly.s13 + 0)
14ea : 4c 1f 14 JMP $141f ; (connect_rooms_directly.s14 + 0)
.s13:
14ed : a5 53 __ LDA T5 + 0 
14ef : 85 0d __ STA P0 
14f1 : a5 55 __ LDA T7 + 0 
14f3 : 85 0f __ STA P2 
14f5 : a9 f6 __ LDA #$f6
14f7 : 85 10 __ STA P3 
14f9 : a9 9f __ LDA #$9f
14fb : 85 17 __ STA P10 
14fd : a9 9f __ LDA #$9f
14ff : 85 11 __ STA P4 
1501 : a9 f5 __ LDA #$f5
1503 : 85 12 __ STA P5 
1505 : a9 9f __ LDA #$9f
1507 : 85 13 __ STA P6 
1509 : a9 f4 __ LDA #$f4
150b : 85 14 __ STA P7 
150d : a9 9f __ LDA #$9f
150f : 85 15 __ STA P8 
1511 : a9 f3 __ LDA #$f3
1513 : 85 16 __ STA P9 
1515 : 20 e9 16 JSR $16e9 ; (calculate_straight_exits.s0 + 0)
1518 : a9 00 __ LDA #$00
151a : 4c 21 14 JMP $1421 ; (connect_rooms_directly.s11 + 0)
--------------------------------------------------------------------
rooms_are_connected: ; rooms_are_connected(u8,u8)->u8
.s0:
151d : a5 0d __ LDA P0 ; (room1 + 0)
151f : 85 1b __ STA ACCU + 0 
1521 : a9 00 __ LDA #$00
1523 : 85 1c __ STA ACCU + 1 
1525 : a9 1d __ LDA #$1d
1527 : 20 19 35 JSR $3519 ; (mul16by8 + 0)
152a : 18 __ __ CLC
152b : a9 20 __ LDA #$20
152d : 65 1b __ ADC ACCU + 0 
152f : 85 1b __ STA ACCU + 0 
1531 : a9 40 __ LDA #$40
1533 : 65 1c __ ADC ACCU + 1 
1535 : 85 1c __ STA ACCU + 1 
1537 : a0 04 __ LDY #$04
1539 : b1 1b __ LDA (ACCU + 0),y 
153b : 85 1d __ STA ACCU + 2 
153d : a2 00 __ LDX #$00
153f : f0 01 __ BEQ $1542 ; (rooms_are_connected.l1 + 0)
.s3:
1541 : e8 __ __ INX
.l1:
1542 : 8a __ __ TXA
1543 : e4 1d __ CPX ACCU + 2 
1545 : b0 15 __ BCS $155c ; (rooms_are_connected.s4 + 0)
.s2:
1547 : 65 1b __ ADC ACCU + 0 
1549 : 85 43 __ STA T1 + 0 
154b : a5 1c __ LDA ACCU + 1 
154d : 69 00 __ ADC #$00
154f : 85 44 __ STA T1 + 1 
1551 : a5 0e __ LDA P1 ; (room2 + 0)
1553 : a0 08 __ LDY #$08
1555 : d1 43 __ CMP (T1 + 0),y 
1557 : d0 e8 __ BNE $1541 ; (rooms_are_connected.s3 + 0)
.s5:
1559 : a9 01 __ LDA #$01
.s1001:
155b : 60 __ __ RTS
.s4:
155c : a9 00 __ LDA #$00
155e : 60 __ __ RTS
--------------------------------------------------------------------
can_connect_rooms_safely: ; can_connect_rooms_safely(u8,u8)->u8
.s0:
155f : a5 11 __ LDA P4 ; (room1 + 0)
1561 : cd e8 35 CMP $35e8 ; (room_count + 0)
1564 : b0 0d __ BCS $1573 ; (can_connect_rooms_safely.s1 + 0)
.s5:
1566 : a5 12 __ LDA P5 ; (room2 + 0)
1568 : cd e8 35 CMP $35e8 ; (room_count + 0)
156b : b0 06 __ BCS $1573 ; (can_connect_rooms_safely.s1 + 0)
.s4:
156d : a5 11 __ LDA P4 ; (room1 + 0)
156f : c5 12 __ CMP P5 ; (room2 + 0)
1571 : d0 05 __ BNE $1578 ; (can_connect_rooms_safely.s3 + 0)
.s1:
1573 : a9 00 __ LDA #$00
.s1001:
1575 : 85 1b __ STA ACCU + 0 
1577 : 60 __ __ RTS
.s3:
1578 : 85 0f __ STA P2 
157a : a5 12 __ LDA P5 ; (room2 + 0)
157c : 85 10 __ STA P3 
157e : 20 1f 11 JSR $111f ; (get_cached_room_distance.s0 + 0)
1581 : a9 08 __ LDA #$08
1583 : cd e8 35 CMP $35e8 ; (room_count + 0)
1586 : a9 50 __ LDA #$50
1588 : b0 02 __ BCS $158c ; (can_connect_rooms_safely.s1005 + 0)
.s9:
158a : a9 1e __ LDA #$1e
.s1005:
158c : c5 1b __ CMP ACCU + 0 
158e : a9 00 __ LDA #$00
1590 : 2a __ __ ROL
1591 : 90 e2 __ BCC $1575 ; (can_connect_rooms_safely.s1001 + 0)
--------------------------------------------------------------------
calculate_exit_from_target: ; calculate_exit_from_target(u8,u8,u8,u8*,u8*)->void
.s0:
1593 : a5 0d __ LDA P0 ; (room_idx + 0)
1595 : 85 1b __ STA ACCU + 0 
1597 : a9 00 __ LDA #$00
1599 : 85 1c __ STA ACCU + 1 
159b : a9 1d __ LDA #$1d
159d : 20 19 35 JSR $3519 ; (mul16by8 + 0)
15a0 : 18 __ __ CLC
15a1 : a9 20 __ LDA #$20
15a3 : 65 1b __ ADC ACCU + 0 
15a5 : 85 43 __ STA T1 + 0 
15a7 : a9 40 __ LDA #$40
15a9 : 65 1c __ ADC ACCU + 1 
15ab : 85 44 __ STA T1 + 1 
15ad : a0 02 __ LDY #$02
15af : b1 43 __ LDA (T1 + 0),y 
15b1 : 85 1c __ STA ACCU + 1 
15b3 : 4a __ __ LSR
15b4 : 85 1b __ STA ACCU + 0 
15b6 : a0 00 __ LDY #$00
15b8 : b1 43 __ LDA (T1 + 0),y 
15ba : aa __ __ TAX
15bb : 18 __ __ CLC
15bc : 65 1b __ ADC ACCU + 0 
15be : 85 1d __ STA ACCU + 2 
15c0 : c5 0e __ CMP P1 ; (target_x + 0)
15c2 : 98 __ __ TYA
15c3 : 2a __ __ ROL
15c4 : 49 01 __ EOR #$01
15c6 : 85 45 __ STA T9 + 0 
15c8 : d0 08 __ BNE $15d2 ; (calculate_exit_from_target.s14 + 0)
.s15:
15ca : 38 __ __ SEC
15cb : a5 1d __ LDA ACCU + 2 
15cd : e5 0e __ SBC P1 ; (target_x + 0)
15cf : 4c d7 15 JMP $15d7 ; (calculate_exit_from_target.s16 + 0)
.s14:
15d2 : 38 __ __ SEC
15d3 : a5 0e __ LDA P1 ; (target_x + 0)
15d5 : e5 1d __ SBC ACCU + 2 
.s16:
15d7 : 85 1b __ STA ACCU + 0 
15d9 : a0 03 __ LDY #$03
15db : b1 43 __ LDA (T1 + 0),y 
15dd : 4a __ __ LSR
15de : 18 __ __ CLC
15df : a0 01 __ LDY #$01
15e1 : 71 43 __ ADC (T1 + 0),y 
15e3 : 85 1e __ STA ACCU + 3 
15e5 : c5 0f __ CMP P2 ; (target_y + 0)
15e7 : a9 00 __ LDA #$00
15e9 : 2a __ __ ROL
15ea : 49 01 __ EOR #$01
15ec : 85 46 __ STA T10 + 0 
15ee : d0 08 __ BNE $15f8 ; (calculate_exit_from_target.s17 + 0)
.s18:
15f0 : 38 __ __ SEC
15f1 : a5 1e __ LDA ACCU + 3 
15f3 : e5 0f __ SBC P2 ; (target_y + 0)
15f5 : 4c fd 15 JMP $15fd ; (calculate_exit_from_target.s19 + 0)
.s17:
15f8 : 38 __ __ SEC
15f9 : a5 0f __ LDA P2 ; (target_y + 0)
15fb : e5 1e __ SBC ACCU + 3 
.s19:
15fd : c5 1b __ CMP ACCU + 0 
15ff : 90 22 __ BCC $1623 ; (calculate_exit_from_target.s5 + 0)
.s6:
1601 : a5 1d __ LDA ACCU + 2 
1603 : a0 00 __ LDY #$00
1605 : 91 10 __ STA (P3),y ; (door_x + 0)
1607 : c8 __ __ INY
1608 : b1 43 __ LDA (T1 + 0),y 
160a : 85 1b __ STA ACCU + 0 
160c : a5 46 __ LDA T10 + 0 
160e : d0 04 __ BNE $1614 ; (calculate_exit_from_target.s11 + 0)
.s12:
1610 : a5 1b __ LDA ACCU + 0 
1612 : b0 0a __ BCS $161e ; (calculate_exit_from_target.s1008 + 0)
.s11:
1614 : a0 03 __ LDY #$03
1616 : b1 43 __ LDA (T1 + 0),y 
1618 : 18 __ __ CLC
1619 : 65 1b __ ADC ACCU + 0 
161b : 38 __ __ SEC
161c : e9 01 __ SBC #$01
.s1008:
161e : a0 00 __ LDY #$00
1620 : 91 12 __ STA (P5),y ; (door_y + 0)
.s1001:
1622 : 60 __ __ RTS
.s5:
1623 : a5 45 __ LDA T9 + 0 
1625 : d0 03 __ BNE $162a ; (calculate_exit_from_target.s8 + 0)
.s9:
1627 : 8a __ __ TXA
1628 : 90 06 __ BCC $1630 ; (calculate_exit_from_target.s25 + 0)
.s8:
162a : 8a __ __ TXA
162b : 65 1c __ ADC ACCU + 1 
162d : 38 __ __ SEC
162e : e9 01 __ SBC #$01
.s25:
1630 : a0 00 __ LDY #$00
1632 : 91 10 __ STA (P3),y ; (door_x + 0)
1634 : a0 03 __ LDY #$03
1636 : b1 43 __ LDA (T1 + 0),y 
1638 : 4a __ __ LSR
1639 : 18 __ __ CLC
163a : a0 01 __ LDY #$01
163c : 71 43 __ ADC (T1 + 0),y 
163e : 4c 1e 16 JMP $161e ; (calculate_exit_from_target.s1008 + 0)
--------------------------------------------------------------------
check_room_alignment: ; check_room_alignment(u8,u8,u8*,u8*)->void
.s0:
1641 : a5 0d __ LDA P0 ; (room1 + 0)
1643 : 85 1b __ STA ACCU + 0 
1645 : a9 00 __ LDA #$00
1647 : 85 1c __ STA ACCU + 1 
1649 : a9 1d __ LDA #$1d
164b : 20 19 35 JSR $3519 ; (mul16by8 + 0)
164e : 18 __ __ CLC
164f : a9 20 __ LDA #$20
1651 : 65 1b __ ADC ACCU + 0 
1653 : 85 43 __ STA T0 + 0 
1655 : a9 40 __ LDA #$40
1657 : 65 1c __ ADC ACCU + 1 
1659 : 85 44 __ STA T0 + 1 
165b : a0 01 __ LDY #$01
165d : b1 43 __ LDA (T0 + 0),y 
165f : 85 45 __ STA T1 + 0 
1661 : 18 __ __ CLC
1662 : a0 03 __ LDY #$03
1664 : 71 43 __ ADC (T0 + 0),y 
1666 : 85 46 __ STA T2 + 0 
1668 : a9 00 __ LDA #$00
166a : 85 1c __ STA ACCU + 1 
166c : 2a __ __ ROL
166d : 85 47 __ STA T2 + 1 
166f : a5 0e __ LDA P1 ; (room2 + 0)
1671 : 85 1b __ STA ACCU + 0 
1673 : a9 1d __ LDA #$1d
1675 : 20 19 35 JSR $3519 ; (mul16by8 + 0)
1678 : 18 __ __ CLC
1679 : a9 20 __ LDA #$20
167b : 65 1b __ ADC ACCU + 0 
167d : 85 1b __ STA ACCU + 0 
167f : a9 40 __ LDA #$40
1681 : 65 1c __ ADC ACCU + 1 
1683 : 85 1c __ STA ACCU + 1 
1685 : a0 01 __ LDY #$01
1687 : b1 1b __ LDA (ACCU + 0),y 
1689 : 85 1d __ STA ACCU + 2 
168b : a5 47 __ LDA T2 + 1 
168d : d0 0a __ BNE $1699 ; (check_room_alignment.s4 + 0)
.s1011:
168f : a5 1d __ LDA ACCU + 2 
1691 : c5 46 __ CMP T2 + 0 
1693 : 90 04 __ BCC $1699 ; (check_room_alignment.s4 + 0)
.s2:
1695 : a9 00 __ LDA #$00
1697 : b0 18 __ BCS $16b1 ; (check_room_alignment.s1014 + 0)
.s4:
1699 : a0 03 __ LDY #$03
169b : b1 1b __ LDA (ACCU + 0),y 
169d : 18 __ __ CLC
169e : 65 1d __ ADC ACCU + 2 
16a0 : 90 04 __ BCC $16a6 ; (check_room_alignment.s1008 + 0)
.s1:
16a2 : a9 01 __ LDA #$01
16a4 : b0 0b __ BCS $16b1 ; (check_room_alignment.s1014 + 0)
.s1008:
16a6 : 85 46 __ STA T2 + 0 
16a8 : a5 45 __ LDA T1 + 0 
16aa : c5 46 __ CMP T2 + 0 
16ac : a9 00 __ LDA #$00
16ae : 2a __ __ ROL
16af : 49 01 __ EOR #$01
.s1014:
16b1 : a0 00 __ LDY #$00
16b3 : 91 0f __ STA (P2),y ; (has_horizontal_overlap + 0)
16b5 : a0 02 __ LDY #$02
16b7 : b1 43 __ LDA (T0 + 0),y 
16b9 : 85 45 __ STA T1 + 0 
16bb : a0 00 __ LDY #$00
16bd : b1 43 __ LDA (T0 + 0),y 
16bf : aa __ __ TAX
16c0 : 18 __ __ CLC
16c1 : 65 45 __ ADC T1 + 0 
16c3 : 85 45 __ STA T1 + 0 
16c5 : b1 1b __ LDA (ACCU + 0),y 
16c7 : b0 08 __ BCS $16d1 ; (check_room_alignment.s8 + 0)
.s1005:
16c9 : c5 45 __ CMP T1 + 0 
16cb : 90 04 __ BCC $16d1 ; (check_room_alignment.s8 + 0)
.s6:
16cd : 98 __ __ TYA
.s1001:
16ce : 91 11 __ STA (P4),y ; (has_vertical_overlap + 0)
16d0 : 60 __ __ RTS
.s8:
16d1 : 18 __ __ CLC
16d2 : a0 02 __ LDY #$02
16d4 : 71 1b __ ADC (ACCU + 0),y 
16d6 : 90 04 __ BCC $16dc ; (check_room_alignment.s1002 + 0)
.s5:
16d8 : a9 01 __ LDA #$01
16da : b0 09 __ BCS $16e5 ; (check_room_alignment.s1016 + 0)
.s1002:
16dc : 85 45 __ STA T1 + 0 
16de : e4 45 __ CPX T1 + 0 
16e0 : a9 00 __ LDA #$00
16e2 : 2a __ __ ROL
16e3 : 49 01 __ EOR #$01
.s1016:
16e5 : a0 00 __ LDY #$00
16e7 : f0 e5 __ BEQ $16ce ; (check_room_alignment.s1001 + 0)
--------------------------------------------------------------------
calculate_straight_exits: ; calculate_straight_exits(u8,u8,u8,u8*,u8*,u8*,u8*)->void
.s0:
16e9 : a5 0e __ LDA P1 ; (room2 + 0)
16eb : 85 1b __ STA ACCU + 0 
16ed : a9 00 __ LDA #$00
16ef : 85 1c __ STA ACCU + 1 
16f1 : a9 1d __ LDA #$1d
16f3 : 20 19 35 JSR $3519 ; (mul16by8 + 0)
16f6 : 18 __ __ CLC
16f7 : a9 20 __ LDA #$20
16f9 : 65 1b __ ADC ACCU + 0 
16fb : 85 47 __ STA T3 + 0 
16fd : a9 40 __ LDA #$40
16ff : 65 1c __ ADC ACCU + 1 
1701 : 85 48 __ STA T3 + 1 
1703 : a0 00 __ LDY #$00
1705 : 84 1c __ STY ACCU + 1 
1707 : b1 47 __ LDA (T3 + 0),y 
1709 : 85 4c __ STA T13 + 0 
170b : a5 0d __ LDA P0 ; (room1 + 0)
170d : 85 1b __ STA ACCU + 0 
170f : a9 1d __ LDA #$1d
1711 : 20 19 35 JSR $3519 ; (mul16by8 + 0)
1714 : a9 20 __ LDA #$20
1716 : 85 43 __ STA T0 + 0 
1718 : 18 __ __ CLC
1719 : a9 40 __ LDA #$40
171b : 65 1c __ ADC ACCU + 1 
171d : 85 44 __ STA T0 + 1 
171f : a4 1b __ LDY ACCU + 0 
1721 : b1 43 __ LDA (T0 + 0),y 
1723 : 85 4b __ STA T12 + 0 
1725 : c8 __ __ INY
1726 : 18 __ __ CLC
1727 : c8 __ __ INY
1728 : 71 43 __ ADC (T0 + 0),y 
172a : aa __ __ TAX
172b : a9 00 __ LDA #$00
172d : 2a __ __ ROL
172e : 85 1c __ STA ACCU + 1 
1730 : a0 01 __ LDY #$01
1732 : b1 47 __ LDA (T3 + 0),y 
1734 : 85 1e __ STA ACCU + 3 
1736 : a4 1b __ LDY ACCU + 0 
1738 : c8 __ __ INY
1739 : b1 43 __ LDA (T0 + 0),y 
173b : 85 1d __ STA ACCU + 2 
173d : c8 __ __ INY
173e : c8 __ __ INY
173f : 71 43 __ ADC (T0 + 0),y 
1741 : 85 45 __ STA T1 + 0 
1743 : a9 00 __ LDA #$00
1745 : 2a __ __ ROL
1746 : 85 46 __ STA T1 + 1 
1748 : a5 0f __ LDA P2 ; (horizontal_aligned + 0)
174a : d0 73 __ BNE $17bf ; (calculate_straight_exits.s1 + 0)
.s2:
174c : a0 02 __ LDY #$02
174e : b1 47 __ LDA (T3 + 0),y 
1750 : 65 4c __ ADC T13 + 0 
1752 : 85 49 __ STA T6 + 0 
1754 : a9 00 __ LDA #$00
1756 : 2a __ __ ROL
1757 : 85 4a __ STA T6 + 1 
1759 : a5 1c __ LDA ACCU + 1 
175b : c5 4a __ CMP T6 + 1 
175d : d0 02 __ BNE $1761 ; (calculate_straight_exits.s1006 + 0)
.s1005:
175f : e4 49 __ CPX T6 + 0 
.s1006:
1761 : b0 02 __ BCS $1765 ; (calculate_straight_exits.s18 + 0)
.s16:
1763 : 86 49 __ STX T6 + 0 
.s18:
1765 : a5 4c __ LDA T13 + 0 
1767 : c5 4b __ CMP T12 + 0 
1769 : b0 04 __ BCS $176f ; (calculate_straight_exits.s21 + 0)
.s19:
176b : a5 4b __ LDA T12 + 0 
176d : 85 4c __ STA T13 + 0 
.s21:
176f : a5 49 __ LDA T6 + 0 
1771 : 38 __ __ SEC
1772 : e5 4c __ SBC T13 + 0 
1774 : 6a __ __ ROR
1775 : 49 80 __ EOR #$80
1777 : 18 __ __ CLC
1778 : 65 4c __ ADC T13 + 0 
177a : a0 00 __ LDY #$00
177c : 91 10 __ STA (P3),y ; (exit1_x + 0)
177e : aa __ __ TAX
177f : a4 1b __ LDY ACCU + 0 
1781 : c8 __ __ INY
1782 : b1 43 __ LDA (T0 + 0),y 
1784 : 85 1b __ STA ACCU + 0 
1786 : a5 46 __ LDA T1 + 1 
1788 : d0 06 __ BNE $1790 ; (calculate_straight_exits.s8 + 0)
.s1002:
178a : a5 45 __ LDA T1 + 0 
178c : c5 1e __ CMP ACCU + 3 
178e : 90 17 __ BCC $17a7 ; (calculate_straight_exits.s7 + 0)
.s8:
1790 : a5 1b __ LDA ACCU + 0 
1792 : a0 00 __ LDY #$00
1794 : 91 12 __ STA (P5),y ; (exit1_y + 0)
1796 : 8a __ __ TXA
1797 : 91 14 __ STA (P7),y ; (exit2_x + 0)
1799 : c8 __ __ INY
179a : b1 47 __ LDA (T3 + 0),y 
179c : 18 __ __ CLC
179d : a0 03 __ LDY #$03
179f : 71 47 __ ADC (T3 + 0),y 
17a1 : 38 __ __ SEC
17a2 : e9 01 __ SBC #$01
17a4 : 4c ba 17 JMP $17ba ; (calculate_straight_exits.s1017 + 0)
.s7:
17a7 : c8 __ __ INY
17a8 : c8 __ __ INY
17a9 : b1 43 __ LDA (T0 + 0),y 
17ab : 65 1b __ ADC ACCU + 0 
17ad : 38 __ __ SEC
17ae : e9 01 __ SBC #$01
17b0 : a0 00 __ LDY #$00
17b2 : 91 12 __ STA (P5),y ; (exit1_y + 0)
17b4 : 8a __ __ TXA
17b5 : 91 14 __ STA (P7),y ; (exit2_x + 0)
17b7 : c8 __ __ INY
17b8 : b1 47 __ LDA (T3 + 0),y 
.s1017:
17ba : a0 00 __ LDY #$00
.s1014:
17bc : 91 16 __ STA (P9),y ; (exit2_y + 0)
.s1001:
17be : 60 __ __ RTS
.s1:
17bf : a0 03 __ LDY #$03
17c1 : b1 47 __ LDA (T3 + 0),y 
17c3 : 65 1e __ ADC ACCU + 3 
17c5 : 85 43 __ STA T0 + 0 
17c7 : a9 00 __ LDA #$00
17c9 : 2a __ __ ROL
17ca : 85 44 __ STA T0 + 1 
17cc : a5 46 __ LDA T1 + 1 
17ce : c5 44 __ CMP T0 + 1 
17d0 : d0 4f __ BNE $1821 ; (calculate_straight_exits.s1012 + 0)
.s1011:
17d2 : a5 45 __ LDA T1 + 0 
17d4 : c5 43 __ CMP T0 + 0 
17d6 : b0 02 __ BCS $17da ; (calculate_straight_exits.s12 + 0)
.s10:
17d8 : 85 43 __ STA T0 + 0 
.s12:
17da : a5 1e __ LDA ACCU + 3 
17dc : c5 1d __ CMP ACCU + 2 
17de : 90 02 __ BCC $17e2 ; (calculate_straight_exits.s15 + 0)
.s14:
17e0 : 85 1d __ STA ACCU + 2 
.s15:
17e2 : 38 __ __ SEC
17e3 : a5 43 __ LDA T0 + 0 
17e5 : e5 1d __ SBC ACCU + 2 
17e7 : 6a __ __ ROR
17e8 : 49 80 __ EOR #$80
17ea : 18 __ __ CLC
17eb : 65 1d __ ADC ACCU + 2 
17ed : 85 43 __ STA T0 + 0 
17ef : a5 1c __ LDA ACCU + 1 
17f1 : 38 __ __ SEC
17f2 : d0 02 __ BNE $17f6 ; (calculate_straight_exits.s1009 + 0)
.s1008:
17f4 : e4 4c __ CPX T13 + 0 
.s1009:
17f6 : a0 00 __ LDY #$00
17f8 : b0 0c __ BCS $1806 ; (calculate_straight_exits.s5 + 0)
.s4:
17fa : ca __ __ DEX
17fb : 8a __ __ TXA
17fc : 91 10 __ STA (P3),y ; (exit1_x + 0)
17fe : a5 43 __ LDA T0 + 0 
1800 : 91 12 __ STA (P5),y ; (exit1_y + 0)
1802 : b1 47 __ LDA (T3 + 0),y 
1804 : 90 14 __ BCC $181a ; (calculate_straight_exits.s27 + 0)
.s5:
1806 : a5 4b __ LDA T12 + 0 
1808 : 91 10 __ STA (P3),y ; (exit1_x + 0)
180a : a5 43 __ LDA T0 + 0 
180c : 91 12 __ STA (P5),y ; (exit1_y + 0)
180e : b1 47 __ LDA (T3 + 0),y 
1810 : 18 __ __ CLC
1811 : a0 02 __ LDY #$02
1813 : 71 47 __ ADC (T3 + 0),y 
1815 : 38 __ __ SEC
1816 : e9 01 __ SBC #$01
1818 : a0 00 __ LDY #$00
.s27:
181a : 91 14 __ STA (P7),y ; (exit2_x + 0)
181c : a5 43 __ LDA T0 + 0 
181e : 4c bc 17 JMP $17bc ; (calculate_straight_exits.s1014 + 0)
.s1012:
1821 : b0 b7 __ BCS $17da ; (calculate_straight_exits.s12 + 0)
.s1018:
1823 : a5 45 __ LDA T1 + 0 
1825 : 90 b1 __ BCC $17d8 ; (calculate_straight_exits.s10 + 0)
--------------------------------------------------------------------
calculate_l_exits: ; calculate_l_exits(u8,u8,u8*,u8*,u8*,u8*)->void
.s0:
1827 : a5 0e __ LDA P1 ; (room2 + 0)
1829 : 85 1b __ STA ACCU + 0 
182b : a9 00 __ LDA #$00
182d : 85 1c __ STA ACCU + 1 
182f : a9 1d __ LDA #$1d
1831 : 20 19 35 JSR $3519 ; (mul16by8 + 0)
1834 : 18 __ __ CLC
1835 : a9 20 __ LDA #$20
1837 : 65 1b __ ADC ACCU + 0 
1839 : 85 43 __ STA T3 + 0 
183b : a9 40 __ LDA #$40
183d : 65 1c __ ADC ACCU + 1 
183f : 85 44 __ STA T3 + 1 
1841 : a0 03 __ LDY #$03
1843 : b1 43 __ LDA (T3 + 0),y 
1845 : 4a __ __ LSR
1846 : 18 __ __ CLC
1847 : a0 01 __ LDY #$01
1849 : 71 43 __ ADC (T3 + 0),y 
184b : 85 45 __ STA T4 + 0 
184d : a5 0d __ LDA P0 ; (room1 + 0)
184f : 85 1b __ STA ACCU + 0 
1851 : a9 00 __ LDA #$00
1853 : 85 1c __ STA ACCU + 1 
1855 : a9 1d __ LDA #$1d
1857 : 20 19 35 JSR $3519 ; (mul16by8 + 0)
185a : 18 __ __ CLC
185b : a9 20 __ LDA #$20
185d : 65 1b __ ADC ACCU + 0 
185f : 85 1b __ STA ACCU + 0 
1861 : a9 40 __ LDA #$40
1863 : 65 1c __ ADC ACCU + 1 
1865 : 85 1c __ STA ACCU + 1 
1867 : a0 03 __ LDY #$03
1869 : b1 1b __ LDA (ACCU + 0),y 
186b : 4a __ __ LSR
186c : 18 __ __ CLC
186d : a0 01 __ LDY #$01
186f : 71 1b __ ADC (ACCU + 0),y 
1871 : 85 1d __ STA ACCU + 2 
1873 : c8 __ __ INY
1874 : b1 1b __ LDA (ACCU + 0),y 
1876 : 85 1e __ STA ACCU + 3 
1878 : 4a __ __ LSR
1879 : 85 46 __ STA T5 + 0 
187b : a0 00 __ LDY #$00
187d : b1 1b __ LDA (ACCU + 0),y 
187f : aa __ __ TAX
1880 : 18 __ __ CLC
1881 : 65 46 __ ADC T5 + 0 
1883 : 85 46 __ STA T5 + 0 
1885 : b1 43 __ LDA (T3 + 0),y 
1887 : 85 48 __ STA T8 + 0 
1889 : a0 02 __ LDY #$02
188b : b1 43 __ LDA (T3 + 0),y 
188d : 4a __ __ LSR
188e : 18 __ __ CLC
188f : 65 48 __ ADC T8 + 0 
1891 : 85 47 __ STA T7 + 0 
1893 : a5 46 __ LDA T5 + 0 
1895 : c5 47 __ CMP T7 + 0 
1897 : a9 00 __ LDA #$00
1899 : 2a __ __ ROL
189a : 49 01 __ EOR #$01
189c : 85 48 __ STA T8 + 0 
189e : f0 2f __ BEQ $18cf ; (calculate_l_exits.s2 + 0)
.s4:
18a0 : a5 1d __ LDA ACCU + 2 
18a2 : c5 45 __ CMP T4 + 0 
18a4 : b0 29 __ BCS $18cf ; (calculate_l_exits.s2 + 0)
.s1:
18a6 : 8a __ __ TXA
18a7 : 65 1e __ ADC ACCU + 3 
18a9 : 38 __ __ SEC
18aa : e9 01 __ SBC #$01
18ac : a0 00 __ LDY #$00
18ae : 91 0f __ STA (P2),y ; (exit1_x + 0)
18b0 : a0 03 __ LDY #$03
18b2 : b1 1b __ LDA (ACCU + 0),y 
18b4 : 4a __ __ LSR
18b5 : 18 __ __ CLC
18b6 : a0 01 __ LDY #$01
18b8 : 71 1b __ ADC (ACCU + 0),y 
18ba : 88 __ __ DEY
18bb : 91 11 __ STA (P4),y ; (exit1_y + 0)
18bd : a0 02 __ LDY #$02
18bf : b1 43 __ LDA (T3 + 0),y 
18c1 : 4a __ __ LSR
18c2 : 18 __ __ CLC
18c3 : a0 00 __ LDY #$00
18c5 : 71 43 __ ADC (T3 + 0),y 
18c7 : 91 13 __ STA (P6),y ; (exit2_x + 0)
18c9 : c8 __ __ INY
18ca : b1 43 __ LDA (T3 + 0),y 
18cc : 4c 4d 19 JMP $194d ; (calculate_l_exits.s3 + 0)
.s2:
18cf : a5 47 __ LDA T7 + 0 
18d1 : c5 46 __ CMP T5 + 0 
18d3 : b0 28 __ BCS $18fd ; (calculate_l_exits.s6 + 0)
.s8:
18d5 : a5 1d __ LDA ACCU + 2 
18d7 : c5 45 __ CMP T4 + 0 
18d9 : b0 22 __ BCS $18fd ; (calculate_l_exits.s6 + 0)
.s5:
18db : a5 46 __ LDA T5 + 0 
18dd : a0 00 __ LDY #$00
18df : 91 0f __ STA (P2),y ; (exit1_x + 0)
18e1 : c8 __ __ INY
18e2 : b1 1b __ LDA (ACCU + 0),y 
18e4 : a0 03 __ LDY #$03
18e6 : 71 1b __ ADC (ACCU + 0),y 
18e8 : 38 __ __ SEC
18e9 : e9 01 __ SBC #$01
18eb : a0 00 __ LDY #$00
18ed : 91 11 __ STA (P4),y ; (exit1_y + 0)
18ef : b1 43 __ LDA (T3 + 0),y 
18f1 : 18 __ __ CLC
18f2 : a0 02 __ LDY #$02
18f4 : 71 43 __ ADC (T3 + 0),y 
18f6 : 38 __ __ SEC
18f7 : e9 01 __ SBC #$01
18f9 : a0 00 __ LDY #$00
18fb : f0 44 __ BEQ $1941 ; (calculate_l_exits.s14 + 0)
.s6:
18fd : a5 48 __ LDA T8 + 0 
18ff : f0 06 __ BEQ $1907 ; (calculate_l_exits.s10 + 0)
.s12:
1901 : a5 45 __ LDA T4 + 0 
1903 : c5 1d __ CMP ACCU + 2 
1905 : 90 2c __ BCC $1933 ; (calculate_l_exits.s9 + 0)
.s10:
1907 : 8a __ __ TXA
1908 : a0 00 __ LDY #$00
190a : 91 0f __ STA (P2),y ; (exit1_x + 0)
190c : a0 03 __ LDY #$03
190e : b1 1b __ LDA (ACCU + 0),y 
1910 : 4a __ __ LSR
1911 : 18 __ __ CLC
1912 : a0 01 __ LDY #$01
1914 : 71 1b __ ADC (ACCU + 0),y 
1916 : 88 __ __ DEY
1917 : 91 11 __ STA (P4),y ; (exit1_y + 0)
1919 : a0 02 __ LDY #$02
191b : b1 43 __ LDA (T3 + 0),y 
191d : 4a __ __ LSR
191e : 18 __ __ CLC
191f : a0 00 __ LDY #$00
1921 : 71 43 __ ADC (T3 + 0),y 
1923 : 91 13 __ STA (P6),y ; (exit2_x + 0)
1925 : c8 __ __ INY
1926 : b1 43 __ LDA (T3 + 0),y 
1928 : 18 __ __ CLC
1929 : a0 03 __ LDY #$03
192b : 71 43 __ ADC (T3 + 0),y 
192d : 38 __ __ SEC
192e : e9 01 __ SBC #$01
1930 : 4c 4d 19 JMP $194d ; (calculate_l_exits.s3 + 0)
.s9:
1933 : a5 46 __ LDA T5 + 0 
1935 : a0 00 __ LDY #$00
1937 : 91 0f __ STA (P2),y ; (exit1_x + 0)
1939 : c8 __ __ INY
193a : b1 1b __ LDA (ACCU + 0),y 
193c : 88 __ __ DEY
193d : 91 11 __ STA (P4),y ; (exit1_y + 0)
193f : b1 43 __ LDA (T3 + 0),y 
.s14:
1941 : 91 13 __ STA (P6),y ; (exit2_x + 0)
1943 : a0 03 __ LDY #$03
1945 : b1 43 __ LDA (T3 + 0),y 
1947 : 4a __ __ LSR
1948 : 18 __ __ CLC
1949 : a0 01 __ LDY #$01
194b : 71 43 __ ADC (T3 + 0),y 
.s3:
194d : a0 00 __ LDY #$00
194f : 91 15 __ STA (P8),y ; (exit2_y + 0)
.s1001:
1951 : 60 __ __ RTS
--------------------------------------------------------------------
path_is_safe: ; path_is_safe(u8,u8,u8,u8,u8,u8,u8)->u8
.s0:
1952 : ad e8 35 LDA $35e8 ; (room_count + 0)
1955 : d0 03 __ BNE $195a ; (path_is_safe.s21 + 0)
1957 : 4c fe 19 JMP $19fe ; (path_is_safe.s4 + 0)
.s21:
195a : 85 45 __ STA T3 + 0 
195c : a9 00 __ LDA #$00
195e : 85 46 __ STA T4 + 0 
1960 : c5 11 __ CMP P4 ; (source_room + 0)
1962 : d0 03 __ BNE $1967 ; (path_is_safe.s8 + 0)
1964 : 4c ef 19 JMP $19ef ; (path_is_safe.l3 + 0)
.s8:
1967 : c5 12 __ CMP P5 ; (dest_room + 0)
1969 : f0 f9 __ BEQ $1964 ; (path_is_safe.s21 + 10)
.s7:
196b : 85 1b __ STA ACCU + 0 
196d : a9 00 __ LDA #$00
196f : 85 1c __ STA ACCU + 1 
1971 : a9 1d __ LDA #$1d
1973 : 20 19 35 JSR $3519 ; (mul16by8 + 0)
1976 : a9 20 __ LDA #$20
1978 : 85 43 __ STA T0 + 0 
197a : 18 __ __ CLC
197b : a9 40 __ LDA #$40
197d : 65 1c __ ADC ACCU + 1 
197f : 85 44 __ STA T0 + 1 
1981 : a4 1b __ LDY ACCU + 0 
1983 : b1 43 __ LDA (T0 + 0),y 
1985 : 85 1b __ STA ACCU + 0 
1987 : c9 02 __ CMP #$02
1989 : 90 06 __ BCC $1991 ; (path_is_safe.s34 + 0)
.s33:
198b : 85 1c __ STA ACCU + 1 
198d : c6 1c __ DEC ACCU + 1 
198f : b0 04 __ BCS $1995 ; (path_is_safe.s35 + 0)
.s34:
1991 : a9 00 __ LDA #$00
1993 : 85 1c __ STA ACCU + 1 
.s35:
1995 : a5 0f __ LDA P2 ; (end_x + 0)
1997 : c5 0d __ CMP P0 ; (start_x + 0)
1999 : a6 0d __ LDX P0 ; (start_x + 0)
199b : 86 47 __ STX T6 + 0 
199d : b0 01 __ BCS $19a0 ; (path_is_safe.s1002 + 0)
.s36:
199f : 8a __ __ TXA
.s1002:
19a0 : c5 1c __ CMP ACCU + 1 
19a2 : 90 4b __ BCC $19ef ; (path_is_safe.l3 + 0)
.s15:
19a4 : e4 0f __ CPX P2 ; (end_x + 0)
19a6 : 90 04 __ BCC $19ac ; (path_is_safe.s41 + 0)
.s40:
19a8 : a5 0f __ LDA P2 ; (end_x + 0)
19aa : 85 47 __ STA T6 + 0 
.s41:
19ac : c8 __ __ INY
19ad : c8 __ __ INY
19ae : b1 43 __ LDA (T0 + 0),y 
19b0 : 38 __ __ SEC
19b1 : 65 1b __ ADC ACCU + 0 
19b3 : c5 47 __ CMP T6 + 0 
19b5 : 90 38 __ BCC $19ef ; (path_is_safe.l3 + 0)
.s14:
19b7 : 88 __ __ DEY
19b8 : b1 43 __ LDA (T0 + 0),y 
19ba : 85 1b __ STA ACCU + 0 
19bc : c9 02 __ CMP #$02
19be : 90 06 __ BCC $19c6 ; (path_is_safe.s43 + 0)
.s42:
19c0 : 85 1c __ STA ACCU + 1 
19c2 : c6 1c __ DEC ACCU + 1 
19c4 : b0 04 __ BCS $19ca ; (path_is_safe.s44 + 0)
.s43:
19c6 : a9 00 __ LDA #$00
19c8 : 85 1c __ STA ACCU + 1 
.s44:
19ca : a5 10 __ LDA P3 ; (end_y + 0)
19cc : c5 0e __ CMP P1 ; (start_y + 0)
19ce : a6 0e __ LDX P1 ; (start_y + 0)
19d0 : 86 47 __ STX T6 + 0 
19d2 : b0 01 __ BCS $19d5 ; (path_is_safe.s1003 + 0)
.s45:
19d4 : 8a __ __ TXA
.s1003:
19d5 : c5 1c __ CMP ACCU + 1 
19d7 : 90 16 __ BCC $19ef ; (path_is_safe.l3 + 0)
.s13:
19d9 : e4 10 __ CPX P3 ; (end_y + 0)
19db : 90 04 __ BCC $19e1 ; (path_is_safe.s50 + 0)
.s49:
19dd : a5 10 __ LDA P3 ; (end_y + 0)
19df : 85 47 __ STA T6 + 0 
.s50:
19e1 : c8 __ __ INY
19e2 : c8 __ __ INY
19e3 : b1 43 __ LDA (T0 + 0),y 
19e5 : 38 __ __ SEC
19e6 : 65 1b __ ADC ACCU + 0 
19e8 : c5 47 __ CMP T6 + 0 
19ea : 90 03 __ BCC $19ef ; (path_is_safe.l3 + 0)
.s10:
19ec : a9 00 __ LDA #$00
.s1001:
19ee : 60 __ __ RTS
.l3:
19ef : e6 46 __ INC T4 + 0 
19f1 : a5 46 __ LDA T4 + 0 
19f3 : c5 45 __ CMP T3 + 0 
19f5 : b0 07 __ BCS $19fe ; (path_is_safe.s4 + 0)
.s2:
19f7 : c5 11 __ CMP P4 ; (source_room + 0)
19f9 : f0 f4 __ BEQ $19ef ; (path_is_safe.l3 + 0)
19fb : 4c 67 19 JMP $1967 ; (path_is_safe.s8 + 0)
.s4:
19fe : a9 01 __ LDA #$01
1a00 : 60 __ __ RTS
--------------------------------------------------------------------
get_wall_side_from_exit: ; get_wall_side_from_exit(u8,u8,u8)->u8
.s0:
1a01 : a5 0d __ LDA P0 ; (room_idx + 0)
1a03 : 85 1b __ STA ACCU + 0 
1a05 : a9 00 __ LDA #$00
1a07 : 85 1c __ STA ACCU + 1 
1a09 : a9 1d __ LDA #$1d
1a0b : 20 19 35 JSR $3519 ; (mul16by8 + 0)
1a0e : a9 20 __ LDA #$20
1a10 : 85 43 __ STA T0 + 0 
1a12 : 18 __ __ CLC
1a13 : a9 40 __ LDA #$40
1a15 : 65 1c __ ADC ACCU + 1 
1a17 : 85 44 __ STA T0 + 1 
1a19 : a4 1b __ LDY ACCU + 0 
1a1b : b1 43 __ LDA (T0 + 0),y 
1a1d : c5 0e __ CMP P1 ; (exit_x + 0)
1a1f : 90 05 __ BCC $1a26 ; (get_wall_side_from_exit.s2 + 0)
.s1006:
1a21 : f0 03 __ BEQ $1a26 ; (get_wall_side_from_exit.s2 + 0)
.s1:
1a23 : a9 00 __ LDA #$00
.s1001:
1a25 : 60 __ __ RTS
.s2:
1a26 : c8 __ __ INY
1a27 : 18 __ __ CLC
1a28 : c8 __ __ INY
1a29 : 71 43 __ ADC (T0 + 0),y 
1a2b : b0 06 __ BCS $1a33 ; (get_wall_side_from_exit.s6 + 0)
.s1002:
1a2d : c5 0e __ CMP P1 ; (exit_x + 0)
1a2f : 90 0e __ BCC $1a3f ; (get_wall_side_from_exit.s5 + 0)
.s1007:
1a31 : f0 0c __ BEQ $1a3f ; (get_wall_side_from_exit.s5 + 0)
.s6:
1a33 : a5 0f __ LDA P2 ; (exit_y + 0)
1a35 : 88 __ __ DEY
1a36 : d1 43 __ CMP (T0 + 0),y 
1a38 : a9 03 __ LDA #$03
1a3a : b0 e9 __ BCS $1a25 ; (get_wall_side_from_exit.s1001 + 0)
.s9:
1a3c : a9 02 __ LDA #$02
1a3e : 60 __ __ RTS
.s5:
1a3f : a9 01 __ LDA #$01
1a41 : 60 __ __ RTS
--------------------------------------------------------------------
draw_corridor_from_door: ; draw_corridor_from_door(u8,u8,u8,u8,u8,u8)->void
.s0:
1a42 : ad fd 9f LDA $9ffd ; (sstack + 6)
1a45 : c9 01 __ CMP #$01
1a47 : f0 3c __ BEQ $1a85 ; (draw_corridor_from_door.s3 + 0)
.s6:
1a49 : aa __ __ TAX
1a4a : f0 22 __ BEQ $1a6e ; (draw_corridor_from_door.s2 + 0)
.s7:
1a4c : c9 02 __ CMP #$02
1a4e : f0 01 __ BEQ $1a51 ; (draw_corridor_from_door.s4 + 0)
.s1001:
1a50 : 60 __ __ RTS
.s4:
1a51 : ad f8 9f LDA $9ff8 ; (sstack + 1)
1a54 : 85 15 __ STA P8 
1a56 : ad f9 9f LDA $9ff9 ; (sstack + 2)
1a59 : 85 16 __ STA P9 
1a5b : ad fb 9f LDA $9ffb ; (sstack + 4)
1a5e : 85 17 __ STA P10 
1a60 : ad fc 9f LDA $9ffc ; (sstack + 5)
1a63 : 85 18 __ STA P11 
1a65 : ad fa 9f LDA $9ffa ; (sstack + 3)
1a68 : 8d f7 9f STA $9ff7 ; (sstack + 0)
1a6b : 4c 3d 1c JMP $1c3d ; (draw_z_path.s0 + 0)
.s2:
1a6e : ad f8 9f LDA $9ff8 ; (sstack + 1)
1a71 : 85 11 __ STA P4 
1a73 : ad f9 9f LDA $9ff9 ; (sstack + 2)
1a76 : 85 12 __ STA P5 
1a78 : ad fb 9f LDA $9ffb ; (sstack + 4)
1a7b : 85 13 __ STA P6 
1a7d : ad fc 9f LDA $9ffc ; (sstack + 5)
1a80 : 85 14 __ STA P7 
1a82 : 4c a2 1a JMP $1aa2 ; (draw_straight_path.l1 + 0)
.s3:
1a85 : ad f8 9f LDA $9ff8 ; (sstack + 1)
1a88 : 85 15 __ STA P8 
1a8a : ad f9 9f LDA $9ff9 ; (sstack + 2)
1a8d : 85 16 __ STA P9 
1a8f : ad fb 9f LDA $9ffb ; (sstack + 4)
1a92 : 85 17 __ STA P10 
1a94 : ad fc 9f LDA $9ffc ; (sstack + 5)
1a97 : 85 18 __ STA P11 
1a99 : ad fa 9f LDA $9ffa ; (sstack + 3)
1a9c : 8d f7 9f STA $9ff7 ; (sstack + 0)
1a9f : 4c f7 1b JMP $1bf7 ; (draw_l_path.s0 + 0)
--------------------------------------------------------------------
draw_straight_path: ; draw_straight_path(u8,u8,u8,u8)->void
.l1:
1aa2 : a5 11 __ LDA P4 ; (door1_x + 0)
1aa4 : 29 80 __ AND #$80
1aa6 : 10 02 __ BPL $1aaa ; (draw_straight_path.l1 + 8)
1aa8 : a9 ff __ LDA #$ff
1aaa : 85 4a __ STA T2 + 1 
1aac : d0 0e __ BNE $1abc ; (draw_straight_path.s1018 + 0)
.s1013:
1aae : a5 11 __ LDA P4 ; (door1_x + 0)
1ab0 : c5 13 __ CMP P6 ; (door2_x + 0)
1ab2 : d0 0a __ BNE $1abe ; (draw_straight_path.s2 + 0)
.s4:
1ab4 : a5 12 __ LDA P5 ; (door1_y + 0)
1ab6 : 30 04 __ BMI $1abc ; (draw_straight_path.s1018 + 0)
.s1010:
1ab8 : c5 14 __ CMP P7 ; (door2_y + 0)
1aba : f0 58 __ BEQ $1b14 ; (draw_straight_path.s1001 + 0)
.s1018:
1abc : a5 11 __ LDA P4 ; (door1_x + 0)
.s2:
1abe : 85 0f __ STA P2 
1ac0 : a5 12 __ LDA P5 ; (door1_y + 0)
1ac2 : 85 10 __ STA P3 
1ac4 : 20 15 1b JSR $1b15 ; (can_place_corridor.s0 + 0)
1ac7 : a5 1b __ LDA ACCU + 0 
1ac9 : f0 0f __ BEQ $1ada ; (draw_straight_path.s7 + 0)
.s5:
1acb : a5 11 __ LDA P4 ; (door1_x + 0)
1acd : 85 0d __ STA P0 
1acf : a5 12 __ LDA P5 ; (door1_y + 0)
1ad1 : 85 0e __ STA P1 
1ad3 : a9 02 __ LDA #$02
1ad5 : 85 0f __ STA P2 
1ad7 : 20 1d 0f JSR $0f1d ; (set_compact_tile.s0 + 0)
.s7:
1ada : a0 00 __ LDY #$00
1adc : 24 10 __ BIT P3 
1ade : 10 01 __ BPL $1ae1 ; (draw_straight_path.s1017 + 0)
.s1016:
1ae0 : 88 __ __ DEY
.s1017:
1ae1 : a5 4a __ LDA T2 + 1 
1ae3 : 30 08 __ BMI $1aed ; (draw_straight_path.s9 + 0)
.s1009:
1ae5 : d0 0b __ BNE $1af2 ; (draw_straight_path.s10 + 0)
.s1006:
1ae7 : a5 11 __ LDA P4 ; (door1_x + 0)
1ae9 : c5 13 __ CMP P6 ; (door2_x + 0)
1aeb : b0 05 __ BCS $1af2 ; (draw_straight_path.s10 + 0)
.s9:
1aed : e6 11 __ INC P4 ; (door1_x + 0)
1aef : 4c fa 1a JMP $1afa ; (draw_straight_path.s11 + 0)
.s10:
1af2 : a5 13 __ LDA P6 ; (door2_x + 0)
1af4 : c5 11 __ CMP P4 ; (door1_x + 0)
1af6 : b0 02 __ BCS $1afa ; (draw_straight_path.s11 + 0)
.s12:
1af8 : c6 11 __ DEC P4 ; (door1_x + 0)
.s11:
1afa : 98 __ __ TYA
1afb : 30 08 __ BMI $1b05 ; (draw_straight_path.s15 + 0)
.s1005:
1afd : d0 0b __ BNE $1b0a ; (draw_straight_path.s16 + 0)
.s1002:
1aff : a5 10 __ LDA P3 
1b01 : c5 14 __ CMP P7 ; (door2_y + 0)
1b03 : b0 05 __ BCS $1b0a ; (draw_straight_path.s16 + 0)
.s15:
1b05 : e6 12 __ INC P5 ; (door1_y + 0)
1b07 : 4c a2 1a JMP $1aa2 ; (draw_straight_path.l1 + 0)
.s16:
1b0a : a5 14 __ LDA P7 ; (door2_y + 0)
1b0c : c5 12 __ CMP P5 ; (door1_y + 0)
1b0e : b0 92 __ BCS $1aa2 ; (draw_straight_path.l1 + 0)
.s18:
1b10 : c6 12 __ DEC P5 ; (door1_y + 0)
1b12 : 90 8e __ BCC $1aa2 ; (draw_straight_path.l1 + 0)
.s1001:
1b14 : 60 __ __ RTS
--------------------------------------------------------------------
can_place_corridor: ; can_place_corridor(u8,u8)->u8
.s0:
1b15 : a5 0f __ LDA P2 ; (x + 0)
1b17 : 85 0d __ STA P0 
1b19 : a5 10 __ LDA P3 ; (y + 0)
1b1b : 85 0e __ STA P1 
1b1d : 20 e4 1b JSR $1be4 ; (is_within_map_bounds.s0 + 0)
1b20 : aa __ __ TAX
1b21 : f0 59 __ BEQ $1b7c ; (can_place_corridor.s1 + 0)
.s3:
1b23 : ad e8 35 LDA $35e8 ; (room_count + 0)
1b26 : d0 05 __ BNE $1b2d ; (can_place_corridor.s33 + 0)
.s8:
1b28 : a9 01 __ LDA #$01
.s1001:
1b2a : 85 1b __ STA ACCU + 0 
1b2c : 60 __ __ RTS
.s33:
1b2d : 85 47 __ STA T6 + 0 
1b2f : a9 00 __ LDA #$00
1b31 : 85 48 __ STA T7 + 0 
.l6:
1b33 : 85 1b __ STA ACCU + 0 
1b35 : a9 00 __ LDA #$00
1b37 : 85 1c __ STA ACCU + 1 
1b39 : a9 1d __ LDA #$1d
1b3b : 20 19 35 JSR $3519 ; (mul16by8 + 0)
1b3e : a9 20 __ LDA #$20
1b40 : 85 43 __ STA T0 + 0 
1b42 : 18 __ __ CLC
1b43 : a9 40 __ LDA #$40
1b45 : 65 1c __ ADC ACCU + 1 
1b47 : 85 44 __ STA T0 + 1 
1b49 : a4 1b __ LDY ACCU + 0 
1b4b : b1 43 __ LDA (T0 + 0),y 
1b4d : 85 46 __ STA T4 + 0 
1b4f : 85 1c __ STA ACCU + 1 
1b51 : a5 0f __ LDA P2 ; (x + 0)
1b53 : c5 46 __ CMP T4 + 0 
1b55 : 90 29 __ BCC $1b80 ; (can_place_corridor.s11 + 0)
.s14:
1b57 : c8 __ __ INY
1b58 : c8 __ __ INY
1b59 : b1 43 __ LDA (T0 + 0),y 
1b5b : 18 __ __ CLC
1b5c : 65 46 __ ADC T4 + 0 
1b5e : b0 06 __ BCS $1b66 ; (can_place_corridor.s13 + 0)
.s1005:
1b60 : c5 0f __ CMP P2 ; (x + 0)
1b62 : 90 1c __ BCC $1b80 ; (can_place_corridor.s11 + 0)
.s1014:
1b64 : f0 1a __ BEQ $1b80 ; (can_place_corridor.s11 + 0)
.s13:
1b66 : 88 __ __ DEY
1b67 : b1 43 __ LDA (T0 + 0),y 
1b69 : c5 10 __ CMP P3 ; (y + 0)
1b6b : 90 02 __ BCC $1b6f ; (can_place_corridor.s12 + 0)
.s1012:
1b6d : d0 11 __ BNE $1b80 ; (can_place_corridor.s11 + 0)
.s12:
1b6f : c8 __ __ INY
1b70 : 18 __ __ CLC
1b71 : c8 __ __ INY
1b72 : 71 43 __ ADC (T0 + 0),y 
1b74 : b0 06 __ BCS $1b7c ; (can_place_corridor.s1 + 0)
.s1002:
1b76 : c5 10 __ CMP P3 ; (y + 0)
1b78 : 90 06 __ BCC $1b80 ; (can_place_corridor.s11 + 0)
.s1013:
1b7a : f0 04 __ BEQ $1b80 ; (can_place_corridor.s11 + 0)
.s1:
1b7c : a9 00 __ LDA #$00
1b7e : f0 aa __ BEQ $1b2a ; (can_place_corridor.s1001 + 0)
.s11:
1b80 : a5 46 __ LDA T4 + 0 
1b82 : c9 02 __ CMP #$02
1b84 : b0 04 __ BCS $1b8a ; (can_place_corridor.s45 + 0)
.s46:
1b86 : a9 00 __ LDA #$00
1b88 : 90 02 __ BCC $1b8c ; (can_place_corridor.s47 + 0)
.s45:
1b8a : e9 02 __ SBC #$02
.s47:
1b8c : 85 45 __ STA T2 + 0 
1b8e : a4 1b __ LDY ACCU + 0 
1b90 : c8 __ __ INY
1b91 : b1 43 __ LDA (T0 + 0),y 
1b93 : 85 1b __ STA ACCU + 0 
1b95 : c9 02 __ CMP #$02
1b97 : b0 04 __ BCS $1b9d ; (can_place_corridor.s48 + 0)
.s49:
1b99 : a9 00 __ LDA #$00
1b9b : 90 02 __ BCC $1b9f ; (can_place_corridor.s50 + 0)
.s48:
1b9d : e9 02 __ SBC #$02
.s50:
1b9f : 85 46 __ STA T4 + 0 
1ba1 : c8 __ __ INY
1ba2 : c8 __ __ INY
1ba3 : b1 43 __ LDA (T0 + 0),y 
1ba5 : 38 __ __ SEC
1ba6 : 65 1b __ ADC ACCU + 0 
1ba8 : aa __ __ TAX
1ba9 : 88 __ __ DEY
1baa : b1 43 __ LDA (T0 + 0),y 
1bac : 38 __ __ SEC
1bad : 65 1c __ ADC ACCU + 1 
1baf : c9 40 __ CMP #$40
1bb1 : a8 __ __ TAY
1bb2 : 90 02 __ BCC $1bb6 ; (can_place_corridor.s18 + 0)
.s16:
1bb4 : a0 3f __ LDY #$3f
.s18:
1bb6 : e0 40 __ CPX #$40
1bb8 : a5 0f __ LDA P2 ; (x + 0)
1bba : 90 22 __ BCC $1bde ; (can_place_corridor.s21 + 0)
.s19:
1bbc : c5 45 __ CMP T2 + 0 
1bbe : 90 10 __ BCC $1bd0 ; (can_place_corridor.s7 + 0)
.s57:
1bc0 : a2 3f __ LDX #$3f
.s27:
1bc2 : c4 0f __ CPY P2 ; (x + 0)
1bc4 : 90 0a __ BCC $1bd0 ; (can_place_corridor.s7 + 0)
.s26:
1bc6 : a5 10 __ LDA P3 ; (y + 0)
1bc8 : c5 46 __ CMP T4 + 0 
1bca : 90 04 __ BCC $1bd0 ; (can_place_corridor.s7 + 0)
.s25:
1bcc : e4 10 __ CPX P3 ; (y + 0)
1bce : b0 ac __ BCS $1b7c ; (can_place_corridor.s1 + 0)
.s7:
1bd0 : e6 48 __ INC T7 + 0 
1bd2 : a5 48 __ LDA T7 + 0 
1bd4 : c5 47 __ CMP T6 + 0 
1bd6 : b0 03 __ BCS $1bdb ; (can_place_corridor.s7 + 11)
1bd8 : 4c 33 1b JMP $1b33 ; (can_place_corridor.l6 + 0)
1bdb : 4c 28 1b JMP $1b28 ; (can_place_corridor.s8 + 0)
.s21:
1bde : c5 45 __ CMP T2 + 0 
1be0 : 90 ee __ BCC $1bd0 ; (can_place_corridor.s7 + 0)
1be2 : b0 de __ BCS $1bc2 ; (can_place_corridor.s27 + 0)
--------------------------------------------------------------------
is_within_map_bounds: ; is_within_map_bounds(u8,u8)->u8
.s0:
1be4 : a5 0d __ LDA P0 ; (x + 0)
1be6 : c9 40 __ CMP #$40
1be8 : b0 0a __ BCS $1bf4 ; (is_within_map_bounds.s2 + 0)
.s4:
1bea : a5 0e __ LDA P1 ; (y + 0)
1bec : c9 40 __ CMP #$40
1bee : a9 00 __ LDA #$00
1bf0 : 2a __ __ ROL
1bf1 : 49 01 __ EOR #$01
1bf3 : 60 __ __ RTS
.s2:
1bf4 : a9 00 __ LDA #$00
.s1001:
1bf6 : 60 __ __ RTS
--------------------------------------------------------------------
draw_l_path: ; draw_l_path(u8,u8,u8,u8,u8)->void
.s0:
1bf7 : a5 15 __ LDA P8 ; (door1_x + 0)
1bf9 : 85 11 __ STA P4 
1bfb : a9 01 __ LDA #$01
1bfd : cd f7 9f CMP $9ff7 ; (sstack + 0)
1c00 : a6 16 __ LDX P9 ; (door1_y + 0)
1c02 : 86 12 __ STX P5 
1c04 : 90 1c __ BCC $1c22 ; (draw_l_path.s7 + 0)
.s2:
1c06 : 86 14 __ STX P7 
1c08 : a5 17 __ LDA P10 ; (door2_x + 0)
.s1002:
1c0a : 85 13 __ STA P6 
1c0c : 20 a2 1a JSR $1aa2 ; (draw_straight_path.l1 + 0)
1c0f : a5 13 __ LDA P6 
1c11 : 85 11 __ STA P4 
1c13 : a5 14 __ LDA P7 
1c15 : 85 12 __ STA P5 
1c17 : a5 17 __ LDA P10 ; (door2_x + 0)
1c19 : 85 13 __ STA P6 
1c1b : a5 18 __ LDA P11 ; (door2_y + 0)
1c1d : 85 14 __ STA P7 
1c1f : 4c a2 1a JMP $1aa2 ; (draw_straight_path.l1 + 0)
.s7:
1c22 : ad f7 9f LDA $9ff7 ; (sstack + 0)
1c25 : c9 02 __ CMP #$02
1c27 : 90 07 __ BCC $1c30 ; (draw_l_path.s5 + 0)
.s10:
1c29 : a9 03 __ LDA #$03
1c2b : cd f7 9f CMP $9ff7 ; (sstack + 0)
1c2e : b0 04 __ BCS $1c34 ; (draw_l_path.s3 + 0)
.s5:
1c30 : 86 14 __ STX P7 
1c32 : 90 04 __ BCC $1c38 ; (draw_l_path.s1003 + 0)
.s3:
1c34 : a5 18 __ LDA P11 ; (door2_y + 0)
1c36 : 85 14 __ STA P7 
.s1003:
1c38 : a5 15 __ LDA P8 ; (door1_x + 0)
1c3a : 4c 0a 1c JMP $1c0a ; (draw_l_path.s1002 + 0)
--------------------------------------------------------------------
draw_z_path: ; draw_z_path(u8,u8,u8,u8,u8)->void
.s0:
1c3d : a5 15 __ LDA P8 ; (door1_x + 0)
1c3f : 85 13 __ STA P6 
1c41 : 85 11 __ STA P4 
1c43 : c5 17 __ CMP P10 ; (door2_x + 0)
1c45 : a9 00 __ LDA #$00
1c47 : 2a __ __ ROL
1c48 : 49 01 __ EOR #$01
1c4a : 85 4c __ STA T3 + 0 
1c4c : d0 08 __ BNE $1c56 ; (draw_z_path.s9 + 0)
.s10:
1c4e : 38 __ __ SEC
1c4f : a5 15 __ LDA P8 ; (door1_x + 0)
1c51 : e5 17 __ SBC P10 ; (door2_x + 0)
1c53 : 4c 5b 1c JMP $1c5b ; (draw_z_path.s11 + 0)
.s9:
1c56 : 38 __ __ SEC
1c57 : a5 17 __ LDA P10 ; (door2_x + 0)
1c59 : e5 15 __ SBC P8 ; (door1_x + 0)
.s11:
1c5b : 85 1b __ STA ACCU + 0 
1c5d : a6 16 __ LDX P9 ; (door1_y + 0)
1c5f : 86 12 __ STX P5 
1c61 : ad f7 9f LDA $9ff7 ; (sstack + 0)
1c64 : f0 6c __ BEQ $1cd2 ; (draw_z_path.s5 + 0)
.s8:
1c66 : c9 01 __ CMP #$01
1c68 : f0 68 __ BEQ $1cd2 ; (draw_z_path.s5 + 0)
.s6:
1c6a : 8a __ __ TXA
1c6b : e4 18 __ CPX P11 ; (door2_y + 0)
1c6d : 90 19 __ BCC $1c88 ; (draw_z_path.s15 + 0)
.s16:
1c6f : e5 18 __ SBC P11 ; (door2_y + 0)
1c71 : 85 1b __ STA ACCU + 0 
1c73 : a9 00 __ LDA #$00
1c75 : 85 1c __ STA ACCU + 1 
1c77 : 85 04 __ STA WORK + 1 
1c79 : a9 03 __ LDA #$03
1c7b : 85 03 __ STA WORK + 0 
1c7d : 20 51 35 JSR $3551 ; (divmod + 0)
1c80 : 38 __ __ SEC
1c81 : a5 16 __ LDA P9 ; (door1_y + 0)
1c83 : e5 1b __ SBC ACCU + 0 
1c85 : 4c a1 1c JMP $1ca1 ; (draw_z_path.s20 + 0)
.s15:
1c88 : 38 __ __ SEC
1c89 : a5 18 __ LDA P11 ; (door2_y + 0)
1c8b : e5 16 __ SBC P9 ; (door1_y + 0)
1c8d : 85 1b __ STA ACCU + 0 
1c8f : a9 00 __ LDA #$00
1c91 : 85 1c __ STA ACCU + 1 
1c93 : 85 04 __ STA WORK + 1 
1c95 : a9 03 __ LDA #$03
1c97 : 85 03 __ STA WORK + 0 
1c99 : 20 51 35 JSR $3551 ; (divmod + 0)
1c9c : 18 __ __ CLC
1c9d : a5 1b __ LDA ACCU + 0 
1c9f : 65 16 __ ADC P9 ; (door1_y + 0)
.s20:
1ca1 : 85 14 __ STA P7 
1ca3 : a6 17 __ LDX P10 ; (door2_x + 0)
1ca5 : 86 4b __ STX T1 + 0 
.s7:
1ca7 : 85 4c __ STA T3 + 0 
1ca9 : 20 a2 1a JSR $1aa2 ; (draw_straight_path.l1 + 0)
1cac : a5 13 __ LDA P6 
1cae : 85 11 __ STA P4 
1cb0 : a5 14 __ LDA P7 
1cb2 : 85 12 __ STA P5 
1cb4 : a5 4b __ LDA T1 + 0 
1cb6 : 85 13 __ STA P6 
1cb8 : a5 4c __ LDA T3 + 0 
1cba : 85 14 __ STA P7 
1cbc : 20 a2 1a JSR $1aa2 ; (draw_straight_path.l1 + 0)
1cbf : a5 13 __ LDA P6 
1cc1 : 85 11 __ STA P4 
1cc3 : a5 14 __ LDA P7 
1cc5 : 85 12 __ STA P5 
1cc7 : a5 17 __ LDA P10 ; (door2_x + 0)
1cc9 : 85 13 __ STA P6 
1ccb : a5 18 __ LDA P11 ; (door2_y + 0)
1ccd : 85 14 __ STA P7 
1ccf : 4c a2 1a JMP $1aa2 ; (draw_straight_path.l1 + 0)
.s5:
1cd2 : a9 00 __ LDA #$00
1cd4 : 85 1c __ STA ACCU + 1 
1cd6 : 85 04 __ STA WORK + 1 
1cd8 : a9 03 __ LDA #$03
1cda : 85 03 __ STA WORK + 0 
1cdc : 20 51 35 JSR $3551 ; (divmod + 0)
1cdf : a5 4c __ LDA T3 + 0 
1ce1 : d0 08 __ BNE $1ceb ; (draw_z_path.s12 + 0)
.s13:
1ce3 : 38 __ __ SEC
1ce4 : a5 15 __ LDA P8 ; (door1_x + 0)
1ce6 : e5 1b __ SBC ACCU + 0 
1ce8 : 4c f0 1c JMP $1cf0 ; (draw_z_path.s14 + 0)
.s12:
1ceb : 18 __ __ CLC
1cec : a5 1b __ LDA ACCU + 0 
1cee : 65 15 __ ADC P8 ; (door1_x + 0)
.s14:
1cf0 : 85 13 __ STA P6 
1cf2 : 85 4b __ STA T1 + 0 
1cf4 : a5 16 __ LDA P9 ; (door1_y + 0)
1cf6 : 85 14 __ STA P7 
1cf8 : a5 18 __ LDA P11 ; (door2_y + 0)
1cfa : 4c a7 1c JMP $1ca7 ; (draw_z_path.s7 + 0)
--------------------------------------------------------------------
place_door: ; place_door(u8,u8)->void
.s0:
1cfd : a5 10 __ LDA P3 ; (x + 0)
1cff : c9 40 __ CMP #$40
1d01 : b0 08 __ BCS $1d0b ; (place_door.s1 + 0)
.s8:
1d03 : a5 11 __ LDA P4 ; (y + 0)
1d05 : c9 40 __ CMP #$40
1d07 : 90 0f __ BCC $1d18 ; (place_door.s7 + 0)
.s1038:
1d09 : a5 10 __ LDA P3 ; (x + 0)
.s1:
1d0b : 85 0d __ STA P0 
1d0d : a5 11 __ LDA P4 ; (y + 0)
1d0f : 85 0e __ STA P1 
1d11 : a9 03 __ LDA #$03
1d13 : 85 0f __ STA P2 
1d15 : 4c 1d 0f JMP $0f1d ; (set_compact_tile.s0 + 0)
.s7:
1d18 : 85 44 __ STA T0 + 1 
1d1a : 4a __ __ LSR
1d1b : aa __ __ TAX
1d1c : a9 00 __ LDA #$00
1d1e : 6a __ __ ROR
1d1f : 85 45 __ STA T1 + 0 
1d21 : a9 00 __ LDA #$00
1d23 : 46 44 __ LSR T0 + 1 
1d25 : 6a __ __ ROR
1d26 : 66 44 __ ROR T0 + 1 
1d28 : 6a __ __ ROR
1d29 : 65 45 __ ADC T1 + 0 
1d2b : a8 __ __ TAY
1d2c : 8a __ __ TXA
1d2d : 65 44 __ ADC T0 + 1 
1d2f : aa __ __ TAX
1d30 : 98 __ __ TYA
1d31 : 18 __ __ CLC
1d32 : 65 10 __ ADC P3 ; (x + 0)
1d34 : 90 01 __ BCC $1d37 ; (place_door.s1013 + 0)
.s1012:
1d36 : e8 __ __ INX
.s1013:
1d37 : 18 __ __ CLC
1d38 : 65 10 __ ADC P3 ; (x + 0)
1d3a : 90 01 __ BCC $1d3d ; (place_door.s1015 + 0)
.s1014:
1d3c : e8 __ __ INX
.s1015:
1d3d : 18 __ __ CLC
1d3e : 65 10 __ ADC P3 ; (x + 0)
1d40 : a8 __ __ TAY
1d41 : 8a __ __ TXA
1d42 : 69 00 __ ADC #$00
1d44 : 4a __ __ LSR
1d45 : 85 46 __ STA T1 + 1 
1d47 : 98 __ __ TYA
1d48 : 6a __ __ ROR
1d49 : 46 46 __ LSR T1 + 1 
1d4b : 6a __ __ ROR
1d4c : 46 46 __ LSR T1 + 1 
1d4e : 6a __ __ ROR
1d4f : 85 45 __ STA T1 + 0 
1d51 : 18 __ __ CLC
1d52 : a9 3a __ LDA #$3a
1d54 : 65 46 __ ADC T1 + 1 
1d56 : 85 46 __ STA T1 + 1 
1d58 : 98 __ __ TYA
1d59 : 29 07 __ AND #$07
1d5b : 85 43 __ STA T0 + 0 
1d5d : aa __ __ TAX
1d5e : a0 20 __ LDY #$20
1d60 : b1 45 __ LDA (T1 + 0),y 
1d62 : e0 00 __ CPX #$00
1d64 : f0 04 __ BEQ $1d6a ; (place_door.s1003 + 0)
.l1002:
1d66 : 4a __ __ LSR
1d67 : ca __ __ DEX
1d68 : d0 fc __ BNE $1d66 ; (place_door.l1002 + 0)
.s1003:
1d6a : 85 1b __ STA ACCU + 0 
1d6c : a5 43 __ LDA T0 + 0 
1d6e : c9 06 __ CMP #$06
1d70 : b0 04 __ BCS $1d76 ; (place_door.s13 + 0)
.s11:
1d72 : a5 1b __ LDA ACCU + 0 
1d74 : 90 18 __ BCC $1d8e ; (place_door.s10 + 0)
.s13:
1d76 : a9 08 __ LDA #$08
1d78 : e5 43 __ SBC T0 + 0 
1d7a : aa __ __ TAX
1d7b : bd 24 36 LDA $3624,x ; (bitshift + 36)
1d7e : 38 __ __ SEC
1d7f : e9 01 __ SBC #$01
1d81 : c8 __ __ INY
1d82 : 31 45 __ AND (T1 + 0),y 
1d84 : e0 00 __ CPX #$00
1d86 : f0 04 __ BEQ $1d8c ; (place_door.s1005 + 0)
.l1006:
1d88 : 0a __ __ ASL
1d89 : ca __ __ DEX
1d8a : d0 fc __ BNE $1d88 ; (place_door.l1006 + 0)
.s1005:
1d8c : 05 1b __ ORA ACCU + 0 
.s10:
1d8e : 29 07 __ AND #$07
1d90 : c9 03 __ CMP #$03
1d92 : f0 07 __ BEQ $1d9b ; (place_door.s1001 + 0)
.s19:
1d94 : c9 06 __ CMP #$06
1d96 : f0 03 __ BEQ $1d9b ; (place_door.s1001 + 0)
1d98 : 4c 09 1d JMP $1d09 ; (place_door.s1038 + 0)
.s1001:
1d9b : 60 __ __ RTS
--------------------------------------------------------------------
add_room_connection: ; add_room_connection(u8,u8)->void
.s0:
1d9c : a5 0d __ LDA P0 ; (room1 + 0)
1d9e : 85 1b __ STA ACCU + 0 
1da0 : a9 00 __ LDA #$00
1da2 : 85 1c __ STA ACCU + 1 
1da4 : a9 1d __ LDA #$1d
1da6 : 20 19 35 JSR $3519 ; (mul16by8 + 0)
1da9 : 18 __ __ CLC
1daa : a9 20 __ LDA #$20
1dac : 65 1b __ ADC ACCU + 0 
1dae : 85 1b __ STA ACCU + 0 
1db0 : a9 40 __ LDA #$40
1db2 : 65 1c __ ADC ACCU + 1 
1db4 : 85 1c __ STA ACCU + 1 
1db6 : a0 04 __ LDY #$04
1db8 : b1 1b __ LDA (ACCU + 0),y 
1dba : c9 04 __ CMP #$04
1dbc : b0 0f __ BCS $1dcd ; (add_room_connection.s3 + 0)
.s1:
1dbe : 09 08 __ ORA #$08
1dc0 : a8 __ __ TAY
1dc1 : a5 0e __ LDA P1 ; (room2 + 0)
1dc3 : 91 1b __ STA (ACCU + 0),y 
1dc5 : a0 04 __ LDY #$04
1dc7 : b1 1b __ LDA (ACCU + 0),y 
1dc9 : 69 01 __ ADC #$01
1dcb : 91 1b __ STA (ACCU + 0),y 
.s3:
1dcd : a5 0e __ LDA P1 ; (room2 + 0)
1dcf : 85 1b __ STA ACCU + 0 
1dd1 : a9 00 __ LDA #$00
1dd3 : 85 1c __ STA ACCU + 1 
1dd5 : a9 1d __ LDA #$1d
1dd7 : 20 19 35 JSR $3519 ; (mul16by8 + 0)
1dda : 18 __ __ CLC
1ddb : a9 20 __ LDA #$20
1ddd : 65 1b __ ADC ACCU + 0 
1ddf : 85 1b __ STA ACCU + 0 
1de1 : a9 40 __ LDA #$40
1de3 : 65 1c __ ADC ACCU + 1 
1de5 : 85 1c __ STA ACCU + 1 
1de7 : a0 04 __ LDY #$04
1de9 : b1 1b __ LDA (ACCU + 0),y 
1deb : c9 04 __ CMP #$04
1ded : b0 0f __ BCS $1dfe ; (add_room_connection.s1001 + 0)
.s4:
1def : 09 08 __ ORA #$08
1df1 : a8 __ __ TAY
1df2 : a5 0d __ LDA P0 ; (room1 + 0)
1df4 : 91 1b __ STA (ACCU + 0),y 
1df6 : a0 04 __ LDY #$04
1df8 : b1 1b __ LDA (ACCU + 0),y 
1dfa : 69 01 __ ADC #$01
1dfc : 91 1b __ STA (ACCU + 0),y 
.s1001:
1dfe : 60 __ __ RTS
--------------------------------------------------------------------
add_door_to_room: ; add_door_to_room(u8,u8,u8,u8,u8)->void
.s0:
1dff : a5 0d __ LDA P0 ; (room_idx + 0)
1e01 : 85 1b __ STA ACCU + 0 
1e03 : a9 00 __ LDA #$00
1e05 : 85 1c __ STA ACCU + 1 
1e07 : a9 1d __ LDA #$1d
1e09 : 20 19 35 JSR $3519 ; (mul16by8 + 0)
1e0c : 18 __ __ CLC
1e0d : a9 20 __ LDA #$20
1e0f : 65 1b __ ADC ACCU + 0 
1e11 : 85 1b __ STA ACCU + 0 
1e13 : a9 40 __ LDA #$40
1e15 : 65 1c __ ADC ACCU + 1 
1e17 : 85 1c __ STA ACCU + 1 
1e19 : a0 1c __ LDY #$1c
1e1b : b1 1b __ LDA (ACCU + 0),y 
1e1d : c9 04 __ CMP #$04
1e1f : b0 2b __ BCS $1e4c ; (add_door_to_room.s1001 + 0)
.s1:
1e21 : 0a __ __ ASL
1e22 : 0a __ __ ASL
1e23 : 18 __ __ CLC
1e24 : 65 1b __ ADC ACCU + 0 
1e26 : 85 43 __ STA T1 + 0 
1e28 : a5 1c __ LDA ACCU + 1 
1e2a : 69 00 __ ADC #$00
1e2c : 85 44 __ STA T1 + 1 
1e2e : a5 0e __ LDA P1 ; (x + 0)
1e30 : a0 0c __ LDY #$0c
1e32 : 91 43 __ STA (T1 + 0),y 
1e34 : a5 0f __ LDA P2 ; (y + 0)
1e36 : c8 __ __ INY
1e37 : 91 43 __ STA (T1 + 0),y 
1e39 : a5 10 __ LDA P3 ; (wall_side + 0)
1e3b : c8 __ __ INY
1e3c : 91 43 __ STA (T1 + 0),y 
1e3e : a5 11 __ LDA P4 ; (connected_room + 0)
1e40 : c8 __ __ INY
1e41 : 91 43 __ STA (T1 + 0),y 
1e43 : 18 __ __ CLC
1e44 : a0 1c __ LDY #$1c
1e46 : b1 1b __ LDA (ACCU + 0),y 
1e48 : 69 01 __ ADC #$01
1e4a : 91 1b __ STA (ACCU + 0),y 
.s1001:
1e4c : 60 __ __ RTS
--------------------------------------------------------------------
mark_secret_rooms: ; mark_secret_rooms(u8)->void
.s0:
1e4d : a9 35 __ LDA #$35
1e4f : 85 0e __ STA P1 
1e51 : a9 1f __ LDA #$1f
1e53 : 85 0f __ STA P2 
1e55 : 20 1f 0a JSR $0a1f ; (print_text.s0 + 0)
1e58 : ad e8 35 LDA $35e8 ; (room_count + 0)
1e5b : d0 01 __ BNE $1e5e ; (mark_secret_rooms.s29 + 0)
1e5d : 60 __ __ RTS
.s29:
1e5e : 85 4d __ STA T9 + 0 
1e60 : a9 00 __ LDA #$00
1e62 : 85 4e __ STA T10 + 0 
1e64 : 85 49 __ STA T4 + 0 
1e66 : 85 4a __ STA T4 + 1 
1e68 : a9 20 __ LDA #$20
1e6a : 85 4b __ STA T5 + 0 
1e6c : a9 40 __ LDA #$40
1e6e : 85 4c __ STA T5 + 1 
.l2:
1e70 : a0 04 __ LDY #$04
1e72 : b1 4b __ LDA (T5 + 0),y 
1e74 : c9 01 __ CMP #$01
1e76 : f0 03 __ BEQ $1e7b ; (mark_secret_rooms.s8 + 0)
1e78 : 4c 13 1f JMP $1f13 ; (mark_secret_rooms.s1 + 0)
.s8:
1e7b : a9 64 __ LDA #$64
1e7d : 20 10 0c JSR $0c10 ; (rnd.s0 + 0)
1e80 : c5 14 __ CMP P7 ; (secret_percentage + 0)
1e82 : b0 f4 __ BCS $1e78 ; (mark_secret_rooms.l2 + 8)
.s5:
1e84 : a0 05 __ LDY #$05
1e86 : b1 4b __ LDA (T5 + 0),y 
1e88 : 09 01 __ ORA #$01
1e8a : 91 4b __ STA (T5 + 0),y 
1e8c : a0 1c __ LDY #$1c
1e8e : b1 4b __ LDA (T5 + 0),y 
1e90 : f0 e6 __ BEQ $1e78 ; (mark_secret_rooms.l2 + 8)
.s9:
1e92 : a9 2c __ LDA #$2c
1e94 : 85 43 __ STA T0 + 0 
1e96 : a9 40 __ LDA #$40
1e98 : 65 4a __ ADC T4 + 1 
1e9a : 85 44 __ STA T0 + 1 
1e9c : a0 0f __ LDY #$0f
1e9e : b1 4b __ LDA (T5 + 0),y 
1ea0 : 85 1b __ STA ACCU + 0 
1ea2 : a9 00 __ LDA #$00
1ea4 : 85 1c __ STA ACCU + 1 
1ea6 : a9 1d __ LDA #$1d
1ea8 : 20 19 35 JSR $3519 ; (mul16by8 + 0)
1eab : 18 __ __ CLC
1eac : a9 20 __ LDA #$20
1eae : 65 1b __ ADC ACCU + 0 
1eb0 : 85 47 __ STA T2 + 0 
1eb2 : a9 40 __ LDA #$40
1eb4 : 65 1c __ ADC ACCU + 1 
1eb6 : 85 48 __ STA T2 + 1 
1eb8 : a0 1c __ LDY #$1c
1eba : b1 47 __ LDA (T2 + 0),y 
1ebc : 85 1d __ STA ACCU + 2 
1ebe : a2 00 __ LDX #$00
1ec0 : f0 01 __ BEQ $1ec3 ; (mark_secret_rooms.l12 + 0)
.s14:
1ec2 : e8 __ __ INX
.l12:
1ec3 : 8a __ __ TXA
1ec4 : e4 1d __ CPX ACCU + 2 
1ec6 : b0 4b __ BCS $1f13 ; (mark_secret_rooms.s1 + 0)
.s13:
1ec8 : 0a __ __ ASL
1ec9 : 0a __ __ ASL
1eca : 18 __ __ CLC
1ecb : 65 47 __ ADC T2 + 0 
1ecd : 85 1b __ STA ACCU + 0 
1ecf : a5 48 __ LDA T2 + 1 
1ed1 : 69 00 __ ADC #$00
1ed3 : 85 1c __ STA ACCU + 1 
1ed5 : a5 4e __ LDA T10 + 0 
1ed7 : a0 0f __ LDY #$0f
1ed9 : d1 1b __ CMP (ACCU + 0),y 
1edb : d0 e5 __ BNE $1ec2 ; (mark_secret_rooms.s14 + 0)
.s16:
1edd : a5 1b __ LDA ACCU + 0 
1edf : 69 0b __ ADC #$0b
1ee1 : 85 45 __ STA T1 + 0 
1ee3 : a5 1c __ LDA ACCU + 1 
1ee5 : 69 00 __ ADC #$00
1ee7 : 85 46 __ STA T1 + 1 
1ee9 : 05 45 __ ORA T1 + 0 
1eeb : f0 26 __ BEQ $1f13 ; (mark_secret_rooms.s1 + 0)
.s20:
1eed : a4 49 __ LDY T4 + 0 
1eef : b1 43 __ LDA (T0 + 0),y 
1ef1 : 85 10 __ STA P3 
1ef3 : a0 00 __ LDY #$00
1ef5 : b1 45 __ LDA (T1 + 0),y 
1ef7 : 85 12 __ STA P5 
1ef9 : c8 __ __ INY
1efa : b1 45 __ LDA (T1 + 0),y 
1efc : 85 13 __ STA P6 
1efe : a4 49 __ LDY T4 + 0 
1f00 : c8 __ __ INY
1f01 : b1 43 __ LDA (T0 + 0),y 
1f03 : 85 11 __ STA P4 
1f05 : 20 4b 1f JSR $1f4b ; (convert_path_to_secret.s0 + 0)
1f08 : a9 dc __ LDA #$dc
1f0a : 85 0e __ STA P1 
1f0c : a9 20 __ LDA #$20
1f0e : 85 0f __ STA P2 
1f10 : 20 1f 0a JSR $0a1f ; (print_text.s0 + 0)
.s1:
1f13 : 18 __ __ CLC
1f14 : a5 49 __ LDA T4 + 0 
1f16 : 69 1d __ ADC #$1d
1f18 : 85 49 __ STA T4 + 0 
1f1a : 90 02 __ BCC $1f1e ; (mark_secret_rooms.s1007 + 0)
.s1006:
1f1c : e6 4a __ INC T4 + 1 
.s1007:
1f1e : 18 __ __ CLC
1f1f : a5 4b __ LDA T5 + 0 
1f21 : 69 1d __ ADC #$1d
1f23 : 85 4b __ STA T5 + 0 
1f25 : 90 02 __ BCC $1f29 ; (mark_secret_rooms.s1009 + 0)
.s1008:
1f27 : e6 4c __ INC T5 + 1 
.s1009:
1f29 : e6 4e __ INC T10 + 0 
1f2b : a5 4e __ LDA T10 + 0 
1f2d : c5 4d __ CMP T9 + 0 
1f2f : b0 03 __ BCS $1f34 ; (mark_secret_rooms.s1001 + 0)
1f31 : 4c 70 1e JMP $1e70 ; (mark_secret_rooms.l2 + 0)
.s1001:
1f34 : 60 __ __ RTS
--------------------------------------------------------------------
1f35 : __ __ __ BYT 0a 4d 61 72 6b 69 6e 67 20 73 65 63 72 65 74 20 : .Marking secret 
1f45 : __ __ __ BYT 72 6f 6f 6d 73 00                               : rooms.
--------------------------------------------------------------------
convert_path_to_secret: ; convert_path_to_secret(u8,u8,u8,u8)->void
.s0:
1f4b : a9 06 __ LDA #$06
1f4d : 85 0f __ STA P2 
.l1:
1f4f : a5 10 __ LDA P3 ; (x1 + 0)
1f51 : 29 80 __ AND #$80
1f53 : 10 02 __ BPL $1f57 ; (convert_path_to_secret.l1 + 8)
1f55 : a9 ff __ LDA #$ff
1f57 : 85 48 __ STA T4 + 1 
1f59 : d0 11 __ BNE $1f6c ; (convert_path_to_secret.s1090 + 0)
.s1021:
1f5b : a5 10 __ LDA P3 ; (x1 + 0)
1f5d : c5 12 __ CMP P5 ; (x2 + 0)
1f5f : d0 0d __ BNE $1f6e ; (convert_path_to_secret.s2 + 0)
.s4:
1f61 : a5 11 __ LDA P4 ; (y1 + 0)
1f63 : 30 07 __ BMI $1f6c ; (convert_path_to_secret.s1090 + 0)
.s1018:
1f65 : c5 13 __ CMP P6 ; (y2 + 0)
1f67 : d0 03 __ BNE $1f6c ; (convert_path_to_secret.s1090 + 0)
1f69 : 4c 43 20 JMP $2043 ; (convert_path_to_secret.s3 + 0)
.s1090:
1f6c : a5 10 __ LDA P3 ; (x1 + 0)
.s2:
1f6e : c9 40 __ CMP #$40
1f70 : b0 06 __ BCS $1f78 ; (convert_path_to_secret.s7 + 0)
.s13:
1f72 : a5 11 __ LDA P4 ; (y1 + 0)
1f74 : c9 40 __ CMP #$40
1f76 : 90 3a __ BCC $1fb2 ; (convert_path_to_secret.s12 + 0)
.s7:
1f78 : a2 00 __ LDX #$00
1f7a : 24 11 __ BIT P4 ; (y1 + 0)
1f7c : 10 01 __ BPL $1f7f ; (convert_path_to_secret.s1045 + 0)
.s1044:
1f7e : ca __ __ DEX
.s1045:
1f7f : a5 48 __ LDA T4 + 1 
1f81 : 30 08 __ BMI $1f8b ; (convert_path_to_secret.s36 + 0)
.s1017:
1f83 : d0 0b __ BNE $1f90 ; (convert_path_to_secret.s37 + 0)
.s1014:
1f85 : a5 10 __ LDA P3 ; (x1 + 0)
1f87 : c5 12 __ CMP P5 ; (x2 + 0)
1f89 : b0 05 __ BCS $1f90 ; (convert_path_to_secret.s37 + 0)
.s36:
1f8b : e6 10 __ INC P3 ; (x1 + 0)
1f8d : 4c 98 1f JMP $1f98 ; (convert_path_to_secret.s38 + 0)
.s37:
1f90 : a5 12 __ LDA P5 ; (x2 + 0)
1f92 : c5 10 __ CMP P3 ; (x1 + 0)
1f94 : b0 02 __ BCS $1f98 ; (convert_path_to_secret.s38 + 0)
.s39:
1f96 : c6 10 __ DEC P3 ; (x1 + 0)
.s38:
1f98 : 8a __ __ TXA
1f99 : 30 08 __ BMI $1fa3 ; (convert_path_to_secret.s42 + 0)
.s1013:
1f9b : d0 0b __ BNE $1fa8 ; (convert_path_to_secret.s43 + 0)
.s1010:
1f9d : a5 11 __ LDA P4 ; (y1 + 0)
1f9f : c5 13 __ CMP P6 ; (y2 + 0)
1fa1 : b0 05 __ BCS $1fa8 ; (convert_path_to_secret.s43 + 0)
.s42:
1fa3 : e6 11 __ INC P4 ; (y1 + 0)
1fa5 : 4c 4f 1f JMP $1f4f ; (convert_path_to_secret.l1 + 0)
.s43:
1fa8 : a5 13 __ LDA P6 ; (y2 + 0)
1faa : c5 11 __ CMP P4 ; (y1 + 0)
1fac : b0 a1 __ BCS $1f4f ; (convert_path_to_secret.l1 + 0)
.s45:
1fae : c6 11 __ DEC P4 ; (y1 + 0)
1fb0 : 90 9d __ BCC $1f4f ; (convert_path_to_secret.l1 + 0)
.s12:
1fb2 : 85 44 __ STA T0 + 1 
1fb4 : 4a __ __ LSR
1fb5 : aa __ __ TAX
1fb6 : a9 00 __ LDA #$00
1fb8 : 6a __ __ ROR
1fb9 : 85 45 __ STA T1 + 0 
1fbb : a9 00 __ LDA #$00
1fbd : 46 44 __ LSR T0 + 1 
1fbf : 6a __ __ ROR
1fc0 : 66 44 __ ROR T0 + 1 
1fc2 : 6a __ __ ROR
1fc3 : 65 45 __ ADC T1 + 0 
1fc5 : a8 __ __ TAY
1fc6 : 8a __ __ TXA
1fc7 : 65 44 __ ADC T0 + 1 
1fc9 : aa __ __ TAX
1fca : 98 __ __ TYA
1fcb : 18 __ __ CLC
1fcc : 65 10 __ ADC P3 ; (x1 + 0)
1fce : 90 01 __ BCC $1fd1 ; (convert_path_to_secret.s1037 + 0)
.s1036:
1fd0 : e8 __ __ INX
.s1037:
1fd1 : 18 __ __ CLC
1fd2 : 65 10 __ ADC P3 ; (x1 + 0)
1fd4 : 90 01 __ BCC $1fd7 ; (convert_path_to_secret.s1039 + 0)
.s1038:
1fd6 : e8 __ __ INX
.s1039:
1fd7 : 18 __ __ CLC
1fd8 : 65 10 __ ADC P3 ; (x1 + 0)
1fda : a8 __ __ TAY
1fdb : 8a __ __ TXA
1fdc : 69 00 __ ADC #$00
1fde : 4a __ __ LSR
1fdf : 85 46 __ STA T1 + 1 
1fe1 : 98 __ __ TYA
1fe2 : 6a __ __ ROR
1fe3 : 46 46 __ LSR T1 + 1 
1fe5 : 6a __ __ ROR
1fe6 : 46 46 __ LSR T1 + 1 
1fe8 : 6a __ __ ROR
1fe9 : 85 45 __ STA T1 + 0 
1feb : 18 __ __ CLC
1fec : a9 3a __ LDA #$3a
1fee : 65 46 __ ADC T1 + 1 
1ff0 : 85 46 __ STA T1 + 1 
1ff2 : 98 __ __ TYA
1ff3 : 29 07 __ AND #$07
1ff5 : 85 43 __ STA T0 + 0 
1ff7 : aa __ __ TAX
1ff8 : a0 20 __ LDY #$20
1ffa : b1 45 __ LDA (T1 + 0),y 
1ffc : e0 00 __ CPX #$00
1ffe : f0 04 __ BEQ $2004 ; (convert_path_to_secret.s1007 + 0)
.l1006:
2000 : 4a __ __ LSR
2001 : ca __ __ DEX
2002 : d0 fc __ BNE $2000 ; (convert_path_to_secret.l1006 + 0)
.s1007:
2004 : 85 1b __ STA ACCU + 0 
2006 : a5 43 __ LDA T0 + 0 
2008 : c9 06 __ CMP #$06
200a : b0 04 __ BCS $2010 ; (convert_path_to_secret.s18 + 0)
.s16:
200c : a5 1b __ LDA ACCU + 0 
200e : 90 18 __ BCC $2028 ; (convert_path_to_secret.s89 + 0)
.s18:
2010 : a9 08 __ LDA #$08
2012 : e5 43 __ SBC T0 + 0 
2014 : aa __ __ TAX
2015 : bd 24 36 LDA $3624,x ; (bitshift + 36)
2018 : 38 __ __ SEC
2019 : e9 01 __ SBC #$01
201b : c8 __ __ INY
201c : 31 45 __ AND (T1 + 0),y 
201e : e0 00 __ CPX #$00
2020 : f0 04 __ BEQ $2026 ; (convert_path_to_secret.s1009 + 0)
.l1024:
2022 : 0a __ __ ASL
2023 : ca __ __ DEX
2024 : d0 fc __ BNE $2022 ; (convert_path_to_secret.l1024 + 0)
.s1009:
2026 : 05 1b __ ORA ACCU + 0 
.s89:
2028 : 29 07 __ AND #$07
202a : c9 02 __ CMP #$02
202c : f0 07 __ BEQ $2035 ; (convert_path_to_secret.s5 + 0)
.s29:
202e : c9 03 __ CMP #$03
2030 : f0 03 __ BEQ $2035 ; (convert_path_to_secret.s5 + 0)
2032 : 4c 78 1f JMP $1f78 ; (convert_path_to_secret.s7 + 0)
.s5:
2035 : a5 10 __ LDA P3 ; (x1 + 0)
2037 : 85 0d __ STA P0 
2039 : a5 11 __ LDA P4 ; (y1 + 0)
203b : 85 0e __ STA P1 
203d : 20 1d 0f JSR $0f1d ; (set_compact_tile.s0 + 0)
2040 : 4c 78 1f JMP $1f78 ; (convert_path_to_secret.s7 + 0)
.s3:
2043 : a5 12 __ LDA P5 ; (x2 + 0)
2045 : c9 40 __ CMP #$40
2047 : 90 01 __ BCC $204a ; (convert_path_to_secret.s55 + 0)
2049 : 60 __ __ RTS
.s55:
204a : a5 13 __ LDA P6 ; (y2 + 0)
204c : c9 40 __ CMP #$40
204e : b0 7c __ BCS $20cc ; (convert_path_to_secret.s1001 + 0)
.s54:
2050 : 85 46 __ STA T1 + 1 
2052 : 4a __ __ LSR
2053 : aa __ __ TAX
2054 : a9 00 __ LDA #$00
2056 : 6a __ __ ROR
2057 : 85 43 __ STA T0 + 0 
2059 : a9 00 __ LDA #$00
205b : 46 46 __ LSR T1 + 1 
205d : 6a __ __ ROR
205e : 66 46 __ ROR T1 + 1 
2060 : 6a __ __ ROR
2061 : 65 43 __ ADC T0 + 0 
2063 : a8 __ __ TAY
2064 : 8a __ __ TXA
2065 : 65 46 __ ADC T1 + 1 
2067 : aa __ __ TAX
2068 : 98 __ __ TYA
2069 : 18 __ __ CLC
206a : 65 12 __ ADC P5 ; (x2 + 0)
206c : 90 01 __ BCC $206f ; (convert_path_to_secret.s1041 + 0)
.s1040:
206e : e8 __ __ INX
.s1041:
206f : 18 __ __ CLC
2070 : 65 12 __ ADC P5 ; (x2 + 0)
2072 : 90 01 __ BCC $2075 ; (convert_path_to_secret.s1043 + 0)
.s1042:
2074 : e8 __ __ INX
.s1043:
2075 : 18 __ __ CLC
2076 : 65 12 __ ADC P5 ; (x2 + 0)
2078 : a8 __ __ TAY
2079 : 8a __ __ TXA
207a : 69 00 __ ADC #$00
207c : 4a __ __ LSR
207d : 85 46 __ STA T1 + 1 
207f : 98 __ __ TYA
2080 : 6a __ __ ROR
2081 : 46 46 __ LSR T1 + 1 
2083 : 6a __ __ ROR
2084 : 46 46 __ LSR T1 + 1 
2086 : 6a __ __ ROR
2087 : 85 45 __ STA T1 + 0 
2089 : 18 __ __ CLC
208a : a9 3a __ LDA #$3a
208c : 65 46 __ ADC T1 + 1 
208e : 85 46 __ STA T1 + 1 
2090 : 98 __ __ TYA
2091 : 29 07 __ AND #$07
2093 : 85 43 __ STA T0 + 0 
2095 : aa __ __ TAX
2096 : a0 20 __ LDY #$20
2098 : b1 45 __ LDA (T1 + 0),y 
209a : e0 00 __ CPX #$00
209c : f0 04 __ BEQ $20a2 ; (convert_path_to_secret.s1003 + 0)
.l1002:
209e : 4a __ __ LSR
209f : ca __ __ DEX
20a0 : d0 fc __ BNE $209e ; (convert_path_to_secret.l1002 + 0)
.s1003:
20a2 : 85 1b __ STA ACCU + 0 
20a4 : a5 43 __ LDA T0 + 0 
20a6 : c9 06 __ CMP #$06
20a8 : b0 04 __ BCS $20ae ; (convert_path_to_secret.s60 + 0)
.s58:
20aa : a5 1b __ LDA ACCU + 0 
20ac : 90 18 __ BCC $20c6 ; (convert_path_to_secret.s94 + 0)
.s60:
20ae : a9 08 __ LDA #$08
20b0 : e5 43 __ SBC T0 + 0 
20b2 : aa __ __ TAX
20b3 : bd 24 36 LDA $3624,x ; (bitshift + 36)
20b6 : 38 __ __ SEC
20b7 : e9 01 __ SBC #$01
20b9 : c8 __ __ INY
20ba : 31 45 __ AND (T1 + 0),y 
20bc : e0 00 __ CPX #$00
20be : f0 04 __ BEQ $20c4 ; (convert_path_to_secret.s1005 + 0)
.l1026:
20c0 : 0a __ __ ASL
20c1 : ca __ __ DEX
20c2 : d0 fc __ BNE $20c0 ; (convert_path_to_secret.l1026 + 0)
.s1005:
20c4 : 05 1b __ ORA ACCU + 0 
.s94:
20c6 : 29 07 __ AND #$07
20c8 : c9 03 __ CMP #$03
20ca : f0 01 __ BEQ $20cd ; (convert_path_to_secret.s48 + 0)
.s1001:
20cc : 60 __ __ RTS
.s48:
20cd : a5 12 __ LDA P5 ; (x2 + 0)
20cf : 85 0d __ STA P0 
20d1 : a5 13 __ LDA P6 ; (y2 + 0)
20d3 : 85 0e __ STA P1 
20d5 : a9 06 __ LDA #$06
20d7 : 85 0f __ STA P2 
20d9 : 4c 1d 0f JMP $0f1d ; (set_compact_tile.s0 + 0)
--------------------------------------------------------------------
20dc : __ __ __ BYT 53 00                                           : S.
--------------------------------------------------------------------
add_stairs: ; add_stairs()->void
.s0:
20de : a9 00 __ LDA #$00
20e0 : 85 0e __ STA P1 
20e2 : a9 23 __ LDA #$23
20e4 : 85 0f __ STA P2 
20e6 : 20 1f 0a JSR $0a1f ; (print_text.s0 + 0)
20e9 : ad e8 35 LDA $35e8 ; (room_count + 0)
20ec : c9 02 __ CMP #$02
20ee : b0 01 __ BCS $20f1 ; (add_stairs.s3 + 0)
20f0 : 60 __ __ RTS
.s3:
20f1 : 85 4c __ STA T7 + 0 
20f3 : e9 01 __ SBC #$01
20f5 : 85 4a __ STA T4 + 0 
20f7 : a9 00 __ LDA #$00
20f9 : 85 49 __ STA T3 + 0 
20fb : 85 47 __ STA T1 + 0 
20fd : 85 4d __ STA T8 + 0 
20ff : 85 4b __ STA T5 + 0 
2101 : a9 fe __ LDA #$fe
2103 : 85 0e __ STA P1 
2105 : a9 0b __ LDA #$0b
2107 : 85 0f __ STA P2 
.l6:
2109 : a5 47 __ LDA T1 + 0 
210b : 29 03 __ AND #$03
210d : d0 03 __ BNE $2112 ; (add_stairs.s11 + 0)
.s9:
210f : 20 1f 0a JSR $0a1f ; (print_text.s0 + 0)
.s11:
2112 : a5 47 __ LDA T1 + 0 
2114 : 85 1b __ STA ACCU + 0 
2116 : a9 00 __ LDA #$00
2118 : 85 1c __ STA ACCU + 1 
211a : a9 1d __ LDA #$1d
211c : 20 19 35 JSR $3519 ; (mul16by8 + 0)
211f : a9 27 __ LDA #$27
2121 : 85 43 __ STA T0 + 0 
2123 : 18 __ __ CLC
2124 : a9 40 __ LDA #$40
2126 : 65 1c __ ADC ACCU + 1 
2128 : 85 44 __ STA T0 + 1 
212a : a5 4b __ LDA T5 + 0 
212c : a4 1b __ LDY ACCU + 0 
212e : d1 43 __ CMP (T0 + 0),y 
2130 : b0 08 __ BCS $213a ; (add_stairs.s5 + 0)
.s12:
2132 : b1 43 __ LDA (T0 + 0),y 
2134 : 85 4b __ STA T5 + 0 
2136 : a5 49 __ LDA T3 + 0 
2138 : 85 4d __ STA T8 + 0 
.s5:
213a : e6 47 __ INC T1 + 0 
213c : e6 49 __ INC T3 + 0 
213e : a5 49 __ LDA T3 + 0 
2140 : c5 4c __ CMP T7 + 0 
2142 : 90 c5 __ BCC $2109 ; (add_stairs.l6 + 0)
.s98:
2144 : a9 00 __ LDA #$00
2146 : 85 49 __ STA T3 + 0 
2148 : 85 47 __ STA T1 + 0 
214a : 85 4b __ STA T5 + 0 
214c : a9 fe __ LDA #$fe
214e : 85 0e __ STA P1 
2150 : a9 0b __ LDA #$0b
2152 : 85 0f __ STA P2 
.l16:
2154 : a5 47 __ LDA T1 + 0 
2156 : 29 03 __ AND #$03
2158 : d0 03 __ BNE $215d ; (add_stairs.s21 + 0)
.s19:
215a : 20 1f 0a JSR $0a1f ; (print_text.s0 + 0)
.s21:
215d : a5 49 __ LDA T3 + 0 
215f : c5 4d __ CMP T8 + 0 
2161 : f0 28 __ BEQ $218b ; (add_stairs.s15 + 0)
.s25:
2163 : a5 47 __ LDA T1 + 0 
2165 : 85 1b __ STA ACCU + 0 
2167 : a9 00 __ LDA #$00
2169 : 85 1c __ STA ACCU + 1 
216b : a9 1d __ LDA #$1d
216d : 20 19 35 JSR $3519 ; (mul16by8 + 0)
2170 : a9 27 __ LDA #$27
2172 : 85 43 __ STA T0 + 0 
2174 : 18 __ __ CLC
2175 : a9 40 __ LDA #$40
2177 : 65 1c __ ADC ACCU + 1 
2179 : 85 44 __ STA T0 + 1 
217b : a5 4b __ LDA T5 + 0 
217d : a4 1b __ LDY ACCU + 0 
217f : d1 43 __ CMP (T0 + 0),y 
2181 : b0 08 __ BCS $218b ; (add_stairs.s15 + 0)
.s22:
2183 : b1 43 __ LDA (T0 + 0),y 
2185 : 85 4b __ STA T5 + 0 
2187 : a5 49 __ LDA T3 + 0 
2189 : 85 4a __ STA T4 + 0 
.s15:
218b : e6 47 __ INC T1 + 0 
218d : e6 49 __ INC T3 + 0 
218f : a5 49 __ LDA T3 + 0 
2191 : c5 4c __ CMP T7 + 0 
2193 : 90 bf __ BCC $2154 ; (add_stairs.l16 + 0)
.s18:
2195 : ad e9 35 LDA $35e9 ; (room_center_cache_valid + 0)
2198 : 85 4e __ STA T9 + 0 
219a : d0 04 __ BNE $21a0 ; (add_stairs.s30 + 0)
.s1003:
219c : a5 4d __ LDA T8 + 0 
219e : b0 15 __ BCS $21b5 ; (add_stairs.s27 + 0)
.s30:
21a0 : a5 4d __ LDA T8 + 0 
21a2 : c9 14 __ CMP #$14
21a4 : b0 0f __ BCS $21b5 ; (add_stairs.s27 + 0)
.s29:
21a6 : 0a __ __ ASL
21a7 : aa __ __ TAX
21a8 : bd 64 42 LDA $4264,x ; (room_center_cache + 0)
21ab : 85 0d __ STA P0 
21ad : bc 65 42 LDY $4265,x ; (room_center_cache + 1)
21b0 : 84 0e __ STY P1 
21b2 : 4c 34 22 JMP $2234 ; (add_stairs.s26 + 0)
.s27:
21b5 : 85 43 __ STA T0 + 0 
21b7 : c5 4c __ CMP T7 + 0 
21b9 : 90 06 __ BCC $21c1 ; (add_stairs.s34 + 0)
.s32:
21bb : a9 00 __ LDA #$00
21bd : 85 45 __ STA T2 + 0 
21bf : b0 59 __ BCS $221a ; (add_stairs.s37 + 0)
.s34:
21c1 : 85 1b __ STA ACCU + 0 
21c3 : a9 00 __ LDA #$00
21c5 : 85 1c __ STA ACCU + 1 
21c7 : a9 1d __ LDA #$1d
21c9 : 20 19 35 JSR $3519 ; (mul16by8 + 0)
21cc : 18 __ __ CLC
21cd : a9 20 __ LDA #$20
21cf : 65 1b __ ADC ACCU + 0 
21d1 : 85 47 __ STA T1 + 0 
21d3 : a9 40 __ LDA #$40
21d5 : 65 1c __ ADC ACCU + 1 
21d7 : 85 48 __ STA T1 + 1 
21d9 : a0 03 __ LDY #$03
21db : b1 47 __ LDA (T1 + 0),y 
21dd : 38 __ __ SEC
21de : e9 01 __ SBC #$01
21e0 : a8 __ __ TAY
21e1 : a9 00 __ LDA #$00
21e3 : e9 00 __ SBC #$00
21e5 : aa __ __ TAX
21e6 : 0a __ __ ASL
21e7 : 98 __ __ TYA
21e8 : 69 00 __ ADC #$00
21ea : 85 45 __ STA T2 + 0 
21ec : 8a __ __ TXA
21ed : 69 00 __ ADC #$00
21ef : 4a __ __ LSR
21f0 : 66 45 __ ROR T2 + 0 
21f2 : a0 01 __ LDY #$01
21f4 : b1 47 __ LDA (T1 + 0),y 
21f6 : 18 __ __ CLC
21f7 : 65 45 __ ADC T2 + 0 
21f9 : 85 45 __ STA T2 + 0 
21fb : c8 __ __ INY
21fc : b1 47 __ LDA (T1 + 0),y 
21fe : 38 __ __ SEC
21ff : e9 01 __ SBC #$01
2201 : a8 __ __ TAY
2202 : a9 00 __ LDA #$00
2204 : e9 00 __ SBC #$00
2206 : aa __ __ TAX
2207 : 0a __ __ ASL
2208 : 98 __ __ TYA
2209 : 69 00 __ ADC #$00
220b : 85 49 __ STA T3 + 0 
220d : 8a __ __ TXA
220e : 69 00 __ ADC #$00
2210 : 4a __ __ LSR
2211 : 66 49 __ ROR T3 + 0 
2213 : a0 00 __ LDY #$00
2215 : b1 47 __ LDA (T1 + 0),y 
2217 : 18 __ __ CLC
2218 : 65 49 __ ADC T3 + 0 
.s37:
221a : 85 0d __ STA P0 
221c : aa __ __ TAX
221d : a5 4d __ LDA T8 + 0 
221f : c9 14 __ CMP #$14
2221 : a4 45 __ LDY T2 + 0 
2223 : 84 0e __ STY P1 
2225 : b0 0d __ BCS $2234 ; (add_stairs.s26 + 0)
.s43:
2227 : 06 43 __ ASL T0 + 0 
2229 : 8a __ __ TXA
222a : a6 43 __ LDX T0 + 0 
222c : 9d 64 42 STA $4264,x ; (room_center_cache + 0)
222f : a5 0e __ LDA P1 
2231 : 9d 65 42 STA $4265,x ; (room_center_cache + 1)
.s26:
2234 : a5 0d __ LDA P0 
2236 : c9 40 __ CMP #$40
2238 : b0 0b __ BCS $2245 ; (add_stairs.s49 + 0)
.s56:
223a : c0 40 __ CPY #$40
223c : b0 07 __ BCS $2245 ; (add_stairs.s49 + 0)
.s55:
223e : a9 04 __ LDA #$04
2240 : 85 0f __ STA P2 
2242 : 20 1d 0f JSR $0f1d ; (set_compact_tile.s0 + 0)
.s49:
2245 : a5 4e __ LDA T9 + 0 
2247 : d0 05 __ BNE $224e ; (add_stairs.s63 + 0)
.s1002:
2249 : a5 4a __ LDA T4 + 0 
224b : 4c 63 22 JMP $2263 ; (add_stairs.s60 + 0)
.s63:
224e : a5 4a __ LDA T4 + 0 
2250 : c9 14 __ CMP #$14
2252 : b0 0f __ BCS $2263 ; (add_stairs.s60 + 0)
.s62:
2254 : 0a __ __ ASL
2255 : aa __ __ TAX
2256 : bd 64 42 LDA $4264,x ; (room_center_cache + 0)
2259 : 85 0d __ STA P0 
225b : bc 65 42 LDY $4265,x ; (room_center_cache + 1)
225e : 84 0e __ STY P1 
2260 : 4c e2 22 JMP $22e2 ; (add_stairs.s59 + 0)
.s60:
2263 : 85 43 __ STA T0 + 0 
2265 : c5 4c __ CMP T7 + 0 
2267 : 90 06 __ BCC $226f ; (add_stairs.s67 + 0)
.s65:
2269 : a9 00 __ LDA #$00
226b : 85 45 __ STA T2 + 0 
226d : b0 59 __ BCS $22c8 ; (add_stairs.s70 + 0)
.s67:
226f : 85 1b __ STA ACCU + 0 
2271 : a9 00 __ LDA #$00
2273 : 85 1c __ STA ACCU + 1 
2275 : a9 1d __ LDA #$1d
2277 : 20 19 35 JSR $3519 ; (mul16by8 + 0)
227a : 18 __ __ CLC
227b : a9 20 __ LDA #$20
227d : 65 1b __ ADC ACCU + 0 
227f : 85 47 __ STA T1 + 0 
2281 : a9 40 __ LDA #$40
2283 : 65 1c __ ADC ACCU + 1 
2285 : 85 48 __ STA T1 + 1 
2287 : a0 03 __ LDY #$03
2289 : b1 47 __ LDA (T1 + 0),y 
228b : 38 __ __ SEC
228c : e9 01 __ SBC #$01
228e : a8 __ __ TAY
228f : a9 00 __ LDA #$00
2291 : e9 00 __ SBC #$00
2293 : aa __ __ TAX
2294 : 0a __ __ ASL
2295 : 98 __ __ TYA
2296 : 69 00 __ ADC #$00
2298 : 85 45 __ STA T2 + 0 
229a : 8a __ __ TXA
229b : 69 00 __ ADC #$00
229d : 4a __ __ LSR
229e : 66 45 __ ROR T2 + 0 
22a0 : a0 01 __ LDY #$01
22a2 : b1 47 __ LDA (T1 + 0),y 
22a4 : 18 __ __ CLC
22a5 : 65 45 __ ADC T2 + 0 
22a7 : 85 45 __ STA T2 + 0 
22a9 : c8 __ __ INY
22aa : b1 47 __ LDA (T1 + 0),y 
22ac : 38 __ __ SEC
22ad : e9 01 __ SBC #$01
22af : a8 __ __ TAY
22b0 : a9 00 __ LDA #$00
22b2 : e9 00 __ SBC #$00
22b4 : aa __ __ TAX
22b5 : 0a __ __ ASL
22b6 : 98 __ __ TYA
22b7 : 69 00 __ ADC #$00
22b9 : 85 49 __ STA T3 + 0 
22bb : 8a __ __ TXA
22bc : 69 00 __ ADC #$00
22be : 4a __ __ LSR
22bf : 66 49 __ ROR T3 + 0 
22c1 : a0 00 __ LDY #$00
22c3 : b1 47 __ LDA (T1 + 0),y 
22c5 : 18 __ __ CLC
22c6 : 65 49 __ ADC T3 + 0 
.s70:
22c8 : 85 0d __ STA P0 
22ca : aa __ __ TAX
22cb : a5 4a __ LDA T4 + 0 
22cd : c9 14 __ CMP #$14
22cf : a4 45 __ LDY T2 + 0 
22d1 : 84 0e __ STY P1 
22d3 : b0 0d __ BCS $22e2 ; (add_stairs.s59 + 0)
.s76:
22d5 : 06 43 __ ASL T0 + 0 
22d7 : 8a __ __ TXA
22d8 : a6 43 __ LDX T0 + 0 
22da : 9d 64 42 STA $4264,x ; (room_center_cache + 0)
22dd : a5 0e __ LDA P1 
22df : 9d 65 42 STA $4265,x ; (room_center_cache + 1)
.s59:
22e2 : a5 0d __ LDA P0 
22e4 : c9 40 __ CMP #$40
22e6 : b0 04 __ BCS $22ec ; (add_stairs.s1001 + 0)
.s89:
22e8 : c0 40 __ CPY #$40
22ea : 90 01 __ BCC $22ed ; (add_stairs.s88 + 0)
.s1001:
22ec : 60 __ __ RTS
.s88:
22ed : a9 05 __ LDA #$05
22ef : 85 0f __ STA P2 
22f1 : 4c 1d 0f JMP $0f1d ; (set_compact_tile.s0 + 0)
--------------------------------------------------------------------
getch: ; getch()->u8
.l1:
22f4 : 20 e4 ff JSR $ffe4 
22f7 : 85 1b __ STA ACCU + 0 
22f9 : a5 1b __ LDA ACCU + 0 
22fb : f0 f7 __ BEQ $22f4 ; (getch.l1 + 0)
.s2:
22fd : 4c a0 33 JMP $33a0 ; (convch.s0 + 0)
--------------------------------------------------------------------
2300 : __ __ __ BYT 0a 0a 50 6c 61 63 69 6e 67 20 73 74 61 69 72 73 : ..Placing stairs
2310 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
add_walls: ; add_walls()->void
.s1000:
2311 : a2 05 __ LDX #$05
2313 : b5 53 __ LDA T12 + 0,x 
2315 : 9d e8 9f STA $9fe8,x ; (connect_rooms@stack + 7)
2318 : ca __ __ DEX
2319 : 10 f8 __ BPL $2313 ; (add_walls.s1000 + 2)
.s0:
231b : a9 b2 __ LDA #$b2
231d : 85 0e __ STA P1 
231f : a9 2d __ LDA #$2d
2321 : 85 0f __ STA P2 
2323 : 20 1f 0a JSR $0a1f ; (print_text.s0 + 0)
2326 : a9 00 __ LDA #$00
2328 : 85 54 __ STA T13 + 0 
232a : 85 47 __ STA T4 + 0 
.l2:
232c : a5 47 __ LDA T4 + 0 
232e : 85 46 __ STA T1 + 1 
2330 : 4a __ __ LSR
2331 : aa __ __ TAX
2332 : a9 00 __ LDA #$00
2334 : 6a __ __ ROR
2335 : 85 43 __ STA T0 + 0 
2337 : a9 00 __ LDA #$00
2339 : 46 46 __ LSR T1 + 1 
233b : 6a __ __ ROR
233c : 66 46 __ ROR T1 + 1 
233e : 6a __ __ ROR
233f : 65 43 __ ADC T0 + 0 
2341 : 85 48 __ STA T5 + 0 
2343 : 85 4a __ STA T6 + 0 
2345 : 8a __ __ TXA
2346 : 65 46 __ ADC T1 + 1 
2348 : 85 49 __ STA T5 + 1 
234a : 85 4b __ STA T6 + 1 
234c : a9 00 __ LDA #$00
234e : 85 55 __ STA T14 + 0 
2350 : 85 4c __ STA T7 + 0 
2352 : 18 __ __ CLC
.l9:
2353 : a5 4a __ LDA T6 + 0 
2355 : 65 4c __ ADC T7 + 0 
2357 : a4 4b __ LDY T6 + 1 
2359 : 90 01 __ BCC $235c ; (add_walls.s1201 + 0)
.s1200:
235b : c8 __ __ INY
.s1201:
235c : 18 __ __ CLC
235d : 65 4c __ ADC T7 + 0 
235f : aa __ __ TAX
2360 : 98 __ __ TYA
2361 : 69 00 __ ADC #$00
2363 : 4a __ __ LSR
2364 : 85 46 __ STA T1 + 1 
2366 : 8a __ __ TXA
2367 : 6a __ __ ROR
2368 : 46 46 __ LSR T1 + 1 
236a : 6a __ __ ROR
236b : 46 46 __ LSR T1 + 1 
236d : 6a __ __ ROR
236e : 85 45 __ STA T1 + 0 
2370 : 18 __ __ CLC
2371 : a9 3a __ LDA #$3a
2373 : 65 46 __ ADC T1 + 1 
2375 : 85 46 __ STA T1 + 1 
2377 : 8a __ __ TXA
2378 : 29 07 __ AND #$07
237a : 85 43 __ STA T0 + 0 
237c : aa __ __ TAX
237d : a0 20 __ LDY #$20
237f : b1 45 __ LDA (T1 + 0),y 
2381 : e0 00 __ CPX #$00
2383 : f0 04 __ BEQ $2389 ; (add_walls.s1003 + 0)
.l1002:
2385 : 4a __ __ LSR
2386 : ca __ __ DEX
2387 : d0 fc __ BNE $2385 ; (add_walls.l1002 + 0)
.s1003:
2389 : 85 1b __ STA ACCU + 0 
238b : a5 43 __ LDA T0 + 0 
238d : c9 06 __ CMP #$06
238f : b0 04 __ BCS $2395 ; (add_walls.s20 + 0)
.s18:
2391 : a5 1b __ LDA ACCU + 0 
2393 : 90 18 __ BCC $23ad ; (add_walls.s11 + 0)
.s20:
2395 : a9 08 __ LDA #$08
2397 : e5 43 __ SBC T0 + 0 
2399 : aa __ __ TAX
239a : bd 24 36 LDA $3624,x ; (bitshift + 36)
239d : 38 __ __ SEC
239e : e9 01 __ SBC #$01
23a0 : c8 __ __ INY
23a1 : 31 45 __ AND (T1 + 0),y 
23a3 : e0 00 __ CPX #$00
23a5 : f0 04 __ BEQ $23ab ; (add_walls.s1005 + 0)
.l1092:
23a7 : 0a __ __ ASL
23a8 : ca __ __ DEX
23a9 : d0 fc __ BNE $23a7 ; (add_walls.l1092 + 0)
.s1005:
23ab : 05 1b __ ORA ACCU + 0 
.s11:
23ad : 29 07 __ AND #$07
23af : 20 c2 2d JSR $2dc2 ; (is_walkable_tile.s0 + 0)
23b2 : aa __ __ TAX
23b3 : f0 03 __ BEQ $23b8 ; (add_walls.s163 + 0)
23b5 : 4c 0d 29 JMP $290d ; (add_walls.s24 + 0)
.s163:
23b8 : 18 __ __ CLC
23b9 : a5 55 __ LDA T14 + 0 
23bb : 69 01 __ ADC #$01
23bd : 85 53 __ STA T12 + 0 
23bf : 85 4d __ STA T8 + 0 
23c1 : 18 __ __ CLC
23c2 : 65 48 __ ADC T5 + 0 
23c4 : a4 49 __ LDY T5 + 1 
23c6 : 90 01 __ BCC $23c9 ; (add_walls.s1207 + 0)
.s1206:
23c8 : c8 __ __ INY
.s1207:
23c9 : 18 __ __ CLC
23ca : 65 53 __ ADC T12 + 0 
23cc : 90 01 __ BCC $23cf ; (add_walls.s1209 + 0)
.s1208:
23ce : c8 __ __ INY
.s1209:
23cf : 18 __ __ CLC
23d0 : 65 53 __ ADC T12 + 0 
23d2 : aa __ __ TAX
23d3 : 98 __ __ TYA
23d4 : 69 00 __ ADC #$00
23d6 : 4a __ __ LSR
23d7 : 85 46 __ STA T1 + 1 
23d9 : 8a __ __ TXA
23da : 6a __ __ ROR
23db : 46 46 __ LSR T1 + 1 
23dd : 6a __ __ ROR
23de : 46 46 __ LSR T1 + 1 
23e0 : 6a __ __ ROR
23e1 : 85 45 __ STA T1 + 0 
23e3 : 18 __ __ CLC
23e4 : a9 3a __ LDA #$3a
23e6 : 65 46 __ ADC T1 + 1 
23e8 : 85 46 __ STA T1 + 1 
23ea : 8a __ __ TXA
23eb : 29 07 __ AND #$07
23ed : 85 43 __ STA T0 + 0 
23ef : aa __ __ TAX
23f0 : a0 20 __ LDY #$20
23f2 : b1 45 __ LDA (T1 + 0),y 
23f4 : e0 00 __ CPX #$00
23f6 : f0 04 __ BEQ $23fc ; (add_walls.s1007 + 0)
.l1006:
23f8 : 4a __ __ LSR
23f9 : ca __ __ DEX
23fa : d0 fc __ BNE $23f8 ; (add_walls.l1006 + 0)
.s1007:
23fc : 85 1b __ STA ACCU + 0 
23fe : a5 43 __ LDA T0 + 0 
2400 : c9 06 __ CMP #$06
2402 : b0 04 __ BCS $2408 ; (add_walls.s174 + 0)
.s172:
2404 : a5 1b __ LDA ACCU + 0 
2406 : 90 18 __ BCC $2420 ; (add_walls.s165 + 0)
.s174:
2408 : a9 08 __ LDA #$08
240a : e5 43 __ SBC T0 + 0 
240c : aa __ __ TAX
240d : bd 24 36 LDA $3624,x ; (bitshift + 36)
2410 : 38 __ __ SEC
2411 : e9 01 __ SBC #$01
2413 : c8 __ __ INY
2414 : 31 45 __ AND (T1 + 0),y 
2416 : e0 00 __ CPX #$00
2418 : f0 04 __ BEQ $241e ; (add_walls.s1009 + 0)
.l1096:
241a : 0a __ __ ASL
241b : ca __ __ DEX
241c : d0 fc __ BNE $241a ; (add_walls.l1096 + 0)
.s1009:
241e : 05 1b __ ORA ACCU + 0 
.s165:
2420 : 29 07 __ AND #$07
2422 : 20 c2 2d JSR $2dc2 ; (is_walkable_tile.s0 + 0)
2425 : aa __ __ TAX
2426 : d0 46 __ BNE $246e ; (add_walls.s178 + 0)
.s5:
2428 : 18 __ __ CLC
2429 : a5 4a __ LDA T6 + 0 
242b : 69 02 __ ADC #$02
242d : 85 4a __ STA T6 + 0 
242f : 90 02 __ BCC $2433 ; (add_walls.s1215 + 0)
.s1214:
2431 : e6 4b __ INC T6 + 1 
.s1215:
2433 : e6 4c __ INC T7 + 0 
2435 : e6 4c __ INC T7 + 0 
2437 : 18 __ __ CLC
2438 : a5 53 __ LDA T12 + 0 
243a : 69 01 __ ADC #$01
243c : 85 55 __ STA T14 + 0 
243e : c9 3f __ CMP #$3f
2440 : b0 03 __ BCS $2445 ; (add_walls.s8 + 0)
2442 : 4c 53 23 JMP $2353 ; (add_walls.l9 + 0)
.s8:
2445 : a5 47 __ LDA T4 + 0 
2447 : 29 07 __ AND #$07
2449 : d0 0b __ BNE $2456 ; (add_walls.s1 + 0)
.s317:
244b : a9 fe __ LDA #$fe
244d : 85 0e __ STA P1 
244f : a9 0b __ LDA #$0b
2451 : 85 0f __ STA P2 
2453 : 20 1f 0a JSR $0a1f ; (print_text.s0 + 0)
.s1:
2456 : e6 47 __ INC T4 + 0 
2458 : e6 54 __ INC T13 + 0 
245a : a5 54 __ LDA T13 + 0 
245c : c9 40 __ CMP #$40
245e : b0 03 __ BCS $2463 ; (add_walls.s1001 + 0)
2460 : 4c 2c 23 JMP $232c ; (add_walls.l2 + 0)
.s1001:
2463 : a2 05 __ LDX #$05
2465 : bd e8 9f LDA $9fe8,x ; (connect_rooms@stack + 7)
2468 : 95 53 __ STA T12 + 0,x 
246a : ca __ __ DEX
246b : 10 f8 __ BPL $2465 ; (add_walls.s1001 + 2)
246d : 60 __ __ RTS
.s178:
246e : 38 __ __ SEC
246f : a5 47 __ LDA T4 + 0 
2471 : e9 01 __ SBC #$01
2473 : 85 4f __ STA T9 + 0 
2475 : a9 00 __ LDA #$00
2477 : e9 00 __ SBC #$00
2479 : 85 50 __ STA T9 + 1 
247b : a5 4f __ LDA T9 + 0 
247d : c9 40 __ CMP #$40
247f : a9 00 __ LDA #$00
2481 : 2a __ __ ROL
2482 : 85 55 __ STA T14 + 0 
2484 : f0 03 __ BEQ $2489 ; (add_walls.s187 + 0)
2486 : 4c 0b 25 JMP $250b ; (add_walls.s181 + 0)
.s187:
2489 : a5 50 __ LDA T9 + 1 
248b : 4a __ __ LSR
248c : a5 4f __ LDA T9 + 0 
248e : 85 46 __ STA T1 + 1 
2490 : 6a __ __ ROR
2491 : aa __ __ TAX
2492 : a9 00 __ LDA #$00
2494 : 6a __ __ ROR
2495 : 85 43 __ STA T0 + 0 
2497 : a5 50 __ LDA T9 + 1 
2499 : 4a __ __ LSR
249a : 66 46 __ ROR T1 + 1 
249c : 6a __ __ ROR
249d : 66 46 __ ROR T1 + 1 
249f : 29 80 __ AND #$80
24a1 : 6a __ __ ROR
24a2 : 65 43 __ ADC T0 + 0 
24a4 : a8 __ __ TAY
24a5 : 8a __ __ TXA
24a6 : 65 46 __ ADC T1 + 1 
24a8 : aa __ __ TAX
24a9 : 98 __ __ TYA
24aa : 18 __ __ CLC
24ab : 65 53 __ ADC T12 + 0 
24ad : 90 01 __ BCC $24b0 ; (add_walls.s1241 + 0)
.s1240:
24af : e8 __ __ INX
.s1241:
24b0 : 18 __ __ CLC
24b1 : 65 53 __ ADC T12 + 0 
24b3 : 90 01 __ BCC $24b6 ; (add_walls.s1243 + 0)
.s1242:
24b5 : e8 __ __ INX
.s1243:
24b6 : 18 __ __ CLC
24b7 : 65 53 __ ADC T12 + 0 
24b9 : a8 __ __ TAY
24ba : 8a __ __ TXA
24bb : 69 00 __ ADC #$00
24bd : 4a __ __ LSR
24be : 85 46 __ STA T1 + 1 
24c0 : 98 __ __ TYA
24c1 : 6a __ __ ROR
24c2 : 46 46 __ LSR T1 + 1 
24c4 : 6a __ __ ROR
24c5 : 46 46 __ LSR T1 + 1 
24c7 : 6a __ __ ROR
24c8 : 85 45 __ STA T1 + 0 
24ca : 18 __ __ CLC
24cb : a9 3a __ LDA #$3a
24cd : 65 46 __ ADC T1 + 1 
24cf : 85 46 __ STA T1 + 1 
24d1 : 98 __ __ TYA
24d2 : 29 07 __ AND #$07
24d4 : 85 43 __ STA T0 + 0 
24d6 : aa __ __ TAX
24d7 : a0 20 __ LDY #$20
24d9 : b1 45 __ LDA (T1 + 0),y 
24db : e0 00 __ CPX #$00
24dd : f0 04 __ BEQ $24e3 ; (add_walls.s1014 + 0)
.l1013:
24df : 4a __ __ LSR
24e0 : ca __ __ DEX
24e1 : d0 fc __ BNE $24df ; (add_walls.l1013 + 0)
.s1014:
24e3 : 85 1b __ STA ACCU + 0 
24e5 : a5 43 __ LDA T0 + 0 
24e7 : c9 06 __ CMP #$06
24e9 : b0 04 __ BCS $24ef ; (add_walls.s193 + 0)
.s191:
24eb : a5 1b __ LDA ACCU + 0 
24ed : 90 18 __ BCC $2507 ; (add_walls.s399 + 0)
.s193:
24ef : a9 08 __ LDA #$08
24f1 : e5 43 __ SBC T0 + 0 
24f3 : aa __ __ TAX
24f4 : bd 24 36 LDA $3624,x ; (bitshift + 36)
24f7 : 38 __ __ SEC
24f8 : e9 01 __ SBC #$01
24fa : c8 __ __ INY
24fb : 31 45 __ AND (T1 + 0),y 
24fd : e0 00 __ CPX #$00
24ff : f0 04 __ BEQ $2505 ; (add_walls.s1016 + 0)
.l1112:
2501 : 0a __ __ ASL
2502 : ca __ __ DEX
2503 : d0 fc __ BNE $2501 ; (add_walls.l1112 + 0)
.s1016:
2505 : 05 1b __ ORA ACCU + 0 
.s399:
2507 : 29 07 __ AND #$07
2509 : d0 0f __ BNE $251a ; (add_walls.s183 + 0)
.s181:
250b : a5 53 __ LDA T12 + 0 
250d : 85 0d __ STA P0 
250f : a5 4f __ LDA T9 + 0 
2511 : 85 0e __ STA P1 
2513 : a9 01 __ LDA #$01
2515 : 85 0f __ STA P2 
2517 : 20 1d 0f JSR $0f1d ; (set_compact_tile.s0 + 0)
.s183:
251a : 18 __ __ CLC
251b : a5 47 __ LDA T4 + 0 
251d : 69 01 __ ADC #$01
251f : 85 51 __ STA T10 + 0 
2521 : c9 40 __ CMP #$40
2523 : a9 00 __ LDA #$00
2525 : 2a __ __ ROL
2526 : 85 56 __ STA T15 + 0 
2528 : d0 7c __ BNE $25a6 ; (add_walls.s198 + 0)
.s204:
252a : a5 51 __ LDA T10 + 0 
252c : 85 46 __ STA T1 + 1 
252e : 4a __ __ LSR
252f : aa __ __ TAX
2530 : a9 00 __ LDA #$00
2532 : 6a __ __ ROR
2533 : 85 43 __ STA T0 + 0 
2535 : a9 00 __ LDA #$00
2537 : 46 46 __ LSR T1 + 1 
2539 : 6a __ __ ROR
253a : 66 46 __ ROR T1 + 1 
253c : 6a __ __ ROR
253d : 65 43 __ ADC T0 + 0 
253f : a8 __ __ TAY
2540 : 8a __ __ TXA
2541 : 65 46 __ ADC T1 + 1 
2543 : aa __ __ TAX
2544 : 98 __ __ TYA
2545 : 18 __ __ CLC
2546 : 65 53 __ ADC T12 + 0 
2548 : 90 01 __ BCC $254b ; (add_walls.s1237 + 0)
.s1236:
254a : e8 __ __ INX
.s1237:
254b : 18 __ __ CLC
254c : 65 53 __ ADC T12 + 0 
254e : 90 01 __ BCC $2551 ; (add_walls.s1239 + 0)
.s1238:
2550 : e8 __ __ INX
.s1239:
2551 : 18 __ __ CLC
2552 : 65 53 __ ADC T12 + 0 
2554 : a8 __ __ TAY
2555 : 8a __ __ TXA
2556 : 69 00 __ ADC #$00
2558 : 4a __ __ LSR
2559 : 85 46 __ STA T1 + 1 
255b : 98 __ __ TYA
255c : 6a __ __ ROR
255d : 46 46 __ LSR T1 + 1 
255f : 6a __ __ ROR
2560 : 46 46 __ LSR T1 + 1 
2562 : 6a __ __ ROR
2563 : 85 45 __ STA T1 + 0 
2565 : 18 __ __ CLC
2566 : a9 3a __ LDA #$3a
2568 : 65 46 __ ADC T1 + 1 
256a : 85 46 __ STA T1 + 1 
256c : 98 __ __ TYA
256d : 29 07 __ AND #$07
256f : 85 43 __ STA T0 + 0 
2571 : aa __ __ TAX
2572 : a0 20 __ LDY #$20
2574 : b1 45 __ LDA (T1 + 0),y 
2576 : e0 00 __ CPX #$00
2578 : f0 04 __ BEQ $257e ; (add_walls.s1021 + 0)
.l1020:
257a : 4a __ __ LSR
257b : ca __ __ DEX
257c : d0 fc __ BNE $257a ; (add_walls.l1020 + 0)
.s1021:
257e : 85 1b __ STA ACCU + 0 
2580 : a5 43 __ LDA T0 + 0 
2582 : c9 06 __ CMP #$06
2584 : b0 04 __ BCS $258a ; (add_walls.s210 + 0)
.s208:
2586 : a5 1b __ LDA ACCU + 0 
2588 : 90 18 __ BCC $25a2 ; (add_walls.s396 + 0)
.s210:
258a : a9 08 __ LDA #$08
258c : e5 43 __ SBC T0 + 0 
258e : aa __ __ TAX
258f : bd 24 36 LDA $3624,x ; (bitshift + 36)
2592 : 38 __ __ SEC
2593 : e9 01 __ SBC #$01
2595 : c8 __ __ INY
2596 : 31 45 __ AND (T1 + 0),y 
2598 : e0 00 __ CPX #$00
259a : f0 04 __ BEQ $25a0 ; (add_walls.s1023 + 0)
.l1110:
259c : 0a __ __ ASL
259d : ca __ __ DEX
259e : d0 fc __ BNE $259c ; (add_walls.l1110 + 0)
.s1023:
25a0 : 05 1b __ ORA ACCU + 0 
.s396:
25a2 : 29 07 __ AND #$07
25a4 : d0 0f __ BNE $25b5 ; (add_walls.s200 + 0)
.s198:
25a6 : a5 53 __ LDA T12 + 0 
25a8 : 85 0d __ STA P0 
25aa : a5 51 __ LDA T10 + 0 
25ac : 85 0e __ STA P1 
25ae : a9 01 __ LDA #$01
25b0 : 85 0f __ STA P2 
25b2 : 20 1d 0f JSR $0f1d ; (set_compact_tile.s0 + 0)
.s200:
25b5 : 38 __ __ SEC
25b6 : a5 53 __ LDA T12 + 0 
25b8 : e9 01 __ SBC #$01
25ba : 85 52 __ STA T11 + 0 
25bc : 18 __ __ CLC
25bd : 65 48 __ ADC T5 + 0 
25bf : a4 49 __ LDY T5 + 1 
25c1 : 90 01 __ BCC $25c4 ; (add_walls.s1211 + 0)
.s1210:
25c3 : c8 __ __ INY
.s1211:
25c4 : 18 __ __ CLC
25c5 : 65 52 __ ADC T11 + 0 
25c7 : 90 01 __ BCC $25ca ; (add_walls.s1213 + 0)
.s1212:
25c9 : c8 __ __ INY
.s1213:
25ca : 18 __ __ CLC
25cb : 65 52 __ ADC T11 + 0 
25cd : aa __ __ TAX
25ce : 98 __ __ TYA
25cf : 69 00 __ ADC #$00
25d1 : 4a __ __ LSR
25d2 : 85 46 __ STA T1 + 1 
25d4 : 8a __ __ TXA
25d5 : 6a __ __ ROR
25d6 : 46 46 __ LSR T1 + 1 
25d8 : 6a __ __ ROR
25d9 : 46 46 __ LSR T1 + 1 
25db : 6a __ __ ROR
25dc : 85 45 __ STA T1 + 0 
25de : 18 __ __ CLC
25df : a9 3a __ LDA #$3a
25e1 : 65 46 __ ADC T1 + 1 
25e3 : 85 46 __ STA T1 + 1 
25e5 : 8a __ __ TXA
25e6 : 29 07 __ AND #$07
25e8 : 85 43 __ STA T0 + 0 
25ea : aa __ __ TAX
25eb : a0 20 __ LDY #$20
25ed : b1 45 __ LDA (T1 + 0),y 
25ef : e0 00 __ CPX #$00
25f1 : f0 04 __ BEQ $25f7 ; (add_walls.s1025 + 0)
.l1024:
25f3 : 4a __ __ LSR
25f4 : ca __ __ DEX
25f5 : d0 fc __ BNE $25f3 ; (add_walls.l1024 + 0)
.s1025:
25f7 : 85 1b __ STA ACCU + 0 
25f9 : a5 43 __ LDA T0 + 0 
25fb : c9 06 __ CMP #$06
25fd : b0 04 __ BCS $2603 ; (add_walls.s227 + 0)
.s225:
25ff : a5 1b __ LDA ACCU + 0 
2601 : 90 18 __ BCC $261b ; (add_walls.s374 + 0)
.s227:
2603 : a9 08 __ LDA #$08
2605 : e5 43 __ SBC T0 + 0 
2607 : aa __ __ TAX
2608 : bd 24 36 LDA $3624,x ; (bitshift + 36)
260b : 38 __ __ SEC
260c : e9 01 __ SBC #$01
260e : c8 __ __ INY
260f : 31 45 __ AND (T1 + 0),y 
2611 : e0 00 __ CPX #$00
2613 : f0 04 __ BEQ $2619 ; (add_walls.s1027 + 0)
.l1098:
2615 : 0a __ __ ASL
2616 : ca __ __ DEX
2617 : d0 fc __ BNE $2615 ; (add_walls.l1098 + 0)
.s1027:
2619 : 05 1b __ ORA ACCU + 0 
.s374:
261b : 29 07 __ AND #$07
261d : d0 0f __ BNE $262e ; (add_walls.s217 + 0)
.s215:
261f : a5 52 __ LDA T11 + 0 
2621 : 85 0d __ STA P0 
2623 : a5 54 __ LDA T13 + 0 
2625 : 85 0e __ STA P1 
2627 : a9 01 __ LDA #$01
2629 : 85 0f __ STA P2 
262b : 20 1d 0f JSR $0f1d ; (set_compact_tile.s0 + 0)
.s217:
262e : e6 4d __ INC T8 + 0 
2630 : a5 4d __ LDA T8 + 0 
2632 : c9 40 __ CMP #$40
2634 : a9 00 __ LDA #$00
2636 : 2a __ __ ROL
2637 : 85 57 __ STA T16 + 0 
2639 : d0 64 __ BNE $269f ; (add_walls.s232 + 0)
.s239:
263b : a5 48 __ LDA T5 + 0 
263d : 65 4d __ ADC T8 + 0 
263f : a4 49 __ LDY T5 + 1 
2641 : 90 01 __ BCC $2644 ; (add_walls.s1233 + 0)
.s1232:
2643 : c8 __ __ INY
.s1233:
2644 : 18 __ __ CLC
2645 : 65 4d __ ADC T8 + 0 
2647 : 90 01 __ BCC $264a ; (add_walls.s1235 + 0)
.s1234:
2649 : c8 __ __ INY
.s1235:
264a : 18 __ __ CLC
264b : 65 4d __ ADC T8 + 0 
264d : aa __ __ TAX
264e : 98 __ __ TYA
264f : 69 00 __ ADC #$00
2651 : 4a __ __ LSR
2652 : 85 46 __ STA T1 + 1 
2654 : 8a __ __ TXA
2655 : 6a __ __ ROR
2656 : 46 46 __ LSR T1 + 1 
2658 : 6a __ __ ROR
2659 : 46 46 __ LSR T1 + 1 
265b : 6a __ __ ROR
265c : 85 45 __ STA T1 + 0 
265e : 18 __ __ CLC
265f : a9 3a __ LDA #$3a
2661 : 65 46 __ ADC T1 + 1 
2663 : 85 46 __ STA T1 + 1 
2665 : 8a __ __ TXA
2666 : 29 07 __ AND #$07
2668 : 85 43 __ STA T0 + 0 
266a : aa __ __ TAX
266b : a0 20 __ LDY #$20
266d : b1 45 __ LDA (T1 + 0),y 
266f : e0 00 __ CPX #$00
2671 : f0 04 __ BEQ $2677 ; (add_walls.s1032 + 0)
.l1031:
2673 : 4a __ __ LSR
2674 : ca __ __ DEX
2675 : d0 fc __ BNE $2673 ; (add_walls.l1031 + 0)
.s1032:
2677 : 85 1b __ STA ACCU + 0 
2679 : a5 43 __ LDA T0 + 0 
267b : c9 06 __ CMP #$06
267d : b0 04 __ BCS $2683 ; (add_walls.s244 + 0)
.s242:
267f : a5 1b __ LDA ACCU + 0 
2681 : 90 18 __ BCC $269b ; (add_walls.s392 + 0)
.s244:
2683 : a9 08 __ LDA #$08
2685 : e5 43 __ SBC T0 + 0 
2687 : aa __ __ TAX
2688 : bd 24 36 LDA $3624,x ; (bitshift + 36)
268b : 38 __ __ SEC
268c : e9 01 __ SBC #$01
268e : c8 __ __ INY
268f : 31 45 __ AND (T1 + 0),y 
2691 : e0 00 __ CPX #$00
2693 : f0 04 __ BEQ $2699 ; (add_walls.s1034 + 0)
.l1108:
2695 : 0a __ __ ASL
2696 : ca __ __ DEX
2697 : d0 fc __ BNE $2695 ; (add_walls.l1108 + 0)
.s1034:
2699 : 05 1b __ ORA ACCU + 0 
.s392:
269b : 29 07 __ AND #$07
269d : d0 0f __ BNE $26ae ; (add_walls.s234 + 0)
.s232:
269f : a5 4d __ LDA T8 + 0 
26a1 : 85 0d __ STA P0 
26a3 : a5 54 __ LDA T13 + 0 
26a5 : 85 0e __ STA P1 
26a7 : a9 01 __ LDA #$01
26a9 : 85 0f __ STA P2 
26ab : 20 1d 0f JSR $0f1d ; (set_compact_tile.s0 + 0)
.s234:
26ae : a5 55 __ LDA T14 + 0 
26b0 : f0 03 __ BEQ $26b5 ; (add_walls.s255 + 0)
26b2 : 4c 37 27 JMP $2737 ; (add_walls.s249 + 0)
.s255:
26b5 : a5 50 __ LDA T9 + 1 
26b7 : 4a __ __ LSR
26b8 : a5 4f __ LDA T9 + 0 
26ba : 85 46 __ STA T1 + 1 
26bc : 6a __ __ ROR
26bd : aa __ __ TAX
26be : a9 00 __ LDA #$00
26c0 : 6a __ __ ROR
26c1 : 85 43 __ STA T0 + 0 
26c3 : a5 50 __ LDA T9 + 1 
26c5 : 4a __ __ LSR
26c6 : 66 46 __ ROR T1 + 1 
26c8 : 6a __ __ ROR
26c9 : 66 46 __ ROR T1 + 1 
26cb : 29 80 __ AND #$80
26cd : 6a __ __ ROR
26ce : 65 43 __ ADC T0 + 0 
26d0 : a8 __ __ TAY
26d1 : 8a __ __ TXA
26d2 : 65 46 __ ADC T1 + 1 
26d4 : aa __ __ TAX
26d5 : 98 __ __ TYA
26d6 : 18 __ __ CLC
26d7 : 65 52 __ ADC T11 + 0 
26d9 : 90 01 __ BCC $26dc ; (add_walls.s1229 + 0)
.s1228:
26db : e8 __ __ INX
.s1229:
26dc : 18 __ __ CLC
26dd : 65 52 __ ADC T11 + 0 
26df : 90 01 __ BCC $26e2 ; (add_walls.s1231 + 0)
.s1230:
26e1 : e8 __ __ INX
.s1231:
26e2 : 18 __ __ CLC
26e3 : 65 52 __ ADC T11 + 0 
26e5 : a8 __ __ TAY
26e6 : 8a __ __ TXA
26e7 : 69 00 __ ADC #$00
26e9 : 4a __ __ LSR
26ea : 85 46 __ STA T1 + 1 
26ec : 98 __ __ TYA
26ed : 6a __ __ ROR
26ee : 46 46 __ LSR T1 + 1 
26f0 : 6a __ __ ROR
26f1 : 46 46 __ LSR T1 + 1 
26f3 : 6a __ __ ROR
26f4 : 85 45 __ STA T1 + 0 
26f6 : 18 __ __ CLC
26f7 : a9 3a __ LDA #$3a
26f9 : 65 46 __ ADC T1 + 1 
26fb : 85 46 __ STA T1 + 1 
26fd : 98 __ __ TYA
26fe : 29 07 __ AND #$07
2700 : 85 43 __ STA T0 + 0 
2702 : aa __ __ TAX
2703 : a0 20 __ LDY #$20
2705 : b1 45 __ LDA (T1 + 0),y 
2707 : e0 00 __ CPX #$00
2709 : f0 04 __ BEQ $270f ; (add_walls.s1036 + 0)
.l1035:
270b : 4a __ __ LSR
270c : ca __ __ DEX
270d : d0 fc __ BNE $270b ; (add_walls.l1035 + 0)
.s1036:
270f : 85 1b __ STA ACCU + 0 
2711 : a5 43 __ LDA T0 + 0 
2713 : c9 06 __ CMP #$06
2715 : b0 04 __ BCS $271b ; (add_walls.s261 + 0)
.s259:
2717 : a5 1b __ LDA ACCU + 0 
2719 : 90 18 __ BCC $2733 ; (add_walls.s389 + 0)
.s261:
271b : a9 08 __ LDA #$08
271d : e5 43 __ SBC T0 + 0 
271f : aa __ __ TAX
2720 : bd 24 36 LDA $3624,x ; (bitshift + 36)
2723 : 38 __ __ SEC
2724 : e9 01 __ SBC #$01
2726 : c8 __ __ INY
2727 : 31 45 __ AND (T1 + 0),y 
2729 : e0 00 __ CPX #$00
272b : f0 04 __ BEQ $2731 ; (add_walls.s1038 + 0)
.l1106:
272d : 0a __ __ ASL
272e : ca __ __ DEX
272f : d0 fc __ BNE $272d ; (add_walls.l1106 + 0)
.s1038:
2731 : 05 1b __ ORA ACCU + 0 
.s389:
2733 : 29 07 __ AND #$07
2735 : d0 0f __ BNE $2746 ; (add_walls.s251 + 0)
.s249:
2737 : a5 52 __ LDA T11 + 0 
2739 : 85 0d __ STA P0 
273b : a5 4f __ LDA T9 + 0 
273d : 85 0e __ STA P1 
273f : a9 01 __ LDA #$01
2741 : 85 0f __ STA P2 
2743 : 20 1d 0f JSR $0f1d ; (set_compact_tile.s0 + 0)
.s251:
2746 : a5 57 __ LDA T16 + 0 
2748 : f0 03 __ BEQ $274d ; (add_walls.s273 + 0)
274a : 4c d3 27 JMP $27d3 ; (add_walls.s266 + 0)
.s273:
274d : a5 55 __ LDA T14 + 0 
274f : d0 f9 __ BNE $274a ; (add_walls.s251 + 4)
.s272:
2751 : a5 50 __ LDA T9 + 1 
2753 : 4a __ __ LSR
2754 : a5 4f __ LDA T9 + 0 
2756 : 85 46 __ STA T1 + 1 
2758 : 6a __ __ ROR
2759 : aa __ __ TAX
275a : a9 00 __ LDA #$00
275c : 6a __ __ ROR
275d : 85 43 __ STA T0 + 0 
275f : a5 50 __ LDA T9 + 1 
2761 : 4a __ __ LSR
2762 : 66 46 __ ROR T1 + 1 
2764 : 6a __ __ ROR
2765 : 66 46 __ ROR T1 + 1 
2767 : 29 80 __ AND #$80
2769 : 6a __ __ ROR
276a : 65 43 __ ADC T0 + 0 
276c : a8 __ __ TAY
276d : 8a __ __ TXA
276e : 65 46 __ ADC T1 + 1 
2770 : aa __ __ TAX
2771 : 98 __ __ TYA
2772 : 18 __ __ CLC
2773 : 65 4d __ ADC T8 + 0 
2775 : 90 01 __ BCC $2778 ; (add_walls.s1225 + 0)
.s1224:
2777 : e8 __ __ INX
.s1225:
2778 : 18 __ __ CLC
2779 : 65 4d __ ADC T8 + 0 
277b : 90 01 __ BCC $277e ; (add_walls.s1227 + 0)
.s1226:
277d : e8 __ __ INX
.s1227:
277e : 18 __ __ CLC
277f : 65 4d __ ADC T8 + 0 
2781 : a8 __ __ TAY
2782 : 8a __ __ TXA
2783 : 69 00 __ ADC #$00
2785 : 4a __ __ LSR
2786 : 85 46 __ STA T1 + 1 
2788 : 98 __ __ TYA
2789 : 6a __ __ ROR
278a : 46 46 __ LSR T1 + 1 
278c : 6a __ __ ROR
278d : 46 46 __ LSR T1 + 1 
278f : 6a __ __ ROR
2790 : 85 45 __ STA T1 + 0 
2792 : 18 __ __ CLC
2793 : a9 3a __ LDA #$3a
2795 : 65 46 __ ADC T1 + 1 
2797 : 85 46 __ STA T1 + 1 
2799 : 98 __ __ TYA
279a : 29 07 __ AND #$07
279c : 85 43 __ STA T0 + 0 
279e : aa __ __ TAX
279f : a0 20 __ LDY #$20
27a1 : b1 45 __ LDA (T1 + 0),y 
27a3 : e0 00 __ CPX #$00
27a5 : f0 04 __ BEQ $27ab ; (add_walls.s1040 + 0)
.l1039:
27a7 : 4a __ __ LSR
27a8 : ca __ __ DEX
27a9 : d0 fc __ BNE $27a7 ; (add_walls.l1039 + 0)
.s1040:
27ab : 85 1b __ STA ACCU + 0 
27ad : a5 43 __ LDA T0 + 0 
27af : c9 06 __ CMP #$06
27b1 : b0 04 __ BCS $27b7 ; (add_walls.s278 + 0)
.s276:
27b3 : a5 1b __ LDA ACCU + 0 
27b5 : 90 18 __ BCC $27cf ; (add_walls.s386 + 0)
.s278:
27b7 : a9 08 __ LDA #$08
27b9 : e5 43 __ SBC T0 + 0 
27bb : aa __ __ TAX
27bc : bd 24 36 LDA $3624,x ; (bitshift + 36)
27bf : 38 __ __ SEC
27c0 : e9 01 __ SBC #$01
27c2 : c8 __ __ INY
27c3 : 31 45 __ AND (T1 + 0),y 
27c5 : e0 00 __ CPX #$00
27c7 : f0 04 __ BEQ $27cd ; (add_walls.s1042 + 0)
.l1104:
27c9 : 0a __ __ ASL
27ca : ca __ __ DEX
27cb : d0 fc __ BNE $27c9 ; (add_walls.l1104 + 0)
.s1042:
27cd : 05 1b __ ORA ACCU + 0 
.s386:
27cf : 29 07 __ AND #$07
27d1 : d0 0f __ BNE $27e2 ; (add_walls.s268 + 0)
.s266:
27d3 : a5 4d __ LDA T8 + 0 
27d5 : 85 0d __ STA P0 
27d7 : a5 4f __ LDA T9 + 0 
27d9 : 85 0e __ STA P1 
27db : a9 01 __ LDA #$01
27dd : 85 0f __ STA P2 
27df : 20 1d 0f JSR $0f1d ; (set_compact_tile.s0 + 0)
.s268:
27e2 : a5 56 __ LDA T15 + 0 
27e4 : d0 7c __ BNE $2862 ; (add_walls.s283 + 0)
.s289:
27e6 : a5 51 __ LDA T10 + 0 
27e8 : 85 46 __ STA T1 + 1 
27ea : 4a __ __ LSR
27eb : aa __ __ TAX
27ec : a9 00 __ LDA #$00
27ee : 6a __ __ ROR
27ef : 85 43 __ STA T0 + 0 
27f1 : a9 00 __ LDA #$00
27f3 : 46 46 __ LSR T1 + 1 
27f5 : 6a __ __ ROR
27f6 : 66 46 __ ROR T1 + 1 
27f8 : 6a __ __ ROR
27f9 : 65 43 __ ADC T0 + 0 
27fb : a8 __ __ TAY
27fc : 8a __ __ TXA
27fd : 65 46 __ ADC T1 + 1 
27ff : aa __ __ TAX
2800 : 98 __ __ TYA
2801 : 18 __ __ CLC
2802 : 65 52 __ ADC T11 + 0 
2804 : 90 01 __ BCC $2807 ; (add_walls.s1221 + 0)
.s1220:
2806 : e8 __ __ INX
.s1221:
2807 : 18 __ __ CLC
2808 : 65 52 __ ADC T11 + 0 
280a : 90 01 __ BCC $280d ; (add_walls.s1223 + 0)
.s1222:
280c : e8 __ __ INX
.s1223:
280d : 18 __ __ CLC
280e : 65 52 __ ADC T11 + 0 
2810 : a8 __ __ TAY
2811 : 8a __ __ TXA
2812 : 69 00 __ ADC #$00
2814 : 4a __ __ LSR
2815 : 85 46 __ STA T1 + 1 
2817 : 98 __ __ TYA
2818 : 6a __ __ ROR
2819 : 46 46 __ LSR T1 + 1 
281b : 6a __ __ ROR
281c : 46 46 __ LSR T1 + 1 
281e : 6a __ __ ROR
281f : 85 45 __ STA T1 + 0 
2821 : 18 __ __ CLC
2822 : a9 3a __ LDA #$3a
2824 : 65 46 __ ADC T1 + 1 
2826 : 85 46 __ STA T1 + 1 
2828 : 98 __ __ TYA
2829 : 29 07 __ AND #$07
282b : 85 43 __ STA T0 + 0 
282d : aa __ __ TAX
282e : a0 20 __ LDY #$20
2830 : b1 45 __ LDA (T1 + 0),y 
2832 : e0 00 __ CPX #$00
2834 : f0 04 __ BEQ $283a ; (add_walls.s1044 + 0)
.l1043:
2836 : 4a __ __ LSR
2837 : ca __ __ DEX
2838 : d0 fc __ BNE $2836 ; (add_walls.l1043 + 0)
.s1044:
283a : 85 1b __ STA ACCU + 0 
283c : a5 43 __ LDA T0 + 0 
283e : c9 06 __ CMP #$06
2840 : b0 04 __ BCS $2846 ; (add_walls.s295 + 0)
.s293:
2842 : a5 1b __ LDA ACCU + 0 
2844 : 90 18 __ BCC $285e ; (add_walls.s383 + 0)
.s295:
2846 : a9 08 __ LDA #$08
2848 : e5 43 __ SBC T0 + 0 
284a : aa __ __ TAX
284b : bd 24 36 LDA $3624,x ; (bitshift + 36)
284e : 38 __ __ SEC
284f : e9 01 __ SBC #$01
2851 : c8 __ __ INY
2852 : 31 45 __ AND (T1 + 0),y 
2854 : e0 00 __ CPX #$00
2856 : f0 04 __ BEQ $285c ; (add_walls.s1046 + 0)
.l1102:
2858 : 0a __ __ ASL
2859 : ca __ __ DEX
285a : d0 fc __ BNE $2858 ; (add_walls.l1102 + 0)
.s1046:
285c : 05 1b __ ORA ACCU + 0 
.s383:
285e : 29 07 __ AND #$07
2860 : d0 0f __ BNE $2871 ; (add_walls.s285 + 0)
.s283:
2862 : a5 52 __ LDA T11 + 0 
2864 : 85 0d __ STA P0 
2866 : a5 51 __ LDA T10 + 0 
2868 : 85 0e __ STA P1 
286a : a9 01 __ LDA #$01
286c : 85 0f __ STA P2 
286e : 20 1d 0f JSR $0f1d ; (set_compact_tile.s0 + 0)
.s285:
2871 : a5 57 __ LDA T16 + 0 
2873 : f0 03 __ BEQ $2878 ; (add_walls.s307 + 0)
2875 : 4c fb 28 JMP $28fb ; (add_walls.s300 + 0)
.s307:
2878 : a5 56 __ LDA T15 + 0 
287a : d0 7f __ BNE $28fb ; (add_walls.s300 + 0)
.s306:
287c : a5 51 __ LDA T10 + 0 
287e : 85 46 __ STA T1 + 1 
2880 : 4a __ __ LSR
2881 : aa __ __ TAX
2882 : a9 00 __ LDA #$00
2884 : 6a __ __ ROR
2885 : 85 43 __ STA T0 + 0 
2887 : a9 00 __ LDA #$00
2889 : 46 46 __ LSR T1 + 1 
288b : 6a __ __ ROR
288c : 66 46 __ ROR T1 + 1 
288e : 6a __ __ ROR
288f : 65 43 __ ADC T0 + 0 
2891 : a8 __ __ TAY
2892 : 8a __ __ TXA
2893 : 65 46 __ ADC T1 + 1 
2895 : aa __ __ TAX
2896 : 98 __ __ TYA
2897 : 18 __ __ CLC
2898 : 65 4d __ ADC T8 + 0 
289a : 90 01 __ BCC $289d ; (add_walls.s1217 + 0)
.s1216:
289c : e8 __ __ INX
.s1217:
289d : 18 __ __ CLC
289e : 65 4d __ ADC T8 + 0 
28a0 : 90 01 __ BCC $28a3 ; (add_walls.s1219 + 0)
.s1218:
28a2 : e8 __ __ INX
.s1219:
28a3 : 18 __ __ CLC
28a4 : 65 4d __ ADC T8 + 0 
28a6 : a8 __ __ TAY
28a7 : 8a __ __ TXA
28a8 : 69 00 __ ADC #$00
28aa : 4a __ __ LSR
28ab : 85 46 __ STA T1 + 1 
28ad : 98 __ __ TYA
28ae : 6a __ __ ROR
28af : 46 46 __ LSR T1 + 1 
28b1 : 6a __ __ ROR
28b2 : 46 46 __ LSR T1 + 1 
28b4 : 6a __ __ ROR
28b5 : 85 45 __ STA T1 + 0 
28b7 : 18 __ __ CLC
28b8 : a9 3a __ LDA #$3a
28ba : 65 46 __ ADC T1 + 1 
28bc : 85 46 __ STA T1 + 1 
28be : 98 __ __ TYA
28bf : 29 07 __ AND #$07
28c1 : 85 43 __ STA T0 + 0 
28c3 : aa __ __ TAX
28c4 : a0 20 __ LDY #$20
28c6 : b1 45 __ LDA (T1 + 0),y 
28c8 : e0 00 __ CPX #$00
28ca : f0 04 __ BEQ $28d0 ; (add_walls.s1048 + 0)
.l1047:
28cc : 4a __ __ LSR
28cd : ca __ __ DEX
28ce : d0 fc __ BNE $28cc ; (add_walls.l1047 + 0)
.s1048:
28d0 : 85 1b __ STA ACCU + 0 
28d2 : a5 43 __ LDA T0 + 0 
28d4 : c9 06 __ CMP #$06
28d6 : b0 04 __ BCS $28dc ; (add_walls.s312 + 0)
.s310:
28d8 : a5 1b __ LDA ACCU + 0 
28da : 90 18 __ BCC $28f4 ; (add_walls.s380 + 0)
.s312:
28dc : a9 08 __ LDA #$08
28de : e5 43 __ SBC T0 + 0 
28e0 : aa __ __ TAX
28e1 : bd 24 36 LDA $3624,x ; (bitshift + 36)
28e4 : 38 __ __ SEC
28e5 : e9 01 __ SBC #$01
28e7 : c8 __ __ INY
28e8 : 31 45 __ AND (T1 + 0),y 
28ea : e0 00 __ CPX #$00
28ec : f0 04 __ BEQ $28f2 ; (add_walls.s1050 + 0)
.l1100:
28ee : 0a __ __ ASL
28ef : ca __ __ DEX
28f0 : d0 fc __ BNE $28ee ; (add_walls.l1100 + 0)
.s1050:
28f2 : 05 1b __ ORA ACCU + 0 
.s380:
28f4 : 29 07 __ AND #$07
28f6 : f0 03 __ BEQ $28fb ; (add_walls.s300 + 0)
28f8 : 4c 28 24 JMP $2428 ; (add_walls.s5 + 0)
.s300:
28fb : a5 4d __ LDA T8 + 0 
28fd : 85 0d __ STA P0 
28ff : a5 51 __ LDA T10 + 0 
2901 : 85 0e __ STA P1 
2903 : a9 01 __ LDA #$01
2905 : 85 0f __ STA P2 
2907 : 20 1d 0f JSR $0f1d ; (set_compact_tile.s0 + 0)
290a : 4c 28 24 JMP $2428 ; (add_walls.s5 + 0)
.s24:
290d : 38 __ __ SEC
290e : a5 47 __ LDA T4 + 0 
2910 : e9 01 __ SBC #$01
2912 : 85 4d __ STA T8 + 0 
2914 : a9 00 __ LDA #$00
2916 : e9 00 __ SBC #$00
2918 : 85 4e __ STA T8 + 1 
291a : a5 4d __ LDA T8 + 0 
291c : c9 40 __ CMP #$40
291e : a9 00 __ LDA #$00
2920 : 2a __ __ ROL
2921 : 85 56 __ STA T15 + 0 
2923 : f0 03 __ BEQ $2928 ; (add_walls.s33 + 0)
2925 : 4c aa 29 JMP $29aa ; (add_walls.s27 + 0)
.s33:
2928 : a5 4e __ LDA T8 + 1 
292a : 4a __ __ LSR
292b : a5 4d __ LDA T8 + 0 
292d : 85 46 __ STA T1 + 1 
292f : 6a __ __ ROR
2930 : aa __ __ TAX
2931 : a9 00 __ LDA #$00
2933 : 6a __ __ ROR
2934 : 85 43 __ STA T0 + 0 
2936 : a5 4e __ LDA T8 + 1 
2938 : 4a __ __ LSR
2939 : 66 46 __ ROR T1 + 1 
293b : 6a __ __ ROR
293c : 66 46 __ ROR T1 + 1 
293e : 29 80 __ AND #$80
2940 : 6a __ __ ROR
2941 : 65 43 __ ADC T0 + 0 
2943 : a8 __ __ TAY
2944 : 8a __ __ TXA
2945 : 65 46 __ ADC T1 + 1 
2947 : aa __ __ TAX
2948 : 98 __ __ TYA
2949 : 18 __ __ CLC
294a : 65 4c __ ADC T7 + 0 
294c : 90 01 __ BCC $294f ; (add_walls.s1269 + 0)
.s1268:
294e : e8 __ __ INX
.s1269:
294f : 18 __ __ CLC
2950 : 65 4c __ ADC T7 + 0 
2952 : 90 01 __ BCC $2955 ; (add_walls.s1271 + 0)
.s1270:
2954 : e8 __ __ INX
.s1271:
2955 : 18 __ __ CLC
2956 : 65 4c __ ADC T7 + 0 
2958 : a8 __ __ TAY
2959 : 8a __ __ TXA
295a : 69 00 __ ADC #$00
295c : 4a __ __ LSR
295d : 85 46 __ STA T1 + 1 
295f : 98 __ __ TYA
2960 : 6a __ __ ROR
2961 : 46 46 __ LSR T1 + 1 
2963 : 6a __ __ ROR
2964 : 46 46 __ LSR T1 + 1 
2966 : 6a __ __ ROR
2967 : 85 45 __ STA T1 + 0 
2969 : 18 __ __ CLC
296a : a9 3a __ LDA #$3a
296c : 65 46 __ ADC T1 + 1 
296e : 85 46 __ STA T1 + 1 
2970 : 98 __ __ TYA
2971 : 29 07 __ AND #$07
2973 : 85 43 __ STA T0 + 0 
2975 : aa __ __ TAX
2976 : a0 20 __ LDY #$20
2978 : b1 45 __ LDA (T1 + 0),y 
297a : e0 00 __ CPX #$00
297c : f0 04 __ BEQ $2982 ; (add_walls.s1055 + 0)
.l1054:
297e : 4a __ __ LSR
297f : ca __ __ DEX
2980 : d0 fc __ BNE $297e ; (add_walls.l1054 + 0)
.s1055:
2982 : 85 1b __ STA ACCU + 0 
2984 : a5 43 __ LDA T0 + 0 
2986 : c9 06 __ CMP #$06
2988 : b0 04 __ BCS $298e ; (add_walls.s39 + 0)
.s37:
298a : a5 1b __ LDA ACCU + 0 
298c : 90 18 __ BCC $29a6 ; (add_walls.s421 + 0)
.s39:
298e : a9 08 __ LDA #$08
2990 : e5 43 __ SBC T0 + 0 
2992 : aa __ __ TAX
2993 : bd 24 36 LDA $3624,x ; (bitshift + 36)
2996 : 38 __ __ SEC
2997 : e9 01 __ SBC #$01
2999 : c8 __ __ INY
299a : 31 45 __ AND (T1 + 0),y 
299c : e0 00 __ CPX #$00
299e : f0 04 __ BEQ $29a4 ; (add_walls.s1057 + 0)
.l1126:
29a0 : 0a __ __ ASL
29a1 : ca __ __ DEX
29a2 : d0 fc __ BNE $29a0 ; (add_walls.l1126 + 0)
.s1057:
29a4 : 05 1b __ ORA ACCU + 0 
.s421:
29a6 : 29 07 __ AND #$07
29a8 : d0 0f __ BNE $29b9 ; (add_walls.s29 + 0)
.s27:
29aa : a5 55 __ LDA T14 + 0 
29ac : 85 0d __ STA P0 
29ae : a5 4d __ LDA T8 + 0 
29b0 : 85 0e __ STA P1 
29b2 : a9 01 __ LDA #$01
29b4 : 85 0f __ STA P2 
29b6 : 20 1d 0f JSR $0f1d ; (set_compact_tile.s0 + 0)
.s29:
29b9 : 18 __ __ CLC
29ba : a5 47 __ LDA T4 + 0 
29bc : 69 01 __ ADC #$01
29be : 85 4f __ STA T9 + 0 
29c0 : c9 40 __ CMP #$40
29c2 : a9 00 __ LDA #$00
29c4 : 2a __ __ ROL
29c5 : 85 57 __ STA T16 + 0 
29c7 : d0 7c __ BNE $2a45 ; (add_walls.s44 + 0)
.s50:
29c9 : a5 4f __ LDA T9 + 0 
29cb : 85 46 __ STA T1 + 1 
29cd : 4a __ __ LSR
29ce : aa __ __ TAX
29cf : a9 00 __ LDA #$00
29d1 : 6a __ __ ROR
29d2 : 85 43 __ STA T0 + 0 
29d4 : a9 00 __ LDA #$00
29d6 : 46 46 __ LSR T1 + 1 
29d8 : 6a __ __ ROR
29d9 : 66 46 __ ROR T1 + 1 
29db : 6a __ __ ROR
29dc : 65 43 __ ADC T0 + 0 
29de : a8 __ __ TAY
29df : 8a __ __ TXA
29e0 : 65 46 __ ADC T1 + 1 
29e2 : aa __ __ TAX
29e3 : 98 __ __ TYA
29e4 : 18 __ __ CLC
29e5 : 65 4c __ ADC T7 + 0 
29e7 : 90 01 __ BCC $29ea ; (add_walls.s1265 + 0)
.s1264:
29e9 : e8 __ __ INX
.s1265:
29ea : 18 __ __ CLC
29eb : 65 4c __ ADC T7 + 0 
29ed : 90 01 __ BCC $29f0 ; (add_walls.s1267 + 0)
.s1266:
29ef : e8 __ __ INX
.s1267:
29f0 : 18 __ __ CLC
29f1 : 65 4c __ ADC T7 + 0 
29f3 : a8 __ __ TAY
29f4 : 8a __ __ TXA
29f5 : 69 00 __ ADC #$00
29f7 : 4a __ __ LSR
29f8 : 85 46 __ STA T1 + 1 
29fa : 98 __ __ TYA
29fb : 6a __ __ ROR
29fc : 46 46 __ LSR T1 + 1 
29fe : 6a __ __ ROR
29ff : 46 46 __ LSR T1 + 1 
2a01 : 6a __ __ ROR
2a02 : 85 45 __ STA T1 + 0 
2a04 : 18 __ __ CLC
2a05 : a9 3a __ LDA #$3a
2a07 : 65 46 __ ADC T1 + 1 
2a09 : 85 46 __ STA T1 + 1 
2a0b : 98 __ __ TYA
2a0c : 29 07 __ AND #$07
2a0e : 85 43 __ STA T0 + 0 
2a10 : aa __ __ TAX
2a11 : a0 20 __ LDY #$20
2a13 : b1 45 __ LDA (T1 + 0),y 
2a15 : e0 00 __ CPX #$00
2a17 : f0 04 __ BEQ $2a1d ; (add_walls.s1062 + 0)
.l1061:
2a19 : 4a __ __ LSR
2a1a : ca __ __ DEX
2a1b : d0 fc __ BNE $2a19 ; (add_walls.l1061 + 0)
.s1062:
2a1d : 85 1b __ STA ACCU + 0 
2a1f : a5 43 __ LDA T0 + 0 
2a21 : c9 06 __ CMP #$06
2a23 : b0 04 __ BCS $2a29 ; (add_walls.s56 + 0)
.s54:
2a25 : a5 1b __ LDA ACCU + 0 
2a27 : 90 18 __ BCC $2a41 ; (add_walls.s418 + 0)
.s56:
2a29 : a9 08 __ LDA #$08
2a2b : e5 43 __ SBC T0 + 0 
2a2d : aa __ __ TAX
2a2e : bd 24 36 LDA $3624,x ; (bitshift + 36)
2a31 : 38 __ __ SEC
2a32 : e9 01 __ SBC #$01
2a34 : c8 __ __ INY
2a35 : 31 45 __ AND (T1 + 0),y 
2a37 : e0 00 __ CPX #$00
2a39 : f0 04 __ BEQ $2a3f ; (add_walls.s1064 + 0)
.l1124:
2a3b : 0a __ __ ASL
2a3c : ca __ __ DEX
2a3d : d0 fc __ BNE $2a3b ; (add_walls.l1124 + 0)
.s1064:
2a3f : 05 1b __ ORA ACCU + 0 
.s418:
2a41 : 29 07 __ AND #$07
2a43 : d0 0f __ BNE $2a54 ; (add_walls.s46 + 0)
.s44:
2a45 : a5 55 __ LDA T14 + 0 
2a47 : 85 0d __ STA P0 
2a49 : a5 4f __ LDA T9 + 0 
2a4b : 85 0e __ STA P1 
2a4d : a9 01 __ LDA #$01
2a4f : 85 0f __ STA P2 
2a51 : 20 1d 0f JSR $0f1d ; (set_compact_tile.s0 + 0)
.s46:
2a54 : 38 __ __ SEC
2a55 : a5 4c __ LDA T7 + 0 
2a57 : e9 01 __ SBC #$01
2a59 : 85 51 __ STA T10 + 0 
2a5b : c9 40 __ CMP #$40
2a5d : a9 00 __ LDA #$00
2a5f : 2a __ __ ROL
2a60 : 85 58 __ STA T17 + 0 
2a62 : d0 64 __ BNE $2ac8 ; (add_walls.s61 + 0)
.s68:
2a64 : a5 48 __ LDA T5 + 0 
2a66 : 65 51 __ ADC T10 + 0 
2a68 : a4 49 __ LDY T5 + 1 
2a6a : 90 01 __ BCC $2a6d ; (add_walls.s1261 + 0)
.s1260:
2a6c : c8 __ __ INY
.s1261:
2a6d : 18 __ __ CLC
2a6e : 65 51 __ ADC T10 + 0 
2a70 : 90 01 __ BCC $2a73 ; (add_walls.s1263 + 0)
.s1262:
2a72 : c8 __ __ INY
.s1263:
2a73 : 18 __ __ CLC
2a74 : 65 51 __ ADC T10 + 0 
2a76 : aa __ __ TAX
2a77 : 98 __ __ TYA
2a78 : 69 00 __ ADC #$00
2a7a : 4a __ __ LSR
2a7b : 85 46 __ STA T1 + 1 
2a7d : 8a __ __ TXA
2a7e : 6a __ __ ROR
2a7f : 46 46 __ LSR T1 + 1 
2a81 : 6a __ __ ROR
2a82 : 46 46 __ LSR T1 + 1 
2a84 : 6a __ __ ROR
2a85 : 85 45 __ STA T1 + 0 
2a87 : 18 __ __ CLC
2a88 : a9 3a __ LDA #$3a
2a8a : 65 46 __ ADC T1 + 1 
2a8c : 85 46 __ STA T1 + 1 
2a8e : 8a __ __ TXA
2a8f : 29 07 __ AND #$07
2a91 : 85 43 __ STA T0 + 0 
2a93 : aa __ __ TAX
2a94 : a0 20 __ LDY #$20
2a96 : b1 45 __ LDA (T1 + 0),y 
2a98 : e0 00 __ CPX #$00
2a9a : f0 04 __ BEQ $2aa0 ; (add_walls.s1069 + 0)
.l1068:
2a9c : 4a __ __ LSR
2a9d : ca __ __ DEX
2a9e : d0 fc __ BNE $2a9c ; (add_walls.l1068 + 0)
.s1069:
2aa0 : 85 1b __ STA ACCU + 0 
2aa2 : a5 43 __ LDA T0 + 0 
2aa4 : c9 06 __ CMP #$06
2aa6 : b0 04 __ BCS $2aac ; (add_walls.s73 + 0)
.s71:
2aa8 : a5 1b __ LDA ACCU + 0 
2aaa : 90 18 __ BCC $2ac4 ; (add_walls.s415 + 0)
.s73:
2aac : a9 08 __ LDA #$08
2aae : e5 43 __ SBC T0 + 0 
2ab0 : aa __ __ TAX
2ab1 : bd 24 36 LDA $3624,x ; (bitshift + 36)
2ab4 : 38 __ __ SEC
2ab5 : e9 01 __ SBC #$01
2ab7 : c8 __ __ INY
2ab8 : 31 45 __ AND (T1 + 0),y 
2aba : e0 00 __ CPX #$00
2abc : f0 04 __ BEQ $2ac2 ; (add_walls.s1071 + 0)
.l1122:
2abe : 0a __ __ ASL
2abf : ca __ __ DEX
2ac0 : d0 fc __ BNE $2abe ; (add_walls.l1122 + 0)
.s1071:
2ac2 : 05 1b __ ORA ACCU + 0 
.s415:
2ac4 : 29 07 __ AND #$07
2ac6 : d0 0f __ BNE $2ad7 ; (add_walls.s63 + 0)
.s61:
2ac8 : a5 51 __ LDA T10 + 0 
2aca : 85 0d __ STA P0 
2acc : a5 54 __ LDA T13 + 0 
2ace : 85 0e __ STA P1 
2ad0 : a9 01 __ LDA #$01
2ad2 : 85 0f __ STA P2 
2ad4 : 20 1d 0f JSR $0f1d ; (set_compact_tile.s0 + 0)
.s63:
2ad7 : 18 __ __ CLC
2ad8 : a5 4c __ LDA T7 + 0 
2ada : 69 01 __ ADC #$01
2adc : 85 53 __ STA T12 + 0 
2ade : 18 __ __ CLC
2adf : 65 48 __ ADC T5 + 0 
2ae1 : a4 49 __ LDY T5 + 1 
2ae3 : 90 01 __ BCC $2ae6 ; (add_walls.s1203 + 0)
.s1202:
2ae5 : c8 __ __ INY
.s1203:
2ae6 : 18 __ __ CLC
2ae7 : 65 53 __ ADC T12 + 0 
2ae9 : 90 01 __ BCC $2aec ; (add_walls.s1205 + 0)
.s1204:
2aeb : c8 __ __ INY
.s1205:
2aec : 18 __ __ CLC
2aed : 65 53 __ ADC T12 + 0 
2aef : aa __ __ TAX
2af0 : 98 __ __ TYA
2af1 : 69 00 __ ADC #$00
2af3 : 4a __ __ LSR
2af4 : 85 46 __ STA T1 + 1 
2af6 : 8a __ __ TXA
2af7 : 6a __ __ ROR
2af8 : 46 46 __ LSR T1 + 1 
2afa : 6a __ __ ROR
2afb : 46 46 __ LSR T1 + 1 
2afd : 6a __ __ ROR
2afe : 85 45 __ STA T1 + 0 
2b00 : 18 __ __ CLC
2b01 : a9 3a __ LDA #$3a
2b03 : 65 46 __ ADC T1 + 1 
2b05 : 85 46 __ STA T1 + 1 
2b07 : 8a __ __ TXA
2b08 : 29 07 __ AND #$07
2b0a : 85 43 __ STA T0 + 0 
2b0c : aa __ __ TAX
2b0d : a0 20 __ LDY #$20
2b0f : b1 45 __ LDA (T1 + 0),y 
2b11 : e0 00 __ CPX #$00
2b13 : f0 04 __ BEQ $2b19 ; (add_walls.s1073 + 0)
.l1072:
2b15 : 4a __ __ LSR
2b16 : ca __ __ DEX
2b17 : d0 fc __ BNE $2b15 ; (add_walls.l1072 + 0)
.s1073:
2b19 : 85 1b __ STA ACCU + 0 
2b1b : a5 43 __ LDA T0 + 0 
2b1d : c9 06 __ CMP #$06
2b1f : b0 04 __ BCS $2b25 ; (add_walls.s90 + 0)
.s88:
2b21 : a5 1b __ LDA ACCU + 0 
2b23 : 90 18 __ BCC $2b3d ; (add_walls.s366 + 0)
.s90:
2b25 : a9 08 __ LDA #$08
2b27 : e5 43 __ SBC T0 + 0 
2b29 : aa __ __ TAX
2b2a : bd 24 36 LDA $3624,x ; (bitshift + 36)
2b2d : 38 __ __ SEC
2b2e : e9 01 __ SBC #$01
2b30 : c8 __ __ INY
2b31 : 31 45 __ AND (T1 + 0),y 
2b33 : e0 00 __ CPX #$00
2b35 : f0 04 __ BEQ $2b3b ; (add_walls.s1075 + 0)
.l1094:
2b37 : 0a __ __ ASL
2b38 : ca __ __ DEX
2b39 : d0 fc __ BNE $2b37 ; (add_walls.l1094 + 0)
.s1075:
2b3b : 05 1b __ ORA ACCU + 0 
.s366:
2b3d : 29 07 __ AND #$07
2b3f : d0 0f __ BNE $2b50 ; (add_walls.s80 + 0)
.s78:
2b41 : a5 53 __ LDA T12 + 0 
2b43 : 85 0d __ STA P0 
2b45 : a5 54 __ LDA T13 + 0 
2b47 : 85 0e __ STA P1 
2b49 : a9 01 __ LDA #$01
2b4b : 85 0f __ STA P2 
2b4d : 20 1d 0f JSR $0f1d ; (set_compact_tile.s0 + 0)
.s80:
2b50 : a5 58 __ LDA T17 + 0 
2b52 : f0 03 __ BEQ $2b57 ; (add_walls.s102 + 0)
2b54 : 4c dd 2b JMP $2bdd ; (add_walls.s95 + 0)
.s102:
2b57 : a5 56 __ LDA T15 + 0 
2b59 : d0 f9 __ BNE $2b54 ; (add_walls.s80 + 4)
.s101:
2b5b : a5 4e __ LDA T8 + 1 
2b5d : 4a __ __ LSR
2b5e : a5 4d __ LDA T8 + 0 
2b60 : 85 46 __ STA T1 + 1 
2b62 : 6a __ __ ROR
2b63 : aa __ __ TAX
2b64 : a9 00 __ LDA #$00
2b66 : 6a __ __ ROR
2b67 : 85 43 __ STA T0 + 0 
2b69 : a5 4e __ LDA T8 + 1 
2b6b : 4a __ __ LSR
2b6c : 66 46 __ ROR T1 + 1 
2b6e : 6a __ __ ROR
2b6f : 66 46 __ ROR T1 + 1 
2b71 : 29 80 __ AND #$80
2b73 : 6a __ __ ROR
2b74 : 65 43 __ ADC T0 + 0 
2b76 : a8 __ __ TAY
2b77 : 8a __ __ TXA
2b78 : 65 46 __ ADC T1 + 1 
2b7a : aa __ __ TAX
2b7b : 98 __ __ TYA
2b7c : 18 __ __ CLC
2b7d : 65 51 __ ADC T10 + 0 
2b7f : 90 01 __ BCC $2b82 ; (add_walls.s1257 + 0)
.s1256:
2b81 : e8 __ __ INX
.s1257:
2b82 : 18 __ __ CLC
2b83 : 65 51 __ ADC T10 + 0 
2b85 : 90 01 __ BCC $2b88 ; (add_walls.s1259 + 0)
.s1258:
2b87 : e8 __ __ INX
.s1259:
2b88 : 18 __ __ CLC
2b89 : 65 51 __ ADC T10 + 0 
2b8b : a8 __ __ TAY
2b8c : 8a __ __ TXA
2b8d : 69 00 __ ADC #$00
2b8f : 4a __ __ LSR
2b90 : 85 46 __ STA T1 + 1 
2b92 : 98 __ __ TYA
2b93 : 6a __ __ ROR
2b94 : 46 46 __ LSR T1 + 1 
2b96 : 6a __ __ ROR
2b97 : 46 46 __ LSR T1 + 1 
2b99 : 6a __ __ ROR
2b9a : 85 45 __ STA T1 + 0 
2b9c : 18 __ __ CLC
2b9d : a9 3a __ LDA #$3a
2b9f : 65 46 __ ADC T1 + 1 
2ba1 : 85 46 __ STA T1 + 1 
2ba3 : 98 __ __ TYA
2ba4 : 29 07 __ AND #$07
2ba6 : 85 43 __ STA T0 + 0 
2ba8 : aa __ __ TAX
2ba9 : a0 20 __ LDY #$20
2bab : b1 45 __ LDA (T1 + 0),y 
2bad : e0 00 __ CPX #$00
2baf : f0 04 __ BEQ $2bb5 ; (add_walls.s1077 + 0)
.l1076:
2bb1 : 4a __ __ LSR
2bb2 : ca __ __ DEX
2bb3 : d0 fc __ BNE $2bb1 ; (add_walls.l1076 + 0)
.s1077:
2bb5 : 85 1b __ STA ACCU + 0 
2bb7 : a5 43 __ LDA T0 + 0 
2bb9 : c9 06 __ CMP #$06
2bbb : b0 04 __ BCS $2bc1 ; (add_walls.s107 + 0)
.s105:
2bbd : a5 1b __ LDA ACCU + 0 
2bbf : 90 18 __ BCC $2bd9 ; (add_walls.s411 + 0)
.s107:
2bc1 : a9 08 __ LDA #$08
2bc3 : e5 43 __ SBC T0 + 0 
2bc5 : aa __ __ TAX
2bc6 : bd 24 36 LDA $3624,x ; (bitshift + 36)
2bc9 : 38 __ __ SEC
2bca : e9 01 __ SBC #$01
2bcc : c8 __ __ INY
2bcd : 31 45 __ AND (T1 + 0),y 
2bcf : e0 00 __ CPX #$00
2bd1 : f0 04 __ BEQ $2bd7 ; (add_walls.s1079 + 0)
.l1120:
2bd3 : 0a __ __ ASL
2bd4 : ca __ __ DEX
2bd5 : d0 fc __ BNE $2bd3 ; (add_walls.l1120 + 0)
.s1079:
2bd7 : 05 1b __ ORA ACCU + 0 
.s411:
2bd9 : 29 07 __ AND #$07
2bdb : d0 16 __ BNE $2bf3 ; (add_walls.s118 + 0)
.s95:
2bdd : a5 51 __ LDA T10 + 0 
2bdf : 85 0d __ STA P0 
2be1 : a5 4d __ LDA T8 + 0 
2be3 : 85 0e __ STA P1 
2be5 : a9 01 __ LDA #$01
2be7 : 85 0f __ STA P2 
2be9 : 20 1d 0f JSR $0f1d ; (set_compact_tile.s0 + 0)
2bec : a5 56 __ LDA T15 + 0 
2bee : f0 03 __ BEQ $2bf3 ; (add_walls.s118 + 0)
2bf0 : 4c 75 2c JMP $2c75 ; (add_walls.s112 + 0)
.s118:
2bf3 : a5 4e __ LDA T8 + 1 
2bf5 : 4a __ __ LSR
2bf6 : a5 4d __ LDA T8 + 0 
2bf8 : 85 46 __ STA T1 + 1 
2bfa : 6a __ __ ROR
2bfb : aa __ __ TAX
2bfc : a9 00 __ LDA #$00
2bfe : 6a __ __ ROR
2bff : 85 43 __ STA T0 + 0 
2c01 : a5 4e __ LDA T8 + 1 
2c03 : 4a __ __ LSR
2c04 : 66 46 __ ROR T1 + 1 
2c06 : 6a __ __ ROR
2c07 : 66 46 __ ROR T1 + 1 
2c09 : 29 80 __ AND #$80
2c0b : 6a __ __ ROR
2c0c : 65 43 __ ADC T0 + 0 
2c0e : a8 __ __ TAY
2c0f : 8a __ __ TXA
2c10 : 65 46 __ ADC T1 + 1 
2c12 : aa __ __ TAX
2c13 : 98 __ __ TYA
2c14 : 18 __ __ CLC
2c15 : 65 53 __ ADC T12 + 0 
2c17 : 90 01 __ BCC $2c1a ; (add_walls.s1253 + 0)
.s1252:
2c19 : e8 __ __ INX
.s1253:
2c1a : 18 __ __ CLC
2c1b : 65 53 __ ADC T12 + 0 
2c1d : 90 01 __ BCC $2c20 ; (add_walls.s1255 + 0)
.s1254:
2c1f : e8 __ __ INX
.s1255:
2c20 : 18 __ __ CLC
2c21 : 65 53 __ ADC T12 + 0 
2c23 : a8 __ __ TAY
2c24 : 8a __ __ TXA
2c25 : 69 00 __ ADC #$00
2c27 : 4a __ __ LSR
2c28 : 85 46 __ STA T1 + 1 
2c2a : 98 __ __ TYA
2c2b : 6a __ __ ROR
2c2c : 46 46 __ LSR T1 + 1 
2c2e : 6a __ __ ROR
2c2f : 46 46 __ LSR T1 + 1 
2c31 : 6a __ __ ROR
2c32 : 85 45 __ STA T1 + 0 
2c34 : 18 __ __ CLC
2c35 : a9 3a __ LDA #$3a
2c37 : 65 46 __ ADC T1 + 1 
2c39 : 85 46 __ STA T1 + 1 
2c3b : 98 __ __ TYA
2c3c : 29 07 __ AND #$07
2c3e : 85 43 __ STA T0 + 0 
2c40 : aa __ __ TAX
2c41 : a0 20 __ LDY #$20
2c43 : b1 45 __ LDA (T1 + 0),y 
2c45 : e0 00 __ CPX #$00
2c47 : f0 04 __ BEQ $2c4d ; (add_walls.s1081 + 0)
.l1080:
2c49 : 4a __ __ LSR
2c4a : ca __ __ DEX
2c4b : d0 fc __ BNE $2c49 ; (add_walls.l1080 + 0)
.s1081:
2c4d : 85 1b __ STA ACCU + 0 
2c4f : a5 43 __ LDA T0 + 0 
2c51 : c9 06 __ CMP #$06
2c53 : b0 04 __ BCS $2c59 ; (add_walls.s124 + 0)
.s122:
2c55 : a5 1b __ LDA ACCU + 0 
2c57 : 90 18 __ BCC $2c71 ; (add_walls.s408 + 0)
.s124:
2c59 : a9 08 __ LDA #$08
2c5b : e5 43 __ SBC T0 + 0 
2c5d : aa __ __ TAX
2c5e : bd 24 36 LDA $3624,x ; (bitshift + 36)
2c61 : 38 __ __ SEC
2c62 : e9 01 __ SBC #$01
2c64 : c8 __ __ INY
2c65 : 31 45 __ AND (T1 + 0),y 
2c67 : e0 00 __ CPX #$00
2c69 : f0 04 __ BEQ $2c6f ; (add_walls.s1083 + 0)
.l1118:
2c6b : 0a __ __ ASL
2c6c : ca __ __ DEX
2c6d : d0 fc __ BNE $2c6b ; (add_walls.l1118 + 0)
.s1083:
2c6f : 05 1b __ ORA ACCU + 0 
.s408:
2c71 : 29 07 __ AND #$07
2c73 : d0 0f __ BNE $2c84 ; (add_walls.s114 + 0)
.s112:
2c75 : a5 53 __ LDA T12 + 0 
2c77 : 85 0d __ STA P0 
2c79 : a5 4d __ LDA T8 + 0 
2c7b : 85 0e __ STA P1 
2c7d : a9 01 __ LDA #$01
2c7f : 85 0f __ STA P2 
2c81 : 20 1d 0f JSR $0f1d ; (set_compact_tile.s0 + 0)
.s114:
2c84 : a5 58 __ LDA T17 + 0 
2c86 : f0 03 __ BEQ $2c8b ; (add_walls.s136 + 0)
2c88 : 4c 0b 2d JMP $2d0b ; (add_walls.s129 + 0)
.s136:
2c8b : a5 57 __ LDA T16 + 0 
2c8d : d0 7c __ BNE $2d0b ; (add_walls.s129 + 0)
.s135:
2c8f : a5 4f __ LDA T9 + 0 
2c91 : 85 46 __ STA T1 + 1 
2c93 : 4a __ __ LSR
2c94 : aa __ __ TAX
2c95 : a9 00 __ LDA #$00
2c97 : 6a __ __ ROR
2c98 : 85 43 __ STA T0 + 0 
2c9a : a9 00 __ LDA #$00
2c9c : 46 46 __ LSR T1 + 1 
2c9e : 6a __ __ ROR
2c9f : 66 46 __ ROR T1 + 1 
2ca1 : 6a __ __ ROR
2ca2 : 65 43 __ ADC T0 + 0 
2ca4 : a8 __ __ TAY
2ca5 : 8a __ __ TXA
2ca6 : 65 46 __ ADC T1 + 1 
2ca8 : aa __ __ TAX
2ca9 : 98 __ __ TYA
2caa : 18 __ __ CLC
2cab : 65 51 __ ADC T10 + 0 
2cad : 90 01 __ BCC $2cb0 ; (add_walls.s1249 + 0)
.s1248:
2caf : e8 __ __ INX
.s1249:
2cb0 : 18 __ __ CLC
2cb1 : 65 51 __ ADC T10 + 0 
2cb3 : 90 01 __ BCC $2cb6 ; (add_walls.s1251 + 0)
.s1250:
2cb5 : e8 __ __ INX
.s1251:
2cb6 : 18 __ __ CLC
2cb7 : 65 51 __ ADC T10 + 0 
2cb9 : a8 __ __ TAY
2cba : 8a __ __ TXA
2cbb : 69 00 __ ADC #$00
2cbd : 4a __ __ LSR
2cbe : 85 46 __ STA T1 + 1 
2cc0 : 98 __ __ TYA
2cc1 : 6a __ __ ROR
2cc2 : 46 46 __ LSR T1 + 1 
2cc4 : 6a __ __ ROR
2cc5 : 46 46 __ LSR T1 + 1 
2cc7 : 6a __ __ ROR
2cc8 : 85 45 __ STA T1 + 0 
2cca : 18 __ __ CLC
2ccb : a9 3a __ LDA #$3a
2ccd : 65 46 __ ADC T1 + 1 
2ccf : 85 46 __ STA T1 + 1 
2cd1 : 98 __ __ TYA
2cd2 : 29 07 __ AND #$07
2cd4 : 85 43 __ STA T0 + 0 
2cd6 : aa __ __ TAX
2cd7 : a0 20 __ LDY #$20
2cd9 : b1 45 __ LDA (T1 + 0),y 
2cdb : e0 00 __ CPX #$00
2cdd : f0 04 __ BEQ $2ce3 ; (add_walls.s1085 + 0)
.l1084:
2cdf : 4a __ __ LSR
2ce0 : ca __ __ DEX
2ce1 : d0 fc __ BNE $2cdf ; (add_walls.l1084 + 0)
.s1085:
2ce3 : 85 1b __ STA ACCU + 0 
2ce5 : a5 43 __ LDA T0 + 0 
2ce7 : c9 06 __ CMP #$06
2ce9 : b0 04 __ BCS $2cef ; (add_walls.s141 + 0)
.s139:
2ceb : a5 1b __ LDA ACCU + 0 
2ced : 90 18 __ BCC $2d07 ; (add_walls.s405 + 0)
.s141:
2cef : a9 08 __ LDA #$08
2cf1 : e5 43 __ SBC T0 + 0 
2cf3 : aa __ __ TAX
2cf4 : bd 24 36 LDA $3624,x ; (bitshift + 36)
2cf7 : 38 __ __ SEC
2cf8 : e9 01 __ SBC #$01
2cfa : c8 __ __ INY
2cfb : 31 45 __ AND (T1 + 0),y 
2cfd : e0 00 __ CPX #$00
2cff : f0 04 __ BEQ $2d05 ; (add_walls.s1087 + 0)
.l1116:
2d01 : 0a __ __ ASL
2d02 : ca __ __ DEX
2d03 : d0 fc __ BNE $2d01 ; (add_walls.l1116 + 0)
.s1087:
2d05 : 05 1b __ ORA ACCU + 0 
.s405:
2d07 : 29 07 __ AND #$07
2d09 : d0 16 __ BNE $2d21 ; (add_walls.s152 + 0)
.s129:
2d0b : a5 51 __ LDA T10 + 0 
2d0d : 85 0d __ STA P0 
2d0f : a5 4f __ LDA T9 + 0 
2d11 : 85 0e __ STA P1 
2d13 : a9 01 __ LDA #$01
2d15 : 85 0f __ STA P2 
2d17 : 20 1d 0f JSR $0f1d ; (set_compact_tile.s0 + 0)
2d1a : a5 57 __ LDA T16 + 0 
2d1c : f0 03 __ BEQ $2d21 ; (add_walls.s152 + 0)
2d1e : 4c a0 2d JMP $2da0 ; (add_walls.s146 + 0)
.s152:
2d21 : a5 4f __ LDA T9 + 0 
2d23 : 85 46 __ STA T1 + 1 
2d25 : 4a __ __ LSR
2d26 : aa __ __ TAX
2d27 : a9 00 __ LDA #$00
2d29 : 6a __ __ ROR
2d2a : 85 43 __ STA T0 + 0 
2d2c : a9 00 __ LDA #$00
2d2e : 46 46 __ LSR T1 + 1 
2d30 : 6a __ __ ROR
2d31 : 66 46 __ ROR T1 + 1 
2d33 : 6a __ __ ROR
2d34 : 65 43 __ ADC T0 + 0 
2d36 : a8 __ __ TAY
2d37 : 8a __ __ TXA
2d38 : 65 46 __ ADC T1 + 1 
2d3a : aa __ __ TAX
2d3b : 98 __ __ TYA
2d3c : 18 __ __ CLC
2d3d : 65 53 __ ADC T12 + 0 
2d3f : 90 01 __ BCC $2d42 ; (add_walls.s1245 + 0)
.s1244:
2d41 : e8 __ __ INX
.s1245:
2d42 : 18 __ __ CLC
2d43 : 65 53 __ ADC T12 + 0 
2d45 : 90 01 __ BCC $2d48 ; (add_walls.s1247 + 0)
.s1246:
2d47 : e8 __ __ INX
.s1247:
2d48 : 18 __ __ CLC
2d49 : 65 53 __ ADC T12 + 0 
2d4b : a8 __ __ TAY
2d4c : 8a __ __ TXA
2d4d : 69 00 __ ADC #$00
2d4f : 4a __ __ LSR
2d50 : 85 46 __ STA T1 + 1 
2d52 : 98 __ __ TYA
2d53 : 6a __ __ ROR
2d54 : 46 46 __ LSR T1 + 1 
2d56 : 6a __ __ ROR
2d57 : 46 46 __ LSR T1 + 1 
2d59 : 6a __ __ ROR
2d5a : 85 45 __ STA T1 + 0 
2d5c : 18 __ __ CLC
2d5d : a9 3a __ LDA #$3a
2d5f : 65 46 __ ADC T1 + 1 
2d61 : 85 46 __ STA T1 + 1 
2d63 : 98 __ __ TYA
2d64 : 29 07 __ AND #$07
2d66 : 85 43 __ STA T0 + 0 
2d68 : aa __ __ TAX
2d69 : a0 20 __ LDY #$20
2d6b : b1 45 __ LDA (T1 + 0),y 
2d6d : e0 00 __ CPX #$00
2d6f : f0 04 __ BEQ $2d75 ; (add_walls.s1089 + 0)
.l1088:
2d71 : 4a __ __ LSR
2d72 : ca __ __ DEX
2d73 : d0 fc __ BNE $2d71 ; (add_walls.l1088 + 0)
.s1089:
2d75 : 85 1b __ STA ACCU + 0 
2d77 : a5 43 __ LDA T0 + 0 
2d79 : c9 06 __ CMP #$06
2d7b : b0 04 __ BCS $2d81 ; (add_walls.s158 + 0)
.s156:
2d7d : a5 1b __ LDA ACCU + 0 
2d7f : 90 18 __ BCC $2d99 ; (add_walls.s402 + 0)
.s158:
2d81 : a9 08 __ LDA #$08
2d83 : e5 43 __ SBC T0 + 0 
2d85 : aa __ __ TAX
2d86 : bd 24 36 LDA $3624,x ; (bitshift + 36)
2d89 : 38 __ __ SEC
2d8a : e9 01 __ SBC #$01
2d8c : c8 __ __ INY
2d8d : 31 45 __ AND (T1 + 0),y 
2d8f : e0 00 __ CPX #$00
2d91 : f0 04 __ BEQ $2d97 ; (add_walls.s1091 + 0)
.l1114:
2d93 : 0a __ __ ASL
2d94 : ca __ __ DEX
2d95 : d0 fc __ BNE $2d93 ; (add_walls.l1114 + 0)
.s1091:
2d97 : 05 1b __ ORA ACCU + 0 
.s402:
2d99 : 29 07 __ AND #$07
2d9b : f0 03 __ BEQ $2da0 ; (add_walls.s146 + 0)
2d9d : 4c b8 23 JMP $23b8 ; (add_walls.s163 + 0)
.s146:
2da0 : a5 53 __ LDA T12 + 0 
2da2 : 85 0d __ STA P0 
2da4 : a5 4f __ LDA T9 + 0 
2da6 : 85 0e __ STA P1 
2da8 : a9 01 __ LDA #$01
2daa : 85 0f __ STA P2 
2dac : 20 1d 0f JSR $0f1d ; (set_compact_tile.s0 + 0)
2daf : 4c b8 23 JMP $23b8 ; (add_walls.s163 + 0)
--------------------------------------------------------------------
2db2 : __ __ __ BYT 0a 0a 50 6c 61 63 69 6e 67 20 77 61 6c 6c 73 00 : ..Placing walls.
--------------------------------------------------------------------
is_walkable_tile: ; is_walkable_tile(u8)->u8
.s0:
2dc2 : c9 02 __ CMP #$02
2dc4 : f0 08 __ BEQ $2dce ; (is_walkable_tile.s1 + 0)
.s5:
2dc6 : c9 03 __ CMP #$03
2dc8 : f0 04 __ BEQ $2dce ; (is_walkable_tile.s1 + 0)
.s4:
2dca : c9 06 __ CMP #$06
2dcc : d0 03 __ BNE $2dd1 ; (is_walkable_tile.s2 + 0)
.s1:
2dce : a9 01 __ LDA #$01
2dd0 : 60 __ __ RTS
.s2:
2dd1 : a9 00 __ LDA #$00
.s1001:
2dd3 : 60 __ __ RTS
--------------------------------------------------------------------
initialize_camera: ; initialize_camera()->void
.s0:
2dd4 : a9 01 __ LDA #$01
2dd6 : 85 14 __ STA P7 
2dd8 : 20 4d 2e JSR $2e4d ; (init_room_center_cache.s0 + 0)
2ddb : ad e8 35 LDA $35e8 ; (room_count + 0)
2dde : f0 14 __ BEQ $2df4 ; (initialize_camera.s1001 + 0)
.s1:
2de0 : ad e9 35 LDA $35e9 ; (room_center_cache_valid + 0)
2de3 : f0 12 __ BEQ $2df7 ; (initialize_camera.s5 + 0)
.s8:
2de5 : ad 64 42 LDA $4264 ; (room_center_cache + 0)
2de8 : 8d e1 35 STA $35e1 ; (camera_center_x + 0)
2deb : ad 65 42 LDA $4265 ; (room_center_cache + 1)
.s1004:
2dee : 8d e2 35 STA $35e2 ; (camera_center_y + 0)
2df1 : 20 e1 2e JSR $2ee1 ; (update_camera.s0 + 0)
.s1001:
2df4 : 4c 3d 2f JMP $2f3d ; (render_map_viewport.s0 + 0)
.s5:
2df7 : ad e8 35 LDA $35e8 ; (room_count + 0)
2dfa : f0 45 __ BEQ $2e41 ; (initialize_camera.s10 + 0)
.s12:
2dfc : ad 22 40 LDA $4022 ; (rooms + 2)
2dff : 38 __ __ SEC
2e00 : e9 01 __ SBC #$01
2e02 : aa __ __ TAX
2e03 : a9 00 __ LDA #$00
2e05 : e9 00 __ SBC #$00
2e07 : a8 __ __ TAY
2e08 : 0a __ __ ASL
2e09 : 8a __ __ TXA
2e0a : 69 00 __ ADC #$00
2e0c : 85 43 __ STA T0 + 0 
2e0e : 98 __ __ TYA
2e0f : 69 00 __ ADC #$00
2e11 : 4a __ __ LSR
2e12 : 66 43 __ ROR T0 + 0 
2e14 : ad 20 40 LDA $4020 ; (rooms + 0)
2e17 : 18 __ __ CLC
2e18 : 65 43 __ ADC T0 + 0 
2e1a : 8d e1 35 STA $35e1 ; (camera_center_x + 0)
2e1d : 8d 64 42 STA $4264 ; (room_center_cache + 0)
2e20 : ad 23 40 LDA $4023 ; (rooms + 3)
2e23 : 38 __ __ SEC
2e24 : e9 01 __ SBC #$01
2e26 : aa __ __ TAX
2e27 : a9 00 __ LDA #$00
2e29 : e9 00 __ SBC #$00
2e2b : a8 __ __ TAY
2e2c : 0a __ __ ASL
2e2d : 8a __ __ TXA
2e2e : 69 00 __ ADC #$00
2e30 : 85 43 __ STA T0 + 0 
2e32 : 98 __ __ TYA
2e33 : 69 00 __ ADC #$00
2e35 : 4a __ __ LSR
2e36 : 66 43 __ ROR T0 + 0 
2e38 : ad 21 40 LDA $4021 ; (rooms + 1)
2e3b : 18 __ __ CLC
2e3c : 65 43 __ ADC T0 + 0 
2e3e : 4c 47 2e JMP $2e47 ; (initialize_camera.s1002 + 0)
.s10:
2e41 : 8d e1 35 STA $35e1 ; (camera_center_x + 0)
2e44 : 8d 64 42 STA $4264 ; (room_center_cache + 0)
.s1002:
2e47 : 8d 65 42 STA $4265 ; (room_center_cache + 1)
2e4a : 4c ee 2d JMP $2dee ; (initialize_camera.s1004 + 0)
--------------------------------------------------------------------
init_room_center_cache: ; init_room_center_cache()->void
.s0:
2e4d : ad e8 35 LDA $35e8 ; (room_count + 0)
2e50 : d0 03 __ BNE $2e55 ; (init_room_center_cache.s21 + 0)
2e52 : 4c db 2e JMP $2edb ; (init_room_center_cache.s4 + 0)
.s21:
2e55 : 85 45 __ STA T4 + 0 
2e57 : a9 00 __ LDA #$00
2e59 : 85 46 __ STA T5 + 0 
.l2:
2e5b : 0a __ __ ASL
2e5c : 85 43 __ STA T1 + 0 
2e5e : a5 46 __ LDA T5 + 0 
2e60 : c5 45 __ CMP T4 + 0 
2e62 : 90 09 __ BCC $2e6d ; (init_room_center_cache.s9 + 0)
.s7:
2e64 : a9 00 __ LDA #$00
2e66 : a6 43 __ LDX T1 + 0 
2e68 : 9d 64 42 STA $4264,x ; (room_center_cache + 0)
2e6b : b0 5f __ BCS $2ecc ; (init_room_center_cache.s12 + 0)
.s9:
2e6d : 85 1b __ STA ACCU + 0 
2e6f : a9 00 __ LDA #$00
2e71 : 85 1c __ STA ACCU + 1 
2e73 : a9 1d __ LDA #$1d
2e75 : 20 19 35 JSR $3519 ; (mul16by8 + 0)
2e78 : 18 __ __ CLC
2e79 : a9 20 __ LDA #$20
2e7b : 65 1b __ ADC ACCU + 0 
2e7d : 85 1b __ STA ACCU + 0 
2e7f : a9 40 __ LDA #$40
2e81 : 65 1c __ ADC ACCU + 1 
2e83 : 85 1c __ STA ACCU + 1 
2e85 : a0 02 __ LDY #$02
2e87 : b1 1b __ LDA (ACCU + 0),y 
2e89 : 38 __ __ SEC
2e8a : e9 01 __ SBC #$01
2e8c : a8 __ __ TAY
2e8d : a9 00 __ LDA #$00
2e8f : e9 00 __ SBC #$00
2e91 : aa __ __ TAX
2e92 : 0a __ __ ASL
2e93 : 98 __ __ TYA
2e94 : 69 00 __ ADC #$00
2e96 : 85 44 __ STA T2 + 0 
2e98 : 8a __ __ TXA
2e99 : 69 00 __ ADC #$00
2e9b : 4a __ __ LSR
2e9c : 66 44 __ ROR T2 + 0 
2e9e : a0 00 __ LDY #$00
2ea0 : b1 1b __ LDA (ACCU + 0),y 
2ea2 : 18 __ __ CLC
2ea3 : 65 44 __ ADC T2 + 0 
2ea5 : a6 43 __ LDX T1 + 0 
2ea7 : 9d 64 42 STA $4264,x ; (room_center_cache + 0)
2eaa : a0 03 __ LDY #$03
2eac : b1 1b __ LDA (ACCU + 0),y 
2eae : 38 __ __ SEC
2eaf : e9 01 __ SBC #$01
2eb1 : a8 __ __ TAY
2eb2 : a9 00 __ LDA #$00
2eb4 : e9 00 __ SBC #$00
2eb6 : aa __ __ TAX
2eb7 : 0a __ __ ASL
2eb8 : 98 __ __ TYA
2eb9 : 69 00 __ ADC #$00
2ebb : 85 44 __ STA T2 + 0 
2ebd : 8a __ __ TXA
2ebe : 69 00 __ ADC #$00
2ec0 : 4a __ __ LSR
2ec1 : 66 44 __ ROR T2 + 0 
2ec3 : a0 01 __ LDY #$01
2ec5 : b1 1b __ LDA (ACCU + 0),y 
2ec7 : 18 __ __ CLC
2ec8 : 65 44 __ ADC T2 + 0 
2eca : a6 43 __ LDX T1 + 0 
.s12:
2ecc : 9d 65 42 STA $4265,x ; (room_center_cache + 1)
2ecf : e6 46 __ INC T5 + 0 
2ed1 : a5 46 __ LDA T5 + 0 
2ed3 : c5 45 __ CMP T4 + 0 
2ed5 : b0 04 __ BCS $2edb ; (init_room_center_cache.s4 + 0)
.s5:
2ed7 : c9 14 __ CMP #$14
2ed9 : 90 80 __ BCC $2e5b ; (init_room_center_cache.l2 + 0)
.s4:
2edb : a9 01 __ LDA #$01
2edd : 8d e9 35 STA $35e9 ; (room_center_cache_valid + 0)
.s1001:
2ee0 : 60 __ __ RTS
--------------------------------------------------------------------
update_camera: ; update_camera()->void
.s0:
2ee1 : ad e1 35 LDA $35e1 ; (camera_center_x + 0)
2ee4 : c9 14 __ CMP #$14
2ee6 : b0 04 __ BCS $2eec ; (update_camera.s5 + 0)
.s6:
2ee8 : a9 00 __ LDA #$00
2eea : 90 02 __ BCC $2eee ; (update_camera.s22 + 0)
.s5:
2eec : e9 14 __ SBC #$14
.s22:
2eee : ac e3 35 LDY $35e3 ; (view + 0)
2ef1 : 8d e3 35 STA $35e3 ; (view + 0)
2ef4 : ad e2 35 LDA $35e2 ; (camera_center_y + 0)
2ef7 : c9 0c __ CMP #$0c
2ef9 : b0 04 __ BCS $2eff ; (update_camera.s8 + 0)
.s9:
2efb : a9 00 __ LDA #$00
2efd : 90 02 __ BCC $2f01 ; (update_camera.s23 + 0)
.s8:
2eff : e9 0c __ SBC #$0c
.s23:
2f01 : ae e4 35 LDX $35e4 ; (view + 1)
2f04 : 8d e4 35 STA $35e4 ; (view + 1)
2f07 : a9 18 __ LDA #$18
2f09 : cd e3 35 CMP $35e3 ; (view + 0)
2f0c : b0 03 __ BCS $2f11 ; (update_camera.s24 + 0)
.s11:
2f0e : 8d e3 35 STA $35e3 ; (view + 0)
.s24:
2f11 : a9 27 __ LDA #$27
2f13 : cd e4 35 CMP $35e4 ; (view + 1)
2f16 : b0 03 __ BCS $2f1b ; (update_camera.s16 + 0)
.s14:
2f18 : 8d e4 35 STA $35e4 ; (view + 1)
.s16:
2f1b : ad e3 35 LDA $35e3 ; (view + 0)
2f1e : 18 __ __ CLC
2f1f : 69 14 __ ADC #$14
2f21 : 8d e1 35 STA $35e1 ; (camera_center_x + 0)
2f24 : ad e4 35 LDA $35e4 ; (view + 1)
2f27 : 18 __ __ CLC
2f28 : 69 0c __ ADC #$0c
2f2a : 8d e2 35 STA $35e2 ; (camera_center_y + 0)
2f2d : cc e3 35 CPY $35e3 ; (view + 0)
2f30 : d0 05 __ BNE $2f37 ; (update_camera.s17 + 0)
.s20:
2f32 : ec e4 35 CPX $35e4 ; (view + 1)
2f35 : f0 05 __ BEQ $2f3c ; (update_camera.s1001 + 0)
.s17:
2f37 : a9 01 __ LDA #$01
2f39 : 8d e5 35 STA $35e5 ; (screen_dirty + 0)
.s1001:
2f3c : 60 __ __ RTS
--------------------------------------------------------------------
render_map_viewport: ; render_map_viewport(u8)->void
.s0:
2f3d : a5 14 __ LDA P7 ; (force_refresh + 0)
2f3f : f0 0f __ BEQ $2f50 ; (render_map_viewport.s3 + 0)
.s1:
2f41 : 20 f4 08 JSR $08f4 ; (clrscr.s0 + 0)
2f44 : a9 00 __ LDA #$00
2f46 : 8d e6 35 STA $35e6 ; (last_scroll_direction + 0)
2f49 : a9 01 __ LDA #$01
2f4b : 8d e5 35 STA $35e5 ; (screen_dirty + 0)
2f4e : d0 05 __ BNE $2f55 ; (render_map_viewport.s6 + 0)
.s3:
2f50 : ad e5 35 LDA $35e5 ; (screen_dirty + 0)
2f53 : f0 18 __ BEQ $2f6d ; (render_map_viewport.s1001 + 0)
.s6:
2f55 : ad e6 35 LDA $35e6 ; (last_scroll_direction + 0)
2f58 : d0 06 __ BNE $2f60 ; (render_map_viewport.s8 + 0)
.s9:
2f5a : 20 fc 31 JSR $31fc ; (update_full_screen.s0 + 0)
2f5d : 4c 65 2f JMP $2f65 ; (render_map_viewport.s1002 + 0)
.s8:
2f60 : 85 13 __ STA P6 
2f62 : 20 6e 2f JSR $2f6e ; (update_partial_screen.s1000 + 0)
.s1002:
2f65 : a9 00 __ LDA #$00
2f67 : 8d e6 35 STA $35e6 ; (last_scroll_direction + 0)
2f6a : 8d e5 35 STA $35e5 ; (screen_dirty + 0)
.s1001:
2f6d : 60 __ __ RTS
--------------------------------------------------------------------
update_partial_screen: ; update_partial_screen(u8)->void
.s1000:
2f6e : a5 53 __ LDA T6 + 0 
2f70 : 8d f5 9f STA $9ff5 ; (add_walls@stack + 13)
2f73 : a5 54 __ LDA T7 + 0 
2f75 : 8d f6 9f STA $9ff6 ; (add_walls@stack + 14)
.s0:
2f78 : a5 13 __ LDA P6 ; (scroll_dir + 0)
2f7a : f0 1b __ BEQ $2f97 ; (update_partial_screen.s1 + 0)
.s4:
2f7c : c9 05 __ CMP #$05
2f7e : b0 17 __ BCS $2f97 ; (update_partial_screen.s1 + 0)
.s3:
2f80 : c9 03 __ CMP #$03
2f82 : d0 03 __ BNE $2f87 ; (update_partial_screen.s28 + 0)
2f84 : 4c 6e 31 JMP $316e ; (update_partial_screen.s17 + 0)
.s28:
2f87 : b0 03 __ BCS $2f8c ; (update_partial_screen.s29 + 0)
2f89 : 4c 35 30 JMP $3035 ; (update_partial_screen.s30 + 0)
.s29:
2f8c : c9 04 __ CMP #$04
2f8e : d0 0a __ BNE $2f9a ; (update_partial_screen.s1001 + 0)
.s22:
2f90 : ad e3 35 LDA $35e3 ; (view + 0)
2f93 : c9 18 __ CMP #$18
2f95 : 90 0e __ BCC $2fa5 ; (update_partial_screen.s74 + 0)
.s1:
2f97 : 20 fc 31 JSR $31fc ; (update_full_screen.s0 + 0)
.s1001:
2f9a : ad f5 9f LDA $9ff5 ; (add_walls@stack + 13)
2f9d : 85 53 __ STA T6 + 0 
2f9f : ad f6 9f LDA $9ff6 ; (add_walls@stack + 14)
2fa2 : 85 54 __ STA T7 + 0 
2fa4 : 60 __ __ RTS
.s74:
2fa5 : 85 53 __ STA T6 + 0 
2fa7 : a9 00 __ LDA #$00
2fa9 : 85 4b __ STA T1 + 0 
2fab : 85 4d __ STA T2 + 0 
2fad : 85 4e __ STA T2 + 1 
2faf : 85 4f __ STA T3 + 0 
2fb1 : a9 04 __ LDA #$04
2fb3 : 85 50 __ STA T3 + 1 
2fb5 : a9 27 __ LDA #$27
2fb7 : 85 11 __ STA P4 
.l80:
2fb9 : a0 00 __ LDY #$00
.l1015:
2fbb : c8 __ __ INY
2fbc : b1 4f __ LDA (T3 + 0),y 
2fbe : 88 __ __ DEY
2fbf : 91 4f __ STA (T3 + 0),y 
2fc1 : c8 __ __ INY
2fc2 : c0 27 __ CPY #$27
2fc4 : 90 f5 __ BCC $2fbb ; (update_partial_screen.l1015 + 0)
.s1016:
2fc6 : a9 00 __ LDA #$00
2fc8 : 85 12 __ STA P5 
2fca : 18 __ __ CLC
2fcb : a9 38 __ LDA #$38
2fcd : 65 4d __ ADC T2 + 0 
2fcf : 85 51 __ STA T4 + 0 
2fd1 : 85 0d __ STA P0 
2fd3 : a9 36 __ LDA #$36
2fd5 : 65 4e __ ADC T2 + 1 
2fd7 : 85 52 __ STA T4 + 1 
2fd9 : 85 0e __ STA P1 
2fdb : 18 __ __ CLC
2fdc : a5 4d __ LDA T2 + 0 
2fde : 69 39 __ ADC #$39
2fe0 : 85 0f __ STA P2 
2fe2 : a5 4e __ LDA T2 + 1 
2fe4 : 69 36 __ ADC #$36
2fe6 : 85 10 __ STA P3 
2fe8 : 20 06 33 JSR $3306 ; (memmove.s0 + 0)
2feb : 18 __ __ CLC
2fec : a5 53 __ LDA T6 + 0 
2fee : 69 27 __ ADC #$27
2ff0 : 85 0d __ STA P0 
2ff2 : ad e4 35 LDA $35e4 ; (view + 1)
2ff5 : 18 __ __ CLC
2ff6 : 65 4b __ ADC T1 + 0 
2ff8 : 85 0e __ STA P1 
2ffa : 20 51 32 JSR $3251 ; (get_map_tile.s0 + 0)
2ffd : aa __ __ TAX
2ffe : 18 __ __ CLC
2fff : a9 27 __ LDA #$27
3001 : 65 4d __ ADC T2 + 0 
3003 : 85 43 __ STA T0 + 0 
3005 : a9 04 __ LDA #$04
3007 : 65 4e __ ADC T2 + 1 
3009 : 85 44 __ STA T0 + 1 
300b : 8a __ __ TXA
300c : a0 00 __ LDY #$00
300e : 91 43 __ STA (T0 + 0),y 
3010 : a0 27 __ LDY #$27
3012 : 91 51 __ STA (T4 + 0),y 
3014 : 18 __ __ CLC
3015 : a5 4d __ LDA T2 + 0 
3017 : 69 28 __ ADC #$28
3019 : 85 4d __ STA T2 + 0 
301b : 90 02 __ BCC $301f ; (update_partial_screen.s1032 + 0)
.s1031:
301d : e6 4e __ INC T2 + 1 
.s1032:
301f : 18 __ __ CLC
3020 : a5 4f __ LDA T3 + 0 
3022 : 69 28 __ ADC #$28
3024 : 85 4f __ STA T3 + 0 
3026 : 90 02 __ BCC $302a ; (update_partial_screen.s1034 + 0)
.s1033:
3028 : e6 50 __ INC T3 + 1 
.s1034:
302a : e6 4b __ INC T1 + 0 
302c : a5 4b __ LDA T1 + 0 
302e : c9 19 __ CMP #$19
3030 : d0 87 __ BNE $2fb9 ; (update_partial_screen.l80 + 0)
3032 : 4c 9a 2f JMP $2f9a ; (update_partial_screen.s1001 + 0)
.s30:
3035 : c9 01 __ CMP #$01
3037 : f0 03 __ BEQ $303c ; (update_partial_screen.s7 + 0)
3039 : 4c c9 30 JMP $30c9 ; (update_partial_screen.s31 + 0)
.s7:
303c : ad e4 35 LDA $35e4 ; (view + 1)
303f : d0 03 __ BNE $3044 ; (update_partial_screen.s39 + 0)
3041 : 4c 97 2f JMP $2f97 ; (update_partial_screen.s1 + 0)
.s39:
3044 : 85 53 __ STA T6 + 0 
3046 : a9 18 __ LDA #$18
3048 : 85 54 __ STA T7 + 0 
304a : a9 28 __ LDA #$28
304c : 85 11 __ STA P4 
.l41:
304e : a5 54 __ LDA T7 + 0 
3050 : 0a __ __ ASL
3051 : 0a __ __ ASL
3052 : 65 54 __ ADC T7 + 0 
3054 : 0a __ __ ASL
3055 : 0a __ __ ASL
3056 : 85 43 __ STA T0 + 0 
3058 : a9 00 __ LDA #$00
305a : 2a __ __ ROL
305b : 06 43 __ ASL T0 + 0 
305d : 2a __ __ ROL
305e : 85 44 __ STA T0 + 1 
3060 : 09 04 __ ORA #$04
3062 : 85 4e __ STA T2 + 1 
3064 : a9 d8 __ LDA #$d8
3066 : 65 43 __ ADC T0 + 0 
3068 : 85 4b __ STA T1 + 0 
306a : a9 03 __ LDA #$03
306c : 65 44 __ ADC T0 + 1 
306e : 85 4c __ STA T1 + 1 
3070 : a5 43 __ LDA T0 + 0 
3072 : 85 4d __ STA T2 + 0 
3074 : a0 00 __ LDY #$00
.l1011:
3076 : b1 4b __ LDA (T1 + 0),y 
3078 : 91 4d __ STA (T2 + 0),y 
307a : c8 __ __ INY
307b : c0 28 __ CPY #$28
307d : 90 f7 __ BCC $3076 ; (update_partial_screen.l1011 + 0)
.s1012:
307f : a9 00 __ LDA #$00
3081 : 85 12 __ STA P5 
3083 : 18 __ __ CLC
3084 : a9 38 __ LDA #$38
3086 : 65 43 __ ADC T0 + 0 
3088 : 85 0d __ STA P0 
308a : a9 36 __ LDA #$36
308c : 65 44 __ ADC T0 + 1 
308e : 85 0e __ STA P1 
3090 : 18 __ __ CLC
3091 : a9 10 __ LDA #$10
3093 : 65 43 __ ADC T0 + 0 
3095 : 85 0f __ STA P2 
3097 : a9 36 __ LDA #$36
3099 : 65 44 __ ADC T0 + 1 
309b : 85 10 __ STA P3 
309d : 20 06 33 JSR $3306 ; (memmove.s0 + 0)
30a0 : c6 54 __ DEC T7 + 0 
30a2 : d0 aa __ BNE $304e ; (update_partial_screen.l41 + 0)
.s43:
30a4 : a5 53 __ LDA T6 + 0 
30a6 : 85 0e __ STA P1 
30a8 : a9 00 __ LDA #$00
30aa : 85 4b __ STA T1 + 0 
.l1017:
30ac : ad e3 35 LDA $35e3 ; (view + 0)
30af : 18 __ __ CLC
30b0 : 65 4b __ ADC T1 + 0 
30b2 : 85 0d __ STA P0 
30b4 : 20 51 32 JSR $3251 ; (get_map_tile.s0 + 0)
30b7 : a6 4b __ LDX T1 + 0 
30b9 : 9d 00 04 STA $0400,x 
30bc : 9d 38 36 STA $3638,x ; (screen_buffer + 0)
30bf : e8 __ __ INX
30c0 : 86 4b __ STX T1 + 0 
30c2 : e0 28 __ CPX #$28
30c4 : d0 e6 __ BNE $30ac ; (update_partial_screen.l1017 + 0)
30c6 : 4c 9a 2f JMP $2f9a ; (update_partial_screen.s1001 + 0)
.s31:
30c9 : c9 02 __ CMP #$02
30cb : d0 f9 __ BNE $30c6 ; (update_partial_screen.l1017 + 26)
.s12:
30cd : ad e4 35 LDA $35e4 ; (view + 1)
30d0 : c9 27 __ CMP #$27
30d2 : 90 03 __ BCC $30d7 ; (update_partial_screen.s87 + 0)
30d4 : 4c 97 2f JMP $2f97 ; (update_partial_screen.s1 + 0)
.s87:
30d7 : 85 53 __ STA T6 + 0 
30d9 : a9 00 __ LDA #$00
30db : 85 4d __ STA T2 + 0 
30dd : 85 4e __ STA T2 + 1 
30df : 85 4f __ STA T3 + 0 
30e1 : a9 04 __ LDA #$04
30e3 : 85 50 __ STA T3 + 1 
30e5 : 85 52 __ STA T4 + 1 
30e7 : a9 28 __ LDA #$28
30e9 : 85 51 __ STA T4 + 0 
30eb : 85 11 __ STA P4 
.l58:
30ed : a0 00 __ LDY #$00
.l1013:
30ef : b1 51 __ LDA (T4 + 0),y 
30f1 : 91 4f __ STA (T3 + 0),y 
30f3 : c8 __ __ INY
30f4 : c0 28 __ CPY #$28
30f6 : 90 f7 __ BCC $30ef ; (update_partial_screen.l1013 + 0)
.s1014:
30f8 : a9 00 __ LDA #$00
30fa : 85 12 __ STA P5 
30fc : 18 __ __ CLC
30fd : a9 38 __ LDA #$38
30ff : 65 4d __ ADC T2 + 0 
3101 : 85 0d __ STA P0 
3103 : a9 36 __ LDA #$36
3105 : 65 4e __ ADC T2 + 1 
3107 : 85 0e __ STA P1 
3109 : 18 __ __ CLC
310a : a5 4d __ LDA T2 + 0 
310c : 69 60 __ ADC #$60
310e : 85 0f __ STA P2 
3110 : a5 4e __ LDA T2 + 1 
3112 : 69 36 __ ADC #$36
3114 : 85 10 __ STA P3 
3116 : 20 06 33 JSR $3306 ; (memmove.s0 + 0)
3119 : 18 __ __ CLC
311a : a5 51 __ LDA T4 + 0 
311c : 69 28 __ ADC #$28
311e : 85 51 __ STA T4 + 0 
3120 : 90 02 __ BCC $3124 ; (update_partial_screen.s1028 + 0)
.s1027:
3122 : e6 52 __ INC T4 + 1 
.s1028:
3124 : 18 __ __ CLC
3125 : a5 4f __ LDA T3 + 0 
3127 : 69 28 __ ADC #$28
3129 : 85 4f __ STA T3 + 0 
312b : 90 02 __ BCC $312f ; (update_partial_screen.s1030 + 0)
.s1029:
312d : e6 50 __ INC T3 + 1 
.s1030:
312f : 18 __ __ CLC
3130 : a5 4d __ LDA T2 + 0 
3132 : 69 28 __ ADC #$28
3134 : 85 4d __ STA T2 + 0 
3136 : a5 4e __ LDA T2 + 1 
3138 : 69 00 __ ADC #$00
313a : 85 4e __ STA T2 + 1 
313c : c9 03 __ CMP #$03
313e : d0 ad __ BNE $30ed ; (update_partial_screen.l58 + 0)
.s1004:
3140 : a5 4d __ LDA T2 + 0 
3142 : c9 c0 __ CMP #$c0
3144 : d0 a7 __ BNE $30ed ; (update_partial_screen.l58 + 0)
.s56:
3146 : a9 00 __ LDA #$00
3148 : 85 4b __ STA T1 + 0 
.l62:
314a : ad e3 35 LDA $35e3 ; (view + 0)
314d : 18 __ __ CLC
314e : 65 4b __ ADC T1 + 0 
3150 : 85 0d __ STA P0 
3152 : 18 __ __ CLC
3153 : a5 53 __ LDA T6 + 0 
3155 : 69 18 __ ADC #$18
3157 : 85 0e __ STA P1 
3159 : 20 51 32 JSR $3251 ; (get_map_tile.s0 + 0)
315c : a6 4b __ LDX T1 + 0 
315e : 9d c0 07 STA $07c0,x 
3161 : 9d f8 39 STA $39f8,x ; (screen_buffer + 960)
3164 : e8 __ __ INX
3165 : 86 4b __ STX T1 + 0 
3167 : e0 28 __ CPX #$28
3169 : d0 df __ BNE $314a ; (update_partial_screen.l62 + 0)
316b : 4c 9a 2f JMP $2f9a ; (update_partial_screen.s1001 + 0)
.s17:
316e : ad e3 35 LDA $35e3 ; (view + 0)
3171 : d0 03 __ BNE $3176 ; (update_partial_screen.s65 + 0)
3173 : 4c 97 2f JMP $2f97 ; (update_partial_screen.s1 + 0)
.s65:
3176 : 85 53 __ STA T6 + 0 
3178 : a9 00 __ LDA #$00
317a : 85 4b __ STA T1 + 0 
317c : 85 4d __ STA T2 + 0 
317e : 85 4e __ STA T2 + 1 
3180 : a9 ff __ LDA #$ff
3182 : 85 4f __ STA T3 + 0 
3184 : a9 03 __ LDA #$03
3186 : 85 50 __ STA T3 + 1 
3188 : a9 27 __ LDA #$27
318a : 85 11 __ STA P4 
.l71:
318c : a0 27 __ LDY #$27
.l1009:
318e : b1 4f __ LDA (T3 + 0),y 
3190 : c8 __ __ INY
3191 : 91 4f __ STA (T3 + 0),y 
3193 : 88 __ __ DEY
3194 : 88 __ __ DEY
3195 : d0 f7 __ BNE $318e ; (update_partial_screen.l1009 + 0)
.s1010:
3197 : 84 12 __ STY P5 
3199 : 18 __ __ CLC
319a : a9 38 __ LDA #$38
319c : 65 4d __ ADC T2 + 0 
319e : 85 51 __ STA T4 + 0 
31a0 : 85 0f __ STA P2 
31a2 : a9 36 __ LDA #$36
31a4 : 65 4e __ ADC T2 + 1 
31a6 : 85 52 __ STA T4 + 1 
31a8 : 85 10 __ STA P3 
31aa : 18 __ __ CLC
31ab : a5 4d __ LDA T2 + 0 
31ad : 69 39 __ ADC #$39
31af : 85 0d __ STA P0 
31b1 : a5 4e __ LDA T2 + 1 
31b3 : 69 36 __ ADC #$36
31b5 : 85 0e __ STA P1 
31b7 : 20 06 33 JSR $3306 ; (memmove.s0 + 0)
31ba : a5 53 __ LDA T6 + 0 
31bc : 85 0d __ STA P0 
31be : ad e4 35 LDA $35e4 ; (view + 1)
31c1 : 18 __ __ CLC
31c2 : 65 4b __ ADC T1 + 0 
31c4 : 85 0e __ STA P1 
31c6 : 20 51 32 JSR $3251 ; (get_map_tile.s0 + 0)
31c9 : aa __ __ TAX
31ca : 18 __ __ CLC
31cb : a9 04 __ LDA #$04
31cd : 65 4e __ ADC T2 + 1 
31cf : 85 44 __ STA T0 + 1 
31d1 : 8a __ __ TXA
31d2 : a0 00 __ LDY #$00
31d4 : a6 4d __ LDX T2 + 0 
31d6 : 86 43 __ STX T0 + 0 
31d8 : 91 43 __ STA (T0 + 0),y 
31da : 91 51 __ STA (T4 + 0),y 
31dc : 8a __ __ TXA
31dd : 18 __ __ CLC
31de : 69 28 __ ADC #$28
31e0 : 85 4d __ STA T2 + 0 
31e2 : 90 02 __ BCC $31e6 ; (update_partial_screen.s1024 + 0)
.s1023:
31e4 : e6 4e __ INC T2 + 1 
.s1024:
31e6 : 18 __ __ CLC
31e7 : a5 4f __ LDA T3 + 0 
31e9 : 69 28 __ ADC #$28
31eb : 85 4f __ STA T3 + 0 
31ed : 90 02 __ BCC $31f1 ; (update_partial_screen.s1026 + 0)
.s1025:
31ef : e6 50 __ INC T3 + 1 
.s1026:
31f1 : e6 4b __ INC T1 + 0 
31f3 : a5 4b __ LDA T1 + 0 
31f5 : c9 19 __ CMP #$19
31f7 : d0 93 __ BNE $318c ; (update_partial_screen.l71 + 0)
31f9 : 4c 9a 2f JMP $2f9a ; (update_partial_screen.s1001 + 0)
--------------------------------------------------------------------
update_full_screen: ; update_full_screen()->void
.s0:
31fc : a9 00 __ LDA #$00
31fe : 85 45 __ STA T1 + 0 
3200 : 85 46 __ STA T2 + 0 
3202 : a9 04 __ LDA #$04
3204 : 85 47 __ STA T2 + 1 
3206 : a9 38 __ LDA #$38
3208 : 85 48 __ STA T3 + 0 
320a : a9 36 __ LDA #$36
320c : 85 49 __ STA T3 + 1 
.l2:
320e : a9 00 __ LDA #$00
3210 : 85 4a __ STA T4 + 0 
.l6:
3212 : ad e3 35 LDA $35e3 ; (view + 0)
3215 : 18 __ __ CLC
3216 : 65 4a __ ADC T4 + 0 
3218 : 85 0d __ STA P0 
321a : ad e4 35 LDA $35e4 ; (view + 1)
321d : 18 __ __ CLC
321e : 65 45 __ ADC T1 + 0 
3220 : 85 0e __ STA P1 
3222 : 20 51 32 JSR $3251 ; (get_map_tile.s0 + 0)
3225 : a4 4a __ LDY T4 + 0 
3227 : 91 46 __ STA (T2 + 0),y 
3229 : 91 48 __ STA (T3 + 0),y 
322b : c8 __ __ INY
322c : 84 4a __ STY T4 + 0 
322e : c0 28 __ CPY #$28
3230 : d0 e0 __ BNE $3212 ; (update_full_screen.l6 + 0)
.s3:
3232 : 18 __ __ CLC
3233 : a5 48 __ LDA T3 + 0 
3235 : 69 28 __ ADC #$28
3237 : 85 48 __ STA T3 + 0 
3239 : 90 02 __ BCC $323d ; (update_full_screen.s1005 + 0)
.s1004:
323b : e6 49 __ INC T3 + 1 
.s1005:
323d : 18 __ __ CLC
323e : a5 46 __ LDA T2 + 0 
3240 : 69 28 __ ADC #$28
3242 : 85 46 __ STA T2 + 0 
3244 : 90 02 __ BCC $3248 ; (update_full_screen.s1007 + 0)
.s1006:
3246 : e6 47 __ INC T2 + 1 
.s1007:
3248 : e6 45 __ INC T1 + 0 
324a : a5 45 __ LDA T1 + 0 
324c : c9 19 __ CMP #$19
324e : d0 be __ BNE $320e ; (update_full_screen.l2 + 0)
.s1001:
3250 : 60 __ __ RTS
--------------------------------------------------------------------
get_map_tile: ; get_map_tile(u8,u8)->u8
.s0:
3251 : a5 0d __ LDA P0 ; (map_x + 0)
3253 : c9 40 __ CMP #$40
3255 : b0 06 __ BCS $325d ; (get_map_tile.s1 + 0)
.s4:
3257 : a5 0e __ LDA P1 ; (map_y + 0)
3259 : c9 40 __ CMP #$40
325b : 90 03 __ BCC $3260 ; (get_map_tile.s3 + 0)
.s1:
325d : a9 20 __ LDA #$20
.s1001:
325f : 60 __ __ RTS
.s3:
3260 : 85 1c __ STA ACCU + 1 
3262 : 4a __ __ LSR
3263 : aa __ __ TAX
3264 : a9 00 __ LDA #$00
3266 : 6a __ __ ROR
3267 : 85 43 __ STA T1 + 0 
3269 : a9 00 __ LDA #$00
326b : 46 1c __ LSR ACCU + 1 
326d : 6a __ __ ROR
326e : 66 1c __ ROR ACCU + 1 
3270 : 6a __ __ ROR
3271 : 65 43 __ ADC T1 + 0 
3273 : a8 __ __ TAY
3274 : 8a __ __ TXA
3275 : 65 1c __ ADC ACCU + 1 
3277 : aa __ __ TAX
3278 : 98 __ __ TYA
3279 : 18 __ __ CLC
327a : 65 0d __ ADC P0 ; (map_x + 0)
327c : 90 01 __ BCC $327f ; (get_map_tile.s1014 + 0)
.s1013:
327e : e8 __ __ INX
.s1014:
327f : 18 __ __ CLC
3280 : 65 0d __ ADC P0 ; (map_x + 0)
3282 : 90 01 __ BCC $3285 ; (get_map_tile.s1016 + 0)
.s1015:
3284 : e8 __ __ INX
.s1016:
3285 : 18 __ __ CLC
3286 : 65 0d __ ADC P0 ; (map_x + 0)
3288 : a8 __ __ TAY
3289 : 8a __ __ TXA
328a : 69 00 __ ADC #$00
328c : 4a __ __ LSR
328d : 85 44 __ STA T1 + 1 
328f : 98 __ __ TYA
3290 : 6a __ __ ROR
3291 : 46 44 __ LSR T1 + 1 
3293 : 6a __ __ ROR
3294 : 46 44 __ LSR T1 + 1 
3296 : 6a __ __ ROR
3297 : 85 43 __ STA T1 + 0 
3299 : 18 __ __ CLC
329a : a9 3a __ LDA #$3a
329c : 65 44 __ ADC T1 + 1 
329e : 85 44 __ STA T1 + 1 
32a0 : 98 __ __ TYA
32a1 : 29 07 __ AND #$07
32a3 : 85 1b __ STA ACCU + 0 
32a5 : aa __ __ TAX
32a6 : a0 20 __ LDY #$20
32a8 : b1 43 __ LDA (T1 + 0),y 
32aa : e0 00 __ CPX #$00
32ac : f0 04 __ BEQ $32b2 ; (get_map_tile.s1003 + 0)
.l1002:
32ae : 4a __ __ LSR
32af : ca __ __ DEX
32b0 : d0 fc __ BNE $32ae ; (get_map_tile.l1002 + 0)
.s1003:
32b2 : 85 1c __ STA ACCU + 1 
32b4 : a5 1b __ LDA ACCU + 0 
32b6 : c9 06 __ CMP #$06
32b8 : b0 04 __ BCS $32be ; (get_map_tile.s9 + 0)
.s7:
32ba : a5 1c __ LDA ACCU + 1 
32bc : 90 18 __ BCC $32d6 ; (get_map_tile.s6 + 0)
.s9:
32be : a9 08 __ LDA #$08
32c0 : e5 1b __ SBC ACCU + 0 
32c2 : aa __ __ TAX
32c3 : bd 24 36 LDA $3624,x ; (bitshift + 36)
32c6 : 38 __ __ SEC
32c7 : e9 01 __ SBC #$01
32c9 : c8 __ __ INY
32ca : 31 43 __ AND (T1 + 0),y 
32cc : e0 00 __ CPX #$00
32ce : f0 04 __ BEQ $32d4 ; (get_map_tile.s1005 + 0)
.l1006:
32d0 : 0a __ __ ASL
32d1 : ca __ __ DEX
32d2 : d0 fc __ BNE $32d0 ; (get_map_tile.l1006 + 0)
.s1005:
32d4 : 05 1c __ ORA ACCU + 1 
.s6:
32d6 : 29 07 __ AND #$07
32d8 : c9 03 __ CMP #$03
32da : d0 03 __ BNE $32df ; (get_map_tile.s23 + 0)
.s16:
32dc : a9 db __ LDA #$db
32de : 60 __ __ RTS
.s23:
32df : 90 16 __ BCC $32f7 ; (get_map_tile.s25 + 0)
.s24:
32e1 : c9 05 __ CMP #$05
32e3 : d0 03 __ BNE $32e8 ; (get_map_tile.s29 + 0)
.s19:
32e5 : a9 3e __ LDA #$3e
32e7 : 60 __ __ RTS
.s29:
32e8 : b0 03 __ BCS $32ed ; (get_map_tile.s30 + 0)
.s18:
32ea : a9 3c __ LDA #$3c
32ec : 60 __ __ RTS
.s30:
32ed : c9 06 __ CMP #$06
32ef : f0 03 __ BEQ $32f4 ; (get_map_tile.s17 + 0)
32f1 : 4c 5d 32 JMP $325d ; (get_map_tile.s1 + 0)
.s17:
32f4 : a9 5e __ LDA #$5e
32f6 : 60 __ __ RTS
.s25:
32f7 : c9 01 __ CMP #$01
32f9 : d0 03 __ BNE $32fe ; (get_map_tile.s26 + 0)
.s14:
32fb : a9 a0 __ LDA #$a0
32fd : 60 __ __ RTS
.s26:
32fe : 8a __ __ TXA
32ff : 69 ff __ ADC #$ff
3301 : 29 0e __ AND #$0e
3303 : 49 2e __ EOR #$2e
3305 : 60 __ __ RTS
--------------------------------------------------------------------
memmove: ; memmove(void*,const void*,i16)->void*
.s0:
3306 : a5 12 __ LDA P5 ; (size + 1)
3308 : 30 5e __ BMI $3368 ; (memmove.s3 + 0)
.s1006:
330a : 05 11 __ ORA P4 ; (size + 0)
330c : f0 5a __ BEQ $3368 ; (memmove.s3 + 0)
.s1:
330e : a5 0e __ LDA P1 ; (dst + 1)
3310 : c5 10 __ CMP P3 ; (src + 1)
3312 : f0 03 __ BEQ $3317 ; (memmove.s1004 + 0)
3314 : 4c 9a 33 JMP $339a ; (memmove.s1005 + 0)
.s1004:
3317 : a5 0d __ LDA P0 ; (dst + 0)
3319 : c5 0f __ CMP P2 ; (src + 0)
331b : 90 54 __ BCC $3371 ; (memmove.s19 + 0)
.s5:
331d : a5 10 __ LDA P3 ; (src + 1)
331f : c5 0e __ CMP P1 ; (dst + 1)
3321 : d0 04 __ BNE $3327 ; (memmove.s1003 + 0)
.s1002:
3323 : a5 0f __ LDA P2 ; (src + 0)
3325 : c5 0d __ CMP P0 ; (dst + 0)
.s1003:
3327 : b0 3f __ BCS $3368 ; (memmove.s3 + 0)
.s9:
3329 : 18 __ __ CLC
332a : a5 0f __ LDA P2 ; (src + 0)
332c : 65 11 __ ADC P4 ; (size + 0)
332e : 85 43 __ STA T3 + 0 
3330 : a5 10 __ LDA P3 ; (src + 1)
3332 : 65 12 __ ADC P5 ; (size + 1)
3334 : 85 44 __ STA T3 + 1 
3336 : 18 __ __ CLC
3337 : a5 0d __ LDA P0 ; (dst + 0)
3339 : 65 11 __ ADC P4 ; (size + 0)
333b : 85 1b __ STA ACCU + 0 
333d : a5 0e __ LDA P1 ; (dst + 1)
333f : 65 12 __ ADC P5 ; (size + 1)
3341 : 85 1c __ STA ACCU + 1 
3343 : a0 00 __ LDY #$00
3345 : a5 11 __ LDA P4 ; (size + 0)
3347 : f0 02 __ BEQ $334b ; (memmove.s1032 + 0)
.s1014:
3349 : e6 12 __ INC P5 ; (size + 1)
.s1032:
334b : a6 11 __ LDX P4 ; (size + 0)
.l1017:
334d : a5 1b __ LDA ACCU + 0 
334f : d0 02 __ BNE $3353 ; (memmove.s1028 + 0)
.s1027:
3351 : c6 1c __ DEC ACCU + 1 
.s1028:
3353 : c6 1b __ DEC ACCU + 0 
3355 : a5 43 __ LDA T3 + 0 
3357 : d0 02 __ BNE $335b ; (memmove.s1030 + 0)
.s1029:
3359 : c6 44 __ DEC T3 + 1 
.s1030:
335b : c6 43 __ DEC T3 + 0 
335d : b1 43 __ LDA (T3 + 0),y 
335f : 91 1b __ STA (ACCU + 0),y 
3361 : ca __ __ DEX
3362 : d0 e9 __ BNE $334d ; (memmove.l1017 + 0)
.s1018:
3364 : c6 12 __ DEC P5 ; (size + 1)
3366 : d0 e5 __ BNE $334d ; (memmove.l1017 + 0)
.s3:
3368 : a5 0d __ LDA P0 ; (dst + 0)
336a : 85 1b __ STA ACCU + 0 
336c : a5 0e __ LDA P1 ; (dst + 1)
336e : 85 1c __ STA ACCU + 1 
.s1001:
3370 : 60 __ __ RTS
.s19:
3371 : 85 1b __ STA ACCU + 0 
3373 : a5 0e __ LDA P1 ; (dst + 1)
3375 : 85 1c __ STA ACCU + 1 
3377 : a0 00 __ LDY #$00
3379 : a5 11 __ LDA P4 ; (size + 0)
337b : f0 02 __ BEQ $337f ; (memmove.s1031 + 0)
.s1012:
337d : e6 12 __ INC P5 ; (size + 1)
.s1031:
337f : a6 11 __ LDX P4 ; (size + 0)
.l1015:
3381 : b1 0f __ LDA (P2),y ; (src + 0)
3383 : 91 1b __ STA (ACCU + 0),y 
3385 : e6 0f __ INC P2 ; (src + 0)
3387 : d0 02 __ BNE $338b ; (memmove.s1024 + 0)
.s1023:
3389 : e6 10 __ INC P3 ; (src + 1)
.s1024:
338b : e6 1b __ INC ACCU + 0 
338d : d0 02 __ BNE $3391 ; (memmove.s1026 + 0)
.s1025:
338f : e6 1c __ INC ACCU + 1 
.s1026:
3391 : ca __ __ DEX
3392 : d0 ed __ BNE $3381 ; (memmove.l1015 + 0)
.s1016:
3394 : c6 12 __ DEC P5 ; (size + 1)
3396 : d0 e9 __ BNE $3381 ; (memmove.l1015 + 0)
3398 : f0 ce __ BEQ $3368 ; (memmove.s3 + 0)
.s1005:
339a : b0 81 __ BCS $331d ; (memmove.s5 + 0)
.s1033:
339c : a5 0d __ LDA P0 ; (dst + 0)
339e : 90 d1 __ BCC $3371 ; (memmove.s19 + 0)
--------------------------------------------------------------------
convch: ; convch(u8)->u8
.s0:
33a0 : a8 __ __ TAY
33a1 : ad eb 35 LDA $35eb ; (giocharmap + 0)
33a4 : f0 27 __ BEQ $33cd ; (convch.s3 + 0)
.s1:
33a6 : c0 0d __ CPY #$0d
33a8 : d0 03 __ BNE $33ad ; (convch.s5 + 0)
.s4:
33aa : a9 0a __ LDA #$0a
.s1001:
33ac : 60 __ __ RTS
.s5:
33ad : c9 02 __ CMP #$02
33af : 90 1c __ BCC $33cd ; (convch.s3 + 0)
.s7:
33b1 : 98 __ __ TYA
33b2 : c0 41 __ CPY #$41
33b4 : 90 17 __ BCC $33cd ; (convch.s3 + 0)
.s13:
33b6 : c9 db __ CMP #$db
33b8 : b0 13 __ BCS $33cd ; (convch.s3 + 0)
.s10:
33ba : c9 c1 __ CMP #$c1
33bc : 90 03 __ BCC $33c1 ; (convch.s16 + 0)
.s14:
33be : 49 a0 __ EOR #$a0
33c0 : a8 __ __ TAY
.s16:
33c1 : c9 7b __ CMP #$7b
33c3 : b0 08 __ BCS $33cd ; (convch.s3 + 0)
.s20:
33c5 : c9 61 __ CMP #$61
33c7 : b0 06 __ BCS $33cf ; (convch.s17 + 0)
.s21:
33c9 : c9 5b __ CMP #$5b
33cb : 90 02 __ BCC $33cf ; (convch.s17 + 0)
.s3:
33cd : 98 __ __ TYA
33ce : 60 __ __ RTS
.s17:
33cf : 49 20 __ EOR #$20
33d1 : 60 __ __ RTS
--------------------------------------------------------------------
save_compact_map: ; save_compact_map(const u8*)->void
.s0:
33d2 : a5 12 __ LDA P5 ; (filename + 0)
33d4 : 85 0d __ STA P0 
33d6 : a5 13 __ LDA P6 ; (filename + 1)
33d8 : 85 0e __ STA P1 
33da : 20 f4 33 JSR $33f4 ; (krnio_setnam.s0 + 0)
33dd : a9 08 __ LDA #$08
33df : 85 0d __ STA P0 
33e1 : a9 40 __ LDA #$40
33e3 : 85 11 __ STA P4 
33e5 : a9 20 __ LDA #$20
33e7 : 85 0e __ STA P1 
33e9 : a9 3a __ LDA #$3a
33eb : 85 0f __ STA P2 
33ed : a9 20 __ LDA #$20
33ef : 85 10 __ STA P3 
33f1 : 4c 0a 34 JMP $340a ; (krnio_save.s0 + 0)
--------------------------------------------------------------------
krnio_setnam: ; krnio_setnam(const u8*)->void
.s0:
33f4 : a5 0d __ LDA P0 
33f6 : 05 0e __ ORA P1 
33f8 : f0 08 __ BEQ $3402 ; (krnio_setnam.s0 + 14)
33fa : a0 ff __ LDY #$ff
33fc : c8 __ __ INY
33fd : b1 0d __ LDA (P0),y 
33ff : d0 fb __ BNE $33fc ; (krnio_setnam.s0 + 8)
3401 : 98 __ __ TYA
3402 : a6 0d __ LDX P0 
3404 : a4 0e __ LDY P1 
3406 : 20 bd ff JSR $ffbd 
.s1001:
3409 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_save: ; krnio_save(u8,const u8*,const u8*)->bool
.s0:
340a : a9 00 __ LDA #$00
340c : a6 0d __ LDX P0 
340e : a0 00 __ LDY #$00
3410 : 20 ba ff JSR $ffba 
3413 : a9 0e __ LDA #$0e
3415 : a6 10 __ LDX P3 
3417 : a4 11 __ LDY P4 
3419 : 20 d8 ff JSR $ffd8 
341c : a9 00 __ LDA #$00
341e : 2a __ __ ROL
341f : 49 01 __ EOR #$01
3421 : 85 1b __ STA ACCU + 0 
3423 : a5 1b __ LDA ACCU + 0 
3425 : f0 02 __ BEQ $3429 ; (krnio_save.s1001 + 0)
.s1006:
3427 : a9 01 __ LDA #$01
.s1001:
3429 : 60 __ __ RTS
--------------------------------------------------------------------
342a : __ __ __ BYT 4d 41 50 44 41 54 41 2e 42 49 4e 00             : MAPDATA.BIN.
--------------------------------------------------------------------
move_camera_direction: ; move_camera_direction(u8)->void
.s1000:
3436 : a2 03 __ LDX #$03
3438 : b5 53 __ LDA T3 + 0,x 
343a : 9d f1 9f STA $9ff1,x ; (grid_positions + 12)
343d : ca __ __ DEX
343e : 10 f8 __ BPL $3438 ; (move_camera_direction.s1000 + 2)
.s0:
3440 : ad e1 35 LDA $35e1 ; (camera_center_x + 0)
3443 : 85 54 __ STA T4 + 0 
3445 : ad e3 35 LDA $35e3 ; (view + 0)
3448 : 85 55 __ STA T5 + 0 
344a : ad e4 35 LDA $35e4 ; (view + 1)
344d : 85 56 __ STA T6 + 0 
344f : a5 15 __ LDA P8 ; (direction + 0)
3451 : ac e2 35 LDY $35e2 ; (camera_center_y + 0)
3454 : 84 53 __ STY T3 + 0 
3456 : c9 03 __ CMP #$03
3458 : d0 03 __ BNE $345d ; (move_camera_direction.s19 + 0)
345a : 4c 10 35 JMP $3510 ; (move_camera_direction.s10 + 0)
.s19:
345d : b0 03 __ BCS $3462 ; (move_camera_direction.s20 + 0)
345f : 4c f2 34 JMP $34f2 ; (move_camera_direction.s21 + 0)
.s20:
3462 : c9 04 __ CMP #$04
3464 : d0 40 __ BNE $34a6 ; (move_camera_direction.s1001 + 0)
.s14:
3466 : a5 54 __ LDA T4 + 0 
3468 : c9 3f __ CMP #$3f
346a : b0 3a __ BCS $34a6 ; (move_camera_direction.s1001 + 0)
.s15:
346c : 69 01 __ ADC #$01
.s25:
346e : aa __ __ TAX
346f : 98 __ __ TYA
.s1002:
3470 : 8e e1 35 STX $35e1 ; (camera_center_x + 0)
3473 : 8d e2 35 STA $35e2 ; (camera_center_y + 0)
3476 : 20 e1 2e JSR $2ee1 ; (update_camera.s0 + 0)
3479 : a5 55 __ LDA T5 + 0 
347b : cd e3 35 CMP $35e3 ; (view + 0)
347e : d0 07 __ BNE $3487 ; (move_camera_direction.s28 + 0)
.s31:
3480 : a5 56 __ LDA T6 + 0 
3482 : cd e4 35 CMP $35e4 ; (view + 1)
3485 : f0 44 __ BEQ $34cb ; (move_camera_direction.s29 + 0)
.s28:
3487 : ad e4 35 LDA $35e4 ; (view + 1)
348a : c5 56 __ CMP T6 + 0 
348c : a9 00 __ LDA #$00
348e : 85 14 __ STA P7 
3490 : a9 01 __ LDA #$01
3492 : 8d e5 35 STA $35e5 ; (screen_dirty + 0)
3495 : 90 09 __ BCC $34a0 ; (move_camera_direction.s63 + 0)
.s33:
3497 : a5 56 __ LDA T6 + 0 
3499 : cd e4 35 CMP $35e4 ; (view + 1)
349c : b0 13 __ BCS $34b1 ; (move_camera_direction.s36 + 0)
.s35:
349e : a9 02 __ LDA #$02
.s63:
34a0 : 8d e6 35 STA $35e6 ; (last_scroll_direction + 0)
34a3 : 20 3d 2f JSR $2f3d ; (render_map_viewport.s0 + 0)
.s1001:
34a6 : a2 03 __ LDX #$03
34a8 : bd f1 9f LDA $9ff1,x ; (grid_positions + 12)
34ab : 95 53 __ STA T3 + 0,x 
34ad : ca __ __ DEX
34ae : 10 f8 __ BPL $34a8 ; (move_camera_direction.s1001 + 2)
34b0 : 60 __ __ RTS
.s36:
34b1 : ad e3 35 LDA $35e3 ; (view + 0)
34b4 : c5 55 __ CMP T5 + 0 
34b6 : b0 04 __ BCS $34bc ; (move_camera_direction.s39 + 0)
.s38:
34b8 : a9 03 __ LDA #$03
34ba : 90 e4 __ BCC $34a0 ; (move_camera_direction.s63 + 0)
.s39:
34bc : a5 55 __ LDA T5 + 0 
34be : cd e3 35 CMP $35e3 ; (view + 0)
34c1 : b0 04 __ BCS $34c7 ; (move_camera_direction.s42 + 0)
.s41:
34c3 : a9 04 __ LDA #$04
34c5 : 90 d9 __ BCC $34a0 ; (move_camera_direction.s63 + 0)
.s42:
34c7 : a9 00 __ LDA #$00
34c9 : b0 d5 __ BCS $34a0 ; (move_camera_direction.s63 + 0)
.s29:
34cb : ad e2 35 LDA $35e2 ; (camera_center_y + 0)
34ce : c5 53 __ CMP T3 + 0 
34d0 : a9 00 __ LDA #$00
34d2 : 85 14 __ STA P7 
34d4 : a9 01 __ LDA #$01
34d6 : 8d e5 35 STA $35e5 ; (screen_dirty + 0)
34d9 : 90 c5 __ BCC $34a0 ; (move_camera_direction.s63 + 0)
.s45:
34db : a5 53 __ LDA T3 + 0 
34dd : cd e2 35 CMP $35e2 ; (camera_center_y + 0)
34e0 : 90 bc __ BCC $349e ; (move_camera_direction.s35 + 0)
.s48:
34e2 : ad e1 35 LDA $35e1 ; (camera_center_x + 0)
34e5 : c5 54 __ CMP T4 + 0 
34e7 : 90 cf __ BCC $34b8 ; (move_camera_direction.s38 + 0)
.s51:
34e9 : a5 54 __ LDA T4 + 0 
34eb : cd e1 35 CMP $35e1 ; (camera_center_x + 0)
34ee : b0 d7 __ BCS $34c7 ; (move_camera_direction.s42 + 0)
34f0 : 90 d1 __ BCC $34c3 ; (move_camera_direction.s41 + 0)
.s21:
34f2 : a6 54 __ LDX T4 + 0 
34f4 : c9 01 __ CMP #$01
34f6 : d0 09 __ BNE $3501 ; (move_camera_direction.s22 + 0)
.s2:
34f8 : a5 53 __ LDA T3 + 0 
34fa : f0 aa __ BEQ $34a6 ; (move_camera_direction.s1001 + 0)
.s3:
34fc : 69 fe __ ADC #$fe
34fe : 4c 70 34 JMP $3470 ; (move_camera_direction.s1002 + 0)
.s22:
3501 : c9 02 __ CMP #$02
3503 : d0 a1 __ BNE $34a6 ; (move_camera_direction.s1001 + 0)
.s6:
3505 : a5 53 __ LDA T3 + 0 
3507 : c9 3f __ CMP #$3f
3509 : b0 9b __ BCS $34a6 ; (move_camera_direction.s1001 + 0)
.s7:
350b : 69 01 __ ADC #$01
350d : 4c 70 34 JMP $3470 ; (move_camera_direction.s1002 + 0)
.s10:
3510 : a5 54 __ LDA T4 + 0 
3512 : f0 92 __ BEQ $34a6 ; (move_camera_direction.s1001 + 0)
.s11:
3514 : 69 fe __ ADC #$fe
3516 : 4c 6e 34 JMP $346e ; (move_camera_direction.s25 + 0)
--------------------------------------------------------------------
mul16by8: ; mul16by8
3519 : 4a __ __ LSR
351a : f0 2e __ BEQ $354a ; (mul16by8 + 49)
351c : a2 00 __ LDX #$00
351e : a0 00 __ LDY #$00
3520 : 90 13 __ BCC $3535 ; (mul16by8 + 28)
3522 : a4 1b __ LDY ACCU + 0 
3524 : a6 1c __ LDX ACCU + 1 
3526 : b0 0d __ BCS $3535 ; (mul16by8 + 28)
3528 : 85 02 __ STA $02 
352a : 18 __ __ CLC
352b : 98 __ __ TYA
352c : 65 1b __ ADC ACCU + 0 
352e : a8 __ __ TAY
352f : 8a __ __ TXA
3530 : 65 1c __ ADC ACCU + 1 
3532 : aa __ __ TAX
3533 : a5 02 __ LDA $02 
3535 : 06 1b __ ASL ACCU + 0 
3537 : 26 1c __ ROL ACCU + 1 
3539 : 4a __ __ LSR
353a : 90 f9 __ BCC $3535 ; (mul16by8 + 28)
353c : d0 ea __ BNE $3528 ; (mul16by8 + 15)
353e : 18 __ __ CLC
353f : 98 __ __ TYA
3540 : 65 1b __ ADC ACCU + 0 
3542 : 85 1b __ STA ACCU + 0 
3544 : 8a __ __ TXA
3545 : 65 1c __ ADC ACCU + 1 
3547 : 85 1c __ STA ACCU + 1 
3549 : 60 __ __ RTS
354a : b0 04 __ BCS $3550 ; (mul16by8 + 55)
354c : 85 1b __ STA ACCU + 0 
354e : 85 1c __ STA ACCU + 1 
3550 : 60 __ __ RTS
--------------------------------------------------------------------
divmod: ; divmod
3551 : a5 1c __ LDA ACCU + 1 
3553 : d0 31 __ BNE $3586 ; (divmod + 53)
3555 : a5 04 __ LDA WORK + 1 
3557 : d0 1e __ BNE $3577 ; (divmod + 38)
3559 : 85 06 __ STA WORK + 3 
355b : a2 04 __ LDX #$04
355d : 06 1b __ ASL ACCU + 0 
355f : 2a __ __ ROL
3560 : c5 03 __ CMP WORK + 0 
3562 : 90 02 __ BCC $3566 ; (divmod + 21)
3564 : e5 03 __ SBC WORK + 0 
3566 : 26 1b __ ROL ACCU + 0 
3568 : 2a __ __ ROL
3569 : c5 03 __ CMP WORK + 0 
356b : 90 02 __ BCC $356f ; (divmod + 30)
356d : e5 03 __ SBC WORK + 0 
356f : 26 1b __ ROL ACCU + 0 
3571 : ca __ __ DEX
3572 : d0 eb __ BNE $355f ; (divmod + 14)
3574 : 85 05 __ STA WORK + 2 
3576 : 60 __ __ RTS
3577 : a5 1b __ LDA ACCU + 0 
3579 : 85 05 __ STA WORK + 2 
357b : a5 1c __ LDA ACCU + 1 
357d : 85 06 __ STA WORK + 3 
357f : a9 00 __ LDA #$00
3581 : 85 1b __ STA ACCU + 0 
3583 : 85 1c __ STA ACCU + 1 
3585 : 60 __ __ RTS
3586 : a5 04 __ LDA WORK + 1 
3588 : d0 1f __ BNE $35a9 ; (divmod + 88)
358a : a5 03 __ LDA WORK + 0 
358c : 30 1b __ BMI $35a9 ; (divmod + 88)
358e : a9 00 __ LDA #$00
3590 : 85 06 __ STA WORK + 3 
3592 : a2 10 __ LDX #$10
3594 : 06 1b __ ASL ACCU + 0 
3596 : 26 1c __ ROL ACCU + 1 
3598 : 2a __ __ ROL
3599 : c5 03 __ CMP WORK + 0 
359b : 90 02 __ BCC $359f ; (divmod + 78)
359d : e5 03 __ SBC WORK + 0 
359f : 26 1b __ ROL ACCU + 0 
35a1 : 26 1c __ ROL ACCU + 1 
35a3 : ca __ __ DEX
35a4 : d0 f2 __ BNE $3598 ; (divmod + 71)
35a6 : 85 05 __ STA WORK + 2 
35a8 : 60 __ __ RTS
35a9 : a9 00 __ LDA #$00
35ab : 85 05 __ STA WORK + 2 
35ad : 85 06 __ STA WORK + 3 
35af : 84 02 __ STY $02 
35b1 : a0 10 __ LDY #$10
35b3 : 18 __ __ CLC
35b4 : 26 1b __ ROL ACCU + 0 
35b6 : 26 1c __ ROL ACCU + 1 
35b8 : 26 05 __ ROL WORK + 2 
35ba : 26 06 __ ROL WORK + 3 
35bc : 38 __ __ SEC
35bd : a5 05 __ LDA WORK + 2 
35bf : e5 03 __ SBC WORK + 0 
35c1 : aa __ __ TAX
35c2 : a5 06 __ LDA WORK + 3 
35c4 : e5 04 __ SBC WORK + 1 
35c6 : 90 04 __ BCC $35cc ; (divmod + 123)
35c8 : 86 05 __ STX WORK + 2 
35ca : 85 06 __ STA WORK + 3 
35cc : 88 __ __ DEY
35cd : d0 e5 __ BNE $35b4 ; (divmod + 99)
35cf : 26 1b __ ROL ACCU + 0 
35d1 : 26 1c __ ROL ACCU + 1 
35d3 : a4 02 __ LDY $02 
35d5 : 60 __ __ RTS
--------------------------------------------------------------------
__multab14L:
35d6 : __ __ __ BYT 00 0e 1c 2a                                     : ...*
--------------------------------------------------------------------
__shltab7L:
35da : __ __ __ BYT 07 0e 1c 38 70 e0                               : ...8p.
--------------------------------------------------------------------
spentry:
35e0 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
camera_center_x:
35e1 : __ __ __ BYT 20                                              :  
--------------------------------------------------------------------
camera_center_y:
35e2 : __ __ __ BYT 20                                              :  
--------------------------------------------------------------------
view:
35e3 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
screen_dirty:
35e5 : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
last_scroll_direction:
35e6 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
rnd_state:
35e7 : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
room_count:
35e8 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
room_center_cache_valid:
35e9 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
distance_cache_valid:
35ea : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
giocharmap:
35eb : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
connected:
35ec : __ __ __ BSS	20
--------------------------------------------------------------------
bitshift:
3600 : __ __ __ BYT 00 00 00 00 00 00 00 00 01 02 04 08 10 20 40 80 : ............. @.
3610 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
3620 : __ __ __ BYT 80 40 20 10 08 04 02 01 00 00 00 00 00 00 00 00 : .@ .............
3630 : __ __ __ BYT 00 00 00 00 00 00 00 00                         : ........
--------------------------------------------------------------------
screen_buffer:
3638 : __ __ __ BSS	1000
--------------------------------------------------------------------
compact_map:
3a20 : __ __ __ BSS	1536
--------------------------------------------------------------------
rooms:
4020 : __ __ __ BSS	580
--------------------------------------------------------------------
room_center_cache:
4264 : __ __ __ BSS	40
--------------------------------------------------------------------
room_distance_cache:
428c : __ __ __ BSS	400
