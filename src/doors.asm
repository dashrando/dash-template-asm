;------------------------------------------------------------------------------
; Doors
;------------------------------------------------------------------------------
PreOpenG4:
        LDA.l BossFlagsVanilla+$01 : AND.w #$0101 : CMP.w #$0101 : BNE +
        LDA.l BossFlagsVanilla+$03 : AND.w #$0101 : CMP.w #$0101 : BNE +
        LDA.l EventFlags
        ORA.w #$0400
        STA.l EventFlags
+
RTS

WakeUpZebes: 
    LDA.l ItemBitArray+$02 : BIT.w #$0400 : BEQ .exit ; TODO: Fresh file save marker
    LDA.l EventFlags : ORA.w #$0001 : STA.l EventFlags
.exit
RTS

pushpc
;------------------------------------------------------------------------------
; Door ASM Pointers
;------------------------------------------------------------------------------
org $838EB4 ; Into Construction Zone
dw WakeUpZebes

org $838C5C ; G4 Elevator
dw PreOpenG4

;------------------------------------------------------------------------------
; Door Edits
;------------------------------------------------------------------------------
if !RECALL == 1
    org $8FC571 ; Plasma Spark
    dw NoopPLM : dw $0000, $0000 ; Plasma door blue

    org $8FC773 ; Halfie Shaft
    skip $26 : dw NoopPLM : dw $0000, $0000 ; Plasma door blue

    org $8FC611 ; Back door to Draygon
    dw $0000    ; Make door blue
    
    org $8F823E ; Forgotten Highway before elevator
    dw $0000    ; Make door blue
    
    org $8FCE9C         ; WS Save room header Phantoon alive
    skip $14 : dw $C2C9 ; Turn on save station
    
    org $8FCC39         ; WS E-tank room header Phantoon alive
    skip $14 : dw $C337 ; Show WS E-tank item

    org $8FCBE7         ; WS back room Phantoon alive
    skip $14 : dw $C323 ; Add missile door back
    
    org $8F8B4E         ; Norfair above Croc 8b96
    skip $48 : dw $0000 ; Make upper Croc door blue

    org $8F8B9E ; Croc room
    dw NoopPLM : dw $0000, $0000 ; Make top door blue

endif

if !AREA == 1
    org $8FCE9C         ; WS Save room header Phantoon alive
    skip $14 : dw $C2C9 ; Turn on save station

    org $8FCBE7         ; WS back room Phantoon alive
    skip $14 : dw $C323 ; Add missile door back

    org $83A63C                 ; West Sand Hall left door 
    dw $D6FD                    ; Connect to Below Botwoon Energy Tank
    db $00,$05,$3E,$06,$03,$00
	dw $8000,$0000
endif

org $8F84EC ; Green Brin pre-map
dw $0000    ; Unlock grey door

pullpc

;------------------------------------------------------------------------------
; Lock doors for area
;------------------------------------------------------------------------------

if !AREA == 1
    WestSandHall_GreyDoor_PLM:
    dw $C842,$060E,$1000,$0000

    SandFalls_GreyDoor_PLM:
    dw $C842,$063E,$1000,$0000

    pushpc
    org $8FD273
    dw WestSandHall_GreyDoor_PLM

    org $8FD71E
    dw SandFalls_GreyDoor_PLM
    pullpc


endif

;------------------------------------------------------------------------------
; Flashing doors for area
;------------------------------------------------------------------------------

if !AREA == 1
    pushpc

    ; n00b bridge portal
    org $8F87A6 : dw $C842,$065E,$8C33
    org $A19325 : db $00

    ; Green Hills portal
    org $8F8670 : dw $C842,$061E,$8C30
    org $A19D5B : db $00

    ; Retro PBs portal
    org $8F874B : db $8C
    org $A193A8 : db $00

    pullpc
endif

;------------------------------------------------------------------------------
; Boss Door Transitions
;------------------------------------------------------------------------------
KraidEnterFromLeft:
    LDA.w #$0034 : STA.w SamusXPos
    LDA.w #$0188 : STA.w SamusYPos
rts

PhantoonEnterFromLeft:
    LDA.w #$002E : STA.w SamusXPos
    LDA.w #$00B8 : STA.w SamusYPos
rts

DraygonEnterFromRight:
    LDA.w #$01D0 : STA.w SamusXPos
    LDA.w #$0070 : STA.w SamusYPos
rts

RidleyEnterFromRight:
    LDA.w #$00C4 : STA.w SamusXPos
    LDA.w #$0084 : STA.w SamusYPos
rts

PreKraidEnterFromLeft:
    LDA.w #$01CD : STA.w SamusXPos
    LDA.w #$0188 : STA.w SamusYPos
