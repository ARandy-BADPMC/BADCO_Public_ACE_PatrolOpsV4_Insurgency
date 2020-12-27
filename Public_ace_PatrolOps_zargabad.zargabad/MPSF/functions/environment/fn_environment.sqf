/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_environment.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Changes Enviroment and Datetime
*/
#define	SHOWEFFECTS		(hasInterface && isnull curatorcamera)

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
// Time
	case "onChangeDateTime" : {
		_params params [["_dateTime",0,[0,[]]],["_instant",true,[false]]];
		if (true) then {
			["setDatetime",[_dateTime,_instant]] spawn MPSF_fnc_environment;
		};
	};
	case "setDatetime" : {
		_params params [["_dateTime",0,[0,[]]],["_instant",true,[false]]];

		private _dateArray = date;
		if (_dateTime isEqualType 0) then {
			_dateArray set [3,0 max _dateTime min 23];
		} else {
			_dateArray =+ _dateTime;
		};

		private _date = date;

		if (typeName _dateTime == typeName 0) then {
			_date set [3,(_date select 3) + floor _dateTime];
			_date set [4,(_date select 4) + (_dateTime % 1) * 60];
		} else {
			_date =+ _dateTime;
		};

		_date params [["_year",date select 0,[0]],["_month",date select 1,[0]],["_day",date select 2,[0]],["_hour",date select 3,[0]],["_minute",date select 4,[0]]];

		if (_instant) then {
			if (isserver) then {
				//["SetDate: %1",[_year,_month,_day,_hour,_minute]] call BIS_fnc_logFormat;
				setdate [_year,_month,_day,_hour,_minute];
			};
		} else {
			private _currentDate = date;

			if (SHOWEFFECTS) then {
				("MPSF_BLACKOUT_DATETIME" call BIS_fnc_rscLayer) cuttext ["","BLACK OUT"];
			};

			sleep 1;

			if (isserver) then {
				//["SetDate: %1",[_year,_month,_day,_hour,_minute]] call BIS_fnc_logFormat;
				setdate [_year,_month,_day,_hour,_minute];
			};

			sleep 1;

			if (SHOWEFFECTS) then {

				/*_diffDate = numbertodate [date select 0,datetonumber date - datetonumber _currentDate];
				_diffYear = (_diffDate select 0) - _yearOld;
				_diffMonth = (_diffDate select 1) - 1;
				_diffDay = (_diffDate select 2) - 1;
				_diffHour = (_diffDate select 3);
				_diffMinute = (_diffDate select 4);

				_value = 0;
				_text = "";
				if (_diffMinute > 0) then {
					_value = round _diffMinute;
					_text = if (_value > 1) then {localize "STR_A3_BIS_fnc_setDate_minuteP"} else {localize "STR_A3_BIS_fnc_setDate_minuteS"};
				};
				if (_diffHour > 0) then {
					_value = round (_diffHour + _diffMinute / 60);
					_text = if (_value > 1) then {localize "STR_A3_BIS_fnc_setDate_hourP"} else {localize "STR_A3_BIS_fnc_setDate_hourS"};
				};
				if (_diffDay > 0) then {
					_value = round (_diffDay + _diffHour / 24);
					_text = if (_value > 1) then {localize "STR_A3_BIS_fnc_setDate_dayP"} else {localize "STR_A3_BIS_fnc_setDate_dayS"};
				};
				if (_diffMonth > 0) then {
					_value = round _diffMonth;
					_text = if (_value > 1) then {localize "STR_A3_BIS_fnc_setDate_monthP"} else {localize "STR_A3_BIS_fnc_setDate_monthS"};
				};
				if (_diffYear > 0) then {
					_value = round_diffYear;
					_text = if (_value > 1) then {localize "STR_A3_BIS_fnc_setDate_yearP"} else {localize "STR_A3_BIS_fnc_setDate_yearS"};
				};

				_text = format [toupper _text,_value];
				_text = format ["<t size='2' font='PuristaSemiBold'>%1</t>",_text];
				[_text,-1,-1,4,0.5] call bis_fnc_dynamictext;
				sleep 0.1;
				//1 fadesound bis_fnc_setDate_soundvolume;
				*/

				("MPSF_BLACKOUT_DATETIME" call bis_fnc_rscLayer) cuttext ["","black in"];
			};
		};

		true;
	};
