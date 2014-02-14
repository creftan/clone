local C = {};

C.ScreenMinX = 0;
C.ScreenMaxX = 0;

C.ScreenMinY = 0;
C.ScreenMaxY = 0;

C.Physics = nil
C.ObjectList = {};
C.ObjectCount = 0;

C.TileObjectList = {};
C.TileObjectCount = 0;
C.TileManager = {};
C.TileManager.List = {};
C.TileManager.TileCounter = 0;
C.TileManager.TotalCounter = 0;

C.WorldSpeed = 0;

C.Timers = {};
C.Timers.NewEventTime = 1;
C.Timers.DeltaTime = 0;
C.Timers.DeltaTimeTick = 0;
C.Timers.PrevEventTime = 1;
C.Timers.CounterList = {};
C.Timers.CounterCount = 0;

C.OverlayTimer = -0.5 * math.pi;
C.OverlayTimerSpeed = 1;
C.OverLayAlpha = 0

C.LayerDisplayGroups = {};
C.LayerDisplayGroupsNum = 0;
C.HudDisplayGroup = display.newGroup(); 

C.GameRunning = false;
C.GameReadyToRun = false;

C.PlayerClassPointer = nil;
C.PlayerPosX = 0;


function C:InitCore(PhysPointer, ScreenMinX, ScreenMaxX, ScreenMinY, ScreenMaxY, WorldSpeed, OverlayTimerSpeed)
	C.Physics = PhysPointer;
	C.ScreenMinX = ScreenMinX;
	C.ScreenMaxX = ScreenMaxX;
	C.ScreenMinY = ScreenMinY;
	C.ScreenMaxY = ScreenMaxY;
	C.WorldSpeed = WorldSpeed;
	C.OverlayTimerSpeed = OverlayTimerSpeed;

end

function C:SetPlayerClassPointer(PlayerPointer)
	C.PlayerClassPointer = PlayerPointer;
end

function C:CreateTileObject(MainImagePath, OverlayImagePath, PosX, PosY, MoveSpeed, Layer, PhysObject, PhysObjectIsCircle, PhysicAtribute, SizeOffset)

	C.TileManager.TileCounter = C.TileManager.TileCounter + 1;
	if C.TileManager.List[C.TileManager.TileCounter] == nil then
		C.TileManager.List[C.TileManager.TileCounter] = 1;
		C.TileManager.TotalCounter = C.TileManager.TotalCounter + 1;

		local XLength = PosX - C.ScreenMinX;
		local X = PosX;
		local Y = PosY;
		local W = 0;
		local H = 0;
		--X, Y, W, H = C:CreateObject(MainImagePath, OverlayImagePath, PosX, (PosY - 20), MoveSpeed, Layer, PhysObject, PhysObjectIsCircle, PhysicAtribute, SizeOffset);
		W, H = C:GetImageObjectData( MainImagePath)
		local NumXTiles = math.ceil(XLength/W);
		for i=1,NumXTiles do
			X = X - W;
			C:CreateObjectToTile(NumXTiles, MainImagePath, OverlayImagePath, X, PosY, MoveSpeed, Layer, PhysObject, PhysObjectIsCircle, PhysicAtribute, SizeOffset);
		end

	end
end

function C:GetImageObjectData( MainImagePath)
	local Obj = display.newImage(MainImagePath);
	local W = Obj.width;
	local H = Obj.height
	Obj:removeSelf();
	Obj = nil;
	return W, H;


end

function C:CreateObjectToTile(NumXTiles, MainImagePath, OverlayImagePath, PosX, PosY, MoveSpeed, Layer, PhysObject, PhysObjectIsCircle, PhysicAtribute, SizeOffset)
		
	C.TileObjectCount = C.TileObjectCount + 1;
	local Obj = {}
	Obj.ID = C.TileObjectCount;
	Obj.GraphMain = display.newImage(MainImagePath);
	Obj.GraphOverlay = display.newImage(OverlayImagePath);
	Obj.X = PosX;
	Obj.Y = PosY;
	Obj.PrevX = PosX;
	Obj.PrevY = PosY;
	Obj.H = Obj.GraphMain.height;
	Obj.W = Obj.GraphMain.width;
	Obj.NumXTiles = NumXTiles;
	Obj.MoveSpeed = MoveSpeed;

	-- Create Physic atributes
	if PhysObject == true then
		local Density = 1;
    	local Friction = 1;
    	local Bounce = 0;
	    	local Radius = ((Obj.GraphMain.height + Obj.GraphMain.width) * 0.25) + SizeOffset;
		if PhysObjectIsCircle == true then
			Physics.addBody( Obj.GraphMain ,PhysicAtribute, { density = Density, friction = Friction, bounce = Bounce, radius = Radius } );
		else
			C.Physics .addBody( Obj.GraphMain , PhysicAtribute, { friction = Friction, bounce = Bounce } );
		end
	end

	C.TileObjectList[C.TileObjectCount] = Obj;
	C:UpdateTileObjectPosition(C.TileObjectCount, PosX, PosY );
	C:InsertInDisplayGroup( C.TileObjectList[C.TileObjectCount].GraphOverlay, C.TileObjectList[C.TileObjectCount].GraphMain, Layer );
	return PosX, PosY, Obj.W, Obj.H;

