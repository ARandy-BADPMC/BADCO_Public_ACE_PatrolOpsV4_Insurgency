#define MISSIONTIME			(if (isMultiplayer) then {serverTime} else {time})
#define DEFAULTAREASIZE		1000

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
// Zone Areas
	case "createZoneArea" : {
		_params params [["_position",[],[[]]],["_radius",0,[0]]];
		if (count _position == 0) exitWith { [] };
		if (_radius == 0) exitWith { [] };
	};
	case "getZoneBuildings" : {
		_params params [["_position",[0,0,0],[[]]],["_orientation",[0,0,0],[[]]],["_drawMarkers",false,[false]]];

		private _areaParams = [_position,(_orientation select 0)/2,(_orientation select 1)/2,0,true];
		private _radius = ((((_orientation select 0)*2) * sin 45) max (((_orientation select 1)*2) * cos 45));
		private _subSectors = [];
		{
			private _buildingPosition = _x modelToWorld [0,0,0];
			_buildingPosition set [2,0];
			if (_buildingPosition inArea _areaParams) then {
				private _buildingSector = ["getArea",[_buildingPosition,100,false]] call PO4_fnc_zones;
				_buildingSector params ["_sectorID","_sectorPos","_sectorWidth"];
				_subSectors pushBackUnique [_sectorID,_sectorPos];
			};
		} forEach (nearestObjects [_position,["House_F"],_radius]);

		if (_drawMarkers && count _subSectors > 5) then {
			{
				_x params ["_sectorID","_sectorPos"];
				private _sectorMarker = createMarker [format["%1",_sectorID],_sectorPos];
				_sectorMarker setMarkerShape "RECTANGLE";
				_sectorMarker setMarkerBrush "SolidBorder";
				_sectorMarker setMarkerColor "ColorOPFOR";
				_sectorMarker setMarkerSize ([100/2.1,100/2.1]);
				_sectorMarker setMarkerAlpha 0.1;
			} forEach _subSectors;
		};

		_subSectors;
	};
	case "getZoneAreas" : {
		_params params [["_position",[0,0,0],[[]]],["_orientation",[0,0,0],[[]]],["_drawMarkers",false,[false]]];
		_position params ["_centerX","_centerY"];
		_orientation params ["_sizeX","_sizeY",["_sizeW",DEFAULTAREASIZE]];

		private _posXMin = _centerX - (_sizeX/2);
		private _posXMax = _centerX + (_sizeX/2);
		private _posYMin = _centerY - (_sizeY/2);
		private _posYMax = _centerY + (_sizeY/2);

		private _sectorPosition = [_posXMin,_posYMin];
		private _sectors = [];
		for "_gridY" from (_posYMin) to (_posYMax) step (_sizeW) do {
			_sectorPosition set [0,_posXMin/2];
			_sectorPosition set [1,_gridY];
			for "_gridX" from (_posXMin) to (_posXMax) step (_sizeW) do {
				_sectorPosition set [0,_gridX];
				private _sectorData = ["getArea",[_sectorPosition,_sizeW,false]] call PO4_fnc_zones;
				_sectorData params ["_sectorID","_sectorPosition","_sectorSize"];
				private _sectorBorders = ["getAreaBorders",[_sectorPosition,_sizeW]] call PO4_fnc_zones;
				if (
					{!(surfaceIsWater _x)} count _sectorBorders > 0
					&& !(surfaceIsWater _sectorPosition)
				) then {
					// Record Sector
					_sectors pushBack [
						_sectorID
						,[(_sectorPosition select 0),(_sectorPosition select 1),0]
						,[_sizeW/2,_sizeW/2,0]
						,1
						,surfaceIsWater _sectorPosition
						,{!(surfaceIsWater _x)} count _sectorBorders
					];
					// Draw Sector
					if (_drawMarkers) then {
						private _sector = createMarker [format["%1",_sectorID],_sectorPosition];
						_sector setMarkerShape "RECTANGLE";
						_sector setMarkerBrush "SolidBorder";
						_sector setMarkerColor "ColorBlack";
						_sector setMarkerSize [_sizeW/2.1,_sizeW/2.1];
						_sector setMarkerAlpha 0.1;
					};
				};
			};
		};
		_sectors;
	};
	case "getAreaBorders" : {
		_params params [["_areaPos",[0,0],[[]]],["_areaSize",100,[0,[]]]];
		if !(typeName _areaSize == typeName []) then { _areaSize = [_areaSize,_areaSize]; };
		_areaSize = [(_areaSize select 0)/2,(_areaSize select 1)/2];
		private _posSW = [(_areaPos select 0) - (_areaSize select 0),(_areaPos select 1) - (_areaSize select 1)];
		private _posNW = [(_areaPos select 0) - (_areaSize select 0),(_areaPos select 1) + (_areaSize select 1)];
		private _posNE = [(_areaPos select 0) + (_areaSize select 0),(_areaPos select 1) + (_areaSize select 1)];
		private _posSE = [(_areaPos select 0) + (_areaSize select 0),(_areaPos select 1) - (_areaSize select 1)];
		[_posSW,_posNW,_posNE,_posSE];
	};
