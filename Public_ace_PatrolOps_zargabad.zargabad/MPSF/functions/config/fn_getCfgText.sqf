params [["_object","",["",objNull]]];

if (_object isEqualType objNull) then {
	_object = typeOf _object;
};
if (_object isEqualTo "") exitWith { "" };

private _class = "";
{
	if (isClass (configFile >> _x >> _object)) exitWith {
		_class = toLower _x;
	};
} forEach ["CfgWeapons","CfgMagazines","CfgAmmo","CfgVehicles","CfgGlasses","CfgItems","cfgGroupIcons","CfgMarkers"];

if(_class isEqualTo "") exitWith {
	//format ["Detect Config text Error of %1",_object] call BIS_fnc_error;
	"";
};

if (_class isEqualTo "cfggroupicons") exitWith {
	getText (configFile >> _class >> _object >> "picture");
};

getText (configFile >> _class >> _object >> "displayName");