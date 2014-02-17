display.setStatusBar( display.HiddenStatusBar )

local storyboard 	= require "storyboard"

local ads = require "ads"

local function adListener( event )
    if event.isError then
        -- Failed to receive an ad.
    end
end

ads.init( "inmobi", "bbe39d2e454c46afacabe5ba53a4be89", adListener )
ads.show( "banner320x48", { x=0, y=100, interval=60, testMode=false } )

function printt()

end 
_G.aud = require("audioo")
_G.sounds = aud.loadsounds()
soundOn = true
musicOn = true
storyboard.gotoScene("startSplash")
