params [["_target",player,[objNull]]];

if !(isPlayer _target) exitWith {};
if !(["mpsf_bodysearch"] call MPSF_fnc_getCfgDataBool) exitWith {};

// Player Redeploy Menu
["MPSF_Action_bodySearch",player,"Seach Body",[
	["mpsf\data\holdactions\holdAction_search_ca.paa",{
		missionNamespace setVariable ["MPSF_Action_bodySearch_target",cursorTarget];
		player playActionNow "medicStartUp";
	}],["mpsf\data\holdactions\holdAction_search_ca.paa",{}]
	,{
		private _target = missionNamespace getVariable ["MPSF_Action_bodySearch_target",objNull];
		if (isNull _target) exitWith {};

		private _attributes = _target getVariable ["MPSF_INTEL_ATTRIBUTES",[]];
		["onBodySearchComplete",[_target,_attributes],0] call MPSF_fnc_triggerEventHandler;
		_target setVariable ["MPSF_INTEL_ATTRIBUTES",nil,true];

		missionNamespace setVariable ["MPSF_Action_bodySearch_target",nil];
		player playActionNow "medicStop";
	},{
		missionNamespace setVariable ["MPSF_Action_bodySearch_target",nil];
		player playActionNow "medicStop";
	}
	,9,false,101
],[],"(vehicle cursorTarget) isKindOf 'CaManBase'"
	+ " && {!alive cursorTarget}"
	+ " && {cursorTarget distance2D player < 2}"
	+ " && !(isnil{cursorTarget getVariable 'MPSF_INTEL_ATTRIBUTES'})"
	+ " || {!isNull(missionNamespace getVariable ['MPSF_Action_bodySearch_target',objNull])}"
,true] spawn {sleep 2; _this call MPSF_fnc_addAction;};

true;