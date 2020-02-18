class encounter_INS_guard {
	scope = 1;
	typeID = 1;
	class Conditions {
		areas[] = {"Village","House","Farm","Religious"};
		vehicleTypes[] = {"CaManBase","Car"};
		zoneTypes[] = {"neutral","hostile"};
		limit = 2;
		timeout = 300;
		sideChat = "A chill is in the air";
		//tasks[] = {"op_2_TargetBatteryAA","op_2_TargetDevice"};
	};
	class Groups {
		class Squad_INS {
			probability = 1;
			faction = "FactionTypeOPF";
			position = "positionOffset";
			groupTypes[] = {"Squad8_INS","Squad4_INS"};
			isPatrolling = 0.6;
			isDefending = 0.6;
			isCrowd = 1;
			radius[] = {50,75};
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