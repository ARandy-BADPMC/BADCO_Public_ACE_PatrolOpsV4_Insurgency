/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_generateMapData.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Generates the Mapdata used by Patrol Ops and stored in CfgMissionData

	Parameter(s):
		0: NUMBER - Size of map sectors to use
		1: BOOL - Draw markers while building

	Returns:
		STRING - The recoreded world data
*/
params [["_sectorWidth",1000,[0]],["_drawMarkers",false,[false]]];

private _worldCenter = [worldSize/2,worldSize/2];
private _worldArea = [worldSize,worldSize,0];
private _worldSize = (worldSize * sin 45) max (worldSize * cos 45);
private _allAreas = [];
private _roads = [];

_getMapSectors = {
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
};

_funcArea = {
	params [["_buildingsArray",[],[[]]],["_locationType","",[""]],["_areaSize",0,[0]],["_limit",0,[0]]];

	diag_log (format["%2 Generating Area Types: %1",_locationType,toUpper worldname]);
	systemChat (format["%2 Generating Area Types: %1",_locationType,toUpper worldname]);

	{
		if !(isNull _x) then {
			private _building = _x;
			private _locationPosition = _building call BIS_fnc_position;
			private _locationSize = [_areaSize,_areaSize];
			private _nearbyBuildings = _buildingsArray select {_x inArea ([_locationPosition,_areaSize,_areaSize,0,false])};

			if (count _nearbyBuildings > 0) then {
				private _posXmin = 1e10;
				private _posXmax = 0;
				private _posYmin = 1e10;
				private _posYmax = 0;
				{
					private _xPos = _x call BIS_fnc_position;
					_posXmin = _posXmin min (_xPos select 0);
					_posXmax = _posXmax max (_xPos select 0);
					_posYmin = _posYmin min (_xPos select 1);
					_posYmax = _posYmax max (_xPos select 1);
				} foreach _nearbyBuildings;
				private _posW =  _posXmax - _posXmin;
				private _posH = _posYmax - _posYmin;
				private _posX = _posXmin + _posW / 2;
				private _posY = _posYmin + _posH / 2;
				private _mapPosMax = [_posXmax,_posYmax];
				private _mapPosMin = [_posXmin,_posYmin];
				private _mapPosW = abs ((_mapPosMax select 0) - (_mapPosMin select 0));
				private _mapPosH = abs ((_mapPosMin select 1) - (_mapPosMax select 1));

				_locationPosition = [_posX,_posY];
				_locationSize = [_mapPosW*1.1,_mapPosH*1.1];
			};

			if (count _nearbyBuildings > _limit) then {
				_buildingsArray = _buildingsArray apply { if (_x in _nearbyBuildings) then {objNull} else {_x};};

				{
					private _marker = createMarker [format["MPSF_BUILDING_HOUSE_%1%2",_locationType,str (_x call BIS_fnc_netID)],_x call BIS_fnc_position];
					_marker setMarkerShape "ICON";
					_marker setMarkerType "mil_dot";
					_marker setMarkerColor "ColorWhite";
					_marker setMarkerSize [0.5,0.5];
					_marker setMarkerAlpha 0.5;
					//_marker setMarkerText format["%1:%2",_buildingClassType,(count _buildingPositions)];
				} forEach _nearbyBuildings;

				_allAreas pushBack [
					_locationType// + "_" + str (count _nearbyBuildings) + "_H"
					,_locationPosition
					,_locationSize apply {abs _x}
					,count _nearbyBuildings
					//,[_locationPosition,_sectorWidth,true] call MPSF_fnc_getAreaSector
				];
			};
		};
	} forEach _buildingsArray;
};

private _sectors = [_sectorWidth,worldSize,_drawMarkers] call _getMapSectors;
diag_log (format["%2 Sectors: %1 x %3m created over %4m area",count _sectors,toUpper worldname,_sectorWidth,worldSize]);
systemChat (format["%2 Sectors: %1 x %3m created over %4m area",count _sectors,toUpper worldname,_sectorWidth,worldSize]);

