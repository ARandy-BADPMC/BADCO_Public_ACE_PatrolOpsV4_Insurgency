/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_setWeather.sqf
	Author(s): see mpsf\credits.txt

	Description:
		This function updates the misison weather

	Parameter(s):
		0: STRING	- Weather Type

	Returns:
		BOOL
*/
params [["_weatherProfile","",[""]],["_timeDelay",0,[0]]];

private _weatherProfiles = ["CfgMissionFramework","EnvironmentWeather"] call BIS_fnc_getCfgSubClasses;
if (count _weatherProfiles == 0) exitWith {};
if !(_weatherProfile in _weatherProfiles) exitWith { /*["Weather Profile %1 not found",str _weatherProfile] call BIS_fnc_error;*/ };

private _weatherParams = ["getCfgWeatherProfile",[_weatherProfile]] call MPSF_fnc_environment;

_weatherParams params ["_overcast","_fog","_wind","_lightning","_colorCorrections","_filmGrain","_PPeffect"];

// Overcast
["setOvercast",[_overcast,_timeDelay]] call MPSF_fnc_environment;

if (_timeDelay == 0) then {
	["setFog",[_fog,_timeDelay]] call MPSF_fnc_environment;
};

["setWind",[_wind,round random 360,_timeDelay]] call MPSF_fnc_environment;
//[_lightning,_timeDelay] call MPSF_fnc_setLightnings;
//[_colorCorrections,_timeDelay] call MPSF_fnc_setColourCorrection;
//[_filmGrain,_timeDelay] call MPSF_fnc_setFilmgrain;
//[_PPeffect,_timeDelay] call MPSF_fnc_setPPEffect;

true;