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
--Script.ReloadScript("Scripts/AI/anchor.lua");

AIAnchor = {
  type = "AIAnchor",
  Properties = 
  {
  	aianchor_AnchorType = "_wrong_type_",
  	bEnabled = 1,  	
		soclasses_SmartObjectClass = "",
		groupid = -1,
		radius = 0,
  },
}

-------------------------------------------------------
function AIAnchor:OnPropertyChange()
	self:Register();	
end

-------------------------------------------------------
function AIAnchor:OnInit()
	self:Register();
end

-------------------------------------------------------
function AIAnchor:OnReset()
	self.bNowEnabled = self.Properties.bEnabled;
	if (self.Properties.bEnabled == 0) then
		self:TriggerEvent(AIEVENT_DISABLE);
	else
		self:TriggerEvent(AIEVENT_ENABLE);
	end
end

-------------------------------------------------------
function AIAnchor:OnUsed()
	-- this function will be called from ACT_USEOBJECT
	BroadcastEvent(self, "Use");
end

-------------------------------------------------------
function AIAnchor:Register()
	self.registered = nil;
	if(self.Properties.aianchor_AnchorType ~= "") then
		if(AIAnchorTable[self.Properties.aianchor_AnchorType] == nil) then
			System.Log("AIAnchor["..self:GetName().."]:  undefined type ["..self.Properties.aianchor_AnchorType.."] Cant register with [AISYSTEM]");
		else
			CryAction.RegisterWithAI( self.id, AIAnchorTable[self.Properties.aianchor_AnchorType], self.Properties );
		
			-- since sending properties to RegisterWithAI has no effect group id will be set with ChangeParameter
			AI.ChangeParameter( self.id, AIPARAM_GROUPID, self.Properties.groupid );
			self.registered = 1;
		end
	end
	self:OnReset();
end

-------------------------------------------------------
function AIAnchor:Event_Use( sender )
	if (self.bNowEnabled == 1) then
		BroadcastEvent(self, "Use");
	end
end

-------------------------------------------------------
function AIAnchor:Event_Enable()
	self:TriggerEvent(AIEVENT_ENABLE);
	self.bNowEnabled = 1;
	BroadcastEvent(self, "Enable");
end

-------------------------------------------------------
function AIAnchor:Event_Disable()
	self:TriggerEvent(AIEVENT_DISABLE);
	self.bNowEnabled = 0;
	BroadcastEvent(self, "Disable");
end

-------------------------------------------------------
function AIAnchor:OnSave(save)
		save.aianchor_AnchorType = self.Properties.aianchor_AnchorType;
end

-------------------------------------------------------
function AIAnchor:OnLoad(save)

		self.Properties.aianchor_AnchorType = save.aianchor_AnchorType;
		if(not self.registered) then
			self:Register();	
		end	
		
end


AIAnchor.FlowEvents =
{
	Inputs =
	{
		Disable = { AIAnchor.Event_Disable, "bool" },
		Enable = { AIAnchor.Event_Enable, "bool" },
		Use = { AIAnchor.Event_Use, "bool" },
	},
	Outputs =
	{
		Disable = "bool",
		Enable = "bool",
		Use = "bool",
	},
}
