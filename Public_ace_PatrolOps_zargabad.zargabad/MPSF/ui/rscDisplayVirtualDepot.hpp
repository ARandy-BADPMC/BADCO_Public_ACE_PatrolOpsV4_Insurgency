class RscDisplayVirtualDepot {
	idd = -1;
	enableSimulation = 1;
	onLoad = "['onLoadDepotUI',_this] call MPSF_fnc_virtualDepot;";
	onUnload = "['onUnloadDepotUI',_this] call MPSF_fnc_virtualDepot;";
	class ControlsBackground {
		class RespawnCtrlTitleLogo: Rsc86PictureKeepAspect {
			idc = 895;
			x = "(safezoneW/2) - 7.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safeZoneX)";
			y = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "15 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "mpsf\data\titles\patrolops_banner_b_co.paa";
		};
		class BlackLeft: Rsc86Text {
			idc = 896;
			colorBackground[] = {0,0,0,0.8};
			x = "safezoneXAbs";
			y = "safezoneY";
			w = "safezoneXAbs - safezoneX";
			h = "safezoneH";
		};
		class BlackRight: BlackLeft {
			idc = 897;
			x = "safezoneX + safezoneW";
		};
		class MouseArea: Rsc86Text {
			idc = 899;
			style = 16;
			x = "safezoneX";
			y = "safezoneY";
			w = "safezoneW";
			h = "safezoneH";
		};
	};
	class Controls {
		class DepotMenu: Rsc86ControlsGroupNoScrollbars {
			idc = 3000;
			x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)";
			y = "23.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))";
			w = "safezoneW";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class controls {
				class DepotMenuTextLeft_1: Rsc86Text {
					idc = 3001;
					text = "";
					x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0,0,0,0.8};
				};
				class DepotMenuButtonVehicleSave: Rsc86ButtonMenu {
					idc = 3005;
					text = "Save Vehicle";
					x = "1 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					tooltip = "Service & Update Vehicles Loadout";
				};
				class DepotMenuButtonVehicleLoad: Rsc86ButtonMenu {
					idc = 3006;
					text = "Load Vehicle";
					x = "2 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					tooltip = "Service & Update Vehicles Loadout";
				};
				class DepotMenuButtonVehicleService: Rsc86ButtonMenu {
					idc = 3002;
					text = "Service Vehicle";
					x = "3 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.2) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					tooltip = "Service & Update Vehicles Loadout";
				};
				/*class DepotMenuButtonVehicleRefuel: RscButtonMenu {
					idc = 3003;
					//text = "Refuel Vehicle";
					x = "2 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					tooltip = "Service & Update Vehicles Loadout";
				};*/
				class DepotMenuButtonVehicleRearm: DepotMenuTextLeft_1 {
					idc = 3004;
					//text = "Rearm Vehicle";
					x = "5 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					tooltip = "Service & Update Vehicles Loadout";
				};
				class DepotMenuButtonVehicleDeploy: Rsc86ButtonMenu {
					idc = 3007;
					text = "Deploy Vehicle";
					x = "6 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.2) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					tooltip = "Deploy New Vehicle";
				};
				class DepotMenuButtonCloseUI: Rsc86ButtonMenu {
					idc = 3008;
					text = "Close";
					x = "8 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.2) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					shortcuts[] = {"0x00050000 + 1"};
					tooltip = "Exit the Depot [Escape]";
				};
			};
		};
		class VehicleInfo: Rsc86ControlsGroup {
			fade = 0;
			idc = 4000;
			x = "safezoneX + safezoneW - 20.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + safezoneH - 4.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "17.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class controls {
				class InfoBackground: Rsc86Text {
					idc = 4001;
					x = "2.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "15 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "2.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0,0,0,1};
				};
				class InfoName: Rsc86Text {
					idc = 4002;
					x = "2.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "15 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					sizeEx = "1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class InfoAuthor: Rsc86Text {
					idc = 4003;
					x = "2.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "15 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorText[] = {1,1,1,0.5};
					sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class DLCBackground: Rsc86Text {
					fade = 1;
					idc = 4004;
					x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "2.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "2.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0,0,0,0.5};
				};
				class DLCIcon: Rsc86ActivePicture {
					idc = 4005;
					enabled = 0;
					fade = 1;
					color[] = {1,1,1,1};
					colorActive[] = {1,1,1,1};
					text = "#(argb,8,8,3)color(1,1,1,1)";
					x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "2.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "2.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
			};
		};
		class Stats: Rsc86ControlsGroupNoScrollbars {
			idc = 5000;
			fade = 0;
			enable = 0;
			x = "safezoneX + safezoneW - 17.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + safezoneH - 10.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class controls {
				class StatsBackground: Rsc86Text {
					idc = 5001;
					x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "15 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0,0,0,0.5};
				};
				class Stat1: Rsc86Progress {
					idc = 5002;
					colorBar[] = {1,1,1,1.0};
					colorFrame[] = {0,0,0,0};
					x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "14 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class Stat2: Stat1 {
					idc = 5003;
					x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "14 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class Stat3: Stat1 {
					idc = 5004;
					x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "2.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "14 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class Stat4: Stat1 {
					idc = 5005;
					x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "3.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "14 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class Stat5: Stat1 {
					idc = 5006;
					x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "4.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "14 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class StatText1: Rsc86Text {
					idc = 5007;
					shadow = 0;
					colorShadow[] = {1,1,1,1.0};
					x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "14 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorText[] = {0,0,0,1};
					colorBackground[] = {1,1,1,0.1};
					sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class StatText2: StatText1 {
					idc = 5008;
					x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "14 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorText[] = {0,0,0,1};
					colorBackground[] = {1,1,1,0.1};
					sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class StatText3: StatText1 {
					idc = 5009;
					x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "2.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "14 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorText[] = {0,0,0,1};
					colorBackground[] = {1,1,1,0.1};
					sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class StatText4: StatText1 {
					idc = 5010;
					x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "3.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "14 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorText[] = {0,0,0,1};
					colorBackground[] = {1,1,1,0.1};
					sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class StatText5: StatText1 {
					idc = 5011;
					x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "4.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "14 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorText[] = {0,0,0,1};
					colorBackground[] = {1,1,1,0.1};
					sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
			};
		};
		class Message: Rsc86Text {
			fade = 1;
			idc = 1000;
			x = "safezoneX + (0.5 * safezoneW) - (0.5 * ((safezoneW - 36 * (((safezoneW / safezoneH) min 1.2) / 40)) max 0.4))";
			y = "21.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))";
			w = "((safezoneW - 36 * (((safezoneW / safezoneH) min 1.2) / 40)) max 0.4)";
			h = "1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.7};
			style = 2;
			shadow = 0;
			text = "";
			sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class leftBackground: Rsc86Text {
			idc = 6998;
			x = "0 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)";
			y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY)";
			w = "(1 + 1.5 * 2) * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.8};
		};
		class FrameLeft: Rsc86Frame {
			idc = 6999;
			x = "(1 + 1.5 * 2) * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)";
			y = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY)";
			w = "15 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "safezoneH - 3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {0,0,0,1};
		};
		class TabCar: Rsc86ButtonImg {
			idc = 6001;
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGarage\Car_ca.paa";
			x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)";
			y = "0.5 * 0.04 + 0 * 0.04 + (safezoneY)";
			w = "(1.4 * 2) * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "$STR_A3_RscDisplayGarage_tab_Car";
			colorBackground[] = {0,0,0,0.4};
		};
		class TextCar: Rsc86Text {
			idc = 6201;
			x = "(0.5 + 1.5 * 2) * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)";
			y = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY)";
			w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.4};
			SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			text = "$STR_A3_RscDisplayGarage_tab_Car";
		};
		class ListCar: Rsc86ListBox {
			idc = 6101;
			x = "(1 + 1.5 *	2) * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)";
			y = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY)";
			w = "15 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "safezoneH - 3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "1.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.8};
			colorSelectBackground[] = {1,1,1,0.5};
			colorSelectBackground2[] = {1,1,1,0.5};
			colorPictureSelected[] = {0.8,0.2,0.2,1};
			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorPictureRightSelected[] = {1,1,1,1};
		};
		class TabTank: TabCar {
			idc = 6002;
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGarage\Tank_ca.paa";
			y = "0.5 * 0.04 + 1.5 * 0.04 + (safezoneY)";
			tooltip = "$STR_A3_RscDisplayGarage_tab_Tank";
		};
		class TextTank: TextCar {
			idc = 6202;
			y = "0.5 * 0.04 + 1.5 * 0.04 + (safezoneY)";
			text = "$STR_A3_RscDisplayGarage_tab_Tank";
		};
		class ListTank: ListCar { idc = 6102; };
		class TabHelicopter: TabCar {
			idc = 6003;
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGarage\Helicopter_ca.paa";
			y = "0.5 * 0.04 + 3 * 0.04 + (safezoneY)";
			tooltip = "$STR_A3_RscDisplayGarage_tab_Helicopter";
		};
		class TextHelicopter: TextCar {
			idc = 6203;
			y = "0.5 * 0.04 + 3 * 0.04 + (safezoneY)";
			text = "$STR_A3_RscDisplayGarage_tab_Helicopter";
		};
		class ListHelicopter: ListCar { idc = 6103; };
		class TabPlane: TabCar {
			idc = 6004;
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGarage\Plane_ca.paa";
			y = "0.5 * 0.04 + 4.5 * 0.04 + (safezoneY)";
			tooltip = "$STR_A3_RscDisplayGarage_tab_Plane";
		};
		class TextPlane: TextCar {
			idc = 6204;
			y = "0.5 * 0.04 + 4.5 * 0.04 + (safezoneY)";
			text = "$STR_A3_RscDisplayGarage_tab_Plane";
		};
		class ListPlane: ListCar { idc = 6104; };
		class TabNaval: TabCar {
			idc = 6005;
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGarage\Naval_ca.paa";
			y = "0.5 * 0.04 + 6 * 0.04 + (safezoneY)";
			tooltip = "$STR_A3_RscDisplayGarage_tab_Naval";
		};
		class TextNaval: TextCar {
			idc = 6205;
			y = "0.5 * 0.04 + 6 * 0.04 + (safezoneY)";
			text = "$STR_A3_RscDisplayGarage_tab_Naval";
		};
		class ListNaval: ListCar { idc = 6105; };
		class TabCrew: Rsc86ButtonImg {
			idc = 6006;
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGarage\Crew_ca.paa";
			x = "safezoneW - 2 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)";
			y = "0.5 * 0.04 + 0 * 0.04 + (safezoneY)";
			w = "(1.4 * 1) * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "Loadout Configuration";
		};
		class ListCrew: ListCar {
			idc = 6106;
			x = "safezoneW - 17.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)";
			y = "1.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY)";
			w = "15 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "safezoneH - 7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "1.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class TogglePylonOwnerBtn: Rsc86ButtonMenu {
			idc = 6206;
			x = "safezoneW - 17.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)";
			y = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY)";
			w = "15 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "Toggle Pilot";
		};
		class TabAnimationSources: TabCrew {
			idc = 6007;
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGarage\AnimationSources_ca.paa";
			y = "0.5 * 0.04 + 1.5 * 0.04 + (safezoneY)";
			tooltip = "$STR_A3_RscDisplayGarage_tab_AnimationSources";
		};
		class ListAnimationSources: ListCrew {
			idc = 6107;
			y = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY)";
			h = "15 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class TabTextureSources: TabCrew {
			idc = 6008;
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGarage\TextureSources_ca.paa";
			y = "0.5 * 0.04 + 3 * 0.04 + (safezoneY)";
			tooltip = "$STR_A3_RscDisplayGarage_tab_TextureSources";
		};
		class ListTextureSources: ListCrew {
			idc = 6108;
			y = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY)";
			h = "15 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};

		class MouseBlock: Rsc86Text {
			idc = 898;
			style = 16;
			x = "safezoneX";
			y = "safezoneY";
			w = "safezoneW";
			h = "safezoneH";
		};

		class IconBackPylon0: Rsc86Picture {
			idc = 7000;
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
			x = -1;
			y = -1;
			w = "1.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {0,0,0,0.8};
		};
		class IconPylon0: Rsc86ButtonImg {
			idc = 7100;
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\PrimaryWeapon_ca.paa";
			x = -1;
			y = -1;
			w = "1.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {1,1,1,0};
		};
		class IconBackPylon1: IconBackPylon0 { idc = 7001; };
		class IconPylon1: IconPylon0 { idc = 7101; };
		class IconBackPylon2: IconBackPylon0 { idc = 7002; };
		class IconPylon2: IconPylon0 { idc = 7102; };
		class IconBackPylon3: IconBackPylon0 { idc = 7003; };
		class IconPylon3: IconPylon0 { idc = 7103; };
		class IconBackPylon4: IconBackPylon0 { idc = 7004; };
		class IconPylon4: IconPylon0 { idc = 7104; };
		class IconBackPylon5: IconBackPylon0 { idc = 7005; };
		class IconPylon5: IconPylon0 { idc = 7105; };
		class IconBackPylon6: IconBackPylon0 { idc = 7006; };
		class IconPylon6: IconPylon0 { idc = 7106; };
		class IconBackPylon7: IconBackPylon0 { idc = 7007; };
		class IconPylon7: IconPylon0 { idc = 7107; };
		class IconBackPylon8: IconBackPylon0 { idc = 7008; };
		class IconPylon8: IconPylon0 { idc = 7108; };
		class IconBackPylon9: IconBackPylon0 { idc = 7009; };
		class IconPylon9: IconPylon0 { idc = 7109; };
		class IconBackPylon10: IconBackPylon0 { idc = 7010; };
		class IconPylon10: IconPylon0 { idc = 7110; };
		class IconBackPylon11: IconBackPylon0 { idc = 7011; };
		class IconPylon11: IconPylon0 { idc = 7111; };
		class IconBackPylon12: IconBackPylon0 { idc = 7012; };
		class IconPylon12: IconPylon0 { idc = 7112; };
		class IconBackPylon13: IconBackPylon0 { idc = 7013; };
		class IconPylon13: IconPylon0 { idc = 7113; };
		class IconBackPylon14: IconBackPylon0 { idc = 7014; };
		class IconPylon14: IconPylon0 { idc = 7114; };
		class IconBackPylon15: IconBackPylon0 { idc = 7015; };
		class IconPylon15: IconPylon0 { idc = 7115; };
		class IconBackPylon16: IconBackPylon0 { idc = 7016; };
		class IconPylon16: IconPylon0 { idc = 7116; };
		class IconBackPylon17: IconBackPylon0 { idc = 7017; };
		class IconPylon17: IconPylon0 { idc = 7117; };
		class IconBackPylon18: IconBackPylon0 { idc = 7018; };
		class IconPylon18: IconPylon0 { idc = 7118; };
		class IconBackPylon19: IconBackPylon0 { idc = 7019; };
		class IconPylon19: IconPylon0 { idc = 7119; };
	};
};

