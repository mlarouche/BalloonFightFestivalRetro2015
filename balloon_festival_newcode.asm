; ========
; = Code =
; ========

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
    cmp #GameMode_Competition
    bne +

    jsr CompetitionPresentationEnter
+
    rts

CompetitionPresentationEnter:
    jsr EnableNMI
    jsr LoadCompetitionPresentationScreen

    lda #$0F
    sta $4015
    lda #$20
    sta CurrentMusic

    lda #$00
    sta Player1State
    sta Player2State

competitionPresentationUpdateLoop:
    jsr WaitForNMI
    jsr ReadInputP1
    tax
    and #Button_Start
    beq +
    lda Player1State
    beq +
    lda Player2State
    jmp competitionPresentationExit
+
    txa
    and #Button_A
    beq +
    lda Player1State
    bne +

    lda #$01
    sta Player1State

    lda #<Player1JoinedNametableUpdate
    sta AddToGfxPointerLow
    ldy #>Player1JoinedNametableUpdate
    sty AddToGfxPointerHigh
    jsr AddToGfxBuffer

    lda Player2State
    beq noPlayer2Confirm
    lda #<PressStartNametableUpdate
    sta AddToGfxPointerLow
    ldy #>PressStartNametableUpdate
    sty AddToGfxPointerHigh
    jsr AddToGfxBuffer
noPlayer2Confirm:
    jmp competitionPresentationUpdateLoop
+
    ldx #$01
    jsr ReadInputP2
    tax
    and #Button_Start
    beq +
    lda Player1State
    beq +
    lda Player2State
    bne competitionPresentationExit
+
    txa
    and #Button_A
    beq +
    lda Player2State
    bne +

    lda #$01
    sta Player2State

    lda #<Player2JoinedNametableUpdate
    sta AddToGfxPointerLow
    ldy #>Player2JoinedNametableUpdate
    sty AddToGfxPointerHigh
    jsr AddToGfxBuffer

    lda Player1State
    beq noPlayer1Confirm
    lda #<PressStartNametableUpdate
    sta AddToGfxBuffer
    ldy #>PressStartNametableUpdate
    sty AddToGfxBuffer
    jsr AddToGfxBuffer
noPlayer1Confirm:
+
    jmp competitionPresentationUpdateLoop

competitionPresentationExit:
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
    ; Mute song
    lda #$00
    sta $4015

    ; Load nametable
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

    ; Wait 2.5 seconds before starting the game
    lda #$00
    sta GameTimer
-
    lda GameTimer
    cmp #150 ; 2.5 seconds in frame count
    bne -
    
    ; Setup competition timer
    lda #Competition_Time
    sta Competition_Seconds
    lda #$00
    sta Competition_FrameCount
    rts

NoDecreaseLivesInCompetition:
    ldy #$02
    lda GameMode
    cmp #GameMode_Competition
    beq +
    dec Player1Lives,x
+
    sty $46

    rts

NewDisplayLives:
    dec $46
    lda #$20
    sta $2006
    lda #$62
    sta $2006
    lda Player1Lives
    jsr DrawLives
    lda NumberOfPlayers
    beq NewDisplayLivesExit
    lda #$20
    sta $2006
    lda #$75
    sta $2006
    lda Player2Lives
DrawLives:
    bmi DisplayGameOverInHUD
DoDrawLives:
    sta $50
    ldx #$06
-
    lda #$24
    cpx $50
    bcs NewDisplayLivesWritePPU
    lda GameMode
    cmp #GameMode_Competition
    bne +
    lda #$24
    bne NewDisplayLivesWritePPU
+
    lda #$2a
NewDisplayLivesWritePPU:
    sta $2007
    dex
    bpl -
NewDisplayLivesExit:
    rts

DisplayGameOverInHUD:
    lda NumberOfPlayers
    beq DoDrawLives
    ldx #$08
-
    lda GameOverHUDText,x
    sta $2007
    dex
    bpl -
    rts

GameOverHUDText:
    .hex 1b 0e 1f 18
    .hex 24 0e 16 0a
    .hex 10

NewLevelIncrement:
    ldx CurrentLevelHeaderPtr
    inx

    lda GameMode
    cmp #GameMode_Competition
    bne NewLevelIncrementOC
    txa
    and #3
    cmp #3
    bne NewLevelIncrementOC
    inx

