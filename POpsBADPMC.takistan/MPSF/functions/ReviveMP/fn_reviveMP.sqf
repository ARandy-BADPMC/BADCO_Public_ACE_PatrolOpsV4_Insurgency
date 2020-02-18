#define MISSIONTIME								(if (isMultiplayer) then {serverTime} else {time})
#define MARKER_SIZE 							0.65
// Colours
#define COLOURWHITE								[1,1,1,1]
#define COLOURINJURED							[1,0.3,0.3,0.7]
#define COLOURREVIVING							[0,0.6,0.6,0.8]
// Icons
#define ICONEMPTY								"#(argb,8,8,3)color(0,0,0,0)"
#define ICONBACKG								"\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\icon_ca.paa"
#define ICONBACKG2								"\A3\ui_f\data\IGUI\Cfg\HoldActions\progress\progress_24_ca.paa"
#define ICONBACKG3								"\A3\ui_f\data\IGUI\Cfg\HoldActions\progress2\progress_24_ca.paa"
#define ICONPOINTER								"\A3\ui_f\data\IGUI\Cfg\simpleTasks\interaction_pointer2_ca.paa"
#define ICONTAKE								"\A3\ui_f\data\IGUI\Cfg\Actions\take_ca.paa"
#define ICONSELECTORF							"\A3\ui_f\data\map\groupicons\selector_selectedFriendly_ca.paa"
#define ICONACTIONHOLDREVIVE					"\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa"
#define ICONACTIONHOLDREVIVEMEDIC				"\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_reviveMedic_ca.paa"
// Injury System
#define INJUREDVARREVIVER						"MPSF_Injury_var_healer"
#define INJUREDVARREVIVEPART					"MPSF_Injury_var_healer%1"
#define INJUREDVARCARRYLINK						"MPSF_Injury_var_carryGroup"
#define INJUREDVARDRAGLINK						"MPSF_Injury_var_dragGroup"
#define ANIMS_CARRIED							["AinjPfalMstpSnonWrflDf_carried","AinjPfalMstpSnonWrflDf_carried_dead","AinjPfalMstpSnonWrflDnon_carried_Up","AinjPfalMstpSnonWrflDnon_carried_still","ainjpfalmstpsnonwnondnon_carried_still"]
#define ANIMS_DRAGGED							["AinjPpneMrunSnonWnonDb_still"]
#define INJURYPARTS								([["head","head"],["spine2","body"],["leftforearm","hands"],["rightforearm","hands"],["leftleg","legs"],["rightleg","legs"],["spine3"],["LeftShoulder"],["RightShoulder"]]) /*,["lefthand"],["righthand"],["leftfoot"],["rightfoot"]*/
#define ISINJUREDDISPLAY						(uiNamespace getVariable ["MPSF_RscTitleMPSFInjuryHeal",false])

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
// UI
	case "onEachFrameUI" : {
		private _timeOfInjury = player getVariable ["MPSF_Injury_var_timeOfInjury",0];
		private _timetoLive = player getVariable ["MPSF_Injury_var_timeToLive",0];
		private _timeSkip = player getVariable ["MPSF_Injury_var_timeSkip",0];
		private _timeLeft = _timetoLive - MISSIONTIME - _timeSkip;
		private _progress = _timeLeft/(_timetoLive - _timeOfInjury);
		private _colour = if ((["isInjured",[player]] call MPSF_fnc_reviveMP) && (["isBeingRevived",[player]] call MPSF_fnc_reviveMP)) then { [0.2,0.8,0.8,0.8]; } else { [0.2,0,0,0.8] };
		private _displayTime = if (_progress <= 0) then { "--:--:--.--" } else { [_timeLeft/60/60,"HH:MM:SS:MM"] call BIS_fnc_timeToString; };

		(uiNamespace getVariable ["RscTitleInjury_IDC_Progress",controlNull]) progressSetPosition _progress;
		(uiNamespace getVariable ["RscTitleInjury_IDC_Progress",controlNull]) ctrlSetTextColor _colour;
		(uiNamespace getVariable ["RscTitleInjury_IDC_Countdown",controlNull]) ctrlSetText _displayTime;
		if (["isBeingRevived",[player]] call MPSF_fnc_reviveMP) then {
			(uiNamespace getVariable ["RscTitleInjury_IDC_Player",controlNull]) ctrlSetText format["Being Revived by %1",name (["getReviver",[player]] call MPSF_fnc_reviveMP)];
		};
		if (uiNamespace getVariable ["MPSF_Injury_var_skip",false]) then {
			(uiNamespace getVariable ["RscTitleInjury_IDC_Skip",controlNull]) ctrlSetText "Bleeding Out...";
		} else {
			(uiNamespace getVariable ["RscTitleInjury_IDC_Skip",controlNull]) ctrlSetText (uiNamespace getVariable ["RscTitleInjury_IDC_SkipText",""]);
		};
		if (player getVariable ["agonyAssist",0] >= time) then {
			(uiNamespace getVariable ["RscTitleInjury_IDC_HelpText",controlNull]) ctrlSetTextColor [0.5,0.5,0.5,0.5];
		} else {
			(uiNamespace getVariable ["RscTitleInjury_IDC_HelpText",controlNull]) ctrlSetTextColor [1,1,1,0.8];
		};

		{
			private _ctrl = uiNamespace getVariable [_x,controlNull];
			if (ctrlCommitted _ctrl) then {
				_ctrl ctrlsetfade (random 0.6);
				_ctrl ctrlCommit (0.4 + random 3);
			};
		} forEach [
			"RscTitleInjury_IDC_HealthLower"
			,"RscTitleInjury_IDC_HealthMiddle"
			,"RscTitleInjury_IDC_HealthUpper"
		];

		// PPEffect Create
		private _handle = missionNamespace getVariable "MPSF_ReviveMP_InjuredEffect";
		if (isNil "_handle") then {
			_handle = ppEffectCreate ["DynamicBlur", 962];
			_handle ppEffectEnable true;
			_handle ppEffectAdjust [2];
			_handle ppEffectCommit 0.1;
			missionNamespace setVariable ["MPSF_ReviveMP_InjuredEffect",_handle];
		};

		if (_progress <= 0 || !(alive player)) then {
			if !(isNil "_handle") then {
				_handle ppEffectEnable false;
				ppEffectDestroy _handle;
				missionNamespace setVariable ["MPSF_ReviveMP_InjuredEffect",nil];
			};
			if (_progress <= 0) then {
				if !(isMultiplayer) then {
					["onKilled",[player]] call MPSF_fnc_reviveMP;
					//["onKilledPlayer",[player]] call (missionNamespace getVariable ["MPSF_fnc_respawnMP",{false}]);
				} else {
					forceRespawn player;
				};
			};
			["onUnloadUI"] call MPSF_fnc_reviveMP;
		};
	};
	case "onLoadUI" : {
		private _dialog = _params select 0;
		uiNamespace setVariable ["RscTitleInjury_dialog",(_dialog)];

		uiNamespace setVariable ["MPSF_Injury_var_showHud",shownHUD]; showHUD false;
		uiNamespace setVariable ["MPSF_Injury_var_showChat",shownChat]; showChat false;
		uiNamespace setVariable ["MPSF_Injury_var_cameraView",cameraView];
		{ inGameUISetEventHandler [_x,"true"]; } forEach ["PrevAction", "Action", "NextAction"];

		{
			uiNamespace setVariable [(_x select 0),_dialog displayCtrl (_x select 1)];
		} forEach [
			["RscTitleInjury_IDC_Ctrl",1000]
			,["RscTitleInjury_IDC_Line1",1001]
			,["RscTitleInjury_IDC_Line2",1002]
			,["RscTitleInjury_IDC_Progress",1003]
			,["RscTitleInjury_IDC_Skip",1004]
			,["RscTitleInjury_IDC_Mission",1005]
			,["RscTitleInjury_IDC_Countdown",1006]
			,["RscTitleInjury_IDC_Player",1007]
			,["RscTitleInjury_IDC_HelpText",1008]
			,["RscTitleInjury_IDC_CtrlHealth",2000]
			,["RscTitleInjury_IDC_HealthLower",2001]
			,["RscTitleInjury_IDC_HealthMiddle",2002]
			,["RscTitleInjury_IDC_HealthUpper",2003]
		];

		(uiNamespace getVariable ["RscTitleInjury_IDC_Player",controlNull]) ctrlSetText format["%1 is Incapacitated",name player];
		(uiNamespace getVariable ["RscTitleInjury_IDC_Mission",controlNull]) ctrlSetText briefingName;
		(uiNamespace getVariable ["RscTitleInjury_IDC_Progress",controlNull]) progressSetPosition 1;
		uiNamespace setVariable ["RscTitleInjury_IDC_SkipText",ctrlText (uiNamespace getVariable ["RscTitleInjury_IDC_Skip",controlNull])];

		["MPSF_RscTitleInjury_onEachFrame","onEachFrame",{["onEachFrameUI",_this] call MPSF_fnc_reviveMP;}] call MPSF_fnc_addEventHandler;
	};
	case "onUnloadUI" : {
		["MPSF_RscTitleInjury_onEachFrame","onEachFrame"] call MPSF_fnc_removeEventHandler;

		showHUD (uiNamespace getVariable ["MPSF_Injury_var_showHud",true]);
		showChat (uiNamespace getVariable ["MPSF_Injury_var_showChat",true]);
		{inGameUISetEventHandler [_x, ""]} forEach ["PrevAction", "Action", "NextAction"];

		("MPSF_rscLayerInjury"call BIS_fnc_rscLayer) cutText ["","PLAIN"];

		uiNamespace setVariable ["MPSF_Injury_var_skip",nil];
		uiNamespace setVariable ["MPSF_Injury_var_cameraView","INTERNAL"];
		uiNamespace setVariable ["MPSF_Injury_var_showHud",true];
		uiNamespace setVariable ["MPSF_Injury_var_showChat",true];
	};
	case "onInjuredKeyDown" : {
		_params params [["_display",displayNull],["_key",-1,[0]],["_shift",false,[false]],["_ctrl",false,[false]],["_alt",false,[false]]];
		private _return = false;
		if (_key in [57] && !_shift && !_ctrl && !_alt) then {
			player setVariable ["MPSF_Injury_var_timeSkip"
				,(player getVariable ["MPSF_Injury_var_timeSkip",0]) + 0.2
			];
			_return = true;
		};
		if (_key in [23,34,35]) then {
			private _lastCall = player getVariable ["agonyAssist",0];
			if (_lastCall < MISSIONTIME) then {
				player setVariable ["agonyAssist",MISSIONTIME + 20,false];
				["onInjuryAgony",[player],side group player] call MPSF_fnc_triggerEventHandler;
			};
			_return = true;
		};
		{
			if (_key in (actionKeys _x)) exitWith { _return = true; };
		} forEach ["Diary","Gear","ReloadMagazine","SwitchWeapon"];
		_return;
	};
	case "draw3D" : {
		_params params [["_add",false,[false]]];
		if (_add) then {
			["MPSF_Injury_3Ddraw_EH","onEachFrame",{
				if ((["isInjured",[player]] call MPSF_fnc_reviveMP) || ISINJUREDDISPLAY || visibleMap) exitWith {};

				private _drawIconBandage = {
					params [["_target",objNull,[objNull]],["_injuredPart","",[""]],["_force",false,[false]]];
					if !(alive _target) exitWith {};
					private _injuredPartDamage = _target getVariable [_injuredPart,0];
					if (_injuredPartDamage > 0 || _force) then {
						private _iconPos = _target modeltoworldvisual (_target selectionPosition _injuredPart);
						private _iconPath = if (["isRevivingPart",[_target,_injuredPart]] call MPSF_fnc_reviveMP) then { ICONACTIONHOLDREVIVEMEDIC } else { ICONACTIONHOLDREVIVE };
						private _iconColor = if (["isRevivingPart",[_target,_injuredPart]] call MPSF_fnc_reviveMP) then { COLOURREVIVING } else { COLOURINJURED };
						drawIcon3D [ICONBACKG3,_iconColor,_iconPos,MARKER_SIZE*1.4,MARKER_SIZE*1.4,0,"",0];
						drawIcon3D [_iconPath,COLOURWHITE,_iconPos,MARKER_SIZE*1.4,MARKER_SIZE*1.4,0,"",0];
					};
				};

				private _drawIconAction = {
					params [["_target",objNull,[objNull]],["_injuredPart","",[""]],["_force",false,[false]]];
					if !(alive _target) exitWith {};
					private _injuredPartDamage = _target getVariable [_injuredPart,0];
					if (_injuredPartDamage > 0 || _force) then {
						private _iconPos = _target modeltoworldvisual (_target selectionPosition _injuredPart);
						private _iconColor = [0,0.6,0.6,0.8];
						drawIcon3D [ICONBACKG,_iconColor,_iconPos,MARKER_SIZE*1.3,MARKER_SIZE*1.3,0,"",0];
						drawIcon3D [ICONTAKE,COLOURWHITE,_iconPos,MARKER_SIZE,MARKER_SIZE,0,"",0];
					};
				};

				private _drawSelector = {
					params [["_target",objNull,[objNull]],["_injuredPart","",[""]]];
					if (_injuredPart isEqualTo (missionNamespace getVariable ["MPSF_Injury_var_selectedPart",""]) && _target isEqualTo cursorObject) then {
						private _iconPos = _target modeltoworldvisual (_target selectionPosition _injuredPart);
						drawIcon3D [ICONSELECTORF,COLOURWHITE,_iconPos,MARKER_SIZE*1.7,MARKER_SIZE*1.7,diag_frameNo % 360,"",0];
						drawIcon3D [ICONEMPTY,COLOURWHITE,_iconPos,MARKER_SIZE*1.7,MARKER_SIZE*1.7,0,localize format ["STR_MPSF_INJURY_%1_ACTION",_injuredPart],2];
					};
				};

				private _drawIconTimer = {
					params [["_target",objNull,[objNull]],["_injuredPart","",[""]],["_force",false,[false]]];
					if !(alive _target) exitWith {};
					private _injuredPartDamage = _target getVariable [_injuredPart,0];
					if (_injuredPartDamage > 0 || _force) then {
						private _iconPos = _target modeltoworldvisual (_target selectionPosition _injuredPart);
						private _timeOfInjury = _target getVariable ["MPSF_Injury_var_timeOfInjury",0];
						private _timetoLive = _target getVariable ["MPSF_Injury_var_timeToLive",0];
						private _timeLeft = _timetoLive - MISSIONTIME;
						private _progress = _timeLeft/(_timetoLive - _timeOfInjury);
						private _displayTime = if (_progress <= 0) then { "--:--:--.--" } else { [_timeLeft/60/60,"HH:MM:SS:MM"] call BIS_fnc_timeToString; };
						drawIcon3D [ICONEMPTY,COLOURWHITE,_iconPos,MARKER_SIZE*1.3,MARKER_SIZE*1.3,0,_displayTime,0,0.03,"EtelkaMonospacePro","center"];
					};
				};

				["getInjuredPartCursor",[cursorTarget]] call MPSF_fnc_reviveMP;

				{
					private _target = _x;
					systemChat str name _x;
					if (player distance _target < 30) then {
						if (player distance2D _target < 3 && !(["isInjuredDragged",[_target]] call MPSF_fnc_reviveMP) && !(["isInjuredCarried",[_target]] call MPSF_fnc_reviveMP)) then {
							if (_target isEqualTo cursorObject) then {
								drawIcon3D [ICONPOINTER,[1,1,1,1],screenToWorld [0.5,0.5],MARKER_SIZE*4,MARKER_SIZE*4,0,"",0];
							};
							for "_i" from 0 to (count INJURYPARTS - 1) do {
								private _injuredPart = INJURYPARTS select _i;
								if (count _injuredPart > 1) then {
									[_target,(_injuredPart select 0)] call _drawIconBandage;
								} else {
									[_target,(_injuredPart select 0),true] call _drawIconAction;
								};
								[_target,(_injuredPart select 0)] call _drawSelector;
							};
						} else {
							if (diag_fps > 20) then {
								[_target,"spine2",true] call _drawIconBandage;
								[_target,"spine2",true] call _drawIconTimer;
							};
						};
					};
				} forEach (["getInjured",[true]] call MPSF_fnc_reviveMP);
			}] call MPSF_fnc_addEventHandler;
		} else {
			["MPSF_Injury_3Ddraw_EH","onEachFrame"] call MPSF_fnc_removeEventHandler;
		};
	};
	case "drawMap" : {
		_params params [["_add",false,[false]]];
		if (_add) then {
			["MPSF_Injury_MapDraw_EH","MapDraw",{
				if ((["isInjured",[player]] call MPSF_fnc_reviveMP) || ISINJUREDDISPLAY || !visibleMap) exitWith {};
				{
					private _target = _x;
					private _iconPos = _target modeltoworldvisual (_target selectionPosition "Spine2");
					private _cursorOver = (missionNamespace getVariable ["MPSF_MAP_CURSORPOS",[0,0]]) distance2D _iconPos < 10;
					private _iconPath = if (["isRevivingPart",[_target,_injuredPart]] call MPSF_fnc_reviveMP) then { ICONACTIONHOLDREVIVE } else { ICONACTIONHOLDREVIVEMEDIC };
					private _iconColor = if (["isRevivingPart",[_target,_injuredPart]] call MPSF_fnc_reviveMP) then { COLOURREVIVING } else { COLOURINJURED };
					private _ctrlMap = (findDisplay 12 displayCtrl 51);
					private _size = 24;
					private _displayText = if (_cursorOver) then {format [" %1",name _target];} else {""};
					_ctrlMap drawIcon [ICONBACKG2,_iconColor,_iconPos,_size*1.1,_size*1.1,0];
					_ctrlMap drawIcon [_iconPath,COLOURWHITE,_iconPos,_size,_size,0,_displayText,1,0.04,"PuristaLight",'right'];
				} forEach (["getInjured",[true]] call MPSF_fnc_reviveMP);
			}] call MPSF_fnc_addEventHandler;
		} else {
			["MPSF_Injury_MapDraw_EH","MapDraw"] call MPSF_fnc_removeEventHandler;
		};
	};
