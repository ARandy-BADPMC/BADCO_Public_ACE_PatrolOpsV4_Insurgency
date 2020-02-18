/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_simulCiv.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Civilian Simulation System

	Parameter(s):
		0: Object - Description

	Returns:
		Bool - True when done
*/
params [["_mode","",[""]],["_params",[],[[],false]]];

//#define CLASSNAMES []
#define CLASSNAMES (["CfgSides","Civilian_Malden","Crowd24"] call BIS_fnc_getCfgDataArray)

switch (_mode) do {
	case "createAgent" : {
		_params params [["_agentType","",["",[]]],["_position",[],[[]]]];

		if (_agentType isEqualTo "" || _position isEqualTo []) exitWith { objNull };
		if !(_agentType isEqualType []) then { _agentType = [_agentType]; };

		_agentType params [["_classname","",[""]],["_loadout","",[""]]];

		private _agent = createAgent [_classname, _position, [], 8, "FORM"];
		if !(isNull _agent) then {
			_agent disableAI "FSM";
			_agent setVariable ["agentObject",_agent,true];
			_agent enableDynamicSimulation true;
			if !(_loadout isEqualTo "") then {
				[_agent,_loadout] call MPSF_fnc_setUnitLoadout;
			};
		};

		_agent;
	};
	case "createCrowd" : {
		_params params [["_groupUnits",[],[[]]],["_position",[0,0,0],[[]]],["_radius",0,[0]]];

		if (count _groupUnits == 0) exitWith { /*["Unable to assign waypoints to group %1 in %2",_groupUnits,mapGridPosition _position] call BIS_fnc_error;*/ false };

		private _movePositions = [_position,_radius,true] call MPSF_fnc_getNearbyBuildings;
		if (count _movePositions < 10) then {
			private _wpcount = (round(_radius / 15) max 5) min 10;
			private _inc = 360/_wpcount;
			for "_i" from 0 to _wpcount do {
				private _ang = _inc * _i;
				private _a = (_position select 0)+(sin(_ang)*_radius);
				private _b = (_position select 1)+(cos(_ang)*_radius);
				if !(surfaceIsWater [_a,_b]) then{
					_movePositions pushBack [_a,_b,0];
				};
			};
			if (count _movePositions == 0) exitWith { /*["Unable to assign waypoints to group %1 in %2",_groupUnits,mapGridPosition _position] call BIS_fnc_error;*/ false; };
		};

		{
			_x setVariable ["crowdData",_movePositions];
			_x setPosATL (selectRandom _movePositions);
			_x setSpeedMode "LIMITED";
			_x forceSpeed (_x getSpeed "Slow");
		} forEach _groupUnits;

		["MPSF_SimulCiv_Crowd_EH","onEachFrame",{
			if (count agents > 0) then {
				private _agent = agents select (diag_frameno % count agents);
				if (_agent getVariable ["inConversation",false]) exitWith {
					(agent _agent) moveTo (position agent _agent);
				};
				{
					private _unit = agent _x;// getVariable ["agentObject",objNull];
					_movePositions = _x getVariable ["crowdData",[]];
					if (count _movePositions > 0) then {
						if (currentCommand _unit isEqualTo "") then {
							_unit moveTo (selectRandom _movePositions);
						};
					};
				} forEach [_agent];
			};
		}] call MPSF_fnc_addEventHandler;
	};
};