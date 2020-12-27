params [["_target",player,[objNull]]];

if !(isPlayer _target) exitWith {};
if !(["mpsf_bodybags"] call MPSF_fnc_getCfgDataBool) exitWith {};

// Check is Laws of War installed
if !(isClass (configfile >> "CfgVehicles" >> "Land_Bodybag_01_white_F")) exitWith {};

// Player Redeploy Menu
["MPSF_Action_bodyBag",player,"Prepare Body Recovery",[
	["mpsf\data\holdactions\holdAction_bodybag_ca.paa",{
		missionNamespace setVariable ["MPSF_Action_bodyBag_target",cursorTarget];
		player playActionNow "medicStartUp";
	}]
	,["mpsf\data\holdactions\holdAction_bodybag_ca.paa",{}]
	,{
		private _target = missionNamespace getVariable ["MPSF_Action_bodyBag_target",objNull];
		if (isNull _target) exitWith {};

		private _attributes = _target getVariable ["MPSF_INTEL_ATTRIBUTES",[]];
		["onBodyBagComplete",[_target,_attributes],true] call MPSF_fnc_triggerEventHandler;

		private _bagClass = switch ([_target,true] call BIS_fnc_objectSide) do {
			case ([3] call BIS_fnc_sideType) : {"Land_Bodybag_01_white_F"};
			case ([player,false] call BIS_fnc_objectSide) : {"Land_Bodybag_01_blue_F"};
			default {"Land_Bodybag_01_black_F"};
		};

		private _position = _target modelToWorldVisualWorld [0,0,0];
		private _direction = getDirVisual _target;
		deleteVehicle _target;

		private _bodyBag = createSimpleObject [_bagClass,_position];
		_bodyBag setPosASL _position;
		_bodyBag setDir _direction;
		_bodyBag setVectorUp surfaceNormal _position;

		missionNamespace setVariable ["MPSF_Action_bodyBag_target",nil];
		player playActionNow "medicStop";
	},{
		missionNamespace setVariable ["MPSF_Action_bodyBag_target",nil];
		player playActionNow "medicStop";
	}
	,6,false,101
],[],"(vehicle cursorTarget) isKindOf 'CaManBase'"
	+ " && {!alive cursorTarget}"
	+ " && {cursorTarget distance2D player < 2}"
	+ " || {!isNull(missionNamespace getVariable ['MPSF_Action_bodyBag_target',objNull])}"
,true] spawn {sleep 2; _this call MPSF_fnc_addAction;};

true;