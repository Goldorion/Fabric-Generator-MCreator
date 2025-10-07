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

package ${package}.world.features.treedecorators;

public class ${name}FruitDecorator extends CocoaDecorator {
	public static MapCodec<${name}FruitDecorator> CODEC = MapCodec.unit(${name}FruitDecorator::new);
	public static TreeDecoratorType<?> DECORATOR_TYPE = new TreeDecoratorType<>(CODEC);

	public ${name}FruitDecorator() {
		super(0.2f);
	}

	@Override protected TreeDecoratorType<?> type() {
		return DECORATOR_TYPE;
	}

	@Override ${mcc.getMethod("net.minecraft.world.level.levelgen.feature.treedecorators.CocoaDecorator", "place", "TreeDecorator.Context")
		.replace("this.probability", "0.2F")
		.replace("Blocks.COCOA.defaultBlockState().setValue(CocoaBlock.AGE,Integer.valueOf(randomsource.nextInt(3))).setValue(CocoaBlock.FACING,direction)", "oriented(" + mappedBlockToBlockStateCode(data.treeFruits) + ", direction1)")
		.replace("p_226028_", "context")}

	@SuppressWarnings("deprecation") private static BlockState oriented(BlockState blockstate, Direction direction) {
		return switch (direction) {
			case SOUTH -> blockstate.rotate(Rotation.CLOCKWISE_180);
			case EAST -> blockstate.rotate(Rotation.CLOCKWISE_90);
			case WEST -> blockstate.rotate(Rotation.COUNTERCLOCKWISE_90);
			default -> blockstate;
		};
	}
}
<#-- @formatter:on -->