<#include "mcelements.ftl">
<@head>if (world instanceof Level _level) {</@head>
	BlockPos _bp${cbi} = ${toBlockPos(input$x,input$y,input$z)};
	if (BoneMealItem.growCrop(new ItemStack(Items.BONE_MEAL), _level, _bp${cbi}) || BoneMealItem.growWaterPlant(new ItemStack(Items.BONE_MEAL), _level, _bp${cbi}, null)) {
		if (!_level.isClientSide())
			_level.levelEvent(2005, _bp${cbi}, 0);
	}
<@tail>}</@tail>