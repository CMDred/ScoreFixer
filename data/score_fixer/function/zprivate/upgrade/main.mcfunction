# Uninstall the previous version
#execute if score #ScoreFixer.Version load.status matches ... run function score_fixer:zprivate/upgrade/uninstall_...

# Initialize the new version
tellraw @a ["",{text:"🔨 ScoreFixer >> ",color:"#E4B0F7"},"Automatically uninstalled the previous version."]
scoreboard players set #ScoreFixer.Init ScoreFixer 0
scoreboard players reset #ScoreFixer.PreviousVersion
