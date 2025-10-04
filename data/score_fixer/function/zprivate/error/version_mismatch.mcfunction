tellraw @a [{text:"🔨 ScoreFixer >> ",color:"#E4B0F7"},{text:"⚠ Multiple incompatible versions of ScoreFixer detected. Remove all but one and try again.",color:"red"}]
execute if score #ScoreFixer load.status matches -1 run return fail

# In case it's run in load
scoreboard players set #ScoreFixer load.status -1
scoreboard players reset #ScoreFixer.Version
schedule clear score_fixer:zprivate/tick
