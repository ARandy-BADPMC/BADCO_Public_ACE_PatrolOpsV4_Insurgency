class op_6_DeployCommsTower: TaskDefaults {
	scope = 0;
	typeID = 6;

	// Random Position
	positionSearchTypes[] = {"Hill"};
	positionSearchRadius = 1000;
	positionNearLast = 1;

	// Description
	class TaskDetails {
		title = "%1";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3<br/>AO: %4 %5 near %6</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>FOP</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>Redacted.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>Redacted.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Redacted.</t>"
		};
		iconType = "Destroy";
		iconPosition = "position";
		textArguments[] = {"operationName","randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort"};
	};

	class DeployableObjects {
		class object_1 {
			containerClass = "Land_Cargo20_military_green_F";
			deployClass = "Land_TTowerBig_1_F";
			position = "return_point";
			angle = -1;
			class Destination {
				position = "position";
				radius = 30;
			};
		};
	};

	// Objective Condition
	class Objective {
		class Succeeded {
			condition = "_targetsDeployed";
		};
	};
};