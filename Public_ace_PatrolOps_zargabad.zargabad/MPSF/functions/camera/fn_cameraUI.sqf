disableSerialization;
params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "Mouse": {
		_params params [["_ctrl",controlNull,[controlNull]],"_mX","_mY"];
		missionNamespace setVariable ["MPSF_CameraUI_Mouse",[_mX,_mY]];

		private _cam = missionNamespace getVariable ["MPSF_CameraUI_Camera",objnull];
		private _center = missionNamespace getVariable ["MPSF_CameraUI_Center",player];
		private _target = missionNamespace getVariable ["MPSF_CameraUI_Target",player];

		_dis = MPSF_CameraUI_Position select 0;
		_dirH = MPSF_CameraUI_Position select 1;
		_dirV = MPSF_CameraUI_Position select 2;
		_targetPos = MPSF_CameraUI_Position select 3;
		_disLocal = _dis;

		_LMB = MPSF_CameraUI_Buttons select 0;
		_RMB = MPSF_CameraUI_Buttons select 1;

		if (isnull _ctrl) then {_LMB = [0,0];};

		if (count _LMB > 0) then {
			_cX = _LMB select 0;
			_cY = _LMB select 1;
			_dX = (_cX - _mX);
			_dY = (_cY - _mY);
			MPSF_CameraUI_Buttons set [0,[_mX,_mY]];

			_centerBox = boundingboxreal _center;
			_centerSizeBottom = _centerBox select 0 select 2;
			_centerSizeUp = _centerBox select 1 select 2;
			_centerSize = sqrt ([_centerBox select 0 select 0,_centerBox select 0 select 1] distance [_centerBox select 1 select 0,_centerBox select 1 select 1]);
			_targetPos = [_targetPos,_dX * _centerSize,_dirH - 90] call BIS_fnc_relpos;
			_targetPos = [
				[0,0,((_targetPos select 2) - _dY * _centerSize) max _centerSizeBottom min _centerSizeUp],
				([[0,0,0],_targetPos] call BIS_fnc_distance2D) min _centerSize,
				[[0,0,0],_targetPos] call BIS_fnc_dirto
			] call BIS_fnc_relpos;
			//_targetPos set [2,(_targetPos select 2) max 0.1];
			_targetPos set [2,(_targetPos select 2) max ((boundingboxreal _center select 0 select 2) + 0.2)];

			//--- Do not let target go below ground
			_posZmin = 0.1;
			_targetWorldPosZ = (_center modeltoworldvisual _targetPos) select 2;
			if (_targetWorldPosZ < _posZmin) then {_targetPos set [2,(_targetPos select 2) - _targetWorldPosZ + _posZmin];};

			MPSF_CameraUI_Position set [3,_targetPos];
		};

		if (count _RMB > 0) then {
			_cX = _RMB select 0;
			_cY = _RMB select 1;
			_dX = (_cX - _mX) * 0.75;
			_dY = (_cY - _mY) * 0.75;
			_targetPos = [
				[0,0,_targetPos select 2],
				[[0,0,0],_targetPos] call BIS_fnc_distance2D,
				([[0,0,0],_targetPos] call BIS_fnc_dirto) - _dX * 180
			] call BIS_fnc_relpos;

			MPSF_CameraUI_Position set [1,(_dirH - _dX * 180) % 360];
			MPSF_CameraUI_Position set [2,(_dirV - _dY * 100) max -89 min 89];
			MPSF_CameraUI_Position set [3,_targetPos];
			MPSF_CameraUI_Buttons set [1,[_mX,_mY]];
		};

		if (isnull _ctrl) then {MPSF_CameraUI_Buttons = [[],[]];};
	};
	case "MouseButtonDown": {
		_params params ["_ctrl",["_key",0,[0]],["_xCord",0,[0]],["_yCord",0,[0]],["_shift",false,[false]],["_ctrl",false,[false]],["_alt",false,[false]]];
		MPSF_CameraUI_Buttons set [_key,[_xCord,_yCord]];
	};
	case "MouseButtonUp": {
		_params params ["_ctrl",["_key",0,[0]],["_xCord",0,[0]],["_yCord",0,[0]],["_shift",false,[false]],["_ctrl",false,[false]],["_alt",false,[false]]];
		MPSF_CameraUI_Buttons set [_key,[]];
	};
	case "MouseZChanged": {
		_params params ["_ctrl",["_change",0,[0]]];

		private _cam = (missionNamespace getVariable ["MPSF_CameraUI_Camera",objnull]);
		private _center = (missionNamespace getVariable ["MPSF_CameraUI_Center",player]);
		private _target = (missionNamespace getVariable ["MPSF_CameraUI_Target",player]);

		private _disMax = (((boundingboxreal _center select 0) vectordistance (boundingboxreal _center select 1)) * 2) max 10;
		private _disMin = _disMax * 0.15;
		private _dis = MPSF_CameraUI_Position select 0;
		private _z = (_dis)/_change;
		_dis = _dis - (_z / 10);
		_dis = _dis max _disMin min _disMax;
		MPSF_CameraUI_Position set [0,_dis];
	};
	case "setCameraTarget" : {
		_params params [["_center",objnull,[objNull]]];
		if (isNull _center) exitWith {};
		missionNamespace setVariable ["MPSF_CameraUI_Center",_center];

		private _target = missionNamespace getVariable ["MPSF_CameraUI_Target",player];
		_target attachto [_center,(missionNamespace getVariable ["MPSF_CameraUI_Position",[0,0,0]]) select 3,""];

		private _disMax = (((boundingboxreal _center select 0) vectordistance (boundingboxreal _center select 1)) * 2) max 10;
		MPSF_CameraUI_Position set [0,_disMax*0.6];
	};
	case "start": {
		if !(isnull (missionNamespace getVariable ["MPSF_CameraUI_Camera",objnull])) exitwith {
			//["CameraUI already active"] call BIS_fnc_error;
		};

		_params params [["_display",displayNull,[displayNull]],["_ctrlMouseArea",controlNull,[controlNull]],["_ctrlMouseBlock",controlNull,[controlNull]],["_center",player,[objNull]]];

		if (isNull _display) exitWith {
			//["CameraUI Display is NULL"] call BIS_fnc_error;
		};

		uiNamespace setVariable ["MPSF_CameraUI_Display",_display];
		missionNamespace setVariable ["MPSF_CameraUI_Center",_center];
		MPSF_CameraUI_Mouse = [0,0];
		MPSF_CameraUI_Buttons = [[],[]];
		MPSF_CameraUI_Action = "";

		_display displayaddeventhandler ["MouseButtonDown","with missionNamespace do {['MouseButtonDown',_this] call MPSF_fnc_CameraUI;};"];
		_display displayaddeventhandler ["MouseButtonUp","with missionNamespace do {['MouseButtonUp',_this] call MPSF_fnc_CameraUI;};"];
		//_display displayaddeventhandler ["KeyDown","with (missionNamespace) do {['KeyDown',_this] call MPSF_fnc_CameraUI;};"];

		_ctrlMouseArea ctrlAddEventHandler ["mousemoving","with missionNamespace do {['Mouse',_this] call MPSF_fnc_CameraUI;};"];
		_ctrlMouseArea ctrlAddEventHandler ["mouseholding","with missionNamespace do {['Mouse',_this] call MPSF_fnc_CameraUI;};"];
		_ctrlMouseArea ctrlAddEventHandler ["mousebuttonclick","with missionNamespace do {['TabDeselect',[ctrlparent (_this select 0),_this select 1]] call MPSF_fnc_CameraUI;};"];
		_ctrlMouseArea ctrlAddEventHandler ["mousezchanged","with missionNamespace do {['MouseZChanged',_this] call MPSF_fnc_CameraUI;};"];
		ctrlsetfocus _ctrlMouseArea;

		_ctrlMouseBlock ctrlenable false;
		_ctrlMouseBlock ctrlAddEventHandler ["setfocus",{_this spawn {disableserialization; (_this select 0) ctrlenable false; (_this select 0) ctrlenable true;};}];

		showhud false;

		_camPosVar = format ["BIS_fnc_arsenal_campos_%1",0];
		MPSF_CameraUI_Position = missionNamespace getVariable [_camPosVar,missionNamespace getVariable [_camPosVar,[10,-45,15,[0,0,-2]]]];
		MPSF_CameraUI_Position = +MPSF_CameraUI_Position;
		_target = createagent ["Logic",position _center,[],0,"none"];
		_target attachto [_center,MPSF_CameraUI_Position select 3,""];
		missionNamespace setvariable ["MPSF_CameraUI_Target",_target];

		_cam = "camera" camcreate position _center;
		_cam cameraeffect ["internal","back"];
		_cam campreparefocus [-1,-1];
		_cam campreparefov 0.35;
		_cam camcommitprepared 0;
		//cameraEffectEnableHUD true;
		showcinemaborder false;
		missionNamespace setVariable ["MPSF_CameraUI_Camera",_cam];
		MPSF_CameraUI_Camera = _cam;
		["#(argb,8,8,3)color(0,0,0,1)",false,nil,0,[0,0.5]] call BIS_fnc_textTiles;

		["MPSF_CameraUI_onEachFrame_EH","onEachFrame",{
			disableserialization;
			private _display = uiNamespace getVariable ["MPSF_CameraUI_Display",displayNull];
			if (isNull _display) exitWith { ["MPSF_CameraUI_onEachFrame_EH","onEachFrame"] call MPSF_fnc_removeEventHandler; };

			private _cam = missionNamespace getVariable ["MPSF_CameraUI_Camera",objnull];
			private _center = missionNamespace getVariable ["MPSF_CameraUI_Center",player];
			private _target = missionNamespace getVariable ["MPSF_CameraUI_Target",player];

			private _dis = MPSF_CameraUI_Position select 0;
			private _dirH = MPSF_CameraUI_Position select 1;
			private _dirV = MPSF_CameraUI_Position select 2;

			[_target,[_dirH + 180,-_dirV,0]] call BIS_fnc_setobjectrotation;
			_target attachto [_center,MPSF_CameraUI_Position select 3,""];

			_cam setpos (_target modeltoworld [0,-_dis,0]);
			_cam setvectordirandup [vectordir _target,vectorup _target];
			if ((getposasl _cam select 2) < (getposasl _center select 2)) then {
				_disCoef = ((getposasl _target select 2) - (getposasl _center select 2)) / ((getposasl _target select 2) - (getposasl _cam select 2) + 0.001);
				_cam setpos (_target modeltoworldvisual [0,-_dis * _disCoef,0]);
			};
		}] call MPSF_fnc_addEventHandler;

		["Mouse",[controlnull,0,0]] call MPSF_fnc_CameraUI;
	};
	case "end" : {
		["MPSF_CameraUI_onEachFrame_EH","onEachFrame"] call MPSF_fnc_removeEventHandler;
		_target = (missionNamespace getvariable ["MPSF_CameraUI_Target",player]);
		_cam = missionNamespace getvariable ["MPSF_CameraUI_Camera",objnull];
		_camData = [getposatl _cam,(getposatl _cam) vectorfromto (getposatl _target)];
		_cam cameraeffect ["terminate","back"];
		camdestroy _cam;
		deletevehicle _target;
		showhud true;
		player switchCamera "INTERNAL";
	};
};