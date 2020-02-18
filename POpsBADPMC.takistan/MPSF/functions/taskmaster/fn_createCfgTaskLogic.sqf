params [["_position",[0,0,0],[[]]],["_taskID","",[""]]];

private _taskLogic = [_position] call MPSF_fnc_createLogic;
_taskLogic setVehicleVarName _taskID; // TODO: Execute on every client
missionNamespace setVariable [_taskID,_taskLogic];
publicVariable _taskID;
// Variables
_taskLogic setVariable ["MPSF_Module_Task_F",true,true];
_taskLogic;