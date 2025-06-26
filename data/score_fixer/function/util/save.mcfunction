# Save all the loaded player storages (for offline players)
# (Note): If a player is offline, the data is not applied as scores anyway, and the storage gets overwritten when they leave. However, I need to make sure the "IsModified:1b" data is not set if the player is online.
execute store result score #ScoreFixer.EntryCount ScoreFixer if data storage score_fixer:loaded Players[]
execute if score #ScoreFixer.EntryCount ScoreFixer matches 0 run return 0

data modify storage score_fixer:zprivate Temp.Players set from storage score_fixer:loaded Players
function score_fixer:zprivate/util/save with storage score_fixer:zprivate Temp.Players[-1]
