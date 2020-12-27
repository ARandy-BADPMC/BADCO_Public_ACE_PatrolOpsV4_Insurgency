_params params [["_objects",[],[objNull,[]]],["_attributes",[],[[]]],["_explosion",false,[false]]];

if (typeName _objects isEqualTo typeName objNull) then { _objects = [_objects]; };

{
	_x setVariable ["MPSF_Taskmanager_taskAttr",_attributes,true];
	_x setVariable ["explodeBig",_explosion,true];
	_x addEventHandler ["HandleDamage",{
		params ["_object","_hitSelection","_damage","_source","_projectile","_hitPartIndex","_instigator","_hitPoint"];
		private _return = count ((_projectile splitString "-_") arrayIntersect ["DemoCharge","SatchelCharge","Remote","TimeBombCore"]);
		if (_return > 0) then {
			private _attributes = _object getVariable ["MPSF_Taskmanager_taskAttr",[]];
			if (_object getVariable ["explodeBig",false]) then {
				[getPosWorld _object,6 + random 6,false] spawn MPSF_fnc_effectExplosionSecondaries;
			};
			_object setDamage 1;
			["onTaskObjectDestroyed",[_object,_attributes],2] call MPSF_fnc_triggerEventHandler;
			deleteVehicle _object;
		};
		0;
	}];
} forEach _objects;

true;