#include "\A3\ui_f\hpp\defineDIKCodes.inc"
#include "\A3\Ui_f\hpp\defineResinclDesign.inc"

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
// Arsenal Integration
	case "buildControl" : {
		_params params [["_display",displayNull,[displayNull]],["_displayCtrl","",[""]]];

		if !(isNull _display) then {
			private _displayCtrls = [];
			private _ctrlAnchor = getArray(missionConfigFile >> _displayCtrl >> "position");
			{ _ctrlAnchor set [_foreachindex,call compile _x]; } forEach _ctrlAnchor;

			{
				private _ctrlName = configName _x;
				private _ctrlType = getText(_x >> "Type");
				private _ctrl = _display ctrlCreate [_ctrlType,86919 + _foreachindex];

				private _ctrlPos = getArray(_x >> "Position");
				{
					_ctrlPos set [_foreachindex,call compile _x];
				} forEach _ctrlPos;
				_ctrlPos = [
					(_ctrlAnchor select 0) + (_ctrlPos select 0)
					,(_ctrlAnchor select 1) + (_ctrlPos select 1)
					,(_ctrlPos select 2)
					,(_ctrlPos select 3)
				];
				_ctrl ctrlSetPosition _ctrlPos;

				if (isArray(_x >> "colorBackground")) then {
					private _colourBackground = getArray(_x >> "colorBackground");
					{ if (typeName _x isEqualTo typeName "") then { _colourBackground set [_foreachindex,call compile _x]; }; } forEach _colourBackground;
					_ctrl ctrlSetBackgroundColor _colourBackground
				};

				if (isText(_x >> "text")) then {
					_ctrl ctrlSetText getText(_x >> "text");
				};

				if (isText(_x >> "sizeEx")) then {
					_ctrl ctrlSetFontHeight (call compile getText (_x >> "sizeEx"));
				};

				if (isArray(_x >> "columns")) then {
					private _countCols = count (lnbGetColumnsPosition _ctrl);
					private _columns = getArray(_x >> "columns");
					if (count _columns > 3) then {
						for "_i" from 3 to (count _columns - 1) do {
							_ctrl lnbAddColumn (_columns select _i);
						};
					};
					_ctrl lnbSetColumnsPos _columns;
				};

				if (isText(_x >> "onLBSelChanged")) then {
					_ctrl ctrlAddEventHandler ["lbselchanged",getText(_x >> "onLBSelChanged")];
				};

				if (isText(_x >> "onButtonClick")) then {
					_ctrl ctrlAddEventHandler ["buttonclick",getText(_x >> "onButtonClick")];
				};

				_ctrl ctrlCommit 0;

				_displayCtrls pushBack _ctrl;
				uiNamespace setVariable [format["%1_%2",_displayCtrl,_ctrlName],_ctrl];
			} forEach ("isClass _x" configClasses (missionConfigFile >> _displayCtrl >> "controls"));

			uiNamespace setVariable [_displayCtrl,_displayCtrls];
		};
	};
	case "destroyControl" : {
		_params params [["_displayCtrl","",[""]]];
		{
			ctrlDelete _x;
		} forEach (uiNamespace getVariable [_displayCtrl,[]]);
	};
	case "onButtonRoleClick" : {
		if !(isNull (uiNamespace getVariable [format["%1_%2","RscDisplayUnitRoleSelect","ValueName"],controlNull])) exitWith {};
		private _display = uiNamespace getVariable ["RscDisplayVirtualArmouryDisplay",displayNull];
		["buildControl",[_display,"RscDisplayUnitRoleSelect"]] call MPSF_fnc_virtualArmoury;

		private _roles = ["getCfgRoles",[side group player,true]] call MPSF_fnc_virtualArmoury;
		private _currentRole = ["getUnitRole",[player]] call MPSF_fnc_virtualArmoury;
		private _ctrlListUnitRoles = uiNamespace getVariable [format["%1_%2","RscDisplayUnitRoleSelect","ValueName"],controlNull];
		lnbclear _ctrlListUnitRoles;
		private _selIndex = 0;
		{
			_x params ["_roleID","_sideID","_displayName","_icon","_limit","_crewman","_pilotHeli","_pilotPlane","_medic","_engineer","_explosiveSpecialist","_UAVHacker","_Halo"];

			private _countRoles = count (allPlayers select {(["getUnitRole",[_x]] call MPSF_fnc_virtualArmoury) isEqualTo _roleID});
			private _strCount = str _countRoles;
			if (_limit > 0 && _limit < 99) then { _strCount = _strCount + "/" + str _limit; };

			private _lbAdd = _ctrlListUnitRoles lnbaddrow [_displayName,"",_strCount];
			if !(_icon isEqualTo "") then {
				_ctrlListUnitRoles lnbsetpicture [[_lbAdd,0],_icon];
			};
			if (_currentRole isEqualTo _roleID) then {
				_ctrlListUnitRoles lnbsetcolor [[_lbAdd,0],[1,0.78,0,1]];
				_selIndex = _lbAdd;
			};
			if (_countRoles < _limit || _limit <= 0) then {
				_ctrlListUnitRoles lnbSetData [[_lbAdd,0],_roleID];
			} else {
				_ctrlListUnitRoles lnbSetData [[_lbAdd,0],""];
				_ctrlListUnitRoles lbsetvalue [_lbAdd,-1];
				_ctrlListUnitRoles lnbsetcolor [[_lbAdd,0],[1,1,1,0.25]];
			};
		} forEach _roles;
		_ctrlListUnitRoles lbSetCurSel _selIndex;
	};
	case "onListRoleSelect" : {
		_params params [["_ctrlList",controlNull,[controlNull]]];
		uiNamespace setVariable ["PO4_VirtualArmoury_var_selectedRole",_ctrlList lnbData [lnbCurSelRow _ctrlList,0]]
	};
	case "onButtonOkClick" : {
		_params params [["_displayID","",[""]],["_display",uiNamespace getVariable ["RscDisplayVirtualArmouryDisplay",displayNull]]];
		private _roleID = uiNamespace getVariable ["PO4_VirtualArmoury_var_selectedRole",(["getUnitRole",[player]] call MPSF_fnc_virtualArmoury)];

		if (_roleID isEqualTo "") exitWith {
			["showMessage",[
				uiNamespace getVariable ["RscDisplayVirtualArmouryDisplay",displayNull]
				,"That role is unavailable to request and assign" // TODO localize
			]] call BIS_fnc_arsenal;
		};

		private _countRoles = count (allPlayers select {(["getUnitRole",[_x]] call MPSF_fnc_virtualArmoury) isEqualTo _roleID});
		private _roleLimit = ["getCfgRoleLimit",[_roleID]] call MPSF_fnc_virtualArmoury;
		if !(_countRoles < _roleLimit) exitWith {
			["showMessage",[
				uiNamespace getVariable ["RscDisplayVirtualArmouryDisplay",displayNull]
				,"That role has reached its limit of players" // TODO localize
			]] call BIS_fnc_arsenal;
		};

		private _assignState = ["getCfgAssignRoles"] call MPSF_fnc_virtualArmoury;
		if (_assignState <= 0) exitWith {
			["showMessage",[
				uiNamespace getVariable ["RscDisplayVirtualArmouryDisplay",displayNull]
				,"Unable to request or assign roles during a mission" // TODO localize
			]] call BIS_fnc_arsenal;
		};

		["onRoleRequest",[player,_roleID],0] call MPSF_fnc_triggerEventHandler;

		if !(isNull _display) then {
			_display closedisplay 2;
		};
	};
	case "arsenalOpened" : {
		_params params [["_display",displayNull,[displayNull]],["_index",false,[false]]];

		uiNamespace setVariable ["RscDisplayVirtualArmouryDisplay",_display];

		private _ctrlButtonInterface = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONINTERFACE;
		private _ctrlButtonRandom = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONRANDOM;
		_ctrlButtonRandom ctrlRemoveAllEventHandlers "buttonclick";
		_ctrlButtonRandom ctrlSetText "";
		_ctrlButtonRandom ctrlSetTooltip "";
		_ctrlButtonRandom ctrlEnable false;

		/*private _ctrlButtonSave = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONSAVE;
		_ctrlButtonSave ctrlRemoveAllEventHandlers "buttonclick";
		_ctrlButtonSave ctrlSetText "";
		_ctrlButtonSave ctrlSetTooltip "";
		_ctrlButtonSave ctrlEnable false;*/

		/*private _ctrlButtonLoad = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONLOAD;
		_ctrlButtonLoad ctrlRemoveAllEventHandlers "buttonclick";
		_ctrlButtonLoad ctrlSetText "";
		_ctrlButtonLoad ctrlSetTooltip "";
		_ctrlButtonLoad ctrlEnable false;*/

		/*private _ctrlButtonExport = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONEXPORT;
		_ctrlButtonExport ctrlRemoveAllEventHandlers "buttonclick";
		_ctrlButtonExport ctrlSetText "";
		_ctrlButtonExport ctrlSetTooltip "";
		_ctrlButtonExport ctrlEnable true;*/

		private _ctrlButtonImport = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONIMPORT;
		_ctrlButtonImport ctrlRemoveAllEventHandlers "buttonclick";
		_ctrlButtonImport ctrlSetText "";
		_ctrlButtonImport ctrlSetTooltip "";
		_ctrlButtonImport ctrlEnable false;

		private _ctrlButtonOK = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONOK;
		_ctrlButtonOK ctrlRemoveAllEventHandlers "buttonclick";
		_ctrlButtonOK ctrlAddEventhandler ["buttonclick",format ["with missionNamespace do { disableSerialization; ['onButtonRoleClick',['init']] call MPSF_fnc_virtualArmoury; };"]];
		_ctrlButtonOK ctrlSetText "Available Roles";
		_ctrlButtonOK ctrlSetTooltip "View and Request a New Role";
		_ctrlButtonOK ctrlEnable true;

		private _ctrl = _display ctrlCreate ["RscPictureKeepAspect",-1];
		_ctrl ctrlSetPosition [
			(safezoneW/2) - 7.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safeZoneX)
			,0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safeZoneY)
			,15 * (((safezoneW / safezoneH) min 1.2) / 40)
			,8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
		];
		(date call BIS_fnc_sunriseSunsetTime) params ["_min","_max"];
		if ((date select 3) > _min && (date select 3) < _max) then {
			_ctrl ctrlSetText "mpsf\data\titles\patrolops_banner_b_co.paa";
		} else {
			_ctrl ctrlSetText "mpsf\data\titles\patrolops_banner_co.paa";
			_intensity = 1;
			_light = "#lightpoint" createvehicle position player;
			_light setLightBrightness _intensity;
			_light setLightAmbient [1,1,1];
			_light setLightColor [0,0,0];
			_light lightAttachObject [player,[0,0,-_intensity * 7]];
			missionNamespace setVariable ["MPSF_VirtualArmoury_lightpoint",_light];
		};
		_ctrl ctrlSetFade 0.2;
		_ctrl ctrlCommit 0;
	};
	case "arsenalClosed" : {
		uiNamespace setVariable ["RscDisplayVirtualArmouryDisplay",nil];
		private _light = missionNamespace getVariable ["MPSF_VirtualArmoury_lightpoint",objNull];
		if !(isNull _light) then {deleteVehicle _light;};
	};
