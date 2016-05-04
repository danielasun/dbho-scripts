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
SoundSupressor = {
	Client = {},
	Server = {},
	Properties = {
		radius = 10
	},
		Editor={
		Icon = "Item.bmp",
		IconOnTop=1,
	},
}


function SoundSupressor:OnPropertyChange()
	self:OnReset();
end;

function SoundSupressor:OnInit()
	self:OnReset();
end

function SoundSupressor:OnReset()

	CryAction.RegisterWithAI(self.id, AIOBJECT_SNDSUPRESSOR, self.Properties);

end;



----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------
------------------------------------Events----------------------------------------
----------------------------------------------------------------------------------
function SoundSupressor:Event_TurnOn()
	self:TriggerEvent(AIEVENT_DISABLE);
end;

function SoundSupressor:Event_TurnOff()
	self:TriggerEvent(AIEVENT_ENABLE);
end;



----------------------------------------------------------------------------------
-------------------------------Flow-Graph Ports-----------------------------------
----------------------------------------------------------------------------------

SoundSupressor.FlowEvents =
{
	Inputs =
	{
		TurnOn = { SoundSupressor.Event_TurnOn, "bool" },
		TurnOff = { SoundSupressor.Event_TurnOff, "bool" },
	},
	Outputs =
	{
	},
}
