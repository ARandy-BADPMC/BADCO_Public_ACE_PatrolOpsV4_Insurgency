params [["_NPC",objNull,[objNull]],["_unit",objNull,[objNull]],["_attributes",[],[[]]],["_id",0,[0]]];

private _nearestEncounter = ["getNearestEncounter",[getPos _NPC,true]] call PO4_fnc_encounters;
if (isNull _nearestEncounter) exitWith {
	selectRandom [ // TODO: localize
		"I have not seen anything nearby, sorry."
	];
};

private _position = getPos _NPC;
private _direction = ((_NPC getRelDir _nearestEncounter) + (direction _NPC)) % 360;
private _distance = _NPC distance2D _nearestEncounter;

private _randomDir = round((_direction + (random (40)) - 20)/10)*10;
private _randomDis = round((_distance + (random (300)) - 150)/100)*100;
private _randomPos = _NPC getPos [_randomDis,_randomDir];
private _nearPosition = _nearestEncounter getPos [100,random 360];

private _regions = [["North West",292.5,337.5],["North",-22.5,22.5],["North East",22.5,67.5],["East",67.5,112.5],["South East",112.5,157.5],["South",157.5,202.5],["South West",202.5,247.5],["West",247.5,292.5]];
private _region = "";
{
	private _ref = _direction + 360;
	private _min = (_x select 1) + 360;
	private _max = (_x select 2) + 360;
	if (_ref >= _min && _ref <= _max) exitWith { _region = _x select 0; };
} forEach _regions;

private _month = str (date select 1);
private _day = str (date select 2);
private _hour = str (date select 3);
private _minute = str (date select 4);
if (date select 1 < 10) then { _month = format ["0%1",str (date select 1)]; };
if (date select 2 < 10) then { _day = format ["0%1",str (date select 2)]; };
if (date select 3 < 10) then { _hour = format ["0%1",str (date select 3)]; };
if (date select 4 < 10) then { _minute = format ["0%1",str (date select 4)]; };

if !(isMultiplayer) then {
	private _marker1 = createMarker [format["MARKER_%1",[5] call MPSF_fnc_getRandomString],getPos _nearestEncounter];
	_marker1 setMarkerShape "ICON";
	_marker1 setMarkerType "mil_dot";
	_marker1 setMarkerColor "colorBlack";
	_marker1 setMarkerText format ["Encounter"];
	_marker1 setMarkerAlpha 0.1;
	_marker1 setMarkerSize [1,1];

	private _marker2 = createMarker [format["MARKER_%1",[5] call MPSF_fnc_getRandomString],_randomPos];
	_marker2 setMarkerShape "ICON";
	_marker2 setMarkerType "mil_dot";
	_marker2 setMarkerColor "colorBlack";
	_marker3 setMarkerText format ["%3 RandomPos %1m, %2",_randomDis,_randomDir,_region];
	_marker2 setMarkerAlpha 0.5;
	_marker2 setMarkerSize [1,1];
};

switch (_id) do {
	case 1 : { // Grid
		["Log","Log","Civil Intel",
			format ["[%1] Civilian reported sighting of possible enemy movements near GRID #%2",format ["%1-%2-%3 %4:%5", str (date select 0), _month, _day, _hour, _minute],mapGridPosition _randomPos]
		] call MPSF_fnc_createDiaryNote;
		private _stringFormat = selectRandom [
			"I spotted somthing near here (indicating Grid #%1 on map)"
			,"Definitely saw something near here (points to Grid #%1)"
		];
		format [_stringFormat,mapGridPosition _randomPos];
	};
	case 2 : { // Distance, Direction
		["Log","Log","Civil Intel",
			format [
				"[%1] Civilian reported sighting of possible enemy movements indicating about %2m on a bearing of about %3 degrees %4 from #%5"
				,format ["%1-%2-%3 %4:%5",str (date select 0),_month, _day, _hour, _minute]
				,_randomDis
				,_randomDir
				,_region
				,mapGridPosition _position
			]
		] call MPSF_fnc_createDiaryNote;
		private _stringFormat = selectRandom [
			"I spotted somthing %3 from here about %1m away"
			,"Definitely saw something %3 from here (points towards %2 degrees)"
		];
		format [_stringFormat,_randomDis,_randomDir,_region];
	};
	case 3 : { // Vague
		["Log","Log","Civil Intel",
			format [
				"[%1] Civilian reported sighting of possible enemy movements indicating a bearing of about %3 degrees %4 from #%5"
				,format ["%1-%2-%3 %4:%5",str (date select 0),_month, _day, _hour, _minute]
				,_randomDis
				,_randomDir
				,_region
				,mapGridPosition _position
			]
		] call MPSF_fnc_createDiaryNote;
		private _stringFormat = selectRandom [
			"I spotted somthing %3 from here, could be them."
			,"Definitely saw something to the %3"
		];
		format [_stringFormat,_randomDis,_randomDir,_region];
	};
	default { // Not Sure
		["Log","Log","Civil Intel",
			format [
				"[%1] Civilian reported sighting of possible enemy movements indicating possibly %4 from #%5"
				,format ["%1-%2-%3 %4:%5",str (date select 0),_month, _day, _hour, _minute]
				,_randomDis
				,_randomDir
				,_region
				,mapGridPosition _position
			]
		] call MPSF_fnc_createDiaryNote;
		private _stringFormat = selectRandom [
			"Not sure, maybe saw something %3 from here."
			,"My friend saw something nearby. Just not sure where..."
		];
		format [_stringFormat,_randomDis,_randomDir,_region];
	};
};