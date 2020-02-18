if !(isServer) exitWith {};

params [["_leader",objNull,[grpNull,objNull]],["_faction",sideUnknown,[sideUnknown,""]],["_qrfTypes",[],["",[]]]];

if (isNull _leader) exitWith {false};
if (_faction isEqualTo sideUnknown) exitWith {};
if (count _qrfTypes == 0) exitWith {};

if (_leader isEqualType grpNull) then { _leader = leader _leader; };

_leader setVariable ["qrfType",selectRandom _qrfTypes];
_leader setVariable ["qrfFaction",_faction];
_leader setVariable ["squadStrength",count units _groupID];
_leader addEventHandler ["AnimChanged",{
	params [["_leader",objNull,[objNull]],["_anim","",[""]]];
	private _inCombat = (toUpper behaviour _leader) isEqualTo "COMBAT";
	private _nearPlayers = {_x distance _leader < 1500} count allPlayers > 0;
	private _squadKilled = ({alive _x} count (units group _leader)) < ((_leader getVariable ["squadStrength",10]) * 0.6);
	if (_inCombat && _nearPlayers && _squadKilled) then {
		_leader removeAllEventHandlers "AnimChanged";
		private _faction = _leader getVariable ["qrfFaction",side group _leader];
		private _qrfType = _leader getVariable ["qrfType",""];
		// Start QRF
		[_leader getVariable ["MPSF_Data_var_QRF",""]] call MPSF_fnc_createParadrop;
		if (alive _leader) then {
			["onRequestQRF",[getPos _leader,_faction,_qrfType],2] call MPSF_fnc_triggerEventHandler;
		};
	};
	if !(alive _leader) then {
		_leader removeAllEventHandlers "AnimChanged";
	};
}];

["MPSF_onRequestQRF_EH","onRequestQRF",{
	params [["_position",[0,0,0],[[]]],["_faction","".[""]],["_qrfType","",[""]]]
	if (_position isEqualTo [0,0,0] || _faction isEqualTo "" || _qrfType isEqualTo "") exitWith {};
	if ((missionNamespace getVariable [format["MPSF_QRF_%1_lastCall",_qrfType],MISSIONTIME] - MISSIONTIME) > 0) exitWith {};
	if (isServer) then {
		missionNamespace setVariable [format["MPSF_QRF_%1_lastCall",_qrfType],MISSIONTIME+1800];
		publicVariable format["MPSF_QRF_%1_lastCall",_qrfType];
		[_position,_faction,_qrfType] spawn MPSF_fnc_createQRFresponse;
	};
	if (hasInterface) then {
		player sideChat "Signal Intercepted: Enemy have requested QRF Support"; // TODO: Localize
	};
}] call MPSF_fnc_addEventHandler;

true;