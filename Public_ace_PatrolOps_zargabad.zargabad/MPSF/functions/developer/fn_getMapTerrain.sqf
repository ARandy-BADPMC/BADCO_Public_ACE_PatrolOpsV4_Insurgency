/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getMapTerrain.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Describe your function

	Parameter(s):
		0: Object - Description

	Returns:
		Bool - True when done
*/
params [["_position",[0,0,0],[[]]],["_orientation",[0,0,0],[[]]],["_drawMarkers",false,[false]]];

// Terrain Scanner
private _definedforest = "(1 * forest * trees) * (1 - sea) * (1 - houses)";
private _treeNoForest = "(1 * (trees + meadow)) * (1 - forest) * (1 - sea) * (1 - houses)";
private _definedClearing = "(1 * meadow) * (1 - forest) * (1 - trees) * (1 - sea) * (1 - houses)";
private _definedTown = "(1 * houses) * (1 - forest) * (1 - sea)";
private _definedOcean = "(1 * (waterDepth interpolate [1,16,0,1]))";

private _areaParams = [_position,(_orientation select 0),(_orientation select 1),0,true];
private _radius = [(_orientation select 0)*2,(_orientation select 1)*2];
private _stepPos = [(_position select 0) - (_orientation select 0),(_position select 1) - (_orientation select 1),0];
private _posSW = +_stepPos;
private _stepDis = ((_radius select 0) max (_radius select 1))/10;

private _Testmarker = createMarker ["TestMarker",[0,0,0]];
_Testmarker setMarkerShape "ICON";
_Testmarker setMarkerType "mil_box";
_Testmarker setmarkercolor "ColorBlack";

private _areas = [];
for "_gridY" from (0) to ((_radius select 1) - _stepDis) step (_stepDis) do {
	_stepPos = [(_posSW select 0),(_posSW select 1) + _gridY];
	for "_gridX" from (0) to ((_radius select 0) - _stepDis) step (_stepDis) do {
		_stepPos = [(_posSW select 0) + _gridX,(_stepPos select 1)];
		_Testmarker setMarkerPos _stepPos;
		if (_stepPos inArea _areaParams) then {
			if !(surfaceIsWater _stepPos) then {
				// Forests
				{
					if ((_x select 1) == 1) then {
						_forestPosition = _x select 0;
						if (
							{_forestPosition distance (_x select 1) < 400} count _areas == 0
							&& (count (_forestPosition nearRoads 80) == 0)
						) then {
							if (_forestPosition inArea _areaParams) then {
								_forestPosition set [2,0];
								_areas pushBack ["Forest",_forestPosition,[20,20,0],0];
								if (_drawMarkers) then {
									_marker = createMarker [format["MPSF_FOREST_%1",_forestPosition],_forestPosition];
									_marker setMarkerShape "ICON";
									_marker setMarkerType "mil_box";
									_marker setmarkercolor "ColorGreen";
									//_marker setMarkerText str(_x select 1);
									_marker setmarkersize [0.5,0.5];
								};
							};
						};
					};
				} forEach (selectBestPlaces [_stepPos,(_stepDis/2),_definedforest,0.6,1]);
				// Light Forest
				{
					if ((_x select 1) == 1) then {
						_forestPosition = _x select 0;
						if (
							{_forestPosition distance (_x select 1) < 500} count _areas == 0
							&& (count (_forestPosition nearRoads 80) == 0)
						) then {
							if (_forestPosition inArea _areaParams) then {
								_forestPosition set [2,0];
								_areas pushBack ["Trees",_forestPosition,[20,20,0],0];
								if (_drawMarkers) then {
									_marker = createMarker [format["MPSF_FOREST_%1",_forestPosition],_forestPosition];
									_marker setMarkerShape "ICON";
									_marker setMarkerType "mil_triangle";
									_marker setmarkercolor "ColorGreen";
									//_marker setMarkerText str(_x select 1);
									_marker setmarkersize [0.5,0.5];
								};
							};
						};
					};
				} forEach (selectBestPlaces [_stepPos,(_stepDis/2),_treeNoForest,_stepDis,1]);
				// Clearings
				{
					if ((_x select 1) == 1) then {
						_clearPosition = _x select 0;
						if (
							({_clearPosition distance (_x select 1) < 300} count _areas == 0)
							&& (count (_clearPosition nearRoads 50) == 0)
						) then {
							_clearPosition = (_clearPosition) isFlatEmpty [15,1,0.3,15,0,false];
							if (count _clearPosition > 0) then {
								if (_clearPosition inArea _areaParams) then {
									_clearPosition set [2,0];
									_areas pushBack ["Clearing",_clearPosition,[50,50,0],0];
									if (_drawMarkers) then {
										_marker = createMarker [format["MPSF_CLEAR_%1",_clearPosition],_clearPosition];
										_marker setMarkerShape "ICON";
										_marker setMarkerType "mil_box";
										_marker setmarkercolor "ColorIndependent";
										//_marker setMarkerText str(_x select 1);
										_marker setmarkersize [0.5,0.5];
									};
								};
							};
						};
					};
				} forEach (selectBestPlaces [_stepPos,_stepDis,_definedClearing,_stepDis,1]);
			};
		};
	};
};

deleteMarker _Testmarker;

_areas;