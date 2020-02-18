/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createAircraftFlyby.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Creates an Aircraft Flyby

	Parameter(s):
		0: Object - Description

	Returns:
		Bool - True when done
*/
params [
	["_waypoints",[],[[]]]
	,["_altitude",random 360,[0]]
	,["_faction","FactionTypeOPF",[""]]
	,["_classNames",[],[[],""]]
	,["_aircraftCount",1,[0]]
];

if (count _waypoints < 2) exitWith {};

if (typeName _classNames isEqualTo typeName "") then {
	private _factionVehicles = ["vehicles",_faction,_classNames] call MPSF_fnc_getConfigSides;
	_classNames = [];
	for "_i" from 1 to _aircraftCount do {
		_classNames pushBack (selectRandom _factionVehicles);
	};
};
if (count _classNames isEqualTo 0) exitWith {};

private _spawnPosition = _waypoints deleteAt 0;
private _direction = _spawnPosition getDir (_waypoints select 0);

private _aircraftData = [_startPos,_faction,_aircraftClass,_direction,true] call MPSF_fnc_createVehicle;
_aircraftData params [["_aircraft",objNull,[objNull]],["_crew",[],[[]]]];
_aircraft flyInHeight _flyInHeight;
_aircraftPilot = driver _aircraft;
_aircraftPilot setSkill 1;
_aircraftPilot disableAI "TARGET";
_aircraftPilot disableAI "AUTOTARGET";
