<#--
 # This file is part of Fabric-Generator-MCreator.
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
<#compress>
package ${package}.mixin;

import org.spongepowered.asm.mixin.Mutable;

@Mixin(MonsterRoomFeature.class)
public abstract class MonsterRoomFeatureMixin {

	@Shadow @Final @Mutable
	private static EntityType<?>[] MOBS;

	@Inject(method = "<clinit>", at = @At("TAIL"))
	private static void injectCustomEntity(CallbackInfo ci) {
		List<EntityType<?>> entities = new ArrayList<>(Arrays.asList(MOBS));
        <#list entities as entity>
        <#if entity.getModElement().getTypeString() == "livingentity" && entity.spawnInDungeons>
        entities.add(${JavaModName}Entities.${entity.getModElement().getRegistryNameUpper()});
        </#if>
        </#list>
		MOBS = entities.toArray(new EntityType[0]);
	}
}
</#compress>
<#-- @formatter:on -->