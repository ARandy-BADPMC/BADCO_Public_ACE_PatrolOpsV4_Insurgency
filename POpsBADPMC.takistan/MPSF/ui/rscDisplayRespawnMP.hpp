class RscDisplayRespawn {
	idd = 860138;
	enableSimulation = 1;
	onLoad = "['onLoadUI',_this] spawn MPSF_fnc_respawnMP;";
	class ControlsBackground {
		class RespawnCtrlMap: Rsc86StrategicMap {
			idc = 1002;
			x = "0 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)";
			y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "0 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneW)";
			h = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneH)";
		};
		class RespawnCtrlBackground: Rsc86StructuredText {
			idc = 1001;
			x = "0 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneXAbs)";
			y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "0 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneWAbs)";
			h = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneH)";
			colorBackground[] = {0,0,0,0.4};
		};
		class RespawnCtrlTitleLogo: Rsc86PictureKeepAspect {
			idc = 1003;
			x = "(safezoneW/2) - 10 * (((safezoneW / safezoneH) min 1.2) / 40) + (safeZoneX)";
			y = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "20 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "mpsf\data\titles\patrolops_banner_b_co.paa";
		};
	};
	class Controls {
		class RespawnCtrlMenu: Rsc86ControlsGroupNoScrollbars {
			idc = 2000;
			x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)";
			y = "23.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))";
			w = "safezoneW";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class controls {
				class RespawnCtrlButton1: Rsc86ButtonMenu {
					idc = 2001;
					text = "Spectator";
					x = "2 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					//tooltip = "Manage Squad and Groups";
				};
				class RespawnCtrlButton2: Rsc86ButtonMenu {
					idc = 2002;
					text = "Loadout";
					x = "3 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					//tooltip = "Manage Squad and Groups";
				};
				class RespawnCtrlButton3: Rsc86ButtonMenu {
					idc = 2003;
					text = "Deploy to Position";
					x = "4 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.2) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					//tooltip = "View Player Stats";
				};
				class RespawnCtrlButton5: Rsc86ButtonMenu {
					idc = 2005;
					text = "Close";
					x = "6 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.2) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					shortcuts[] = {"0x00050000 + 1"};
					tooltip = "Exit [Escape]";
				};
			};
		};

		class RespawnCtrlSlider: Rsc86XSliderH {
			idc = 4001;
			x = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.3) + (safezoneX)";
			y = "22.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))";
			w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.4) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class RespawnCtrlSliderText1: Rsc86StructuredText {
			idc = 4002;
			text = "<t size='0.8' shadow='0'>Distance</t><br/><t size='1.7' shadow='0'>128m</t>"; //--- ToDo: Localize;
			x = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.3) + (safezoneX)";
			y = "19.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))";
			w = "5 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "2.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0};
		};
		class RespawnCtrlSliderText2: Rsc86StructuredText {
			idc = 4003;
			text = "<t size='0.8' shadow='0'>Altitude</t><br/><t size='1.7' shadow='0'>10.8km</t>"; //--- ToDo: Localize;
			x = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.36) + (safezoneX)";
			y = "19.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))";
			w = "8 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "2.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0};
		};
	};
};