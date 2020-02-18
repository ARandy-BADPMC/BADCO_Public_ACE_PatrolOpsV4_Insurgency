/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_addAction.sqf
	Author(s): see mpsf\credits.txt

	Description:
		This function adds a standard action to an object

	Parameter(s):
		0: STRING	- Unique Action ID to track
		1: OBJECT	- Remove the camera once finished and return to player view
		2: STRING	- Title of Action
		3: SCRIPT	- Code to execute on action
		4: ARRAY	- Arguments to pass through
		5: STRING	- Condition to show action

	Returns:
		BOOLEAN
*/

params [
	["_actionID","",[""]]
	,["_object",objNull,[objNull]]
	,["_displayText","Interact",[""]]
	,["_script",{},[{},[]]]
	,["_arguments",[],[[],objNull]]
	,["_condition","true",[""]]
	,["_target",0,[[],0,"",objNull,grpNull,sideUnknown,false,missionNamespace]]
	,["_draw3D",false,[false]]
	,["_priority",0,[0]]
];

if (_target isEqualTo missionNamespace) then { _target = 0; };

if (_draw3D) then {
	["addIntelBeacon",[_object,_displayText]] call MPSF_fnc_intel;
};

["onAddAction",[_actionID,_object,_displayText,_script,_arguments,_condition,_draw3D,_priority],_target] call MPSF_fnc_triggerEventHandler;