//Important:
//To use this script you must provide credit to the Authors on your Workshop page of the map you use this in
//Authors: IceGrenade
//This script features on the Skylands V2 Map by IceGrenade

//Difficulty to Implement = 4/10 (This code snippet is not for beginners, some prior knowledge is assumed)
//[0=Easy-10=Advanced]

//Instructions:
//Place a trigger_use in the map with a targetname of 'wings_trigger'
//Disable debugger if you are happy with it
//Set the parameters, wing sound and model
//Thread this in the main() function at the bottom

level.wingsModel = "wings_model";
level.wingsSound = "wings_sound_name";
level.wingsTriggerName = "wings_trigger"
level.wingsGravity = 630;
level.wingsBoost = 170;
level.debug = true;
thread iceGrenade_GetWings();

//Place this at the bottom of your mapname.gsc
function iceGrenade_GetWings();
{
    wings = GetEnt(level.wingsTriggerName, "targetname");
    wings SetHintString("Get Wings");
    wings SetCursorHint("HINT_NOICON");
    wings waittill("trigger", player);
    if( player.wings != true )
    {
        player PlaySound(level.wingsSound);
        wait 3;
        player Attach(level.wingsModel, "tag_origin");
        player thread iceGrenade_HasWings();
    }
}

function iceGrenade_HasWings()
{
    self endon("death");
    self.wings = true;
    self.oldGravity = 800;
    self SetPlayerGravity(level.wingsGravity);

    while(1)
    {
        while(!self IsOnGround() && !self IsOnLadder())
        {
            if(self JumpButtonPressed())
            {
                if(level.debug)
                    IPrintLn("Jump Activated");
                self SetVelocity(self GetVelocity() + (0,0,level.wingsBoost));
                break;
            }
            wait 0.05;
        }
        WAIT_SERVER_FRAME;
    }
}
