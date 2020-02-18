/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getMapRoads.sqf
	Author(s): see mpsf\credits.txt
*/
params [["_position",[0,0,0],[[]]],["_orientation",[0,0,0],[[]]],["_drawMarkers",false,[false]]];

private _areaParams = [_position,(_orientation select 0),(_orientation select 1),0,true];
private _radius = ((((_orientation select 0)*2) * sin 45) max (((_orientation select 1)*2) * cos 45));
private _roads = [];
{
	private _roadSegment = _x;
	private _roadPosition = position _roadSegment;
	_roadPosition set [2,0];
	if ({_roadPosition distance (_x select 1) < (_radius/2.5)} count _roads == 0) then {
		if (_roadPosition inArea _areaParams) then {
			private _connectedTo = roadsConnectedTo _roadSegment;
			if (count _connectedTo > 0) then {
				private _roadDirection = [_roadPosition,(_connectedTo select 0)] call BIS_fnc_DirTo;
				_roads pushBack ["ID",_roadPosition,_roadDirection];

				// Draw Road
				if (_drawMarkers) then {
					private _marker = createMarker [format["MPSF_ROAD_%1%2",(_roadPosition) select 0,(_roadPosition) select 1],_roadPosition];
					_marker setMarkerShape "ICON";
					_marker setMarkerType "mil_dot";
					_marker setMarkerColor "ColorGrey";
					_marker setMarkerSize [0.5,0.5];
					_marker setMarkerAlpha 0.5;
				};
			};
		};
	};
} forEach (_position nearRoads _radius);

_roads;