// Event Functions
	case "onHandleDamage" : {
		_params params [["_target",objNull,[objNull]],["_hitPoint","",[""]],["_hitDamage",0,[0]],["_shooter",objNull,[objNull]],["_magazine","",[""]],["_hitPointIndex",-1,[0]]];
		if (isNull _target || isNull _shooter) exitWith {0};

		if !(vehicle _target isKindOf "CaManBase") exitWith { _hitDamage };

		_hitDamage = _hitDamage * (["getCfgReviveDamageMultiplier"] call MPSF_fnc_reviveMP);

		private _damage = if (_hitPoint == "") then {
			(damage _target) + (_hitDamage - damage _target)
		} else {
			(_target getHitIndex _hitPointIndex) + (_hitDamage - (_target getHitIndex _hitPointIndex));
		};

		private _setInjured = if (_damage > 0.9) then { _damage = 0.89; count (["hands","legs","head","body"] select {_target getHit _x > 0}) > 0 } else { false };
		if (_setInjured) then {
			if !(["isInjured",[_target]] call MPSF_fnc_reviveMP) exitWith {
				["onInjured",[_target,_setInjured],0] call MPSF_fnc_triggerEventHandler;
			};
		};
		_damage
	};
	case "onInjured" : {
		_params params [["_target",objNull,[objNull]],["_state",false,[false]]];

		if !(_state) exitWith {};
		//if !(isPlayer _target) then { _target disableAI "MOVE"; };

		private _processInjured = true;
		switch (true) do {
			case !(vehicle _target isKindOf "CaManBase") : {
				switch (true) do {
					case !(speed vehicle _target < 1 && {isTouchingGround vehicle _target});
					case (surfaceIsWater(getPosATL _target) && (((getPosASL _target) select 2) <= 0)) : {
						_processInjured = false;
						["setState",[_target,7]] call MPSF_fnc_reviveMP;
					};
				};
			};
		};
		if (_processInjured) then {
			// Set Status
			["setState",[_target,1]] call MPSF_fnc_reviveMP;
			// Set Body Wounded Parts
			["setInjuryWounds",[_target]] call MPSF_fnc_reviveMP;
			// Set Bleedout Duration
			["setTimeToLive",[_target,MISSIONTIME]] call MPSF_fnc_reviveMP;
			// Auto Eject when stopped
			["setAutoEject",[_target]] call MPSF_fnc_reviveMP;
			// Disable Collisions
			["setDisableCollision",[_target]] call MPSF_fnc_reviveMP;
			// If is player, start injury overlay
			if (_target isEqualTo player) then {
				_target setVariable ["MPSF_Injury_var_isPlayer",true];
				// TFAR & ACRE Support
				["setRadioState",[_target,false]] call MPSF_fnc_reviveMP;
				// Restrict Keys to Injured State
				["MPSF_Injury_spaceSkipKeyDown","KeyDown",{["onInjuredKeyDown",_this] call MPSF_fnc_reviveMP;}] call MPSF_fnc_addEventHandler;
				// Start UI Overlay
				("MPSF_rscLayerInjury"call BIS_fnc_rscLayer) cutRsc ["RscTitleMPSFInjury","PLAIN"];
			} else {
				// If another player
				if (hasInterface) then {
					if ([side _target,side player] call BIS_fnc_areFriendly) then {
						// Display Notification
						if (alive _target) then { ["displayNotification",[0,_target]] call MPSF_fnc_reviveMP; };
						// 3D Icons
						["draw3D",[true]] call MPSF_fnc_reviveMP;
						// Map Draw
						["drawMap",[true]] call MPSF_fnc_reviveMP;
						// Action to Assist
						["setInteraction",[_target,true]] call MPSF_fnc_reviveMP;
					};
				};
			};
		};
		_processInjured
	};
	case "onAgony" : {
		_params params [["_target",objNull,[objNull]]];
		if (local _target) then {
			private _scream = selectRandom [
				"WoundedGuyA_01","WoundedGuyA_02","WoundedGuyA_03","WoundedGuyA_04","WoundedGuyA_05","WoundedGuyA_06","WoundedGuyA_07","WoundedGuyA_08"
				,"WoundedGuyB_01","WoundedGuyB_02","WoundedGuyB_03","WoundedGuyB_04","WoundedGuyB_05","WoundedGuyB_06","WoundedGuyB_07","WoundedGuyB_08"
				,"WoundedGuyC_01","WoundedGuyC_02","WoundedGuyC_03","WoundedGuyC_04","WoundedGuyC_05"
			];
			_target say3D _scream;
		};
		if !(_target isEqualTo player) then {
			if (player distance2D _target < 80 && side player isEqualTo side _target) then {
				_target sideChat localize "STR_MPSF_INJURY_AGONYCAL"; // TODO: Localize
			};
		};
	};
	case "onKilled" : {/*
		_params params[["_target",objNull,[objNull]],["_killer",objNull,[objNull]],["_respawn",-1,[-1]],["_delay",-1,[-1]]];
		["setState",[_target,8]] call MPSF_fnc_reviveMP;
		["onInjuredStop",[_target]] call MPSF_fnc_reviveMP;
	*/};
	case "onRespawn" : {
		_params params[["_target",objNull,[objNull]],["_killer",objNull,[objNull]],["_respawn",-1,[-1]],["_delay",-1,[-1]]];
		["setState",[_target,8]] call MPSF_fnc_reviveMP;
	};
	case "onInjuredStop" : {
		_params params [["_target",objNull,[objNull]]];

		// If was player, stop injured UI
		if (_target getVariable ["MPSF_Injury_var_isPlayer",false]) then {
			["setRadioState",[_target,true]] call MPSF_fnc_reviveMP;
			("MPSF_rscLayerInjury"call BIS_fnc_rscLayer) cutText ["","PLAIN",0];
			["onUnload"] call MPSF_UI_fnc_rscTitleInjury;
		};

		if !(isPlayer _target) then { _target enableAI "MOVE"; };

		if (local _target) then {
			// Terminate Carry
			private _carryLink = ["getCarryObjects",[_target]] call MPSF_fnc_reviveMP;
			if !(count (_carryLink select {!(isNull _x)}) == 0) then {
				["onInjuryCarry",_carryLink,_carryLink] call MPSF_fnc_triggerEventHandler;
			};
			// Terminate Drag
			private _dragLink = ["getDragObjects",[_target]] call MPSF_fnc_reviveMP;
			if !(count (_dragLink select {!(isNull _x)}) == 0) then {
				["onInjuryDrag",_dragLink,_dragLink] call MPSF_fnc_triggerEventHandler;
			};

			if (alive _target) then {
				["setState",[_target,9]] call MPSF_fnc_reviveMP;
			};

			[format["MPSF_Injury_countdown%1_EH",_target call BIS_fnc_netId],"onEachFrame"] call MPSF_fnc_removeEventHandler;
			["MPSF_Injury_spaceSkipKeyDown","KeyDown"] call MPSF_fnc_removeEventHandler;
		};

		// Enable Collisions
		["setEnableCollision",[_target]] call MPSF_fnc_reviveMP;

		// Set Status
		["setState",[_target,0]] call MPSF_fnc_reviveMP;

		_target removeAction (_target getVariable ["MPSF_Injury_var_reviveActionID",-1]);
		_target setVariable ["MPSF_Injury_var_reviveActionID",nil];

		if (count (["getInjured",[true]] call MPSF_fnc_reviveMP) == 0) then {
			["draw3D",[false]] call MPSF_fnc_reviveMP;
			["drawMap",[false]] call MPSF_fnc_reviveMP;
		};
	};
