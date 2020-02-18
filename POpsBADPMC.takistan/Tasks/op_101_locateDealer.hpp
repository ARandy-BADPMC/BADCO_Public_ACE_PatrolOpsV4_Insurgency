class op_101_locateDealer_parent {
	scope = 1;
	typeID = 101;
	class TaskDetails {
		parent = "";
		title = "%1";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>Redacted.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>Redacted.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>Redacted.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Redacted.</t>"
		};
		iconType = "PatrolOps";
		textArguments[] = {"operationName"};
	};
	class ChildTasks {
		startingTask[] = {"op_101_locateDealer_1a_intelSquad","op_101_locateDealer_1b_intelLaptop"};
		class op_101_locateDealer_1a_intelSquad {
			//
		};
		class op_101_locateDealer_1b_intelLaptop {
			//
		};
		class op_101_locateDealer_2a_capture {
			//
		};
		class op_101_locateDealer_2b_eliminate {
			//
		};
	};
	class Markers {};
	class Objective {
		class Succeeded {
			state = 1; // 0:Created, 1:Succeeded, 2: Failed, 3: Canceled
			condition = "_childTasksComplete";
		};
	};
};

class op_101_locateDealer_1a_intelSquad {
	scope = 1;
	typeID = 101;
	class TaskDetails {
		parent = "";
		title = "Locate INTEL";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>Redacted.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>Redacted.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>Redacted.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Redacted.</t>"
		};
		iconType = "PatrolOps";
		textArguments[] = {"operationName"};
	};
};

class op_101_locateDealer_1b_intelLaptop {
	scope = 1;
	typeID = 101;
	class TaskDetails {
		parent = "";
		title = "Locate INTEL";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>Redacted.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>Redacted.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>Redacted.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Redacted.</t>"
		};
		iconType = "PatrolOps";
		textArguments[] = {"operationName"};
	};
};

class op_101_locateDealer_2a_capture {
	scope = 1;
	typeID = 101;
	class TaskDetails {
		parent = "";
		title = "%1";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>Redacted.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>Redacted.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>Redacted.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Redacted.</t>"
		};
		iconType = "PatrolOps";
		textArguments[] = {"operationName"};
	};
};

class op_101_locateDealer_2b_eliminate {
	scope = 1;
	typeID = 101;
	class TaskDetails {
		parent = "";
		title = "%1";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>Redacted.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>Redacted.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>Redacted.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Redacted.</t>"
		};
		iconType = "PatrolOps";
		textArguments[] = {"operationName"};
	};
};