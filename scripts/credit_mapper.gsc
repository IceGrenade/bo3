//Important:
//To use this script you must provide credit to the Authors on your Workshop page of the map you use this in
//Authors: IceGrenade

//Difficulty to Implement = 3/10 (This code snippet is not for beginners, some prior knowledge is assumed)
//[0=Easy-10=Advanced]

//Requires the following functions:
//https://github.com/IceGrenade/bo3/blob/master/scripts/screen_text.gsc

//Instructions:
//Place this at the bottom of your Main() function before the closing bracket (})
thread ice_Credit();

//Place this at the bottom of your mapname.gsc
function ice_Credit()
{
    //Modify these messages to suit your needs
    start_message1 = "^1Welcome to my map";
    start_message2 = "^1Map Name";
    start_message3 = "^1Enjoy this challenge";
    start_message4 = "^1Don't forget to Upvote :)";
    looping_message1 = "Made by Bob";
    looping_message2 = "Buy me coffee and you will be loved";
    
    level flag::wait_till( "initial_blackscreen_passed" );
    wait 3;
    thread screen_text (start_message1, 2, 2 );
    wait 3;
    thread screen_text (start_message2, 2, 2 );
    wait 3;
    thread screen_text (start_message3, 2, 3 );
    wait 3;
    thread screen_text (start_message4, 2, 3 );
    wait 4;
    while(1)
    {
        iPrintLn(looping_message1);
        wait 60;
        iPrintLn(looping_message2);
        wait 60;
    }
}
