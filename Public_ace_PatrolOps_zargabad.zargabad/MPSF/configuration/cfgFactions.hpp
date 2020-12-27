/*
	Map: Altis
	Factions: Custom Made for PO4
*/
class Blufor_Altis {
	displayName = "NATO";
	displayLongName = "North Atlantic Treaty Organization";
	displayColour = "ColorBlufor";
	side = 1;
	class Groups {
		class TargetHVT {
			classNames[] = {"rhsusf_usmc_marpat_d_officer","rhsusf_usmc_marpat_d_spotter"};
		};
		class TargetHVT_INS {
			classNames[] = {"LOP_PESH_IND_Infantry_SL","LOP_PESH_IND_Infantry_Marksman"};
		};
		class Squad8 {
			classNames[] = {"rhsusf_usmc_marpat_d_teamleader","rhsusf_usmc_marpat_d_engineer","rhsusf_usmc_marpat_d_rifleman_m4","rhsusf_usmc_marpat_d_rifleman_m4","rhsusf_usmc_marpat_d_autorifleman_m249","rhsusf_usmc_marpat_d_autorifleman_m249_ass","rhsusf_usmc_marpat_d_riflemanat","rhsusf_usmc_marpat_d_grenadier"};
		};
		class Squad8_AA {
			classNames[] = {"rhsusf_usmc_marpat_d_teamleader","rhsusf_usmc_marpat_d_engineer","rhsusf_usmc_marpat_d_rifleman_m4","rhsusf_usmc_marpat_d_rifleman_m4","rhsusf_usmc_marpat_d_autorifleman_m249","rhsusf_usmc_marpat_d_autorifleman_m249_ass","rhsusf_usmc_marpat_d_riflemanat","rhsusf_usmc_marpat_d_stinger"};
		};
		class Squad8_AR {
			classNames[] = {"rhsusf_usmc_marpat_d_teamleader","rhsusf_usmc_marpat_d_engineer","rhsusf_usmc_marpat_d_rifleman_m4","rhsusf_usmc_marpat_d_rifleman_m4","rhsusf_usmc_marpat_d_autorifleman_m249","rhsusf_usmc_marpat_d_autorifleman_m249_ass","rhsusf_usmc_marpat_d_autorifleman_m249","rhsusf_usmc_marpat_d_autorifleman_m249_ass"};
		};
		class Squad8_AT {
			classNames[] = {"rhsusf_usmc_marpat_d_teamleader","rhsusf_usmc_marpat_d_engineer","rhsusf_usmc_marpat_d_rifleman_m4","rhsusf_usmc_marpat_d_rifleman_m4","rhsusf_usmc_marpat_d_autorifleman_m249","rhsusf_usmc_marpat_d_autorifleman_m249_ass","rhsusf_usmc_marpat_d_riflemanat","rhsusf_usmc_marpat_d_javelin"};
		};
		class Squad8_M {
			classNames[] = {"rhsusf_usmc_marpat_d_teamleader","rhsusf_usmc_marpat_d_engineer","rhsusf_usmc_marpat_d_rifleman_m4","rhsusf_usmc_marpat_d_rifleman_m4","rhsusf_usmc_marpat_d_autorifleman_m249","rhsusf_usmc_marpat_d_autorifleman_m249_ass","rhsusf_usmc_marpat_d_riflemanat","rhsusf_usmc_marpat_d_grenadier"};
		};
		class Squad8_INS {
			classNames[] = {"LOP_PESH_IND_Infantry_SL","LOP_PESH_IND_Infantry_Corpsman","LOP_PESH_IND_Infantry_Engineer","LOP_PESH_IND_Infantry_GL","LOP_PESH_IND_Infantry_AT","LOP_PESH_IND_Infantry_MG","LOP_PESH_IND_Infantry_Marksman","LOP_PESH_IND_Infantry_Rifleman_2"};
		};
		class Squad4 {
			classNames[] = {"rhsusf_usmc_marpat_d_teamleader","rhsusf_usmc_marpat_d_engineer","rhsusf_usmc_marpat_d_rifleman_m4","rhsusf_usmc_marpat_d_rifleman_m4"};
		};
		class Squad4_AA {
			classNames[] = {"rhsusf_usmc_marpat_d_autorifleman_m249","rhsusf_usmc_marpat_d_autorifleman_m249_ass","rhsusf_usmc_marpat_d_riflemanat","rhsusf_usmc_marpat_d_stinger"};
		};
		class Squad4_AR {
			classNames[] = {"rhsusf_usmc_marpat_d_rifleman_m4","rhsusf_usmc_marpat_d_rifleman_m4","rhsusf_usmc_marpat_d_autorifleman_m249","rhsusf_usmc_marpat_d_autorifleman_m249_ass"};
		};
		class Squad4_AT {
			classNames[] = {"rhsusf_usmc_marpat_d_autorifleman_m249","rhsusf_usmc_marpat_d_autorifleman_m249_ass","rhsusf_usmc_marpat_d_riflemanat","rhsusf_usmc_marpat_d_javelin"};
		};
		class Squad4_M {
			classNames[] = {"rhsusf_usmc_marpat_d_teamleader","rhsusf_usmc_marpat_d_engineer","rhsusf_usmc_marpat_d_rifleman_m4","rhsusf_usmc_marpat_d_rifleman_m4"};
		};
		class Squad4_INS {
			classNames[] = {"LOP_PESH_IND_Infantry_SL","LOP_PESH_IND_Infantry_Corpsman","LOP_PESH_IND_Infantry_Engineer","LOP_PESH_IND_Infantry_GL"};
		};
		class Sniper {
			classNames[] = {"rhsusf_usmc_marpat_d_sniper","rhsusf_usmc_marpat_d_spotter"};
		};
		class Sniper_INS {
			classNames[] = {"LOP_PESH_IND_Infantry_Sniper","LOP_PESH_IND_Infantry_Corpsman"};
		};
		class ParaMilitary {
			classNames[] = {"LOP_PMC_Infantry_SL","LOP_PMC_Infantry_Rifleman_2","LOP_PMC_Infantry_EOD","LOP_PMC_Infantry_GL","LOP_PMC_Infantry_MG_Asst","LOP_PMC_Infantry_Corpsman","LOP_PMC_Infantry_Marksman_2","LOP_PMC_Infantry_Engineer"};
		};
		class SpecOps {
			classNames[] = {"rhsusf_usmc_recon_marpat_d_teamleader_fast","rhsusf_usmc_recon_marpat_d_marksman_fast","rhsusf_usmc_recon_marpat_d_rifleman_at_fast","rhsusf_usmc_recon_marpat_d_autorifleman_fast","rhsusf_usmc_recon_marpat_d_rifleman_fast"};
		};
		class SpecOps_Elite {
			classNames[] = {"rhsusf_socom_marsoc_teamchief","rhsusf_socom_marsoc_sarc","rhsusf_socom_marsoc_cso_mk17","rhsusf_socom_marsoc_cso_breacher","rhsusf_socom_marsoc_sniper"};
		};
	};
	class Vehicles {
		class VehicleHVT {
			classNames[] = {"rhsusf_M977A4_AMMO_BKIT_usarmy_d","rhsusf_m1240a1_m240_usmc_d"};
		};
		class VehicleHVT_INS {
			classNames[] = {"LOP_PESH_IND_M1025_D"};
		};
		class Car {
			classNames[] = {"rhsusf_m998_d_s_4dr"};
		};
		class Car_INS {
			classNames[] = {"LOP_PESH_IND_M1025_W_M2"};
		};
		class CarTurret {
			classNames[] = {"rhsusf_m1025_d_s_m2","rhsusf_m1045_d_s","rhsusf_m1240a1_m2crows_usmc_d","rhsusf_m1240a1_m2_usmc_d","rhsusf_m1240a1_m240_usmc_d","rhsusf_m1240a1_mk19_usmc_d"};
		};
		class CarTurret_INS {
			classNames[] = {"LOP_PESH_IND_M1025_W_M2"};
		};
		class Truck {
			classNames[] = {"rhsusf_M1083A1P2_D_fmtv_usarmy","rhsusf_M1078A1P2_B_D_fmtv_usarmy","rhsusf_CGRCAT1A2_usmc_d"};
		};
		class Truck_INS {
			classNames[] = {"LOP_PESH_IND_HEMTT_Transport_D","LOP_PESH_IND_Truck"};
		};
		class Truck_Support {
			classNames[] = {"rhsusf_M978A4_BKIT_usarmy_d","rhsusf_M977A4_REPAIR_usarmy_d","rhsusf_M977A4_AMMO_usarmy_d"};
		};
		class Armour_AA {
			classNames[] = {"RHS_M6"};
		};
		class Armour_APC {
			classNames[] = {"RHS_M2A3_BUSKI","rhsusf_stryker_m1126_m2_d","rhsusf_m113d_usarmy","rhsusf_m113d_usarmy_M240"};
		};
		class Armour_MBT {
			classNames[] = {"rhsusf_m1a1fep_d"};
		};
		class Armour_Art {
			classNames[] = {"rhsusf_m109d_usarmy","rhsusf_M142_usarmy_D"};
		};
		class CAS_Heli {
			classNames[] = {"RHS_AH1Z","RHS_UH1Y_d"};
		};
		class CAS_Air {
			classNames[] = {"RHS_A10"};
		};
		class CAS_UAV {
			classNames[] = {"B_UAV_02_CAS_F","B_UAV_05_F"};
		};
		class Fighter_Plane {
			classNames[] = {"rhsusf_f22"};
		};
		class Transport_Heli {
			classNames[] = {"rhsusf_CH53E_USMC_GAU21_D","RHS_UH1Y_d","RHS_UH60M_d","RHS_CH_47F_light"};
		};
		class Transport_Air {
			classNames[] = {"RHS_C130J"};
		};
		class UAV {
			classNames[] = {"B_UAV_02_CAS_F","B_UAV_05_F"};
		};
		class UGV {
			classNames[] = {"B_UGV_01_rcws_F"};
		};
		class Boat {
			classNames[] = {"rhsusf_mkvsoc"};
		};
	};
};
class Opfor_Altis {
	displayName = "Militia";
	displayLongName = "Middle Eastern Militia";
	displayColour = "ColorOpfor";
	side = 0;
	class Groups {
		class TargetHVT {
			classNames[] = {"LOP_TKA_Infantry_TL"};
		};
		class TargetHVT_INS {
			classNames[] = {"LOP_AM_Infantry_SL"};
		};
		class Squad8 {
			classNames[] = {"LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_Rifleman_3","LOP_ISTS_Infantry_AT","LOP_ISTS_Infantry_AR","LOP_ISTS_Infantry_Rifleman_5","LOP_ISTS_Infantry_GL","LOP_ISTS_Infantry_AR","LOP_ISTS_Infantry_Marksman"};
		};
		class Squad8_AA {
			classNames[] = {"LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_Rifleman_3","LOP_TKA_Infantry_AA","LOP_ISTS_Infantry_Rifleman_3","LOP_ISTS_Infantry_Rifleman_5","LOP_ISTS_Infantry_GL","LOP_ISTS_Infantry_Corpsman","LOP_ISTS_Infantry_Marksman"};
		};
		class Squad8_AR {
			classNames[] = {"LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_Rifleman_3","LOP_ISTS_Infantry_AT","LOP_ISTS_Infantry_AR","LOP_ISTS_Infantry_Rifleman_5","LOP_ISTS_Infantry_GL","LOP_ISTS_Infantry_Corpsman","LOP_ISTS_Infantry_Marksman"};
		};
		class Squad8_AT {
			classNames[] = {"LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_Rifleman_3","LOP_ISTS_Infantry_AT","LOP_ISTS_Infantry_Rifleman_3","LOP_ISTS_Infantry_Rifleman_5","LOP_ISTS_Infantry_GL","LOP_ISTS_Infantry_Corpsman","LOP_ISTS_Infantry_Marksman"};
		};
		class Squad8_M {
			classNames[] = {"LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_Rifleman_3","LOP_ISTS_Infantry_AT","LOP_ISTS_Infantry_Rifleman_3","LOP_ISTS_Infantry_Rifleman_5","LOP_ISTS_Infantry_GL","LOP_ISTS_Infantry_Corpsman","LOP_ISTS_Infantry_Marksman"};
		};
		class Squad8_INS {
			classNames[] = {"LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_Rifleman_3","LOP_ISTS_Infantry_AT","LOP_ISTS_Infantry_AR","LOP_ISTS_Infantry_Rifleman_5","LOP_ISTS_Infantry_GL","LOP_ISTS_Infantry_Corpsman","LOP_ISTS_Infantry_Marksman"};
		};
		class Squad4 {
			classNames[] = {"LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_Marksman","LOP_ISTS_Infantry_AR","LOP_ISTS_Infantry_Corpsman"};
		};
		class Squad4_AA {
			classNames[] = {"LOP_ISTS_Infantry_SL","LOP_TKA_Infantry_AA","LOP_ISTS_Infantry_Rifleman_3","LOP_ISTS_Infantry_Corpsman"};
		};
		class Squad4_AR {
			classNames[] = {"LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_AR","LOP_ISTS_Infantry_Rifleman_3","LOP_ISTS_Infantry_Corpsman"};
		};
		class Squad4_AT {
			classNames[] = {"LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_AT","LOP_ISTS_Infantry_Rifleman_3","LOP_ISTS_Infantry_Corpsman"};
		};
		class Squad4_M {
			classNames[] = {"LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_Marksman","LOP_ISTS_Infantry_Rifleman_3","LOP_ISTS_Infantry_Corpsman"};
		};
		class Squad4_INS {
			classNames[] = {"LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_Marksman","LOP_ISTS_Infantry_AR","LOP_ISTS_Infantry_Corpsman"};
		};
		class Sniper {
			classNames[] = {"LOP_TKA_Infantry_Marksman","LOP_TKA_Infantry_Rifleman_3"};
		};
		class Sniper_INS {
			classNames[] = {"LOP_AM_Infantry_Rifleman_7","LOP_AM_Infantry_Marksman"};
		};
		class ParaMilitary {
			classNames[] = {"LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_Marksman","LOP_ISTS_Infantry_AR","LOP_ISTS_Infantry_Corpsman"};
		};
		class SpecOps {
			classNames[] = {"LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_Marksman","LOP_ISTS_Infantry_AR","LOP_ISTS_Infantry_Corpsman"};
		};
		class SpecOps_Elite {
			classNames[] = {"LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_Marksman","LOP_ISTS_Infantry_AR","LOP_ISTS_Infantry_Corpsman"};
		};
	};
	class Vehicles {
		class VehicleHVT {
			classNames[] = {"LOP_TKA_UAZ_Open"};
		};
		class Car {
			classNames[] = {"LOP_TKA_UAZ_Open","LOP_TKA_UAZ"};
		};
		class Car_INS {
			classNames[] = {"LOP_ISTS_Landrover"};
		};
		class CarTurret {
			classNames[] = {"LOP_TKA_UAZ_SPG","LOP_TKA_UAZ_AGS","LOP_TKA_UAZ_DshKM"};
		};
		class CarTurret_INS {
			classNames[] = {"rhsgref_ins_g_uaz_dshkm_chdkz"};
		};
		class Truck {
			classNames[] = {"LOP_TKA_Ural","LOP_TKA_Ural_open"};
		};
		class Truck_INS {
			classNames[] = {"LOP_ISTS_Truck"};
		};
		class Truck_Support {
			classNames[] = {"LOP_TKA_Ural","I_G_Van_01_fuel_F","I_G_Van_02_transport_F"};
		};
		class Armour_AA {
			classNames[] = {"LOP_TKA_ZSU234"};
		};
		class Armour_APC {
			classNames[] = {"LOP_TKA_BTR60","LOP_TKA_BTR70"};
		};
		class Armour_MBT {
			classNames[] = {"LOP_TKA_T55"};
		};
		class Armour_Art {
			classNames[] = {"LOP_TKA_BM21"};
		};
		class CAS_Heli {
			classNames[] = {"LOP_TKA_Mi24V_AT","LOP_TKA_Mi24V_FAB"};
		};
		class CAS_Air {
			classNames[] = {"RHS_Su25SM_vvs"};
		};
		class CAS_UAV {
			classNames[] = {"O_UAV_02_CAS_F","O_T_UAV_04_CAS_F"};
		};
		class Fighter_Plane {
			classNames[] = {"rhs_mig29s_vvs"};
		};
		class Transport_Heli {
			classNames[] = {"LOP_TKA_Mi8MT_Cargo"};
		};
		class Transport_Air {
			classNames[] = {"O_T_VTOL_02_infantry_grey_F","O_T_VTOL_02_infantry_hex_F"};
		};
		class UAV {
			classNames[] = {"O_UAV_02_CAS_F","O_T_UAV_04_CAS_F"};
		};
		class UGV {
			classNames[] = {"O_UGV_01_rcws_F"};
		};
		class Boat {
			classNames[] = {"O_Boat_Armed_01_hmg_F"};
		};
	};
};
class Civilian_Altis {
	displayName = "Civilian";
	displayLongName = "Civilian";
	displayColour = "ColorCivilian";
	side = 3;
	class Groups {
		class Observer {
			classNames[] = {"C_Orestes"};
		};
		class Informants {
			classNames[] = {"C_Orestes","C_Nikos","C_Nikos_aged"};
		};
		class Crowd4 {
			classNames[] = {"C_man_polo_1_F_euro","C_man_polo_1_F"};
		};
		class Crowd6 {
			classNames[] = {"C_man_polo_2_F","C_man_polo_3_F_euro","C_man_polo_3_F"};
		};
		class Crowd12 {
			classNames[] = {"C_man_polo_5_F_afro","C_man_polo_5_F_asia","C_man_polo_5_F_euro","C_man_polo_5_F","C_man_1_1_F","C_man_1_2_F"};
		};
		class Crowd24 {
			classNames[] = {"C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F","C_Driver_1_random_base_F","C_man_shorts_2_F","C_man_shorts_3_F","C_man_shorts_4_F","C_man_w_worker_F"};
		};
		class Journo {
			classNames[] = {"C_journalist_F"};
		};
	};
	class Vehicles {
		class Helicopter {
			classNames[] = {"C_Heli_Light_01_civil_F"};
		};
		class Boat {
			classNames[] = {"C_Boat_Civil_01_F","C_Boat_Civil_01_rescue_F","C_Boat_Civil_01_police_F"};
		};
		class Car {
			classNames[] = {"C_Offroad_01_F","C_Offroad_01_repair_F","C_Truck_02_covered_F","C_Truck_02_transport_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_SUV_01_F","C_Truck_02_fuel_F","C_Truck_02_box_F","C_Van_01_transport_F","C_Van_01_box_F","C_Van_01_fuel_F"};
		};
	};
};

