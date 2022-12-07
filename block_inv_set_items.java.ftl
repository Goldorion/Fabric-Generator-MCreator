BlockEntity _ent${customBlockIndex} = world.getBlockEntity(new BlockPos(${input$x}, ${input$y}, ${input$z}));
ItemStack stack${customBlockIndex} = new ItemStack(${input$item});
stack${customBlockIndex}.setCount(${opt.toInt(input$amount)});
if (_ent${customBlockIndex} != null) {
((RandomizableContainerBlockEntity) _ent${customBlockIndex}).setItem(${opt.toInt(input$slotid)}, stack${customBlockIndex});
}