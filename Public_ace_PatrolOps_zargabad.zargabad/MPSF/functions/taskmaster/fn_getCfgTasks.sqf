/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getCfgTasks.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Returns the configuration of the task system or specific task

	Parameter(s):
		0: STRING - Data Type requested
		1: ARRAY - Data Arrtibutes like Task ID
		2: BOOL - Resolve the outcome to provide single result

	Returns:
		Anything - Variable based on the datatype

	Example:
		["3dIcons",[],false] call MPSF_fnc_getCfgTasks // Returns True/False
*/
params [["_dataType","",[""]],["_params",[],[[]]],["_resolve",false,[false]]];

switch (_dataType) do {
// Difficulty
	case "3dIcons" : { ["CfgTaskEnhancements","3d"] call MPSF_fnc_getCfgDataBool; };
	case "enableTaskHints" : { ["CfgMissionTasks","enableTaskHints"] call MPSF_fnc_getCfgDataBool; };
// Task Objects
	case "intelDropTypes";
	case "intelDownloadTypes";
	case "TowerTypes";
	case "WeaponCacheTypes";
	case "SupplyTypes" : { ["CfgMissionFramework",_dataType] call MPSF_fnc_getCfgDataArray; };
// Tasks
	case "taskIDs" : { (["CfgMissionTasks"] call BIS_fnc_getCfgSubClasses) select {["CfgMissionTasks",_x,"scope"] call MPSF_fnc_getCfgDataBool}; };
	case "taskTypes" : { ["CfgTaskTypes"] call BIS_fnc_getCfgSubClasses select {count (["taskTypeIDs",[_x]] call MPSF_fnc_getCfgTasks) > 0}; };
	case "taskTypeIDs" : { _params params [["_taskType","",[""]]]; ["CfgTaskTypes",_taskType,"taskIDs"] call MPSF_fnc_getCfgDataArray; };
	case "getTasksByScope" : {
		_params apply {if (_x isEqualType 0) then {_x} else {-10}};
		(["taskIDs"] call MPSF_fnc_getCfgTasks) select {(["CfgMissionTasks",_x,"scope"] call MPSF_fnc_getCfgDataNumber) in (_params select {_x > 0})};
	};
	case "getTasksByType" : {
		_params apply {if (_x isEqualType "") then {_x} else {"_ERROR_"}};
		(["taskIDs"] call MPSF_fnc_getCfgTasks) select {(["CfgMissionTasks",_x,"TaskDetails","type"] call MPSF_fnc_getCfgDataText) in _params};
	};
	case "getTasksByID" : {
		private _paramsText = [];
		_params = _params apply { if (_x isEqualType "") then { _paramsText append (["taskTypeIDs",[_x]] call MPSF_fnc_getCfgTasks); -1 } else { _x }; };
		_params append _paramsText;
		(["taskIDs"] call MPSF_fnc_getCfgTasks) select {(["CfgMissionTasks",_x,"typeID"] call MPSF_fnc_getCfgDataNumber) in (_params select {_x > 0})};
	};
	case "getTaskAreaType" : {
		["positionSearchTypes",_params] call MPSF_fnc_getCfgTasks;
	};
// Task Configuration
	case "isParent" : {
		_params params [["_taskID","",[""]]];
		isClass (["CfgMissionTasks",_cfgTaskID,"ChildTasks"] call BIS_fnc_getCfg);
	};
	case "hasMarkers" : {
		_params params [["_taskID","",[""]]];
		count (["CfgMissionTasks",_taskID,"Markers"] call BIS_fnc_getCfgSubClasses) > 0;
	};
	case "hasCompositions" : {
		_params params [["_taskID","",[""]]];
		count (["CfgMissionTasks",_taskID,"Compositions"] call BIS_fnc_getCfgSubClasses) > 0;
	};
	case "hasGroups" : {
		_params params [["_taskID","",[""]]];
		count (["CfgMissionTasks",_taskID,"Groups"] call BIS_fnc_getCfgSubClasses) > 0;
	};
	case "hasDeployableObjects" : {
		_params params [["_taskID","",[""]]];
		count (["CfgMissionTasks",_taskID,"DeployableObjects"] call BIS_fnc_getCfgSubClasses) > 0;
	};
	case "hasSimpleTask" : {
		_params params [["_taskID","",[""]]];
		isClass (["CfgMissionTasks",_taskID,"TaskDetails"] call BIS_fnc_getCfg);
	};
	case "position";
	case "positionOffset" : {
		_params params [["_taskID","",[""]]];
		private _return = ["CfgMissionTasks",_taskID,_dataType] call MPSF_fnc_getCfgData;
		if (isNil "_return") exitWith { [0,0,0] };
		_return;
	};
	case "scope";
	case "typeID";
	case "playerTaskLives";
	case "positionSearchRadius" : {
		_params params [["_taskID","",[""]]];
		["CfgMissionTasks",_taskID,_dataType] call MPSF_fnc_getCfgDataNumber;
	};
	case "areaSize";
	case "positionSearchTypes" : {
		_params params [["_taskID","",[""]]];
		["CfgMissionTasks",_taskID,_dataType] call MPSF_fnc_getCfgDataArray;
	};
	case "clearTownSectors";
	case "clearAreaSectors";
	case "preventPlayerRespawn";
	case "positionIsWater";
	case "positionNearRoad";
	case "positionNearLast" : {
		_params params [["_taskID","",[""]]];
		["CfgMissionTasks",_taskID,_dataType] call MPSF_fnc_getCfgDataBool;
	};
	case "function";
	case "worldName" : {
		_params params [["_taskID","",[""]]];
		["CfgMissionTasks",_taskID,_dataType] call MPSF_fnc_getCfgDataText;
	};
	case "checkTaskAreas" : {
		_params params [["_taskID","",[""]]];

		private _position = ["position",[_taskID]] call MPSF_fnc_getCfgTasks;
		private _positionOffset = ["positionOffset",[_taskID]] call MPSF_fnc_getCfgTasks;
		if !(_position isEqualTo [0,0,0] && _positionOffset isEqualTo [0,0,0]) exitWith { true };

		private _positionSearchTypes = ["positionSearchTypes",[_taskID]] call MPSF_fnc_getCfgTasks;
		private _mapSectors = (["sectors"] call MPSF_fnc_getCfgMapData) select {(["hasSectorAreaType",[_x,_positionSearchTypes]] call MPSF_fnc_getCfgMapData)};
		count _mapSectors > 0;
	};
// Task Configuration: Compositions
	case "Compositions" : {
		_params params [["_taskID","",[""]]];
		private _compIDs = ["CfgMissionTasks",_taskID,_dataType] call BIS_fnc_getCfgSubClasses;
		private _compositions = [];
		{
			private _compID = _x;
			private _composition = [format["%1_%2",_taskID,_compID]];
			_composition resize 11;
			{
				_composition set [_forEachIndex + 1,(["CfgMissionTasks",_taskID,_dataType,_compID,_x] call MPSF_fnc_getCfgData)];
			} forEach [
				"typeIDs"
				,"position"
				,"distance"
				,"direction"
				,"radius"
				,"angle"
				,"faction"
				,"groupTypes"
				,"targets"
			];
			_composition set [10,(["CfgMissionTasks",_taskID,_dataType,_compID,"downloadIntel"] call MPSF_fnc_getCfgDataBool)];
			_compositions pushBack _composition;
		} forEach _compIDs;
		_compositions;
	};
// Task Configuration: Markers
	case "Markers" : {
		_params params [["_taskID","",[""]]];
		private _markerIDs = ["CfgMissionTasks",_taskID,_dataType] call BIS_fnc_getCfgSubClasses;
		private _markerData = [];
		{
			private _markerID = _x;
			private _marker = [format["%1_%2",_taskID,_markerID]];
			_marker resize 12;
			{
				_marker set [_forEachIndex + 1,(["CfgMissionTasks",_taskID,_dataType,_markerID,_x] call MPSF_fnc_getCfgData)];
			} forEach [
				"position"
				,"shape"
				,"type"
				,"brush"
				,"colour"
				,"angle"
				,"size"
				,"distance"
				,"direction"
				,"text"
				,"alpha"
			];
			_markerData pushBack _marker;
		} forEach _markerIDs;
		_markerData;
	};
// Deployables
	case "DeployableObjects" : {
		_params params [["_taskID","",[""]]];
		private _objectIDs = ["CfgMissionTasks",_taskID,_dataType] call BIS_fnc_getCfgSubClasses;
		private _objectData = [];
		{
			private _objectID = _x;
			private _object = [format["%1_%2",_taskID,_objectID]];
			_object resize 12;
			{
				_object set [_forEachIndex + 1,(["CfgMissionTasks",_taskID,_dataType,_objectID,_x] call MPSF_fnc_getCfgData)];
			} forEach [
				"position"
				,"angle"
				,"containerClass"
				,"deployClass"
			];
			{
				_object set [_forEachIndex + 5,(["CfgMissionTasks",_taskID,_dataType,_objectID,"Destination",_x] call MPSF_fnc_getCfgData)];
			} forEach [
				"position"
				,"radius"
			];
			_objectData pushBack _object;
		} forEach _objectIDs;
		_objectData;
	};
// Task Configuration: Groups
	case "Groups" : {
		_params params [["_taskID","",[""]]];
		private _groupIDs = ["CfgMissionTasks",_taskID,_dataType] call BIS_fnc_getCfgSubClasses;
		private _groupArray = [];
		{
			private _groupID = _x;
			private _groupData = [format["%1_%2",_taskID,_groupID]];
			_groupData resize 24;
			private _taskData = ["vehicleTypes","groupTypes","objectTypes","createCrew","faction","position","distance","direction","radius","angle","minPlayers","conversations"];
			for "_i" from 0 to 11 do {
				_groupData set [_i + 1,["CfgMissionTasks",_taskID,_dataType,_groupID,_taskData select _i] call MPSF_fnc_getCfgData];
			};
			private _taskDataBool = ["probability","createCrew","isPatrolling","isDefending","isAttacking","occupyBuildings","isTarget","dropIntel","detonate","captive","isCrowd","patrolAirspace"];
			for "_i" from 0 to 11 do {
				_groupData set [_i + 13,["CfgMissionTasks",_taskID,_dataType,_groupID,_taskDataBool select _i] call MPSF_fnc_getCfgDataBool];
			};
			_groupArray pushBack +_groupData;
		} forEach _groupIDs;
		_groupArray;
	};
// Simple Task Details
	case "taskParent" : {
		_params params [["_taskID","",[""]]];
		["TaskDetails",[_taskID,"parent"],_resolve] call MPSF_fnc_getCfgTasks;
	};
	case "taskType" : {
		_params params [["_taskID","",[""]]];
		["TaskDetails",[_taskID,"iconType"],_resolve] call MPSF_fnc_getCfgTasks;
	};
	case "TaskDetails" : {
		_params params [["_taskID","",[""]],["_attribute","",[""]]];
		switch (_attribute) do {
			case "priority" : { ["CfgMissionTasks",_taskID,_dataType,_attribute] call MPSF_fnc_getCfgData; };
			case "chevronTitle";
			case "iconType";
			case "title";
			case "brief";
			case "parent" : { ["CfgMissionTasks",_taskID,_dataType,_attribute] call MPSF_fnc_getCfgDataText; };
			case "hideUntilComplete" : { ["CfgMissionTasks",_taskID,_dataType,_attribute] call MPSF_fnc_getCfgDataBool; };
			case "textArguments" : { ["CfgMissionTasks",_taskID,_dataType,_attribute] call MPSF_fnc_getCfgDataArray; };
			case "state" : {
				private _return = ["CfgMissionTasks",_taskID,_dataType,_attribute] call MPSF_fnc_getCfgData;
				if (isNil "_return") exitWith { "Created" };
				_return;
			};
			case "target" : {
				private _return = ["CfgMissionTasks",_taskID,_dataType,_attribute] call MPSF_fnc_getCfgData;
				if (isNil "_return") exitWith { true };
				switch (typeName _return) do {
					case (typeName "") : { _return = call compile _return; };
					case (typeName 0) : { _return = [_return] call BIS_fnc_sideType};
				};
				_return;
			};
			case "iconPosition";
			case "position" : {
				private _return = ["CfgMissionTasks",_taskID,_dataType,_attribute] call MPSF_fnc_getCfgData;
				if (isNil "_return") exitWith { [0,0,0] };
				_return;
			};
			case "description" : {
				private _description = ["CfgMissionTasks",_taskID,_dataType,_attribute] call MPSF_fnc_getCfgData;
				if (isNil "_description") exitWith { "" };
				if (typeName _description isEqualTo typeName []) then {
					private _text = "";
					{
						_text = _text + format["%1%2",if (_forEachIndex == 0) then {""} else {"<br/><br/>"},_x];
					} forEach _description;
					_description = _text;
				};
				_description
			};
			default {
				[
					["TaskDetails",[_taskID,"parent"],_resolve] call MPSF_fnc_getCfgTasks
					,["TaskDetails",[_taskID,"target"],_resolve] call MPSF_fnc_getCfgTasks
					,["TaskDetails",[_taskID,"title"],_resolve] call MPSF_fnc_getCfgTasks
					,["TaskDetails",[_taskID,"description"],_resolve] call MPSF_fnc_getCfgTasks
					,["TaskDetails",[_taskID,"iconType"],_resolve] call MPSF_fnc_getCfgTasks
					,["TaskDetails",[_taskID,"position"],_resolve] call MPSF_fnc_getCfgTasks
					,["TaskDetails",[_taskID,"chevronTitle"],_resolve] call MPSF_fnc_getCfgTasks
					,["TaskDetails",[_taskID,"textArguments"],_resolve] call MPSF_fnc_getCfgTasks
					,["TaskDetails",[_taskID,"state"],_resolve] call MPSF_fnc_getCfgTasks
					,["TaskDetails",[_taskID,"priority"],_resolve] call MPSF_fnc_getCfgTasks
				]
			};
		};
	};
	case "getTaskTypeList" : {
		private _taskTypes = [];
		{
			private _taskCfg = ["CfgTaskTypes",_x] call BIS_fnc_getCfg;
			if (([_taskCfg,"scope"] call MPSF_fnc_getCfgDataNumber) == 2) then {
				_taskTypes pushBack [
					_x
					,[_taskCfg,"displayName"] call MPSF_fnc_getCfgDataText
					,[_taskCfg,"icon"] call MPSF_fnc_getCfgDataText
				];
			};
		} forEach (["CfgTaskTypes"] call BIS_fnc_getCfgSubClasses);
		_taskTypes;
	};
// Task Data
	case "childTasks" : {
		_params params [["_taskID","",[""]],["_resolve",false,[false]]];
		private _childTaskIDs = ["CfgMissionTasks",_taskID,"ChildTasks"] call BIS_fnc_getCfgSubClasses;

		if (_resolve) then {
			_childTaskIDs = _childTaskIDs apply { ["getChildTaskData",[_x]] call MPSF_fnc_getCfgTasks; };
		};

		_childTaskIDs select {["CfgMissionTasks",_x,"scope"] call MPSF_fnc_getCfgDataBool};
	};
	case "getChildTaskData" : {
		_params params [["_taskID","",[""]],["_resolve",false,[false]]];
		private _dependants = [];
		/*{ _dependants pushBack [_x,""]; } forEach ["CfgMissionTasks",_taskID] call MPSF_fnc_getCfgDataArray; getArray(_x >> "completed");
		{ _dependants pushBack [_x,"Succeeded"]; } forEach getArray(_x >> "succeeded");
		{ _dependants pushBack [_x,"Failed"]; } forEach getArray(_x >> "failed");
		{ _dependants pushBack [_x,"Canceled"]; } forEach getArray(_x >> "canceled");
		_childTasks pushBack [configName _x,_dependants];*/
		_dependants;
	};
// Objective
	case "objectiveCondition" : {
		_params params [["_taskID","",[""]],["_condition","",[""]]];
		private _condition = ["CfgMissionTasks",_taskID,"Objective",_condition,"condition"] call MPSF_fnc_getCfgData;
		if (isNil "_condition") exitWith { "False"; };
		if (typeName _condition isEqualTo typeName []) then { _condition = _condition joinString " && "; };
		if (_condition isEqualTo "") exitWith { "false" };
		_condition;
	};
	case "objectiveNextTask" : {
		_params params [["_taskID","",[""]],["_condition","",[""]]];
		["CfgMissionTasks",_taskID,"Objective",_condition,"nextTask"] call MPSF_fnc_getCfgDataArray;
	};
	case "objectiveNextTasks" : {
		_params params [["_taskID","",[""]],["_condition","",[""]]];
		["CfgMissionTasks",_taskID,"Objective",_condition,"nextTasks"] call MPSF_fnc_getCfgDataArray;
	};
	case "objectiveFunction" : {
		_params params [["_taskID","",[""]],["_condition","",[""]]];
		["CfgMissionTasks",_taskID,"Objective",_condition,"function"] call MPSF_fnc_getCfgDataText;
	};
	case "nearbyReturnPoint";
	case "disableRespawn" : {
		_params params [["_taskID","",[""]]];
		["CfgMissionTasks",_taskID,"Objective",_dataType] call MPSF_fnc_getCfgDataBool;
	};
	case "objectiveAttribute" : {
		_params params [["_taskID","",[""]],["_condition","",[""]]];
		private _condition = ["objectiveCondition",_params] call MPSF_fnc_getCfgTasks;
		private _attributes = ["CfgMissionTasks",_taskID,"Objective",_condition,"condition"] call MPSF_fnc_getCfgDataArray;
		{
			_attributes pushBackUnique toLower _x;
		} forEach (_condition splitString "(){}&|-,._ ");
		_attributes apply {toLower _x};
	};
	case "objectiveAttributes" : {
		_params params [["_taskID","",[""]]];
		private _attributes = [];
		private _return = [];
		{ _attributes append (["objectiveAttribute",[_taskID,_x]] call MPSF_fnc_getCfgTasks); } forEach ["Succeeded","Failed","Canceled"];
		{_return pushBackUnique _x} forEach _attributes;
		_return;
	};
	case "Objectives" : {
		_params params [["_taskID","",[""]]];
		private _outcomes = [];
		private _conditions = [];
		{
			private _objective = _x;
			private _cfg = ["CfgMissionTasks",_taskID,"Objective",_objective] call BIS_fnc_getCfg;
			if (isClass(_cfg)) then {
				private _taskState = ["Succeeded","Failed","Canceled"] select ((1 max (["CfgMissionTasks",_taskID,"Objective",_objective,"state"] call MPSF_fnc_getCfgDataNumber) min 3) - 1);
				private _condition = ["CfgMissionTasks",_taskID,"Objective",_objective,"condition"] call MPSF_fnc_getCfgDataText;
				private _nextTask = ["CfgMissionTasks",_taskID,"Objective",_objective,"condition"] call MPSF_fnc_getCfgDataArray;
				private _nextTasks = ["CfgMissionTasks",_taskID,"Objective",_objective,"condition"] call MPSF_fnc_getCfgDataArray;
				private _function = ["CfgMissionTasks",_taskID,"Objective",_objective,"condition"] call MPSF_fnc_getCfgDataText;
				private _endMission = ["CfgMissionTasks",_taskID,"Objective",_objective,"condition"] call MPSF_fnc_getCfgDataBool;

				_nextTask = _nextTask select { ["checkTaskAreas",[_x]] call MPSF_fnc_getCfgTasks; };
				_nextTasks = _nextTasks select { ["checkTaskAreas",[_x]] call MPSF_fnc_getCfgTasks; };

				_outcomes pushBack [_taskState,_condition,_nextTask,_nextTasks,_function,_endMission];
				{
					_conditions pushBackUnique toLower _x;
				} forEach (((_cfg >> "condition") call MPSF_fnc_getCfgDataText) splitString "(){}&|-,._ ");
				{_conditions pushBackUnique toLower _x} forEach (["CfgMissionTasks",_taskID,"Objective",_objective,"condition"] call MPSF_fnc_getCfgDataArray);
			};
		} forEach ["Succeeded","Failed","Canceled"];

		[_outcomes,_conditions]
	};
	case "Objective" : {
		_params params [["_taskID","",[""]],["_attribute","",[""]]];
		switch (_attribute) do {
			case "Succeeded";
			case "Failed";
			case "Canceled" : {
				private _condition = ["CfgMissionTasks",_taskID,_dataType,_attribute,"condition"] call MPSF_fnc_getCfgDataText;
				private _nextTask = ["CfgMissionTasks",_taskID,_dataType,_attribute,"nextTask"] call MPSF_fnc_getCfgDataArray;
				private _nextTasks = ["CfgMissionTasks",_taskID,_dataType,_attribute,"nextTasks"] call MPSF_fnc_getCfgDataArray;
				private _function = ["CfgMissionTasks",_taskID,_dataType,_attribute,"function"] call MPSF_fnc_getCfgDataText;
				[_attribute,_condition,_nextTask,_nextTasks,_function];
			};
			case "Outcomes" : {
				private _objectives = ["CfgMissionTasks",_taskID,_dataType] call BIS_fnc_getCfgSubClasses;
				private _outcomes = [];
				{
					_outcomes pushBack (["Objective",[_taskID,_x],_resolve] call MPSF_fnc_getCfgTasks);
				} forEach _objectives;
				_outcomes
			};
			case "Conditions" : {
				private _objectives = ["CfgMissionTasks",_taskID,_dataType] call BIS_fnc_getCfgSubClasses;
				private _conditions = [];
				{
					private _outcome =  ["Objective",[_taskID,_x],_resolve] call MPSF_fnc_getCfgTasks;
					{ _conditions pushBackUnique toLower _x; } forEach ((_outcome select 0) splitString "(){}&|-,._ ");
				} forEach _objectives;
				_conditions
			};
		};
	};
};