NewLevelIncrementOC:
    cpx #$10
    bne +
    ldx #$04
+
    stx CurrentLevelHeaderPtr
    jmp InitGameRound

NewInitPhaseDisplay:
    lda GameMode
    cmp #GameMode_Competition
    bne NewInitPhaseDisplayOC
    
    ldx #$08
-
    lda InitialTimerData,x
    sta $57,x
    dex
    bpl -
    jmp NewInitPhaseDisplayExit

NewInitPhaseDisplayOC:
    lda $3d
    and #$20
    beq ++

    ldx #$0a
-
    lda __f3f5,x
    sta $57,x
    dex
    bpl -
    ldy #$0a
    lda CurrentPhaseCount
    sta $43
    jsr __d77c
    sta $60
    lda $43
    sta $61
NewInitPhaseDisplayExit:
    jmp AddToGfxBuffer_Default

++
    lda #$00
    ldy #$f4
    jmp AddToGfxBuffer

InitialTimerData:
    .hex 20 6e 05
    .hex 00 02 C0 05 09

CompetitionUpdate:
    ; Hijacked
    jsr __f470

    lda GameMode
    cmp #GameMode_Competition
    bne CompetitionUpdateOC
    
    ldx Competition_FrameCount
    inx
    cpx #60
    bmi +

    ldx #$00
    dec Competition_Seconds
    bne +
    
    lda #$00
    sta GameMode
    jmp Competition_TimeUp
+
    stx Competition_FrameCount
    jmp CompetitionUpdateExit
    
CompetitionUpdateOC:
    lda PhaseFlashTimer
    beq CompetitionUpdateExit
    dec PhaseFlashTimer
    jsr NewInitPhaseDisplay

CompetitionUpdateExit:
    rts

Competition_TimeUp:
    ; Mute Sound
    lda #$00
    sta $4015

    ; Load nametable
    jsr ClearScreenAndSprites
    jsr HideEverything
    jsr WaitForNMI
    jsr DisableNMI

    lda #<TimeUpNametablePtr
    sta LoadPointerLow
    lda #>TimeUpNametablePtr
    sta LoadPointerHigh
    jsr LoadNametable
    jsr EnableNMI
    jsr ShowScreen

    ; Wait 2 seconds
    lda #$00
    sta GameTimer
-
    lda GameTimer
    cmp #120 ; 2 seconds in frame count
    bne -

    jmp Competition_FinalScoreEnter

FinalState_Wait1 = $00
FinalState_ShowPlayer1 = $01
FinalState_Wait2 = $02
FinalState_ShowPlayer2 = $03
FinalState_Wait3 = $04
FinalState_ShowWinner = $05
FinalState_ReadInput = $06

Competition_FinalScoreEnter:
    ; Load nametable
    jsr ClearScreenAndSprites
    jsr HideEverything
    jsr WaitForNMI
    jsr DisableNMI

    ldx #48
    ldy #0
-
    lda FinalScoreOAMTable,y
    sta $0200,y
    iny
    dex
    bne -

    lda #<FinalScoreNametablePtr
    sta LoadPointerLow
    lda #>FinalScoreNametablePtr
    sta LoadPointerHigh
    jsr LoadNametable
    jsr EnableNMI
    jsr ShowScreen

    lda #$00
    sta Competition_FinalState
    sta GameTimer

    ; Unmute and play game over jingle
    lda #$0F
    sta $4015
    lda #$01
    sta CurrentMusic
    
Competition_FinalScoreUpdate:
    jsr WaitForNMI

    lda Competition_FinalState
    cmp #FinalState_Wait1
    bne +

    lda GameTimer
    cmp #120
    bne Competition_FinalScoreUpdateEnd
    lda #FinalState_ShowPlayer1
    sta Competition_FinalState

+   cmp #FinalState_ShowPlayer1
    bne +

    jsr CompetitionFinalScore_ShowPlayer1

+   cmp #FinalState_Wait2
    bne +

    lda GameTimer
    cmp #120
    bne Competition_FinalScoreUpdateEnd
    lda #FinalState_ShowPlayer2
    sta Competition_FinalState

