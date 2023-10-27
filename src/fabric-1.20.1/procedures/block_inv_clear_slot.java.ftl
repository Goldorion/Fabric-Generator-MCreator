<#include "mcelements.ftl">
<#-- @formatter:off -->
BlockEntity _ent${customBlockIndex} = world.getBlockEntity(${toBlockPos(input$x,input$y,input$z)});
if (_ent${customBlockIndex} != null) {
	((RandomizableContainerBlockEntity) _ent${customBlockIndex}).removeItemNoUpdate(${opt.toInt(input$slotid)});
}
<#-- @formatter:on -->