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
ScanSpot =
{
	Client = {},
	Server = {},
	PropertiesInstance = {},

	Properties =
	{
		bUseEntity = 1,

		ParticleFX =
		{
			name = "",
			vOffset 	= {x=0, y=0, z=0},
			vRotation	= {x=0, y=0, z=0},
		},
	},

	Editor={
		Icon = "TagPoint.bmp",
		--Model = "Editor/Objects/Sphere.cgf",
	},

	Server=
	{
		OnStartGame = function(entity)
			--Log("Registering Scan Spot")
			GameAI.RegisterScanSpot(entity.id)
		end,
	},

	OnScannedByDrone = function(entity)
		local linkCount = entity:CountLinks()
		for i=0, linkCount-1 do
			local linkedEntity = entity:GetLink(i)

			if (entity.Properties.bUseEntity) then
				linkedEntity:OnUsed()
			end

			if (entity.Properties.ParticleFX.name ~= "") then
				Particle.SpawnEffect(entity.Properties.ParticleFX.name, SumVectors(linkedEntity:GetWorldPos(), entity.Properties.ParticleFX.vOffset), entity.Properties.ParticleFX.vRotation, 1.0)
			end
		end

		entity:ActivateOutput("Scanned", true);
	end,
}

-------------------------------------------------------

function ScanSpot:Event_Enable( sender )
	GameAI.RegisterScanSpot(self.id)
end

function ScanSpot:Event_Disable( sender )
	GameAI.UnregisterScanSpot(self.id)
	-- to do: handle case where it is disable while the drone is using it
end

ScanSpot.FlowEvents =
{
	Inputs =
	{
		Enable = { ScanSpot.Event_Enable, "bool" },
		Disable = { ScanSpot.Event_Disable, "bool" },
	},

	Outputs =
	{
		Scanned = "bool",
	}
}