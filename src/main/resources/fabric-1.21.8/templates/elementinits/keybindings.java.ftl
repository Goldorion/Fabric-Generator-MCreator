<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2020-2025, Goldorion, opensource contributors
 #
 # Fabric-Generator-MCreator is free software: you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.
 #
 # Fabric-Generator-MCreator is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
 # along with Fabric-Generator-MCreator. If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->
<@javacompress>

<#include "../procedures.java.ftl">

/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

@Environment(EnvType.CLIENT) public class ${JavaModName}KeyMappings {

	<#list keybinds as keybind>
	public static final KeyMapping ${keybind.getModElement().getRegistryNameUpper()} = new KeyMapping(
			"key.${modid}.${keybind.getModElement().getRegistryName()}",
			<#if keybind.triggerKey?starts_with("MOUSE")>
				InputConstants.Type.MOUSE, GLFW.GLFW_${generator.map(keybind.triggerKey, "keybuttons")},
			<#else>
				GLFW.GLFW_KEY_${generator.map(keybind.triggerKey, "keybuttons")},
			</#if>
			"key.categories.${keybind.keyBindingCategoryKey}")
				<#if hasProcedure(keybind.onKeyReleased) || hasProcedure(keybind.onKeyPressed)>
				{
					private boolean isDownOld = false;

					@Override public void setDown(boolean isDown) {
						super.setDown(isDown);

						if (isDownOld != isDown && isDown) {
							<#if hasProcedure(keybind.onKeyPressed)>
								ClientPlayNetworking.send(new ${keybind.getModElement().getName()}Message(0, 0));
								${keybind.getModElement().getName()}Message.pressAction(Minecraft.getInstance().player, 0, 0);
							</#if>

							<#if hasProcedure(keybind.onKeyReleased)>
								${keybind.getModElement().getRegistryNameUpper()}_LASTPRESS = System.currentTimeMillis();
							</#if>
						}
						<#if hasProcedure(keybind.onKeyReleased)>
						else if (isDownOld != isDown && !isDown) {
							int dt = (int) (System.currentTimeMillis() - ${keybind.getModElement().getRegistryNameUpper()}_LASTPRESS);
							ClientPlayNetworking.send(new ${keybind.getModElement().getName()}Message(1, dt));
							${keybind.getModElement().getName()}Message.pressAction(Minecraft.getInstance().player, 1, dt);
						}
						</#if>

						isDownOld = isDown;
					}
				}
				</#if>;
	</#list>

	<#list keybinds as keybind>
		<#if hasProcedure(keybind.onKeyReleased)>
		private static long ${keybind.getModElement().getRegistryNameUpper()}_LASTPRESS = 0;
		</#if>
	</#list>

	public static void clientLoad() {
		<#list keybinds as keybind>
			KeyBindingHelper.registerKeyBinding(${keybind.getModElement().getRegistryNameUpper()});
		</#list>

		ClientTickEvents.END_CLIENT_TICK.register((client) -> {
			if (client.screen == null) {
			<#list keybinds as keybind>
				<#if hasProcedure(keybind.onKeyPressed) || hasProcedure(keybind.onKeyReleased)>
					${keybind.getModElement().getRegistryNameUpper()}.consumeClick();
				</#if>
			</#list>
			}
		});
	}
}
</@javacompress>
<#-- @formatter:on -->