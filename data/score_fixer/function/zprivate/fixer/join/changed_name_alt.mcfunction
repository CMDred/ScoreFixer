# Case 2: The name is no longer present in the map due to a past conflict

# Copy scores
    # Get the number of tracked objectives
    execute store result score #ScoreFixer.ObjectiveCount ScoreFixer if data storage score_fixer:zprivate Temp.CurrentMap.Objectives[]

    # Copy each objective to the new player name
    execute if score #ScoreFixer.ObjectiveCount ScoreFixer matches 1.. run data modify storage score_fixer:zprivate Temp.Objectives set from storage score_fixer:zprivate Temp.CurrentMap.Objectives
    execute if score #ScoreFixer.ObjectiveCount ScoreFixer matches 1.. run function score_fixer:zprivate/fixer/join/copy_scores with storage score_fixer:zprivate Temp.Objectives[-1]

# Prepare for the event
data modify storage score_fixer:event Data set from storage score_fixer:zprivate Player
data modify storage score_fixer:event Data.OldName set from storage score_fixer:zprivate Temp.CurrentMap.OldName

# Update the map (Name & Remove "IsOffline:1b")
data modify storage score_fixer:zprivate Temp.CurrentMap.Name set from storage score_fixer:zprivate Player.Name
data remove storage score_fixer:zprivate Temp.CurrentMap.IsOffline
data remove storage score_fixer:zprivate Temp.CurrentMap.OldName
$data modify storage score_fixer:zprivate Maps[{UUID:$(UUID)}] set from storage score_fixer:zprivate Temp.CurrentMap

# Trigger the "#score_fixer:changed_name" event
function #score_fixer:changed_name with storage score_fixer:event Data
data remove storage score_fixer:event Data
