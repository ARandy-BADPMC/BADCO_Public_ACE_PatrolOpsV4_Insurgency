class MPSF {
	tag = "MPSF";
	class Framework {
		file = "mpsf\functions";
		class init { preInit = 1; postInit = 1; };
	};
	class Camera {
		file = "mpsf\functions\camera";
		class camera {};
		class cameraDollyShot {};
		class cameraUI {};
	};
	class Common {
		file = "mpsf\functions\common";
		class animateUnit {};
		class checkMods {};
		class getNearbyBuildings {};
		class getObjectFromNetID {};
		class getRandomOpName {};
		class getRandomString {};
		class isAdmin {};
		class isUnitSpeaking {};
		class isWeaponRaised {};
		class createCtrl {};
		class destroyCtrl {};
		class getTurrets {};
		class getVehicleRoles {};
	};
	class Config {
		file = "mpsf\functions\config";
		class getCfgComposition {};
		class getCfgData {};
		class getCfgDataArray {};
		class getCfgDataBool {};
		class getCfgDataNumber {};
		class getCfgDataObject {};
		class getCfgDataText {};
		class getCfgIconNATO {};
		class getCfgIconNATOSize {};
		class getCfgMapData {};
		class getCfgParam {};
		class getCfgText {};
	};
	class Conversation {
		file = "mpsf\functions\conversation";
		class addConversation {};
		class conversation {};
	};
	class Developer {
		file = "mpsf\functions\developer";
		class capitaliseString {};
		class drawMapData {};
		class generateMapData {};
		class getAreaBorders {};
		class getAreaBuildings {};
		class getAreaSector {};
		class getAreaSectors {};
		class getMapLocations {};
		class getMapRoads {};
		class getMapSectors {};
		class getMapTerrain {};
		class showBuildingPositions {};
		class vehicleClasses {};
	};
	class Effects {
		file = "mpsf\functions\effects";
		class refractionPoint {};
	};
	class Environment {
		file = "mpsf\functions\environment";
		class civilianPopulation {};
		class environment { postInit = 1; };
		class playMusicScore {};
		class setDateTime {};
		class setWeather {};
	};
	class Events {
		file = "mpsf\functions\events";
		class addEventHandler {};
		class initEventHandler { preInit = 1; };
		class isEventHandler {};
		class law_onKilledInjured {};
		class onDamagedCfgTasks_C4Only_eh {};
		class onDamagedCfgTasks_eh {};
		class onKilledCfgTasks_eh {};
		class removeEventHandler {};
		class triggerEventHandler {};
	};
	class Hazard {
		file = "mpsf\functions\hazard";
		class hazardous { postInit = 1; };
		class suicideBomber {};
		class vehicleIED {};
		class roadsideIED {};
	};
	class HeadlessClient {
		file = "mpsf\functions\hlc";
		class getHeadlessClient {};
		class isHeadlessClient {};
		class getHeadlessClients {};
		class isHeadlessClientPresent {};
	};
	class Group {
		file = "mpsf\functions\group";
		class createSquad {};
		class getSquadID {};
		class getSquadInsignia {};
		class getUnitLoadout {};
		class getUnitRole {};
		class getUnitTrait {};
		class group { postInit = 1; };
		class joinSquad {};
		class removeSquad {};
		class setSquadID {};
		class setSquadInsignia {};
		class setSquadLeader {};
		class setUnitLoadout {};
		class setUnitRole {};
		class setUnitTrait {};
	};
	class Intel {
		file = "mpsf\functions\intel";
		class createDiaryNote {};
		class createIntel {};
		class createIntelBeacon {};
		class intel { postInit = 1; };
		class onKilledDropIntel {};
	};
	class Interact {
		file = "mpsf\functions\interact";
		class actionBodyBag {};
		class actionBodySearch {};
		class actionVehicleDoors {};
		class addAction {};
		class interaction {};
		class removeAction {};
	};
	class Interface {
		file = "mpsf\functions\interface";
		class interface { postInit = 1; };
		class mapDrawSquadMarkers {};
		class visualSettings {};
	};
	class Logistics {
		file = "mpsf\functions\logistics";
		class advancedSlingLoading { postInit = 1; };
		class advancedTowing { postInit = 1; };
		class shkFastRope { postInit = 1; };
	};
	class Simulation {
		file = "mpsf\functions\simulation";
		class dynamicSimulation { preInit = 1; };
		class simulCiv { postInit = 0; };
		class simulLayers {};
		class simulWeather {};
	};
	class Spawner {
		file = "mpsf\functions\spawner";
		class create3DENComposition {};
		class createAgentGroup {};
		class createAircraftCAS {};
		class createAircraftFlyby {};
		class createAmbush {};
		class createBridge {};
		class createCarrier01 {};
		class createCheckpoint {};
		class createComposition {};
		class createConvoy {};
		class createCrew {};
		class createDeployable {};
		class createGroup {};
		class createLogic {};
		class createObject {};
		class createOccupiedArea {};
		class createParadrop {};
		class createPatrol {};
		class createVehicle {};
		class effectExplosionSecondaries {};
		class initSpawnerEH { postInit = 1; };
		class initVehicle {};
		class getConfigLoadout {};
		class getCfgFaction {};
		class getCfgFactionID {};
		class setGroupAirCombat {};
		class setGroupAttack {};
		class setGroupCrowd {};
		class setGroupDefend {};
		class setGroupHold {};
		class setGroupMoveRandom {};
		class setGroupOccupy {};
		class setGroupPatrol {};
		class setFactionTypeOPF {};
		class setUnitGear {};
		class setVehicleAmmo {};
		class setVehicleFuel {};
		class setVehicleHealth {};
	};
	class Taskmaster {
		file = "mpsf\functions\taskmaster";
		class addCfgTaskMonitor {};
		class createCfgTask {};
		class createCfgTaskCompositions {};
		class createCfgTaskDeployable {};
		class createCfgTaskGroups {};
		class createCfgTaskLogic {};
		class createCfgTaskMarkers {};
		class createCfgTaskObjective {};
		class createCfgTaskReturnPoint {};
		class getCfgTaskID {};
		class getCfgTaskModules {};
		class getCfgTaskPosition {};
		class getCfgTasks {};
		class processCfgTask {};
		class processCfgTaskArguments {};
		class removeCfgTask {};
		class removeCfgTaskMonitor {};
		class taskmaster {};

	};
	class Taskmanager {
		file = "mpsf\functions\taskmanager";
		class areTasksComplete {};
		class assignTask {};
		class createTask {};
		class getAssignedTask {};
		class getAssignedTaskPlayers {};
		class getAvailableTasks {};
		class getNearestReturnPoint {};
		class getReturnPoints {};
		class getTaskData {};
		class getTaskDescription {};
		class isTaskComplete {};
		class isTaskState {};
		class removeTask {};
		class updateTaskDestination {};
		class updateTaskState {};
	};
	class Zeus {
		file = "mpsf\functions\zeus";
		class addZeusEditArea {};
		class addZeusObjects {};
		class initZeus { postInit = 1; };
		class removeZeusEditArea {};
	};
};

