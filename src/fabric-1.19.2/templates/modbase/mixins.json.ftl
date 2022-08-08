{
  "required": true,
  "minVersion": "0.8",
  "package": "${package}.mixins",
  "compatibilityLevel": "JAVA_17",
  "mixins": [
    "EntityMixin",
    "${settings.getJavaModName()}FishingHookMixin"
  ],
  "injectors": {
    "defaultRequire": 1
  }
}