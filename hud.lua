local hud = {}


function hud.forSfx(event)
	print("sfx")
end

function hud.forMusic(event)
	print("music")
end

function hud.createHud(event,group)
	
	local function returntrue()
		return true
	end
	
	local hudList = {
				{
				listener=hud.forMusic,
				pic="art/Buttons/b_note.png",
				},
				{
				listener=hud.forSfx,
				pic="art/Buttons/b_speaker.png",
				},
			}
	for i=1,2 do
		local hudGroup = display.newGroup()

		hudPic = display.newImage(hudGroup,hudList[i].pic,0,0,50,50)
		hudPic.x = hudPic.width*i*1.1
		hudGroup.xScale, hudGroup.yScale = 3,3

		hudGroup:addEventListener("tap",hudList[i].listener)
		hudGroup:addEventListener("touch",returntrue)
		group:insert(hudGroup)

	end
	return hud.createHud
end


function hud.deleteHud(event)
	display.remove(hudTest)
end

return hud