class ParamDateTime {
	title = "Mission Start Hour";
	values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
	default = 7;
	texts[]={"0000H (Midnight)","0100H","0200H","0300H","0400H","0500H (Sunrise)","0600H","0700H","0800H","0900H","1000H","1100H","1200H (Midday)","1300H","1400H","1500H","1600H","1700H","1800H","1900H (Sunset)","2000H","2100H","2200H","2300H"};
	function = "MPSF_Param_fnc_setMissionTime";
};