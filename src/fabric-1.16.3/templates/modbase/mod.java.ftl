<#--
This file is part of MCreatorFabricGenerator.

MCreatorFabricGenerator is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

MCreatorFabricGenerator is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with MCreatorFabricGenerator.  If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->
/*
 *    MCreator note:
 *
 *    If you lock base mod element files, you can edit this file and the proxy files
 *    and they won't get overwritten. If you change your mod package or modid, you
 *    need to apply these changes to this file MANUALLY.
 *
 *
 *    If you do not lock base mod element files in Workspace settings, this file
 *    will be REGENERATED on each build.
 *
 */

package ${package};

import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;

import net.fabricmc.fabric.api.event.world.WorldTickCallback;
import net.fabricmc.fabric.api.event.player.*;
import net.fabricmc.api.ModInitializer;

import ${package}.procedures.*;
import ${package}.item.*;
import ${package}.block.*;
import ${package}.server.*;
import ${package}.world.*;

public class ${JavaModName} implements ModInitializer {

    public static final Logger LOGGER = LogManager.getLogger();

<#list sounds as sound>
	public static final Identifier ${sound}_ID = id("${sound}");
  	public static final SoundEvent ${sound}Event = new SoundEvent(${sound}_ID);
</#list>

<#list w.getElementsOfType("ENCHANTMENT") as ench>
	public static final Enchantment ${ench}_ENCH = Registry.register(Registry.ENCHANTMENT, id("${ench.getRegistryName()}"), new ${ench}Enchantment());
</#list>

<#list w.getElementsOfType("ITEM") as item>
	public static final Item ${item}_ITEM = Registry.register(Registry.ITEM, id("${item.getRegistryName()}"), new ${item}Item());
</#list>

<#list w.getElementsOfType("RANGEDITEM") as item>
	public static final Item ${item}_ITEM = Registry.register(Registry.ITEM, id("${item.getRegistryName()}"), new ${item}RangedItem());
</#list>

<#list w.getElementsOfType("MUSICDISC") as disc>
	public static final Item ${disc}_ITEM = Registry.register(Registry.ITEM, id("${disc.getRegistryName()}"), new ${disc}MusicDisc());
</#list>

<#list w.getElementsOfType("TAB") as group>
 	public static final ItemGroup ${group} = ${group}ItemGroup.get();
</#list>

<#list w.getElementsOfType("BLOCK") as block>
	<#assign ge = block.getGeneratableElement()>
	public static final Block ${block}_BLOCK = Registry.register(Registry.BLOCK, id("${block.getRegistryName()}"), new ${block}Block());
	public static final BlockItem ${block}_ITEM = Registry.register(Registry.ITEM, id("${block.getRegistryName()}"), new BlockItem(${block}_BLOCK, new Item.Settings().group(${ge.creativeTab})));
</#list>

<#list w.getElementsOfType("PLANT") as plant>
	<#assign ge = plant.getGeneratableElement()>
	public static final Block ${block}_BLOCK = Registry.register(Registry.BLOCK, id("${block.getRegistryName()}"), new ${plant}FlowerBlock());
	public static final BlockItem ${block}_ITEM = Registry.register(Registry.ITEM, id("${block.getRegistryName()}"), new BlockItem(${plant}_BLOCK, new Item.Settings().group(${ge.creativeTab})));
</#list>

<#list w.getElementsOfType("ARMOR") as armor>
	<#assign ge = armor.getGeneratableElement()>
	<#if ge.enableHelmet>
		public static final Item ${armor}_HELMET = Registry.register(Registry.ITEM, id("${armor.getRegistryName()}_helmet"), new ArmorItem(${armor}ArmorMaterial.${armor?upper_case}, EquipmentSlot.HEAD, (new Item.Settings().group(${ge.creativeTab}))));
	</#if>
	<#if ge.enableBody>
		public static final Item ${armor}_CHESTPLATE = Registry.register(Registry.ITEM, id("${armor.getRegistryName()}_chestplate"), new ArmorItem(${armor}ArmorMaterial.${armor?upper_case}, EquipmentSlot.CHEST, (new Item.Settings().group(${ge.creativeTab}))));
	</#if>
	<#if ge.enableLeggings>
		public static final Item ${armor}_LEGGINGS = Registry.register(Registry.ITEM, id("${armor.getRegistryName()}_leggings"), new ArmorItem(${armor}ArmorMaterial.${armor?upper_case}, EquipmentSlot.LEGS, (new Item.Settings().group(${ge.creativeTab}))));
	</#if>
	<#if ge.enableBoots>
		public static final Item ${armor}_BOOTS = Registry.register(Registry.ITEM, id("${armor.getRegistryName()}_boots"), new ArmorItem(${armor}ArmorMaterial.${armor?upper_case}, EquipmentSlot.FEET, (new Item.Settings().group(${ge.creativeTab}))));
	</#if>
</#list>

<#list w.getElementsOfType("TOOL") as tool>
	public static final Item ${tool}_TOOL = Registry.register(Registry.ITEM, id("${tool.getRegistryName()}"), ${tool}Tool.INSTANCE);
</#list>

	public void onInitialize() {
		LOGGER.info("Initializing ${JavaModName}");
	<#list w.getElementsOfType("FUEL") as fuel>
		${fuel}Fuel.initialize();
	</#list>

		<#list w.getElementsOfType("PROCEDURE") as procedure>
			new ${procedure}Procedure();
		</#list>

		<#list w.getElementsOfType("CODE") as code>
			${code}CustomCode.initialize();
		</#list>

		<#list w.getElementsOfType("BIOME") as biome>
			${biome}Biome.init();
		</#list>

		<#list sounds as sound>
  			Registry.register(Registry.SOUND_EVENT, ${JavaModName}.${sound}_ID, ${JavaModName}.${sound}Event);
		</#list>

		CommandRegistrationCallback.EVENT.register((dispatcher, dedicated) -> {
			<#list w.getElementsOfType("COMMAND") as command>
			${command}Command.register(dispatcher);
			</#list>
		});
	}

	public static final Identifier id(String s) {
		return new Identifier("${modid}", s);
	}
}
<#-- @formatter:on -->