class RscDisplayVirtualDepotAirLoadout {
	idd = 860136;
	enableSimulation = 1;
	onLoad = "['onLoadPylonUI',_this] call MPSF_fnc_virtualDepot;";
	class ControlsBackground {};
	class Controls {
		class LineIcon: Rsc86Frame {
			fade = 1;
			idc = 2001;
			x = -1;
			y = -1;
			w = 0;
			h = 0;
			colorText[] = {0,0,0,1};
		};
		class ToggleOwnerBtn: Rsc86ButtonMenu {
			idc = 2010;
			x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "Toggle Pilot";
		};
		class ListBox1: Rsc86ListBox {
			idc = 2011;
			x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class IconBackground: Rsc86Picture {
			idc = 2021;
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
			x = -1;
			y = -1;
			w = "1.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {0,0,0,0.8};
		};
		class IconImage: Rsc86ButtonImg {
			idc = 2022;
			text = "\a3\ui_f\data\IGUI\Cfg\Actions\loadVehicle_ca.paa";
			x = -1;
			y = -1;
			w = "1.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {1,1,1,0};
		};
		class IconText: Rsc86Text {
			idc = 2023;
			text = "Confirm";
			x = -1;
			y = -1;
			w = "4.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {1,1,1,0.8};
			colorBackground[] = {0,0,0,0.8};
		};
	};
};