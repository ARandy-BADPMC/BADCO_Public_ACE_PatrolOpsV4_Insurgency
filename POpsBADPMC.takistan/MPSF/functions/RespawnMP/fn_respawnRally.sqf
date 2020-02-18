params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "onRallypointAction" : {
		_params params [["_target",objNull,[objNull]],["_stage",0,[0]],["_frame",0,[0]]];
		if (local _reviver) then {
			switch (_stage) do {
				case 1 : { // Start
					player groupChat "Deploying Rallypoint";
				};
				case 2 : { // Progress
				};
				case 3 : { // Complete
					player groupChat "Deployed Rallypoint";
				};
				case 4 : { // Canceled
					player groupChat "Canceled Rallypoint";
				};
			};
		};
	};
	case "canDeploy" : {
		_params params [["_target",objNull,[objNull]]];
		vehicle _target isEqualTo _target
		&& {alive _target}
		&& {{_target distance2D (getMarkerPos _x) > 1000} count ([side group _target] call BIS_fnc_getRespawnMarkers) > 0}
		&& {isNull (missionNamespace getVariable ["MPSF_RespawnMP_rallypoint",objNull])}
	};
	case "rallypointAction" : {
		["MPSF_Respawn_onRallypointDeploy_EH",player,"Deploy Rallypoint",[
			["ui\data\actions\holdAction_connect_ca.paa",{}]
			,["ui\data\actions\holdAction_connect_ca.paa",{}]
			,{ ["onInjuryReviving",[_target,3],true] call MPSF_fnc_triggerEventHandler; }
			,{}
			,5,false],[],"['canDeploy',[player]] call MPSF_fnc_respawnRally",0
		] spawn {sleep 0.125; _this call MPSF_fnc_addAction;};
	};
	case "initRallyPoints" : {
		if !(["getCfgEnable",["respawn","Rallypoint"]] call MPSF_fnc_respawnMP) exitWith {};
		["MPSF_RespawnMP_onRallypointRemove_EH","onRallypointRemove",{["onRallypointRemove",_this] call MPSF_fnc_respawnRally;}] call MPSF_fnc_addEventHandler;
		["MPSF_RespawnMP_onRallypointAdd_EH","onRallypointAdd",{["onRallypointAdd",_this] call MPSF_fnc_respawnRally;}] call MPSF_fnc_addEventHandler;
		["MPSF_Respawn_onRallypointDeploy_EH","onRallypointDeploy",{["onRallypointDeploy",_this] call MPSF_fnc_respawnRally;}] call MPSF_fnc_addEventHandler;
		["rallypointAction"] call MPSF_fnc_respawnRally;
	};
};