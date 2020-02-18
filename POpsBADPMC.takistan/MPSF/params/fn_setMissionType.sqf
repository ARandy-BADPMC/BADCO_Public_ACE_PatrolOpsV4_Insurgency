/*
	Description:
	This function updates the misison parameter type
		- PARAM Only
*/
if !(isServer) exitWith {};

params [["_type",0,[0]]];

_type = switch (_type) do {
	case 1 : { "Occupation"; };
	case 2 : { "Foothold"; };
	case 3 : { "Operations" };
	case 4 : { "Patrols" };
	default { ""; };
};

missionNamespace setVariable ["PO4_PARAM_var_gamemode",_type];

["init",[_type]] call PO4_fnc_StoryBuilder;