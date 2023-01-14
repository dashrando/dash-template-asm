; Macro that can be called to setup the button bindings for the controller

!button_B = #$8000
!button_Y = #$4000
!button_Select = #$2000
!button_Start = #$1000
!button_A = #$0080
!button_X = #$0040
!button_L = #$0020
!button_R = #$0010

!Shoot = $7e09b2
!Jump = $7e09b4
!Dash = $7e09b6
!ItemCancel = $7e09b8
!ItemSelect = $7e09ba
!AimDown = $7e09bc
!AimUp = $7e09be

macro bind(action,button)
   lda.w <button>
   sta <action>
endmacro

macro setup_controller()
  ; Save the status register state
  php

  ; Enable 16-bit mode
  rep #$20

  ; Setup the controller scheme
  %bind(!Shoot,!button_X)
  %bind(!AimUp,!button_R)
  %bind(!AimDown,!button_L)
  %bind(!ItemSelect,!button_A)
  %bind(!Jump,!button_B)
  %bind(!Dash,!button_Y)
  %bind(!ItemCancel,!button_Select)

  ; Restore the status register state
  plp
endmacro