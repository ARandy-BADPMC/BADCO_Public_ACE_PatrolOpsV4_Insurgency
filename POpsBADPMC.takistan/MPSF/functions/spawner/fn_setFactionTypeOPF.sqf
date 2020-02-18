/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_setFactionTypeOPF.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Overwrite mission faction on the fly
*/

#define CFGSIDEFACTIONS	["OPF_F","BLU_F","IND_F","OPF_G_F","BLU_G_F","IND_G_F"]

if !(isServer) exitWith {};

params [["_factionID",0,[0,""]]];

if (_factionID isEqualTo 0) exitWith { false; };
if (_factionID isEqualType 0) then {
	private _factionID = CFGSIDEFACTIONS select (_factionID - 1);
};

if !(_factionID IN (["CfgMissionFramework","Factions"] call BIS_fnc_getCfgSubClasses)) exitWith { false; };

missionNamespace setVariable ["MPSF_Mission_var_enemyfaction",_factionID];
publicVariable "MPSF_Mission_var_enemyfaction";

true;