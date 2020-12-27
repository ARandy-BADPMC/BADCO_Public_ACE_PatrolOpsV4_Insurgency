params [["_taskLogic",objNull,[objNull,""]],["_cfgTaskID","",[""]]];

if !(["hasDeployableObjects",[_cfgTaskID]] call MPSF_fnc_getCfgTasks) exitWith { [] };

if (typeName _taskLogic isEqualTo typeName "") then { _taskLogic = missionNamespace getVariable [_taskLogic,objNull]; };
if (isNull _taskLogic) exitWith { /*["Unable to get task logic"] call BIS_fnc_error;*/ };

private _taskID = _taskLogic getVariable ["taskID",""];
private _position = _taskLogic getVariable ["position",[0,0,0]];
private _positionOffset = _taskLogic getVariable ["positionOffset",[0,0,0]];

private _createdObjects = [];
private _objectData = ["DeployableObjects",[_cfgTaskID],true] call MPSF_fnc_getCfgTasks;

{
	_x params [
		["_deployID","",[""]],
		["_deployPosition",[0,0,0],[[],""]],
		["_deployAngle",[0,0],[0,[]]],
		["_containerClass","",[""]],
		["_deployClass","",[""]],
		["_deployDest",[0,0,0],[[],""]],
		["_deployRadius",[0,0],[0,[]]]
	];
	if (_deployPosition isEqualTo "position") then { _deployPosition =+ _position };
	if (_deployPosition isEqualTo "positionOffset") then { _deployPosition =+ _positionOffset };
	if (_deployPosition isEqualTo [0,0,0]) then { _deployPosition =+ _position };
	if (typeName _deployPosition isEqualTo typeName "") then { _deployPosition = _deployPosition call BIS_fnc_position; };
	if !(typeName _deployAngle isEqualTo typeName []) then { _deployAngle = [_deployAngle,_deployAngle]; };
	if ((_deployAngle select 0) > (_deployAngle select 1)) then { _deployAngle set [1,(_deployAngle select 1) + 360]; };
	_deployAngle = ([(_deployAngle select 0),(_deployAngle select 1)] call BIS_fnc_randomNum) % 360;

	private _container = [_deployPosition,_deployAngle,_containerClass,_deployClass,[_taskID]] call MPSF_fnc_createDeployable;

	if (_deployDest isEqualTo "position") then { _deployDest =+ _position };
	if (_deployDest isEqualTo "positionOffset") then { _deployDest =+ _positionOffset };
	if (_deployDest isEqualTo [0,0,0]) then { _deployDest =+ _position };
	if (typeName _deployDest isEqualTo typeName "") then { _deployDest = _deployDest call BIS_fnc_position; };
	if !(typeName _deployRadius isEqualTo typeName []) then { _deployRadius = [_deployRadius,_deployRadius]; };
	private _deployArea = [_deployDest] + _deployRadius + [0,false];

	_createdObjects pushback [_deployClass,_deployDest,_deployRadius,_deployArea];
} forEach _objectData;

_taskLogic setVariable ["deployableObjects",_createdObjects];

_createdObjects;