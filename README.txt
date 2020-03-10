Map Prefix Handler

To get started:
  1) Extract prefixes.zip into your sourcemod folder at "\SteamLibrary\steamapps\common\counter-strike source\cstrike\cfg\sourcemod"
  2) Store MPH.sp into your scripting folder at "\SteamLibrary\steamapps\common\counter-strike source\cstrike\addons\sourcemod\scripting"
  3) Store MPH.smx into your plugins folder at "\SteamLibrary\steamapps\common\counter-strike source\cstrike\addons\sourcemod\plugins"
  
To add prefixes to the recognized list:
  1) Follow comment guidelines in MPH.sp and compile the new file with http://www.sourcemod.net/compiler.php 
  2) Repeat steps 2 and 3 from getting started.
  
To edit loading/unloading plugins:
  1) Follow comment guidelines in any cfg file in the prefixes folder. 
     sm unload plugin timer        <- This will unload a plugin named timer
     sm load plugin timer          <- This will load a plugin named timer
  2) Save with the same naming scheme. *Any files not included in the .sp file will not be executed during runtime.
  
For any concerns, please send me a message on Discord.
c0meback#5600