// Functions
	case "setState" : {
		_params params [["_target",objNull,[objNull]],["_state",0,[0]]];

		if !(local _target) exitWith {};

		switch (_state) do {
			case 0 : { // Healthy
				['setInjured',[_target,false,false]] call MPSF_fnc_reviveMP;
			};
			case 1 : { // Injured
				['setInjured',[_target,true,true]] call MPSF_fnc_reviveMP;
			};
			case 2; // Dragged
			case 3; // Carried
			case 4 : { // In Vehicle
				['setInjured',[_target,true,false]] call MPSF_fnc_reviveMP;
			};
			case 5 : { // Part Revived
				['setInjured',[_target,true,true]] call MPSF_fnc_reviveMP;
			};
			case 6 : { // Morphine
				['setInjured',[_target,true,true]] call MPSF_fnc_reviveMP;
			};
			case 7 : { // Kill
				['setInjured',[_target,false,false]] call MPSF_fnc_reviveMP;
				switch (true) do {
					case (!isMultiplayer && _target isEqualTo player) : {
						[_target,objNull,0,0] call MPSF_fnc_onInjuryKilled;
						[_target,objNull,0,0] call MPSF_fnc_onRespawnKilled;
					};
					case (isMultiplayer) : { _target setDamage 1; };
					default { _target setDamage 1; };
				};
			};
			case 8 : { // Killed/Respawned EH
				['setInjured',[_target,false,false]] call MPSF_fnc_reviveMP;
			};
			case 9 : { // Healed
				['setInjured',[_target,false,false]] call MPSF_fnc_reviveMP;
				_target setDamage 0;
			};
		};
	};
	case "setInjured" : {
		_params params [["_target",objNull,[objNull]],["_injured",true,[false]],["_unconscious",true,[false]]];
		_target setVariable ["MPSF_Injury_var_state",_injured,true];
		_target setUnconscious _unconscious;
		_target setCaptive _injured;
		true;
	};
	case "setRadioState" : {
		_params params [["_target",objNull,[objNull]],["_state",true,[false]]];
		if ([["task_force_radio","acre_api"],false] call MPSF_fnc_checkMods) then {
			if (_state) then { // Enable Radio
				// TFAR
				_target setVariable ["tf_unable_to_use_radio",false];
				// ACRE
				[false] call (missionNamespace getVariable ["acre_api_fnc_setSpectator",{}]);
			} else { // Disable Radio
				// TFAR
				_target setVariable ["tf_unable_to_use_radio",true];
				// ACRE
				[true] call (missionNamespace getVariable ["acre_api_fnc_setSpectator",{}]);
			};
		};
	};
	case "getInjured" : {
		_params params [["_returnFriendly",true,[false]]];
		private _injured = [];
		_injured append (allPlayers select { [side _x,playerSide] call BIS_fnc_sideIsFriendly; });
		_injured append ((units group player) select { !(isPlayer _x); });
		_injured append ((nearestObjects [player,["CaManBase"],30,true]) select { !(isPlayer _x) });
		_injured select { (["isInjured",[_x]] call MPSF_fnc_reviveMP) && (if (_returnFriendly) then { [side _x,playerSide] call BIS_fnc_sideIsFriendly; } else { true }) };
	};
	case "isInjured" : {
		_params params [["_target",objNull,[objNull]]];
		_target getVariable ["MPSF_Injury_var_state",false] && alive _target;
	};
	case "getTimeToLive" : {
		_params params [["_target",objNull,[objNull]]];
		_target getVariable ["MPSF_Injury_var_timeToLive",0];
	};
	case "setTimeToLive" : {
		_params params [["_target",objNull,[objNull]],["_time",-1,[0]]];

		if (local _target) then {
			if (_time < 0) then {
				_time = _target getVariable ["MPSF_Injury_var_timeToLive",MISSIONTIME];
			};
			private _timetoLive = _time + ((["getCfgReviveBleedout"] call MPSF_fnc_reviveMP) max 10);
			_target setVariable ["MPSF_Injury_var_timeOfInjury",MISSIONTIME,true];
			_target setVariable ["MPSF_Injury_var_timeToLive",_timetoLive,true];
			_target setVariable ["MPSF_Injury_var_timeSkip",0];
			[
				format["MPSF_Injury_countdown%1_EH",_target call BIS_fnc_netId]
				,"onEachFrame"
				,compile format ["['processInjuryTimeToLive',[%1]] call MPSF_fnc_reviveMP;",str (_target call BIS_fnc_netID)]
			] call MPSF_fnc_addEventHandler;
		};
	};
	case "processInjuryTimeToLive" : {
		_params params [["_targetID","",[""]]];
		private _target = _targetID call BIS_fnc_objectFromNetID;
		private _timetoLive = ["getTimeToLive",[_target]] call MPSF_fnc_reviveMP;
		private _timeSkip = _target getVariable ["MPSF_Injury_var_timeSkip",0];
		private _timeLeft = if !(false) then { _timetoLive - MISSIONTIME - _timeSkip; } else { 999 };
		if (_timeLeft <= 0 || !(["isInjured",[_target]] call MPSF_fnc_reviveMP) || !(alive _target)) then {
			[format["MPSF_Injury_countdown%1_EH",_target call BIS_fnc_netId],"onEachFrame"] call MPSF_fnc_removeEventHandler;
		};
		if (_timeLeft <= 0) then {
			["setState",[_target,7]] call MPSF_fnc_reviveMP;
		};
	};
	case "getInjuryWounds" : {
		_params params [["_target",objNull,[objNull]],["_injuredPart","",[""]],["_resolve",false,[false]]];
		private _damage = _target getVariable [_injuredPart,0];
		if (_resolve) then {_damage > 0 || _injuredPart in ["spine3","LeftShoulder","RightShoulder"]} else {_damage};
	};
	case "setInjuryWounds" : {
		_params params [["_target",objNull,[objNull]],["_injuredParts",INJURYPARTS,[[]]],["_damage",-1,[0]]];
		if (local _target) then {
			{
				if (typeName _x isEqualTo typeName []) then {
					if (count _x > 1) then {
						_target setVariable [(_x select 0),_target getHit (_x select 1),true];
					};
				} else {
					_target setVariable [_x,_damage,true];
				};
			} forEach _injuredParts;
		};
	};
	case "displayNotification" : {
		_params params [["_case",0,[0]],["_target",objNull,[objNull]]];
		switch (_case) do {
			case 0 : { [side group player,"HQ"] sideChat format ["%1 has been critically injured and needs assistance.",name _target]; };
			case 1 : { player groupChat "You require gear to perform First Aid!"; };
			case 2 : { player groupChat "You are not medically trained to assist!"; };
		};
		true
	};
