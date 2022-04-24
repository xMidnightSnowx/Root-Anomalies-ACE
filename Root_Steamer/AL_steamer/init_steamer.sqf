// ORIGINALLY CREATED BY ALIAS
// MODIFIED BY ROOT 
/*
[marker_namer,territory,damage_inflicted,recharge_delay] execVM "\Root_Anomalies\Root_Steamer\AL_steamer\steamer_main.sqf";


marker_namer		- string, name of the marker where you want the anomaly to spawn
territory			- number, radius in meters of Streamer's territory
damage_inflicted	- number, amount of damage inflicted by Streamer's burst
recharge_delay		- number, delay in seconds between Streamer's attacks
*/

private _hasZen = isClass (configFile >> "CfgPatches" >> "zen_custom_modules");
if !(_hasZen) exitwith
{
    diag_log "******CBA and/or ZEN not detected. They are required for this mod.";
};

if (!hasinterface) exitwith {};

params ["_logic"];

private _radiuspos = getPosATL _logic;
private _pos = getPosATL (_this#0);

if (isNil "STEAMER_markerIndex") then { STEAMER_markerIndex = 0 };

_steamermarkerName = format ["STEAMER_%1", STEAMER_markerIndex];
STEAMER_markerIndex = STEAMER_markerIndex + 1;
_steamermarker = createMarker [_steamermarkerName, _logic];
deleteVehicle _logic;

["Steamer Anomaly Settings",[
	["SLIDER:RADIUS",["Steamer Territory","Radius in meters of the Steamer's territory."],[100,5000,200,0,_radiuspos,[7,120,32,1]]],
	["SLIDER:PERCENT",["Steamer Damage","Percentage amount of damage the Steamer does to his target."],[0,1,0.6,2]],
	["SLIDER",["Steamer Recharge Delay","Delay in seconds between Steamer's attacks."],[3,60,5,0]]
	],{
		params ["_results", "_steamermarkerName"];
		_results params ["_steamer_territory", "_steamer_damage", "_steamer_recharge"];
		
		// ["Steamer Anomaly Configured and Created!"] call zen_common_fnc_showMessage;
		["Anomaly Configured", "Anomaly has been configured and created!", 10] call BIS_fnc_curatorHint;

		[_steamermarkerName, _steamer_territory, _steamer_damage, _steamer_recharge] execVM "\Root_Anomalies\Root_Steamer\AL_steamer\steamer_main.sqf";
	},{
		// ["Aborted"] call zen_common_fnc_showMessage;
		["Aborted", "Anomaly configuration aborted!", 10] call BIS_fnc_curatorHint;
		playSound "FD_Start_F";
	}, _steamermarkerName] call zen_dialog_fnc_create;