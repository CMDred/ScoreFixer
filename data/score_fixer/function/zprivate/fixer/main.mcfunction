# Keep track of number of online players
execute store success score @s ScoreFixer.IsOnline run scoreboard players add #ScoreFixer.OnlinePlayerCount ScoreFixer 1

# Get Player UUID
data modify storage score_fixer:zprivate Player.UUID set from entity @s UUID

# Get Player Name
# (Note): I didn't use a hardcoded UUID to make absolutely sure there won't be a UUID collision, which would mess up the pack.
# (Note): I could use a PlayerID score instead of the name, but someone could accidentally reset everyone's scores, delete scoreboard.dat or remove the objective while keeping the data storage, which would mess up the datapack. The performance difference is negligible.
tag @s add ScoreFixer.ThisPlayer
execute summon minecraft:item_display run function score_fixer:zprivate/fixer/get_player_name
tag @s remove ScoreFixer.ThisPlayer

# Check if a map for the current name already exists
function score_fixer:zprivate/fixer/get_map_by_name with storage score_fixer:zprivate Player
execute store success score #ScoreFixer.MapExists ScoreFixer if data storage score_fixer:zprivate Temp.CurrentMap

    # If yes: Check if the UUID is different
    execute if score #ScoreFixer.MapExists ScoreFixer matches 1 run data modify storage score_fixer:zprivate Temp.EqualityCheck set from storage score_fixer:zprivate Temp.CurrentMap.UUID
    execute if score #ScoreFixer.MapExists ScoreFixer matches 1 store success score #ScoreFixer.IsDifferentUUID ScoreFixer run data modify storage score_fixer:zprivate Temp.EqualityCheck set from storage score_fixer:zprivate Player.UUID

        # If no: Stop the function & Remove the map's "IsOffline:1b" (Player joined with their usual name)
        execute if score #ScoreFixer.MapExists ScoreFixer matches 1 if score #ScoreFixer.IsDifferentUUID ScoreFixer matches 0 run return run function score_fixer:zprivate/fixer/remove_offline_status with storage score_fixer:zprivate Player

        # If yes: Update the map for this player's UUID and create a backup for the other player's scores (Player joined with a new name that is already mapped)
        execute if score #ScoreFixer.MapExists ScoreFixer matches 1 run function score_fixer:zprivate/fixer/create_backup with storage score_fixer:zprivate Temp.CurrentMap

# Check if a map with the UUID exists
function score_fixer:zprivate/fixer/get_map_by_uuid with storage score_fixer:zprivate Player
execute store success score #ScoreFixer.MapExists ScoreFixer if data storage score_fixer:zprivate Temp.CurrentMap

    # If yes: Copy scores from the old name to the new name & update the map
    execute if score #ScoreFixer.MapExists ScoreFixer matches 1 run data modify storage score_fixer:zprivate Player.OldName set from storage score_fixer:zprivate Temp.CurrentMap.Name
    execute if score #ScoreFixer.MapExists ScoreFixer matches 1 run return run function score_fixer:zprivate/fixer/transfer_scores with storage score_fixer:zprivate Player

    # If no: Create a map & check if a backup with that UUID exists
    data modify storage score_fixer:zprivate Maps append from storage score_fixer:zprivate Player

    function score_fixer:zprivate/fixer/get_backup with storage score_fixer:zprivate Player

        # If yes: Load the backup and delete it
        execute if data storage score_fixer:zprivate Temp.CurrentBackup run function score_fixer:zprivate/fixer/load_backup with storage score_fixer:zprivate Player