private _worldBuildings = nearestObjects [_worldCenter,["House_F","House"],_worldSize];
private _worldTowns = nearestLocations [_worldCenter,["CityCenter","NameCityCapital","NameCity","NameVillage","NameLocal","Name"],_worldSize];
private _worldAreas = nearestLocations [_worldCenter,[
	"NameMarine"
	//,"Strategic"
	//,"StrongpointArea"
	//,"FlatArea"
	//,"FlatAreaCity"
	//,"FlatAreaCitySmall"
	,"Airport"
	,"Hill"
	,"ViewPoint"
	,"VegetationVineyard"
],_worldSize];

private _worldBuildingTowns =+ _worldBuildings select { !((typeOf _x find "House" < 0 && typeOf _x find "Shop" < 0) || {typeOf _x find "Cargo_House" >= 0}) };
private _worldBuildingReligion =+ _worldBuildings select { !(typeOf _x find "Chapel" < 0 && typeOf _x find "Church" < 0 && typeOf _x find "Mosque" < 0 && typeOf _x find "Minaret" < 0) };
private _worldBuildingOffice =+ _worldBuildings select { !(typeOf _x find "Office" < 0) };
private _worldBuildingPiers =+ _worldBuildings select { !(typeOf _x find "Pier" < 0) };
private _worldBuildingMilitary =+ _worldBuildings select { !(typeOf _x find "Barracks" < 0 && typeOf _x find "Bunker" < 0 && typeOf _x find "Dome" < 0 && typeOf _x find "Land_Cargo_" < 0 && typeOf _x find "_mil_" < 0) };
private _worldBuildingIndustrial =+ _worldBuildings select { !(typeOf _x find "Land_cmp_" < 0 && typeOf _x find "Land_dp_" < 0 && typeOf _x find "Factory" < 0 && typeOf _x find "Shed" < 0 && typeOf _x find "Barn" < 0 && typeOf _x find "_ind_" < 0) };
private _worldBuildingShacks =+ _worldBuildings select { !(typeOf _x find "Land_d_" < 0 && typeOf _x find "Unfinished" < 0 && typeOf _x find "Land_u_" < 0 && typeOf _x find "Slum" < 0 && typeOf _x find "Barn" < 0) && count (nearestObjects [_x call BIS_fnc_position,["House_F"],80]) < 3 };
private _worldBuildingFuel =+ _worldBuildings select { !(typeOf _x find "fuel" < 0 && typeOf _x find "Land_fs_" < 0) };
private _worldBuildingRuin =+ _worldBuildings select { !(typeOf _x find "ruin" < 0 && typeOf _x find "castle" < 0) };
private _worldBuildingFarm =+ _worldBuildings select { !(typeOf _x find "farm" < 0 && typeOf _x find "shed" < 0) };
private _worldBuildingTowers =+ _worldBuildings select { !(typeOf _x find "Communication" < 0 && typeOf _x find "TTower" < 0) };
private _worldBuildingHouse =+ _worldBuildingTowns;

