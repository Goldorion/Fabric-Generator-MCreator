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
<#include "procedures.java.ftl">

package ${package}.network;

import ${package}.${JavaModName};

public class ${name}Message {

	<#if hasProcedure(data.onKeyPressed) || hasProcedure(data.onKeyReleased)>
    	public static void pressAction(Player entity, KeyMapping key) {
    		Level world = entity.level;
    		double x = entity.getX();
    		double y = entity.getY();
    		double z = entity.getZ();

    		// security measure to prevent arbitrary chunk generation
    		if (!world.hasChunkAt(entity.blockPosition()))
    			return;

    		<#if hasProcedure(data.onKeyPressed)>
    		    if(key.isDown()) {
    			    <@procedureOBJToCode data.onKeyPressed/>
    		    }
    		</#if>

    		<#if hasProcedure(data.onKeyReleased)>
                if(key.consumeClick()) {
    			    <@procedureOBJToCode data.onKeyReleased/>
    		    }
    		</#if>
    	}
    </#if>
}
<#-- @formatter:on -->