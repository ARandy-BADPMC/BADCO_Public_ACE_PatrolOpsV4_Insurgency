/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_cameraDollyShot.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Create a moving shot sequence

	Parameter(s):
		0: ARRAY - Camera path points
			0: ARRAY/Marker/Object - Position of Camera
			1: NUMBER - Altitude(m)
			2: ARRAY/Marker/Object - Focal point to track
			3: NUMBER - Time taken to reach position
			4: NUMBER - Field of View
			5: BOOL - Show cinematic borders
			6: STRING - FADE in or out ("fadeIn","fadeOut")
		1: BOOL - Destroy camera on completion or wait for next sequence.

	Returns:
		Bool - True when done

	Example: Orbit Player
		[270,900,150] spawn {
			_bse = _this select 0;
			_rad = _this select 1;
			_alt = _this select 2;

			_pos = (position player);
			_dir = if(random 1 > 0.5) then { -1 }else{ 1 };
			_wpc = round (_rad / 12) max 5;
			_rid = round (_rad / _wpc);
			_aid = round (_alt / _wpc);
			_inc = 360/_wpc;
			_wparray = [];

			for "_i" from 0 to _wpc do {
				_ang = _bse + _inc * _dir * _i;
				_a = (_pos select 0)+(sin(_ang)*_rad);
				_b = (_pos select 1)+(cos(_ang)*_rad);

				_wparray pushBack [[_a,_b,_alt],-1,player,0.2,0.5,false,""];

				_rad = (_rad - _rid) max 1;
				_alt = (_alt - _aid) max 1;
			};

			[_wparray,true] spawn MPSF_fnc_cameraDollyShot;
		};
*/
params [["_cameraPath",[],[[]]],["_destroyOnFinish",true,[false]]];

private _camera = ["createCamera",["CameraPath",true]] call MPSF_fnc_Camera;

waitUntil {time > 0};

{
	_x params [
		["_camPos",[0,0,0],["",[],objNull]]
		,["_camAlt",-1,[0]]
		,["_camTgt",[0,0,0],["",[],objNull]]
		,["_pathTime",3,[0]]
		,["_camFOV",0.7,[0]]
		,["_camBorder",false,[false]]
		,["_transition","",[""]]
	];
	private _timer = time + _pathTime - 2;
	private _camPos = switch (typeName _camPos) do {
		case (typeName "") : {
			private _object = missionNamespace getVariable [_camPos,objNull];
			if (isNull _object) then { getMarkerPos _camPos } else { position _object };
		};
		default {_camPos};
	};
	private _camTarget = switch (typeName _camTgt) do {
		case (typeName "") : {
			private _object = missionNamespace getVariable [_camTgt,objNull];
			if (isNull _object) then { getMarkerPos _camTgt } else { _object };
		};
		default {_camTgt};
	};
	private _camTargetPos = switch (typeName _camTarget) do {
		case (typeName objNull) : { getPos _camTarget };
		default {_camTarget};
	};

	if (_forEachIndex == 0) then {
		_pathTime = 0;
	};

	if (_camAlt < 0) then {
		_camPos = [(_camPos select 0) - (_camTargetPos select 0),(_camPos select 1) - (_camTargetPos select 1),(_camPos select 2) - (_camTargetPos select 2)];
		_camera camSetRelPos _camPos;
	} else {
		_camPos set [2,_camAlt];
		_camera camSetPos _camPos;
	};
	_camera camSetTarget _camTarget;
	_camera camSetFOV _camFOV;
	_camera camCommit _pathTime;
	showcinemaborder _camBorder;

	WaitUntil{camCommitted _camera || _timer <= time};
	switch (_transition) do {
		case "fadeIn" : { ["cameraFade",[false,2]] spawn MPSF_fnc_Camera; };
		case "fadeOut" : { ["cameraFade",[true,2]] call MPSF_fnc_Camera; };
	};
	WaitUntil{camCommitted _camera};
} forEach _cameraPath;

if(_destroyOnFinish && !(isNull _camera)) then {
	["destroyCamera",["CameraPath"]] call MPSF_fnc_Camera;
};