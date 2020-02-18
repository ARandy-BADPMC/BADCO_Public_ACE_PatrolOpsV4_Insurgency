/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createParadrop.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Creats a paradrop of units
*/
params [
	["_startPos",[0,0,0],[[]]]
	,["_destPos",[0,0,0],[[]]]
	,["_faction","FactionTypeOPF",[""]]
	,["_aircraftClass","",[""]]
	,["_squadType","",["",[]]]
	,["_forceJump",false,[false]]
];

//[getMarkerPos "testStart",getMarkerPos "testDest","EnemyFaction","Helicopter","Squad8",true] call MPSF_fnc_createParadrop;

private _flyInHeight = 200;
_startPos set [2,_flyInHeight];
private _direction = _startPos getDir _destPos;

// Check faction ID
if (_faction IN ["FactionTypeBLU","FactionTypeOPF","FactionTypeCIV"]) then {
	_faction = [_faction] call MPSF_fnc_getConfigMission;
};

// Check aircraft classname
if !(isClass(configFile >> "CfgVehicles" >> _aircraftClass)) then {
	_aircraftClass = [_faction,_aircraftClass,true] call MPSF_fnc_getConfigSideVehicles;
};
if (_aircraftClass isKindof "Plane") then { _forceJump = true; };

private _aircraftData = [_startPos,_faction,_aircraftClass,_direction,true,_squadType] call MPSF_fnc_createVehicle;
_aircraftData params [["_aircraft",objNull,[objNull]],["_crew",[],[[]]]];
_aircraft flyInHeight _flyInHeight;
_aircraftPilot = driver _aircraft;
(group _aircraftPilot) setBehaviour "SAFE";
(group _aircraftPilot) setSpeedMode "LIMITED";
(group _aircraftPilot) setCombatMode "YELLOW";
(group _aircraftPilot) setFormation (selectRandom ["ECH LEFT","ECH RIGHT"]);
_aircraftPilot setSkill 1;
_aircraftPilot disableAI "TARGET";
_aircraftPilot disableAI "AUTOTARGET";
_aircraftPilot doMove _destPos;

if !(_forceJump) then {
	_destPos = [_destPos,0,200,10,0,0.5,0] call BIS_fnc_findSafePos;
};
private _landingZone = "HeliHEmpty" createVehicle _destPos;
_landingZone setPosATL _destPos;

[format["MPSF_Paradrop_%1",_aircraft call BIS_fnc_netID],"onEachFrame",{
	if (diag_frameNo % 50 == 0) then {
		params ["_aircraft","_forceJump","_destPos"];
		private _stage = _aircraft getVariable ["Paradrop_Stage","travel"];
		private _exit = false;
		switch (true) do {
			case (!alive _aircraft) : { _exit = true; };
			case (_forceJump && _aircraft distance2D _destPos < 250 && !(_stage == "flyout")) : {
				_aircraft setVariable ["Paradrop_Stage","flyout"];
				_aircraft doMove (_destPos getPos [5000,direction _aircraft]);
				private _jumpList = fullCrew _aircraft select {toLower(_x select 1) == "cargo"};
				[_jumpList,_destPos] spawn {
					params ["_jumpList","_destPos"];
					private _jumpGroup = grpNull;
					{
						_x params ["_unit","_role","_cargoIndex","_turretPath","_personTurret"];
						unassignVehicle _unit;
						moveOut _unit;
						if !(backpack _unit isEqualTo "") then {removeBackpack _unit;};
						_unit addBackpack "B_parachute";
						_jumpGroup = group _unit;
						sleep 1;
					} forEach _jumpList;
					[_jumpGroup,_destPos,150] call MPSF_fnc_setGroupPatrol;
				};
			};
			case (!_forceJump && _aircraft distance2D _destPos < 250 && !(_stage == "flyout")) : {
				_aircraft setVariable ["Paradrop_Stage","flyout"];
				_aircraft land "Land";
			};
			case (_stage == "flyout" && _aircraft distance2D _destPos > 3000) : {
				{ deleteVehicle _x; } forEach (crew _aircraft + [_aircraft]);
				_exit = true;
			};
		};
		if (_exit) then {
			[format["MPSF_Paradrop_%1",_aircraft call BIS_fnc_netID],"onEachFrame"] call MPSF_fnc_removeEventHandler;
		};
	};
},[_aircraft,_forceJump,_destPos]] call MPSF_fnc_addEventHandler;