end

function C:CreateTimeObject(CreateTime, MainImagePath, OverlayImagePath, PosX, PosY, MoveSpeed, Layer, PhysObject, PhysObjectIsCircle, PhysicAtribute, SizeOffset, SinYMovement, SinYSpeed, SinYStart, PointsToPlayer)
	C.Timers.CounterCount = C.Timers.CounterCount + 1;
	if C.Timers.CounterList[C.Timers.CounterCount] == nil then
		local Timer = {}
		Timer.Tick = 0;
		C.Timers.CounterList[C.Timers.CounterCount] = Timer;
	end
	C.Timers.CounterList[C.Timers.CounterCount].Tick = C.Timers.CounterList[C.Timers.CounterCount].Tick + C.Timers.DeltaTimeTick;

	if C.Timers.CounterList[C.Timers.CounterCount].Tick > CreateTime then
		C.Timers.CounterList[C.Timers.CounterCount].Tick = C.Timers.CounterList[C.Timers.CounterCount].Tick - CreateTime;
	
		C:CreateObject(MainImagePath, OverlayImagePath, PosX, PosY, MoveSpeed, Layer, PhysObject, PhysObjectIsCircle, PhysicAtribute, SizeOffset, SinYMovement, SinYSpeed, SinYStart, PointsToPlayer);

	end
end

function C:CreateObject(MainImagePath, OverlayImagePath, PosX, PosY, MoveSpeed, Layer, PhysObject, PhysObjectIsCircle, PhysicAtribute, SizeOffset, SinYMovement, SinYSpeed, SinYStart, PointsToPlayer)
		
	C.ObjectCount = C.ObjectCount + 1;
	local Obj = {}
	Obj.ID = C.ObjectCount;
	Obj.GraphMain = display.newImage(MainImagePath);
	Obj.GraphOverlay = display.newImage(OverlayImagePath);
	Obj.X = PosX;
	Obj.Y = PosY;
	Obj.PrevX = PosX;
	Obj.PrevY = PosY;
	Obj.H = Obj.GraphMain.height;
	Obj.W = Obj.GraphMain.width;
	Obj.MoveSpeed = MoveSpeed;
	Obj.SinYMovement = SinYMovement;
	Obj.SinYSpeed = SinYSpeed;
	Obj.SinYVal = SinYStart;
	Obj.Points = math.ceil(PointsToPlayer);


	-- Create Physic atributes
	if PhysObject == true then
		local Density = 1;
    	local Friction = 1;
    	local Bounce = 0;
	    	local Radius = (Obj.GraphMain.height * 0.5) + SizeOffset;
		if PhysObjectIsCircle == true then
			Physics.addBody( Obj.GraphMain ,PhysicAtribute, { density = Density, friction = Friction, bounce = Bounce, radius = Radius } );
		else
			C.Physics .addBody( Obj.GraphMain , PhysicAtribute, { friction = Friction, bounce = Bounce } );
		end
	end

	C.ObjectList[C.ObjectCount] = Obj;
	C:UpdateObjectPosition(C.ObjectCount, PosX, PosY );
	C:InsertInDisplayGroup( C.ObjectList[C.ObjectCount].GraphOverlay, C.ObjectList[C.ObjectCount].GraphMain, Layer );
	return PosX, PosY, Obj.W, Obj.H;

end

function C:InsertInDisplayGroup( GraphPointer1, GraphPointer2, Layer )

	if C.LayerDisplayGroupsNum < Layer then
		C.LayerDisplayGroupsNum = Layer;

		--Sort DisplayGroups
		for i=1,C.LayerDisplayGroupsNum do
			if C.LayerDisplayGroups[i] == nil then
				C.LayerDisplayGroups[i] = display.newGroup();
			end
			C.LayerDisplayGroups[i]:toFront();		
		end
		C.HudDisplayGroup:toFront();

	end
	C.LayerDisplayGroups[Layer]:insert(GraphPointer2);
	C.LayerDisplayGroups[Layer]:insert(GraphPointer1);
