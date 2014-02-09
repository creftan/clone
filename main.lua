--Gravity, hur snabbt den faller, rad 22
--YvelBoost, hur mycket den ska åka upp / tap (det kan misstolkas ^^) , rad 23
--Radius, storleken, rad 27

--ObstSpeed, hur snabbt spelet går, rad 59
-- ObstWidth, brädden på hindren, rad 54
-- ObstSpace, bredden på hålet mellan hindren, rad 55


--display.setDefault( "magTextureFilter", "nearest" )
--display.setDefault( "minTextureFilter", "nearest" )

local Physics     = require( "physics" )
                    --require( "sprite" )

Physics.start();
Physics.setDrawMode( "hybrid" );

local CamMaxY = display.viewableContentHeight;
local CamMaxX = display.viewableContentWidth;

    local Gravity = 50
    local YVelBoost = 400;
    local Density = 1;
    local Friction = 0.3;
    local Bounce = 0;
    local Radius = 20;

Physics.setGravity( 0, Gravity );
local BallStartX = CamMaxX*0.25;
local BallStartY = CamMaxY*0.5;
local DrBall = display.newCircle(BallStartX, BallStartY, Radius)
Physics.addBody( DrBall ,"dynamic", { density = Density, friction = Friction, bounce = Bounce, radius = Radius } );

local mrFloor = display.newRect(0, CamMaxY, CamMaxX, 30);
Physics.addBody( mrFloor , "static", { friction=0.5, bounce=0.0 } );

local string = "0"
local ScoreBoard = display.newText(string, 10, 10, native.systemFont, 10)
    --ScoreBoard:setFillColor(1,1,1)
    
local function PrintScore(Score)
    print ("Score  "..Score)
    ScoreBoard.text = Score
end

local function OnTouch( event )
     if event.phase == "began" then
        DrBall:setLinearVelocity( 0, YVelBoost * -1 )
    end
    
end
local Timers = {};
Timers.NewEventTime = 1
Timers.DeltaTime = 1
Timers.PrevEventTime = 1
Timers.CreatonTime = 3
Timers.CreatonCounter = 0


local Obst = {};
local ObstCount = 0;
local ObstWidth = 60;
local ObstSpace = 115;
local ObstStartPosX = CamMaxX + (ObstWidth);
local ObstStartPosY = CamMaxY*0.5;
local ObstHeight = CamMaxY*0.5;
local ObstSpeed = 85

local Reseting = false;



local function Update (event)
    Timers.NewEventTime = event.time;
    Timers.DeltaTime = (Timers.NewEventTime - Timers.PrevEventTime) * 0.001;
    Timers.PrevEventTime = Timers.NewEventTime;

    Timers.CreatonCounter = Timers.CreatonCounter + Timers.DeltaTime;
    
    if Reseting == false then

        if Timers.CreatonCounter > Timers.CreatonTime then
            --print('Create Object', Timers.CreatonCounter);
            Timers.CreatonCounter = Timers.CreatonCounter - Timers.CreatonTime;

            ObstCount = ObstCount + 1;
            PrintScore(ObstCount-1)
            local Body = {}
            Body.Obj1 = display.newRect(0, 0, ObstWidth, ObstHeight)
            --Body.Obj1:setReferencePoint(display.CenterReferencePoint);
            Body.Obj1.anchorX = .5
            Body.Obj1.anchorY = .5
            Body.Obj2 = display.newRect(0, 0, ObstWidth, ObstHeight)
            --Body.Obj2:setReferencePoint(display.CenterReferencePoint);
            Body.Obj2.anchorX = .5
            Body.Obj2.anchorY = .5


            Body.Obj1.x = ObstStartPosX
            Body.Obj2.x = ObstStartPosX

            local Rand = math.random(-95, 95)
            Body.Obj1.y = ObstStartPosY - (ObstStartPosY * 0.5) - (ObstSpace * 0.5) + Rand
            Body.Obj2.y = ObstStartPosY + (ObstStartPosY * 0.5) + (ObstSpace * 0.5) + Rand

            Body.Obj1:setFillColor(150,150,5);
            
            Physics.addBody( Body.Obj1 , "static", { friction=0.5, bounce=0.0 } );
            Physics.addBody( Body.Obj2 , "static", { friction=0.5, bounce=0.0 } );

            Obst[ObstCount] = Body;
        end

    
        for i=1,ObstCount do
            Obst[i].Obj1.x = Obst[i].Obj1.x - (ObstSpeed * Timers.DeltaTime);
            Obst[i].Obj2.x = Obst[i].Obj2.x - (ObstSpeed * Timers.DeltaTime);
        end
    else

        for i=1,ObstCount do
            --Obst[i].Obj1.removeBody( Obst[i].Obj1 );
            if Obst[i].Obj1 ~= nil then
                  Obst[i].Obj1:removeSelf();
            end
            if Obst[i].Obj2 ~= nil then
                 Obst[i].Obj2:removeSelf();
            end
        end
        ObstCount = 0;
        DrBall:setLinearVelocity( 0, 0 );
        DrBall.x = BallStartX;
        DrBall.y = BallStartY;

    Reseting = false;
    Physics.start();

    end



end

function GlobalPreCollisionFunction(self, event)
    print('Reseting')
    --Physics.stop();
    physics.pause();
    Reseting = true;
end


DrBall.preCollision = GlobalPreCollisionFunction
DrBall:addEventListener( "preCollision", DrBall )




Runtime:addEventListener( "enterFrame", Update )
Runtime:addEventListener( "touch", OnTouch )

 