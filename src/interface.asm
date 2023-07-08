macro PrintLabelAddress(label)
    print "  <label>: 0x",hex(snestopc(<label>)),","
endmacro

print ""
print "const BOSSES = {"
%PrintLabelAddress(DoorToKraidBoss)
%PrintLabelAddress(DoorToPhantoonBoss)
%PrintLabelAddress(DoorToDraygonBoss)
%PrintLabelAddress(DoorToRidleyBoss)
print "  //"
%PrintLabelAddress(DoorVectorToKraid)
%PrintLabelAddress(DoorVectorToPhantoon)
%PrintLabelAddress(DoorVectorToDraygon)
%PrintLabelAddress(DoorVectorToRidley)
print "  //"
%PrintLabelAddress(DoorVectorTeleportToKraid)
%PrintLabelAddress(DoorVectorTeleportToPhantoon)
%PrintLabelAddress(DoorVectorTeleportToDraygon)
%PrintLabelAddress(DoorVectorTeleportToRidley)
print "  //"
%PrintLabelAddress(DoorFromKraidRoom)
%PrintLabelAddress(DoorFromPhantoonRoom)
%PrintLabelAddress(DoorFromDraygonRoom)
%PrintLabelAddress(DoorFromRidleyRoom)
print "  //"
%PrintLabelAddress(DoorVectorToPreKraid)
%PrintLabelAddress(DoorVectorToPrePhantoon)
%PrintLabelAddress(DoorVectorToPreDraygon)
%PrintLabelAddress(DoorVectorToPreRidley)
print "  //"
%PrintLabelAddress(DoorVectorTeleportToPreKraid)
%PrintLabelAddress(DoorVectorTeleportToPrePhantoon)
%PrintLabelAddress(DoorVectorTeleportToPreDraygon)
%PrintLabelAddress(DoorVectorTeleportToPreRidley)
print "};"
print ""