; Original version by Smiley
; Reworked by MassHesteria

InitializeProjectileExpanded:
        JSL.l InitializeProjectile ; What we wrote over
        LDA.w BeamsEquipped : BIT.w #$1000 : BNE .exit
                PHP : PHB
                PHK : PLB
                REP #$30
                ; Lookup the uncharged damage value
                LDA.w ProjectileTypes,X
                AND.w #$000F
                ASL
                TAY
                LDA.w ProjectilePointers,Y
                TAY
                LDA.w $0000,Y
                STA.w ProjectileDamage,X
                PLB : PLP
        .exit
RTL
