---@alias RaceType "unranked" | "ranked" | "private" | "pink-slip" | "crew-battle"

---@class Response
---@field success boolean
---@field error? string

---@class RaceSettings
---@field nickname string
---@field chatNotifications boolean
---@field eventNotifications boolean
---@field raceNotifications boolean
---@field comRaceNotifications boolean
---@field hideCheckpointFlares boolean
---@field euTimezone boolean
---@field top5Mode boolean
---@field incognito boolean

---@class Race
---@field id number
---@field raceName string
---@field raceMode RaceMode
---@field vehicleClass string|table<string>
---@field trackId number
---@field ownerStateId number
---@field startTime number
---@field status RaceStatus
---@field players table<string, RacePlayer>
---@field maxPlayers number
---@field minPlayers number
---@field maxLaps number
---@field maxTimeAfterFirstFinish number
---@field season number
---@field tournament number
---@field ghostEnabled GhostTypes
---@field reverseRoute boolean
---@field requiredBid number
---@field currency string
---@field isFirstPerson boolean
---@field chat table<number, ChatMessage>

---@class ChatMessage
---@field nickname string
---@field message string
---@field time number

---@class RaceVehicle
---@field label string
---@field class string
---@field modelHash number
---@field entity number|nil
---@field plate string

---@class RacePlayerHistory
---@field stateId string
---@field raceId number
---@field vehiclePlate string
---@field state RacePlayerState
---@field eloChange number
---@field time number
---@field lapTimes table<number>
---@field position number
---@field anonymousName string|nil

---@class RacePlayer
---@field source number
---@field vehicle RaceVehicle
---@field nickname string
---@field currentCheckpoint number
---@field currentLap number
---@field startTime number
---@field lapTimes table<number>
---@field state RacePlayerState
---@field stateId number
---@field elo number
---@field vehiclePlate string

---@class CrewMember
---@field stateId string
---@field nickname string
---@field profilePicture string
---@field role CrewRole

---@class CrewRole
---@field id string
---@field label string
---@field permissions table<string, boolean>

---@class Crew
---@field id number
---@field name string
---@field tag string
---@field color string
---@field members table<string, string>
---@field createdAt number
---@field elo number
---@field owner number
---@field roles table<string, CrewRole>

---@class CrewSyncObj : Crew
---@field totalRaces number
---@field wonRaces number
---@field lastDeltaElo number
---@field maxMembers number
---@field position number

---@class CrewPlayerBattle
---@field player1 RacePlayer -- + .isReady
---@field player2 RacePlayer -- + .isReady
---@field winner string|nil -- stateId
---@field race Race|nil

---@class CrewBattle
---@field id number
---@field crew1 Crew
---@field crew2 Crew
---@field crew1Members User[]|nil
---@field crew2Members User[]|nil
---@field status CrewBattleStatus
---@field battles CrewPlayerBattle[]
---@field type CrewBattleTypes
---@field vehicleClass string|table<string>
---@field bet number
---@field currency string
---@field winner number|nil -- crewId
---@field eloChange number|nil

---@class CrewBattleTeam
---@field id number
---@field tag string

---@class CrewBattleHistory
---@field id number
---@field crew1 CrewBattleTeam
---@field crew2 CrewBattleTeam
---@field crew1Members string
---@field crew2Members string
---@field status number
---@field type number
---@field classes string
---@field bet number
---@field currency string
---@field winner string|nil
---@field eloChange number|nil
---@field battles string
---@field season number|nil
---@field startTime string

---@class AvailableSeason
---@field id number
---@field name string

---@class SeasonPlayerLastRaces
---@field id number
---@field stateId string
---@field raceId number
---@field vehiclePlate string
---@field state number
---@field eloChange number
---@field time number
---@field vehicleClass string
---@field lapTimes string
---@field fastestLap number|nil
---@field position number|nil
---@field reward number
---@field currency string
---@field anonymousName string|nil
---@field raceName string

---@class SeasonPlayerUsedVehicleStats : OwnedVehicle
---@field totalRaces number
---@field wonRaces number
---@field netElo number
---@field avgPlace number
---@field lastUsed string

---@class SeasonPlayerUsedTrackStats
---@field id number
---@field name string
---@field creatorStateId string
---@field checkpoints string
---@field props string
---@field createdAt string
---@field updatedAt string
---@field isPublished number
---@field isDeleted number
---@field isOfficial number
---@field isVerified number
---@field isFeatured number
---@field isSprint number
---@field totalRaces number
---@field wonRaces number
---@field netElo number
---@field avgPlace number
---@field lastUsed string

---@class SeasonPlayerStats
---@field deltaCash number
---@field totalRaces number
---@field totalTime number
---@field tracksCreated number
---@field avgPlace number
---@field mostRacedClass string
---@field lastRaces SeasonPlayerLastRaces[]
---@field mostUsedVehicles SeasonPlayerUsedVehicleStats[]
---@field mostPlayedTracks SeasonPlayerUsedTrackStats[]

