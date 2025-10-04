# Check if the current player is offline
# (Note): Players who just joined (but whose leaving wasn't yet detected because of Singleplayer) need to be considered "offline", so it doesn't skip the leave event for them before the join event runs.
$execute store success score #ScoreFixer.IsOnline ScoreFixer if entity @a[name=$(Name),tag=!ScoreFixer.Joined,limit=1]
execute if score #ScoreFixer.IsOnline ScoreFixer matches 0 run function score_fixer:zprivate/fixer/leave/leave with storage score_fixer:zprivate Temp.Players[-1]

# Next player
execute if score #ScoreFixer.EntryCount ScoreFixer matches 0 run return 0
data remove storage score_fixer:zprivate Temp.Players[-1]
function score_fixer:zprivate/fixer/leave/find_offline_players with storage score_fixer:zprivate Temp.Players[-1]
