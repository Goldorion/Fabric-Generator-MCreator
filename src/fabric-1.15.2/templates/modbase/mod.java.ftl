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

import ${package}.item;
import net.fabricmc.fabric.api.biomes.v1.OverworldBiomes;
import net.fabricmc.fabric.api.biomes.v1.OverworldClimate;

public class ${JavaModName} implements ModInitializer {

  <#list sounds as sound>
	public static final Identifier ${sound} = new Identifier("${modid}:${sound}");
  public static SoundEvent ${sound}Event = new SoundEvent(${sound});
	</#list>

<#list w.getElementsOfType("ITEM") as item>
	public static final Item ${item} = new ${item}();
</#list>

<#list w.getElementsOfType("PLANT") as plant>
  public static final PlantBlock ${plant}Plant = new ${plant}();
</#list>

<#list w.getElementsOfType("ARMOR") as armor>
<#assign ge = armor.getGeneratableElement()>
	public static final Item ${armor}_HELMET = new ${armor}ArmorItem(${armor}Material.${armor}, EquipmentSlot.HEAD, (new Item.Settings().group(${ge.creativeTab})));
	public static final Item ${armor}_CHESTPLATE = new ${armor}ArmorItem(${armor}Material.${armor}, EquipmentSlot.CHEST, (new Item.Settings().group(${ge.creativeTab})));
	public static final Item ${armor}_LEGGINGS = new ${armor}ArmorItem(${armor}Material.${armor}, EquipmentSlot.LEGS, (new Item.Settings().group(${ge.creativeTab})));
	public static final Item ${armor}_BOOTS = new ${armor}ArmorItem(${armor}Material.${armor}, EquipmentSlot.FEET, (new Item.Settings().group(${ge.creativeTab})));
</#list>

<#list w.getElementsOfType("FOOD") as food>
	public static final Item ${food} = new ${food}();
</#list>

<#list w.getElementsOfType("BLOCK") as block>
    public static final ${block} ${block} = new ${block}();
    public static BlockEntityType<${block}.${block}BlockEntity> ${block}BE;
</#list>

	@Override
	public void onInitialize() {

  <#list sounds as sound>
  	Registry.register(Registry.SOUND_EVENT, ${JavaModName}.${sound}, ${JavaModName}.${sound}Event);
  </#list>

<#list w.getElementsOfType("ITEM") as item>
		Registry.register(Registry.ITEM, new Identifier("${modid}", "${item.getRegistryName()}"), ${item});
</#list>

<#list w.getElementsOfType("ARMOR") as armor>
	Registry.register(Registry.ITEM,new Identifier("${modid}","${armor.getRegistryName()}_helmet"), ${armor}_HELMET);
	Registry.register(Registry.ITEM,new Identifier("${modid}","${armor.getRegistryName()}_chestplate"), ${armor}_CHESTPLATE);
	Registry.register(Registry.ITEM,new Identifier("${modid}","${armor.getRegistryName()}_leggings"), ${armor}_LEGGINGS);
	Registry.register(Registry.ITEM,new Identifier("${modid}","${armor.getRegistryName()}_boots"), ${armor}_BOOTS);
</#list>

${JavaModName}Biomes.registerBiomes();

<#list w.getElementsOfType("BIOME") as biome>
  OverworldBiomes.addContinentalBiome(${JavaModName}Biomes.${biome?upper_case},OverworldClimate.TEMPERATE,${biome}.WEIGHT);
</#list>

<#list w.getElementsOfType("PLANT") as plant>
<#assign ge = plant.getGeneratableElement()>
  Registry.register(Registry.BLOCK,new Identifier("${modid}","${plant.getRegistryName()}"),${plant}Plant);
  Registry.register(Registry.ITEM,new Identifier("${modid}","${plant.getRegistryName()}"),new BlockItem(${plant}Plant, new Item.Settings().group(${ge.creativeTab})));
</#list>

<#list w.getElementsOfType("FOOD") as food>
		Registry.register(Registry.ITEM, new Identifier("${modid}", "${food.getRegistryName()}"), ${food});
</#list>

<#list w.getElementsOfType("TOOL") as tool>
		Registry.register(Registry.ITEM, new Identifier("${modid}", "${tool.getRegistryName()}"), new ${tool}Item(new ${tool}Material()));
</#list>

<#list w.getElementsOfType("BLOCK") as block>
<#assign ge = block.getGeneratableElement()>
    if(${block}.hasBE) ${block}BE = Registry.register(Registry.BLOCK_ENTITY_TYPE,new Identifier("${modid}","${block?lower_case}be"),BlockEntityType.Builder.create(${block}.${block}BlockEntity::new).build(null));
		Registry.register(Registry.BLOCK, new Identifier("${modid}", "${block.getRegistryName()}"), ${block});
    Registry.BIOME.forEach(this.${block}::genBlock);
    RegistryEntryAddedCallback.event(Registry.BIOME).register((i, identifier, biome) -> { this.${block}.genBlock(biome); });
		Registry.register(Registry.ITEM, new Identifier("${modid}", "${block.getRegistryName()}"), new BlockItem(${block}, new Item.Settings().group(${ge.creativeTab})));
</#list>

<#list w.getElementsOfType("FUEL") as fuel>
    ${fuel}Fuel.initialize();
</#list>
	}
}
<#-- @formatter:on -->
