private static int getAmountInGUISlot(Entity entity, int sltid) {
	<#if types.guis?has_content>
	if(entity instanceof Player player && player.containerMenu instanceof ${JavaModName}Menus.MenuAccessor menuAccessor) {
		ItemStack stack = menuAccessor.getSlots().get(sltid).getItem();
		if(stack != null)
			return stack.getCount();
	}
	</#if>
	return 0;
}