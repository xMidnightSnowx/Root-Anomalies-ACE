// ORIGINALLY CREATED BY ALIAS
// MODIFIED BY ROOT
fnc_teleportSFX_AI = {
    private ["_unit", "_ind"];
    _unit = _this select 0;
    _ind = 3;
    while {_ind>0} do {
        _unit hideObjectglobal true;
        sleep 0.2; _unit hideObjectglobal false;sleep 0.2;_ind = _ind-1
    };
};

if (!isServer) exitwith {};
_obj_teleporter = _this select 0;
_obj_core		= _this select 1;
_list_teleport=[];
_list_vek_teleport=[];

while {alive _obj_teleporter} do {
    _list_teleport = (position _obj_teleporter) nearEntities ["CAManBase", 15];
    if (protection_smug !="") then {
        if (count _list_teleport>0) then {
            {
                if ((headgear _x == protection_smug)or(goggles _x==protection_smug)or(uniform _x==protection_smug)or(vest _x==protection_smug)or(backpack _x==protection_smug) or (protection_smug in (assigneditems _x + items _x))) then {} else {
                    _fresh_spawn = _x getVariable "teleported_in";
                    if (isnil "_fresh_spawn") then {
                        [_obj_teleporter, ["tele_message", 100]] remoteExec ["say3D"];
                        [_x] call fnc_teleportSFX_AI;
                        if (isplayer _x) then {
                            [[_x, _obj_teleporter], "\Root_Anomalies\Root_Smuggler\AL_smuggler\smuggler_teleport_effect.sqf"] remoteExec ["execVM"]
                        } else {
                            _dest_tele = [getPos _obj_teleporter, 300, -1, 5, 0, 0.5, 0] call BIS_fnc_findSafePos;
                            _x setPos _dest_tele;
                            if (_x isKindOf "Man") then {
                                _bodyPart = ["Head", "RightLeg", "LeftArm", "Body", "LeftLeg", "RightArm"] selectRandomWeighted [0.3, 0.8, 0.65, 0.5, 0.8, 0.65];
                                _dmgtype = selectRandom ["backblast", "bite", "bullet", "explosive", "falling", "grenade", "punch", "ropeburn", "shell", "stab", "unknown", "vehiclecrash"];
                                [_x, 0.18, _bodyPart, _dmgtype] call ace_medical_fnc_adddamagetoUnit;
                            } else {
                                _currentDamage = getDammage _x;
								_newDamage = _currentDamage + random(0.25);
								_x setDamage _newDamage;
                            };
                        };
                    };
                };
            } forEach _list_teleport;
        };
    } else {
        {
            _fresh_spawn = _x getVariable "teleported_in";
            if (isnil "_fresh_spawn") then {
                [_obj_teleporter, ["tele_message", 100]] remoteExec ["say3D"];
                [_x] call fnc_teleportSFX_AI;
                if (isplayer _x) then {
                    [[_x, _obj_teleporter], "\Root_Anomalies\Root_Smuggler\AL_smuggler\smuggler_teleport_effect.sqf"] remoteExec ["execVM"]
                } else {
                    _dest_tele = [getPos _obj_teleporter, 300, -1, 5, 0, 0.5, 0] call BIS_fnc_findSafePos;
                    _x setPos _dest_tele;
                    if (_x isKindOf "Man") then {
                        _bodyPart = ["Head", "RightLeg", "LeftArm", "Body", "LeftLeg", "RightArm"] selectRandomWeighted [0.3, 0.8, 0.65, 0.5, 0.8, 0.65];
                        _dmgtype = selectRandom ["backblast", "bite", "bullet", "explosive", "falling", "grenade", "punch", "ropeburn", "shell", "stab", "unknown", "vehiclecrash"];
                        [_x, 0.18, _bodyPart, _dmgtype] call ace_medical_fnc_adddamagetoUnit;
                    } else {
                        _x setDamage ((getdammage _x) + (random 0.25));
                    };
                };
            };
        } forEach _list_teleport;
    };
    
    _list_vek_teleport = (position _obj_teleporter) nearEntities ["landvehicle", 15];
    if (count _list_vek_teleport>0) then {
        {
            _fresh_spawn = _x getVariable "teleported_in";
            if (isnil "_fresh_spawn") then {
                [_obj_teleporter, ["tele_message", 100]] remoteExec ["say3D"];
                [_x] call fnc_teleportSFX_AI;
                _dest_tele = [getPos _obj_teleporter, 300, -1, 5, 0, 0.5, 0] call BIS_fnc_findSafePos;
                _x setPos _dest_tele;
                _x setDamage ((getDammage _x) + (random 0.25));
            };
        } forEach _list_vek_teleport;
        _list_vek_teleport = [];
        _list_teleport=[];
    };
    sleep 2;
};