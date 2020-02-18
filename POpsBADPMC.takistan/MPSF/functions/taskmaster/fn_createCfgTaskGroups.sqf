params [["_taskLogic",objNull,[objNull,""]],["_cfgTaskID","",[""]]];

if !(["hasGroups",[_cfgTaskID]] call MPSF_fnc_getCfgTasks) exitWith { [] };

if (typeName _taskLogic isEqualTo typeName "") then {
	_taskLogic = missionNamespace getVariable [_taskLogic,objNull];
};
if (isNull _taskLogic) exitWith { [] };

private _taskID = _taskLogic getVariable ["taskID",""];
private _position = _taskLogic getVariable ["position",[0,0,0]];
private _positionOffset = _taskLogic getVariable ["positionOffset",[0,0,0]];

private _cfgTaskGroups = ["Groups",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;
private _createdGroups = [];
private _createdUnits = [];
private _createdObjects = [];
private _createdTargets = [];

{
	_x params [
		["_groupUID","",[""]]
		,["_vehicleTypes",[],[[]]]
		,["_groupTypes",[],[[]]]
		,["_objectTypes",[],[[]]]
		,["_crewTypes",[]]
		,["_factionID","",[""]]
		,["_groupPos",[0,0,0],[[],""]]
		,["_distance",[0,0],[[]]]
		,["_direction",[0,0],[[]]]
		,["_radius",[50,150],[[]]]
		,["_angle",[0,0],[[]]]
		,["_minPlayers",0,[0]]
		,["_conversations",[],[[]]]
		//,["_QRF",[],[[]]]
		,["_probability",false,[false]]
		,["_createCrew",false,[false]]
		,["_isPatrolling",false,[false]]
		,["_isDefending",false,[false]]
		,["_isAttacking",false,[false]]
		,["_occupyBuildings",false,[false]]
		,["_isTarget",false,[false]]
		,["_dropIntel",false,[false]]
		,["_detonate",false,[false]]
		,["_captive",false,[false]]
		,["_isCrowd",false,[false]]
		,["_patrolAirspace",false,[false]]
	];

	if (_probability && _minPlayers <= count (allPlayers - entities "HeadlessClient_F") || !(isMultiplayer)) then {
		// Is a pre-existing map placed object
		if !(isNull (missionNamespace getVariable [_groupUID,objNull])) then {
			if (_isTarget) then {
				_createdTargets pushback (missionNamespace getVariable [_groupUID,objNull]);
			};
			_createdUnits pushback (missionNamespace getVariable [_groupUID,objNull]);
		} else {
			if (_groupPos isEqualTo "position") then { _groupPos =+ _position };
			if (_groupPos isEqualTo "positionOffset") then { _groupPos =+ _positionOffset };
			if (_groupPos isEqualTo [0,0,0]) then { _groupPos =+ _position };
			if (typeName _groupPos isEqualTo typeName "") then { _groupPos = _groupPos call BIS_fnc_position; };

			_distance = _distance call BIS_fnc_randomNum;
			_direction = _direction call BIS_fnc_randomNum;
			_radius = _radius call BIS_fnc_randomNum;
			_angle = _angle call BIS_fnc_randomNum;

			private _spawnPos =+ _groupPos;
			if (_distance > 0) then {
				_spawnPos = [_groupPos,_distance,_direction] call BIS_fnc_relPos;
			};

			if (count _vehicleTypes > 0) then {
				private _factionVehicleTypes = _vehicleTypes select {!((configFile >> "cfgVehicles" >> _x) call BIS_fnc_getCfgIsClass)};
				_vehicleTypes = _vehicleTypes - _factionVehicleTypes;
				_vehicleTypes append (["vehicles",_factionID,_factionVehicleTypes,false] call MPSF_fnc_getCfgFaction);

				switch (true) do {
					case (_crewTypes isEqualType []) : {};
					case (_crewTypes isEqualType "") : { _crewTypes = ["groupData",_factionID,_crewTypes] call MPSF_fnc_getCfgFaction; };
					default { _crewTypes = []; };
				};

				if (count _vehicleTypes > 0) then {
					([_spawnPos,_factionID,selectRandom _vehicleTypes,_angle,if (count _crewTypes > 0) then {_crewTypes} else {_createCrew}] call MPSF_fnc_createVehicle) params [["_vehicle",objNull,[objNull]],["_crew",[],[[]]]];
					if !(isNull _vehicle) then {
						if (_isTarget) then {
							{ _createdTargets pushback _x; } forEach [_vehicle];
							_vehicle setVariable ["returnpoint_taskID",_taskID,true];
						};
						if (count _crew > 0) then {
							private _driverGroup = group((_crew select 0) select 0);
							_createdGroups pushback _driverGroup;
							{ _createdUnits pushback (_x select 0); } forEach _crew;
							switch (true) do {
								case (_isPatrolling) : { [_driverGroup,_spawnPos,_radius] spawn MPSF_fnc_setGroupPatrol; };
								case (_isAttacking) : { [_driverGroup,_groupPos,true] spawn MPSF_fnc_setGroupAttack; };
								case (_isDefending) : { [_driverGroup,_spawnPos,_radius] spawn MPSF_fnc_setGroupPatrol; };
								case (_patrolAirspace) : { [_driverGroup] call MPSF_fnc_setGroupAirCombat;};
								default { [_driverGroup,_spawnPos] spawn MPSF_fnc_setGroupHold; };
							};
						};
					};
				};
			};

			if (count _groupTypes > 0) then {
				private _groupID = [_spawnPos,_factionID,selectRandom _groupTypes] call MPSF_fnc_createGroup;
				if !(isNull _groupID) then {
					_createdGroups pushback _groupID;
					private _groupUnits = units _groupID;
					if (_isTarget) then {
						{ _createdTargets pushback _x; } forEach _groupUnits;
					};
					{ _createdUnits pushback _x; } forEach _groupUnits;

					switch (true) do {
						case (_isPatrolling) : { [_groupID,_spawnPos,_radius] spawn MPSF_fnc_setGroupPatrol; };
						case (_isAttacking) : { [_groupID,_groupPos,true] spawn MPSF_fnc_setGroupAttack; };
						case (_isDefending && _occupyBuildings) : { [_groupID,_spawnPos,_radius] spawn MPSF_fnc_setGroupOccupy; };
						case (_isDefending) : { [_groupID,_spawnPos,_radius] spawn MPSF_fnc_setGroupDefend; };
						case (_isCrowd) : { [_groupID,_spawnPos,_radius] call MPSF_fnc_setGroupCrowd; };
						default { [_groupID,_spawnPos] spawn MPSF_fnc_setGroupHold; };
					};

					if (count _conversations > 0 && count _groupUnits > 0) then {
						private _conversationID = selectRandom _conversations;
						[(_groupUnits select 0),_conversationID,[_taskID]] call { missionNamespace getVariable ["MPSF_fnc_addConversation",{}] };
					};

					if (_dropIntel) then {
						[_groupUnits,[_taskID,_cfgTaskID]] spawn (missionNamespace getVariable ["MPSF_fnc_onKilledDropIntel",{}]);
					};

					/*if (count _QRF > 0) then {
						[_groupID,_factionID,_QRF] call MPSF_fnc_createCfgTaskQRF;
					};*/
				} else {
					//format ["createTaskGroups: Null Group ID Created"] call BIS_fnc_logFormat;
				};
			};

			if (count _objectTypes > 0) then {
				private _object = [selectRandom _objectTypes,_spawnPos,_angle] call MPSF_fnc_createObject;
				if !(isNull _object) then {
					if (_isTarget) then {
						_createdTargets pushback _object;
					};
					_createdObjects pushback _object;
					if (_occupyBuildings) then {
						private _buildings = nearestObjects [_spawnPos,["House_F"],_radius];
						if (count _buildings > 0) then {
							private _buildingPositions = [];
							{
								{ _buildingPositions pushBack _x; } forEach ([_x] call BIS_fnc_buildingPositions);
							} forEach (_buildings);
							if (count _buildingPositions > 0) then {
								_object setPos (selectRandom _buildingPositions);
							};
						} else {
							_object setVehiclePosition [(_spawnPos getPos [_radius,random 360]),[],0,"NONE"];
						};
					} else {
						_object setVehiclePosition [(_spawnPos getPos [_radius,random 360]),[],0,"NONE"];
					};
					["addObjectDamageEH_C4only",[[_object],[_taskID],true]] call MPSF_fnc_taskmaster;
				};
			};
		};
	};
} forEach _cfgTaskGroups;

if !(isNull _taskLogic) then {
	_taskLogic setVariable ["targets",_createdTargets,!(isServer)];
	_taskLogic setVariable ["groups",_createdGroups,!(isServer)];
	_taskLogic setVariable ["units",_createdUnits,!(isServer)];
	_taskLogic setVariable ["objects",_createdObjects,!(isServer)];
	_taskLogic setVariable ["cfgGroupsSet",true,!(isServer)];
};

["addUnitKilledEH",[(_createdTargets + _createdUnits),[_taskID]]] call MPSF_fnc_taskmaster;

[_createdGroups,_createdUnits,_createdTargets];