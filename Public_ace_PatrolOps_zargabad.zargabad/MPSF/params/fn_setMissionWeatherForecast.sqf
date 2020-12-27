/*
	Description:
	This function updates the misison parameter weather forecast
		- PARAM Only
*/
params [["_weatherSetting",0,[0]]];

[_weatherSetting,60] call MPSF_fnc_setWeather;