private _sectors = ["sectors",[true]] call MPSF_fnc_getCfgMapData;
{
	_x params ["_sectorID","_sectorPosition","_sectorOrientation","_rectangle","_sectorTypes","_sectorAreas","_sectorIsWater"];
	private _sectorMarker = createMarkerLocal [format ["MPSF_Marker_%1",_sectorID],_sectorPosition];
	_sectorMarker setMarkerShapeLocal "RECTANGLE";
	_sectorMarker setMarkerBrushLocal "SolidBorder";
	_sectorMarker setMarkerColorLocal "ColorBlack";
	_sectorMarker setMarkerSizeLocal [(_sectorOrientation select 0)*0.95,(_sectorOrientation select 1)*0.95];
	_sectorMarker setMarkerAlphaLocal 0.2;
} forEach _sectors;

private _areas = ["areas",[nil,true]] call MPSF_fnc_getCfgMapData;
{
	_x params [
		["_areaID","",[""]]
		,["_areaPosition",[0,0,0],[[]]]
		,["_areaOrientation",[0,0,0],[[]]]
		,["_areaType","",[""]]
		,["_areaSector","",[""]]
		,["_areaBuildings",[],[[]]]
		,["_areaSectors",[],[[]]]
	];

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
		case "forest" : { "colorIndependent"; };
		case "clearing" : { "colorBrown"; };
		case "shack" : { "colorGrey" };
		default {"ColorWhite"};
	};

	if !(_areaType IN ["clearing","forest"]) then {
		private _marker = createMarker [format["MPSF_LOCATION_%1_1",_areaID],_areaPosition];
		_marker setMarkerShape "RECTANGLE";
		_marker setMarkerBrush "SolidBorder";
		_marker setMarkerColor _markerColour;
		_marker setMarkerAlpha 0.2;
		_marker setMarkerSize [(_areaOrientation select 0)/2,(_areaOrientation select 1)/2];
	};

	private _marker = createMarker [format["MPSF_LOCATION_%1_2",_areaID],_areaPosition];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "mil_dot";
	_marker setMarkerColor _markerColour;
	if !(_areaType IN ["Clearing","Forest"]) then { _marker setMarkerText _areaType; };
	_marker setMarkerSize [1,1];
	_marker setMarkerAlpha 0.5;

	{
		private _sector = createMarker [format["MPSF_LOCATIONSECTOR_%1",(_x select 0)],(_x select 1)];
		_sector setMarkerShape "RECTANGLE";
		_sector setMarkerBrush "SolidBorder";
		_sector setMarkerColor "ColorOpfor";
		_sector setMarkerSize [100/2.1,100/2.1];
		_sector setMarkerAlpha 0.2;
	} forEach _areaSectors;
} forEach _areas;

private _roads = ["roads"] call MPSF_fnc_getCfgMapData;
{
	_x params ["_roadID","_roadPosition","_roadOrientation","_roadType","_roadSector"];
	private _marker = createMarker [format["MPSF_ROAD_%1",_roadID],_roadPosition];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "mil_arrow";
	_marker setMarkerDir _roadOrientation;
	_marker setMarkerColor "ColorBlack";
	_marker setMarkerSize [0.3,0.3];
	_marker setMarkerAlpha 0.5;
} forEach _roads;