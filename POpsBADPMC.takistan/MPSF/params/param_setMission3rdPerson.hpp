class MPSFrestict3rdPerson {
	title = "3rd Person Perspective (Over Shoulder Camera)";
	values[] = {0,1,2,3,4};
	default = 0;
	texts[] = {"Enabled","Armour Drivers Only","Aircraft Pilots Only","Any Driver or Pilot Only","Disabled"};
	function = "MPSF_Param_fnc_setMission3rdPerson";
	isGlobal = 1;
};