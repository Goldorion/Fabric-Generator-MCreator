<#assign mixins = ['LivingEntityMixin', 'PlayerMixin', 'ItemStackMixin', 'BlockItemMixin', 'BoneMealItemMixin', 'CommandsMixin', 'ExperienceOrbMixin']>
<#assign client_mixins = []>
<#if w.getGElementsOfType('biome')?filter(e -> e.spawnBiome || e.spawnInCaves || e.spawnBiomeNether)?size != 0>
  <#assign mixins = mixins + ['NoiseGeneratorSettingsMixin', 'BiomeSourcePresetMixin', 'LevelStorageSourceMixin']>
</#if>
<#if w.hasElementsOfBaseType('item')>
	<#assign mixins = mixins + ['RepairItemRecipeMixin']>
	<#assign mixins = mixins + ['ServerPlayerMixin']>
</#if>
<#if w.hasElementsOfType('attribute')>
	<#assign mixins = mixins + ['AttributeSupplierAccessor']>
</#if>
<#if w.hasElementsOfType('armor')>
	<#assign mixins = mixins + ['PiglinAiMixin']>
	<#assign client_mixins = client_mixins + ['EquipmentLayerRendererMixin']>
</#if>
<#if w.getGElementsOfType('livingentity')?filter(e -> e.spawnInDungeons)?size != 0>
	<#assign mixins = mixins + ['MonsterRoomFeatureMixin']>
</#if>
<#if w.getGElementsOfType('tool')?filter(e -> e.toolType.equals('Shears'))?size != 0>
	<#assign mixins = mixins + ['SheepMixin']>
</#if>
{
  "required": true,
  "package": "${package}.mixin",
  "compatibilityLevel": "JAVA_25",
  "refmap": "${modid}.refmap.json",
  "mixins": [
	<#list mixins as mixin>"${mixin}"<#sep>,</#list>
  ],
  "client": [
	<#list client_mixins as mixin>"${mixin}"<#sep>,</#list>
  ],
  "injectors": {
    "defaultRequire": 1
  },
  "minVersion": "0.8.4"
}