fnc_buzzInOut = 
{
	playMusic ["buzzer",0];
	sleep 0.5;
	arsenal_gate animate ["door_1_rot", 1];
	sleep 2;
	arsenal_gate animate ["door_1_rot", 0];
};