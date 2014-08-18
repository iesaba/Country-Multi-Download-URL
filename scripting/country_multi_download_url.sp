#include <sourcemod>
#include <geoip>

#pragma semicolon 1

public Plugin:myinfo = {
	name        = "Country Multi Download URL",
	author      = "k725",
	description = "Multi sv_downloadurl!!",
	version     = "0.1",
	url         = "https://github.com/iesaba/Country-Multi-Download-URL"
};

public bool:OnClientConnect(client)
{
	if (IsValidClient(client)) {
		decl String:urlList[64];
		decl Handle:urlListKv;
		decl String:urlListBuf[8];
		decl String:urlHttp[PLATFORM_MAX_PATH + 1];
		decl String:clientIp[32];
		decl String:clientCountry[4];
		decl Handle:serverCvar;

		serverCvar = FindConVar("sv_downloadurl");
		urlListKv  = CreateKeyValues("Multi Download URL");

		BuildPath(Path_SM, urlList, sizeof(urlList), "configs/country_multi_download_url.cfg");
		GetClientIP(client, clientIp, sizeof(clientIp));

		if (!GeoipCode3(clientIp, clientCountry)) clientCountry = "DEF";

		if(FileExists(urlList))
		{
			FileToKeyValues(urlListKv, urlList);
			KvGotoFirstSubKey(urlListKv);

			do {
				KvGetSectionName(urlListKv, urlListBuf, sizeof(urlListBuf));

				if (StrEqual(urlListBuf, clientCountry))
				{
					// It exists in the list.
					KvGetString(urlListKv, "url", urlHttp, sizeof(urlHttp));
					SetConVarString(serverCvar, urlHttp);
					CloseHandle(urlListKv);

					return true;
				}
			} while (KvGotoNextKey(urlListKv));

			// Does not exist in the list.
			KvJumpToKey(urlListKv, "DEF");
			KvGetString(urlListKv, "url", urlHttp, sizeof(urlHttp), "");
			SetConVarString(serverCvar, urlHttp);
			CloseHandle(urlListKv);
		}
		else
		{
			LogMessage("[MultiDL] Not found!! (configs/multi_download_url.cfg)");
		}
	}

	return true;
}

stock bool:IsValidClient(client)
{
	if (client <= 0 || client > MaxClients) return false;
	if (IsClientSourceTV(client) || IsClientReplay(client)) return false;
	if (IsFakeClient(client)) return false;
	return true;
}