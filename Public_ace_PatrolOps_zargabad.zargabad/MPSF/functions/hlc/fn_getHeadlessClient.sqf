/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getHeadlessClient.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Returns the best performing Headless Client

	Parameter(s):
		0: Object - Description

	Returns:
		Bool - True when done
*/
private _headlessClients = [] call MPSF_fnc_getHeadlessClients;

if (count _headlessClients > 0) then {
	private _headlessClient = objNull;
	private _currentFPS = 0;
	{
		if ((_x getVariable ["MPSF_HLC_var_clientFPS",0]) >= _currentFPS) then {
			_headlessClient = _x;
		};
	} forEach _headlessClients;
	_headlessClient;
} else {
	objNull;
};