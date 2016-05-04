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
Script.ReloadScript( "Scripts/Entities/Physics/RigidBodyEx.lua");

DangerousRigidBody = {
	Properties = {
		bCurrentlyDealingDamage = 0,
		bDoesFriendlyFireDamage = 0,
		fDamageToDeal = 10000.0,
		fTimeBetweenHits = 0.5,
	},
}

MakeDerivedEntity( DangerousRigidBody, RigidBodyEx )

-------------------------------------------------------
--					Flow Graph						 --
-------------------------------------------------------

function DangerousRigidBody:Event_MakeDangerous(sender, params)
	Game.SetDangerousRigidBodyDangerStatus(self.id, true, params.id);
	self:ActivateOutput( "IsDangerous", true );
end

function DangerousRigidBody:Event_MakeNotDangerous()
	Game.SetDangerousRigidBodyDangerStatus(self.id, false, 0);
	self:ActivateOutput( "IsDangerous", false );
end

DangerousRigidBody.FlowEvents = 
{
	Inputs = 
	{
		MakeDangerous = { DangerousRigidBody.Event_MakeDangerous, "entity" },
		MakeNotDangerous = { DangerousRigidBody.Event_MakeNotDangerous, "any" },
	},
	Outputs = 
	{
		IsDangerous = "bool"
	},
}

mergef(DangerousRigidBody.FlowEvents, RigidBodyEx.FlowEvents, 1);