params [["_taskLogic",objNull,[objNull,""]],["_cfgTaskID","",[""]],["_parentID","",[""]]];

if !(["hasSimpleTask",[_cfgTaskID]] call MPSF_fnc_getCfgTasks) exitWith { [] };

if (typeName _taskLogic isEqualTo typeName "") then { _taskLogic = missionNamespace getVariable [_taskLogic,objNull]; };
if (isNull _taskLogic) exitWith { /*["Unable to get task logic"] call BIS_fnc_error;*/ };

private _taskID = _taskLogic getVariable ["taskID",""];
private _position = _taskLogic getVariable ["position",[0,0,0]];
private _positionOffset = _taskLogic getVariable ["positionOffset",[0,0,0]];

if !(isClass (["CfgMissionTasks",_cfgTaskID] call BIS_fnc_getCfg)) exitWith {};

if (_parentID isEqualTo "") then {
	_parentID = ["taskParent",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;
};
private _taskIDs = if !(_parentID isEqualTo "") then { [_taskID,_parentID]; } else { _taskID };

private _target = ["TaskDetails",[_cfgTaskID,"target"]] call MPSF_fnc_getCfgTasks;
private _title = ["TaskDetails",[_cfgTaskID,"title"]] call MPSF_fnc_getCfgTasks;
private _description = ["TaskDetails",[_cfgTaskID,"description"]] call MPSF_fnc_getCfgTasks;
private _iconType = ["TaskDetails",[_cfgTaskID,"iconType"]] call MPSF_fnc_getCfgTasks;
private _taskPos = ["TaskDetails",[_cfgTaskID,"iconPosition"]] call MPSF_fnc_getCfgTasks;
private _chevronTitle = ["TaskDetails",[_cfgTaskID,"chevronTitle"]] call MPSF_fnc_getCfgTasks;
private _textArguments = ["TaskDetails",[_cfgTaskID,"textArguments"]] call MPSF_fnc_getCfgTasks;
private _state = ["TaskDetails",[_cfgTaskID,"state"]] call MPSF_fnc_getCfgTasks;

if (_taskPos isEqualTo "position") then { _taskPos =+ _position; };
if (_taskPos isEqualTo "positionOffset") then { _taskPos =+ _positionOffset; };
if (typeName _taskPos isEqualTo typeName "") then { _taskPos = _taskPos call BIS_fnc_position; };

private _args = [_description,_title,_chevronTitle];
private _targets = _taskLogic getVariable [format["MPSF_%1_data_%2",_taskID,"targets"],[]];
{
	private _argument = [_x,[_position,_targets]] call MPSF_fnc_getTaskDescription;
	_textArguments set [_forEachIndex,_argument];
} forEach _textArguments;

if (typeName _args isEqualTo typeName []) then {
	{ _args set [_forEachIndex,format([_x] + _textArguments)]; } forEach _args;
};

[_taskIDs,_target,_args,_taskPos,_state,0,true,_iconType,(isMultiplayer && isServer)] call MPSF_fnc_createTask;