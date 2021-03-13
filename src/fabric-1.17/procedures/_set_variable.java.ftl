<#include "mcitems.ftl">
<#if scope == "local">
    <#if type == "NUMBER">
        ${name} =(double)${value};
    <#elseif type == "LOGIC">
        ${name} =(boolean)${value};
    <#elseif type == "STRING">
        ${name} =(String)${value};
    <#elseif type == "ITEMSTACK">
        ${name} = ${mappedMCItemToItemStackCode(value, 1)};
    </#if>
</#if>