end

function C.GetHudGroup()
	return C.HudDisplayGroup;
end

function C:DeleteDisplayGroups()
	for i=1,C.LayerDisplayGroupsNum do
		if C.LayerDisplayGroups[i] ~= nil then
			C.LayerDisplayGroups[i]:removeSelf();
			C.LayerDisplayGroups[i] = nil;
		end		
	end
	C.LayerDisplayGroupsNum = 0;
end

function C:DestroyObject( ObjectID  )
	local TempObj = {}
	TempObj = C.ObjectList[ObjectID];
	C.ObjectList[ObjectID] = C.ObjectList[C.ObjectCount];
	C.ObjectList[C.ObjectCount] = TempObj;
	C.ObjectList[ObjectID].ID = ObjectID;

	C.ObjectList[C.ObjectCount].GraphMain:removeSelf();
	C.ObjectList[C.ObjectCount].GraphOverlay:removeSelf();

	C.ObjectCount = C.ObjectCount - 1;
end

function C:DestroyTileObject( ObjectID  )
	local TempObj = {}
	TempObj = C.TileObjectList[ObjectID];
	C.TileObjectList[ObjectID] = C.TileObjectList[C.TileObjectCount];
	C.TileObjectList[C.TileObjectCount] = TempObj;
	C.TileObjectList[ObjectID].ID = ObjectID;

	C.TileObjectList[C.TileObjectCount].GraphMain:removeSelf();
	C.TileObjectList[C.TileObjectCount].GraphOverlay:removeSelf();

	C.TileObjectCount = C.TileObjectCount - 1;
end

function C:CheckObjectOutsideScreen( ObjectID )
	OutsidePosX = C.ObjectList[ObjectID].X + (C.ObjectList[ObjectID].W * 0.5);
	if OutsidePosX < C.ScreenMinX then
		C:DestroyObject(ObjectID);
	end
end

function C:CheckTileObjectOutsideScreen( ObjectID )
	OutsidePosX = C.TileObjectList[ObjectID].X + (C.TileObjectList[ObjectID].W * 0.5);
	if OutsidePosX < C.ScreenMinX then
		local NewX = C.TileObjectList[ObjectID].X + (C.TileObjectList[ObjectID].W * C.TileObjectList[ObjectID].NumXTiles)
		C:UpdateTileObjectPosition(ObjectID, NewX, C.TileObjectList[ObjectID].Y );
	end
end

function C:UpdateObjectPosition(ObjectID, NewX, NewY)

	local function UpdateGraphicPos (GraphPointer, X, Y)
		--GraphPointer:setReferencePoint(display.CenterReferencePoint);
		GraphPointer.x = X;
		GraphPointer.y = Y;
	end

	local Obj = {};
	Obj = C.ObjectList[ObjectID];
	Obj.PrevX = Obj.X;
	Obj.PrevY = Obj.Y;
	Obj.X = NewX;
	Obj.Y = NewY;
	-- Sin movement
	Obj.SinYVal = Obj.SinYVal+ (C.Timers.DeltaTime * Obj.SinYSpeed)
	local Val = Obj.SinYMovement * math.sin(Obj.SinYVal);
	local SinManiY = NewY + Val;
	--
	UpdateGraphicPos(Obj.GraphMain, NewX, SinManiY );
	UpdateGraphicPos(Obj.GraphOverlay, NewX, SinManiY );
	Obj.GraphOverlay.alpha = C.OverLayAlpha;

	-- GivePlayerPoints if Coords is procede
	if Obj.X < C.PlayerPosX then
		 C.PlayerClassPointer:AddPlayerPoints(Obj.Points);
		 Obj.Points = 0;
	end


end

function C:UpdateTileObjectPosition(ObjectID, NewX, NewY)

	local function UpdateGraphicPos (GraphPointer, X, Y)
		--GraphPointer:setReferencePoint(display.CenterReferencePoint);
		GraphPointer.x = X;
		GraphPointer.y = Y;
	end

	local Obj = {};
	Obj = C.TileObjectList[ObjectID];
	Obj.PrevX = Obj.X;
	Obj.PrevY = Obj.Y;
	Obj.X = NewX;
	Obj.Y = NewY;
	UpdateGraphicPos(Obj.GraphMain, NewX, NewY);
	UpdateGraphicPos(Obj.GraphOverlay, NewX, NewY);
	Obj.GraphOverlay.alpha = C.OverLayAlpha;

