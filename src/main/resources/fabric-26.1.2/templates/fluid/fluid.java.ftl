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
package ${package}.fluid;

<@javacompress>
public abstract class ${name}Fluid extends FlowingFluid {
	private static final FluidVariantAttributeHandler PROPERTIES = new FluidVariantAttributeHandler() {
		<#if data.luminosity != 0>
		@Override public int getLightEmission(FluidVariant variant) {
			return ${(data.luminosity lt 15)?then(data.luminosity, 15)};
		}
		</#if>

		<#if (data.density < 0)>
		@Override public boolean isLighterThanAir(FluidVariant variant) {
			return true;
		}
		</#if>

		<#if data.viscosity != 1000>
		@Override public int getViscosity(FluidVariant variant, @Nullable Level world) {
			return ${data.viscosity};
		}
		</#if>

		<#if data.temperature != 300>
		@Override public int getTemperature(FluidVariant variant) {
			return ${data.temperature};
		}
		</#if>

		<#if data.emptySound?has_content && data.emptySound.getMappedValue()?has_content>
		@Override public Optional<SoundEvent> getEmptySound(FluidVariant variant) {
			return Optional.of(BuiltInRegistries.SOUND_EVENT.getValue(Identifier.parse("${data.emptySound}")));
		}
		</#if>
	};

	private ${name}Fluid() {
		super();
	}

	@Override public Fluid getFlowing() {
		return ${JavaModName}Fluids.FLOWING_${REGISTRYNAME};
	}

	@Override public Fluid getSource() {
		return ${JavaModName}Fluids.${REGISTRYNAME};
	}

	@Override protected boolean canConvertToSource(ServerLevel level) {
		return ${data.canMultiply};
	}

	@Override protected int getSlopeFindDistance(LevelReader level) {
		return ${data.slopeFindDistance};
	}

	@Override protected int getDropOff(LevelReader level) {
		return ${data.levelDecrease};
	}

	@Override public Item getBucket() {
		return <#if data.generateBucket>${JavaModName}Items.${REGISTRYNAME}_BUCKET<#else>Items.AIR</#if>;
	}

	@Override protected boolean canBeReplacedWith(FluidState state, BlockGetter level, BlockPos pos, Fluid fluid, Direction direction) {
		return direction == Direction.DOWN && !isSame(fluid);
	}

	@Override public int getTickDelay(LevelReader level) {
		return ${data.flowRate};
	}

	@Override protected float getExplosionResistance() {
		return ${data.resistance}f;
	}

	@Override protected BlockState createLegacyBlock(FluidState state) {
		return ${JavaModName}Blocks.${REGISTRYNAME}.defaultBlockState().setValue(LiquidBlock.LEVEL, getLegacyLevel(state));
	}

	@Override public boolean isSame(Fluid fluid) {
		return fluid == getSource() || fluid == getFlowing();
	}

	@Override public Optional<SoundEvent> getPickupSound() {
		return Optional.of(SoundEvents.BUCKET_FILL);
	}

	<#if data.type == "WATER">
	@Override ${mcc.getMethod("net.minecraft.world.level.material.WaterFluid", "entityInside", "Level", "BlockPos", "Entity", "InsideBlockEffectApplier")}
	<#else>
	@Override ${mcc.getMethod("net.minecraft.world.level.material.LavaFluid", "entityInside", "Level", "BlockPos", "Entity", "InsideBlockEffectApplier")}
	</#if>

	<#if data.spawnParticles>
	@Override public ParticleOptions getDripParticle() {
		return ${data.dripParticle};
	}
	</#if>

	<#if data.flowStrength != 1>
	@Override public Vec3 getFlow(BlockGetter world, BlockPos pos, FluidState fluidstate) {
		return super.getFlow(world, pos, fluidstate).scale(${data.flowStrength});
	}
	</#if>

	<#if hasProcedure(data.flowCondition)>
	@Override protected void spread(ServerLevel world, BlockPos fromPos, BlockState blockstate, FluidState fluidIn) {
		int x = fromPos.getX();
		int y = fromPos.getY();
		int z = fromPos.getZ();
		if(<@procedureOBJToConditionCode data.flowCondition/>)
			super.spread(world, fromPos, blockstate, fluidIn);
	}
	</#if>


