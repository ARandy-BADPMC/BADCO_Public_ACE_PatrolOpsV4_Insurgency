class Rsc86ScrollBar {
	color[] = {1,1,1,0.6};
	colorActive[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.3};
	thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	shadow = 0;
	scrollSpeed = 0.06;
	width = 0;
	height = 0;
	autoScrollEnabled = 0;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
};

class Rsc86ControlsGroup {
	type = 15;
	idc = -1;
	x = 0;
	y = 0;
	w = 1;
	h = 1;
	shadow = 0;
	style = 16;
	class VScrollbar: Rsc86ScrollBar
	{
		width = 0.021;
		autoScrollEnabled = 1;
	};
	class HScrollbar: Rsc86ScrollBar
	{
		height = 0.028;
	};
	class Controls{};
};

class Rsc86ControlsGroupNoScrollbars: Rsc86ControlsGroup {
	class VScrollbar: VScrollbar {
		width = 0;
	};
	class HScrollbar: HScrollbar {
		height = 0;
	};
};

class Rsc86ControlsGroupNoHScrollbars: Rsc86ControlsGroup {
	class HScrollbar: HScrollbar {
		height = 0;
	};
};

class Rsc86ControlsGroupNoVScrollbars: Rsc86ControlsGroup {
	class VScrollbar: VScrollbar {
		width = 0;
	};
};

class Rsc86Tree {
	access = 0;
	type = 12;
	default = 0;
	blinkingPeriod = 0;
	colorArrow[] = {0,0,0,0};
	colorMarked[] = {1,0.5,0,0.5};
	colorMarkedSelected[] = {1,0.5,0,1};
	colorMarkedText[] = {1,1,1,1};
	tooltip = "";
	tooltipColorShade[] = {0,0,0,1};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	shadow = 1;
	multiselectEnabled = 1;
	maxHistoryDelay = 1;
	style = 0;
	font = "RobotoCondensed";
	sizeEx = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	expandedTexture = "A3\ui_f\data\gui\rsccommon\RscTree\expandedTexture_ca.paa";
	hiddenTexture = "A3\ui_f\data\gui\rsccommon\RscTree\hiddenTexture_ca.paa";
	x = 0;
	y = 0;
	w = 0.1;
	h = 0.2;
	rowHeight = 0.0439091;
	colorText[] = {1,1,1,1};
	colorSearch[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
	colorSelect[] = {1,1,1,0.7};
	colorSelectText[] = {0,0,0,1};
	colorBackground[] = {0,0,0,0};
	colorSelectBackground[] = {0,0,0,0.5};
	colorBorder[] = {0,0,0,0};
	colorDisabled[] = {1,1,1,0.25};
	colorLines[] = {0,0,0,0};
	borderSize = 0;
	expandOnDoubleclick = 1;
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {0,0,0,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightSelected[] = {0,0,0,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
	class ScrollBar: Rsc86ScrollBar{};
};

class Rsc86Text {
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 0;
	shadow = 1;
	type = 0;
	text = "";
	colorShadow[] = {0,0,0,0.5};
	font = "PuristaMedium";
	SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0};
	linespacing = 1;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};

class Rsc86Line: Rsc86Text {
	idc = -1;
	style = 176;
	x = 0.17;
	y = 0.48;
	w = 0.66;
	h = 0;
	text = "";
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
};

class Rsc86Title: Rsc86Text {
	style = 0;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	colorText[] = {0.95,0.95,0.95,1};
};

class Rsc86LoadingText: Rsc86Text {
	style = 2;
	x = 0.29412;
	y = 0.666672;
	w = 0.411768;
	h = 0.039216;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	colorText[] = {1,1,1,1.0};
};

class Rsc86StructuredText : Rsc86Text {
	type = 13;
	text = "";
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	colorText[] = {1,1,1,1};
	shadow = 1;
	x = 0;
	y = 0;
	h = 0.035;
	w = 0.1;
	class Attributes {
		font = "PuristaMedium";
		color = "#ffffff";
		align = "left";
		valign = "middle";
		shadowColor = "#000000";
		shadow = 0;
	};
};

class Rsc86Picture {
	type = 0;
	style = "0x30";
	shadow = 0;
	font = "PuristaMedium";
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	x = 0;
	y = 0;
	w = 0.2;
	h = 0.15;
	text = "";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};

class Rsc86PictureKeepAspect: Rsc86Picture {
	style = "0x30 + 0x800";
};

class Rsc86ActiveText: Rsc86Text {
	idc = -1;
	type = 0;
	x = 0;
	y = 0;
	h = 0.035;
	w = 0.035;
	font = "PuristaMedium";
	shadow = 2;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	color[] = {0,0,0,1};
	colorText[] = {0,0,0,1};
	colorActive[] = {0.3,0.4,0,1};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};

class Rsc86ActivePicture: Rsc86ActiveText {
	style = 48;
	color[] = {1,1,1,0.5};
	colorActive[] = {1,1,1,1};
};

class Rsc86ActivePictureKeepAspect: Rsc86ActivePicture {
	style = "0x30 + 0x800";
};

class Rsc86Button {
	style = 2;
	type = 1;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	shadow = 2;
	font = "PuristaMedium";
	SizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground[] = {0,0,0,0.5};
	colorBackgroundActive[] = {0,0,0,1};
	colorBackgroundDisabled[] = {0,0,0,0.5};
	colorFocused[] = {0,0,0,1};
	colorShadow[] = {0,0,0,0};
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0;
	offsetPressedY = 0;
	colorBorder[] = {0,0,0,1};
	borderSize = 0.0;
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
};

class Rsc86ButtonImg: Rsc86Button {
	style = 48;
	colorBackground[] = {0,0,0,0.8};
	colorDisabled[] = {1,1,1,1};
	text = "";
};

class Rsc86ButtonTextOnly: Rsc86Button {
	SizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	font = "PuristaLight";
	colorBackground[] = {1,1,1,0};
	colorBackgroundActive[] = {1,1,1,0};
	colorBackgroundDisabled[] = {1,1,1,0};
	colorFocused[] = {1,1,1,0};
	colorShadow[] = {1,1,1,0};
	borderSize = 0.0;
	text = "";
};

class Rsc86ShortcutButton {
	idc = -1;
	style = 0;
	default = 0;
	shadow = 1;
	w = 0.183825;
	h = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 20)";
	color[] = {1,1,1,1.0};
	colorFocused[] = {1,1,1,1.0};
	color2[] = {0.95,0.95,0.95,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1};
	colorBackgroundFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1};
	colorBackground2[] = {1,1,1,1};
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";
	periodFocus = 1.2;
	periodOver = 0.8;
	class HitZone
	{
		left = 0.0;
		top = 0.0;
		right = 0.0;
		bottom = 0.0;
	};
	class ShortcutPos
	{
		left = 0;
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		w = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		h = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class TextPos
	{
		left = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0.0;
	};
	period = 0.4;
	font = "PuristaMedium";
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	text = "";
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
	action = "";
	class Attributes
	{
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
	class AttributesImage
	{
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
	};
};

class Rsc86ShortcutButtonMain: Rsc86ShortcutButton {
	idc = -1;
	style = 0;
	default = 0;
	w = 0.3137255;
	h = 0.1045752;
	color[] = {1,1,1,1.0};
	colorDisabled[] = {1,1,1,0.25};
	class HitZone
	{
		left = 0.0;
		top = 0.0;
		right = 0.0;
		bottom = 0.0;
	};
	class ShortcutPos
	{
		left = 0.0145;
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)) / 2";
		w = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2) * (3/4)";
		h = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
	};
	class TextPos
	{
		left = "(((safezoneW / safezoneH) min 1.2) / 32) * 1.5";
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20)*2 - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)) / 2";
		right = 0.005;
		bottom = 0.0;
	};
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\disabled_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\down_ca.paa";
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\normal_ca.paa";
	period = 0.5;
	font = "PuristaMedium";
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
	text = "";
	action = "";
	class Attributes
	{
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	class AttributesImage
	{
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "false";
	};
};

