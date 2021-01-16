badcoDynamicSimApply = 
{
	_object = _this select 0;

	sleep 20;
	if (simulationEnabled _object && {!((typeof _object) in ["Land_Net_Fence_Gate_F", "Land_BackAlley_01_l_gate_F", "Land_Wrench_F"])}) then {
		_object enableDynamicSimulation true;
	};
};