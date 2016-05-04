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
--	Description: Spectator Point
--
----------------------------------------------------------------------------------------------------
SpectatorPoint =
{
	Client = {},
	Server = {},

	Editor={
		--Model="Editor/Objects/spawnpointhelper.cgf",
		Icon="spectator.bmp",
		DisplayArrow=1,
	},
	
	Properties=
	{
		bEnabled=1,
	},
}

--------------------------------------------------------------------------
function SpectatorPoint.Server:OnInit()
	self:Enable(tonumber(self.Properties.bEnabled)~=0);	
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY,0);
end

--------------------------------------------------------------------------
function SpectatorPoint.Client:OnInit()
	if (not CryAction.IsServer()) then
		self:Enable(tonumber(self.Properties.bEnabled)~=0);	
	end
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY,0);
end

----------------------------------------------------------------------------------------------------
function SpectatorPoint:Enable(enable)
	if (enable) then
		g_gameRules.game:AddSpectatorLocation(self.id);
	else
		g_gameRules.game:RemoveSpectatorLocation(self.id);
	end
	self.enabled=enable;
end

--------------------------------------------------------------------------
function SpectatorPoint.Server:OnShutDown()
	if (g_gameRules) then
		g_gameRules.game:RemoveSpectatorLocation(self.id);
	end
end

--------------------------------------------------------------------------
function SpectatorPoint.Client:OnShutDown()
	if (g_gameRules) and (not CryAction.IsServer()) then
		g_gameRules.game:RemoveSpectatorLocation(self.id);
	end
end

--------------------------------------------------------------------------
function SpectatorPoint:IsEnabled()
	return self.enabled;
end
