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
    .hex 0 1 0 0

NewTitlescreenPtr:
    .db <NewTitlescreen
    .db >NewTitlescreen

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