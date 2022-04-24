// ORIGINALLY CREATED BY ALIAS
// MODIFIED BY ROOT 
// Tutorial: https://www.youtube.com/user/aliascartoons

/*

================================================================================================================================
STRIGOI Parameters =======================
================================================================================================================================
[_marker_name,_territory,_day_activ,_inflicted_damage,_hp_strigoi] execvm "\Root_Anomalies\Root_Strigoi\AL_strigoi\strigoi_main.sqf"

_marker_name		- string, name of the marker where you want to place the anomaly
_territory			- number, meters, strigoi will move and be active only within boundaries of his territory
_day_activ			- boolean, if false strigoi will be active only at night, if tru he will be active both night and day
_inflicted_damage	- number, the amount of damage strigoi will inflict to his target during attack
_hp_strigoi			- number, strigois health points, as higher it is as resilient will be

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

if (isNil "STRIGOI_markerIndex") then { STRIGOI_markerIndex = 0 };

_strigoimarkerName = format ["STRIGOI_%1", STRIGOI_markerIndex];
STRIGOI_markerIndex = STRIGOI_markerIndex + 1;
_strigoimarker = createMarker [_strigoimarkerName, _logic];
deleteVehicle _logic;


["Strigoi Anomaly Settings",[
	["EDIT",["Strigoi Health","Amount of damage the Strigoi takesa before being killed."],["400"]],
	["SLIDER:RADIUS",["Strigoi Territory","Radius in meters of the Strigoi's territory."],[100,5000,200,0,_radiuspos,[7,120,32,1]]],
	["SLIDER:PERCENT",["Strigoi Damage","Percentage amount of damage the Strigoi does to his target."],[0,1,0.6,2]],
	["TOOLBOX:YESNO",["Night Mode Only","If true, Strigoi will only be active/spawned during night time."],false]
	],{
		params ["_results", "_strigoimarkerName"];
		_results params ["_strigoi_hp", "_strigoi_territory", "_strigoi_damage", "_isnightonly"];
		
		_strigoi_hp = parseNumber _strigoi_hp;
		_strigoi_hp = round _strigoi_hp;

		// ["Strigoi Anomaly Configured and Created!"] call zen_common_fnc_showMessage;
		["Anomaly Configured", "Anomaly has been configured and created!", 10] call BIS_fnc_curatorHint;

		[_strigoimarkerName, _strigoi_territory, _isnightonly, _strigoi_damage, _strigoi_hp] execVM "\Root_Anomalies\Root_Strigoi\AL_strigoi\strigoi_main.sqf";
	},{
		// ["Aborted"] call zen_common_fnc_showMessage;
		["Aborted", "Anomaly configuration aborted!", 10] call BIS_fnc_curatorHint;
		playSound "FD_Start_F";
	}, _strigoimarkerName] call zen_dialog_fnc_create;

