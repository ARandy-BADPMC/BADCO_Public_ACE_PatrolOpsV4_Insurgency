#define ICONNATO(natoIcon) ("\a3\ui_f\data\Map\Markers\NATO\" + natoIcon + ".paa")
params [["_size",0,[0]],["_fullPath",true,[false]]];

private _typeSuffix = switch (_size) do {
//	case (_size > 120000) : { "group_11" };	// Army		Group 120k+
//	case (_size > 100000) : { "group_10" };	// Army		100k
//	case (_size > 30000) : { "group_9" };	// Corps	30k-60k
//	case (_size > 10000) : { "group_8" };	// Division	10k-20k
//	case (_size > 2000) : { "group_7" };	// Brigade	2k-10k
//	case (_size > 500) : { "group_6" };		// Regiment	500-2k
//	case (_size > 300) : { "group_5" };		// Battalion	300-1k
	case (_size > 60) : { "group_4" };		// Company	60-250
	case (_size > 10) : { "group_3" };		// Platoon	20-60
	case (_size > 5) : { "group_2" };		// Section	5-20
	case (_size > 3) : { "group_1" };		// Patrol	3-5
	default { "group_0" };					// FireTeam	0-2
};

if (_fullPath) then { ICONNATO(_typeSuffix); } else { _typeSuffix };