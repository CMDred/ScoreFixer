tellraw @a [{text:"🔨 ScoreFixer >> ",color:"#E4B0F7"},{text:"⚠ Cannot automatically upgrade: Previously installed ScoreFixer version is newer than the current version. Please uninstall the previous version manually before installing this one.",color:"red"}]
scoreboard players set #ScoreFixer load.status -2
scoreboard players reset #ScoreFixer.PreviousVersion
scoreboard players reset #ScoreFixer.Version
schedule clear score_fixer:zprivate/tick
