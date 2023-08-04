macro PrintAddress(varName,address)
    print "  <varName>: 0x",hex(snestopc(<address>)),","
endmacro

macro PrintHexByte(varName,varValue)
    print "  <varName>: 0x",hex(<varValue>),","
endmacro

macro PrintLabelAddress(label)
    %PrintAddress(<label>,<label>)
endmacro

print "export const BOSS_DOORS = {"
print "  // Boss Entry Door Pointers"
%PrintLabelAddress(DoorToKraidBoss)
%PrintLabelAddress(DoorToPhantoonBoss)
%PrintLabelAddress(DoorToDraygonBoss)
%PrintLabelAddress(DoorToRidleyBoss)
print "  // Boss Entry Door Vectors"
%PrintLabelAddress(DoorVectorToKraidInBrinstar)
%PrintLabelAddress(DoorVectorToKraidInWreckedShip)
%PrintLabelAddress(DoorVectorToKraidInMaridia)
%PrintLabelAddress(DoorVectorToKraidInNorfair)
%PrintLabelAddress(DoorVectorToPhantoonInBrinstar)
%PrintLabelAddress(DoorVectorToPhantoonInWreckedShip)
%PrintLabelAddress(DoorVectorToPhantoonInMaridia)
%PrintLabelAddress(DoorVectorToPhantoonInNorfair)
%PrintLabelAddress(DoorVectorToDraygonInBrinstar)
%PrintLabelAddress(DoorVectorToDraygonInWreckedShip)
%PrintLabelAddress(DoorVectorToDraygonInMaridia)
%PrintLabelAddress(DoorVectorToDraygonInNorfair)
%PrintLabelAddress(DoorVectorToRidleyInBrinstar)
%PrintLabelAddress(DoorVectorToRidleyInWreckedShip)
%PrintLabelAddress(DoorVectorToRidleyInMaridia)
%PrintLabelAddress(DoorVectorToRidleyInNorfair)
print "  // Boss Exit Door Pointers"
%PrintLabelAddress(DoorFromKraidInBrinstar)
%PrintLabelAddress(DoorFromPhantoonInWreckedShip)
%PrintLabelAddress(DoorFromDraygonInMaridia)
%PrintLabelAddress(DoorFromRidleyInNorfair)
print "  // Boss Exit Door Vectors"
%PrintLabelAddress(DoorVectorToPreKraid)
%PrintLabelAddress(DoorVectorToPrePhantoon)
%PrintLabelAddress(DoorVectorToPreDraygon)
%PrintLabelAddress(DoorVectorToPreRidley)
print "};"
print ""
print "export const AREA_DOORS = {"
print "  // Door Pointers"
%PrintLabelAddress(Door_RetroPBs)
%PrintLabelAddress(Door_GreenHills)
%PrintLabelAddress(Door_Moat)
%PrintLabelAddress(Door_Ocean)
%PrintLabelAddress(Door_G4)
%PrintLabelAddress(Door_Tourian)
%PrintLabelAddress(Door_Kago)
%PrintLabelAddress(Door_GreenElevator)
%PrintLabelAddress(Door_Crabs)
%PrintLabelAddress(Door_RedElevator)
%PrintLabelAddress(Door_HighwayExit)
%PrintLabelAddress(Door_Highway)
%PrintLabelAddress(Door_NoobBridge)
%PrintLabelAddress(Door_RedTower)
%PrintLabelAddress(Door_MaridiaEscape)
%PrintLabelAddress(Door_RedFish)
%PrintLabelAddress(Door_MaridiaTube)
%PrintLabelAddress(Door_MainStreet)
%PrintLabelAddress(Door_KraidEntry)
%PrintLabelAddress(Door_ElevatorEntry)
%PrintLabelAddress(Door_AboveKraid)
%PrintLabelAddress(Door_MaridiaMap)
%PrintLabelAddress(Door_KraidMouth)
%PrintLabelAddress(Door_KraidsLair)
%PrintLabelAddress(Door_CrocEntry)
%PrintLabelAddress(Door_Croc)
%PrintLabelAddress(Door_SingleChamber)
%PrintLabelAddress(Door_Muskateers)
%PrintLabelAddress(Door_LavaDive)
%PrintLabelAddress(Door_RidleyMouth)
%PrintLabelAddress(Door_PreAqueduct)
%PrintLabelAddress(Door_Aqueduct)
print "  // Vanilla Door Vectors"
%PrintLabelAddress(DoorVectorToRetroPBs)
%PrintLabelAddress(DoorVectorToGreenHills)
%PrintLabelAddress(DoorVectorToMoat)
%PrintLabelAddress(DoorVectorToOcean)
%PrintLabelAddress(DoorVectorToG4)
%PrintLabelAddress(DoorVectorToTourian)
%PrintLabelAddress(DoorVectorToKago)
%PrintLabelAddress(DoorVectorToGreenElevator)
%PrintLabelAddress(DoorVectorToCrabs)
%PrintLabelAddress(DoorVectorToRedElevator)
%PrintLabelAddress(DoorVectorToHighwayExit)
%PrintLabelAddress(DoorVectorToHighway)
%PrintLabelAddress(DoorVectorToNoobBridge)
%PrintLabelAddress(DoorVectorToRedTower)
%PrintLabelAddress(DoorVectorToMaridiaEscape)
%PrintLabelAddress(DoorVectorToRedFish)
%PrintLabelAddress(DoorVectorToMaridiaTube)
%PrintLabelAddress(DoorVectorToMainStreet)
%PrintLabelAddress(DoorVectorToKraidEntry)
%PrintLabelAddress(DoorVectorToElevatorEntry)
%PrintLabelAddress(DoorVectorToAboveKraid)
%PrintLabelAddress(DoorVectorToMaridiaMap)
%PrintLabelAddress(DoorVectorToKraidMouth)
%PrintLabelAddress(DoorVectorToKraidsLair)
%PrintLabelAddress(DoorVectorToCrocEntry)
%PrintLabelAddress(DoorVectorToCroc)
%PrintLabelAddress(DoorVectorToSingleChamber)
%PrintLabelAddress(DoorVectorToMuskateers)
%PrintLabelAddress(DoorVectorToLavaDive)
%PrintLabelAddress(DoorVectorToRidleyMouth)
%PrintLabelAddress(DoorVectorToPreAqueduct)
%PrintLabelAddress(DoorVectorToAqueduct)
print "};"
print ""
print "export const BOSS_ITEMS = {"
print "  // Varia Suit Location"
%PrintAddress(VariaSuitInBrinstar,$8F8ACA)
%PrintAddress(VariaSuitInWreckedShip,RoomHeaderVariaSuitInWreckedShip_item_plm)
%PrintAddress(VariaSuitInMaridia,RoomHeaderVariaSuitInMaridia_item_plm)
%PrintAddress(VariaSuitInNorfair,RoomHeaderVariaSuitInNorfair_item_plm)
print "  // Space Jump Location"
%PrintAddress(SpaceJumpInBrinstar,RoomHeaderSpaceJumpInBrinstar_item_plm)
%PrintAddress(SpaceJumpInWreckedShip,RoomHeaderSpaceJumpInWreckedShip_item_plm)
%PrintAddress(SpaceJumpInMaridia,$8FC7A7)
%PrintAddress(SpaceJumpInNorfair,RoomHeaderSpaceJumpInNorfair_item_plm)
print "  // Ridley Tank Location"
%PrintAddress(RidleyTankInBrinstar,RoomHeaderRidleyTankInBrinstar_item_plm)
%PrintAddress(RidleyTankInWreckedShip,RoomHeaderRidleyTankInWreckedShip_item_plm)
%PrintAddress(RidleyTankInMaridia,RoomHeaderRidleyTankInMaridia_item_plm)
%PrintAddress(RidleyTankInNorfair,$8F9108)
print "};"
print ""
print "export const TABLE_FLAGS = {"
print "  // Charge Modes: 0x00 = Vanilla  0x01 = Starter,"
print "  //               0x02 = Recall   0x03 = New"
%PrintLabelAddress(ChargeMode)
print "  // HUD bits: 0x01 = Charge  0x02 = Item Counts,"
print "  //           0x04 = Area    0x08 = Dash Items"
%PrintLabelAddress(HUDBitField)
print "  // Fanfare: 0x0000 = On  0x0001 = Off"
%PrintLabelAddress(NoFanfare)
print "};"