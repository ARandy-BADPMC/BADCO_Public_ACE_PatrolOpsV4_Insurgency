#define MISSIONTIME			(if (isMultiplayer) then {serverTime} else {time})
#define COLOURWHITE				[1,1,1,1]
#define COLOURORANGE			[1,0.66,0,1]
#define ICONEMPTY				"#(argb,8,8,3)color(0,0,0,0)"
#define ICONSELECTORM			"\A3\ui_f\data\map\groupicons\selector_selectedMission_ca.paa"
#define ICONBADGE				"\A3\ui_f\data\Map\GroupIcons\badge_rotate_%1_gs.paa"
#define REDEPLOYVARPOS			"PO4_MISSION_var_selectedRedeployPos"
#define REDEPLOYGETPOS			(missionNamespace getVariable [REDEPLOYVARPOS,[0,0,0]])
#define REDEPLOYSETPOS(varPos)	(missionNamespace setVariable [REDEPLOYVARPOS,varPos])
#define REDEPLOYSELECTED		!(REDEPLOYGETPOS isEqualTo [0,0,0])

#define TASKHOVERVAR			"PO4_missionUI_taskHover"
#define GETTASKHOVER			(missionNamespace getVariable [TASKHOVERVAR,""])
#define SETTASKHOVER(id)		(missionNamespace setVariable [TASKHOVERVAR,id])
#define ISTASKHOVER(id)			(GETTASKHOVER isEqualTo id)
#define TASKSELECTVAR			"PO4_missionUI_taskSelect"
#define GETTASKSELECT			(missionNamespace getVariable [TASKSELECTVAR,""])
#define SETTASKSELECT(id)		(missionNamespace setVariable [TASKSELECTVAR,id])
#define ISTASKSELECTED(id)		(GETTASKSELECT isEqualTo id)
#define ISTASKSELECTHOVER		!(GETTASKHOVER isEqualTo "" && GETTASKSELECT isEqualTo "")

#include "\A3\Ui_f\hpp\defineResinclDesign.inc"
#define TOLERANCE_X			0.031
#define TOLERANCE_Y			0.041
#define BLOCK_W  			0.06
#define BLOCK_H  			0.08
#define MARKER_SIZE			30
#define MARKER_SIZE_HOVER		38.5
#define MARKER_SIZE_SELECTED		24
#define MARKER_SIZE_SELECTED_HOVER	32
#define PX_W	  			BLOCK_W/MARKER_SIZE_HOVER
#define PX_H  				BLOCK_H/MARKER_SIZE_HOVER
#define ICON_SCALE			0.77778
#define BACKGROUND_COLOR		[0,0,0,0.60]
#define BACKGROUND_COLOR_HOVER		[0,0,0,1]
#define ICON_COLOR			[1,1,1,1]
#define ICON_COLOR_DISABLED		[1,1,1,0.35]
#define ICON_COLOR_ASSIGNED		[1,0.7,0,1]
#define ICON_COLOR_ASSIGNED_DISABLED	[1,0.7,0,0.35]
#define ICON_COLOR_SELECTED		BACKGROUND_COLOR_HOVER
#define ICON_COLOR_SHARED		[0,0.89,1,1]
#define ICON_COLOR_WEST			[0,0.89,1,1]
#define ICON_COLOR_EAST			[1,0.21,0.21,1]
#define ICON_COLOR_GUER			[0.85,1,0.27,1]
#define ICON_COLOR_CIV			[0.85,0.27,1,1]

params [["_mode","",[""]],["_params",[],[[],false]]];

private _var = "PO4_Operation_List";

