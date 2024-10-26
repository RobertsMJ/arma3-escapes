// Object composition created and exported with Map Builder
// See www.map-builder.info - Map Builder by NeoArmageddon
// Call this script by [Position, Rotation] execVM "filename.sqf"

params ["_center", "_rotation", ["_static", objNull, [objNull]], ["_vehicle", objNull, [objNull]]];

[_center, 25] call a3e_fnc_cleanupTerrain;

private _objects = [];
private _pos = [];
if (!(isNull _vehicle)) then {
	_pos = [_center, _center vectorAdd [-1.19421, -9.90234, 0.000301838], _rotation] call A3E_fnc_rotatePosition;
	_vehicle setDir ((getDir _vehicle) + _rotation);
	_vehicle setVectorUp surfaceNormal _pos;
	_vehicle setPosATL _pos;
};

_pos = [_center, _center vectorAdd [6.06116, -3.30908, 0], _rotation] call A3E_fnc_rotatePosition;
private _obj = "Land_BagBunker_Tower_F" createVehicle _pos;
_obj setDir ((getDir _obj) + _rotation + 180);
_obj setVectorUp surfaceNormal _pos;
_obj setPosATL _pos;
_objects pushBack _obj;

if (!(isNull _static)) then {
	_pos = [_center, _center vectorAdd [6.75, -1.3, 2.75], _rotation] call A3E_fnc_rotatePosition;
	// _static setVectorDirAndUp [[0.0308489, 0.999524, 0], [0, 0, 1]];
	_static setDir ((getDir _static) + _rotation);
	_static setVectorUp surfaceNormal _pos;
	_static setPosATL _pos;
};

_pos = [_center, _center vectorAdd [-4.17871, -2.42529, 0], _rotation] call A3E_fnc_rotatePosition;
_obj = "Land_HBarrier_5_F" createVehicle _pos;
_obj setDir ((getDir _obj) + _rotation + 90);
_obj setVectorUp surfaceNormal _pos;
_obj setPosATL _pos;
_objects pushBack _obj;

_pos = [_center, _center vectorAdd [-4.18518, -2.42969, 1.29559], _rotation] call A3E_fnc_rotatePosition;
_obj = "Land_HBarrier_5_F" createVehicle _pos;
_obj setDir ((getDir _obj) + _rotation + 90);
_obj setVectorUp surfaceNormal _pos;
_obj setPosATL _pos;
_objects pushBack _obj;

_pos = [_center, _center vectorAdd [-4.33887, 4.98438, -0.200378], _rotation] call A3E_fnc_rotatePosition;
_obj = "Land_Razorwire_F" createVehicle _pos;
_obj setDir ((getDir _obj) + _rotation + 90);
_obj setVectorUp surfaceNormal _pos;
_obj setPosATL _pos;
_objects pushBack _obj;

_pos = [_center, _center vectorAdd [3.70532, 5.08203, -0.222816], _rotation] call A3E_fnc_rotatePosition;
_obj = "Land_Razorwire_F" createVehicle _pos;
_obj setDir ((getDir _obj) + _rotation + 90);
_obj setVectorUp surfaceNormal _pos;
_obj setPosATL _pos;
_objects pushBack _obj;

// weapons
private ["_box", "_weaponCount"];

// Basic Weapon Box
private _weapons = [];
private _weaponMagazines = [];

// Launchers
for "_i" from 0 to (count a3e_arr_AmmoDepotLaunchers - 1) do {
	private ["_handGunItem", "_weaponClassName", "_probabilityOfPrecence", "_minCount", "_maxCount", "_magazines", "_magazinesPerWeapon"];

	_handGunItem = a3e_arr_AmmoDepotLaunchers select _i;

	_weaponClassName = _handGunItem select 0;
	_probabilityOfPrecence = _handGunItem select 1;
	_minCount = _handGunItem select 2;
	_maxCount = _handGunItem select 3;
	_magazines = _handGunItem select 4;
	_magazinesPerWeapon = _handGunItem select 5;

	    // Only include common launchers
	if (random 100 <= _probabilityOfPrecence && _probabilityOfPrecence > 50) then {
		_weaponCount = floor (_minCount + random (_maxCount - _minCount));
		_weapons pushBack [_weaponClassName, _weaponCount];

		for "_j" from 0 to (count _magazines) - 1 do {
			_weaponMagazines pushBack [_magazines select _j, _weaponCount * _magazinesPerWeapon];
		};
	};
};

if (count _weapons > 0 || count _weaponMagazines > 0) then {
	private _pos = [_center, _center vectorAdd [7, -5.5, 0], _rotation] call A3E_fnc_rotatePosition;
	_box = createVehicle ["Box_East_Wps_F", _pos, [], 0, "CAN_COLLIDE"];
	clearWeaponCargoGlobal _box;
	clearMagazineCargoGlobal _box;
	clearItemCargoGlobal _box;
	clearBackpackCargoGlobal _box;

	{
		_box addWeaponCargoGlobal _x;
	} forEach _weapons;

	{
		_box addMagazineCargoGlobal _x;
	} forEach _weaponMagazines;
	_objects pushBack _box;
};

_objects;