{
	while {true} do 
	{
		
		_uavs = allUnitsUAV;
		{
			if (typeOf _x == "B_UAV_02_dynamicLoadout_F" || typeOf _x == "B_UAV_05_F" || typeOf _x == "B_T_UAV_03_dynamicLoadout_F") then 
			{
				_controllers = UAVControl _x;
				if (count _controllers == 0) exitWith {};
				if (typeOf (UAVControl _x select 0) != "rhsusf_usmc_marpat_d_uav") then 
				{
					(UAVControl _x select 0) connectTerminalToUAV objNull;
				};
				if (typeOf (UAVControl _x select 2) != "rhsusf_usmc_marpat_d_uav") then 
				{
					(UAVControl _x select 2) connectTerminalToUAV objNull;
				};
			};
		} forEach _uavs;
		sleep 1;
	};
};