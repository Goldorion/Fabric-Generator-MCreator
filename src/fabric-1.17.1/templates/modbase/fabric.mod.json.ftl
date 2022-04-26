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
    ]
  },

  "depends": {
    "fabricloader": ">=0.12.12",
    "fabric": "*",
    "minecraft": "1.17.x",
    "java": ">=16"
  },
  "accessWidener" : "modid.accesswidener"
}
<#-- @formatter:on -->
