<#-- @formatter:off -->
{
  "schemaVersion": 1,
  "id": "${settings.getModID()}",
  "version": "${settings.getVersion()}",

  "name": "${settings.getModName()}",
<#if settings.getDescription()?has_content>
  "description": "${settings.getDescription()}",
</#if>
<#if settings.getAuthor()?has_content>
  "authors": [
	"${settings.getAuthor()}"
  ],
</#if>
  "contact": {
	"homepage": "${settings.getWebsiteURL()}",
	"sources": ""
  },
  "license": "${settings.getLicense()}",
<#if settings.getModPicture()?has_content>
  "icon": "assets/${modid}/icon.png",
</#if>

  "environment": "*",
  "entrypoints": {
	"main": [
	  "${package}.${JavaModName}"
	],
	"client":[
	  "${package}.ClientInit"
	]<#if settings.getMCreatorDependenciesRaw()?seq_contains("terrablender")>,
	"terrablender":[
		"${package}.TerraBlenderInit"
	]</#if>
  },

  "depends": {
	"fabricloader": ">=0.14.11",
	"fabric": "*",
	"minecraft": "~1.19",
	"java": ">=17"
  }<#if w.hasElementsOfBaseType("item")>,
  "mixins": [
	"${settings.getModID()}.mixins.json"
  ]</#if>
}
<#-- @formatter:on -->
