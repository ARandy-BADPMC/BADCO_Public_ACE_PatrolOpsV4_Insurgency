PatrolOpsVersion = "4.0.610 RC";
HorzionConflictVersion = "0.23 ATC Beta";
missionDebugMode = 0;

class CfgMission {
	// Faction IDs found in cfgSides.hpp
	FactionTypeBLU	= "Blufor_Altis";
	FactionTypeOPF	= "Opfor_Altis";
	FactionTypeCIV 	= "Civilian_Altis";

	class Bases {
		class Malden_Base_SE {
			displayName = "Safe Base Bravo";
		};
		class Malden_Base_NE {
			displayName = "Safe Base Charlie";
		};
		class Malden_Base_NW {
			displayName = "Safe Base Delta";
		};
		class Malden_USS_Freedom {
			displayName = "Carrier (USS Freedom)";
		};
	};
};

class CfgMissionTasks {
	// Default Task Parameters
	class taskDefaults {
		scope = 0;
		target = -1;
		areaSize[] = {1000,1000};
		positionSearchRadius = 1000;
		//positionSearchTypes[] = {"Shack","Forest","Village","Clearing","Hill","House","Farm","Villa","Fuel","Factory","Airport","Military","Tower","Dock","SportField","Ruin"};
	};

	class PatrolOperations {
		scope = 2;
		typeID = 0;
		class TaskDetails {
			parent = "";
			title = "Patrol %1";
			description[] = {
				"<t>Ref: %2</t> | <t>Date: %3</t>"
				,"<t size='1.1' color='#FFC600'>Brief:</t> <t>%1 has been a region of heavy conflict for the last several years. Under current occupation by %4 Forces, the region has a tenuous sense of stability despite small underground groups running an insurgency in the hopes of profiting from a black market resource trade.</t>"
				,"<t size='1.1' color='#FFC600'>Action:</t> <t>%4 Forces will conduct regional patrols around the landscape of %1. The objective is to maintain a constant presence visible to the civilian population and to gather INTEL on regional insurgent activities in the hope of mounting further operations to eliminate it.</t>"
				,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>Little is known about what the insurgency have with respect to their resources however attacks have begun to increase in the last month. While there is no evidence of external funding and resourcing, there have been reports of %6 observers in the region and COMMAND has suspicion that the insurgency is backed by %5 Forces. More INTEL is needed before mounting serious operations against insurgent supply lines, key personnel and potentially engagements with %5 Forces.</t>"
				,"<t size='1.1' color='#FFC600'>Note:</t> <t>Redacted</t>"
			};
			iconType = "PatrolOps";
			textArguments[] = {"worldName","randomCode","datetime","factionBLUlong","factionOPFlong","factionOPFshort"};
		};
		class ChildTasks {};
		class Markers {};
	};

	/* Encounters */
	// 0 - Triggered Events
	//	#include "tasks\event_0_responseCrashedVehicle.hpp"			// Crashed Vehicle (INTEL) -- Team in distress
	//	#include "tasks\event_0_responseCrashedHelo.hpp"			// Crashed Helicopter (INTEL) -- Team in distress
	// 1 - Random Encounters
		#include "tasks\encounter_EN_jets.hpp"
		#include "tasks\encounter_EN_manpads.hpp"
		#include "tasks\encounter_EN_manpats.hpp"
		#include "tasks\encounter_INS_attack.hpp"
		#include "tasks\encounter_INS_camp.hpp"
		#include "tasks\encounter_INS_fuelStop.hpp"
		#include "tasks\encounter_INS_guard.hpp"
		#include "tasks\encounter_INS_patrol.hpp"
		#include "tasks\encounter_INS_patrolTechnical.hpp"
		#include "tasks\encounter_INS_squadTruck.hpp"

