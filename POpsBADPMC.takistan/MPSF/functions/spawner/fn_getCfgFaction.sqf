/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getCfgFaction.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Faction Functions
*/
params [["_dataType","",[""]],["_faction","",[""]]];

private _factionID = [_faction] call MPSF_fnc_getCfgFactionID;
switch (_dataType) do {
	case "displayName";
	case "displayLongName";
	case "displayColour" : {
		["CfgMissionFramework","Factions",_factionID,_dataType] call MPSF_fnc_getCfgDataText;
	};
	case "displayColourRGBA" : {
		private _colour = ["displayColour",_factionID] call MPSF_fnc_getCfgFaction;
		[_colour] call MPSF_fnc_getConfigMarkerColour;
	};
	case "displayColourHEX" : {
		private _colour = ["displayColourRGBA",_factionID] call MPSF_fnc_getCfgFaction;
		[_colour] call BIS_fnc_colorRGBAtoHTML;
	};
	case "sideID" : {
		["CfgMissionFramework","Factions",_factionID,"side"] call MPSF_fnc_getCfgDataNumber;
	};
	case "side" : {
		private _sideID = ["sideID",_factionID] call MPSF_fnc_getCfgFaction;
		[east,west,resistance,civilian] select (0 max _sideID min 3);
	};
	case "groupIDs" : {
		["CfgMissionFramework","Factions",_factionID,"groups"] call BIS_fnc_getCfgSubClasses;
	};
	case "vehicleIDs" : {
		["CfgMissionFramework","Factions",_factionID,"vehicles"] call BIS_fnc_getCfgSubClasses;
	};
	case "groupData" : {
		private _groupID = _this param [2,"",[""]];
		private _return = ["CfgMissionFramework","Factions",_factionID,"groups",_groupID,"classNames"] call MPSF_fnc_getCfgDataArray;
		private _classIDs = ["CfgMissionFramework","Factions",_factionID,"groups",_groupID] call BIS_fnc_getCfgSubClasses;
		if (count _classIDs > 0) then {
			{
				private _path = ["CfgMissionFramework","Factions",_factionID,"groups",_groupID,_x];
				_return pushBack [
					(_path + ["className"]) call MPSF_fnc_getCfgDataText
					,(_path + ["loadout"]) call MPSF_fnc_getCfgDataText
				];
			} forEach _classIDs;
		};
		_return = _return apply { if !(_x isEqualType []) then { [_x] } else { _x }; };
		_return select { (configFile >> "CfgVehicles" >> (_x select 0)) call BIS_fnc_getCfgIsClass; };
	};
	case "vehicles" : {
		private _vehicleTypes = _this param [2,[],["",[]]];
		private _resolve = _this param [3,false,[false]];

		if !(_vehicleTypes isEqualType []) then { _vehicleTypes = [_vehicleTypes]; };

		private _return = [];
		private _vehicleTypes = _vehicleTypes apply { ["CfgMissionFramework","Factions",_factionID,"vehicles",_x,"classNames"] call MPSF_fnc_getCfgDataArray; };
		{ _return append _x; } forEach (_vehicleTypes);

		_return = _return select { (configFile >> "CfgVehicles" >> _x) call BIS_fnc_getCfgIsClass; };

		if (_resolve) then {
			selectRandom _return;
		} else {
			_return;
		};
	};
	case "crewTypes" : {
		private _vehicleType = _this param [2,"",[""]];
		["CfgMissionFramework","Factions",_factionID,"vehicles",format["crewTypes%1",_vehicleType]] call MPSF_fnc_getCfgDataArray;
	};
	default { false };
};