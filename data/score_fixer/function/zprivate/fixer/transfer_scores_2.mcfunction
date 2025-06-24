# Recursively copy the objectives to the new player name one by one
$scoreboard players operation $(Name) $(Objective) = $(OldName) $(Objective)

# Next objective
execute if score #ScoreFixer.ObjectiveCount ScoreFixer matches 1 run return 0
scoreboard players remove #ScoreFixer.ObjectiveCount ScoreFixer 1
data remove storage score_fixer:zprivate Temp.Objectives[-1]
data modify storage score_fixer:zprivate Player.Objective set from storage score_fixer:zprivate Temp.Objectives[-1].Name
function score_fixer:zprivate/fixer/transfer_scores_2 with storage score_fixer:zprivate Player
