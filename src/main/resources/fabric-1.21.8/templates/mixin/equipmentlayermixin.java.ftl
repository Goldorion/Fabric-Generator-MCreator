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

	@Shadow @Final private Function<EquipmentLayerRenderer.LayerTextureKey, ResourceLocation> layerTextureLookup;

	@Shadow @Final private Function<EquipmentLayerRenderer.TrimSpriteKey, TextureAtlasSprite> trimSpriteLookup;

	@Shadow private static int getColorForLayer(EquipmentClientInfo.Layer layer, int i) {
		return 0;
	}

	@Inject(method = "Lnet/minecraft/client/renderer/entity/layers/EquipmentLayerRenderer;renderLayers(Lnet/minecraft/client/resources/model/EquipmentClientInfo$LayerType;Lnet/minecraft/resources/ResourceKey;Lnet/minecraft/client/model/Model;Lnet/minecraft/world/item/ItemStack;Lcom/mojang/blaze3d/vertex/PoseStack;Lnet/minecraft/client/renderer/MultiBufferSource;ILnet/minecraft/resources/ResourceLocation;)V", at = @At("HEAD"), cancellable = true)
	public void renderLayers(EquipmentClientInfo.LayerType layerType, ResourceKey<EquipmentAsset> resourceKey, Model model, ItemStack itemStack, PoseStack poseStack, MultiBufferSource multiBufferSource, int i, ResourceLocation resourceLocation, CallbackInfo ci) {
		if (${JavaModName}ArmorModels.ARMOR_MODELS.containsKey(itemStack.getItem())) {
			${JavaModName}ArmorModels.ArmorModel armorModel = ${JavaModName}ArmorModels.ARMOR_MODELS.get(itemStack.getItem());
			if (armorModel.getHumanoidArmorModel(itemStack, layerType, model) != null)
				model = armorModel.getGenericArmorModel(itemStack, layerType, model);
			List<EquipmentClientInfo.Layer> list = this.equipmentAssets.get(resourceKey).getLayers(layerType);
			if (list.isEmpty()) {
				ci.cancel();
			}
			int j = DyedItemColor.getOrDefault(itemStack, 0);
			boolean bl = itemStack.hasFoil();
			for (EquipmentClientInfo.Layer layer : list) {
				int k = getColorForLayer(layer, j);
				if (k == 0) continue;
				ResourceLocation resourceLocation2 = layer.usePlayerTexture() && resourceLocation != null ? resourceLocation : this.layerTextureLookup.apply(new EquipmentLayerRenderer.LayerTextureKey(layerType, layer));
				resourceLocation2 = armorModel.getArmorTexture(itemStack, layerType, layer, resourceLocation2);
				VertexConsumer vertexConsumer = ItemRenderer.getArmorFoilBuffer(multiBufferSource, RenderType.armorCutoutNoCull(resourceLocation2), bl);
				model.renderToBuffer(poseStack, vertexConsumer, i, OverlayTexture.NO_OVERLAY, k);
				bl = false;
			}
			ArmorTrim armorTrim = itemStack.get(DataComponents.TRIM);
			if (armorTrim != null) {
				TextureAtlasSprite textureAtlasSprite = this.trimSpriteLookup.apply(new EquipmentLayerRenderer.TrimSpriteKey(armorTrim, layerType, resourceKey));
				VertexConsumer vertexConsumer2 = textureAtlasSprite.wrap(multiBufferSource.getBuffer(Sheets.armorTrimsSheet(armorTrim.pattern().value().decal())));
				model.renderToBuffer(poseStack, vertexConsumer2, i, OverlayTexture.NO_OVERLAY);
			}
			ci.cancel();
		}
	}
}
<#-- @formatter:on -->