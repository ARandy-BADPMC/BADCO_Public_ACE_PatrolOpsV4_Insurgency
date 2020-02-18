/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getTaskDescription.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Returns the variable to populate a task description dynamically
*/
params [["_dataType","",[""]],["_params",[],[[]]]];

switch (toLower _dataType) do {
	case "factionblushort" : {
		["displayName","FactionTypeBLU"] call MPSF_fnc_getCfgFaction;
	};
	case "factionblulong" : {
		["displayLongName","FactionTypeBLU"] call MPSF_fnc_getCfgFaction;
	};
	case "factionbluside" : {
		private _side = ["side","FactionTypeBLU"] call MPSF_fnc_getCfgFaction;
		[_side] call BIS_fnc_sideName;
	};
	case "factionopfshort" : {
		["displayName","FactionTypeOPF"] call MPSF_fnc_getCfgFaction;
	};
	case "factionopflong" : {
		["displayLongName","FactionTypeOPF"] call MPSF_fnc_getCfgFaction;
	};
	case "factionopfside" : {
		["side","FactionTypeOPF"] call MPSF_fnc_getCfgFaction;
	};
	case "vehiclename" : {
		private _objects = _params param [1,[],[[]]];
		if (count _objects > 0) then {
			[selectRandom _objects] call MPSF_fnc_getConfigDisplayName;
		} else {
			"Unknown";
		};
	};
	case "worldname" : {
		toUpper worldName;
	};
	case "worldregion" : {
		_params params [["_position",[0,0,0],[[]]]];
		private _worldSize = worldSize;
		private _worldCentre = [_worldSize/2,_worldSize/2,0];
		private _centreWidth = _worldSize/6;
		if (_position distance _worldCentre <= _centreWidth) exitWith { "Central" };
		private _regions = [["North West",292.5,337.5],["North",-22.5,22.5],["North East",22.5,67.5],["East",67.5,112.5],["South East",112.5,157.5],["South",157.5,202.5],["South West",202.5,247.5],["West",247.5,292.5]];
		private _dir = [_worldCentre,_position] call BIS_fnc_dirTo;
		private _return = "";
		{
			private _ref = _dir + 360;
			private _min = (_x select 1) + 360;
			private _max = (_x select 2) + 360;
			if (_ref >= _min && _ref <= _max) exitWith { _return = _x select 0; };
		} forEach _regions;
		_return;
	};
	case "gridreference" : {
		_params params [["_position",[0,0,0],[[]]]];
		mapGridPosition _position;
	};
	case "nearesttownX" : {
		_params params [["_position",[0,0,0],[[]]]];
		private _nearTowns = nearestLocations [_position,["NameCityCapital","NameCity","NameVillage"],2000];
		private _return = "Grid " + (mapGridPosition _position);
		if (count _nearTowns > 0) then {
			_return = text (_nearTowns select 0);
		};
		_return
	};
	case "nearesttown";
	case "nearestlocation" : {
		_params params [["_position",[0,0,0],[[]]]];
		private _nearTowns = nearestLocations [_position,["NameCity","NameCityCapital","NameMarine","NameVillage","NameLocal"],2000];
		private _return = "Grid " + (mapGridPosition _position);
		if (count _nearTowns > 0) then {
			_return = text (_nearTowns select 0);
		};
		_return
	};
	case "randomcode" : {
		toUpper format["%1-%2",[2] call MPSF_fnc_getRandomString,[4] call MPSF_fnc_getRandomString];
	};
	case "operationname" : {
		[] call MPSF_fnc_getRandomOpName;
	};
	case "missionname" : {
		missionName;
	};
	case "briefingname" : {
		briefingName;
	};
	case "servername" : {
		serverName;
	};
	case "playername" : {
		name player
	};
	case "hh";
	case "hh:mm";
	case "hh:mm:ss" : {
		[daytime,toUpper _dataType] call BIS_fnc_timeToString;
	};
	case "datetime" : {
		private _month = str (date select 1);
		private _day = str (date select 2);
		private _hour = str (date select 3);
		private _minute = str (date select 4);
		if (date select 1 < 10) then { _month = format ["0%1",str (date select 1)]; };
		if (date select 2 < 10) then { _day = format ["0%1",str (date select 2)]; };
		if (date select 3 < 10) then { _hour = format ["0%1",str (date select 3)]; };
		if (date select 4 < 10) then { _minute = format ["0%1",str (date select 4)]; };
		format ["%1-%2-%3 %4:%5", str (date select 0), _month, _day, _hour, _minute];
	};
	default {
		private _return = missionNamespace getVariable [_dataType,format["%1",_dataType]];
		if !(typeName _return == typeName "") then { str _return; } else { _return; };
	};
};