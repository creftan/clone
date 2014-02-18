display.setStatusBar( display.HiddenStatusBar )

local storyboard 	= require "storyboard"

local ads = require "ads"

local function adListener( event )
    if event.isError then
        print(event.response)
    end
end

ads.init( "inneractive", "ThreeOfUs_FlapDoge_Android", adListener )
ads.show( "banner", { x=0, y=display.contentHeight*.94, interval=60, testMode=false } )

function printt()

end 
_G.aud = require("audioo")
_G.sounds = aud.loadsounds()
soundOn = true
musicOn = true
storyboard.gotoScene("startSplash")
