<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2025, Pylo, opensource contributors
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
<#include "../procedures.java.ftl">
<#include "../triggers.java.ftl">
package ${package}.block;

import net.minecraft.world.level.block.state.BlockBehaviour.Properties;

<@javacompress>
public class ${name}Block extends LiquidBlock {

	public ${name}Block(BlockBehaviour.Properties properties) {
		super(${JavaModName}Fluids.${REGISTRYNAME},
			properties
			<#if generator.map(data.colorOnMap, "mapcolors") != "DEFAULT">
			.mapColor(MapColor.${generator.map(data.colorOnMap, "mapcolors")})
			<#else>
			.mapColor(MapColor.${(data.type=="WATER")?then("WATER","FIRE")})
			</#if>
			.strength(${data.resistance}f)
			<#if data.emissiveRendering>.hasPostProcess((bs, br, bp) -> true).emissiveRendering((bs, br, bp) -> true)</#if>
			<#if data.luminance != 0>.lightLevel(s -> ${data.luminance})</#if>
			<#if data.ignitedByLava>.ignitedByLava()</#if>
			.noCollission().noLootTable().liquid().pushReaction(PushReaction.DESTROY).sound(SoundType.EMPTY).replaceable()
		);

		<#if data.flammability != 0 && data.fireSpreadSpeed != 0>
			FlammableBlockRegistry.getDefaultInstance().add(this, ${data.flammability}, ${data.fireSpreadSpeed});
		</#if>
	}

	<#if data.lightOpacity == 0>
	@Override public boolean propagatesSkylightDown(BlockState state) {
		return true;
	}
	<#elseif data.lightOpacity != 1>
	@Override public int getLightBlock(BlockState state) {
		return ${data.lightOpacity};
	}
	</#if>

	<@onBlockAdded data.onBlockAdded, hasProcedure(data.onTickUpdate) && data.tickRate gt 0, data.tickRate/>

	<@onRedstoneOrNeighborChanged "", "", data.onNeighbourChanges/>

	<#if hasProcedure(data.onTickUpdate)>
	@Override public void tick(BlockState blockstate, ServerLevel world, BlockPos pos, RandomSource random) {
		super.tick(blockstate, world, pos, random);
		<@procedureCode data.onTickUpdate, {
			"x": "pos.getX()",
			"y": "pos.getY()",
			"z": "pos.getZ()",
			"world": "world",
			"blockstate": "blockstate"
		}/>
		<#if (data.tickRate > 0)>
		world.scheduleTick(pos, this, ${data.tickRate});
		</#if>
	}
	</#if>

	<@onEntityCollides data.onEntityCollides/>

	<@onAnimateTick data.onRandomUpdateEvent/>

	<@onDestroyedByExplosion data.onDestroyedByExplosion/>

}</@javacompress>