class Rsc86ButtonMenu: Rsc86ShortcutButton {
	idc = -1;
	type = 16;
	style = "0x02 + 0xC0";
	default = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureOver = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
	colorBackground[] = {0,0,0,0.8};
	colorBackgroundFocused[] = {1,1,1,1};
	colorBackground2[] = {0.75,0.75,0.75,1};
	color[] = {1,1,1,1};
	colorFocused[] = {0,0,0,1};
	color2[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	period = 1.2;
	periodFocus = 1.2;
	periodOver = 1.2;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	class TextPos
	{
		left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0.0;
	};
	class Attributes
	{
		font = "PuristaLight";
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	class ShortcutPos
	{
		left = "(6.25 * (((safezoneW / safezoneH) min 1.2) / 40)) - 0.0225 - 0.005";
		top = 0.005;
		w = 0.0225;
		h = 0.03;
	};
	soundEnter[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEnter",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundPush",0.09,1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundClick",0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEscape",0.09,1};
};

class Rsc86IGUIShortcutButton: Rsc86ShortcutButton {
	w = 0.183825;
	h = "0.0522876 * 	0.7";
	style = 2;
	class HitZone
	{
		left = 0.002;
		top = "0.003 * 	0.7";
		right = 0.002;
		bottom = "0.016 * 	0.7";
	};
	class ShortcutPos
	{
		left = -0.006;
		top = "-0.007 * 	0.7";
		w = 0;
		h = "0.0522876 * 	0.7";
	};
	class TextPos
	{
		left = 0.0;
		top = "0.000 * 	0.7";
		right = 0.0;
		bottom = "0.016 * 	0.7";
	};
	class Attributes
	{
		font = "RobotoCondensed";
		color = "#E5E5E5";
		align = "center";
		shadow = "true";
	};
};
class Rsc86GearShortcutButton: Rsc86ShortcutButton {
	w = 0.0392157;
	h = 0.0522876;
	style = 2;
	color[] = {1,1,1,1};
	color2[] = {1,1,1,0.85};
	colorBackground[] = {1,1,1,1};
	colorbackground2[] = {1,1,1,0.85};
	colorDisabled[] = {1,1,1,0.4};
	class HitZone
	{
		left = 0.0;
		top = 0.0;
		right = 0.0;
		bottom = 0.0;
	};
	class ShortcutPos
	{
		left = -0.006;
		top = -0.007;
		w = 0.0392157;
		h = 0.0522876;
	};
	class TextPos
	{
		left = 0.003;
		top = 0.001;
		right = 0.0;
		bottom = 0.0;
	};
	sizeEx = 0.1;
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscGearShortcutButton\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscGearShortcutButton\disabled_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscGearShortcutButton\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscGearShortcutButton\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscGearShortcutButton\down_ca.paa";
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscGearShortcutButton\normal_ca.paa";
	class Attributes
	{
		font = "RobotoCondensed";
		color = "#E5E5E5";
		align = "center";
		shadow = "false";
	};
};

class Rsc86ButtonMenuOK: Rsc86ButtonMenu {
	idc = 1;
	shortcuts[] = {"0x00050000 + 0",28,57,156};
	default = 1;
	text = "$STR_DISP_OK";
	soundPush[] = {"\A3\ui_f\data\sound\RscButtonMenuOK\soundPush",0.09,1};
};

class Rsc86ButtonMenuCancel: Rsc86ButtonMenu {
	idc = 2;
	shortcuts[] = {"0x00050000 + 1"};
	text = "$STR_DISP_CANCEL";
};

class Rsc86ButtonMenuImage: Rsc86ButtonMenu {
	idc = -1;
	animTextureNormal = "#(argb,8,8,3)color(1,1,1,0.8)";
	animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1.0)";
	animTextureOver = "#(argb,8,8,3)color(1,1,1,1.0)";
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1.0)";
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,1.0)";
	animTextureDefault = "#(argb,8,8,3)color(1,1,1,0.8)";
	color[] = {1,1,1,1};
	color2[] = {1,0,0,1};
	colorFocused[] = {1,0,0,1};
	colorDisabled[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
	colorBackground2[] = {0,0,0,1};
	colorBackgroundFocused[] = {0,0,0,1};
	shadow = 0;
	style = 2;
	class ShortcutPos {
		left = 0;
		top = 0;
		w = 0;
		h = 0;
	};
	class TextPos {
		left = 0;
		top = 0;
		right = 0;
		bottom = 0;
	};
};