	/* Operations */
	// 2 - Eliminate Target
	//	#include "tasks\op_2_targetArmourDepot.hpp"				// 0/0 - TEST // - ArmourDepot
		#include "tasks\op_2_targetBatteryAA.hpp"					// 5/5 - Tested // - AA Battery
		#include "tasks\op_2_targetBatteryArtillery.hpp"			// 5/5 - Tested // - Artillery Battery
		#include "tasks\op_2_targetColumnArmour.hpp"				// 0/0 - TEST // - Vehicle Column Armoured
		#include "tasks\op_2_targetColumnVehicle.hpp"				// 0/0 - TEST // - Vehicle Column Soft
		#include "tasks\op_2_targetCommsCentre.hpp"				// 5/5 - Tested	// - Comms Base
		#include "tasks\op_2_targetCommsTower.hpp"					// 5/5 - Tested	// - Comms Tower
		#include "tasks\op_2_targetDevice.hpp"						// 5/5 - Tested // - Device Sabotage
	//	#include "tasks\op_2_targetDrugFactory.hpp"				// 0/0 - TEST // - Drug Factory
	//	#include "tasks\op_2_targetDrugHouse.hpp"					// 0/0 - TEST // - Drug House
		#include "tasks\op_2_targetHelipad.hpp"					// 0/0 - TEST // - Helipad
		#include "tasks\op_2_targetHVT.hpp"						// 5/5 - Tested	// - HVT
	//	#include "tasks\op_2_targetIEDFactory.hpp"					// 0/0 - TEST // - IED Factory
	//	#include "tasks\op_2_targetIEDMaker.hpp"					// 0/0 - TEST // - IED Maker
	//	#include "tasks\op_2_targetMinefield.hpp"					// 0/0 - TEST // - Minefield Being deployed so intervene
		#include "tasks\op_2_targetSupplyAmmo.hpp"					// 0/0 - TEST // - Supply Point
		#include "tasks\op_2_targetSupplyFuel.hpp"					// 0/0 - TEST // - Fuel Supply
		#include "tasks\op_2_targetVehicle.hpp"					// 5/5 - Tested	// - Vehicle
		#include "tasks\op_2_targetWeaponsCache.hpp"				// 5/5 - Tested // - Weapons Cache

	// 3 - Secure/Defend Area
		#include "tasks\op_3_secureAirport.hpp"					// 5/5 - Tested - TODO: Add Helicopters // - Airport
		#include "tasks\op_3_secureFactory.hpp"					// 3/5 - Tested - TODO: Update Description, Failed Vehicle Spawn, Refine Spawn Locations // - Factories
		#include "tasks\op_3_secureHomestead.hpp"					// 5/5 - Tested - TODO: Update Description // - Houses
		#include "tasks\op_3_secureRuin.hpp"						// 2/5 - Tested - TODO: Update Description, Failed Vehicle Spawn, Remove Vehicles, Refine Spawn Locations // - Ruins
		#include "tasks\op_3_secureTown.hpp"						// 5/5 - Tested - TODO: Update Description // - Town
		#include "tasks\op_3_secureVillage.hpp"					// 5/5 - Tested - TODO: Update Description // - Village

	// 4 - Retrieve Intel > Ambush
		#include "tasks\op_4_retrieveIntelBase.hpp"				// 0/0 - TODO Add Ambush // - Base
		#include "tasks\op_4_retrieveIntelCamp.hpp"				// 5/5 - Tested - TODO: Make Harder // - Encampment
		#include "tasks\op_4_retrieveIntelDrone.hpp"				// 5/5 - Tested - TODO: Make Harder, Make Detonation Handler with Explosion // - Crashed Drone
		#include "tasks\op_4_retrieveIntelHVT.hpp"					// 5/5 - Tested - TODO: Make Harder // - HVT Intel

	// 5 - Deliver Object > Ambush
		#include "tasks\op_5_deliverSupplies.hpp"					// 0/0 - TEST // - Supply Container

	// 6 - Deploy Object
		#include "tasks\op_6_deployCommsTower.hpp"					// 1/5 - Tested - TODO: Needs Logistics, Enemy, Description // - Comms Tower
		#include "tasks\op_6_deployMedicPost.hpp"					// 0/0 - TEST // - Medic Centre

	// 7 - Rescue/Retrieve
		#include "tasks\op_7_recoverHVT.hpp"						// 0/0 - TEST - TODO: Create Civ Hostages as Friendly + ADDACTION to Join Group // - Retrieve HVT
		#include "tasks\op_7_recoverPOWs.hpp"						// 0/0 - TEST - TODO: Create Civ Hostages as Friendly + ADDACTION to Join Group // - Retrieve POW
		#include "tasks\op_7_recoverVehicle.hpp"					// 0/0 - Tested - TODO: Needs more varients broken into seporate tasks // - Retrieve Vehicle

	// 8 - Jets
		#include "tasks\op_8_jets_airSuperiority.hpp"				// 0/0 - TEST - TODO: Create new air combat coverage function for "Jets = 1;" // - Eliminate Large Air Force

	/* Multi Stage Missions */
	//	#include "tasks\op_101_locateDealer.hpp"						// IED Blast Site >> IED Factory >> IED Maker
};

