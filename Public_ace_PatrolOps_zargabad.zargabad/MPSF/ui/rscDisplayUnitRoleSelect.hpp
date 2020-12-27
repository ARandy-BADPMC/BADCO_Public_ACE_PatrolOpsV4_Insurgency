class RscDisplayUnitRoleSelect {
	position[] = {
		"10 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)"
		,"0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)"
		,"20 * (((safezoneW / safezoneH) min 1.2) / 40)"
		,"22.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
	};
	class controls {
		class Title {
			type = "RscText";
			position[] = {
				"0 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
				,"20 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
			};
			colorBackground[] = {
				"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])"
				,"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])"
				,"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])"
				,"(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"
			};
			text = "Role Selection";
		};
		class MainBackground {
			type = "RscText";
			position[] = {
				"0 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
				,"20 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"20 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
			};
			colorBackground[] = {0,0,0,0.8};
		};
		class Column1: Rsc86Text {
			type = "RscText";
			position[] = {
				"0.5 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"1.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
				,"19 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"19 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
			};
			colorBackground[] = {1,1,1,0.2};
		};
		class Column2: Rsc86Text {
			type = "RscText";
			position[] = {
				"15.7 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"1.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
				,"0.95 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"19 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
			};
			colorBackground[] = {1,1,1,0.1};
		};
		class Column3: Rsc86Text {
			type = "RscText";
			position[] = {
				"17.6 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"1.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
				,"0.95 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"19 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
			};
			colorBackground[] = {1,1,1,0.1};
		};
		class ValueName: Rsc86ListNBox {
			columns[] = {0,0.7,0.9};
			type = "RscListNBox";
			position[] = {
				"0.5 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"1.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
				,"19 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"19 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
			};
			onLBSelChanged = "['onListRoleSelect',_this] call MPSF_fnc_virtualArmoury;";
			sizeEx = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class ButtonOK: Rsc86ButtonMenu {
			type = "RscButtonMenu";
			position[] = {
				"15 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"21.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
				,"5 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
			};
			text = "Request Role";
			onButtonClick = "['onButtonOkClick',['RscDisplayUnitRoleSelect']] call MPSF_fnc_virtualArmoury;";
		};
		class ButtonCancel: Rsc86ButtonMenu {
			type = "RscButtonMenu";
			position[] = {
				"9.9 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"21.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
				,"5 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
			};
			text = "$STR_DISP_CANCEL";
			onButtonClick = "['destroyControl',['RscDisplayUnitRoleSelect',ctrlparent (_this select 0)]] call MPSF_fnc_virtualArmoury;";
		};
	};
};