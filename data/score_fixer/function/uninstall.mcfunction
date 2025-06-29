# Check if it's installed
scoreboard objectives add ScoreFixer.Uninstall dummy
execute if score #ScoreFixer.Init ScoreFixer matches 1 run scoreboard players set #ScoreFixer.Init ScoreFixer.Uninstall 1
execute unless score #ScoreFixer.Init ScoreFixer.Uninstall matches 1 run tellraw @a [{text:"🔨 ScoreFixer >> ",color:"#E4B0F7"},{text:"⚠ Could not uninstall ScoreFixer. Is it installed?",color:"red"}]
execute unless score #ScoreFixer.Init ScoreFixer.Uninstall matches 1 run return run scoreboard objectives remove ScoreFixer.Uninstall
scoreboard objectives remove ScoreFixer.Uninstall

# Tellraw
tellraw @s ["",{text:"🔨 ScoreFixer >> ",color:"#E4B0F7"},"Uninstalled ScoreFixer (v1.0.1)"]
tellraw @s ["",{text:"🔨 ScoreFixer >> ",color:"#E4B0F7"},"Also remove all associated data? ",{text:"[Yes]",bold:true,color:"red",click_event:{action:"run_command",command:"/function score_fixer:zprivate/true_uninstall"},hover_event:{action:"show_text",value:["",{text:"WARNING:",color:"dark_red"}," Scores only get transferred to the new name once the player joins. Any scores that have not yet been applied will be lost forever.\n\n",{text:"Click to remove all data!",color:"yellow"}]}}]

# Set ScoreFixer version in data storage (For potential datafixing when installing a newer version)
data modify storage score_fixer:zprivate Version set value 1

data modify storage score_fixer:zprivate Maps[].IsOffline set value 1b

# Remove scoreboards & data storages
scoreboard objectives remove ScoreFixer

scoreboard players reset #ScoreFixer.Init
scoreboard players reset #ScoreFixer.ShowLoadMessage
scoreboard players reset #ScoreFixer.PlayerCount
scoreboard players reset #ScoreFixer.OnlinePlayerCount
scoreboard players reset #ScoreFixer.HasValue
scoreboard players reset #ScoreFixer.EntryCount
scoreboard players reset #ScoreFixer.MapExists
scoreboard players reset #ScoreFixer.IsDifferentUUID
scoreboard players reset #ScoreFixer.WasModified
scoreboard players reset #ScoreFixer.IsHexadecimal
scoreboard players reset #ScoreFixer.NameExists

data remove storage score_fixer:zprivate Player
data remove storage score_fixer:zprivate OnlinePlayers
data remove storage score_fixer:zprivate Temp
data remove storage score_fixer:loaded Players

# Stop the tick function
schedule clear score_fixer:zprivate/tick
