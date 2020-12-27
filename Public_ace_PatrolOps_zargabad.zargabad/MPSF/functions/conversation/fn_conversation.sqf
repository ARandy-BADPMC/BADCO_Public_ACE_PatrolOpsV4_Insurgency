params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
// UI
	case "onLoadUI" : {
		disableSerialization;
		_params params ["_dialog"];

		uiNamespace setVariable ["MPSF_rscConversation_display",(_dialog)];
		{
			uiNamespace setVariable [(_x select 0),_dialog displayCtrl (_x select 1)];
		} forEach [
			 ["RscDisplayConversation_IDC_RESPONSE",1000]
			,["RscDisplayConversation_IDC_QUESTION",1001]
			,["RscDisplayConversation_IDC_QUESTIONFRAME",1002]
		];

		["updateUIConversation"] call MPSF_fnc_conversation;

		private _ctrlList = uiNamespace getVariable ["RscDisplayConversation_IDC_QUESTION",controlNull];
		_ctrlList ctrladdeventhandler ["lbselchanged",compile format ["disableSerialization; ['onActionListSelClick',_this] call MPSF_fnc_conversation;"]];
		_ctrlList ctrladdeventhandler ["lbdblclick",compile format ["disableSerialization; ['onActionListLbDblClick',_this] call MPSF_fnc_conversation;"]];
	};
	case "onActionListLbDblClick" : {
		_params params [["_ctrlList",controlNull,[controlNull]],["_index",-1,[0]]];
		if (_index >= 0) then {
			private _NPC = ["getUIConversationNPC"] call MPSF_fnc_conversation;
			private _CSID = ["getUIConversationSID",[_NPC]] call MPSF_fnc_conversation;
			if !(_CSID == (_ctrlList lbData _index)) then {
				["setUIConversationSID",[_NPC,_ctrlList lbData _index]] call MPSF_fnc_conversation;
				["updateUIConversation"] call MPSF_fnc_conversation;
			};
		};
	};
	case "updateUIConversation" : {
		disableSerialization;

		private _NPC = ["getUIConversationNPC"] call MPSF_fnc_conversation;
		private _CID = ["getUIConversationID",[_NPC]] call MPSF_fnc_conversation;
		private _CSID = ["getUIConversationSID",[_NPC]] call MPSF_fnc_conversation;
		private _attributes = uiNamespace getVariable ["MPSF_Conversation_var_Attr",[]];

		if (_CSID isEqualTo "") exitWith { hint "NONE"; };

		private _ctrlText = uiNamespace getVariable ["RscDisplayConversation_IDC_RESPONSE",controlNull];
		private _ctrlList = uiNamespace getVariable ["RscDisplayConversation_IDC_QUESTION",controlNull];
		private _ctrlFrame = uiNamespace getVariable ["RscDisplayConversation_IDC_QUESTIONFRAME",controlNull];
		private _csData = ["getCfgResponseActions",[_CID,_CSID,true]] call MPSF_fnc_conversation;

		private _responseData = ["getCfgResponse",[_CID,_CSID]] call MPSF_fnc_conversation;
		_responseData params ["_responseID","_displayText","_condition","_options","_arguments","_action","_endConversation"];

		private _arguments = ["processArguments",[_CID,_CSID]] call MPSF_fnc_conversation;
		_displayText = format ([_displayText] + _arguments);

		if !(_displayText isEqualTo "") then {
			_ctrlText ctrlSetStructuredText parseText _displayText;
		} else {
			_ctrlText ctrlSetStructuredText parseText "Stares Blankly..."; // TODO: localize;
		};
		_ctrlText ctrlCommit 0.2;

		private _ctrlPos = ctrlPosition _ctrlList;
		_ctrlPos set [3,0];
		_ctrlList ctrlSetPosition _ctrlPos;
		_ctrlList ctrlSetFade (if !(count _csData == 0) then { 0 } else { 1 });
		_ctrlList ctrlCommit 0;
		_ctrlFrame ctrlSetPosition _ctrlPos;
		_ctrlFrame ctrlSetFade (if !(count _csData == 0) then { 0 } else { 1 });
		_ctrlFrame ctrlCommit 0;

		lbClear _ctrlList;
		if (count _csData > 0) then {
			_ctrlList ctrlsetfontheight ((1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) * 0.8);
			{
				_x params ["_actionID","_actionText","_actionCondition","_actionResponses"];
				_actionText = format ([_actionText] + (_arguments));
				private _lbAdd = _ctrlList lbadd format ["%1",_actionText];
				_ctrlList lbSetData [_lbAdd,selectRandom _actionResponses];
			} forEach _csData;

			_ctrlPos = ctrlPosition _ctrlList;
			_ctrlPos set [3,(1 max (lbSize _ctrlList) min 8) * (1.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))];
			_ctrlList ctrlSetPosition _ctrlPos;
			_ctrlList ctrlCommit 0.2;
			_ctrlFrame ctrlSetPosition _ctrlPos;
			_ctrlFrame ctrlCommit 0.2;
		};

		if (count _action > 0) then {
			[_NPC,selectRandom _action] call MPSF_fnc_animateUnit;
		};

		private _code = ["getCfgResponseCode",[_CID,_CSID]] call MPSF_fnc_conversation;
		if !(_code isEqualTo "") then {
			[_NPC,player,(_NPC getVariable ["ConversationAttributes",[]])] call compile _code;
		};

		private _function = ["getCfgResponseFunction",[_CID,_CSID]] call MPSF_fnc_conversation;
		if !(_function isEqualTo "") then {
			[_NPC,player,(_NPC getVariable ["ConversationAttributes",[]])] call (missionNamespace getVariable [_function,{}]);
		};

		if (["getCfgResponseRemove",[_CID,_CSID]] call MPSF_fnc_conversation) then {
			[format ["MPSF_Conversation_%1_%2",_CID,_NPC call BIS_fnc_netId],_NPC] call MPSF_fnc_removeAction;
		};

		if (["getCfgResponseEnd",[_CID,_CSID]] call MPSF_fnc_conversation) then {
			[player,_NPC] spawn {
				uisleep 1;
				(uiNamespace getVariable ["MPSF_Conversation_DisplayID",displayNull]) closeDisplay 2;
				["onEndConversation",_this,0] call MPSF_fnc_triggerEventHandler;
			};
		};
	};
	case "openUI" : {
		disableSerialization;
		_params params [["_player",objNull,[objNull]],["_NPC",objNull,[objNull]],["_conversationID","",["",[]]],["_conversationSID","",["",[]]],["_attributes",[],[[]]]];

		if (isNull _NPC) exitWith { /*["Unable to retrieve NPC to begin conversation"] call BIS_fnc_error;*/ };
		if !(alive _NPC) exitWith {
			[parseText format ["<t align='center' size='1.2'>%1</t>","The dead do not speak to the living..."], [ // Todo: localize
				(safezoneW/2) - 10 * (((safezoneW / safezoneH) min 1.2) / 40) + safeZoneX
				,(safeZoneH / 2) + 8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safeZoneY
				,20 * (((safezoneW / safezoneH) min 1.2) / 40)
				,3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
			],nil,3,0.7,0] spawn BIS_fnc_textTiles;
		};

		_NPC setVariable ["Conversation",player,true];
		["setUIConversationNPC",[_NPC]] call MPSF_fnc_conversation;
		["setUIConversationID",[_NPC,_conversationID]] call MPSF_fnc_conversation;
		["setUIConversationSID",[_NPC,_conversationSID]] call MPSF_fnc_conversation;

		private _display = ([] call BIS_fnc_displayMission) createDisplay "RscDisplayConversation";
		waitUntil {!isNull _display};
		uiNamespace setVariable ["MPSF_Conversation_DisplayID",_display];

		missionNamespace setVariable ["suspend3D",true];

		["MPSF_Conversation_UI","onEachFrame",{
			private _target = ["getUIConversationNPC"] call MPSF_fnc_conversation;
			if !(isNull _target) then {
				private _selPos = _target selectionPosition "Pilot";
				if (_selPos distance [0,0,0] > 0) then {
					_selPos = [_selPos,[-0.3,0,0]] call BIS_fnc_vectorAdd;
					private _pos = _target modeltoworld _selPos;
					private _uiPos = worldToScreen _pos;
					if (_uiPos isEqualTypeArray [0,0]) then {
						private _ctrl = uiNamespace getVariable ["RscDisplayConversation_IDC_RESPONSE",controlNull];
						_ctrlPos = ctrlposition _ctrl;
						_ctrlPos set [0,(_uiPos select 0)];
						_ctrlPos set [1,(_uiPos select 1)];
						_ctrl ctrlsetposition _ctrlPos;
						_ctrl ctrlSetFade 0;
						_ctrl ctrlcommit 0;
					} else {
						_ctrl ctrlsetposition [-1,-1];
						_ctrl ctrlSetFade 1;
						_ctrl ctrlcommit 0;
					};
				};
			};
		}] call MPSF_fnc_addEventHandler;

		waitUntil {isNull _display || !alive player};

		missionNamespace setVariable ["suspend3D",false];
		["MPSF_Conversation_UI","onEachFrame"] call MPSF_fnc_removeEventHandler;
		["setUIConversationID",[_NPC,""]] call MPSF_fnc_conversation;
		["setUIConversationNPC",[objNull]] call MPSF_fnc_conversation;
		_NPC setVariable ["Conversation",nil,true];

		true;
	};
