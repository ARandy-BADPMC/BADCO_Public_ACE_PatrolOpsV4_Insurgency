params [["_logic",objNull,[objNull]],["_loadout","",[""]]];

if !(_logic isEqualType objNull) exitWith { /*["Error in paramters to create position: %1",str _this] call BIS_fnc_error;*/ false };

["createLoadoutAction",[_logic,_loadout]] spawn { sleep 0.6; _this call MPSF_fnc_virtualArmoury};

true;