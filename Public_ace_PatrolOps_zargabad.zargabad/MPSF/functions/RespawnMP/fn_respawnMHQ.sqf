params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "onMHQinit" : {
		_params params [["_MHQvehicle",objNull,[objNull]],["_target",-1,[0]]];

		if (isServer) then {
			_MHQvehicle setVariable ["MPSF_RespawnMP_MHQ",true,true];
			_MHQvehicle setVariable ["MPSF_RespawnMP_MHQside",_target,true];
		};

		if (hasInterface) then {
			if !(isNull (_MHQvehicle getVariable ["MPSF_RespawnMP_MHQ_Trigger",objNull])) exitWith {};

			private _trigger = createTrigger ["EmptyDetector",_MHQvehicle,false];
			_trigger setTriggerArea [6,6,getDir _MHQvehicle,false,4];
			_trigger setTriggerActivation ["ANYPLAYER","PRESENT",true];
			_trigger setTriggerStatements ["(vehicle player) in thisList"
				,format["['activateActionMHQ',[thisTrigger]] call MPSF_fnc_respawnMHQ;"]
				,format["['deactivateActionMHQ',[thisTrigger]] call MPSF_fnc_respawnMHQ;"]
			];
			_trigger attachTo [_MHQvehicle,[0,0,0]];
			_MHQvehicle setVariable ["MPSF_RespawnMP_MHQ_Trigger",_trigger];
			if (_target >= 0) then {
				_MHQvehicle setVariable ["VirtualDepot_Side",_target];
			};
			if (time > 0) then {
				["ScoreAdded",["MHQ Deployed to Battlefield.",5]] call BIS_fnc_showNotification;
			};
		};
	};
	case "onDeployMHQ" : {
		_params params [["_target",objNull,[objNull]],["_caller",objNull,[objNull]]];
		if (local _target) then {
			_target allowDamage false;
			_target lock 2;
			["setMHQdeployed",[_target,true]] call MPSF_fnc_respawnMHQ;
		};

		if (isServer) then {
			["addPosition",[format ["MPSF_RespawnMP_MHQ%1_RespawnPos",_target call BIS_fnc_netId],side group _caller,_target]] call MPSF_fnc_respawnMP;
		};

		if (hasInterface) then {
			if (["isMHQfriendly",[_target,player]] call MPSF_fnc_respawnMHQ) then {
				["ScoreAdded",[format ["MHQ Deployed %1",mapGridPosition _target],5]] call BIS_fnc_showNotification;
				[sideunknown,"SentGenBaseUnlockRespawn"] call BIS_fnc_sayMessage;
			};
		};
		true;
	};
	case "onUndeployMHQ" : {
		_params params [["_target",objNull,[objNull]],["_caller",objNull,[objNull]]];
		if (local _target) then {
			_target allowDamage true;
			_target lock 0;
			["setMHQdeployed",[_target,false]] call MPSF_fnc_respawnMHQ;
		};
		if (isServer) then {
			["removePosition",[format ["MPSF_RespawnMP_MHQ%1_RespawnPos",_target call BIS_fnc_netId],side group _caller]] call MPSF_fnc_respawnMP;
		};
		if (hasInterface) then {
			if (["isMHQfriendly",[_target,player]] call MPSF_fnc_respawnMHQ) then {
				["ScoreAdded",[format ["MHQ Undeployed %1",mapGridPosition _target],5]] call BIS_fnc_showNotification;
			};
		};
		true;
	};
	case "activateActionMHQ" : {
		_params params [["_trigger",objNull]];

		private _MHQvehicle = attachedTo _trigger;
		if (isNull _MHQvehicle) exitWith { /*["Unable to retrieve depot logic attached to trigger"] call BIS_fnc_error;*/ };

		// Deploy MHQ
		[format ["MPSF_%1_Respawn_DeployMHQ_Action",_MHQvehicle call BIS_fnc_netId],_MHQvehicle,"Deploy MHQ",[
			["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
			,["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
			,{ ["onDeployMHQ",[_target,_caller],0] spawn MPSF_fnc_triggerEventHandler; }
			,{}
			,3,false,103
		],[],"(['canDeployMHQ',[_target]] call MPSF_fnc_respawnMHQ)"
		,true] spawn { sleep 0.1; _this call MPSF_fnc_addAction; };

		// Undeploy MHQ
		[format ["MPSF_%1_Respawn_UndeployMHQ_Action",_MHQvehicle call BIS_fnc_netId],_MHQvehicle,"Pack Up MHQ",[
			["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
			,["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
			,{ ["onUndeployMHQ",[_target,_caller],0] spawn MPSF_fnc_triggerEventHandler; }
			,{}
			,3,false,102
		],[],"(['canUndeployMHQ',[_target]] call MPSF_fnc_respawnMHQ)"
		,true] spawn { sleep 0.2; _this call MPSF_fnc_addAction; };

		// Player Redeploy Menu
		[format ["MPSF_%1_Respawn_RedeployMHQ_Action",_MHQvehicle call BIS_fnc_netId],_MHQvehicle,"Redploy Soldier",[
			["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
			,["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
			,{ ["openUI"] spawn MPSF_fnc_respawnMP; }
			,{}
			,3,false,101
		],[],"(['isMHQdeployed',[_target]] call MPSF_fnc_respawnMHQ) && (vehicle player isEqualTo player)"
		,true] spawn {sleep 0.3; _this call MPSF_fnc_addAction;};

		// Player Mission Menu
		if !(isNil {missionNamespace getVariable "PO4_fnc_operations"}) then {
			[format ["MPSF_%1_Respawn_MissionyMHQ_Action",_MHQvehicle call BIS_fnc_netId],_MHQvehicle,"AccessCommand Centre",[
				["mpsf\data\holdactions\holdAction_map.paa",{}]
				,["mpsf\data\holdactions\holdAction_map.paa",{}]
				,{["openUI"] call (missionNamespace getVariable ["PO4_fnc_operations",{}])}
				,{}
				,3,false,101
			],[],"(['isMHQdeployed',[_target]] call MPSF_fnc_respawnMHQ) && (vehicle player isEqualTo player)"
			,true] spawn {sleep 0.3; _this call MPSF_fnc_addAction;};
		};
	};
	case "deactivateActionMHQ" : {
		_params params [["_trigger",objNull],["_target",objNull,[[],objNull]]];
		private _MHQvehicle = attachedTo _trigger;
		if (isNull _MHQvehicle) exitWith { /*["Unable to retrieve depot logic attached to trigger"] call BIS_fnc_error;*/ };
		[format ["MPSF_%1_Respawn_DeployMHQ_Action",_MHQvehicle call BIS_fnc_netId],player] call MPSF_fnc_removeAction;
		[format ["MPSF_%1_Respawn_UndeployMHQ_Action",_MHQvehicle call BIS_fnc_netId],player] call MPSF_fnc_removeAction;
		[format ["MPSF_%1_Respawn_RedeployMHQ_Action",_MHQvehicle call BIS_fnc_netId],player] call MPSF_fnc_removeAction;
		[format ["MPSF_%1_Respawn_MissionyMHQ_Action",_MHQvehicle call BIS_fnc_netId],player] call MPSF_fnc_removeAction;
	};
	case "canDeployMHQ" : {
		_params params [["_target",objNull,[objNull]]];
		!(["isMHQdeployed",[_target,false]] call MPSF_fnc_respawnMHQ)
		&& alive _target
		&& count (crew _target) == 0
	};
	case "canUndeployMHQ" : {
		_params params [["_target",objNull,[objNull]]];
		(["isMHQdeployed",[_target,false]] call MPSF_fnc_respawnMHQ)
		&& alive _target
		&& count (crew _target) == 0
	};
	case "setMHQdeployed" : {
		_params params [["_target",objNull,[objNull]],["_state",false,[false]]];
		_target setVariable ["MPSF_RespawnMP_MHQstate",_state,true];
		true;
	};
	case "isMHQdeployed" : {
		_params params [["_target",objNull,[objNull]],["_default",false,[false]]];
		private _return = _target getVariable ["MPSF_RespawnMP_MHQstate",_default];
		//hint str [_target,_return];
		_return;
	};
	case "isMHQfriendly" : {
		_params params [["_target",objNull,[objNull]],["_unit",player,[objNull]]];
		private _sideMHQ = _target getVariable ["MPSF_RespawnMP_MHQside",-1];
		if (_sideMHQ < 0) exitWith { true };
		private _sideUnit = (side group _unit) call BIS_fnc_sideID;
		(_sideMHQ isEqualTo _sideUnit);
	};
	case "preInit";
	case "postInit";
	case "init" : {
		{ ["onMHQinit",[_x]] call MPSF_fnc_respawnMHQ; } forEach (vehicles select { _x getVariable ["MPSF_RespawnMP_MHQ",false]; });
		["MPSF_RespawnMP_onMHQinit_EH","onMHQinit",{ ["onMHQinit",_this] call MPSF_fnc_respawnMHQ; }] call MPSF_fnc_addEventHandler;
		["MPSF_RespawnMP_onDeployMHQ_EH","onDeployMHQ",{["onDeployMHQ",_this] call MPSF_fnc_respawnMHQ;}] call MPSF_fnc_addEventHandler;
		["MPSF_RespawnMP_onUndeployMHQ_EH","onUndeployMHQ",{["onUndeployMHQ",_this] call MPSF_fnc_respawnMHQ;}] call MPSF_fnc_addEventHandler;
	};
};