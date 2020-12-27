class RscTitleMPSFReturnPointDistance {
	idd = 8600103;
	movingEnable = 0;
	duration = 1e+011;
	fadein = 0;
	fadeout = 0;
	onLoad = "['onLoadReturnPointUI',_this] call MPSF_fnc_taskmaster;";
	class controls {
		class MainGroup: Rsc86ControlsGroupNoScrollbars {
			idc = 1000;
			x = "0 * (((safezoneW / safezoneH) min 1.2) / 40) + (safeZoneX)";
			y = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "0 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneW)";
			h = "5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class controls {
				class TitleLine_Top: Rsc86StructuredText {
					idc = 1001;
					x = "(safezoneW/2) - 15 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "30 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.07 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {1,1,1,0.5};
					colorText[] = {0,0,0,0};
					text = "";
				};
				class SkipTitle: Rsc86StructuredText {
					idc = 1002;
					x = "(safezoneW/2) - 15 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "30 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1.15 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					size = "1.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					sizeEx = "1.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					text = "915m to nearest Return Point";
					colorBackground[] = {0,0,0,0};
					shadow = 0;
					class Attributes {
						font = "PuristaMedium";
						color = "#ffffff";
						align = "center";
						shadow = 0;
						valign = "top";
					};
				};
			};
		};
	};
};