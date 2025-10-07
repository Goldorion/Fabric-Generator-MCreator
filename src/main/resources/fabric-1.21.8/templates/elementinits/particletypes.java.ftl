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

public class ${JavaModName}ParticleTypes {

	<#list particles as particle>
	public static SimpleParticleType ${particle.getModElement().getRegistryNameUpper()};
	</#list>

	public static void load() {
		<#list particles as particle>
		register("${particle.getModElement().getRegistryName()}", FabricParticleTypes.simple(<#if particle.alwaysShow>true</#if>));
		</#list>
	}

	private static SimpleParticleType register(String registryname, SimpleParticleType element) {
		return Registry.register(BuiltInRegistries.PARTICLE_TYPE, ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, registryname), element);
	}
}
<#-- @formatter:on -->