/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createAmbush.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Creates an Ambush

	Parameter(s):
		0: Object - Description

	Returns:
		Bool - True when done
*/
params [["_centerPos",[0,0,0],[[]]],["_faction",sideUnknown,[sideUnknown,""]],["_classNames",[],[[],""]]];

private _buildingPositions = [_position,_radius,true] call MPSF_fnc_getNearbyBuildings;
private _offsetPos = if (count _buildingPositions == 0) then { _centerPos getPos [200,random 360]; } else { selectRandom _buildingPositions; };

// Create Group
private _group = [_offsetPos,_faction,_classNames] call MPSF_fnc_createGroup;
_group params [["_groupID",grpNull,[grpNull]],["_groupUnits",[],[[]]]];

// Occupy Area
[_groupID,_centerPos,50] call MPSF_fnc_setGroupOccupy;

// Create Event
private _leader = leader _groupID;
_leader setVariable ["MPSF_Data_var_ambushPos",_centerPos];
_leader addEventHandler ["AnimChanged",{
	params [["_leader",objNull,[objNull]],["_anim","",[""]]];
	if ((toUpper behaviour _leader) isEqualTo "COMBAT") then {
		_leader removeAllEventHandlers "AnimChanged";
		// Create Distraction
		private _charge = "DemoCharge_Remote_Ammo_Scripted" createVehicle (_leader getVariable ["MPSF_Data_var_ambushPos",[0,0,0]]);
		_charge setDamage 1;
		// Start Movement
		[group _leader,_leader getVariable ["MPSF_Data_var_ambushPos",position _leader]] call MPSF_fnc_setGroupAttack;
	};
}];