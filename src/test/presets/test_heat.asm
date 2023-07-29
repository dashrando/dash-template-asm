pushpc

incsrc ../buttons.asm
incsrc ../quickmet.asm
incsrc ../loadout.asm

; Start in Speed Booster room
%quickmet(!speed_room)

; Disable creating a save file
org InitGameState_save
NOP #3
JSL InitializeForTesting

org $DFFDB0
InitializeForTesting: {
        %setup_controller()

        ; Add equipment and beams
        %add_items(!MorphingBall,!Bombs)
        %add_beams(!ChargeBeam,!PlasmaBeam,!WaveBeam,!IceBeam,!SpazerBeam)
        %unequip_beams(!SpazerBeam)

        ; Add some ammo
        LDA.w #5
        STA.w CurrentPBs : STA.w MaxPBs
        STA.w CurrentSupers : STA.w MaxSupers
        LDA.w #10
        STA.w CurrentMissiles : STA.w MaxMissiles

        ; Make sure Zebes is awake
        LDA.l EventFlags : ORA.w #$0001 : STA.l EventFlags

        ; Equip all DASH items
        LDA.w DashItemsCollected : ORA #$0221 : STA.w DashItemsCollected
        LDA.w DashItemsEquipped : ORA #$0221 : STA.w DashItemsEquipped

        ; Fix the music
        pushpc
        org $8FAD2C
        dw $0515
        pullpc

        ; Place items
        pushpc
        org $8F8C82 : dw $EF07  ; Varia Suit at Speed Booster
        pullpc

        RTL
}

pullpc

