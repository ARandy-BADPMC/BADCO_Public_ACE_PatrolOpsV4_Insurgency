/*
	Author: Ji?? Wainar (Warka), optimised by Killzone_Kid, modified by Eightysix
*/
private _cfg = _this call BIS_fnc_getCfg;
if (isText _cfg) exitWith {missionNamespace getVariable [getText _cfg, objNull]};
objNull