class Rsc86CheckBox {
	idc = -1;
	type = 77;
	style = 0;
	checked = 0;
	x = "0.375 * safezoneW + safezoneX";
	y = "0.36 * safezoneH + safezoneY";
	w = "0.025 * safezoneW";
	h = "0.04 * safezoneH";
	color[] = {1,1,1,0.7};
	colorFocused[] = {1,1,1,1};
	colorHover[] = {1,1,1,1};
	colorPressed[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.2};
	colorBackground[] = {0,0,0,0};
	colorBackgroundFocused[] = {0,0,0,0};
	colorBackgroundHover[] = {0,0,0,0};
	colorBackgroundPressed[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};
	textureChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureFocusedChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureFocusedUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureHoverChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureHoverUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	texturePressedChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	texturePressedUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureDisabledChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureDisabledUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	soundEnter[] = {"",0.1,1};
	soundPush[] = {"",0.1,1};
	soundClick[] = {"",0.1,1};
	soundEscape[] = {"",0.1,1};
};

class Rsc86TextCheckBox {
	idc = -1;
	type = 7;
	style = 0;
	x = "0.375 * safezoneW + safezoneX";
	y = "0.36 * safezoneH + safezoneY";
	w = "0.025 * safezoneW";
	h = "0.04 * safezoneH";
	colorText[] = {1,0,0,1};
	color[] = {0,0,0,0};
	colorBackground[] = {0,0,1,1};
	colorTextSelect[] = {0,0.8,0,1};
	colorSelectedBg[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1};
	colorSelect[] = {0,0,0,1};
	colorTextDisable[] = {0.4,0.4,0.4,1};
	colorDisable[] = {0.4,0.4,0.4,1};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	font = "PuristaMedium";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	rows = 1;
	columns = 1;
	strings[] = {"UNCHECKED"};
	checked_strings[] = {"CHECKED"};
};

class Rsc86Progress {
	type = 8;
	style = 0;
	x = 0.344;
	y = 0.619;
	w = 0.3137255;
	h = 0.0261438;
	shadow = 2;
	texture = "#(argb,8,8,3)color(1,1,1,1)";
	colorFrame[] = {0,0,0,0.8};
	colorBar[] = {1,0,0,1};
};

//https://community.bistudio.com/wiki/DialogControls-ListBoxes
class Rsc86ListBox {
	access = 0;
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	autoScrollSpeed = -1;
	type = 5;
	style = 16;
	sizeEx = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	font = "PuristaLight";
	shadow = 0;
	colorShadow[] = {0,0,0,0.5};
	color[] = {0.95,0.95,0.95,1};
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	colorScrollbar[] = {0,0,0,0};
	colorSelect[] = {0,0,0,1};
	colorSelect2[] = {0,0,0,1};
	colorBackground[] = {0,0,0,0.8};
	colorSelectBackground[] = {1,1,1,0.8};
	colorSelectBackground2[] = {1,1,1,0.8};
	period = 1.2;
	rowHeight = 0;
	itemSpacing = 0;
	maxHistoryDelay = 1.0;
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {0.7,0,0,1};
	colorPictureDisabled[] = {1,1,1,1};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1};
	class ListScrollBar: Rsc86ScrollBar {
		color[] = {1,1,1,1};
		autoScrollEnabled = 1;
	};
};

class Rsc86ListBoxKeys: Rsc86ListBox {
	collisionColor[] = {1,0,0,1};
	disabledKeyColor[] = {0.4,0.4,0.4,1};
};

