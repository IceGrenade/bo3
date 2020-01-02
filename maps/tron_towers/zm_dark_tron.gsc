#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\compass;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#insert scripts\zm\_zm_utility.gsh;

#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;

#using scripts\shared\ai\zombie_utility;

//Perks
#using scripts\zm\_zm_pack_a_punch;
#using scripts\zm\_zm_perks;
#insert scripts\zm\_zm_perks.gsh;
#using scripts\zm\_zm_pack_a_punch_util;
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
//#using scripts\zm\_zm_powerup_weapon_minigun;

//Traps
#using scripts\zm\_zm_trap_electric;

#using scripts\zm\zm_usermap;
// NSZ Ambient Sounds
#using scripts\_NSZ\nsz_ambient_sounds;

#using scripts\zm\_zm_weap_staff_fire;
#using scripts\zm\_zm_weap_tomahawk;


// NSZ Hitmarkers
#using scripts\_NSZ\nsz_hitmarkers;


//Buyable Ending
#using scripts\zm\ugxmods_buyable_ending;

//Soulboxes
//#using scripts\zm\growing_soulbox;

// NSZ Custom Powerups
#using scripts\_NSZ\nsz_powerup_time_warp;
#using scripts\_NSZ\nsz_powerup_fast_feet;
#using scripts\_NSZ\nsz_powerup_bottomless_clip;
#using scripts\_NSZ\nsz_powerup_money;


//// WARDOGSK93: Start
// 3arc Perks
#using scripts\zm\_zm_perk_electric_cherry;
#using scripts\zm\_zm_perk_widows_wine;
#using scripts\wardog\perk\_wardog_perk_phd;
#using scripts\wardog\perk\_wardog_perk_tombstone;
#using scripts\wardog\perk\_wardog_perk_vulture;
#using scripts\wardog\perk\_wardog_perk_fizz;

// Core
#using scripts\wardog\wardog_addon;
#using scripts\wardog\wardog_callback;
#using scripts\wardog\perk\_wardog_perk_hud;
//// WARDOGSK93: End

//// xSanchez78: Start
// Whos Who
#using scripts\zm\_zm_perk_chugabud;
//// xSanchez78: End

//*****************************************************************************
// MAIN
//*****************************************************************************

function main()
{
    wardog_addon::pre_init();
	zm_usermap::main();
	difficulty = 1;
    column = int(difficulty) + 1;
    
    zombie_utility::set_zombie_var( "zombie_spawn_delay",                 1.0,    true,    column );
    zombie_utility::set_zombie_var( "zombie_new_runner_interval",          10,    false,    column );
    zombie_utility::set_zombie_var( "zombie_move_speed_multiplier",       18,    false,    column );
    zombie_utility::set_zombie_var( "zombie_move_speed_multiplier_easy",  18,    false,    column );
    zombie_utility::set_zombie_var( "zombie_max_ai",                     32,        false,    column );
    zombie_utility::set_zombie_var( "zombie_ai_per_player",             6,        false,    column );

    //FX
    precache_fx();
    
    wardog_addon::init();
    level.register_offhand_weapons_for_level_defaults_override = &offhand_weapon_overrride;
    level._zombie_custom_add_weapons = &custom_add_weapons;
    level.giveCustomCharacters = &giveCustomCharacters;
    level._chugabud_post_respawn_override_func = &chugabud_post_respawn_func;

	level thread nsz_ambient_sounds::init();
	
    //Raised perk limit
    level.perk_purchase_limit = 12;

	level._zombie_custom_add_weapons =&custom_add_weapons;
    //Pack-a-Punch Camo Revalations
    level.pack_a_punch_camo_index = 84; 
    level.pack_a_punch_camo_index_number_variants = 4;

    //Custom Start Score
	level.player_starting_points = 500;
	//Setup the levels Zombie Zone Volumes
	level.zones = [];
	level.zone_manager_init_func =&usermap_test_zone_init;
	init_zones[0] = "start_zone";
	level thread zm_zonemgr::manage_zones( init_zones );
    //Voxes
    level thread add_zm_vox();

	level.pathdist_type = PATHDIST_ORIGINAL;

	thread eeDoor();
    //Custom Weapon
    level.start_weapon = (getWeapon("pistol_fiveseven"));


    thread point1();
    thread point2();
    thread point3();
    thread point4();
    thread point5();
    thread credit();

    //Nudge change
    level zm_perks::spare_change();
}

