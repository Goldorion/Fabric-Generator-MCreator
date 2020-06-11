<#-- @formatter:off -->
{
  "replace": false,
  "values": [
<#list w.getElementsOfType("TOOL") as tool>
<#assign ge = tool.getGeneratableElement()>
<#if ge.toolType == "Pickaxe">
    "${tool}:${tool.getRegistryName()}"<#if tool?has_next>,</#if>
</#if>
</#list>
  ]
}
<#-- @formatter:on -->