{
	if !((_x getVariable ["MPSF_Location_Type",""]) isEqualTo "") then {
		private _locationObject = _x;
		private _locationType = _locationObject getVariable ["MPSF_Location_Type","Undefined"];
		private _locationPosition = position _x;
		private _locationBuildings = _worldBuildingTowns select {_x inArea ([_locationPosition,300,300,0,false])};
		private _locationZ = if (_locationType isEqualTo "Air") then { 500 } else { 0 };
		private _locationSize = [100,100];
		{
			if ((typeOf _x) isKindOf "EmptyDetector") exitWith {
				(triggerArea _x) params ["_width","_height","_angle","_area"];
				_locationPosition = position _x;
				_locationSize = [_height,_width];
			};
		} forEach synchronizedObjects _locationObject;

		if (count _locationBuildings > 0) then {
			private _posXmin = 1e10;
			private _posXmax = 0;
			private _posYmin = 1e10;
			private _posYmax = 0;
			{
				private _xPos = _x call BIS_fnc_position;
				_posXmin = _posXmin min (_xPos select 0);
				_posXmax = _posXmax max (_xPos select 0);
				_posYmin = _posYmin min (_xPos select 1);
				_posYmax = _posYmax max (_xPos select 1);
			} foreach _locationBuildings;
			private _posW =  _posXmax - _posXmin;
			private _posH = _posYmax - _posYmin;
			private _posX = _posXmin + _posW / 2;
			private _posY = _posYmin + _posH / 2;
			private _mapPosMax = [_posXmax,_posYmax];
			private _mapPosMin = [_posXmin,_posYmin];
			private _mapPosW = abs ((_mapPosMax select 0) - (_mapPosMin select 0));
			private _mapPosH = abs ((_mapPosMin select 1) - (_mapPosMax select 1));

			_locationPosition = [_posX,_posY];
			_locationSize = [_mapPosW*1.1,_mapPosH*1.1];
		};

		_allAreas pushBack [
			_locationType
			,[_locationPosition select 0,_locationPosition select 1,_locationZ]
			,_locationSize apply {_x max 50}
			,count _locationBuildings
		];
	};
} forEach (allMissionObjects "Logic");

if (count _worldTowns > 0) then {
	diag_log (format["%2 Generating Area Types: %1","World Towns",toUpper worldname]);
	systemChat (format["%2 Generating Area Types: %1","World Towns",toUpper worldname]);

	{
		private _location = _x;
		private _locationType = type _x;
		private _locationPosition = [(locationPosition _x) select 0,(locationPosition _x) select 1,0];
		private _locationSize = [(size _x) select 0,(size _x) select 1,0];
		private _locationBuildings = _worldBuildingTowns select {_x inArea ([_locationPosition,300,300,0,false])};
		_worldBuildingHouse = _worldBuildingHouse - _locationBuildings;
		_worldBuildingShacks = _worldBuildingShacks select {!(_x inArea ([_locationPosition,300,300,0,false]))};

		if (count _locationBuildings > 0) then {
			private _posXmin = 1e10;
			private _posXmax = 0;
			private _posYmin = 1e10;
			private _posYmax = 0;
			{
				private _xPos = _x call BIS_fnc_position;
				_posXmin = _posXmin min (_xPos select 0);
				_posXmax = _posXmax max (_xPos select 0);
				_posYmin = _posYmin min (_xPos select 1);
				_posYmax = _posYmax max (_xPos select 1);
			} foreach _locationBuildings;
			private _posW =  _posXmax - _posXmin;
			private _posH = _posYmax - _posYmin;
			private _posX = _posXmin + _posW / 2;
			private _posY = _posYmin + _posH / 2;
			private _mapPosMax = [_posXmax,_posYmax];
			private _mapPosMin = [_posXmin,_posYmin];
			private _mapPosW = abs ((_mapPosMax select 0) - (_mapPosMin select 0));
			private _mapPosH = abs ((_mapPosMin select 1) - (_mapPosMax select 1));

			_locationPosition = [_posX,_posY];
			_locationSize = [_mapPosW*1.1,_mapPosH*1.1];
		};

		//private _locationSectors = [_locationPosition,_locationSize,_drawMarkers] call MPSF_fnc_getAreaSectors;

		_locationType = switch (true) do {
			case (count _locationBuildings < 1) : {
				switch (true) do {
					case (_locationType == "NameMarine");
					case (surfaceIsWater _locationPosition) : { "" };
					default { "" };
				};
			};
			case (count _locationBuildings < 3) : { "House" };
			case (count _locationBuildings < 35) : { "Village"};
			case (count _locationBuildings < 75) : { "Town" };
			case (count _locationBuildings < 250) : { "City" };
			default { _locationType };
		};

		{
			private _marker = createMarker [format["MPSF_BUILDING_HOUSE_%1%2",_locationType,str (_x call BIS_fnc_netID)],_x call BIS_fnc_position];
			_marker setMarkerShape "ICON";
			_marker setMarkerType "mil_dot";
			_marker setMarkerColor "ColorWhite";
			_marker setMarkerSize [0.5,0.5];
			_marker setMarkerAlpha 0.5;
			//_marker setMarkerText str typeOf _x;
			//_marker setMarkerText format["%1:%2",_buildingClassType,(count _buildingPositions)];
		} forEach _locationBuildings;

		private _locationSectors = [_locationPosition,_locationSize,_drawMarkers] call MPSF_fnc_getAreaSectors;

		if !(_locationType isEqualTo "") then {
			_allAreas pushBack [
				_locationType// + "_" + str (count _locationBuildings) + "_L"
				,_locationPosition
				,_locationSize apply {_x max 50}
				,count _locationBuildings
				,if (count _locationSectors > 10) then {_locationSectors} else {[]}
			];
		};
	} forEach _worldTowns;
};

