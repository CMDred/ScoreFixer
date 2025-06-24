# Recursively copy the objectives and values to the backup one by one
$execute store success score #ScoreFixer.HasScoreValue ScoreFixer if score $(Player) $(Name) matches ..2147483647
$data modify storage score_fixer:zprivate Backups[-1].Data append value {Objective:$(Name)}
$execute store result storage score_fixer:zprivate Backups[-1].Data[-1].Value int 1 run scoreboard players get $(Player) $(Name)
execute if score #ScoreFixer.HasScoreValue ScoreFixer matches 0 run data remove storage score_fixer:zprivate Backups[-1].Data[-1]

# Next objective
execute if score #ScoreFixer.ObjectiveCount ScoreFixer matches 1 run return 0
scoreboard players remove #ScoreFixer.ObjectiveCount ScoreFixer 1
data remove storage score_fixer:zprivate Temp.Objectives[-1]
data modify storage score_fixer:zprivate Temp.Objectives[-1].Player set from storage score_fixer:zprivate Temp.CurrentMap.Name
function score_fixer:zprivate/fixer/create_backup_2 with storage score_fixer:zprivate Temp.Objectives[-1]
