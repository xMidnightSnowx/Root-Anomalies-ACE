// ORIGINALLY CREATED BY ALIAS
// MODIFIED BY ROOT 
/*
[object_name,territory_radius,throwable_class_name,damage_inflicted] execvm "\Root_Anomalies\Root_Swarmer\AL_swarmer\swarmer_main.sqf";

object_name			 - string, the name of the object you use as start location for SWARMER
territory_radius	 - number, radius of territory in meters
throwable_class_name - string, class name of the throwable item you want to use as pesticide
damage_inflicted	 - number, the amount of damage SWARMER inflicts with his attacks
*/

private _hasZen = isClass (configFile >> "CfgPatches" >> "zen_custom_modules");
if !(_hasZen) exitwith
{
    diag_log "******CBA and/or ZEN not detected. They are required for this mod.";
};

if (!hasinterface) exitwith {};

params ["_logic"];

_swarmerloc = getPosATL _logic;
deleteVehicle _logic;

["Swarmer Anomaly Settings",[
	["EDIT",["Swarmer Hive Object","Classname of the object used to spawn the Swarmer."],["Land_GarbageBags_F"]],
	["SLIDER:RADIUS",["Swarmer Territory","Radius in meters of the Swarmer's territory."],[100,5000,200,0,_swarmerloc,[7,120,32,1]]],
	["EDIT",["Pesticide Object","Classname of the object used to kill the Swarmer."],["SmokeShellGreen"]],
	["SLIDER:PERCENT",["Swarmer Damage","Percentage amount of damage the Swarmer does to his target."],[0,1,0.6,2]]
	],{
		params ["_results", "_swarmerloc"];
		_results params ["_swarmerobject", "_swarmer_territory", "_pesticideobject", "_swarmerdamage"];
		
		_swarmerhive = _swarmerobject createVehicle _swarmerloc;

		// ["Swarmer Anomaly configured and active!"] call zen_common_fnc_showMessage;
		["Anomaly Configured", "Anomaly has been configured and created!", 10] call BIS_fnc_curatorHint;

		[_swarmerhive, _swarmer_territory, _pesticideobject, _swarmerdamage] execVM "\Root_Anomalies\Root_Swarmer\AL_swarmer\swarmer_main.sqf";
	},{
		// ["Aborted"] call zen_common_fnc_showMessage;
		["Aborted", "Anomaly configuration aborted!", 10] call BIS_fnc_curatorHint;
		playSound "FD_Start_F";
	}, _swarmerloc] call zen_dialog_fnc_create;

