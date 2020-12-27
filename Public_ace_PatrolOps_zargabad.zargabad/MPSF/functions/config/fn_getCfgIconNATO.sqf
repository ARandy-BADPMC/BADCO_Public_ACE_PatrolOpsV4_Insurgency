#define ICONNATO(natoIcon) ("\a3\ui_f\data\Map\Markers\NATO\" + natoIcon + ".paa")
params [["_object","",["",objNull]],["_fullPath",true,[false]]];

private _sideIndex = [[_object] call BIS_fnc_objectSide] call BIS_fnc_sideID;
private _sidePrefix = ["O_","B_","N_"] select (0 max _sideIndex min 2);
private _typeSuffix = switch (true) do {
	case (_object isKindOf "CaManBase") : {"inf"};
	case (_object isKindOf "StaticMortar") : {"mortar"};
	case (getnumber(configFile >> "CfgVehicles" >> typeof _object >> "isUAV") > 0) : {"uav"};
	case (getNumber(configFile >> "CfgVehicles" >> typeOf _object >> "transportRepair") > 0) : {"maint"};
	case (getNumber(configFile >> "CfgVehicles" >> typeOf _object >> "transportAmmo") > 0) : {"service"};
	case (getNumber(configFile >> "CfgVehicles" >> typeOf _object >> "transportFuel") > 0) : {"support"};
	case (getNumber(configFile >> "CfgVehicles" >> typeOf _object >> "attendant") > 0) : {"med"};
	case ("Artillery" in getArray(configFile >> "CfgVehicles" >> typeOf _object >> "availableForSupportTypes")) : {"art"};
	case (_object isKindOf "Car") : {"motor_inf"};
	case (_object isKindOf "Tank") : {"armor"};
	case (_object isKindOf "Ship") : {"naval"};
	case (_object isKindOf "Helicopter") : {"air"};
	case (_object isKindOf "Plane") : {"plane"};
	case (_object isKindOf "ModuleHQ_F") : {"hq"};
	default {"unknown"};
};

private _icon = format["%1%2",_sidePrefix,_typeSuffix];
if (_fullPath) then { ICONNATO(_icon); } else { _icon };