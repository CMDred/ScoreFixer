# Reset the other player's scores & remove their map's name assignment
$scoreboard players reset $(Name)
$data remove storage score_fixer:zprivate Maps[{Name:$(Name)}].Name
