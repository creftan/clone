local S = {};
S.TileSize = 32;
S.SpriteSheets = {};
S.SpriteSheetCount = 0;
S.ObjectList = {};
S.ObjectCount = 0;

function S:InitSpriteSheet()
	S.SpriteSheetCount = S.SpriteSheetCount + 1;

	return S.SpriteSheetCount;
end

function S:SetTileSize( Size )
	S.TileSize = Size;
end

function S:CreateObject(SheetID, StartTileX, StartTileY, EndTileX, EndTileY  )
	S.ObjectCount = S.ObjectCount + 1;
	local Obj = {};
	Obj.SheetID = SheetID;
	Obj.ID = S.ObjectCount; 

	return S.ObjectCount;
end

function S:CreateAnimation(SheetID, StartTileXList, StartTileYList, EndTileXList, EndTileYList, NumFrames )
	
end

return S;

