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
--
--	Description: FlowGraph node which spawns a particle effect
--
----------------------------------------------------------------------------------------------------
SpawnParticleEffect = {
	Category = "approved",
	Inputs = {{"t_Activate","bool"},{"Position","vec3"}, {"Effect","string"}},
	Outputs = {{"Done","bool"}},
	Implementation=function(bActivate,vPosition,sEffect)
		Particle.SpawnEffect(sEffect,vPosition,g_Vectors.v001,1.0);
		return;
	end;
} 


