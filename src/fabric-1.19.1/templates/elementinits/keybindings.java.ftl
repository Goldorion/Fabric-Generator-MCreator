<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2020-2021, Goldorion, opensource contributors
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

<#-- @formatter:off -->

<#include "../procedures.java.ftl">

/*
 *    MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

public class ${JavaModName}KeyMappings {

    <#list keybinds as keybind>
	    public static KeyMapping ${keybind.getModElement().getRegistryNameUpper()};
    </#list>

    public static void serverLoad() {
	    <#list keybinds as key>
	        ServerPlayNetworking.registerGlobalReceiver(new ResourceLocation(${JavaModName}.MODID, "${key.getModElement().getRegistryName()?lower_case}"), ${key.getModElement().getName()}Message::apply);
	    </#list>
	}

	public static void load() {
	    <#list keybinds as keybind>
    	    ${keybind.getModElement().getRegistryNameUpper()} = KeyBindingHelper.registerKeyBinding(new KeyMapping("key.${modid}.${keybind.getModElement().getRegistryName()}",
    	        GLFW.GLFW_KEY_${generator.map(keybind.triggerKey, "keybuttons")}, "key.categories.${keybind.keyBindingCategoryKey}"));
        </#list>
	    ClientTickEvents.END_CLIENT_TICK.register((client) -> {
            <#list keybinds as keybind>
                if(${keybind.getModElement().getRegistryNameUpper()}.isDown() || ${keybind.getModElement().getRegistryNameUpper()}.consumeClick())
			        ClientPlayNetworking.send(new ResourceLocation(${JavaModName}.MODID, "${keybind.getModElement().getRegistryName()?lower_case}"), new ${keybind.getModElement().getName()}Message(${keybind.getModElement().getRegistryNameUpper()}.isDown(),
			                ${keybind.getModElement().getRegistryNameUpper()}.consumeClick()));
            </#list>
        });
	}

}

<#-- @formatter:on -->