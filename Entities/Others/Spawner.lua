Spawner = 
{

    Properties = {
        esArchetype="",
        iNumberOfPlayers = 6,

    },

    Editor = {
        Icon = "bug.bmp",
    },

    xml_def_path = "Scripts/Data/Spawner_def.xml",
    xml_data_path = "Scripts/Data/Spawner_data.xml",

    xml_formation_def_path = "Scripts/Data/Formation_def.xml",
    xml_formation_data_path = "Scripts/Data/Formation_data.xml",

    time_elapsed = 0.0,

    redteam_formation = {}, 
    blueteam_formation = {},

    xmin = 473,
    xmax = 532,
    ymin = 518,
    ymax = 568,
    fallHeight = 32,
}

function fitness(time,numberOfPlayersOnOwnTeamAlive, numberOfPlayersOnOtherTeamKilled)
    return numberOfPlayersOnOwnTeamAlive + numberOfPlayersOnOtherTeamKilled - time
end


function Spawner:GenerateLocation(xmin,xmax,ymin,ymax)
    math.randomseed(os.clock()*1000)
    math.random(); math.random();
    local tempx = math.random(xmin,xmax)
    local tempy = math.random(ymin,ymax)
    local temptheta = math.rad(math.random(0,360))
    return {x=tempx,y=tempy,theta=temptheta}
end

function Spawner:SpawnPlayer(entityName, entityArchetype, pos, id_num)
    -- pos is a table of x,y,theta

    local params = {id,
                    class="Human",
                    name= entityName..id_num,
                    position={x=pos.x,y=pos.y,z=self.fallHeight}, 
                    orientation={math.cos(pos.theta),math.sin(pos.theta),0},
                    scale={1,1,1},
                    flags=0,
                    archetype= entityArchetype,
                   }

    System.SpawnEntity(params)
end 

