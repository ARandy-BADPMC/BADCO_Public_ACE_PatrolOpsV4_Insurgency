/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createCtrl.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Creates a control in a display

	Parameter(s):
		0: Display - Parent Display
		1: STRING - ConfigID of Controls to be created

	Returns:
		Nothing
*/
params [["_display",displayNull,[displayNull]],["_displayCtrl","",[""]]];

if !(isNull _display) then {
	private _displayCtrls = [];
	private _ctrlAnchor = getArray(missionConfigFile >> _displayCtrl >> "position");
	{ _ctrlAnchor set [_foreachindex,call compile _x]; } forEach _ctrlAnchor;

	{
		private _ctrlName = configName _x;
		private _ctrlType = getText(_x >> "Type");
		private _ctrl = _display ctrlCreate [_ctrlType,86919 + _foreachindex];

		private _ctrlPos = getArray(_x >> "Position");
		{
			_ctrlPos set [_foreachindex,call compile _x];
		} forEach _ctrlPos;
		_ctrlPos = [
			(_ctrlAnchor select 0) + (_ctrlPos select 0)
			,(_ctrlAnchor select 1) + (_ctrlPos select 1)
			,(_ctrlPos select 2)
			,(_ctrlPos select 3)
		];
		_ctrl ctrlSetPosition _ctrlPos;

		if (isArray(_x >> "colorBackground")) then {
			private _colourBackground = getArray(_x >> "colorBackground");
			{ if (typeName _x isEqualTo typeName "") then { _colourBackground set [_foreachindex,call compile _x]; }; } forEach _colourBackground;
			_ctrl ctrlSetBackgroundColor _colourBackground
		};

		if (isText(_x >> "text")) then {
			_ctrl ctrlSetText getText(_x >> "text");
		};

		if (isText(_x >> "sizeEx")) then {
			_ctrl ctrlSetFontHeight (call compile getText (_x >> "sizeEx"));
		};

		if (isArray(_x >> "columns")) then {
			private _countCols = count (lnbGetColumnsPosition _ctrl);
			private _columns = getArray(_x >> "columns");
			if (count _columns > 3) then {
				for "_i" from 3 to (count _columns - 1) do {
					_ctrl lnbAddColumn (_columns select _i);
				};
			};
			_ctrl lnbSetColumnsPos _columns;
		};

		if (isText(_x >> "onLBSelChanged")) then {
			_ctrl ctrlAddEventHandler ["lbselchanged",getText(_x >> "onLBSelChanged")];
		};

		if (isText(_x >> "onButtonClick")) then {
			_ctrl ctrlAddEventHandler ["buttonclick",getText(_x >> "onButtonClick")];
		};

		_ctrl ctrlCommit 0;

		_displayCtrls pushBack _ctrl;
		uiNamespace setVariable [format["%1_%2",_displayCtrl,_ctrlName],_ctrl];
	} forEach ("isClass _x" configClasses (missionConfigFile >> _displayCtrl >> "controls"));

	uiNamespace setVariable [_displayCtrl,_displayCtrls];
};