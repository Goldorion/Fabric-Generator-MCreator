<#-- @formatter:off -->
<#if data.itemTexture?has_content>
{
  "parent": "item/generated",
  "textures": {
	"layer0": "${modid}:item/${data.itemTexture}"
  }
}
<#else>
{
	"parent": "${modid}:block/${registryname}_inventory"
}
</#if>
<#-- @formatter:on -->