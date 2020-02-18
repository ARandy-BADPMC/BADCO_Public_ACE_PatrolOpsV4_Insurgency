class ParamWeather {
	title = "Mission Weather";
	values[] = {0,1,2,3};
	default = 1;
	texts[]={"Clear","Cloudy","Rain","Thunderstorm"/*,"Cyclone","Snowing"*/};
	function = "MPSF_Param_fnc_setMissionWeather";
};

/*class ParamForecast {
	title = "Mission Weather Forecast";
	values[] = {0,1,2,3};
	default = 1;
	texts[]={"Clear","Cloudy","Rain","Thunderstorm"};
	function = "MPSF_Param_fnc_setMissionWeatherForecast";
};*/

class ParamTimeSpeed {
	title = "Mission Time Acceleration (Game : Reality)";
	values[] = {0,1,2,3,4,5,6,7};
	default = 2;
	texts[] = {"x0.1 (1:10Hrs)","0.5 (1:2Hrs)","x1 (1:1Hrs)","x2 (2:1Hrs)","x4 (4:1Hrs)","x6 (6:1Hrs)","x12 (12:1Hrs)","x24 (24:1Hrs)"};
//	function = "MPSF_Param_fnc_setMissionSpeed";
};