(new Object(){
    public String getValue(BlockPos pos, String tag){
        BlockEntity be = world.getBlockEntity(pos);
        if(be == null) {
            return "";
        }
        return be.toInitialChunkDataNbt().getString(tag);
    }
}.getValue(new BlockPos((int)${input$x},(int)${input$y},(int)${input$z}), ${input$tagName}))