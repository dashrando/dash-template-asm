!pos ?= -1

if !pos < 0
   print "ERROR: Specify 'pos' as preprocessor flag"
else

!pos #= !pos*256

org $008000
!i = 0
while !i < 64
   !result = readfile4("build/SuperMetroid.sfc",!pos+(4*!i))
   dd !result
   !i #= !i+1
endif

endif
