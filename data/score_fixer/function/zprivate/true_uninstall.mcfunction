# Clear all ScoreFixer data
data remove storage score_fixer:objectives List
data remove storage score_fixer:zprivate Maps
data remove storage score_fixer:zprivate Version
data modify storage score_fixer:zprivate Maps[].IsOffline set value 1b
tellraw @s ["",{text:"🔨 ScoreFixer >> ",color:"#E4B0F7"},"Removed all ScoreFixer data"]
