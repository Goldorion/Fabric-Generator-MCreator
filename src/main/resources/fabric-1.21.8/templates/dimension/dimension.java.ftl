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
<#include "../mcitems.ftl">
<#include "../procedures.java.ftl">

package ${package}.world.dimension;

<@javacompress>
public class ${name}Dimension {

	<#if data.hasEffectsOrDimensionTriggers()>
		public static void load() {
			<#if data.useCustomEffects>
			DimensionSpecialEffects customEffect = new DimensionSpecialEffects(
				DimensionSpecialEffects.SkyType.${data.skyType?replace("NORMAL", "OVERWORLD")},
				false,
				false
			) {
				@Override public Vec3 getBrightnessDependentFogColor(Vec3 color, float sunHeight) {
					<#if data.airColor?has_content>
						return new Vec3(${data.airColor.getRed()/255},${data.airColor.getGreen()/255},${data.airColor.getBlue()/255})
					<#else>
						return color
					</#if>
					<#if data.sunHeightAffectsFog>
						.multiply(sunHeight * 0.94 + 0.06, sunHeight * 0.94 + 0.06, sunHeight * 0.91 + 0.09)
					</#if>;
				}

				@Override public boolean isFoggyAt(int x, int y) {
					return ${data.hasFog};
				}
			};

			DimensionRenderingRegistry.registerDimensionEffects(ResourceLocation.parse("${modid}:${registryname}"), customEffect);
			</#if>

			<#if hasProcedure(data.onPlayerLeavesDimension) || hasProcedure(data.onPlayerEntersDimension)>
				ServerEntityWorldChangeEvents.AFTER_PLAYER_CHANGE_WORLD.register((entity, origin, destination) -> {
					Level world = entity.level();
					double x = entity.getX();
					double y = entity.getY();
					double z = entity.getZ();
					if (origin.dimension() == ResourceKey.create(Registries.DIMENSION, ResourceLocation.parse("${modid}:${registryname}"))) {
						<@procedureOBJToCode data.onPlayerLeavesDimension/>
					}
					if (destination.dimension() == ResourceKey.create(Registries.DIMENSION, ResourceLocation.parse("${modid}:${registryname}"))) {
						<@procedureOBJToCode data.onPlayerEntersDimension/>
					}
				});
			</#if>
		}
	</#if>
}
</@javacompress>
<#-- @formatter:on -->