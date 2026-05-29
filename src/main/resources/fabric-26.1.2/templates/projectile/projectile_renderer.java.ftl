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
package ${package}.client.renderer;

import com.mojang.math.Axis;

@Environment(EnvType.CLIENT)
public class ${name}Renderer extends EntityRenderer<${name}Entity, LivingEntityRenderState> {

	private static final Identifier texture = Identifier.parse("${modid}:textures/entities/${data.customModelTexture}");

	private final ${data.entityModel} model;

	public ${name}Renderer(EntityRendererProvider.Context context) {
		super(context);
		model = new ${data.entityModel}(context.bakeLayer(${data.entityModel}.LAYER_LOCATION));
	}

	@Override public void submit(LivingEntityRenderState state, PoseStack poseStack, SubmitNodeCollector submitNodeCollector, CameraRenderState camera) {
		poseStack.pushPose();
		poseStack.mulPose(Axis.YP.rotationDegrees(state.yRot - 90));
		poseStack.mulPose(Axis.ZP.rotationDegrees(90 + state.xRot));
		model.setupAnim(state);
		submitNodeCollector.submitModel(this.model, state, poseStack, texture, state.lightCoords, OverlayTexture.NO_OVERLAY, state.outlineColor, null);
		poseStack.popPose();

		super.submit(state, poseStack, submitNodeCollector, camera);
	}

	@Override public LivingEntityRenderState createRenderState() {
		return new LivingEntityRenderState();
	}

	@Override public void extractRenderState(${name}Entity entity, LivingEntityRenderState state, float partialTicks) {
		super.extractRenderState(entity, state, partialTicks);
		state.xRot = entity.getXRot(partialTicks);
		state.yRot = entity.getYRot(partialTicks);
	}
}
<#-- @formatter:on -->