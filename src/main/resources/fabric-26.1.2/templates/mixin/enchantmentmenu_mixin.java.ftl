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
package ${package}.mixin;

@Mixin(EnchantmentMenu.class)
public abstract class EnchantmentMenuMixin {

	@Unique
	private static final HashMap<Block, Integer> VALUES = new HashMap<>() {{
		put(Blocks.BOOKSHELF, 1);
		<#list w.getGElementsOfType('block')?filter(e -> e.enchantPowerBonus gt 0) as block>
		put(${JavaModName}Blocks.${block.getModElement().getRegistryNameUpper()}, ${block.enchantPowerBonus?round});
		</#list>
	}};

	@Final @Shadow private Container enchantSlots;
	@Final @Shadow private ContainerLevelAccess access;
	@Final @Shadow private RandomSource random;
	@Final @Shadow private DataSlot enchantmentSeed;

	@Unique private final EnchantmentMenu self = (EnchantmentMenu) (Object) this;

	@Inject(method = "slotsChanged(Lnet/minecraft/world/Container;)V", at = @At(value = "TAIL"))
	public void slotsChangedInject(Container container, CallbackInfo ci) {
		${mcc.getCodeFor("net.minecraft.world.inventory.EnchantmentMenu", 115, 127)
				.replace("this.costs", "self.costs")
				.replace("this.enchantClue", "self.enchantClue")
				.replace("this.levelClue", "self.levelClue")
				.replace("IdMap<Holder<Holder<Enchantment>>> holders", "IdMap<Holder<Enchantment>> holders")
				.replace("this.", "")}

		for (BlockPos blockPos2 : EnchantingTableBlock.BOOKSHELF_OFFSETS) {
			Block block = level.getBlockState(pos.offset(blockPos2)).getBlock();
			if (EnchantingTableBlock.isValidBookShelf(level, pos, blockPos2))
				bookcases++;
			else if (VALUES.containsKey(block))
				bookcases += VALUES.get(block);
		}

		${mcc.getCodeFor("net.minecraft.world.inventory.EnchantmentMenu", 132, 150).replace("this.getEnchantmentList", "self.getEnchantmentList")
				.replace("this.costs", "self.costs")
				.replace("this.enchantClue", "self.enchantClue")
				.replace("this.levelClue", "self.levelClue")
				.replace("this.broadcastChanges()", "self.broadcastChanges()")
				.replace("this.", "")}
	}

}
<#-- @formatter:on -->