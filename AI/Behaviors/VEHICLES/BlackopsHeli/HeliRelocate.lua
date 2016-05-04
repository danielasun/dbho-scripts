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
local Behavior = CreateAIBehavior("HeliRelocate", "HeliIdle",
{
	Constructor = function (self, entity)
		self:AnalyzeSituation(entity)
	end,

	Destructor = function(self, entity)
	end,
	
	AnalyzeSituation = function(self, entity, sender, data)

		local targetPos = g_Vectors.temp_v1

		AI.GetAttentionTargetPosition(entity.id, targetPos)
		AI.SetRefPointPosition(entity.id, targetPos)
		entity:SelectPipe(0, "HeliFlyBy")
	end,
	
	GoodLocationReached = function(self, entity, sender, data)
		AI.SetBehaviorVariable(entity.id, "GoodLocation", true)
	end,
	
	AdvantagePointNotFound = function(self, entity, sender, data)
		Log("%s - AdvantagePointNotFound", EntityName(entity))
	end,

	OnDestinationReached = function(self, entity)
		entity:SelectPipe(0, "HeliHovering")
		--self:AnalyzeSituation(entity)
	end,

	OnEnemyMemory = function(self, entity, distance)
		self:AnalyzeSituation(entity)
	end,
	

})