// Reviving Functions
	case "onReviving" : {
		_params params [["_target",objNull,[objNull]],["_reviver",objNull,[objNull]],["_stage",0,[0]],["_params",[],[[]]]];

		if (_target isEqualTo _reviver) exitWith {};

		if (local _reviver) then {
			switch (_stage) do {
				case 1 : { // Start
					// Get Injured Part
					private _injuredPart = ["getInjuredPartCursor",[_target]] call MPSF_fnc_reviveMP;
					// Part Already being revived by someone else
					if (["isRevivingPart",[_target,_injuredPart]] call MPSF_fnc_reviveMP) exitWith {};
					if !(["canHeal",[_target,_reviver,true]] call MPSF_fnc_reviveMP) exitWith {};

					switch (_injuredPart) do {
						case "spine3" : { /* Apply Morphine */ };
						case "LeftShoulder" : { /* Drag */ ["onInjuryDrag",[_target,_reviver,true],[_target,_reviver]] call MPSF_fnc_triggerEventHandler; };
						case "RightShoulder" : { /* Carry */ ["onInjuryCarry",[_target,_reviver,true],[_target,_reviver]] call MPSF_fnc_triggerEventHandler; };
						default {
							/* Revive Part */
							if (["getInjuryWounds",[_target,_injuredPart,true]] call MPSF_fnc_reviveMP) then {
								_target setVariable ["injuredPartReviving",_injuredPart];
								["setRevivingPart",[_target,_injuredPart,_reviver]] call MPSF_fnc_reviveMP;
								["setReviver",[_target,_reviver]] call MPSF_fnc_reviveMP;
								[_reviver,"AinvPknlMstpSlayWrflDnon_medic"] call MPSF_fnc_animateUnit;
							};
						};
					};
				};
				case 2 : { // Progress
					private _injuredPart = _target getVariable ["injuredPartReviving",""];
					//hint str ([_injuredPart] + _params);
				};
				case 3 : { // Complete
					if !(["canHeal",[_target,_reviver,false]] call MPSF_fnc_reviveMP) exitWith {};
					private _injuredPart = _target getVariable ["injuredPartReviving",""];
					_target setVariable ["injuredPartReviving",nil];
					if !(_injuredPart isEqualTo "") then {
						_target setVariable [_injuredPart,0,true];
						["setRevivingPart",[_target,_injuredPart]] call MPSF_fnc_reviveMP;
						if (_reviver isEqualTo player) then {
							if (count (INJURYPARTS select {(_target getVariable [_x select 0,0]) > 0}) == 0) then {
								// Remove FAK/MEDKIT
								["removeItems",[_target,_reviver]] call MPSF_fnc_reviveMP;
								// Trigger Revive State
								["onInjuryRevived",[_target,_reviver],[_target,_reviver]] call MPSF_fnc_triggerEventHandler;
							};
						};
					};
				};
				case 4 : { // Canceled
					private _injuredPart = _target getVariable ["injuredPartReviving",""];
					_target setVariable ["injuredPartReviving",nil];
					[_reviver,""] call MPSF_fnc_animateUnit;
					["setRevivingPart",[_target,_injuredPart]] call MPSF_fnc_reviveMP;
				};
			};
		};
	};
	case "onRevived" : {
		_params params [["_target",objNull,[objNull]],["_reviver",objNull,[objNull]]];
		["onInjuredStop",[_target]] call MPSF_fnc_reviveMP;
	};
	case "isBeingRevived";
	case "isReviving" : {
		_params params [["_target",objNull,[objNull]]];
		!isNull(["getReviver",[_target]] call MPSF_fnc_reviveMP);
	};
	case "getReviver" : {
		_params params [["_target",objNull,[objNull]]];
		_target getVariable [INJUREDVARREVIVER,objNull];
	};
	case "setReviver" : {
		_params params [["_target",objNull,[objNull]],["_assistant",objNull,[objNull]],["_link",false,[false]]];
		if (_link) then {
			_target setVariable [INJUREDVARREVIVER,_assistant,true];
			_assistant setVariable [INJUREDVARREVIVER,_target,true];
		} else {
			_target setVariable [INJUREDVARREVIVER,nil,true];
			_assistant setVariable [INJUREDVARREVIVER,nil,true];
		};
		true;
	};
	case "isRevivingPart" : {
		_params params [["_target",objNull,[objNull]],["_part","",[""]]];
		private _assistant = ["getRevivingPart",[_target,_part]] call MPSF_fnc_reviveMP;
		!isNull(_assistant) && alive _assistant;
	};
	case "getRevivingParts" : {
		_params params [["_target",objNull,[objNull]]];
		private _return = [];
		{
			private _assistant = ["getRevivingPart",[_target,_x select 0]] call MPSF_fnc_reviveMP;
			if !(isNull _assistant) then { _return pushBack [_x select 0,_assistant]; };
		} forEach INJURYPARTS;
		_return;
	};
	case "getRevivingPart" : {
		_params params [["_target",objNull,[objNull]],["_part","",[""]]];
		_target getVariable [format[INJUREDVARREVIVEPART,_part],objNull];
	};
	case "setRevivingPart" : {
		_params params [["_target",objNull,[objNull]],["_part","",[""]],["_assistant",objNull,[objNull]]];
		if (isNull _assistant) then {
			_target setVariable [format[INJUREDVARREVIVEPART,_part],nil,true];
		} else {
			_target setVariable [format[INJUREDVARREVIVEPART,_part],_assistant,true];
		};
	};
	case "isBeingRevived2" : {
		_params params [["_target",objNull,[objNull]]];
		count ((["getInjuredPartsReviver"] call MPSF_fnc_reviveMP) select {!(isNull(_x))}) > 0;
	};
	case "getInjuredPartsReviver" : { // Return which part is being healed by whom
		_params params [["_target",objNull,[objNull]],["_injuredParts",INJURYPARTS apply {_x select 0},["",[]]]];
		if (typeName _injuredParts isEqualTo typeName "") then { _injuredParts = [_injuredParts]; };
		_injuredParts apply { _target getVariable [format ["part_%1_reviver",_x],objNull]; };
	};
	case "getInjuredPartsDamage" : {
		_params params [["_target",objNull,[objNull]],["_injuredParts",INJURYPARTS apply {_x select 0},["",[]]]];
		if (typeName _injuredParts isEqualTo typeName "") then { _injuredParts = [_injuredParts]; };
		_injuredParts apply { _target getVariable [format ["part_%1_damage",_x],0]; };
	};
	case "setInjuredPartReviver" : { // Set which part is being healed by whom
		_params params [["_target",objNull,[objNull]],["_injuredPart","",[""]],["_reviver",objNull,[objNull]]];
		if (isNull _target || isNull _reviver) exitWith { /*["setInjuredPartReviver has null objects %1|%2",_target,_reviver] call BIS_fnc_error;*/ false };
		if (_injuredPart isEqualTo "") exitWith { /*["setInjuredPartReviver has nil injured part"] call BIS_fnc_error;*/ false };

		_target setVariable [format["part_%1_reviver",_injuredPart],_reviver,true];

		true;
	};
	case "setInjuredPartDamage" : {
		_params params [["_target",objNull,[objNull]],["_injuredPart","",[""]],["_damage",0,[0]]];
		if (isNull _target) exitWith { /*["setInjuredPartDamage has null objects %1",_target] call BIS_fnc_error;*/ false };
		if (_injuredPart isEqualTo "") exitWith { /*["setInjuredPartDamage has nil injured part"] call BIS_fnc_error;*/ false };

		_target setVariable [format["part_%1_damage",_injuredPart],_damage,true];

		true;
	};
	case "getInjuredPartCursor" : { // TODO: Needs optimisation
		_params params [["_target",objNull,[objNull]]];

		private _cursor = [0.5,0.5];
		private _distance = 0.5;
		private _returnPart = "";

		if !(isNull _target) then {
			{
				private _partPos = worldToScreen (_target modeltoworldvisual (_target selectionPosition (_x select 0)));
				if (count _partPos > 1) then {
					if (_cursor distance2D _partPos < _distance) then {
						_distance = _cursor distance2D _partPos;
						_returnPart = (_x select 0);
					};
				};
			} forEach INJURYPARTS;
		};

		missionNamespace setVariable ["MPSF_Injury_var_selectedPart",_returnPart];
		_returnPart;
	};
