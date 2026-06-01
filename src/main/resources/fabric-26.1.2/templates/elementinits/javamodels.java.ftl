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
 *	MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

<#assign specialentities = w.getGElementsOfType("specialentity")>
@Environment(EnvType.CLIENT) public class ${JavaModName}Models {
	<#list specialentities as entity>
	public static final ModelLayerLocation ${entity.getModElement().getRegistryNameUpper()}_LAYER_LOCATION =
			new ModelLayerLocation(Identifier.parse("${modid}:<#if entity.isBoatChestVariant()>chest_</#if>boat/${entity.getModElement().getRegistryName()}"), "main");
	</#list>

	public static void clientLoad() {
		<#list javamodels as model>
		ModelLayerRegistry.registerModelLayer(${model.getReadableName()}.LAYER_LOCATION, ${model.getReadableName()}::createBodyLayer);
		</#list>
		<#list specialentities as entity>
		ModelLayerRegistry.registerModelLayer(${entity.getModElement().getRegistryNameUpper()}_LAYER_LOCATION, <#if entity.isAnyRaft()>Raft<#else>Boat</#if>Model::create${entity.entityType}Model);
		</#list>
	}
}
<#-- @formatter:on -->