/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createVehicle.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Sets a preconfigured loadout from cfgMissionArmoury If the unit is local to the server/client running the code

	Parameter(s):
			1: <ARRAY> - Position [x,y]
			2: <STRING/SIDE> - Side or Faction name from cfgMission_Sides
			3: <STRING> - Vehicle Class Name of Vehicle Type from cfgMission_Sides
			4: <NUMBER> - Direction from 0-360 degrees
			5: <BOOL> - Create Vehicle Crew
			6: <ARRAY/STRING> - Create Cargo from Array of Units or Group from cfgMission_Sides

	Returns:
		[<VEHICLE>,<VEHICLE GROUP>,<ARRAY OF UNITS IN VEHICLE>]

	Example:
		[screenToWorld [0.5,0.5],"FactionTypeBLU","B_MRAP_01_F",random 360,true,["B_soldier_f","B_soldier_f"]] call MPSF_fnc_createVehicle;
*/
params [
	["_position",[],[[]]]
	,["_faction",sideUnknown,[sideUnknown,""]]
	,["_className","",[""]]
	,["_direction",random 360,[0]]
	,["_spawnCrew",false,[false,[]]]
	,["_cargoUnits",[],[[],""]]
];

if (_className isEqualTo "") exitWith { [objNull,grpnull,[]] };

private _side = if (_faction isEqualType "") then {
	_faction = [_faction] call MPSF_fnc_getCfgFactionID;
	["side",_faction] call MPSF_fnc_getCfgFaction;
} else {
	_faction
};

if (_side isEqualTo sideUnknown) exitWith {
	/*["Invalid faction ID %1",_faction] call BIS_fnc_error;*/
	[objNull,grpnull,[]]
};

if !(isClass(configFile >> "cfgVehicles" >> _className)) then {
	_className = ["vehicles",_faction,_className,true] call MPSF_fnc_getCfgFaction;
};

if !(isClass(configFile >> "cfgVehicles" >> _className)) exitWith {
	/*["MissionBuilder Failed to create unknown vehicle %1 in spawnVehicle",_className] call BIS_fnc_error;*/
	[objNull,grpnull,[]]
};

private _crewTypes = [];
if (_spawnCrew isEqualType []) then {
	_crewTypes = +_spawnCrew;
	_spawnCrew = count _spawnCrew > 0;
};

if (_className isKindOf "Air" && surfaceIsWater _position) then { _position set [2,300]; };
private _state = if (_className isKindof "Air" && {_spawnCrew} && {(_position select 2) >= 200}) then {"FLY"} else {"NONE"};

private _vehicle = createVehicle [_className,_position,[],0,_state];
_vehicle allowDamage false;
_vehicle setVehiclePosition [_position,[],0,_state];
_vehicle setDir _direction;

clearWeaponCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;

private _vehicleGroup = [];
if (_spawnCrew) then { _vehicleGroup = [_vehicle,_side,_crewTypes] call MPSF_fnc_createCrew; };

private _sim = getText(configFile >> "CfgVehicles" >> _className >> "simulation");
if(_state == "FLY" && toLower _sim IN ["helicopter","helicopterrtd","airplane","airplanex"] && _spawnCrew) then {
	_vehicle engineOn true;
	if (toLower _sim IN ["helicopter","helicopterrtd"]) then {
		_vehicle flyInHeight 50;
		_vehicle setVelocity [130 * (sin _direction), 130 * (cos _direction), 0];
	} else {
		_vehicle flyInHeight 500;
		_vehicle setVelocity [450 * (sin _direction), 450 * (cos _direction), 0];
	};
};

private _spawnCargo = if (typeName _cargoUnits == typeName []) then { count _cargoUnits > 0 } else { typeName _cargoUnits == typeName "" };
if (_spawnCargo) then {
	private _spawnpos =+ _position;
	_spawnpos set [2,0];
	private _spawnCargoData = [_spawnpos,_faction,_cargoUnits] call MPSF_fnc_createGroup;
	if !(isNull (_spawnCargoData select 0)) then {
		{
			_x moveInCargo _vehicle;
			if (vehicle _x isEqualTo _x) then { deleteVehicle _x; };
		} forEach (_spawnCargoData select 1);
	};
};

_vehicle allowDamage true;
_vehicle enableDynamicSimulation true;

[[_vehicle]] call MPSF_fnc_addZeusObjects;

[_vehicle,fullCrew _vehicle select {!(toLower (_x select 1) isEqualTo "cargo")},fullCrew _vehicle select {toLower (_x select 1) isEqualTo "cargo"}]