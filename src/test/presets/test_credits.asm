pushpc

incsrc ../buttons.asm

; Disable creating a save file
org InitGameState_save
NOP #6
JSL InitializeForTesting

org $DFFDB0
InitializeForTesting: {
        %setup_controller()
        LDA.w #$000E : JSL $8081FA
        PHX
        LDA.w #555   : STA.l DoorTransitions
        LDA.w #12345 : STA.l ChargedShots
        LDA.w #6789  : STA.l SpecialBeamsFired
        LDA.w #123   : STA.l SupersFired
        LDA.w #45    : STA.l MissilesFired
        LDA.w #6     : STA.l PowerBombsLaid
        PLX

        ; Add some ammo
        LDA.w #5
        STA.w CurrentPBs : STA.w MaxPBs
        STA.w CurrentSupers : STA.w MaxSupers
        LDA.w #10
        STA.w CurrentMissiles : STA.w MaxMissiles

        ; Equip DASH items
        LDA.w #$0221
        STA.w DashItemsEquipped : STA.w DashItemsCollected

        ; Equip charge beam and an upgrade
        LDA.w #$1100
        STA.w BeamsEquipped : STA.w BeamsCollected

        RTL
}

pullpc