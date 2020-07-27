<#include "mcitems.ftl">
if(!world.getWorld().isClient()) {
	ItemEntity entityToSpawn=new ItemEntity(world.getWorld(), ${input$x}, ${input$y}, ${input$z}, new ItemStack(${mappedMCItemToItemStackCode(input$block, 1)}, 1));
	entityToSpawn.setPickupDelay(10);
	world.addEntity(entityToSpawn);
}
