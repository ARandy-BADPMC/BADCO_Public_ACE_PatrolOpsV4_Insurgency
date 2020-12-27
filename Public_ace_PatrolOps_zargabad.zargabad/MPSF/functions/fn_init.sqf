params [["_mode","",[""]]];

switch (_mode) do {
	case "preInit": {
		/* ***************************************************
		** Events											**
		*************************************************** */
	};
	case "postInit": {
		/* ***************************************************
		** NPC Conversation									**
		*************************************************** */
		["MPSF_Conversation_onStartConversation_EH","onStartConversation",{ ["onStartConversation",_this] call MPSF_fnc_conversation; }] call MPSF_fnc_addEventHandler;
		["MPSF_Conversation_onStartConversation_EH","onEndConversation",{ ["onEndConversation",_this] call MPSF_fnc_conversation; }] call MPSF_fnc_addEventHandler;
		/* ***************************************************
		** Tasks Manager									**
		*************************************************** */
		["init"] call MPSF_fnc_interaction;
		/* ***************************************************
		** Tasks Manager									**
		*************************************************** */
		if (isServer) then {
			private _scope2Tasks = (["CfgMissionTasks"] call BIS_fnc_getCfgSubClasses) select {(["CfgMissionTasks",_x,"scope"] call MPSF_fnc_getCfgDataNumber) isEqualTo 2};
			{
				["create",[_x]] call MPSF_fnc_taskmaster;
			} forEach (_scope2Tasks);
			// Task Abort Request
			["MPSF_Taskmanager_monitor_taskAbort_EH","onTaskRequestAbort",{
				params [["_taskID","",[""]],["_taskState","Canceled",[""]]];
				private _taskLogic = missionNamespace getVariable [_taskID,objNull];
				if !(isNull _taskLogic) then {
					_taskLogic setVariable ["abort",true];
					["onTaskValidate",[_taskID],2] call MPSF_fnc_triggerEventHandler;
				};
			}] call MPSF_fnc_addEventHandler;
			// Unit Killed
			["MPSF_Taskmanager_monitor_unitKilled_EH","onTaskUnitKilled",{
				params [["_unit",objNull,[objNull]],["_attributes",[],[[]]]];
				_attributes params [["_taskID","",[""]]];
				private _taskLogic = missionNamespace getVariable [_taskID,objNull];
				if !(isNull _taskLogic) then {
					_taskLogic setVariable ["targetskilled",({alive _x && canMove _x} count (_taskLogic getVariable ["targets",[]]) == 0)];
					_taskLogic setVariable ["unitskilled",({alive _x && canMove _x} count (_taskLogic getVariable ["units",[]]) == 0)];
					_taskLogic setVariable ["cachedestroyed",({damage _x == 0} count ((_taskLogic getVariable ["targets",[]]) select {typeOf _x IN (["WeaponCacheTypes"] call MPSF_fnc_getCfgTasks)}) == 0)];
					["onTaskValidate",[_taskID],2] call MPSF_fnc_triggerEventHandler;
				};
			}] call MPSF_fnc_addEventHandler;
			// Returned Vehicle
			["MPSF_Taskmanager_onVehicleReturned_EH","onVehicleReturned",{
				params [["_taskID","",[""]],["_vehicle",objNull,[objNull]],["_returnee",objNull,[objNull]]];
				private _taskLogic = missionNamespace getVariable [_taskID,objNull];
				if !(isNull _taskLogic) then {
					["onTaskValidate",[_taskID],2] call MPSF_fnc_triggerEventHandler;
				};
			}] call MPSF_fnc_addEventHandler;
			// Composition Target Objects Destroyed
			["MPSF_Taskmanager_monitor_objectDestroyed","onTaskObjectDestroyed",{
				params [["_object",objNull,[objNull]],["_attributes",[],[[]]]];
				_attributes params [["_taskID","",[""]]];
				private _taskLogic = missionNamespace getVariable [_taskID,objNull];
				if !(isNull _taskLogic) then {
					_taskLogic setVariable ["objectdestroyed",({alive _x && canMove _x} count (_taskLogic getVariable ["targetObjects",[]]) == 0)];
					["onTaskValidate",[_taskID],2] call MPSF_fnc_triggerEventHandler;
				};
			}] call MPSF_fnc_addEventHandler;
			// Intel Downloaded
			["MPSF_Taskmanager_monitor_intelDownloaded_EH","onIntelDownloadComplete",{
				params [["_object",objNull,[objNull]],["_target",objNull,[objNull]],["_attributes",[],[[]]]];
				_attributes params [["_taskID","",[""]]];
				private _taskLogic = missionNamespace getVariable [_taskID,objNull];
				if !(isNull _taskLogic) then {
					_taskLogic setVariable ["inteldownloaded",true];
					["onTaskValidate",[_taskID],2] call MPSF_fnc_triggerEventHandler;
				};
			}] call MPSF_fnc_addEventHandler;
			// Intel Picked Up
			["MPSF_Taskmanager_monitor_intelPickedUp_EH","onIntelPickup",{
				params [["_target",objNull,[objNull]],["_attributes",[],[[]]]];
				_attributes params [["_taskID","",[""]]];
				private _taskLogic = missionNamespace getVariable [_taskID,objNull];
				if !(isNull _taskLogic) then {
					_taskLogic setVariable ["intelpickedUp",true];
					["onTaskValidate",[_taskID],2] call MPSF_fnc_triggerEventHandler;
				};
			}] call MPSF_fnc_addEventHandler;
			// Intel Recieved
			["MPSF_Taskmanager_monitor_intelRecieved_EH","onIntelRecieve",{
				params [["_object",objNull,[objNull]],["_target",objNull,[objNull]],["_attributes",[],[[]]]];
				_attributes params [["_taskID","",[""]]];
				private _taskLogic = missionNamespace getVariable [_taskID,objNull];
				if !(isNull _taskLogic) then {
					_taskLogic setVariable ["intelRecieved",true];
					["onTaskValidate",[_taskID],2] call MPSF_fnc_triggerEventHandler;
				};
			}] call MPSF_fnc_addEventHandler;
			// Object Deployed
			["MPSF_Taskmanager_monitor_objectDeployed","onObjectDeployed",{
				params [["_object",objNull,[objNull]],["_previousObject","",[""]],["_caller",objNull,[objNull]],["_attributes",[],[[]]]];
				_attributes params [["_taskID","",[""]]];
				private _taskLogic = missionNamespace getVariable [_taskID,objNull];
				if !(isNull _taskLogic) then {
					["onTaskValidate",[_taskID],2] call MPSF_fnc_triggerEventHandler;
				};
			}] call MPSF_fnc_addEventHandler;
			// Trigger Task Check
			["MPSF_Taskmanager_monitor_validateTaskCondition_EH","onTaskValidate",{
				params [["_taskID","",[""]]];
				["processTask",[_taskID]] spawn {sleep (1 + random 1); _this call MPSF_fnc_taskmaster};
			}] call MPSF_fnc_addEventHandler;
			// Child Task Complete
			["MPSF_Taskmanager_monitor_onChildTaskComplete_EH","onTaskComplete",{
				// TODO Event Handler
			}] call MPSF_fnc_addEventHandler;
		};
		if !(isServer || hasInterface) then { // Headless Client
			["MPSF_Taskmanager_HLC_onSpawnCommand_EH","onSpawnCommand",{
				params ["_taskID","_cfgTaskID","_position","_positionOffset"];
				private _taskLogic = missionNamespace getVariable [_taskID,objNull];
				if !(isNull _taskLogic) then {
					["createTaskGroups",[_taskLogic,_cfgTaskID]] call MPSF_fnc_taskmaster;
				};
			}] call MPSF_fnc_addEventHandler;
		};
		if (hasInterface) then {
			["MPSF_Taskmanager_onGetIn_EH","onGetIn",{
				params [["_unit",objNull,[objNull]],["_position","",[""]],["_vehicle",objNull,[objNull]],["_turret",[],[[]]]];
				if !((_vehicle getVariable ["returnpoint_taskID",""]) isEqualTo "") then {
					["loadReturnPointUI",[_vehicle]] call MPSF_fnc_taskmaster;
				};
			}] call MPSF_fnc_addEventHandler;
		};
	};
};