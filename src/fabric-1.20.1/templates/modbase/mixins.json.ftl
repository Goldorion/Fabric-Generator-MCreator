{
  "required": true,
  "minVersion": "0.8",
  "package": "${package}.mixins",
  "compatibilityLevel": "JAVA_17",
  "mixins": [
	"${settings.getJavaModName()}RepairItemRecipeMixin"<#if w.getGElementsOfType('tool')?filter(e -> e.toolType = 'Fishing rod')?size != 0>,
	"${settings.getJavaModName()}FishingHookMixin",
	"${settings.getJavaModName()}FishingHookRendererMixin",
	"EntityMixin"
	</#if>
  ],
  "injectors": {
	"defaultRequire": 1
  }
}