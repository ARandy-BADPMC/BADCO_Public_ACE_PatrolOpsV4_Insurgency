#define MISSIONTIME			(if (isMultiplayer) then {serverTime} else {time})
#define DEFAULTAREASIZE		1000

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
// Event Handlers
	case "clientHasMoved" : {
		_params params [["_oldPos",[0,0,0],[[]]],["_newPos",[0,0,0],[[]]],["_totalDistance",1,[0]],["_distance",0,[0]]];

		private _radius = ["getSectorSize"] call MPSF_fnc_getCfgMapData;
		private _refPos = _newPos getPos [_radius/2,_oldPos getDir _newPos];
		private _refSectorID = ["getSectorID",[_refPos,_radius,true]] call PO4_fnc_zones;

		// private _marker = createMarker [format["MPSF_LOCATION_%1_2",_refPos],_refPos];
		// _marker setMarkerShape "ICON";
		// _marker setMarkerType "mil_dot";
		// _marker setMarkerColor "ColorBlack";
		// _marker setMarkerText (_refSectorID);
		// _marker setMarkerSize [1,1];

		if !(_refSectorID in (["sectors"] call MPSF_fnc_getCfgMapData)) exitWith {
			["%1 Sector does not exist",_refSectorID] call BIS_fnc_error;
		};

		private _sectorState = ["getSectorState",[_refSectorID]] call PO4_fnc_zones;
		//systemChat format ["%1 sector is %2",_refSectorID,_sectorState];
		if (_sectorState isEqualTo 2) exitWith {/*friendly*/};

		private _sectorActiveState = ["getSectorActiveState",[_refSectorID]] call PO4_fnc_zones;
		if (_sectorActiveState) exitWith {
			//systemChat format ["clientHasMoved: %1 is Active",_refSectorID];
		};

		private _sectorEncounterIDs = ["getSectorEncounterIDs",[_refSectorID]] call PO4_fnc_encounters;
		if (count _sectorEncounterIDs == 0) exitWith {};

		(selectRandom _sectorEncounterIDs) params ["_encounterID","_encounterAreaIDs"];
		private _areaID = selectRandom _encounterAreaIDs;
		["requestEncounter",[_refSectorID,_areaID,_encounterID]] call PO4_fnc_encounters;
		[_refSectorID,_areaID,_encounterID]
	};
	case "clientHasMovedAir" : {
		_params params [["_oldPos",[0,0,0],[[]]],["_newPos",[0,0,0],[[]]],["_totalDistance",1,[0]],["_distance",0,[0]]];

		private _sectorEncounterIDs = ["getAirEncounterIDs",[]] call PO4_fnc_encounters;
		if (count _sectorEncounterIDs == 0) exitWith {};

		(selectRandom _sectorEncounterIDs) params ["_encounterID","_encounterAreaIDs"];
		private _areaID = selectRandom _encounterAreaIDs;
		["requestEncounter",[nil,_areaID,_encounterID]] call PO4_fnc_encounters;
		[nil,_areaID,_encounterID]
	};
	case "clientHasMovedWater" : {};
	case "requestEncounter" : {
		_params params [["_sectorID","",[""]],["_areaID","",[""]],["_encounterID","",[""]],["_send",false,[false]]];

		if (_send && !isServer) exitWith {};

		private _timeOut = ["getCfgEncounterTimeout",[_encounterID]] call PO4_fnc_encounters;
		private _lastRun = missionNamespace getVariable [format ["PO4_Encounter_%1_lastTime",_encounterID],MISSIONTIME];
		if (_lastRun > MISSIONTIME) exitWith {
		//	systemChat str format ["%1 timeOut reached: %2s",_encounterID,round(_lastRun - MISSIONTIME)];
		};

		private _limit = ["getCfgEncounterLimit",[_encounterID]] call PO4_fnc_encounters;
		private _encounterLogics = ["getEncounterModules",[_encounterID,true]] call PO4_fnc_encounters;
		if (count _encounterLogics >= _limit && _limit > 0) exitWith {
		//	systemChat str format ["%1 limit reached",_encounterID];
		};

		if (isServer) then {
			["createSectorEncounter",[_sectorID,_areaID,_encounterID]] spawn PO4_fnc_encounters;
		} else {
			["onRequestEncounter",[_sectorID,_areaID,_encounterID,true],2] call MPSF_fnc_triggerEventHandler;
		};
	};
