class op_3_secureAirport: TaskDefaults {
	scope = 1;
	typeID = 3;
	positionSearchTypes[] = {"Airport"};
	positionSearchRadius = 1000;
	positionNearLast = 1;
	class TaskDetails {
		title = "%1";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3<br/>AO: %4 %5 near %6</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>%8 have moved agressivly and occupied the civillian town of %6. This is a bold move by %8 and their true motives are unclear at this stage. Extreme caution is advised.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%7 forces will move to the area and liberate %6 from %8 by eliminiating all opposing forces.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>%8 have moved rapidly and the exact force size is unknown. It is likely due to the scale to be a well organised and well equiped force.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Civillian population has not managed to evacuate at the time of report. There is a likelyhood at there are civilians remaining in the AO so caution is advised.</t>"
			,"op_3_secureAirport"
		};
		iconType = "Attack";
		iconPosition = "positionOffset";
		textArguments[] = {"operationName","randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort"};
	};

	// Markers
	class Markers {
		class marker_A {
			position = "positionOffset";
			shape = "RECTANGLE";
			brush = "SolidBorder";
			colour = "ColorOpfor";
			size[] = {0.99,0.99};
			alpha = 0.2;
		};
		class marker_B: marker_A {
			brush = "Border";
			size[] = {1.2,1.2};
			alpha = 1;
		};
		class marker_C: marker_A {
			brush = "Border";
			size[] = {1.0,1.0};
			alpha = 1;
		};
		class marker_D: marker_A {
			brush = "FDiagonal";
			size[] = {1.2,0.1};
			alpha = 0.9;
			direction = 0;
			distance = 1.1;
		};
		class marker_E: marker_D {
			direction = 180;
		};
		class marker_F: marker_D {
			size[] = {1.0,0.1};
			direction = 90;
			angle = 90;
		};
		class marker_G: marker_F {
			direction = 270;
		};
		class marker_target {
			position = "positionOffset";
			shape = "ICON";
			type = "mil_objective";
			colour = "ColorOpfor";
			size[] = {0.8,0.8};
			alpha = 0.6;
			text = "Target";
		};
	};

	// Groups + Targets
	class Groups {
		class EN_squad8_1 {
			probability = 1;
			position = "positionOffset";
			distance[] = {50,100};
			direction[] = {0,360};
			faction = "FactionTypeOPF";
			groupTypes[] = {"Squad8","Squad8_AA","Squad8_AR","Squad8_AT","Squad8_M"};
			isPatrolling = 0.8;
			radius[] = {100,200};
			isDefending = 1;
			occupyBuildings = 1;
		};
		class EN_squad8_2: EN_squad8_1 { probability = 0.7; minPlayers = 4; radius[] = {150,250}; };
		class EN_squad8_3: EN_squad8_1 { probability = 0.5; minPlayers = 8; radius[] = {200,300}; };
		class EN_squad8_4: EN_squad8_1 { probability = 0.3; minPlayers = 12; radius[] = {250,300}; };

		class EN_squad4_1 {
			probability = 1;
			position = "positionOffset";
			distance[] = {50,100};
			direction[] = {0,360};
			faction = "FactionTypeOPF";
			groupTypes[] = {"Squad4","Squad4_AA","Squad4_AR","Squad4_AT","Squad4_M"};
			isPatrolling = 0.8;
			radius[] = {100,250};
			isDefending = 1;
			occupyBuildings = 1;
		};
		class EN_squad4_2: EN_squad4_1 { probability = 0.6; minPlayers = 2; };
		class EN_squad4_3: EN_squad4_1 { probability = 0.7; minPlayers = 6; };
		class EN_squad4_4: EN_squad4_1 { probability = 0.8; minPlayers = 10; };

		class EN_LightVehicle_1 {
			probability = 1;
			position = "positionOffset";
			distance[] = {50,100};
			direction[] = {0,360};
			faction = "FactionTypeOPF";
			vehicleTypes[] = {"CarTurret","Car","Truck"};
			createCrew = 1;
			isPatrolling = 0.6;
			radius[] = {150,250};
		};
		class EN_LightVehicle_2: EN_LightVehicle_1 { probability = 0.7; minPlayers = 8; };
		class EN_LightVehicle_3: EN_LightVehicle_1 { probability = 0.8; minPlayers = 14; };

		class EN_HeavyVehicle_1 {
			minPlayers = 8;
			probability = 1;
			position = "positionOffset";
			distance[] = {50,100};
			direction[] = {0,360};
			faction = "FactionTypeOPF";
			vehicleTypes[] = {"Armour_APC","Armour_MBT"};
			createCrew = 1;
			isPatrolling = 1;
			radius[] = {200,400};
		};
		class EN_HeavyVehicle_2: EN_HeavyVehicle_1 { probability = 0.7; minPlayers = 12; };
		class EN_HeavyVehicle_3: EN_HeavyVehicle_1 { probability = 0.8; minPlayers = 16; };
	};

	// Objective Condition
	class Objective {
		class Succeeded {
			condition = "_unitsKilled";
		};
	};
};

