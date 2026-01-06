<#--
 # This file is part of Fabric-Generator-MCreator.
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

<#assign specialentities = w.getGElementsOfType("specialentity")>
@Environment(EnvType.CLIENT) public class ${JavaModName}Models {
	<#list specialentities as entity>
	public static final ModelLayerLocation ${entity.getModElement().getRegistryNameUpper()}_LAYER_LOCATION =
			new ModelLayerLocation(ResourceLocation.parse("${modid}:<#if entity.entityType == "Boat">boat<#else>chest_boat</#if>/${entity.getModElement().getRegistryName()}"), "main");
	</#list>

	public static void clientLoad() {
		<#list javamodels as model>
		EntityModelLayerRegistry.registerModelLayer(${model.getReadableName()}.LAYER_LOCATION, ${model.getReadableName()}::createBodyLayer);
		</#list>
		<#list specialentities as entity>
		EntityModelLayerRegistry.registerModelLayer(${entity.getModElement().getRegistryNameUpper()}_LAYER_LOCATION, BoatModel::create${entity.entityType}Model);
		</#list>
	}
}
<#-- @formatter:on -->