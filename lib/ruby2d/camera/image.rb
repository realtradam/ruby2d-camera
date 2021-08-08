# frozen_string_literal: true

module Camera
  # Wraps existing variables as well as adding new methods
  # so that it can be handled by the Camera Module
  class Image < Ruby2D::Image
    # Recalculates real coordiantes
    # Use after changing variables
    def _draw
      return if @hide
      temp_angle = Camera.angle * (Math::PI / 180)
      half_width = Window.width * 0.5
      half_height = Window.height * 0.5
      offset_x = @x + (@width / 2)
      offset_y = @y + (@height / 2)
      temp_x = (((offset_x - Camera.x) * Math.cos(temp_angle)) - ((offset_y - Camera.y) * Math.sin(temp_angle))) \
        * Camera.zoom + half_width - (width * Camera.zoom / 2)
      temp_y = (((offset_x - Camera.x) * Math.sin(temp_angle)) + ((offset_y - Camera.y) * Math.cos(temp_angle))) \
        * Camera.zoom + half_height - (height * Camera.zoom / 2)
      temp_rotate = self.rotate + Camera.angle
      temp_width = self.width * Camera.zoom
      temp_height = self.height * Camera.zoom
      self.draw(x: temp_x, y: temp_y,
                width: temp_width,
                height: temp_height,
                rotate: temp_rotate,
                color: [self.color.r, self.color.g, self.color.b, self.color.a])
    end

    def initialize(path, opts= {})
      super(path, opts)
      Ruby2D::Camera << self
      Window.remove(self)
    end
      def remove
        @hide = true
      end

      def add
        @hide = false
      end
  end
end
