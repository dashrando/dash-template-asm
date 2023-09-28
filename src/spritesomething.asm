SpriteSomethingFix:
        CMP.w #$0003 : BEQ .fix
        CMP.w #$0014 : BNE .fix
               JML $91F67F
        .fix:

        ; Quit if the code is unmodified
        LDA.w $F635
        CMP.w #$0001 : BEQ .quit

        ; Setup the mask for gravity/PV
        LDA.w #$0020

        ; Quit if gravity has been collected
        BIT.w VanillaItemsCollected : BNE .quit

        ; Quit if PV is not equipped
        BIT.w DashItemsEquipped : BEQ .quit

        ; Temporarily mark that we have gravity for the animation
        TSB.w VanillaItemsEquipped
        JSL $9B8000 ; Custom SpriteSomething code is here
        LDA.w #$0020 : TRB.w VanillaItemsEquipped

        ; Return back to the calling function
        JML $91F63A
        .quit:
        JML $91F634

pushpc
org $91F62A
JML SpriteSomethingFix
pullpc