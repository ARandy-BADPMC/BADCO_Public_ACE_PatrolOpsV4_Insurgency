/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_initEventHandler.sqf
	Author(s): see mpsf\credits.txt

	Description:
		This is a system that manages the reactive event system
*/
if (hasInterface) then {
	[] spawn {
		private _customEvents = {
			if (alive player) then {
				// Event Handler: Vehicle Player moved position
				private _vehicle = vehicle player;
				private _oldPosition = missionNamespace getVariable ["MPSF_Player_var_previousPositionASL",[0,0,0]];
				private _oldDistance = missionNamespace getVariable ["MPSF_Player_var_distanceTraveled",0];
				private _newPosition = getPosASL _vehicle;
				private _incrementalDistance = _newPosition distance _oldPosition;
				private _vehicleDistance = switch (true) do {
					case (_vehicle isKindOf "CaManBase") : { 150 };
					case (_vehicle isKindOf "Ship");
					case (_vehicle isKindOf "Helicopter");
					case (_vehicle isKindOf "Land") : { 500 };
					case (_vehicle isKindOf "Air") : { 5000 };
					default { 100 };
				};
				if (_incrementalDistance > _vehicleDistance) then {
					missionNamespace setVariable ["MPSF_Player_var_previousPositionASL",_newPosition];
					missionNamespace setVariable ["MPSF_Player_var_distanceTraveled",_oldDistance + _incrementalDistance];
					["HasMoved",[_oldPosition,_newPosition,round(_oldDistance + _incrementalDistance),round(_incrementalDistance)],true] call MPSF_fnc_triggerEventHandler;
				};
				// Event Handler: Player UAV Connection State Change
				private _oldUAV = missionNamespace getVariable ["MPSF_Player_var_connectedUAV",objNull];
				private _newUAV = getConnectedUAV player;
				if !(_oldUAV == _newUAV) then {
					if !(isNull _oldUAV) then {
						["UAVdisconnected",[player,_oldUAV],true] call MPSF_fnc_triggerEventHandler;
					};
					if !(isNull _newUAV) then {
						["UAVconnected",[player,_newUAV],true] call MPSF_fnc_triggerEventHandler;
					};
					missionNamespace setVariable ["MPSF_Player_var_connectedUAV",_newUAV];
				};
			};
			false;
		};
		["MPSF_ClientEH_onEachFrame","onEachFrame",{['onEachFrame',_this,true] call MPSF_fnc_triggerEventHandler;}] call BIS_fnc_addStackedEventHandler;
		["MPSF_Custom_EH","onEachFrame",_customEvents] call MPSF_fnc_addEventHandler;

		waitUntil { !(isNull player) };
		if (count(missionNamespace getVariable ["MPSF_Player_var_previousPositionASL",[]]) == 0) then {
			missionNamespace setVariable ["MPSF_Player_var_previousPositionASL",getPosASL player];
		};

		player addEventHandler ["Fired",				{["onFired",_this,true] call MPSF_fnc_triggerEventHandler;}];
		player addEventHandler ["HandleDamage",			{["onHandleDamage",_this,true,true] call MPSF_fnc_triggerEventHandler;}];
		player addEventHandler ["HandleRating",			{["onHandleRating",_this,true] call MPSF_fnc_triggerEventHandler;}];
		player addEventHandler ["GetInMan",				{["onGetIn",_this,true] call MPSF_fnc_triggerEventHandler;}];
		player addEventHandler ["GetOutMan",			{["onGetOut",_this,true] call MPSF_fnc_triggerEventHandler;}];
		player addEventHandler ["SeatSwitchedMan",		{["onSeatSwitch",[_this select 0,(assignedVehicleRole (_this select 0)) param [0,""],_this select 2],true] call MPSF_fnc_triggerEventHandler;}];
		player addEventHandler ["Killed",				{["onKilled",_this,true] call MPSF_fnc_triggerEventHandler;}];
		["MPSF_onRespawn_workaround_EH","onKilled",{
			_this spawn {
				waitUntil {alive player};
				["onRespawn",[player,(_this select 0)],true] call MPSF_fnc_triggerEventHandler;
			};
		}] call MPSF_fnc_addEventHandler;
		//player addEventHandler ["Respawn",			{["onRespawn",_this,true] call MPSF_fnc_triggerEventHandler;}];
		player addEventHandler ["Put",					{["onPutItem",_this,true] call MPSF_fnc_triggerEventHandler;}];
		player addEventHandler ["Take",					{["onTakeItem",_this,true] call MPSF_fnc_triggerEventHandler;}];
		player addEventHandler ["TaskSetAsCurrent",		{["onTaskAssign",_this,true] call MPSF_fnc_triggerEventHandler;}];
		addmissioneventhandler ["draw3d",				{["draw3D",[],true] call MPSF_fnc_triggerEventHandler;}];
		addMissionEventHandler ["EntityKilled",			{["onKilledGlobal",_this,true] call MPSF_fnc_triggerEventHandler;}];
		addMissionEventHandler ["EntityRespawned",		{["onRespawnGlobal",_this,true] call MPSF_fnc_triggerEventHandler;}];
		//player addEventHandler ["Hit",				{}];
		//player addEventHandler ["WeaponAssembled",	{}];
		//player addEventHandler ["WeaponDisassembled",	{}];
		//player addEventHandler ["PostReset",			{}];
		//player addEventHandler ["SoundPlayed",		{}];
		//player addEventHandler ["FiredNear",			{}];
		//player addEventHandler ["Explosion",			{}];
		//player addEventHandler ["animchanged",		{}];
	};
	[] spawn {
		waitUntil{ !isNull (findDisplay 46) };
		(findDisplay 46) displayAddEventHandler ["KeyDown",			{['KeyDown',_this,true] call MPSF_fnc_triggerEventHandler;}];
		(findDisplay 46) displayAddEventHandler ["KeyUp",			{['KeyUp',_this,true] call MPSF_fnc_triggerEventHandler;}];
		(findDisplay 46) displayAddEventHandler ["MouseButtonDown",	{['MouseButtonDown',_this,true] call MPSF_fnc_triggerEventHandler; false;}];
		(findDisplay 46) displayAddEventHandler ["MouseButtonUp",	{['MouseButtonUp',_this,true] call MPSF_fnc_triggerEventHandler; false;}];
		(findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw",{if (visibleMap) then { ['MapDraw',_this,true] call MPSF_fnc_triggerEventHandler; }; false;}];
		(findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["MouseMoving",{missionNamespace setVariable ["MPSF_MAP_CURSORPOS",(_this select 0) ctrlMapScreenToWorld [(_this select 1),(_this select 2)]];}];
	};
} else {
	["MPSF_ServerEH_onEachFrame","onEachFrame",{['onEachFrame',_this,true] call MPSF_fnc_triggerEventHandler;}] call BIS_fnc_addStackedEventHandler;
};