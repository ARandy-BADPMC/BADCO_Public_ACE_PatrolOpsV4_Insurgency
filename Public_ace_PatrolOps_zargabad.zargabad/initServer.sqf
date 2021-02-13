["Initialize", [true]] call BIS_fnc_dynamicGroups;
call compileFinal preprocessfilelinenumbers "MPSF\functions\VirtualArmoury\BADCO_Arsenal.sqf";

civilian setFriend [west,1];
civilian setFriend [east,1];
east setFriend [west,0];
east setFriend [resistance,1];
resistance setFriend [west,0];
resistance setFriend [east,1];
west setFriend [east,0];
west setFriend [resistance,0];

[] spawn 
	{
		while {true} do 
			{
				diag_log format ["### Hz_diag: %1, %2, %3, %4, %5, %6",diag_fps,viewDistance, count diag_activeSQFScripts, {local _x} count allunits, {local _x} count vehicles, {local agent _x} count agents];
				uiSleep 60;
			};
	};
	
[] spawn 
	{
		while {true} do 
			{
				_players = allPlayers;
				if (count _players > 0) then
				{
					{
					_currentPlayerLoadout = getUnitLoadout _x;
					diag_log format ["### Player %1 loadout:",_x];
					diag_log _currentPlayerLoadout;
					} forEach _players;
				};
				uiSleep 600;
			};
	};
