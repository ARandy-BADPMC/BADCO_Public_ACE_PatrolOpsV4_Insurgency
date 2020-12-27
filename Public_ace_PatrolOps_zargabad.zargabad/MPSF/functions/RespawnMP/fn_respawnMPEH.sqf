disableSerialization;

params [["_unit",objnull,[objnull]],["_otherUnit",objnull,[objnull]],["_respawn",3,[0]],["_respawnDelay",0,[0]],["_revive",false,[false]]];

if !(alive player) then {
	["onKilled",[_unit,_otherUnit]] spawn MPSF_fnc_respawnMP;
} else {
	["onRespawn",[_unit,_otherUnit]] spawn MPSF_fnc_respawnMP;
	setplayerrespawntime _respawnDelay;
};