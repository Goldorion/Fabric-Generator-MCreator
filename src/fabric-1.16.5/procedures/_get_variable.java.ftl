<#if scope == "local">
    <#if type == "ITEMSTACK">
        /*@ItemStack*/(${name})
    <#else>
        (${name})
    </#if>
</#if>