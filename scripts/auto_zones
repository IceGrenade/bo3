//Description
//When users walk into certain trigger multiples you can enable zones to open,
//allowing you to remove doors from areas to make zoning more fluid

//Important
//To use this script you must provide credit to the Authors on your Workshop page of the map you use this in
//Authors: IceGrenade

//Difficulty to Implement = 2/10 (This code snippet is not for beginners, some prior knowledge is assumed)
//[0=Easy-10=Advanced]

//Instructions
//Add trigger_multiple triggers into your map with targetname equal to the zone flag

//Example Zone Flag Setup
function usermap_test_zone_init()
{
	zm_zonemgr::add_adjacent_zone("start_zone", "zone2", "zone2flag");
	zm_zonemgr::add_adjacent_zone("zone2",      "zone3", "zone3flag");
	level flag::init( "always_on" );
	level flag::set( "always_on" );
}	

//Place this at the bottom of your Main() function before the closing bracket }
thread ice_AutoZones();

//Place this at the bottom of your mapname.gsc
function ice_AutoZones()
{
	thread triggerZone("zone2flag"); //example targetname of trigger_multiple
	thread triggerZone("zone3flag");
}

function triggerZone(ztarg)
{
	runit = GetEnt( ztarg, "targetname");
	runit waittill("trigger", player);
	level flag::set( ztarg );
	break;
}
