/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_group.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Linked to BIS Dynamic Groups, this is the group management functions
*/
#include "\A3\Functions_F_MP_Mark\DynamicGroupsCommonDefines.inc"

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "create" : {
		if !(isServer) exitWith { grpNull };
		_params params [["_player",objNull,[objNull]],["_register",false,[false]]];
		if (isNull _player) exitWith { grpNull };
		// Create the new group in which we will put player
		private _group = createGroup (side group _player);
		// Join player to new group
		[_player] joinSilent _group;
		if (_register) then { ["RegisterGroup",[_group,_player]] call MPSF_fnc_squadMod; };
		_group
	};
	case "join" : {
		if !(isServer) exitWith {};
		_params params [["_group",grpNull,[grpNull]],["_player",objNull,[objNull]]];
		if (!isNull _player && {group _player != _group}) then {
			private _oldGroup 	= group _player;
			private _units		= units _oldGroup - [_player];
			[_player] joinSilent _group;
			if (count _units < 1) then {
				["onSquadRemove",[_oldGroup],0] call MPSF_fnc_triggerEventHandler;
			};
			//["OnPlayerGroupChanged",[_player,_group]] call MPSF_fnc_squadMod;
			["onSquadUpdate",[],0] call MPSF_fnc_triggerEventHandler;
		};
	};
	case "delete" : {
		_params params [["_group",grpNull,[grpNull]]];
		if (!isNull _group && {local _group}) then {
			if (count units _group > 0) then {
				{
					[_x] joinSilent grpNull;
				} forEach (units _group);
			};
			deleteGroup _group;
		};
	};
	case "register" : {
		if !(isServer) exitWith {};
		_params params [["_group",grpNull,[grpNull]],["_leader",objNull,[objNull]],["_data",[],[[]]]];

		if (!isNull _group && {!isNull _leader} && {_leader == leader _group}) then {
			_data params [["_name",groupId _group,[""]],["_locked",false,[true]],["_insignia","",[""]]];

			if (_insignia isEqualTo "") then { _insignia = ["LoadRandomInsignia"] call MPSF_fnc_squadMod; };

			_group setVariable [VAR_GROUP_REGISTERED,true,true];
			_group setVariable [VAR_GROUP_CREATOR,_leader,true];
			_group setVariable [VAR_GROUP_INSIGNIA,_insignia,true];
			_group setVariable [VAR_GROUP_PRIVATE,_locked,true];
			_group setVariable [VAR_GROUP_VAR,format ["%1_%2_%3",_name,getPlayerUID _leader,time],true];

			// Set the default name of the group
			_group setGroupIdGlobal [_name];

			// Set insignia for all members of the group
			{
			//	["OnPlayerGroupChanged", [_x, _group]] call MPSF_fnc_squadMod;
			} forEach units _group;

			["onSquadUpdate",[],0] call MPSF_fnc_triggerEventHandler;
			//["RegisterGroup: Group (%1) registered with leader (%2)", _group, _leader] call BIS_fnc_logFormat;
		};
	};
	case "deregister" : {
		_params params [["_group",grpNull,[grpNull]],["_keep",false,[false]]];
		if (!isNull _group && {["IsGroupRegistered", [_group]] call MPSF_fnc_squadMod}) then {

			["onGroupUnregister",[_group],0] call MPSF_fnc_triggerEventHandler;

			if (_keep || {count units _group > 0}) then {
				_group setVariable [VAR_GROUP_REGISTERED,nil,true];
				_group setVariable [VAR_GROUP_CREATOR,nil,true];
				_group setVariable [VAR_GROUP_INSIGNIA,nil,true];
				_group setVariable [VAR_GROUP_PRIVATE,nil,true];
				_group setVariable [VAR_GROUP_VAR,nil,true];
			} else  {
				["DeleteGroup",[_group]] call MPSF_fnc_squadMod;
			};
			//["UnregisterGroup: Group (%1) unregistered and deleted (%2)", _group, _keep] call BIS_fnc_logFormat;
		};
	};
	case "isRegistered" : {
		_params params [["_group",grpNull,[grpNull]]];
		_group getVariable [VAR_GROUP_REGISTERED, false];
	};
	case "getGroups" : {
		_params params [["_registered",false,[false]],["_side",sideUnknown,[sideUnknown]]];
		private _groups = allGroups select {isPlayer leader _x || !(isMultiplayer)};
		if (_registered) then {
			_groups = _groups select {["IsGroupRegistered",[_x]] call MPSF_fnc_squadMod;};
		};
		if !(_side isEqualTo sideUnknown) then {
			_groups = _groups select {side _x == _side};
		};
		_groups;
	};
	case "getGroupUnits" : {
		_params params [["_group",grpNull,[grpNull]]];
		private _units = [leader _group];
		{ _units pushBack _x; } forEach (units _group - _units);
		_units;
	};
	case "getUnregisteredUnits" : {
		_params params [["_side",sideUnknown,[sideUnknown]]];
		private _groups = ["getGroups",[false,_side]] call MPSF_fnc_squadMod;
		private _units = [];
		{
			if !(["IsGroupRegistered", [_x]] call MPSF_fnc_squadMod) then {
				_units append (units _x);
			};
		} forEach _groups;
		_units;
	};
	case "setName" : {
		if !(isServer) exitWith {};
		_params params [["_group",grpNull,[grpNull]],["_name","",[""]]];
		if (!isNull _group && {_name != ""}) then {
			_group setGroupIdGlobal [_name];
		};
	};
	case "setPrivate" : {
		if !(isServer) exitWith {};
		_params params [["_group",grpNull,[grpNull]],["_locked",false,[false]]];
		if (!isNull _group) then {
			_group setVariable [VAR_GROUP_PRIVATE,_locked,true];
		};
	};
	case "setLeader" : {
		if !(isServer) exitWith {};
		_params params [["_group",grpNull,[grpNull]],["_player",objNull,[objNull]]];

		if (!isNull _group && {!isNull _player} && {_group == group _player}) then {
			// Select new leader
			[_group, _player] remoteExec ["selectLeader", groupOwner _group];
			// Log
			//["SwitchLeader: %1 / %2", _group, _player] call BIS_fnc_logFormat;
		};
	};
	case "removeGroupMember" : {
		if !(isServer) exitWith {};
		_params params [["_group",grpNull,[grpNull]],["_player",objNull,[objNull]]];
		if (!isNull _player && {!isNull _group} && {group _player == _group}) then {
			private ["_units"];
			_units = units _group - [_player];
			[_player] joinSilent grpNull;
			["OnPlayerGroupChanged", [_player, group _player]] call MPSF_fnc_squadMod;
			if (count _units < 1) then {
				["DeleteGroup", [_group]] call MPSF_fnc_squadMod;
			};
		};
	};
	case "postInit" : {
		//
	};
};