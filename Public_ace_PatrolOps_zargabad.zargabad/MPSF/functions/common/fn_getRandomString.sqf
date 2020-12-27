/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getRandomString.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Generate a distinct random string

	Parameter(s):
		0: NUMBER - Length of string

	Returns:
		STRING
*/
params [["_stringCount",8,[0]]];

private _chars = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","1","2","3","4","5","6","7","8","9","0"];
private _countChars = count _chars - 1;
private _returnString = "";
private _existingStrings = missionNamespace getVariable ["MPSF_String_var_randomStrings",[]];

for "_i" from 1 to _stringCount do {
	_char = _chars select (random(_countChars));
	_returnString = format["%1%2",_returnString,if(random 1 > 0.49) then { toUpper(_char) } else { toLower(_char) } ];
};

if (_returnString IN _existingStrings) then {
	[_stringCount] call MPSF_fnc_getRandomString;
} else {
	_existingStrings pushBack _returnString;
	missionNamespace setVariable ["MPSF_String_var_randomStrings",_existingStrings];
};

_returnString;