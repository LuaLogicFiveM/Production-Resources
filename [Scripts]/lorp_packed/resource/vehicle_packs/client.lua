local function SpawnVehicle(vehicleModel)
    local model = type(vehicleModel) == 'number' and vehicleModel or joaat(vehicleModel)
    local vector = GetEntityCoords(cache.ped)
    local networked = true

    if not vector then return end

    CreateThread(function()
        if not IsModelInCdimage(model) then
            return lib.notify({title = 'Vehicle Packs', description = 'This vehicle is not in the server, please make a ticket if this was in the server previously', type = 'error', position = 'top'})
        end

        lib.requestModel(model)

        local vehicle = CreateVehicle(model, vector.x, vector.y, vector.z, GetEntityHeading(cache.ped), networked, true)

        if networked then
            SetEntityAsMissionEntity(vehicle, true, true)
        end

        SetVehicleHasBeenOwnedByPlayer(vehicle, true)
        SetVehicleNeedsToBeHotwired(vehicle, false)
        SetModelAsNoLongerNeeded(model)
        SetVehRadioStation(vehicle, 'OFF')
        TaskWarpPedIntoVehicle(cache.ped, vehicle, -1)

        RequestCollisionAtCoord(vector.x, vector.y, vector.z)
        while not HasCollisionLoadedAroundEntity(vehicle) do
            Wait(0)
        end
    end)
end


