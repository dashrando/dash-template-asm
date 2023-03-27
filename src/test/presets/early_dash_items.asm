pushpc

incsrc ../buttons.asm
incsrc ../loadout.asm

; Disable creating a save file
org InitGameState_save
NOP #6
JSL InitializeForTesting

org $DFFDB0
InitializeForTesting: {
        %setup_controller()

        ; Place DASH items in early locations
        pushpc
        org pctosnes($7879E) : dw $F088 ; Double Jump at Brinstar Ceiling
        org pctosnes($78798) : dw $EFEC ; Charge Upgrade at Beta Missiles

        org NoFanfare : dw $0001 ; Disable fanfares
        pullpc

        RTL
}

pullpc
