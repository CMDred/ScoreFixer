scoreboard players remove #ScoreFixer.EntryCount ScoreFixer 1

# Remove player from OnlinePlayers storage, add "IsOffline" data & copy player scores to their data storage
$data remove storage score_fixer:zprivate OnlinePlayers[{Name:$(Name)}]
$data modify storage score_fixer:zprivate Temp.CurrentMap set from storage score_fixer:zprivate Maps[{Name:$(Name)}]
data modify storage score_fixer:zprivate Temp.CurrentMap.IsOffline set value 1b

    # Copy the tracked objectives with their values to the map
    execute store result score #ScoreFixer.EntryCount ScoreFixer if data storage score_fixer:objectives List[]

    data modify storage score_fixer:zprivate Temp.Objectives set from storage score_fixer:objectives List
    data modify storage score_fixer:zprivate Temp.Objectives[-1].Player set from storage score_fixer:zprivate Temp.CurrentMap.Name
    data modify storage score_fixer:zprivate Temp.CurrentMap.Objectives set value []
    execute if score #ScoreFixer.EntryCount ScoreFixer matches 1.. run function score_fixer:zprivate/fixer/leave/copy_scores with storage score_fixer:zprivate Temp.Objectives[-1]

$data modify storage score_fixer:zprivate Maps[{Name:$(Name)}] set from storage score_fixer:zprivate Temp.CurrentMap

# Trigger the "#score_fixer:left_game" event
data modify storage score_fixer:event Data.Name set from storage score_fixer:zprivate Temp.CurrentMap.Name
data modify storage score_fixer:event Data.UUID set from storage score_fixer:zprivate Temp.CurrentMap.UUID
function #score_fixer:left_game with storage score_fixer:event Data
data remove storage score_fixer:event Data