class Rsc86ListNBox : Rsc86ListBox {
	type = 102;
	style = 16;
	shadow = 0;
	drawSideArrows = 1;
	period = 1.2;
	idcLeft = 0;
	idcRight = 0;
	class ListScrollBar : Rsc86ScrollBar{};
	class ScrollBar : Rsc86ScrollBar{};
};
class Rsc86IGUIListNBox: Rsc86ListNBox {
	style = "0 + 0x10";
	shadow = 2;
	color[] = {1,1,1,1};
	colorText[] = {1,1,1,0.75};
	colorScrollbar[] = {0.95,0.95,0.95,1};
	colorSelect[] = {0.95,0.95,0.95,1};
	colorSelect2[] = {0.95,0.95,0.95,1};
	colorSelectBackground[] = {1,1,1,1.0};
	colorSelectBackground2[] = {1,1,1,1.0};
	period = 0;
	colorBackground[] = {0,0,0,1};
	columns[] = {0.1,0.7,0.1,0.1};
	class ScrollBar: ScrollBar{};
};

class Rsc86Edit {
	type = 2;
	style = "0x00 + 0x40";
	shadow = 2;
	sizeEx = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	font = "PuristaLight";
	autocomplete = "";
	text = "";
	colorBackground[] = {0,0,0,1};
	colorText[] = {0.95,0.95,0.95,1};
	colorDisabled[] = {1,1,1,0.25};
	colorSelection[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1};
	canModify = 1;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};

class Rsc86Slider {
	type = 3;
	h = 0.025;
	color[] = {1,1,1,0.8};
	colorActive[] = {1,1,1,1};
};

class Rsc86XSliderH {
	type = 43;
	style = "0x400	+ 0x10";
	shadow = 0;
	x = 0;
	y = 0;
	h = 0.029412;
	w = 0.4;
	blinkingPeriod = 0;
	font = "PuristaMedium";
	color[] = {1,1,1,0.6};
	colorActive[] = {1,0.5,0,1};
	colorDisabled[] = {1,1,1,0.2};
	colorSelect[] = {1,0.5,0,1};
	colorText[] = {1,1,1,1};
	arrowEmpty = "\A3\ui_f\data\gui\cfg\slider\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\slider\arrowFull_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\slider\border_ca.paa";
	soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1};
	thumb = "\A3\ui_f\data\gui\cfg\slider\thumb_ca.paa";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};

class Rsc86XListBox {
	access = 0;
	type = 42;
	style = "0x400 + 0x02 +	0x10";
	default = 0;
	x = 0;
	y = 0;
	h = 0.029412;
	w = 0.4;
	blinkingPeriod = 0;
	font = "PuristaMedium";
	color[] = {1,1,1,0.6};
	colorActive[] = {1,0.5,0,1};
	colorDisabled[] = {1,1,1,0.2};
	colorSelect[] = {1,0.5,0,1};
	colorText[] = {1,1,1,1};
	arrowEmpty = "\A3\ui_f\data\gui\cfg\slider\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\slider\arrowFull_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\slider\border_ca.paa";
	soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1};
	shadow = 0;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	tooltip = "";
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};

class Rsc86Frame {
	type = 0;
	idc = -1;
	style = 64;
	shadow = 2;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = "PuristaMedium";
	sizeEx = 0.02;
	text = "";
};

class Rsc86Background: Rsc86Text {
	type = 0;
	IDC = -1;
	style = 512;
	shadow = 0;
	x = 0.0;
	y = 0.0;
	w = 1.0;
	h = 1.0;
	text = "";
	ColorBackground[] = {0.48,0.5,0.35,1};
	ColorText[] = {0.1,0.1,0.1,1};
	font = "PuristaMedium";
	SizeEx = 1;
};

class Rsc86HTML {
	colorText[] = {1,1,1,1.0};
	colorBold[] = {1,1,1,1.0};
	colorLink[] = {1,1,1,0.75};
	colorLinkActive[] = {1,1,1,1.0};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	prevPage = "\A3\ui_f\data\gui\rsccommon\rschtml\arrow_left_ca.paa";
	nextPage = "\A3\ui_f\data\gui\rsccommon\rschtml\arrow_right_ca.paa";
	shadow = 2;
	class H1
	{
		font = "PuristaMedium";
		fontBold = "PuristaSemibold";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
		align = "left";
	};
	class H2
	{
		font = "PuristaMedium";
		fontBold = "PuristaSemibold";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		align = "right";
	};
	class H3
	{
		font = "PuristaMedium";
		fontBold = "PuristaSemibold";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		align = "left";
	};
	class H4
	{
		font = "PuristaMedium";
		fontBold = "PuristaSemibold";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		align = "left";
	};
	class H5
	{
		font = "PuristaMedium";
		fontBold = "PuristaSemibold";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		align = "left";
	};
	class H6
	{
		font = "PuristaMedium";
		fontBold = "PuristaSemibold";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		align = "left";
	};
	class P
	{
		font = "PuristaMedium";
		fontBold = "PuristaSemibold";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		align = "left";
	};
};

