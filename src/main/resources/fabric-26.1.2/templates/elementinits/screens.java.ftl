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

/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

import java.text.DecimalFormat;

@Environment(EnvType.CLIENT) public class ${JavaModName}Screens {

	public static void clientLoad() {
		<#list guis as gui>
			MenuScreens.register(${JavaModName}Menus.${gui.getModElement().getRegistryNameUpper()}, ${gui.getModElement().getName()}Screen::new);
		</#list>
	}

	public interface FabricScreenAccessor {
		void updateMenuState(int elementType, String name, Object elementState);
	}

	public static class ExtendedSlider extends AbstractSliderButton {
		protected Component prefix;
		protected Component suffix;

		protected double minValue;
		protected double maxValue;

		protected double stepSize;

		protected boolean drawString;

		private final DecimalFormat format;

		public ExtendedSlider(int x, int y, int width, int height, Component prefix, Component suffix, double minValue, double maxValue, double currentValue, double stepSize, int precision, boolean drawString) {
			super(x, y, width, height, Component.empty(), 0D);
			this.prefix = prefix;
			this.suffix = suffix;
			this.minValue = minValue;
			this.maxValue = maxValue;
			this.stepSize = Math.abs(stepSize);
			this.value = this.snapToNearest((currentValue - minValue) / (maxValue - minValue));
			this.drawString = drawString;

			if (stepSize == 0D) {
				precision = Math.min(precision, 4);

				StringBuilder builder = new StringBuilder("0");

				if (precision > 0)
					builder.append('.');

				while (precision-- > 0)
					builder.append('0');

				this.format = new DecimalFormat(builder.toString());
			} else if (Mth.equal(this.stepSize, Math.floor(this.stepSize))) {
				this.format = new DecimalFormat("0");
			} else {
				this.format = new DecimalFormat(Double.toString(this.stepSize).replaceAll("\\d", "0"));
			}

			this.updateMessage();
		}

		public ExtendedSlider(int x, int y, int width, int height, Component prefix, Component suffix, double minValue, double maxValue, double currentValue, boolean drawString) {
			this(x, y, width, height, prefix, suffix, minValue, maxValue, currentValue, 1D, 0, drawString);
		}

		public double getValue() {
			return this.value * (maxValue - minValue) + minValue;
		}

		public long getValueLong() {
			return Math.round(this.getValue());
		}

		public int getValueInt() {
			return (int) this.getValueLong();
		}

		public void setValue(double value) {
			setFractionalValue((value - this.minValue) / (this.maxValue - this.minValue));
		}

		public String getValueString() {
			return this.format.format(this.getValue());
		}

		@Override
		public void onClick(MouseButtonEvent event, boolean doubleClick) {
			this.setValueFromMouse(event.x());
		}

		@Override
		protected void onDrag(MouseButtonEvent event, double dx, double dy) {
			super.onDrag(event, dx, dy);
			this.setValueFromMouse(event.x());
		}

		@Override
		public boolean keyPressed(KeyEvent event) {
			int keyCode = event.key();
			boolean flag = keyCode == GLFW.GLFW_KEY_LEFT;
			if (flag || keyCode == GLFW.GLFW_KEY_RIGHT) {
				if (this.minValue > this.maxValue)
					flag = !flag;
				float f = flag ? -1F : 1F;
				if (stepSize <= 0D)
					this.setFractionalValue(this.value + (f / (this.width - 8)));
				else
					this.setValue(this.getValue() + f * this.stepSize);
			}

			return false;
		}

		private void setValueFromMouse(double mouseX) {
			this.setFractionalValue((mouseX - (this.getX() + 4)) / (this.width - 8));
		}

		private void setFractionalValue(double fractionalValue) {
			double oldValue = this.value;
			this.value = this.snapToNearest(fractionalValue);
			if (!Mth.equal(oldValue, this.value))
				this.applyValue();

			this.updateMessage();
		}

		private double snapToNearest(double value) {
			if (stepSize <= 0D)
				return Mth.clamp(value, 0D, 1D);

			value = Mth.lerp(Mth.clamp(value, 0D, 1D), this.minValue, this.maxValue);

			value = (stepSize * Math.round(value / stepSize));

			if (this.minValue > this.maxValue) {
				value = Mth.clamp(value, this.maxValue, this.minValue);
			} else {
				value = Mth.clamp(value, this.minValue, this.maxValue);
			}

			return Mth.map(value, this.minValue, this.maxValue, 0D, 1D);
		}

		@Override
		protected void updateMessage() {
			if (this.drawString) {
				this.setMessage(Component.literal("").append(prefix).append(this.getValueString()).append(suffix));
			} else {
				this.setMessage(Component.empty());
			}
		}

		@Override
		protected void applyValue() {}

		@Override
		public void extractWidgetRenderState(GuiGraphicsExtractor guiGraphics, int mouseX, int mouseY, float partialTick) {
			guiGraphics.blitSprite(RenderPipelines.GUI_TEXTURED, this.getSprite(), this.getX(), this.getY(), this.getWidth(), this.getHeight(), ARGB.white(this.alpha));
			guiGraphics.blitSprite(RenderPipelines.GUI_TEXTURED, this.getHandleSprite(), this.getX() + (int) (this.value * (double) (this.width - 8)), this.getY(), 8, this.getHeight(), ARGB.white(this.alpha));
			int i = this.active ? 16777215 : 10526880;
			var message = getMessage().copy().withStyle(style -> style.withColor(i)); // TODO 1.21.11: Inefficient, check how Vanilla does this
			this.extractScrollingStringOverContents(guiGraphics.textRendererForWidget(this, GuiGraphicsExtractor.HoveredTextEffects.NONE), message, 2);
	
			if (this.isHovered())
				guiGraphics.requestCursor(this.dragging ? CursorTypes.RESIZE_EW : CursorTypes.POINTING_HAND);
		}
	}
}
<#-- @formatter:on -->
