;-------------------------------------------------------------------------------
; balloon_fight.nes disasembled by DISASM6 v1.5
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; User Defined Labels
;-------------------------------------------------------------------------------
BytesLeftToLoad      = $12
GameTimer            = $19
LoadPointerLow       = $1d
LoadPointerHigh      = $1e
GfxPointerLow        = $1f
GfxPointerHigh       = $20
PlatformLeftLow      = $23
PlatformLeftHigh     = $24
PlatformRightLow     = $25
PlatformRightHigh    = $26
PlatformTopLow       = $27
PlatformTopHigh      = $28
PlatformBottomLow    = $29
PlatformBottonHigh   = $2a
CurrentLevelHeaderPtr = $3b
CurrentPhaseCount    = $3c
GameMode             = $3f
NumberOfPlayers      = $40
Player1Lives         = $41
Player2Lives         = $42
BalloonTripRankUnitDigit = $49
BalloonTripRankTenDigit = $4a
CloudGfxX            = $54
CloudGfxY            = $55
Player1Ballons       = $88
Player2Ballons       = $89
Player1X             = $91
Player2X             = $92
FishX                = $99
Player1Y             = $9a
Player2Y             = $9b
FishY                = $a2
Player1Invincible    = $bd
Player2Invincible    = $be
Player1InvincibleFlash = $bf
Player2InvincibleFlash = $c0
IsBonusPhase         = $c8
PlatformCount        = $cd
CurrentMusic         = $f2
Player1State         = $0451
Player2State         = $0452
BonusPhaseIntensityLevel = $0558
BonusPhasePointMultiplyer = $0559
BonusPhaseRisingBalloonSpeed = $055a
BonusPhaseSuperBonus1 = $055b
BonusPhaseSuperBonus2 = $055c
Player1BonusBallons  = $05cd
Player2BonusBalloon  = $05ce

;-------------------------------------------------------------------------------
; iNES Header
;-------------------------------------------------------------------------------
            .db "NES", $1A                           ; Header
            .db 1                                    ; 1 x 16k PRG banks
            .db 1                                    ; 1 x 8k CHR banks
            .db %00000000                            ; Mirroring: Horizontal
                                                     ; SRAM: Not used
                                                     ; 512k Trainer: Not used
                                                     ; 4 Screen VRAM: Not used
                                                     ; Mapper: 0
            .db %00000000                            ; RomType: NES
            .hex 00 00 00 00                         ; iNES Tail 
            .hex 00 00 00 00                          

;-------------------------------------------------------------------------------
; Program Origin
;-------------------------------------------------------------------------------
            .org $c000                               ; Set program counter

;-------------------------------------------------------------------------------
; ROM Start
;-------------------------------------------------------------------------------
; reset vector
;-------------------------------------------------------------------------------
reset:      lda #$00                                 ; $c000: a9 00     
            sta $2000                                ; $c002: 8d 00 20  
            sta $2001                                ; $c005: 8d 01 20  
__c008:     lda $2002                                ; $c008: ad 02 20  
            bpl __c008                               ; $c00b: 10 fb     
__c00d:     lda $2002                                ; $c00d: ad 02 20  
            bmi __c00d                               ; $c010: 30 fb     
__c012:     lda $2002                                ; $c012: ad 02 20  
            bpl __c012                               ; $c015: 10 fb     
            sei                                      ; $c017: 78        
            cld                                      ; $c018: d8        
            ldx #$ff                                 ; $c019: a2 ff     
            txs                                      ; $c01b: 9a        
            ldx #$12                                 ; $c01c: a2 12     
            lda #$00                                 ; $c01e: a9 00     
__c020:     sta $00,x                                ; $c020: 95 00     
            inx                                      ; $c022: e8        
            bne __c020                               ; $c023: d0 fb     
            ldx #$02                                 ; $c025: a2 02     
__c027:     lda $07fa,x                              ; $c027: bd fa 07  
            cmp __c082,x                             ; $c02a: dd 82 c0  
            bne __c034                               ; $c02d: d0 05     
            dex                                      ; $c02f: ca        
            bpl __c027                               ; $c030: 10 f5     
            bmi __c077                               ; $c032: 30 43     
__c034:     ldx #$00                                 ; $c034: a2 00     
            txa                                      ; $c036: 8a        
__c037:     sta $00,x                                ; $c037: 95 00     
            sta $0700,x                              ; $c039: 9d 00 07  
            inx                                      ; $c03c: e8        
            bne __c037                               ; $c03d: d0 f8     
            lda #$32                                 ; $c03f: a9 32     
            sta $15                                  ; $c041: 85 15     
__c043:     lda #$32                                 ; $c043: a9 32     
            jsr __d6de                               ; $c045: 20 de d6  
            lda #$00                                 ; $c048: a9 00     
            sta $46                                  ; $c04a: 85 46     
            jsr __c579                               ; $c04c: 20 79 c5  
            dec $15                                  ; $c04f: c6 15     
            bne __c043                               ; $c051: d0 f0     
            ldx #$0e                                 ; $c053: a2 0e     
__c055:     lda __c085,x                             ; $c055: bd 85 c0  
            sta $0629,x                              ; $c058: 9d 29 06  
            dex                                      ; $c05b: ca        
            bpl __c055                               ; $c05c: 10 f7     
            ldx #$04                                 ; $c05e: a2 04     
__c060:     lda #$00                                 ; $c060: a9 00     
            sta $03,x                                ; $c062: 95 03     
            dex                                      ; $c064: ca        
            bpl __c060                               ; $c065: 10 f9     
            lda #$00                                 ; $c067: a9 00     
            jsr __d6de                               ; $c069: 20 de d6  
            ldx #$02                                 ; $c06c: a2 02     
__c06e:     lda __c082,x                             ; $c06e: bd 82 c0  
            sta $07fa,x                              ; $c071: 9d fa 07  
            dex                                      ; $c074: ca        
            bpl __c06e                               ; $c075: 10 f7     
__c077:     lda #$1e                                 ; $c077: a9 1e     
            sta $01                                  ; $c079: 85 01     
            lda #$90                                 ; $c07b: a9 90     
            sta $00                                  ; $c07d: 85 00     
            jmp __f1d4                               ; $c07f: 4c d4 f1  

;-------------------------------------------------------------------------------
__c082:     .hex 48 41 4c                            ; $c082: 48 41 4c      Data
__c085:     .hex 00 00 00 01                         ; $c085: 00 00 00 01   Data
            .hex 00 00 00 00                         ; $c089: 00 00 00 00   Data
            .hex 01 00 00 00                         ; $c08d: 01 00 00 00   Data
            .hex 05 02 00                            ; $c091: 05 02 00      Data

;-------------------------------------------------------------------------------
; nmi vector
;-------------------------------------------------------------------------------
nmi:        pha                                      ; $c094: 48        
            txa                                      ; $c095: 8a        
            pha                                      ; $c096: 48        
            tya                                      ; $c097: 98        
            pha                                      ; $c098: 48        
            lda #$00                                 ; $c099: a9 00     
            sta $2003                                ; $c09b: 8d 03 20  
            lda #$02                                 ; $c09e: a9 02     
            sta $4014                                ; $c0a0: 8d 14 40  
            lda $52                                  ; $c0a3: a5 52     
            cmp $53                                  ; $c0a5: c5 53     
            beq __c0ac                               ; $c0a7: f0 03     
            jsr __c17c                               ; $c0a9: 20 7c c1  
__c0ac:     jsr __d60d                               ; $c0ac: 20 0d d6  
            jsr __d798                               ; $c0af: 20 98 d7  
            inc GameTimer                            ; $c0b2: e6 19     
            lda #$20                                 ; $c0b4: a9 20     
            sta $2006                                ; $c0b6: 8d 06 20  
            lda #$00                                 ; $c0b9: a9 00     
            sta $2006                                ; $c0bb: 8d 06 20  
            lda #$00                                 ; $c0be: a9 00     
            sta $2005                                ; $c0c0: 8d 05 20  
            sta $2005                                ; $c0c3: 8d 05 20  
            jsr __fff7                               ; $c0c6: 20 f7 ff  
            lda #$01                                 ; $c0c9: a9 01     
            sta $02                                  ; $c0cb: 85 02     
            lda $16                                  ; $c0cd: a5 16     
            beq __c0f1                               ; $c0cf: f0 20     
__c0d1:     lda $2002                                ; $c0d1: ad 02 20  
            bmi __c0d1                               ; $c0d4: 30 fb     
            ldx #$04                                 ; $c0d6: a2 04     
            ldy #$c6                                 ; $c0d8: a0 c6     
__c0da:     dey                                      ; $c0da: 88        
            bne __c0da                               ; $c0db: d0 fd     
            dex                                      ; $c0dd: ca        
            bne __c0da                               ; $c0de: d0 fa     
            lda $18                                  ; $c0e0: a5 18     
            ora $00                                  ; $c0e2: 05 00     
            sta $2000                                ; $c0e4: 8d 00 20  
            lda $17                                  ; $c0e7: a5 17     
            sta $2005                                ; $c0e9: 8d 05 20  
            lda #$00                                 ; $c0ec: a9 00     
            sta $2005                                ; $c0ee: 8d 05 20  
__c0f1:     pla                                      ; $c0f1: 68        
            tay                                      ; $c0f2: a8        
            pla                                      ; $c0f3: 68        
            tax                                      ; $c0f4: aa        
            pla                                      ; $c0f5: 68        
            rti                                      ; $c0f6: 40        

;-------------------------------------------------------------------------------
; irq/brk vector
;-------------------------------------------------------------------------------
irq:        jmp irq                                  ; $c0f7: 4c f7 c0  

;-------------------------------------------------------------------------------
__c0fa:     lda $00                                  ; $c0fa: a5 00     
            and #$7f                                 ; $c0fc: 29 7f     
__c0fe:     sta $2000                                ; $c0fe: 8d 00 20  
            sta $00                                  ; $c101: 85 00     
            rts                                      ; $c103: 60        

;-------------------------------------------------------------------------------
__c104:     lda $00                                  ; $c104: a5 00     
            ora #$80                                 ; $c106: 09 80     
            bne __c0fe                               ; $c108: d0 f4     
__c10a:     lda #$00                                 ; $c10a: a9 00     
__c10c:     pha                                      ; $c10c: 48        
            jsr __f465                               ; $c10d: 20 65 f4  
            pla                                      ; $c110: 68        
            sta $2001                                ; $c111: 8d 01 20  
            rts                                      ; $c114: 60        

;-------------------------------------------------------------------------------
__c115:     lda $01                                  ; $c115: a5 01     
            bne __c10c                               ; $c117: d0 f3     
__c119:     jsr __c154                               ; $c119: 20 54 c1  
            ldy #$00                                 ; $c11c: a0 00     
__c11e:     lda $0057,y                              ; $c11e: b9 57 00  
            sta $0300,x                              ; $c121: 9d 00 03  
            inx                                      ; $c124: e8        
            iny                                      ; $c125: c8        
            cpy $56                                  ; $c126: c4 56     
            bne __c11e                               ; $c128: d0 f4     
            stx $53                                  ; $c12a: 86 53     
            rts                                      ; $c12c: 60        

;-------------------------------------------------------------------------------
__c12d:     lda #$57                                 ; $c12d: a9 57     
            ldy #$00                                 ; $c12f: a0 00     
__c131:     sta $21                                  ; $c131: 85 21     
            sty $22                                  ; $c133: 84 22     
            txa                                      ; $c135: 8a        
            pha                                      ; $c136: 48        
            ldy #$02                                 ; $c137: a0 02     
            lda ($21),y                              ; $c139: b1 21     
            clc                                      ; $c13b: 18        
            adc #$03                                 ; $c13c: 69 03     
            sta BytesLeftToLoad                      ; $c13e: 85 12     
            ldx $53                                  ; $c140: a6 53     
            ldy #$00                                 ; $c142: a0 00     
__c144:     lda ($21),y                              ; $c144: b1 21     
            sta $0300,x                              ; $c146: 9d 00 03  
            inx                                      ; $c149: e8        
            iny                                      ; $c14a: c8        
            cpy BytesLeftToLoad                      ; $c14b: c4 12     
            bne __c144                               ; $c14d: d0 f5     
            stx $53                                  ; $c14f: 86 53     
            pla                                      ; $c151: 68        
            tax                                      ; $c152: aa        
            rts                                      ; $c153: 60        

;-------------------------------------------------------------------------------
__c154:     ldx $53                                  ; $c154: a6 53     
            lda #$00                                 ; $c156: a9 00     
            sta BytesLeftToLoad                      ; $c158: 85 12     
            lda CloudGfxY                            ; $c15a: a5 55     
            asl                                      ; $c15c: 0a        
            asl                                      ; $c15d: 0a        
            asl                                      ; $c15e: 0a        
            asl                                      ; $c15f: 0a        
            rol BytesLeftToLoad                      ; $c160: 26 12     
            asl                                      ; $c162: 0a        
            rol BytesLeftToLoad                      ; $c163: 26 12     
            ora CloudGfxX                            ; $c165: 05 54     
            pha                                      ; $c167: 48        
            lda BytesLeftToLoad                      ; $c168: a5 12     
            ora #$20                                 ; $c16a: 09 20     
            sta $0300,x                              ; $c16c: 9d 00 03  
            inx                                      ; $c16f: e8        
            pla                                      ; $c170: 68        
            sta $0300,x                              ; $c171: 9d 00 03  
            inx                                      ; $c174: e8        
            lda $56                                  ; $c175: a5 56     
            sta $0300,x                              ; $c177: 9d 00 03  
            inx                                      ; $c17a: e8        
            rts                                      ; $c17b: 60        

;-------------------------------------------------------------------------------
__c17c:     tya                                      ; $c17c: 98        
            pha                                      ; $c17d: 48        
            txa                                      ; $c17e: 8a        
            pha                                      ; $c17f: 48        
            jsr __c188                               ; $c180: 20 88 c1  
            pla                                      ; $c183: 68        
            tax                                      ; $c184: aa        
            pla                                      ; $c185: 68        
            tay                                      ; $c186: a8        
            rts                                      ; $c187: 60        

;-------------------------------------------------------------------------------
__c188:     ldx $52                                  ; $c188: a6 52     
            lda $0300,x                              ; $c18a: bd 00 03  
            inx                                      ; $c18d: e8        
            sta $50                                  ; $c18e: 85 50     
            sta $2006                                ; $c190: 8d 06 20  
            lda $0300,x                              ; $c193: bd 00 03  
            inx                                      ; $c196: e8        
            sta $2006                                ; $c197: 8d 06 20  
            ldy $0300,x                              ; $c19a: bc 00 03  
            inx                                      ; $c19d: e8        
__c19e:     lda $0300,x                              ; $c19e: bd 00 03  
            inx                                      ; $c1a1: e8        
            sta $2007                                ; $c1a2: 8d 07 20  
            dey                                      ; $c1a5: 88        
            bne __c19e                               ; $c1a6: d0 f6     
            lda $50                                  ; $c1a8: a5 50     
            cmp #$3f                                 ; $c1aa: c9 3f     
            bne __c1be                               ; $c1ac: d0 10     
            lda #$3f                                 ; $c1ae: a9 3f     
            sta $2006                                ; $c1b0: 8d 06 20  
            lda #$00                                 ; $c1b3: a9 00     
            sta $2006                                ; $c1b5: 8d 06 20  
            sta $2006                                ; $c1b8: 8d 06 20  
            sta $2006                                ; $c1bb: 8d 06 20  
__c1be:     stx $52                                  ; $c1be: 86 52     
            cpx $53                                  ; $c1c0: e4 53     
            bne __c188                               ; $c1c2: d0 c4     
            rts                                      ; $c1c4: 60        

;-------------------------------------------------------------------------------
__c1c5:     lda #$20                                 ; $c1c5: a9 20     
            sta CurrentMusic                         ; $c1c7: 85 f2     
            jsr __c527                               ; $c1c9: 20 27 c5  
            jsr __c539                               ; $c1cc: 20 39 c5  
            lda #$ff                                 ; $c1cf: a9 ff     
            sta PlatformCount                        ; $c1d1: 85 cd     
            lda #$ad                                 ; $c1d3: a9 ad     
            sta PlatformLeftLow                      ; $c1d5: 85 23     
            lda #$c4                                 ; $c1d7: a9 c4     
            sta PlatformLeftHigh                     ; $c1d9: 85 24     
            lda #$80                                 ; $c1db: a9 80     
            sta Player1X                             ; $c1dd: 85 91     
            sta $0488                                ; $c1df: 8d 88 04  
            lda #$70                                 ; $c1e2: a9 70     
            sta Player1Y                             ; $c1e4: 85 9a     
            jsr __cd4a                               ; $c1e6: 20 4a cd  
            lda #$00                                 ; $c1e9: a9 00     
            sta Player1Lives                         ; $c1eb: 85 41     
            sta $c9                                  ; $c1ed: 85 c9     
            sta $ca                                  ; $c1ef: 85 ca     
            sta $ba                                  ; $c1f1: 85 ba     
            sta $c5                                  ; $c1f3: 85 c5     
            sta IsBonusPhase                         ; $c1f5: 85 c8     
            jsr __f4a5                               ; $c1f7: 20 a5 f4  
            ldx #$13                                 ; $c1fa: a2 13     
__c1fc:     lda #$ff                                 ; $c1fc: a9 ff     
            sta $0530,x                              ; $c1fe: 9d 30 05  
            lda #$f0                                 ; $c201: a9 f0     
            sta $04a4,x                              ; $c203: 9d a4 04  
            dex                                      ; $c206: ca        
            bpl __c1fc                               ; $c207: 10 f3     
__c209:     jsr __f470                               ; $c209: 20 70 f4  
            jsr __e691                               ; $c20c: 20 91 e6  
            lda $c5                                  ; $c20f: a5 c5     
            bne __c216                               ; $c211: d0 03     
            jsr __c6f9                               ; $c213: 20 f9 c6  
__c216:     lda GameTimer                            ; $c216: a5 19     
            lsr                                      ; $c218: 4a        
            bcs __c21e                               ; $c219: b0 03     
            jmp __c2d0                               ; $c21b: 4c d0 c2  

;-------------------------------------------------------------------------------
__c21e:     lda $c5                                  ; $c21e: a5 c5     
            beq __c227                               ; $c220: f0 05     
            dec $c5                                  ; $c222: c6 c5     
            jmp __c2d0                               ; $c224: 4c d0 c2  

;-------------------------------------------------------------------------------
__c227:     lda $17                                  ; $c227: a5 17     
            bne __c231                               ; $c229: d0 06     
            lda $18                                  ; $c22b: a5 18     
            eor #$01                                 ; $c22d: 49 01     
            sta $18                                  ; $c22f: 85 18     
__c231:     dec $17                                  ; $c231: c6 17     
            lda $0488                                ; $c233: ad 88 04  
            beq __c24d                               ; $c236: f0 15     
            inc $0488                                ; $c238: ee 88 04  
            lda $0488                                ; $c23b: ad 88 04  
            cmp #$f0                                 ; $c23e: c9 f0     
            bcc __c247                               ; $c240: 90 05     
            lda #$00                                 ; $c242: a9 00     
            sta $0488                                ; $c244: 8d 88 04  
__c247:     lda Player1Invincible                    ; $c247: a5 bd     
            beq __c24d                               ; $c249: f0 02     
            inc Player1X                             ; $c24b: e6 91     
__c24d:     ldx #$07                                 ; $c24d: a2 07     
__c24f:     lda $055d,x                              ; $c24f: bd 5d 05  
            bmi __c26d                               ; $c252: 30 19     
            inc $0567,x                              ; $c254: fe 67 05  
            lda $0567,x                              ; $c257: bd 67 05  
            cmp #$f8                                 ; $c25a: c9 f8     
            bne __c26d                               ; $c25c: d0 0f     
            lda #$ff                                 ; $c25e: a9 ff     
            sta $055d,x                              ; $c260: 9d 5d 05  
            lda #$f0                                 ; $c263: a9 f0     
            sta $057b,x                              ; $c265: 9d 7b 05  
            lda #$00                                 ; $c268: a9 00     
            sta Player2BonusBalloon                  ; $c26a: 8d ce 05  
__c26d:     dex                                      ; $c26d: ca        
            bpl __c24f                               ; $c26e: 10 df     
            ldx #$13                                 ; $c270: a2 13     
__c272:     lda $0530,x                              ; $c272: bd 30 05  
            bmi __c289                               ; $c275: 30 12     
            inc $0490,x                              ; $c277: fe 90 04  
            lda $0490,x                              ; $c27a: bd 90 04  
            cmp #$f8                                 ; $c27d: c9 f8     
            bcc __c289                               ; $c27f: 90 08     
            lda #$f0                                 ; $c281: a9 f0     
            sta $04a4,x                              ; $c283: 9d a4 04  
            sta $0530,x                              ; $c286: 9d 30 05  
__c289:     dex                                      ; $c289: ca        
            bpl __c272                               ; $c28a: 10 e6     
            lda $17                                  ; $c28c: a5 17     
            and #$07                                 ; $c28e: 29 07     
            bne __c2d0                               ; $c290: d0 3e     
            ldx Player1Ballons                       ; $c292: a6 88     
            dex                                      ; $c294: ca        
            bmi __c2d0                               ; $c295: 30 39     
            lda #$00                                 ; $c297: a9 00     
            sta $3e                                  ; $c299: 85 3e     
            lda #$01                                 ; $c29b: a9 01     
            jsr __d6de                               ; $c29d: 20 de d6  
            inc $c9                                  ; $c2a0: e6 c9     
            lda $c9                                  ; $c2a2: a5 c9     
            and #$1f                                 ; $c2a4: 29 1f     
            bne __c2bc                               ; $c2a6: d0 14     
            inc $ca                                  ; $c2a8: e6 ca     
            lda $ca                                  ; $c2aa: a5 ca     
            cmp #$0a                                 ; $c2ac: c9 0a     
            bne __c2bc                               ; $c2ae: d0 0c     
            lda #$02                                 ; $c2b0: a9 02     
            sta $ca                                  ; $c2b2: 85 ca     
            ldy $ba                                  ; $c2b4: a4 ba     
            iny                                      ; $c2b6: c8        
            tya                                      ; $c2b7: 98        
            and #$03                                 ; $c2b8: 29 03     
            sta $ba                                  ; $c2ba: 85 ba     
__c2bc:     ldx $ca                                  ; $c2bc: a6 ca     
            lda __c3bf,x                             ; $c2be: bd bf c3  
            asl                                      ; $c2c1: 0a        
            tay                                      ; $c2c2: a8        
            lda __c3b5,y                             ; $c2c3: b9 b5 c3  
            sta PlatformRightLow                     ; $c2c6: 85 25     
            lda __c3b6,y                             ; $c2c8: b9 b6 c3  
            sta PlatformRightHigh                    ; $c2cb: 85 26     
            jsr __c3b2                               ; $c2cd: 20 b2 c3  
__c2d0:     ldx #$07                                 ; $c2d0: a2 07     
__c2d2:     lda $055d,x                              ; $c2d2: bd 5d 05  
            bmi __c2ef                               ; $c2d5: 30 18     
            jsr __cece                               ; $c2d7: 20 ce ce  
            lda Player1BonusBallons                  ; $c2da: ad cd 05  
            beq __c2ef                               ; $c2dd: f0 10     
            dec Player1BonusBallons                  ; $c2df: ce cd 05  
            inc Player2BonusBalloon                  ; $c2e2: ee ce 05  
            txa                                      ; $c2e5: 8a        
            pha                                      ; $c2e6: 48        
            lda BonusPhasePointMultiplyer            ; $c2e7: ad 59 05  
            jsr __d6de                               ; $c2ea: 20 de d6  
            pla                                      ; $c2ed: 68        
            tax                                      ; $c2ee: aa        
__c2ef:     jsr __ce2f                               ; $c2ef: 20 2f ce  
            dex                                      ; $c2f2: ca        
            bpl __c2d2                               ; $c2f3: 10 dd     
            ldx #$13                                 ; $c2f5: a2 13     
__c2f7:     lda $0530,x                              ; $c2f7: bd 30 05  
            bmi __c317                               ; $c2fa: 30 1b     
            lda $c5                                  ; $c2fc: a5 c5     
            bne __c314                               ; $c2fe: d0 14     
            jsr __c9b6                               ; $c300: 20 b6 c9  
            lda $04a4,x                              ; $c303: bd a4 04  
            cmp #$02                                 ; $c306: c9 02     
            bcs __c30d                               ; $c308: b0 03     
            jsr __ca4f                               ; $c30a: 20 4f ca  
__c30d:     cmp #$d8                                 ; $c30d: c9 d8     
            bcc __c314                               ; $c30f: 90 03     
            jsr __ca4f                               ; $c311: 20 4f ca  
__c314:     jsr __cb1c                               ; $c314: 20 1c cb  
__c317:     lda GameTimer                            ; $c317: a5 19     
            and #$07                                 ; $c319: 29 07     
            lsr                                      ; $c31b: 4a        
            tay                                      ; $c31c: a8        
            lda __c9dd,y                             ; $c31d: b9 dd c9  
            pha                                      ; $c320: 48        
            lda GameTimer                            ; $c321: a5 19     
            lsr                                      ; $c323: 4a        
            txa                                      ; $c324: 8a        
            bcc __c32d                               ; $c325: 90 06     
            sta BytesLeftToLoad                      ; $c327: 85 12     
            lda #$13                                 ; $c329: a9 13     
            sbc BytesLeftToLoad                      ; $c32b: e5 12     
__c32d:     asl                                      ; $c32d: 0a        
            asl                                      ; $c32e: 0a        
            tay                                      ; $c32f: a8        
            pla                                      ; $c330: 68        
            sta $02b1,y                              ; $c331: 99 b1 02  
            lda $04a4,x                              ; $c334: bd a4 04  
            sta $02b0,y                              ; $c337: 99 b0 02  
            lda $0490,x                              ; $c33a: bd 90 04  
            sta $02b3,y                              ; $c33d: 99 b3 02  
            lda #$00                                 ; $c340: a9 00     
            sta $02b2,y                              ; $c342: 99 b2 02  
            dex                                      ; $c345: ca        
            bpl __c2f7                               ; $c346: 10 af     
            lda Player2BonusBalloon                  ; $c348: ad ce 05  
            cmp #$14                                 ; $c34b: c9 14     
            bcc __c36f                               ; $c34d: 90 20     
            inc $47                                  ; $c34f: e6 47     
            lda #$00                                 ; $c351: a9 00     
            jsr __d6de                               ; $c353: 20 de d6  
            dec $47                                  ; $c356: c6 47     
            lda #$10                                 ; $c358: a9 10     
            sta CurrentMusic                         ; $c35a: 85 f2     
            inc IsBonusPhase                         ; $c35c: e6 c8     
            jsr __d3ed                               ; $c35e: 20 ed d3  
            jsr __c527                               ; $c361: 20 27 c5  
            dec IsBonusPhase                         ; $c364: c6 c8     
            ldx #$64                                 ; $c366: a2 64     
            jsr __f45e                               ; $c368: 20 5e f4  
            lda #$20                                 ; $c36b: a9 20     
            sta CurrentMusic                         ; $c36d: 85 f2     
__c36f:     ldx #$f0                                 ; $c36f: a2 f0     
            lda $0488                                ; $c371: ad 88 04  
            beq __c378                               ; $c374: f0 02     
            ldx #$88                                 ; $c376: a2 88     
__c378:     stx $0200                                ; $c378: 8e 00 02  
            stx $0204                                ; $c37b: 8e 04 02  
            sta $0203                                ; $c37e: 8d 03 02  
            clc                                      ; $c381: 18        
            adc #$08                                 ; $c382: 69 08     
            sta $0207                                ; $c384: 8d 07 02  
            lda GameTimer                            ; $c387: a5 19     
            and #$03                                 ; $c389: 29 03     
            sta $0202                                ; $c38b: 8d 02 02  
            sta $0206                                ; $c38e: 8d 06 02  
            ldx #$e3                                 ; $c391: a2 e3     
            stx $0201                                ; $c393: 8e 01 02  
            inx                                      ; $c396: e8        
            stx $0205                                ; $c397: 8e 05 02  
            lda Player1Ballons                       ; $c39a: a5 88     
            bmi __c3a1                               ; $c39c: 30 03     
            jmp __c209                               ; $c39e: 4c 09 c2  

;-------------------------------------------------------------------------------
__c3a1:     jsr __c579                               ; $c3a1: 20 79 c5  
            lda #$01                                 ; $c3a4: a9 01     
            sta $f0                                  ; $c3a6: 85 f0     
            jsr __f465                               ; $c3a8: 20 65 f4  
            lda #$02                                 ; $c3ab: a9 02     
            sta CurrentMusic                         ; $c3ad: 85 f2     
            jmp __f36a                               ; $c3af: 4c 6a f3  

;-------------------------------------------------------------------------------
__c3b2:     jmp ($0025)                              ; $c3b2: 6c 25 00  

;-------------------------------------------------------------------------------
__c3b5:     .hex c9                                  ; $c3b5: c9            Data
__c3b6:     .hex c3 f7 c3 3e                         ; $c3b6: c3 f7 c3 3e   Data
            .hex c4 5f c4 5e                         ; $c3ba: c4 5f c4 5e   Data
            .hex c4                                  ; $c3be: c4            Data
__c3bf:     .hex 00 00 02 02                         ; $c3bf: 00 00 02 02   Data
            .hex 02 02 02 04                         ; $c3c3: 02 02 02 04   Data
            .hex 03 01                               ; $c3c7: 03 01         Data

;-------------------------------------------------------------------------------
__c3c9:     ldy #$00                                 ; $c3c9: a0 00     
            lda (PlatformLeftLow),y                  ; $c3cb: b1 23     
            inc PlatformLeftLow                      ; $c3cd: e6 23     
            bne __c3d3                               ; $c3cf: d0 02     
            inc PlatformLeftHigh                     ; $c3d1: e6 24     
__c3d3:     tax                                      ; $c3d3: aa        
            beq __c3f6                               ; $c3d4: f0 20     
            asl                                      ; $c3d6: 0a        
            asl                                      ; $c3d7: 0a        
            asl                                      ; $c3d8: 0a        
            sta $15                                  ; $c3d9: 85 15     
            lda #$00                                 ; $c3db: a9 00     
            sta $14                                  ; $c3dd: 85 14     
            txa                                      ; $c3df: 8a        
            and #$c0                                 ; $c3e0: 29 c0     
            cmp #$80                                 ; $c3e2: c9 80     
            bne __c3ec                               ; $c3e4: d0 06     
            jsr __c46b                               ; $c3e6: 20 6b c4  
            jmp __c3c9                               ; $c3e9: 4c c9 c3  

;-------------------------------------------------------------------------------
__c3ec:     cmp #$00                                 ; $c3ec: c9 00     
            bne __c3f6                               ; $c3ee: d0 06     
            jsr __c486                               ; $c3f0: 20 86 c4  
            jmp __c3c9                               ; $c3f3: 4c c9 c3  

;-------------------------------------------------------------------------------
__c3f6:     rts                                      ; $c3f6: 60        

;-------------------------------------------------------------------------------
__c3f7:     jsr __f1b3                               ; $c3f7: 20 b3 f1  
            and #$7f                                 ; $c3fa: 29 7f     
            cmp #$04                                 ; $c3fc: c9 04     
            bcc __c40c                               ; $c3fe: 90 0c     
            cmp #$18                                 ; $c400: c9 18     
            bcs __c40c                               ; $c402: b0 08     
            asl                                      ; $c404: 0a        
            asl                                      ; $c405: 0a        
            asl                                      ; $c406: 0a        
            sta $15                                  ; $c407: 85 15     
            jsr __c46b                               ; $c409: 20 6b c4  
__c40c:     jsr __f1b3                               ; $c40c: 20 b3 f1  
            and #$3f                                 ; $c40f: 29 3f     
            cmp #$02                                 ; $c411: c9 02     
            bcc __c439                               ; $c413: 90 24     
            cmp #$18                                 ; $c415: c9 18     
            bcs __c439                               ; $c417: b0 20     
            asl                                      ; $c419: 0a        
            asl                                      ; $c41a: 0a        
            asl                                      ; $c41b: 0a        
            sta $15                                  ; $c41c: 85 15     
            jsr __f1b3                               ; $c41e: 20 b3 f1  
            and #$3f                                 ; $c421: 29 3f     
            ldx $ba                                  ; $c423: a6 ba     
            adc __c43a,x                             ; $c425: 7d 3a c4  
            sta $14                                  ; $c428: 85 14     
            jsr __c486                               ; $c42a: 20 86 c4  
            jsr __f1b3                               ; $c42d: 20 b3 f1  
            lsr                                      ; $c430: 4a        
            bcc __c40c                               ; $c431: 90 d9     
            jsr __ca4f                               ; $c433: 20 4f ca  
            jmp __c40c                               ; $c436: 4c 0c c4  

;-------------------------------------------------------------------------------
__c439:     rts                                      ; $c439: 60        

;-------------------------------------------------------------------------------
__c43a:     .hex 20 30 40 60                         ; $c43a: 20 30 40 60   Data

;-------------------------------------------------------------------------------
            jsr __f1b3                               ; $c43e: 20 b3 f1  
            and #$cf                                 ; $c441: 29 cf     
            bne __c3f7                               ; $c443: d0 b2     
            ldy Player2Ballons                       ; $c445: a4 89     
            iny                                      ; $c447: c8        
            bne __c3f7                               ; $c448: d0 ad     
            lda #$e6                                 ; $c44a: a9 e6     
            sta Player2Y                             ; $c44c: 85 9b     
            lda $1b                                  ; $c44e: a5 1b     
            and #$7f                                 ; $c450: 29 7f     
            adc #$40                                 ; $c452: 69 40     
            sta Player2X                             ; $c454: 85 92     
            lda #$80                                 ; $c456: a9 80     
            sta Player2Ballons                       ; $c458: 85 89     
            lda #$00                                 ; $c45a: a9 00     
            sta $80                                  ; $c45c: 85 80     
            rts                                      ; $c45e: 60        

;-------------------------------------------------------------------------------
            jsr __c40c                               ; $c45f: 20 0c c4  
            jsr __f1b3                               ; $c462: 20 b3 f1  
            and #$7f                                 ; $c465: 29 7f     
            sta $0508,x                              ; $c467: 9d 08 05  
            rts                                      ; $c46a: 60        

;-------------------------------------------------------------------------------
__c46b:     ldx #$07                                 ; $c46b: a2 07     
__c46d:     lda $055d,x                              ; $c46d: bd 5d 05  
            bmi __c476                               ; $c470: 30 04     
            dex                                      ; $c472: ca        
            bpl __c46d                               ; $c473: 10 f8     
            rts                                      ; $c475: 60        

;-------------------------------------------------------------------------------
__c476:     lda #$01                                 ; $c476: a9 01     
            sta $055d,x                              ; $c478: 9d 5d 05  
            lda #$00                                 ; $c47b: a9 00     
            sta $0567,x                              ; $c47d: 9d 67 05  
            lda $15                                  ; $c480: a5 15     
            sta $057b,x                              ; $c482: 9d 7b 05  
            rts                                      ; $c485: 60        

;-------------------------------------------------------------------------------
__c486:     ldx #$13                                 ; $c486: a2 13     
__c488:     lda $0530,x                              ; $c488: bd 30 05  
            bmi __c491                               ; $c48b: 30 04     
            dex                                      ; $c48d: ca        
            bpl __c488                               ; $c48e: 10 f8     
            rts                                      ; $c490: 60        

;-------------------------------------------------------------------------------
__c491:     lda #$00                                 ; $c491: a9 00     
            sta $0530,x                              ; $c493: 9d 30 05  
            sta $0490,x                              ; $c496: 9d 90 04  
            sta $04f4,x                              ; $c499: 9d f4 04  
            sta $0508,x                              ; $c49c: 9d 08 05  
            sta $04e0,x                              ; $c49f: 9d e0 04  
            lda $14                                  ; $c4a2: a5 14     
            sta $051c,x                              ; $c4a4: 9d 1c 05  
            lda $15                                  ; $c4a7: a5 15     
            sta $04a4,x                              ; $c4a9: 9d a4 04  
            rts                                      ; $c4ac: 60        

;-------------------------------------------------------------------------------
            .hex 00 00 09 00                         ; $c4ad: 00 00 09 00   Data
            .hex 08 8c 00 07                         ; $c4b1: 08 8c 00 07   Data
            .hex 18 00 18 00                         ; $c4b5: 18 00 18 00   Data
            .hex 19 00 1a 00                         ; $c4b9: 19 00 1a 00   Data
            .hex 84 94 1a 00                         ; $c4bd: 84 94 1a 00   Data
            .hex 1a 00 1a 00                         ; $c4c1: 1a 00 1a 00   Data
            .hex 0b 12 00 0c                         ; $c4c5: 0b 12 00 0c   Data
            .hex 13 00 0d 14                         ; $c4c9: 13 00 0d 14   Data
            .hex 00 14 00 00                         ; $c4cd: 00 14 00 00   Data
            .hex 90 00 07 00                         ; $c4d1: 90 00 07 00   Data
            .hex 07 8c 96 00                         ; $c4d5: 07 8c 96 00   Data
            .hex 08 00 09 00                         ; $c4d9: 08 00 09 00   Data
            .hex 00 18 00 17                         ; $c4dd: 00 18 00 17   Data
            .hex 00 16 00 00                         ; $c4e1: 00 16 00 00   Data
            .hex 00 00 00 00                         ; $c4e5: 00 00 00 00   Data
            .hex 8a 90 00 00                         ; $c4e9: 8a 90 00 00   Data
            .hex 00 08 00 09                         ; $c4ed: 00 08 00 09   Data
            .hex 98 00 0a 00                         ; $c4f1: 98 00 0a 00   Data
            .hex 00 00 86 8a                         ; $c4f5: 00 00 86 8a   Data
            .hex 15 00 14 00                         ; $c4f9: 15 00 14 00   Data
            .hex 8e 13 00 00                         ; $c4fd: 8e 13 00 00   Data
            .hex 03 0d 00 0d                         ; $c501: 03 0d 00 0d   Data
            .hex 0e 00 0c 0d                         ; $c505: 0e 00 0c 0d   Data
            .hex 00 0d 19 00                         ; $c509: 00 0d 19 00   Data
            .hex 86 92 00 00                         ; $c50d: 86 92 00 00   Data
            .hex 98 00 00 0a                         ; $c511: 98 00 00 0a   Data
            .hex 12 00 09 13                         ; $c515: 12 00 09 13   Data
            .hex 00 08 14 00                         ; $c519: 00 08 14 00   Data
            .hex 07 15 00 07                         ; $c51d: 07 15 00 07   Data
            .hex 16 00 07 00                         ; $c521: 16 00 07 00   Data
            .hex 00 00                               ; $c525: 00 00         Data

;-------------------------------------------------------------------------------
__c527:     jsr __d0e2                               ; $c527: 20 e2 d0  
            asl BonusPhasePointMultiplyer            ; $c52a: 0e 59 05  
            lda BonusPhasePointMultiplyer            ; $c52d: ad 59 05  
            asl                                      ; $c530: 0a        
            asl                                      ; $c531: 0a        
            adc BonusPhasePointMultiplyer            ; $c532: 6d 59 05  
            sta BonusPhasePointMultiplyer            ; $c535: 8d 59 05  
            rts                                      ; $c538: 60        

;-------------------------------------------------------------------------------
__c539:     lda #$00                                 ; $c539: a9 00     
            sta BytesLeftToLoad                      ; $c53b: 85 12     
__c53d:     lda BytesLeftToLoad                      ; $c53d: a5 12     
            asl                                      ; $c53f: 0a        
            asl                                      ; $c540: 0a        
            adc BytesLeftToLoad                      ; $c541: 65 12     
            sta LoadPointerLow                       ; $c543: 85 1d     
            lda #$07                                 ; $c545: a9 07     
            sta LoadPointerHigh                      ; $c547: 85 1e     
            ldy #$04                                 ; $c549: a0 04     
__c54b:     lda (LoadPointerLow),y                   ; $c54b: b1 1d     
            cmp $0003,y                              ; $c54d: d9 03 00  
            bcc __c563                               ; $c550: 90 11     
            bne __c559                               ; $c552: d0 05     
            dey                                      ; $c554: 88        
            bpl __c54b                               ; $c555: 10 f4     
            bmi __c563                               ; $c557: 30 0a     
__c559:     inc BytesLeftToLoad                      ; $c559: e6 12     
            lda BytesLeftToLoad                      ; $c55b: a5 12     
            cmp #$32                                 ; $c55d: c9 32     
            bne __c53d                               ; $c55f: d0 dc     
            dec BytesLeftToLoad                      ; $c561: c6 12     
__c563:     inc BytesLeftToLoad                      ; $c563: e6 12     
            lda BytesLeftToLoad                      ; $c565: a5 12     
            pha                                      ; $c567: 48        
            sta $43                                  ; $c568: 85 43     
            ldy #$0a                                 ; $c56a: a0 0a     
            jsr __d77c                               ; $c56c: 20 7c d7  
            sta BalloonTripRankTenDigit              ; $c56f: 85 4a     
            lda $43                                  ; $c571: a5 43     
            sta BalloonTripRankUnitDigit             ; $c573: 85 49     
            pla                                      ; $c575: 68        
            sta BytesLeftToLoad                      ; $c576: 85 12     
            rts                                      ; $c578: 60        

;-------------------------------------------------------------------------------
__c579:     jsr __c539                               ; $c579: 20 39 c5  
            dec BytesLeftToLoad                      ; $c57c: c6 12     
            lda #$31                                 ; $c57e: a9 31     
            sec                                      ; $c580: 38        
            sbc BytesLeftToLoad                      ; $c581: e5 12     
            sta $13                                  ; $c583: 85 13     
            asl                                      ; $c585: 0a        
            asl                                      ; $c586: 0a        
            adc $13                                  ; $c587: 65 13     
            tay                                      ; $c589: a8        
            lda BytesLeftToLoad                      ; $c58a: a5 12     
            asl                                      ; $c58c: 0a        
            asl                                      ; $c58d: 0a        
            adc BytesLeftToLoad                      ; $c58e: 65 12     
            sta LoadPointerLow                       ; $c590: 85 1d     
            clc                                      ; $c592: 18        
            adc #$05                                 ; $c593: 69 05     
            sta GfxPointerLow                        ; $c595: 85 1f     
            lda #$07                                 ; $c597: a9 07     
            sta LoadPointerHigh                      ; $c599: 85 1e     
            sta GfxPointerHigh                       ; $c59b: 85 20     
            tya                                      ; $c59d: 98        
            beq __c5ac                               ; $c59e: f0 0c     
            dey                                      ; $c5a0: 88        
__c5a1:     lda (LoadPointerLow),y                   ; $c5a1: b1 1d     
            sta (GfxPointerLow),y                    ; $c5a3: 91 1f     
            dey                                      ; $c5a5: 88        
            bne __c5a1                               ; $c5a6: d0 f9     
            lda (LoadPointerLow),y                   ; $c5a8: b1 1d     
            sta (GfxPointerLow),y                    ; $c5aa: 91 1f     
__c5ac:     ldy #$04                                 ; $c5ac: a0 04     
__c5ae:     lda $0003,y                              ; $c5ae: b9 03 00  
            sta (LoadPointerLow),y                   ; $c5b1: 91 1d     
            dey                                      ; $c5b3: 88        
            bpl __c5ae                               ; $c5b4: 10 f8     
            rts                                      ; $c5b6: 60        

;-------------------------------------------------------------------------------
__c5b7:     .hex 01 02 03 03                         ; $c5b7: 01 02 03 03   Data
__c5bb:     .hex 02 01 ff 03                         ; $c5bb: 02 01 ff 03   Data
            .hex 04 05 06 ff                         ; $c5bf: 04 05 06 ff   Data

;-------------------------------------------------------------------------------
__c5c3:     lda $048d                                ; $c5c3: ad 8d 04  
            lsr                                      ; $c5c6: 4a        
            lsr                                      ; $c5c7: 4a        
            lsr                                      ; $c5c8: 4a        
            tax                                      ; $c5c9: aa        
            lda $048a                                ; $c5ca: ad 8a 04  
            bne __c5d5                               ; $c5cd: d0 06     
            lda __c5b7,x                             ; $c5cf: bd b7 c5  
            jmp __c5d8                               ; $c5d2: 4c d8 c5  

;-------------------------------------------------------------------------------
__c5d5:     lda __c5bb,x                             ; $c5d5: bd bb c5  
__c5d8:     sta $87                                  ; $c5d8: 85 87     
            ldx #$08                                 ; $c5da: a2 08     
            jsr __e3a4                               ; $c5dc: 20 a4 e3  
            lda $048c                                ; $c5df: ad 8c 04  
            beq __c613                               ; $c5e2: f0 2f     
            ldx $048b                                ; $c5e4: ae 8b 04  
            lda $048d                                ; $c5e7: ad 8d 04  
            cmp #$20                                 ; $c5ea: c9 20     
            bne __c5f4                               ; $c5ec: d0 06     
            lda #$ff                                 ; $c5ee: a9 ff     
            sta Player1Ballons,x                     ; $c5f0: 95 88     
            bmi __c610                               ; $c5f2: 30 1c     
__c5f4:     bcs __c613                               ; $c5f4: b0 1d     
            lda $0450                                ; $c5f6: ad 50 04  
            bne __c602                               ; $c5f9: d0 07     
            lda FishX                                ; $c5fb: a5 99     
            clc                                      ; $c5fd: 18        
            adc #$04                                 ; $c5fe: 69 04     
            bne __c607                               ; $c600: d0 05     
__c602:     lda FishX                                ; $c602: a5 99     
            sec                                      ; $c604: 38        
            sbc #$04                                 ; $c605: e9 04     
__c607:     sta Player1X,x                           ; $c607: 95 91     
            lda FishY                                ; $c609: a5 a2     
            sec                                      ; $c60b: 38        
            sbc #$0a                                 ; $c60c: e9 0a     
            sta Player1Y,x                           ; $c60e: 95 9a     
__c610:     jsr __e3a4                               ; $c610: 20 a4 e3  
__c613:     rts                                      ; $c613: 60        

;-------------------------------------------------------------------------------
__c614:     lda #$ff                                 ; $c614: a9 ff     
            sta $048b                                ; $c616: 8d 8b 04  
            ldx #$07                                 ; $c619: a2 07     
__c61b:     lda Player1Ballons,x                     ; $c61b: b5 88     
            bmi __c62b                               ; $c61d: 30 0c     
            lda Player1Y,x                           ; $c61f: b5 9a     
            cmp #$b4                                 ; $c621: c9 b4     
            bcc __c62b                               ; $c623: 90 06     
            lda Player1X,x                           ; $c625: b5 91     
            cmp FishX                                ; $c627: c5 99     
            beq __c62f                               ; $c629: f0 04     
__c62b:     dex                                      ; $c62b: ca        
            bpl __c61b                               ; $c62c: 10 ed     
            rts                                      ; $c62e: 60        

;-------------------------------------------------------------------------------
__c62f:     stx $048b                                ; $c62f: 8e 8b 04  
            lda $0448,x                              ; $c632: bd 48 04  
            sta $0450                                ; $c635: 8d 50 04  
            lda #$00                                 ; $c638: a9 00     
            sta $048a                                ; $c63a: 8d 8a 04  
            sta $048d                                ; $c63d: 8d 8d 04  
            sta $048c                                ; $c640: 8d 8c 04  
            sta $0489                                ; $c643: 8d 89 04  
            lda #$dc                                 ; $c646: a9 dc     
            sta FishY                                ; $c648: 85 a2     
            rts                                      ; $c64a: 60        

;-------------------------------------------------------------------------------
__c64b:     inc FishX                                ; $c64b: e6 99     
            lda FishX                                ; $c64d: a5 99     
            cmp #$b1                                 ; $c64f: c9 b1     
            bcc __c657                               ; $c651: 90 04     
            lda #$40                                 ; $c653: a9 40     
            sta FishX                                ; $c655: 85 99     
__c657:     rts                                      ; $c657: 60        

;-------------------------------------------------------------------------------
__c658:     lda $0489                                ; $c658: ad 89 04  
            bne __c66f                               ; $c65b: d0 12     
            dec FishY                                ; $c65d: c6 a2     
            lda FishY                                ; $c65f: a5 a2     
            cmp #$c4                                 ; $c661: c9 c4     
            bcs __c671                               ; $c663: b0 0c     
            inc FishY                                ; $c665: e6 a2     
            inc $048a                                ; $c667: ee 8a 04  
            inc $0489                                ; $c66a: ee 89 04  
            bne __c671                               ; $c66d: d0 02     
__c66f:     inc FishY                                ; $c66f: e6 a2     
__c671:     inc $048d                                ; $c671: ee 8d 04  
            lda $048d                                ; $c674: ad 8d 04  
            cmp #$18                                 ; $c677: c9 18     
            bne __c6a3                               ; $c679: d0 28     
            ldx $048b                                ; $c67b: ae 8b 04  
            lda Player1Ballons,x                     ; $c67e: b5 88     
            bmi __c6a3                               ; $c680: 30 21     
            lda Player1Y,x                           ; $c682: b5 9a     
            clc                                      ; $c684: 18        
            adc #$10                                 ; $c685: 69 10     
            cmp FishY                                ; $c687: c5 a2     
            bcc __c6a3                               ; $c689: 90 18     
            ldy Player1State,x                       ; $c68b: bc 51 04  
            lda __c6b8,y                             ; $c68e: b9 b8 c6  
            sta Player1State,x                       ; $c691: 9d 51 04  
            lda #$00                                 ; $c694: a9 00     
            sta $7f,x                                ; $c696: 95 7f     
            sta Player1Ballons,x                     ; $c698: 95 88     
            lda CurrentMusic                         ; $c69a: a5 f2     
            ora #$40                                 ; $c69c: 09 40     
            sta CurrentMusic                         ; $c69e: 85 f2     
            inc $048c                                ; $c6a0: ee 8c 04  
__c6a3:     lda $048a                                ; $c6a3: ad 8a 04  
            beq __c6b7                               ; $c6a6: f0 0f     
            lda $048d                                ; $c6a8: ad 8d 04  
            cmp #$28                                 ; $c6ab: c9 28     
            beq __c6b3                               ; $c6ad: f0 04     
            cmp #$30                                 ; $c6af: c9 30     
            bne __c6b7                               ; $c6b1: d0 04     
__c6b3:     lda #$cc                                 ; $c6b3: a9 cc     
            sta FishY                                ; $c6b5: 85 a2     
__c6b7:     rts                                      ; $c6b7: 60        

;-------------------------------------------------------------------------------
__c6b8:     .hex 08 09 0a 0b                         ; $c6b8: 08 09 0a 0b   Data
            .hex 08 09 0a 0b                         ; $c6bc: 08 09 0a 0b   Data
            .hex 08 09 0a 0b                         ; $c6c0: 08 09 0a 0b   Data

;-------------------------------------------------------------------------------
__c6c4:     lda $0489                                ; $c6c4: ad 89 04  
            bne __c6f8                               ; $c6c7: d0 2f     
            ldx $048b                                ; $c6c9: ae 8b 04  
            lda Player1Ballons,x                     ; $c6cc: b5 88     
            bmi __c6e0                               ; $c6ce: 30 10     
            lda Player1Y,x                           ; $c6d0: b5 9a     
            cmp #$b4                                 ; $c6d2: c9 b4     
            bcc __c6e0                               ; $c6d4: 90 0a     
            lda Player1X,x                           ; $c6d6: b5 91     
            cmp #$40                                 ; $c6d8: c9 40     
            bcc __c6e0                               ; $c6da: 90 04     
            cmp #$b1                                 ; $c6dc: c9 b1     
            bcc __c6ee                               ; $c6de: 90 0e     
__c6e0:     lda #$30                                 ; $c6e0: a9 30     
            sec                                      ; $c6e2: 38        
            sbc $048d                                ; $c6e3: ed 8d 04  
            sta $048d                                ; $c6e6: 8d 8d 04  
            inc $0489                                ; $c6e9: ee 89 04  
            bne __c6f8                               ; $c6ec: d0 0a     
__c6ee:     lda Player1X,x                           ; $c6ee: b5 91     
            sta FishX                                ; $c6f0: 85 99     
            lda $0448,x                              ; $c6f2: bd 48 04  
            sta $0450                                ; $c6f5: 8d 50 04  
__c6f8:     rts                                      ; $c6f8: 60        

;-------------------------------------------------------------------------------
__c6f9:     lda $87                                  ; $c6f9: a5 87     
            bpl __c70d                               ; $c6fb: 10 10     
            jsr __c64b                               ; $c6fd: 20 4b c6  
            jsr __c614                               ; $c700: 20 14 c6  
            lda $048b                                ; $c703: ad 8b 04  
            bpl __c709                               ; $c706: 10 01     
            rts                                      ; $c708: 60        

;-------------------------------------------------------------------------------
__c709:     lda #$40                                 ; $c709: a9 40     
            sta $f3                                  ; $c70b: 85 f3     
__c70d:     jsr __c6c4                               ; $c70d: 20 c4 c6  
            jsr __c658                               ; $c710: 20 58 c6  
            jmp __c5c3                               ; $c713: 4c c3 c5  

;-------------------------------------------------------------------------------
__c716:     ldx #$01                                 ; $c716: a2 01     
__c718:     lda #$ff                                 ; $c718: a9 ff     
            sta $0530,x                              ; $c71a: 9d 30 05  
            sta $0544,x                              ; $c71d: 9d 44 05  
            dex                                      ; $c720: ca        
            bpl __c718                               ; $c721: 10 f5     
            jsr __c77a                               ; $c723: 20 7a c7  
__c726:     ldx CurrentPhaseCount                    ; $c726: a6 3c     
            cpx #$18                                 ; $c728: e0 18     
            bcc __c72e                               ; $c72a: 90 02     
            ldx #$18                                 ; $c72c: a2 18     
__c72e:     lda __c748,x                             ; $c72e: bd 48 c7  
            sta $ba                                  ; $c731: 85 ba     
            lda __c761,x                             ; $c733: bd 61 c7  
            sta $b8                                  ; $c736: 85 b8     
            lda #$f0                                 ; $c738: a9 f0     
            sta $02e0                                ; $c73a: 8d e0 02  
            sta $02e4                                ; $c73d: 8d e4 02  
            sta $02e8                                ; $c740: 8d e8 02  
            lda #$03                                 ; $c743: a9 03     
            jmp __c856                               ; $c745: 4c 56 c8  

;-------------------------------------------------------------------------------
__c748:     .hex 00 00 00 00                         ; $c748: 00 00 00 00   Data
            .hex 00 00 00 00                         ; $c74c: 00 00 00 00   Data
            .hex 00 00 01 01                         ; $c750: 00 00 01 01   Data
            .hex 01 01 01 01                         ; $c754: 01 01 01 01   Data
            .hex 02 01 01 01                         ; $c758: 02 01 01 01   Data
            .hex 01 01 01 01                         ; $c75c: 01 01 01 01   Data
            .hex 01                                  ; $c760: 01            Data
__c761:     .hex 0f 0f 0c 0c                         ; $c761: 0f 0f 0c 0c   Data
            .hex 0c 0c 0a 0a                         ; $c765: 0c 0c 0a 0a   Data
            .hex 0a 0a 0c 0c                         ; $c769: 0a 0a 0c 0c   Data
            .hex 0a 0a 0a 08                         ; $c76d: 0a 0a 0a 08   Data
            .hex 0a 0a 08 08                         ; $c771: 0a 0a 08 08   Data
            .hex 08 08 08 08                         ; $c775: 08 08 08 08   Data
            .hex 05                                  ; $c779: 05            Data

;-------------------------------------------------------------------------------
__c77a:     lda $a3                                  ; $c77a: a5 a3     
            bpl __c781                               ; $c77c: 10 03     
__c77e:     sta $a4                                  ; $c77e: 85 a4     
            rts                                      ; $c780: 60        

;-------------------------------------------------------------------------------
__c781:     jsr __f1b3                               ; $c781: 20 b3 f1  
__c784:     cmp $a3                                  ; $c784: c5 a3     
            bcc __c77e                               ; $c786: 90 f6     
            beq __c77e                               ; $c788: f0 f4     
            clc                                      ; $c78a: 18        
            sbc $a3                                  ; $c78b: e5 a3     
            jmp __c784                               ; $c78d: 4c 84 c7  

;-------------------------------------------------------------------------------
__c790:     lda GameTimer                            ; $c790: a5 19     
            and #$7f                                 ; $c792: 29 7f     
            beq __c797                               ; $c794: f0 01     
__c796:     rts                                      ; $c796: 60        

;-------------------------------------------------------------------------------
__c797:     dec $b8                                  ; $c797: c6 b8     
            bne __c796                               ; $c799: d0 fb     
            ldx #$00                                 ; $c79b: a2 00     
            lda $0530,x                              ; $c79d: bd 30 05  
            bmi __c7ad                               ; $c7a0: 30 0b     
            inx                                      ; $c7a2: e8        
            lda $0530,x                              ; $c7a3: bd 30 05  
            bmi __c7ad                               ; $c7a6: 30 05     
            lda #$01                                 ; $c7a8: a9 01     
            sta $b8                                  ; $c7aa: 85 b8     
            rts                                      ; $c7ac: 60        

;-------------------------------------------------------------------------------
__c7ad:     ldy $a4                                  ; $c7ad: a4 a4     
            sty $a5                                  ; $c7af: 84 a5     
            bpl __c7b4                               ; $c7b1: 10 01     
            rts                                      ; $c7b3: 60        

;-------------------------------------------------------------------------------
__c7b4:     lda #$80                                 ; $c7b4: a9 80     
            sta $04b8,x                              ; $c7b6: 9d b8 04  
            sta $04cc,x                              ; $c7b9: 9d cc 04  
            lda #$00                                 ; $c7bc: a9 00     
            sta $0530,x                              ; $c7be: 9d 30 05  
            lda $00b2,y                              ; $c7c1: b9 b2 00  
            sta $0490,x                              ; $c7c4: 9d 90 04  
            lda $00b5,y                              ; $c7c7: b9 b5 00  
            sta $04a4,x                              ; $c7ca: 9d a4 04  
            ldy $ba                                  ; $c7cd: a4 ba     
            jsr __f1b3                               ; $c7cf: 20 b3 f1  
            and #$1f                                 ; $c7d2: 29 1f     
            adc __c89f,y                             ; $c7d4: 79 9f c8  
            sta $0508,x                              ; $c7d7: 9d 08 05  
            lda __c8ab,y                             ; $c7da: b9 ab c8  
            sta $051c,x                              ; $c7dd: 9d 1c 05  
            lda __c8a5,y                             ; $c7e0: b9 a5 c8  
            sta $04e0,x                              ; $c7e3: 9d e0 04  
            lda __c8b1,y                             ; $c7e6: b9 b1 c8  
            sta $04f4,x                              ; $c7e9: 9d f4 04  
            jsr __f1b3                               ; $c7ec: 20 b3 f1  
            and #$03                                 ; $c7ef: 29 03     
            sta $0544,x                              ; $c7f1: 9d 44 05  
            tay                                      ; $c7f4: a8        
            lda __c897,y                             ; $c7f5: b9 97 c8  
            clc                                      ; $c7f8: 18        
            adc $0490,x                              ; $c7f9: 7d 90 04  
            sta $0490,x                              ; $c7fc: 9d 90 04  
            lda __c89b,y                             ; $c7ff: b9 9b c8  
            clc                                      ; $c802: 18        
            adc $04a4,x                              ; $c803: 7d a4 04  
            sta $04a4,x                              ; $c806: 9d a4 04  
            lda __c88f,y                             ; $c809: b9 8f c8  
            beq __c811                               ; $c80c: f0 03     
            jsr __ca3d                               ; $c80e: 20 3d ca  
__c811:     lda __c893,y                             ; $c811: b9 93 c8  
            beq __c819                               ; $c814: f0 03     
            jsr __ca55                               ; $c816: 20 55 ca  
__c819:     lda $ba                                  ; $c819: a5 ba     
            cmp #$05                                 ; $c81b: c9 05     
            bcs __c821                               ; $c81d: b0 02     
            inc $ba                                  ; $c81f: e6 ba     
__c821:     lda #$06                                 ; $c821: a9 06     
            sec                                      ; $c823: 38        
            sbc $ba                                  ; $c824: e5 ba     
            sta $b8                                  ; $c826: 85 b8     
            lda $f0                                  ; $c828: a5 f0     
            ora #$04                                 ; $c82a: 09 04     
            sta $f0                                  ; $c82c: 85 f0     
            jmp __c77a                               ; $c82e: 4c 7a c7  

;-------------------------------------------------------------------------------
__c831:     lda $b8                                  ; $c831: a5 b8     
            cmp #$01                                 ; $c833: c9 01     
            bne __c88a                               ; $c835: d0 53     
            lda $0530                                ; $c837: ad 30 05  
            bmi __c846                               ; $c83a: 30 0a     
            lda $0531                                ; $c83c: ad 31 05  
            bmi __c846                               ; $c83f: 30 05     
            lda #$02                                 ; $c841: a9 02     
            sta $b8                                  ; $c843: 85 b8     
            rts                                      ; $c845: 60        

;-------------------------------------------------------------------------------
__c846:     lda GameTimer                            ; $c846: a5 19     
            and #$7f                                 ; $c848: 29 7f     
            cmp #$40                                 ; $c84a: c9 40     
            bcc __c88a                               ; $c84c: 90 3c     
            bne __c856                               ; $c84e: d0 06     
            lda $f1                                  ; $c850: a5 f1     
            ora #$08                                 ; $c852: 09 08     
            sta $f1                                  ; $c854: 85 f1     
__c856:     and #$03                                 ; $c856: 29 03     
            tax                                      ; $c858: aa        
            lda __c88b,x                             ; $c859: bd 8b c8  
            sta $5a                                  ; $c85c: 85 5a     
            ldx $a4                                  ; $c85e: a6 a4     
            bmi __c88a                               ; $c860: 30 28     
            lda #$23                                 ; $c862: a9 23     
            sta $57                                  ; $c864: 85 57     
            lda $a6,x                                ; $c866: b5 a6     
            sta $58                                  ; $c868: 85 58     
            lda #$01                                 ; $c86a: a9 01     
            sta $59                                  ; $c86c: 85 59     
            jsr __c883                               ; $c86e: 20 83 c8  
            lda $a9,x                                ; $c871: b5 a9     
            sta $58                                  ; $c873: 85 58     
            jsr __c883                               ; $c875: 20 83 c8  
            lda $ac,x                                ; $c878: b5 ac     
            sta $58                                  ; $c87a: 85 58     
            jsr __c883                               ; $c87c: 20 83 c8  
            lda $af,x                                ; $c87f: b5 af     
            sta $58                                  ; $c881: 85 58     
__c883:     lda #$57                                 ; $c883: a9 57     
            ldy #$00                                 ; $c885: a0 00     
            jmp __c131                               ; $c887: 4c 31 c1  

;-------------------------------------------------------------------------------
__c88a:     rts                                      ; $c88a: 60        

;-------------------------------------------------------------------------------
__c88b:     .hex 55 ff 00 ff                         ; $c88b: 55 ff 00 ff   Data
__c88f:     .hex 00 00 ff ff                         ; $c88f: 00 00 ff ff   Data
__c893:     .hex ff 00 00 ff                         ; $c893: ff 00 00 ff   Data
__c897:     .hex 10 10 f0 f0                         ; $c897: 10 10 f0 f0   Data
__c89b:     .hex de 22 22 de                         ; $c89b: de 22 22 de   Data
__c89f:     .hex 60 70 80 90                         ; $c89f: 60 70 80 90   Data
            .hex a0 b0                               ; $c8a3: a0 b0         Data
__c8a5:     .hex 00 00 00 00                         ; $c8a5: 00 00 00 00   Data
            .hex 00 00                               ; $c8a9: 00 00         Data
__c8ab:     .hex c0 f0 20 50                         ; $c8ab: c0 f0 20 50   Data
            .hex 80 b0                               ; $c8af: 80 b0         Data
__c8b1:     .hex 00 00 01 01                         ; $c8b1: 00 00 01 01   Data
            .hex 01 01                               ; $c8b5: 01 01         Data

;-------------------------------------------------------------------------------
__c8b7:     ldx #$01                                 ; $c8b7: a2 01     
__c8b9:     lda $0530,x                              ; $c8b9: bd 30 05  
            bpl __c8c1                               ; $c8bc: 10 03     
            jmp __c9af                               ; $c8be: 4c af c9  

;-------------------------------------------------------------------------------
__c8c1:     lda $0544,x                              ; $c8c1: bd 44 05  
            bmi __c941                               ; $c8c4: 30 7b     
            tay                                      ; $c8c6: a8        
            txa                                      ; $c8c7: 8a        
            pha                                      ; $c8c8: 48        
            ldx $a5                                  ; $c8c9: a6 a5     
            lda $b2,x                                ; $c8cb: b5 b2     
            adc __c9e5,y                             ; $c8cd: 79 e5 c9  
            sta $02e3                                ; $c8d0: 8d e3 02  
            sta $02e7                                ; $c8d3: 8d e7 02  
            sta $02eb                                ; $c8d6: 8d eb 02  
            lda $b5,x                                ; $c8d9: b5 b5     
            adc __c9f5,y                             ; $c8db: 79 f5 c9  
            sta $02e0                                ; $c8de: 8d e0 02  
            adc __ca05,y                             ; $c8e1: 79 05 ca  
            sta $02e4                                ; $c8e4: 8d e4 02  
            adc __ca05,y                             ; $c8e7: 79 05 ca  
            sta $02e8                                ; $c8ea: 8d e8 02  
            tya                                      ; $c8ed: 98        
            and #$03                                 ; $c8ee: 29 03     
            tax                                      ; $c8f0: aa        
            tya                                      ; $c8f1: 98        
            lsr                                      ; $c8f2: 4a        
            lsr                                      ; $c8f3: 4a        
            tay                                      ; $c8f4: a8        
            lda GameTimer                            ; $c8f5: a5 19     
            lsr                                      ; $c8f7: 4a        
            lsr                                      ; $c8f8: 4a        
            bcs __c8ff                               ; $c8f9: b0 04     
            tya                                      ; $c8fb: 98        
            adc #$05                                 ; $c8fc: 69 05     
            tay                                      ; $c8fe: a8        
__c8ff:     lda __ca15,y                             ; $c8ff: b9 15 ca  
            sta $02e1                                ; $c902: 8d e1 02  
            lda __ca1f,y                             ; $c905: b9 1f ca  
            sta $02e5                                ; $c908: 8d e5 02  
            lda __ca29,y                             ; $c90b: b9 29 ca  
            sta $02e9                                ; $c90e: 8d e9 02  
            lda __ca33,x                             ; $c911: bd 33 ca  
            sta $02e2                                ; $c914: 8d e2 02  
            sta $02e6                                ; $c917: 8d e6 02  
            sta $02ea                                ; $c91a: 8d ea 02  
            pla                                      ; $c91d: 68        
            tax                                      ; $c91e: aa        
            lda GameTimer                            ; $c91f: a5 19     
            and #$07                                 ; $c921: 29 07     
            bne __c937                               ; $c923: d0 12     
            lda $0544,x                              ; $c925: bd 44 05  
            clc                                      ; $c928: 18        
            adc #$04                                 ; $c929: 69 04     
            sta $0544,x                              ; $c92b: 9d 44 05  
            cmp #$14                                 ; $c92e: c9 14     
            bcc __c937                               ; $c930: 90 05     
            lda #$ff                                 ; $c932: a9 ff     
            sta $0544,x                              ; $c934: 9d 44 05  
__c937:     lda $0544,x                              ; $c937: bd 44 05  
            cmp #$10                                 ; $c93a: c9 10     
            bcs __c941                               ; $c93c: b0 03     
            jmp __c9af                               ; $c93e: 4c af c9  

;-------------------------------------------------------------------------------
__c941:     jsr __c9b6                               ; $c941: 20 b6 c9  
            lda $0490,x                              ; $c944: bd 90 04  
            cmp #$02                                 ; $c947: c9 02     
            bcs __c94e                               ; $c949: b0 03     
            jsr __ca37                               ; $c94b: 20 37 ca  
__c94e:     lda $0490,x                              ; $c94e: bd 90 04  
            cmp #$f7                                 ; $c951: c9 f7     
            bcc __c958                               ; $c953: 90 03     
            jsr __ca37                               ; $c955: 20 37 ca  
__c958:     lda $04a4,x                              ; $c958: bd a4 04  
            cmp #$02                                 ; $c95b: c9 02     
            bcs __c962                               ; $c95d: b0 03     
            jsr __ca4f                               ; $c95f: 20 4f ca  
__c962:     lda $04a4,x                              ; $c962: bd a4 04  
            cmp #$e0                                 ; $c965: c9 e0     
            bcc __c976                               ; $c967: 90 0d     
            lda #$ff                                 ; $c969: a9 ff     
            sta $0530,x                              ; $c96b: 9d 30 05  
            lda #$f0                                 ; $c96e: a9 f0     
            sta $04a4,x                              ; $c970: 9d a4 04  
            jmp __c9af                               ; $c973: 4c af c9  

;-------------------------------------------------------------------------------
__c976:     jsr __ca67                               ; $c976: 20 67 ca  
            jsr __cb1c                               ; $c979: 20 1c cb  
            ldy $0530,x                              ; $c97c: bc 30 05  
            iny                                      ; $c97f: c8        
            tya                                      ; $c980: 98        
            and #$07                                 ; $c981: 29 07     
            sta $0530,x                              ; $c983: 9d 30 05  
            ldy $0530,x                              ; $c986: bc 30 05  
            lda __c9dd,y                             ; $c989: b9 dd c9  
            sta BytesLeftToLoad                      ; $c98c: 85 12     
            txa                                      ; $c98e: 8a        
            asl                                      ; $c98f: 0a        
            asl                                      ; $c990: 0a        
            clc                                      ; $c991: 18        
            tay                                      ; $c992: a8        
            lda $04a4,x                              ; $c993: bd a4 04  
            cmp #$d0                                 ; $c996: c9 d0     
            sta $0200,y                              ; $c998: 99 00 02  
            lda $0490,x                              ; $c99b: bd 90 04  
            sta $0203,y                              ; $c99e: 99 03 02  
            lda BytesLeftToLoad                      ; $c9a1: a5 12     
            sta $0201,y                              ; $c9a3: 99 01 02  
            lda #$00                                 ; $c9a6: a9 00     
            bcc __c9ac                               ; $c9a8: 90 02     
            lda #$20                                 ; $c9aa: a9 20     
__c9ac:     sta $0202,y                              ; $c9ac: 99 02 02  
__c9af:     dex                                      ; $c9af: ca        
            bmi __c9b5                               ; $c9b0: 30 03     
            jmp __c8b9                               ; $c9b2: 4c b9 c8  

;-------------------------------------------------------------------------------
__c9b5:     rts                                      ; $c9b5: 60        

;-------------------------------------------------------------------------------
__c9b6:     lda $0508,x                              ; $c9b6: bd 08 05  
            clc                                      ; $c9b9: 18        
            adc $04b8,x                              ; $c9ba: 7d b8 04  
            sta $04b8,x                              ; $c9bd: 9d b8 04  
            lda $04e0,x                              ; $c9c0: bd e0 04  
            adc $0490,x                              ; $c9c3: 7d 90 04  
            sta $0490,x                              ; $c9c6: 9d 90 04  
            lda $051c,x                              ; $c9c9: bd 1c 05  
            clc                                      ; $c9cc: 18        
            adc $04cc,x                              ; $c9cd: 7d cc 04  
            sta $04cc,x                              ; $c9d0: 9d cc 04  
            lda $04f4,x                              ; $c9d3: bd f4 04  
            adc $04a4,x                              ; $c9d6: 7d a4 04  
            sta $04a4,x                              ; $c9d9: 9d a4 04  
            rts                                      ; $c9dc: 60        

;-------------------------------------------------------------------------------
__c9dd:     .hex 9d 9e 9f 9e                         ; $c9dd: 9d 9e 9f 9e   Data
            .hex 9d a0 a1 a0                         ; $c9e1: 9d a0 a1 a0   Data
__c9e5:     .hex 08 08 f0 f0                         ; $c9e5: 08 08 f0 f0   Data
            .hex 08 08 f0 f0                         ; $c9e9: 08 08 f0 f0   Data
            .hex 08 08 f0 f0                         ; $c9ed: 08 08 f0 f0   Data
            .hex 08 08 f0 f0                         ; $c9f1: 08 08 f0 f0   Data
__c9f5:     .hex ee 0a 0a ee                         ; $c9f5: ee 0a 0a ee   Data
            .hex ee 0a 0a ee                         ; $c9f9: ee 0a 0a ee   Data
            .hex ee 0a 0a ee                         ; $c9fd: ee 0a 0a ee   Data
            .hex ee 0a 0a ee                         ; $ca01: ee 0a 0a ee   Data
__ca05:     .hex f8 08 08 f8                         ; $ca05: f8 08 08 f8   Data
            .hex f8 08 08 f8                         ; $ca09: f8 08 08 f8   Data
            .hex f8 08 08 f8                         ; $ca0d: f8 08 08 f8   Data
            .hex f8 08 08 f8                         ; $ca11: f8 08 08 f8   Data
__ca15:     .hex 91 93 97 97                         ; $ca15: 91 93 97 97   Data
            .hex fc 92 95 9a                         ; $ca19: fc 92 95 9a   Data
            .hex 9a fc                               ; $ca1d: 9a fc         Data
__ca1f:     .hex fc 94 98 98                         ; $ca1f: fc 94 98 98   Data
            .hex fc fc 96 9b                         ; $ca23: fc fc 96 9b   Data
            .hex 9b fc                               ; $ca27: 9b fc         Data
__ca29:     .hex fc fc 99 99                         ; $ca29: fc fc 99 99   Data
            .hex fc fc fc 9c                         ; $ca2d: fc fc fc 9c   Data
            .hex 9c fc                               ; $ca31: 9c fc         Data
__ca33:     .hex c0 40 00 80                         ; $ca33: c0 40 00 80   Data

;-------------------------------------------------------------------------------
__ca37:     lda $f3                                  ; $ca37: a5 f3     
            ora #$80                                 ; $ca39: 09 80     
            sta $f3                                  ; $ca3b: 85 f3     
__ca3d:     lda #$00                                 ; $ca3d: a9 00     
            sec                                      ; $ca3f: 38        
            sbc $0508,x                              ; $ca40: fd 08 05  
            sta $0508,x                              ; $ca43: 9d 08 05  
            lda #$00                                 ; $ca46: a9 00     
            sbc $04e0,x                              ; $ca48: fd e0 04  
            sta $04e0,x                              ; $ca4b: 9d e0 04  
            rts                                      ; $ca4e: 60        

;-------------------------------------------------------------------------------
__ca4f:     lda $f3                                  ; $ca4f: a5 f3     
            ora #$80                                 ; $ca51: 09 80     
            sta $f3                                  ; $ca53: 85 f3     
__ca55:     lda #$00                                 ; $ca55: a9 00     
            sec                                      ; $ca57: 38        
            sbc $051c,x                              ; $ca58: fd 1c 05  
            sta $051c,x                              ; $ca5b: 9d 1c 05  
            lda #$00                                 ; $ca5e: a9 00     
            sbc $04f4,x                              ; $ca60: fd f4 04  
            sta $04f4,x                              ; $ca63: 9d f4 04  
            rts                                      ; $ca66: 60        

;-------------------------------------------------------------------------------
__ca67:     ldy PlatformCount                        ; $ca67: a4 cd     
__ca69:     lda #$00                                 ; $ca69: a9 00     
            sta $cc                                  ; $ca6b: 85 cc     
            lda (PlatformTopLow),y                   ; $ca6d: b1 27     
            sec                                      ; $ca6f: 38        
            sbc #$08                                 ; $ca70: e9 08     
            cmp $04a4,x                              ; $ca72: dd a4 04  
            bcs __cadd                               ; $ca75: b0 66     
            adc #$03                                 ; $ca77: 69 03     
            cmp $04a4,x                              ; $ca79: dd a4 04  
            bcc __ca82                               ; $ca7c: 90 04     
            lda #$01                                 ; $ca7e: a9 01     
            bne __ca92                               ; $ca80: d0 10     
__ca82:     lda (PlatformBottomLow),y                ; $ca82: b1 29     
            cmp $04a4,x                              ; $ca84: dd a4 04  
            bcc __cadd                               ; $ca87: 90 54     
            sbc #$03                                 ; $ca89: e9 03     
            cmp $04a4,x                              ; $ca8b: dd a4 04  
            bcs __caad                               ; $ca8e: b0 1d     
            lda #$02                                 ; $ca90: a9 02     
__ca92:     sta $cc                                  ; $ca92: 85 cc     
            lda (PlatformLeftLow),y                  ; $ca94: b1 23     
            cmp #$10                                 ; $ca96: c9 10     
            beq __caa2                               ; $ca98: f0 08     
            sec                                      ; $ca9a: 38        
            sbc #$04                                 ; $ca9b: e9 04     
            cmp $0490,x                              ; $ca9d: dd 90 04  
            bcs __caa9                               ; $caa0: b0 07     
__caa2:     lda (PlatformRightLow),y                 ; $caa2: b1 25     
            cmp $0490,x                              ; $caa4: dd 90 04  
            bcs __caad                               ; $caa7: b0 04     
__caa9:     lda #$00                                 ; $caa9: a9 00     
            sta $cc                                  ; $caab: 85 cc     
__caad:     lda (PlatformLeftLow),y                  ; $caad: b1 23     
            cmp #$10                                 ; $caaf: c9 10     
            beq __cac8                               ; $cab1: f0 15     
            sec                                      ; $cab3: 38        
            sbc #$08                                 ; $cab4: e9 08     
            cmp $0490,x                              ; $cab6: dd 90 04  
            bcs __cadd                               ; $cab9: b0 22     
            adc #$03                                 ; $cabb: 69 03     
            cmp $0490,x                              ; $cabd: dd 90 04  
            bcc __cac8                               ; $cac0: 90 06     
            lda $cc                                  ; $cac2: a5 cc     
            ora #$04                                 ; $cac4: 09 04     
            bne __cadb                               ; $cac6: d0 13     
__cac8:     lda (PlatformRightLow),y                 ; $cac8: b1 25     
            cmp #$ff                                 ; $caca: c9 ff     
            beq __cadd                               ; $cacc: f0 0f     
            cmp $0490,x                              ; $cace: dd 90 04  
            bcc __cadd                               ; $cad1: 90 0a     
            sbc #$03                                 ; $cad3: e9 03     
            bcs __cadd                               ; $cad5: b0 06     
            lda $cc                                  ; $cad7: a5 cc     
            ora #$08                                 ; $cad9: 09 08     
__cadb:     sta $cc                                  ; $cadb: 85 cc     
__cadd:     lda $cc                                  ; $cadd: a5 cc     
            bne __cae8                               ; $cadf: d0 07     
__cae1:     dey                                      ; $cae1: 88        
            bmi __cae7                               ; $cae2: 30 03     
            jmp __ca69                               ; $cae4: 4c 69 ca  

;-------------------------------------------------------------------------------
__cae7:     rts                                      ; $cae7: 60        

;-------------------------------------------------------------------------------
__cae8:     lsr $cc                                  ; $cae8: 46 cc     
            bcc __caf4                               ; $caea: 90 08     
            lda $04f4,x                              ; $caec: bd f4 04  
            bmi __caf4                               ; $caef: 30 03     
            jsr __ca4f                               ; $caf1: 20 4f ca  
__caf4:     lsr $cc                                  ; $caf4: 46 cc     
            bcc __cb00                               ; $caf6: 90 08     
            lda $04f4,x                              ; $caf8: bd f4 04  
            bpl __cb00                               ; $cafb: 10 03     
            jsr __ca4f                               ; $cafd: 20 4f ca  
__cb00:     lsr $cc                                  ; $cb00: 46 cc     
            bcc __cb0c                               ; $cb02: 90 08     
            lda $04e0,x                              ; $cb04: bd e0 04  
            bmi __cb0c                               ; $cb07: 30 03     
            jsr __ca37                               ; $cb09: 20 37 ca  
__cb0c:     lsr $cc                                  ; $cb0c: 46 cc     
            bcc __cb18                               ; $cb0e: 90 08     
            lda $04e0,x                              ; $cb10: bd e0 04  
            bpl __cb18                               ; $cb13: 10 03     
            jsr __ca37                               ; $cb15: 20 37 ca  
__cb18:     jmp __cae1                               ; $cb18: 4c e1 ca  

;-------------------------------------------------------------------------------
            rts                                      ; $cb1b: 60        

;-------------------------------------------------------------------------------
__cb1c:     ldy #$01                                 ; $cb1c: a0 01     
__cb1e:     lda $0088,y                              ; $cb1e: b9 88 00  
            bmi __cb70                               ; $cb21: 30 4d     
            beq __cb70                               ; $cb23: f0 4b     
            lda $00bd,y                              ; $cb25: b9 bd 00  
            bne __cb70                               ; $cb28: d0 46     
            lda $0490,x                              ; $cb2a: bd 90 04  
            sec                                      ; $cb2d: 38        
            sbc $0091,y                              ; $cb2e: f9 91 00  
            jsr __f08e                               ; $cb31: 20 8e f0  
            cmp #$08                                 ; $cb34: c9 08     
            bcs __cb70                               ; $cb36: b0 38     
            lda $04a4,x                              ; $cb38: bd a4 04  
            sec                                      ; $cb3b: 38        
            sbc $009a,y                              ; $cb3c: f9 9a 00  
            sec                                      ; $cb3f: 38        
            sbc #$08                                 ; $cb40: e9 08     
            jsr __f08e                               ; $cb42: 20 8e f0  
            cmp #$0c                                 ; $cb45: c9 0c     
            bcs __cb70                               ; $cb47: b0 27     
            lda #$00                                 ; $cb49: a9 00     
            sta $0088,y                              ; $cb4b: 99 88 00  
            lda #$01                                 ; $cb4e: a9 01     
            sta $007f,y                              ; $cb50: 99 7f 00  
            sta $00c1,y                              ; $cb53: 99 c1 00  
            lda #$0b                                 ; $cb56: a9 0b     
            sta Player1State,y                       ; $cb58: 99 51 04  
            lda #$20                                 ; $cb5b: a9 20     
            sta $045a,y                              ; $cb5d: 99 5a 04  
            lda $f0                                  ; $cb60: a5 f0     
            ora #$80                                 ; $cb62: 09 80     
            sta $f0                                  ; $cb64: 85 f0     
            lda #$f0                                 ; $cb66: a9 f0     
            sta $04a4,x                              ; $cb68: 9d a4 04  
            lda #$ff                                 ; $cb6b: a9 ff     
            sta $0530,x                              ; $cb6d: 9d 30 05  
__cb70:     dey                                      ; $cb70: 88        
            bpl __cb1e                               ; $cb71: 10 ab     
            rts                                      ; $cb73: 60        

;-------------------------------------------------------------------------------
__cb74:     ldx $05d1                                ; $cb74: ae d1 05  
            bmi __cba7                               ; $cb77: 30 2e     
__cb79:     jsr __cba8                               ; $cb79: 20 a8 cb  
            lda $0604,x                              ; $cb7c: bd 04 06  
            beq __cba4                               ; $cb7f: f0 23     
            txa                                      ; $cb81: 8a        
            eor GameTimer                            ; $cb82: 45 19     
            and #$01                                 ; $cb84: 29 01     
            bne __cba4                               ; $cb86: d0 1c     
            ldy $05fa,x                              ; $cb88: bc fa 05  
            iny                                      ; $cb8b: c8        
            tya                                      ; $cb8c: 98        
            and #$03                                 ; $cb8d: 29 03     
            sta $05fa,x                              ; $cb8f: 9d fa 05  
            jsr __cccb                               ; $cb92: 20 cb cc  
            lda $05fa,x                              ; $cb95: bd fa 05  
            cmp #$01                                 ; $cb98: c9 01     
            bne __cba4                               ; $cb9a: d0 08     
            dec $060e,x                              ; $cb9c: de 0e 06  
            bne __cba4                               ; $cb9f: d0 03     
            dec $0604,x                              ; $cba1: de 04 06  
__cba4:     dex                                      ; $cba4: ca        
            bpl __cb79                               ; $cba5: 10 d2     
__cba7:     rts                                      ; $cba7: 60        

;-------------------------------------------------------------------------------
__cba8:     ldy #$07                                 ; $cba8: a0 07     
            lda $0604,x                              ; $cbaa: bd 04 06  
            bne __cbb2                               ; $cbad: d0 03     
            jmp __cc3a                               ; $cbaf: 4c 3a cc  

;-------------------------------------------------------------------------------
__cbb2:     lda $0088,y                              ; $cbb2: b9 88 00  
            bmi __cc2f                               ; $cbb5: 30 78     
            beq __cc2f                               ; $cbb7: f0 76     
            cpy #$02                                 ; $cbb9: c0 02     
            bcc __cbc1                               ; $cbbb: 90 04     
            cmp #$01                                 ; $cbbd: c9 01     
            beq __cc2f                               ; $cbbf: f0 6e     
__cbc1:     lda $0091,y                              ; $cbc1: b9 91 00  
            clc                                      ; $cbc4: 18        
            adc #$08                                 ; $cbc5: 69 08     
            sec                                      ; $cbc7: 38        
            sbc $05d2,x                              ; $cbc8: fd d2 05  
            sta BytesLeftToLoad                      ; $cbcb: 85 12     
            jsr __f08e                               ; $cbcd: 20 8e f0  
            cmp #$12                                 ; $cbd0: c9 12     
            bcs __cc2f                               ; $cbd2: b0 5b     
            lda $009a,y                              ; $cbd4: b9 9a 00  
            clc                                      ; $cbd7: 18        
            adc #$0c                                 ; $cbd8: 69 0c     
            sec                                      ; $cbda: 38        
            sbc $05dc,x                              ; $cbdb: fd dc 05  
            sta $13                                  ; $cbde: 85 13     
            jsr __f08e                               ; $cbe0: 20 8e f0  
            cmp #$12                                 ; $cbe3: c9 12     
            bcs __cc2f                               ; $cbe5: b0 48     
            lda BytesLeftToLoad                      ; $cbe7: a5 12     
            bmi __cbfc                               ; $cbe9: 30 11     
            cmp #$03                                 ; $cbeb: c9 03     
            bcc __cc0b                               ; $cbed: 90 1c     
            lda #$02                                 ; $cbef: a9 02     
            sta $041b,y                              ; $cbf1: 99 1b 04  
            jsr __cc33                               ; $cbf4: 20 33 cc  
            jsr __ebbb                               ; $cbf7: 20 bb eb  
            bne __cc0b                               ; $cbfa: d0 0f     
__cbfc:     cmp #$fd                                 ; $cbfc: c9 fd     
            bcs __cc0b                               ; $cbfe: b0 0b     
            lda #$fe                                 ; $cc00: a9 fe     
            sta $041b,y                              ; $cc02: 99 1b 04  
            jsr __ebbb                               ; $cc05: 20 bb eb  
            jsr __cc33                               ; $cc08: 20 33 cc  
__cc0b:     lda $13                                  ; $cc0b: a5 13     
            bmi __cc20                               ; $cc0d: 30 11     
            cmp #$03                                 ; $cc0f: c9 03     
            bcc __cc2f                               ; $cc11: 90 1c     
            lda #$02                                 ; $cc13: a9 02     
            sta $042d,y                              ; $cc15: 99 2d 04  
            jsr __ebb2                               ; $cc18: 20 b2 eb  
            jsr __cc33                               ; $cc1b: 20 33 cc  
            bne __cc2f                               ; $cc1e: d0 0f     
__cc20:     cmp #$fd                                 ; $cc20: c9 fd     
            bcs __cc2f                               ; $cc22: b0 0b     
            lda #$fe                                 ; $cc24: a9 fe     
            sta $042d,y                              ; $cc26: 99 2d 04  
            jsr __ebb2                               ; $cc29: 20 b2 eb  
            jsr __cc33                               ; $cc2c: 20 33 cc  
__cc2f:     dey                                      ; $cc2f: 88        
            bpl __cbb2                               ; $cc30: 10 80     
            rts                                      ; $cc32: 60        

;-------------------------------------------------------------------------------
__cc33:     lda $f1                                  ; $cc33: a5 f1     
            ora #$02                                 ; $cc35: 09 02     
            sta $f1                                  ; $cc37: 85 f1     
            rts                                      ; $cc39: 60        

;-------------------------------------------------------------------------------
__cc3a:     lda $0088,y                              ; $cc3a: b9 88 00  
            bmi __ccb8                               ; $cc3d: 30 79     
            beq __ccb8                               ; $cc3f: f0 77     
            cpy #$02                                 ; $cc41: c0 02     
            bcc __cc73                               ; $cc43: 90 2e     
            lda $05fa,x                              ; $cc45: bd fa 05  
            cmp #$03                                 ; $cc48: c9 03     
            bne __cc73                               ; $cc4a: d0 27     
            lda $05d2,x                              ; $cc4c: bd d2 05  
            sec                                      ; $cc4f: 38        
            sbc #$0a                                 ; $cc50: e9 0a     
            cmp $0091,y                              ; $cc52: d9 91 00  
            bcs __cc73                               ; $cc55: b0 1c     
            adc #$04                                 ; $cc57: 69 04     
            cmp $0091,y                              ; $cc59: d9 91 00  
            bcc __cc73                               ; $cc5c: 90 15     
            lda $05dc,x                              ; $cc5e: bd dc 05  
            sec                                      ; $cc61: 38        
            sbc #$1c                                 ; $cc62: e9 1c     
            cmp $009a,y                              ; $cc64: d9 9a 00  
            bcs __cc73                               ; $cc67: b0 0a     
            adc #$04                                 ; $cc69: 69 04     
            cmp $009a,y                              ; $cc6b: d9 9a 00  
            bcc __cc73                               ; $cc6e: 90 03     
            jsr __ccbf                               ; $cc70: 20 bf cc  
__cc73:     lda $0091,y                              ; $cc73: b9 91 00  
            clc                                      ; $cc76: 18        
            adc #$08                                 ; $cc77: 69 08     
            sec                                      ; $cc79: 38        
            sbc $05d2,x                              ; $cc7a: fd d2 05  
            jsr __f08e                               ; $cc7d: 20 8e f0  
            sta BytesLeftToLoad                      ; $cc80: 85 12     
            lda $009a,y                              ; $cc82: b9 9a 00  
            clc                                      ; $cc85: 18        
            adc #$0c                                 ; $cc86: 69 0c     
            sec                                      ; $cc88: 38        
            sbc $05dc,x                              ; $cc89: fd dc 05  
            jsr __f08e                               ; $cc8c: 20 8e f0  
            sta $13                                  ; $cc8f: 85 13     
            lda $05fa,x                              ; $cc91: bd fa 05  
            cmp #$03                                 ; $cc94: c9 03     
            beq __cca2                               ; $cc96: f0 0a     
            lda BytesLeftToLoad                      ; $cc98: a5 12     
            pha                                      ; $cc9a: 48        
            lda $13                                  ; $cc9b: a5 13     
            sta BytesLeftToLoad                      ; $cc9d: 85 12     
            pla                                      ; $cc9f: 68        
            sta $13                                  ; $cca0: 85 13     
__cca2:     lda BytesLeftToLoad                      ; $cca2: a5 12     
            cmp #$14                                 ; $cca4: c9 14     
            bcs __ccb8                               ; $cca6: b0 10     
            lda $13                                  ; $cca8: a5 13     
            cmp #$0b                                 ; $ccaa: c9 0b     
            bcs __ccb8                               ; $ccac: b0 0a     
            lda #$01                                 ; $ccae: a9 01     
            sta $0604,x                              ; $ccb0: 9d 04 06  
            lda #$32                                 ; $ccb3: a9 32     
            sta $060e,x                              ; $ccb5: 9d 0e 06  
__ccb8:     dey                                      ; $ccb8: 88        
            bmi __ccbe                               ; $ccb9: 30 03     
            jmp __cc3a                               ; $ccbb: 4c 3a cc  

;-------------------------------------------------------------------------------
__ccbe:     rts                                      ; $ccbe: 60        

;-------------------------------------------------------------------------------
__ccbf:     txa                                      ; $ccbf: 8a        
            pha                                      ; $ccc0: 48        
            tya                                      ; $ccc1: 98        
            tax                                      ; $ccc2: aa        
            inc $cb                                  ; $ccc3: e6 cb     
            jsr __e983                               ; $ccc5: 20 83 e9  
            pla                                      ; $ccc8: 68        
            tax                                      ; $ccc9: aa        
            rts                                      ; $ccca: 60        

;-------------------------------------------------------------------------------
__cccb:     lda $05f0,x                              ; $cccb: bd f0 05  
            sta $57                                  ; $ccce: 85 57     
            lda $05e6,x                              ; $ccd0: bd e6 05  
            sta $58                                  ; $ccd3: 85 58     
            lda #$03                                 ; $ccd5: a9 03     
            sta $59                                  ; $ccd7: 85 59     
            ldy $05fa,x                              ; $ccd9: bc fa 05  
            lda __cd26,y                             ; $ccdc: b9 26 cd  
            sta $5a                                  ; $ccdf: 85 5a     
            lda __cd2a,y                             ; $cce1: b9 2a cd  
            sta $5b                                  ; $cce4: 85 5b     
            lda __cd2e,y                             ; $cce6: b9 2e cd  
            sta $5c                                  ; $cce9: 85 5c     
            jsr __cd0f                               ; $cceb: 20 0f cd  
            lda __cd32,y                             ; $ccee: b9 32 cd  
            sta $5a                                  ; $ccf1: 85 5a     
            lda __cd36,y                             ; $ccf3: b9 36 cd  
            sta $5b                                  ; $ccf6: 85 5b     
            lda __cd3a,y                             ; $ccf8: b9 3a cd  
            sta $5c                                  ; $ccfb: 85 5c     
            jsr __cd0f                               ; $ccfd: 20 0f cd  
            lda __cd3e,y                             ; $cd00: b9 3e cd  
            sta $5a                                  ; $cd03: 85 5a     
            lda __cd42,y                             ; $cd05: b9 42 cd  
            sta $5b                                  ; $cd08: 85 5b     
            lda __cd46,y                             ; $cd0a: b9 46 cd  
            sta $5c                                  ; $cd0d: 85 5c     
__cd0f:     tya                                      ; $cd0f: 98        
            pha                                      ; $cd10: 48        
            lda #$57                                 ; $cd11: a9 57     
            ldy #$00                                 ; $cd13: a0 00     
            jsr __c131                               ; $cd15: 20 31 c1  
            pla                                      ; $cd18: 68        
            tay                                      ; $cd19: a8        
            lda $58                                  ; $cd1a: a5 58     
            clc                                      ; $cd1c: 18        
            adc #$20                                 ; $cd1d: 69 20     
            sta $58                                  ; $cd1f: 85 58     
            bcc __cd25                               ; $cd21: 90 02     
            inc $57                                  ; $cd23: e6 57     
__cd25:     rts                                      ; $cd25: 60        

;-------------------------------------------------------------------------------
__cd26:     .hex a1 24 24 24                         ; $cd26: a1 24 24 24   Data
__cd2a:     .hex a2 9e ab 24                         ; $cd2a: a2 9e ab 24   Data
__cd2e:     .hex 24 24 ac 24                         ; $cd2e: 24 24 ac 24   Data
__cd32:     .hex a3 24 ad a8                         ; $cd32: a3 24 ad a8   Data
__cd36:     .hex a4 9f ae a9                         ; $cd36: a4 9f ae a9   Data
__cd3a:     .hex a5 24 af aa                         ; $cd3a: a5 24 af aa   Data
__cd3e:     .hex 24 24 b0 24                         ; $cd3e: 24 24 b0 24   Data
__cd42:     .hex a6 a0 b1 24                         ; $cd42: a6 a0 b1 24   Data
__cd46:     .hex a7 24 24 24                         ; $cd46: a7 24 24 24   Data

;-------------------------------------------------------------------------------
__cd4a:     ldx #$09                                 ; $cd4a: a2 09     
__cd4c:     lda #$ff                                 ; $cd4c: a9 ff     
            sta $055d,x                              ; $cd4e: 9d 5d 05  
            lda #$f0                                 ; $cd51: a9 f0     
            sta $057b,x                              ; $cd53: 9d 7b 05  
            dex                                      ; $cd56: ca        
            bpl __cd4c                               ; $cd57: 10 f3     
            rts                                      ; $cd59: 60        

;-------------------------------------------------------------------------------
__cd5a:     dec $05cc                                ; $cd5a: ce cc 05  
            beq __cd60                               ; $cd5d: f0 01     
            rts                                      ; $cd5f: 60        

;-------------------------------------------------------------------------------
__cd60:     lda $1b                                  ; $cd60: a5 1b     
            and #$3f                                 ; $cd62: 29 3f     
            adc #$28                                 ; $cd64: 69 28     
            sta $05cc                                ; $cd66: 8d cc 05  
            ldx #$09                                 ; $cd69: a2 09     
__cd6b:     lda $055d,x                              ; $cd6b: bd 5d 05  
            bmi __cd74                               ; $cd6e: 30 04     
            dex                                      ; $cd70: ca        
            bpl __cd6b                               ; $cd71: 10 f8     
            rts                                      ; $cd73: 60        

;-------------------------------------------------------------------------------
__cd74:     lda #$00                                 ; $cd74: a9 00     
            sta $055d,x                              ; $cd76: 9d 5d 05  
            sta $0599,x                              ; $cd79: 9d 99 05  
            sta $058f,x                              ; $cd7c: 9d 8f 05  
            lda #$80                                 ; $cd7f: a9 80     
            sta $0571,x                              ; $cd81: 9d 71 05  
            sta $0585,x                              ; $cd84: 9d 85 05  
            lda #$d0                                 ; $cd87: a9 d0     
            sta $057b,x                              ; $cd89: 9d 7b 05  
            jsr __f1b3                               ; $cd8c: 20 b3 f1  
            and #$03                                 ; $cd8f: 29 03     
            tay                                      ; $cd91: a8        
            lda __ceae,y                             ; $cd92: b9 ae ce  
            sta $0567,x                              ; $cd95: 9d 67 05  
            ldy #$00                                 ; $cd98: a0 00     
            lda $1b                                  ; $cd9a: a5 1b     
            sta $05b7,x                              ; $cd9c: 9d b7 05  
            bpl __cda2                               ; $cd9f: 10 01     
            dey                                      ; $cda1: 88        
__cda2:     tya                                      ; $cda2: 98        
            sta $05c1,x                              ; $cda3: 9d c1 05  
            dec $05cb                                ; $cda6: ce cb 05  
            rts                                      ; $cda9: 60        

;-------------------------------------------------------------------------------
__cdaa:     ldx #$09                                 ; $cdaa: a2 09     
__cdac:     lda $055d,x                              ; $cdac: bd 5d 05  
            bmi __ce22                               ; $cdaf: 30 71     
            beq __cdfc                               ; $cdb1: f0 49     
            lda $0599,x                              ; $cdb3: bd 99 05  
            sta BytesLeftToLoad                      ; $cdb6: 85 12     
            lda $058f,x                              ; $cdb8: bd 8f 05  
            sta $13                                  ; $cdbb: 85 13     
            jsr __f1a6                               ; $cdbd: 20 a6 f1  
            lda $05b7,x                              ; $cdc0: bd b7 05  
            clc                                      ; $cdc3: 18        
            adc BytesLeftToLoad                      ; $cdc4: 65 12     
            sta $05b7,x                              ; $cdc6: 9d b7 05  
            sta BytesLeftToLoad                      ; $cdc9: 85 12     
            lda $05c1,x                              ; $cdcb: bd c1 05  
            adc $13                                  ; $cdce: 65 13     
            sta $05c1,x                              ; $cdd0: 9d c1 05  
            sta $13                                  ; $cdd3: 85 13     
            jsr __f1a6                               ; $cdd5: 20 a6 f1  
            lda $0599,x                              ; $cdd8: bd 99 05  
            sec                                      ; $cddb: 38        
            sbc BytesLeftToLoad                      ; $cddc: e5 12     
            sta $0599,x                              ; $cdde: 9d 99 05  
            lda $058f,x                              ; $cde1: bd 8f 05  
            sbc $13                                  ; $cde4: e5 13     
            sta $058f,x                              ; $cde6: 9d 8f 05  
            lda $0571,x                              ; $cde9: bd 71 05  
            clc                                      ; $cdec: 18        
            adc $0599,x                              ; $cded: 7d 99 05  
            sta $0571,x                              ; $cdf0: 9d 71 05  
            lda $0567,x                              ; $cdf3: bd 67 05  
            adc $058f,x                              ; $cdf6: 7d 8f 05  
            sta $0567,x                              ; $cdf9: 9d 67 05  
__cdfc:     lda $0585,x                              ; $cdfc: bd 85 05  
            sec                                      ; $cdff: 38        
            sbc BonusPhaseRisingBalloonSpeed         ; $ce00: ed 5a 05  
            sta $0585,x                              ; $ce03: 9d 85 05  
            bcs __ce0b                               ; $ce06: b0 03     
            dec $057b,x                              ; $ce08: de 7b 05  
__ce0b:     lda $057b,x                              ; $ce0b: bd 7b 05  
            cmp #$f0                                 ; $ce0e: c9 f0     
            beq __ce1d                               ; $ce10: f0 0b     
            cmp #$a8                                 ; $ce12: c9 a8     
            bcs __ce22                               ; $ce14: b0 0c     
            lda #$01                                 ; $ce16: a9 01     
            sta $055d,x                              ; $ce18: 9d 5d 05  
            bne __ce22                               ; $ce1b: d0 05     
__ce1d:     lda #$ff                                 ; $ce1d: a9 ff     
            sta $055d,x                              ; $ce1f: 9d 5d 05  
__ce22:     jsr __ce2f                               ; $ce22: 20 2f ce  
            jsr __cece                               ; $ce25: 20 ce ce  
            dex                                      ; $ce28: ca        
            bmi __ce2e                               ; $ce29: 30 03     
            jmp __cdac                               ; $ce2b: 4c ac cd  

;-------------------------------------------------------------------------------
__ce2e:     rts                                      ; $ce2e: 60        

;-------------------------------------------------------------------------------
__ce2f:     ldy $055d,x                              ; $ce2f: bc 5d 05  
            iny                                      ; $ce32: c8        
            lda __ceb2,y                             ; $ce33: b9 b2 ce  
            sta $13                                  ; $ce36: 85 13     
            txa                                      ; $ce38: 8a        
            sta BytesLeftToLoad                      ; $ce39: 85 12     
            asl                                      ; $ce3b: 0a        
            adc BytesLeftToLoad                      ; $ce3c: 65 12     
            asl                                      ; $ce3e: 0a        
            asl                                      ; $ce3f: 0a        
            tay                                      ; $ce40: a8        
            lda $057b,x                              ; $ce41: bd 7b 05  
            sta $0250,y                              ; $ce44: 99 50 02  
            sta $0254,y                              ; $ce47: 99 54 02  
            clc                                      ; $ce4a: 18        
            adc #$08                                 ; $ce4b: 69 08     
            sta $0258,y                              ; $ce4d: 99 58 02  
            lda $0567,x                              ; $ce50: bd 67 05  
            sta $0253,y                              ; $ce53: 99 53 02  
            clc                                      ; $ce56: 18        
            adc #$04                                 ; $ce57: 69 04     
            sta $025b,y                              ; $ce59: 99 5b 02  
            clc                                      ; $ce5c: 18        
            adc #$04                                 ; $ce5d: 69 04     
            sta $0257,y                              ; $ce5f: 99 57 02  
            lda $13                                  ; $ce62: a5 13     
            sta $0252,y                              ; $ce64: 99 52 02  
            sta $0256,y                              ; $ce67: 99 56 02  
            sta $025a,y                              ; $ce6a: 99 5a 02  
            lda $055d,x                              ; $ce6d: bd 5d 05  
            bmi __ce99                               ; $ce70: 30 27     
            lda #$a8                                 ; $ce72: a9 a8     
            sta $0251,y                              ; $ce74: 99 51 02  
            lda #$a9                                 ; $ce77: a9 a9     
            sta $0255,y                              ; $ce79: 99 55 02  
            lda GameTimer                            ; $ce7c: a5 19     
            lsr                                      ; $ce7e: 4a        
            lsr                                      ; $ce7f: 4a        
            lsr                                      ; $ce80: 4a        
            lsr                                      ; $ce81: 4a        
            and #$07                                 ; $ce82: 29 07     
            stx $13                                  ; $ce84: 86 13     
            tax                                      ; $ce86: aa        
            lda __ceb5,x                             ; $ce87: bd b5 ce  
            sta $0259,y                              ; $ce8a: 99 59 02  
            lda $025a,y                              ; $ce8d: b9 5a 02  
            eor __cebd,x                             ; $ce90: 5d bd ce  
            sta $025a,y                              ; $ce93: 99 5a 02  
            ldx $13                                  ; $ce96: a6 13     
            rts                                      ; $ce98: 60        

;-------------------------------------------------------------------------------
__ce99:     lda #$f0                                 ; $ce99: a9 f0     
            sta $057b,x                              ; $ce9b: 9d 7b 05  
            lda #$ac                                 ; $ce9e: a9 ac     
            sta $0251,y                              ; $cea0: 99 51 02  
            lda #$ad                                 ; $cea3: a9 ad     
            sta $0255,y                              ; $cea5: 99 55 02  
            lda #$fc                                 ; $cea8: a9 fc     
            sta $0259,y                              ; $ceaa: 99 59 02  
            rts                                      ; $cead: 60        

;-------------------------------------------------------------------------------
__ceae:     .hex 20 50 a0 d0                         ; $ceae: 20 50 a0 d0   Data
__ceb2:     .hex 02 22 02                            ; $ceb2: 02 22 02      Data
__ceb5:     .hex aa ab ab aa                         ; $ceb5: aa ab ab aa   Data
            .hex aa ab ab aa                         ; $ceb9: aa ab ab aa   Data
__cebd:     .hex 00 00 40 40                         ; $cebd: 00 00 40 40   Data
            .hex 40 40 00 00                         ; $cec1: 40 40 00 00   Data
            .hex fc fc df fc                         ; $cec5: fc fc df fc   Data
            .hex fc e0 e2 e1                         ; $cec9: fc e0 e2 e1   Data
            .hex fc                                  ; $cecd: fc            Data

;-------------------------------------------------------------------------------
__cece:     ldy #$01                                 ; $cece: a0 01     
__ced0:     lda $0088,y                              ; $ced0: b9 88 00  
            bmi __cf0f                               ; $ced3: 30 3a     
            beq __cf0f                               ; $ced5: f0 38     
            lda $055d,x                              ; $ced7: bd 5d 05  
            bmi __cf12                               ; $ceda: 30 36     
            lda $009a,y                              ; $cedc: b9 9a 00  
            cmp #$c0                                 ; $cedf: c9 c0     
            bcs __cf0f                               ; $cee1: b0 2c     
            sec                                      ; $cee3: 38        
            sbc $057b,x                              ; $cee4: fd 7b 05  
            jsr __f08e                               ; $cee7: 20 8e f0  
            cmp #$18                                 ; $ceea: c9 18     
            bcs __cf0f                               ; $ceec: b0 21     
            lda $0091,y                              ; $ceee: b9 91 00  
            sec                                      ; $cef1: 38        
            sbc $0567,x                              ; $cef2: fd 67 05  
            jsr __f08e                               ; $cef5: 20 8e f0  
            cmp #$10                                 ; $cef8: c9 10     
            bcs __cf0f                               ; $cefa: b0 13     
            lda #$ff                                 ; $cefc: a9 ff     
            sta $055d,x                              ; $cefe: 9d 5d 05  
            lda Player1BonusBallons,y                ; $cf01: b9 cd 05  
            clc                                      ; $cf04: 18        
            adc #$01                                 ; $cf05: 69 01     
            sta Player1BonusBallons,y                ; $cf07: 99 cd 05  
            lda #$02                                 ; $cf0a: a9 02     
            sta $f0                                  ; $cf0c: 85 f0     
            rts                                      ; $cf0e: 60        

;-------------------------------------------------------------------------------
__cf0f:     dey                                      ; $cf0f: 88        
            bpl __ced0                               ; $cf10: 10 be     
__cf12:     rts                                      ; $cf12: 60        

;-------------------------------------------------------------------------------
__cf13:     lda #$20                                 ; $cf13: a9 20     
            sta CurrentMusic                         ; $cf15: 85 f2     
            jsr __d0e2                               ; $cf17: 20 e2 d0  
            jsr __cd4a                               ; $cf1a: 20 4a cd  
            ldx NumberOfPlayers                      ; $cf1d: a6 40     
__cf1f:     lda Player1Lives,x                       ; $cf1f: b5 41     
            bmi __cf26                               ; $cf21: 30 03     
            jsr __f3b0                               ; $cf23: 20 b0 f3  
__cf26:     dex                                      ; $cf26: ca        
            bpl __cf1f                               ; $cf27: 10 f6     
            ldx #$00                                 ; $cf29: a2 00     
            stx Player1Invincible                    ; $cf2b: 86 bd     
            stx Player2Invincible                    ; $cf2d: 86 be     
            lda #$14                                 ; $cf2f: a9 14     
            sta $05cb                                ; $cf31: 8d cb 05  
__cf34:     jsr __f470                               ; $cf34: 20 70 f4  
            inc $4c                                  ; $cf37: e6 4c     
            jsr __d8dd                               ; $cf39: 20 dd d8  
            jsr __e691                               ; $cf3c: 20 91 e6  
            lda $05cb                                ; $cf3f: ad cb 05  
            beq __cf47                               ; $cf42: f0 03     
            jsr __cd5a                               ; $cf44: 20 5a cd  
__cf47:     jsr __cdaa                               ; $cf47: 20 aa cd  
            lda $05cb                                ; $cf4a: ad cb 05  
            bne __cf34                               ; $cf4d: d0 e5     
            ldx #$09                                 ; $cf4f: a2 09     
__cf51:     lda $055d,x                              ; $cf51: bd 5d 05  
            bpl __cf34                               ; $cf54: 10 de     
            dex                                      ; $cf56: ca        
            bpl __cf51                               ; $cf57: 10 f8     
            lda GameTimer                            ; $cf59: a5 19     
            bne __cf34                               ; $cf5b: d0 d7     
            jsr __d246                               ; $cf5d: 20 46 d2  
            ldx #$02                                 ; $cf60: a2 02     
            stx $46                                  ; $cf62: 86 46     
            jsr __f45e                               ; $cf64: 20 5e f4  
            lda #$2b                                 ; $cf67: a9 2b     
            ldy #$d1                                 ; $cf69: a0 d1     
            jsr __c131                               ; $cf6b: 20 31 c1  
            lda #$5a                                 ; $cf6e: a9 5a     
            ldy #$d1                                 ; $cf70: a0 d1     
            jsr __c131                               ; $cf72: 20 31 c1  
            lda #$65                                 ; $cf75: a9 65     
            ldy #$d1                                 ; $cf77: a0 d1     
            jsr __c131                               ; $cf79: 20 31 c1  
            ldx NumberOfPlayers                      ; $cf7c: a6 40     
__cf7e:     lda #$20                                 ; $cf7e: a9 20     
            sta Player1X,x                           ; $cf80: 95 91     
            lda __d19e,x                             ; $cf82: bd 9e d1  
            sta Player1Y,x                           ; $cf85: 95 9a     
            lda #$03                                 ; $cf87: a9 03     
            sta $7f,x                                ; $cf89: 95 7f     
            lda #$01                                 ; $cf8b: a9 01     
            sta $0448,x                              ; $cf8d: 9d 48 04  
            jsr __f3b0                               ; $cf90: 20 b0 f3  
            jsr __e3a4                               ; $cf93: 20 a4 e3  
            dex                                      ; $cf96: ca        
            bpl __cf7e                               ; $cf97: 10 e5     
            lda #$44                                 ; $cf99: a9 44     
            sta $0567                                ; $cf9b: 8d 67 05  
            sta $0568                                ; $cf9e: 8d 68 05  
            lda #$54                                 ; $cfa1: a9 54     
            sta $057b                                ; $cfa3: 8d 7b 05  
            lda #$74                                 ; $cfa6: a9 74     
            sta $057c                                ; $cfa8: 8d 7c 05  
            lda #$01                                 ; $cfab: a9 01     
            sta $055d                                ; $cfad: 8d 5d 05  
            sta $055e                                ; $cfb0: 8d 5e 05  
            ldx NumberOfPlayers                      ; $cfb3: a6 40     
__cfb5:     jsr __ce2f                               ; $cfb5: 20 2f ce  
            dex                                      ; $cfb8: ca        
            bpl __cfb5                               ; $cfb9: 10 fa     
            jsr __f45c                               ; $cfbb: 20 5c f4  
            lda #$2b                                 ; $cfbe: a9 2b     
            sta $57                                  ; $cfc0: 85 57     
            lda #$24                                 ; $cfc2: a9 24     
            sta $58                                  ; $cfc4: 85 58     
            sta $59                                  ; $cfc6: 85 59     
            lda #$0c                                 ; $cfc8: a9 0c     
            sta CloudGfxX                            ; $cfca: 85 54     
            lda #$0b                                 ; $cfcc: a9 0b     
            sta CloudGfxY                            ; $cfce: 85 55     
            lda #$05                                 ; $cfd0: a9 05     
            sta $56                                  ; $cfd2: 85 56     
            lda Player1BonusBallons                  ; $cfd4: ad cd 05  
            jsr __d1c9                               ; $cfd7: 20 c9 d1  
            lda NumberOfPlayers                      ; $cfda: a5 40     
            beq __cfe8                               ; $cfdc: f0 0a     
            lda #$0f                                 ; $cfde: a9 0f     
            sta CloudGfxY                            ; $cfe0: 85 55     
            lda Player2BonusBalloon                  ; $cfe2: ad ce 05  
            jsr __d1c9                               ; $cfe5: 20 c9 d1  
__cfe8:     jsr __f45c                               ; $cfe8: 20 5c f4  
            lda BonusPhasePointMultiplyer            ; $cfeb: ad 59 05  
            sta $57                                  ; $cfee: 85 57     
            lda #$00                                 ; $cff0: a9 00     
            sta $58                                  ; $cff2: 85 58     
            sta $59                                  ; $cff4: 85 59     
            lda #$08                                 ; $cff6: a9 08     
            sta CloudGfxX                            ; $cff8: 85 54     
            lda #$0b                                 ; $cffa: a9 0b     
            sta CloudGfxY                            ; $cffc: 85 55     
            lda #$03                                 ; $cffe: a9 03     
            sta $56                                  ; $d000: 85 56     
            lda BonusPhasePointMultiplyer            ; $d002: ad 59 05  
            jsr __c119                               ; $d005: 20 19 c1  
            lda NumberOfPlayers                      ; $d008: a5 40     
            beq __d013                               ; $d00a: f0 07     
            lda #$0f                                 ; $d00c: a9 0f     
            sta CloudGfxY                            ; $d00e: 85 55     
            jsr __c119                               ; $d010: 20 19 c1  
__d013:     lda #$ff                                 ; $d013: a9 ff     
            sta $055d                                ; $d015: 8d 5d 05  
            sta $055e                                ; $d018: 8d 5e 05  
            ldx NumberOfPlayers                      ; $d01b: a6 40     
__d01d:     jsr __ce2f                               ; $d01d: 20 2f ce  
            dex                                      ; $d020: ca        
            bpl __d01d                               ; $d021: 10 fa     
            lda #$02                                 ; $d023: a9 02     
            sta $f0                                  ; $d025: 85 f0     
            ldx #$02                                 ; $d027: a2 02     
            jsr __f45e                               ; $d029: 20 5e f4  
            ldx NumberOfPlayers                      ; $d02c: a6 40     
__d02e:     jsr __ce2f                               ; $d02e: 20 2f ce  
            dex                                      ; $d031: ca        
            bpl __d02e                               ; $d032: 10 fa     
            jsr __d1a0                               ; $d034: 20 a0 d1  
            jsr __f45c                               ; $d037: 20 5c f4  
            lda #$01                                 ; $d03a: a9 01     
            sta $f0                                  ; $d03c: 85 f0     
            jsr __d121                               ; $d03e: 20 21 d1  
            bne __d068                               ; $d041: d0 25     
            lda #$70                                 ; $d043: a9 70     
            ldy #$d1                                 ; $d045: a0 d1     
            jsr __c131                               ; $d047: 20 31 c1  
            jsr __f465                               ; $d04a: 20 65 f4  
            ldx #$1a                                 ; $d04d: a2 1a     
__d04f:     lda __d184,x                             ; $d04f: bd 84 d1  
            sta $57,x                                ; $d052: 95 57     
            dex                                      ; $d054: ca        
            bpl __d04f                               ; $d055: 10 f8     
            lda BonusPhaseSuperBonus1                ; $d057: ad 5b 05  
            sta $68                                  ; $d05a: 85 68     
            lda BonusPhaseSuperBonus2                ; $d05c: ad 5c 05  
            sta $69                                  ; $d05f: 85 69     
            jsr __c12d                               ; $d061: 20 2d c1  
            lda #$10                                 ; $d064: a9 10     
            sta CurrentMusic                         ; $d066: 85 f2     
__d068:     ldx #$78                                 ; $d068: a2 78     
            jsr __f45e                               ; $d06a: 20 5e f4  
            jsr __d1a0                               ; $d06d: 20 a0 d1  
__d070:     lda #$00                                 ; $d070: a9 00     
            sta $3e                                  ; $d072: 85 3e     
            ldx #$04                                 ; $d074: a2 04     
            jsr __d213                               ; $d076: 20 13 d2  
            jsr __c12d                               ; $d079: 20 2d c1  
            lda NumberOfPlayers                      ; $d07c: a5 40     
            beq __d08e                               ; $d07e: f0 0e     
            inc $3e                                  ; $d080: e6 3e     
            ldx #$12                                 ; $d082: a2 12     
            jsr __d213                               ; $d084: 20 13 d2  
            lda #$65                                 ; $d087: a9 65     
            ldy #$00                                 ; $d089: a0 00     
            jsr __c131                               ; $d08b: 20 31 c1  
__d08e:     lda #$01                                 ; $d08e: a9 01     
            sta $f1                                  ; $d090: 85 f1     
            ldx #$02                                 ; $d092: a2 02     
            jsr __f45e                               ; $d094: 20 5e f4  
            lda $5d                                  ; $d097: a5 5d     
            cmp #$24                                 ; $d099: c9 24     
            bne __d070                               ; $d09b: d0 d3     
            lda NumberOfPlayers                      ; $d09d: a5 40     
            beq __d0a8                               ; $d09f: f0 07     
            .hex ad 6b 00                            ; $d0a1: ad 6b 00  Bad Addr Mode - LDA $006b
            cmp #$24                                 ; $d0a4: c9 24     
            bne __d070                               ; $d0a6: d0 c8     
__d0a8:     ldx #$0a                                 ; $d0a8: a2 0a     
            jsr __f45e                               ; $d0aa: 20 5e f4  
            jsr __d121                               ; $d0ad: 20 21 d1  
            bne __d0ce                               ; $d0b0: d0 1c     
            lda BonusPhaseSuperBonus1                ; $d0b2: ad 5b 05  
            sta $47                                  ; $d0b5: 85 47     
            lda BonusPhaseSuperBonus2                ; $d0b7: ad 5c 05  
            sta $48                                  ; $d0ba: 85 48     
            lda NumberOfPlayers                      ; $d0bc: a5 40     
            sta $3e                                  ; $d0be: 85 3e     
__d0c0:     jsr __d6dc                               ; $d0c0: 20 dc d6  
            dec $3e                                  ; $d0c3: c6 3e     
            bpl __d0c0                               ; $d0c5: 10 f9     
            lda #$01                                 ; $d0c7: a9 01     
            sta $f1                                  ; $d0c9: 85 f1     
            jsr __f45c                               ; $d0cb: 20 5c f4  
__d0ce:     lda #$00                                 ; $d0ce: a9 00     
            sta $47                                  ; $d0d0: 85 47     
            sta $48                                  ; $d0d2: 85 48     
            ldx #$01                                 ; $d0d4: a2 01     
__d0d6:     lda Player1Lives,x                       ; $d0d6: b5 41     
            bpl __d0dc                               ; $d0d8: 10 02     
            sta Player1Ballons,x                     ; $d0da: 95 88     
__d0dc:     dex                                      ; $d0dc: ca        
            bpl __d0d6                               ; $d0dd: 10 f7     
            jmp __f353                               ; $d0df: 4c 53 f3  

;-------------------------------------------------------------------------------
__d0e2:     ldx BonusPhaseIntensityLevel             ; $d0e2: ae 58 05  
            lda BonusPhasePointsPerBalloonData,x     ; $d0e5: bd 0d d1  
            sta BonusPhasePointMultiplyer            ; $d0e8: 8d 59 05  
            lda BonusPhaseRisingBalloonSpeedData,x   ; $d0eb: bd 12 d1  
            sta BonusPhaseRisingBalloonSpeed         ; $d0ee: 8d 5a 05  
            lda BonusPhaseSuperBonus1Data,x          ; $d0f1: bd 17 d1  
            sta BonusPhaseSuperBonus1                ; $d0f4: 8d 5b 05  
            lda BonusPhaseSuperBonus2Data,x          ; $d0f7: bd 1c d1  
            sta BonusPhaseSuperBonus2                ; $d0fa: 8d 5c 05  
            cpx #$04                                 ; $d0fd: e0 04     
            bcs __d104                               ; $d0ff: b0 03     
            inc BonusPhaseIntensityLevel             ; $d101: ee 58 05  
__d104:     lda #$00                                 ; $d104: a9 00     
            sta Player1BonusBallons                  ; $d106: 8d cd 05  
            sta Player2BonusBalloon                  ; $d109: 8d ce 05  
            rts                                      ; $d10c: 60        

;-------------------------------------------------------------------------------
BonusPhasePointsPerBalloonData:
            .hex 03 05 07 07                         ; $d10d: 03 05 07 07   Data
            .hex 07                                  ; $d111: 07            Data

BonusPhaseRisingBalloonSpeedData:
            .hex 80 90 98 a0                         ; $d112: 80 90 98 a0   Data
            .hex a8                                  ; $d116: a8            Data

BonusPhaseSuperBonus1Data:
            .hex 01 01 02 02                         ; $d117: 01 01 02 02   Data
            .hex 03                                  ; $d11b: 03            Data

BonusPhaseSuperBonus2Data:
            .hex 00 05 00 05                         ; $d11c: 00 05 00 05   Data
            .hex 00                                  ; $d120: 00            Data

;-------------------------------------------------------------------------------
__d121:     lda Player1BonusBallons                  ; $d121: ad cd 05  
            clc                                      ; $d124: 18        
            adc Player2BonusBalloon                  ; $d125: 6d ce 05  
            cmp #$14                                 ; $d128: c9 14     
            rts                                      ; $d12a: 60        

;-------------------------------------------------------------------------------
            .hex 3f 00 10 0f                         ; $d12b: 3f 00 10 0f   Data
            .hex 30 30 30 0f                         ; $d12f: 30 30 30 0f   Data
            .hex 30 27 15 0f                         ; $d133: 30 27 15 0f   Data
            .hex 30 02 21 0f                         ; $d137: 30 02 21 0f   Data
            .hex 16 16 16                            ; $d13b: 16 16 16      Data
__d13e:     .hex 21 73 0b 29                         ; $d13e: 21 73 0b 29   Data
            .hex 00 00 00 00                         ; $d142: 00 00 00 00   Data
            .hex 00 24 19 1d                         ; $d146: 00 24 19 1d   Data
            .hex 1c 26 21 f3                         ; $d14a: 1c 26 21 f3   Data
            .hex 0b 29 00 00                         ; $d14e: 0b 29 00 00   Data
            .hex 00 00 00 24                         ; $d152: 00 00 00 24   Data
            .hex 19 1d 1c 26                         ; $d156: 19 1d 1c 26   Data
            .hex 23 e8 08 ff                         ; $d15a: 23 e8 08 ff   Data
            .hex ff ff ff ff                         ; $d15e: ff ff ff ff   Data
            .hex ff ff ff 23                         ; $d162: ff ff ff 23   Data
            .hex c0 08 40 50                         ; $d166: c0 08 40 50   Data
            .hex 50 50 50 90                         ; $d16a: 50 50 50 90   Data
            .hex a0 a0 22 88                         ; $d16e: a0 a0 22 88   Data
            .hex 11 19 24 0e                         ; $d172: 11 19 24 0e   Data
            .hex 24 1b 24 0f                         ; $d176: 24 1b 24 0f   Data
            .hex 24 0e 24 0c                         ; $d17a: 24 0e 24 0c   Data
            .hex 24 1d 24 2c                         ; $d17e: 24 1d 24 2c   Data
            .hex 2c 2c                               ; $d182: 2c 2c         Data
__d184:     .hex 22 c6 17 1c                         ; $d184: 22 c6 17 1c   Data
            .hex 1e 19 0e 1b                         ; $d188: 1e 19 0e 1b   Data
            .hex 24 0b 18 17                         ; $d18c: 24 0b 18 17   Data
            .hex 1e 1c 24 24                         ; $d190: 1e 1c 24 24   Data
            .hex 24 01 00 00                         ; $d194: 24 01 00 00   Data
            .hex 00 00 19 1d                         ; $d198: 00 00 19 1d   Data
            .hex 1c 2c                               ; $d19c: 1c 2c         Data
__d19e:     .hex 50 70                               ; $d19e: 50 70         Data

;-------------------------------------------------------------------------------
__d1a0:     ldx #$1c                                 ; $d1a0: a2 1c     
__d1a2:     lda __d13e,x                             ; $d1a2: bd 3e d1  
            sta $57,x                                ; $d1a5: 95 57     
            dex                                      ; $d1a7: ca        
            bpl __d1a2                               ; $d1a8: 10 f8     
            ldx #$04                                 ; $d1aa: a2 04     
            ldy Player1BonusBallons                  ; $d1ac: ac cd 05  
            jsr __d1dc                               ; $d1af: 20 dc d1  
            ldx #$12                                 ; $d1b2: a2 12     
            ldy Player2BonusBalloon                  ; $d1b4: ac ce 05  
            jsr __d1dc                               ; $d1b7: 20 dc d1  
            jsr __c12d                               ; $d1ba: 20 2d c1  
            lda NumberOfPlayers                      ; $d1bd: a5 40     
            bne __d1c2                               ; $d1bf: d0 01     
            rts                                      ; $d1c1: 60        

;-------------------------------------------------------------------------------
__d1c2:     lda #$65                                 ; $d1c2: a9 65     
            ldy #$00                                 ; $d1c4: a0 00     
            jmp __c131                               ; $d1c6: 4c 31 c1  

;-------------------------------------------------------------------------------
__d1c9:     ldy #$00                                 ; $d1c9: a0 00     
__d1cb:     cmp #$0a                                 ; $d1cb: c9 0a     
            bcc __d1d5                               ; $d1cd: 90 06     
            iny                                      ; $d1cf: c8        
            sbc #$0a                                 ; $d1d0: e9 0a     
            jmp __d1cb                               ; $d1d2: 4c cb d1  

;-------------------------------------------------------------------------------
__d1d5:     sty $5a                                  ; $d1d5: 84 5a     
            sta $5b                                  ; $d1d7: 85 5b     
            jmp __c119                               ; $d1d9: 4c 19 c1  

;-------------------------------------------------------------------------------
__d1dc:     dey                                      ; $d1dc: 88        
            bmi __d1fe                               ; $d1dd: 30 1f     
            lda BonusPhasePointMultiplyer            ; $d1df: ad 59 05  
            clc                                      ; $d1e2: 18        
            adc $59,x                                ; $d1e3: 75 59     
            cmp #$0a                                 ; $d1e5: c9 0a     
            bcc __d1ed                               ; $d1e7: 90 04     
            sbc #$0a                                 ; $d1e9: e9 0a     
            inc $58,x                                ; $d1eb: f6 58     
__d1ed:     sta $59,x                                ; $d1ed: 95 59     
            lda $58,x                                ; $d1ef: b5 58     
            cmp #$0a                                 ; $d1f1: c9 0a     
            bcc __d1fb                               ; $d1f3: 90 06     
            sbc #$0a                                 ; $d1f5: e9 0a     
            inc $57,x                                ; $d1f7: f6 57     
            sta $58,x                                ; $d1f9: 95 58     
__d1fb:     jmp __d1dc                               ; $d1fb: 4c dc d1  

;-------------------------------------------------------------------------------
__d1fe:     ldy #$00                                 ; $d1fe: a0 00     
__d200:     lda $57,x                                ; $d200: b5 57     
            beq __d208                               ; $d202: f0 04     
            cmp #$24                                 ; $d204: c9 24     
            bne __d212                               ; $d206: d0 0a     
__d208:     lda #$24                                 ; $d208: a9 24     
            sta $57,x                                ; $d20a: 95 57     
            inx                                      ; $d20c: e8        
            iny                                      ; $d20d: c8        
            cpy #$04                                 ; $d20e: c0 04     
            bne __d200                               ; $d210: d0 ee     
__d212:     rts                                      ; $d212: 60        

;-------------------------------------------------------------------------------
__d213:     lda $59,x                                ; $d213: b5 59     
            cmp #$24                                 ; $d215: c9 24     
            beq __d243                               ; $d217: f0 2a     
            tay                                      ; $d219: a8        
            bne __d238                               ; $d21a: d0 1c     
            lda $58,x                                ; $d21c: b5 58     
            cmp #$24                                 ; $d21e: c9 24     
            beq __d243                               ; $d220: f0 21     
            lda $58,x                                ; $d222: b5 58     
            bne __d232                               ; $d224: d0 0c     
            lda $57,x                                ; $d226: b5 57     
            cmp #$24                                 ; $d228: c9 24     
            beq __d243                               ; $d22a: f0 17     
            lda #$0a                                 ; $d22c: a9 0a     
            sta $58,x                                ; $d22e: 95 58     
            dec $57,x                                ; $d230: d6 57     
__d232:     lda #$0a                                 ; $d232: a9 0a     
            sta $59,x                                ; $d234: 95 59     
            dec $58,x                                ; $d236: d6 58     
__d238:     dec $59,x                                ; $d238: d6 59     
            txa                                      ; $d23a: 8a        
            pha                                      ; $d23b: 48        
            lda #$0a                                 ; $d23c: a9 0a     
            jsr __d6de                               ; $d23e: 20 de d6  
            pla                                      ; $d241: 68        
            tax                                      ; $d242: aa        
__d243:     jmp __d1fe                               ; $d243: 4c fe d1  

;-------------------------------------------------------------------------------
__d246:     jsr __c10a                               ; $d246: 20 0a c1  
            jsr __c0fa                               ; $d249: 20 fa c0  
            lda #$20                                 ; $d24c: a9 20     
            sta $2006                                ; $d24e: 8d 06 20  
            lda #$00                                 ; $d251: a9 00     
            sta $2006                                ; $d253: 8d 06 20  
            jsr __d275                               ; $d256: 20 75 d2  
            jsr __d275                               ; $d259: 20 75 d2  
            jsr __c104                               ; $d25c: 20 04 c1  
            jsr __c115                               ; $d25f: 20 15 c1  
            ldx #$3f                                 ; $d262: a2 3f     
            ldy #$00                                 ; $d264: a0 00     
            sty $4c                                  ; $d266: 84 4c     
__d268:     lda #$f0                                 ; $d268: a9 f0     
            sta $0200,y                              ; $d26a: 99 00 02  
            iny                                      ; $d26d: c8        
            iny                                      ; $d26e: c8        
            iny                                      ; $d26f: c8        
            iny                                      ; $d270: c8        
            dex                                      ; $d271: ca        
            bpl __d268                               ; $d272: 10 f4     
            rts                                      ; $d274: 60        

;-------------------------------------------------------------------------------
__d275:     ldx #$f0                                 ; $d275: a2 f0     
            lda #$24                                 ; $d277: a9 24     
__d279:     sta $2007                                ; $d279: 8d 07 20  
            sta $2007                                ; $d27c: 8d 07 20  
            sta $2007                                ; $d27f: 8d 07 20  
            sta $2007                                ; $d282: 8d 07 20  
            dex                                      ; $d285: ca        
            bne __d279                               ; $d286: d0 f1     
            ldx #$40                                 ; $d288: a2 40     
            lda #$00                                 ; $d28a: a9 00     
__d28c:     sta $2007                                ; $d28c: 8d 07 20  
            dex                                      ; $d28f: ca        
            bne __d28c                               ; $d290: d0 fa     
            rts                                      ; $d292: 60        

;-------------------------------------------------------------------------------
__d293:     jsr __c10a                               ; $d293: 20 0a c1  
            jsr __c0fa                               ; $d296: 20 fa c0  
            lda $16                                  ; $d299: a5 16     
            beq __d2a0                               ; $d29b: f0 03     
            jmp __d572                               ; $d29d: 4c 72 d5  

;-------------------------------------------------------------------------------
__d2a0:     ldy CurrentLevelHeaderPtr                ; $d2a0: a4 3b     
            lda LevelHeaderPointersLo,y              ; $d2a2: b9 2a db  
            sta LoadPointerLow                       ; $d2a5: 85 1d     
            lda LevelHeaderPointerHigh,y             ; $d2a7: b9 3a db  
            sta LoadPointerHigh                      ; $d2aa: 85 1e     
            jsr __d497                               ; $d2ac: 20 97 d4  
            ldx #$00                                 ; $d2af: a2 00     
__d2b1:     jsr __d4e5                               ; $d2b1: 20 e5 d4  
            cmp #$ff                                 ; $d2b4: c9 ff     
            beq __d322                               ; $d2b6: f0 6a     
            sta CloudGfxX                            ; $d2b8: 85 54     
            jsr __d4e5                               ; $d2ba: 20 e5 d4  
            sta CloudGfxY                            ; $d2bd: 85 55     
            ldy #$03                                 ; $d2bf: a0 03     
__d2c1:     jsr __d4fb                               ; $d2c1: 20 fb d4  
            lda #$04                                 ; $d2c4: a9 04     
            sta BytesLeftToLoad                      ; $d2c6: 85 12     
            lda __d493,y                             ; $d2c8: b9 93 d4  
__d2cb:     sta $2007                                ; $d2cb: 8d 07 20  
            clc                                      ; $d2ce: 18        
            adc #$04                                 ; $d2cf: 69 04     
            dec BytesLeftToLoad                      ; $d2d1: c6 12     
            bne __d2cb                               ; $d2d3: d0 f6     
            inc CloudGfxY                            ; $d2d5: e6 55     
            dey                                      ; $d2d7: 88        
            bpl __d2c1                               ; $d2d8: 10 e7     
            lda CloudGfxY                            ; $d2da: a5 55     
            sec                                      ; $d2dc: 38        
            sbc #$04                                 ; $d2dd: e9 04     
            sta CloudGfxY                            ; $d2df: 85 55     
            jsr __d51c                               ; $d2e1: 20 1c d5  
            sta $a6,x                                ; $d2e4: 95 a6     
            inc CloudGfxX                            ; $d2e6: e6 54     
            inc CloudGfxX                            ; $d2e8: e6 54     
            jsr __d51c                               ; $d2ea: 20 1c d5  
            sta $a9,x                                ; $d2ed: 95 a9     
            inc CloudGfxY                            ; $d2ef: e6 55     
            inc CloudGfxY                            ; $d2f1: e6 55     
            jsr __d51c                               ; $d2f3: 20 1c d5  
            sta $af,x                                ; $d2f6: 95 af     
            dec CloudGfxX                            ; $d2f8: c6 54     
            dec CloudGfxX                            ; $d2fa: c6 54     
            jsr __d51c                               ; $d2fc: 20 1c d5  
            sta $ac,x                                ; $d2ff: 95 ac     
            stx $a4                                  ; $d301: 86 a4     
            lda #$03                                 ; $d303: a9 03     
            jsr __c856                               ; $d305: 20 56 c8  
            jsr __c17c                               ; $d308: 20 7c c1  
            ldx $a4                                  ; $d30b: a6 a4     
            lda CloudGfxX                            ; $d30d: a5 54     
            asl                                      ; $d30f: 0a        
            asl                                      ; $d310: 0a        
            asl                                      ; $d311: 0a        
            clc                                      ; $d312: 18        
            adc #$10                                 ; $d313: 69 10     
            sta $b2,x                                ; $d315: 95 b2     
            lda CloudGfxY                            ; $d317: a5 55     
            asl                                      ; $d319: 0a        
            asl                                      ; $d31a: 0a        
            asl                                      ; $d31b: 0a        
            sta $b5,x                                ; $d31c: 95 b5     
            inx                                      ; $d31e: e8        
            jmp __d2b1                               ; $d31f: 4c b1 d2  

;-------------------------------------------------------------------------------
__d322:     dex                                      ; $d322: ca        
            stx $a3                                  ; $d323: 86 a3     
            ldx #$00                                 ; $d325: a2 00     
__d327:     jsr __d4e5                               ; $d327: 20 e5 d4  
            cmp #$ff                                 ; $d32a: c9 ff     
            beq __d37e                               ; $d32c: f0 50     
            sta CloudGfxX                            ; $d32e: 85 54     
            jsr __d4e5                               ; $d330: 20 e5 d4  
            sta CloudGfxY                            ; $d333: 85 55     
            jsr __d4e5                               ; $d335: 20 e5 d4  
            sta $05fa,x                              ; $d338: 9d fa 05  
            lda CloudGfxX                            ; $d33b: a5 54     
            asl                                      ; $d33d: 0a        
            asl                                      ; $d33e: 0a        
            asl                                      ; $d33f: 0a        
            adc #$0c                                 ; $d340: 69 0c     
            sta $05d2,x                              ; $d342: 9d d2 05  
            lda CloudGfxY                            ; $d345: a5 55     
            asl                                      ; $d347: 0a        
            asl                                      ; $d348: 0a        
            asl                                      ; $d349: 0a        
            adc #$0c                                 ; $d34a: 69 0c     
            sta $05dc,x                              ; $d34c: 9d dc 05  
            lda #$00                                 ; $d34f: a9 00     
            sta $0604,x                              ; $d351: 9d 04 06  
            jsr __d4fb                               ; $d354: 20 fb d4  
            sta $05e6,x                              ; $d357: 9d e6 05  
            lda $13                                  ; $d35a: a5 13     
            sta $05f0,x                              ; $d35c: 9d f0 05  
            jsr __d56c                               ; $d35f: 20 6c d5  
            jsr __d53c                               ; $d362: 20 3c d5  
            inc CloudGfxX                            ; $d365: e6 54     
            inc CloudGfxX                            ; $d367: e6 54     
            jsr __d53c                               ; $d369: 20 3c d5  
            inc CloudGfxY                            ; $d36c: e6 55     
            inc CloudGfxY                            ; $d36e: e6 55     
            jsr __d53c                               ; $d370: 20 3c d5  
            dec CloudGfxX                            ; $d373: c6 54     
            dec CloudGfxX                            ; $d375: c6 54     
            jsr __d53c                               ; $d377: 20 3c d5  
            inx                                      ; $d37a: e8        
            jmp __d327                               ; $d37b: 4c 27 d3  

;-------------------------------------------------------------------------------
__d37e:     dex                                      ; $d37e: ca        
            stx $05d1                                ; $d37f: 8e d1 05  
            jsr __d4e5                               ; $d382: 20 e5 d4  
            sta GfxPointerLow                        ; $d385: 85 1f     
            jsr __d4e5                               ; $d387: 20 e5 d4  
            sta GfxPointerHigh                       ; $d38a: 85 20     
            ldy #$00                                 ; $d38c: a0 00     
            lda (GfxPointerLow),y                    ; $d38e: b1 1f     
            tax                                      ; $d390: aa        
            dex                                      ; $d391: ca        
            bpl __d399                               ; $d392: 10 05     
            inc IsBonusPhase                         ; $d394: e6 c8     
            jmp __d3ba                               ; $d396: 4c ba d3  

;-------------------------------------------------------------------------------
__d399:     iny                                      ; $d399: c8        
__d39a:     lda (GfxPointerLow),y                    ; $d39a: b1 1f     
            iny                                      ; $d39c: c8        
            sta $93,x                                ; $d39d: 95 93     
            lda (GfxPointerLow),y                    ; $d39f: b1 1f     
            iny                                      ; $d3a1: c8        
            sta $9c,x                                ; $d3a2: 95 9c     
            lda (GfxPointerLow),y                    ; $d3a4: b1 1f     
            iny                                      ; $d3a6: c8        
            sta $0453,x                              ; $d3a7: 9d 53 04  
            lda #$02                                 ; $d3aa: a9 02     
            sta $81,x                                ; $d3ac: 95 81     
            lda #$01                                 ; $d3ae: a9 01     
            sta $8a,x                                ; $d3b0: 95 8a     
            lda $c6                                  ; $d3b2: a5 c6     
            sta $0441,x                              ; $d3b4: 9d 41 04  
            dex                                      ; $d3b7: ca        
            bpl __d39a                               ; $d3b8: 10 e0     
__d3ba:     jsr __d4e5                               ; $d3ba: 20 e5 d4  
            sta PlatformCount                        ; $d3bd: 85 cd     
            jsr __d4e5                               ; $d3bf: 20 e5 d4  
            sta PlatformLeftLow                      ; $d3c2: 85 23     
            jsr __d4e5                               ; $d3c4: 20 e5 d4  
            tay                                      ; $d3c7: a8        
            sta PlatformLeftHigh                     ; $d3c8: 85 24     
            lda PlatformLeftLow                      ; $d3ca: a5 23     
            jsr __d48c                               ; $d3cc: 20 8c d4  
            sta PlatformRightLow                     ; $d3cf: 85 25     
            sty PlatformRightHigh                    ; $d3d1: 84 26     
            jsr __d48c                               ; $d3d3: 20 8c d4  
            sta PlatformTopLow                       ; $d3d6: 85 27     
            sty PlatformTopHigh                      ; $d3d8: 84 28     
            jsr __d48c                               ; $d3da: 20 8c d4  
            sta PlatformBottomLow                    ; $d3dd: 85 29     
            sty PlatformBottonHigh                   ; $d3df: 84 2a     
__d3e1:     jsr __d5d9                               ; $d3e1: 20 d9 d5  
            jsr __d3ed                               ; $d3e4: 20 ed d3  
            jsr __c104                               ; $d3e7: 20 04 c1  
            jmp __c115                               ; $d3ea: 4c 15 c1  

;-------------------------------------------------------------------------------
__d3ed:     ldx #$22                                 ; $d3ed: a2 22     
__d3ef:     lda __d437,x                             ; $d3ef: bd 37 d4  
            sta $57,x                                ; $d3f2: 95 57     
            dex                                      ; $d3f4: ca        
            bpl __d3ef                               ; $d3f5: 10 f8     
            lda IsBonusPhase                         ; $d3f7: a5 c8     
            bne __d410                               ; $d3f9: d0 15     
            lda CurrentLevelHeaderPtr                ; $d3fb: a5 3b     
            and #$0c                                 ; $d3fd: 29 0c     
            ora #$03                                 ; $d3ff: 09 03     
            tay                                      ; $d401: a8        
            ldx #$03                                 ; $d402: a2 03     
__d404:     lda __d45a,y                             ; $d404: b9 5a d4  
            sta $5a,x                                ; $d407: 95 5a     
            dey                                      ; $d409: 88        
            dex                                      ; $d40a: ca        
            bpl __d404                               ; $d40b: 10 f7     
__d40d:     jmp __c12d                               ; $d40d: 4c 2d c1  

;-------------------------------------------------------------------------------
__d410:     ldx BonusPhaseIntensityLevel             ; $d410: ae 58 05  
            lda __d46a,x                             ; $d413: bd 6a d4  
            sta LoadPointerLow                       ; $d416: 85 1d     
            lda __d46f,x                             ; $d418: bd 6f d4  
            sta LoadPointerHigh                      ; $d41b: 85 1e     
            ldx #$03                                 ; $d41d: a2 03     
            ldy #$07                                 ; $d41f: a0 07     
__d421:     lda (LoadPointerLow),y                   ; $d421: b1 1d     
            sta $72,x                                ; $d423: 95 72     
            dey                                      ; $d425: 88        
            dex                                      ; $d426: ca        
            bpl __d421                               ; $d427: 10 f8     
            lda $16                                  ; $d429: a5 16     
            bne __d40d                               ; $d42b: d0 e0     
__d42d:     lda (LoadPointerLow),y                   ; $d42d: b1 1d     
            sta $005a,y                              ; $d42f: 99 5a 00  
            dey                                      ; $d432: 88        
            bpl __d42d                               ; $d433: 10 f8     
            bmi __d40d                               ; $d435: 30 d6     

;-------------------------------------------------------------------------------
__d437:     .hex 3f 00 20 0f                         ; $d437: 3f 00 20 0f   Data
            .hex 2a 09 07 0f                         ; $d43b: 2a 09 07 0f   Data
            .hex 30 27 15 0f                         ; $d43f: 30 27 15 0f   Data
            .hex 30 02 21 0f                         ; $d443: 30 02 21 0f   Data
            .hex 30 00 10 0f                         ; $d447: 30 00 10 0f   Data
            .hex 16 12 37 0f                         ; $d44b: 16 12 37 0f   Data
            .hex 12 16 37 0f                         ; $d44f: 12 16 37 0f   Data
            .hex 17 11 35 0f                         ; $d453: 17 11 35 0f   Data
            .hex 17 11 2b                            ; $d457: 17 11 2b      Data
__d45a:     .hex 0f 2a 09 07                         ; $d45a: 0f 2a 09 07   Data
            .hex 0f 26 06 07                         ; $d45e: 0f 26 06 07   Data
            .hex 0f 1b 0c 07                         ; $d462: 0f 1b 0c 07   Data
            .hex 0f 2c 01 06                         ; $d466: 0f 2c 01 06   Data
__d46a:     .hex 74 7c 84 84                         ; $d46a: 74 7c 84 84   Data
            .hex 84                                  ; $d46e: 84            Data
__d46f:     .hex d4 d4 d4 d4                         ; $d46f: d4 d4 d4 d4   Data
            .hex d4 0f 02 08                         ; $d473: d4 0f 02 08   Data
            .hex 06 0f 2b 30                         ; $d477: 06 0f 2b 30   Data
            .hex 12 0f 07 0a                         ; $d47b: 12 0f 07 0a   Data
            .hex 19 0f 26 30                         ; $d47f: 19 0f 26 30   Data
            .hex 2b 0f 07 0c                         ; $d483: 2b 0f 07 0c   Data
            .hex 1c 0f 15 30                         ; $d487: 1c 0f 15 30   Data
            .hex 26                                  ; $d48b: 26            Data

;-------------------------------------------------------------------------------
__d48c:     sec                                      ; $d48c: 38        
            adc PlatformCount                        ; $d48d: 65 cd     
            bcc __d492                               ; $d48f: 90 01     
            iny                                      ; $d491: c8        
__d492:     rts                                      ; $d492: 60        

;-------------------------------------------------------------------------------
__d493:     .hex 7f 7e 7d 7c                         ; $d493: 7f 7e 7d 7c   Data

;-------------------------------------------------------------------------------
__d497:     jsr __d4e5                               ; $d497: 20 e5 d4  
            sta GfxPointerLow                        ; $d49a: 85 1f     
            jsr __d4e5                               ; $d49c: 20 e5 d4  
            sta GfxPointerHigh                       ; $d49f: 85 20     
            tax                                      ; $d4a1: aa        
            beq __d4e4                               ; $d4a2: f0 40     
__d4a4:     jsr __d4f0                               ; $d4a4: 20 f0 d4  
            tax                                      ; $d4a7: aa        
            beq __d497                               ; $d4a8: f0 ed     
            and #$7f                                 ; $d4aa: 29 7f     
            sta $2006                                ; $d4ac: 8d 06 20  
            jsr __d4f0                               ; $d4af: 20 f0 d4  
            sta $2006                                ; $d4b2: 8d 06 20  
            jsr __d4f0                               ; $d4b5: 20 f0 d4  
            sta BytesLeftToLoad                      ; $d4b8: 85 12     
            txa                                      ; $d4ba: 8a        
            and #$80                                 ; $d4bb: 29 80     
            lsr                                      ; $d4bd: 4a        
            lsr                                      ; $d4be: 4a        
            lsr                                      ; $d4bf: 4a        
            lsr                                      ; $d4c0: 4a        
            lsr                                      ; $d4c1: 4a        
            ora $00                                  ; $d4c2: 05 00     
            sta $2000                                ; $d4c4: 8d 00 20  
            txa                                      ; $d4c7: 8a        
            and #$40                                 ; $d4c8: 29 40     
            bne __d4d8                               ; $d4ca: d0 0c     
__d4cc:     jsr __d4f0                               ; $d4cc: 20 f0 d4  
            sta $2007                                ; $d4cf: 8d 07 20  
            dec BytesLeftToLoad                      ; $d4d2: c6 12     
            bne __d4cc                               ; $d4d4: d0 f6     
            beq __d4a4                               ; $d4d6: f0 cc     
__d4d8:     jsr __d4f0                               ; $d4d8: 20 f0 d4  
__d4db:     sta $2007                                ; $d4db: 8d 07 20  
            dec BytesLeftToLoad                      ; $d4de: c6 12     
            bne __d4db                               ; $d4e0: d0 f9     
            beq __d4a4                               ; $d4e2: f0 c0     
__d4e4:     rts                                      ; $d4e4: 60        

;-------------------------------------------------------------------------------
__d4e5:     ldy #$00                                 ; $d4e5: a0 00     
            lda (LoadPointerLow),y                   ; $d4e7: b1 1d     
            inc LoadPointerLow                       ; $d4e9: e6 1d     
            bne __d4ef                               ; $d4eb: d0 02     
            inc LoadPointerHigh                      ; $d4ed: e6 1e     
__d4ef:     rts                                      ; $d4ef: 60        

;-------------------------------------------------------------------------------
__d4f0:     ldy #$00                                 ; $d4f0: a0 00     
            lda (GfxPointerLow),y                    ; $d4f2: b1 1f     
            inc GfxPointerLow                        ; $d4f4: e6 1f     
            bne __d4fa                               ; $d4f6: d0 02     
            inc GfxPointerHigh                       ; $d4f8: e6 20     
__d4fa:     rts                                      ; $d4fa: 60        

;-------------------------------------------------------------------------------
__d4fb:     lda CloudGfxY                            ; $d4fb: a5 55     
            sta BytesLeftToLoad                      ; $d4fd: 85 12     
            lda #$00                                 ; $d4ff: a9 00     
            asl BytesLeftToLoad                      ; $d501: 06 12     
            asl BytesLeftToLoad                      ; $d503: 06 12     
            asl BytesLeftToLoad                      ; $d505: 06 12     
            asl BytesLeftToLoad                      ; $d507: 06 12     
            rol                                      ; $d509: 2a        
            asl BytesLeftToLoad                      ; $d50a: 06 12     
            rol                                      ; $d50c: 2a        
            ora #$20                                 ; $d50d: 09 20     
            sta $2006                                ; $d50f: 8d 06 20  
            sta $13                                  ; $d512: 85 13     
            lda BytesLeftToLoad                      ; $d514: a5 12     
            ora CloudGfxX                            ; $d516: 05 54     
            sta $2006                                ; $d518: 8d 06 20  
            rts                                      ; $d51b: 60        

;-------------------------------------------------------------------------------
__d51c:     lda CloudGfxY                            ; $d51c: a5 55     
            and #$fc                                 ; $d51e: 29 fc     
            asl                                      ; $d520: 0a        
            sta BytesLeftToLoad                      ; $d521: 85 12     
            lda CloudGfxX                            ; $d523: a5 54     
            lsr                                      ; $d525: 4a        
            lsr                                      ; $d526: 4a        
            ora BytesLeftToLoad                      ; $d527: 05 12     
            ora #$c0                                 ; $d529: 09 c0     
            pha                                      ; $d52b: 48        
            lda CloudGfxY                            ; $d52c: a5 55     
            and #$02                                 ; $d52e: 29 02     
            sta BytesLeftToLoad                      ; $d530: 85 12     
            lda CloudGfxX                            ; $d532: a5 54     
            and #$02                                 ; $d534: 29 02     
            lsr                                      ; $d536: 4a        
            ora BytesLeftToLoad                      ; $d537: 05 12     
            tay                                      ; $d539: a8        
            pla                                      ; $d53a: 68        
            rts                                      ; $d53b: 60        

;-------------------------------------------------------------------------------
__d53c:     lda #$23                                 ; $d53c: a9 23     
            sta $2006                                ; $d53e: 8d 06 20  
            jsr __d51c                               ; $d541: 20 1c d5  
            sta $2006                                ; $d544: 8d 06 20  
            lda $2007                                ; $d547: ad 07 20  
            lda $2007                                ; $d54a: ad 07 20  
            and __d564,y                             ; $d54d: 39 64 d5  
            ora __d568,y                             ; $d550: 19 68 d5  
            pha                                      ; $d553: 48        
            lda #$23                                 ; $d554: a9 23     
            sta $2006                                ; $d556: 8d 06 20  
            jsr __d51c                               ; $d559: 20 1c d5  
            sta $2006                                ; $d55c: 8d 06 20  
            pla                                      ; $d55f: 68        
            sta $2007                                ; $d560: 8d 07 20  
            rts                                      ; $d563: 60        

;-------------------------------------------------------------------------------
__d564:     .hex fc f3 cf 3f                         ; $d564: fc f3 cf 3f   Data
__d568:     .hex 01 04 10 40                         ; $d568: 01 04 10 40   Data
__d56c:     jsr __cccb                               ; $d56c: 20 cb cc  
            jmp __c17c                               ; $d56f: 4c 7c c1  

;-------------------------------------------------------------------------------
__d572:     lda #$c0                                 ; $d572: a9 c0     
            ldy #$23                                 ; $d574: a0 23     
            jsr __d593                               ; $d576: 20 93 d5  
            lda #$c0                                 ; $d579: a9 c0     
            ldy #$27                                 ; $d57b: a0 27     
            jsr __d593                               ; $d57d: 20 93 d5  
            ldy #$23                                 ; $d580: a0 23     
            lda #$60                                 ; $d582: a9 60     
            jsr __d5b8                               ; $d584: 20 b8 d5  
            ldy #$27                                 ; $d587: a0 27     
            lda #$60                                 ; $d589: a9 60     
            jsr __d5b8                               ; $d58b: 20 b8 d5  
            inc IsBonusPhase                         ; $d58e: e6 c8     
            jmp __d3e1                               ; $d590: 4c e1 d3  

;-------------------------------------------------------------------------------
__d593:     sty $2006                                ; $d593: 8c 06 20  
            sta $2006                                ; $d596: 8d 06 20  
            ldx #$00                                 ; $d599: a2 00     
__d59b:     lda __dcae,x                             ; $d59b: bd ae dc  
            sta $2007                                ; $d59e: 8d 07 20  
            inx                                      ; $d5a1: e8        
            cpx #$08                                 ; $d5a2: e0 08     
            bne __d59b                               ; $d5a4: d0 f5     
            lda #$00                                 ; $d5a6: a9 00     
            ldx #$28                                 ; $d5a8: a2 28     
            jsr __d5b1                               ; $d5aa: 20 b1 d5  
            lda #$aa                                 ; $d5ad: a9 aa     
            ldx #$10                                 ; $d5af: a2 10     
__d5b1:     sta $2007                                ; $d5b1: 8d 07 20  
            dex                                      ; $d5b4: ca        
            bne __d5b1                               ; $d5b5: d0 fa     
            rts                                      ; $d5b7: 60        

;-------------------------------------------------------------------------------
__d5b8:     sty $2006                                ; $d5b8: 8c 06 20  
            sta $2006                                ; $d5bb: 8d 06 20  
            ldx #$20                                 ; $d5be: a2 20     
            lda #$58                                 ; $d5c0: a9 58     
            jsr __d5c9                               ; $d5c2: 20 c9 d5  
            ldx #$40                                 ; $d5c5: a2 40     
            lda #$5c                                 ; $d5c7: a9 5c     
__d5c9:     sta BytesLeftToLoad                      ; $d5c9: 85 12     
__d5cb:     txa                                      ; $d5cb: 8a        
            and #$03                                 ; $d5cc: 29 03     
            eor #$03                                 ; $d5ce: 49 03     
            ora BytesLeftToLoad                      ; $d5d0: 05 12     
            sta $2007                                ; $d5d2: 8d 07 20  
            dex                                      ; $d5d5: ca        
            bne __d5cb                               ; $d5d6: d0 f3     
            rts                                      ; $d5d8: 60        

;-------------------------------------------------------------------------------
__d5d9:     ldx #$00                                 ; $d5d9: a2 00     
__d5db:     jsr __d651                               ; $d5db: 20 51 d6  
            jsr __d5f1                               ; $d5de: 20 f1 d5  
            lda $51                                  ; $d5e1: a5 51     
            ora #$04                                 ; $d5e3: 09 04     
            sta $51                                  ; $d5e5: 85 51     
            jsr __d5f1                               ; $d5e7: 20 f1 d5  
            inx                                      ; $d5ea: e8        
            inx                                      ; $d5eb: e8        
            cpx #$80                                 ; $d5ec: e0 80     
            bne __d5db                               ; $d5ee: d0 eb     
            rts                                      ; $d5f0: 60        

;-------------------------------------------------------------------------------
__d5f1:     lda $51                                  ; $d5f1: a5 51     
            sta $2006                                ; $d5f3: 8d 06 20  
            lda $50                                  ; $d5f6: a5 50     
            sta $2006                                ; $d5f8: 8d 06 20  
            lda $2007                                ; $d5fb: ad 07 20  
            lda $2007                                ; $d5fe: ad 07 20  
            cmp #$24                                 ; $d601: c9 24     
            bne __d60c                               ; $d603: d0 07     
            txa                                      ; $d605: 8a        
            and #$03                                 ; $d606: 29 03     
            tay                                      ; $d608: a8        
            jmp __d63b                               ; $d609: 4c 3b d6  

;-------------------------------------------------------------------------------
__d60c:     rts                                      ; $d60c: 60        

;-------------------------------------------------------------------------------
__d60d:     lda $4c                                  ; $d60d: a5 4c     
            beq __d63a                               ; $d60f: f0 29     
            dec $4c                                  ; $d611: c6 4c     
            lda $4f                                  ; $d613: a5 4f     
            clc                                      ; $d615: 18        
            adc #$02                                 ; $d616: 69 02     
            and #$3f                                 ; $d618: 29 3f     
            sta $4f                                  ; $d61a: 85 4f     
            tax                                      ; $d61c: aa        
            jsr __d651                               ; $d61d: 20 51 d6  
            lda $51                                  ; $d620: a5 51     
            sta $2006                                ; $d622: 8d 06 20  
            lda $50                                  ; $d625: a5 50     
            sta $2006                                ; $d627: 8d 06 20  
            lda $2007                                ; $d62a: ad 07 20  
            lda $2007                                ; $d62d: ad 07 20  
            ldy #$03                                 ; $d630: a0 03     
__d632:     cmp __d64c,y                             ; $d632: d9 4c d6  
            beq __d63b                               ; $d635: f0 04     
            dey                                      ; $d637: 88        
            bpl __d632                               ; $d638: 10 f8     
__d63a:     rts                                      ; $d63a: 60        

;-------------------------------------------------------------------------------
__d63b:     lda $51                                  ; $d63b: a5 51     
            sta $2006                                ; $d63d: 8d 06 20  
            lda $50                                  ; $d640: a5 50     
            sta $2006                                ; $d642: 8d 06 20  
            lda __d64d,y                             ; $d645: b9 4d d6  
            sta $2007                                ; $d648: 8d 07 20  
            rts                                      ; $d64b: 60        

;-------------------------------------------------------------------------------
__d64c:     .hex 24                                  ; $d64c: 24            Data
__d64d:     .hex ed ee ef 24                         ; $d64d: ed ee ef 24   Data

;-------------------------------------------------------------------------------
__d651:     lda __d65c,x                             ; $d651: bd 5c d6  
            sta $50                                  ; $d654: 85 50     
            lda __d65d,x                             ; $d656: bd 5d d6  
            sta $51                                  ; $d659: 85 51     
            rts                                      ; $d65b: 60        

;-------------------------------------------------------------------------------
__d65c:     .hex 63                                  ; $d65c: 63            Data
__d65d:     .hex 21 a5 21 cb                         ; $d65d: 21 a5 21 cb   Data
            .hex 20 b7 20 7d                         ; $d661: 20 b7 20 7d   Data
            .hex 21 9b 22 f2                         ; $d665: 21 9b 22 f2   Data
            .hex 20 49 22 6d                         ; $d669: 20 49 22 6d   Data
            .hex 21 0b 22 92                         ; $d66d: 21 0b 22 92   Data
            .hex 22 95 21 1c                         ; $d671: 22 95 21 1c   Data
            .hex 21 48 21 e0                         ; $d675: 21 48 21 e0   Data
            .hex 20 0b 23 ce                         ; $d679: 20 0b 23 ce   Data
            .hex 20 d0 21 06                         ; $d67d: 20 d0 21 06   Data
            .hex 21 19 21 30                         ; $d681: 21 19 21 30   Data
            .hex 22 8a 22 88                         ; $d685: 22 8a 22 88   Data
            .hex 22 a4 20 42                         ; $d689: 22 a4 20 42   Data
            .hex 22 68 21 3c                         ; $d68d: 22 68 21 3c   Data
            .hex 22 36 21 ca                         ; $d691: 22 36 21 ca   Data
            .hex 21 bc 20 96                         ; $d695: 21 bc 20 96   Data
            .hex 21 4c 21 35                         ; $d699: 21 4c 21 35   Data
            .hex 22 ef 20 68                         ; $d69d: 22 ef 20 68   Data
            .hex 22 a6 20 bb                         ; $d6a1: 22 a6 20 bb   Data
            .hex 21 7a 21 ea                         ; $d6a5: 21 7a 21 ea   Data
            .hex 20 f1 21 c2                         ; $d6a9: 20 f1 21 c2   Data
            .hex 20 77 21 54                         ; $d6ad: 20 77 21 54   Data
            .hex 21 ba 20 c5                         ; $d6b1: 21 ba 20 c5   Data
            .hex 22 be 20 fa                         ; $d6b5: 22 be 20 fa   Data
            .hex 20 ae 21 46                         ; $d6b9: 20 ae 21 46   Data
            .hex 21 9a 21 d2                         ; $d6bd: 21 9a 21 d2   Data
            .hex 20 3d 21 2b                         ; $d6c1: 20 3d 21 2b   Data
            .hex 22 b0 20 b6                         ; $d6c5: 22 b0 20 b6   Data
            .hex 21 ac 20 b3                         ; $d6c9: 21 ac 20 b3   Data
            .hex 20 db 20 f6                         ; $d6cd: 20 db 20 f6   Data
            .hex 20 2c 21 e7                         ; $d6d1: 20 2c 21 e7   Data
            .hex 20 62 21 e4                         ; $d6d5: 20 62 21 e4   Data
            .hex 21 4e 21                            ; $d6d9: 21 4e 21      Data
__d6dc:     lda #$00                                 ; $d6dc: a9 00     
__d6de:     sta $43                                  ; $d6de: 85 43     
            lda $3a                                  ; $d6e0: a5 3a     
            beq __d6e5                               ; $d6e2: f0 01     
__d6e4:     rts                                      ; $d6e4: 60        

;-------------------------------------------------------------------------------
__d6e5:     ldx $3e                                  ; $d6e5: a6 3e     
            cpx #$02                                 ; $d6e7: e0 02     
            bcs __d6e4                               ; $d6e9: b0 f9     
            lda Player1Lives,x                       ; $d6eb: b5 41     
            bmi __d6e4                               ; $d6ed: 30 f5     
            ldy #$64                                 ; $d6ef: a0 64     
            jsr __d77c                               ; $d6f1: 20 7c d7  
            clc                                      ; $d6f4: 18        
            adc $48                                  ; $d6f5: 65 48     
            sta $45                                  ; $d6f7: 85 45     
            ldy #$0a                                 ; $d6f9: a0 0a     
            jsr __d77c                               ; $d6fb: 20 7c d7  
            sta $44                                  ; $d6fe: 85 44     
            ldx GameMode                             ; $d700: a6 3f     
            lda __d779,x                             ; $d702: bd 79 d7  
            sta $21                                  ; $d705: 85 21     
            lda #$06                                 ; $d707: a9 06     
            sta $22                                  ; $d709: 85 22     
            lda $3e                                  ; $d70b: a5 3e     
            asl                                      ; $d70d: 0a        
            asl                                      ; $d70e: 0a        
            ora $3e                                  ; $d70f: 05 3e     
            tax                                      ; $d711: aa        
            clc                                      ; $d712: 18        
            lda $03,x                                ; $d713: b5 03     
            adc $43                                  ; $d715: 65 43     
            jsr __d78f                               ; $d717: 20 8f d7  
            sta $03,x                                ; $d71a: 95 03     
            lda $04,x                                ; $d71c: b5 04     
            adc $44                                  ; $d71e: 65 44     
            jsr __d78f                               ; $d720: 20 8f d7  
            sta $04,x                                ; $d723: 95 04     
            lda $05,x                                ; $d725: b5 05     
            adc $45                                  ; $d727: 65 45     
            jsr __d78f                               ; $d729: 20 8f d7  
            sta $05,x                                ; $d72c: 95 05     
            lda $06,x                                ; $d72e: b5 06     
            adc $47                                  ; $d730: 65 47     
            jsr __d78f                               ; $d732: 20 8f d7  
            sta $06,x                                ; $d735: 95 06     
            lda $07,x                                ; $d737: b5 07     
            adc #$00                                 ; $d739: 69 00     
            jsr __d78f                               ; $d73b: 20 8f d7  
            sta $07,x                                ; $d73e: 95 07     
            inx                                      ; $d740: e8        
            inx                                      ; $d741: e8        
            inx                                      ; $d742: e8        
            inx                                      ; $d743: e8        
            ldy #$04                                 ; $d744: a0 04     
__d746:     lda $03,x                                ; $d746: b5 03     
            cmp ($21),y                              ; $d748: d1 21     
            bcc __d765                               ; $d74a: 90 19     
            bne __d752                               ; $d74c: d0 04     
            dex                                      ; $d74e: ca        
            dey                                      ; $d74f: 88        
            bpl __d746                               ; $d750: 10 f4     
__d752:     ldy #$00                                 ; $d752: a0 00     
            lda $3e                                  ; $d754: a5 3e     
            asl                                      ; $d756: 0a        
            asl                                      ; $d757: 0a        
            ora $3e                                  ; $d758: 05 3e     
            tax                                      ; $d75a: aa        
__d75b:     lda $03,x                                ; $d75b: b5 03     
            sta ($21),y                              ; $d75d: 91 21     
            inx                                      ; $d75f: e8        
            iny                                      ; $d760: c8        
            cpy #$05                                 ; $d761: c0 05     
            bne __d75b                               ; $d763: d0 f6     
__d765:     ldy #$04                                 ; $d765: a0 04     
__d767:     lda ($21),y                              ; $d767: b1 21     
            sta $000d,y                              ; $d769: 99 0d 00  
            dey                                      ; $d76c: 88        
            bpl __d767                               ; $d76d: 10 f8     
            inc $46                                  ; $d76f: e6 46     
            lda $16                                  ; $d771: a5 16     
            beq __d778                               ; $d773: f0 03     
            jsr __c539                               ; $d775: 20 39 c5  
__d778:     rts                                      ; $d778: 60        

;-------------------------------------------------------------------------------
__d779:     .hex 29 2e 33                            ; $d779: 29 2e 33      Data

;-------------------------------------------------------------------------------
__d77c:     sty BytesLeftToLoad                      ; $d77c: 84 12     
            ldx #$ff                                 ; $d77e: a2 ff     
            lda $43                                  ; $d780: a5 43     
__d782:     sec                                      ; $d782: 38        
            sbc BytesLeftToLoad                      ; $d783: e5 12     
            inx                                      ; $d785: e8        
            bcs __d782                               ; $d786: b0 fa     
            clc                                      ; $d788: 18        
            adc BytesLeftToLoad                      ; $d789: 65 12     
            sta $43                                  ; $d78b: 85 43     
            txa                                      ; $d78d: 8a        
            rts                                      ; $d78e: 60        

;-------------------------------------------------------------------------------
__d78f:     cmp #$0a                                 ; $d78f: c9 0a     
            bcs __d794                               ; $d791: b0 01     
            rts                                      ; $d793: 60        

;-------------------------------------------------------------------------------
__d794:     sec                                      ; $d794: 38        
            sbc #$0a                                 ; $d795: e9 0a     
            rts                                      ; $d797: 60        

;-------------------------------------------------------------------------------
__d798:     ldy $46                                  ; $d798: a4 46     
            dey                                      ; $d79a: 88        
            beq __d7a0                               ; $d79b: f0 03     
            bpl __d805                               ; $d79d: 10 66     
            rts                                      ; $d79f: 60        

;-------------------------------------------------------------------------------
__d7a0:     lda #$20                                 ; $d7a0: a9 20     
            sta $2006                                ; $d7a2: 8d 06 20  
            lda #$43                                 ; $d7a5: a9 43     
            sta $2006                                ; $d7a7: 8d 06 20  
            lda #$8e                                 ; $d7aa: a9 8e     
            sta $2007                                ; $d7ac: 8d 07 20  
            ldx #$04                                 ; $d7af: a2 04     
__d7b1:     lda $03,x                                ; $d7b1: b5 03     
            sta $2007                                ; $d7b3: 8d 07 20  
            dex                                      ; $d7b6: ca        
            bpl __d7b1                               ; $d7b7: 10 f8     
            lda #$00                                 ; $d7b9: a9 00     
            sta $2007                                ; $d7bb: 8d 07 20  
            lda #$24                                 ; $d7be: a9 24     
            sta $2007                                ; $d7c0: 8d 07 20  
            sta $2007                                ; $d7c3: 8d 07 20  
            ldx #$8c                                 ; $d7c6: a2 8c     
            stx $2007                                ; $d7c8: 8e 07 20  
            inx                                      ; $d7cb: e8        
            stx $2007                                ; $d7cc: 8e 07 20  
            ldx #$04                                 ; $d7cf: a2 04     
__d7d1:     lda $0d,x                                ; $d7d1: b5 0d     
            sta $2007                                ; $d7d3: 8d 07 20  
            dex                                      ; $d7d6: ca        
            bpl __d7d1                               ; $d7d7: 10 f8     
            lda #$00                                 ; $d7d9: a9 00     
            sta $2007                                ; $d7db: 8d 07 20  
            lda #$24                                 ; $d7de: a9 24     
            sta $2007                                ; $d7e0: 8d 07 20  
            sta $2007                                ; $d7e3: 8d 07 20  
            lda $16                                  ; $d7e6: a5 16     
            bne __d854                               ; $d7e8: d0 6a     
            lda NumberOfPlayers                      ; $d7ea: a5 40     
            beq __d802                               ; $d7ec: f0 14     
            lda #$8f                                 ; $d7ee: a9 8f     
            sta $2007                                ; $d7f0: 8d 07 20  
            ldx #$04                                 ; $d7f3: a2 04     
__d7f5:     lda $08,x                                ; $d7f5: b5 08     
            sta $2007                                ; $d7f7: 8d 07 20  
            dex                                      ; $d7fa: ca        
            bpl __d7f5                               ; $d7fb: 10 f8     
            lda #$00                                 ; $d7fd: a9 00     
            sta $2007                                ; $d7ff: 8d 07 20  
__d802:     dec $46                                  ; $d802: c6 46     
            rts                                      ; $d804: 60        

;-------------------------------------------------------------------------------
__d805:     dec $46                                  ; $d805: c6 46     
            lda #$20                                 ; $d807: a9 20     
            sta $2006                                ; $d809: 8d 06 20  
            lda #$62                                 ; $d80c: a9 62     
            sta $2006                                ; $d80e: 8d 06 20  
            lda Player1Lives                         ; $d811: a5 41     
            jsr __d826                               ; $d813: 20 26 d8  
            lda NumberOfPlayers                      ; $d816: a5 40     
            beq __d83a                               ; $d818: f0 20     
            lda #$20                                 ; $d81a: a9 20     
            sta $2006                                ; $d81c: 8d 06 20  
            lda #$75                                 ; $d81f: a9 75     
            sta $2006                                ; $d821: 8d 06 20  
            lda Player2Lives                         ; $d824: a5 42     
__d826:     bmi __d83b                               ; $d826: 30 13     
__d828:     sta $50                                  ; $d828: 85 50     
            ldx #$06                                 ; $d82a: a2 06     
__d82c:     lda #$24                                 ; $d82c: a9 24     
            cpx $50                                  ; $d82e: e4 50     
            bcs __d834                               ; $d830: b0 02     
            lda #$2a                                 ; $d832: a9 2a     
__d834:     sta $2007                                ; $d834: 8d 07 20  
            dex                                      ; $d837: ca        
            bpl __d82c                               ; $d838: 10 f2     
__d83a:     rts                                      ; $d83a: 60        

;-------------------------------------------------------------------------------
__d83b:     lda NumberOfPlayers                      ; $d83b: a5 40     
            beq __d828                               ; $d83d: f0 e9     
            ldx #$08                                 ; $d83f: a2 08     
__d841:     lda __d84b,x                             ; $d841: bd 4b d8  
            sta $2007                                ; $d844: 8d 07 20  
            dex                                      ; $d847: ca        
            bpl __d841                               ; $d848: 10 f7     
            rts                                      ; $d84a: 60        

;-------------------------------------------------------------------------------
__d84b:     .hex 1b 0e 1f 18                         ; $d84b: 1b 0e 1f 18   Data
            .hex 24 0e 16 0a                         ; $d84f: 24 0e 16 0a   Data
            .hex 10                                  ; $d853: 10            Data

;-------------------------------------------------------------------------------
__d854:     ldy #$04                                 ; $d854: a0 04     
__d856:     lda __d86c,y                             ; $d856: b9 6c d8  
            sta $2007                                ; $d859: 8d 07 20  
            dey                                      ; $d85c: 88        
            bpl __d856                               ; $d85d: 10 f7     
            lda BalloonTripRankTenDigit              ; $d85f: a5 4a     
            sta $2007                                ; $d861: 8d 07 20  
            lda BalloonTripRankUnitDigit             ; $d864: a5 49     
            sta $2007                                ; $d866: 8d 07 20  
            dec $46                                  ; $d869: c6 46     
            rts                                      ; $d86b: 60        

;-------------------------------------------------------------------------------
__d86c:     .hex fb fa f9 f8                         ; $d86c: fb fa f9 f8   Data
            .hex f7                                  ; $d870: f7            Data

;-------------------------------------------------------------------------------
__d871:     sta BytesLeftToLoad                      ; $d871: 85 12     
            stx $13                                  ; $d873: 86 13     
            sty $14                                  ; $d875: 84 14     
            ldx #$01                                 ; $d877: a2 01     
__d879:     lda $061a,x                              ; $d879: bd 1a 06  
            bmi __d88c                               ; $d87c: 30 0e     
            dex                                      ; $d87e: ca        
            bpl __d879                               ; $d87f: 10 f8     
            ldx #$01                                 ; $d881: a2 01     
            lda $0619                                ; $d883: ad 19 06  
            cmp $0618                                ; $d886: cd 18 06  
            bcc __d88c                               ; $d889: 90 01     
            dex                                      ; $d88b: ca        
__d88c:     lda #$64                                 ; $d88c: a9 64     
            sta $0618,x                              ; $d88e: 9d 18 06  
            lda BytesLeftToLoad                      ; $d891: a5 12     
            sta $061a,x                              ; $d893: 9d 1a 06  
            tay                                      ; $d896: a8        
            txa                                      ; $d897: 8a        
            asl                                      ; $d898: 0a        
            asl                                      ; $d899: 0a        
            asl                                      ; $d89a: 0a        
            tax                                      ; $d89b: aa        
            lda __d8d1,y                             ; $d89c: b9 d1 d8  
            sta $02f1,x                              ; $d89f: 9d f1 02  
            lda __d8d7,y                             ; $d8a2: b9 d7 d8  
            sta $02f5,x                              ; $d8a5: 9d f5 02  
            ldy $13                                  ; $d8a8: a4 13     
            lda $009a,y                              ; $d8aa: b9 9a 00  
            sec                                      ; $d8ad: 38        
            sbc #$08                                 ; $d8ae: e9 08     
            sta $02f0,x                              ; $d8b0: 9d f0 02  
            sta $02f4,x                              ; $d8b3: 9d f4 02  
            lda $0091,y                              ; $d8b6: b9 91 00  
            sta $02f3,x                              ; $d8b9: 9d f3 02  
            clc                                      ; $d8bc: 18        
            adc #$08                                 ; $d8bd: 69 08     
            sta $02f7,x                              ; $d8bf: 9d f7 02  
            lda $3e                                  ; $d8c2: a5 3e     
            sta $02f2,x                              ; $d8c4: 9d f2 02  
            sta $02f6,x                              ; $d8c7: 9d f6 02  
            ldy $14                                  ; $d8ca: a4 14     
            ldx $13                                  ; $d8cc: a6 13     
            lda BytesLeftToLoad                      ; $d8ce: a5 12     
            rts                                      ; $d8d0: 60        

;-------------------------------------------------------------------------------
__d8d1:     .hex f4 f5 f6 f7                         ; $d8d1: f4 f5 f6 f7   Data
            .hex f8 f9                               ; $d8d5: f8 f9         Data
__d8d7:     .hex fb fb fa fb                         ; $d8d7: fb fb fa fb   Data
            .hex fb fb                               ; $d8db: fb fb         Data

;-------------------------------------------------------------------------------
__d8dd:     ldx #$01                                 ; $d8dd: a2 01     
__d8df:     lda $061a,x                              ; $d8df: bd 1a 06  
            bmi __d8fb                               ; $d8e2: 30 17     
            dec $0618,x                              ; $d8e4: de 18 06  
            bne __d8fb                               ; $d8e7: d0 12     
            lda #$ff                                 ; $d8e9: a9 ff     
            sta $061a,x                              ; $d8eb: 9d 1a 06  
            txa                                      ; $d8ee: 8a        
            asl                                      ; $d8ef: 0a        
            asl                                      ; $d8f0: 0a        
            asl                                      ; $d8f1: 0a        
            tay                                      ; $d8f2: a8        
            lda #$f0                                 ; $d8f3: a9 f0     
            sta $02f0,y                              ; $d8f5: 99 f0 02  
            sta $02f4,y                              ; $d8f8: 99 f4 02  
__d8fb:     dex                                      ; $d8fb: ca        
            bpl __d8df                               ; $d8fc: 10 e1     
            rts                                      ; $d8fe: 60        

;-------------------------------------------------------------------------------
__d8ff:     ldx #$01                                 ; $d8ff: a2 01     
__d901:     lda #$00                                 ; $d901: a9 00     
            sta $0618,x                              ; $d903: 9d 18 06  
            lda #$ff                                 ; $d906: a9 ff     
            sta $061a,x                              ; $d908: 9d 1a 06  
            dex                                      ; $d90b: ca        
            bpl __d901                               ; $d90c: 10 f3     
            rts                                      ; $d90e: 60        

;-------------------------------------------------------------------------------
__d90f:     jsr __d246                               ; $d90f: 20 46 d2  
            jsr __c10a                               ; $d912: 20 0a c1  
            jsr __f465                               ; $d915: 20 65 f4  
            jsr __c0fa                               ; $d918: 20 fa c0  
            lda #$2c                                 ; $d91b: a9 2c     
            sta LoadPointerLow                       ; $d91d: 85 1d     
            lda #$d9                                 ; $d91f: a9 d9     
            sta LoadPointerHigh                      ; $d921: 85 1e     
            jsr __d497                               ; $d923: 20 97 d4  
            jsr __c104                               ; $d926: 20 04 c1  
            jmp __c115                               ; $d929: 4c 15 c1  

;-------------------------------------------------------------------------------
TitleScreenNameTablePtrLo:
            .hex 30                                  ; $d92c: 30            Data

TitleScreenNameTablePtrHi:
            .hex d9 00 00                            ; $d92d: d9 00 00      Data

TitleScreenNameTable:
            .hex 3f 00 04 0f                         ; $d930: 3f 00 04 0f   Data
            .hex 30 27 2a 3f                         ; $d934: 30 27 2a 3f   Data
            .hex 18 04 0f 16                         ; $d938: 18 04 0f 16   Data
            .hex 30 21 20 7c                         ; $d93c: 30 21 20 7c   Data
            .hex 21 f0 f1 24                         ; $d940: 21 f0 f1 24   Data
            .hex 24 24 24 e0                         ; $d944: 24 24 24 e0   Data
            .hex e1 e1 e2 e0                         ; $d948: e1 e1 e2 e0   Data
            .hex e1 e1 e2 e0                         ; $d94c: e1 e1 e2 e0   Data
            .hex e2 24 e0 e2                         ; $d950: e2 24 e0 e2   Data
            .hex 24 e0 e1 e1                         ; $d954: 24 e0 e1 e1   Data
            .hex e2 e0 e1 e1                         ; $d958: e2 e0 e1 e1   Data
            .hex e2 e0 ec 24                         ; $d95c: e2 e0 ec 24   Data
            .hex e0 e2 20 a2                         ; $d960: e0 e2 20 a2   Data
            .hex 1b e3 e3 e3                         ; $d964: 1b e3 e3 e3   Data
            .hex e5 e3 e3 e3                         ; $d968: e5 e3 e3 e3   Data
            .hex e5 e3 e5 24                         ; $d96c: e5 e3 e5 24   Data
            .hex e3 e5 24 e3                         ; $d970: e3 e5 24 e3   Data
            .hex e3 e3 e5 e3                         ; $d974: e3 e3 e5 e3   Data
            .hex e3 e3 e5 e3                         ; $d978: e3 e3 e5 e3   Data
            .hex e3 f3 e3 e5                         ; $d97c: e3 f3 e3 e5   Data
            .hex 20 c2 1b e3                         ; $d980: 20 c2 1b e3   Data
            .hex e4 e3 e7 e3                         ; $d984: e4 e3 e7 e3   Data
            .hex e4 e3 e5 e3                         ; $d988: e4 e3 e5 e3   Data
            .hex e5 24 e3 e5                         ; $d98c: e5 24 e3 e5   Data
            .hex 24 e3 e4 e3                         ; $d990: 24 e3 e4 e3   Data
            .hex e5 e3 e4 e3                         ; $d994: e5 e3 e4 e3   Data
            .hex e5 e3 e3 e3                         ; $d998: e5 e3 e3 e3   Data
            .hex e3 e5 20 e2                         ; $d99c: e3 e5 20 e2   Data
            .hex 1b e3 e3 e3                         ; $d9a0: 1b e3 e3 e3   Data
            .hex e2 e3 e3 e3                         ; $d9a4: e2 e3 e3 e3   Data
            .hex e5 e3 e5 24                         ; $d9a8: e5 e3 e5 24   Data
            .hex e3 e5 24 e3                         ; $d9ac: e3 e5 24 e3   Data
            .hex e3 e3 e5 e3                         ; $d9b0: e3 e3 e5 e3   Data
            .hex e3 e3 e5 e3                         ; $d9b4: e3 e3 e5 e3   Data
            .hex e3 e3 e3 e5                         ; $d9b8: e3 e3 e3 e5   Data
            .hex 21 02 1b e3                         ; $d9bc: 21 02 1b e3   Data
            .hex e4 e3 e5 e3                         ; $d9c0: e4 e3 e5 e3   Data
            .hex f2 e3 e5 e3                         ; $d9c4: f2 e3 e5 e3   Data
            .hex e3 e2 e3 e3                         ; $d9c8: e3 e2 e3 e3   Data
            .hex e2 e3 e3 e3                         ; $d9cc: e2 e3 e3 e3   Data
            .hex e5 e3 e3 e3                         ; $d9d0: e5 e3 e3 e3   Data
            .hex e5 e3 f2 e3                         ; $d9d4: e5 e3 f2 e3   Data
            .hex e3 e5 21 22                         ; $d9d8: e3 e5 21 22   Data
            .hex 1b e6 e3 e3                         ; $d9dc: 1b e6 e3 e3   Data
            .hex e7 eb 24 e6                         ; $d9e0: e7 eb 24 e6   Data
            .hex e7 e6 e3 e7                         ; $d9e4: e7 e6 e3 e7   Data
            .hex e6 e3 e7 e6                         ; $d9e8: e6 e3 e7 e6   Data
            .hex e3 e3 e7 e6                         ; $d9ec: e3 e3 e7 e6   Data
            .hex e3 e3 e7 eb                         ; $d9f0: e3 e3 e7 eb   Data
            .hex 24 e6 e3 e7                         ; $d9f4: 24 e6 e3 e7   Data
            .hex 21 4c 12 e0                         ; $d9f8: 21 4c 12 e0   Data
            .hex e1 e1 e2 e0                         ; $d9fc: e1 e1 e2 e0   Data
            .hex e2 e0 e1 e1                         ; $da00: e2 e0 e1 e1   Data
            .hex e2 e8 24 e0                         ; $da04: e2 e8 24 e0   Data
            .hex e2 e0 e1 e1                         ; $da08: e2 e0 e1 e1   Data
            .hex e2 21 6c 12                         ; $da0c: e2 21 6c 12   Data
            .hex e3 e3 e3 e7                         ; $da10: e3 e3 e3 e7   Data
            .hex e3 e5 e3 f5                         ; $da14: e3 e5 e3 f5   Data
            .hex f6 e7 e3 f3                         ; $da18: f6 e7 e3 f3   Data
            .hex e3 e5 e6 e3                         ; $da1c: e3 e5 e6 e3   Data
            .hex e3 e7 21 8c                         ; $da20: e3 e7 21 8c   Data
            .hex 12 e3 e3 ef                         ; $da24: 12 e3 e3 ef   Data
            .hex 24 e3 e5 e3                         ; $da28: 24 e3 e5 e3   Data
            .hex 24 24 24 e3                         ; $da2c: 24 24 24 e3   Data
            .hex e3 e3 e5 24                         ; $da30: e3 e3 e5 24   Data
            .hex e3 e5 24 21                         ; $da34: e3 e5 24 21   Data
            .hex ac 12 e3 e3                         ; $da38: ac 12 e3 e3   Data
            .hex e1 ea e3 e5                         ; $da3c: e1 ea e3 e5   Data
            .hex e3 e9 e3 e2                         ; $da40: e3 e9 e3 e2   Data
            .hex e3 e3 e3 e5                         ; $da44: e3 e3 e3 e5   Data
            .hex 24 e3 e5 24                         ; $da48: 24 e3 e5 24   Data
            .hex 21 cc 12 e3                         ; $da4c: 21 cc 12 e3   Data
            .hex e3 ef 24 e3                         ; $da50: e3 ef 24 e3   Data
            .hex e5 e3 f3 e3                         ; $da54: e5 e3 f3 e3   Data
            .hex e5 e3 f2 e3                         ; $da58: e5 e3 f2 e3   Data
            .hex e5 24 e3 e5                         ; $da5c: e5 24 e3 e5   Data
            .hex 24 21 ec 12                         ; $da60: 24 21 ec 12   Data
            .hex e6 e7 24 24                         ; $da64: e6 e7 24 24   Data
            .hex e6 e7 e6 e7                         ; $da68: e6 e7 e6 e7   Data
            .hex e6 e7 eb 24                         ; $da6c: e6 e7 eb 24   Data
            .hex e6 e7 24 e6                         ; $da70: e6 e7 24 e6   Data
            .hex e7 24 22 48                         ; $da74: e7 24 22 48   Data
            .hex 10 0a 24 24                         ; $da78: 10 0a 24 24   Data
            .hex 01 25 19 15                         ; $da7c: 01 25 19 15   Data
            .hex 0a 22 0e 1b                         ; $da80: 0a 22 0e 1b   Data
            .hex 24 10 0a 16                         ; $da84: 24 10 0a 16   Data
            .hex 0e 22 88 10                         ; $da88: 0e 22 88 10   Data
            .hex 0b 24 24 02                         ; $da8c: 0b 24 24 02   Data
            .hex 25 19 15 0a                         ; $da90: 25 19 15 0a   Data
            .hex 22 0e 1b 24                         ; $da94: 22 0e 1b 24   Data
            .hex 10 0a 16 0e                         ; $da98: 10 0a 16 0e   Data
            .hex 22 c8 10 0c                         ; $da9c: 22 c8 10 0c   Data
            .hex 24 24 0b 0a                         ; $daa0: 24 24 0b 0a   Data
            .hex 15 15 18 18                         ; $daa4: 15 15 18 18   Data
            .hex 17 24 24 1d                         ; $daa8: 17 24 24 1d   Data
            .hex 1b 12 19 23                         ; $daac: 1b 12 19 23   Data
            .hex 49 0e f4 01                         ; $dab0: 49 0e f4 01   Data
            .hex 09 08 04 24                         ; $dab4: 09 08 04 24   Data
            .hex 17 12 17 1d                         ; $dab8: 17 12 17 1d   Data
            .hex 0e 17 0d 18                         ; $dabc: 0e 17 0d 18   Data
            .hex 00                                  ; $dac0: 00            Data

;-------------------------------------------------------------------------------
__dac1:     jsr __c104                               ; $dac1: 20 04 c1  
            jsr __d90f                               ; $dac4: 20 0f d9  
            lda #$00                                 ; $dac7: a9 00     
            sta GameTimer                            ; $dac9: 85 19     
__dacb:     jsr __f465                               ; $dacb: 20 65 f4  
            lda GameTimer                            ; $dace: a5 19     
            beq __daf1                               ; $dad0: f0 1f     
            jsr __db08                               ; $dad2: 20 08 db  
            jsr __e768                               ; $dad5: 20 68 e7  
            tax                                      ; $dad8: aa        
            and #$10                                 ; $dad9: 29 10     
            bne __daf0                               ; $dadb: d0 13     
            txa                                      ; $dadd: 8a        
            and #$20                                 ; $dade: 29 20     
            beq __daed                               ; $dae0: f0 0b     
            lda #$00                                 ; $dae2: a9 00     
            sta GameTimer                            ; $dae4: 85 19     
            ldx GameMode                             ; $dae6: a6 3f     
            lda __db05,x                             ; $dae8: bd 05 db  
            sta GameMode                             ; $daeb: 85 3f     
__daed:     jmp __dacb                               ; $daed: 4c cb da  

;-------------------------------------------------------------------------------
__daf0:     rts                                      ; $daf0: 60        

;-------------------------------------------------------------------------------
__daf1:     inc $3a                                  ; $daf1: e6 3a     
            inc NumberOfPlayers                      ; $daf3: e6 40     
            lda #$00                                 ; $daf5: a9 00     
            sta $4015                                ; $daf7: 8d 15 40  
            sta $16                                  ; $dafa: 85 16     
            jsr __f1f2                               ; $dafc: 20 f2 f1  
            lda #$00                                 ; $daff: a9 00     
            sta $3a                                  ; $db01: 85 3a     
            beq __dac1                               ; $db03: f0 bc     

;-------------------------------------------------------------------------------
__db05:     .hex 01 02 00                            ; $db05: 01 02 00      Data
__db08:     lda GameMode                             ; $db08: a5 3f     
            lsr                                      ; $db0a: 4a        
            sta $16                                  ; $db0b: 85 16     
            lda GameMode                             ; $db0d: a5 3f     
            tax                                      ; $db0f: aa        
            and #$01                                 ; $db10: 29 01     
            sta NumberOfPlayers                      ; $db12: 85 40     
            lda TitleScreenCursorOptionY,x           ; $db14: bd 27 db  
            sta $057b                                ; $db17: 8d 7b 05  
            lda #$2c                                 ; $db1a: a9 2c     
            sta $0567                                ; $db1c: 8d 67 05  
            ldx #$00                                 ; $db1f: a2 00     
            stx $055d                                ; $db21: 8e 5d 05  
            jmp __ce2f                               ; $db24: 4c 2f ce  

;-------------------------------------------------------------------------------
TitleScreenCursorOptionY:
            .hex 8c 9c ac                            ; $db27: 8c 9c ac      Data

LevelHeaderPointersLo:
            .hex 4a 59 f2 6c                         ; $db2a: 4a 59 f2 6c   Data
            .hex 77 88 e1 6c                         ; $db2e: 77 88 e1 6c   Data
            .hex 99 03 ca 6c                         ; $db32: 99 03 ca 6c   Data
            .hex ad 17 e1 6c                         ; $db36: ad 17 e1 6c   Data

LevelHeaderPointerHigh:
            .hex db db db db                         ; $db3a: db db db db   Data
            .hex db db db db                         ; $db3e: db db db db   Data
            .hex db dc db db                         ; $db42: db dc db db   Data
            .hex db dc db db                         ; $db46: db dc db db   Data
            .hex 2b dc 39 dd                         ; $db4a: 2b dc 39 dd   Data
            .hex 00 00 10 06                         ; $db4e: 00 00 10 06   Data
            .hex ff ff 96 df                         ; $db52: ff ff 96 df   Data
            .hex 02 7a de 2b                         ; $db56: 02 7a de 2b   Data
            .hex dc 39 dd 4b                         ; $db5a: dc 39 dd 4b   Data
            .hex dd 00 00 18                         ; $db5e: dd 00 00 18   Data
            .hex 0c 04 0e ff                         ; $db62: 0c 04 0e ff   Data
            .hex ff a0 df 04                         ; $db66: ff a0 df 04   Data
            .hex 86 de ca dc                         ; $db6a: 86 de ca dc   Data
            .hex 00 00 ff ff                         ; $db6e: 00 00 ff ff   Data
            .hex b0 df 00 9a                         ; $db72: b0 df 00 9a   Data
            .hex de 2b dc 5e                         ; $db76: de 2b dc 5e   Data
            .hex dd 00 00 08                         ; $db7a: dd 00 00 08   Data
            .hex 06 18 0a ff                         ; $db7e: 06 18 0a ff   Data
            .hex ff b1 df 06                         ; $db82: ff b1 df 06   Data
            .hex 9e de 2b dc                         ; $db86: 9e de 2b dc   Data
            .hex 7d dd 00 00                         ; $db8a: 7d dd 00 00   Data
            .hex 04 06 12 08                         ; $db8e: 04 06 12 08   Data
            .hex ff ff c1 df                         ; $db92: ff ff c1 df   Data
            .hex 07 ba de 2b                         ; $db96: 07 ba de 2b   Data
            .hex dc a3 dd 00                         ; $db9a: dc a3 dd 00   Data
            .hex 00 06 06 14                         ; $db9e: 00 06 06 14   Data
            .hex 10 ff 0f 0d                         ; $dba2: 10 ff 0f 0d   Data
            .hex 01 ff d4 df                         ; $dba6: 01 ff d4 df   Data
            .hex 09 da de 2b                         ; $dbaa: 09 da de 2b   Data
            .hex dc ce dd 00                         ; $dbae: dc ce dd 00   Data
            .hex 00 04 06 10                         ; $dbb2: 00 04 06 10   Data
            .hex 0e ff 08 0e                         ; $dbb6: 0e ff 08 0e   Data
            .hex 03 0d 09 03                         ; $dbba: 03 0d 09 03   Data
            .hex 12 08 03 17                         ; $dbbe: 12 08 03 17   Data
            .hex 0d 03 ff e7                         ; $dbc2: 0d 03 ff e7   Data
            .hex df 03 02 df                         ; $dbc6: df 03 02 df   Data
            .hex 2b dc 5e dd                         ; $dbca: 2b dc 5e dd   Data
            .hex 00 00 10 06                         ; $dbce: 00 00 10 06   Data
            .hex 1a 0c ff 08                         ; $dbd2: 1a 0c ff 08   Data
            .hex 08 01 18 04                         ; $dbd6: 08 01 18 04   Data
            .hex 01 ff b1 df                         ; $dbda: 01 ff b1 df   Data
            .hex 06 9e de 2b                         ; $dbde: 06 9e de 2b   Data
            .hex dc db dd 00                         ; $dbe2: dc db dd 00   Data
            .hex 00 0e 06 0c                         ; $dbe6: 00 0e 06 0c   Data
            .hex 14 ff ff f7                         ; $dbea: 14 ff ff f7   Data
            .hex df 06 12 df                         ; $dbee: df 06 12 df   Data
            .hex 2b dc 01 de                         ; $dbf2: 2b dc 01 de   Data
            .hex 00 00 04 08                         ; $dbf6: 00 00 04 08   Data
            .hex 16 10 ff ff                         ; $dbfa: 16 10 ff ff   Data
            .hex 07 e0 09 2e                         ; $dbfe: 07 e0 09 2e   Data
            .hex df 2b dc 32                         ; $dc02: df 2b dc 32   Data
            .hex de 00 00 04                         ; $dc06: de 00 00 04   Data
            .hex 10 18 10 ff                         ; $dc0a: 10 18 10 ff   Data
            .hex 0e 06 01 ff                         ; $dc0e: 0e 06 01 ff   Data
            .hex 17 e0 07 56                         ; $dc12: 17 e0 07 56   Data
            .hex df 2b dc 5b                         ; $dc16: df 2b dc 5b   Data
            .hex de 00 00 04                         ; $dc1a: de 00 00 04   Data
            .hex 08 0e 10 ff                         ; $dc1e: 08 0e 10 ff   Data
            .hex 10 07 01 ff                         ; $dc22: 10 07 01 ff   Data
            .hex 2a e0 07 76                         ; $dc26: 2a e0 07 76   Data
            .hex df 23 40 88                         ; $dc2a: df 23 40 88   Data
            .hex 39 38 39 38                         ; $dc2e: 39 38 39 38   Data
            .hex 39 38 39 33                         ; $dc32: 39 38 39 33   Data
            .hex 24 24 24 24                         ; $dc36: 24 24 24 24   Data
            .hex 24 24 24 24                         ; $dc3a: 24 24 24 24   Data
            .hex 24 24 24 24                         ; $dc3e: 24 24 24 24   Data
            .hex 24 24 24 24                         ; $dc42: 24 24 24 24   Data
            .hex 30 38 39 38                         ; $dc46: 30 38 39 38   Data
            .hex 39 38 39 38                         ; $dc4a: 39 38 39 38   Data
            .hex 3c 3b 3c 3b                         ; $dc4e: 3c 3b 3c 3b   Data
            .hex 3c 3b 3c 3d                         ; $dc52: 3c 3b 3c 3d   Data
            .hex 58 59 5a 5b                         ; $dc56: 58 59 5a 5b   Data
            .hex 58 59 5a 5b                         ; $dc5a: 58 59 5a 5b   Data
            .hex 58 59 5a 5b                         ; $dc5e: 58 59 5a 5b   Data
            .hex 58 59 5a 5b                         ; $dc62: 58 59 5a 5b   Data
            .hex 3a 3b 3c 3b                         ; $dc66: 3a 3b 3c 3b   Data
            .hex 3c 3b 3c 3b                         ; $dc6a: 3c 3b 3c 3b   Data
            .hex 60 61 62 63                         ; $dc6e: 60 61 62 63   Data
            .hex 60 61 62 63                         ; $dc72: 60 61 62 63   Data
            .hex 5c 5d 5e 5f                         ; $dc76: 5c 5d 5e 5f   Data
            .hex 5c 5d 5e 5f                         ; $dc7a: 5c 5d 5e 5f   Data
            .hex 5c 5d 5e 5f                         ; $dc7e: 5c 5d 5e 5f   Data
            .hex 5c 5d 5e 5f                         ; $dc82: 5c 5d 5e 5f   Data
            .hex 60 61 62 63                         ; $dc86: 60 61 62 63   Data
            .hex 60 61 62 63                         ; $dc8a: 60 61 62 63   Data
            .hex 5c 5d 5e 5f                         ; $dc8e: 5c 5d 5e 5f   Data
            .hex 5c 5d 5e 5f                         ; $dc92: 5c 5d 5e 5f   Data
            .hex 5c 5d 5e 5f                         ; $dc96: 5c 5d 5e 5f   Data
            .hex 5c 5d 5e 5f                         ; $dc9a: 5c 5d 5e 5f   Data
            .hex 5c 5d 5e 5f                         ; $dc9e: 5c 5d 5e 5f   Data
            .hex 5c 5d 5e 5f                         ; $dca2: 5c 5d 5e 5f   Data
            .hex 5c 5d 5e 5f                         ; $dca6: 5c 5d 5e 5f   Data
            .hex 5c 5d 5e 5f                         ; $dcaa: 5c 5d 5e 5f   Data
__dcae:     .hex 40 50 50 50                         ; $dcae: 40 50 50 50   Data
            .hex 50 90 a0 a0                         ; $dcb2: 50 90 a0 a0   Data
            .hex 23 f0 10 00                         ; $dcb6: 23 f0 10 00   Data
            .hex 00 a0 a0 a0                         ; $dcba: 00 a0 a0 a0   Data
            .hex a0 00 00 0a                         ; $dcbe: a0 00 00 0a   Data
            .hex 0a 0a 0a 0a                         ; $dcc2: 0a 0a 0a 0a   Data
            .hex 0a 0a 0a 00                         ; $dcc6: 0a 0a 0a 00   Data
            .hex a3 04 04 93                         ; $dcca: a3 04 04 93   Data
            .hex 94 94 94 a3                         ; $dcce: 94 94 94 a3   Data
            .hex 05 04 95 96                         ; $dcd2: 05 04 95 96   Data
            .hex 96 96 a2 ea                         ; $dcd6: 96 96 a2 ea   Data
            .hex 05 93 94 94                         ; $dcda: 05 93 94 94   Data
            .hex 94 94 a2 eb                         ; $dcde: 94 94 a2 eb   Data
            .hex 05 95 96 96                         ; $dce2: 05 95 96 96   Data
            .hex 96 96 a3 34                         ; $dce6: 96 96 a3 34   Data
            .hex 03 93 94 94                         ; $dcea: 03 93 94 94   Data
            .hex a3 35 03 95                         ; $dcee: a3 35 03 95   Data
            .hex 96 96 a3 1a                         ; $dcf2: 96 96 a3 1a   Data
            .hex 04 93 94 94                         ; $dcf6: 04 93 94 94   Data
            .hex 94 a3 1b 04                         ; $dcfa: 94 a3 1b 04   Data
            .hex 95 96 96 96                         ; $dcfe: 95 96 96 96   Data
            .hex 63 80 20 97                         ; $dd02: 63 80 20 97   Data
            .hex 23 a0 20 98                         ; $dd06: 23 a0 20 98   Data
            .hex 99 98 99 98                         ; $dd0a: 99 98 99 98   Data
            .hex 99 98 99 98                         ; $dd0e: 99 98 99 98   Data
            .hex 99 98 99 98                         ; $dd12: 99 98 99 98   Data
            .hex 99 98 99 98                         ; $dd16: 99 98 99 98   Data
            .hex 99 98 99 98                         ; $dd1a: 99 98 99 98   Data
            .hex 99 98 99 98                         ; $dd1e: 99 98 99 98   Data
            .hex 99 98 99 98                         ; $dd22: 99 98 99 98   Data
            .hex 99 98 99 23                         ; $dd26: 99 98 99 23   Data
            .hex c0 08 40 50                         ; $dd2a: c0 08 40 50   Data
            .hex 50 50 50 90                         ; $dd2e: 50 50 50 90   Data
            .hex a0 a0 63 e8                         ; $dd32: a0 a0 63 e8   Data
            .hex 10 ff 00 22                         ; $dd36: 10 ff 00 22   Data
            .hex 49 0e 30 31                         ; $dd3a: 49 0e 30 31   Data
            .hex 32 31 32 31                         ; $dd3e: 32 31 32 31   Data
            .hex 32 31 32 31                         ; $dd42: 32 31 32 31   Data
            .hex 32 31 32 33                         ; $dd46: 32 31 32 33   Data
            .hex 00 21 57 06                         ; $dd4a: 00 21 57 06   Data
            .hex 30 31 32 31                         ; $dd4e: 30 31 32 31   Data
            .hex 32 33 21 65                         ; $dd52: 32 33 21 65   Data
            .hex 06 30 31 32                         ; $dd56: 06 30 31 32   Data
            .hex 31 32 33 00                         ; $dd5a: 31 32 33 00   Data
            .hex 21 90 03 30                         ; $dd5e: 21 90 03 30   Data
            .hex 31 33 22 26                         ; $dd62: 31 33 22 26   Data
            .hex 03 30 31 33                         ; $dd66: 03 30 31 33   Data
            .hex 22 57 03 30                         ; $dd6a: 22 57 03 30   Data
            .hex 31 33 22 6c                         ; $dd6e: 31 33 22 6c   Data
            .hex 03 30 31 33                         ; $dd72: 03 30 31 33   Data
            .hex 22 f2 03 30                         ; $dd76: 22 f2 03 30   Data
            .hex 31 33 00 20                         ; $dd7a: 31 33 00 20   Data
            .hex cb 03 30 31                         ; $dd7e: cb 03 30 31   Data
            .hex 33 a1 6d 03                         ; $dd82: 33 a1 6d 03   Data
            .hex 3e 3f 40 a1                         ; $dd86: 3e 3f 40 a1   Data
            .hex 59 04 3e 3f                         ; $dd8a: 59 04 3e 3f   Data
            .hex 3f 40 a1 a5                         ; $dd8e: 3f 40 a1 a5   Data
            .hex 03 3e 3f 40                         ; $dd92: 03 3e 3f 40   Data
            .hex 22 aa 03 30                         ; $dd96: 22 aa 03 30   Data
            .hex 31 33 22 b3                         ; $dd9a: 31 33 22 b3   Data
            .hex 03 30 31 33                         ; $dd9e: 03 30 31 33   Data
            .hex 00 20 e2 02                         ; $dda2: 00 20 e2 02   Data
            .hex 30 33 20 fb                         ; $dda6: 30 33 20 fb   Data
            .hex 02 30 33 21                         ; $ddaa: 02 30 33 21   Data
            .hex 57 02 30 33                         ; $ddae: 57 02 30 33   Data
            .hex 21 93 02 30                         ; $ddb2: 21 93 02 30   Data
            .hex 33 22 0b 02                         ; $ddb6: 33 22 0b 02   Data
            .hex 30 33 22 47                         ; $ddba: 30 33 22 47   Data
            .hex 02 30 33 22                         ; $ddbe: 02 30 33 22   Data
            .hex 83 02 30 33                         ; $ddc2: 83 02 30 33   Data
            .hex 22 cf 04 30                         ; $ddc6: 22 cf 04 30   Data
            .hex 31 32 33 00                         ; $ddca: 31 32 33 00   Data
            .hex 22 ca 03 30                         ; $ddce: 22 ca 03 30   Data
            .hex 31 33 22 d2                         ; $ddd2: 31 33 22 d2   Data
            .hex 03 30 31 33                         ; $ddd6: 03 30 31 33   Data
            .hex 00 21 08 04                         ; $ddda: 00 21 08 04   Data
            .hex 30 31 32 33                         ; $ddde: 30 31 32 33   Data
            .hex 21 14 04 30                         ; $dde2: 21 14 04 30   Data
            .hex 31 32 33 a1                         ; $dde6: 31 32 33 a1   Data
            .hex a5 04 3e 3f                         ; $ddea: a5 04 3e 3f   Data
            .hex 3f 40 a1 ba                         ; $ddee: 3f 40 a1 ba   Data
            .hex 04 3e 3f 3f                         ; $ddf2: 04 3e 3f 3f   Data
            .hex 40 22 6c 06                         ; $ddf6: 40 22 6c 06   Data
            .hex 30 31 32 31                         ; $ddfa: 30 31 32 31   Data
            .hex 32 33 00 22                         ; $ddfe: 32 33 00 22   Data
            .hex ee 04 30 31                         ; $de02: ee 04 30 31   Data
            .hex 32 33 20 f9                         ; $de06: 32 33 20 f9   Data
            .hex 03 30 31 33                         ; $de0a: 03 30 31 33   Data
            .hex a1 1a 03 3f                         ; $de0e: a1 1a 03 3f   Data
            .hex 3f 40 21 90                         ; $de12: 3f 40 21 90   Data
            .hex 03 30 31 33                         ; $de16: 03 30 31 33   Data
            .hex a1 b1 03 3f                         ; $de1a: a1 b1 03 3f   Data
            .hex 3f 40 22 28                         ; $de1e: 3f 40 22 28   Data
            .hex 03 30 31 33                         ; $de22: 03 30 31 33   Data
            .hex a2 49 03 3f                         ; $de26: a2 49 03 3f   Data
            .hex 3f 40 20 ea                         ; $de2a: 3f 40 20 ea   Data
            .hex 02 30 33 00                         ; $de2e: 02 30 33 00   Data
            .hex a2 6c 03 3e                         ; $de32: a2 6c 03 3e   Data
            .hex 3f 40 a2 73                         ; $de36: 3f 40 a2 73   Data
            .hex 03 3e 3f 40                         ; $de3a: 03 3e 3f 40   Data
            .hex 20 e4 04 30                         ; $de3e: 20 e4 04 30   Data
            .hex 31 32 33 20                         ; $de42: 31 32 33 20   Data
            .hex f8 04 30 31                         ; $de46: f8 04 30 31   Data
            .hex 32 33 21 a8                         ; $de4a: 32 33 21 a8   Data
            .hex 04 30 31 32                         ; $de4e: 04 30 31 32   Data
            .hex 33 21 b5 04                         ; $de52: 33 21 b5 04   Data
            .hex 30 31 32 33                         ; $de56: 30 31 32 33   Data
            .hex 00 22 64 02                         ; $de5a: 00 22 64 02   Data
            .hex 30 33 22 08                         ; $de5e: 30 33 22 08   Data
            .hex 02 30 33 21                         ; $de62: 02 30 33 21   Data
            .hex ac 02 30 33                         ; $de66: ac 02 30 33   Data
            .hex 21 b4 02 30                         ; $de6a: 21 b4 02 30   Data
            .hex 33 22 18 02                         ; $de6e: 33 22 18 02   Data
            .hex 30 33 22 7c                         ; $de72: 30 33 22 7c   Data
            .hex 02 30 33 00                         ; $de76: 02 30 33 00   Data
            .hex 10 c8 48 38                         ; $de7a: 10 c8 48 38   Data
            .hex ff b8 cf cf                         ; $de7e: ff b8 cf cf   Data
            .hex 8f e0 e0 98                         ; $de82: 8f e0 e0 98   Data
            .hex 10 c4 48 b8                         ; $de86: 10 c4 48 b8   Data
            .hex 28 3c ff b8                         ; $de8a: 28 3c ff b8   Data
            .hex e8 58 cf cf                         ; $de8e: e8 58 cf cf   Data
            .hex 8f 4f 57 e0                         ; $de92: 8f 4f 57 e0   Data
            .hex e0 98 58 60                         ; $de96: e0 98 58 60   Data
            .hex 10 ff df ec                         ; $de9a: 10 ff df ec   Data
            .hex 10 c8 80 30                         ; $de9e: 10 c8 80 30   Data
            .hex b8 60 90 38                         ; $dea2: b8 60 90 38   Data
            .hex ff 98 48 d0                         ; $dea6: ff 98 48 d0   Data
            .hex 78 a8 cf cf                         ; $deaa: 78 a8 cf cf   Data
            .hex 5f 87 8f 97                         ; $deae: 5f 87 8f 97   Data
            .hex b7 e0 e0 68                         ; $deb2: b7 e0 e0 68   Data
            .hex 90 98 a0 c0                         ; $deb6: 90 98 a0 c0   Data
            .hex 10 c8 58 68                         ; $deba: 10 c8 58 68   Data
            .hex c8 28 50 98                         ; $debe: c8 28 50 98   Data
            .hex 38 ff 70 78                         ; $dec2: 38 ff 70 78   Data
            .hex d0 30 68 b0                         ; $dec6: d0 30 68 b0   Data
            .hex cf cf 2f 57                         ; $deca: cf cf 2f 57   Data
            .hex 4f 67 a7 a7                         ; $dece: 4f 67 a7 a7   Data
            .hex e0 e0 38 6c                         ; $ded2: e0 e0 38 6c   Data
            .hex 6c 7c b0 b0                         ; $ded6: 6c 7c b0 b0   Data
            .hex 10 c8 12 da                         ; $deda: 10 c8 12 da   Data
            .hex ba 9a 5a 3a                         ; $dede: ba 9a 5a 3a   Data
            .hex 1a 7a 38 ff                         ; $dee2: 1a 7a 38 ff   Data
            .hex 1e e6 c6 a6                         ; $dee6: 1e e6 c6 a6   Data
            .hex 66 46 26 96                         ; $deea: 66 46 26 96   Data
            .hex cf cf 37 37                         ; $deee: cf cf 37 37   Data
            .hex 4f 5f 7f 8f                         ; $def2: 4f 5f 7f 8f   Data
            .hex 9f af e0 e0                         ; $def6: 9f af e0 e0   Data
            .hex 40 40 58 68                         ; $defa: 40 40 58 68   Data
            .hex 88 98 a8 b8                         ; $defe: 88 98 a8 b8   Data
            .hex 10 c8 52 92                         ; $df02: 10 c8 52 92   Data
            .hex 38 ff 66 a6                         ; $df06: 38 ff 66 a6   Data
            .hex cf cf af af                         ; $df0a: cf cf af af   Data
            .hex e0 e0 b8 b8                         ; $df0e: e0 e0 b8 b8   Data
            .hex 10 c8 40 a0                         ; $df12: 10 c8 40 a0   Data
            .hex 28 d0 60 38                         ; $df16: 28 d0 60 38   Data
            .hex ff 60 c0 30                         ; $df1a: ff 60 c0 30   Data
            .hex d8 90 cf cf                         ; $df1e: d8 90 cf cf   Data
            .hex 3f 3f 67 67                         ; $df22: 3f 3f 67 67   Data
            .hex 97 e0 e0 48                         ; $df26: 97 e0 e0 48   Data
            .hex 48 88 88 a0                         ; $df2a: 48 88 88 a0   Data
            .hex 10 c8 50 c8                         ; $df2e: 10 c8 50 c8   Data
            .hex 88 40 70 d0                         ; $df32: 88 40 70 d0   Data
            .hex 88 48 38 ff                         ; $df36: 88 48 38 ff   Data
            .hex 60 e0 98 58                         ; $df3a: 60 e0 98 58   Data
            .hex 90 d8 90 50                         ; $df3e: 90 d8 90 50   Data
            .hex cf cf 37 37                         ; $df42: cf cf 37 37   Data
            .hex 5f 87 b7 3c                         ; $df46: 5f 87 b7 3c   Data
            .hex 64 8c e0 e0                         ; $df4a: 64 8c e0 e0   Data
            .hex 40 40 68 90                         ; $df4e: 40 40 68 90   Data
            .hex c0 60 80 a8                         ; $df52: c0 60 80 a8   Data
            .hex 10 c8 20 c0                         ; $df56: 10 c8 20 c0   Data
            .hex 40 a8 60 98                         ; $df5a: 40 a8 60 98   Data
            .hex 38 ff 40 e0                         ; $df5e: 38 ff 40 e0   Data
            .hex 60 c8 68 a0                         ; $df62: 60 c8 68 a0   Data
            .hex cf cf 37 37                         ; $df66: cf cf 37 37   Data
            .hex 67 67 97 97                         ; $df6a: 67 67 97 97   Data
            .hex e0 e0 40 40                         ; $df6e: e0 e0 40 40   Data
            .hex 70 70 b0 b0                         ; $df72: 70 70 b0 b0   Data
            .hex 10 c8 20 40                         ; $df76: 10 c8 20 40   Data
            .hex 60 a0 c0 e0                         ; $df7a: 60 a0 c0 e0   Data
            .hex 38 ff 30 50                         ; $df7e: 38 ff 30 50   Data
            .hex 70 b0 d0 f0                         ; $df82: 70 b0 d0 f0   Data
            .hex cf cf 97 7f                         ; $df86: cf cf 97 7f   Data
            .hex 67 67 7f 97                         ; $df8a: 67 67 7f 97   Data
            .hex e0 e0 a0 88                         ; $df8e: e0 e0 a0 88   Data
            .hex 70 70 88 a0                         ; $df92: 70 70 88 a0   Data
            .hex 03 58 78 04                         ; $df96: 03 58 78 04   Data
            .hex 78 78 04 98                         ; $df9a: 78 78 04 98   Data
            .hex 78 04 05 c8                         ; $df9e: 78 04 05 c8   Data
            .hex 38 05 38 40                         ; $dfa2: 38 05 38 40   Data
            .hex 05 58 78 04                         ; $dfa6: 05 58 78 04   Data
            .hex 78 78 04 98                         ; $dfaa: 78 78 04 98   Data
            .hex 78 04 00 05                         ; $dfae: 78 04 00 05   Data
            .hex 94 a0 06 84                         ; $dfb2: 94 a0 06 84   Data
            .hex 48 05 34 70                         ; $dfb6: 48 05 34 70   Data
            .hex 04 64 80 04                         ; $dfba: 04 64 80 04   Data
            .hex bc 78 04 06                         ; $dfbe: bc 78 04 06   Data
            .hex 5c 18 06 24                         ; $dfc2: 5c 18 06 24   Data
            .hex 50 05 64 40                         ; $dfc6: 50 05 64 40   Data
            .hex 05 c4 38 05                         ; $dfca: 05 c4 38 05   Data
            .hex 54 90 04 9c                         ; $dfce: 54 90 04 9c   Data
            .hex 90 04 06 10                         ; $dfd2: 90 04 06 10   Data
            .hex 20 06 d8 20                         ; $dfd6: 20 06 d8 20   Data
            .hex 06 b8 38 05                         ; $dfda: 06 b8 38 05   Data
            .hex 98 48 05 58                         ; $dfde: 98 48 05 58   Data
            .hex 68 05 38 78                         ; $dfe2: 68 05 38 78   Data
            .hex 04 05 54 98                         ; $dfe6: 04 05 54 98   Data
            .hex 05 94 98 05                         ; $dfea: 05 94 98 05   Data
            .hex 6c 39 06 94                         ; $dfee: 6c 39 06 94   Data
            .hex 31 06 bc 59                         ; $dff2: 31 06 bc 59   Data
            .hex 06 05 50 28                         ; $dff6: 06 05 50 28   Data
            .hex 06 a8 28 06                         ; $dffa: 06 a8 28 06   Data
            .hex 24 50 06 cc                         ; $dffe: 24 50 06 cc   Data
            .hex 50 06 70 80                         ; $e002: 50 06 70 80   Data
            .hex 04 05 50 20                         ; $e006: 04 05 50 20   Data
            .hex 06 c8 20 06                         ; $e00a: 06 c8 20 06   Data
            .hex 84 48 05 44                         ; $e00e: 84 48 05 44   Data
            .hex 70 05 78 a0                         ; $e012: 70 05 78 a0   Data
            .hex 04 06 28 20                         ; $e016: 04 06 28 20   Data
            .hex 06 c8 20 06                         ; $e01a: 06 c8 20 06   Data
            .hex 48 50 05 b0                         ; $e01e: 48 50 05 b0   Data
            .hex 50 05 5c 80                         ; $e022: 50 05 5c 80   Data
            .hex 04 94 80 04                         ; $e026: 04 94 80 04   Data
            .hex 06 20 80 04                         ; $e02a: 06 20 80 04   Data
            .hex 40 68 05 60                         ; $e02e: 40 68 05 60   Data
            .hex 50 06 a0 50                         ; $e032: 50 06 a0 50   Data
            .hex 06 c0 68 05                         ; $e036: 06 c0 68 05   Data
            .hex e0 80 04                            ; $e03a: e0 80 04      Data
__e03d:     .hex 08 08 f0 08                         ; $e03d: 08 08 f0 08   Data
            .hex 08 00 00 00                         ; $e041: 08 00 00 00   Data
            .hex 00 08 08 08                         ; $e045: 00 08 08 08   Data
            .hex 00 00 01 08                         ; $e049: 00 00 01 08   Data
            .hex 08 09 00 00                         ; $e04d: 08 09 00 00   Data
            .hex ff 08 08 07                         ; $e051: ff 08 08 07   Data
            .hex fe 00 00 06                         ; $e055: fe 00 00 06   Data
            .hex 08 08 02 00                         ; $e059: 08 08 02 00   Data
            .hex 00 0a 08 08                         ; $e05d: 00 0a 08 08   Data
            .hex 02 00 01 0a                         ; $e061: 02 00 01 0a   Data
            .hex 08 09 04 00                         ; $e065: 08 09 04 00   Data
            .hex 00 0c 08 08                         ; $e069: 00 0c 08 08   Data
            .hex 00 00 fe 08                         ; $e06d: 00 00 fe 08   Data
            .hex 08 06 fd fd                         ; $e071: 08 06 fd fd   Data
            .hex fd 05 05 05                         ; $e075: fd 05 05 05   Data
            .hex 08 08 08 00                         ; $e079: 08 08 08 00   Data
            .hex 00 00 08 08                         ; $e07d: 00 00 08 08   Data
            .hex 07 00 00 ff                         ; $e081: 07 00 00 ff   Data
            .hex 08 08 09 00                         ; $e085: 08 08 09 00   Data
            .hex 00 01 0a 08                         ; $e089: 00 01 0a 08   Data
            .hex 08 02 00 00                         ; $e08d: 08 02 00 00   Data
            .hex 06 08 08 fe                         ; $e091: 06 08 08 fe   Data
            .hex 00 00 06 08                         ; $e095: 00 00 06 08   Data
            .hex 07 fe 00 ff                         ; $e099: 07 fe 00 ff   Data
            .hex 04 08 08 fc                         ; $e09d: 04 08 08 fc   Data
            .hex 00 00 08 08                         ; $e0a1: 00 00 08 08   Data
            .hex 0a 00 00 02                         ; $e0a5: 0a 00 00 02   Data
            .hex 0b 0b 0b 03                         ; $e0a9: 0b 0b 0b 03   Data
            .hex 03 03 00 00                         ; $e0ad: 03 03 00 00   Data
            .hex 01 02 03 04                         ; $e0b1: 01 02 03 04   Data
            .hex 05 00 00 01                         ; $e0b5: 05 00 00 01   Data
            .hex 02 03 06 07                         ; $e0b9: 02 03 06 07   Data
            .hex 00 00 01 02                         ; $e0bd: 00 00 01 02   Data
            .hex 03 06 08 00                         ; $e0c1: 03 06 08 00   Data
            .hex 09 0a 02 0b                         ; $e0c5: 09 0a 02 0b   Data
            .hex 0c 05 00 00                         ; $e0c9: 0c 05 00 00   Data
            .hex 01 02 03 04                         ; $e0cd: 01 02 03 04   Data
            .hex 05 00 00 01                         ; $e0d1: 05 00 00 01   Data
            .hex 02 0d 0e 05                         ; $e0d5: 02 0d 0e 05   Data
            .hex 00 1a 1b 1c                         ; $e0d9: 00 1a 1b 1c   Data
            .hex 1d 1e 1f 01                         ; $e0dd: 1d 1e 1f 01   Data
            .hex 1a 1b 20 1d                         ; $e0e1: 1a 1b 20 1d   Data
            .hex 1e fc 00 1a                         ; $e0e5: 1e fc 00 1a   Data
            .hex 21 22 1d 23                         ; $e0e9: 21 22 1d 23   Data
            .hex 24 00 00 38                         ; $e0ed: 24 00 00 38   Data
            .hex 35 0d 39 37                         ; $e0f1: 35 0d 39 37   Data
            .hex 00 00 34 35                         ; $e0f5: 00 00 34 35   Data
            .hex 03 36 37 00                         ; $e0f9: 03 36 37 00   Data
            .hex 09 3a 35 0b                         ; $e0fd: 09 3a 35 0b   Data
            .hex 3b 37 00 ce                         ; $e101: 3b 37 00 ce   Data
            .hex cf d0 d1 d2                         ; $e105: cf d0 d1 d2   Data
            .hex d3 00 25 26                         ; $e109: d3 00 25 26   Data
            .hex 27 28 29 2a                         ; $e10d: 27 28 29 2a   Data
            .hex 01 28 29 2c                         ; $e111: 01 28 29 2c   Data
            .hex 25 26 2b 00                         ; $e115: 25 26 2b 00   Data
            .hex 4c cc 02 4d                         ; $e119: 4c cc 02 4d   Data
            .hex cd 05 00 4c                         ; $e11d: cd 05 00 4c   Data
            .hex 2f 22 4d 30                         ; $e121: 2f 22 4d 30   Data
            .hex 24 07 4c 2f                         ; $e125: 24 07 4c 2f   Data
            .hex 35 4d 30 37                         ; $e129: 35 4d 30 37   Data
            .hex 02 4c 2f 27                         ; $e12d: 02 4c 2f 27   Data
            .hex 4d 30 2a 07                         ; $e131: 4d 30 2a 07   Data
            .hex 4c 2f 2b 4d                         ; $e135: 4c 2f 2b 4d   Data
            .hex 30 2c 00 0f                         ; $e139: 30 2c 00 0f   Data
            .hex 10 02 11 12                         ; $e13d: 10 02 11 12   Data
            .hex 05 00 0f 10                         ; $e141: 05 00 0f 10   Data
            .hex 02 11 19 07                         ; $e145: 02 11 19 07   Data
            .hex 00 0f 10 02                         ; $e149: 00 0f 10 02   Data
            .hex 11 19 08 00                         ; $e14d: 11 19 08 00   Data
            .hex 13 14 02 15                         ; $e151: 13 14 02 15   Data
            .hex 16 05 00 0f                         ; $e155: 16 05 00 0f   Data
            .hex 10 02 11 12                         ; $e159: 10 02 11 12   Data
            .hex 05 03 13 17                         ; $e15d: 05 03 13 17   Data
            .hex 02 15 18 05                         ; $e161: 02 15 18 05   Data
            .hex 04 13 2d 1c                         ; $e165: 04 13 2d 1c   Data
            .hex 15 2e 1f 05                         ; $e169: 15 2e 1f 05   Data
            .hex 13 2d 20 15                         ; $e16d: 13 2d 20 15   Data
            .hex 2e fc 04 13                         ; $e171: 2e fc 04 13   Data
            .hex 2f 22 15 30                         ; $e175: 2f 22 15 30   Data
            .hex 24 00 13 3c                         ; $e179: 24 00 13 3c   Data
            .hex 35 15 3d 37                         ; $e17d: 35 15 3d 37   Data
            .hex 00 0f 40 35                         ; $e181: 00 0f 40 35   Data
            .hex 11 41 37 03                         ; $e185: 11 41 37 03   Data
            .hex 13 3e 35 15                         ; $e189: 13 3e 35 15   Data
            .hex 3f 37 00 d4                         ; $e18d: 3f 37 00 d4   Data
            .hex d5 d0 d6 d7                         ; $e191: d5 d0 d6 d7   Data
            .hex d3 00 25 31                         ; $e195: d3 00 25 31   Data
            .hex 27 32 33 2a                         ; $e199: 27 32 33 2a   Data
            .hex 02 25 31 27                         ; $e19d: 02 25 31 27   Data
            .hex 32 33 2a 00                         ; $e1a1: 32 33 2a 00   Data
            .hex fc 48 42 fc                         ; $e1a5: fc 48 42 fc   Data
            .hex 49 43 00 fc                         ; $e1a9: 49 43 00 fc   Data
            .hex 48 44 fc 49                         ; $e1ad: 48 44 fc 49   Data
            .hex 45 00 fc 4a                         ; $e1b1: 45 00 fc 4a   Data
            .hex 46 fc 4b 47                         ; $e1b5: 46 fc 4b 47   Data
            .hex 00 fc a4 a5                         ; $e1b9: 00 fc a4 a5   Data
            .hex fc a6 a7 08                         ; $e1bd: fc a6 a7 08   Data
            .hex fc 71 fc fc                         ; $e1c1: fc 71 fc fc   Data
            .hex 72 73 08 fc                         ; $e1c5: 72 73 08 fc   Data
            .hex 74 fc fc 75                         ; $e1c9: 74 fc fc 75   Data
            .hex 76 08 fc 71                         ; $e1cd: 76 08 fc 71   Data
            .hex 77 fc 72 73                         ; $e1d1: 77 fc 72 73   Data
            .hex 08 fc 74 77                         ; $e1d5: 08 fc 74 77   Data
            .hex fc 75 76 08                         ; $e1d9: fc 75 76 08   Data
            .hex fc 71 78 fc                         ; $e1dd: fc 71 78 fc   Data
            .hex 72 73 08 fc                         ; $e1e1: 72 73 08 fc   Data
            .hex 74 78 fc 75                         ; $e1e5: 74 78 fc 75   Data
            .hex 76 08 fc 71                         ; $e1e9: 76 08 fc 71   Data
            .hex 79 fc 72 73                         ; $e1ed: 79 fc 72 73   Data
            .hex 08 fc 74 79                         ; $e1f1: 08 fc 74 79   Data
            .hex fc 75 76 00                         ; $e1f5: fc 75 76 00   Data
            .hex 4e 4f 50 51                         ; $e1f9: 4e 4f 50 51   Data
            .hex 52 53 00 4e                         ; $e1fd: 52 53 00 4e   Data
            .hex 4f 50 51 5e                         ; $e201: 4f 50 51 5e   Data
            .hex 58 00 4e 4f                         ; $e205: 58 00 4e 4f   Data
            .hex 50 51 5e 5d                         ; $e209: 50 51 5e 5d   Data
            .hex 00 54 55 50                         ; $e20d: 00 54 55 50   Data
            .hex 56 57 53 00                         ; $e211: 56 57 53 00   Data
            .hex 4e 4f 50 51                         ; $e215: 4e 4f 50 51   Data
            .hex 52 53 00 59                         ; $e219: 52 53 00 59   Data
            .hex 5a 50 5b 5c                         ; $e21d: 5a 50 5b 5c   Data
            .hex 53 00 fc 5f                         ; $e221: 53 00 fc 5f   Data
            .hex 60 fc 61 62                         ; $e225: 60 fc 61 62   Data
            .hex 06 63 64 60                         ; $e229: 06 63 64 60   Data
            .hex fc 65 62 00                         ; $e22d: fc 65 62 00   Data
            .hex 66 67 60 68                         ; $e231: 66 67 60 68   Data
            .hex 69 62 00 6a                         ; $e235: 69 62 00 6a   Data
            .hex 67 60 6b 69                         ; $e239: 67 60 6b 69   Data
            .hex 62 00 fc 6c                         ; $e23d: 62 00 fc 6c   Data
            .hex 6d fc 6e 6f                         ; $e241: 6d fc 6e 6f   Data
            .hex 00 fc 6c 6d                         ; $e245: 00 fc 6c 6d   Data
            .hex fc 6e 70                            ; $e249: fc 6e 70      Data
__e24c:     .hex af b6 bd b6                         ; $e24c: af b6 bd b6   Data
            .hex c4 cb d2 cb                         ; $e250: c4 cb d2 cb   Data
            .hex d9 e0 e7 e0                         ; $e254: d9 e0 e7 e0   Data
            .hex ee f5 fc f5                         ; $e258: ee f5 fc f5   Data
            .hex 0a 0a 0a 0a                         ; $e25c: 0a 0a 0a 0a   Data
            .hex 11 11 11 11                         ; $e260: 11 11 11 11   Data
            .hex 18 18 18 18                         ; $e264: 18 18 18 18   Data
            .hex 1f 1f 1f 1f                         ; $e268: 1f 1f 1f 1f   Data
            .hex 26 26 26 26                         ; $e26c: 26 26 26 26   Data
            .hex 2d 2d 2d 2d                         ; $e270: 2d 2d 2d 2d   Data
            .hex 34 34 34 34                         ; $e274: 34 34 34 34   Data
            .hex 3b 42 49 42                         ; $e278: 3b 42 49 42   Data
            .hex 50 57 5e 57                         ; $e27c: 50 57 5e 57   Data
            .hex 65 6c 73 6c                         ; $e280: 65 6c 73 6c   Data
            .hex 7a 81 88 81                         ; $e284: 7a 81 88 81   Data
            .hex 96 96 96 96                         ; $e288: 96 96 96 96   Data
            .hex 9d 9d 9d 9d                         ; $e28c: 9d 9d 9d 9d   Data
            .hex a4 ab b2 ab                         ; $e290: a4 ab b2 ab   Data
            .hex b9 a4 b9 a4                         ; $e294: b9 a4 b9 a4   Data
__e298:     .hex e0 e0 e0 e0                         ; $e298: e0 e0 e0 e0   Data
            .hex e0 e0 e0 e0                         ; $e29c: e0 e0 e0 e0   Data
            .hex e0 e0 e0 e0                         ; $e2a0: e0 e0 e0 e0   Data
            .hex e0 e0 e0 e0                         ; $e2a4: e0 e0 e0 e0   Data
            .hex e1 e1 e1 e1                         ; $e2a8: e1 e1 e1 e1   Data
            .hex e1 e1 e1 e1                         ; $e2ac: e1 e1 e1 e1   Data
            .hex e1 e1 e1 e1                         ; $e2b0: e1 e1 e1 e1   Data
            .hex e1 e1 e1 e1                         ; $e2b4: e1 e1 e1 e1   Data
            .hex e1 e1 e1 e1                         ; $e2b8: e1 e1 e1 e1   Data
            .hex e1 e1 e1 e1                         ; $e2bc: e1 e1 e1 e1   Data
            .hex e1 e1 e1 e1                         ; $e2c0: e1 e1 e1 e1   Data
            .hex e1 e1 e1 e1                         ; $e2c4: e1 e1 e1 e1   Data
            .hex e1 e1 e1 e1                         ; $e2c8: e1 e1 e1 e1   Data
            .hex e1 e1 e1 e1                         ; $e2cc: e1 e1 e1 e1   Data
            .hex e1 e1 e1 e1                         ; $e2d0: e1 e1 e1 e1   Data
            .hex e1 e1 e1 e1                         ; $e2d4: e1 e1 e1 e1   Data
            .hex e1 e1 e1 e1                         ; $e2d8: e1 e1 e1 e1   Data
            .hex e1 e1 e1 e1                         ; $e2dc: e1 e1 e1 e1   Data
            .hex e1 e1 e1 e1                         ; $e2e0: e1 e1 e1 e1   Data
__e2e4:     .hex 81 81 8f 81                         ; $e2e4: 81 81 8f 81   Data
            .hex f5 f5 03 f5                         ; $e2e8: f5 f5 03 f5   Data
__e2ec:     .hex e1 e1 e1 e1                         ; $e2ec: e1 e1 e1 e1   Data
            .hex e0 e0 e1 e0                         ; $e2f0: e0 e0 e1 e0   Data
__e2f4:     .hex f8 ff 06 ff                         ; $e2f4: f8 ff 06 ff   Data
            .hex 0d 14 1b 14                         ; $e2f8: 0d 14 1b 14   Data
            .hex 3e 3e 22 29                         ; $e2fc: 3e 3e 22 29   Data
            .hex 30 30 30 30                         ; $e300: 30 30 30 30   Data
            .hex c0 c0 c0 c0                         ; $e304: c0 c0 c0 c0   Data
            .hex c0 c7 c0 c7                         ; $e308: c0 c7 c0 c7   Data
            .hex ce d5 ce d5                         ; $e30c: ce d5 ce d5   Data
            .hex dc e3 dc e3                         ; $e310: dc e3 dc e3   Data
            .hex ea f1 ea f1                         ; $e314: ea f1 ea f1   Data
            .hex 3e 45 3e 45                         ; $e318: 3e 45 3e 45   Data
            .hex 37 37 37 37                         ; $e31c: 37 37 37 37   Data
__e320:     .hex e1 e1 e2 e1                         ; $e320: e1 e1 e2 e1   Data
            .hex e2 e2 e2 e2                         ; $e324: e2 e2 e2 e2   Data
            .hex e2 e2 e2 e2                         ; $e328: e2 e2 e2 e2   Data
            .hex e2 e2 e2 e2                         ; $e32c: e2 e2 e2 e2   Data
            .hex e1 e1 e1 e1                         ; $e330: e1 e1 e1 e1   Data
            .hex e1 e1 e1 e1                         ; $e334: e1 e1 e1 e1   Data
            .hex e1 e1 e1 e1                         ; $e338: e1 e1 e1 e1   Data
            .hex e1 e1 e1 e1                         ; $e33c: e1 e1 e1 e1   Data
            .hex e1 e1 e1 e1                         ; $e340: e1 e1 e1 e1   Data
            .hex e2 e2 e2 e2                         ; $e344: e2 e2 e2 e2   Data
            .hex e2 e2 e2 e2                         ; $e348: e2 e2 e2 e2   Data
__e34c:     .hex 44 2c 00                            ; $e34c: 44 2c 00      Data
__e34f:     .hex 00 00 04                            ; $e34f: 00 00 04      Data
__e352:     .hex 24 08 00 00                         ; $e352: 24 08 00 00   Data
            .hex fc fc fe fc                         ; $e356: fc fc fe fc   Data
            .hex 00 7b fc fc                         ; $e35a: 00 7b fc fc   Data
            .hex 7c fc fc 00                         ; $e35e: 7c fc fc 00   Data
            .hex 7d 7e fc 7f                         ; $e362: 7d 7e fc 7f   Data
            .hex 80 fc 00 81                         ; $e366: 80 fc 00 81   Data
            .hex 82 83 84 85                         ; $e36a: 82 83 84 85   Data
            .hex 86 00 87 88                         ; $e36e: 86 00 87 88   Data
            .hex fc 89 8a fc                         ; $e372: fc 89 8a fc   Data
            .hex 00 8b 8c fc                         ; $e376: 00 8b 8c fc   Data
            .hex 8d 8e fc 00                         ; $e37a: 8d 8e fc 00   Data
            .hex 8f 90 fc fc                         ; $e37e: 8f 90 fc fc   Data
            .hex fc fc                               ; $e382: fc fc         Data
__e384:     .hex 55 5a 61 68                         ; $e384: 55 5a 61 68   Data
            .hex 6f 76 7d                            ; $e388: 6f 76 7d      Data
__e38b:     .hex e3 e3 e3 e3                         ; $e38b: e3 e3 e3 e3   Data
            .hex e3 e3 e3                            ; $e38f: e3 e3 e3      Data
__e392:     .hex 20 38 50 68                         ; $e392: 20 38 50 68   Data
            .hex 80 98 b0 c8                         ; $e396: 80 98 b0 c8   Data
            .hex 08                                  ; $e39a: 08            Data
__e39b:     .hex 20 38 c8 b0                         ; $e39b: 20 38 c8 b0   Data
            .hex 98 80 68 50                         ; $e39f: 98 80 68 50   Data
            .hex 08                                  ; $e3a3: 08            Data

;-------------------------------------------------------------------------------
__e3a4:     lda __e392,x                             ; $e3a4: bd 92 e3  
            sta GfxPointerLow                        ; $e3a7: 85 1f     
            lda GameTimer                            ; $e3a9: a5 19     
            lsr                                      ; $e3ab: 4a        
            bcc __e3b3                               ; $e3ac: 90 05     
            lda __e39b,x                             ; $e3ae: bd 9b e3  
            sta GfxPointerLow                        ; $e3b1: 85 1f     
__e3b3:     lda #$02                                 ; $e3b3: a9 02     
            sta GfxPointerHigh                       ; $e3b5: 85 20     
            lda Player1Ballons,x                     ; $e3b7: b5 88     
            bpl __e3cf                               ; $e3b9: 10 14     
            cmp #$ff                                 ; $e3bb: c9 ff     
            beq __e3c2                               ; $e3bd: f0 03     
            jmp __e4d5                               ; $e3bf: 4c d5 e4  

;-------------------------------------------------------------------------------
__e3c2:     ldy #$14                                 ; $e3c2: a0 14     
__e3c4:     lda #$f0                                 ; $e3c4: a9 f0     
            sta (GfxPointerLow),y                    ; $e3c6: 91 1f     
            dey                                      ; $e3c8: 88        
            dey                                      ; $e3c9: 88        
            dey                                      ; $e3ca: 88        
            dey                                      ; $e3cb: 88        
            bpl __e3c4                               ; $e3cc: 10 f6     
            rts                                      ; $e3ce: 60        

;-------------------------------------------------------------------------------
__e3cf:     cpx #$08                                 ; $e3cf: e0 08     
            beq __e41b                               ; $e3d1: f0 48     
            lda $7f,x                                ; $e3d3: b5 7f     
            asl                                      ; $e3d5: 0a        
            asl                                      ; $e3d6: 0a        
            adc $0436,x                              ; $e3d7: 7d 36 04  
            cpx #$02                                 ; $e3da: e0 02     
            bcs __e408                               ; $e3dc: b0 2a     
            ldy Player1Ballons,x                     ; $e3de: b4 88     
            adc __e34c,y                             ; $e3e0: 79 4c e3  
            tay                                      ; $e3e3: a8        
            lda __e24c,y                             ; $e3e4: b9 4c e2  
            sta LoadPointerLow                       ; $e3e7: 85 1d     
            lda __e298,y                             ; $e3e9: b9 98 e2  
            sta LoadPointerHigh                      ; $e3ec: 85 1e     
            lda Player1Invincible,x                  ; $e3ee: b5 bd     
            beq __e429                               ; $e3f0: f0 37     
            ldy Player1Ballons,x                     ; $e3f2: b4 88     
            lda __e34f,y                             ; $e3f4: b9 4f e3  
            adc $0436,x                              ; $e3f7: 7d 36 04  
            tay                                      ; $e3fa: a8        
            lda __e2e4,y                             ; $e3fb: b9 e4 e2  
            sta LoadPointerLow                       ; $e3fe: 85 1d     
            lda __e2ec,y                             ; $e400: b9 ec e2  
            sta LoadPointerHigh                      ; $e403: 85 1e     
            jmp __e429                               ; $e405: 4c 29 e4  

;-------------------------------------------------------------------------------
__e408:     ldy Player1Ballons,x                     ; $e408: b4 88     
            clc                                      ; $e40a: 18        
            adc __e352,y                             ; $e40b: 79 52 e3  
            tay                                      ; $e40e: a8        
            lda __e2f4,y                             ; $e40f: b9 f4 e2  
            sta LoadPointerLow                       ; $e412: 85 1d     
            lda __e320,y                             ; $e414: b9 20 e3  
            sta LoadPointerHigh                      ; $e417: 85 1e     
            bne __e429                               ; $e419: d0 0e     
__e41b:     ldy $7f,x                                ; $e41b: b4 7f     
            bmi __e3c2                               ; $e41d: 30 a3     
            lda __e384,y                             ; $e41f: b9 84 e3  
            sta LoadPointerLow                       ; $e422: 85 1d     
            lda __e38b,y                             ; $e424: b9 8b e3  
            sta LoadPointerHigh                      ; $e427: 85 1e     
__e429:     lda Player1X,x                           ; $e429: b5 91     
            sta $15                                  ; $e42b: 85 15     
            lda Player1Y,x                           ; $e42d: b5 9a     
            sta BytesLeftToLoad                      ; $e42f: 85 12     
            txa                                      ; $e431: 8a        
            beq __e444                               ; $e432: f0 10     
            cpx #$01                                 ; $e434: e0 01     
            bne __e43c                               ; $e436: d0 04     
            lda #$01                                 ; $e438: a9 01     
            bne __e444                               ; $e43a: d0 08     
__e43c:     lda Player1State,x                       ; $e43c: bd 51 04  
            clc                                      ; $e43f: 18        
            adc #$02                                 ; $e440: 69 02     
            and #$03                                 ; $e442: 29 03     
__e444:     ldy $0448,x                              ; $e444: bc 48 04  
            beq __e44b                               ; $e447: f0 02     
            ora #$40                                 ; $e449: 09 40     
__e44b:     ldy Player1Ballons,x                     ; $e44b: b4 88     
            cpy #$02                                 ; $e44d: c0 02     
            bne __e459                               ; $e44f: d0 08     
            ldy $7f,x                                ; $e451: b4 7f     
            cpy #$05                                 ; $e453: c0 05     
            bne __e459                               ; $e455: d0 02     
            eor #$40                                 ; $e457: 49 40     
__e459:     ldy Player1Y,x                           ; $e459: b4 9a     
            cpy #$c9                                 ; $e45b: c0 c9     
            bcs __e463                               ; $e45d: b0 04     
            cpx #$09                                 ; $e45f: e0 09     
            bne __e465                               ; $e461: d0 02     
__e463:     ora #$20                                 ; $e463: 09 20     
__e465:     sta $14                                  ; $e465: 85 14     
            lda #$43                                 ; $e467: a9 43     
            sta $21                                  ; $e469: 85 21     
            lda #$e0                                 ; $e46b: a9 e0     
            sta $22                                  ; $e46d: 85 22     
            lda $0448,x                              ; $e46f: bd 48 04  
            beq __e47c                               ; $e472: f0 08     
            lda #$79                                 ; $e474: a9 79     
            sta $21                                  ; $e476: 85 21     
            lda #$e0                                 ; $e478: a9 e0     
            sta $22                                  ; $e47a: 85 22     
__e47c:     ldy #$00                                 ; $e47c: a0 00     
            lda (LoadPointerLow),y                   ; $e47e: b1 1d     
            inc LoadPointerLow                       ; $e480: e6 1d     
            bne __e486                               ; $e482: d0 02     
            inc LoadPointerHigh                      ; $e484: e6 1e     
__e486:     asl                                      ; $e486: 0a        
            sta $13                                  ; $e487: 85 13     
            asl                                      ; $e489: 0a        
            adc $13                                  ; $e48a: 65 13     
            adc $21                                  ; $e48c: 65 21     
            sta $21                                  ; $e48e: 85 21     
            bcc __e494                               ; $e490: 90 02     
            inc $22                                  ; $e492: e6 22     
__e494:     txa                                      ; $e494: 8a        
            pha                                      ; $e495: 48        
            ldx #$05                                 ; $e496: a2 05     
            ldy #$00                                 ; $e498: a0 00     
__e49a:     lda BytesLeftToLoad                      ; $e49a: a5 12     
            clc                                      ; $e49c: 18        
            adc __e03d,x                             ; $e49d: 7d 3d e0  
            sta (GfxPointerLow),y                    ; $e4a0: 91 1f     
            sta BytesLeftToLoad                      ; $e4a2: 85 12     
            iny                                      ; $e4a4: c8        
            sty $13                                  ; $e4a5: 84 13     
            ldy #$00                                 ; $e4a7: a0 00     
            lda (LoadPointerLow),y                   ; $e4a9: b1 1d     
            inc LoadPointerLow                       ; $e4ab: e6 1d     
            bne __e4b1                               ; $e4ad: d0 02     
            inc LoadPointerHigh                      ; $e4af: e6 1e     
__e4b1:     ldy $13                                  ; $e4b1: a4 13     
            sta (GfxPointerLow),y                    ; $e4b3: 91 1f     
            iny                                      ; $e4b5: c8        
            lda $14                                  ; $e4b6: a5 14     
            sta (GfxPointerLow),y                    ; $e4b8: 91 1f     
            iny                                      ; $e4ba: c8        
            sty $13                                  ; $e4bb: 84 13     
            ldy #$00                                 ; $e4bd: a0 00     
            lda $15                                  ; $e4bf: a5 15     
            clc                                      ; $e4c1: 18        
            adc ($21),y                              ; $e4c2: 71 21     
            inc $21                                  ; $e4c4: e6 21     
            bne __e4ca                               ; $e4c6: d0 02     
            inc $22                                  ; $e4c8: e6 22     
__e4ca:     ldy $13                                  ; $e4ca: a4 13     
            sta (GfxPointerLow),y                    ; $e4cc: 91 1f     
            iny                                      ; $e4ce: c8        
            dex                                      ; $e4cf: ca        
            bpl __e49a                               ; $e4d0: 10 c8     
            pla                                      ; $e4d2: 68        
            tax                                      ; $e4d3: aa        
            rts                                      ; $e4d4: 60        

;-------------------------------------------------------------------------------
__e4d5:     txa                                      ; $e4d5: 8a        
            pha                                      ; $e4d6: 48        
            ldy GfxPointerLow                        ; $e4d7: a4 1f     
            lda Player1Y,x                           ; $e4d9: b5 9a     
            sta $0200,y                              ; $e4db: 99 00 02  
            sta $0204,y                              ; $e4de: 99 04 02  
            clc                                      ; $e4e1: 18        
            adc #$08                                 ; $e4e2: 69 08     
            sta $0208,y                              ; $e4e4: 99 08 02  
            sta $020c,y                              ; $e4e7: 99 0c 02  
            lda #$f0                                 ; $e4ea: a9 f0     
            sta $0210,y                              ; $e4ec: 99 10 02  
            sta $0214,y                              ; $e4ef: 99 14 02  
            lda Player1X,x                           ; $e4f2: b5 91     
            sta $0203,y                              ; $e4f4: 99 03 02  
            sta $020b,y                              ; $e4f7: 99 0b 02  
            clc                                      ; $e4fa: 18        
            adc #$08                                 ; $e4fb: 69 08     
            sta $0207,y                              ; $e4fd: 99 07 02  
            sta $020f,y                              ; $e500: 99 0f 02  
            lda Player1Y,x                           ; $e503: b5 9a     
            cmp #$d0                                 ; $e505: c9 d0     
            lda #$03                                 ; $e507: a9 03     
            bcc __e50d                               ; $e509: 90 02     
            lda #$23                                 ; $e50b: a9 23     
__e50d:     sta $0202,y                              ; $e50d: 99 02 02  
            lda $7f,x                                ; $e510: b5 7f     
            bne __e553                               ; $e512: d0 3f     
            lda $0202,y                              ; $e514: b9 02 02  
            sta $0206,y                              ; $e517: 99 06 02  
            sta $020a,y                              ; $e51a: 99 0a 02  
            sta $020e,y                              ; $e51d: 99 0e 02  
            lda #$da                                 ; $e520: a9 da     
            sta $0201,y                              ; $e522: 99 01 02  
            lda #$db                                 ; $e525: a9 db     
            sta $0205,y                              ; $e527: 99 05 02  
            lda #$dc                                 ; $e52a: a9 dc     
            sta $0209,y                              ; $e52c: 99 09 02  
            lda #$dd                                 ; $e52f: a9 dd     
            sta $020d,y                              ; $e531: 99 0d 02  
            ldx GfxPointerLow                        ; $e534: a6 1f     
            lda GameTimer                            ; $e536: a5 19     
            and #$20                                 ; $e538: 29 20     
            beq __e550                               ; $e53a: f0 14     
            lda GameTimer                            ; $e53c: a5 19     
            and #$40                                 ; $e53e: 29 40     
            bne __e54a                               ; $e540: d0 08     
            inc $0200,x                              ; $e542: fe 00 02  
            inc $0204,x                              ; $e545: fe 04 02  
            bne __e550                               ; $e548: d0 06     
__e54a:     inc $0203,x                              ; $e54a: fe 03 02  
            inc $020b,x                              ; $e54d: fe 0b 02  
__e550:     pla                                      ; $e550: 68        
            tax                                      ; $e551: aa        
            rts                                      ; $e552: 60        

;-------------------------------------------------------------------------------
__e553:     lda $0202,y                              ; $e553: b9 02 02  
            ora #$40                                 ; $e556: 09 40     
            sta $0206,y                              ; $e558: 99 06 02  
            ora #$80                                 ; $e55b: 09 80     
            sta $020e,y                              ; $e55d: 99 0e 02  
            and #$bf                                 ; $e560: 29 bf     
            sta $020a,y                              ; $e562: 99 0a 02  
            lda #$de                                 ; $e565: a9 de     
            sta $0201,y                              ; $e567: 99 01 02  
            sta $0205,y                              ; $e56a: 99 05 02  
            sta $0209,y                              ; $e56d: 99 09 02  
            sta $020d,y                              ; $e570: 99 0d 02  
            dec $045a,x                              ; $e573: de 5a 04  
            bpl __e584                               ; $e576: 10 0c     
            lda #$ff                                 ; $e578: a9 ff     
            sta Player1Ballons,x                     ; $e57a: 95 88     
            lda #$f0                                 ; $e57c: a9 f0     
            sta Player1Y,x                           ; $e57e: 95 9a     
            lda #$04                                 ; $e580: a9 04     
            sta $f1                                  ; $e582: 85 f1     
__e584:     pla                                      ; $e584: 68        
            tax                                      ; $e585: aa        
            rts                                      ; $e586: 60        

;-------------------------------------------------------------------------------
__e587:     ldx $bb                                  ; $e587: a6 bb     
            bmi __e5c4                               ; $e589: 30 39     
            lda __e5c5,x                             ; $e58b: bd c5 e5  
            sta LoadPointerLow                       ; $e58e: 85 1d     
            lda __e5ca,x                             ; $e590: bd ca e5  
            sta LoadPointerHigh                      ; $e593: 85 1e     
            ldy #$00                                 ; $e595: a0 00     
            ldx #$00                                 ; $e597: a2 00     
__e599:     lda (LoadPointerLow),y                   ; $e599: b1 1d     
            sta $02e0,x                              ; $e59b: 9d e0 02  
            iny                                      ; $e59e: c8        
            inx                                      ; $e59f: e8        
            cmp #$f0                                 ; $e5a0: c9 f0     
            bne __e5a7                               ; $e5a2: d0 03     
            inx                                      ; $e5a4: e8        
            inx                                      ; $e5a5: e8        
            inx                                      ; $e5a6: e8        
__e5a7:     cpx #$10                                 ; $e5a7: e0 10     
            bne __e599                               ; $e5a9: d0 ee     
            ldy #$0f                                 ; $e5ab: a0 0f     
__e5ad:     lda $02e0,y                              ; $e5ad: b9 e0 02  
            clc                                      ; $e5b0: 18        
            adc $bc                                  ; $e5b1: 65 bc     
            sta $02e0,y                              ; $e5b3: 99 e0 02  
            dey                                      ; $e5b6: 88        
            dey                                      ; $e5b7: 88        
            dey                                      ; $e5b8: 88        
            dey                                      ; $e5b9: 88        
            bpl __e5ad                               ; $e5ba: 10 f1     
            lda GameTimer                            ; $e5bc: a5 19     
            and #$03                                 ; $e5be: 29 03     
            bne __e5c4                               ; $e5c0: d0 02     
            dec $bb                                  ; $e5c2: c6 bb     
__e5c4:     rts                                      ; $e5c4: 60        

;-------------------------------------------------------------------------------
__e5c5:     .hex fd ed e0 d6                         ; $e5c5: fd ed e0 d6   Data
            .hex cf                                  ; $e5c9: cf            Data
__e5ca:     .hex e5 e5 e5 e5                         ; $e5ca: e5 e5 e5 e5   Data
            .hex e5 d0 ae 03                         ; $e5ce: e5 d0 ae 03   Data
            .hex 04 f0 f0 f0                         ; $e5d2: 04 f0 f0 f0   Data
            .hex c8 af 03 04                         ; $e5d6: c8 af 03 04   Data
            .hex d0 b0 03 04                         ; $e5da: d0 b0 03 04   Data
            .hex f0 f0 c8 b1                         ; $e5de: f0 f0 c8 b1   Data
            .hex 03 fc c8 b2                         ; $e5e2: 03 fc c8 b2   Data
            .hex 03 04 d0 b3                         ; $e5e6: 03 04 d0 b3   Data
            .hex 03 04 f0 c8                         ; $e5ea: 03 04 f0 c8   Data
            .hex b4 03 00 c8                         ; $e5ee: b4 03 00 c8   Data
            .hex b4 43 08 d0                         ; $e5f2: b4 43 08 d0   Data
            .hex b5 03 00 d0                         ; $e5f6: b5 03 00 d0   Data
            .hex b5 43 08 f0                         ; $e5fa: b5 43 08 f0   Data
            .hex f0 f0 f0                            ; $e5fe: f0 f0 f0      Data
__e601:     .hex 04 04 05 06                         ; $e601: 04 04 05 06   Data
            .hex 03 03 03 06                         ; $e605: 03 03 03 06   Data
            .hex 0a 0a 0a 0a                         ; $e609: 0a 0a 0a 0a   Data
__e60d:     .hex 28 32 46 78                         ; $e60d: 28 32 46 78   Data
            .hex 00 00 00 64                         ; $e611: 00 00 00 64   Data
            .hex 00 00 00 00                         ; $e615: 00 00 00 00   Data
__e619:     .hex 0a 1e 32 70                         ; $e619: 0a 1e 32 70   Data
            .hex 00 00 00 70                         ; $e61d: 00 00 00 70   Data
            .hex 00 00 00 00                         ; $e621: 00 00 00 00   Data
__e625:     .hex 14 3c 64 a0                         ; $e625: 14 3c 64 a0   Data
            .hex 00 00 00 a0                         ; $e629: 00 00 00 a0   Data
            .hex 00 00 00 00                         ; $e62d: 00 00 00 00   Data
__e631:     .hex 70 b0 e0 40                         ; $e631: 70 b0 e0 40   Data
            .hex 80 80 80 40                         ; $e635: 80 80 80 40   Data
            .hex 00 00 00 00                         ; $e639: 00 00 00 00   Data
__e63d:     .hex 00 00 00 01                         ; $e63d: 00 00 00 01   Data
            .hex 00 00 00 01                         ; $e641: 00 00 00 01   Data
            .hex 00 00 00 00                         ; $e645: 00 00 00 00   Data
__e649:     .hex 90 50 20 c0                         ; $e649: 90 50 20 c0   Data
            .hex 80 80 80 c0                         ; $e64d: 80 80 80 c0   Data
            .hex 00 00 00 00                         ; $e651: 00 00 00 00   Data
__e655:     .hex ff ff ff fe                         ; $e655: ff ff ff fe   Data
            .hex ff ff ff fe                         ; $e659: ff ff ff fe   Data
            .hex 00 00 00 00                         ; $e65d: 00 00 00 00   Data
__e661:     .hex 50 90 c0 40                         ; $e661: 50 90 c0 40   Data
            .hex 40 40 40 40                         ; $e665: 40 40 40 40   Data
            .hex 00 00 00 00                         ; $e669: 00 00 00 00   Data
__e66d:     .hex 00 00 00 01                         ; $e66d: 00 00 00 01   Data
            .hex 00 00 00 01                         ; $e671: 00 00 00 01   Data
            .hex 02 02 02 02                         ; $e675: 02 02 02 02   Data
__e679:     .hex b0 70 40 c0                         ; $e679: b0 70 40 c0   Data
            .hex c0 c0 c0 c0                         ; $e67d: c0 c0 c0 c0   Data
            .hex c0 c0 c0 c0                         ; $e681: c0 c0 c0 c0   Data
__e685:     .hex ff ff ff fe                         ; $e685: ff ff ff fe   Data
            .hex ff ff ff fe                         ; $e689: ff ff ff fe   Data
            .hex fe 01 fe fe                         ; $e68d: fe 01 fe fe   Data

;-------------------------------------------------------------------------------
__e691:     jsr __ee25                               ; $e691: 20 25 ee  
            ldx #$07                                 ; $e694: a2 07     
__e696:     lda Player1Ballons,x                     ; $e696: b5 88     
            bpl __e6a4                               ; $e698: 10 0a     
            cmp #$ff                                 ; $e69a: c9 ff     
            beq __e6e2                               ; $e69c: f0 44     
            jsr __ecba                               ; $e69e: 20 ba ec  
            jmp __e6e2                               ; $e6a1: 4c e2 e6  

;-------------------------------------------------------------------------------
__e6a4:     cpx #$02                                 ; $e6a4: e0 02     
            bcc __e6b8                               ; $e6a6: 90 10     
            cmp #$01                                 ; $e6a8: c9 01     
            bne __e6b8                               ; $e6aa: d0 0c     
            lda $7f,x                                ; $e6ac: b5 7f     
            cmp #$02                                 ; $e6ae: c9 02     
            bcs __e6b8                               ; $e6b0: b0 06     
            lda $f1                                  ; $e6b2: a5 f1     
            ora #$20                                 ; $e6b4: 09 20     
            sta $f1                                  ; $e6b6: 85 f1     
__e6b8:     dec $043f,x                              ; $e6b8: de 3f 04  
            bne __e6d9                               ; $e6bb: d0 1c     
            lda #$03                                 ; $e6bd: a9 03     
            sta $043f,x                              ; $e6bf: 9d 3f 04  
            cpx #$02                                 ; $e6c2: e0 02     
            bcs __e6ce                               ; $e6c4: b0 08     
            dec Player1InvincibleFlash,x             ; $e6c6: d6 bf     
            bne __e6ce                               ; $e6c8: d0 04     
            lda #$00                                 ; $e6ca: a9 00     
            sta Player1Invincible,x                  ; $e6cc: 95 bd     
__e6ce:     jsr __ea18                               ; $e6ce: 20 18 ea  
            stx $3e                                  ; $e6d1: 86 3e     
            jsr __ebc4                               ; $e6d3: 20 c4 eb  
            jsr __e796                               ; $e6d6: 20 96 e7  
__e6d9:     jsr __ea58                               ; $e6d9: 20 58 ea  
            jsr __ed28                               ; $e6dc: 20 28 ed  
            jsr __e983                               ; $e6df: 20 83 e9  
__e6e2:     jsr __e3a4                               ; $e6e2: 20 a4 e3  
            dex                                      ; $e6e5: ca        
            bpl __e696                               ; $e6e6: 10 ae     
            rts                                      ; $e6e8: 60        

;-------------------------------------------------------------------------------
__e6e9:     cpx #$02                                 ; $e6e9: e0 02     
            bcs __e705                               ; $e6eb: b0 18     
            lda GameTimer                            ; $e6ed: a5 19     
            and #$0f                                 ; $e6ef: 29 0f     
            bne __e6f8                               ; $e6f1: d0 05     
            jsr __f1b3                               ; $e6f3: 20 b3 f1  
            sta $31,x                                ; $e6f6: 95 31     
__e6f8:     lda $3a                                  ; $e6f8: a5 3a     
            bne __e705                               ; $e6fa: d0 09     
            jsr __e76a                               ; $e6fc: 20 6a e7  
            lda $061c,x                              ; $e6ff: bd 1c 06  
            sta $31,x                                ; $e702: 95 31     
__e704:     rts                                      ; $e704: 60        

;-------------------------------------------------------------------------------
__e705:     lda Player1Y,x                           ; $e705: b5 9a     
            cmp #$a0                                 ; $e707: c9 a0     
            bcc __e712                               ; $e709: 90 07     
            lda $31,x                                ; $e70b: b5 31     
            ora #$40                                 ; $e70d: 09 40     
            sta $31,x                                ; $e70f: 95 31     
            rts                                      ; $e711: 60        

;-------------------------------------------------------------------------------
__e712:     dec $045a,x                              ; $e712: de 5a 04  
            bne __e704                               ; $e715: d0 ed     
            jsr __f1b3                               ; $e717: 20 b3 f1  
            ldy Player1State,x                       ; $e71a: bc 51 04  
            and __e762,y                             ; $e71d: 39 62 e7  
            adc __e765,y                             ; $e720: 79 65 e7  
            sta $045a,x                              ; $e723: 9d 5a 04  
            stx BytesLeftToLoad                      ; $e726: 86 12     
            lda GameTimer                            ; $e728: a5 19     
            rol                                      ; $e72a: 2a        
            rol                                      ; $e72b: 2a        
            eor BytesLeftToLoad                      ; $e72c: 45 12     
            and #$01                                 ; $e72e: 29 01     
            tay                                      ; $e730: a8        
            lda $0088,y                              ; $e731: b9 88 00  
            bmi __e749                               ; $e734: 30 13     
            lda $00bd,y                              ; $e736: b9 bd 00  
            bne __e749                               ; $e739: d0 0e     
            lda #$00                                 ; $e73b: a9 00     
            sta $31,x                                ; $e73d: 95 31     
            lda $009a,y                              ; $e73f: b9 9a 00  
            sec                                      ; $e742: 38        
            sbc #$04                                 ; $e743: e9 04     
            cmp Player1Y,x                           ; $e745: d5 9a     
            bcs __e74d                               ; $e747: b0 04     
__e749:     lda #$40                                 ; $e749: a9 40     
            sta $31,x                                ; $e74b: 95 31     
__e74d:     lda Player1X,x                           ; $e74d: b5 91     
            cmp $0091,y                              ; $e74f: d9 91 00  
            bcs __e75b                               ; $e752: b0 07     
            lda $31,x                                ; $e754: b5 31     
            ora #$01                                 ; $e756: 09 01     
            sta $31,x                                ; $e758: 95 31     
            rts                                      ; $e75a: 60        

;-------------------------------------------------------------------------------
__e75b:     lda $31,x                                ; $e75b: b5 31     
            ora #$02                                 ; $e75d: 09 02     
            sta $31,x                                ; $e75f: 95 31     
            rts                                      ; $e761: 60        

;-------------------------------------------------------------------------------
__e762:     .hex 1f 0f 07                            ; $e762: 1f 0f 07      Data
__e765:     .hex 20 10 08                            ; $e765: 20 10 08      Data

;-------------------------------------------------------------------------------
__e768:     ldx #$00                                 ; $e768: a2 00     
__e76a:     lda #$01                                 ; $e76a: a9 01     
            sta $4016                                ; $e76c: 8d 16 40  
            lda #$00                                 ; $e76f: a9 00     
            sta $4016                                ; $e771: 8d 16 40  
            ldy #$07                                 ; $e774: a0 07     
__e776:     lda $4016,x                              ; $e776: bd 16 40  
            sta BytesLeftToLoad                      ; $e779: 85 12     
            lsr                                      ; $e77b: 4a        
            ora BytesLeftToLoad                      ; $e77c: 05 12     
            lsr                                      ; $e77e: 4a        
            rol $061c,x                              ; $e77f: 3e 1c 06  
            dey                                      ; $e782: 88        
            bpl __e776                               ; $e783: 10 f1     
            ldy $061e,x                              ; $e785: bc 1e 06  
            lda $061c,x                              ; $e788: bd 1c 06  
            sta $061e,x                              ; $e78b: 9d 1e 06  
            tya                                      ; $e78e: 98        
            eor $061c,x                              ; $e78f: 5d 1c 06  
            and $061c,x                              ; $e792: 3d 1c 06  
            rts                                      ; $e795: 60        

;-------------------------------------------------------------------------------
__e796:     lda Player1Ballons,x                     ; $e796: b5 88     
            bne __e7a3                               ; $e798: d0 09     
__e79a:     lda #$00                                 ; $e79a: a9 00     
            sta $0424,x                              ; $e79c: 9d 24 04  
            sta $042d,x                              ; $e79f: 9d 2d 04  
            rts                                      ; $e7a2: 60        

;-------------------------------------------------------------------------------
__e7a3:     cmp #$02                                 ; $e7a3: c9 02     
            beq __e7e8                               ; $e7a5: f0 41     
            cpx #$02                                 ; $e7a7: e0 02     
            bcc __e7e8                               ; $e7a9: 90 3d     
            lda $7f,x                                ; $e7ab: b5 7f     
            cmp #$02                                 ; $e7ad: c9 02     
            bcs __e79a                               ; $e7af: b0 e9     
__e7b1:     lda $0424,x                              ; $e7b1: bd 24 04  
            sta BytesLeftToLoad                      ; $e7b4: 85 12     
            lda $042d,x                              ; $e7b6: bd 2d 04  
            sta $13                                  ; $e7b9: 85 13     
            jsr __f1a6                               ; $e7bb: 20 a6 f1  
            lda $0463,x                              ; $e7be: bd 63 04  
            clc                                      ; $e7c1: 18        
            adc BytesLeftToLoad                      ; $e7c2: 65 12     
            sta $0463,x                              ; $e7c4: 9d 63 04  
            sta BytesLeftToLoad                      ; $e7c7: 85 12     
            lda $046c,x                              ; $e7c9: bd 6c 04  
            adc $13                                  ; $e7cc: 65 13     
            sta $046c,x                              ; $e7ce: 9d 6c 04  
            sta $13                                  ; $e7d1: 85 13     
            jsr __f1a6                               ; $e7d3: 20 a6 f1  
            lda $0424,x                              ; $e7d6: bd 24 04  
            sec                                      ; $e7d9: 38        
            sbc BytesLeftToLoad                      ; $e7da: e5 12     
            sta $0424,x                              ; $e7dc: 9d 24 04  
            lda $042d,x                              ; $e7df: bd 2d 04  
            sbc $13                                  ; $e7e2: e5 13     
            sta $042d,x                              ; $e7e4: 9d 2d 04  
            rts                                      ; $e7e7: 60        

;-------------------------------------------------------------------------------
__e7e8:     lda $7f,x                                ; $e7e8: b5 7f     
            cmp #$06                                 ; $e7ea: c9 06     
            bcc __e7ef                               ; $e7ec: 90 01     
            rts                                      ; $e7ee: 60        

;-------------------------------------------------------------------------------
__e7ef:     lda $7f,x                                ; $e7ef: b5 7f     
            cmp #$04                                 ; $e7f1: c9 04     
            bne __e811                               ; $e7f3: d0 1c     
            lda $31,x                                ; $e7f5: b5 31     
            and #$02                                 ; $e7f7: 29 02     
            beq __e802                               ; $e7f9: f0 07     
            lda $0448,x                              ; $e7fb: bd 48 04  
            beq __e811                               ; $e7fe: f0 11     
            bne __e80d                               ; $e800: d0 0b     
__e802:     lda $31,x                                ; $e802: b5 31     
            and #$01                                 ; $e804: 29 01     
            beq __e811                               ; $e806: f0 09     
            lda $0448,x                              ; $e808: bd 48 04  
            bne __e811                               ; $e80b: d0 04     
__e80d:     lda #$05                                 ; $e80d: a9 05     
            sta $7f,x                                ; $e80f: 95 7f     
__e811:     lda $7f,x                                ; $e811: b5 7f     
            cmp #$02                                 ; $e813: c9 02     
            bne __e832                               ; $e815: d0 1b     
            lda $31,x                                ; $e817: b5 31     
            and #$02                                 ; $e819: 29 02     
            beq __e821                               ; $e81b: f0 04     
            lda #$00                                 ; $e81d: a9 00     
            beq __e829                               ; $e81f: f0 08     
__e821:     lda $31,x                                ; $e821: b5 31     
            and #$01                                 ; $e823: 29 01     
            beq __e82e                               ; $e825: f0 07     
            lda #$01                                 ; $e827: a9 01     
__e829:     cmp $0448,x                              ; $e829: dd 48 04  
            beq __e832                               ; $e82c: f0 04     
__e82e:     lda #$04                                 ; $e82e: a9 04     
            sta $7f,x                                ; $e830: 95 7f     
__e832:     lda $7f,x                                ; $e832: b5 7f     
            cmp #$04                                 ; $e834: c9 04     
            bcc __e854                               ; $e836: 90 1c     
            lda $31,x                                ; $e838: b5 31     
            and #$02                                 ; $e83a: 29 02     
            beq __e845                               ; $e83c: f0 07     
            lda $0448,x                              ; $e83e: bd 48 04  
            bne __e854                               ; $e841: d0 11     
            beq __e850                               ; $e843: f0 0b     
__e845:     lda $31,x                                ; $e845: b5 31     
            and #$01                                 ; $e847: 29 01     
            beq __e854                               ; $e849: f0 09     
            lda $0448,x                              ; $e84b: bd 48 04  
            beq __e854                               ; $e84e: f0 04     
__e850:     lda #$02                                 ; $e850: a9 02     
            sta $7f,x                                ; $e852: 95 7f     
__e854:     lda $7f,x                                ; $e854: b5 7f     
            cmp #$03                                 ; $e856: c9 03     
            bne __e864                               ; $e858: d0 0a     
            lda $31,x                                ; $e85a: b5 31     
            and #$03                                 ; $e85c: 29 03     
            beq __e864                               ; $e85e: f0 04     
            lda #$02                                 ; $e860: a9 02     
            sta $7f,x                                ; $e862: 95 7f     
__e864:     lda $7f,x                                ; $e864: b5 7f     
            cmp #$04                                 ; $e866: c9 04     
            bcs __e87f                               ; $e868: b0 15     
            lda $31,x                                ; $e86a: b5 31     
            and #$02                                 ; $e86c: 29 02     
            beq __e874                               ; $e86e: f0 04     
            lda #$00                                 ; $e870: a9 00     
            beq __e87c                               ; $e872: f0 08     
__e874:     lda $31,x                                ; $e874: b5 31     
            and #$01                                 ; $e876: 29 01     
            beq __e87f                               ; $e878: f0 05     
            lda #$01                                 ; $e87a: a9 01     
__e87c:     sta $0448,x                              ; $e87c: 9d 48 04  
__e87f:     lda $7f,x                                ; $e87f: b5 7f     
            cmp #$04                                 ; $e881: c9 04     
            bcc __e8b8                               ; $e883: 90 33     
            lda $0436,x                              ; $e885: bd 36 04  
            cmp #$01                                 ; $e888: c9 01     
            bne __e8b8                               ; $e88a: d0 2c     
            ldy Player1State,x                       ; $e88c: bc 51 04  
            lda $0448,x                              ; $e88f: bd 48 04  
            beq __e8a6                               ; $e892: f0 12     
            lda $0424,x                              ; $e894: bd 24 04  
            sec                                      ; $e897: 38        
            sbc __e625,y                             ; $e898: f9 25 e6  
            sta $0424,x                              ; $e89b: 9d 24 04  
            lda $042d,x                              ; $e89e: bd 2d 04  
            sbc #$00                                 ; $e8a1: e9 00     
            jmp __e901                               ; $e8a3: 4c 01 e9  

;-------------------------------------------------------------------------------
__e8a6:     lda $0424,x                              ; $e8a6: bd 24 04  
            clc                                      ; $e8a9: 18        
            adc __e625,y                             ; $e8aa: 79 25 e6  
            sta $0424,x                              ; $e8ad: 9d 24 04  
            lda $042d,x                              ; $e8b0: bd 2d 04  
            adc #$00                                 ; $e8b3: 69 00     
            jmp __e901                               ; $e8b5: 4c 01 e9  

;-------------------------------------------------------------------------------
__e8b8:     lda $7f,x                                ; $e8b8: b5 7f     
            beq __e8c7                               ; $e8ba: f0 0b     
            cmp #$02                                 ; $e8bc: c9 02     
            beq __e907                               ; $e8be: f0 47     
            cmp #$03                                 ; $e8c0: c9 03     
            beq __e8c7                               ; $e8c2: f0 03     
            jmp __e951                               ; $e8c4: 4c 51 e9  

;-------------------------------------------------------------------------------
__e8c7:     lda $0436,x                              ; $e8c7: bd 36 04  
            cmp #$01                                 ; $e8ca: c9 01     
            beq __e8d1                               ; $e8cc: f0 03     
            jmp __e951                               ; $e8ce: 4c 51 e9  

;-------------------------------------------------------------------------------
__e8d1:     ldy Player1State,x                       ; $e8d1: bc 51 04  
            lda $31,x                                ; $e8d4: b5 31     
            and #$02                                 ; $e8d6: 29 02     
            beq __e8ec                               ; $e8d8: f0 12     
            lda $0424,x                              ; $e8da: bd 24 04  
            sec                                      ; $e8dd: 38        
            sbc __e619,y                             ; $e8de: f9 19 e6  
            sta $0424,x                              ; $e8e1: 9d 24 04  
            lda $042d,x                              ; $e8e4: bd 2d 04  
            sbc #$00                                 ; $e8e7: e9 00     
            jmp __e901                               ; $e8e9: 4c 01 e9  

;-------------------------------------------------------------------------------
__e8ec:     lda $31,x                                ; $e8ec: b5 31     
            and #$01                                 ; $e8ee: 29 01     
            beq __e951                               ; $e8f0: f0 5f     
            lda $0424,x                              ; $e8f2: bd 24 04  
            clc                                      ; $e8f5: 18        
            adc __e619,y                             ; $e8f6: 79 19 e6  
            sta $0424,x                              ; $e8f9: 9d 24 04  
            lda $042d,x                              ; $e8fc: bd 2d 04  
            adc #$00                                 ; $e8ff: 69 00     
__e901:     sta $042d,x                              ; $e901: 9d 2d 04  
            jmp __e951                               ; $e904: 4c 51 e9  

;-------------------------------------------------------------------------------
__e907:     lda $0436,x                              ; $e907: bd 36 04  
            cmp #$01                                 ; $e90a: c9 01     
            bne __e951                               ; $e90c: d0 43     
            ldy Player1State,x                       ; $e90e: bc 51 04  
            lda $31,x                                ; $e911: b5 31     
            and #$02                                 ; $e913: 29 02     
            beq __e929                               ; $e915: f0 12     
            lda $0424,x                              ; $e917: bd 24 04  
            sec                                      ; $e91a: 38        
            sbc __e625,y                             ; $e91b: f9 25 e6  
            sta $0424,x                              ; $e91e: 9d 24 04  
            lda $042d,x                              ; $e921: bd 2d 04  
            sbc #$00                                 ; $e924: e9 00     
            jmp __e93e                               ; $e926: 4c 3e e9  

;-------------------------------------------------------------------------------
__e929:     lda $31,x                                ; $e929: b5 31     
            and #$01                                 ; $e92b: 29 01     
            beq __e951                               ; $e92d: f0 22     
            lda $0424,x                              ; $e92f: bd 24 04  
            clc                                      ; $e932: 18        
            adc __e625,y                             ; $e933: 79 25 e6  
            sta $0424,x                              ; $e936: 9d 24 04  
            lda $042d,x                              ; $e939: bd 2d 04  
            adc #$00                                 ; $e93c: 69 00     
__e93e:     sta $042d,x                              ; $e93e: 9d 2d 04  
            lda $31,x                                ; $e941: b5 31     
            and #$03                                 ; $e943: 29 03     
            beq __e951                               ; $e945: f0 0a     
            cpx #$02                                 ; $e947: e0 02     
            bcs __e951                               ; $e949: b0 06     
            lda $f0                                  ; $e94b: a5 f0     
            ora #$08                                 ; $e94d: 09 08     
            sta $f0                                  ; $e94f: 85 f0     
__e951:     lda $7f,x                                ; $e951: b5 7f     
            cmp #$04                                 ; $e953: c9 04     
            bcc __e982                               ; $e955: 90 2b     
            lda $0448,x                              ; $e957: bd 48 04  
            bne __e963                               ; $e95a: d0 07     
            lda $042d,x                              ; $e95c: bd 2d 04  
            bmi __e982                               ; $e95f: 30 21     
            bpl __e968                               ; $e961: 10 05     
__e963:     lda $042d,x                              ; $e963: bd 2d 04  
            bpl __e982                               ; $e966: 10 1a     
__e968:     lda $7f,x                                ; $e968: b5 7f     
            cmp #$05                                 ; $e96a: c9 05     
            bne __e976                               ; $e96c: d0 08     
            lda $0448,x                              ; $e96e: bd 48 04  
            eor #$01                                 ; $e971: 49 01     
            sta $0448,x                              ; $e973: 9d 48 04  
__e976:     lda #$03                                 ; $e976: a9 03     
            sta $7f,x                                ; $e978: 95 7f     
            lda #$00                                 ; $e97a: a9 00     
            sta $0424,x                              ; $e97c: 9d 24 04  
            sta $042d,x                              ; $e97f: 9d 2d 04  
__e982:     rts                                      ; $e982: 60        

;-------------------------------------------------------------------------------
__e983:     lda $cb                                  ; $e983: a5 cb     
            bne __e9b6                               ; $e985: d0 2f     
            lda Player1Invincible,x                  ; $e987: b5 bd     
            beq __e99a                               ; $e989: f0 0f     
            lda $0488                                ; $e98b: ad 88 04  
            beq __e99a                               ; $e98e: f0 0a     
            sec                                      ; $e990: 38        
            sbc Player1X,x                           ; $e991: f5 91     
            jsr __f08e                               ; $e993: 20 8e f0  
            cmp #$05                                 ; $e996: c9 05     
            bcc __e9b6                               ; $e998: 90 1c     
__e99a:     cpx #$02                                 ; $e99a: e0 02     
            bcc __e9a4                               ; $e99c: 90 06     
            lda Player1Ballons,x                     ; $e99e: b5 88     
            cmp #$02                                 ; $e9a0: c9 02     
            bne __e9f2                               ; $e9a2: d0 4e     
__e9a4:     lda $7f,x                                ; $e9a4: b5 7f     
            cmp #$02                                 ; $e9a6: c9 02     
            bcc __e9f2                               ; $e9a8: 90 48     
            cmp #$06                                 ; $e9aa: c9 06     
            bcs __e9f2                               ; $e9ac: b0 44     
            lda #$01                                 ; $e9ae: a9 01     
            sta $7f,x                                ; $e9b0: 95 7f     
            sta $045a,x                              ; $e9b2: 9d 5a 04  
            rts                                      ; $e9b5: 60        

;-------------------------------------------------------------------------------
__e9b6:     lda #$00                                 ; $e9b6: a9 00     
            sta $0412,x                              ; $e9b8: 9d 12 04  
            sta $041b,x                              ; $e9bb: 9d 1b 04  
            sta $0409,x                              ; $e9be: 9d 09 04  
            sta $cb                                  ; $e9c1: 85 cb     
            cpx #$02                                 ; $e9c3: e0 02     
            bcc __e9fd                               ; $e9c5: 90 36     
            lda Player1Ballons,x                     ; $e9c7: b5 88     
            cmp #$02                                 ; $e9c9: c9 02     
            beq __e9f3                               ; $e9cb: f0 26     
            cmp #$01                                 ; $e9cd: c9 01     
            bne __e9f2                               ; $e9cf: d0 21     
            lda $7f,x                                ; $e9d1: b5 7f     
            cmp #$02                                 ; $e9d3: c9 02     
            bcs __e9f2                               ; $e9d5: b0 1b     
            lda #$02                                 ; $e9d7: a9 02     
            sta $7f,x                                ; $e9d9: 95 7f     
            lda $c6                                  ; $e9db: a5 c6     
            sta $043f,x                              ; $e9dd: 9d 3f 04  
            lda #$00                                 ; $e9e0: a9 00     
            sta $0424,x                              ; $e9e2: 9d 24 04  
            sta $042d,x                              ; $e9e5: 9d 2d 04  
            sta $0463,x                              ; $e9e8: 9d 63 04  
            sta $046c,x                              ; $e9eb: 9d 6c 04  
            lda #$40                                 ; $e9ee: a9 40     
            sta $f1                                  ; $e9f0: 85 f1     
__e9f2:     rts                                      ; $e9f2: 60        

;-------------------------------------------------------------------------------
__e9f3:     lda #$00                                 ; $e9f3: a9 00     
            sta $7f,x                                ; $e9f5: 95 7f     
            lda #$01                                 ; $e9f7: a9 01     
            sta $045a,x                              ; $e9f9: 9d 5a 04  
            rts                                      ; $e9fc: 60        

;-------------------------------------------------------------------------------
__e9fd:     lda $7f,x                                ; $e9fd: b5 7f     
            cmp #$01                                 ; $e9ff: c9 01     
            bne __ea17                               ; $ea01: d0 14     
            cmp #$06                                 ; $ea03: c9 06     
            bcs __ea17                               ; $ea05: b0 10     
            lda $0424,x                              ; $ea07: bd 24 04  
            ora $042d,x                              ; $ea0a: 1d 2d 04  
            bne __ea13                               ; $ea0d: d0 04     
            lda #$03                                 ; $ea0f: a9 03     
            bne __ea15                               ; $ea11: d0 02     
__ea13:     lda #$02                                 ; $ea13: a9 02     
__ea15:     sta $7f,x                                ; $ea15: 95 7f     
__ea17:     rts                                      ; $ea17: 60        

;-------------------------------------------------------------------------------
__ea18:     cpx #$02                                 ; $ea18: e0 02     
            bcs __ea2c                               ; $ea1a: b0 10     
            lda Player1Invincible,x                  ; $ea1c: b5 bd     
            bne __ea44                               ; $ea1e: d0 24     
            lda $7f,x                                ; $ea20: b5 7f     
            cmp #$01                                 ; $ea22: c9 01     
            beq __ea3e                               ; $ea24: f0 18     
            cmp #$03                                 ; $ea26: c9 03     
            bne __ea44                               ; $ea28: d0 1a     
            beq __ea3e                               ; $ea2a: f0 12     
__ea2c:     lda $7f,x                                ; $ea2c: b5 7f     
            cmp #$01                                 ; $ea2e: c9 01     
            beq __ea3e                               ; $ea30: f0 0c     
            cmp #$03                                 ; $ea32: c9 03     
            bcc __ea44                               ; $ea34: 90 0e     
            lda GameTimer                            ; $ea36: a5 19     
            and #$03                                 ; $ea38: 29 03     
            bne __ea47                               ; $ea3a: d0 0b     
            beq __ea44                               ; $ea3c: f0 06     
__ea3e:     lda GameTimer                            ; $ea3e: a5 19     
            and #$07                                 ; $ea40: 29 07     
            bne __ea47                               ; $ea42: d0 03     
__ea44:     inc $0436,x                              ; $ea44: fe 36 04  
__ea47:     lda $0436,x                              ; $ea47: bd 36 04  
            and #$03                                 ; $ea4a: 29 03     
            sta $0436,x                              ; $ea4c: 9d 36 04  
            bne __ea57                               ; $ea4f: d0 06     
            lda $7f,x                                ; $ea51: b5 7f     
            bne __ea57                               ; $ea53: d0 02     
            inc $7f,x                                ; $ea55: f6 7f     
__ea57:     rts                                      ; $ea57: 60        

;-------------------------------------------------------------------------------
__ea58:     lda $0475,x                              ; $ea58: bd 75 04  
            beq __ea60                               ; $ea5b: f0 03     
            dec $0475,x                              ; $ea5d: de 75 04  
__ea60:     cpx #$02                                 ; $ea60: e0 02     
            bcs __ea8c                               ; $ea62: b0 28     
            lda $c1,x                                ; $ea64: b5 c1     
            beq __ea8c                               ; $ea66: f0 24     
            lda GameTimer                            ; $ea68: a5 19     
            lsr                                      ; $ea6a: 4a        
            bcc __ea8b                               ; $ea6b: 90 1e     
            inc $0436,x                              ; $ea6d: fe 36 04  
            lda $0436,x                              ; $ea70: bd 36 04  
            and #$03                                 ; $ea73: 29 03     
            sta $0436,x                              ; $ea75: 9d 36 04  
            lda #$01                                 ; $ea78: a9 01     
            sta $7f,x                                ; $ea7a: 95 7f     
            dec $045a,x                              ; $ea7c: de 5a 04  
            bne __ea8b                               ; $ea7f: d0 0a     
            lda #$00                                 ; $ea81: a9 00     
            sta $c1,x                                ; $ea83: 95 c1     
            sta $7f,x                                ; $ea85: 95 7f     
            lda #$20                                 ; $ea87: a9 20     
            sta $f0                                  ; $ea89: 85 f0     
__ea8b:     rts                                      ; $ea8b: 60        

;-------------------------------------------------------------------------------
__ea8c:     lda $0412,x                              ; $ea8c: bd 12 04  
            clc                                      ; $ea8f: 18        
            ldy Player1State,x                       ; $ea90: bc 51 04  
            adc __e601,y                             ; $ea93: 79 01 e6  
            sta $0412,x                              ; $ea96: 9d 12 04  
            bcc __ea9e                               ; $ea99: 90 03     
            inc $041b,x                              ; $ea9b: fe 1b 04  
__ea9e:     lda $041b,x                              ; $ea9e: bd 1b 04  
            bmi __eac1                               ; $eaa1: 30 1e     
            cmp __e66d,y                             ; $eaa3: d9 6d e6  
            bcc __eadc                               ; $eaa6: 90 34     
            bne __eab2                               ; $eaa8: d0 08     
            lda $0412,x                              ; $eaaa: bd 12 04  
            cmp __e661,y                             ; $eaad: d9 61 e6  
            bcc __eadc                               ; $eab0: 90 2a     
__eab2:     lda __e661,y                             ; $eab2: b9 61 e6  
            sta $0412,x                              ; $eab5: 9d 12 04  
            lda __e66d,y                             ; $eab8: b9 6d e6  
            sta $041b,x                              ; $eabb: 9d 1b 04  
            jmp __eadc                               ; $eabe: 4c dc ea  

;-------------------------------------------------------------------------------
__eac1:     cmp __e685,y                             ; $eac1: d9 85 e6  
            bcc __ead0                               ; $eac4: 90 0a     
            bne __eadc                               ; $eac6: d0 14     
            lda $0412,x                              ; $eac8: bd 12 04  
            cmp __e679,y                             ; $eacb: d9 79 e6  
            bcs __eadc                               ; $eace: b0 0c     
__ead0:     lda __e679,y                             ; $ead0: b9 79 e6  
            sta $0412,x                              ; $ead3: 9d 12 04  
            lda __e685,y                             ; $ead6: b9 85 e6  
            sta $041b,x                              ; $ead9: 9d 1b 04  
__eadc:     jsr __eba0                               ; $eadc: 20 a0 eb  
            cmp #$f8                                 ; $eadf: c9 f8     
            bcs __eb0d                               ; $eae1: b0 2a     
            cmp #$e8                                 ; $eae3: c9 e8     
            bcc __eb0d                               ; $eae5: 90 26     
            lda #$ff                                 ; $eae7: a9 ff     
            sta Player1Ballons,x                     ; $eae9: 95 88     
            lda #$04                                 ; $eaeb: a9 04     
            sta $bb                                  ; $eaed: 85 bb     
            lda Player1X,x                           ; $eaef: b5 91     
            sta $bc                                  ; $eaf1: 85 bc     
            cpx #$02                                 ; $eaf3: e0 02     
            bcc __eb05                               ; $eaf5: 90 0e     
            lda #$80                                 ; $eaf7: a9 80     
            sta Player1Ballons,x                     ; $eaf9: 95 88     
            lda #$00                                 ; $eafb: a9 00     
            sta $7f,x                                ; $eafd: 95 7f     
            lda #$01                                 ; $eaff: a9 01     
            sta $f3                                  ; $eb01: 85 f3     
            bne __eb0d                               ; $eb03: d0 08     
__eb05:     lda IsBonusPhase                         ; $eb05: a5 c8     
            bne __eb0d                               ; $eb07: d0 04     
            lda #$40                                 ; $eb09: a9 40     
            sta $f0                                  ; $eb0b: 85 f0     
__eb0d:     lda $042d,x                              ; $eb0d: bd 2d 04  
            bmi __eb30                               ; $eb10: 30 1e     
            cmp __e63d,y                             ; $eb12: d9 3d e6  
            bcc __eb4b                               ; $eb15: 90 34     
            bne __eb21                               ; $eb17: d0 08     
            lda $0424,x                              ; $eb19: bd 24 04  
            cmp __e631,y                             ; $eb1c: d9 31 e6  
            bcc __eb4b                               ; $eb1f: 90 2a     
__eb21:     lda __e631,y                             ; $eb21: b9 31 e6  
            sta $0424,x                              ; $eb24: 9d 24 04  
            lda __e63d,y                             ; $eb27: b9 3d e6  
            sta $042d,x                              ; $eb2a: 9d 2d 04  
            jmp __eb4b                               ; $eb2d: 4c 4b eb  

;-------------------------------------------------------------------------------
__eb30:     cmp __e655,y                             ; $eb30: d9 55 e6  
            bcc __eb3f                               ; $eb33: 90 0a     
            bne __eb4b                               ; $eb35: d0 14     
            lda $0424,x                              ; $eb37: bd 24 04  
            cmp __e649,y                             ; $eb3a: d9 49 e6  
            bcs __eb4b                               ; $eb3d: b0 0c     
__eb3f:     lda __e649,y                             ; $eb3f: b9 49 e6  
            sta $0424,x                              ; $eb42: 9d 24 04  
            lda __e655,y                             ; $eb45: b9 55 e6  
            sta $042d,x                              ; $eb48: 9d 2d 04  
__eb4b:     jsr __eb8e                               ; $eb4b: 20 8e eb  
            lda $16                                  ; $eb4e: a5 16     
            beq __eb62                               ; $eb50: f0 10     
            lda Player1X,x                           ; $eb52: b5 91     
            cmp #$10                                 ; $eb54: c9 10     
            bcs __eb5a                               ; $eb56: b0 02     
            lda #$10                                 ; $eb58: a9 10     
__eb5a:     cmp #$e0                                 ; $eb5a: c9 e0     
            bcc __eb60                               ; $eb5c: 90 02     
            lda #$e0                                 ; $eb5e: a9 e0     
__eb60:     sta Player1X,x                           ; $eb60: 95 91     
__eb62:     lda IsBonusPhase                         ; $eb62: a5 c8     
            beq __eb8d                               ; $eb64: f0 27     
            lda Player1Ballons,x                     ; $eb66: b5 88     
            bne __eb8d                               ; $eb68: d0 23     
            lda Player1Y,x                           ; $eb6a: b5 9a     
            cmp #$c8                                 ; $eb6c: c9 c8     
            bcc __eb8d                               ; $eb6e: 90 1d     
            lda #$c7                                 ; $eb70: a9 c7     
            sta Player1Y,x                           ; $eb72: 95 9a     
            lda Player1State,x                       ; $eb74: bd 51 04  
            cmp #$0b                                 ; $eb77: c9 0b     
            bne __eb84                               ; $eb79: d0 09     
            dec Player1State,x                       ; $eb7b: de 51 04  
            jsr __f107                               ; $eb7e: 20 07 f1  
            jmp __f18c                               ; $eb81: 4c 8c f1  

;-------------------------------------------------------------------------------
__eb84:     lda #$02                                 ; $eb84: a9 02     
            sta Player1Ballons,x                     ; $eb86: 95 88     
            lda #$03                                 ; $eb88: a9 03     
            sta Player1State,x                       ; $eb8a: 9d 51 04  
__eb8d:     rts                                      ; $eb8d: 60        

;-------------------------------------------------------------------------------
__eb8e:     lda $0400,x                              ; $eb8e: bd 00 04  
            clc                                      ; $eb91: 18        
            adc $0424,x                              ; $eb92: 7d 24 04  
            sta $0400,x                              ; $eb95: 9d 00 04  
            lda Player1X,x                           ; $eb98: b5 91     
            adc $042d,x                              ; $eb9a: 7d 2d 04  
            sta Player1X,x                           ; $eb9d: 95 91     
            rts                                      ; $eb9f: 60        

;-------------------------------------------------------------------------------
__eba0:     lda $0409,x                              ; $eba0: bd 09 04  
            clc                                      ; $eba3: 18        
            adc $0412,x                              ; $eba4: 7d 12 04  
            sta $0409,x                              ; $eba7: 9d 09 04  
            lda Player1Y,x                           ; $ebaa: b5 9a     
            adc $041b,x                              ; $ebac: 7d 1b 04  
            sta Player1Y,x                           ; $ebaf: 95 9a     
            rts                                      ; $ebb1: 60        

;-------------------------------------------------------------------------------
__ebb2:     jsr __f0b4                               ; $ebb2: 20 b4 f0  
            jsr __eb8e                               ; $ebb5: 20 8e eb  
            jmp __f0b4                               ; $ebb8: 4c b4 f0  

;-------------------------------------------------------------------------------
__ebbb:     jsr __f0b4                               ; $ebbb: 20 b4 f0  
            jsr __eba0                               ; $ebbe: 20 a0 eb  
            jmp __f0b4                               ; $ebc1: 4c b4 f0  

;-------------------------------------------------------------------------------
__ebc4:     cpx #$02                                 ; $ebc4: e0 02     
            bcs __ebe3                               ; $ebc6: b0 1b     
            lda Player1Ballons,x                     ; $ebc8: b5 88     
            bne __ebd6                               ; $ebca: d0 0a     
            lda $0436,x                              ; $ebcc: bd 36 04  
            bne __ebd6                               ; $ebcf: d0 05     
            lda #$00                                 ; $ebd1: a9 00     
            sta $7f,x                                ; $ebd3: 95 7f     
            rts                                      ; $ebd5: 60        

;-------------------------------------------------------------------------------
__ebd6:     lda $7f,x                                ; $ebd6: b5 7f     
            cmp #$06                                 ; $ebd8: c9 06     
            bcc __ec38                               ; $ebda: 90 5c     
            lda #$01                                 ; $ebdc: a9 01     
            sta $7f,x                                ; $ebde: 95 7f     
            dec Player1Ballons,x                     ; $ebe0: d6 88     
            rts                                      ; $ebe2: 60        

;-------------------------------------------------------------------------------
__ebe3:     lda Player1Ballons,x                     ; $ebe3: b5 88     
            cmp #$02                                 ; $ebe5: c9 02     
            beq __ec38                               ; $ebe7: f0 4f     
            lda $0436,x                              ; $ebe9: bd 36 04  
            bne __ebfd                               ; $ebec: d0 0f     
            lda Player1Ballons,x                     ; $ebee: b5 88     
            bne __ebf7                               ; $ebf0: d0 05     
            lda #$00                                 ; $ebf2: a9 00     
            sta $7f,x                                ; $ebf4: 95 7f     
            rts                                      ; $ebf6: 60        

;-------------------------------------------------------------------------------
__ebf7:     lda $7f,x                                ; $ebf7: b5 7f     
            bne __ebfe                               ; $ebf9: d0 03     
            inc $7f,x                                ; $ebfb: f6 7f     
__ebfd:     rts                                      ; $ebfd: 60        

;-------------------------------------------------------------------------------
__ebfe:     cmp #$02                                 ; $ebfe: c9 02     
            bcc __ebfd                               ; $ec00: 90 fb     
            dec $045a,x                              ; $ec02: de 5a 04  
            bne __ec37                               ; $ec05: d0 30     
            lda $c7                                  ; $ec07: a5 c7     
            sta $045a,x                              ; $ec09: 9d 5a 04  
            inc $7f,x                                ; $ec0c: f6 7f     
            lda $7f,x                                ; $ec0e: b5 7f     
            cmp #$07                                 ; $ec10: c9 07     
            bcc __ec37                               ; $ec12: 90 23     
            lda #$02                                 ; $ec14: a9 02     
            sta Player1Ballons,x                     ; $ec16: 95 88     
            lda #$00                                 ; $ec18: a9 00     
            sta $7f,x                                ; $ec1a: 95 7f     
            ldy Player1State,x                       ; $ec1c: bc 51 04  
            lda __ecae,y                             ; $ec1f: b9 ae ec  
            ldy $047e,x                              ; $ec22: bc 7e 04  
            bne __ec2f                               ; $ec25: d0 08     
            dec $047e,x                              ; $ec27: de 7e 04  
            lda Player1State,x                       ; $ec2a: bd 51 04  
            and #$03                                 ; $ec2d: 29 03     
__ec2f:     sta Player1State,x                       ; $ec2f: 9d 51 04  
            lda #$fe                                 ; $ec32: a9 fe     
            sta $041b,x                              ; $ec34: 9d 1b 04  
__ec37:     rts                                      ; $ec37: 60        

;-------------------------------------------------------------------------------
__ec38:     jsr __e6e9                               ; $ec38: 20 e9 e6  
            lda $31,x                                ; $ec3b: b5 31     
            and #$c3                                 ; $ec3d: 29 c3     
            beq __ec49                               ; $ec3f: f0 08     
            cpx #$02                                 ; $ec41: e0 02     
            bcs __ec49                               ; $ec43: b0 04     
            lda #$00                                 ; $ec45: a9 00     
            sta Player1Invincible,x                  ; $ec47: 95 bd     
__ec49:     lda $31,x                                ; $ec49: b5 31     
            and #$40                                 ; $ec4b: 29 40     
            bne __ec61                               ; $ec4d: d0 12     
            lda $31,x                                ; $ec4f: b5 31     
            and #$80                                 ; $ec51: 29 80     
            bne __ec5c                               ; $ec53: d0 07     
            lda #$00                                 ; $ec55: a9 00     
            sta $0620,x                              ; $ec57: 9d 20 06  
            beq __ecad                               ; $ec5a: f0 51     
__ec5c:     lda $0620,x                              ; $ec5c: bd 20 06  
            bne __ecad                               ; $ec5f: d0 4c     
__ec61:     lda $7f,x                                ; $ec61: b5 7f     
            cmp #$02                                 ; $ec63: c9 02     
            bcc __ec75                               ; $ec65: 90 0e     
            dec Player1Y,x                           ; $ec67: d6 9a     
            dec Player1Y,x                           ; $ec69: d6 9a     
            lda #$00                                 ; $ec6b: a9 00     
            sta $0412,x                              ; $ec6d: 9d 12 04  
            sta $041b,x                              ; $ec70: 9d 1b 04  
            beq __ec7e                               ; $ec73: f0 09     
__ec75:     cmp #$01                                 ; $ec75: c9 01     
            beq __ec7e                               ; $ec77: f0 05     
            lda $0436,x                              ; $ec79: bd 36 04  
            bne __ecad                               ; $ec7c: d0 2f     
__ec7e:     lda #$00                                 ; $ec7e: a9 00     
            sta $7f,x                                ; $ec80: 95 7f     
            lda #$01                                 ; $ec82: a9 01     
            sta $0436,x                              ; $ec84: 9d 36 04  
            lda #$01                                 ; $ec87: a9 01     
            sta $0620,x                              ; $ec89: 9d 20 06  
            ldy #$00                                 ; $ec8c: a0 00     
            cpx #$02                                 ; $ec8e: e0 02     
            bcc __ec93                               ; $ec90: 90 01     
            iny                                      ; $ec92: c8        
__ec93:     lda $00f0,y                              ; $ec93: b9 f0 00  
            ora #$10                                 ; $ec96: 09 10     
            sta $00f0,y                              ; $ec98: 99 f0 00  
            lda $0412,x                              ; $ec9b: bd 12 04  
            sec                                      ; $ec9e: 38        
            ldy Player1State,x                       ; $ec9f: bc 51 04  
            sbc __e60d,y                             ; $eca2: f9 0d e6  
            sta $0412,x                              ; $eca5: 9d 12 04  
            bcs __ecad                               ; $eca8: b0 03     
            dec $041b,x                              ; $ecaa: de 1b 04  
__ecad:     rts                                      ; $ecad: 60        

;-------------------------------------------------------------------------------
__ecae:     .hex 01 02 02 03                         ; $ecae: 01 02 02 03   Data
            .hex 01 02 02 03                         ; $ecb2: 01 02 02 03   Data
            .hex 01 02 02 03                         ; $ecb6: 01 02 02 03   Data

;-------------------------------------------------------------------------------
__ecba:     lda $7f,x                                ; $ecba: b5 7f     
            bne __ed27                               ; $ecbc: d0 69     
            jsr __e7b1                               ; $ecbe: 20 b1 e7  
            jsr __eb8e                               ; $ecc1: 20 8e eb  
            lda $0409,x                              ; $ecc4: bd 09 04  
            sec                                      ; $ecc7: 38        
            sbc #$60                                 ; $ecc8: e9 60     
            sta $0409,x                              ; $ecca: 9d 09 04  
            lda Player1Y,x                           ; $eccd: b5 9a     
            sbc #$00                                 ; $eccf: e9 00     
            sta Player1Y,x                           ; $ecd1: 95 9a     
            cmp #$f1                                 ; $ecd3: c9 f1     
            bcc __ecdb                               ; $ecd5: 90 04     
            lda #$ff                                 ; $ecd7: a9 ff     
            sta Player1Ballons,x                     ; $ecd9: 95 88     
__ecdb:     txa                                      ; $ecdb: 8a        
            pha                                      ; $ecdc: 48        
            ldy #$01                                 ; $ecdd: a0 01     
__ecdf:     lda $0088,y                              ; $ecdf: b9 88 00  
            beq __ed22                               ; $ece2: f0 3e     
            bmi __ed22                               ; $ece4: 30 3c     
            lda Player1Y,x                           ; $ece6: b5 9a     
            sec                                      ; $ece8: 38        
            sbc $009a,y                              ; $ece9: f9 9a 00  
            jsr __f08e                               ; $ecec: 20 8e f0  
            cmp #$18                                 ; $ecef: c9 18     
            bcs __ed22                               ; $ecf1: b0 2f     
            lda Player1X,x                           ; $ecf3: b5 91     
            sec                                      ; $ecf5: 38        
            sbc $0091,y                              ; $ecf6: f9 91 00  
            jsr __f08e                               ; $ecf9: 20 8e f0  
            cmp #$10                                 ; $ecfc: c9 10     
            bcs __ed22                               ; $ecfe: b0 22     
            lda #$ff                                 ; $ed00: a9 ff     
            sta $7f,x                                ; $ed02: 95 7f     
            lda #$03                                 ; $ed04: a9 03     
            sta $045a,x                              ; $ed06: 9d 5a 04  
            lda #$78                                 ; $ed09: a9 78     
            sta $c5                                  ; $ed0b: 85 c5     
            lda #$02                                 ; $ed0d: a9 02     
            sta $f0                                  ; $ed0f: 85 f0     
            lda #$32                                 ; $ed11: a9 32     
            sty $3e                                  ; $ed13: 84 3e     
            jsr __d6de                               ; $ed15: 20 de d6  
            lda #$01                                 ; $ed18: a9 01     
            ldx $3e                                  ; $ed1a: a6 3e     
            jsr __d871                               ; $ed1c: 20 71 d8  
            pla                                      ; $ed1f: 68        
            tax                                      ; $ed20: aa        
            rts                                      ; $ed21: 60        

;-------------------------------------------------------------------------------
__ed22:     dey                                      ; $ed22: 88        
            bpl __ecdf                               ; $ed23: 10 ba     
            pla                                      ; $ed25: 68        
            tax                                      ; $ed26: aa        
__ed27:     rts                                      ; $ed27: 60        

;-------------------------------------------------------------------------------
__ed28:     ldy Player1Ballons,x                     ; $ed28: b4 88     
            dey                                      ; $ed2a: 88        
            bpl __ed2e                               ; $ed2b: 10 01     
__ed2d:     rts                                      ; $ed2d: 60        

;-------------------------------------------------------------------------------
__ed2e:     lda Player1Y,x                           ; $ed2e: b5 9a     
            cmp #$f9                                 ; $ed30: c9 f9     
            bcc __ed40                               ; $ed32: 90 0c     
            lda $041b,x                              ; $ed34: bd 1b 04  
            bpl __ed2d                               ; $ed37: 10 f4     
            lda #$00                                 ; $ed39: a9 00     
            sta $cc                                  ; $ed3b: 85 cc     
            jmp __ede1                               ; $ed3d: 4c e1 ed  

;-------------------------------------------------------------------------------
__ed40:     ldy PlatformCount                        ; $ed40: a4 cd     
            bmi __ed27                               ; $ed42: 30 e3     
__ed44:     lda #$00                                 ; $ed44: a9 00     
            sta $cc                                  ; $ed46: 85 cc     
            lda (PlatformTopLow),y                   ; $ed48: b1 27     
            sec                                      ; $ed4a: 38        
            sbc #$18                                 ; $ed4b: e9 18     
            cmp Player1Y,x                           ; $ed4d: d5 9a     
            bcs __edb6                               ; $ed4f: b0 65     
            adc #$03                                 ; $ed51: 69 03     
            cmp Player1Y,x                           ; $ed53: d5 9a     
            bcc __ed5b                               ; $ed55: 90 04     
            lda #$01                                 ; $ed57: a9 01     
            bne __ed69                               ; $ed59: d0 0e     
__ed5b:     lda (PlatformBottomLow),y                ; $ed5b: b1 29     
            cmp Player1Y,x                           ; $ed5d: d5 9a     
            bcc __edb6                               ; $ed5f: 90 55     
            sbc #$03                                 ; $ed61: e9 03     
            cmp Player1Y,x                           ; $ed63: d5 9a     
            bcs __ed89                               ; $ed65: b0 22     
            lda #$02                                 ; $ed67: a9 02     
__ed69:     sta $cc                                  ; $ed69: 85 cc     
            lda (PlatformLeftLow),y                  ; $ed6b: b1 23     
            cmp #$10                                 ; $ed6d: c9 10     
            beq __ed78                               ; $ed6f: f0 07     
            sec                                      ; $ed71: 38        
            sbc #$0c                                 ; $ed72: e9 0c     
            cmp Player1X,x                           ; $ed74: d5 91     
            bcs __ed85                               ; $ed76: b0 0d     
__ed78:     lda (PlatformRightLow),y                 ; $ed78: b1 25     
            cmp #$ff                                 ; $ed7a: c9 ff     
            beq __ed89                               ; $ed7c: f0 0b     
            sec                                      ; $ed7e: 38        
            sbc #$04                                 ; $ed7f: e9 04     
            cmp Player1X,x                           ; $ed81: d5 91     
            bcs __ed89                               ; $ed83: b0 04     
__ed85:     lda #$00                                 ; $ed85: a9 00     
            sta $cc                                  ; $ed87: 85 cc     
__ed89:     lda (PlatformLeftLow),y                  ; $ed89: b1 23     
            sec                                      ; $ed8b: 38        
            sbc #$10                                 ; $ed8c: e9 10     
            beq __eda0                               ; $ed8e: f0 10     
            cmp Player1X,x                           ; $ed90: d5 91     
            bcs __edb6                               ; $ed92: b0 22     
            adc #$04                                 ; $ed94: 69 04     
            cmp Player1X,x                           ; $ed96: d5 91     
            bcc __eda0                               ; $ed98: 90 06     
            lda $cc                                  ; $ed9a: a5 cc     
            ora #$04                                 ; $ed9c: 09 04     
            bne __edb4                               ; $ed9e: d0 14     
__eda0:     lda (PlatformRightLow),y                 ; $eda0: b1 25     
            cmp #$ff                                 ; $eda2: c9 ff     
            beq __edb6                               ; $eda4: f0 10     
            cmp Player1X,x                           ; $eda6: d5 91     
            bcc __edb6                               ; $eda8: 90 0c     
            sbc #$04                                 ; $edaa: e9 04     
            cmp Player1X,x                           ; $edac: d5 91     
            bcs __edb6                               ; $edae: b0 06     
            lda $cc                                  ; $edb0: a5 cc     
            ora #$08                                 ; $edb2: 09 08     
__edb4:     sta $cc                                  ; $edb4: 85 cc     
__edb6:     lda $cc                                  ; $edb6: a5 cc     
            bne __edc1                               ; $edb8: d0 07     
            dey                                      ; $edba: 88        
            bmi __edc0                               ; $edbb: 30 03     
            jmp __ed44                               ; $edbd: 4c 44 ed  

;-------------------------------------------------------------------------------
__edc0:     rts                                      ; $edc0: 60        

;-------------------------------------------------------------------------------
__edc1:     lsr $cc                                  ; $edc1: 46 cc     
            bcc __edd6                               ; $edc3: 90 11     
            lda $041b,x                              ; $edc5: bd 1b 04  
            bmi __edd6                               ; $edc8: 30 0c     
            lda (PlatformTopLow),y                   ; $edca: b1 27     
            sbc #$18                                 ; $edcc: e9 18     
            sta Player1Y,x                           ; $edce: 95 9a     
            inc Player1Y,x                           ; $edd0: f6 9a     
            lda #$01                                 ; $edd2: a9 01     
            sta $cb                                  ; $edd4: 85 cb     
__edd6:     lsr $cc                                  ; $edd6: 46 cc     
            bcc __edf4                               ; $edd8: 90 1a     
            lda $041b,x                              ; $edda: bd 1b 04  
            bpl __edf4                               ; $eddd: 10 15     
            lda (PlatformBottomLow),y                ; $eddf: b1 29     
__ede1:     sta Player1Y,x                           ; $ede1: 95 9a     
            jsr __f107                               ; $ede3: 20 07 f1  
            jsr __f18c                               ; $ede6: 20 8c f1  
            cpx #$02                                 ; $ede9: e0 02     
            bcs __edf0                               ; $edeb: b0 03     
            jsr __cc33                               ; $eded: 20 33 cc  
__edf0:     lda $cb                                  ; $edf0: a5 cb     
            bne __ee24                               ; $edf2: d0 30     
__edf4:     lsr $cc                                  ; $edf4: 46 cc     
            bcc __edff                               ; $edf6: 90 07     
            lda $042d,x                              ; $edf8: bd 2d 04  
            bmi __edff                               ; $edfb: 30 02     
            bpl __ee08                               ; $edfd: 10 09     
__edff:     lsr $cc                                  ; $edff: 46 cc     
            bcc __ee24                               ; $ee01: 90 21     
            lda $042d,x                              ; $ee03: bd 2d 04  
            bpl __ee24                               ; $ee06: 10 1c     
__ee08:     jsr __f0de                               ; $ee08: 20 de f0  
            jsr __f172                               ; $ee0b: 20 72 f1  
            lda $042d,x                              ; $ee0e: bd 2d 04  
            ora $0424,x                              ; $ee11: 1d 24 04  
            beq __ee24                               ; $ee14: f0 0e     
            lda $0448,x                              ; $ee16: bd 48 04  
            eor #$01                                 ; $ee19: 49 01     
            sta $0448,x                              ; $ee1b: 9d 48 04  
            lda $f1                                  ; $ee1e: a5 f1     
            ora #$02                                 ; $ee20: 09 02     
            sta $f1                                  ; $ee22: 85 f1     
__ee24:     rts                                      ; $ee24: 60        

;-------------------------------------------------------------------------------
__ee25:     ldx #$07                                 ; $ee25: a2 07     
__ee27:     stx BytesLeftToLoad                      ; $ee27: 86 12     
            ldy BytesLeftToLoad                      ; $ee29: a4 12     
            dey                                      ; $ee2b: 88        
            bpl __ee31                               ; $ee2c: 10 03     
__ee2e:     jmp __ef2a                               ; $ee2e: 4c 2a ef  

;-------------------------------------------------------------------------------
__ee31:     lda Player1Ballons,x                     ; $ee31: b5 88     
            bmi __ee2e                               ; $ee33: 30 f9     
            beq __ee2e                               ; $ee35: f0 f7     
            lda $0088,y                              ; $ee37: b9 88 00  
            bmi __ee2e                               ; $ee3a: 30 f2     
            beq __ee2e                               ; $ee3c: f0 f0     
            lda #$00                                 ; $ee3e: a9 00     
            sta $cc                                  ; $ee40: 85 cc     
            lda $009a,y                              ; $ee42: b9 9a 00  
            sec                                      ; $ee45: 38        
            sbc Player1Y,x                           ; $ee46: f5 9a     
            jsr __f08e                               ; $ee48: 20 8e f0  
            cmp #$18                                 ; $ee4b: c9 18     
            bcs __eec0                               ; $ee4d: b0 71     
            lda Player1Y,x                           ; $ee4f: b5 9a     
            clc                                      ; $ee51: 18        
            adc #$18                                 ; $ee52: 69 18     
            sta BytesLeftToLoad                      ; $ee54: 85 12     
            lda $009a,y                              ; $ee56: b9 9a 00  
            clc                                      ; $ee59: 18        
            adc #$07                                 ; $ee5a: 69 07     
            sec                                      ; $ee5c: 38        
            sbc BytesLeftToLoad                      ; $ee5d: e5 12     
            jsr __f08e                               ; $ee5f: 20 8e f0  
            cmp #$04                                 ; $ee62: c9 04     
            bcs __ee6a                               ; $ee64: b0 04     
            lda #$01                                 ; $ee66: a9 01     
            bne __ee7c                               ; $ee68: d0 12     
__ee6a:     lda $009a,y                              ; $ee6a: b9 9a 00  
            clc                                      ; $ee6d: 18        
            adc #$11                                 ; $ee6e: 69 11     
            sec                                      ; $ee70: 38        
            sbc Player1Y,x                           ; $ee71: f5 9a     
            jsr __f08e                               ; $ee73: 20 8e f0  
            cmp #$04                                 ; $ee76: c9 04     
            bcs __ee8f                               ; $ee78: b0 15     
            lda #$02                                 ; $ee7a: a9 02     
__ee7c:     sta $cc                                  ; $ee7c: 85 cc     
            lda $0091,y                              ; $ee7e: b9 91 00  
            sec                                      ; $ee81: 38        
            sbc Player1X,x                           ; $ee82: f5 91     
            jsr __f08e                               ; $ee84: 20 8e f0  
            cmp #$10                                 ; $ee87: c9 10     
            bcc __ee8f                               ; $ee89: 90 04     
            lda #$00                                 ; $ee8b: a9 00     
            sta $cc                                  ; $ee8d: 85 cc     
__ee8f:     lda Player1X,x                           ; $ee8f: b5 91     
            clc                                      ; $ee91: 18        
            adc #$10                                 ; $ee92: 69 10     
            sta BytesLeftToLoad                      ; $ee94: 85 12     
            lda $0091,y                              ; $ee96: b9 91 00  
            clc                                      ; $ee99: 18        
            adc #$07                                 ; $ee9a: 69 07     
            sec                                      ; $ee9c: 38        
            sbc BytesLeftToLoad                      ; $ee9d: e5 12     
            jsr __f08e                               ; $ee9f: 20 8e f0  
            cmp #$04                                 ; $eea2: c9 04     
            bcs __eeaa                               ; $eea4: b0 04     
            lda #$04                                 ; $eea6: a9 04     
            bne __eebc                               ; $eea8: d0 12     
__eeaa:     lda $0091,y                              ; $eeaa: b9 91 00  
            clc                                      ; $eead: 18        
            adc #$09                                 ; $eeae: 69 09     
            sec                                      ; $eeb0: 38        
            sbc Player1X,x                           ; $eeb1: f5 91     
            jsr __f08e                               ; $eeb3: 20 8e f0  
            cmp #$04                                 ; $eeb6: c9 04     
            bcs __eec0                               ; $eeb8: b0 06     
            lda #$08                                 ; $eeba: a9 08     
__eebc:     ora $cc                                  ; $eebc: 05 cc     
            sta $cc                                  ; $eebe: 85 cc     
__eec0:     lda #$00                                 ; $eec0: a9 00     
            sta $4b                                  ; $eec2: 85 4b     
            lsr $cc                                  ; $eec4: 46 cc     
            bcc __eecd                               ; $eec6: 90 05     
            jsr __f0a6                               ; $eec8: 20 a6 f0  
            bmi __eed6                               ; $eecb: 30 09     
__eecd:     lsr $cc                                  ; $eecd: 46 cc     
            bcc __eef1                               ; $eecf: 90 20     
            jsr __f0a6                               ; $eed1: 20 a6 f0  
            bmi __eef1                               ; $eed4: 30 1b     
__eed6:     jsr __f0bd                               ; $eed6: 20 bd f0  
            bcs __eeed                               ; $eed9: b0 12     
            jsr __f107                               ; $eedb: 20 07 f1  
            jsr __f18c                               ; $eede: 20 8c f1  
            jsr __f0b4                               ; $eee1: 20 b4 f0  
            jsr __f107                               ; $eee4: 20 07 f1  
            jsr __f18c                               ; $eee7: 20 8c f1  
            jsr __f0b4                               ; $eeea: 20 b4 f0  
__eeed:     lda #$01                                 ; $eeed: a9 01     
            sta $4b                                  ; $eeef: 85 4b     
__eef1:     lsr $cc                                  ; $eef1: 46 cc     
            bcc __eefa                               ; $eef3: 90 05     
            jsr __f098                               ; $eef5: 20 98 f0  
            bmi __ef03                               ; $eef8: 30 09     
__eefa:     lsr $cc                                  ; $eefa: 46 cc     
            bcc __ef1e                               ; $eefc: 90 20     
            jsr __f098                               ; $eefe: 20 98 f0  
            bmi __ef1e                               ; $ef01: 30 1b     
__ef03:     jsr __f0bd                               ; $ef03: 20 bd f0  
            bcs __ef1a                               ; $ef06: b0 12     
            jsr __f0de                               ; $ef08: 20 de f0  
            jsr __f172                               ; $ef0b: 20 72 f1  
            jsr __f0b4                               ; $ef0e: 20 b4 f0  
            jsr __f0de                               ; $ef11: 20 de f0  
            jsr __f172                               ; $ef14: 20 72 f1  
            jsr __f0b4                               ; $ef17: 20 b4 f0  
__ef1a:     lda #$01                                 ; $ef1a: a9 01     
            sta $4b                                  ; $ef1c: 85 4b     
__ef1e:     jsr __ef37                               ; $ef1e: 20 37 ef  
            jsr __f0b4                               ; $ef21: 20 b4 f0  
            jsr __ef37                               ; $ef24: 20 37 ef  
            jsr __f0b4                               ; $ef27: 20 b4 f0  
__ef2a:     dey                                      ; $ef2a: 88        
            bmi __ef30                               ; $ef2b: 30 03     
            jmp __ee31                               ; $ef2d: 4c 31 ee  

;-------------------------------------------------------------------------------
__ef30:     dex                                      ; $ef30: ca        
            bmi __ef36                               ; $ef31: 30 03     
            jmp __ee27                               ; $ef33: 4c 27 ee  

;-------------------------------------------------------------------------------
__ef36:     rts                                      ; $ef36: 60        

;-------------------------------------------------------------------------------
__ef37:     cpx #$02                                 ; $ef37: e0 02     
            bcc __ef42                               ; $ef39: 90 07     
            cpy #$02                                 ; $ef3b: c0 02     
            bcc __ef42                               ; $ef3d: 90 03     
            jmp __f043                               ; $ef3f: 4c 43 f0  

;-------------------------------------------------------------------------------
__ef42:     lda #$00                                 ; $ef42: a9 00     
            sta $0487                                ; $ef44: 8d 87 04  
            lda $0475,x                              ; $ef47: bd 75 04  
            beq __ef4f                               ; $ef4a: f0 03     
            jmp __f043                               ; $ef4c: 4c 43 f0  

;-------------------------------------------------------------------------------
__ef4f:     lda $4b                                  ; $ef4f: a5 4b     
            bne __ef56                               ; $ef51: d0 03     
            jmp __f043                               ; $ef53: 4c 43 f0  

;-------------------------------------------------------------------------------
__ef56:     cpx #$02                                 ; $ef56: e0 02     
            bcs __ef61                               ; $ef58: b0 07     
            lda Player1Invincible,x                  ; $ef5a: b5 bd     
            beq __ef72                               ; $ef5c: f0 14     
            jmp __f043                               ; $ef5e: 4c 43 f0  

;-------------------------------------------------------------------------------
__ef61:     lda Player1Ballons,x                     ; $ef61: b5 88     
            cmp #$01                                 ; $ef63: c9 01     
            bne __ef72                               ; $ef65: d0 0b     
            lda $7f,x                                ; $ef67: b5 7f     
            cmp #$02                                 ; $ef69: c9 02     
            bcs __ef7f                               ; $ef6b: b0 12     
            lda #$01                                 ; $ef6d: a9 01     
            sta $0487                                ; $ef6f: 8d 87 04  
__ef72:     lda $009a,y                              ; $ef72: b9 9a 00  
            clc                                      ; $ef75: 18        
            adc #$04                                 ; $ef76: 69 04     
            cmp Player1Y,x                           ; $ef78: d5 9a     
            bcc __ef7f                               ; $ef7a: 90 03     
            jmp __f043                               ; $ef7c: 4c 43 f0  

;-------------------------------------------------------------------------------
__ef7f:     lda #$14                                 ; $ef7f: a9 14     
            sta $0475,x                              ; $ef81: 9d 75 04  
            lda #$00                                 ; $ef84: a9 00     
            sta $0436,x                              ; $ef86: 9d 36 04  
            cpy #$02                                 ; $ef89: c0 02     
            bcc __ef97                               ; $ef8b: 90 0a     
            lda $0088,y                              ; $ef8d: b9 88 00  
            cmp #$02                                 ; $ef90: c9 02     
            beq __ef97                               ; $ef92: f0 03     
            jmp __f043                               ; $ef94: 4c 43 f0  

;-------------------------------------------------------------------------------
__ef97:     lda $f0                                  ; $ef97: a5 f0     
            ora #$02                                 ; $ef99: 09 02     
            sta $f0                                  ; $ef9b: 85 f0     
            lda Player1Ballons,x                     ; $ef9d: b5 88     
            cmp #$02                                 ; $ef9f: c9 02     
            bne __efc0                               ; $efa1: d0 1d     
            cpx #$02                                 ; $efa3: e0 02     
            bcs __efc0                               ; $efa5: b0 19     
            sty BytesLeftToLoad                      ; $efa7: 84 12     
            ldy $7f,x                                ; $efa9: b4 7f     
            lda __f053,y                             ; $efab: b9 53 f0  
            ldy BytesLeftToLoad                      ; $efae: a4 12     
            pha                                      ; $efb0: 48        
            pla                                      ; $efb1: 68        
            bne __efb7                               ; $efb2: d0 03     
            jmp __f043                               ; $efb4: 4c 43 f0  

;-------------------------------------------------------------------------------
__efb7:     sta $7f,x                                ; $efb7: 95 7f     
            lda #$00                                 ; $efb9: a9 00     
            sta $0436,x                              ; $efbb: 9d 36 04  
            beq __efea                               ; $efbe: f0 2a     
__efc0:     dec Player1Ballons,x                     ; $efc0: d6 88     
            bne __efce                               ; $efc2: d0 0a     
            lda #$ff                                 ; $efc4: a9 ff     
            sta $041b,x                              ; $efc6: 9d 1b 04  
            lda #$00                                 ; $efc9: a9 00     
            sta $0412,x                              ; $efcb: 9d 12 04  
__efce:     lda #$00                                 ; $efce: a9 00     
            sta $7f,x                                ; $efd0: 95 7f     
            sta $0424,x                              ; $efd2: 9d 24 04  
            sta $042d,x                              ; $efd5: 9d 2d 04  
            lda Player1X,x                           ; $efd8: b5 91     
            bmi __efe0                               ; $efda: 30 04     
            lda #$ff                                 ; $efdc: a9 ff     
            bne __efe2                               ; $efde: d0 02     
__efe0:     lda #$00                                 ; $efe0: a9 00     
__efe2:     sta $046c,x                              ; $efe2: 9d 6c 04  
            lda #$80                                 ; $efe5: a9 80     
            sta $0463,x                              ; $efe7: 9d 63 04  
__efea:     sty BytesLeftToLoad                      ; $efea: 84 12     
            ldy Player1State,x                       ; $efec: bc 51 04  
            lda __f05e,y                             ; $efef: b9 5e f0  
            sta Player1State,x                       ; $eff2: 9d 51 04  
            lda #$01                                 ; $eff5: a9 01     
            sta $047e,x                              ; $eff7: 9d 7e 04  
            ldy BytesLeftToLoad                      ; $effa: a4 12     
            cpy #$02                                 ; $effc: c0 02     
            bcs __f043                               ; $effe: b0 43     
            lda Player1State,x                       ; $f000: bd 51 04  
            cmp #$07                                 ; $f003: c9 07     
            beq __f011                               ; $f005: f0 0a     
            cmp #$08                                 ; $f007: c9 08     
            bcc __f011                               ; $f009: 90 06     
            lda $f1                                  ; $f00b: a5 f1     
            ora #$80                                 ; $f00d: 09 80     
            sta $f1                                  ; $f00f: 85 f1     
__f011:     ldy Player1State,x                       ; $f011: bc 51 04  
            lda __f06a,y                             ; $f014: b9 6a f0  
            sta $13                                  ; $f017: 85 13     
            lda $0487                                ; $f019: ad 87 04  
            beq __f023                               ; $f01c: f0 05     
            lda __f076,y                             ; $f01e: b9 76 f0  
            sta $13                                  ; $f021: 85 13     
__f023:     lda __f082,y                             ; $f023: b9 82 f0  
            clc                                      ; $f026: 18        
            adc $0487                                ; $f027: 6d 87 04  
            sta $14                                  ; $f02a: 85 14     
            lda BytesLeftToLoad                      ; $f02c: a5 12     
            sta $3e                                  ; $f02e: 85 3e     
            pha                                      ; $f030: 48        
            txa                                      ; $f031: 8a        
            pha                                      ; $f032: 48        
            lda $13                                  ; $f033: a5 13     
            pha                                      ; $f035: 48        
            lda $14                                  ; $f036: a5 14     
            jsr __d871                               ; $f038: 20 71 d8  
            pla                                      ; $f03b: 68        
            jsr __d6de                               ; $f03c: 20 de d6  
            pla                                      ; $f03f: 68        
            tax                                      ; $f040: aa        
            pla                                      ; $f041: 68        
            tay                                      ; $f042: a8        
__f043:     lda Player1State,x                       ; $f043: bd 51 04  
            cmp #$0b                                 ; $f046: c9 0b     
            bne __f052                               ; $f048: d0 08     
            lda IsBonusPhase                         ; $f04a: a5 c8     
            bne __f052                               ; $f04c: d0 04     
            lda #$20                                 ; $f04e: a9 20     
            sta $f0                                  ; $f050: 85 f0     
__f052:     rts                                      ; $f052: 60        

;-------------------------------------------------------------------------------
__f053:     .hex 06 06 07 08                         ; $f053: 06 06 07 08   Data
            .hex 09 0a 00 00                         ; $f057: 09 0a 00 00   Data
            .hex 00 00 00                            ; $f05b: 00 00 00      Data
__f05e:     .hex 04 05 06 07                         ; $f05e: 04 05 06 07   Data
            .hex 08 09 0a 0b                         ; $f062: 08 09 0a 0b   Data
            .hex 08 09 0a 0b                         ; $f066: 08 09 0a 0b   Data
__f06a:     .hex 00 00 00 00                         ; $f06a: 00 00 00 00   Data
            .hex 32 4b 64 64                         ; $f06e: 32 4b 64 64   Data
            .hex 4b 64 96 64                         ; $f072: 4b 64 96 64   Data
__f076:     .hex 00 00 00 00                         ; $f076: 00 00 00 00   Data
            .hex 32 4b 64 64                         ; $f07a: 32 4b 64 64   Data
            .hex 64 96 c8 64                         ; $f07e: 64 96 c8 64   Data
__f082:     .hex 00 00 00 00                         ; $f082: 00 00 00 00   Data
            .hex 01 02 03 03                         ; $f086: 01 02 03 03   Data
            .hex 02 03 04 03                         ; $f08a: 02 03 04 03   Data

;-------------------------------------------------------------------------------
__f08e:     pha                                      ; $f08e: 48        
            pla                                      ; $f08f: 68        
            bpl __f097                               ; $f090: 10 05     
            eor #$ff                                 ; $f092: 49 ff     
            clc                                      ; $f094: 18        
            adc #$01                                 ; $f095: 69 01     
__f097:     rts                                      ; $f097: 60        

;-------------------------------------------------------------------------------
__f098:     lda $0424,y                              ; $f098: b9 24 04  
            sec                                      ; $f09b: 38        
            sbc $0424,x                              ; $f09c: fd 24 04  
            lda $042d,y                              ; $f09f: b9 2d 04  
            sbc $042d,x                              ; $f0a2: fd 2d 04  
            rts                                      ; $f0a5: 60        

;-------------------------------------------------------------------------------
__f0a6:     lda $0412,y                              ; $f0a6: b9 12 04  
            sec                                      ; $f0a9: 38        
            sbc $0412,x                              ; $f0aa: fd 12 04  
            lda $041b,y                              ; $f0ad: b9 1b 04  
            sbc $041b,x                              ; $f0b0: fd 1b 04  
            rts                                      ; $f0b3: 60        

;-------------------------------------------------------------------------------
__f0b4:     stx BytesLeftToLoad                      ; $f0b4: 86 12     
            sty $13                                  ; $f0b6: 84 13     
            ldx $13                                  ; $f0b8: a6 13     
            ldy BytesLeftToLoad                      ; $f0ba: a4 12     
            rts                                      ; $f0bc: 60        

;-------------------------------------------------------------------------------
__f0bd:     cpx #$02                                 ; $f0bd: e0 02     
            bcc __f0dd                               ; $f0bf: 90 1c     
            lda $7f,x                                ; $f0c1: b5 7f     
            cmp #$02                                 ; $f0c3: c9 02     
            bcc __f0dd                               ; $f0c5: 90 16     
            lda #$01                                 ; $f0c7: a9 01     
            cmp Player1Ballons,x                     ; $f0c9: d5 88     
            bcs __f0dd                               ; $f0cb: b0 10     
            cpy #$02                                 ; $f0cd: c0 02     
            bcc __f0dd                               ; $f0cf: 90 0c     
            lda $007f,y                              ; $f0d1: b9 7f 00  
            cmp #$02                                 ; $f0d4: c9 02     
            bcc __f0dd                               ; $f0d6: 90 05     
            lda #$01                                 ; $f0d8: a9 01     
            cmp $0088,y                              ; $f0da: d9 88 00  
__f0dd:     rts                                      ; $f0dd: 60        

;-------------------------------------------------------------------------------
__f0de:     lda #$00                                 ; $f0de: a9 00     
            sec                                      ; $f0e0: 38        
            sbc $0424,x                              ; $f0e1: fd 24 04  
            sta $0424,x                              ; $f0e4: 9d 24 04  
            lda #$00                                 ; $f0e7: a9 00     
            sbc $042d,x                              ; $f0e9: fd 2d 04  
            sta $042d,x                              ; $f0ec: 9d 2d 04  
            lda #$00                                 ; $f0ef: a9 00     
            sec                                      ; $f0f1: 38        
            sbc $0463,x                              ; $f0f2: fd 63 04  
            sta $0463,x                              ; $f0f5: 9d 63 04  
            lda #$00                                 ; $f0f8: a9 00     
            sbc $046c,x                              ; $f0fa: fd 6c 04  
            sta $046c,x                              ; $f0fd: 9d 6c 04  
            lda $31,x                                ; $f100: b5 31     
            and #$40                                 ; $f102: 29 40     
            sta $31,x                                ; $f104: 95 31     
            rts                                      ; $f106: 60        

;-------------------------------------------------------------------------------
__f107:     lda #$00                                 ; $f107: a9 00     
            sec                                      ; $f109: 38        
            sbc $0412,x                              ; $f10a: fd 12 04  
            sta $0412,x                              ; $f10d: 9d 12 04  
            lda #$00                                 ; $f110: a9 00     
            sbc $041b,x                              ; $f112: fd 1b 04  
            sta $041b,x                              ; $f115: 9d 1b 04  
            rts                                      ; $f118: 60        

;-------------------------------------------------------------------------------
__f119:     sta $2d                                  ; $f119: 85 2d     
            lda $2c                                  ; $f11b: a5 2c     
            bpl __f143                               ; $f11d: 10 24     
            lda #$00                                 ; $f11f: a9 00     
            sec                                      ; $f121: 38        
            sbc $2b                                  ; $f122: e5 2b     
            sta $2b                                  ; $f124: 85 2b     
            lda #$00                                 ; $f126: a9 00     
            sbc $2c                                  ; $f128: e5 2c     
            sta $2c                                  ; $f12a: 85 2c     
            jsr __f143                               ; $f12c: 20 43 f1  
            lda #$00                                 ; $f12f: a9 00     
            sec                                      ; $f131: 38        
            sbc $2e                                  ; $f132: e5 2e     
            sta $2e                                  ; $f134: 85 2e     
            lda #$00                                 ; $f136: a9 00     
            sbc $2f                                  ; $f138: e5 2f     
            sta $2f                                  ; $f13a: 85 2f     
            lda #$00                                 ; $f13c: a9 00     
            sbc $30                                  ; $f13e: e5 30     
            sta $30                                  ; $f140: 85 30     
            rts                                      ; $f142: 60        

;-------------------------------------------------------------------------------
__f143:     txa                                      ; $f143: 8a        
            pha                                      ; $f144: 48        
            lda #$00                                 ; $f145: a9 00     
            sta $2e                                  ; $f147: 85 2e     
            sta $2f                                  ; $f149: 85 2f     
            sta $30                                  ; $f14b: 85 30     
            ldx #$08                                 ; $f14d: a2 08     
__f14f:     asl $2e                                  ; $f14f: 06 2e     
            rol $2f                                  ; $f151: 26 2f     
            rol $30                                  ; $f153: 26 30     
            asl $2d                                  ; $f155: 06 2d     
            bcc __f16c                               ; $f157: 90 13     
            clc                                      ; $f159: 18        
            lda $2b                                  ; $f15a: a5 2b     
            adc $2e                                  ; $f15c: 65 2e     
            sta $2e                                  ; $f15e: 85 2e     
            lda $2c                                  ; $f160: a5 2c     
            adc $2f                                  ; $f162: 65 2f     
            sta $2f                                  ; $f164: 85 2f     
            lda #$00                                 ; $f166: a9 00     
            adc $30                                  ; $f168: 65 30     
            sta $30                                  ; $f16a: 85 30     
__f16c:     dex                                      ; $f16c: ca        
            bne __f14f                               ; $f16d: d0 e0     
            pla                                      ; $f16f: 68        
            tax                                      ; $f170: aa        
            rts                                      ; $f171: 60        

;-------------------------------------------------------------------------------
__f172:     lda $0424,x                              ; $f172: bd 24 04  
            sta $2b                                  ; $f175: 85 2b     
            lda $042d,x                              ; $f177: bd 2d 04  
            sta $2c                                  ; $f17a: 85 2c     
            lda #$cd                                 ; $f17c: a9 cd     
            jsr __f119                               ; $f17e: 20 19 f1  
            lda $2f                                  ; $f181: a5 2f     
            sta $0424,x                              ; $f183: 9d 24 04  
            lda $30                                  ; $f186: a5 30     
            sta $042d,x                              ; $f188: 9d 2d 04  
            rts                                      ; $f18b: 60        

;-------------------------------------------------------------------------------
__f18c:     lda $0412,x                              ; $f18c: bd 12 04  
            sta $2b                                  ; $f18f: 85 2b     
            lda $041b,x                              ; $f191: bd 1b 04  
            sta $2c                                  ; $f194: 85 2c     
            lda #$cd                                 ; $f196: a9 cd     
            jsr __f119                               ; $f198: 20 19 f1  
            lda $2f                                  ; $f19b: a5 2f     
            sta $0412,x                              ; $f19d: 9d 12 04  
            lda $30                                  ; $f1a0: a5 30     
            sta $041b,x                              ; $f1a2: 9d 1b 04  
            rts                                      ; $f1a5: 60        

;-------------------------------------------------------------------------------
__f1a6:     ldy #$04                                 ; $f1a6: a0 04     
__f1a8:     lda $13                                  ; $f1a8: a5 13     
            asl                                      ; $f1aa: 0a        
            ror $13                                  ; $f1ab: 66 13     
            ror BytesLeftToLoad                      ; $f1ad: 66 12     
            dey                                      ; $f1af: 88        
            bne __f1a8                               ; $f1b0: d0 f6     
            rts                                      ; $f1b2: 60        

;-------------------------------------------------------------------------------
__f1b3:     txa                                      ; $f1b3: 8a        
            pha                                      ; $f1b4: 48        
            ldx #$0b                                 ; $f1b5: a2 0b     
__f1b7:     asl $1b                                  ; $f1b7: 06 1b     
            rol $1c                                  ; $f1b9: 26 1c     
            rol                                      ; $f1bb: 2a        
            rol                                      ; $f1bc: 2a        
            eor $1b                                  ; $f1bd: 45 1b     
            rol                                      ; $f1bf: 2a        
            eor $1b                                  ; $f1c0: 45 1b     
            lsr                                      ; $f1c2: 4a        
            lsr                                      ; $f1c3: 4a        
            eor #$ff                                 ; $f1c4: 49 ff     
            and #$01                                 ; $f1c6: 29 01     
            ora $1b                                  ; $f1c8: 05 1b     
            sta $1b                                  ; $f1ca: 85 1b     
            dex                                      ; $f1cc: ca        
            bne __f1b7                               ; $f1cd: d0 e8     
            pla                                      ; $f1cf: 68        
            tax                                      ; $f1d0: aa        
            lda $1b                                  ; $f1d1: a5 1b     
            rts                                      ; $f1d3: 60        

;-------------------------------------------------------------------------------
__f1d4:     jsr __dac1                               ; $f1d4: 20 c1 da  
            ldx #$09                                 ; $f1d7: a2 09     
__f1d9:     lda #$00                                 ; $f1d9: a9 00     
            sta $03,x                                ; $f1db: 95 03     
            dex                                      ; $f1dd: ca        
            bpl __f1d9                               ; $f1de: 10 f9     
            sta $3e                                  ; $f1e0: 85 3e     
            inc Player1Lives                         ; $f1e2: e6 41     
            jsr __d6de                               ; $f1e4: 20 de d6  
            lda #$0f                                 ; $f1e7: a9 0f     
            sta $4015                                ; $f1e9: 8d 15 40  
            lda #$01                                 ; $f1ec: a9 01     
            sta $f0                                  ; $f1ee: 85 f0     
            lda #$02                                 ; $f1f0: a9 02     
__f1f2:     sta Player1Lives                         ; $f1f2: 85 41     
            ldy NumberOfPlayers                      ; $f1f4: a4 40     
            bne __f1fa                               ; $f1f6: d0 02     
            lda #$ff                                 ; $f1f8: a9 ff     
__f1fa:     sta Player2Lives                         ; $f1fa: 85 42     
            ldx #$00                                 ; $f1fc: a2 00     
            stx $0488                                ; $f1fe: 8e 88 04  
            stx CurrentLevelHeaderPtr                ; $f201: 86 3b     
            stx CurrentPhaseCount                    ; $f203: 86 3c     
            stx BonusPhaseIntensityLevel             ; $f205: 8e 58 05  
            dex                                      ; $f208: ca        
            stx Player2Ballons                       ; $f209: 86 89     
            ldx NumberOfPlayers                      ; $f20b: a6 40     
__f20d:     jsr __f3b0                               ; $f20d: 20 b0 f3  
            dex                                      ; $f210: ca        
            bpl __f20d                               ; $f211: 10 fa     
__f213:     lda #$00                                 ; $f213: a9 00     
            sta IsBonusPhase                         ; $f215: 85 c8     
            lda CurrentPhaseCount                    ; $f217: a5 3c     
            lsr                                      ; $f219: 4a        
            lsr                                      ; $f21a: 4a        
            cmp #$08                                 ; $f21b: c9 08     
            bcc __f221                               ; $f21d: 90 02     
            lda #$08                                 ; $f21f: a9 08     
__f221:     tax                                      ; $f221: aa        
            lda __f3ba,x                             ; $f222: bd ba f3  
            sta $c6                                  ; $f225: 85 c6     
            lda __f3c3,x                             ; $f227: bd c3 f3  
            sta $c7                                  ; $f22a: 85 c7     
            lda CurrentPhaseCount                    ; $f22c: a5 3c     
            cmp #$02                                 ; $f22e: c9 02     
            bcs __f238                               ; $f230: b0 06     
            lda #$03                                 ; $f232: a9 03     
            sta $c6                                  ; $f234: 85 c6     
            sta $c7                                  ; $f236: 85 c7     
__f238:     ldx #$07                                 ; $f238: a2 07     
__f23a:     lda #$00                                 ; $f23a: a9 00     
            sta $0448,x                              ; $f23c: 9d 48 04  
            sta $0475,x                              ; $f23f: 9d 75 04  
            sta $047e,x                              ; $f242: 9d 7e 04  
            sta $0424,x                              ; $f245: 9d 24 04  
            sta $042d,x                              ; $f248: 9d 2d 04  
            sta $0412,x                              ; $f24b: 9d 12 04  
            sta $041b,x                              ; $f24e: 9d 1b 04  
            sta $0463,x                              ; $f251: 9d 63 04  
            sta $046c,x                              ; $f254: 9d 6c 04  
            sta $0400,x                              ; $f257: 9d 00 04  
            sta $0409,x                              ; $f25a: 9d 09 04  
            lda #$01                                 ; $f25d: a9 01     
            sta $043f,x                              ; $f25f: 9d 3f 04  
            sta $045a,x                              ; $f262: 9d 5a 04  
            lda #$03                                 ; $f265: a9 03     
            sta $0436,x                              ; $f267: 9d 36 04  
            dex                                      ; $f26a: ca        
            bpl __f23a                               ; $f26b: 10 cd     
            ldx #$05                                 ; $f26d: a2 05     
__f26f:     lda #$ff                                 ; $f26f: a9 ff     
            sta $8a,x                                ; $f271: 95 8a     
            dex                                      ; $f273: ca        
            bpl __f26f                               ; $f274: 10 f9     
            ldx NumberOfPlayers                      ; $f276: a6 40     
__f278:     jsr __f386                               ; $f278: 20 86 f3  
            dex                                      ; $f27b: ca        
            bpl __f278                               ; $f27c: 10 fa     
            jsr __d246                               ; $f27e: 20 46 d2  
            jsr __d293                               ; $f281: 20 93 d2  
            lda $c6                                  ; $f284: a5 c6     
            cmp #$10                                 ; $f286: c9 10     
            bcs __f28e                               ; $f288: b0 04     
            lda #$58                                 ; $f28a: a9 58     
            sta $c6                                  ; $f28c: 85 c6     
__f28e:     jsr __f4a5                               ; $f28e: 20 a5 f4  
            jsr __d8ff                               ; $f291: 20 ff d8  
            lda $16                                  ; $f294: a5 16     
            beq __f29b                               ; $f296: f0 03     
            jmp __c1c5                               ; $f298: 4c c5 c1  

;-------------------------------------------------------------------------------
__f29b:     lda IsBonusPhase                         ; $f29b: a5 c8     
            beq __f2a2                               ; $f29d: f0 03     
            jmp __cf13                               ; $f29f: 4c 13 cf  

;-------------------------------------------------------------------------------
__f2a2:     jsr __c716                               ; $f2a2: 20 16 c7  
            lda CurrentLevelHeaderPtr                ; $f2a5: a5 3b     
            and #$03                                 ; $f2a7: 29 03     
            bne __f2b3                               ; $f2a9: d0 08     
            lda #$08                                 ; $f2ab: a9 08     
            sta CurrentMusic                         ; $f2ad: 85 f2     
            ldx $3a                                  ; $f2af: a6 3a     
            bne __f2b9                               ; $f2b1: d0 06     
__f2b3:     lda #$ff                                 ; $f2b3: a9 ff     
            sta $3d                                  ; $f2b5: 85 3d     
            inc CurrentPhaseCount                    ; $f2b7: e6 3c     
__f2b9:     jsr __f470                               ; $f2b9: 20 70 f4  
            lda $3d                                  ; $f2bc: a5 3d     
            beq __f2c5                               ; $f2be: f0 05     
            dec $3d                                  ; $f2c0: c6 3d     
            jsr __f3cc                               ; $f2c2: 20 cc f3  
__f2c5:     jsr __f1b3                               ; $f2c5: 20 b3 f1  
            jsr __e691                               ; $f2c8: 20 91 e6  
            jsr __c6f9                               ; $f2cb: 20 f9 c6  
            jsr __c790                               ; $f2ce: 20 90 c7  
            jsr __c831                               ; $f2d1: 20 31 c8  
            jsr __c8b7                               ; $f2d4: 20 b7 c8  
            jsr __d8dd                               ; $f2d7: 20 dd d8  
            jsr __e587                               ; $f2da: 20 87 e5  
            jsr __cb74                               ; $f2dd: 20 74 cb  
            inc $4c                                  ; $f2e0: e6 4c     
            ldx NumberOfPlayers                      ; $f2e2: a6 40     
__f2e4:     lda Player1Ballons,x                     ; $f2e4: b5 88     
            bpl __f30d                               ; $f2e6: 10 25     
            lda $3a                                  ; $f2e8: a5 3a     
            bne __f326                               ; $f2ea: d0 3a     
            lda Player1Lives,x                       ; $f2ec: b5 41     
            bmi __f30d                               ; $f2ee: 30 1d     
            dec $c3,x                                ; $f2f0: d6 c3     
            bne __f327                               ; $f2f2: d0 33     
            txa                                      ; $f2f4: 8a        
            pha                                      ; $f2f5: 48        
            jsr __c726                               ; $f2f6: 20 26 c7  
            pla                                      ; $f2f9: 68        
            tax                                      ; $f2fa: aa        
            ldy #$02                                 ; $f2fb: a0 02     
            dec Player1Lives,x                       ; $f2fd: d6 41     
            sty $46                                  ; $f2ff: 84 46     
            bmi __f30d                               ; $f301: 30 0a     
            jsr __f386                               ; $f303: 20 86 f3  
            jsr __f3b0                               ; $f306: 20 b0 f3  
            lda #$80                                 ; $f309: a9 80     
            sta CurrentMusic                         ; $f30b: 85 f2     
__f30d:     dex                                      ; $f30d: ca        
            bpl __f2e4                               ; $f30e: 10 d4     
            lda Player1Lives                         ; $f310: a5 41     
            bpl __f318                               ; $f312: 10 04     
            lda Player2Lives                         ; $f314: a5 42     
            bmi __f366                               ; $f316: 30 4e     
__f318:     lda $3a                                  ; $f318: a5 3a     
            beq __f327                               ; $f31a: f0 0b     
            jsr __e768                               ; $f31c: 20 68 e7  
            lda $061c                                ; $f31f: ad 1c 06  
            and #$30                                 ; $f322: 29 30     
            beq __f2b9                               ; $f324: f0 93     
__f326:     rts                                      ; $f326: 60        

;-------------------------------------------------------------------------------
__f327:     ldx #$05                                 ; $f327: a2 05     
__f329:     lda $8a,x                                ; $f329: b5 8a     
            beq __f32f                               ; $f32b: f0 02     
            bpl __f2b9                               ; $f32d: 10 8a     
__f32f:     dex                                      ; $f32f: ca        
            bpl __f329                               ; $f330: 10 f7     
            lda $bb                                  ; $f332: a5 bb     
            bpl __f2b9                               ; $f334: 10 83     
            ldx NumberOfPlayers                      ; $f336: a6 40     
__f338:     ldy Player1Ballons,x                     ; $f338: b4 88     
            dey                                      ; $f33a: 88        
            bpl __f34c                               ; $f33b: 10 0f     
            lda Player1Lives,x                       ; $f33d: b5 41     
            bmi __f34c                               ; $f33f: 30 0b     
            lda #$ff                                 ; $f341: a9 ff     
            sta Player1Ballons,x                     ; $f343: 95 88     
            lda #$01                                 ; $f345: a9 01     
            sta $c3,x                                ; $f347: 95 c3     
            jmp __f2b9                               ; $f349: 4c b9 f2  

;-------------------------------------------------------------------------------
__f34c:     dex                                      ; $f34c: ca        
            bpl __f338                               ; $f34d: 10 e9     
            lda #$02                                 ; $f34f: a9 02     
            sta CurrentMusic                         ; $f351: 85 f2     
__f353:     ldx #$96                                 ; $f353: a2 96     
            jsr __f45e                               ; $f355: 20 5e f4  
            ldx CurrentLevelHeaderPtr                ; $f358: a6 3b     
            inx                                      ; $f35a: e8        
            cpx #$10                                 ; $f35b: e0 10     
            bne __f361                               ; $f35d: d0 02     
            ldx #$04                                 ; $f35f: a2 04     
__f361:     stx CurrentLevelHeaderPtr                ; $f361: 86 3b     
            jmp __f213                               ; $f363: 4c 13 f2  

;-------------------------------------------------------------------------------
__f366:     lda #$01                                 ; $f366: a9 01     
            sta CurrentMusic                         ; $f368: 85 f2     
__f36a:     lda #$00                                 ; $f36a: a9 00     
            sta $17                                  ; $f36c: 85 17     
            sta $18                                  ; $f36e: 85 18     
            sta $15                                  ; $f370: 85 15     
            jsr __f40b                               ; $f372: 20 0b f4  
__f375:     jsr __f465                               ; $f375: 20 65 f4  
            jsr __e768                               ; $f378: 20 68 e7  
            and #$30                                 ; $f37b: 29 30     
            bne __f383                               ; $f37d: d0 04     
            dec $15                                  ; $f37f: c6 15     
            bne __f375                               ; $f381: d0 f2     
__f383:     jmp __f1d4                               ; $f383: 4c d4 f1  

;-------------------------------------------------------------------------------
__f386:     lda Player1Lives,x                       ; $f386: b5 41     
            bmi __f3ad                               ; $f388: 30 23     
            lda PlayerStartPositionX,x               ; $f38a: bd ae f3  
            sta Player1X,x                           ; $f38d: 95 91     
            lda #$b8                                 ; $f38f: a9 b8     
            sta Player1Y,x                           ; $f391: 95 9a     
            sta Player1Invincible,x                  ; $f393: 95 bd     
            lda #$c8                                 ; $f395: a9 c8     
            sta Player1InvincibleFlash,x             ; $f397: 95 bf     
            lda #$5a                                 ; $f399: a9 5a     
            ldy Player1Lives,x                       ; $f39b: b4 41     
            bpl __f3a1                               ; $f39d: 10 02     
            lda #$01                                 ; $f39f: a9 01     
__f3a1:     sta $c3,x                                ; $f3a1: 95 c3     
            lda #$00                                 ; $f3a3: a9 00     
            sta $c1,x                                ; $f3a5: 95 c1     
            sta $042d,x                              ; $f3a7: 9d 2d 04  
            sta $0424,x                              ; $f3aa: 9d 24 04  
__f3ad:     rts                                      ; $f3ad: 60        

;-------------------------------------------------------------------------------
PlayerStartPositionX:
            .hex 20 d0                               ; $f3ae: 20 d0         Data

;-------------------------------------------------------------------------------
__f3b0:     lda #$03                                 ; $f3b0: a9 03     
            sta Player1State,x                       ; $f3b2: 9d 51 04  
            lda #$02                                 ; $f3b5: a9 02     
            sta Player1Ballons,x                     ; $f3b7: 95 88     
            rts                                      ; $f3b9: 60        

;-------------------------------------------------------------------------------
__f3ba:     .hex 58 50 58 50                         ; $f3ba: 58 50 58 50   Data
            .hex 50 40 38 30                         ; $f3be: 50 40 38 30   Data
            .hex 28                                  ; $f3c2: 28            Data
__f3c3:     .hex 04 04 03 03                         ; $f3c3: 04 04 03 03   Data
            .hex 02 02 02 02                         ; $f3c7: 02 02 02 02   Data
            .hex 02                                  ; $f3cb: 02            Data

;-------------------------------------------------------------------------------
__f3cc:     lda $3d                                  ; $f3cc: a5 3d     
            and #$20                                 ; $f3ce: 29 20     
            beq __f3ee                               ; $f3d0: f0 1c     
            ldx #$0a                                 ; $f3d2: a2 0a     
__f3d4:     lda __f3f5,x                             ; $f3d4: bd f5 f3  
            sta $57,x                                ; $f3d7: 95 57     
            dex                                      ; $f3d9: ca        
            bpl __f3d4                               ; $f3da: 10 f8     
            ldy #$0a                                 ; $f3dc: a0 0a     
            lda CurrentPhaseCount                    ; $f3de: a5 3c     
            sta $43                                  ; $f3e0: 85 43     
            jsr __d77c                               ; $f3e2: 20 7c d7  
            sta $60                                  ; $f3e5: 85 60     
            lda $43                                  ; $f3e7: a5 43     
            sta $61                                  ; $f3e9: 85 61     
            jmp __c12d                               ; $f3eb: 4c 2d c1  

;-------------------------------------------------------------------------------
__f3ee:     lda #$00                                 ; $f3ee: a9 00     
            ldy #$f4                                 ; $f3f0: a0 f4     
            jmp __c131                               ; $f3f2: 4c 31 c1  

;-------------------------------------------------------------------------------
__f3f5:     .hex 20 6c 08 19                         ; $f3f5: 20 6c 08 19   Data
            .hex 11 0a 1c 0e                         ; $f3f9: 11 0a 1c 0e   Data
            .hex 25 00 00 20                         ; $f3fd: 25 00 00 20   Data
            .hex 6c 08 24 24                         ; $f401: 6c 08 24 24   Data
            .hex 24 24 24 24                         ; $f405: 24 24 24 24   Data
            .hex 24 24                               ; $f409: 24 24         Data

;-------------------------------------------------------------------------------
__f40b:     jsr __f465                               ; $f40b: 20 65 f4  
            ldx #$01                                 ; $f40e: a2 01     
__f410:     lda __f43b,x                             ; $f410: bd 3b f4  
            ldy __f43d,x                             ; $f413: bc 3d f4  
            jsr __c131                               ; $f416: 20 31 c1  
            dex                                      ; $f419: ca        
            bpl __f410                               ; $f41a: 10 f4     
            ldx #$0f                                 ; $f41c: a2 0f     
__f41e:     lda #$24                                 ; $f41e: a9 24     
            sta $5a,x                                ; $f420: 95 5a     
            dex                                      ; $f422: ca        
            bpl __f41e                               ; $f423: 10 f9     
            lda #$10                                 ; $f425: a9 10     
            sta $59                                  ; $f427: 85 59     
            lda #$21                                 ; $f429: a9 21     
            sta $57                                  ; $f42b: 85 57     
            ldx #$02                                 ; $f42d: a2 02     
__f42f:     lda __f43f,x                             ; $f42f: bd 3f f4  
            sta $58                                  ; $f432: 85 58     
            jsr __c12d                               ; $f434: 20 2d c1  
            dex                                      ; $f437: ca        
            bpl __f42f                               ; $f438: 10 f5     
            rts                                      ; $f43a: 60        

;-------------------------------------------------------------------------------
__f43b:     .hex 42 55                               ; $f43b: 42 55         Data
__f43d:     .hex f4 f4                               ; $f43d: f4 f4         Data
__f43f:     .hex 88 a8 e8 21                         ; $f43f: 88 a8 e8 21   Data
            .hex c8 10 24 24                         ; $f443: c8 10 24 24   Data
            .hex 24 10 0a 16                         ; $f447: 24 10 0a 16   Data
            .hex 0e 24 24 18                         ; $f44b: 0e 24 24 18   Data
            .hex 1f 0e 1b 24                         ; $f44f: 1f 0e 1b 24   Data
            .hex 24 24 23 da                         ; $f453: 24 24 23 da   Data
            .hex 04 aa aa aa                         ; $f457: 04 aa aa aa   Data
            .hex aa                                  ; $f45b: aa            Data

;-------------------------------------------------------------------------------
__f45c:     ldx #$14                                 ; $f45c: a2 14     
__f45e:     jsr __f465                               ; $f45e: 20 65 f4  
            dex                                      ; $f461: ca        
            bne __f45e                               ; $f462: d0 fa     
            rts                                      ; $f464: 60        

;-------------------------------------------------------------------------------
__f465:     lda #$00                                 ; $f465: a9 00     
            sta $02                                  ; $f467: 85 02     
__f469:     lda $02                                  ; $f469: a5 02     
            beq __f469                               ; $f46b: f0 fc     
            dec $02                                  ; $f46d: c6 02     
__f46f:     rts                                      ; $f46f: 60        

;-------------------------------------------------------------------------------
__f470:     jsr __f469                               ; $f470: 20 69 f4  
            lda $3a                                  ; $f473: a5 3a     
            bne __f46f                               ; $f475: d0 f8     
            jsr __e768                               ; $f477: 20 68 e7  
            and #$10                                 ; $f47a: 29 10     
            beq __f46f                               ; $f47c: f0 f1     
            lda #$04                                 ; $f47e: a9 04     
            sta CurrentMusic                         ; $f480: 85 f2     
            lda $01                                  ; $f482: a5 01     
            and #$ef                                 ; $f484: 29 ef     
            sta $2001                                ; $f486: 8d 01 20  
__f489:     jsr __f465                               ; $f489: 20 65 f4  
            jsr __e768                               ; $f48c: 20 68 e7  
            and #$10                                 ; $f48f: 29 10     
            beq __f489                               ; $f491: f0 f6     
            lda $01                                  ; $f493: a5 01     
            sta $2001                                ; $f495: 8d 01 20  
            ldy #$04                                 ; $f498: a0 04     
            lda IsBonusPhase                         ; $f49a: a5 c8     
            ora $16                                  ; $f49c: 05 16     
            beq __f4a2                               ; $f49e: f0 02     
            ldy #$20                                 ; $f4a0: a0 20     
__f4a2:     sty CurrentMusic                         ; $f4a2: 84 f2     
            rts                                      ; $f4a4: 60        

;-------------------------------------------------------------------------------
__f4a5:     lda #$01                                 ; $f4a5: a9 01     
            sta $048e                                ; $f4a7: 8d 8e 04  
            sta $048f                                ; $f4aa: 8d 8f 04  
            lda #$ff                                 ; $f4ad: a9 ff     
            sta $bb                                  ; $f4af: 85 bb     
            sta $87                                  ; $f4b1: 85 87     
            sta $048c                                ; $f4b3: 8d 8c 04  
            ldx #$01                                 ; $f4b6: a2 01     
            stx $0459                                ; $f4b8: 8e 59 04  
            stx $90                                  ; $f4bb: 86 90     
            inx                                      ; $f4bd: e8        
            stx $46                                  ; $f4be: 86 46     
            lda #$40                                 ; $f4c0: a9 40     
            sta FishX                                ; $f4c2: 85 99     
            rts                                      ; $f4c4: 60        

;-------------------------------------------------------------------------------
            .hex ff ff ff                            ; $f4c5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff                            ; $f4c8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff                            ; $f4cb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff                            ; $f4ce: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff                            ; $f4d1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff                            ; $f4d4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff                            ; $f4d7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff                            ; $f4da: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff                            ; $f4dd: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff                            ; $f4e0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff                            ; $f4e3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff                            ; $f4e6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff                            ; $f4e9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff                            ; $f4ec: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff                            ; $f4ef: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff                            ; $f4f2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff                            ; $f4f5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff                            ; $f4f8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff                            ; $f4fb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff                               ; $f4fe: ff ff     Suspected data
__f500:     jsr __f78f                               ; $f500: 20 8f f7  
__f503:     rts                                      ; $f503: 60        

;-------------------------------------------------------------------------------
__f504:     lda #$00                                 ; $f504: a9 00     
            tax                                      ; $f506: aa        
            sta $fd                                  ; $f507: 85 fd     
            beq __f51b                               ; $f509: f0 10     
__f50b:     txa                                      ; $f50b: 8a        
            lsr                                      ; $f50c: 4a        
            tax                                      ; $f50d: aa        
__f50e:     inx                                      ; $f50e: e8        
            txa                                      ; $f50f: 8a        
            cmp #$04                                 ; $f510: c9 04     
            beq __f503                               ; $f512: f0 ef     
            lda $fd                                  ; $f514: a5 fd     
            clc                                      ; $f516: 18        
            adc #$04                                 ; $f517: 69 04     
            sta $fd                                  ; $f519: 85 fd     
__f51b:     txa                                      ; $f51b: 8a        
            asl                                      ; $f51c: 0a        
            tax                                      ; $f51d: aa        
            lda $e0,x                                ; $f51e: b5 e0     
            sta $fe                                  ; $f520: 85 fe     
            lda $e1,x                                ; $f522: b5 e1     
            sta $ff                                  ; $f524: 85 ff     
            lda $e1,x                                ; $f526: b5 e1     
            beq __f50b                               ; $f528: f0 e1     
            txa                                      ; $f52a: 8a        
            lsr                                      ; $f52b: 4a        
            tax                                      ; $f52c: aa        
            dec $d0,x                                ; $f52d: d6 d0     
            bne __f50e                               ; $f52f: d0 dd     
__f531:     ldy $e8,x                                ; $f531: b4 e8     
            inc $e8,x                                ; $f533: f6 e8     
            lda ($fe),y                              ; $f535: b1 fe     
            beq __f500                               ; $f537: f0 c7     
            tay                                      ; $f539: a8        
            cmp #$ff                                 ; $f53a: c9 ff     
            beq __f547                               ; $f53c: f0 09     
            and #$c0                                 ; $f53e: 29 c0     
            cmp #$c0                                 ; $f540: c9 c0     
            beq __f553                               ; $f542: f0 0f     
            jmp __f561                               ; $f544: 4c 61 f5  

;-------------------------------------------------------------------------------
__f547:     lda $d8,x                                ; $f547: b5 d8     
            beq __f55e                               ; $f549: f0 13     
            dec $d8,x                                ; $f54b: d6 d8     
            lda $ec,x                                ; $f54d: b5 ec     
            sta $e8,x                                ; $f54f: 95 e8     
            bne __f55e                               ; $f551: d0 0b     
__f553:     tya                                      ; $f553: 98        
            and #$3f                                 ; $f554: 29 3f     
            sta $d8,x                                ; $f556: 95 d8     
            dec $d8,x                                ; $f558: d6 d8     
            lda $e8,x                                ; $f55a: b5 e8     
            sta $ec,x                                ; $f55c: 95 ec     
__f55e:     jmp __f531                               ; $f55e: 4c 31 f5  

;-------------------------------------------------------------------------------
__f561:     tya                                      ; $f561: 98        
            bpl __f57b                               ; $f562: 10 17     
            and #$0f                                 ; $f564: 29 0f     
            clc                                      ; $f566: 18        
            adc $df                                  ; $f567: 65 df     
            tay                                      ; $f569: a8        
            lda __f660,y                             ; $f56a: b9 60 f6  
            sta $d4,x                                ; $f56d: 95 d4     
            tay                                      ; $f56f: a8        
            txa                                      ; $f570: 8a        
            cmp #$02                                 ; $f571: c9 02     
            beq __f5c4                               ; $f573: f0 4f     
__f575:     ldy $e8,x                                ; $f575: b4 e8     
            inc $e8,x                                ; $f577: f6 e8     
            lda ($fe),y                              ; $f579: b1 fe     
__f57b:     tay                                      ; $f57b: a8        
            txa                                      ; $f57c: 8a        
            cmp #$03                                 ; $f57d: c9 03     
            beq __f5e1                               ; $f57f: f0 60     
            pha                                      ; $f581: 48        
            tax                                      ; $f582: aa        
            cmp #$01                                 ; $f583: c9 01     
            beq __f5b9                               ; $f585: f0 32     
__f587:     ldx $fd                                  ; $f587: a6 fd     
            lda __f601,y                             ; $f589: b9 01 f6  
            beq __f599                               ; $f58c: f0 0b     
            sta $4002,x                              ; $f58e: 9d 02 40  
            lda __f600,y                             ; $f591: b9 00 f6  
            ora #$08                                 ; $f594: 09 08     
            sta $4003,x                              ; $f596: 9d 03 40  
__f599:     tay                                      ; $f599: a8        
            pla                                      ; $f59a: 68        
            tax                                      ; $f59b: aa        
            tya                                      ; $f59c: 98        
            bne __f5aa                               ; $f59d: d0 0b     
            ldy #$00                                 ; $f59f: a0 00     
            txa                                      ; $f5a1: 8a        
            cmp #$02                                 ; $f5a2: c9 02     
            beq __f5ac                               ; $f5a4: f0 06     
            ldy #$10                                 ; $f5a6: a0 10     
            bne __f5ac                               ; $f5a8: d0 02     
__f5aa:     ldy $dc,x                                ; $f5aa: b4 dc     
__f5ac:     tya                                      ; $f5ac: 98        
            ldy $fd                                  ; $f5ad: a4 fd     
            sta $4000,y                              ; $f5af: 99 00 40  
__f5b2:     lda $d4,x                                ; $f5b2: b5 d4     
            sta $d0,x                                ; $f5b4: 95 d0     
            jmp __f50e                               ; $f5b6: 4c 0e f5  

;-------------------------------------------------------------------------------
__f5b9:     lda $f5                                  ; $f5b9: a5 f5     
            and #$02                                 ; $f5bb: 29 02     
            beq __f587                               ; $f5bd: f0 c8     
            pla                                      ; $f5bf: 68        
            tax                                      ; $f5c0: aa        
            jmp __f5b2                               ; $f5c1: 4c b2 f5  

;-------------------------------------------------------------------------------
__f5c4:     tya                                      ; $f5c4: 98        
            ldy $07f0                                ; $f5c5: ac f0 07  
            beq __f5ce                               ; $f5c8: f0 04     
            lda #$ff                                 ; $f5ca: a9 ff     
            bne __f5d9                               ; $f5cc: d0 0b     
__f5ce:     clc                                      ; $f5ce: 18        
            adc #$fe                                 ; $f5cf: 69 fe     
            asl                                      ; $f5d1: 0a        
            asl                                      ; $f5d2: 0a        
            cmp #$3c                                 ; $f5d3: c9 3c     
            bcc __f5d9                               ; $f5d5: 90 02     
            lda #$3c                                 ; $f5d7: a9 3c     
__f5d9:     sta $4008                                ; $f5d9: 8d 08 40  
            sta $de                                  ; $f5dc: 85 de     
            jmp __f575                               ; $f5de: 4c 75 f5  

;-------------------------------------------------------------------------------
__f5e1:     lda $f4                                  ; $f5e1: a5 f4     
            cmp #$02                                 ; $f5e3: c9 02     
            beq __f5f9                               ; $f5e5: f0 12     
            lda __f700,y                             ; $f5e7: b9 00 f7  
            sta $400c                                ; $f5ea: 8d 0c 40  
            lda __f701,y                             ; $f5ed: b9 01 f7  
            sta $400e                                ; $f5f0: 8d 0e 40  
            lda __f702,y                             ; $f5f3: b9 02 f7  
            sta $400f                                ; $f5f6: 8d 0f 40  
__f5f9:     jmp __f5b2                               ; $f5f9: 4c b2 f5  

;-------------------------------------------------------------------------------
            .hex 16 ff 10 c5                         ; $f5fc: 16 ff 10 c5   Data
__f600:     .hex 07                                  ; $f600: 07            Data
__f601:     .hex f0 00 00 00                         ; $f601: f0 00 00 00   Data
            .hex d4 00 c8 00                         ; $f605: d4 00 c8 00   Data
            .hex bd 00 b2 00                         ; $f609: bd 00 b2 00   Data
            .hex a8 00 9f 00                         ; $f60d: a8 00 9f 00   Data
            .hex 96 00 8d 00                         ; $f611: 96 00 8d 00   Data
            .hex 85 00 7e 00                         ; $f615: 85 00 7e 00   Data
            .hex 76 00 70 01                         ; $f619: 76 00 70 01   Data
            .hex ab 01 93 01                         ; $f61d: ab 01 93 01   Data
            .hex 7c 01 67 01                         ; $f621: 7c 01 67 01   Data
            .hex 52 01 3f 01                         ; $f625: 52 01 3f 01   Data
            .hex 2d 01 1c 01                         ; $f629: 2d 01 1c 01   Data
            .hex 0c 00 fd 00                         ; $f62d: 0c 00 fd 00   Data
            .hex ee 00 e1 03                         ; $f631: ee 00 e1 03   Data
            .hex 57 03 27 02                         ; $f635: 57 03 27 02   Data
            .hex f9 02 cf 02                         ; $f639: f9 02 cf 02   Data
            .hex a6 02 80 02                         ; $f63d: a6 02 80 02   Data
            .hex 5c 02 3a 02                         ; $f641: 5c 02 3a 02   Data
            .hex 1a 01 fc 01                         ; $f645: 1a 01 fc 01   Data
            .hex df 01 c4 03                         ; $f649: df 01 c4 03   Data
            .hex f8 00 69 00                         ; $f64d: f8 00 69 00   Data
            .hex 63 00 5e 00                         ; $f651: 63 00 5e 00   Data
            .hex 58 00 53 00                         ; $f655: 58 00 53 00   Data
            .hex 4f 00 4a 00                         ; $f659: 4f 00 4a 00   Data
            .hex 46 00 42                            ; $f65d: 46 00 42      Data
__f660:     .hex 03 06 0c 18                         ; $f660: 03 06 0c 18   Data
            .hex 30 12 24 09                         ; $f664: 30 12 24 09   Data
            .hex 08 04 07 01                         ; $f668: 08 04 07 01   Data
            .hex 04 08 10 20                         ; $f66c: 04 08 10 20   Data
            .hex 40 18 30 0c                         ; $f670: 40 18 30 0c   Data
            .hex 01 06 0c 18                         ; $f674: 01 06 0c 18   Data
            .hex 30 60 24 48                         ; $f678: 30 60 24 48   Data
            .hex 12 10 08 0e                         ; $f67c: 12 10 08 0e   Data
            .hex 02 03 04                            ; $f680: 02 03 04      Data

;-------------------------------------------------------------------------------
__f683:     lda #$00                                 ; $f683: a9 00     
            beq __f691                               ; $f685: f0 0a     
__f687:     lda #$08                                 ; $f687: a9 08     
            bne __f691                               ; $f689: d0 06     
__f68b:     lda #$0c                                 ; $f68b: a9 0c     
            bne __f691                               ; $f68d: d0 02     
__f68f:     lda #$04                                 ; $f68f: a9 04     
__f691:     sta $f9                                  ; $f691: 85 f9     
            lda #$40                                 ; $f693: a9 40     
            sta $fa                                  ; $f695: 85 fa     
            stx $fb                                  ; $f697: 86 fb     
            sty $fc                                  ; $f699: 84 fc     
            ldy #$00                                 ; $f69b: a0 00     
__f69d:     lda ($fb),y                              ; $f69d: b1 fb     
            sta ($f9),y                              ; $f69f: 91 f9     
            iny                                      ; $f6a1: c8        
            tya                                      ; $f6a2: 98        
            cmp #$04                                 ; $f6a3: c9 04     
            bne __f69d                               ; $f6a5: d0 f6     
            rts                                      ; $f6a7: 60        

;-------------------------------------------------------------------------------
__f6a8:     tax                                      ; $f6a8: aa        
            jsr __f798                               ; $f6a9: 20 98 f7  
            stx $f6                                  ; $f6ac: 86 f6     
            lda $07f5                                ; $f6ae: ad f5 07  
            beq __f6be                               ; $f6b1: f0 0b     
            cmp #$02                                 ; $f6b3: c9 02     
            bne __f6be                               ; $f6b5: d0 07     
            sta $f0                                  ; $f6b7: 85 f0     
            lda #$00                                 ; $f6b9: a9 00     
            sta $07f5                                ; $f6bb: 8d f5 07  
__f6be:     lda __fbca,y                             ; $f6be: b9 ca fb  
            tay                                      ; $f6c1: a8        
            ldx #$00                                 ; $f6c2: a2 00     
__f6c4:     lda __fbca,y                             ; $f6c4: b9 ca fb  
            sta $df,x                                ; $f6c7: 95 df     
            iny                                      ; $f6c9: c8        
            inx                                      ; $f6ca: e8        
            txa                                      ; $f6cb: 8a        
            cmp #$09                                 ; $f6cc: c9 09     
            bne __f6c4                               ; $f6ce: d0 f4     
            lda #$01                                 ; $f6d0: a9 01     
            sta $d0                                  ; $f6d2: 85 d0     
            sta $d1                                  ; $f6d4: 85 d1     
            sta $d2                                  ; $f6d6: 85 d2     
            sta $d3                                  ; $f6d8: 85 d3     
            lda #$00                                 ; $f6da: a9 00     
            sta $e8                                  ; $f6dc: 85 e8     
            sta $e9                                  ; $f6de: 85 e9     
            sta $ea                                  ; $f6e0: 85 ea     
            sta $eb                                  ; $f6e2: 85 eb     
            rts                                      ; $f6e4: 60        

;-------------------------------------------------------------------------------
            .hex 94 ab fd 58                         ; $f6e5: 94 ab fd 58   Data
            .hex 00 7f 04 18                         ; $f6e9: 00 7f 04 18   Data
            .hex 3f 7f 00 00                         ; $f6ed: 3f 7f 00 00   Data
            .hex 06 7f 0a c0                         ; $f6f1: 06 7f 0a c0   Data
            .hex 08 7f 05 c0                         ; $f6f5: 08 7f 05 c0   Data
            .hex c1 89 02 0f                         ; $f6f9: c1 89 02 0f   Data
            .hex ff ff ff                            ; $f6fd: ff ff ff      Data
__f700:     .hex 10                                  ; $f700: 10            Data
__f701:     .hex 00                                  ; $f701: 00            Data
__f702:     .hex 18 10 01 18                         ; $f702: 18 10 01 18   Data
            .hex 00 01 88 02                         ; $f706: 00 01 88 02   Data
            .hex 02 40 03 05                         ; $f70a: 02 40 03 05   Data
            .hex 40 04 07 40                         ; $f70e: 40 04 07 40   Data

;-------------------------------------------------------------------------------
__f712:     lda #$7f                                 ; $f712: a9 7f     
            sta $4001                                ; $f714: 8d 01 40  
            sta $4005                                ; $f717: 8d 05 40  
__f71a:     stx $dc                                  ; $f71a: 86 dc     
            sty $dd                                  ; $f71c: 84 dd     
            rts                                      ; $f71e: 60        

;-------------------------------------------------------------------------------
__f71f:     ldx #$e5                                 ; $f71f: a2 e5     
            ldy #$f6                                 ; $f721: a0 f6     
            bne __f745                               ; $f723: d0 20     
__f725:     lda $f3                                  ; $f725: a5 f3     
            lsr                                      ; $f727: 4a        
            bcs __f736                               ; $f728: b0 0c     
            lda $f7                                  ; $f72a: a5 f7     
            lsr                                      ; $f72c: 4a        
            bcs __f749                               ; $f72d: b0 1a     
            lda $f0                                  ; $f72f: a5 f0     
            and #$10                                 ; $f731: 29 10     
            bne __f71f                               ; $f733: d0 ea     
            rts                                      ; $f735: 60        

;-------------------------------------------------------------------------------
__f736:     lda $f7                                  ; $f736: a5 f7     
            ora #$01                                 ; $f738: 09 01     
            sta $f7                                  ; $f73a: 85 f7     
            lda #$00                                 ; $f73c: a9 00     
            sta $07e4                                ; $f73e: 8d e4 07  
            ldx #$fc                                 ; $f741: a2 fc     
            ldy #$f5                                 ; $f743: a0 f5     
__f745:     jsr __f683                               ; $f745: 20 83 f6  
            rts                                      ; $f748: 60        

;-------------------------------------------------------------------------------
__f749:     inc $07e4                                ; $f749: ee e4 07  
            lda $07e4                                ; $f74c: ad e4 07  
            cmp #$58                                 ; $f74f: c9 58     
            bne __f77b                               ; $f751: d0 28     
            lda #$00                                 ; $f753: a9 00     
            sta $f7                                  ; $f755: 85 f7     
            rts                                      ; $f757: 60        

;-------------------------------------------------------------------------------
__f758:     lda #$c0                                 ; $f758: a9 c0     
            sta $4017                                ; $f75a: 8d 17 40  
            jsr __fb25                               ; $f75d: 20 25 fb  
            jsr __f90a                               ; $f760: 20 0a f9  
            jsr __fa38                               ; $f763: 20 38 fa  
            jsr __faac                               ; $f766: 20 ac fa  
            jsr __f824                               ; $f769: 20 24 f8  
            lda $f1                                  ; $f76c: a5 f1     
            sta $07e9                                ; $f76e: 8d e9 07  
            lda #$00                                 ; $f771: a9 00     
            sta $f0                                  ; $f773: 85 f0     
            sta $f1                                  ; $f775: 85 f1     
            sta CurrentMusic                         ; $f777: 85 f2     
            sta $f3                                  ; $f779: 85 f3     
__f77b:     rts                                      ; $f77b: 60        

;-------------------------------------------------------------------------------
__f77c:     lda $f4                                  ; $f77c: a5 f4     
            and #$06                                 ; $f77e: 29 06     
            bne __f77b                               ; $f780: d0 f9     
            lda $f4                                  ; $f782: a5 f4     
            and #$f0                                 ; $f784: 29 f0     
            sta $f4                                  ; $f786: 85 f4     
            ldx #$e9                                 ; $f788: a2 e9     
            ldy #$f6                                 ; $f78a: a0 f6     
            jmp __f879                               ; $f78c: 4c 79 f8  

;-------------------------------------------------------------------------------
__f78f:     lda $f6                                  ; $f78f: a5 f6     
            cmp #$20                                 ; $f791: c9 20     
            bne __f79f                               ; $f793: d0 0a     
            inc $07e8                                ; $f795: ee e8 07  
__f798:     and #$0f                                 ; $f798: 29 0f     
            cmp #$0f                                 ; $f79a: c9 0f     
            bne __f7a5                               ; $f79c: d0 07     
            txa                                      ; $f79e: 8a        
__f79f:     lda $f4                                  ; $f79f: a5 f4     
            and #$20                                 ; $f7a1: 29 20     
            bne __f7c7                               ; $f7a3: d0 22     
__f7a5:     lda #$10                                 ; $f7a5: a9 10     
            sta $400c                                ; $f7a7: 8d 0c 40  
            sta $4000                                ; $f7aa: 8d 00 40  
            sta $4004                                ; $f7ad: 8d 04 40  
            lda #$00                                 ; $f7b0: a9 00     
            sta $f4                                  ; $f7b2: 85 f4     
__f7b4:     sta $f5                                  ; $f7b4: 85 f5     
            sta $f6                                  ; $f7b6: 85 f6     
            sta $07fa                                ; $f7b8: 8d fa 07  
            sta $f7                                  ; $f7bb: 85 f7     
            sta $4008                                ; $f7bd: 8d 08 40  
            sta $4011                                ; $f7c0: 8d 11 40  
            sta $07f0                                ; $f7c3: 8d f0 07  
            rts                                      ; $f7c6: 60        

;-------------------------------------------------------------------------------
__f7c7:     lda #$10                                 ; $f7c7: a9 10     
            sta $4004                                ; $f7c9: 8d 04 40  
            sta $400c                                ; $f7cc: 8d 0c 40  
            lda #$00                                 ; $f7cf: a9 00     
            beq __f7b4                               ; $f7d1: f0 e1     
__f7d3:     lda #$00                                 ; $f7d3: a9 00     
            sta $07fa                                ; $f7d5: 8d fa 07  
            rts                                      ; $f7d8: 60        

;-------------------------------------------------------------------------------
__f7d9:     ldx #$f5                                 ; $f7d9: a2 f5     
            ldy #$f6                                 ; $f7db: a0 f6     
            jmp __f879                               ; $f7dd: 4c 79 f8  

;-------------------------------------------------------------------------------
__f7e0:     inc $07fb                                ; $f7e0: ee fb 07  
            lda $07fb                                ; $f7e3: ad fb 07  
            cmp #$10                                 ; $f7e6: c9 10     
            beq __f7d9                               ; $f7e8: f0 ef     
            cmp #$20                                 ; $f7ea: c9 20     
            beq __f7d3                               ; $f7ec: f0 e5     
            rts                                      ; $f7ee: 60        

;-------------------------------------------------------------------------------
__f7ef:     lda #$00                                 ; $f7ef: a9 00     
            sta $07fb                                ; $f7f1: 8d fb 07  
            lda #$f0                                 ; $f7f4: a9 f0     
            sta $07fa                                ; $f7f6: 8d fa 07  
            ldx #$f1                                 ; $f7f9: a2 f1     
            ldy #$f6                                 ; $f7fb: a0 f6     
            jmp __f879                               ; $f7fd: 4c 79 f8  

;-------------------------------------------------------------------------------
__f800:     lda $f4                                  ; $f800: a5 f4     
            and #$f0                                 ; $f802: 29 f0     
            ora #$02                                 ; $f804: 09 02     
            sta $f4                                  ; $f806: 85 f4     
            lda #$00                                 ; $f808: a9 00     
            sta $07f7                                ; $f80a: 8d f7 07  
            ldx #$f1                                 ; $f80d: a2 f1     
            ldy #$f6                                 ; $f80f: a0 f6     
            jmp __f879                               ; $f811: 4c 79 f8  

;-------------------------------------------------------------------------------
__f814:     inc $07f7                                ; $f814: ee f7 07  
            lda $07f7                                ; $f817: ad f7 07  
            cmp #$10                                 ; $f81a: c9 10     
            bne __f85b                               ; $f81c: d0 3d     
            jmp __f89b                               ; $f81e: 4c 9b f8  

;-------------------------------------------------------------------------------
__f821:     jmp __f7a5                               ; $f821: 4c a5 f7  

;-------------------------------------------------------------------------------
__f824:     lda $f0                                  ; $f824: a5 f0     
            lsr                                      ; $f826: 4a        
            bcs __f821                               ; $f827: b0 f8     
            lda $f6                                  ; $f829: a5 f6     
            cmp #$df                                 ; $f82b: c9 df     
            beq __f83b                               ; $f82d: f0 0c     
            cmp #$7f                                 ; $f82f: c9 7f     
            beq __f83b                               ; $f831: f0 08     
            cmp #$20                                 ; $f833: c9 20     
            beq __f83b                               ; $f835: f0 04     
            lda $f6                                  ; $f837: a5 f6     
            bne __f85b                               ; $f839: d0 20     
__f83b:     lda $07fa                                ; $f83b: ad fa 07  
            cmp #$0f                                 ; $f83e: c9 0f     
            beq __f7ef                               ; $f840: f0 ad     
            cmp #$f0                                 ; $f842: c9 f0     
            beq __f7e0                               ; $f844: f0 9a     
            lda $f0                                  ; $f846: a5 f0     
            lsr                                      ; $f848: 4a        
            lsr                                      ; $f849: 4a        
            bcs __f800                               ; $f84a: b0 b4     
            lsr                                      ; $f84c: 4a        
            bcs __f85f                               ; $f84d: b0 10     
            lsr                                      ; $f84f: 4a        
            bcs __f85c                               ; $f850: b0 0a     
            lda $f4                                  ; $f852: a5 f4     
            lsr                                      ; $f854: 4a        
            lsr                                      ; $f855: 4a        
            bcs __f814                               ; $f856: b0 bc     
            lsr                                      ; $f858: 4a        
            bcs __f87d                               ; $f859: b0 22     
__f85b:     rts                                      ; $f85b: 60        

;-------------------------------------------------------------------------------
__f85c:     jmp __f77c                               ; $f85c: 4c 7c f7  

;-------------------------------------------------------------------------------
__f85f:     lda $f4                                  ; $f85f: a5 f4     
            and #$80                                 ; $f861: 29 80     
            bne __f85b                               ; $f863: d0 f6     
            lda $f4                                  ; $f865: a5 f4     
            and #$f0                                 ; $f867: 29 f0     
            ora #$04                                 ; $f869: 09 04     
            sta $f4                                  ; $f86b: 85 f4     
            lda #$00                                 ; $f86d: a9 00     
            sta $07f3                                ; $f86f: 8d f3 07  
            sta $07f1                                ; $f872: 8d f1 07  
            ldx #$ed                                 ; $f875: a2 ed     
            ldy #$f6                                 ; $f877: a0 f6     
__f879:     jsr __f68b                               ; $f879: 20 8b f6  
            rts                                      ; $f87c: 60        

;-------------------------------------------------------------------------------
__f87d:     inc $07f3                                ; $f87d: ee f3 07  
            lda $07f3                                ; $f880: ad f3 07  
            cmp #$03                                 ; $f883: c9 03     
            bne __f8a1                               ; $f885: d0 1a     
            lda #$00                                 ; $f887: a9 00     
            sta $07f3                                ; $f889: 8d f3 07  
            inc $07f1                                ; $f88c: ee f1 07  
            lda $07f1                                ; $f88f: ad f1 07  
            cmp #$10                                 ; $f892: c9 10     
            bne __f8a2                               ; $f894: d0 0c     
            lda #$10                                 ; $f896: a9 10     
            sta $400c                                ; $f898: 8d 0c 40  
__f89b:     lda $f4                                  ; $f89b: a5 f4     
            and #$f0                                 ; $f89d: 29 f0     
            sta $f4                                  ; $f89f: 85 f4     
__f8a1:     rts                                      ; $f8a1: 60        

;-------------------------------------------------------------------------------
__f8a2:     sta $400e                                ; $f8a2: 8d 0e 40  
            rts                                      ; $f8a5: 60        

;-------------------------------------------------------------------------------
__f8a6:     lda #$00                                 ; $f8a6: a9 00     
            sta $07e0                                ; $f8a8: 8d e0 07  
            clc                                      ; $f8ab: 18        
            lda $1b                                  ; $f8ac: a5 1b     
            and #$07                                 ; $f8ae: 29 07     
            adc #$02                                 ; $f8b0: 69 02     
            sta $07e1                                ; $f8b2: 8d e1 07  
            lda $f7                                  ; $f8b5: a5 f7     
            and #$00                                 ; $f8b7: 29 00     
            ora #$80                                 ; $f8b9: 09 80     
            sta $f7                                  ; $f8bb: 85 f7     
            bne __f8e8                               ; $f8bd: d0 29     
__f8bf:     inc $07e0                                ; $f8bf: ee e0 07  
            lda $07e0                                ; $f8c2: ad e0 07  
            cmp $07e1                                ; $f8c5: cd e1 07  
            bne __f8e8                               ; $f8c8: d0 1e     
__f8ca:     lda #$10                                 ; $f8ca: a9 10     
            sta $4000                                ; $f8cc: 8d 00 40  
            sta $4004                                ; $f8cf: 8d 04 40  
            lda #$00                                 ; $f8d2: a9 00     
            sta $f7                                  ; $f8d4: 85 f7     
            lda $f4                                  ; $f8d6: a5 f4     
            and #$0f                                 ; $f8d8: 29 0f     
            sta $f4                                  ; $f8da: 85 f4     
            rts                                      ; $f8dc: 60        

;-------------------------------------------------------------------------------
__f8dd:     jsr __f7a5                               ; $f8dd: 20 a5 f7  
            lda #$80                                 ; $f8e0: a9 80     
            sta $f4                                  ; $f8e2: 85 f4     
            lda #$02                                 ; $f8e4: a9 02     
            sta $f0                                  ; $f8e6: 85 f0     
__f8e8:     ldx #$f9                                 ; $f8e8: a2 f9     
            ldy #$f6                                 ; $f8ea: a0 f6     
            jsr __f683                               ; $f8ec: 20 83 f6  
            lda $1b                                  ; $f8ef: a5 1b     
            and #$0f                                 ; $f8f1: 29 0f     
            sta $4002                                ; $f8f3: 8d 02 40  
            ldx #$f9                                 ; $f8f6: a2 f9     
            ldy #$f6                                 ; $f8f8: a0 f6     
            jsr __f68f                               ; $f8fa: 20 8f f6  
            lda $1b                                  ; $f8fd: a5 1b     
            lsr                                      ; $f8ff: 4a        
            lsr                                      ; $f900: 4a        
            and #$0f                                 ; $f901: 29 0f     
            sta $4006                                ; $f903: 8d 06 40  
            rts                                      ; $f906: 60        

;-------------------------------------------------------------------------------
__f907:     jmp __f8a6                               ; $f907: 4c a6 f8  

;-------------------------------------------------------------------------------
__f90a:     lda $f6                                  ; $f90a: a5 f6     
            beq __f91b                               ; $f90c: f0 0d     
            cmp #$df                                 ; $f90e: c9 df     
            beq __f91b                               ; $f910: f0 09     
            lda $f0                                  ; $f912: a5 f0     
            and #$e0                                 ; $f914: 29 e0     
            beq __f94e                               ; $f916: f0 36     
            jsr __f7a5                               ; $f918: 20 a5 f7  
__f91b:     lda $f0                                  ; $f91b: a5 f0     
            asl                                      ; $f91d: 0a        
            bcs __f8dd                               ; $f91e: b0 bd     
            asl                                      ; $f920: 0a        
            bcs __f952                               ; $f921: b0 2f     
            asl                                      ; $f923: 0a        
            bcs __f965                               ; $f924: b0 3f     
            lda $f4                                  ; $f926: a5 f4     
            asl                                      ; $f928: 0a        
            bcs __f8e8                               ; $f929: b0 bd     
            lda $f4                                  ; $f92b: a5 f4     
            and #$e0                                 ; $f92d: 29 e0     
            bne __f94e                               ; $f92f: d0 1d     
            lda $f6                                  ; $f931: a5 f6     
            cmp #$df                                 ; $f933: c9 df     
            beq __f94b                               ; $f935: f0 14     
            lda $f6                                  ; $f937: a5 f6     
            bne __f94e                               ; $f939: d0 13     
            lda $f3                                  ; $f93b: a5 f3     
            asl                                      ; $f93d: 0a        
            bcs __f907                               ; $f93e: b0 c7     
            asl                                      ; $f940: 0a        
            bcs __f977                               ; $f941: b0 34     
            lda $f7                                  ; $f943: a5 f7     
            asl                                      ; $f945: 0a        
            bcs __f94f                               ; $f946: b0 07     
            asl                                      ; $f948: 0a        
            bcs __f993                               ; $f949: b0 48     
__f94b:     jsr __f725                               ; $f94b: 20 25 f7  
__f94e:     rts                                      ; $f94e: 60        

;-------------------------------------------------------------------------------
__f94f:     jmp __f8bf                               ; $f94f: 4c bf f8  

;-------------------------------------------------------------------------------
__f952:     lda #$0f                                 ; $f952: a9 0f     
            sta $07fa                                ; $f954: 8d fa 07  
            lda $f4                                  ; $f957: a5 f4     
            and #$0f                                 ; $f959: 29 0f     
            ora #$40                                 ; $f95b: 09 40     
            sta $f4                                  ; $f95d: 85 f4     
            ldx #$d1                                 ; $f95f: a2 d1     
            ldy #$f9                                 ; $f961: a0 f9     
            bne __f98f                               ; $f963: d0 2a     
__f965:     lda #$02                                 ; $f965: a9 02     
            sta $f0                                  ; $f967: 85 f0     
            lda $f4                                  ; $f969: a5 f4     
            and #$0f                                 ; $f96b: 29 0f     
            ora #$20                                 ; $f96d: 09 20     
            sta $f4                                  ; $f96f: 85 f4     
            ldx #$cd                                 ; $f971: a2 cd     
            ldy #$f9                                 ; $f973: a0 f9     
            bne __f98f                               ; $f975: d0 18     
__f977:     lda #$00                                 ; $f977: a9 00     
            sta $07fc                                ; $f979: 8d fc 07  
            lda $f7                                  ; $f97c: a5 f7     
            and #$00                                 ; $f97e: 29 00     
            ora #$40                                 ; $f980: 09 40     
            sta $f7                                  ; $f982: 85 f7     
            ldx #$d5                                 ; $f984: a2 d5     
            ldy #$f9                                 ; $f986: a0 f9     
            jsr __f68f                               ; $f988: 20 8f f6  
            ldx #$d9                                 ; $f98b: a2 d9     
            ldy #$f9                                 ; $f98d: a0 f9     
__f98f:     jsr __f683                               ; $f98f: 20 83 f6  
            rts                                      ; $f992: 60        

;-------------------------------------------------------------------------------
__f993:     inc $07fc                                ; $f993: ee fc 07  
            lda $07fc                                ; $f996: ad fc 07  
            cmp #$12                                 ; $f999: c9 12     
            beq __f9ca                               ; $f99b: f0 2d     
            cmp #$06                                 ; $f99d: c9 06     
            bcc __f9b1                               ; $f99f: 90 10     
            lda $1b                                  ; $f9a1: a5 1b     
            ora #$10                                 ; $f9a3: 09 10     
            and #$7f                                 ; $f9a5: 29 7f     
            sta $07fe                                ; $f9a7: 8d fe 07  
            rol                                      ; $f9aa: 2a        
            sta $07fd                                ; $f9ab: 8d fd 07  
            jmp __f9bd                               ; $f9ae: 4c bd f9  

;-------------------------------------------------------------------------------
__f9b1:     inc $07fd                                ; $f9b1: ee fd 07  
            inc $07fd                                ; $f9b4: ee fd 07  
            inc $07fe                                ; $f9b7: ee fe 07  
            inc $07fe                                ; $f9ba: ee fe 07  
__f9bd:     lda $07fd                                ; $f9bd: ad fd 07  
            sta $4006                                ; $f9c0: 8d 06 40  
            lda $07fe                                ; $f9c3: ad fe 07  
            sta $4002                                ; $f9c6: 8d 02 40  
            rts                                      ; $f9c9: 60        

;-------------------------------------------------------------------------------
__f9ca:     jmp __f8ca                               ; $f9ca: 4c ca f8  

;-------------------------------------------------------------------------------
            .hex b8 d5 20 00                         ; $f9cd: b8 d5 20 00   Data
            .hex 9f 93 80 22                         ; $f9d1: 9f 93 80 22   Data
            .hex 3f ba e0 06                         ; $f9d5: 3f ba e0 06   Data
            .hex 3f bb ce 06                         ; $f9d9: 3f bb ce 06   Data
            .hex b8 93 50 02                         ; $f9dd: b8 93 50 02   Data
            .hex 80 7f 60 68                         ; $f9e1: 80 7f 60 68   Data
            .hex 80 7f 62 68                         ; $f9e5: 80 7f 62 68   Data

;-------------------------------------------------------------------------------
__f9e9:     lda $f5                                  ; $f9e9: a5 f5     
            and #$02                                 ; $f9eb: 29 02     
            bne __fa26                               ; $f9ed: d0 37     
            lda $f6                                  ; $f9ef: a5 f6     
            cmp #$df                                 ; $f9f1: c9 df     
            beq __f9f9                               ; $f9f3: f0 04     
            lda $f6                                  ; $f9f5: a5 f6     
            bne __fa26                               ; $f9f7: d0 2d     
__f9f9:     lda #$00                                 ; $f9f9: a9 00     
            sta $07f9                                ; $f9fb: 8d f9 07  
            lda $f5                                  ; $f9fe: a5 f5     
            and #$e0                                 ; $fa00: 29 e0     
            ora #$02                                 ; $fa02: 09 02     
            sta $f5                                  ; $fa04: 85 f5     
            ldx #$dd                                 ; $fa06: a2 dd     
            ldy #$f9                                 ; $fa08: a0 f9     
            bne __fa7f                               ; $fa0a: d0 73     
__fa0c:     inc $07f9                                ; $fa0c: ee f9 07  
            lda $07f9                                ; $fa0f: ad f9 07  
            cmp #$07                                 ; $fa12: c9 07     
            bne __fa26                               ; $fa14: d0 10     
            lda #$7f                                 ; $fa16: a9 7f     
            sta $4005                                ; $fa18: 8d 05 40  
            lda #$10                                 ; $fa1b: a9 10     
            sta $4004                                ; $fa1d: 8d 04 40  
            lda $f5                                  ; $fa20: a5 f5     
            and #$e0                                 ; $fa22: 29 e0     
            sta $f5                                  ; $fa24: 85 f5     
__fa26:     rts                                      ; $fa26: 60        

;-------------------------------------------------------------------------------
__fa27:     jsr __f7a5                               ; $fa27: 20 a5 f7  
            ldx #$e1                                 ; $fa2a: a2 e1     
            ldy #$f9                                 ; $fa2c: a0 f9     
            jsr __f683                               ; $fa2e: 20 83 f6  
            ldx #$e5                                 ; $fa31: a2 e5     
            ldy #$f9                                 ; $fa33: a0 f9     
            jmp __fa7f                               ; $fa35: 4c 7f fa  

;-------------------------------------------------------------------------------
__fa38:     lda $f6                                  ; $fa38: a5 f6     
            beq __fa42                               ; $fa3a: f0 06     
            and #$0f                                 ; $fa3c: 29 0f     
            cmp #$0f                                 ; $fa3e: c9 0f     
            bne __fa63                               ; $fa40: d0 21     
__fa42:     lda $f4                                  ; $fa42: a5 f4     
            and #$80                                 ; $fa44: 29 80     
            bne __fa63                               ; $fa46: d0 1b     
            lda $f7                                  ; $fa48: a5 f7     
            and #$c0                                 ; $fa4a: 29 c0     
            bne __fa63                               ; $fa4c: d0 15     
            lda $f1                                  ; $fa4e: a5 f1     
            lsr                                      ; $fa50: 4a        
            bcs __fa27                               ; $fa51: b0 d4     
            lsr                                      ; $fa53: 4a        
            bcs __f9e9                               ; $fa54: b0 93     
            lsr                                      ; $fa56: 4a        
            bcs __fa83                               ; $fa57: b0 2a     
            lsr                                      ; $fa59: 4a        
            lsr                                      ; $fa5a: 4a        
            bcs __fa64                               ; $fa5b: b0 07     
            lda $f5                                  ; $fa5d: a5 f5     
            lsr                                      ; $fa5f: 4a        
            lsr                                      ; $fa60: 4a        
            bcs __fa0c                               ; $fa61: b0 a9     
__fa63:     rts                                      ; $fa63: 60        

;-------------------------------------------------------------------------------
__fa64:     lda $f6                                  ; $fa64: a5 f6     
            bne __fa63                               ; $fa66: d0 fb     
            lda $f5                                  ; $fa68: a5 f5     
            and #$02                                 ; $fa6a: 29 02     
            bne __fa63                               ; $fa6c: d0 f5     
            ldx #$8a                                 ; $fa6e: a2 8a     
            ldy #$fa                                 ; $fa70: a0 fa     
            jsr __f68f                               ; $fa72: 20 8f f6  
            lda $1b                                  ; $fa75: a5 1b     
            and #$3f                                 ; $fa77: 29 3f     
            ora #$10                                 ; $fa79: 09 10     
            sta $4006                                ; $fa7b: 8d 06 40  
            rts                                      ; $fa7e: 60        

;-------------------------------------------------------------------------------
__fa7f:     jsr __f68f                               ; $fa7f: 20 8f f6  
            rts                                      ; $fa82: 60        

;-------------------------------------------------------------------------------
__fa83:     ldy #$0a                                 ; $fa83: a0 0a     
            lda #$ef                                 ; $fa85: a9 ef     
            jmp __fba5                               ; $fa87: 4c a5 fb  

;-------------------------------------------------------------------------------
            .hex d9 86 a8 48                         ; $fa8a: d9 86 a8 48   Data
            .hex 08 7f 40 28                         ; $fa8e: 08 7f 40 28   Data
            .hex 08 7f 45 28                         ; $fa92: 08 7f 45 28   Data

;-------------------------------------------------------------------------------
__fa96:     inc $07f6                                ; $fa96: ee f6 07  
            lda $07f6                                ; $fa99: ad f6 07  
            cmp #$04                                 ; $fa9c: c9 04     
            bne __fad8                               ; $fa9e: d0 38     
            lda $f5                                  ; $faa0: a5 f5     
            and #$1f                                 ; $faa2: 29 1f     
            sta $f5                                  ; $faa4: 85 f5     
            ldx #$92                                 ; $faa6: a2 92     
            ldy #$fa                                 ; $faa8: a0 fa     
            bne __fb00                               ; $faaa: d0 54     
__faac:     lda $f6                                  ; $faac: a5 f6     
            beq __faba                               ; $faae: f0 0a     
            cmp #$08                                 ; $fab0: c9 08     
            beq __faba                               ; $fab2: f0 06     
            and #$0f                                 ; $fab4: 29 0f     
            cmp #$0f                                 ; $fab6: c9 0f     
            bne __fad8                               ; $fab8: d0 1e     
__faba:     lda $f4                                  ; $faba: a5 f4     
            and #$80                                 ; $fabc: 29 80     
            bne __fad8                               ; $fabe: d0 18     
            lda $f1                                  ; $fac0: a5 f1     
            asl                                      ; $fac2: 0a        
            bcs __fb17                               ; $fac3: b0 52     
            asl                                      ; $fac5: 0a        
            bcs __fae2                               ; $fac6: b0 1a     
            lda $f5                                  ; $fac8: a5 f5     
            asl                                      ; $faca: 0a        
            asl                                      ; $facb: 0a        
            bcs __fa96                               ; $facc: b0 c8     
            lda $f1                                  ; $face: a5 f1     
            and #$20                                 ; $fad0: 29 20     
            beq __fad9                               ; $fad2: f0 05     
            lda $f6                                  ; $fad4: a5 f6     
            beq __fb04                               ; $fad6: f0 2c     
__fad8:     rts                                      ; $fad8: 60        

;-------------------------------------------------------------------------------
__fad9:     lda $f6                                  ; $fad9: a5 f6     
            cmp #$df                                 ; $fadb: c9 df     
            bne __fad8                               ; $fadd: d0 f9     
            jmp __f79f                               ; $fadf: 4c 9f f7  

;-------------------------------------------------------------------------------
__fae2:     lda $f5                                  ; $fae2: a5 f5     
            and #$1f                                 ; $fae4: 29 1f     
            ora #$40                                 ; $fae6: 09 40     
            sta $f5                                  ; $fae8: 85 f5     
            lda #$00                                 ; $faea: a9 00     
            sta $4008                                ; $faec: 8d 08 40  
            sta $f6                                  ; $faef: 85 f6     
            sta $07f6                                ; $faf1: 8d f6 07  
            lda #$10                                 ; $faf4: a9 10     
            sta $4004                                ; $faf6: 8d 04 40  
            sta $400c                                ; $faf9: 8d 0c 40  
            ldx #$8e                                 ; $fafc: a2 8e     
            ldy #$fa                                 ; $fafe: a0 fa     
__fb00:     jsr __f687                               ; $fb00: 20 87 f6  
            rts                                      ; $fb03: 60        

;-------------------------------------------------------------------------------
__fb04:     lda $07e9                                ; $fb04: ad e9 07  
            and #$20                                 ; $fb07: 29 20     
            bne __fb10                               ; $fb09: d0 05     
            lda #$02                                 ; $fb0b: a9 02     
            sta $07f5                                ; $fb0d: 8d f5 07  
__fb10:     ldy #$08                                 ; $fb10: a0 08     
            lda #$df                                 ; $fb12: a9 df     
            jmp __fba5                               ; $fb14: 4c a5 fb  

;-------------------------------------------------------------------------------
__fb17:     ldy #$04                                 ; $fb17: a0 04     
            lda #$7f                                 ; $fb19: a9 7f     
            jmp __fba5                               ; $fb1b: 4c a5 fb  

;-------------------------------------------------------------------------------
__fb1e:     ldy #$00                                 ; $fb1e: a0 00     
            lda #$02                                 ; $fb20: a9 02     
            jmp __fbc1                               ; $fb22: 4c c1 fb  

;-------------------------------------------------------------------------------
__fb25:     lda $07e8                                ; $fb25: ad e8 07  
            bne __fb5e                               ; $fb28: d0 34     
            lda CurrentMusic                         ; $fb2a: a5 f2     
            lsr                                      ; $fb2c: 4a        
            bcs __fb82                               ; $fb2d: b0 53     
            lsr                                      ; $fb2f: 4a        
            bcs __fb1e                               ; $fb30: b0 ec     
            lsr                                      ; $fb32: 4a        
            bcs __fb4c                               ; $fb33: b0 17     
            lsr                                      ; $fb35: 4a        
            bcs __fb7c                               ; $fb36: b0 44     
            lsr                                      ; $fb38: 4a        
            bcs __fb69                               ; $fb39: b0 2e     
            lsr                                      ; $fb3b: 4a        
            bcs __fb5e                               ; $fb3c: b0 20     
            lsr                                      ; $fb3e: 4a        
            bcs __fb58                               ; $fb3f: b0 17     
            lsr                                      ; $fb41: 4a        
            bcs __fb52                               ; $fb42: b0 0e     
            lda $f6                                  ; $fb44: a5 f6     
            bne __fb49                               ; $fb46: d0 01     
            rts                                      ; $fb48: 60        

;-------------------------------------------------------------------------------
__fb49:     jmp __f504                               ; $fb49: 4c 04 f5  

;-------------------------------------------------------------------------------
__fb4c:     ldy #$02                                 ; $fb4c: a0 02     
            lda #$04                                 ; $fb4e: a9 04     
            bne __fba5                               ; $fb50: d0 53     
__fb52:     ldy #$09                                 ; $fb52: a0 09     
            lda #$80                                 ; $fb54: a9 80     
            bne __fb6d                               ; $fb56: d0 15     
__fb58:     ldy #$07                                 ; $fb58: a0 07     
            lda #$40                                 ; $fb5a: a9 40     
            bne __fb6d                               ; $fb5c: d0 0f     
__fb5e:     lda #$00                                 ; $fb5e: a9 00     
            sta $07e8                                ; $fb60: 8d e8 07  
            ldy #$06                                 ; $fb63: a0 06     
            lda #$20                                 ; $fb65: a9 20     
            bne __fbc1                               ; $fb67: d0 58     
__fb69:     ldy #$05                                 ; $fb69: a0 05     
            lda #$10                                 ; $fb6b: a9 10     
__fb6d:     jsr __f6a8                               ; $fb6d: 20 a8 f6  
            ldx #$fc                                 ; $fb70: a2 fc     
            ldy #$fc                                 ; $fb72: a0 fc     
            jsr __f712                               ; $fb74: 20 12 f7  
            inc $07f0                                ; $fb77: ee f0 07  
            bne __fb49                               ; $fb7a: d0 cd     
__fb7c:     ldy #$03                                 ; $fb7c: a0 03     
            lda #$08                                 ; $fb7e: a9 08     
            bne __fb86                               ; $fb80: d0 04     
__fb82:     ldy #$01                                 ; $fb82: a0 01     
            lda #$01                                 ; $fb84: a9 01     
__fb86:     jsr __f6a8                               ; $fb86: 20 a8 f6  
            ldx #$80                                 ; $fb89: a2 80     
            ldy #$80                                 ; $fb8b: a0 80     
__fb8d:     jsr __f71a                               ; $fb8d: 20 1a f7  
            lda #$83                                 ; $fb90: a9 83     
            sta $4001                                ; $fb92: 8d 01 40  
            lda #$7f                                 ; $fb95: a9 7f     
            sta $4005                                ; $fb97: 8d 05 40  
            bne __fbaf                               ; $fb9a: d0 13     
            jsr __f6a8                               ; $fb9c: 20 a8 f6  
            ldx #$04                                 ; $fb9f: a2 04     
            ldy #$04                                 ; $fba1: a0 04     
            bne __fbac                               ; $fba3: d0 07     
__fba5:     jsr __f6a8                               ; $fba5: 20 a8 f6  
            ldx #$80                                 ; $fba8: a2 80     
            ldy #$80                                 ; $fbaa: a0 80     
__fbac:     jsr __f712                               ; $fbac: 20 12 f7  
__fbaf:     lda #$00                                 ; $fbaf: a9 00     
            sta $07f0                                ; $fbb1: 8d f0 07  
            lda $f4                                  ; $fbb4: a5 f4     
            and #$20                                 ; $fbb6: 29 20     
            beq __fb49                               ; $fbb8: f0 8f     
            lda #$d5                                 ; $fbba: a9 d5     
            sta $4001                                ; $fbbc: 8d 01 40  
            bne __fb49                               ; $fbbf: d0 88     
__fbc1:     jsr __f6a8                               ; $fbc1: 20 a8 f6  
            ldx #$80                                 ; $fbc4: a2 80     
            ldy #$ba                                 ; $fbc6: a0 ba     
            bne __fb8d                               ; $fbc8: d0 c3     

;-------------------------------------------------------------------------------
__fbca:     .hex 0b 14 1d 26                         ; $fbca: 0b 14 1d 26   Data
            .hex 2f 38 41 4a                         ; $fbce: 2f 38 41 4a   Data
            .hex 53 5c 65 0c                         ; $fbd2: 53 5c 65 0c   Data
            .hex 02 ff 0b ff                         ; $fbd6: 02 ff 0b ff   Data
            .hex 1e ff 31 ff                         ; $fbda: 1e ff 31 ff   Data
            .hex 15 18 fe 2a                         ; $fbde: 15 18 fe 2a   Data
            .hex fe 65 fe 86                         ; $fbe2: fe 65 fe 86   Data
            .hex fe 0c 0d fe                         ; $fbe6: fe 0c 0d fe   Data
            .hex 00 00 13 fe                         ; $fbea: 00 00 13 fe   Data
            .hex 00 00 15 38                         ; $fbee: 00 00 15 38   Data
            .hex ff 5a ff 79                         ; $fbf2: ff 5a ff 79   Data
            .hex ff 94 ff 00                         ; $fbf6: ff 94 ff 00   Data
            .hex 00 00 d7 fe                         ; $fbfa: 00 00 d7 fe   Data
            .hex ed fe 00 00                         ; $fbfe: ed fe 00 00   Data
            .hex 00 b3 ff c9                         ; $fc02: 00 b3 ff c9   Data
            .hex ff da ff ef                         ; $fc06: ff da ff ef   Data
            .hex ff 15 a5 fc                         ; $fc0a: ff 15 a5 fc   Data
            .hex 0a fd 98 fd                         ; $fc0e: 0a fd 98 fd   Data
            .hex e0 fd 15 b2                         ; $fc12: e0 fd 15 b2   Data
            .hex fe 00 00 c5                         ; $fc16: fe 00 00 c5   Data
            .hex fe 00 00 15                         ; $fc1a: fe 00 00 15   Data
            .hex 00 00 92 fe                         ; $fc1e: 00 00 92 fe   Data
            .hex a1 fe 00 00                         ; $fc22: a1 fe 00 00   Data
            .hex 0c 59 fc 72                         ; $fc26: 0c 59 fc 72   Data
            .hex fc 8c fc 00                         ; $fc2a: fc 8c fc 00   Data
            .hex 00 00 00 00                         ; $fc2e: 00 00 00 00   Data
            .hex 38 fc 49 fc                         ; $fc32: 38 fc 49 fc   Data
            .hex 00 00 82 02                         ; $fc36: 00 00 82 02   Data
            .hex 8b 02 80 08                         ; $fc3a: 8b 02 80 08   Data
            .hex 02 10 02 16                         ; $fc3e: 02 10 02 16   Data
            .hex 02 52 02 02                         ; $fc42: 02 52 02 02   Data
            .hex 02 1a 00 82                         ; $fc46: 02 1a 00 82   Data
            .hex 02 80 10 02                         ; $fc4a: 02 80 10 02   Data
            .hex 16 02 52 02                         ; $fc4e: 16 02 52 02   Data
            .hex 5a 02 02 02                         ; $fc52: 5a 02 02 02   Data
            .hex 56 81 02 80                         ; $fc56: 56 81 02 80   Data
            .hex 12 02 0c 02                         ; $fc5a: 12 02 0c 02   Data
            .hex 04 02 0c 02                         ; $fc5e: 04 02 0c 02   Data
            .hex 04 02 2a 02                         ; $fc62: 04 02 2a 02   Data
            .hex 81 04 02 80                         ; $fc66: 81 04 02 80   Data
            .hex 04 02 81 04                         ; $fc6a: 04 02 81 04   Data
            .hex 88 02 02 00                         ; $fc6e: 88 02 02 00   Data
            .hex 88 02 02 80                         ; $fc72: 88 02 02 80   Data
            .hex 04 02 2a 02                         ; $fc76: 04 02 2a 02   Data
            .hex 24 02 2a 02                         ; $fc7a: 24 02 2a 02   Data
            .hex 24 02 1c 02                         ; $fc7e: 24 02 1c 02   Data
            .hex 81 22 02 80                         ; $fc82: 81 22 02 80   Data
            .hex 22 02 81 24                         ; $fc86: 22 02 81 24   Data
            .hex 88 02 88 02                         ; $fc8a: 88 02 88 02   Data
            .hex 80 56 02 4e                         ; $fc8e: 80 56 02 4e   Data
            .hex 02 12 02 4e                         ; $fc92: 02 12 02 4e   Data
            .hex 02 12 02 0c                         ; $fc96: 02 12 02 0c   Data
            .hex 02 81 10 02                         ; $fc9a: 02 81 10 02   Data
            .hex 80 10 02 81                         ; $fc9e: 80 10 02 81   Data
            .hex 12 88 02 c3                         ; $fca2: 12 88 02 c3   Data
            .hex 81 02 02 1c                         ; $fca6: 81 02 02 1c   Data
            .hex 02 02 02 1c                         ; $fcaa: 02 02 02 1c   Data
            .hex 1c ff c6 88                         ; $fcae: 1c ff c6 88   Data
            .hex 1c ff c7 82                         ; $fcb2: 1c ff c7 82   Data
            .hex 4c 4c 2a 4c                         ; $fcb6: 4c 4c 2a 4c   Data
            .hex ff c6 88 1c                         ; $fcba: ff c6 88 1c   Data
            .hex ff c4 81 46                         ; $fcbe: ff c4 81 46   Data
            .hex 02 46 02 32                         ; $fcc2: 02 46 02 32   Data
            .hex 02 46 80 2e                         ; $fcc6: 02 46 80 2e   Data
            .hex 2e ff c3 82                         ; $fcca: 2e ff c3 82   Data
            .hex 46 46 81 32                         ; $fcce: 46 46 81 32   Data
            .hex 32 46 2e ff                         ; $fcd2: 32 46 2e ff   Data
            .hex 80 0c 0c 81                         ; $fcd6: 80 0c 0c 81   Data
            .hex 46 46 46 80                         ; $fcda: 46 46 46 80   Data
            .hex 04 04 81 46                         ; $fcde: 04 04 81 46   Data
            .hex 46 02 c8 82                         ; $fce2: 46 02 c8 82   Data
            .hex 4c 4c 2a 4c                         ; $fce6: 4c 4c 2a 4c   Data
            .hex ff c2 81 46                         ; $fcea: ff c2 81 46   Data
            .hex 80 32 32 82                         ; $fcee: 80 32 32 82   Data
            .hex 46 04 81 46                         ; $fcf2: 46 04 81 46   Data
            .hex 2a ff c2 81                         ; $fcf6: 2a ff c2 81   Data
            .hex 0c 0c 80 04                         ; $fcfa: 0c 0c 80 04   Data
            .hex 04 81 04 80                         ; $fcfe: 04 81 04 80   Data
            .hex 2e 2e 81 2e                         ; $fd02: 2e 2e 81 2e   Data
            .hex 82 24 ff 00                         ; $fd06: 82 24 ff 00   Data
            .hex 81 32 02 02                         ; $fd0a: 81 32 02 02   Data
            .hex 06 0c 32 02                         ; $fd0e: 06 0c 32 02   Data
            .hex 02 8a 2e 8b                         ; $fd12: 02 8a 2e 8b   Data
            .hex 02 8a 2e 8b                         ; $fd16: 02 8a 2e 8b   Data
            .hex 02 8a 2e 8b                         ; $fd1a: 02 8a 2e 8b   Data
            .hex 02 88 2e 32                         ; $fd1e: 02 88 2e 32   Data
            .hex 2e d0 8c 2c                         ; $fd22: 2e d0 8c 2c   Data
            .hex 24 ff d0 2e                         ; $fd26: 24 ff d0 2e   Data
            .hex 20 ff c3 80                         ; $fd2a: 20 ff c3 80   Data
            .hex 28 02 82 02                         ; $fd2e: 28 02 82 02   Data
            .hex 80 2c 02 32                         ; $fd32: 80 2c 02 32   Data
            .hex 02 24 02 82                         ; $fd36: 02 24 02 82   Data
            .hex 02 81 02 80                         ; $fd3a: 02 81 02 80   Data
            .hex 28 02 06 02                         ; $fd3e: 28 02 06 02   Data
            .hex 28 02 81 02                         ; $fd42: 28 02 81 02   Data
            .hex 80 24 02 32                         ; $fd46: 80 24 02 32   Data
            .hex 02 24 02 ff                         ; $fd4a: 02 24 02 ff   Data
            .hex 80 28 02 82                         ; $fd4e: 80 28 02 82   Data
            .hex 02 80 2c 02                         ; $fd52: 02 80 2c 02   Data
            .hex 32 02 24 02                         ; $fd56: 32 02 24 02   Data
            .hex 82 02 89 0c                         ; $fd5a: 82 02 89 0c   Data
            .hex 0a 08 06 32                         ; $fd5e: 0a 08 06 32   Data
            .hex 30 2e 2c 2a                         ; $fd62: 30 2e 2c 2a   Data
            .hex 28 26 24 02                         ; $fd66: 28 26 24 02   Data
            .hex 02 02 86 02                         ; $fd6a: 02 02 86 02   Data
            .hex c7 84 02 ff                         ; $fd6e: c7 84 02 ff   Data
            .hex c4 80 28 02                         ; $fd72: c4 80 28 02   Data
            .hex 82 02 80 2c                         ; $fd76: 82 02 80 2c   Data
            .hex 02 32 02 24                         ; $fd7a: 02 32 02 24   Data
            .hex 02 82 02 81                         ; $fd7e: 02 82 02 81   Data
            .hex 02 80 28 02                         ; $fd82: 02 80 28 02   Data
            .hex 06 02 28 02                         ; $fd86: 06 02 28 02   Data
            .hex 81 02 80 24                         ; $fd8a: 81 02 80 24   Data
            .hex 02 32 02 24                         ; $fd8e: 02 32 02 24   Data
            .hex 02 ff c8 84                         ; $fd92: 02 ff c8 84   Data
            .hex 02 ff 81 14                         ; $fd96: 02 ff 81 14   Data
            .hex 02 02 14 1a                         ; $fd9a: 02 02 14 1a   Data
            .hex 14 02 02 88                         ; $fd9e: 14 02 02 88   Data
            .hex 10 10 10 10                         ; $fda2: 10 10 10 10   Data
            .hex 14 10 85 3c                         ; $fda6: 14 10 85 3c   Data
            .hex 81 44 85 4a                         ; $fdaa: 81 44 85 4a   Data
            .hex 81 44 88 28                         ; $fdae: 81 44 88 28   Data
            .hex 24 20 46 42                         ; $fdb2: 24 20 46 42   Data
            .hex 40 c6 81 3c                         ; $fdb6: 40 c6 81 3c   Data
            .hex 02 02 44 02                         ; $fdba: 02 02 44 02   Data
            .hex 02 02 4a 02                         ; $fdbe: 02 02 4a 02   Data
            .hex 46 36 36 38                         ; $fdc2: 46 36 36 38   Data
            .hex 38 02 3a 02                         ; $fdc6: 38 02 3a 02   Data
            .hex 80 3c 3c 81                         ; $fdca: 80 3c 3c 81   Data
            .hex 02 24 02 02                         ; $fdce: 02 24 02 02   Data
            .hex 2c 24 88 24                         ; $fdd2: 2c 24 88 24   Data
            .hex 1e 46 36 38                         ; $fdd6: 1e 46 36 38   Data
            .hex 3a ff c4 84                         ; $fdda: 3a ff c4 84   Data
            .hex 02 ff d8 81                         ; $fdde: 02 ff d8 81   Data
            .hex 06 ff c6 88                         ; $fde2: 06 ff c6 88   Data
            .hex 06 ff c7 81                         ; $fde6: 06 ff c7 81   Data
            .hex 06 06 80 06                         ; $fdea: 06 06 80 06   Data
            .hex 06 81 06 06                         ; $fdee: 06 81 06 06   Data
            .hex 80 06 06 81                         ; $fdf2: 80 06 06 81   Data
            .hex 06 06 ff c6                         ; $fdf6: 06 06 ff c6   Data
            .hex 88 06 ff e0                         ; $fdfa: 88 06 ff e0   Data
            .hex 81 06 06 ff                         ; $fdfe: 81 06 06 ff   Data
            .hex 82 0f 81 06                         ; $fe02: 82 0f 81 06   Data
            .hex 06 ea 06 06                         ; $fe06: 06 ea 06 06   Data
            .hex 06 06 ff c5                         ; $fe0a: 06 06 ff c5   Data
            .hex 80 0e 58 ff                         ; $fe0e: 80 0e 58 ff   Data
            .hex 00 c5 80 0e                         ; $fe12: 00 c5 80 0e   Data
            .hex 58 ff 82 1c                         ; $fe16: 58 ff 82 1c   Data
            .hex 1c c3 82 1c                         ; $fe1a: 1c c3 82 1c   Data
            .hex 1c 81 1c 1c                         ; $fe1e: 1c 81 1c 1c   Data
            .hex 1c 02 ff c7                         ; $fe22: 1c 02 ff c7   Data
            .hex 88 1c ff 00                         ; $fe26: 88 1c ff 00   Data
            .hex 83 02 80 0e                         ; $fe2a: 83 02 80 0e   Data
            .hex 02 0e 02 0c                         ; $fe2e: 02 0e 02 0c   Data
            .hex 02 0e 02 4e                         ; $fe32: 02 0e 02 4e   Data
            .hex 02 02 02 0e                         ; $fe36: 02 02 02 0e   Data
            .hex 02 0c 02 02                         ; $fe3a: 02 0c 02 02   Data
            .hex 02 0e 02 0c                         ; $fe3e: 02 0e 02 0c   Data
            .hex 02 0e 02 4e                         ; $fe42: 02 0e 02 4e   Data
            .hex 02 02 02 0e                         ; $fe46: 02 02 02 0e   Data
            .hex 02 0c 02 0e                         ; $fe4a: 02 0c 02 0e   Data
            .hex 02 0e 02 0c                         ; $fe4e: 02 0e 02 0c   Data
            .hex 02 0e 02 4e                         ; $fe52: 02 0e 02 4e   Data
            .hex 02 02 02 0e                         ; $fe56: 02 02 02 0e   Data
            .hex 02 0c 02 88                         ; $fe5a: 02 0c 02 88   Data
            .hex 4e 18 16 12                         ; $fe5e: 4e 18 16 12   Data
            .hex 0e 0c 0e 83                         ; $fe62: 0e 0c 0e 83   Data
            .hex 02 81 3e 3e                         ; $fe66: 02 81 3e 3e   Data
            .hex 82 46 1c 46                         ; $fe6a: 82 46 1c 46   Data
            .hex 81 02 38 3e                         ; $fe6e: 81 02 38 3e   Data
            .hex 02 82 46 1c                         ; $fe72: 02 82 46 1c   Data
            .hex 82 48 48 81                         ; $fe76: 82 48 48 81   Data
            .hex 3e 3e 82 38                         ; $fe7a: 3e 3e 82 38   Data
            .hex 88 24 20 1c                         ; $fe7e: 88 24 20 1c   Data
            .hex 48 46 42 3e                         ; $fe82: 48 46 42 3e   Data
            .hex 82 09 09 c6                         ; $fe86: 82 09 09 c6   Data
            .hex 82 03 0c ff                         ; $fe8a: 82 03 0c ff   Data
            .hex c6 88 06 ff                         ; $fe8e: c6 88 06 ff   Data
            .hex ed 89 2a 02                         ; $fe92: ed 89 2a 02   Data
            .hex 04 0c 02 04                         ; $fe96: 04 0c 02 04   Data
            .hex 08 02 30 26                         ; $fe9a: 08 02 30 26   Data
            .hex 02 30 ff 80                         ; $fe9e: 02 30 ff 80   Data
            .hex 02 ed 89 0c                         ; $fea2: 02 ed 89 0c   Data
            .hex 02 12 4e 02                         ; $fea6: 02 12 4e 02   Data
            .hex 12 18 02 0e                         ; $feaa: 12 18 02 0e   Data
            .hex 08 02 0e ff                         ; $feae: 08 02 0e ff   Data
            .hex 80 42 02 48                         ; $feb2: 80 42 02 48   Data
            .hex 02 1e 02 24                         ; $feb6: 02 1e 02 24   Data
            .hex 02 02 02 2a                         ; $feba: 02 02 02 2a   Data
            .hex 02 c6 8c 30                         ; $febe: 02 c6 8c 30   Data
            .hex 2a ff 00 80                         ; $fec2: 2a ff 00 80   Data
            .hex 24 02 2a 02                         ; $fec6: 24 02 2a 02   Data
            .hex 30 02 06 02                         ; $feca: 30 02 06 02   Data
            .hex 02 02 0c 02                         ; $fece: 02 02 0c 02   Data
            .hex c6 8c 12 18                         ; $fed2: c6 8c 12 18   Data
            .hex ff 80 56 54                         ; $fed6: ff 80 56 54   Data
            .hex 52 50 81 02                         ; $feda: 52 50 81 02   Data
            .hex 80 5e 5a 54                         ; $fede: 80 5e 5a 54   Data
            .hex 50 18 14 10                         ; $fee2: 50 18 14 10   Data
            .hex 0a 06 30 2c                         ; $fee6: 0a 06 30 2c   Data
            .hex 28 02 00 80                         ; $feea: 28 02 00 80   Data
            .hex 1a 18 16 14                         ; $feee: 1a 18 16 14   Data
            .hex 81 02 80 02                         ; $fef2: 81 02 80 02   Data
            .hex 5e 5a 54 50                         ; $fef6: 5e 5a 54 50   Data
            .hex 18 14 10 0a                         ; $fefa: 18 14 10 0a   Data
            .hex 06 30 2c 28                         ; $fefe: 06 30 2c 28   Data
            .hex 82 1c 02 1c                         ; $ff02: 82 1c 02 1c   Data
            .hex 02 02 1c 1c                         ; $ff06: 02 02 1c 1c   Data
            .hex 00 81 10 0a                         ; $ff0a: 00 81 10 0a   Data
            .hex 32 28 80 32                         ; $ff0e: 32 28 80 32   Data
            .hex 02 32 02 82                         ; $ff12: 02 32 02 82   Data
            .hex 32 81 06 02                         ; $ff16: 32 81 06 02   Data
            .hex 06 02 82 32                         ; $ff1a: 06 02 82 32   Data
            .hex 81 54 1a 10                         ; $ff1e: 81 54 1a 10   Data
            .hex 0a 80 10 02                         ; $ff22: 0a 80 10 02   Data
            .hex 10 02 82 10                         ; $ff26: 10 02 82 10   Data
            .hex 81 16 02 16                         ; $ff2a: 81 16 02 16   Data
            .hex 02 82 0a 83                         ; $ff2e: 02 82 0a 83   Data
            .hex 03 0c 82 03                         ; $ff32: 03 0c 82 03   Data
            .hex 0c 0c c2 88                         ; $ff36: 0c 0c c2 88   Data
            .hex 1c 1c 1c 1c                         ; $ff3a: 1c 1c 1c 1c   Data
            .hex 1c 1c 83 1c                         ; $ff3e: 1c 1c 83 1c   Data
            .hex 80 04 04 2a                         ; $ff42: 80 04 04 2a   Data
            .hex 02 82 1c ff                         ; $ff46: 02 82 1c ff   Data
            .hex 81 4c 02 4c                         ; $ff4a: 81 4c 02 4c   Data
            .hex 02 2a 02 4c                         ; $ff4e: 02 2a 02 4c   Data
            .hex 1c 81 4c 02                         ; $ff52: 1c 81 4c 02   Data
            .hex 4c 02 4c 00                         ; $ff56: 4c 02 4c 00   Data
            .hex 88 2e 2e 2e                         ; $ff5a: 88 2e 2e 2e   Data
            .hex 30 04 30 c4                         ; $ff5e: 30 04 30 c4   Data
            .hex 80 2e 04 ff                         ; $ff62: 80 2e 04 ff   Data
            .hex 83 02 88 2e                         ; $ff66: 83 02 88 2e   Data
            .hex 2e 2e 30 04                         ; $ff6a: 2e 2e 30 04   Data
            .hex 30 c4 80 2e                         ; $ff6e: 30 c4 80 2e   Data
            .hex 04 ff 83 02                         ; $ff72: 04 ff 83 02   Data
            .hex 84 02 02 c2                         ; $ff76: 84 02 02 c2   Data
            .hex 88 3e 3e 3e                         ; $ff7a: 88 3e 3e 3e   Data
            .hex 42 46 42 84                         ; $ff7e: 42 46 42 84   Data
            .hex 3e ff 85 3e                         ; $ff82: 3e ff 85 3e   Data
            .hex 81 3e 88 1c                         ; $ff86: 81 3e 88 1c   Data
            .hex 46 1c 81 02                         ; $ff8a: 46 1c 81 02   Data
            .hex 3e 3e 3e 82                         ; $ff8e: 3e 3e 3e 82   Data
            .hex 34 02 c2 88                         ; $ff92: 34 02 c2 88   Data
            .hex 06 06 06 06                         ; $ff96: 06 06 06 06   Data
            .hex 06 06 82 06                         ; $ff9a: 06 06 82 06   Data
            .hex 06 06 06 ff                         ; $ff9e: 06 06 06 ff   Data
            .hex c2 81 06 06                         ; $ffa2: c2 81 06 06   Data
            .hex 80 06 06 81                         ; $ffa6: 80 06 06 81   Data
            .hex 06 06 06 06                         ; $ffaa: 06 06 06 06   Data
            .hex 80 06 06 ff                         ; $ffae: 80 06 06 ff   Data
            .hex 09 80 10 02                         ; $ffb2: 09 80 10 02   Data
            .hex 10 02 10 02                         ; $ffb6: 10 02 10 02   Data
            .hex 0c 0c 0c 02                         ; $ffba: 0c 0c 0c 02   Data
            .hex 0c 02 14 14                         ; $ffbe: 0c 02 14 14   Data
            .hex 14 02 14 02                         ; $ffc2: 14 02 14 02   Data
            .hex 85 10 00 80                         ; $ffc6: 85 10 00 80   Data
            .hex 32 02 32 02                         ; $ffca: 32 02 32 02   Data
            .hex 32 02 c2 32                         ; $ffce: 32 02 c2 32   Data
            .hex 32 32 02 32                         ; $ffd2: 32 32 02 32   Data
            .hex 02 ff 85 32                         ; $ffd6: 02 ff 85 32   Data
            .hex 80 54 02 54                         ; $ffda: 80 54 02 54   Data
            .hex 02 54 02 50                         ; $ffde: 02 54 02 50   Data
            .hex 50 50 02 50                         ; $ffe2: 50 50 02 50   Data
            .hex 02 56 56 56                         ; $ffe6: 02 56 56 56   Data
            .hex 02 56 02 85                         ; $ffea: 02 56 02 85   Data
            .hex 54 c4 85 0c                         ; $ffee: 54 c4 85 0c   Data
            .hex ff ff ff ff                         ; $fff2: ff ff ff ff   Data
            .hex ff                                  ; $fff6: ff            Data

;-------------------------------------------------------------------------------
__fff7:     jmp __f758                               ; $fff7: 4c 58 f7  

;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; Vector Table
;-------------------------------------------------------------------------------
vectors:    .dw nmi                        ; $fffa: 94 c0     Vector table
            .dw reset                      ; $fffc: 00 c0     Vector table
            .dw irq                        ; $fffe: f7 c0     Vector table

;-------------------------------------------------------------------------------
; CHR-ROM
;-------------------------------------------------------------------------------
            .incbin balloon_fight.chr                ; Include CHR-ROM