class CfgRespawnMP {
	enabled = 1;
	MHQLimit = 3;
	MHQvehicles[] = {
		"B_Truck_01_box_F","B_MRAP_01_F"
		,"O_Truck_03_repair_F","O_MRAP_02_F"
		,"I_Truck_02_box_F","I_MRAP_03_F"
	};
	class west {
		respawn[] = {"Base","Group","Rallypoint","Countdown"}; // ,"Wave","Spectator","Trigger"
		respawnTimer = 120;
		redeploy[] = {"Base","Group","Halo","Rallypoint"};
		redeployVehicles[] = {"Base","Halo"};
		redeployDelay = 10;
	};
	class east: west {};
	class resistance: west {};
};

class CfgReviveMP {
	enabled = 1;
	enableSkipBleedout = 1;
	RequireItems[] = {"FirstAidKit","MedKit"};
	RequireItemsFullHeal[] = {"MedKit"};
	RemoveItems[] = {"FirstAidKit"};
	RequireMedicTrait = 0;
	ReviveTimer = 6;
	ReviveTimerMedicSpeed = 1.5;
	ReviveBleedout = 300;
	ReviveDamageMultiplier = 0.8;
};

class CfgVirtualArmoury {
	assignRoles = 2;
	enableFullArmoury = 1;
	enableVehicleAccess[] = {"All"};
	class Roles { // Redundant with CfgRoles in description.ext
		#include "mpsf\configuration\cfgRoles.hpp"
	};
};

class CfgVirtualDepot {
	supplyRadius = 10;
	/*
		Limiting the types of ordinance to the configured hardpoints
		Values: 0:False, 1:True
	*/
	compatiblePylonMags = 0;

	/*
		Enable Direct Pylon Interaction
		Disables in-editor editing before deploying the vehicle
		Values: 0:False, 1:True
	*/
	externalPylonInteraction = 0;

	/*
		Time taken in seconds to load an ordinance onto the pylon
		Requires Pylon Interaction
	*/
	loadOrdinanceDuration = 10;

	/*
		The repair damage per second for each damage point of the vehicle.
	*/
	repairSpeed = 0.1;
	refuelSpeed = 0.1;
	rearmSpeed = 0.1;

	// Force this classname to appear as a distinct vehicle, useful for splitting up models and classnames
	forceInDepot[] = {
		"MELB_AH6M_L","MELB_AH6M_M","MELB_MH6M" // MELB Mod
		// RHS Mod
		,"RHS_AH1Z_CS"	,"RHS_AH1Z_GS"
		,"RHS_MELB_AH6M_H","RHS_MELB_AH6M_L","RHS_MELB_AH6M_M","RHS_MELB_H6M","RHS_MELB_MH6M"
		,"RHS_AH64D_noradar","RHS_AH64D_AA","RHS_AH64D_noradar_AA","RHS_AH64D_CS","RHS_AH64D_noradar_CS","RHS_AH64D_GS","RHS_AH64D_noradar_GS"
		,"RHS_UH60M_MEV2","RHS_UH1Y_FFAR"
		,"RHS_UH1Y_GS","RHS_UH1Y_UNARMED"
		,"RHSgref_b_mi24g_FAB","RHSgref_b_mi24g_UPK23"
		,"rhsgref_cdf_b_Mi35_AT","rhsgref_cdf_b_Mi35_UPK","rhsgref_cdf_b_Mi35"
		,"rhsgref_cdf_b_reg_Mi17Sh_FAB","rhsgref_cdf_b_reg_Mi17Sh_UPK"
		// BIS
		,"B_T_VTOL_01_vehicle_F","B_Plane_Fighter_01_Stealth_F","O_Plane_Fighter_02_Stealth_F"
		,"B_G_Van_02_transport_F","B_G_Van_02_vehicle_F"
		,"O_G_Van_02_transport_F","O_G_Van_02_vehicle_F"
		,"I_G_Van_02_transport_F","I_G_Van_02_vehicle_F"
		,"C_IDAP_UAV_06_antimine_F"
	};

	class VehicleLimit {
		Plane = 2;
		Air = 1;
	};

