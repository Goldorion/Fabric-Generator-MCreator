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
<#include "../mcitems.ftl">

/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

public class ${JavaModName}VillagerProfessions {

	private static final Map<String, ProfessionPoiType> POI_TYPES = new HashMap<>();

	<#list villagerprofessions as villagerprofession>
		public static VillagerProfession ${villagerprofession.getModElement().getRegistryNameUpper()};
	</#list>

	public static void load() {
		<#list villagerprofessions as villagerprofession>
			${villagerprofession.getModElement().getRegistryNameUpper()} =
				registerProfession(
					"${villagerprofession.getModElement().getRegistryName()}",
					() -> ${mappedBlockToBlock(villagerprofession.pointOfInterest)},
					() -> BuiltInRegistries.SOUND_EVENT.getValue(ResourceLocation.parse("${villagerprofession.actionSound}"))
				);
		</#list>

		for (Map.Entry<String, ProfessionPoiType> entry : POI_TYPES.entrySet()) {
			Block block = entry.getValue().block.get();
			String name = entry.getKey();

			Optional<Holder<PoiType>> existingCheck = PoiTypes.forState(block.defaultBlockState());
			if (existingCheck.isPresent()) {
				${JavaModName}.LOGGER.error("Skipping villager profession " + name + " that uses POI block " + block + " that is already in use by " + existingCheck);
				continue;
			}

			PoiType poiType = PointOfInterestHelper.register(ResourceLocation.fromNamespaceAndPath("${modid}", name), 1, 1, ImmutableSet.copyOf(block.getStateDefinition().getPossibleStates()));
				entry.getValue().poiType = BuiltInRegistries.POINT_OF_INTEREST_TYPE.wrapAsHolder(poiType);
		}
	}

	private static VillagerProfession registerProfession(String name, Supplier<Block> block, Supplier<SoundEvent> soundEvent) {
		POI_TYPES.put(name, new ProfessionPoiType(block, null));

		Predicate<Holder<PoiType>> poiPredicate = poiTypeHolder -> (POI_TYPES.get(name).poiType != null) && (poiTypeHolder.value() == POI_TYPES.get(name).poiType.value());

		return Registry.register(BuiltInRegistries.VILLAGER_PROFESSION, ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, name), new VillagerProfession(Component.translatable("entity.villager." + ${JavaModName}.MODID + "." + name), poiPredicate, poiPredicate, ImmutableSet.of(), ImmutableSet.of(), soundEvent.get()));
	}

	private static class ProfessionPoiType {

		final Supplier<Block> block;
		Holder<PoiType> poiType;

		ProfessionPoiType(Supplier<Block> block, Holder<PoiType> poiType) {
			this.block = block;
			this.poiType = poiType;
		}
	}
}
<#-- @formatter:on -->