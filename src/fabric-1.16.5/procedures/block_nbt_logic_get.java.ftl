<#-- @formatter:off -->
(new Object(){
public boolean getValue(World world, BlockPos pos, String tag) {
        BlockEntity be = world.getBlockEntity(pos);
        if(be == null)
            return false;
        return be.toInitialChunkDataNbt().getBoolean(key);
	}
}.getValue(world, new BlockPos((int)${input$x},(int)${input$y},(int)${input$z}), ${input$tagName}))
<#-- @formatter:on -->