if (count _worldAreas > 0) then {
	diag_log (format["%2 Generating Area Types: %1","World Areas",toUpper worldname]);
	systemChat (format["%2 Generating Area Types: %1","World Areas",toUpper worldname]);

	{
		private _location = _x;
		private _locationType = type _x;
		private _locationPosition = [(locationPosition _x) select 0,(locationPosition _x) select 1,0];
		private _locationSize = [(size _x) select 0,(size _x) select 1,0];
		private _nearbyAreas = _worldAreas select {(locationPosition _x) inArea ([_locationPosition,320,320,0,false]) && type _x isEqualTo _locationType};
		_worldAreas = _worldAreas - _nearbyAreas;

		if (count _nearbyAreas > 0) then {
			private _posXmin = 1e10;
			private _posXmax = 0;
			private _posYmin = 1e10;
			private _posYmax = 0;
			{
				private _xPos = locationPosition _x;
				_posXmin = _posXmin min (_xPos select 0);
				_posXmax = _posXmax max (_xPos select 0);
				_posYmin = _posYmin min (_xPos select 1);
				_posYmax = _posYmax max (_xPos select 1);
			} foreach _nearbyAreas;
			private _posW =  _posXmax - _posXmin;
			private _posH = _posYmax - _posYmin;
			private _posX = _posXmin + _posW / 2;
			private _posY = _posYmin + _posH / 2;
			private _mapPosMax = [_posXmax,_posYmax];
			private _mapPosMin = [_posXmin,_posYmin];
			private _mapPosW = abs ((_mapPosMax select 0) - (_mapPosMin select 0));
			private _mapPosH = abs ((_mapPosMin select 1) - (_mapPosMax select 1));

			_locationPosition = [_posX,_posY];
			_locationSize = [_mapPosW*1.1,_mapPosH*1.1];
		};

		{
			private _marker = createMarker [format["MPSF_BUILDING_HOUSE_%1%2",_locationType,_x],locationPosition _x];
			_marker setMarkerShape "ICON";
			_marker setMarkerType "mil_dot";
			_marker setMarkerColor "ColorRed";
			_marker setMarkerSize [0.5,0.5];
			_marker setMarkerAlpha 0.5;
			//_marker setMarkerText str typeOf _x;
			//_marker setMarkerText format["%1:%2",_buildingClassType,(count _buildingPositions)];
		} forEach _nearbyAreas;

		_locationType = switch (_locationType) do {
			case "NameMarine" : { "Marina" };
			case "ViewPoint" : { "Hill"};
			case "VegetationVineyard" : { "Farm" };
			default { _locationType };
		};

		if (count _nearbyAreas > 0) then {
			_allAreas pushBack [
				_locationType// + "_" + str (count _locationBuildings) + "_L"
				,_locationPosition
				,_locationSize apply {_x max 50}
				,count _nearbyAreas
				//,[_locationPosition,_sectorWidth,true] call MPSF_fnc_getAreaSector
			];
		};
	} forEach _worldAreas;
};

