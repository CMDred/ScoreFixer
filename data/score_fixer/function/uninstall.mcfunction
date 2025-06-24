# Check if it's installed
scoreboard objectives add ScoreFixer.Uninstall dummy
execute if score #ScoreFixer.Init ScoreFixer matches 1 run scoreboard players set #ScoreFixer.Init ScoreFixer.Uninstall 1
execute unless score #ScoreFixer.Init ScoreFixer.Uninstall matches 1 run tellraw @a [{text:"ScoreFixer >> ",color:"#C1EA53"},{text:"⚠ Could not uninstall ScoreFixer. Is it installed?",color:"red"}]
execute unless score #ScoreFixer.Init ScoreFixer.Uninstall matches 1 run return run scoreboard objectives remove ScoreFixer.Uninstall
scoreboard objectives remove ScoreFixer.Uninstall

# Tellraw
tellraw @s ["",{text:"ScoreFixer >> ",color:"#C1EA53"},"Uninstalled ScoreFixer (v1.0.0)"]

# Remove scoreboards & data storages
scoreboard objectives remove ScoreFixer
scoreboard objectives remove ScoreFixer.IsOnline

scoreboard players reset #ScoreFixer.Init

#data remove storage ppd:zprivate data

# Stop the tick function
schedule clear score_fixer:zprivate/tick

#NEW APPROACH:
#- Get UUID
#- Get Name
#- Does a mapping with that name exist?
#   - Yes: Same UUID?
#      - Yes: RETURN
#      - No: Create a backup for that mapping, reset that name's scores, delete any mappings with the same UUID as I have, create a new mapping

#   - No: Does a mapping with that UUID exist?
#      - Yes: Copy scores from the old name to the new name, reset the old name's scores and update the mapping's name.
#      - No: Does a backup with that UUID exist?
#         - Yes: Load it, delete it, create new mapping
#         - No: Create new mapping



# THE PACK IS ROBUST AND SUPPORTS DELETING PLAYER STATS OR RESETTING ALL SCORES. Completely immune against name conflicts (e.g. someone renaming to someone else's name). Persists even through server crashes
# PROVIDE AN EVENT FOR "DIFFERENT NAME DETECTED"
