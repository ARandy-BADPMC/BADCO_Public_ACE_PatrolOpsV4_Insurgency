/*
	Description:
	This function updates the misison parameter type
		- PARAM Only
*/
if !(hasInterface) exitWith {};

_this spawn {
	params [["_type",0,[0]]];
	waitUntil {!(isNull player)};
	switch (_type) do {
		case 0 : {
			player enableFatigue false;
			["MPSF_Fatigue_onRespawn_EH","onRespawn",{
				player enableFatigue false;
			}] call MPSF_fnc_addEventHandler;
		};
		case 1 : {
			player enableFatigue true;
			["MPSF_Fatigue_onRespawn_EH","onRespawn",{
				player enableFatigue true;
			}] call MPSF_fnc_addEventHandler;
		};
	};
};

true;