local hud = {}

function hud.hudFunctions()
	local function forSfx(event)
		print("Music")
	end

	local function forMusic(event)
		print("Music")
	end
end

function hud.createHud(event,group)
--[[	hud.hudFunctions(forMusic,forSfx)
	local hudList = {
				{
				listener=forMusic,
				pic="art/Buttons/b_note.png",
				},
				{
				listener=forSfx,
				pic="art/Buttons/b_speaker.png",
				},
			}
	for i=1,2 do
		local hudGroup = display.newGroup()

		hudPic = display.newImage(hudGroup,hudList[i].pic,0,0,50,50)
		hudPic.x = hudPic.width*i*1.1
		hudGroup.xScale, hudGroup.yScale = 3,3

		hudGroup:addEventListener("tap",hudList[i].listener)
		group:insert(hudGroup)

	end
]]
end


function hud.deleteHud(event)
	display.remove(hudTest)
end

return hud