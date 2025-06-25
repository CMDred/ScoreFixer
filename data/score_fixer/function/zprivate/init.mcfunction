# Init
scoreboard players set #ScoreFixer.Init ScoreFixer 1
execute unless score #ScoreFixer.ShowLoadMessage ScoreFixer matches 0 run scoreboard players set #ScoreFixer.ShowLoadMessage ScoreFixer 1

# Scoreboards
scoreboard objectives add ScoreFixer.IsOnline dummy

# Data Storages
data modify storage score_fixer:objectives List set value []
data modify storage score_fixer:zprivate OnlinePlayers set value []

# Tellraw
tellraw @a ["",{text:"🔨 ScoreFixer >> ",color:"#E4B0F7"},"Installed ScoreFixer (v1.0.0)"]
tellraw @a ["",{text:"🔨 ScoreFixer >> ",color:"#E4B0F7"},{text:"Click here",bold:true,color:"yellow",click_event:{action:"run_command",command:"/function score_fixer:settings/toggle_load_message"},hover_event:{action:"show_text",value:["/function score_fixer:settings/toggle_load_message"]}}," to toggle the load message"]
execute if score #ScoreFixer.ShowLoadMessage ScoreFixer matches 1 run tellraw @a ""
