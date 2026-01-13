CodeStudio = {}

CodeStudio.AutoSQL = true

-- 'QB' = For QBCore Framework
-- 'ESX' = For ESX Framework

CodeStudio.ServerType = 'ESX'    --QB|ESX

CodeStudio.OpenUI = {
    OpenWithKey = true,
    DefaultOpenKey = 'F4',       --Player can change this by going into settings
    OpenWithCommand = true,     --Must be true if you want to use OpenWithKey
    OpenCommandName = 'jobs',

    LocationBased = false,       --If You Enable this Player can access menu from particular location
    Target = 'qb-target',               --qb-target/ox_target
    TargetPed = `ig_car3guy2`,
    Location = vector4(-1084.88, -248.31, 36.76, 197),  --LifeInvader (*Tip: if ped is above ground then -1 in z)
}

CodeStudio.AdminCommands = {
    EnableAdminCommands = true,         --Whether to allow admin commands to add and delete players job
    AdminAddJobCommand = 'addjob',      --Add Job Command
    AdminRemoveJobCommand = 'removejob', --Remove Job Command
    DiscordLogs = true,  -- Put webhook to enable admin logs
    AdminRoles = {  --Admins to access commands
        'owner',
        'manager',
        'admin',
        'mod'
    }
}


CodeStudio.AllowAutoJobSavining = true  -- Whenever Player recieves job it will automatically register that job into multi job menu
CodeStudio.Animation = true             --Enable Animation when they open UI
CodeStudio.EnableDuty = false            --Enable Toggle Duty On/Off Feature
CodeStudio.Currency = "$"               --Salary Currency 

CodeStudio.MaxJobs = { --Maximum ALlowed Jobs in Multi Job Menu
    Default = 10,        --Default Max Job 
    Allowed = {     --Customizable Max Job based on Ace Perms, Identifers(Discord/Steam/Fivem)
        --['discord:968848387132772434'] = 6,
        -- ['discord:968848387132772434'] = 8,
    },
    WhiteListJob = {  --These Jobs will not count towards max jobs
        'police',
    }
}

--Non Removable Deafulat Jobs in Multi job Menu (Deafult jobs that players cant delete)--

CodeStudio.DefaultJobs = {
    {job = 'unemployed', grade = '0'},
}
