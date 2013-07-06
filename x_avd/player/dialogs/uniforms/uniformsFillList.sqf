private ["_items", "_uniforms"];  
_items = uniformItems player + vestItems player + backpackItems player + weapons player + magazines player + items player;

        _uniforms = [];
        {
            _type = [_x] call AVD_fnc_getUniformType;
            
            switch(_type) do {
              case "uniform": {
                  _uniforms = _uniforms + [_x];

              };
              
              case "vest": {
                  
              };
              
              case "headgear": {
                  
              };  
            };
            
            
        } foreach _items;
		
_size = count _uniforms;

for "_i" from 0 to (_size - 1) do
{
	private "_index";
	_displayName = getText(configFile >> "cfgWeapons" >> _uniforms select _i >> "displayName");
	_index = lbAdd [1500, format ["%1",_displayName]];
	lbSetData [1500, _index, _uniforms select _i];
};

waitUntil{
	private ["_indexLB", "_dataLB", "_str", "_cnt", "_side"];


	_indexLB = lbCurSel 1500;
	_dataLB = lbData [1500, _indexLB];
	_side = [_dataLB] call AVD_fnc_getSideByClass;
	_str = lbText [1500, _indexLB];
	_cnt = abs(round(_indexLB));
	ctrlSetText [1000, format ["Side: %1", _side]];
	dialogOpen == 0
};