end

function C:UpdateDeltaTime(event)
	C.Timers.NewEventTime = event.time;
    C.Timers.DeltaTime = (C.Timers.NewEventTime - C.Timers.PrevEventTime) * 0.001;
    C.Timers.PrevEventTime = C.Timers.NewEventTime;
    if C.Timers.DeltaTime > 0.05 then
    	C.Timers.DeltaTime = 0.05;
    end
end

function C:GetDeltaTime()
	return C.Timers.DeltaTime;
end

function C:ResetCounters()
	C.Timers.CounterCount = 0;
	C.TileManager.TileCounter = 0;
end

function C:PauseGame()
	--print("GamePaused");
	C.GameRunning = false;
	--C.Timers.DeltaTime = 0;
	C.Physics.pause();
end

function C:StartGame()
	--print("GameStart");
	C.GameRunning = true;
	C.Physics.start();
end

function C:StopGame()
	--print("GameStopped");
	--C.Timers.DeltaTime = 0;
	C.OverlayTimer = -0.5 * math.pi;
	C.OverLayAlpha = 0
	C.GameRunning = false;
	C.Physics.pause();
	-- Destroy objects
	if C.ObjectCount > 0 then
		for i=C.ObjectCount,1,-1 do
			C:DestroyObject(i);
		end
	end
	-- Destroy Tile-objects
	if C.TileObjectCount > 0 then
		for i=C.TileObjectCount,1,-1 do
			C:DestroyTileObject(i);
		end
	end
	-- Reset TileManager
	if C.TileManager.TotalCounter > 0 then
		for i=C.TileManager.TotalCounter,1,-1 do
			C.TileManager.List[i] = nil;
		end
	end
	C.TileManager.TileCounter = 0;

	--Reseting All Timers
	for i=1,#C.Timers.CounterList do
		C.Timers.CounterList[i].Tick = 0
	end


	--C.Physics.stop();
end

function C:SetPlayerXPos(PosX)
	C.PlayerPosX = PosX;
end

function C:GetIfGameIsRunning()
	return C.GameRunning;
end

function C:SetGameReadyness(ReadyToRun)
	C.GameReadyToRun = ReadyToRun;
end

function C:GetIfGameIsReadyToRun()
	return C.GameReadyToRun;
end

function C:GetTimeCycle()
	return C.OverLayAlpha;
end

function C:Update(event)

	C:UpdateDeltaTime(event);
	C.Timers.DeltaTimeTick = 0;
	if C.GameRunning == true then
		C:GameRunningUpdate(event);
	end

end

function C:GameRunningUpdate(event)

	C.Timers.DeltaTimeTick = C.Timers.DeltaTime;
	--ObjectUpdate Movement
	
	for i=1,C.ObjectCount do
	--	for k,v in pairs(C.ObjectList[i]) do
--
--				print(k,v)
--		end
--		print " "
		C.ObjectList[i].X = C.ObjectList[i].X - (C.ObjectList[i].MoveSpeed * C.Timers.DeltaTime);
		C:UpdateObjectPosition(i, C.ObjectList[i].X, C.ObjectList[i].Y);
	end

	--ObjectUpdate OutsideScreen Deletion
	if C.ObjectCount > 0 then
		for i=C.ObjectCount,1,-1 do
			C:CheckObjectOutsideScreen(i);
		end
	end

	--TileObjectUpdate Movement
	for i=1,C.TileObjectCount do
		C.TileObjectList[i].X = C.TileObjectList[i].X - (C.TileObjectList[i].MoveSpeed * C.Timers.DeltaTime);
		C:UpdateTileObjectPosition(i, C.TileObjectList[i].X, C.TileObjectList[i].Y);
	end

	--TileObjectUpdate OutsideScreen RePositionation
	if C.TileObjectCount > 0 then
		for i=C.TileObjectCount,1,-1 do
			C:CheckTileObjectOutsideScreen(i);
		end
	end

	-- Overlay Time Cycle
	C.OverlayTimer = C.OverlayTimer + (C.Timers.DeltaTime * C.OverlayTimerSpeed);
	C.OverLayAlpha = (math.sin(C.OverlayTimer ) + 1) * 0.5
	--print(C.OverLayAlpha , C.OverlayTimer )

end

return C;