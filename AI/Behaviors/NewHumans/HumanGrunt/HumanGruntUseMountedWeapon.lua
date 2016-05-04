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
local Behavior = CreateAIBehavior("HumanGruntUseMountedWeapon", "HumanBaseBehavior",
{	
	Constructor = function(self, entity)
		AI.EnableCoverFire(entity.id, true)
		AI.PlayCommunication(entity.id, "goto_mounted_weapon", "Group", 0.5)

		if (entity.AI.targetMountedWeapon) then
			entity.AI.targetMountedWeapon.inUse = true
		end
		entity:UseMountedWeapon()

		-- Making sure MountedWeaponTargetChange is called at the start, 
		-- since this is where the mounted weapon goalpipes are selected.
		entity.selectMountedWeaponGoalpipeTimer = Script.SetTimer(1000, function() entity:MountedWeaponTargetChange() end)
	end,

	Destructor = function(self, entity)
		entity:SafeKillTimer(entity.selectMountedWeaponGoalpipeTimer)

		AI.EnableCoverFire(entity.id, false)
		if (entity.AI.targetMountedWeapon) then
			entity.AI.targetMountedWeapon.inUse = false
		end

		self:Leave(entity)
	end,

	OnTargetLost = function(self, entity, sender, data)
		if (not entity:IsGunner()) then
			self:Leave(entity)
		end
	end,

	OnNewAttentionTarget = function(self, entity, sender, data)
		entity:CheckMountedWeaponTarget(data.iValue)
		entity:MountedWeaponTargetChange()
	end,

	OnNoTarget = function(self, entity, sender, data)
		entity:MountedWeaponTargetChange()
	end,

	OnOutOfAmmo = function(self, entity, sender, data)
		self:Leave(entity)
	end,

	Leave = function(self, entity)
		AI.SetBehaviorVariable(entity.id, "UseMountedWeapon", false)
		entity:LeaveMountedWeapon()
	end,
})