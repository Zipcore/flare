#include <sourcemod>

#define VERSION "1.0.0"

//Booleans
bool g_bHL2MP = false, g_bTF2 = false, g_bCSS = false, g_bUnknown = false;

//Strings
char g_sSpawnList[PLATFORM_MAX_PATH];

public Plugin:myinfo = 
{
	name = "Flare - Main",
	author = "FusionLock",
	description = "A mod for SourceMod that contains commands that are used to spawn/manipulate entities.",
	version = VERSION,
	url = "https://github.com/xfusionlockx/flare"
}

public OnPluginStart()
{
	LoadTranslations("common.phrases");

	//Checking if Flare is supported for the game
	char sGameName[64];

	GetGameFolderName(sGameName, sizeof(sGameName));

	if(StrEqual(sGameName, "hl2mp", true))
	{
		g_bHL2MP = true;
	}else if(StrEqual(sGameName, "tf", true))
	{
		g_bTF2 = true;
	}else if(StrEqual(sGameName, "cstrike", true))
	{
		g_bCSS = true;
	}else{
		g_bUnknown = true;
	}

	if(g_bUnknown)
	{
		PrintToServer("Flare doesn't support '%s'! Unloading the plugin.", sGameName);
		ServerCommand("sm plugins unload fl_main.smx");
	}

	//Now loading the plugin

	//Finding/Creating directories and files Flare needs
	BuildPath(Path_SM, g_sSpawnList, sizeof(g_sSpawnList), "data/flare/spawn.txt");

	//Commands


	//Convars
	CreateConVar("flare", "yes", "Shows that the Flare plugin is running on the server.", FCVAR_NOTIFY|FCVAR_PLUGIN);
	CreateConVar("flare_version", VERSION, "The version of Flare that the server is running.", FCVAR_NOTIFY|FCVAR_PLUGIN);

	//Notice that plugin loaded
	PrintToServer("[Flare] Flare ver%s has loaded successfully.", VERSION);
}
