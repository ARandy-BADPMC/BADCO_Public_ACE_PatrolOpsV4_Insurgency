params [["_cfgTaskID","",[""]],["_position","",[[],""]],["_parentID","",[""]]];

if (_cfgTaskID isEqualTo "") exitWith {};

if (["isParent",[_cfgTaskID]] call MPSF_fnc_getCfgTasks) then {
	// Create Unique Task ID
	private _taskID = ["createTaskID",[_cfgTaskID]] call MPSF_fnc_taskmaster;
	// Create Task Manager Logic
	private _taskLogic = ["createTaskLogic",[[0,0,0],_taskID]] call MPSF_fnc_taskmaster;
	_taskLogic setVariable ["taskID",_taskID,true];
	// Crate Task Position
	private _positionData = ["createTaskPosition",[_cfgTaskID,_taskID]] call MPSF_fnc_taskmaster;
	_positionData params [["_position",[0,0,0],[[]]],["_positionOffset",[0,0,0],[[]]],["_areaID",[0,0,0],[[],""]]];
	_taskLogic setVariable ["position",_position,true];
	_taskLogic setVariable ["positionOffset",_positionOffset,true];
	_taskLogic setVariable ["area",_areaID,true];
	_taskLogic setPos _positionOffset;

	// Create Markers
	["createTaskMarkers",[_taskID,_cfgTaskID]] call MPSF_fnc_taskmaster;
	// Create Compositions
	["createTaskCompositions",[_taskID,_cfgTaskID]] call MPSF_fnc_taskmaster;
	// Create Parent Task
	["createTaskNotification",[_taskID,_cfgTaskID/*,_parentID*/]] call MPSF_fnc_taskmaster;
	// Fire onTaskCreate Event Handler
	["onTaskCreate",[_taskID,_cfgTaskID],0] call MPSF_fnc_triggerEventHandler;

	//format ["Parent Task Created: %1",_taskID] call BIS_fnc_logFormat;

	// Create Children Tasks
	private _childTasks = ["childTasks",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;
	//format ["ChildTasks %1: %2",_cfgTaskID,_childTasks] call BIS_fnc_logFormat;
	if (count _childTasks > 0) then {
		/*private _childTaskIDs = [];
		{
			_x params ["_childID","_dependantTasks"];
			private _childTaskID = format["%1_%2",_taskID,_childID];
			_childTaskIDs pushBackUnique _childTaskID;
			if (count (_dependantTasks select {([format["%1_%2",_taskID,_x select 0],_x select 1] call MPSF_fnc_isTaskState)}) isEqualTo count _dependantTasks) then {
				[_childID,_childTaskID,_taskID,false] call MPSF_fnc_createCfgTask;
			} else {
				missionNamespace setVariable [format["MPSF_ChildData_%1",_childTaskID],[_childTaskID] + _x];
				[format["MPSF_Parentof_%1",_childTaskID],"onTaskComplete",compile (
					format ["MPSF_ChildData_%1 params ['_childTaskID','_childID','_dependantTasks'];",_childTaskID]
					+ "if (count (_dependantTasks select {([format['%1_%2',"
					+ format ["%1,_x select 0],_x select 1] call MPSF_fnc_isTaskState)}) isEqualTo count _dependantTasks) then {",str _taskID]
					+ format ["[_childID,_childTaskID,%2,false] call MPSF_fnc_createCfgTask;
						[format['MPSF_Parentof_%1',_childTaskID],'onTaskComplete'] call MPSF_fnc_removeEventHandler;
					};",_childTaskID,str _taskID]
				)] call MPSF_fnc_addEventHandler;
			};
		} forEach _childTasks;
		missionNamespace setVariable [format[_taskVar,_taskID,"childTasks"],_childTaskIDs];*/
	};

	["addTaskMonitor",[_taskID,_cfgTaskID]] call MPSF_fnc_taskmaster;
} else {
	// Create Unique Task ID
	private _taskID = ["createTaskID",[_cfgTaskID]] call MPSF_fnc_taskmaster;

	// Create Task Manager Logic
	private _taskLogic = ["createTaskLogic",[[0,0,0],_taskID]] call MPSF_fnc_taskmaster;
	_taskLogic setVariable ["cfgTaskID",_cfgTaskID,true];
	_taskLogic setVariable ["taskID",_taskID,true];

	// Crate Task Position
	private _positionData = ["createTaskPosition",[_cfgTaskID,_taskID,_position]] call MPSF_fnc_taskmaster;
	_positionData params [["_position",[0,0,0],[[]]],["_positionOffset",[0,0,0],[[]]],["_areaID",[0,0,0],[[],""]]];
	_taskLogic setVariable ["position",_position,true];
	_taskLogic setVariable ["positionOffset",_positionOffset,true];
	_taskLogic setVariable ["area",_areaID,true];
	_taskLogic setPos _positionOffset;

	if (_position isEqualTo [0,0,0]) then {
		//deleteVehicle _taskLogic;
		//(format ["createChildTask request: failed to find position for %1",_taskID,_this]) call BIS_fnc_logFormat;
	};

	// Create Markers
	["createTaskMarkers",[_taskID,_cfgTaskID]] call MPSF_fnc_taskmaster;
	// Create Compositions
	["createTaskCompositions",[_taskID,_cfgTaskID]] call MPSF_fnc_taskmaster;
	// Create Return Point
	["createTaskReturnPoint",[_taskID,_cfgTaskID]] call MPSF_fnc_taskmaster;
	// Create Deployable Objects
	["createTaskDeployable",[_taskID,_cfgTaskID]] call MPSF_fnc_taskmaster;
	// Create Parent Task
	["createTaskNotification",[_taskID,_cfgTaskID,_parentID]] call MPSF_fnc_taskmaster;

	// Create Groups
	if ([] call MPSF_fnc_isHeadlessClientPresent) then {
		["onSpawnCommand",[_taskID,_cfgTaskID,_position,_positionOffset],[] call MPSF_fnc_getHeadlessClient] call MPSF_fnc_triggerEventHandler;
	} else {
		["createTaskGroups",[_taskID,_cfgTaskID,_position,_positionOffset]] call MPSF_fnc_taskmaster;
	};

	["addTaskMonitor",[_taskID,_cfgTaskID]] call MPSF_fnc_taskmaster;

	// Fire onTaskCreate Event Handler
	["onTaskCreate",[_taskID,_cfgTaskID],0] call MPSF_fnc_triggerEventHandler;
};