# Iterate over OnlinePlayers and run appropriate "leave" commands for everyone who left
data modify storage score_fixer:zprivate Temp.Players set from storage score_fixer:zprivate OnlinePlayers
scoreboard players operation #ScoreFixer.EntryCount ScoreFixer = #ScoreFixer.OnlinePlayerCount ScoreFixer
scoreboard players operation #ScoreFixer.EntryCount ScoreFixer -= #ScoreFixer.PlayerCount ScoreFixer
function score_fixer:zprivate/fixer/leave/find_offline_players with storage score_fixer:zprivate Temp.Players[-1]

# Reset the players' ScoreFixer score (stands for "IsOnline") and update OnlinePlayerCount
# (Note): Because all fake players use the ScoreFixer objective too, I copy the important fakeplayers' scores to another, then copy them back.
scoreboard objectives add ScoreFixer.Temp dummy
scoreboard players operation #ScoreFixer.ShowLoadMessage ScoreFixer.Temp = #ScoreFixer.ShowLoadMessage ScoreFixer
scoreboard players operation #ScoreFixer.SomeoneJoined ScoreFixer.Temp = #ScoreFixer.SomeoneJoined ScoreFixer

scoreboard players reset * ScoreFixer

scoreboard players set #ScoreFixer.Init ScoreFixer 1
scoreboard players operation #ScoreFixer.ShowLoadMessage ScoreFixer = #ScoreFixer.ShowLoadMessage ScoreFixer.Temp
scoreboard players operation #ScoreFixer.SomeoneJoined ScoreFixer = #ScoreFixer.SomeoneJoined ScoreFixer.Temp
scoreboard objectives remove ScoreFixer.Temp

execute store success score @a ScoreFixer store result score #ScoreFixer.OnlinePlayerCount ScoreFixer if entity @a