---@class TrackStat
---@field avgTime number|nil
---@field bestTime number|nil
---@field personalBest number|nil
---@field totalRaces number
---@field leaderboard table

---@class SeasonTrackStats
---@field casual TrackStat
---@field ranked TrackStat

---@class Season
---@field id number
---@field name string
---@field startDate number
---@field endDate number
---@field isCurrent boolean
---@field isFinished boolean

---@class BattleList
---@field column table<number, Battle[]>

---@class Battle
---@field id number
---@field team1 RacePlayer[]
---@field team2 RacePlayer[]
---@field player1Score number
---@field player2Score number
---@field winner number

---@class Tournament
---@field id number
---@field name string
---@field creatorStateId number
---@field createdAt number
---@field isPublished boolean
---@field isDeleted boolean
---@field isOfficial boolean
---@field isVerified boolean
---@field isFeatured boolean
---@field tournamentType TournamentType
---@field races number[] Race ids
---@field battleBO TournamentBattleBO|nil
---@field players number[]
---@field status TournamentStatus
---@field battles BattleList

---@class Checkpoint
---@field id number
---@field coords vector4
---@field modelIndex number
---@field distBetweenProps number Applicable only to tires, cones etc

---@class Prop
---@field id number
---@field coords vector4
---@field model string

---@class Track
---@field id number
---@field name string
---@field checkpoints Checkpoint[]
---@field props Prop[]
---@field creatorStateId string
---@field createdAt number
---@field updatedAt number
---@field isPublished boolean
---@field isDeleted boolean
---@field isOfficial boolean
---@field isVerified boolean
---@field isFeatured boolean
---@field isSprint boolean
---@field bestTime number

---@class User
---@field source number
---@field stateId string|number
---@field nickname string
---@field profilePicture string|nil
---@field elo number
---@field crew number|nil
---@field crewTag string|nil
---@field incognito boolean
---@field dailyEnd number
---@field gotDaily boolean
---@field euTimezone boolean

---@class UserLastRace
---@field id number
---@field stateId string
---@field raceId number
---@field vehiclePlate string
---@field state number
---@field eloChange number
---@field time number
---@field vehicleClass string
---@field lapTimes string
---@field fastestLap number|nil
---@field position number|nil
---@field reward number
---@field currency string
---@field anonymousName string|nil
---@field raceName string
---@field raceMode string
---@field trackId number
---@field ownerStateId string
---@field startTime string
---@field status number
---@field maxPlayers number
---@field minPlayers number
---@field maxLaps number
---@field maxTimeAfterFirstFinish number
---@field season number|nil
---@field tournament number|nil
---@field ghostEnabled number
---@field reverseRoute number
---@field requiredBid number
---@field isFirstPerson number
---@field crewBattle number|nil
---@field password string|nil
---@field isPrivate number
---@field euTimezone number
---@field additionalReward number
---@field positionRewards string

---@class RacingCurrency
---@field name string
---@field label string
---@field floor boolean
---@field isCrypto boolean

---@class DailyReward
---@field type string
---@field racesRequired number
---@field redeemed boolean

---@class SeasonReward
---@field id number
---@field description string

---@class ChatMessage
---@field nickname string
---@field message string
---@field time number

-- NUI Posts
---@class NUIPostLoadRace
---@field id number

---@class NUIPostLoadTracks
---@field query string
---@field offset number
---@field filter string
---@field sorting string

---@class NUIPostLoadSeason
---@field seasonId number

---@class NUIPostLoadLeaderboardUsers
---@field season number
---@field query string
---@field offset number

---@class NUIPostSearchProfiles
---@field query string

---@class NUIPostLoadProfile
---@field stateId string

---@class NUIPostLoadProfileData
---@field stateId string
---@field seasonId number

---@class NUIPostGetReward
---@field query string

---@class NUIPostCreateRace
---@field track Track
---@field name string
---@field playerAmount number
---@field requiredBid number
---@field additionalReward number
---@field maxLaps number
---@field classes string[]
---@field ghostEnabled number
---@field invertRoute boolean
---@field startTime number
---@field isFirstPerson boolean
---@field password string
---@field plate string
---@field raceMode RaceType
---@field isRanked boolean

---@class NUIPostStartRace
---@field raceId number
---@field trackId number

---@class NUIPostLeaveRace
---@field raceId number

---@class NUIPostSetWaypoint
---@field raceId number
---@field trackId number
---@field reverseRoute boolean

---@class NUIPostJoinRace
---@field raceId number
---@field plate string

---@class NUIPostFindPrivateRace
---@field password string

---@class NUIPostLoadProfileInfo
---@field stateId string
---@field seasonId number
---@field offset number

