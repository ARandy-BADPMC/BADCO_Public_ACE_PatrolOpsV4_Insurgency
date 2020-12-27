/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createDeployable.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Creates a deployable object
*/
if (hasInterface && !isServer) exitWith {};

params [["_position",[0,0,0],["",[],objNull]],["_direction",0,[0]],["_containerClassname","",[""]],["_deployedClassname","",[""]],["_attributes",[],[[]]]];

if !(_position isEqualType []) then { _position = _position call BIS_fnc_position; };
if (_position isEqualTo [0,0,0]) exitWith { /*["Invalid position %1",_position] call BIS_fnc_error;*/ objNull };

private _container = switch (true) do {
	case (_containerClassname isKindOf "ThingX") : {
		[_containerClassname,_position,_direction] call MPSF_fnc_createObject;
	};
	default {
		[_position,nil,_containerClassname,_direction] call MPSF_fnc_createVehicle;
	};
};

if (isNull _container) exitWith { /*["Unable to create container %1",_containerClassname] call BIS_fnc_error;*/ objNull };

_container setVariable ["deployedClassName",_deployedClassname,true];
_container setVariable ["attributes",_attributes,true];

[format["MPSF_Deployable_%1",_container call BIS_fnc_netID],_container,format ["Deploy %1",_deployedClassname],[
		["mpsf\data\holdactions\holdAction_repair_ca.paa",{_caller playAction "PutDown";}]
		,["mpsf\data\holdactions\holdAction_repair_ca.paa",{}]
		,{ ["onObjectDeploy",[_target,_caller],0] call MPSF_fnc_triggerEventHandler; }
		,{}
		,3,true
	],[],"damage _target < 1 && _this distance2D _target < 5",0,true
] spawn {sleep 0.125; _this call MPSF_fnc_addAction;};

_container;