switch (_mode) do {
// UI
	case "onMapDraw" : {
		disableSerialization;
		_params params [["_ctrlMap",controlNull,[controlNull]]];
		private _ctrlOpGroup = uiNamespace getVariable ["RscMissionUI_IDC_ctrlOpGroup",controlNull];

		_ctrlMap drawRectangle [[worldSize/2,worldSize/2,0],worldSize/2,worldSize/2,0,[1,1,1,0.42],"\A3\Ui_f\data\GUI\Rsc\RscDisplayStrategicMap\cross_ca.paa"];

		if (REDEPLOYSELECTED) then {
			private _drawPos = REDEPLOYGETPOS call BIS_fnc_position;
			_ctrlMap drawEllipse [_drawPos,worldSize*0.1,worldSize*0.1,0,[0.7,0,0,0.6],"\a3\ui_f\data\Map\MarkerBrushes\fdiagonal_ca.paa"];
			_ctrlMap drawIcon [ICONSELECTORM,COLOURORANGE,_drawPos,40,40,(diag_frameNo%360)*2,"",1,0.03,'PuristaMedium','right'];

			_ctrlOpGroupPos = ctrlPosition _ctrlOpGroup;
			_ctrlOpGroupPos set [0,((_ctrlMap ctrlMapWorldToScreen _drawPos) select 0) + ((safeZoneW - 1 * (((safeZoneW / safeZoneH) min 1.2) / 40)) * 0.1)];
			_ctrlOpGroupPos set [1,((_ctrlMap ctrlMapWorldToScreen _drawPos) select 1) - (1.5 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25))];
			_ctrlOpGroup ctrlSetPosition _ctrlOpGroupPos;
			_ctrlOpGroup ctrlCommit 0;
		} else {
			_ctrlOpGroupPos = ctrlPosition _ctrlOpGroup;
			_ctrlOpGroupPos set [0,-1];
			_ctrlOpGroupPos set [1,-1];
			_ctrlOpGroup ctrlSetPosition _ctrlOpGroupPos;
			_ctrlOpGroup ctrlCommit 0;
		};

		private _operations = ["getOperations"] call PO4_fnc_operations;
		{
			_x params ["_opID","_taskID","_areaID","_requireIntel"];
			private _drawPos = ["getAreaPosition",[_areaID]] call MPSF_fnc_getCfgMapData;
			private _image = [0,1,2,3,4,5,6,5,4,3,2,1] select (((diag_frameNo + _forEachIndex)/5)%11);
			_ctrlMap drawicon [format[ICONBADGE,_image],COLOURWHITE,_drawPos,30,30,0,"",1];
		} forEach _operations;
	};
	case "onMapDraw2" : {
		disableSerialization;
		_params params [["_ctrlMap",controlNull,[controlNull]]];
		_ctrlMap drawRectangle [[worldSize/2,worldSize/2,0],worldSize/2,worldSize/2,0,[1,1,1,0.42],"\A3\Ui_f\data\GUI\Rsc\RscDisplayStrategicMap\cross_ca.paa"];
		(missionNamespace getVariable ["MAP_CURSOR_SCREEN",[0,0]]) params ["_mouseX","_mouseY"];

		_fnc_drawMarker = {
			_this params ["_opID","_taskID","_taskState","_areaID","_dest","_requireIntel"];

			private _type = ["TaskDetails",[_opID,"iconType"]] call MPSF_fnc_getCfgTasks;
			private _typeTex = [_type] call BIS_fnc_taskTypeIcon;
			if (_typeTex isEqualTo "") then { _typeTex = "\A3\ui_f\data\igui\cfg\simpleTasks\types\default_ca.paa"; };

			private _isSelected = ISTASKSELECTED(_opID);
			private _isMouseover = ISTASKHOVER(_opID);
			private _iconColor = ICON_COLOR;
			if !(_isMouseover) then {
				_markerSize = MARKER_SIZE;
			} else {
				_markerSize = MARKER_SIZE_HOVER;
			};

			if !(_isSelected) then {
				switch (true) do {
					case (_isMouseover) : {
						_ctrlMap drawIcon ["#(argb,8,8,3)color(1,1,1,1)", BACKGROUND_COLOR_HOVER, _dest, MARKER_SIZE_HOVER, MARKER_SIZE_HOVER, 0];
						_ctrlMap drawIcon [_typeTex, _iconColor, _dest, MARKER_SIZE_HOVER * ICON_SCALE, MARKER_SIZE_HOVER * ICON_SCALE, 0];
					};
					/*case (_task == _mouseOverTaskTooltip) : {
						_ctrlMap drawIcon ["#(argb,8,8,3)color(1,1,1,1)", BACKGROUND_COLOR_HOVER, _dest, MARKER_SIZE_HOVER, MARKER_SIZE_HOVER, 0];
						_ctrlMap drawIcon [_typeTex, _iconColor, _dest, MARKER_SIZE_HOVER * ICON_SCALE, MARKER_SIZE_HOVER * ICON_SCALE, 0];
					};*/
					default {
						_ctrlMap drawIcon ["#(argb,8,8,3)color(1,1,1,1)",BACKGROUND_COLOR, _dest, MARKER_SIZE, MARKER_SIZE, 0];
						_ctrlMap drawIcon [_typeTex, _iconColor, _dest, MARKER_SIZE * ICON_SCALE, MARKER_SIZE * ICON_SCALE, 0];
					};
				};
			} else { //task is selected
				if !(_isMouseover) then {
					_ctrlMap drawIcon ["#(argb,8,8,3)color(1,1,1,1)", ICON_COLOR_SELECTED, _dest, MARKER_SIZE, MARKER_SIZE, 0];
					_ctrlMap drawIcon ["#(argb,8,8,3)color(1,1,1,1)", _iconColor, _dest, MARKER_SIZE_SELECTED, MARKER_SIZE_SELECTED, 0];
					_ctrlMap drawIcon [_typeTex, ICON_COLOR_SELECTED, _dest, MARKER_SIZE * ICON_SCALE, MARKER_SIZE * ICON_SCALE, 0];
				} else { //mouseover state
					_ctrlMap drawIcon ["#(argb,8,8,3)color(1,1,1,1)", ICON_COLOR_SELECTED, _dest, MARKER_SIZE_HOVER, MARKER_SIZE_HOVER, 0];
					_ctrlMap drawIcon ["#(argb,8,8,3)color(1,1,1,1)", _iconColor, _dest, MARKER_SIZE_SELECTED_HOVER, MARKER_SIZE_SELECTED_HOVER, 0];
					_ctrlMap drawIcon [_typeTex, ICON_COLOR_SELECTED, _dest, MARKER_SIZE_HOVER * ICON_SCALE, MARKER_SIZE_HOVER * ICON_SCALE, 0];
				};
			};
		};
		_fnc_drawTooltip = {
			_this params ["_opID","_taskID","_taskState","_areaID","_dest","_requireIntel"];

			private _display = ctrlParent _ctrlMap;
			private _ctrlTooltip = uiNamespace getVariable ["RscMissionUI_IDC_ctrlOpGroup",controlNull];

			private _taskSelected = !(GETTASKSELECT isEqualTo "");
			private _taskHovered = !(GETTASKHOVER isEqualTo "");

			if !(ISTASKSELECTHOVER) exitWith {
				_ctrlTooltip ctrlSetPosition [-1,-1];
				_ctrlTooltip ctrlSetFade 1;
				_ctrlTooltip ctrlCommit 0;
			};

			if !(_taskSelected && ISTASKSELECTED(_opID)) exitWith {};

			_mapCoords = _ctrlMap ctrlMapWorldToScreen _dest;
			_tooltipCoords = [(_mapCoords select 0) + (PX_W * MARKER_SIZE_HOVER/2) - (PX_W * 2),(_mapCoords select 1) - (PX_H * MARKER_SIZE_HOVER/2)];
			_ctrlTooltip ctrlSetPosition _tooltipCoords;
			_ctrlTooltip ctrlSetFade 0;
			_ctrlTooltip ctrlCommit 0;
		};

		private _operations = ["getOperationList"] call PO4_fnc_operations;
		private _intelText = uiNamespace getVariable ["RscMissionUI_IDC_ctrlInteText3",controlNull];
		_intelText ctrlSetStructuredText parseText format ["INTEL:<t color='#FF2222'>%1/%2</t>"
			,["getIntelScore",[side group player]] call PO4_fnc_operations
			, missionNamespace getVariable ["PO4_Operation_intelLimit",1]
		];

		private _noIntelText = uiNamespace getVariable ["RscMissionUI_IDC_ctrlInteText4",controlNull];
		_noIntelText ctrlEnable false;
		if (count _operations == 0) exitWith {
			private _ctrlTooltip = uiNamespace getVariable ["RscMissionUI_IDC_ctrlOpGroup",controlNull];
			_ctrlTooltip ctrlSetPosition [-1,-1];
			_ctrlTooltip ctrlSetFade 1;
			_ctrlTooltip ctrlCommit 0;
			_noIntelText ctrlSetFade 0;
			_noIntelText ctrlCommit 0;
		};
		_noIntelText ctrlSetFade 1;
		_noIntelText ctrlCommit 0;

		private _taskX = -1;
		private _taskY = -1;
		private _taskDeltaX = 1;
		private _taskDeltaY = 1;
		SETTASKHOVER("");
		{
			_x params ["_opID","_taskID","_taskState","_areaID","_dest","_requireIntel"];
			_position = _ctrlMap ctrlMapWorldToScreen _dest;
			_xX = _position select 0;
			_xY = _position select 1;
			_xDeltaX = abs(_xX - _mouseX);
			_xDeltaY = abs(_xY - _mouseY);
			if (_xDeltaX < TOLERANCE_X && {_xDeltaY < TOLERANCE_Y} && {_xDeltaX + _xDeltaY < _taskDeltaX + _taskDeltaY}) then {
				SETTASKHOVER(_opID);
				_taskX = _xX;
				_taskY = _xY;
				_taskDeltaX = _xDeltaX;
				_taskDeltaY = _xDeltaY;
			};
		} forEach _operations;

		{
			_x params ["_opID","_taskID","_taskState","_areaID","_dest","_requireIntel"];
			if (_dest isEqualTo []) then { _dest = [_forEachIndex*10,_forEachIndex*10]; };
			[_opID,_taskID,_taskState,_areaID,_dest,_requireIntel] call _fnc_drawMarker;
			_x call _fnc_drawTooltip;
		} forEach _operations;

		if (REDEPLOYSELECTED) then {
			private _drawPos = REDEPLOYGETPOS call BIS_fnc_position;
			_ctrlMap drawEllipse [_drawPos,worldSize*0.1,worldSize*0.1,0,[0.7,0,0,0.6],"\a3\ui_f\data\Map\MarkerBrushes\fdiagonal_ca.paa"];
			_ctrlMap drawIcon [ICONSELECTORM,COLOURORANGE,_drawPos,40,40,(diag_frameNo%360)*2,"",1,0.03,'PuristaMedium','right'];
		};

		private _image = [0,1,2,3,4,5,6,5,4,3,2,1] select ((diag_frameNo/5)%11);
		_ctrlMap drawIcon [format[ICONBADGE,_image],COLOURWHITE,(missionNamespace getVariable ["MAP_CURSOR_WORLD",[0,0]]),30,30,0,str REDEPLOYGETPOS,1];
	};
	case "onMapSelect" : {
		_params params [["_ctrlMap",controlNull,[controlNull]],["_key",0,[0]],["_xCord",0,[0]],["_yCord",0,[0]],["_shift",false,[false]],["_ctrl",false,[false]],["_alt",false,[false]]];
		if !(_key isEqualTo 0) exitWith {};

		SETTASKSELECT(nil);

		private _ctrlMapPos = _ctrlMap ctrlMapScreenToWorld [_xCord,_yCord];
		private _nearestPoint = ["getNearestRespawnPoint",[_ctrlMapPos]] call PO4_fnc_operations;
		if (count _nearestPoint == 0) exitWith {};

		private _nearestDist = _ctrlMapPos distance2D (_nearestPoint select 4);
		switch (true) do {
			case (_nearestDist < 500) : {
				SETTASKSELECT(GETTASKHOVER);

				private _operation = (["getOperationList"] call PO4_fnc_operations) select {(_x select 0) isEqualTo GETTASKHOVER};
				if !(count _operation > 0) exitWith {};

				(_operation select 0) params ["_opID","_taskID","_taskState","_areaID","_dest","_requireIntel"];

				private _ctrlTitle = uiNamespace getVariable ["RscMissionUI_IDC_ctrlOpTitle",controlNull];
				_ctrlTitle ctrlSetText toUpper("SITREP " + _opID);

				private _brief = ["TaskDetails",[_opID,"brief"]] call MPSF_fnc_getCfgTasks;
				if (_brief isEqualTo "") then {
					private _textArguments = (["TaskDetails",[_opID,"textArguments"]] call MPSF_fnc_getCfgTasks) apply {
						switch (toLower _x) do {
							case "randomcode" : {"INPUT:REFID"};
							case "operationname" : {"OPNAME:PENDING"};
							default {_x};
						};
					};
					_brief = format ([["TaskDetails",[_opID,"description"]] call MPSF_fnc_getCfgTasks] + (_textArguments apply {[_x,[_dest,[]]] call MPSF_fnc_getTaskDescription}));
				};
				private _ctrlBrief = uiNamespace getVariable ["RscMissionUI_IDC_ctrlOpBrief",controlNull];
				_ctrlBrief ctrlSetStructuredText parseText _brief;
				_ctrlBrief ctrlSetFontHeight (0.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25));
				[_ctrlBrief] call BIS_fnc_ctrlFitToTextHeight;
				private _ctrlBriefPos = ctrlPosition _ctrlBrief;

				private _ctrlTooltip = uiNamespace getVariable ["RscMissionUI_IDC_ctrlOpGroup",controlNull];
				private _ctrlTooltipPos = ctrlPosition _ctrlTooltip;
				_ctrlTooltipPos set [3,(2.2 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)) max (_ctrlBriefPos select 3) min (10 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25))];
				_ctrlTooltip ctrlSetPosition _ctrlTooltipPos;
				_ctrlTooltip ctrlCommit 0;

				//["updateMapCenter",[_ctrlMap,_nearestPoint select 4]] call PO4_fnc_operations;
			};
		};
		["updateMenu"] call PO4_fnc_operations;
		true;
	};
	case "updateMapCenter" : {
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
	case "updateIntelText1" : {
		_params params [["_ctrl",controlNull,[controlNull]]];
		_text = toArray ctrlText _ctrl;
		_ctrlPos = ctrlPosition _ctrl;
		_ctrlPos set [2,(count _text) * (0.4 * (((safezoneW / safezoneH) min 1.2) / 40))];
		_ctrl ctrlSetPosition _ctrlPos;
		_ctrl ctrlSetFade 0;
		_ctrl ctrlCommit 0;
	};
	case "updateMenu" : {
		private _ctrlButton1 = uiNamespace getVariable ["RscMissionUI_IDC_ctrlButton1",controlNull];

		private _ctrlButton2 = uiNamespace getVariable ["RscMissionUI_IDC_ctrlButton2",controlNull];
		_ctrlButton2 ctrlSetEventHandler ["ButtonClick",""];
		switch (true) do {
			case !([player] call MPSF_fnc_isAdmin) : {
				_ctrlButton2 ctrlSetText "Mission Command Only";
				_ctrlButton2 ctrlEnable false;
			};
			case (ISTASKSELECTHOVER) : {
				private _operation = (["getOperationList"] call PO4_fnc_operations) select {(_x select 0) isEqualTo GETTASKHOVER};
				if (count _operation > 0) then {
					(_operation select 0) params ["_opID","_taskID","_taskState","_areaID","_dest","_requireIntel"];
					switch (true) do {
						case (count (allPlayers select {_x distance2D _dest < (worldSize*0.1)}) > 0) : {
							_ctrlButton2 ctrlSetText "Players too close...";
							_ctrlButton2 ctrlEnable false;
						};
						default {
							_ctrlButton2 ctrlSetText "Initiate Operation";
							_ctrlButton2 ctrlAddEventHandler ["ButtonClick",{ ["onMouseClick",[101]] call PO4_fnc_operations; }];
							_ctrlButton2 ctrlEnable true;
						};
					};
				};

			};
			default {
				_ctrlButton2 ctrlSetText "";
				_ctrlButton2 ctrlEnable false;
			};
		};
		_ctrlButton2 ctrlCommit 0;

		private _ctrlButton3 = uiNamespace getVariable ["RscMissionUI_IDC_ctrlButton3",controlNull];
	};
	case "onMouseClick" : {
		_params params [["_id",-1,[0]]];
		switch (_id) do {
			case 101 : {
				private _operation = (["getOperationList"] call PO4_fnc_operations) select {(_x select 0) isEqualTo GETTASKSELECT};
				if !(count _operation > 0) exitWith {};
				(_operation select 0) params ["_opID","_taskID","_taskState","_areaID","_dest","_requireIntel"];
				if !(_opID isEqualTo "") then {
					["onActivateOperation",[_opID,_areaID],2] call MPSF_fnc_triggerEventHandler;
				};
			};
			case 0 : { ['closeUI'] call PO4_fnc_operations; };
		};
	};
	case "onLoad" : {
		disableSerialization;
		private _display = _params select 0;
		uiNamespace setVariable ["RscMissionUI_dialog",(_display)];
		{
			uiNamespace setVariable [(_x select 0),_display displayCtrl (_x select 1)];
		} forEach [
			["RscMissionUI_IDC_ctrlBackground",1001]
			,["RscMissionUI_IDC_ctrlMap",1002]
			,["RscMissionUI_IDC_ctrlTitleLogo",1003]
			,["RscMissionUI_IDC_ctrlInteText1",1901]
			,["RscMissionUI_IDC_ctrlInteText2",1902]
			,["RscMissionUI_IDC_ctrlInteText3",1903]
			,["RscMissionUI_IDC_ctrlInteText4",1904]
			,["RscMissionUI_IDC_ctrlMenu",2000]
			,["RscMissionUI_IDC_ctrlButton1",2001]
			,["RscMissionUI_IDC_ctrlButton2",2002]
			,["RscMissionUI_IDC_ctrlButton3",2003]
			,["RscMissionUI_IDC_ctrlButton4",2004]
			,["RscMissionUI_IDC_ctrlButton5",2005]
			,["RscMissionUI_IDC_ctrlOpGroup",3000]
			,["RscMissionUI_IDC_ctrlOpTitle",3001]
			,["RscMissionUI_IDC_ctrlOpBrief",3002]
		];

		{
			_ctrl = uiNamespace getVariable [_x,controlNull];
			_ctrl ctrlSetFade 1;
			_ctrl ctrlCommit 0;
		} forEach [
			"RscMissionUI_IDC_ctrlTitleLogo"
			,"RscMissionUI_IDC_ctrlInteText1"
			,"RscMissionUI_IDC_ctrlInteText2"
			,"RscMissionUI_IDC_ctrlMenu"
			,"RscMissionUI_IDC_ctrlButton1"
			,"RscMissionUI_IDC_ctrlButton2"
			,"RscMissionUI_IDC_ctrlButton3"
			,"RscMissionUI_IDC_ctrlButton4"
			,"RscMissionUI_IDC_ctrlButton5"
		];

		[] spawn {
			disableSerialization;
			private _ctrlBackground = uiNamespace getVariable ["RscMissionUI_IDC_ctrlBackground",controlNull];
			private _ctrlMap = uiNamespace getVariable ["RscMissionUI_IDC_ctrlMap",controlNull];
			_ctrlBackground ctrlSetBackgroundColor [0,0,0,1];
			_ctrlBackground ctrlSetFade 0;
			_ctrlBackground ctrlCommit 0;
			_ctrlMap ctrlEnable false;
			_ctrlMap ctrlSetFade 1;
			_ctrlMap ctrlCommit 0;
			uiSleep 2;
			_ctrlMap ctrlSetFade 0;
			_ctrlMap ctrlCommit 0;
			_ctrlBackground ctrlSetFade 0.8;
			_ctrlBackground ctrlCommit 0.5;
			uiSleep 0.5;
			_ctrlMap ctrlEnable true;

			private _ctrlTitleLogo = uiNamespace getVariable ["RscMissionUI_IDC_ctrlTitleLogo",controlNull];
			_ctrlTitleLogo ctrlEnable false;
			_ctrlTitleLogo ctrlSetFade 0.9;
			_ctrlTitleLogo ctrlCommit 0.2;

			{
				_ctrl = uiNamespace getVariable [_x,controlNull];
				_ctrl ctrlSetFade 0;
				_ctrl ctrlCommit 0.2;
				uiSleep 0.1;
			} forEach [
				"RscMissionUI_IDC_ctrlInteText1"
				,"RscMissionUI_IDC_ctrlInteText2"
				,"RscMissionUI_IDC_ctrlMenu"
				,"RscMissionUI_IDC_ctrlButton1"
				,"RscMissionUI_IDC_ctrlButton2"
				,"RscMissionUI_IDC_ctrlButton3"
				,"RscMissionUI_IDC_ctrlButton4"
				,"RscMissionUI_IDC_ctrlButton5"
			];
		};

		private _ctrlIntelText = uiNamespace getVariable ["RscMissionUI_IDC_ctrlInteText1",controlNull];
		["updateIntelText1",[_ctrlIntelText]] call PO4_fnc_operations;

		private _ctrlBackground = uiNamespace getVariable ["RscMissionUI_IDC_ctrlBackground",controlNull];
		_ctrlBackground ctrlEnable false;

		private _ctrlMap = uiNamespace getVariable ["RscMissionUI_IDC_ctrlMap",controlNull];
		["updateMapCenter",[_ctrlMap]] call PO4_fnc_operations;
		_ctrlMap ctrlAddEventHandler ["Draw",{
			#include "\A3\ui_f\scripts\gui\RscDiaryTaskMarkers.sqf"
		}];
		_ctrlMap ctrlAddEventHandler ["draw",{["onMapDraw2",_this] call PO4_fnc_operations;}];
		_ctrlMap ctrlAddEventHandler ["mouseButtonDown",{["onMapSelect",_this] call PO4_fnc_operations;}];
		_ctrlMap ctrlAddEventHandler ["mouseButtonDblClick",{["onMapSelect",_this] call PO4_fnc_operations;}];
		_ctrlMap ctrlAddEventHandler ["setfocus",{_this spawn {disableserialization; (_this select 0) ctrlenable false; (_this select 0) ctrlenable true;};}];
		_ctrlMap ctrlAddEventHandler ["MouseMoving",{missionNamespace setVariable ["MAP_CURSOR_WORLD",(_this select 0) ctrlMapScreenToWorld [(_this select 1),(_this select 2)]];}];
		_ctrlMap ctrlAddEventHandler ["MouseMoving",{missionNamespace setVariable ["MAP_CURSOR_SCREEN",[(_this select 1),(_this select 2)]];}];

		private _ctrlButton3 = uiNamespace getVariable ["RscMissionUI_IDC_ctrlButton3",controlNull];
		_ctrlButton3 ctrlSetEventHandler ["ButtonClick","['onMouseClick',[0]] call PO4_fnc_operations;"];

		ctrlsetfocus (uiNamespace getVariable ["RscMissionUI_IDC_ctrlButton2",controlNull]);
		["updateMenu"] call PO4_fnc_operations;
	};
	case "openUI" : {
		disableSerialization;
		onMapSingleClick "";
		// Create Display
		private _display = (findDisplay 46) createDisplay "RscDisplayMissionUI";
		waitUntil {!isNull _display};
		uiNamespace setVariable ["PO4_Mission_DisplayID",_display];
		waitUntil {isNull _display};
		["#(argb,8,8,3)color(0,0,0,1)",false,nil,0,[0,0.5]] call BIS_fnc_textTiles;
	};
	case "closeUI" : {
		(uiNamespace getVariable ["PO4_Mission_DisplayID",displayNull]) closeDisplay 1;
	};
// Functions
	case "getOperationList" : {
		_params params [["_active",false,[false]]];

		private _operations = (["getOperations"] call PO4_fnc_operations) apply {
			_x params ["_opID","_taskID","_areaID","_requireIntel"];
			private _taskState = [_taskID] call BIS_fnc_taskState;
			private _position = ["getAreaPosition",[_areaID]] call MPSF_fnc_getCfgMapData;
			[_opID,_taskID,_taskState,_areaID,_position,_requireIntel]
		};

		_operations;
	};
	case "getNearestRespawnPoint" : {
		_params params [["_centrePos",[0,0,0],[[],objNull]]];

		if !(_centrePos isEqualType []) then { _centrePos = _centrePos call BIS_fnc_position; };

		private _operations = ["getOperationList"] call PO4_fnc_operations;
		if (count _operations == 0) exitWith {[]};

		private _return = _operations select 0;
		private _distance = (_return select 4) distance2D _centrePos;
		{
			private _checkDistance = (_x select 4) distance2D _centrePos;
			if (_checkDistance < _distance) then {
				_return = _x;
				_distance = _checkDistance;
			};
		} forEach _operations;

		_return;
	};
// Action
	case "addAction" : {
		_params params [["_target",objNull,[objNull]]];

		if (hasInterface) then {
			["PO4_Mission_OpenDisplay_Action",_target,"Access Mission Operations",[
					["mpsf\data\holdactions\holdAction_map.paa",{}]
					,["mpsf\data\holdactions\holdAction_map.paa",{}]
					,{["openUI"] call PO4_fnc_operations;}
					,{}
					,1,false,103
				],[],
					"vehicle player isEqualTo player && _target distance player < 3"
				,true,false,105
			] spawn {sleep 0.5; _this call MPSF_fnc_addAction};
		};
	};
// INTEL
	case "addIntelScore";
	case "removeIntelScore" : {
		_params params [["_side",side group player,[sideUnknown]],["_score",0,[0]]];
		//systemChat format ["Add Intel score +%1",_score];
		private _varname = "PO4_Operation_intelScore" + str _side;
		private _currentScore = (missionNamespace getVariable [_varname,0]) + _score;
		private _requireScore = missionNamespace getVariable ["PO4_Operation_intelLimit",1];

		if (_currentScore >= _requireScore && _score > 0) then {
			["createIntelOperation"] spawn PO4_fnc_operations;
			["onIntelCreateOp",[],_side] call MPSF_fnc_triggerEventHandler;
			_currentScore = 0;
		};
		missionNamespace setVariable [_varname,_currentScore];
		publicVariable _varname;
		true;
	};
	case "getIntelScore" : {
		_params params [["_side",side group player,[sideUnknown]]];
		private _varname = "PO4_Operation_intelScore" + str _side;
		missionNamespace getVariable [_varname,0];
	};
	case "createIntelOperation" : {
		private _operations = (["taskIDs"] call MPSF_fnc_getCfgTasks) select { (["CfgMissionTasks",_x,"typeID"] call MPSF_fnc_getCfgDataNumber) in [2,3,4,5,6,7,8,9] };
		private _operations = _operations apply { [_x,(["positionSearchTypes",[_x]] call MPSF_fnc_getCfgTasks) apply {toLower _x},[]]; };
		private _areas = (["areas"] call MPSF_fnc_getCfgMapData) apply {
			[
				_x
				,toLower(["getAreaType",[_x]] call MPSF_fnc_getCfgMapData)
				,(["getAreaPosition",[_x]] call MPSF_fnc_getCfgMapData)
				,(["getCurrentSector",[(["getAreaPosition",[_x]] call MPSF_fnc_getCfgMapData)]] call MPSF_fnc_getCfgMapData)
			];
		};
		_areas = _areas select {!((_x select 0) isEqualTo "")};
		_areas = _areas select {["isSectorHostile",[(_x select 3),[0,1]]] call PO4_fnc_zones};

		for "_iE" from 0 to (count _operations - 1) do {
			_operation = _operations select _iE;
			for "_iA" from 0 to (count _areas - 1) do {
				_area = _areas select _iA;
				if (count ((_operation select 1) arrayIntersect _area) > 0) then {
					(_operation select 2) pushBackUnique (_area select 0);
					_area = ["_USED_"];
				};
			};
		};

		/*{
			_x params [["_operationID",""],["_taskID",""],["_areaIDs",[]],["_requireIntel",false]];
			["addOperation",[_operationID,selectRandom _areaIDs,_requireIntel]] call PO4_fnc_operations;
		} forEach _operations;*/

		(selectRandom (_operations select {count (_x select 2) > 0})) params [["_operationID",""],["_taskID",""],["_areaIDs",[]],["_requireIntel",false]];
		["addOperation",[_operationID,selectRandom _areaIDs,_requireIntel]] call PO4_fnc_operations;
	};
// Operations
	case "addOperation" : {
		_params params [["_operationID","",[""]],["_areaID","",[""]],["_requireIntel",false,[false]]];

		private _array = ["getOperations"] call PO4_fnc_operations;
		_array pushBack [_operationID,"",_areaID,!_requireIntel,false];
		missionNamespace setVariable [_var,_array];
		publicVariable _var;

		true;
	};
	case "removeOperation" : {
		_params params [["_operationID","",[""]],["_areaID","",[""]],["_requireIntel",false,[false]]];
		private _array = ["getOperations"] call PO4_fnc_operations;
		{
			_x params ["_opID","_taskID","_opAreaID","_requireIntel"];
			if (_operationID isEqualTo _opID && _areaID isEqualTo _opAreaID) exitWith {
				_array deleteAt _forEachIndex;
				missionNamespace setVariable [_var,_array];
				publicVariable _var;
			};
		} forEach _array;
		true
	};
	case "activateOperation" : {
		_params params [["_operationID","",[""]],["_areaID","",[""]]];
		private _operations = ["getOperations"] call PO4_fnc_operations;
		private _index = (_operations apply {(_x select 0)}) find _operationID;
		if (_index >= 0) then {
			(_operations select _index) params ["_opID","_taskID","_areaID","_requireIntel"];
			//["removeOperation",[_opID,_areaID,_requireIntel]] call PO4_fnc_operations;
			private _taskID = [_operationID,_areaID] call MPSF_fnc_createCfgTask;
			_operations set [_index,[_opID,_taskID,_areaID,_requireIntel]];
			missionNamespace setVariable [_var,_operations];
			publicVariable _var;
		};
	};
	case "getOperations" : {
		_params params [["_active",false,[false]]];
		private _operations = missionNamespace getVariable [_var,[]];
		if !(_active) then { _operations = _operations select {(_x select 1) isEqualTo ""}; };
		_operations
	};
	case "onOperationComplete" : {
		private _opLimit = ["",0] call BIS_fnc_getParamValue;
		if (_opLimit == 0) exitWith {};

		private _currentScore = count(missionNamespace getVariable ["PO4_CompletedOps",[]]);
		if (_currentScore >= _opLimit) then {
			["onEndMission",[],0] call MPSF_fnc_triggerEventHandler;
		};
	};
// Config
// Init
	case "preInit";
	case "postInit";
	case "init" : {
		if (isServer) then {
			["PO4_Operation_onActivateOperation","onActivateOperation",{ ["activateOperation",_this] call PO4_fnc_operations; }] call MPSF_fnc_addEventHandler;
		};
		if (hasInterface) then {
			["PO4_Encounter_onBodyBagComplete_EH","onBodyBagComplete",{ [playerSide,"HQ"] commandChat "+1 for Laws of War"; }] call MPSF_fnc_addEventHandler;
			["PO4_Operation_onIntelCreateOp_EH","onIntelCreateOp",{ if ([player] call MPSF_fnc_isAdmin) then { ["MPSF_oncreateIntelOperation"] call BIS_fnc_showNotification; }; }] call MPSF_fnc_addEventHandler;
		};
	};
};

/*
private _tasks = ["getTasksByID",[2,3,4,5,6,7]] call MPSF_fnc_getCfgTasks;
if (count _tasks > 0 && {random 1 > 0.5}) then {
	[selectRandom _tasks] spawn {sleep 10; _this call MPSF_fnc_createCfgTask};
};
*/
//["createIntelOperation"] spawn {sleep 1; _this call PO4_fnc_operations};