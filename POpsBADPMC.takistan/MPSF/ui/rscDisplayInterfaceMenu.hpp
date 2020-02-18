class RscDisplayInterfaceMenu {
	idd = 860130;
	enableSimulation = 1;
	onLoad = "['onLoad',_this] call MPSF_fnc_interface;";
	class ControlsBackground {
		class InterfaceBackground: Rsc86StructuredText {
			idc = 1000;
			x = "0 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneXAbs)";
			y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "0 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneWAbs)";
			h = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneH)";
			colorBackground[] = {0,0,0,0.6};
		};
		class InterfaceBackgroundTitleLogo: Rsc86PictureKeepAspect {
			idc = 1001;
			x = "(safezoneW/2) - 15 * (((safezoneW / safezoneH) min 1.2) / 40) + (safeZoneX)";
			y = "(safezoneH/2) - 5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "30 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "MPSF\data\titles\patrolops_logo_b_co.paa";
		};
	};
	class Controls {
		class InterfaceMenu: Rsc86ControlsGroupNoScrollbars {
			idc = 2000;
			x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)";
			y = "23.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))";
			w = "safezoneW";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class controls {
				class InterfaceButton1: Rsc86ButtonMenu {
					idc = 2001;
					text = "Squad Manager";
					x = "0 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					tooltip = "Manage Squad and Groups";
				};
				class InterfaceButton2: Rsc86ButtonMenu {
					idc = 2002;
					text = "Mission View";
					x = "1 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					tooltip = "View current mission progress";
				};
				class InterfaceButton3: Rsc86ButtonMenu {
					idc = 2003;
					text = "Player View";
					x = "2 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					tooltip = "View Player Stats";
				};
				class InterfaceButton4: Rsc86ButtonMenu {
					idc = 2004;
					text = "Visual Settings";
					x = "3 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					tooltip = "Adjust Visual Settings";
				};
				class InterfaceButton5: Rsc86ButtonMenu {
					idc = 2005;
					text = "Close";
					x = "4 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					shortcuts[] = {"0x00050000 + 1"};
					tooltip = "Exit [Escape]";
				};
			};
		};
		class InterfaceVisualSettings: Rsc86ControlsGroupNoScrollbars {
			idc = 3000;
			x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)";
			y = "(safezoneH/2.6) + 0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY)";
			w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.3) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class controls {
				class VisualSettingsButton1: Rsc86ButtonMenu {
					idc = 3002;
					text = "Land";
					x = "0 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					tooltip = "Service & Update Vehicles Loadout";
				};
				class VisualSettingsButton2: Rsc86ButtonMenu {
					idc = 3003;
					text = "Helicopter";
					x = "1 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					tooltip = "Service & Update Vehicles Loadout";
				};
				class VisualSettingsButton3: Rsc86ButtonMenu {
					idc = 3004;
					text = "Plane";
					x = "2 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					tooltip = "Service & Update Vehicles Loadout";
				};
				class ViewDistanceText: Rsc86Text {
					idc = 3100;
					x = "0 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.08) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					text = "View Distance";
					colorBackground[] = {0,0,0,0.5};
				};
				class ViewDistanceSlider: Rsc86XSliderH {
					idc = 3101;
					x = "1 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.08)";
					y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.17) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class ViewDistanceEdit: Rsc86Edit {
					idc = 3102;
					x = "1 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.25)";
					y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.05) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					onKillFocus = "				comment 'DO NOT COPY THIS CODE TO YOUR ATTRIBUTE CONFIG UNLESS YOU ARE CHANGING SOMETHING IN THE CODE!';				_ctrlGroup = ctrlParentControlsGroup (_this select 0);				_value = sliderposition (_ctrlGroup controlsgroupctrl 100);				[_ctrlGroup,_value] call bis_fnc_3DENIntel;			";
				};
				class DrawDistanceText: Rsc86Text {
					idc = 3200;
					x = "0 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.08) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					text = "Draw Distance";
					colorBackground[] = {0,0,0,0.5};
				};
				class DrawDistanceSlider: Rsc86XSliderH {
					idc = 3201;
					x = "1 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.08)";
					y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.17) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class DrawDistanceEdit: Rsc86Edit {
					idc = 3202;
					x = "1 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.25)";
					y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.05) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					onKillFocus = "				comment 'DO NOT COPY THIS CODE TO YOUR ATTRIBUTE CONFIG UNLESS YOU ARE CHANGING SOMETHING IN THE CODE!';				_ctrlGroup = ctrlParentControlsGroup (_this select 0);				_value = sliderposition (_ctrlGroup controlsgroupctrl 100);				[_ctrlGroup,_value] call bis_fnc_3DENIntel;			";
				};
				class TerrainText: Rsc86Text {
					idc = 3300;
					x = "0 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					y = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.08) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					text = "Terrain";
					colorBackground[] = {0,0,0,0.5};
				};
				class TerrainListbox: Rsc86ListBox  {
					idc = 3301;
					x = "1 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.08)";
					y = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.22) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0,0,0,0.5};
				};
			};
		};
		class InterfaceMissionMenu: Rsc86ControlsGroupNoScrollbars {
			idc = 4000;
			x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)";
			y = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY)";
			w = "safezoneW";//"((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.3) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "safezoneH - 3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class controls {
				class MissionButton1: Rsc86ButtonMenu {
					idc = 4001;
					text = "Active Tasks";
					x = "0 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					tooltip = "Manage Squad and Groups";
				};
				class MissionButton2: Rsc86ButtonMenu {
					idc = 4002;
					text = "Mission Tasks";
					x = "1 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					tooltip = "View current mission progress";
				};
				class MissionCtrlList: Rsc86Tree {
					idc = 4003;
					x = "0 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.2) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "safezoneH - 4.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0,0,0,0.5};
				};
				class MissionStructuredText1: Rsc86StructuredText {
					idc = 4004;
					x = "2 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.3) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "safezoneH - 4.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
					colorBackground[] = {0,0,0,0.1};
				};
			};
		};
	};
};
