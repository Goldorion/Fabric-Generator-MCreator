<#include "mcelements.ftl">
<#-- @formatter:off -->
{
	if(${input$entity} instanceof ServerPlayer _ent) {
		_ent.openMenu(new ExtendedScreenHandlerFactory() {
			final BlockPos _pos = ${toBlockPos(input$x,input$y,input$z)};
			@Override
			public void writeScreenOpeningData(ServerPlayer player, FriendlyByteBuf buf) {
				buf.writeBlockPos(_pos);
			}

			@Override
			public Component getDisplayName() {
				return Component.literal("${field$guiname}");
			}

			@Override
			public AbstractContainerMenu createMenu(int syncId, Inventory inv, Player player) {
				return new ${(field$guiname)}Menu(syncId, inv, new FriendlyByteBuf(Unpooled.buffer()).writeBlockPos(_pos));
			}
		});
	}
}
<#-- @formatter:on -->