// Encounter
	case "createSectorEncounter" : {
		_params params [["_sectorID","",[""]],["_areaID","",[""]],["_encounterID","",[""]]];
		if (_encounterID isEqualTo "") exitWith { "" };

		private _timeOut = ["getCfgEncounterTimeout",[_encounterID]] call PO4_fnc_encounters;
		missionNamespace setVariable [format ["PO4_Encounter_%1_lastTime",_encounterID],MISSIONTIME + _timeOut];
		publicVariable format ["PO4_Encounter_%1_lastTime",_encounterID];

		// Create Unique Task ID
		private _taskID = ["createTaskID",[_encounterID]] call MPSF_fnc_taskmaster;

		// Create Task Manager Logic
		private _taskLogic = ["createTaskLogic",[[0,0,0],_taskID]] call MPSF_fnc_taskmaster;
		_taskLogic setVariable ["cfgTaskID",_encounterID,true];
		_taskLogic setVariable ["taskID",_taskID,true];
		_taskLogic setVariable ["PO4_Module_Encounter_F",true,true];

		// Create Task Position
		private _areaPos = ["getAreaPosition",[_areaID]] call MPSF_fnc_getCfgMapData;
		if (["positionNearRoad",[_encounterID]] call MPSF_fnc_getCfgTasks) then {
			private _nearRoads = [];
			for "_i" from 2 to 10 do {
				_nearRoads = (_areaPos nearRoads (50*_i)) select {!(surfaceIsWater getPos _x)};
				if (count _nearRoads > 0) exitWith {};
			};
			if (count _nearRoads > 0) then {
				_areaPos = getPos (selectRandom _nearRoads);
			};
		};

		_taskLogic setVariable ["position",_areaPos,true];
		_taskLogic setVariable ["positionOffset",_areaPos,true];
		_taskLogic setVariable ["area",_areaID,true];
		_taskLogic setPos _areaPos;

		// Create Markers
		["createTaskMarkers",[_taskID,_encounterID]] call MPSF_fnc_taskmaster;

		// Create Compositions
		["createTaskCompositions",[_taskID,_encounterID]] call MPSF_fnc_taskmaster;

		// Create Groups
		if ([] call MPSF_fnc_isHeadlessClientPresent) then {
			["onSpawnCommand",[_taskID,_encounterID,_areaPos,_areaPos],[] call MPSF_fnc_getHeadlessClient] call MPSF_fnc_triggerEventHandler;
		} else {
			["createTaskGroups",[_taskID,_encounterID,_areaPos,_areaPos]] call MPSF_fnc_taskmaster;
		};

		// Create Parent Task
		["createTaskNotification",[_taskID,_encounterID]] call MPSF_fnc_taskmaster;
		["addTaskMonitor",[_taskID,_encounterID]] call MPSF_fnc_taskmaster;

		// Fire onTaskCreate Event Handler
		["onEncounterCreate",[_taskID,_encounterID,_areaPos],0] call MPSF_fnc_triggerEventHandler;

		_taskID
	};
	case "getEncounterModules" : {
		_params params [["_types",[],[[],""]],["_active",false,[false]]];
		if !(_types isEqualType []) then { _types = [_types]; };
		private _taskModules = (allMissionObjects "Logic") select {_x getVariable ["PO4_Module_Encounter_F",false]};
		if (count _types > 0) then {
			_taskModules = _taskModules select { (_x getVariable ["cfgTaskID",""]) in _types };
		};
		if (_active) then {
			_taskModules = _taskModules select { _x getVariable ["TaskActive",true]; };
		};
		_taskModules
	};
	case "getNearbyEncounters" : {
		_params params [["_position",[0,0,0],[[]]],["_active",false,[false]]];
		private _taskModules = ["getEncounterModules",[[],_active]] call PO4_fnc_encounters;
		_taskModules = _taskModules select {_x distance2D _position < 1000};
		_taskModules
	};
	case "getNearestEncounter" : {
		_params params [["_position",[0,0,0],[[]]],["_active",false,[false]]];
		private _taskModules = ["getEncounterModules",[[],_active]] call PO4_fnc_encounters;
		private _taskModule = objNull;
		private _distance = 1e6;
		{
			private _relDis = _position distance2D _x;
			if (_relDis < _distance) then {
				_distance = _relDis;
				_taskModule = _x;
			};
		} forEach _taskModules;
		_taskModule
	};
	case "getSectorEncounterIDs" : {
		_params params [["_sectorID","",[""]]];
		if (_sectorID isEqualTo "") exitWith {[]};
		if !(["isSectorHostile",[_sectorID,[0,1]]] call PO4_fnc_zones) exitWith {[]};
		// Sector Data
		private _sectorAreas = ["sectorAreas",[_sectorID,true]] call MPSF_fnc_getCfgMapData;
		_sectorAreas = _sectorAreas select { private _pos = _x select 1; { _x distance _pos < 500 } count allPlayers == 0; };
		_sectorAreas = _sectorAreas select { count (["getNearbyEncounters",[_x select 1,true]] call PO4_fnc_encounters) == 0 };
		if (count _sectorAreas == 0) exitWith {[]};
		// Encounter Data
		private _encounterIDs = (["taskIDs"] call MPSF_fnc_getCfgTasks) select { (["CfgMissionTasks",_x,"typeID"] call MPSF_fnc_getCfgDataNumber) in [1] };
		// Group Data
		(["getGroupData",[group player]] call PO4_fnc_encounters) params ["_groupID","_countUnits","_countPlayers","_classTypes","_moving"];
		_classTypes = _classTypes apply { toLower _x; };
		// Valid Encounter
		private _encounters = [];
		{
			private _encounterID = _x;
			private _encounterAreaTypes = (["getCfgEncounterAreaTypes",[_encounterID]] call PO4_fnc_encounters) apply { toLower _x; };
			private _encounterAreaIDs = _sectorAreas select {(_x select 3) in _encounterAreaTypes};
			// {
			// 	private _marker = createMarker [format["MPSF_AREA_%1",_x select 0],_x select 1];
			// 	_marker setMarkerShape "ICON";
			// 	_marker setMarkerType "mil_objective";
			// 	_marker setMarkerColor "ColorBlack";
			// 	_marker setMarkerText (_x select 0);
			// 	_marker setMarkerSize [0.5,0.5];
			// 	_marker setMarkerAlpha 0.3;
			// } forEach _encounterAreaIDs;
			if (count _encounterAreaIDs > 0) then {
				private _encounterVehicleTypes = (["getCfgEncounterVehicleTypes",[_encounterID]] call PO4_fnc_encounters) apply { toLower _x; };
				private _vehiclePass = count (_encounterVehicleTypes arrayIntersect _classTypes) > 0;
				if (_vehiclePass || count _encounterVehicleTypes == 0) then {
					_encounters pushBackUnique [_encounterID,_encounterAreaIDs apply {_x select 0}];
				};
			};
		} forEach _encounterIDs;
		_encounters
	};
	case "getAirEncounterIDs" : {
		// Encounter Data
		private _encounterIDs = (["taskIDs"] call MPSF_fnc_getCfgTasks) select { (["CfgMissionTasks",_x,"typeID"] call MPSF_fnc_getCfgDataNumber) in [1] };
		// Areas
		private _areas = ["areas",["Air",true]] call MPSF_fnc_getCfgMapData;
		// Group Data
		(["getGroupData",[group player]] call PO4_fnc_encounters) params ["_groupID","_countUnits","_countPlayers","_classTypes","_moving"];
		_classTypes = _classTypes apply { toLower _x; };
		// Valid Encounter
		private _encounters = [];
		{
			private _encounterID = _x;
			private _encounterAreaTypes = (["getCfgEncounterAreaTypes",[_encounterID]] call PO4_fnc_encounters) apply { toLower _x; };
			private _encounterAreaIDs = _areas select {(_x select 3) in _encounterAreaTypes};
			if (count _encounterAreaIDs > 0) then {
				private _encounterVehicleTypes = (["getCfgEncounterVehicleTypes",[_encounterID]] call PO4_fnc_encounters) apply { toLower _x; };
				private _vehiclePass = count (_encounterVehicleTypes arrayIntersect _classTypes) > 0;
				if (_vehiclePass || count _encounterVehicleTypes == 0) then {
					_encounters pushBackUnique [_encounterID,_encounterAreaIDs apply {_x select 0}];
				};
			};
		} forEach _encounterIDs;
		_encounters
	};
	case "getWaterEncounterIDs" : {
		// Encounter Data
		private _encounterIDs = (["taskIDs"] call MPSF_fnc_getCfgTasks) select { (["CfgMissionTasks",_x,"typeID"] call MPSF_fnc_getCfgDataNumber) in [1] };
		// Areas
		private _areas = ["areas",["Water",false]] call MPSF_fnc_getCfgMapData;
		// Group Data
		(["getGroupData",[group player]] call PO4_fnc_encounters) params ["_groupID","_countUnits","_countPlayers","_classTypes","_moving"];
		_classTypes = _classTypes apply { toLower _x; };
		// Valid Encounter
		private _encounters = [];
		{
			private _encounterID = _x;
			private _encounterAreaTypes = (["getCfgEncounterAreaTypes",[_encounterID]] call PO4_fnc_encounters) apply { toLower _x; };
			private _encounterAreaIDs = _areas select {(_x select 3) in _encounterAreaTypes};
			if (count _encounterAreaIDs > 0) then {
				private _encounterVehicleTypes = (["getCfgEncounterVehicleTypes",[_encounterID]] call PO4_fnc_encounters) apply { toLower _x; };
				private _vehiclePass = count (_encounterVehicleTypes arrayIntersect _classTypes) > 0;
				if (_vehiclePass || count _encounterVehicleTypes == 0) then {
					_encounters pushBackUnique [_encounterID,_encounterAreaIDs apply {_x select 0}];
				};
			};
		} forEach _encounterIDs;
		_encounters
	};
