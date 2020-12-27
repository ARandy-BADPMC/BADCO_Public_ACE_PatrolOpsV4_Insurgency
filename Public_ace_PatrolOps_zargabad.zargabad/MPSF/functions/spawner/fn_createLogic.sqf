/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createLogic.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Creats a virtual logic
*/
params [["_position",[0,0,0],[[]]],["_direction",0,[0]]];

private _logicGroup = missionNamespace getVariable ["MPSF_Logic_var_groupID",grpNull];
if (isNull _logicGroup) then {
	private _logicCenter = createCenter sideLogic;
	_logicGroup = createGroup _logicCenter;
	missionNamespace setVariable ["MPSF_Logic_var_groupID",_logicGroup];
	publicVariable "MPSF_Logic_var_groupID";
};

_position set [2,0];

private _logic = _logicGroup createUnit ["Logic",_position,[],0,"NONE"];
if (surfaceIsWater _position) then { _logic setPosASL _position; } else { _logic setPosATL _position; };
_logic setDir _direction;

_logic;