rts

PrePhantoonEnterFromLeft:
    JSR.w $E1FE  ; Vanilla Door ASM
    LDA.w #$049F : STA.w SamusXPos
    LDA.w #$00B8 : STA.w SamusYPos
rts

PreDraygonEnterFromRight:
    JSR.w $E3D9  ; Vanilla Door ASM
    LDA.w #$0034 : STA.w SamusXPos
    LDA.w #$0288 : STA.w SamusYPos
rts

PreRidleyEnterFromRight:
    LDA.w #$002E : STA.w SamusXPos
    LDA.w #$0098 : STA.w SamusYPos
rts

pushpc

;
org RoomHeaderPreKraid
skip 8 : db $02

org RoomHeaderPrePhantoon
skip 8 : db $02

org RoomHeaderPreDraygon
skip 8 : db $02

org RoomHeaderPreRidley
skip 8 : db $02

;
org $83AD70

print "const BOSSES = {"
%PrintLabelAddress(DoorToKraidBoss)
%PrintLabelAddress(DoorToPhantoonBoss)
%PrintLabelAddress(DoorToDraygonBoss)
%PrintLabelAddress(DoorToRidleyBoss)

print "//"
%PrintLabelAddress(DoorVectorToKraid)
%PrintLabelAddress(DoorVectorToPhantoon)
%PrintLabelAddress(DoorVectorToDraygon)
%PrintLabelAddress(DoorVectorToRidley)
print "//"

;print "DoorVectorToKraidFromLeft"
DoorVectorToKraidFromLeft:
dw $A59F : db $40,$04,$01,$16,$00,$01 : dw $8000,KraidEnterFromLeft
%PrintLabelAddress(DoorVectorToKraidFromLeft)
; vanilla
;dx A59F,00,04,01,16,00,01,8000,0000

DoorVectorToPhantoonFromLeft:
dw $CD13 : db $40,$04,$01,$06,$00,$00 : dw $8000,PhantoonEnterFromLeft
%PrintLabelAddress(DoorVectorToPhantoonFromLeft)
; vanilla
;dx CD13,00,04,01,06,00,00,8000,0000

DoorVectorToDraygonFromRight:
dw $DA60 : db $40,$05,$1E,$06,$01,$00 : dw $8000,DraygonEnterFromRight
%PrintLabelAddress(DoorVectorToDraygonFromRight)
; vanilla
;dx DA60,00,05,1E,06,01,00,8000,0000

DoorVectorToRidleyFromRight:
dw $B32E : db $40,$05,$0E,$06,$00,$00 : dw $8000,RidleyEnterFromRight
%PrintLabelAddress(DoorVectorToRidleyFromRight)
; vanilla
;dx B32E,00,05,0E,06,00,00,8000,0000

print "//"
%PrintLabelAddress(DoorFromKraidRoom)
%PrintLabelAddress(DoorFromPhantoonRoom)
%PrintLabelAddress(DoorFromDraygonRoom)
%PrintLabelAddress(DoorFromRidleyRoom)

print "//"
%PrintLabelAddress(DoorVectorToPreKraid)
%PrintLabelAddress(DoorVectorToPrePhantoon)
%PrintLabelAddress(DoorVectorToPreDraygon)
%PrintLabelAddress(DoorVectorToPreRidley)
print "//"

DoorVectorToPreKraidFromLeft:
dw $A56B : db $40,$05,$1E,$16,$01,$01 : dw $8000,PreKraidEnterFromLeft
%PrintLabelAddress(DoorVectorToPreKraidFromLeft)
; vanilla
;dx A56B,00,05,1E,16,01,01,8000,0000

DoorVectorToPrePhantoonFromLeft:
dw $CC6F : db $40,$05,$4E,$06,$04,$00 : dw $8000,PrePhantoonEnterFromLeft
%PrintLabelAddress(DoorVectorToPrePhantoonFromLeft)
; vanilla
;dx CC6F,00,05,4E,06,04,00,8000,E1FE

DoorVectorToPreDraygonFromRight:
dw $D78F : db $40,$04,$01,$26,$00,$02 : dw $8000,PreDraygonEnterFromRight
%PrintLabelAddress(DoorVectorToPreDraygonFromRight)
; vanilla
;dx D78F,00,04,01,26,00,02,8000,E3D9

DoorVectorToPreRidleyFromRight:
dw $B37A : db $40,$04,$01,$06,$00,$00 : dw $8000,PreRidleyEnterFromRight
%PrintLabelAddress(DoorVectorToPreRidleyFromRight)
; vanilla
;dx B37A,00,04,01,06,00,00,8000,0000
print "}"

pullpc