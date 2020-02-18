/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_taskmaster.sqf
	Author(s): Roy86

	Description:
		The Mission Task Framework
*/
#define MISSIONTIME			(if (isMultiplayer) then {serverTime} else {time})

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "create" : {
		_params call MPSF_fnc_createCfgTask;
	};
	case "createParentTask" : {
		_params call MPSF_fnc_createCfgTask;
	};
	case "createChildTask" : {
		_params call MPSF_fnc_createCfgTask;
	};
	case "removeTask" : {
		_params call MPSF_fnc_removeCfgTask;
	};
// Common Functions
	case "createTaskLogic" : {
		_params call MPSF_fnc_createCfgTaskLogic;
	};
	case "createTaskID" : {
		_params call MPSF_Fnc_getCfgTaskID;
	};
	case "createTaskPosition" : {
		_params call MPSF_fnc_getCfgTaskPosition;
	};
	case "createTaskMarkers" : {
		_params call MPSF_fnc_createCfgTaskMarkers;
	};
	case "createTaskCompositions" : {
		_params call MPSF_fnc_createCfgTaskCompositions;
	};
	case "createTaskReturnPoint" : {
		_params call MPSF_fnc_createCfgTaskReturnPoint;
	};
	case "createTaskGroups" : {
		_params call MPSF_fnc_createCfgTaskGroups;
	};
	case "createTaskDeployable" : {
		_params call MPSF_fnc_createCfgTaskDeployable;
	};
	case "createTaskObjectiveLives" : {
		private _taskLives = ["playerTaskLives",_cfgTaskID] call MPSF_fnc_getConfigTask;
		if (_taskLives > 0) then {
			missionNamespace setVariable [format[_taskVar,_taskID,"lives"],_taskLives];
			publicVariable format[_taskVar,_taskID,"lives"];
		};
	};
	case "createTaskNotification" : {
		_params call MPSF_fnc_createCfgTaskObjective;
	};
// Event Handlers
	case "addUnitKilledEH" : {
		_params call MPSF_fnc_onKilledCfgTasks_EH;
	};
	case "addObjectDamageEH" : {
		_params call MPSF_fnc_onDamagedCfgTasks_EH;
	};
	case "addObjectDamageEH_C4only" : {
		_params call MPSF_fnc_onDamagedCfgTasks_C4Only_EH;
	};
	case "endMissionOCAP" : {
		//https://forums.bistudio.com/forums/topic/194164-ocap-operation-capture-and-playback-aar-system/
		if (isServer) then {
			["MPSF_Taskmanager_OCAPend_onEachFrame_EH","onEachFrame",{
				if (count (allPlayers - entities "HeadlessClient_F") == 0) then {
					["MPSF_Taskmanager_OCAPend_onEachFrame_EH","onEachFrame"] call MPSF_fnc_removeEventHandler;
					[] call (missionNamespace getVariable ["ocap_fnc_exportData",{}]);
				};
			}] call MPSF_fnc_addEventHandler;
		};
	};
// Return Point
	case "onLoadReturnPointUI" : {
		private _dialog = _params select 0;
		uiNamespace setVariable ["RscTitleReturn_dialog",(_dialog)];

		{
			uiNamespace setVariable [(_x select 0),_dialog displayCtrl (_x select 1)];
		} forEach [
			["RscTitleInjury_IDC_Ctrl",1000]
			,["RscTitleInjury_IDC_Line1",1001]
			,["RscTitleInjury_IDC_Line2",1002]
		];

		["MPSF_ReturnPointUI_onEachFrame_EH","onEachFrame",{
			private _vehicle = uiNamespace getVariable ["currentVehicle",objNull];

			if (isNull _vehicle) exitWith {
				["unLoadReturnPointUI"] call MPSF_fnc_taskmaster;
				["MPSF_ReturnPointUI_onEachFrame_EH","onEachFrame"] call MPSF_fnc_removeEventHandler;
			};

			if !(vehicle player isEqualTo _vehicle) exitWith {
				["unLoadReturnPointUI"] call MPSF_fnc_taskmaster;
				["MPSF_ReturnPointUI_onEachFrame_EH","onEachFrame"] call MPSF_fnc_removeEventHandler;
			};

			private _distance = (_vehicle distance getMarkerPos ([position _vehicle,player] call MPSF_fnc_getNearestReturnPoint));
			if (_distance <= 30) then {
				private _taskID = _vehicle getVariable ["returnpoint_taskID",""];
				["MPSF_ReturnPointUI_onEachFrame_EH","onEachFrame"] call MPSF_fnc_removeEventHandler;
				["unLoadReturnPointUI"] call MPSF_fnc_taskmaster;
				if (driver _vehicle isEqualTo player) then {
					["onVehicleReturned",[_taskID,_vehicle,player],2] call MPSF_fnc_triggerEventHandler;
				};
			};

			private _distString = "<t size='0.8' shadow='0'>%1:</t> <t size='1.2' shadow='0'>%2</t> <t size='0.8'>%3</t>";
			private _distStringVal = if (_distance < 1000) then { format ["%1m",floor _distance]; } else { format ["%1km",floor (_distance/1000)]; };
			private _ctrlText = uiNamespace getVariable ["RscTitleInjury_IDC_Line2",controlNull];
			_ctrlText ctrlSetStructuredText parseText format [_distString,"Distance",_distStringVal,"to nearest return point"];
		}] call MPSF_fnc_addEventHandler;
	};
	case "loadReturnPointUI" : {
		_params params [["_vehicle",objNull,[objNull]]];
		if (isNull _vehicle) exitWith {};
		uiNamespace setVariable ["currentVehicle",_vehicle];
		("ReturnPointUI" call BIS_fnc_rscLayer) cutRsc ["RscTitleMPSFReturnPointDistance","PLAIN",0,false];
	};
	case "unLoadReturnPointUI" : {
		uiNamespace setVariable ["currentVehicle",nil];
		("ReturnPointUI" call BIS_fnc_rscLayer) cutText ["","PLAIN"];
	};
// Task Process Monitor
	case "addTaskMonitor" : {
		_params call MPSF_fnc_addCfgTaskMonitor;
	};
	case "removeTaskMonitor" : {
		_params call MPSF_fnc_removeCfgTaskMonitor;
	};
	case "processTaskArguments" : {
		_params call MPSF_fnc_processCfgTaskArguments;
	};
	case "processTask" : {
		_params call MPSF_fnc_processCfgTask;
	};
// Functions
	case "getTaskModules" : {
		_params call MPSF_fnc_getCfgTaskModules;
	};
	case "getTaskActive" : {
		_params params [["_cfgTaskID","",[""]]];
		 ["getTaskModules",[_cfgTaskID,true]] call MPSF_fnc_taskmaster;
	};
	case "isTaskActive" : {
		_params params [["_cfgTaskID","",[""]]];
		count (["getTaskModules",[_cfgTaskID,true]] call MPSF_fnc_taskmaster) > 0;
	};
};