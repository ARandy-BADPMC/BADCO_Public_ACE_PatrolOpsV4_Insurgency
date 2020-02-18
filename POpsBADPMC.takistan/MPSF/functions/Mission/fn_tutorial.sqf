params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
// Init
	case "postInit";
	case "init" : {
		if (hasInterface) then {
			waitUntil { !isNull player && ["PatrolOperations"] call BIS_fnc_taskExists };
			// Patrolling
			["PO4_Tutorial_HasMoved_1_EH","HasMoved",{
				["PO4_Tutorial_HasMoved_1_EH","HasMoved"] call MPSF_fnc_removeEventHandler;
				[["PatrolOps4","BeginPO4"]] call BIS_fnc_advHint;
			}] call MPSF_fnc_addEventHandler;
			// Virtual Armoury
			[["Tutorial_VirtualArmoury","PatrolOperations"],player,["Access the Virtual Armoury to set your loadout based on your squad role","Gear Up (Optional)"],"Virtual_Armoury_Marker",nil,nil,nil,"rearm"] call MPSF_fnc_createTask; // TODO localize
			["PO4_Tutorial_arsenalOpened_EH","arsenalOpened",{
				["PO4_Tutorial_arsenalOpened_EH","arsenalOpened"] call MPSF_fnc_removeEventHandler;
				["Tutorial_VirtualArmoury","Succeeded",true] call MPSF_fnc_updateTaskState;
				[["PatrolOps4","PO4BeginArmoury"]] call BIS_fnc_advHint;
			}] call MPSF_fnc_addEventHandler;
			// Spawn a vehicle
			[["Tutorial_VirtualDepot","PatrolOperations"],player,["Access the Virtual Depot to create or modify a vehicle for your squad","Get Mounted (Optional)"],"Virtual_Depot_Marker",nil,nil,nil,"car"] call MPSF_fnc_createTask; // TODO localize
			["PO4_Tutorial_virtualDepotOpened_EH","virtualDepotOpened",{
				["PO4_Tutorial_virtualDepotOpened_EH","virtualDepotOpened"] call MPSF_fnc_removeEventHandler;
				["Tutorial_VirtualDepot","Succeeded",true] call MPSF_fnc_updateTaskState;
				[["PatrolOps4","PO4BeginDepot"]] call BIS_fnc_advHint;
			}] call MPSF_fnc_addEventHandler;
			// Intel
			["PO4_Tutorial_onIntelCreated_EH","onIntelCreated",{
				["PO4_Tutorial_onIntelCreated_EH","onIntelCreated"] call MPSF_fnc_removeEventHandler;
				[["PatrolOps4","PO4BeginIntel"]] call BIS_fnc_advHint;
			}] call MPSF_fnc_addEventHandler;
			["PO4_Tutorial_onIntelDownloadStart_EH","onIntelDownloadStart",{
				["PO4_Tutorial_onIntelDownloadStart_EH","onIntelDownloadStart"] call MPSF_fnc_removeEventHandler;
				// TODO
			}] call MPSF_fnc_addEventHandler;
			["PO4_Tutorial_onIntelRecieve_EH","onIntelRecieve",{
				["PO4_Tutorial_onIntelRecieve_EH","onIntelRecieve"] call MPSF_fnc_removeEventHandler;
				// TODO
			}] call MPSF_fnc_addEventHandler;
			["PO4_Tutorial_onIntelCreateOp_EH","onIntelCreateOp",{
				["PO4_Tutorial_onIntelCreateOp_EH","onIntelCreateOp"] call MPSF_fnc_removeEventHandler;
				// TODO
			}] call MPSF_fnc_addEventHandler;
			// Respawn MHQ
			["PO4_Tutorial_onMHQinit_EH","onMHQinit",{
				["PO4_Tutorial_onMHQinit_EH","onMHQinit"] call MPSF_fnc_removeEventHandler;
				// TODO
			}] call MPSF_fnc_addEventHandler;
			["PO4_Tutorial_onDeployMHQ_EH","onDeployMHQ",{
				["PO4_Tutorial_onDeployMHQ_EH","onDeployMHQ"] call MPSF_fnc_removeEventHandler;
				// TODO
			}] call MPSF_fnc_addEventHandler;
			// Revive
			["PO4_Tutorial_onInjured_EH","onInjured",{
				["PO4_Tutorial_onInjured_EH","onInjured"] call MPSF_fnc_removeEventHandler;
				[["PatrolOps4","PO4BeginReviveMP"]] call BIS_fnc_advHint;
			}] call MPSF_fnc_addEventHandler;
			// Begin Patrolling
			if (time < 10) then {
				[["Tutorial_BeginPatrol","PatrolOperations"],player,["Conduct a patrol of a nearby area in search of any hostile force or INTEL on their operations.","Conduct a Patrol"],[],nil,nil,nil,"rearm"] call MPSF_fnc_createTask; // TODO localize
			};
			["PO4_Tutorial_onEncounterCreate_EH","onEncounterCreate",{
				["PO4_Tutorial_onEncounterCreate_EH","onEncounterCreate"] call MPSF_fnc_removeEventHandler;
				["Tutorial_BeginPatrol","Succeeded",true] call MPSF_fnc_updateTaskState;
				[["PatrolOps4","PO4BeginPatrol"]] call BIS_fnc_advHint;
			}] call MPSF_fnc_addEventHandler;
		};
	};
};