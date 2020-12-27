class op_2_targetColumnArmour: TaskDefaults {
	scope = 1;
	typeID = 2;
	positionSearchTypes[] = {"Town","Village","House"};
	positionSearchRadius = 1000;
	positionNearLast = 1;
	class TaskDetails {
		title = "%1";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3<br/>AO: %4 %5 near %6</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>A UAV conducting a surveillance flight over %6 has spotted %8 armoured vehicles operating in the area. This incursion is a direct threat to both %7 operations and civilian traffic.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%7 forces will move to %6 and conduct a sweep to eliminiate any armoured platforms and hostile %8 forces.</t>"
			,"<t size='1.1' color='#FFC600'>Intel:</t> <t>As many as three large heat signitures where detected to be operating in the area however the report could not confirm if civilian vehicles where identified.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>It is likely that the local civilian population has not noticed the rapid deployment of %8 so extreme caution is recommended to minimise civilian casualty.</t>"
			,"op_2_targetColumnVehicle"
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
		class Target_1 {
			isTarget = 1;
			probability = 1;
			position = "positionOffset";
			distance[] = {50,100};
			direction[] = {0,120};
			faction = "FactionTypeOPF";
			vehicleTypes[] = {"Armour_APC","Armour_MBT"};
			createCrew = 1;
			isPatrolling = 1;
			radius[] = {800,1200};
		};
		class Target_2: Target_1 {
			probability = 0.8;
			minPlayers = 5;
			direction[] = {121,240};
		};
		class Target_3: Target_1 {
			probability = 0.8;
			minPlayers = 10;
			direction[] = {241,360};
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