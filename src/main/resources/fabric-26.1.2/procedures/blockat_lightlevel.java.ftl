<#include "mcelements.ftl">
/*@int*/(world.getBlockState(${toBlockPos(input$x,input$y,input$z)}).getLightEmission(${toBlockPos(input$x,input$y,input$z)}))