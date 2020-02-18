/*
	Virtual Vehicle Depot with Dynamic Aircraft Loadout Editor (DALE)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_virtualDepot.sqf
	Author(s): TBD

	Description:
		Vehice Framework supporting the creation and modification of vehicles in-game

	TODO:
		- Vehicle Volume Limitations
		- IDEA from [CTB]FLOYDII for Carrier Ops
			- Limited vehicle inventory due to carrier
			- Limited weapons armoury due to carrier
			- Airframe Varients draw from same pool
*/

#define MARKER_SIZE 		0.65
#define COLOURWHITE			[1,1,1,1]
#define COLOURTEAL			[1,0.3,0.3,0.7]
#define ICONEMPTY			"#(argb,8,8,3)color(0,0,0,0)"
#define ICONBACK			"\a3\ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa"
#define ICONREFUEL			"\a3\ui_f\data\IGUI\Cfg\Actions\refuel_ca.paa"
#define ICONRELOAD			"\a3\ui_f\data\IGUI\Cfg\Actions\reload_ca.paa"
#define ICONREPAIR			"\a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa"
#define ICONADD				"\a3\ui_f\data\GUI\Rsc\RscDisplayArsenal\cargoMisc_ca.paa"
#define ICONPOINTER			"\A3\ui_f\data\IGUI\Cfg\simpleTasks\interaction_pointer2_ca.paa"
#define ICONSELECTORF		"\A3\ui_f\data\map\groupicons\selector_selectedFriendly_ca.paa"
#define MISSIONTIME			(if (isMultiplayer) then {serverTime} else {time})

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
// UI
	case "ctrlListSelect" : {
		disableSerialization;
		_params params [["_ctrlList",controlNull,[controlNull]]];

		private _depotLogic = uiNamespace getVariable ["MPSF_activeDepotLogic",objNull];
		if (isNull _depotLogic) exitWith {
			/*["Unable to retrieve depot logic attached to trigger"] call BIS_fnc_error;*/
			["closeDepotUI"] call MPSF_fnc_virtualDepot;
		};

		private _cursel = lbcursel _ctrlList;
		if (_cursel < 0) exitwith {};

		private _center = ["getTargetCenter"] call MPSF_fnc_virtualDepot;
		private _initVehicle = false;
		private _idc = ctrlIDC _ctrlList;
		private _lbData = (_ctrlList) lbData _cursel;
		private _index = _ctrlList lbvalue _cursel;
		private _checkboxTextures = [
			tolower gettext (configfile >> "RscCheckBox" >> "textureUnchecked"),
			tolower gettext (configfile >> "RscCheckBox" >> "textureChecked")
		];

		switch (_idc) do {
			case 6101; // Car
			case 6102; // Tank
			case 6103; // Helicopter
			case 6104; // Plane
			case 6105 : { // Navel
				private _data = _depotLogic getVariable ["vehicles",[]];
				private _vehicleData = (_data select (_idc - 6101)) select _index;
				_vehicleData params [["_model","",[""]],["_vehicleClassArray",[],[[]]]];

				private _isUAV = false;
				private _isMHQ = !((_model find "MHQ") < 0);
				_vehicleClassArray = _vehicleClassArray apply { (configFile >> "CfgVehicles" >> _x) };
				_vehicleClassArray = _vehicleClassArray select {
					if (getnumber (_x >> "isUAV") == 1) then {
						_isUAV = true;
						getNumber(_x >> "side") isEqualTo ((side group player) call BIS_fnc_sideID)
					} else {
						true
					};
				};

				if (count _vehicleClassArray == 0) exitWith {
					if (_isUAV) then {
						["No Friendly UAV varients found for that type so cannot proceed with creating the UAV"] call BIS_fnc_error;
					} else {
						["No valid vehicle classnames available to create"] call BIS_fnc_error;
					};
				};

				private _cfg = (_vehicleClassArray select 0);
				private _className = configName _cfg;
				private _centerType = if !(simulationenabled _center && _center isKindOf "AllVehicles") then {""} else {typeOf _center};
				private _centerPos = getPosWorld _depotLogic;
				private _centerDir = getDir _depotLogic;

				if (_className != _centerType || !alive _center) then {
					_center setPosASL [0,0,1000];
					deleteVehicle _center;
					_center = createVehicle [_className,[0,0,1100],[],0,"CAN_COLLIDE"];
					["allowDamage",[_center,false]] call MPSF_fnc_virtualDepot;
					["setVehiclePosition",[_center,_depotLogic]] call MPSF_fnc_virtualDepot;
					["vehicleLock",[_center,2]] call MPSF_fnc_virtualDepot;
					["clearVehicleCargo",[_center]] call MPSF_fnc_virtualDepot;
					["setTargetCenter",[_center]] call MPSF_fnc_virtualDepot;
					["setMHQ",[_center,_isMHQ]] call MPSF_fnc_virtualDepot;
					_center setVehicleTIPars [0.5,0.5,0.5];
					if (count (["getPylonsMags",[_center]] call MPSF_fnc_virtualDepot) > 0) then {
						["clearPylonLoadout",[_center]] call MPSF_fnc_virtualDepot;
						["startDrawHardpoints"] call MPSF_fnc_virtualDepot;
					} else {
						["MPSF_VehicleDepot_pylonEdit_onEachFrame_EH","onEachFrame"] call MPSF_fnc_removeEventHandler;
					};
				};

				["ctrlListPylonUpdate",[_center]] call MPSF_fnc_virtualDepot;
				["ctrlListAnimUpdate",[_center]] call MPSF_fnc_virtualDepot;
				["ctrlListTextureUpdate",[_center]] call MPSF_fnc_virtualDepot;

				//["ShowItemInfo",[_center]] call MPSF_fnc_virtualDepot;
				//["ShowItemStats",[_center]] call MPSF_fnc_virtualDepot;

				["ctrlTabsShow"] call MPSF_fnc_virtualDepot;
				["ctrlMenuButtonEnabled"] call MPSF_fnc_virtualDepot;
			};
			case 6106 : { // Pylon Loadout
				private _pylon = ["getTargetCenterPylon"] call MPSF_fnc_virtualDepot;
				if (_pylon < 0) exitWith {
					["ctrlButtonSelect",[11,[0]]] call MPSF_fnc_virtualDepot;
				};
				private _magazine = _ctrlList lbdata _cursel;
				private _compatible = ["isPylonMagCompatible",[_center,_pylon,_magazine]] call MPSF_fnc_virtualDepot;
				private _ignoreCompatible = !(["getCfgCompatiblePylons"] call MPSF_fnc_virtualDepot);
				if (_compatible || _ignoreCompatible) then {
					["setPylonMagPercent",[_center,_pylon,_magazine,1]] call MPSF_fnc_virtualDepot;
				};
				["ctrlTabSelectRight",[0]] call MPSF_fnc_virtualDepot;
				["ctrlListPylonCompatible"] call MPSF_fnc_virtualDepot;
			};
			case 6107 : { // Animations
				private _selected = _checkboxTextures find (_ctrlList lbPicture _cursel);
				private _selected = _center animationphase (_ctrlList lbdata _cursel);
				_ctrlList lbSetPicture [_cursel,_checkboxTextures select ((_selected + 1) % 2)];
				_initVehicle = true;
			};
			case 6108 : { // Textures
				private _selected = _checkboxTextures find (_ctrlList lbpicture _cursel);
				for "_i" from 0 to (lbsize _ctrlList - 1) do {
					_ctrlList lbSetPicture [_i,_checkboxTextures select 0];
				};
				_ctrlList lbSetPicture [_cursel,_checkboxTextures select 1];
				_initVehicle = true;
			};
		};
		if (_initVehicle) then {
			private _ctrlListTextures = (uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlListTexture",controlNull]);
			private _ctrlListAnimations = (uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlListAnim",controlNull]);
			private _textures = "";
			for "_i" from 0 to (lbsize _ctrlListTextures - 1) do {
				if ((_ctrlListTextures lbpicture _i) == (_checkboxTextures select 1)) exitwith { _textures = [_ctrlListTextures lbdata _i,1]; };
			};
			private _animations = [];
			for "_i" from 0 to (lbsize _ctrlListAnimations - 1) do {
				_animations pushback (_ctrlListAnimations lbdata _i);
				_animations pushback (_checkboxTextures find (_ctrlListAnimations lbpicture _i));
			};
			["onUpdateVehicleInit",[_center,_textures,_animations],0] call MPSF_fnc_triggerEventHandler;
		};
	};
	case "ctrlButtonSelect" : {
		_params params [["_index",0,[0]],["_data",[],[[]]]];
		switch (_index) do {
			case 0; // Tab Car
			case 1; // Tab Tank
			case 2; // Tab Helicopter
			case 3; // Tab Plane
			case 4 : {
				["ctrlTabSelectLeft",[_index]] call MPSF_fnc_virtualDepot;
				["ctrlTabSelectRight",[-1]] call MPSF_fnc_virtualDepot;
			}; // Tab Naval
			case 5; // Tab Pylon
			case 6; // Tab Animation
			case 7 : { // Tab Texture
				["ctrlTabSelectLeft",[-1]] call MPSF_fnc_virtualDepot;
				["ctrlTabSelectRight",[_index-5]] call MPSF_fnc_virtualDepot;
			};
			case 8 : { // Deploy Vehicle
				private _center = ["getTargetCenter"] call MPSF_fnc_virtualDepot;
				if (["checkVehicleRole",[player,_center]] call (missionNamespace getVariable ["MPSF_fnc_virtualArmoury",{true}])) then {
					["deployCenter"] call MPSF_fnc_virtualDepot;
				} else {
					["showMessage",["Unqualified to use vehicle"]] call MPSF_fnc_virtualDepot;
				};
			};
			case 9 : {}; // Save Config
			case 10 : {}; // Load Config
			case 11 : { // Select Pylon
				["setTargetCenterPylon",_data] call MPSF_fnc_virtualDepot;
				["ctrlListPylonCompatible"] call MPSF_fnc_virtualDepot;
				["ctrlTabSelectLeft",[-1]] call MPSF_fnc_virtualDepot;
				["ctrlTabSelectRight",[0]] call MPSF_fnc_virtualDepot;
			};
			case 12 : { // Service Vehicle
				private _center = ["getTargetCenter"] call MPSF_fnc_virtualDepot;
				if !(isNull _center) then {
					_center setDamage 0;
					_center setFuel 1;
					["syncWeaponLoadout",[_center]] call MPSF_fnc_virtualDepot;
					systemChat "Vehicle Repaired, Refueled and Primary Weapons Rearmed.";
					["ctrlMenuButtonEnabled"] call MPSF_fnc_virtualDepot;
				};
			};
			default {
				["ctrlTabSelectLeft",[-1]] call MPSF_fnc_virtualDepot;
				["ctrlTabSelectRight",[-1]] call MPSF_fnc_virtualDepot;
			};
		};
		true;
	};
	case "ctrlMenuButtonEnabled" : {
		private _center = ["getTargetCenter"] call MPSF_fnc_virtualDepot;
		private _isDeployable = !(["isDeployed",[_center]] call MPSF_fnc_virtualDepot);
		private _hasPylons = count (["getPylonsMags",[_center]] call MPSF_fnc_virtualDepot) > 0;

		(["getCfgVehicleLimits",[typeOf _center]] call MPSF_fnc_virtualDepot) params ["_currentCount","_limit"];
		private _isNotLimited = true;// _limit < 0 || _currentCount < _limit;

		private _vehicleBtn = uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlMenuVehicle",controlNull];
		private _vehicleBtnText = if (_isDeployable) then { "Deploy Vehicle"; } else { "Redeploy Vehicle"; }; // TODO localize
		_vehicleBtn ctrlSetText _vehicleBtnText;
		_vehicleBtn ctrlEnable (!(isNull _center) && _isNotLimited);
		_vehicleBtn ctrlCommit 0;
		_vehicleBtn ctrlRemoveAllEventHandlers "buttonClick";
		_vehicleBtn ctrlAddEventHandler ["buttonclick",compile "['ctrlButtonSelect',[8]] call MPSF_fnc_virtualDepot;"];

		private _serviceBtn = uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlMenuVehicleService",controlNull];
		_serviceBtn ctrlEnable (!(isNull _center) && {(["getDamage",[_center]] call MPSF_fnc_virtualDepot) > 0.1 || fuel _center < 1 || !canMove _center});
		_serviceBtn ctrlCommit 0;
		_serviceBtn ctrlRemoveAllEventHandlers "buttonClick";
		_serviceBtn ctrlAddEventHandler ["buttonclick",compile "['ctrlButtonSelect',[12]] call MPSF_fnc_virtualDepot;"];
	};
	case "ctrlTabsShow" : {
		_params params [["_show",false,[false]],["_showLeft",false,[false]],["_showRight",false,[false]]];

		private _depotLogic = uiNamespace getVariable ["MPSF_activeDepotLogic",objNull];
		if (isNull _depotLogic) exitWith {
			/*["Unable to retrieve depot logic attached to trigger"] call BIS_fnc_error;*/
			["closeDepotUI"] call MPSF_fnc_virtualDepot;
		};

		private _center = ["getTargetCenter"] call MPSF_fnc_virtualDepot;
		private _show = !(isNull _center);
		private _showPylons = _show && (count (["getPylonsMags",[_center]] call MPSF_fnc_virtualDepot) > 0) && !(["getCfgDepotPylonInteraction"] call MPSF_fnc_virtualDepot);
		private _showAnim = _show && count(configproperties [configFile >> "CfgVehicles" >> typeOf _center >> "animationSources","isclass _x && getText(_x >> 'displayName') != """"",true]) > 0;
		private _showTextures = _show && count(configproperties [configFile >> "CfgVehicles" >> typeOf _center >> "textureSources","isclass _x",true]) > 0;

		private _tabsLeft = [
			"RscDisplayVehicle_IDC_CtrlTabCar"
			,"RscDisplayVehicle_IDC_CtrlTabTank"
			,"RscDisplayVehicle_IDC_CtrlTabHeli"
			,"RscDisplayVehicle_IDC_CtrlTabPlane"
			,"RscDisplayVehicle_IDC_CtrlTabNavel"
		];

		private _textLeft = [
			"RscDisplayVehicle_IDC_CtrlTextCar"
			,"RscDisplayVehicle_IDC_CtrlTextTank"
			,"RscDisplayVehicle_IDC_CtrlTextHeli"
			,"RscDisplayVehicle_IDC_CtrlTextPlane"
			,"RscDisplayVehicle_IDC_CtrlTextNavel"
		];

		private _tabsRight = [
			["RscDisplayVehicle_IDC_CtrlTabCrew",_showPylons]
			,["RscDisplayVehicle_IDC_CtrlTabAnim",_showAnim]
			,["RscDisplayVehicle_IDC_CtrlTabTexture",_showTextures]
		];

		private _tabPosLeft = [
			uiNamespace getVariable ["RscDisplayVehicle_POS_CtrlTabCar",[0,0,0,0]]
			,uiNamespace getVariable ["RscDisplayVehicle_POS_CtrlTabTank",[0,0,0,0]]
			,uiNamespace getVariable ["RscDisplayVehicle_POS_CtrlTabHeli",[0,0,0,0]]
			,uiNamespace getVariable ["RscDisplayVehicle_POS_CtrlTabPlane",[0,0,0,0]]
			,uiNamespace getVariable ["RscDisplayVehicle_POS_CtrlTabNavel",[0,0,0,0]]
		];

		private _textPositions = [
			uiNamespace getVariable ["RscDisplayVehicle_POS_CtrlTextCar",[0,0,0,0]]
			,uiNamespace getVariable ["RscDisplayVehicle_POS_CtrlTextTank",[0,0,0,0]]
			,uiNamespace getVariable ["RscDisplayVehicle_POS_CtrlTextHeli",[0,0,0,0]]
			,uiNamespace getVariable ["RscDisplayVehicle_POS_CtrlTextPlane",[0,0,0,0]]
			,uiNamespace getVariable ["RscDisplayVehicle_POS_CtrlTextNavel",[0,0,0,0]]
		];

		private _tabPosRight = [
			uiNamespace getVariable ["RscDisplayVehicle_POS_CtrlTabCrew",[0,0,0,0]]
			,uiNamespace getVariable ["RscDisplayVehicle_POS_CtrlTabAnim",[0,0,0,0]]
			,uiNamespace getVariable ["RscDisplayVehicle_POS_CtrlTabTexture",[0,0,0,0]]
		];

		private _vehicles = _depotLogic getVariable ["vehicles",[]];
		private _index = 0;
		{
			private _ctrlTab = uiNamespace getVariable [(_tabsLeft select _forEachIndex),controlNull];
			private _ctrlText = uiNamespace getVariable [(_textLeft select _forEachIndex),controlNull];
			private _ctrlTextPos = ctrlPosition _ctrlText;
			if (count (_vehicles param [_forEachIndex,[],[[]]]) > 0) then {
				_ctrlTab ctrlSetPosition (_tabPosLeft select _index);
				_ctrlText ctrlSetPosition (_textPositions select _index);
				_index = _index + 1;
			} else {
				_ctrlTab ctrlSetPosition [0,0,0,0];
				_ctrlText ctrlSetPosition [0,0,0,0];
			};
			_ctrlTab ctrlCommit 0;
			_ctrlText ctrlCommit 0;
		} forEach _tabsLeft;

		private _index = 0;
		{
			private _ctrlTab = uiNamespace getVariable [(_tabsRight select _forEachIndex) select 0,controlNull];
			private _ctrlShow = (_tabsRight select _forEachIndex) select 1;
			_ctrlTab ctrlEnable _ctrlShow;
			_ctrlTab ctrlSetFade (if (_ctrlShow) then {0} else {1});
			if (_ctrlShow) then {
				_ctrlTab ctrlSetPosition (_tabPosRight select _index);
				_index = _index + 1;
			} else {
				_ctrlTab ctrlSetPosition [0,0,0,0];
			};
			_ctrlTab ctrlCommit 0;
		} forEach _tabsRight;

		["ctrlTabSelectRight",[-1]] call MPSF_fnc_virtualDepot;
	};
	case "ctrlTabSelectLeft" : {
		_params params [["_index",-1,[0]]];

		private _tabsLeft = [
			"RscDisplayVehicle_IDC_CtrlTabCar"
			,"RscDisplayVehicle_IDC_CtrlTabTank"
			,"RscDisplayVehicle_IDC_CtrlTabHeli"
			,"RscDisplayVehicle_IDC_CtrlTabPlane"
			,"RscDisplayVehicle_IDC_CtrlTabNavel"
		];
		private _listLeft = [
			"RscDisplayVehicle_IDC_CtrlListCar"
			,"RscDisplayVehicle_IDC_CtrlListTank"
			,"RscDisplayVehicle_IDC_CtrlListHeli"
			,"RscDisplayVehicle_IDC_CtrlListPlane"
			,"RscDisplayVehicle_IDC_CtrlListNavel"
		];
		private _textLeft = [
			"RscDisplayVehicle_IDC_CtrlTextCar"
			,"RscDisplayVehicle_IDC_CtrlTextTank"
			,"RscDisplayVehicle_IDC_CtrlTextHeli"
			,"RscDisplayVehicle_IDC_CtrlTextPlane"
			,"RscDisplayVehicle_IDC_CtrlTextNavel"
		];

		private _ctrlTabBg = uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlTabsBg",controlNull];
		private _ctrlTabBgPos = uiNamespace getVariable ["RscDisplayVehicle_POS_CtrlTabsBg",[0,0,0,0]];
		if (_index >= 0) then {
			private _ctrlTab = uiNamespace getVariable [(_tabsLeft select _index),controlNull];
			private _ctrlTabPos = ctrlPosition _ctrlTab;
			_ctrlTabBgPos set [1,(_ctrlTabPos select 1)];
			_ctrlTabBg ctrlSetPosition _ctrlTabBgPos;
			_ctrlTabBg ctrlCommit 0.15;
			_ctrlTabBg ctrlCommit 0.15;
		} else {
			_ctrlTabBg ctrlSetPosition [0,0,0,0];
			_ctrlTabBg ctrlCommit 0;
		};

		private _ctrlList = controlNull;
		if (_index >= 0) then {
			_ctrlList = uiNamespace getVariable [(_listLeft select _index),controlNull];
			if (ctrlFade _ctrlList < 1) then {
				_ctrlList ctrlEnable false;
				_ctrlList ctrlSetFade 1;
				_ctrlList ctrlCommit 0;
				_ctrlList = controlNull;
			} else {
				_ctrlList ctrlEnable true;
				_ctrlList ctrlSetFade 0;
				_ctrlList ctrlCommit 0;
			};
		};

		{
			private _ctrlListTemp = uiNamespace getVariable [(_listLeft select _x),controlNull];
			_ctrlListTemp ctrlEnable false;
			_ctrlListTemp ctrlSetFade 1;
			_ctrlListTemp ctrlCommit 0;
		} forEach ([0,1,2,3,4] - [_index]);

		private _ctrlFrame = uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlTabsFrame",controlNull];
		_ctrlFrame ctrlEnable false;
		_ctrlFrame ctrlSetFade (if !(isNull _ctrlList) then {0} else {1});
		_ctrlFrame ctrlCommit 0;

		{
			private _ctrlTextTemp = uiNamespace getVariable [(_x),controlNull];
			_ctrlTextTemp ctrlEnable (_index >= 0);
			_ctrlTextTemp ctrlSetFade (if !(isNull _ctrlList) then {1} else {0});
			_ctrlTextTemp ctrlCommit 0;
		} forEach _textLeft;

		!(isNull _ctrlList);
	};
	case "ctrlTabSelectRight" : {
		_params params [["_index",-1,[0]]];
		private _tabsRight = [
			"RscDisplayVehicle_IDC_CtrlTabCrew"
			,"RscDisplayVehicle_IDC_CtrlTabAnim"
			,"RscDisplayVehicle_IDC_CtrlTabTexture"
		];

		private _listRight = [
			"RscDisplayVehicle_IDC_CtrlListCrew"
			,"RscDisplayVehicle_IDC_CtrlListAnim"
			,"RscDisplayVehicle_IDC_CtrlListTexture"
		];

		private _listBtn = ["RscDisplayVehicle_IDC_CtrlBtnPylonOwner"];

		{
			private _ctrlListTemp = uiNamespace getVariable [(_listRight select _x),controlNull];
			_ctrlListTemp ctrlEnable false;
			_ctrlListTemp ctrlSetFade 1;
			_ctrlListTemp ctrlCommit 0;
		} forEach ([0,1,2] - [_index]);

		if (_index >= 0) then {
			private _ctrlList = uiNamespace getVariable [(_listRight select _index),controlNull];
			_ctrlList ctrlEnable true;
			_ctrlList ctrlSetFade 0;
			_ctrlList ctrlCommit 0;
		};

		private _ctrlPylonButton = uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlBtnPylonOwner",controlNull];
		_ctrlPylonButton ctrlEnable (_index == 0);
		_ctrlPylonButton ctrlSetFade (ctrlFade (uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlListCrew",controlNull]));
		_ctrlPylonButton ctrlCommit 0;
		if (_index == 0) then {
			private _pylonOwner = ["getPylonOwner"] call MPSF_fnc_virtualDepot;
			_ctrlPylonButton ctrlSetText format ["Owner: %1",if (_pylonOwner isEqualTo []) then {"Pilot"} else {"Gunner"}];
			_ctrlPylonButton ctrlAddEventHandler ["ButtonClick",{
				["togglePylonOwner"] call MPSF_fnc_virtualDepot;
				private _pylonOwner = ["getPylonOwner"] call MPSF_fnc_virtualDepot;
				(_this select 0) ctrlSetText format ["Owner: %1",if (_pylonOwner isEqualTo []) then {"Pilot"} else {"Gunner"}]; // TODO: localize
			}];
		} else {
			_ctrlPylonButton ctrlSetEventHandler ["ButtonClick",""];
		};
	};
	case "ctrlVehicleListUpdate" : {
		_params params [["_depotLogic",(uiNamespace getVariable ["MPSF_activeDepotLogic",objNull]),[objNull]]];
		if (isNull _depotLogic) exitWith {
			/*["Unable to retrieve depot logic attached to trigger"] call BIS_fnc_error;*/
			["closeDepotUI"] call MPSF_fnc_virtualDepot;
		};

		//private _funds = [player] call (missionNamespace getVariable ["PO4_fnc_getCoinFunds",{0}]);
		private _listLeft = [
			"RscDisplayVehicle_IDC_CtrlListCar"
			,"RscDisplayVehicle_IDC_CtrlListTank"
			,"RscDisplayVehicle_IDC_CtrlListHeli"
			,"RscDisplayVehicle_IDC_CtrlListPlane"
			,"RscDisplayVehicle_IDC_CtrlListNavel"
		];

		{
			_vehicles = _x;
			private _ctrlList = uiNamespace getVariable [(_listLeft select _forEachIndex),controlNull];
			lbClear _ctrlList;
			_ctrlList ctrlsetfontheight (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8);

			for "_i" from 0 to (count _vehicles - 1) step 1 do {
				private _vehicleArray = _vehicles select _i;
				_vehicleArray params ["_model","_modelData"];

				/*private _cost = [_className,0] call (missionNamespace getVariable ["PO4_fnc_getCoinCost",{0}]);
				private _lbAdd = _ctrlList lbAdd format ["%1%2",_displayName,if(_cost > 0) then {format [" - $%1",_cost]} else {""}];
				if (_cost <= _funds) then {
					_ctrlList lbSetData [_lbAdd,_className];
				} else {
					_ctrlList lbSetColor [_lbAdd,[1,1,1,0.5]];
					_ctrlList lbSetData [_lbAdd,""];
				};*/

				private _modelExample = (configFile >> "CfgVehicles" >> (_modelData select 0));
				private _displayName = gettext (_modelExample >> "displayName");
				if !(_model find "MHQ" < 0) then { _displayName = _displayName + " (MHQ)"; };

				(["getCfgVehicleLimits",[_modelExample]] call MPSF_fnc_virtualDepot) params ["_currentCount","_limit"];
				if !(_limit < 0) then {
					_displayName = format ["%1 %2/%3",_displayName,_currentCount,_limit];
				};

				private _lbAdd = _ctrlList lbadd _displayName;
				_ctrlList lbsetpicture [_lbAdd,gettext (_modelExample >> "picture")];
				_ctrlList lbsetdata [_lbAdd,_model];
				_ctrlList lbsetvalue [_lbAdd,_i];
				_ctrlList lbsettooltip [_lbAdd,_displayName];

				private _addons = configsourceaddonlist _modelExample;
				if (count _addons > 0) then {
					_dlcs = configsourcemodlist (configfile >> "CfgPatches" >> _addons select 0);
					if (count _dlcs > 0) then {
						_ctrlList lbsetpictureright [_lbAdd,gettext (configfile >> "cfgMods" >> (_dlcs select 0) >> "logo")];
					};
				};
			};
			lbsort _ctrlList;
		} foreach (_depotLogic getVariable ["vehicles",[]]);
	};
	case "ctrlListPylonUpdate" : {
		private _depotLogic = uiNamespace getVariable ["MPSF_activeDepotLogic",objNull];
		if (isNull _depotLogic) exitWith {
			/*["Unable to retrieve depot logic attached to trigger"] call BIS_fnc_error;*/
			["closeDepotUI"] call MPSF_fnc_virtualDepot;
		};
		private _center = ["getTargetCenter"] call MPSF_fnc_virtualDepot;
		private _checkboxTextures = [
			tolower gettext (configfile >> "RscCheckBox" >> "textureUnchecked"),
			tolower gettext (configfile >> "RscCheckBox" >> "textureChecked")
		];

		private _availableMags = [["","- Empty",true]];
		private _allPylonMagazines = "getNumber (_x >> 'scope') isEqualTo 2" configClasses (configfile >> "CfgMagazines");
		{
			private _magID = configName _x;
			_allPylonMagazines set [_forEachIndex,[
				_magID
				,((configfile >> "CfgMagazines" >> _magID >> "displayName") call MPSF_fnc_getCfgDataText)
				,((configfile >> "CfgMagazines" >> _magID >> "hardpoints") call MPSF_fnc_getCfgDataArray) apply { toLower _x }
			]];
		} forEach _allPylonMagazines;

		if (["getCfgCompatiblePylons"] call MPSF_fnc_virtualDepot) then {
			private _pylonHardpoints = (["getCfgHardPoints",[_center]] call MPSF_fnc_virtualDepot) apply {toLower _x};
			_allPylonMagazines = _allPylonMagazines select { count (_pylonHardpoints arrayIntersect (_x select 2)) > 0};
		};
		_availableMags append _allPylonMagazines;

		private _ctrlListPylonMags = uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlListCrew",controlNull];
		lbclear _ctrlListPylonMags;
		{
			_x params ["_magClass","_magName","_magHardpoints"];
			if (_magName != "") then {
				private _lbAdd = _ctrlListPylonMags lbAdd _magName;
				_ctrlListPylonMags lbSetData [_lbAdd,_magClass];
				_ctrlListPylonMags lbSetPicture [_lbAdd,_checkboxTextures select 0];
			};
		} foreach (_availableMags);
		_ctrlListPylonMags ctrlsetfontheight (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8);
		lbsort _ctrlListPylonMags;
	};
	case "ctrlListPylonCompatible" : {
		private _checkboxTextures = [
			tolower gettext (configfile >> "RscCheckBox" >> "textureUnchecked"),
			tolower gettext (configfile >> "RscCheckBox" >> "textureChecked")
		];
		private _compatibleTextures = [
			"\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca",
			"\a3\ui_f\data\IGUI\Cfg\Actions\ico_ON_ca.paa"
		];
		private _center = ["getTargetCenter"] call MPSF_fnc_virtualDepot;
		private _pylonID = ["getTargetCenterPylon"] call MPSF_fnc_virtualDepot;
		private _pylonMag = (["getPylonMag",[_center,_pylonID,true]] call MPSF_fnc_virtualDepot) select 0;

		private _ctrlList = uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlListCrew",controlNull];
		private _ctrlSize = lbSize _ctrlList;
		if (_ctrlSize > 1) then {
			for "_i" from 1 to (_ctrlSize - 1) do {
				private _magazine = _ctrlList lbData _i;
				if (_pylonMag isEqualTo _magazine) then {
					_ctrlList lbSetPicture [_i,_checkboxTextures select 1];
				} else {
					_ctrlList lbSetPicture [_i,_checkboxTextures select 0];
				};
				private _compatible = ["isPylonMagCompatible",[_center,_pylonID,_magazine]] call MPSF_fnc_virtualDepot;
				private _ignoreCompatible = !(["getCfgCompatiblePylons"] call MPSF_fnc_virtualDepot);
				if (_compatible) then {
					_ctrlList lbSetPictureRight [_i,_compatibleTextures select 1];
				} else {
					_ctrlList lbSetPictureRight [_i,_compatibleTextures select 0];
				};
				if (_compatible || _ignoreCompatible) then { _ctrlList lbSetColor [_i,[1, 1,1,1]]; } else { _ctrlList lbSetColor [_i,[1,1,1,0.3]]; };
			};
		};
	};
	case "ctrlListAnimUpdate" : {
		private _depotLogic = uiNamespace getVariable ["MPSF_activeDepotLogic",objNull];
		if (isNull _depotLogic) exitWith {
			/*["Unable to retrieve depot logic attached to trigger"] call BIS_fnc_error;*/
			["closeDepotUI"] call MPSF_fnc_virtualDepot;
		};
		private _center = ["getTargetCenter"] call MPSF_fnc_virtualDepot;
		private _checkboxTextures = [
			tolower gettext (configfile >> "RscCheckBox" >> "textureUnchecked"),
			tolower gettext (configfile >> "RscCheckBox" >> "textureChecked")
		];

		private _animationArray = configproperties [configFile >> "CfgVehicles" >> typeOf _center >> "animationSources","isclass _x",true];
		_animationArray = _animationArray apply {[configName _x,getText(_x >> "DisplayName"),getNumber(_x >> "scope"),isNumber(_x >> "scope")]};

		private _ctrlListAnimations = (uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlListAnim",controlNull]);
		lbclear _ctrlListAnimations;
		{
			_x params ["_configName","_displayName","_scopeNumber","_scopeIsNumber"];
			if (_displayName != "" && { _scopeNumber > 1 || !_scopeIsNumber}) then {
				private _lbAdd = _ctrlListAnimations lbadd _displayName;
				_ctrlListAnimations lbSetData [_lbAdd,_configName];
				_ctrlListAnimations lbSetPicture [_lbAdd,_checkboxTextures select ((_center animationphase _configName) max 0)];
			};
		} foreach _animationArray;
		_ctrlListAnimations ctrlsetfontheight (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8);
		lbsort _ctrlListAnimations;
	};
	case "ctrlListTextureUpdate" : {
		private _depotLogic = uiNamespace getVariable ["MPSF_activeDepotLogic",objNull];
		if (isNull _depotLogic) exitWith {
			/*["Unable to retrieve depot logic attached to trigger"] call BIS_fnc_error;*/
			["closeDepotUI"] call MPSF_fnc_virtualDepot;
		};
		private _center = ["getTargetCenter"] call MPSF_fnc_virtualDepot;
		private _currentTextures = getObjectTextures _center;
		private _current = "";
		private _checkboxTextures = [
			tolower gettext (configfile >> "RscCheckBox" >> "textureUnchecked"),
			tolower gettext (configfile >> "RscCheckBox" >> "textureChecked")
		];

		private _ctrlListTextures = (uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlListTexture",controlNull]);
		lbclear _ctrlListTextures;
		{
			private _displayName = gettext (_x >> "displayName");
			if (_displayName != "") then {
				private _textures = getarray (_x >> "textures");
				private _selected = true;
				if (count _textures == count _currentTextures) then {
					{
						if (tolower _x find (_currentTextures select _forEachIndex) < 0) exitwith {_selected = false;};
					} foreach _textures;
				} else {
					_selected = false;
				};
				private _lbAdd = _ctrlListTextures lbadd _displayName;
				_ctrlListTextures lbsetdata [_lbAdd,configname _x];
				_ctrlListTextures lbsetpicture [_lbAdd,_checkboxTextures select 0];
				if (_selected) then {
					_current = configname _x;
				};
			};
		} foreach (configproperties [configFile >> "CfgVehicles" >> typeOf _center >> "textureSources","isclass _x",true]);
		_ctrlListTextures ctrlsetfontheight (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8);
		lbsort _ctrlListTextures;
		for "_i" from 0 to (lbsize _ctrlListTextures - 1) do {
			if ((_ctrlListTextures lbdata _i) == _current) then {
				_ctrlListTextures lbsetcursel _i;
			};
		};
	};
	case "ShowItemInfo": {
		_params params [["_center",objNull,[objNull]]];

		private _cfg = configFile >> "CfgVehicles" >> typeOf _center;

		if (isclass _cfg) then {
			private _ctrlInfo = uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlInfo",controlNull];
			_ctrlInfo ctrlsetfade 0;
			_ctrlInfo ctrlcommit 0.2;

			private _ctrlInfoName = uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlInfoName",controlNull];
			_ctrlInfoName ctrlsettext getText (_cfg >> "DisplayName");

			private _ctrlInfoAuthor = uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlInfoAuthor",controlNull];
			_ctrlInfoAuthor ctrlsettext getText(_cfg >> "Author");

			private _ctrlDLC = uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlDLCIcon",controlNull];
			private _ctrlDLCBackground = uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlDLCBg",controlNull];
			private _dlc = _cfg call GETDLC;
			if (_dlc != "") then {
				private _dlcParams = modParams [_dlc,["name","logo","logoOver"]];
				_dlcParams params [["_name",""],["_logo",""],["_logoOver",""]];
				_fieldManualTopicAndHint = getarray (configfile >> "cfgMods" >> _dlc >> "fieldManualTopicAndHint");
				_ctrlDLC ctrlsettooltip _name;
				_ctrlDLC ctrlsettext _logo;
				_ctrlDLC ctrlsetfade 0;
				_ctrlDLC ctrlseteventhandler ["mouseexit",format ["(_this select 0) ctrlsettext '%1';",_logo]];
				_ctrlDLC ctrlseteventhandler ["mouseenter",format ["(_this select 0) ctrlsettext '%1';",_logoOver]];
				_ctrlDLC ctrlseteventhandler ["buttonclick",format ["if (count %1 > 0) then {(%1 + [ctrlparent (_this select 0)]) call BIS_fnc_openFieldManual;};",_fieldManualTopicAndHint]];
				_ctrlDLCBackground ctrlsetfade 0;
			} else {
				_ctrlDLC ctrlsetfade 1;
				_ctrlDLCBackground ctrlsetfade 1;
			};
			_ctrlDLC ctrlcommit 0.2;
			_ctrlDLCBackground ctrlcommit 0.2;
		} else {
			private _ctrlInfo = uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlInfo",controlNull];
			_ctrlInfo ctrlsetfade 1;
			_ctrlInfo ctrlcommit 0.2;

			_ctrlStats = uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlStats",controlNull];
			_ctrlStats ctrlsetfade 1;
			_ctrlStats ctrlcommit 0.2;
		};
	};
	case "ShowItemStats": {
		_params params [["_center",objNull,[objNull]]];
		private _cfg = configFile >> "CfgVehicles" >> typeOf _center;
		if (isclass _cfg) then {
			private _ctrlStats = uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlStats",controlNull];
			private _ctrlBackground = uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlStatBg",controlNull];
			private _ctrlStatsPos = ctrlposition _ctrlStats;
			_ctrlStatsPos set [0,0];
			_ctrlStatsPos set [1,0];
			private _barMin = 0.01;
			private _barMax = 1;

			private _statControls = [
				["RscDisplayVehicle_IDC_CtrlStatP1","RscDisplayVehicle_IDC_CtrlStatT1"],
				["RscDisplayVehicle_IDC_CtrlStatP2","RscDisplayVehicle_IDC_CtrlStatT2"],
				["RscDisplayVehicle_IDC_CtrlStatP3","RscDisplayVehicle_IDC_CtrlStatT3"],
				["RscDisplayVehicle_IDC_CtrlStatP4","RscDisplayVehicle_IDC_CtrlStatT4"],
				["RscDisplayVehicle_IDC_CtrlStatP5","RscDisplayVehicle_IDC_CtrlStatT5"]
			];
			private _rowH = 1 / (count _statControls + 1);
			private _fnc_showStats = {
				_h = _rowH;
				{
					_ctrlStat = uiNamespace getVariable [(_statControls select _forEachIndex) select 0,controlNull];
					_ctrlText = uiNamespace getVariable [(_statControls select _forEachIndex) select 1,controlNull];
					if (count _x > 0) then {
						_ctrlStat progresssetposition (_x select 0);
						_ctrlText ctrlsettext toupper (_x select 1);
						_ctrlText ctrlsetfade 0;
						_ctrlText ctrlcommit 0;
						_h = _h + _rowH;
					} else {
						_ctrlStat progresssetposition 0;
						_ctrlText ctrlsetfade 1;
						_ctrlText ctrlcommit 0;
					};
				} foreach _this;
				_ctrlStatsPos set [1,(_ctrlStatsPos select 3) * (1 - _h)];
				_ctrlStatsPos set [3,(_ctrlStatsPos select 3) * _h];
				_ctrlBackground ctrlsetposition _ctrlStatsPos;
				_ctrlBackground ctrlcommit 0;
			};

			_ctrlStats ctrlsetfade 0;
			_statsExtremes = uinamespace getVariable "BIS_fnc_garage_stats";
			if !(isnil "_statsExtremes") then {
				private _statsMin = _statsExtremes select 0;
				private _statsMax = _statsExtremes select 1;

				private _stats = [[_cfg],STATS,_statsMin] call BIS_fnc_configExtremes;
				_stats = _stats select 1;

				_statMaxSpeed = linearConversion [_statsMin select 0,_statsMax select 0,_stats select 0,_barMin,_barMax];
				_statArmor = linearConversion [_statsMin select 1,_statsMax select 1,_stats select 1,_barMin,_barMax];
				_statFuelCapacity = linearConversion [_statsMin select 2,_statsMax select 2,_stats select 2,_barMin,_barMax];
				_statThreat = linearConversion [_statsMin select 3,_statsMax select 3,_stats select 3,_barMin,_barMax];
				[
					[],[],[],
					[_statMaxSpeed,"Max speed"],
					[_statArmor,"Armor"]/*
					[_statFuelCapacity,"Fuel capacity"],
					[_statThreat,"Threat"]*/
				] call _fnc_showStats;
			};

			_ctrlStats ctrlcommit CTRLFADEDELAY;
		} else {
			private _ctrlStats = uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlStats",controlNull];
			_ctrlStats ctrlsetfade 1;
			_ctrlStats ctrlcommit CTRLFADEDELAY;
		};
	};
	case "showMessage": {
		terminate (missionnamespace getvariable ["MPSF_VehicleDepot_UI_message",scriptNull]);
		_spawn = _params spawn {
			disableserialization;
			_message = _this select 0;
			_ctrlMessage = uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlMessage",controlNull];
			_ctrlMessage ctrlsettext _message;
			_ctrlMessage ctrlsetfade 1;
			_ctrlMessage ctrlcommit 0;
			_ctrlMessage ctrlsetfade 0;
			_ctrlMessage ctrlcommit 0.3;
			uisleep 4;
			_ctrlMessage ctrlsetfade 1;
			_ctrlMessage ctrlcommit 1;
		};
		missionnamespace setvariable ["MPSF_VehicleDepot_UI_message",_spawn];
	};
	case "startDrawHardpoints" : {
		if (["getCfgDepotPylonInteraction"] call MPSF_fnc_virtualDepot) exitWith {};
		["MPSF_VehicleDepot_pylonEdit_onEachFrame_EH","onEachFrame",{
			private _vehicle = ["getTargetCenter"] call MPSF_fnc_virtualDepot;

			if (["isOpenPylonUI"] call MPSF_fnc_virtualDepot) exitWith {};

			private _ctrlBackgroundName = "RscDisplayVehicle_IDC_CtrlIconBackPylon%1";
			private _ctrlIconName = "RscDisplayVehicle_IDC_CtrlIconPylon%1";
			private _vehicleHardpoints = ["getPylonPositions",[_vehicle]] call MPSF_fnc_virtualDepot;

			for "_i" from 0 to 19 do {
				private _ctrlMoved = false;
				if (count _vehicleHardpoints >= (_i + 1)) then {
					private _hardpoints = _vehicleHardpoints select _i;
					if (count _hardpoints == 3) then {
						_pos = _vehicle modelToWorldVisual _hardpoints;
						_uiPos = worldtoscreen _pos;
						if (count _uiPos > 0 && !(_pos isEqualTo [0,0,0])) then {
							_ctrlMoved = true;
							_fade = _fade min (_uiPos distance BIS_fnc_arsenal_mouse);
							_ctrlPos = [];
							private _ctrl = controlNull;
							{
								_ctrl = uiNamespace getVariable [format [_x,_i],controlNull];
								_ctrlPos = ctrlposition _ctrl;
								_ctrlPos set [0,(_uiPos select 0) - (_ctrlPos select 2) * 0.5];
								_ctrlPos set [1,(_uiPos select 1) - (_ctrlPos select 3) * 0.5];
								_ctrl ctrlsetposition _ctrlPos;
								_ctrl ctrlcommit 0;
							} foreach [_ctrlBackgroundName,_ctrlIconName];

							_ctrl ctrlSetEventHandler ["buttonClick",format ["['ctrlButtonSelect',[11,[%1]]] call MPSF_fnc_virtualDepot;",_i]];

							switch (true) do {
								case (["isPylonMagFull",[_vehicle,_i]] call MPSF_fnc_virtualDepot) : {
									_ctrl ctrlSetText ICONRELOAD;
									_ctrl ctrlSetTooltip "Switch Ordinance";
								};
								case (["hasPylonMag",[_vehicle,_i]] call MPSF_fnc_virtualDepot) : {
									_ctrl ctrlSetText ICONRELOAD;
									_ctrl ctrlSetTooltip "Reload Pylon";
								};
								default {
									_ctrl ctrlSetText ICONADD;
									_ctrl ctrlSetTooltip "Add Ordinance";
								};
							};
						};
					};
				};
				if !(_ctrlMoved) then {
					{
						_ctrl = uiNamespace getVariable [format [_x,_i],controlNull];
						_ctrl ctrlSetEventHandler ["buttonClick",""];
						_ctrl ctrlsetposition [-1,-1];
						_ctrl ctrlcommit 0;
					} foreach [_ctrlBackgroundName,_ctrlIconName];
				};
			};

			if (count _vehicleHardpoints == 0 || isNull _vehicle || !(vehicle player isEqualTo player)) exitWith {
				["MPSF_VehicleDepot_pylonEdit_onEachFrame_EH","onEachFrame"] call MPSF_fnc_removeEventHandler;
			};
		}] call MPSF_fnc_addEventHandler;
	};
	case "onLoadDepotUI" : {
		disableSerialization;
		private _display = _params select 0;
		uiNamespace setVariable ["RscDisplayVehicle_dialog",(_display)];

		private _depotLogic = uiNamespace getVariable ["MPSF_activeDepotLogic",objNull];
		if (isNull _depotLogic) exitWith {
			/*["Unable to retrieve depot logic attached to trigger"] call BIS_fnc_error;*/
			["closeDepotUI"] call MPSF_fnc_virtualDepot;
		};

		{
			uiNamespace setVariable [format[(_x select 0),"IDC"],_display displayCtrl (_x select 1)];
			uiNamespace setVariable [format[(_x select 0),"POS"],ctrlPosition (_display displayCtrl (_x select 1))];
		} forEach [
			["RscDisplayVehicle_%1_mouseBlock",898]
			,["RscDisplayVehicle_%1_mouseArea",899]
			,["RscDisplayVehicle_%1_titleimage",895]

			,["RscDisplayVehicle_%1_CtrlMessage",1000]
			,["RscDisplayVehicle_%1_CtrlMenu",3000]
			,["RscDisplayVehicle_%1_CtrlMenuTextLeft",3001]
			,["RscDisplayVehicle_%1_CtrlMenuVehicleService",3002]
			,["RscDisplayVehicle_%1_CtrlMenuVehicleA",3003]
			,["RscDisplayVehicle_%1_CtrlMenuVehicleB",3004]
			,["RscDisplayVehicle_%1_CtrlMenuVehicleSave",3005]
			,["RscDisplayVehicle_%1_CtrlMenuVehicleLoad",3006]
			,["RscDisplayVehicle_%1_CtrlMenuVehicle",3007]
			,["RscDisplayVehicle_%1_CtrlMenuClose",3008]

			,["RscDisplayVehicle_%1_CtrlInfo",4000]
			,["RscDisplayVehicle_%1_CtrlInfoBg",4001]
			,["RscDisplayVehicle_%1_CtrlInfoName",4002]
			,["RscDisplayVehicle_%1_CtrlInfoAuthor",4003]
			,["RscDisplayVehicle_%1_CtrlDLCBg",4004]
			,["RscDisplayVehicle_%1_CtrlDLCIcon",4005]
			,["RscDisplayVehicle_%1_CtrlStats",5000]
			,["RscDisplayVehicle_%1_CtrlStatBg",5001]
			,["RscDisplayVehicle_%1_CtrlStatP1",5002]
			,["RscDisplayVehicle_%1_CtrlStatP2",5003]
			,["RscDisplayVehicle_%1_CtrlStatP3",5004]
			,["RscDisplayVehicle_%1_CtrlStatP4",5005]
			,["RscDisplayVehicle_%1_CtrlStatP5",5006]
			,["RscDisplayVehicle_%1_CtrlStatT1",5007]
			,["RscDisplayVehicle_%1_CtrlStatT2",5008]
			,["RscDisplayVehicle_%1_CtrlStatT3",5009]
			,["RscDisplayVehicle_%1_CtrlStatT4",5010]
			,["RscDisplayVehicle_%1_CtrlStatT5",5011]

			,["RscDisplayVehicle_%1_CtrlTabsBg",6998]
			,["RscDisplayVehicle_%1_CtrlTabsFrame",6999]

			,["RscDisplayVehicle_%1_CtrlTabCar",6001]
			,["RscDisplayVehicle_%1_CtrlListCar",6101]
			,["RscDisplayVehicle_%1_CtrlTextCar",6201]

			,["RscDisplayVehicle_%1_CtrlTabTank",6002]
			,["RscDisplayVehicle_%1_CtrlListTank",6102]
			,["RscDisplayVehicle_%1_CtrlTextTank",6202]

			,["RscDisplayVehicle_%1_CtrlTabHeli",6003]
			,["RscDisplayVehicle_%1_CtrlListHeli",6103]
			,["RscDisplayVehicle_%1_CtrlTextHeli",6203]

			,["RscDisplayVehicle_%1_CtrlTabPlane",6004]
			,["RscDisplayVehicle_%1_CtrlListPlane",6104]
			,["RscDisplayVehicle_%1_CtrlTextPlane",6204]

			,["RscDisplayVehicle_%1_CtrlTabNavel",6005]
			,["RscDisplayVehicle_%1_CtrlListNavel",6105]
			,["RscDisplayVehicle_%1_CtrlTextNavel",6205]

			,["RscDisplayVehicle_%1_CtrlTabCrew",6006]
			,["RscDisplayVehicle_%1_CtrlListCrew",6106]
			,["RscDisplayVehicle_%1_CtrlBtnPylonOwner",6206]

			,["RscDisplayVehicle_%1_CtrlTabAnim",6007]
			,["RscDisplayVehicle_%1_CtrlListAnim",6107]

			,["RscDisplayVehicle_%1_CtrlTabTexture",6008]
			,["RscDisplayVehicle_%1_CtrlListTexture",6108]

			,["RscDisplayVehicle_%1_CtrlIconBackPylon0",7000]
			,["RscDisplayVehicle_%1_CtrlIconPylon0",7100]
			,["RscDisplayVehicle_%1_CtrlIconBackPylon1",7001]
			,["RscDisplayVehicle_%1_CtrlIconPylon1",7101]
			,["RscDisplayVehicle_%1_CtrlIconBackPylon2",7002]
			,["RscDisplayVehicle_%1_CtrlIconPylon2",7102]
			,["RscDisplayVehicle_%1_CtrlIconBackPylon3",7003]
			,["RscDisplayVehicle_%1_CtrlIconPylon3",7103]
			,["RscDisplayVehicle_%1_CtrlIconBackPylon4",7004]
			,["RscDisplayVehicle_%1_CtrlIconPylon4",7104]
			,["RscDisplayVehicle_%1_CtrlIconBackPylon5",7005]
			,["RscDisplayVehicle_%1_CtrlIconPylon5",7105]
			,["RscDisplayVehicle_%1_CtrlIconBackPylon6",7006]
			,["RscDisplayVehicle_%1_CtrlIconPylon6",7106]
			,["RscDisplayVehicle_%1_CtrlIconBackPylon7",7007]
			,["RscDisplayVehicle_%1_CtrlIconPylon7",7107]
			,["RscDisplayVehicle_%1_CtrlIconBackPylon8",7008]
			,["RscDisplayVehicle_%1_CtrlIconPylon8",7108]
			,["RscDisplayVehicle_%1_CtrlIconBackPylon9",7009]
			,["RscDisplayVehicle_%1_CtrlIconPylon9",7109]
			,["RscDisplayVehicle_%1_CtrlIconBackPylon10",7010]
			,["RscDisplayVehicle_%1_CtrlIconPylon10",7110]
			,["RscDisplayVehicle_%1_CtrlIconBackPylon11",7011]
			,["RscDisplayVehicle_%1_CtrlIconPylon11",7111]
			,["RscDisplayVehicle_%1_CtrlIconBackPylon12",7012]
			,["RscDisplayVehicle_%1_CtrlIconPylon12",7112]
			,["RscDisplayVehicle_%1_CtrlIconBackPylon13",7013]
			,["RscDisplayVehicle_%1_CtrlIconPylon13",7113]
			,["RscDisplayVehicle_%1_CtrlIconBackPylon14",7014]
			,["RscDisplayVehicle_%1_CtrlIconPylon14",7114]
			,["RscDisplayVehicle_%1_CtrlIconBackPylon15",7015]
			,["RscDisplayVehicle_%1_CtrlIconPylon15",7115]
			,["RscDisplayVehicle_%1_CtrlIconBackPylon16",7016]
			,["RscDisplayVehicle_%1_CtrlIconPylon16",7116]
			,["RscDisplayVehicle_%1_CtrlIconBackPylon17",7017]
			,["RscDisplayVehicle_%1_CtrlIconPylon17",7117]
			,["RscDisplayVehicle_%1_CtrlIconBackPylon18",7018]
			,["RscDisplayVehicle_%1_CtrlIconPylon18",7118]
			,["RscDisplayVehicle_%1_CtrlIconBackPylon19",7019]
			,["RscDisplayVehicle_%1_CtrlIconPylon19",7119]
		];

		{
			(uiNamespace getVariable [_x,controlNull]) ctrlEnable false;
			(uiNamespace getVariable [_x,controlNull]) ctrlSetFade 1;
			(uiNamespace getVariable [_x,controlNull]) ctrlCommit 0;
		} foreach [
			"RscDisplayVehicle_IDC_CtrlMessage"
			,"RscDisplayVehicle_IDC_CtrlInfo"
			,"RscDisplayVehicle_IDC_CtrlStats"
			,"RscDisplayVehicle_IDC_CtrlTabs"
		];

		{
			(uiNamespace getVariable [_x,controlNull]) ctrlAddEventHandler ["buttonclick",compile format ["['ctrlButtonSelect',[%1]] call MPSF_fnc_virtualDepot;",_forEachIndex]];
		} foreach [
			"RscDisplayVehicle_IDC_CtrlTabCar"
			,"RscDisplayVehicle_IDC_CtrlTabTank"
			,"RscDisplayVehicle_IDC_CtrlTabHeli"
			,"RscDisplayVehicle_IDC_CtrlTabPlane"
			,"RscDisplayVehicle_IDC_CtrlTabNavel"
			,"RscDisplayVehicle_IDC_CtrlTabCrew"
			,"RscDisplayVehicle_IDC_CtrlTabAnim"
			,"RscDisplayVehicle_IDC_CtrlTabTexture"
		];

		{
			(uiNamespace getVariable [_x,controlNull]) ctrlAddEventHandler ["lbselchanged",{ ['ctrlListSelect',_this] spawn MPSF_fnc_virtualDepot; }];
		} foreach [
			"RscDisplayVehicle_IDC_CtrlListCar"
			,"RscDisplayVehicle_IDC_CtrlListTank"
			,"RscDisplayVehicle_IDC_CtrlListHeli"
			,"RscDisplayVehicle_IDC_CtrlListPlane"
			,"RscDisplayVehicle_IDC_CtrlListNavel"
			,"RscDisplayVehicle_IDC_CtrlListCrew"
			,"RscDisplayVehicle_IDC_CtrlListAnim"
			,"RscDisplayVehicle_IDC_CtrlListTexture"
		];

		{
			(uiNamespace getVariable [_x,controlNull]) ctrlEnable false;
			(uiNamespace getVariable [_x,controlNull]) ctrlCommit 0;
		} foreach [
			"RscDisplayVehicle_IDC_CtrlMenuVehicleSave"
			,"RscDisplayVehicle_IDC_CtrlMenuVehicleLoad"
		];

		private _ctrlTitleLogo = uiNamespace getVariable ["RscDisplayVehicle_IDC_titleimage",controlNull];
		_ctrlTitleLogo ctrlEnable false;
		_ctrlTitleLogo ctrlSetFade 0.2;
		_ctrlTitleLogo ctrlCommit 0;

		//--- Load stats
		if (isnil {uinamespace getVariable "BIS_fnc_garage_stats"}) then {
			private _defaultCrew = gettext (configfile >> "cfgvehicles" >> "all" >> "crew");
			uinamespace setVariable [
				"BIS_fnc_garage_stats",
				[
					("isclass _x && {getnumber (_x >> 'scope') == 2} && {gettext (_x >> 'crew') != _defaultCrew}" configclasses (configfile >> "cfgvehicles")),
					STATS
				] call bis_fnc_configExtremes
			];
		};

		(uiNamespace getVariable ["RscDisplayVehicle_IDC_mouseArea",controlNull]) ctrladdeventhandler ["mousebuttonclick","['ctrlButtonSelect',[]] call MPSF_fnc_virtualDepot;"];
		(uiNamespace getVariable ["RscDisplayVehicle_IDC_CtrlMenuClose",controlNull]) ctrlAddEventHandler ["buttonclick","['closeDepotUI'] call MPSF_fnc_virtualDepot;"];

		private _center = ["getTargetCenter"] call MPSF_fnc_virtualDepot;
		["start",[
			_display
			,(uiNamespace getVariable ["RscDisplayVehicle_IDC_mouseArea",controlNull])
			,(uiNamespace getVariable ["RscDisplayVehicle_IDC_mouseBlock",controlNull])
			,_depotLogic
		]] call (missionNamespace getVariable ["MPSF_fnc_CameraUI",{}]);

		if !(isNull _center) then {
			["setVehiclePosition",[_center,_depotLogic]] call MPSF_fnc_virtualDepot;
			["vehicleLock",[_center,2]] call MPSF_fnc_virtualDepot;
			["allowDamage",[_center,false]] call MPSF_fnc_virtualDepot;
			["setTargetCenter",[_center,false]] call MPSF_fnc_virtualDepot;
			["setDeployed",[_center,true]] call MPSF_fnc_virtualDepot;
			if (count (["getPylonsMags",[_center]] call MPSF_fnc_virtualDepot) > 0) then {
				["startDrawHardpoints"] call MPSF_fnc_virtualDepot;
				["ctrlListPylonUpdate",[_center]] call MPSF_fnc_virtualDepot;
			} else {
				["MPSF_VehicleDepot_pylonEdit_onEachFrame_EH","onEachFrame"] call MPSF_fnc_removeEventHandler;
			};
			["ctrlListAnimUpdate",[_center]] call MPSF_fnc_virtualDepot;
			["ctrlListTextureUpdate",[_center]] call MPSF_fnc_virtualDepot;
			["ShowItemInfo",[_center]] call MPSF_fnc_virtualDepot;
			//["ShowItemStats",[_center]] call MPSF_fnc_virtualDepot;
		};
		["ctrlTabsShow"] call MPSF_fnc_virtualDepot;
		["ctrlMenuButtonEnabled"] call MPSF_fnc_virtualDepot;

		/*if (sunOrMoon < 1) then {
			["updateCameraVision",[1]] call PO4_fnc_camera;
		};
		*/
		//[parseText format ["<t align='right' size='2.0'><t font='PuristaBold' size='2.4'>%1</t> %2</t>",mapGridPosition _depotLogic],[0,1,1,0.5],nil,5,2,0] spawn BIS_fnc_textTiles;

		/*_intensity = 20;
		_light = "#lightpoint" createVehicle position _depotLogic;
		_light setLightBrightness _intensity;
		_light setLightAmbient [1,1,1];
		_light setLightColor [0,0,0];
		_light lightAttachObject [_depotLogic,[0,0,-_intensity * 7]];*/

		["ctrlMenuButtonEnabled"] call MPSF_fnc_virtualDepot;
		["ctrlVehicleListUpdate",[_depotLogic]] call MPSF_fnc_virtualDepot;
		["ctrlTabSelectLeft",[-1]] call MPSF_fnc_virtualDepot;
		["ctrlTabSelectRight",[]] call MPSF_fnc_virtualDepot;
		["ctrlTabsShow",[true,true,false]] call MPSF_fnc_virtualDepot;
	};
	case "onUnloadDepotUI" : {
		["#(argb,8,8,3)color(0,0,0,1)",false,nil,0,[0,0.5]] call BIS_fnc_textTiles;

		["closeVirtualDepot",[_depotID,player,false],side player] call PO4_fnc_triggerEventHandler;

		uiNamespace setVariable ["PO4_VehicleDepot_UI_ID",nil];
		uiNamespace setVariable ["PO4_VehicleDepot_UI_SID",nil];
		uiNamespace setVariable ["PO4_VehicleDepot_UI_VID",nil];
		//uiNamespace setVariable ["PO4_VehicleDepot_UI_TempVehicle",nil];
	};
	case "isOpenDepotUI" : {
		private _return = !(isNull(uiNamespace getVariable ["MPSF_VirtualDepot_DisplayID",displayNull]));
		_return;
	};
	case "openDepotUI" : {
		disableSerialization;
		_params params [["_depotLogic",objNull,[objNull]]];
		if (isNull _depotLogic) exitWith { /*["Unable to retrieve depot logic attached to trigger"] call BIS_fnc_error;*/ };

		if !(isNull (_depotLogic getVariable ["ActiveUser",objNull])) exitWith { /*["Depot is already in USE"] call BIS_fnc_error;*/ };

		_depotLogic setVariable ["ActiveUser",player,true];
		uiNamespace setVariable ["MPSF_activeDepotLogic",_depotLogic];

		private _nearbyObjects = ["getVehiclesInDepot",[_depotLogic]] call MPSF_fnc_virtualDepot;
		private _center = _nearbyObjects param [0,objNull,[objNull]];
		if !(isNull _center) then {
			["setTargetCenter",[_center,false]] call MPSF_fnc_virtualDepot;
		};

		private _display = ([] call BIS_fnc_displayMission) createDisplay "RscDisplayVirtualDepot";
		waitUntil {!isNull _display};
		["virtualDepotOpened",[],true] call MPSF_fnc_triggerEventHandler;
		uiNamespace setVariable ["MPSF_VirtualDepot_DisplayID",_display];
		waitUntil {isNull _display || !alive player};
		["virtualDepotClosed",[],true] call MPSF_fnc_triggerEventHandler;

		["end"] call (missionNamespace getVariable ["MPSF_fnc_CameraUI",{/*["No Namespace Function %1 Found",str "MPSF_fnc_CameraUI"] call BIS_fnc_error;*/}]);
		["closeDepotUI"] call MPSF_fnc_virtualDepot;
		_depotLogic setVariable ["ActiveUser",nil,true];
		uiNamespace setVariable ["MPSF_activeDepotLogic",nil];

		private _center = ["getTargetCenter"] call MPSF_fnc_virtualDepot;
		if !(isNull _center) then { ["allowDamage",[_center,false]] call MPSF_fnc_virtualDepot; };

		true;
	};
	case "closeDepotUI" : {
		disableSerialization;
		private _center = ["getTargetCenter"] call MPSF_fnc_virtualDepot;
		if !(isNull _center) then {
			["vehicleLock",[_center,0]] call MPSF_fnc_virtualDepot;
			["setTargetCenter",[objNull]] call MPSF_fnc_virtualDepot;
		};
		(uiNamespace getVariable ["MPSF_VirtualDepot_DisplayID",displayNull]) closeDisplay 2;
		uiNamespace setVariable ["MPSF_VirtualDepot_DisplayID",nil];
		true;
	};
// Dynamic Aircraft Loadout Editor (DALE) Functions
	case "startDale" : {
		_params params [["_center",objNull,[objNull]]];
		if (isNull _center) exitWith {};
		["setTargetCenter",[_center,false]] call MPSF_fnc_virtualDepot;
		["aircraftLoadoutStart",[_center],_center] call MPSF_fnc_triggerEventHandler;
		["drawDale3D",[_center,player]] call MPSF_fnc_virtualDepot;
	};
	case "endDale" : {
		_params params [["_center",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]];
		if (isNull _center) exitWith {};
		systemChat "Exited Dynamic Aircraft Loadout Editor";
		["MPSF_VehicleDepot_pylonEdit_onEachFrame_EH","onEachFrame"] call MPSF_fnc_removeEventHandler;
		["aircraftLoadoutEnd",[_center],_center] call MPSF_fnc_triggerEventHandler;
		["syncWeaponLoadout",[_center]] call MPSF_fnc_virtualDepot;
		["setDeployed",[_center,true]] call MPSF_fnc_virtualDepot;
		["setTargetCenter",[objNull]] call MPSF_fnc_virtualDepot;
		["setTargetCenterPylon",[]] call MPSF_fnc_virtualDepot;
	};
	case "onLoadPylonUI" : {
		disableSerialization;
		private _dialog = _params select 0;
		uiNamespace setVariable ["RscDisplayVirtualDepotAirLoadout_dialog",(_dialog)];
		{
			uiNamespace setVariable [(_x select 0),(_dialog displayCtrl (_x select 1))];
		} forEach [
			["PylonCtrlLineIcon",2001]
			,["PylonCtrlOwnerBtn",2010]
			,["PylonCtrlList1",2011]
			,["PylonCtrlIconBackground",2021]
			,["PylonCtrlIconImage",2022]
			,["PylonCtrlIconText",2023]
		];

		private _vehicle = ['getTargetCenter'] call MPSF_fnc_virtualDepot;
		private _pylonID = ["getTargetCenterPylon"] call MPSF_fnc_virtualDepot;
		private _pylonOwner = ["getPylonOwner",[_vehicle,_pylonID]] call MPSF_fnc_virtualDepot;
		private _pylonsMag = ["getPylonMag",[_vehicle,_pylonID]] call MPSF_fnc_virtualDepot;
		private _pylonHardpoints = (["getCfgPylons",[_vehicle]] call MPSF_fnc_virtualDepot) apply {_x select 1};
		private _pylonHardpoints = (_pylonHardpoints select _pylonID) apply {toLower _x};
		private _allPylonMagazines = "toLower (configname _x) find 'pylon' >= 0" configClasses (configfile >> "CfgMagazines");
		private _availableMags = [["","- Empty"]];
		private _fullList = !(["getCfgCompatiblePylons"] call MPSF_fnc_virtualDepot);

		{
			private _magHardPoints = (getArray(configfile >> "CfgMagazines" >> configName _x >> "hardpoints")) apply {toLower _x};
			if (count (_pylonHardpoints arrayIntersect _magHardPoints) > 0 || _fullList) then {
				_availableMags pushBackUnique [
					configName _x
					,getText (configfile >> "CfgMagazines" >> configName _x >> "displayName")
					,count (_pylonHardpoints arrayIntersect _magHardPoints) > 0
				];
			};
		} forEach _allPylonMagazines;

		if (count _availableMags == 0) exitWith {
			(findDisplay 860136) closeDisplay 0;
			systemChat "Failed: No Mags Available";
		};

		["MPSF_DALE_pylonSelectMagUI_onEachFrame_EH","onEachFrame",{
			private _vehicle = ['getTargetCenter'] call MPSF_fnc_virtualDepot;
			private _pylonID = ["getTargetCenterPylon"] call MPSF_fnc_virtualDepot;
			if (isNull _vehicle || _pylonID < 0) exitWith {
				["MPSF_DALE_pylonSelectMagUI_onEachFrame_EH","onEachFrame"] call MPSF_fnc_removeEventHandler;
			};
			private _vehicleHardpoints = ["getPylonPositions",[_vehicle]] call MPSF_fnc_virtualDepot;
			if (count _vehicleHardpoints == 0) exitWith {
				["MPSF_DALE_pylonSelectMagUI_onEachFrame_EH","onEachFrame"] call MPSF_fnc_removeEventHandler;
			};
			_hardPoint = _vehicleHardpoints select _pylonID;
			_uiPos = worldtoscreen (_vehicle modelToWorldVisual _hardPoint);
			if (count _uiPos > 0) then {
				private _ctrlPos = [];

				private _ctrlIconBackground = uiNamespace getVariable ["PylonCtrlIconBackground",controlNull];
				private _ctrlIconImage = uiNamespace getVariable ["PylonCtrlIconImage",controlNull];
				{
					_ctrl = _x;
					_ctrlPos = ctrlposition _ctrl;
					_ctrlPos set [0,(_uiPos select 0) - (_ctrlPos select 2) * 0.5];
					_ctrlPos set [1,(_uiPos select 1) - (_ctrlPos select 3) * 0.5];
					_ctrl ctrlsetposition _ctrlPos;
					_ctrl ctrlcommit 0;
				} foreach [_ctrlIconBackground,_ctrlIconImage];

				private _ctrlIconText = uiNamespace getVariable ["PylonCtrlIconText",controlNull];
				_ctrlTextPos = ctrlposition _ctrlIconText;
				_ctrlTextPos set [0,(_ctrlPos select 0) + (1.5 * (((safezoneW / safezoneH) min 1.2) / 40))];
				_ctrlTextPos set [1,(_ctrlPos select 1)];
				_ctrlIconText ctrlsetposition _ctrlTextPos;
				_ctrlIconText ctrlcommit 0;

				private _ctrlList = uiNamespace getVariable ["PylonCtrlList1",controlNull];
				_ctrlListPos = ctrlposition _ctrlList;
				_ctrlListPos set [1,(_uiPos select 1) - (_ctrlListPos select 3) * 0.5];
				_ctrlList ctrlsetposition _ctrlListPos;
				_ctrlList ctrlcommit 0;

				private _ctrlOwnerBtn = uiNamespace getVariable ["PylonCtrlOwnerBtn",controlNull];
				_ctrlOwnerPos = ctrlposition _ctrlOwnerBtn;
				_ctrlOwnerPos set [1,(_ctrlListPos select 1) - (1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))];
				_ctrlOwnerBtn ctrlsetposition _ctrlOwnerPos;
				_ctrlOwnerBtn ctrlcommit 0;

				private _ctrlLineIcon = uiNamespace getVariable ["PylonCtrlLineIcon",controlNull];
				if (ctrlfade _ctrlList == 0) then {
					_ctrlLinePosX = (_uiPos select 0) - (_ctrlPos select 2) * 0.5;
					_ctrlLineIcon ctrlsetposition [
						(_uiPos select 0) - (_ctrlPos select 2) * 0.5,
						_uiPos select 1,
						(ctrlposition _ctrlList select 0) + (ctrlposition _ctrlList select 2) - _ctrlLinePosX,
						0
					];
					_ctrlLineIcon ctrlsetfade 0;
					_ctrlLineIcon ctrlcommit 0;
				} else {
					if (ctrlfade _ctrlLineIcon == 0) then {
						_ctrlLineIcon ctrlsetfade 0.01;
						_ctrlLineIcon ctrlcommit 0;
						_ctrlLineIcon ctrlsetfade 1;
						_ctrlLineIcon ctrlcommit FADE_DELAY;
					};
				};
			};
		}] call MPSF_fnc_addEventHandler;

		private _ctrlList = uiNamespace getVariable ["PylonCtrlList1",controlNull];
		private _curSel = 0;
		{
			_x params ["_magClass","_magName",["_magCompatible",false]];
			_idx = _ctrlList lbAdd _magName;
			_ctrlList lbSetData [_idx,_magClass];
			_ctrlList lbSetTooltip [_idx,format["Install %1 Ordinance",_magName]];
			if (_magCompatible) then {
				_ctrlList lbSetPictureRight [_idx,"\a3\ui_f\data\IGUI\Cfg\Actions\ico_ON_ca.paa"];
			};
			if (_pylonsMag isEqualTo _magClass) then { _curSel = _forEachIndex; };
		} forEach _availableMags;
		_ctrlList lbSetCurSel _curSel;
		lbSort [_ctrlList,"ASC"];
		ctrlSetFocus _ctrlList;

		_ctrlList ctrlAddEventHandler ["LBSelChanged",{
			missionNamespace setVariable ["DALE_appliedMag",false];
			missionNamespace setVariable ["DALE_requestMag",(_this select 0) lbData (_this select 1)];
			["setPylonMag",[nil,nil,((_this select 0) lbData (_this select 1)),(99)]] call MPSF_fnc_virtualDepot;
		}];

		private _ctrlOwnerBtn = uiNamespace getVariable ["PylonCtrlOwnerBtn",controlNull];
		_ctrlOwnerBtn ctrlSetText format ["Owner: %1",if (_pylonOwner isEqualTo []) then {"Pilot"} else {"Gunner"}];
		_ctrlOwnerBtn ctrlAddEventHandler ["ButtonClick",{
			["togglePylonOwner"] call MPSF_fnc_virtualDepot;
			private _pylonOwner = ["getPylonOwner"] call MPSF_fnc_virtualDepot;
			(_this select 0) ctrlSetText format ["Owner: %1",if (_pylonOwner isEqualTo []) then {"Pilot"} else {"Gunner"}];
		}];

		private _ctrlIconImage = uiNamespace getVariable ["PylonCtrlIconImage",controlNull];
		_ctrlIconImage ctrlAddEventHandler ["ButtonClick",{
			(_this select 0) ctrlRemoveAllEventHandlers "ButtonClick";
			missionNamespace setVariable ["DALE_appliedMag",true];
			private _pylonsMag = missionNamespace getVariable ["DALE_requestMag",""];
			["setPylonMag",[nil,nil,_pylonsMag,(0)]] call MPSF_fnc_virtualDepot;
			["closePylonUI"] call MPSF_fnc_virtualDepot;
		}];
	};
	case "openPylonUI" : {
		missionNamespace setVariable ["DALE_appliedMag",false];
		private _display = ([] call BIS_fnc_displayMission) createDisplay "RscDisplayVirtualDepotAirLoadout";
		waitUntil {!isNull _display};
		uiNamespace setVariable ["MPSF_DALE_DisplayID",_display];
		waitUntil {isNull _display};
	};
	case "closePylonUI" : { (uiNamespace getVariable ["MPSF_DALE_DisplayID",displayNull]) closeDisplay 2; };
	case "drawDale3D" : {
		_params params [["_vehicle",objNull,[objNull]],["_caller",player,[objNull]]];
		if (isNull _vehicle) exitWith {};
		["MPSF_VehicleDepot_pylonEdit_onEachFrame_EH","onEachFrame",{
			private _vehicle = ["getTargetCenter"] call MPSF_fnc_virtualDepot;

			if (isNull _vehicle || !(vehicle player isEqualTo player)) exitWith {
				["MPSF_VehicleDepot_pylonEdit_onEachFrame_EH","onEachFrame"] call MPSF_fnc_removeEventHandler;
			};
			if (["isOpenPylonUI"] call MPSF_fnc_virtualDepot) exitWith {};

			private _selectedPart = ["getCursorPylonID",[_vehicle]] call MPSF_fnc_virtualDepot;
			private _vehicleHardpoints = ["getPylonPositions",[_vehicle]] call MPSF_fnc_virtualDepot;
			{
				if (count _x == 3) then {
					_pos = _vehicle modelToWorldVisual _x;
					if !(_pos isEqualTo [0,0,0]) then {
						private _alpha = 0 max (1 - (_pos distance2D player)/10) min 1;
						private _colour1 = COLOURWHITE; _colour1 set [3,_alpha];
						private _colour2 = [0,0,0,0]; _colour2 set [3,_alpha];
						switch (true) do {
							case (["isPylonMagFull",[_vehicle,_forEachIndex]] call MPSF_fnc_virtualDepot) : {
								if (_selectedPart == (_forEachIndex)) then {
									drawIcon3D [ICONRELOAD,_colour1,_pos,MARKER_SIZE*1.5,MARKER_SIZE*1.6,0,"",0];
									drawIcon3D [ICONEMPTY,_colour1,_pos,MARKER_SIZE*1.5,MARKER_SIZE*-3.0,0,"Switch",2,0.03,"RobotoCondensed"];
								};
							};
							case (["hasPylonMag",[_vehicle,_forEachIndex]] call MPSF_fnc_virtualDepot) : {
								drawIcon3D [ICONRELOAD,_colour1,_pos,MARKER_SIZE*1.5,MARKER_SIZE*1.5,0,"",0];
								drawIcon3D [ICONEMPTY,_colour1,_pos,MARKER_SIZE*1.5,MARKER_SIZE*-3.0,0,"Reload",2,0.03,"RobotoCondensed"];
							};
							default {
								if (_selectedPart == (_forEachIndex)) then {
									drawIcon3D [ICONEMPTY,_colour1,_pos,MARKER_SIZE*1.5,MARKER_SIZE*-3.0,0,"Add Ordinance",2,0.03,"RobotoCondensed"];
								} else {
									drawIcon3D [ICONBACK,_colour2,_pos,MARKER_SIZE*1.5,MARKER_SIZE*1.5,0,"",0];
								};
								drawIcon3D [ICONADD,_colour1,_pos,MARKER_SIZE*1.5,MARKER_SIZE*1.6,0,"",0];
							};
						};
						if (_selectedPart == (_forEachIndex)) then {
							private _pylonMagName = ["getCfgMagazineDisplayName",[(["getPylonMag",[_vehicle,_forEachIndex]] call MPSF_fnc_virtualDepot)]] call MPSF_fnc_virtualDepot;
							drawIcon3D [ICONSELECTORF,_colour1,_pos,MARKER_SIZE*1.8,MARKER_SIZE*1.8,diag_frameNo % 360,"",0];
							drawIcon3D [ICONEMPTY,_colour1,_pos,MARKER_SIZE*1.8,MARKER_SIZE*1.8,0,_pylonMagName + " Pylon:" + str (_forEachIndex + 1),2];
						};
					};
				};
			} forEach _vehicleHardpoints;
			drawIcon3D [ICONPOINTER,[1,1,1,1],screenToWorld [0.5,0.5],MARKER_SIZE*4,MARKER_SIZE*4,0,"",0];
		}] call MPSF_fnc_addEventHandler;
	};
	case "getCursorPylonID" : {
		_params params [["_vehicle",objNull,[objNull]]];
		private _pylonID = -1;
		if !(isNull _vehicle) then {
			private _hardPoints = (["getPylonPositions",[_vehicle]] call MPSF_fnc_virtualDepot) apply {worldToScreen (_vehicle modeltoworldvisual _x)};
			private _distance = 0.1;
			{
				private _cursorDistance = [0.5,0.5] distance2D _x;
				if (_cursorDistance < _distance) then {
					_distance = _cursorDistance;
					_pylonID = _forEachIndex;
				};
			} forEach (_hardPoints select {count _x > 0});
		};
		["setTargetCenterPylon",[_pylonID]] call MPSF_fnc_virtualDepot;
		_pylonID;
	};
	case "toggleBay" : { // Broken
		_params params [
			["_vehicle",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]
			,["_pylonID",(['getTargetCenterPylon'] call MPSF_fnc_virtualDepot),[0]]
			,["_pylonPhase",-1,[0]]
		];
		//_vehicle animateBay [_pylonID,_pylonPhase];
	};
	case "togglePylon" : { // Broken
		_params params [
			["_vehicle",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]
			,["_pylonID",(['getTargetCenterPylon'] call MPSF_fnc_virtualDepot),[0]]
			,["_pylonPhase",-1,[0]]
		];
		//_vehicle animatePylon [_pylonID,_pylonPhase];
	};
	case "togglePylonOwner" : {
		_params params [
			["_vehicle",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]
			,["_pylonID",(['getTargetCenterPylon'] call MPSF_fnc_virtualDepot),[0]]
		];
		if (isNull _vehicle || _pylonID < 0) exitWith {};
		private _owner = ["getPylonOwner",[_vehicle,_pylonID]] call MPSF_fnc_virtualDepot;
		private _newOwner = if (_owner isEqualTo []) then {[0]} else {[]};
		["setPylonOwner",[_vehicle,_pylonID,_newOwner]] call MPSF_fnc_virtualDepot;
		["syncWeaponLoadout",[_vehicle]] call MPSF_fnc_virtualDepot;
	};
	case "getPylonOwner" : {
		_params params [
			["_vehicle",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]
			,["_pylonID",(['getTargetCenterPylon'] call MPSF_fnc_virtualDepot),[0]]
		];
		private _owner = _vehicle getVariable [format["DALE_Pylon_%1_Owner",_pylonID],""];
		if (_owner isEqualTo "") then {
			_owner = (["getCfgPylon",[_vehicle,_pylonID]] call MPSF_fnc_virtualDepot) select 2;
		};
		_owner
	};
	case "setPylonOwner" : {
		_params params [
			["_vehicle",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]
			,["_pylonID",(['getTargetCenterPylon'] call MPSF_fnc_virtualDepot),[0]]
			,["_owner",0,[[],0]]
		];
		if (_owner isEqualType 0) then {
			_owner = ["getPylonOwner",[_vehicle,_pylonID]] call MPSF_fnc_virtualDepot;
		};
		_vehicle setVariable [format["DALE_Pylon_%1_Owner",_pylonID],_owner,true];
		true
	};
	case "getPylonOwnerName" : {
		_params params [
			["_vehicle",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]
			,["_pylonID",(['getTargetCenterPylon'] call MPSF_fnc_virtualDepot),[0]]
		];
		private _owner = ["getPylonOwner",[_vehicle,_pylonID]] call MPSF_fnc_virtualDepot;
		if (_owner isEqualTo []) then {"Pilot"} else {"Gunner"};
	};
	case "getPylonsMags" : {
		_params params [
			["_vehicle",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]
			,["_resolve",false,[false]]
		];
		private _pylonsMags = getPylonMagazines _vehicle;
		if (_resolve) then {
			{
				_pylonsMags set [_forEachIndex,[
					_x
					,["getPylonMagAmmo",[_vehicle,_forEachIndex]] call MPSF_fnc_virtualDepot
					,getNumber (configfile >> "CfgMagazines" >> _x >> "count")
				]];
			} forEach _pylonsMags;
		};
		//diag_log format ["getPylonsMags | _pylonsMags:%1",_pylonsMags];
		_pylonsMags
	};
	case "getPylonMag" : {
		_params params [
			["_vehicle",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]
			,["_pylonID",(['getTargetCenterPylon'] call MPSF_fnc_virtualDepot),[0]]
			,["_resolve",false,[false]]
		];
		if (isNull _vehicle || _pylonID < 0) exitWith {
			if (_resolve) then { ["",0,0] } else { "" };
		};
		private _pylonsMags = ["getPylonsMags",[_vehicle,_resolve]] call MPSF_fnc_virtualDepot;
		if (count _pylonsMags <= _pylonID) exitWith { if (_resolve) then { ["",0,0] } else { "" }; };
		//diag_log format ["getPylonMag 2 | _pylonsMags:%1 | _pylonID:%2",_pylonsMags,_pylonID];
		_pylonsMags select _pylonID;
	};
	case "setPylonMag" : {
		_params params [
			["_vehicle",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]
			,["_pylonID",(['getTargetCenterPylon'] call MPSF_fnc_virtualDepot),[0]]
			,["_magazine","",[""]]
			,["_ammo",-1,[0]]
		];
		if (isNull _vehicle || _pylonID < 0) exitWith {false};
		if (_magazine isEqualTo "") then {
			private _removedMag = ["getPylonMag",[_vehicle,_pylonID]] call MPSF_fnc_virtualDepot;
			if !(_removedMag isEqualTo "") then {
				_vehicle setPylonLoadOut [(_pylonID + 1),_magazine,true];
			};
		} else {
			private _owner = ["getPylonOwner",[_vehicle,_pylonID]] call MPSF_fnc_virtualDepot;
			_vehicle setPylonLoadOut [(_pylonID + 1),_magazine,true,_owner];
			if (_ammo >= 0) then {
				["setPylonMagAmmo",[_vehicle,_pylonID,_ammo]] call MPSF_fnc_virtualDepot;
			};
		};
		true
	};
	case "setPylonMagPercent" : {
		_params params [
			["_vehicle",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]
			,["_pylonID",(['getTargetCenterPylon'] call MPSF_fnc_virtualDepot),[0]]
			,["_magazine","",[""]]
			,["_ammo",-1,[0]]
		];
		if (isNull _vehicle || _pylonID < 0) exitWith {false};
		["setPylonMag",[_vehicle,_pylonID,_magazine]] call MPSF_fnc_virtualDepot;
		["setPylonMagAmmoPercent",[_vehicle,_pylonID,_ammo]] call MPSF_fnc_virtualDepot;
		true;
	};
	case "getPylonMagAmmo" : {
		_params params [
			["_vehicle",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]
			,["_pylonID",(['getTargetCenterPylon'] call MPSF_fnc_virtualDepot),[0]]
		];
		if (isNull _vehicle || _pylonID < 0) exitWith { 0 };
		_vehicle ammoOnPylon (_pylonID + 1);
	};
	case "setPylonMagAmmo" : {
		_params params [
			["_vehicle",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]
			,["_pylonID",(['getTargetCenterPylon'] call MPSF_fnc_virtualDepot),[0]]
			,["_ammo",0,[0]]
		];
		if (isNull _vehicle || _pylonID < 0) exitWith {false};
		private _maxAmmo = 0 max ((configfile >> "CfgMagazines" >> (["getPylonMag",[_vehicle,_pylonID]] call MPSF_fnc_virtualDepot) >> "count") call MPSF_fnc_getCfgDataNumber);
		_vehicle setAmmoOnPylon [(_pylonID + 1),_ammo min _maxAmmo];
		true
	};
	case "setPylonMagAmmoPercent" : {
		_params params [
			["_vehicle",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]
			,["_pylonID",(['getTargetCenterPylon'] call MPSF_fnc_virtualDepot),[0]]
			,["_ammo",0,[0]]
		];
		if (isNull _vehicle || _pylonID < 0) exitWith {false};
		private _maxAmmo = 0 max ((configfile >> "CfgMagazines" >> (["getPylonMag",[_vehicle,_pylonID]] call MPSF_fnc_virtualDepot) >> "count") call MPSF_fnc_getCfgDataNumber);
		_vehicle setAmmoOnPylon [(_pylonID + 1),floor(_ammo * _maxAmmo)];
		true
	};
	case "hasPylonMag" : {
		_params params [
			["_vehicle",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]
			,["_pylonID",(['getTargetCenterPylon'] call MPSF_fnc_virtualDepot),[0]]
		];
		private _pylonsMag = ["getPylonMag",[_vehicle,_pylonID]] call MPSF_fnc_virtualDepot;
		//diag_log format ["hasPylonMag | _pylonsMag:%1",str_pylonsMag];
		!(_pylonsMag isEqualTo "")
	};
	case "isPylonMagFull" : {
		_params params [
			["_vehicle",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]
			,["_pylonID",(['getTargetCenterPylon'] call MPSF_fnc_virtualDepot),[0]]
		];
		if (isNull _vehicle || _pylonID < 0) exitWith { false };
		private _pylonMag = ["getPylonMag",[_vehicle,_pylonID]] call MPSF_fnc_virtualDepot;
		private _maxAmmo = ((configfile >> "CfgMagazines" >> _pylonMag >> "count") call MPSF_fnc_getCfgDataNumber) max 1;
		private _pylonsMagAmmo = ["getPylonMagAmmo",[_vehicle,_pylonID]] call MPSF_fnc_virtualDepot;
		//diag_log format ["isPylonMagFull | _pylonMag: %1 | _maxAmmo: %2 | _pylonsMagAmmo: %3",_pylonMag,_maxAmmo,_pylonsMagAmmo];
		_pylonsMagAmmo == _maxAmmo;
	};
	case "isPylonMagCompatible" : {
		_params params [
			["_vehicle",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]
			,["_pylonID",(['getTargetCenterPylon'] call MPSF_fnc_virtualDepot),[0]]
			,["_magazine","",[""]]
		];
		if (isNull _vehicle || _pylonID < 0) exitWith { false };
		if (_magazine isEqualTo "") exitWith {true};

		private _pylonHardpoints = (["getCfgPylon",[_vehicle,_pylonID]] call MPSF_fnc_virtualDepot) select 1;
		private _magHardPoints = (configFile >> "CfgMagazines" >> _magazine >> "hardpoints") call MPSF_fnc_getCfgDataArray;

		count (_pylonHardpoints arrayIntersect _magHardPoints) > 0
	};
	case "getPylonPositions" : {
		_params params [["_vehicle",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]];
		private _pylons = ["getPylonsMags",[_vehicle,false]] call MPSF_fnc_virtualDepot;
		private _hardPoints = [];
		{
			private _cfgHardPoints = ["CfgVirtualDepot","hardpoints",configName _x,"positions"] call MPSF_fnc_getCfgDataArray;
			_cfgHardPoints = _cfgHardPoints apply {if (_x isEqualType "") then {_vehicle selectionPosition _x} else {_x}};
			if (count (_cfgHardPoints select {!(_x isEqualTo [0,0,0])}) > 0) exitWith {
				_hardPoints =+ _cfgHardPoints;
			};
		} forEach ([(configFile >> "CfgVehicles" >> typeOf _vehicle)] call BIS_fnc_returnParents);

		if (count _hardPoints == 0) then {
			(_vehicle call BIS_fnc_boundingBoxDimensions) params ["_sizeX","_sizeY","_sizeZ"];
			private _step = _sizeX / (count _pylons - 1);

			_hardPoints resize (count _pylons);
			private _rightIndex = (count _hardPoints) - 1;
			private _leftIndex = 0;

			{
				if ((_forEachIndex + 1) % 2 == 0) then {
					_hardPoints set [_forEachIndex,[(_leftIndex * _step) - (_sizeX/2),0,-1.5]];
					_leftIndex = _leftIndex + 1;
				} else {
					_hardPoints set [_forEachIndex,[(_rightIndex * _step) - (_sizeX/2),0,-1.5]];
					_rightIndex = _rightIndex - 1;
				};
			} forEach _pylons;
		};

		{
			if (_x isEqualTo [0,0,0]) then {
				_hardPoints set [_forEachIndex,[_forEachIndex - ((count _pylons)/ 2),0,-1.5]];
			};
		} forEach _hardPoints;

		_hardPoints;
	};
	case "clearPylonLoadout" : {
		_params params [["_vehicle",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]];
		if (isNull _vehicle) exitWith {};

		private _pylons = ["getPylonsMags",[_vehicle,true]] call MPSF_fnc_virtualDepot;
		{
			["setPylonMag",[_vehicle,_forEachIndex,"",0]] call MPSF_fnc_virtualDepot;
		} forEach _pylons;
		["syncWeaponLoadout",[_vehicle]] call MPSF_fnc_virtualDepot;
		true;
	};
	case "syncWeaponLoadout" : {
		_params params [["_vehicle",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]];
		if (isNull _vehicle) exitWith {};

		private _pylons = ["getPylonsMags",[_vehicle,true]] call MPSF_fnc_virtualDepot;
		{
			["setPylonMag",[_vehicle,_forEachIndex,"",0]] call MPSF_fnc_virtualDepot;
		} forEach _pylons;

		private _nonPylonWeapons = [];
		{ _nonPylonWeapons append getArray (_x >> "weapons") } forEach ([_vehicle,configNull] call BIS_fnc_getTurrets);
		{ _vehicle removeWeaponGlobal _x } forEach ((weapons _vehicle) - (_nonPylonWeapons));
		_vehicle setVehicleAmmo 1;

		{
			["setPylonMag",[_vehicle,_forEachIndex,(_x select 0),(_x select 1)]] call MPSF_fnc_virtualDepot;
		} forEach (_pylons);
	};
	case "getCfgMagazineDisplayName" : {
		_params params [["_magazine","",[""]]];
		if (_magazine isEqualTo "") exitWith { "Empty"; };
		getText (configfile >> "CfgMagazines" >> _magazine >> "displayName");
	};
	case "getCfgPylons" : {
		_params params [["_vehicle",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]];
		if (isNull _vehicle) exitWith { [] };
		private _pylonCfg = (configfile >> "CfgVehicles" >> typeOf _vehicle >> "Components" >> "TransportPylonsComponent" >> "pylons");
		private _pylons = (_pylonCfg call BIS_fnc_getCfgSubClasses);// select { (toLower _x) find 'dummy' < 0 };
		_pylons apply {
			[
				_x
				,(_pylonCfg >> _x >> "hardpoints") call MPSF_fnc_getCfgDataArray
				,(_pylonCfg >> _x >> "turret") call MPSF_fnc_getCfgDataArray
			]
		};
	};
	case "getCfgPylon" : {
		_params params [
			["_vehicle",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]
			,["_pylonID",(['getTargetCenterPylon'] call MPSF_fnc_virtualDepot),[0]]
		];
		private _pylons = ["getCfgPylons",[_vehicle]] call MPSF_fnc_virtualDepot;
		if (count _pylons == 0) exitWith { /*["No Valid Pylons Found for %1 for pylon %2",_vehicle,_pylonID] call BIS_fnc_error;*/ ["","",[]]; };
		_pylons select _pylonID;
	};
	case "getCfgHardPoints" : {
		_params params [["_vehicle",(['getTargetCenter'] call MPSF_fnc_virtualDepot),[objNull]]];
		if (isNull _vehicle) exitWith { [] };
		private _hardPoints = [];
		private _pylons = ["getCfgPylons",[_vehicle]] call MPSF_fnc_virtualDepot;
		{ _hardPoints append (_x select 1); } forEach _pylons;
		_hardPoints;
	};
// Functions
	case "getTargetCenter" : { missionNamespace getVariable ["MPSF_VehicleDepot_Center",objNull]; };
	case "setTargetCenter" : {
		_params params [["_center",objNull,[objNull]],["_destroy",true,[false]]];
		private _centerOld = ["getTargetCenter"] call MPSF_fnc_virtualDepot;
		if !(isNull _centerOld) then {
			if !(_centerOld isKindOf "Man") then {
				if (!(["isDeployed",[_centerOld]] call MPSF_fnc_virtualDepot) && _destroy) then {
					deleteVehicle _centerOld;
				};
			};
		};
		if !(isNull _center) then {
			missionNamespace setVariable ["MPSF_VehicleDepot_Center",_center];
			["setCameraTarget",[_center]] call MPSF_fnc_CameraUI;
			["setDeployed",[_center,false]] call MPSF_fnc_virtualDepot;
		} else {
			missionNamespace setVariable ["MPSF_VehicleDepot_Center",nil];
		};
	};
	case "getTargetCenterPylon" : { missionNamespace getVariable ["virtualDepotSelectedVehiclePylonID",-1]; };
	case "setTargetCenterPylon" : {
		_params params [["_pylonID",-1,[0]]];
		missionNamespace setVariable ["virtualDepotSelectedVehiclePylonID",_pylonID];
	};
	case "clearVehicleCargo" : {
		_params params [["_center",(["getTargetCenter"] call MPSF_fnc_virtualDepot),[objNull]]];
		if (isNull _center) exitWith {false};
		clearWeaponCargoGlobal _center;
		clearItemCargoGlobal _center;
		clearBackpackCargoGlobal _center;
		clearMagazineCargoGlobal _center;
		true;
	};
	case "getDamage" : {
		_params params [["_center",(["getTargetCenter"] call MPSF_fnc_virtualDepot),[objNull]],["_state",true,[false]]];
		if (isNull _center) exitWith {0};
		private _return = 0;
		{ _return = _return max _x; } forEach ((getAllHitPointsDamage _center) select 2);
		_return;
	};
	case "allowDamage" : {
		_params params [["_center",(["getTargetCenter"] call MPSF_fnc_virtualDepot),[objNull]],["_state",true,[false]]];
		if (isNull _center) exitWith {false};
		_center allowDamage _state;
		true;
	};
	case "vehicleLock" : {
		_params params [["_center",(["getTargetCenter"] call MPSF_fnc_virtualDepot),[objNull]],["_state",0,[0]]];
		if (isNull _center) exitWith {false};
		_center lock _state;
		true;
	};
	case "setVehiclePosition" : {
		_params params [["_center",(["getTargetCenter"] call MPSF_fnc_virtualDepot),[objNull]],["_postion",[],[[],objNull]],["_direction",0,[0]]];
		if (isNull _center) exitWith {false};
		if (_postion isEqualType objNull) then {
			_direction = getDir _postion;
			_postion = _postion call BIS_fnc_position;
		};
		if (_postion isEqualTo []) exitWith {false};
		_center setVehiclePosition [_postion,[],0,"CAN_COLLIDE"];
		_center setDir _direction;
		_center setVelocity [0,0,0];
		true
	};
	case "deployCenter" : {
		_params params [["_center",(["getTargetCenter"] call MPSF_fnc_virtualDepot),[objNull]]];
		["syncWeaponLoadout",[_center]] call MPSF_fnc_virtualDepot;

		private _cfg = (configFile >> "CfgVehicles" >> typeOf _center);
		if (getnumber (_cfg >> "isUAV") == 1) then { createVehicleCrew _center; };

		["setDeployed",[_center,true]] call MPSF_fnc_virtualDepot;
		["allowDamage",[_center,true]] call MPSF_fnc_virtualDepot;
		["vehicleLock",[_center,0]] call MPSF_fnc_virtualDepot;
		["setTargetCenter",[objNull]] call MPSF_fnc_virtualDepot;
		["setTargetCenterPylon",[]] call MPSF_fnc_virtualDepot;
		["closeDepotUI"] call MPSF_fnc_virtualDepot;
		["onDeployVehicle",[_center,player],side group player] call MPSF_fnc_triggerEventHandler;
		if (["isMHQ",[_center]] call MPSF_fnc_virtualDepot) then {
			[_center,side group player] call (missionNamespace getVariable ["MPSF_fnc_createMHQ",{}]);
		};
		_center setFuel 1;
	};
	case "setDeployed" : {
		_params params [["_target",objNull,[objNull]],["_deployed",true,[false]]];
		_target setVariable ["isDeployed",_deployed,true];
	};
	case "isDeployed" : {
		_params params [["_target",objNull,[objNull]]];
		_target getVariable ["isDeployed",true];
	};
	case "setMHQ" : {
		_params params [["_target",objNull,[objNull]],["_isMHQ",false,[false]]];
		_target setVariable ["isMHQ",_isMHQ,true];
	};
	case "isMHQ" : {
		_params params [["_target",objNull,[objNull]],["_default",false,[false]]];
		_target getVariable ["isMHQ",_default];
	};
	case "clearDepot" : {};
	case "getVehiclesInDepot" : {
		_params params [["_depotLogic",objNull,[objNull,""]]];
		if (_depotLogic isEqualType "") then {
			_depotLogic = _depotLogic call BIS_fnc_objectFromNetId;
		};
		if (isNull _depotLogic) exitWith { [] };
		private _trigger = _depotLogic getVariable ["VirtualDepot_Trigger",objNull];
		private _nearbyObjects = nearestObjects [_depotLogic,["AllVehicles"],(["getCfgSupplyRadius"] call MPSF_fnc_virtualDepot)];
		private _nearbyObjects = _nearbyObjects select { _x inArea _trigger && !(_x isKindOf "Man"); };
		_nearbyObjects;
	};
	case "isDepotOccupied" : {
		_params params [["_depotLogic",objNull,[objNull,""]]];
		private _nearbyVehicles = ["getVehiclesInDepot",[_depotLogic]] call MPSF_fnc_virtualDepot;
		count _nearbyVehicles > 0;
	};
	case "isOpenPylonUI" : { !(isNull(uiNamespace getVariable ["MPSF_DALE_DisplayID",displayNull])); };
	case "preLoadVehicles" : {
		_params params [["_depotLogic",objNull,[objNull]]];
		if (isNull _depotLogic) exitWith { /*["Unable to retrieve depot logic attached to trigger"] call BIS_fnc_error;*/ };

		private _data = _depotLogic getVariable ["vehicles",[]];
		if (count (_data) > 0) exitWith {_data};

		private _classTypes = (_depotLogic getVariable ["MPSF_Module_VehicleDepot_Classnames_F",["All"]]) apply { toLower _x; };
		private _defaultCrew = gettext (configfile >> "cfgvehicles" >> "All" >> "crew");

		for "_i" from 0 to 4 do {
			_data set [_i,[]];
		};

		private _forcedInDepot = ["getCfgForceInDepot"] call MPSF_fnc_virtualDepot;
		private _mhqClassnames = ["getCfgClassnamesMHQ"] call MPSF_fnc_virtualDepot;
		private _cfgVehicles = "isclass _x && {getnumber (_x >> 'scope') == 2} && {gettext (_x >> 'crew') != _defaultCrew}" configclasses (configfile >> "cfgvehicles");
		private _side = _depotLogic getVariable ["VirtualDepot_Side",-1];
		if (_side >= 0) then {
			_cfgVehicles = _cfgVehicles select { getNumber(_x >> "side") == _side };
		};

		{
			private _cfgObject = _x;
			private _parents = ([_cfgObject,true] call BIS_fnc_returnParents) apply {toLower _x};
			if (count (_parents arrayIntersect _classTypes) > 0) then {
				private _simulation = gettext (_cfgObject >> "simulation");
				_items = switch (tolower _simulation) do {
					case "car";
					case "carx" : {
						_data select 0; // CAR
					};
					case "tank";
					case "tankx" : {
						if (getnumber (_cfgObject >> "maxspeed") > 0) then {
							_data select 1; // ARMOUR
						} else {
							[]; //_data select 5; // Static
						};
					};
					case "helicopter";
					case "helicopterx";
					case "helicopterrtd" : {
						_data select 2; // HELICOPTER
					};
					case "airplane";
					case "airplanex" : {
						_data select 3; // AIRPLANE
					};
					case "ship";
					case "shipx";
					case "submarinex" : {
						_data select 4; // BOAT
					};
					default { [] };
				};
				private _model = tolower gettext (_cfgObject >> "model");
				if (
					getnumber (_cfgObject >> "forceInGarage") > 0
					|| toLower (configName _cfgObject) IN _forcedInDepot
				) then {
					_model = _model + ":" + configname _cfgObject;
				};
				_modelID = (_items apply {_x select 0}) find _model;
				if (_modelID < 0) then {
					_modelID = count _items;
					_items pushback [_model,[]];
				};
				_modelData = (_items select _modelID) select 1;
				_modelData pushback configname _cfgObject;


				if (count (_parents arrayIntersect _mhqClassnames) > 0) then {
					_modelMHQ = _model + ":MHQ";
					_modelMHQID = (_items apply {_x select 0}) find _modelMHQ;
					if (_modelMHQID < 0) then {
						_modelMHQID = count _items;
						_items pushback [_modelMHQ,[]];
					};
					_modelMHQData = (_items select _modelMHQID) select 1;
					_modelMHQData pushback configname _cfgObject;
				};

			};
		} foreach _cfgVehicles;
		_depotLogic setVariable ["vehicles",_data];
	};
// Actions
	case "createTriggerAction" : {
		if (hasInterface) then {
			_params params [["_depotLogic",objNull,[objNull]],["_target",-1,[0]],["_resource","",[""]]];

			if !(isNull (_depotLogic getVariable ["VirtualDepot_Trigger",objNull])) exitWith {};

			private _supplyRadius = ["getCfgSupplyRadius"] call MPSF_fnc_virtualDepot;
			private _trigger = createTrigger ["EmptyDetector",_depotLogic,false];
			_trigger setTriggerArea [_supplyRadius,_supplyRadius,getDir _depotLogic,false,4];
			_trigger setTriggerActivation ["ANYPLAYER","PRESENT",true];
			_trigger setTriggerStatements ["(vehicle player) in thisList"
				,format["['activateDepot',[thisTrigger,thisList]] call MPSF_fnc_virtualDepot;"]
				,format["['deactivateDepot',[thisTrigger]] call MPSF_fnc_virtualDepot;"]
			];
			_trigger attachTo [_depotLogic,[0,0,0]];
			_depotLogic setVariable ["VirtualDepot_Trigger",_trigger];
			if (_target >= 0) then {
				_depotLogic setVariable ["VirtualDepot_Side",_target];
			};
			["preLoadVehicles",[_depotLogic]] spawn MPSF_fnc_virtualDepot;
		};
	};
	case "activateDepot" : {
		_params params [["_trigger",objNull],["_target",[],[[]]]];
		if !((vehicle player) in _list) exitWith {};

		private _depotLogic = attachedTo _trigger;
		if (isNull _depotLogic) exitWith { /*["Unable to retrieve depot logic attached to trigger"] call BIS_fnc_error;*/ };

		if !(isNull (_depotLogic getVariable ["ActiveUser",objNull])) exitWith {
			(triggerArea _trigger) params ["_triggerA","_triggerB"];
			(vehicle player) setVehiclePosition [(player getPos [abs((player distance2D _trigger) - _triggerA) + 1.0,_depotLogic getDir player]),[],0,"NONE"];
			["<t color='#ff0000' size = '.8'><img image='\a3\ui_f_curator\Data\CfgMarkers\minefieldap_ca.paa'/><br />Vehicle Depot is ACTIVE. Do Not Enter!</t>"] spawn BIS_fnc_dynamicText;
		};

		if (["getCfgDepotPylonInteraction"] call MPSF_fnc_virtualDepot) then {
			// Access Vehicle Depot
			["MPSF_VirtualDepot_openUI",player,"Access Virtual Depot",[
					["mpsf\data\holdactions\holdAction_depot_ca.paa",{}]
					,["mpsf\data\holdactions\holdAction_depot_ca.paa",{}]
					,{ ["openDepotUI",(_this select 3)] spawn MPSF_fnc_virtualDepot; }
					,{}
					,1,false,103
				],[_depotLogic],
					format ["!(['isDepotOccupied',[%1]] call MPSF_fnc_virtualDepot)",str (_depotLogic call BIS_fnc_netId)]
					+ " && vehicle player isEqualTo player"
				,true,false,105
			] spawn {sleep 0.1; _this call MPSF_fnc_addAction};
			["MPSF_VirtualDepot_occupied_openUI",player,"Swap Depot Vehicle"
				,{ ["openDepotUI",(_this select 3)] spawn MPSF_fnc_virtualDepot; }
				,[_depotLogic]
				,format ["(['isDepotOccupied',[%1]] call MPSF_fnc_virtualDepot)",str (_depotLogic call BIS_fnc_netId)]
					+ " && (['getTargetCenterPylon'] call MPSF_fnc_virtualDepot) < 0"
					+ " && vehicle player isEqualTo player"
				,true,false,105
			] spawn {sleep 0.1; _this call MPSF_fnc_addAction};
			// DALE Start
			["MPSF_DALE_start_action",player,"Service Vehicle",[
					["mpsf\data\holdactions\holdAction_repair_ca.paa",{}]
					,["mpsf\data\holdactions\holdAction_repair_ca.paa",{}]
					,{ ["startDale",[cursorObject]] spawn MPSF_fnc_virtualDepot; }
					,{},1,false
				],[_depotLogic],
					"cursorObject isKindOf 'Air'"
					+ " && cursorObject distance player < 15"
					+ " && vehicle player isEqualTo player"
					+ " && (isNull (['getTargetCenter'] call MPSF_fnc_virtualDepot))"
					+ " && !((['getTargetCenterPylon'] call MPSF_fnc_virtualDepot) >= 0)"
					+ format [" && (['isDepotOccupied',[%1]] call MPSF_fnc_virtualDepot)",str (_depotLogic call BIS_fnc_netId)]
				,true,false,100
			] spawn {sleep 0.2; _this call MPSF_fnc_addAction};
			// DALE Set Pylon Mag
			["MPSF_DALE_setMag_action",player,"Set Pylon",[
					["mpsf\data\holdactions\holdAction_missile_ca.paa",{}]
					,["mpsf\data\holdactions\holdAction_missile_ca.paa",{}]
					,{ ["openPylonUI"] call MPSF_fnc_virtualDepot; }
					,{},0.6,false
				],[_depotLogic],
					"(['getTargetCenterPylon'] call MPSF_fnc_virtualDepot) >= 0"
					 + " && vehicle player isEqualTo player"
					 + " && {(['isPylonMagFull'] call MPSF_fnc_virtualDepot)"
					 + " || !(['hasPylonMag'] call MPSF_fnc_virtualDepot)}"
					 + format [" && (['isDepotOccupied',[%1]] call MPSF_fnc_virtualDepot)",str (_depotLogic call BIS_fnc_netId)]
				,true,false,101
			] spawn {sleep 0.3; _this call MPSF_fnc_addAction};
			// DALE Set Pylon Ammo
			["MPSF_DALE_loadMag_action",player,"Load Ordinance",[
					["mpsf\data\holdactions\holdAction_magazine_ca.paa",{ ["setPylonMagAmmoPercent",[nil,nil,0]] call MPSF_fnc_virtualDepot; }]
					,["mpsf\data\holdactions\holdAction_magazine_ca.paa",{ ["setPylonMagAmmoPercent",[nil,nil,(_this select 4)/24]] call MPSF_fnc_virtualDepot; }]
					,{ ["setPylonMagAmmoPercent",[nil,nil,1]] call MPSF_fnc_virtualDepot; }
					,{ false },(["getCfgOrdinanceDuration"] call MPSF_fnc_virtualDepot),false
				],[_depotLogic],
					"(['hasPylonMag'] call MPSF_fnc_virtualDepot)"
					+ " && !(['isPylonMagFull'] call MPSF_fnc_virtualDepot)"
					+ " && vehicle player isEqualTo player"
				,true,false,102
			] spawn {sleep 0.4; _this call MPSF_fnc_addAction};
		} else {
			// Access Vehicle Depot
			["MPSF_VirtualDepot_openUI",player,"Access Virtual Depot",[
				["mpsf\data\holdactions\holdAction_depot_ca.paa",{}]
				,["mpsf\data\holdactions\holdAction_depot_ca.paa",{}]
				,{ ["openDepotUI",(_this select 3)] spawn MPSF_fnc_virtualDepot; }
				,{}
				,1,false,103
			],[_depotLogic],
				"vehicle player isEqualTo player"
			,true,false,105] spawn {sleep 0.1; _this call MPSF_fnc_addAction};
		};
	};
	case "deactivateDepot" : {
		["endDale"] call MPSF_fnc_virtualDepot;
		["MPSF_DALE_start_action",player] call MPSF_fnc_removeAction;
		["MPSF_DALE_setMag_action",player] call MPSF_fnc_removeAction;
		["MPSF_DALE_loadMag_action",player] call MPSF_fnc_removeAction;
		["MPSF_VirtualDepot_openUI",player] call MPSF_fnc_removeAction;
		["MPSF_VirtualDepot_occupied_openUI",player] call MPSF_fnc_removeAction;
	};
// Event Handlers
	case "eventHandlers" : {
		// Vehicle Bays Open
		["DALE_aircraftLoadoutStart_EH","aircraftLoadoutStart",{ ["aircraftLoadoutStart",_this] call MPSF_fnc_virtualDepot; }] call MPSF_fnc_addEventHandler;
		["DALE_aircraftLoadoutEnd_EH","aircraftLoadoutEnd",{ ["aircraftLoadoutEnd",_this] call MPSF_fnc_virtualDepot; }] call MPSF_fnc_addEventHandler;

		// Add new supply points
		["MPSF_DALE_onDALESupplypointCreate_EH","onDALESupplypointCreate",{ ["createTriggerAction",_this] call MPSF_fnc_virtualDepot; }] call MPSF_fnc_addEventHandler;

		// Deployed Vehicle
		["MPSF_VirtualDepot_onDeployVehicle_EH","onDeployVehicle",{
			params [["_center",objNull,[objNull]],["_player",objNull,[objNull]]];
			private _lastRun = missionNamespace getVariable ["MPSF_VirtualDepot_onDeployVehicle_LastRun",MISSIONTIME];
			if !(_lastRun > MISSIONTIME) then {
				missionNamespace setVariable ["MPSF_VirtualDepot_onDeployVehicle_LastRun",MISSIONTIME + 30];
				switch (true) do {
					case (_center isKindOf "Helicopter") : {
						[sideunknown,selectRandom ["mp_groundsupport_10_newchopper_BHQ_0","mp_groundsupport_10_newchopper_BHQ_1","mp_groundsupport_10_newchopper_BHQ_2"]] call BIS_fnc_sayMessage;
					};
					default {
						[sideunknown,"SentGenBaseUnlockVehicle"] call BIS_fnc_sayMessage;
					};
				};
			};
			((_player call BIS_fnc_objectSide) call BIS_fnc_moduleHQ) sideChat format ["%1 deployed by %2",[_center] call MPSF_fnc_getCfgText,name _player]; // TODO: localize
		}] call MPSF_fnc_addEventHandler;

		// Depo Vehicle ?Init
		["MPSF_VirtualDepot_onUpdateVehicleInit_EH","onUpdateVehicleInit",{ if (local (_this select 0)) then { _this call BIS_fnc_initVehicle; }; }] call MPSF_fnc_addEventHandler;
		["MPSF_VirtualDepot_onVehicleDepotCreate_EH","onVehicleDepotCreate",{ ["createTriggerAction",_this] call MPSF_fnc_virtualDepot; }] call MPSF_fnc_addEventHandler;
	};
	case "aircraftLoadoutStart" : {
		_params params [["_vehicle",objNull,[objNull]]];
		if !(local _vehicle) exitWith {};
		// Open Aircraft Bays
		{
			["toggleBay",[_vehicle,_forEachIndex,1]] call MPSF_fnc_virtualDepot;
			["togglePylon",[_vehicle,_forEachIndex,1]] call MPSF_fnc_virtualDepot;
		} forEach (getPylonMagazines _vehicle);
	};
	case "aircraftLoadoutEnd" : {
		_params params [["_vehicle",objNull,[objNull]]];
		if !(local _vehicle) exitWith {};
		// Reset Aircraft Bays
		{
			["toggleBay",[_vehicle,_forEachIndex,-1]] call MPSF_fnc_virtualDepot;
			["togglePylon",[_vehicle,_forEachIndex,-1]] call MPSF_fnc_virtualDepot;
		} forEach (getPylonMagazines _vehicle);
	};
// Configuration
	case "getCfgSupplyRadius" : { (["CfgVirtualDepot","supplyRadius"] call MPSF_fnc_getCfgDataNumber) max 5; };
	case "getCfgForceInDepot" : { (["CfgVirtualDepot","forceInDepot"] call MPSF_fnc_getCfgDataArray) apply {toLower _x}; };
	case "getCfgCompatiblePylons" : {
		private _compatiblePylonText = ["CfgVirtualDepot","compatiblePylonMags"] call MPSF_fnc_getCfgDataText;
		if !(_compatiblePylonText isEqualTo "" || {count _compatiblePylonText < 5}) exitWith { missionNamespace getVariable [_compatiblePylonText,false] };

		private _compatiblePylonParam = ["paramCompatiblePylonMags",-1] call BIS_fnc_getParamValue;
		if (_compatiblePylonParam in [0,1]) exitWith { [false,true] select _compatiblePylonParam; };

		["CfgVirtualDepot","compatiblePylonMags"] call MPSF_fnc_getCfgDataBool;
	};
	case "getCfgDepotPylonInteraction" : {
		private _interactPylonText = ["CfgVirtualDepot","externalPylonInteraction"] call MPSF_fnc_getCfgDataText;
		if !(_interactPylonText isEqualTo "" || {count _interactPylonText < 5}) exitWith { missionNamespace getVariable [_interactPylonText,false] };

		private _interactPylonParam = ["paramExternalPylonInteraction",-1] call BIS_fnc_getParamValue;
		if (_interactPylonParam in [0,1]) exitWith { [false,true] select _interactPylonParam; };

		["CfgVirtualDepot","externalPylonInteraction"] call MPSF_fnc_getCfgDataBool;
	};
	case "getCfgOrdinanceDuration" : {
		private _return = missionNamespace getVariable ["VirtualDepotLoadOrdinanceDuration",-1];
		if !(_return < 0) then { _return = ["paramLoadOrdinanceDuration",-1] call BIS_fnc_getParamValue; };
		if !(_return < 0) then { _return = ["CfgVirtualDepot","loadOrdinanceDuration"] call MPSF_fnc_getCfgDataNumber; };
		_return max 5;
	};
	case "getCfgVehicleLimits" : {
		_params params [["_cfg","",["",configFile]]];
		if (_cfg isEqualType "") then { _cfg = (configFile >> "CfgVehicles" >> _cfg); };
		private _parents = [_cfg,true] call BIS_fnc_returnParents;
		private _limit = [-1,-1];
		{
			private _classType = _x;
			private _classLimit = ["CfgVirtualDepot","VehicleLimit",_x] call MPSF_fnc_getCfgDataNumber;
			if !(_classLimit < 0) exitWith {
				_limit = [count (vehicles select { _x isKindOf _classType && ([_x,false] call BIS_fnc_objectSide) isEqualTo (side group player) }),_classLimit];
			};
		} forEach _parents;
		_limit;
	};
	case "getCfgClassnamesMHQ" : { (["CfgRespawnMP","MHQvehicles"] call MPSF_fnc_getCfgDataArray) apply {toLower _x}; };
	case "getCfgCarrierDepots" : {
		private _return = [];
		{
			private _carrierDepotID = _x;
			_return pushBack [
				_carrierDepotID
				,(["CfgVirtualDepot","CarrierDepots",_carrierDepotID,"position"] call MPSF_fnc_getCfgDataArray)
				,(["CfgVirtualDepot","CarrierDepots",_carrierDepotID,"direction"] call MPSF_fnc_getCfgDataNumber)
				,(["CfgVirtualDepot","CarrierDepots",_carrierDepotID,"classNames"] call MPSF_fnc_getCfgDataArray)
			];
		} forEach (["CfgVirtualDepot","CarrierDepots"] call BIS_fnc_getCfgSubClasses);
		_return;
	};
// Init
	case "init" : {
		if !(isServer) exitWith {};

		_params params [
			["_depotLogic",objNull,[objNull,[]]]
			,["_classNames",[],[[]]]
			,["_target",-1,[0]]
			,["_supplyStates",[true,true,true],[[]]]
		];

		if (_depotLogic isEqualType []) then {
			_depotLogic = [_depotLogic,0] call MPSF_fnc_createLogic;
		};
		_depotLogic setVariable ["MPSF_Module_VehicleDepot_F",true,true];
		_depotLogic setVariable ["MPSF_Module_VehicleDepot_Classnames_F",_classNames,true];

		private _depots = missionNamespace getVariable ["MPSF_VehicleDepot_positions",[]];
		_depots pushBack [_depotLogic,_target];
		missionNamespace setVariable ["MPSF_VehicleDepot_positions",_depots];
		publicVariable "MPSF_VehicleDepot_positions";

		["onVehicleDepotCreate",[_depotLogic,_target],0] call MPSF_fnc_triggerEventHandler;
	};
	case "postInit" : {
		// Init Supply Points
		{ ["createTriggerAction",_x] call MPSF_fnc_virtualDepot; } forEach (missionNamespace getVariable ["MPSF_VehicleDepot_positions",[]]);
		// Add Event Handlers
		["eventHandlers"] call MPSF_fnc_virtualDepot;
	};
};