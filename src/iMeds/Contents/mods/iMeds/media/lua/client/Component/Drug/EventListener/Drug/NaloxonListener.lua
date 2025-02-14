local normalEffect = function()
    if not Survivor:isInitialized() or Survivor:getBlood():getDrugs()[Naloxon.alias] == nil then
        return false
    end

    if Survivor:getBlood():getDrugs()[Naloxon.alias].isActive then
        ---@type OpiateStorage
        local opiateStorage = ZCore:getContainer():get('imeds.drug.storage.opiate_storage')
        for _, drug in pairs(opiateStorage:findAll()) do
            if Survivor:getBlood():getDrugs()[drug:getAlias()] ~= nil then
                Survivor:getBlood():getDrugs()[drug:getAlias()].onset = 0
                Survivor:getBlood():getDrugs()[drug:getAlias()].duration = 0
                Survivor:getBlood():getDrugs()[drug:getAlias()].dose = 0
                Survivor:getBlood():getDrugs()[drug:getAlias()].isActive = false
                Survivor:getBlood():getDrugs()[drug:getAlias()].isOverdose = false
                Survivor:getBlood():getDrugs()[drug:getAlias()].isOverdoseEffectApplied = false
            end
        end
    end
end

local overdoseEffect = function()
    if not Survivor:isInitialized() or Survivor:getBlood():getDrugs()[Naloxon.alias] == nil then
        return false
    end

    if not Survivor:getBlood():getDrugs()[Naloxon.alias].isOverdose then
        return false
    end

    if not Survivor:getBlood():getDrugs()[Naloxon.alias].isOverdoseEffectApplied then
        Survivor:setFoodSicknessLevel(80)
        Survivor:setPainReductionFromMeds(0)

        Survivor:getBlood():getDrugs()[Naloxon.alias].isOverdoseEffectApplied = true
    end
end

Events.OnTick.Add(normalEffect)
Events.OnTick.Add(overdoseEffect)