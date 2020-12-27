params [["_position",[0,0,0],[[]]],["_effectSize",3,[0]],["_effectOffset",[0,0,0],[[]]]];

if (_position isEqualTo [0,0,0]) exitWith { objNull };

private _effectType = ["\A3\data_f\ParticleEffects\Universal\Refract",1,0,1,0];
//["\A3\data_f\ParticleEffects\Universal\Universal",16,7,48,1]

private _effect = createvehicle ["#particlesource",_position,[],0,"can_collide"];
_effect setParticleParams [_effectType,"","Billboard",1,0.2,[0,0,0],[0,0,0],1,1.275,1,0,[_effectSize],[[0,0,0,0.0],[0,0,0,0.5],[0,0,0,0.0]],[1],0.1,0.05,"","","",0,false,0,[]];
_effect setParticleRandom [0,[0,0,0],[0,0,0],1,0.1,[0,0,0,0],0,0,1,0];
_effect setDropInterval 0.01;
_effect