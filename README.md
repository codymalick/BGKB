BGKB
====
Version .01
Battleground Killing Blow
WoW Add-On for tracking killstreaks, playing sounds upon killing players, HKs, and Death.

To Install:
1. Copy BGKB folder to WoW Add-on Directory (usually C:\Program Files\World of Warcraft\Interface\Addons)
2. Login to WoW
3. Click Add-Ons in character select
4. Check BGKB
5. Login and have fun!

Version .03
Removed duplicated on pvp_kills_changed, added Deathstreak
functionality, fixed death sounds. Added counter for pvp_kills_update
because it was firing twice on one honorable kill.

Version .02
Added BG detection, activation and deactivation of mod sounds are now based on being in or out of a BG. 
Removed extra output to the console, added messages for entering and leaving BG.

Version .01
Basic Add-on functions work. On killing anything, sound clips play. Currently, no sound clips included in git. Planning on adding default game sounds for easy installation and use. 

Current functionality:
  Console log of each killing blow
  Kill streak counter (Works on anything, adding player only functionality later)
  Death streak counter (ends after getting a killing blow)
  Plays specified files in BGKB.lua, need to add dynamic list creation. 
  
