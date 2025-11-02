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
package ${package}.world.features;

public class StructureFeature extends Feature<StructureFeatureConfiguration> {
	public StructureFeature(Codec<StructureFeatureConfiguration> codec) {
		super(codec);
	}

	public boolean place(FeaturePlaceContext<StructureFeatureConfiguration> context) {
		RandomSource random = context.random();
		WorldGenLevel worldGenLevel = context.level();
		StructureFeatureConfiguration config = context.config();
		Rotation rotation = config.randomRotation() ? Rotation.getRandom(random) : Rotation.NONE;
		Mirror mirror = config.randomMirror() ? Mirror.values()[random.nextInt(2)] : Mirror.NONE;
		// Load the structure template
		StructureTemplateManager structureManager = worldGenLevel.getLevel().getServer().getStructureManager();
		StructureTemplate template = structureManager.getOrCreate(config.structure());
		StructurePlaceSettings placeSettings = (new StructurePlaceSettings()).setRotation(rotation).setMirror(mirror).setRandom(random).setIgnoreEntities(false)
				.addProcessor(new BlockIgnoreProcessor(config.ignoredBlocks().stream().map(Holder::value).toList()));
		BlockPos placePos = context.origin().offset(StructureTemplate.calculateRelativePosition(placeSettings, new BlockPos(config.offset())));
		template.placeInWorld(worldGenLevel, placePos, placePos, placeSettings, random, 2);
		return true;
	}
}
<#-- @formatter:on -->