; Balloon Fight (JU) 2-Player Trip Hack with 32k memory by mikaelmoizt 2014 * go bananas!

; iNES identifier - for emulation purposes

byte "NES",$1a            ; basically "NES" plus a terminator
byte $02                  ; 2x16 PRG-ROM block, full NROM 32k
byte $01                  ; 1 CHR-ROM block
byte $00                  ; dontcare
byte $00                  ; dontcare
dsb 8                     ; 8 bytes padding

; declarations

frame EQU $19


; so by adding a iNES header we set the amount of PRG ROM blocks our hack will use
; since the original game is a small one, residing in memory from $c000 to $ffff this header will give us an additional 16 k of free memory
; memory from $8000-$bfff is now completely empty and you can fit another Balloon Fight in this area

org $8000                                               ; origin of added code

start:                                                  ; things we want to do before game starts
     jmp $c000                                          ; jump to game init code

NMI:                                                    ; things we want inside NMI routine. Careful coding here!
 IF 1=0
     lda #$20                                           ; this is just an example of added code - my beloved frame counter
     sta $2006                                          ; (optional)
     lda #$00
     sta $2006

     lda frame
     pha
     lsr
     lsr
     lsr
     lsr

     sta $2007

     pla
     and #$0f
     sta $2007
 ENDIF

     lda $0d
     cmp #$ff
     beq resetscore

     jmp $c08a

resetscore:                                             ; entering 2-player trip mode cause top score to be set to $ff
     lda #$00                                           ; there are more elegant ways to solve this, like temp storage,
     sta $0d                                            ; but this method will suffice
     sta $0e
     sta $0f
     sta $10
     sta $11
     jmp $c08a                                          ; jump to regular NMI routine

draw:
     lda $2002                                          ; poll for a frame..
     bpl draw
     pha                                                ; push everything to stack just in case

     txa
     pha
     tya
     pha

     lda #$23
     sta $2006                                          ; PPUADDR=$23xx

     lda #$08
     sta $2006                                          ; PPUADDR=$2308

     ldx #$00                                           ; prepare for text output

textloop:
     lda text,x                                         ; read from label 'text'
     sta $2007                                          ; output to screen
     inx                                                ; next byte from 'text'
     cmp #$fc                                           ; look for terminator $fc
     bne textloop                                       ; if not found, loop

; this got a bit messy I am afraid.

     lda #$23
     sta $2006                                          ; PPUADDR=$23xx

     lda #$4d
     sta $2006                                          ; PPUADDR=$234d

; for the original (C)1984 NINTENDO text

     pla                                                ; pull back from stack
     tax
     pla
     tay


     pla
     rts                                                ; back to normal NMI routine

text:
     db "d"-"d"+13,$24,$24,$02,$25,"player trip"-"d"+13,$FC

hackfix:                                                ; hijacked subroutine to print out the titlescreen
     pha
     sta $2007
     lda $1f                                            ; load lo byte of 16 bit zp pointer for title screen
     cmp #$ac                                           ; $1f == #$ac?
     beq +
     pla
     rts
+
     lda $20                                            ; load hi byte of 16 bit zp pointer for titlescreen
     cmp #$da                                           ; $20 == #$da?
     beq ++
     pla
     rts
++
     jsr draw                                           ; conditions met, go print our text
     pla
     rts

break:                                                  ; things we want to do on BRK/IRQ
                                                        ; ....
     rti                                                ; return to where BRK occured

; end of vectors declaration.

main:                                                   ; here you can add whatever cool stuff you like to have in the game.
      .db 00

gamemode:
      .db $01,$02,$03,$04,$00                           ; game modes. working back to 0
                                                        ; theoretically allows 256 different game modes
                                                        ; $01 == 1 Player Game
                                                        ; $02 == 2 Player Game
                                                        ; $03 == balloon Trip
                                                        ; $04 == unintended mix between $02 and $03
balloonposition:
      .db $8c,$9c,$ac,$bc,$cc                           ; balloon vertical position. $8C == Option A

pad $c000,$ea                                           ; standard nop padding

; end of section
; now to reinsert the rom file

org $c000

incbin "Balloon Fight (JU).nes",$10,$14c5               ; Balloon Fight (JU) ROM file.. offset $10 (16) bytes for ignoring iNES header
; Now at $d4c5
     jsr hackfix

incbin "Balloon Fight (JU).nes",$14d8,$616              ; copy bytes from $14d8 to $1ade (-> $DADE)

; Now at $dade
     lda gamemode,x                                     ; add extra game modes.

incbin "Balloon Fight (JU).nes",$1af1,$29               ; copy bytes from $1ae1 (+10) down to..

; Now at $db0a
     lda balloonposition,x                              ; fetch sprite vertical position for balloon placement

incbin "Balloon Fight (JU).nes",$1b1d,$24ed             ; copy rest of ROM except the last 6 bytes for adding custom vectors

org $fffa
      dw NMI                                            ; NMI vector.
      dw start                                          ; Reset vector.
      dw break                                          ; Break/irq vector.

; reinstering chr

incbin "Balloon Fight (JU).nes", $4010                  ; read the contents of ROM file and insert from graphics -> EOF.

