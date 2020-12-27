/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_capitaliseString.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Capitalise the first letter

	Parameter(s):
		0: STRING

	Returns:
		STRING
*/
params ["_string","",[""]];

private _return = "";
{
	if (_forEachIndex == 0) then {
		_return = format["%1%2",_return,toUpper(toString _x)];
	} else {
		_return = format["%1%2",_return,toLower(toString _x)];
	};
} forEach toArray _string;

_return;