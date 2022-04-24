// ORIGINALLY CREATED BY ALIAS
// MODIFIED BY ROOT 
/*
[marker,territory_radius,damage_inflicted,health_points] execvm "\Root_Anomalies\Root_Flamer\AL_flamer\flamer_main.sqf";

marker				- string, name of the marker where you want to place the anomaly
territory_radius	- number, radius in meters of FLAMERs territory
damage_inflicted	- number, damage inflicted by FLAMERs main attack
health_points		- number, amount of health/hit points FLAMER has
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

if (isNil "FLAMER_markerIndex") then { FLAMER_markerIndex = 0 };

_flamermarkerName = format ["FLAMER_%1", FLAMER_markerIndex];
FLAMER_markerIndex = FLAMER_markerIndex + 1;
_flamermarker = createMarker [_flamermarkerName, _logic];
deleteVehicle _logic;


["Flamer Anomaly Settings",[
	["EDIT",["Flamer Health","Amount of damage the Flamer takesa before being killed."],["400"]],
	["SLIDER:RADIUS",["Flamer Territory","Radius in meters of the Flamer's territory."],[100,5000,200,0,_radiuspos,[7,120,32,1]]],
	["SLIDER:PERCENT",["Flamer Damage","Percentage amount of damage the Flamer does to his target."],[0,1,0.6,2]],
	["SLIDER",["Flamer Recharge Delay","Delay in seconds between Flamer's attacks."],[3,60,5,0]]
	],{
		params ["_results", "_flamermarkername"];
		_results params ["_flamer_hp", "_flamer_territory", "_flamer_damage", "_flamer_recharge"];
		
		_flamer_hp = parseNumber _flamer_hp;
		_flamer_hp = round _flamer_hp;

		// ["Flamer Anomaly Configured and Created!"] call zen_common_fnc_showMessage;
		["Anomaly Configured", "Anomaly has been configured and created!", 10] call BIS_fnc_curatorHint;

		[_flamermarkername, _flamer_territory, _flamer_damage, _flamer_recharge, _flamer_hp] execVM "\Root_Anomalies\Root_Flamer\AL_flamer\flamer_main.sqf";
	},{
		// ["Aborted"] call zen_common_fnc_showMessage;
		["Aborted", "Anomaly configuration aborted!", 10] call BIS_fnc_curatorHint;
		playSound "FD_Start_F";
	}, _flamermarkername] call zen_dialog_fnc_create;

