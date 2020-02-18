if !(isServer) exitWith {};

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "showLayer" : {
		_params params [["_layers",[],[[]]],["_showLayers",[],[[]]]];
		//--- Hub - hide layers for later use
		{
			_layerName = _x;
			_layerObjects = missionnamespace getvariable [format ["MPSF_layer_%1",_layerName],[]];
			_layerExplosives = missionnamespace getvariable [format ["MPSF_layer_%1_explosives",_layerName],[]];
			_layerParticles = missionnamespace getvariable [format ["MPSF_layer_%1_particles",_layerName],[]];
			_layerLights = missionnamespace getvariable [format ["MPSF_layer_%1_lights",_layerName],[]];
			_layerSounds = missionnamespace getvariable [format ["MPSF_layer_%1_sounds",_layerName],[]];
			_layerFunction = missionnamespace getvariable format ["MPSF_fnc_initLayer_%1",_layerName];
			{
				_x enableSimulationGlobal false;
				_x hideObjectGlobal true;
				_x allowdamage false;
			} foreach _layerObjects;

			//--- Disable particle and light effects
			{(_x select 0) setdropinterval 0;} foreach _layerParticles;
			{(_x select 0) setlightbrightness 0;} foreach _layerLights;
			{
				_x params ["_sound","_pos"];
				if (isnull _sound) then {_sound = (_pos nearobjects ["#dynamicsound",1]) param [0,objnull]; _x set [0,_sound];}; //--- Sound not serialized, find it again after load
				_sound setposatl (_pos vectoradd [0,0,-100]);
			} foreach _layerSounds;

			//--- Move explosives to the air to hide their icons
			{
				if ((getposatl _x select 2) < 1000) then {_x setposatl ((getposatl _x) vectoradd [0,0,10000]);};
			} foreach _layerExplosives;

			if !(isnil "_layerFunction") then { ["Hide",_layerObjects] call _layerFunction; };
		} foreach (_layers - _showLayers);

		{
			_layerName = _x;
			_layerObjects = missionnamespace getvariable [format ["MPSF_layer_%1",_layerName],[]];
			_layerExplosives = missionnamespace getvariable [format ["MPSF_layer_%1_explosives",_layerName],[]];
			_layerParticles = missionnamespace getvariable [format ["MPSF_layer_%1_particles",_layerName],[]];
			_layerLights = missionnamespace getvariable [format ["MPSF_layer_%1_lights",_layerName],[]];
			_layerSounds = missionnamespace getvariable [format ["MPSF_layer_%1_sounds",_layerName],[]];
			//_layerSoundObjects = [];
			_layerFunction = missionnamespace getvariable format ["MPSF_fnc_initLayer_%1",_layerName];
			{
				_x enableSimulationGlobal (_x getvariable ["BIS_defaultSimulation",true]);
				_x hideObjectGlobal false;
				_x allowdamage true;
				_x setvelocitymodelspace [0,0,0];
			} foreach _layerObjects;

			//--- Enable particle and light effects
			{(_x select 0) setdropinterval (_x select 1);} foreach _layerParticles;
			{(_x select 0) setlightbrightness (_x select 1);} foreach _layerLights;
			{
				_x params ["_sound","_pos"];
				if (isnull _sound) then {_sound = ((_pos vectoradd [0,0,-100]) nearobjects ["#dynamicsound",1]) param [0,objnull]; _x set [0,_sound];}; //--- Sound not serialized, find it again after load
				_sound setposatl _pos;
			} foreach _layerSounds;

			//--- Move explosives back to the ground
			{
				if ((getposatl _x select 2) > 1000) then {_x setposatl ((getposatl _x) vectoradd [0,0,-10000]);};
			} foreach _layerExplosives;

			if !(isnil "_layerFunction") then { ["Show",_layerObjects] call _layerFunction; };
		} foreach _showLayers;

	};
	//--- Initialize editor layers
	case "init" : {
		_params params [["_initLayers",[],[[]]]];

		missionNamespace setVariable ["MPSF_Mission_Layers",["CfgMission","Bases"] call BIS_fnc_getCfgSubClasses];

		private _compositions = ["CfgMission","Bases"] call BIS_fnc_getCfgSubClasses;
		{
			_layer = _x;
			_layerVar = format ["MPSF_layer_%1",_layer];
			_layerObjects = missionnamespace getvariable [_layerVar,[]];
			//_editorLayerEntities = getMissionLayerEntities _layer;
			_editorLayerObjects = (getMissionLayerEntities _layer) param [0,[]];
			_explosivesVar = format ["MPSF_layer_%1_explosives",_layer];
			_explosives = missionnamespace getvariable [_explosivesVar,[]];
			{
				_editorLayerObjects append ((getMissionLayerEntities format ["%1_%2",_x,_layer]) param [0,[]]);
			} foreach _compositions;
			if (count _editorLayerObjects > 0) then {
				{
					if (_x iskindof "Default") then {
						if (_x iskindof "UXO1_Ammo_Base_F") then {
							_xID = switch true do {
								case (_x iskindof "UXO4_Ammo_Base_F"): {4};
								case (_x iskindof "UXO3_Ammo_Base_F"): {3};
								case (_x iskindof "UXO2_Ammo_Base_F"): {2};
								default {1};
							};
							_xClass = format ["BombCluster_0%1_UXO%2_Ammo_F",BIS_UXOType,_xID];
							_xNew = createvehicle [_xClass,position _x,[],0,"can_collide"];
							_xNew setposatl getposatl _x;
							_xNew setvectordirandup [vectordir _x,vectorup _x];
							_editorLayerObjects set [_foreachindex,_xNew];
							_x setpos [10,10,10];
							deletevehicle _x;
							_x = _xNew;
						};
						_explosives pushbackunique _x;
					};
					if !(simulationenabled _x) then {_x setvariable ["BIS_defaultSimulation",false];};
					_x setvariable ["BIS_layer",tolower _layer];
					_x enableSimulationGlobal false;
					_x hideObjectGlobal true;

					//--- Disable inventory containers
					if (!(_x iskindof "AllVehicles") && {_x iskindof "WeaponHolder" || {_x canAdd "FirstAidKit"}}) then {_x setdamage 1;};
				} foreach _editorLayerObjects;
				_layerObjects append _editorLayerObjects;
			};
			missionnamespace setvariable [_layerVar,_layerObjects];
			missionnamespace setvariable [_explosivesVar,_explosives];

			_layerFnc = missionnamespace getvariable format ["MPSF_fnc_initLayer_%1",_layer];
			if !(isnil "_layerFnc") then {["Init",_layerObjects] call _layerFnc;};
		} foreach (missionNamespace getVariable ["MPSF_Mission_Layers",[]]);

		["showLayer",[(missionNamespace getVariable ["MPSF_Mission_Layers",[]]),_initLayers]] call MPSF_fnc_simulLayers;
	};
};