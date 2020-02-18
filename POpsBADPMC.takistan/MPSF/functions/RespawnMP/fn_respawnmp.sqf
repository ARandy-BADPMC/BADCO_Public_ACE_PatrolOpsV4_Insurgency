#define MISSIONTIME							(if (isMultiplayer) then {serverTime} else {time})

#define MAINLEFTBUTTONS	[\
	"RscRespawn_IDC_LeftSideBar_Btn1"\
	,"RscRespawn_IDC_LeftSideBar_Btn2"\
	,"RscRespawn_IDC_LeftSideBar_Btn3"\
	,"RscRespawn_IDC_LeftSideBar_Btn4"\
	,"RscRespawn_IDC_LeftSideBar_Btn5"\
	,"RscRespawn_IDC_LeftSideBar_Btn6"\
	,"RscRespawn_IDC_LeftSideBar_Btn7"\
	,"RscRespawn_IDC_LeftSideBar_Btn8"\
	,"RscRespawn_IDC_LeftSideBar_Btn9"\
]
#define WETDISTORTION_0(INTENSITY)	[1,INTENSITY,INTENSITY,4.10,3.70,2.50,1.85,0.005,0.005,0.005,0.005,0.5,0.3,10.0,6.0]
#define WETDISTORTION_1(INTENSITY)	[1,INTENSITY,INTENSITY,8,8,8,8,0.005,0.005,0.005,0.005,0.0,0.0,1.0,1.0]

// Colours
#define COLOURWHITE							[1,1,1,1]
#define COLOURREVIVING						[0,0.6,0.6,1]
#define COLOURORANGE						[1,0.66,0,1]
// Icons
#define ICONEMPTY							"#(argb,8,8,3)color(0,0,0,0)"
#define ICONSELECTORM						"\A3\ui_f\data\map\groupicons\selector_selectedMission_ca.paa"
#define ICONPARACHUTE						"\A3\ui_f\data\Map\VehicleIcons\iconParachute_ca.paa"
#define ICONMOVE							"\A3\ui_f\data\IGUI\Cfg\Actions\ico_ON_ca.paa"
#define ICONSELECTED						"\A3\ui_f\data\map\groupicons\selector_selected_ca.paa"
#define ICONMOVEWARNING						"\A3\ui_f\data\IGUI\Cfg\Actions\ico_OFF_ca.paa"
#define ICONBADGE							"\A3\ui_f\data\Map\GroupIcons\badge_rotate_%1_gs.paa"
// Respawn
#define JUMPAREA							[250,250,0]
#define REDEPLOYAREAS(target)				(["getRedeployPoints",[target]] call MPSF_fnc_respawnMP)
#define NOTHALOAREAS(target)				(REDEPLOYAREAS(target) select {!(_x select 2)})
#define HALOJUMPAREAS(target)				(REDEPLOYAREAS(target) select {(_x select 2)})

#define REDEPLOYVARPOS						"MPSF_HALO_var_selectedRedeployPos"
#define REDEPLOYGETPOS						(missionNamespace getVariable [REDEPLOYVARPOS,[0,0,0]])
#define REDEPLOYSETPOS(varPos)				(missionNamespace setVariable [REDEPLOYVARPOS,varPos])

#define REDEPLOYVARJUMPPOS					"MPSF_HALO_var_selectedJumpPos"
#define REDEPLOYGETJUMPPOS					(missionNamespace getVariable [REDEPLOYVARJUMPPOS,[0,0,0]])
#define REDEPLOYSETJUMPPOS(varPos)			(missionNamespace setVariable [REDEPLOYVARJUMPPOS,varPos])

#define REDEPLOYVARJUMPALT					"MPSF_HALO_var_selectedJumpAltitude"
#define REDEPLOYGETJUMPALT					(missionNamespace getVariable [REDEPLOYVARJUMPALT,1000])
#define REDEPLOYSETJUMPALT(altitude)		(missionNamespace setVariable [REDEPLOYVARJUMPALT,altitude])

#define GETPLAYERKILLED						!(player getVariable ["aliveState",alive player])

#define VARRESPAWNPOS						"MPSF_RespawnMP_respawnPos"
#define GETRESPAWNPOS						(missionNamespace getVariable [VARRESPAWNPOS,[0,0,0]])
#define SETRESPAWNPOS(varPos)				(missionNamespace setVariable [VARRESPAWNPOS,varPos])

#define VARPLAYERBODY						"MPSF_RespawnMP_playerBody"
#define GETPLAYERBODY						(missionNamespace getVariable [VARPLAYERBODY,player])
#define SETPLAYERBODY(varBody)				(missionNamespace getVariable [VARPLAYERBODY,varBody])

#define VARRESPAWNTIMER						"MPSF_RespawnMP_playerRespawnTimer"
#define GETRESPAWNTIMER						(missionNamespace getVariable [VARRESPAWNTIMER,0])
#define SETRESPAWNTIMER(varTime)			(missionNamespace setVariable [VARRESPAWNTIMER,varTime])

