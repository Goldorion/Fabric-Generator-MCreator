<#include "mcelements.ftl">
<#-- @formatter:off -->
BlockEntity _ent${customBlockIndex} = world.getBlockEntity(${toBlockPos(input$x,input$y,input$z)});
if (_ent${customBlockIndex} != null) {
    ((RandomizableContainerBlockEntity) _ent${customBlockIndex}).removeItem(${opt.toInt(input$slotid)}, ${opt.toInt(input$amount)});
}
<#-- @formatter:on -->