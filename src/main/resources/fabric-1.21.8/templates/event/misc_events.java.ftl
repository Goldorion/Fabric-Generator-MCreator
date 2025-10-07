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
package ${package}.event;

public class MiscEvents {

	public static final Event<CommandExecute> COMMAND_EXECUTE = EventFactory.createArrayBacked(CommandExecute.class, (callbacks) -> (results) -> {
		for (CommandExecute event : callbacks) {
			boolean result = event.onCommandExecuted(results);
			if (!result) {
				return false;
			}
		}
		return true;
	});

	@FunctionalInterface
	public interface CommandExecute {
		boolean onCommandExecuted(ParseResults<CommandSourceStack> results);
	}
}
<#-- @formatter:on -->