function usermap_test_zone_init()
{
	zm_zonemgr::add_adjacent_zone("start_zone", "z2", "ez2");
    zm_zonemgr::add_adjacent_zone("z2", "z3", "ez3");
    zm_zonemgr::add_adjacent_zone("z3", "z4", "ez4");
    zm_zonemgr::add_adjacent_zone("z4", "z5", "ez5");
    zm_zonemgr::add_adjacent_zone("z5", "z6", "ez6");
    zm_zonemgr::add_adjacent_zone("z6", "z7", "ez7");
    zm_zonemgr::add_adjacent_zone("z7", "z8", "ez8");
    zm_zonemgr::add_adjacent_zone("z8", "z9", "ez9");
    zm_zonemgr::add_adjacent_zone("z9", "z10", "ez10");
    zm_zonemgr::add_adjacent_zone("z10", "z11", "ez11");
    zm_zonemgr::add_adjacent_zone("z11", "z12", "ez12");
    zm_zonemgr::add_adjacent_zone("z12", "z13", "ez13");
    zm_zonemgr::add_adjacent_zone("z13", "z14", "ez14");
    zm_zonemgr::add_adjacent_zone("z14", "z15", "ez15");
    zm_zonemgr::add_adjacent_zone("z15", "z16", "ez16");
	zm_zonemgr::add_adjacent_zone("z16", "z17", "ez17");
    zm_zonemgr::add_adjacent_zone("z17", "z18", "ez18");
    zm_zonemgr::add_adjacent_zone("z18", "z19", "ez19");
    zm_zonemgr::add_adjacent_zone("z19", "z20", "ez20");
    zm_zonemgr::add_adjacent_zone("z20", "z21", "ez21");
    zm_zonemgr::add_adjacent_zone("z21", "z22", "ez22");
    zm_zonemgr::add_adjacent_zone("z22", "z23", "ez23");
    zm_zonemgr::add_adjacent_zone("z23", "z24", "ez24");
	zm_zonemgr::add_adjacent_zone("z24", "z25", "ez25");
	zm_zonemgr::add_adjacent_zone("z25", "z26", "ez26");
    zm_zonemgr::add_adjacent_zone("z26", "z27", "ez27");
    zm_zonemgr::add_adjacent_zone("z27", "z28", "ez28");
    zm_zonemgr::add_adjacent_zone("z28", "z29", "ez29");
    zm_zonemgr::add_adjacent_zone("z29", "z30", "ez30");
    zm_zonemgr::add_adjacent_zone("z30", "z31", "ez31");
    zm_zonemgr::add_adjacent_zone("z31", "z32", "ez32");
    zm_zonemgr::add_adjacent_zone("z32", "z33", "ez33");
    zm_zonemgr::add_adjacent_zone("z33", "zlastc", "ezlast");
    zm_zonemgr::add_adjacent_zone("z33", "zlastd", "ezlast");
    zm_zonemgr::add_adjacent_zone("z33", "zlastb", "ezlast");
    zm_zonemgr::add_adjacent_zone("z33", "zlasta", "ezlast");
	level flag::init( "always_on" );
	level flag::set( "always_on" );
}	

function custom_add_weapons()
{
	zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_levelcommon_weapons.csv", 1);
}

function precache_fx()
{
    level._effect["zapper"]             = "dlc0/factory/fx_elec_trap_factory";
    level._effect["zapper_light_ready"]     = "maps/zombie/fx_zombie_light_glow_green";
    level._effect["zapper_light_notready"]      = "maps/zombie/fx_zombie_light_glow_red";
    level._effect["elec_room_on"]           = "fx_zombie_light_elec_room_on";
    level._effect["elec_md"]            = "zombie/fx_elec_player_md_zmb";
    level._effect["elec_sm"]            = "zombie/fx_elec_player_sm_zmb";
    level._effect["elec_torso"]         = "zombie/fx_elec_player_torso_zmb";
    level._effect["powerup_grabbed_red"]    = "zombie/fx_powerup_grab_red_zmb";
}

function credit()
{
	level flag::wait_till( "initial_blackscreen_passed" );
    wait 3;
    thread better_print ("^9Made by ^5IceGrenade!", 0, 0, 3, 3 );
    wait 5;
    thread better_print ("^9YouTube.com/^5IceGrenade ^9for new maps!", 0, 0, 2, 3 );
	while(1)
	{

            iPrintLn("made by YouTube.com/IceGrenade");
            wait 45;
            iPrintLn("Free Map Making Tutorials @ YouTube.com/IceGrenade");
            wait 45;
	}
}

//Voxes
function add_zm_vox()
{
 zm_audio::loadPlayerVoiceCategories("gamedata/audio/zm/zm_vox.csv");
}

function eeDoor()
{
    level.itemsRequired = 5;
    level.itemsCollected = 0;
    level thread item1();
    level thread item2();
    level thread item3();
    level thread item4();
    level thread item5();
}
 
