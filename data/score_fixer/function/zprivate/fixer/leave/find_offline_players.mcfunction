# Check if the current player is offline
$execute unless entity $(Name) run function score_fixer:zprivate/fixer/leave/main {Name:$(Name)}

# Next player
execute if score #ScoreFixer.EntryCount ScoreFixer matches 0 run return 0
data remove storage score_fixer:zprivate Temp.Players[-1]
function score_fixer:zprivate/fixer/leave/find_offline_players with storage score_fixer:zprivate Temp.Players[-1]
