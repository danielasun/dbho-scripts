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
    generation_size = 10,
    number_of_generations = 10,

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

function Spawner:OnInit()
    self:Activate(1) -- allows you to use OnUpdate
end

function Spawner:EndGame(winningTeam,score)

    -- winningTeam is a string
    -- score is a table with {["bluescore"] = bluenum,["redscore"] = rednum}
    Log("Spawner:EndGame()")
    local data = CryAction.LoadXML(self.xml_def_path,self.xml_data_path)
    data.formation[data.scenario]["blue_score"] = score.bluescore
    data.formation[data.scenario]["red_score"] = score.redscore
    data.formation[data.scenario]["fitness"] = (score.bluescore + (6 - score.redscore))/12
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
end

function Spawner:OnReset(bGameStart)

    if(bGameStart) then
        local LEARNINGOVER = 0
        
        Log("Spawner:OnReset()")
        local data = CryAction.LoadXML(self.xml_def_path,self.xml_data_path)

        -- every generation
        if(data.scenario >= self.generation_size) then
            data.generation = data.generation + 1
            if data.generation <= self.number_of_generations then
                data.scenario = 0 -- never ever finish with scenario = 0
                for i = 1, self.generation_size do
                    data.formation[i]["blue_score"] = -1;
                    data.formation[i]["red_score"] = -1;
                    data.formation[data.scenario]["fitness"] = -1
                end
                Log("GeneticAlgorithm()")
            else
                LEARNINGOVER = 1
                Log("$5 MACHINE LEARNING OVER")
            end
        end

        if LEARNINGOVER == 0 then
            -- every scenario
            data.scenario = data.scenario + 1
            CryAction.SaveXML(self.xml_def_path, self.xml_data_path, data)
            
            -- clear out formations
            self.redteam_formation = {}
            self.blueteam_formation = {}

            -- set the GameTokens
            GameToken.SetToken("GameStates.GameIsRunning",true)
            Log("GameRunning = " .. type(GameToken.GetToken("GameStates.GameIsRunning")))

            if GameToken.GetToken("GameStates.GameIsRunning") == "1" then
                Log("Game has started!")
            end

            GameToken.SetToken("GameStates.BlueNumAlive",self.Properties.iNumberOfPlayers)
            Log("Blue team has " .. GameToken.GetToken("GameStates.BlueNumAlive"))
            GameToken.SetToken("GameStates.RedNumAlive",self.Properties.iNumberOfPlayers)
            Log("Red team has " .. GameToken.GetToken("GameStates.RedNumAlive"))

            -- Red team
            for i=1,self.Properties.iNumberOfPlayers do
                local playerPos = Spawner:GenerateLocation(501,521,523,563)
                self.redteam_formation["x" .. i] = playerPos.x
                self.redteam_formation["y" .. i] = playerPos.y
                self.redteam_formation["theta" .. i] = playerPos.theta
                Spawner:SpawnPlayer("grunts.Human-red", "humans.grunts.Human-red", playerPos,i)
            end

            for k,val in pairs(self.redteam_formation) do
                    Log(k .. " = " .. val)
            end

            -- Blue team
            for i=1,self.Properties.iNumberOfPlayers do
                
                playerPos = {
                    x=data.formation[data.scenario]["x"..i],
                    y=data.formation[data.scenario]["y"..i],
                    theta=data.formation[data.scenario]["theta"..i],
                }

                self.blueteam_formation["x" .. i] = playerPos.x
                self.blueteam_formation["y" .. i] = playerPos.y
                self.blueteam_formation["theta" .. i] = playerPos.theta
                Spawner:SpawnPlayer("grunts.Human-blue","humans.grunts.Human-blue", playerPos,i)
            end

            Log("Number of entries in blueteam_formation is = " .. #self.blueteam_formation)
            for k,val in pairs(self.blueteam_formation) do
                    Log(k .. " = " .. val)
            end
        end
    end

    -- OLD STYLE
    -- if(bGameStart) then
    --     local data = CryAction.LoadXML(self.xml_def_path,self.xml_data_path)
    --     data.version = data.version + 1
    --     CryAction.SaveXML(self.xml_def_path, self.xml_data_path, data)
    --     self.time_elapsed = 0.0;
    --     Log("Spawner:OnReset")
    --     GameToken.SetToken("GameStates.GameIsRunning",true)
    --     Log("GameRunning = " .. type(GameToken.GetToken("GameStates.GameIsRunning")))

    --     if GameToken.GetToken("GameStates.GameIsRunning") == "1" then
    --         Log("Game has started!")
    --     end

    --     GameToken.SetToken("GameStates.BlueNumAlive",self.Properties.iNumberOfPlayers)
    --     Log("Blue team has " .. GameToken.GetToken("GameStates.BlueNumAlive"))
    --     GameToken.SetToken("GameStates.RedNumAlive",self.Properties.iNumberOfPlayers)
    --     Log("Red team has " .. GameToken.GetToken("GameStates.RedNumAlive"))

    --     playerpos = Spawner:GenerateLocation(self.xmin,self.xmax,self.ymin,self.ymax)
    --     Log("x=" .. playerpos.x .. " y=" .. playerpos.y .. " theta=" .. playerpos.theta)

    --     Spawner:SpawnFormation("grunts.Human-red","humans.grunts.Human-red",501,521,523,563)
    --     Spawner:SpawnFormation("grunts.Human-blue","humans.grunts.Human-blue",478,500,523,563)
    -- end
end

-- THIS WORKS
function Spawner:SpawnFormation(entityName,entityArchetype,xmin,xmax,ymin,ymax)
    Log("Spawner:SpawnFormation")
    local data = CryAction.LoadXML(self.xml_def_path,self.xml_data_path)
    local len = #data.formation+1
    if(entityName=="grunts.Human-blue") then
        data.formation[len] = {}
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
