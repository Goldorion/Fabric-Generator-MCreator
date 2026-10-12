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
<#include "../procedures.java.ftl">
package ${package}.world.features;

<@javacompress>
public record ${name}Feature(Holder<Feature> feature) implements Feature {
	public static final MapCodec<${name}Feature> CODEC = RecordCodecBuilder.mapCodec(
			builder -> builder.group(Feature.CODEC.fieldOf("feature").forGetter(${name}Feature::feature))
			.apply(builder, ${name}Feature::new));

	@Override public MapCodec<${name}Feature> codec() {
		return CODEC;
	}

	@Override public Stream<Holder<Feature>> getSubFeatures() {
		return Stream.of(this.feature);
	}

	@Override public boolean place(WorldGenLevel world, ChunkGenerator chunkGenerator, RandomSource random, BlockPos origin) {
		<#if hasProcedure(data.generateCondition)>
		int x = origin.getX();
		int y = origin.getY();
		int z = origin.getZ();
		if (!<@procedureOBJToConditionCode data.generateCondition/>)
			return false;
		</#if>

		Feature toPlace = this.feature.value();
		return toPlace.place(world, chunkGenerator, random, origin);
	}
}</@javacompress>
<#-- @formatter:on -->