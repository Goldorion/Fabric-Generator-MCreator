<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2025, Pylo, opensource contributors
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
/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

public class ${JavaModName}BlockEntities {

	<#list blockentities as blockentity>
	public static BlockEntityType<${blockentity.getModElement().getName()}BlockEntity> ${blockentity.getModElement().getRegistryNameUpper()};
	</#list>

	public static void load() {
		<#list blockentities as blockentity>
		${blockentity.getModElement().getRegistryNameUpper()} =
			register("${blockentity.getModElement().getRegistryName()}", ${JavaModName}Blocks.${blockentity.getModElement().getRegistryNameUpper()},
				${blockentity.getModElement().getName()}BlockEntity::new);
		</#list>
	}

	// Start of user code block custom block entities
	// End of user code block custom block entities

	private static <T extends BlockEntity> BlockEntityType<T> register(String registryname, Block block, FabricBlockEntityTypeBuilder.Factory<? extends T> supplier) {
		return Registry.register(BuiltInRegistries.BLOCK_ENTITY_TYPE, ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, registryname), FabricBlockEntityTypeBuilder.<T>create(supplier, block).build());
	}
}
<#-- @formatter:on -->