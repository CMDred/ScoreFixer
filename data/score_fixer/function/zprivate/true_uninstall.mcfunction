# Version error checking
execute if score #ScoreFixer.VersionError load.status matches 1 run return run function score_fixer:zprivate/version_error

# Check if it's installed
scoreboard objectives add ScoreFixer.Uninstall dummy
execute if score #ScoreFixer.Init ScoreFixer matches 1 run scoreboard players set #ScoreFixer.Init ScoreFixer.Uninstall 1
execute if score #ScoreFixer.Init ScoreFixer.Uninstall matches 1 run tellraw @a [{text:"🔨 ScoreFixer >> ",color:"#E4B0F7"},{text:"⚠ You need to uninstall ScoreFixer first",color:"red"}]

# Clear all ScoreFixer data
execute unless score #ScoreFixer.Init ScoreFixer.Uninstall matches 1 run data remove storage score_fixer:objectives List
execute unless score #ScoreFixer.Init ScoreFixer.Uninstall matches 1 run data remove storage score_fixer:zprivate Maps
execute unless score #ScoreFixer.Init ScoreFixer.Uninstall matches 1 run data remove storage score_fixer:zprivate Version
execute unless score #ScoreFixer.Init ScoreFixer.Uninstall matches 1 run tellraw @s ["",{text:"🔨 ScoreFixer >> ",color:"#E4B0F7"},"Removed all ScoreFixer data"]

execute unless score #ScoreFixer.Init ScoreFixer.Uninstall matches 1 run scoreboard players reset #ScoreFixer.Init
scoreboard objectives remove ScoreFixer.Uninstall