// Encounter Configuration
	case "getCfgEncounterLimit" : {
		_params params [["_encounterID","",[""]]];
		["CfgMissionTasks",_encounterID,"Conditions","Limit"] call MPSF_fnc_getCfgDataNumber;
	};
	case "getCfgEncounterTimeout" : {
		_params params [["_encounterID","",[""]]];
		["CfgMissionTasks",_encounterID,"Conditions","Timeout"] call MPSF_fnc_getCfgDataNumber;
	};
	case "getCfgEncounterAreaTypes" : {
		_params params [["_encounterID","",[""]]];
		["CfgMissionTasks",_encounterID,"Conditions","Areas"] call MPSF_fnc_getCfgDataArray;
	};
	case "getCfgEncounterVehicleTypes" : {
		_params params [["_encounterID","",[""]]];
		["CfgMissionTasks",_encounterID,"Conditions","VehicleTypes"] call MPSF_fnc_getCfgDataArray;
	};
	case "getCfgEncounterZoneTypes" : {
		_params params [["_encounterID","",[""]]];
		["CfgMissionTasks",_encounterID,"Conditions","ZoneTypes"] call MPSF_fnc_getCfgDataArray;
	};
	case "getCfgEncounterTasks" : {
		_params params [["_encounterID","",[""]]];
		["CfgMissionTasks",_encounterID,"Conditions","tasks"] call MPSF_fnc_getCfgDataArray;
	};
	case "getCfgEncounterChat" : {
		_params params [["_encounterID","",[""]]];
		["CfgMissionTasks",_encounterID,"Conditions","sideChat"] call MPSF_fnc_getCfgDataText;
	};
	case "getCfgEncounterMoving" : {
		_params params [["_encounterID","",[""]]];
		[false,true] select abs(["CfgMissionTasks",_encounterID,"Conditions","moving"] call MPSF_fnc_getCfgDataNumber);
	};
