class RscDisplayConversation {
	idd = -1;
	enableSimulation = 1;
	onLoad = "['onLoadUI',_this] call MPSF_fnc_conversation;";
	class ControlsBackground {};
	class Controls {
		class Response: Rsc86StructuredText {
			idc = 1000;
			x = "safezoneX + (0.5 * safezoneW - 8 * (((safezoneW / safezoneH) min 1.2) / 40))";
			y = "safezoneY + 0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "16 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "2.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "";
			sizeEx = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.5};
			class Attributes {
				font = "PuristaMedium";
				color = "#ffffff";
				align = "Left";
				shadow = 1;
			};
		};
		class ListSelect: Rsc86Listbox {
			idc = 1001;
			x = "safezoneX + safezoneW * 0.5 - 12 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + safezoneH * 0.6 + 0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "24 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "15 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.5};
			colorSelect[] = {0.8,0.8,0.8,0.5};
			colorSelect2[] = {0.8,0,0,0.8};
			colorSelectBackground[] = {0.1,0,0,1};
			colorSelectBackground2[] = {0.1,0.1,0.1,1};
		};
		class ListFrame: Rsc86Frame {
			idc = 1002;
			x = "safezoneX + safezoneW * 0.5 - 12 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + safezoneH * 0.6 + 0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "24 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "15 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {0,0,0,1};
		};
	};
};