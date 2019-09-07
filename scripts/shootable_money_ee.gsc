//Important:
//To use this script you must provide credit to the Authors on your Workshop page of the map you use this in
//Authors: IceGrenade

//Difficulty to Implement = 4/10 (This code snippet is not for beginners, some prior knowledge is assumed)
//[0=Easy-10=Advanced]

//Requires the following functions:
//https://github.com/IceGrenade/bo3/blob/master/scripts/screen_text.gsc

//Instructions:
// 1. Modify the Message content
//       Use ^1 to change the colour of the text to red
//       Colour codes: ^1 red, ^2 green, ^3 yellow, ^4 blue, ^5 light blue, ^6 = purple, ^7 = white, ^8 Dark Blue, ^9 = grey, ^0 = black
// 2. Place any number of script_models in radiant with the target name of 'gold'
// 3. hange the sound or add sound with alias of 'goldsound' for each shot gold, add sound for perk reward of 'weaponcycle'
// 4. (Optional) Set fx alias for shots and drops

//Place this at the bottom of your Main() function before the closing bracket (})
thread ice_Money();

//Place this at the bottom of your mapname.gsc
function ice_Money()
{
	goldmulti = GetEntArray("gold","targetname");
	level.gold = 0;
	level.totalgold = 0;
	foreach (gold in goldmulti)
	{
		gold thread givegold();
		level.totalgold += 1;
	}
}

function givegold()
{
	self setCanDamage(1);
	self waittill("damage", damage, attacker, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel);
	PlayFX(level._effect["powerup_grabbed_red"], self.origin);
	self PlaySound("goldsound");
	inflictor.score += 400;
	self Delete();
	level.gold += 1;
	thread screen_text ("^2Gold found: ^4"+level.gold+"/"+level.totalgold, 2, 1 );
	if(level.gold == 20)
		thread allperks();
	if(level.gold == level.totalgold)
	{
		i=0;
		wait 0.5;
		thread screen_text ("^1ALL GOLD FOUND!", 3, 2 );
		foreach (player in GetPlayers())
			player thread giveTotalReward();
	}
}

function giveTotalReward()
{
	i=0;
	while(i<100)
	{
		self PlaySound("goldsound");
		self.score += 300;
		i++;
		wait 0.05;
	}
}

function allperks()
{
	thread screen_text ("^1Free Perks Activated!", 3, 2 );
	perkplaces  = struct::get_array("perkplace", "targetname");
	player1 = GetPlayers()[0];
	player1 PlaySound("zmb_buildable_complete");
	foreach(perk in perkplaces)
	{
		zm_powerups::specific_powerup_drop( "free_perk", perk.origin);
		PlayFX(level._effect["powerup_grabbed_red"], perk.origin);
		wait 0.2;
	}
	player1 PlaySound("weapon_cycle");
}
