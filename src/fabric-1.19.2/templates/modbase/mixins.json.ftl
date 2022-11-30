{
  "required": true,
  "minVersion": "0.8",
  "package": "${package}.mixins",
  "compatibilityLevel": "JAVA_17",
  "mixins": [
	"EntityMixin",
	"${settings.getJavaModName()}FishingHookMixin",
	"${settings.getJavaModName()}FishingHookRendererMixin"
  ],
  "injectors": {
	"defaultRequire": 1
  }
}