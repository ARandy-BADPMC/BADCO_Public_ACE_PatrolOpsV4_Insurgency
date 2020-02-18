/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_logistics.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Logistics Functions
*/
params [["_mode","",[""]],["_params",[],[[],false]]];
if !(_params isEqualType []) then { _params = [_params]; };

switch (_mode) do {
// Actions
	case "actionCanTowCableDeploy" : {};
	case "actionCanTowCableAttach" : {};
	case "actionCanTowCablePickup" : {};
	case "actionCanTowCableDrop" : {};
	case "actionCanTowCablePack" : {};
	case "actionTowCableDeploy" : {
		_params params [["_vehicleTarget",objNull,[objNull]]];
		if !(canMove _vehicleTarget) exitWith { false };
		["setVehicleSource",[_vehicleTarget]] call MPSF_fnc_logistics;
		["setTowRopes",[_vehicleTarget,player]] call MPSF_fnc_logistics;
	};
	case "actionTowCableAttach" : {};
	case "actionTowCablePickup" : {};
	case "actionTowCableDrop" : {};
	case "actionTowCablePack" : {};
// Functions
	case "canTow" : {
		_params params [["_vehicleTarget",objNull,[objNull]]];
		if (isNull _vehicleTarget) exitWith { false };
		private _towTypes = ["getCfgTowTypes",[_vehicleTarget,true]] call MPSF_fnc_logistics;
		count _towTypes > 0;
	};
	case "canBeTowed" : {
		_params params [["_vehicleSource",objNull,[objNull]],["_vehicleTarget",objNull,[objNull]]];
		private _vehicleSourceTowTypes = ["getCfgTowTypes",[_vehicleSource,true]] call MPSF_fnc_logistics;
		if (count _vehicleSourceTowTypes == 0) exitWith { false };
		private _targetParents = [configFile >> "CfgVehicles" >> typeOf _vehicleTarget,true] call BIS_fnc_returnParents;
		count (_vehicleSourceTowTypes arrayIntersect _targetParents) > 0;
	};
	case "canLift" : {
		_params params [["_vehicleTarget",objNull,[objNull]]];
		if (isNull _vehicleTarget) exitWith { false };
		private _liftTypes = ["getCfgLiftTypes",[_vehicleTarget,true]] call MPSF_fnc_logistics;
		count _liftTypes > 0;
	};
	case "canBeLifted" : {
		_params params [["_vehicleSource",objNull,[objNull]],["_vehicleTarget",objNull,[objNull]]];
		private _vehicleSourceLiftTypes = ["getCfgLiftTypes",[_vehicleSource,true]] call MPSF_fnc_logistics;
		if (count _vehicleSourceLiftTypes == 0) exitWith { false };
		private _targetParents = [configFile >> "CfgVehicles" >> typeOf _vehicleTarget,true] call BIS_fnc_returnParents;
		count (_vehicleSourceLiftTypes arrayIntersect _targetParents) > 0;
	};
	case "canCarryLoad" : {
		_params params [["_vehicleTarget",objNull,[objNull]]];
		if (isNull _vehicleTarget) exitWith { false };
		private _loadTypes = ["getCfgLoadTypes",[_vehicleTarget,true]] call MPSF_fnc_logistics;
		count _loadTypes > 0;
	};
	case "canBeCarried" : {
		_params params [["_vehicleSource",objNull,[objNull]],["_vehicleTarget",objNull,[objNull]]];
		private _vehicleSourceLoadTypes = ["getCfgLoadTypes",[_vehicleSource,true]] call MPSF_fnc_logistics;
		if (count _vehicleSourceLoadTypes == 0) exitWith { false };
		private _targetParents = [configFile >> "CfgVehicles" >> typeOf _vehicleTarget,true] call BIS_fnc_returnParents;
		count (_vehicleSourceLoadTypes arrayIntersect _targetParents) > 0;
	};
// Configuration
	case "getCfgTowEnabled" : { ["CfgMissionFramework","Logistics","enableTow"] call MPSF_fnc_getCfgDataBool; };
	case "getCfgTowTypes" : {
		_params params [["_vehicle",objNull,[objNull]],["_resolve",true,[false]]];
		if (isNull _vehicle) exitWith { [] };
		private _cfgParents = [configFile >> "CfgVehicles" >> typeOf _vehicle,true] call BIS_fnc_returnParents;
		_cfgParents = _cfgParents apply { [_x,["CfgMissionFramework","Logistics",_x,"towTypes"] call MPSF_fnc_getCfgDataArray]; };
		_cfgParents = _cfgParents select { count (_x select 1) > 0};
		if (_resolve && count _cfgParents > 0) then {
			_cfgParents = (_cfgParents select 0) select 1;
		};
		_cfgParents;
	};
	case "getCfgLiftEnabled" : { ["CfgMissionFramework","Logistics","enableLift"] call MPSF_fnc_getCfgDataBool; };
	case "getCfgLiftTypes" : {
		_params params [["_vehicle",objNull,[objNull]],["_resolve",true,[false]]];
		if (isNull _vehicle) exitWith { [] };
		private _cfgParents = [configFile >> "CfgVehicles" >> typeOf _vehicle,true] call BIS_fnc_returnParents;
		_cfgParents = _cfgParents apply { [_x,["CfgMissionFramework","Logistics",_x,"liftTypes"] call MPSF_fnc_getCfgDataArray]; };
		_cfgParents = _cfgParents select { count (_x select 1) > 0};
		if (_resolve && count _cfgParents > 0) then {
			_cfgParents = (_cfgParents select 0) select 1;
		};
		_cfgParents;
	};
	case "getCfgLoadEnabled" : { ["CfgMissionFramework","Logistics","enableLoad"] call MPSF_fnc_getCfgDataBool; };
	case "getCfgLoadTypes" : {
		_params params [["_vehicle",objNull,[objNull]],["_resolve",true,[false]]];
		if (isNull _vehicle) exitWith { [] };
		private _cfgParents = [configFile >> "CfgVehicles" >> typeOf _vehicle,true] call BIS_fnc_returnParents;
		_cfgParents = _cfgParents apply { [_x,["CfgMissionFramework","Logistics",_x,"loadTypes"] call MPSF_fnc_getCfgDataArray]; };
		_cfgParents = _cfgParents select { count (_x select 1) > 0};
		if (_resolve && count _cfgParents > 0) then {
			_cfgParents = (_cfgParents select 0) select 1;
		};
		_cfgParents;
	};
// Init
	case "preInit" : {
		//
	};
	case "postInit" : {
		//
	};
};