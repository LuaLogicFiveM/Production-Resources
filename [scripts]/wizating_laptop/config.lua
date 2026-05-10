Config = {
   Command = false,
   CommandName = 'tuning',

   -- Laptop Discord webhook
   useWebHook = false,
   webHook = "https://discord.com/api/webhooks/...................",   -- REPLACE WITH YOUR WEBHOOK URL
   username = "Wizating Laptop Tune Logs",                        -- MESSAGE USERNAME
   avatar_url = "https://i.imgur.com/M8wQNrr.png",                     -- MESSAGE AVATAR IMAGE

   resetLaptopPos = "resetLaptopPos", -- Command which will set the laptop postion back to default

   ItemName = 'tuners_laptop',
   JobRoles = { ---- need to use a framework to set this true
      [1] = {name = "mechanic" , minJobGrade = 0 },
   },

   useESX = true,
   esxObject = 'esx:getSharedObject', -- What your getSharedObject is named, if you have renamed it.
   useESXitem = false,
   restrictToESXJob = false,

   useQB = false,
   qbObject = 'qb-core', -- Object or export name
   useQBitem = false,
   restrictToQBJob = false,

   useVRP = false,
   useVRPitem = false,
   restrictToVRPJob = false,

   --- PLATES --
   PlateDebug = false,
   Plates = "custom", --  spaces || mixed 
   --|| "trimmed - Works for all normal 8 character plates removes all whitespace and spaces ||
   --|| "spaces - Works for vehicleshop that have spaces in plates but remove the white space at the end of the plate ||
   --|| "mixed - Works for QB or users with esx_vehicleshop ||
   --|| "custom - Works for all Spaces Normally best option ||

   ------ SQL INFO CHANGE THESE TO MATCH YOURS -----
   UseOwnedVehicles  = false, -- change this to true if using owned vehicles and set up the tables to match your framework
   ownedVehicles = 'CHANGE ME', ----  change this to the table name of your owned vehicles
   vehiclePlate = 'CHANGE ME', ---- change this to the column name where you store your numberplates in your owned vehicles table

   DeleteUnownedVehiclesFromSQL = true, ----- when using the with above it will add a 1 into the database where the owned column is if a user owns the vehicle. 
   -- Then on server restart the script will look for every car with 0 in the owned column and remove them from your database.
   -- CAUTION TURNING THIS TO TRUE WITHOUT CORRECTLY SETTING UP THE ABOVE WILL REMOVE ALL TUNES AS THE VEHICLE WILL ALWAYS BE UNOWNED TO THE SCRIPT

   ------ DYNO ---------- 
   -- THIS IS FOR THE LAPTOPS DYNO SYSTEM, 
   -- DO NOT USE THIS IF USING WIZATING DYNO. 
   UseDyno = false, --- SETTING TO FALSE REMOVES THE LAPTOPS DYNO USE 
   WHPMODIFIER = 410, --- lower or higher this value to increase or decrease the hp values shown on dyno.
   TQMODIFIER = 1.185, --- lower or higher this value to increase or decrease the torque values shown on dyno.
   DynoMarker = false,
   DynoUseMaxDistance = 5.0,
   DynoLocations = { 
      --{ x = -223.9 , y = -1330.09 , z = 30.89 },
      --{ x =  0.0, y =  0.0, z =  0.0 }, ----- add cords here
   },

   ------ LOCK TO RACETRACK LOCATIONS --- SET TO FALSE TO USE LAPTOP NORMALLY
   -- this only allows the laptop to be used within this location , once leaving said zone vehicle returns to default handling and vice versa.
   OnlyTuneInLocations = false,
   TuneMaxDistanceFromLocations = 100.0,
   TuneLocations = {
      --[1] = { x = -72.97 , y = -1757.15 , z = 29.51 },
      --[2] = { x = 104.15 , y = 156.09 , z = 104.72 } 
      --- will need to add to a ',' to the end of the previous coords
      -- if you want to add more then two locations and make sure to follow number order.
      -- [3] = { x = 0.0 , y = 0.0 , z =  0.0}, 
      -- [4] = { x = 0.0 , y = 0.0 , z =  0.0} ----- example
   },




   -----//// LAPTOP MODES ----///
   --- OPTIONS AVAILABLE ---
   -- "BOTH" -- // allows full access to tuning -- USERS CAN SELECT WHICH TO USE

   --// THIS WILL LOCK THE LAPTOP INTO THESE MODES NOT ALLOWING USERS TO CHANGE \\--
   -- "SIMPLE"-- // allows only SIMPLE tuning
   -- "ADVANCED" // allows advanced tuning  --- THIS IS HOW THE LAPTOP WOULD BE BEFORE THE NEW MODE SYSTEM.

   laptopModes = "BOTH", 



   -------//////// Laptop Handling Data //////////
   -- the data here shows in the laptop if you want to add something that is not already here from the handling.meta You can. Aslong as it only needs a single value. EG XYZ Values will not work ATM 

   --- THE ADD A NEW PIECE OF DATA THIS IS HOW THE TABLE IS CONSTRUCTED. You would need to follow this order or you will create an error.
   -- [INSERT ORDERED TABLE NUMBER HERE] = { HANDLINGMETANAME = { MIN, MAX, 'INFORMATION POPUP TEXT'}}


   -- ALWAYS MAKE SURE THE TABLE IS IN NUMBER ORDER OR YOU WILL CAUSE ISSUES. 1 2 3 4 ETC 

   -- if you do NOT want players to be able to modify something here you can simply remove it and reorder the table numbers

   -----//////// ADVANCED /////////
   -----//////// ADVANCED /////////
   -----//////// ADVANCED /////////
   -----//////// ADVANCED /////////
   traction = {                       --  MIN, MAX, INFORMATION POPUP TEXT
      [1] = { fTractionCurveMax         = { 0, 8.7, 'Cornering grip of the vehicle as a multi of the tire surface friction.'}},
      [2] = { fTractionCurveMin         = { 0, 8.5, 'Accelerating/braking grip of the vehicle as a multi of the tire surface friction.' }},
      [3] = { fTractionBiasFront        = { 0.01, 0.99,'Determines the distribution of traction from front to rear.<br>0.01 = only rear axle has traction.<br>0.99 = only front axle has traction.<br>0.5 = both axles have equal traction.<br>Entering a value of 0.0 or 1.0 causes the vehicle to have no traction.'}},
      [4] = { fTractionLossMult         = { 0, 1.4, 'Affects how much grip is changed when driving on asphalt and mud <br>- Higher values make the car less responsive and prone to sliding.' }},
      [5] = { fLowSpeedTractionLossMult = { 0, 2.2, "How much traction is reduced at low speed.<br>0.0 means normal traction. It affects mainly car burnout when accelerating.<br>Decreasing value will cause less burnout, less sliding at start.<br>Higher value will cause more burnout." }},
      [6] = { fTractionCurveLateral     = { 0, 120.0, 'Shape of lateral traction curve. <br> - The degress of angle before the car loses grip.'}},
      [7] = { fTractionSpringDeltaMax   = { 0.1, 0.5, 'This value determines at what distance above the ground the car will lose traction.'}},
      [8] = { fSteeringLock             = { 0, 75.0, "Multi of the game's calculation of the angle a steer wheel will turn while at full turn.<br> Steering lock is directly related to turning radius." }},
   },

   power = {
      [1] = { fDriveInertia            = { 0.1, 10.0, "Describes how fast an engine will rev.<br>Default value is 1.0, (or no modification of drive intertia). <br> Bigger values = quicker Redline (maximum engine speed)" }},
      [2] = { fInitialDriveForce       = { 0, 3.0 , "This modifies the game's calculation of drive force (from the output of the transmission).<br>1.0 uses drive force calculation unmodified. <br>Values less than 1.0 will in effect give the vehicle less drive force. <br> Values greater than 1.0 will produce more drive force."}},
      [3] = { fDriveBiasFront          = { 0, 1.0, "This value is used to determine whether a vehicles drive.<br>Value: 0.0 is rear wheel drive<br> 1.0 is front wheel drive<br> Any value between 0.01 and 0.99 is four wheel drive <br>(0.5 give both front and rear axles equal force, being perfect 4WD.)"}},
      [4] = { fInitialDragCoeff        = { 1.0, 30.0, "Sets the drag coefficient of the vehicle.<br> Increase to simulate aerodynamic drag."}},
      [5] = { fInitialDriveMaxFlatVel  = { 100, 330.0, "Determines the speed at redline in top gear <br> Controls the final drive of the vehicle's gearbox. <br> Multiply the number by 0.82 to get the speed in mph <br> Multiply by 1.32 to get kph. <br>Setting this value does not guarantee the vehicle will reach this speed." }},
      [6] = { fClutchChangeRateScaleUpShift   = { 0.3, 9.0 , "Clutch speed multi on up shifts.<br> Bigger numbers = faster shifts."}},
      [7] = { fClutchChangeRateScaleDownShift = { 0.3, 9.0, "Clutch speed multi on down shifts.<br> Bigger numbers = faster shifts" }},
   },

   brakes = {
      [1] = { fBrakeBiasFront        = { 0, 0.8 ,"This controls the distribution of braking force between the front and rear axle.<br> 0.0 means the rear axle only receives brake force<br> 1.0 means the front axle only receives brake force<br> 0.5 gives both axles equal brake force."}},
      [2] = { fBrakeForce            = { 0.01, 5.0 , "Multiplies the game's calculation of deceleration.<br>- Bigger number = harder braking." }},
      [3] = { fHandBrakeForce        = { 0.01, 5.0 , "Braking power for handbrake. <br> Bigger number = harder braking" }},
   },

   suspension = {
      [1] = { fSuspensionForce       = { 0, 9.0, "Affects how strong suspension is.<br> Can help if car is easily flipped over when turning.<br> Lower limit for zero force at full extension." }},   
      [2] = { fSuspensionReboundDamp = { 0, 10.8, "Damping during strut rebound. <br> Bigger = stiffer." }},  
      [3] = { fSuspensionCompDamp    = { 0, 8.0, "Damping during strut compression. <br> Bigger = stiffer"}},  
      [4] = { fSuspensionBiasFront   = { 0, 0.8, "Force damping scale front/back. <br>If more wheels at back (e.g. trucks) need front suspension to be stronger.<br>This value determines which suspension is stronger, front or rear.<br>If value is above 0.50 then front is stiffer, when below, rear."}}, 
      [5] = { fSuspensionUpperLimit  = { 0, 1.0, "How far can wheels move up from original position." }},  
      [6] = { fSuspensionLowerLimit  = { -1.0, 0, "How far can wheels move down from original position."}},                             
      [7] = { fAntiRollBarForce      = { 0, 5.0, "The spring constant that is transmitted to the opposite wheel <br> under compression larger numbers are a larger force.<br> Larger Numbers = less body roll" }},
      [8] = { fAntiRollBarBiasFront  = { 0, 1.0, "The bias between front and rear for the antiroll bar. <br> 0 front, 1 rear" }},
      [9] = { fRollCentreHeightFront = { -1.0, 1.2 , "The roll center height for the front axle.<br>High values place the roll center closer to the center of mass, reducing body roll. <br>Values placing the roll center higher than the center of mass will induce negative body roll.<br>Low values increase the roll center distance from the center of mass, increasing body roll.<br>Values placing the roll center too far from the center of mass may increase rollover chances."}},
      [10] = { fRollCentreHeightRear = { -1.0, 1.2, "The roll center height for the rear axle.<br>High values place the roll center closer to the center of mass, reducing body roll.<br>Values placing the roll center higher than the center of mass will induce negative body roll. <br>Low values increase the roll center distance from the center of mass, increasing body roll. <br>Values placing the roll center too far from the center of mass may increase rollover chances."}},
      [11] = { fSuspensionRaise = { 0, 5.0, "The amount that the suspension raises the body off the wheels. <br>Recommend adjusting at second decimal unless vehicle has room to move. <br>ie -0.02 is plenty of drop on an already low car."}},
   },

   -----//////// BASIC /////////
   -----//////// BASIC /////////
   -----//////// BASIC /////////
   -----//////// BASIC /////////




   ---                                      !IMPORTANT!   READ ME         READ ME       READ ME     READ ME    READ ME   !IMPORTANT!
   --[[
   
      This simple version of the tuner allows you to let new users play with laptop in a more stress free manor, 
      allowing you to create presets with sliders that they could tweak to finalise the handling to their liking. 
      
      This could also be used to help train them to understanding what to change on a vehicle.
   ]]



   -- CorneringGrip WILL DISPLAY IN THE LATOP AS Cornering Grip 
   -- IF YOU WANT TO MAKE A NEW SLIDER TO ONE OF THE PRESETS BE SURE TOO
   -- NOT USE SPACES. USE CAPS TO CREATE THE SPACE IN THE UI
   -- ALL OF THESE TABLES ARE EDITABLE. 

   
   -- WARNING!! EDITING THE TABLE INCORRECTLY WILL BREAK THE SCRIPT SO BE SURE TO BACK UP CONFIGS INCASE OF MISTAKES.

   tunerHandlingPresets = {   --            VALUES THE LAPTOP SLIDERS WILL EDIT. YOU CAN STACK MULTIPLE IN A SECTION TO SIMPLIFY TUNING.

      race = {                              -- THE MIN AND MAX ARE MULTIPLICATIONS OF THE VALUES SET BELOW -- 

                                          -- THESE ARE STILL CONFINED BY YOUR MIN MAX NUMBERS IN THE ADVANCED SECTION. 

                                          -- IF YOU DO NOT CARE ABOUT THERE BEING MIN AND MAX NUMBERS, PUT THE MIN, MAX THERE TO HIGHER NUMBERS THEN BELOW CAN REACH. 

                                          -- MAKE SURE THEY ARE WITHIN GTA CONSTRAINTS. CERTAIN VALUES GOING TO LOW OR HIGH WILL CAUSE THE VEHICLE TO BREAK.

                                             -- make sure handling.meta data begin with f and are formatted correctly ...   fHandBrakeForce  <--- MAKE SURE CAPITALS ARE EXACTLY THE SAME AS META FILE.
      [1] = { ['CorneringGrip'] = { popup = "Add or remove cornering grip from the vehicle" , multi = {min = 0.5 , max = 1.5}, fTractionCurveMax = 2.95, fTractionCurveMin = 2.6 }},
      [2] = { ['Braking']       = { popup = "Increase or decrease your braking forces." , multi = {min = 0.5 , max = 1.5}, fBrakeForce = 2.5, fHandBrakeForce = 2.5}},
      [3] = { ['BrakeBias']     = { popup = "Increase to move brake bias more towards the front" , multi = {min = 0.5 , max = 1.5}, fBrakeBiasFront = 0.60}},
      [4] = { ['Acceleration']  = { popup = "Increase or decrease cars power" , multi = {min = 0.5 , max = 1.5}, fInitialDriveForce = 0.5, fDriveInertia = 1.0, fClutchChangeRateScaleDownShift = 5.0, fClutchChangeRateScaleUpShift = 5.0}},
      [5] = { ['TopSpeed']      = { popup = "Increase or decrease the top Speed of your vehicle. ( EDITING THIS VALUE AFFECTS POWER OF REST OF TUNE)" ,multi = {min = 0.5 , max = 1.5}, fInitialDriveMaxFlatVel = 160.0 }},


         -- DATA INSIDE HERE WILL BE PERSISTENT TO THE MODE, USERS CANNOT CHANGE THESE. 
         -- THEY WILL BE SET WHEN TUNING IN THIS SECTION.
         [6] = { ['Persistent']     = {
                                    fTractionCurveLateral = 23.0, 
                                    fLowSpeedTractionLossMult = 0.1,
                                    fDriveInertia = 1.0 ,
                                    }}
      },
      cruise = {
      [1] = { ['CorneringGrip'] = { popup = "Add or remove cornering grip from the vehicle" , multi = {min = 0.5 , max = 1.5}, fTractionCurveMax = 2.75, fTractionCurveMin = 2.45 }},
      [2] = { ['Braking']       = { popup = "Increase or decrease your braking forces." , multi = {min = 0.5 , max = 1.5}, fBrakeForce = 2.5, fHandBrakeForce = 2.5}},
      [3] = { ['Acceleration']  = { popup = "Increase or decrease cars power", multi = {min = 0.5 , max = 1.5}, fInitialDriveForce = 0.25, fDriveInertia = 0.45, fClutchChangeRateScaleDownShift = 2.0, fClutchChangeRateScaleUpShift = 2.0}},
      [4] = { ['TopSpeed']      = { popup = "Increase or decrease the top Speed of your vehicle. ( EDITING THIS VALUE AFFECTS POWER OF REST OF TUNE)", multi = {min = 0.5 , max = 1.5}, fInitialDriveMaxFlatVel = 130.0}}
      },

      drift = {                                       
      [1] = { ['TyreGrip']       = { popup = "Increase or decrease base tyre grip", multi = {min = 0.75 , max = 1.5}, fTractionCurveMax = 1.75, fTractionCurveMin = 2.0}},
      [2] = { ['Brakes']         = { popup = "Increase or decrease your braking forces." , multi = {min = 0.25 , max = 2.0}, fBrakeForce = 0.5}},
      [3] = { ['HandBrakePower'] = { popup = "Increase or decrease your handbrake force." , multi = {min = 0.5 , max = 1.5}, fHandBrakeForce = 2.5}},
      [4] = { ['BrakeBias']      = { popup = "Increase to move brake bias more towards the front" , multi = {min = 0.5 , max = 1.5}, fBrakeBiasFront = 0.75}},
      [5] = { ['TractionBias']   = { popup = "Increase or decrease front wheel grip.( higher means lower rear grip)" , multi = {min = 0.9 , max = 1.2}, fTractionBiasFront = 0.60}},
      [6] = { ['SteeringAngle']  = { popup = "Increase or decrease the maximum steering angle the vehicle can achieve" , multi = {min = 0.75 , max = 1.25}, fSteeringLock = 60.0 }},
      [7] = { ['Acceleration']   = { popup = "Increase or decrease cars power" , multi = {min = 0.5 , max = 2.0}, fInitialDriveForce = 0.5}},
      [8] = { ['TopSpeed']       = { popup = "Increase or decrease the top Speed of your vehicle. ( EDITING THIS VALUE AFFECTS POWER OF REST OF TUNE)", multi = {min = 0.75 , max = 2.0}, fInitialDriveMaxFlatVel = 180.0 }},

      -- DATA INSIDE HERE WILL BE PERSISTENT TO THE MODE, USERS CANNOT CHANGE THESE. 
      -- THEY WILL BE SET WHEN TUNING IN THIS SECTION.
      [9] = { ['Persistent']     = {
                                    fTractionCurveLateral = 100.0, 
                                    fLowSpeedTractionLossMult = 0.1,
                                    fDriveBiasFront = 0.0,
                                    fDriveInertia = 1.0 ,
                                    fClutchChangeRateScaleDownShift = 6.0,
                                    fClutchChangeRateScaleUpShift = 6.0,
                                    }}
      },

      drag = {
      [1] = { ['StraightLineGrip'] = { popup = "Increase or decrease base tyre grip", multi = {min = 0.5 , max = 1.5}, fTractionCurveMax = 3.55, fTractionCurveMin = 3.15 }},
      [2] = { ['Braking']          = { popup = "Increase or decrease your braking forces.", multi = {min = 0.5 , max = 1.5}, fBrakeForce = 3.5}},
      [3] = { ['Drivebias']        = { popup = "Increase or decrease front axle drive.", multi = {min = 0.5 , max = 1.5}, fTractionBiasFront = 0.45, fDriveBiasFront = 0.45 }},
      [4] = { ['Acceleration']     = { popup = "Increase or decrease cars power",multi = {min = 0.5 , max = 1.5}, fInitialDriveForce = 0.75, fDriveInertia = 1.0, fClutchChangeRateScaleDownShift = 5.0, fClutchChangeRateScaleUpShift = 5.0}},
      [5] = { ['TopSpeed']         = { popup = "Increase or decrease the top Speed of your vehicle. ( EDITING THIS VALUE AFFECTS POWER OF REST OF TUNE)", multi = {min = 0.5 , max = 1.5}, fInitialDriveMaxFlatVel = 185.0 }},
            -- DATA INSIDE HERE WILL BE PERSISTENT TO THE MODE, USERS CANNOT CHANGE THESE. 
      -- THEY WILL BE SET WHEN TUNING IN THIS SECTION.
      [6] = { ['Persistent']     = {
                                    fTractionCurveLateral = 21.0, 
                                    fSteeringLock = 45.0,
                                    fInitialDragCoeff = 9.0,
                                    fLowSpeedTractionLossMult = 0.0,
                                    }}
      },

   },


   ------------------///// MOTOR BIKE ///// -------------
   ---- Bikes are handled differently in GTA In our testing these are the only handling floats worth changing. 

   -- if you want to disallow any of these for the motorbikes. you can remove it or add more. 

   -- PLEASE NOTE you will need it to be in the table above if you want it in the bikes data table also.

   bikeData = {
      "fTractionCurveMax",
      "fTractionCurveMin",
      "fTractionLossMult",
      "fTractionCurveLateral",
      "fTractionSpringDeltaMax",
      "fTractionBiasFront",
      "fLowSpeedTractionLossMult",
      "fInitialDriveForce",
      "fDriveInertia",
      "fClutchChangeRateScaleUpShift",
      "fClutchChangeRateScaleDownShift",
      "fInitialDragCoeff",
      "fBrakeForce",
      "fHandBrakeForce",
      "fInitialDriveMaxFlatVel",
      "fBrakeBiasFront",
      "fSuspensionForce",
      "fSuspensionCompDamp",
      "fSuspensionUpperLimit",
      "fSuspensionLowerLimit",
      "fSteeringLock",
      "fRollCentreHeightFront",
      "fRollCentreHeightRear",
      "fSuspensionReboundDamp",
      "fSuspensionBiasFront"
   },

   tuningRestriction = "blacklist", -- or "whitelist"
   carlist = { "ELEGY" },
   ------
   -- NOTIFICATIONS
   ------

   notification1 = 'Race Tune : ON',
   notification2 = 'Preset Deleted!',
   notification3 = 'Cars handling has been reset to default',
   notification4 = 'You need to be in a vehicle to use the laptop',
   notification5 = 'You need to select a preset before trying to share',
   notification6 = 'No player near you!',
   notification7 = 'Target is not the closet player',
   notification8 = 'Vehicle Tuned',
   notification9 = 'You need to be at the race track to use the laptop',
   notification10 = 'You do not have the required item to use this!',
   notification11 = 'Race Tune : OFF',
   notification12 = 'This vehicle is blocked from tuning!',
   notification15 = 'Dyno iniatilized start revving your engines Press [E] again to finish',
   notification16 = 'Dyno has finished open up your laptop!!',
   notification17 = 'Preset Selected',
   notification18 = 'Laptop position reset, you can now reopen the laptop if in a vehicle.',
}