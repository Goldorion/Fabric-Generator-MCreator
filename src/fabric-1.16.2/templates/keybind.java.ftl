<#-- @formatter:off -->

<#include "procedures.java.ftl">

package ${package}.client;

import ${package}.${JavaModName};

public class ${name}KeyBinding extends KeyBinding {
	<#if hasProcedure(data.onKeyReleased)>
	private long lastpress = 0;
	</#if>

	public ${name}KeyBinding() {
		super("key.mcreator.${registryname}", GLFW.GLFW_KEY_${generator.map(data.triggerKey, "keybuttons")}, "key.categories.${data.keyBindingCategoryKey}");
	}

	public void keyPressed(PlayerEntity entity) {

		World world = entity.world;
		int x = Math.round(MathHelper.floor(entity.getX()));
		int y = Math.round(MathHelper.floor(entity.getY()));
		int z = Math.round(MathHelper.floor(entity.getZ()));

		<#if hasProcedure(data.onKeyPressed)>
			<@procedureOBJToCode data.onKeyPressed/>
		</#if>
	}

	public void keyReleased(PlayerEntity entity) {

		World world = entity.world;
		int x = Math.round(MathHelper.floor(entity.getX()));
		int y = Math.round(MathHelper.floor(entity.getY()));
		int z = Math.round(MathHelper.floor(entity.getZ()));

		<#if hasProcedure(data.onKeyReleased)>
			<@procedureOBJToCode data.onKeyReleased/>
		</#if>
	}
}

<#-- @formatter:on -->
