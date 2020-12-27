/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_initSpawnerEH.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Initialise required mission event handlers
*/

// Deployable Objects
["MPSF_DeployableObject_EH","onObjectDeploy",{
	params [["_container",objNull,[objNull]],["_caller",objNull,[objNull]]];
	if (isServer) then {
		private _deployedClassname = _container getVariable ["deployedClassName",""];
		private _attributes = _container getVariable ["attributes",[]];

		if (_deployedClassname isEqualTo "") exitWith {};

		private _spawnPos = getPosATLVisual _container;
		private _spawnDir = getDir _container;
		private _spawnClass = typeOf _container;
		deleteVehicle _container;

		_deployed = createVehicle [_deployedClassname,_spawnPos,[],0,"CAN_COLLIDE"];
		_deployed setVehiclePosition [_spawnPos,[],0,"CAN_COLLIDE"];
		_deployed setDir _spawnDir;

		_deployed setVariable ["deployedClassName",_spawnClass,true];
		_deployed setVariable ["attributes",_attributes,true];

		if !(isNull _deployed) then {
			["onObjectDeployed",[_deployed,_spawnClass,_caller,_attributes],0] call MPSF_fnc_triggerEventHandler;
		};

		[format["MPSF_Deployable_%1",_deployed call BIS_fnc_netID],_deployed,format ["Deploy %1",_spawnClass],[
				["mpsf\data\holdactions\holdAction_repair_ca.paa",{_caller playAction "PutDown";}]
				,["mpsf\data\holdactions\holdAction_repair_ca.paa",{}]
				,{ ["onObjectDeploy",[_target,_caller],0] call MPSF_fnc_triggerEventHandler; }
				,{}
				,3,true
			],[],"damage _target < 1",0,true
		] spawn {sleep 0.125; _this call MPSF_fnc_addAction;};
	};
}] call MPSF_fnc_addEventHandler;

// USS Freedom Aircraft Carrier
["MPSF_Spawner_onCarrierCreated_EH","onCarrierCreated",{
	if !(isServer) then {
		params [["_carrierBase",objNull,[objNull]]];

		if (_carrierBase getVariable ["MPSF_Carrier_init",false]) exitWith {};
		_carrierBase setVariable ["MPSF_Carrier_init",true];

		if (count (_carrierBase getVariable ["bis_carrierParts", []]) == 0) then {
			//["Carrier %1 is empty. Client Fixing.",str "bis_carrierParts"] call BIS_fnc_logFormatServer;
			private _carrierPartsArray = (configFile >> "CfgVehicles" >> typeOf _carrierBase >> "multiStructureParts") call BIS_fnc_getCfgDataArray;
			private _partClasses = _carrierPartsArray apply {_x select 0};
			private _nearbyCarrierParts = nearestObjects [_carrierBase,_partClasses,500];
			{
				private _carrierPart = _x;
				private _index = _forEachIndex;
				{
					if ((_carrierPart select 0) isEqualTo typeOf _x) exitWith { _carrierPart set [0,_x]; };
				} forEach _nearbyCarrierParts;
				_carrierPartsArray set [_index,_carrierPart];
			} forEach _carrierPartsArray;
			_carrierBase setVariable ["bis_carrierParts",_nearbyCarrierParts];
			//["Carrier %1 was empty. Now contains %2.",str "bis_carrierParts",_carrierBase getVariable ["bis_carrierParts", []]] call BIS_fnc_logFormatServer;
		};

		[_carrierBase] spawn { sleep 1; _this call BIS_fnc_Carrier01Init};
	};
}] call MPSF_fnc_addEventHandler;

{
	["onCarrierCreated",[_x],true] call MPSF_fnc_triggerEventHandler;
} forEach (allMissionObjects "Land_Carrier_01_base_F");