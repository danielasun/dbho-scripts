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
--	Description: Camera Shake helper entity
--
----------------------------------------------------------------------------------------------------
CameraShake =
{
	Properties =
	{
		vector_Position = {x=0, y=0, z=0 },
		fRadius = 10.0,
		fStrength = 1.0,
		fDuration = 2.0,
		fFrequency = 0.5
	},

	Editor =
	{
		Icon = "shake.bmp",
	},
}

function CameraShake:OnPropertyChange()
end

function CameraShake:Event_Shake(sender)
	g_gameRules:ClientViewShake(self.Properties.vector_Position, nil, 0.0, self.Properties.fRadius,self.Properties.fStrength,self.Properties.fDuration,self.Properties.fFrequency);
end

CameraShake.FlowEvents =
{
	Inputs =
	{
		Shake = { CameraShake.Event_Shake, "bool" },
	},
	Outputs =
	{
	},
}
