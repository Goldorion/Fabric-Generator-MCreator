<#-- @formatter:off -->


package ${package}.keybind;

 {

	@OnlyIn(Dist.CLIENT)
	private static KeyBinding key;

	<#if hasProcedure(data.onKeyReleased)>
	private long lastpress = 0;
	</#if>

	public static void initializeClient(){
		${key} = new KeyBinding(
    "key.${registryname}",
    InputUtil.Type.KEYSYM,
    GLFW.GLFW_KEY_${generator.map(data.triggerKey, "keybuttons")},
    "key.categories.${data.keyBindingCategoryKey}"
    );

		KeyBindingHelper.registerKeyBinding(keyBinding);
	}
}

<#-- @formatter:on -->
