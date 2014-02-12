
application = {
	content = {        --Small     Big
		width = 320,   --160       320
		height = 480,  --240       480
		scale = "zoomStretch",
		fps = 60,
		
		--[[
        imageSuffix = {
		    ["@2x"] = 2,
		}
		--]]
	},

    --[[
    -- Push notifications

    notification =
    {
        iphone =
        {
            types =
            {
                "badge", "sound", "alert", "newsstand"
            }
        }
    }
    --]]

    LevelHelperSettings = 
    {
        imagesSubfolder = "Images",
        levelsSubfolder = "levels",
        directorGroup = nil
    }
}