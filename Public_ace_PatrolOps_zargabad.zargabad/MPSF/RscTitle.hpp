#include "ui\rscTitleReturnPointDistance.hpp"

class RscTitleMPSFInjury {
	idd = 8600102;
	movingEnable = 0;
	duration = 1e+011;
	fadein = 0;
	fadeout = 0;
	name = "RscTitleMPSFInjury";
	onLoad = "['onLoadUI',_this] call MPSF_fnc_reviveMP;";
	onUnload = "['onUnloadUI',_this] call MPSF_fnc_reviveMP;";
	class controls {
		class RscHealthTextures: Rsc86ControlsGroupNoScrollbars {
			idc = 2000;
			x = "0 * (((safezoneW / safezoneH) min 1.2) / 40) + (safeZoneX)";
			y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "safezoneW + 0 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "safezoneH + 0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class controls {
				class Blood_1: Rsc86Picture {
					idc = 2001;
					text = "\A3\Ui_f\data\igui\rsctitles\HealthTextures\blood_lower_ca.paa";
					x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "safezoneW + 0 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "safezoneH + 0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class Blood_2: Blood_1 {
					idc = 2002;
					text = "\A3\Ui_f\data\igui\rsctitles\HealthTextures\blood_middle_ca.paa";
				};
				class Blood_3: Blood_1 {
					idc = 2003;
					text = "\A3\Ui_f\data\igui\rsctitles\HealthTextures\blood_upper_ca.paa";
				};
			};
		};
		class MainGroup: Rsc86ControlsGroupNoScrollbars {
			idc = 1000;
			x = "safeZoneX + 0 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "(safezoneH - safezoneH/4) - 5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "safezoneW + 0 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "(safezoneH/4) + 0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class controls {
				class ReviveProgress: Rsc86Progress {
					idc = 1003;
					x = "(safezoneW/2) - 15 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "8.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "30 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1.15 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					texture = "#(argb,8,8,3)color(1,1,1,1)";
					colorFrame[] = {0,0,0,0.2};
					colorBar[] = {0.2,0,0,1};
				};
				class SkipTitle: Rsc86StructuredText {
					idc = 1004;
					x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "8.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "safezoneW + 0 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1.15 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					size = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					sizeEx = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					text = "Hold Space to bleed out";
					colorBackground[] = {0,0,0,0};
					shadow = 0;
					class Attributes {
						font = "RobotoCondensed";
						color = "#ffffff";
						align = "center";
						shadow = 0;
						valign = "top";
					};
				};
				class Countdown: Rsc86StructuredText {
					idc = 1006;
					x = "(safezoneW/2) - 15 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "8.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "30 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1.15 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					size = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					sizeEx = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					text = "00:00:00.00";
					colorBackground[] = {0,0,0,0};
					shadow = 0;
					class Attributes {
						font = "RobotoCondensed";
						color = "#ffffff";
						align = "left";
						shadow = 0;
						valign = "center";
					};
				};
				class CallHelpTitle: Rsc86StructuredText {
					idc = 1008;
					x = "(safezoneW/2) - 15 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "9.95 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "30 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					size = "0.85 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					sizeEx = "0.85 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					text = "Press [H] to call for Help";
					colorBackground[] = {0,0,0,0};
					shadow = 0;
					class Attributes {
						font = "RobotoCondensed";
						color = "#ffffff";
						align = "left";
						shadow = 0;
						valign = "top";
					};
				};
			};
		};
	};
};