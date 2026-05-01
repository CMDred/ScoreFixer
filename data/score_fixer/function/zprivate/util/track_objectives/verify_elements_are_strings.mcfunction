# Recursively check if the last element is a string
    # Check if it cannot be converted to a string (Map, List, Array, ...)
    # (Note): I have to clear it before I set it. Otherwise, it might interpret "data is the same as before" (i.e., from a previous "track_objectives" call) as "invalid input".
    data remove storage score_fixer:zprivate Temp.ToString
    execute store success score #ScoreFixer.IsSuccess ScoreFixer run data modify storage score_fixer:zprivate Temp.ToString set string storage score_fixer:zprivate Temp.Objectives[-1]
    execute if score #ScoreFixer.IsSuccess ScoreFixer matches 0 run return run scoreboard players set #ScoreFixer.RecursionFailed ScoreFixer 1

    # Check if the stringified value is different from the original
    execute store success score #ScoreFixer.IsSuccess ScoreFixer run data modify storage score_fixer:zprivate Temp.ToString set from storage score_fixer:zprivate Temp.Objectives[-1]
    execute if score #ScoreFixer.IsSuccess ScoreFixer matches 1 run return run scoreboard players set #ScoreFixer.RecursionFailed ScoreFixer 1

# Next element
execute if score #ScoreFixer.EntryCount ScoreFixer matches 1 run return 0
scoreboard players remove #ScoreFixer.EntryCount ScoreFixer 1
data remove storage score_fixer:zprivate Temp.Objectives[-1]
function score_fixer:zprivate/util/track_objectives/verify_elements_are_strings
