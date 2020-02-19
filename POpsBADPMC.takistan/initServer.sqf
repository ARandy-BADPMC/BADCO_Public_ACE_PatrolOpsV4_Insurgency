["Initialize", [true]] call BIS_fnc_dynamicGroups;
call compileFinal preprocessfilelinenumbers "MPSF\functions\VirtualArmoury\BADCO_Arsenal.sqf";
call compileFinal preprocessFileLineNumbers "MPSF\functions\VirtualDepot\BADCO_skin_applier.sqf";

civilian setFriend [west,1];
civilian setFriend [east,1];
east setFriend [west,0];
east setFriend [resistance,0];
resistance setFriend [west,0];
resistance setFriend [east,0];
west setFriend [east,0];
west setFriend [resistance,0];