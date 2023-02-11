;------------------------------------------------------------------------------
; Tables
;------------------------------------------------------------------------------
; Tables and data that should end up statically mapped for any given build for
; the frontend or any tools. Document the PC address for convenience.
;------------------------------------------------------------------------------

org $DF8000 ; 0x2F8000
FileSelectCode:
db $00, $01, $02, $03

org $DF8004 ; 0x2F8004
ChargeMode:
if !STD == 1
    db $01  ; 0 = vanilla, 1 = starter, 2 = balance
    db $00  ; 0 = no hud, 1 = charge damage on HUD
else
    db $02  ; 0 = vanilla, 1 = starter, 2 = balance
    db $01  ; 0 = no hud, 1 = charge damage on HUD
endif

org $DF8006 ; 0x2F8006
SpaceJumpPhysics:
db $00  ; $00 = Vanilla | $01 = Water with gravity physics everywhere

org $DF8007 ; PC 0x2F8007
CreditsItemLocations:
    %font1("      MAJOR ITEM LOCATIONS      ", "pink") ; 640
    %font1("MORPH BALL                      ", "yellow") ; 641
    %font1("................................", "orange") ; 642 ; 0x2F8087
    %font1("BOMB                            ", "yellow") ; 643
    %font1("................................", "orange") ; 644 ; 0x2F8107
    %font1("ICE BEAM                        ", "yellow") ; 645
    %font1("................................", "orange") ; 646 ; 0x2F8187
    %font1("WAVE BEAM                       ", "yellow") ; 647
    %font1("................................", "orange") ; 648 ; 0x2F8207
    %font1("SPAZER                          ", "yellow") ; 649
    %font1("................................", "orange") ; 650 ; 0x2F8287
    %font1("PLASMA BEAM                     ", "yellow") ; 651
    %font1("................................", "orange") ; 652 ; 0x2F8307
    %font1("VARIA SUIT                      ", "yellow") ; 653
    %font1("................................", "orange") ; 654 ; 0x2F8387
    %font1("GRAVITY SUIT                    ", "yellow") ; 655
    %font1("................................", "orange") ; 656 ; 0x2F8407
    %font1("HIJUMP BOOTS                    ", "yellow") ; 657
    %font1("................................", "orange") ; 658 ; 0x2F8487
    %font1("SPACE JUMP                      ", "yellow") ; 659
    %font1("................................", "orange") ; 660 ; 0x2F8507
    %font1("SPEED BOOSTER                   ", "yellow") ; 661
    %font1("................................", "orange") ; 662 ; 0x2F8587
    %font1("SCREW ATTACK                    ", "yellow") ; 663
    %font1("................................", "orange") ; 664 ; 0x2F8607
    %font1("SPRING BALL                     ", "yellow") ; 665
    %font1("................................", "orange") ; 666 ; 0x2F8687
    %font1("XRAY SCOPE                      ", "yellow") ; 667
    %font1("................................", "orange") ; 668 ; 0x2F8707
    %font1("GRAPPLING BEAM                  ", "yellow") ; 669
    %font1("................................", "orange") ; 670 ; 0x2F8787
    %font1("HEAT SHIELD                     ", "yellow") ; 671
    %font1("................................", "orange") ; 672 ; 0x2F8807
    %font1("PRESSURE VALVE                  ", "yellow") ; 673
    %font1("................................", "orange") ; 674 ; 0x2F8887
    %font1("DOUBLE JUMP                     ", "yellow") ; 675
    %font1("................................", "orange") ; 676 ; 0x2F8907
    if !STD == 0
        %font1("CHARGE UPGRADES                 ", "yellow") ; 677
    else
        %font1("CHARGE BEAM                     ", "yellow") ; 677
    endif
    %font1("................................", "orange") ; 678 ; 0x2F8987
    %font1("                                ", "orange") ; 679 ; 0x2F89C7
    %font1("                                ", "orange") ; 680 ; 0x2F8A07
    %font1("                                ", "orange") ; 681 ; 0x2F8A47
    %font1("                                ", "orange") ; 682 ; 0x2F8A87
    %font1("                                ", "orange") ; 683 ; 0x2F8AC7
    dd 0

org $DF8B0B ; 0x2F8B0B
NoFanfare:  ; $00 = Fanfare | $01 = No fanfare
dw $0000

org $DF8B0D ; 0x2F8B0D
