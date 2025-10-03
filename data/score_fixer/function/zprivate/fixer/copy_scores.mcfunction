# Recursively copy the objectives to the player name one by one
# (Note): I check if the objective is in the list in case it gets removed from it. In this case, I don't want to copy it over to the player anymore.
$execute if data storage score_fixer:objectives List[{Name:$(Name)}] run scoreboard players set @s $(Name) $(Value)

# Next objective
execute if score #ScoreFixer.ObjectiveCount ScoreFixer matches 1 run return 0
scoreboard players remove #ScoreFixer.ObjectiveCount ScoreFixer 1
data remove storage score_fixer:zprivate Temp.Objectives[-1]
function score_fixer:zprivate/fixer/copy_scores with storage score_fixer:zprivate Temp.Objectives[-1]
