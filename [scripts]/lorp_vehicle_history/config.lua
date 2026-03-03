Config = {}

Config.Framework = 'auto'
Config.Inventory = 'auto'
Config.Target = 'auto'
Config.Debug = false
Config.RateLimitMs = 1500

Config.UseMileage = false
Config.UseJgMileage = true
Config.JgMileageResource = 'jg-vehiclemileage'
Config.PlateMaxLength = 12
Config.VinLength = 17
Config.DefaultRegistrationStatus = 'valid'
Config.ReportIdPattern = 'CARFAX-AAAA-111111'
Config.VinPattern = 'AAAAAAAA111111111'

Config.PhysicalReport = {
    enabled = true,
    price = 250,
    moneyType = 'cash',
    item = 'carfax_report',
    searchRadius = 12.0,
    ped = {
        model = 's_m_m_highsec_01',
        coords = vec3(241.0123, -1378.9858, 32.7418),
        heading = 144.7703,
        scenario = 'WORLD_HUMAN_CLIPBOARD'
    },
    zone = {
        type = 'box',
        coords = vec3(241.4962, -1394.3303, 30.1211),
        size = vec3(6.0, 6.0, 4.0),
        rotation = 0.0,
        debug = true
    },
    target = {
        label = 'target_carfax_request',
        icon = 'fa-solid fa-file-lines',
        distance = 2.0
    }
}

Config.AdminGroups = {'owner', 'manager'}
Config.AdminAce = 'group.manager'

Config.Commands = {
    service = {
        name = 'servicecar',
        job = nil,
        description = 'command_service_description'
    },
    incident = {
        name = 'incident',
        job = {
            sheriff = 0,
            sahp = 0,
            dot = 0
        },
        description = 'command_incident_description'
    },
    owneredit = {
        name = 'owneredit',
        job = {
            pdm = 0,
            dmv = 0
        },
        description = 'command_owner_description'
    },
    carfax = {
        name = 'carfax',
        job = nil,
        description = 'command_carfax_description'
    },
    vin = {
        name = 'vin',
        job = nil,
        description = 'command_vin_description'
    }
    -- debugmode = {
    --     name = 'debugmode',
    --     job = nil,
    --     adminOnly = true,
    --     description = 'command_debug_description'
    -- }
}

Config.JobLabels = {
    mechanic = 'job_label_mechanic',
    police = 'job_label_police',
    dmv = 'job_label_dmv'
}

Config.ServiceTypes = {{
    value = 'oil_change',
    label = 'service_type_oil_change'
}, {
    value = 'engine_repair',
    label = 'service_type_engine_repair'
}, {
    value = 'body_repair',
    label = 'service_type_body_repair'
}, {
    value = 'full_inspection',
    label = 'service_type_full_inspection'
}, {
    value = 'custom',
    label = 'service_type_custom'
}}

Config.IncidentTypes = {{
    value = 'insurance_claim',
    label = 'incident_type_insurance_claim',
    private = false
}, {
    value = 'impound',
    label = 'incident_type_impound',
    private = false
}, {
    value = 'total_loss',
    label = 'incident_type_total_loss',
    private = false
}, {
    value = 'police_seizure',
    label = 'incident_type_police_seizure',
    private = false
}, {
    value = 'stolen_report',
    label = 'incident_type_stolen_report',
    private = true
}}

Config.RegistrationStatuses = {{
    value = 'valid',
    label = 'registration_valid'
}, {
    value = 'expired',
    label = 'registration_expired'
}, {
    value = 'suspended',
    label = 'registration_suspended'
}, {
    value = 'revoked',
    label = 'registration_revoked'
}}

Config.ReportVisibility = {
    showIdentifiers = {
        sheriff = true,
        sahp = true,
        dmv = true
    },
    showPrivateIncidents = {
        sheriff = true,
        sahp = true,
        dmv = true
    }
}

Config.TextLimits = {
    notes = 240,
    customLabel = 48,
    jobLabel = 48
}
