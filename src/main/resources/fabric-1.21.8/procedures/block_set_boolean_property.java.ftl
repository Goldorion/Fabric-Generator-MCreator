<#include "mcelements.ftl">
{
	BlockPos _pos = ${toBlockPos(input$x,input$y,input$z)};
	BlockState _bs${cbi} =  world.getBlockState(_pos);
	if (_bs${cbi}.getBlock().getStateDefinition().getProperty(${input$property}) instanceof BooleanProperty _booleanProp)
		world.setBlock(_pos, _bs${cbi}.setValue(_booleanProp, ${input$value}), 3);
}