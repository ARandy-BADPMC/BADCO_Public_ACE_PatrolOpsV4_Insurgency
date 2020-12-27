/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getAreaSector.sqf
	Author(s): see mpsf\credits.txt
*/
params [["_position",[0,0,0],[[]]],["_size",0,[0]],["_resolve",true,[false]]];

if (_size isEqualTo 0) then { _size = 1000; };

private _posX = (floor((_position select 0)/_size)*_size) + (_size/2);
private _posY = (floor((_position select 1)/_size)*_size) + (_size/2);
private _sectorID = format["sector_%1%2",
	switch (count toarray str _posX) do {
		case 1 : { format ["000%1",_posX] };
		case 2 : { format ["00%1",_posX] };
		case 3 : { format ["0%1",_posX] };
		default { format ["%1",_posX] };
	}
	,
	switch (count toarray str _posY) do {
		case 1 : { format ["000%1",_posY] };
		case 2 : { format ["00%1",_posY] };
		case 3 : { format ["0%1",_posY] };
		default { format ["%1",_posY] };
	}
];

if (_resolve) then {
	_sectorID;
} else {
	[_sectorID,[_posX,_posY,0],_size];
};