---@class NUIPostSendChatMsg
---@field chatId string
---@field message string

---@class NUIPostGetAvailableVehs
---@field class string[]

---@class NUIPostSaveSettings : RaceSettings

---@class NUIPostSetFavourite
---@field id number
---@field favourite boolean

---@class NUIPostKickPlayer
---@field raceId number
---@field stateId string
---@field isBanned boolean

---@class NUIPostAdminUpdateTrack
---@field trackId number
---@field key "isFeatured" | "isOfficial" | "isVerified"
---@field value boolean

---@class NUIPostDeleteTrack
---@field trackId number

---@class NUIPostDeleteRace
---@field raceId number

---@class NUIPostLoadCrewBattle
---@field battleId number

---@class NUIPostLoadCrew
---@field crewId number

---@class NUIPostCrewBattleReady
---@field battleId number
---@field plate string

---@class NUIPostForfeitCrewBattle
---@field battleId number

---@class NUIPostJoinCrewBattle
---@field battleId number
---@field members User[]

---@class NUIPostCreateBattle
---@field type CrewBattleTypes
---@field classes string[]
---@field bet number
---@field currency string
---@field selectedMembers string[]

---@class NUIPostLoadCrewBattleHsty
---@field offset number

---@class NUIPostLoadTrack
---@field id number

---@class NUIPostLoadTrackData
---@field seasonId number
---@field trackId number
---@field raceType RaceType

---@class NUIPostLoadCrew
---@field seasonId number
---@field tournamentId number
---@field query string
---@field offset number

---@class NUIPostCreateCrew
---@field name string
---@field tag string
---@field color string

---@class NUIPostLeaveCrew
---@field crewId number

---@class NUIPostInviteMember
---@field nickname string
---@field roleId number

---@class NUIPostKickCrewMember
---@field crewId number
---@field stateId string

---@class NUIPostSubscribe
---@field type "activeRaces" | "crewBattle" | "activeCrewBattles" | "home" | "race"
---@field value boolean
---@field data table

---@class NUIPostCreateCrewRole
---@field crewId number
---@field name string
---@field permissions table<string, boolean>

---@class NUIPostUpdateCrewRole
---@field crewId number
---@field roleId number
---@field name string
---@field permissions table<string, boolean>

---@class NUIPostRemoveCrewRole
---@field crewId number
---@field roleId number

---@class NUIPostSetCrewMemberRole
---@field crewId number
---@field stateId string
---@field roleId number

---@class NUIPostClaimSeasonReward
---@field id number

--- NUI Callbacks
---@class NUICBLeaderboardUser : User
---@field mostUsedVehicle OwnedVehicle

---@class NUICBLoadedProfile : User
---@field currentSeasonId number
---@field availableSeasons table<number, AvailableSeason>
---@field loadedData table<number, SeasonPlayerStats>

---@class NUICBRewardItem
---@field name string
---@field label string

---@class NUICBRewardVehicle
---@field model string
---@field label string

---@class NUICBCreatedRace : Response
---@field id? number

---@class NUICBGetTrack : Track
---@field currentSeasonId number
---@field availableSeasons table<number, AvailableSeason>
---@field creator string
---@field isFavourite boolean
---@field loadedData table<number, SeasonTrackStats>

---@class NUICBFoundPrivateRace : Response
---@field race? Race

---@class NUICBRedeemReward : Response
---@field reward DailyReward[]

---@class NUICBAdminUpdateTrack : Response
---@field track Track

---@class NUICBJoinCrewBattle : Response
---@field battleId number

---@class NUICBCreateBattle : Response
---@field battleId number

---@class NUICBLoadHomeRewards
---@field races number
---@field maxRaces number
---@field endTimestamp number
---@field rewards DailyReward[]

---@class NUICBLoadHomeHotTrack
---@field id number
---@field name string
---@field creatorStateId string
---@field checkpoints string
---@field props string
---@field createdAt string
---@field updatedAt string
---@field isPublished number
---@field isDeleted number
---@field isOfficial number
---@field isVerified number
---@field isFeatured number
---@field isSprint number
---@field bestTime number|nil

---@class NUICBLoadHome : RaceSettings
---@field dailyReward NUICBLoadHomeRewards
---@field currentElo number
---@field lastRaces UserLastRace[]
---@field activeRaces Race[]
---@field hotTracks NUICBLoadHomeHotTrack[]
---@field popularTracks Track[]
---@field newTracks Track[]
---@field nickname string
---@field incognito boolean
---@field euTimezone boolean
---@field seasonRewards SeasonReward[]
---@field canCreateTracks boolean

---@class NUICBCreateCrew : Response
---@field crew CrewSyncObj

---@class NUICBClaimSeasonReward : Response
---@field remainingRewards SeasonReward[]
