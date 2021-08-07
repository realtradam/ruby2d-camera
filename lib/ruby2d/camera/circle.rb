# frozen_string_literal: true

module Ruby2D
  module Camera
    # Wraps existing variables as well as adding new methods
    # so that it can be handled by the Camera Module
    class Circle < Ruby2D::Circle
      # Recalculates real coordiantes
      # Use after changing variables
      def _draw
        angle = Camera.angle * (Math::PI / 180)
        half_width = Window.width * 0.5
        half_height = Window.height * 0.5
        temp_radius = @radius * Camera.zoom
        temp_x = (((@x - Ruby2D::Camera.x + radius) * Math.cos(angle)) - ((@y - Ruby2D::Camera.y + radius) * Math.sin(angle))) * Ruby2D::Camera.zoom + half_width
        temp_y = (((@x - Ruby2D::Camera.x + radius) * Math.sin(angle)) + ((@y - Ruby2D::Camera.y + radius) * Math.cos(angle))) * Ruby2D::Camera.zoom + half_height
        Ruby2D::Circle.draw(x: temp_x, y: tempy,
                            radius: temp_radius,
                            sectors: @sectors,
                            color: [self.color.r, self.color.g, self.color.b, self.color.a])

      end

      def initialize(otps= {})
        super(opts)
        Ruby2D::Camera << self
        self.remove
      end
    end
  end
end