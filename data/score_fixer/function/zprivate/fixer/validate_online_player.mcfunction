# Get Player Name & UUID
tag @s add ScoreFixer.ThisPlayer
execute summon minecraft:item_frame run function score_fixer:zprivate/fixer/join/get_player_name_and_uuid
tag @s remove ScoreFixer.ThisPlayer

# Check if the current (Name, UUID) is in 'OnlinePlayers': Detect the join manually if not
function score_fixer:zprivate/fixer/validate_online_player_2 with storage score_fixer:zprivate Player
