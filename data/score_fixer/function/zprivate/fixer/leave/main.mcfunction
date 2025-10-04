# Iterate over OnlinePlayers and run appropriate "leave" commands for everyone who left
data modify storage score_fixer:zprivate Temp.Players set from storage score_fixer:zprivate OnlinePlayers
scoreboard players operation #ScoreFixer.EntryCount ScoreFixer = #ScoreFixer.OnlinePlayerCount ScoreFixer
scoreboard players operation #ScoreFixer.EntryCount ScoreFixer -= #ScoreFixer.PlayerCount ScoreFixer
function score_fixer:zprivate/fixer/leave/find_offline_players with storage score_fixer:zprivate Temp.Players[-1]

# Update OnlinePlayerCount
scoreboard players operation #ScoreFixer.OnlinePlayerCount ScoreFixer = #ScoreFixer.PlayerCount ScoreFixer
