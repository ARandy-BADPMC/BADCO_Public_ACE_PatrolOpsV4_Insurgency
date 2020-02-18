mpsf_ui_key = "User1";
mpsf_bodybags = 1;
mpsf_bodysearch = 1;

class CfgMissionFramework {
	enableLog = 1;
	// Mission Admin - Credit to Mackenzieexd from TaskForce72 for UID filter Idea
	AdminUIDs[] = {
		"_SP_PLAYER_"	/* SP and Editor Debug */
		,"_MP_CANKICK_"	/* ServerCommandAvailable #kick */
		,"00000000000"	/* example Player UID "getPlayerUID" */
	};
	// Task Objects
	intelDropTypes[] = {"Land_File1_F","Land_File2_F","Land_FilePhotos_F","Land_Map_F","Land_Notepad_F","Land_HandyCam_F","Land_MobilePhone_old_F","Land_MobilePhone_smart_F","Land_PortableLongRangeRadio_F","Land_Suitcase_F","Land_File_research_F","Land_Tablet_01_F","Land_Tablet_02_F"};
	intelDownloadTypes[] = {"Land_DataTerminal_01_F","Land_Device_assembled_F","Land_Device_disassembled_F","Land_Laptop_F","Land_Laptop_unfolded_F","Land_Laptop_device_F","Land_SatellitePhone_F","UAV"};
	WeaponCacheTypes[] = {"Box_FIA_Ammo_F","Box_FIA_Support_F","Box_FIA_Wps_F"};
	TowerTypes[] = {};
	SupplyTypes[] = {};
	// Object Cache Default
	cacheRadius = 2000;
	// View Distance Parameters
	viewDistance[] = {500,10000};
	viewDistanceLand[] = {500,10000};
	viewDistanceSea[] = {500,10000};
	viewDistanceAir[] = {500,15000};
	class Factions {
		#include "configuration\cfgFactions.hpp"
	};
	class EnvironmentWeather {
		#include "configuration\cfgWeather.hpp"
	};
	class Logistics {
		enableTow = 1;
		enableLift = 1;
		enableLoad = 1;
		class Tank {
			towTypes[] = {"AllVehicles"};
			liftTypes[] = {};
			loadTypes[] = {};
		};
		class Car {
			towTypes[] = {"Car","Air","Ship"};
			liftTypes[] = {};
			loadTypes[] = {};
		};
	};
	class MapData {
		#include "maps\altis.hpp"
		#include "maps\chernarus.hpp"
		#include "maps\dya.hpp"
		#include "maps\malden.hpp"
		#include "maps\tanoa.hpp"
		#include "maps\takistan.hpp"
	};
	class OperationNames {
		#include "configuration\cfgOpNames.hpp"
	};
	class ObjectCompositions {
		class comms_tower_georgetown {
			#include "compositions\comms_tower_georgetown.sqe"
		};
		class B_UAV_05_CrashSite_F {
			#include "compositions\b_uav_05_crashsite_f.sqe"
		};
		class en_camp_1 {
			#include "compositions\en_camp_1.sqe"
		};
		class en_camp_2 {
			#include "compositions\en_camp_2.sqe"
		};
		class en_camp_3_intel {
			#include "compositions\en_camp_3_intel.sqe"
		};
		class en_camp_4_intel {
			#include "compositions\en_camp_4_intel.sqe"
		};
		class en_container_comms_intel {
			#include "compositions\en_container_comms_intel.sqe"
		};
		class en_device_01_f {
			#include "compositions\en_device_01_f.sqe"
		};
		class crashsite_uav_01 {
			#include "compositions\crashsite_uav_01.sqe"
		};
		class crashsite_uav_02 {
			#include "compositions\crashsite_uav_02.sqe"
		};
		class en_supply_fuel_1 {
			#include "compositions\en_supply_fuel_1.sqe"
		};
		class en_supply_fuel_2 {
			#include "compositions\en_supply_fuel_2.sqe"
		};
		class en_supply_ammo_1 {
			#include "compositions\en_supply_ammo_1.sqe"
		};
		class en_supply_ammo_2 {
			#include "compositions\en_supply_ammo_2.sqe"
		};
		class en_helipad_1 {
			#include "compositions\en_helipad_1.sqe"
		};
	};
};
// NPC Conversations
class CfgNPCConversari {
	#include "configuration\cfgConversari.hpp"
};
// UI Elements
#include "ui\rscCommon.hpp"
// UI Menu
#include "ui\rscDisplayInterfaceMenu.hpp"
// UI NPC Conversations
#include "ui\rscDisplayConversation.hpp"
// UI Intro Camera
#include "ui\rscDisplayCamera.hpp"
// RespawnMP
#include "ui\rscDisplayRespawnMP.hpp"
// Virtual Armoury
#include "ui\rscDisplayUnitRoleSelect.hpp"
// Virtual Depot
#include "ui\rscDisplayVirtualDepot.hpp"
// MissionUI
#include "ui\rscDisplayMissionUI.hpp"