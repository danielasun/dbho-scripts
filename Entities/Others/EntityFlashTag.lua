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
Script.ReloadScript("scripts/Utils/EntityUtils.lua")

-- Basic entity
EntityFlashTag =
{
	Properties =
	{
		soclasses_SmartObjectClass = "",
		bAutoGenAIHidePts = 0,

		object_Model = "Objects/default/primitive_plane_small.cgf",
		fScale = 2.0, -- Set the scale of the tag to appear above players heads
	},

	Client = {},
	Server = {},

	-- Temp.
	_Flags = {},

	Editor =
	{
		Icon = "physicsobject.bmp",
		IconOnTop = 1,
	},

}
------------------------------------------------------------------------------------------------------
function EntityFlashTag:OnSpawn()
	self:SetFromProperties();
end

------------------------------------------------------------------------------------------------------
function EntityFlashTag:SetFromProperties()
	local Properties = self.Properties;

	if (Properties.object_Model == "") then
		do return end;
	end

	self:LoadObject(0,Properties.object_Model);
	self:SetScale(Properties.fScale);

end

------------------------------------------------------------------------------------------------------
-- OnPropertyChange called only by the editor.
------------------------------------------------------------------------------------------------------
function EntityFlashTag:OnPropertyChange()
	self:SetFromProperties();
end
