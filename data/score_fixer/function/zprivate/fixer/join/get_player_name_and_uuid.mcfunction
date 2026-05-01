# Get the player's data
loot replace entity @s contents loot {pools:[{rolls:1,entries:[{type:"minecraft:item",name:"minecraft:egg",functions:[{function:"minecraft:set_name",entity:"this",name:{selector:"@a[tag=ScoreFixer.ThisPlayer,limit=1]"},target:"item_name"}]}]}]}
data modify storage score_fixer:zprivate Temp.PlayerData set from entity @s Item.components."minecraft:item_name"
data modify storage score_fixer:zprivate Player.Name set from storage score_fixer:zprivate Temp.PlayerData.insertion
data modify storage score_fixer:zprivate Player.UUID set from storage score_fixer:zprivate Temp.PlayerData.hover_event.uuid
kill @s
