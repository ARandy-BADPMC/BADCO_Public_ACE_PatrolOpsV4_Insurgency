/*
	Description:
	This function updates the mission parameter time acceleration
		- PARAM Only
*/
if !(isServer) exitWith {};

params [["_range",2000,[0]]];

missionNamespace setVariable ["PO4_Mission_var_objectiveRange",_range];