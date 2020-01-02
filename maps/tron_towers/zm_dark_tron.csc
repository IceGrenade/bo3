#using scripts\codescripts\struct;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#using scripts\zm\_load;
#using scripts\zm\_zm_weapons;

//Perks
#using scripts\zm\_zm_pack_a_punch;
#using scripts\zm\_zm_perk_additionalprimaryweapon;
#using scripts\zm\_zm_perk_doubletap2;
#using scripts\zm\_zm_perk_deadshot;
#using scripts\zm\_zm_perk_juggernaut;
#using scripts\zm\_zm_perk_quick_revive;
#using scripts\zm\_zm_perk_sleight_of_hand;
#using scripts\zm\_zm_perk_staminup;

//Powerups
#using scripts\zm\_zm_powerup_double_points;
#using scripts\zm\_zm_powerup_carpenter;
#using scripts\zm\_zm_powerup_fire_sale;
#using scripts\zm\_zm_powerup_free_perk;
#using scripts\zm\_zm_powerup_full_ammo;
#using scripts\zm\_zm_powerup_insta_kill;
#using scripts\zm\_zm_powerup_nuke;

//Traps
#using scripts\zm\_zm_trap_electric;

#using scripts\zm\zm_usermap;

#using scripts\zm\_zm_weap_staff_fire;
#using scripts\zm\_zm_weap_tomahawk;

//Custom
#using scripts\zm\_zm_perk_electric_cherry;
#using scripts\zm\_zm_perk_widows_wine;
#using scripts\wardog\perk\_wardog_perk_phd;
#using scripts\wardog\perk\_wardog_perk_tombstone;
#using scripts\wardog\perk\_wardog_perk_vulture;
#using scripts\wardog\perk\_wardog_perk_fizz;
#insert scripts\zm\_zm_perks.gsh;
#using scripts\wardog\wardog_addon;
#using scripts\zm\_zm_perk_chugabud;

//Trap
#precache( "client_fx", "dlc0/factory/fx_elec_trap_factory" );
#precache( "client_fx", "maps/zombie/fx_zombie_light_glow_green" );
#precache( "client_fx", "maps/zombie/fx_zombie_light_glow_red" );
#precache( "client_fx", "fx_zombie_light_elec_room_on" );
#precache( "client_fx", "zombie/fx_elec_player_md_zmb" );
#precache( "client_fx", "zombie/fx_elec_player_sm_zmb" );
#precache( "client_fx", "zombie/fx_elec_player_torso_zmb" );
#precache( "client_fx", "electric/fx_elec_sparks_burst_sm_circuit_os" );
#precache( "client_fx", "electric/fx_elec_sparks_burst_sm_circuit_os" );
#precache( "client_fx", "zombie/fx_powerup_on_green_zmb" );

function main()
{
	zm_usermap::main();

	callback::on_localclient_connect( &on_player_connect ); //Wait for the player to connect 
	util::waitforclient( 0 );

	include_weapons();
}

function include_weapons()
{
	zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_levelcommon_weapons.csv", 1);
}

function on_player_connect( localclientnum ) 
{   
	cam_01 = GetEnt( localclientnum, "cam_01", "targetname" );// add your script origin targetname
	cam_01 SetExtraCam( 0, 1920, 1080 ); //  add cam number / Activates the camera so it will be displayed on screen. 
}  
