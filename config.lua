
application = {
       license =
       {
          google =
          {
             key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjb6VZ2ofuNe0GlOiFnLJKkT/PSuNn4LPIwtW+DqAKY0Gp1jprQ/52A5YxMh4T6UYH5ZFOD3qB50QkIoOyuVVRw5k6b5FF+z+WfdFPc/1f6poWy4buYHtXRYOBI6HbYEkDp+I0pOGoMhjhmGw6u54SYP0zWv1EUdxLHDVqCXhx6tB5xci8/AE7fyUrXOcp0EuGYK4oqAwsqrD11Bkxvnkd2afMGSV3+jS7YwsSOvZpnusLd8p7Xafzpak7n1jWf4RGmxa/BsRIMNzsPCSRKaWmRgZt2yFy4TeIMzPAF7nHR/8eSduPyM94Z5Aho0SxNMojNS6PNjYkBaAaO3Qg+kMxwIDAQAB",
             policy = "serverManaged",
          },
       },
       
	content = {        --Small     Big
		width = 320,   --160       320
		height = 480,  --240       480
		scale = "letterBox",
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



