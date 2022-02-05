<#--
 # MCreator (https://mcreator.net/)
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2021, Pylo, opensource contributors
 # Copyright (C) 2020-2022, Goldorion, opensource contributors
 #
 # This program is free software: you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.
 #
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <https://www.gnu.org/licenses/>.
 #
 # Additional permission for code generator templates (*.ftl files)
 #
 # As a special exception, you may create a larger work that contains part or
 # all of the MCreator code generator templates (*.ftl files) and distribute
 # that work under terms of your choice, so long as that work isn't itself a
 # template for code generation. Alternatively, if you modify or redistribute
 # the template itself, you may (at your option) remove this special exception,
 # which will cause the template and the resulting code generator output files
 # to be licensed under the GNU General Public License without this special
 # exception.
-->

<#-- @formatter:off -->

/*
 *    MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

public class ${JavaModName}Blocks {

    <#list blocks as block>
        public static Block ${block.getModElement().getRegistryNameUpper()};
    </#list>

    public static void load() {
        <#list blocks as block>
            ${block.getModElement().getRegistryNameUpper()} = Registry.register(Registry.BLOCK, new ResourceLocation(${JavaModName}.MODID,
                "${block.getModElement().getRegistryName()}"), new ${block.getModElement().getName()}Block());
        </#list>
    }

    public static void clientLoad() {
        <#list blocks as block>
            <#if block.getModElement().getTypeString() == "block">
                <#if block.transparencyType != "SOLID" || block.hasTransparency>
                    ${block.getModElement().getName()}Block.clientInit();
                </#if>
            <#elseif block.getModElement().getTypeString() == "plant">
                ${block.getModElement().getName()}Block.clientInit();
            </#if>
        </#list>
    }

}

<#-- @formatter:on -->