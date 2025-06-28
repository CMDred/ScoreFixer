# ScoreFixer
A robust Minecraft Data Pack library that prevents scoreboard values from getting lost after a player name change.\
For inquiries, please contact **@silicatYT** on Discord.\
\
Download: [Modrinth](https://modrinth.com/datapack/score-fixer)\
Issue tracker: [GitHub](https://github.com/CMDred/ScoreFixer)

## Why is this necessary?
In Minecraft, scores are tied to usernames rather than UUIDs. As such, changing your name resets your previously held scores (which can break Data Packs or lose progress), and anyone joining with your old name can take over your previous scores.\
**ScoreFixer** tackles this issue and lets you automatically transfer scores to your new name without conflicts.

## Features
- Automatically transfer certain scoreboard objectives' values to the new player name upon a name change
- Read/write offline players' scores using their UUID or specific scoreboard values (e.g. ID score) as selectors
- Events (function tags): `#score_fixer:changed_name`, `#score_fixer:joined_game` & `#score_fixer:left_game`

## How to use
### Make scores transfer on name change
To make ScoreFixer automatically transfer an objective (e.g. "foo"), add `{Name:"foo"}` to the `score_fixer:objectives List` data storage.

### Access offline players' scores
#### Load
You can access offline players' scores with their UUID by running `/function score_fixer:util/load_with_uuid {UUID:...}` (accepts hexadecimal and int array format). If a player is found, their data is copied to `score_fixer:loaded Players`. From there, you can make changes (adjust score values, remove objectives from the list to reset them, etc).\
Alternatively, you can manually copy data from every player that matches your custom condition like so: 
```
/data modify storage score_fixer:loaded Players append from storage score_fixer:zprivate Maps[{Objectives:[{Name:"foo",Value:10}]}]
```
#### Save
After applying changes to the objectives in `score_fixer:loaded Players`, run `/function score_fixer:util/save` to save the data for all loaded players at once.

### Events
- `#score_fixer:changed_name`: When a player joins with a new name, this function tag is executed **as** that player. The data storage `score_fixer:event Data` contains `Name`, `OldName` and `UUID`.
- `#score_fixer:joined_game`: When a player joins, this function tag is executed **as** that player. The data storage `score_fixer:event Data` contains `Name` and `UUID`.
- `#score_fixer:left_game`: When a player leaves, this function tag is executed. The data storage `score_fixer:event Data` contains `Name` and `UUID`.

## Good to know
- It is recommended for **ScoreFixer** to run first, so that scores are transferred before other Data Packs try to use them
- For technical reasons, scores manually set while the player was offline (e.g. `scoreboard players set SilicatYT foo 1`) cannot be transferred if they join with a new name; use the `load` and `save` utilities instead
  - Reason: Names in commands are case insensitive if a player with that name is online. If a player exclusively changes their name's capitalization, scores cannot be copied over when they join.

## Credit
From CMDred:
- **SilicatYT**

Additional help:
- Leinad677YT (Consulting & ideas)

## License
As per the MIT License, you are allowed to redistribute, modify and use **ScoreFixer** as long as you provide credit for the original work.
