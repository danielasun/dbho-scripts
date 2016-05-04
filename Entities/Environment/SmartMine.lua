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
SmartMine =
{
	type = "SmartMine",

	Properties =
	{
		object_Model = "Objects/default/primitive_sphere.cgf",
		MaterialArmed = "Materials/basecolors/base_red_firebrick",
		MaterialDisarmed = "Materials/basecolors/base_green_bright",
		vTriggerBox	= {x=5, y=5, z=3},
		fTriggerToDetonateDelay = 0.75,
		fDetonationRadius = 2.5,
		ExplosionType = "SmartMineExplosive",
		Damage = 980,
		esFaction = "Grunts",
		
		Physics = 
		{
			bStatic = 0,
			fJumpImpulse = 5000,
		},

		LightArmed =
		{
			clrDiffuse = { x=1 , y=0 , z=0 },
			fDiffuseMultiplier = 1,
			fSpecularMultiplier = 1,
			fHDRDynamic = 0,
		},

		LightDisarmed = 
		{
			clrDiffuse = { x=0 , y=1 , z=0 },
			fDiffuseMultiplier = 1,
			fSpecularMultiplier = 1,
			fHDRDynamic = 0,
		},

		Audio =
		{
			esSmartMineType = "Cell",
		}
	},

	Editor =
	{
		Icon="mine.bmp",
	},

	Client = {},
	Server = {},
}

function SmartMine:OnPropertyChange()

end

function SmartMine.Server:OnHit(hit)
	if ((hit.type ~= "collision") and (hit.damage > 0)) then
		Game.SendEventToGameObject( self.id, "detonate" );
		BroadcastEvent( self, "Exploded" );
		if(hit.shooterId) then
			self.detonatedByEntity = hit.shooterId;
		end
	end
end


function SmartMine:Event_Enable()
	Game.SendEventToGameObject( self.id, "enable" );
end

function SmartMine:Event_Disable()
	Game.SendEventToGameObject( self.id, "disable" );
end

function SmartMine:OnExploded()
	BroadcastEvent( self, "Exploded" );
end

SmartMine.FlowEvents =
{
	Inputs =
	{
		Enable = { SmartMine.Event_Enable, "any" },
		Disable = { SmartMine.Event_Disable, "any" },
	},
	Outputs =
	{
		Exploded = "bool",
	},
}
