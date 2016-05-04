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
CameraTargetPoint = {
};

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CameraTargetPoint:OnInit()
	self:Activate(0);
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CameraTargetPoint:OnContact( Entity )
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CameraTargetPoint:OnDamage( Hit )
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CameraTargetPoint:OnShutDown()
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CameraTargetPoint:OnEvent( EventId, Params )
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CameraTargetPoint:OnSave( stm )
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CameraTargetPoint:OnLoad( stm )
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CameraTargetPoint:OnWrite( stm )
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CameraTargetPoint:OnRead( stm )
end
