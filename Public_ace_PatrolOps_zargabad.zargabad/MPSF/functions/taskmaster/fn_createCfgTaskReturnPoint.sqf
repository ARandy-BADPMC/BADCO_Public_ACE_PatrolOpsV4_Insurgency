params [["_taskLogic",objNull,[objNull,""]],["_cfgTaskID","",[""]]];

if !(["nearbyReturnPoint",[_cfgTaskID]] call MPSF_fnc_getCfgTasks) exitWith { [0,0,0]; };

if (typeName _taskLogic isEqualTo typeName "") then { _taskLogic = missionNamespace getVariable [_taskLogic,objNull]; };
if (isNull _taskLogic) exitWith { /*["Unable to get task logic"] call BIS_fnc_error;*/ };

private _taskID = _taskLogic getVariable ["taskID",""];
private _position = _taskLogic getVariable ["position",[0,0,0]];
private _positionOffset = _taskLogic getVariable ["positionOffset",[0,0,0]];

private _positions = (["getNearbyAreas",[_position,["Clearing"],4000]] call MPSF_fnc_getCfgMapData) select { (["getAreaPosition",[_x]] call MPSF_fnc_getCfgMapData) distance2D _position > 1500 };
if (count _positions == 0) exitWith { /*["No nearby areas to %1 for Return Point",_position] call BIS_fnc_error;*/ [0,0,0]; };

private _area = selectRandom _positions;
private _position = ["getAreaPosition",[_area]] call MPSF_fnc_getCfgMapData;

private _marker = format["returnpoint_%1_centre",_taskID];
createMarker [_marker,_position];
_marker setMarkerShape "ICON";
_marker setMarkerDir 0;
_marker setMarkerType "selector_selectedFriendly";
_marker setMarkerText "Return Point"; // TODO: Localize
_marker setMarkerSize [0.8,0.8];
_marker setMarkerColor "ColorBlufor";
_marker setMarkerAlpha 0.8;

private _markerArea = format["returnpoint_%1_area",_taskID];
createMarker [_markerArea,_position];
_markerArea setMarkerShape "ELLIPSE";
_markerArea setMarkerDir 0;
_markerArea setMarkerBrush "SolidBorder";
_markerArea setMArkerSize [15,15];
_markerArea setMarkerColor "ColorBlufor";
_markerArea setMarkerAlpha 0.8;

_taskLogic setVariable ["returnpoint",[_marker,_markerArea,_position]];

_position;