params [
	["_depot",objNull,[objNull]]
	,["_classTypes",["All"],[[]]]
	,["_sideID",-1,[0,""]]
	,["_repair",true,[false]]
	,["_rearm",true,[false]]
	,["_refuel",true,[false]]
	,["_linkID","",[""]]
];

if (_sideID isEqualType "") then {
	_sideID = ["sideID",_sideID] call MPSF_fnc_getCfgFaction;
};

["init",[_depot,_classTypes,_sideID,[_repair,_rearm,_refuel],_linkID]] spawn { sleep 1; _this call MPSF_fnc_virtualDepot};