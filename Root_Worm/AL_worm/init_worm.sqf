// ORIGINALLY CREATED BY ALIAS
// MODIFIED BY ROOT 
// The WORM DEMO
// Tutorial: https://www.youtube.com/user/aliascartoons

/*

================================================================================================================================
WORM Parameters =======================
================================================================================================================================
null = [marker_name]execvm "AL_worm\worm.sqf"

marker_name	- string, name of the marker where you want to place the anomaly

*/
	

params ["_logic"];
if (isNil "WORM_markerIndex") then { WORM_markerIndex = 0 };
_wormmarkerName = format ["WORM_%1", WORM_markerIndex];
WORM_markerIndex = WORM_markerIndex + 1;
_wormmarker = createMarker [_wormmarkerName, _logic];
deleteVehicle _logic;
[_wormmarkerName] execVM "\Root_Anomalies\Root_Worm\AL_worm\worm_main.sqf";

// ["Worm Created!"] call zen_common_fnc_showMessage;
["Anomaly Configured", "Anomaly has been configured and created!", 10] call BIS_fnc_curatorHint;