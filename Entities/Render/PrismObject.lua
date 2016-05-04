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
----------------------------------------------------------------------------------------------------


PrismObject = {
  type = "PrismObject",
	ENTITY_DETAIL_ID = 1,

	Properties = {
	},

	Editor = {
		Model = "Editor/Objects/Particles.cgf",
		Icon = "Clouds.bmp",
	},
}

-------------------------------------------------------
function PrismObject:OnSpawn()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
end

-------------------------------------------------------
function PrismObject:OnInit()
	self:NetPresent(0);
	self:Create();
end


-------------------------------------------------------
function PrismObject:OnShutDown()
end

-------------------------------------------------------
function PrismObject:Create()
	local props = self.Properties;	
	self:LoadPrismObject(0);
end

-------------------------------------------------------
function PrismObject:Delete()
	self:FreeSlot(0);
end

------------------------------------------------------------------------------------------------------
-- OnReset called only by the editor.
------------------------------------------------------------------------------------------------------
function PrismObject:OnReset()
	local bCurrentlyHasObj = self:IsSlotValid(0);
	if (not bCurrentlyHasObj) then
		self:Create();
	end
end


-------------------------------------------------------
function PrismObject:OnSave(tbl)
	tbl.bHasObject = self:IsSlotValid(0);
	if (tbl.bHasObject) then
	  -- todo: save pos
	end
end

-------------------------------------------------------
function PrismObject:OnLoad(tbl)
	local bCurrentlyHasObject = self:IsSlotValid(0);
	local bWantObject = tbl.bHasObject;
	if (bWantObject and not bCurrentlyHasObject) then
		self:Create();
	  -- todo: restore pos
	elseif (not bWantObject and bCurrentlyHasObject) then
		self:Delete();	
	end
end

-------------------------------------------------------
-- Hide Event
-------------------------------------------------------
function PrismObject:Event_Hide()
	self:Delete();
end

-------------------------------------------------------
-- Show Event
-------------------------------------------------------
function PrismObject:Event_Show()
	self:Create();
end

PrismObject.FlowEvents =
{
	Inputs =
	{
		Hide = { PrismObject.Event_Hide, "bool" },
		Show = { PrismObject.Event_Show, "bool" },
	},
	Outputs =
	{
		Hide = "bool",
		Show = "bool",
	},
}
