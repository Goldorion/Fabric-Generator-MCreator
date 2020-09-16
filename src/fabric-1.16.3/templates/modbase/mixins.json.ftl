{
  "required": true,
  "package": "${package}.mixin",
  "compatibilityLevel": "JAVA_8",
  "mixins": [
    "SetBaseBiomesLayerAccessor",
    "BuiltinBiomesAccessor",
    "VanillaLayeredBiomeSourceAccessor"
  ],
  "injectors": {
    "defaultRequire": 1
  }
}