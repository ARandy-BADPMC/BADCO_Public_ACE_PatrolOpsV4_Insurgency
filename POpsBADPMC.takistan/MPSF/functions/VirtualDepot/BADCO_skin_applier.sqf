BADCO_texture_applier = {
_vehicle = _this select 0;
//aircraft
if (typeOf _vehicle == "I_Plane_Fighter_04_F") then 
	{ 
		_vehicle setObjectTextureGlobal [0,"\Gripen_textures\Gripen_Skin1.paa"]; 
		_vehicle setObjectTextureGlobal [1,"\Gripen_textures\Grippen_Skin2.paa"];
	};
if (typeOf _vehicle == "I_Heli_light_03_dynamicLoadout_F") then 
	{ 
		_vehicle setObjectTextureGlobal [0,"\a3\Air_F_EPB\Heli_Light_03\data\Heli_Light_03_base_CO.paa"];
	};
if (typeOf _vehicle == "O_Heli_Light_02_dynamicLoadout_F") then 
	{ 
		_vehicle setObjectTextureGlobal [0,"a3\air_f\heli_light_02\data\heli_light_02_ext_co.paa"];
	};
if (typeOf _vehicle == "O_Heli_Transport_04_F") then 
	{
		_vehicle setObjectTextureGlobal [0,"a3\air_f_heli\heli_transport_04\data\heli_transport_04_base_01_black_co.paa"]; 
		_vehicle setObjectTextureGlobal [1,"a3\air_f_heli\heli_transport_04\data\heli_transport_04_base_02_black_co.paa"];
	};
if (typeOf _vehicle == "I_Heli_Transport_02_F") then 
	{
		_vehicle setObjectTextureGlobal [0, "\NH90_textures\NH90_0.paa"];
		_vehicle setObjectTextureGlobal [1, "\NH90_textures\NH90_1.paa"];
		_vehicle setObjectTextureGlobal [2, "\NH90_textures\NH90_2.paa"];
	};

//land vehs
if (typeOf _vehicle == "I_MRAP_03_gmg_F" || typeOf _vehicle == "I_MRAP_03_hmg_F")then 
	{
		_vehicle setObjectTextureGlobal [0,"\Fennek_textures\Fennek_0.paa"]; 
		_vehicle setObjectTextureGlobal [1,"\Fennek_textures\Fennek_1.paa"];
	};
if (typeOf _vehicle == "I_MBT_03_cannon_F") then 
	{ 
		_vehicle setObjectTextureGlobal [0,"\Leopard_textures\Leopard_0.paa"];
		_vehicle setObjectTextureGlobal [1,"\Leopard_textures\Leopard_1.paa"]; 
		_vehicle setObjectTextureGlobal [2,"\Leopard_textures\Leopard_0.paa"];
	};
if (typeOf _vehicle == "I_APC_Wheeled_03_cannon_F") then 
	{
		_vehicle setObjectTextureGlobal [0,"\Pandur_textures\pandur_0"];
		_vehicle setObjectTextureGlobal [1,"\Pandur_textures\pandur_1"];
		_vehicle setObjectTextureGlobal [2,"\Pandur_textures\pandur_2"];
		_vehicle setObjectTextureGlobal [3,"\Pandur_textures\pandur_3"];
	};
if (typeOf _vehicle == "O_APC_Wheeled_02_rcws_F") then 
	{
		_vehicle setObjectTextureGlobal [0,"\ARMA_textures\ARMA_0"];
		_vehicle setObjectTextureGlobal [1,"\ARMA_textures\ARMA_1"];
		_vehicle setObjectTextureGlobal [2,"\ARMA_textures\ARMA_2"];
	};
if (typeOf _vehicle == "O_MRAP_02_gmg_F" || typeOf _vehicle == "O_MRAP_02_hmg_F") then 
	{
		_vehicle setObjectTextureGlobal [0,"\IFRIT_textures\IFRIT_0"];
		_vehicle setObjectTextureGlobal [1,"\IFRIT_textures\IFRIT_1"];
		_vehicle setObjectTextureGlobal [2,"\IFRIT_textures\IFRIT_2"];
	};
if (typeOf _vehicle == "O_MRAP_02_F") then 
	{
		_vehicle setObjectTextureGlobal [0,"\IFRIT_textures\IFRIT_0"];
		_vehicle setObjectTextureGlobal [1,"\IFRIT_textures\IFRIT_1"];
	};
if (typeOf _vehicle == "rhs_tigr_vdv" || typeOf _vehicle == "rhs_tigr_sts_vdv" || typeOf _vehicle == "rhs_tigr_m_vdv") then 
	{
		_vehicle setObjectTextureGlobal [0, "\GAZ_textures\GAZ_0.paa"];
		_vehicle setObjectTextureGlobal [1, "\GAZ_textures\GAZ_1.paa"];
		_vehicle setObjectTextureGlobal [2, "\GAZ_textures\GAZ_2.paa"];
	};



//special
if (typeOf _vehicle == "rhs_bmp2d_msv") then 
	{
		[ _vehicle, ["standard",1], ["konkurs_hide_source",1,"crate_l1_unhide",1,"crate_l2_unhide",1,"crate_l3_unhide",1,"crate_r1_unhide",1,"crate_r2_unhide",1,"crate_r3_unhide",1,"wood_1_unhide",1] ] call BIS_fnc_initVehicle; 
		_vehicle setObjectTextureGlobal [0,"\BMP_2_textures\BMP2_0"];
		_vehicle setObjectTextureGlobal [1,"\BMP_2_textures\BMP2_1"];
		_vehicle setObjectTextureGlobal [2,"\BMP_2_textures\BMP2_2"];
		_vehicle setObjectTextureGlobal [3,"\BMP_2_textures\BMP2_3"];
	};

if (typeOf _vehicle == "rhs_t72bb_tv") then 
	{
		[_vehicle,["standard",1], ["hide_com_shield",1]] call BIS_fnc_initVehicle;
		_vehicle setObjectTextureGlobal [0, "\M84_textures\0.paa"];
		_vehicle setObjectTextureGlobal [1, "\M84_textures\1.paa"];
		_vehicle setObjectTextureGlobal [2, "\M84_textures\2.paa"];
		_vehicle setObjectTextureGlobal [3, "\M84_textures\3.paa"];
		_vehicle setObjectTextureGlobal [4, "\M84_textures\4.paa"];

		_vehicle ForceFlagTexture "\M84_textures\CroatianFlag.paa";
	};

if (typeOf _vehicle == "O_T_APC_Tracked_02_cannon_ghex_F") then 
	{
		_vehicle lockTurret [[0,0], true]; 
		_vehicle lockTurret [[0], true]; 
		_vehicle animate ["HideTurret",1];
		_vehicle setVariable ["ace_medical_medicClass",1,true];

		_vehicle setObjectTextureGlobal [0,"\BTRK_textures\BTRK0.paa"];
		_vehicle setObjectTextureGlobal [1,"\BTRK_textures\BTRK1.paa"];
	};

if (typeOf _vehicle == "B_APC_Wheeled_01_cannon_F") then 
	{
		[_vehicle,["Sand",1],["showBags",0,"showCamonetHull",1,"showCamonetTurret",1,"showSLATHull",0,"showSLATTurret",1]] call BIS_fnc_initVehicle; 
	};

if (typeOf _vehicle == "RHS_Mi8AMTSh_vvs") then 
	{
		[ _vehicle ,nil,["HIDE_front_armor",1,"HIDE_weapon_holders",1,"bench_hide",0,"exhaust_hide",0,"RearDoors",0]] call BIS_fnc_initVehicle;

		_vehicle setObjectTextureGlobal [0,"\MI17_textures\MI-17.paa"];
	};

if (typeof _vehicle == "RHS_Mi24P_vdv") then 
	{
		_vehicle setObjectTextureGlobal [0, "\MI24_textures\MI-240.paa"];
		_vehicle setObjectTextureGlobal [1, "\MI24_textures\MI-241.paa"];
	};

};