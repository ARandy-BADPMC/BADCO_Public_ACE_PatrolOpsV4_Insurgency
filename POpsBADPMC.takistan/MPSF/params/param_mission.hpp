class MPSFMissionLimit {
	title = "Mission Limit on Operations";
	values[] = {1,3,5,7,9,0};
	default = 1;
	texts[] = {"1 Op","3 Ops","5 Ops","7 Ops","9 Ops","Unlimited Ops"};
	function = "MPSF_Param_fnc_setMissionLimit";
};

class MPSFMissionRadius {
	title = "Mission Range between Operations";
	values[] = {1000,2000,3000,4000,5000,6000,7000,8000,9000,10000};
	default = 3000;
	texts[] = {"1Km","2Km","3Km","4Km","5Km","6Km","7Km","8Km","9Km","10Km"};
	function = "MPSF_Param_fnc_setMissionRange";
};

class MPSFOperationType {
	title = "Mission Operation Type";
	values[] = {0,1,2};
	texts[] = {"Patrol Operations","Random Operations","Random Missions"};
	default = 0;
};

/* class MPSFBaseSelection {
	title = "Base of Operations";
	values[] = {0,1,2,3};
	texts[]={"Safe Base Bravo (SthEast)","Safe Base Charlie (NthEast)","Safe Base Delta (NthWst)","USS Freedom (Aircraft Carrier)"};
	default = 1;
}; */

class PO4_Mission_Limit {
	title = "Tour of Duty Duration";
	values[] = {0,1,3,5,7,9};
	texts[] = {"Infinite","1 Operation","3 Ops","5 Ops","7 Ops","9 Ops"};
	default = 3;
};
