params [["_cfgTaskID","",[""]],["_taskID","",[""]],["_areaID","",[[],""]]];

//(format ["Task Position request: %1 | params: %2",_taskID,_this]) call BIS_fnc_logFormat;

private _var = format["%1_var_position",_taskID];
// Exit early when already stored
if !(isNil _var) exitWith { missionNamespace getVariable [_var,[[0,0,0],[0,0,0],""]]; };

// Get task position configuration
private _position = ["position",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;
private _positionOffset = ["positionOffset",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;
private _positionSearchRadius = ["positionSearchRadius",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;
private _positionSearchTypes = ["positionSearchTypes",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;
private _positionNearLast = ["positionNearLast",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;
private _positionNearRoad = ["positionNearRoad",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;
private _positionIsWater = ["positionIsWater",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;

//(format ["Task Position info: %1 | Position: %2 | PosOffset: %3 | SearchRadius: %4 | SearchTypes: %5",_taskID,_position,_positionOffset,_positionSearchRadius,_positionSearchTypes]) call BIS_fnc_logFormat;

switch (true) do {
    case (_position isEqualTypeArray [0,0]);
    case (_position isEqualTypeArray [0,0,0]) : {};
    case (_position isEqualType []) : {
        _position = selectRandom _position;
    };
    case (_position isEqualType objNull);
    case (_position isEqualType "") : { _position = _position call BIS_fnc_position; };
};

// Check position is array
if !(_position isEqualType []) then { _position = _position call BIS_fnc_position; };

// Override if position is near last or parentID stored position
if (_positionNearLast) then { _position = missionNamespace getVariable ["MPSF_Task_var_lastRefPos",[0,0,0]]; };

if (_areaID isEqualType []) then {
    if (_positionNearLast) then {
        private _nearbyAreas = ["getNearbyAreas",[_areaID,_positionSearchTypes,2000]] call MPSF_fnc_getCfgMapData;
        _nearbyAreas = _nearbyAreas select { (["getAreaPosition",[_x]] call MPSF_fnc_getCfgMapData) distance _areaID > 800 };
        if (count _nearbyAreas > 0) then {
            _position = ["getAreaPosition",[selectRandom _nearbyAreas]] call MPSF_fnc_getCfgMapData;
        };
    } else {
        _areaID = "";
    };
};

// If position is not defined, randomise to a sector location
if (_position isEqualTo [0,0,0] && _areaID isEqualType "") then {
    if (_areaID isEqualTo "") then {
        private _mapSectors = ["sectors"] call MPSF_fnc_getCfgMapData;
        if (_positionIsWater) then {
            _mapSectors = _mapSectors select {(["isSectorWater",[_x]] call MPSF_fnc_getCfgMapData)};
        } else {
            _mapSectors = _mapSectors select {!(["isSectorWater",[_x]] call MPSF_fnc_getCfgMapData)};
        };
        if (count _positionSearchTypes > 0) then {
            _mapSectors = _mapSectors select {(["hasSectorAreaType",[_x,_positionSearchTypes]] call MPSF_fnc_getCfgMapData)};
        };
        if (count _mapSectors > 0) then {
            _position = ["sectorPosition",[selectRandom _mapSectors]] call MPSF_fnc_getCfgMapData;
        };
    } else {
        _position = ["getAreaPosition",[_areaID]] call MPSF_fnc_getCfgMapData;
    };
};

switch (true) do {
    case (_positionOffset isEqualTypeArray [0,0]);
    case (_positionOffset isEqualTypeArray [0,0,0]) : {};
    case (_positionOffset isEqualType []) : {
        _positionOffset = selectRandom _positionOffset;
    };
    case (_positionOffset isEqualType objNull);
    case (_positionOffset isEqualType "") : { _positionOffset = _positionOffset call BIS_fnc_position; };
};
if !(_positionOffset isEqualType []) then { _positionOffset = _positionOffset call BIS_fnc_position; };

// If positionOffset is not defined, use position location
if (_positionOffset isEqualTo [0,0,0]) then { _positionOffset =+ _position; };

// Move Offset Position to nearby area type
if (_areaID isEqualTo "") then {
    if (_positionSearchRadius > 0 && count _positionSearchTypes > 0) then {
        private _areas = ["getNearbyAreas",[_positionOffset,_positionSearchTypes,_positionSearchRadius/2]] call MPSF_fnc_getCfgMapData;
        if (count _areas > 0) then {
            _areaID = selectRandom _areas;
            _positionOffset = ["getAreaPosition",[_areaID]] call MPSF_fnc_getCfgMapData;
        };
    };
};

// Move Offset Position to nearby road
if (_positionNearRoad) then {
    private _nearRoads = [];
    for "_i" from 2 to 10 do {
        _nearRoads = (_positionOffset nearRoads (50*(_i/2))) select {!(surfaceIsWater getPos _x)};
        if (count _nearRoads > 0) exitWith { _nearRoads apply {getPos _x}};
    };
    if (count _nearRoads > 0) then {
        _positionOffset = getPos (selectRandom _nearRoads);
    };
};

//(format ["Task Position generated: %1 | Position: %2 | PosOffset: %3 | Area: %4",_taskID,_position,_positionOffset,str _areaID]) call BIS_fnc_logFormat;

missionNamespace setVariable [_var,[_position,_positionOffset,_areaID]];
[_position,_positionOffset,_areaID];