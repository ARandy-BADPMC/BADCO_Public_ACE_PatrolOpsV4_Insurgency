params [["_taskID","",[""]],["_cfgTaskID","",[""]]];

if (_taskID == "") exitWith { false };

private _taskIDs = missionNamespace getVariable ["MPSF_Taskmanager_var_activeTaskIDs",[]];
_taskIDs pushBack [_taskID,_cfgTaskID];
missionNamespace setVariable ["MPSF_Taskmanager_var_activeTaskIDs",_taskIDs];

true;