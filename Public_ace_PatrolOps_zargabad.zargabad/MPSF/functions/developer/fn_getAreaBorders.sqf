/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getAreaBorders.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Returns the corners of a sector

	Parameter(s):
		0: ARRAY	- Center Position
		1: NUMBER	- Width of Sector

	Returns:
		ARRAY		- [SW,NW,NE,SE]
*/
params [["_areaPos",[0,0],[[]]],["_areaSize",100,[0,[]]]];

if !(typeName _areaSize == typeName []) then { _areaSize = [_areaSize,_areaSize]; };
_areaSize = [(_areaSize select 0)/2,(_areaSize select 1)/2];

private _posSW = [(_areaPos select 0) - (_areaSize select 0),(_areaPos select 1) - (_areaSize select 1)];
private _posNW = [(_areaPos select 0) - (_areaSize select 0),(_areaPos select 1) + (_areaSize select 1)];
private _posNE = [(_areaPos select 0) + (_areaSize select 0),(_areaPos select 1) + (_areaSize select 1)];
private _posSE = [(_areaPos select 0) + (_areaSize select 0),(_areaPos select 1) - (_areaSize select 1)];

[_posSW,_posNW,_posNE,_posSE];