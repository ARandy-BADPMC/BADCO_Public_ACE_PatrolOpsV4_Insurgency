/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_setVehicleHealth.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Reset a vehicles health
*/
params [["_vehicle",objNull]];

private _hitPoints = [_vehicle,true] call MPSF_fnc_getConfigVehicleHitpoints;
private _validHitPoints = ["HitLFWheel","HitLBWheel","HitLMWheel","HitLF2Wheel","HitRFWheel","HitRBWheel","HitRMWheel","HitRF2Wheel" ,"HitEngine", "HitLTrack","HitRTrack","HitFuel","HitAvionics","HitVRotor","HitHRotor"];
_hitPoints = _hitPoints arrayIntersect _validHitPoints;

{
	//if (_x in _validHitPoints) then {
		_vehicle vehicleChat format ["Repairing: %1",str round((_forEachIndex/count _hitpoints)*100) + "%"];
		_vehicle getHitPointDamage _x;
		_vehicle setHitPointDamage [_x,0];
		sleep 1;
		if !(_vehicle call _validateVehicle) exitWith {};
	//};
} forEach _hitPoints;

_vehicle setDamage 0;
_vehicle vehicleChat format ["Repairing: %1",str((1 - (damage _vehicle))*100) + "%"];