/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createCrew.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Creats a crew in a vehicle
*/
params [["_vehicle",objNull,[objNull]],["_side",sideUnknown,[sideUnknown,""]],["_crewTypes",[],[[],""]]];

if (isNull _vehicle) exitWith { /*["Vehicle is Null. Cannot spawn crew."] call BIS_fnc_error;*/ [] };
if !(_crewTypes isEqualType []) then { _crewTypes = [_crewTypes]; };

if (_side isEqualTo sideUnknown || {(count _crewTypes) isEqualTo 0}) then {
	createVehicleCrew _vehicle;
} else {
	private _groupID = createGroup _side;
		if !(isNull _groupID) exitWith {
		{
			_x params ["_role","_turretPath"];
			if (toLower (_role) in ["driver","gunner","commander","turret"]) then {
				private _unitData = _crewTypes select (_forEachIndex % (count _crewTypes));
				if (typeName _unitData isEqualTo typeName "") then { _unitData = [_unitData]; };
				_unitData params [["_unitType","",[""]],["_unitLoadout","",[""]]];

				private _unit = _groupID createUnit [_unitType,[0,0,100],[],0,"NONE"];
				_unit setSkill 0.7;
				_unit allowFleeing 0;
				if !(_unitLoadout isEqualTo "") then {
					[_unit,_unitLoadout] call MPSF_fnc_setUnitLoadout;
				};

				switch (toLower _role) do {
					case "driver" : { _unit moveInDriver _vehicle; };
					case "gunner" : { _unit moveInGunner _vehicle; };
					case "commander" : { _unit moveInCommander _vehicle; };
					case "turret" : { _unit moveInTurret [_vehicle,_turretPath]; };
					case "turret_ffv" : { _unit moveInTurret [_vehicle,_turretPath]; };
				};
			};
		} forEach ([_vehicle,true] call MPSF_fnc_getVehicleRoles);
	};
};

fullCrew _vehicle;