/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_dynamicSimulation.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Handles BIS Dynamic Simulation (Cache) to improve performance

	Returns:
		Bool - True when done
*/

// Enable BIS Dynamic Simulation
enableDynamicSimulationSystem true;
// Set Group Simulation Distance
"Group" setDynamicSimulationDistance (viewDistance - (viewDistance * fog));
// Set Occupied Vehicle Simulation Distance
"Vehicle" setDynamicSimulationDistance (viewDistance - (viewDistance * fog));
// Set Empty Vehicle Simulation Distance
"EmptyVehicle" setDynamicSimulationDistance 250;
// Set Object Simulation Distance
"Prop" setDynamicSimulationDistance 50;

// Update distance based on viewdistance and fog
["MPSF_fnc_dynamicSimulation_onEachFrame","onEachFrame",{
	if (diag_frameno%30000 == 4) then {
		"Group" setDynamicSimulationDistance (viewDistance - (viewDistance * fog));
		"Vehicle" setDynamicSimulationDistance (viewDistance - (viewDistance * fog));
	};
}] call MPSF_fnc_addEventHandler;

if (isServer) then {
	//
};

if (hasInterface) then {
	//
};

true;