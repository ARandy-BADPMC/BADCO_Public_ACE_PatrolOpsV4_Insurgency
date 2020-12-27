/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_civilianPopulation.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Creates cilivilian areas that are triggered when players are nearby

	Parameter(s):
		0: Object - Description

	Returns:
		Bool - True when done
*/
params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "buildAreas" : {
		private _areas = ["getNearbyAreas",[[worldSize/2,worldSize/2,0],["Town","Village","City","Farm"],worldSize]] call MPSF_fnc_getCfgMapData;
		{
			["createArea",[_x]] call MPSF_fnc_civilianPopulation;
		} forEach _areas;
	};
	case "createArea" : {
		if (isServer) then {
			_params params [["_areaID","",[""]]];

			if (_areaID isEqualTo "") exitWith {};

			private _areaLogic = missionNamespace getVariable [_areaID,objNull];
			if (isNull _areaLogic) then {
				private _areaPos = ["getAreaPosition",[_areaID]] call MPSF_fnc_getCfgMapData;
				_areaLogic = [_areaPos] call MPSF_fnc_createLogic;
				_areaLogic setVariable ["MPSF_Module_Area_F",true,true];
				_areaLogic setVehicleVarName _areaID;
				missionNamespace setVariable [_areaID,_areaLogic];
				publicVariable _areaID;
			};

			private _areaType = ["getAreaType",[_areaID]] call MPSF_fnc_getCfgMapData;

			private _checkRadius = 400;
			private _trigger = createTrigger ["EmptyDetector",_areaLogic,false];
			_trigger setTriggerArea [_checkRadius,_checkRadius,getDir _areaLogic,false,50];
			_trigger setTriggerActivation ["ANYPLAYER","PRESENT",true];
			_trigger setTriggerStatements ["this"
				,format["['activateArea',[thisTrigger,%1]] call MPSF_fnc_civilianPopulation;",str _areaType]
				,format["['deactivateArea',[thisTrigger]] call MPSF_fnc_civilianPopulation;"]
			];
			_trigger attachTo [_areaLogic,[0,0,0]];
			_areaLogic setVariable ["VirtualDepot_Trigger",_trigger];
		};
	};
	case "activateArea" : {
		_params params [["_trigger",objNull],["_areaType","",[""]]];

		private _areaLogic = attachedTo _trigger;
		if (isNull _areaLogic) exitWith { /*["Unable to retrieve area logic attached to trigger"] call BIS_fnc_error;*/ };

		if (toLower _areaType in ["city","town","village","house"]) then {
			// Create Groups
			if ([] call MPSF_fnc_isHeadlessClientPresent) then {
				["onSpawnCivCommand",[_areaLogic,str _areaLogic],[] call MPSF_fnc_getHeadlessClient] call MPSF_fnc_triggerEventHandler;
			} else {
				["createCivPopulation",[_areaLogic,str _areaLogic]] call MPSF_fnc_civilianPopulation;
			};
		};
	};
	case "deactivateArea" : {
		_params params [["_trigger",objNull]];
		private _areaLogic = attachedTo _trigger;

		if (isNull _areaLogic) exitWith { /*["Unable to retrieve area logic attached to trigger"] call BIS_fnc_error;*/ };

		{ deleteVehicle _x; } forEach (_areaLogic getVariable ["MPSF_CivPop_var_groupID",[]]);
	};
	case "createCivPopulation" : {
		_params params [["_civLogic",objNull,[objNull,""]],["_areaID","",[""]]];

		if (typeName _civLogic isEqualTo typeName "") then { _civLogic = missionNamespace getVariable [_civLogic,objNull]; };
		if (isNull _civLogic) exitWith { /*["Unable to get civilian logic"] call BIS_fnc_error;*/ };

		private _areaBuildingCount = ["getAreaBuildingCount",[_areaID]] call MPSF_fnc_getCfgMapData;
		private _groupTypes = switch (true) do {
			case (_areaBuildingCount < 16) : { ["Crowd4"] };
			case (_areaBuildingCount < 24) : { ["Crowd6"] };
			case (_areaBuildingCount < 48) : { ["Crowd12"] };
			default { ["Crowd24"] };
		};

		if (count _groupTypes == 0) exitWith { /*["Unable to get civilian group types"] call BIS_fnc_error;*/ };

		private _areaPos = ["getAreaPosition",[_areaID]] call MPSF_fnc_getCfgMapData;
		private _groupData = [_areaPos,"FactionTypeCIV",(selectRandom _groupTypes)] call MPSF_fnc_createAgentGroup;

		if (count _groupData > 0) then {
			private _areaSize = ["getAreaOrientation",[_areaID]] call MPSF_fnc_getCfgMapData;
			_areaSize params ["_sizeX","_sizeY","_rotation"];
			["createCrowd",[_groupData,_areaPos,_sizeX max _sizeY]] call MPSF_fnc_simulCiv;
			{
				if (selectRandom [false,true]) then {
					[_x,"nearbyEncounters"] call (missionNamespace getVariable ["MPSF_fnc_addConversation",{}]);
				};
			} forEach _groupData;
			_civLogic setVariable ["MPSF_CivPop_var_groupID",_groupData,true];
		};
	};
	case "init";
	case "postInit" : {
		if (isServer) then {
			["buildAreas"] spawn {sleep 1; _this call MPSF_fnc_civilianPopulation};
		};
		if !(isServer || hasInterface) then { // Headless Client
			["MPSF_CivlianPopulation_HLC_onSpawnCommand_EH","onSpawnCivCommand",{
				params [["_areaLogic",objNull,[objNull]],["_areaID","",[""]]];
				if !(isNull _areaLogic) then {
					["createCivPopulation",[_areaLogic,_areaID]] call MPSF_fnc_civilianPopulation;
				};
			}] call MPSF_fnc_addEventHandler;
		};
		if (hasInterface) then {
			//
		};
	};
};