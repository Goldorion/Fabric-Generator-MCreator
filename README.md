# MCreator Fabric Generator
A plugin for [MCreator](https://mcreator.net/), a code generator to create Minecraft mods. Adds a [Fabric](https://fabricmc.net/) generator type.

This project is not official. It is not affiliated with the respective owners and maintainers of Fabric, Minecraft, or MCreator. Do not expect any official support from their communities.

**The current targeted Minecraft version is 1.17.1.**
**The 1.17.1 version is still W.I.P. to get features of the last 1.16.5 version.**

## Features
Unsupported fields in full supported mod elements are features from Forge only. They are not available with Fabric yet.
### Full supported
* Advancement
* Command
* Custom code
* Enchantment 
* Food
* Fuel
* Function
* Game rule
* GUI
* Item
* Item group
  Missing: Re-order creative tabs
* Key binding
* Loot table
* Music disc
* Overlay
* Painting
* Particle
* Plant
* Potion Effect
* Potion
* Recipe
* Structure spawn
* Tool

### Partially supported (almost completed)
* Armor
* Biome
* Block
* Dimension
* Living entity
* Ranged item
  
### Partially supported
* Procedure
* Variables
  // Global scopes, except Global session, are missing.

### Unsupported
* Fluid

## Installation Instructions
Pre-built binaries can be found on the [Release page of this repository](https://github.com/Goldorion/Fabric-Generator-MCreator/releases).

Install like any other plugin: Launch MCreator -> Open preferences -> Manage plugins -> Load Plugin -> Find your downloaded zip file -> **Restart MCreator**.

## Important Information
- Make sure you use MCreator 2021.2.33614 or a newer version
- Back up your workspace before updating to a newer version of the plugin.
- Mods will also require [Fabric API](https://www.curseforge.com/minecraft/mc-mods/fabric-api) to function properly, so when you want to play your mod, make sure you have fabric api.

## Credits/License
Lead Dev - [Goldorion](https://github.com/Goldorion), [BoogieMonster1O1](https://github.com/BoogieMonster1O1)
Contributors - crispy_chips1234, Klemen, U1timateJ7
Thanks to all of you helping in reporting bugs, testing or anything else.

The plugin's MCreator forum page is [here](https://mcreator.net/forum/60201/fabric-generator-plugin).

Licensed under the GNU Lesser General Public License, version 3.0  
- Mods created with this tool may be closed source and/or be distributed with a different license.
- Appropriate credit must be provided to the creators and maintainers of this software.
- Forked versions of this software must be distributed under the same license as this with attribution, if distributed.
- Changes must be stated if any modified works are to be distributed.
- Under no circumstances can you state that modified works are endorsed by the original creators.
