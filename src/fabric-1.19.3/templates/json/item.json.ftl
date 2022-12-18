{
    "parent": "item/generated",
    "textures": {
        <#if var_item?? && var_item=="helmet">
            "layer0": "${modid}:item/${data.textureHelmet}"
        <#elseif var_item?? && var_item=="body">
            "layer0": "${modid}:item/${data.textureBody}"
        <#elseif var_item?? && var_item=="leggings">
            "layer0": "${modid}:item/${data.textureLeggings}"
        <#elseif var_item?? && var_item=="boots">
            "layer0": "${modid}:item/${data.textureBoots}"
        <#else>
            "layer0": "${modid}:item/${data.texture}"
        </#if>
    }
}