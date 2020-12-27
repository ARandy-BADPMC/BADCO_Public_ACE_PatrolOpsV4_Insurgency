class RscDisplayCameraIntro_1 {
	position[] = {
		"safeZoneXAbs"
		,"safeZoneY"
		,"safeZoneWAbs"
		,"safeZoneH"
	};
	class controls {
		class Title {
			type = "RscPictureKeepAspect";
			position[] = {
				"(safezoneW/2) - 10 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"(safeZoneH / 2) - 8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
				,"20 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"16 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
			};
			text = "mpsf\data\titles\patrolops_logo_co.paa";
		};
		class MainBackgroundTop {
			type = "RscText";
			position[] = {
				"0 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
				,"safeZoneWAbs"
				,"safeZoneH / 2"
			};
			colorBackground[] = {0,0,0,1};
		};
		class MainBackgroundBottom {
			type = "RscText";
			position[] = {
				"0 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"safeZoneH / 2"
				,"safeZoneWAbs"
				,"safeZoneH / 2"
			};
			colorBackground[] = {0,0,0,1};
		};
	};
};