// Carry Functions
	case "onCarry" : {
		_params params [["_target",objNull,[objNull]],["_carrier",objNull,[objNull]],["_carry",false,[false]]];

		if (_carry) then {
			["setState",[_target,3]] call MPSF_fnc_reviveMP;
			["setCarryObjects",[_target,_carrier,false]] call MPSF_fnc_reviveMP;

			if (local _target) then {
				// Position Injured Player
				_target setDir (getDir _carrier + 180);
				_target setPosASL (getPosASL _carrier vectorAdd (vectorDir _carrier));

				// Local Animation
				[_target,"AinjPfalMstpSnonWrflDnon_carried_Up"] call MPSF_fnc_animateUnit; // TODO: FUNCTION
				_target setVariable ["MPSF_Injury_animChangedCarried_EH",
					_target addEventHandler ["AnimDone",{
						params["_target","_anim"];
						if (["isInjuredCarried",[_target]] call MPSF_fnc_reviveMP) then {
							if !(_anim IN ANIMS_CARRIED) then {
								_target attachTo [(["getCarryObjects",[_target]] call MPSF_fnc_reviveMP) select 1,[0.2,0.1,0.2]];
								_target setDir 0;
								[_target,"AinjPfalMstpSnonWrflDf_carried_dead"] call MPSF_fnc_animateUnit;
							};
						} else {
							private _ehAnimChanged = _target getVariable ["MPSF_Injury_animChangedCarried_EH", -1];
							if !(_ehAnimChanged == -1) then {
								_target removeEventHandler ["AnimDone",_ehAnimChanged];
								_target setVariable ["MPSF_Injury_animChangedCarried_EH",nil];
							};
						};
					}]
				];
				_target setVariable ["MPSF_Injury_carryKilled_EH",
					_target addEventHandler ["Killed",{
						params [["_killed",objNull,[objNull]]];
						(["getCarryObjects",[_killed]] call MPSF_fnc_reviveMP) params [["_target",objNull,[objNull]],["_carrier",objNull,[objNull]]];
						if (["isInjuredCarried",[_target]] call MPSF_fnc_reviveMP) then {
							["onInjuryCarry",[_target,_carrier,false],[_target,_carrier]] call MPSF_fnc_triggerEventHandler;
						};
						_target removeEventHandler ["Killed",_target getVariable ["MPSF_Injury_carryKilled_EH",-1]];
					}]
				];
			};

			if (local _carrier) then {
				[_carrier,"AcinPknlMstpSnonWnonDnon_AcinPercMrunSnonWnonDnon"] call MPSF_fnc_animateUnit;
				_carrier setVariable ["MPSF_Injury_carryKilled_EH",
					_carrier addEventHandler ["Killed",{
						params [["_killed",objNull,[objNull]]];
						(["getCarryObjects",[_target]] call MPSF_fnc_reviveMP) params [["_target",objNull,[objNull]],["_carrier",objNull,[objNull]]];
						if (["isInjuredCarried",[_target]] call MPSF_fnc_reviveMP) then {
							["onInjuryCarry",[_target,_carrier,false],[_target,_carrier]] call MPSF_fnc_triggerEventHandler;
						};
						_carrier removeEventHandler ["Killed",_carrier getVariable ["MPSF_Injury_carryKilled_EH",-1]];
					}]
				];
				if (_carrier isEqualTo player) then {
					_carrier setVariable ["MPSF_Injury_var_carryAction",
						_carrier addAction [format["Drop %1",name _target],{
							(_this select 3) params ["_target","_carrier"];
							["onInjuryCarry",[_target,_carrier,false],[_target,_carrier]] call MPSF_fnc_triggerEventHandler;
						},[_target,_carrier],100,true,true,"","true"]
					];
				};
			};
		} else {
			["setCarryObjects",[_target,_carrier,true]] call MPSF_fnc_reviveMP;

			detach _target;
			detach _carrier;

			if (local _target) then {
				_target removeEventHandler ["Killed",_target getVariable ["MPSF_Injury_carryKilled_EH",-1]];
				[_target,"unconscious"] call MPSF_fnc_animateUnit;
				["setState",[_target,1]] spawn {sleep 0.1; _this call MPSF_fnc_reviveMP};
			};

			if (local _carrier) then {
				_carrier removeAction (_carrier getVariable ["MPSF_Injury_var_carryAction",-1]);
				_carrier removeEventHandler ["Killed",_carrier getVariable ["MPSF_Injury_carryKilled_EH",-1]];
				if (alive _carrier) then {
					[_carrier,"amovpknlmstpsraswrfldnon"] call MPSF_fnc_animateUnit;
				};
			};
		};
	};
	case "getCarryObjects" : {
		_params params [["_target",objNull,[objNull]]];
		_target getVariable [INJUREDVARCARRYLINK,[objNull,objNull]]
	};
	case "setCarryObjects" : {
		_params params [["_target",objNull,[objNull]],["_assistant",objNull,[objNull]],["_remove",false,[false]]];
		if !(_remove) then {
			_target setVariable [INJUREDVARCARRYLINK,[_target,_assistant],true];
			_assistant setVariable [INJUREDVARCARRYLINK,[_target,_assistant],true];
		} else {
			_target setVariable [INJUREDVARCARRYLINK,nil,true];
			_assistant setVariable [INJUREDVARCARRYLINK,nil,true];
		};
		true;
	};
	case "isInjuredCarried" : {
		_params params [["_target",objNull,[objNull]]];
		count ((["getCarryObjects",[_target]] call MPSF_fnc_reviveMP) select {alive _x}) > 0
	};
