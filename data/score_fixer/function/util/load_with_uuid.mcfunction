# Check if ScoreFixer is running properly
execute unless score #ScoreFixer load.status matches 1.. run return run function score_fixer:zprivate/error/check

# Clear previously loaded data
data modify storage score_fixer:loaded Players set value []

# Load an offline player's scores using their UUID (Hexadecimal or int array format)
$data modify storage score_fixer:zprivate Temp.UUID set value "$(UUID)"
data modify storage score_fixer:zprivate Temp.Char set string storage score_fixer:zprivate Temp.UUID 0 1
execute store success score #ScoreFixer.IsHexadecimal ScoreFixer run data modify storage score_fixer:zprivate Temp.Char set value "["
execute if score #ScoreFixer.IsHexadecimal ScoreFixer matches 1 run function score_fixer:zprivate/util/load_with_uuid/hexadecimal with storage score_fixer:zprivate Temp
execute if score #ScoreFixer.IsHexadecimal ScoreFixer matches 0 run function score_fixer:zprivate/util/load_with_uuid/int_array with storage score_fixer:zprivate Temp

execute if data storage score_fixer:loaded Players[0] run return 1
return fail
