/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_intel.sqf
	Author(s): see mpsf\credits.txt

	Description:
		INTEL Framework
*/
// Intel
#define TERABYTE							1000000000000
#define GIGABYTE							1000000000
#define MEGABYTE							1000000
#define KILOBYTE							1000
#define BYTE								1
#define BITRATE	 							(KILOBYTE*(random MEGABYTE))
#define INTELVARCONNECTSTART				1000
#define INTELVARCONNECTPROGRESS				"MPSF_Intel_var_UIConnectingProgress"
#define INTELVARLINKDISTANCE				"MPSF_Intel_var_downloadLinkDistance"
#define GETINTELLINKDISTANCE				(missionNamespace getVariable [INTELVARLINKDISTANCE,20])
#define INTELVARDOWNLOADOBJECT				"MPSF_Intel_var_isDownloadable"
#define ISINTELOBJECT(object)				(object getVariable [INTELVARDOWNLOADOBJECT,false])
#define SETINTELOBJECT(object,state)		(object setVariable [INTELVARDOWNLOADOBJECT,state,true])
#define INTELVARDOWNLOADOBJECTATTR			"MPSF_Intel_var_downloadAttributes"
#define SETINTELOBJECTATTR(object,attr)		(object setVariable [INTELVARDOWNLOADOBJECTATTR,attr])
#define GETINTELOBJECTATTR(object)			(object setVariable [INTELVARDOWNLOADOBJECTATTR,[]])
#define INTELVARDOWNLOADLINK				"MPSF_Intel_var_downloadlinked"
#define GETINTELDOWNLOADLINK(object)		(object getVariable [INTELVARDOWNLOADLINK,objNull])
#define HASINTELDOWNLOADLINK(object,target)	(GETINTELDOWNLOADLINK(object) isEqualTo target && GETINTELDOWNLOADLINK(target) isEqualTo object)
#define SETINTELDOWNLOADLINK(object,target)	(object setVariable [INTELVARDOWNLOADLINK,target]); (target setVariable [INTELVARDOWNLOADLINK,object])
#define KILLINTELDOWNLOADLINK(object,target) (object setVariable [INTELVARDOWNLOADLINK,nil,true]); (target setVariable [INTELVARDOWNLOADLINK,nil,true])
#define ISINTELDOWNLOADING(object)			(alive GETINTELDOWNLOADLINK(object) && damage GETINTELDOWNLOADLINK(object) < 1)
#define INTELVARDOWNLOADSIZE				"MPSF_Intel_var_downloadSize"
#define SETINTELDOWNLOADSIZE(object,size)	(object setVariable [INTELVARDOWNLOADSIZE,size,true])
#define GETINTELDOWNLOADSIZE(object)		(object getVariable [INTELVARDOWNLOADSIZE,0])
#define INTELVARDOWNLOADLEFT				"MPSF_Intel_var_downloadRemaining"
#define SETINTELDOWNLOADLEFT(object,size)	(object setVariable [INTELVARDOWNLOADLEFT,size])
#define GETINTELDOWNLOADLEFT(object)		(object getVariable [INTELVARDOWNLOADLEFT,GETINTELDOWNLOADSIZE(object)])
#define INTELVARUISTATE						"MPSF_Intel_var_UIstate"
#define GETINTELDOWNLOADUISTATE				(uiNamespace getVariable [INTELVARUISTATE,0])
#define SETINTELDOWNLOADUISTATE(state)		(uiNamespace setVariable [INTELVARUISTATE,state])
// Colours
#define COLOURWHITE							[1,1,1,1]
#define COLOURREVIVING						[0,0.6,0.6,1]
#define COLOURORANGE						[1,0.66,0,1]
// Icons
#define ICONEMPTY							"#(argb,8,8,3)color(0,0,0,0.8)"
#define ICONSELECTORM						"\A3\ui_f\data\map\groupicons\selector_selectedMission_ca.paa"
#define ICONPARACHUTE						"\A3\ui_f\data\Map\VehicleIcons\iconParachute_ca.paa"
#define ICONMOVEOLD							"\A3\ui_f\data\IGUI\Cfg\Actions\ico_ON_ca.paa"
#define ICONMOVE							"\a3\ui_f\data\IGUI\Cfg\Cursors\mission_ca.paa"
#define ICONSELECTED						"\A3\ui_f\data\map\groupicons\selector_selected_ca.paa"
#define ICONMOVEWARNING						"\A3\ui_f\data\IGUI\Cfg\Actions\ico_OFF_ca.paa"
#define ICONBADGE							"\A3\ui_f\data\Map\GroupIcons\badge_rotate_%1_gs.paa"

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
// Event Triggers
	// EH INTEL CREATE
	case "onIntelCreated" : {};
	case "onIntelDropped" : {};
	// EH Intel Download
	case "onIntelDownloadStart" : {
		_params params [["_object",objNull,[objNull]],["_target",objNull,[objNull]],["_attributes",[],[[]]]];

		if (HASINTELDOWNLOADLINK(_object,_target)) exitWith {};

		if (side _target == side player) then {
			["MPSF_onIntelDownloadStart",[name _target]] call BIS_fnc_showNotification;
		};

		if (_target isEqualTo player) then {
			SETINTELDOWNLOADLEFT(_object,0);
			SETINTELDOWNLOADLINK(_object,_target);
			_object setVariable ["MPSF_Intel_var_downloadAttributes",_attributes];
			_object setVariable ["MPSF_Intel_var_downloadSizeStart",TERABYTE + random(TERABYTE/3)];
		};

		if (local _object) then {
			if (_object isKindOf "Land_DataTerminal_01_F") then {
				[_object,3] call BIS_fnc_DataTerminalAnimate;
			};
		};

		private _linkObjects = missionNamespace getVariable ["MPSF_Intel_var_linkObjects",[]];
		_linkObjects pushBack [_object,_target];
		missionNamespace setVariable ["MPSF_Intel_var_linkObjects",_linkObjects];

		["MPSF_Intel_onEachFrameDrawLine_EH","onEachFrame",{
			private _linkObjects = missionNamespace getVariable ["MPSF_Intel_var_linkObjects",[]];
			if (count _linkObjects == 0) exitWith { ["MPSF_Intel_onEachFrameDrawLine_EH","onEachFrame"] call MPSF_fnc_removeEventHandler; };
			{
				_x params [["_object",objNull,[objNull]],["_target",objNull,[objNull]]];
				if (
					HASINTELDOWNLOADLINK(_object,_target)
				) then {
					private _attributes = _object getVariable ["MPSF_Intel_var_downloadAttributes",[]];
					private _downloadSize = _object getVariable ["MPSF_Intel_var_downloadSizeStart",0];
					private _downloadCurrent = GETINTELDOWNLOADLEFT(_object);
					private _linkDelay = ((GETINTELLINKDISTANCE - (_object distance2D _target)) / GETINTELLINKDISTANCE) min 1 max 0.01;
					_downloadCurrent = (_downloadCurrent + BITRATE * _linkDelay) min _downloadSize;
					private _progress = _downloadCurrent/_downloadSize;
					private _callRound = { round(_this * 100)/100 };
					private _formatStart = format["%1TB",_downloadSize/(10e11) call _callRound];
					private _formatCurrent = switch (true) do {
						case (_downloadCurrent < KILOBYTE) : { format["%1",_downloadCurrent]; };
						case (_downloadCurrent < MEGABYTE) : { format["%1kB",_downloadCurrent/(10e2) call _callRound]; };
						case (_downloadCurrent < GIGABYTE) : { format["%1MB",_downloadCurrent/(10e5) call _callRound]; };
						case (_downloadCurrent < TERABYTE) : { format["%1GB",_downloadCurrent/(10e8) call _callRound]; };
						default { format["%1TB",_downloadCurrent/(10e11) call _callRound]; };
					};

					hintSilent parseText (if (_linkDelay < 0.3) then {
						format["<t align='right'>Downloading...<br/>%1%2 Complete<br/>%3/%4<br/>%5</t><br/><img image='\A3\ui_f\data\IGUI\RscTitles\RscHvtPhase\JAC_A3_Signal_%5_ca.paa' size='2' color = '#FF2D2D' />",floor(_progress*100),"%",_formatCurrent,_formatStart,round(4*_linkDelay) min 4 max 0];
					} else {
						format["<t align='right'>Downloading...<br/>%1%2 Complete<br/>%3/%4<br/>%5</t><br/><img image='\A3\ui_f\data\IGUI\RscTitles\RscHvtPhase\JAC_A3_Signal_%5_ca.paa' size='1' />",floor(_progress*100),"%",_formatCurrent,_formatStart,round(4*_linkDelay) min 4 max 0];
					});

					switch (true) do {
						case (!ISINTELDOWNLOADING(_object));
						case (!ISINTELDOWNLOADING(_target));
						case (_target distance2D _object > GETINTELLINKDISTANCE) : {
							["MPSF_Intel_onEachFrameDrawLine_EH","onEachFrame"] call MPSF_fnc_removeEventHandler;
							["onIntelDownloadStop",[_object,_target,_attributes],0] call MPSF_fnc_triggerEventHandler;
						};
						case (GETINTELDOWNLOADLEFT(_object) >= _downloadSize) : {
							["MPSF_Intel_onEachFrameDrawLine_EH","onEachFrame"] call MPSF_fnc_removeEventHandler;
							["onIntelDownloadComplete",[_object,_target,_attributes],0] call MPSF_fnc_triggerEventHandler;
						};
					};
					SETINTELDOWNLOADLEFT(_object,_downloadCurrent);

					if (random 1 > 0.35) then {
						private _sourcePos = getPosATL _object;
						private _targetPos = _target modeltoworldvisual (_target selectionPosition "lefthand");
						private _distance = 1 max (_sourcePos distance2D _targetPos) min GETINTELLINKDISTANCE;
						private _colour = [1,1,0,1];
						_colour set [0,_distance/GETINTELLINKDISTANCE];
						_colour set [1,1-(_distance/GETINTELLINKDISTANCE)];
						drawLine3D [_sourcePos,_targetPos,_colour];
					};
				} else {
					_linkObjects deleteAt _forEachIndex;
				};
			} forEach _linkObjects;
			missionNamespace setVariable ["MPSF_Intel_var_linkObjects",_linkObjects];
		}] call MPSF_fnc_addEventHandler;
	};
	case "onIntelDownloadStop" : {
		_params params [["_object",objNull,[objNull]],["_target",objNull,[objNull]],["_attributes",[],[[]]]];
		// Animate Terminal
		if (local _object) then { if (_object isKindOf "Land_DataTerminal_01_F") then { [_object,0] call BIS_fnc_DataTerminalAnimate; }; };
		// Remove Link
		if (_target isEqualTo player) then { KILLINTELDOWNLOADLINK(_object,_target); };
		// Remove VR Target
		["removeIntelBeacon",[_object]] call MPSF_fnc_intel;
		// Notification
		if (side _target == side player) then { ["MPSF_onIntelDownloadStop",[name _target]] call BIS_fnc_showNotification; };
	};
	case "onIntelDownloadComplete" : {
		_params params [["_object",objNull,[objNull]],["_target",objNull,[objNull]],["_attributes",[],[[]]]];
		// Animate Terminal
		if (local _object) then { if (_object isKindOf "Land_DataTerminal_01_F") then { [_object,0] call BIS_fnc_DataTerminalAnimate; }; };
		// Remove Link
		if (_target isEqualTo player) then { KILLINTELDOWNLOADLINK(_object,_target); };
		// Remove VR Target
		["removeIntelBeacon",[_object]] call MPSF_fnc_intel;
		// Notification
		if (side _target == side player) then { ["MPSF_onIntelDownloadComplete",[name _target]] call BIS_fnc_showNotification; };
	};
	// EH Intel Handler
	case "onIntelPickup" : {
		_params params [["_target",objNull,[objNull]],["_attributes",[],[[]]]];
		// Notification
		if (side _target == side player) then { ["MPSF_onIntelPickup",[name _target]] call BIS_fnc_showNotification; };
	};
	case "onIntelRecieve" : {
		_params params [["_object",objNull,[objNull]],["_target",objNull,[objNull]],["_attributes",[],[[]]]];
		// Notification
		if (side _target == side player) then { ["MPSF_onIntelRecieve",[name _target,name _object]] call BIS_fnc_showNotification; };
	};
