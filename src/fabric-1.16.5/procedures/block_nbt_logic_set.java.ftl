if(!world.isClient()) {
    BlockPos _bp = new BlockPos((int)${input$x},(int)${input$y},(int)${input$z});
    BlockEntity _blockEntity = world.getBlockEntity(_bp);
    BlockState _bs = world.getBlockState(_bp);
    if(_blockEntity!=null)
    _blockEntity.toInitialChunkDataNbt().putDouble(${input$tagName}, ${input$tagValue});
    world.onBlockChanged(_bp, _bs, _bs);
}
