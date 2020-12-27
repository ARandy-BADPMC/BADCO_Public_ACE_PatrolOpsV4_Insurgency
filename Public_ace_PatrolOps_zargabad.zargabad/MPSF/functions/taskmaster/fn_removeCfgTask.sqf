params [["_taskID","",[""]]];

private _taskLogic = missionNamespace getVariable [_taskID,objNull];
if (isNull _taskLogic) exitWith { /*["Unable to get task logic"] call BIS_fnc_error;*/ };

_taskLogic setVariable ["TaskActive",false,true];

["removeTaskMonitor",[_taskID]] call MPSF_fnc_taskmaster;

private _deleteFromArray = {
	switch (true) do {
		case (_this isEqualType objNull) : { if !(_this getVariable ["ignoreCleanup",false]) then { deleteVehicle _this; }; };
		case (_this isEqualType objNull) : { deleteGroup _this; };
		case (_this isEqualType "") : { deleteMarker _this; };
	};
};

{ _x call _deleteFromArray; } forEach (_taskLogic getVariable ["markers",[]]);

waitUntil { {_x distance _taskLogic < 1500} count allPlayers == 0 };

{ _x call _deleteFromArray; } forEach (_taskLogic getVariable ["compositions",[]]);
{ _x call _deleteFromArray; } forEach (_taskLogic getVariable ["targets",[]]);
{ _x call _deleteFromArray; } forEach (_taskLogic getVariable ["units",[]]);
{ _x call _deleteFromArray; } forEach (_taskLogic getVariable ["groups",[]]);

[_taskID] call MPSF_fnc_removeZeusEditArea;

deleteMarker format["returnpoint_%1_centre",_taskID];
deleteMarker format["returnpoint_%1_area",_taskID];

deleteVehicle _taskLogic;