<#--
This file is part of Fabric-Generator-MCreator.

Fabric-Generator-MCreator is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Fabric-Generator-MCreator is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with Fabric-Generator-MCreator.  If not, see <https://www.gnu.org/licenses/>.
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

public class ${JavaModName} implements ModInitializer {

    public static final Logger LOGGER = LogManager.getLogger();

<#list sounds as sound>
	public static final Identifier ${sound}_ID = id("${sound}");
  	public static final SoundEvent ${sound}Event = new SoundEvent(${sound}_ID);
</#list>

<#list w.getElementsOfType("enchantment") as ench>
	public static final Enchantment ${ench}_ENCH = Registry.register(Registry.ENCHANTMENT, id("${ench.getRegistryName()}"), new ${ench}Enchantment());
</#list>

<#list w.getElementsOfType("item") as item>
	public static final Item ${item}_ITEM = Registry.register(Registry.ITEM, id("${item.getRegistryName()}"), new ${item}Item());
</#list>

<#list w.getElementsOfType("rangeditem") as item>
	public static final Item ${item}_ITEM = Registry.register(Registry.ITEM, id("${item.getRegistryName()}"), new ${item}RangedItem());
</#list>

<#list w.getElementsOfType("musicdisc") as disc>
	public static final Item ${disc}_ITEM = Registry.register(Registry.ITEM, id("${disc.getRegistryName()}"), new ${disc}MusicDisc());
</#list>

<#list w.getElementsOfType("tab") as group>
 	public static final ItemGroup ${group} = ${group}ItemGroup.get();
</#list>

<#list w.getElementsOfType("block") as block>
	<#assign ge = block.getGeneratableElement()>
	public static final Block ${block}_BLOCK = Registry.register(Registry.BLOCK, id("${block.getRegistryName()}"), new ${block}Block());
	public static final BlockItem ${block}_ITEM = Registry.register(Registry.ITEM, id("${block.getRegistryName()}"), new BlockItem(${block}_BLOCK, new Item.Settings().group(${ge.creativeTab})));
</#list>

<#list w.getElementsOfType("plant") as plant>
	<#assign ge = plant.getGeneratableElement()>
	public static final Block ${plant}_BLOCK = Registry.register(Registry.BLOCK, id("${plant.getRegistryName()}"), new ${plant}Block());
	public static final BlockItem ${plant}_ITEM = Registry.register(Registry.ITEM, id("${plant.getRegistryName()}"), new BlockItem(${plant}_BLOCK, new Item.Settings().group(${ge.creativeTab})));
</#list>

<#list w.getElementsOfType("armor") as armor>
	<#assign ge = armor.getGeneratableElement()>
	<#if ge.enableHelmet>
		public static final Item ${armor}_HELMET = Registry.register(Registry.ITEM, id("${armor.getRegistryName()}_helmet"), ${armor}ArmorMaterial.HELMET);
	</#if>
	<#if ge.enableBody>
		public static final Item ${armor}_CHESTPLATE = Registry.register(Registry.ITEM, id("${armor.getRegistryName()}_chestplate"), ${armor}ArmorMaterial.CHESTPLATE);
	</#if>
	<#if ge.enableLeggings>
		public static final Item ${armor}_LEGGINGS = Registry.register(Registry.ITEM, id("${armor.getRegistryName()}_leggings"), ${armor}ArmorMaterial.LEGGINGS);
	</#if>
	<#if ge.enableBoots>
		public static final Item ${armor}_BOOTS = Registry.register(Registry.ITEM, id("${armor.getRegistryName()}_boots"), ${armor}ArmorMaterial.BOOTS);
	</#if>
</#list>

<#list w.getElementsOfType("tool") as tool>
	public static final Item ${tool}_ITEM = Registry.register(Registry.ITEM, id("${tool.getRegistryName()}"), ${tool}Tool.INSTANCE);
</#list>

<#list w.getElementsOfType("potioneffect") as effect>
	<#assign ge = effect.getGeneratableElement()>
	public static final StatusEffect ${effect}_STATUS_EFFECT = Registry.register(Registry.STATUS_EFFECT, id("${effect.getRegistryName()}"), new ${effect}Effect());
</#list>

<#list w.getElementsOfType("potion") as potion>
	<#assign ge = potion.getGeneratableElement()>
	public static final Potion ${potion}_POTION = Registry.register(Registry.POTION, id("${potion.getRegistryName()}_potion"), new ${potion}Potion());
</#list>

<#list w.getElementsOfType("biome") as biome>
    public static final RegistryKey<Biome> ${biome}_KEY = RegistryKey.of(Registry.BIOME_KEY, id("${biome.getRegistryName()}"));
</#list>

<#list w.getElementsOfType("gamerule") as gamerule>
    <#assign ge = gamerule.getGeneratableElement()>
	<#if ge.type == "Number">
        public static final GameRules.Key<GameRules.IntRule> ${gamerule} = ${gamerule}GameRule.gamerule;
    <#else>
        public static final GameRules.Key<GameRules.BooleanRule> ${gamerule} = ${gamerule}GameRule.gamerule;
    </#if>
</#list>

<#list w.getElementsOfType("painting") as painting>
    <#assign ge = painting.getGeneratableElement()>
        public static final PaintingMotive ${painting} = Registry.register(Registry.PAINTING_MOTIVE,
            id("${painting.getRegistryName()}"), ${painting}Painting.painting);
</#list>

<#list w.getElementsOfType("gui") as gui>
	public static final ScreenHandlerType<${gui}Gui.GuiContainerMod> ${gui}ScreenType = ScreenHandlerRegistry.registerExtended(id("${gui.getRegistryName()}"), ${gui}Gui.GuiContainerMod::new);
</#list>

	@Override
	public void onInitialize() {
		LOGGER.info("Initializing ${JavaModName}");

	    <#list w.getElementsOfType("fuel") as fuel>
		    ${fuel}Fuel.initialize();
	    </#list>

	    <#list w.getElementsOfType("block") as block>
	        <#if (block.getGeneratableElement().spawnWorldTypes?size > 0)>
	            ${block}Block.Generation.init();
	        </#if>
	    </#list>

	    <#list w.getElementsOfType("plant") as plant>
	        <#if (plant.getGeneratableElement().spawnWorldTypes?size > 0)>
	            ${plant}Block.Generation.init();
	        </#if>
	    </#list>

		<#list w.getElementsOfType("procedure") as procedure>
			new ${procedure}Procedure();
		</#list>

		<#list w.getElementsOfType("code") as code>
			${code}CustomCode.initialize();
		</#list>

		<#list w.getElementsOfType("biome") as biome>
			${biome}Biome.init();
		</#list>

		<#list w.getElementsOfType("livingentity") as entity>
			${entity}Entity.init();
		</#list>

		<#list w.getElementsOfType("structure") as structure>
			${structure}Structure.init();
		</#list>

		<#list w.getElementsOfType("gui") as gui>
			${gui}GuiWindow.screenInit();
		</#list>

		<#list sounds as sound>
  			Registry.register(Registry.SOUND_EVENT, ${JavaModName}.${sound}_ID, ${JavaModName}.${sound}Event);
		</#list>

		CommandRegistrationCallback.EVENT.register((dispatcher, dedicated) -> {
			<#list w.getElementsOfType("command") as command>
			${command}Command.register(dispatcher);
			</#list>
		});
	}

	public static final Identifier id(String s) {
		return new Identifier("${modid}", s);
	}
}
<#-- @formatter:on -->
