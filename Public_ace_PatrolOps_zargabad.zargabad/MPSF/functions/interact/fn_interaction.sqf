/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_interaction.sqf
	Author(s): see mpsf\credits.txt

	Description:
		INTERACTION Framework
*/
#include "\A3\ui_f\hpp\defineDIKCodes.inc"
params [["_mode","",[""]],["_params",[]]];

switch (_mode) do {
	/* On Select Action */
	case "onAddAction" : {
		_params params [
			["_actionID","",[""]]
			,["_object",objNull,[objNull]]
			,["_displayText","Interact",[""]]
			,["_script",{},[{},[]]]
			,["_arguments",[],[[]]]
			,["_condition","true",[""]]
			,["_draw3D",false,[false]]
		];
		if (isServer) then {
			private _globalActions = missionNamespace getVariable ["MPSF_InterAction_globalActions",[]];
			_globalActions pushBackUnique [_actionID,_object,_displayText,_script,_arguments,_condition,_draw3D];
			missionNamespace setVariable ["MPSF_InterAction_globalActions",_globalActions];
			publicVariable "MPSF_InterAction_globalActions";
		};
		if (hasInterface) then {
			private _localActions = missionNamespace getVariable ["MPSF_InterAction_localActions",[]];
			_localActions pushBackUnique [_actionID,_object,_displayText,_script,_arguments,_condition,_draw3D];
			missionNamespace setVariable ["MPSF_InterAction_localActions",_localActions];
			["addAction",_params] call MPSF_fnc_Interaction;
		};
	};
	case "addAction" : {
		_params params [
			["_actionID","",[""]]
			,["_object",objNull,[objNull]]
			,["_displayText","Interact",[""]]
			,["_script",{},[{},[]]]
			,["_arguments",[],[[]]]
			,["_condition","true",[""]]
			,["_draw3D",false,[false]]
			,["_priority",0,[0]]
		];

		if ((_object getVariable [_actionID,-1]) >= 0) exitWith {};

		private _type = if (_object == player) then {"Self"} else {"Else"};
		switch (true) do {
		//	case ([["ace_main"],false] call MPSF_fnc_checkMods) : { [format["ACE_addAction%1",_type],_params] call MPSF_fnc_Interaction; };
		//	case (isClass(configFile >> "CfgPatches" >> "cba_main_a3")) : { [format["CBA_addAction%1",_type],_params] call MPSF_fnc_Interaction; };
			case (typeName _script isEqualTo typeName []) : { ["BIS_addActionHold",_params] call MPSF_fnc_Interaction; };
			default { ["BIS_addAction",_params] call MPSF_fnc_Interaction; };
		};
	};
	case "onRemoveAction" : {
		_params params [["_actionID","",[""]],["_object",objNull,[objNull]]];

		if (isServer) then {
			private _globalActions = missionNamespace getVariable ["MPSF_InterAction_globalActions",[]];
			{
				if ((_x select 0) isEqualTo _actionID) exitWith { _globalActions deleteAt _forEachIndex; };
			} forEach _globalActions;
			missionNamespace setVariable ["MPSF_InterAction_globalActions",_globalActions];
			publicVariable "MPSF_InterAction_globalActions";
		};

		if (hasInterface) then {
			private _index = _object getVariable [_actionID,-1];
			if (_index >= 0) then {
				_object removeAction _index;
			};
			_object setVariable [_actionID,nil];
			private _localActions = missionNamespace getVariable ["MPSF_InterAction_localActions",[]];
			{
				if ((_x select 0) isEqualTo _actionID) exitWith { _localActions deleteAt _forEachIndex; };
			} forEach _localActions;
			missionNamespace setVariable ["MPSF_InterAction_localActions",_localActions];
		};
	};
	/* Interaction: BIS Menu */
	case "BIS_addAction" : {
		_params params [
			["_actionID","",[""]]
			,["_object",objNull,[objNull]]
			,["_displayText","Interact",[""]]
			,["_script",{},[{},[]]]
			,["_arguments",[],[[]]]
			,["_condition","true",[""]]
			,["_draw3D",false,[false]]
			,["_priority",100,[0]]

		];
		_object setVariable [_actionID,
			_object addAction [_displayText,_script,_arguments,_priority,true,true,"",_condition,15]
		,false];
	};
	case "BIS_addActionHold" : {
		_params params [
			["_actionID","",[""]]
			,["_object",objNull,[objNull]]
			,["_displayText","Interact",[""]]
			,["_script",{},[{},[]]]
			,["_arguments",[],[[],objNull]]
			,["_condition","true",[""]]
			,["_draw3D",false,[false]]
			,["_priority",100,[0]]
		];
		_script params [
			["_onStart",{},[[],{}]]
			,["_onProgress",{},[[],{}]]
			,["_codeCompleted",{},[{}]]
			,["_codeInterrupted",{},[{}]]
			,["_duration",5,[0]]
			,["_removeCompleted",false,[false]]
		];
		if !(typeName _onStart isEqualTo typeName []) then { _onStart = ["",_onStart]; };
		if !(typeName _onProgress isEqualTo typeName []) then { _onProgress = ["",_onProgress]; };
		_onStart params [["_holdIconStart","",[""]],["_codeStart",{},[{}]]];
		_onProgress params [["_holdIconProgress","",[""]],["_codeProgress",{},[{}]]];
		if (_codeProgress isEqualTo {}) then {
			_codeProgress = {
				private _progressTick = _this select 4;
				if (_progressTick % 2 == 0) exitwith {};
				playsound3d [((getarray (configfile >> "CfgSounds" >> "Orange_Action_Wheel" >> "sound")) param [0,""]) + ".wss",player,false,getposasl player,1,0.9 + 0.2 * _progressTick / 24];
			};
		};
		_object setVariable [_actionID,
			[_object,_displayText,_holdIconStart,_holdIconProgress,_condition,"true",_codeStart,_codeProgress,_codeCompleted,_codeInterrupted,_arguments,_duration,_priority,_removeCompleted] call BIS_fnc_holdActionAdd
		,false];
	};
	/* Interaction: ACE Menu */
	case "ACE_addActionElse" : {
		if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {
		//	http://forums.unitedoperations.net/index.php/topic/25042-ace-custom-interactions/
		//	_action = ["vip_brofist", "Brofist", "", {systemChat format["%1 does not wish to brofist.", name (_this select 0)]}, {true}] call ace_interact_menu_fnc_createAction;
		//	[typeOf player, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
		//	[bob, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
		};
	};
	case "ACE_addActionSelf" : {
		if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {
		//	_action = ["vip_cyanide", "Take Cyanide Capsule", "", {player setDamage 1}, {true}] call ace_interact_menu_fnc_createAction;
		//	[typeOf player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToClass;
		};
	};
	/* Interaction: CBA Menu */
	case "CBA_KeyBind" : {
		if (isClass(configFile >> "CfgPatches" >> "cba_main_a3")) then {
		//	["MPSF", "MyKey", ["My Pretty Key Name", "My Pretty Tool Tip"], { systemChat str _this; }, { systemChat str _this; }, [DIK_TAB, [false, false, false]]] call cba_fnc_addKeybind;
		//	["MPSF", "MyOtherKey", "My Other Pretty Key Name", { systemChat str _this; }, { systemChat str _this; }, [DIK_K, [false, false, false]]] call cba_fnc_addKeybind;
		//	["MPSF", "MyOtherKey2", "My Pretty Name", { systemChat str _this; }, { systemChat str _this; }, [DIK_SPACE, [false, false, false]]] call cba_fnc_addKeybind;
		};
	};
	case "init" : {
		if (hasInterface) then {
			{ ["addAction",_x] call MPSF_fnc_Interaction; } forEach (missionNamespace getVariable ["MPSF_Interaction_addActionServer",[]]);
			["MPSF_Interaction_onKilled_EH","onKilled",{
				[] spawn {
					waitUntil {!(isNull player) && alive player};
					{ ["addAction",_x] call MPSF_fnc_Interaction; } forEach (missionNamespace getVariable ["MPSF_InterAction_globalActions",[]]);
					{ ["addAction",_x] call MPSF_fnc_Interaction; } forEach (missionNamespace getVariable ["MPSF_InterAction_localActions",[]]);
				};
			}] call MPSF_fnc_addEventHandler;
			/*if ([["cba_main"],false] call MPSF_fnc_checkMods) then {
				["PatrolOps4","Amrel PDA"
					,["Open Amrel PDA","Access advanced features through the Amrel PDA"]
					,{["openDisplayRscAmrelDisplay",["AmrelPDA"]] call MPSF_UI_fnc_rscDisplayAmrelDevice;}
					,{}
					,[DIK_U,[false,false,false]]
				] call (missionNameSpace getVariable ["CBA_fnc_addKeybind",{false}]);
				["PatrolOps4","Amrel Tablet"
					,["Open Amrel Tablet","Access advanced features through the Amrel Tablet"]
					,{["openDisplayRscAmrelDisplay",["AmrelTablet"]] call MPSF_UI_fnc_rscDisplayAmrelDevice;}
					,{}
					,[DIK_U,[false,true,false]]
				] call (missionNameSpace getVariable ["CBA_fnc_addKeybind",{false}]);
			} else {
				["BIS_AmrelPDA_KEYDOWN","KeyDown",{
					params [["_display",displayNull],["_key",-1,[0]],["_shift",false,[false]],["_ctrl",false,[false]],["_alt",false,[false]]];
					if (_key in actionKeys "TeamSwitch" && !_shift && !_ctrl && !_alt) then {
						["openDisplayRscAmrelDisplay",["AmrelPDA"]] call MPSF_UI_fnc_rscDisplayAmrelDevice;
					};
				}] call MPSF_fnc_addEventHandler;
				["BIS_AmrelTablet_KEYDOWN","KeyDown",{
					params [["_display",displayNull],["_key",-1,[0]],["_shift",false,[false]],["_ctrl",false,[false]],["_alt",false,[false]]];
					if (_key in actionKeys "TeamSwitch" && !_shift && _ctrl && !_alt) then {
						["openDisplayRscAmrelDisplay",["AmrelTablet"]] call MPSF_UI_fnc_rscDisplayAmrelDevice;
					};
				}] call MPSF_fnc_addEventHandler;
			};*/
			// Replace body with BodyBag (LAWS DLC)
			[] call MPSF_fnc_actionBodyBag;
			// INTEL Body Searching
			[] call MPSF_fnc_actionBodySearch;
			// Vehicle Doors
			[] call MPSF_fnc_actionVehicleDoors;
		};
		["MPSF_Interaction_addAction_EH","onAddAction",{["onAddAction",_this] spawn MPSF_fnc_Interaction;}] call MPSF_fnc_addEventHandler;
		["MPSF_Interaction_remAction_EH","onRemoveAction",{["onRemoveAction",_this] spawn MPSF_fnc_Interaction;}] call MPSF_fnc_addEventHandler;
	};
};