#define REDEPLOYGETSELECTJUMPPOS(target)	(target getVariable [REDEPLOYVARJUMPPOS,[0,0,0]])
#define REDEPLOYSETSELECTJUMPPOS(target,varPos)	(target setVariable [REDEPLOYVARJUMPPOS,varPos,true])
#define REDEPLOYJUMPSELECTED				!(REDEPLOYGETJUMPPOS isEqualTo [0,0,0])
#define REDEPLOYSELECTED					!(REDEPLOYGETPOS isEqualTo [0,0,0])

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
// UI
	case "onMapDraw" : {
		disableSerialization;
		_params params [["_ctrlMap",controlNull,[controlNull]]];
		private _colorSide = (player call BIS_fnc_objectSide) call BIS_fnc_sidecolor;
		private _redeployPositions = ["getRedeployPoints",[player]] call MPSF_fnc_respawnMP;

		["updateCtrlRespawnTimer"] call MPSF_fnc_respawnMP;

		_ctrlMap drawRectangle [[worldSize/2,worldSize/2,0],worldSize/2,worldSize/2,0,[1,1,1,0.42],"\A3\Ui_f\data\GUI\Rsc\RscDisplayStrategicMap\cross_ca.paa"];

		// Halo Areas
		{
			_x params [["_target",objNull,[objNull,"",[]]],["_displayName","",[""]],["_halo",false,[false]]];
			private _drawPos = _target call BIS_fnc_position;
			_ctrlMap drawEllipse ([_drawPos] + JUMPAREA + [[1,1,1,1],"#(rgb,8,8,3)color(0.4,0.4,0.4,0.3)"]);
			_ctrlMap drawEllipse ([_drawPos] + JUMPAREA + [_colorSide,"\A3\ui_f\data\map\markerbrushes\fdiagonal_ca.paa"]);
		} forEach (_redeployPositions select {(_x select 2)});

		// Respawn
		{
			_x params [["_target",objNull,[objNull,"",[]]],["_displayName","",[""]],["_halo",false,[false]]];
			private _drawPos = _target call BIS_fnc_position;
			if (_displayName isEqualTo "") then { _displayName = mapGridPosition _drawPos; };
			_ctrlMap drawIcon [ICONEMPTY,COLOURWHITE,_drawPos,32,32,0," " + _displayName,1,0.03,'PuristaMedium','right'];
			if !(_target isEqualTo REDEPLOYGETPOS) then {
				if ({ alive _x && {side group _x != side group player} && {_x distance _drawPos <= 250} } count allUnits > 0) then {
					private _colorDanger = ["IGUI","WARNING_RGB"] call BIS_fnc_displayColorGet;
					_colorDanger set [3, 1];
					_ctrlMap drawicon [ICONSELECTED,COLOURWHITE,_drawPos,30,30,0,"",1];
					_ctrlMap drawicon [ICONMOVEWARNING,_colorDanger,_drawPos,30,30,0,"",1];
				} else {
					private _image = [0,1,2,3,4,5,6,5,4,3,2,1] select (((diag_frameNo + _forEachIndex)/5)%11);
					_ctrlMap drawicon [format[ICONBADGE,_image],COLOURWHITE,_drawPos,30,30,0,"",1];
				};
			};
		} forEach (_redeployPositions select {!(_x select 2)});

		// Draw Group Jump Points
		{
			if (alive _x && isPlayer _x) then {
				private _jumpTeamPos = REDEPLOYGETSELECTJUMPPOS(_x);
				if !(_jumpTeamPos isEqualTo [0,0,0]) then {
					private _displayName = name _x;
					_ctrlMap drawIcon [ICONMOVE,_colorSide,_jumpTeamPos,32,32,0,"",1,0.03,'PuristaMedium','right'];
					_ctrlMap drawIcon [ICONEMPTY,[1,1,1,1],_jumpTeamPos,32,32,0,format[" %1 %2",_displayName,""],1,0.03,'PuristaMedium','right']; // Todo: Localise
				};
			};
		} forEach ((units group player) - [player]);

		// Draw selected redeploy position
		switch (true) do {
			case (REDEPLOYSELECTED) : {
				private _drawPos = REDEPLOYGETPOS call BIS_fnc_position;
				_ctrlMap drawIcon [ICONSELECTORM,COLOURORANGE,_drawPos,32,32,(diag_frameNo%360)*4,"",1,0.03,'PuristaMedium','right'];
				_ctrlMap drawIcon [ICONMOVE,COLOURWHITE,_drawPos,24,24,0,"",1,0.03,'PuristaMedium','right'];
			};
			case (REDEPLOYJUMPSELECTED) : {
				private _drawPos = REDEPLOYGETJUMPPOS call BIS_fnc_position;
				_ctrlMap drawIcon [ICONSELECTORM,COLOURORANGE,_drawPos,32,32,(diag_frameNo%360)*4,"",1,0.03,'PuristaMedium','right'];
				_ctrlMap drawIcon [ICONPARACHUTE,COLOURWHITE,_drawPos,24,24,0,"",1,0.03,'PuristaMedium','right'];
				_ctrlMap drawIcon [ICONEMPTY,COLOURWHITE,_drawPos,24,24,0," Parachute",1,0.03,'PuristaMedium','right']; // Todo: Localise
			};
		};
	};
	case "updateCtrlRespawnTimer" : {
		private _timeLeft = ["getRespawnTimer"] call MPSF_fnc_respawnMP;
		systemChat str _timeLeft;
		if !(_timeLeft > 0) exitWith {
			["updateCtrlMenu"] call MPSF_fnc_respawnMP;
		};
		private _ctrlText = uiNamespace getVariable ["RscRespawn_IDC_ctrlButton3",controlNull];
		if (_timeLeft > 1e4) then {
			_ctrlText ctrlSetText format ["Awaiting Respawn"]; // TODO: localize
		} else {
			_ctrlText ctrlSetText format ["Deploy in: %1",[_timeLeft/60,"HH:MM:SS:MM"] call BIS_fnc_timeToString]; // TODO: localize
		};
		_ctrlText ctrlSetFade 0;
		_ctrlText ctrlCommit 0;
	};
	case "updateCtrlMenu" : {
		private _redeploySelected = !(REDEPLOYGETPOS isEqualTo [0,0,0]);
		private _parachuteSelect = !(REDEPLOYGETJUMPPOS isEqualTo [0,0,0]);
		private _respawnTimeout = (["getRespawnTimer"] call MPSF_fnc_respawnMP) <= 0;
		private _stateDeploy1 = _respawnTimeout && (_parachuteSelect || _redeploySelected);
		private _ctrlBtnSpectate = uiNamespace getVariable ["RscRespawn_IDC_ctrlButton1",controlNull];
		_ctrlBtnSpectate ctrlEnable false;
		_ctrlBtnSpectate ctrlCommit 0;

		private _ctrlBtnLoadout = uiNamespace getVariable ["RscRespawn_IDC_ctrlButton2",controlNull];
		_ctrlBtnLoadout ctrlEnable false;
		_ctrlBtnLoadout ctrlCommit 0;

		private _ctrlDeploy1 = uiNamespace getVariable ["RscRespawn_IDC_ctrlButton3",controlNull];
		_ctrlDeploy1 ctrlEnable _stateDeploy1;
		switch (true) do {
			case (_stateDeploy1) : {
				_ctrlDeploy1 ctrlSetText format ["Deploy to %1",toUpper worldName]; // TODO: localize
				_ctrlDeploy1 ctrlSetTooltip "Deploy To Battlefield"; // TODO: Localize
				_ctrlDeploy1 ctrlSetEventHandler ["buttonclick","['onMouseClick',_this] call MPSF_fnc_respawnMP;"];
			};
			case !(_stateDeploy1) : {
				_ctrlDeploy1 ctrlSetTooltip "";
				_ctrlDeploy1 ctrlSetEventHandler ["buttonclick",""];
			};
		};
		_ctrlDeploy1 ctrlSetFade 0;
		_ctrlDeploy1 ctrlCommit 0;
	};
	case "onMapSelect" : {
		_params params [["_ctrlMap",controlNull,[controlNull]],["_key",0,[0]],["_xCord",0,[0]],["_yCord",0,[0]],["_shift",false,[false]],["_ctrl",false,[false]],["_alt",false,[false]]];
		if !(_key isEqualTo 0) exitWith {};

		REDEPLOYSETPOS(nil);
		REDEPLOYSETJUMPPOS(nil);
		REDEPLOYSETSELECTJUMPPOS(player,nil);

		private _ctrlMapPos = _ctrlMap ctrlMapScreenToWorld [_xCord,_yCord];
		private _nearestPoint = ["getNearestPosition",[_ctrlMapPos,[player] call BIS_fnc_objectSide]] call MPSF_fnc_respawnMP;
		private _nearestPos = (_nearestPoint select 0) call BIS_fnc_position;
		private _nearestDist = _ctrlMapPos distance2D _nearestPos;

		["setDistanceText",[if (alive player) then { player distance2D _ctrlMapPos } else { _nearestDist }]] call MPSF_fnc_respawnMP;

		switch (true) do {
			case (_nearestDist < 500) : {
				REDEPLOYSETPOS(_nearestPoint select 0);
				["setAltitudeSliderEnabled",[uiNamespace getVariable ["RscRespawn_IDC_ctrlSlider",controlNull]]] call MPSF_fnc_respawnMP;
				["centerMap",[_ctrlMap,_nearestPos]] call MPSF_fnc_respawnMP;
			};
			case ((["haloEnabled"] call MPSF_fnc_respawnMP) && count (HALOJUMPAREAS(player)) > 0 && alive player) : {
				if (count (HALOJUMPAREAS(player) select {_ctrlMapPos inArea ([(_x select 0) call BIS_fnc_position] + JUMPAREA + [false])}) > 0) then {
					REDEPLOYSETJUMPPOS(_ctrlMapPos);
					REDEPLOYSETSELECTJUMPPOS(player,_ctrlMapPos);
					["setAltitudeSliderEnabled",[uiNamespace getVariable ["RscRespawn_IDC_ctrlSlider",controlNull],true]] call MPSF_fnc_respawnMP;
					["centerMap",[_ctrlMap,_ctrlMapPos]] call MPSF_fnc_respawnMP;
				};
			};
			case ((["haloEnabled"] call MPSF_fnc_respawnMP) && count (HALOJUMPAREAS(player)) == 0 && alive player) : {
				REDEPLOYSETJUMPPOS(_ctrlMapPos);
				REDEPLOYSETSELECTJUMPPOS(player,_ctrlMapPos);
				["setAltitudeSliderEnabled",[uiNamespace getVariable ["RscRespawn_IDC_ctrlSlider",controlNull],true]] call MPSF_fnc_respawnMP;
				["centerMap",[_ctrlMap,_ctrlMapPos]] call MPSF_fnc_respawnMP;
			};
			default {
				["setAltitudeSliderEnabled",[uiNamespace getVariable ["RscRespawn_IDC_ctrlSlider",controlNull]]] call MPSF_fnc_respawnMP;
			};
		};
		["updateGridText"] call MPSF_fnc_respawnMP;
		["updateCtrlMenu"] call MPSF_fnc_respawnMP;
	};
	case "onMouseClick" : {
		_params params [["_ctrl",controlNull,[controlNull,0]]];
		private _idc = if !(_ctrl isEqualType controlNull) then { _ctrl } else { ctrlIDC _ctrl };
		switch (_idc) do {
			case 1002 : {};
			case 2001 : { ['openSpectatorUI'] call MPSF_fnc_respawnMP; };
			case 2002 : { ['openLoadoutUI'] call MPSF_fnc_respawnMP; };
			case 2003 : {
				private _selectDeployPos = REDEPLOYGETPOS;
				private _selectJumpPos = REDEPLOYGETJUMPPOS;
				if !(_selectJumpPos isEqualTo [0,0,0]) then { _selectJumpPos set [2,REDEPLOYGETJUMPALT]; };
				private _redeployPos = if (_selectJumpPos isEqualTo [0,0,0]) then { _selectDeployPos } else { _selectJumpPos };
				SETRESPAWNPOS(_redeployPos);
				if (GETPLAYERKILLED) then {
					if (isMultiplayer) then {
						setPlayerRespawnTime 0;
					} else {
						["onRespawn",[player,player]] spawn MPSF_fnc_respawnMP;
					};
				} else {
					private _units = ((units group player) select {((_x distance2D player) < 50) && !(isPlayer _x)}) + [player];
					["onRedeploy",[_units,_redeployPos],0] call MPSF_fnc_triggerEventHandler;
				};
				["closeUI"] call MPSF_fnc_respawnMP;
			};
			case 2004 : {};
			case 2005 : { ['closeUI'] call MPSF_fnc_respawnMP; };
			case 4001 : {
				_altitude = _params param [1,0,[0]];
				_altitude = 500 max ((round(_altitude/100)) * 100);
				_ctrl slidersetposition _altitude;
				REDEPLOYSETJUMPALT(_altitude);
				["setAltitudeText",[_altitude]] call MPSF_fnc_respawnMP;
			};
		};
	};
	case "setDistanceText" : {
		_params params [["_distance",0,[0]]];
		if !(_distance > 0) exitWith { ["setDistanceTextShow",[false]] call MPSF_fnc_respawnMP; };
		["setDistanceTextShow",[true]] call MPSF_fnc_respawnMP;
		private _ctrlText = uiNamespace getVariable ["RscRespawn_IDC_ctrlSliderText1",controlNull];
		private _stringFormat = "<t size='0.8' shadow='0'>%1</t><br/><t size='1.2' shadow='0'>%2</t><br/><t size='0.8'>%3</t>";
		private _distance = if (_distance < 1000) then {
			[format ["%1m",round(_distance)],format ["%1ft",round(_distance*3.28084)]];
		} else {
			[format ["%1km",round(_distance/100)/10],format ["%1mi",round((_distance*0.621371)/100)/10]];
		};
		_distance params ["_distanceMetric","_distanceImperial"];
		private _stringText = format[_stringFormat,"Dist. Base",_distanceMetric,_distanceImperial];
		_ctrlText ctrlSetStructuredText parseText _stringText; // Todo: Localise
	};
	case "setDistanceTextShow" : {
		_params params [["_enabled",false,[false]]];
		private _ctrlText = uiNamespace getVariable ["RscRespawn_IDC_ctrlSliderText1",controlNull];
		switch (true) do {
			case (_enabled) : {
				_ctrlText ctrlEnable _enabled;
				_ctrlText ctrlSetFade 0;
				_ctrlText ctrlCommit 0;
			};
			case !(_enabled) : {
				_ctrlText ctrlEnable _enabled;
				_ctrlText ctrlSetFade 1;
				_ctrlText ctrlCommit 0;
			};
		};
	};
	case "setAltitudeText" : {
		_params params [["_altitude",0,[0]]];
		private _ctrlText = uiNamespace getVariable ["RscRespawn_IDC_ctrlSliderText2",controlNull];
		private _stringFormat = "<t size='0.8' shadow='0'>%1</t><br/><t size='1.2' shadow='0'>%2</t><br/><t size='0.8'>%3</t>";
		private _altJump = _altitude < 4500;
		private _altitude = if (_altitude < 1000) then {
			[format ["%1m",round(_altitude)],format ["%1ft",round(_altitude*3.28084)]];
		} else {
			[format ["%1km",round(_altitude/100)/10],format ["%1mi",round((_altitude*0.621371)/100)/10]];
		};
		_altitude params ["_heightMetric","_heightImperial"];
		private _stringText = format[_stringFormat,if (_altJump) then {"Jump Alt."} else {"HALO Alt."},_heightMetric,_heightImperial];
		_ctrlText ctrlSetStructuredText parseText _stringText; // Todo: Localise
	};
	case "setAltitudeSliderEnabled" : {
		_params params [["_ctrlSlider",controlNull,[controlNull]],["_enabled",false,[false]]];
		private _ctrlText = uiNamespace getVariable ["RscRespawn_IDC_ctrlSliderText2",controlNull];
		switch (true) do {
			case (_enabled) : {
				_ctrlText ctrlEnable _enabled;
				_ctrlText ctrlSetFade 0;
				_ctrlText ctrlCommit 0;
				_ctrlSlider ctrlSetFade 0;
			};
			case !(_enabled) : {
				_ctrlText ctrlEnable _enabled;
				_ctrlText ctrlSetFade 1;
				_ctrlText ctrlCommit 0;
				_ctrlSlider ctrlSetFade 1;
			};
		};
		_ctrlSlider ctrlEnable _enabled;
		_ctrlSlider ctrlCommit 0;
	};
	case "centerMap" : {
		_params params [["_ctrlMap",controlNull,[controlNull]],["_position",[],[[]]]];

		if (count _position > 0) exitWith {
			_position params ["_posX","_posY"];
			_ctrlMap ctrlMapAnimAdd [0.2,ctrlmapscale _ctrlMap min 0.3,[_posX,_posY]];
			ctrlMapAnimCommit _ctrlMap;
		};

		private _respawnAreas = ["getRedeployPoints",[player]] call MPSF_fnc_respawnMP;
		if (count _respawnAreas > 0) then {
			private _posXmin = 1e10;
			private _posXmax = 0;
			private _posYmin = 1e10;
			private _posYmax = 0;
			{
				_x params [["_target",objNull,[objNull,"",[]]],["_displayName","",[""]],["_halo",false,[false]]];
				private _xPos = (_target) call BIS_fnc_position;
				_posXmin = _posXmin min (_xPos select 0);
				_posXmax = _posXmax max (_xPos select 0);
				_posYmin = _posYmin min (_xPos select 1);
				_posYmax = _posYmax max (_xPos select 1);
			} foreach _respawnAreas;
			private _posW =  _posXmax - _posXmin;
			private _posH = _posYmax - _posYmin;
			private _posX = _posXmin + _posW / 2;
			private _posY = _posYmin + _posH / 2;
			private _mapPosMax = _ctrlMap ctrlmapworldtoscreen [_posXmax,_posYmax];
			private _mapPosMin = _ctrlMap ctrlmapworldtoscreen [_posXmin,_posYmin];
			private _mapPosW = ((_mapPosMax select 0) - (_mapPosMin select 0));
			private _mapPosH = ((_mapPosMin select 1) - (_mapPosMax select 1));
			private _mapZoom = if (_mapPosW > 0 && _mapPosH > 0) then {
				private _mapScale = ctrlmapscale _ctrlMap;
				private _mapScaleW = _mapScale / ((ctrlposition _ctrlMap select 2) / _mapPosW);
				private _mapScaleH = _mapScale / ((ctrlposition _ctrlMap select 3) / _mapPosH);
				(_mapScaleW max _mapScaleH) * 2
			} else {
				ctrlmapscale _ctrlMap
			};
			_ctrlMap ctrlMapAnimAdd [0,_mapZoom,[_posX,_posY]];
		} else {
			_ctrlMap ctrlMapAnimAdd [0,0.1,[worldSize/2,worldSize/2,0]];
		};
		ctrlMapAnimCommit _ctrlMap;
		true;
	};
	case "onLoadUI" : {
		disableSerialization;
		private _dialog = _params select 0;
		uiNamespace setVariable ["RscRespawn_dialog",(_dialog)];

		{
			private _ctrl = _dialog displayCtrl (_x select 1);
			uiNamespace setVariable [(_x select 0),_ctrl];
			_ctrl ctrlSetFade 1;
			_ctrl ctrlCommit 0;
		} forEach [
			["RscRespawn_IDC_ctrlBackground",1001]
			,["RscRespawn_IDC_ctrlMap",1002]
			,["RscRespawn_IDC_ctrlTitleLogo",1003]
			,["RscRespawn_IDC_ctrlMenu",2000]
			,["RscRespawn_IDC_ctrlButton1",2001]
			,["RscRespawn_IDC_ctrlButton2",2002]
			,["RscRespawn_IDC_ctrlButton3",2003]
			,["RscRespawn_IDC_ctrlButton4",2004]
			,["RscRespawn_IDC_ctrlButton5",2005]
			,["RscRespawn_IDC_ctrlSlider",4001]
			,["RscRespawn_IDC_ctrlSliderText1",4002]
			,["RscRespawn_IDC_ctrlSliderText2",4003]
		];

		private _ctrlBackground = uiNamespace getVariable ["RscRespawn_IDC_ctrlBackground",controlNull];
		_ctrlBackground ctrlEnable false;

		private _ctrlTitleLogo = uiNamespace getVariable ["RscRespawn_IDC_ctrlTitleLogo",controlNull];
		_ctrlTitleLogo ctrlEnable false;
		_ctrlTitleLogo ctrlSetFade 0.9;
		_ctrlTitleLogo ctrlCommit 0;

		private _ctrlMap = uiNamespace getVariable ["RscRespawn_IDC_ctrlMap",controlNull];
		["centerMap",[_ctrlMap]] call MPSF_fnc_respawnMP;
		_ctrlMap ctrlAddEventHandler ["Draw",{
			#include "\A3\ui_f\scripts\gui\RscDiaryTaskMarkers.sqf"
		}];
		_ctrlMap ctrlAddEventHandler ["draw",{["onMapDraw",_this] call MPSF_fnc_respawnMP;}];
		_ctrlMap ctrlAddEventHandler ["mouseButtonDown",{["onMapSelect",_this] call MPSF_fnc_respawnMP;}];
		_ctrlMap ctrlAddEventHandler ["mouseButtonDblClick",{["onMapSelect",_this] call MPSF_fnc_respawnMP;}];
		_ctrlMap ctrlAddEventHandler ["setfocus",{_this spawn {disableserialization; (_this select 0) ctrlenable false; (_this select 0) ctrlenable true;};}];

		private _killed = uiNamespace getVariable ["MPSF_RespawnMP_var_killedUI",false];
		if (_killed) then {
			_ctrlBackground ctrlSetBackgroundColor [0,0,0,1];
			_ctrlBackground ctrlSetFade 0;
			_ctrlBackground ctrlCommit 0.1;
			uiSleep 2;
			_ctrlMap ctrlEnable false;
			_ctrlMap ctrlSetFade 0;
			_ctrlMap ctrlCommit 0;
			_ctrlBackground ctrlSetFade 0.8;
			_ctrlBackground ctrlCommit 0.5;
			uiSleep 0.5;
			_ctrlMap ctrlEnable true;
		} else {
			_ctrlMap ctrlSetFade 0;
			_ctrlMap ctrlCommit 0;
		};

		[] spawn {
			disableSerialization;
			{
				private _ctrl = uiNamespace getVariable [_x,controlNull];
				_ctrl ctrlSetFade 0;
				_ctrl ctrlCommit 0.5;
				uiSleep 0.1;
			} forEach [
				"RscRespawn_IDC_ctrlMenu"
				,"RscRespawn_IDC_ctrlButton1"
				,"RscRespawn_IDC_ctrlButton2"
				,"RscRespawn_IDC_ctrlButton3"
				,"RscRespawn_IDC_ctrlButton4"
				,"RscRespawn_IDC_ctrlButton5"
			];
		};

		private _ctrlSlider = uiNamespace getVariable ["RscRespawn_IDC_ctrlSlider",controlNull];
		_ctrlSlider slidersetrange [0,10000];
		['onMouseClick',[_ctrlSlider,1000]] call MPSF_fnc_respawnMP;
		["setAltitudeSliderEnabled",[_ctrlSlider]] call MPSF_fnc_respawnMP;
		_ctrlSlider ctrlAddEventHandler ["sliderposchanged",{ ['onMouseClick',_this] call MPSF_fnc_respawnMP; }];

		["updateCtrlMenu"] call MPSF_fnc_respawnMP;
	};
	case "openUI" : {
		disableSerialization;
		uiNamespace setVariable ["MPSF_RespawnMP_var_killedUI",GETPLAYERKILLED];

		onMapSingleClick "";

		private _uiType = if (GETPLAYERKILLED) then {"respawn"} else {"redeploy"};
		missionNamespace setVariable ["MPSF_RespawnMP_UIType",_uiType];

		if !(GETPLAYERKILLED) then { ["#(argb,8,8,3)color(0,0,0,1)",false,nil,0,[0,0.5]] call BIS_fnc_textTiles; };
		if !("MPSF_RespawnMP_blackScreen" in (missionNamespace getVariable ["BIS_fnc_blackOut_ids",[]])) then {
			["MPSF_RespawnMP_blackScreen",false] call BIS_fnc_blackOut;
		};

		REDEPLOYSETPOS(nil);
		REDEPLOYSETJUMPPOS(nil);
		REDEPLOYSETSELECTJUMPPOS(player,nil);
		REDEPLOYSETJUMPALT(nil);

		// Create Display
		private _display = (findDisplay 46) createDisplay "RscDisplayRespawn";
		waitUntil {!isNull _display};
		uiNamespace setVariable ["MPSF_RespawnMP_DisplayID",_display];
		waitUntil {isNull _display};
		uiNamespace setVariable ["MPSF_RespawnMP_var_killedUI",nil];
		missionNamespace setVariable ["MPSF_RespawnMP_UIType",nil];

		REDEPLOYSETPOS(nil);
		REDEPLOYSETJUMPPOS(nil);
		REDEPLOYSETSELECTJUMPPOS(player,nil);
		REDEPLOYSETJUMPALT(nil);

		["#(argb,8,8,3)color(0,0,0,1)",false,nil,0,[0,0.5]] call BIS_fnc_textTiles;

		if (GETPLAYERKILLED && isNull _display) exitWith {
			["openUI",[true]] spawn {sleep 0.2; _this call MPSF_fnc_respawnMP;};
		};
		["MPSF_RespawnMP_blackScreen",false] call BIS_fnc_blackIn;
	};
	case "closeUI" : {
		(uiNamespace getVariable ["MPSF_RespawnMP_DisplayID",displayNull]) closeDisplay 1;
	};
