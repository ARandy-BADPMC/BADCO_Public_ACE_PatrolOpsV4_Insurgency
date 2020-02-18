/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getMapLocations.sqf
	Author(s): see mpsf\credits.txt
*/
params [["_sectorWidth",1000,[0]],["_worldSize",worldSize,[0]],["_drawMarkers",false,[false]],["_includeExistingLocations",true,[false]]];

private _worldCenter = [_worldSize/2,_worldSize/2];

private _locations = [];
{
	if !((_x getVariable ["MPSF_Location_Type",""]) isEqualTo "") then {
		private _locationObject = _x;
		private _locationType = _locationObject getVariable ["MPSF_Location_Type","Undefined"];
		private _locationPosition = position _x;
		private _locationZ = if (_locationType isEqualTo "Air") then { 500 } else { 0 };
		private _locationSize = [100,100];

		{
			if ((typeOf _x) isKindOf "EmptyDetector") exitWith {
				(triggerArea _x) params ["_width","_height","_angle","_area"];
				_locationPosition = position _x;
				_locationSize = [_height,_width];
			};
		} forEach synchronizedObjects _locationObject;

		_locations pushBack [
			_locationType
			,[_locationPosition select 0,_locationPosition select 1,_locationZ]
			,[_locationSize select 0,_locationSize select 1,0]
		];
	};
} forEach (allMissionObjects "Logic");

if (_includeExistingLocations) then {
	{
		private _locationPosition = locationPosition _x;
		if ({_locationPosition distance2D (_x select 1) < 500} count _locations == 0) then {
			_locations pushBack [
				type _x
				,[(locationPosition _x) select 0,(locationPosition _x) select 1,0]
				,[(size _x) select 0,(size _x) select 1,0]
			];
		};
	} forEach (nearestLocations [_worldCenter,["NameCity","NameCityCapital","NameVillage","NameLocal","Hill"],_worldSize]);
};

{
	private _locationData = _x;
	_locationData params ["_locationClass","_locationPosition","_locationSize"];

	private _locationID = format["%1_%2",_locationClass,_forEachIndex];
	private _locationBuildings = [_locationPosition,_locationSize,_drawMarkers] call MPSF_fnc_getAreaBuildings;
	private _locationSectors = [_locationPosition,_locationSize,_drawMarkers] call MPSF_fnc_getAreaSectors;

	_locations set [_forEachIndex,[
		_locationID
		,_locationPosition
		,_locationSize
		,_locationClass
		,[_locationPosition,_sectorWidth,true] call MPSF_fnc_getAreaSector
		,count _locationBuildings
		,if (count _locationSectors > 5) then { _locationSectors } else { [] }
	]];
} forEach _locations;

// Draw Locations
if (_drawMarkers) then {
	{
		private _marker = createMarker [format["MPSF_LOCATION_%1_1",_forEachIndex],(_x select 1)];
		_marker setMarkerShape "RECTANGLE";
		_marker setMarkerBrush "SolidBorder";
		_marker setMarkerColor "ColorOpfor";
		_marker setMarkerSize [((_x select 2) select 0)/2,((_x select 2) select 1)/2];

		private _marker = createMarker [format["MPSF_LOCATION_%1_2",_forEachIndex],(_x select 1)];
		_marker setMarkerShape "ICON";
		_marker setMarkerType "mil_dot";
		_marker setMarkerColor "ColorOpfor";
		_marker setMarkerText (_x select 0);
		_marker setMarkerSize [1,1];
	} forEach _locations;
};

_locations;