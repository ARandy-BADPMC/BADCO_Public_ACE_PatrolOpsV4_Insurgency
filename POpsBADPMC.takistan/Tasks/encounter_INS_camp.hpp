class encounter_INS_camp {
	scope = 1;
	typeID = 1;
	class Conditions {
		areas[] = {"Clearing","Forest"};
		vehicleTypes[] = {"CaManBase","LandVehicle"};
		zoneTypes[] = {"neutral"};
		limit = 1;
		timeout = 300;
		sideChat = "A chill is in the air";
		//tasks[] = {"op_2_TargetBatteryAA","op_2_TargetDevice"};
	};
	class Compositions {
		class Camp {
			position = positionOffset;
			typeIDs[] = {"en_camp_1","en_camp_2","en_camp_3_intel","en_camp_4_intel"};
		};
	};
	class Groups {
		class Squad_INS {
			probability = 1;
			faction = "FactionTypeOPF";
			groupTypes[] = {"Squad8_INS","Squad4_INS"};
			isPatrolling = 0.6;
			isDefending = 0.6;
			isCrowd = 1;
			radius[] = {150,250};
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