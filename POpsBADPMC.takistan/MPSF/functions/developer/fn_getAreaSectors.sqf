/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getAreaSectors.sqf
	Author(s): see mpsf\credits.txt
*/
params [["_position",[0,0,0],[[]]],["_orientation",[0,0,0],[[]]],["_drawMarkers",false,[false]]];

private _areaParams = [_position,(_orientation select 0)/2,(_orientation select 1)/2,0,true];
private _radius = ((((_orientation select 0)*2) * sin 45) max (((_orientation select 1)*2) * cos 45));
private _subSectors = [];
{
	private _buildingPosition = _x modelToWorld [0,0,0];
	_buildingPosition set [2,0];
	if (_buildingPosition inArea _areaParams) then {
		private _buildingSector = [_buildingPosition,100,false] call MPSF_fnc_getAreaSector;
		_buildingSector params ["_sectorID","_sectorPos","_sectorWidth"];
		_subSectors pushBackUnique [_sectorID,_sectorPos];
	};
} forEach (nearestObjects [_position,["House_F"],_radius]);

if (_drawMarkers && count _subSectors > 5) then {
	{
		_x params ["_sectorID","_sectorPos"];
		private _sectorMarker = createMarker [format["MPSF_S%1_A%2",_forEachIndex,_sectorID],_sectorPos];
		_sectorMarker setMarkerShape "RECTANGLE";
		_sectorMarker setMarkerBrush "SolidBorder";
		_sectorMarker setMarkerColor "ColorOPFOR";
		_sectorMarker setMarkerSize ([100/2.1,100/2.1]);
		_sectorMarker setMarkerAlpha 0.5;
	} forEach _subSectors;
};

_subSectors;