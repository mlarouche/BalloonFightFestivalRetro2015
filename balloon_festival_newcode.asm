Titlescreen_UpdateParameters:
    ldx GameMode
    lda GameModeIsBalloonTrip,x
    sta IsBalloonTrip
    lda GameModeNumberOfPlayers,x
    sta NumberOfPlayers
    lda NewTitleScreenCursorOptionY,x
    sta $057b
    lda #$2c
    sta $0567
    ldx #$00
    stx $055d
    jmp __ce2f

GameModeIsBalloonTrip:
    .hex 0 0 1 0

GameModeNumberOfPlayers:
    .hex 0 1 0 1

IsCompetitionSelected:
    ; Original code hijacked
    ldx #$09
    lda #$00
-
    sta $03, x
    dex
    bpl -
    sta $3e

    lda GameMode
    cmp #$03
    bne +

    jsr CompetitionUpdate
+
    rts

CompetitionUpdate:
    jsr EnableNMI
    jsr LoadCompetitionPresentationScreen

    lda #$0F
    sta $4015
    lda #$20
    sta CurrentMusic

    lda #$00
    sta Player1State
    sta Player2State

competitionUpdateLoop:
    jsr WaitForNMI
    jsr ReadInputP1
    tax
    and #Button_Start
    beq +
    lda Player1State
    beq +
    lda Player2State
    jmp competitionUpdateExit
+
    txa
    and #Button_A
    beq +
    lda Player1State
    bne +

    lda #$01
    sta Player1State

    jsr HideEverything
    jsr DisableNMI

    lda #<Player1JoinedNametableUpdatePtr
    sta LoadPointerLow
    lda #>Player1JoinedNametableUpdatePtr
    sta LoadPointerHigh
    jsr LoadNametable

    lda Player2State
    beq noPlayer2Confirm
    lda #<PressStartNametableUpdatePtr
    sta LoadPointerLow
    lda #>PressStartNametableUpdatePtr
    sta LoadPointerHigh
    jsr LoadNametable
noPlayer2Confirm:
    jsr EnableNMI
    jsr ShowScreen
    jmp competitionUpdateLoop
+
    ldx #$01
    jsr ReadInputP2
    tax
    and #Button_Start
    beq +
    lda Player1State
    beq +
    lda Player2State
    bne competitionUpdateExit
+
    txa
    and #Button_A
    beq +
    lda Player2State
    bne +

    lda #$01
    sta Player2State

    jsr HideEverything
    jsr DisableNMI

    lda #<Player2JoinedNametableUpdatePtr
    sta LoadPointerLow
    lda #>Player2JoinedNametableUpdatePtr
    sta LoadPointerHigh
    jsr LoadNametable

    lda Player1State
    beq noPlayer1Confirm
    lda #<PressStartNametableUpdatePtr
    sta LoadPointerLow
    lda #>PressStartNametableUpdatePtr
    sta LoadPointerHigh
    jsr LoadNametable
noPlayer1Confirm:
    jsr EnableNMI
    jsr ShowScreen
+
    jmp competitionUpdateLoop
competitionUpdateExit:
    jsr StartCompetitionScreen
    rts

LoadCompetitionPresentationScreen:
    jsr ClearScreenAndSprites
    jsr HideEverything
    jsr WaitForNMI
    jsr DisableNMI

    ldx #24
    ldy #0
-
    lda IwataSpriteCompPresentation,y
    sta $0200,y
    iny
    dex
    bne -

    lda #<CompetitionPresentationPtr
    sta LoadPointerLow
    lda #>CompetitionPresentationPtr
    sta LoadPointerHigh
    jsr LoadNametable
    jsr EnableNMI
    jmp ShowScreen

StartCompetitionScreen:
    lda #$00
    sta $4015
    jsr ClearScreenAndSprites
    jsr HideEverything
    jsr WaitForNMI
    jsr DisableNMI

    lda #<StartCompetitionNametablePtr
    sta LoadPointerLow
    lda #>StartCompetitionNametablePtr
    sta LoadPointerHigh
    jsr LoadNametable
    jsr EnableNMI
    jsr ShowScreen

    lda #$00
    sta GameTimer
-
    lda GameTimer
    cmp #150 ; 2.5 seconds in frame count
    bne -
    rts

CompetitionPresentationPtr:
    .db <CompetitionPresentationNametable
    .db >CompetitionPresentationNametable
    .hex 0 0

