// http://killzonekid.com/arma-building-bridges/

if !(isServer) exitWith {};

params [["_startPos",[],[[]]],["_direction",0,[0]],["_type","",[""]],["_count",1,[0]],["_offset",[0,0,0],[[]]]];

private _start = createVehicle [_type,_startPos,[],0,"CAN_COLLIDE"];
_start setVectorUp [0,0,1];
_start setDir _direction;
_start setPosATL _startPos;

private _dimensions = _start call BIS_fnc_boundingBoxDimensions;
private _objects = [_start];

for "_i" from 1 to _count do {
	private _obj = createVehicle [_type,_startPos,[],0,"CAN_COLLIDE"];
	private _offsetPos = _offset apply {_i * _x};
	_obj attachTo [_start,_offsetPos];
	private _objPos = getPosATL _obj;
	private _objDir = getDir _obj;
	detach _obj;
	_obj setDir _objDir;
	_obj setPosATL _objPos;
	_objects pushBack _obj;
};

{
	private _marker = createMarker [format["Bridge_%1_%2",_start call BIS_fnc_netId,_forEachIndex],getPosASL _x];
	_marker setMarkerShape "RECTANGLE";
	_marker setMarkerDir (getDir _x);
	_marker setMarkerBrush "SolidFull";
	_marker setMarkerColor "ColorGrey";
	_marker setMarkerSize [(_dimensions select 0) / 2,(_dimensions select 1) / 2];
} foreach _objects;

_objects;