# Get the number of tracked objectives
execute store result score #ScoreFixer.ObjectiveCount ScoreFixer if data storage score_fixer:objectives List[]

# Copy each objective to the new player name
execute if score #ScoreFixer.ObjectiveCount ScoreFixer matches 1.. run data modify storage score_fixer:zprivate Temp.Objectives set from storage score_fixer:objectives List
execute if score #ScoreFixer.ObjectiveCount ScoreFixer matches 1.. run data modify storage score_fixer:zprivate Player.Objective set from storage score_fixer:zprivate Temp.Objectives[-1].Name
execute if score #ScoreFixer.ObjectiveCount ScoreFixer matches 1.. run function score_fixer:zprivate/fixer/transfer_scores_2 with storage score_fixer:zprivate Player

# Reset the old player name's scores
$scoreboard players reset $(OldName)
