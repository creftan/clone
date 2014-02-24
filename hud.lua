


local hud = {}
local enablesocial = false
local socialModule = require "socialModule"
local font = "Ponderosa"
local boolswitch = true 
_W = display.contentWidth
_H = display.contentHeight

local medal = {9,74,199}
--local medal = {1,2,3}
local medalimage = {"art/Ingame/dogenope.png","art/Ingame/Dogebronze.png","art/Ingame/dogesilver.png","art/Ingame/Dogegold.png"}

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
			buttonListOff[2].isVisible = true
			aud.setsoundvolume(0)
		else 
			soundOn = true
			buttonListOff[2].isVisible = false
			aud.setsoundvolume(1)
		end
	--end
end

function hud.forMusic(event)
	if musicOn then
		musicOn = false
		buttonListOff[1].isVisible = true
		aud.setmusicvolume(0)
	else 
		musicOn = true
		buttonListOff[1].isVisible = false
		aud.setmusicvolume(.3)
	end
end
	
function hud.returntrue()
	return true
end

function hud.forFacebook(event)
	if event.phase == "ended" then
		socialModule.sendfbMessage("Test\n\n\nTest!")
	end
end

function hud.forTwitter(event)

	if event.phase == "ended" then
		--socialModule.sendTweetAppCapture("pic.png","FUCKING AWESOME!\ntest the app here: http://fuckyou.com/")
		socialModule.twitterAndroid("This is fucking awesome, fuck you!\nLine?")
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

	hudListOff ={ 
					{pic="art/Buttons/b_noteoff.png"},
				 	{pic="art/Buttons/b_speakeroff.png"},
				 }

	buttonList = {}
	buttonListOff = {}
	
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

	for i=1,#hudListOff do 
		hud.hudGroupOff = display.newGroup()
		hud.hudPicOff = display.newImage(hud.hudGroupOff,hudListOff[i].pic,0,0)
		hud.hudPicOff.x = 20 + hud.hudPicOff.width*(i-1)*2.5
		hud.hudPicOff.xScale, hud.hudPicOff.yScale = 2,2

		buttonListOff[#buttonListOff+1] = hud.hudPicOff

		group:insert(hud.hudGroupOff)

	end
		if soundOn then 
			buttonListOff[2].isVisible = false
		end

		if musicOn then
			buttonListOff[1].isVisible = false
		end
	hud.scoreText = display.newText(hud.hudGroup,"0",0,0,font,40)
	hud.scoreText.text = 0 
	hud.scoreText.x = _W*.5
	hud.scoreText.y = _H*.15

	hud.wowText = display.newText(hud.hudGroup," ",0,0,font,20)
	hud.wowText.x = _W*.5
	hud.wowText.y = _H*.22
	
	hud.adblock = display.newImageRect (hud.hudGroup,"art/adblock.png",300,30)
	hud.adblock.x = _W*.5
	hud.adblock.y = _H*.90
	hud.adblock2 = display.newImageRect (hud.hudGroup,"art/adblock2.png",300,30)
	hud.adblock2.x = _W*.5
	hud.adblock2.y = _H*.90
		hud.adblock.alpha = 0
		hud.adblock2.alpha = 0
			

	local scorecounter = 0 


	function hud.resetScore()
		scorecounter = 0 
		scoretext = 0 
	end 

	function hud.getScore(score)
		hud.ad()
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

	function hud.ad()

			if adbool then
			print "adblink"
			boolswitch = not boolswitch

			if boolswitch then 
			print "adblink"

					hud.adblock.alpha = 1
					hud.adblock2.alpha = 0 
			else
			print "adblink 2"

					hud.adblock.alpha = 0
					hud.adblock2.alpha = 1 
			end 				
			end 
	end 


	function hud.setScoresGameOver(score1, score2)
		print (score1, medal[1])
		local whatmedal = 1 

		if score1 > medal[1] then 
		whatmedal = 2
		end

		if score1 > medal[2] then 
		whatmedal = 3

		end

		if score1 > medal[3] then 
		whatmedal = 4
		end

		print (whatmedal)
		print (medalimage[whatmedal])

		hud.medal = display.newImage(hud.gameOverGroup,medalimage[whatmedal],0,0)

		hud.medal.x = -28.5
		hud.medal.y = 3


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
	hud.gameOvertext1 = display.newText(hud.gameOverGroup,"0", 0,0, font, 10)
	hud.gameOvertext1.x = 10
	hud.gameOvertext1.y = -7
	hud.gameOvertext2 = display.newText(hud.gameOverGroup,"0", 0,0, font, 10)
	hud.gameOvertext2.x = 10
	hud.gameOvertext2.y = 16


	hud.gameOverGroup.x = _W*.5
	hud.gameOverGroup.y = -_H
	hud.gameOverGroup.xScale, hud.gameOverGroup.yScale = 2.5,2.5
	

	if enablesocial then 

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
	end

	
	return hud.createHud
end

function hud.printScore(Score)
    hud.scoreText.text = Score
end

function hud.deleteHud(event,group)
	--print("Deletes ")
	buttonListOff[1]:removeSelf()
	buttonListOff[2]:removeSelf()
	display.remove(hud.hudGroupOff)
	display.remove(hud.scoreText)
	display.remove(hud.medal)
	display.remove(hud.gameOverGroup)

	for i=1,#hudList do
		buttonList[i]:removeEventListener("touch",hudList[i].listener)
		buttonList[i]:removeEventListener("tap",hud.returntrue)
		
		display.remove(buttonList[i])
		display.remove(group)
	end
	if enablesocial then 
	for i=1,#socialList do
		socialButtonList[i]:removeEventListener("tap",hud.returntrue)
		socialButtonList[i]:removeEventListener("touch",socialList[i].listener)
		
		display.remove(socialButtonList)
		display.remove(socialGroup)
	end
end 
	gameOverTransition2 = nil
	gameOverTransition = nil
end	

socialList = nil
hudList = nil
hudListOff = nil
buttonList = nil
buttonListOff = nil 
	
socialButtonList = {}

sentence = hud.makeRandomSentence()
--print (sentence)

return hud