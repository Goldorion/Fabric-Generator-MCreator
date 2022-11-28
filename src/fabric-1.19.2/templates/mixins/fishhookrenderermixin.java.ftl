<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2020-2022, Goldorion, opensource contributors
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
package ${package}.mixins;

import ${package}.mixins.EntityMixin;
import org.spongepowered.asm.mixin.injection.Constant;

@Mixin(FishingHookRenderer.class)
public abstract class ${JavaModName}FishingHookRendererMixin {
	double offset = 0.35;
	float offset2 = 0.525f;

	@Inject(method = "render", at = @At("HEAD"))
	public void render(FishingHook fishingHook, float f, float g, PoseStack poseStack, MultiBufferSource multiBufferSource, int i, CallbackInfo ci) {
		Player playerino = fishingHook.getPlayerOwner();
		ItemStack itemStack = playerino.getMainHandItem();
		ItemStack itemStack2 = playerino.getOffhandItem();
		<#list tools as tool>
			<#if tool.toolType == "Fishing rod">
				if (itemStack.is(${JavaModName}Items.${tool.getModElement().getRegistryNameUpper()})) {
					offset = -0.35;
					offset2 = -0.525f;
				} else if (itemStack.is(Items.FISHING_ROD)) {
					offset = 0.35;
					offset2 = 0.525f;
				} else if (itemStack2.is(${JavaModName}Items.${tool.getModElement().getRegistryNameUpper()})) {
					offset = 0.35;
					offset2 = 0.525f;
				}
			</#if>
		</#list>
	}

	@ModifyConstant(method = "render", constant = @Constant(doubleValue = 0.35))
	private double injected(double x) {
		return offset;
	}

	@ModifyConstant(method = "render", constant = @Constant(floatValue = 0.525f))
	private float injected(float x) {
		return offset2;
	}
}
<#-- @formatter:on -->
