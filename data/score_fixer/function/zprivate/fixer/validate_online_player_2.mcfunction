# Check if the current (Name, UUID) is in 'OnlinePlayers': Detect the join manually if not
$execute unless data storage score_fixer:zprivate OnlinePlayers[{Name:"$(Name)",UUID:$(UUID)}] run scoreboard players set @s ScoreFixer 1
