!VariaSuit = $0001
!SpringBall = $0002
!MorphingBall = $0004
!ScrewAttack = $0008
!GravitySuit = $0020
!HiJumpBoots = $0100
!SpaceJump = $0200
!Bombs = $1000
!SpeedBooster = $2000
!GrapplingBeam = $4000
!XrayScope = $8000

!WaveBeam = $0001
!IceBeam = $0002
!SpazerBeam = $0004
!PlasmaBeam = $0008
!ChargeBeam = $1000

macro add_items(...)
   !items #= 0
   !i #= 0
   while !i < sizeof(...)
      !items := !items|<!i>
      !i #= !i+1
   endif

   LDA.w VanillaItemsCollected
   ORA.w #!items
   STA.w VanillaItemsCollected

   LDA.w VanillaItemsEquipped
   ORA.w #!items
   STA.w VanillaItemsEquipped
endmacro

macro unequip_items(...)
   !items #= $ffff
   !i #= 0
   while !i < sizeof(...)
      !items := !items&~<!i>
      !i #= !i+1
   endif

   LDA.w VanillaItemsEquipped
   AND.w #!items
   STA.w VanillaItemsEquipped
endmacro

macro add_beams(...)
   !beams #= 0
   !i #= 0
   while !i < sizeof(...)
      !beams := !beams|<!i>
      !i #= !i+1
   endif

   LDA.w BeamsCollected
   ORA.w #!beams
   STA.w BeamsCollected

   LDA.w BeamsEquipped
   ORA.w #!beams
   STA.w BeamsEquipped
endmacro

macro unequip_beams(...)
   !beams #= $ffff
   !i #= 0
   while !i < sizeof(...)
      !beams := !beams&~<!i>
      !i #= !i+1
   endif

   LDA.w BeamsEquipped
   AND.w #!beams
   STA.w BeamsEquipped
endmacro