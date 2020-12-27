// Add Action
["MPSF_Interaction_addVehicleDoorActions_onGetIn_EH","onGetIn",{
	if ({vehicle player isKindOf _x} count ["Heli_Transport_01_base_F","Heli_Transport_04_base_F","Heli_Attack_02_base_F","Heli_Transport_02_base_F"] == 0) exitWith {};
	["MPSF_VehicleDoor_Action",player,"Toggle Cargo Doors",{
		switch (true) do {
			case (vehicle player isKindOf "Heli_Transport_01_base_F") : {
				vehicle player animateDoor ['door_R',1 - (vehicle player doorPhase "door_R")];
				vehicle player animateDoor ['door_L',1 - (vehicle player doorPhase "door_L")];
			};
			case (vehicle player isKindOf "Heli_Transport_04_base_F") : {
				vehicle player animateDoor ["Door_4_source",1 - (vehicle player doorPhase "Door_4_source")];
				vehicle player animateDoor ["Door_5_source",1 - (vehicle player doorPhase "Door_5_source")];
			};
			case (vehicle player isKindOf "Heli_Attack_02_base_F") : {
				vehicle player animateDoor ["door_L",1 - (vehicle player doorPhase "door_L")];
				vehicle player animateDoor ["door_L_pop",1 - (vehicle player doorPhase "door_L_pop")];
				vehicle player animateDoor ["door_R",1 - (vehicle player doorPhase "door_R")];
				vehicle player animateDoor ["door_R_pop",1 - (vehicle player doorPhase "door_R_pop")];
			};
			case (vehicle player isKindOf "Heli_Transport_02_base_F") : {
				vehicle player animateDoor ["Door_Back_L",1 - (vehicle player doorPhase "Door_Back_L")];
				vehicle player animateDoor ["Door_Back_R",1 - (vehicle player doorPhase "Door_Back_R")];
			};
		};
	},[],"driver vehicle player isEqualTo player"] call MPSF_fnc_addAction;
}] call MPSF_fnc_addEventHandler;

// Remove Action
["MPSF_Interaction_addVehicleDoorActions_onGetOut_EH","onGetOut",{
	["MPSF_VehicleDoor_Action",player] call MPSF_fnc_removeAction;
}] call MPSF_fnc_addEventHandler;