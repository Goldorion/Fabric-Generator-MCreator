<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2020-2023, Goldorion, opensource contributors
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

public class ${JavaModName}Enchantments {

	<#list enchantments as enchantment>
		public static Enchantment ${enchantment.getModElement().getRegistryNameUpper()};
	</#list>

	public static void load() {
			<#list enchantments as enchantment>
				${enchantment.getModElement().getRegistryNameUpper()} = Registry.register(BuiltInRegistries.ENCHANTMENT,
					new ResourceLocation(${JavaModName}.MODID, "${enchantment.getModElement().getRegistryName()}"),
					new ${enchantment.getModElement().getName()}Enchantment());
			</#list>
	}

}
<#-- @formatter:on -->