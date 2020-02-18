// https://community.bistudio.com/wiki/Arma_3_Advanced_Hints_(Field_Manual)

class MPSF {
	displayName = "Mission";
	class VisualSettings {
		displayName = "Adjusting the View Settings";
		displayNameShort = "Adjusting View Settings";
		description = "Press %11 to step over low obstacle. Your %13 is %14";
		tip = "The free look represents turning the head sideways and up or down.";
		arguments[] = {
			{{"getOver"}}, // Double nested array means assigned key (will be specially formatted)
			{"name"}, // Nested array means element (specially formatted part of text)
			"name player" // Simple string will be simply compiled and called String is used as a link to localization database in case it starts by str_
		};
		//image = "\path\image_ca.paa";
		//noImage = false;
	};
};

class PatrolOps4 {
	displayName = "Patrol Ops";
	class BeginPO4 {
		displayName = "Introduction to Patrol Operations";
		displayNameShort = "Patrol Operations";
		description = "Patrol Operations is a team oriented mission that benefits from co-operative play.<br/>To begin, organise a group together, gear up and begin conducting patrols of areas outside the base.<br/>On patrol, anything can happen so be prepared for the inevitable enemy contact.<br/>Collect any intel you find through items, downloading or body searching to gain information on enemy operations.<br/>If enough intel is collected, an operation will be available that can be initiated from the Base.<br/>Operations can be long and difficult so ensure you have the necessary gear and support to begin one.";
		tip = "Speaking with Civilians can yield INTEL on where there are possible hostile combatants.";
		arguments[] = {
			{{"getOver"}}, // Double nested array means assigned key (will be specially formatted)
			{"name"}, // Nested array means element (specially formatted part of text)
			"name player" // string to compile or localization starts by str_
		};
		image = "\a3\ui_f\data\GUI\Cfg\Hints\BasicWalk_ca.paa";
		//noImage = false;
	};
	class PO4BeginArmoury {
		displayName = "Virtual Armoury Loadout";
		displayNameShort = "Virtual Armoury Loadout";
		description = "Succeeding on patrol falls heavily on your soldiers loadout.<br/>The Virtual armoury allows you to tailor your soldiers gear to ensure you have the best chance of completing your mission.<br/>There are however certain limits depending on what role you are within your squad. Missile Specialist Units have access to missiles and rockets however do not have access to Sniper Rifles, You get the idea...<br/>Gear up go begin your patrol.";
		tip = "Speak with your team leader about your assigned role.";
		image = "\a3\ui_f\data\GUI\Cfg\Hints\Firemode_ca.paa";
	};
	class PO4BeginDepot {
		displayName = "Virtual Vehicle Depot";
		displayNameShort = "Virtual Vehicle Depot";
		description = "Getting to the battlefield and providing support will ultimately determine your teams success.<br/><br/>The Virtual Depot will provide you access to the various vehicles available and any customised loadouts for the mission and it is up to you and your team to ensure they are deployed correctly.<br/><br/>Some vehicles may have limits on the number you can use or the loadouts they can carry (Jets DLC).";
		tip = "Do not enter the depot when it is already active.";
		image = "\a3\ui_f\data\GUI\Cfg\Hints\VehicleRepair_CA.paa";
	};
	class PO4BeginPatrol {
		displayName = "Conducting a Patrol";
		displayNameShort = "Conducting a Patrol";
		description = "The primary objective of patrolling is to identify and engage hostile forces while collecting any intel on their larger operations.<br/>The first part to any patrol is selecting the right area.<br/>Assess the terrain and location to ensure your team will have the upper hand in the event of an attack.<br/>Positioning near villages or towns will provide access to any intel civilians can provide if you have a good relationship with them.<br/>When on a patrol, keep an eye out for any potentially hostile forces and engage with discretion.";
		tip = "Speak with civilians to learn about enemy locations.";
		image = "\a3\ui_f\data\GUI\Cfg\Hints\BasicWalk_ca.paa";
	};
	class PO4BeginOperation {
		displayName = "Conducting an Operation";
		displayNameShort = "Mission Operations";
		description = "The primary objective of Patrol Ops is to complete as many disruptive operations against the opposing force.<br/>Operations are varied in their type and can yield unexpected outcomes. Be prepared for an operation that can be drawn out into a longer multi-staged mission as your team proceeds as the enemy have had substantial time to prepare a complex network of support and operational assets.<br/>Operations are accessible when enough intel is collected and are initiated or aborted from the mission command post at base. Only mission admins and possibly squad leaders are permitted to access and accept mission operations.";
		tip = "Operation Intel is not always accurate. Expect the unexpected in the field.";
		image = "\a3\ui_f\data\GUI\Cfg\Hints\BasicWalk_ca.paa";
	};
	class PO4BeginReviveMP {
		displayName = "Reviving the Injured";
		displayNameShort = "ReviveMP";
		description = "When a squad member receives an injury, they can be crippled and require urgent first aid to revive them before they bleed out.<br/><br/>Upon moving to the injured unit, the damage is represented as red icons that can be interacted with to provide first aid or to move the unit to a safer location before providing first aid.<br/>";
		tip = "Ensure the area is safe before assisting, otherwise you will be the next casualty.";
		image = "\a3\ui_f\data\GUI\Cfg\Hints\BasicWalk_ca.paa";
	};
	class PO4BeginIntel {
		displayName = "Mission Intelligence";
		displayNameShort = "Gathering Intel";
		description = "During the mission, you come across various types of ways to gather intel.<br/>Pick up dropped items<br>Download from terminals or devices<br/>Speaking with Civilians<br/>";
		tip = "";
		image = "\a3\ui_f\data\GUI\Cfg\Hints\BasicWalk_ca.paa";
	};
	class PO4BeginSquadmod {
		displayName = "Squad Management";
		displayNameShort = "Squadmod";
		description = "Join or create your own group, invite other players and form your own squad.";
		tip = "Press %11 to open/close the Squadmod interface";
		//tip = "Press %3CTRL +%4 %11 to toggle on/off the group markers";
		arguments[] = {{{TeamSwitch}}};
		image = "\A3\Ui_f\data\GUI\Cfg\Hints\Commanding_ca.paa";
	};
};