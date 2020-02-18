/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createCheckpoint.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Creates a Checkpoint (requires a composition)
*/
params [["_position",[0,0,0],[[]]],["_direction",0,[0]],["_faction",sideUnknown,[sideUnknown,""]],["_classNames",[],[[],""]]];

private _compositions = ["Roadblock"];
private _composition = [selectRandom _compositions,_position,_direction,false] call MPSF_fnc_createComposition;
private _group = [_position,_faction,_classNames] call MPSF_fnc_createGroup;

_group params [["_groupID",grpNull,[grpNull]],["_groupUnits",[],[[]]]];
[_groupID,_position,50] spawn MPSF_fnc_setGroupDefend;

[_groupID,_groupUnits,_composition];