CompetitionPresentationNametable:
    ; background palette 0
    .hex 3f 00 04 0f 30 27 2a
    ; sprite palette 0
    .hex 3f 10 04 0f 0C 1D 37

    ; Nametable data
    .hex 20 A8 11
    .db "PLEASE"-$37
    .hex 24
    .db "UNDERSTAND"-$37

    .hex 21 63 1A
    .db "BIENVENUE"-$37
    .hex 24
    .db "A"-$37
    .hex 24
    .db "LA"-$37
    .hex 24
    .db "COMPETITION"-$37

    .hex 21 87 11
    .db "DE"-$37
    .hex 24
    .db "BALLOON"-$37
    .hex 24
    .db "FIGHT"-$37
    .hex 2C ; !

    .hex 21 E1 1D
    .db "2"-"0"
    .hex 24
    .db "JOUEURS"-$37
    .hex 27 ; ,
    .db "3"-"0"
    .hex 24
    .db "MINUTES"-$37
    .hex 27 ; ,
    .db "CELUI"-$37
    .hex 24
    .db "QUI"-$37

    .hex 22 04 19
    .db "A"-$37
    .hex 24
    .db "LE"-$37
    .hex 24
    .db "MAX"-$37
    .hex 24
    .db "DE"-$37
    .hex 24
    .db "POINTS"-$37
    .hex 24
    .db "GAGNE"-$37
    .hex 2C ; !

    .hex 22 62 1C
    .db "APPUYEZ"-$37
    .hex 24
    .db "SUR"-$37
    .hex 24
    .db "A"-$37
    .hex 24
    .db "POUR"-$37
    .hex 24
    .db "CONFIRMER"-$37

    .hex 22 89 0F
    .db "VOTRE"-$37
    .hex 24
    .db "PRESENCE"-$37
    .hex 26 ; .

    .hex 22 E7 13
    .db "JOUEUR"-$37
    .hex 24
    .db "1"-"0"
    .hex 29 ; =
    .db "EN"-$37
    .hex 24
    .db "ATTENTE"-$37

    .hex 23 27 13
    .db "JOUEUR"-$37
    .hex 24
    .db "2"-"0"
    .hex 29 ; =
    .db "EN"-$37
    .hex 24
    .db "ATTENTE"-$37

    ; EOD
    .hex 0

IwataSpriteX1 = 120
IwataSpriteX2 = 128
IwataSpriteY1 = 56
IwataSpriteY2 = 64
IwataSpriteY3 = 72

IwataSpriteCompPresentation:
    .db IwataSpriteY1
    .hex 0
    .hex 0
    .db IwataSpriteX1

    .db IwataSpriteY1
    .hex 0B
    .hex 0
    .db IwataSpriteX2

    .db IwataSpriteY2
    .hex 38
    .hex 0
    .db IwataSpriteX1

    .db IwataSpriteY2
    .hex 39
    .hex 0
    .db IwataSpriteX2

    .db IwataSpriteY3
    .hex 27
    .hex 0
    .db IwataSpriteX1

    .db IwataSpriteY3
    .hex 05
    .hex 0
    .db IwataSpriteX2

Player1JoinedNametableUpdatePtr:
    .db <Player1JoinedNametableUpdate
    .db >Player1JoinedNametableUpdate
    .hex 0 0

Player1JoinedNametableUpdate:
    .hex 22 F0 0A
    .db "PRET"-$37
    .hex 2C ; !
    .dsb 5,$24
    
    ; EOD
    .hex 0
    
Player2JoinedNametableUpdatePtr:
    .db <Player2JoinedNametableUpdate
    .db >Player2JoinedNametableUpdate
    .hex 0 0

Player2JoinedNametableUpdate:
    .hex 23 30 0A
    .db "PRET"-$37
    .hex 2C ; !
    .dsb 5,$24

    ; EOD
    .hex 0

PressStartNametableUpdatePtr:
    .db <PressStartNametableUpdate
    .db >PressStartNametableUpdate
    .hex 0 0

PressStartNametableUpdate:
    .hex 23 68 11
    .db "APPUYEZ"-$37
    .hex 24
    .db "SUR"-$37
    .hex 24
    .db "START"-$37

    .hex 0

StartCompetitionNametablePtr:
    .db <StartCompetitionNametable
    .db >StartCompetitionNametable
    .hex 0
    .hex 0
    
StartCompetitionNametable:
    ; background palette 0
    .hex 3f 00 04 0f 30 27 2a

    .hex 21 AC 07
    .db "HAJIME"-$37
    .hex 2C ; !
    .hex 0

NewTitlescreenPtr:
    .db <NewTitlescreen
    .db >NewTitlescreen
    .hex 0 0