// Config
	case "getCfgIntelDropTypes" : {
		["CfgMissionFramework","intelDropTypes"] call MPSF_fnc_getCfgDataArray;
	};
	case "getCfgIntelDownloadTypes" : {
		["CfgMissionFramework","intelDownloadTypes"] call MPSF_fnc_getCfgDataArray;
	};
// Funtions
	case "createIntel" : {
		_params params [["_target",objNull,[[],"",objNull]],["_arguments",[],[[]]]];
		private _dropTypes = ["getCfgIntelDropTypes"] call MPSF_fnc_intel;
		private _downloadTypes = ["getCfgIntelDownloadTypes"] call MPSF_fnc_intel;

		// Create Intel on Position
		if !(typeName _target isEqualTo typeName objNull) then {
			private _dropPos = _target call BIS_fnc_position;
			if (count _dropTypes > 0) then {
				_target = createVehicle [selectRandom _dropTypes,_dropPos,[],0,"CAN_COLLIDE"];
				_target setVelocity [(random 6) - 3,(random 6) - 3,3 + random 3];
			};
		};

		SETINTELOBJECTATTR(_target,_arguments);

		switch (true) do {
			case (_target isKindOf "CaManBase") : {};
			case (typeOf _target IN _dropTypes) : {
				[format["MPSF_Intel_%1",_target call BIS_fnc_netID],_target,"Pickup INTEL",[ // TODO: Localise
					["mpsf\data\holdactions\holdAction_search_ca.paa",{
						missionNamespace setVariable ["MPSF_Action_intel_target",_target];
						_caller playAction "PutDown";
					}],["mpsf\data\holdactions\holdAction_search_ca.paa",{
						//
					}],{
						["onIntelPickup",[_caller,_arguments],0] call MPSF_fnc_triggerEventHandler;
						deleteVehicle _target;
						missionNamespace setVariable ["MPSF_Action_intel_target",nil];
					},{
						missionNamespace setVariable ["MPSF_Action_intel_target",nil];
					}
					,1,true],_arguments
					,"damage _target < 1"
						+ " && _this distance _target < 3"
						+ " || {!isNull(missionNamespace getVariable ['MPSF_Action_intel_target',objNull])}"
					,0,true
				] spawn {sleep 0.125; _this call MPSF_fnc_addAction;};
				["onIntelCreated",[_target,"intel"],0] call MPSF_fnc_triggerEventHandler;
			};
			case !(_target isKindOf "CaManBase");
			case (typeOf _target IN _downloadTypes) : {
				[format["MPSF_Intel_%1",_target call BIS_fnc_netID],_target,"Download INTEL",[ // TODO: Localise
					["mpsf\data\holdactions\holdAction_download_ca.paa",{
						missionNamespace setVariable ["MPSF_Action_intel_target",_target];
						_caller playAction "PutDown";
					}],["mpsf\data\holdactions\holdAction_download_ca.paa",{
						//
					}],{
						["onIntelDownloadStart",[_target,_caller,_arguments],0] call MPSF_fnc_triggerEventHandler;
						missionNamespace setVariable ["MPSF_Action_intel_target",nil];
					},{
						missionNamespace setVariable ["MPSF_Action_intel_target",nil];
					}
					,1,false],_arguments
					,"damage _target < 1"
						+ " && _this distance _target < 3"
						+ " || {!isNull(missionNamespace getVariable ['MPSF_Action_intel_target',objNull])}"
					,0,true
				] spawn {sleep 0.125; _this call MPSF_fnc_addAction;};
				//SETINTELOBJECT(_target,true);
				["onIntelCreated",[_target,"download"],0] call MPSF_fnc_triggerEventHandler;
			};
		};

		if (_target isKindOf "Land_DataTerminal_01_F") then {
			[_target,"red","orange","green"] call BIS_fnc_dataTerminalColor;
		};

		_target
	};
	case "onKilledDropIntel" : {
		_params params [["_units",[],[objNull,[]]],["_attributes",[],[[]]]];
		if (typeName _units isEqualTo typeName objNull) then { _units = [_units]; };
		{
			_x setVariable ["MPSF_INTEL_ATTRIBUTES",_attributes,true];
			_x addEventHandler ["Killed",{
				params ["_killed","_killer"];
				private _group = group _killed;
				if ({alive _x} count units(_group) == 0) then {
					private _attributes = _killed getVariable ["MPSF_INTEL_ATTRIBUTES",[]];
					[getPosATL _killed,_attributes] call MPSF_fnc_createIntel;
				};
				if (selectRandom [false,true]) then {
					_killed setVariable ["MPSF_INTEL_ATTRIBUTES",[],true];
				};
			}];
		} forEach _units;
		true;
	};
