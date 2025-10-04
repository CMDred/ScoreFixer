# Schedule
schedule function score_fixer:zprivate/tick 1t

# Detect joining the game
# (Note): I first mark people as joined, then run leave detection, then run the join_game event (So the join event doesn't run before the leave event if both are detected in the same tick because of Singleplayer).
execute as @a unless score @s ScoreFixer matches 0 run function score_fixer:zprivate/fixer/join/mark_as_joined
execute store result score #ScoreFixer.PlayerCount ScoreFixer if entity @a

# Check if someone left
execute unless score #ScoreFixer.OnlinePlayerCount ScoreFixer = #ScoreFixer.PlayerCount ScoreFixer run function score_fixer:zprivate/fixer/leave/main

# Perform the join_game event
execute unless score #ScoreFixer.SomeoneJoined ScoreFixer matches 1 run return 0
execute as @a[tag=ScoreFixer.Joined] run function score_fixer:zprivate/fixer/join/main
scoreboard players set #ScoreFixer.SomeoneJoined ScoreFixer 0
