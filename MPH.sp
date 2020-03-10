/* Map Prefix Handler
 * Filename        MPH.sp
 * Date            3/9/20
 * Author          c0meback
 * Version         1.0
 * Copyright       2020, All Rights Reserved
 *
 * Description
 *
 *    This plugin is a scalable implementation of prefix-influenced plugin management.
 *    On map start the appropriate config will load/unload specified plugins.
 */
 
#include <sourcemod>
#include <sdktools>

public Plugin:myinfo = {
	name = "Custom Map Configs",
	author = "c0meback",
	description = "Prefix-influenced plugin management.",
	version = "1",
	url = "N/A"
}

Handle mph_var = INVALID_HANDLE;

public OnPluginStart() {
	mph_var = CreateConVar("mph_var", "1" , "MPH plugin version", FCVAR_DONTRECORD|FCVAR_NOTIFY);  //initialize plugin
	SetConVarString(mph_var, "1" , false, false);                                                  //set plugin version
}

//Parse current map prefix
public OnMapStart() {
	char currentMap[PLATFORM_MAX_PATH];
	GetCurrentMap( currentMap, sizeof(currentMap) );
	LogMessage("Current map is %s", currentMap );
	stringParse( currentMap );
	LogMessage("Appropriate CFGs loaded.");
	return;
}

//Check for standard prefixes
void stringParse( const char[] map ) {
	
	if ( StrContains( map , "bhop_" , false ) > -1 ) {
		LogMessage("Loading bhop config file...");
		cfgLoad( "bhop.cfg" );
	}
	else if ( StrContains( map , "kz_" , false ) > -1 ) {
		LogMessage("Loading kz config file...");
		cfgLoad( "kz.cfg" ); 
	}
	else if ( StrContains( map , "cs_" , false ) > -1 ) {
		LogMessage("Loading hostage rescue config file...");
		cfgLoad( "cs.cfg" ); 
	}
	else if ( StrContains( map , "de_" , false ) > -1 ) {
		LogMessage("Loading defuse config file...");
		cfgLoad( "de.cfg" ); 
	}
	else if ( StrContains( map , "surf_" , false ) > -1 ) {
		LogMessage("Loading surf config file...");
		cfgLoad( "surf.cfg" ); 
	}
	/*  Any additional cases must follow this format and have a cfg file in cfg/sourcemod/prefixes/ 
	 *
	 *	else if ( StrContains( map , "EXAMPLE_PREFIX_" , false ) > -1 ) {
	 *		LogMessage("Loading EXAMPLE_PREFIX config file...");
	 *		cfgLoad( "EXAMPLE_PREFIX.cfg" ); 
	 *
	 *	}
	 */
	else {
		LogMessage("Unrecognized prefix for %s", map );
		cfgLoad( "default.cfg" );
	}

	return;
}

//Open and execute appropriate cfg files
void cfgLoad( const char[] prefix ) {
	char cfg[PLATFORM_MAX_PATH];
	Format( cfg , sizeof(cfg) , "addons/sourcemod/configs/prefix/" );            //builds a path string in cfg
	Handle path = OpenDirectory(cfg);                                            //attempt to iterate to the directory
	
	if ( path == INVALID_HANDLE ) {
		LogMessage( "Error navigating to %s!", cfg );
		return;
	}

	char cfgContents[PLATFORM_MAX_PATH];
	FileType type;

	while (ReadDirEntry( path, cfgContents , sizeof( cfgContents ) , type ) ) {  //execute cfg according to naming scheme
		if ( type == FileType_File ) {
			if ( StrEqual( cfgContents , prefix , false ) ) {
				LogMessage("Loading %s%s", "/sourcemod/prefix/" , cfgContents );
				ServerCommand("exec %s%s", "/sourcemod/prefix/" , cfgContents ); //attempt to load cfg located in cstrike/cfg/sourcemod/prefix/
			}
		}
	}
	return;
}