// Functions
	case "getUIConversationNPC" : {
		_params params [["_NPC",objNull,[objNull]]];
		missionNamespace getVariable ["MPSF_Conversation_var_NPC",objNull];
	};
	case "setUIConversationNPC" : {
		_params params [["_NPC",objNull,[objNull]]];
		missionNamespace setVariable ["MPSF_Conversation_var_NPC",_NPC];
	};
	case "getUIConversationID" : {
		_params params [["_NPC",objNull,[objNull]]];
		_NPC getVariable ["MPSF_Conversation_var_CID",""];
	};
	case "setUIConversationID" : {
		_params params [["_NPC",objNull,[objNull]],["_conversationID","",[""]]];
		_NPC setVariable ["MPSF_Conversation_var_CID",_conversationID];
	};
	case "getUIConversationSID" : {
		_params params [["_NPC",objNull,[objNull]]];
		_NPC getVariable ["MPSF_Conversation_var_CSID",""];
	};
	case "setUIConversationSID" : {
		_params params [["_NPC",objNull,[objNull]],["_conversationSID","",[""]]];
		_NPC setVariable ["MPSF_Conversation_var_CSID",_conversationSID];
	};
	case "processArguments" : {
		_params params [["_conversationID","",[""]],["_conversationSegmentID","",[""]]];
		private _arguments = ["getCfgResponseArguments",[_conversationID,_conversationSegmentID]] call MPSF_fnc_conversation;
		_arguments = _arguments apply { [_NPC,player,(_NPC getVariable ["ConversationAttributes",[]])] call compile _x; };
		_arguments;
	};
