/*
	Description:
	This function updates the misison parameter time acceleration
		- PARAM Only
*/
if !(isServer) exitWith {};

params [["_multiplier",2,[0]]];
_multiplier = [0.1,0.5,1,2,4,6,12,24] select (_multiplier);

[_multiplier] call PO4_fnc_setTimeMultiplier;