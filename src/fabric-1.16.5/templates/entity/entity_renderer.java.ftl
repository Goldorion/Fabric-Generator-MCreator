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

public class ${name}EntityRenderer extends MobEntityRenderer<${name}Entity, ${name}EntityModel> {

    public ${name}EntityRenderer(EntityRenderDispatcher entityRenderDispatcher) {
            super(entityRenderDispatcher, new  ${name}EntityModel(), ${data.modelShadowSize}f);
        }

        public static void clientInit() {
            EntityRendererRegistry.INSTANCE.register(${name}Entity.ENTITY, (dispatcher, context) -> new ${name}EntityRenderer(dispatcher));
        }

        @Override
        public Identifier getTexture(TestEntityEntity entity) {
            return new Identifier("${modid}:textures/${data.mobModelTexture}");
        }
}

<#-- @formatter:on -->