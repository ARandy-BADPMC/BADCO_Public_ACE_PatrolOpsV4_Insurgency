class encounter_INS_fuelStop {
	scope = 1;
	typeID = 1;
	class Conditions {
		areas[] = {"Fuel"};
		vehicleTypes[] = {"CaManBase","Car"};
		zoneTypes[] = {"neutral","hostile"};
		limit = 1;
		timeout = 900;
		sideChat = "A chill is in the air";
		//tasks[] = {"op_2_TargetBatteryAA","op_2_TargetDevice"};
	};
	class Groups {
		class Truck_INS {
			probability = 1;
			faction = "FactionTypeOPF";
			position = "positionOffset";
			vehicleTypes[] = {"Truck_INS"};
			createCrew = "TargetHVT_INS";
		};
		class Squad_INS {
			probability = 1;
			faction = "FactionTypeOPF";
			position = "positionOffset";
			groupTypes[] = {"Squad8_INS","Squad4_INS"};
			isDefending = 1;
			radius[] = {70,90};
			dropIntel = 0.8;
		};
	};
	class Objective {
		class Succeeded {
			state = 1;
			condition = "_unitsKilled";
		};
	};
};