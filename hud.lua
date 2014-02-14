
local hud = {}
local soundOn = true
local musicOn = true
local socialModule = require "socialModule"
local facebook = require("facebook")
function hud.makeRandomSentence()
	local list1 = {"SUCH","VERY","SO","MUCH","WOW"}
	local list2 = {"SCORE","BRAVE","PROGRESS","DOGE","GOOD"}
	local i1 = math.random(1,#list1)
	local i2 = math.random(1,#list2)
	local sentence = list1[i1].." "..list2[i2]

	return sentence
end 



function hud.forSfx(event)
	--if event.phase == "ended" then
		if soundOn then
			soundOn = false
			aud.setsoundvolume(0)
		else 
			soundOn = true
			aud.setsoundvolume(1)
		end
	--end
end

function hud.forMusic(event)
	if musicOn then
		musicOn = false
		aud.setmusicvolume(0)
	else 
		musicOn = true
		aud.setmusicvolume(.3)
	end
end
	
function hud.returntrue()
	return true
end

function hud.forFacebook(event)
	if event.phase == "ended" then
		facebook.request( "me/feed", "POST", { message="Test\n\n\nAnother test" } )
	end
end

function hud.forTwitter(event)

	if event.phase == "ended" then
		socialModule.sendTweetAppCapture("pic.png","FUCKING AWESOME!\ntest the app here: http://fuckyou.com/")
	end
end

function hud.createHud(event,group)
	socialList = {
				{listener=hud.forFacebook, 	pic="art/face.png"},
				{listener=hud.forTwitter,	pic="art/twit.png"},
	}

	hudList = {
				{listener=hud.forMusic,	pic="art/Buttons/b_note.png"},
				{listener=hud.forSfx,	pic="art/Buttons/b_speaker.png"},
			}

	buttonList = {}
	
	socialButtonList = {}

	for i=1,#hudList do
		hud.hudGroup = display.newGroup()
		
		hud.hudPic = display.newImage(hud.hudGroup,hudList[i].pic,0,0)
		hud.hudPic.x = 20 + hud.hudPic.width*(i-1)*2.5
		hud.hudPic.xScale, hud.hudPic.yScale = 2,2
	
		buttonList[#buttonList+1] = hud.hudPic

		hud.hudPic:addEventListener("tap",hudList[i].listener)
		hud.hudPic:addEventListener("touch",hud.returntrue)
		group:insert(hud.hudGroup)

	end

	hud.scoreText = display.newText(hud.hudGroup,"0",0,0,"Arcade",40)
	hud.scoreText.text = 0 
	hud.scoreText.x = _W*.5
	hud.scoreText.y = _H*.15

	hud.wowText = display.newText(hud.hudGroup," ",0,0,"Arcade",20)
	hud.wowText.x = _W*.5
	hud.wowText.y = _H*.22
	
	local scorecounter = 0 

	function hud.resetScore()
		scorecounter = 0 
		scoretext = 0 
	end 

	function hud.getScore(score)
		local oldtext = {}
		scorecounter = scorecounter + 1
		oldtext.y = hud.scoreText.y

		hud.scoreText.text = score
		hud.scoreText.alpha = 1
		if scorecounter == 5 then 
			hud.wowText.text = hud.makeRandomSentence()
			hud.wowText.alpha = 1
			hud.wowText.xScale = 1
			hud.wowText.yScale = 1
		
			transition.to (hud.wowText, {delay = 500, time = 500, alpha = 0, xScale = 3, yScale = .1})
			scorecounter = 0 
		end 		
		transition.to (hud.scoreText, {time = 20,y = oldtext.y + 10,transition=easing.InOutQuad,onComplete=function()
		transition.to (hud.scoreText, {time = 50,y = oldtext.y, transition=easing.InOutQuad})
		end})  
		aud.play(sounds.point)
	end

	function hud.loadHighscore() 
    
    	local path = system.pathForFile( "save.txt", system.DocumentsDirectory )
    	local file = io.open( path, "r" )
    
    	if file == nil then Highscore = 0; end
    
    	if file ~=nil then 
    	    for line in file:lines() do
    	        Highscore=tonumber(line)
    	    end
    	    io.close( file )
    	end 
    	return Highscore
    end 

 
    function hud.saveHighscore(saveData)
        local path = system.pathForFile( "save.txt", system.DocumentsDirectory )
        local file = io.open( path, "w" )
        
        file:write( saveData )
        io.close( file )
        file = nil		
 	end 



	function hud.setScoresGameOver(score1, score2)
		hud.gameOvertext1.text = score1		
		hud.gameOvertext2.text = score2
	end 

	function hud.gameOverBoxMove()
		hud.gameOverTransition = transition.to(hud.gameOverGroup,{time=80,y=180,transition=easing.InOutQuad,onComplete=function()
			hud.gameOverTransition2 = transition.to(hud.gameOverGroup,{time=80,y=170,transition=easing.InOutQuad})
		end})
	end
	hud.gameOverGroup = display.newGroup()
	
	hud.hudGroup:insert(hud.gameOverGroup)
	
	hud.gameOver = display.newImage(hud.gameOverGroup,"art/Ingame/gameoverbox.png",0,0)
	hud.gameOvertext1 = display.newText(hud.gameOverGroup,"0", 0,0, "Arcade", 10)
	hud.gameOvertext1.x = 10
	hud.gameOvertext1.y = -7
	hud.gameOvertext2 = display.newText(hud.gameOverGroup,"0", 0,0, "Arcade", 10)
	hud.gameOvertext2.x = 10
	hud.gameOvertext2.y = 16


	hud.gameOverGroup.x = _W*.5
	hud.gameOverGroup.y = -_H
	hud.gameOverGroup.xScale, hud.gameOverGroup.yScale = 2.5,2.5
	
	for i=1,#socialList do
		hud.socialGroup = display.newGroup()
		hud.socialPics = display.newImage(hud.socialGroup,socialList[i].pic,0,0)
		hud.socialPics.x = hud.socialPics.width*(i-1)*2.1
		hud.socialGroup.x = -hud.socialGroup.width
		hud.socialGroup.y = hud.gameOver.y + 40
		
		socialButtonList[#socialButtonList+1] = hud.socialGroup
		
		hud.gameOverGroup:insert(hud.socialGroup)

		hud.socialGroup:addEventListener("touch",socialList[i].listener)
		hud.socialGroup:addEventListener("tap",hud.returntrue)
	end

	return hud.createHud
end

function hud.printScore(Score)
    hud.scoreText.text = Score
end

function hud.deleteHud(event,group)
	print("Deletes ")
	display.remove(hud.scoreText)


	display.remove(hud.gameOverGroup)
	for i=1,#hudList do
		buttonList[i]:removeEventListener("touch",hudList[i].listener)
		buttonList[i]:removeEventListener("tap",hud.returntrue)
		
		display.remove(buttonList[i])
		display.remove(group)
	end

	for i=1,#socialList do
		socialButtonList[i]:removeEventListener("tap",hud.returntrue)
		socialButtonList[i]:removeEventListener("touch",socialList[i].listener)
		
		display.remove(socialButtonList)
		display.remove(socialGroup)
	end

	gameOverTransition2 = nil
	gameOverTransition = nil
end	

sentence = hud.makeRandomSentence()
print (sentence)

return hud