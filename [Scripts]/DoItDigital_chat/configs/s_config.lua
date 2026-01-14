-- The FrameWork You Are Using Can Be: ESX, QBCore, Other, Auto (Automatically Detect) , (For QBox Use QBCore or Auto)
FrameWorkInUse = 'ESX' 
--Who Can Edit Chat , Can Use Steam Or Discord Or License 
chatEditors ={
	["discord:1005645750077771797"] = true,
}
-- Default Chat Channel , if player doesn't use any chat command we will use this channel
defaultChat = 'ooc'
--Command To Open Chat Editor
chatEditorCommand = 'chateditor'

showJoins = false -- Show Join Messages
showLeaves = false -- Show Leave Messages

-- Chat Message Limit Per Player Per Second Per Message Type
SpamProtection = {
	["me"] = 5,  -- disabled
    ["twt"] = 10000,   -- 10 seconds
	["pd"] = 5000, -- 5 seconds
	["ad"] = 60000, -- 15 seconds
}

EnableChatLogger = true -- Enable Chat Logger
WriteLogsEveryXMessages = 50 -- Write Logs Every X Messages
AllowUsersToChangeTheme = true -- Allow Users To Change Theme
AllowUsersToChangeSettings = true -- Setting This To False Will Disable (change font,size,and chat position for players) And Use The Values Set By Server Admins)

--STAFFS ONLY
staffCanWriteInAllChats = true

--ENABLE NAME PERKS SYSTEM
enableNamePerks = false -- Enable Name Perks System [you can edit namePerksEditable.lua to add your own logic]
namePerksPrice = 50000 -- Price For Name Perks [you can edit namePerksEditable.lua to add your own logic]
defaultNamePerk = "chatfx1" -- range from chatfx1 to chatfx8


--BAD WORDS FILTER
badWords = {
    "nigg",
    "n1gg",
    "n199",
	"fag",
	"fagg",
	"f@g",
	"f@9",
	"coon",
	"nigger",
	"faggot",
	"queer",
	"kys",
	"negger",
	"niger",
	"niqer",
	"niqqer",
	"666",
	"666hub.org",
	"666hub",
	"si666r"
}