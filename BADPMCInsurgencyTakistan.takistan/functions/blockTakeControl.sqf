_vehicle = _this select 0;
_role = _this select 1;
_copilot = _this select 2;
_SOAR = missionNamespace getVariable ["SOAR",[]];
_playerType = typeOf _copilot;

if ((_copilot in _SOAR) && (_playerType == "rhsusf_army_ocp_helipilot" )) then 
	{
	} else 
	{
		[_vehicle,false] remoteexec ["enableCopilot"];
	};