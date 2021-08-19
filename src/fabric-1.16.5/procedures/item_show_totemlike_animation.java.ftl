<#include "mcitems.ftl">
if(world.isClient()) {
    MinecraftClient.getInstance().gameRenderer.showFloatingItem(${mappedMCItemToItemStackCode(input$item, 1)});
}