	@Override protected void beforeDestroyingBlock(LevelAccessor world, BlockPos pos, BlockState blockstate) {
		BlockEntity blockEntity = blockstate.hasBlockEntity() ? world.getBlockEntity(pos) : null;
		Block.dropResources(blockstate, world, pos, blockEntity);
		<#if hasProcedure(data.beforeReplacingBlock)>
		<@procedureCode data.beforeReplacingBlock, {
			"x": "pos.getX()",
			"y": "pos.getY()",
			"z": "pos.getZ()",
			"world": "world",
			"blockstate": "blockstate"
		}/>
		</#if>
	}

	public static class Source extends ${name}Fluid {
		public int getAmount(FluidState state) {
			return 8;
		}

		public boolean isSource(FluidState state) {
			return true;
		}
	}

	public static class Flowing extends ${name}Fluid {
		protected void createFluidStateDefinition(StateDefinition.Builder<Fluid, FluidState> builder) {
			super.createFluidStateDefinition(builder);
			builder.add(LEVEL);
		}

		public int getAmount(FluidState state) {
			return state.getValue(LEVEL);
		}

		public boolean isSource(FluidState state) {
			return false;
		}
	}

	public static void load() {
		FluidVariantAttributes.register(${JavaModName}Fluids.${REGISTRYNAME}, PROPERTIES);
		FluidVariantAttributes.register(${JavaModName}Fluids.FLOWING_${REGISTRYNAME}, PROPERTIES);
	}

	@Environment(EnvType.CLIENT) public static void clientLoad() {
		FluidRenderingRegistry.register(${JavaModName}Fluids.${REGISTRYNAME}, ${JavaModName}Fluids.FLOWING_${REGISTRYNAME}, new FluidModel.Unbaked(
		new Material(Identifier.parse("${data.textureStill.format("%s:block/%s")}")), new Material(Identifier.parse("${data.textureFlowing.format("%s:block/%s")}")),
		<#if data.textureRenderOverlay?has_content>new Material(Identifier.parse("${data.textureRenderOverlay.format("%s:textures/%s")}.png"))<#else>null</#if>,
				<#if data.isFluidTinted()>
				new BlockTintSource() {
					@Override public int color(BlockState state) {
						return <#if data.tintType == "Grass">
						-6506636
						<#elseif data.tintType == "Foliage" || data.tintType == "Default foliage">
						-12012264
						<#elseif data.tintType == "Birch foliage">
						-8345771
						<#elseif data.tintType == "Spruce foliage">
						-10380959
						<#elseif data.tintType == "Water">
						-13083194
						<#elseif data.tintType == "Sky">
						-8214273
						<#elseif data.tintType == "Fog">
						-4138753
						<#else>
						-16448205
						</#if>;
					}

					@Override public int colorInWorld(BlockState blockState, BlockAndTintGetter world, BlockPos pos) {
						return <#if data.tintType == "Grass">
							BiomeColors.getAverageGrassColor(world, pos)
						<#elseif data.tintType == "Foliage">
							BiomeColors.getAverageFoliageColor(world, pos)
						<#elseif data.tintType == "Default foliage">
							FoliageColor.FOLIAGE_DEFAULT
						<#elseif data.tintType == "Birch foliage">
							FoliageColor.FOLIAGE_BIRCH
						<#elseif data.tintType == "Spruce foliage">
							FoliageColor.FOLIAGE_EVERGREEN
						<#elseif data.tintType == "Water">
							BiomeColors.getAverageWaterColor(world, pos)
						<#elseif data.tintType == "Sky">
							Minecraft.getInstance().gameRenderer.getMainCamera().attributeProbe().getValue(EnvironmentAttributes.SKY_COLOR, 0)
						<#elseif data.tintType == "Fog">
							Minecraft.getInstance().gameRenderer.getMainCamera().attributeProbe().getValue(EnvironmentAttributes.FOG_COLOR, 0)
						<#else>
							Minecraft.getInstance().gameRenderer.getMainCamera().attributeProbe().getValue(EnvironmentAttributes.WATER_FOG_COLOR, 0)
						</#if> | 0xFF000000;
					}
				}
				<#else>
				null
				</#if>
		));
	}
}</@javacompress>
<#-- @formatter:on -->