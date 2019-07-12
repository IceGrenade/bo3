//Important:
//To use this script you must provide credit to the Authors on your Workshop page of the map you use this in
//Authors: IceGrenade

//This code snippet is not for beginners, some prior knowledge is assumed

//Instructions:
//Place this at the bottom of your Main() function before the closing bracket (})

thread ice_Credit();

//Modify the Message content
//Use ^1 to change the colour of the text to red
//Colour codes: ^1 red, ^2 green, ^3 yellow, ^4 blue, ^5 light blue, ^6 = purple, ^7 = white, ^8 Dark Blue, ^9 = grey, ^0 = black

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

function screen_text(text,font_scale,fade_time)
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
    hud.x = 0;
    hud.y = hud.y - 100;
    hud.alpha = 1;
    hud SetText(text);
    wait(2);
    hud fadeOverTime(fade_time);
    hud.alpha = 0;
    wait(fade_time);
    hud Destroy();
}
