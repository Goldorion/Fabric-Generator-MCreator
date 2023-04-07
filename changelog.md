# Changelogs:

## 1.8.8
* [Bugfix #401] Key bindings were not displayed in the Controls menu
* [Bugfix #402] Biomes didn't generate and caused build errors

## 1.8.7
* Updated to support the newest 2023.1 patch (and future patches)

## 1.8.6
* Updated to MCreator 2023.1.09612
* [Bugfix #380] Get light of block procedure caused a build error (NerdyPuzzle)
* [Bugfix #381] Is biome at procedure caused a build error (NerdyPuzzle)
* [Bugfix #386] Ranged item `immediatesourceentity` dependency variable had the wrong name (NerdyPuzzle)
* [Bugfix #390] Custom item damage vs mob/animal parameter did not work (NerdyPuzzle)

## 1.8.5
* [Bugfix #364] Using custom potion effects in custom potions crashed the game
* [Bugfix #374] Blocks and items could not be generated correctly (NerdyPuzzle)
* [Bugfix #375] Features still generated Java code in JSON files

## 1.8.4
* Updated to first MCreator 2023.1 snapshot (following the first 2022.4 snapshot)
* [Bugfix #369] Fix missing mappings for the itemtype procedure (NerdyPuzzle)
* [Bugfix #371] Fix mods crashing when used together (kleiders)

## 1.8.3
* [#365] Added chinese tooltips (Grey Wind)
* [Bugfix #355] Glowing music discs caused a build error
* [Bugfix #360] Fix particles import still being in the template (NerdyPuzzle)
* [Bugfix #368] Blocks could not be created
* [Bugfix] Custom biomes caused problems
  * Note: End biomes use a hardcoded weight of 10 as no parameter can be used.

## 1.8.2
* Added support for MCreator EAP 2022.4.52117

## 1.8.1
* [#345] Added is entity swimming procedure block (kleiders)
* [Bugfix #339] Fix some problems related to key binds (kleiders)
* [Bugfix #340] Get amount in slot and Get item in slot GUI procedure blocks caused problems (kleiders)
* [Bugfix #342] Fix potion effects crashing the game (kleiders)
* [Bugfix #347] Repair items could cause problems in some cases (NerdyPuzzle)

## 1.8
* Updated to Fabric API 0.67.1
* [#79] Added support for global variable scopes: Global map and Global world
  * In some cases, they can desync. A simple fix is to check "If NOT client side"
* [#302] Added all block inventory management procedure blocks (NerdyPuzzle)
* [#308, #319, #320, #325] Added new global triggers support: Entity attacked, Entity dies, before entity is hurt, Player sends a message, Command executed, Player joins a world, Player leaves a world, Entity travels to a dimension (kleiders and NerdyPuzzle)
* [#308] Added support for entity local variables (kleiders)
* [#309] Added RepairItemRecipe Mixin and refactored a lot of things related to mixins (kleiders)
* [#316] Reintroduced support for end biomes through biome default features (NerdyPuzzle)
* [#318] Added get/set entity inventory slot procedures (NerdyPuzzle)
* [#324] Added "creativePickItem" to blocks (kleiders)
* [#322] Remove block nbts as they use forge code (NerdyPuzzle)
* [#332] Added support for the wait procedure (NerdyPuzzle)
* [Bugfix #326] Fishing mixin fix and refmap fix (kleiders)
* [Bugfix #327] The base texture parameter caused a build error in overlays
* [Bugfix #329] Custom biomes without a spawning option enabled caused a build error
* [Bugfix #331] Fix guistate dependency on GUI slots & buttons causing a build error (NerdyPuzzle)

## 1.7.1
* [Bugfix #307] "Close any open GUI for" block caused a build error
* [Bugfix #313] Mods could not be exported (once again)

## 1.7
## Release
* [#292] Added Projectile related procedures (kleiders)
* [#294] Added support for a new global trigger: Entity dies (kleiders)
* [#296] Added support for armor tick triggers  (NerdyPuzzle)
* [#301] Removed forge feature dependent procedures (NerdyPuzzle)
* [#305] Added support for ranged entity parameters (kleiders)
* [#306] Added support for 2 new global triggers: Player left clicks block and A block is broken
* [#306] Player right clicks block global trigger now supports all dependencies
* [Bugfix #232] Stair block base made the game crashed (NerdyPuzzle)
* [Bugfix #262] Ranged items crashed on servers (kleiders)
* [Bugfix #290] Launching the game using TerraBlender without a single biome crashed the game
* [Bugfix #299] "Shoot constantly when active" caused a build error (NerdyPuzzle)
* [Bugfix #303] Custom fishing rods did not work correctly (kleiders)
* [Bugfix] Entity AI tasks did not generate

## 1.7-beta-12
* Added a TerraBlender API
* Added support for Overworld and Nether biome generations
  Notes: TerraBlender is required and cave biomes are still unsupported.
* [Bugfix] Custom APIs could not be used
* [Bugfix #285] Using custom potions in a workspace caused a build error

## 1.7-beta-11
* Updated to MCreator 2022.3.41417
* Added support for 1.19.x mappings
* Removed End biome support (sorry)
* Added support for new 2022.3.41417 features
* [Bugfix #273] Custom paintings didn't appear in the game
* [Bugfix #274] Is block tagged in caused a build error
* [Bugfix] Fixed a problem with dimensions

## 1.7-beta-10
* [#260] Added support for custom bullet models
* [Bugfix #236] Items disappearing from GUI when being shift-clicked
* [Bugfix #266] Open GUI procedure block caused a build error
* [Bugfix #267] Setting Drop amount to 0 caused a build error
* [Bugfix #272] Workspaces with recipes could fail to build in some cases.

## 1.7-beta-9
* Updated Fabric API to 0.60.0
* Re-added support for the dimension mod element
* Added support for brewing stand recipes (**Read the type tooltip for info**)
* [Bugfix #259] Buttons or slots without a procedure caused a build error
* [Bugfix #264] item.crop.plant sound did not work
* [Bugfix #264] Using a custom sound crashed the game

## 1.7-beta-8
* [Bugfix #253] GUIs not using player's slots caused a build error
* [Bugfix #256] Player right clicks with item trigger caused a build error
* [Bugfix] Schedule tick could still cause a build error in some cases
* [Bugfix] Recipe remainder made the code not generating
* [Bugfix] Enabling melee damages caused a build error (missing import)
* [Bugfix] Custom sounds set caused a build error
* [Bugfix] Fire spreading caused a build error for blocks
* [Bugfix] Offset type caused a build error for blocks
* [Bugfix] Can redstone connect to block has been disabled (Forge feature)
* [Bugfix] Custom entities could not due to a missing import in some cases

## 1.7-beta-7
* [Bugfix #245] Selecting specific biomes to generate a feature caused a build error
* [Bugfix #246] Enabling the glowing effect on custom tools caused a build error due to a wrong import
* [Bugfix #247] Changing the block's tick rate could cause a build error in some cases

## 1.7-beta-6
* Updated to Minecraft 1.19.2 and Fabric API 0.59.0
* [#223] fabric.mod.json is now lockable
* [Bugfix #222] Enabling the waterloggable option for custom blocks caused a build error
* [Bugfix #229] Generated blocks, plants or structures caused a build error.
* [Bugfix #231] Sounds did not play on servers
* [Bugfix #238] Stay in crafting grid option caused a build error
* [Bugfix #243] Disabled the creative pick item parameter for blocks and plants (Forge feature)
* [Bugfix] Random offset plant parameter caused a build error when changed.

### 1.7-beta-5
* [#220] A Gradle task is now executed to decompile the code (to open it)
* [Bugfix #217] Execute commands procedure blocks could not be used
* [Bugfix #219 #221] Multiple procedure blocks caused a build error due to the usage of `new TextComponent`

### 1.7-beta-4
* [#202] Added support for custom Java models for entities (Same as Forge 1.18.2)
* [Bugfix] Custom armors had a black and purple renderer

### 1.7-beta-3
* Custom Java models can no longer be imported (currently unsupported)
* [Bugfix #214] The play sound procedure block caused a build error
* [Bugfix] Custom sound types for blocks caused a build error
* [Bugfix] Tamable entities could cause a build error
* [Bugfix] Get fuel power procedure block caused a build error
* Some other minor fixes and changes

### 1.7-beta-2
* Disable some generation parameters in the biome mod element (they were not implemented)
* [Bugfix #211] Mods could not be exported
* [Bugfix] Fix fishing rods causing a build error

### 1.7-beta-1
* Added base support for Fabric 1.19.1
* Added support for mod elements: advancement, armor, biome, block, code, command, enchantment, function, game rule, gui, item, item extension, key bind, living entity, loot table, music disc, overlay, plant, potion, potion effect, procedure, ranged item, recipe, structure, tab, tag, tool
* Added some minor features from 2022.2 snapshots
* [Bugfix] Add item to player's inventory caused a build error

Notes: 1.19 mappings will come after official data lists are updated. Biomes are far from being as in the 1.17.1 generator because I will now need to use TerraBlender to generate biomes in the overworld. Even if I support Nether and End gens, I can't apply surface rules currently and so, I will also need TerraBlender.
Dimensions are also not done because they changed once again between 1.18.2 and 1.19, and I didn't find how to port them.
You can also expect several bugs, mostly when using procedure blocks.

## 1.6

### Release
* Updated to MCreator 2022.2
* Added support for the new Item extension mod element
* Added support for the new command arguments
* Added support for the new texture categories
* Added new block features: pitch rotation, requires correct tool option and projectile hits the block
* Added new plant features: is solid option, projectile hits the block and entity walked on the plant
* Added blockstate management procedure blocks to universally read, write and modify block states
* Added entity procedures: for each passenger, for each direct passenger, get passenger that is controlling entity, and get lowest ridden entity
* [Bugfix] Checkboxes in custom GUIs had too big of a click region

### 1.6-beta-4
(Unsupported by Fabric)
* [Bugfix #197] Disabled "When block destroyed by player" block/plant trigger
* [Bugfix #198] Removed entity NBT related procedure blocks

### 1.6-beta-3
* Updated to 2022.1
* Fix the access widener problem
* [Bugfix #188] Selecting mega spruce tree type in biomes made the game crashed
* [Bugfix #192] Local variables were not generated
* [Bugfix #187] Several advancement triggers did not work properly
* [Bugfix] Some recipes had problems

### 1.6-beta-2
* Fixed #180
  * Note: If you already opened a workspace, follow these steps:
    1. Close your workspace and go inside your workspace's folder
    2. Open in Notepad or another text editor the `.mcreator` file
    3. Search `currentGenerator`, inside `workspaceSettings` and replace `fabric-1.17.1` by `fabric-1.16.5` (Install it!)
    4. Save, close, re-open your workspace, and re-select Fabric 1.17.1

### 1.6-beta-1
* Added base support for Fabric 1.17.1
* Added support for mod elements: advancement, armor, biome, block, command, creative tab, custom element, dimension, enchantment, food, fuel, function, game rule, gui, item, key binding, living entity, loot table, music disc, overlay, painting, particle, potion effect, potion item, procedure, ranged item, recipe, structure, tag, tool and variables
* Added support for new global triggers: Player in bed, Player respawns and Player wakes up
* Added support for water loggable blocks
* Added support for tinted plants and blocks
* Added support for following block procedure blocks: Play break effect, is side solid
* Added support for following direction procedure blocks: For each direction, for each horizontal direction, direction iterator, direction random
* Added support for following direction procedure blocks: Check player game mode, Get entity shoot power, Get entity slot, For each slot of entity inventory, Get entity look face, Get/Set logic/number/string entity NBT tag, Get potion effect level, Get potion effect remaining, Remove item, Remove recipe, remove specific potion effect, Remove xp, remove xp level, Run function, send chat, set flying, set food level, set main hand item, set offhand item, set no gravity, set oxygen, set rotation, set saturation, set scoreboard score, set slot, set sneaking, set spawn, set sprinting, set in cobweb, size height, size width, submerged height, xp level, logic entity compare
* Added support for following item procedure blocks: bucket to fluid, 
* Added support for misc procedure blocks: Get dimension id, get localized text
* Added support for following world procedure blocks: shoot arrow, spawn entity, spawn entity with rotation, spawn entity with rotation and velocity, strike lightning, get number of players on the server, entity in range, entity in range exists, entity in range foreach, spawn falling block, switch world, use bone meal

## 1.5.3
* [Bugfix] Fix Get fuel power of, Is blockat solid, replace block, get/set logic/text block NBT Tag of block, get enchantment level of itemstack, get smelting result, place structure, run function, set global spawn, set time, spawn item entity, get biome at, get dimension id procedure blocks
* [Bugfix] Fix music disc build error
* [Bugfix #166] Fix the On food eaten food trigger

## 1.5.2
* [Bugfix #164] Food elements did not generate files

## 1.5.1
* [Bugfix #150] Entities with the Biped model now display equipped items
  * The fix was applied to chicken models
* [Bugfix] Some AI tasks blocks prevented the entity to build

## 1.5

* Added full support for custom GUIs
* Added support for Block entity
* Added support for Block, entity and item inventories
* Added support for following GUI related procedure blocks: Deal damage to item in slot, Get amount in slot, get item in
  slot, remove items, Set item in slot, Get text in textfield, Is checkbox checked, Set text in textfield
* Add support for flying entities
* Added following AI task blocks: Attack fly, Break blocks, Fly, Move indoors
* Added support for custom dispenser behaviour for custom items
* [#111] Added "Does item stay in crafting grid" item and tool parameter support
* [#152] Added support for the immediatesourcentity dependency for bullet triggers in ranged items
* [Bugfix] Using the custom drop option in custom blocks caused a build error (due to a change from the last version)
* [Bugfix] On block right-clicked block trigger caused a build error
* [Bugfix] Right-click in air item trigger caused a build error.
* [Bugfix] Biomes using a custom entity didn't build properly
* [Bugfix #152] Entities with the Biped model now display equipped items

## 1.4.2

* [Bugfix] Custom biome sounds caused a build error
* [Bugfix] BerryBushes, SwampClayDisk and TaigaLargeFerns default features caused a build due to a wrong value
* [Bugfix] On initial spawn entity trigger caused a build error when a procedure was selected
* [Bugfix #143] Ray tracing procedure blocks cause a build error
* [Bugfix #145] Enabling the boss bar in custom entities caused a build error
* [Bugfix #146, #147, #148] Mod elements having an element selected inside a block/item selector always failed to build.

## 1.4.1

* [Bugfix] Right-click in air tool trigger caused a build error.
* [Bugfix] Custom shears caused a build error
* [Bugfix] Special and multi-tool weren't fully supported (causing build errors)
* [Bugfix #139] Selecting the Nether or the End dimensions in the plant generation caused a build error
* [Bugfix #142] Enabling the `Does emit redstone` property for custom blocks caused a build error

## 1.4

### Release

* Added the possibility to generate custom biomes in the Nether and The End. // Read the tooltip of the biome
  dictionnary.
* Added support for the Action Result Type procedure block
* Added support for new logic related procedure blocks: Advancement is equal to, compare dimension id, compare entities,
  compare itemstacks, compare items
* Added support for new blocks related procedure blocks: Block is fertilizable, is valid position, is waterloggable, NBT
  logic get, NBT logic set, get hardness, is solid, get light level, get opacity, convert block to item, Provided
  blockstate, Item to block
* Added support for new fluid related procedure blocks: Is fluid, is fluid source, get fluid at
* Added support for new direction related procedure blocks: Compare axes, x offset, y, offset, z offset, rotate
  clockwise, rotate counterclockwise
* Added support for new entity and player related procedure blocks: Add exhaustion, add potion, add potion (advanced),
  add recipe, check creature type, deal custom damage, get dimension ID, get absorption, get armor slot item, get flying
  speed, get oxygen, get saturation, get scoreboard score, get walk speed, get owner, get riding entity, get target
  entity, has no gravity, has recipe, is elytra flying, is tagged in, is alive, is blocking, is child, is immune to
  explosions, is immune to fire, is in lava, is in water, is in water or bubble column, is invisible, is invulnerable,
  is leashed, is non boss, is on ground, is tamed, is tamed by, make ride, make tamed, move entity
* Added support for new item and itemstack related procedure blocks: Can smelt, check rarity, deal damage [#89],
  enchanted with xp, fuel power, get food value, get max damage [#89], get saturation value, is food, is tool, is name,
  name, NBT logic/number/String get/set, set damage [#89], set display name, show totem like animation, item entity to
  itemstack, get count, grow, itemstack iterator, remove specific enchantment, shrink
* Added support for new world related procedure blocks: Place structure, play sound, provided dimension id, run
  function, get dimension id, get height at, get number of players in provided world, for each player in the world

### Snapshot 1

Note: Incompatible with MCreator 2021.2.31709 and older

* Update to MCreator 2021.2
* Improved generated code style in some places
* Disabled all unsupported parameters for armor, biome, block, enchantment, food, item, living entity, music disc,
  plant, potion effect, ranged item and tool mod elements
* Added support for custom potion and custom potion effect (the split)
* Added missing features for custom potion effects
* Added support for new block bases: End rod, Pressure plate and Button
* Added support for the fishing rod tool type
* Added support for new block parameters: Custom sound set, Redstone properties, placing condition, on right-clicked and
  on block placed by triggers
* Added support for new plant parameters: Double plant, Custom sound set, Creative pick item, Placing condition, Custom
  set of blocks a plant can be placed/grow on, On block added and On block placed by triggers
* Added support for a new tool parameter: When block destroyed with tool trigger
* Added support for new enchantment features
* Added support for new ranged item parameters: Action sound and animation
* Added support for blockstate, direction and action result variable types
* Added support for Action Result return value in triggers
* Added Global session scope support
* Added the new plugin update checking system
* Added support for Is immune to fire for custom armors
* [Bugfix] Is curse option for enchantments didn't apply to the enchantment
* [Bugfix] Fix custom bounding box condition for plants
* [Bugfix] Some other minor fixes and improvements

## 1.3

Note: Except if a major bug is found, this version is the last one supporting MCreator 2021.1.

* Added custom structure spawn mod element
* Added custom particle mod element
* Added Particle properties support for blocks
* Added support for Client display random tick for custom blocks and plants
* [Bugfix] Imitate overworld behaviour parameter caused a crash.
* [Bugfix] Custom enchantments didn't compile due to the class duplicated inside the same class
* [Bugfix] Fix enchantment mappings
* [Bugfix #133] Spawn XP orb and Add enchantment to itemstack procedure blocks caused a build error

## 1.2

Note: This version will not be loaded on MCreator 2021.2 (including snapshots). 2021.2 snapshots make several major
changes, making the current version incompatible with them. Another version will be made to support entirely MCreator
2021.2

* Updated to Fabric API 0.37.1
* Improved generated code for custom armors
* Added support for the painting mod element
* [#124] Added support for tooltips for each armor item
* Added knockback resistance support for custom armors
* [Bugfix #113] Workspaces could not build properly.
* [Bugfix #118] The drop of custom block caused a build error.
* [Bugfix #131] Blocks and items did not appear in custom creative tabs

## 1.1

### Release

* Updated Fabric API to 0.34.6
* Added a complete support for the game rule mod element
* Added support for block generation parameters
* Added support for all plant generation types and generation parameters
* Added new world procedure blocks: get logic game rule, get number game rule, set logic game rule and set number game
  rule
* Added complete support for Tick randomly
* Added a new block trigger: Update tick
* Updated the tag mod element to support entities
* Added new block bases: [#104] Stairs, door, fence, fence gate
* [Bugfix #110] GROUND and PLANT step sounds had the wrong sound.
* [Bugfix] Transparency on custom plants was black.
* [Bugfix] Update tick trigger for plants caused a build error.

### Snapshot 1

* [#83] Added support for custom living entities Note: Flying entities are not 100% implemented. Entity inventory and
  Ranged attacks are not implemented.
* Added minimum and maximal enchantment level parameters
* Added Enable melee damage checkbox for custom items
* [Bugfix #102] Some block triggers caused build errors
* [Bugfix #105] Blocks mined with a tool using a lower harvest level dropped.
* [Bugfix] Some sound mappings did not work properly

## 1.0.2

* [Bugfix #99] Repair items could not use custom tools
* [Bugfix #101] Select a map color on custom blocks caused a build error
* [Bugfix #102] Some block triggers caused build errors
* [Bugfix #102] Several world procedure blocks caused a build error
* [Bugfix] Some Material mappings were wrong
* [Bugfix] Custom plants prevented the workspace compilation

## 1.0.1

* Updated to MCreator EAP 2021.12313
* Updated Fabric API to 0.32.5
* Updated the command mod element to support new features
* Updated the block and plant mod elements to support the new bounding box editor
* [#72] Bounding boxes now properly rotate
* Added grass model for blocks
* Added new block/plant properties: Step sound, speed and jump factors
* [Bugfix] Custom blocks did not compile due to the new bounding box editor
* [Bugfix] The code of custom plants were not generated
* [Bugfix] An error was still printed in the console saying custom trees are not supported yet.

## 1.0

* The plugin no longer requires ClothCommons to work
* Updated to MCreator 2021.1.3117
* Updated to Minecraft 1.16.5
* Updated Fabric API to 0.32.0
* Added support for custom potions
* Added support for custom dimensions (no portal)
* Updated the biome, command, food, loot table and overlay to support new features //Note for biomes: The biome
  dictionary is not supported because fabric doesn't support for the moment. Check below for custom trees //Note for
  foods: When item is dropped and When entity swing item are still not implemented)
* Added support for slab, leaves and pane block bases
* Added support for custom trees in biomes //Note: Max water depth, custom vines and fruits are not implemented yet (
  water depth is not supported)
* Added the smithing recipe type
* Added support for local variables in procedures
* Added crop model for blocks
* Added support for custom block item and particle textures
* Added Is immune to fire, glow condition, recipe remainder, rarity
* Added support for new item stack related procedure blocks: Is enchanted, Is enchantable, Has enchantment, Set number
  of items to, Cooldown for, Get damage, Get enchantment level, Provided itemstack
* Added support for the Return and Console log procedure blocks
* Explode procedure block now supports the explosion type
* Biomes can now be generated in the overworld
* Added all missing mappings and fixed some mapping files
* Remove mixins entirely
* Custom axes, pickaxes, swords, shovels and hoes have now to be added inside the fabric item tag to work with modded
  blocks //Note: Item tags: fabric:axes, fabric:pickaxes, fabric:swords, fabric:shovels and fabric:hoes //Without this
  change, files have to be manually changed to remove the "null" each type a custom tool is deleted.
* [Bugfix] Mods couldn't be exported
* [Bugfix] Run client could not work
* [Bugfix] Fix transparency parameter for blocks
* [Bugfix] Blocks didn't build properly
* [Bugfix] Tools failed to compile when the attack speed was set to a decimal, and the damage would be reduced by the
  attack speed.
* [Bugfix] Surely more bug fix caused by mixins
* [Bugfix] Custom armors had a black and white renderer
* [Bugfix] Custom armors without an equipment sound or with an invalid sound caused a build error
* [Bugfix] Number dependencies in procedures couldn't be used
* [Bugfix] Default map color for blocks caused a build error
* [Bugfix] Custom music discs didn't play the sound
* [Bugfix] Fix custom enchantments in mappings

## 1.0.0-pre6

* Updated to the second 2020.5 snapshot
* Started to update biomes to the second 2020.5 snapshot. (Structures and Default Features)
* [Bugfix] Blocks Break Thread Three Fix #74 and #80

## 1.0.0-pre5

* Added overworld biome generation.

## 1.0.0-pre4

* Updated to 1.16.3
* [Bugfix] Fixed a crash with modmenu

## 1.0.0-pre3

* Updated to 1.16.3 rc-1
* Re-added modmenu support

## 1.0.0-pre2

* Added Ranged Item mod element.

## 1.0.0-pre1

* Added Plant mod element
* Added Biome mod element
* Added the damage vs mob/animal for items (#68)
* Some mapping changes
* [Bugfix] Fixed Item, Tool and Block Tooltips
* [Bugfix] Fixed block_nbt_num_set
* [Bugfix] Fixed commands (fixes #65)

## 1.0.0-alpha5

- Updated Fabric, Fabric API and mapping versions
- [Bugfix #45]  Procedures didn't compile properly (#57)
- [Bugfix #50] Food elements didn't compile properly (#59)
- Added emissive lighting for blocks (#59)

## 1.0.0-alpha4

The plugins now require [Cloth Commons](https://github.com/ClothCreators/ClothCommons) to work.

* Added all mappings (1.16.2 and before)
* [Bugfix] Fixed x y z dependencies in global triggers
* [Bugfix #47]
* [Bugfix #51]

## 1.0.0-alpha3

- Updated the generator to Minecraft 1.16.2
- [Bugfix #48]

## 1.0.0-alpha2

- Added overlays
- Added music discs
- Added key bindings (They still have bugs)
- Added commands
- Added enchantments
- [Bugfixes] Fixed all (or almost, an option for the items has been deactivated for the moment) elements of the first
  alpha version.

## 1.0.0-alpha1

- Items (inventory is not supported yet)
- Blocks (block entities are not supported yet)
- Armor
- Tools
- Food
- Fuel
- Item groups
- Procedures (77 procedure blocks, and 4 global triggers)
- Custom code
- Recipes
- Advancements
- Loot tables
- Functions
- Tags

## 0.6.1

* [Bugfix #32]
* [Bugfix #33]
* Updated fabric API

## 0.6.0

### All Changes:-

* **Added support for Non-pushable block entities**
* **Armor can now use custom sounds**
* **Added support for Falling blocks**
* **Item groups are back!**
* **Added support for directional properties on blocks (all five of them)**
* **Added support for custom voxelshapes that work with directional blocks**
* **Added support for custom biomes**
* **Added support for Ore generation. This is very incomplete and works only in the nether and overworld, and replaces
  netherrack and the 4 stone variants respectively**
* **Added support for the creation of plants**. Features:
    * Offset type
    * All other implemented block properties
    * Unbreakability
* Added support for Item, Block and Food tooltips
* Added support for enchantment glint on Items and Food
* Added support for drinking on food (drinking means different sounds and no particles)
* Added support for enchantability on Items
* Added support for melee damage on Items
* Added tool tags for tools
* Added support for the luminance on Blocks
* Added support for light opacity on Blocks
* Added the ability to add custom fuels (and it works this time)
* The base mod now includes mod menu
* Food can now have custom eating time
* Updated Loom to 0.4.26
* Added support for block transparency
* Added support for connected block sides
* Added support for block tick rate (Does nothing for now)
* Updated fabric API to 0.12
* Updated yarn version

### Changes from the previous snapshot:-

* Fixed a critical bug with biomes
* Optimized code
* Updated fabric loader to 0.8.8

## 0.5.0

- **Updated Fabric API version to 0.11.1+build.312-1.15**
- **Updated the Fabric version for 0.8.7+build.201 (If you get an error with the setup, Re-run the setup.)**
- Updated yarn mappings for the 1.15.2+build.17 version
- **Added support for armors**
- Added support for the Repair Items feature for Tools and Armors
- Added harvest level for mining blocks
- Not Specified tool can now be used for block.
- Other mapping changes
- [Bugfix] Block hardness didn’t work properly with numbers.
- **[Bugfix #5] Smelting, Blasting, Smoking, Campfire recipe types didn't work.**

## 0.4.1

* [Bugfix] Fixed some block materials having wrong mapping names
* [Bugfix] Fixed block sounds having wrong mapping names
* Added more block materials
* Changed block materials

## 0.4.0

* Added support for tools (Pickaxe, Axe, Shovel, and Sword)
* Added support for the maximal damage for items
* The generator has now its own workspace type. Your old workspaces can be broken. It is recommended to create a new
  workspace.
* Removed Block Render (Didn't work)
* [Bugfix] Fixed Fuel element
* [Bugfix] The main class had nothing inside if you make a block
* [Bugfix] Fixed Block element

## 0.3.0

* Added Basic Block Element:
    * Render (Solid, cutout, cutout mipped, and translucent)
    * Hardness/Resistance/Material/Sound/Creative tab
    * Generation in the world (Specific biomes don’t work)
* Added Food Element (Few parameters don’t work)
* Added Fuel Element

## 0.2.1

* [Bugfix] Fixed bugs
* Removed ItemGroup feature, will be re-added later
* Added Recipe, Tag, Function, Advancement, and Loot Table Features

## 0.2.0

* Added Basic Creative Tabs
* Added Advancements
* Added Loot Tables
* Added Recipes
* Added Functions
* Added Recipes

## 0.1.0

* Basic item support
