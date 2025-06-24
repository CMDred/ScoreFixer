# Get the number of tracked objectives
execute store result score #ScoreFixer.ObjectiveCount ScoreFixer if data storage score_fixer:zprivate Temp.CurrentBackup.Data[]

# Copy each objective to the new player name
execute if score #ScoreFixer.ObjectiveCount ScoreFixer matches 0 run return 0

data modify storage score_fixer:zprivate Temp.CurrentBackup.Data[-1].Player set from storage score_fixer:zprivate Player.Name
function score_fixer:zprivate/fixer/load_backup_2 with storage score_fixer:zprivate Temp.CurrentBackup.Data[-1]
