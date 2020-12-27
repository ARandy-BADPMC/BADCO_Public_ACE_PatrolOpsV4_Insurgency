/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createConvoy.sqf
	Author(s): see mpsf\credits.txt

	Description:
		IN PROGRESS
*/
params [
	["_startPos",[0,0,0],[[]]]
	,["_destPos",[0,0,0],[[]]]
	,["_faction","FactionTypeOPF",[""]]
	,["_vehicleClasses",[],["",[]]]
];

private _direction = _startPos getDir _destPos;

if (_faction IN ["FactionTypeBLU","FactionTypeOPF","FactionTypeCIV"]) then {
	_faction = [_faction] call MPSF_fnc_getConfigMission;
};
if !(typeName _vehicleClasses isEqualTo typeName []) then { _vehicleClasses = [_vehicleClasses]; };

private _nearbyRoads = _startPos nearRoads 50;
private _nearestRoad = objNull;
if (count _nearbyRoads > 0) then {
	_nearestRoad = selectRandom _nearbyRoads;
};

if (isNull _nearestRoad) exitWith {};

private _roadSegments = [];
private _spawnPos = [];
private _spawnDir = [];
for "_i" from 0 to (count _vehicleClasses - 1) do {
	private _connectedTo = (roadsConnectedTo _nearestRoad) select {!(_x IN _roadSegments)};
	if (count _connectedTo > 0) then {
		_connectedTo = (_connectedTo select 0);
	} else {
		_connectedTo = objNull;
	};
	if !(isNull _connectedTo) then {
		_roadSegments pushBackUnique _nearestRoad;
		_spawnPos pushBack (_nearestRoad call BIS_fnc_position);
		_spawnDir pushBack (_connectedTo getDir _nearestRoad);
		_nearestRoad = _connectedTo;
	} else {
		private _nearbyRoads = (_nearestRoad nearRoads 50) select {!(_x IN _roadSegments)};
		if (count _nearbyRoads > 0) then {
			_nearestRoad = selectRandom _nearbyRoads;
		};
	};
};

private _convoyGroup = grpNull;
{
	private _vehiclePos = _spawnPos select _forEachIndex;
	private _vehicleDir = _spawnDir select _forEachIndex;
	private _vehicleClass = _vehicleClasses select _forEachIndex;
	if !(typeName _vehicleClass isEqualTo typeName []) then { _vehicleClass = [_vehicleClass]; };
	_vehicleClass params [["_vehicleType","",[""]],["_squadType",[],[[],""]]];

	if !(isClass(configFile >> "CfgVehicles" >> _vehicleType)) then {
		_vehicleType = [_faction,_vehicleType,true] call MPSF_fnc_getConfigSideVehicles;
	};

	private _vehicleData = [_vehiclePos,_faction,_vehicleType,_vehicleDir,true,_squadType] call MPSF_fnc_createVehicle;
	_vehicleData params [["_vehicle",objNull,[objNull]],["_crew",[],[[]]],["_cargo",[],[[]]]];

	_vehicleGroup = group driver _vehicle;
	if (isNull _convoyGroup) then {
		_convoyGroup = _vehicleGroup;
		_convoyGroup setFormation "Column";
		_convoyGroup setBehaviour "SAFE";
		_convoyGroup setCombatMode "WHITE";
	} else {
		(units _vehicleGroup) joinSilent _convoyGroup;
		deleteGroup _vehicleGroup;
	};

	if (false) then {
		private _marker = createMarker [format["MPSF_ROAD_%1_%2",_forEachIndex,[6] call MPSF_fnc_getRandomString],_vehiclePos];
		_marker setMarkerShape "ICON";
		_marker setMarkerType "mil_arrow";
		_marker setMarkerDir _vehicleDir;
		_marker setMarkerColor "ColorBlack";
		_marker setMarkerSize [0.5,0.5];
		_marker setMarkerAlpha 0.5;
	};
} forEach _roadSegments;

private _wayPoint = _convoyGroup addWaypoint [_destPos,50];
_wayPoint setWaypointType "MOVE";