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

@Environment(EnvType.CLIENT) public class ${JavaModName}EntityRenderers {

	public static void clientLoad() {
		<#list entities as entity>
			<#if entity.getModElement().getTypeString() == "projectile">
				<#if entity.isCustomModel()>
				EntityRendererRegistry.register(${JavaModName}Entities.${entity.getModElement().getRegistryNameUpper()}, ${entity.getModElement().getName()}Renderer::new);
				<#else>
				EntityRendererRegistry.register(${JavaModName}Entities.${entity.getModElement().getRegistryNameUpper()}, ThrownItemRenderer::new);
				</#if>
			<#elseif entity.getModElement().getTypeString() == "livingentity">
				EntityRendererRegistry.register(${JavaModName}Entities.${entity.getModElement().getRegistryNameUpper()}, ${entity.getModElement().getName()}Renderer::new);
				<#if entity.hasCustomProjectile()>
				EntityRendererRegistry.register(${JavaModName}Entities.${entity.getModElement().getRegistryNameUpper()}_PROJECTILE, ThrownItemRenderer::new);
				</#if>
			<#elseif entity.getModElement().getTypeString() == "specialentity">
				EntityRendererRegistry.register(${JavaModName}Entities.${entity.getModElement().getRegistryNameUpper()},
						context -> new BoatRenderer(context, ${JavaModName}Models.${entity.getModElement().getRegistryNameUpper()}_LAYER_LOCATION));
			</#if>
		</#list>
	}
}
<#-- @formatter:on -->