# Mark the current player as "Joined"
tag @s add ScoreFixer.Joined

# Keep track of online players
execute store success score @s ScoreFixer store success score #ScoreFixer.SomeoneJoined ScoreFixer run scoreboard players add #ScoreFixer.OnlinePlayerCount ScoreFixer 1
scoreboard players reset @s ScoreFixer.LeaveGame
