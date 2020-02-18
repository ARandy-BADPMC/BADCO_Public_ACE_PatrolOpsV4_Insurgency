params [["_taskRef","",[""]]];

private _taskIDs = missionNamespace getVariable ["MPSF_Taskmanager_var_activeTaskIDs",[]];
{
	if (_taskRef == (_x select 0)) exitWith {
		_taskIDs deleteAt _forEachIndex;
	};
} forEach _taskIDs;

missionNamespace setVariable ["MPSF_Taskmanager_var_activeTaskIDs",_taskIDs];

true;