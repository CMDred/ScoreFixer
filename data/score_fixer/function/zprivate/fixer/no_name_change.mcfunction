# Remove "IsOffline:1b" and "IsModified:1b" from the map
data remove storage score_fixer:zprivate Temp.CurrentMap.IsOffline
execute store success score #ScoreFixer.WasModified ScoreFixer run data remove storage score_fixer:zprivate Temp.CurrentMap.IsModified
$data modify storage score_fixer:zprivate Maps[{Name:$(Name)}] set from storage score_fixer:zprivate Temp.CurrentMap

# Copy scores if the data storage's scores were modified while the player was offline
execute if score #ScoreFixer.WasModified ScoreFixer matches 0 run return 0

# Reset all scores from the objectives list
    # Get the number of tracked objectives
    execute store result score #ScoreFixer.ObjectiveCount ScoreFixer if data storage score_fixer:objectives List[]
    execute if score #ScoreFixer.ObjectiveCount ScoreFixer matches 0 run return 0

    # Copy each objective to the new player name
    data modify storage score_fixer:zprivate Temp.Objectives set from storage score_fixer:objectives List
    function score_fixer:zprivate/fixer/reset_scores with storage score_fixer:zprivate Temp.Objectives[-1]

# Copy scores
    # Get the number of tracked objectives
    execute store result score #ScoreFixer.ObjectiveCount ScoreFixer if data storage score_fixer:zprivate Temp.CurrentMap.Objectives[]
    execute if score #ScoreFixer.ObjectiveCount ScoreFixer matches 0 run return 0

    # Copy each objective to the new player name
    data modify storage score_fixer:zprivate Temp.Objectives set from storage score_fixer:zprivate Temp.CurrentMap.Objectives
    function score_fixer:zprivate/fixer/copy_scores with storage score_fixer:zprivate Temp.Objectives[-1]