// Weather
	case "setFog" : {
		_params params [["_fogParams",fogParams,[[],0]],["_time",0,[0]]];
		if (isServer) then {
			if !(_fogParams isEqualType []) then { _fogParams = [0.45*_fogParams,0.08*_fogParams,25*_fogParams]; };
			private _offset = (1 - sunOrMoon) max 0.1;
			_fogParams set [0,(_fogParams select 0) * _offset];
			_fogParams set [2,(_fogParams select 2) * _offset];
			//["SetFog: %1",_fogParams] call BIS_fnc_logFormat;
			_time setfog _fogParams;
		};
		true;
	};
	case "setOvercast" : {
		_params params [["_overcastParams",overcast,[[],0]],["_time",0,[0]]];
		_time setOvercast _overcastParams;
		if (isServer) then {
			//["SetOvercast: %1",_overcastParams] call BIS_fnc_logFormat;
			if (_time == 0) then { forceWeatherChange; };
		};
		true;
	};
	case "setTimeMultiplier" : {
		_params params [["_multiplier",1,[0]]];
		if (isServer) then {
			//["SetTimeMultiplier: %1",_multiplier] call BIS_fnc_logFormat;
			setTimeMultiplier (0.1 max _multiplier min 120);
		};
		_multiplier;
	};
	case "setWind" : {
		_params params [["_windSpeed",0,[0]],["_windDir",0,[0]],["_time",0,[0]]];
		if (isServer) then {
			//["SetWind: %1",[_windSpeed,_windDir]] call BIS_fnc_logFormat;
			_time setWindStr _windSpeed;
			_time setWindDir _windDir;
			_time setWindForce 0.3;
		};
		true;
	};
// Configuration
	case "getCfgWeatherProfile" : {
		_params params [["_weatherID","",[""]]];

		private _weatherData = [];
		{
			_weatherData pushBack (["CfgMissionFramework","EnvironmentWeather",_weatherID,_x] call MPSF_fnc_getCfgData);
		} forEach [
			"Overcast","Fog","Wind","Lightning","ColorCorrections","FilmGrain","PPeffect"
		];

		//str [_weatherID,_weatherData] call BIS_fnc_logFormat;

		_weatherData params [["_overcast",0,[0,[]]],["_fog",0,[0,[]]],["_wind",0,[0,[]]],["_lightning",0,[0,[]]],["_colorCorrections",[],[[]]],["_filmGrain",[0,0,0,0,0],[[]]],["_PPeffect","",[""]]];

		private _overcast = switch (typeName _overcast) do {
			case (typeName 0) : { _overcast };
			case (typeName []) : { (_overcast select 0) + random ((_overcast select 1) - (_overcast select 0)); };
			default {0};
		};

		private _wind = switch (typeName _wind) do {
			case (typeName []) : { (_wind select 0) + random ((_wind select 1) - (_wind select 0)); };
			case (typeName 0) : { _wind };
			default {0};
		};

		[_overcast,_fog,_wind,_lightning,_colorCorrections,_filmGrain,_PPeffect];
	};
// Init
	case "postInit" : {
		["init"] spawn MPSF_fnc_civilianPopulation;
		if (isServer) then {
			["MPSF_Environment_onDatetimeChange_EH","onChangeDateTime",{
				["onChangeDateTime",_this] call MPSF_fnc_environment;
			}] call MPSF_fnc_addEventHandler;
		} else {
			// Weather Change Trigger
			["MPSF_Environment_onWeatherChange_EH","onWeatherChange",{
				//
			}] call MPSF_fnc_addEventHandler;

			// Date Time Change Trigger
			["MPSF_Environment_onDateTimeChange_EH","onDateTimeChange",{
				//
			}] call MPSF_fnc_addEventHandler;
		};
	};
	case "init" : {
		//
	};
};