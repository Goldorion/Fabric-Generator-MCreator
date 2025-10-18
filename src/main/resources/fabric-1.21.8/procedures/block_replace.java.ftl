<#include "mcelements.ftl">
<#include "mcitems.ftl">
<#if field$nbt == "FALSE" && field$state == "FALSE">
world.setBlock(${toBlockPos(input$x,input$y,input$z)}, ${mappedBlockToBlockStateCode(input$block)},3);
<#else>
{
	BlockPos _bp${cbi} = ${toBlockPos(input$x,input$y,input$z)};
	BlockState _bs${cbi} = ${mappedBlockToBlockStateCode(input$block)};

	<#if field$state == "TRUE">
	BlockState _bso = world.getBlockState(_bp${cbi});
	for(Property<?> _propertyOld : _bso.getProperties()) {
		Property _propertyNew = _bs${cbi}.getBlock().getStateDefinition().getProperty(_propertyOld.getName());
		if (_propertyNew != null && _bs${cbi}.getValue(_propertyNew) != null)
			try {
				_bs${cbi} = _bs${cbi}.setValue(_propertyNew, _bso.getValue(_propertyOld));
			} catch (Exception e) {}
	}
	</#if>

	<#if field$nbt == "TRUE">
	BlockEntity _be = world.getBlockEntity(_bp${cbi});
	CompoundTag _bnbt = null;
	if(_be != null) {
		_bnbt = _be.saveWithFullMetadata(world.registryAccess());
		_be.setRemoved();
	}
	</#if>

	world.setBlock(_bp${cbi}, _bs${cbi}, 3);

	<#if field$nbt == "TRUE">
	if(_bnbt != null) {
		_be = world.getBlockEntity(_bp${cbi});
		if(_be != null) {
			try {
				_be.loadWithComponents(TagValueInput.create(ProblemReporter.DISCARDING, world.registryAccess(), _bnbt));
			} catch(Exception ignored) {}
		}
	}
	</#if>
}
</#if>