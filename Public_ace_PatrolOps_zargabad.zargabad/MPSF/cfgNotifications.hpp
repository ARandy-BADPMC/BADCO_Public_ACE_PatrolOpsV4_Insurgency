// INTEL
class MPSF_onIntelDownloadComplete {
	title = "Intel Download";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "%1 has completed downloading intel";
	priority = 5;
	sound = "taskAssigned";
};

class MPSF_onIntelDownloadStart {
	title = "Intel Download";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "%1 has started downloading Intel";
	priority = 5;
	sound = "taskAssigned";
};

class MPSF_onIntelDownloadStop {
	title = "Intel Download";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "Intel download has been cancelled";
	priority = 5;
	sound = "taskAssigned";
};

class MPSF_onIntelRecieve {
	title = "Intel Receive";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "%1 has received intel from %2";
	priority = 5;
	sound = "taskAssigned";
};

class MPSF_onIntelPickup {
	title = "Intel Picked Up";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "%1 has found a piece of intel";
	priority = 5;
	sound = "taskAssigned";
};

class MPSF_onIntel {
	title = "%1";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "%2";
	priority = 5;
	sound = "taskAssigned";
};

// Virtual Armoury
class VirtualArmoury_RoleRequest {
	title = "Role Requested";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "%1 requesting %2 assignment";
	priority = 5;
	duration = 5;
	sound = "taskAssigned";
};

class VirtualArmoury_RoleAssigned {
	title = "Role Assigned";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "%1 assigned as %2";
	priority = 5;
	duration = 5;
	sound = "taskAssigned";
};

class VirtualArmoury_RoleFailed {
	title = "Unqualified Operator";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "You are not qualified to operate this vehicle";
	priority = 5;
	duration = 5;
	sound = "taskAssigned";
};

class VirtualArmoury_RoleLimitReached {
	title = "Role Limit Reached";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "%1 roles are all taken";
	priority = 5;
	duration = 5;
	sound = "taskAssigned";
};

// INTEL
class MPSF_oncreateIntelOperation {
	title = "New Operation Available";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "New operation available at base";
	priority = 2;
	sound = "taskAssigned";
};