# Version error checking
# (Note): The version increments when the data structure changes, previous behaviour changes or new utilities are added. Or when replacing the old datapack with a new one would leave dangling scoreboards, data etc.
    # Version check: Check if ScoreFixer is installed twice with conflicting versions
    execute if function #score_fixer:zprivate/version_check run return run function score_fixer:zprivate/version_error
    scoreboard players reset #ScoreFixer.VersionError

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
