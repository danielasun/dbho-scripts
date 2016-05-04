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
local Behavior = CreateAIBehavior("VehicleGoto", "VehicleAct",{
	Constructor = function(self , entity )
	end,

	OnActivate = function(self, entity )
		self.allowed = 1;
	end,	
	OnEndPathOffset = function(self, entity)
		AI.LogEvent(entity:GetName().." couldn't reach the goto destination");
	end,
	---------------------------------------------
	OnNoTarget = function(self, entity )
	end,

	---------------------------------------------
	OnEnemyMemory = function( self, entity )
	end,

	--------------------------------------------
	OnEnemySeen = function( self, entity, fDistance )
	end,

	--------------------------------------------------------------------------
	OnSomebodyDied = function( self, entity, sender )
	end,

	OnGroupMemberDied = function( self, entity, sender )
	end,

	OnGroupMemberDiedNearest = function( self, entity, sender, data )
		AI.Signal(SIGNALFILTER_GROUPONLY, 1, "OnGroupMemberDied",entity.id,data);
	end,

	---------------------------------------------
	OnPlayerMemory = function(self, entity )
	end,
	---------------------------------------------
	OnDeadFriendSeen = function(self,entity )
	end,

	---------------------------------------------
	OnDied = function( self,entity )
	end,
	---------------------------------------------

	---------------------------------------------------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------------------------------------------
	--
	--	FlowGraph	actions 
	--
	---------------------------------------------------------------------------------------------------------------------------------------
})
