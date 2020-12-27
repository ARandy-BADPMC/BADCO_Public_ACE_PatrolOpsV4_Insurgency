// Temporary until SquadMod
["InitializePlayer",[player, true]] call BIS_fnc_dynamicGroups;
call compile preprocessFileLineNumbers "MPSF\functions\BADCO_class_check.sqf"; 
/*
[] spawn {
	disableSerialization;
	waitUntil{ !isNull (findDisplay 46) };
	private _ctrlText = (findDisplay 46) ctrlCreate ["RscStructuredText",-1];
	private _sitrep = format ["<t font='PuristaMedium' align='right' size='0.7' shadow='0'>%3<br/>%1<br/>%2</t>",briefingName,getText(missionConfigFile >> "PatrolOpsVersion"),"<img image='mpsf\data\titles\patrolops_logo_co.paa' size='2.2'/>"];
	_ctrlText ctrlSetStructuredText parseText _sitrep;
	_ctrlText ctrlSetTextColor [1,1,1,0.7];
	_ctrlText ctrlSetBackgroundColor [0,0,0,0];
	_ctrlText ctrlSetPosition [
		(safezoneW - 22 * (((safezoneW / safezoneH) min 1.2) / 40)) + (safeZoneX)
		,(safezoneH - 5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) + (safeZoneY)
		,20 * (((safezoneW / safezoneH) min 1.2) / 40)
		,5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
	];
	_ctrlText ctrlSetFade 0.5;
	_ctrlText ctrlCommit 0;
	true;
};
*/
_boxes = [box1,box2,box3];
{_x addaction ["Arsenal", 
	{[_this select 0, _this select 1] call ace_arsenal_fnc_openBox;},nil,0,true,false,"","",10];
} forEach _boxes;

[["PatrolOps4","BeginPO4"]] call BIS_fnc_advHint;
["Tutorial_VirtualArmoury","Assigned",true] call MPSF_fnc_updateTaskState;
// Team Killer Rating Neutraliser
["Player_onHandleRating_EH","onHandleRating",{ if (rating player <= 0) then { player addRating ((abs rating player)+1); }; }] call MPSF_fnc_addEventHandler;

_uid = getPlayerUID player;
_SOAR = ["76561198117073327","76561198142692277","76561198059583284","76561198067590754","76561198067590754"];//76561198142692277 -Alex. K., 76561198117073327 - A.Randy,   76561198059583284 - Vittex?, 76561198067590754 - Mas Pater, "76561198129876850" - Dehumanized
if (_uid in _soar) then {player setVariable ["SOAR",1]};
player addEventHandler ["GetInMan",{[_this select 0,_this select 1, _this select 2] call BADCO_role_check;}];
if (typeof player == "rhsusf_usmc_marpat_d_uav" || typeOf player == "rhsusf_airforce_jetpilot") then 
{
	if (_uid in _soar) then 
	{
		hint "Welcome whitelisted player"
	} else 
	{
		["epicFail",false,2] call BIS_fnc_endMission;				
	};
};

_clanStatus = (squadparams player select 0) select 0;
switch (_clanStatus) do {
	case "B.A.D. PMC": {player setpos [5028.4,6098.36,0.157372];};
	case "Bad Co": {player setpos [4928.1,6067.26,0];};
	default {}
};
if (name player == "Dehumanized") then {player setPos [5002.38,6099.9,0]; player forceAddUniform "U_C_WorkerCoveralls";};

removeAllWeapons player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;
arsenal_gate setVariable ['bis_disabled_Door_1',1,true];

[] spawn {
	sleep 10;	
	if ((isnil "acre_sys_io_serverStarted") || {!acre_sys_io_serverStarted}) then {
		endMission "ACRE_disabled";
	};
};
