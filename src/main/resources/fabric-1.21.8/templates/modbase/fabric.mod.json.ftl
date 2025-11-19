<#-- @formatter:off -->
{
  "schemaVersion": 1,
  "id": "${settings.getModID()}",
  "version": "${settings.getCleanVersion()}",
  "name": "${JavaConventions.escapeStringForJava(settings.getModName())}",
<#if settings.getDescription()?has_content>
  "description": "${JavaConventions.escapeStringForJava(settings.getDescription())}",
</#if>
<#if settings.getAuthor()?has_content>
  "authors": [
	"${JavaConventions.escapeStringForJava(settings.getAuthor())}"
  ],
</#if>
<#if settings.getWebsiteURL()?has_content>
  "contact": {
	"homepage": "${JavaConventions.escapeStringForJava(settings.getWebsiteURL())}",
	"sources": ""
  },
</#if>
  "license": "${JavaConventions.escapeStringForJava(settings.getLicense())}",
<#if settings.getModPicture()?has_content>
  "icon": "logo.png",
</#if>
  "environment": "*",
  "entrypoints": {
	"main": [
	  "${package}.${JavaModName}"
	],
	"client":[
	  "${package}.${JavaModName}Client"
	]
  },
  <#if (w.getGElementsOfType('biome')?filter(e -> e.spawnBiome || e.spawnInCaves || e.spawnBiomeNether || e.hasVines() || e.hasFruits())?size != 0) || w.hasElementsOfType('feature')>
  "accessWidener" : "META-INF/${modid}.accesswidener",
  </#if>
  "mixins": [
	"${modid}.mixins.json"
  ],
  "depends": {
	"fabricloader": ">=0.17.2",
	"minecraft": "~${generator.getGeneratorMinecraftVersion()}",
	"java": ">=21",
	"fabric-api": "*"
  }
}
<#-- @formatter:on -->