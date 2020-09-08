if(!world.isClient()) {
    BlockPos _bp = new BlockPos((int)${input$x},(int)${input$y},(int)${input$z});
    BlockEntity _be = world.getBlockEntity(_bp);
    BlockState _bs = world.getBlockState(_bp);
    if(_be != null){
        _be.toTag(new CompoundTag()).putString(${input$tagName}, ${input$tagValue});
    }
    world.onBlockChanged(_bp, _bs, _bs);
}