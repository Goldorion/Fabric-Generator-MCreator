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
package ${package}.mixin;

@Mixin(EquipmentLayerRenderer.class)
public abstract class EquipmentLayerRendererMixin {
	@Shadow @Final private EquipmentAssetManager equipmentAssets;

	@Shadow @Final private Function<EquipmentLayerRenderer.LayerTextureKey, Identifier> layerTextureLookup;

	@Shadow @Final private Function<EquipmentLayerRenderer.TrimSpriteKey, TextureAtlasSprite> trimSpriteLookup;
	
	@Inject(method = "renderLayers(Lnet/minecraft/client/resources/model/EquipmentClientInfo$LayerType;Lnet/minecraft/resources/ResourceKey;Lnet/minecraft/client/model/Model;Ljava/lang/Object;Lnet/minecraft/world/item/ItemStack;Lcom/mojang/blaze3d/vertex/PoseStack;Lnet/minecraft/client/renderer/SubmitNodeCollector;ILnet/minecraft/resources/Identifier;II)V", at = @At("HEAD"), cancellable = true)
	public <S> void renderLayers(EquipmentClientInfo.LayerType layerType, ResourceKey<EquipmentAsset> resourceKey, Model<? super S> model, S state, ItemStack itemStack, PoseStack poseStack, SubmitNodeCollector submitNodeCollector, int lightCoords, @Nullable Identifier playerTextureOverride, int outlineColor, int order, CallbackInfo ci) {
		if (!${JavaModName}ArmorModels.ARMOR_MODELS.containsKey(itemStack.getItem()) || layerType == EquipmentClientInfo.LayerType.WINGS)
		    return;
		${JavaModName}ArmorModels.ArmorModel armorModel = ${JavaModName}ArmorModels.ARMOR_MODELS.get(itemStack.getItem());
		if (armorModel.getHumanoidArmorModel(itemStack, layerType, model) != null)
			model = armorModel.getGenericArmorModel(itemStack, layerType, model);
		List<EquipmentClientInfo.Layer> layers = this.equipmentAssets.get(resourceKey).getLayers(layerType);
		if (layers.isEmpty()) {
			ci.cancel();
			return;
		}

		int dyeColor = DyedItemColor.getOrDefault(itemStack, 0);
		boolean renderFoil = itemStack.hasFoil();
		int nextOrder = order;

		for(EquipmentClientInfo.Layer layer : layers) {
			int color = ((EquipmentLayerRenderer)(Object)this).getColorForLayer(layer, dyeColor);
			if (color != 0) {
				Identifier layerTexture = layer.usePlayerTexture() && playerTextureOverride != null ? playerTextureOverride : this.layerTextureLookup.apply(new EquipmentLayerRenderer.LayerTextureKey(layerType, layer));
				submitNodeCollector.order(nextOrder++).submitModel(model, state, poseStack, RenderTypes.armorCutoutNoCull(layerTexture), lightCoords, OverlayTexture.NO_OVERLAY, color, null, outlineColor, null);
				if (renderFoil) {
					submitNodeCollector.order(nextOrder++).submitModel(model, state, poseStack, RenderTypes.armorEntityGlint(), lightCoords, OverlayTexture.NO_OVERLAY, color, null, outlineColor, null);
				}

				renderFoil = false;
			}
		}
		ArmorTrim trim = (ArmorTrim)itemStack.get(DataComponents.TRIM);
		if (trim != null && layerType != EquipmentClientInfo.LayerType.HUMANOID_BABY) {
			TextureAtlasSprite sprite = this.trimSpriteLookup.apply(new EquipmentLayerRenderer.TrimSpriteKey(trim, layerType, resourceKey));
			RenderType renderType = Sheets.armorTrimsSheet(trim.pattern().value().decal());
			submitNodeCollector.order(order++).submitModel(model, state, poseStack, renderType, lightCoords, OverlayTexture.NO_OVERLAY, -1, sprite, outlineColor, (ModelFeatureRenderer.CrumblingOverlay)null);
		}
		ci.cancel();
	}
}
<#-- @formatter:on -->