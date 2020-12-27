params [["_cfgTaskID","",[""]]];

if (_cfgTaskID isEqualTo "") exitWith { "" };

if ([_cfgTaskID] call BIS_fnc_taskExists || !(isNull (missionNamespace getVariable [_cfgTaskID,objNull]))) then {
	for "_i" from 1 to 999 do {
		private _testID = format["%1_%2",_cfgTaskID,_i];
		if !([_testID] call BIS_fnc_taskExists || !(isNull (missionNamespace getVariable [_testID,objNull]))) exitWith { _cfgTaskID = _testID; };
	};
};

_cfgTaskID;