if(!world.isClient()) {
    BlockPos _bp = new BlockPos((int)${input$x},(int)${input$y},(int)${input$z});
    BlockEntity _blockEntity = world.getBlockEntityy(_bp);
    BlockState _bs = world.getBlockState(_bp);
    if(_blockEntity!=null)
    _blockEntity.toTag(new CompoundTag()).putDouble(${input$tagName}, ${input$tagValue});
    world.onBlockChanged(_bp, _bs, _bs);
}