class Rsc86MapControlTooltip: Rsc86ControlsGroupNoScrollbars {
	idc = 2350;
	x = -1;
	y = -1;
	w = 0;
	h = 0;
	class Controls {
		class Background: Rsc86Text {
			idc = 235000;
			x = 1;
			y = 1;
			w = 1;
			h = 1;
			colorBackground[] = {0,0,0,1};
		};
		class InfoBackground: Rsc86StructuredText {
			idc = 235001;
			x = 0;
			y = 0;
			w = 1;
			h = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {1,1,1,0.15};
		};
		class Info: Rsc86StructuredText {
			idc = 235002;
			x = 1;
			y = 1;
			w = 1;
			h = 1;
		};
		class AssetsBackground: Rsc86StructuredText {
			idc = 235003;
			x = 1;
			y = 1;
			w = 1;
			h = 1;
			colorBackground[] = {0,0,0,1};
		};
		class Assets: Rsc86StructuredText {
			idc = 235004;
			x = 1;
			y = 1;
			w = 1;
			h = 1;
		};
		class PictureBackground: Rsc86Text {
			idc = 235005;
			x = 1;
			y = 1;
			w = 1;
			h = 1;
			colorBackground[] = {0,0,0,1};
		};
		class PictureX: Rsc86PictureKeepAspect {
			idc = 235006;
			x = -1;
			y = -1;
			w = 0;
			h = 0;
			autoplay = 1;
			loops = 1;
		};
	};
};
class Rsc86MessageBox: Rsc86ControlsGroupNoScrollbars {
	idc = 2351;
	x = -1;
	y = -1;
	w = 0;
	h = 0;
	class Controls {
		class BcgCommonTop: Rsc86StructuredText {
			idc = 235100;
			x = 0;
			y = 0;
			w = "18.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",1};
		};
		class BcgCommon: Rsc86StructuredText {
			idc = 235101;
			x = 0;
			y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "18.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,1};
		};
		class Text: Rsc86StructuredText {
			idc = 235102;
			x = "0.7 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "1.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "17 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class BackgroundButtonOK: Rsc86StructuredText {
			idc = 235103;
			x = 0;
			y = "2.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "6.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,1};
		};
		class BackgroundButtonMiddle: BackgroundButtonOK {
			idc = 235104;
			x = "6.3 * (((safezoneW / safezoneH) min 1.2) / 40)";
		};
		class BackgroundButtonCancel: BackgroundButtonOK {
			idc = 235105;
			x = "12.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
		};
		class ButtonOK: Rsc86ButtonMenuOK {
			default = 1;
			idc = 235106;
			colorBackground[] = {0,0,0,1};
			x = 0;
			y = "2.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "6.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class ButtonCancel: Rsc86ButtonMenuCancel {
			idc = 235107;
			colorBackground[] = {0,0,0,1};
			x = "12.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "2.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "6.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
	};
};
class Rsc86MapControl {
	moveOnEdges = 1;
	type = 101;
	style = 48;
	x = "SafeZoneXAbs";
	y = "SafeZoneY + 1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	w = "SafeZoneWAbs";
	h = "SafeZoneH - 1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	shadow = 0;
	ptsPerSquareSea = 5;
	ptsPerSquareTxt = 20;
	ptsPerSquareCLn = 10;
	ptsPerSquareExp = 10;
	ptsPerSquareCost = 10;
	ptsPerSquareFor = 9;
	ptsPerSquareForEdge = 9;
	ptsPerSquareRoad = 6;
	ptsPerSquareObj = 9;
	showCountourInterval = 0;
	scaleMin = 0.001;
	scaleMax = 1.0;
	scaleDefault = 0.16;
	maxSatelliteAlpha = 1;//0.85;
	alphaFadeStartScale = 2;
	alphaFadeEndScale = 2;
	colorBackground[] = {0.969,0.957,0.949,1.0};
	colorSea[] = {0.467,0.631,0.851,0.5};
	colorForest[] = {0.624,0.78,0.388,0.5};
	colorForestBorder[] = {0.0,0.0,0.0,0.0};
	colorRocks[] = {0.0,0.0,0.0,0.3};
	colorRocksBorder[] = {0.0,0.0,0.0,0.0};
	colorLevels[] = {0.286,0.177,0.094,0.5};
	colorMainCountlines[] = {0.572,0.354,0.188,0.5};
	colorCountlines[] = {0.572,0.354,0.188,0.25};
	colorMainCountlinesWater[] = {0.491,0.577,0.702,0.6};
	colorCountlinesWater[] = {0.491,0.577,0.702,0.3};
	colorPowerLines[] = {0.1,0.1,0.1,1.0};
	colorRailWay[] = {0.8,0.2,0.0,1.0};
	colorNames[] = {0.1,0.1,0.1,0.9};
	colorInactive[] = {1.0,1.0,1.0,0.5};
	colorOutside[] = {0.0,0.0,0.0,1.0};
	colorTracks[] = {0.84,0.76,0.65,0.15};
	colorTracksFill[] = {0.84,0.76,0.65,1.0};
	colorRoads[] = {0.7,0.7,0.7,1.0};
	colorRoadsFill[] = {1.0,1.0,1.0,1.0};
	colorMainRoads[] = {0.9,0.5,0.3,1.0};
	colorMainRoadsFill[] = {1.0,0.6,0.4,1.0};
	colorGrid[] = {0.1,0.1,0.1,0.6};
	colorGridMap[] = {0.1,0.1,0.1,0.6};
	colorText[] = {0,0,0,1};
	font = "PuristaMedium";
	fontLabel = "PuristaMedium";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	sizeExLabel = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontGrid = "TahomaB";
	sizeExGrid = 0.02;
	fontUnits = "TahomaB";
	sizeExUnits = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontNames = "EtelkaNarrowMediumPro";
	sizeExNames = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8) * 2";
	fontInfo = "PuristaMedium";
	sizeExInfo = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontLevel = "TahomaB";
	sizeExLevel = 0.02;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	class ActiveMarker {
		color[] = {0.30, 0.10, 0.90, 1.00};
		size = 50;
	};
	class Legend
	{
		x = "SafeZoneX + (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "SafeZoneY + safezoneH - 4.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "3.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		font = "PuristaMedium";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		colorBackground[] = {1,1,1,0.5};
		color[] = {0,0,0,1};
	};
	class Task
	{
		icon = "\A3\ui_f\data\map\mapcontrol\taskIcon_CA.paa";
		iconCreated = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_CA.paa";
		iconCanceled = "\A3\ui_f\data\map\mapcontrol\taskIconCanceled_CA.paa";
		iconDone = "\A3\ui_f\data\map\mapcontrol\taskIconDone_CA.paa";
		iconFailed = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_CA.paa";
		color[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])","(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
		colorCreated[] = {1,1,1,1};
		colorCanceled[] = {0.7,0.7,0.7,1};
		colorDone[] = {0.7,1,0.3,1};
		colorFailed[] = {1,0.3,0.2,1};
		size = 27;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class Waypoint
	{
		coefMax = 1;
		coefMin = 1;
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		color[] = {0,0,0,1};
		size = 24;
		importance = 1;
	};
	class WaypointCompleted
	{
		coefMax = 1;
		coefMin = 1;
		icon = "\A3\ui_f\data\map\mapcontrol\waypointCompleted_ca.paa";
		color[] = {0,0,0,1};
		size = 24;
		importance = 1;
	};
	class CustomMark
	{
		icon = "\A3\ui_f\data\map\mapcontrol\custommark_ca.paa";
		size = 24;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		color[] = {0,0,0,1};
	};
	class Command
	{
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		color[] = {1,1,1,1};
	};
	class Bush
	{
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[] = {0.45,0.64,0.33,0.4};
		size = 7;
		importance = "0.2 * 14 * 0.05 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Rock
	{
		icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
		color[] = {0.1,0.1,0.1,0.8};
		size = 12;
		importance = "0.5 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class SmallTree
	{
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[] = {0.45,0.64,0.33,0.4};
		size = 12;
		importance = "0.6 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Tree
	{
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[] = {0.45,0.64,0.33,0.4};
		size = 12;
		importance = "0.9 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class busstop
	{
		icon = "\A3\ui_f\data\map\mapcontrol\busstop_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class fuelstation
	{
		icon = "\A3\ui_f\data\map\mapcontrol\fuelstation_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class hospital
	{
		icon = "\A3\ui_f\data\map\mapcontrol\hospital_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class church
	{
		icon = "\A3\ui_f\data\map\mapcontrol\church_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class lighthouse
	{
		icon = "\A3\ui_f\data\map\mapcontrol\lighthouse_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class power
	{
		icon = "\A3\ui_f\data\map\mapcontrol\power_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class powersolar
	{
		icon = "\A3\ui_f\data\map\mapcontrol\powersolar_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class powerwave
	{
		icon = "\A3\ui_f\data\map\mapcontrol\powerwave_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class powerwind
	{
		icon = "\A3\ui_f\data\map\mapcontrol\powerwind_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class quay
	{
		icon = "\A3\ui_f\data\map\mapcontrol\quay_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class transmitter
	{
		icon = "\A3\ui_f\data\map\mapcontrol\transmitter_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class watertower
	{
		icon = "\A3\ui_f\data\map\mapcontrol\watertower_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class Cross
	{
		icon = "\A3\ui_f\data\map\mapcontrol\Cross_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {0,0,0,1};
	};
	class Chapel
	{
		icon = "\A3\ui_f\data\map\mapcontrol\Chapel_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {0,0,0,1};
	};
	class Shipwreck
	{
		icon = "\A3\ui_f\data\map\mapcontrol\Shipwreck_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {0,0,0,1};
	};
	class Bunker
	{
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 14;
		importance = "1.5 * 14 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Fortress
	{
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Fountain
	{
		icon = "\A3\ui_f\data\map\mapcontrol\fountain_ca.paa";
		size = 11;
		importance = "1 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Ruin
	{
		icon = "\A3\ui_f\data\map\mapcontrol\ruin_ca.paa";
		size = 16;
		importance = "1.2 * 16 * 0.05";
		coefMin = 1;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Stack
	{
		icon = "\A3\ui_f\data\map\mapcontrol\stack_ca.paa";
		size = 20;
		importance = "2 * 16 * 0.05";
		coefMin = 0.9;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Tourism
	{
		icon = "\A3\ui_f\data\map\mapcontrol\tourism_ca.paa";
		size = 16;
		importance = "1 * 16 * 0.05";
		coefMin = 0.7;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class ViewTower
	{
		icon = "\A3\ui_f\data\map\mapcontrol\viewtower_ca.paa";
		size = 16;
		importance = "2.5 * 16 * 0.05";
		coefMin = 0.5;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class LineMarker {
		lineWidthThin = 0.008;
		lineWidthThick = 0.014;
		lineLengthMin = 5;
		lineDistanceMin = 3e-005;
		textureComboBoxColor = "#(argb,8,8,3)color(1,1,1,1)";
	};
};

class Rsc86MapControlEmpty: Rsc86MapControl {
	type = 101;
	ptsPerSquareSea = 1000;
	ptsPerSquareTxt = 1000;
	ptsPerSquareCLn = 1000;
	ptsPerSquareExp = 1000;
	ptsPerSquareCost = 1000;
	ptsPerSquareFor = 1000;
	ptsPerSquareForEdge = 1000;
	ptsPerSquareRoad = 1000;
	ptsPerSquareObj = 1000;
	alphaFadeStartScale = 0;
	alphaFadeEndScale = 0;
	colorBackground[] = {1,1,1,1};
	colorOutside[] = {1,1,1,1};
	colorSea[] = {0,0,0,0};
	colorForest[] = {0,0,0,0};
	colorForestBorder[] = {0,0,0,0};
	colorRocks[] = {0,0,0,0};
	colorRocksBorder[] = {0,0,0,0};
	colorLevels[] = {0,0,0,0};
	colorMainCountlines[] = {0,0,0,0};
	colorCountlines[] = {0,0,0,0};
	colorMainCountlinesWater[] = {0,0,0,0};
	colorCountlinesWater[] = {0,0,0,0};
	colorPowerLines[] = {0,0,0,0};
	colorRailWay[] = {0,0,0,0};
	colorNames[] = {0,0,0,0};
	colorInactive[] = {0,0,0,0};
	colorGrid[] = {0,0,0,0};
	colorGridMap[] = {0,0,0,0};
	class Task: Task
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		iconCreated = "#(argb,8,8,3)color(0,0,0,0)";
		iconCanceled = "#(argb,8,8,3)color(0,0,0,0)";
		iconDone = "#(argb,8,8,3)color(0,0,0,0)";
		iconFailed = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		colorCreated[] = {0,0,0,0};
		colorCanceled[] = {0,0,0,0};
		colorDone[] = {0,0,0,0};
		colorFailed[] = {0,0,0,0};
		size = 0;
	};
	class Waypoint: Waypoint
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class WaypointCompleted: WaypointCompleted
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class CustomMark: CustomMark
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Command: Command
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Bush: Bush
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Rock: Rock
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class SmallTree: SmallTree
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Tree: Tree
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class busstop: busstop
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class fuelstation: fuelstation
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class hospital: hospital
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class church: church
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class lighthouse: lighthouse
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class power: power
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class powersolar: powersolar
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class powerwave: powerwave
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class powerwind: powerwind
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class quay: quay
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class shipwreck: Shipwreck
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class transmitter: transmitter
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class watertower: watertower
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Bunker: Bunker
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Cross: Cross
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Fortress: Fortress
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Fountain: Fountain
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Chapel: Chapel
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Ruin: Ruin
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Stack: Stack
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Tourism: Tourism
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class ViewTower: ViewTower
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class LineMarker: LineMarker {
		lineWidthThin = 0;
		lineWidthThick = 0;
		lineLengthMin = 5;
		lineDistanceMin = 3e-005;
		textureComboBoxColor = "#(argb,8,8,3)color(0,0,0,0)";
	};
};


class Rsc86StrategicMap: Rsc86MapControl {
	x = "safezoneXAbs";
	y = "safezoneY";
	w = "safezoneWAbs";
	h = "safezoneH";
	drawObjects = 0;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	maxSatelliteAlpha = "uinamespace getvariable ['RscDisplayStrategicMap_maxSatelliteAlpha',1]";
	alphaFadeStartScale = 100;
	alphaFadeEndScale = 100;
	scaleMin = "uinamespace getvariable ['RscDisplayStrategicMap_scaleMin',0.04]";
	scaleMax = "uinamespace getvariable ['RscDisplayStrategicMap_scaleMax',0.3]";
	scaleDefault = "uinamespace getvariable ['RscDisplayStrategicMap_scaleDefault',0.3]";
	colorBackground[] = {1,1,1,1};
	colorOutside[] = {"uinamespace getvariable ['RscDisplayStrategicMap_colorOutside_R',0]","uinamespace getvariable ['RscDisplayStrategicMap_colorOutside_G',0]","uinamespace getvariable ['RscDisplayStrategicMap_colorOutside_B',0]",1};
	colorSea[] = {0.467,0.631,0.851,0.25};
	colorCountlines[] = {0,0,0,0};
	colorMainCountlines[] = {0,0,0,0};
	colorCountlinesWater[] = {0,0,0,0};
	colorMainCountlinesWater[] = {0,0,0,0};
	colorForest[] = {1,1,1,1};
	colorRocks[] = {0,0,0,0};
	colorGrid[] = {0,0,0,0.4};
	colorGridMap[] = {0,0,0,0.1};
	ptsPerSquareTxt = 20;
	ptsPerSquareRoad = 200;
	ptsPerSquareObj = 200;
	ptsPerSquareCLn = 200;
	ptsPerSquareCost = 200;
	ptsPerSquareFor = 200;
	ptsPerSquareForEdge = 200;
	sizeExLabel = 0;
	sizeExGrid = 0.03;
	sizeExUnits = 0;
	sizeExNames = 0;
	sizeExInfo = 0;
	sizeExLevel = 0;
	moveOnEdges = 1;
	showCountourInterval = 0;
	class Task: Task
	{
		size = 0;
	};
};

class Rsc86LineBreak{};

class Rsc86ComboX {
	type = 44;
	style = "0x10 + 0x200";
	font = "RobotoCondensed";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.12;
	h = 0.035;
	colorSelect[] = {0,0,0,1};
	colorText[] = {1,1,1,1.0};
	colorBackground[] = {0,0,0,1};
	colorSelectBackground[] = {1,1,1,0.7};
	colorScrollbar[] = {1,0,0,1};
	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	wholeHeight = 0.45;
	colorActive[] = {1,0,0,1};
	colorDisabled[] = {1,1,1,0.25};
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightSelected[] = {1,1,1,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
	colorTextRight[] = {1,1,1,1};
	colorSelectRight[] = {0,0,0,1};
	colorSelect2Right[] = {0,0,0,1};
	maxHistoryDelay = 1;
	tooltip = "CT_XCOMBO";
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1};
	soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1};
	soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1};
	class List {
		x = 0;
		y = 0;
		w = 0.12;
		h = 0.035;
		colorBackground[] = {0.2,0.2,0.2,1}; // List fill color
		colorSelectBackground[] = {1,0.5,0,1}; // Selected item fill color (oscillates between this and colorSelectBackground2 in control root)
		colorBorder[] = {1,1,1,1}; // List scrollbar color (combined with Scrollbar >> color)
		rowHeight = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		colorText[] = {1,1,1,1}; // Text color
		colorSelect[] = {1,1,1,1}; // Selected text color (oscillates between this and colorSelect2 in control root)
	};
	class ScrollBar {
		width = 0; // width of scrollBar
		height = 0; // height of scrollbar
		scrollSpeed = 0.01; // speed of scroll bar
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)
		color[] = {1,1,1,1}; // Scrollbar color (combined with List >> colorBorder)
	};
};

class Rsc86Combo {
	type = 44;
	style = "0x10 + 0x200";
	font = "RobotoCondensed";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.12;
	h = 0.035;
	colorSelect[] = {0,0,0,1};
	colorText[] = {1,1,1,1.0};
	colorBackground[] = {0,0,0,1};
	colorSelectBackground[] = {1,1,1,0.7};
	colorScrollbar[] = {1,0,0,1};
	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	wholeHeight = 0.45;
	colorActive[] = {1,0,0,1};
	colorDisabled[] = {1,1,1,0.25};
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightSelected[] = {1,1,1,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
	colorTextRight[] = {1,1,1,1};
	colorSelectRight[] = {0,0,0,1};
	colorSelect2Right[] = {0,0,0,1};
	maxHistoryDelay = 1;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1};
	soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1};
	soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1};
	class ScrollBar: Rsc86ScrollBar {
		color[] = {1,1,1,1};
	};
};

class Rsc86Toolbox {
	colorText[] = {0.95,0.95,0.95,1};
	color[] = {0.95,0.95,0.95,1};
	colorTextSelect[] = {0.95,0.95,0.95,1};
	colorSelect[] = {0.95,0.95,0.95,1};
	colorTextDisable[] = {0.4,0.4,0.4,1};
	colorDisable[] = {0.4,0.4,0.4,1};
	colorSelectedBg[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.5};
	font = "PuristaMedium";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};

class Rsc86Vignette: Rsc86Picture {
	x = "safezoneXAbs";
	y = "safezoneY";
	w = "safezoneWAbs";
	h = "safezoneH";
	text = "\A3\ui_f\data\gui\rsccommon\rscvignette\vignette_gs.paa";
	colortext[] = {0,0,0,0.3};
};

class Rsc86BackgroundGUI: Rsc86Text {
	colorBackground[] = {0,0,0,0.5};
	colorText[] = {1,1,1,1};
	background = 1;
};

class Rsc86BackgroundGUILeft: Rsc86Picture {
	text = "A3\ui_f\data\gui\rsccommon\rscbackgroundgui\gradient_left_gs.paa";
	colorText[] = {1,1,1,"0.3*0"};
	colorBackground[] = {0,0,0,0};
	background = 1;
};

class Rsc86BackgroundGUIRight: Rsc86Picture {
	text = "A3\ui_f\data\gui\rsccommon\rscbackgroundgui\gradient_right_gs.paa";
	colorText[] = {0,0,0,"0.4*0"};
	colorBackground[] = {0,0,0,0};
	background = 1;
};

class Rsc86BackgroundGUIBottom: Rsc86Picture {
	colorText[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.8};
	text = "A3\ui_f\data\gui\rsccommon\rscshortcutbutton\background_ca.paa";
	align = "bottom";
	background = 1;
};

class Rsc86BackgroundGUITop: Rsc86Text {
	colorBackground[] = {0,0,0,1};
	align = "top";
	moving = 1;
	background = 1;
};

class Rsc86BackgroundGUIDark: Rsc86Text {
	colorBackground[] = {0,0,0,0.2};
	background = 1;
};

class RscAmrelPDA: Rsc86PictureKeepAspect {
	x = "safeZoneX + (profileNameSpace getVariable [""Roy86_IGUI_AmrelPDA_X"",0])";
	y = "safeZoneY + (profileNameSpace getVariable [""Roy86_IGUI_AmrelPDA_Y"",0])";
	w = "12.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "25.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	text = "MPSF\data\amrel\itemAmrelPDA_ca.paa";
};

class RscAmrelTablet: Rsc86PictureKeepAspect {
	x = "safeZoneX + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_X"",0])";
	y = "safeZoneY + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_Y"",0])";
	w = "51.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "25.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	text = "MPSF\data\amrel\itemAmrelTablet_ca.paa";
};