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
--	Description: Interactive Static Ledge (for editor placement)
--
----------------------------------------------------------------------------------------------------
LedgeObjectStatic =
{
  Properties =
  {
    bIsThin			= 0,
	  bIsWindow		= 0,
	  bLedgeDoubleSide = 0,
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
			bUsableByMarines=1,
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

function LedgeObjectStatic:OnPropertyChange()

end

function LedgeObjectStatic:IsShapeOnly()
	return 1;
end

function LedgeObjectStatic:IsClosed()
  return 0;
end

function LedgeObjectStatic:ShapeMinPoints()
	return 2;
end

function LedgeObjectStatic:ShapeMaxPoints()
	return 33;
end

function LedgeObjectStatic:ExportToGame()
  return 0;
end

function LedgeObjectStatic:OnSpawn()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
	self:SetFlags(ENTITY_FLAG_NO_PROXIMITY, 0);
end