diag_log (format["%2 Locations: %1 logged over %3m area",count _allAreas,toUpper worldname,worldSize]);
systemChat (format["%2 Locations: %1 logged over %3m area",count _allAreas,toUpper worldname,worldSize]);

if (count _worldBuildingHouse > 0) then {
	diag_log (format["%2 Generating Area Types: %1","World Houses",toUpper worldname]);
	systemChat (format["%2 Generating Area Types: %1","World Houses",toUpper worldname]);
	{
		private _building = _x;
		private _locationPosition = _building call BIS_fnc_position;
		private _locationSize = [300,300];
		private _nearbyHouses = _worldBuildingHouse select {_x inArea ([_locationPosition,300,300,0,false])};
		_worldBuildingHouse = _worldBuildingHouse - _nearbyHouses;
		_worldBuildingShacks = _worldBuildingShacks select {!(_x inArea ([_locationPosition,300,300,0,false]))};

		if (count _nearbyHouses > 0) then {
			private _posXmin = 1e10;
			private _posXmax = 0;
			private _posYmin = 1e10;
			private _posYmax = 0;
			{
				private _xPos = _x call BIS_fnc_position;
				_posXmin = _posXmin min (_xPos select 0);
				_posXmax = _posXmax max (_xPos select 0);
				_posYmin = _posYmin min (_xPos select 1);
				_posYmax = _posYmax max (_xPos select 1);
			} foreach _nearbyHouses;
			private _posW =  _posXmax - _posXmin;
			private _posH = _posYmax - _posYmin;
			private _posX = _posXmin + _posW / 2;
			private _posY = _posYmin + _posH / 2;
			private _mapPosMax = [_posXmax,_posYmax];
			private _mapPosMin = [_posXmin,_posYmin];
			private _mapPosW = abs ((_mapPosMax select 0) - (_mapPosMin select 0));
			private _mapPosH = abs ((_mapPosMin select 1) - (_mapPosMax select 1));

			_locationPosition = [_posX,_posY];
			_locationSize = [_mapPosW*1.1,_mapPosH*1.1];
		};

		_locationType = switch (true) do {
			case (count _nearbyHouses < 1) : { "" };
			case (count _nearbyHouses < 3) : { "House" };
			case (count _nearbyHouses < 35) : { "Village"};
			case (count _nearbyHouses < 75) : { "Town" };
			case (count _nearbyHouses < 250) : { "City" };
			default { "Unknown" };
		};

		{
			private _marker = createMarker [format["MPSF_BUILDING_HOUSE_%1%2",_locationType,str (_x call BIS_fnc_netID)],_x call BIS_fnc_position];
			_marker setMarkerShape "ICON";
			_marker setMarkerType "mil_dot";
			_marker setMarkerColor "ColorWhite";
			_marker setMarkerSize [0.5,0.5];
			_marker setMarkerAlpha 0.5;
			//_marker setMarkerText format["%1:%2",_buildingClassType,(count _buildingPositions)];
		} forEach _nearbyHouses;

		private _locationSectors = [_locationPosition,_locationSize,_drawMarkers] call MPSF_fnc_getAreaSectors;

		if !(_locationType isEqualTo "") then {
			_allAreas pushBack [
				_locationType// + "_" + str (count _nearbyHouses) + "_H"
				,_locationPosition
				,_locationSize apply {_x max 50}
				,count _nearbyHouses
				,if (count _locationSectors > 10) then {_locationSectors} else {[]}
			];
		};
	} forEach _worldBuildingHouse;
};

