# Toggle the load message
scoreboard players add #ScoreFixer.ShowLoadMessage ScoreFixer 1
execute unless score #ScoreFixer.ShowLoadMessage ScoreFixer matches 1 run scoreboard players set #ScoreFixer.ShowLoadMessage ScoreFixer 0

# Tellraw
execute if score #ScoreFixer.ShowLoadMessage ScoreFixer matches 0 run tellraw @s ["",{text:"ScoreFixer >> ",color:"#C1EA53"},"Disabled the load message"]
execute if score #ScoreFixer.ShowLoadMessage ScoreFixer matches 1 run tellraw @s ["",{text:"ScoreFixer >> ",color:"#C1EA53"},"Enabled the load message"]