-- function Spawner:SpawnFormationFromXML(entityName,entityArchetype)
-- -- spawns AI and adds them to the Blue team formation
--     Log("Spawner:SpawnFormationFromXML()")
--     local data = CryAction.LoadXML(self.xml_formation_def_path, self.xml_formation_data_path)
--     for i,playerPos in pairs(data.formation) do
--         Log("x,y,theta" .. playerPos.x .. "," .. playerPos.y .. "," .. playerPos.theta)
--         self.blueteam_formation[#self.blueteam_formation+1] = {x=playerPos.x,y=playerPos.y,theta=playerPos.theta}
--         Spawner:SpawnPlayer(entityName, entityArchetype, playerPos,i)
--     end
-- end


function Spawner:OnInit()
    self:Activate(1) -- allows you to use OnUpdate
end

function Spawner:EndGame(winningTeam,score)

    -- winningTeam is a string
    -- score is a table with {["bluescore"] = bluenum,["redscore"] = rednum}
    Log("Spawner:EndGame()")
    local data = CryAction.LoadXML(self.xml_def_path,self.xml_data_path)
    local len = #data.formation;
    if winningTeam == "blue" then
        data.formation[len]["win"] = 1
    else
        data.formation[len]["win"] = 0
    end
    data.formation[len]["blue_score"] = score.bluescore;
    data.formation[len]["red_score"] = score.redscore;
    CryAction.SaveXML(self.xml_def_path, self.xml_data_path, data)

end


function Spawner:OnUpdate(dt)
    if(not System.IsEditing()) then
        Log("Spawner:OnUpdate")
        Log("BLUE = " .. GameToken.GetToken("GameStates.BlueNumAlive"))
    end

    if GameToken.GetToken("GameStates.GameIsRunning") == "1" then
        local bluenum = GameToken.GetToken("GameStates.BlueNumAlive")
        local rednum = GameToken.GetToken("GameStates.RedNumAlive")
        local nplayers = self.Properties.iNumberOfPlayers

        -- Red wins
        if tonumber(GameToken.GetToken("GameStates.BlueNumAlive")) == 0 then
            Log("$7Red Team won " .. nplayers-bluenum .. " to " .. nplayers-rednum )
            GameToken.SetToken("GameStates.GameIsRunning",false)
            Spawner:EndGame("red",{["bluescore"] = nplayers-rednum,["redscore"] = nplayers-bluenum})
        end

        -- Blue wins
        if tonumber(GameToken.GetToken("GameStates.RedNumAlive")) == 0 then
            Log("$2BlueTeam won " .. nplayers-rednum ..  " to " ..  nplayers-bluenum)
            GameToken.SetToken("GameStates.GameIsRunning",false)
            Spawner:EndGame("blue",{["bluescore"] = nplayers-rednum,["redscore"] = nplayers-bluenum})
        end

        -- Log("Blue team has " .. GameToken.GetToken("GameStates.BlueNumAlive"))
        -- Log("Red team has " .. GameToken.GetToken("GameStates.RedNumAlive"))
    end
    -- Log("Blue = " .. GameToken.GetToken("GameStates.BlueNumAlive"))

end

function Spawner:OnReset(bGameStart)

    -- if(bGameStart) then
    --     Log("Spawner:OnReset()")
    --     self.redteam_formation = {}
    --     self.blueteam_formation = {}

    --     GameToken.SetToken("GameStates.GameIsRunning",true)
    --     Log("GameRunning = " .. type(GameToken.GetToken("GameStates.GameIsRunning")))

    --     if GameToken.GetToken("GameStates.GameIsRunning") == "1" then
    --         Log("Game has started!")
    --     end

    --     GameToken.SetToken("GameStates.BlueNumAlive",self.Properties.iNumberOfPlayers)
    --     Log("Blue team has " .. GameToken.GetToken("GameStates.BlueNumAlive"))
    --     GameToken.SetToken("GameStates.RedNumAlive",self.Properties.iNumberOfPlayers)
    --     Log("Red team has " .. GameToken.GetToken("GameStates.RedNumAlive"))

    --     -- Red team
    --     for i=1,self.Properties.iNumberOfPlayers do
    --         local playerPos = Spawner:GenerateLocation(501,521,523,563)
    --         self.redteam_formation[#self.redteam_formation+1] = {x=playerPos.x,y=playerPos.y,theta=playerPos.theta}
    --         Spawner:SpawnPlayer("grunts.Human-red", "humans.grunts.Human-red", playerPos,i)
    --     end

    --     for _,player in pairs(self.redteam_formation) do
    --         for k,val in pairs(player) do
    --             Log(k .. " = " .. val)
    --         end
    --     end

    --     -- Spawner:SpawnFormationFromXML("grunts.Human-blue","humans.grunts.Human-blue")
    --     local data = CryAction.LoadXML(self.xml_formation_def_path, self.xml_formation_data_path)
    --     for i,playerPos in pairs(data.formation) do
    --         Log("#" .. i .. " x,y,theta " .. playerPos.x .. "," .. playerPos.y .. "," .. playerPos.theta)
    --         self.blueteam_formation[#self.blueteam_formation+1] = {x=playerPos.x,y=playerPos.y,theta=playerPos.theta}
    --         Spawner:SpawnPlayer("grunts.Human-blue","humans.grunts.Human-blue", playerPos,i)
    --     end

    --     Log("Number of entries in blueteam_formation is = " .. #self.blueteam_formation)
    --     for _,player in pairs(self.blueteam_formation) do
    --         for k,val in pairs(player) do
    --             Log(k .. " = " .. val)
    --         end
    --     end

    --     GameToken.SetToken("GameStates.BlueNumAlive",#self.redteam_formation)
    --     Log("Blue team has " .. GameToken.GetToken("GameStates.BlueNumAlive"))
    --     GameToken.SetToken("GameStates.RedNumAlive",#self.blueteam_formation)
    --     Log("Red team has " .. GameToken.GetToken("GameStates.RedNumAlive"))
    -- end

    -- OLD STYLE
    if(bGameStart) then
        local data = CryAction.LoadXML(self.xml_def_path,self.xml_data_path)
        data.version = data.version + 1
        CryAction.SaveXML(self.xml_def_path, self.xml_data_path, data)
        self.time_elapsed = 0.0;
        Log("Spawner:OnReset")
        GameToken.SetToken("GameStates.GameIsRunning",true)
        Log("GameRunning = " .. type(GameToken.GetToken("GameStates.GameIsRunning")))

        if GameToken.GetToken("GameStates.GameIsRunning") == "1" then
            Log("Game has started!")
        end

        GameToken.SetToken("GameStates.BlueNumAlive",self.Properties.iNumberOfPlayers)
        Log("Blue team has " .. GameToken.GetToken("GameStates.BlueNumAlive"))
        GameToken.SetToken("GameStates.RedNumAlive",self.Properties.iNumberOfPlayers)
        Log("Red team has " .. GameToken.GetToken("GameStates.RedNumAlive"))

        playerpos = Spawner:GenerateLocation(self.xmin,self.xmax,self.ymin,self.ymax)
        Log("x=" .. playerpos.x .. " y=" .. playerpos.y .. " theta=" .. playerpos.theta)

        Spawner:SpawnFormation("grunts.Human-red","humans.grunts.Human-red",501,521,523,563)
        Spawner:SpawnFormation("grunts.Human-blue","humans.grunts.Human-blue",478,500,523,563)
    end
end

-- THIS WORKS
function Spawner:SpawnFormation(entityName,entityArchetype,xmin,xmax,ymin,ymax)
    Log("Spawner:SpawnFormation")
    local data = CryAction.LoadXML(self.xml_def_path,self.xml_data_path)
    local len = #data.formation+1
    if(entityName=="grunts.Human-blue") then
        data.formation[len] = {}
        data.formation[len]["win"] = 0
        data.formation[len]["blue_score"] = -1
        data.formation[len]["red_score"] = -1
    end

    for i=1,self.Properties.iNumberOfPlayers do
        --Log("i = " .. i .. " os.time() = " .. os.clock()*1000)
        math.randomseed(os.clock()*1000)
        math.random(); math.random();
        local tempx = math.random(xmin,xmax)
        local tempy = math.random(ymin,ymax)
        local temptheta = math.rad(math.random(0,360))

        local params = {id,
                        class="Human",
                        name= entityName..i,
                        position={x=tempx,y=tempy,z=self.fallHeight}, 
                        orientation={math.cos(temptheta),math.sin(temptheta),0},
                        scale={1,1,1},
                        flags=0,
                        archetype= entityArchetype,
                       }

        System.SpawnEntity(params)
        Log("x,y,theta = ".. tempx ..",".. tempy .."," ..  temptheta)

        if(entityName=="grunts.Human-blue") then
            data.formation[len]["x"..i] = tempx
            data.formation[len]["y"..i] = tempy
            data.formation[len]["theta"..i] = temptheta
            Log("length of the table is " .. #data.formation)
            CryAction.SaveXML(self.xml_def_path, self.xml_data_path, data)
            Log("Saving position data for human "..i)
        end
    end
end
