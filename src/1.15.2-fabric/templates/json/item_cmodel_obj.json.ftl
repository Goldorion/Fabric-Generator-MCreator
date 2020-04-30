{
  "forge_marker": 1,
  "parent": "forge:item/default",
  "loader": "forge:obj",
  "model": "${modid}:models/item/${data.customModelName.split(":")[0]}.obj",
  "textures": {
    "particle": "${modid}:items/${data.texture}"
  <#if data.getTextureMap()?has_content>,
      <#list data.getTextureMap().entrySet() as texture>
          "${texture.getKey()}": "${modid}:blocks/${texture.getValue()}"<#if texture?has_next>,</#if>
      </#list>
  </#if>
  }<#--,
  <#if var_type?? && var_type=="tool">
  "transform": "forge:default-tool"
  <#else>
  "transform": "forge:default-item"
  </#if>-->
}