private ["_key", "_index"];
_key = "var";
if(isNil "_this") then {
    _key = _this;
};
_index = call AVD_fnc_getIndex;
format["%1_%2", _key, _index];
