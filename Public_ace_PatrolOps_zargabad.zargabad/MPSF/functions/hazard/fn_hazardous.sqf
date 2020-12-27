params [["_mode","",[""]],["_params",[],[[],false]]];

#define IEDTYPES	(selectRandom ["IEDLandBig_F","IEDUrbanBig_F","IEDLandSmall_F","IEDUrbanSmall_F"])
#define IEDTYPES2	(selectRandom ["DemoCharge_Remote_Ammo_Scripted","SatchelCharge_Remote_Ammo_Scripted"])

switch (_mode) do {
	case "createIED" : {
		_params params [["_position",[0,0,0],[[],objNull]],["_direction",0,[0]],["_size",-1,[0]],["_roadSide",true,[false]]];

		if (_position isEqualTo [0,0,0]) exitWith { /*["Invalid Position"] call BIS_fnc_error;*/ objNull };
		private _iedObject = _position;
		if (_position isEqualType []) then {
			if (_roadSide) then {
				_position = _position getPos [7,_direction + (selectRandom [90,-90])];
			};
			//_iedObject = createMine [IEDTYPES,_position,[],0];
			_iedObject = createVehicle [IEDTYPES2,_position,[],0,"CAN_COLLIDE"];
			_iedObject setVehiclePosition [_position,[],0,"CAN_COLLIDE"];
			_iedObject setDir _direction;
		};

		[[_iedObject]] call MPSF_fnc_addZeusObjects;

		if !(_iedObject isEqualType objNull) exitWith { /*["Unknown Object Type %1",[_iedObject] + _params] call BIS_fnc_error;*/ objNull };

		["onCreateIED",[_iedObject],0] spawn MPSF_fnc_triggerEventHandler;

		_iedObject
	};
	case "createVBIED" : {
		//
	};
	case "createHBIED" : {
		//
	};
	case "createSuicider" : {
		//
	};
// Funtions
	case "detonateIED" : {
		_params params [["_position",[0,0,0],[[],objNull]]];
		createVehicle ["Bo_GBU12_LGB_MI10",(_position call BIS_fnc_position),[],0,"NONE"];
	};
	case "getRoadsidePosition" : {
		_params params [["_position",[0,0,0],[[],objNull]],["_direction",-1,[0]]];

		//

		_position;
	};
// Trigger Actions
	case "createTriggerAction" : {
		diag_log str _this;
		if (hasInterface) then {
			_params params [["_iedObject",objNull,[objNull]]];

			if !(isNull (_iedObject getVariable ["Hazardous_Trigger",objNull])) exitWith {};

			private _trigger = createTrigger ["EmptyDetector",position _iedObject,false];
			_trigger setTriggerArea [5,5,getDir _iedObject,false];
			_trigger setTriggerActivation ["ANYPLAYER","PRESENT",true];
			_trigger setTriggerStatements ["this"
				,format["['activateTrigger',[thisTrigger]] call MPSF_fnc_hazardous;"]
				,format["['deactivateTrigger',[thisTrigger]] call MPSF_fnc_hazardous;"]
			];
			_trigger attachTo [_iedObject,[0,0,0]];
			_iedObject setVariable ["Hazardous_Trigger",_trigger];
		};
	};
	case "activateTrigger" : {
		_params params [["_trigger",objNull]];

		hint str _this;

		systemChat str attachedObjects _trigger;
		systemChat str attachedTo _trigger;

		private _iedObject = attachedTo _trigger;
		if (isNull _iedObject) exitWith { /*["Unable to retrieve IED attached to trigger %1",_iedObject] call BIS_fnc_error;*/ };

		// Defuse Action
		[format ["MPSF_IED_%1_Defuse_Action",(_iedObject call BIS_fnc_netId)],_iedObject,"Defuse IED",[
				["mpsf\data\holdactions\holdAction_depot_ca.paa",{}]
				,["mpsf\data\holdactions\holdAction_depot_ca.paa",{}]
				,{ ["openDepotUI",(_this select 3)] spawn MPSF_fnc_hazardous; }
				,{}
				,1,false,103
			],[_iedObject],
				"true"
			,true,false,105
		] spawn {sleep 0.1; _this call MPSF_fnc_addAction};

		// Detonate Action
		[format ["MPSF_IED_%1_Detonate_Action",(_iedObject call BIS_fnc_netId)],_iedObject,"Service Vehicle",{
			hint "BOOM";
		},[_iedObject],
				"true"
			,true,false,100
		] spawn {sleep 0.2; _this call MPSF_fnc_addAction};

		// Trigger Monitor
		//["MPSF_IEDTrigger_onEachFrame_EH","onEachFrame",{
			//
		//}] call MPSF_fnc_addEventHandler;

		["detonateIED",[_iedObject]] call MPSF_fnc_hazardous;
	};
	case "deactivateTrigger" : {
		["MPSF_IEDTrigger_onEachFrame_EH","onEachFrame"] call MPSF_fnc_removeEventHandler;
	};
// Eventhandlers
	case "eventhandlers" : {
		//["INIT Hazardous_Trigger EH"] call BIS_fnc_logFormat;
		["MPSF_Hazard_onCreateIED_EH","onCreateIED",{ ["createTriggerAction",_this] call MPSF_fnc_hazardous; }] call MPSF_fnc_addEventHandler;
	};
// Initialise
	case "postInit" : {
		["eventhandlers"] call MPSF_fnc_hazardous;
	};
};