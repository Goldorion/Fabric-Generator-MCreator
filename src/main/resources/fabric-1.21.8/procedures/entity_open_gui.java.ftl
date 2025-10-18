<#include "mcelements.ftl">
<#-- @formatter:off -->
<@head>if(${input$entity} instanceof ServerPlayer _ent) {</@head>
	BlockPos _bpos${cbi} = ${toBlockPos(input$x,input$y,input$z)};
	_ent.openMenu(new MenuProvider() {

		@Override public Component getDisplayName() {
			return Component.literal("${field$guiname}");
		}

		@Override public boolean shouldCloseCurrentScreen() {
			return false;
		}

		@Override public AbstractContainerMenu createMenu(int id, Inventory inventory, Player player) {
			return new ${(field$guiname)}Menu(id, inventory, new FriendlyByteBuf(Unpooled.buffer()).writeBlockPos(_bpos${cbi}));
		}

	});
<@tail>}</@tail>
<#-- @formatter:on -->