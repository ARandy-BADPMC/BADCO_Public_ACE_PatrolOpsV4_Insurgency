{
	while {true} do 
	{
		{
			if (typeOf _x == "B_UAV_02_dynamicLoadout_F" || {typeOf _x == "B_UAV_05_F"} || {typeOf _x == "B_T_UAV_03_dynamicLoadout_F"}) then 
			{
				if (count UAVControl _x) exitWith {};
				if (typeOf (UAVControl _x select 0) != "rhsusf_usmc_marpat_d_uav") then 
				{
					(UAVControl _x select 0) connectTerminalToUAV objNull;
				};
				if (typeOf (UAVControl _x select 2) != "rhsusf_usmc_marpat_d_uav") then 
				{
					(UAVControl _x select 2) connectTerminalToUAV objNull;
				};
			};
		} forEach allUnitsUAV;
		sleep 1;
	};
};