// Event Handlers
	case "onKilled" : {
		_params params[["_target",objNull,[objNull]],["_killer",objNull,[objNull]]];
		// Respawn Counter
		["resetRespawnTimer"] call MPSF_fnc_respawnMP;
		// SP default pos while respawning
		if !(isMultiplayer) then {
			if !(alive _target) exitWith {};
			private _respawnMarkers = (player call BIS_fnc_objectSide) call BIS_fnc_getRespawnMarkers;
			if (count _respawnMarkers > 0) then {
				["setPosition",[player,selectRandom _respawnMarkers]] call MPSF_fnc_respawnMP;
			} else {
				player setpos [10,10,100];
			};
			player setUnconscious false;
			player setDamage 0;
			player hideobject true;
			player enablesimulation false;
			player setVariable ["aliveState",false];
		};
		// HIDE UI
		showHUD false;
		showChat false;
		{ inGameUISetEventHandler [_x,"true"]; } forEach ["PrevAction", "Action", "NextAction"];
		// Create Display
		["openUI"] spawn MPSF_fnc_respawnMP;
		//
		true;
	};
	case "onRespawn" : {
		_params params[["_newUnit",objNull,[objNull]],["_oldUnit",objNull,[objNull]]];

		private _position = GETRESPAWNPOS;
		if !(_position isEqualTo [0,0,0]) then {
			["setPosition",[player,_position]] call MPSF_fnc_respawnMP;
		} else {
			private _respawnMarkers = (player call BIS_fnc_objectSide) call BIS_fnc_getRespawnMarkers;
			if (count _respawnMarkers > 0) then {
				["setPosition",[player,selectRandom _respawnMarkers]] call MPSF_fnc_respawnMP;
			} else {
				player setpos _oldUnit;
			};
		};
		// Unhide SP Player
		if !(isMultiplayer) then {
			player hideobject false;
			player enablesimulation true;
			player setVariable ["aliveState",nil];
		};
		// Reset Damage
		isNil {player setDamage 0};
		// Show UI
 		showHUD (uiNamespace getVariable ["MPSF_RespawnMP_var_showHud",true]);
		showChat (uiNamespace getVariable ["MPSF_RespawnMP_var_showChat",true]);
		{inGameUISetEventHandler [_x, ""]} forEach ["PrevAction", "Action", "NextAction"];
		// Remove Old Body
		if !(isNull _oldUnit) then { deleteVehicle _oldUnit; };

		["closeUI"] call MPSF_fnc_respawnMP;

		SETRESPAWNPOS(nil);
		setPlayerRespawnTime 1e9;
	};
	case "onRedeploy" : {
		_params params [["_units",[],[[]]],["_position",objNull,[objNull,"",[]]],["_instant",false,[false]]];
		if ({local _x} count _units == 0) exitWith {};
		if (player in _units) then {
			if (_instant) then {
				["#(argb,8,8,3)color(1,1,1,1)",false,nil,0,[0,0.5]] call BIS_fnc_textTiles;
			} else {
				["MPSF_Respawn_displayTransition",true,1] call BIS_fnc_blackOut;
				uiSleep 2;
			};
		};
		private _centerPos = _position call BIS_fnc_position;
		{
			private _target = _x;
			if (local _target) then {
				switch (true) do {
					case (_position isEqualType []) : {
						private _movePos = _centerPos getPos [5 * _forEachIndex,5 * _forEachIndex];
						_movePos set [2,(_position select 2)];
						["setPosition",[_target,_movePos]] call MPSF_fnc_respawnMP;
					};
					case !(_target isKindOf "CaManBase") : {
						["setPosition",[_target,_position call BIS_fnc_position]] call MPSF_fnc_respawnMP;
					};
					default {
						["setPosition",[_target,_position]] call MPSF_fnc_respawnMP;
					};
				};
			};
		} forEach _units;
		if (player in _units) then {
			if (_instant) then {} else {
				uiSleep 2;
				["MPSF_Respawn_displayTransition",true,1] call BIS_fnc_blackIn;
			};
		};
	};
