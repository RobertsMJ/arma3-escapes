// Eden Object composition to SQF
// Export file
// Script by NeoArmageddon
// Call this script by [Position, Rotation] execVM "filename.sqf"

params ["_center", "_rotation", ["_static", objNull, [objNull]], ["_vehicle", objNull, [objNull]]];

[_center, 25] call a3e_fnc_cleanupTerrain;

private _fnc_createObject = {
	params["_className", "_centerPos", "_relativePos", "_rotateDir", "_relativeDir", ["_align", true]];
	private["_object", "_realPos"];
	_realPos = ([_centerPos, [(_centerPos select 0) + (_relativePos select 0), (_centerPos select 1) + (_relativePos select 1), (_relativePos select 2)], _rotateDir] call A3E_fnc_RotatePosition);
	_object = createVehicle [_className, _realPos, [], 0, "CAN_COLLIDE"];
	_object setDir (_relativeDir + _rotateDir);
	_object setPosATL _realPos;
	if (_align) then {
		_object setVectorUp surfaceNormal _realPos;
	};

	_object;
};

private _objects = [];
private _obj = objNull;

_obj = ["Land_BarGate_F", _center, [-0.390747, 0.391357, 0], _rotation, 179.988] call _fnc_createObject;
_objects pushBack _obj;
_obj = ["Land_BagFence_Round_F", _center, [4.34167, 1.79785, 0], _rotation, 133.29] call _fnc_createObject;
_objects pushBack _obj;
_obj = ["Land_BagFence_Round_F", _center, [4.18945, -1.17517, 0], _rotation, 50.8415] call _fnc_createObject;
_objects pushBack _obj;
_obj = ["Land_BagFence_Round_F", _center, [-4.90186, 1.49036, 0], _rotation, 230.789] call _fnc_createObject;
_objects pushBack _obj;
_obj = ["Land_BagFence_Round_F", _center, [-4.83887, -1.20178, 0], _rotation, 309.005] call _fnc_createObject;
_objects pushBack _obj;
_obj = ["Land_BagFence_End_F", _center, [5.64612, -2.0415, 0], _rotation, 5.37634] call _fnc_createObject;
_objects pushBack _obj;
_obj = ["Land_BagFence_End_F", _center, [-6.37781, -1.92725, 0], _rotation, 181.092] call _fnc_createObject;
_objects pushBack _obj;
_obj = ["Land_BagFence_End_F", _center, [5.98145, 2.48779, 0], _rotation, 5.37634] call _fnc_createObject;
_objects pushBack _obj;
_obj = ["Land_BagFence_End_F", _center, [-6.42041, 2.34607, 0], _rotation, 181.092] call _fnc_createObject;
_objects pushBack _obj;

if (!(isNull _static)) then {
	private _pos = [_center, _center vectorAdd [6.15918, 0.396851, -0.0121169], _rotation] call A3E_FNC_RotatePosition;
	_static setDir (269.87 + _rotation);
	_static setPosATL _pos;
};
if (!(isNull _vehicle)) then {
	private _pos = [_center, _center vectorAdd [-9.58679, 0.108887, 0.0323153], _rotation] call A3E_FNC_RotatePosition;
	_vehicle setDir (89.8637 + _rotation);
	_vehicle setPosATL _pos;
};

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
	private _pos = [_center, _center vectorAdd [-5, 1, 0], _rotation] call A3E_fnc_rotatePosition;
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