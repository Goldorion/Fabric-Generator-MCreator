<#-- @formatter:off -->
{
	Entity _ent = ${input$entity};
	if(_ent instanceof ServerPlayerEntity) {
		((ServerPlayerEntity) _ent).openHandledScreen(new ExtendedScreenHandlerFactory() {
		    BlockPos _pos = new BlockPos((int)${input$x},(int)${input$y},(int)${input$z});
			@Override
			public void writeScreenOpeningData(ServerPlayerEntity player, PacketByteBuf buf) {
				buf.writeBlockPos(_pos);
			}

			@Override
			public Text getDisplayName() {
				return new LiteralText("${field$guiname}");
			}

			@Override
			public ScreenHandler createMenu(int syncId, PlayerInventory inv, PlayerEntity player) {
				return new ${(field$guiname)}Gui.GuiContainerMod(syncId, inv, new PacketByteBuf(Unpooled.buffer()).writeBlockPos(_pos));
			}
		});
	}
}
<#-- @formatter:on -->