/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_playMusicScore.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Plays a random song
*/
private _music = [];
{
	private _musicClass = getText(_x >> "musicClass");
	private _musicTheme = getText(_x >> "theme");
	private _musicDuration = getNumber(_x >> "duration");
	if (toLower _musicClass in ["lead"] && _musicDuration >= (count allPlayers) * 4) then {
		_music pushBackUnique configName _x;
	};
} forEach ("isClass _x" configClasses (configFile >> "CfgMusic"));

if (count _music > 0) then {
	playMusic (selectRandom _music);
	0 fadeMusic 1;
};