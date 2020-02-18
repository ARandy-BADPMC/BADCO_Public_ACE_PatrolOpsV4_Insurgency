/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getTaskData.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Returns the tasks data
*/
params [["_dataType","",[""]],["_taskID","",[""]]];

switch (_dataType) do {
	case "all";
	case "data" : {
		missionNamespace getVariable [[_taskID] call BIS_fnc_taskVar,[]];
	};
	case "parent" : {
		[_taskID] call BIS_fnc_taskParent;
	};
	case "children" : {
		[_taskID] call BIS_fnc_taskChildren;
	};
	case "description" : {
		[_taskID] call BIS_fnc_taskDescription;
	};
	case "state" : {
		[_taskID] call BIS_fnc_taskState;
	};
	case "isComplete" : {
		if ([_taskID] call BIS_fnc_taskExists) then {
			[_taskID] call BIS_fnc_taskCompleted;
		} else {
			false
		};
	};
	case "destination" : {
		[_taskID] call BIS_fnc_taskDestination;
	};
	default { nil };
};