[_worldBuildingHouse,"House",200,0] call _funcArea;
[_worldBuildingOffice,"Office",150,0] call _funcArea;
[_worldBuildingPiers,"Port",300,4] call _funcArea;
[_worldBuildingMilitary,"Military",300,2] call _funcArea;
[_worldBuildingIndustrial,"Industrial",200,4] call _funcArea;
[_worldBuildingShacks,"Shack",100,0] call _funcArea;
[_worldBuildingReligion,"Religious",100,0] call _funcArea;
[_worldBuildingFuel,"Fuel",100,0] call _funcArea;
[_worldBuildingRuin,"Ruin",100,0] call _funcArea;
[_worldBuildingFarm,"Farm",100,0] call _funcArea;
[_worldBuildingTowers,"Tower",100,0] call _funcArea;

{
	_allAreas pushBack ["Air",[_x select 0,_x select 1,500],[1,1],0];
} forEach [
	[0,0],[worldSize/2,0],[worldSize,0]
	,[0,worldSize/2],[worldSize,worldSize/2]
	,[0,worldSize],[worldSize/2,worldSize],[worldSize,worldSize]
];

{
	_x params ["_sectorID","_sectorPosition","_sectorOrientation","_sectorShape","_sectorIsWater","_sectorCorners"];

	diag_log (format["%2 Generating Terrain in %1",_sectorID,toUpper worldname]);
	systemChat (format["%2 Generating Terrain in %1",_sectorID,toUpper worldname]);
	// Get Terrain
	{
		_x pushBack _sectorID;
		_allAreas pushBack _x;
	} forEach ([_sectorPosition,_sectorOrientation,true] call MPSF_fnc_getMapTerrain);

	diag_log (format["%2 Generating Roads in %1",_sectorID,toUpper worldname]);
	systemChat (format["%2 Generating Roads in %1",_sectorID,toUpper worldname]);
	// Get Roads
	{
		_x set [0,format["%1_%2","RoadSegment",count _roads]];
		_x pushBack _sectorID;
		_roads pushBack _x;
	} forEach ([_sectorPosition,_sectorOrientation,_drawMarkers] call MPSF_fnc_getMapRoads);
} forEach _sectors;

_allAreas sort true;


diag_log (format["%2 Cleaning Areas: %1 logged over %3m area",count _allAreas,toUpper worldname,worldSize]);
systemChat (format["%2 Cleaning Areas: %1 logged over %3m area",count _allAreas,toUpper worldname,worldSize]);
{
	private _locationData = _x;
	_locationData params ["_locationType","_locationPosition","_locationSize","_locationBuildings",["_locationSectors",[]]];

	private _locationID = format["%1_%2",_locationType,_forEachIndex];

	_allAreas set [_forEachIndex,[
		_locationID
		,_locationPosition
		,_locationSize
		,_locationType
		,[_locationPosition,_sectorWidth,true] call MPSF_fnc_getAreaSector
		,_locationBuildings
		,if (count _locationSectors > 5) then { _locationSectors } else { [] }
	]];
} forEach _allAreas;

diag_log (format["%2 Areas: %1 logged over %3m area",count _allAreas,toUpper worldname,worldSize]);
systemChat (format["%2 Areas: %1 logged over %3m area",count _allAreas,toUpper worldname,worldSize]);

diag_log (format["%2 Road Segments: %1 logged over %3m area",count _roads,toUpper worldname,worldSize]);
systemChat (format["%2 Road Segments: %1 logged over %3m area",count _roads,toUpper worldname,worldSize]);

// Draw Locations
if (_drawMarkers) then {
	{
		private _markerColour = switch (_x select 3) do {
			case "City" : { "colorPink"; };
			case "Town" : { "colorPink"; };
			case "Village";
			case "House";
			case "Farm" : { "colorOrange"; };
			case "Office" : { "colorBlack"; };
			case "Port" : { "colorBLUFOR"; };
			case "Military" : { "colorOPFOR"; };
			case "Industrial" : { "colorBlue"; };
			case "Hill";
			case "Forest" : { "colorIndependent"; };
			case "Clearing" : { "colorBrown"; };
			case "Shack" : { "colorGrey" };
			default {"ColorWhite"};
		};

		private _marker = createMarker [format["MPSF_LOCATION_%1_1",_forEachIndex],(_x select 1)];
		_marker setMarkerShape "RECTANGLE";
		_marker setMarkerBrush "SolidBorder";
		_marker setMarkerColor _markerColour;
		_marker setMarkerAlpha 0.2;
		_marker setMarkerSize [((_x select 2) select 0)/2,((_x select 2) select 1)/2];

		private _marker = createMarker [format["MPSF_LOCATION_%1_2",_forEachIndex],(_x select 1)];
		_marker setMarkerShape "ICON";
		_marker setMarkerType "mil_dot";
		_marker setMarkerColor _markerColour;
		_marker setMarkerText (_x select 0);
		_marker setMarkerSize [1,1];
	} forEach _allAreas;
};

