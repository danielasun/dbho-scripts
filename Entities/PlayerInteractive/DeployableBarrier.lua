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
Script.ReloadScript("Scripts/Entities/Others/InteractiveEntity.lua");
Script.ReloadScript("Scripts/Entities/PlayerInteractive/InteractiveObjectEx.lua");


DeployableBarrier =
{
	type = "DeployableBarrier",
	
	Properties =
	{
		bUsable = 1,
		
		Interaction =
		{
			object_Model = "Objects/props/military_infrastructure/mil_barrier/mil_barrier_2m_lp_hole.cga",
			Interaction = "barrier2m_hole",
			InteractionRadius = 1.5,
			InteractionAngle = 70,
		},
		
		Physics =
		{
			bRigidBody = 1,
		},
	},
	
	Editor =
	{
		Icon = "animobject.bmp",
		IconOnTop = 1,
	},
}


function DeployableBarrier:StopUse(user, idx)
	InteractiveObjectEx.StopUse(self, user, idx);
	AI.AddCoverEntity(self.id);
end;


mergef(DeployableBarrier, InteractiveObjectEx, 1);


------------------------------------------------------------------------------------------------------
-- Flow events.
------------------------------------------------------------------------------------------------------

DeployableBarrier.FlowEvents =
{
	Inputs =
	{
		Use = { InteractiveObjectEx.Event_Use, "bool" },
		UserId = { InteractiveObjectEx.Event_UserId, "entity" },
		Hide = { InteractiveObjectEx.Event_Hide, "bool" },
		UnHide = { InteractiveObjectEx.Event_UnHide, "bool" },
		Enable = { InteractiveObjectEx.Event_EnableUsable, "bool" },
		Disable = { InteractiveObjectEx.Event_DisableUsable, "bool" },
	},
	Outputs =
	{
		Started = "bool",
		Finished = "bool",
		Enabled = "bool",
		Disabled = "bool",
		Hide = "bool",
		UnHide = "bool",
	},
}
