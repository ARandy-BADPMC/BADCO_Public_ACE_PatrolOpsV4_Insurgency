class op_4_RetrieveIntelHVT: TaskDefaults {
	scope = 0;
	typeID = 4;

	// Random Position
	positionSearchTypes[] = {"Town","Shack","Village","House"};
	positionSearchRadius = 1000;
	positionNearLast = 1;

	// Description
	class TaskDetails {
		// parent = ""; // No Parent
		title = "%1";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3<br/>AO: %4 %5 near %6</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>FOP</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>Redacted.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>Redacted.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Redacted.</t>"
		};
		iconType = "Intel";
		iconPosition = "position";
		textArguments[] = {"operationName","randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort"};
	};

	// Markers
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

	// Groups + Targets
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
			dropIntel = 1;
		};
		class HVT_Guard_Group {
			probability = 0.9;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"ReconTeam"};
			isPatrolling = 0.4;
			radius[] = {60,100};
			isDefending = 1;
			occupyBuildings = 1;
		};
		class EN_Group_1 {
			probability = 1;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"Squad8","Squad8_AA","Squad8_AR","Squad8_AT","Squad8_M"};
			isPatrolling = 0.9;
			radius[] = {100,150};
			isDefending = 1;
			occupyBuildings = 1;
		};
		class EN_Group_2 {
			probability = 1;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"Squad4","Squad4_AA","Squad4_AR","Squad4_AT","Squad4_M"};
			isPatrolling = 1;
			radius[] = {150,250};
		};
	};

	// Objective Condition
	class Objective {
		class Succeeded {
			condition = "_targetsKilled && _intelPickedUp";
		};
	};
};