function item1()
{
    trig1 = GetEnt("eetrig1", "targetname");
    obj1 = GetEnt("eeitem1", "targetname");
    trig1 SetHintString("");
    trig1 SetCursorHint("HINT_NOICON");
    while(1)
    {
        trig1 waittill("trigger", player);
        PlayFX(level._effect["powerup_grabbed_red"], trig1.origin);
        trig1 PlaySound("boobeep");
        player.score += 1000;
        level.itemsCollected++;
        thread eeCheckDone(player);
        break;
    }
    trig1 Delete();
    obj1 Delete();
}
 
function item2()
{
    trig2 = GetEnt("eetrig2", "targetname");
    obj2 = GetEnt("eeitem2", "targetname");
    trig2 SetHintString("");
    trig2 SetCursorHint("HINT_NOICON");
    while(1)
    {
        trig2 waittill("trigger", player);
        PlayFX(level._effect["powerup_grabbed_red"], trig2.origin);
        trig2 PlaySound("boobeep");
        player.score += 1000;
        level.itemsCollected++;
        thread eeCheckDone(player);
        break;
    }
    trig2 Delete();
    obj2 Delete();
}
 
function item3()
{
    trig3 = GetEnt("eetrig3", "targetname");
    obj3 = GetEnt("eeitem3", "targetname");
    trig3 SetHintString("");
    trig3 SetCursorHint("HINT_NOICON");
    while(1)
    {
        trig3 waittill("trigger", player);
        PlayFX(level._effect["powerup_grabbed_red"], trig3.origin);
        trig3 PlaySound("boobeep");
        player.score += 1000;
        level.itemsCollected++;
        thread eeCheckDone(player);
        break;
    }
    trig3 Delete();
    obj3 Delete();
}
 
function item4()
{
    trig4 = GetEnt("eetrig4", "targetname");
    obj4 = GetEnt("eeitem4", "targetname");
    trig4 SetHintString("");
    trig4 SetCursorHint("HINT_NOICON");
    while(1)
    {
        trig4 waittill("trigger", player);
        PlayFX(level._effect["powerup_grabbed_red"], trig4.origin);
        trig4 PlaySound("boobeep");
        player.score += 1000;
        level.itemsCollected++;
        thread eeCheckDone(player);
        break;
    }
    trig4 Delete();
    obj4 Delete();
}
 
function item5()
{
    trig5 = GetEnt("eetrig5", "targetname");
    obj5 = GetEnt("eeitem5", "targetname");
    trig5 SetHintString("");
    trig5 SetCursorHint("HINT_NOICON");
    while(1)
    {
        trig5 waittill("trigger", player);
        PlayFX(level._effect["powerup_grabbed_red"], trig5.origin);
        trig5 PlaySound("boobeep");
        player.score += 1000;
        level.itemsCollected++;
        thread eeCheckDone(player);
        break;
    }
    trig5 Delete();
    obj5 Delete();
}
 
function eeCheckDone(player)
{
    while(1)
    {
        self waittill(level.shootablesCollected >= level.itemsRequired);
        if(level.itemsCollected == level.itemsRequired)
        {
            eedoor2 = GetEnt("eedoor1", "targetname");
            IPrintLnBold("Barrier Unlocked!");
            eedoor2 PlaySound("boobeepend");
            wait 5;
            IPrintLnBold("Epic bruh!");
            eedoor2 Delete();
        }
        break;
    }
}

function point1()
{
    points1 = GetEnt("points1", "targetname");
    points1o = GetEnt("points1o", "targetname");
    points1 waittill("trigger", player);
    PlayFX(level._effect["powerup_grabbed_red"], points1.origin);
    points1 PlaySound("success");
    player.score += 700;
    points1 Delete();
    points1o Delete();
}

function point2()
{
    points2 = GetEnt("points2", "targetname");
    points2o = GetEnt("points2o", "targetname");
    points2 waittill("trigger", player);
    PlayFX(level._effect["powerup_grabbed_red"], points2.origin);
    points2 PlaySound("success");
    player.score += 1000;
    points2 Delete();
    points2o Delete();
}

function point3()
{
    points3 = GetEnt("points3", "targetname");
    points3o = GetEnt("points3o", "targetname");
    points3 waittill("trigger", player);
    PlayFX(level._effect["powerup_grabbed_red"], points3.origin);
    points3 PlaySound("success");
    player.score += 1300;
    points3 Delete();
    points3o Delete();
}

function point4()
{
    points4 = GetEnt("points4", "targetname");
    points4o = GetEnt("points4o", "targetname");
    points4 waittill("trigger", player);
    PlayFX(level._effect["powerup_grabbed_red"], points4.origin);
    points4 PlaySound("success");
    player.score += 2000;
    points4 Delete();
    points4o Delete();
}

function point5()
{
    points5 = GetEnt("points5", "targetname");
    points5o = GetEnt("points5o", "targetname");
    points5 waittill("trigger", player);
    PlayFX(level._effect["powerup_grabbed_red"], points5.origin);
    points5 PlaySound("success");
    player.score += 1600;
    points5 Delete();
    points5o Delete();
}