// Drag Functions
	case "onDrag" : {
		_params params [["_target",objNull,[objNull]],["_carrier",objNull,[objNull]],["_drag",false,[false]]];

		if (_drag) then {
			["setState",[_target,2]] call MPSF_fnc_reviveMP;
			["setDragObjects",[_target,_carrier,true]] call MPSF_fnc_reviveMP;

			if (local _target) then {
				// Position Injured Player
				_target setPosASL (getPosASL _carrier vectorAdd (vectorDir _carrier vectorMultiply 1.5));
				_target attachTo [_carrier,[0,1,0.08]];
				_target setDir 180;

				// Animation
				[_target,"AinjPpneMrunSnonWnonDb_grab"] call MPSF_fnc_animateUnit;
				_target setVariable ["MPSF_Injury_animChangedDragged_EH",
					_target addEventHandler ["AnimDone",{
						params["_target","_anim"];
						if (["isInjuredDragged",[_target]] call MPSF_fnc_reviveMP) then {
							// Reset Animation to Drag
							if !(_anim IN ANIMS_DRAGGED) then { [_target,"AinjPpneMrunSnonWnonDb"] call MPSF_fnc_animateUnit; };
						} else {
							// Remove Animation Handler
							private _ehAnimChanged = _target getVariable ["MPSF_Injury_animChangedDragged_EH", -1];
							if !(_ehAnimChanged == -1) then {
								_target removeEventHandler ["AnimDone",_ehAnimChanged];
								_target setVariable ["MPSF_Injury_animChangedDragged_EH",nil];
							};
						};
					}]
				];
				_target setVariable ["MPSF_Injury_dragKilled_EH",
					_target addEventHandler ["Killed",{
						params [["_killed",objNull,[objNull]]];
						(["getDragObjects",[_killed]] call MPSF_fnc_reviveMP) params [["_target",objNull,[objNull]],["_carrier",objNull,[objNull]]];
						if (["isInjuredDragged",[_target]] call MPSF_fnc_reviveMP) then {
							["onInjuryDrag",[_target,_carrier,false],[_target,_carrier]] call MPSF_fnc_triggerEventHandler;
						};
						_target removeEventHandler ["Killed",_target getVariable ["MPSF_Injury_dragKilled_EH",-1]];
					}]
				];
			};

			if (local _carrier) then {
				_carrier playAction "grabDrag";
				_carrier setVariable ["MPSF_Injury_dragKilled_EH",
					_carrier addEventHandler ["Killed",{
						params [["_killed",objNull,[objNull]]];
						(["getDragObjects",[_killed]] call MPSF_fnc_reviveMP) params [["_target",objNull,[objNull]],["_carrier",objNull,[objNull]]];
						if (["isInjuredDragged",[_target]] call MPSF_fnc_reviveMP) then {
							["onInjuryDrag",[_target,_carrier,false],[_target,_carrier]] call MPSF_fnc_triggerEventHandler;
						};
						_carrier removeEventHandler ["Killed",_carrier getVariable ["MPSF_Injury_dragKilled_EH",-1]];
					}]
				];
				if (_carrier isEqualTo player) then {
					_carrier setVariable ["MPSF_Injury_var_dragAction",
						_carrier addAction [format["Drop %1",name _target],{
							(_this select 3) params ["_target","_carrier"];
							["onInjuryDrag",[_target,_carrier,false],[_target,_carrier]] call MPSF_fnc_triggerEventHandler;
						},[_target,_carrier],100,true,true,"","true"]
					];
				};
			};
		} else {
			["setDragObjects",[_target,_carrier,false]] call MPSF_fnc_reviveMP;

			detach _target;
			detach _carrier;

			if (local _target) then {
				_target removeEventHandler ["Killed",_target getVariable ["MPSF_Injury_dragKilled_EH",-1]];
				if (alive _target) then {
				//	[_target,"released"] call MPSF_fnc_animateUnit;
					[_target,"unconscious"] call MPSF_fnc_animateUnit;
					["setState",[_target,1]] spawn {sleep 0.1; _this call MPSF_fnc_reviveMP};
				} else {
					[_target,"AinjPpneMstpSnonWrflDb_death"] call MPSF_fnc_animateUnit;
					["setState",[_target,6]] spawn {sleep 0.1; _this call MPSF_fnc_reviveMP};
				};
			};

			if (local _carrier) then {
				_carrier removeAction (_carrier getVariable ["MPSF_Injury_var_dragAction",-1]);
				_carrier removeEventHandler ["Killed",_carrier getVariable ["MPSF_Injury_dragKilled_EH",-1]];
				if (alive _carrier) then {
					[_carrier, "amovpknlmstpsraswrfldnon"] call MPSF_fnc_animateUnit;
				};
			};
		};
	};
	case "getDragObjects" : {
		_params params [["_target",objNull,[objNull]]];
		_target getVariable [INJUREDVARDRAGLINK,[objNull,objNull]]
	};
	case "setDragObjects" : {
		_params params [["_target",objNull,[objNull]],["_assistant",objNull,[objNull]],["_link",false,[false]]];
		if (_link) then {
			_target setVariable [INJUREDVARDRAGLINK,[_target,_assistant],true];
			_assistant setVariable [INJUREDVARDRAGLINK,[_target,_assistant],true];
		} else {
			_target setVariable [INJUREDVARDRAGLINK,nil,true];
			_assistant setVariable [INJUREDVARDRAGLINK,nil,true];
		};
		true;
	};
	case "isInjuredDragged" : {
		_params params [["_target",objNull,[objNull]]];
		count ((["getDragObjects",[_target]] call MPSF_fnc_reviveMP) select {alive _x}) > 0
	};
