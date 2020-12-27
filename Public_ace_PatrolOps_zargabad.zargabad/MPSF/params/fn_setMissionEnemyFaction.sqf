/*
	Description:
	This function updates the misison parameter time acceleration
		- PARAM Only
*/
if !(isServer) exitWith {};

params [["_factionID",2,[0]]];
_factionID = ["OPF_F","BLU_F","IND_F","OPF_G_F","BLU_G_F","IND_G_F"] select (_factionID);

missionNamespace setVariable ["PO4_Mission_var_enemyfaction",_factionID];
