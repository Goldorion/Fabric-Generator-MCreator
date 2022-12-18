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
	"parent": "item/generated",
	"textures": {
	  "layer0": "${modid}:block/${data.texture}"
	}
}
</#if>
<#-- @formatter:on -->