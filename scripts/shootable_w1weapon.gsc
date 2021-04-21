/*
	Important: To use this script you must provide credit to the Authors on your Workshop page of the map you use this in
	Authors: xReaction

	Difficulty to Implement = 4 (This code snippet is not for beginners, some prior knowledge is assumed)[0=Easy-10=Advanced]
	
	Details
			This is a script that implements a trigger that can ONLY BE SHOT BY ONE WEAPON
			The weapon can be changed to whatever you want it to be (look in zm_levelcommon_weapons.csv for weapon names)

	Instructions:
			1. Change the "pistol_standard" in the weapon_to_shoot_with variable to whatever gun you want it to be shot with
			(default MR6)
			2. Add a model/ brushmodel in the map with the targetname shootable_1weap_model
			3. Add a trigger_damage, over the model/ brushmodel, with the targetname shootable_1weap_trig
			Note: trigger MUST be trigger_damage otherwise it will not work properly!
				  a. It's also worth ticking EXPLOSION_NO on the trigger_damage so it isn't set off by grenades, this will stop all
				  explosive weapons though so you can decide if you want it on or not
				  b. If you have any problems/ questions message me on Discord xReaction#7551 or twitter @SFLReaction

	
*/

//Place this at the bottom of your Main() function before the closing bracket (})
thread shootable1Weapon();


//Place these functions at the bottom of your mapname.gsc
function shootable1Weapon()
{
	shootable_1weap_trig = GetEnt("shootable_1weap_trig", "targetname");
	shootable_1weap_model = GetEnt("shootable_1weap_model", "targetname");
	//Define what weapon you want the trigger to be shot with below, check in the weapon levelcommon for weapon names and
	//replace "pistol_standard" with whatever. currently its set to the starting pistol (MR6)
	weapon_to_shoot_with = "pistol_standard";
	level flag::wait_till("initial_blackscreen_passed");
	//Setting up a while loop here so whenever its shot with the wrong gun it doesnt just end
	while(1)
	{
		shootable_1weap_trig waittill("trigger", player);
		player_weapon = player GetCurrentWeapon();
		//IPrintLnBold( "current player weapon is: ");
		//IPrintLnBold( player_weapon.name );
		WAIT_SERVER_FRAME;
		if( player_weapon.name == weapon_to_shoot_with || player_weapon.name == weapon_to_shoot_with+"_upgraded" )
		{
			player thread modelShot(shootable_1weap_model, shootable_1weap_trig);
			//We break here so the while loop ends and it doesnt continue waiting for a shot from a weapon.
			break;
		}
		else
		{
			//Do something here if you shot it with the wrong weapon
			//IPrintLnBold("that aint the weapon g...");
		}
	}
}

function modelShot(model, trigger)
{
	//This is where you script what you want to happen after you shoot it
	//I've just made it so it plays the cha ching sound and gives the player who shot it points
	//but the possibilities are endless!

	//IPrintLnBold("OW I'VE BEEN SHOT");
	self PlayLocalSound("zmb_cha_ching");
	model Delete();
	trigger Delete();
	self.score += 500;
}