+   cmp #FinalState_ShowPlayer2
    bne +

    jsr CompetitionFinalScore_ShowPlayer2

+   cmp #FinalState_Wait3
    bne +

    lda GameTimer
    cmp #190
    bne Competition_FinalScoreUpdateEnd
    lda #FinalState_ShowWinner
    sta Competition_FinalState

+   cmp #FinalState_ShowWinner
    bne +

    jsr CompetitionFinalScore_ShowWinner

+   cmp #FinalState_ReadInput
    bne Competition_FinalScoreUpdateEnd

    jsr ReadInputP1
    and #(Button_Start|Button_Select)
    cmp #(Button_Start|Button_Select)
    beq Competition_FinalScoreExit

Competition_FinalScoreUpdateEnd:
    jmp Competition_FinalScoreUpdate

Competition_FinalScoreExit:
    ldx #$FF
    txs
    jmp GameInit

CompetitionFinalScore_Wait1:
    rts

CompetitionFinalScore_ShowPlayer1:
    ldx #$08
-
    lda FinalScore_Player1, x
    sta $57,x
    dex
    bpl -
    
    ldx #$04
    ldy #$00
-
    lda $03,x
    sta $5A,y
    iny
    dex
    bpl -
    
    jsr AddToGfxBuffer_Default

    lda #$00
    sta GameTimer
    lda #FinalState_Wait2
    sta Competition_FinalState
    rts

CompetitionFinalScore_ShowPlayer2:
    ldx #$08
-
    lda FinalScore_Player2, x
    sta $57,x
    dex
    bpl -
    
    ldx #$04
    ldy #$00
-
    lda $08,x
    sta $5A,y
    iny
    dex
    bpl -
    
    jsr AddToGfxBuffer_Default

    lda #$00
    sta GameTimer
    lda #FinalState_Wait3
    sta Competition_FinalState
    rts

FinalScore_Player1:
    .hex 21 8C 06
    .hex 0 0 0 0 0 0

FinalScore_Player2:
    .hex 22 AC 06
    .hex 0 0 0 0 0 0

CompetitionFinalScore_ShowWinner:
    lda #<FinalScore_ShowWinnerUpdate
    sta AddToGfxPointerLow
    ldy #>FinalScore_ShowWinnerUpdate
    sty AddToGfxPointerHigh
    jsr AddToGfxBuffer

    ldx #$04
-
    lda $03,x
    cmp $08,x
    beq +
    bcc IsPlayer2Winner
    bcs IsPlayer1Winner
+
    dex
    bpl -
    
    ldx GfxBufferIndex
    ldy #9
-
    lda FinalScore_Tie,y
    sta $0300,x
    
    dex
    dey
    bpl -

    bmi +
    
IsPlayer1Winner:
    ldx GfxBufferIndex
    dex
    dex
    lda #$01
    sta $0300,x
    bne +

IsPlayer2Winner:
    ldx GfxBufferIndex
    dex
    dex
    lda #$02
    sta $0300,x

+
    lda #<FinalScore_ShowPressUpdate1
    sta AddToGfxPointerLow
    ldy #>FinalScore_ShowPressUpdate1
    sty AddToGfxPointerHigh
    jsr AddToGfxBuffer

    lda #<FinalScore_ShowPressUpdate2
    sta AddToGfxPointerLow
    ldy #>FinalScore_ShowPressUpdate2
    sty AddToGfxPointerHigh
    jsr AddToGfxBuffer

    lda #FinalState_ReadInput
    sta Competition_FinalState
    rts

; ========
; = Data =
; ========
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

Player1JoinedNametableUpdate:
    .hex 22 F0 0A
    .db "PRET"-$37
    .hex 2C ; !
    .dsb 5,$24

Player2JoinedNametableUpdate:
    .hex 23 30 0A
    .db "PRET"-$37
    .hex 2C ; !
    .dsb 5,$24

PressStartNametableUpdate:
    .hex 23 68 11
    .db "APPUYEZ"-$37
    .hex 24
    .db "SUR"-$37
    .hex 24
    .db "START"-$37

StartCompetitionNametablePtr:
    .db <StartCompetitionNametable
    .db >StartCompetitionNametable
    .hex 0 0

