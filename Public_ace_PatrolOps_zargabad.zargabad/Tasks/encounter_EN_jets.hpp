class encounter_EN_jets {
	scope = 1;
	typeID = 1;
	class Conditions {
		areas[] = {"Air"};
		VehicleTypes[] = {"Plane_Fighter_01_Base_F","Plane_Fighter_02_Base_F","Plane_Fighter_03_base_F","Plane_Fighter_04_Base_F","Plane_CAS_01_base_F","Plane_CAS_02_base_F"};
		limit = 1;
		timeout = 900;
		sideChat = "AWAC Detecting Unknown Air Contacts Inbound";
	};
	class Groups {
		class AirCombatFighter_1 {
			probability = 1;
			position = "positionOffset";
			angle[] = {0,360};
			faction = "FactionTypeOPF";
			vehicleTypes[] = {"Fighter_Plane"};
			createCrew = 1;
			patrolAirspace = 1;
		};
		class AirCombatFighter_2 {
			probability = 0.5;
			position = positionOffset;
			angle[] = {0,360};
			faction = FactionTypeOPF;
			vehicleTypes[] = {"Fighter_Plane"};
			createCrew = 1;
			patrolAirspace = 1;
		};
	};
	class Objective {
		class Succeeded {
			state = 1;
			condition = "_unitsKilled";
		};
	};
};