// Configuration
	case "getCfgStartPoints" : {
		_params params [["_conversationID","",[""]]];
		["CfgNPCConversari",_conversationID,"startPoints"] call MPSF_fnc_getCfgDataArray;
	};
	case "getCfgResumePoints" : {
		_params params [["_conversationID","",[""]]];
		["CfgNPCConversari",_conversationID,"resumePoints"] call MPSF_fnc_getCfgDataArray;
	};
	case "getCfgResponse" : {
		_params params [["_conversationID","",[""]],["_conversationSegmentID","",[""]]];
		[
			_conversationSegmentID
			,["CfgNPCConversari",_conversationID,_conversationSegmentID,"displayText"] call MPSF_fnc_getCfgDataText
			,["CfgNPCConversari",_conversationID,_conversationSegmentID,"condition"] call MPSF_fnc_getCfgDataText
			,["CfgNPCConversari",_conversationID,_conversationSegmentID,"options"] call MPSF_fnc_getCfgDataArray
			,["CfgNPCConversari",_conversationID,_conversationSegmentID,"arguments"] call MPSF_fnc_getCfgDataArray
			,["CfgNPCConversari",_conversationID,_conversationSegmentID,"action"] call MPSF_fnc_getCfgDataArray
			,["CfgNPCConversari",_conversationID,_conversationSegmentID,"endConversation"] call MPSF_fnc_getCfgDataBool
		]
	};
	case "getCfgResponseActions" : {
		_params params [["_conversationID","",[""]],["_conversationSegmentID","",[""]],["_resolve",false,[false]]];
		private _actions = ["CfgNPCConversari",_conversationID,_conversationSegmentID,"options"] call MPSF_fnc_getCfgDataArray;
		if (_resolve) then {
			_actions = _actions apply { ["getCfgAction",[_conversationID,_x]] call MPSF_fnc_conversation; };
		};
		_actions
	};
	case "getCfgActions" : {
		_params params [["_conversationID","",[""]],["_conversationSegmentID","",[""]],["_resolve",false,[false]]];
		private _actions = ["CfgNPCConversari",_conversationID,_conversationSegmentID,"actions"] call MPSF_fnc_getCfgDataArray;
		if (_resolve) then {
			_actions = _actions apply { ["getCfgAction",[_conversationID,_x]] call MPSF_fnc_conversation; };
		};
		_actions
	};
	case "getCfgAction" : {
		_params params [["_conversationID","",[""]],["_conversationSegmentID","",[""]]];
		[
			_conversationSegmentID
			,["CfgNPCConversari",_conversationID,_conversationSegmentID,"displayText"] call MPSF_fnc_getCfgDataText
			,["CfgNPCConversari",_conversationID,_conversationSegmentID,"condition"] call MPSF_fnc_getCfgDataText
			,["CfgNPCConversari",_conversationID,_conversationSegmentID,"responses"] call MPSF_fnc_getCfgDataArray
			,["CfgNPCConversari",_conversationID,_conversationSegmentID,"effect"] call MPSF_fnc_getCfgDataArray
			,["CfgNPCConversari",_conversationID,_conversationSegmentID,"action"] call MPSF_fnc_getCfgDataText
			,["CfgNPCConversari",_conversationID,_conversationSegmentID,"endConversation"] call MPSF_fnc_getCfgDataBool
		]
	};
	case "getCfgResponseArguments" : {
		_params params [["_conversationID","",[""]],["_conversationSegmentID","",[""]]];
		["CfgNPCConversari",_conversationID,_conversationSegmentID,"arguments"] call MPSF_fnc_getCfgDataArray;
	};
	case "getCfgResponseCode" : {
		_params params [["_conversationID","",[""]],["_conversationSegmentID","",[""]],["_resolve",false,[false]]];
		["CfgNPCConversari",_conversationID,_conversationSegmentID,"code"] call MPSF_fnc_getCfgDataText;
	};
	case "getCfgResponseFunction" : {
		_params params [["_conversationID","",[""]],["_conversationSegmentID","",[""]],["_resolve",false,[false]]];
		["CfgNPCConversari",_conversationID,_conversationSegmentID,"function"] call MPSF_fnc_getCfgDataText;
	};
	case "getCfgResponseRemove" : {
		_params params [["_conversationID","",[""]],["_conversationSegmentID","",[""]]];
		["CfgNPCConversari",_conversationID,_conversationSegmentID,"removeAction"] call MPSF_fnc_getCfgDataBool;
	};
	case "getCfgResponseEnd" : {
		_params params [["_conversationID","",[""]],["_conversationSegmentID","",[""]]];
		["CfgNPCConversari",_conversationID,_conversationSegmentID,"endConversation"] call MPSF_fnc_getCfgDataBool;
	};
