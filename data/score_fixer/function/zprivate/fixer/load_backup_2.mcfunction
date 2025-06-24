# Recursively copy the objectives to the new player name one by one
$scoreboard players set $(Player) $(Objective) $(Value)

# Next objective
execute if score #ScoreFixer.ObjectiveCount ScoreFixer matches 1 run return 0
scoreboard players remove #ScoreFixer.ObjectiveCount ScoreFixer 1
data remove storage score_fixer:zprivate Temp.CurrentBackup.Data[-1]
data modify storage score_fixer:zprivate Temp.CurrentBackup.Data[-1].Player set from storage score_fixer:zprivate Player.Name
function score_fixer:zprivate/fixer/load_backup_2 with storage score_fixer:zprivate Temp.CurrentBackup.Data[-1]
