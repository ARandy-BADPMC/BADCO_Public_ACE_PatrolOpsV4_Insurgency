/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_create3DENComposition.sqf
	Author(s): Modified from Larrow (https://forums.bistudio.com/forums/topic/191902-eden-composition-spawning/)

	Description:
		Describe your function

	Parameter(s):
		0: Object - Description

	Returns:
		Bool - True when done
*/
#define SPAWNPOS	[0,0,1000]

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
// Configuration
	case "getAnchorPosition" : {
		_params params [["_compositionID","",[""]]];
		private _anchor = ["CfgMissionFramework","ObjectCompositions",_compositionID,"center"] call MPSF_fnc_getCfgDataArray;
		[(_anchor select 0),(_anchor select 2),(_anchor select 1)];
	};
	case "getCfgPaths" : {
		_params params [["_parentCfgClass","",["",[]]]];

		if (_parentCfgClass isEqualTo "") exitWith { [] };
		if !(_parentCfgClass isEqualType []) then { _parentCfgClass = ["CfgMissionFramework","ObjectCompositions",_parentCfgClass]; };

		private _childrenCfgClass = (_parentCfgClass call BIS_fnc_getCfgSubClasses) apply { private _path = _parentCfgClass + [_x]; [_path,toLower((_path + ["dataType"]) call MPSF_fnc_getCfgDataText)] };
		if (count _childrenCfgClass == 0) exitWith { [] };

		private _paths = [];
		{
			_x params ["_path","_datatype"];
			switch (_datatype) do {
				case "group";
				case "logic";
				case "marker";
				case "object";
				case "trigger";
				case "waypoint" : {
					_paths pushBack [_path,_datatype];
				};
				//case "Layer";
				default {
					if (count (_path call BIS_fnc_getCfgSubClasses) > 0) then {
						_paths pushBack [_path,_datatype];
						{ _paths pushBack _x; } forEach (["getCfgPaths",[_path]] call MPSF_fnc_create3DENComposition);
					};
				};
			};
		} forEach _childrenCfgClass;

		_paths;
	};
	case "setObjectPosition" : {
		_params params [["_path",[],[[]]],["_object",objNull,[objNull]],["_anchorPos",[0,0,0],[[]]],["_anchorDir",0,[0]],["_force",false,[false]]];

		if (count _path == 0 || isNull _object) exitWith {false};

		private _cfgOffset = (_path + ["positionInfo","position"]) call MPSF_fnc_getCfgDataArray;
		if !(_cfgOffset isEqualTypeArray [0,0,0]) then { _cfgOffset = [0,0,0]; };

		private _cfgRot = (_path + ["positionInfo","angles"]) call MPSF_fnc_getCfgDataArray;
		if !(_cfgRot isEqualTypeArray [0,0,0]) then { _cfgRot = [0,0,0]; };

		private _atlOffset = (_path + ["attributes","atlOffset"]) call MPSF_fnc_getCfgDataNumber;
		private _randomStartPos = (_path + ["randomStartPositions"]) call MPSF_fnc_getCfgDataArray;
		private _needsSurfaceUp = ((typeof _object) isKindOf "LandVehicle") || ((typeof _object) isKindOf "LandVehicle") && (_atlOffset < 10);
		private _placementRadius =  (_path + ["attributes","placementRadius"]) call MPSF_fnc_getCfgDataNumber;

		private ["_pos"];

		_cfgOffset = [(_cfgOffset select 0),(_cfgOffset select 2),(_cfgOffset select 1)];
		_cfgOffset = [_cfgOffset,(360 - _anchorDir)] call BIS_fnc_rotateVector2D;
		_cfgOffset = _cfgOffset vectorAdd ([[0,0,0],(360 - _anchorDir)] call BIS_fnc_rotateVector2D);

		private _pos = if !(_force) then {
			private _newPosX = (_anchorPos select 0) + (_cfgOffset select 0);
			private _newPosY = (_anchorPos select 1) + (_cfgOffset select 1);
			private _newPosZ = (getTerrainHeightASL [_newPosX,_newPosY]) + ( _cfgOffset select 2 );
			[ _newPosX, _newPosY, _newPosZ ];
		}else{
			(_anchorPos vectorAdd _cfgOffset) vectorAdd [0,0,0];
		};

		if ( count _randomStartPos > 0 ) then {
			_randomStartPos = _randomStartPos  apply {
				private _mkrPos = ATLToASL getMarkerPos _x;
				_mkrPos = _mkrPos vectorAdd [ 0, 0, abs( boundingBoxReal _object select 0 select 2 ) ];
				_mkrPos
			};
			_pos = selectRandom ( [ _pos ] + _randomStartPos );
		};

		if ( _placementRadius > 0 ) then {
			_pos = AGLToASL ( _pos getPos [ random _placementRadius, random 360 ] );
			_pos = _pos vectorAdd [ 0, 0, abs( boundingBoxReal _object select 0 select 2 ) ];
		};

		if (surfaceIsWater _pos && !_force) then {
			_pos = [ _pos select 0, _pos select 1, 0 + ( _cfgOffset select 2 ) + ( _anchorPos select 2 ) ];
		};

		//Move object to its world position
		_object setPosWorld _pos;
		//Turn composition angles to degrees
		_cfgRot params[ "_P", "_Y", "_R" ];

		_Y = ( deg _Y ) + _anchorDir;
		_P = deg _P;
		_R = 360 - deg _R;
		//If Aliging composition or its a vehicle that needs surface up
		_pb = if ( ( !_force || _needsSurfaceUp ) && !( surfaceIsWater _pos && false /*_compWater*/ ) && _force ) then {
			//Face it in the right direction
			_object setDir _Y;
			//Get positions surface up
			_up = surfaceNormal _pos;
			//Get bound corner surface ups
			_bounds = boundingBoxReal _object;
			_bounds params[ "_mins", "_maxs" ];
			_mins params[ "_minX", "_minY", "_minZ" ];
			_maxs params[ "_maxX", "_maxY" ];
			//Calculate up based on corner surface normals
			_newUp = _up;
			{
				_cornerPos = _object modelToWorldVisual _x;
				_cornerUp = surfaceNormal _cornerPos;
				_weight = _pos distance _cornerPos;
				_diff = ( _up vectorDiff _cornerUp ) vectorMultiply _weight;
				_newUp = _newUp vectorAdd _diff;
			}forEach [
				[ _minX, _minY, _minZ ],
				[ _minX, _maxY, _minZ ],
				[ _maxX, _maxY, _minZ ],
				[ _maxX, _minY, _minZ ]
			];
			_object setVectorUp vectorNormalized _up;
			_object call BIS_fnc_getPitchBank
		}else{
			[ 0, 0 ]
		};

		//Add any surface offset to composition rotations
		_pb params[ "_pbP", "_pbR" ];
		_P = (_P + _pbP)%360;
		_R = (_R + _pbR)%360;

		if(_P < 0) then { _P = linearConversion[ -0, -360, _P, 360, 0 ]; };
		if(_R < 0) then { _R = linearConversion[ -0, -360, _R, 360, 0 ]; };
		if(_Y < 0) then { _Y = linearConversion[ -0, -360, _Y, 360, 0 ]; };

		//Calculate Dir and Up
		_dir = [ sin _Y * cos _P, cos _Y * cos _P, sin _P];
		_up = [ [ sin _R, -sin _P, cos _R * cos _P ], (-1) * _Y ] call BIS_fnc_rotateVector2D;
		//Set Object rotation
		_object setVectorDirAndUp [ _dir, _up ];

		// ARMA Jets Carrier
		if (typeOf _object isEqualTo "Land_Carrier_01_base_F") then {
			[_object] call BIS_fnc_Carrier01PosUpdate;
		};
	};
	case "createObject" : {
		_params params [["_path",[],[[]]],["_anchorPos",[0,0,0],[[]]],["_anchorDir",0,[0]],["_useAnchor",false,[false]],["_groupID",grpNull,[grpNull]]];

		private _probabilty = abs((_path + ["attributes","presence"]) call MPSF_fnc_getCfgDataNumber) >= random 1;
		if !(_probabilty) exitWith {objNull};

		private _presenceCondition = (_path + ["attributes","presenceCondition"]) call MPSF_fnc_getCfgDataText;
		if !(_presenceCondition isEqualTo "") then {
			if !(call compile _presenceCondition) exitWith {objNull};
		};

		private _className = (_path + ["type"]) call MPSF_fnc_getCfgDataText;
		if (_className isEqualTo "") exitWith {objNull};

		private _atlOffset = (_path + ["attributes","atlOffset"]) call MPSF_fnc_getCfgDataNumber;

		private _object = switch (true) do {
			case (_className isKindOf "Man") : {
				private _unit = _groupID createUnit [_className,SPAWNPOS,[],0,"NONE"];
				_unit enableSimulationGlobal false;
				_unit allowDamage false;

				private _skill = (_path + ["attributes","skill"]) call MPSF_fnc_getCfgDataNumber;
				if !(_skill < 0) then { _unit setSkill _skill; };

				private _rank = (_path + ["attributes","rank"]) call MPSF_fnc_getCfgDataText;
				if !(_rank isEqualTo "") then { _unit setSkill _skill; };

				private _loadout = (["getCfgUnitLoadout",[_path + ["attributes","inventory"]]]) call MPSF_fnc_create3DENComposition;
				if !(count _loadout == 0) then { _unit setUnitLoadout _loadout; };

				_unit;
			};
			case (_className isKindOf "LandVehicle");
			case (_className isKindOf "Air") : {
				private _spawnType = if (_atlOffset > 10) then {"FLY"} else {"CAN_COLLIDE"};
				private _isSimple = (_path + ["attributes","createAsSimpleObject"]) call MPSF_fnc_getCfgDataBool;
				private _vehicle = if (_isSimple) then {
					createSimpleObject [getText (configfile >> "CfgVehicles" >> _className >> "model"),SPAWNPOS]
				} else {
					createVehicle [_className,SPAWNPOS,[],0,_spawnType];
				};
				_vehicle enableSimulationGlobal false;
				_vehicle allowDamage false;

				private _locked = (_path + ["attributes","lock"]) call MPSF_fnc_getCfgDataText;
				if !(_locked isEqualTo "") then { _vehicle setVehicleLock _locked };

				private _fuel = (_path + ["attributes","fuel"]) call MPSF_fnc_getCfgDataNumber;
				if !(_fuel < 0) then { _vehicle setFuel _fuel; };

				if (_spawnType isEqualTo "FLY") then { _vehicle engineOn true; };

				_vehicle
			};
			case (_className isKindOf "Ship") : {
				private _vehicle = createVehicle [_className,SPAWNPOS,[],0,"CAN_COLLIDE"];
				_vehicle enableSimulationGlobal false;
				_vehicle allowDamage false;
				_vehicle
			};
			default {
				private _vehicle = createVehicle [_className,SPAWNPOS,[],0,"NONE"];
				_vehicle enableSimulationGlobal false;
				_vehicle allowDamage false;
				_vehicle
			};
		};

		private _health = (_path + ["attributes","health"]) call MPSF_fnc_getCfgDataNumber;
		if !(_health < 0) then { _object setDamage _health; };

		private _ammo = (_path + ["attributes","ammo"]) call MPSF_fnc_getCfgDataNumber;
		if !(_ammo < 0) then { _object setVehicleAmmo _ammo; };

		private _varName = (_path + ["attributes","name"]) call MPSF_fnc_getCfgDataText;
		if !(_varName isEqualTo "") then {
			_object setVehicleVarName _varName;
			missionNamespace setVariable [_varName,_object];
			publicVariable _varName;
		};

		private _objectID = (_path + ["id"]) call MPSF_fnc_getCfgDataNumber;
		_object setVariable ["3DENobjectID",_objectID];

		private _simulationEnabled = !((_path + ["attributes","disableSimulation"]) call MPSF_fnc_getCfgDataBool);
		_object setVariable ["3DENsimEnable",_simulationEnabled];

		private _simulationEnabled = !((_path + ["attributes","disableCollision"]) call MPSF_fnc_getCfgDataBool);
		_object setVariable ["3DENcollisionEnable",_simulationEnabled];

		private _texture = (_path + ["attributes","textures"]) call MPSF_fnc_getCfgDataText;
		if !(_texture isEqualTo "") then { _object setObjectTextureGlobal [0,_texture]; };

		["setObjectPosition",[_path,_object,_anchorPos,_anchorDir,_useAnchor]] call MPSF_fnc_create3DENComposition;

		if (_className isKindOf "Man") then {
			((waypoints group _object) select 0) setWaypointPosition [getPos _object,0];
		};

		private _objectInit = (_path + ["attributes","init"]) call MPSF_fnc_getCfgDataText;
		if !(_objectInit isEqualTo "") then { _object call compile format["this = _this; %1",_objectInit]; };

		// diag_log str [_objectID,_className,_object];

		_object
	};
	case "createGroup" : {
		_params params [["_path",[],[[]]],["_anchorPos",[0,0,0],[[]]],["_anchorDir",0,[0]],["_useAnchor",false,[false]]];

		private _side = (_path + ["side"]) call MPSF_fnc_getCfgDataText;
		if (_side isEqualTo "") exitWith { grpNull };
		private _groupID = call compile format[ "createGroup %1", _side];

		private _combatMode = (_path + ["attributes","combatMode"]) call MPSF_fnc_getCfgDataText;
		private _behaviour = (_path + ["attributes","behaviour"]) call MPSF_fnc_getCfgDataText;
		private _speedMode = (_path + ["attributes","speedMode"]) call MPSF_fnc_getCfgDataText;
		private _formation = (_path + ["attributes","formation"]) call MPSF_fnc_getCfgDataText;

		_groupID setCombatMode _combatMode;
		_groupID setBehaviour _behaviour;
		_groupID setSpeedMode _speedMode;
		_groupID setFormation _formation;

		private _groupEntityIDs = (_path + ["entities"]) call BIS_fnc_getCfgSubClasses;
		{
			private _entityPath = _path + ["entities",_x];
			["createObject",[_entityPath,_anchorPos,_anchorDir,_useAnchor,_groupID]] call MPSF_fnc_create3DENComposition;
		} forEach _groupEntityIDs;

		private _groupLinkItems = (_path + ["crewLinks","links"]) call BIS_fnc_getCfgSubClasses;
		_groupID setVariable ["3DENlinks",_groupLinkItems apply {
			[
				_x
				,(_path + ["crewLinks","links",_x,"item0"]) call MPSF_fnc_getCfgDataNumber
				,(_path + ["crewLinks","links",_x,"item1"]) call MPSF_fnc_getCfgDataNumber
				,(_path + ["crewLinks","links",_x,"customData","role"]) call MPSF_fnc_getCfgDataNumber
				,(_path + ["crewLinks","links",_x,"customData","turretPath"]) call MPSF_fnc_getCfgDataArray
				,(_path + ["crewLinks","links",_x,"customData","cargoIndex"]) call MPSF_fnc_getCfgDataNumber
			]
		}];

		_groupID
	};
	case "createMarker" : {
		_params params [["_path",[],[[]]],["_anchorPos",[0,0,0],[[]]],["_anchorDir",0,[0]],["_useAnchor",false,[false]]];

		private _cfgOffset = (_path + ["position"]) call MPSF_fnc_getCfgDataArray;
		if !(_cfgOffset isEqualTypeArray [0,0,0]) then { _cfgOffset = [0,0,0]; };
		_cfgOffset = [(_cfgOffset select 0),(_cfgOffset select 2),(_cfgOffset select 1)];
		_cfgOffset = [_cfgOffset,(360 - _anchorDir)] call BIS_fnc_rotateVector2D;
		_cfgOffset = _cfgOffset vectorAdd ([[0,0,0],(360 - _anchorDir)] call BIS_fnc_rotateVector2D);
		private _markerPosition = (_anchorPos vectorAdd _cfgOffset) vectorAdd [0,0,0];

		private _markerName = (_path + ["name"]) call MPSF_fnc_getCfgDataText;
		private _marker = createMarker [_markerName,_markerPosition];

		private _markerShape = (_path + ["markerType"]) call MPSF_fnc_getCfgDataText;
		switch (toUpper _markerShape) do {
			case "RECTANGLE";
			case "ELLIPSE" : {
				_marker setMarkerShape _markerShape;

				private _markerFill = (_path + ["fillName"]) call MPSF_fnc_getCfgDataText;
				_marker setMarkerBrush _markerFill;
			};
			case "POLYLINE" : {};
			default {
				_markerShape = "ICON";
				_marker setMarkerShape _markerShape;

				private _markerType = (_path + ["type"]) call MPSF_fnc_getCfgDataText;
				_marker setMarkerType _markerType;
			};
		};

		private _markerWidth = (_path + ["a"]) call MPSF_fnc_getCfgDataNumber;
		private _markerHeight = (_path + ["b"]) call MPSF_fnc_getCfgDataNumber;
		_marker setMarkerSize [_markerWidth,_markerHeight];

		private _markerAngle = (_path + ["angle"]) call MPSF_fnc_getCfgDataNumber;
		_marker setMarkerDir (_markerAngle max 0);

		private _markerText = (_path + ["text"]) call MPSF_fnc_getCfgDataText;
		if !( _markerText isEqualTo "" ) then {
			_marker setMarkerText _markerText;
		};

		private _markerColour = (_path + ["colorName"]) call MPSF_fnc_getCfgDataText;
		if !( _markerColour isEqualTo "" ) then {
			_marker setMarkerColor _markerColour;
		};

		private _markerAlpha = (_path + ["alpha"]) call MPSF_fnc_getCfgDataNumber;
		_marker setMarkerAlpha abs(_markerAlpha);

		_marker;
	};
	case "createPath" : {
		_params params [["_path",[],[[]]],["_datatype","",[""]],["_anchorPos",[0,0,0],[[]]],["_anchorDir",0,[0]],["_useAnchor",false,[false]]];
		private _object = switch (_datatype) do {
			case "group" : { ["createGroup",[_path,_anchorPos,_anchorDir,_useAnchor]] call MPSF_fnc_create3DENComposition; };
			case "object" : { ["createObject",[_path,_anchorPos,_anchorDir,_useAnchor,grpNull]] call MPSF_fnc_create3DENComposition; };
			//case "logic" : { ["createLogic",[_path,_anchorPos,_anchorDir,_useAnchor]] call MPSF_fnc_create3DENComposition; objNull };
			case "marker" : { ["createMarker",[_path,_anchorPos,_anchorDir,_useAnchor]] call MPSF_fnc_create3DENComposition; };
			//case "trigger" : { ["createTrigger",[_path,_anchorPos,_anchorDir,_useAnchor]] call MPSF_fnc_create3DENComposition; objNull };
			//case "waypoint" : { ["createWaypoint",[_path,_anchorPos,_anchorDir],_useAnchor] call MPSF_fnc_create3DENComposition; objNull };
			//case "Layer" : {objNull};
			default {objNull};
		};
		_object;
	};
	case "processLinks" : {
		_params params [["_object",objNull,[objNull,grpNull]],["_compositionObjects",[],[[]]]];
		if (isNull _object) exitWith {};

		switch (typeName _object) do {
			case (typeName grpNull) : {
				private _groupLinkItems = _object getVariable ["3DENlinks",[]];
				{
					_x params [["_classID","",[""]],["_targetID",-2,[0]],["_vehicleID",-2,[0]],["_role",-1,[0]],["_turret",[],[[]]],["_cargoIndex",-1,[0]]];
					private _target = (_compositionObjects select { (_x getVariable ["3DENobjectID",-1]) == _targetID }) param [0,objNull];
					private _vehicle = (_compositionObjects select { (_x getVariable ["3DENobjectID",-1]) == _vehicleID }) param [0,objNull];
					if !(isNull _target || isNull _vehicle) then {
						switch (true) do {
							//case (count _turret > 0) : { _target moveInTurret [_vehicle,_turret]; };
							//case (_cargoIndex > -1) : { _target moveInCargo [_vehicle,_cargoIndex]; };
							default { _target moveInAny _vehicle; };
						};
					};
				} forEach _groupLinkItems;
			};
			case (typeName objNull) : {
				//enable simulation
				if (!(simulationEnabled _object) && (_object getVariable ["3DENsimEnable",true])) then {
					_object enableSimulationGlobal true;
					_object allowDamage true;
				} else {
					if !(_object getVariable ["3DENcollisionEnable",true]) then { {_x disableCollisionWith _object;} forEach allPlayers; };
				};
			};
		};
	};
	case "create3DENComposition" : {
		_params params [["_compositionID","",[""]],["_anchorPos",[0,0,0],[[]]],["_anchorDir",0,[0]]];
		if !(["CfgMissionFramework","ObjectCompositions",_compositionID] call BIS_fnc_getCfgIsClass) exitWith { /*["Unable to identify object composition for %1",_compositionID] call BIS_fnc_error;*/ []; };

		private _compositionLayers = ["getCfgPaths",[_compositionID]] call MPSF_fnc_create3DENComposition;

		private _useAnchor = _anchorPos isEqualTo [0,0,0];
		if (_useAnchor) then { _anchorPos = ["getAnchorPosition",[_compositionID]] call MPSF_fnc_create3DENComposition; };

		private _spawnObjects = [];
		private _spawnMarkers = [];
		{
			private _return = ["createPath",(_x + [_anchorPos,_anchorDir,_useAnchor])] call MPSF_fnc_create3DENComposition;
			switch (true) do {
				case (_return isEqualType objNull) : {
					if !(isNull _return) then { _spawnObjects pushBack _return; };
				};
				case (_return isEqualType grpNull) : {
					_spawnObjects pushBack _return;
					{ _spawnObjects pushBack _x; } forEach (units _return);
				};
				case (_return isEqualType "") : {
					_spawnMarkers pushBack _return;
				};
			};
		} forEach _compositionLayers;

		{
			["processLinks",[_x,_spawnObjects]] call MPSF_fnc_create3DENComposition;
		} forEach _spawnObjects;

		if (count _spawnObjects > 0) then {
			[_spawnObjects select {_x isEqualType objNull}] call MPSF_fnc_addZeusObjects;
		};

		_spawnObjects + _spawnMarkers;
	};
};