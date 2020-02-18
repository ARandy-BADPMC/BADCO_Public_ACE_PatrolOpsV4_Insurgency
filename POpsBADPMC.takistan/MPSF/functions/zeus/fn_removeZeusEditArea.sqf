/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_removeZeusEditArea.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Removes an existing Zeus Area
*/
params [["_areaID","",[""]]];

private _areaIDs = missionNamespace getVariable ["MPSF_Zeus_AreaIDs",[]];
private _areaIDx = _areaIDs find _areaID;
_areaIDs deleteAt _areaIDx;
missionNamespace setVariable ["MPSF_Zeus_AreaIDs",_areaIDs];

if ((["ZeusZoneRestrict",0] call BIS_fnc_getParamValue) isEqualTo 1) then {
	{
		_x removeCuratorEditingArea _areaIDx;
	} foreach allCurators;
	//["Zeus Area Removed",_areaID] call BIS_fnc_logFormatServer;
};


true;