// Positions
	case "addRespawnPosition" : {
		_params params [["_positionID","",[""]],["_position","",["",objNull,grpNull,[]]],["_displayName","",[""]]];
		["addPosition",[_positionID,missionNamespace,_position,_displayName]] call MPSF_fnc_respawnMP;
	};
	case "removeRespawnPosition" : {
		_params params [["_positionID","",[""]]];
		["removePosition",[_positionID,missionNamespace]] call MPSF_fnc_respawnMP;
	};
	case "addRedeployPoint" : {
		if !(isServer) exitWith {};
		_params params [["_redeployLogic",objNull,[objNull,[]]],["_orientation",[10,10,0],[[]]],["_dest","",[[],""]]];
		_orientation params [["_sizeA",10,[0]],["_sizeB",10,[0]],["_direction",0,[0]]];

		if (_redeployLogic isEqualType []) then {
			_redeployLogic = [_redeployLogic,_direction] call MPSF_fnc_createLogic;
		};
		if (isNull _redeployLogic) exitWith {};

		_redeployLogic setVariable ["redeployPoint",true,true];
		_redeployLogic setVariable ["redeployPos",_dest,true];
		["onRedeployCreate",[_redeployLogic,[_sizeA,_sizeB]],0] call MPSF_fnc_triggerEventHandler;

		true;
	};