function offhand_weapon_overrride()
{
    level.zombie_lethal_grenade_player_init = GetWeapon("frag_grenade");
    level.zombie_melee_weapon_player_init = level.weaponBaseMelee;
    level.zombie_equipment_player_init = undefined;

    zm_utility::register_lethal_grenade_for_level("frag_grenade");
    zm_utility::register_melee_weapon_for_level(level.weaponBaseMelee.name);
    zm_utility::register_tactical_grenade_for_level("cymbal_monkey");
    zm_utility::register_tactical_grenade_for_level("octobomb");
}

function giveCustomCharacters()
{
    if(isdefined(level.hotjoin_player_setup) && [[level.hotjoin_player_setup]]("c_zom_farmgirl_viewhands" ))
        return;

    self DetachAll();
    if(!isdefined(self.characterIndex))
        self.characterIndex = zm_usermap::assign_lowest_unused_character_index();

    self.favorite_wall_weapons_list = [];
    self.talks_in_danger = false;

    self SetCharacterBodyType(self.characterIndex);
    self SetCharacterBodyStyle(0);
    self SetCharacterHelmetStyle(0);

    switch(self.characterIndex)
    {
        case 0:
            self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = GetWeapon("frag_grenade");
            self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = GetWeapon("bouncingbetty");
            self.whos_who_shader = "c_zom_der_dempsey_mpc_fb";
            break;

        case 1:
            self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = GetWeapon("870mcs");
            self.whos_who_shader = "c_zom_der_nikolai_mpc_fb";
            break;

        case 3:
            self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = GetWeapon("hk416");
            self.whos_who_shader = "c_zom_der_takeo_mpc_fb";
            break;

        case 2:
            self.talks_in_danger = true;
            level.rich_sq_player = self;
            level.sndRadioA = self;
            self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size ] = GetWeapon("pistol_standard");
            self.whos_who_shader = "c_zom_der_richtofen_mpc_fb";
            break;
    }

    self SetMoveSpeedScale(1);
    self SetSprintDuration(4);
    self SetSprintCooldown(0);

    self thread zm_usermap::set_exert_id();
}

function chugabud_post_respawn_func( v_new_player_position )
{
    weapon_powerup_array = [];
    keys = GetArrayKeys(level.zombie_powerups);

    for(i = 0; i < keys.size; i++)
    {
        if(isdefined(level._custom_powerups) && isdefined(level._custom_powerups[keys[i]]) && isdefined(level._custom_powerups[keys[i]].weapon_countdown))
            weapon_powerup_array[weapon_powerup_array.size] = keys[i];
    }

    weapon_powerup = undefined;

    if(isdefined(self.loadout))
    {
        for(i = 0; i < self.loadout.weapons.size; i++)
        {
            for(j = 0; j < weapon_powerup_array.size; j++)
            {
                if(self.loadout.weapons[i]["weapon"] == level.zombie_powerup_weapon[weapon_powerup_array[j]])
                {
                    weapon_powerup = weapon_powerup_array[j];
                    break;
                }
            }
        }
    }
    if(isdefined(weapon_powerup))
    {
        level thread zm_powerups::weapon_powerup_remove(self, weapon_powerup + "_time_over", weapon_powerup, false);

        weapons = [];
        index = 0;

        for(i = 0; i < self.loadout.weapons.size; i++)
        {
            if(self.loadout.weapons[i]["weapon"] == level.zombie_powerup_weapon[weapon_powerup])
                continue;

            weapons[index] = self.loadout.weapons[i];
            index++;
        }

        self.loadout.weapons = weapons;
        if(isdefined(self._zombie_weapon_before_powerup) && isdefined(self._zombie_weapon_before_powerup[weapon_powerup]))
        {
            current_weapon = self._zombie_weapon_before_powerup[weapon_powerup];

            for(i = 0; i < self.loadout.weapons.size; i++)
            {
                if(self.loadout.weapons[i]["weapon"] == current_weapon || self.loadout.weapons[i]["weapon"].altWeapon == current_weapon)
                {
                    self.loadout.current_weapon = i;
                    break;
                }
            }
        }
    }
}

function better_print( text, align_x, align_y, font_scale, fade_time )
{
    hud = NewHudElem();
    hud.foreground = true;
    hud.fontScale = font_scale;
    hud.sort = 1;
    hud.hidewheninmenu = false;
    hud.alignX = "center";
    hud.alignY = "middle";
    hud.horzAlign = "center";
    hud.vertAlign = "middle";
    hud.x = align_x;
    hud.y = hud.y - align_y;
    hud.alpha = 1;
    hud SetText( text );
    wait( 2 );
    hud fadeOverTime( fade_time );
    hud.alpha = 0;
    wait( fade_time );
    hud Destroy();
}
