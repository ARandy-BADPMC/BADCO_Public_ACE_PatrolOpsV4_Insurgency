if !(isServer) exitWith {};

params [["_logic",objNull,[objNull,[]]],["_orientation",[5,5,0],[[]]],["_destination","",[[],""]]];

if (_logic isEqualTo objNull) exitWith { false };

["addRedeployPoint",[_logic,_orientation,_destination],true] call MPSF_fnc_triggerEventHandler;

true;