// Other Functions
	case "setAutoEject" : {
		_params params [["_target",objNull,[objNull]]];
		if !(local _target) exitWith {};
		if !(vehicle _target isEqualTo _target) then {
			_target spawn {
				params ["_target"];
				private _vehicle = vehicle _target;
				["setState",[_target,4]] call MPSF_fnc_reviveMP;
				waitUntil { isTouchingGround _vehicle && speed _vehicle < 1 || damage _vehicle == 1 };
				_target action ["Eject",vehicle _target];
				waitUntil { (vehicle _target isEqualTo _target) || !(alive _target)};
				["setState",[_target,1]] call MPSF_fnc_reviveMP;
			};
		};
		true;
	};
	case "setDisableCollision" : {
		_params params [["_target",objNull,[objNull]]];
		["setCollision",[_target,false]] call MPSF_fnc_reviveMP;
	};
	case "setEnableCollision" : {
		_params params [["_target",objNull,[objNull]]];
		["setCollision",[_target,true]] call MPSF_fnc_reviveMP;
	};
	case "setCollision" : {
		_params params [["_target",objNull,[objNull]],["_enable",true,[false]]];
		if (_enable) then {
			if (local _target) then {
				{
					if !(["isInjured",[_x]] call MPSF_fnc_reviveMP) then { _target enableCollisionWith _x; };
				} forEach allPlayers;
			} else {
				if !(["isInjured",[_target]] call MPSF_fnc_reviveMP) then { player enableCollisionWith _target; };
			};
		} else {
			if (local _target) then {
				{_target disableCollisionWith _x} forEach allPlayers;
			} else {
				player disableCollisionWith _target;
			};
		};
		true;
	};
	case "setInteraction" : {
		_params params [["_target",objNull,[objNull]],["_addAction",false,[false]]];
		private _actionID = format["MPSF_Injury_%1_Action1",_target call BIS_fnc_netId];
		if (_addAction) then {
			// Revive Duration
			private _actionDuration = (["getCfgReviveTimer"] call MPSF_fnc_reviveMP);
			if (["getCfgRequireMedic"] call MPSF_fnc_reviveMP) then {
				if (["isMedic",[player]] call MPSF_fnc_reviveMP) then { _actionDuration = _actionDuration / (["getCfgReviveMedicMultiplier"] call MPSF_fnc_reviveMP); };
			};
			// Revive Action Condition
			private _actionCondition = "(['isInjured',[_target]] call MPSF_fnc_reviveMP)
				&& !(['isInjuredCarried',[_target]] call MPSF_fnc_reviveMP)
				&& !(['isInjuredDragged',[_target]] call MPSF_fnc_reviveMP)
				&& (['getInjuryWounds',[_target,(['getInjuredPartCursor',[_target]] call MPSF_fnc_reviveMP),true]] call MPSF_fnc_reviveMP)
				|| (['isReviving',[player]] call MPSF_fnc_reviveMP)
			";
			[_actionID,_target,format[localize "STR_MPSF_INJURY_ACTION",name _target],[
				[ICONACTIONHOLDREVIVE,{["onInjuryReviving",[_target,_caller,1],true] call MPSF_fnc_triggerEventHandler;}]
				,[ICONACTIONHOLDREVIVEMEDIC,{["onInjuryReviving",[_target,_caller,2,[_frame]],true] call MPSF_fnc_triggerEventHandler;}]
				,{["onInjuryReviving",[_target,_caller,3],true] call MPSF_fnc_triggerEventHandler;}
				,{["onInjuryReviving",[_target,_caller,4],true] call MPSF_fnc_triggerEventHandler;}
				,_actionDuration,false
			],[],_actionCondition,true,false] call MPSF_fnc_addAction;
		} else {
			[_actionID,_target] call MPSF_fnc_removeAction;
		};
	};
	case "canHeal" : {
		_params params [["_target",objNull,[objNull]],["_assistant",objNull,[objNull]],["_notify",false,[false]]];
		private _isMedic = ["isMedic",[_assistant]] call MPSF_fnc_reviveMP;
		private _hasItems = ["hasItems",[_target,_assistant]] call MPSF_fnc_reviveMP;
		if (_notify) then {
			switch (true) do {
				case !(_isMedic) : { ["displayNotification",[2]] call MPSF_fnc_reviveMP; };
				case !(_hasItems) : { ["displayNotification",[1]] call MPSF_fnc_reviveMP; };
			};
		};
		_isMedic && _hasItems
	};
	case "canHealFull" : {
		_params params [["_target",objNull,[objNull]],["_assistant",objNull,[objNull]]];
		private _canHeal = ["canHeal",[_target,_assistant]] call MPSF_fnc_reviveMP;
		if (_canHeal) then {
			_canHeal = ["hasItemFullHeal",[_target,_assistant]] call MPSF_fnc_reviveMP;
		};
		_canHeal;
	};
	case "isMedic" : {
		_params params [["_target",objNull,[objNull]]];
		if (["getCfgRequireMedic"] call MPSF_fnc_reviveMP) then { _target getUnitTrait "medic"; } else { true };
	};
	case "hasItems" : {
		_params params [["_target",objNull,[objNull]],["_assistant",objNull,[objNull]]];
		private _itemTypes = ["getCfgRequireItems"] call MPSF_fnc_reviveMP;
		if (count _itemTypes > 0) then {
			count ((items _target) arrayIntersect _itemTypes) > 0 || count ((items _assistant) arrayIntersect _itemTypes) > 0
		} else {
			true;
		};
	};
	case "hasItemFullHeal" : {
		_params params [["_target",objNull,[objNull]],["_assistant",objNull,[objNull]]];
		private _itemTypes = ["getCfgRequiteItemsHeal"] call MPSF_fnc_reviveMP;
		if (count _itemTypes > 0) then {
			count ((items _target) arrayIntersect _itemTypes) > 0 || count ((items _assistant) arrayIntersect _itemTypes) > 0
		} else {
			true;
		};
	};
	case "removeItems" : {
		_params params [["_target",objNull,[objNull]],["_assistant",objNull,[objNull]]];
		private _itemTypes = ["getCfgRemoveItems"] call MPSF_fnc_reviveMP;
		if (count _itemTypes > 0) then {
			private _removeItemsTarget = (items _target) arrayIntersect _itemTypes;
			if (count _removeItemsTarget > 0) then {
				private _item = selectRandom _removeItemsTarget;
				_target removeItem _item;
				[side group player,"HQ"] sideChat format ["Removed %2 from %1 when applying aid.",name _target,_item];
			} else {
				private _removeItemsAssistant = (items _assistant) arrayIntersect _itemTypes;
				if (count _removeItemsAssistant > 0) then {
					private _item = selectRandom _removeItemsAssistant;
					_assistant removeItem _item;
					[side group player,"HQ"] sideChat format ["Removed %2 when applying aid to %1.",name _target,_item];
				};
			};
		};
	};
