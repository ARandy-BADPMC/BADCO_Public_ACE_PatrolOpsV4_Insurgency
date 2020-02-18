/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createAircraftCAS.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Creates a CAS Aircraft
*/
params [
	["_attackPos",[0,0,0],[[]]]
	,["_attackDir",random 360,[0]]
	,["_faction","FactionTypeOPF",[""]]
	,["_aircraftClass","",[""]]
	,["_forceAttack",false,[false]]
];

private _startPos = _attackPos getPos [6000,_attackDir];
private _flyInHeight = 250;
_startPos set [2,_flyInHeight];
private _direction = _startPos getDir _attackPos;

// Check faction ID
private _faction = [_faction] call MPSF_fnc_getCfgFactionID;

// Check aircraft classname
if !(isClass(configFile >> "CfgVehicles" >> _aircraftClass)) then {
	_aircraftClass = ["vehicles",_faction,_aircraftClass,true] call MPSF_fnc_getCfgFactionData;
};

private _aircraftData = [_startPos,_faction,_aircraftClass,_direction,true] call MPSF_fnc_createVehicle;
_aircraftData params [["_aircraft",objNull,[objNull]],["_crew",[],[[]]]];
_aircraft flyInHeight _flyInHeight;
_aircraftPilot = driver _aircraft;
_aircraftPilot setSkill 1;
_aircraftPilot doMove _attackPos;

[group _aircraftPilot,_attackPos] call MPSF_fnc_setGroupPatrol;