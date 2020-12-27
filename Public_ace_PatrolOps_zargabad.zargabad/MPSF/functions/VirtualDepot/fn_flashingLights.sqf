params [["_vehicle",objNull,[objNull]]];

if (isNull _vehicle) exitWith {};

private _selectionNames = selectionNames _vehicle select { _name = _x; {_name find _x >= 0} count ["light","police","services","beacon"] > 0};
_selectionNames = _selectionNames select {!((_vehicle selectionPosition _x) isEqualTo [0,0,0])};
if (count _selectionNames == 0) exitWith {};

private _selectionPos = [_vehicle selectionPosition (_selectionNames select 0),[0,0,0.1]] call BIS_fnc_vectorAdd;
private _colourEmergency = [[1,0,0],[0,0,1]];
private _colourCivil = [[1,0.6,0],[0,0,0]];

private _lightpoint = "#lightpoint" createVehicle getpos _vehicle;
_lightpoint setLightColor [0,0,0];
_lightpoint setLightBrightness 0;
_lightpoint setLightAmbient [0.1,0.1,1];
_lightpoint setLightAttenuation [0.181, 0, 1000, 130];
_lightpoint setLightFlareSize 0.38;
_lightpoint setLightFlareMaxDistance 150;
_lightpoint setLightUseFlare true;
_lightpoint lightAttachObject [_vehicle,_selectionPos];

private _cycle = [
	_colourEmergency select 0,[],
	_colourEmergency select 0,[],[],[],[],
	_colourEmergency select 1,[],
	_colourEmergency select 1,[],[],[],[]
];

while {alive _vehicle} do {
	private _brightness = if (sunOrMoon < 1) then { 4 } else { 50 };
	//systemChat str [_vehicle,_lightpoint,_brightness,_colourEmergency];
	if (_vehicle animationPhase "BeaconsStart" > 0.5 || _vehicle animationPhase "lights_em_hide" > 0.5) then {
		_vehicle say3D "AlarmCar";
		{
			if (_x isEqualTypeArray [0,0,0]) then {
				_lightpoint setLightColor _x;
				_lightpoint setLightBrightness _brightness;
			} else {
				_lightpoint setLightBrightness 0;
			};
			sleep 0.05;
		} foreach _cycle;
	};
};
deleteVehicle _lightpoint;