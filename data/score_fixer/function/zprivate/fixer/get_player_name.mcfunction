# Get the player's name
tag @s add ScoreFixer.ThisEntity
execute as @a[tag=ScoreFixer.ThisPlayer,limit=1] run loot replace entity @e[type=minecraft:item_display,tag=ScoreFixer.ThisEntity,distance=..0.01,limit=1] contents loot score_fixer:player_head
data modify storage score_fixer:zprivate Player.Name set from entity @s item.components."minecraft:profile".name
kill @s
