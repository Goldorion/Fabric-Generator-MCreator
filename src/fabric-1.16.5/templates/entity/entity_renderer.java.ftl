<#--
This file is part of Fabric-Generator-MCreator.

MCreatorFabricGenerator is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

MCreatorFabricGenerator is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with MCreatorFabricGenerator.  If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->

package ${package}.entity.render;

public class ${name}EntityRenderer extends MobEntityRenderer<${name}Entity, ${name}EntityRenderer.${data.mobModelName}> {

    public ${name}EntityRenderer(EntityRenderDispatcher entityRenderDispatcher) {
        super(entityRenderDispatcher, new ${data.mobModelName}(), ${data.modelShadowSize}f);
    }

    public static void clientInit() {
        EntityRendererRegistry.INSTANCE.register(${name}Entity.ENTITY, (dispatcher, context) -> new ${name}EntityRenderer(dispatcher));
    }

    @Override
    public Identifier getTexture(${name}Entity entity) {
        return new Identifier("${modid}:textures/${data.mobModelTexture}");
    }

	<#if data.getModelCode()?? && !data.isBuiltInModel() >
	<#assign entityName>
	    ${name}
	</#assign>
	${data.getModelCode().toString()
		.replace("extends EntityModel<Entity>", "extends EntityModel<" + name + "Entity>")
		.replace("GlStateManager.translate", "GlStateManager.translated")
		.replace("ModelRenderer ", "ModelPart ")
		.replace("ModelRenderer(", "ModelPart(")
		.replace("GlStateManager.scale", "GlStateManager.scaled")
		.replace("rotateAngleX", "pitch")
		.replace("rotateAngleY", "yaw")
		.replace("rotateAngleZ", "roll")
		.replace("setRotationPoint", "setPivot")
		.replace(".addBox(", ".addCuboid(")
		.replace("IVertexBuilder", "VertexConsumer")
		.replaceAll("setRotationAngles\\(float[\n\r\t\\s]+f,[\n\r\t\\s]+float[\n\r\t\\s]+f1,[\n\r\t\\s]+float[\n\r\t\\s]+f2,[\n\r\t\\s]+float[\n\r\t\\s]+f3,[\n\r\t\\s]+float[\n\r\t\\s]+f4,[\n\r\t\\s]+float[\n\r\t\\s]+f5,[\n\r\t\\s]+Entity[\n\r\t\\s]+e\\)",
		"setAngles(" + name + "Entity e, float f, float f1, float f2, float f3, float f4)")
		.replaceAll("setAngles\\(float[\n\r\t\\s]+f,[\n\r\t\\s]+float[\n\r\t\\s]+f1,[\n\r\t\\s]+float[\n\r\t\\s]+f2,[\n\r\t\\s]+float[\n\r\t\\s]+f3,[\n\r\t\\s]+float[\n\r\t\\s]+f4,[\n\r\t\\s]+float[\n\r\t\\s]+f5,[\n\r\t\\s]+Entity[\n\r\t\\s]+entity\\)",
		"setAngles(Entity entity, float f, float f1, float f2, float f3, float f4)")
		.replace("super.setRotationAngles(f, f1, f2, f3, f4, f5, e);", "")

		.replaceAll("render\\(Entity[\n\r\t\\s]+entity,[\n\r\t\\s]+float[\n\r\t\\s]+f,[\n\r\t\\s]+float[\n\r\t\\s]+f1,[\n\r\t\\s]+float[\n\r\t\\s]+f2,[\n\r\t\\s]+float[\n\r\t\\s]+f3,[\n\r\t\\s]+float[\n\r\t\\s]+f4,[\n\r\t\\s]+float[\n\r\t\\s]+f5\\)",
		"render(MatrixStack ms, VertexConsumer vb, int i1, int i2, float f1, float f2, float f3, float f4)")
		.replaceAll("super\\.render\\(entity,[\n\r\t\\s]+f,[\n\r\t\\s]+f1,[\n\r\t\\s]+f2,[\n\r\t\\s]+f3,[\n\r\t\\s]+f4,[\n\r\t\\s]+f5\\);", "")
		.replace(".render(f5);", ".render(ms, vb, i1, i2, f1, f2, f3, f4);")
	}
	</#if>
}

<#-- @formatter:on -->