display.setStatusBar( display.HiddenStatusBar )

local storyboard 	= require "storyboard"

function print()

end 
_G.aud = require("audioo")
_G.sounds = aud.loadsounds()

aud.playMusic("Audio/menu.mp3")

storyboard.gotoScene("startBackground")
