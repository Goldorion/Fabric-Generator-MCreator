<#--
This file is part of MCreatorFabricGenerator.

MCreatorFabricGenerator is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

MCreatorFabricGenerator is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with MCreatorFabricGenerator.  If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->

package ${package};

/*
 * This mod element is always locked. Enter your code below.
 * Do not remove any of the following methods. Doing so will cause
 * compilation to fail.
 *
 * The easiest way to do something here is by making an inner class
 * and registering it in one of the following methods. If you
 * want to make a plain independent class, create it using
 * Project Browser - New... and make sure to create the class
 * outside the ${package} package as it is managed by MCreator.
 *
 * If you change workspace package, modid or prefix, you will need
 * to manually adapt this file to these changes or remake it.
*/
public class ${name}CustomCode {

	/*
	 * This method will run at mod initialization on both the client and server
	 */
	public static void initialize() {

	}

	/*
	 * This method will run at mod initialization only on the client
	 */
	public static void initializeClient() {

	}

	/*
	 * This method will run at mod initialization only on the dedicated server
	 */
	public void initializeServer() {

	}

}
<#-- @formatter:on -->