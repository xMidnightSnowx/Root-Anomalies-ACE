// ORIGINALLY CREATED BY ALIAS
// MODIFIED BY ROOT
/*
[marker_namer, territory, damage_inflicted, recharge_delay, health_points] execVM "\Root_Anomalies\Root_Farmer\AL_farmer\init_farmer.sqf";
marker_namer		- string, name of the marker where you want the anomaly to spawn
territory			- number, radius in meters of Farmer's territory
damage_inflicted	- number, amount of damage inflicted by Farmer's shock wave
recharge_time		- number, delay in seconds between Farmer's attacks see line 47 in al_steamer.sqf if you want to customize even more the delay between attacks
health_points		- number, amount of health farmer has
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

if (isnil "FARMER_markerindex") then { FARMER_markerindex = 0 };

_farmermarkername = format ["FARMER_%1", FARMER_markerindex];
FARMER_markerindex = FARMER_markerindex + 1;
_farmermarker = createMarker [_farmermarkername, _radiuspos];
deleteVehicle _logic;

["Farmer Anomaly Settings",[
	["EDIT",["Farmer Health","Amount of damage the Farmer takesa before being killed."],["400"]],
	["SLIDER:RADIUS",["Farmer Territory","Radius in meters of the Farmer's territory."],[100,5000,200,0,_radiuspos,[7,120,32,1]]],
	["SLIDER:PERCENT",["Farmer Damage","Percentage amount of damage the Farmer does to his target."],[0,1,0.6,2]],
	["SLIDER",["Farmer Recharge Delay","Delay in seconds between Farmer's attacks."],[3,60,5,0]]
	],{
		params ["_results", "_farmermarkername"];
		_results params ["_farmer_hp", "_farmer_territory", "_farmer_damage", "_farmer_recharge"];
		
		_farmer_hp = parseNumber _farmer_hp;
		_farmer_hp = round _farmer_hp;

		// ["Farmer Anomaly Configured and Created!"] call zen_common_fnc_showMessage;
		// [objNull, "Farmer Anomaly Configured and Created!"] call BIS_fnc_showCuratorFeedbackMessage;

		["Anomaly Configured", "Anomaly has been configured and created!", 10] call BIS_fnc_curatorHint;

		[_farmermarkername, _farmer_territory, _farmer_damage, _farmer_recharge, _farmer_hp] execVM "\Root_Anomalies\Root_Farmer\AL_farmer\farmer_main.sqf";
	},{
		// ["Aborted"] call zen_common_fnc_showMessage;
		["Aborted", "Anomaly configuration aborted!", 10] call BIS_fnc_curatorHint;
		playSound "FD_Start_F";
	}, _farmermarkername] call zen_dialog_fnc_create;

