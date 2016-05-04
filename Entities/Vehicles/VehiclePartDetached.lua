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
VehiclePartDetached =
{
	Client = {},
	Server = {},

	Properties =
	{
		bPickable = 1,
	},
	
	Editor =
	{
		Icon		= "Item.bmp",
		IconOnTop	= 1,
	},
}

function VehiclePartDetached:IsUsable(user)
	return 1;
end;

function VehiclePartDetached:GetUsableMessage(idx)
	return "@grab_object";
end;

function VehiclePartDetached:OnInit()
	self:OnReset();
end

function VehiclePartDetached:OnPropertyChange()
	self:OnReset();
end

function VehiclePartDetached:OnReset()
end

function VehiclePartDetached:SetObjectModel(model)
end

function VehiclePartDetached:OnShutDown()
end

function VehiclePartDetached:Event_TargetReached(sender)
end

function VehiclePartDetached:Event_Enable(sender)
end

function VehiclePartDetached:Event_Disable(sender)
end

function VehiclePartDetached:GetReturnToPoolWeight(isUrgent)
	local	maxDistance = 100;
	
	local	weight = self:GetTimeSinceLastSeen() * maxDistance;
	
	if (g_localActor) then
		local	distance = self:GetDistance(g_localActor.id);
		
		if (distance > maxDistance) then
			distance = maxDistance;
		end
		
		weight = weight + distance;
	end

	return weight;
end

VehiclePartDetached.FlowEvents =
{
	Inputs =
	{
	},
	
	Outputs =
	{
	},
}
