/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getAreaBuildings.sqf
	Author(s): see mpsf\credits.txt
*/
params [["_position",[0,0,0],[[]]],["_orientation",[0,0,0],[[]]],["_drawMarkers",false,[false]]];

private _areaParams = [_position,(_orientation select 0),(_orientation select 1),0,false];
private _radius = (((_orientation select 0) * sin 45) max ((_orientation select 1) * cos 45));

if (_drawMarkers) then {
	private _marker = createMarker [format["MPSF_Search_%1",_position],_position];
	_marker setMarkerShape "ELLIPSE";
	_marker setMarkerBrush "SolidBorder";
	_marker setMarkerColor "ColorBlufor";
	_marker setMarkerSize [_radius,_radius];
};

private _buildings = [];
{
	private _building = _x;
	private _buildingClassName = typeOf _building;

	if !(_buildingClassName find "House" < 0 && _buildingClassName find "Shop" < 0) then {
		private _buildingPosition = _building modelToWorld [0,0,0];
		private _buildingClass = gettext (configFile >> "cfgVehicles" >> _buildingClassName >> "vehicleClass");
		private _buildingClassType = ((_buildingClass splitString "_") - ["Structures","Structure"]) joinString "";
		private _buildingPositions = [_x] call BIS_fnc_buildingPositions;

		if (
			(_buildingPosition inArea _areaParams)
			&& count _buildingPositions > 0
		) then {
			//private _buildingDirection = direction _x;
			_buildings pushBack [
				_buildingPosition
				,_buildingClassName
				,_buildingClassType
			];
			// Draw Location
			if (_drawMarkers) then {
				private _marker = createMarker [format["MPSF_BUILDING_%1%2",(_buildingPosition) select 0,(_buildingPosition) select 1],_buildingPosition];
				_marker setMarkerShape "ICON";
				_marker setMarkerType "mil_dot";
				_marker setMarkerColor "ColorWhite";
				_marker setMarkerSize [0.5,0.5];
				_marker setMarkerAlpha 0.8;
				//_marker setMarkerText format["%1:%2",_buildingClassType,(count _buildingPositions)];
			};
		};
	};
} forEach (nearestObjects [_position,["House_F"],_radius]);

_buildings