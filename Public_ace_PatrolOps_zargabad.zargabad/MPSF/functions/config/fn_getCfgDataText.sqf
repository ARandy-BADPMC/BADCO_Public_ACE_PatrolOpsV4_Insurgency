/*
	Author: Ji?? Wainar (Warka), optimised by Killzone_Kid, modified by Eightysix
*/
private _cfg = _this call BIS_fnc_getCfg;
if (isNumber _cfg) exitWith {str getNumber _cfg};
getText _cfg;