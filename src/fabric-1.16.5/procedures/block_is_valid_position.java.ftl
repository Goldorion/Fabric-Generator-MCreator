<#include "mcitems.ftl">
(${mappedBlockToBlockStateCode(input$block)}.canPlaceAt(world, new BlockPos((int) ${input$x}, (int) ${input$y}, (int) ${input$z})))