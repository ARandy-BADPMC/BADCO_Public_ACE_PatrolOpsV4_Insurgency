/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_effectExplosionSecondaries.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Creats secondary explosions over time
*/
if (isServer) then {
	_this spawn {
		params[["_target",objNull,[[],objNull]],["_amount",1,[0]],["_alive",true,[true]]];

		if (_target isEqualType []) then {
			_target = [_target] call MPSF_fnc_createLogic;
			_alive = false;
		};

		if !(_amount > 0) exitWith {};
		for "_i" from 1 to _amount do {
			sleep ((random 3) + 1);
			if ((_alive && {alive _target}) || {isnull _target || {(getposASL _target) select 2 < 0}}) exitwith {};
			createVehicle ["SmallSecondary", _target modelToWorld (_target selectionposition "destructionEffect2"), [], 0, "CAN_COLLIDE"];
		};

		if !(_alive) then { deleteVehicle _target; };
	};
};