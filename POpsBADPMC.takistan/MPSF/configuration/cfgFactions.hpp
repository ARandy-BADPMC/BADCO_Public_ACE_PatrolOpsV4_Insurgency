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
			classNames[] = {"B_Officer_F","B_Recon_JTAC_F"};
		};
		class TargetHVT_INS {
			classNames[] = {"B_G_officer_F","B_G_Sharpshooter_F"};
		};
		class Squad8 {
			classNames[] = {"B_Soldier_TL_F","B_Soldier_GL_F","B_Soldier_F","B_Soldier_AA_F","B_Soldier_AR_F","B_Soldier_AT_F","B_Soldier_M_F","B_medic_F"};
		};
		class Squad8_AA {
			classNames[] = {"B_Soldier_TL_F","B_Soldier_GL_F","B_Soldier_F","B_Soldier_A_F","B_Soldier_GL_F","B_Soldier_AA_F","B_Soldier_AA_F","B_medic_F"};
		};
		class Squad8_AR {
			classNames[] = {"B_Soldier_TL_F","B_Soldier_GL_F","B_Soldier_F","B_Soldier_A_F","B_Soldier_GL_F","B_Soldier_AR_F","B_Soldier_AR_F","B_medic_F"};
		};
		class Squad8_AT {
			classNames[] = {"B_Soldier_TL_F","B_Soldier_GL_F","B_Soldier_F","B_Soldier_A_F","B_Soldier_GL_F","B_Soldier_AT_F","B_Soldier_LAT_F","B_medic_F"};
		};
		class Squad8_M {
			classNames[] = {"B_Soldier_TL_F","B_Soldier_GL_F","B_Soldier_F","B_Soldier_A_F","B_Soldier_GL_F","B_Soldier_M_F","B_Soldier_M_F","B_medic_F"};
		};
		class Squad8_INS {
			classNames[] = {"B_G_Soldier_TL_F","B_G_Soldier_GL_F","B_G_Soldier_LAT_F","B_G_Soldier_AR_F","B_G_Soldier_AR_F","B_G_Soldier_LAT_F","B_G_Sharpshooter_F","B_G_medic_F"};
		};
		class Squad4 {
			classNames[] = {"B_Soldier_TL_F","B_Soldier_GL_F","B_Soldier_F","B_medic_F"};
		};
		class Squad4_AA {
			classNames[] = {"B_Soldier_TL_F","B_Soldier_GL_F","B_Soldier_AA_F","B_Soldier_AA_F"};
		};
		class Squad4_AR {
			classNames[] = {"B_Soldier_TL_F","B_Soldier_GL_F","B_Soldier_AR_F","B_Soldier_AR_F"};
		};
		class Squad4_AT {
			classNames[] = {"B_Soldier_TL_F","B_Soldier_GL_F","B_Soldier_AT_F","B_Soldier_LAT_F"};
		};
		class Squad4_M {
			classNames[] = {"B_Soldier_TL_F","B_Soldier_GL_F","B_Soldier_M_F","B_Soldier_M_F"};
		};
		class Squad4_INS {
			classNames[] = {"B_G_Soldier_TL_F","B_G_Soldier_GL_F","B_G_Soldier_LAT_F","B_G_medic_F"};
		};
		class Sniper {
			classNames[] = {"B_ghillie_sard_F","B_ghillie_sard_F"};
		};
		class Sniper_INS {
			classNames[] = {"B_G_Sharpshooter_F","B_G_Sharpshooter_F"};
		};
		class ParaMilitary {
			classNames[] = {"B_G_Soldier_TL_F","B_G_Soldier_GL_F","B_G_Soldier_LAT_F","B_G_Soldier_AR_F","B_G_Soldier_AR_F","B_G_Soldier_LAT_F","B_G_Sharpshooter_F","B_G_medic_F"};
		};
		class SpecOps {
			classNames[] = {"B_Recon_TL_F","B_Recon_F","B_Recon_M_F","B_Recon_LAT_F","B_Recon_JTAC_F"};
		};
		class SpecOps_Elite {
			classNames[] = {"B_CTRG_soldier_GL_LAT_F","B_CTRG_soldier_AR_A_F","B_CTRG_Sharphooter_F","B_CTRG_soldier_engineer_exp_F","B_CTRG_soldier_M_medic_F"};
		};
	};
	class Vehicles {
		class VehicleHVT {
			classNames[] = {"B_Truck_01_ammo_F","B_APC_Tracked_01_CRV_F"};
		};
		class VehicleHVT_INS {
			classNames[] = {"B_G_Offroad_01_repair_F"};
		};
		class Car {
			classNames[] = {"B_MRAP_01_F","B_LSV_01_unarmed_black_F","B_LSV_01_unarmed_sand_F"};
		};
		class Car_INS {
			classNames[] = {"B_G_Offroad_01_F"};
		};
		class CarTurret {
			classNames[] = {"B_MRAP_01_gmg_F","B_MRAP_01_hmg_F","B_LSV_01_armed_black_F","B_LSV_01_armed_sand_F"};
		};
		class CarTurret_INS {
			classNames[] = {"B_G_Offroad_01_armed_F"};
		};
		class Truck {
			classNames[] = {"B_Truck_01_transport_F","B_Truck_01_covered_F"};
		};
		class Truck_INS {
			classNames[] = {"B_G_Van_01_transport_F"};
		};
		class Truck_Support {
			classNames[] = {"B_Truck_01_Repair_F","B_Truck_01_ammo_F","B_Truck_01_fuel_F"};
		};
		class Armour_AA {
			classNames[] = {"B_APC_Tracked_01_AA_F"};
		};
		class Armour_APC {
			classNames[] = {"B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F"};
		};
		class Armour_MBT {
			classNames[] = {"B_MBT_01_cannon_F","B_MBT_01_TUSK_F"};
		};
		class Armour_Art {
			classNames[] = {"B_MBT_01_arty_F","B_MBT_01_mlrs_F"};
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
			classNames[] = {"B_CTRG_Heli_Transport_01_sand_F","B_Heli_Transport_01_F","B_Heli_Transport_03_F"};
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
			classNames[] = {"B_Boat_Armed_01_minigun_F"};
		};
	};
};
class Opfor_Altis {
	displayName = "AFA";
	displayLongName = "Altis Freedom Alliance";
	displayColour = "ColorOpfor";
	side = 0;
	class Groups {
		class TargetHVT {
			classNames[] = {"O_Officer_F","O_V_Soldier_TL_hex_F"};
		};
		class TargetHVT_INS {
			classNames[] = {"O_G_officer_F","O_G_Sharpshooter_F"};
		};
		class Squad8 {
			classNames[] = {"O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_AA_F","O_Soldier_AR_F","O_Soldier_AT_F","O_soldier_M_F","O_medic_F"};
		};
		class Squad8_AA {
			classNames[] = {"O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_A_F","O_Soldier_GL_F","O_Soldier_AA_F","O_Soldier_AA_F","O_medic_F"};
		};
		class Squad8_AR {
			classNames[] = {"O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_A_F","O_Soldier_GL_F","O_Soldier_AR_F","O_Soldier_AR_F","O_medic_F"};
		};
		class Squad8_AT {
			classNames[] = {"O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_A_F","O_Soldier_GL_F","O_Soldier_AT_F","O_Soldier_LAT_F","O_medic_F"};
		};
		class Squad8_M {
			classNames[] = {"O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_A_F","O_Soldier_GL_F","O_soldier_M_F","O_soldier_M_F","O_medic_F"};
		};
		class Squad8_INS {
			classNames[] = {"O_G_Soldier_TL_F","O_G_Soldier_GL_F","O_G_Soldier_LAT_F","O_G_Soldier_AR_F","O_G_Soldier_A_F","O_G_Soldier_M_F","O_G_Sharpshooter_F","O_G_medic_F"};
		};
		class Squad4 {
			classNames[] = {"O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_medic_F"};
		};
		class Squad4_AA {
			classNames[] = {"O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_AA_F","O_Soldier_AA_F"};
		};
		class Squad4_AR {
			classNames[] = {"O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_AR_F","O_Soldier_AR_F"};
		};
		class Squad4_AT {
			classNames[] = {"O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_AT_F","O_Soldier_LAT_F"};
		};
		class Squad4_M {
			classNames[] = {"O_Soldier_TL_F","O_Soldier_GL_F","O_soldier_M_F","O_soldier_M_F"};
		};
		class Squad4_INS {
			classNames[] = {"O_G_Soldier_TL_F","O_G_Soldier_GL_F","O_G_Soldier_LAT_F","O_G_Soldier_AR_F"};
		};
		class Sniper {
			classNames[] = {"O_ghillie_sard_F","O_ghillie_sard_F"};
		};
		class Sniper_INS {
			classNames[] = {"O_G_Sharpshooter_F","O_G_Sharpshooter_F"};
		};
		class ParaMilitary {
			classNames[] = {"O_G_Soldier_TL_F","O_G_Soldier_AR_F","O_G_Soldier_GL_F","O_G_Soldier_M_F","O_G_Soldier_LAT_F"};
		};
		class SpecOps {
			classNames[] = {"O_recon_TL_F","O_recon_F","O_recon_M_F","O_recon_LAT_F","O_recon_exp_F"};
		};
		class SpecOps_Elite {
			classNames[] = {"O_V_Soldier_TL_hex_F","O_V_Soldier_hex_F","O_V_Soldier_M_hex_F","O_V_Soldier_LAT_hex_F","O_V_Soldier_Exp_hex_F"};
		};
	};
	class Vehicles {
		class VehicleHVT {
			classNames[] = {"O_Truck_03_device_F"};
		};
		class Car {
			classNames[] = {"O_LSV_02_unarmed_F","O_LSV_02_unarmed_black_F","O_LSV_02_unarmed_arid_F","O_MRAP_02_F"};
		};
		class Car_INS {
			classNames[] = {"O_G_Offroad_01_F"};
		};
		class CarTurret {
			classNames[] = {"O_LSV_02_armed_F","O_LSV_02_armed_black_F","O_LSV_02_armed_arid_F","O_MRAP_02_gmg_F","O_MRAP_02_hmg_F"};
		};
		class CarTurret_INS {
			classNames[] = {"O_G_Offroad_01_armed_F"};
		};
		class Truck {
			classNames[] = {"O_Truck_03_transport_F","O_Truck_03_covered_F"};
		};
		class Truck_INS {
			classNames[] = {"O_Truck_02_transport_F","O_G_Van_01_transport_F"};
		};
		class Truck_Support {
			classNames[] = {"O_Truck_03_repair_F","O_Truck_03_ammo_F","O_Truck_03_fuel_F"};
		};
		class Armour_AA {
			classNames[] = {"O_APC_Tracked_02_AA_F"};
		};
		class Armour_APC {
			classNames[] = {"O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F"};
		};
		class Armour_MBT {
			classNames[] = {"O_MBT_02_cannon_F"};
		};
		class Armour_Art {
			classNames[] = {"O_MBT_02_arty_F"};
		};
		class CAS_Heli {
			classNames[] = {"O_Heli_Attack_02_F","O_Heli_Attack_02_black_F"};
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
			classNames[] = {"O_Heli_Transport_04_bench_black_F","O_Heli_Transport_04_bench_F","O_Heli_Transport_04_covered_black_F","O_Heli_Transport_04_covered_F"};
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
			classNames[] = {"C_man_polo_1_F_afro","C_man_polo_1_F_asia","C_man_polo_1_F_euro","C_man_polo_1_F"};
		};
		class Crowd6 {
			classNames[] = {"C_man_polo_2_F_afro","C_man_polo_2_F_asia","C_man_polo_2_F_euro","C_man_polo_2_F","C_man_polo_3_F_euro","C_man_polo_3_F"};
		};
		class Crowd12 {
			classNames[] = {"C_man_polo_3_F_afro","C_man_polo_3_F_asia","C_man_polo_4_F_afro","C_man_polo_4_F_asia","C_man_polo_4_F_euro","C_man_polo_4_F","C_man_polo_5_F_afro","C_man_polo_5_F_asia","C_man_polo_5_F_euro","C_man_polo_5_F","C_man_1_1_F","C_man_1_2_F"};
		};
		class Crowd24 {
			classNames[] = {"C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F","C_Driver_1_random_base_F","C_man_shorts_2_F","C_man_shorts_3_F","C_man_shorts_4_F","C_man_w_worker_F","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F","C_Driver_1_random_base_F","C_man_shorts_2_F","C_man_shorts_3_F","C_man_shorts_4_F","C_man_w_worker_F"};
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