	// Used in "mpsf\functions\spawner\fn_createCarrier01.sqf" for spawning the carrier to support Vehicle Depots
	class CarrierDepots {
		class Elevator1 { // Starboard Bow - Clear, Open, West facing
			position[] = {-33.1792,-8.6475,25.8617};
			direction = 87;
			classNames[] = {"Plane","Helicopter"};
		};
		class Elevator2 { // Starboard Mid Section - West facing, small area near tower overhang
			position[] = {-33.1792,71.6475,25.8617};
			direction = 87;
			classNames[] = {"Plane_Fighter_01_Base_F","Plane_Fighter_02_Base_F","Plane_Fighter_03_base_F","Plane_Fighter_04_Base_F","Plane_CAS_01_base_F","Plane_CAS_02_base_F"};
		};
		class Elevator3 { // Port Stern - Clear, Open, north facing, direct to Catapult 4
			position[] = {35.4792,119.9475,25.8617};
			direction = 180;
			classNames[] = {"Plane","Helicopter"};
		};
		class SternLandingPad { // Starboard Stern - Clear, Open, North facing toward tower
			position[] = {-34.6792,159.6475,25.8617};
			direction = 180;
			classNames[] = {"LandVehicle","Helicopter"};
		};
	};

	// Perfecting the Hardpoint locations of the aircraft. Not all Aircraft require this IF they are set-up properly.
	// If not declared, a default position will be used until specified.
	class HardPoints {
		//copyToClipboard str [[(configFile >> "CfgVehicles" >> typeOf cursorObject)] call BIS_fnc_returnParents,selectionNames cursorObject];
		class B_Plane_Fighter_01_Stealth_F {
			positions[] = {
				{},{},{},{}
				,{1.8612,0,-0.997347}
				,{-1.8612,0,-0.997347}
				,{1,-1,-1.6}
				,{-1,-1,-1.6}
				,{1,-2,-1.6}
				,{-1,-2,-1.6}
				,{1,-3,-1.6}
				,{-1,-3,-1.6}
			};
		};
		class Plane_Fighter_01_Base_F {
			positions[] = {
				"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.001"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.002"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.003"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.004"
				,{1.8612,0,-0.997347}
				,{-1.8612,0,-0.997347}
				,{1,-1,-1.6}
				,{-1,-1,-1.6}
				,{1,-2,-1.6}
				,{-1,-2,-1.6}
				,{1,-3,-1.6}
				,{-1,-3,-1.6}
			};
		};
		class O_Plane_Fighter_02_Stealth_F {
			positions[] = {
				"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.007"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.008"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.009"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.010"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.011"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.012"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.013"
			};
		};
		class Plane_Fighter_02_Base_F {
			positions[] = {
				"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.001"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.002"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.003"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.004"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.005"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.006"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.007"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.008"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.009"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.010"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.011"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.012"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.013"
			};
		};
		class Plane_Fighter_03_base_F {
			positions[] = {
				"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.001"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.002"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.003"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.004"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.005"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.006"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.007"
			};
		};
		class Plane_Fighter_04_Base_F {
			positions[] = {
				"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.001"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.002"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.003"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.004"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.005"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.006"
				//,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.007"
				//,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.008"
			};
		};
		class Plane_CAS_01_base_F {
			positions[] = {
				"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.001"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.002"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.003"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.004"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.005"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.006"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.007"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.008"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.009"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.010"
			};
		};
		class Plane_CAS_02_base_F {
			positions[] = {
				"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.001"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.002"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.003"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.004"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.005"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.006"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.007"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.008"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.009"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.010"
			};
		};
		class VTOL_02_infantry_base_F {
			positions[] = {
				"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.001"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.002"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.003"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.004"
			};
		};
		class VTOL_02_vehicle_base_F: VTOL_02_infantry_base_F {};
		class Heli_Attack_01_base_F {
			positions[] = {
				"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.001"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.002"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.003"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.004"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.005"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.006"
			};
		};
		class Heli_Attack_02_base_F {
			positions[] = {
				"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.001"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.002"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.003"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.004"
			};
		};
		class Heli_Light_01_armed_base_F {
			positions[] = {
				"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.001"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.002"
			};
		};
		class Heli_Light_02_base_F: Heli_Light_01_armed_base_F {};
		class Heli_light_03_base_F: Heli_Light_01_armed_base_F {};
		class UAV_02_base_F: Heli_Light_01_armed_base_F {};
		class UAV_03_base_F {
			positions[] = {
				"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.001"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.002"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.003"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.004"
			};
		};
		class UAV_05_Base_F {
			positions[] = {
				"proxy:\a3\weapons_f_jets\ammo\pylonpod_bomb_gbu12_04_x1_f.001"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_bomb_gbu12_04_x1_f.002"
			};
		};
	};
};