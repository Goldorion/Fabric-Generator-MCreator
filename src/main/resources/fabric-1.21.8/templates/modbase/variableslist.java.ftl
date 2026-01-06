<#--
 # This file is part of Fabric-Generator-MCreator.
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
package ${package}.network;

import ${package}.${JavaModName};

public class ${JavaModName}Variables {
	<#if w.hasVariablesOfScope("PLAYER_LIFETIME") || w.hasVariablesOfScope("PLAYER_PERSISTENT")>
	public static final AttachmentType<PlayerVariables> PLAYER_VARIABLES = AttachmentRegistry.create(ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, "player_variables"), (builder) -> builder.persistent(PlayerVariables.CODEC).initializer(PlayerVariables::new));
	</#if>

	<#if w.hasVariablesOfScope("GLOBAL_SESSION")>
		<#list variables as var>
			<#if var.getScope().name() == "GLOBAL_SESSION">
				<@var.getType().getScopeDefinition(generator.getWorkspace(), "GLOBAL_SESSION")['init']?interpret/>
			</#if>
		</#list>
	</#if>

	public static void variablesLoad() {
        <#if w.hasVariablesOfScope("PLAYER_LIFETIME") || w.hasVariablesOfScope("PLAYER_PERSISTENT")>
        PayloadTypeRegistry.playS2C().register(PlayerVariablesSyncMessage.TYPE, PlayerVariablesSyncMessage.STREAM_CODEC);

        ServerPlayerEvents.JOIN.register((player) -> {
            ServerPlayNetworking.send(player, new PlayerVariablesSyncMessage(player.getAttachedOrCreate(PLAYER_VARIABLES)));
        });

		ServerPlayerEvents.AFTER_RESPAWN.register((oldPlayer, newPlayer, alive) -> {
				ServerPlayNetworking.send(newPlayer, new PlayerVariablesSyncMessage(oldPlayer.getAttachedOrCreate(PLAYER_VARIABLES)));
		});

		ServerEntityWorldChangeEvents.AFTER_PLAYER_CHANGE_WORLD.register((player, origin, destination) -> {
			if (!destination.isClientSide())
				ServerPlayNetworking.send(player, new PlayerVariablesSyncMessage(player.getAttachedOrCreate(PLAYER_VARIABLES)));
		});

        PlayerEvents.END_PLAYER_TICK.register((entity) -> {
		    if (entity instanceof ServerPlayer player && player.getAttachedOrCreate(PLAYER_VARIABLES)._syncDirty) {
                ServerPlayNetworking.send(player, new PlayerVariablesSyncMessage(player.getAttachedOrCreate(PLAYER_VARIABLES)));
                player.getAttachedOrCreate(PLAYER_VARIABLES)._syncDirty = false;
            }
		});

		ServerPlayerEvents.COPY_FROM.register((oldPlayer, newPlayer, alive) -> {
            PlayerVariables original = oldPlayer.getAttachedOrCreate(PLAYER_VARIABLES);
            PlayerVariables clone = new PlayerVariables();
            <#list variables as var>
                <#if var.getScope().name() == "PLAYER_PERSISTENT">
                clone.${var.getName()} = original.${var.getName()};
                </#if>
            </#list>
            if(alive) {
                <#list variables as var>
                    <#if var.getScope().name() == "PLAYER_LIFETIME">
                    clone.${var.getName()} = original.${var.getName()};
                    </#if>
                </#list>
            }
            newPlayer.setAttached(PLAYER_VARIABLES, clone);
		});
        </#if>

        <#if w.hasVariablesOfScope("GLOBAL_WORLD") || w.hasVariablesOfScope("GLOBAL_MAP")>
        PayloadTypeRegistry.playS2C().register(SavedDataSyncMessage.TYPE, SavedDataSyncMessage.STREAM_CODEC);

		ServerPlayerEvents.JOIN.register((player) -> {
			SavedData mapdata = MapVariables.get(player.level());
			SavedData worlddata = WorldVariables.get(player.level());
			if(mapdata != null)
				ServerPlayNetworking.send(player, new SavedDataSyncMessage(0, mapdata));
			if(worlddata != null)
				ServerPlayNetworking.send(player, new SavedDataSyncMessage(1, worlddata));
		});

		ServerEntityWorldChangeEvents.AFTER_PLAYER_CHANGE_WORLD.register((player, origin, destination) -> {
			if (!destination.isClientSide()) {
				SavedData worlddata = WorldVariables.get(player.level());
				if(worlddata != null)
					ServerPlayNetworking.send(player, new SavedDataSyncMessage(1, worlddata));
			}
		});

        ServerTickEvents.END_WORLD_TICK.register((level) -> {
			WorldVariables worldVariables = WorldVariables.get(level);
			if (worldVariables._syncDirty) {
			    level.players().forEach(player -> ServerPlayNetworking.send(player, new SavedDataSyncMessage(1, worldVariables)));
			    worldVariables._syncDirty = false;
			}

			MapVariables mapVariables = MapVariables.get(level);
			if (mapVariables._syncDirty) {
			    PlayerLookup.world(level).forEach(player -> ServerPlayNetworking.send(player, new SavedDataSyncMessage(0, mapVariables)));
			    mapVariables._syncDirty = false;
			}
		});
	</#if>
    }

	<#if w.hasVariablesOfScope("GLOBAL_WORLD") || w.hasVariablesOfScope("GLOBAL_MAP")>
	public static class WorldVariables extends SavedData {

		public static final SavedDataType<WorldVariables> TYPE = new SavedDataType<>("${modid}_worldvars", ctx -> new WorldVariables(),
			ctx -> CompoundTag.CODEC.xmap(
				tag -> {
					WorldVariables instance = new WorldVariables();
					instance.read(tag, ctx.levelOrThrow().registryAccess());
					return instance;
				},
				instance -> instance.save(new CompoundTag(), ctx.levelOrThrow().registryAccess())
			), null
		);

		boolean _syncDirty = false;

		<#list variables as var>
			<#if var.getScope().name() == "GLOBAL_WORLD">
				<@var.getType().getScopeDefinition(generator.getWorkspace(), "GLOBAL_WORLD")['init']?interpret/>
			</#if>
		</#list>

		public void read(CompoundTag nbt, HolderLookup.Provider lookupProvider) {
			<#list variables as var>
				<#if var.getScope().name() == "GLOBAL_WORLD">
					<@var.getType().getScopeDefinition(generator.getWorkspace(), "GLOBAL_WORLD")['read']?interpret/>
				</#if>
			</#list>
		}

		public CompoundTag save(CompoundTag nbt, HolderLookup.Provider lookupProvider) {
			<#list variables as var>
				<#if var.getScope().name() == "GLOBAL_WORLD">
					<@var.getType().getScopeDefinition(generator.getWorkspace(), "GLOBAL_WORLD")['write']?interpret/>
				</#if>
			</#list>
			return nbt;
		}

		public void markSyncDirty() {
			this.setDirty();
			this._syncDirty = true;
		}

		static WorldVariables clientSide = new WorldVariables();

		public static WorldVariables get(LevelAccessor world) {
			if (world instanceof ServerLevel level) {
				return level.getDataStorage().computeIfAbsent(WorldVariables.TYPE);
			} else {
				return clientSide;
			}
		}
	}

	public static class MapVariables extends SavedData {

		public static final SavedDataType<MapVariables> TYPE = new SavedDataType<>("${modid}_mapvars", ctx -> new MapVariables(),
			ctx -> CompoundTag.CODEC.xmap(
				tag -> {
					MapVariables instance = new MapVariables();
					instance.read(tag, ctx.levelOrThrow().registryAccess());
					return instance;
				},
				instance -> instance.save(new CompoundTag(), ctx.levelOrThrow().registryAccess())
			), null
		);

		boolean _syncDirty = false;

		<#list variables as var>
			<#if var.getScope().name() == "GLOBAL_MAP">
				<@var.getType().getScopeDefinition(generator.getWorkspace(), "GLOBAL_MAP")['init']?interpret/>
			</#if>
		</#list>

		public void read(CompoundTag nbt, HolderLookup.Provider lookupProvider) {
			<#list variables as var>
				<#if var.getScope().name() == "GLOBAL_MAP">
					<@var.getType().getScopeDefinition(generator.getWorkspace(), "GLOBAL_MAP")['read']?interpret/>
				</#if>
			</#list>
		}

		public CompoundTag save(CompoundTag nbt, HolderLookup.Provider lookupProvider) {
			<#list variables as var>
				<#if var.getScope().name() == "GLOBAL_MAP">
					<@var.getType().getScopeDefinition(generator.getWorkspace(), "GLOBAL_MAP")['write']?interpret/>
				</#if>
			</#list>
			return nbt;
		}

		public void markSyncDirty() {
			this.setDirty();
			this._syncDirty = true;
		}

		static MapVariables clientSide = new MapVariables();

		public static MapVariables get(LevelAccessor world) {
			if (world instanceof ServerLevelAccessor serverLevelAccessor) {
				return serverLevelAccessor.getLevel().getServer().getLevel(Level.OVERWORLD).getDataStorage().computeIfAbsent(MapVariables.TYPE);
			} else {
				return clientSide;
			}
		}
	}

	public record SavedDataSyncMessage(int dataType, SavedData data) implements CustomPacketPayload {

		public static final Type<SavedDataSyncMessage> TYPE = new Type<>(ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, "saved_data_sync"));

		public static final StreamCodec<RegistryFriendlyByteBuf, SavedDataSyncMessage> STREAM_CODEC = StreamCodec.of(
			(RegistryFriendlyByteBuf buffer, SavedDataSyncMessage message) -> {
				buffer.writeInt(message.dataType);
				if (message.data instanceof MapVariables mapVariables)
					buffer.writeNbt(mapVariables.save(new CompoundTag(), buffer.registryAccess()));
				else if (message.data instanceof WorldVariables worldVariables)
					buffer.writeNbt(worldVariables.save(new CompoundTag(), buffer.registryAccess()));
			},
			(RegistryFriendlyByteBuf buffer) -> {
				int dataType = buffer.readInt();
				CompoundTag nbt = buffer.readNbt();
				SavedData data = null;
				if (nbt != null) {
					data = dataType == 0 ? new MapVariables() : new WorldVariables();
					if(data instanceof MapVariables mapVariables)
						mapVariables.read(nbt, buffer.registryAccess());
					else if(data instanceof WorldVariables worldVariables)
						worldVariables.read(nbt, buffer.registryAccess());
				}
				return new SavedDataSyncMessage(dataType, data);
			}
		);

		@Override public Type<SavedDataSyncMessage> type() {
			return TYPE;
		}

		public static void handleData(final SavedDataSyncMessage message, final ClientPlayNetworking.Context context) {
			if (message.data != null) {
				context.client().execute(() -> {
					if (message.dataType == 0)
						MapVariables.clientSide.read(((MapVariables) message.data).save(new CompoundTag(), context.player().registryAccess()), context.player().registryAccess());
					else
						WorldVariables.clientSide.read(((WorldVariables) message.data).save(new CompoundTag(), context.player().registryAccess()), context.player().registryAccess());
				});
			}
		}
	}
	</#if>

	<#if w.hasVariablesOfScope("PLAYER_LIFETIME") || w.hasVariablesOfScope("PLAYER_PERSISTENT")>
	<#assign playerVars = []>
    <#list variables as var>
    	<#if var.getScope().name() == "PLAYER_LIFETIME" || var.getScope().name() == "PLAYER_PERSISTENT">
    		<#assign playerVars = playerVars + [var]>
    	</#if>
    </#list>
	public static class PlayerVariables {
		public static final Codec<PlayerVariables> CODEC = RecordCodecBuilder.create(builder -> builder.group(
		<#list playerVars as var>
			<#if var.getScope().name() == "PLAYER_LIFETIME">
				<@var.getType().getScopeDefinition(generator.getWorkspace(), "PLAYER_LIFETIME")['codec']?interpret/>
			<#elseif var.getScope().name() == "PLAYER_PERSISTENT">
				<@var.getType().getScopeDefinition(generator.getWorkspace(), "PLAYER_PERSISTENT")['codec']?interpret/>
			</#if><#sep>,
		</#list>
		).apply(builder, PlayerVariables::new));

		boolean _syncDirty = false;

		<#list variables as var>
			<#if var.getScope().name() == "PLAYER_LIFETIME">
				<@var.getType().getScopeDefinition(generator.getWorkspace(), "PLAYER_LIFETIME")['init']?interpret/>
			<#elseif var.getScope().name() == "PLAYER_PERSISTENT">
				<@var.getType().getScopeDefinition(generator.getWorkspace(), "PLAYER_PERSISTENT")['init']?interpret/>
			</#if>
		</#list>

		public PlayerVariables() {
		}

		public PlayerVariables(<#list playerVars as var>${var.getType().getJavaType(generator.getWorkspace())} ${var.getName()}<#sep>, </#list>) {
		    <#list playerVars as var>
                this.${var.getName()} = ${var.getName()};
            </#list>
		}

		public void serialize(ValueOutput output) {
			<#list variables as var>
				<#if var.getScope().name() == "PLAYER_LIFETIME">
					<@var.getType().getScopeDefinition(generator.getWorkspace(), "PLAYER_LIFETIME")['write']?interpret/>
				<#elseif var.getScope().name() == "PLAYER_PERSISTENT">
					<@var.getType().getScopeDefinition(generator.getWorkspace(), "PLAYER_PERSISTENT")['write']?interpret/>
				</#if>
			</#list>
		}

		public void deserialize(ValueInput input) {
			<#list variables as var>
				<#if var.getScope().name() == "PLAYER_LIFETIME">
					<@var.getType().getScopeDefinition(generator.getWorkspace(), "PLAYER_LIFETIME")['read']?interpret/>
				<#elseif var.getScope().name() == "PLAYER_PERSISTENT">
					<@var.getType().getScopeDefinition(generator.getWorkspace(), "PLAYER_PERSISTENT")['read']?interpret/>
				</#if>
			</#list>
		}

		public void markSyncDirty() {
			_syncDirty = true;
		}
	}

	public record PlayerVariablesSyncMessage(PlayerVariables data) implements CustomPacketPayload {

		public static final Type<PlayerVariablesSyncMessage> TYPE = new Type<>(ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, "player_variables_sync"));

		public static final StreamCodec<RegistryFriendlyByteBuf, PlayerVariablesSyncMessage> STREAM_CODEC = StreamCodec.of(
				(RegistryFriendlyByteBuf buffer, PlayerVariablesSyncMessage message) -> {
					TagValueOutput output = TagValueOutput.createWithoutContext(ProblemReporter.DISCARDING);
					message.data.serialize(output);
					buffer.writeNbt(output.buildResult());
				},
				(RegistryFriendlyByteBuf buffer) -> {
					PlayerVariablesSyncMessage message = new PlayerVariablesSyncMessage(new PlayerVariables());
					message.data.deserialize(TagValueInput.create(ProblemReporter.DISCARDING, buffer.registryAccess(), buffer.readNbt()));
					return message;
				}
		);

		@Override public Type<PlayerVariablesSyncMessage> type() {
			return TYPE;
		}

		public static void handleData(final PlayerVariablesSyncMessage message, final ClientPlayNetworking.Context context) {
			if (message.data != null) {
				context.client().execute(() -> {
					<#-- If we use setAttached here, we may get unwanted references to old data instance -->
					TagValueOutput output = TagValueOutput.createWithContext(ProblemReporter.DISCARDING, context.player().registryAccess());
					message.data.serialize(output);
					context.player().getAttachedOrCreate(PLAYER_VARIABLES).deserialize(TagValueInput.create(ProblemReporter.DISCARDING, context.player().registryAccess(), output.buildResult()));
				});
			}
		}
	}
	</#if>
}
<#-- @formatter:on -->