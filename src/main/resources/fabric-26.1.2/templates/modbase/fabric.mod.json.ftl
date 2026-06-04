<#-- @formatter:off -->
<#assign hasDeps = settings.getDependencies()?has_content>
<#assign hasDependants = settings.getDependants()?has_content>
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
  "environment": "<#if settings.isServerSideOnly()>server<#else>*</#if>",
  "entrypoints": {
	"main": [
	  "${package}.${JavaModName}"
	],
	"client":[
	  "${package}.${JavaModName}Client"
	]
  },
  "mixins": [
	"${modid}.mixins.json"
  ],
  "accessWidener": "META-INF/${modid}.classtweaker",
  "depends": {
	"fabricloader": ">=0.19.3",
	"minecraft": "~${generator.getGeneratorMinecraftVersion()}",
	"java": ">=25",
	"fabric-api": "*"<#if settings.getRequiredMods()?has_content>,</#if>
	<#list settings.getRequiredMods() as e>
	"${e}": "${(settings.getVersionRange(e) == '[0,)')?then('*', settings.getVersionRange(e))}"<#sep>,
	</#list>
  }<#if hasDeps || hasDependants>,
  "suggests": {
	<#list settings.getDependencies() as e>
	"${e}": "${(settings.getVersionRange(e) == '[0,)')?then('*', settings.getVersionRange(e))}"<#sep>,
	</#list><#if hasDeps && hasDependants>,</#if>
	<#list settings.getDependants() as e>
	"${e}": "*"<#sep>,
	</#list>
  }
  </#if>
}
<#-- @formatter:on -->