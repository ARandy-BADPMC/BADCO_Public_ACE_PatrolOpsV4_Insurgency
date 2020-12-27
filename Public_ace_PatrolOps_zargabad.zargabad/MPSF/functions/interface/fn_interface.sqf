/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_interface.sqf
	Author(s): see mpsf\credits.txt

	Description:
		INTERFACE Functions
*/
params [["_mode","",[""]],["_params",[],[[],false]]];

#define CTRLINTERFACEGROUPS ["RscInterface_IDC_InterfaceMissionMenu","","RscInterface_IDC_InterfaceVisualSettings",""]

#define ICONTASKASSIGNED	"\a3\3den\Data\Attributes\TaskStates\assigned_ca.paa"
#define ICONTASKCANCELED	"\a3\3den\Data\Attributes\TaskStates\canceled_ca.paa"
#define ICONTASKCREATED		"\a3\3den\Data\Attributes\TaskStates\created_ca.paa"
#define ICONTASKFAILED		"\a3\3den\Data\Attributes\TaskStates\failed_ca.paa"
#define ICONTASKSUCCEEDED	"\a3\3den\Data\Attributes\TaskStates\succeeded_ca.paa"

switch (_mode) do {
// Visual Settings
	case "setDisplay" : {
		_params params [["_ctrl",-1,[controlNull,0]]];
		private _idc = if !(_ctrl isEqualType controlNull) then { _ctrl } else { ctrlIDC _ctrl };

		{
			private _ctrl = uiNamespace getVariable [_x,controlNull];
			_ctrl ctrlEnable false;
			_ctrl ctrlSetFade 1;
			_ctrl ctrlCommit 0.3;
		} forEach CTRLINTERFACEGROUPS;

		switch (_idc) do {
			case 2001 : {
				[] spawn {
					["closeDisplay"] call MPSF_fnc_interface;
					sleep 0.1;
					["createDisplay"] call MPSF_fnc_squadMod;
				};
			};
			case 2002 : {
				["onLoadMissionMenu"] call MPSF_fnc_interface;
				private _ctrl = uiNamespace getVariable ["RscInterface_IDC_InterfaceMissionMenu",controlNull];
				_ctrl ctrlEnable true;
				_ctrl ctrlSetFade 0;
				_ctrl ctrlCommit 0.3;
			};
			case 2004 : {
				["onLoadVisualSettings"] call MPSF_fnc_interface;
				private _ctrl = uiNamespace getVariable ["RscInterface_IDC_InterfaceVisualSettings",controlNull];
				_ctrl ctrlEnable true;
				_ctrl ctrlSetFade 0;
				_ctrl ctrlCommit 0.3;
			};
			case 2005 : {
				["closeDisplay"] call MPSF_fnc_interface;
			};
		};
		if (_idc == 2004) then {
			(missionNamespace getVariable ["MPSF_Screen_Effect",-1]) ppEffectAdjust [0];
			(missionNamespace getVariable ["MPSF_Screen_Effect",-1]) ppEffectCommit 0.2;
		} else {
			(missionNamespace getVariable ["MPSF_Screen_Effect",-1]) ppEffectAdjust [8];
			(missionNamespace getVariable ["MPSF_Screen_Effect",-1]) ppEffectCommit 0.2;
		};
	};
	case "onLoadMissionMenu" : {
		private _ctrlMissionButton1 = uiNamespace getVariable ["RscInterface_IDC_MissionButton1",controlNull];
		_ctrlMissionButton1 ctrlAddEventHandler ["buttonclick","['onVisualSettingsChange',_this] call MPSF_fnc_interface;"];

		private _ctrlMissionButton2 = uiNamespace getVariable ["RscInterface_IDC_MissionButton2",controlNull];
		_ctrlMissionButton2 ctrlAddEventHandler ["buttonclick","['onVisualSettingsChange',_this] call MPSF_fnc_interface;"];

		private _ctrlMissionTreeList = uiNamespace getVariable ["RscInterface_IDC_MissionTreeList",controlNull];
		_ctrlMissionTreeList ctrlSetEventHandler ["",""];
		tvClear _ctrlMissionTreeList;

		private _parentTasks = ([player] call BIS_fnc_tasksUnit) select {([_x] call BIS_fnc_taskParent) isEqualTo ""};
		for "_i" from 0 to (count _parentTasks - 1) do {
			private _parentID = _parentTasks select _i;
			private _parentState = [_parentID] call BIS_fnc_taskState;
			private _assignedPlayers = [_parentID] call MPSF_fnc_getAssignedTaskPlayers;

			([_parentID] call BIS_fnc_taskDescription) params [["_parentDesc",[""],[[]]],["_parentTitle",[""],[[]]]];
			_parentTitle = _parentTitle param [0,"",[""]];
			_parentDesc = _parentDesc param [0,"",[""]];
			if (_parentTitle isEqualTo "") then { _parentTitle = _parentID; };
			_parentTitle = format ["%1%2",_parentTitle,
				if (count _assignedPlayers > 0) then { format [" (%1 Assigned)",count _assignedPlayers] } else {""}
			];

			private _parent = _ctrlMissionTreeList tvAdd [[],_parentTitle];
			_ctrlMissionTreeList tvSetData [[_parent],_parentID];
			switch (toLower _parentState) do {
				case "created" : {_ctrlMissionTreeList tvSetPictureRight [[_parent],ICONTASKCREATED]; };
				case "assigned" : {_ctrlMissionTreeList tvSetPictureRight [[_parent],ICONTASKASSIGNED]; };
				case "succeeded" : {_ctrlMissionTreeList tvSetPictureRight [[_parent],ICONTASKSUCCEEDED]; };
				case "failed" : {_ctrlMissionTreeList tvSetPictureRight [[_parent],ICONTASKFAILED]; };
				case "canceled" : { _ctrlMissionTreeList tvSetPictureRight [[_parent],ICONTASKCANCELED]; };
			};

			private _childTasks = [_parentID] call BIS_fnc_taskChildren;
			if (count _childTasks > 0) then {
				for "_cID" from 0 to (count _childTasks - 1) do {
					private _childID = _childTasks select _i;
					private _childState = [_childID] call BIS_fnc_taskState;
					private _assignedPlayers = [_childID] call MPSF_fnc_getAssignedTaskPlayers;

					([_childID] call BIS_fnc_taskDescription) params [["_childDesc",[""],[[]]],["_childTitle",[""],[[]]]];
					_childTitle = _childTitle param [0,"",[""]];
					_childDesc = _childDesc param [0,"",[""]];
					if (_childTitle isEqualTo "") then { _childTitle = _childID; };
					_childTitle = format ["%1%2",_childTitle,
						if (count _assignedPlayers > 0) then { format [" (%1 Assigned)",count _assignedPlayers] } else {""}
					];

					private _child = _ctrlMissionTreeList tvAdd [[_parent],_childTitle];
					_ctrlMissionTreeList tvSetData [[_parent,_child],_childID];
					switch (toLower _childState) do {
						case "created" : {_ctrlMissionTreeList tvSetPictureRight [[_parent,_child],ICONTASKCREATED]; };
						case "assigned" : {_ctrlMissionTreeList tvSetPictureRight [[_parent,_child],ICONTASKASSIGNED]; };
						case "succeeded" : {_ctrlMissionTreeList tvSetPictureRight [[_parent,_child],ICONTASKSUCCEEDED]; };
						case "failed" : {_ctrlMissionTreeList tvSetPictureRight [[_parent,_child],ICONTASKFAILED]; };
						case "canceled" : { _ctrlMissionTreeList tvSetPictureRight [[_parent,_child],ICONTASKCANCELED]; };
					};
				};
			};
		};
		tvExpandAll _ctrlMissionTreeList;
		_ctrlMissionTreeList tvSetCurSel [0];
		_ctrlMissionTreeList ctrlAddEventHandler ["treeSelChanged",{ ["onMissionMenuChange",_this] call MPSF_fnc_interface; }];

		private _ctrlMissionText1 = uiNamespace getVariable ["RscInterface_IDC_MissionText1",controlNull];
		_ctrlMissionText1 ctrlSetStructuredText parseText "<t size='2'>Description</t>";
	};
	case "onMissionMenuChange" : {
		//systemChat str _this;
		_params params [["_ctrl",controlNull,[controlNull,0]]];
		private _idc = if !(_ctrl isEqualType controlNull) then { _ctrl } else { ctrlIDC _ctrl };
		switch (_idc) do {
			case 4003 : {
				private _path = _params param [1,[0],[[]]];
				private _taskID = _ctrl tvData _path;

				([_taskID] call BIS_fnc_taskDescription) params [["_taskDesc",[""],[[]]],["_taskTitle",[""],[[]]]];
				_taskTitle = _taskTitle param [0,"",[""]];
				_taskDesc = _taskDesc param [0,"",[""]];
				copyToClipboard str parseText _taskDesc;
				private _ctrlMissionText1 = uiNamespace getVariable ["RscInterface_IDC_MissionText1",controlNull];
				_ctrlMissionText1 ctrlSetStructuredText parseText _taskDesc;
			};
		};
	};
	case "onLoadVisualSettings" : {
		(["getCfgViewDistance"] call MPSF_fnc_visualSettings) params [["_sliderMin",500,[0]],["_sliderMax",10000,[0]]];

		private _ctrlVisualSettingsButton1 = uiNamespace getVariable ["RscInterface_IDC_VisualSettingsButton1",controlNull];
		_ctrlVisualSettingsButton1 ctrlAddEventHandler ["buttonclick","['onVisualSettingsChange',_this] call MPSF_fnc_interface;"];

		private _ctrlVisualSettingsButton2 = uiNamespace getVariable ["RscInterface_IDC_VisualSettingsButton2",controlNull];
		_ctrlVisualSettingsButton2 ctrlAddEventHandler ["buttonclick","['onVisualSettingsChange',_this] call MPSF_fnc_interface;"];

		private _ctrlVisualSettingsButton3 = uiNamespace getVariable ["RscInterface_IDC_VisualSettingsButton3",controlNull];
		_ctrlVisualSettingsButton3 ctrlAddEventHandler ["buttonclick","['onVisualSettingsChange',_this] call MPSF_fnc_interface;"];

		private _ctrlViewDistanceText = uiNamespace getVariable ["RscInterface_IDC_ViewDistanceText",controlNull];
		private _ctrlViewDistanceSlider = uiNamespace getVariable ["RscInterface_IDC_ViewDistanceSlider",controlNull];
		_ctrlViewDistanceSlider ctrlAddEventHandler ["SliderPosChanged","['onVisualSettingsChange',_this] call MPSF_fnc_interface;"];
		_ctrlViewDistanceSlider sliderSetRange [_sliderMin,_sliderMax];
		_ctrlViewDistanceSlider sliderSetPosition viewDistance;

		private _ctrlViewDistanceEdit = uiNamespace getVariable ["RscInterface_IDC_ViewDistanceEdit",controlNull];
		_ctrlViewDistanceEdit ctrlAddEventHandler ["KillFocus","['onVisualSettingsChange',_this + [call compile (ctrlText (_this select 0))]] call MPSF_fnc_interface;"];
		_ctrlViewDistanceEdit ctrlSetText str (viewDistance);

		private _ctrlDrawDistanceText = uiNamespace getVariable ["RscInterface_IDC_DrawDistanceText",controlNull];
		private _ctrlDrawDistanceSlider = uiNamespace getVariable ["RscInterface_IDC_DrawDistanceSlider",controlNull];
		_ctrlDrawDistanceSlider ctrlAddEventHandler ["SliderPosChanged","['onVisualSettingsChange',_this] call MPSF_fnc_interface;"];
		_ctrlDrawDistanceSlider sliderSetRange [_sliderMin,_sliderMax];
		_ctrlDrawDistanceSlider sliderSetPosition (getObjectViewDistance select 0);

		private _ctrlDrawDistanceEdit = uiNamespace getVariable ["RscInterface_IDC_DrawDistanceEdit",controlNull];
		_ctrlDrawDistanceEdit ctrlAddEventHandler ["KillFocus","['onVisualSettingsChange',_this + [call compile (ctrlText (_this select 0))]] call MPSF_fnc_interface;"];
		_ctrlDrawDistanceEdit ctrlSetText str (getObjectViewDistance select 0);

		private _ctrlTerrainText = uiNamespace getVariable ["RscInterface_IDC_TerrainText",controlNull];
		private _ctrlTerrainListbox = uiNamespace getVariable ["RscInterface_IDC_TerrainListbox",controlNull];
		lnbClear _ctrlTerrainListbox;
		{
			_ctrlTerrainListbox lbAdd (_x select 0);
			_ctrlTerrainListbox lbSetValue [_foreachindex,(_x select 1)];
		} forEach [["None",0],["Low",1],["Medium",2],["High",3],["Ultra",4]];
		_ctrlTerrainListbox lbSetCurSel (["getTerrainGrid",[missionNamespace getVariable ["MPSF_VisualSettings_vehicle","Default"]]] call MPSF_fnc_visualSettings);
		_ctrlTerrainListbox ctrlAddEventHandler ["LBSelChanged","['onVisualSettingsChange',_this] call MPSF_fnc_interface;"];
	};
	case "onVisualSettingsChange" : {
		_params params [["_ctrl",controlNull,[controlNull,0]]];
		private _idc = if !(_ctrl isEqualType controlNull) then { _ctrl } else { ctrlIDC _ctrl };
		switch (_idc) do {
			case 3002 : {
				missionNamespace setVariable ["MPSF_VisualSettings_vehicle","Land"];
				["onVisualSettingsChange",[3101]] call MPSF_fnc_interface;
				["onVisualSettingsChange",[3201]] call MPSF_fnc_interface;
			};
			case 3003 : {
				missionNamespace setVariable ["MPSF_VisualSettings_vehicle","Sea"];
				["onVisualSettingsChange",[3101]] call MPSF_fnc_interface;
				["onVisualSettingsChange",[3201]] call MPSF_fnc_interface;
			};
			case 3004 : {
				missionNamespace setVariable ["MPSF_VisualSettings_vehicle","Air"];
				["onVisualSettingsChange",[3101]] call MPSF_fnc_interface;
				["onVisualSettingsChange",[3201]] call MPSF_fnc_interface;
			};
			case 3101;
			case 3102 : {
				_value = _params param [1,-1,[0]];
				private _return = ["setViewDistance",[_value,(missionNamespace getVariable ["MPSF_VisualSettings_vehicle","Default"])]] call MPSF_fnc_visualSettings;
				private _ctrlViewDistanceSlider = uiNamespace getVariable ["RscInterface_IDC_ViewDistanceSlider",controlNull];
				_ctrlViewDistanceSlider sliderSetPosition viewDistance;
				private _ctrlViewDistanceEdit = uiNamespace getVariable ["RscInterface_IDC_ViewDistanceEdit",controlNull];
				_ctrlViewDistanceEdit ctrlSetText str (viewDistance);
				private _ctrlDrawDistanceSlider = uiNamespace getVariable ["RscInterface_IDC_DrawDistanceSlider",controlNull];
				_ctrlDrawDistanceSlider sliderSetPosition (getObjectViewDistance select 0);
				private _ctrlDrawDistanceEdit = uiNamespace getVariable ["RscInterface_IDC_DrawDistanceEdit",controlNull];
				_ctrlDrawDistanceEdit ctrlSetText str (getObjectViewDistance select 0);
			};
			case 3201;
			case 3202 : {
				_value = _params param [1,-1,[0]];
				private _return = ["setObjectViewDistance",[_value,(missionNamespace getVariable ["MPSF_VisualSettings_vehicle","Default"])]] call MPSF_fnc_visualSettings;
				private _ctrlDrawDistanceSlider = uiNamespace getVariable ["RscInterface_IDC_DrawDistanceSlider",controlNull];
				_ctrlDrawDistanceSlider sliderSetPosition (getObjectViewDistance select 0);
				private _ctrlDrawDistanceEdit = uiNamespace getVariable ["RscInterface_IDC_DrawDistanceEdit",controlNull];
				_ctrlDrawDistanceEdit ctrlSetText str (getObjectViewDistance select 0);
			};
			case 3300 : {};
			case 3301 : {
				_value = _params param [1,-1,[0]];
				private _return = ["setTerrainGrid",[_value,(missionNamespace getVariable ["MPSF_VisualSettings_vehicle","Default"])]] call MPSF_fnc_visualSettings;
			};
		};
	};
// Core Menu
	case "onLoad" : {
		disableSerialization;
		private _display = _params select 0;
		uiNamespace setVariable ["RscInterface_display",_display];
		{
			uiNamespace setVariable [(_x select 0),_display displayCtrl (_x select 1)];
		} forEach [
			["RscInterface_IDC_InterfaceBackground",1000]
			,["RscInterface_IDC_InterfaceLogo",1001]

			,["RscInterface_IDC_InterfaceButton1",2001]
			,["RscInterface_IDC_InterfaceButton2",2002]
			,["RscInterface_IDC_InterfaceButton3",2003]
			,["RscInterface_IDC_InterfaceButton4",2004]
			,["RscInterface_IDC_InterfaceButton5",2005]

			,["RscInterface_IDC_InterfaceVisualSettings",3000]
			,["RscInterface_IDC_VisualSettingsButton1",3002]
			,["RscInterface_IDC_VisualSettingsButton2",3003]
			,["RscInterface_IDC_VisualSettingsButton3",3004]
			,["RscInterface_IDC_ViewDistanceText",3100]
			,["RscInterface_IDC_ViewDistanceSlider",3101]
			,["RscInterface_IDC_ViewDistanceEdit",3102]
			,["RscInterface_IDC_DrawDistanceText",3200]
			,["RscInterface_IDC_DrawDistanceSlider",3201]
			,["RscInterface_IDC_DrawDistanceEdit",3202]
			,["RscInterface_IDC_TerrainText",3300]
			,["RscInterface_IDC_TerrainListbox",3301]

			,["RscInterface_IDC_InterfaceMissionMenu",4000]
			,["RscInterface_IDC_MissionButton1",4001]
			,["RscInterface_IDC_MissionButton2",4002]
			,["RscInterface_IDC_MissionTreeList",4003]
			,["RscInterface_IDC_MissionText1",4004]
		];

		{
			private _ctrl = uiNamespace getVariable [_x,controlNull];
			_ctrl ctrlEnable false;
			_ctrl ctrlSetFade 1;
			_ctrl ctrlCommit 0;
		} forEach CTRLINTERFACEGROUPS;

		private _ctrlBackground = uiNamespace getVariable ["RscInterface_IDC_InterfaceBackground",controlNull];
		_ctrlBackground ctrlEnable false;

		private _ctrlTitleLogo = uiNamespace getVariable ["RscInterface_IDC_InterfaceLogo",controlNull];
		_ctrlTitleLogo ctrlEnable false;
		_ctrlTitleLogo ctrlSetFade 0.8;
		_ctrlTitleLogo ctrlCommit 0;

		["setDisplay"] call MPSF_fnc_interface;

		(uiNamespace getVariable ["RscInterface_IDC_InterfaceButton1",controlNull]) ctrlAddEventHandler ["buttonclick","['setDisplay',_this] call MPSF_fnc_interface;"];
		(uiNamespace getVariable ["RscInterface_IDC_InterfaceButton2",controlNull]) ctrlAddEventHandler ["buttonclick","['setDisplay',_this] call MPSF_fnc_interface;"];
		(uiNamespace getVariable ["RscInterface_IDC_InterfaceButton3",controlNull]) ctrlAddEventHandler ["buttonclick","['setDisplay',_this] call MPSF_fnc_interface;"];
		(uiNamespace getVariable ["RscInterface_IDC_InterfaceButton4",controlNull]) ctrlAddEventHandler ["buttonclick","['setDisplay',_this] call MPSF_fnc_interface;"];
		(uiNamespace getVariable ["RscInterface_IDC_InterfaceButton5",controlNull]) ctrlAddEventHandler ["buttonclick","['setDisplay',_this] call MPSF_fnc_interface;"];
	};
// Init Display
	case "createDisplay" : {
		disableSerialization;
		if !(isNull (findDisplay 860130)) exitWith { ["closeDisplay"] call MPSF_fnc_interface; };
		["#(argb,8,8,3)color(0,0,0,1)",false,nil,0,[0,0.5]] call BIS_fnc_textTiles;

		// PPEffect Create
		private _handle = nil;
		if (isNil {missionNamespace getVariable "MPSF_Screen_Effect"}) then {
			_handle = ppEffectCreate ["DynamicBlur", 961];
			_handle ppEffectEnable true;
			_handle ppEffectAdjust [8];
			_handle ppEffectCommit 0.1;
			missionNamespace setVariable ["MPSF_Screen_Effect",_handle];
		};

		// Create Display
		private _display = ([] call BIS_fnc_displayMission) createDisplay "RscDisplayTaskUI"; // "RscDisplayInterfaceMenu"; //
		waitUntil {!isNull _display};

		["displayAddEventHandler",[_display]] call MPSF_fnc_interface;

		// Wait Until Closed
		waitUntil {isNull _display};

		// PPEffect Destroy
		if !(isNil "_handle") then {
			_handle ppEffectEnable false;
			ppEffectDestroy _handle;
			missionNamespace setVariable ["MPSF_Screen_Effect",nil];
		};
		["#(argb,8,8,3)color(0,0,0,1)",false,nil,0,[0,0.5]] call BIS_fnc_textTiles;
	};
	case "closeDisplay" : {
		disableSerialization;
		private _display = uiNamespace getVariable ["RscInterface_display",displayNull];
		_display closeDisplay 1;
	};
	case "isDisplayOpen" : {
		disableSerialization;
		!(isNull (findDisplay 860130));
	};
	case "onKeyDown" : {
		disableSerialization;
		if !(hasInterface) exitWith {};
		_params params [["_display",displayNull],["_key",-1,[0]],["_shift",false,[false]],["_ctrl",false,[false]],["_alt",false,[false]]];
		switch (true) do {
			case (_key in actionKeys (getMissionConfigValue ["mpsf_ui_key","TeamSwitch"]) && !_ctrl) : {
				if !(missionNamespace getVariable ["MPSF_onKeyDown_HeldTeamSwitch",false]) then {
					missionNamespace setVariable ["MPSF_onKeyDown_HeldTeamSwitch",true];
				};
				true;
			};
			default { false };
		};
		true;
	};
	case "onKeyUp" : {
		disableSerialization;
		if !(hasInterface) exitWith {};
		_params params [["_display",displayNull],["_key",-1,[0]],["_shift",false,[false]],["_ctrl",false,[false]],["_alt",false,[false]]];
		switch (true) do {
			case (_key in actionKeys (getMissionConfigValue ["mpsf_ui_key","TeamSwitch"]) && !_ctrl) : {
				missionNamespace setVariable ["MPSF_onKeyDown_HeldTeamSwitch",nil];
				if !(["isDisplayOpen"] call MPSF_fnc_squadmod) then {
					["createDisplay"] spawn MPSF_fnc_squadmod;
				} else {
					["closeDisplay"] call MPSF_fnc_squadmod;//MPSF_fnc_interface;
				};
				true;
			};
			default { false };
		};
	};
	case "displayAddEventHandler" : {
		disableSerialization;
		if !(hasInterface) exitWith {};
		_params params [["_display",displayNull,[displayNull]]];
		private _down   = _display displayAddEventHandler ["KeyDown","['onKeyDown',_this] call MPSF_fnc_interface;"];
		private _up     = _display displayAddEventHandler ["KeyUp","['onKeyUp',_this] call MPSF_fnc_interface;"];
	};
	case "postInit" : {
		["eventHandlers"] call MPSF_fnc_visualSettings;
		[true] call MPSF_fnc_mapDrawSquadMarkers;

		["MPSF_Interface_onKeyDown_EH","KeyDown",{ ["onKeyDown",_this] call MPSF_fnc_interface; }] call MPSF_fnc_addEventHandler;
		["MPSF_Interface_onKeyDown_EH","KeyUp",{ ["onKeyUp",_this] call MPSF_fnc_interface; }] call MPSF_fnc_addEventHandler;
	};
};