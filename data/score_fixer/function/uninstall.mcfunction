# Check if it's installed
scoreboard objectives add ScoreFixer.Uninstall dummy
execute if score #ScoreFixer.Init ScoreFixer matches 1 run scoreboard players set #ScoreFixer.Init ScoreFixer.Uninstall 1
execute unless score #ScoreFixer.Init ScoreFixer.Uninstall matches 1 run tellraw @a [{text:"🔨 ScoreFixer >> ",color:"#E4B0F7"},{text:"⚠ Could not uninstall ScoreFixer. Is it installed?",color:"red"}]
execute unless score #ScoreFixer.Init ScoreFixer.Uninstall matches 1 run return run scoreboard objectives remove ScoreFixer.Uninstall
scoreboard objectives remove ScoreFixer.Uninstall

# Tellraw
tellraw @s ["",{text:"🔨 ScoreFixer >> ",color:"#E4B0F7"},"Uninstalled ScoreFixer (v1.0.0)"]

# Remove scoreboards & data storages
scoreboard objectives remove ScoreFixer
scoreboard objectives remove ScoreFixer.IsOnline

scoreboard players reset #ScoreFixer.Init
scoreboard players reset #ScoreFixer.ShowLoadMessage
scoreboard players reset #ScoreFixer.PlayerCount
scoreboard players reset #ScoreFixer.OnlinePlayerCount
scoreboard players reset #ScoreFixer.HasScoreValue
scoreboard players reset #ScoreFixer.ObjectiveCount
scoreboard players reset #ScoreFixer.MapExists
scoreboard players reset #ScoreFixer.IsDifferentUUID

data remove storage score_fixer:objectives List
data remove storage score_fixer:zprivate Backups
data remove storage score_fixer:zprivate Maps
data remove storage score_fixer:zprivate Player
data remove storage score_fixer:zprivate Temp

# Stop the tick function
schedule clear score_fixer:zprivate/tick
