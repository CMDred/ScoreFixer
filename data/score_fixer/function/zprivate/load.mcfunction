# Init
scoreboard objectives add ScoreFixer dummy
execute unless score #ScoreFixer.Init ScoreFixer matches 1 run function score_fixer:zprivate/init

# Tellraw
execute if score #ScoreFixer.ShowLoadMessage ScoreFixer matches 1 run tellraw @a ["",{text:"ScoreFixer >> ",color:"#C1EA53"},{text:"Made by SilicatYT",click_event:{action:"open_url",url:"https://www.youtube.com/BluesProductionTeam"},hover_event:{action:"show_text",value:[{text:"YouTube: ",color:"dark_aqua"},{text:"CMDred",color:"white"}]}},"\n",{text:"ScoreFixer >> ",color:"#C1EA53"},"Get the latest updates: ",{text:"Modrinth",color:"#5491F7",click_event:{action:"open_url",url:"https://modrinth.com/datapack/score-fixer"},hover_event:{action:"show_text",value:["Open page"]}},", ",{text:"GitHub",color:"#5491F7",click_event:{action:"open_url",url:"https://github.com/CMDred/score-fixer"},hover_event:{action:"show_text",value:["Open page"]}}]

# Tick
function score_fixer:zprivate/tick
