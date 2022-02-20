<#-- @formatter:off -->
{
	if(${input$entity} instanceof ServerPlayer _ent) {
		BlockPos _bpos = new BlockPos((int)${input$x},(int)${input$y},(int)${input$z});
		((ServerPlayer) _ent).openMenu(new ExtendedScreenHandlerFactory() {
            BlockPos _pos = new BlockPos((int)${input$x},(int)${input$y},(int)${input$z});
        	@Override
        	public void writeScreenOpeningData(ServerPlayer player, FriendlyByteBuf buf) {
        	    buf.writeBlockPos(_pos);
        	}

        	@Override
        	public Component getDisplayName() {
        	    return new TextComponent("${field$guiname}");
        	}

        	@Override
        	public AbstractContainerMenu createMenu(int syncId, Inventory inv, Player player) {
        		return new ${(field$guiname)}Menu(syncId, inv, new FriendlyByteBuf(Unpooled.buffer()).writeBlockPos(_pos));
        	}
        });
	}
}
<#-- @formatter:on -->