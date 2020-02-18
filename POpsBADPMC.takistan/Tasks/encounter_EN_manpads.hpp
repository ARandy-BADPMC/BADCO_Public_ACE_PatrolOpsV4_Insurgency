class encounter_EN_manpads {
	scope = 1;
	typeID = 1;
	class Conditions {
		areas[] = {"Clearing","Hill"};
		VehicleTypes[] = {"Helicopter"};
		zoneTypes[] = {"hostile"};
		limit = 2;
		timeout = 600;
		sideChat = "Warning Airspace Not Secure";
	};
	class Groups {
		class Squad_AA {
			probability = 1;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"Squad4_AA"};
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