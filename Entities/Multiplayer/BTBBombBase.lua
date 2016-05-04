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
BTBBombBase = {
    Client = {},
    Server = {},
    Properties = {
	fileModel		= "objects/library/props/ctf/mpnots_flagbase01.cgf",
	ModelSubObject		= "main",
	Radius			= 2;
    },
    Editor = {
	Icon		= "Item.bmp",
	IconOnTop	= 1,
    },
}

function BTBBombBase.Server:OnInit()
	Log("BTBBombBase.Server.OnInit");
	if (not self.bInitialized) then
		self:OnReset();
		self.bInitialized = 1;
	end;
	self.inside = {};
end;

function BTBBombBase.Client:OnInit()
	Log("BTBBombBase.Client.OnInit");
	if (not self.bInitialized) then
		self:OnReset();
		self.bInitialized = 1;
	end;
	self.inside = {};
end;

function BTBBombBase:OnReset()
    Log("BTBBombBase.OnReset");
    self:LoadObject(0, self.Properties.fileModel);
	
	local radius_2 = self.Properties.Radius / 2;
	
 	local Min={x=-radius_2,y=-radius_2,z=-radius_2};
	local Max={x=radius_2,y=radius_2,z=radius_2};
	self:SetTriggerBBox(Min,Max);
	
	self:Physicalize(0, PE_STATIC, { mass=0 });
	
	self:SetFlags(ENTITY_FLAG_ON_RADAR, 0);
end;

----------------------------------------------------------------------------------------------------

function BTBBombBase.Server:OnHit()
	Log("HIT BASE!");
end
