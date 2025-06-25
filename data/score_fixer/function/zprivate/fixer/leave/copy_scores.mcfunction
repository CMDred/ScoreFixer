# Recursively copy the objectives and values to the map one by one
$execute store success score #ScoreFixer.HasValue ScoreFixer if score $(Player) $(Name) matches ..2147483647
data modify storage score_fixer:zprivate Temp.CurrentMap.Objectives append value {}
data modify storage score_fixer:zprivate Temp.CurrentMap.Objectives[-1].Name set from storage score_fixer:zprivate Temp.Objectives[-1]
$execute store result storage score_fixer:zprivate Temp.CurrentMap.Objectives[-1].Value int 1 run scoreboard players get $(Player) $(Name)
execute if score #ScoreFixer.HasValue ScoreFixer matches 0 run data remove storage score_fixer:zprivate Temp.CurrentMap.Objectives[-1]

# Next objective
execute if score #ScoreFixer.EntryCount ScoreFixer matches 1 run return 0
scoreboard players remove #ScoreFixer.EntryCount ScoreFixer 1
data remove storage score_fixer:zprivate Temp.Objectives[-1]
data modify storage score_fixer:zprivate Temp.Objectives[-1].Player set from storage score_fixer:zprivate Temp.CurrentMap.Name
function score_fixer:zprivate/fixer/leave/copy_scores with storage score_fixer:zprivate Temp.Objectives[-1]
