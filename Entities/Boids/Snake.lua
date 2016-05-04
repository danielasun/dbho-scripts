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
Script.ReloadScript( "Scripts/Entities/Boids/Chickens.lua" );

Snake =
{
	Properties =
	{
		Boid =
		{
			object_Model = "",
		},
		Movement =
		{
			HeightMin = 1,
			HeightMax = 3,
			SpeedMin = 0.5,
			SpeedMax = 1,
			MaxAnimSpeed = 2,
		},
	},

	Audio =
	{
	},
	
	Animations =
	{
		"walk_loop",   -- walking
		"idle01",      -- idle1
		"idle01",      -- idle2
		"idle01",      -- idle3
		"idle01",      -- pickup
		"idle01",      -- throw
	},
	Editor =
	{
		Icon = "Bird.bmp"
	},
}

MakeDerivedEntityOverride( Snake,Chickens )

function Snake:OnSpawn()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
end