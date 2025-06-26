# Get Player UUID
data modify storage score_fixer:zprivate Player.UUID set from entity @s UUID

# Get Player Name
# (Note): I didn't use a hardcoded UUID to make absolutely sure there won't be a UUID collision, which would mess up the pack.
# (Note): I could use a PlayerID score instead of the name, but someone could accidentally reset everyone's scores, delete scoreboard.dat or remove the objective while keeping the data storage, which would mess up the datapack. The performance difference is negligible.
tag @s add ScoreFixer.ThisPlayer
execute summon minecraft:item_display run function score_fixer:zprivate/fixer/get_player_name
tag @s remove ScoreFixer.ThisPlayer

# Keep track of online players
execute store success score @s ScoreFixer.IsOnline run scoreboard players add #ScoreFixer.OnlinePlayerCount ScoreFixer 1
data modify storage score_fixer:zprivate OnlinePlayers append from storage score_fixer:zprivate Player

# Trigger the "#score_fixer:joined_game" event
data modify storage score_fixer:event Data set from storage score_fixer:zprivate Player
function #score_fixer:joined_game with storage score_fixer:event Data
data remove storage score_fixer:event Data

# Check if a map for the current name already exists
function score_fixer:zprivate/fixer/get_map_by_name with storage score_fixer:zprivate Player
execute store success score #ScoreFixer.MapExists ScoreFixer if data storage score_fixer:zprivate Temp.CurrentMap

    # If yes: Check if the UUID is different
    execute if score #ScoreFixer.MapExists ScoreFixer matches 1 run data modify storage score_fixer:zprivate Temp.EqualityCheck set from storage score_fixer:zprivate Temp.CurrentMap.UUID
    execute if score #ScoreFixer.MapExists ScoreFixer matches 1 store success score #ScoreFixer.IsDifferentUUID ScoreFixer run data modify storage score_fixer:zprivate Temp.EqualityCheck set from storage score_fixer:zprivate Player.UUID

        # If no: Stop the function, remove the map's "IsOffline:1b" and apply any score changes that happened to the data storage while the player was offline (Player joined with their usual name)
        execute if score #ScoreFixer.MapExists ScoreFixer matches 1 if score #ScoreFixer.IsDifferentUUID ScoreFixer matches 0 run return run function score_fixer:zprivate/fixer/no_name_change with storage score_fixer:zprivate Player

        # If yes: Remove the other player's map's name, reset their score and update the map for this player's UUID (Player joined with a new name that is already mapped)
        execute if score #ScoreFixer.MapExists ScoreFixer matches 1 run function score_fixer:zprivate/fixer/name_conflict with storage score_fixer:zprivate Temp.CurrentMap

# Check if a map with the UUID exists
function score_fixer:zprivate/fixer/get_map_by_uuid with storage score_fixer:zprivate Player
execute store success score #ScoreFixer.MapExists ScoreFixer if data storage score_fixer:zprivate Temp.CurrentMap

    # If no: Create a map
    execute if score #ScoreFixer.MapExists ScoreFixer matches 0 run return run data modify storage score_fixer:zprivate Maps append from storage score_fixer:zprivate Player

    # If yes: Update the map & copy scores from it to the new name
    data modify storage score_fixer:zprivate Player.OldName set from storage score_fixer:zprivate Temp.CurrentMap.Name
    function score_fixer:zprivate/fixer/changed_name with storage score_fixer:zprivate Player
