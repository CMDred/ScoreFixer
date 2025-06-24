# ScoreFixer
A robust Minecraft Data Pack library that prevents scoreboard values from getting lost after a player name change.\
For inquiries, please contact **@silicatYT** on Discord.\
\
Download: [Modrinth](https://modrinth.com/datapack/score-fixer)\
Issue tracker: [GitHub](https://github.com/CMDred/ScoreFixer)

## Why is this necessary?
In Minecraft, scoreboards are an insecure place to store data. Scores are tied to usernames rather than UUIDs. As such, changing your name resets your previously held scores (which can break Data Packs or lose progress), and anyone joining with your old name now holds your previous scores.\
**ScoreFixer** tackles this issue and lets you automatically transfer scores to your new name without conflicts.

## How to use
To make ScoreFixer automatically transfer an objective (e.g. "foo"), add `{Name:"foo"}` to the `score_fixer:objectives List` data storage.

## Good to know
- **ScoreFixer** supports [Lantern Load](https://github.com/LanternMC/load) to control the order in which Data Packs load
- It is recommended for **ScoreFixer** to run first, so that scores are transferred before other Data Packs try to use them

## Credit
From CMDred:
- **SilicatYT**

## License
As per the MIT License, you are allowed to redistribute, modify and use **ScoreFixer** as long as you provide credit for the original work.
