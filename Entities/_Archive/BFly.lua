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
BFly = {
	type = "BFlyController",
	Properties = {	
		BFlyNumber = 23,
		},
	Editor={
		Model="Objects/Editor/T.cgf",
	},
	
	outsideBFlyNumber = 0,
}


function BFly:OnInit()
end
-----------------------------------------------------------------------------
--	fade: 0-out 1-in
function BFly:OnProceedFadeArea( player,areaId,fadeCoeff )

--System.LogToConsole("--> bfly FadeIS "..fadeCoeff );
--	System.SetViewDistance(1200);

--	if(player ~= _localplayer) then
--		return
--	end	
--local	cCoeff = sqrt( fadeCoeff );
--	fadeCoeff = cCoeff
	System.SetBFCount( Lerp(self.outsideBFlyNumber, self.Properties.BFlyNumber, fadeCoeff) );
end

-----------------------------------------------------------------------------
function BFly:OnEnterArea( player,areaId )

--	if(player ~= _localplayer) then
--		return
--	end	

--System.LogToConsole("--> Entering BFLY Area "..areaId);
	
	self.outsideBFlyNumber = System.GetBFCount( );
end

-----------------------------------------------------------------------------
function BFly:OnLeaveArea( player,areaId )

--System.LogToConsole("--> Leaving BFLY Area "..areaId);

--	if(player ~= _localplayer) then
--		return
--	end	
	
	System.SetBFCount( self.outsideBFlyNumber);

end
-----------------------------------------------------------------------------
function BFly:OnShutDown()
end
