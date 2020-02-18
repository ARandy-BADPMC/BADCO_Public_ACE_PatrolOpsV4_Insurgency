/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getMapSectors.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Describe your function

	Parameter(s):
		0: Object - Description

	Returns:
		Bool - True when done
*/
params [["_sectorWidth",1000,[0]],["_worldSize",worldSize,[0]],["_drawMarkers",false,[false]]];

private _sectorPosition = [_sectorWidth/2,_sectorWidth/2];
private _sectors = [];

for "_gridY" from (_sectorWidth/2) to _worldSize step (_sectorWidth) do {
	_sectorPosition set [0,_sectorWidth/2];
	_sectorPosition set [1,_gridY];
	for "_gridX" from (_sectorWidth/2) to _worldSize step (_sectorWidth) do {
		_sectorPosition set [0,_gridX];
		private _sectorData = [_sectorPosition,_sectorWidth,false] call MPSF_fnc_getAreaSector;
		private _sectorBorders = [_sectorPosition,_sectorWidth] call MPSF_fnc_getAreaBorders;
		_sectorData params ["_sectorID","_sectorPosition","_sectorSize"];
		if (
			{!(surfaceIsWater _x)} count _sectorBorders > 0
			//&& !(surfaceIsWater _sectorPosition)
		) then {
			// Record Sector
			_sectors pushBack [
				_sectorID
				,[(_sectorPosition select 0),(_sectorPosition select 1),0]
				,[_sectorWidth/2,_sectorWidth/2,0]
				,1
				,surfaceIsWater _sectorPosition
				,{!(surfaceIsWater _x)} count _sectorBorders
			];
			// Draw Sector
			if (_drawMarkers) then {
				private _sector = createMarker [format["MPSF_GRID_%1%2",_gridX,_gridY],_sectorPosition];
				_sector setMarkerShape "RECTANGLE";
				_sector setMarkerBrush "SolidBorder";
				_sector setMarkerColor "ColorBlack";
				_sector setMarkerSize [_sectorWidth/2.1,_sectorWidth/2.1];
				_sector setMarkerAlpha 0.3;
			};
		};
	};
};

_sectors;