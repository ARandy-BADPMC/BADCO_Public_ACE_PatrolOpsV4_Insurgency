params [["_target",objNull,[objNull]],["_side",sideUnknown,[sideUnknown]]];

if (isNull _target || _side isEqualTo sideUnknown) exitWith { /*["Error in paramters to create MHQ: %1",str _this] call BIS_fnc_error;*/ false };

["onMHQinit",[_target,_side call BIS_fnc_sideID],0] call MPSF_fnc_triggerEventHandler;

true;