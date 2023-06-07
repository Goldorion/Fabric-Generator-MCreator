{
  "required": true,
  "minVersion": "0.8",
  "package": "${package}.mixins",
  "compatibilityLevel": "JAVA_17",
  "mixins": [
	"${settings.getJavaModName()}RepairItemRecipeMixin"<#if w.hasToolsOfType("Fishing rod")>,
	"${settings.getJavaModName()}FishingHookMixin",
	"${settings.getJavaModName()}FishingHookRendererMixin",
	"EntityMixin"
	</#if>
  ],
  "injectors": {
	"defaultRequire": 1
  }
}