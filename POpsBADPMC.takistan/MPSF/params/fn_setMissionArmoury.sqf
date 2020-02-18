/*
	Description:
	This function updates the misison parameter for the virtual armoury (Arsenal)
		- PARAM Only
*/
params [["_fullInventory",0,[0]]];
missionNamespace setVariable ["PO4_Param_var_fullArmoury",_fullInventory > 0];