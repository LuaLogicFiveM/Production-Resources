['drug_drops_box'] = {
    label = "Suspicious Box",
    weight = 5000,
    stack = false,
    buttons = {
        {
            label = 'Unbox',
            action = function(slot)
                TriggerServerEvent('prp-drug-drops:server:openDrugBox', slot)
            end,
        }
    }
}