<#include "mcelements.ftl">
<#include "mcitems.ftl">
(${mappedMCItemToItemStackCode(input$a, 1)}.is(TagKey.create(Registries.ITEM, ${toResourceLocation(input$b)})))