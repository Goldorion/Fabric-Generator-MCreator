<#include "mcitems.ftl">
/*@int*/(world instanceof Level _levelFV${cbi} ? _levelFV${cbi}.fuelValues().burnDuration(${mappedMCItemToItemStackCode(input$item, 1)}) : 0)