# frozen_string_literal: true

module Camera
  # Wraps existing variables as well as adding new methods
  # so that it can be handled by the Camera Module
  class Image < Ruby2D::Image
    # Recalculates real coordiantes
    # Use after changing variables
    def _draw
      angle = Camera.angle * (Math::PI / 180)
      half_width = Window.width * 0.5
      half_height = Window.height * 0.5
      offset_x = x + (width / 2)
      offset_y = y + (height / 2)
      temp_x = (((offset_x - Camera.x) * Math.cos(angle)) - ((offset_y - Camera.y) * Math.sin(angle))) \
        * Camera.zoom + half_width - (width * Camera.zoom / 2)
      temp_y = (((offset_x - Camera.x) * Math.sin(angle)) + ((offset_y - Camera.y) * Math.cos(angle))) \
        * Camera.zoom + half_height - (height * Camera.zoom / 2)
      temp_rotate = rotate + Camera.angle
      temp_width = width * Camera.zoom
      temp_height = height * Camera.zoom
      self.draw(x: temp_x, y: temp_y,
                width: temp_width,
                height: temp_height,
                rotate: temp_rotate,
                color: [self.color.r, self.color.g, self.color.b, self.color.a])
    end
  end
end