// Functions
	case "getGroupData" : {
		_params params [["_groupID",grpNull,[grpNull]]];
		if (isNull _groupID) exitWith { []; };

		private _vehicles = (units _groupID) apply {vehicle _x;};
		private _vehicleClasses = [];
		{
			{
				_vehicleClasses pushBackUnique _x;
			} forEach ([configFile >> "CfgVehicles" >> typeOf _x,true] call BIS_fnc_returnParents);
		} forEach _vehicles;

		[
			_groupID
			,count (units _groupID)
			,count (units _groupID select {isPlayer _x})
			,_vehicleClasses
		];
	};
	case "processLogReg" : {
		_params params [["_unit",player,[objNull]]];

		private _groupID = group _unit;
		private _side = side _groupID;
		private _units = units _groupID;
		private _leader = leader _groupID;
		private _vehicle = vehicle _leader;
		private _coefVehicle = switch (true) do {
			case (_vehicle isKindOf "Air") : { "coeff_Plane" };
			case (_vehicle isKindOf "Helicopter") : { "coeff_Helo" };
			case (_vehicle isKindOf "LandVehicle") : { "coeff_Vehicle" };
			default { "coeff_CaManBase" };
		};

		private _scores = ["processScore",[_coefVehicle]] call PO4_fnc_encounters;
		_scores pushBack (["processScore",["+distancetohome"]] call PO4_fnc_encounters);
		_scores pushBack (["processScore",["+squadsize"]] call PO4_fnc_encounters);
		_scores pushBack (["processScore",["+zoneType"]] call PO4_fnc_encounters);
		//_scores pushBack ([0.00713,missionNamespace getVariable ["MPSF_lastEncounterDateTime",MISSIONTIME]]); // Timed Encounter
		//_scores pushBack ([0.02742,_sectorStatus]); // Sector Type

		private _LogRegScore = 0;
		{
			_x params [["_coef",0,[0]],["_score",0,[0]]];
			_LogRegScore = _LogRegScore + (_coef * _score);
		} forEach _scores;

		private _LogReg = (1/(1+exp(-(_LogRegScore))));
		private _LogTrigger = _LogReg >= random 1;

		//systemChat str _scores;
		//systemChat str [_LogRegScore,_LogReg,_LogTrigger];

		_LogTrigger;
	};
	case "processScore" : {
		_params params [["_attr","",[""]],["_unit",player,[objNull]]];
		switch (_attr) do {
			// Coefficients
			case "coeff_CaManBase" : { [-7.012547,1] };
			case "coeff_Vehicle" : { [-8.42138,1] };
			case "coeff_Helo" : { [-11.23796,1] };
			case "coeff_Plane" : { [-9.23769,1] };
			// Features
			case "+squadsize" : { [0.031942,count units group _unit] };
			case "-squadsize" : { [-0.031942,count units group _unit] };
			case "+distancetohome" : {
				private _d2b = 1e9;
				{ _d2b = _d2b min (_unit distance2d getMarkerPos _x); } forEach ([side _unit] call BIS_fnc_getRespawnMarkers);
				[0.002484,_d2b]
			};
			case "-distancetohome" : {
				private _d2b = 1e9;
				{ _d2b = _d2b min (_unit distance2d getMarkerPos _x); } forEach ([side _unit] call BIS_fnc_getRespawnMarkers);
				[-0.002484,_d2b]
			};
			case "+zoneType" : {
				private _zoneType = ["getZoneType",[position _unit,false]] call PO4_fnc_zones;
				[
					[-1,100] // safe
					,[-0.684238,3] // friendly
					,[-1.138854,2] // neutral
					,[ 0.164811,1] // hostile
				] select (0 max _zoneType min 3);
			};
			default { [0,0] };
		};
	};
