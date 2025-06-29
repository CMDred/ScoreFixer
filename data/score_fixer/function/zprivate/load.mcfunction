# Error checking
# (Note): The version increments when the data structure changes (incl. getting new data that doesn't break datapacks using the old version), behaviour changes or functions are added/removed.
    # Version check: Check if ScoreFixer is installed twice with conflicting versions
    execute if function #score_fixer:zprivate/version_check run scoreboard players set #ScoreFixer.VersionError load.status 1
    execute if score #ScoreFixer.VersionError load.status matches 1 run tellraw @a [{text:"🔨 ScoreFixer >> ",color:"#E4B0F7"},{text:"⚠ Multiple incompatible versions of ScoreFixer detected. Remove all but one and try again.",color:"red"}]
    execute if score #ScoreFixer.VersionError load.status matches 1 run schedule clear score_fixer:zprivate/tick
    execute if score #ScoreFixer.VersionError load.status matches 1 run scoreboard players reset #ScoreFixer.Version
    execute if score #ScoreFixer.VersionError load.status matches 1 run return run scoreboard players reset #ScoreFixer.VersionError

    # Lantern Load
    # (Note): If the version check fails, load.status will not be set, and therefore it won't start ticking.
    scoreboard players set #ScoreFixer load.status 1

# Init
scoreboard objectives add ScoreFixer dummy
execute unless score #ScoreFixer.Init ScoreFixer matches 1 run function score_fixer:zprivate/init

# Tellraw
execute if score #ScoreFixer.ShowLoadMessage ScoreFixer matches 1 run tellraw @a ["",{text:"🔨 ScoreFixer >> ",color:"#E4B0F7"},{text:"Made by SilicatYT",click_event:{action:"open_url",url:"https://www.youtube.com/BluesProductionTeam"},hover_event:{action:"show_text",value:[{text:"YouTube: ",color:"dark_aqua"},{text:"CMDred",color:"white"}]}},"\n",{text:"🔨 ScoreFixer >> ",color:"#E4B0F7"},"Get the latest updates: ",{text:"Modrinth",color:"#5491F7",click_event:{action:"open_url",url:"https://modrinth.com/datapack/score-fixer"},hover_event:{action:"show_text",value:["Open page"]}},", ",{text:"GitHub",color:"#5491F7",click_event:{action:"open_url",url:"https://github.com/CMDred/ScoreFixer"},hover_event:{action:"show_text",value:["Open page"]}}]

# Tick
function score_fixer:zprivate/tick
