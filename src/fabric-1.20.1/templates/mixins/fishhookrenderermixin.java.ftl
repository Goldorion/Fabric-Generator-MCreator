<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2020-2023, Goldorion, opensource contributors
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
	private int offset;

	@Inject(method = "render", at = @At("HEAD"))
	public void render(FishingHook fishingHook, float f, float g, PoseStack poseStack, MultiBufferSource multiBufferSource, int i, CallbackInfo ci) {
		Player player = fishingHook.getPlayerOwner();
		ItemStack itemStack = player.getMainHandItem();
		offset = player.getMainArm() == HumanoidArm.RIGHT ? 1 : -1;
		if (!(itemStack.getItem() instanceof FishingRodItem)) {
			offset = -offset;
		}
	}

	@ModifyVariable(method = "render", at = @At("STORE"), ordinal = 1)
	private int injected(int x) {
		return offset;
	}
}
<#-- @formatter:on -->
