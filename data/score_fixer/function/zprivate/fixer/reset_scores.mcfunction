# Recursively reset the objectives for the player name one by one
# (Note): I check if the objective is in the list in case it gets removed from it. In this case, I don't want to reset it for the player anymore.
$scoreboard players reset @s $(Name)

# Next objective
execute if score #ScoreFixer.ObjectiveCount ScoreFixer matches 1 run return 0
scoreboard players remove #ScoreFixer.ObjectiveCount ScoreFixer 1
data remove storage score_fixer:zprivate Temp.Objectives[-1]
function score_fixer:zprivate/fixer/reset_scores with storage score_fixer:zprivate Temp.Objectives[-1]
