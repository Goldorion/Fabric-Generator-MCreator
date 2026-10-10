<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2026, Pylo, opensource contributors
 # Copyright (C) 2020-2026, Goldorion, opensource contributors
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
 *    MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

<#assign decoratedBiomes = biomes?filter(e -> e.hasVines() || e.hasFruits())>

public class ${JavaModName}BiomeDecorators {

	public static void load() {
            <#list decoratedBiomes as biome>
                <#assign biomeME = biome.getModElement()>
                <#if biome.hasFruits()>
                    register("${biomeME.getRegistryName()}_tree_fruit_decorator", ${biomeME.getName()}FruitDecorator.DECORATOR_TYPE);
                </#if>
                <#if biome.hasVines()>
                    register("${biomeME.getRegistryName()}_tree_leave_decorator", ${biomeME.getName()}LeaveDecorator.DECORATOR_TYPE);
                    register("${biomeME.getRegistryName()}_tree_trunk_decorator", ${biomeME.getName()}TrunkDecorator.DECORATOR_TYPE);
                </#if>
            </#list>
	}

	private static void register(String registryname, TreeDecoratorType<?> treeDecoratorType) {
		Registry.register(BuiltInRegistries.TREE_DECORATOR_TYPE, Identifier.fromNamespaceAndPath(${JavaModName}.MODID, registryname), treeDecoratorType);
	}
}
<#-- @formatter:on -->