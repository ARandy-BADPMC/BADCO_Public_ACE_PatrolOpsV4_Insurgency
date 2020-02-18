params [["_taskLogic",objNull,[objNull,""]],["_cfgTaskID","",[""]]];

if !(["hasMarkers",[_cfgTaskID]] call MPSF_fnc_getCfgTasks) exitWith { [] };

if (typeName _taskLogic isEqualTo typeName "") then { _taskLogic = missionNamespace getVariable [_taskLogic,objNull]; };
if (isNull _taskLogic) exitWith { /*["Unable to get task logic"] call BIS_fnc_error;*/ };

private _taskID = _taskLogic getVariable ["taskID",""];
private _position = _taskLogic getVariable ["position",[0,0,0]];
private _positionOffset = _taskLogic getVariable ["positionOffset",[0,0,0]];

private _createdMarkers = [];
private _markerData = ["Markers",[_cfgTaskID],true] call MPSF_fnc_getCfgTasks;
private _areaSize = ["areaSize",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;

{
	_x params [
		["_markerID","",[""]],
		["_markerPosition",[0,0,0],[[],""]],
		["_markerShape","",[""]],
		["_markerType","",[""]],
		["_markerBrush","",[""]],
		["_markerColour","",[""]],
		["_markerAngle",[0,0],[0,[]]],
		["_markerSize",[1,1],[0,[]]],
		["_markerDistance",[0,0],[0,[]]],
		["_markerDirection",[0,0],[0,[]]],
		["_markerText","",[""]],
		["_markerAlpha",1,[0]]
	];

	if (_markerPosition isEqualTo "position") then { _markerPosition =+ _position };
	if (_markerPosition isEqualTo "positionOffset") then { _markerPosition =+ _positionOffset };
	if (_markerPosition isEqualTo [0,0,0]) then { _markerPosition =+ _position };
	if (typeName _markerPosition isEqualTo typeName "") then { _markerPosition = _markerPosition call BIS_fnc_position; };

	if !(typeName _markerAngle isEqualTo typeName []) then { _markerAngle = [_markerAngle,_markerAngle]; };
	if ((_markerAngle select 0) > (_markerAngle select 1)) then { _markerAngle set [1,(_markerAngle select 1) + 360]; };
	_markerAngle = ([(_markerAngle select 0),(_markerAngle select 1)] call BIS_fnc_randomNum) % 360;

	if (_markerAngle > 0) then {
		_areaSize set [2,(_areaSize select 0)/sin(_markerAngle)];
	} else {
		_areaSize set [2,(_areaSize select 0)];
	};

	if !(typeName _markerDirection isEqualTo typeName []) then { _markerDirection = [_markerDirection,_markerDirection]; };
	if ((_markerDirection select 0) > (_markerDirection select 1)) then { _markerDirection set [1,(_markerDirection select 1) + 360]; };
	_markerDirection = (_markerDirection call BIS_fnc_randomNum) % 360;

	if !(typeName _markerDistance isEqualTo typeName []) then { _markerDistance = [_markerDistance,_markerDistance]; };
	_markerDistance = ([(_markerDistance select 0) * 100,(_markerDistance select 1) * 100] call BIS_fnc_randomNum)/100;
	if (_markerDistance < 9) then { _markerDistance = ((_areaSize select 2)/2)*_markerDistance; };

	if (_markerDistance > 0) then {
		_markerPosition = _markerPosition getPos [_markerDistance,_markerDirection];
	};

	if !(toUpper _markerShape == "ICON") then {
		{
			if (_x <= 9) then {
				_markerSize set [_forEachIndex,((_areaSize select _forEachIndex)*_x)/2];
			};
		} forEach _markerSize;
	};

	private _marker = createMarker [format["%1_%2",_taskID,_markerID],_markerPosition];
	_marker setMarkerShape _markerShape;
	_marker setMarkerDir _markerAngle;
	if (toUpper _markerShape == "ICON") then {
		_marker setMarkerType _markerType;
		_marker setMarkerText _markerText;
	} else {
		_marker setMarkerBrush _markerBrush;
	};
	_marker setMarkerColor _markerColour;
	_marker setMarkerSize _markerSize;
	_marker setMarkerAlpha (0 max _markerAlpha min 1);

	_createdMarkers pushback _marker;
} forEach _markerData;

_taskLogic setVariable ["markers",_createdMarkers];

_createdMarkers;