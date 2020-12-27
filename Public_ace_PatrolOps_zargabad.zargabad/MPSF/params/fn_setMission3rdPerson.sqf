/*
	Description:
	This function updates the misison parameter for restriction of 3rd Person
		- PARAM Only
*/
params [["_value",0,[0]]];

if !(hasInterface) exitWith {};

switch (_value) do {
	case 1 : { // Armour 3rd Person
		["MPSF_3rdPersonCheck_onEachFrame_EH","onEachFrame",{
			if (cameraView isEqualTo "EXTERNAL") then {
				if !(vehicle player isKindOf "Tank" && driver vehicle player isEqualTo player) then {
					vehicle player switchCamera "Internal";
				};
			};
		}] spawn { uisleep 0.1; _this call MPSF_fnc_addEventHandler; };
	};
	case 2 : { // Air 3rd Person
		["MPSF_3rdPersonCheck_onEachFrame_EH","onEachFrame",{
			if (cameraView isEqualTo "EXTERNAL") then {
				if !(vehicle player isKindOf "Air" && driver vehicle player isEqualTo player) then {
					vehicle player switchCamera "Internal";
				};
			};
		}] spawn { uisleep 0.1; _this call MPSF_fnc_addEventHandler; };
	};
	case 3 : { // Driver 3rd Person
		["MPSF_3rdPersonCheck_onEachFrame_EH","onEachFrame",{
			if (cameraView isEqualTo "EXTERNAL") then {
				if !(driver vehicle player isEqualTo player && !(vehicle player isKindOf "CaManBase")) then {
					vehicle player switchCamera "Internal";
				};
			};
		}] spawn { uisleep 0.1; _this call MPSF_fnc_addEventHandler; };
	};
	case 4 : { // No 3rd Person
		["MPSF_3rdPersonCheck_onEachFrame_EH","onEachFrame",{
			if (cameraView isEqualTo "EXTERNAL") then {
				vehicle player switchCamera "Internal";
			};
		}] spawn { uisleep 0.1; _this call MPSF_fnc_addEventHandler; };
	};
};

true;