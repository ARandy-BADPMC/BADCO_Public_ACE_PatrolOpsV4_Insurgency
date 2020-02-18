class RscDisplayMissionUI {
	idd = 860142;
	enableSimulation = 1;
	onLoad = "['onLoad',_this] call PO4_fnc_operations;";
	class ControlsBackground {
		class MissionCtrlMap: Rsc86StrategicMap {
			idc = 1002;
			x = "0 * (((safeZoneW / safeZoneH) min 1.2) / 40) + (safeZoneX)";
			y = "0 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "0 * (((safeZoneW / safeZoneH) min 1.2) / 40) + (safeZoneW)";
			h = "0 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) + (safeZoneH)";
		};
		class MissionCtrlBackground: Rsc86StructuredText {
			idc = 1001;
			x = "0 * (((safeZoneW / safeZoneH) min 1.2) / 40) + (safeZoneXAbs)";
			y = "0 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "0 * (((safeZoneW / safeZoneH) min 1.2) / 40) + (safeZoneWAbs)";
			h = "0 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) + (safeZoneH)";
			colorBackground[] = {0,0,0,1};
		};
		class RespawnCtrlTitleLogo: Rsc86PictureKeepAspect {
			idc = 1003;
			x = "(safeZoneW/2) - 10 * (((safeZoneW / safeZoneH) min 1.2) / 40) + (safeZoneX)";
			y = "0.5 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "20 * (((safeZoneW / safeZoneH) min 1.2) / 40)";
			h = "10 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			text = "mpsf\data\titles\patrolops_banner_b_co.paa";
		};
	};
	class Controls {
		class MissionTextTR1: Rsc86StructuredText {
			idc = 1901;
			x = "0.5 * (((safeZoneW / safeZoneH) min 1.2) / 40) + (safeZoneX)";
			y = "0.5 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "10 * (((safeZoneW / safeZoneH) min 1.2) / 40)";
			h = "0.7 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			size = "0.7 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.7 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.8};
			text = "//SECURE.NATO.AI/MALDEN/OPS/NQ-TADASD-20170608.HDFS";
			class Attributes {
				font = "EtelkaMonospacePro";
			};
		};
		class MissionTextTR2: Rsc86StructuredText {
			idc = 1902;
			x = "0.5 * (((safeZoneW / safeZoneH) min 1.2) / 40) + (safeZoneX)";
			y = "1.3 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "10 * (((safeZoneW / safeZoneH) min 1.2) / 40)";
			h = "0.7 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.8};
			size = "0.7 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.7 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			text = "REGION:MALDEN/STATUS:<t color='#FF2222'>RED</t>";
			class Attributes {
				font = "EtelkaMonospacePro";
			};
		};
		class MissionTextTR3: Rsc86StructuredText {
			idc = 1903;
			x = "0.5 * (((safeZoneW / safeZoneH) min 1.2) / 40) + (safeZoneX)";
			y = "2.1 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "10 * (((safeZoneW / safeZoneH) min 1.2) / 40)";
			h = "0.7 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.8};
			size = "0.7 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.7 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			text = "INTEL:<t color='#FF2222'>RED</t>";
			class Attributes {
				font = "EtelkaMonospacePro";
			};
		};
		class MissionTextTR4: Rsc86StructuredText {
			idc = 1904;
			x = "0 * (((safeZoneW / safeZoneH) min 1.2) / 40) + (safeZoneX) + (safeZoneW/2 - 10 * (((safeZoneW / safeZoneH) min 1.2) / 40))";
			y = "2.1 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) + (safeZoneY) + (safeZoneH/2 - 2 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25))";
			w = "20 * (((safeZoneW / safeZoneH) min 1.2) / 40)";
			h = "2 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.8};
			size = "1.5 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "1.5 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			text = "No Intel Collected";
			class Attributes {
				font = "EtelkaMonospacePro";
				align = "center";
			};
		};
		class MissionCtrlMenu: Rsc86ControlsGroupNoScrollbars {
			idc = 2000;
			x = "0.5 * (((safeZoneW / safeZoneH) min 1.2) / 40) + (safeZoneX)";
			y = "23.5 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) + (safeZoneY + safeZoneH - (((safeZoneW / safeZoneH) min 1.2) / 1.2))";
			w = "safeZoneW";
			h = "1 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			class controls {
				class MissionCtrlMenuButton1: Rsc86ButtonMenu {
					idc = 2001;
					text = "Intel";
					x = "3 * ((safeZoneW - 1 * (((safeZoneW / safeZoneH) min 1.2) / 40)) * 0.1)";
					y = "0 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
					w = "((safeZoneW - 1 * (((safeZoneW / safeZoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safeZoneW / safeZoneH) min 1.2) / 40)";
					h = "1 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
				};
				class MissionCtrlMenuButton2: Rsc86ButtonMenu {
					idc = 2002;
					text = "Unlock Operation";
					x = "4 * ((safeZoneW - 1 * (((safeZoneW / safeZoneH) min 1.2) / 40)) * 0.1)";
					y = "0 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
					w = "((safeZoneW - 1 * (((safeZoneW / safeZoneH) min 1.2) / 40)) * 0.2) - 0.1 * (((safeZoneW / safeZoneH) min 1.2) / 40)";
					h = "1 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
				};
				class MissionCtrlMenuButton3: Rsc86ButtonMenu {
					idc = 2003;
					text = "Close";
					x = "6 * ((safeZoneW - 1 * (((safeZoneW / safeZoneH) min 1.2) / 40)) * 0.1)";
					y = "0 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
					w = "((safeZoneW - 1 * (((safeZoneW / safeZoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safeZoneW / safeZoneH) min 1.2) / 40)";
					h = "1 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
					shortcuts[] = {"0x00050000 + 1"};
					tooltip = "Exit [Escape]";
				};
			};
		};
		class MissionCtrlInfo: Rsc86ControlsGroup {
			idc = 3000;
			x = "5.5 * (((safeZoneW / safeZoneH) min 1.2) / 40) + (safeZoneX)";
			y = "5.5 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "10 * (((safeZoneW / safeZoneH) min 1.2) / 40)";
			h = "11.1 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			class controls {
				class MissionCtrlInfoTitle: Rsc86StructuredText {
					idc = 3001;
					text = "";
					x = "0 * ((safeZoneW - 1 * (((safeZoneW / safeZoneH) min 1.2) / 40)) * 0.1)";
					y = "0 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
					w = "10 * (((safeZoneW / safeZoneH) min 1.2) / 40)";
					h = "1 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0,0,0,0.8};
				};
				class MissionCtrlInfoBrief: Rsc86StructuredText {
					idc = 3002;
					text = "";
					x = "0 * ((safeZoneW - 1 * (((safeZoneW / safeZoneH) min 1.2) / 40)) * 0.1)";
					y = "1.1 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
					w = "10 * (((safeZoneW / safeZoneH) min 1.2) / 40)";
					h = "10 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0,0,0,0.8};
					size = "0.7 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
					sizeEx = "0.7 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
				};
			};
		};
	};
};