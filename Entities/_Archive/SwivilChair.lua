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
-- chair for AI to sit on
-- after creating lua need to place path in Editor\EntityRegistry.xml (in Artwork SS)
SwivilChair = {
	name = "SwivilChair",
	Properties = {
		objModel = "Objects/Indoor/furniture/chairs/swivel.cgf",
	},
}
------------------------------------------------------------------------------------------------------
function SwivilChair:OnInit()
	self:Activate(0);
	if (self.ModelName ~= self.Properties.objModel) then
		self.ModelName = self.Properties.objModel;
		self:LoadObject( self.ModelName, 0,1 );
	end
	-- see ScriptObjectEntity 
	self:CreateStaticEntity(200,0); -- param fMass, nSurfaceID
	self:EnablePhysics( 1 );
	self:DrawObject(0,1); --param nPos(slot number), nMode(0 = Don't draw, 1 = Draw normally, 3 = Draw near)
--	self:RegisterWithAI(AIAnchor.AIOBJECT_SWIVIL_CHAIR);
	AI:RegisterWithAI(self.id, AIAnchor.AIOBJECT_SWIVIL_CHAIR);
end
------------------------------------------------------------------------------------------------------
function SwivilChair:OnEvent ( id, params)
	
end
------------------------------------------------------------------------------------------------------
function SwivilChair:OnShutDown()

end
------------------------------------------------------------------------------------------------------
