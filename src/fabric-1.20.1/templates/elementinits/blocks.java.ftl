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

public class ${JavaModName}Blocks {

	<#list blocks as block>
		<#if block.getModElement().getTypeString() != "dimension">
			public static Block ${block.getModElement().getRegistryNameUpper()};
		</#if>
	</#list>

	public static void load() {
		<#list blocks as block>
			<#if block.getModElement().getTypeString() != "dimension">
				${block.getModElement().getRegistryNameUpper()} = register("${block.getModElement().getRegistryName()}", new ${block.getModElement().getName()}Block());
			</#if>
		</#list>
	}

	public static void clientLoad() {
		<#list blocks as block>
			<#if block.getModElement().getTypeString() == "block" || block.getModElement().getTypeString() == "plant">
					${block.getModElement().getName()}Block.clientInit();
			</#if>
		</#list>
	}

	private static Block register(String registryName, Block block) {
		return Registry.register(BuiltInRegistries.BLOCK, new ResourceLocation(${JavaModName}.MODID, registryName), block);
	}

}

<#-- @formatter:on -->