/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createCarrier01.sqf
	Author(s): Roy86

	Description:
		It spawns a functioning Carrier

	Parameter(s):
		0: ARRAY/OBJECT - Position of carrier
		1: NUMBER - if position array, direction number is used
		2: BOOL - Create carrier defences
		3: BOOL - Create Deck Clutter
		4: BOOL - Create a respawn_west_carrier marker for BIS and compatible Respawn
		5: BOOL - Create Vehicle Virtual Depots
		6: BOOL - Create Virtual Arsenal Points

	Returns:
		OBJECT - Carrier Base
*/
if !(isServer) exitWith {};

params [
	["_position",[0,0,0],[[],objNull]]
	,["_direction",0,[0]]
	,["_defenses",false,[false]]
	,["_deckObjects",false,[false]]
	,["_respawn",false,[false]]
	,["_virtualDepot",false,[false]]
	,["_virtualArsenal",false,[false]]
];

if (_position isEqualType objNull) then {
	_direction = (getDir _position) + 180;
	_position = _position call BIS_fnc_position;
};

private _carrier = createVehicle ["Land_Carrier_01_base_F",_position,[],0,"None"];
_carrier setPosWorld _position;
_carrier setDir _direction;
[_carrier] call BIS_fnc_Carrier01PosUpdate;

["onCarrierCreated",[_carrier],0] call MPSF_fnc_triggerEventHandler;

if (_defenses) then {
	private _defenceObjectArray = [
		["B_SAM_System_02_F",[30.062,174.59,21.9526],75]
		,["B_AAA_System_01_F",[-16.8706,188.882,13.9553],0.956]
		,["B_SAM_System_01_F",[-39.0879,178.476,21.9668],0]
		,["B_SAM_System_02_F",[-28.6377,-100.764,21.2904],270.913]
		,["B_AAA_System_01_F",[-29.8869,-105.509,20.3317],270.913]
		,["B_SAM_System_01_F",[24.8462,-115.089,18.6639],90]
		,["B_AAA_System_01_F",[47.8657,-0.0559375,20.6829],90]
		//,["Sign_Arrow_Large_F",[-28.8706,110.882,24.3244],90]
	];
	private _defenceObjects = [];
	{
		_x params ["_class","_offset","_dir"];
		_turret = createVehicle [_class,[0,0,1000],[],0,"CAN_COLLIDE"];
		_turret enableSimulationGlobal false;
		_turret allowDamage false;
		_turret attachTo [_carrier,_offset];
		_turret setDir _dir;
		createVehicleCrew _turret;
		_turret enableSimulationGlobal true;
		detach _turret;
		_turret setDir (_dir + 180);
		_defenceObjects pushBack _turret;
	} forEach _defenceObjectArray ;

	[_defenceObjects,allCurators,true] call MPSF_fnc_addZeusObjects;
};

