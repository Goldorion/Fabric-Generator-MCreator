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
 * MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

public class ${JavaModName}Fluids {

	<#list fluids as fluid>
	public static FlowingFluid ${fluid.getModElement().getRegistryNameUpper()};
	public static FlowingFluid FLOWING_${fluid.getModElement().getRegistryNameUpper()};
	</#list>

	public static void load() {
		<#list fluids as fluid>
		${fluid.getModElement().getRegistryNameUpper()} =
			register("${fluid.getModElement().getRegistryName()}", ${fluid.getModElement().getName()}Fluid.Source::new);
		FLOWING_${fluid.getModElement().getRegistryNameUpper()} =
			register("flowing_${fluid.getModElement().getRegistryName()}", ${fluid.getModElement().getName()}Fluid.Flowing::new);
		</#list>
	}

	@Environment(EnvType.CLIENT) public static void clientLoad() {
		<#list fluids as fluid>
		${fluid.getModElement().getName()}Fluid.clientLoad();
		</#list>
	}

	private static <F extends Fluid> F register(String registryname, Supplier<F> element) {
		return (F) Registry.register(BuiltInRegistries.FLUID, ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, registryname), element.get());
	}
}
<#-- @formatter:on -->