// Role/Loadout Functions
	case "onRoleRequest" : {
		_params params [["_target",objNull,[objNull]],["_roleID","",[""]]];

		private _assignState = ["getCfgAssignRoles"] call MPSF_fnc_virtualArmoury;
		private _cleared = switch (_assignState) do {
			case 1 : { ([player] call MPSF_fnc_isAdmin) }; // Admin Only
			case 2 : { ([player] call MPSF_fnc_isAdmin) || (player isEqualTo leader group _target) }; // Admin & Squad Leaders
			default { false };
		};

		if (_cleared || !(isMultiplayer)) then {
			private _countRoles = count (allPlayers select {(["getUnitRole",[_x]] call MPSF_fnc_virtualArmoury) isEqualTo _roleID});
			private _roleLimit = ["getCfgRoleLimit",[_roleID]] call MPSF_fnc_virtualArmoury;
			if !(_countRoles < _roleLimit) exitWith {};

			if (_target isEqualTo player || local _target) exitWith {
				["setUnitRole",[_target,_roleID]] call MPSF_fnc_virtualArmoury;
			};

			["VirtualArmoury_RoleRequest",[
				name _target
				,["getCfgRoleDisplayName",[_roleID]] call MPSF_fnc_virtualArmoury
			]] call BIS_fnc_showNotification;
		};
	};
	case "getUnitRole" : {
		_params params [["_target",objNull,[objNull]]];
		_target getVariable ["MPSF_VirtualArmoury_Role","Rifleman"];
	};
	case "setUnitRole" : {
		_params params [["_target",objNull,[objNull]],["_roleID","",[""]]];

		if !(local _target) exitWith {};

		private _availableRoles = (["CfgRoles"] call BIS_fnc_getCfgSubClasses) apply {toLower _x};
		if !(toLower _roleID in _availableRoles) exitWith { /*["Unknown Role ID"] call BIS_fnc_error;*/ false };

		private _countRoles = count (allPlayers select {(["getUnitRole",[_x]] call MPSF_fnc_virtualArmoury) isEqualTo _roleID});
		private _roleLimit = ["getCfgRoleLimit",[_roleID]] call MPSF_fnc_virtualArmoury;
		if !(_countRoles < _roleLimit) exitWith {
			if (hasInterface) then {
				["VirtualArmoury_RoleLimitReached",[
					["getCfgRoleDisplayName",[_roleID]] call MPSF_fnc_virtualArmoury
				]] call BIS_fnc_showNotification;
			};
			false;
		};

		if (_target isEqualTo player) then {
			private _display = uiNamespace getVariable ["RscDisplayVirtualArmouryDisplay",displayNull];
			if !(isNull _display) then { _display closedisplay 2; };
		};

		_target setVariable ["MPSF_VirtualArmoury_Role",_roleID,true];

		["setRoleVirtualCargo",[(["getArmouryLogics"] call MPSF_fnc_virtualArmoury),_roleID]] call MPSF_fnc_virtualArmoury;

		private _roleData = ["getCfgRoleData",[_roleID]] call MPSF_fnc_virtualArmoury;
		{
			switch (_foreachindex) do {
				//case 0 : {}; // ID - Do Nothing
				//case 1 : {}; // Side - Do nothing
				//case 2 : {}; // DisplayName - Do Nothing
				//case 3 : {}; // Icon - Do Nothing
				//case 4 : {}; // Limit - Do Nothing
				case 5 : { [_target,"crewman",_x] call MPSF_fnc_setUnitTrait; };
				case 6 : { [_target,"pilotHeli",_x] call MPSF_fnc_setUnitTrait; };
				case 7 : { [_target,"pilotPlane",_x] call MPSF_fnc_setUnitTrait; };
				case 8 : { [_target,"medic",_x] call MPSF_fnc_setUnitTrait; };
				case 9 : { [_target,"engineer",_x] call MPSF_fnc_setUnitTrait; };
				case 10 : { [_target,"explosiveSpecialist",_x] call MPSF_fnc_setUnitTrait; };
				case 11 : { [_target,"UAVHacker",_x] call MPSF_fnc_setUnitTrait; };
				case 12 : { [_target,"HALO",_x] call MPSF_fnc_setUnitTrait; };
			};
		} forEach _roleData;

		["VirtualArmoury_RoleAssigned",[
			name _target
			,["getCfgRoleDisplayName",[_roleID]] call MPSF_fnc_virtualArmoury
		]] call BIS_fnc_showNotification;

		true;
	};
	case "checkVehicleRole" : {
		_params params [["_target",objNull,[objNull]],["_vehicle",objNull,[objNull]]];

		if (_target IN assignedCargo _vehicle) exitWith { true };

		private _accessExempt = ["getCfgVehicleAccess"] call MPSF_fnc_virtualArmoury;
		if ({ _vehicle isKindOf _x } count _accessExempt > 0) exitWith { true };

		switch (true) do {
			case (_vehicle isKindOf "Helicopter") : { [_target,"pilotHeli"] call MPSF_fnc_getUnitTrait; };
			case (_vehicle isKindOf "Plane") : { [_target,"pilotPlane"] call MPSF_fnc_getUnitTrait; };
			case (_vehicle isKindOf "Tank") : { [_target,"crewman"] call MPSF_fnc_getUnitTrait; };
			default { true };
		};
	};
	case "setRoleVirtualCargo" : {
		_params params [["_ammoboxes",(["getArmouryLogics"] call MPSF_fnc_virtualArmoury),[objNull,[],missionNamespace]],["_roleID","",[""]]];

		if !(_ammoboxes isEqualType []) then { _ammoboxes = [_ammoboxes]; };

		private _items = ["getCfgRoleLoadout",[_roleID,"items"]] call MPSF_fnc_virtualArmoury;
		private _weapons = ["getCfgRoleLoadout",[_roleID,"weapons"]] call MPSF_fnc_virtualArmoury;
		private _magazines = ["getCfgRoleLoadout",[_roleID,"magazines"]] call MPSF_fnc_virtualArmoury;
		private _backpacks = ["getCfgRoleLoadout",[_roleID,"backpacks"]] call MPSF_fnc_virtualArmoury;

		if (count _magazines == 0) then {
			{
				if (getnumber (_x >> "type") > 0 && {(getnumber (_x >> "scope") == 2 || getnumber (_x >> "scopeArsenal") == 2)}) then {
					_magazines pushBackUnique configname _x;
				};
			} foreach ("isclass _x" configclasses (configfile >> "cfgmagazines"));
		};

		{
			private _ammobox = _x;

			// Clear Existing Cargo
			if (_ammobox isEqualType objNull) then {
				clearWeaponCargoGlobal _ammobox;
				clearItemCargoGlobal _ammobox;
				clearBackpackCargoGlobal _ammobox;
				clearMagazineCargoGlobal _ammobox;
			};
			[_ammobox,(_ammobox call BIS_fnc_getVirtualItemCargo)] call BIS_fnc_removeVirtualItemCargo;
			[_ammobox,(_ammobox call BIS_fnc_getVirtualWeaponCargo)] call BIS_fnc_removeVirtualWeaponCargo;

			// Add Gear to Ammobox
			if (count _items > 0) then { [_ammobox,_items,false,false,1,0] call BIS_fnc_addVirtualItemCargo; };
			if (count _weapons > 0) then { [_ammobox,_weapons,false,false,1,1] call BIS_fnc_addVirtualItemCargo; };
			if (count _magazines > 0) then { [_ammobox,_magazines,false,false,1,2] call BIS_fnc_addVirtualItemCargo; };
			if (count _backpacks > 0) then { [_ammobox,_backpacks,false,false,1,3] call BIS_fnc_addVirtualItemCargo; };
		} forEach _ammoboxes;

		true;
	};
