// Phase 1
class Operation_Phase1_AssaultNight {
	scope = 2;
	typeID = 0;
	class TaskDetails {
		parent = "";
		title = "Operation Hard Eye Selen";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3 | Phase 1 of 2</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>%1 has been a region of heavy conflict for the last decade. Recently, after the withdrawl of %4 forces from the region, the rise of %5 has accelerated rapidly with vast regions in the eastern and sourthern parts of %1 now reported to be under their control in the hopes of profiting from a black market resource trade. This has placed an increasing amount of pressure on diplomated relationships with press coverage blasting the %4 withdrawl for a lack of accountability and repect for the people of %1.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>Phase 1: %4 Forces will re-assert control over northern and western regional areas of %1. The objective is to re-esablish a safezone to support the civilian population and new governement of %1 while gathering INTEL on regional %5 activities in the hope of mounting further operations to eliminate it.<br/>%4 Forces will move in Phase 1 to %7 and conduct several syncronised tasks to secure key strategic locations and capture enemy intel.<br/>Phase 2: To Follow after review of captured INTEL and Drone flights over eastern regions</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>Little is known about what the %5 insurgency have with respect to their resources however attacks have begun to increase in the last month. While there is no evidence of external funding and resourcing, there have been reports of foreign observers in the region and COMMAND has suspicion that the insurgency is backed by foriegn governemnts or organised criminal enterprises. More INTEL is needed before mounting serious operations against %5 supply lines, key personnel and further direct engagements with %5 Forces.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Redacted --COMMAND ONLY--</t>"
		};
		iconType = "Defend";
		chevronTitle = "Operation Phase 1";
		textArguments[] = {"worldName","randomCode","datetime","factionBLUlong","factionOPFlong","factionOPFshort","nearestTown"};
	};
	class Environment {
		time = "Dawn";
		fog = 1;
		force = 1;
	};
	class Markers {};
	class ChildTasks {
		class Phase1_SecureArea_Crossroads {};
		class Phase1_SecureArea_Commstower {};
		class Phase1_SecureArea_Barracks {};
	};
	class Objective {
		class Succeeded {
			condition = "_childTasksComplete";
		};
	};
};
class Phase1_SecureArea_Crossroads {
	scope = 2;
	typeID = 2;
	position = "op_p1_crossroads";
	positionOffset = "op_p1_crossroads_offset";
	class TaskDetails {
		parent = "Operation_Phase1_AssaultNight";
		title = "Secure Crossroads";
		description[] = {
			"<t>Ref: %1</t> | <t>Date: %2<br/>AO: %3 %4 near %5</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>There is a key strategic chokepoint for %7 supply lines and retreat created by the terrain and buildings. The crossroads linking this has been identified as a key objective area that will cut the enemy off from their command and put their potential strategies in disarray.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%6 forces will move to and occupy the area, ensuring that any enemy forces are engaged and cleared from those locations around the crossroads. It is essential this is completed otherwise possible reinforcements can breach our lines and attack %6 forces from the side and rear.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>The enemy has clearly identified the area as a strategic location and appear to have moved larger technicals and heavy weapons to that area. Excercise extreme caution as there is a high CIV population in that area</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>There are civilians in the area and it is possible that some may support %7. Be on the lookout for watchers who are likely to relay your location to the enemy.<br/>ROE states they cannot be engaged however less hostile approaches may prove useful.</t>"
		};
		iconType = "A";
		iconPosition = "positionOffset";
		chevronTitle = "%1";
		textArguments[] = {"randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort"};
	};

	class Markers {
		//
	};

	class Groups {
		class target_0 {
			probability = 1;
			faction = "FactionTypeOPF";
			groupTypes[] = {"Squad8_INS"};
			isPatrolling = 1;
			position = "positionOffset";
			radius[] = {60,80};
		};
	};

