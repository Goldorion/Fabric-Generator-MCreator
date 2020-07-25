(new Object(){
    public double getValue(BlockPos pos, String key){
        BlockEntity be = world.getBlockEntity(pos);
        if(be = null) {
            return -1;
        }
        return be.toTag(new CompoundTag()).getDouble(key);
    }
}.getValue(new BlockPos((int)${input$x},(int)${input$y},(int)${input$z}), ${input$tagName}))