// Actions
	case "addAction" : {
		_params params [["_NPC",objNull,[objNull]],["_conversationID","",[""]],["_attributes",[],[[]]]];

		if (isNull _NPC || _conversationID isEqualTo "") exitWith { false; };

		private _NPCname = name _NPC;

		// Access Vehicle Depot
		[
			format ["MPSF_Conversation_%1_%2",_conversationID,_NPC call BIS_fnc_netId]
			,_NPC
			,format["Speak With %1",if (_NPCname isEqualTo "") then {"Person"} else {_NPCname}] // TODO: localize
			,{ ["onStartConversation",([player,(_this select 0)] + (_this select 3)),0] call MPSF_fnc_triggerEventHandler; }
			,[_conversationID,_attributes]
			,"vehicle player isEqualTo player && _this distance _target < 4 && alive _target"
			,0
			,false
			,105
		] spawn {sleep (0.3 + random 3); _this call MPSF_fnc_addAction};

		["addIntelBeacon",[_NPC,"","\A3\ui_f\data\IGUI\Cfg\Actions\talk_ca.paa"]] call (missionNamespace getVariable ["MPSF_fnc_intel",{}]);

		_NPC allowFleeing 0;

		[group _NPC,position _NPC] call MPSF_fnc_setGroupHold;

		true;
	};
	case "removeAction" : {
		_params params [["_NPC",objNull,[objNull]],["_conversationID","",[""]],["_attributes",[],[[]]]];
		[format ["MPSF_Conversation_%1_%2",_conversationID,_NPC call BIS_fnc_netId],_NPC] call MPSF_fnc_removeAction;
	};
// Events
	case "onStartConversation" : {
		_params params [["_player",objNull,[objNull]],["_NPC",objNull,[objNull]],["_conversationID","",["",[]]],["_attributes",[],[[]]]];

		if !(isNull (_NPC getVariable ["Conversation",objNull])) exitWith {};

		if (local _NPC || isServer) then {
			_NPC forceSpeed 0;
			_NPC doWatch _player;
			_NPC setDir (getDir _player - 180);
			_NPC setVariable ["inConversation",true];
		};

		if (_player isEqualTo player) then {
			_NPC setVariable ["ConversationAttributes",_attributes,true];
			private _startConversation = if ((["getUIConversationSID",[_NPC]] call MPSF_fnc_conversation) isEqualTo "") then {
				["getCfgStartPoints",[_conversationID]] call MPSF_fnc_conversation;
			} else {
				["getCfgResumePoints",[_conversationID]] call MPSF_fnc_conversation;
			};

			if (count _startConversation isEqualTo 0) exitWith {
				["onEndConversation",[player,_NPC],0] call MPSF_fnc_triggerEventHandler;
			};

			_startConversation = selectRandom _startConversation;
			["openUI",[_player,_NPC,_conversationID,_startConversation,_attributes]] spawn MPSF_fnc_conversation;
		};
	};
	case "onEndConversation" : {
		_params params ["_player","_NPC"];
		if (local _NPC || isServer) then {
			_NPC setVariable ["inConversation",nil];
			_NPC forceSpeed -1;
		};
	};
};