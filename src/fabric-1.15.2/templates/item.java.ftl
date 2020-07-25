<#-- @formatter:off -->
/*
*    MCreator note:
*
*    If you lock base mod element files, you can edit this file and the proxy files
*    and they won't get overwritten. If you change your mod package or modid, you
*    need to apply these changes to this file MANUALLY.
*
*
*    If you do not lock base mod element files in Workspace settings, this file
*    will be REGENERATED on each build.
*
*/

package ${package}.item;

import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;

public class ${name}Item extends Item {
    public ${name}Item() {
        super(new Item.Settings()
            .group(${data.creativeTab})
            <#if data.damageCount != 0>
                .maxDamage(${data.damageCount})
            <#else>
                .maxStackSize(${data.stackSize})
            </#if>
        );
    }

    @Override
    public int getMaxUseTime(ItemStack itemstack) {
        return ${data.useDuration};
    }

    @Override
    public float getMiningSpeedMultiplier(ItemStack stack, BlockState state) {
        return (float)(${data.toolType}F);
    }

    @Override
    public Multimap<EntityAttribute, EntityAttributeModifier> getAttributeModifiers(EquipmentSlot slot) {
        Multimap<String, EntityAttributeModifier> multimap = super.getAttributeModifiers(slot);
        if (slot == EquipmentSlotType.MAINHAND) {
            multimap.put(EntityAttributes.GENERIC_ATTACK_DAMAGE.getTranslationKey(), new EntityAttributeModifier(ATTACK_DAMAGE_MODIFIER_ID, "item_damage", (double) ${data.damageVsEntity - 2}, EntityAttributeModifier.Operation.ADDITION));
            multimap.put(EntityAttributes.GENERIC_ATTACK_SPEED.getTranslationKey(), new EntityAttributeModifier(ATTACK_SPEED_MODIFIER_ID, "item_attack_speed", -2.4, EntityAttributeModifier.Operation.ADDITION));
        }
        return ImmutableMultimap.of();
    }

    <#if data.hasGlow>
        @Environment(Envtype.CLIENT)
        @Override
        public boolean hasGlint(ItemStack stack) {
            return true;
        }
    </#if>

    <#if data.destroyAnyBlock>
        @Override
        public boolean isEffectiveOn(BlockState state) {
            return true;
        }
    </#if>

    <#if data.specialInfo?has_content>
        @Override
        @Environment(EnvType.CLIENT)
        public void appendTooltip(ItemStack stack, @Nullable World world, List<Text> tooltip, TooltipContext context) {
            <#list data.specialInfo as entry>
                tooltip.add(new LiteralText("${JavaConventions.escapeStringForJava(entry)}"));
            </#list>
        }
    </#if>

    @Override
    public int getEnchantability() {
        return ${data.enchantability};
    }
}
<#-- @formatter:on -->
