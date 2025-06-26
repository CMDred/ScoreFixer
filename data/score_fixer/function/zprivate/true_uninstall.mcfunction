# Clear all ScoreFixer data
data remove storage score_fixer:objectives List
data remove storage score_fixer:zprivate Maps
data remove storage score_fixer:zprivate Version
tellraw @s ["",{text:"🔨 ScoreFixer >> ",color:"#E4B0F7"},"Removed all ScoreFixer data"]
