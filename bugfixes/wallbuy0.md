The Wallbuy 0 Bug is a mischevious one that not many people realise is easy to fix

Solution: Rename the level common weapon file and everywhere where it is referenced.

Details: Take a copy of your usermaps gsc and csc from your share/raw/scripts/zm/ folder
Place them into your usermaps/mapname/scripts/zm/
Put a reference to your usermaps & replace the levelcommon reference with the new file name one:
```csv
stringtable,gamedata/weapons/zm/zm_fallguys_weapons.csv
scriptparsetree,scripts/zm/zm_usermap.gsc
scriptparsetree,scripts/zm/zm_usermap.csc
```
Overall this means update the references in:
```
mapname.gsc
mapname.csc
usermaps.gsc
usermaps.csc
mapname.zone
```
Done!

E.g. I changed mine to zm_fallguys_weapons. Now I will never have broken wallbuys in my maps and players will not need to restart from the 0 purchase bug!


Worth Checking out This Video on Adding / Removing Weapons from Vertasea!
https://www.youtube.com/watch?v=YseEEao4CmA
