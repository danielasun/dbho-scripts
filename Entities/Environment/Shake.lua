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
Shake = {
	type = "Shake",
	Properties = {
		Radius = 30.0,
		Shake = 0.05,
	},
	
	Editor={
		Icon="shake.bmp",
	},
}


function Shake:OnInit()
	self:OnReset();
end

function Shake:OnPropertyChange()
	self:OnReset();
end

function Shake:OnReset()
end

function Shake:OnShutDown()
end

function Shake:Event_Enable( sender )
end

function Shake:Event_Disable( sender )
end

Shake.FlowEvents =
{
	Inputs =
	{
		Disable = { Shake.Event_Disable, "bool" },
		Enable = { Shake.Event_Enable, "bool" },
	},
	Outputs =
	{
		Disable = "bool",
		Enable = "bool",
	},
}
