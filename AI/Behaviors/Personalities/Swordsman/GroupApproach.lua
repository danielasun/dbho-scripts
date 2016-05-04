-- SwordsmanApproach behavior.
-- Based on a file created by the_grim

local Behavior = CreateAIBehavior("GroupApproach",
{
    Alertness = 2,

    Constructor = function (self, entity)
        Log("============")
        Log("Approaching!");
        Log("============")
        entity:SelectPipe(0, "group_approach");    
    end,

    Destructor = function(self, entity)
    end,

    OnGroupMemberDiedNearest = function ( self, entity, sender,data)
        Log("Oh FUCK");
        AI.SetBehaviorVariable(entity.id, "Alerted", true);
    end,

    OnGroupMemberDied = function( self, entity, sender)
        AI.SetBehaviorVariable(entity.id, "Alerted", true);        
    end,

    AnalyzeSituation = function (self, entity, sender, data)
        local range = 2.5;
        local distance = AI.GetAttentionTargetDistance(entity.id);

        Log("Distance in approach:");
        Log(distance);

        if(distance > (range)) then
            AI.SetBehaviorVariable(entity.id, "IsAttackRange", false);
        elseif(distance < (range)) then
            AI.SetBehaviorVariable(entity.id, "IsAttackRange", true);
        end

    end,
})
