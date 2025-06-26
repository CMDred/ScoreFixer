# Get the number of tracked objectives
execute store result score #ScoreFixer.EntryCount ScoreFixer if data storage score_fixer:zprivate Temp.CurrentMap.Objectives[]

# Copy each objective to the new player name
execute if score #ScoreFixer.EntryCount ScoreFixer matches 1.. run data modify storage score_fixer:zprivate Temp.Objectives set from storage score_fixer:zprivate Temp.CurrentMap.Objectives
execute if score #ScoreFixer.EntryCount ScoreFixer matches 1.. run function score_fixer:zprivate/fixer/changed_name_2 with storage score_fixer:zprivate Temp.Objectives[-1]

# Reset the old player name's scores
$scoreboard players reset $(OldName)

# Update the map (Name & Remove "IsOffline:1b")
data modify storage score_fixer:zprivate Temp.CurrentMap.Name set from storage score_fixer:zprivate Player.Name
data remove storage score_fixer:zprivate Temp.CurrentMap.IsOffline
$data modify storage score_fixer:zprivate Maps[{Name:$(OldName)}] set from storage score_fixer:zprivate Temp.CurrentMap

# Trigger the "#score_fixer:changed_name" event
data modify storage score_fixer:event Data set from storage score_fixer:zprivate Player
function #score_fixer:changed_name with storage score_fixer:event Data
data remove storage score_fixer:event Data