private _br = tostring [13,10];
private _tab = tostring [9];
private _tab2 = _tab + _tab;
private _tab3 = _tab + _tab2;
private _tab4 = _tab + _tab3;
private _tab5 = _tab + _tab4;
private _tab6 = _tab + _tab5;
private _tab7 = _tab + _tab6;

private _export = "/*" + _br;
_export = _export + _tab + "CfgMissionData Generator" + _br;
_export = _export + _tab + "Contributor: " + (profileName) + _br;
_export = _export + _tab + "World: " + worldName + _br;
_export = _export + "*/" + _br + _br;

// Export Data - Begin Compile
_export = _export + format ["class %1 {",worldName] + _br;

// Export Data - Map Sectors
if (count _sectors > 0) then {
	_export = _export + _tab + "class Sectors {" + _br;
	_export = _export + _tab2 + format ["radius = %1;",_sectorWidth] + _br;
	{
		_x params ["_sectorID","_sectorPosition","_sectorOrientation","_sectorShape","_sectorIsWater","_sectorCorners"];
		private _areaParams = [_sectorPosition,(_sectorOrientation select 0),(_sectorOrientation select 1),0,true];

		_export = _export + _tab2 + format ["class %1 {",_sectorID] + _br;
		_export = _export + _tab3 + format ["position[] = {%1};",_sectorPosition joinString ","] + _br;
		_export = _export + _tab3 + format ["orientation[] = {%1};",_sectorOrientation joinString ","] + _br;
		_export = _export + _tab3 + format ["isWater = %1;",if (_sectorIsWater) then { 1 } else { 0 }] + _br;

		private _sectorTypeFlags = [];
		private _sectorAreas = [];
		{
			_x params [
				["_areaID","",[""]]
				,["_areaPosition",[0,0,0],[[]]]
				,["_areaOrientation",[0,0,0],[[]]]
				,["_areaClass","",[""]]
				,["_areaSector","",[""]]
				,["_areaBuildings",0,[0]]
				,["_areaSectors",[],[[]]]
			];
			if (_areaSector isEqualTo _sectorID) then {
				_sectorTypeFlags pushBackUnique str _areaClass;
				_sectorAreas pushBackUnique str _areaID;
			};
		} forEach _allAreas;

		if (count _sectorTypeFlags > 0) then {
			_export = _export + _tab3 + format ["typeFlags[] = {%1};",(_sectorTypeFlags joinString ",")] + _br;
		};
		if (count _sectorAreas > 0) then {
			_export = _export + _tab3 + format ["areas[] = {%1};",(_sectorAreas joinString ",")] + _br;
		};

		private _sectorRoads = [];
		{
			_x params [
				["_roadID","",[""]]
				,["_roadPosition",[0,0,0],[[]]]
				,["_roadDir",0,[0]]
				,["_roadSector","",[""]]
			];
			if (_roadSector isEqualTo _sectorID) then {
				_sectorRoads pushBackUnique str _roadID;
			};
		} forEach _roads;
		if (count _sectorRoads > 0) then {
			_export = _export + _tab3 + format ["roads[] = {%1};",(_sectorRoads joinString ",")] + _br;
		};
		_export = _export + _tab2 + "};" + _br;
		systemChat (format["Exporting %1 of %2 Sectors",_forEachIndex,count _sectors]);
	} forEach (_sectors);
	_export = _export + _tab + "};" + _br;
};

