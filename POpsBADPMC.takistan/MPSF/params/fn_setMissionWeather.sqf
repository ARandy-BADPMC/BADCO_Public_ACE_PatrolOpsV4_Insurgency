/*
	Description:
	This function updates the misison parameter weather
		- PARAM Only
*/
params [["_weatherSetting",0,[0]]];

[["Clear","Overcast_Light","Overcast_Heavy","Thunderstorm","Sandstorm","Snowstorm","Nuclear"] select _weatherSetting] call MPSF_fnc_setWeather;

true;