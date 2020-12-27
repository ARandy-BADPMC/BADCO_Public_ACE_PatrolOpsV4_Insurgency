_trigger = _this select 0;
_grp = (_trigger getVariable ["group",0]);
_units = units _grp;
_wasAlive = [];
{
	if (alive _x) then {_wasAlive pushback _x};
	_x setdamage 1;
	deleteVehicle _x
} foreach _units;
deleteGroup _grp;
if (count _wasAlive < 1) then {deleteVehicle _trigger;};

