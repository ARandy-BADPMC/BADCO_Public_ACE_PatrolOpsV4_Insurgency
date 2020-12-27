class encounter_INS_patrolTechnical {
	scope = 1;
	typeID = 1;
	positionNearRoad = 1;
	class Conditions {
		areas[] = {"Clearing","Village","House","Farm"};
		vehicleTypes[] = {"CaManBase","Car"};
		zoneTypes[] = {"neutral","hostile"};
		limit = 2;
		timeout = 300;
		sideChat = "A chill is in the air";
		//tasks[] = {"op_2_TargetBatteryAA","op_2_TargetDevice"};
	};
	class Groups {
		class CarTurret_INS {
			probability = 1;
			faction = "FactionTypeOPF";
			position = "positionOffset";
			vehicleTypes[] = {"CarTurret_INS"};
			createCrew = 1;
			isPatrolling = 1;
			radius[] = {350,500};
		};
	};
	class Objective {
		class Succeeded {
			state = 1;
			condition = "_unitsKilled";
		};
	};
};