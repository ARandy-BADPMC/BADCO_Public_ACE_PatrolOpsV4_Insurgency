class op_2_TargetBatteryAA: TaskDefaults {
	scope = 1;
	typeID = 2;
	positionSearchTypes[] = {"Town","Village"};
	positionSearchRadius = 1000;
	positionNearLast = 1;
	class TaskDetails {
		title = "%1";
		brief = "Unknown Brief at this time";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3<br/>AO: %4 %5 near %6</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>A UAV conducting a surveillance flight over %6 has come under fire from Anti Air weapons. Satellite recon shows %8 forces have deployed an Anti-Air battery in the vacinity of %8. The UAV was not harmed and successfully returned to base.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%7 forces will move to %6 and conduct a sweep to eliminiate any Anti-Air platforms and any hostile forces.</t>"
			,"<t size='1.1' color='#FFC600'>Intel:</t> <t>%8 have deployed at least one Anti-Air platform but there could be as many as three operating in the area with a support crew as well as a likelyhood of additional ground forces.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>It is likely that the local civilian population has not had time to evacuate due to the rapid deployment of %8 so extreme caution is recommended to minimise civilian casualty..</t>"
			,"op_2_TargetBatteryAA"
		};
		iconType = "Destroy";
		iconPosition = "position";
		textArguments[] = {"operationName","randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort"};
	};
	class Markers {
		class marker_A {
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
	class Groups {
		class AA_Target_1 {
			isTarget = 1;
			probability = 1;
			position = "positionOffset";
			distance[] = {50,100};
			direction[] = {0,120};
			faction = "FactionTypeOPF";
			vehicleTypes[] = {"Armour_AA"};
			createCrew = 1;
		};
		class AA_Target_2: AA_Target_1 {
			probability = 0.8;
			minPlayers = 5;
			direction[] = {121,240};
		};
		class AA_Target_3: AA_Target_1 {
			probability = 0.8;
			minPlayers = 10;
			direction[] = {241,360};
		};
		class HVT_Guard_Group {
			probability = 0.2;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"SpecOps_Elite"};
			isPatrolling = 0.4;
			radius[] = {60,100};
			isDefending = 1;
			occupyBuildings = 1;
		};
		class EN_Group_1 {
			probability = 0.9;
			position = "positionOffset";
			distance[] = {20,50};
			direction[] = {0,360};
			faction = "FactionTypeOPF";
			groupTypes[] = {"Squad8","Squad8_AA","Squad8_AR","Squad8_AT","Squad8_M","Squad4","Squad4_AA","Squad4_AR","Squad4_AT","Squad4_M","Squad8_INS","Squad4_INS"};
			isPatrolling = 0.9;
			radius[] = {50,150};
			isDefending = 1;
			occupyBuildings = 1;
		};
		class EN_Group_2: EN_Group_1 {
			minPlayers = 2;
			distance[] = {100,150};
			radius[] = {150,200};
		};
		class EN_Group_3: EN_Group_1 {
			minPlayers = 6;
			distance[] = {150,200};
			radius[] = {200,250};
		};
		class EN_Vehicle_Group_1 {
			probability = 0.85;
			position = "positionOffset";
			distance[] = {50,100};
			direction[] = {0,360};
			faction = "FactionTypeOPF";
			vehicleTypes[] = {"CarTurret","Car","Truck_Support"};
			createCrew = 1;
			isPatrolling = 0.6;
			radius[] = {150,250};
		};
		class EN_Vehicle_Group_2: EN_Vehicle_Group_1 {
			probability = 0.7;
			minPlayers = 8;
			vehicleTypes[] = {"CarTurret","Armour_AA","Armour_APC","Truck_Support"};
		};
		class EN_Vehicle_Group_3: EN_Vehicle_Group_1 {
			probability = 0.7;
			minPlayers = 16;
			vehicleTypes[] = {"Armour_AA","Armour_APC"};
		};
	};

	// Objective Condition
	class Objective {
		class Succeeded {
			state = 1; // 0:Created, 1:Succeeded, 2: Failed, 3: Canceled
			condition = "_targetsKilled";
		};
	};
};