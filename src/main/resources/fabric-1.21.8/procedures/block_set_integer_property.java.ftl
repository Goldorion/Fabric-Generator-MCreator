<#include "mcelements.ftl">
{
	int _value = ${opt.toInt(input$value)};
	BlockPos _pos = ${toBlockPos(input$x,input$y,input$z)};
	BlockState _bs${cbi} = world.getBlockState(_pos);
	if (_bs${cbi}.getBlock().getStateDefinition().getProperty(${input$property}) instanceof IntegerProperty _integerProp && _integerProp.getPossibleValues().contains(_value))
		world.setBlock(_pos, _bs${cbi}.setValue(_integerProp, _value), 3);
}