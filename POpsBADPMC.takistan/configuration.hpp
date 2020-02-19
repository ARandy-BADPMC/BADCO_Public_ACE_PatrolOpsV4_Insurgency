PatrolOpsVersion = "4.0.610 RC";
HorzionConflictVersion = "0.23 ATC Beta";
missionDebugMode = 0;

class CfgMission {
	// Faction IDs found in cfgSides.hpp
	FactionTypeBLU	= "Blufor_Altis";
	FactionTypeOPF	= "Opfor_Altis";
	FactionTypeCIV 	= "Civilian_Altis";

	class Bases {
		class Rasman_Airfield {
			displayName = "Rasman Airfield";
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
	MHQLimit = 1;
	MHQvehicles[] = {
		"O_T_APC_Tracked_02_cannon_ghex_F"
	};
	class west {
		respawn[] = {"Base","Group","Rallypoint","Countdown"}; // ,"Wave","Spectator","Trigger"
		respawnTimer = 30;
		redeploy[] = {"Base","Group","Rallypoint"};
		redeployVehicles[] = {"Base"};
		redeployDelay = 10;
	};
	class east: west {};
	class resistance: west {};
};

class CfgReviveMP {
	enabled = 0;
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
	assignRoles = 0;
	enableFullArmoury = 0;
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
	"RHS_AH1Z",
	"RHS_AH64D",
	"RHS_MELB_AH6M",
	"I_Heli_Transport_02_F",
	"I_Heli_light_03_dynamicLoadout_F",
	"I_Heli_light_03_unarmed_F",
	"RHS_CH_47F_10",
	"B_Heli_Transport_03_F",
	"B_Heli_Transport_03_unarmed_F",
	"rhsusf_CH53E_USMC_D",
	"O_Heli_Light_02_dynamicLoadout_F",
	"O_Heli_Light_02_unarmed_F",
	"C_Heli_Light_01_civil_F",
	"B_Heli_Light_01_F",
	"RHS_MELB_MH6M",
	"RHS_Mi8AMTSh_vvs", 
	"RHS_Mi24P_vdv",
	"O_Heli_Transport_04_F", 
	"RHS_MELB_H6M",
	"B_Heli_Attack_01_dynamicLoadout_F",
	"RHS_UH1Y_d",
	"RHS_UH1Y_UNARMED_d",
	"RHS_UH60M_d",
	"RHS_UH60M_ESSS_d",
	"RHS_UH60M2_d",
	"RHS_UH60M_MEV_d",
	"B_Heli_Transport_01_F",
	
	"RHS_A10",
	"B_Plane_CAS_01_dynamicLoadout_F",
	"RHS_AN2_B",
	"RHS_C130J",
	"C_Plane_Civil_01_F",
	"C_Plane_Civil_01_racing_F",
	"B_Plane_Fighter_01_F",
	"I_Plane_Fighter_04_F",
	"rhssaf_airforce_l_18",
	"RHS_L39_cdf_b_cdf",
	"RHS_l159_cdf_b_CDF",
	"RHSGREF_cdf_b_su25",
	"B_UAV_02_dynamicLoadout_f",
	
	"B_APC_Wheeled_01_cannon_F",
	"B_APC_Tracked_01_AA_F",
	"O_T_APC_Tracked_02_cannon_ghex_F",
	"rhs_bmp2d_msv",
	"rhsusf_CGRCAT1A2_usmc_d",
	"rhsusf_CGRCAT1A2_Mk19_usmc_d",
	"rhsusf_CGRCAT1A2_M2_usmc_d",
	"I_MRAP_03_hmg_F",
	"I_MRAP_03_gmg_F",
	"rhs_tigr_vdv",
	"rhs_tigr_sts_vdv",
	"rhs_tigr_m_vdv",
	"O_MRAP_02_F",
	"O_MRAP_02_gmg_F",
	"O_MRAP_02_hmg_F",
	"I_MBT_03_cannon_F",
	"B_MRAP_01_F",
	"B_MRAP_01_gmg_F",
	"B_MRAP_01_hmg_F",
	"rhsusf_m1045_d",
	"rhsusf_M1078A1R_SOV_M2_D_fmtv_socom",
	"rhsusf_M1084A1R_SOV_M2_D_fmtv_socom",
	"rhsusf_m109d_usarmy",
	"rhsusf_m113d_usarmy_supply",
	"rhsusf_m113d_usarmy",
	"rhsusf_m113d_usarmy_M240",
	"rhsusf_m113d_usarmy_medical",
	"rhsusf_m113d_usarmy_MK19",
	"rhsusf_m113d_usarmy_unarmed",
	"rhsusf_stryker_m1126_m2_wd",
	"rhsusf_M1117_D",
	"rhsusf_M1220_usarmy_d",
	"rhsusf_M1220_M153_M2_usarmy_d",
	"rhsusf_M1220_M2_usarmy_d",
	"rhsusf_M1220_MK19_usarmy_d",
	"rhsusf_M1220_M153_MK19_usarmy_d",
	"rhsusf_M1230_M2_usarmy_d",
	"rhsusf_M1230_MK19_usarmy_d",
	"rhsusf_M1232_usarmy_d",
	"rhsusf_M1232_M2_usarmy_d",
	"rhsusf_M1232_MK19_usarmy_d",
	"rhsusf_M1237_M2_usarmy_d",
	"rhsusf_M1237_MK19_usarmy_d",
	"rhsusf_M1238A1_socom_d",
	"rhsusf_M1238A1_M2_socom_d",
	"rhsusf_M1238A1_Mk19_socom_d",
	"rhsusf_M1239_socom_d",
	"rhsusf_M1239_M2_socom_d",
	"rhsusf_M1239_M2_Deploy_socom_d",
	"rhsusf_M1239_MK19_socom_d",
	"rhsusf_M1239_MK19_Deploy_socom_d",
	"rhsusf_M142_usarmy_D",
	"rhsusf_m1a1aimd_usarmy",
	"rhsusf_m1a1aim_tuski_d",
	"rhsusf_m1a2sep1d_usarmy",
	"rhsusf_m1a2sep1tuskid_usarmy",
	"rhsusf_m1a2sep1tuskiid_usarmy",
	"RHS_M2A2",
	"RHS_M2A2_BUSKI",
	"RHS_M2A3",
	"RHS_M2A3_BUSKI",
	"RHS_M2A3_BUSKIII",
	"RHS_M6",
	"I_C_Offroad_02_LMG_F",
	"I_C_Offroad_02_AT_F",
	"B_MBT_01_TUSK_F",
	"B_MBT_01_cannon_F",
	"B_APC_Tracked_01_rcws_F",
	"B_APC_Tracked_01_CRV_F",
	"B_G_Offroad_01_AT_F",
	"O_APC_Wheeled_02_rcws_F",
	"I_APC_Wheeled_03_cannon_F",
	"rhsusf_rg33_usmc_d",
	"rhsusf_rg33_m2_usmc_d",
	"B_AFV_Wheeled_01_up_cannon_F",
	"B_AFV_Wheeled_01_cannon_F",
	"B_MBT_01_arty_F",
	"rhs_t72bb_tv",
	"I_LT_01_AT_F",
	"I_LT_01_AA_F",
	"I_LT_01_cannon_F",
	"I_LT_01_scout_F"
	};

	class VehicleLimit {
		Plane = 1;
		Air = 2;
	};

	// Used in "mpsf\functions\spawner\fn_createCarrier01.sqf" for spawning the carrier to support Vehicle Depots
	/*class CarrierDepots {
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
	};*/

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
