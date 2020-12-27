#define CTRLMAP		(findDisplay 12 displayCtrl 51)
#define ICONNATO(natoIcon) ("\a3\ui_f\data\Map\Markers\NATO\" + natoIcon + ".paa")
#define EVENTID		"MPSF_DrawMap_squadMarkers_EH"
#define EVENTTYPE	"MapDraw"

params [["_drawState",false,[false]]];

if !(_drawState) then {
	if ([EVENTID,EVENTTYPE] call MPSF_fnc_isEventHandler) then {
		[EVENTID,EVENTTYPE] call MPSF_fnc_removeEventHandler;
	};
} else {
	[EVENTID,EVENTTYPE,{
		private _assignedItems = (assigneditems player apply {_x call BIS_fnc_itemType}) apply {_x select 1};
		if !(count (["GPS","UAVTerminal"] arrayIntersect _assignedItems) > 0) exitWith {};
		private _size = 36 min (8 * 0.15) * 10^(abs log (ctrlMapScale CTRLMAP));
		{
			private _leader = leader _x;
			private _mapPosition = getPos _leader;
			private _iconType = _x getVariable ["natoIcon",[vehicle _leader,false] call MPSF_fnc_getCfgIconNATO];
			private _iconSize = [count units _x] call MPSF_fnc_getCfgIconNATOSize;
			private _iconColor = (configfile >> "CfgMarkerColors" >> ([[_leader] call BIS_fnc_objectSide,true] call BIS_fnc_sideColor) >> "color") call BIS_fnc_colorConfigToRGBA;

			private _groupID = (groupID _x) splitString " ";
			private _groupSide = _groupID deleteAt 0;
			private _groupName = _groupID joinString " ";

			CTRLMAP drawIcon ["#(argb,8,8,3)color(0,0,0,0)",[1,1,1,0.8],_mapPosition,_size,_size,0,format ["%1 ",_groupSide],2,(_size/1000),"PuristaLight",'left'];
			CTRLMAP drawIcon ["#(argb,8,8,3)color(0,0,0,0)",[1,1,1,0.8],_mapPosition,_size,_size,0,format [" %1",_groupName],2,(_size/1000),"PuristaLight",'right'];
			CTRLMAP drawIcon [_iconSize,_iconColor,_mapPosition,_size*1.1,_size*1.1,0,"",0,0.05,"PuristaLight",'center'];
			CTRLMAP drawIcon [ICONNATO(_iconType),_iconColor,_mapPosition,_size,_size,0,"",0,0.05,"PuristaLight",'center'];
		} forEach (allGroups select {[side _x,side group player] call BIS_fnc_areFriendly});
	}] call MPSF_fnc_addEventHandler;
};