# Changelogs:
## 0.6.2-alpha1
- minor updates to generator for partial revival

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
* **Added support for Ore generation. This is very incomplete and  works only in the nether and overworld, and replaces netherrack and the 4 stone variants respectively**
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
* The generator has now its own workspace type. Your old workspaces can be broken. It is recommended to create a new workspace.
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
