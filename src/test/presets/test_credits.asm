pushpc

incsrc ../buttons.asm

!DoorTransitions = $0002
!ChargeShots = $0014
!SpecialBeamAttacks = $0015
!SuperMissiles = $0016
!Missiles = $0017
!PowerBombs = $0018

macro set_stat(stat, value)
        LDX.w #<stat>
        LDA.w <value>
        JSL store_stat
endmacro

; Disable creating a save file
org InitGameState_save
NOP #6
JSL InitializeForTesting

org $DFFDB0
InitializeForTesting: {
        %setup_controller()
        LDA.w #$000E : JSL $8081FA
        PHX
        %set_stat(!DoorTransitions,#555)
        %set_stat(!ChargeShots,#12345)
        %set_stat(!SpecialBeamAttacks,#6789)
        %set_stat(!SuperMissiles,#123)
        %set_stat(!Missiles,#45)
        %set_stat(!PowerBombs,#6)
        PLX
        RTL
}

pullpc