<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2020-2021, Goldorion, opensource contributors
 #
 # Fabric-Generator-MCreator is free software: you can redistribute it and/or modify
 # it under the terms of the GNU Lesser General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.

 # Fabric-Generator-MCreator is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 # GNU Lesser General Public License for more details.
 #
 # You should have received a copy of the GNU Lesser General Public License
 # along with Fabric-Generator-MCreator.  If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->

/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

public class ${JavaModName}MobEffects {

	<#list potioneffects as effect>
		public static MobEffect ${effect.getModElement().getRegistryNameUpper()};
	</#list>

	public static void load() {
		<#list potioneffects as effect>
			${effect.getModElement().getRegistryNameUpper()} = Registry.register(Registry.MOB_EFFECT, new ResourceLocation(${JavaModName}.MODID, "${effect.getModElement().getRegistryName()}"), new ${effect.getModElement().getName()}MobEffect());
		</#list>
	}
}

<#-- @formatter:on -->