// Export Data - Map Sectors
if (count _allAreas > 0) then {
	_export = _export + _tab + "class Areas {" + _br;
	{
		diag_log str _x;
		_x params [
			["_areaID","",[""]]
			,["_areaPosition",[0,0,0],[[]]]
			,["_areaOrientation",[0,0,0],[[]]]
			,["_areaClass","",[""]]
			,["_areaSector","",[""]]
			,["_areaBuildings",0,[0]]
			,["_areaSectors",[],[[]]]
		];
		_export = _export + _tab2 + format ["class %1 {",_areaID] + _br;
		_export = _export + _tab3 + format ["position[] = {%1};",_areaPosition joinString ","] + _br;
		_export = _export + _tab3 + format ["orientation[] = {%1};",_areaOrientation joinString ","] + _br;
		_export = _export + _tab3 + format ["type = %1;",str _areaClass] + _br;
		_export = _export + _tab3 + format ["sector = %1;",str _areaSector] + _br;
		if (_areaBuildings > 0) then {
			_export = _export + _tab3 + format ["buildings = %1;",_areaBuildings] + _br;
		};
		if (count _areaSectors > 0) then {
			_export = _export + _tab3 + "class AreaSectors {" + _br;
			{
				_x params ["_subSectorID","_subSectorPos"];
				_export = _export + _tab4 + format ["%1[] = {%2};",_subSectorID,_subSectorPos joinString ","] + _br;
			} forEach _areaSectors;
			_export = _export + _tab3 + "};" + _br;
		};
		/*if (count _areaBuildings > 0) then {
			{
				_areaBuildings set [_foreachIndex,format ["{%1}",[
					format ["{%1}",(_x select 0) joinString ","]
					,str (_x select 1)
					,str (_x select 2)
				] joinString ","]];
			} forEach _areaBuildings;
			_export = _export + _tab3 + format ["buildings[] = {%1};",_areaBuildings joinString ","] + _br;
		};*/
		_export = _export + _tab2 + "};" + _br;
		systemChat (format["Exporting %1 of %2 Areas",_forEachIndex,count _allAreas]);
	} forEach _allAreas;
	_export = _export + _tab + "};" + _br;
};

// Export Data - Roads
if (count _roads > 0) then {
	_export = _export + _tab + "class Roads {" + _br;
	{
		_x params [
			["_roadID","",[""]]
			,["_roadPosition",[0,0,0],[[]]]
			,["_roadDir",0,[0]]
			,["_roadSector","",[""]]
		];
		_export = _export + _tab2 + format ["class %1 {",_roadID] + _br;
		_export = _export + _tab3 + format ["position[] = {%1};",_roadPosition joinString ","] + _br;
		_export = _export + _tab3 + format ["direction = %1;",_roadDir] + _br;
		_export = _export + _tab3 + format ["sector = %1;",str _roadSector] + _br;
		_export = _export + _tab2 + "};" + _br;
		systemChat (format["Exporting %1 of %2 Roads",_forEachIndex,count _roads]);
	} forEach _roads;
	_export = _export + _tab + "};" + _br;
};

_export = _export + "};" + _br;
// Export Data - End Compile

missionNamespace setVariable ["MPSF_Developer_MapData",_export];

diag_log format["Exporting CfgMissionData Output for %1",toUpper str(worldName)];
systemChat format["Exporting CfgMissionData Output for %1",toUpper str(worldName)];

copyToClipboard _export;
_lines = { _x IN [10] } count toArray(_export);

diag_log format["Processed CfgMissionData Output for %1 with %2 Lines",toUpper str(worldName),_lines];
systemChat format["Processed CfgMissionData Output for %1 with %2 Lines",toUpper str(worldName),_lines];

systemChat format ["CfgMissionData: %1 Exported to Clipboard",worldName];