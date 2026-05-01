# Recursively add the last element to the tracked objectives (Without creating duplicates)
$data modify storage score_fixer:objectives List[{Name:$(CurrentObjective)}].Name set value $(CurrentObjective)

# Next element
execute if score #ScoreFixer.EntryCount ScoreFixer matches 1 run return 0
scoreboard players remove #ScoreFixer.EntryCount ScoreFixer 1
data remove storage score_fixer:zprivate Temp.Input[-1]
data modify storage score_fixer:zprivate Temp.CurrentObjective set from storage score_fixer:zprivate Temp.Input[-1]
function score_fixer:zprivate/util/track_objectives/track_loop with storage score_fixer:zprivate Temp
