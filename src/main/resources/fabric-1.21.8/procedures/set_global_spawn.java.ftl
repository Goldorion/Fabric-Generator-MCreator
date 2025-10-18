<#include "mcelements.ftl">
<@head>if (world.getLevelData() instanceof WritableLevelData _levelData) {</@head>
	_levelData.setSpawn(${toBlockPos(input$x,input$y,input$z)}, 0);
<@tail>}</@tail>