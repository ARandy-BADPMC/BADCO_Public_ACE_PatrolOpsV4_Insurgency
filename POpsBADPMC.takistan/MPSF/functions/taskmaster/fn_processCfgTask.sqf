params [["_taskID","",[""]],["_cfgTaskID","",[""]]];

private _taskLogic = missionNamespace getVariable [_taskID,objNull];
if (isNull _taskLogic) exitWith { /*["Unable to get task logic"] call BIS_fnc_error;*/ };

if !(missionNamespace getVariable [format["processing%1",_taskID],false]) then {
	missionNamespace setVariable [format["processing%1",_taskID],true];

	if (_cfgTaskID isEqualTo "") then { _cfgTaskID = _taskLogic getVariable ["cfgTaskID",""]; };
	if !(_cfgTaskID isEqualTo "") then {
		(["Objectives",[_cfgTaskID]] call MPSF_fnc_getCfgTasks) params [["_cfgTaskObjectives",[],[[]]],["_cfgTaskAttributes",[],[[]]]];

		private _arguments = ["processTaskArguments",[_taskLogic,_cfgTaskID,_taskID]] call MPSF_fnc_taskmaster;
		private _inputs = format ["params [
			['_targets',[],[[]]]
			,['_groups',[],[[]]]
			,['_units',[],[[]]]
			,['_lives',-1,[0]]
			,['_hasLivesLeft',false,[false]]
			,['_targetsKilled',false,[false]]
			,['_targetsDestroyed',false,[false]]
			,['_targetsReturned',false,[false]]
			,['_targetsDeployed',false,[false]]
			,['_unitsKilled',false,[false]]
			,['_cacheDestroyed',false,[false]]
			,['_intelDownloaded',false,[false]]
			,['_intelPickedUp',false,[false]]
			,['_intelRecieved',false,[false]]
			,['_playersKilled',false,[false]]
			,['_playersLeft',false,[false]]
			,['_sectorsCleared',false,[false]]
			,['_areaDefended',false,[false]]
			,['_childTasksComplete',false,[false]]
		]; "];

		private _exitState = "";
		private _endMission = false;
		private _taskData = [];
		{
			_x params [["_taskState","",[""]],["_taskCondition","",[""]],["_taskNext",[],[[]]],["_tasksNext",[],[[]]],["_taskFunction","",[""]],["_taskEndMission",false,[false]]];
			if (toLower _taskState IN ["succeeded","failed","canceled"]) then {
				if !(_taskCondition == "") then {
					if (_arguments call compile (_inputs + _taskCondition)) exitWith {
						//format ["ProcessTaskCondition Exiting Task %1 as %2",_taskID,_taskState] call BIS_fnc_logFormat;
						_exitState = _taskState;
						_taskData = _x;
					};
				};
			};
		} forEach (_cfgTaskObjectives);

		if (_taskLogic getVariable ["abort",false]) then {
			//format ["ProcessTaskCondition Aborting Task %1",_taskID] call BIS_fnc_logFormat;
			_exitState = _taskLogic getVariable ["abortState","canceled"];
			_taskData = [];
		};

		if (!(_exitState isEqualTo "") && {(_taskLogic getVariable ["exitState",""]) isEqualTo ""}) then {
			_taskLogic setVariable ["exitState",_exitState];
			private _lastPosition = position _taskLogic;
			["removeTaskMonitor",[_taskID]] call MPSF_fnc_taskmaster;

			if ([_taskID] call BIS_fnc_taskExists) then {
				[_taskID,_exitState,true] call MPSF_fnc_updateTaskState;
			};

			private _cfgTaskID = _taskLogic getVariable ["cfgTaskID",""];
			private _position = _taskLogic getVariable ["position",[0,0,0]];
			private _positionOffset = _taskLogic getVariable ["positionOffset",[0,0,0]];

			["onTaskComplete",[_exitState,_taskID,_cfgTaskID,_position,_positionOffset],0] call MPSF_fnc_triggerEventHandler;
			["removeTask",[_taskID]] spawn MPSF_fnc_taskmaster;

			if (count _taskData > 0) then {
				_taskData params [["_taskState","",[""]],["_taskCondition","",[""]],["_taskNext",[],[[]]],["_tasksNext",[],[[]]],["_taskFunction","",[""]]];
				if !(_taskFunction isEqualTo "") then {
					[_taskID,_exitState,_position,_positionOffset] spawn (missionNamespace getVariable [_taskFunction,{}]);
				};
				if (count _taskNext > 0) then {
					["create",[selectRandom _taskNext,_lastPosition]] call MPSF_fnc_taskmaster;
				};
				if (count _tasksNext > 0) then {
					{ ["create",[_x,_lastPosition]] call MPSF_fnc_taskmaster; } forEach _tasksNext;
				};
			};
		};
	};
	missionNamespace setVariable [format["processing%1",_taskID],false];
};