NewTitlescreen:
    ; background palette 0
    .hex 3f 00 04 0f 30 27 2a
    ; sprite palette 2
    .hex 3f 18 04 0f 16 30 21

    .hex 20 7c 21
    .hex f0 f1 24 24 24 24 e0 e1 e1 e2 e0 e1 e1 e2 e0 e2
    .hex 24 e0 e2 24 e0 e1 e1 e2 e0 e1 e1 e2 e0 ec 24 e0
    .hex e2

    .hex 20 a2 1b
    .hex e3 e3 e3
    .hex e5 e3 e3 e3
    .hex e5 e3 e5 24
    .hex e3 e5 24 e3
    .hex e3 e3 e5 e3
    .hex e3 e3 e5 e3
    .hex e3 f3 e3 e5

    .hex 20 c2 1b
    .hex e3
    .hex e4 e3 e7 e3
    .hex e4 e3 e5 e3
    .hex e5 24 e3 e5
    .hex 24 e3 e4 e3
    .hex e5 e3 e4 e3
    .hex e5 e3 e3 e3
    .hex e3 e5
    
    .hex 20 e2 1b
    .hex e3 e3 e3
    .hex e2 e3 e3 e3
    .hex e5 e3 e5 24
    .hex e3 e5 24 e3
    .hex e3 e3 e5 e3
    .hex e3 e3 e5 e3
    .hex e3 e3 e3 e5

    .hex 21 02 1b
    .hex e3
    .hex e4 e3 e5 e3
    .hex f2 e3 e5 e3
    .hex e3 e2 e3 e3
    .hex e2 e3 e3 e3
    .hex e5 e3 e3 e3
    .hex e5 e3 f2 e3
    .hex e3 e5
    
    .hex 21 22 1b
    .hex e6 e3 e3
    .hex e7 eb 24 e6
    .hex e7 e6 e3 e7
    .hex e6 e3 e7 e6
    .hex e3 e3 e7 e6
    .hex e3 e3 e7 eb
    .hex 24 e6 e3 e7
    
    .hex 21 4c 12
    .hex e0
    .hex e1 e1 e2 e0
    .hex e2 e0 e1 e1
    .hex e2 e8 24 e0
    .hex e2 e0 e1 e1
    .hex e2
    
    .hex 21 6c 12
    .hex e3 e3 e3 e7
    .hex e3 e5 e3 f5
    .hex f6 e7 e3 f3
    .hex e3 e5 e6 e3
    .hex e3 e7
    
    .hex 21 8c 12
    .hex e3 e3 ef
    .hex 24 e3 e5 e3
    .hex 24 24 24 e3
    .hex e3 e3 e5 24
    .hex e3 e5 24 
    
    .hex 21 ac 12
    .hex e3 e3
    .hex e1 ea e3 e5
    .hex e3 e9 e3 e2
    .hex e3 e3 e3 e5
    .hex 24 e3 e5 24
    
    .hex 21 cc 12
    .hex e3
    .hex e3 ef 24 e3
    .hex e5 e3 f3 e3
    .hex e5 e3 f2 e3
    .hex e5 24 e3 e5
    .hex 24
    
    .hex 21 ec 12
    .hex e6 e7 24 24
    .hex e6 e7 e6 e7
    .hex e6 e7 eb 24
    .hex e6 e7 24 e6
    .hex e7 24 
    
    ; HOMMAGE A
    .hex 21 82 09
    .db "HOMMAGE"-$37
    .hex 24
    .db "A"-$37
    
    ; SATORU
    .hex 21 A2 09
    .hex 24 24 24
    .db "SATORU"-$37
    
    ; IWATA
    .hex 21 C2 09
    .hex 24 24 24 24
    .db "IWATA"-$37
    
    ; First choice
    .hex 22 48 11
    .db "A"-$37
    .hex 24 24
    .db "PARTIE"-$37
    .hex 24
    .db "1"-"0"
    .hex 24
    .db "IWATA"-$37
    
    ; Second choice
    .hex 22 88 11
    .db "B"-$37
    .hex 24 24
    .db "PARTIE"-$37
    .hex 24
    .db "2"-"0"
    .hex 24
    .db "IWATA"-$37
    
    ; Third choice
    .hex 22 c8 10
    .db "C"-$37
    .hex 24 24
    .db "VOYAGE"-$37
    .hex 24
    .db "BALLON"-$37
    
    ; Fourth choice (ze competition)
    .hex 23 08 0e
    .db "D"-$37
    .hex 24 24
    .db "COMPETITION"-$37
    
    ; Copyright 1984 Nintendo
    .hex 23 49 0e
    .hex f4 01 09 08 04 24 17 12 17 1d 0e 17 0d 18
    
    ; Copyright 2015 retrogamer.ca
    .hex 23 66 13
    .hex f4
    .db "2015"-"0"
    .hex 24
    .db "RETROGAMER"-$37
    .db "."-8
    .db "CA"-$37
    
    ; EOD
    .hex 00

NewTitleScreenCursorOptionY:
    .hex 8c 9c ac bc

NextOptionSelection:
    .hex 01 02 03 00

NewD779:
    .hex 29 2e 33 29