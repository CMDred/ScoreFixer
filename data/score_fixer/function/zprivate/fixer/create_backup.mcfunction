# Create a backup for the other player
$data modify storage score_fixer:zprivate Backups append value {UUID:$(UUID),Data:[]}

    # Copy every tracked objective with its value to the backup
    execute store result score #ScoreFixer.ObjectiveCount ScoreFixer if data storage score_fixer:objectives List[]

    data modify storage score_fixer:zprivate Temp.Objectives set from storage score_fixer:objectives List
    data modify storage score_fixer:zprivate Temp.Objectives[-1].Player set from storage score_fixer:zprivate Temp.CurrentMap.Name
    function score_fixer:zprivate/fixer/create_backup_2 with storage score_fixer:zprivate Temp.Objectives[-1]

# Reset the other player's scores
$scoreboard players reset $(Name)