class MPSF_Param {
	tag = "MPSF_Param";
	class Params {
		file = "mpsf\params";
		class setMission3rdPerson {};
		//class setMissionArmoury {};
		//class setMissionEnableCOIN {};
		//class setMissionEnemyFaction {};
		class setMissionFatigue {};
		//class setMissionLimit {};
		//class setMissionRange {};
		//class setMissionSpeed {};
		class setMissionTime {};
		//class setMissionType {};
		class setMissionWeather {};
		//class setMissionWeatherForecast {};
	};
};

class RespawnMP {
	tag = "MPSF";
	class Revive {
		file = "mpsf\functions\respawnmp";
		class createMHQ {};
		class createRedeployPoint {};
		class respawnmp { preInit = 1; postInit = 1; };
		class respawnHALO { ext = ".fsm"; };
		class respawnMHQ {};
		class respawnRally {};
		class respawnmpEH {};
	};
};

class ReviveMP {
	tag = "MPSF";
	class Revive {
		file = "mpsf\functions\revivemp";
		class addRevive {};
		class isInjured {};
		class setInjured {};
		class isReviving {};
		class revivemp { preInit = 1; };
	};
};

class VirtualArmoury {
	tag = "MPSF";
	class VirtualArmoury {
		file = "mpsf\functions\virtualarmoury";
		class createLoadoutPoint {};
		class generateRoles {};
		class VirtualArmoury { postInit = 1; };
	};
};

class VirtualDepot {
	tag = "MPSF";
	class VirtualDepot {
		file = "mpsf\functions\virtualdepot";
		class createVirtualDepot {};
		class VirtualDepot { postInit = 1; };
		class flashinglights {};
	};
};

class PO4 {
	tag = "PO4";
	class Mission {
		file = "mpsf\functions\mission";
		class conversationResponses {};
		class encounters { postInit = 1; };
		class operations { postInit = 1; };
		class zones { postInit = 1; };
		class tutorial {};
	};
};