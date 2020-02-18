class op_2_targetHVT: TaskDefaults {
	scope = 1;
	typeID = 2;
	positionSearchTypes[] = {"Town","Villa","House"};
	positionSearchRadius = 1000;
	positionNearLast = 1;
	class TaskDetails {
		title = "%1";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3<br/>AO: %4 %5 near %6</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>Intel confirmation recieved on a priority target located near %6. Intel indicates that %8 squads are undergoing an excercise overseen by a high ranking officer from a foriegn entity belived to be funding and training %8 forces. This individual is considered highly valuable and could be carrying further intel on %8 operations in this region.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%7 forces will move to the area and conduct a sweep to locate and either attempt to capture or eliminate the target including the collection of any intel they may have.</t>"
			,"<t size='1.1' color='#FFC600'>Intel:</t> <t>%8 forces are believed to be minimal with a likelyhood of only one small squad operating in that area with small arms and possible a light technical for transport. It is unlikely that they will want to draw attention to themselves and the officer.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Civilian population are active in the atea and are unlikely to be a concern. Keep an eye out for watchers who will track %7 movements and report to the enemy.</t>"
			,"op_2_targetHVT"
		};
		iconType = "Attack";
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
		class marker_target { // TODO: REMOVE
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
		class HVT_Target_Group {
			isTarget = 1;
			probability = 1;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"TargetHVT"};
			isPatrolling = 0.2;
			radius[] = {80,120};
			isDefending = 1;
			occupyBuildings = 1;
		};
		class HVT_Guard_Group {
			probability = 1;
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
			groupTypes[] = {"Squad8","Squad8_AA","Squad8_AR","Squad8_AT","Squad8_M","Squad4","Squad4_AA","Squad4_AR","Squad4_AT","Squad4_M"};
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
			vehicleTypes[] = {"CarTurret","Car"};
			createCrew = 1;
			isPatrolling = 0.6;
			radius[] = {150,250};
		};
		class EN_Vehicle_Group_2: EN_Vehicle_Group_1 {
			probability = 0.7;
			minPlayers = 8;
			vehicleTypes[] = {"CarTurret","Armour_AA","Armour_APC"};
		};
		class EN_Vehicle_Group_3: EN_Vehicle_Group_1 {
			probability = 0.7;
			minPlayers = 16;
			vehicleTypes[] = {"Armour_AA","Armour_APC"};
		};
	};
	class Objective {
		class Succeeded {
			state = 1; // 0:Created, 1:Succeeded, 2: Failed, 3: Canceled
			condition = "_targetsKilled";
		};
	};
};

class op_2_targetHVT_INS: op_2_targetHVT {
	scope = 1;
	typeID = 2;
	positionSearchTypes[] = {"Shack","Village","House","Villa"};
	positionSearchRadius = 1000;
	positionNearLast = 1;
	class TaskDetails {
		title = "%1";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3<br/>AO: %4 %5 near %6</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>Confirmation recieved on a valuable target located near %6. Intel indicates that %8 squads are undergoing an excercise overseen by a ranking member of %8. This individual is considered a valuable opportunity and could be carrying further intel on %8 operations in this region.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%7 forces will move to the area and conduct a sweep to locate and either attempt to capture or eliminate the target including the collection of any intel they may have.</t>"
			,"<t size='1.1' color='#FFC600'>Intel:</t> <t>%8 forces are believed to be minimal with a likelyhood of only one small squad operating in that area with small arms and possible a light technical for transport. It is unlikely that they will want to draw attention to themselves and the officer.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Civilian population are active in the atea and are unlikely to be a concern. Keep an eye out for watchers who will track %7 movements and report to the enemy.</t>"
			,"op_2_targetHVT_INS"
		};
		iconType = "Attack";
		iconPosition = "position";
		textArguments[] = {"operationName","randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort"};
	};
	class Groups {
		class HVT_Target_Group {
			isTarget = 1;
			probability = 1;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"TargetHVT_INS"};
			isPatrolling = 0.2;
			radius[] = {80,120};
			isDefending = 1;
			occupyBuildings = 1;
		};
		class HVT_Guard_Group {
			probability = 1;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"ParaMilitary"};
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
			groupTypes[] = {"Squad8_INS","Squad4_INS"};
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
			vehicleTypes[] = {"CarTurret_INS","Car_INS","Truck_INS"};
			createCrew = 1;
			isPatrolling = 0.6;
			radius[] = {150,250};
		};
		class EN_Vehicle_Group_2: EN_Vehicle_Group_1 {
			probability = 0.7;
			minPlayers = 8;
		};
		class EN_Vehicle_Group_3: EN_Vehicle_Group_1 {
			probability = 0.7;
			minPlayers = 16;
		};
	};
	class Objective {
		class Succeeded {
			state = 1; // 0:Created, 1:Succeeded, 2: Failed, 3: Canceled
			condition = "_targetsKilled";
		};
	};
};