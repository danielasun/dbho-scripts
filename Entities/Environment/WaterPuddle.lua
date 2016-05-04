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
WaterPuddle = 
{
	type = "WaterPuddle",
	
	Properties = 
	{
		bThisIsAPuddle = 0,
	},
	
	Editor = 
	{
		Model="Editor/Objects/T.cgf",
		Icon="Water.bmp",
		ShowBounds = 1,
		IsScalable = false;
		IsRotatable = true;
	},
}



function WaterPuddle:OnPropertyChange()
end



function WaterPuddle:IsShapeOnly()
	return 0;
end



function WaterPuddle:Event_Hide()
	self:Hide(1);
	self:ActivateOutput("Hidden", true);
end;



function WaterPuddle:Event_UnHide()
	self:Hide(0);
	self:ActivateOutput( "UnHidden", true );
end;




WaterPuddle.FlowEvents =
{
	Inputs =
	{
		Hide = { WaterPuddle.Event_Hide, "bool" },
		UnHide = { WaterPuddle.Event_UnHide, "bool" },
	},
	Outputs =
	{
		Hidden = "bool",
		UnHidden = "bool",
	},
}
