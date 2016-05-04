----------------------------------------------------------------------------------------------------
--
-- All or portions of this file Copyright (c) Amazon.com, Inc. or its affiliates or
-- its licensors.
--
-- For complete copyright and license terms please see the LICENSE at the root of this
-- distribution (the "License"). All use of this software is governed by the License,
-- or, if provided, by the license below or the license accompanying this file. Do not
-- remove or modify any license notices. This file is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--
-- Original file Copyright Crytek GMBH or its affiliates, used under license.
--
--
--	Description: Interactive Ledge (for editor placement)
--
----------------------------------------------------------------------------------------------------
Script.ReloadScript("Scripts/Entities/ContextualNavigation/LedgeObjectStatic.lua");

LedgeObject =
{
  Properties =
  {
    bEnabled		= 1,
		bIsThin			= 0,
		bIsWindow		= 0,
		bLedgeDoubleSide = 0;
		bLedgeFlipped   = 0,
		fCornerMaxAngle = 130.0,
		fCornerEndAdjustAmount = 0.5,

		MainSide =
		{
			bEndCrouched = 0,
			bEndFalling = 0,	
			bUsableByMarines = 1,
			esLedgeType = "Normal",
		},

		OppositeSide = 
		{
			bEndCrouched = 0,
			bEndFalling = 0,	
			bUsableByMarines = 1,
			esLedgeType = "Normal",
		},

   },

  Client={},
  Server={},

  Editor=
  {
    Icon="ledge.bmp",
    ShowBounds = 1,
  },
}

function LedgeObject:OnPropertyChange()

end

function LedgeObject:IsShapeOnly()
	return LedgeObjectStatic.IsShapeOnly(self);
end

function LedgeObject:IsClosed()
	return LedgeObjectStatic.IsClosed(self);
end

function LedgeObject:ShapeMinPoints()
	return LedgeObjectStatic.ShapeMinPoints(self);
end

function LedgeObject:ShapeMaxPoints()
	return LedgeObjectStatic.ShapeMaxPoints(self);
end

function LedgeObject:OnSpawn()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
	self:SetFlags(ENTITY_FLAG_NO_PROXIMITY, 0);
end

function LedgeObject:Event_Enable()
	Game.SendEventToGameObject( self.id, "enable" ); 
	BroadcastEvent(self, "Enable");
end

function LedgeObject:Event_Disable()
	Game.SendEventToGameObject( self.id, "disable" ); 
	BroadcastEvent(self, "Disable");
end

function LedgeObject:StartUse(userId)
	self:ActivateOutput( "StartUse", userId );
end

LedgeObject.FlowEvents =
{
	Inputs =
	{
		Disable = { LedgeObject.Event_Disable, "bool" },
		Enable = { LedgeObject.Event_Enable, "bool" },
	},
	Outputs =
	{
		Disable = "bool",
		Enable = "bool",
		StartUse = "entity",
	},
}		
