<#include "mcitems.ftl">
(${mappedBlockToBlockStateCode(input$a)}.getMaterial() == net.minecraft.block.Material.${generator.map(field$material, "materials")})