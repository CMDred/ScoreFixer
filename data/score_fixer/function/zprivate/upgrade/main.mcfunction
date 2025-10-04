# Uninstall the previous version
#execute if score #ScoreFixer.Version load.status matches ... run function score_fixer:zprivate/upgrade/uninstall_...

# Run the init function
scoreboard players set #ScoreFixer.Init ScoreFixer 0

scoreboard players reset #ScoreFixer.PreviousVersion
