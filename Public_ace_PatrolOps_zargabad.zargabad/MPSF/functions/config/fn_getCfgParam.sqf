params [["_param",0,["",0]],["_default",0,["",0]]];

switch (typeName _default) do {
	case (typeName 0) : {
		[_param,_default] call BIS_fnc_getParamValue;
	};
	case (typeName "") : {
		private _texts = ["params",_param,"texts"] call MPSF_fnc_getCfgDataArray;
		private _values = ["params",_param,"values"] call MPSF_fnc_getCfgDataArray;
		private _value = [_param,0] call BIS_fnc_getParamValue;
		_texts param [_values find _value,""];
	};
	default {_default};
};