# Changelogs:

## 1.0
* The plugin no longer requires ClothCommons to work
* Updated to MCreator 2021.1.3117
* Updated to Minecraft 1.17 Snapshot 21w10a
* Updated Fabric API to 0.31.2
* Added support for custom potions
* Added support for custom dimensions (no portal)
* Updated the Biome mod element to support all features
  //Note: The biome dictionary is not supported because fabric doesn't support for the moment
  //Check below for custom trees
* Updated the loot table to support new features
* Updated the command mod element
* Updated the food mod element
  //Note: When item is dropped and When entity swing item are still not implemented)
* Added support for slab, leaves and pane block bases
* Added support for custom trees in biomes
  //Note: Max water depth, custom vines and fruits are not implemented yet (water depth is not supported)
* Added the smithing recipe type
* Added crop model for blocks
* Added support for custom block item and particle textures
* Added Is immune to fire, Glow condition (item + food), recipe remainder, rarity
* Added support for new item stack related procedure blocks: Is enchanted, Is enchantable, Has enchantment, Set number of items to,
  Cooldown for, Get damage, Get enchantment level, Provided itemstack
* Added support for the Return and Console log procedure blocks
* Explode procedure block now supports the explosion type  
* Biomes can now be generated in the overworld
* Changed and fixed some mappings
* Remove mixins entirely
* Custom axes, pickaxes, swords, shovels and hoes have now to be added inside the fabric item tag to work with modded blocks
  //Note: Item tags: fabric:axes, fabric:pickaxes, fabric:swords, fabric:shovels and fabric:hoes
  //Without this change, files have to be manually changed to remove the "null" each type a custom tool is deleted.
* [Bugfix] Mods couldn't be exported
* [Bugfix] Run client could not work
* [Bugfix] Fix transparency parameter for blocks
* [Bugfix] Blocks didn't build properly
* [Bugfix] Tools failed to compile when the attack speed was set to a decimal, and the damage would be reduced by the attack speed.
* [Bugfix] Surely more bug fix caused by mixins
* [Bugfix] Custom armors had a black and white renderer
* [Bugfix] Custom armors without an equipment sound or with an invalid sound caused a build error
* [Bugfix] Number dependencies in procedures couldn't be used
* [Bugfix] Default map color for block caused a build error