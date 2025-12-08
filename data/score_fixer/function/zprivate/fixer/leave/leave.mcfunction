scoreboard players remove #ScoreFixer.EntryCount ScoreFixer 1

# Reset ScoreFixer score
# (Note): This is necessary because of the following scenario: Server crashes, A leaves without incrementing the ScoreFixer score (Still 0). Server ticks again without A being online, so the leave event runs for A. When A rejoins, their ScoreFixer score is still 0 (because it only increments when leaving), so no joining is detected. That's why I reset the score, so A's join is detected properly. But if A's join is already detected, the score shouldn't reset (because it would cause a 2nd join event in the next tick).
$execute unless entity @a[name=$(Name),tag=ScoreFixer.Joined,limit=1] run scoreboard players reset $(Name) ScoreFixer

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
