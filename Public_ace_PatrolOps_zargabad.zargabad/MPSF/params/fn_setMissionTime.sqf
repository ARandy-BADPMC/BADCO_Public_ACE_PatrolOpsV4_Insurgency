/*
	Description:
	This function updates the misison parameter time
		- PARAM Only
*/
if !(isServer) exitWith {};

params [["_timeValue",8,[0]]];

private _dateTime = date;
_dateTime set [3,0 max _timeValue min 23];

[_dateTime] call MPSF_fnc_setDateTime;