// Init
	case "postInit";
	case "init" : {
		if (isServer) then {
			// Create Encounter
			["PO4_Encounter_onRequestEncounter_EH","onRequestEncounter",{
				["requestEncounter",_this] call PO4_fnc_encounters;
			}] call MPSF_fnc_addEventHandler;
			// When an encounter INTEL is picked up
			["PO4_Encounter_onIntelPickup_EH","onIntelPickup",{
				params [["_unit",objNull,[objNull]],["_attr",[],[[]]]];
				_attr params [["_taskID","",[""]],["_cfgTaskID","",[""]]];
				private _encounterIDs = (["taskIDs"] call MPSF_fnc_getCfgTasks) select { (["CfgMissionTasks",_x,"typeID"] call MPSF_fnc_getCfgDataNumber) in [1]};
				if (_cfgTaskID in _encounterIDs) then {
					["addIntelScore",[side group _unit,1]] call PO4_fnc_operations;
				};
			}] call MPSF_fnc_addEventHandler;
			// When an encounter INTEL is downloaded
			["PO4_Encounter_onIntelRecieve_EH","onIntelRecieve",{
				params [["_target",objNull,[objNull]],["_unit",objNull,[objNull]],["_attr",[],[[]]]];
				_attr params [["_taskID","",[""]],["_cfgTaskID","",[""]]];
				private _encounterIDs = (["taskIDs"] call MPSF_fnc_getCfgTasks) select { (["CfgMissionTasks",_x,"typeID"] call MPSF_fnc_getCfgDataNumber) in [1]};
				if (_cfgTaskID in _encounterIDs) then {
					["addIntelScore",[side group _unit,0.5]] call PO4_fnc_operations;
				};
			}] call MPSF_fnc_addEventHandler;
			// When an encounter INTEL is downloaded
			["PO4_Encounter_onIntelDownloadComplete_EH","onIntelDownloadComplete",{
				params [["_unit",objNull,[objNull]],["_attr",[],[[]]]];
				_attr params [["_taskID","",[""]],["_cfgTaskID","",[""]]];
				private _encounterIDs = (["taskIDs"] call MPSF_fnc_getCfgTasks) select { (["CfgMissionTasks",_x,"typeID"] call MPSF_fnc_getCfgDataNumber) in [1]};
				if (_cfgTaskID in _encounterIDs) then {
					["addIntelScore",[side group _unit,2]] call PO4_fnc_operations;
				};
			}] call MPSF_fnc_addEventHandler;
			// When a Body is searched
			["PO4_Encounter_onBodySearchComplete_EH","onBodySearchComplete",{
				params [["_unit",objNull,[objNull]],["_attr",[],[[]]]];
				_attr params [["_taskID","",[""]],["_cfgTaskID","",[""]]];
				private _encounterIDs = (["taskIDs"] call MPSF_fnc_getCfgTasks) select { (["CfgMissionTasks",_x,"typeID"] call MPSF_fnc_getCfgDataNumber) in [1]};
				if (_cfgTaskID in _encounterIDs) then {
					["addIntelScore",[side group _unit,1]] call PO4_fnc_operations;
				};
			}] call MPSF_fnc_addEventHandler;
		};
		if (hasInterface) then {
			// On Encounter Create
			["PO4_Encounter_onEncounterCreate_EH","onEncounterCreate",{
				params ["_taskID","_encounterID"];
				// Show Any Text
				private _text = ["getCfgEncounterChat",[_encounterID]] call PO4_fnc_encounters;
				if !(_text isEqualTo "") then { [playerSide,"AirBase"] commandChat _text; };
			}] call MPSF_fnc_addEventHandler;
			// Add movement Trigger calculation of random encounters
			["PO4_Encounter_onMove_EH","HasMoved",{
				private _vehicle = vehicle player;
				switch (true) do {
					case (_vehicle isEqualTo player) : {
						if (leader group player isEqualTo player) then {
							["clientHasMoved",_this] spawn PO4_fnc_encounters;
						};
					};
					case (_vehicle isKindOf "LandVehicle");
					case (_vehicle isKindOf "Helicopter") : {
						if (driver _vehicle isEqualTo player) then {
							["clientHasMoved",_this] spawn PO4_fnc_encounters;
						};
					};
					case (_vehicle isKindOf "Plane") : {
						if (driver _vehicle isEqualTo player) then {
							["clientHasMovedAir",_this] spawn PO4_fnc_encounters;
						};
					};
					case (_vehicle isKindOf "Ship") : {
						if (driver _vehicle isEqualTo player) then {
							["clientHasMovedWater",_this] spawn PO4_fnc_encounters;
						};
					};
				};
			}] call MPSF_fnc_addEventHandler;
			["PO4_Encounter_onBodySearchCompleteClient_EH","onBodySearchComplete",{
				params [["_unit",objNull,[objNull]],["_attr",[],[[]]]];
				if (count _attr > 0) then {
					["MPSF_onIntel",["Intel Found","Intel has been recovered"]] call BIS_fnc_showNotification;
				} else {
					["MPSF_onIntel",["No Intel Found","There was not Intel recovered"]] call BIS_fnc_showNotification;
				};
			}] call MPSF_fnc_addEventHandler;
		};
	};
};