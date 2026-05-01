# Check if ScoreFixer is running properly
execute unless score #ScoreFixer load.status matches 1.. run return run function score_fixer:zprivate/error/check

# Input validation
$data modify storage score_fixer:zprivate Temp.Input set value $(Objectives)

    # Input is a list (or array) with at least 1 element
    execute store result score #ScoreFixer.EntryCount ScoreFixer if data storage score_fixer:zprivate Temp.Input[]
    execute if score #ScoreFixer.EntryCount ScoreFixer matches 0 run tellraw @s [{text:"🔨 ScoreFixer >> ",color:"#E4B0F7"},{text:"Could not untrack objectives: 'Objectives' must be a non-empty list of strings.",color:"red"}]
    execute if score #ScoreFixer.EntryCount ScoreFixer matches 0 run return fail

    # Every input element is a string
    scoreboard players set #ScoreFixer.RecursionFailed ScoreFixer 0
    data modify storage score_fixer:zprivate Temp.Objectives set from storage score_fixer:zprivate Temp.Input
    function score_fixer:zprivate/util/track_objectives/verify_elements_are_strings
    execute if score #ScoreFixer.RecursionFailed ScoreFixer matches 1 run tellraw @s [{text:"🔨 ScoreFixer >> ",color:"#E4B0F7"},{text:"Could not untrack objectives: 'Objectives' must be a non-empty list of strings.",color:"red"}]
    execute if score #ScoreFixer.RecursionFailed ScoreFixer matches 1 run return fail

# Untrack the input objectives
execute store result score #ScoreFixer.EntryCount ScoreFixer if data storage score_fixer:zprivate Temp.Input[]
data modify storage score_fixer:zprivate Temp.CurrentObjective set from storage score_fixer:zprivate Temp.Input[-1]
function score_fixer:zprivate/util/untrack_objectives/untrack_loop with storage score_fixer:zprivate Temp

return 1
