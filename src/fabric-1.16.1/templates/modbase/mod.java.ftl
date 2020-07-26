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

public class ${JavaModName} implements ModInitializer {

    public static final Logger LOGGER = LogManager.getLogger();

<#list w.getElementsOfType("ITEM") as item>
	public static final Item ${item}_ITEM = Registry.register(Registry.ITEM, id("${item.getRegistryName()}"), new ${item}());
</#list>

<#list w.getElementsOfType("TAB") as group>
 	public static final ItemGroup ${group} = ${group}ItemGroup.get();
</#list>

<#list w.getElementsOfType("BLOCK") as block>
	<#assign ge = block.getGeneratableElement()>
	public static final Block ${block}_BLOCK = Registry.register(Registry.BLOCK, id("${block.getRegistryName()}"), new ${block}());
	public static final BlockItem ${block}_BLOCK_ITEM = Registry.register(Registry.ITEM, id("${block.getRegistryName()}"), new BlockItem(${block}, new Item.Settings().group(${ge.creativeTab})));
</#list>

<#list w.getElementsOfType("ARMOR") as armor>
	<#assign ge = armor.getGeneratableElement()>
	<#if ge.enableHelmet>
		public static final Item ${armor}_ARMOR = Registry.register(Registry.ITEM, id("${armor.getRegistryName()}"), new ArmorItem(${armor}ArmorMaterial.${armor?upper_case}, EquipmentSlot.HEAD, (new Item.Settings().group(${ge.creativeTab}))));
	</#if>
	<#if ge.enableBody>
		public static final Item ${armor}_ARMOR = Registry.register(Registry.ITEM, id("${armor.getRegistryName()}"), new ArmorItem(${armor}ArmorMaterial.${armor?upper_case}, EquipmentSlot.CHEST, (new Item.Settings().group(${ge.creativeTab}))));
	</#if>
	<#if ge.enableLeggings>
		public static final Item ${armor}_ARMOR = Registry.register(Registry.ITEM, id("${armor.getRegistryName()}"), new ArmorItem(${armor}ArmorMaterial.${armor?upper_case}, EquipmentSlot.LEGS, (new Item.Settings().group(${ge.creativeTab}))));
	</#if>
	<#if ge.enableBoots>
		public static final Item ${armor}_ARMOR = Registry.register(Registry.ITEM, id("${armor.getRegistryName()}"), new ArmorItem(${armor}ArmorMaterial.${armor?upper_case}, EquipmentSlot.FEET, (new Item.Settings().group(${ge.creativeTab}))));
	</#if>
</#list>

<#list w.getElementsOfType("TOOL") as tool>
	public static final Item ${tool}_TOOL = Registry.register(Registry.ITEM, id("${armor.getRegistryName()}"), ${tool}Tool.INSTANCE);
</#list>

	public void onInitialize() {
		LOGGER.info("[${JavaModName}] Initializing");
	<#list w.getElementsOfType("FUEL") as fuel>
		${fuel}Fuel.initialize();
	</#list>
		Registry.BIOME.forEach((biome) -> {
			<#list w.getElementsOfType("BLOCK") as block>
			${block}_BLOCK.genBlock(biome);
			</#list>
		});
		RegistryEntryAddedCallback.event(Registry.BIOME).register((i, identifier, biome) -> {
			<#list w.getElementsOfType("BLOCK") as block>
				${block}_BLOCK.genBlock(biome);
			</#list>
		})
		WorldTickCallback.EVENT.register((world) -> {
		<#list w.getElementsOfType("PROCEDURE") as procedure>
			${procedure}Procedure.worldTick(world);
		</#list>
		});
		UseBlockCallback.EVENT.register((player, world, hand, hitResult) -> {
		<#list w.getElementsOfType("PROCEDURE") as procedure>
			${procedure}Procedure.useOnBlock(player, world, hand, hitResult);
		</#list>
			return ActionResult.PASS;
		});
		UseEntityCallback.EVENT.register((player, world, hand, entity, hitResult) -> {
		<#list w.getElementsOfType("PROCEDURE") as procedure>
			${procedure}Procedure.useOnEntity(player, world, hand, entity, hitResult);
		</#list>
			return ActionResult.PASS;
		});
		UseItemCallback.EVENT.register((player, world, hand) -> {
		<#list w.getElementsOfType("PROCEDURE") as procedure>
			${procedure}Procedure.useItem(player, world, hand);
		</#list>
			return ActionResult.PASS;
		});

		<#list w.getElementsOfType("CODE") as code>
			${code}CustomCode.initialize();
		</#list>
	}

	public static final Identifier id(String s) {
		return new Identifier("${modid}", s);
	}
}
<#-- @formatter:on -->
