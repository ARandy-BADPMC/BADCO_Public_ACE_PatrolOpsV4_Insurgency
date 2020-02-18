/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_addZeusEditArea.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Creats a Zeus Area
*/
params [["_areaID","",[""]],["_position",[0,0,0],[[]]],["_radius",0,[0,[]]],["_curators",allCurators,[[]]]];

if (typeName _radius isEqualTo typeName []) then { _radius = (_radius select 0) max (_radius select 1); };
if (_position isEqualTo [0,0,0] || _radius isEqualTo 0) exitWith {""};

private _areaIDs = missionNamespace getVariable ["MPSF_Zeus_AreaIDs",[]];
private _areaIDx = _areaIDs find _areaID;
if (_areaIDx >= 0) exitWith {""};
_areaIDx = count _areaIDs;
_areaIDs set [_areaIDx,_areaID];
missionNamespace setVariable ["MPSF_Zeus_AreaIDs",_areaIDs];

if ((["ZeusZoneRestrict",0] call BIS_fnc_getParamValue) isEqualTo 1) then {
	{
		_x addCuratorEditingArea [_areaIDx,_position,_radius];
	} foreach _curators;
};

_areaID;