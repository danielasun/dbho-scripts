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
--System.Log("Loading SmartObjectCondition.lua");

SmartObjectCondition = {
  type = "SmartObjectCondition",
  Properties = 
  {
  	bEnabled = true,
  	bIncludeInNavigation = true,
  	bRelativeToTarget = false,
  	Object = {
  		soclass_Class = "BasicEntity",
  		sostate_State = "Idle",
  		object_Model = "",
  	},
  	User = {
  		soclass_Class = "AIOBJECT_ACTOR",
  		sostate_State = "Idle",
  		object_Model = "",
  	},
  	Limits = {
  		fDistance = 10.0,
  		fOrientation = 360.0,
  	},
  	Delay = {
  		fMinimum = 0.5,
  		fMaximum = 15.0,
  		fMemory = 1.0,
  	},
  	Multipliers = {
  		fProximity = 1.0,
  		fOrientation = 0.0,
  		fVisibility = 0.0,
  		fRandomness = 0.25,
  	},
  	Action = {
  		soaction_Name = "",
  		sostate_ObjectState = "Busy",
  		sostate_UserState = "Busy",
  	},
  },
	
	Editor={
		Model="Editor/Objects/Pyramid.cgf",
	},
}

-------------------------------------------------------
function SmartObjectCondition:OnPropertyChange()
--	self:Register();
end

-------------------------------------------------------
function SmartObjectCondition:OnInit()
--	self:Register();
end

-------------------------------------------------------
function SmartObjectCondition:OnReset()
	self:Register();
end

-------------------------------------------------------
function SmartObjectCondition:Register()
--	This entity shouldn't be used anymore!
--	AI.AddSmartObjectCondition( self.Properties );
end
