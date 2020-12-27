class op_8_EngageAirSuperiority_SouthWest: TaskDefaults {
	scope = 0;
	typeID = 8;

	// Starting Position
	position[] = {0,0,1500};

	// Description
	class TaskDetails {
		title = "%1";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3<br/>AO: %4 %5 near %6</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>Redacted.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>Redacted.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>Redacted.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Redacted.</t>"
		};
		iconType = "Destroy";
		textArguments[] = {"operationName","randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort","vehiclename"};
	};

	// Groups + Targets
	class Groups {
		class AirSuperiorityFighter_1 {
			isTarget = 1;
			probability = 1;
			position = "position";
			faction = "FactionTypeOPF";
			vehicleTypes[] = {"Plane"};
			createCrew = 1;
			jet = 1;
		};
		class AirSuperiorityFighter_2: AirSuperiorityFighter_1 {
			probability = 0.95;
		};
		class AirSuperiorityFighter_3: AirSuperiorityFighter_1 {
			probability = 0.65;
		};
		class AirSuperiorityFighter_4: AirSuperiorityFighter_1 {
			probability = 0.45;
			minPlayers = 15;
		};
		class AirSuperiorityFighter_5: AirSuperiorityFighter_1 {
			probability = 0.25;
			minPlayers = 25;
		};
	};

	// Objective Condition
	class Objective {
		class Succeeded {
			condition = "_targetsKilled";
		};
	};
};