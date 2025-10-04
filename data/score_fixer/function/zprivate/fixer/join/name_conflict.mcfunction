# Reset the other player's scores & remove their map's name assignment
$scoreboard players reset $(Name)
data modify storage score_fixer:zprivate Temp.CurrentMap.OldName set from storage score_fixer:zprivate Temp.CurrentMap.Name
data remove storage score_fixer:zprivate Temp.CurrentMap.Name
$data modify storage score_fixer:zprivate Maps[{Name:$(Name)}] set from storage score_fixer:zprivate Temp.CurrentMap
