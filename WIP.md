## WIP List

- Fix tints not being applied in the game on custom blocks
  - See [this page](https://docs.fabricmc.net/develop/blocks/block-models#elements) to fix the problem
- Port GLOBAL_MAP and GLOBAL_WORLD variable scopes
- Custom entities don't spawn :(
- should we be interested in restoring the centerX, centerY, xAngle, yAngle variables to their old state? [Patch](https://github.com/neoforged/NeoForge/blob/26.1.x/patches/net/minecraft/client/gui/screens/inventory/InventoryScreen.java.patch)

???
- Port [[Bugfix] Certain GUI-related procedure blocks did not work in combination with GUI opened procedure triggers](https://github.com/MCreator/MCreator/commit/ce0485bf8f83e043bae47dd2cec5a257c331ded8)
- Port [[Bugfix] Buckets of custom fluids did not work correctly with fluid tanks of other mods](https://github.com/MCreator/MCreator/commit/86fea15eca651ac30458d43575dd7568c31d684f)