// Loadout Role Point
	case "createLoadoutAction" : {
		_params params [["_logic",objNull,[objNull]],["_loadout","",[""]]];
		if (isServer) then {
			_logic setVariable ["MPSF_VirtualArmoury_LoadoutPoint",true,true];
		};
		if (hasInterface) then {
			if (isNull _logic) exitWith { /*["%1",_logic] call BIS_fnc_error;*/ };
			if !(isNull (_logic getVariable ["MPSF_VirtualArmoury_LoadoutPoint_Trigger",objNull])) exitWith {};

			private _trigger = createTrigger ["EmptyDetector",_logic,false];
			_trigger setTriggerArea [4,4,getDir _logic,false];
			_trigger setTriggerActivation ["ANYPLAYER","PRESENT",true];
			_trigger setTriggerStatements ["(vehicle player) in thisList"
				,format["['activateActionLoadoutPoint',[thisTrigger,thisList]] call MPSF_fnc_virtualArmoury;"]
				,format["['deactivateActionLoadoutPoint',[thisTrigger]] call MPSF_fnc_virtualArmoury;"]
			];
			_trigger attachTo [_logic,[0,0,0]];
			_logic setVariable ["MPSF_VirtualArmoury_LoadoutPoint_Trigger",_trigger];
			if !(_loadout isEqualTo "") then {
				_logic setVariable ["MPSF_VirtualArmoury_LoadoutPoint_Loadout",_loadout,true];
			};
			["setRoleVirtualCargo",[["getArmouryLogics"] call MPSF_fnc_virtualArmoury]] call MPSF_fnc_virtualArmoury;
		};
		if (typeName _logic isEqualTo typeName objNull) then {
			clearWeaponCargoGlobal _logic;
			clearItemCargoGlobal _logic;
			clearBackpackCargoGlobal _logic;
			clearMagazineCargoGlobal _logic;
		};
		[_logic,(_logic call BIS_fnc_getVirtualItemCargo)] call BIS_fnc_removeVirtualItemCargo;
		[_logic,true,true] call BIS_fnc_removeVirtualWeaponCargo;
	};
	case "activateActionLoadoutPoint" : {
		_params params [["_trigger",objNull],["_list",[],[[]]]];

		if !(player in _list) exitWith {};

		private _logic = attachedTo _trigger;
		player setVariable ["ArmouryLogic",_logic];
		// Set Loadout Action
		if !(isNil {_logic getVariable "MPSF_VirtualArmoury_LoadoutPoint_Loadout"}) then {
			["MPSF_VirtualArmoury_LoadoutPoint_Action",player,"Assign Virtual Loadout",[
				["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
				,["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
				,{ ["Open",[(["getCfgFullArmoury"] call MPSF_fnc_virtualArmoury),_logic]] call BIS_fnc_arsenal; }
				,{}
				,0.5,false,101
			],[],"speed vehicle player isEqualTo 0 && vehicle player isEqualTo player"
			,true] spawn {sleep 0.1; _this call MPSF_fnc_addAction;};
		} else {
			["MPSF_VirtualArmoury_LoadoutPoint_Action",player,"Access Virtual Armoury",[
				["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
				,["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
				,{ ["Open",[
					(["getCfgFullArmoury"] call MPSF_fnc_virtualArmoury)
					|| (["getCfgRoleFullLoadout",[(["getUnitRole",[player]] call MPSF_fnc_virtualArmoury)]] call MPSF_fnc_virtualArmoury)
					,(player getVariable ["ArmouryLogic",objNull])
				]] call BIS_fnc_arsenal; }
				,{}
				,0.5,false,101
			],[],"speed vehicle player isEqualTo 0 && vehicle player isEqualTo player"
			,true] spawn {sleep 0.1; _this call MPSF_fnc_addAction;};
		};
	};
	case "deactivateActionLoadoutPoint" : {
		["MPSF_VirtualArmoury_LoadoutPoint_Action",player] call MPSF_fnc_removeAction;
	};
// Configuration
	case "getArmouryLogics" : { (allMissionObjects "All") select { _x getVariable ["MPSF_VirtualArmoury_LoadoutPoint",false]; }; };
	case "getCfgAssignRoles" : { ["CfgVirtualArmoury","assignRoles"] call MPSF_fnc_getCfgDataNumber; };
	case "getCfgFullArmoury" : { ["CfgVirtualArmoury","enableFullArmoury"] call MPSF_fnc_getCfgDataBool; };
	case "getCfgVehicleAccess" : { ["CfgVirtualArmoury","enableVehicleAccess"] call MPSF_fnc_getCfgDataArray; };
	case "getCfgLoadout" : {
		_params params [["_roleID",typeOf player,[""]]];
		private _cfgLoadout = configNull;
		{
			if (isClass(_x >> _roleID)) exitWith {
				_cfgLoadout = (_x >> _roleID);
			};
		} forEach [
			//(missionConfigFile >> "CfgVirtualArmoury" >> "Roles"),
			(missionConfigFile >> "CfgRoles"),
			(missionConfigFile >> "CfgRespawnInventory"),
			(configFile >> "CfgVehicles")
		];
		_cfgLoadout
	};
	case "getCfgRoles" : {
		_params params [["_sideID",side group player,[0,sideUnknown]],["_resolve",false,[false]]];
		if !(_sideID isEqualType 0) then { _sideID = _sideID call BIS_fnc_sideID; };
		private _roles = (["CfgRoles"] call BIS_fnc_getCfgSubClasses) select { private _roleSideID = ["getCfgRoleSideID",[_x]] call MPSF_fnc_virtualArmoury; _roleSideID < 0 || _roleSideID isEqualTo _sideID };
		if (_resolve) then {
			_roles = _roles apply { ["getCfgRoleData",[_x]] call MPSF_fnc_virtualArmoury; };
		};
		_roles;
	};
	case "getCfgRoleData" : {
		_params params [["_roleID","",[""]]];
		[
			_roleID
			,["getCfgRoleSideID",[_roleID]] call MPSF_fnc_virtualArmoury
			,["getCfgRoleDisplayName",[_roleID]] call MPSF_fnc_virtualArmoury
			,["getCfgRoleIcon",[_roleID]] call MPSF_fnc_virtualArmoury
			,["getCfgRoleLimit",[_roleID]] call MPSF_fnc_virtualArmoury
			,["getCfgRoleTrait",[_roleID,"crewman"]] call MPSF_fnc_virtualArmoury
			,["getCfgRoleTrait",[_roleID,"pilotHeli"]] call MPSF_fnc_virtualArmoury
			,["getCfgRoleTrait",[_roleID,"pilotPlane"]] call MPSF_fnc_virtualArmoury
			,["getCfgRoleTrait",[_roleID,"medic"]] call MPSF_fnc_virtualArmoury
			,["getCfgRoleTrait",[_roleID,"engineer"]] call MPSF_fnc_virtualArmoury
			,["getCfgRoleTrait",[_roleID,"explosiveSpecialist"]] call MPSF_fnc_virtualArmoury
			,["getCfgRoleTrait",[_roleID,"UAVHacker"]] call MPSF_fnc_virtualArmoury
			,["getCfgRoleTrait",[_roleID,"halo"]] call MPSF_fnc_virtualArmoury
		]
	};
	case "getCfgRoleSideID" : {
		_params params [["_roleID","",[""]]];
		["CfgRoles",_roleID,"side"] call MPSF_fnc_getCfgDataNumber;
	};
	case "getCfgRoleDisplayName" : {
		_params params [["_roleID","",[""]]];
		["CfgRoles",_roleID,"displayName"] call MPSF_fnc_getCfgDataText;
	};
	case "getCfgRoleIcon" : {
		_params params [["_roleID","",[""]]];
		["CfgRoles",_roleID,"icon"] call MPSF_fnc_getCfgDataText;
	};
	case "getCfgRoleLimit" : {
		_params params [["_roleID","",[""]]];
		private _limit = ["CfgRoles",_roleID,"limit"] call MPSF_fnc_getCfgDataNumber;
		if (_limit <= 0) then { _limit = 1e3; };
		_limit;
	};
	case "getCfgRoleTrait" : {
		_params params [["_roleID","",[""]],["_trait","",[""]]];
		private _traits = (["CfgRoles",_roleID,"traits"] call MPSF_fnc_getCfgDataArray) apply {toLower _x};
		(toLower _trait) in _traits
	};
	case "getCfgRoleCrewman" : {
		_params params [["_roleID","",[""]]];
		["getCfgRoleTrait",[_roleID,"crewman"]] call MPSF_fnc_virtualArmoury;
	};
	case "getCfgRolePilotHeli" : {
		_params params [["_roleID","",[""]]];
		["getCfgRoleTrait",[_roleID,"pilotHeli"]] call MPSF_fnc_virtualArmoury;
	};
	case "getCfgRolePilotPlane" : {
		_params params [["_roleID","",[""]]];
		["getCfgRoleTrait",[_roleID,"pilotPlane"]] call MPSF_fnc_virtualArmoury;
	};
	case "getCfgRoleMedic" : {
		_params params [["_roleID","",[""]]];
		["getCfgRoleTrait",[_roleID,"medic"]] call MPSF_fnc_virtualArmoury;
	};
	case "getCfgRoleEngineer" : {
		_params params [["_roleID","",[""]]];
		["getCfgRoleTrait",[_roleID,"engineer"]] call MPSF_fnc_virtualArmoury;
	};
	case "getCfgRoleExplosiveSpecialist" : {
		_params params [["_roleID","",[""]]];
		["getCfgRoleTrait",[_roleID,"explosiveSpecialist"]] call MPSF_fnc_virtualArmoury;
	};
	case "getCfgRoleUAVHacker" : {
		_params params [["_roleID","",[""]]];
		["getCfgRoleTrait",[_roleID,"UAVHacker"]] call MPSF_fnc_virtualArmoury;
	};
	case "getCfgRoleHALO" : {
		_params params [["_roleID","",[""]]];
		["getCfgRoleTrait",[_roleID,"halo"]] call MPSF_fnc_virtualArmoury;
	};
	case "getCfgRoleFullLoadout" : {
		_params params [["_roleID","",[""]]];
		["CfgRoles",_roleID,"fullArmoury"] call MPSF_fnc_getCfgDataBool;
	};
	case "getCfgRoleLoadout" : {
		_params params [["_roleID","",[""]],["_type","",[""]]];
		private _cfgLoadout = missionConfigFile >> "CfgRoles" >> _roleID >> "Armoury";

		private _typeNames = [];
		{
			if !((configName _x) find _type < 0) then {
				{
					_typeNames pushBackUnique _x;
				} forEach getArray(_x);
			};
		} foreach configProperties [_cfgLoadout,"true",true];

		switch (_type) do {
			case "items" : {
				private _uniforms = ["getCfgRoleLoadout",[_roleID,"gear"]] call MPSF_fnc_virtualArmoury;
				{ _typeNames pushBackUnique _x; } forEach _uniforms;
				{ _typeNames pushBackUnique _x; } forEach getArray (_cfgLoadout >> "linkedItems");

				if (isText(_cfgLoadout >> "uniformClass")) then {
					_typeNames pushBackUnique getText(_cfgLoadout >> "uniformClass");
				};

				if (isText(_cfgLoadout >> "uniform")) then {
					_typeNames pushBackUnique getText(_cfgLoadout >> "uniform");
				};
			};
			case "backpacks" : {
				if (isText(_cfgLoadout >> "backpack")) then {
					_typeNames pushBackUnique getText(_cfgLoadout >> "backpack");
				};
			};
			case "weapons" : {
				_typeNames = _typeNames apply { _x call BIS_fnc_baseWeapon; };
			};
		};
		_typeNames select {!(_x isEqualTo "")};
	};
// Event Handlers
	case "eventHandlers" : {
		["MPSF_VirtualArmoury_onRoleRequest_EH","onRoleRequest",{
			["onRoleRequest",_this] call MPSF_fnc_virtualArmoury;
		}] call MPSF_fnc_addEventHandler;

		["MPSF_VirtualArmoury_onRoleAssign_EH","onRoleAssign",{
			["setUnitRole",_this] call MPSF_fnc_virtualArmoury;
		}] call MPSF_fnc_addEventHandler;

		["MPSF_VirtualArmoury_onLoadoutPointAdd_EH","onLoadoutPointAdd",{
			["createLoadoutAction",_this] call MPSF_fnc_virtualArmoury;
		}] call MPSF_fnc_addEventHandler;

		if (hasInterface) then {
			["MPSF_VirtualArmoury_arsenalOpened_EH","arsenalOpened",{
				["arsenalOpened",_this] call MPSF_fnc_virtualArmoury;
			}] call MPSF_fnc_addEventHandler;

			["MPSF_VirtualArmoury_arsenalClosed_EH","arsenalClosed",{
				["arsenalClosed"] call MPSF_fnc_virtualArmoury;
				[player,"arsenal"] call MPSF_fnc_getUnitLoadout;
			}] call MPSF_fnc_addEventHandler;

			["MPSF_VirtualArmoury_onKilled_EH","onKilled",{
				[player,"VirtualInventoryKilled"] call MPSF_fnc_getUnitLoadout;
			}] call MPSF_fnc_addEventHandler;

			["MPSF_VirtualArmoury_onKilled_EH","onRespawn",{
				[player,"VirtualInventoryKilled"] call MPSF_fnc_setUnitLoadout;
			}] call MPSF_fnc_addEventHandler;

			["MPSF_VirtualArmoury_onGetIn_EH","onGetIn",{
				params [["_target",objNull,[objNull]],["_vehicleRole","",[""]],["_vehicle",objNull,[objNull]],["_turret",[],[[]]]];
				if !(["checkVehicleRole",[_target,_vehicle]] call MPSF_fnc_virtualArmoury) then {
					_target action ["getOut",_vehicle];
					_vehicle engineOn false;
					["VirtualArmoury_RoleFailed"] call BIS_fnc_showNotification;
				};
			}] call MPSF_fnc_addEventHandler;

			["MPSF_VirtualArmoury_onSeatSwitch_EH","onSeatSwitch",{
				params [["_target",objNull,[objNull]],["_role","",[""]],["_vehicle",objNull,[objNull]]];
				if !(["checkVehicleRole",[_target,_vehicle]] call MPSF_fnc_virtualArmoury) then {
					if !(_target moveInCargo _vehicle) then {
						_target action ["getOut",_vehicle];
					};
					["VirtualArmoury_RoleFailed"] call BIS_fnc_showNotification;
				};
			}] call MPSF_fnc_addEventHandler;
		};
	};
// Init
	case "postInit" : {
		{
			["createLoadoutAction",[_x]] call MPSF_fnc_virtualArmoury;
		} forEach (["getArmouryLogics"] call MPSF_fnc_virtualArmoury);
		["eventHandlers"] call MPSF_fnc_virtualArmoury;
	};
};