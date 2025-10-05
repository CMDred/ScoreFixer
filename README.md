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
<details>
<summary>Make scores transfer on name change</summary>

To make ScoreFixer automatically transfer an objective (e.g. "foo"), add `{Name:"foo"}` to the `score_fixer:objectives List` data storage.

</details>

<details>
<summary>Access offline players' scores</summary>

  <details>
  <summary>Load</summary>

You can access offline players' scores with their UUID by running `/function score_fixer:util/load_with_uuid {UUID:...}` (accepts hexadecimal and int array format). If a player is found, their data is copied to `score_fixer:loaded Players`. From there, you can make changes (adjust score values, remove objectives from the list to reset them, etc).\
Alternatively, you can manually copy data from every player that matches your custom condition like so:
```
/data modify storage score_fixer:loaded Players append from storage score_fixer:zprivate Maps[{Objectives:[{Name:"foo",Value:10}]}]
```

  </details>

  <details>
  <summary>Save</summary>

After applying changes to the objectives in `score_fixer:loaded Players`, run `/function score_fixer:util/save` to save the data for all loaded players at once.

  </details>

</details>

<details>
<summary>Events</summary>

- `#score_fixer:changed_name`: When a player joins with a new name, this function tag is executed **as** that player. The data storage `score_fixer:event Data` contains `Name`, `OldName` and `UUID`.
- `#score_fixer:joined_game`: When a player joins, this function tag is executed **as** that player. The data storage `score_fixer:event Data` contains `Name` and `UUID`.
- `#score_fixer:left_game`: When a player leaves, this function tag is executed. The data storage `score_fixer:event Data` contains `Name` and `UUID`.

The data inside `score_fixer:event Data` is also directly accessible using **macros**.

</details>

<details>
<summary>Upgrade or uninstall ScoreFixer</summary>

- **Uninstall:** Run `/function score_fixer:uninstall`.
- **Upgrade:**
  - Uninstall the current version (keep the associated data), replace the Data Pack with the new version, then `/reload`.
  - **(v1.2.0+)** Upgrading from v1.2.0 to a higher version can be done without uninstalling the current version first.

</details>

## Good to know
<details>
<summary>Caveats to ScoreFixer</summary>

- Scores manually set while the player is offline (e.g. `/scoreboard players set SilicatYT foo 1`) cannot be transferred if they join with a new name. Use the `load` and `save` utilities instead.
  - Reason: While a player is offline, the game becomes case insensitive to that name, making it impossible to copy scores from the previous name to the new name if a player only changed their name capitalization.

</details>

<details>
<summary>Lantern Load</summary>

ScoreFixer supports [Lantern Load](https://github.com/LanternMC/load), a convention that lets you specify dependencies (incl. versions) and control the order in which Data Packs run. **It is vital that ScoreFixer loads and ticks before your Data Pack**, so that scores can be assigned to the new player names before your Data Pack checks them.
- **Make ScoreFixer load and tick before your Data Pack:** Specify ScoreFixer as a Lantern Load dependency (makes it load first), and make your `load` function start a self-scheduled `tick` function instead of using `#minecraft:tick`.
- `#ScoreFixer load.status`: This score is set once ScoreFixer loads. Its value tells you **whether ScoreFixer has loaded already**. Negative values are error codes:
  - 1: ScoreFixer loaded correctly and can be used
  - <unset>: ScoreFixer could not load (e.g. not installed)
  - -1: Multiple incompatible ScoreFixer versions installed
  - -2: Tried to load a ScoreFixer version while a newer one was previously installed and not manually uninstalled
  - -3: Tried to load a ScoreFixer version while a different unknown version was previously installed and not manually uninstalled
- `#ScoreFixer.Version load.status`: This score is set once ScoreFixer loads. Its value tells you **what ScoreFixer version is installed**. It's a single integer that increments whenever a potentially breaking change is made (e.g. behaviour change, utility function renamed etc). If the value does not change (e.g. only optimizations were made), any Data Packs that use ScoreFixer should not require any changes either.

</details>

## Credit
From CMDred:
- **SilicatYT**

Additional help:
- Leinad677YT (Consulting & ideas)

## License
As per the MIT License, you are allowed to redistribute, modify and use ScoreFixer as long as you provide credit for the original work.
