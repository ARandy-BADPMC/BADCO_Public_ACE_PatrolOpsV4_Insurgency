["Initialize", [true]] call BIS_fnc_dynamicGroups;
call compileFinal preprocessfilelinenumbers "MPSF\functions\VirtualArmoury\BADCO_Arsenal.sqf";
call compileFinal preprocessFileLineNumbers "MPSF\functions\VirtualDepot\BADCO_skin_applier.sqf";
_BADCO_UAV_check = call compile preprocessFileLineNumbers "MPSF\functions\BADCO_UAV_check.sqf"; 

civilian setFriend [west,1];
civilian setFriend [east,1];
east setFriend [west,0];
east setFriend [resistance,1];
resistance setFriend [west,0];
resistance setFriend [east,1];
west setFriend [east,0];
west setFriend [resistance,0];

[] spawn _BADCO_UAV_check;