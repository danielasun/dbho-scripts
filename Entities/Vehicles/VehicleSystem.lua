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
--	Description: Common code for all the vehicle implementations
--
----------------------------------------------------------------------------------------------------
V_XML_DEF = "Scripts/Entities/Vehicles/def_vehicle.xml";
V_SCRIPT_DIR = "Scripts/Entities/Vehicles/Implementations/";
V_XML_DIR = V_SCRIPT_DIR.."Xml/";

-- convenience defines to use with GetHelperPos, GetHelperDir (on vehicle and entity)
HELPER_WORLD = 0;
HELPER_LOCAL = 1;


VehicleSystem = {};


-- get vehicle implementations
if (not VehicleSystem.VehicleImpls) then  
  VehicleSystem.VehicleImpls = Vehicle.GetVehicleImplementations(V_XML_DIR);
  --Log("[VehicleSystem]: got %i vehicle implementations", count(VehicleSystem.VehicleImpls));
end


--------------------------------------------------------------------------
function ExposeVehicleToNetwork( class )
	Net.Expose {
		Class = class,
		ClientMethods = {
		},

		ServerMethods = {
		},
	}
end

--------------------------------------------------------------------------
function VehicleSystem.ReloadVehicleSystem()
  Log("Reloading VehicleSystem");
  Vehicle.ReloadSystem();
  Script.ReloadScript( "Scripts/Entities/Vehicles/VehicleSystem.lua" );        
end