/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createTask.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Creates a BIS Task
*/
params [
	["_taskID",[],[[],""]]
	,["_target",true,[true,sideunknown,grpNull,objnull,[]]]
	,["_args","",["",[]]]
	,["_dest",objNull,[objNull,[],""]]
	,["_state",false,["",false,0]]
	,["_priority",-1,[0]]
	,["_showNotification",true,[true]]
	,["_taskType","",[""]]
	,["_share",isServer,[false]]
];

if (_dest isEqualType "") then { _dest = markerpos _dest; };
if (_state isEqualType 0) then { _state = _state > 0; };
if (_dest isEqualTo [0,0,0]) then { _dest = []; };

//["Task_Intel","Task Intel",(_args select 1),(_args select 0)] call MPSF_fnc_createDiaryNote;
[_target,_taskID,_args,_dest,_state,_priority,_showNotification,_taskType,_share] call BIS_fnc_taskCreate;