// Sectors
	case "createSectorArea" : {
		_params params [["_sectorID","",[""]],["_areaPos",[0,0,0],[[]]],["_areaOrientation",[0,0,0],[[]]]];
		_areaOrientation params ["_areaSizeX","_areaSizeY","_areaDir"];
		createMarker [_sectorID,_areaPos];
		_sectorID setMarkerShape "RECTANGLE";
		_sectorID setMarkerBrush "Border";
		_sectorID setMarkerColor "ColorIndependent";
		_sectorID setMarkerSize [_areaSizeX,_areaSizeY];
		_sectorID setMarkerAlpha 0.1;
		_sectorID
	};
	case "removeSectorArea" : {
		_params params [["_sectorID","",[""]]];
		deleteMarker _sectorID;
		["removeSectorEncounters",[_sectorID]] call PO4_fnc_zones;
		true;
	};
	case "getSectorID" : {
		_params params [["_position",[0,0,0],[[]]],["_size",0,[0]],["_resolve",true,[false]]];
		if (_size isEqualTo 0) then { _size = 100; };
		private _posX = (floor((_position select 0)/_size)*_size) + (_size/2);
		private _posY = (floor((_position select 1)/_size)*_size) + (_size/2);
		private _sectorID = format["sector_%1%2",
			switch (count toarray str _posX) do {
				case 1 : { format ["000%1",_posX] };
				case 2 : { format ["00%1",_posX] };
				case 3 : { format ["0%1",_posX] };
				default { format ["%1",_posX] };
			},switch (count toarray str _posY) do {
				case 1 : { format ["000%1",_posY] };
				case 2 : { format ["00%1",_posY] };
				case 3 : { format ["0%1",_posY] };
				default { format ["%1",_posY] };
			}
		];
		if (_resolve) then {
			_sectorID;
		} else {
			[_sectorID,[_posX,_posY,0],_size];
		};
	};
	case "getSectorActiveState" : {
		_params params [["_sectorID","",[""]]];
		missionNamespace getVariable [format["PO4_%1_active",_sectorID],false];
	};
	case "getSectorState" : {
		_params params [["_sectorID","",[[],""]],["_resolve",false,[false]]];
		private _state = abs(["coloropfor","colorindependent","colorblufor"] find markerColor _sectorID);
		if (_resolve) then { _state = ["hostile","neutral","friendly"] select _state; };
		_state;
	};
	case "setSectorActiveState" : {
		_params params [["_sectorID","",[""]],["_state",false,[false]]];
		private _var = format ["PO4_%1_active",_sectorID];
		if (_state) then {
			missionNamespace setVariable [_var,_state];
		} else {
			missionNamespace setVariable [_var,nil];
		};
		publicVariable _var;
		true;
	};
	case "setSectorState" : {
		_params params [["_sectorID","",[[],""]],["_state",0,["",0]]];
		if !(_state isEqualType 0) then { _state = abs(["hostile","neutral","friendly"] find toLower _state); };
		_sectorID setMarkerColor (["coloropfor","colorindependent","colorblufor"] select _state);
		true
	};
	case "isSectorHostile" : {
		_params params [["_sectorID","",[[],""]],["_types",[0],[[]]]];
		(["getSectorState",[_sectorID,false]] call PO4_fnc_zones) in _types;
	};
