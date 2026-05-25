<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2025, Pylo, opensource contributors
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

package ${package}.client.dimension;

<@javacompress>
@Environment(EnvType.CLIENT) public class ${name}DimensionEffects {

	public static void clientLoad() {
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
			DimensionRenderingRegistry.registerDimensionEffects(Identifier.parse("${modid}:${registryname}"), customEffect);
	}
}
</@javacompress>
<#-- @formatter:on -->