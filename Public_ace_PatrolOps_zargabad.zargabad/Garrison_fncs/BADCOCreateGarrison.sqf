_pos = _this select 0;
_trigger = _this select 1;
_grpSize = _this select 2;

_comp = switch _grpSize do 
{
	case "small": {["LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_Rifleman_3","LOP_ISTS_Infantry_AT"]};
	case "medium": {["LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_Rifleman_3","LOP_ISTS_Infantry_AT","LOP_ISTS_Infantry_Rifleman_3","LOP_ISTS_Infantry_Rifleman_5"]};
	default {["LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_Rifleman_3","LOP_ISTS_Infantry_AT","LOP_ISTS_Infantry_Rifleman_3","LOP_ISTS_Infantry_Rifleman_5","LOP_ISTS_Infantry_GL","LOP_ISTS_Infantry_Corpsman","LOP_ISTS_Infantry_Marksman"]};
};

_grp = createGroup [Independent, false];
{
	_unit = _grp createUnit [_x,_pos, [],10,"NONE"];
} forEach _comp;
nul = [_grp,100,true,[60,2],true] execVM "Garrison_fncs\Garrison_script.sqf";	
_trigger setVariable ["group",_grp];

