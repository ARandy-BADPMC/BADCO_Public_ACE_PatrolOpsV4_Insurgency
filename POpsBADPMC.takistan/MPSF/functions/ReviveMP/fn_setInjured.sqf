params [["_unit",objNull,[objNull]],["_partsHit",["hands","legs","head","body"],[[]]]];

_partsHit select {_unit setHit [_x,0.8]; };

if (isServer) then {
	["onInjured",[_unit,true],0] call MPSF_fnc_triggerEventHandler;
};