<#-- @formatter:off -->
{
	Entity _ent = ${input$entity};
	if(_ent instanceof ServerPlayerEntity) {
		_ent.openHandledScreen(new ExtendedScreenHandlerFactory() {
			@Override
			public void writeScreenOpeningData(ServerPlayerEntity player, PacketByteBuf buf) {

			}

			@Override
			public Text getDisplayName() {
				return new LiteralText("${field$guiname}");
			}

			@Override
			public ScreenHandler createMenu(int syncId, PlayerInventory inv, PlayerEntity player) {
				return new ${(field$guiname)}Gui.GuiContainerMod(syncId, inv, new PacketByteBuf(Unpooled.buffer()).writeBlockPos(new BlockPos((int)${input$x},(int)${input$y},(int)${input$z})));
			}
		}
	}
}
<#-- @formatter:on -->}