StartCompetitionNametable:
    ; background palette 0
    .hex 3f 00 04 0f 30 27 2a

    .hex 21 AC 07
    .db "HAJIME"-$37
    .hex 2C ; !
    .hex 0

TimeUpNametablePtr:
    .db <TimeUpNametable
    .db >TimeUpNametable
    .hex 0 0
    
TimeUpNametable:
     ; background palette 0
    .hex 3f 00 04 0f 30 27 2a

    .hex 21 AA 0D
    .db "TEMPS"-$37
    .hex 24
    .db "ECOULE"-$37
    .hex 2C ; !

    ; EOD
    .hex 0

FinalScoreNametablePtr:
    .db <FinalScoreNametable
    .db >FinalScoreNametable
    .hex 0 0

FinalScoreNametable:
    ; background palette 0
    .hex 3f 00 04 0f 30 27 2a
    ; sprite palettes
    .hex 3f 10 08
    .hex 0f 0C 1D 37
    .hex 0f 13 1D 37

    .hex 20 67 11
    .db "LES"-$37
    .hex 24
    .db "SCORES"-$37
    .hex 24
    .db "FINAUX"-$37
    
    .hex 20 CB 08
    .db "JOUEUR"-$37
    .hex 24
    .db "1"-"0"
    
    .hex 21 EB 08
    .db "JOUEUR"-$37
    .hex 24
    .db "2"-"0"

    ; EOD
    .hex 0

Joueur1SpriteX1 = 112
Joueur1SpriteX2 = 120
Joueur1SpriteY1 = 64
Joueur1SpriteY2 = 72
Joueur1SpriteY3 = 80

Joueur2SpriteX1 = 112
Joueur2SpriteX2 = 120
Joueur2SpriteY1 = 136
Joueur2SpriteY2 = 144
Joueur2SpriteY3 = 152

FinalScoreOAMTable:
    .db Joueur1SpriteY1
    .hex 0
    .hex 0
    .db Joueur1SpriteX1

    .db Joueur1SpriteY1
    .hex 0B
    .hex 0
    .db Joueur1SpriteX2

    .db Joueur1SpriteY2
    .hex 38
    .hex 0
    .db Joueur1SpriteX1

    .db Joueur1SpriteY2
    .hex 39
    .hex 0
    .db Joueur1SpriteX2

    .db Joueur1SpriteY3
    .hex 27
    .hex 0
    .db Joueur1SpriteX1

    .db Joueur1SpriteY3
    .hex 05
    .hex 0
    .db Joueur1SpriteX2

    ; -----------------
    .db Joueur2SpriteY1
    .hex 0
    .hex 1
    .db Joueur2SpriteX1

    .db Joueur2SpriteY1
    .hex 0B
    .hex 1
    .db Joueur2SpriteX2

    .db Joueur2SpriteY2
    .hex 38
    .hex 1
    .db Joueur2SpriteX1

    .db Joueur2SpriteY2
    .hex 39
    .hex 1
    .db Joueur2SpriteX2

    .db Joueur2SpriteY3
    .hex 27
    .hex 1
    .db Joueur2SpriteX1

    .db Joueur2SpriteY3
    .hex 05
    .hex 1
    .db Joueur2SpriteX2

FinalScore_ShowWinnerUpdate:
    .hex 23 04 19
    .db "LE"-$37
    .hex 24
    .db "GAGNANT"-$37
    .hex 24
    .db "EST"-$37
    .hex C0 ; :
    .hex 24
    .db "JOUEUR"-$37
    .hex 24
    .db "0"-"0"
    .hex 2c ; !

FinalScore_Tie:
    .db "MATCH"-$37
    .hex 24
    .db "NUL"-$37

FinalScore_ShowPressUpdate1:
    .hex 23 44 18
    .db "APPUYEZ"-$37
    .hex 24
    .db "SUR"-$37
    .hex 24
    .db "START"-$37
    .hex c2 ; +
    .db "SELECT"-$37
    
FinalScore_ShowPressUpdate2:
    .hex 23 65 17
    .db "POUR"-$37
    .hex 24
    .db "RETOURNER"-$37
    .hex 24
    .db "AU"-$37
    .hex 24
    .db "DEBUT"-$37

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

; This select which top score to load
NewD779:
    .hex 29 2e 33 2e