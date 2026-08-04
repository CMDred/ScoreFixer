scoreboard players remove #ScoreFixer.EntryCount ScoreFixer 1

# (BUG): If a player with the same name but different case is online, it resets the wrong player's score. That player's ScoreFixer score (who must have just joined in the current tick) is set to 0 in the join event, so that's not a problem. But the player whose score SHOULD have been reset hasn't been reset, so their next join won't cause a join event, breaking the pack slightly. This is not easily fixable.
    # When it happens: Same as the bug below, but only if both players are different (because the score is set to 0 in the join event again if it's the same player).
# (BUG): In addition to the bug above, the backup for $(Name) will pull from the online player's name rather than the correct one, because scoreboard commands automatically use the casing of the online player's name if it exists. This is not fixable unless backups are created every tick rather than on leave, which would ruin performance.
    # When it happens: Player 'A' leaves the game and the server stops in the same tick (Singleplayer leave, server stop, or crash). Then, player 'B' changes their name to 'A's but with different casing, and joins the world in singleplayer, meaning there is no time to create the backup using the correct scores.
    # Why it can't be fixed: Let's assume we wait with creating 'A's backup until 'B' leaves again. It's singleplayer, so after 'B' leaves, no time will pass until the next person joins. And what if that person is 'A' again, with their original name, but with different casing? It is strictly impossible to copy scores from OLD to NEW if both only differ in their casing. Simpler scenario: 'A' leaves (singleplayer), changes their casing, joins back. This is not a problem in servers, because there will be ticks without 'A' online, so backups can be created.
$scoreboard players reset $(Name) ScoreFixer

# Remove player from OnlinePlayers storage, add "IsOffline" data & copy player scores to their data storage
$data remove storage score_fixer:zprivate OnlinePlayers[{Name:$(Name)}]
$data modify storage score_fixer:zprivate Temp.CurrentMap set from storage score_fixer:zprivate Maps[{Name:$(Name)}]
data modify storage score_fixer:zprivate Temp.CurrentMap.IsOffline set value 1b

    # Copy the tracked objectives with their values to the map
    execute store result score #ScoreFixer.ObjectiveCount ScoreFixer if data storage score_fixer:objectives List[]

    data modify storage score_fixer:zprivate Temp.Objectives set from storage score_fixer:objectives List
    data modify storage score_fixer:zprivate Temp.Objectives[-1].Player set from storage score_fixer:zprivate Temp.CurrentMap.Name
    data modify storage score_fixer:zprivate Temp.CurrentMap.Objectives set value []
    execute if score #ScoreFixer.ObjectiveCount ScoreFixer matches 1.. run function score_fixer:zprivate/fixer/leave/store_scores with storage score_fixer:zprivate Temp.Objectives[-1]

$data modify storage score_fixer:zprivate Maps[{Name:$(Name)}] set from storage score_fixer:zprivate Temp.CurrentMap

# Trigger the "#score_fixer:left_game" event
data modify storage score_fixer:event Data.Name set from storage score_fixer:zprivate Temp.CurrentMap.Name
data modify storage score_fixer:event Data.UUID set from storage score_fixer:zprivate Temp.CurrentMap.UUID
function #score_fixer:left_game with storage score_fixer:event Data
data remove storage score_fixer:event Data
