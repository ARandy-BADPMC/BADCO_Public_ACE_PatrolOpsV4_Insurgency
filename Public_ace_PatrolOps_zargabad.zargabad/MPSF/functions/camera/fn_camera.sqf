/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_camera.sqf
	Author(s): see mpsf\credits.txt

	Description:
		System Camera Functions

	Parameter(s):
		0: String - Function
		1: ARRAY - Parameters

	Returns:
		Variable
*/
params [["_mode","",[""]],["_params",[]]];

switch (_mode) do {
/* Camera Manager: Camera */
	case "createCamera" : {
		_params params [["_cameraID","cameraObject",[""]],["_switchCam",true,[false]]];
		["getCamera",[_cameraID,true,_switchCam]] call MPSF_fnc_Camera;
	};
	case "getCamera" : {
		_params params [
			["_cameraID","cameraObject",[""]]
			,["_createCam",false,[false]]
			,["_switchCam",false,[false]]
			,["_destoryCam",false,[false]]
		];
		_cameraID = format ["PO4_Camera_var_entity%1",_cameraID];
		private _camera = missionNamespace getVariable [_cameraID,objNull];
		if (_createCam && isNull _camera) then {
			_camera = "camera" camCreate [0,0,0];
			missionNamespace setVariable [_cameraID,_camera];
		};
		if (_switchCam && !(isNull _camera)) then {
			_camera cameraEffect ["internal","back"];
		};
		if (_destoryCam && !(isNull _camera)) then {
			camDestroy _camera;
			if (hasInterface) then {
				player cameraEffect ["terminate","back"];
			};
			_camera = objNull;
			missionNamespace setVariable [_cameraID,_camera];
		};
		_camera;
	};
	case "destroyCamera" : {
		_params params [["_cameraID","cameraObject",[""]]];
		["getCamera",[_cameraID,nil,nil,true]] call MPSF_fnc_Camera;
	};
/* Camera Manager: Camera Lenses */
	case "updateCameraVision" : {
		_params params [["_states",[0,1,2,4,6,8],[[]]]];
		private _state = _states select ((uiNamespace getVariable ["RscDisplayRespawn_CameraVisionMode",0]) + 1) % (count _states);
		switch (_states select _state) do {
			case 0 : { call compile "camusenvg false; false SetCamUseTi 0;"; }; // Normal
			case 1 : { call compile "camusenvg true;  false SetCamUseTi 0;"; }; // NVG
			case 2 : { call compile "camusenvg false; true SetCamUseTi 0;"; }; // White Hot
			case 3 : { call compile "camusenvg false; true SetCamUseTi 1;"; }; // Black Hot
			case 4 : { call compile "camusenvg false; true SetCamUseTi 2;"; }; // Light Green Hot / Darker Green cold
			case 5 : { call compile "camusenvg false; true SetCamUseTi 3;"; }; // Black Hot / Darker Green cold
			case 6 : { call compile "camusenvg false; true SetCamUseTi 4;"; }; // Light Red Hot /Darker Red Cold
			case 7 : { call compile "camusenvg false; true SetCamUseTi 5;"; }; // Black Hot / Darker Red Cold
			case 8 : { call compile "camusenvg false; true SetCamUseTi 6;"; }; // White Hot . Darker Red Col
			case 9 : { call compile "camusenvg false; true SetCamUseTi 7;"; }; // Thermal
		};
		uiNamespace setVariable ["RscDisplayRespawn_CameraVisionMode",_state];
	};
};