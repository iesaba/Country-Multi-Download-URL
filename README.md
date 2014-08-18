Country-Multi-Download-URL
==========================

SourceMod / Multi sv_downloadurl

Idea :: [Multi Sv_downloadurl v1.1][1] (AMXX plugin)

example config file. ``country_multi_download_url.cfg``  
Support [ISO-3166 alpha3][2]. 

Country name uppercase!! & Not delete "DEF"!!

    "Multi Download URL"
    {
    	"USA"
    	{
    		"url"	"http://example.us/csgo"
    	}
    	"CAN"
    	{
    		"url"	"http://example.ca/csgo"
    	}
    	"JPN"
    	{
    		"url"	"http://example.jp/csgo"
    	}
    	// Default
    	// * Not delete!! *
    	"DEF"
    	{
    		"url"	"http://example.com/csgo"
    	}
    }


  [1]: https://forums.alliedmods.net/showthread.php?p=856637
  [2]: http://www.geonames.org/countries/