if (_deckObjects) then {
	private _deckObjectArray = [
		["B_CargoNet_01_ammo_F",[-40.7881,90.2271,24.3429],0,false]
		,["B_CargoNet_01_ammo_F",[-38.6631,90.2275,24.3429],0,false]
		,["B_Plane_Fighter_01_F",[-33.1792,52.6475,25.8617],87.0001,false]
		,["B_Plane_Fighter_01_F",[-33.6758,10.5229,25.8964],87.0006,false]
		,["B_Plane_Fighter_01_F",[-32.9292,39.2734,25.8617],90.0001,false]
		,["B_Plane_Fighter_01_F",[-33.0508,26.1484,25.8964],90.0006,false]
		,["B_Plane_Fighter_01_F",[30.9355,152.724,25.9168],217.001,false]
		,["B_Plane_Fighter_01_F",[36.9976,142.372,25.9006],257.998,false]
		,["B_Slingload_01_Cargo_F",[-35.5381,98.4771,24.8797],3,false]
		,["B_Slingload_01_Cargo_F",[-40.6289,113.745,24.8797],0,false]
		,["B_Slingload_01_Cargo_F",[-24.9673,119.817,24.8797],0,false]
		,["B_Slingload_01_Fuel_F",[-31.6079,119.995,24.8801],180,false]
		,["B_Slingload_01_Repair_F",[-34.3027,120.071,24.8782],180,false]
		,["Box_NATO_AmmoVeh_F",[-30.3984,94.1558,24.338],0,false]
		,["CargoNet_01_barrels_F",[-32.4131,94.1021,24.0464],0,false]
		,["CargoNet_01_barrels_F",[-34.2051,94.0518,24.0464],0,false]
		,["CargoNet_01_box_F",[-40.7881,92.3521,24.1526],0,false]
		,["Land_Basketball_01_F",[-34.6265,107.29,23.5927],0.665,false]
		,["Land_Cargo10_military_green_F",[-35.4038,115.119,24.8705],270,false]
		,["Land_Cargo10_military_green_F",[-40.5381,99.8521,24.8705],270,false]
		,["Land_Cargo20_military_green_F",[-40.7324,120.164,24.842],90,false]
		,["Land_DieselGroundPowerUnit_01_F",[-40.7622,134.825,24.3643],0,false]
		,["Land_DieselGroundPowerUnit_01_F",[-39.9976,131.553,24.3643],360,false]
		,["Land_Football_01_F",[-40.0342,110.472,23.6019],0,false]
		,["Land_GymBench_01_F",[-40.7881,104.852,24.108],270,false]
		,["Land_GymBench_01_F",[-40.7881,107.477,24.108],270,false]
		,["Land_GymRack_01_F",[-34.7881,106.852,24.6128],87,false]
		,["Land_GymRack_02_F",[-34.9131,109.102,24.1519],90,false]
		,["Land_GymRack_03_F",[-41.2881,109.977,24.1014],0,false]
		,["Land_GymRack_03_F",[-40.4131,109.977,24.1014],0,false]
		,["Land_JetEngineStarter_01_F",[-21.77,108.989,24.6822],180,false]
		,["Land_JetEngineStarter_01_F",[-27.9131,58.3521,24.6822],270,false]
		,["Land_JetEngineStarter_01_F",[-29.2881,3.85205,24.6822],270,false]
		,["Land_Pallet_MilBoxes_F",[-35.9131,94.1021,23.9688],90,false]
		,["Land_PaperBox_closed_F",[-40.7881,96.4771,24.1618],0,false]
		,["Land_PaperBox_closed_F",[-40.7881,94.4771,24.1618],0,false]
		,["Land_PressureWasher_01_F",[-41.0381,136.727,24.1032],360,false]
		,["Land_Rugbyball_01_F",[-39.6602,110.349,23.5791],55,false]
		//,["Sign_Arrow_Large_F",[0,0,24.3244],0,false]
	];
	private _deckObjects = [];
	{
		_x params ["_class","_offset","_dir","_simulate"];
		_object = createVehicle [_class,[0,0,1000],[],0,"CAN_COLLIDE"];
		if (_class isEqualTo "B_Plane_Fighter_01_F") then {
			_object animate ["wing_fold_l",1,true];
			_object animate ["wing_fold_r",1,true];
		};

		_offset set [2,(_offset select 2) - 0.7];

		_object allowDamage false;
		_object setPosWorld (_carrier modelToWorldVisual _offset);
		_object setDir (_direction + _dir);
		_object lock 2;
		_object setFuel 0;
		_object setVehicleAmmo 0;
		_object enableSimulationGlobal _simulate;
		_deckObjects pushBack _object;
	} forEach _deckObjectArray ;
};

if (_respawn) then {
	private _respawnOffset = _carrier modelToWorldVisual [-27.8706,110.882,24.3244];
	private _respawnMarker = createMarker [ format ["respawn_west_carrier_%1",_carrier call BIS_fnc_netId],_respawnOffset];
};

if (_virtualDepot) then {
	private _carrierDepots = ["getCfgCarrierDepots"] call (missionNamespace getVariable ["MPSF_fnc_VirtualDepot",{[]}]);
	if (count _carrierDepots > 0) then {
		{
			_x params ["_depotID","_depotOffset","_depotDir","_depotClassNames"];
			private _depotLogic = [[0,0,0]] call MPSF_fnc_createLogic;
			_depotLogic setPosWorld (_carrier modelToWorldVisual _depotOffset);
			_depotLogic setDir (_direction + _depotDir);
			[_depotLogic
				,_depotClassNames
				,"FactionTypeBLU"
				,true,true,true
				,_carrier call BIS_fnc_netId
			] call (missionNamespace getVariable ["MPSF_fnc_createVirtualDepot",{}]);
		} forEach _carrierDepots;
	};
};

if (_virtualArsenal) then {
	//
};

_carrier;