// Functions
	case "isNearRespawnPoints" : {
		_params params ["_position","_radius"];
		private _side = ["side","FactionTypeBLU"] call MPSF_fnc_getCfgFaction;
		count (([_side] call BIS_fnc_getRespawnMarkers) select {getMarkerPos _x distance2D _position <= _radius}) > 0;
	};
// Initilise
	case "postInit";
	case "init" : {
		if (isServer) then {
			{
				private _sectorID = _x;
				private _sectorPos = ["sectorPosition",[_sectorID]] call MPSF_fnc_getCfgMapData;
				private _sectorSize = ["sectorSize",[_sectorID]] call MPSF_fnc_getCfgMapData;
				private _areaID = ["createSectorArea",[_sectorID,_sectorPos,_sectorSize]] call PO4_fnc_zones;
				switch (true) do {
					case (["isNearRespawnPoints",[_sectorPos,worldSize*0.1]] call PO4_fnc_zones) : {
						["setSectorState",[_areaID,2]] call PO4_fnc_zones;
					};
					case (["isNearRespawnPoints",[_sectorPos,worldSize*0.35]] call PO4_fnc_zones) : {
						["setSectorState",[_areaID,1]] call PO4_fnc_zones;
					};
					default {
						["setSectorState",[_areaID,0]] call PO4_fnc_zones;
					};
				};
			} forEach (["sectors"] call MPSF_fnc_getCfgMapData);
		};
		true;
	};