class op_3_secureAirport_INS: TaskDefaults {
	scope = 1;
	typeID = 3;
	positionSearchTypes[] = {"Airport"};
	positionSearchRadius = 1000;
	positionNearLast = 1;
	class TaskDetails {
		title = "%1";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3<br/>AO: %4 %5 near %6</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>Reports are inidicating %8 have occupied a town and are in the process of raiding the surrounding area. This is a bold move and a swift response is required to regain control of the area and disrupt %8 strategies.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%7 forces will move to the area and liberate %6 from %8 by eliminiating all opposing forces.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>%8 have moved rapidly and the exact force size is unknown. Due to the reports of raiding, it is not believed this is an established force but more likely %8 guerilla forces.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Civillian population has not managed to evacuate at the time of report. There is a likelyhood at there are civilians remaining in the AO so caution is advised.</t>"
			,"op_3_secureAirport_INS"
		};
		iconType = "Attack";
		iconPosition = "positionOffset";
		textArguments[] = {"operationName","randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort"};
	};

	// Markers
	class Markers {
		class marker_A {
			position = "positionOffset";
			shape = "RECTANGLE";
			brush = "SolidBorder";
			colour = "ColorOpfor";
			size[] = {0.99,0.99};
			alpha = 0.2;
		};
		class marker_B: marker_A {
			brush = "Border";
			size[] = {1.2,1.2};
			alpha = 1;
		};
		class marker_C: marker_A {
			brush = "Border";
			size[] = {1.0,1.0};
			alpha = 1;
		};
		class marker_D: marker_A {
			brush = "FDiagonal";
			size[] = {1.2,0.1};
			alpha = 0.9;
			direction = 0;
			distance = 1.1;
		};
		class marker_E: marker_D {
			direction = 180;
		};
		class marker_F: marker_D {
			size[] = {1.0,0.1};
			direction = 90;
			angle = 90;
		};
		class marker_G: marker_F {
			direction = 270;
		};
		class marker_target {
			position = "positionOffset";
			shape = "ICON";
			type = "mil_objective";
			colour = "ColorOpfor";
			size[] = {0.8,0.8};
			alpha = 0.6;
			text = "Target";
		};
	};

	// Groups + Targets
	class Groups {
		class EN_Group_1 {
			probability = 1;
			position = "positionOffset";
			distance[] = {50,100};
			direction[] = {0,360};
			faction = "FactionTypeOPF";
			groupTypes[] = {"Squad8_INS","Squad4_INS"};
			isPatrolling = 0.8;
			radius[] = {100,250};
			isDefending = 1;
			occupyBuildings = 1;
		};
		class EN_Group_2: EN_Group_1 { probability = 0.7; minPlayers = 4; radius[] = {150,250}; };
		class EN_Group_3: EN_Group_1 { probability = 0.5; minPlayers = 8; radius[] = {200,300}; };
		class EN_Group_4: EN_Group_1 { probability = 0.3; minPlayers = 12; radius[] = {250,300}; };

		class EN_LightVehicle_1 {
			probability = 1;
			position = "positionOffset";
			distance[] = {50,100};
			direction[] = {0,360};
			faction = "FactionTypeOPF";
			vehicleTypes[] = {"CarTurret_INS","Truck_INS"};
			createCrew = 1;
			isPatrolling = 0.6;
			radius[] = {150,250};
		};
		class EN_LightVehicle_2: EN_LightVehicle_1 { probability = 0.7; minPlayers = 6; vehicleTypes[] = {"CarTurret_INS","Truck_INS","Armour_APC"}; };
		class EN_LightVehicle_3: EN_LightVehicle_1 { probability = 0.8; minPlayers = 10; vehicleTypes[] = {"CarTurret_INS","Truck_INS","Armour_APC"}; };
		class EN_LightVehicle_4: EN_LightVehicle_1 { probability = 0.8; minPlayers = 16; vehicleTypes[] = {"CarTurret_INS","Truck_INS","Armour_APC"}; };
	};

	// Objective Condition
	class Objective {
		class Succeeded {
			condition = "_unitsKilled";
		};
	};
};