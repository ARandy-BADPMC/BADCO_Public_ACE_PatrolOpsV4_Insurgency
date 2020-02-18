params [["_taskLogic",objNull,[objNull]],["_cfgTaskID","",[""]],["_taskID","",[""]]];

private _arguments = [];
_arguments pushBack (_taskLogic getVariable ["targets",[]]);
_arguments pushBack (_taskLogic getVariable ["groups",[]]);
_arguments pushBack (_taskLogic getVariable ["units",[]]);
_arguments pushBack (_taskLogic getVariable ["lives",-1]);
_arguments pushBack (abs(_taskLogic getVariable ["lives",-1]) > 0);

private _attributes = ["objectiveAttributes",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;

#define ATTRCOUNT 4
{
	switch (toLower _x) do {
		case "targetskilled" : {
			_arguments set [ATTRCOUNT + 1,
				({alive _x && canMove _x} count (_taskLogic getVariable ["targets",[]]) == 0)
				&& (_taskLogic getVariable ["cfgGroupsSet",false])
			];
		};
		case "targetsdestroyed" : {
			_arguments set [ATTRCOUNT + 2,
				({alive _x && canMove _x} count (_taskLogic getVariable ["targetObjects",[]]) == 0)
			];
		};
		case "targetsreturned" : {
			private _targets = _taskLogic getVariable ["targets",[]];
			if (count _targets > 0 && (_taskLogic getVariable ["cfgGroupsSet",false])) then {
				_targets = _targets apply {
					_x distance getMarkerPos ([position _x,_x] call MPSF_fnc_getNearestReturnPoint) < 30
					&& isTouchingGround _x
					&& alive _x
					&& canMove _x
				};
			} else { _targets = [false]; };
			_arguments set [ATTRCOUNT + 3,count (_targets select {_x}) == count _targets];
		};
		case "targetsdeployed" : {
			private _targetAreas = _taskLogic getVariable ["deployableObjects",[]];
			{
				_x params [["_deployClass","",[""]],["_deployDest",[0,0,0],[[],""]],["_deployRadius",[0,0],[[]]],["_deployArea",[[0,0,0],0,0,0,false],[[]]]];
				private _nearbyObjects = _deployDest nearObjects [_deployClass,(_deployRadius select 0) max (_deployRadius select 1)];
				_targetAreas set [_forEachIndex,count (_nearbyObjects select {_x inArea _deployArea}) > 0];
			} forEach _targetAreas;
			_arguments set [ATTRCOUNT + 4,count (_targetAreas select {_x}) == count _targetAreas];
		};
		case "unitskilled" : {
			_arguments set [ATTRCOUNT + 5,
				({alive _x && canMove _x} count (_taskLogic getVariable ["units",[]]) == 0)
				&& (_taskLogic getVariable ["cfgGroupsSet",false])
			];
		};
		case "cachedestroyed" : {
			private _caches = (_taskLogic getVariable ["targets",[]]) select {typeOf _x IN (["WeaponCacheTypes"] call MPSF_fnc_getCfgTasks)};
			_arguments set [ATTRCOUNT + 6,
				({damage _x == 0} count _caches == 0)
				&& (_taskLogic getVariable ["cfgGroupsSet",false])
			];
		};
		case "inteldownloaded" : {
			_arguments set [ATTRCOUNT + 7,_taskLogic getVariable ["inteldownloaded",false]];
		};
		case "intelpickedup" : {
			_arguments set [ATTRCOUNT + 8,_taskLogic getVariable ["intelpickedup",false]];
		};
		case "intelrecieved" : {
			_arguments set [ATTRCOUNT + 9,_taskLogic getVariable ["intelrecieved",false]];
		};
		case "playerskilled" : {
			private _allPlayers = [_taskID] call MPSF_fnc_getAssignedTaskPlayers;
			_arguments set [ATTRCOUNT + 10,
				count (_allPlayers select {!(_taskID IN (_x getVariable ["MPSF_Player_var_assignedTasksKIA",[]]))}) == 0
			];
		};
		case "playersleft" : {
			private _allPlayers = [_taskID] call MPSF_fnc_getAssignedTaskPlayers;
			_arguments set [ATTRCOUNT + 11,
				count (_allPlayers select {!(_taskID IN (_x getVariable ["MPSF_Player_var_assignedTasksKIA",[]]))}) > 0
			];
		};
		case "sectorscleared" : {
			_arguments set [ATTRCOUNT + 12,false];
		};
		case "areadefended" : {
			private _areaActive = missionNamespace getVariable [format["MPSF_Taskmanager_%1_var_areaActive",_taskID],false];
			if !(_areaActive) then {
				missionNamespace setVariable [format["MPSF_Taskmanager_%1_var_areaActive",_taskID],({false} count allPlayers > 0)];
			};
			if (_areaActive) then { ({alive _x} count allPlayers > 0) } else {true};
			_arguments set [ATTRCOUNT + 13,false];
		};
		case "childtaskscomplete" : {
			private _childTasks = _taskLogic getVariable ["childTasks",([_taskID] call BIS_fnc_taskChildren)];
			_arguments set [ATTRCOUNT + 14,count (_childTasks select {([_x] call MPSF_fnc_isTaskComplete)}) isEqualTo count _childTasks];
		};
	};
} forEach _cfgTaskAttributes;

_arguments