// Config
	case "getCfgReviveEnabled" : { missionNamespace getVariable ["MissionReviveEnabled",["CfgReviveMP","enabled"] call MPSF_fnc_getCfgDataBool]; };
	case "getCfgRequireItems" : { missionNamespace getVariable ["MissionReviveRequireItems",["CfgReviveMP","RequireItems"] call MPSF_fnc_getCfgDataArray]; };
	case "getCfgRequiteItemsHeal" : { missionNamespace getVariable ["MissionReviveRequireItems",["CfgReviveMP","RequireItemsFullHeal"] call MPSF_fnc_getCfgDataArray]; };
	case "getCfgRemoveItems" : { missionNamespace getVariable ["MissionReviveRemoveItems",["CfgReviveMP","RemoveItems"] call MPSF_fnc_getCfgDataArray]; };
	case "getCfgRequireMedic" : { missionNamespace getVariable ["MissionReviveRequireMedic",["CfgReviveMP","RequireMedicTrait"] call MPSF_fnc_getCfgDataBool]; };
	case "getCfgReviveTimer" : { missionNamespace getVariable ["MissionReviveReviveTimer",["CfgReviveMP","ReviveTimer"] call MPSF_fnc_getCfgDataNumber]; };
	case "getCfgReviveBleedout" : { missionNamespace getVariable ["MissionReviveReviveBleedout",["CfgReviveMP","ReviveBleedout"] call MPSF_fnc_getCfgDataNumber]; };
	case "getCfgReviveMedicMultiplier" : { missionNamespace getVariable ["MissionReviveMedicMultiplier",["CfgReviveMP","ReviveTimerMedicSpeed"] call MPSF_fnc_getCfgDataNumber]; };
	case "getCfgReviveDamageMultiplier" : { missionNamespace getVariable ["MissionReviveMedicMultiplier",["CfgReviveMP","ReviveDamageMultiplier"] call MPSF_fnc_getCfgDataNumber]; };
// INIT
	case "addDiaryNote" : {
		if !(["getCfgReviveEnabled"] call MPSF_fnc_reviveMP) exitWith {};
		private _reviveMPnoteID = "MPSF_REVIVEMP_NOTE";
		private _reviveMPtitle = "Revive MP";
		if !(player diarySubjectExists _reviveMPnoteID) then { player createDiarySubject [_reviveMPnoteID,_reviveMPtitle]; };
		private _reviveMPrecords = [ // TODO: Localize
			"Revive MP<br/>Describing the Revive Process"
			,"Revive MP<br/>Describing the First Aid Caviets"
			,"Revive MP<br/>A damage based revive script that enables units to treat injured other injured units"
			,"Revive MP<br/>Describing the Injured State"
		];
		{ player createDiaryRecord [_reviveMPnoteID,["ReviveMP",_x]]; } forEach _reviveMPrecords;
		true
	};
	case "initUnit" : {
		if !(["getCfgReviveEnabled"] call MPSF_fnc_reviveMP) exitWith {};

		_params params [["_target",objNull,[objNull]]];
		if (isNull _target) exitWith {};
		if !(local _target) exitWith {};
		if !(isNil {missionNamespace getVariable format ["MPSF_Injury_var_%1_HandleDamage_EH",_target call BIS_fnc_netID]}) exitWith {};

		missionNamespace setVariable [format ["MPSF_Injury_var_%1_HandleDamage_EH",_target call BIS_fnc_netID],
			_target addEventHandler ["HandleDamage",{["onHandleDamage",_this] call MPSF_fnc_reviveMP;}]
		];
		true;
	};
	case "preInit";
	case "postInit";
	case "init" : {
		// Exit if not enabled in missionconfigfile
		if !(["getCfgReviveEnabled"] call MPSF_fnc_reviveMP) exitWith {};
		// Exit if mission parameter set to disabled
		if !((["ParamReviveMPenable",1] call BIS_fnc_getParamValue) isEqualTo 1) exitWith {};
		_params params [["_addDiaryNote",true,[false]]];
		["MPSF_Injury_onInjuryReviving_EH","onInjuryReviving",{ ["onReviving",_this] call MPSF_fnc_reviveMP; } ] call MPSF_fnc_addEventHandler;
		["MPSF_Injury_onInjuryRevived_EH","onInjuryRevived",{ ["onRevived",_this] call MPSF_fnc_reviveMP; }] call MPSF_fnc_addEventHandler;
		["MPSF_Injury_onInjuryKilled_EH","onInjuryKilled",{ ["onKilled",_this] call MPSF_fnc_reviveMP ;}] call MPSF_fnc_addEventHandler;
		["MPSF_Injury_onInjuryAgony_EH","onInjuryAgony",{ ["onAgony",_this] call MPSF_fnc_reviveMP ;}] call MPSF_fnc_addEventHandler;
		["MPSF_Injury_onInjuryCarry_EH","onInjuryCarry",{ ["onCarry",_this] call MPSF_fnc_reviveMP; }] call MPSF_fnc_addEventHandler;
		["MPSF_Injury_onInjuryDrag_EH","onInjuryDrag",{ ["onDrag",_this] call MPSF_fnc_reviveMP; }] call MPSF_fnc_addEventHandler;
		["MPSF_Injury_onInjury_EH","onInjured",{ ["onInjured",_this] call MPSF_fnc_reviveMP; }] call MPSF_fnc_addEventHandler;
		if (hasInterface) then {
			["MPSF_Injury_damage_EH","onHandleDamage",{["onHandleDamage",_this] call MPSF_fnc_reviveMP;}] call MPSF_fnc_addEventHandler;
			["MPSF_Injury_onUnitRecruited_EH","onUnitRecruited",{["initUnit",[_this select 0]] call MPSF_fnc_reviveMP}] call MPSF_fnc_addEventHandler;
			if (_addDiaryNote) then { ["addDiaryNote"] call MPSF_fnc_reviveMP; };
		};
		true;
	};
};