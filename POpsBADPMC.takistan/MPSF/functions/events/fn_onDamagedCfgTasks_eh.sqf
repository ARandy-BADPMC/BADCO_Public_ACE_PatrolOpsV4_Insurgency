_params params [["_objects",[],[objNull,[]]],["_attributes",[],[[]]]];

if (typeName _objects isEqualTo typeName objNull) then { _objects = [_objects]; };

{
	_x setVariable ["MPSF_Taskmanager_taskAttr",_attributes,true];
	_x addEventHandler ["HandleDamage",{
		params ["_object","_hitSelection","_damage","_source","_projectile","_hitPartIndex","_instigator","_hitPoint"];
		if !((damage _object + _damage)  < 1 && alive _object && canMove _object) then {
			private _attributes = _object getVariable ["MPSF_Taskmanager_taskAttr",[]];
			["onTaskObjectDestroyed",[_object,_attributes],2] call MPSF_fnc_triggerEventHandler;
		};
		_damage
	}];
} forEach _objects;

true;