/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_initZeus.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Zeus Framework
*/
#define MISSIONTIME							(if (isMultiplayer) then {serverTime} else {time})
#define CHECKFRAME(width,offset)			(((diag_frameno - offset) % width) == 0)

if (isServer) then {
	private _zoneRestict = (["ZeusZoneRestrict",0] call BIS_fnc_getParamValue) isEqualTo 1;
	{
		_x allowCuratorLogicIgnoreAreas true; // Allow Modules placed anywhere.
		_x setCuratorEditingAreaType _zoneRestict; // Restrict to Areas to inside or out
	} forEach allCurators;

	["MPSF_ZeusObjectsSync_EH","onEachFrame",{
		if (CHECKFRAME(500,12)) then {
			{
				_x addCuratorEditableObjects [allPlayers,true];
			} foreach allCurators;
		};
	}] call MPSF_fnc_addEventHandler;
};