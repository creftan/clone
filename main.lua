display.setStatusBar( display.HiddenStatusBar )

local storyboard 	= require "storyboard"

function printt()

end 
_G.aud = require("audioo")
_G.sounds = aud.loadsounds()
soundOn = true
musicOn = true
storyboard.gotoScene("startSplash")
