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
// 2. Add a trigger in the map where this reward can be activated or comment out all 'gaperk' lines to have it reward instantly when called with thread iceGrenade_AllPerks();
// 3. Lines 25-35 Set whatever variables you like. Messages / trigger text / reward type / amount / sound

//Place this at the bottom of your Main() function before the closing bracket (})
thread iceGrenade_AllPerks();

//Place this at the bottom of your mapname.gsc
function iceGrenade_AllPerks()
{
    //Variables you can change to preference
    trigger_message = "Press &&1 to get all perks";
    activated_message = "^1Perk Reward Activated!";
    reward_amount_1 = 10000;
    reward_amount_2 = 8000;
    reward_amount_3 = 6000;
    reward_amount_4 = 5000;
    reward_type = "free_perk";
    sound_to_play = "zmb_cha_ching";
    if(!isDefined(level.perk_purchase_limit))
        level.perk_purchase_limit = 13;
    
    //Define trigger
    gaperks = GetEnt("all_perks_triggger", "targetname");
    gaperks SetCursorHint( "HINT_NOICON" ); 
    
    //Setup trigger
    gaperks SetHintString(trigger_message);
    gaperks waittill("trigger", player);
    gaperks SetHintString("");

    //Play Sound
    player PlaySound(sound_top_play);

    //Pick Random Reward Amount per Player
    pickNumber = RandomInt(3);
    foreach(player in GetPlayers())
    {
        if( pickNumber == 3 )
            player.score += reward_amount_1;
        else if( pickNumber == 2)
            player.score += reward_amount_2;
        else if( pickNumber == 1)
            player.score += reward_amount_3;
        else
            player.score += reward_amount_4;
    }

    //Activated Reward Message on-screen
    thread screen_text (activated_message, 2, 4 );

    //Give reward X perk limit set
    for (i = 0; i < level.perk_purchase_limit; i++)
        zm_powerups::specific_powerup_drop( reward_type, GetPlayers()[0].origin);
}
