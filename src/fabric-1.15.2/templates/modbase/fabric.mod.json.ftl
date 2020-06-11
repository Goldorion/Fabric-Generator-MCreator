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

<#if settings.getModPicture()?has_content>
  "icon": "assets/${modid}/icon.png",
</#if>

  "environment": "*",
  "entrypoints": {
    "main": [
      "${package}.${JavaModName}"
    ]
  },

  "depends": {
    "fabricloader": ">=0.8.3",
    "fabric": "*",
    "minecraft": "1.15.x"
  },
  "suggests": {
    "flamingo": "*"
  }
}
<#-- @formatter:on -->