CreateThread(function()
    lib.registerContext({
        id = 'VehicleMenu',
        title = 'Vehicle Packs Menu',
        options = {
            {
                title = 'Drift Pack',
                arrow = true,
                icon = 'car',
                menu = 'DriftMenu',
            },
            {
                title = 'Drag Pack',
                arrow = true,
                icon = 'car',
                menu = 'DragMenu',
            },
            {
                title = 'Lowrider Pack',
                arrow = true,
                icon = 'car',
                menu = 'LowMenu',
            },
            {
                title = 'Motorcycle Pack',
                arrow = true,
                icon = 'car',
                menu = 'BikeMenu',
            },
            {
                title = 'Mini Car Pack',
                arrow = true,
                icon = 'car',
                menu = 'MiniCarMenu',
            },
            {
                title = 'Squatted Pack',
                arrow = true,
                icon = 'car',
                menu = 'SquattedMenu',
            },
            {
                title = 'Booster Pack',
                arrow = true,
                icon = 'car',
                menu = 'BoosterMenu',
            },
            {
                title = 'Pilots Pack',
                arrow = true,
                icon = 'car',
                menu = 'PilotsMenu',
            },
            {
                title = '4x4/Mud Truck Pack',
                arrow = true,
                icon = 'car',
                menu = 'MudMenu',
            },
            {
                title = 'Dirt Car Pack',
                arrow = true,
                icon = 'car',
                menu = 'DirtMenu',
            },
            {
                title = 'Slider Pack',
                arrow = true,
                icon = 'car',
                menu = 'SliderMenu',
            },
            {
                title = 'IRL Pack',
                arrow = true,
                icon = 'car',
                menu = 'IRLMenu',
            },
            {
                title = 'Car Pack',
                arrow = true,
                icon = 'car',
                menu = 'CarMenu',
            },
            {
                title = 'Diesel Pack',
                arrow = true,
                icon = 'car',
                menu = 'DieselMenu',
            }
        }
    })

    lib.registerContext({
        id = 'BoosterMenu',
        title = 'Booster Vehicle Menu',
        menu = 'VehicleMenu',
        options = {
            {
                title = 'Iroc',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('gstiroc')
                end,
            },
            {
                title = 'Ram',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('gstramv1')
                end,
            },
            {
                title = 'Concept',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('CONCEPTR')
                end,
            },
            {
                title = 'Hellacious',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('hellacious')
                end,
            },
            {
                title = 'Redeye Super Stock',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('RedeyeSuperstockSCV2')
                end,
            },
            {
                title = 'Octaviavrs',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('xk21octaviavrs')
                end,
            },
            {
                title = 'M4',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('m4f82')
                end,
            },
            {
                title = 'Cullinan',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('cullinank')
                end,
            },
            {
                title = '2ncsx7',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('2ncsx7')
                end,
            }
        }
    })

    lib.registerContext({
        id = 'BikeMenu',
        title = 'Motorcycle Vehicle Menu',
        menu = 'VehicleMenu',
        options = {
            {
                title = 'Motorcycle 1',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('ghostsching')
                end,
            },
            {
                title = 'Motorcycle 2',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('ghostscholo')
                end,
            },
            {
                title = 'Motorcycle 3',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('ghostscholo7')
                end,
            },
            {
                title = 'Motorcycle 4',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('THEREAPERCHOP24')
                end,
            },
            {
                title = 'Motorcycle 5',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('HELLSPAWN')
                end,
            },
            {
                title = 'Motorcycle 5',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('NAGLFAR')
                end,
            },
            {
                title = 'Motorcycle 6',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('DARKFATE')
                end,
            },
        }
    })

    lib.registerContext({
        id = 'SquattedMenu',
        title = 'Squatted Vehicle Menu',
        menu = 'VehicleMenu',
        options = {
            {
                title = 'OBS Silverado',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('TIMBOSOBS')
                end,
            },
            {
                title = '2018 Ford F150',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('tremsearsf150')
                end,
            },
            {
                title = 'Chevy Tahoe',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('rgntwoodyv1')
                end,
            },
            {
                title = 'Chevy Cateye',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('tullypussykitty')
                end,
            },
            {
                title = 'New Body',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('slipsnewbody')
                end,
            },
            {
                title = 'Ford Cruzin',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('willyscruzin')
                end,
            },
            {
                title = 'Squatted Minivan',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('mininigga')
                end,
            },
            {
                title = '2020 Single Cab GMC Sierra',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('joes20sierra ')
                end,
            }
        }
    })

    lib.registerContext({
        id = 'MiniCarMenu',
        title = 'Mini Car Menu',
        menu = 'VehicleMenu',
        options = {
            {
                title = 'a90',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('minia90lema')
                end,
            },
            {
                title = 'Agera',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('miniageralema')
                end,
            },
            {
                title = 'Mini Cooper',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('minicag')
                end,
            },
            {
                title = 'dv4r',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('minidv4rlema')
                end,
            },
            {
                title = 'Evoque',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('minievoque')
                end,
            },
            {
                title = 'Ferrari',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('miniferrarilema')
                end,
            },
            {
                title = 'Volkswagen Golf',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('minigolflema')
                end,
            },
            {
                title = 'GTR',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('gtrag')
                end,
            },
            {
                title = 'Squatted Minivan',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('mininigga')
                end,
            },
            {
                title = 'Jeep',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('jeepag')
                end,
            },
            {
                title = 'Miata',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('minimiatalema')
                end,
            },
            {
                title = 'mk4',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('minimk4lema')
                end,
            },
            {
                title = 'Moster Truck',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('minimonsterlema')
                end,
            },
            {
                title = 'Antique Car',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('mouseag')
                end,
            },
            {
                title = 'Mustang',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('mustangag')
                end,
            },
            {
                title = 'Ninja',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('minininjalema')
                end,
            },
            {
                title = 'r33',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('r33hs')
                end,
            },
            {
                title = 'Porche',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('porscheag')
                end,
            },

            {
                title = 'r34',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('minir34lema')
                end,
            },
            {
                title = 's14',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('minis14lema')
                end,
            },
            {
                title = 'Viper',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('MiniViperLema')
                end,
            },
            {
                title = '6x6',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('minixclasslema')
                end,
            },
            {
                title = 'Lego Chiron',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('legochiron')
                end,
            },
            {
                title = 'Lego Porche',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('legoporsche')
                end,
            },
            {
                title = 'Lego McLaren',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('lsen')
                end,
            }
        }
    })

    lib.registerContext({
        id = 'LowMenu',
        title = 'Lowrider Vehicle Menu',
        menu = 'VehicleMenu',
        options = {
            {
                title = '1958 Impala',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('58DROP')
                end,
            },
            {
                title = '1963 Impala',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('RAY63')
                end,
            },
            {
                title = '1959 Impala',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('IMPALA59C')
                end,
            },
            {
                title = '1964 Impala',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('RAY64')
                end,
            },
            {
                title = '1975 Caprice',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('CHECO75')
                end,
            },
        }
    })

    lib.registerContext({
        id = 'DragMenu',
        title = 'Drag Vehicle Menu',
        menu = 'VehicleMenu',
        options = {
            {
                title = 'Hellcat',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('kkslimcharger')
                end,
            },
            {
                title = '69 Camaro',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('beastmode1')
                end,
            },
            {
                title = '69 Camaro 2',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('beastmodesl')
                end,
            },
            {
                title = 'Trailer for 69 Camaros',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('beastmodetrailer')
                end,
            },
            {
                title = 'Pro Mod Camaro',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('fireballcamaro')
                end,
            },
            {
                title = 'Pro Mod Audi',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('joesnarcos')
                end,
            },
            {
                title = 'Cletus Leroy',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('leroy')
                end,
            },
            {
                title = 'Drag Strip Pro Tree',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('ProTree')
                end,
            },
            {
                title = 'Mustang',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('saleendionR')
                end,
            },
            {
                title = 'Drag TrackHwawk',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('vanzdragth')
                end,
            },
            {
                title = 'Drag Car',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('VengmaliN')
                end,
            },
            {
                title = 'Drag 2011 Camaro',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('Waffleztwistedtea')
                end,
            },
            {
                title = 'Drag C10',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('zaccdragc')
                end,
            },
            {
                title = 'Drag Trackhawk',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('DTRACKHAWK')
                end,
            },
            {
                title = 'Corvette C7 ZR1',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('dzr1drag')
                end,
            },
            {
                title = 'g4eye',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('g4eye')
                end,
            },
            {
                title = 'Drag Challenger',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('joesmxrda')
                end,
            },
            {
                title = 'Foxbody',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('kiki')
                end,
            },
            {
                title = '1996 Camaro',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('MadMax')
                end,
            },
            {
                title = 'ProMod C6',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('VengeanceRadialVette')
                end,
            },
            {
                title = 'El Camino',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('vengelco3')
                end,
            },
            {
                title = 'El Camino SS',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('VengKane')
                end,
            },
            {
                title = '2024 Mustang GT',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('CHASEDRAGGT24')
                end,
            },
            {
                title = 'EVO IX',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('ABEVOIXDRAG')
                end,
            },
            {
                title = 'C7 R1',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('C7ZR1D')
                end,
            },
            {
                title = 'Black WidowR',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('BLACKWIDOWR')
                end,
            },
            {
                title = '2019 ZL1',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('cfesprozl1')
                end,
            },
            {
                title = 'C6 Big Turbo',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('09SC6')
                end,
            },
        }
    })

    lib.registerContext({
        id = 'DriftMenu',
        title = 'Drift Vehicle Menu',
        menu = 'VehicleMenu',
        options = {
            {
                title = 'S14',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('JDZENKIS14')
                end,
            },
            {
                title = '1984 rx7',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('84rx7k')
                end,
            },
            {
                title = '1986 Toyota Karma',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('86karma')
                end,
            },
            {
                title = 'Nissan 180sx',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('180sxrb')
                end,
            },
            {
                title = '240sx',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('240sxhr')
                end,
            },
            {
                title = 'Nissan 370z',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('370zh')
                end,
            },
            {
                title = 'BMW 328',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('328nii')
                end,
            },
            {
                title = 'Anubis',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('anubis')
                end,
            },
            {
                title = 'Skyline GTR',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('daisx')
                end,
            },
            {
                title = 'Altezza',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('driftaltezza')
                end,
            },
            {
                title = 'Ram',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('driftram')
                end,
            },
            {
                title = 'Honda s15',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('drifts15')
                end,
            },
            {
                title = 'e2000',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('e2000')
                end,
            },
            {
                title = 'er34',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('er34')
                end,
            },
            {
                title = 'gtrh',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('gtrh')
                end,
            },
            {
                title = 'Mazda rx7',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('hotwaterlab')
                end,
            },
            {
                title = 'MonalisaFF3',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('MonalisaFF3')
                end,
            },
            {
                title = 's13',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('s13neverlift')
                end,
            },
            {
                title = 's14 hachi',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('s14hachi')
                end,
            },

            {
                title = 's15',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('s15rbjr')
                end,
            },
            {
                title = 'Titan',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('titanh')
                end,
            },
            {
                title = 'Supercharged Mustang',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('ugc13gt')
                end,
            },
            {
                title = '2007 WRX ',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('07wrx')
                end,
            },
            {
                title = 'Charger',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('blockparty')
                end,
            },
            {
                title = 'Drift C6 Corvette',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('GODzC6FD')
                end,
            },
            {
                title = 'Drift s15',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('S145Drift')
                end,
            },
            {
                title = 'Mitsubishi Dift Van',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('carXsuz')
                end,
            },
            {
                title = '240',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('freebo240')
                end,
            },
            {
                title = 'Drift Supra',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('GODzA90DRIFT')
                end,
            }
        }
    })

    lib.registerContext({
        id = 'PilotsMenu',
        title = 'Pilots Vehicle Menu',
        menu = 'VehicleMenu',
        options = {
            {
                title = 'B-21 Raider',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('b21raider')
                end,
            },
            {
                title = 'Lockheed Darkstar',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('darkstar')
                end,
            },
            {
                title = 'F-15C Eagle',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('eagle')
                end,
            },
            {
                title = 'F-14D Tomcat',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('f14d2')
                end,
            },
            {
                title = 'F-15E Strike Eagle',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('f15e')
                end,
            },
            {
                title = 'F22A',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('f22a')
                end,
            },
            {
                title = 'Kawac',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('kawac2')
                end,
            },
            {
                title = 'HESA Shaded 136',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('shahed136')
                end,
            },
            {
                title = 'Sky Baloon',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('spybaloon')
                end,
            },
            {
                title = 'X-02S Strike Wyvern',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('wyvern')
                end,
            }
        }
    })

    lib.registerContext({
        id = 'MudMenu',
        title = '4x4/Mud Truck Vehicle Menu',
        menu = 'VehicleMenu',
        options = {
            {
                title = '2015 Yukon',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('damudtrok')
                end,
            },
            {
                title = 'F350',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('johnnymudtrok')
                end,
            },
            {
                title = '1950 Chevy',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('skoopsmudtruck')
                end,
            },
            {
                title = 'OBS F350',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('tyymegaford')
                end,
            },
            {
                title = '2020 F350',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('sdmega350')
                end,
            },
            {
                title = 'Offroad Mustang',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('gt500offroad')
                end,
            },
            {
                title = 'F350 Flatbed',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('joesrickynigv4')
                end,
            },
            {
                title = 'OG Bronco',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('apexdon')
                end,
            },
            {
                title = '2018 F150',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('doughboymudtrok')
                end,
            },
            {
                title = 'Taco Truck',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('elaniptaco')
                end,
            }
        }
    })

    lib.registerContext({
        id = 'DirtMenu',
        title = 'Dirt Car Vehicle Menu',
        menu = 'VehicleMenu',
        options = {
            {
                title = 'crimsonlm',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('crimsonlm')
                end,
            },
            {
                title = 'sprintcar',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('sprintcar')
                end,
            },
            {
                title = 'USRAMOD',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('USRAMOD')
                end,
            },
            {
                title = 'SuperLateModel',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('SuperLateModel')
                end,
            },
            {
                title = 'openbmod',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('openbmod')
                end,
            },
            {
                title = '2017krypt',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('StreetStock')
                end,
            },
            {
                title = 'StreetStock',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('StreetStock')
                end,
            },
            {
                title = 'scarlm ',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('scarlm')
                end,
            }
        }
    })

    lib.registerContext({
        id = 'CarMenu',
        title = 'Car Vehicle Menu',
        menu = 'VehicleMenu',
        options = {
            {
                title = 'Cambered Tesla',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('joesjohnnyv4')
                end,
            },
            {
                title = 'BMW',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('M3BXANE')
                end,
            },
            {
                title = 'Miata',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('mazfd')
                end,
            },
            {
                title = '2015 Mustang',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('rmodmustangs')
                end,
            },
            {
                title = 'Lambo Aventador',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('aventador')
                end,
            },
            {
                title = 'Camaro ZL1',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('ZL1Hycade')
                end,
            },
            {
                title = 'Ferrari',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('f8snlargog')
                end,
            },
            {
                title = 'Widebody Kia',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('16k5bk_sj')
                end,
            },
            {
                title = 'Track Spec Charger',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('GODzTRACKCAT')
                end,
            }
        }
    })

    lib.registerContext({
        id = 'DieselMenu',
        title = 'Diesel Truck Menu',
        menu = 'VehicleMenu',
        options = {
            {
                title = '5th Gen Cummins',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('joessuperv3')
                end,
            }
        }
    })

    lib.registerContext({
        id = 'SliderMenu',
        title = 'Slider Vehicle Menu',
        menu = 'VehicleMenu',
        options = {
            {
                title = 'Asea',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('asea')
                end,
            },
            {
                title = 'Volvo Wagon',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('jifamily')
                end,
            },
            {
                title = 'Dropped AMG',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('dc_s63wald')
                end,
            },
            {
                title = 'Black Escalade',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('escaladesport')
                end,
            },
            {
                title = 'Toyota SUV',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('lcbeast')
                end,
            },
            {
                title = 'TrackHawk',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('morhawk')
                end,
            },
            {
                title = 'Black Audi',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('scarnrs3')
                end,
            },
            {
                title = 'BMW',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('bmwm8hamann')
                end,
            }
        }
    })

    lib.registerContext({
        id = 'IRLMenu',
        title = 'IRL Vehicle Menu',
        menu = 'VehicleMenu',
        options = {
            {
                title = 'Chriss Twin Turbo Sierra',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('cmusg')
                end,
            },
            {
                title = 'Luke Laytons S14 Silverado',
                icon = 'car',
                onSelect = function()
                    SpawnVehicle('tor15luke')
                end,
            }
        }
    })
end)

RegisterCommand('vehiclepacks', function()
    lib.showContext('VehicleMenu')
end, false)

lib.onCache('seat', function(seat)
    if seat ~= -1 then return end
    TriggerServerEvent('lorp_packed:server:requestCheck', VehToNet(cache.vehicle))
end)