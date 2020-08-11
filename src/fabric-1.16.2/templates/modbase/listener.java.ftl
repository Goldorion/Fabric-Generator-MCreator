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

package ${package};

public interface IListener {
    default void worldTick(World world) {

    }

    default void useOnBlock(PlayerEntity player, World world, Hand hand, BlockHitResult hitResult) {

    }

    default void useOnEntity(PlayerEntity player, World world, Hand hand, Entity entity, /* Nullable */ EntityHitResult hitResult) {

    }

    default void useItem(PlayerEntity player, World world, Hand hand) {

    }
}

<#-- @formatter:on -->
