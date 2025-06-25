# Schedule
schedule function score_fixer:zprivate/tick 1t

# Detect joining the game
execute as @a unless score @s ScoreFixer.IsOnline matches 1 run function score_fixer:zprivate/fixer/main
execute store result score #ScoreFixer.PlayerCount ScoreFixer if entity @a

# Check if someone left
execute if score #ScoreFixer.OnlinePlayerCount ScoreFixer = #ScoreFixer.PlayerCount ScoreFixer run return 0

    # Iterate over OnlinePlayers and run appropriate "leave" commands for everyone who left
    data modify storage score_fixer:zprivate Temp.Players set from storage score_fixer:zprivate OnlinePlayers
    scoreboard players operation #ScoreFixer.EntryCount ScoreFixer = #ScoreFixer.OnlinePlayerCount ScoreFixer
    scoreboard players operation #ScoreFixer.EntryCount ScoreFixer -= #ScoreFixer.PlayerCount ScoreFixer
    function score_fixer:zprivate/fixer/leave/find_offline_players with storage score_fixer:zprivate Temp.Players[-1]

    # Reset IsOnline and update OnlinePlayerCount
    scoreboard players reset * ScoreFixer.IsOnline
    execute store success score @a ScoreFixer.IsOnline store result score #ScoreFixer.OnlinePlayerCount ScoreFixer if entity @a
