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
package ${package}.world.features.configurations;

public record StructureFeatureConfiguration(Identifier structure, boolean randomRotation, boolean randomMirror, HolderSet<Block> ignoredBlocks, Vec3i offset) implements FeatureConfiguration {
	public static final Codec<StructureFeatureConfiguration> CODEC = RecordCodecBuilder.create(builder -> builder.group(
		Identifier.CODEC.fieldOf("structure").forGetter(StructureFeatureConfiguration::structure),
		Codec.BOOL.fieldOf("random_rotation").orElse(false).forGetter(StructureFeatureConfiguration::randomRotation),
		Codec.BOOL.fieldOf("random_mirror").orElse(false).forGetter(StructureFeatureConfiguration::randomMirror),
		RegistryCodecs.homogeneousList(Registries.BLOCK).fieldOf("ignored_blocks").forGetter(StructureFeatureConfiguration::ignoredBlocks),
		Vec3i.offsetCodec(48).optionalFieldOf("offset", Vec3i.ZERO).forGetter(StructureFeatureConfiguration::offset)
	).apply(builder, StructureFeatureConfiguration::new));
}
<#-- @formatter:on -->
