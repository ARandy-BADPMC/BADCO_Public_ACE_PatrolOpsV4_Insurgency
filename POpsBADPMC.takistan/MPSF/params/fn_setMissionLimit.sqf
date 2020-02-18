/*
	Description:
	This function updates the misison parameter for the task limit
		- PARAM Only
*/
params [["_limit",0,[0]]];

if (_limit > 0) then {
	missionNamespace setVariable ["PO4_PARAM_var_taskLimit",_limit];
};
