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
BossMarker =
{
	Editor =
	{
		Icon="Comment.bmp",
	},
	Properties =
	{
		fileModel				= "",
		ModelSubObject	= "",
		bEnabled				= 1,
	},
}

--------------------------------------------------------------------------
function BossMarker:OnInit()
	self:OnReset();
end

--------------------------------------------------------------------------
function BossMarker:OnPropertyChange()
	self:OnReset();
end

--------------------------------------------------------------------------
function BossMarker:OnReset()
	if(self.Properties.bEnabled == 1)then
		Game.AddTacticalEntity(self.id, eTacticalEntity_Unit);
	else
		Game.RemoveTacticalEntity(self.id, eTacticalEntity_Unit);
	end
end

--------------------------------------------------------------------------
function BossMarker:OnLoad(table)  
	self.Properties.bEnabled = table.enabled;
end

--------------------------------------------------------------------------
function BossMarker:OnSave(table)  
	table.enabled = self.Properties.bEnabled;
end

--------------------------------------------------------------------------
function BossMarker:Event_Enable()
	self.Properties.bEnabled = 1;
	BroadcastEvent( self,"Unhide" );
	Game.AddTacticalEntity(self.id, eTacticalEntity_Unit);
end

--------------------------------------------------------------------------
function BossMarker:Event_Disable()
	self.Properties.bEnabled = 0;
	BroadcastEvent( self,"Hide" );
	Game.RemoveTacticalEntity(self.id, eTacticalEntity_Unit);
end

--------------------------------------------------------------------------
BossMarker.FlowEvents =
{
	Inputs =
	{
		Enable = { BossMarker.Event_Enable, "bool" },
		Disable = { BossMarker.Event_Disable, "bool" },
	},
}
