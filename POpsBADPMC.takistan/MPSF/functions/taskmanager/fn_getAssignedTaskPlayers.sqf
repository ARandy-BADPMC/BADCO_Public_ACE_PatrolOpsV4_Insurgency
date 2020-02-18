params [["_taskID","",[""]]];

allPlayers select {([_x] call BIS_fnc_taskCurrent) isEqualTo _taskID};