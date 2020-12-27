params [["_groupID",grpNull,[grpNull]],["_position",[0,0,0],[[]]],["_radius",0,[0]]];

_groupID setBehaviour "SAFE";
_groupID setSpeedMode "LIMITED";
_groupID setCombatMode "WHITE";

private _movePositions = [_position,_radius,true] call MPSF_fnc_getNearbyBuildings;
private _wpcount = (round(_radius / 15) max 5) min 10;
private _inc = 360/_wpcount;
for "_i" from 0 to _wpcount do {
	private _ang = _inc * _i;
	private _a = (_position select 0)+(sin(_ang)*_radius);
	private _b = (_position select 1)+(cos(_ang)*_radius);
	if !(surfaceIsWater [_a,_b]) then{
		_movePositions pushBack [_a,_b,0];
	};
};

if (count _movePositions == 0) exitWith { /*["Unable to assign waypoints to group %1 in %2",_groupID,mapGridPosition _position] call BIS_fnc_error;*/ false; };

[format["MPSF_Crowd_%1_EH",groupID _groupID],"onEachFrame",{
	if (diag_frameNo % 500 == 0) then {
		params ["_groupID","_units","_movePositions"];
		{
			if (currentCommand _x isEqualTo "") then {
				_x doMove (selectRandom _movePositions);
			};
		} forEach _units;
		if ({alive _x} count _units == 0) then {
			[format["MPSF_Crowd_%1_EH",groupID _groupID],"onEachFrame"] call MPSF_fnc_removeEventHandler;
		};
	};
},[_groupID,units _groupID,_movePositions]] call MPSF_fnc_addEventHandler;