# Recursively copy the data for each player one by one
execute if data storage score_fixer:zprivate Temp.Players[-1].IsOffline run data modify storage score_fixer:zprivate Temp.Players[-1].IsModified set value 1b
$data modify storage score_fixer:zprivate Maps[{UUID:$(UUID)}] set from storage score_fixer:zprivate Temp.Players[-1]

# Next player
execute if score #ScoreFixer.EntryCount ScoreFixer matches 1 run return 0
scoreboard players remove #ScoreFixer.EntryCount ScoreFixer 1
data remove storage score_fixer:zprivate Temp.Players[-1]
execute if data storage score_fixer:zprivate Temp.Players[-1].Name run return run function score_fixer:zprivate/util/save/with_name with storage score_fixer:zprivate Temp.Players[-1]
function score_fixer:zprivate/util/save/with_uuid with storage score_fixer:zprivate Temp.Players[-1]