// Debug
	case "debug_encounter_areas": {
		private _encounterIDs = (["taskIDs"] call MPSF_fnc_getCfgTasks) select { (["CfgMissionTasks",_x,"typeID"] call MPSF_fnc_getCfgDataNumber) in [1]};
		private _areaIDs = ["areas"] call MPSF_fnc_getCfgMapData;

		private _encounters = _encounterIDs apply { [_x,(["getCfgEncounterAreaTypes",[_x]] call PO4_fnc_encounters) apply {toLower _x}]; };
		private _areas = _areaIDs apply { [_x,toLower(["getAreaType",[_x]] call MPSF_fnc_getCfgMapData)]; };

		private _return = [];
		for "_iE" from 0 to (count _encounters - 1) do {
			private _encounter = _encounters select _iE;
			for "_iA" from 0 to (count _areaIDs - 1) do {
				private _area = _areas select _iA;
				if (count ((_encounter select 1) arrayIntersect _area) > 0) then {
					_return pushBackUnique [_encounter select 0,_area select 0];
				};
			};
		};

		{
			_x params ["_encounterID","_areaID"];

			private _areaPos = ["getAreaPosition",[_areaID]] call MPSF_fnc_getCfgMapData;
			private _areaType = ["getAreaType",[_areaID]] call MPSF_fnc_getCfgMapData;
			private _markerID = _areaID + str _forEachIndex;

			createMarkerLocal [_markerID,_areaPos];
			_markerID setMarkerShapeLocal "ICON";
			_markerID setMarkerTextLocal _encounterID;
			_markerID setMarkerSizeLocal [1,1];
			_markerID setMarkerAlphaLocal 0.8;
			switch (toLower _areaType) do {
				case "military" : { _markerID setMarkerTypeLocal "loc_Bunker"; _markerID setMarkerColorLocal "ColorOpfor"; };
				case "village" : { _markerID setMarkerTypeLocal "loc_Stack"; _markerID setMarkerColorLocal "ColorYellow"; };
				case "town" : { _markerID setMarkerTypeLocal "loc_Tourism"; _markerID setMarkerColorLocal "ColorOrange"; };
				case "house" : { _markerID setMarkerTypeLocal "loc_Cross"; _markerID setMarkerColorLocal "Colorblufor"; };
				case "airport" : { _markerID setMarkerTypeLocal "c_plane"; _markerID setMarkerColorLocal "Colorblufor"; };
				case "factory" : { _markerID setMarkerTypeLocal "loc_Power"; _markerID setMarkerColorLocal "Colorblufor"; };
				case "ruin" : { _markerID setMarkerTypeLocal "loc_ruin"; _markerID setMarkerColorLocal "Colorblack"; };
				case "forest" : { _markerID setMarkerTypeLocal "loc_Tree"; _markerID setMarkerColorLocal "ColorGreen"; };
				case "clearing" : { _markerID setMarkerTypeLocal "loc_Bush"; _markerID setMarkerColorLocal "colorIndependent"; };
				default { _markerID setMarkerTypeLocal "mil_dot"; _markerID setMarkerColorLocal "ColorBlack"; };
			};
		} forEach _return;
	};
	case "debug_drawLocations" : {
		//["debug_drawLocations"] call BIS_fnc_logFormat;
		/* Create Sectors */
		private _sectors = ["sectors"] call MPSF_fnc_getCfgMapData;
		{
			private _sectorID = _x;
			private _sectorPos = ["sectorPosition",[_sectorID]] call MPSF_fnc_getCfgMapData;
			private _sectorSize = ["sectorSize",[_sectorID]] call MPSF_fnc_getCfgMapData;

			createMarkerLocal [_sectorID,_sectorPos];
			_sectorID setMarkerShapeLocal "RECTANGLE";
			_sectorID setMarkerBrushLocal "SolidBorder";
			_sectorID setMarkerColorLocal "ColorOpfor";
			_sectorID setMarkerSizeLocal [(_sectorSize select 0)*0.95,(_sectorSize select 1)*0.95];
			_sectorID setMarkerAlphaLocal 0.1;
		} forEach _sectors;

		/* Create Locations */
		["debug_drawAreas",[["areas"] call MPSF_fnc_getCfgMapData]] call PO4_fnc_encounters;
	};
	case "debug_drawAreas" : {
		_params params [["_areaIDs",[],[[]]]];
		{
			private _areaID = _x;
			private _areaPos = ["getAreaPosition",[_areaID]] call MPSF_fnc_getCfgMapData;
			private _areaOri = ["getAreaOrientation",[_areaID]] call MPSF_fnc_getCfgMapData;
			private _areaType = ["getAreaType",[_areaID]] call MPSF_fnc_getCfgMapData;
			private _markerColour = switch (_areaType) do {
				case "city" : { "colorPink"; };
				case "town" : { "colorPink"; };
				case "village";
				case "house";
				case "farm" : { "colorOrange"; };
				case "office" : { "colorBlack"; };
				case "port" : { "colorBLUFOR"; };
				case "military" : { "colorOPFOR"; };
				case "industrial" : { "colorBlue"; };
				case "hill";
				case "trees";
				case "forest" : { "colorIndependent"; };
				case "clearing" : { "colorBrown"; };
				case "shack" : { "colorGrey" };
				default {"ColorWhite"};
			};

			private _marker = createMarker [format["MPSF_LOCATION_%1_1",_forEachIndex],_areaPos];
			_marker setMarkerShape "RECTANGLE";
			_marker setMarkerBrush "SolidBorder";
			_marker setMarkerColor _markerColour;
			_marker setMarkerAlpha 0.2;
			_marker setMarkerSize [(_areaOri select 0)/2,(_areaOri select 1)/2];

			private _marker = createMarker [format["MPSF_LOCATION_%1_2",_forEachIndex],_areaPos];
			_marker setMarkerShape "ICON";
			_marker setMarkerType "mil_dot";
			_marker setMarkerColor _markerColour;
			_marker setMarkerText (_areaID + "_" + _areaType);
			_marker setMarkerAlpha 0.5;
			_marker setMarkerSize [1,1];
		} forEach _areaIDs;
	};
};
