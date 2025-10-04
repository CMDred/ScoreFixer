# Check if ScoreFixer is running properly
execute unless score #ScoreFixer load.status matches 1.. run return run function score_fixer:zprivate/error/check

# Save all the loaded player storages (for offline players)
# (Note): If a player is offline, the data is not applied as scores anyway, and the storage gets overwritten when they leave. However, I need to make sure the "IsModified:1b" data is not set if the player is online.
execute store result score #ScoreFixer.EntryCount ScoreFixer if data storage score_fixer:loaded Players[]
execute if score #ScoreFixer.EntryCount ScoreFixer matches 0 run return fail

data modify storage score_fixer:zprivate Temp.Players set from storage score_fixer:loaded Players
execute if data storage score_fixer:zprivate Temp.Players[-1].Name run function score_fixer:zprivate/util/save/with_name with storage score_fixer:zprivate Temp.Players[-1]
execute unless data storage score_fixer:zprivate Temp.Players[-1].Name run function score_fixer:zprivate/util/save/with_uuid with storage score_fixer:zprivate Temp.Players[-1]

return 1
