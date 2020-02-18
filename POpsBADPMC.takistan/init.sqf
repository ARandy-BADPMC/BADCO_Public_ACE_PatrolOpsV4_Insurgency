if !(isMultiplayer) then {
	OnMapSingleClick "vehicle player setVehiclePosition [[_pos select 0, _pos select 1, if( (vehicle player) isKindof ""AIR"" && isEngineOn (vehicle player) ) then { 100 }else{ 0 } ],[],0,""None""]";
	player allowDamage false;
	player setCaptive false;
};