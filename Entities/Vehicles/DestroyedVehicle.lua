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
Script.ReloadScript( "Scripts/Entities/Others/RigidBody.lua" );

---------------------------------------------------------

DestroyedVehicle = 
{
	type = "DestroyedVehicle",

	Properties = 
	{
		bInteractLargeObject = 1, 
		bUsable = 1,
		Physics = 
		{
			Mass = 2000,
		},
	},

	PropertiesInstance = 
	{
		bProvideAICover = 1,  
	},

	Editor = 
	{
		IsScalable = false;
	},
}

MakeDerivedEntity(DestroyedVehicle,RigidBody);
AddHeavyObjectProperty(DestroyedVehicle);
MakeAICoverEntity(DestroyedVehicle);
SetupCollisionFiltering(DestroyedVehicle);

function DestroyedVehicle:IsUsable()
	if(self.Properties.bUsable ~= 0) then
		return 1;
	end

	return 0;
end

function DestroyedVehicle:OnReset()
	RigidBody.OnReset(self);
	ApplyCollisionFiltering(self, GetCollisionFiltering(self));
end