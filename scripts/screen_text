//Important:
//To use this script you must provide credit to the Authors on your Workshop page of the map you use this in
//Authors: IceGrenade

//Difficulty to Implement = 2/10 (This code snippet is not for beginners, some prior knowledge is assumed)
//[0=Easy-10=Advanced]

//Instructions:
//Thread this wherever you would like to print to the screen

thread screen_text ("^1This is a message on screen", 2, 2 );

//Modify the Message content
//Use ^1 to change the colour of the text to red
//Colour codes: ^1 red, ^2 green, ^3 yellow, ^4 blue, ^5 light blue, ^6 = purple, ^7 = white, ^8 Dark Blue, ^9 = grey, ^0 = black

//Place this at the bottom of your mapname.gsc
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