/*
	Map: TANOA
	Factions: Custom Made for PO4
*/
class Blufor_Tanoa {
	displayName = "NATO Pacific";
	displayLongName = "North Atlantic Treaty Organization";
	displayColour = "ColorBlufor";
	side = 1;
	class Groups {
		class TargetHVT {
			classNames[] = {"B_T_Officer_F","B_T_Recon_JTAC_F"};
		};
		class TargetHVT_INS {
			classNames[] = {{"B_T_Officer_F","I_C_Soldier_Camo_F"},{"B_T_Recon_JTAC_F","I_C_Soldier_Para_4_F"}};
		};
		class Squad8 {
			classNames[] = {"B_T_Soldier_TL_F","B_T_Soldier_GL_F","B_T_Soldier_F","B_T_Soldier_AA_F","B_T_Soldier_AR_F","B_T_Soldier_AT_F","B_T_Soldier_M_F","B_T_medic_F"};
		};
		class Squad8_AA {
			classNames[] = {"B_T_Soldier_TL_F","B_T_Soldier_GL_F","B_T_Soldier_F","B_T_Soldier_A_F","B_T_Soldier_GL_F","B_T_Soldier_AA_F","B_T_Soldier_AA_F","B_T_medic_F"};
		};
		class Squad8_AR {
			classNames[] = {"B_T_Soldier_TL_F","B_T_Soldier_GL_F","B_T_Soldier_F","B_T_Soldier_A_F","B_T_Soldier_GL_F","B_T_Soldier_AR_F","B_T_Soldier_AR_F","B_T_medic_F"};
		};
		class Squad8_AT {
			classNames[] = {"B_T_Soldier_TL_F","B_T_Soldier_GL_F","B_T_Soldier_F","B_T_Soldier_A_F","B_T_Soldier_GL_F","B_T_Soldier_AT_F","B_T_Soldier_LAT_F","B_T_medic_F"};
		};
		class Squad8_M {
			classNames[] = {"B_T_Soldier_TL_F","B_T_Soldier_GL_F","B_T_Soldier_F","B_T_Soldier_A_F","B_T_Soldier_GL_F","B_T_Soldier_M_F","B_T_Soldier_M_F","B_T_medic_F"};
		};
		class Squad8_INS {
			classNames[] = {{"B_T_Soldier_F","I_C_Soldier_Bandit_6_F"},{"B_T_Soldier_F","I_C_Soldier_Bandit_5_F"},{"B_T_Soldier_F","I_C_Soldier_Bandit_3_F"},{"B_T_Soldier_F","I_C_Soldier_Bandit_2_F"},{"B_T_Soldier_F","I_C_Soldier_Bandit_8_F"},{"B_T_Soldier_F","I_C_Soldier_Bandit_7_F"},{"B_T_Soldier_F","I_C_Soldier_Bandit_4_F"},{"B_T_Soldier_F","I_C_Soldier_Bandit_1_F"}};
		};
		class Squad4 {
			classNames[] = {"B_T_Soldier_TL_F","B_T_Soldier_GL_F","B_T_Soldier_F","B_T_medic_F"};
		};
		class Squad4_AA {
			classNames[] = {"B_T_Soldier_TL_F","B_T_Soldier_GL_F","B_T_Soldier_AA_F","B_T_Soldier_AA_F"};
		};
		class Squad4_AR {
			classNames[] = {"B_T_Soldier_TL_F","B_T_Soldier_GL_F","B_T_Soldier_AR_F","B_T_Soldier_AR_F"};
		};
		class Squad4_AT {
			classNames[] = {"B_T_Soldier_TL_F","B_T_Soldier_GL_F","B_T_Soldier_AT_F","B_T_Soldier_LAT_F"};
		};
		class Squad4_M {
			classNames[] = {"B_T_Soldier_TL_F","B_T_Soldier_GL_F","B_T_Soldier_M_F","B_T_Soldier_M_F"};
		};
		class Squad4_INS {
			classNames[] = {{"B_T_Soldier_F","I_C_Soldier_Bandit_6_F"},{"B_T_Soldier_F","I_C_Soldier_Bandit_5_F"},{"B_T_Soldier_F","I_C_Soldier_Bandit_3_F"},{"B_T_Soldier_F","I_C_Soldier_Bandit_2_F"}};
		};
		class Sniper {
			classNames[] = {"B_T_ghillie_tna_F","B_T_ghillie_tna_F"};
		};
		class Sniper_INS {
			classNames[] = {{"B_T_ghillie_tna_F","I_C_Soldier_Para_1_F"},{"B_T_ghillie_tna_F","I_C_Soldier_Para_2_F"}};
		};
		class ParaMilitary {
			classNames[] = {{"B_T_Soldier_F","I_C_Soldier_Para_6_F"},{"B_T_Soldier_F","I_C_Soldier_Para_2_F"},{"B_T_Soldier_F","I_C_Soldier_Para_4_F"},{"B_T_Soldier_F","I_C_Soldier_Para_5_F"},{"B_T_Soldier_F","I_C_Soldier_Para_8_F"}};
		};
		class SpecOps {
			classNames[] = {"B_T_Recon_TL_F","B_T_Recon_F","B_T_Recon_M_F","B_T_Recon_LAT_F","B_T_Recon_JTAC_F"};
		};
		class SpecOps_Elite {
			classNames[] = {"B_CTRG_Soldier_TL_tna_F","B_CTRG_Soldier_AR_tna_F","B_CTRG_Soldier_M_tna_F","B_CTRG_Soldier_LAT_tna_F","B_CTRG_Soldier_Exp_tna_F","B_CTRG_Soldier_Medic_tna_F"};
		};
	};
	class Vehicles {
		class VehicleHVT {
			classNames[] = {"B_T_Truck_01_ammo_F","B_T_APC_Tracked_01_CRV_F"};
		};
		class VehicleHVT_INS {
			classNames[] = {"B_G_Offroad_01_repair_F"};
		};
		class Car {
			classNames[] = {"B_T_MRAP_01_F","B_T_LSV_01_unarmed_CTRG_F","B_T_LSV_01_unarmed_black_F","B_T_LSV_01_unarmed_olive_F"};
		};
		class Car_INS {
			classNames[] = {"B_G_Offroad_01_F"};
		};
		class CarTurret {
			classNames[] = {"B_T_MRAP_01_gmg_F","B_T_MRAP_01_hmg_F","B_T_LSV_01_armed_black_F","B_T_LSV_01_armed_olive_F"};
		};
		class CarTurret_INS {
			classNames[] = {"B_G_Offroad_01_armed_F"};
		};
		class Truck {
			classNames[] = {"B_T_Truck_01_transport_F","B_T_Truck_01_covered_F"};
		};
		class Truck_INS {
			classNames[] = {"B_G_Van_01_transport_F"};
		};
		class Truck_Support {
			classNames[] = {"B_T_Truck_01_ammo_F","B_T_Truck_01_fuel_F","B_T_Truck_01_Repair_F"};
		};
		class Armour_AA {
			classNames[] = {"B_T_APC_Tracked_01_AA_F"};
		};
		class Armour_APC {
			classNames[] = {"B_T_APC_Wheeled_01_cannon_F","B_T_APC_Tracked_01_rcws_F"};
		};
		class Armour_MBT {
			classNames[] = {"B_T_MBT_01_cannon_F","B_T_MBT_01_TUSK_F"};
		};
		class Armour_Art {
			classNames[] = {"B_T_MBT_01_arty_F","B_T_MBT_01_mlrs_F"};
		};
		class CAS_Heli {
			classNames[] = {"B_Heli_Light_01_dynamicLoadout_F","B_Heli_Attack_01_F"};
		};
		class CAS_Air {
			classNames[] = {"B_Plane_CAS_01_F"};
		};
		class CAS_UAV {
			classNames[] = {"B_UAV_02_CAS_F","B_UAV_05_F"};
		};
		class Fighter_Plane {
			classNames[] = {"B_Plane_Fighter_01_F","B_Plane_Fighter_01_Stealth_F"};
		};
		class Transport_Heli {
			classNames[] = {"B_CTRG_Heli_Transport_01_tropic_F","B_Heli_Transport_01_F","B_Heli_Transport_03_F"};
		};
		class Transport_Air {
			classNames[] = {"B_T_VTOL_01_infantry_F"};
		};
		class UAV {
			classNames[] = {"B_UAV_02_CAS_F","B_UAV_05_F"};
		};
		class UGV {
			classNames[] = {"B_UGV_01_rcws_F"};
		};
		class Boat {
			classNames[] = {"B_T_Boat_Armed_01_minigun_F"};
		};
	};
};
class Opfor_Tanoa {
	displayName = "Syndikat";
	displayLongName = "Syndikat Allegiance Group";
	displayColour = "ColorOpfor";
	side = 0;
	class Groups {
		class TargetHVT {
			classNames[] = {"O_T_Officer_F","O_V_Soldier_TL_ghex_F"};
		};
		class TargetHVT_INS {
			classNames[] = {{"O_T_Officer_F","I_C_Soldier_Camo_F"},{"O_V_Soldier_TL_ghex_F","I_C_Soldier_Para_4_F"}};
		};
		class Squad8 {
			classNames[] = {"O_T_Soldier_TL_F","O_T_Soldier_GL_F","O_T_Soldier_F","O_T_Soldier_AA_F","O_T_Soldier_AR_F","O_T_Soldier_AT_F","O_T_Soldier_M_F","O_T_medic_F"};
		};
		class Squad8_AA {
			classNames[] = {"O_T_Soldier_TL_F","O_T_Soldier_GL_F","O_T_Soldier_F","O_T_Soldier_A_F","O_T_Soldier_GL_F","O_T_Soldier_AA_F","O_T_Soldier_AA_F","O_T_medic_F"};
		};
		class Squad8_AR {
			classNames[] = {"O_T_Soldier_TL_F","O_T_Soldier_GL_F","O_T_Soldier_F","O_T_Soldier_A_F","O_T_Soldier_GL_F","O_T_Soldier_AR_F","O_T_Soldier_AR_F","O_T_medic_F"};
		};
		class Squad8_AT {
			classNames[] = {"O_T_Soldier_TL_F","O_T_Soldier_GL_F","O_T_Soldier_F","O_T_Soldier_A_F","O_T_Soldier_GL_F","O_T_Soldier_AT_F","O_T_Soldier_LAT_F","O_T_medic_F"};
		};
		class Squad8_M {
			classNames[] = {"O_T_Soldier_TL_F","O_T_Soldier_GL_F","O_T_Soldier_F","O_T_Soldier_A_F","O_T_Soldier_GL_F","O_T_Soldier_M_F","O_T_Soldier_M_F","O_T_medic_F"};
		};
		class Squad8_INS {
			classNames[] = {{"O_T_Soldier_F","I_C_Soldier_Bandit_6_F"},{"O_T_Soldier_F","I_C_Soldier_Bandit_5_F"},{"O_T_Soldier_F","I_C_Soldier_Bandit_3_F"},{"O_T_Soldier_F","I_C_Soldier_Bandit_2_F"},{"O_T_Soldier_F","I_C_Soldier_Bandit_8_F"},{"O_T_Soldier_F","I_C_Soldier_Bandit_7_F"},{"O_T_Soldier_F","I_C_Soldier_Bandit_4_F"},{"O_T_Soldier_F","I_C_Soldier_Bandit_1_F"}};
		};
		class Squad4 {
			classNames[] = {"O_T_Soldier_TL_F","O_T_Soldier_GL_F","O_T_Soldier_F","O_T_medic_F"};
		};
		class Squad4_AA {
			classNames[] = {"O_T_Soldier_TL_F","O_T_Soldier_GL_F","O_T_Soldier_AA_F","O_T_Soldier_AA_F"};
		};
		class Squad4_AR {
			classNames[] = {"O_T_Soldier_TL_F","O_T_Soldier_GL_F","O_T_Soldier_AR_F","O_T_Soldier_AR_F"};
		};
		class Squad4_AT {
			classNames[] = {"O_T_Soldier_TL_F","O_T_Soldier_GL_F","O_T_Soldier_AT_F","O_T_Soldier_LAT_F"};
		};
		class Squad4_M {
			classNames[] = {"O_T_Soldier_TL_F","O_T_Soldier_GL_F","O_T_Soldier_M_F","O_T_Soldier_M_F"};
		};
		class Squad4_INS {
			classNames[] = {{"O_T_Soldier_F","I_C_Soldier_Bandit_6_F"},{"O_T_Soldier_F","I_C_Soldier_Bandit_5_F"},{"O_T_Soldier_F","I_C_Soldier_Bandit_3_F"},{"O_T_Soldier_F","I_C_Soldier_Bandit_2_F"}};
		};
		class Sniper {
			classNames[] = {"O_T_ghillie_tna_F","O_T_ghillie_tna_F"};
		};
		class Sniper_INS {
			classNames[] = {"I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F"};
		};
		class ParaMilitary {
			classNames[] = {{"O_T_Soldier_F","I_C_Soldier_Para_6_F"},{"O_T_Soldier_F","I_C_Soldier_Para_2_F"},{"O_T_Soldier_F","I_C_Soldier_Para_4_F"},{"O_T_Soldier_F","I_C_Soldier_Para_5_F"},{"O_T_Soldier_F","I_C_Soldier_Para_8_F"}};
		};
		class SpecOps {
			classNames[] = {"O_T_Recon_TL_F","O_T_Recon_F","O_T_Recon_M_F","O_T_Recon_LAT_F","O_T_Recon_Exp_F"};
		};
		class SpecOps_Elite {
			classNames[] = {"O_V_Soldier_TL_ghex_F","O_V_Soldier_ghex_F","O_V_Soldier_M_ghex_F","O_V_Soldier_LAT_ghex_F","O_V_Soldier_Exp_ghex_F"};
		};
	};
	class Vehicles {
		class VehicleHVT {
			classNames[] = {"O_T_Truck_03_device_ghex_F"};
		};
		class VehicleHVT_INS {
			classNames[] = {"O_T_LSV_02_armed_black_F","O_T_LSV_02_armed_ghex_F"};
		};
		class Car {
			classNames[] = {"O_T_LSV_02_unarmed_F","O_T_LSV_02_unarmed_black_F","O_T_LSV_02_unarmed_ghex_F","O_T_MRAP_02_ghex_F"};
		};
		class Car_INS {
			classNames[] = {"O_G_Offroad_01_F","I_C_Offroad_02_unarmed_F"};
		};
		class CarTurret {
			classNames[] = {"O_T_LSV_02_armed_F","O_T_LSV_02_armed_black_F","O_T_LSV_02_armed_ghex_F","O_T_MRAP_02_gmg_ghex_F","O_T_MRAP_02_hmg_ghex_F"};
		};
		class CarTurret_INS {
			classNames[] = {"O_G_Offroad_01_armed_F"};
		};
		class Truck {
			classNames[] = {"O_T_Truck_03_transport_ghex_F","O_T_Truck_03_covered_ghex_F"};
		};
		class Truck_INS {
			classNames[] = {"I_C_Van_01_transport_F"};
		};
		class Truck_Support {
			classNames[] = {"O_T_Truck_03_repair_ghex_F","O_T_Truck_03_ammo_ghex_F","O_T_Truck_03_fuel_ghex_F"};
		};
		class Armour_AA {
			classNames[] = {"O_T_APC_Tracked_02_AA_ghex_F"};
		};
		class Armour_APC {
			classNames[] = {"O_T_APC_Wheeled_02_rcws_ghex_F","O_T_APC_Tracked_02_cannon_ghex_F"};
		};
		class Armour_MBT {
			classNames[] = {"O_T_MBT_02_cannon_ghex_F"};
		};
		class Armour_Art {
			classNames[] = {"O_T_MBT_02_arty_ghex_F"};
		};
		class CAS_Heli {
			classNames[] = {"O_Heli_Attack_02_black_F"};
		};
		class CAS_Air {
			classNames[] = {"O_Plane_CAS_02_F"};
		};
		class CAS_UAV {
			classNames[] = {"O_UAV_02_CAS_F","O_T_UAV_04_CAS_F"};
		};
		class Fighter_Plane {
			classNames[] = {"O_Plane_Fighter_02_F","O_Plane_Fighter_02_Stealth_F"};
		};
		class Transport_Heli {
			classNames[] = {"O_Heli_Transport_04_bench_black_F","O_Heli_Transport_04_covered_black_F"};
		};
		class Transport_Air {
			classNames[] = {"O_T_VTOL_02_infantry_ghex_F"};
		};
		class UAV {
			classNames[] = {"O_UAV_02_CAS_F","O_T_UAV_04_CAS_F"};
		};
		class UGV {
			classNames[] = {"O_T_UGV_01_rcws_ghex_F"};
		};
		class Boat {
			classNames[] = {"O_T_Boat_Armed_01_hmg_F"};
		};
	};
};
class Civilian_Tanoa {
	displayName = "Civilian";
	displayLongName = "Civilian";
	displayColour = "ColorCivilian";
	side = 3;
	class Groups {
		class Observer {
			classNames[] = {"C_Orestes"};
		};
		class Informants {
			classNames[] = {"C_Orestes","C_Nikos","C_Nikos_aged"};
		};
		class Crowd4 {
			classNames[] = {"C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_Man_casual_4_F_tanoan"};
		};
		class Crowd6 {
			classNames[] = {"C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_Man_casual_4_F_tanoan","C_Man_casual_5_F_tanoan","C_Man_casual_6_F_tanoan"};
		};
		class Crowd12 {
			classNames[] = {"C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_Man_casual_4_F_tanoan","C_Man_casual_5_F_tanoan","C_Man_casual_6_F_tanoan","C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_Man_casual_4_F_tanoan","C_Man_casual_5_F_tanoan","C_Man_casual_6_F_tanoan"};
		};
		class Crowd24 {
			classNames[] = {"C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_Man_casual_4_F_tanoan","C_Man_casual_5_F_tanoan","C_Man_casual_6_F_tanoan","C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_Man_casual_4_F_tanoan","C_Man_casual_5_F_tanoan","C_Man_casual_6_F_tanoan","C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_Man_casual_4_F_tanoan","C_Man_casual_5_F_tanoan","C_Man_casual_6_F_tanoan","C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_Man_casual_4_F_tanoan","C_Man_casual_5_F_tanoan","C_Man_casual_6_F_tanoan"};
		};
		class Journo {
			classNames[] = {"C_journalist_F"};
		};
	};
	class Vehicles {
		class Helicopter {
			classNames[] = {"C_Heli_Light_01_civil_F"};
		};
		class Boat {
			classNames[] = {"C_Boat_Civil_01_F","C_Boat_Civil_01_rescue_F","C_Boat_Civil_01_police_F"};
		};
		class Car {
			classNames[] = {"C_Offroad_01_F","C_Offroad_01_repair_F","C_Truck_02_covered_F","C_Truck_02_transport_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_SUV_01_F","C_Truck_02_fuel_F","C_Truck_02_box_F","C_Van_01_transport_F","C_Van_01_box_F","C_Van_01_fuel_F"};
		};
	};
};

/*
	Map: Malden
	Factions: Custom Made for PO4
*/
class Blufor_Malden: BLUFOR_Altis {};
class Opfor_Malden: OPFOR_Altis {};
class Civilian_Malden: Civilian_Altis {};
