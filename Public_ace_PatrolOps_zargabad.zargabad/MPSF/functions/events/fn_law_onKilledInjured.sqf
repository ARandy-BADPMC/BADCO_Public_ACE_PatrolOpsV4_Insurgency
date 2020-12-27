params [["_unit",objnull,[objnull]]];

_unit addEventhandler ["handleDamage",{
	params ["_unit","_part","_damage","_source","_ammo"];
	if (lifestate _unit == "incapacitated") exitwith {0.9};
	if (vehicle _unit != _unit) exitwith {_damage};
	if (isPlayer _source) then {
		_unit setdamage 0.9;
		_unit setUnconscious true;
		_unit disableconversation true;
		_unit setspeaker "base";
		_unit disableai "move";
		_unit disableai "target";
		_unit disableai "autotarget";
		[_unit] join grpnull;
	};
}];

_unit addEventhandler ["killed",{
	params[["_target",objNull,[objNull]],["_killer",objNull,[objNull]]];
	if (isPlayer _killer) then {
		_counter = ["BIS_incapacitatedKills",1] call BIS_fnc_counter;
		if (_counter == 1) then {
			["Orange_incapacitatedKilled",[],0] call MPSF_fnc_triggerEventHandler;
		};
		_target setvelocity [0,0,0];
	};
}];

true;