/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_animateUnit.sqf
	Credit: ACE3 MOD

	Description:
		Sets an Animation for a unit

	Parameter(s):
		0: Object - Target to animate
		1: STRING - Animation Move

	Returns:
		Bool - True when done
*/
params [["_target",objNull,[objNull]],["_animation","",[""]]];

// switchMove "" no longer works in dev 1.37
if (_animation == "") exitWith {false};

// try playMoveNow first
_target playMoveNow _animation;

// if animation doesn't respond, do switchMove
if (animationState _target != _animation) then {
	_target switchMove _animation;
};

true;