// Actions
	case "addRedeployActions" : {
		_params params [["_redeployLogic",objNull,[objNull]],["_area",[10,10],[[]]]];
		_area params [["_sizeA",10,[0]],["_sizeB",10,[0]]];

		if (hasInterface) then {
			if !(isNull (_redeployLogic getVariable ["MPSF_RespawnMP_Redeploy_Trigger",objNull])) exitWith {};
			private _trigger = createTrigger ["EmptyDetector",_redeployLogic,false];
			_trigger setTriggerArea [_sizeA max 2,_sizeB max 2,getDir _redeployLogic,false];
			_trigger setTriggerActivation ["ANYPLAYER","PRESENT",true];
			_trigger setTriggerStatements ["(vehicle player) in thisList"
				,format["['activateRedeployActions',[thisTrigger]] call MPSF_fnc_respawnMP;"]
				,format["['deactivateRedeployActions',[thisTrigger]] call MPSF_fnc_respawnMP;"]
			];
			_trigger attachTo [_redeployLogic,[0,0,0]];
			_redeployLogic setVariable ["MPSF_RespawnMP_Redeploy_Trigger",_trigger];
			[getPos _redeployLogic,3,[0,0,1]] call MPSF_fnc_refractionPoint;
		};
	};
	case "activateRedeployActions" : {
		_params params [["_trigger",objNull]];

		private _redeployLink = (attachedTo _trigger) getVariable ["redeployPos",""];
		if !(_redeployLink isEqualTo "") then {
			// PPEffect Create
			private _handle = nil;
			if (isNil {missionNamespace getVariable "MPSF_WetScreen_Effect"}) then {
				_handle = ppEffectCreate ["WetDistortion",925];
				_handle ppEffectEnable true;
				_handle ppEffectAdjust WETDISTORTION_0(0);
				_handle ppEffectCommit 0;
				missionNamespace setVariable ["MPSF_WetScreen_Effect",_handle];
			};

			SETRESPAWNPOS(_redeployLink);

			// Player Redeploy Menu
			["MPSF_RespawnMP_Redeploy_Action",player,format ["Redeploy to #%1",mapGridPosition _redeployLink],[
				["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
				,["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{
					private _progressTick = _this select 4;
					if (_progressTick % 2 == 0) exitwith {};
					private _coef = _progressTick / 24;
					MPSF_WetScreen_Effect ppeffectadjust WETDISTORTION_0(_coef);
					MPSF_WetScreen_Effect ppeffectcommit 0;
					MPSF_WetScreen_Effect ppeffectadjust WETDISTORTION_1(_coef);
					MPSF_WetScreen_Effect ppeffectcommit 0.2;
				}]
				,{
					MPSF_WetScreen_Effect ppeffectadjust WETDISTORTION_0(0);
					MPSF_WetScreen_Effect ppeffectcommit 0;
					["onRedeploy",[[vehicle player],GETRESPAWNPOS,true],true] call MPSF_fnc_triggerEventHandler;
				}
				,{
					MPSF_WetScreen_Effect ppeffectadjust WETDISTORTION_0(0);
					MPSF_WetScreen_Effect ppeffectcommit 0.4;
				}
				,4,false,101
			],[],"speed vehicle player == 0 && {player isEqualTo driver vehicle player}"
			,true] spawn {sleep 0.1; _this call MPSF_fnc_addAction;};
		} else {
			// Player Redeploy Menu
			["MPSF_RespawnMP_Redeploy_Action",player,"Open Redeploy Menu",[
				["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
				,["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
				,{ ["openUI"] spawn MPSF_fnc_respawnMP; }
				,{}
				,0.5,false,101
			],[],"speed vehicle player == 0"
			,true] spawn {sleep 0.1; _this call MPSF_fnc_addAction;};
		};
	};
	case "deactivateRedeployActions" : {
		["MPSF_RespawnMP_Redeploy_Action",player] call MPSF_fnc_removeAction;
		private _handle = missionNamespace getVariable "MPSF_WetScreen_Effect";
		if !(isNil "_handle") then {
			_handle ppEffectEnable false;
			ppEffectDestroy _handle;
			missionNamespace setVariable ["MPSF_WetScreen_Effect",nil];
		};
	};
// Functions
	case "resetRespawnTimer" : {
		_params params [["_respawn",GETPLAYERKILLED,[false]]];
		private _respawnType = if (_respawn) then {"respawn"} else {"redeploy"};
		private _respawnTimer = ["getCfgRespawnTimer"] call MPSF_fnc_respawnMP;
		switch (true) do {
			case (["getCfgEnable",[_respawnType,"Wave",side group player]] call MPSF_fnc_respawnMP) : {
				_respawnTimer = 0 + _respawnTimer - MISSIONTIME % _respawnTimer;
			};
			case (["getCfgEnable",[_respawnType,"Trigger",side group player]] call MPSF_fnc_respawnMP) : {
				_respawnTimer = 1e9;
			};
		};
		_respawnTimer = MISSIONTIME + _respawnTimer;
		SETRESPAWNTIMER(_respawnTimer);
		if (isMultiplayer) then { setPlayerRespawnTime 1e9; };
		true;
	};
	case "getRespawnTimer" : {
		if !(hasInterface) exitWith { -1 };
		if ((missionNamespace getVariable ["MPSF_RespawnMP_displayType",0]) == 1) exitWith {-1};
		//if (isMultiplayer) then { playerRespawnTime; };
		GETRESPAWNTIMER - MISSIONTIME;
	};
	case "addPosition" : {
		_params params [
			["_positionID","",[""]]
			,["_targetOrig",missionNamespace,[missionNamespace,sideUnknown,grpNull,objNull]]
			,["_position","",["",grpNull,objNull,[]]]
			,["_displayName","",[""]]
			,["_add",true,[true]]
		];

		if (["isPosition",[_positionID]] call MPSF_fnc_respawnMP) exitWith { _positionID };
		if (!isserver && time == 0) then { /*["Warning! Calling the function on client at the mission start will result in data not being broadcasted correctly!"] call BIS_fnc_error;*/ };

		private _varName = "MPSF_RespawnMP_Positions_list";
		private _target = _targetOrig;
		if (typeName _position == typeName objNull) then {_position = _position call BIS_fnc_objectVar;};
		if (typeName _target == typeName sideUnknown) then {
			_varName = _varName + str _target;
			_target = missionNamespace;
		};

		if (_displayName isEqualTo "" && {_position isEqualType "" || _position isEqualType []}) then {
			_displayName = mapGridPosition (_position call BIS_fnc_position);
		};

		private _positions = _target getvariable [_varName,[]];
		private _positionIDs = _positions apply {_x select 0};
		private _positionIndex = _positionIDs find _positionID;

		if (_add) then {
			if (_positionIndex < 0) then {
				private _handlerID = [_targetOrig,_position,_displayName] call BIS_fnc_addRespawnPosition;
				missionNamespace setVariable [_positionID,_handlerID];
				_positions pushBack [_positionID,_position,_displayName];
			};
		} else {
			if (_positionIndex >= 0) then {
				(missionNamespace getVariable [_positionID,[_targetOrig,-1]]) call BIS_fnc_removeRespawnPosition;
				_positions deleteAt _positionIndex;
			};
		};

		//--- Commit
		switch (typeName _target) do {
			case (typeName missionNamespace);
			case (typeName sideUnknown): {
				_target setvariable [_varName,_positions];
				publicvariable _varName;
			};
			case (typeName grpNull);
			case (typeName objNull): {
				_target setvariable [_varName,_positions,true];
			};
		};

		[_targetOrig,_positionID]
	};
	case "removePosition" : {
		_params params [
			["_positionID","",[""]]
			,["_targetOrig",missionNamespace,[missionNamespace,sideUnknown,grpNull,objNull]]
		];
		["addPosition",[_positionID,_targetOrig,nil,nil,false]] call MPSF_fnc_respawnMP;
	};
	case "getPositions" : {
		_params params [["_target",player,[objNull,grpNull,sideUnknown,missionNamespace]],["_type","",[""]]];

		private _varName = format["MPSF_RespawnMP_%1Positions_list",toLower _type];
		private _positions = missionNamespace getvariable [_varName,[]];

		if (toLower _type == "respawn") then {
			private _sideTarget = switch (typeName _target) do {
				case (typeName objNull);
				case (typeName grpNull): { _target call BIS_fnc_objectSide };
				case (typeName sideUnknown): { _target };
				default { player call BIS_fnc_objectSide };
			};

			// Markers
			{
				_positions pushBack [format ["BIS_Respawn_%1",_x],_x,format ["Grid #%1",mapGridPosition (getMarkerPos _x)]];
			} forEach ([_sideTarget] call BIS_fnc_getRespawnMarkers);

			// BIS Positions
			private _respawnPositions = [_target] call BIS_fnc_getRespawnPositions;
			private _respawnPositionsNames = [_target,1] call BIS_fnc_getRespawnPositions;
			{
				private _respawnName = _respawnPositionsNames select _forEachIndex;
				if (_respawnName isEqualTo "") then { _respawnName = format ["Grid #%1",mapGridPosition (_x call BIS_fnc_position)]; };
				_positions pushBack [format ["BIS_Respawn_%1",_x],_x,_respawnName];
			} forEach _respawnPositions;
		};

		switch (typeName _target) do {
			case (typeName objNull): {
				// Objects
				{_positions pushBack _x;} forEach (_target getvariable [_varName,[]]);
				{_positions pushBack _x;} forEach ((group _target) getvariable [_varName,[]]);
				{_positions pushBack _x;} forEach (missionNamespace getvariable [_varName + str (_target call bis_fnc_objectSide),[]]);
			};
			case (typeName grpNull): {
				{_positions pushBack _x;} forEach ((_target) getvariable [_varName,[]]);
				{_positions pushBack _x;} forEach (missionNamespace getvariable [_varName + str (_target call bis_fnc_objectSide),[]]);
			};
			case (typeName sideUnknown): {
				{_positions pushBack _x;} forEach (missionNamespace getvariable [_varName + str (_target),[]]);
			};
		};

		// Check Positions
		_positions = _positions select {
			switch (true) do {
				case ((_x select 1) isEqualType "") : {
					private _testObj = missionNamespace getvariable [(_x select 1),objNull];
					if !(isNull _testObj) then { alive _testObj && simulationenabled _testObj && canmove _testObj } else { markerpos (_x select 1) distance2D [0,0] > 0 };
				};
				case ((_x select 1) isEqualType objNull) : { alive (_x select 1) && simulationenabled (_x select 1) && canmove (_x select 1) };
				case ((_x select 1) isEqualType grpNull) : { alive leader (_x select 1); };
				default {_x};
			};
		};

		// Fix Names
		_positions = _positions apply {_x set [2,(_x select 2) call BIS_fnc_localize]; _x;};

		_positions
	};
	case "getPosition" : {
		_params params [["_positionID","",[""]],["_target",player,[objNull,grpNull,sideUnknown,missionNamespace]],["_type","",[""]]];
		private _positions = (["getPositions",[_target,_type]] call MPSF_fnc_respawnMP) select {_x select 0 == _positionID};
		if (count _positions > 0) then { _positions select 0 } else { [] };
	};
	case "isPosition" : {
		_params params [["_positionID","",[""]]];
		private _position = ["getPosition",[_positionID]] call MPSF_fnc_respawnMP;
		(count _position > 0);
	};
	case "setPosition" : {
		_params params [["_target",objNull,[objNull]],["_position",[0,0,0],[[],objNull,grpNull,""]],["_halo",false,[false]]];

		if (isNull _target) exitWith {false};

		switch (true) do {
			case (_position isEqualType objNull) : { _position = vehicle _position };
			case (_position isEqualType grpNull) : { _position = leader _position };
		};

		if (_position isEqualTo [0,0,0]) exitWith {false};

		switch (true) do {
			case (_position isEqualType objNull) : {
				// Move to Leader/Vehicle
				if !(locked _position > 1) then {
					if (_target moveInAny _position) exitWith {true};
				};

				private _zPos = (ASLToAGL getPosASL _position) select 2;
				private _bb = boundingBox _position;
				private _moveDirectionSelect = speed _position < 0 && !(_position isKindOf "CAManBase");

				if (_zPos >= 50) exitWith {
					private _spawnPos = _position modelToWorldVisual [5/2 - random 5,(_bb select _moveDirectionSelect select 1),(_bb select 0 select 2) * 1.25];
					if (_spawnPos isEqualTo [0,0,0]) exitWith {false};
					isNil {
						private _para = createVehicle ["Steerable_Parachute_F", _spawnPos, [], 0, "CAN_COLLIDE"];
						_para setDir (_para getDir _position);
						_target moveInDriver _para;
						_para setVelocity velocity _position;
					};
					true
				};

				//--- vehicle is on the ground, move next to it
				private _offset = (getPos _position distance getPosVisual _position) + 1.5;
				private _spawnPos = (_position getRelPos [ //--- get spawn position now, to make it more robust in scheduled
					(_bb select _moveDirectionSelect select 1)
					+
					([-_offset, _offset] select _moveDirectionSelect), //--- avoid appearing in front of a moving vehicle
					linearConversion [0, 100, round random 100, -15, 15]
				]) vectorAdd [0, 0, _zPos];

				if (isNil "_spawnPos" || {_spawnPos isEqualTo [0,0,0]}) exitWith {false};

				_target setVehiclePosition [_spawnPos, [], 0, "NONE"];
				_target setDir (_target getDir _position);

				true
			};
			case (_position isEqualType "") : {
				if !(isNull (missionNamespace getVariable [_position,objNull])) exitWith {
					["setPosition",[_target,missionNamespace getVariable [_position,objNull],_halo]] call MPSF_fnc_respawnMP;
				};
				private _markerPos = markerPos _position;
				if (_markerPos isEqualTo [0,0,0]) exitWith {};
				markerSize _position params ["_markerX", "_markerY"];
				_target setDir markerDir _position;
				_target setVehiclePosition [_markerPos, [], (_markerX * _markerY) / 2, "NONE"];
				true
			};
			case (_position isEqualTypeArray [0,0,0]) : {
				switch (true) do {
					case (_position select 2 >= 500) : {
						[_target,_position,(_position select 2)] call MPSF_fnc_respawnHALO;
					};
					case (_position select 2 >= 50) : {
						isNil {
							private _para = createVehicle ["Steerable_Parachute_F",_position,[],0,"CAN_COLLIDE"];
							_para setDir getDir _target;
							_target moveInDriver _para;
							true
						};
						_target setPosASL AGLToASL _position;
					};
					default {
						_target setPosASL AGLToASL _position;
					};
				};
				true
			};
		};
	};
	case "getNearestPosition" : {
		_params params [["_centrePos",[0,0,0],[[],objNull]]];

		if !(_centrePos isEqualType []) then { _centrePos = _centrePos call BIS_fnc_position; };

		private _positions = ["getRedeployPoints",[player]] call MPSF_fnc_respawnMP;
		if (count _positions == 0) exitWith { [0,0,0] };

		private _position = _positions select 0;
		private _distance = ((_position select 0) call BIS_fnc_position) distance2D _centrePos;
		{
			private _checkDistance = ((_x select 0) call BIS_fnc_position) distance2D _centrePos;
			if (_checkDistance < _distance) then {
				_position = _x;
				_distance = _checkDistance;
			};
		} forEach _positions;

		_position;
	};
	case "getRedeployPoints" : {
		_params params [["_target",player,[objNull,grpNull,sideUnknown,missionNamespace]]];

		private _sideTarget = switch (typeName _target) do {
			case (typeName objNull);
			case (typeName grpNull): { _target call BIS_fnc_objectSide };
			case (typeName sideUnknown): { _target };
			default { player call BIS_fnc_objectSide };
		};

		private _redeployPositions = [];
		private _respawnType = missionNamespace getVariable ["MPSF_RespawnMP_UIType","respawn"];

		if (["getCfgEnable",[_respawnType,"Base",side group player]] call MPSF_fnc_respawnMP) then {
			// Markers
			private _respawnMarkers = [_sideTarget] call BIS_fnc_getRespawnMarkers;
			{
				private _respawnName = markerText _x;
				if (_respawnName isEqualTo "") then { _respawnName = format ["Grid #%1",mapGridPosition (_x call BIS_fnc_position)]; };
				_redeployPositions pushBack [_x,_respawnName,false];
			} forEach _respawnMarkers;

			// BIS Positions
			private _respawnPositions = [_target] call BIS_fnc_getRespawnPositions;
			private _respawnPositionsNames = [_target,1] call BIS_fnc_getRespawnPositions;
			{
				private _respawnName = switch (true) do {
					case !((_respawnPositionsNames select _forEachIndex) isEqualTo "") : { _respawnPositionsNames select _forEachIndex; };
					case (["isMHQdeployed",[_x,false]] call MPSF_fnc_respawnMP) : { format ["MHQ %1 %2",([_x] call MPSF_fnc_getCfgText),"(Deployed)"]; };
					case (_x isEqualType objNull) : { format ["%1",([_x] call MPSF_fnc_getCfgText)]; };
					case (_x isEqualType grpNull) : { format ["%1 (%2)",groupID _x,name leader _x]; };
					default { format ["Grid #%1 %2",mapGridPosition (_x call BIS_fnc_position),typeName _x]; };
				};
				_redeployPositions pushBack [
					_x
					,_respawnName
					,if (_x isEqualType []) then {(_x select 2 > 1000)} else {false}
				];
			} forEach _respawnPositions;
		};

		if !(["getCfgEnable",[_respawnType,"Halo",side group player]] call MPSF_fnc_respawnMP) then {
			_redeployPositions = _redeployPositions select {!(_x select 2)};
		};

		if !(["getCfgEnable",[_respawnType,"Rallypoint",side group player]] call MPSF_fnc_respawnMP) then {
			_redeployPositions = _redeployPositions select {str (_x select 0) find "rallypoint" < 0};
		};

		if (["getCfgEnable",[_respawnType,"Group",side group player]] call MPSF_fnc_respawnMP) then {
			private _leader = leader group player;
			if (alive _leader && !(_leader isEqualTo player)) then {
				_redeployPositions pushBack [_leader,format ["%1 (%2)",groupID group _leader,name _leader],false];
			};
		};

		_redeployPositions
	};
// Configuration
	case "getCfgRespawn" : {
		_params params [["_typeVar","respawn",[""]],["_varName","",[""]],["_side",sideUnknown,[sideUnknown]]];
		switch (_varName) do {
			case "Base";
			case "Group";
			case "Halo";
			case "Rallypoints";
			case "Wave";
			case "Countdown";
			case "Spectator";
			case "Trigger" : {
				private _array = ["CfgRespawnMP",str _side,_typeVar] call MPSF_fnc_getCfgDataArray;
				_array append (["CfgRespawnMP",_typeVar] call MPSF_fnc_getCfgDataArray);
				toLower _varName IN (_array apply {toLower _x});
			};
			default {false};
		};
	};
	case "getCfgRespawnEnabled" : {
		missionNamespace getVariable ["MissionRespawnEnabled",
			["CfgRespawnMP","enabled"] call MPSF_fnc_getCfgDataBool
		];
	};
	case "getCfgEnable" : {
		_params params [["_typeVar","respawn",[""]],["_getVar","",[""]],["_side",side group player,[sideUnknown]]];
		missionNamespace getVariable [format["MissionRespawnMP_%1%2",_typeVar,_getVar],
			["getCfgRespawn",[_typeVar,_getVar,_side]] call MPSF_fnc_respawnMP
		];
	};
	case "getCfgRespawnTimer" : {
		missionNamespace getVariable ["MissionRespawnTimerEnabled",
			(["CfgRespawnMP",str(side group player),"respawnTimer"] call MPSF_fnc_getCfgDataNumber)
			max (["CfgRespawnMP","respawnTimer"] call MPSF_fnc_getCfgDataNumber)
		];
	};
	case "getCfgRedeployDelay" : {
		missionNamespace getVariable ["MissionRespawnDelay",
			(["CfgRespawnMP",str(side group player),"redeployDelay"] call MPSF_fnc_getCfgDataNumber)
			max (["CfgRespawnMP","redeployDelay"] call MPSF_fnc_getCfgDataNumber)
		];
	};
	case "haloEnabled" : {
		(["getCfgEnable",[(missionNamespace getVariable ["MPSF_RespawnMP_UIType","respawn"]),"Halo",side group player]] call MPSF_fnc_respawnMP) || ([player,"HALO"] call MPSF_fnc_getUnitTrait);
	};
// Init
	case "preInit" : {
		if (hasInterface) then {
			uiNamespace setVariable ["MPSF_RespawnMP_var_showHud",shownHUD];
			uiNamespace setVariable ["MPSF_RespawnMP_var_showChat",shownChat];
		};
		addMissionEventHandler ["Loaded",{diag_log format["Loaded:%1",_this]}];
		addMissionEventHandler ["EntityKilled",{diag_log format["EntityKilled:%1",_this]}];
		addMissionEventHandler ["EntityRespawned",{diag_log format["EntityRespawned:%1",_this]}];
	};
	case "postInit";
	case "init" : {
		if (hasInterface) then {
		//	["MPSF_RespawnMP_onKilled_EH","onKilled",{ ["onKilled",_this] spawn MPSF_fnc_respawnMP; }] call MPSF_fnc_addEventHandler;
		//	["MPSF_RespawnMP_onRespawn_EH","onRespawn",{ ["onRespawn",_this] spawn MPSF_fnc_respawnMP; }] call MPSF_fnc_addEventHandler;
			["MPSF_RespawnMP_onRedeploy_EH","onRedeploy",{ ["onRedeploy",_this] spawn MPSF_fnc_respawnMP; }] call MPSF_fnc_addEventHandler;
			["MPSF_RespawnMP_onTriggerRespawn_EH","onTriggerRespawn",{SETRESPAWNTIMER(0)}] call MPSF_fnc_addEventHandler;
			{
				["addRedeployActions",[_x]] call MPSF_fnc_respawnMP;
			} forEach ((allMissionObjects "All") select { _x getVariable ["redeployPoint",false]; });
			["MPSF_RespawnMP_onRedeployCreate_EH","onRedeployCreate",{ ["addRedeployActions",_this] call MPSF_fnc_respawnMP; }] call MPSF_fnc_addEventHandler;
		};
		["init"] call MPSF_fnc_respawnMHQ;
		["init"] call MPSF_fnc_respawnRally;
	};
};