<#--
This file is part of MCreatorFabricGenerator.

MCreatorFabricGenerator is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

MCreatorFabricGenerator is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with MCreatorFabricGenerator.  If not, see <https://www.gnu.org/licenses/>.
-->

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
