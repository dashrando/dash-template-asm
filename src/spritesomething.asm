SpriteSomethingFix:
        CMP.w #$0003 : BEQ .fix
        CMP.w #$0014 : BNE .fix
               JML $91F67F
        .fix:

        ; Quit if the code is unmodified
        LDA.l $91F635
        CMP.w #$0001 : BEQ .quit

        ; Quit if PV is not equipped
        LDA.w DashItemsEquipped
        BIT.w #$0020 : BEQ .quit

        ; Quit if gravity is equipped
        LDA.w VanillaItemsEquipped
        BIT.w #$0020 : BNE .quit

        ; Temporarily mark that we have gravity for the animation
        PHA
        ORA.w #$0020 : STA.w VanillaItemsEquipped
        JSL $9B8000 ; Custom SpriteSomething code is here
        PLA
        STA.w VanillaItemsEquipped

        ; Return back to the calling function
        JML $91F63A
        .quit:
        JML $91F634

pushpc
org $91F62A
JML SpriteSomethingFix
pullpc