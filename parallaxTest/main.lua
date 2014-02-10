
_W = display.contentWidth
_H = display.contentHeight

display.setDefault( "magTextureFilter", "nearest" )
display.setDefault( "minTextureFilter", "nearest" )

local p = {}
	p.position1 = 0 
	p.position2 = 0 
	p.position3 = 0 

local parallax2 = display.newGroup()
	parallax2.layer1_1=display.newImageRect(parallax2,"mountain.png", 64,128)
	parallax2.layer1_1.xScale = 2
	parallax2.layer1_1.yScale = 2
	parallax2.layer1_1.x = _W/2
	parallax2.layer1_1.y = _H*.64

	parallax2.layer1_2=display.newImageRect(parallax2,"mountain.png", 64,128)
	parallax2.layer1_2.xScale = 2
	parallax2.layer1_2.yScale = 2
	parallax2.layer1_2.x = _W/2 + 512
	parallax2.layer1_2.y = _H*.64

local parallax1 = display.newGroup()
	parallax1.layer1_1=display.newImageRect(parallax1,"bushes.png", 256,64)
	parallax1.layer1_1.xScale = 2
	parallax1.layer1_1.yScale = 2
	parallax1.layer1_1.x = _W/2
	parallax1.layer1_1.y = _H*.74

	parallax1.layer1_2=display.newImageRect(parallax1,"bushes.png", 256,64)
	parallax1.layer1_2.xScale = 2
	parallax1.layer1_2.yScale = 2
	parallax1.layer1_2.x = _W/2 + 512
	parallax1.layer1_2.y = _H*.74


floorgroup = display.newGroup()
topgroup = display.newGroup()

local sky = display.newRect (0,0,_W,_H)
	sky:setFillColor(.5,.6,.9)
	sky.x = _W*.5
	sky.y = _H*.4
	
local ground_top_1 = display.newImageRect(topgroup,"ground_top_2.png",701,64)
	ground_top_1.xScale = .5
	ground_top_1.yScale = .5
	ground_top_1.x = _W*.5
	ground_top_1.y = _H*.8

local ground_top_2 = display.newImageRect(topgroup,"ground_top_2.png",701,64)
	ground_top_2.xScale = .5
	ground_top_2.yScale = .5
	ground_top_2.x = _W*.5 + 350
	ground_top_2.y = _H*.8
		
local floorline = display.newRect(floorgroup, 0,0,_W,1)
	floorline.strokeWidth = 2
	floorline:setStrokeColor(.3,.6,.1)
	floorline.x = _W/2
	floorline.y = _H*.789

local floorbottom = display.newRect(floorgroup,0,0,_W,_H)
	floorbottom.x = _W/2
	floorbottom.y = _H*1.3
	floorbottom:setFillColor(.62,.37,.16)

floorgroup:insert(topgroup)
sky:toBack()
floorgroup.y = _H*.1

function move(speed)
	
	p.position1 = p.position1 - speed
	if p.position1 < -350 then 
		p.position1 = 0 
	end

	topgroup.x = p.position 

	p.position2 = p.position2 - speed/2
	if p.position2 < -512 then 
		p.position2 = 0 
	end

	p.position3 = p.position3 - speed/3
	if p.position3 < -512 then 
		p.position3 = 0 
	end

	topgroup.x = p.position1
	parallax1.x = p.position2 
	parallax2.x = p.position3 


end

function dostuff()
	move (4)
end 

Runtime:addEventListener("enterFrame",dostuff)
