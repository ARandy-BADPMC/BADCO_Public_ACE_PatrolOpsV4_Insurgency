class encounter_EN_manpats {
	scope = 1;
	typeID = 1;
	positionNearRoad = 1;
	class Conditions {
		areas[] = {"Clearing"};
		VehicleTypes[] = {"Tank","Car"};
		zoneTypes[] = {"hostile"};
		limit = 2;
		timeout = 600;
		sideChat = "Warning MANPATS In Area";
	};
	class Groups {
		class Squad_AT {
			probability = 1;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"Squad4_AT"};
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