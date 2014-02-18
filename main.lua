display.setStatusBar( display.HiddenStatusBar )

local storyboard 	= require "storyboard"
adcounter = 0 
local ads = require "ads"

local function adListener( event )
    if event.isError then
       adcounter = adcounter + 1 
       print ("ad "..counter)
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
