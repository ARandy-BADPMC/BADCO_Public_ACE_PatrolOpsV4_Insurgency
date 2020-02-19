// Temporary until SquadMod
["InitializePlayer",[player, true]] call BIS_fnc_dynamicGroups;

// PO4 Hints and Tips
["init"] call PO4_fnc_tutorial;

// Move player into any nearby barracks
[] spawn {
	if (hasInterface) then {
		if !(is3DEN) then {
			private _barracks = nearestObjects [(getMarkerPos "respawn_west"),["Land_i_Barracks_V1_F","Land_i_Barracks_V2_F","Land_u_Barracks_V2_F","Land_Barracks_01_grey_F","Land_Barracks_01_camo_F","Land_Barracks_01_dilapidated_F"],50];
			private _positions = [];
			{
				_buildingPos = _x;
				{
					_pos = _x;
					if (_forEachIndex in [2,4,5,6,7,8,9,10,11,12,13,15,16,19,20,21,22,23,24,25,26,27,28,29,30,31,48,49]) then {
						_positions pushBack _pos;
					};
				} forEach _buildingPos;
			} forEach (_barracks apply {[_x] call BIS_fnc_buildingPositions});

			if (count _positions > 0) then {
				{
					private _unit = _x;
					private _position = _positions select (_forEachIndex % (count _positions));
					if (local _x) then { _x setPosATL _position; };
				} forEach (playableUnits + switchableUnits);
			};
		};
	};
};

// Intro Sequence
[14309.4,17417.9,3] call {
	if (["missionDebugMode"] call MPSF_fnc_getCfgDataBool) exitWith { false };

	private _duration = 10;

	waitUntil {!(isNull ([] call BIS_fnc_displayMission))};

	private _musicVolume = musicVolume;
	switch (true) do {
		case (random 1 < 0.5) : {
			0 fadeMusic 1;
			playMusic ["LeadTrack02_F_EXP",20];
		};
		default {
			3 fadeMusic 1;
			playMusic ["LeadTrack01b_F_EXP",23];
		};
	};

	["mpsf\data\titles\patrolops_overview_co.paa",false,nil,5,[0,0.5]] call BIS_fnc_textTiles;

	private _missionType = ["MPSFBaseSelection",""] call MPSF_fnc_getCfgParam;
	private _modifier = ["modifiedBy"] call MPSF_fnc_getCfgDataText;

	[parseText format ["<t align='center' size='1.2'>%1%2</t>"
			,toUpper worldName
			,if !(_missionType isEqualTo "") then { format [" | %1",_missionType]; } else {""}
			,if !(_modifier isEqualTo "") then { format [" | %1",_modifier]; } else {""}
		], [
		(safezoneW/2) - 10 * (((safezoneW / safezoneH) min 1.2) / 40) + safeZoneX
		,(safeZoneH / 2) + 8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safeZoneY
		,20 * (((safezoneW / safezoneH) min 1.2) / 40)
		,3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
	], nil, 7, 0.7, 0] spawn BIS_fnc_textTiles;

	[([] call BIS_fnc_displayMission),"RscDisplayCameraIntro_1"] call MPSF_fnc_createCtrl;

	private _rscTop = uiNamespace getVariable ["RscDisplayCameraIntro_1_MainBackgroundTop",controlNull];
	_rscTopPos = ctrlPosition _rscTop;
	_rscTopPos set [3,0];
	_rscTop ctrlSetPosition _rscTopPos;
	_rscTop ctrlSetFade 0.2;
	_rscTop ctrlCommit _duration;

	private _rscBottom = uiNamespace getVariable ["RscDisplayCameraIntro_1_MainBackgroundBottom",controlNull];
	_rscBottomPos = ctrlPosition _rscBottom;
	_rscBottomPos set [3,0];
	_rscBottomPos set [1,safeZoneH + safeZoneY];
	_rscBottom ctrlSetPosition _rscBottomPos;
	_rscBottom ctrlSetFade 0.2;
	_rscBottom ctrlCommit _duration;

	_wparray = [];
	_wparray pushBack [_this getPos [20,200 + 137.53],2,_this,0,0.2,false,""];
	_wparray pushBack [_this getPos [20,180 + 137.53],2,_this,0,0.5,false,""];
	_wparray pushBack [_this getPos [20,150 + 137.53],3,_this,_duration,0.5,false,""];
	[_wparray] spawn MPSF_fnc_cameraDollyShot;

	uiSleep (_duration * 0.8);

	private _rscTitle = uiNamespace getVariable ["RscDisplayCameraIntro_1_Title",controlNull];
	_rscTitle ctrlSetFade 1;
	_rscTitle ctrlCommit (_duration * 0.1);

	uiSleep (_duration * 0.2);

	["#(argb,8,8,3)color(0,0,0,1)",false,nil,0,[0,0.5]] call BIS_fnc_textTiles;
	["RscDisplayCameraIntro_1"] call MPSF_fnc_destroyCtrl;
	10 fadeMusic 0;
	_musicVolume spawn {
		uiSleep 10;
		playMusic "";
		0 fadeMusic _this;
	};
	true
};

[[
		[format ["%1: ",briefingName],"align = 'left' size = '0.7' font='PuristaBold'"]
		,["INITIATING","align = 'left' size = '0.7' font='PuristaLight'","#aaaaaa"]
		,["","<br/>"]
		,["AO: ","align = 'left' size = '0.6' font='PuristaLight'"]
		,[toUpper worldName,"align = 'left' size = '0.6' font='PuristaLight'","#33ff33"]
		,["","<br/>"]
		,["CIV: ","align = 'left' size = '0.6' font='PuristaLight'"]
		,["ACTIVE","align = 'left' size = '0.6' font='PuristaLight'","#33ff33"]
		,["","<br/>"]
		,["EN: ","align = 'left' size = '0.6' font='PuristaLight'"]
		,["ACTIVE","align = 'left' size = '0.6' font='PuristaBold'","#ff3333"]
],5 * (((safezoneW / safezoneH) min 1.2) / 40) + safeZoneX
,10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safeZoneY
] call BIS_fnc_typeText2;

[] spawn {
	disableSerialization;
	waitUntil{ !isNull (findDisplay 46) };
	private _ctrlText = (findDisplay 46) ctrlCreate ["RscStructuredText",-1];
	private _sitrep = format ["<t font='PuristaMedium' align='right' size='0.7' shadow='0'>%3<br/>%1<br/>%2</t>",briefingName,getText(missionConfigFile >> "PatrolOpsVersion"),"<img image='mpsf\data\titles\patrolops_logo_co.paa' size='2.2'/>"];
	_ctrlText ctrlSetStructuredText parseText _sitrep;
	_ctrlText ctrlSetTextColor [1,1,1,0.7];
	_ctrlText ctrlSetBackgroundColor [0,0,0,0];
	_ctrlText ctrlSetPosition [
		(safezoneW - 22 * (((safezoneW / safezoneH) min 1.2) / 40)) + (safeZoneX)
		,(safezoneH - 5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) + (safeZoneY)
		,20 * (((safezoneW / safezoneH) min 1.2) / 40)
		,5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
	];
	_ctrlText ctrlSetFade 0.5;
	_ctrlText ctrlCommit 0;
	true;
};

[["PatrolOps4","BeginPO4"]] call BIS_fnc_advHint;
["Tutorial_VirtualArmoury","Assigned",true] call MPSF_fnc_updateTaskState;
// Team Killer Rating Neutraliser
["Player_onHandleRating_EH","onHandleRating",{ if (rating player <= 0) then { player addRating ((abs rating player)+1); }; }] call MPSF_fnc_addEventHandler;