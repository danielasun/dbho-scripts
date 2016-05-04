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
AI.LogEvent("LOADING AI GROUP BEHAVIORS");

AIGroupBehavior = 
{
}

function CreateAIGroupBehavior(name, parent, def)
	if ((not def) and ((type(parent) == "table") or (not parent))) then
		def = parent
		parent = nil
	end

	if (not def) then
		def = {}
	end

	assert(not def.parent)
	assert(not def.name)

	local behavior = {}
	mergef(behavior, def, true)

	if (parent) then
		behavior = def
		mergef(def, AIGroupBehavior[parent], true)
		behavior.parent = AIGroupBehavior[parent]
	else
		behavior = def
		behavior.parent = nil
	end
	
	AIGroupBehavior[name] = behavior
	behavior.name = name

	return behavior
end