	class Objective {
		class Succeeded {
			condition = "_unitsKilled";
		};
	};
};
class Phase1_SecureArea_Commstower {
	scope = 2;
	typeID = 2;
	position = "op_p1_commstower";
	positionOffset = "op_p1_commstower_offset";
	class TaskDetails {
		parent = "Operation_Phase1_AssaultNight";
		title = "Secure Comms Hub";
		description[] = {
			"<t>Ref: %1</t> | <t>Date: %2<br/>AO: %3 %4 near %5</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>%7 forces have taken the nearby communications tower in an effort to control civilian communications and support their own. This is a key strategic position for %7 that must be captured in order to disrupt their efforts to coordinate their forces and request assistance in the event of an assault by %6 forces.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%6 forces will capture this objective with the intent to secure and not destroy the equipment. Eliminate all hostiles in and around the locations then fortify the position against possible counter attacks. The communications equipment is highly valuable so every effort should be made to preserve the building and tower.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>This is a KEY COMMS HUB for the enemy and is likely to be well defended by veteren and well equipped soldiers. Due to the enemy encrypting their signals, we cannot determine size or capaibility of the force occyuping the loction. Clearing the position should be done as quickly as possible due to the likelyhood of soldiers at that location requesting reinforcements from nearby strongholds.<br/>It is likely that the enemy have their encryption gear set up at the site which is a major strategic benefit if the device data is able to be recovered.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>There are civilians in the area and it is possible that some may support %7. Be on the lookout for watchers who are likely to relay your location to the enemy.<br/>ROE states they cannot be engaged however less hostile approaches may prove useful.</t>"
		};
		iconType = "B";
		iconPosition = "position";
		chevronTitle = "%1";
		textArguments[] = {"randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort"};
	};
	class Markers {};
	class Compositions {
		class iedBlastSite {
			typeIDs[] = {"comms_tower_georgetown"};
			downloadIntel = 1;
		};
		class B_UAV_05_CrashSite_F {
			typeIDs[] = {"B_UAV_05_CrashSite_F"};
			downloadIntel = 1;
		};
	};
	class Groups {
		class target_0 {
			probability = 1;
			faction = "FactionTypeOPF";
			groupTypes[] = {"Squad4"};
			isDefending = 1;
			occupyBuildings = 1;
			position = "position";
			radius[] = {30,30};
		};
		class target_1 {
			probability = 1;
			faction = "FactionTypeOPF";
			groupTypes[] = {"Squad4"};
			isPatrolling = 1;
			position = "positionOffset";
			radius[] = {80,80};
		};
		class target_2 {
			probability = 1;
			faction = "FactionTypeOPF";
			groupTypes[] = {"Squad4"};
			isDefending = 1;
			occupyBuildings = 1;
			position = "positionOffset";
			radius[] = {80,80};
		};
	};
	class Objective {
		class Succeeded {
			condition = "_unitsKilled && _intelDownloaded";
		};
	};
};
class Phase1_SecureArea_Barracks {
	scope = 2;
	typeID = 2;
	position = "op_p1_baracks";
	positionOffset = "op_p1_barracks_offset";
	class TaskDetails {
		parent = "Operation_Phase1_AssaultNight";
		title = "Secure Police HQ";
		description[] = {
			"<t>Ref: %1</t> | <t>Date: %2<br/>AO: %3 %4 near %5</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>%7 forces have taken over and occupied the local district police HQ in an effort to gain weapons and vehicles. Local Police were able to remove the bulk of the weapons and vehicles before being driven away however it is likely they did not get everything as COMMAND is still waiting on a report into the recovered inventory. This is another key location that needs to be recovered due to the building strongpoint to the district and it is a likely used by %7 as a command post for its officers.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%6 forces will surround and engage all hostiles at the objective, capture any senior %7 officers where possible and recover any potential intel they may be carrying.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>It is highly possible that this location is the command post for %7 operations in the area. It is therefore likely to have be heavily defended with escape routes planned for enemy senior officers.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>There are civilians in the area that may support %8. Be on the lookout for watchers who are likely to relay your location to the enemy.<br/>ROE states they cannot be engaged however less hostile approaches may prove useful.</t>"
		};
		iconType = "C";
		iconPosition = "positionOffset";
		chevronTitle = "%1";
		textArguments[] = {"randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort"};
	};
	class Markers {};
	class Groups {
		class target_0 {
			probability = 1;
			faction = "FactionTypeOPF";
			groupTypes[] = {"Squad8_INS"};
			isDefending = 1;
			occupyBuildings = 1;
			position = "position";
			radius[] = {50,50};
		};
		class target_1 {
			probability = 1;
			faction = "FactionTypeOPF";
			groupTypes[] = {"Squad4_INS"};
			isDefending = 1;
			occupyBuildings = 1;
			dropIntel = 1;
			position = "positionOffset";
			radius[] = {30,30};
		};
	};
	class Deployable {
		class deploy_1 {
			position = "";
			direction = 0;
			container = "";
			Object = "";
		};
	};
	class Objective {
		class Succeeded {
			condition = "_unitsKilled && _intelPickedup";
		};
	};
};

// Phase 2
class Operation_Phase2_ClearSkies {
	// Brief Clear Tactical Positions
	// Later that afternoon/dusk
	scope = 1;
	typeID = 0;
	class TaskDetails {
		parent = "";
		title = "Operation Hard Eye Selen";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3 | Phase 2 of 2</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>After the initial assault in Georgetown, %6 appear to have not withdrawn as expected and instead have increased activity in the western regions of %1. Drone surveillance has been completely ineffective in penetrating the canopy of the jungle, which is masking %6 movements. Attempts to penetrate further west have observerd heavy anti-air engagement leading to the loss of a UCAV to the sourthern part of the main %1 island. Reconnaissance has identified 2 locations from where Ground to Air Misiles were launched from and in the presence of a unknown and high risk threat, COMMAND has issued a No-Fly zone until those positions have been cleared.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%4 forces will conduct several operations to restore Air Superiority over %1 and recover INTEL to identify movement patterns and strongholds of %6 forces on %1's main island. There is a NO-FLY zone over %1 until the operations have been successfully carried out.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>%6 forces are using the dense %1 jungle to move heavy equipment to key strategic locations in %1. The scale and capability of their forces is not determinable at this stage until more intel is recovered.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Removal of the Anti-Air is considered a high priority however the INTEL contained within the crashed drone is essential to the possible identification of enemy movement patterns in that region of %1.</t>"
		};
		iconType = "attack";
		chevronTitle = "Operation Phase 1";
		textArguments[] = {"worldName","randomCode","datetime","factionBLUlong","factionOPFlong","factionOPFshort"};
	};
	class Environment {
		time = "Dusk";
		force = 1;
	};
	class ChildTasks {};
};
class Phase2_DroneIntel {
	// _intelRecieved
};
class Phase2_AA_Battery_1 {
	// _targetsKilled
};
class Phase2_AA_Battery_2 {
	// _targetsKilled
};
class Phase2_CivIntel {
	// _intelRecieved
};
class Phase2_Cache_1 {
	// _targetsKilled
};
class Phase2_Cache_2 {
	// _targetsKilled
};