incsrc "../introskip_doors/introskip_doors.asm"
incsrc "../include/extra_init.asm"
incsrc "../include/buttons.asm"


macro set_stat(stat, value)
  ldx #<stat>
  lda.w <value>
  jsl $dfd880
endmacro

macro set_all_stats()
  phx
  %set_stat(!DoorTransitions, #555)
  %set_stat(!ChargeShots, #12345)
  %set_stat(!SpecialBeamAttacks, #6789)
  %set_stat(!SuperMissiles, #123)
  %set_stat(!Missiles, #45)
  %set_stat(!PowerBombs, #6)
  plx
endmacro

%begin_extra_init()
{
  ; Set the "time bomb" flag
  lda #$000e         ; Time bomb is considered event 0xE
  jsl $8081fa        ; Call the "Set Event" function

  %add_items(!MorphingBall, \
             !Bombs,        \
             !SpeedBooster, \
             !HiJumpBoots)

  %unequip_items(!SpeedBooster, \
                 !HiJumpBoots)

  %add_beams(!ChargeBeam, \
             !WaveBeam)

  %unequip_beams(!ChargeBeam)

  ; Give 15 of all ammo
  lda.w #15
  sta !Addr_NumMissiles
  sta !Addr_MaxMissiles
  sta !Addr_NumSupers
  sta !Addr_MaxSupers
  sta !Addr_NumPBs
  sta !Addr_MaxPBs

  %set_all_stats()
  %setup_controller()
}
%end_extra_init_no_save()
