/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getCfgMapData.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Return predefined map data
*/
params [["_dataType","",[""]],["_params",[],[[]]]];

if !(isClass(missionConfigFile >> "CfgMissionFramework" >> "MapData" >> worldName)) exitWith {
	//["Unable to find mapdata for %1",toUpper worldName] call BIS_fnc_error;
	false;
};
private _cfgMapData = missionConfigFile >> "CfgMissionFramework" >> "MapData" >> worldName;

switch (_dataType) do {
// SECTORS
	case "getSectorSize" : {
		getNumber(_cfgMapData >> "Sectors" >> "radius");
	};
	case "sectors" : {
		_params params [["_resolve",false,[false]]];
		private _cfgSectors = ("isClass _x" configClasses (_cfgMapData >> "Sectors"));
		private _sectors = [];
		{
			if (_resolve) then {
				_sectors pushBack (["sector",[configName _x]] call MPSF_fnc_getCfgMapData);
			} else {
				_sectors pushBack configName _x;
			};
		} forEach _cfgSectors;
		_sectors;
	};
	case "sector" : {
		_params params [["_sectorID","",[""]]];
		private _cfgSector = _cfgMapData >> "Sectors" >> _sectorID;
		if !(isClass(_cfgSector)) exitWith { [] };
		[
			configName _cfgSector
			,getArray(_cfgSector >> "position")
			,getArray(_cfgSector >> "orientation")
			,getNumber(_cfgSector >> "rectangle")
			,getArray(_cfgSector >> "typeFlags")
			,getArray(_cfgSector >> "areas")
			,getNumber(_cfgSector >> "isWater") == 1
		]
	};
	case "sectorPosition" : {
		_params params [["_sectorID","",["",[]]]];
		if !(typeName _sectorID isEqualTo typeName "") then {
			_sectorID = ["getCurrentSector",[_sectorID]] call MPSF_fnc_getCfgMapData;
		};
		private _cfgSector = _cfgMapData >> "Sectors" >> _sectorID;
		if !(isClass(_cfgSector)) exitWith { [0,0,0] };
		getArray(_cfgSector >> "position");
	};
	case "sectorSize" : {
		_params params [["_sectorID","",[""]]];
		private _cfgSector = _cfgMapData >> "Sectors" >> _sectorID;
		if !(isClass(_cfgSector)) exitWith { [0,0,0] };
		getArray(_cfgSector >> "orientation");
	};
	case "sectorAreas" : {
		_params params [["_sectorID","",[""]],["_resolve",false,[false]]];
		private _sectorAreas = ["CfgMissionFramework","MapData",worldName,"Sectors",_sectorID,"areas"] call MPSF_fnc_getCfgDataArray;
		if (_resolve) then {
			_sectorAreas = _sectorAreas apply { ["getAreaData",[_x]] call MPSF_fnc_getCfgMapData; };
		};
		_sectorAreas
	};
	case "sectorTypes" : {
		_params params [["_sectorID","",[""]]];
		["CfgMissionFramework","MapData",worldName,"Sectors",_sectorID,"typeFlags"] call MPSF_fnc_getCfgDataArray;
	};
	case "isSectorWater" : {
		_params params [["_sectorID","",[""]]];
		private _cfgSector = _cfgMapData >> "Sectors" >> _sectorID;
		if !(isClass(_cfgSector)) exitWith { [0,0,0] };
		(_cfgSector >> "isWater") call MPSF_fnc_getCfgDataBool;
	};
	case "hasSectorAreaType" : {
		_params params [["_sectorID","",[""]],["_areaTypes",[],[[]]]];
		private _cfgSector = _cfgMapData >> "Sectors" >> _sectorID;
		if !(isClass(_cfgSector)) exitWith {false};
		private _sectorAreas = ["sectorTypes",[_sectorID]] call MPSF_fnc_getCfgMapData;
		_sectorAreas apply {toLower _x};
		_areaTypes apply {toLower _x};
		count (_areaTypes arrayIntersect _sectorAreas) > 0
	};
	case "getCurrentSector" : {
		_params params [["_position",[0,0,0],[[]]],["_resolve",false,[false]],["_size",0,[0]]];
		if (_size isEqualTo 0) then { _size = ["getSectorSize"] call MPSF_fnc_getCfgMapData; };
		private _posX = (floor((_position select 0)/_size)*_size) + (_size/2);
		private _posY = (floor((_position select 1)/_size)*_size) + (_size/2);
		private _sectorID = format["sector_%1%2",
			switch (count toarray str _posX) do {
				case 1 : { format ["000%1",_posX] };
				case 2 : { format ["00%1",_posX] };
				case 3 : { format ["0%1",_posX] };
				default { format ["%1",_posX] };
			},
			switch (count toarray str _posY) do {
				case 1 : { format ["000%1",_posY] };
				case 2 : { format ["00%1",_posY] };
				case 3 : { format ["0%1",_posY] };
				default { format ["%1",_posY] };
			}
		];
		if (_resolve) then { [_sectorID,[_posX,_posY],_size]; } else { _sectorID; };
	};
	case "getNearbySectors" : {
		_params params [["_position",[0,0,0],[[]]],["_radius",0,[0]],["_resolve",false,[false]]];

		(["getCurrentSector",[_position,true]] call MPSF_fnc_getCfgMapData) params ["_sectorCurrent","_sectorPosition","_sectorWidth"];
		private _xMin = (_sectorPosition select 0) - (_sectorWidth max _radius);
		private _xMax = (_sectorPosition select 0) + (_sectorWidth max _radius);
		private _yMin = (_sectorPosition select 1) - (_sectorWidth max _radius);
		private _yMax = (_sectorPosition select 1) + (_sectorWidth max _radius);
		private _sectors = ["sectors"] call MPSF_fnc_getCfgMapData;
		private _nearSectors = [];

		for "_gridY" from _yMin to _yMax step _sectorWidth do {
			for "_gridX" from _xMin to _xMax step _sectorWidth do {
				(["getCurrentSector",[[_gridX,_gridY],true]] call MPSF_fnc_getCfgMapData) params ["_sectorID","_sectorPos","_sectorWidth"];
				if ([_gridX,_gridY] distance _position <= (_sectorWidth max _radius)) then {
					if (_sectorID IN _sectors) then {
						_nearSectors pushBackUnique _sectorID;
					};
				};
			};
		};

		if (_resolve && count _nearSectors > 0) then { _nearSectors = selectRandom _nearSectors; }; // TODO: Update resolve to APPLY

		_nearSectors;
	};
	case "getSectorAreas" : {
		_params params [["_sectorID","",[""]]];
		["CfgMissionFramework","MapData",worldName,"sectors",_sectorID,"areas"] call MPSF_fnc_getCfgDataArray;
	};
// AREAS
	case "getNearbyAreas" : {
		_params params [["_position",[0,0,0],["",[]]],["_types",[],["",[]]],["_radius",0,[0]],["_resolve",false,[false]]];
		if (typeName _position isEqualTo typeName "") then { _position = ["sectorPosition",[_position]] call MPSF_fnc_getCfgMapData; };
		if (typeName _types isEqualTo typeName "") then { _types = [_types]; };

		private _nearbySectors = ["getNearbySectors",[_position,_radius,false]] call MPSF_fnc_getCfgMapData;
		if (count _nearbySectors == 0) exitWith { [] };

		private _sectorAreas = [];
		{ _sectorAreas append (["getSectorAreas",[_x]] call MPSF_fnc_getCfgMapData); } forEach _nearbySectors;
		if (count _sectorAreas == 0) exitWith { [] };
		if (count _types > 0) then {
			_sectorAreas = _sectorAreas select { toLower(["getAreaType",[_x]] call MPSF_fnc_getCfgMapData) in (_types apply {toLower _x}) };
		};
		_sectorAreas
	};
	case "areas" : {
		_params params [["_types",[],["",[]]],["_resolve",false,[false]]];
		if !(_types isEqualType []) then { _types = [_types]; };
		private _areas = ["CfgMissionFramework","MapData",worldName,"Areas"] call BIS_fnc_getCfgSubClasses;
		if (count _types > 0) then {_areas = _areas select { toLower (["getAreaType",[_x]] call MPSF_fnc_getCfgMapData) in (_types apply {toLower _x}) }; };
		if (_resolve) then { _areas = _areas apply {["getAreaData",[_x]] call MPSF_fnc_getCfgMapData}; };
		_areas
	};
	case "area" : {
		_params params [["_areaID","",[""]]];
		private _cfgArea = ["CfgMissionFramework","MapData",worldName,"Areas",_areaID] call BIS_fnc_getCfg;
		private _areaData = [
			_areaID
			,(_cfgArea >> "position") call MPSF_fnc_getCfgDataArray
			,(_cfgArea >> "orientation") call MPSF_fnc_getCfgDataArray
			,(_cfgArea >> "type") call MPSF_fnc_getCfgDataText
			,(_cfgArea >> "sector") call MPSF_fnc_getCfgDataText
			,((_cfgArea >> "buildings") call MPSF_fnc_getCfgDataNumber) max 0
		];
		if (isClass(_cfgArea >> "AreaSectors")) then {
			private _subSectors = [];
			{
				_subSectors pushBackUnique [configName _x,getArray(_x)];
			} forEach (configProperties [_cfgArea >> "AreaSectors","isArray _x",true]);
			_areaData pushBack _subSectors;
		};
		_areaData
	};
	case "getAreaData" : {
		_params params [["_areaID","",[""]]];
		[
			_areaID
			,["getAreaPosition",[_areaID]] call MPSF_fnc_getCfgMapData
			,["getAreaOrientation",[_areaID]] call MPSF_fnc_getCfgMapData
			,["getAreaType",[_areaID]] call MPSF_fnc_getCfgMapData
		]
	};
	case "getAreaPosition" : {
		_params params [["_areaID","",[""]]];
		["CfgMissionFramework","MapData",worldName,"Areas",_areaID,"position"] call MPSF_fnc_getCfgDataArray;
	};
	case "getAreaOrientation" : {
		_params params [["_areaID","",[""]]];
		getArray(_cfgMapData >> "Areas" >> _areaID >> "orientation");
	};
	case "getAreaType" : {
		_params params [["_areaID","",[""]]];
		toLower (["CfgMissionFramework","MapData",worldName,"Areas",_areaID,"type"] call MPSF_fnc_getCfgDataText);
	};
	case "getAreaBuildingCount" : {
		_params params [["_areaID","",[""]]];
		(["CfgMissionFramework","MapData",worldName,"Areas",_areaID,"buildings"] call MPSF_fnc_getCfgDataNumber) max 0;
	};
	case "areaHasSectors" : {
		_params params [["_areaID","",[""]]];
		private _cfgArea = _cfgMapData >> "Areas" >> _areaID;
		isClass(_cfgArea >> "AreaSectors");
	};
// ROADS
	case "roads" : {
		private _cfgRoad = "isClass _x" configClasses (_cfgMapData >> "Roads");
		{
			_cfgRoad set [_forEachIndex,[
				configName _x
				,getArray(_x >> "position")
				,getNumber(_x >> "direction")
				,"road"
				,getText(_x >> "sector")
			]];
		} forEach _cfgRoad;
		_cfgRoad;
	};
	case "road" : {
		_params params [["_roadID","",[""]]];
		private _cfgRoad = _cfgMapData >> "Roads" >> _roadID;
		[
			configName _cfgRoad
			,getArray(_cfgRoad >> "position")
			,getNumber(_cfgRoad >> "direction")
			,"road"
			,getText(_cfgRoad >> "sector")
		]
	};
};