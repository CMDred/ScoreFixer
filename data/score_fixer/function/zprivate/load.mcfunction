# Version error checking: Check if ScoreFixer is installed twice with conflicting versions
# (Note): The version increments when the data structure changes, previous behaviour changes or new utilities are added. Or when replacing the old datapack with a new one would leave dangling scoreboards, data etc.
# (Note): If the version check fails, load.status will be negative with the respective error code (e.g. -1: version mismatch), and therefore it won't start ticking.
execute if function #score_fixer:zprivate/version_check run return run function score_fixer:zprivate/error/version_mismatch

# Automatic upgrade
# (Note): It tries to automatically uninstall the previous version and install the new version without manual input. But if the previous version is higher, it throws an error.
execute if score #ScoreFixer.Init ScoreFixer matches 1 store result score #ScoreFixer.PreviousVersion load.status run data get storage score_fixer:zprivate Version
execute if score #ScoreFixer.PreviousVersion load.status matches 0 run return run function score_fixer:zprivate/error/version_unknown
execute if score #ScoreFixer.PreviousVersion load.status > #ScoreFixer.Version load.status run return run function score_fixer:zprivate/error/version_downgrade
#execute if score #ScoreFixer.PreviousVersion load.status matches <accepted range> if score #ScoreFixer.PreviousVersion load.status < #ScoreFixer.Version load.status run function score_fixer:zprivate/upgrade/main

scoreboard players set #ScoreFixer load.status 1

# Init
scoreboard objectives add ScoreFixer minecraft.custom:minecraft.leave_game
execute unless score #ScoreFixer.Init ScoreFixer matches 1 run function score_fixer:zprivate/init

# Tellraw
execute if score #ScoreFixer.ShowLoadMessage ScoreFixer matches 1 run tellraw @a ["",{text:"🔨 ScoreFixer >> ",color:"#E4B0F7"},{text:"Made by SilicatYT",click_event:{action:"open_url",url:"https://www.youtube.com/BluesProductionTeam"},hover_event:{action:"show_text",value:[{text:"YouTube: ",color:"dark_aqua"},{text:"CMDred",color:"white"}]}},"\n",{text:"🔨 ScoreFixer >> ",color:"#E4B0F7"},"Get the latest updates: ",{text:"Modrinth",color:"#5491F7",click_event:{action:"open_url",url:"https://modrinth.com/datapack/score-fixer"},hover_event:{action:"show_text",value:["Open page"]}},", ",{text:"GitHub",color:"#5491F7",click_event:{action:"open_url",url:"https://github.com/CMDred/ScoreFixer"},hover_event:{action:"show_text",value:["Open page"]}},"\n",{text:"🔨 ScoreFixer >> ",color:"#E4B0F7"},{text:"Click to toggle this message",color:"yellow",click_event:{action:"run_command",command:"function score_fixer:settings/toggle_load_message"},hover_event:{action:"show_text",value:["Toggle load message"]}}]

# Tick
function score_fixer:zprivate/tick
