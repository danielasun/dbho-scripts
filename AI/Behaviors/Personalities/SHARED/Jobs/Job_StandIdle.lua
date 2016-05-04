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
local Behavior = CreateAIBehavior("Job_StandIdle",
{
	Constructor = function(self,entity )
		g_StringTemp1 = tostring(entity.Properties.aicharacter_character).."Idle";
		local defaultBehavior = AIBehavior[g_StringTemp1];
		if(defaultBehavior and defaultBehavior ~= AIBehavior.Job_StandIdle and defaultBehavior.Constructor) then 
			defaultBehavior:Constructor(entity);
		else			
			if ( entity.AI and entity.AI.needsAlerted ) then
				AI.Signal(SIGNALFILTER_SENDER, 1, "INCOMING_FIRE",entity.id);
				entity.AI.needsAlerted = nil;
			end	
		end
		
		entity:InitAIRelaxed();
		entity:SelectPipe(0, "DoNothing");
	end,

	Destructor = function(self, entity)
	end,

	OnJobContinue = function(self,entity,sender )	
		self:Constructor(entity);
	end,

	OnBored = function (self, entity)
	end,	
})