// 3D Hud
	case "addIntelBeacon" : {
		if (isServer) then {
			_params params [["_position",[0,0,0],[[],objNull,""]],["_displayText","",[""]],["_displayIcon","",[""]]];
			if (_position isEqualTo [0,0,0]) exitWith {};
			if (_position isEqualType "") then { _position = _position call BIS_fnc_position; };

			if !(_position isEqualType objNull) then {
				_position = [_position call BIS_fnc_position] call MPSF_fnc_createLogic;
			};

			if !(_displayText isEqualTo "") then {
				_position setVariable ["MPSF_Intel_VRtext_F",_displayText,true];
			};

			if !(_displayIcon isEqualTo "") then {
				_position setVariable ["MPSF_Intel_VRicon_F",_displayIcon,true];
			};
		};
	};
	case "removeIntelBeacon" : {
		_params params [["_position",[0,0,0],[[],objNull,""]]];

		if !(_position isEqualType objNull) exitWith {};

		_position setVariable ["MPSF_Intel_VRtext_F",nil,true];
		_position setVariable ["MPSF_Intel_VRicon_F",nil,true];

		true;
	};
// Initialise
	case "postInit" : {
		if (hasInterface) then {
			["MPSF_Intel_onIntelCreated_EH","onIntelCreated",{ ["onIntelCreated",_this] call MPSF_fnc_intel; }] call MPSF_fnc_addEventHandler;
			["MPSF_Intel_onIntelDownloadStart_EH","onIntelDownloadStart",{ ["onIntelDownloadStart",_this] call MPSF_fnc_intel; }] call MPSF_fnc_addEventHandler;
			["MPSF_Intel_onIntelDownloadStop_EH","onIntelDownloadStop",{ ["onIntelDownloadStop",_this] call MPSF_fnc_intel; }] call MPSF_fnc_addEventHandler;
			["MPSF_Intel_onIntelDownloadComplete_EH","onIntelDownloadComplete",{ ["onIntelDownloadComplete",_this] call MPSF_fnc_intel; }] call MPSF_fnc_addEventHandler;
			["MPSF_Intel_onIntelRecieve_EH","onIntelRecieve",{ ["onIntelRecieve",_this] call MPSF_fnc_intel; }] call MPSF_fnc_addEventHandler;
			["MPSF_Intel_onIntelPickup_EH","onIntelPickup",{ ["onIntelPickup",_this] call MPSF_fnc_intel; }] call MPSF_fnc_addEventHandler;
			["onEachFramIntelBeacon"] call MPSF_fnc_intel;
			["MPSF_Intel_VRbeacon_onEachFrame_EH","onEachFrame",{
				if (missionNamespace getVariable ["suspend3D",false]) exitWith {};
				private _pos = positionCameraToWorld [0,0,0];
				private _nearbyVRtargets = (nearestObjects [_pos,["All"],16]) select {!((_x getVariable ["MPSF_Intel_VRtext_F",""]) + (_x getVariable ["MPSF_Intel_VRicon_F",""]) isEqualTo "")};
				if !(surfaceIsWater _pos) then { _pos = ATLtoASL _pos; };
				{
					(boundingBoxReal _x) params ["_p1","_p2"];
					private _offset = (_p2 select 2) - (_p1 select 2);
					private _drawPos = _x modelToWorld [0,0,abs _offset];
					private _alpha = (0 max (1-(_pos distance2D _drawPos)/15) min 1);
					drawIcon3D [(_x getVariable ["MPSF_Intel_VRicon_F",ICONMOVE]),[1,1,1,_alpha],_drawPos,1.6,1.6,0,"",0];
					drawIcon3D [ICONEMPTY,[1,1,1,_alpha],_drawPos,0,-1,0,(_x getVariable ["MPSF_Intel_VRtext_F",""]),2,0.04,"RobotoCondensed"];
				} forEach _nearbyVRtargets;
			}] call MPSF_fnc_addEventHandler;
		};
	};
};