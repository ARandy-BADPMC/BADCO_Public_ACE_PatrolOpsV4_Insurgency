/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getHeadlessClients.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Returns all active headless clients
*/
(allMissionObjects "HeadlessClient_F") select {isPlayer _x};