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
--  Description: Tag Name point entity - used to provide positional information for rendering fake player tag names
--
----------------------------------------------------------------------------------------------------
TagNamePoint =
{
	Client = {},
	Server = {},

	Editor={
		Icon="spectator.bmp", -- Just something for now
		DisplayArrow=0,
	},
	
	Properties=
	{
		bEnabled    = 1,
	},
}

function TagNamePoint.Client:OnInit()
--System.Log( "TagNamePoint.Client:OnInit()" );
	if (not self.bInitialized) then
		--System.Log( "About to call RegisterTag Name Point" );
		self.bInitialized = 1;
		--Game.RegisterTagNamePoint(self.id); --michiel
	end
end



