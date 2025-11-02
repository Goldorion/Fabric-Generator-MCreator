<#assign mixins = []>
<#assign client_mixins = []>
<#if w.getGElementsOfType('biome')?filter(e -> e.spawnBiome || e.spawnInCaves || e.spawnBiomeNether)?size != 0>
	<#assign mixins = mixins + ['NoiseGeneratorSettingsMixin']>
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
<#assign mixins = mixins + ['LivingEntityMixin']>
<#assign mixins = mixins + ['PlayerMixin']>
<#assign mixins = mixins + ['ItemStackMixin']>
<#assign mixins = mixins + ['BlockItemMixin']>
<#assign mixins = mixins + ['BoneMealItemMixin']>
<#assign mixins = mixins + ['CommandsMixin']>
<#assign mixins = mixins + ['ExperienceOrbMixin']>
{
  "required": true,
  "package": "${package}.mixin",
  "compatibilityLevel": "JAVA_21",
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